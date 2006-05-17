Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbWEQAbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbWEQAbX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWEQAQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:16:47 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:60828 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932311AbWEQAQj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:16:39 -0400
Date: Wed, 17 May 2006 02:16:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 16/50] genirq: add genirq sw IRQ-retrigger
Message-ID: <20060517001628.GQ12877@elte.hu>
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

enable platforms that do not have a hardware-assisted hardirq-resend
mechanism to resend them via a softirq-driven IRQ emulation mechanism.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 include/linux/irq.h |    3 +
 kernel/irq/Makefile |    2 -
 kernel/irq/manage.c |   10 ------
 kernel/irq/resend.c |   79 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 84 insertions(+), 10 deletions(-)

Index: linux-genirq.q/include/linux/irq.h
===================================================================
--- linux-genirq.q.orig/include/linux/irq.h
+++ linux-genirq.q/include/linux/irq.h
@@ -242,6 +242,9 @@ extern void note_interrupt(unsigned int 
 			   int action_ret, struct pt_regs *regs);
 extern int can_request_irq(unsigned int irq, unsigned long irqflags);
 
+/* Resending of interrupts :*/
+void check_irq_resend(struct irq_desc *desc, unsigned int irq);
+
 extern void init_irq_proc(void);
 
 #endif /* CONFIG_GENERIC_HARDIRQS */
Index: linux-genirq.q/kernel/irq/Makefile
===================================================================
--- linux-genirq.q.orig/kernel/irq/Makefile
+++ linux-genirq.q/kernel/irq/Makefile
@@ -1,5 +1,5 @@
 
-obj-y := handle.o manage.o spurious.o
+obj-y := handle.o manage.o spurious.o resend.o
 obj-$(CONFIG_GENERIC_IRQ_PROBE) += autoprobe.o
 obj-$(CONFIG_PROC_FS) += proc.o
 obj-$(CONFIG_GENERIC_PENDING_IRQ) += migration.o
Index: linux-genirq.q/kernel/irq/manage.c
===================================================================
--- linux-genirq.q.orig/kernel/irq/manage.c
+++ linux-genirq.q/kernel/irq/manage.c
@@ -118,15 +118,7 @@ void enable_irq(unsigned int irq)
 		WARN_ON(1);
 		break;
 	case 1: {
-		unsigned int status = desc->status & ~IRQ_DISABLED;
-
-		desc->status = status;
-		if ((status & (IRQ_PENDING | IRQ_REPLAY)) == IRQ_PENDING) {
-			desc->status = status | IRQ_REPLAY;
-			if (desc->handler && desc->handler->retrigger)
-				desc->handler->retrigger(irq);
-		}
-		desc->handler->enable(irq);
+		check_irq_resend(desc, irq);
 		/* fall-through */
 	}
 	default:
Index: linux-genirq.q/kernel/irq/resend.c
===================================================================
--- /dev/null
+++ linux-genirq.q/kernel/irq/resend.c
@@ -0,0 +1,79 @@
+/*
+ * linux/kernel/irq/resend.c
+ *
+ * Copyright (C) 1992, 1998-2006 Linus Torvalds, Ingo Molnar
+ * Copyright (C) 2005-2006, Thomas Gleixner
+ *
+ * This file contains the IRQ-resend code
+ *
+ * If the interrupt is waiting to be processed, we try to re-run it.
+ * We can't directly run it from here since the caller might be in an
+ * interrupt-protected region. Not all irq controller chips can
+ * retrigger interrupts at the hardware level, so in those cases
+ * we allow the resending of IRQs via a tasklet.
+ */
+
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/random.h>
+#include <linux/interrupt.h>
+
+#include "internals.h"
+
+#ifdef CONFIG_HARDIRQS_SW_RESEND
+
+/* Bitmap to handle software resend of interrupts: */
+static DECLARE_BITMAP(irqs_resend, NR_IRQS);
+
+/*
+ * Run software resends of IRQ's
+ */
+static void resend_irqs(unsigned long arg)
+{
+	struct irq_desc *desc;
+	unsigned long flags;
+	int irq;
+
+	while (!bitmap_empty(irqs_resend, NR_IRQS)) {
+		irq = find_first_bit(irqs_resend, NR_IRQS);
+		clear_bit(irq, irqs_resend);
+		desc = irq_desc + irq;
+		spin_lock_irqsave(&desc->lock, flags);
+		desc->handle(irq, desc, NULL);
+		spin_unlock_irqrestore(&desc->lock, flags);
+	}
+}
+
+/* Tasklet to handle resend: */
+static DECLARE_TASKLET(resend_tasklet, resend_irqs, 0);
+
+#endif
+
+/*
+ * IRQ resend
+ *
+ * Is called with interrupts disabled and desc->lock held.
+ */
+void check_irq_resend(struct irq_desc *desc, unsigned int irq)
+{
+	unsigned int status = desc->status;
+
+	/*
+	 * Make sure the interrupt is enabled, before resending it:
+	 */
+	desc->handler->enable(irq);
+
+	if ((status & (IRQ_PENDING | IRQ_REPLAY)) == IRQ_PENDING) {
+		desc->status &= ~IRQ_PENDING;
+		desc->status = status | IRQ_REPLAY;
+
+		if (!desc->handler || !desc->handler->retrigger ||
+					!desc->handler->retrigger(irq)) {
+#ifdef CONFIG_HARDIRQS_SW_RESEND
+			/* Set it pending and activate the softirq: */
+			set_bit(irq, irqs_resend);
+			tasklet_schedule(&resend_tasklet);
+#endif
+		}
+	}
+}
