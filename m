Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbTELLZN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 07:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbTELLZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 07:25:13 -0400
Received: from cs-ats40.donpac.ru ([217.107.128.161]:14340 "EHLO pazke")
	by vger.kernel.org with ESMTP id S261915AbTELLYv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 07:24:51 -0400
Date: Mon, 12 May 2003 15:37:33 +0400
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>, paulus@samba.org
Subject: [PATCH] irq handling consolidation (ppc part)
Message-ID: <20030512113733.GD1315@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>, paulus@samba.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="1sNVjLsmu1MXqwQ/"
Content-Disposition: inline
X-Uname: Linux 2.5.68 i686 unknown
User-Agent: Mutt/1.5.4i
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1sNVjLsmu1MXqwQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

powerpc part of irq handling code consolidation. Compiles,
but untested.

Please take a look.

Best regards.

-- 
Andrey Panin		| Embedded systems software developer
pazke@orbita1.ru	| PGP key: wwwkeys.pgp.net

--1sNVjLsmu1MXqwQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-irq-ppc-2.5.69"

diff --minimal -urN -X /usr/share/dontdiff linux-2.5.69.vanilla/arch/ppc/Kconfig linux-2.5.69/arch/ppc/Kconfig
--- linux-2.5.69.vanilla/arch/ppc/Kconfig	2003-05-07 20:40:40.000000000 +0400
+++ linux-2.5.69/arch/ppc/Kconfig	2003-05-11 21:03:26.000000000 +0400
@@ -6,6 +6,10 @@
 	bool
 	default y
 
+config GENERIC_IRQ
+	bool
+	default y
+
 config UID16
 	bool
 
diff --minimal -urN -X /usr/share/dontdiff linux-2.5.69.vanilla/arch/ppc/kernel/irq.c linux-2.5.69/arch/ppc/kernel/irq.c
--- linux-2.5.69.vanilla/arch/ppc/kernel/irq.c	2003-05-07 20:40:40.000000000 +0400
+++ linux-2.5.69/arch/ppc/kernel/irq.c	2003-05-11 21:10:04.000000000 +0400
@@ -10,12 +10,6 @@
  *  Adapted for Power Macintosh by Paul Mackerras
  *    Copyright (C) 1996 Paul Mackerras (paulus@cs.anu.edu.au)
  *  Amiga/APUS changes by Jesper Skov (jskov@cygnus.co.uk).
- *  
- * This file contains the code used by various IRQ handling routines:
- * asking for different IRQ's should be done through these routines
- * instead of just grabbing them. Thus setups with different IRQ numbers
- * shouldn't result in any weird surprises, and installing new handlers
- * should be easier.
  *
  * The MPC8xx has an interrupt mask in the SIU.  If a bit is set, the
  * interrupt is _enabled_.  As expected, IRQ0 is bit 0 in the 32-bit
@@ -26,314 +20,41 @@
  * to reduce code space and undefined function references.
  */
 
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
 
-#include <asm/uaccess.h>
-#include <asm/bitops.h>
-#include <asm/system.h>
 #include <asm/io.h>
 #include <asm/pgtable.h>
 #include <asm/irq.h>
 #include <asm/cache.h>
 #include <asm/prom.h>
-#include <asm/ptrace.h>
 
 #define NR_MASK_WORDS	((NR_IRQS + 31) / 32)
 
 extern atomic_t ipi_recv;
 extern atomic_t ipi_sent;
-void enable_irq(unsigned int irq_nr);
-void disable_irq(unsigned int irq_nr);
-
-static void register_irq_proc (unsigned int irq);
 
 #define MAXCOUNT 10000000
 
-irq_desc_t irq_desc[NR_IRQS] __cacheline_aligned =
-	{ [0 ... NR_IRQS-1] = { 0, NULL, NULL, 0, SPIN_LOCK_UNLOCKED}};
-	
 int ppc_spurious_interrupts = 0;
-struct irqaction *ppc_irq_action[NR_IRQS];
 unsigned long ppc_cached_irq_mask[NR_MASK_WORDS];
 unsigned long ppc_lost_interrupts[NR_MASK_WORDS];
 atomic_t ppc_n_lost_interrupts;
 
-/* nasty hack for shared irq's since we need to do kmalloc calls but
- * can't very early in the boot when we need to do a request irq.
- * this needs to be removed.
- * -- Cort
- */
-#define IRQ_KMALLOC_ENTRIES 8
-static int cache_bitmask = 0;
-static struct irqaction malloc_cache[IRQ_KMALLOC_ENTRIES];
-extern int mem_init_done;
-
 #if defined(CONFIG_TAU_INT)
 extern int tau_interrupts(unsigned long cpu);
 extern int tau_initialized;
 #endif
 
