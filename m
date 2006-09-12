Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030278AbWILR3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030278AbWILR3w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 13:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030285AbWILR3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 13:29:52 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:21890 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1030278AbWILR3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 13:29:51 -0400
Subject: [PATCH] add the ability to template irq handlers in the generic
	irq code
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 12 Sep 2006 12:29:43 -0500
Message-Id: <1158082183.3461.26.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On parisc, we have the issue that function call pointers are hugely
expensive, so we'd like to minimise their use in the interrupts.
Unfortunately, this involves directly calling the ack/eoi functions
instead of indirecting.  To permit this without losing the advantages of
centrally managed irq code, I introduced template builders for irq
handlers.  This allows us to construct special handlers on parisc that
don't indirect through function call pointers.

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

---
James

Index: parisc-2.6/kernel/irq/chip.c
===================================================================
--- parisc-2.6.orig/kernel/irq/chip.c	2006-09-12 09:17:53.000000000 -0700
+++ parisc-2.6/kernel/irq/chip.c	2006-09-12 09:19:46.000000000 -0700
@@ -17,6 +17,90 @@
 
 #include "internals.h"
 
+/* Helpers for constructing IRQ handlers */
+
+#ifdef CONFIG_SMP
+#define HANDLE_PERCPU_IRQ(NAME, ACK, EOI)				\
+void fastcall								\
+handle_percpu_irq##NAME(unsigned int irq, struct irq_desc *desc,	\
+			struct pt_regs *regs)				\
+{									\
+	irqreturn_t action_ret;						\
+									\
+	kstat_this_cpu.irqs[irq]++;					\
+									\
+	ACK(desc, irq);							\
+									\
+	action_ret = handle_IRQ_event(irq, regs, desc->action);		\
+	if (!noirqdebug)						\
+		note_interrupt(irq, desc, action_ret, regs);		\
+									\
+	EOI(desc,irq);							\
+}
+#else
+#define HANDLE_PERCPU_IRQ(NAME, ACK, END)
+#endif /* CONFIG_SMP */
+
+#define HANDLE_LEVEL_IRQ(NAME, MASK, UNMASK)				\
+void fastcall								\
+handle_level_irq##NAME(unsigned int irq, struct irq_desc *desc,		\
+			struct pt_regs *regs)				\
+{									\
+	unsigned int cpu = smp_processor_id();				\
+	struct irqaction *action;					\
+	irqreturn_t action_ret;						\
+									\
+	spin_lock(&desc->lock);						\
+	MASK(desc, irq);						\
+									\
+	if (unlikely(desc->status & IRQ_INPROGRESS))			\
+		goto out;						\
+	desc->status &= ~(IRQ_REPLAY | IRQ_WAITING);			\
+	kstat_cpu(cpu).irqs[irq]++;					\
+									\
+	/*								\
+	 * If its disabled or no action available			\
+	 * keep it masked and get out of here				\
+	 */								\
+	action = desc->action;						\
+	if (unlikely(!action || (desc->status & IRQ_DISABLED))) {	\
+		desc->status |= IRQ_PENDING;				\
+		goto out;						\
+	}								\
+									\
+	desc->status |= IRQ_INPROGRESS;					\
+	desc->status &= ~IRQ_PENDING;					\
+	spin_unlock(&desc->lock);					\
+									\
+	action_ret = handle_IRQ_event(irq, regs, action);		\
+	if (!noirqdebug)						\
+		note_interrupt(irq, desc, action_ret, regs);		\
+									\
+	spin_lock(&desc->lock);						\
+	desc->status &= ~IRQ_INPROGRESS;				\
+out:									\
+	UNMASK(desc,irq);						\
+	spin_unlock(&desc->lock);					\
+}
+
+#define HANDLE_SPECIFIC_IRQ(NAME, ACK, EOI, HANDLER)			\
+void fastcall								\
+handle_specific_irq##NAME(unsigned int irq, struct irq_desc *desc,	\
+			  struct pt_regs *regs)				\
+{									\
+	irqreturn_t action_ret;						\
+									\
+	kstat_this_cpu.irqs[irq]++;					\
+									\
+	ACK(desc, irq);							\
+									\
+	action_ret = HANDLER(irq, desc->action->dev_id, regs);		\
+	if (!noirqdebug)						\
+		note_interrupt(irq, desc, action_ret, regs);		\
+									\
+	EOI(desc,irq);							\
+}
+
 /**
  *	set_irq_chip - set the irq chip for an irq
  *	@irq:	irq number
@@ -186,6 +270,24 @@ static inline void mask_ack_irq(struct i
 	}
 }
 
+static inline void unmask_enabled_irq(struct irq_desc *desc, int irq)
+{
+	if (!(desc->status & IRQ_DISABLED) && desc->chip->unmask)
+		desc->chip->unmask(irq);
+}
+
+static inline void ack_irq(struct irq_desc *desc, int irq)
+{
+	if (desc->chip->ack)
+		desc->chip->ack(irq);
+}
+
+static inline void eoi_irq(struct irq_desc *desc, int irq)
+{
+	if (desc->chip->eoi)
+		desc->chip->eoi(irq);
+}
+
 /**
  *	handle_simple_irq - Simple and software-decoded IRQs.
  *	@irq:	the interrupt number
@@ -241,46 +343,7 @@ out_unlock:
  *	it after the associated handler has acknowledged the device, so the
  *	interrupt line is back to inactive.
  */
