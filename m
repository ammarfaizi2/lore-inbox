Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265817AbTF3JSr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 05:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265818AbTF3JSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 05:18:47 -0400
Received: from mail.donpac.ru ([217.107.128.190]:30621 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S265817AbTF3JSW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 05:18:22 -0400
Date: Mon, 30 Jun 2003 13:32:37 +0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] irq consolidation, new attempt (ppc part)
Message-ID: <20030630093237.GD4618@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8/pVXlBMPtxfSuJG"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Andrey Panin <pazke@donpac.ru>
X-Spam-Score: -10.2 (----------)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8/pVXlBMPtxfSuJG
Content-Type: multipart/mixed; boundary="ahP6B03r4gLOj5uD"
Content-Disposition: inline


--ahP6B03r4gLOj5uD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

ppc specific part of irq handling code consolidation patchset.
Patch against 2.5.73. Compiles, but untested.

Please take a look.

Best regards.

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--ahP6B03r4gLOj5uD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-irq-ppc-2.5.73"
Content-Transfer-Encoding: quoted-printable

diff --minimal -urN -X /usr/share/dontdiff linux-2.5.73.vanilla/arch/ppc/Kc=
onfig linux-2.5.73/arch/ppc/Kconfig
--- linux-2.5.73.vanilla/arch/ppc/Kconfig	2003-06-27 20:29:11.000000000 +04=
00
+++ linux-2.5.73/arch/ppc/Kconfig	2003-06-27 22:41:48.000000000 +0400
@@ -6,6 +6,10 @@
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
diff --minimal -urN -X /usr/share/dontdiff linux-2.5.73.vanilla/arch/ppc/ke=
rnel/irq.c linux-2.5.73/arch/ppc/kernel/irq.c
--- linux-2.5.73.vanilla/arch/ppc/kernel/irq.c	2003-06-27 20:29:14.00000000=
0 +0400
+++ linux-2.5.73/arch/ppc/kernel/irq.c	2003-06-29 20:53:34.000000000 +0400
@@ -10,12 +10,6 @@
  *  Adapted for Power Macintosh by Paul Mackerras
  *    Copyright (C) 1996 Paul Mackerras (paulus@cs.anu.edu.au)
  *  Amiga/APUS changes by Jesper Skov (jskov@cygnus.co.uk).
- * =20
- * This file contains the code used by various IRQ handling routines:
- * asking for different IRQ's should be done through these routines
- * instead of just grabbing them. Thus setups with different IRQ numbers
- * shouldn't result in any weird surprises, and installing new handlers
- * should be easier.
  *
  * The MPC8xx has an interrupt mask in the SIU.  If a bit is set, the
  * interrupt is _enabled_.  As expected, IRQ0 is bit 0 in the 32-bit
@@ -26,43 +20,28 @@
  * to reduce code space and undefined function references.
  */
=20
-#include <linux/errno.h>
+#include <linux/config.h>
 #include <linux/threads.h>
 #include <linux/kernel_stat.h>
 #include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/ptrace.h>
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
-#include <linux/timex.h>
-#include <linux/config.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
-#include <linux/delay.h>
 #include <linux/irq.h>
-#include <linux/proc_fs.h>
-#include <linux/random.h>
 #include <linux/seq_file.h>
=20
-#include <asm/uaccess.h>
-#include <asm/bitops.h>
-#include <asm/system.h>
 #include <asm/io.h>
 #include <asm/pgtable.h>
 #include <asm/irq.h>
 #include <asm/cache.h>
 #include <asm/prom.h>
-#include <asm/ptrace.h>
=20
 #define NR_MASK_WORDS	((NR_IRQS + 31) / 32)
=20
 extern atomic_t ipi_recv;
 extern atomic_t ipi_sent;
-void enable_irq(unsigned int irq_nr);
-void disable_irq(unsigned int irq_nr);
-
-static void register_irq_proc (unsigned int irq);
=20
 #define MAXCOUNT 10000000
=20
@@ -71,272 +50,17 @@
 		.lock =3D SPIN_LOCK_UNLOCKED
 	}
 };
