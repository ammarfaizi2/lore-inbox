Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317267AbSFXEEc>; Mon, 24 Jun 2002 00:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317268AbSFXEEb>; Mon, 24 Jun 2002 00:04:31 -0400
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:10763 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S317267AbSFXEEa>;
	Mon, 24 Jun 2002 00:04:30 -0400
Date: Sun, 23 Jun 2002 23:48:39 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: [PATCH] 2.5.24 : drivers/scsi/gdth.c
Message-ID: <Pine.LNX.4.44.0206232346240.909-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
 This patch adds the DMA mapping checking code, and reduces some 
redundancy. Please review.
Regards,
Frank

--- drivers/scsi/gdth.c.old	Wed Feb 13 21:26:59 2002
+++ drivers/scsi/gdth.c	Sun Jun 23 23:41:10 2002
@@ -827,10 +827,18 @@
     TRACE(("gdth_search_dev() cnt %d vendor %x device %x\n",
           *cnt, vendor, device));
 
-#if LINUX_VERSION_CODE >= 0x20363
+#if LINUX_VERSION_CODE >= 0x2015C
     pdev = NULL;
     while ((pdev = pci_find_device(vendor, device, pdev)) 
            != NULL) {
+	    if(pci_set_dma_mask(pdev, 0xffffffff))
+	    {
+		printk(KERN_WARNING "gdth : No suitable DMA available\n");
+	    }
+
+#endif
+
+#if LINUX_VERSION_CODE >= 0x20363
         if (pci_enable_device(pdev))
             continue;
         if (*cnt >= MAXHA)
@@ -866,11 +874,8 @@
         (*cnt)++;
     }       
 #elif LINUX_VERSION_CODE >= 0x2015C
-    pdev = NULL;
-    while ((pdev = pci_find_device(vendor, device, pdev)) 
-           != NULL) {
-        if (*cnt >= MAXHA)
-            return;
+    if (*cnt >= MAXHA)
+       return;
         /* GDT PCI controller found, resources are already in pdev */
         pcistr[*cnt].pdev = pdev;
         pcistr[*cnt].vendor_id = vendor;

