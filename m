Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261873AbVASUWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbVASUWy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 15:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbVASUWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 15:22:44 -0500
Received: from waste.org ([216.27.176.166]:31657 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261868AbVASUWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 15:22:25 -0500
Date: Wed, 19 Jan 2005 12:22:20 -0800
From: Matt Mackall <mpm@selenic.com>
To: Roger Luethi <rl@hellgate.ch>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] use mmiowb in via-rhine
Message-ID: <20050119202220.GT12076@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the generic PCI memory barrier. Test-compiled.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: bk/drivers/net/via-rhine.c
===================================================================
--- bk.orig/drivers/net/via-rhine.c	2005-01-19 12:06:52.283455936 -0800
+++ bk/drivers/net/via-rhine.c	2005-01-19 12:18:02.536561976 -0800
@@ -351,9 +351,6 @@
  * indicator. In addition, Tx and Rx buffers need to 4 byte aligned.
  */
 
-/* Beware of PCI posted writes */
-#define IOSYNC	do { ioread8(ioaddr + StationAddr); } while (0)
-
 static struct pci_device_id rhine_pci_tbl[] =
 {
 	{0x1106, 0x3043, PCI_ANY_ID, PCI_ANY_ID, 0, 0, }, /* VT86C100A */
@@ -596,7 +593,7 @@
 	void __iomem *ioaddr = rp->base;
 
 	iowrite8(Cmd1Reset, ioaddr + ChipCmd1);
-	IOSYNC;
+	mmiowb();
 
 	if (ioread8(ioaddr + ChipCmd1) & Cmd1Reset) {
 		printk(KERN_INFO "%s: Reset not complete yet. "
@@ -1305,7 +1302,7 @@
 	/* Wake the potentially-idle transmit channel */
 	iowrite8(ioread8(ioaddr + ChipCmd1) | Cmd1TxDemand,
 	       ioaddr + ChipCmd1);
-	IOSYNC;
+	mmiowb();
 
 	if (rp->cur_tx == rp->dirty_tx + TX_QUEUE_LEN)
 		netif_stop_queue(dev);
@@ -1339,7 +1336,7 @@
 		if (intr_status & IntrTxDescRace)
 			iowrite8(0x08, ioaddr + IntrStatus2);
 		iowrite16(intr_status & 0xffff, ioaddr + IntrStatus);
-		IOSYNC;
+		mmiowb();
 
 		if (debug > 4)
 			printk(KERN_DEBUG "%s: Interrupt, status %8.8x.\n",
@@ -1602,7 +1599,7 @@
 		       ioaddr + ChipCmd);
 		iowrite8(ioread8(ioaddr + ChipCmd1) | Cmd1TxDemand,
 		       ioaddr + ChipCmd1);
-		IOSYNC;
+		mmiowb();
 	}
 	else {
 		/* This should never happen */

-- 
Mathematics is the supreme nostalgia of our time.
