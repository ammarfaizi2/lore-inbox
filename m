Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287882AbSAHEup>; Mon, 7 Jan 2002 23:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287648AbSAHEug>; Mon, 7 Jan 2002 23:50:36 -0500
Received: from [213.253.244.85] ([213.253.244.85]:42614 "EHLO
	mail.lhsystems.hu") by vger.kernel.org with ESMTP
	id <S287882AbSAHEuX>; Mon, 7 Jan 2002 23:50:23 -0500
Date: Tue, 8 Jan 2002 05:51:05 +0100 (CET)
From: Szekeres Bela <szekeres@lhsystems.hu>
To: Daniel Gryniewicz <dang@fprintf.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: arp bug
In-Reply-To: <20020107184144.1bdc1ee2.dang@fprintf.net>
Message-ID: <Pine.LNX.4.10.10201080514540.22909-100000@garfield.lhsystems.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

I've seen a similar bug in 2.2.19 (and a lot of 2.2-s, I've not checked it in
the 2.4 series).

I have two boxes both connected to the same two nets (tr and eth in my case,
but it does not matter). A third machine is only connected to the ethernet.

--------------------------- 10.1.0.0 (tr)
  |.1       |.2
 BOX1      BOX2      BOX3
  |.1       |.2       |.3
--------------------------- 10.2.0.0 (eth)

BOX3 has its default route set at 10.2.0.1 (BOX1). BOX3 opens a TCP connection
to 10.1.0.2 (BOX2's tr address). This connection setup packet goes thru
BOX1. BOX2 obviously answers thru the shorter path, directly over eth. BOX2
sends out a bogus arp query during this reply.

The problem lies in the ARP code itself. BOX2 fills out the arp query with the
following info:
- target: BOX3 IP address      (correct)
- self:   BOX2 eth MAC address (correct)
- self:   BOX2 tr IP address (incorrect)

The arp code only checks, if the target IP address is reachable directly. If 
it is, it takes its own IP address from the connection setup packet.

In my case BOX1 is a NetWare, which caches all the arp queries it sees, which
produced a very interesting arp table in BOX1...

The attached patch solved my problems.

Regards,
- Bela

--- net/ipv4/arp.c.orig	Fri Apr 20 01:56:40 2001
+++ net/ipv4/arp.c	Wed Feb 23 23:37:33 2000
@@ -67,6 +67,8 @@
  *					now it is in net/core/neighbour.c.
  *		Julian Anastasov:	"hidden" flag: hide the
  *					interface and don't reply for it
+ *		Bela Szekeres   :	Fixed bogus source IP address in ARP
+ *					requests (multi-homed hosts only)
  */
 
 /* RFC1122 Status:
@@ -318,7 +320,7 @@
 	if (skb &&
 	    (dev2 = ip_dev_find(skb->nh.iph->saddr)) != NULL &&
 	    (in_dev2 = dev2->ip_ptr) != NULL &&
-	    !IN_DEV_HIDDEN(in_dev2))
+	    !IN_DEV_HIDDEN(in_dev2) && (dev2==dev))
 		saddr = skb->nh.iph->saddr;
 	else
 		saddr = inet_select_addr(dev, target, RT_SCOPE_LINK);

On Mon, 7 Jan 2002, Daniel Gryniewicz wrote:

> I've encountered what I believe to be an arp bug.  Here's the situation:
> 
> I have quite a number of boxes, connected together via a number of networks.
> (It's a routing testbed) In this case, there are two boxes in question, box A
> and box B.  Here's the relevent portion of the config of both boxes:
> 
> Box A: (netbsd)
> ex0: flags=8863<UP,BROADCAST,NOTRAILERS,RUNNING,SIMPLEX,MULTICAST> mtu 1500
> 	address: 00:b0:d0:99:e6:ab
> 	media: Ethernet autoselect (100baseTX full-duplex)
> 	status: active
> 	inet 10.131.10.22 netmask 0xff800000 broadcast 10.255.255.255
> 	inet6 fe80::2b0:d0ff:fe99:e6ab%ex0 prefixlen 64 scopeid 0x5
> 	inet6 fec0:0:0:30a::16 prefixlen 64
> 	iso 47.0.5.80.ff.ff.0.0.0.6.0.0.0.0.0.a.83.a.16.0 
> 		netmask ff.ff.ff.ff.ff.ff.ff.ff.ff.ff.ff.ff.ff.ff.ff.ff.ff.ff.0.0.0 
> fxp2: flags=8943<UP,BROADCAST,RUNNING,PROMISC,SIMPLEX,MULTICAST> mtu 1500
> 	address: 00:02:b3:03:4f:05
> 	media: Ethernet autoselect (100baseTX)
> 	status: active
> 	inet 10.3.37.22 netmask 0xffffff80 broadcast 10.3.37.127
> 	inet6 fe80::202:b3ff:fe03:4f05%fxp2 prefixlen 64 scopeid 0x3
> 	inet6 fec0:0:0:325::16 prefixlen 64
> 	iso 47.0.5.80.ff.ff.0.0.0.4.0.0.0.0.0.a.3.21.16.0 
> 		netmask ff.ff.ff.ff.ff.ff.ff.ff.ff.ff.ff.ff.ff.ff.ff.ff.ff.ff.0.0.0 
> 
> Box B: (linux 2.4.17)
> eth0      Link encap:Ethernet  HWaddr 00:B0:D0:99:E5:E6  
>           inet addr:10.131.10.13  Bcast:10.255.255.255  Mask:255.128.0.0
>           inet6 addr: fe80::2b0:d0ff:fe99:e5e6/10 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:7325 errors:0 dropped:0 overruns:1 frame:0
>           TX packets:416 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:100 
>           Interrupt:5 Base address:0xe880 
> 
> eth4      Link encap:Ethernet  HWaddr 00:02:B3:03:4C:EE  
>           inet addr:10.3.37.13  Bcast:10.3.37.127  Mask:255.255.255.128
>           inet6 addr: fe80::202:b3ff:fe03:4cee/10 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:1 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:100 
>           Interrupt:11 Base address:0x6000 
> 
> Kernel IP routing table
> Destination     Gateway         Genmask         Flags   MSS Window  irtt Iface
> 10.3.37.0       0.0.0.0         255.255.255.128 U        40 0          0 eth4
> 0.0.0.0         10.254.10.1     0.0.0.0         UG       40 0          0 eth0
> 
> If I now change the default route on box B from 10.254.10.1 to 10.3.37.22
> (using route del/route add), then Box B sends the following arp, captured via
> tcpdump on box A:
> 
> 17:49:12.393126 arp who-has 10.3.37.22 tell 10.131.10.13
> 
> This triggers a bug in NetBSD, which is how I found out about this, but should
> that be "tell 10.3.37.13"?  If it was, this would work.  As near as I can
> tell, Linux does this type of thing whenever I change my default route from
> it's initial one to one on another interface.  This bug occures in (at least)
> 2.4.17, 2.4.5, and 2.2.20, so it's probably in all versions.
> 
> Thanks,
> Daniel
> --- 
> Recursion n.:
>         See Recursion.
>                         -- Random Shack Data Processing Dictionary
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

