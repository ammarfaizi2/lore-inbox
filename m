Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263124AbUDTQBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263124AbUDTQBl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 12:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263093AbUDTQBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 12:01:41 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2944 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263124AbUDTQBb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 12:01:31 -0400
Date: Tue, 20 Apr 2004 12:01:04 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Antony Suter <suterant@users.sourceforge.net>
cc: cryptic-lkml@bloodletting.com, List LKML <linux-kernel@vger.kernel.org>
Subject: Re: Testing Dual Ethernet via Loopback
In-Reply-To: <1082468778.13813.4.camel@hikaru.lan>
Message-ID: <Pine.LNX.4.53.0404201142410.568@chaos>
References: <1082468778.13813.4.camel@hikaru.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Apr 2004, Antony Suter wrote:

>
> No special kernel is needed. You have a proper crossover cable
> connecting your ethernet cards?
>
> You simply have to assign ip addresses to each card properly. It might
> be easiest to assign different subnets to each.
> 192.168.1.1/255.255.255.0 to the first and 192.168.2.1/255.255.255.0 to
> the second. That should get you started.
>

That's how it should work. However, there appears to be a problem
with ARP (reported off-and-on over several years). The initial connection
fails or ends up going through 127.0.0.1, when you use two boards
on the same machine.

Here is an example:

Script started on Tue Apr 20 11:47:36 2004
# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:10:5A:27:7B:16
          inet addr:10.100.2.224  Bcast:10.255.255.255  Mask:255.0.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:96538 errors:0 dropped:0 overruns:0 frame:0
          TX packets:974 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          Interrupt:18 Base address:0xd000

eth0:1    Link encap:Ethernet  HWaddr 00:10:5A:27:7B:16
          inet addr:10.106.100.167  Bcast:10.255.255.255  Mask:255.0.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          Interrupt:18 Base address:0xd000

eth1      Link encap:Ethernet  HWaddr 00:10:DC:A7:A7:3B
          inet addr:10.100.2.223  Bcast:10.255.255.255  Mask:255.0.0.0
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          Interrupt:18

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:294 errors:0 dropped:0 overruns:0 frame:0
          TX packets:294 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0

# route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
10.0.0.0        *               255.0.0.0       U     0      0        0 eth0
10.0.0.0        *               255.0.0.0       U     0      0        0 eth1
127.0.0.0       *               255.0.0.0       U     0      0        0 lo
default         hidden-route    0.0.0.0         UG    0      0        0 eth0
# ping 10.100.2.223
64 bytes from 10.100.2.223     icmp-seq:0  ttl:64  time(ms):0.13    lost:0
64 bytes from 10.100.2.223     icmp-seq:0  ttl:64  time(ms):20.31   lost:0
64 bytes from 10.100.2.223     icmp-seq:1  ttl:64  time(ms):0.03    lost:0
64 bytes from 10.100.2.223     icmp-seq:1  ttl:64  time(ms):0.04    lost:0
64 bytes from 10.100.2.223     icmp-seq:2  ttl:64  time(ms):0.03    lost:0
64 bytes from 10.100.2.223     icmp-seq:2  ttl:64  time(ms):0.04    lost:0
64 bytes from 10.100.2.223     icmp-seq:3  ttl:64  time(ms):0.03    lost:0
64 bytes from 10.100.2.223     icmp-seq:3  ttl:64  time(ms):0.04    lost:0
64 bytes from 10.100.2.223     icmp-seq:4  ttl:64  time(ms):0.03    lost:0
# nslookup 10.100.2.223
Server:  octans.analogic.com
Address:  10.100.2.1

*** octans.analogic.com can't find 10.100.2.223: Non-existent host/domain
# nslookup 10.100.2.223
Server:  octans.analogic.com
Address:  10.100.2.1

Name:    chaos.analogic.com
Address:  10.100.2.224

# uname -a
Linux chaos 2.4.26 #1 SMP Fri Apr 16 15:49:31 EDT 2004 i686
# exit
Script done on Tue Apr 20 11:49:32 2004

I'm on interface 10.100.2.224.
I can ping 10.100.2.223 *** WITH NO CABLE CONNECTED!!! ***

If I execute `ifconfig lo down`, the ping-able connection
goes away so I know how it's being propagated.

It's like Linux is trying to be "helpful" again, figures it
will find the best route to the other interface so it bypasses
the interface and goes through lo. In recent years, Linux has
gotten to be more and more "helpful" like that. This makes
troubleshooting in the real-world very difficult.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5596.77 BogoMips).
            Note 96.31% of all statistics are fiction.


