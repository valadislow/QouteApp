//
//  ViewController.swift
//  KenyeQuote
//
//  Created by 1 on 7/1/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var label: UILabel!
    @IBAction func randomQouta(_ sender: Any) {
        
        let url = URL(string: "https://api.kanye.rest")!
        
        let task = URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error {
                print("Error", error)
                return
            }
            
            guard let hhtpResponse = response as? HTTPURLResponse else {
                print("not the right response")
                return
            }
            
            guard(200...299).contains(hhtpResponse.statusCode) else{
                print("Error")
                return
            }
            
            guard let data = data else {
                print("bad data")
                return
            }
            do{
                let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: String]
                
                DispatchQueue.main.async {
                    self.label.text = json["quote"]
                }
            } catch let error {
                print("Error", error)
            }
            
        }
        task.resume()
        
    }
    

}
