Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267374AbSLEUaK>; Thu, 5 Dec 2002 15:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267375AbSLEUaK>; Thu, 5 Dec 2002 15:30:10 -0500
Received: from chaos.analogic.com ([204.178.40.224]:45191 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267374AbSLEUaG>; Thu, 5 Dec 2002 15:30:06 -0500
Date: Thu, 5 Dec 2002 15:37:38 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Tomas Szepe <szepe@pinerecords.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [OT] ipv4: how to choose src ip?
In-Reply-To: <20021205190054.GE23877@louise.pinerecords.com>
Message-ID: <Pine.LNX.3.95.1021205152058.18105A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Dec 2002, Tomas Szepe wrote:

> Hi,
> 
> I apologize for a vigorously off-topic post;  Google groups just ain't
> helping me this time.
> 
> Suppose I have two IP addresses from the same subnet on the same
> interface, and this interface also happens to be what my default
> gateway is on, like so:
> 
> /sbin/ifconfig eth1   213.168.178.209 netmask 255.255.255.192 \
> 					broadcast 213.168.178.255
> /sbin/ifconfig eth1:0 213.168.178.210 netmask 255.255.255.192 \
> 					broadcast 213.168.178.255
> /sbin/route add default gw 213.168.178.193
> 
> The question is, how does the IP stack decide what source IP address
> it should use when there's a packet to be sent on the given subnet or
> via the defaultgw?  Is there any way to actually choose the source IP
> address manually (say, per outgoing connection)?
> 
> I'm not interested in rewriting the source address with netfilter based
> on destination and/or service;  What I'm looking for is rather a way to
> initiate two connections to the same destination host using the two
> different source IP addresses.
> 

The simple answer is that if you need a specific IP address
associated with a "multi-honed" host, that has only one interface,
then something is broken. And you get to keep the pieces.

The IP addresses assigned to a multi-honed host are the addresses
to which it will respond during ARP. The ARP (Address Resolution
Protocol) you remember, is the protocol used to get the "hardware"
or IEEE station address of the interface.

Any IP protocol will properly work with any IP address embedded in
the packet from the interface that responded to the ARP.

However, the IP address inside the data-gram will usually be
the IP address of the interface that first sent that packet.
The IP address used is the address of the interface that met
the necessary criteria for getting the data-gram onto the wire.
In other words, the net-mask and the network address are the
determining factors. If you have two or more IP addresses that
are capable of putting the data-gram on the wire, the first one,
i.e., the address used to initialize the interface first, will
be the one that is used in out-going packets.

Since you don't bind a socket to a specific IP address when
initiating connections, you can't chose what IP address will
be used for those connections. However, when setting up
a server that will accept connections, you bind that socket
to both an IP address and a port. Therefore, a server can
be created that accepts connections only to a specific IP
address of a multi-honed host.

If you insist upon using only a particular IP address for
a specific connection from a multi-honed host, you can set
up a host-route for that particular machine:

Script started on Thu Dec  5 14:57:26 2002
# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:50:DA:19:7A:7D  
          inet addr:10.100.2.224  Bcast:10.255.255.255  Mask:255.0.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:30718261 errors:72 dropped:0 overruns:0 frame:72
          TX packets:3307230 errors:0 dropped:0 overruns:0 carrier:221
          collisions:35578 txqueuelen:100 
          Interrupt:10 Base address:0xb800

eth0:1    Link encap:Ethernet  HWaddr 00:50:DA:19:7A:7D
          inet addr:10.106.100.167  Bcast:10.255.255.255  Mask:255.0.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          Interrupt:10 Base address:0xb800 

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:59125 errors:0 dropped:0 overruns:0 frame:0
          TX packets:59125 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 

# route add -host skunkworks gw 10.106.100.167
# route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
10.106.100.205  10.106.100.167  255.255.255.255 UGH   0      0        0 eth0
10.0.0.0        0.0.0.0         255.0.0.0       U     0      0        0 eth0
127.0.0.0       0.0.0.0         255.0.0.0       U     0      0        0 lo
0.0.0.0         10.100.1.1      0.0.0.0         UG    0      0        0 eth0
# exit
exit

Script done on Thu Dec  5 14:58:58 2002

You can verify with `tcpdump` that the source address to 10.106.100.205
has been set to the gateway address of 10.106.100.167.

Script started on Thu Dec  5 15:28:15 2002
# tcpdump -n
tcpdump: listening on eth0
15:28:26.334663 0:d0:b7:3c:df:26 ff:ff:ff:ff:ff:ff 886d 60: 
			 0001 0001 2016 0c00 0100 0002 b32c 0bdb
			 0000 0000 0000 0000 0000 0000 0000 0000
			 0000 0000 0000 0000 0000 0000 0000 0000
			 0000 0000 0000
[SNIPPED lots of junk]

15:28:28.558563 arp who-has 10.106.100.205 tell 10.106.100.167
                            ^^^^^^^^^^^^^^      ^^^^^^^^^^^^^^
                             skunkworks         second interface
513 packets received by filter
0 packets dropped by kernel
# exit
exit
Script done on Thu Dec  5 15:28:38 2002

This is just an artifact of a particular kernel and a particular
installation. It is not the "right way" to do this.

There is no RightWay(tm) because any attempt to choose a specific
IP to on the wire from a machine that has only one interface, but
is multi-honed, is broken at the start. However, you can chose where
Netmasks, associated with a particular address, "interlock" to get
a range of destination addresses to use a particular source address.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


