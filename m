Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262058AbTELLUv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 07:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbTELLUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 07:20:51 -0400
Received: from cs-ats40.donpac.ru ([217.107.128.161]:49157 "EHLO pazke")
	by vger.kernel.org with ESMTP id S262058AbTELLUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 07:20:19 -0400
Date: Mon, 12 May 2003 15:33:01 +0400
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] irq handling consolidation (i386 part)
Message-ID: <20030512113301.GB1315@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="eJnRUKwClWJh1Khz"
Content-Disposition: inline
X-Uname: Linux 2.5.68 i686 unknown
User-Agent: Mutt/1.5.4i
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

attached patch (against 2.5.69-bk) is i386 part of irq handling
code consolidation work. Compiles and works.

Please take a look.

Best regards.

-- 
Andrey Panin		| Embedded systems software developer
pazke@orbita1.ru	| PGP key: wwwkeys.pgp.net

--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-irq-i386-2.5.69"

diff --minimal -urN -X /usr/share/dontdiff linux-2.5.69.vanilla/arch/i386/Kconfig linux-2.5.69/arch/i386/Kconfig
--- linux-2.5.69.vanilla/arch/i386/Kconfig	2003-05-07 20:40:38.000000000 +0400
+++ linux-2.5.69/arch/i386/Kconfig	2003-05-10 20:55:06.000000000 +0400
@@ -18,6 +18,10 @@
 	bool
 	default y
 
+config GENERIC_IRQ
+	bool
+	default y
+
 config SBUS
 	bool
 
diff --minimal -urN -X /usr/share/dontdiff linux-2.5.69.vanilla/arch/i386/kernel/irq.c linux-2.5.69/arch/i386/kernel/irq.c
--- linux-2.5.69.vanilla/arch/i386/kernel/irq.c	2003-05-07 20:40:38.000000000 +0400
+++ linux-2.5.69/arch/i386/kernel/irq.c	2003-05-10 21:05:49.000000000 +0400
@@ -2,132 +2,27 @@
  *	linux/arch/i386/kernel/irq.c
  *
  *	Copyright (C) 1992, 1998 Linus Torvalds, Ingo Molnar
- *
- * This file contains the code used by various IRQ handling routines:
- * asking for different IRQ's should be done through these routines
- * instead of just grabbing them. Thus setups with different IRQ numbers
- * shouldn't result in any weird surprises, and installing new handlers
- * should be easier.
- */
-
-/*
- * (mostly architecture independent, will move to kernel/irq.c in 2.5.)
- *
- * IRQs are in fact implemented a bit like signal handlers for the kernel.
- * Naturally it's not a 1:1 relation, but there are similarities.
  */
 
 #include <linux/config.h>
-#include <linux/errno.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/ioport.h>
 #include <linux/interrupt.h>
-#include <linux/timex.h>
-#include <linux/slab.h>
-#include <linux/random.h>
-#include <linux/smp_lock.h>
-#include <linux/init.h>
 #include <linux/kernel_stat.h>
-#include <linux/irq.h>
-#include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/kallsyms.h>
 
 #include <asm/atomic.h>
-#include <asm/io.h>
-#include <asm/smp.h>
-#include <asm/system.h>
-#include <asm/bitops.h>
-#include <asm/uaccess.h>
-#include <asm/pgalloc.h>
-#include <asm/delay.h>
-#include <asm/desc.h>
-#include <asm/irq.h>
-
+#include <asm/io_apic.h>	/* for APIC_MISMATCH_DEBUG */
 
 
 /*
- * Linux has a controller-independent x86 interrupt architecture.
- * every controller has a 'controller-template', that is used
- * by the main code to do the right thing. Each driver-visible
- * interrupt source is transparently wired to the apropriate
- * controller. Thus drivers need not be aware of the
- * interrupt-controller.
- *
  * Various interrupt controllers we handle: 8259 PIC, SMP IO-APIC,
  * PIIX4's internal 8259 PIC and SGI's Visual Workstation Cobalt (IO-)APIC.
  * (IO-APICs assumed to be messaging to Pentium local-APICs)
- *
- * the code is designed to be easily extended with new/different
- * interrupt controllers, without having to do assembly magic.
  */
 
