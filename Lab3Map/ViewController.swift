//
//  ViewController.swift
//  Lab3Map
//
//  Created by Taina on 5/11/15.
//  Copyright (c) 2015 Taina. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var manager = CLLocationManager()
    
    @IBOutlet weak var Map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.manager.requestWhenInUseAuthorization()
        Map.showsUserLocation = true
    }
    
    //MARK: location manager
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!){
        var loc:CLLocationCoordinate2D = manager.location.coordinate
        
        println("locations = \(loc.latitude) \(loc.longitude)")
        
        let latitude:CLLocationDegrees = loc.latitude
        let longitude: CLLocationDegrees = loc.longitude
        
        //change for Zoom Level
        let latDelta: CLLocationDegrees = 0.5
        let longDelta: CLLocationDegrees = 0.5
        
        //update the map
        var span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        self.Map.setRegion(region, animated: true)
        
        //stop updating location for manual update
        self.manager.stopUpdatingLocation()
        
    }
    
    @IBAction func updateMap(sender: AnyObject) {
        
        if (CLLocationManager.locationServicesEnabled())
        {
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            manager.startUpdatingLocation()
        }
    }
    
}