-void *irq_kmalloc(size_t size, int pri)
-{
-	unsigned int i;
-	if ( mem_init_done )
-		return kmalloc(size,pri);
-	for ( i = 0; i < IRQ_KMALLOC_ENTRIES ; i++ )
-		if ( ! ( cache_bitmask & (1<<i) ) )
-		{
-			cache_bitmask |= (1<<i);
-			return (void *)(&malloc_cache[i]);
-		}
-	return 0;
-}
-
-void irq_kfree(void *ptr)
-{
-	unsigned int i;
-	for ( i = 0 ; i < IRQ_KMALLOC_ENTRIES ; i++ )
-		if ( ptr == &malloc_cache[i] )
-		{
-			cache_bitmask &= ~(1<<i);
-			return;
-		}
-	kfree(ptr);
-}
-
-int
-setup_irq(unsigned int irq, struct irqaction * new)
-{
-	int shared = 0;
-	unsigned long flags;
-	struct irqaction *old, **p;
-	irq_desc_t *desc = irq_desc + irq;
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
-	if (irq >= NR_IRQS)
-		return -EINVAL;
-	if (!handler) {
-		printk(KERN_ERR "request_irq called with NULL handler!\n");
-		dump_stack();
-		return 0;
-	}
-	
-	action = (struct irqaction *)
-		irq_kmalloc(sizeof(struct irqaction), GFP_KERNEL);
-	if (!action) {
-		printk(KERN_ERR "irq_kmalloc() failed for irq %d !\n", irq);
-		return -ENOMEM;
-	}
-	
-	action->handler = handler;
-	action->flags = irqflags;					
-	action->mask = 0;
-	action->name = devname;
-	action->dev_id = dev_id;
-	action->next = NULL;
-	
-	retval = setup_irq(irq, action);
-	if (retval) {
-		kfree(action);
-		return retval;
-	}
-		
-	return 0;
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
-void disable_irq_nosync(unsigned int irq)
-{
-	irq_desc_t *desc = irq_desc + irq;
-	unsigned long flags;
-
-	spin_lock_irqsave(&desc->lock, flags);
-	if (!desc->depth++) {
-		if (!(desc->status & IRQ_PER_CPU))
-			desc->status |= IRQ_DISABLED;
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
 
 int show_interrupts(struct seq_file *p, void *v)
 {
@@ -391,24 +112,6 @@
 	return 0;
 }
 
-static inline void
-handle_irq_event(int irq, struct pt_regs *regs, struct irqaction *action)
-{
-	int status = 0;
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
-}
-
 /*
  * Eventually, this should take an array of interrupts and an array size
  * so it can dispatch multiple interrupts.
@@ -477,7 +180,7 @@
 	 */
 	for (;;) {
 		spin_unlock(&desc->lock);
-		handle_irq_event(irq, regs, action);
+		handle_IRQ_event(irq, regs, action);
 		spin_lock(&desc->lock);
 		
 		if (likely(!(desc->status & IRQ_PENDING)))
@@ -548,184 +251,3 @@
 	
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
-unsigned int irq_affinity [NR_IRQS] =
-	{ [0 ... NR_IRQS-1] = DEFAULT_CPU_AFFINITY };
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
-static int irq_affinity_write_proc (struct file *file, const char *buffer,
-					unsigned long count, void *data)
-{
-	int irq = (int) data, full_count = count, err;
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
-	 *
-	 * We assume a 1-1 logical<->physical cpu mapping here.  If
-	 * we assume that the cpu indices in /proc/irq/../smp_affinity
-	 * are actually logical cpu #'s then we have no problem.
-	 *  -- Cort <cort@fsmlabs.com>
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
-	struct proc_dir_entry *entry;
-	char name [MAX_NAMELEN];
-
-	if (!root_irq_dir || (irq_desc[irq].handler == NULL) || irq_dir[irq])
-		return;
-
-	memset(name, 0, MAX_NAMELEN);
-	sprintf(name, "%d", irq);
-
-	/* create /proc/irq/1234 */
-	irq_dir[irq] = proc_mkdir(name, root_irq_dir);
-
-	/* create /proc/irq/1234/smp_affinity */
-	entry = create_proc_entry("smp_affinity", 0600, irq_dir[irq]);
-
-	entry->nlink = 1;
-	entry->data = (void *)irq;
-	entry->read_proc = irq_affinity_read_proc;
-	entry->write_proc = irq_affinity_write_proc;
-
-	smp_affinity_entry[irq] = entry;
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
-	entry->nlink = 1;
-	entry->data = (void *)&prof_cpu_mask;
-	entry->read_proc = prof_cpu_mask_read_proc;
-	entry->write_proc = prof_cpu_mask_write_proc;
-
-	/*
-	 * Create entries for all existing IRQs.
-	 */
-	for (i = 0; i < NR_IRQS; i++) {
-		if (irq_desc[i].handler == NULL)
-			continue;
-		register_irq_proc(i);
-	}
-}
-
-irqreturn_t no_action(int irq, void *dev, struct pt_regs *regs)
-{
-	return IRQ_NONE;
-}
diff --minimal -urN -X /usr/share/dontdiff linux-2.5.69.vanilla/include/asm-ppc/hw_irq.h linux-2.5.69/include/asm-ppc/hw_irq.h
--- linux-2.5.69.vanilla/include/asm-ppc/hw_irq.h	2002-11-28 01:36:14.000000000 +0300
+++ linux-2.5.69/include/asm-ppc/hw_irq.h	2003-05-11 21:03:26.000000000 +0400
@@ -71,6 +71,32 @@
 struct hw_interrupt_type;
 static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i) {}
 
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
+/* Used in setup_irq() */
+#define ARCH_NONSHARED_IRQ_MASK ~(IRQ_DISABLED | IRQ_AUTODETECT | IRQ_WAITING)
+
+#define HAVE_ARCH_IRQ_PROBE
+
+#define ARCH_AFFINITY_WIDTH	8
+
+#ifdef CONFIG_IRQ_ALL_CPUS
+#define ARCH_DEFAULT_CPU_AFFINITY 
+#define ARCH_DEFAULT_IRQ_AFFINITY	~0UL
+#else
+#define ARCH_DEFAULT_IRQ_AFFINITY	0x00000001
+#endif
+
+#define arch_can_create_irq_proc() (1)
 
 #endif /* _PPC_HW_IRQ_H */
 #endif /* __KERNEL__ */

--1sNVjLsmu1MXqwQ/--
