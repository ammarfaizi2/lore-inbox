Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266854AbTADLzO>; Sat, 4 Jan 2003 06:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266907AbTADLzO>; Sat, 4 Jan 2003 06:55:14 -0500
Received: from samael.donpac.ru ([195.161.172.239]:13575 "EHLO
	samael.donpac.ru") by vger.kernel.org with ESMTP id <S266854AbTADLzF>;
	Sat, 4 Jan 2003 06:55:05 -0500
From: "Andrey Panin" <pazke@orbita1.ru>
Date: Sat, 4 Jan 2003 14:59:10 +0300
To: linux-kernel@vger.kernel.org
Subject: [RFC] irq handling code consolidation, second try (ppc part)
Message-ID: <20030104115910.GF10477@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FLPM4o+7JoHGki3m"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Uname: Linux 2.4.20aa1 i686 unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FLPM4o+7JoHGki3m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi all, 

attached patch is a second try of IRQ handling code consolidation.
This is a ppc specific patch (compiled successfuly).

Beware, this patch removes some old(?) and crappy code:
	- irq_kmalloc(), irq_kfree() removed. If ppc need to register
	  irqs early, it should use setup_irq() as all decent people do :))
	- request_irq() with NULL handler argument == free_irq(), does
	  anyone use this kludge ?

Best regards.

-- 
Andrey Panin		| Embedded systems software developer
pazke@orbita1.ru	| PGP key: wwwkeys.pgp.net

--FLPM4o+7JoHGki3m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-irq-ppc-2.5.53"

diff --minimal -urN -X /usr/share/dontdiff linux-2.5.53.vanilla/arch/ppc/Kconfig linux-2.5.53/arch/ppc/Kconfig
--- linux-2.5.53.vanilla/arch/ppc/Kconfig	Fri Dec 27 19:44:57 2002
+++ linux-2.5.53/arch/ppc/Kconfig	Fri Jan  3 14:28:03 2003
@@ -10,6 +10,10 @@
 	bool
 	default y
 
+config GENERIC_IRQ
+	bool
+	default y
+
 config UID16
 	bool
 
diff --minimal -urN -X /usr/share/dontdiff linux-2.5.53.vanilla/arch/ppc/kernel/irq.c linux-2.5.53/arch/ppc/kernel/irq.c
--- linux-2.5.53.vanilla/arch/ppc/kernel/irq.c	Fri Dec 27 19:44:57 2002
+++ linux-2.5.53/arch/ppc/kernel/irq.c	Fri Jan  3 21:17:10 2003
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
@@ -59,289 +53,21 @@
 
 extern atomic_t ipi_recv;
 extern atomic_t ipi_sent;
-void enable_irq(unsigned int irq_nr);
-void disable_irq(unsigned int irq_nr);
 
 static void register_irq_proc (unsigned int irq);
 
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
-int request_irq(unsigned int irq, void (*handler)(int, void *, struct pt_regs *),
-	unsigned long irqflags, const char * devname, void *dev_id)
-{
-	struct irqaction *action;
-	int retval;
-
-	if (irq >= NR_IRQS)
-		return -EINVAL;
-	if (!handler)
-	{
-		/*
-		 * free_irq() used to be implemented as a call to
-		 * request_irq() with handler being NULL.  Now we have
-		 * a real free_irq() but need to allow the old behavior
-		 * for old code that hasn't caught up yet.
-		 *  -- Cort <cort@fsmlabs.com>
-		 */
-		free_irq(irq, dev_id);
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
-	if (retval)
-	{
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
-
 int show_interrupts(struct seq_file *p, void *v)
 {
 	int i, j;
@@ -394,24 +120,6 @@
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
@@ -480,7 +188,7 @@
 	 */
 	for (;;) {
 		spin_unlock(&desc->lock);
-		handle_irq_event(irq, regs, action);
+		handle_IRQ_event(irq, regs, action);
 		spin_lock(&desc->lock);
 		
 		if (likely(!(desc->status & IRQ_PENDING)))
@@ -554,14 +262,6 @@
 	ppc_md.init_IRQ();
 }
 
-#ifdef CONFIG_SMP
-void synchronize_irq(unsigned int irq)
-{
-	while (irq_desc[irq].status & IRQ_INPROGRESS)
-		barrier();
-}
-#endif /* CONFIG_SMP */
-
 static struct proc_dir_entry *root_irq_dir;
 static struct proc_dir_entry *irq_dir[NR_IRQS];
 static struct proc_dir_entry *smp_affinity_entry[NR_IRQS];
@@ -585,42 +285,8 @@
 	return sprintf (page, "%08x\n", irq_affinity[(int)data]);
 }
 
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
+extern unsigned int parse_hex_value(const char *buffer, unsigned long count,
+				    unsigned long *ret);
 
 static int irq_affinity_write_proc (struct file *file, const char *buffer,
 					unsigned long count, void *data)
@@ -728,8 +394,4 @@
 			continue;
 		register_irq_proc(i);
 	}
-}
-
-void no_action(int irq, void *dev, struct pt_regs *regs)
-{
 }
diff --minimal -urN -X /usr/share/dontdiff linux-2.5.53.vanilla/include/asm-ppc/hw_irq.h linux-2.5.53/include/asm-ppc/hw_irq.h
--- linux-2.5.53.vanilla/include/asm-ppc/hw_irq.h	Fri Dec 27 19:47:10 2002
+++ linux-2.5.53/include/asm-ppc/hw_irq.h	Sat Jan  4 00:24:07 2003
@@ -5,6 +5,8 @@
 #ifndef _PPC_HW_IRQ_H
 #define _PPC_HW_IRQ_H
 
+//#include <linux/irq.h>
+
 extern void timer_interrupt(struct pt_regs *);
 extern void ppc_irq_dispatch_handler(struct pt_regs *regs, int irq);
 
@@ -71,6 +73,23 @@
 struct hw_interrupt_type;
 static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i) {}
 
+//extern irq_desc_t irq_desc[NR_IRQS];
+
+#define arch_ack_bad_irq(irq) do { } while (0)
+
+/* Return a pointer to the irq descriptor for IRQ.  */
+#define irq_desc(irq) (irq_desc + (irq))
+
+/* Check irq number */
+#define arch_check_irq(irq) ((irq) >= NR_IRQS)
+
+/* Arch specific hook for setup_irq() */
+#define arch_setup_irq(irq, desc, irqaction) do { } while (0)
+
+/* Used in setup_irq() */
+#define ARCH_NONSHARED_IRQ_MASK ~(IRQ_DISABLED | IRQ_AUTODETECT | IRQ_WAITING)
+
+#define HAVE_ARCH_IRQ_PROBE
 
 #endif /* _PPC_HW_IRQ_H */
 #endif /* __KERNEL__ */

--FLPM4o+7JoHGki3m--
