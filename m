Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751880AbWGAPLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880AbWGAPLK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 11:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751877AbWGAO5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 10:57:17 -0400
Received: from www.osadl.org ([213.239.205.134]:40612 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751621AbWGAO5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:57:11 -0400
Message-Id: <20060701145225.418238000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:54:41 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, lethal@linux-sh.org
Subject: [RFC][patch 19/44] SH: Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-sh.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use the new IRQF_ constants and remove the SA_INTERRUPT define

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 arch/sh/boards/snapgear/setup.c        |    2 +-
 arch/sh/cchips/hd6446x/hd64461/setup.c |    2 +-
 arch/sh/cchips/hd6446x/hd64465/gpio.c  |    2 +-
 arch/sh/cchips/hd6446x/hd64465/setup.c |    2 +-
 arch/sh/cchips/voyagergx/irq.c         |    2 +-
 arch/sh/drivers/dma/dma-g2.c           |    2 +-
 arch/sh/drivers/dma/dma-pvr2.c         |    2 +-
 arch/sh/drivers/dma/dma-sh.c           |    4 ++--
 arch/sh/drivers/pci/pci-st40.c         |    2 +-
 arch/sh/kernel/timers/timer-tmu.c      |    2 +-
 include/asm-sh/floppy.h                |    9 ++++-----
 include/asm-sh/mpc1211/keyboard.h      |    2 +-
 include/asm-sh/signal.h                |    2 --
 13 files changed, 16 insertions(+), 19 deletions(-)

Index: linux-2.6.git/include/asm-sh/floppy.h
===================================================================
--- linux-2.6.git.orig/include/asm-sh/floppy.h	2006-07-01 16:51:23.000000000 +0200
+++ linux-2.6.git/include/asm-sh/floppy.h	2006-07-01 16:51:36.000000000 +0200
@@ -146,12 +146,11 @@ static int vdma_get_dma_residue(unsigned
 static int fd_request_irq(void)
 {
 	if(can_use_virtual_dma)
-		return request_irq(FLOPPY_IRQ, floppy_hardint,SA_INTERRUPT,
-				   "floppy", NULL);
+		return request_irq(FLOPPY_IRQ, floppy_hardint,
+				   IRQF_DISABLED, "floppy", NULL);
 	else
-		return request_irq(FLOPPY_IRQ, floppy_interrupt, SA_INTERRUPT,
-				   "floppy", NULL);
-
+		return request_irq(FLOPPY_IRQ, floppy_interrupt,
+				   IRQF_DISABLED, "floppy", NULL);
 }
 
 static unsigned long dma_mem_alloc(unsigned long size)
Index: linux-2.6.git/include/asm-sh/signal.h
===================================================================
--- linux-2.6.git.orig/include/asm-sh/signal.h	2006-07-01 16:51:23.000000000 +0200
+++ linux-2.6.git/include/asm-sh/signal.h	2006-07-01 16:51:36.000000000 +0200
@@ -75,7 +75,6 @@ typedef unsigned long sigset_t;
  * SA_FLAGS values:
  *
  * SA_ONSTACK indicates that a registered stack_t will be used.
- * SA_INTERRUPT is a no-op, but left due to historical reasons. Use the
  * SA_RESTART flag to get restarting signals (which were the default long ago)
  * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
  * SA_RESETHAND clears the handler when the signal is delivered.
@@ -95,7 +94,6 @@ typedef unsigned long sigset_t;
 
 #define SA_NOMASK	SA_NODEFER
 #define SA_ONESHOT	SA_RESETHAND
-#define SA_INTERRUPT	0x20000000 /* dummy -- ignored */
 
 #define SA_RESTORER	0x04000000
 
Index: linux-2.6.git/include/asm-sh/mpc1211/keyboard.h
===================================================================
--- linux-2.6.git.orig/include/asm-sh/mpc1211/keyboard.h	2006-07-01 16:51:23.000000000 +0200
+++ linux-2.6.git/include/asm-sh/mpc1211/keyboard.h	2006-07-01 16:51:36.000000000 +0200
@@ -57,7 +57,7 @@ extern unsigned char pckbd_sysrq_xlate[1
 #define AUX_IRQ 12
 
 #define aux_request_irq(hand, dev_id)					\
-	request_irq(AUX_IRQ, hand, SA_SHIRQ, "PS2 Mouse", dev_id)
+	request_irq(AUX_IRQ, hand, IRQF_SHARED, "PS2 Mouse", dev_id)
 
 #define aux_free_irq(dev_id) free_irq(AUX_IRQ, dev_id)
 
Index: linux-2.6.git/arch/sh/boards/snapgear/setup.c
===================================================================
--- linux-2.6.git.orig/arch/sh/boards/snapgear/setup.c	2006-07-01 16:51:23.000000000 +0200
+++ linux-2.6.git/arch/sh/boards/snapgear/setup.c	2006-07-01 16:51:36.000000000 +0200
@@ -50,7 +50,7 @@ static int __init eraseconfig_init(void)
 {
 	printk("SnapGear: EraseConfig init\n");
 	/* Setup "EraseConfig" switch on external IRQ 0 */
-	if (request_irq(IRL0_IRQ, eraseconfig_interrupt, SA_INTERRUPT,
+	if (request_irq(IRL0_IRQ, eraseconfig_interrupt, IRQF_DISABLED,
 				"Erase Config", NULL))
 		printk("SnapGear: failed to register IRQ%d for Reset witch\n",
 				IRL0_IRQ);
Index: linux-2.6.git/arch/sh/cchips/hd6446x/hd64461/setup.c
===================================================================
--- linux-2.6.git.orig/arch/sh/cchips/hd6446x/hd64461/setup.c	2006-07-01 16:51:23.000000000 +0200
+++ linux-2.6.git/arch/sh/cchips/hd6446x/hd64461/setup.c	2006-07-01 16:51:36.000000000 +0200
@@ -133,7 +133,7 @@ int hd64461_irq_demux(int irq)
 	return __irq_demux(irq);
 }
 
-static struct irqaction irq0 = { hd64461_interrupt, SA_INTERRUPT, CPU_MASK_NONE, "HD64461", NULL, NULL };
+static struct irqaction irq0 = { hd64461_interrupt, IRQF_DISABLED, CPU_MASK_NONE, "HD64461", NULL, NULL };
 
 int __init setup_hd64461(void)
 {
Index: linux-2.6.git/arch/sh/cchips/hd6446x/hd64465/gpio.c
===================================================================
--- linux-2.6.git.orig/arch/sh/cchips/hd6446x/hd64465/gpio.c	2006-07-01 16:51:23.000000000 +0200
+++ linux-2.6.git/arch/sh/cchips/hd6446x/hd64465/gpio.c	2006-07-01 16:51:36.000000000 +0200
@@ -170,7 +170,7 @@ static int __init hd64465_gpio_init(void
 	if (!request_region(HD64465_REG_GPACR, 0x1000, MODNAME))
 		return -EBUSY;
 	if (request_irq(HD64465_IRQ_GPIO, hd64465_gpio_interrupt,
-	    		SA_INTERRUPT, MODNAME, 0))
+	    		IRQF_DISABLED, MODNAME, 0))
 		goto out_irqfailed;
 
     	printk("HD64465 GPIO layer on irq %d\n", HD64465_IRQ_GPIO);
Index: linux-2.6.git/arch/sh/cchips/hd6446x/hd64465/setup.c
===================================================================
--- linux-2.6.git.orig/arch/sh/cchips/hd6446x/hd64465/setup.c	2006-07-01 16:51:23.000000000 +0200
+++ linux-2.6.git/arch/sh/cchips/hd6446x/hd64465/setup.c	2006-07-01 16:51:36.000000000 +0200
@@ -153,7 +153,7 @@ int hd64465_irq_demux(int irq)
 	return irq;
 }
 
-static struct irqaction irq0  = { hd64465_interrupt, SA_INTERRUPT, CPU_MASK_NONE, "HD64465", NULL, NULL};
+static struct irqaction irq0  = { hd64465_interrupt, IRQF_DISABLED, CPU_MASK_NONE, "HD64465", NULL, NULL};
 
 
 static int __init setup_hd64465(void)
Index: linux-2.6.git/arch/sh/cchips/voyagergx/irq.c
===================================================================
--- linux-2.6.git.orig/arch/sh/cchips/voyagergx/irq.c	2006-07-01 16:51:23.000000000 +0200
+++ linux-2.6.git/arch/sh/cchips/voyagergx/irq.c	2006-07-01 16:51:36.000000000 +0200
@@ -165,7 +165,7 @@ int voyagergx_irq_demux(int irq)
 static struct irqaction irq0  = {
 	.name		= "voyagergx",
 	.handler	= voyagergx_interrupt,
-	.flags		= SA_INTERRUPT,
+	.flags		= IRQF_DISABLED,
 	.mask		= CPU_MASK_NONE,
 };
 
Index: linux-2.6.git/arch/sh/drivers/dma/dma-g2.c
===================================================================
--- linux-2.6.git.orig/arch/sh/drivers/dma/dma-g2.c	2006-07-01 16:51:23.000000000 +0200
+++ linux-2.6.git/arch/sh/drivers/dma/dma-g2.c	2006-07-01 16:51:36.000000000 +0200
@@ -56,7 +56,7 @@ static irqreturn_t g2_dma_interrupt(int 
 static struct irqaction g2_dma_irq = {
 	.name		= "g2 DMA handler",
 	.handler	= g2_dma_interrupt,
-	.flags		= SA_INTERRUPT,
+	.flags		= IRQF_DISABLED,
 };
 
 static int g2_enable_dma(struct dma_channel *chan)
Index: linux-2.6.git/arch/sh/drivers/dma/dma-pvr2.c
===================================================================
--- linux-2.6.git.orig/arch/sh/drivers/dma/dma-pvr2.c	2006-07-01 16:51:23.000000000 +0200
+++ linux-2.6.git/arch/sh/drivers/dma/dma-pvr2.c	2006-07-01 16:51:36.000000000 +0200
@@ -70,7 +70,7 @@ static int pvr2_xfer_dma(struct dma_chan
 static struct irqaction pvr2_dma_irq = {
 	.name		= "pvr2 DMA handler",
 	.handler	= pvr2_dma_interrupt,
-	.flags		= SA_INTERRUPT,
+	.flags		= IRQF_DISABLED,
 };
 
 static struct dma_ops pvr2_dma_ops = {
Index: linux-2.6.git/arch/sh/drivers/dma/dma-sh.c
===================================================================
--- linux-2.6.git.orig/arch/sh/drivers/dma/dma-sh.c	2006-07-01 16:51:23.000000000 +0200
+++ linux-2.6.git/arch/sh/drivers/dma/dma-sh.c	2006-07-01 16:51:36.000000000 +0200
@@ -90,7 +90,7 @@ static int sh_dmac_request_dma(struct dm
 		 chan->chan);
 
 	return request_irq(get_dmte_irq(chan->chan), dma_tei,
-			   SA_INTERRUPT, name, chan);
+			   IRQF_DISABLED, name, chan);
 }
 
 static void sh_dmac_free_dma(struct dma_channel *chan)
@@ -258,7 +258,7 @@ static int __init sh_dmac_init(void)
 
 #ifdef CONFIG_CPU_SH4
 	make_ipr_irq(DMAE_IRQ, DMA_IPR_ADDR, DMA_IPR_POS, DMA_PRIORITY);
-	i = request_irq(DMAE_IRQ, dma_err, SA_INTERRUPT, "DMAC Address Error", 0);
+	i = request_irq(DMAE_IRQ, dma_err, IRQF_DISABLED, "DMAC Address Error", 0);
 	if (i < 0)
 		return i;
 #endif
Index: linux-2.6.git/arch/sh/drivers/pci/pci-st40.c
===================================================================
--- linux-2.6.git.orig/arch/sh/drivers/pci/pci-st40.c	2006-07-01 16:51:23.000000000 +0200
+++ linux-2.6.git/arch/sh/drivers/pci/pci-st40.c	2006-07-01 16:51:36.000000000 +0200
@@ -447,7 +447,7 @@ static int __init pcibios_init(void)
 		     PHYSADDR(memory_end) - PHYSADDR(memory_start));
 
 	if (request_irq(ST40PCI_ERR_IRQ, st40_pci_irq, 
-                        SA_INTERRUPT, "st40pci", NULL)) {
+                        IRQF_DISABLED, "st40pci", NULL)) {
 		printk(KERN_ERR "st40pci: Cannot hook interrupt\n");
 		return -EIO;
 	}
Index: linux-2.6.git/arch/sh/kernel/timers/timer-tmu.c
===================================================================
--- linux-2.6.git.orig/arch/sh/kernel/timers/timer-tmu.c	2006-07-01 16:51:23.000000000 +0200
+++ linux-2.6.git/arch/sh/kernel/timers/timer-tmu.c	2006-07-01 16:51:36.000000000 +0200
@@ -107,7 +107,7 @@ static irqreturn_t tmu_timer_interrupt(i
 static struct irqaction tmu_irq = {
 	.name		= "timer",
 	.handler	= tmu_timer_interrupt,
-	.flags		= SA_INTERRUPT,
+	.flags		= IRQF_DISABLED,
 	.mask		= CPU_MASK_NONE,
 };
 

--

