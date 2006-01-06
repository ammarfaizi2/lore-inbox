Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbWAFDbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWAFDbu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 22:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbWAFDbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 22:31:49 -0500
Received: from main.gmane.org ([80.91.229.2]:40159 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750823AbWAFDbt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 22:31:49 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: eth0 and loopback problems.
Date: Fri, 06 Jan 2006 12:31:24 +0900
Message-ID: <dpkoae$5t2$1@sea.gmane.org>
References: <20060105092052.GE3008@darkstar.mylan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20060103)
X-Accept-Language: en-us, en
In-Reply-To: <20060105092052.GE3008@darkstar.mylan>
X-Enigmail-Version: 0.93.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

JohnnyRun wrote:
> Hi all!
> I think  it's a bug....
That definately seems weired, but I never ran into it till now...

> HOSTA# ifconfig eth0 192.168.0.1
> HOSTA# ifconfig eth0 down
> HOSTA# ping 192.168.0.1
> (the ping works, like all other ICMP / TCP /UDP ... application. 
> In other words: all work like eth0 in UP mode when source and
> destination point comunicate via loopback device.
> I think it's not correct because if eth0 is DOWN for all the hosts in
> LAN should be down for me too. Or not?

Just to rewrite that in iproute2

old ~ # ip addr flush dev eth1
old ~ # ip addr show dev eth1
4: eth1: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast qlen 1000
    link/ether 00:00:00:54:0b:8a brd ff:ff:ff:ff:ff:ff
old ~ # ping -c1 -q 192.168.0.1
PING 192.168.0.1 (192.168.0.1) 56(84) bytes of data.

--- 192.168.0.1 ping statistics ---
1 packets transmitted, 0 received, 100% packet loss, time 0ms

old ~ # ip addr add 192.168.0.1/32 dev eth1
old ~ # ip link set dev eth1 down
old ~ # ip link show dev eth1
4: eth1: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast qlen 1000
    link/ether 00:00:00:54:0b:8a brd ff:ff:ff:ff:ff:ff
old ~ # ping -c1 -q 192.168.0.1
PING 192.168.0.1 (192.168.0.1) 56(84) bytes of data.

--- 192.168.0.1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.033/0.033/0.033/0.000 ms


> Suppose another conf:
> 
> HOSTA# ifconfig
> eth0      Link encap:Ethernet  HWaddr 00:10:DC:C3:5E:FF  
>           inet addr:192.168.0.1  Bcast:192.168.0.255  Mask:255.0.0.0
> 	  BROADCAST MULTICAST  MTU:1500  Metric:1
> eth1      Link encap:Ethernet  HWaddr 00:0E:35:74:16:67  
>           inet addr:192.168.0.2 [...]
> 	  UP BROADCAST RUNNING MULTICAST  MTU:1500
> lo  	 [...]
> 
> HOSTB# ifconfig eth0
> eth0      Link encap:Ethernet  HWaddr 00:00:24:C8:4A:7D  
>           inet addr:192.168.0.1  Bcast:1.255.255.255  Mask:255.0.0.0
> 	  UP BROADCAST RUNNING MULTICAST  MTU:1500
> 	  [...]
> 
> So, HOSTA and HOSTB share the same ip but: HOSTA eth0 is DOWN; HOSTA eth1 is
> UP, HOSTB eth0 is UP. So, no conflict should be possible.
> but:
> 
> HOSTB# ping 192.168.0.2
> (does not reply)
> 
> So I suppose that HOSTA route the icmp reply through its lo.
> But:
> 
> HOSTA# tcpdump -i lo
> doesn't show any reply, and 
> 
> HOSTA# tcpdump -i eth0 
> it's not permitted, because eth0 is DOWN.
> 
> The same result for TCP protocol (tested with hping).
> Operative conditions: Linux 2.6.14, HOSTA eth1 is wifi.

Very good testcase!

Any IP gurus? Ideas on why is such behaviour observerd?

Does it have to do something with the driver for ethX being notiefied of the link status and thus
hardware (PHY?) is shut down so signal from the wire is ignored?
Or down the ARP somewhere?

Cannot think of security exploit at the moment, but there should be one...


Kalin.

-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

