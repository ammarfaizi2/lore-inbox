Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290149AbSAKW4K>; Fri, 11 Jan 2002 17:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290152AbSAKW4B>; Fri, 11 Jan 2002 17:56:01 -0500
Received: from svr3.applink.net ([206.50.88.3]:64529 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S290149AbSAKWzq>;
	Fri, 11 Jan 2002 17:55:46 -0500
Message-Id: <200201112255.g0BMtFSr004753@svr3.applink.net>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: timothy.covell@ashavan.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: strange kernel message when hacking the NIC driver
Date: Fri, 11 Jan 2002 16:51:27 -0600
X-Mailer: KMail [version 1.3.2]
Cc: zhengpei@msu.edu (Pei Zheng), linux-kernel@vger.kernel.org
In-Reply-To: <E16P1Sb-0007b9-00@the-village.bc.nu> <200201111906.g0BJ6kSr003243@svr3.applink.net>
In-Reply-To: <200201111906.g0BJ6kSr003243@svr3.applink.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 January 2002 13:02, Timothy Covell wrote:
> On Friday 11 January 2002 07:11, Alan Cox wrote:
> > > Let me clarify what I said earlier.  You cannot have
> > > identical MAC addresses on two different NICs.   Indeed,
> > > it is impossible w/o trying to fool the kernel into
> > > redefining the NICs hardware based MAC address.
> >
> > Wrong
> >
> > A mac address is per system. Now in fact almost all systems do it per
> > ethernet card but that is not what the specifications guarantee. There
> > are machines out there and cards out there which use the same MAC on all
> > interfaces. -
>
> IMHO, they _should_ be unique except for multicast addressing and uses
> such as in HSRP/VRRP and such.   Network admins usually like to have
> a firm grip concerning how traffic is routed.  They don't want traffic on
> one segment/subnet getting routed to another.  IHMO, this is a vector
> for viruses proliferation because the host vulnerable thinks that all
> segments/subnets are the same.
>
>

OK, here are some snippets which I found from reading the IEEE 802.x
standards.   As far as I can see, the only justification for your and Sun's
(OpenBootProm) method is to assume that all ports will be aggregated.

IEEE 802:
---------
However, due to the shared-medium nature of the IEEE 802 LANs, there is 
always a MAC Sublayer.


IEEE 802:
---------

5.1 Organizationally Unique Identifier 
5.1.1 Concept. 

Organizationally Unique Identifiers allow a general means of assuring unique 
identifiers for a 
number of purposes. Currently, the IEEE assigns Organizationally Unique 
Identifiers to be used 
for generating LAN MAC addresses and protocol identifiers. Assuming correct 
administration by 
the assignee, the LAN MAC addresses and protocol identifiers will be 
universally unique.



IEEE 802.1D
-----------

a) A Bridge is not directly addressed by communicating end stations, except 
as an end station for
management purposes: frames transmitted between end stations carry the MAC 
Address of the peer-end
station in their Destination Address field, not the MAC Address, if any, of 
the Bridge. 

b) All MAC Addresses must be unique within the Bridged LAN. 

c) The MAC Addresses of end stations are not restricted by the topology and 
configuration of the Bridged LAN.


IEEE 802.1G 
-------------

Preservation of the MAC service The MAC service offered by a remotely bridged 
LAN is 
similar (see 5.3) to that offered by a single LAN. In consequence 

a) A bridge is not directly addressed by communicating end stations, except
as an end station for management purposes: frames transmitted between end 
stations carry the MAC address of the peer end station in their Destination 
Address fields, 
not the MAC address, if any, of a bridge. 

b) All MAC addresses are unique and addressable within the bridged LAN. 

c) The MAC addresses of end stations are not restricted by the topology and 
configuration of the bridged LAN.


IEEE 802.1Q
----------------
B.1.2 Duplicate MAC Addresses 

The simplest example of a need for Independent VLAN Learning occurs where
two (or more) distinct devices in different parts of the network reuse 
the same individual MAC Address, or where a single device is connected to 
multiple LAN segments, and all of its LAN interfaces use the same individual 
MAC Address. This is shown in Figure B-3.


[picture ommitted for obvious reasons]

The example shows two clients with access to the same server; both clients 
are using the same individual MAC Address, X. If the Bridge shares learning 
between VLAN Red (which serves Client A) and VLAN Blue (which serves Client 
B), 
i.e., the Bridge uses the same FID for both VLANs, then Address X will appear 
to 
move between Ports 1 and 2 of the Bridge, depending upon which client has 
most recently 
trans-mitted a frame. Communication between these Clients and the server will 
therefore 
be seriously disrupted. Assignment of distinct FIDs for Red and Blue ensures 
that 
communication can take place correctly.