-/*
- * Controller mappings for all interrupt sources:
- */
-irq_desc_t irq_desc[NR_IRQS] __cacheline_aligned =
-	{ [0 ... NR_IRQS-1] = { 0, &no_irq_type, NULL, 0, SPIN_LOCK_UNLOCKED}};
-
-static void register_irq_proc (unsigned int irq);
-
-/*
- * Special irq handlers.
- */
-
-irqreturn_t no_action(int cpl, void *dev_id, struct pt_regs *regs)
-{ return IRQ_NONE; }
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
-#if CONFIG_X86
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
-
-atomic_t irq_err_count;
-#ifdef CONFIG_X86_IO_APIC
-#ifdef APIC_MISMATCH_DEBUG
+#if defined(CONFIG_X86_IO_APIC) && defined(APIC_MISMATCH_DEBUG)
 atomic_t irq_mis_count;
 #endif
-#endif
 
 /*
  * Generic, controller-independent functions:
@@ -189,154 +84,6 @@
 	return 0;
 }
 
-#if CONFIG_SMP
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
-int handle_IRQ_event(unsigned int irq,
-		struct pt_regs *regs, struct irqaction *action)
-{
-	int status = 1;	/* Force the "do bottom halves" bit */
-	int retval = 0;
-	struct irqaction *first_action = action;
-
-	if (!(action->flags & SA_INTERRUPT))
-		local_irq_enable();
-
-	do {
-		status |= action->flags;
-		retval |= action->handler(irq, action->dev_id, regs);
-		action = action->next;
-	} while (action);
-	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
-	local_irq_disable();
-	if (retval != 1) {
-		static int count = 100;
-		if (count) {
-			count--;
-			if (retval) {
-				printk("irq event %d: bogus retval mask %x\n",
-					irq, retval);
-			} else {
-				printk("irq %d: nobody cared!\n", irq);
-			}
-			dump_stack();
-			printk("handlers:\n");
-			action = first_action;
-			do {
-				printk("[<%p>]", action->handler);
-				print_symbol(" (%s)",
-					(unsigned long)action->handler);
-				printk("\n");
-				action = action->next;
-			} while (action);
-		}
-	}
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
- *	This function may be called from IRQ context.
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
@@ -440,554 +187,3 @@
 
 	return 1;
 }
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
-	action->mask = 0;
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
- *	This function must not be called from interrupt context. 
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
-			/* Wait to make sure it's not being used on another CPU */
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
-}
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
-		desc->status &= ~(IRQ_DISABLED | IRQ_AUTODETECT | IRQ_WAITING | IRQ_INPROGRESS);
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
-#define HEX_DIGITS 8
-
-static unsigned int parse_hex_value (const char *buffer,
-		unsigned long count, unsigned long *ret)
-{
-	unsigned char hexnum [HEX_DIGITS];
-	unsigned long value;
-	int i;
-
-	if (!count)
-		return -EINVAL;
-	if (count > HEX_DIGITS)
-		count = HEX_DIGITS;
-	if (copy_from_user(hexnum, buffer, count))
-		return -EFAULT;
-
-	/*
-	 * Parse the first 8 characters as a hex string, any non-hex char
-	 * is end-of-string. '00e1', 'e1', '00E1', 'E1' are all the same.
-	 */
-	value = 0;
-
-	for (i = 0; i < count; i++) {
-		unsigned int c = hexnum[i];
-
-		switch (c) {
-			case '0' ... '9': c -= '0'; break;
-			case 'a' ... 'f': c -= 'a'-10; break;
-			case 'A' ... 'F': c -= 'A'-10; break;
-		default:
-			goto out;
-		}
-		value = (value << 4) | c;
-	}
-out:
-	*ret = value;
-	return 0;
-}
-
-#if CONFIG_SMP
-
-static struct proc_dir_entry * smp_affinity_entry [NR_IRQS];
-
-unsigned long irq_affinity [NR_IRQS] = { [0 ... NR_IRQS-1] = ~0UL };
-static int irq_affinity_read_proc (char *page, char **start, off_t off,
-			int count, int *eof, void *data)
-{
-	if (count < HEX_DIGITS+1)
-		return -EINVAL;
-	return sprintf (page, "%08lx\n", irq_affinity[(long)data]);
-}
-
-static int irq_affinity_write_proc (struct file *file, const char *buffer,
-					unsigned long count, void *data)
-{
-	int irq = (long) data, full_count = count, err;
-	unsigned long new_value;
-
-	if (!irq_desc[irq].handler->set_affinity)
-		return -EIO;
-
-	err = parse_hex_value(buffer, count, &new_value);
-
-	/*
-	 * Do not allow disabling IRQs completely - it's a too easy
-	 * way to make the system unusable accidentally :-) At least
-	 * one online CPU still has to be targeted.
-	 */
-	if (!(new_value & cpu_online_map))
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
-static int prof_cpu_mask_read_proc (char *page, char **start, off_t off,
-			int count, int *eof, void *data)
-{
-	unsigned long *mask = (unsigned long *) data;
-	if (count < HEX_DIGITS+1)
-		return -EINVAL;
-	return sprintf (page, "%08lx\n", *mask);
-}
-
-static int prof_cpu_mask_write_proc (struct file *file, const char *buffer,
-					unsigned long count, void *data)
-{
-	unsigned long *mask = (unsigned long *) data, full_count = count, err;
-	unsigned long new_value;
-
-	err = parse_hex_value(buffer, count, &new_value);
-	if (err)
-		return err;
-
-	*mask = new_value;
-	return full_count;
-}
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
-#if CONFIG_SMP
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
-}
-
-unsigned long prof_cpu_mask = -1;
-
-void init_irq_proc (void)
-{
-	struct proc_dir_entry *entry;
-	int i;
-
-	/* create /proc/irq */
-	root_irq_dir = proc_mkdir("irq", 0);
-
-	/* create /proc/irq/prof_cpu_mask */
-	entry = create_proc_entry("prof_cpu_mask", 0600, root_irq_dir);
-
-	if (!entry)
-	    return;
-
-	entry->nlink = 1;
-	entry->data = (void *)&prof_cpu_mask;
-	entry->read_proc = prof_cpu_mask_read_proc;
-	entry->write_proc = prof_cpu_mask_write_proc;
-
-	/*
-	 * Create entries for all existing IRQs.
-	 */
-	for (i = 0; i < NR_IRQS; i++)
-		register_irq_proc(i);
-}
-
diff --minimal -urN -X /usr/share/dontdiff linux-2.5.69.vanilla/include/asm-i386/hw_irq.h linux-2.5.69/include/asm-i386/hw_irq.h
--- linux-2.5.69.vanilla/include/asm-i386/hw_irq.h	2003-05-07 20:37:19.000000000 +0400
+++ linux-2.5.69/include/asm-i386/hw_irq.h	2003-05-10 20:55:06.000000000 +0400
@@ -16,6 +16,7 @@
 #include <linux/profile.h>
 #include <asm/atomic.h>
 #include <asm/irq.h>
