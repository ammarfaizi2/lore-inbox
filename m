Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932938AbWGAPIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932938AbWGAPIt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 11:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751898AbWGAO5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 10:57:25 -0400
Received: from www.osadl.org ([213.239.205.134]:35748 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751577AbWGAO5I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:57:08 -0400
Message-Id: <20060701145224.950514000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:54:36 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, benh@kernel.crashing.org
Subject: [RFC][patch 15/44] POWERPC: Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-powerpc.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use the new IRQF_ constants and remove the SA_INTERRUPT define

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 arch/powerpc/platforms/cell/interrupt.c |    4 ++--
 arch/powerpc/platforms/cell/spu_base.c  |    6 +++---
 arch/powerpc/platforms/chrp/setup.c     |   10 +++++-----
 arch/powerpc/platforms/powermac/pic.c   |    2 +-
 arch/powerpc/platforms/powermac/smp.c   |    2 +-
 arch/powerpc/platforms/pseries/setup.c  |   10 +++++-----
 arch/powerpc/platforms/pseries/xics.c   |   11 +++++++----
 arch/powerpc/sysdev/i8259.c             |    4 ++--
 arch/powerpc/sysdev/mpic.c              |   15 +++++++++------
 include/asm-powerpc/floppy.h            |    2 +-
 include/asm-powerpc/signal.h            |    2 --
 11 files changed, 36 insertions(+), 32 deletions(-)

Index: linux-2.6.git/include/asm-powerpc/floppy.h
===================================================================
--- linux-2.6.git.orig/include/asm-powerpc/floppy.h	2006-07-01 16:51:24.000000000 +0200
+++ linux-2.6.git/include/asm-powerpc/floppy.h	2006-07-01 16:51:35.000000000 +0200
@@ -27,7 +27,7 @@
 #define fd_disable_irq()        disable_irq(FLOPPY_IRQ)
 #define fd_cacheflush(addr,size) /* nothing */
 #define fd_request_irq()        request_irq(FLOPPY_IRQ, floppy_interrupt, \
-					    SA_INTERRUPT, "floppy", NULL)
+					    IRQF_DISABLED, "floppy", NULL)
 #define fd_free_irq()           free_irq(FLOPPY_IRQ, NULL);
 
 #ifdef CONFIG_PCI
Index: linux-2.6.git/include/asm-powerpc/signal.h
===================================================================
--- linux-2.6.git.orig/include/asm-powerpc/signal.h	2006-07-01 16:51:24.000000000 +0200
+++ linux-2.6.git/include/asm-powerpc/signal.h	2006-07-01 16:51:35.000000000 +0200
@@ -63,7 +63,6 @@ typedef struct {
  * SA_FLAGS values:
  *
  * SA_ONSTACK is not currently supported, but will allow sigaltstack(2).
- * SA_INTERRUPT is a no-op, but left due to historical reasons. Use the
  * SA_RESTART flag to get restarting signals (which were the default long ago)
  * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
  * SA_RESETHAND clears the handler when the signal is delivered.
@@ -83,7 +82,6 @@ typedef struct {
 
 #define SA_NOMASK	SA_NODEFER
 #define SA_ONESHOT	SA_RESETHAND
-#define SA_INTERRUPT	0x20000000u /* dummy -- ignored */
 
 #define SA_RESTORER	0x04000000U
 
Index: linux-2.6.git/arch/powerpc/platforms/cell/interrupt.c
===================================================================
--- linux-2.6.git.orig/arch/powerpc/platforms/cell/interrupt.c	2006-07-01 16:51:24.000000000 +0200
+++ linux-2.6.git/arch/powerpc/platforms/cell/interrupt.c	2006-07-01 16:51:35.000000000 +0200
@@ -304,11 +304,11 @@ static void iic_request_ipi(int ipi, con
 	int irq;
 
 	irq = iic_ipi_to_irq(ipi);
-	/* IPIs are marked SA_INTERRUPT as they must run with irqs
+	/* IPIs are marked IRQF_DISABLED as they must run with irqs
 	 * disabled */
 	get_irq_desc(irq)->chip = &iic_pic;
 	get_irq_desc(irq)->status |= IRQ_PER_CPU;
-	request_irq(irq, iic_ipi_action, SA_INTERRUPT, name, NULL);
+	request_irq(irq, iic_ipi_action, IRQF_DISABLED, name, NULL);
 }
 
 void iic_request_IPIs(void)
Index: linux-2.6.git/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linux-2.6.git.orig/arch/powerpc/platforms/cell/spu_base.c	2006-07-01 16:51:24.000000000 +0200
+++ linux-2.6.git/arch/powerpc/platforms/cell/spu_base.c	2006-07-01 16:51:35.000000000 +0200
@@ -274,19 +274,19 @@ spu_request_irqs(struct spu *spu)
 
 	snprintf(spu->irq_c0, sizeof (spu->irq_c0), "spe%02d.0", spu->number);
 	ret = request_irq(irq_base + spu->isrc,
-		 spu_irq_class_0, SA_INTERRUPT, spu->irq_c0, spu);
+		 spu_irq_class_0, IRQF_DISABLED, spu->irq_c0, spu);
 	if (ret)
 		goto out;
 
 	snprintf(spu->irq_c1, sizeof (spu->irq_c1), "spe%02d.1", spu->number);
 	ret = request_irq(irq_base + IIC_CLASS_STRIDE + spu->isrc,
-		 spu_irq_class_1, SA_INTERRUPT, spu->irq_c1, spu);
+		 spu_irq_class_1, IRQF_DISABLED, spu->irq_c1, spu);
 	if (ret)
 		goto out1;
 
 	snprintf(spu->irq_c2, sizeof (spu->irq_c2), "spe%02d.2", spu->number);
 	ret = request_irq(irq_base + 2*IIC_CLASS_STRIDE + spu->isrc,
-		 spu_irq_class_2, SA_INTERRUPT, spu->irq_c2, spu);
+		 spu_irq_class_2, IRQF_DISABLED, spu->irq_c2, spu);
 	if (ret)
 		goto out2;
 	goto out;
