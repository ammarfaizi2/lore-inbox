Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266585AbUJAVxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266585AbUJAVxJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 17:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266467AbUJAVPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 17:15:12 -0400
Received: from scanner2.mail.elte.hu ([157.181.151.9]:59851 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266170AbUJAUsE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 16:48:04 -0400
Date: Fri, 1 Oct 2004 22:49:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 5/5, 2.6.9-rc3] generic irq subsystem, ppc64 port
Message-ID: <20041001204930.GE18750@elte.hu>
References: <20041001204533.GA18684@elte.hu> <20041001204642.GA18750@elte.hu> <20041001204740.GB18750@elte.hu> <20041001204822.GC18750@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041001204822.GC18750@elte.hu>
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


ppc64 port of generic hardirq handling.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Christoph Hellwig <hch@lst.de>

--- linux/arch/ppc64/Kconfig.orig
+++ linux/arch/ppc64/Kconfig
@@ -207,6 +207,13 @@ config PREEMPT
 	  Say Y here if you are building a kernel for a desktop, embedded
 	  or real-time system.  Say N if you are unsure.
 
+#
+# Use the generic interrupt handling code in kernel/hardirq.c:
+#
+config GENERIC_HARDIRQS
+	bool
+	default y
+
 config MSCHUNKS
 	bool
 	depends on PPC_ISERIES
--- linux/arch/ppc64/kernel/misc.S.orig
+++ linux/arch/ppc64/kernel/misc.S
@@ -115,12 +115,12 @@ _GLOBAL(call_do_softirq)
 	mtlr	r0
 	blr
 
-_GLOBAL(call_handle_irq_event)
+_GLOBAL(call_handle_IRQ_event)
 	mflr	r0
 	std	r0,16(r1)
 	stdu	r1,THREAD_SIZE-112(r6)
 	mr	r1,r6
-	bl	.handle_irq_event
+	bl	.handle_IRQ_event
 	ld	r1,0(r1)
 	ld	r0,16(r1)
 	mtlr	r0
--- linux/arch/ppc64/kernel/irq.c.orig
+++ linux/arch/ppc64/kernel/irq.c
@@ -60,259 +60,12 @@
 extern void iSeries_smp_message_recv( struct pt_regs * );
 #endif
 
-static void register_irq_proc (unsigned int irq);
-
-irq_desc_t irq_desc[NR_IRQS] __cacheline_aligned = {
-	[0 ... NR_IRQS-1] = {
-		.lock = SPIN_LOCK_UNLOCKED
-	}
-};
+extern irq_desc_t irq_desc[NR_IRQS];
 
 int __irq_offset_value;
 int ppc_spurious_interrupts;
 unsigned long lpevent_count;
 