-=09
+
 int ppc_spurious_interrupts =3D 0;
-struct irqaction *ppc_irq_action[NR_IRQS];
 unsigned long ppc_cached_irq_mask[NR_MASK_WORDS];
 unsigned long ppc_lost_interrupts[NR_MASK_WORDS];
 atomic_t ppc_n_lost_interrupts;
=20
-/* nasty hack for shared irq's since we need to do kmalloc calls but
- * can't very early in the boot when we need to do a request irq.
- * this needs to be removed.
- * -- Cort
- */
-#define IRQ_KMALLOC_ENTRIES 8
-static int cache_bitmask =3D 0;
-static struct irqaction malloc_cache[IRQ_KMALLOC_ENTRIES];
-extern int mem_init_done;
-
 #if defined(CONFIG_TAU_INT)
 extern int tau_interrupts(unsigned long cpu);
 extern int tau_initialized;
 #endif
=20
-void *irq_kmalloc(size_t size, int pri)
-{
-	unsigned int i;
-	if ( mem_init_done )
-		return kmalloc(size,pri);
-	for ( i =3D 0; i < IRQ_KMALLOC_ENTRIES ; i++ )
-		if ( ! ( cache_bitmask & (1<<i) ) )
-		{
-			cache_bitmask |=3D (1<<i);
-			return (void *)(&malloc_cache[i]);
-		}
-	return 0;
-}
-
-void irq_kfree(void *ptr)
-{
-	unsigned int i;
-	for ( i =3D 0 ; i < IRQ_KMALLOC_ENTRIES ; i++ )
-		if ( ptr =3D=3D &malloc_cache[i] )
-		{
-			cache_bitmask &=3D ~(1<<i);
-			return;
-		}
-	kfree(ptr);
-}
-
-int
-setup_irq(unsigned int irq, struct irqaction * new)
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
-		desc->status &=3D ~(IRQ_DISABLED | IRQ_AUTODETECT | IRQ_WAITING);
-		unmask_irq(irq);
-	}
-	spin_unlock_irqrestore(&desc->lock,flags);
-
-	register_irq_proc(irq);
-	return 0;
-}
-
-void free_irq(unsigned int irq, void* dev_id)
-{
-	irq_desc_t *desc;
-	struct irqaction **p;
-	unsigned long flags;
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
-				mask_irq(irq);
-			}
-			spin_unlock_irqrestore(&desc->lock,flags);
-
-			synchronize_irq(irq);
-			irq_kfree(action);
-			return;
-		}
-		printk("Trying to free free IRQ%d\n",irq);
-		spin_unlock_irqrestore(&desc->lock,flags);
-		break;
-	}
-	return;
-}
-
-int request_irq(unsigned int irq,
-	irqreturn_t (*handler)(int, void *, struct pt_regs *),
-	unsigned long irqflags, const char * devname, void *dev_id)
-{
-	struct irqaction *action;
-	int retval;
-
-	if (irq >=3D NR_IRQS)
-		return -EINVAL;
-	if (!handler) {
-		printk(KERN_ERR "request_irq called with NULL handler!\n");
-		dump_stack();
-		return 0;
-	}
-=09
-	action =3D (struct irqaction *)
-		irq_kmalloc(sizeof(struct irqaction), GFP_KERNEL);
-	if (!action) {
-		printk(KERN_ERR "irq_kmalloc() failed for irq %d !\n", irq);
-		return -ENOMEM;
-	}
-=09
-	action->handler =3D handler;
-	action->flags =3D irqflags;				=09
-	action->mask =3D 0;
-	action->name =3D devname;
-	action->dev_id =3D dev_id;
-	action->next =3D NULL;
-=09
-	retval =3D setup_irq(irq, action);
-	if (retval) {
-		kfree(action);
-		return retval;
-	}
-	=09
-	return 0;
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
-
-void disable_irq_nosync(unsigned int irq)
-{
-	irq_desc_t *desc =3D irq_desc + irq;
-	unsigned long flags;
-
-	spin_lock_irqsave(&desc->lock, flags);
-	if (!desc->depth++) {
-		if (!(desc->status & IRQ_PER_CPU))
-			desc->status |=3D IRQ_DISABLED;
-		mask_irq(irq);
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
-		unmask_irq(irq);
-		/* fall-through */
-	}
-	default:
-		desc->depth--;
-		break;
-	case 0:
-		printk("enable_irq(%u) unbalanced\n", irq);
-	}
-	spin_unlock_irqrestore(&desc->lock, flags);
-}
=20
 int show_interrupts(struct seq_file *p, void *v)
 {
@@ -394,24 +118,6 @@
 	return 0;
 }
