Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287388AbSAGXnH>; Mon, 7 Jan 2002 18:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287404AbSAGXmt>; Mon, 7 Jan 2002 18:42:49 -0500
Received: from [209.249.147.248] ([209.249.147.248]:2820 "EHLO proxy1.addr.com")
	by vger.kernel.org with ESMTP id <S287388AbSAGXmc>;
	Mon, 7 Jan 2002 18:42:32 -0500
Date: Mon, 7 Jan 2002 18:41:44 -0500
From: Daniel Gryniewicz <dang@fprintf.net>
To: linux-kernel@vger.kernel.org
Subject: arp bug
Message-Id: <20020107184144.1bdc1ee2.dang@fprintf.net>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've encountered what I believe to be an arp bug.  Here's the situation:

I have quite a number of boxes, connected together via a number of networks.
(It's a routing testbed) In this case, there are two boxes in question, box A
and box B.  Here's the relevent portion of the config of both boxes:

Box A: (netbsd)
ex0: flags=8863<UP,BROADCAST,NOTRAILERS,RUNNING,SIMPLEX,MULTICAST> mtu 1500
	address: 00:b0:d0:99:e6:ab
	media: Ethernet autoselect (100baseTX full-duplex)
	status: active
	inet 10.131.10.22 netmask 0xff800000 broadcast 10.255.255.255
	inet6 fe80::2b0:d0ff:fe99:e6ab%ex0 prefixlen 64 scopeid 0x5
	inet6 fec0:0:0:30a::16 prefixlen 64
	iso 47.0.5.80.ff.ff.0.0.0.6.0.0.0.0.0.a.83.a.16.0 
		netmask ff.ff.ff.ff.ff.ff.ff.ff.ff.ff.ff.ff.ff.ff.ff.ff.ff.ff.0.0.0 
fxp2: flags=8943<UP,BROADCAST,RUNNING,PROMISC,SIMPLEX,MULTICAST> mtu 1500
	address: 00:02:b3:03:4f:05
	media: Ethernet autoselect (100baseTX)
	status: active
	inet 10.3.37.22 netmask 0xffffff80 broadcast 10.3.37.127
	inet6 fe80::202:b3ff:fe03:4f05%fxp2 prefixlen 64 scopeid 0x3
	inet6 fec0:0:0:325::16 prefixlen 64
	iso 47.0.5.80.ff.ff.0.0.0.4.0.0.0.0.0.a.3.21.16.0 
		netmask ff.ff.ff.ff.ff.ff.ff.ff.ff.ff.ff.ff.ff.ff.ff.ff.ff.ff.0.0.0 

Box B: (linux 2.4.17)
eth0      Link encap:Ethernet  HWaddr 00:B0:D0:99:E5:E6  
          inet addr:10.131.10.13  Bcast:10.255.255.255  Mask:255.128.0.0
          inet6 addr: fe80::2b0:d0ff:fe99:e5e6/10 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:7325 errors:0 dropped:0 overruns:1 frame:0
          TX packets:416 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          Interrupt:5 Base address:0xe880 

eth4      Link encap:Ethernet  HWaddr 00:02:B3:03:4C:EE  
          inet addr:10.3.37.13  Bcast:10.3.37.127  Mask:255.255.255.128
          inet6 addr: fe80::202:b3ff:fe03:4cee/10 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          Interrupt:11 Base address:0x6000 

Kernel IP routing table
Destination     Gateway         Genmask         Flags   MSS Window  irtt Iface
10.3.37.0       0.0.0.0         255.255.255.128 U        40 0          0 eth4
0.0.0.0         10.254.10.1     0.0.0.0         UG       40 0          0 eth0

If I now change the default route on box B from 10.254.10.1 to 10.3.37.22
(using route del/route add), then Box B sends the following arp, captured via
tcpdump on box A:

17:49:12.393126 arp who-has 10.3.37.22 tell 10.131.10.13

This triggers a bug in NetBSD, which is how I found out about this, but should
that be "tell 10.3.37.13"?  If it was, this would work.  As near as I can
tell, Linux does this type of thing whenever I change my default route from
it's initial one to one on another interface.  This bug occures in (at least)
2.4.17, 2.4.5, and 2.2.20, so it's probably in all versions.

Thanks,
Daniel
--- 
Recursion n.:
        See Recursion.
                        -- Random Shack Data Processing Dictionary

