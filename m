Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265178AbUELTHC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265178AbUELTHC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 15:07:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265179AbUELTFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 15:05:53 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:46777 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S265178AbUELS4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 14:56:16 -0400
From: mporter@kernel.crashing.org
Message-Id: <200405121856.LAA13744@liberty.homelinux.org>
Subject: [PATCH 5/8] PPC32: 4xx core fixes and 440gx PIC support
To: akpm@osdl.org
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Date: Wed, 12 May 2004 11:55:55 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Merge misc. 4xx core fixes and support for the new
cascade scheme in the 440gx. Please apply.

diff -Nru a/arch/ppc/boot/simple/embed_config.c b/arch/ppc/boot/simple/embed_config.c
--- a/arch/ppc/boot/simple/embed_config.c	Wed May 12 09:24:49 2004
+++ b/arch/ppc/boot/simple/embed_config.c	Wed May 12 09:24:49 2004
@@ -705,7 +705,7 @@
 #ifdef CONFIG_IBM_OPENBIOS
 /* This could possibly work for all treeboot roms.
 */
-#if defined(CONFIG_ASH) || defined(CONFIG_BEECH)
+#if defined(CONFIG_ASH) || defined(CONFIG_BEECH) || defined(CONFIG_BUBINGA)
 #define BOARD_INFO_VECTOR       0xFFF80B50 /* openbios 1.19 moved this vector down  - armin */
 #else
 #define BOARD_INFO_VECTOR	0xFFFE0B50
@@ -742,7 +742,7 @@
 	 */
 	mtdcr(DCRN_MALCR(DCRN_MAL_BASE), MALCR_MMSR);     /* 1st reset MAL */
 	while (mfdcr(DCRN_MALCR(DCRN_MAL_BASE)) & MALCR_MMSR) {}; /* wait for the reset */	
-	out_be32(EMAC0_BASE,0x20000000);        /* then reset EMAC */
+	out_be32((volatile u32*)EMAC0_BASE,0x20000000);        /* then reset EMAC */
 #endif
 
 	bd = &bdinfo;
diff -Nru a/arch/ppc/kernel/ppc_ksyms.c b/arch/ppc/kernel/ppc_ksyms.c
--- a/arch/ppc/kernel/ppc_ksyms.c	Wed May 12 09:24:49 2004
+++ b/arch/ppc/kernel/ppc_ksyms.c	Wed May 12 09:24:49 2004
@@ -336,7 +336,7 @@
 EXPORT_SYMBOL(cpm_install_handler);
 EXPORT_SYMBOL(cpm_free_handler);
 #endif /* CONFIG_8xx */
-#if defined(CONFIG_8xx) || defined(CONFIG_4xx)
+#if defined(CONFIG_8xx) || defined(CONFIG_40x)
 EXPORT_SYMBOL(__res);
 #endif
 #if defined(CONFIG_8xx)