=20
-static inline void
-handle_irq_event(int irq, struct pt_regs *regs, struct irqaction *action)
-{
-	int status =3D 0;
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
-}
-
 /*
  * Eventually, this should take an array of interrupts and an array size
  * so it can dispatch multiple interrupts.
@@ -479,10 +185,13 @@
 	 * SMP environment.
 	 */
 	for (;;) {
+		extern void note_interrupt(int, irq_desc_t*, irqreturn_t);
+		irqreturn_t action_ret;
+
 		spin_unlock(&desc->lock);
-		handle_irq_event(irq, regs, action);
+		action_ret =3D handle_IRQ_event(irq, regs, action);
 		spin_lock(&desc->lock);
-	=09
+		note_interrupt(irq, desc, action_ret);
 		if (likely(!(desc->status & IRQ_PENDING)))
 			break;
 		desc->status &=3D ~IRQ_PENDING;
@@ -551,184 +260,3 @@
 =09
 	ppc_md.init_IRQ();
 }
-
-#ifdef CONFIG_SMP
-void synchronize_irq(unsigned int irq)
-{
-	while (irq_desc[irq].status & IRQ_INPROGRESS)
-		barrier();
-}
-#endif /* CONFIG_SMP */
-
-static struct proc_dir_entry *root_irq_dir;
-static struct proc_dir_entry *irq_dir[NR_IRQS];
-static struct proc_dir_entry *smp_affinity_entry[NR_IRQS];
-
-#ifdef CONFIG_IRQ_ALL_CPUS
-#define DEFAULT_CPU_AFFINITY 0xffffffff
-#else
-#define DEFAULT_CPU_AFFINITY 0x00000001
-#endif
-
-unsigned int irq_affinity [NR_IRQS] =3D
-	{ [0 ... NR_IRQS-1] =3D DEFAULT_CPU_AFFINITY };
-
-#define HEX_DIGITS 8
-
-static int irq_affinity_read_proc (char *page, char **start, off_t off,
-			int count, int *eof, void *data)
-{
-	if (count < HEX_DIGITS+1)
-		return -EINVAL;
-	return sprintf (page, "%08x\n", irq_affinity[(int)data]);
-}
-
-static unsigned int parse_hex_value (const char __user *buffer,
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
-static int irq_affinity_write_proc (struct file *file, const char __user *=
buffer,
-					unsigned long count, void *data)
-{
-	int irq =3D (int) data, full_count =3D count, err;
-	unsigned long new_value;
-
-	if (!irq_desc[irq].handler->set_affinity)
-		return -EIO;
-
-	err =3D parse_hex_value(buffer, count, &new_value);
-
-	/*
-	 * Do not allow disabling IRQs completely - it's a too easy
-	 * way to make the system unusable accidentally :-) At least
-	 * one online CPU still has to be targeted.
-	 *
-	 * We assume a 1-1 logical<->physical cpu mapping here.  If
-	 * we assume that the cpu indices in /proc/irq/../smp_affinity
-	 * are actually logical cpu #'s then we have no problem.
-	 *  -- Cort <cort@fsmlabs.com>
-	 */
-	if (!(new_value & cpu_online_map))
-		return -EINVAL;
-
-	irq_affinity[irq] =3D new_value;
-	irq_desc[irq].handler->set_affinity(irq, new_value);
-
-	return full_count;
-}
-
-static int prof_cpu_mask_read_proc (char *page, char **start, off_t off,
-			int count, int *eof, void *data)
-{
-	unsigned long *mask =3D (unsigned long *) data;
-	if (count < HEX_DIGITS+1)
-		return -EINVAL;
-	return sprintf (page, "%08lx\n", *mask);
-}
-
-static int prof_cpu_mask_write_proc (struct file *file, const char __user =
*buffer,
-					unsigned long count, void *data)
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
-
-#define MAX_NAMELEN 10
-
-static void register_irq_proc (unsigned int irq)
-{
-	struct proc_dir_entry *entry;
-	char name [MAX_NAMELEN];
-
-	if (!root_irq_dir || (irq_desc[irq].handler =3D=3D NULL) || irq_dir[irq])
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
-	entry->data =3D (void *)irq;
-	entry->read_proc =3D irq_affinity_read_proc;
-	entry->write_proc =3D irq_affinity_write_proc;
-
-	smp_affinity_entry[irq] =3D entry;
-}
-
-unsigned long prof_cpu_mask =3D -1;
-
-void init_irq_proc (void)
-{
-	struct proc_dir_entry *entry;
-	int i;
-
-	/* create /proc/irq */
-	root_irq_dir =3D proc_mkdir("irq", 0);
-
-	/* create /proc/irq/prof_cpu_mask */
-	entry =3D create_proc_entry("prof_cpu_mask", 0600, root_irq_dir);
-
-	entry->nlink =3D 1;
-	entry->data =3D (void *)&prof_cpu_mask;
-	entry->read_proc =3D prof_cpu_mask_read_proc;
-	entry->write_proc =3D prof_cpu_mask_write_proc;
-
-	/*
-	 * Create entries for all existing IRQs.
-	 */
-	for (i =3D 0; i < NR_IRQS; i++) {
-		if (irq_desc[i].handler =3D=3D NULL)
-			continue;
-		register_irq_proc(i);
-	}
-}
-
-irqreturn_t no_action(int irq, void *dev, struct pt_regs *regs)
-{
-	return IRQ_NONE;
-}
diff --minimal -urN -X /usr/share/dontdiff linux-2.5.73.vanilla/include/asm=
-ppc/hw_irq.h linux-2.5.73/include/asm-ppc/hw_irq.h
--- linux-2.5.73.vanilla/include/asm-ppc/hw_irq.h	2003-06-27 20:32:53.00000=
0000 +0400
+++ linux-2.5.73/include/asm-ppc/hw_irq.h	2003-06-29 20:44:16.000000000 +04=
00
@@ -71,6 +71,37 @@
 struct hw_interrupt_type;
 static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int=
 i) {}
