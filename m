Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131643AbQKAVDh>; Wed, 1 Nov 2000 16:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131642AbQKAVDU>; Wed, 1 Nov 2000 16:03:20 -0500
Received: from [193.205.41.225] ([193.205.41.225]:28545 "EHLO
	banach.dmf.bs.unicatt.it") by vger.kernel.org with ESMTP
	id <S131627AbQKAVDO>; Wed, 1 Nov 2000 16:03:14 -0500
Date: Wed, 1 Nov 2000 22:03:05 +0100
From: Luca Giuzzi <giuzzi@dmf.bs.unicatt.it>
Message-Id: <200011012103.eA1L35D03854@banach.dmf.bs.unicatt.it>
To: jarek@swipnet.se, linux-kernel@vger.kernel.org
Subject: Re: Oops in test10 during module loading of 3c509
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems the cleaning up of the network drivers has been a tad too
 aggressive :) There is no init_etherdev() anymore in 3c509.c

The following patch seems to solve the problem.
(the code is taken from a working test10pre5)

Cheers,
 lg

--- 3c509.c.test10-broken	Wed Nov  1 17:12:08 2000
+++ 3c509.c	Wed Nov  1 17:13:37 2000
@@ -434,6 +434,13 @@
 	/* Free the interrupt so that some other card can use it. */
 	outw(0x0f00, ioaddr + WN0_IRQ);
  found:
+        if (dev == NULL) {
+                dev = init_etherdev(dev, sizeof(struct el3_private));
+                if (dev == NULL) {
+                        release_region(ioaddr, EL3_IO_EXTENT);
+                        return -ENOMEM;
+                }
+        }
 	memcpy(dev->dev_addr, phys_addr, sizeof(phys_addr));
 	dev->base_addr = ioaddr;
 	dev->irq = irq;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
