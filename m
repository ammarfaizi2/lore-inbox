Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbRCTX0Q>; Tue, 20 Mar 2001 18:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129115AbRCTX0H>; Tue, 20 Mar 2001 18:26:07 -0500
Received: from laurin.munich.netsurf.de ([194.64.166.1]:25052 "EHLO
	laurin.munich.netsurf.de") by vger.kernel.org with ESMTP
	id <S129066AbRCTX0D>; Tue, 20 Mar 2001 18:26:03 -0500
Date: Tue, 20 Mar 2001 23:49:42 +0100
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ieee1394 pcilynx.c SMP fix
Message-ID: <20010320234942.A3191@storm.local>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Andreas Bombe <andreas.bombe@munich.netsurf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Due to a brain malfunction spinlocks were used in pcilynx.c before they
were initialized, causing SMP systems to deadlock.  The patch fixes this
and removes one second/redundant initialization of another lock.


diff -ruN linux-2.4.linus/drivers/ieee1394/pcilynx.c linux-2.4/drivers/ieee1394/pcilynx.c
--- linux-2.4.linus/drivers/ieee1394/pcilynx.c	Mon Feb 26 01:39:30 2001
+++ linux-2.4/drivers/ieee1394/pcilynx.c	Wed Mar 14 01:00:13 2001
@@ -470,8 +470,6 @@
         lynx->phy_reg0 = -1;
 
         lynx->async.queue = NULL;
-        spin_lock_init(&lynx->async.queue_lock);
-        spin_lock_init(&lynx->phy_reg_lock);
         
         pcl.next = pcl_bus(lynx, lynx->rcv_pcl);
         put_pcl(lynx, lynx->rcv_pcl_start, &pcl);
@@ -1357,6 +1355,9 @@
         lynx->id = num_of_cards-1;
         lynx->dev = dev;
 
+        lynx->lock = SPIN_LOCK_UNLOCKED;
+        lynx->phy_reg_lock = SPIN_LOCK_UNLOCKED;
+
         if (!pci_dma_supported(dev, 0xffffffff)) {
                 FAIL("DMA address limits not supported for PCILynx hardware %d",
                      lynx->id);
@@ -1456,8 +1457,6 @@
         lynx->iso_rcv.pcl_start = alloc_pcl(lynx);
 
         /* all allocations successful - simple init stuff follows */
-
-        lynx->lock = SPIN_LOCK_UNLOCKED;
 
         reg_write(lynx, PCI_INT_ENABLE, PCI_INT_DMA_ALL);
 


-- 
 Andreas E. Bombe <andreas.bombe@munich.netsurf.de>    DSA key 0x04880A44
http://home.pages.de/~andreas.bombe/    http://linux1394.sourceforge.net/