=20
+#define arch_ack_bad_irq(irq) do { } while (0)
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
+#define for_each_irq(i) for (i =3D 0; i < NR_IRQS; i++) \
+	if (!irq_valid(i)) \
+		continue; \
+	else
+
+/* Used in setup_irq() */
+#define ARCH_NONSHARED_IRQ_MASK ~(IRQ_DISABLED | IRQ_AUTODETECT | IRQ_WAIT=
ING)
+
+#define HAVE_ARCH_IRQ_PROBE
+
+#define ARCH_AFFINITY_WIDTH	8
+
+#ifdef CONFIG_IRQ_ALL_CPUS
+#define ARCH_DEFAULT_CPU_AFFINITY=20
+#define ARCH_DEFAULT_IRQ_AFFINITY	~0UL
+#else
+#define ARCH_DEFAULT_IRQ_AFFINITY	0x00000001
+#endif
+
+#define arch_can_create_irq_proc() (1)
=20
 #endif /* _PPC_HW_IRQ_H */
 #endif /* __KERNEL__ */

--ahP6B03r4gLOj5uD--

--8/pVXlBMPtxfSuJG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/AAO1by9O0+A2ZecRAky1AJ0QFo0ilcDS/nlh+C5YTgX2i6acaQCgmQBO
GwwvX4RWwQM5sz1NOFoa7kk=
=M94q
-----END PGP SIGNATURE-----

--8/pVXlBMPtxfSuJG--
