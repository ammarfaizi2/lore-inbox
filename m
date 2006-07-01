Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932869AbWGAPHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932869AbWGAPHX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 11:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbWGAO53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 10:57:29 -0400
Received: from www.osadl.org ([213.239.205.134]:36516 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751587AbWGAO5J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:57:09 -0400
Message-Id: <20060701145225.065017000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:54:37 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, benh@kernel.crashing.org
Subject: [RFC][patch 16/44] PPC: Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-ppc.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use the new IRQF_ constants and remove the SA_INTERRUPT define

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 arch/ppc/8260_io/fcc_enet.c                  |    2 +-
 arch/ppc/platforms/85xx/mpc8560_ads.c        |    2 +-
 arch/ppc/platforms/85xx/mpc85xx_cds_common.c |    2 +-
 arch/ppc/platforms/85xx/stx_gp3.c            |    2 +-
 arch/ppc/platforms/85xx/tqm85xx.c            |    2 +-
 arch/ppc/platforms/hdpu.c                    |    4 ++--
 arch/ppc/platforms/radstone_ppc7d.c          |    2 +-
 arch/ppc/platforms/sbc82xx.c                 |    2 +-
 arch/ppc/syslib/gt64260_pic.c                |    6 +++---
 arch/ppc/syslib/ibm440gx_common.c            |    2 +-
 arch/ppc/syslib/m82xx_pci.c                  |    2 +-
 arch/ppc/syslib/mv64360_pic.c                |    8 ++++----
 arch/ppc/syslib/open_pic.c                   |   15 +++++++++------
 include/asm-ppc/floppy.h                     |    8 ++++----
 14 files changed, 31 insertions(+), 28 deletions(-)

Index: linux-2.6.git/include/asm-ppc/floppy.h
===================================================================
--- linux-2.6.git.orig/include/asm-ppc/floppy.h	2006-07-01 16:51:24.000000000 +0200
+++ linux-2.6.git/include/asm-ppc/floppy.h	2006-07-01 16:51:35.000000000 +0200
@@ -96,11 +96,11 @@ static int vdma_get_dma_residue(unsigned
 static int fd_request_irq(void)
 {
 	if (can_use_virtual_dma)
-		return request_irq(FLOPPY_IRQ, floppy_hardint,SA_INTERRUPT,
-						   "floppy", NULL);
+		return request_irq(FLOPPY_IRQ, floppy_hardint,
+				   IRQF_DISABLED, "floppy", NULL);
 	else
-		return request_irq(FLOPPY_IRQ, floppy_interrupt, SA_INTERRUPT,
-				   "floppy", NULL);
+		return request_irq(FLOPPY_IRQ, floppy_interrupt,
+				   IRQF_DISABLED, "floppy", NULL);
 }
 
 static int vdma_dma_setup(char *addr, unsigned long size, int mode, int io)
Index: linux-2.6.git/arch/ppc/8260_io/fcc_enet.c
===================================================================
--- linux-2.6.git.orig/arch/ppc/8260_io/fcc_enet.c	2006-07-01 16:51:24.000000000 +0200
+++ linux-2.6.git/arch/ppc/8260_io/fcc_enet.c	2006-07-01 16:51:35.000000000 +0200
@@ -2116,7 +2116,7 @@ init_fcc_startup(fcc_info_t *fip, struct
 
 #ifdef	PHY_INTERRUPT
 #ifdef CONFIG_ADS8272
-	if (request_irq(PHY_INTERRUPT, mii_link_interrupt, SA_SHIRQ,
+	if (request_irq(PHY_INTERRUPT, mii_link_interrupt, IRQF_SHARED,
 				"mii", dev) < 0)
 		printk(KERN_CRIT "Can't get MII IRQ %d\n", PHY_INTERRUPT);
 #else
Index: linux-2.6.git/arch/ppc/platforms/hdpu.c
===================================================================
--- linux-2.6.git.orig/arch/ppc/platforms/hdpu.c	2006-07-01 16:51:24.000000000 +0200
+++ linux-2.6.git/arch/ppc/platforms/hdpu.c	2006-07-01 16:51:35.000000000 +0200
@@ -837,7 +837,7 @@ static void smp_hdpu_setup_cpu(int cpu_n
 		mv64x60_write(&bh, MV64360_CPU0_DOORBELL_CLR, 0xff);
 		mv64x60_write(&bh, MV64360_CPU0_DOORBELL_MASK, 0xff);
 		request_irq(60, hdpu_smp_cpu0_int_handler,
-			    SA_INTERRUPT, hdpu_smp0, 0);
+			    IRQF_DISABLED, hdpu_smp0, 0);
 	}
 
 	if (cpu_nr == 1) {
@@ -857,7 +857,7 @@ static void smp_hdpu_setup_cpu(int cpu_n
 		mv64x60_write(&bh, MV64360_CPU1_DOORBELL_CLR, 0x0);
 		mv64x60_write(&bh, MV64360_CPU1_DOORBELL_MASK, 0xff);
 		request_irq(28, hdpu_smp_cpu1_int_handler,
-			    SA_INTERRUPT, hdpu_smp1, 0);
+			    IRQF_DISABLED, hdpu_smp1, 0);
 	}
 
 }
Index: linux-2.6.git/arch/ppc/platforms/radstone_ppc7d.c
===================================================================
--- linux-2.6.git.orig/arch/ppc/platforms/radstone_ppc7d.c	2006-07-01 16:51:24.000000000 +0200
+++ linux-2.6.git/arch/ppc/platforms/radstone_ppc7d.c	2006-07-01 16:51:35.000000000 +0200
@@ -1310,7 +1310,7 @@ static void ppc7d_init2(void)
 
 	/* Hook up i8259 interrupt which is connected to GPP28 */
 	request_irq(mv64360_irq_base + MV64x60_IRQ_GPP28, ppc7d_i8259_intr,
-		    SA_INTERRUPT, "I8259 (GPP28) interrupt", (void *)0);
+		    IRQF_DISABLED, "I8259 (GPP28) interrupt", (void *)0);
 
 	/* Configure MPP16 as watchdog NMI, MPP17 as watchdog WDE */
 	spin_lock_irqsave(&mv64x60_lock, flags);
Index: linux-2.6.git/arch/ppc/platforms/sbc82xx.c
===================================================================
--- linux-2.6.git.orig/arch/ppc/platforms/sbc82xx.c	2006-07-01 16:51:24.000000000 +0200
+++ linux-2.6.git/arch/ppc/platforms/sbc82xx.c	2006-07-01 16:51:35.000000000 +0200
@@ -145,7 +145,7 @@ static irqreturn_t sbc82xx_i8259_demux(i
 
 static struct irqaction sbc82xx_i8259_irqaction = {
 	.handler = sbc82xx_i8259_demux,
-	.flags = SA_INTERRUPT,
+	.flags = IRQF_DISABLED,
 	.mask = CPU_MASK_NONE,
 	.name = "i8259 demux",
 };
Index: linux-2.6.git/arch/ppc/platforms/85xx/mpc8560_ads.c
===================================================================
--- linux-2.6.git.orig/arch/ppc/platforms/85xx/mpc8560_ads.c	2006-07-01 16:51:24.000000000 +0200
+++ linux-2.6.git/arch/ppc/platforms/85xx/mpc8560_ads.c	2006-07-01 16:51:35.000000000 +0200
@@ -131,7 +131,7 @@ static irqreturn_t cpm2_cascade(int irq,
 
 static struct irqaction cpm2_irqaction = {
 	.handler = cpm2_cascade,
-	.flags = SA_INTERRUPT,
+	.flags = IRQF_DISABLED,
 	.mask = CPU_MASK_NONE,
 	.name = "cpm2_cascade",
 };
Index: linux-2.6.git/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
===================================================================
--- linux-2.6.git.orig/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	2006-07-01 16:51:24.000000000 +0200
+++ linux-2.6.git/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	2006-07-01 16:51:35.000000000 +0200
@@ -136,7 +136,7 @@ static irqreturn_t cpm2_cascade(int irq,
 
 static struct irqaction cpm2_irqaction = {
 	.handler = cpm2_cascade,
-	.flags = SA_INTERRUPT,
+	.flags = IRQF_DISABLED,
 	.mask = CPU_MASK_NONE,
 	.name = "cpm2_cascade",
 };
Index: linux-2.6.git/arch/ppc/platforms/85xx/stx_gp3.c
===================================================================
--- linux-2.6.git.orig/arch/ppc/platforms/85xx/stx_gp3.c	2006-07-01 16:51:24.000000000 +0200
+++ linux-2.6.git/arch/ppc/platforms/85xx/stx_gp3.c	2006-07-01 16:51:35.000000000 +0200
@@ -166,7 +166,7 @@ static irqreturn_t cpm2_cascade(int irq,
 
 static struct irqaction cpm2_irqaction = {
 	.handler	= cpm2_cascade,
-	.flags		= SA_INTERRUPT,
+	.flags		= IRQF_DISABLED,
 	.mask		= CPU_MASK_NONE,
 	.name		= "cpm2_cascade",
 };
Index: linux-2.6.git/arch/ppc/platforms/85xx/tqm85xx.c
===================================================================
--- linux-2.6.git.orig/arch/ppc/platforms/85xx/tqm85xx.c	2006-07-01 16:51:24.000000000 +0200
+++ linux-2.6.git/arch/ppc/platforms/85xx/tqm85xx.c	2006-07-01 16:51:35.000000000 +0200
@@ -190,7 +190,7 @@ static irqreturn_t cpm2_cascade(int irq,
 
 static struct irqaction cpm2_irqaction = {
 	.handler = cpm2_cascade,
-	.flags = SA_INTERRUPT,
+	.flags = IRQF_DISABLED,
 	.mask = CPU_MASK_NONE,
 	.name = "cpm2_cascade",
 };
Index: linux-2.6.git/arch/ppc/syslib/gt64260_pic.c
===================================================================
--- linux-2.6.git.orig/arch/ppc/syslib/gt64260_pic.c	2006-07-01 16:51:24.000000000 +0200
+++ linux-2.6.git/arch/ppc/syslib/gt64260_pic.c	2006-07-01 16:51:35.000000000 +0200
@@ -297,7 +297,7 @@ gt64260_register_hdlrs(void)
 
 	/* Register CPU interface error interrupt handler */
 	if ((rc = request_irq(MV64x60_IRQ_CPU_ERR,
-		gt64260_cpu_error_int_handler, SA_INTERRUPT, CPU_INTR_STR, 0)))
+		gt64260_cpu_error_int_handler, IRQF_DISABLED, CPU_INTR_STR, 0)))
 		printk(KERN_WARNING "Can't register cpu error handler: %d", rc);
 
 	mv64x60_write(&bh, MV64x60_CPU_ERR_MASK, 0);
@@ -305,7 +305,7 @@ gt64260_register_hdlrs(void)
 
 	/* Register PCI 0 error interrupt handler */
 	if ((rc = request_irq(MV64360_IRQ_PCI0, gt64260_pci_error_int_handler,
-		    SA_INTERRUPT, PCI0_INTR_STR, (void *)0)))
+		    IRQF_DISABLED, PCI0_INTR_STR, (void *)0)))
 		printk(KERN_WARNING "Can't register pci 0 error handler: %d",
 			rc);
 
@@ -314,7 +314,7 @@ gt64260_register_hdlrs(void)
 
 	/* Register PCI 1 error interrupt handler */
 	if ((rc = request_irq(MV64360_IRQ_PCI1, gt64260_pci_error_int_handler,
-		    SA_INTERRUPT, PCI1_INTR_STR, (void *)1)))
+		    IRQF_DISABLED, PCI1_INTR_STR, (void *)1)))
 		printk(KERN_WARNING "Can't register pci 1 error handler: %d",
 			rc);
 
