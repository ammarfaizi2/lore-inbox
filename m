Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbTFOQSI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 12:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262348AbTFOQSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 12:18:08 -0400
Received: from m239.net195-132-57.noos.fr ([195.132.57.239]:34692 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP id S262358AbTFOQRy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 12:17:54 -0400
Date: Sun, 15 Jun 2003 18:31:38 +0200
From: Stelian Pop <stelian@popies.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4.21] meye driver update
Message-ID: <20030615163138.GD1857@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is my latest meye driver version, ready to be integrated
in the next -pre cycle.

The attached patch:
* replaces the pci_alloc_consistent calls with dma_alloc_coherent
  because we want to do the allocations at GFP_KERNEL priority and
  not GFP_ATOMIC because we request quite a bit of memory and the
  allocation fails quite frequently.

  It would be better to have a pci_alloc_consistent with an extra
  parameter (priority) but since we haven't, and the meye driver is
  supposed to work only on ix86 platforms we can safely do the
  change. Moreover, in 2.4 we don't even have a dma_alloc_coherent
  function, so the meye driver is carrying a local version, 
  backported from 2.5.

* fixes the DMA engine stop request. The hard freezes encountered
  when using this driver and repeatedly opening/closing the device
  have been tracked down to this particular piece of code. The new
  version seems to work way better, I haven't had a single freeze
  since the change.

Marcelo, please apply.

Stelian.

===== drivers/media/video/meye.h 1.7 vs edited =====
--- 1.7/drivers/media/video/meye.h	Fri Feb 21 11:24:07 2003
+++ edited/drivers/media/video/meye.h	Tue Jun 10 11:18:50 2003
@@ -31,7 +31,7 @@
 #define _MEYE_PRIV_H_
 
 #define MEYE_DRIVER_MAJORVERSION	1
-#define MEYE_DRIVER_MINORVERSION	6
+#define MEYE_DRIVER_MINORVERSION	7
 
 #include <linux/config.h>
 #include <linux/types.h>
===== drivers/media/video/meye.c 1.13 vs edited =====
--- 1.13/drivers/media/video/meye.c	Tue Feb 18 12:31:10 2003
+++ edited/drivers/media/video/meye.c	Thu Apr 17 10:23:00 2003
@@ -161,6 +161,34 @@
 	}
 }
 
