Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbTEKJnz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 05:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbTEKJnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 05:43:55 -0400
Received: from amsfep15-int.chello.nl ([213.46.243.28]:63271 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S261183AbTEKJnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 05:43:50 -0400
Date: Sun, 11 May 2003 11:53:18 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: tulip-users@lists.sourceforge.net,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: 21041 transmit timed out
In-Reply-To: <Pine.GSO.4.21.0304201237140.14680-100000@vervain.sonytel.be>
Message-ID: <Pine.LNX.4.44.0305111148460.19415-100000@callisto>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Apr 2003, Geert Uytterhoeven wrote:
> Under heavy network activity (e.g. downloading ISOs), my Tulip card (D-Link
> DE-530+ with DECchip 21041) still goes down with 2.4.20.
>
> Suddenly I start getting messages of the form:
> | NETDEV WATCHDOG: eth0: transmit timed out
> | eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
> | eth0: 21143 100baseTx sensed media.
>
> and the network no longer works. Sometimes it automatically recovers after a
> while (without printing additional messages), but usually I need to do a manual
> ifconfig down/up sequence to revive the network.
>
> The register values may differ. Last time I saw these, with their respective
> number of occurrencies:
>
>  1741 x status fc260010, CSR12 000000c8, CSR13 ffffef09, CSR14 ffffff7f
>   581 x status fc260010, CSR12 000002c8, CSR13 ffffef09, CSR14 ffffff7f
>    20 x status fc260010, CSR12 000050c8, CSR13 ffffef09, CSR14 fffff7fd
>     6 x status fc260010, CSR12 000052c8, CSR13 ffffef09, CSR14 fffff7fd
>    28 x status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff
>
> Once it printed
>
> | eth0: 21041 media switched to 10baseT.
>
> after which the network seemed to work again for a few minutes.
>
> I also got 27 times
>
> | eth0: No 21041 10baseT link beat, Media switched to 10base2.
>
> which I find, together with the zillions of `21143 100baseTx sensed media'
> messages very strange, since the card is 10 Mbps-only and connected using UTP
> to a 10 Mbps-only Ethernet hub (D-Link DE816-TP).

I did some more investigations...

If a transmit timeout happens on a 21041, the current code changes the
interface medium:
 1. If 10base2 (if_port = 1) and no 10baseT link beat, stay on 10base2 (1)
 2. If AUI (2) and no 10baseT link beat, swith to 10baseT (0)
 3. If 10base2 (1) or AUI (2) and the 10baseT link beat is present, swith to
    10baseT (0)
 4. If 10baseT (0), switch to 10base2 (1)

To me it looks like these rules are flawed. Apart from the fishyness of the
first two rules, rule 4 unconditionally switches my interface to 10base2, while
I still have a 10baseT link beat ((csr12 & 4) == 0)!

As removing this media change code didn't help, I modified the code in the
following way:

--- linux-2.4.20/drivers/net/tulip/tulip_core.c.orig	Tue Oct 29 18:41:48 2002
+++ linux-2.4.20/drivers/net/tulip/tulip_core.c	Sun May  4 11:51:36 2003
@@ -570,13 +570,20 @@
 			   inl(ioaddr + CSR13), inl(ioaddr + CSR14));
 		tp->mediasense = 1;
 		if ( ! tp->medialock) {
-			if (dev->if_port == 1 || dev->if_port == 2)
+			if (dev->if_port == 1 || dev->if_port == 2) {
+printk("Switching from port %d", dev->if_port);
 				if (csr12 & 0x0004) {
 					dev->if_port = 2 - dev->if_port;
 				} else
 					dev->if_port = 0;
-			else
+printk(" to port %d", dev->if_port);
+			} else if (dev->if_port == 0 && !(csr12 & 0x0004)) {
+printk("Staying on 10baseT\n");
+			} else {
+printk("Switching from port %d", dev->if_port);
 				dev->if_port = 1;
+printk(" to 10base2\n");
+			}
 			tulip_select_media(dev, 0);
 		}
 	} else if (tp->chip_id == DC21140 || tp->chip_id == DC21142


And now it recovers when a transmit timeout is detected:

| May  4 14:36:00 callisto kernel: eth0: Media selection tick, 10baseT, status fc2e0000 mode fffe2202 SIA 00005108 ffffef01 ffffffff ffff0008.
| May  4 14:36:00 callisto kernel: eth0: 21041 media tick  CSR12 00005108.
| May  4 14:36:30 callisto kernel: eth0: Media selection tick, 10baseT, status fc660000 mode fffe2202 SIA 000051c8 ffffef01 ffffffff ffff0008.
| May  4 14:36:30 callisto kernel: eth0: 21041 media tick  CSR12 000051c8.

----> Here it goes wrong

| May  4 14:36:37 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| May  4 14:36:37 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...

(csr12 & 4) == 0, so there's still a 10baseT link beat

| May  4 14:36:37 callisto kernel: Staying on 10baseT
| May  4 14:36:37 callisto kernel: eth0: 21041 using media 10baseT, CSR12 is 51c8.
| May  4 14:36:37 callisto kernel: eth0: The transmitter stopped.  CSR5 is fc678106, CSR6 fffe2002, new CSR6 80020000.
| May  4 14:36:37 callisto kernel: eth0: 21143 link status interrupt 000011c4, CSR5 fc678106, ffffffff.
| May  4 14:36:45 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| May  4 14:36:45 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| May  4 14:36:45 callisto kernel: Staying on 10baseT
| May  4 14:36:45 callisto kernel: eth0: 21041 using media 10baseT, CSR12 is 51c8.
| May  4 14:36:45 callisto kernel: eth0: The transmitter stopped.  CSR5 is fc678106, CSR6 fffe2002, new CSR6 80020000.
| May  4 14:36:45 callisto kernel: eth0: 21143 link status interrupt 000011c4, CSR5 fc678106, ffffffff.
| May  4 14:36:54 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| May  4 14:36:54 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| May  4 14:36:54 callisto kernel: Staying on 10baseT
| May  4 14:36:54 callisto kernel: eth0: 21041 using media 10baseT, CSR12 is 51c8.
| May  4 14:36:54 callisto kernel: eth0: The transmitter stopped.  CSR5 is fc678106, CSR6 fffe2002, new CSR6 80020000.
| May  4 14:36:54 callisto kernel: eth0: 21143 link status interrupt 000011c4, CSR5 fc678106, ffffffff.
| May  4 14:37:00 callisto kernel: eth0: Media selection tick, 10baseT, status fc660000 mode fffe2002 SIA 000051c8 ffffef01 ffffffff ffff0008.
| May  4 14:37:00 callisto kernel: eth0: 21041 media tick  CSR12 000051c8.
| May  4 14:37:02 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| May  4 14:37:02 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| May  4 14:37:02 callisto kernel: Staying on 10baseT
| May  4 14:37:02 callisto kernel: eth0: 21041 using media 10baseT, CSR12 is 51c8.
| May  4 14:37:02 callisto kernel: eth0: The transmitter stopped.  CSR5 is fc678106, CSR6 fffe2002, new CSR6 80020000.
| May  4 14:37:02 callisto kernel: eth0: 21143 link status interrupt 000011c4, CSR5 fc678106, ffffffff.
| May  4 14:37:11 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| May  4 14:37:11 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| May  4 14:37:11 callisto kernel: Staying on 10baseT
| May  4 14:37:11 callisto kernel: eth0: 21041 using media 10baseT, CSR12 is 51c8.
| May  4 14:37:11 callisto kernel: eth0: The transmitter stopped.  CSR5 is fc678106, CSR6 fffe2002, new CSR6 80020000.
| May  4 14:37:11 callisto kernel: eth0: 21143 link status interrupt 000011c4, CSR5 fc678106, ffffffff.
| May  4 14:37:19 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| May  4 14:37:19 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| May  4 14:37:19 callisto kernel: Staying on 10baseT
| May  4 14:37:19 callisto kernel: eth0: 21041 using media 10baseT, CSR12 is 51c8.
| May  4 14:37:19 callisto kernel: eth0: The transmitter stopped.  CSR5 is fc678106, CSR6 fffe2002, new CSR6 80020000.
| May  4 14:37:19 callisto kernel: eth0: 21143 link status interrupt 000011c4, CSR5 fc678106, ffffffff.
| May  4 14:37:27 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| May  4 14:37:27 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| May  4 14:37:27 callisto kernel: Staying on 10baseT
| May  4 14:37:27 callisto kernel: eth0: 21041 using media 10baseT, CSR12 is 51c8.
| May  4 14:37:27 callisto kernel: eth0: The transmitter stopped.  CSR5 is fc678106, CSR6 fffe2002, new CSR6 80020000.
| May  4 14:37:27 callisto kernel: eth0: 21143 link status interrupt 000011c4, CSR5 fc678106, ffffffff.
| May  4 14:37:30 callisto kernel: eth0: Media selection tick, 10baseT, status fc660000 mode fffe2002 SIA 000051c8 ffffef01 ffffffff ffff0008.
| May  4 14:37:30 callisto kernel: eth0: 21041 media tick  CSR12 000051c8.
| May  4 14:37:36 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| May  4 14:37:36 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| May  4 14:37:36 callisto kernel: Staying on 10baseT
| May  4 14:37:36 callisto kernel: eth0: 21041 using media 10baseT, CSR12 is 51c8.
| May  4 14:37:36 callisto kernel: eth0: The transmitter stopped.  CSR5 is fc678106, CSR6 fffe2002, new CSR6 80020000.
| May  4 14:37:36 callisto kernel: eth0: 21143 link status interrupt 000011c4, CSR5 fc678106, ffffffff.
| May  4 14:37:44 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| May  4 14:37:44 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| May  4 14:37:44 callisto kernel: Staying on 10baseT
| May  4 14:37:44 callisto kernel: eth0: 21041 using media 10baseT, CSR12 is 51c8.
| May  4 14:37:44 callisto kernel: eth0: The transmitter stopped.  CSR5 is fc678106, CSR6 fffe2002, new CSR6 80020000.
| May  4 14:37:44 callisto kernel: eth0: 21143 link status interrupt 000011c4, CSR5 fc678106, ffffffff.
| May  4 14:37:52 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| May  4 14:37:52 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| May  4 14:37:52 callisto kernel: Staying on 10baseT
| May  4 14:37:52 callisto kernel: eth0: 21041 using media 10baseT, CSR12 is 51c8.
| May  4 14:37:52 callisto kernel: eth0: The transmitter stopped.  CSR5 is fc678106, CSR6 fffe2002, new CSR6 80020000.
| May  4 14:37:52 callisto kernel: eth0: 21143 link status interrupt 000011c4, CSR5 fc678106, ffffffff.
| May  4 14:38:00 callisto kernel: eth0: Media selection tick, 10baseT, status fc660000 mode fffe2002 SIA 000051c8 ffffef01 ffffffff ffff0008.
| May  4 14:38:00 callisto kernel: eth0: 21041 media tick  CSR12 000051c8.
| May  4 14:38:01 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| May  4 14:38:01 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| May  4 14:38:01 callisto kernel: Staying on 10baseT
| May  4 14:38:01 callisto kernel: eth0: 21041 using media 10baseT, CSR12 is 51c8.
| May  4 14:38:01 callisto kernel: eth0: The transmitter stopped.  CSR5 is fc678106, CSR6 fffe2002, new CSR6 80020000.
| May  4 14:38:01 callisto kernel: eth0: 21143 link status interrupt 000011c4, CSR5 fc678106, ffffffff.
| May  4 14:38:09 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| May  4 14:38:09 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 00005108, CSR13 ffffef01, CSR14 ffffffff, resetting...
| May  4 14:38:09 callisto kernel: Staying on 10baseT
| May  4 14:38:09 callisto kernel: eth0: 21041 using media 10baseT, CSR12 is 51c8.
| May  4 14:38:09 callisto kernel: eth0: The transmitter stopped.  CSR5 is fc678106, CSR6 fffe2002, new CSR6 80020000.
| May  4 14:38:09 callisto kernel: eth0: 21143 link status interrupt 000011c4, CSR5 fc678106, ffffffff.
| May  4 14:38:18 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| May  4 14:38:18 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| May  4 14:38:18 callisto kernel: Staying on 10baseT
| May  4 14:38:18 callisto kernel: eth0: 21041 using media 10baseT, CSR12 is 51c8.
| May  4 14:38:18 callisto kernel: eth0: The transmitter stopped.  CSR5 is fc678106, CSR6 fffe2002, new CSR6 80020000.
| May  4 14:38:18 callisto kernel: eth0: 21143 link status interrupt 000011c4, CSR5 fc678106, ffffffff.
| May  4 14:38:26 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| May  4 14:38:26 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| May  4 14:38:26 callisto kernel: Staying on 10baseT
| May  4 14:38:26 callisto kernel: eth0: 21041 using media 10baseT, CSR12 is 51c8.
| May  4 14:38:26 callisto kernel: eth0: The transmitter stopped.  CSR5 is fc678106, CSR6 fffe2002, new CSR6 80020000.
| May  4 14:38:26 callisto kernel: eth0: 21143 link status interrupt 000011c4, CSR5 fc678106, ffffffff.
| May  4 14:38:30 callisto kernel: eth0: Media selection tick, 10baseT, status fc660000 mode fffe2002 SIA 000051c8 ffffef01 ffffffff ffff0008.
| May  4 14:38:30 callisto kernel: eth0: 21041 media tick  CSR12 000051c8.
| May  4 14:38:34 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| May  4 14:38:34 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| May  4 14:38:34 callisto kernel: Staying on 10baseT
| May  4 14:38:34 callisto kernel: eth0: 21041 using media 10baseT, CSR12 is 51c8.
| May  4 14:38:34 callisto kernel: eth0: The transmitter stopped.  CSR5 is fc678106, CSR6 fffe2002, new CSR6 80020000.
| May  4 14:38:34 callisto kernel: eth0: 21143 link status interrupt 000011c4, CSR5 fc678106, ffffffff.
| May  4 14:38:43 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| May  4 14:38:43 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| May  4 14:38:43 callisto kernel: Staying on 10baseT
| May  4 14:38:43 callisto kernel: eth0: 21041 using media 10baseT, CSR12 is 51c8.
| May  4 14:38:43 callisto kernel: eth0: The transmitter stopped.  CSR5 is fc678106, CSR6 fffe2002, new CSR6 80020000.
| May  4 14:38:43 callisto kernel: eth0: 21143 link status interrupt 000011c4, CSR5 fc678106, ffffffff.
| May  4 14:38:51 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| May  4 14:38:51 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 000051c8, CSR13 ffffef01, CSR14 ffffffff, resetting...
| May  4 14:38:51 callisto kernel: Staying on 10baseT
| May  4 14:38:51 callisto kernel: eth0: 21041 using media 10baseT, CSR12 is 51c8.
| May  4 14:38:51 callisto kernel: eth0: The transmitter stopped.  CSR5 is fc678106, CSR6 fffe2002, new CSR6 80020000.
| May  4 14:38:51 callisto kernel: eth0: 21143 link status interrupt 000011c4, CSR5 fc678106, ffffffff.
| May  4 14:38:59 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| May  4 14:38:59 callisto kernel: eth0: 21041 transmit timed out, status fc660000, CSR12 00005108, CSR13 ffffef01, CSR14 ffffffff, resetting...
| May  4 14:38:59 callisto kernel: Staying on 10baseT
| May  4 14:38:59 callisto kernel: eth0: 21041 using media 10baseT, CSR12 is 51c8.
| May  4 14:38:59 callisto kernel: eth0: The transmitter stopped.  CSR5 is fc678106, CSR6 fffe2002, new CSR6 80020000.
| May  4 14:38:59 callisto kernel: eth0: 21143 link status interrupt 000011c4, CSR5 fc678106, ffffffff.
| May  4 14:39:00 callisto kernel: eth0: Media selection tick, 10baseT, status fc260000 mode fffe2002 SIA 000011c4 ffffef01 ffffffff ffff0008.
| May  4 14:39:00 callisto kernel: eth0: 21041 media tick  CSR12 000011c4.
| May  4 14:39:00 callisto kernel: eth0: No 21041 10baseT link beat, Media switched to 10base2.

----> Here it lost the 10baseT link beat (why?), so it switches to 10base2

| May  4 14:39:08 callisto kernel: NETDEV WATCHDOG: eth0: transmit timed out
| May  4 14:39:08 callisto kernel: eth0: 21041 transmit timed out, status fc260010, CSR12 000052c8, CSR13 ffffef09, CSR14 fffff7fd, resetting...
| May  4 14:39:08 callisto kernel: Switching from port 1 to port 0<7>eth0: 21041 using media 10baseT, CSR12 is 52c8.

---> Here it switches back to 10baseT

| May  4 14:39:08 callisto kernel: eth0: 21143 link status interrupt 000010c4, CSR5 fc268110, ffffffff.
| May  4 14:39:10 callisto kernel: eth0: Media selection tick, 10baseT, status fc260000 mode fffe2002 SIA 000061c8 ffffef01 ffffffff ffff0008.
| May  4 14:39:10 callisto kernel: eth0: 21041 media tick  CSR12 000061c8.
| May  4 14:39:10 callisto kernel: eth0: Out-of-sync dirty pointer, 2922990 vs. 2923007.

----> Here the card has recoverd

| May  4 14:39:40 callisto kernel: eth0: Media selection tick, 10baseT, status fc360000 mode fffe2002 SIA 00005148 ffffef01 ffffffff ffff0008.
| May  4 14:39:40 callisto kernel: eth0: 21041 media tick  CSR12 00005148.

It still takes a few minutes to recover, but at least it recovers
automatically, and within the TCP timeout limit, so no connections are lost.

I tested this by transfering several gigabytes across the network using netcat,
and it always recovered without needing manual intervention.

So I suggest the following patch:

--- linux-2.4.20/drivers/net/tulip/tulip_core.c.orig	Tue Oct 29 18:41:48 2002
+++ linux-2.4.20/drivers/net/tulip/tulip_core.c	Sun May 11 11:31:29 2003
@@ -575,7 +575,7 @@
 					dev->if_port = 2 - dev->if_port;
 				} else
 					dev->if_port = 0;
-			else
+			else if (dev->if_port != 0 || (csr12 & 0x0004) != 0)
 				dev->if_port = 1;
 			tulip_select_media(dev, 0);
 		}

Any comments?

BTW, is there a version of the new de2104x driver in 2.5.x available for
2.4.20?

FYI, the debug code commented out with `#if defined(way_too_many_messages)'
doesn't work, but I haven't found out yet why exactly it crashes the kernel,
though.


Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

