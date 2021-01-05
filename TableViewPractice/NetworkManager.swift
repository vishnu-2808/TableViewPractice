//
//  NetworkManager.swift
//  TableViewPractice
//
//  Created by A Vishnu on 28/12/20.
//

import UIKit
import Foundation

class NetworkManager: NSObject {
    
    static var shared = NetworkManager()
    var URLRequestObj:URLRequest!
    var dataTask:URLSessionDataTask!
    var detailsData:NSArray!
    var storedData:[NSDictionary] = []
    var bodyArr:[String] = []
    var idArr:[Int] = []
    var postIdArr:[Int] = []
    var emailArr:[String] = []
    var nameArr:[String] = []
    
    private override init() {
        super.init()
        
        serverData()
     
        
    }
    func serverData()
    {
        URLRequestObj = URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/comments")!)
        
        URLRequestObj.httpMethod = "GET"
        
        dataTask = URLSession.shared.dataTask(with: URLRequestObj, completionHandler: { [self] (rData, connectionDetials, err) in
            print(rData)
            do{
            var dataFromServer = try JSONSerialization.jsonObject(with: rData!, options: JSONSerialization.ReadingOptions.allowFragments)
                
                detailsData = dataFromServer as! NSArray
              //  print("*****here\(detailsData.count)")
                
                for i in 0..<detailsData.count
                {
                    storedData.append(detailsData[i] as! NSDictionary)
                  //print("**hereid\(storedData[i].value(forKey: "id")!)")
                    
                    
                    idArr.append(storedData[i].value(forKey: "id") as! Int)
                    postIdArr.append(storedData[i].value(forKey: "postId") as! Int )
                    nameArr.append(storedData[i].value(forKey: "name") as! String)
                    bodyArr.append(storedData[i].value(forKey: "body") as! String)
                    emailArr.append(storedData[i].value(forKey: "email") as! String)
                  

                }
                
              
            }catch{
                print("something went wrong")
            }
        })
        dataTask.resume()
        
        print("email\(emailArr)")
    }
}