diff -Nru a/arch/ppc/syslib/ppc405_pci.c b/arch/ppc/syslib/ppc405_pci.c
--- a/arch/ppc/syslib/ppc405_pci.c	Wed May 12 09:24:49 2004
+++ b/arch/ppc/syslib/ppc405_pci.c	Wed May 12 09:24:49 2004
@@ -57,14 +57,6 @@
 		    )
 		    ) {
 
-			DBG(KERN_ERR "PCI: 0x%lx <= resource[%d] <= 0x%lx"
-			    ", bus 0x%x dev 0x%2.2x.%1.1x,\n"
-			    KERN_ERR "  %s\n"
-			    KERN_ERR "  fixup will be attempted later\n",
-			    min_host_addr, i, max_host_addr,
-			    dev->bus->number, PCI_SLOT(dev->devfn),
-			    PCI_FUNC(dev->devfn), dev->slot.name);
-
 			/* force pcibios_assign_resources() to assign a new address */
 			res->end -= res->start;
 			res->start = 0;
diff -Nru a/arch/ppc/syslib/ppc4xx_pic.c b/arch/ppc/syslib/ppc4xx_pic.c
--- a/arch/ppc/syslib/ppc4xx_pic.c	Wed May 12 09:24:49 2004
+++ b/arch/ppc/syslib/ppc4xx_pic.c	Wed May 12 09:24:49 2004
@@ -142,9 +142,12 @@
 #ifndef UIC1
 #define UIC1 UIC0
 #endif
+#ifndef UIC2
+#define UIC2 UIC1
+#endif
 
 static void
-ppc405_uic_enable(unsigned int irq)
+ppc4xx_uic_enable(unsigned int irq)
 {
 	int bit, word;
 	irq_desc_t *desc = irq_desc + irq;
@@ -153,7 +156,7 @@
 	word = irq >> 5;
 
 #ifdef UIC_DEBUG
-	printk("ppc405_uic_enable - irq %d word %d bit 0x%x\n", irq, word, bit);
+	printk("ppc4xx_uic_enable - irq %d word %d bit 0x%x\n", irq, word, bit);
 #endif
 	ppc_cached_irq_mask[word] |= 1 << (31 - bit);
 	switch (word) {
@@ -162,38 +165,35 @@
 		if ((mfdcr(DCRN_UIC_TR(UIC0)) & (1 << (31 - bit))) == 0)
 			desc->status |= IRQ_LEVEL;
 		else
-		/* lets hope this works since in linux/irq.h
-		 * there is no define for EDGE and it's assumed
-		 * once you set status to LEVEL you would not
-		 * want to change it - Armin
-		 */
-		desc->status = desc->status & ~IRQ_LEVEL;
+			desc->status = desc->status & ~IRQ_LEVEL;
 		break;
 	case 1:
 		mtdcr(DCRN_UIC_ER(UIC1), ppc_cached_irq_mask[word]);
 		if ((mfdcr(DCRN_UIC_TR(UIC1)) & (1 << (31 - bit))) == 0)
 			desc->status |= IRQ_LEVEL;
 		else
-		/* lets hope this works since in linux/irq.h
-		 * there is no define for EDGE and it's assumed
-		 * once you set status to LEVEL you would not
-		 * want to change it - Armin
-		 */
-		desc->status = desc->status & ~IRQ_LEVEL;
+			desc->status = desc->status & ~IRQ_LEVEL;
+	break;
+	case 2:
+		mtdcr(DCRN_UIC_ER(UIC2), ppc_cached_irq_mask[word]);
+		if ((mfdcr(DCRN_UIC_TR(UIC2)) & (1 << (31 - bit))) == 0)
+			desc->status |= IRQ_LEVEL;
+		else
+			desc->status = desc->status & ~IRQ_LEVEL;
 	break;
 	}
 
 }
 
 static void
-ppc405_uic_disable(unsigned int irq)
+ppc4xx_uic_disable(unsigned int irq)
 {
 	int bit, word;
 
 	bit = irq & 0x1f;
 	word = irq >> 5;
 #ifdef UIC_DEBUG
-	printk("ppc405_uic_disable - irq %d word %d bit 0x%x\n", irq, word,
+	printk("ppc4xx_uic_disable - irq %d word %d bit 0x%x\n", irq, word,
 	       bit);
 #endif
 	ppc_cached_irq_mask[word] &= ~(1 << (31 - bit));
@@ -204,11 +204,14 @@
 	case 1:
 		mtdcr(DCRN_UIC_ER(UIC1), ppc_cached_irq_mask[word]);
 		break;
+	case 2:
+		mtdcr(DCRN_UIC_ER(UIC2), ppc_cached_irq_mask[word]);
+		break;
 	}
 }
 
 static void
-ppc405_uic_disable_and_ack(unsigned int irq)
+ppc4xx_uic_disable_and_ack(unsigned int irq)
 {
 	int bit, word;
 
@@ -216,7 +219,7 @@
 	word = irq >> 5;
 
 #ifdef UIC_DEBUG
-	printk("ppc405_uic_disable_and_ack - irq %d word %d bit 0x%x\n", irq,
+	printk("ppc4xx_uic_disable_and_ack - irq %d word %d bit 0x%x\n", irq,
 	       word, bit);
 #endif
 	ppc_cached_irq_mask[word] &= ~(1 << (31 - bit));
@@ -224,16 +227,30 @@
 	case 0:
 		mtdcr(DCRN_UIC_ER(UIC0), ppc_cached_irq_mask[word]);
 		mtdcr(DCRN_UIC_SR(UIC0), (1 << (31 - bit)));
+#if (NR_UICS > 2)
+		mtdcr(DCRN_UIC_SR(UICB), UICB_UIC0NC);
+#endif
 		break;
 	case 1:
 		mtdcr(DCRN_UIC_ER(UIC1), ppc_cached_irq_mask[word]);
 		mtdcr(DCRN_UIC_SR(UIC1), (1 << (31 - bit)));
+#if (NR_UICS > 2)
+		mtdcr(DCRN_UIC_SR(UICB), UICB_UIC1NC);
+#endif
+		break;
+	case 2:
+		mtdcr(DCRN_UIC_ER(UIC2), ppc_cached_irq_mask[word]);
+		mtdcr(DCRN_UIC_SR(UIC2), (1 << (31 - bit)));
+#if (NR_UICS > 2)
+		mtdcr(DCRN_UIC_SR(UICB), UICB_UIC2NC);
+#endif
 		break;
 	}
+
 }
 
 static void
-ppc405_uic_end(unsigned int irq)
+ppc4xx_uic_end(unsigned int irq)
 {
 	int bit, word;
 	unsigned int tr_bits;
@@ -242,7 +259,7 @@
 	word = irq >> 5;
 
 #ifdef UIC_DEBUG
-	printk("ppc405_uic_end - irq %d word %d bit 0x%x\n", irq, word, bit);
+	printk("ppc4xx_uic_end - irq %d word %d bit 0x%x\n", irq, word, bit);
 #endif
 
 	switch (word) {
@@ -259,9 +276,21 @@
 		switch (word) {
 		case 0:
 			mtdcr(DCRN_UIC_SR(UIC0), 1 << (31 - bit));
+#if (NR_UICS > 2)
+			mtdcr(DCRN_UIC_SR(UICB),  UICB_UIC0NC);
+#endif
 			break;
 		case 1:
 			mtdcr(DCRN_UIC_SR(UIC1), 1 << (31 - bit));
+#if (NR_UICS > 2)
+			mtdcr(DCRN_UIC_SR(UICB),  UICB_UIC1NC);
+#endif
+			break;
+		case 2:
+			mtdcr(DCRN_UIC_SR(UIC2), 1 << (31 - bit));
+#if (NR_UICS > 2)
+			mtdcr(DCRN_UIC_SR(UICB),  UICB_UIC2NC);
+#endif
 			break;
 		}
 	}
@@ -275,11 +304,14 @@
 		case 1:
 			mtdcr(DCRN_UIC_ER(UIC1), ppc_cached_irq_mask[word]);
 			break;
+		case 2:
+			mtdcr(DCRN_UIC_ER(UIC2), ppc_cached_irq_mask[word]);
+			break;
 		}
 	}
 }
 