Index: linux-2.6.git/arch/powerpc/platforms/chrp/setup.c
===================================================================
--- linux-2.6.git.orig/arch/powerpc/platforms/chrp/setup.c	2006-07-01 16:51:24.000000000 +0200
+++ linux-2.6.git/arch/powerpc/platforms/chrp/setup.c	2006-07-01 16:51:35.000000000 +0200
@@ -351,8 +351,8 @@ static void __init chrp_find_openpic(voi
 
 	printk(KERN_INFO "OpenPIC at %lx\n", opaddr);
 
-	irq_count = NR_IRQS - NUM_ISA_INTERRUPTS - 4; /* leave room for IPIs */
-	prom_get_irq_senses(init_senses, NUM_ISA_INTERRUPTS, NR_IRQS - 4);
+	irq_count = NR_IRQS - NUM_IIRQF_DISABLEDS - 4; /* leave room for IPIs */
+	prom_get_irq_senses(init_senses, NUM_IIRQF_DISABLEDS, NR_IRQS - 4);
 	/* i8259 cascade is always positive level */
 	init_senses[0] = IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE;
 
@@ -383,7 +383,7 @@ static void __init chrp_find_openpic(voi
 		isu_size = iranges[3];
 
 	chrp_mpic = mpic_alloc(opaddr, MPIC_PRIMARY,
-			       isu_size, NUM_ISA_INTERRUPTS, irq_count,
+			       isu_size, NUM_IIRQF_DISABLEDS, irq_count,
 			       NR_IRQS - 4, init_senses, irq_count,
 			       " MPIC    ");
 	if (chrp_mpic == NULL) {
@@ -402,7 +402,7 @@ static void __init chrp_find_openpic(voi
 	}
 
 	mpic_init(chrp_mpic);
-	mpic_setup_cascade(NUM_ISA_INTERRUPTS, i8259_irq_cascade, NULL);
+	mpic_setup_cascade(NUM_IIRQF_DISABLEDS, i8259_irq_cascade, NULL);
 }
 
 #if defined(CONFIG_VT) && defined(CONFIG_INPUT_ADBHID) && defined(XMON)
@@ -523,7 +523,7 @@ static int __init chrp_probe(void)
 	ppc_do_canonicalize_irqs = 1;
 
 	/* Assume we have an 8259... */
-	__irq_offset_value = NUM_ISA_INTERRUPTS;
+	__irq_offset_value = NUM_IIRQF_DISABLEDS;
 
 	return 1;
 }
Index: linux-2.6.git/arch/powerpc/platforms/powermac/pic.c
===================================================================
--- linux-2.6.git.orig/arch/powerpc/platforms/powermac/pic.c	2006-07-01 16:51:24.000000000 +0200
+++ linux-2.6.git/arch/powerpc/platforms/powermac/pic.c	2006-07-01 16:51:35.000000000 +0200
@@ -381,7 +381,7 @@ static struct irqaction xmon_action = {
 
 static struct irqaction gatwick_cascade_action = {
 	.handler	= gatwick_action,
-	.flags		= SA_INTERRUPT,
+	.flags		= IRQF_DISABLED,
 	.mask		= CPU_MASK_NONE,
 	.name		= "cascade",
 };
Index: linux-2.6.git/arch/powerpc/platforms/powermac/smp.c
===================================================================
--- linux-2.6.git.orig/arch/powerpc/platforms/powermac/smp.c	2006-07-01 16:51:24.000000000 +0200
+++ linux-2.6.git/arch/powerpc/platforms/powermac/smp.c	2006-07-01 16:51:35.000000000 +0200
@@ -377,7 +377,7 @@ static void __init psurge_dual_sync_tb(i
 
 static struct irqaction psurge_irqaction = {
 	.handler = psurge_primary_intr,
-	.flags = SA_INTERRUPT,
+	.flags = IRQF_DISABLED,
 	.mask = CPU_MASK_NONE,
 	.name = "primary IPI",
 };
Index: linux-2.6.git/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- linux-2.6.git.orig/arch/powerpc/platforms/pseries/setup.c	2006-07-01 16:51:24.000000000 +0200
+++ linux-2.6.git/arch/powerpc/platforms/pseries/setup.c	2006-07-01 16:51:35.000000000 +0200
@@ -140,14 +140,14 @@ static void __init pSeries_init_mpic(voi
 	i8259_init(intack, 0);
 
 	/* Hook cascade to mpic */
-	mpic_setup_cascade(NUM_ISA_INTERRUPTS, i8259_irq_cascade, NULL);
+	mpic_setup_cascade(NUM_IIRQF_DISABLEDS, i8259_irq_cascade, NULL);
 }
 
 static void __init pSeries_setup_mpic(void)
 {
 	unsigned int *opprop;
 	unsigned long openpic_addr = 0;
-        unsigned char senses[NR_IRQS - NUM_ISA_INTERRUPTS];
+        unsigned char senses[NR_IRQS - NUM_IIRQF_DISABLEDS];
         struct device_node *root;
 	int irq_count;
 
@@ -166,10 +166,10 @@ static void __init pSeries_setup_mpic(vo
 	BUG_ON(openpic_addr == 0);
 
 	/* Get the sense values from OF */
-	prom_get_irq_senses(senses, NUM_ISA_INTERRUPTS, NR_IRQS);
+	prom_get_irq_senses(senses, NUM_IIRQF_DISABLEDS, NR_IRQS);
 	
 	/* Setup the openpic driver */
-	irq_count = NR_IRQS - NUM_ISA_INTERRUPTS - 4; /* leave room for IPIs */
+	irq_count = NR_IRQS - NUM_IIRQF_DISABLEDS - 4; /* leave room for IPIs */
 	pSeries_mpic = mpic_alloc(openpic_addr, MPIC_PRIMARY,
 				  16, 16, irq_count, /* isu size, irq offset, irq count */ 
 				  NR_IRQS - 4, /* ipi offset */
@@ -269,7 +269,7 @@ static  void __init pSeries_discover_pic
 	 * Setup interrupt mapping options that are needed for finish_device_tree
 	 * to properly parse the OF interrupt tree & do the virtual irq mapping
 	 */
-	__irq_offset_value = NUM_ISA_INTERRUPTS;
+	__irq_offset_value = NUM_IIRQF_DISABLEDS;
 	ppc64_interrupt_controller = IC_INVALID;
 	for (np = NULL; (np = of_find_node_by_name(np, "interrupt-controller"));) {
 		typep = (char *)get_property(np, "compatible", NULL);
Index: linux-2.6.git/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- linux-2.6.git.orig/arch/powerpc/platforms/pseries/xics.c	2006-07-01 16:51:24.000000000 +0200
+++ linux-2.6.git/arch/powerpc/platforms/pseries/xics.c	2006-07-01 16:51:35.000000000 +0200
@@ -59,7 +59,7 @@ static struct radix_tree_root irq_map = 
 
 /*
  * Mark IPIs as higher priority so we can take them inside interrupts that
- * arent marked SA_INTERRUPT
+ * arent marked IRQF_DISABLED
  */
 #define IPI_PRIORITY		4
 
@@ -586,9 +586,12 @@ void xics_request_IPIs(void)
 {
 	virt_irq_to_real_map[XICS_IPI] = XICS_IPI;
 
-	/* IPIs are marked SA_INTERRUPT as they must run with irqs disabled */
-	request_irq(irq_offset_up(XICS_IPI), xics_ipi_action, SA_INTERRUPT,
-		    "IPI", NULL);
+	/* 
+	 * IPIs are marked IRQF_DISABLED as they must run with irqs
+	 * disabled 
+	 */
+	request_irq(irq_offset_up(XICS_IPI), xics_ipi_action,
+		    IRQF_DISABLED, "IPI", NULL);
 	get_irq_desc(irq_offset_up(XICS_IPI))->status |= IRQ_PER_CPU;
 }
 #endif
Index: linux-2.6.git/arch/powerpc/sysdev/i8259.c
===================================================================
--- linux-2.6.git.orig/arch/powerpc/sysdev/i8259.c	2006-07-01 16:51:24.000000000 +0200
+++ linux-2.6.git/arch/powerpc/sysdev/i8259.c	2006-07-01 16:51:35.000000000 +0200
@@ -167,7 +167,7 @@ static struct resource pic_edgectrl_iore
 
 static struct irqaction i8259_irqaction = {
 	.handler = no_action,
-	.flags = SA_INTERRUPT,
+	.flags = IRQF_DISABLED,
 	.mask = CPU_MASK_NONE,
 	.name = "82c59 secondary cascade",
 };
@@ -207,7 +207,7 @@ void __init i8259_init(unsigned long int
 
 	spin_unlock_irqrestore(&i8259_lock, flags);
 
-	for (i = 0; i < NUM_ISA_INTERRUPTS; ++i)
+	for (i = 0; i < NUM_IIRQF_DISABLEDS; ++i)
 		irq_desc[offset + i].chip = &i8259_pic;
 
 	/* reserve our resources */
Index: linux-2.6.git/arch/powerpc/sysdev/mpic.c
===================================================================
--- linux-2.6.git.orig/arch/powerpc/sysdev/mpic.c	2006-07-01 16:51:24.000000000 +0200
+++ linux-2.6.git/arch/powerpc/sysdev/mpic.c	2006-07-01 16:51:35.000000000 +0200
@@ -540,7 +540,7 @@ static void mpic_end_ipi(unsigned int ir
 	 * IPIs are marked IRQ_PER_CPU. This has the side effect of
 	 * preventing the IRQ_PENDING/IRQ_INPROGRESS logic from
 	 * applying to them. We EOI them late to avoid re-entering.
-	 * We mark IPI's with SA_INTERRUPT as they must run with
+	 * We mark IPI's with IRQF_DISABLED as they must run with
 	 * irqs disabled.
 	 */
 	mpic_eoi(mpic);
@@ -1027,14 +1027,17 @@ void mpic_request_ipis(void)
 	
 	printk("requesting IPIs ... \n");
 
-	/* IPIs are marked SA_INTERRUPT as they must run with irqs disabled */
-	request_irq(mpic->ipi_offset+0, mpic_ipi_action, SA_INTERRUPT,
+	/* 
+	 * IPIs are marked IRQF_DISABLED as they must run with irqs 
+	 * disabled 
+	 */
+	request_irq(mpic->ipi_offset+0, mpic_ipi_action, IRQF_DISABLED,
 		    "IPI0 (call function)", mpic);
-	request_irq(mpic->ipi_offset+1, mpic_ipi_action, SA_INTERRUPT,
+	request_irq(mpic->ipi_offset+1, mpic_ipi_action, IRQF_DISABLED,
 		   "IPI1 (reschedule)", mpic);
-	request_irq(mpic->ipi_offset+2, mpic_ipi_action, SA_INTERRUPT,
+	request_irq(mpic->ipi_offset+2, mpic_ipi_action, IRQF_DISABLED,
 		   "IPI2 (unused)", mpic);
-	request_irq(mpic->ipi_offset+3, mpic_ipi_action, SA_INTERRUPT,
+	request_irq(mpic->ipi_offset+3, mpic_ipi_action, IRQF_DISABLED,
 		   "IPI3 (debugger break)", mpic);
 
 	printk("IPIs requested... \n");

--

