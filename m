Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262810AbUBZQTK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 11:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262806AbUBZQTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 11:19:10 -0500
Received: from witte.sonytel.be ([80.88.33.193]:48585 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262826AbUBZQSQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 11:18:16 -0500
Date: Thu, 26 Feb 2004 17:18:01 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: tulip-users@lists.sourceforge.net,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] Tulip 21041 port breakage
Message-ID: <Pine.GSO.4.58.0401031203001.3219@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Jeff,

I still (2.4.23, but the Tulip driver wasn't changed in the mean time) need the
following patch in my tree:

--- linux-2.4.26-pre1/drivers/net/tulip/tulip_core.c.orig	2004-02-26 17:06:50.000000000 +0100
+++ linux-2.4.26-pre1/drivers/net/tulip/tulip_core.c	2004-02-26 17:09:54.000000000 +0100
@@ -579,7 +579,7 @@
 					dev->if_port = 2 - dev->if_port;
 				} else
 					dev->if_port = 0;
-			else
+			else if (dev->if_port != 0 || (csr12 & 0x0004) != 0)
 				dev->if_port = 1;
 			tulip_select_media(dev, 0);
 		}

Without this patch, on heavy network activity the driver switches from 10-baseT
to 10-base2, while there's still a 10-baseT link beat, and the network is lost,
requiring manual intervention (ifdown/ifup).

With the patch, the driver automatically recovers after a few minutes, as
evidenced from this log excerpt:

| Feb  3 17:48:50 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| Feb  3 17:48:50 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| Feb  3 17:48:50 callisto kernel: tulip: old driver would switch to 10base2, but we don't
| Feb  3 17:48:58 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| Feb  3 17:48:58 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| Feb  3 17:48:58 callisto kernel: tulip: old driver would switch to 10base2, but we don't
| Feb  3 17:49:18 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| Feb  3 17:49:18 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| Feb  3 17:49:18 callisto kernel: tulip: old driver would switch to 10base2, but we don't
| Feb  3 17:49:26 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| Feb  3 17:49:26 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| Feb  3 17:49:26 callisto kernel: tulip: old driver would switch to 10base2, but we don't
| Feb  3 17:49:34 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| Feb  3 17:49:34 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| Feb  3 17:49:34 callisto kernel: tulip: old driver would switch to 10base2, but we don't
| Feb  3 17:49:42 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| Feb  3 17:49:42 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| Feb  3 17:49:42 callisto kernel: tulip: old driver would switch to 10base2, but we don't
| Feb  3 17:49:50 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| Feb  3 17:49:50 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| Feb  3 17:49:50 callisto kernel: tulip: old driver would switch to 10base2, but we don't
| Feb  3 17:49:58 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| Feb  3 17:49:58 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| Feb  3 17:49:58 callisto kernel: tulip: old driver would switch to 10base2, but we don't
| Feb  3 17:50:06 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| Feb  3 17:50:06 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| Feb  3 17:50:06 callisto kernel: tulip: old driver would switch to 10base2, but we don't
| Feb  3 17:50:14 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| Feb  3 17:50:14 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| Feb  3 17:50:14 callisto kernel: tulip: old driver would switch to 10base2, but we don't
| Feb  3 17:50:22 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| Feb  3 17:50:22 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| Feb  3 17:50:22 callisto kernel: tulip: old driver would switch to 10base2, but we don't
| Feb  3 17:50:30 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| Feb  3 17:50:30 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| Feb  3 17:50:30 callisto kernel: tulip: old driver would switch to 10base2, but we don't
| Feb  3 17:50:42 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| Feb  3 17:50:42 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| Feb  3 17:50:42 callisto kernel: tulip: old driver would switch to 10base2, but we don't
| Feb  3 17:50:50 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| Feb  3 17:50:50 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| Feb  3 17:50:50 callisto kernel: tulip: old driver would switch to 10base2, but we don't
| Feb  3 17:50:58 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| Feb  3 17:50:58 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| Feb  3 17:50:58 callisto kernel: tulip: old driver would switch to 10base2, but we don't
| Feb  3 17:51:06 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| Feb  3 17:51:06 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| Feb  3 17:51:06 callisto kernel: tulip: old driver would switch to 10base2, but we don't
| Feb  3 17:51:14 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| Feb  3 17:51:14 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| Feb  3 17:51:14 callisto kernel: tulip: old driver would switch to 10base2, but we don't
| Feb  3 17:51:22 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| Feb  3 17:51:22 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| Feb  3 17:51:22 callisto kernel: tulip: old driver would switch to 10base2, but we don't
| Feb  3 17:51:30 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| Feb  3 17:51:30 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| Feb  3 17:51:30 callisto kernel: tulip: old driver would switch to 10base2, but we don't
| Feb  3 17:51:38 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| Feb  3 17:51:38 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| Feb  3 17:51:38 callisto kernel: tulip: old driver would switch to 10base2, but we don't
| Feb  3 17:51:46 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| Feb  3 17:51:46 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| Feb  3 17:51:46 callisto kernel: tulip: old driver would switch to 10base2, but we don't
| Feb  3 17:52:10 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| Feb  3 17:52:10 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| Feb  3 17:52:10 callisto kernel: tulip: old driver would switch to 10base2, but we don't
| Feb  3 17:52:26 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| Feb  3 17:52:26 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| Feb  3 17:52:26 callisto kernel: tulip: old driver would switch to 10base2, but we don't
| Feb  3 17:52:46 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| Feb  3 17:52:46 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| Feb  3 17:52:46 callisto kernel: tulip: old driver would switch to 10base2, but we don't
| Feb  3 17:52:54 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| Feb  3 17:52:54 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| Feb  3 17:52:54 callisto kernel: tulip: old driver would switch to 10base2, but we don't
| Feb  3 17:53:10 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| Feb  3 17:53:10 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| Feb  3 17:53:10 callisto kernel: tulip: old driver would switch to 10base2, but we don't
| Feb  3 17:53:18 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| Feb  3 17:53:18 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| Feb  3 17:53:18 callisto kernel: tulip: old driver would switch to 10base2, but we don't
| Feb  3 17:55:38 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| Feb  3 17:55:38 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| Feb  3 17:55:38 callisto kernel: tulip: old driver would switch to 10base2, but we don't
| Feb  3 17:55:54 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| Feb  3 17:55:54 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| Feb  3 17:55:54 callisto kernel: tulip: old driver would switch to 10base2, but we don't
| Feb  3 17:56:02 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| Feb  3 17:56:02 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| Feb  3 17:56:02 callisto kernel: tulip: old driver would switch to 10base2, but we don't
| Feb  3 17:56:02 callisto kernel: eth0: No 21041 10baseT link beat, Media switched to 10base2.
| Feb  3 17:56:10 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| Feb  3 17:56:10 callisto kernel: eth0: 21041 transmit timed out, status fc260010, CSR12 000050c8, CSR13 ffffef09, CSR14 fffff7fd, resetting...
| Feb  3 17:56:12 callisto kernel: eth0: Out-of-sync dirty pointer, 76318 vs. 76335.

