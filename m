Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbTFOQLn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 12:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262340AbTFOQLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 12:11:42 -0400
Received: from m239.net195-132-57.noos.fr ([195.132.57.239]:20868 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP id S262331AbTFOQLQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 12:11:16 -0400
Date: Sun, 15 Jun 2003 18:25:03 +0200
From: Stelian Pop <stelian@popies.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.71 RESEND] meye driver update
Message-ID: <20030615162502.GB1857@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The attached patch:
  
* replaces the pci_alloc_consistent calls with dma_alloc_coherent
  because we want to do the allocations at GFP_KERNEL priority and
  not GFP_ATOMIC because we request quite a bit of memory and the
  allocation fails quite frequently.

  It would be better to have a pci_alloc_consistent with an extra
  parameter (priority) but since we haven't, and the meye driver is
  supposed to work only on ix86 platforms we can safely do the
  change.

* fixes the DMA engine stop request. The hard freezes encountered
  when using this driver and repeatedly opening/closing the device
  have been tracked down to this particular piece of code. The new
  version seems to work way better, I haven't had a single freeze
  since the change.

* fixes the irq handler prototype (irqreturn_t changes).

Linus, please apply.

Stelian.

===== drivers/media/video/meye.h 1.7 vs edited =====
--- 1.7/drivers/media/video/meye.h	Tue Feb 18 12:30:51 2003
+++ edited/drivers/media/video/meye.h	Wed Apr 16 10:01:38 2003
@@ -31,7 +31,7 @@
 #define _MEYE_PRIV_H_
 
 #define MEYE_DRIVER_MAJORVERSION	1
-#define MEYE_DRIVER_MINORVERSION	6
+#define MEYE_DRIVER_MINORVERSION	7
 
 #include <linux/config.h>
 #include <linux/types.h>
===== drivers/media/video/meye.c 1.16 vs edited =====
--- 1.16/drivers/media/video/meye.c	Thu Apr 24 12:35:17 2003
+++ edited/drivers/media/video/meye.c	Fri Apr 25 09:25:01 2003
@@ -167,9 +167,10 @@
 
 	memset(meye.mchip_ptable, 0, sizeof(meye.mchip_ptable));
 
-	meye.mchip_ptable[MCHIP_NB_PAGES] = pci_alloc_consistent(meye.mchip_dev, 
-								 PAGE_SIZE, 
-								 &meye.mchip_dmahandle);
+	meye.mchip_ptable[MCHIP_NB_PAGES] = dma_alloc_coherent(&meye.mchip_dev->dev, 
+							       PAGE_SIZE, 
+							       &meye.mchip_dmahandle,
+							       GFP_KERNEL);
 	if (!meye.mchip_ptable[MCHIP_NB_PAGES]) {
 		meye.mchip_dmahandle = 0;
 		return -1;
@@ -177,16 +178,17 @@
 
 	pt = (u32 *)meye.mchip_ptable[MCHIP_NB_PAGES];
 	for (i = 0; i < MCHIP_NB_PAGES; i++) {
-		meye.mchip_ptable[i] = pci_alloc_consistent(meye.mchip_dev, 
-							    PAGE_SIZE,
-							    pt);
+		meye.mchip_ptable[i] = dma_alloc_coherent(&meye.mchip_dev->dev, 
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
+				dma_free_coherent(&meye.mchip_dev->dev,
+						  PAGE_SIZE,
+						  meye.mchip_ptable[j], *pt);
 				pt++;
 			}
 			meye.mchip_dmahandle = 0;
@@ -204,17 +206,17 @@
 	pt = (u32 *)meye.mchip_ptable[MCHIP_NB_PAGES];
 	for (i = 0; i < MCHIP_NB_PAGES; i++) {
 		if (meye.mchip_ptable[i])
-			pci_free_consistent(meye.mchip_dev, 
-					    PAGE_SIZE, 
-					    meye.mchip_ptable[i], *pt);
+			dma_free_coherent(&meye.mchip_dev->dev, 
+					  PAGE_SIZE, 
+					  meye.mchip_ptable[i], *pt);
 		pt++;
 	}
 
 	if (meye.mchip_ptable[MCHIP_NB_PAGES])
-		pci_free_consistent(meye.mchip_dev, 
-				    PAGE_SIZE, 
-				    meye.mchip_ptable[MCHIP_NB_PAGES], 
-				    meye.mchip_dmahandle);
+		dma_free_coherent(&meye.mchip_dev->dev, 
+				  PAGE_SIZE, 
+				  meye.mchip_ptable[MCHIP_NB_PAGES],
+				  meye.mchip_dmahandle);
 
 	memset(meye.mchip_ptable, 0, sizeof(meye.mchip_ptable));
 	meye.mchip_dmahandle = 0;
@@ -613,25 +615,25 @@
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
@@ -832,7 +834,7 @@
 /* Interrupt handling                                                       */
 /****************************************************************************/
 
-static void meye_irq(int irq, void *dev_id, struct pt_regs *regs) {
+static irqreturn_t meye_irq(int irq, void *dev_id, struct pt_regs *regs) {
 	u32 v;
 	int reqnr;
 	v = mchip_read(MCHIP_MM_INTA);
@@ -840,7 +842,7 @@
 	while (1) {
 		v = mchip_get_frame();
 		if (!(v & MCHIP_MM_FIR_RDY))
-			return;
+			return IRQ_NONE;
 		switch (meye.mchip_mode) {
 
 		case MCHIP_HIC_MODE_CONT_OUT:
@@ -873,11 +875,12 @@
 
 		default:
 			/* do not free frame, since it can be a snap */
-			return;
+			return IRQ_NONE;
 		} /* switch */
 
 		mchip_free_frame();
 	}
+	return IRQ_HANDLED;
 }
 
 /****************************************************************************/
@@ -1391,6 +1394,8 @@
 
 	mchip_hic_stop();
 
+	mchip_dma_free();
+
 	/* disable interrupts */
 	mchip_set(MCHIP_MM_INTA, 0x0);
 
@@ -1402,8 +1407,6 @@
 			   pci_resource_len(meye.mchip_dev, 0));
 
 	pci_disable_device(meye.mchip_dev);
-
-	mchip_dma_free();
 
 	if (meye.grab_fbuffer)
 		rvfree(meye.grab_fbuffer, gbuffers*gbufsize);
-- 
Stelian Pop <stelian@popies.net>
