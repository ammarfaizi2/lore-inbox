Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760118AbWLFFPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760118AbWLFFPK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 00:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760125AbWLFFPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 00:15:10 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:35682 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760118AbWLFFPI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 00:15:08 -0500
From: Matthew Wilcox <matthew@wil.cx>
To: linux-kernel@vger.kernel.org
Cc: parisc-linux@parisc-linux.org, Matthew Wilcox <matthew@wil.cx>,
       James Bottomley <James.Bottomley@SteelEye.com>
Subject: [PATCH 2/3] Add the ability to template irq handlers in the generic irq code
Date: Tue,  5 Dec 2006 22:15:06 -0700
Message-Id: <1165382107889-git-send-email-matthew@wil.cx>
X-Mailer: git-send-email 1.4.3.3
In-Reply-To: <11653821071704-git-send-email-matthew@wil.cx>
References: <11653821071704-git-send-email-matthew@wil.cx>
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

Some fixes by Andrew Morton and Matthew Wilcox due to rapid code flux
in this area.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>
---
 kernel/irq/chip.c |  163 ++++++++++++++++++++++++++++++++++-------------------
 1 files changed, 104 insertions(+), 59 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index ebfd24a..1b18c5c 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -17,6 +17,87 @@
 
 #include "internals.h"
 
+/* Helpers for constructing IRQ handlers */
+
+#ifdef CONFIG_SMP
+#define HANDLE_PERCPU_IRQ(NAME, ACK, EOI)				\
+void fastcall								\
+handle_percpu_irq##NAME(unsigned int irq, struct irq_desc *desc)	\
+{									\
+	irqreturn_t action_ret;						\
+									\
+	kstat_this_cpu.irqs[irq]++;					\
+									\
+	ACK(desc, irq);							\
+									\
+	action_ret = handle_IRQ_event(irq, desc->action);		\
+	if (!noirqdebug)						\
+		note_interrupt(irq, desc, action_ret);			\
+									\
+	EOI(desc,irq);							\
+}
+#else
+#define HANDLE_PERCPU_IRQ(NAME, ACK, END)
+#endif /* CONFIG_SMP */
+
+#define HANDLE_LEVEL_IRQ(NAME, MASK, UNMASK)				\
+void fastcall								\
+handle_level_irq##NAME(unsigned int irq, struct irq_desc *desc)		\
+{									\
+	unsigned int cpu = smp_processor_id();				\
+	struct irqaction *action;					\
+	irqreturn_t action_ret;						\
+									\
+	spin_lock(&desc->lock);						\
+	MASK(desc, irq);						\
+									\
+	if (unlikely(desc->status & IRQ_INPROGRESS))			\
+		goto out_unlock;					\
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
+		goto out_unlock;					\
+	}								\
+									\
+	desc->status |= IRQ_INPROGRESS;					\
+	desc->status &= ~IRQ_PENDING;					\
+	spin_unlock(&desc->lock);					\
+									\
+	action_ret = handle_IRQ_event(irq, action);			\
+	if (!noirqdebug)						\
+		note_interrupt(irq, desc, action_ret);			\
+									\
+	spin_lock(&desc->lock);						\
+	desc->status &= ~IRQ_INPROGRESS;				\
+	UNMASK(desc,irq);						\
+out_unlock:								\
+	spin_unlock(&desc->lock);					\
+}
+
+#define HANDLE_SPECIFIC_IRQ(NAME, ACK, EOI, HANDLER)			\
+void fastcall								\
+handle_specific_irq##NAME(unsigned int irq, struct irq_desc *desc)	\
+{									\
+	irqreturn_t action_ret;						\
+									\
+	kstat_this_cpu.irqs[irq]++;					\
+									\
+	ACK(desc, irq);							\
+									\
+	action_ret = HANDLER(irq, desc->action->dev_id);		\
+	if (!noirqdebug)						\
+		note_interrupt(irq, desc, action_ret);			\
+									\
+	EOI(desc,irq);							\
+}
+
 /**
  *	dynamic_irq_init - initialize a dynamically allocated irq
  *	@irq:	irq number to initialize
@@ -247,6 +328,24 @@ static inline void mask_ack_irq(struct i
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
@@ -300,46 +399,7 @@ out_unlock:
  *	it after the associated handler has acknowledged the device, so the
  *	interrupt line is back to inactive.
  */
-void fastcall
-handle_level_irq(unsigned int irq, struct irq_desc *desc)
-{
-	unsigned int cpu = smp_processor_id();
-	struct irqaction *action;
-	irqreturn_t action_ret;
-
-	spin_lock(&desc->lock);
-	mask_ack_irq(desc, irq);
-
-	if (unlikely(desc->status & IRQ_INPROGRESS))
-		goto out_unlock;
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
-		goto out_unlock;
-	}
-
-	desc->status |= IRQ_INPROGRESS;
-	desc->status &= ~IRQ_PENDING;
-	spin_unlock(&desc->lock);
-
-	action_ret = handle_IRQ_event(irq, action);
-	if (!noirqdebug)
-		note_interrupt(irq, desc, action_ret);
-
-	spin_lock(&desc->lock);
-	desc->status &= ~IRQ_INPROGRESS;
-	if (!(desc->status & IRQ_DISABLED) && desc->chip->unmask)
-		desc->chip->unmask(irq);
-out_unlock:
-	spin_unlock(&desc->lock);
-}
+HANDLE_LEVEL_IRQ(, mask_ack_irq, unmask_enabled_irq)
 
 /**
  *	handle_fasteoi_irq - irq handler for transparent controllers
@@ -472,7 +532,6 @@ out_unlock:
 	spin_unlock(&desc->lock);
 }
 
-#ifdef CONFIG_SMP
 /**
  *	handle_percpu_IRQ - Per CPU local irq handler
  *	@irq:	the interrupt number
@@ -480,25 +539,11 @@ out_unlock:
  *
  *	Per CPU interrupts on SMP machines without locking requirements
  */
-void fastcall
-handle_percpu_irq(unsigned int irq, struct irq_desc *desc)
-{
-	irqreturn_t action_ret;
-
-	kstat_this_cpu.irqs[irq]++;
-
-	if (desc->chip->ack)
-		desc->chip->ack(irq);
+HANDLE_PERCPU_IRQ(, ack_irq, eoi_irq)
 
-	action_ret = handle_IRQ_event(irq, desc->action);
-	if (!noirqdebug)
-		note_interrupt(irq, desc, action_ret);
-
-	if (desc->chip->eoi)
-		desc->chip->eoi(irq);
-}
-
-#endif /* CONFIG_SMP */
+#ifdef ARCH_HAS_IRQ_HANDLERS
+#include <asm/irq-handlers.h>
+#endif
 
 void
 __set_irq_handler(unsigned int irq, irq_flow_handler_t handle, int is_chained,
-- 
1.4.3.3

