Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbWGAO6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbWGAO6j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 10:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWGAO6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 10:58:07 -0400
Received: from www.osadl.org ([213.239.205.134]:50084 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751540AbWGAO5U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:57:20 -0400
Message-Id: <20060701145226.229093000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:54:49 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>
Subject: [RFC][patch 26/44] generic irq: Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-kernel.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 kernel/irq/handle.c   |    4 ++--
 kernel/irq/manage.c   |   38 +++++++++++++++++++-------------------
 kernel/irq/spurious.c |    4 ++--
 3 files changed, 23 insertions(+), 23 deletions(-)

Index: linux-2.6.git/kernel/irq/handle.c
===================================================================
--- linux-2.6.git.orig/kernel/irq/handle.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/kernel/irq/handle.c	2006-07-01 16:51:39.000000000 +0200
@@ -113,7 +113,7 @@ irqreturn_t handle_IRQ_event(unsigned in
 	irqreturn_t ret, retval = IRQ_NONE;
 	unsigned int status = 0;
 
-	if (!(action->flags & SA_INTERRUPT))
+	if (!(action->flags & IRQF_DISABLED))
 		local_irq_enable();
 
 	do {
@@ -124,7 +124,7 @@ irqreturn_t handle_IRQ_event(unsigned in
 		action = action->next;
 	} while (action);
 
-	if (status & SA_SAMPLE_RANDOM)
+	if (status & IRQF_SAMPLE_RANDOM)
 		add_interrupt_randomness(irq);
 	local_irq_disable();
 
Index: linux-2.6.git/kernel/irq/manage.c
===================================================================
--- linux-2.6.git.orig/kernel/irq/manage.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/kernel/irq/manage.c	2006-07-01 16:51:39.000000000 +0200
@@ -167,7 +167,7 @@ int can_request_irq(unsigned int irq, un
 
 	action = irq_desc[irq].action;
 	if (action)
-		if (irqflags & action->flags & SA_SHIRQ)
+		if (irqflags & action->flags & IRQF_SHARED)
 			action = NULL;
 
 	return !action;
@@ -205,7 +205,7 @@ int setup_irq(unsigned int irq, struct i
 	 * so we have to be careful not to interfere with a
 	 * running system.
 	 */
-	if (new->flags & SA_SAMPLE_RANDOM) {
+	if (new->flags & IRQF_SAMPLE_RANDOM) {
 		/*
 		 * This function might sleep, we want to call it first,
 		 * outside of the atomic block.
@@ -227,16 +227,16 @@ int setup_irq(unsigned int irq, struct i
 		/*
 		 * Can't share interrupts unless both agree to and are
 		 * the same type (level, edge, polarity). So both flag
-		 * fields must have SA_SHIRQ set and the bits which
+		 * fields must have IRQF_SHARED set and the bits which
 		 * set the trigger type must match.
 		 */
-		if (!((old->flags & new->flags) & SA_SHIRQ) ||
-		    ((old->flags ^ new->flags) & SA_TRIGGER_MASK))
+		if (!((old->flags & new->flags) & IRQF_SHARED) ||
+		    ((old->flags ^ new->flags) & IRQF_TRIGGER_MASK))
 			goto mismatch;
 
-#if defined(CONFIG_IRQ_PER_CPU) && defined(SA_PERCPU_IRQ)
+#if defined(CONFIG_IRQ_PER_CPU)
 		/* All handlers must agree on per-cpuness */
-		if ((old->flags & IRQ_PER_CPU) != (new->flags & IRQ_PER_CPU))
+		if ((old->flags & IRQF_PERCPU) != (new->flags & IRQF_PERCPU))
 			goto mismatch;
 #endif
 
@@ -249,25 +249,25 @@ int setup_irq(unsigned int irq, struct i
 	}
 
 	*p = new;
-#if defined(CONFIG_IRQ_PER_CPU) && defined(SA_PERCPU_IRQ)
-	if (new->flags & SA_PERCPU_IRQ)
+#if defined(CONFIG_IRQ_PER_CPU)
+	if (new->flags & IRQF_PERCPU)
 		desc->status |= IRQ_PER_CPU;
 #endif
 	if (!shared) {
 		irq_chip_set_defaults(desc->chip);
 
 		/* Setup the type (level, edge polarity) if configured: */
-		if (new->flags & SA_TRIGGER_MASK) {
+		if (new->flags & IRQF_TRIGGER_MASK) {
 			if (desc->chip && desc->chip->set_type)
 				desc->chip->set_type(irq,
-						new->flags & SA_TRIGGER_MASK);
+						new->flags & IRQF_TRIGGER_MASK);
 			else
 				/*
-				 * SA_TRIGGER_* but the PIC does not support
+				 * IRQF_TRIGGER_* but the PIC does not support
 				 * multiple flow-types?
 				 */
-				printk(KERN_WARNING "setup_irq(%d) SA_TRIGGER"
-				       "set. No set_type function available\n",
+				printk(KERN_WARNING "setup_irq(%d) IRQF_TRIGGER"
+				       " set. No set_type function available\n",
 				       irq);
 		} else
 			compat_irq_chip_set_default_handler(desc);
@@ -297,7 +297,7 @@ int setup_irq(unsigned int irq, struct i
 
 mismatch:
 	spin_unlock_irqrestore(&desc->lock, flags);
-	if (!(new->flags & SA_PROBEIRQ)) {
+	if (!(new->flags & IRQF_PROBE_SHARED)) {
 		printk(KERN_ERR "%s: irq handler mismatch\n", __FUNCTION__);
 		dump_stack();
 	}
@@ -396,9 +396,9 @@ EXPORT_SYMBOL(free_irq);
  *
  *	Flags:
  *
- *	SA_SHIRQ		Interrupt is shared
- *	SA_INTERRUPT		Disable local interrupts while processing
- *	SA_SAMPLE_RANDOM	The interrupt can be used for entropy
+ *	IRQF_SHARED		Interrupt is shared
+ *	IRQF_DISABLED	Disable local interrupts while processing
+ *	IRQF_SAMPLE_RANDOM	The interrupt can be used for entropy
  *
  */
 int request_irq(unsigned int irq,
@@ -414,7 +414,7 @@ int request_irq(unsigned int irq,
 	 * which interrupt is which (messes up the interrupt freeing
 	 * logic etc).
 	 */
-	if ((irqflags & SA_SHIRQ) && !dev_id)
+	if ((irqflags & IRQF_SHARED) && !dev_id)
 		return -EINVAL;
 	if (irq >= NR_IRQS)
 		return -EINVAL;
Index: linux-2.6.git/kernel/irq/spurious.c
===================================================================
--- linux-2.6.git.orig/kernel/irq/spurious.c	2006-07-01 16:51:20.000000000 +0200
+++ linux-2.6.git/kernel/irq/spurious.c	2006-07-01 16:51:39.000000000 +0200
@@ -36,7 +36,7 @@ static int misrouted_irq(int irq, struct
 			 * Already running: If it is shared get the other
 			 * CPU to go looking for our mystery interrupt too
 			 */
-			if (desc->action && (desc->action->flags & SA_SHIRQ))
+			if (desc->action && (desc->action->flags & IRQF_SHARED))
 				desc->status |= IRQ_PENDING;
 			spin_unlock(&desc->lock);
 			continue;
@@ -48,7 +48,7 @@ static int misrouted_irq(int irq, struct
 
 		while (action) {
 			/* Only shared IRQ handlers are safe to call */
-			if (action->flags & SA_SHIRQ) {
+			if (action->flags & IRQF_SHARED) {
 				if (action->handler(i, action->dev_id, regs) ==
 						IRQ_HANDLED)
 					ok = 1;

--

