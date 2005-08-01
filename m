Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbVHAQE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbVHAQE4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 12:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbVHAQE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 12:04:56 -0400
Received: from mo00.iij4u.or.jp ([210.130.0.19]:20987 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261299AbVHAQEy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 12:04:54 -0400
Date: Tue, 2 Aug 2005 01:04:46 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] mips: update IRQ handling for vr41xx
Message-Id: <20050802010446.61ea5628.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch has updated IRQ handling for vr41xx.
o added common IRQ dispatch
o changed IRQ number in int-handler.S
o added resource management to icu.c

This patch already has been applied to mips tree.
Please apply.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff linux-2.6.13-rc4-git2-orig/arch/mips/vr41xx/common/Makefile linux-2.6.13-rc4-git2/arch/mips/vr41xx/common/Makefile
--- linux-2.6.13-rc4-git2-orig/arch/mips/vr41xx/common/Makefile	2005-07-29 07:44:44.000000000 +0900
+++ linux-2.6.13-rc4-git2/arch/mips/vr41xx/common/Makefile	2005-07-31 01:20:03.000000000 +0900
@@ -2,7 +2,7 @@
 # Makefile for common code of the NEC VR4100 series.
 #
 
-obj-y				+= bcu.o cmu.o icu.o init.o int-handler.o pmu.o
+obj-y				+= bcu.o cmu.o icu.o init.o int-handler.o irq.o pmu.o
 obj-$(CONFIG_VRC4173)		+= vrc4173.o
 
 EXTRA_AFLAGS := $(CFLAGS)
diff -urN -X dontdiff linux-2.6.13-rc4-git2-orig/arch/mips/vr41xx/common/icu.c linux-2.6.13-rc4-git2/arch/mips/vr41xx/common/icu.c
--- linux-2.6.13-rc4-git2-orig/arch/mips/vr41xx/common/icu.c	2005-07-29 07:44:44.000000000 +0900
+++ linux-2.6.13-rc4-git2/arch/mips/vr41xx/common/icu.c	2005-07-31 01:20:03.000000000 +0900
@@ -3,8 +3,7 @@
  *
  *  Copyright (C) 2001-2002  MontaVista Software Inc.
  *    Author: Yoichi Yuasa <yyuasa@mvista.com or source@mvista.com>
- *  Copyright (C) 2003-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
- *  Copyright (C) 2005 Ralf Baechle (ralf@linux-mips.org)
+ *  Copyright (C) 2003-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -31,7 +30,7 @@
  */
 #include <linux/errno.h>
 #include <linux/init.h>
-#include <linux/interrupt.h>
+#include <linux/ioport.h>
 #include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/smp.h>
@@ -39,34 +38,24 @@
 
 #include <asm/cpu.h>
 #include <asm/io.h>
-#include <asm/irq.h>
-#include <asm/irq_cpu.h>
 #include <asm/vr41xx/vr41xx.h>
 
