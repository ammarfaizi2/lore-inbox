Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267041AbSLXGa0>; Tue, 24 Dec 2002 01:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267042AbSLXGa0>; Tue, 24 Dec 2002 01:30:26 -0500
Received: from samael.donpac.ru ([195.161.172.239]:8966 "EHLO samael.donpac.ru")
	by vger.kernel.org with ESMTP id <S267041AbSLXGaT>;
	Tue, 24 Dec 2002 01:30:19 -0500
From: "Andrey Panin" <pazke@orbita1.ru>
Date: Tue, 24 Dec 2002 09:33:52 +0300
To: linux-kernel@vger.kernel.org
Cc: miles@gnu.org
Subject: [RFC] irq handling code consolidation (v850)
Message-ID: <20021224063352.GE1222@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org, miles@gnu.org
References: <20021224063036.GD1222@pazke>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2/5bycvrmDh4d1IB"
Content-Disposition: inline
In-Reply-To: <20021224063036.GD1222@pazke>
User-Agent: Mutt/1.3.28i
X-Uname: Linux 2.4.20aa1 i686 unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


v850 specific patch attached. Not compiled, not tested.

-- 
Andrey Panin		| Embedded systems software developer
pazke@orbita1.ru	| PGP key: wwwkeys.pgp.net

--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-irq-v850

diff --minimal -urN -X /usr/share/dontdiff linux-2.5.52.vanilla/arch/v850/Kconfig linux-2.5.52/arch/v850/Kconfig
--- linux-2.5.52.vanilla/arch/v850/Kconfig	Thu Dec 19 20:02:33 2002
+++ linux-2.5.52/arch/v850/Kconfig	Tue Dec 24 21:50:45 2002
@@ -23,6 +23,10 @@
 	bool
 	default n
 
+config CONFIG_GENERIC_IRQ
+	bool
+	default y
+
 # Turn off some random 386 crap that can affect device config
 config ISA
 	bool
diff --minimal -urN -X /usr/share/dontdiff linux-2.5.52.vanilla/arch/v850/kernel/irq.c linux-2.5.52/arch/v850/kernel/irq.c
--- linux-2.5.52.vanilla/arch/v850/kernel/irq.c	Thu Nov 28 01:36:17 2002
+++ linux-2.5.52/arch/v850/kernel/irq.c	Tue Dec 24 21:49:19 2002
@@ -26,50 +26,8 @@
 
 #include <asm/system.h>
 
-/*
- * Controller mappings for all interrupt sources:
- */
-irq_desc_t irq_desc[NR_IRQS] __cacheline_aligned =
-	{ [0 ... NR_IRQS-1] = { 0, &no_irq_type, NULL, 0, SPIN_LOCK_UNLOCKED}};
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
-static void enable_none(unsigned int irq) { }
-static unsigned int startup_none(unsigned int irq) { return 0; }
-static void disable_none(unsigned int irq) { }
-static void ack_none(unsigned int irq)
-{
-	/*
-	 * 'what should we do if we get a hw irq event on an illegal vector'.
-	 * each architecture has to answer this themselves, it doesnt deserve
-	 * a generic callback i think.
-	 */
-	printk("received IRQ %d with unknown interrupt type\n", irq);
-}
-
-/* startup is the same as "enable", shutdown is same as "disable" */
-#define shutdown_none	disable_none
-#define end_none	enable_none
-
-struct hw_interrupt_type no_irq_type = {
-	"none",
-	startup_none,
-	shutdown_none,
-	enable_none,
-	disable_none,
-	ack_none,
-	end_none
-};
 
-volatile unsigned long irq_err_count, spurious_count;
+volatile unsigned long spurious_count;
 
 /*
  * Generic, controller-independent functions:
@@ -119,119 +77,6 @@
 	return 0;
 }
 
-/*
- * This should really return information about whether
- * we should do bottom half handling etc. Right now we
- * end up _always_ checking the bottom half, which is a
- * waste of time and is not what some drivers would
- * prefer.
- */
-int handle_IRQ_event(unsigned int irq, struct pt_regs * regs, struct irqaction * action)
-{
-	int status = 1; /* Force the "do bottom halves" bit */
-
-	if (!(action->flags & SA_INTERRUPT))
-		local_irq_enable();
-
-	do {
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
- 
-/**
- *	disable_irq_nosync - disable an irq without waiting
- *	@irq: Interrupt to disable
- *
- *	Disable the selected interrupt line. Disables of an interrupt
- *	stack. Unlike disable_irq(), this function does not ensure existing
- *	instances of the IRQ handler have completed before returning.
- *
- *	This function may be called from IRQ context.
- */
- 
-void inline disable_irq_nosync(unsigned int irq)
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
-/**
- *	disable_irq - disable an irq and wait for completion
- *	@irq: Interrupt to disable
- *
- *	Disable the selected interrupt line. Disables of an interrupt
- *	stack. That is for two disables you need two enables. This
- *	function waits for any pending IRQ handlers for this interrupt
- *	to complete before returning. If you use this function while
- *	holding a resource the IRQ handler may need you will deadlock.
- *
- *	This function may be called - with care - from IRQ context.
- */
- 
-void disable_irq(unsigned int irq)
-{
-	disable_irq_nosync(irq);
-	synchronize_irq(irq);
-}
-
-/**
- *	enable_irq - enable interrupt handling on an irq
- *	@irq: Interrupt to enable
- *
- *	Re-enables the processing of interrupts on this IRQ line
- *	providing no disable_irq calls are now in effect.
- *
- *	This function may be called from IRQ context.
- */
- 
-void enable_irq(unsigned int irq)
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
-		printk("enable_irq(%u) unbalanced from %p\n", irq,
-		       __builtin_return_address(0));
-	}
-	spin_unlock_irqrestore(&desc->lock, flags);
-}
-
 /* Handle interrupt IRQ.  REGS are the registers at the time of ther
    interrupt.  */
 unsigned int handle_irq (int irq, struct pt_regs *regs)