Index: linux-2.6.git/arch/ppc/syslib/ibm440gx_common.c
===================================================================
--- linux-2.6.git.orig/arch/ppc/syslib/ibm440gx_common.c	2006-07-01 16:51:24.000000000 +0200
+++ linux-2.6.git/arch/ppc/syslib/ibm440gx_common.c	2006-07-01 16:51:35.000000000 +0200
@@ -149,7 +149,7 @@ void __init ibm440gx_l2c_enable(void){
 	unsigned long flags;
 
 	/* Install error handler */
-	if (request_irq(87, l2c_error_handler, SA_INTERRUPT, "L2C", 0) < 0){
+	if (request_irq(87, l2c_error_handler, IRQF_DISABLED, "L2C", 0) < 0){
 		printk(KERN_ERR "Cannot install L2C error handler, cache is not enabled\n");
 		return;
 	}
Index: linux-2.6.git/arch/ppc/syslib/m82xx_pci.c
===================================================================
--- linux-2.6.git.orig/arch/ppc/syslib/m82xx_pci.c	2006-07-01 16:51:24.000000000 +0200
+++ linux-2.6.git/arch/ppc/syslib/m82xx_pci.c	2006-07-01 16:51:35.000000000 +0200
@@ -139,7 +139,7 @@ pq2pci_irq_demux(int irq, void *dev_id, 
 
 static struct irqaction pq2pci_irqaction = {
 	.handler = pq2pci_irq_demux,
-	.flags 	 = SA_INTERRUPT,
+	.flags 	 = IRQF_DISABLED,
 	.mask	 = CPU_MASK_NONE,
 	.name	 = "PQ2 PCI cascade",
 };
Index: linux-2.6.git/arch/ppc/syslib/mv64360_pic.c
===================================================================
--- linux-2.6.git.orig/arch/ppc/syslib/mv64360_pic.c	2006-07-01 16:51:24.000000000 +0200
+++ linux-2.6.git/arch/ppc/syslib/mv64360_pic.c	2006-07-01 16:51:35.000000000 +0200
@@ -380,7 +380,7 @@ mv64360_register_hdlrs(void)
 	/* Clear old errors and register CPU interface error intr handler */
 	mv64x60_write(&bh, MV64x60_CPU_ERR_CAUSE, 0);
 	if ((rc = request_irq(MV64x60_IRQ_CPU_ERR + mv64360_irq_base,
-		mv64360_cpu_error_int_handler, SA_INTERRUPT, CPU_INTR_STR, 0)))
+		mv64360_cpu_error_int_handler, IRQF_DISABLED, CPU_INTR_STR, 0)))
 		printk(KERN_WARNING "Can't register cpu error handler: %d", rc);
 
 	mv64x60_write(&bh, MV64x60_CPU_ERR_MASK, 0);
