Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261474AbTCOPcN>; Sat, 15 Mar 2003 10:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261471AbTCOPcN>; Sat, 15 Mar 2003 10:32:13 -0500
Received: from 66-23-198-2.clients.speedfactory.net ([66.23.198.2]:45202 "EHLO
	hp.outpostsentinel.com") by vger.kernel.org with ESMTP
	id <S261469AbTCOPcK>; Sat, 15 Mar 2003 10:32:10 -0500
Subject: RE: RS485 communication
From: Chris Fowler <cfowler@outpostsentinel.com>
To: Robert White <rwhite@casabyte.com>
Cc: Ed Vance <EdV@macrolink.com>, "'Linux PPP'" <linuxppp@indiainfo.com>,
       linux-serial@vger.kernel.org,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
In-Reply-To: <PEEPIDHAKMCGHDBJLHKGCEGACDAA.rwhite@casabyte.com>
References: <PEEPIDHAKMCGHDBJLHKGCEGACDAA.rwhite@casabyte.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 15 Mar 2003 10:42:53 -0500
Message-Id: <1047742974.2852.10.camel@hp.outpostsentinel.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think using SOCK_PACKET an an ethernet chip may be the best choice. 
You can use IP or you can use RWP (Rober White Protocol).


On Sat, 2003-03-15 at 03:07, Robert White wrote:
> Yes, that, but that is only part of it.
> 
> The RS485 is a proper bus, so this custom program (or programs) will have to
> act as full bus arbiters and a kind of router.  Each PPP daemon must receive
> ONLY the data that its peer daemon transmits.  That means that each slave
> must know to ignore the data not destined for it.  Further, the master,
> which would have multiple PPP instances running on it, will need to decide
> which of those instances get which of the receiving bytes.
> 
> So just like an Ethernet transceiver puts a protocol frame around the data
> to get it to the destination, the transport program will have to put
> envelopes around the data.  THEN the master transport program will tell each
> slave when and how many of its envelopes it may send.  The only way that can
> work (because there is no "ring" you can't pass a "token") is for the master
> to ask each slave in turn: "Got anything to send?"
> 
> This usually devolves to a sequence of "#1, say your piece", "#2 say your
> piece" etc.  That is a very bad performance model.
> 
> So every frame of data will need to be arbitrarily wide, meaning a length
> code, and will need an in-multiplexor address.
> 
> So the master, for instance, will say "slave 1, go".  The slave 1 will send
> a packet (not necessarily a PPP packet, as the multiplexor will have
> overhead data etc.)
> 
> The master will look at the address and decide which local pty the data is
> for and send it there.  (Think a simple byte pump here)
> 
> When that pty has response data, and when the master says "slave 0 (e.g. me)
> go" it will frame a message that slave #1 will receive and put through to
> its local pty.  Slave 1 also has the job of ignoring data for slaves 2
> through N and the Master (Slave 0).
> 
> In short, he has to write a distributed application that pumps data into and
> out of a broadcast medium, and makes sure that each participant gets only
> the data intended for itself.  (This is what both the Ethernet hardware
> layer, and the IP protocols do.)
> 
> In communications you almost always put protocols inside of protocols to
> some significant depth.
> 
> For instance, when you play Unreal Tournament 2003:
> Unreal Tournament's data is carried by UDP,
> The UDP is carried by IP,
> The IP is carried by the Ethernet hardware access layer (raw Ethernet),
> Those packets may go to your cable modem which either wraps the Ethernet
> hardware packets or decodes them and reencodes the IP  into whatever it
> does.
> 
> >From there, if your cable modem is doing PPPoE there are even more layers.
> 
> This guy will only have to write a multiplexing layer, but it won't be fun.
> 
> Then again, the Ethernet people have done all that, which is why it is
> cheaper and easier to just get the Ethernet hardware and use it.
> 
> Rob.
> 
> -----Original Message-----
> From: Chris Fowler [mailto:cfowler@outpostsentinel.com]
> Sent: Thursday, March 13, 2003 3:31 PM
> To: Robert White
> Cc: Ed Vance; 'Linux PPP'; linux-serial@vger.kernel.org; 'linux-kernel'
> Subject: RE: RS485 communication
> 
> 
> Are you saying that for him to to use PPPD that he will have to write a
> program that will run on a master and tell all the slave nodes when they
> can transmit their data.  In this case it would be ppp data.  Hopfully
> in block sizes that are at least the size of the MTU ppp is running.
> 
> Chris
> 


