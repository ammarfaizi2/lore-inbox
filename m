Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265800AbTF3JNP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 05:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265801AbTF3JNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 05:13:15 -0400
Received: from mail.donpac.ru ([217.107.128.190]:46745 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S265800AbTF3JMZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 05:12:25 -0400
Date: Mon, 30 Jun 2003 13:26:33 +0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] irq consolidation, new attempt (alpha part)
Message-ID: <20030630092633.GC4618@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="65ImJOski3p8EhYV"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Andrey Panin <pazke@donpac.ru>
X-Spam-Score: -10.2 (----------)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--65ImJOski3p8EhYV
Content-Type: multipart/mixed; boundary="WBsA/oQW3eTA3LlM"
Content-Disposition: inline


--WBsA/oQW3eTA3LlM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

alpha specific part of irq handling code consolidation patchset.
Patch is against 2.5.73. Compiles, but untested.


Best regards.

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--WBsA/oQW3eTA3LlM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-irq-alpha-2.5.73"
Content-Transfer-Encoding: quoted-printable

diff --minimal -urN -X /usr/share/dontdiff linux-2.5.73.vanilla/arch/alpha/=
Kconfig linux-2.5.73/arch/alpha/Kconfig
--- linux-2.5.73.vanilla/arch/alpha/Kconfig	2003-06-27 20:29:39.000000000 +=
0400
+++ linux-2.5.73/arch/alpha/Kconfig	2003-06-27 20:34:34.000000000 +0400
@@ -15,6 +15,10 @@
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
diff --minimal -urN -X /usr/share/dontdiff linux-2.5.73.vanilla/arch/alpha/=
kernel/irq_alpha.c linux-2.5.73/arch/alpha/kernel/irq_alpha.c
--- linux-2.5.73.vanilla/arch/alpha/kernel/irq_alpha.c	2003-06-27 20:29:40.=
000000000 +0400
+++ linux-2.5.73/arch/alpha/kernel/irq_alpha.c	2003-06-27 20:34:34.00000000=
0 +0400
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
diff --minimal -urN -X /usr/share/dontdiff linux-2.5.73.vanilla/arch/alpha/=
kernel/irq.c linux-2.5.73/arch/alpha/kernel/irq.c
--- linux-2.5.73.vanilla/arch/alpha/kernel/irq.c	2003-06-27 20:29:40.000000=
000 +0400
+++ linux-2.5.73/arch/alpha/kernel/irq.c	2003-06-29 12:25:41.000000000 +0400
@@ -2,34 +2,15 @@
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
-#include <linux/kernel.h>
-#include <linux/errno.h>
 #include <linux/kernel_stat.h>
 #include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/ptrace.h>
 #include <linux/interrupt.h>
-#include <linux/slab.h>
-#include <linux/random.h>
-#include <linux/init.h>
 #include <linux/irq.h>
-#include <linux/proc_fs.h>
 #include <linux/seq_file.h>
=20
-#include <asm/system.h>
-#include <asm/io.h>
-#include <asm/bitops.h>
-#include <asm/uaccess.h>
-
 /*
  * Controller mappings for all interrupt sources:
  */
@@ -40,478 +21,31 @@
 	}
 };
=20
-static void register_irq_proc(unsigned int irq);
-
-volatile unsigned long irq_err_count;
-
-/*
- * Special irq handlers.
- */
-
-irqreturn_t no_action(int cpl, void *dev_id, struct pt_regs *regs)
-{
-	return IRQ_NONE;
-}
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
-static struct proc_dir_entry * root_irq_dir;
-static struct proc_dir_entry * irq_dir[NR_IRQS];
-
 #ifdef CONFIG_SMP=20
-static struct proc_dir_entry * smp_affinity_entry[NR_IRQS];
 static char irq_user_affinity[NR_IRQS];