+#include <asm/apic.h>
 
 /*
  * Various low-level irq details needed by irq.c, process.c,
@@ -117,4 +118,39 @@
 static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i) {}
 #endif
 
+extern irq_desc_t irq_desc[NR_IRQS];
+
+/*
+ * Currently unexpected vectors happen only on SMP and APIC.
+ * We _must_ ack these because every local APIC has only N
+ * irq slots per priority level, and a 'hanging, unacked' IRQ
+ * holds up an irq slot - in excessive cases (when multiple
+ * unexpected vectors occur) that might lock up the APIC
+ * completely.
+ */
+#ifdef CONFIG_X86_LOCAL_APIC
+#define arch_ack_bad_irq(irq) ack_APIC_irq()
+#else
+#define arch_ack_bad_irq(irq) do { } while (0)
+#endif
+
+/* Return a pointer to the irq descriptor for IRQ.  */
+#define irq_desc(irq) (irq_desc + (irq))
+
+/* Check irq number */
+#define irq_valid(irq) ((irq) < NR_IRQS)
+
+/* Arch specific hook for setup_irq() */
+#define arch_setup_irq(irq, desc, irqaction) do { } while (0)
+
+/* Used in setup_irq() */
+#define ARCH_NONSHARED_IRQ_MASK \
+	~(IRQ_DISABLED | IRQ_AUTODETECT | IRQ_WAITING | IRQ_INPROGRESS)
+
+#define ARCH_AFFINITY_WIDTH	8
+
+#define ARCH_DEFAULT_IRQ_AFFINITY	~0UL
+
+#define arch_can_create_irq_proc() (1)
+
 #endif /* _ASM_HW_IRQ_H */

--eJnRUKwClWJh1Khz--