-int
-setup_irq(unsigned int irq, struct irqaction * new)
-{
-	int shared = 0;
-	unsigned long flags;
-	struct irqaction *old, **p;
-	irq_desc_t *desc = get_irq_desc(irq);
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
-		desc->status &= ~(IRQ_DISABLED | IRQ_AUTODETECT | IRQ_WAITING | IRQ_INPROGRESS);
-		if (desc->handler && desc->handler->startup)
-			desc->handler->startup(irq);
-		unmask_irq(irq);
-	}
-	spin_unlock_irqrestore(&desc->lock,flags);
-
-	register_irq_proc(irq);
-	return 0;
-}
-
-#ifdef CONFIG_SMP
-
-inline void synchronize_irq(unsigned int irq)
-{
-	while (get_irq_desc(irq)->status & IRQ_INPROGRESS)
-		cpu_relax();
-}
-
-EXPORT_SYMBOL(synchronize_irq);
-
-#endif /* CONFIG_SMP */
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
-	if (!handler)
-		return -EINVAL;
-
-	action = (struct irqaction *)
-		kmalloc(sizeof(struct irqaction), GFP_KERNEL);
-	if (!action) {
-		printk(KERN_ERR "kmalloc() failed for irq %d !\n", irq);
-		return -ENOMEM;
-	}
-
-	action->handler = handler;
-	action->flags = irqflags;
-	cpus_clear(action->mask);
-	action->name = devname;
-	action->dev_id = dev_id;
-	action->next = NULL;
-
-	retval = setup_irq(irq, action);
-	if (retval)
-		kfree(action);
-
-	return 0;
-}
-
-EXPORT_SYMBOL(request_irq);
-
-void free_irq(unsigned int irq, void *dev_id)
-{
-	irq_desc_t *desc = get_irq_desc(irq);
-	struct irqaction **p;
-	unsigned long flags;
-
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
-			/* Wait to make sure it's not being used on another CPU */
-			synchronize_irq(irq);
-			kfree(action);
-			return;
-		}
-		printk("Trying to free free IRQ%d\n",irq);
-		spin_unlock_irqrestore(&desc->lock,flags);
-		break;
-	}
-	return;
-}
-
-EXPORT_SYMBOL(free_irq);
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
-inline void disable_irq_nosync(unsigned int irq)
-{
-	irq_desc_t *desc = get_irq_desc(irq);
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
-EXPORT_SYMBOL(disable_irq_nosync);
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
-	irq_desc_t *desc = get_irq_desc(irq);
-	disable_irq_nosync(irq);
-	if (desc->action)
-		synchronize_irq(irq);
-}
-
-EXPORT_SYMBOL(disable_irq);
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
-	irq_desc_t *desc = get_irq_desc(irq);
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
-		printk("enable_irq(%u) unbalanced from %p\n", irq,
-		       __builtin_return_address(0));
-	}
-	spin_unlock_irqrestore(&desc->lock, flags);
-}
-
-EXPORT_SYMBOL(enable_irq);
-
 int show_interrupts(struct seq_file *p, void *v)
 {
 	int i = *(loff_t *) v, j;
@@ -360,107 +113,7 @@ skip:
 	return 0;
 }
 
-int handle_irq_event(int irq, struct pt_regs *regs, struct irqaction *action)
-{
-	int status = 0;
-	int ret, retval = 0;
-
-	if (!(action->flags & SA_INTERRUPT))
-		local_irq_enable();
-
-	do {
-		ret = action->handler(irq, action->dev_id, regs);
-		if (ret == IRQ_HANDLED)
-			status |= action->flags;
-		retval |= ret;
-		action = action->next;
-	} while (action);
-	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
-	local_irq_disable();
-	return retval;
-}
-
-static void __report_bad_irq(int irq, irq_desc_t *desc, irqreturn_t action_ret)
-{
-	struct irqaction *action;
-
-	if (action_ret != IRQ_HANDLED && action_ret != IRQ_NONE) {
-		printk(KERN_ERR "irq event %d: bogus return value %x\n",
-				irq, action_ret);
-	} else {
-		printk(KERN_ERR "irq %d: nobody cared!\n", irq);
-	}
-	dump_stack();
-	printk(KERN_ERR "handlers:\n");
-	action = desc->action;
-	do {
-		printk(KERN_ERR "[<%p>]", action->handler);
-		print_symbol(" (%s)",
-			(unsigned long)action->handler);
-		printk("\n");
-		action = action->next;
-	} while (action);
-}
-
-static void report_bad_irq(int irq, irq_desc_t *desc, irqreturn_t action_ret)
-{
-	static int count = 100;
-
-	if (count) {
-		count--;
-		__report_bad_irq(irq, desc, action_ret);
-	}
-}
-
-static int noirqdebug;
-
-static int __init noirqdebug_setup(char *str)
-{
-	noirqdebug = 1;
-	printk("IRQ lockup detection disabled\n");
-	return 1;
-}
-
-__setup("noirqdebug", noirqdebug_setup);
-
-/*
- * If 99,900 of the previous 100,000 interrupts have not been handled then
- * assume that the IRQ is stuck in some manner.  Drop a diagnostic and try to
- * turn the IRQ off.
- *
- * (The other 100-of-100,000 interrupts may have been a correctly-functioning
- *  device sharing an IRQ with the failing one)
- *
- * Called under desc->lock
- */
-static void note_interrupt(int irq, irq_desc_t *desc, irqreturn_t action_ret)
-{
-	if (action_ret != IRQ_HANDLED) {
-		desc->irqs_unhandled++;
-		if (action_ret != IRQ_NONE)
-			report_bad_irq(irq, desc, action_ret);
-	}
-
-	desc->irq_count++;
-	if (desc->irq_count < 100000)
-		return;
-
-	desc->irq_count = 0;
-	if (desc->irqs_unhandled > 99900) {
-		/*
-		 * The interrupt is stuck
-		 */
-		__report_bad_irq(irq, desc, action_ret);
-		/*
-		 * Now kill the IRQ
-		 */
-		printk(KERN_EMERG "Disabling IRQ #%d\n", irq);
-		desc->status |= IRQ_DISABLED;
-		desc->handler->disable(irq);
-	}
-	desc->irqs_unhandled = 0;
-}
+extern int noirqdebug;
 
 /*
  * Eventually, this should take an array of interrupts and an array size
@@ -482,7 +135,7 @@ void ppc_irq_dispatch_handler(struct pt_
 	if (desc->status & IRQ_PER_CPU) {
 		/* no locking required for CPU-local interrupts: */
 		ack_irq(irq);