IEEE 802.3
----------  
The only thing which I could find that supported you and Sun's
position is in using LACP.  Then, one uses the SystemID 
(the hostid from eeprom, or one of the port's MAC).  So, if you are
assuming that all ports should belong to an aggregate group by
default, then I could understand this point.  However, the vast
majority of system's NICs (aside from the QFE cards) are never
aggregated.  So, it's a bit of a stretch to using LACP as a default.

Quotations:


i)Each port is assigned a unique,globally administered MAC address.This MAC 
address 
is used as the source address for frame exchanges that are initiated by 
entities within 
the Link Aggregation sublayer itself (i.e.,LACP and Marker protocol 
exchanges). NOTE  
The LACP and Marker protocols use a multicast destination address for all 
exchanges,
and do not impose any requirement for a port to recognize more than one 
unicast address 
on received frames. 

j)Each Aggregator is assigned a unique,globally administered MAC address;this 
address is 
used as the MAC address of the aggregation from the perspective of the MAC 
Client, both as 
a source address for transmitted frames and as the destination address for 
received frames.
The MAC address of the Aggregator may be one of the MAC addresses of a port 
in the associated 
Link Aggregation Group (see 43.2.10).



43.2.8 Aggregator An Aggregator comprises an instance of a Frame Collection 
function,
an instance of a Frame Distribution function and one or more instances of the 
Aggregator 
Parser/Multiplexer function for a Link Aggregation Group.A single Aggregator 
is associated 
with each Link Aggregation Group.  An Aggregator offers a standard IEEE 802.3 
MAC service 
interface to its associated MAC Client;access to the MAC service by a MAC 
Client is always 
achieved via an Aggregator. An Aggregator can therefore be considered to be a 
logical MAC ,
bound to one or more ports,through which the MAC client is provided access to 
the MAC service. 
A single,individual MAC address is associated with each Aggregator (see 
43.2.10). An Aggregator is 
available for use by the MAC Client if the following are all true: 

a)It has one or more attached ports. 
b)The Aggregator has not been set to a disabled state by administrative 
action (see 30.7.1.1.13).
c)The collection and/or distribution function associated with one or more of 
the attached ports is 
enabled (see 30.7.1.1.14). 

NOTE  To simplify the modeling and description of the operation of Link 
Aggregation,it is assumed that 
there are as many Aggregators as there are ports in a given System; however, 
this is not a requirement 
of this standard.Aggregation of two or more ports consists of changing the 
bindings between ports and 
Aggregators such that more than one port is bound to a single Aggregator.The 
creation of any aggregations 
of two or more links will therefore result in one or more Aggregators that 
are bound to more than one port,
and one or more Aggregators that are not bound to any port.An Aggregator that 
is not bound to any port appears 
to a MAC Client as a MAC interface to an inactive port.During times when the 
bindings between ports and Aggregators a
re changing,or as a consequence of particular con  guration choices, there 
may be occasions when one or more ports 
are not bound to any Aggregator.

43.2.10 Addressing Each IEEE 802.3 MAC has an associated globally-unique 
individual MAC address,whether that MAC 
is used for Link Aggregation or not (see Clause 4). Each Aggregator to which 
one or more ports are attached has 
an associated globally-unique individual MAC address (see 43.3.3).The MAC 
address of the Aggregator may be the 
globally-unique individual MAC addresses of one of the MACs in the associated 
Link Aggregation Group,or it may 
be a distinct MAC address.The manner in which such addresses are chosen is 
not otherwise constrained by this standard. 
Protocol entities sourcing frames from within the Link Aggregation sublayer 
(e.g.,LACP and the Marker protocol)use the 
MAC address of the MAC within an underlying port as the source address in 
frames transmitted through that port.The MAC 
Client sees only the Aggregator and not the underlying MACs,and therefore 
uses the Aggregator  s MAC address as the source 
address in transmitted frames.If a MAC Client submits a frame to the 
Aggregator for transmission without specifying a 
source address,the Aggregator inserts its own MAC address as the source 
address for transmitted frames.



RFC 826:
--------

However, 48.bit Ethernet addresses are supposed to be unique and fixed for 
all time, so they shouldn't
change.


>From the Ethernet FAQ:
----------------------

02.10Q: What is a MAC address?
A: It is  the unique hexadecimal serial number assigned to each Ether-
net  network device to identify it  on  the network.  With Ethernet
devices  (as  with  most other  network  types),  this  address  is
permanently set at  the time of manufacturer, though it can usually
be changed  through  software (though this is  generally a Very
Bad Thing to do). 

02.11Q: Why must the MAC address to be unique?  

A: Each card  has  a  unique MAC address,  so  that
it will be able to exclusively  grab  packets  off the wire
meant  for  it.   If  MAC addresses are not unique,  there is 
no  way  to distinguish between two  stations.  Devices on the 
network  watch  network traffic and look for their own MAC address 
in each packet to determine whether they should decode  it or  not.
Special circumstances exist  for broadcasting to every device.

04.01Q: What is a "segment"?
A: A  piece of network wire bounded by bridges,  routers, repeaters or
terminators. 

04.02Q: What is a "subnet"?
A: Another overloaded  term. It can  mean, depending on  the usage,  a
segment, a set of machines  grouped together by a specific protocol
feature  (note  that  these machines do not have to be on  the same
segment, but they could be) or a big  nylon  thing used  to capture 
enemy subs.


-- 
timothy.covell@ashavan.org.