@@ -389,14 +389,14 @@ mv64360_register_hdlrs(void)
 	/* Clear old errors and register internal SRAM error intr handler */
 	mv64x60_write(&bh, MV64360_SRAM_ERR_CAUSE, 0);
 	if ((rc = request_irq(MV64360_IRQ_SRAM_PAR_ERR + mv64360_irq_base,
-		mv64360_sram_error_int_handler,SA_INTERRUPT,SRAM_INTR_STR, 0)))
+		mv64360_sram_error_int_handler,IRQF_DISABLED,SRAM_INTR_STR, 0)))
 		printk(KERN_WARNING "Can't register SRAM error handler: %d",rc);
 
 	/* Clear old errors and register PCI 0 error intr handler */
 	mv64x60_write(&bh, MV64x60_PCI0_ERR_CAUSE, 0);
 	if ((rc = request_irq(MV64360_IRQ_PCI0 + mv64360_irq_base,
 			mv64360_pci_error_int_handler,
-			SA_INTERRUPT, PCI0_INTR_STR, (void *)0)))
+			IRQF_DISABLED, PCI0_INTR_STR, (void *)0)))
 		printk(KERN_WARNING "Can't register pci 0 error handler: %d",
 			rc);
 
@@ -411,7 +411,7 @@ mv64360_register_hdlrs(void)
 	mv64x60_write(&bh, MV64x60_PCI1_ERR_CAUSE, 0);
 	if ((rc = request_irq(MV64360_IRQ_PCI1 + mv64360_irq_base,
 			mv64360_pci_error_int_handler,
-			SA_INTERRUPT, PCI1_INTR_STR, (void *)1)))
+			IRQF_DISABLED, PCI1_INTR_STR, (void *)1)))
 		printk(KERN_WARNING "Can't register pci 1 error handler: %d",
 			rc);
 