-		action_ret = handle_irq_event(irq, regs, desc->action);
+		action_ret = handle_IRQ_event(irq, regs, desc->action);
 		desc->handler->end(irq);
 		return;
 	}
@@ -550,13 +203,13 @@ void ppc_irq_dispatch_handler(struct pt_
 		if (curtp != irqtp) {
 			irqtp->task = curtp->task;
 			irqtp->flags = 0;
-			action_ret = call_handle_irq_event(irq, regs, action, irqtp);
+			action_ret = call_handle_IRQ_event(irq, regs, action, irqtp);
 			irqtp->task = NULL;
 			if (irqtp->flags)
 				set_bits(irqtp->flags, &curtp->flags);
 		} else
 #endif
-			action_ret = handle_irq_event(irq, regs, action);
+			action_ret = handle_IRQ_event(irq, regs, action);
 
 		spin_lock(&desc->lock);
 		if (!noirqdebug)
@@ -658,27 +311,6 @@ void do_IRQ(struct pt_regs *regs)
 }
 #endif	/* CONFIG_PPC_ISERIES */
 
-unsigned long probe_irq_on (void)
-{
-	return 0;
-}
-
-EXPORT_SYMBOL(probe_irq_on);
-
-int probe_irq_off (unsigned long irqs)
-{
-	return 0;
-}
-
-EXPORT_SYMBOL(probe_irq_off);
-
-unsigned int probe_irq_mask(unsigned long irqs)
-{
-	return 0;
-}
-
-EXPORT_SYMBOL(probe_irq_mask);
-
 void __init init_IRQ(void)
 {
 	static int once = 0;
@@ -692,130 +324,6 @@ void __init init_IRQ(void)
 	irq_ctx_init();
 }
 
-static struct proc_dir_entry * root_irq_dir;
-static struct proc_dir_entry * irq_dir [NR_IRQS];
-static struct proc_dir_entry * smp_affinity_entry [NR_IRQS];
-
-/* Protected by get_irq_desc(irq)->lock. */
-#ifdef CONFIG_IRQ_ALL_CPUS
-cpumask_t irq_affinity [NR_IRQS] = { [0 ... NR_IRQS-1] = CPU_MASK_ALL };
-#else  /* CONFIG_IRQ_ALL_CPUS */
-cpumask_t irq_affinity [NR_IRQS] = { [0 ... NR_IRQS-1] = CPU_MASK_NONE };
-#endif /* CONFIG_IRQ_ALL_CPUS */
-
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
-static int irq_affinity_write_proc (struct file *file, const char __user *buffer,
-					unsigned long count, void *data)
-{
-	unsigned int irq = (long)data;
-	irq_desc_t *desc = get_irq_desc(irq);
-	int ret;
-	cpumask_t new_value, tmp;
-
-	if (!desc->handler->set_affinity)
-		return -EIO;
-
-	ret = cpumask_parse(buffer, count, new_value);
-	if (ret != 0)
-		return ret;
-
-	/*
-	 * We check for CPU_MASK_ALL in xics to send irqs to all cpus.
-	 * In some cases CPU_MASK_ALL is smaller than the cpumask (eg
-	 * NR_CPUS == 32 and cpumask is a long), so we mask it here to
-	 * be consistent.
-	 */
-	cpus_and(new_value, new_value, CPU_MASK_ALL);
-
-	/*
-	 * Grab lock here so cpu_online_map can't change, and also
-	 * protect irq_affinity[].
-	 */
-	spin_lock(&desc->lock);
-
-	/*
-	 * Do not allow disabling IRQs completely - it's a too easy
-	 * way to make the system unusable accidentally :-) At least
-	 * one online CPU still has to be targeted.
-	 */
-	cpus_and(tmp, new_value, cpu_online_map);
-	if (cpus_empty(tmp)) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	irq_affinity[irq] = new_value;
-	desc->handler->set_affinity(irq, new_value);
-	ret = count;
-
-out:
-	spin_unlock(&desc->lock);
-	return ret;
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
-	if (entry) {
-		entry->nlink = 1;
-		entry->data = (void *)(long)irq;
-		entry->read_proc = irq_affinity_read_proc;
-		entry->write_proc = irq_affinity_write_proc;
-	}
-
-	smp_affinity_entry[irq] = entry;
-}
-
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
-	for_each_irq(i) {
-		if (get_irq_desc(i)->handler == NULL)
-			continue;
-		register_irq_proc(i);
-	}
-}
-
-irqreturn_t no_action(int irq, void *dev, struct pt_regs *regs)
-{
-	return IRQ_NONE;
-}
-
 #ifndef CONFIG_PPC_ISERIES
 /*
  * Virtual IRQ mapping code, used on systems with XICS interrupt controllers.
--- linux/include/asm-ppc64/irq.h.orig
+++ linux/include/asm-ppc64/irq.h
@@ -17,10 +17,6 @@
  */
 #define NR_IRQS		512
 