+/****************************************************************************/
+/* dma_alloc_coherent / dma_free_coherent ported from 2.5                  */
+/****************************************************************************/
+
+void *dma_alloc_coherent(struct pci_dev *dev, size_t size,
+                           dma_addr_t *dma_handle, int gfp)
+{
+        void *ret;
+        /* ignore region specifiers */
+        gfp &= ~(__GFP_DMA | __GFP_HIGHMEM);
+
+        if (dev == NULL || ((u32)dev->dma_mask < 0xffffffff))
+                gfp |= GFP_DMA;
+        ret = (void *)__get_free_pages(gfp, get_order(size));
+
+        if (ret != NULL) { 
+                memset(ret, 0, size);
+                *dma_handle = virt_to_phys(ret);
+        }       
+        return ret;
+}
+
+void dma_free_coherent(struct pci_dev *dev, size_t size,
+                         void *vaddr, dma_addr_t dma_handle)
+{
+        free_pages((unsigned long)vaddr, get_order(size));
+}
+
 /* return a page table pointing to N pages of locked memory */
 static int ptable_alloc(void) {
 	u32 *pt;
@@ -168,9 +196,10 @@
 
 	memset(meye.mchip_ptable, 0, sizeof(meye.mchip_ptable));
 
-	meye.mchip_ptable[MCHIP_NB_PAGES] = pci_alloc_consistent(meye.mchip_dev, 
-								 PAGE_SIZE, 
-								 &meye.mchip_dmahandle);
+	meye.mchip_ptable[MCHIP_NB_PAGES] = dma_alloc_coherent(meye.mchip_dev, 
+							       PAGE_SIZE, 
+							       &meye.mchip_dmahandle,
+							       GFP_KERNEL);
 	if (!meye.mchip_ptable[MCHIP_NB_PAGES]) {
 		meye.mchip_dmahandle = 0;
 		return -1;
@@ -178,16 +207,17 @@
 
 	pt = (u32 *)meye.mchip_ptable[MCHIP_NB_PAGES];
 	for (i = 0; i < MCHIP_NB_PAGES; i++) {
-		meye.mchip_ptable[i] = pci_alloc_consistent(meye.mchip_dev, 
-							    PAGE_SIZE,
-							    pt);
+		meye.mchip_ptable[i] = dma_alloc_coherent(meye.mchip_dev, 
+							  PAGE_SIZE,
+							  pt,
+							  GFP_KERNEL);
 		if (!meye.mchip_ptable[i]) {
 			int j;
 			pt = (u32 *)meye.mchip_ptable[MCHIP_NB_PAGES];
 			for (j = 0; j < i; ++j) {
-				pci_free_consistent(meye.mchip_dev,
-						    PAGE_SIZE,
-						    meye.mchip_ptable[j], *pt);
+				dma_free_coherent(meye.mchip_dev,
+						  PAGE_SIZE,
+						  meye.mchip_ptable[j], *pt);
 				pt++;
 			}
 			meye.mchip_dmahandle = 0;
@@ -205,17 +235,17 @@
 	pt = (u32 *)meye.mchip_ptable[MCHIP_NB_PAGES];
 	for (i = 0; i < MCHIP_NB_PAGES; i++) {
 		if (meye.mchip_ptable[i])
-			pci_free_consistent(meye.mchip_dev, 
-					    PAGE_SIZE, 
-					    meye.mchip_ptable[i], *pt);
+			dma_free_coherent(meye.mchip_dev, 
+					  PAGE_SIZE, 
+					  meye.mchip_ptable[i], *pt);
 		pt++;
 	}
 
 	if (meye.mchip_ptable[MCHIP_NB_PAGES])
-		pci_free_consistent(meye.mchip_dev, 
-				    PAGE_SIZE, 
-				    meye.mchip_ptable[MCHIP_NB_PAGES], 
-				    meye.mchip_dmahandle);
+		dma_free_coherent(meye.mchip_dev, 
+				  PAGE_SIZE, 
+				  meye.mchip_ptable[MCHIP_NB_PAGES],
+				  meye.mchip_dmahandle);
 
 	memset(meye.mchip_ptable, 0, sizeof(meye.mchip_ptable));
 	meye.mchip_dmahandle = 0;
@@ -614,25 +644,25 @@
 /* stop any existing HIC action and wait for any dma to complete then
    reset the dma engine */
 static void mchip_hic_stop(void) {
-	int i = 0;
+	int i, j;
 
 	meye.mchip_mode = MCHIP_HIC_MODE_NOOP;
-	if (!(mchip_read(MCHIP_HIC_STATUS) & MCHIP_HIC_STATUS_BUSY)) 
+	if (!(mchip_read(MCHIP_HIC_STATUS) & MCHIP_HIC_STATUS_BUSY))
 		return;
-	mchip_set(MCHIP_HIC_CMD, MCHIP_HIC_CMD_STOP);
-	mchip_delay(MCHIP_HIC_CMD, 0);
-	while (!mchip_delay(MCHIP_HIC_STATUS, MCHIP_HIC_STATUS_IDLE)) {
-		/*  resetting HIC */
+	for (i = 0; i < 20; ++i) {
 		mchip_set(MCHIP_HIC_CMD, MCHIP_HIC_CMD_STOP);
 		mchip_delay(MCHIP_HIC_CMD, 0);
+		for (j = 0; j < 100; ++j) {
+			if (mchip_delay(MCHIP_HIC_STATUS, MCHIP_HIC_STATUS_IDLE))
+				return;
+			wait_ms(1);
+		}
+		printk(KERN_ERR "meye: need to reset HIC!\n");
+	
 		mchip_set(MCHIP_HIC_CTL, MCHIP_HIC_CTL_SOFT_RESET);
 		wait_ms(250);
-		if (i++ > 20) {
-			printk(KERN_ERR "meye: resetting HIC hanged!\n");
-			break;
-		}
 	}
-	wait_ms(100);
+	printk(KERN_ERR "meye: resetting HIC hanged!\n");
 }
 
 /****************************************************************************/
@@ -1392,6 +1422,8 @@
 
 	mchip_hic_stop();
 
+	mchip_dma_free();
+
 	/* disable interrupts */
 	mchip_set(MCHIP_MM_INTA, 0x0);
 
@@ -1403,8 +1435,6 @@
 			   pci_resource_len(meye.mchip_dev, 0));
 
 	pci_disable_device(meye.mchip_dev);
-
-	mchip_dma_free();
 
 	if (meye.grab_fbuffer)
 		rvfree(meye.grab_fbuffer, gbuffers*gbufsize);


-- 
Stelian Pop <stelian@popies.net>
