Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265549AbTFZKtV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 06:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265544AbTFZKtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 06:49:21 -0400
Received: from p164.ats40.donpac.ru ([217.107.128.164]:17827 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S265550AbTFZKsk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 06:48:40 -0400
Date: Thu, 26 Jun 2003 15:02:47 +0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] irq handling code consolidation (common part)
Message-ID: <20030626110247.GT9679@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NDuspjMMC1Ui5ypn"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Andrey Panin <pazke@donpac.ru>
X-Spam-Score: -10.2 (----------)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NDuspjMMC1Ui5ypn
Content-Type: multipart/mixed; boundary="O3WNCzIuUImKerqE"
Content-Disposition: inline


--O3WNCzIuUImKerqE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

the irq handling consolidation patch returns from the dead !
Now with runaway irq detection code included !

This patch (against 2.5.73) contains common part of it.

Please take a look.

Best regards.

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--O3WNCzIuUImKerqE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-irq-common-2.5.72"
Content-Transfer-Encoding: quoted-printable

diff --minimal -urN -X /usr/share/dontdiff linux-2.5.72.vanilla/kernel/irq.=
c linux-2.5.72/kernel/irq.c
--- linux-2.5.72.vanilla/kernel/irq.c	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.5.72/kernel/irq.c	2003-06-17 23:01:44.000000000 +0400
@@ -0,0 +1,904 @@
+/*
+ *  linux/kernel/irq.c
+ *
+ *  Architecture independent parts of IRQ handling.
+ *
+ *  Copyright (C) 1992-2002 Linus Torvalds.
+ *
+ *  Modified from the alpha version by Andrey Panin.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+/*
+ * This file contains the code used by various IRQ handling routines:
+ * asking for different IRQ's should be done through these routines
+ * instead of just grabbing them. Thus setups with different IRQ numbers
+ * shouldn't result in any weird surprises, and installing new handlers
+ * should be easier.
+ *
+ * IRQs are in fact implemented a bit like signal handlers for the kernel.
+ * Naturally it's not a 1:1 relation, but there are similarities.
+ *
+ * Linux has a controller-independent x86 interrupt architecture.
+ * every controller has a 'controller-template', that is used
+ * by the main code to do the right thing. Each driver-visible
+ * interrupt source is transparently wired to the apropriate
+ * controller. Thus drivers need not be aware of the
+ * interrupt-controller.
+ *
+ * The code is designed to be easily extended with new/different
+ * interrupt controllers, without having to do assembly magic.
+ */
+
+#include <linux/config.h>
+#include <linux/slab.h>
+#include <linux/errno.h>
+#include <linux/signal.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/random.h>
+#include <linux/jiffies.h>
+#include <linux/proc_fs.h>
+#include <linux/stringify.h>
+#include <linux/kallsyms.h>
+
+#include <asm/param.h>
+#include <asm/semaphore.h>
+#include <asm/hw_irq.h>
+#include <asm/uaccess.h>
+
+#ifndef HAVE_ARCH_IRQ_DESC
+
+/*
+ * Controller mappings for all interrupt sources:
+ */
+irq_desc_t irq_desc[NR_IRQS] __cacheline_aligned =3D {
+	[0 ... NR_IRQS - 1] =3D {
+		.handler =3D	&no_irq_type,
+		.lock =3D		SPIN_LOCK_UNLOCKED,
+	}
+};
+
+#endif
+
+/*
+ * Special irq handlers.
+ */
+
+irqreturn_t no_action(int cpl, void *dev_id, struct pt_regs *regs)
+{
+	return IRQ_NONE;
+}
+
+/*
+ * Generic no controller code
+ */
+atomic_t irq_err_count;
+
+static void no_irq_enable_disable(unsigned int irq) { }
+static unsigned int no_irq_startup(unsigned int irq) { return 0; }
+
+static void no_irq_ack(unsigned int irq)
+{
+	atomic_inc(&irq_err_count);
+	printk(KERN_CRIT "Unexpected IRQ trap at vector %u\n", irq);
+	arch_ack_bad_irq(irq);
+}
+
+struct hw_interrupt_type no_irq_type =3D {
+	.typename	=3D "none",
+	.startup	=3D no_irq_startup,
+	.shutdown	=3D no_irq_enable_disable,
+	.enable		=3D no_irq_enable_disable,
+	.disable	=3D no_irq_enable_disable,
+	.ack		=3D no_irq_ack,
+	.end		=3D no_irq_enable_disable,
+};
+
+/*
+ * This should really return information about whether
+ * we should do bottom half handling etc. Right now we
+ * end up _always_ checking the bottom half, which is a
+ * waste of time and is not what some drivers would
+ * prefer.
+ */
+int handle_IRQ_event(unsigned int irq, struct pt_regs *regs,
+		     struct irqaction *action)
+{
+	int status =3D 1;	/* Force the "do bottom halves" bit */
+	int retval =3D 0;
+
+	if (!(action->flags & SA_INTERRUPT))
+		local_irq_enable();
+
+	do {
+		status |=3D action->flags;
+		retval |=3D action->handler(irq, action->dev_id, regs);
+		action =3D action->next;
+	} while (action);
+
+	if (status & SA_SAMPLE_RANDOM)
+		add_interrupt_randomness(irq);
+
+	local_irq_disable();
+
+	return retval;
+}
+
+static void __report_bad_irq(int irq, irq_desc_t *desc, irqreturn_t action=
_ret)
+{
+	struct irqaction *action;
+
+	if (action_ret !=3D IRQ_HANDLED && action_ret !=3D IRQ_NONE) {
+		printk(KERN_ERR "irq event %d: bogus return value %x\n",
+				irq, action_ret);
+	} else {
+		printk(KERN_ERR "irq %d: nobody cared!\n", irq);
+	}
+	dump_stack();
+	printk(KERN_ERR "handlers:\n");
+	action =3D desc->action;
+	do {
+		printk(KERN_ERR "[<%p>]", action->handler);
+		print_symbol(" (%s)",
+			(unsigned long)action->handler);
+		printk("\n");
+		action =3D action->next;
+	} while (action);
+}
+
+static void report_bad_irq(int irq, irq_desc_t *desc, irqreturn_t action_r=
et)
+{
+	static int count =3D 100;
+
+	if (count) {
+		count--;
+		__report_bad_irq(irq, desc, action_ret);
+	}
+}
+
+int noirqdebug;
+
+static int __init noirqdebug_setup(char *str)
+{
+	noirqdebug =3D 1;
+	printk(KERN_INFO "IRQ lockup detection disabled\n");
+	return 1;
+}
+
+__setup("noirqdebug", noirqdebug_setup);
+
+/*
+ * If 99,900 of the previous 100,000 interrupts have not been handled then
+ * assume that the IRQ is stuck in some manner.  Drop a diagnostic and try=
 to
+ * turn the IRQ off.
+ *
+ * (The other 100-of-100,000 interrupts may have been a correctly-function=
ing
+ *  device sharing an IRQ with the failing one)
+ *
+ * Called under desc->lock
+ */
+void __note_interrupt(int irq, irq_desc_t *desc, irqreturn_t action_ret)
+{
+	if (action_ret !=3D IRQ_HANDLED) {
+		desc->irqs_unhandled++;
+		if (action_ret !=3D IRQ_NONE)
+			report_bad_irq(irq, desc, action_ret);
+	}
+
+	desc->irq_count++;
+	if (desc->irq_count < 100000)
+		return;
+
+	desc->irq_count =3D 0;
+	if (desc->irqs_unhandled > 99900) {
+		/*
+		 * The interrupt is stuck
+		 */
+		__report_bad_irq(irq, desc, action_ret);
+		/*
+		 * Now kill the IRQ
+		 */
+		printk(KERN_EMERG "Disabling IRQ #%d\n", irq);
+		desc->status |=3D IRQ_DISABLED;
+		desc->handler->disable(irq);
+	}
+	desc->irqs_unhandled =3D 0;
+}
+
+#if defined(CONFIG_SMP) && !defined(HAVE_ARCH_SYNCRONIZE_IRQ)
+
+inline void synchronize_irq(unsigned int irq)
+{
+	irq_desc_t *desc =3D irq_desc(irq);
+
+        /* is there anything to synchronize with? */
+	if (!desc->action)
+		return;
+
+	while (desc->status & IRQ_INPROGRESS)
+		cpu_relax();
+}
+
+#endif
+
+/*
+ * Workarounds for interrupt types without startup()/shutdown() (ppc, ppc6=
4).
+ * Will be removed some day.
+ */
+
+static int startup_irq(unsigned int irq)
+{
+	irq_desc_t *desc =3D irq_desc(irq);
+
+	if (desc->handler->startup)
+		return desc->handler->startup(irq);
+	else if (desc->handler->enable)
+		desc->handler->enable(irq);
+	else=20
+		BUG();
+	return 0;
+}
+
+static void shutdown_irq(unsigned int irq)
+{
+	irq_desc_t *desc =3D irq_desc(irq);
+
+	if (desc->handler->shutdown)
+		desc->handler->shutdown(irq);
+	else if (desc->handler->disable)
+		desc->handler->disable(irq);
+	else=20
+		BUG();
+}
+
+/*
+ * Generic enable/disable code: this just calls
+ * down into the PIC-specific version for the actual
+ * hardware disable after having gotten the irq
+ * controller lock.=20
+ */
+=20
+/**
+ *	disable_irq_nosync - disable an irq without waiting
+ *	@irq: Interrupt to disable
+ *
+ *	Disable the selected interrupt line.  Disables and Enables are
+ *	nested.
+ *	Unlike disable_irq(), this function does not ensure existing
+ *	instances of the IRQ handler have completed before returning.
+ *
+ *	This function may be called from IRQ context.
+ */
+inline void disable_irq_nosync(unsigned int irq)
+{
+	irq_desc_t *desc =3D irq_desc(irq);
+	unsigned long flags;
+
+	spin_lock_irqsave(&desc->lock, flags);
+	if (!desc->depth++) {
+		/* Needed for ppc & ppc64, doesn't harm others (really ?) */
+		if (!(desc->status & IRQ_PER_CPU))
+			desc->status |=3D IRQ_DISABLED;
+		desc->handler->disable(irq);
+	}
+	spin_unlock_irqrestore(&desc->lock, flags);
+}
+
+/**
+ *	disable_irq - disable an irq and wait for completion
+ *	@irq: Interrupt to disable
+ *
+ *	Disable the selected interrupt line.  Enables and Disables are
+ *	nested. That is for two disables you need two enables.
+ *	This function waits for any pending IRQ handlers for this interrupt
+ *	to complete before returning. If you use this function while
+ *	holding a resource the IRQ handler may need you will deadlock.
+ *
+ *	This function may be called - with care - from IRQ context.
+ */
+void disable_irq(unsigned int irq)
+{
+	disable_irq_nosync(irq);
+	synchronize_irq(irq);
+}
+
+/**
+ *	enable_irq - enable handling of an irq
+ *	@irq: Interrupt to enable
+ *
+ *	Undoes the effect of one call to disable_irq().  If this
+ *	matches the last disable, processing of interrupts on this
+ *	IRQ line is re-enabled.
+ *
+ *	This function may be called from IRQ context.
+ */
+void enable_irq(unsigned int irq)
+{
+	irq_desc_t *desc =3D irq_desc(irq);
+	unsigned long flags;
+
+	spin_lock_irqsave(&desc->lock, flags);
+	switch (desc->depth) {
+	case 1: {
+		unsigned int status =3D desc->status & ~IRQ_DISABLED;
+		desc->status =3D status;
+		if ((status & (IRQ_PENDING | IRQ_REPLAY)) =3D=3D IRQ_PENDING) {
+			desc->status =3D status | IRQ_REPLAY;
+			hw_resend_irq(desc->handler, irq);
+		}
+		desc->handler->enable(irq);
+		/* fall-through */
+	}
+	default:
+		desc->depth--;
+		break;
+	case 0:
+		printk(KERN_ERR "enable_irq(%u) unbalanced from %p\n",
+		       irq, __builtin_return_address(0));
+	}
+	spin_unlock_irqrestore(&desc->lock, flags);
+}
+
+/**
+ *	request_irq - allocate an interrupt line
+ *	@irq: Interrupt line to allocate
+ *	@handler: Function to be called when the IRQ occurs
+ *	@irqflags: Interrupt type flags
+ *	@devname: An ascii name for the claiming device
+ *	@dev_id: A cookie passed back to the handler function
+ *
+ *	This call allocates interrupt resources and enables the
+ *	interrupt line and IRQ handling. From the point this
+ *	call is made your handler function may be invoked. Since
+ *	your handler function must clear any interrupt the board=20
+ *	raises, you must take care both to initialise your hardware
+ *	and to set up the interrupt handler in the right order.
+ *
+ *	Dev_id must be globally unique. Normally the address of the
+ *	device data structure is used as the cookie. Since the handler
+ *	receives this value it makes sense to use it.
+ *
+ *	If your interrupt is shared you must pass a non NULL dev_id
+ *	as this is required when freeing the interrupt.
+ *
+ *	Flags:
+ *
+ *	SA_SHIRQ		Interrupt is shared
+ *
+ *	SA_INTERRUPT		Disable local interrupts while processing
+ *
+ *	SA_SAMPLE_RANDOM	The interrupt can be used for entropy
+ */
+int request_irq(unsigned int irq,
+		irqreturn_t (*handler)(int, void *, struct pt_regs *),
+		unsigned long irqflags,
+		const char *devname,
+		void *dev_id)
+{
+	int retval;
+	struct irqaction *action;
+
+	/*
+	 * Sanity-check: shared interrupts should REALLY pass in
+	 * a real dev-ID, otherwise we'll have trouble later trying
+	 * to figure out which interrupt is which (messes up the
+	 * interrupt freeing logic etc).
+	 */
+	if (irqflags & SA_SHIRQ) {
+		if (!dev_id)
+			printk(KERN_ERR "Bad boy: %s (at %p) called us " \
+				"without a dev_id!\n", devname,
+				__builtin_return_address(0));
+	}
+
+	if (!irq_valid(irq) || !handler)
+		return -EINVAL;
+
+	action =3D kmalloc(sizeof(struct irqaction), GFP_ATOMIC);
+	if (!action)
+		return -ENOMEM;
+
+	action->handler =3D handler;
+	action->flags =3D irqflags;
+	action->mask =3D 0;
+	action->name =3D devname;
+	action->next =3D NULL;
+	action->dev_id =3D dev_id;
+
+	retval =3D setup_irq(irq, action);
+	if (retval)
+		kfree(action);
+	return retval;
+}
+
+#ifndef HAVE_ARCH_IRQ_PROC
+void register_irq_proc(unsigned int irq);
+#endif
+
+int setup_irq(unsigned int irq, struct irqaction *new)
+{
+	int shared =3D 0;
+	unsigned long flags;
+	struct irqaction *old, **p;
+	irq_desc_t *desc =3D irq_desc(irq);
+
+	if (desc->handler =3D=3D &no_irq_type)
+		return -ENOSYS;
+
+	/*
+	 * Some drivers like serial.c use request_irq() heavily,
+	 * so we have to be careful not to interfere with a
+	 * running system.
+	 */
+	if (new->flags & SA_SAMPLE_RANDOM) {
+		/*
+		 * This function might sleep, we want to call it first,
+		 * outside of the atomic block.
+		 * Yes, this might clear the entropy pool if the wrong
+		 * driver is attempted to be loaded, without actually
+		 * installing a new handler, but is this really a problem,
+		 * only the sysadmin is able to do this.
+		 */
+		rand_initialize_irq(irq);
+	}
+
+	arch_setup_irq(irq, desc, new);
+
+	/*
+	 * The following block of code has to be executed atomically
+	 */
+	spin_lock_irqsave(&desc->lock, flags);
+	p =3D &desc->action;
+	if ((old =3D *p) !=3D NULL) {
+		/* Can't share interrupts unless both agree to */
+		if (!(old->flags & new->flags & SA_SHIRQ)) {
+			spin_unlock_irqrestore(&desc->lock, flags);
+			return -EBUSY;
+		}
+
+		/* add new interrupt at end of irq queue */
+		do {
+			p =3D &old->next;
+			old =3D *p;
+		} while (old);
+		shared =3D 1;
+	}
+
+	*p =3D new;
+
+	if (!shared) {
+		desc->depth =3D 0;
+		desc->status &=3D ARCH_NONSHARED_IRQ_MASK;
+		startup_irq(irq);
+	}
+	spin_unlock_irqrestore(&desc->lock, flags);
+
+	register_irq_proc(irq);
+
+	return 0;
+}
+
+/**
+ *	free_irq - free an interrupt
+ *	@irq: Interrupt line to free
+ *	@dev_id: Device identity to free
+ *
+ *	Remove an interrupt handler. The handler is removed and if the
+ *	interrupt line is no longer in use by any driver it is disabled.
+ *	On a shared IRQ the caller must ensure the interrupt is disabled
+ *	on the card it drives before calling this function. The function
+ *	does not return until any executing interrupts for this IRQ
+ *	have completed.
+ *
+ *	This function must not be called from interrupt context.=20
+ */
+void free_irq(unsigned int irq, void *dev_id)
+{
+	irq_desc_t *desc;
+	struct irqaction **p;
+	unsigned long flags;
+
+	if (!irq_valid(irq)) {
+		printk(KERN_CRIT "Trying to free IRQ%d\n", irq);
+		return;
+	}
+
+	desc =3D irq_desc(irq);
+	spin_lock_irqsave(&desc->lock, flags);
+	p =3D &desc->action;
+	for (;;) {
+		struct irqaction * action =3D *p;
+		if (action) {
+			struct irqaction **pp =3D p;
+			p =3D &action->next;
+			if (action->dev_id !=3D dev_id)
+				continue;
+
+			/* Found it - now remove it from the list of entries */
+			*pp =3D action->next;
+			if (!desc->action) {
+				desc->status |=3D IRQ_DISABLED;
+				shutdown_irq(irq);
+			}
+			spin_unlock_irqrestore(&desc->lock, flags);
+
+			/* Wait to make sure it's not being used on another CPU */
+			synchronize_irq(irq);
+			kfree(action);
+			return;
+		}
+		printk(KERN_CRIT "Trying to free free IRQ%d\n", irq);
+		spin_unlock_irqrestore(&desc->lock, flags);
+		return;
+	}
+}
+
+#ifndef HAVE_ARCH_IRQ_PROBE
+
+/*
+ * IRQ autodetection code..
+ *
+ * This depends on the fact that any interrupt that
+ * comes in on to an unassigned handler will get stuck
+ * with "IRQ_WAITING" cleared and the interrupt
+ * disabled.
+ */
+
+static DECLARE_MUTEX(probe_sem);
+
+/**
+ *	probe_irq_on - begin an interrupt autodetect
+ *
+ *	Commence probing for an interrupt. The interrupts are scanned
+ *	and a mask of potential interrupt lines is returned.
+ *
+ */
+unsigned long probe_irq_on(void)
+{
+	unsigned int i;
+	irq_desc_t *desc;
+	unsigned long val;
+	unsigned long delay;
+
+	down(&probe_sem);
+	/*=20
+	 * something may have generated an irq long ago and we want to
+	 * flush such a longstanding irq before considering it as spurious.=20
+	 */
+	for (i =3D NR_IRQS - 1; i > 0; i--)  {
+		desc =3D irq_desc(i);
+
+		spin_lock_irq(&desc->lock);
+		if (!desc->action)=20
+			startup_irq(i);
+		spin_unlock_irq(&desc->lock);
+	}
+
+	/* Wait for longstanding interrupts to trigger. */
+	for (delay =3D jiffies + HZ/50; time_after(delay, jiffies); )
+		/* about 20ms delay */ barrier();
+
+	/*
+	 * enable any unassigned irqs
+	 * (we must startup again here because if a longstanding irq
+	 * happened in the previous stage, it may have masked itself)
+	 */
+	for (i =3D NR_IRQS-1; i > 0; i--) {
+		desc =3D irq_desc(i);
+
+		spin_lock_irq(&desc->lock);
+		if (!desc->action) {
+			desc->status |=3D IRQ_AUTODETECT | IRQ_WAITING;
+			if (startup_irq(i))
+				desc->status |=3D IRQ_PENDING;
+		}
+		spin_unlock_irq(&desc->lock);
+	}
+
+	/*
+	 * Wait for spurious interrupts to trigger
+	 */
+	for (delay =3D jiffies + HZ/10; time_after(delay, jiffies); )
+		/* about 100ms delay */ barrier();
+
+	/*
+	 * Now filter out any obviously spurious interrupts
+	 */
+	val =3D 0;
+	for (i =3D 0; i < NR_IRQS; i++) {
+		irq_desc_t *desc =3D irq_desc(i);
+		unsigned int status;
+
+		spin_lock_irq(&desc->lock);
+		status =3D desc->status;
+
+		if (status & IRQ_AUTODETECT) {
+			/* It triggered already - consider it spurious. */
+			if (!(status & IRQ_WAITING)) {
+				desc->status =3D status & ~IRQ_AUTODETECT;
+				shutdown_irq(i);
+			} else
+				if (i < 32)
+					val |=3D 1 << i;
+		}
+		spin_unlock_irq(&desc->lock);
+	}
+
+	return val;
+}
+
+/**
+ *	probe_irq_mask - scan a bitmap of interrupt lines
+ *	@val:	mask of interrupts to consider
+ *
+ *	Scan the ISA bus interrupt lines and return a bitmap of
+ *	active interrupts. The interrupt probe logic state is then
+ *	returned to its previous value. This function can handle only=20
+ *	legacy ISA interrupts
+ *
+ *	Note: we need to scan all the irq's even though we will
+ *	only return ISA irq numbers - just so that we reset them
+ *	all to a known state.
+ */
+unsigned int probe_irq_mask(unsigned long val)
+{
+	int i;
+	unsigned int mask;
+
+	mask =3D 0;
+	for (i =3D 0; i < NR_IRQS; i++) {
+		irq_desc_t *desc =3D irq_desc(i);
+		unsigned int status;
+
+		spin_lock_irq(&desc->lock);
+		status =3D desc->status;
+
+		if (status & IRQ_AUTODETECT) {
+			if (i < 16 && !(status & IRQ_WAITING))
+				mask |=3D 1 << i;
+
+			desc->status =3D status & ~IRQ_AUTODETECT;
+			shutdown_irq(i);
+		}
+		spin_unlock_irq(&desc->lock);
+	}
+	up(&probe_sem);
+
+	return mask & val;
+}
+
+/**
+ *	probe_irq_off	- end an interrupt autodetect
+ *	@val: mask of potential interrupts (unused)
+ *
+ *	Scans the unused interrupt lines and returns the line which
+ *	appears to have triggered the interrupt. If no interrupt was
+ *	found then zero is returned. If more than one interrupt is
+ *	found then minus the first candidate is returned to indicate
+ *	their is doubt. This function can handle any interrupt source.
+ *
+ *	The interrupt probe logic state is returned to its previous
+ *	value.
+ *
+ *	BUGS: When used in a module (which arguably shouldnt happen)
+ *	nothing prevents two IRQ probe callers from overlapping. The
+ *	results of this are non-optimal.
+ */
+int probe_irq_off(unsigned long val)
+{
+	int i, irq_found, nr_irqs;
+
+	nr_irqs =3D 0;
+	irq_found =3D 0;
+	for (i =3D 0; i < NR_IRQS; i++) {
+		irq_desc_t *desc =3D irq_desc(i);
+		unsigned int status;
+
+		spin_lock_irq(&desc->lock);
+		status =3D desc->status;
+
+		if (status & IRQ_AUTODETECT) {
+			if (!(status & IRQ_WAITING)) {
+				if (!nr_irqs)
+					irq_found =3D i;
+				nr_irqs++;
+			}
+			desc->status =3D status & ~IRQ_AUTODETECT;
+			shutdown_irq(i);
+		}
+		spin_unlock_irq(&desc->lock);
+	}
+	up(&probe_sem);
+
+	if (nr_irqs > 1)
+		irq_found =3D -irq_found;
+	return irq_found;
+}
+
+#endif	/* HAVE_ARCH_IRQ_PROBE */
+
+#ifndef HAVE_ARCH_IRQ_PROC
+
+unsigned int parse_hex_value(const char __user *buffer, unsigned long coun=
t,=20
+			     unsigned long *ret)
+{
+	unsigned char hexnum[ARCH_AFFINITY_WIDTH];
+	unsigned long value, i;
+
+	if (!count)
+		return -EINVAL;
+	if (count > ARCH_AFFINITY_WIDTH)
+		count =3D ARCH_AFFINITY_WIDTH;
+	if (copy_from_user(hexnum, buffer, count))
+		return -EFAULT;
+
+	/*
+	 * Parse the first ARCH_AFFINITY_WIDTH characters as a hex
+	 * string, any non-hex char is end-of-string. '00e1', 'e1', '00E1',
+	 * 'E1' are all the same.
+	 */
+	value =3D 0;
+
+	for (i =3D 0; i < count; i++) {
+		unsigned int c =3D hexnum[i];
+
+		switch (c) {
+			case '0' ... '9': c -=3D '0'; break;
+			case 'a' ... 'f': c -=3D 'a' - 10; break;
+			case 'A' ... 'F': c -=3D 'A' - 10; break;
+		default:
+			goto out;
+		}
+		value =3D (value << 4) | c;
+	}
+out:
+	*ret =3D value;
+	return 0;
+}
+
+#define MAX_NAMELEN 10
+
+struct proc_dir_entry *root_irq_dir;
+static struct proc_dir_entry *irq_dir[NR_IRQS];
+
+#ifdef CONFIG_SMP
+static struct proc_dir_entry *smp_affinity_entry[NR_IRQS];
+
+unsigned long irq_affinity[NR_IRQS] =3D {=20
+	[0 ... NR_IRQS - 1] =3D ARCH_DEFAULT_IRQ_AFFINITY
+};
+
+static int irq_affinity_read_proc(char *page, char **start, off_t off,
+				  int count, int *eof, void *data)
+{
+	if (count < ARCH_AFFINITY_WIDTH + 1)
+		return -EINVAL;
+	return sprintf (page, "%0" __stringify(ARCH_AFFINITY_WIDTH) "lx\n",
+			irq_affinity[(long)data]);
+}
+
+static int irq_affinity_write_proc(struct file *file, const char __user *b=
uffer,
+				   unsigned long count, void *data)
+{
+	int irq =3D (long) data, full_count =3D count, err;
+	unsigned long new_value;
+
+	if (!irq_desc(irq)->handler->set_affinity)
+		return -EIO;
+
+	err =3D parse_hex_value(buffer, count, &new_value);
+
+	/*
+	 * Do not allow disabling IRQs completely - it's a too easy
+	 * way to make the system unusable accidentally :-) At least
+	 * one online CPU still has to be targeted.
+	 */
+	if (!(new_value & cpu_online_map))
+		return -EINVAL;
+
+	irq_affinity[irq] =3D new_value;
+	irq_desc(irq)->handler->set_affinity(irq, new_value);
+
+	return full_count;
+}
+#endif
+
+void register_irq_proc(unsigned int irq)
+{
+	char name[MAX_NAMELEN];
+
+	if (!root_irq_dir || (irq_desc(irq)->handler =3D=3D &no_irq_type) ||
+			irq_dir[irq])
+		return;
+
+	memset(name, 0, MAX_NAMELEN);
+	sprintf(name, "%d", irq);
+
+	/* create /proc/irq/1234 */
+	irq_dir[irq] =3D proc_mkdir(name, root_irq_dir);
+
+#ifdef CONFIG_SMP
+	if (irq_desc(irq)->handler->set_affinity) {
+		struct proc_dir_entry *entry;
+
+		/* create /proc/irq/1234/smp_affinity */
+		entry =3D create_proc_entry("smp_affinity", 0600, irq_dir[irq]);
+
+		if (entry) {
+			entry->nlink =3D 1;
+			entry->data =3D (void *)(long)irq;
+			entry->read_proc =3D irq_affinity_read_proc;
+			entry->write_proc =3D irq_affinity_write_proc;
+		}
+
+		smp_affinity_entry[irq] =3D entry;
+	}
+#endif
+}
+
+#ifdef CONFIG_SMP
+
+unsigned long prof_cpu_mask =3D ~0UL;
+
+static int prof_cpu_mask_read_proc(char *page, char **start, off_t off,
+				   int count, int *eof, void *data)
+{
+	unsigned long *mask =3D (unsigned long *) data;
+	if (count < ARCH_AFFINITY_WIDTH + 1)
+		return -EINVAL;
+	return sprintf (page, "%0" __stringify(ARCH_AFFINITY_WIDTH) "lx\n",=20
+			*mask);
+}
+
+static int prof_cpu_mask_write_proc(struct file *file, const char __user *=
buffer,
+				    unsigned long count, void *data)
+{
+	unsigned long *mask =3D (unsigned long *) data, full_count =3D count, err;
+	unsigned long new_value;
+
+	err =3D parse_hex_value(buffer, count, &new_value);
+	if (err)
+		return err;
+
+	*mask =3D new_value;
+	return full_count;
+}
+#endif
+
+void init_irq_proc(void)
+{
+	int i;
+
+	/* create /proc/irq */
+	root_irq_dir =3D proc_mkdir("irq", 0);
+
+#ifdef CONFIG_SMP
+	{
+		struct proc_dir_entry *entry;
+
+		/* create /proc/irq/prof_cpu_mask */
+		entry =3D create_proc_entry("prof_cpu_mask", 0600, root_irq_dir);
+		if (!entry)
+			return;
+
+		entry->nlink =3D 1;
+		entry->data =3D (void *)&prof_cpu_mask;
+		entry->read_proc =3D prof_cpu_mask_read_proc;
+		entry->write_proc =3D prof_cpu_mask_write_proc;
+	}
+#endif
+
+	/*
+	 * Create entries for all existing IRQs.
+	 */
+	if (arch_can_create_irq_proc())
+		for (i =3D 0; irq_valid(i); i++)
+			if (irq_desc(i)->handler !=3D &no_irq_type)
+				register_irq_proc(i);
+}
+
+#endif	/* HAVE_ARCH_IRQ_PROC */
diff --minimal -urN -X /usr/share/dontdiff linux-2.5.72.vanilla/kernel/Make=
file linux-2.5.72/kernel/Makefile
--- linux-2.5.72.vanilla/kernel/Makefile	2003-06-17 20:00:48.000000000 +0400
+++ linux-2.5.72/kernel/Makefile	2003-06-17 22:26:07.000000000 +0400
@@ -19,6 +19,7 @@
 obj-$(CONFIG_BSD_PROCESS_ACCT) +=3D acct.o
 obj-$(CONFIG_SOFTWARE_SUSPEND) +=3D suspend.o
 obj-$(CONFIG_COMPAT) +=3D compat.o
+obj-$(CONFIG_GENERIC_IRQ) +=3D irq.o
=20
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-poi=
nter is

--O3WNCzIuUImKerqE--

--NDuspjMMC1Ui5ypn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE++tLWby9O0+A2ZecRAuLfAJ0QsGLWvZRwVtgmFVLcvcamtYuUuQCeLa3r
pqp8/6znXzT+2gqyCsVjrPc=
=+fEX
-----END PGP SIGNATURE-----

--NDuspjMMC1Ui5ypn--