-extern void disable_irq(unsigned int);
-extern void disable_irq_nosync(unsigned int);
-extern void enable_irq(unsigned int);
-
 /* this number is used when no interrupt has been assigned */
 #define NO_IRQ			(-1)
 
@@ -80,7 +76,6 @@ static __inline__ int irq_canonicalize(i
 
 struct irqaction;
 struct pt_regs;
-int handle_irq_event(int, struct pt_regs *, struct irqaction *);
 
 #ifdef CONFIG_IRQSTACKS
 /*
@@ -91,7 +86,7 @@ extern struct thread_info *softirq_ctx[N
 
 extern void irq_ctx_init(void);
 extern void call_do_softirq(struct thread_info *tp);
-extern int call_handle_irq_event(int irq, struct pt_regs *regs,
+extern int call_handle_IRQ_event(int irq, struct pt_regs *regs,
 			struct irqaction *action, struct thread_info *tp);
 
 #define __ARCH_HAS_DO_SOFTIRQ
--- linux/include/asm-ppc64/hardirq.h.orig
+++ linux/include/asm-ppc64/hardirq.h
@@ -19,45 +19,10 @@ typedef struct {
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
-/*
- * We put the hardirq and softirq counter into the preemption
- * counter. The bitmask has the following meaning:
- *
- * - bits 0-7 are the preemption count (max preemption depth: 256)
- * - bits 8-15 are the softirq count (max # of softirqs: 256)
- * - bits 16-24 are the hardirq count (max # of hardirqs: 512)
- *
- * - ( bit 26 is the PREEMPT_ACTIVE flag. )
- *
- * PREEMPT_MASK: 0x000000ff
- * SOFTIRQ_MASK: 0x0000ff00
- * HARDIRQ_MASK: 0x01ff0000
- */
-
-#define PREEMPT_BITS	8
-#define SOFTIRQ_BITS	8
-#define HARDIRQ_BITS	9
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
-#endif
-
-#define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
-#define irq_exit()							\
-do {									\
-		preempt_count() -= IRQ_EXIT_OFFSET;			\
-		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
-			do_softirq();					\
-		preempt_enable_no_resched();				\
-} while (0)
+static inline void ack_bad_irq(int irq)
+{
+	printk(KERN_CRIT "illegal vector %d received!\n", irq);
+	BUG();
+}
 
 #endif /* __ASM_HARDIRQ_H */
--- linux/include/asm-ppc64/smp.h.orig
+++ linux/include/asm-ppc64/smp.h
@@ -52,8 +52,6 @@ extern cpumask_t cpu_sibling_map[NR_CPUS
 #endif
 #define PPC_MSG_DEBUGGER_BREAK  3
 
-extern cpumask_t irq_affinity[];
-
 void smp_init_iSeries(void);
 void smp_init_pSeries(void);
 
