Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266849AbTADLsW>; Sat, 4 Jan 2003 06:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266852AbTADLsW>; Sat, 4 Jan 2003 06:48:22 -0500
Received: from samael.donpac.ru ([195.161.172.239]:11271 "EHLO
	samael.donpac.ru") by vger.kernel.org with ESMTP id <S266849AbTADLsH>;
	Sat, 4 Jan 2003 06:48:07 -0500
From: "Andrey Panin" <pazke@orbita1.ru>
Date: Sat, 4 Jan 2003 14:52:12 +0300
To: linux-kernel@vger.kernel.org
Subject: [RFC] irq handling code consolidation, second try (alpha part)
Message-ID: <20030104115212.GE10477@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DNUSDXU7R7AVVM8C"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Uname: Linux 2.4.20aa1 i686 unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DNUSDXU7R7AVVM8C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi all,=20

attached patch is a second try of IRQ handling code consolidation.
This is a alpha specific patch (compiled successfuly).

Best regards.

--=20
Andrey Panin		| Embedded systems software developer
pazke@orbita1.ru	| PGP key: wwwkeys.pgp.net

--DNUSDXU7R7AVVM8C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-irq-alpha-2.5.53"
Content-Transfer-Encoding: quoted-printable

diff --minimal -urN -X /usr/share/dontdiff linux-2.5.53.vanilla/arch/alpha/=
Kconfig linux-2.5.53/arch/alpha/Kconfig
--- linux-2.5.53.vanilla/arch/alpha/Kconfig	Fri Dec 27 19:44:58 2002
+++ linux-2.5.53/arch/alpha/Kconfig	Tue Dec 31 21:47:16 2002
@@ -20,6 +20,10 @@
 	bool
 	default y
=20
+config GENERIC_IRQ
+	bool
+	default y
+
 config UID16
 	bool
=20
diff --minimal -urN -X /usr/share/dontdiff linux-2.5.53.vanilla/arch/alpha/=
kernel/irq.c linux-2.5.53/arch/alpha/kernel/irq.c
--- linux-2.5.53.vanilla/arch/alpha/kernel/irq.c	Fri Dec 27 19:44:58 2002
+++ linux-2.5.53/arch/alpha/kernel/irq.c	Fri Jan  3 21:15:03 2003
@@ -2,12 +2,6 @@
  *	linux/arch/alpha/kernel/irq.c
  *
  *	Copyright (C) 1995 Linus Torvalds
- *
- * This file contains the code used by various IRQ handling routines:
- * asking for different IRQ's should be done through these routines
- * instead of just grabbing them. Thus setups with different IRQ numbers
- * shouldn't result in any weird surprises, and installing new handlers
- * should be easier.
  */
=20
 #include <linux/config.h>
@@ -30,186 +24,9 @@
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
=20
-/*
- * Controller mappings for all interrupt sources:
- */
-irq_desc_t irq_desc[NR_IRQS] __cacheline_aligned =3D {
-	[0 ... NR_IRQS-1] =3D { 0, &no_irq_type, NULL, 0, SPIN_LOCK_UNLOCKED}
-};
=20
 static void register_irq_proc(unsigned int irq);
=20
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
-struct hw_interrupt_type no_irq_type =3D {
-	.typename	=3D "none",
-	.startup	=3D no_irq_startup,
-	.shutdown	=3D no_irq_enable_disable,
-	.enable		=3D no_irq_enable_disable,
-	.disable	=3D no_irq_enable_disable,
-	.ack		=3D no_irq_ack,
-	.end		=3D no_irq_enable_disable,
-};
-
-int
-handle_IRQ_event(unsigned int irq, struct pt_regs *regs,
-		 struct irqaction *action)
-{
-	int status =3D 1;	/* Force the "do bottom halves" bit */
-
-	do {
-		if (!(action->flags & SA_INTERRUPT))
-			local_irq_enable();
-		else
-			local_irq_disable();
-
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
-void inline
-disable_irq_nosync(unsigned int irq)
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
-int
-setup_irq(unsigned int irq, struct irqaction * new)
-{
-	int shared =3D 0;
-	struct irqaction *old, **p;
-	unsigned long flags;
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
-		desc->status &=3D ~IRQ_DISABLED;
-		desc->handler->startup(irq);
-	}
-	spin_unlock_irqrestore(&desc->lock,flags);
-
-	return 0;
-}
-
 static struct proc_dir_entry * root_irq_dir;
 static struct proc_dir_entry * irq_dir[NR_IRQS];
=20
@@ -218,8 +35,7 @@
 static char irq_user_affinity[NR_IRQS];
 static unsigned long irq_affinity[NR_IRQS] =3D { [0 ... NR_IRQS-1] =3D ~0U=
L };
=20
-static void
-select_smp_affinity(int irq)
+void select_smp_affinity(int irq)
 {
 	static int last_cpu;
 	int cpu =3D last_cpu + 1;
@@ -246,43 +62,8 @@
 	return sprintf (page, "%016lx\n", irq_affinity[(long)data]);
 }
=20
-static unsigned int
-parse_hex_value (const char *buffer,
-		 unsigned long count, unsigned long *ret)
-{
-	unsigned char hexnum [HEX_DIGITS];
-	unsigned long value;
-	unsigned long i;
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
+extern unsigned int parse_hex_value(const char *buffer, unsigned long coun=
t,
+				    unsigned long *ret);
=20
 static int
 irq_affinity_write_proc(struct file *file, const char *buffer,
@@ -408,100 +189,6 @@
 }
=20
 int
-request_irq(unsigned int irq, void (*handler)(int, void *, struct pt_regs =
*),
-	    unsigned long irqflags, const char * devname, void *dev_id)
-{
-	int retval;
-	struct irqaction * action;
-
-	if (irq >=3D ACTUAL_NR_IRQS)
-		return -EINVAL;
-	if (!handler)
-		return -EINVAL;
-
-#if 1
-	/*
-	 * Sanity-check: shared interrupts should REALLY pass in
-	 * a real dev-ID, otherwise we'll have trouble later trying
-	 * to figure out which interrupt is which (messes up the
-	 * interrupt freeing logic etc).
-	 */
-	if ((irqflags & SA_SHIRQ) && !dev_id) {
-		printk(KERN_ERR
-		       "Bad boy: %s (at %p) called us without a dev_id!\n",
-		       devname, __builtin_return_address(0));
-	}
-#endif
-
-	action =3D (struct irqaction *)
-			kmalloc(sizeof(struct irqaction), GFP_KERNEL);
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
-#ifdef CONFIG_SMP
-	select_smp_affinity(irq);
-#endif
-
-	retval =3D setup_irq(irq, action);
-	if (retval)
-		kfree(action);
-	return retval;
-}
-
-void
-free_irq(unsigned int irq, void *dev_id)
-{
-	irq_desc_t *desc;
-	struct irqaction **p;
-	unsigned long flags;
-
-	if (irq >=3D ACTUAL_NR_IRQS) {
-		printk(KERN_CRIT "Trying to free IRQ%d\n", irq);
-		return;
-	}
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
-			/* Found - now remove it from the list of entries.  */
-			*pp =3D action->next;
-			if (!desc->action) {
-				desc->status |=3D IRQ_DISABLED;
-				desc->handler->shutdown(irq);
-			}
-			spin_unlock_irqrestore(&desc->lock,flags);
-
-#ifdef CONFIG_SMP
-			/* Wait to make sure it's not being used on
-			   another CPU.  */
-			while (desc->status & IRQ_INPROGRESS)
-				barrier();
-#endif
-			kfree(action);
-			return;
-		}
-		printk(KERN_ERR "Trying to free free IRQ%d\n",irq);
-		spin_unlock_irqrestore(&desc->lock,flags);
-		return;
-	}
-}
-
-int
 show_interrupts(struct seq_file *p, void *v)
 {
 #ifdef CONFIG_SMP
@@ -549,7 +236,7 @@
 			seq_printf(p, "%10lu ", cpu_data[i].ipi_count);
 	seq_putc(p, '\n');
 #endif
-	seq_printf(p, "ERR: %10lu\n", irq_err_count);
+	seq_printf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
 	return 0;
 }
=20
@@ -582,7 +269,7 @@
 	static unsigned int illegal_count=3D0;
 =09
 	if ((unsigned) irq > ACTUAL_NR_IRQS && illegal_count < MAX_ILLEGAL_IRQS )=
 {
-		irq_err_count++;
+		atomic_inc(&irq_err_count);
 		illegal_count++;
 		printk(KERN_CRIT "device_interrupt: illegal interrupt %d\n",
 		       irq);
@@ -651,164 +338,3 @@
=20
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
-	for (i =3D NR_IRQS-1; i >=3D 0; i--) {
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
-	/* enable any unassigned irqs (we must startup again here because
-	   if a longstanding irq happened in the previous stage, it may have
-	   masked itself) first, enable any unassigned irqs. */
-	for (i =3D NR_IRQS-1; i >=3D 0; i--) {
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
-	for (i=3D0; i<NR_IRQS; i++) {
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
-unsigned int
-probe_irq_mask(unsigned long val)
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
-			/* We only react to ISA interrupts */
-			if (!(status & IRQ_WAITING)) {
-				if (i < 16)
-					mask |=3D 1 << i;
-			}
-
-			desc->status =3D status & ~IRQ_AUTODETECT;
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
-	nr_irqs =3D 0;
-	irq_found =3D 0;
-	for (i=3D0; i<NR_IRQS; i++) {
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
-
-	if (nr_irqs > 1)
-		irq_found =3D -irq_found;
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
diff --minimal -urN -X /usr/share/dontdiff linux-2.5.53.vanilla/arch/alpha/=
kernel/irq_alpha.c linux-2.5.53/arch/alpha/kernel/irq_alpha.c
--- linux-2.5.53.vanilla/arch/alpha/kernel/irq_alpha.c	Fri Dec 27 19:44:58 =
2002
+++ linux-2.5.53/arch/alpha/kernel/irq_alpha.c	Wed Jan  1 13:02:16 2003
@@ -26,7 +26,7 @@
 static void
 dummy_perf(unsigned long vector, struct pt_regs *regs)
 {
-	irq_err_count++;
+	atomic_inc(&irq_err_count);
 	printk(KERN_CRIT "Performance counter interrupt!\n");
 }
=20
@@ -46,7 +46,7 @@
 		handle_ipi(regs);
 		return;
 #else
-		irq_err_count++;
+		atomic_inc(&irq_err_count);
 		printk(KERN_CRIT "Interprocessor interrupt? "
 		       "You must be kidding!\n");
 #endif
diff --minimal -urN -X /usr/share/dontdiff linux-2.5.53.vanilla/arch/alpha/=
kernel/smp.c linux-2.5.53/arch/alpha/kernel/smp.c
--- linux-2.5.53.vanilla/arch/alpha/kernel/smp.c	Fri Dec 27 19:44:58 2002
+++ linux-2.5.53/arch/alpha/kernel/smp.c	Wed Jan  1 13:23:10 2003
@@ -432,7 +432,7 @@
 	/* Don't care about the contents of regs since we'll never
 	   reschedule the forked task. */
 	struct pt_regs regs;
-	return do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL);
+	return do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL, NULL);
 }
=20
 /*
diff --minimal -urN -X /usr/share/dontdiff linux-2.5.53.vanilla/include/asm=
-alpha/hw_irq.h linux-2.5.53/include/asm-alpha/hw_irq.h
--- linux-2.5.53.vanilla/include/asm-alpha/hw_irq.h	Fri Dec 27 19:47:15 2002
+++ linux-2.5.53/include/asm-alpha/hw_irq.h	Fri Jan  3 23:39:55 2003
@@ -2,15 +2,40 @@
 #define _ALPHA_HW_IRQ_H
=20
 #include <linux/config.h>
+#include <asm/machvec.h>
=20
 static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int=
 i) {}
=20
-extern volatile unsigned long irq_err_count;
+extern atomic_t irq_err_count;
+
+extern void select_smp_affinity(int irq);
+
+extern irq_desc_t irq_desc[NR_IRQS];
=20
 #ifdef CONFIG_ALPHA_GENERIC
 #define ACTUAL_NR_IRQS	alpha_mv.nr_irqs
 #else
 #define ACTUAL_NR_IRQS	NR_IRQS
 #endif
+
+#define arch_ack_bad_irq(irq) do { } while (0)
+
+/* Return a pointer to the irq descriptor for IRQ.  */
+#define irq_desc(irq) (irq_desc + (irq))
+
+/* Check irq number */
+#define arch_check_irq(irq) ((irq) >=3D ACTUAL_NR_IRQS)
+
+/* Arch specific hook for setup_irq() */
+#ifdef CONFIG_SMP
+#define arch_setup_irq(irq, desc, irqaction) select_smp_affinity(irq)
+#else
+#define arch_setup_irq(irq, desc, irqaction) do { } while (0)
+#endif
+
+/* Used in setup_irq() */
+#define ARCH_NONSHARED_IRQ_MASK ~IRQ_DISABLED
+
+#define ARCH_PROC_SMP_AFF_WIDTH	16
=20
 #endif

--DNUSDXU7R7AVVM8C--