Machine is CHRP LongTrail with a PPC604e and a 21041, connected to a 10 Mbps
hub:

00:04.0 Ethernet controller: Digital Equipment Corporation DECchip 21041 [Tulip Pass 3] (rev 21)
        Subsystem: D-Link System Inc DE-530+
        Flags: bus master, medium devsel, latency 0, IRQ 29
        I/O ports at 1080 [size=128]
        Memory at c1080000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at c11c0000 [disabled] [size=256K]

Kernel is 2.4.23, with the following patch applied to the tulip driver:

--- linux-ppc-2.4.23/drivers/net/tulip/tulip_core.c.orig	2003-11-28 21:04:35.000000000 +0100
+++ linux-ppc-2.4.23/drivers/net/tulip/tulip_core.c	2003-11-30 11:37:45.000000000 +0100
@@ -580,7 +580,15 @@
 				} else
 					dev->if_port = 0;
 			else
+			{
+printk("tulip: old driver would switch to 10base2, ");
+			if (dev->if_port != 0 || (csr12 & 0x0004) != 0) {
+printk("and we do\n");
 				dev->if_port = 1;
+			} else {
+printk("but we don't\n");
+			}
+			}
 			tulip_select_media(dev, 0);
 		}
 	} else if (tp->chip_id == DC21140 || tp->chip_id == DC21142


BTW, recently I noticed a different problem:

(tux is my Vaio laptop with i8255x Ethernet, callisto is the PPC box with a
21041):

| tux$ ping callisto
| PING callisto.of.borg (192.168.0.1): 56 data bytes
| 64 bytes from 192.168.0.1: icmp_seq=5 ttl=64 time=0.1 ms
| 64 bytes from 192.168.0.1: icmp_seq=0 ttl=64 time=4998.4 ms
| 64 bytes from 192.168.0.1: icmp_seq=1 ttl=64 time=4002.3 ms
| 64 bytes from 192.168.0.1: icmp_seq=2 ttl=64 time=3002.4 ms
| 64 bytes from 192.168.0.1: icmp_seq=3 ttl=64 time=2002.5 ms
| 64 bytes from 192.168.0.1: icmp_seq=4 ttl=64 time=1002.6 ms
| 64 bytes from 192.168.0.1: icmp_seq=31 ttl=64 time=0.1 ms
| 64 bytes from 192.168.0.1: icmp_seq=6 ttl=64 time=25032.0 ms
| 64 bytes from 192.168.0.1: icmp_seq=7 ttl=64 time=24032.0 ms
| 64 bytes from 192.168.0.1: icmp_seq=8 ttl=64 time=23032.0 ms
| 64 bytes from 192.168.0.1: icmp_seq=9 ttl=64 time=22032.0 ms
| 64 bytes from 192.168.0.1: icmp_seq=10 ttl=64 time=21032.0 ms
| 64 bytes from 192.168.0.1: icmp_seq=11 ttl=64 time=20022.0 ms
| 64 bytes from 192.168.0.1: icmp_seq=12 ttl=64 time=19022.0 ms
| 64 bytes from 192.168.0.1: icmp_seq=13 ttl=64 time=18022.0 ms
| 64 bytes from 192.168.0.1: icmp_seq=14 ttl=64 time=17022.0 ms
| 64 bytes from 192.168.0.1: icmp_seq=15 ttl=64 time=16022.0 ms
| 64 bytes from 192.168.0.1: icmp_seq=16 ttl=64 time=15022.0 ms
| 64 bytes from 192.168.0.1: icmp_seq=17 ttl=64 time=14022.0 ms
| 64 bytes from 192.168.0.1: icmp_seq=18 ttl=64 time=13022.0 ms
| 64 bytes from 192.168.0.1: icmp_seq=19 ttl=64 time=12022.0 ms
| 64 bytes from 192.168.0.1: icmp_seq=20 ttl=64 time=11022.0 ms
| 64 bytes from 192.168.0.1: icmp_seq=21 ttl=64 time=10022.0 ms
| 64 bytes from 192.168.0.1: icmp_seq=22 ttl=64 time=9021.9 ms
| 64 bytes from 192.168.0.1: icmp_seq=23 ttl=64 time=8021.9 ms
| 64 bytes from 192.168.0.1: icmp_seq=24 ttl=64 time=7021.9 ms
| 64 bytes from 192.168.0.1: icmp_seq=25 ttl=64 time=6021.9 ms
| 64 bytes from 192.168.0.1: icmp_seq=26 ttl=64 time=5021.9 ms
| 64 bytes from 192.168.0.1: icmp_seq=27 ttl=64 time=4021.9 ms
| 64 bytes from 192.168.0.1: icmp_seq=28 ttl=64 time=3021.9 ms
| 64 bytes from 192.168.0.1: icmp_seq=29 ttl=64 time=2021.8 ms
| 64 bytes from 192.168.0.1: icmp_seq=30 ttl=64 time=1021.9 ms
| 64 bytes from 192.168.0.1: icmp_seq=55 ttl=64 time=0.1 ms
| 64 bytes from 192.168.0.1: icmp_seq=32 ttl=64 time=23016.2 ms
| 64 bytes from 192.168.0.1: icmp_seq=33 ttl=64 time=22016.2 ms
| 64 bytes from 192.168.0.1: icmp_seq=34 ttl=64 time=21016.2 ms
| 64 bytes from 192.168.0.1: icmp_seq=35 ttl=64 time=20016.2 ms
| 64 bytes from 192.168.0.1: icmp_seq=36 ttl=64 time=19016.3 ms
| 64 bytes from 192.168.0.1: icmp_seq=37 ttl=64 time=18016.2 ms
| 64 bytes from 192.168.0.1: icmp_seq=38 ttl=64 time=17016.2 ms
| 64 bytes from 192.168.0.1: icmp_seq=39 ttl=64 time=16016.3 ms
| ...
|
| --- callisto.of.borg ping statistics ---
| 452 packets transmitted, 420 packets received, 7% packet loss
| round-trip min/avg/max = 0.1/10917.2/25032.0 ms

However, according to dmesg the case to be adressed by the patch above was not
triggered, so this is a different problem.

ifdown/ifup fixed the problem.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
