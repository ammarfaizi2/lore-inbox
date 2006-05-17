Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbWEQASJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbWEQASJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbWEQARs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:17:48 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:5789 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932297AbWEQARM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:17:12 -0400
Date: Wed, 17 May 2006 02:16:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 22/50] genirq: add irq-chip support
Message-ID: <20060517001656.GW12877@elte.hu>
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

enable platforms to use the irq-chip and irq-flow abstractions:
allow setting of the chip, the type and provide highlevel handlers
for common irq-flows.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 include/linux/irq.h |   14 +
 kernel/irq/Makefile |    2 
 kernel/irq/chip.c   |  370 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 385 insertions(+), 1 deletion(-)

Index: linux-genirq.q/include/linux/irq.h
===================================================================
--- linux-genirq.q.orig/include/linux/irq.h
+++ linux-genirq.q/include/linux/irq.h
@@ -308,6 +308,20 @@ extern int can_request_irq(unsigned int 
 /* Dummy irq-chip implementation: */
 extern struct irq_chip no_irq_chip;
 
+/* Set/get chip/data for an IRQ: */
+
+extern int set_irq_chip(unsigned int irq, struct irq_chip *chip);
+extern int set_irq_data(unsigned int irq, void *data);
+extern int set_irq_chip_data(unsigned int irq, void *data);
+extern int set_irq_type(unsigned int irq, unsigned int type);
+
+#define get_irq_chip(irq)	(irq_desc[irq].handler)
+#define get_irq_chip_data(irq)	(irq_desc[irq].chip_data)
+#define get_irq_data(irq)	(irq_desc[irq].handler_data)
+
+/* Set default functions for irq_chip structures: */
+extern void irq_chip_set_defaults(struct irq_chip *chip);
+
 #endif /* CONFIG_GENERIC_HARDIRQS */
 
 #endif /* !CONFIG_S390 */
Index: linux-genirq.q/kernel/irq/Makefile
===================================================================
--- linux-genirq.q.orig/kernel/irq/Makefile
+++ linux-genirq.q/kernel/irq/Makefile
@@ -1,5 +1,5 @@
 
-obj-y := handle.o manage.o spurious.o resend.o
+obj-y := handle.o manage.o spurious.o resend.o chip.o
 obj-$(CONFIG_GENERIC_IRQ_PROBE) += autoprobe.o
 obj-$(CONFIG_PROC_FS) += proc.o
 obj-$(CONFIG_GENERIC_PENDING_IRQ) += migration.o
Index: linux-genirq.q/kernel/irq/chip.c
===================================================================
--- /dev/null
+++ linux-genirq.q/kernel/irq/chip.c
@@ -0,0 +1,370 @@
+/*
+ * linux/kernel/irq/chip.c
+ *
+ * Copyright (C) 1992, 1998-2006 Linus Torvalds, Ingo Molnar
+ * Copyright (C) 2005-2006, Thomas Gleixner, Russell King
+ *
+ * This file contains the core interrupt handling code, for irq-chip
+ * based architectures.
+ *
+ * Detailed information is available in Documentation/DocBook/genericirq
+ */
+
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/kernel_stat.h>
+
+#include "internals.h"
+
+/**
+ *	set_irq_chip - set the irq chip for an irq
+ *	@irq:	irq number
+ *	@chip:	pointer to irq chip description structure
+ */
+int set_irq_chip(unsigned int irq, struct irq_chip *chip)
+{
+	struct irq_desc *desc;
+	unsigned long flags;
+
+	if (irq >= NR_IRQS) {
+		printk(KERN_ERR "Trying to install chip for IRQ%d\n", irq);
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	if (!chip)
+		chip = &no_irq_chip;
+
+	desc = irq_desc + irq;
+	spin_lock_irqsave(&desc->lock, flags);
+	irq_chip_set_defaults(chip);
+	desc->handler = chip;
+	spin_unlock_irqrestore(&desc->lock, flags);
+	return 0;
+}
+EXPORT_SYMBOL(set_irq_chip);
+
+/**
+ *	set_irq_type - set the irq type for an irq
+ *	@irq:	irq number
+ *	@type:	interrupt type - see include/linux/interrupt.h
+ */
+int set_irq_type(unsigned int irq, unsigned int type)
+{
+	struct irq_desc *desc;
+	unsigned long flags;
+	int ret = -ENXIO;
+
+	if (irq >= NR_IRQS) {
+		printk(KERN_ERR "Trying to set irq type for IRQ%d\n", irq);
+		return -ENODEV;
+	}
+
+	desc = irq_desc + irq;
+	if (desc->handler->set_type) {
+		spin_lock_irqsave(&desc->lock, flags);
+		ret = desc->handler->set_type(irq, type);
+		spin_unlock_irqrestore(&desc->lock, flags);
+	}
+	return ret;
+}
+EXPORT_SYMBOL(set_irq_type);
+
+/**
+ *	set_irq_data - set irq type data for an irq
+ *	@irq:	Interrupt number
+ *	@data:	Pointer to interrupt specific data
+ *
+ *	Set the hardware irq controller data for an irq
+ */
+int set_irq_data(unsigned int irq, void *data)
+{
+	struct irq_desc *desc;
+	unsigned long flags;
+
+	if (irq >= NR_IRQS) {
+		printk(KERN_ERR
+		       "Trying to install controller data for IRQ%d\n", irq);
+		return -EINVAL;
+	}
+
+	desc = irq_desc + irq;
+	spin_lock_irqsave(&desc->lock, flags);
+	desc->handler_data = data;
+	spin_unlock_irqrestore(&desc->lock, flags);
+	return 0;
+}
+EXPORT_SYMBOL(set_irq_data);
+
+/**
+ *	set_irq_chip_data - set irq chip data for an irq
+ *	@irq:	Interrupt number
+ *	@data:	Pointer to chip specific data
+ *
+ *	Set the hardware irq chip data for an irq
+ */
+int set_irq_chip_data(unsigned int irq, void *data)
+{
+	struct irq_desc *desc = irq_desc + irq;
+	unsigned long flags;
+
+	if (irq >= NR_IRQS || !desc->handler) {
+		printk(KERN_ERR "BUG: bad set_irq_chip_data(IRQ#%d)\n", irq);
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&desc->lock, flags);
+	desc->chip_data = data;
+	spin_unlock_irqrestore(&desc->lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL(set_irq_chip_data);
+
+/*
+ * default enable function
+ */
+static void default_enable(unsigned int irq)
+{
+	struct irq_desc *desc = irq_desc + irq;
+
+	desc->handler->unmask(irq);
+	desc->status &= ~IRQ_MASKED;
+}
+
+/*
+ * default disable function
+ */
+static void default_disable(unsigned int irq)
+{
+	irq_desc[irq].handler->mask(irq);
+}
+
+/*
+ * default startup function
+ */
+static unsigned int default_startup(unsigned int irq)
+{
+	irq_desc[irq].handler->enable(irq);
+
+	return 0;
+}
+
+/*
+ * Fixup enable/disable function pointers
+ */
+void irq_chip_set_defaults(struct irq_chip *chip)
+{
+	if (!chip->enable)
+		chip->enable = default_enable;
+	if (!chip->disable)
+		chip->disable = default_disable;
+	if (!chip->startup)
+		chip->startup = default_startup;
+	if (!chip->shutdown)
+		chip->shutdown = chip->disable;
+}
+
+static inline void mask_ack_irq(struct irq_desc *desc, int irq)
+{
+	if (desc->handler->mask_ack)
+		desc->handler->mask_ack(irq);
+	else {
+		desc->handler->mask(irq);
+		desc->handler->ack(irq);
+	}
+}
+
+/**
+ * handle_simple_irq - Simple and software-decoded IRQs.
+ * @irq:	the interrupt number
+ * @desc:	the interrupt description structure for this irq
+ * @regs:	pointer to a register structure
+ *
+ * Simple interrupts are either sent from a demultiplexing interrupt
+ * handler or come from hardware, where no interrupt hardware control
+ * is necessary.
+ *
+ * Note: The caller is expected to handle the ack, clear, mask and
+ * unmask issues if necessary.
+ *
+ * Must be called with the irq_desc->lock held
+ */
+void
+handle_simple_irq(unsigned int irq, struct irq_desc *desc, struct pt_regs *regs)
+{
+	struct irqaction *action;
+	irqreturn_t action_ret;
+	const unsigned int cpu = smp_processor_id();
+
+	kstat_cpu(cpu).irqs[irq]++;
+
+	desc->status &= ~(IRQ_REPLAY | IRQ_WAITING);
+
+	action = desc->action;
+	if (unlikely(!action || desc->depth))
+		return;
+
+	desc->status |= IRQ_INPROGRESS;
+	spin_unlock(&desc->lock);
+	action_ret = handle_IRQ_event(irq, regs, action);
+	if (!noirqdebug)
+		note_interrupt(irq, desc, action_ret, regs);
+	spin_lock(&desc->lock);
+	desc->status &= ~IRQ_INPROGRESS;
+}
+
+/**
+ * handle_level_irq - Level type irq handler
+ * @irq:	the interrupt number
+ * @desc:	the interrupt description structure for this irq
+ * @regs:	pointer to a register structure
+ *
+ * Level type interrupts are active as long as the hardware line has
+ * the active level. This may require to mask the interrupt and unmask it
+ * after the associated handler has acknowledged the device, so the
+ * interrupt line is back to inactive.
+ *
+ * Must be called with the irq_desc->lock held
+ */
+void
+handle_level_irq(unsigned int irq, struct irq_desc *desc, struct pt_regs *regs)
+{
+	struct irqaction *action;
+	irqreturn_t action_ret;
+	const unsigned int cpu = smp_processor_id();
+
+	kstat_cpu(cpu).irqs[irq]++;
+
+	desc->status &= ~(IRQ_REPLAY | IRQ_WAITING);
+
+	mask_ack_irq(desc, irq);
+
+	/*
+	 * If its disabled or no action available
+	 * keep it masked and get out of here
+	 */
+	action = desc->action;
+	if (unlikely(!action || desc->depth))
+		goto out;
+
+	desc->status |= IRQ_INPROGRESS;
+	spin_unlock(&desc->lock);
+	action_ret = handle_IRQ_event(irq, regs, action);
+	if (!noirqdebug)
+		note_interrupt(irq, desc, action_ret, regs);
+	spin_lock(&desc->lock);
+
+	desc->status &= ~IRQ_INPROGRESS;
+out:
+	if (!desc->depth && desc->handler->unmask)
+		desc->handler->unmask(irq);
+}
+
+/**
+ * handle_edge_irq - edge type IRQ handler
+ * @irq:	the interrupt number
+ * @desc:	the interrupt description structure for this irq
+ * @regs:	pointer to a register structure
+ *
+ * Interrupt occures on the falling and/or rising edge of a hardware
+ * signal. The occurence is latched into the irq controller hardware
+ * and must be acked in order to be reenabled. After the ack another
+ * interrupt can happen on the same source even before the first one
+ * is handled by the assosiacted event handler. If this happens it
+ * might be necessary to disable (mask) the interrupt depending on the
+ * controller hardware. This requires to reenable the interrupt inside
+ * of the loop which handles the interrupts which have arrived while
+ * the handler was running. If all pending interrupts are handled, the
+ * loop is left and depending on the hardware controller some final
+ * ack might be necessary.
+ *
+ * Must be called with the irq_desc->lock held
+ */
+void
+handle_edge_irq(unsigned int irq, struct irq_desc *desc, struct pt_regs *regs)
+{
+	const unsigned int cpu = smp_processor_id();
+
+	kstat_cpu(cpu).irqs[irq]++;
+
+	desc->status &= ~(IRQ_REPLAY | IRQ_WAITING);
+
+	/*
+	 * If we're currently running this IRQ, or its disabled,
+	 * we shouldn't process the IRQ. Mark it pending, handle
+	 * the necessary masking and go out
+	 */
+	if (unlikely((desc->status & IRQ_INPROGRESS) || desc->depth ||
+		    !desc->action)) {
+		desc->status |= (IRQ_PENDING | IRQ_MASKED);
+		mask_ack_irq(desc, irq);
+		return;
+	}
+
+	/* Start handling the irq */
+	desc->handler->ack(irq);
+
+	/* Mark the IRQ currently in progress.*/
+	desc->status |= IRQ_INPROGRESS;
+
+	do {
+		struct irqaction *action = desc->action;
+		irqreturn_t action_ret;
+
+		if (unlikely(!action)) {
+			desc->handler->mask(irq);
+			return;
+		}
+
+		/*
+		 * When another irq arrived while we were handling
+		 * one, we could have masked the irq.
+		 * Renable it, if it was not disabled in meantime.
+		 */
+		if (unlikely(((desc->status & (IRQ_PENDING | IRQ_MASKED)) ==
+			      (IRQ_PENDING | IRQ_MASKED)) && !desc->depth)) {
+			desc->handler->unmask(irq);
+			desc->status &= ~IRQ_MASKED;
+		}
+
+		desc->status &= ~IRQ_PENDING;
+		spin_unlock(&desc->lock);
+		action_ret = handle_IRQ_event(irq, regs, action);
+		if (!noirqdebug)
+			note_interrupt(irq, desc, action_ret, regs);
+		spin_lock(&desc->lock);
+
+	} while ((desc->status & IRQ_PENDING) && !desc->depth);
+
+	desc->status &= ~IRQ_INPROGRESS;
+}
+
+#ifdef CONFIG_SMP
+/**
+ * handle_percpu_IRQ - Per CPU local irq handler
+ * @irq:	the interrupt number
+ * @desc:	the interrupt description structure for this irq
+ * @regs:	pointer to a register structure
+ *
+ * Per CPU interrupts on SMP machines without locking requirements
+ */
+void
+handle_percpu_irq(unsigned int irq, struct irq_desc *desc, struct pt_regs *regs)
+{
+	irqreturn_t action_ret;
+
+	kstat_this_cpu.irqs[irq]++;
+
+	if (desc->handler->ack)
+		desc->handler->ack(irq);
+
+	action_ret = handle_IRQ_event(irq, regs, desc->action);
+	if (!noirqdebug)
+		note_interrupt(irq, desc, action_ret, regs);
+
+	if (desc->handler->end)
+		desc->handler->end(irq);
+}
+#endif /* CONFIG_SMP */
