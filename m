Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266547AbUJAVdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266547AbUJAVdD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 17:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266603AbUJAVbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 17:31:49 -0400
Received: from scanner1.mail.elte.hu ([157.181.1.137]:3499 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266547AbUJAUrO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 16:47:14 -0400
Date: Fri, 1 Oct 2004 22:48:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 3/5, 2.6.9-rc3] generic irq subsystem, x64 port
Message-ID: <20041001204822.GC18750@elte.hu>
References: <20041001204533.GA18684@elte.hu> <20041001204642.GA18750@elte.hu> <20041001204740.GB18750@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041001204740.GB18750@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


x64 port of generic hardirq handling.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Christoph Hellwig <hch@lst.de>

--- linux/arch/x86_64/Kconfig.orig
+++ linux/arch/x86_64/Kconfig
@@ -329,6 +329,12 @@ config X86_MCE
 
 endmenu
 
+#
+# Use the generic interrupt handling code in kernel/hardirq.c:
+#
+config GENERIC_HARDIRQS
+	bool
+	default y
 
 menu "Power management options"
 
--- linux/arch/x86_64/kernel/irq.c.orig
+++ linux/arch/x86_64/kernel/irq.c
@@ -3,127 +3,19 @@
  *
  *	Copyright (C) 1992, 1998 Linus Torvalds, Ingo Molnar
  *
- * This file contains the code used by various IRQ handling routines:
- * asking for different IRQ's should be done through these routines
- * instead of just grabbing them. Thus setups with different IRQ numbers
- * shouldn't result in any weird surprises, and installing new handlers
- * should be easier.
+ * This file contains the lowest level x86_64-specific interrupt
+ * entry and irq statistics code. All the remaining irq logic is
+ * done by the generic kernel/hardirq.c code and in the
+ * x86_64-specific irq controller code. (e.g. i8259.c and
+ * io_apic.c.)
  */
 
-/*
- * (mostly architecture independent, will move to kernel/irq.c in 2.5.)
- *
- * IRQs are in fact implemented a bit like signal handlers for the kernel.
- * Naturally it's not a 1:1 relation, but there are similarities.
- */
-
-#include <linux/config.h>
-#include <linux/errno.h>
-#include <linux/module.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/ioport.h>
-#include <linux/interrupt.h>
-#include <linux/timex.h>
-#include <linux/slab.h>
-#include <linux/random.h>
-#include <linux/smp_lock.h>
-#include <linux/init.h>
 #include <linux/kernel_stat.h>
-#include <linux/irq.h>
-#include <linux/proc_fs.h>
+#include <linux/interrupt.h>
 #include <linux/seq_file.h>
-
-#include <asm/atomic.h>
-#include <asm/io.h>
-#include <asm/smp.h>
-#include <asm/system.h>
-#include <asm/bitops.h>
+#include <linux/module.h>
 #include <asm/uaccess.h>
