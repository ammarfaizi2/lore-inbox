Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbWEQA27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbWEQA27 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWEQA2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:28:11 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:12445 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932327AbWEQARl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:17:41 -0400
Date: Wed, 17 May 2006 02:17:25 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 28/50] genirq: ARM: arm/common: convert irq handling
Message-ID: <20060517001725.GC12877@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Convert the files in arch/arm/common to use the generic
irq handling functions.
---
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

 arch/arm/common/gic.c        |   18 ++++++++++++++++--
 arch/arm/common/locomo.c     |    2 +-
 arch/arm/common/sa1111.c     |   10 +++++-----
 arch/arm/common/time-acorn.c |    1 +
 4 files changed, 23 insertions(+), 8 deletions(-)

Index: linux-genirq.q/arch/arm/common/gic.c
===================================================================
--- linux-genirq.q.orig/arch/arm/common/gic.c
+++ linux-genirq.q/arch/arm/common/gic.c
@@ -33,6 +33,7 @@
 
 static void __iomem *gic_dist_base;
 static void __iomem *gic_cpu_base;
+static DEFINE_SPINLOCK(irq_controller_lock);
 
 /*
  * Routines to acknowledge, disable and enable interrupts
@@ -52,32 +53,45 @@ static void __iomem *gic_cpu_base;
 static void gic_ack_irq(unsigned int irq)
 {
 	u32 mask = 1 << (irq % 32);
+
+	spin_lock(&irq_controller_lock);
 	writel(mask, gic_dist_base + GIC_DIST_ENABLE_CLEAR + (irq / 32) * 4);
 	writel(irq, gic_cpu_base + GIC_CPU_EOI);
+	spin_unlock(&irq_controller_lock);
 }
 
 static void gic_mask_irq(unsigned int irq)
 {
 	u32 mask = 1 << (irq % 32);
+
+	spin_lock(&irq_controller_lock);
 	writel(mask, gic_dist_base + GIC_DIST_ENABLE_CLEAR + (irq / 32) * 4);
+	spin_unlock(&irq_controller_lock);
 }
 
 static void gic_unmask_irq(unsigned int irq)
 {
 	u32 mask = 1 << (irq % 32);
+
+	spin_lock(&irq_controller_lock);
 	writel(mask, gic_dist_base + GIC_DIST_ENABLE_SET + (irq / 32) * 4);
+	spin_unlock(&irq_controller_lock);
 }
 
 #ifdef CONFIG_SMP
-static void gic_set_cpu(struct irqdesc *desc, unsigned int irq, unsigned int cpu)
+static void gic_set_cpu(unsigned int irq, cpumask_t mask_val)
 {
 	void __iomem *reg = gic_dist_base + GIC_DIST_TARGET + (irq & ~3);
 	unsigned int shift = (irq % 4) * 8;
+	unsigned int cpu = first_cpu(mask_val);
 	u32 val;
 
+	spin_lock(&irq_controller_lock);
+	irq_desc[irq].cpu = cpu;
 	val = readl(reg) & ~(0xff << shift);
 	val |= 1 << (cpu + shift);
 	writel(val, reg);
+	spin_unlock(&irq_controller_lock);
 }
 #endif
 
@@ -86,7 +100,7 @@ static struct irqchip gic_chip = {
 	.mask		= gic_mask_irq,
 	.unmask		= gic_unmask_irq,
 #ifdef CONFIG_SMP
-	.set_cpu	= gic_set_cpu,
+	.set_affinity	= gic_set_cpu,
 #endif
 };
 
Index: linux-genirq.q/arch/arm/common/locomo.c
===================================================================
--- linux-genirq.q.orig/arch/arm/common/locomo.c
+++ linux-genirq.q/arch/arm/common/locomo.c
@@ -165,7 +165,7 @@ static void locomo_handler(unsigned int 
 	void __iomem *mapbase = get_irq_chipdata(irq);
 
 	/* Acknowledge the parent IRQ */
-	desc->chip->ack(irq);
+	desc->handler->ack(irq);
 
 	/* check why this interrupt was generated */
 	req = locomo_readl(mapbase + LOCOMO_ICR) & 0x0f00;
Index: linux-genirq.q/arch/arm/common/sa1111.c
===================================================================
--- linux-genirq.q.orig/arch/arm/common/sa1111.c
+++ linux-genirq.q/arch/arm/common/sa1111.c
@@ -151,14 +151,14 @@ static void
 sa1111_irq_handler(unsigned int irq, struct irqdesc *desc, struct pt_regs *regs)
 {
 	unsigned int stat0, stat1, i;
-	void __iomem *base = desc->data;
+	void __iomem *base = get_irq_data(irq);
 
 	stat0 = sa1111_readl(base + SA1111_INTSTATCLR0);
 	stat1 = sa1111_readl(base + SA1111_INTSTATCLR1);
 
 	sa1111_writel(stat0, base + SA1111_INTSTATCLR0);
 
-	desc->chip->ack(irq);
+	desc->handler->ack(irq);
 
 	sa1111_writel(stat1, base + SA1111_INTSTATCLR1);
 
@@ -169,14 +169,14 @@ sa1111_irq_handler(unsigned int irq, str
 
 	for (i = IRQ_SA1111_START; stat0; i++, stat0 >>= 1)
 		if (stat0 & 1)
-			do_edge_IRQ(i, irq_desc + i, regs);
+			handle_edge_irq(i, irq_desc + i, regs);
 
 	for (i = IRQ_SA1111_START + 32; stat1; i++, stat1 >>= 1)
 		if (stat1 & 1)
-			do_edge_IRQ(i, irq_desc + i, regs);
+			handle_edge_irq(i, irq_desc + i, regs);
 
 	/* For level-based interrupts */
-	desc->chip->unmask(irq);
+	desc->handler->unmask(irq);
 }
 
 #define SA1111_IRQMASK_LO(x)	(1 << (x - IRQ_SA1111_START))
Index: linux-genirq.q/arch/arm/common/time-acorn.c
===================================================================
--- linux-genirq.q.orig/arch/arm/common/time-acorn.c
+++ linux-genirq.q/arch/arm/common/time-acorn.c
@@ -16,6 +16,7 @@
 #include <linux/timex.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 
 #include <asm/hardware.h>
 #include <asm/io.h>
