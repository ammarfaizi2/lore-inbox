Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267044AbSLXGmc>; Tue, 24 Dec 2002 01:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267047AbSLXGmc>; Tue, 24 Dec 2002 01:42:32 -0500
Received: from samael.donpac.ru ([195.161.172.239]:12038 "EHLO
	samael.donpac.ru") by vger.kernel.org with ESMTP id <S267044AbSLXGmQ>;
	Tue, 24 Dec 2002 01:42:16 -0500
From: "Andrey Panin" <pazke@orbita1.ru>
Date: Tue, 24 Dec 2002 09:45:51 +0300
To: linux-kernel@vger.kernel.org
Subject: [RFC] irq handling code consolidation (alpha)
Message-ID: <20021224064551.GG1222@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20021224063036.GD1222@pazke>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FN+gV9K+162wdwwF"
Content-Disposition: inline
In-Reply-To: <20021224063036.GD1222@pazke>
User-Agent: Mutt/1.3.28i
X-Uname: Linux 2.4.20aa1 i686 unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FN+gV9K+162wdwwF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


alpha specific patch attached. Not tested, not compiled.

-- 
Andrey Panin		| Embedded systems software developer
pazke@orbita1.ru	| PGP key: wwwkeys.pgp.net

--FN+gV9K+162wdwwF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-irq-alpha

diff --minimal -urN -X /usr/share/dontdiff linux-2.5.52.vanilla/arch/alpha/Kconfig linux-2.5.52/arch/alpha/Kconfig
--- linux-2.5.52.vanilla/arch/alpha/Kconfig	Mon Dec 16 05:08:14 2002
+++ linux-2.5.52/arch/alpha/Kconfig	Tue Dec 24 09:41:58 2002
@@ -20,6 +20,10 @@
 	bool
 	default y
 
+config GENERIC_IRQ
+	bool
+	default y
+
 config UID16
 	bool
 
diff --minimal -urN -X /usr/share/dontdiff linux-2.5.52.vanilla/arch/alpha/kernel/irq.c linux-2.5.52/arch/alpha/kernel/irq.c
--- linux-2.5.52.vanilla/arch/alpha/kernel/irq.c	Mon Dec 16 05:08:14 2002
+++ linux-2.5.52/arch/alpha/kernel/irq.c	Tue Dec 24 09:41:04 2002
@@ -30,129 +30,9 @@
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
 
-/*
- * Controller mappings for all interrupt sources:
- */
-irq_desc_t irq_desc[NR_IRQS] __cacheline_aligned = {
-	[0 ... NR_IRQS-1] = { 0, &no_irq_type, NULL, 0, SPIN_LOCK_UNLOCKED}
-};
 
 static void register_irq_proc(unsigned int irq);
 
-volatile unsigned long irq_err_count;
-
-/*
- * Special irq handlers.
- */
-
-void no_action(int cpl, void *dev_id, struct pt_regs *regs) { }
-
-/*
- * Generic no controller code
- */
-
-static void no_irq_enable_disable(unsigned int irq) { }
-static unsigned int no_irq_startup(unsigned int irq) { return 0; }
-
-static void
-no_irq_ack(unsigned int irq)
-{
-	irq_err_count++;
-	printk(KERN_CRIT "Unexpected IRQ trap at vector %u\n", irq);
-}
-
-struct hw_interrupt_type no_irq_type = {
-	.typename	= "none",
-	.startup	= no_irq_startup,
-	.shutdown	= no_irq_enable_disable,
-	.enable		= no_irq_enable_disable,
-	.disable	= no_irq_enable_disable,
-	.ack		= no_irq_ack,
-	.end		= no_irq_enable_disable,
-};
-
-int
-handle_IRQ_event(unsigned int irq, struct pt_regs *regs,
-		 struct irqaction *action)
-{
-	int status = 1;	/* Force the "do bottom halves" bit */
-
-	do {
-		if (!(action->flags & SA_INTERRUPT))
-			local_irq_enable();
-		else
-			local_irq_disable();
-
-		status |= action->flags;
-		action->handler(irq, action->dev_id, regs);
-		action = action->next;
-	} while (action);
-	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
-	local_irq_disable();
-
-	return status;
-}
-
-/*
- * Generic enable/disable code: this just calls
- * down into the PIC-specific version for the actual
- * hardware disable after having gotten the irq
- * controller lock. 
- */
-void inline
-disable_irq_nosync(unsigned int irq)
-{
-	irq_desc_t *desc = irq_desc + irq;
-	unsigned long flags;
-
-	spin_lock_irqsave(&desc->lock, flags);
-	if (!desc->depth++) {
-		desc->status |= IRQ_DISABLED;
-		desc->handler->disable(irq);
-	}
-	spin_unlock_irqrestore(&desc->lock, flags);
-}
-
-/*
- * Synchronous version of the above, making sure the IRQ is
- * no longer running on any other IRQ..
- */
-void
-disable_irq(unsigned int irq)
-{
-	disable_irq_nosync(irq);
-	synchronize_irq(irq);
-}
-
-void
-enable_irq(unsigned int irq)
-{
-	irq_desc_t *desc = irq_desc + irq;
-	unsigned long flags;
-
-	spin_lock_irqsave(&desc->lock, flags);
-	switch (desc->depth) {
-	case 1: {
-		unsigned int status = desc->status & ~IRQ_DISABLED;
-		desc->status = status;
-		if ((status & (IRQ_PENDING | IRQ_REPLAY)) == IRQ_PENDING) {
-			desc->status = status | IRQ_REPLAY;
-			hw_resend_irq(desc->handler,irq);
-		}
-		desc->handler->enable(irq);
-		/* fall-through */
-	}
-	default:
-		desc->depth--;
-		break;
-	case 0:
-		printk(KERN_ERR "enable_irq() unbalanced from %p\n",
-		       __builtin_return_address(0));
-	}
-	spin_unlock_irqrestore(&desc->lock, flags);
-}
-
 int
 setup_irq(unsigned int irq, struct irqaction * new)
 {
@@ -651,164 +531,3 @@
 
 	irq_exit();
 }
-
-/*
- * IRQ autodetection code..
- *
- * This depends on the fact that any interrupt that
- * comes in on to an unassigned handler will get stuck
- * with "IRQ_WAITING" cleared and the interrupt
- * disabled.
- */
-unsigned long
-probe_irq_on(void)
-{
-	int i;
-	irq_desc_t *desc;
-	unsigned long delay;
-	unsigned long val;
-
-	/* Something may have generated an irq long ago and we want to
-	   flush such a longstanding irq before considering it as spurious. */
-	for (i = NR_IRQS-1; i >= 0; i--) {
-		desc = irq_desc + i;
-
-		spin_lock_irq(&desc->lock);
-		if (!irq_desc[i].action) 
-			irq_desc[i].handler->startup(i);
-		spin_unlock_irq(&desc->lock);
-	}
-
-	/* Wait for longstanding interrupts to trigger. */
-	for (delay = jiffies + HZ/50; time_after(delay, jiffies); )
-		/* about 20ms delay */ barrier();
-
-	/* enable any unassigned irqs (we must startup again here because
-	   if a longstanding irq happened in the previous stage, it may have
-	   masked itself) first, enable any unassigned irqs. */
-	for (i = NR_IRQS-1; i >= 0; i--) {
-		desc = irq_desc + i;
-
-		spin_lock_irq(&desc->lock);
-		if (!desc->action) {
-			desc->status |= IRQ_AUTODETECT | IRQ_WAITING;
-			if (desc->handler->startup(i))
-				desc->status |= IRQ_PENDING;
-		}
-		spin_unlock_irq(&desc->lock);
-	}
-
-	/*
-	 * Wait for spurious interrupts to trigger
-	 */
-	for (delay = jiffies + HZ/10; time_after(delay, jiffies); )
-		/* about 100ms delay */ barrier();
-
-	/*
-	 * Now filter out any obviously spurious interrupts
-	 */
-	val = 0;
-	for (i=0; i<NR_IRQS; i++) {
-		irq_desc_t *desc = irq_desc + i;
-		unsigned int status;
-
-		spin_lock_irq(&desc->lock);
-		status = desc->status;
-
-		if (status & IRQ_AUTODETECT) {
-			/* It triggered already - consider it spurious. */
-			if (!(status & IRQ_WAITING)) {
-				desc->status = status & ~IRQ_AUTODETECT;
-				desc->handler->shutdown(i);
-			} else
-				if (i < 32)
-					val |= 1 << i;
-		}
-		spin_unlock_irq(&desc->lock);
-	}
-
-	return val;
-}
-
-/*
- * Return a mask of triggered interrupts (this
- * can handle only legacy ISA interrupts).
- */
-unsigned int
-probe_irq_mask(unsigned long val)
-{
-	int i;
-	unsigned int mask;
-
-	mask = 0;
-	for (i = 0; i < NR_IRQS; i++) {
-		irq_desc_t *desc = irq_desc + i;
-		unsigned int status;
-
-		spin_lock_irq(&desc->lock);
-		status = desc->status;
-
-		if (status & IRQ_AUTODETECT) {
-			/* We only react to ISA interrupts */
-			if (!(status & IRQ_WAITING)) {
-				if (i < 16)
-					mask |= 1 << i;
-			}
-
-			desc->status = status & ~IRQ_AUTODETECT;
-			desc->handler->shutdown(i);
-		}
-		spin_unlock_irq(&desc->lock);
-	}
-
-	return mask & val;
-}
-
-/*
- * Get the result of the IRQ probe.. A negative result means that
- * we have several candidates (but we return the lowest-numbered
- * one).
- */
-
-int
-probe_irq_off(unsigned long val)
-{
-	int i, irq_found, nr_irqs;
-
-	nr_irqs = 0;
-	irq_found = 0;
-	for (i=0; i<NR_IRQS; i++) {
-		irq_desc_t *desc = irq_desc + i;
-		unsigned int status;
-
-		spin_lock_irq(&desc->lock);
-		status = desc->status;
-
-		if (status & IRQ_AUTODETECT) {
-			if (!(status & IRQ_WAITING)) {
-				if (!nr_irqs)
-					irq_found = i;
-				nr_irqs++;
-			}
-			desc->status = status & ~IRQ_AUTODETECT;
-			desc->handler->shutdown(i);
-		}
-		spin_unlock_irq(&desc->lock);
-	}
-
-	if (nr_irqs > 1)
-		irq_found = -irq_found;
-	return irq_found;
-}
-
-#ifdef CONFIG_SMP
-void synchronize_irq(unsigned int irq)
-{
-        /* is there anything to synchronize with? */
-	if (!irq_desc[irq].action)
-		return;
-
-	while (irq_desc[irq].status & IRQ_INPROGRESS)
-		barrier();
-}
-#endif
diff --minimal -urN -X /usr/share/dontdiff linux-2.5.52.vanilla/include/asm-alpha/hw_irq.h linux-2.5.52/include/asm-alpha/hw_irq.h
--- linux-2.5.52.vanilla/include/asm-alpha/hw_irq.h	Mon Dec 16 05:07:43 2002
+++ linux-2.5.52/include/asm-alpha/hw_irq.h	Tue Dec 24 09:42:39 2002
@@ -13,4 +13,9 @@
 #define ACTUAL_NR_IRQS	NR_IRQS
 #endif
 
+#define ack_bad_irq(irq)
+
+/* Return a pointer to the irq descriptor for IRQ.  */
+#define irq_desc(irq) (irq_desc + (irq))
+
 #endif

--FN+gV9K+162wdwwF--
