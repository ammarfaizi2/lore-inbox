Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267216AbTAUUg0>; Tue, 21 Jan 2003 15:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267219AbTAUUg0>; Tue, 21 Jan 2003 15:36:26 -0500
Received: from hera.cwi.nl ([192.16.191.8]:30124 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S267216AbTAUUgW>;
	Tue, 21 Jan 2003 15:36:22 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 21 Jan 2003 21:45:28 +0100 (MET)
Message-Id: <UTC200301212045.h0LKjSp11532.aeb@smtp.cwi.nl>
To: jgarzik@pobox.com
Subject: 3c509.c
Cc: ALESSANDRO.SUARDI@oracle.com, efault@gmx.de, linux-kernel@vger.kernel.org,
       mzyngier@freesurf.fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Last Saturday or so I mentioned an Oops in __find_symbol in 2.5.59
and two people sent me Kai's patch. Thanks!

This evening the next attempt. Under 2.5.58 my ethernet cards
still work, under 2.5.59 eth0, a 3c509, fails.

(1) Started to read the source and come across

3c509.c:
----------
	/* Huh ? Can someone explain what is this for ? */
	if (dev->mem_end == 0x3c509 /* Magic key */ && ...
----------

An answer to that question is:
	See Documentation/networking/3c509.txt
(under "Special Driver Features").


(2) Reading el3_probe() one sees

3c509.c:
----------
static int __init el3_probe(int card_idx) {
	struct net_device *dev;

#ifdef CONFIG_MCA
	if( MCA_bus ) {
		for() {
			if(dev && ((dev->irq >= 1 && ...
		}
	}
#endif
----------

Funny. Since dev has a random value we must conclude that
this code is broken. Also, MCA_NOTFOUND is undefined.
Things improve with

#include <linux/mca-legacy.h>

at the start, and an assignment to dev (or this code involving
dev ripped out). Something like

--- .../linux-2.5.59/linux/drivers/net/3c509.c	Sat Jan 18 23:54:39 2003
+++ ./3c509.c	Tue Jan 21 20:37:10 2003
@@ -88,6 +88,7 @@
 #include <linux/ethtool.h>
 #include <linux/device.h>
 #include <linux/eisa.h>
+#include <linux/mca-legacy.h>
 
 #include <asm/uaccess.h>
 #include <asm/bitops.h>
@@ -398,14 +399,14 @@
 
 				ioaddr = ((short)((pos4&0xfc)|0x02)) << 8;
 				irq = pos5 & 0x0f;
-
+#if 0
 				/* probing for a card at a particular IO/IRQ */
 				if(dev && ((dev->irq >= 1 && dev->irq != irq) ||
 			   	(dev->base_addr >= 1 && dev->base_addr != ioaddr))) {
 					slot++;         /* probing next slot */
 					continue;
 				}
-
+#endif
 				printk("3c509: found %s at slot %d\n",
 					el3_mca_adapters[j].name, slot + 1 );
 



(3) In cases such as these, where ethernet cards get different names
than they had under the previous kernel, it is neccessary to find
out which name belongs to which card. An easy approach is
    dmesg | grep eth
For me this yields eth0, eth2 and eth3 but not eth1, a 3c900 Boomerang.
Indeed, the boot message only says about this animal:

<6>PCI: Found IRQ 11 for device 00:0d.0
<6>PCI: Sharing IRQ 11 with 00:07.2
<6>PCI: Sharing IRQ 11 with 00:09.0
<6>PCI: Sharing IRQ 11 with 00:09.1
<4>3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
<6>00:0d.0: 3Com PCI 3c900 Boomerang 10Mbps Combo at 0xb400. Vers LK1.1.18
<4>  ***WARNING*** No MII transceivers found!

but no MAC address, and no ethN number is given.
I consider this a bug (and submitted a patch a year ago or so).
Should I resubmit the patch?

Andries
