Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267685AbUBTBkG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 20:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267688AbUBTBkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 20:40:05 -0500
Received: from gate.crashing.org ([63.228.1.57]:11177 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267685AbUBTBjw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 20:39:52 -0500
Subject: [PATCH] Fix a DMA underrun problem with pmac IDE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1077240933.20788.814.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 20 Feb 2004 12:35:34 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch fixes the behaviour of the pmac "macio" IDE driver when
a DMA transfer happen to get less data out of the device than expected
when setting up the DMA commands (the device underruns). This is very
common with recent ATAPI stuffs and used to cause problem & disable
DMA. This patch fixes the way we handle that condition, thus also
fixing DVD burning on a bunch of recent pmacs.

Ben.

diff -urN linux-2.5/drivers/ide/ppc/pmac.c linuxppc-2.5-benh/drivers/ide/ppc/pmac.c
--- linux-2.5/drivers/ide/ppc/pmac.c	2004-02-20 11:26:47.653976368 +1100
+++ linuxppc-2.5-benh/drivers/ide/ppc/pmac.c	2004-02-18 17:20:22.861862968 +1100
@@ -55,7 +55,7 @@
 
 #define IDE_PMAC_DEBUG
 
-#define DMA_WAIT_TIMEOUT	100
+#define DMA_WAIT_TIMEOUT	50
 
 typedef struct pmac_ide_hwif {
 	unsigned long			regbase;
@@ -2026,8 +2026,11 @@
 	dstat = readl(&dma->status);
 	writel(((RUN|WAKE|DEAD) << 16), &dma->control);
 	pmac_ide_destroy_dmatable(drive);
-	/* verify good dma status */
-	return (dstat & (RUN|DEAD|ACTIVE)) != RUN;
+	/* verify good dma status. we don't check for ACTIVE beeing 0. We should...
+	 * in theory, but with ATAPI decices doing buffer underruns, that would
+	 * cause us to disable DMA, which isn't what we want
+	 */
+	return (dstat & (RUN|DEAD)) != RUN;
 }
 
 /*
@@ -2041,7 +2044,7 @@
 {
 	pmac_ide_hwif_t* pmif = (pmac_ide_hwif_t *)HWIF(drive)->hwif_data;
 	volatile struct dbdma_regs *dma;
-	unsigned long status;
+	unsigned long status, timeout;
 
 	if (pmif == NULL)
 		return 0;
@@ -2057,17 +2060,8 @@
 	 * - The dbdma fifo hasn't yet finished flushing to
 	 * to system memory when the disk interrupt occurs.
 	 * 
-	 * The trick here is to increment drive->waiting_for_dma,
-	 * and return as if no interrupt occurred. If the counter
-	 * reach a certain timeout value, we then return 1. If
-	 * we really got the interrupt, it will happen right away
-	 * again.
-	 * Apple's solution here may be more elegant. They issue
-	 * a DMA channel interrupt (a separate irq line) via a DBDMA
-	 * NOP command just before the STOP, and wait for both the
-	 * disk and DBDMA interrupts to have completed.
 	 */
- 
+
 	/* If ACTIVE is cleared, the STOP command have passed and
 	 * transfer is complete.
 	 */
@@ -2079,15 +2073,26 @@
 			called while not waiting\n", HWIF(drive)->index);
 
 	/* If dbdma didn't execute the STOP command yet, the
-	 * active bit is still set */
-	drive->waiting_for_dma++;
-	if (drive->waiting_for_dma >= DMA_WAIT_TIMEOUT) {
-		printk(KERN_WARNING "ide%d, timeout waiting \
-			for dbdma command stop\n", HWIF(drive)->index);
-		return 1;
-	}
-	udelay(5);
-	return 0;
+	 * active bit is still set. We consider that we aren't
+	 * sharing interrupts (which is hopefully the case with
+	 * those controllers) and so we just try to flush the
+	 * channel for pending data in the fifo
+	 */
+	udelay(1);
+	writel((FLUSH << 16) | FLUSH, &dma->control);
+	timeout = 0;
+	for (;;) {
+		udelay(1);
+		status = readl(&dma->status);
+		if ((status & FLUSH) == 0)
+			break;
+		if (++timeout > 100) {
+			printk(KERN_WARNING "ide%d, ide_dma_test_irq \
+			timeout flushing channel\n", HWIF(drive)->index);
+			break;
+		}
+	}	
+	return 1;
 }
 
 static int __pmac


