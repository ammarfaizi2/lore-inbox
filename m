Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbVLHHCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbVLHHCR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 02:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbVLHHCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 02:02:17 -0500
Received: from main.gmane.org ([80.91.229.2]:15572 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751192AbVLHHCR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 02:02:17 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: previa.bbs@bbs.csie.ncue.edu.tw (Southern Cross)
Subject: HTTPMU/UDP 
Date: 08 Dec 2005 06:49:43 GMT
Organization: Legend
Message-ID: <A11PFLS7$P_Previa@bbs.csie.ncue.edu.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: bbs.ncue.edu.tw
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

UPnP
UPnP

http://jan.netcomp.monash.edu.au/internetdevices/upnp/upnp.html
UPnP stack


HTTPMU

On UDP, you send datagrams: self-contained messages
Multicast UDP sends datagrams to a "group"
For HTTPMU, the contents of the datagram are HTTP requests
There is no response to these multicast requests since the message may be received by any number of clients, and this is not a request-response situation
So a request like GET http://localhost/index.html cannot be interpreted as a request for a document
HTTPMU is expected to use the syntax of HTTP while changing the semantics
HTTPMU allows the possibility of new request types such as NOTIFY as well as the standard HTTP requests of GET, POST, HEAD, etc
HTTPMU was invented to support UPnP
HTTPMU is not a W3C standard
HTTPMU is an expired IETF draft

HTTPU

HTTPU sends a single datagram over UDP to a host
The recipient may send a reply back to the host and port that sent the datagram
Again, it is not expected that standard HTTP requests be sent, only that the syntax is obeyed
HTTPU was invented for UPnP, etc

Simple Service Discovery Protocol (SSDP)

SSDP is used over HTTPMU and HTTPU tp provide basic information about services
It can be used by devices starting up to notify others about their presence
It can be used by clients trying to find a service by asking to search for a service
Announcements/requests are made by multicast over HTTPMU
Replies (if any) are made over HTTPU

SSDP notify

An SSDP notify is multicast by HTTPMU when a device wants to advertise itself, usually at startup
The notify message includes a statement about the device type such as schemas-upnp-org:device:BinaryLight:0.9 and an HTTP url for an XML description of the device
Each device has a UUID (universally unique id) so that it can be identified even if it's IP address changes or it leaves and revisits the network
There is no response to a notify
A typical notify might be
NOTIFY * HTTP/1.1
HOST: 239.255.255.250:1900
CACHE-CONTROL: max-age = seconds until advertisement expires
LOCATION: URL for UPnP description for root device
NT: search target
NTS: ssdp:alive
SERVER: OS/version UPnP/1.0 product/version
USN: advertisement UUID
A notify is also sent at graceful shutdown. The messages are distinguished by the field NTS which is set to ssdp:alive or ssdp:byebye

SSDP search

A search is made using HTTPMU when a client needs to find a device and has maybe missed any adverts
Search is on services not devices (but I am not sure...)
The search is trivially simple: does the service match the service type string or not? If yes then reply by HHTPU, if not then ignore it
The response should include a pointer to an XML service description, so more complex searches could be performed using the XML documents
An example search might be
  M-SEARCH * HTTP/1.1
   S: uuid:ijklmnop-7dec-11d0-a765-00a0c91e6bf6
   Host: 239.255.255.250:reservedSSDPport
   Man: "ssdp:discover"
   ST: ge:fridge
   MX: 3
Device description
A device is described by an XML description file

<?xml version="1.0"?>
<root xmlns="urn:schemas-upnp-org:device-1-0">
  <specVersion>
    <major>1</major>
    <minor>0</minor>
  </specVersion>
  <URLBase>base URL for all relative URLs</URLBase>
  <device>
    <deviceType>urn:schemas-upnp-org:device:deviceType:v</deviceType>
    <friendlyName>short user-friendly title</friendlyName>
    <manufacturer>manufacturer name</manufacturer>
    <manufacturerURL>URL to manufacturer site</manufacturerURL>
    <modelDescription>long user-friendly title</modelDescription>
    <modelName>model name</modelName>
         <modelNumber>model number</modelNumber>
    <modelURL>URL to model site</modelURL>
    <serialNumber>manufacturer's serial number</serialNumber>
    <UDN>uuid:UUID</UDN>
    <UPC>Universal Product Code</UPC>
    <iconList>
      <icon>
        <mimetype>image/format</mimetype>
        <width>horizontal pixels</width>
        <height>vertical pixels</height>
        <depth>color depth</depth>
        <url>URL to icon</url>
    </icon>
    <!-- XML to declare other icons, if any, go here -->
    </iconList>
    <serviceList>
      <service>
        <serviceType>urn:schemas-upnp-org:service:serviceType:v</serviceType>
        <serviceId>urn:upnp-org:serviceId:serviceID</serviceId>
        <SCPDURL>URL to service description</SCPDURL>
        <controlURL>URL for control</controlURL>
        <eventSubURL>URL URL for eventing</eventSubURL>
      </service>
      <!-- Declarations for other services defined by a UPnP Forum working
           committee (if any) go here -->
      <!-- Declarations for other services added by UPnP vendor (if any) go here -->
    </serviceList>
    <deviceList>
      <!-- Description of embedded devices defined by a UPnP Forum working
           committee (if any) go here -->
      <!-- Description of embedded devices added by UPnP vendor (if any) go here -->
    </deviceList>
    <presentationURL>URL for presentation</presentationURL>
  </device>
</root>

Comments

There are many references to url's in this
manufacturer
this will be to home page of the manufacturer
icon
this could be to any icon anywhere
service description
this could be a url anywhere
control
this is the url to send SOAP messages to. It must be a url on the device. This is to allow client applications to make RPC calls to the device
eventing
this is the url to register yourself for device events. It must be a url on the device
presentation
this is an HTML form to control the device, so must be a url on the device. This to allow human interaction with the device
The device must be running an HTTP server
It must be able to understand SOAP messages, so needs an XML parser
It should be able to undersand form requests
The device may run many services, so the description includes a list of services
Service types are standardised by the UPnP consortium. These are (April 2004)
Basic Device
Internet Gateway Device
MediaServer and MediaRenderer
Printer Device and Print Basic Service
Scanner (External Activity, Feeder, Scan, Scanner)
HVAC
WLAN Access Point Device
Device Security and Security Console
Lighting Controls
A vendor will specialise within one of these types

UPnP and J2ME

There is heavy use of multicast. While J2ME supports UDP datagrams, it does not support multicast
UPnP requires use of web services. There is now an optional extension for the J2ME to support web services. This uses a restricted XMl parser
There are several Java implementations of UPnP. CyberLink is an open source version. Unknown if it runs on J2ME
There are no open forums attempting to add UPnP to J2ME, but some of the commercial implementations which claim to run under J2ME

Events

Events are handled by a mechanism called GETA
A service that wants to send an event does so by either HTTP or HTTPU to registered listeners
The service makes a NOTIFY request to the HTTP(U) servers running on the listeners. The listener has to decide what to do with each request - but it does not send an HTTP response
Like Java beans, every time a service changes state (by changing the value of a state variable) it generates an event
Listeners register for all state changes in a service

GUI

Usually, a service will be handled by a program running as a client making SOAP calls
A service may allow a user to control it directly
The UI for a service is an HTML page, typically an HTML Form
The user controls the service by filling in form parameters and submitting the form to the service
The service has to run CGI scripts/servlets/perl modules/etc to handle the form

UPnP life cycle - service

Multicast its existence using HTTPMU using a NOTIFY...alive message. The adverts contain
Device type (e.g. dimmable light device)
Each service type (e.g. on-off service)
URL for device and service descriptions
Runs an HTTP server to respond to device/service description requests (e.g. request for dimmable light description). Each service contains a URL for control
Respond to M-SEARCH requests from clients searching for devices/services. The responses are similar to the original adverts

Respond to control messages to an HTTP server handling SOAP requests by calling a service method. The service should complete the method call and respond within 30 seconds
Respond to event subscription, renewal or unsubscribe messages to an HTTP server by recording the URL of the subscribing party
When a state change occurs, sending NOTIFY messages to the HTTP server of each event subscriber
Respond to requests to an HTTP asking for an HTML page to control the device, and responding to requests made using this form (e.g. calling a servlet to call a method)
Advertises termination using HTTPMU using a NOTIFY...byebye message

UPnP life cycle - client

Make a search using HTTPMU when starting up or looking for a device/service
Receiving the response by HTTPU or HTTP
Listening for service adverts (hello/byebye) over HTTPMU
Invoking services by SOAP requests to an HTTP server
Getting a presentation page using HTTP
Subscribing to events by request to an HTTP server
Receiving event notifications on an the client's HTTP server

References

"Understanding Plug and Play", Microsoft, www.upnp.org
Digital Home Working Group
"Multicast and Unicast UDP HTTP Messages" IETF draft draft-goland-http-udp-00.txt (expires 1999)
"General Event Notification Architecture Base: Client to Arbiter" IETF draft draft-cohen-gena-client-00.txt (expires 1999)
"Simple Service Discovery Protocol/1.0" IETF draft draft-cai-ssdp-v1-00.txt (expires 1999)
"UPnP Device Architecture"


--------------------------------------------------------------------------------

Jan Newmarch (http://jan.netcomp.monash.edu.au)
jan.newmarch@infotech.monash.edu.au
Last modified: Tue May 4 22:14:46 EST 2004
Copyright Jan Newmarch

--
 [1;41m¡÷[44m¡õ[m O[1mri[30mgi[mn: [1;43m Alpha_Project£»ªüº¸µo´ú¸Õ­p¹º [47m bbs.csie.ncue.edu.tw [m
 [1;45m¡ô[42m¡ö[m Au[1mt[30mho[mr: [1;33mprevia[m ±q [1;34m218-170-136-64.dynamic.hinet.net[m µoªí