-#include <asm/pgalloc.h>
-#include <asm/delay.h>
-#include <asm/desc.h>
-#include <asm/irq.h>
-
-
-
-/*
- * Linux has a controller-independent x86 interrupt architecture.
- * every controller has a 'controller-template', that is used
- * by the main code to do the right thing. Each driver-visible
- * interrupt source is transparently wired to the appropriate
- * controller. Thus drivers need not be aware of the
- * interrupt-controller.
- *
- * Various interrupt controllers we handle: 8259 PIC, SMP IO-APIC,
- * PIIX4's internal 8259 PIC and SGI's Visual Workstation Cobalt (IO-)APIC.
- * (IO-APICs assumed to be messaging to Pentium local-APICs)
- *
- * the code is designed to be easily extended with new/different
- * interrupt controllers, without having to do assembly magic.
- */
-
-/*
- * Controller mappings for all interrupt sources:
- */
-irq_desc_t irq_desc[NR_IRQS] __cacheline_aligned = {
-	[0 ... NR_IRQS-1] = {
-		.handler = &no_irq_type,
-		.lock = SPIN_LOCK_UNLOCKED
-	}
-};
-
-static void register_irq_proc (unsigned int irq);
-
-/*
- * Special irq handlers.
- */
-
-irqreturn_t no_action(int cpl, void *dev_id, struct pt_regs *regs) { return IRQ_NONE; }
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
-/*
- * 'what should we do if we get a hw irq event on an illegal vector'.
- * each architecture has to answer this themselves, it doesn't deserve
- * a generic callback i think.
- */
-#ifdef CONFIG_X86
-	printk("unexpected IRQ trap at vector %02x\n", irq);
-#ifdef CONFIG_X86_LOCAL_APIC
-	/*
-	 * Currently unexpected vectors happen only on SMP and APIC.
-	 * We _must_ ack these because every local APIC has only N
-	 * irq slots per priority level, and a 'hanging, unacked' IRQ
-	 * holds up an irq slot - in excessive cases (when multiple
-	 * unexpected vectors occur) that might lock up the APIC
-	 * completely.
-	 */
-	ack_APIC_irq();
-#endif
-#endif
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
+#include <asm/io_apic.h>
 
 atomic_t irq_err_count;
 #ifdef CONFIG_X86_IO_APIC
@@ -195,131 +87,6 @@ skip:
 	return 0;
 }
 
