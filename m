Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267405AbRGTVd3>; Fri, 20 Jul 2001 17:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267408AbRGTVdU>; Fri, 20 Jul 2001 17:33:20 -0400
Received: from [209.182.168.213] ([209.182.168.213]:46599 "EHLO
	draco.foogod.com") by vger.kernel.org with ESMTP id <S267405AbRGTVdG>;
	Fri, 20 Jul 2001 17:33:06 -0400
Date: Fri, 20 Jul 2001 14:32:47 -0700
From: alex@foogod.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH] eepro100 and IFF_RUNNING under 2.4
Message-ID: <20010720143247.A6596@draco.foogod.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
X-Mailer: Mutt 1.0pre3us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii

Hiho..  While working on some code which tries to monitor physical link status
for ethernet interfaces, I noticed that apparently under the 2.4 kernel, the
eepro100 driver does not reflect link status with the IFF_RUNNING flag as it
used to under 2.2.x.

It looks like a bit of the code in eepro100.c didn't get updated to reflect
some interface changes that happened somewhere in 2.3, so here is a patch which
should fix things (It also adds a bit of code to set things properly on startup as well, patch is against kernel 2.4.6).

(I'm not quite sure who to send this to, so I'm sending it to the list)

-alex

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="eepro100_linkstate24.patch"

--- drivers/net/eepro100.c.orig	Mon Jul  2 14:03:04 2001
+++ drivers/net/eepro100.c	Fri Jul 20 13:28:20 2001
@@ -976,6 +976,11 @@
 	if ((sp->phy[0] & 0x8000) == 0)
 		sp->advertising = mdio_read(ioaddr, sp->phy[0] & 0x1f, 4);
 
+	if (mdio_read(ioaddr, sp->phy[0], 1) & 0x0004)
+		netif_carrier_on(dev);
+	else
+		netif_carrier_off(dev);
+
 	if (speedo_debug > 2) {
 		printk(KERN_DEBUG "%s: Done speedo_open(), status %8.8x.\n",
 			   dev->name, inw(ioaddr + SCBStatus));
@@ -1088,9 +1093,9 @@
 			mdio_read(ioaddr, phy_num, 1);
 			/* If link beat has returned... */
 			if (mdio_read(ioaddr, phy_num, 1) & 0x0004)
-				dev->flags |= IFF_RUNNING;
+				netif_carrier_on(dev);
 			else
-				dev->flags &= ~IFF_RUNNING;
+				netif_carrier_off(dev);
 		}
 	}
 	if (speedo_debug > 3) {

--gKMricLos+KVdGMg--