-static unsigned long irq_affinity[NR_IRQS] =3D { [0 ... NR_IRQS-1] =3D ~0U=
L };
=20
-static void
-select_smp_affinity(int irq)
+void select_smp_affinity(int irq)
 {
 	static int last_cpu;
 	int cpu =3D last_cpu + 1;
+	irq_desc_t *desc;
=20
-	if (! irq_desc[irq].handler->set_affinity || irq_user_affinity[irq])
+	if (!irq_valid(irq))
 		return;
=20
-	while (((cpu_present_mask >> cpu) & 1) =3D=3D 0)
-		cpu =3D (cpu < (NR_CPUS-1) ? cpu + 1 : 0);
-	last_cpu =3D cpu;
-
-	irq_affinity[irq] =3D 1UL << cpu;
-	irq_desc[irq].handler->set_affinity(irq, 1UL << cpu);
-}
-
-#define HEX_DIGITS 16
-
-static int
-irq_affinity_read_proc (char *page, char **start, off_t off,
-			int count, int *eof, void *data)
-{
-	if (count < HEX_DIGITS+1)
-		return -EINVAL;
-	return sprintf (page, "%016lx\n", irq_affinity[(long)data]);
-}
-
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
-
-static int
-irq_affinity_write_proc(struct file *file, const char *buffer,
-			unsigned long count, void *data)
-{
-	int irq =3D (long) data, full_count =3D count, err;
-	unsigned long new_value;
-
-	if (!irq_desc[irq].handler->set_affinity)
-		return -EIO;
-
-	err =3D parse_hex_value(buffer, count, &new_value);
-
-	/* The special value 0 means release control of the
-	   affinity to kernel.  */
-	if (new_value =3D=3D 0) {
-		irq_user_affinity[irq] =3D 0;
-		select_smp_affinity(irq);
-	}
-	/* Do not allow disabling IRQs completely - it's a too easy
-	   way to make the system unusable accidentally :-) At least
-	   one online CPU still has to be targeted.  */
-	else if (!(new_value & cpu_present_mask))
-		return -EINVAL;
-	else {
-		irq_affinity[irq] =3D new_value;
-		irq_user_affinity[irq] =3D 1;
-		irq_desc[irq].handler->set_affinity(irq, new_value);
-	}
-
-	return full_count;
-}
-
-static int
-prof_cpu_mask_read_proc(char *page, char **start, off_t off,
-			int count, int *eof, void *data)
-{
-	unsigned long *mask =3D (unsigned long *) data;
-	if (count < HEX_DIGITS+1)
-		return -EINVAL;
-	return sprintf (page, "%016lx\n", *mask);
-}
-
-static int
-prof_cpu_mask_write_proc(struct file *file, const char *buffer,
-			 unsigned long count, void *data)
-{
-	unsigned long *mask =3D (unsigned long *) data, full_count =3D count, err;
-	unsigned long new_value;
-
-	err =3D parse_hex_value(buffer, count, &new_value);
-	if (err)
-		return err;
-
-	*mask =3D new_value;
-	return full_count;
-}
-#endif /* CONFIG_SMP */
-
-#define MAX_NAMELEN 10
-
-static void
-register_irq_proc (unsigned int irq)
-{
-#ifdef CONFIG_SMP
-	struct proc_dir_entry *entry;
-#endif
-	char name [MAX_NAMELEN];
+	desc =3D irq_desc(irq);
=20
-	if (!root_irq_dir || (irq_desc[irq].handler =3D=3D &no_irq_type))
+	if (desc->handler->set_affinity || irq_user_affinity[irq])
 		return;
=20
-	memset(name, 0, MAX_NAMELEN);
-	sprintf(name, "%d", irq);
-
-	/* create /proc/irq/1234 */
-	irq_dir[irq] =3D proc_mkdir(name, root_irq_dir);
-
-#ifdef CONFIG_SMP=20
-	if (irq_desc[irq].handler->set_affinity) {
-		/* create /proc/irq/1234/smp_affinity */
-		entry =3D create_proc_entry("smp_affinity", 0600, irq_dir[irq]);
-
-		entry->nlink =3D 1;
-		entry->data =3D (void *)(long)irq;
-		entry->read_proc =3D irq_affinity_read_proc;
-		entry->write_proc =3D irq_affinity_write_proc;
-
-		smp_affinity_entry[irq] =3D entry;
-	}
-#endif
-}
-
-unsigned long prof_cpu_mask =3D ~0UL;
-
-void
-init_irq_proc (void)
-{
-#ifdef CONFIG_SMP
-	struct proc_dir_entry *entry;
-#endif
-	int i;
-
-	/* create /proc/irq */
-	root_irq_dir =3D proc_mkdir("irq", 0);
-
-#ifdef CONFIG_SMP=20
-	/* create /proc/irq/prof_cpu_mask */
-	entry =3D create_proc_entry("prof_cpu_mask", 0600, root_irq_dir);
-
-	entry->nlink =3D 1;
-	entry->data =3D (void *)&prof_cpu_mask;
-	entry->read_proc =3D prof_cpu_mask_read_proc;
-	entry->write_proc =3D prof_cpu_mask_write_proc;
-#endif
-
-	/*
-	 * Create entries for all existing IRQs. If the number of IRQs
-	 * is greater the 1/4 the total dynamic inode space for /proc,
-	 * don't pollute the inode space
-	 */
-	if (ACTUAL_NR_IRQS < (PROC_NDYNAMIC / 4)) {
-		for (i =3D 0; i < ACTUAL_NR_IRQS; i++) {
-			if (irq_desc[i].handler =3D=3D &no_irq_type)
-				continue;
-			register_irq_proc(i);
-		}
-	}
-}
-
-int
-request_irq(unsigned int irq, irqreturn_t (*handler)(int, void *, struct p=
t_regs *),
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
+	while (((cpu_present_mask >> cpu) & 1) =3D=3D 0)
+		cpu =3D (cpu < (NR_CPUS-1) ? cpu + 1 : 0);
+	last_cpu =3D cpu;
=20
-	retval =3D setup_irq(irq, action);
-	if (retval)
-		kfree(action);
-	return retval;
+	desc->irq_affinity =3D 1UL << cpu;
+	desc->handler->set_affinity(irq, 1UL << cpu);
 }
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
 #endif