@@ -448,197 +293,6 @@
 		spin_unlock_irqrestore(&desc->lock,flags);
 		return;
 	}
-}
-
-/*
- * IRQ autodetection code..
- *
- * This depends on the fact that any interrupt that
- * comes in on to an unassigned handler will get stuck
- * with "IRQ_WAITING" cleared and the interrupt
- * disabled.
- */
-
-static DECLARE_MUTEX(probe_sem);
-
-/**
- *	probe_irq_on	- begin an interrupt autodetect
- *
- *	Commence probing for an interrupt. The interrupts are scanned
- *	and a mask of potential interrupt lines is returned.
- *
- */
- 
-unsigned long probe_irq_on(void)
-{
-	unsigned int i;
-	irq_desc_t *desc;
-	unsigned long val;
-	unsigned long delay;
-
-	down(&probe_sem);
-	/* 
-	 * something may have generated an irq long ago and we want to
-	 * flush such a longstanding irq before considering it as spurious. 
-	 */
-	for (i = NR_IRQS-1; i > 0; i--)  {
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
-	/*
-	 * enable any unassigned irqs
-	 * (we must startup again here because if a longstanding irq
-	 * happened in the previous stage, it may have masked itself)
-	 */
-	for (i = NR_IRQS-1; i > 0; i--) {
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
-	for (i = 0; i < NR_IRQS; i++) {
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
- 
-/**
- *	probe_irq_mask - scan a bitmap of interrupt lines
- *	@val:	mask of interrupts to consider
- *
- *	Scan the ISA bus interrupt lines and return a bitmap of
- *	active interrupts. The interrupt probe logic state is then
- *	returned to its previous value.
- *
- *	Note: we need to scan all the irq's even though we will
- *	only return ISA irq numbers - just so that we reset them
- *	all to a known state.
- */
-unsigned int probe_irq_mask(unsigned long val)
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
-			if (i < 16 && !(status & IRQ_WAITING))
-				mask |= 1 << i;
-
-			desc->status = status & ~IRQ_AUTODETECT;
-			desc->handler->shutdown(i);
-		}
-		spin_unlock_irq(&desc->lock);
-	}
-	up(&probe_sem);
-
-	return mask & val;
-}
-
-/*
- * Return the one interrupt that triggered (this can
- * handle any interrupt source).
- */
-
-/**
- *	probe_irq_off	- end an interrupt autodetect
- *	@val: mask of potential interrupts (unused)
- *
- *	Scans the unused interrupt lines and returns the line which
- *	appears to have triggered the interrupt. If no interrupt was
- *	found then zero is returned. If more than one interrupt is
- *	found then minus the first candidate is returned to indicate
- *	their is doubt.
- *
- *	The interrupt probe logic state is returned to its previous
- *	value.
- *
- *	BUGS: When used in a module (which arguably shouldnt happen)
- *	nothing prevents two IRQ probe callers from overlapping. The
- *	results of this are non-optimal.
- */
- 
-int probe_irq_off(unsigned long val)
-{
-	int i, irq_found, nr_irqs;
-
-	nr_irqs = 0;
-	irq_found = 0;
-	for (i = 0; i < NR_IRQS; i++) {
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
-	up(&probe_sem);
-
-	if (nr_irqs > 1)
-		irq_found = -irq_found;
-	return irq_found;
 }
 
 /* this was setup_x86_irq but it seems pretty generic */
diff --minimal -urN -X /usr/share/dontdiff linux-2.5.52.vanilla/include/asm-v850/hw_irq.h linux-2.5.52/include/asm-v850/hw_irq.h
--- linux-2.5.52.vanilla/include/asm-v850/hw_irq.h	Tue Dec 24 21:55:02 2002
+++ linux-2.5.52/include/asm-v850/hw_irq.h	Tue Dec 24 21:55:15 2002
@@ -5,4 +5,9 @@
 {
 }
 
+#define ack_bad_irq(irq)
+
+/* Return a pointer to the irq descriptor for IRQ.  */
+#define irq_desc(irq) (irq_desc + (irq))
+
 #endif /* __V850_HW_IRQ_H__ */

--2/5bycvrmDh4d1IB--