-void fastcall
-handle_level_irq(unsigned int irq, struct irq_desc *desc, struct pt_regs *regs)
-{
-	unsigned int cpu = smp_processor_id();
-	struct irqaction *action;
-	irqreturn_t action_ret;
-
-	spin_lock(&desc->lock);
-	mask_ack_irq(desc, irq);
-
-	if (unlikely(desc->status & IRQ_INPROGRESS))
-		goto out;
-	desc->status &= ~(IRQ_REPLAY | IRQ_WAITING);
-	kstat_cpu(cpu).irqs[irq]++;
-
-	/*
-	 * If its disabled or no action available
-	 * keep it masked and get out of here
-	 */
-	action = desc->action;
-	if (unlikely(!action || (desc->status & IRQ_DISABLED))) {
-		desc->status |= IRQ_PENDING;
-		goto out;
-	}
-
-	desc->status |= IRQ_INPROGRESS;
-	desc->status &= ~IRQ_PENDING;
-	spin_unlock(&desc->lock);
-
-	action_ret = handle_IRQ_event(irq, regs, action);
-	if (!noirqdebug)
-		note_interrupt(irq, desc, action_ret, regs);
-
-	spin_lock(&desc->lock);
-	desc->status &= ~IRQ_INPROGRESS;
-out:
-	if (!(desc->status & IRQ_DISABLED) && desc->chip->unmask)
-		desc->chip->unmask(irq);
-	spin_unlock(&desc->lock);
-}
+HANDLE_LEVEL_IRQ(, mask_ack_irq, unmask_enabled_irq)
 
 /**
  *	handle_fasteoi_irq - irq handler for transparent controllers
@@ -416,7 +479,6 @@ out_unlock:
 	spin_unlock(&desc->lock);
 }
 
-#ifdef CONFIG_SMP
 /**
  *	handle_percpu_IRQ - Per CPU local irq handler
  *	@irq:	the interrupt number
@@ -425,25 +487,19 @@ out_unlock:
  *
  *	Per CPU interrupts on SMP machines without locking requirements
  */
-void fastcall
-handle_percpu_irq(unsigned int irq, struct irq_desc *desc, struct pt_regs *regs)
-{
-	irqreturn_t action_ret;
+HANDLE_PERCPU_IRQ(, ack_irq, eoi_irq)
 
-	kstat_this_cpu.irqs[irq]++;
-
-	if (desc->chip->ack)
-		desc->chip->ack(irq);
-
-	action_ret = handle_IRQ_event(irq, regs, desc->action);
-	if (!noirqdebug)
-		note_interrupt(irq, desc, action_ret, regs);
-
-	if (desc->chip->eoi)
-		desc->chip->eoi(irq);
+#ifdef ARCH_HAS_IRQ_HANDLERS
+#include <asm/irq-handlers.h>
+#else
+static inline char *arch_handle_irq_name(void fastcall (*handle)(unsigned int,
+							struct irq_desc *,
+							struct pt_regs *))
+{
+	return NULL;
 }
+#endif
 
-#endif /* CONFIG_SMP */
 
 void
 __set_irq_handler(unsigned int irq,
@@ -533,5 +589,5 @@ handle_irq_name(void fastcall (*handle)(
 	if (handle == handle_bad_irq)
 		return "bad    ";
 
-	return NULL;
+	return arch_handle_irq_name(handle);
 }