-extern asmlinkage void vr41xx_handle_interrupt(void);
-
-extern void init_vr41xx_giuint_irq(void);
-extern void giuint_irq_dispatch(struct pt_regs *regs);
-
-static uint32_t icu1_base;
-static uint32_t icu2_base;
-
-static struct irqaction icu_cascade = {
-	.handler	= no_action,
-	.mask		= CPU_MASK_NONE,
-	.name		= "cascade",
-};
+static void __iomem *icu1_base;
+static void __iomem *icu2_base;
 
 static unsigned char sysint1_assign[16] = {
 	0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
 static unsigned char sysint2_assign[16] = {
-	2, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
+	2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
 
-#define SYSINT1REG_TYPE1	KSEG1ADDR(0x0b000080)
-#define SYSINT2REG_TYPE1	KSEG1ADDR(0x0b000200)
+#define ICU1_TYPE1_BASE	0x0b000080UL
+#define ICU2_TYPE1_BASE	0x0b000200UL
 
-#define SYSINT1REG_TYPE2	KSEG1ADDR(0x0f000080)
-#define SYSINT2REG_TYPE2	KSEG1ADDR(0x0f0000a0)
+#define ICU1_TYPE2_BASE	0x0f000080UL
+#define ICU2_TYPE2_BASE	0x0f0000a0UL
+
+#define ICU1_SIZE	0x20
+#define ICU2_SIZE	0x1c
 
 #define SYSINT1REG	0x00
 #define PIUINTREG	0x02
@@ -106,61 +95,61 @@
 #define SYSINT1_IRQ_TO_PIN(x)	((x) - SYSINT1_IRQ_BASE)	/* Pin 0-15 */
 #define SYSINT2_IRQ_TO_PIN(x)	((x) - SYSINT2_IRQ_BASE)	/* Pin 0-15 */
 
-#define read_icu1(offset)	readw(icu1_base + (offset))
-#define write_icu1(val, offset)	writew((val), icu1_base + (offset))
+#define INT_TO_IRQ(x)		((x) + 2)	/* Int0-4 -> IRQ2-6 */
+
+#define icu1_read(offset)		readw(icu1_base + (offset))
+#define icu1_write(offset, value)	writew((value), icu1_base + (offset))
 
-#define read_icu2(offset)	readw(icu2_base + (offset))
-#define write_icu2(val, offset)	writew((val), icu2_base + (offset))
+#define icu2_read(offset)		readw(icu2_base + (offset))
+#define icu2_write(offset, value)	writew((value), icu2_base + (offset))
 
 #define INTASSIGN_MAX	4
 #define INTASSIGN_MASK	0x0007
 
-static inline uint16_t set_icu1(uint8_t offset, uint16_t set)
+static inline uint16_t icu1_set(uint8_t offset, uint16_t set)
 {
-	uint16_t res;
+	uint16_t data;
 
-	res = read_icu1(offset);
-	res |= set;
-	write_icu1(res, offset);
+	data = icu1_read(offset);
+	data |= set;
+	icu1_write(offset, data);
 
-	return res;
+	return data;
 }
 
-static inline uint16_t clear_icu1(uint8_t offset, uint16_t clear)
+static inline uint16_t icu1_clear(uint8_t offset, uint16_t clear)
 {
-	uint16_t res;
+	uint16_t data;
 
-	res = read_icu1(offset);
-	res &= ~clear;
-	write_icu1(res, offset);
+	data = icu1_read(offset);
+	data &= ~clear;
+	icu1_write(offset, data);
 
-	return res;
+	return data;
 }
 
-static inline uint16_t set_icu2(uint8_t offset, uint16_t set)
+static inline uint16_t icu2_set(uint8_t offset, uint16_t set)
 {
-	uint16_t res;
+	uint16_t data;
 
-	res = read_icu2(offset);
-	res |= set;
-	write_icu2(res, offset);
+	data = icu2_read(offset);
+	data |= set;
+	icu2_write(offset, data);
 
-	return res;
+	return data;
 }
 
-static inline uint16_t clear_icu2(uint8_t offset, uint16_t clear)
+static inline uint16_t icu2_clear(uint8_t offset, uint16_t clear)
 {
-	uint16_t res;
+	uint16_t data;
 
-	res = read_icu2(offset);
-	res &= ~clear;
-	write_icu2(res, offset);
+	data = icu2_read(offset);
+	data &= ~clear;
+	icu2_write(offset, data);
 
-	return res;
+	return data;
 }
 
-/*=======================================================================*/
-
 void vr41xx_enable_piuint(uint16_t mask)
 {
 	irq_desc_t *desc = irq_desc + PIU_IRQ;
@@ -169,7 +158,7 @@
 	if (current_cpu_data.cputype == CPU_VR4111 ||
 	    current_cpu_data.cputype == CPU_VR4121) {
 		spin_lock_irqsave(&desc->lock, flags);
-		set_icu1(MPIUINTREG, mask);
+		icu1_set(MPIUINTREG, mask);
 		spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
@@ -184,7 +173,7 @@
 	if (current_cpu_data.cputype == CPU_VR4111 ||
 	    current_cpu_data.cputype == CPU_VR4121) {
 		spin_lock_irqsave(&desc->lock, flags);
-		clear_icu1(MPIUINTREG, mask);
+		icu1_clear(MPIUINTREG, mask);
 		spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
@@ -199,7 +188,7 @@
 	if (current_cpu_data.cputype == CPU_VR4111 ||
 	    current_cpu_data.cputype == CPU_VR4121) {
 		spin_lock_irqsave(&desc->lock, flags);
-		set_icu1(MAIUINTREG, mask);
+		icu1_set(MAIUINTREG, mask);
 		spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
@@ -214,7 +203,7 @@
 	if (current_cpu_data.cputype == CPU_VR4111 ||
 	    current_cpu_data.cputype == CPU_VR4121) {
 		spin_lock_irqsave(&desc->lock, flags);
-		clear_icu1(MAIUINTREG, mask);
+		icu1_clear(MAIUINTREG, mask);
 		spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
@@ -229,7 +218,7 @@
 	if (current_cpu_data.cputype == CPU_VR4111 ||
 	    current_cpu_data.cputype == CPU_VR4121) {
 		spin_lock_irqsave(&desc->lock, flags);
-		set_icu1(MKIUINTREG, mask);
+		icu1_set(MKIUINTREG, mask);
 		spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
@@ -244,7 +233,7 @@
 	if (current_cpu_data.cputype == CPU_VR4111 ||
 	    current_cpu_data.cputype == CPU_VR4121) {
 		spin_lock_irqsave(&desc->lock, flags);
-		clear_icu1(MKIUINTREG, mask);
+		icu1_clear(MKIUINTREG, mask);
 		spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
@@ -257,7 +246,7 @@
 	unsigned long flags;
 
 	spin_lock_irqsave(&desc->lock, flags);
-	set_icu1(MDSIUINTREG, mask);
+	icu1_set(MDSIUINTREG, mask);
 	spin_unlock_irqrestore(&desc->lock, flags);
 }
 
@@ -269,7 +258,7 @@
 	unsigned long flags;
 
 	spin_lock_irqsave(&desc->lock, flags);
-	clear_icu1(MDSIUINTREG, mask);
+	icu1_clear(MDSIUINTREG, mask);
 	spin_unlock_irqrestore(&desc->lock, flags);
 }
 
@@ -281,7 +270,7 @@
 	unsigned long flags;
 
 	spin_lock_irqsave(&desc->lock, flags);
-	set_icu2(MFIRINTREG, mask);
+	icu2_set(MFIRINTREG, mask);
 	spin_unlock_irqrestore(&desc->lock, flags);
 }
 
@@ -293,7 +282,7 @@
 	unsigned long flags;
 
 	spin_lock_irqsave(&desc->lock, flags);
-	clear_icu2(MFIRINTREG, mask);
+	icu2_clear(MFIRINTREG, mask);
 	spin_unlock_irqrestore(&desc->lock, flags);
 }
 
@@ -308,7 +297,7 @@
 	    current_cpu_data.cputype == CPU_VR4131 ||
 	    current_cpu_data.cputype == CPU_VR4133) {
 		spin_lock_irqsave(&desc->lock, flags);
-		write_icu2(PCIINT0, MPCIINTREG);
+		icu2_write(MPCIINTREG, PCIINT0);
 		spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
@@ -324,7 +313,7 @@
 	    current_cpu_data.cputype == CPU_VR4131 ||
 	    current_cpu_data.cputype == CPU_VR4133) {
 		spin_lock_irqsave(&desc->lock, flags);
-		write_icu2(0, MPCIINTREG);
+		icu2_write(MPCIINTREG, 0);
 		spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
@@ -340,7 +329,7 @@
 	    current_cpu_data.cputype == CPU_VR4131 ||
 	    current_cpu_data.cputype == CPU_VR4133) {
 		spin_lock_irqsave(&desc->lock, flags);
-		write_icu2(SCUINT0, MSCUINTREG);
+		icu2_write(MSCUINTREG, SCUINT0);
 		spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
@@ -356,7 +345,7 @@
 	    current_cpu_data.cputype == CPU_VR4131 ||
 	    current_cpu_data.cputype == CPU_VR4133) {
 		spin_lock_irqsave(&desc->lock, flags);
-		write_icu2(0, MSCUINTREG);
+		icu2_write(MSCUINTREG, 0);
 		spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
@@ -372,7 +361,7 @@
 	    current_cpu_data.cputype == CPU_VR4131 ||
 	    current_cpu_data.cputype == CPU_VR4133) {
 		spin_lock_irqsave(&desc->lock, flags);
-		set_icu2(MCSIINTREG, mask);
+		icu2_set(MCSIINTREG, mask);
 		spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
@@ -388,7 +377,7 @@
 	    current_cpu_data.cputype == CPU_VR4131 ||
 	    current_cpu_data.cputype == CPU_VR4133) {
 		spin_lock_irqsave(&desc->lock, flags);
-		clear_icu2(MCSIINTREG, mask);
+		icu2_clear(MCSIINTREG, mask);
 		spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
@@ -404,7 +393,7 @@
 	    current_cpu_data.cputype == CPU_VR4131 ||
 	    current_cpu_data.cputype == CPU_VR4133) {
 		spin_lock_irqsave(&desc->lock, flags);
-		write_icu2(BCUINTR, MBCUINTREG);
+		icu2_write(MBCUINTREG, BCUINTR);
 		spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
@@ -420,30 +409,28 @@
 	    current_cpu_data.cputype == CPU_VR4131 ||
 	    current_cpu_data.cputype == CPU_VR4133) {
 		spin_lock_irqsave(&desc->lock, flags);
-		write_icu2(0, MBCUINTREG);
+		icu2_write(MBCUINTREG, 0);
 		spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
 
 EXPORT_SYMBOL(vr41xx_disable_bcuint);
 
-/*=======================================================================*/
-
 static unsigned int startup_sysint1_irq(unsigned int irq)
 {
-	set_icu1(MSYSINT1REG, (uint16_t)1 << SYSINT1_IRQ_TO_PIN(irq));
+	icu1_set(MSYSINT1REG, 1 << SYSINT1_IRQ_TO_PIN(irq));
 
 	return 0; /* never anything pending */
 }
 
 static void shutdown_sysint1_irq(unsigned int irq)
 {
-	clear_icu1(MSYSINT1REG, (uint16_t)1 << SYSINT1_IRQ_TO_PIN(irq));
+	icu1_clear(MSYSINT1REG, 1 << SYSINT1_IRQ_TO_PIN(irq));
 }
 
 static void enable_sysint1_irq(unsigned int irq)
 {
-	set_icu1(MSYSINT1REG, (uint16_t)1 << SYSINT1_IRQ_TO_PIN(irq));
+	icu1_set(MSYSINT1REG, 1 << SYSINT1_IRQ_TO_PIN(irq));
 }
 
 #define disable_sysint1_irq	shutdown_sysint1_irq
@@ -452,7 +439,7 @@
 static void end_sysint1_irq(unsigned int irq)
 {
 	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-		set_icu1(MSYSINT1REG, (uint16_t)1 << SYSINT1_IRQ_TO_PIN(irq));
+		icu1_set(MSYSINT1REG, 1 << SYSINT1_IRQ_TO_PIN(irq));
 }
 
 static struct hw_interrupt_type sysint1_irq_type = {
@@ -465,23 +452,21 @@
 	.end		= end_sysint1_irq,
 };
 
-/*=======================================================================*/
-
 static unsigned int startup_sysint2_irq(unsigned int irq)
 {
-	set_icu2(MSYSINT2REG, (uint16_t)1 << SYSINT2_IRQ_TO_PIN(irq));
+	icu2_set(MSYSINT2REG, 1 << SYSINT2_IRQ_TO_PIN(irq));
 
 	return 0; /* never anything pending */
 }
 
 static void shutdown_sysint2_irq(unsigned int irq)
 {
-	clear_icu2(MSYSINT2REG, (uint16_t)1 << SYSINT2_IRQ_TO_PIN(irq));
+	icu2_clear(MSYSINT2REG, 1 << SYSINT2_IRQ_TO_PIN(irq));
 }
 
 static void enable_sysint2_irq(unsigned int irq)
 {
-	set_icu2(MSYSINT2REG, (uint16_t)1 << SYSINT2_IRQ_TO_PIN(irq));
+	icu2_set(MSYSINT2REG, 1 << SYSINT2_IRQ_TO_PIN(irq));
 }
 
 #define disable_sysint2_irq	shutdown_sysint2_irq
@@ -490,7 +475,7 @@
 static void end_sysint2_irq(unsigned int irq)
 {
 	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-		set_icu2(MSYSINT2REG, (uint16_t)1 << SYSINT2_IRQ_TO_PIN(irq));
+		icu2_set(MSYSINT2REG, 1 << SYSINT2_IRQ_TO_PIN(irq));
 }
 
 static struct hw_interrupt_type sysint2_irq_type = {
@@ -503,8 +488,6 @@
 	.end		= end_sysint2_irq,
 };
 
-/*=======================================================================*/
-
 static inline int set_sysint1_assign(unsigned int irq, unsigned char assign)
 {
 	irq_desc_t *desc = irq_desc + irq;
@@ -515,8 +498,8 @@
 
 	spin_lock_irq(&desc->lock);
 
-	intassign0 = read_icu1(INTASSIGN0);
-	intassign1 = read_icu1(INTASSIGN1);
+	intassign0 = icu1_read(INTASSIGN0);
+	intassign1 = icu1_read(INTASSIGN1);
 
 	switch (pin) {
 	case 0:
@@ -556,8 +539,8 @@
 	}
 
 	sysint1_assign[pin] = assign;
-	write_icu1(intassign0, INTASSIGN0);
-	write_icu1(intassign1, INTASSIGN1);
+	icu1_write(INTASSIGN0, intassign0);
+	icu1_write(INTASSIGN1, intassign1);
 
 	spin_unlock_irq(&desc->lock);
 
@@ -574,8 +557,8 @@
 
 	spin_lock_irq(&desc->lock);
 
-	intassign2 = read_icu1(INTASSIGN2);
-	intassign3 = read_icu1(INTASSIGN3);
+	intassign2 = icu1_read(INTASSIGN2);
+	intassign3 = icu1_read(INTASSIGN3);
 
 	switch (pin) {
 	case 0:
@@ -623,8 +606,8 @@
 	}
 
 	sysint2_assign[pin] = assign;
-	write_icu1(intassign2, INTASSIGN2);
-	write_icu1(intassign3, INTASSIGN3);
+	icu1_write(INTASSIGN2, intassign2);
+	icu1_write(INTASSIGN3, intassign3);
 
 	spin_unlock_irq(&desc->lock);
 
@@ -651,88 +634,92 @@
 
 EXPORT_SYMBOL(vr41xx_set_intassign);
 
-/*=======================================================================*/
-
-asmlinkage void irq_dispatch(unsigned char intnum, struct pt_regs *regs)
+static int icu_get_irq(unsigned int irq, struct pt_regs *regs)
 {
 	uint16_t pend1, pend2;
 	uint16_t mask1, mask2;
 	int i;
 
-	pend1 = read_icu1(SYSINT1REG);
-	mask1 = read_icu1(MSYSINT1REG);
+	pend1 = icu1_read(SYSINT1REG);
+	mask1 = icu1_read(MSYSINT1REG);
 
-	pend2 = read_icu2(SYSINT2REG);
-	mask2 = read_icu2(MSYSINT2REG);
+	pend2 = icu2_read(SYSINT2REG);
+	mask2 = icu2_read(MSYSINT2REG);
 
 	mask1 &= pend1;
 	mask2 &= pend2;
 
 	if (mask1) {
 		for (i = 0; i < 16; i++) {
-			if (intnum == sysint1_assign[i] &&
-			    (mask1 & ((uint16_t)1 << i))) {
-				if (i == 8)
-					giuint_irq_dispatch(regs);
-				else
-					do_IRQ(SYSINT1_IRQ(i), regs);
-				return;
-			}
+			if (irq == INT_TO_IRQ(sysint1_assign[i]) && (mask1 & (1 << i)))
+				return SYSINT1_IRQ(i);
 		}
 	}
 
 	if (mask2) {
 		for (i = 0; i < 16; i++) {
-			if (intnum == sysint2_assign[i] &&
-			    (mask2 & ((uint16_t)1 << i))) {
-				do_IRQ(SYSINT2_IRQ(i), regs);
-				return;
-			}
+			if (irq == INT_TO_IRQ(sysint2_assign[i]) && (mask2 & (1 << i)))
+				return SYSINT2_IRQ(i);
 		}
 	}
 
 	printk(KERN_ERR "spurious ICU interrupt: %04x,%04x\n", pend1, pend2);
 
 	atomic_inc(&irq_err_count);
-}
 
-/*=======================================================================*/
+	return -1;
+}
 
 static int __init vr41xx_icu_init(void)
 {
+	unsigned long icu1_start, icu2_start;
+	int i;
+
 	switch (current_cpu_data.cputype) {
 	case CPU_VR4111:
 	case CPU_VR4121:
-		icu1_base = SYSINT1REG_TYPE1;
-		icu2_base = SYSINT2REG_TYPE1;
+		icu1_start = ICU1_TYPE1_BASE;
+		icu2_start = ICU2_TYPE1_BASE;
 		break;
 	case CPU_VR4122:
 	case CPU_VR4131:
 	case CPU_VR4133:
-		icu1_base = SYSINT1REG_TYPE2;
-		icu2_base = SYSINT2REG_TYPE2;
+		icu1_start = ICU1_TYPE2_BASE;
+		icu2_start = ICU2_TYPE2_BASE;
 		break;
 	default:
 		printk(KERN_ERR "ICU: Unexpected CPU of NEC VR4100 series\n");
-		return -EINVAL;
+		return -ENODEV;
 	}
 
-	write_icu1(0, MSYSINT1REG);
-	write_icu1(0xffff, MGIUINTLREG);
+	if (request_mem_region(icu1_start, ICU1_SIZE, "ICU") == NULL)
+		return -EBUSY;
 
-	write_icu2(0, MSYSINT2REG);
-	write_icu2(0xffff, MGIUINTHREG);
+	if (request_mem_region(icu2_start, ICU2_SIZE, "ICU") == NULL) {
+		release_mem_region(icu1_start, ICU1_SIZE);
+		return -EBUSY;
+	}
 
-	return 0;
-}
+	icu1_base = ioremap(icu1_start, ICU1_SIZE);
+	if (icu1_base == NULL) {
+		release_mem_region(icu1_start, ICU1_SIZE);
+		release_mem_region(icu2_start, ICU2_SIZE);
+		return -ENOMEM;
+	}
 
-early_initcall(vr41xx_icu_init);
+	icu2_base = ioremap(icu2_start, ICU2_SIZE);
+	if (icu2_base == NULL) {
+		iounmap(icu1_base);
+		release_mem_region(icu1_start, ICU1_SIZE);
+		release_mem_region(icu2_start, ICU2_SIZE);
+		return -ENOMEM;
+	}
 
-/*=======================================================================*/
+	icu1_write(MSYSINT1REG, 0);
+	icu1_write(MGIUINTLREG, 0xffff);
 
-static inline void init_vr41xx_icu_irq(void)
-{
-	int i;
+	icu2_write(MSYSINT2REG, 0);
+	icu2_write(MGIUINTHREG, 0xffff);
 
 	for (i = SYSINT1_IRQ_BASE; i <= SYSINT1_IRQ_LAST; i++)
 		irq_desc[i].handler = &sysint1_irq_type;
@@ -740,18 +727,13 @@
 	for (i = SYSINT2_IRQ_BASE; i <= SYSINT2_IRQ_LAST; i++)
 		irq_desc[i].handler = &sysint2_irq_type;
 
-	setup_irq(INT0_CASCADE_IRQ, &icu_cascade);
-	setup_irq(INT1_CASCADE_IRQ, &icu_cascade);
-	setup_irq(INT2_CASCADE_IRQ, &icu_cascade);
-	setup_irq(INT3_CASCADE_IRQ, &icu_cascade);
-	setup_irq(INT4_CASCADE_IRQ, &icu_cascade);
-}
+	cascade_irq(INT0_IRQ, icu_get_irq);
+	cascade_irq(INT1_IRQ, icu_get_irq);
+	cascade_irq(INT2_IRQ, icu_get_irq);
+	cascade_irq(INT3_IRQ, icu_get_irq);
+	cascade_irq(INT4_IRQ, icu_get_irq);
 
-void __init arch_init_irq(void)
-{
-	mips_cpu_irq_init(MIPS_CPU_IRQ_BASE);
-	init_vr41xx_icu_irq();
-	init_vr41xx_giuint_irq();
-
-	set_except_vector(0, vr41xx_handle_interrupt);
+	return 0;
 }
+
+core_initcall(vr41xx_icu_init);
diff -urN -X dontdiff linux-2.6.13-rc4-git2-orig/arch/mips/vr41xx/common/int-handler.S linux-2.6.13-rc4-git2/arch/mips/vr41xx/common/int-handler.S
--- linux-2.6.13-rc4-git2-orig/arch/mips/vr41xx/common/int-handler.S	2005-07-29 07:44:44.000000000 +0900
+++ linux-2.6.13-rc4-git2/arch/mips/vr41xx/common/int-handler.S	2005-07-31 01:20:03.000000000 +0900
@@ -71,24 +71,24 @@
 
 		andi	t1, t0, CAUSEF_IP3	# check for Int1
 		bnez	t1, handle_int
-		li	a0, 1
+		li	a0, 3
 
 		andi	t1, t0, CAUSEF_IP4	# check for Int2
 		bnez	t1, handle_int
-		li	a0, 2
+		li	a0, 4
 
 		andi	t1, t0, CAUSEF_IP5	# check for Int3
 		bnez	t1, handle_int
-		li	a0, 3
+		li	a0, 5
 
 		andi	t1, t0, CAUSEF_IP6	# check for Int4
 		bnez	t1, handle_int
-		li	a0, 4
+		li	a0, 6
 
 1:
 		andi	t1, t0, CAUSEF_IP2	# check for Int0
 		bnez	t1, handle_int
-		li	a0, 0
+		li	a0, 2
 
 		andi	t1, t0, CAUSEF_IP0	# check for IP0
 		bnez	t1, handle_irq
diff -urN -X dontdiff linux-2.6.13-rc4-git2-orig/arch/mips/vr41xx/common/irq.c linux-2.6.13-rc4-git2/arch/mips/vr41xx/common/irq.c
--- linux-2.6.13-rc4-git2-orig/arch/mips/vr41xx/common/irq.c	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.13-rc4-git2/arch/mips/vr41xx/common/irq.c	2005-07-31 01:20:08.000000000 +0900
@@ -0,0 +1,94 @@
+/*
+ *  Interrupt handing routines for NEC VR4100 series.
+ *
+ *  Copyright (C) 2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/interrupt.h>
+#include <linux/module.h>
+
+#include <asm/irq_cpu.h>
+#include <asm/system.h>
+#include <asm/vr41xx/vr41xx.h>
+
+typedef struct irq_cascade {
+	int (*get_irq)(unsigned int, struct pt_regs *);
+} irq_cascade_t;
+
+static irq_cascade_t irq_cascade[NR_IRQS] __cacheline_aligned;
+
+static struct irqaction cascade_irqaction = {
+	.handler	= no_action,
+	.mask		= CPU_MASK_NONE,
+	.name		= "cascade",
+};
+
+int cascade_irq(unsigned int irq, int (*get_irq)(unsigned int, struct pt_regs *))
+{
+	int retval = 0;
+
+	if (irq >= NR_IRQS)
+		return -EINVAL;
+
+	if (irq_cascade[irq].get_irq != NULL)
+		free_irq(irq, NULL);
+
+	irq_cascade[irq].get_irq = get_irq;
+
+	if (get_irq != NULL) {
+		retval = setup_irq(irq, &cascade_irqaction);
+		if (retval < 0)
+			irq_cascade[irq].get_irq = NULL;
+	}
+
+	return retval;
+}
+
+EXPORT_SYMBOL_GPL(cascade_irq);
+
+asmlinkage void irq_dispatch(unsigned int irq, struct pt_regs *regs)
+{
+	irq_cascade_t *cascade;
+	irq_desc_t *desc;
+
+	if (irq >= NR_IRQS) {
+		atomic_inc(&irq_err_count);
+		return;
+	}
+
+	cascade = irq_cascade + irq;
+	if (cascade->get_irq != NULL) {
+		unsigned int source_irq = irq;
+		desc = irq_desc + source_irq;
+		desc->handler->ack(source_irq);
+		irq = cascade->get_irq(irq, regs);
+		if (irq < 0)
+			atomic_inc(&irq_err_count);
+		else
+			irq_dispatch(irq, regs);
+		desc->handler->end(source_irq);
+	} else
+		do_IRQ(irq, regs);
+}
+
+extern asmlinkage void vr41xx_handle_interrupt(void);
+
+void __init arch_init_irq(void)
+{
+	mips_cpu_irq_init(MIPS_CPU_IRQ_BASE);
+
+	set_except_vector(0, vr41xx_handle_interrupt);
+}
diff -urN -X dontdiff linux-2.6.13-rc4-git2-orig/include/asm-mips/vr41xx/vr41xx.h linux-2.6.13-rc4-git2/include/asm-mips/vr41xx/vr41xx.h
--- linux-2.6.13-rc4-git2-orig/include/asm-mips/vr41xx/vr41xx.h	2005-07-29 07:44:44.000000000 +0900
+++ linux-2.6.13-rc4-git2/include/asm-mips/vr41xx/vr41xx.h	2005-07-31 01:20:03.000000000 +0900
@@ -7,7 +7,7 @@
  * Copyright (C) 2001, 2002 Paul Mundt
  * Copyright (C) 2002 MontaVista Software, Inc.
  * Copyright (C) 2002 TimeSys Corp.
- * Copyright (C) 2003-2004 Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ * Copyright (C) 2003-2005 Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
@@ -79,11 +79,11 @@
 #define MIPS_CPU_IRQ(x)		(MIPS_CPU_IRQ_BASE + (x))
 #define MIPS_SOFTINT0_IRQ	MIPS_CPU_IRQ(0)
 #define MIPS_SOFTINT1_IRQ	MIPS_CPU_IRQ(1)
-#define INT0_CASCADE_IRQ	MIPS_CPU_IRQ(2)
-#define INT1_CASCADE_IRQ	MIPS_CPU_IRQ(3)
-#define INT2_CASCADE_IRQ	MIPS_CPU_IRQ(4)
-#define INT3_CASCADE_IRQ	MIPS_CPU_IRQ(5)
-#define INT4_CASCADE_IRQ	MIPS_CPU_IRQ(6)
+#define INT0_IRQ		MIPS_CPU_IRQ(2)
+#define INT1_IRQ		MIPS_CPU_IRQ(3)
+#define INT2_IRQ		MIPS_CPU_IRQ(4)
+#define INT3_IRQ		MIPS_CPU_IRQ(5)
+#define INT4_IRQ		MIPS_CPU_IRQ(6)
 #define TIMER_IRQ		MIPS_CPU_IRQ(7)
 
 /* SYINT1 Interrupt Numbers */
@@ -97,7 +97,7 @@
 #define PIU_IRQ			SYSINT1_IRQ(5)
 #define AIU_IRQ			SYSINT1_IRQ(6)
 #define KIU_IRQ			SYSINT1_IRQ(7)
-#define GIUINT_CASCADE_IRQ	SYSINT1_IRQ(8)
+#define GIUINT_IRQ		SYSINT1_IRQ(8)
 #define SIU_IRQ			SYSINT1_IRQ(9)
 #define BUSERR_IRQ		SYSINT1_IRQ(10)
 #define SOFTINT_IRQ		SYSINT1_IRQ(11)
@@ -128,7 +128,7 @@
 #define GIU_IRQ_LAST		GIU_IRQ(31)
 
 extern int vr41xx_set_intassign(unsigned int irq, unsigned char intassign);
-extern int vr41xx_cascade_irq(unsigned int irq, int (*get_irq_number)(int irq));
+extern int cascade_irq(unsigned int irq, int (*get_irq)(unsigned int, struct pt_regs *));
 
 #define PIUINT_COMMAND		0x0040
 #define PIUINT_DATA		0x0020