-#ifdef CONFIG_SMP
-inline void synchronize_irq(unsigned int irq)
-{
-	while (irq_desc[irq].status & IRQ_INPROGRESS)
-		cpu_relax();
-}
-#endif
-
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
-	int ret;
-
-	if (!(action->flags & SA_INTERRUPT))
-		local_irq_enable();
-
-	do {
-		ret = action->handler(irq, action->dev_id, regs);
-		if (ret == IRQ_HANDLED)
-			status |= action->flags;
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
- *	Disable the selected interrupt line.  Disables and Enables are
- *	nested.
- *	Unlike disable_irq(), this function does not ensure existing
- *	instances of the IRQ handler have completed before returning.
- *
- *	This function must not be called from IRQ context.
- */
- 
-inline void disable_irq_nosync(unsigned int irq)
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
- *	Disable the selected interrupt line.  Enables and Disables are
- *	nested.
- *	This function waits for any pending IRQ handlers for this interrupt
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
- *	enable_irq - enable handling of an irq
- *	@irq: Interrupt to enable
- *
- *	Undoes the effect of one call to disable_irq().  If this
- *	matches the last disable, processing of interrupts on this
- *	IRQ line is re-enabled.
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
 /*
  * do_IRQ handles all normal device IRQ's (the special
  * SMP cross-CPU interrupts have their own specific
@@ -327,591 +94,15 @@ void enable_irq(unsigned int irq)
  */
 asmlinkage unsigned int do_IRQ(struct pt_regs *regs)
 {	
-	/* 
-	 * We ack quickly, we don't want the irq controller
-	 * thinking we're snobs just because some other CPU has
-	 * disabled global interrupts (we have already done the
-	 * INT_ACK cycles, it's too late to try to pretend to the
-	 * controller that we aren't taking the interrupt).
-	 *
-	 * 0 return value means that this irq is already being
-	 * handled by some other CPU. (or is disabled)
-	 */
-	unsigned irq = regs->orig_rax & 0xff; /* high bits used in ret_from_ code  */
-	int cpu = smp_processor_id();
-	irq_desc_t *desc = irq_desc + irq;
-	struct irqaction * action;
-	unsigned int status;
-
-	if (irq > 256) BUG();
+	/* high bits used in ret_from_ code  */
+	unsigned irq = regs->orig_rax & 0xff;
 
-	irq_enter(); 
-	kstat_cpu(cpu).irqs[irq]++;
-	spin_lock(&desc->lock);
-	desc->handler->ack(irq);
-	/*
-	   REPLAY is when Linux resends an IRQ that was dropped earlier
-	   WAITING is used by probe to mark irqs that are being tested
-	   */
-	status = desc->status & ~(IRQ_REPLAY | IRQ_WAITING);
-	status |= IRQ_PENDING; /* we _want_ to handle it */
-
-	/*
-	 * If the IRQ is disabled for whatever reason, we cannot
-	 * use the action we have.
-	 */
-	action = NULL;
-	if (likely(!(status & (IRQ_DISABLED | IRQ_INPROGRESS)))) {
-		action = desc->action;
-		status &= ~IRQ_PENDING; /* we commit to handling */
-		status |= IRQ_INPROGRESS; /* we are handling it */
-	}
-	desc->status = status;
-
-	/*
-	 * If there is no IRQ handler or it was disabled, exit early.
-	   Since we set PENDING, if another processor is handling
-	   a different instance of this same irq, the other processor
-	   will take care of it.
-	 */
-	if (unlikely(!action))
-		goto out;
-
-	/*
-	 * Edge triggered interrupts need to remember
-	 * pending events.
-	 * This applies to any hw interrupts that allow a second
-	 * instance of the same irq to arrive while we are in do_IRQ
-	 * or in the handler. But the code here only handles the _second_
-	 * instance of the irq, not the third or fourth. So it is mostly
-	 * useful for irq hardware that does not mask cleanly in an
-	 * SMP environment.
-	 */
-	for (;;) {
-		spin_unlock(&desc->lock);
-		handle_IRQ_event(irq, regs, action);
-		spin_lock(&desc->lock);
-		
-		if (unlikely(!(desc->status & IRQ_PENDING)))
-			break;
-		desc->status &= ~IRQ_PENDING;
-	}
-	desc->status &= ~IRQ_INPROGRESS;
-out:
-	/*
-	 * The ->end() handler has to deal with interrupts which got
-	 * disabled while the handler was running.
-	 */
-	if (irq > 256) BUG();
-	desc->handler->end(irq);
-	spin_unlock(&desc->lock);
+	irq_enter();
+	BUG_ON(irq > 256);
 
+	__do_IRQ(irq, regs);
 	irq_exit();
-	return 1;
-}
-
-int can_request_irq(unsigned int irq, unsigned long irqflags)
-{
-	struct irqaction *action;
-
-	if (irq >= NR_IRQS)
-		return 0;
-	action = irq_desc[irq].action;
-	if (action) {
-		if (irqflags & action->flags & SA_SHIRQ)
-			action = NULL;
-	}
-	return !action;
-}
-
-/**
- *	request_irq - allocate an interrupt line
- *	@irq: Interrupt line to allocate
- *	@handler: Function to be called when the IRQ occurs
- *	@irqflags: Interrupt type flags
- *	@devname: An ascii name for the claiming device
- *	@dev_id: A cookie passed back to the handler function
- *
- *	This call allocates interrupt resources and enables the
- *	interrupt line and IRQ handling. From the point this
- *	call is made your handler function may be invoked. Since
- *	your handler function must clear any interrupt the board 
- *	raises, you must take care both to initialise your hardware
- *	and to set up the interrupt handler in the right order.
- *
- *	Dev_id must be globally unique. Normally the address of the
- *	device data structure is used as the cookie. Since the handler
- *	receives this value it makes sense to use it.
- *
- *	If your interrupt is shared you must pass a non NULL dev_id
- *	as this is required when freeing the interrupt.
- *
- *	Flags:
- *
- *	SA_SHIRQ		Interrupt is shared
- *
- *	SA_INTERRUPT		Disable local interrupts while processing
- *
- *	SA_SAMPLE_RANDOM	The interrupt can be used for entropy
- *
- */
- 
-int request_irq(unsigned int irq, 
-		irqreturn_t (*handler)(int, void *, struct pt_regs *),
-		unsigned long irqflags, 
-		const char * devname,
-		void *dev_id)
-{
-	int retval;
-	struct irqaction * action;
-
-#if 1
-	/*
-	 * Sanity-check: shared interrupts should REALLY pass in
-	 * a real dev-ID, otherwise we'll have trouble later trying
-	 * to figure out which interrupt is which (messes up the
-	 * interrupt freeing logic etc).
-	 */
-	if (irqflags & SA_SHIRQ) {
-		if (!dev_id)
-			printk("Bad boy: %s (at 0x%x) called us without a dev_id!\n", devname, (&irq)[-1]);
-	}
-#endif
-
-	if (irq >= NR_IRQS)
-		return -EINVAL;
-	if (!handler)
-		return -EINVAL;
-
-	action = (struct irqaction *)
-			kmalloc(sizeof(struct irqaction), GFP_ATOMIC);
-	if (!action)
-		return -ENOMEM;
-
-	action->handler = handler;
-	action->flags = irqflags;
-	cpus_clear(action->mask);
-	action->name = devname;
-	action->next = NULL;
-	action->dev_id = dev_id;
-
-	retval = setup_irq(irq, action);
-	if (retval)
-		kfree(action);
-	return retval;
-}
-
-EXPORT_SYMBOL(request_irq);
-
-/**
- *	free_irq - free an interrupt
- *	@irq: Interrupt line to free
- *	@dev_id: Device identity to free
- *
- *	Remove an interrupt handler. The handler is removed and if the
- *	interrupt line is no longer in use by any driver it is disabled.
- *	On a shared IRQ the caller must ensure the interrupt is disabled
- *	on the card it drives before calling this function. The function
- *	does not return until any executing interrupts for this IRQ
- *	have completed.
- *
- *	This function may be called from interrupt context. 
- *
- *	Bugs: Attempting to free an irq in a handler for the same irq hangs
- *	      the machine.
- */
- 
-void free_irq(unsigned int irq, void *dev_id)
-{
-	irq_desc_t *desc;
-	struct irqaction **p;
-	unsigned long flags;
-
-	if (irq >= NR_IRQS)
-		return;
-
-	desc = irq_desc + irq;
-	spin_lock_irqsave(&desc->lock,flags);
-	p = &desc->action;
-	for (;;) {
-		struct irqaction * action = *p;
-		if (action) {
-			struct irqaction **pp = p;
-			p = &action->next;
-			if (action->dev_id != dev_id)
-				continue;
-
-			/* Found it - now remove it from the list of entries */
-			*pp = action->next;
-			if (!desc->action) {
-				desc->status |= IRQ_DISABLED;
-				desc->handler->shutdown(irq);
-			}
-			spin_unlock_irqrestore(&desc->lock,flags);
-
-			synchronize_irq(irq);
-			kfree(action);
-			return;
-		}
-		printk("Trying to free free IRQ%d\n",irq);
-		spin_unlock_irqrestore(&desc->lock,flags);
-		return;
-	}
-}
-
-EXPORT_SYMBOL(free_irq);
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
-EXPORT_SYMBOL(probe_irq_on);
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
- *	BUGS: When used in a module (which arguably shouldn't happen)
- *	nothing prevents two IRQ probe callers from overlapping. The
- *	results of this are non-optimal.
- */
- 
-int probe_irq_off(unsigned long val)
-{
-	int i, irq_found, nr_irqs;
 
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
-}
-
-EXPORT_SYMBOL(probe_irq_off);
-
-/* this was setup_x86_irq but it seems pretty generic */
-int setup_irq(unsigned int irq, struct irqaction * new)
-{
-	int shared = 0;
-	unsigned long flags;
-	struct irqaction *old, **p;
-	irq_desc_t *desc = irq_desc + irq;
-
-	if (desc->handler == &no_irq_type)
-		return -ENOSYS;
-
-	/*
-	 * Some drivers like serial.c use request_irq() heavily,
-	 * so we have to be careful not to interfere with a
-	 * running system.
-	 */
-	if (new->flags & SA_SAMPLE_RANDOM) {
-		/*
-		 * This function might sleep, we want to call it first,
-		 * outside of the atomic block.
-		 * Yes, this might clear the entropy pool if the wrong
-		 * driver is attempted to be loaded, without actually
-		 * installing a new handler, but is this really a problem,
-		 * only the sysadmin is able to do this.
-		 */
-		rand_initialize_irq(irq);
-	}
-
-	/*
-	 * The following block of code has to be executed atomically
-	 */
-	spin_lock_irqsave(&desc->lock,flags);
-	p = &desc->action;
-	if ((old = *p) != NULL) {
-		/* Can't share interrupts unless both agree to */
-		if (!(old->flags & new->flags & SA_SHIRQ)) {
-			spin_unlock_irqrestore(&desc->lock,flags);
-			return -EBUSY;
-		}
-
-		/* add new interrupt at end of irq queue */
-		do {
-			p = &old->next;
-			old = *p;
-		} while (old);
-		shared = 1;
-	}
-
-	*p = new;
-
-	if (!shared) {
-		desc->depth = 0;
-		desc->status &= ~(IRQ_DISABLED | IRQ_AUTODETECT | IRQ_WAITING);
-		desc->handler->startup(irq);
-	}
-	spin_unlock_irqrestore(&desc->lock,flags);
-
-	register_irq_proc(irq);
-	return 0;
-}
-
-static struct proc_dir_entry * root_irq_dir;
-static struct proc_dir_entry * irq_dir [NR_IRQS];
-
-#ifdef CONFIG_SMP
-
-static struct proc_dir_entry * smp_affinity_entry [NR_IRQS];
-
-static cpumask_t irq_affinity [NR_IRQS] = { [0 ... NR_IRQS-1] = CPU_MASK_ALL };
-static int irq_affinity_read_proc (char *page, char **start, off_t off,
-			int count, int *eof, void *data)
-{
-	int len = cpumask_scnprintf(page, count, irq_affinity[(long)data]);
-	if (count - len < 2)
-		return -EINVAL;
-	len += sprintf(page + len, "\n");
-	return len;
-}
-
-static int irq_affinity_write_proc (struct file *file,
-					const char __user *buffer,
-					unsigned long count, void *data)
-{
-	int irq = (long) data, full_count = count, err;
-	cpumask_t tmp, new_value;
-
-	if (!irq_desc[irq].handler->set_affinity)
-		return -EIO;
-
-	err = cpumask_parse(buffer, count, new_value);
-
-	/*
-	 * Do not allow disabling IRQs completely - it's a too easy
-	 * way to make the system unusable accidentally :-) At least
-	 * one online CPU still has to be targeted.
-	 */
-	cpus_and(tmp, new_value, cpu_online_map);
-	if (cpus_empty(tmp))
-		return -EINVAL;
-
-	irq_affinity[irq] = new_value;
-	irq_desc[irq].handler->set_affinity(irq, new_value);
-
-	return full_count;
-}
-
-#endif
-
-#define MAX_NAMELEN 10
-
-static void register_irq_proc (unsigned int irq)
-{
-	char name [MAX_NAMELEN];
-
-	if (!root_irq_dir || (irq_desc[irq].handler == &no_irq_type) ||
-			irq_dir[irq])
-		return;
-
-	memset(name, 0, MAX_NAMELEN);
-	sprintf(name, "%d", irq);
-
-	/* create /proc/irq/1234 */
-	irq_dir[irq] = proc_mkdir(name, root_irq_dir);
-
-#ifdef CONFIG_SMP
-	{
-		struct proc_dir_entry *entry;
-
-		/* create /proc/irq/1234/smp_affinity */
-		entry = create_proc_entry("smp_affinity", 0600, irq_dir[irq]);
-
-		if (entry) {
-			entry->nlink = 1;
-			entry->data = (void *)(long)irq;
-			entry->read_proc = irq_affinity_read_proc;
-			entry->write_proc = irq_affinity_write_proc;
-		}
-
-		smp_affinity_entry[irq] = entry;
-	}
-#endif
+	return 1;
 }
 
-void init_irq_proc (void)
-{
-	int i;
-
-	/* create /proc/irq */
-	root_irq_dir = proc_mkdir("irq", NULL);
-
-	/* create /proc/irq/prof_cpu_mask */
-	create_prof_cpu_mask(root_irq_dir);
-
-	/*
-	 * Create entries for all existing IRQs.
-	 */
-	for (i = 0; i < NR_IRQS; i++)
-		register_irq_proc(i);
-}
--- linux/include/asm-x86_64/irq.h.orig
+++ linux/include/asm-x86_64/irq.h
@@ -44,11 +44,6 @@ static __inline__ int irq_canonicalize(i
 	return ((irq == 2) ? 9 : irq);
 }
 
-extern void disable_irq(unsigned int);
-extern void disable_irq_nosync(unsigned int);
-extern void enable_irq(unsigned int);
-extern int can_request_irq(unsigned int, unsigned long flags);
-
 #ifdef CONFIG_X86_LOCAL_APIC
 #define ARCH_HAS_NMI_WATCHDOG		/* See include/linux/nmi.h */
 #endif
--- linux/include/asm-x86_64/hardirq.h.orig
+++ linux/include/asm-x86_64/hardirq.h
@@ -5,6 +5,7 @@
 #include <linux/threads.h>
 #include <linux/irq.h>
 #include <asm/pda.h>
+#include <asm/apic.h>
 
 #define __ARCH_IRQ_STAT 1
 
@@ -15,47 +16,24 @@
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
 /*
- * We put the hardirq and softirq counter into the preemption
- * counter. The bitmask has the following meaning:
- *
- * - bits 0-7 are the preemption count (max preemption depth: 256)
- * - bits 8-15 are the softirq count (max # of softirqs: 256)
- * - bits 16-23 are the hardirq count (max # of hardirqs: 256)
- *
- * - ( bit 26 is the PREEMPT_ACTIVE flag. )
- *
- * PREEMPT_MASK: 0x000000ff
- * HARDIRQ_MASK: 0x0000ff00
- * SOFTIRQ_MASK: 0x00ff0000
+ * 'what should we do if we get a hw irq event on an illegal vector'.
+ * each architecture has to answer this themselves.
  */
-
-#define PREEMPT_BITS	8
-#define SOFTIRQ_BITS	8
-#define HARDIRQ_BITS	8
-
-#define PREEMPT_SHIFT	0
-#define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
-#define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
-
-/*
- * The hardirq mask has to be large enough to have
- * space for potentially all IRQ sources in the system
- * nesting on a single CPU:
- */
-#if (1 << HARDIRQ_BITS) < NR_IRQS
-# error HARDIRQ_BITS is too low!
+static inline void ack_bad_irq(unsigned int irq)
+{
+#ifdef CONFIG_X86
+	printk("unexpected IRQ trap at vector %02x\n", irq);
+#ifdef CONFIG_X86_LOCAL_APIC
+	/*
+	 * Currently unexpected vectors happen only on SMP and APIC.
+	 * We _must_ ack these because every local APIC has only N
+	 * irq slots per priority level, and a 'hanging, unacked' IRQ
+	 * holds up an irq slot - in excessive cases (when multiple
+	 * unexpected vectors occur) that might lock up the APIC
+	 * completely.
+	 */
+	ack_APIC_irq();
 #endif
-
-#define nmi_enter()		(irq_enter())
-#define nmi_exit()		(preempt_count() -= HARDIRQ_OFFSET)
-
-#define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
-#define irq_exit()							\
-do {									\
-		preempt_count() -= IRQ_EXIT_OFFSET;			\
-		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
-			do_softirq();					\
-		preempt_enable_no_resched();				\
-} while (0)
-
+#endif
+}
 #endif /* __ASM_HARDIRQ_H */
