Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbVC2Qnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVC2Qnd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 11:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbVC2Qnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 11:43:33 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:54461 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S261221AbVC2Qm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 11:42:56 -0500
Date: Tue, 29 Mar 2005 10:42:29 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@blarg.somerset.sps.mot.com
To: Andrew Morton <akpm@osdl.org>
cc: Jason McMullan <jason.mcmullan@timesys.com>, linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>, shall@mvista.com
Subject: [PATCH] ppc32: CPM2 PIC cleanup
Message-ID: <Pine.LNX.4.61.0503291039180.15390@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Cleaned up the CPM2 interrupt controller code:
* Added the ability to offset the IRQs
* Refactored common PIC init code out of platform files
* Fixed IRQ offsets on MPC85xx so it can handle properly handled multiple 
interrupt controllers (i8259, CPM2 PIC, and OpenPIC)

Signed-off-by: Jason McMullan <jason.mcmullan@timesys.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
diff -Nru a/arch/ppc/platforms/85xx/mpc8560_ads.c b/arch/ppc/platforms/85xx/mpc8560_ads.c
--- a/arch/ppc/platforms/85xx/mpc8560_ads.c	2005-03-29 10:36:16 -06:00
+++ b/arch/ppc/platforms/85xx/mpc8560_ads.c	2005-03-29 10:36:16 -06:00
@@ -135,25 +135,11 @@
 static void __init
 mpc8560_ads_init_IRQ(void)
 {
-	int i;
-	volatile cpm2_map_t *immap = cpm2_immr;
-
 	/* Setup OpenPIC */
 	mpc85xx_ads_init_IRQ();
 
-	/* disable all CPM interupts */
-	immap->im_intctl.ic_simrh = 0x0;
-	immap->im_intctl.ic_simrl = 0x0;
-
-	for (i = CPM_IRQ_OFFSET; i < (NR_CPM_INTS + CPM_IRQ_OFFSET); i++)
-		irq_desc[i].handler = &cpm2_pic;
-
-	/* Initialize the default interrupt mapping priorities,
-	 * in case the boot rom changed something on us.
-	 */
-	immap->im_intctl.ic_sicr = 0;
-	immap->im_intctl.ic_scprrh = 0x05309770;
-	immap->im_intctl.ic_scprrl = 0x05309770;
+	/* Setup CPM2 PIC */
+        cpm2_init_IRQ();
 
 	setup_irq(MPC85xx_IRQ_CPM, &cpm2_irqaction);
 
diff -Nru a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
--- a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	2005-03-29 10:36:16 -06:00
+++ b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	2005-03-29 10:36:16 -06:00
@@ -181,10 +181,6 @@
 mpc85xx_cds_init_IRQ(void)
 {
 	bd_t *binfo = (bd_t *) __res;
-#ifdef CONFIG_CPM2
-	volatile cpm2_map_t *immap = cpm2_immr;
-	int i;
-#endif
 
 	/* Determine the Physical Address of the OpenPIC regs */
 	phys_addr_t OpenPIC_PAddr = binfo->bi_immr_base + MPC85xx_OPENPIC_OFFSET;
@@ -203,19 +199,8 @@
 	openpic_init(MPC85xx_OPENPIC_IRQ_OFFSET);
 
 #ifdef CONFIG_CPM2
-	/* disable all CPM interupts */
-	immap->im_intctl.ic_simrh = 0x0;
-	immap->im_intctl.ic_simrl = 0x0;
-
-	for (i = CPM_IRQ_OFFSET; i < (NR_CPM_INTS + CPM_IRQ_OFFSET); i++)
-		irq_desc[i].handler = &cpm2_pic;
-
-	/* Initialize the default interrupt mapping priorities,
-	 * in case the boot rom changed something on us.
-	 */
-	immap->im_intctl.ic_sicr = 0;
-	immap->im_intctl.ic_scprrh = 0x05309770;
-	immap->im_intctl.ic_scprrl = 0x05309770;
+	/* Setup CPM2 PIC */
+        cpm2_init_IRQ();
 
 	setup_irq(MPC85xx_IRQ_CPM, &cpm2_irqaction);
 #endif
diff -Nru a/arch/ppc/platforms/85xx/stx_gp3.c b/arch/ppc/platforms/85xx/stx_gp3.c
--- a/arch/ppc/platforms/85xx/stx_gp3.c	2005-03-29 10:36:16 -06:00
+++ b/arch/ppc/platforms/85xx/stx_gp3.c	2005-03-29 10:36:16 -06:00
@@ -201,7 +201,6 @@
 gp3_init_IRQ(void)
 {
 	int i;
-	volatile cpm2_map_t *immap = cpm2_immr;
 	bd_t *binfo = (bd_t *) __res;
 
 	/*
@@ -227,24 +226,8 @@
 	 */
 	openpic_init(MPC85xx_OPENPIC_IRQ_OFFSET);
 
-	/*
-	 * Setup CPM2 PIC
-	 */
-
-	/* disable all CPM interupts */
-	immap->im_intctl.ic_simrh = 0x0;
-	immap->im_intctl.ic_simrl = 0x0;
-
-	for (i = CPM_IRQ_OFFSET; i < (NR_CPM_INTS + CPM_IRQ_OFFSET); i++)
-		irq_desc[i].handler = &cpm2_pic;
-
-	/*
-	 * Initialize the default interrupt mapping priorities,
-	 * in case the boot rom changed something on us.
-	 */
-	immap->im_intctl.ic_sicr = 0;
-	immap->im_intctl.ic_scprrh = 0x05309770;
-	immap->im_intctl.ic_scprrl = 0x05309770;
+	/* Setup CPM2 PIC */
+        cpm2_init_IRQ();
 
 	setup_irq(MPC85xx_IRQ_CPM, &cpm2_irqaction);
 
diff -Nru a/arch/ppc/syslib/cpm2_pic.c b/arch/ppc/syslib/cpm2_pic.c
--- a/arch/ppc/syslib/cpm2_pic.c	2005-03-29 10:36:16 -06:00
+++ b/arch/ppc/syslib/cpm2_pic.c	2005-03-29 10:36:16 -06:00
@@ -48,6 +48,8 @@
 	int	bit, word;
 	volatile uint	*simr;
 
+	irq_nr -= CPM_IRQ_OFFSET;
+
 	bit = irq_to_siubit[irq_nr];
 	word = irq_to_siureg[irq_nr];
 
@@ -61,6 +63,8 @@
 	int	bit, word;
 	volatile uint	*simr;
 
+	irq_nr -= CPM_IRQ_OFFSET;
+
 	bit = irq_to_siubit[irq_nr];
 	word = irq_to_siureg[irq_nr];
 
@@ -74,6 +78,8 @@
 	int	bit, word;
 	volatile uint	*simr, *sipnr;
 
+	irq_nr -= CPM_IRQ_OFFSET;
+
 	bit = irq_to_siubit[irq_nr];
 	word = irq_to_siureg[irq_nr];
 
@@ -92,6 +98,7 @@
 	if (!(irq_desc[irq_nr].status & (IRQ_DISABLED|IRQ_INPROGRESS))
 			&& irq_desc[irq_nr].action) {
 
+		irq_nr -= CPM_IRQ_OFFSET;
 		bit = irq_to_siubit[irq_nr];
 		word = irq_to_siureg[irq_nr];
 
@@ -101,20 +108,15 @@
 	}
 }
 
-struct hw_interrupt_type cpm2_pic = {
-	" CPM2 SIU  ",
-	NULL,
-	NULL,
-	cpm2_unmask_irq,
-	cpm2_mask_irq,
-	cpm2_mask_and_ack,
-	cpm2_end_irq,
-	0
+static struct hw_interrupt_type cpm2_pic = {
+	.typename = " CPM2 SIU ",
+	.enable = cpm2_unmask_irq,
+	.disable = cpm2_mask_irq,
+	.ack = cpm2_mask_and_ack,
+	.end = cpm2_end_irq,
 };
 
-
-int
-cpm2_get_irq(struct pt_regs *regs)
+int cpm2_get_irq(struct pt_regs *regs)
 {
 	int irq;
         unsigned long bits;
@@ -126,5 +128,43 @@
 
 	if (irq == 0)
 		return(-1);
-	return irq;
+	return irq+CPM_IRQ_OFFSET;
+}
+
+void cpm2_init_IRQ(void)
+{
+	int i;
+
+	/* Clear the CPM IRQ controller, in case it has any bits set
+	 * from the bootloader
+	 */
+
+	/* Mask out everything */
+	cpm2_immr->im_intctl.ic_simrh = 0x00000000;
+	cpm2_immr->im_intctl.ic_simrl = 0x00000000;
+	wmb();
+
+	/* Ack everything */
+	cpm2_immr->im_intctl.ic_sipnrh = 0xffffffff;
+	cpm2_immr->im_intctl.ic_sipnrl = 0xffffffff;
+	wmb();
+
+	/* Dummy read of the vector */
+	i = cpm2_immr->im_intctl.ic_sivec;
+	rmb();
+
+	/* Initialize the default interrupt mapping priorities,
+	 * in case the boot rom changed something on us.
+	 */
+	cpm2_immr->im_intctl.ic_sicr = 0;
+	cpm2_immr->im_intctl.ic_scprrh = 0x05309770;
+	cpm2_immr->im_intctl.ic_scprrl = 0x05309770;
+
+
+	/* Enable chaining to OpenPIC, and make everything level
+	 */
+	for (i = 0; i < NR_CPM_INTS; i++) {
+		irq_desc[i+CPM_IRQ_OFFSET].handler = &cpm2_pic;
+		irq_desc[i+CPM_IRQ_OFFSET].status |= IRQ_LEVEL;
+	}
 }
diff -Nru a/arch/ppc/syslib/cpm2_pic.h b/arch/ppc/syslib/cpm2_pic.h
--- a/arch/ppc/syslib/cpm2_pic.h	2005-03-29 10:36:16 -06:00
+++ b/arch/ppc/syslib/cpm2_pic.h	2005-03-29 10:36:16 -06:00
@@ -1,7 +1,8 @@
 #ifndef _PPC_KERNEL_CPM2_H
 #define _PPC_KERNEL_CPM2_H
 
-extern struct hw_interrupt_type cpm2_pic;
 extern int cpm2_get_irq(struct pt_regs *regs);
+
+extern void cpm2_init_IRQ(void);
 
 #endif /* _PPC_KERNEL_CPM2_H */
diff -Nru a/arch/ppc/syslib/m8260_setup.c b/arch/ppc/syslib/m8260_setup.c
--- a/arch/ppc/syslib/m8260_setup.c	2005-03-29 10:36:16 -06:00
+++ b/arch/ppc/syslib/m8260_setup.c	2005-03-29 10:36:16 -06:00
@@ -167,18 +167,12 @@
 static void __init
 m8260_init_IRQ(void)
 {
-	int i;
-
-        for ( i = 0 ; i < NR_SIU_INTS ; i++ )
-                irq_desc[i].handler = &cpm2_pic;
+	cpm2_init_IRQ();
 
 	/* Initialize the default interrupt mapping priorities,
 	 * in case the boot rom changed something on us.
 	 */
-	cpm2_immr->im_intctl.ic_sicr = 0;
 	cpm2_immr->im_intctl.ic_siprr = 0x05309770;
-	cpm2_immr->im_intctl.ic_scprrh = 0x05309770;
-	cpm2_immr->im_intctl.ic_scprrl = 0x05309770;
 }
 
 /*
diff -Nru a/include/asm-ppc/irq.h b/include/asm-ppc/irq.h
--- a/include/asm-ppc/irq.h	2005-03-29 10:36:16 -06:00
+++ b/include/asm-ppc/irq.h	2005-03-29 10:36:16 -06:00
@@ -171,7 +171,7 @@
 
 #define	NR_IRQS	(NR_IPIC_INTS)
 
-#elif defined(CONFIG_CPM2) && defined(CONFIG_85xx)
+#elif defined(CONFIG_85xx)
 /* Now include the board configuration specific associations.
 */
 #include <asm/mpc85xx.h>
@@ -186,7 +186,7 @@
 #define NR_CPM_INTS	64
 #define NR_EPIC_INTS	44
 #ifndef NR_8259_INTS
-#define NR_8259_INTS 0
+#define NR_8259_INTS	0
 #endif
 #define NUM_8259_INTERRUPTS NR_8259_INTS
 
@@ -196,13 +196,59 @@
 
 #define NR_IRQS	(NR_EPIC_INTS + NR_CPM_INTS + NR_8259_INTS)
 
-/* These values must be zero-based and map 1:1 with the EPIC configuration.
- * They are used throughout the 8560 I/O subsystem to generate
- * interrupt masks, flags, and other control patterns.  This is why the
- * current kernel assumption of the 8259 as the base controller is such
- * a pain in the butt.
- */
+/* Internal IRQs on MPC85xx OpenPIC */
+
+#ifndef MPC85xx_OPENPIC_IRQ_OFFSET
+#ifdef CONFIG_CPM2
+#define MPC85xx_OPENPIC_IRQ_OFFSET	(CPM_IRQ_OFFSET + NR_CPM_INTS)
+#else
+#define MPC85xx_OPENPIC_IRQ_OFFSET	0
+#endif
+#endif
+
+/* Not all of these exist on all MPC85xx implementations */
+#define MPC85xx_IRQ_L2CACHE	( 0 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_ECM		( 1 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_DDR		( 2 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_LBIU	( 3 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_DMA0	( 4 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_DMA1	( 5 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_DMA2	( 6 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_DMA3	( 7 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_PCI1	( 8 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_PCI2	( 9 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_RIO_ERROR	( 9 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_RIO_BELL	(10 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_RIO_TX	(11 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_RIO_RX	(12 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_TSEC1_TX	(13 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_TSEC1_RX	(14 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_TSEC1_ERROR	(18 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_TSEC2_TX	(19 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_TSEC2_RX	(20 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_TSEC2_ERROR	(24 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_FEC		(25 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_DUART	(26 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_IIC1	(27 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_PERFMON	(28 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_SEC2	(29 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_CPM		(30 + MPC85xx_OPENPIC_IRQ_OFFSET)
+
+/* The 12 external interrupt lines */
+#define MPC85xx_IRQ_EXT0        (32 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_EXT1        (33 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_EXT2        (34 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_EXT3        (35 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_EXT4        (36 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_EXT5        (37 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_EXT6        (38 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_EXT7        (39 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_EXT8        (40 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_EXT9        (41 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_EXT10       (42 + MPC85xx_OPENPIC_IRQ_OFFSET)
+#define MPC85xx_IRQ_EXT11       (43 + MPC85xx_OPENPIC_IRQ_OFFSET)
 
+/* CPM related interrupts */
 #define	SIU_INT_ERROR		((uint)0x00+CPM_IRQ_OFFSET)
 #define	SIU_INT_I2C		((uint)0x01+CPM_IRQ_OFFSET)
 #define	SIU_INT_SPI		((uint)0x02+CPM_IRQ_OFFSET)
@@ -267,57 +313,62 @@
  * (Document errata updates have fixed this...make sure you have up to
  * date processor documentation -- Dan).
  */
-#define NR_SIU_INTS	64
 
-#define	SIU_INT_ERROR		((uint)0x00)
-#define	SIU_INT_I2C		((uint)0x01)
-#define	SIU_INT_SPI		((uint)0x02)
-#define	SIU_INT_RISC		((uint)0x03)
-#define	SIU_INT_SMC1		((uint)0x04)
-#define	SIU_INT_SMC2		((uint)0x05)
-#define	SIU_INT_IDMA1		((uint)0x06)
-#define	SIU_INT_IDMA2		((uint)0x07)
-#define	SIU_INT_IDMA3		((uint)0x08)
-#define	SIU_INT_IDMA4		((uint)0x09)
-#define	SIU_INT_SDMA		((uint)0x0a)
-#define	SIU_INT_TIMER1		((uint)0x0c)
-#define	SIU_INT_TIMER2		((uint)0x0d)
-#define	SIU_INT_TIMER3		((uint)0x0e)
-#define	SIU_INT_TIMER4		((uint)0x0f)
-#define	SIU_INT_TMCNT		((uint)0x10)
-#define	SIU_INT_PIT		((uint)0x11)
-#define	SIU_INT_IRQ1		((uint)0x13)
-#define	SIU_INT_IRQ2		((uint)0x14)
-#define	SIU_INT_IRQ3		((uint)0x15)
-#define	SIU_INT_IRQ4		((uint)0x16)
-#define	SIU_INT_IRQ5		((uint)0x17)
-#define	SIU_INT_IRQ6		((uint)0x18)
-#define	SIU_INT_IRQ7		((uint)0x19)
-#define	SIU_INT_FCC1		((uint)0x20)
-#define	SIU_INT_FCC2		((uint)0x21)
-#define	SIU_INT_FCC3		((uint)0x22)
-#define	SIU_INT_MCC1		((uint)0x24)
-#define	SIU_INT_MCC2		((uint)0x25)
-#define	SIU_INT_SCC1		((uint)0x28)
-#define	SIU_INT_SCC2		((uint)0x29)
-#define	SIU_INT_SCC3		((uint)0x2a)
-#define	SIU_INT_SCC4		((uint)0x2b)
-#define	SIU_INT_PC15		((uint)0x30)
-#define	SIU_INT_PC14		((uint)0x31)
-#define	SIU_INT_PC13		((uint)0x32)
-#define	SIU_INT_PC12		((uint)0x33)
-#define	SIU_INT_PC11		((uint)0x34)
-#define	SIU_INT_PC10		((uint)0x35)
-#define	SIU_INT_PC9		((uint)0x36)
-#define	SIU_INT_PC8		((uint)0x37)
-#define	SIU_INT_PC7		((uint)0x38)
-#define	SIU_INT_PC6		((uint)0x39)
-#define	SIU_INT_PC5		((uint)0x3a)
-#define	SIU_INT_PC4		((uint)0x3b)
-#define	SIU_INT_PC3		((uint)0x3c)
-#define	SIU_INT_PC2		((uint)0x3d)
-#define	SIU_INT_PC1		((uint)0x3e)
-#define	SIU_INT_PC0		((uint)0x3f)
+#ifndef CPM_IRQ_OFFSET
+#define CPM_IRQ_OFFSET	0
+#endif
+
+#define NR_CPM_INTS	64
+
+#define	SIU_INT_ERROR		((uint)0x00 + CPM_IRQ_OFFSET)
+#define	SIU_INT_I2C		((uint)0x01 + CPM_IRQ_OFFSET)
+#define	SIU_INT_SPI		((uint)0x02 + CPM_IRQ_OFFSET)
+#define	SIU_INT_RISC		((uint)0x03 + CPM_IRQ_OFFSET)
+#define	SIU_INT_SMC1		((uint)0x04 + CPM_IRQ_OFFSET)
+#define	SIU_INT_SMC2		((uint)0x05 + CPM_IRQ_OFFSET)
+#define	SIU_INT_IDMA1		((uint)0x06 + CPM_IRQ_OFFSET)
+#define	SIU_INT_IDMA2		((uint)0x07 + CPM_IRQ_OFFSET)
+#define	SIU_INT_IDMA3		((uint)0x08 + CPM_IRQ_OFFSET)
+#define	SIU_INT_IDMA4		((uint)0x09 + CPM_IRQ_OFFSET)
+#define	SIU_INT_SDMA		((uint)0x0a + CPM_IRQ_OFFSET)
+#define	SIU_INT_TIMER1		((uint)0x0c + CPM_IRQ_OFFSET)
+#define	SIU_INT_TIMER2		((uint)0x0d + CPM_IRQ_OFFSET)
+#define	SIU_INT_TIMER3		((uint)0x0e + CPM_IRQ_OFFSET)
+#define	SIU_INT_TIMER4		((uint)0x0f + CPM_IRQ_OFFSET)
+#define	SIU_INT_TMCNT		((uint)0x10 + CPM_IRQ_OFFSET)
+#define	SIU_INT_PIT		((uint)0x11 + CPM_IRQ_OFFSET)
+#define	SIU_INT_IRQ1		((uint)0x13 + CPM_IRQ_OFFSET)
+#define	SIU_INT_IRQ2		((uint)0x14 + CPM_IRQ_OFFSET)
+#define	SIU_INT_IRQ3		((uint)0x15 + CPM_IRQ_OFFSET)
+#define	SIU_INT_IRQ4		((uint)0x16 + CPM_IRQ_OFFSET)
+#define	SIU_INT_IRQ5		((uint)0x17 + CPM_IRQ_OFFSET)
+#define	SIU_INT_IRQ6		((uint)0x18 + CPM_IRQ_OFFSET)
+#define	SIU_INT_IRQ7		((uint)0x19 + CPM_IRQ_OFFSET)
+#define	SIU_INT_FCC1		((uint)0x20 + CPM_IRQ_OFFSET)
+#define	SIU_INT_FCC2		((uint)0x21 + CPM_IRQ_OFFSET)
+#define	SIU_INT_FCC3		((uint)0x22 + CPM_IRQ_OFFSET)
+#define	SIU_INT_MCC1		((uint)0x24 + CPM_IRQ_OFFSET)
+#define	SIU_INT_MCC2		((uint)0x25 + CPM_IRQ_OFFSET)
+#define	SIU_INT_SCC1		((uint)0x28 + CPM_IRQ_OFFSET)
+#define	SIU_INT_SCC2		((uint)0x29 + CPM_IRQ_OFFSET)
+#define	SIU_INT_SCC3		((uint)0x2a + CPM_IRQ_OFFSET)
+#define	SIU_INT_SCC4		((uint)0x2b + CPM_IRQ_OFFSET)
+#define	SIU_INT_PC15		((uint)0x30 + CPM_IRQ_OFFSET)
+#define	SIU_INT_PC14		((uint)0x31 + CPM_IRQ_OFFSET)
+#define	SIU_INT_PC13		((uint)0x32 + CPM_IRQ_OFFSET)
+#define	SIU_INT_PC12		((uint)0x33 + CPM_IRQ_OFFSET)
+#define	SIU_INT_PC11		((uint)0x34 + CPM_IRQ_OFFSET)
+#define	SIU_INT_PC10		((uint)0x35 + CPM_IRQ_OFFSET)
+#define	SIU_INT_PC9		((uint)0x36 + CPM_IRQ_OFFSET)
+#define	SIU_INT_PC8		((uint)0x37 + CPM_IRQ_OFFSET)
+#define	SIU_INT_PC7		((uint)0x38 + CPM_IRQ_OFFSET)
+#define	SIU_INT_PC6		((uint)0x39 + CPM_IRQ_OFFSET)
+#define	SIU_INT_PC5		((uint)0x3a + CPM_IRQ_OFFSET)
+#define	SIU_INT_PC4		((uint)0x3b + CPM_IRQ_OFFSET)
+#define	SIU_INT_PC3		((uint)0x3c + CPM_IRQ_OFFSET)
+#define	SIU_INT_PC2		((uint)0x3d + CPM_IRQ_OFFSET)
+#define	SIU_INT_PC1		((uint)0x3e + CPM_IRQ_OFFSET)
+#define	SIU_INT_PC0		((uint)0x3f + CPM_IRQ_OFFSET)
 
 #endif /* CONFIG_8260 */
 
diff -Nru a/include/asm-ppc/mpc85xx.h b/include/asm-ppc/mpc85xx.h
--- a/include/asm-ppc/mpc85xx.h	2005-03-29 10:36:16 -06:00
+++ b/include/asm-ppc/mpc85xx.h	2005-03-29 10:36:16 -06:00
@@ -52,55 +52,6 @@
  */
 extern unsigned char __res[];
 
-/* Internal IRQs on MPC85xx OpenPIC */
-/* Not all of these exist on all MPC85xx implementations */
-
-#ifndef MPC85xx_OPENPIC_IRQ_OFFSET
-#define MPC85xx_OPENPIC_IRQ_OFFSET	64
-#endif
-
-/* The 32 internal sources */
-#define MPC85xx_IRQ_L2CACHE	( 0 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_ECM		( 1 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_DDR		( 2 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_LBIU	( 3 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_DMA0	( 4 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_DMA1	( 5 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_DMA2	( 6 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_DMA3	( 7 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_PCI1	( 8 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_PCI2	( 9 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_RIO_ERROR	( 9 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_RIO_BELL	(10 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_RIO_TX	(11 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_RIO_RX	(12 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_TSEC1_TX	(13 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_TSEC1_RX	(14 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_TSEC1_ERROR	(18 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_TSEC2_TX	(19 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_TSEC2_RX	(20 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_TSEC2_ERROR	(24 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_FEC		(25 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_DUART	(26 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_IIC1	(27 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_PERFMON	(28 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_SEC2	(29 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_CPM		(30 + MPC85xx_OPENPIC_IRQ_OFFSET)
-
-/* The 12 external interrupt lines */
-#define MPC85xx_IRQ_EXT0        (32 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT1        (33 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT2        (34 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT3        (35 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT4        (36 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT5        (37 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT6        (38 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT7        (39 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT8        (40 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT9        (41 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT10       (42 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT11       (43 + MPC85xx_OPENPIC_IRQ_OFFSET)
-
 /* Offset from CCSRBAR */
 #define MPC85xx_CPM_OFFSET	(0x80000)
 #define MPC85xx_CPM_SIZE	(0x40000)
