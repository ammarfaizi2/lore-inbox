Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266846AbTADLqd>; Sat, 4 Jan 2003 06:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266848AbTADLqd>; Sat, 4 Jan 2003 06:46:33 -0500
Received: from samael.donpac.ru ([195.161.172.239]:10759 "EHLO
	samael.donpac.ru") by vger.kernel.org with ESMTP id <S266846AbTADLqV>;
	Sat, 4 Jan 2003 06:46:21 -0500
From: "Andrey Panin" <pazke@orbita1.ru>
Date: Sat, 4 Jan 2003 14:50:26 +0300
To: linux-kernel@vger.kernel.org
Subject: [RFC] irq handling code consolidation, second try (i386 part)
Message-ID: <20030104115026.GD10477@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AsxXAMtlQ5JHofzM"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Uname: Linux 2.4.20aa1 i686 unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AsxXAMtlQ5JHofzM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi all,=20

attached patch is a second try of IRQ handling code consolidation.
This is a i386 specific patch (tested and works).

Best regards.

--=20
Andrey Panin		| Embedded systems software developer
pazke@orbita1.ru	| PGP key: wwwkeys.pgp.net

--AsxXAMtlQ5JHofzM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-irq-i386-2.5.53"
Content-Transfer-Encoding: quoted-printable

diff --minimal -urN -X /usr/share/dontdiff linux-2.5.53.vanilla/arch/i386/K=
config linux-2.5.53/arch/i386/Kconfig
--- linux-2.5.53.vanilla/arch/i386/Kconfig	Fri Dec 27 19:44:51 2002
+++ linux-2.5.53/arch/i386/Kconfig	Mon Dec 30 15:19:59 2002
@@ -22,6 +22,10 @@
 	bool
 	default y
=20
+config GENERIC_IRQ
+	bool
+	default y
+
 config SBUS
 	bool
=20
diff --minimal -urN -X /usr/share/dontdiff linux-2.5.53.vanilla/arch/i386/k=
ernel/irq.c linux-2.5.53/arch/i386/kernel/irq.c
--- linux-2.5.53.vanilla/arch/i386/kernel/irq.c	Fri Dec 27 19:44:50 2002
+++ linux-2.5.53/arch/i386/kernel/irq.c	Fri Jan  3 21:27:28 2003
@@ -2,19 +2,6 @@
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
=20
 #include <linux/config.h>
@@ -62,65 +49,9 @@
  * interrupt controllers, without having to do assembly magic.
  */
=20
-/*
- * Controller mappings for all interrupt sources:
- */
-irq_desc_t irq_desc[NR_IRQS] __cacheline_aligned =3D
-	{ [0 ... NR_IRQS-1] =3D { 0, &no_irq_type, NULL, 0, SPIN_LOCK_UNLOCKED}};
-
 static void register_irq_proc (unsigned int irq);
=20
-/*
- * Special irq handlers.
- */
-
-void no_action(int cpl, void *dev_id, struct pt_regs *regs) { }
-
-/*
- * Generic no controller code
- */
=20
-static void enable_none(unsigned int irq) { }
-static unsigned int startup_none(unsigned int irq) { return 0; }
-static void disable_none(unsigned int irq) { }
-static void ack_none(unsigned int irq)
-{
-/*
- * 'what should we do if we get a hw irq event on an illegal vector'.
- * each architecture has to answer this themselves, it doesnt deserve
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
-struct hw_interrupt_type no_irq_type =3D {
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
 #ifdef CONFIG_X86_IO_APIC
 #ifdef APIC_MISMATCH_DEBUG
 atomic_t irq_mis_count;
@@ -183,129 +114,6 @@
 	return 0;
 }
=20
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
-int handle_IRQ_event(unsigned int irq, struct pt_regs * regs, struct irqac=
tion * action)
-{
-	int status =3D 1;	/* Force the "do bottom halves" bit */
-
-	if (!(action->flags & SA_INTERRUPT))
-		local_irq_enable();
-
-	do {
-		status |=3D action->flags;
-		action->handler(irq, action->dev_id, regs);
-		action =3D action->next;
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
- * controller lock.=20
- */
-=20
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
-=20
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
-		printk("enable_irq(%u) unbalanced from %p\n", irq,
-		       __builtin_return_address(0));
-	}
-	spin_unlock_irqrestore(&desc->lock, flags);
-}
-
 /*
  * do_IRQ handles all normal device IRQ's (the special
  * SMP cross-CPU interrupts have their own specific
@@ -410,428 +218,13 @@
 	return 1;
 }
=20
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
-int request_irq(unsigned int irq,=20
-		void (*handler)(int, void *, struct pt_regs *),
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
-			printk("Bad boy: %s (at 0x%x) called us without a dev_id!\n", devname, =
(&irq)[-1]);
-	}
-#endif
-
-	if (irq >=3D NR_IRQS)
-		return -EINVAL;
-	if (!handler)
-		return -EINVAL;
-
-	action =3D (struct irqaction *)
-			kmalloc(sizeof(struct irqaction), GFP_ATOMIC);
-	if (!action)
-		return -ENOMEM;
-
-	action->handler =3D handler;
-	action->flags =3D irqflags;
-	action->mask =3D 0;
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
- *	This function must not be called from interrupt context.=20
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
-=20
-unsigned long probe_irq_on(void)
-{
-	unsigned int i;
-	irq_desc_t *desc;
-	unsigned long val;
-	unsigned long delay;
-
-	down(&probe_sem);
-	/*=20
-	 * something may have generated an irq long ago and we want to
-	 * flush such a longstanding irq before considering it as spurious.=20
-	 */
-	for (i =3D NR_IRQS-1; i > 0; i--)  {
-		desc =3D irq_desc + i;
-
-		spin_lock_irq(&desc->lock);
-		if (!irq_desc[i].action)=20
-			irq_desc[i].handler->startup(i);
-		spin_unlock_irq(&desc->lock);
-	}
-
-	/* Wait for longstanding interrupts to trigger. */
-	for (delay =3D jiffies + HZ/50; time_after(delay, jiffies); )
-		/* about 20ms delay */ barrier();
-
-	/*
-	 * enable any unassigned irqs
-	 * (we must startup again here because if a longstanding irq
-	 * happened in the previous stage, it may have masked itself)
-	 */
-	for (i =3D NR_IRQS-1; i > 0; i--) {
-		desc =3D irq_desc + i;
-
-		spin_lock_irq(&desc->lock);
-		if (!desc->action) {
-			desc->status |=3D IRQ_AUTODETECT | IRQ_WAITING;
-			if (desc->handler->startup(i))
-				desc->status |=3D IRQ_PENDING;
-		}
-		spin_unlock_irq(&desc->lock);
-	}
-
-	/*
-	 * Wait for spurious interrupts to trigger
-	 */
-	for (delay =3D jiffies + HZ/10; time_after(delay, jiffies); )
-		/* about 100ms delay */ barrier();
-
-	/*
-	 * Now filter out any obviously spurious interrupts
-	 */
-	val =3D 0;
-	for (i =3D 0; i < NR_IRQS; i++) {
-		irq_desc_t *desc =3D irq_desc + i;
-		unsigned int status;
-
-		spin_lock_irq(&desc->lock);
-		status =3D desc->status;
-
-		if (status & IRQ_AUTODETECT) {
-			/* It triggered already - consider it spurious. */
-			if (!(status & IRQ_WAITING)) {
-				desc->status =3D status & ~IRQ_AUTODETECT;
-				desc->handler->shutdown(i);
-			} else
-				if (i < 32)
-					val |=3D 1 << i;
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
-=20
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
-	mask =3D 0;
-	for (i =3D 0; i < NR_IRQS; i++) {
-		irq_desc_t *desc =3D irq_desc + i;
-		unsigned int status;
-
-		spin_lock_irq(&desc->lock);
-		status =3D desc->status;
-
-		if (status & IRQ_AUTODETECT) {
-			if (i < 16 && !(status & IRQ_WAITING))
-				mask |=3D 1 << i;
-
-			desc->status =3D status & ~IRQ_AUTODETECT;
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
-=20
-int probe_irq_off(unsigned long val)
-{
-	int i, irq_found, nr_irqs;
-
-	nr_irqs =3D 0;
-	irq_found =3D 0;
-	for (i =3D 0; i < NR_IRQS; i++) {
-		irq_desc_t *desc =3D irq_desc + i;
-		unsigned int status;
-
-		spin_lock_irq(&desc->lock);
-		status =3D desc->status;
-
-		if (status & IRQ_AUTODETECT) {
-			if (!(status & IRQ_WAITING)) {
-				if (!nr_irqs)
-					irq_found =3D i;
-				nr_irqs++;
-			}
-			desc->status =3D status & ~IRQ_AUTODETECT;
-			desc->handler->shutdown(i);
-		}
-		spin_unlock_irq(&desc->lock);
-	}
-	up(&probe_sem);
-
-	if (nr_irqs > 1)
-		irq_found =3D -irq_found;
-	return irq_found;
-}
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
-	if ((old =3D *p) !=3D NULL) {
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
-		desc->status &=3D ~(IRQ_DISABLED | IRQ_AUTODETECT | IRQ_WAITING | IRQ_IN=
PROGRESS);
-		desc->handler->startup(irq);
-	}
-	spin_unlock_irqrestore(&desc->lock,flags);
-
-	register_irq_proc(irq);
-	return 0;
-}
-
 static struct proc_dir_entry * root_irq_dir;
 static struct proc_dir_entry * irq_dir [NR_IRQS];
=20
 #define HEX_DIGITS 8
=20
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
-		count =3D HEX_DIGITS;
-	if (copy_from_user(hexnum, buffer, count))
-		return -EFAULT;
-
-	/*
-	 * Parse the first 8 characters as a hex string, any non-hex char
-	 * is end-of-string. '00e1', 'e1', '00E1', 'E1' are all the same.
-	 */
-	value =3D 0;
-
-	for (i =3D 0; i < count; i++) {
-		unsigned int c =3D hexnum[i];
-
-		switch (c) {
-			case '0' ... '9': c -=3D '0'; break;
-			case 'a' ... 'f': c -=3D 'a'-10; break;
-			case 'A' ... 'F': c -=3D 'A'-10; break;
-		default:
-			goto out;
-		}
-		value =3D (value << 4) | c;
-	}
-out:
-	*ret =3D value;
-	return 0;
-}
-
+extern unsigned int parse_hex_value(const char *buffer, unsigned long coun=
t,
+				    unsigned long *ret);
 #if CONFIG_SMP
=20
 static struct proc_dir_entry * smp_affinity_entry [NR_IRQS];
diff --minimal -urN -X /usr/share/dontdiff linux-2.5.53.vanilla/include/asm=
-i386/hw_irq.h linux-2.5.53/include/asm-i386/hw_irq.h
--- linux-2.5.53.vanilla/include/asm-i386/hw_irq.h	Fri Dec 27 19:47:21 2002
+++ linux-2.5.53/include/asm-i386/hw_irq.h	Sat Jan  4 00:13:02 2003
@@ -140,4 +140,33 @@
 static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int=
 i) {}
 #endif
=20
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
+#define arch_check_irq(irq) ((irq) >=3D NR_IRQS)
+
+/* Arch specific hook for setup_irq() */
+#define arch_setup_irq(irq, desc, irqaction) do { } while (0)
+
+/* Used in setup_irq() */
+#define ARCH_NONSHARED_IRQ_MASK \
+	~(IRQ_DISABLED | IRQ_AUTODETECT | IRQ_WAITING | IRQ_INPROGRESS)
+
 #endif /* _ASM_HW_IRQ_H */

--AsxXAMtlQ5JHofzM--
