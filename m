Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266189AbUJTBz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266189AbUJTBz4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 21:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270223AbUJTAtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 20:49:13 -0400
Received: from admingilde.org ([213.95.21.5]:16528 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S267421AbUJTALx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 20:11:53 -0400
Date: Wed, 20 Oct 2004 02:11:24 +0200
From: Martin Waitz <tali@admingilde.org>
To: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@karaya.com>,
       linux-kernel@vger.kernel.org
Subject: generic hardirq handling for uml
Message-ID: <20041020001124.GA29215@admingilde.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Jeff Dike <jdike@karaya.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.6+20040907i
X-Hashcash: 0:041020:jdike@karaya.com:fce157b7c9bd9921
X-Hashcash: 0:041020:akpm@osdl.org:19d760b5f32f5d42
X-Hashcash: 0:041020:linux-kernel@vger.kernel.org:caa0e59277b06cea
X-Spam-Score: -10.9 (----------)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

I just ported arch/um to generic hardirq handling.
It works for me on a 2.6.9-rc4-mm1 kernel.

Without this patch, ARCH=3Dum does not build as it tries
to use arch/hardirq.h which is already ported to generic
hardirq on i386.

Signed-off-by: Martin Waitz <tali@admignilde.org>

Index: linux-2.6/arch/um/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/arch/um/Kconfig	2004-10-17 18:36:05.000000000 +0200
+++ linux-2.6/arch/um/Kconfig	2004-10-17 18:36:19.000000000 +0200
@@ -7,6 +7,13 @@
 	bool
 	default y
=20
+#
+# Use the generic interrupt handling code in kernel/irq/:
+#
+config GENERIC_HARDIRQS
+	bool
+	default y
+
 mainmenu "Linux/Usermode Kernel Configuration"
=20
 config ISA
Index: linux-2.6/arch/um/kernel/irq.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/arch/um/kernel/irq.c	2004-10-17 18:35:12.000000000 +0200
+++ linux-2.6/arch/um/kernel/irq.c	2004-10-20 00:36:08.000000000 +0200
@@ -5,89 +5,64 @@
  *	Copyright (C) 1992, 1998 Linus Torvalds, Ingo Molnar
  */
=20
-#include "linux/config.h"
 #include "linux/kernel.h"
 #include "linux/module.h"
 #include "linux/smp.h"
 #include "linux/irq.h"
 #include "linux/kernel_stat.h"
 #include "linux/interrupt.h"
-#include "linux/random.h"
-#include "linux/slab.h"
 #include "linux/file.h"
-#include "linux/proc_fs.h"
 #include "linux/init.h"
 #include "linux/seq_file.h"
 #include "linux/profile.h"
 #include "linux/hardirq.h"
-#include "asm/irq.h"
-#include "asm/hw_irq.h"
-#include "asm/atomic.h"
-#include "asm/signal.h"
-#include "asm/system.h"
-#include "asm/errno.h"
-#include "asm/uaccess.h"
 #include "user_util.h"
 #include "kern_util.h"
 #include "irq_user.h"
 #include "irq_kern.h"
=20
-static void register_irq_proc (unsigned int irq);
=20
-irq_desc_t irq_desc[NR_IRQS] __cacheline_aligned =3D {
-	[0 ... NR_IRQS-1] =3D {
-		.handler =3D &no_irq_type,
-		.lock =3D SPIN_LOCK_UNLOCKED
-	}
-};
+void ack_bad_irq(unsigned int irq)
+{
+	printk("unexpected IQ trap at vector %02x\n", irq);
+}
=20
 /*
- * Generic no controller code
+ * do_IRQ handles all normal device IRQ's (the special
+ * SMP cross-CPU interrupts have their own specific
+ * handlers).
  */
+unsigned int do_IRQ(int irq, union uml_pt_regs *regs)
+{
+	irq_enter();
+
+	__do_IRQ(irq, (struct pt_regs *) regs);
+
+	irq_exit();
+
+	return 1;
+}
+
=20
-static void enable_none(unsigned int irq) { }
-static unsigned int startup_none(unsigned int irq) { return 0; }
-static void disable_none(unsigned int irq) { }
-static void ack_none(unsigned int irq)
+int um_request_irq(unsigned int irq, int fd, int type,
+		   irqreturn_t (*handler)(int, void *, struct pt_regs *),
+		   unsigned long irqflags, const char * devname,
+		   void *dev_id)
 {
-/*
- * 'what should we do if we get a hw irq event on an illegal vector'.
- * each architecture has to answer this themselves, it doesn't deserve
- * a generic callback i think.
- */
-#ifdef CONFIG_X86
-	printk(KERN_ERR "unexpected IRQ trap at vector %02x\n", irq);
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
+	int err;
+
+	err =3D request_irq(irq, handler, irqflags, devname, dev_id);
+	if(err)
+		return(err);
+
+	if(fd !=3D -1)
+		err =3D activate_fd(irq, fd, type, dev_id);
+	return(err);
 }
+EXPORT_SYMBOL(um_request_irq);
+EXPORT_SYMBOL(reactivate_fd);
=20
-/* startup is the same as "enable", shutdown is same as "disable" */
-#define shutdown_none	disable_none
-#define end_none	enable_none
-
-struct hw_interrupt_type no_irq_type =3D {
-	"none",
-	startup_none,
-	shutdown_none,
-	enable_none,
-	disable_none,
-	ack_none,
-	end_none
-};
=20
-/*
- * Generic, controller-independent functions:
- */
=20
 int show_interrupts(struct seq_file *p, void *v)
 {
@@ -136,530 +111,6 @@
 	return 0;
 }
=20
-/*
- * This should really return information about whether
- * we should do bottom half handling etc. Right now we
- * end up _always_ checking the bottom half, which is a
- * waste of time and is not what some drivers would
- * prefer.
- */
-int handle_IRQ_event(unsigned int irq, struct pt_regs * regs,=20
-		     struct irqaction * action)
-{
-	int status =3D 1;	/* Force the "do bottom halves" bit */
-	int ret, retval =3D 0;
-
-	if (!(action->flags & SA_INTERRUPT))
-		local_irq_enable();
-
-	do {
-		ret =3D action->handler(irq, action->dev_id, regs);
-		if (ret =3D=3D IRQ_HANDLED)
-			status |=3D action->flags;
-		retval |=3D ret;
-		action =3D action->next;
-	} while (action);
-	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
-
-	local_irq_disable();
-
-	return retval;
-}
-
-/*
- * Generic enable/disable code: this just calls
- * down into the PIC-specific version for the actual
- * hardware disable after having gotten the irq
- * controller lock.=20
- */
-=20
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
-=20
-inline void disable_irq_nosync(unsigned int irq)
-{
-	irq_desc_t *desc =3D irq_desc + irq;
-	unsigned long flags;
-
-	spin_lock_irqsave(&desc->lock, flags);
-	if (!desc->depth++) {
-		desc->status |=3D IRQ_DISABLED;
-		desc->handler->disable(irq);
-	}
-	spin_unlock_irqrestore(&desc->lock, flags);
-}
-
-#ifdef CONFIG_SMP
-inline void synchronize_irq(unsigned int irq)
-{
-	/* is there anything to synchronize with? */
-	if (!irq_desc[irq].action)
-		return;
-=20
-	while (irq_desc[irq].status & IRQ_INPROGRESS)
-		cpu_relax();
-}
-#endif
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
-=20
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
-=20
-void enable_irq(unsigned int irq)
-{
-	irq_desc_t *desc =3D irq_desc + irq;
-	unsigned long flags;
-
-	spin_lock_irqsave(&desc->lock, flags);
-	switch (desc->depth) {
-	case 1: {
-		unsigned int status =3D desc->status & ~IRQ_DISABLED;
-		desc->status =3D status;
-		if ((status & (IRQ_PENDING | IRQ_REPLAY)) =3D=3D IRQ_PENDING) {
-			desc->status =3D status | IRQ_REPLAY;
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
-/*
- * do_IRQ handles all normal device IRQ's (the special
- * SMP cross-CPU interrupts have their own specific
- * handlers).
- */
-unsigned int do_IRQ(int irq, union uml_pt_regs *regs)
-{=09
-	/*=20
-	 * 0 return value means that this irq is already being
-	 * handled by some other CPU. (or is disabled)
-	 */
-	irq_desc_t *desc =3D irq_desc + irq;
-	struct irqaction * action;
-	unsigned int status;
-
-	irq_enter();
-	kstat_this_cpu.irqs[irq]++;
-	spin_lock(&desc->lock);
-	desc->handler->ack(irq);
-	/*
-	   REPLAY is when Linux resends an IRQ that was dropped earlier
-	   WAITING is used by probe to mark irqs that are being tested
-	   */
-	status =3D desc->status & ~(IRQ_REPLAY | IRQ_WAITING);
-	status |=3D IRQ_PENDING; /* we _want_ to handle it */
-
-	/*
-	 * If the IRQ is disabled for whatever reason, we cannot
-	 * use the action we have.
-	 */
-	action =3D NULL;
-	if (!(status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
-		action =3D desc->action;
-		status &=3D ~IRQ_PENDING; /* we commit to handling */
-		status |=3D IRQ_INPROGRESS; /* we are handling it */
-	}
-	desc->status =3D status;
-
-	/*
-	 * If there is no IRQ handler or it was disabled, exit early.
-	   Since we set PENDING, if another processor is handling
-	   a different instance of this same irq, the other processor
-	   will take care of it.
-	 */
-	if (!action)
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
-		handle_IRQ_event(irq, (struct pt_regs *) regs, action);
-		spin_lock(&desc->lock);
-	=09
-		if (!(desc->status & IRQ_PENDING))
-			break;
-		desc->status &=3D ~IRQ_PENDING;
-	}
-	desc->status &=3D ~IRQ_INPROGRESS;
-out:
-	/*
-	 * The ->end() handler has to deal with interrupts which got
-	 * disabled while the handler was running.
-	 */
-	desc->handler->end(irq);
-	spin_unlock(&desc->lock);
-
-	irq_exit();
-
-	return 1;
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
- *	your handler function must clear any interrupt the board=20
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
-=20
-int request_irq(unsigned int irq,
-		irqreturn_t (*handler)(int, void *, struct pt_regs *),
-		unsigned long irqflags,=20
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
-			printk(KERN_ERR "Bad boy: %s (at 0x%x) called us "
-			       "without a dev_id!\n", devname, (&irq)[-1]);
-	}
-#endif
-
-	if (irq >=3D NR_IRQS)
-		return -EINVAL;
-	if (!handler)
-		return -EINVAL;
-
-	action =3D (struct irqaction *)
-			kmalloc(sizeof(struct irqaction), GFP_KERNEL);
-	if (!action)
-		return -ENOMEM;
-
-	action->handler =3D handler;
-	action->flags =3D irqflags;
-	cpus_clear(action->mask);
-	action->name =3D devname;
-	action->next =3D NULL;
-	action->dev_id =3D dev_id;
-
-	retval =3D setup_irq(irq, action);
-	if (retval)
-		kfree(action);
-	return retval;
-}
-
-EXPORT_SYMBOL(request_irq);
-
-int um_request_irq(unsigned int irq, int fd, int type,
-		   irqreturn_t (*handler)(int, void *, struct pt_regs *),
-		   unsigned long irqflags, const char * devname,
-		   void *dev_id)
-{
-	int err;
-
-	err =3D request_irq(irq, handler, irqflags, devname, dev_id);
-	if(err)
-		return(err);
-
-	if(fd !=3D -1)
-		err =3D activate_fd(irq, fd, type, dev_id);
-	return(err);
-}
-EXPORT_SYMBOL(um_request_irq);
-EXPORT_SYMBOL(reactivate_fd);
-
-/* this was setup_x86_irq but it seems pretty generic */
-int setup_irq(unsigned int irq, struct irqaction * new)
-{
-	int shared =3D 0;
-	unsigned long flags;
-	struct irqaction *old, **p;
-	irq_desc_t *desc =3D irq_desc + irq;
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
-	p =3D &desc->action;
-	old =3D *p;
-	if (old !=3D NULL) {
-		/* Can't share interrupts unless both agree to */
-		if (!(old->flags & new->flags & SA_SHIRQ)) {
-			spin_unlock_irqrestore(&desc->lock,flags);
-			return -EBUSY;
-		}
-
-		/* add new interrupt at end of irq queue */
-		do {
-			p =3D &old->next;
-			old =3D *p;
-		} while (old);
-		shared =3D 1;
-	}
-
-	*p =3D new;
-
-	if (!shared) {
-		desc->depth =3D 0;
-		desc->status &=3D ~IRQ_DISABLED;
-		desc->handler->startup(irq);
-	}
-	spin_unlock_irqrestore(&desc->lock,flags);
-
-	register_irq_proc(irq);
-	return 0;
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
- *	This function may be called from interrupt context.=20
- *
- *	Bugs: Attempting to free an irq in a handler for the same irq hangs
- *	      the machine.
- */
-=20
-void free_irq(unsigned int irq, void *dev_id)
-{
-	irq_desc_t *desc;
-	struct irqaction **p;
-	unsigned long flags;
-
-	if (irq >=3D NR_IRQS)
-		return;
-
-	desc =3D irq_desc + irq;
-	spin_lock_irqsave(&desc->lock,flags);
-	p =3D &desc->action;
-	for (;;) {
-		struct irqaction * action =3D *p;
-		if (action) {
-			struct irqaction **pp =3D p;
-			p =3D &action->next;
-			if (action->dev_id !=3D dev_id)
-				continue;
-
-			/* Found it - now remove it from the list of entries */
-			*pp =3D action->next;
-			if (!desc->action) {
-				desc->status |=3D IRQ_DISABLED;
-				desc->handler->shutdown(irq);
-			}
-			free_irq_by_irq_and_dev(irq, dev_id);
-			spin_unlock_irqrestore(&desc->lock,flags);
-
-			/* Wait to make sure it's not being used on another CPU */
-			synchronize_irq(irq);
-			kfree(action);
-			return;
-		}
-		printk(KERN_ERR "Trying to free free IRQ%d\n",irq);
-		spin_unlock_irqrestore(&desc->lock,flags);
-		return;
-	}
-}
-
-EXPORT_SYMBOL(free_irq);
-
-/* These are initialized by sysctl_init, which is called from init/main.c =
*/
-static struct proc_dir_entry * root_irq_dir;
-static struct proc_dir_entry * irq_dir [NR_IRQS];
-static struct proc_dir_entry * smp_affinity_entry [NR_IRQS];
-
-/* These are read and written as longs, so a read won't see a partial write
- * even during a race.
- */
-static cpumask_t irq_affinity [NR_IRQS] =3D { [0 ... NR_IRQS-1] =3D CPU_MA=
SK_ALL };
-
-static int irq_affinity_read_proc (char *page, char **start, off_t off,
-			int count, int *eof, void *data)
-{
-	int len =3D cpumask_scnprintf(page, count, irq_affinity[(long)data]);
-	if (count - len < 2)
-		return -EINVAL;
-	len +=3D sprintf(page + len, "\n");
-	return len;
-}
-
-static int irq_affinity_write_proc (struct file *file, const char *buffer,
-					unsigned long count, void *data)
-{
-	int irq =3D (long) data, full_count =3D count, err;
-	cpumask_t new_value;
-
-	if (!irq_desc[irq].handler->set_affinity)
-		return -EIO;
-
-	err =3D cpumask_parse(buffer, count, new_value);
-	if(err)
-		return(err);
-
-#ifdef CONFIG_SMP
-	/*
-	 * Do not allow disabling IRQs completely - it's a too easy
-	 * way to make the system unusable accidentally :-) At least
-	 * one online CPU still has to be targeted.
-	 */
-	{ cpumask_t tmp;
-	  cpus_and(tmp, new_value, cpu_online_map);
-	  if (cpus_empty(tmp))
-		  return -EINVAL;
-	}
-#endif
-
-	irq_affinity[irq] =3D new_value;
-	irq_desc[irq].handler->set_affinity(irq, new_value);
-
-	return full_count;
-}
-
-#define MAX_NAMELEN 10
-
-static void register_irq_proc (unsigned int irq)
-{
-	struct proc_dir_entry *entry;
-	char name [MAX_NAMELEN];
-
-	if (!root_irq_dir || (irq_desc[irq].handler =3D=3D &no_irq_type) ||
-	    irq_dir[irq])
-		return;
-
-	memset(name, 0, MAX_NAMELEN);
-	sprintf(name, "%d", irq);
-
-	/* create /proc/irq/1234 */
-	irq_dir[irq] =3D proc_mkdir(name, root_irq_dir);
-
-	/* create /proc/irq/1234/smp_affinity */
-	entry =3D create_proc_entry("smp_affinity", 0600, irq_dir[irq]);
-
-	entry->nlink =3D 1;
-	entry->data =3D (void *)(long)irq;
-	entry->read_proc =3D irq_affinity_read_proc;
-	entry->write_proc =3D irq_affinity_write_proc;
-
-	smp_affinity_entry[irq] =3D entry;
-}
-
-void __init init_irq_proc (void)
-{
-	int i;
-
-	/* create /proc/irq */
-	root_irq_dir =3D proc_mkdir("irq", 0);
-
-	/* create /proc/irq/prof_cpu_mask */
-	create_prof_cpu_mask(root_irq_dir);
-
-	/*
-	 * Create entries for all existing IRQs.
-	 */
-	for (i =3D 0; i < NR_IRQS; i++)
-		register_irq_proc(i);
-}
-
 static spinlock_t irq_spinlock =3D SPIN_LOCK_UNLOCKED;
=20
 unsigned long irq_lock(void)
@@ -675,20 +126,6 @@
 	spin_unlock_irqrestore(&irq_spinlock, flags);
 }
=20
-unsigned long probe_irq_on(void)
-{
-	return(0);
-}
-
-EXPORT_SYMBOL(probe_irq_on);
-
-int probe_irq_off(unsigned long val)
-{
-	return(0);
-}
-
-EXPORT_SYMBOL(probe_irq_off);
-
 static unsigned int startup_SIGIO_irq(unsigned int irq)
 {
 	return(0);

--=20
Martin Waitz

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBda0rj/Eaxd/oD7IRAlYJAJ9Sup5otBveC6owvKeOwlNY8jHY3QCghQnP
eoQAwUdlZlmXNPe7x/2NdXM=
=k9uP
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--