-			kfree(action);
-			return;
-		}
-		printk(KERN_ERR "Trying to free free IRQ%d\n",irq);
-		spin_unlock_irqrestore(&desc->lock,flags);
-		return;
-	}
-}
=20
 int
 show_interrupts(struct seq_file *p, void *v)
@@ -559,14 +93,14 @@
 unlock:
 		spin_unlock_irqrestore(&irq_desc[i].lock, flags);
 	}
-#ifdef CONFIG_SMP
+#if CONFIG_SMP
 	seq_puts(p, "IPI: ");
 	for (i =3D 0; i < NR_CPUS; i++)
 		if (cpu_online(i))
 			seq_printf(p, "%10lu ", cpu_data[i].ipi_count);
 	seq_putc(p, '\n');
 #endif
-	seq_printf(p, "ERR: %10lu\n", irq_err_count);
+	seq_printf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
 	return 0;
 }
=20
@@ -599,7 +133,7 @@
 	static unsigned int illegal_count=3D0;
 =09
 	if ((unsigned) irq > ACTUAL_NR_IRQS && illegal_count < MAX_ILLEGAL_IRQS )=
 {
-		irq_err_count++;
+		atomic_inc(&irq_err_count);
 		illegal_count++;
 		printk(KERN_CRIT "device_interrupt: illegal interrupt %d\n",
 		       irq);
@@ -648,10 +182,13 @@
 	 * SMP environment.
 	 */
 	for (;;) {
+		extern void note_interrupt(int, irq_desc_t*, irqreturn_t);
+		irqreturn_t action_ret;
+
 		spin_unlock(&desc->lock);
-		handle_IRQ_event(irq, regs, action);
+		action_ret =3D handle_IRQ_event(irq, regs, action);
 		spin_lock(&desc->lock);
-	=09
+		note_interrupt(irq, desc, action_ret);
 		if (!(desc->status & IRQ_PENDING)
 		    || (desc->status & IRQ_LEVEL))
 			break;
@@ -668,164 +205,3 @@
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
diff --minimal -urN -X /usr/share/dontdiff linux-2.5.73.vanilla/include/asm=
-alpha/hw_irq.h linux-2.5.73/include/asm-alpha/hw_irq.h
--- linux-2.5.73.vanilla/include/asm-alpha/hw_irq.h	2003-06-27 20:32:45.000=
000000 +0400
+++ linux-2.5.73/include/asm-alpha/hw_irq.h	2003-06-29 12:23:35.000000000 +=
0400
@@ -2,10 +2,15 @@
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
@@ -13,4 +18,33 @@
 #define ACTUAL_NR_IRQS	NR_IRQS
 #endif
=20
+#define arch_ack_bad_irq(irq) do { } while (0)
+
+/* Return a pointer to the irq descriptor for IRQ.  */
+#define irq_desc(irq) (irq_desc + (irq))
+
+/* Check irq number */
+#define irq_valid(irq) ((irq) < ACTUAL_NR_IRQS)
+
+#define for_each_irq(i) for (i =3D 0; i < NR_IRQS; i++) \
+	if (!irq_valid(i)) \
+		continue; \
+	else
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
+#define ARCH_AFFINITY_WIDTH	16
+
+#define ARCH_DEFAULT_IRQ_AFFINITY	~0UL
+
+#define arch_can_create_irq_proc() (ACTUAL_NR_IRQS < (PROC_NDYNAMIC / 4))
+
 #endif

--WBsA/oQW3eTA3LlM--

--65ImJOski3p8EhYV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/AAJJby9O0+A2ZecRArClAJ4tGrfWcLkWwnr6yDWNBfzRRUQTygCfZxF0
orUluhWPqse0b9LOC0O1QMs=
=ohI6
-----END PGP SIGNATURE-----

--65ImJOski3p8EhYV--