Index: linux-2.6.git/arch/ppc/syslib/open_pic.c
===================================================================
--- linux-2.6.git.orig/arch/ppc/syslib/open_pic.c	2006-07-01 16:51:24.000000000 +0200
+++ linux-2.6.git/arch/ppc/syslib/open_pic.c	2006-07-01 16:51:35.000000000 +0200
@@ -575,18 +575,21 @@ void openpic_request_IPIs(void)
 	if (OpenPIC == NULL)
 		return;
 
-	/* IPIs are marked SA_INTERRUPT as they must run with irqs disabled */
+	/*
+ 	 * IPIs are marked IRQF_DISABLED as they must run with irqs
+	 * disabled
+	 */
 	request_irq(OPENPIC_VEC_IPI+open_pic_irq_offset,
-		    openpic_ipi_action, SA_INTERRUPT,
+		    openpic_ipi_action, IRQF_DISABLED,
 		    "IPI0 (call function)", NULL);
 	request_irq(OPENPIC_VEC_IPI+open_pic_irq_offset+1,
-		    openpic_ipi_action, SA_INTERRUPT,
+		    openpic_ipi_action, IRQF_DISABLED,
 		    "IPI1 (reschedule)", NULL);
 	request_irq(OPENPIC_VEC_IPI+open_pic_irq_offset+2,
-		    openpic_ipi_action, SA_INTERRUPT,
+		    openpic_ipi_action, IRQF_DISABLED,
 		    "IPI2 (invalidate tlb)", NULL);
 	request_irq(OPENPIC_VEC_IPI+open_pic_irq_offset+3,
-		    openpic_ipi_action, SA_INTERRUPT,
+		    openpic_ipi_action, IRQF_DISABLED,
 		    "IPI3 (xmon break)", NULL);
 
 	for ( i = 0; i < OPENPIC_NUM_IPI ; i++ )
@@ -691,7 +694,7 @@ openpic_init_nmi_irq(u_int irq)
 
 static struct irqaction openpic_cascade_irqaction = {
 	.handler = no_action,
-	.flags = SA_INTERRUPT,
+	.flags = IRQF_DISABLED,
 	.mask = CPU_MASK_NONE,
 };
 

--