-static struct hw_interrupt_type ppc405_uic = {
+static struct hw_interrupt_type ppc4xx_uic = {
 #if (NR_UICS == 1)
 	"IBM UIC",
 #else
@@ -287,15 +319,15 @@
 #endif
 	NULL,
 	NULL,
-	ppc405_uic_enable,
-	ppc405_uic_disable,
-	ppc405_uic_disable_and_ack,
-	ppc405_uic_end,
+	ppc4xx_uic_enable,
+	ppc4xx_uic_disable,
+	ppc4xx_uic_disable_and_ack,
+	ppc4xx_uic_end,
 	0
 };
 
 int
-ppc405_pic_get_irq(struct pt_regs *regs)
+ppc4xx_pic_get_irq(struct pt_regs *regs)
 {
 	int irq, cas_irq;
 	unsigned long bits;
@@ -305,9 +337,25 @@
 	 * enabled.
 	 */
 
+#if (NR_UICS > 2)
+	bits = mfdcr(DCRN_UIC_MSR(UICB));
+#else
 	bits = mfdcr(DCRN_UIC_MSR(UIC0));
-
-#if (NR_UICS > 1)
+#endif
+#if (NR_UICS > 2)
+	if (bits & UICB_UIC0NC) {
+		bits = mfdcr(DCRN_UIC_MSR(UIC0));
+		irq = 32 - ffs(bits);
+	} else if (bits & UICB_UIC1NC) {
+		bits = mfdcr(DCRN_UIC_MSR(UIC1));
+		irq = 64 - ffs(bits);
+	} else if (bits & UICB_UIC2NC) {
+		bits = mfdcr(DCRN_UIC_MSR(UIC2));
+		irq = 96 - ffs(bits);
+	} else {
+		irq = -1;
+	}
+#elif (NR_UICS > 1)
 	if (bits & UIC_CASCADE_MASK) {
 		bits = mfdcr(DCRN_UIC_MSR(UIC1));
 		cas_irq = 32 - ffs(bits);
@@ -330,7 +378,7 @@
 		irq = -1;
 
 #ifdef UIC_DEBUG
-	printk("ppc405_pic_get_irq - irq %d bit 0x%x\n", irq, bits);
+	printk("ppc4xx_pic_get_irq - irq %d bit 0x%x\n", irq, bits);
 #endif
 
 	return (irq);
@@ -354,8 +402,10 @@
 	unsigned long ppc_cached_pol_mask[NR_MASK_WORDS];
 	ppc_cached_sense_mask[0] = 0;
 	ppc_cached_sense_mask[1] = 0;
+	ppc_cached_sense_mask[2] = 0;
 	ppc_cached_pol_mask[0] = 0;
 	ppc_cached_pol_mask[1] = 0;
+	ppc_cached_pol_mask[2] = 0;
 
 	for (irq = 0; irq < NR_IRQS; irq++) {
 
@@ -398,6 +448,18 @@
 			mtdcr(DCRN_UIC_TR(UIC1), ppc_cached_sense_mask[word]);
 
 			break;
+		case 2:
+#ifdef PPC4xx_PIC_DEBUG
+			printk("Pol %x ", mfdcr(DCRN_UIC_PR(UIC2)));
+			printk("Level %x\n", mfdcr(DCRN_UIC_TR(UIC2)));
+#endif
+			/* polarity  setting */
+			mtdcr(DCRN_UIC_PR(UIC2), ppc_cached_pol_mask[word]);
+
+			/* Level setting */
+			mtdcr(DCRN_UIC_TR(UIC2), ppc_cached_sense_mask[word]);
+
+			break;
 		}
 	}
 
@@ -405,13 +467,13 @@
 void __init
 ppc4xx_pic_init(void)
 {
-
 	/*
 	 * Disable all external interrupts until they are
 	 * explicity requested.
 	 */
 	ppc_cached_irq_mask[0] = 0;
 	ppc_cached_irq_mask[1] = 0;
+	ppc_cached_irq_mask[2] = 0;
 
 #if defined CONFIG_403
 	mtdcr(DCRN_EXIER, ppc_cached_irq_mask[0]);
@@ -419,11 +481,21 @@
 	ppc4xx_pic = &ppc403_aic;
 	ppc_md.get_irq = ppc403_pic_get_irq;
 #else
+#if  (NR_UICS > 2)
+	mtdcr(DCRN_UIC_ER(UICB), UICB_UIC0NC | UICB_UIC1NC | UICB_UIC2NC);
+	mtdcr(DCRN_UIC_CR(UICB), 0);
+
+	mtdcr(DCRN_UIC_ER(UIC2), ppc_cached_irq_mask[2]);
+	mtdcr(DCRN_UIC_CR(UIC2), 0);
+
+#endif
 #if  (NR_UICS > 1)
-	ppc_cached_irq_mask[0] |= 1 << (31 - UIC0_UIC1NC);	/* enable cascading interrupt */
+#if  (NR_UICS == 2)
+	/* enable cascading interrupt */
+	ppc_cached_irq_mask[0] |= 1 << (31 - UIC0_UIC1NC);
+#endif
 	mtdcr(DCRN_UIC_ER(UIC1), ppc_cached_irq_mask[1]);
 	mtdcr(DCRN_UIC_CR(UIC1), 0);
-
 #endif
 	mtdcr(DCRN_UIC_ER(UIC0), ppc_cached_irq_mask[0]);
 	mtdcr(DCRN_UIC_CR(UIC0), 0);
@@ -432,13 +504,16 @@
 		ppc4xx_extpic_init();
 
 	/* Clear any pending interrupts */
+#if (NR_UICS > 2)
+	mtdcr(DCRN_UIC_SR(UICB), 0xffffffff);
+	mtdcr(DCRN_UIC_SR(UIC2), 0xffffffff);
+#endif
 #if (NR_UICS > 1)
 	mtdcr(DCRN_UIC_SR(UIC1), 0xffffffff);
 #endif
 	mtdcr(DCRN_UIC_SR(UIC0), 0xffffffff);
 
-	ppc4xx_pic = &ppc405_uic;
-	ppc_md.get_irq = ppc405_pic_get_irq;
+	ppc4xx_pic = &ppc4xx_uic;
+	ppc_md.get_irq = ppc4xx_pic_get_irq;
 #endif
-
 }
