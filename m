Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266561AbUJAV1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266561AbUJAV1t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 17:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266585AbUJAV0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 17:26:19 -0400
Received: from scanner2.mail.elte.hu ([157.181.151.9]:53451 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266615AbUJAUrR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 16:47:17 -0400
Date: Fri, 1 Oct 2004 22:48:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 4/5, 2.6.9-rc3] generic irq subsystem, ppc port
Message-ID: <20041001204854.GD18750@elte.hu>
References: <20041001204533.GA18684@elte.hu> <20041001204642.GA18750@elte.hu> <20041001204740.GB18750@elte.hu> <20041001204822.GC18750@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041001204822.GC18750@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-2.701, required 5.9,
	BAYES_00 -4.90, DOMAIN_BODY 2.20
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ppc32 port of generic hardirq handling.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Christoph Hellwig <hch@lst.de>

--- linux/arch/ppc/Kconfig.orig
+++ linux/arch/ppc/Kconfig
@@ -11,6 +11,10 @@ config MMU
 config UID16
 	bool
 
+config GENERIC_HARDIRQS
+	bool
+	default y
+
 config RWSEM_GENERIC_SPINLOCK
 	bool
 
--- linux/arch/ppc/syslib/ppc8xx_pic.c.orig
+++ linux/arch/ppc/syslib/ppc8xx_pic.c
@@ -105,7 +105,7 @@ m8xx_do_IRQ(struct pt_regs *regs,
 		ppc_spurious_interrupts++;
 	}
 	else {
-                ppc_irq_dispatch_handler( regs, irq );
+                __do_IRQ(irq, regs);
 	}
 
 }
@@ -161,7 +161,7 @@ void mbx_i8259_action(int cpl, void *dev
 	}
 	bits = 1UL << irq;
 	irq += i8259_pic.irq_offset;
-	ppc_irq_dispatch_handler( regs, irq );
+	__do_IRQ(irq, regs);
 }
 #endif
 
--- linux/arch/ppc/kernel/ppc_ksyms.c.orig
+++ linux/arch/ppc/kernel/ppc_ksyms.c
@@ -84,10 +84,6 @@ EXPORT_SYMBOL(SingleStepException);
 EXPORT_SYMBOL(sys_sigreturn);
 EXPORT_SYMBOL(ppc_n_lost_interrupts);
 EXPORT_SYMBOL(ppc_lost_interrupts);
-EXPORT_SYMBOL(enable_irq);
-EXPORT_SYMBOL(disable_irq);
-EXPORT_SYMBOL(disable_irq_nosync);
-EXPORT_SYMBOL(probe_irq_mask);
 
 EXPORT_SYMBOL(ISA_DMA_THRESHOLD);
 EXPORT_SYMBOL(DMA_MODE_READ);
@@ -205,7 +201,6 @@ EXPORT_SYMBOL(giveup_spe);
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL(smp_call_function);
 EXPORT_SYMBOL(smp_hw_index);
-EXPORT_SYMBOL(synchronize_irq);
 #endif
 
 EXPORT_SYMBOL(ppc_md);
@@ -292,8 +287,6 @@ EXPORT_SYMBOL(local_irq_restore_end);
 #endif
 EXPORT_SYMBOL(timer_interrupt);
 EXPORT_SYMBOL(irq_desc);
-void ppc_irq_dispatch_handler(struct pt_regs *, int);
-EXPORT_SYMBOL(ppc_irq_dispatch_handler);
 EXPORT_SYMBOL(tb_ticks_per_jiffy);
 EXPORT_SYMBOL(get_wchan);
 EXPORT_SYMBOL(console_drivers);
--- linux/arch/ppc/kernel/irq.c.orig
+++ linux/arch/ppc/kernel/irq.c
@@ -62,296 +62,15 @@
 
 extern atomic_t ipi_recv;
 extern atomic_t ipi_sent;
-void enable_irq(unsigned int irq_nr);
-void disable_irq(unsigned int irq_nr);
-
-static void register_irq_proc (unsigned int irq);
 
 #define MAXCOUNT 10000000
 
-irq_desc_t irq_desc[NR_IRQS] __cacheline_aligned = {
-	[0 ... NR_IRQS-1] = {
-		.lock = SPIN_LOCK_UNLOCKED
-	}
-};
-
 int ppc_spurious_interrupts = 0;
 struct irqaction *ppc_irq_action[NR_IRQS];
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
-#if defined(CONFIG_TAU_INT)
-extern int tau_interrupts(unsigned long cpu);
-extern int tau_initialized;
-#endif
-
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
-	return NULL;
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
-		if (desc->handler) {
-			if (desc->handler->startup)
-				desc->handler->startup(irq);
-			else if (desc->handler->enable)
-				desc->handler->enable(irq);
-		}
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
-EXPORT_SYMBOL(free_irq);
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
-	cpus_clear(action->mask);
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
-EXPORT_SYMBOL(request_irq);
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
-	irq_desc_t *desc = irq_desc + irq;
-	disable_irq_nosync(irq);
-	if (desc->action)
-		synchronize_irq(irq);
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
 	int i = *(loff_t *) v, j;
@@ -411,115 +130,6 @@ skip:
 	return 0;
 }
 
-static inline void
-handle_irq_event(int irq, struct pt_regs *regs, struct irqaction *action)
-{
-	int status = 0;
-	int ret;
-
-	if (!(action->flags & SA_INTERRUPT))
-		local_irq_enable();
-
-	do {
-		ret = action->handler(irq, action->dev_id, regs);
-		if (ret == IRQ_HANDLED)
-			status |= action->flags;
-		action = action->next;
-	} while (action);
-	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
-	local_irq_disable();
-}
-
-/*
- * Eventually, this should take an array of interrupts and an array size
- * so it can dispatch multiple interrupts.
- */
-void ppc_irq_dispatch_handler(struct pt_regs *regs, int irq)
-{
-	int status;
-	struct irqaction *action;
-	irq_desc_t *desc = irq_desc + irq;
-
-	kstat_this_cpu.irqs[irq]++;
-	spin_lock(&desc->lock);
-	ack_irq(irq);
-	/*
-	   REPLAY is when Linux resends an IRQ that was dropped earlier
-	   WAITING is used by probe to mark irqs that are being tested
-	   */
-	status = desc->status & ~(IRQ_REPLAY | IRQ_WAITING);
-	if (!(status & IRQ_PER_CPU))
-		status |= IRQ_PENDING; /* we _want_ to handle it */
-
-	/*
-	 * If the IRQ is disabled for whatever reason, we cannot
-	 * use the action we have.
-	 */
-	action = NULL;
-	if (likely(!(status & (IRQ_DISABLED | IRQ_INPROGRESS)))) {
-		action = desc->action;
-		if (!action || !action->handler) {
-			ppc_spurious_interrupts++;
-			printk(KERN_DEBUG "Unhandled interrupt %x, disabled\n", irq);
-			/* We can't call disable_irq here, it would deadlock */
-			++desc->depth;
-			desc->status |= IRQ_DISABLED;
-			mask_irq(irq);
-			/* This is a real interrupt, we have to eoi it,
-			   so we jump to out */
-			goto out;
-		}
-		status &= ~IRQ_PENDING; /* we commit to handling */
-		if (!(status & IRQ_PER_CPU))
-			status |= IRQ_INPROGRESS; /* we are handling it */
-	}
-	desc->status = status;
-
-	/*
-	 * If there is no IRQ handler or it was disabled, exit early.
-	   Since we set PENDING, if another processor is handling
-	   a different instance of this same irq, the other processor
-	   will take care of it.
-	 */
-	if (unlikely(!action))
-		goto out;
-
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
-		handle_irq_event(irq, regs, action);
-		spin_lock(&desc->lock);
-
-		if (likely(!(desc->status & IRQ_PENDING)))
-			break;
-		desc->status &= ~IRQ_PENDING;
-	}
-out:
-	desc->status &= ~IRQ_INPROGRESS;
-	/*
-	 * The ->end() handler has to deal with interrupts which got
-	 * disabled while the handler was running.
-	 */
-	if (irq_desc[irq].handler) {
-		if (irq_desc[irq].handler->end)
-			irq_desc[irq].handler->end(irq);
-		else if (irq_desc[irq].handler->enable)
-			irq_desc[irq].handler->enable(irq);
-	}
-	spin_unlock(&desc->lock);
-}
-
 void do_IRQ(struct pt_regs *regs)
 {
 	int irq, first = 1;
@@ -534,7 +144,7 @@ void do_IRQ(struct pt_regs *regs)
 	 * has already been handled. -- Tom
 	 */
 	while ((irq = ppc_md.get_irq(regs)) >= 0) {
-		ppc_irq_dispatch_handler(regs, irq);
+		__do_IRQ(irq, regs);
 		first = 0;
 	}
 	if (irq != -2 && first)
@@ -543,143 +153,7 @@ void do_IRQ(struct pt_regs *regs)
         irq_exit();
 }
 
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
-#define DEFAULT_CPU_AFFINITY CPU_MASK_ALL
-#else
-#define DEFAULT_CPU_AFFINITY cpumask_of_cpu(0)
-#endif
-
-cpumask_t irq_affinity [NR_IRQS];
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
-	int irq = (int) data, full_count = count, err;
-	cpumask_t new_value, tmp;
-
-	if (!irq_desc[irq].handler->set_affinity)
-		return -EIO;
-
-	err = cpumask_parse(buffer, count, new_value);
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
-	cpus_and(tmp, new_value, cpu_online_map);
-	if (cpus_empty(tmp))
-		return -EINVAL;
-
-	irq_affinity[irq] = new_value;
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
-void init_irq_proc (void)
-{
-	int i;
-
-	/* create /proc/irq */
-	root_irq_dir = proc_mkdir("irq", NULL);
-	/* create /proc/irq/prof_cpu_mask */
-	create_prof_cpu_mask(root_irq_dir);
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
-
 void __init init_IRQ(void)
 {
-	int i;
-
-	for (i = 0; i < NR_IRQS; ++i)
-		irq_affinity[i] = DEFAULT_CPU_AFFINITY;
-
 	ppc_md.init_IRQ();
 }
--- linux/arch/ppc/platforms/pmac_pic.c.orig
+++ linux/arch/ppc/platforms/pmac_pic.c
@@ -214,7 +214,7 @@ static irqreturn_t gatwick_action(int cp
 		if (bits == 0)
 			continue;
 		irq += __ilog2(bits);
-		ppc_irq_dispatch_handler(regs, irq);
+		__do_IRQ(irq, regs);
 		return IRQ_HANDLED;
 	}
 	printk("gatwick irq not from gatwick pic\n");
@@ -383,11 +383,34 @@ static irqreturn_t k2u3_action(int cpl, 
 
 	irq = openpic2_get_irq(regs);
 	if (irq != -1)
-		ppc_irq_dispatch_handler(regs, irq);
+		__do_IRQ(irq, regs);
 	return IRQ_HANDLED;
 }
+
+static struct irqaction k2u3_cascade_action = {
+	.handler	= k2u3_action,
+	.flags		= 0,
+	.mask		= CPU_MASK_NONE,
+	.name		= "U3->K2 Cascade",
+};
 #endif /* CONFIG_POWER4 */
 
+#ifdef CONFIG_XMON
+static struct irqaction xmon_action = {
+	.handler	= xmon_irq,
+	.flags		= 0,
+	.mask		= CPU_MASK_NONE,
+	.name		= "NMI - XMON"
+};
+#endif
+
+static struct irqaction gatwick_cascade_action = {
+	.handler	= gatwick_action,
+	.flags		= SA_INTERRUPT,
+	.mask		= CPU_MASK_NONE,
+	.name		= "cascade",
+};
+
 void __init pmac_pic_init(void)
 {
         int i;
@@ -440,8 +463,9 @@ void __init pmac_pic_init(void)
 				OpenPIC_InitSenses = senses;
 				OpenPIC_NumInitSenses = 128;
 				openpic2_init(PMAC_OPENPIC2_OFFSET);
-				if (request_irq(irqctrler2->intrs[0].line, k2u3_action, 0,
-						"U3->K2 Cascade", NULL))
+
+				if (setup_irq(irqctrler2->intrs[0].line,
+					      &k2u3_cascade_action))
 					printk("Unable to get OpenPIC IRQ for cascade\n");
 			}
 #endif /* CONFIG_POWER4 */
@@ -455,8 +479,7 @@ void __init pmac_pic_init(void)
 				if (pswitch && pswitch->n_intrs) {
 					nmi_irq = pswitch->intrs[0].line;
 					openpic_init_nmi_irq(nmi_irq);
-					request_irq(nmi_irq, xmon_irq, 0,
-						    "NMI - XMON", NULL);
+					setup_irq(nmi_irq, &xmon_action);
 				}
 			}
 #endif	/* CONFIG_XMON */
@@ -553,8 +576,7 @@ void __init pmac_pic_init(void)
 			(int)irq_cascade);
 		for ( i = max_real_irqs ; i < max_irqs ; i++ )
 			irq_desc[i].handler = &gatwick_pic;
-		request_irq( irq_cascade, gatwick_action, SA_INTERRUPT,
-			     "cascade", NULL );
+		setup_irq(irq_cascade, &gatwick_cascade_action);
 	}
 	printk("System has %d possible interrupts\n", max_irqs);
 	if (max_irqs != max_real_irqs)
@@ -562,7 +584,7 @@ void __init pmac_pic_init(void)
 			max_real_irqs);
 
 #ifdef CONFIG_XMON
-	request_irq(20, xmon_irq, 0, "NMI - XMON", NULL);
+	setup_irq(20, &xmon_action);
 #endif	/* CONFIG_XMON */
 }
 
--- linux/arch/ppc/platforms/85xx/mpc85xx_cds_common.c.orig
+++ linux/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
@@ -191,9 +191,7 @@ mpc85xx_cds_show_cpuinfo(struct seq_file
 static void cpm2_cascade(int irq, void *dev_id, struct pt_regs *regs)
 {
 	while((irq = cpm2_get_irq(regs)) >= 0)
-	{
-		ppc_irq_dispatch_handler(regs,irq);
-	}
+		__do_IRQ(irq, regs);
 }
 #endif /* CONFIG_CPM2 */
 
--- linux/arch/ppc/platforms/85xx/mpc8560_ads.c.orig
+++ linux/arch/ppc/platforms/85xx/mpc8560_ads.c
@@ -145,9 +145,8 @@ mpc8560ads_setup_arch(void)
 
 static irqreturn_t cpm2_cascade(int irq, void *dev_id, struct pt_regs *regs)
 {
-	while ((irq = cpm2_get_irq(regs)) >= 0) {
-		ppc_irq_dispatch_handler(regs, irq);
-	}
+	while ((irq = cpm2_get_irq(regs)) >= 0)
+		__do_IRQ(irq, regs);
 	return IRQ_HANDLED;
 }
 
--- linux/arch/ppc/platforms/adir_pic.c.orig
+++ linux/arch/ppc/platforms/adir_pic.c
@@ -11,7 +11,7 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/pci.h>
-#include <linux/irq.h>
+#include <linux/interrupt.h>
 
 #include <asm/io.h>
 #include <asm/i8259.h>
@@ -20,11 +20,6 @@
 static void adir_onboard_pic_enable(unsigned int irq);
 static void adir_onboard_pic_disable(unsigned int irq);
 
-static void
-no_action(int cpl, void *dev_id, struct pt_regs *regs)
-{
-}
-
 __init static void
 adir_onboard_pic_init(void)
 {
@@ -88,6 +83,13 @@ static struct hw_interrupt_type adir_onb
 	NULL
 };
 
+static struct irqaction noop_action = {
+	.handler	= no_action,
+	.flags          = SA_INTERRUPT,
+	.mask           = CPU_MASK_NONE,
+	.name           = "82c59 primary cascade",
+};
+
 /*
  * Linux interrupt values are assigned as follows:
  *
@@ -110,11 +112,7 @@ adir_init_IRQ(void)
 	adir_onboard_pic_init();
 
 	/* Enable 8259 interrupt cascade */
-	request_irq(ADIR_IRQ_VT82C686_INTR,
-			no_action,
-			SA_INTERRUPT,
-			"82c59 primary cascade",
-			NULL);
+	setup_irq(ADIR_IRQ_VT82C686_INTR, &noop_action);
 }
 
 int
--- linux/arch/ppc/platforms/sbc82xx.c.orig
+++ linux/arch/ppc/platforms/sbc82xx.c
@@ -142,7 +142,7 @@ static irqreturn_t sbc82xx_i8259_demux(i
 			return IRQ_HANDLED;
 		}
 	}
-	ppc_irq_dispatch_handler(regs, NR_SIU_INTS + irq);
+	__do_IRQ(NR_SIU_INTS + irq, regs);
 	return IRQ_HANDLED;
 }
 
--- linux/include/asm-ppc/irq.h.orig
+++ linux/include/asm-ppc/irq.h
@@ -6,10 +6,6 @@
 #include <asm/machdep.h>		/* ppc_md */
 #include <asm/atomic.h>
 
-extern void disable_irq(unsigned int);
-extern void disable_irq_nosync(unsigned int);
-extern void enable_irq(unsigned int);
-
 /*
  * These constants are used for passing information about interrupt
  * signal polarity and level/edge sensing to the low-level PIC chip
--- linux/include/asm-ppc/hardirq.h.orig
+++ linux/include/asm-ppc/hardirq.h
@@ -21,46 +21,11 @@ typedef struct {
 
 #define last_jiffy_stamp(cpu) __IRQ_STAT((cpu), __last_jiffy_stamp)
 
-/*
- * We put the hardirq and softirq counter into the preemption
- * counter. The bitmask has the following meaning:
- *
- * - bits 0-7 are the preemption count (max preemption depth: 256)
- * - bits 8-15 are the softirq count (max # of softirqs: 256)
- * - bits 16-23 are the hardirq count (max # of hardirqs: 256)
- *
- * - ( bit 26 is the PREEMPT_ACTIVE flag. )
- *
- * PREEMPT_MASK: 0x000000ff
- * SOFTIRQ_MASK: 0x0000ff00
- * HARDIRQ_MASK: 0x00ff0000
- */
-
-#define PREEMPT_BITS	8
-#define SOFTIRQ_BITS	8
-#define HARDIRQ_BITS	8
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
-	preempt_count() -= IRQ_EXIT_OFFSET;				\
-	if (!in_interrupt() && softirq_pending(smp_processor_id()))	\
-		do_softirq();						\
-	preempt_enable_no_resched();					\
-} while (0)
+static inline void ack_bad_irq(int irq)
+{
+	printk(KERN_CRIT "illegal vector %d received!\n", irq);
+	BUG();
+}
 
 #endif /* __ASM_HARDIRQ_H */
 #endif /* __KERNEL__ */
--- linux/include/asm-ppc/hw_irq.h.orig
+++ linux/include/asm-ppc/hw_irq.h
@@ -9,7 +9,6 @@
 #include <asm/reg.h>
 
 extern void timer_interrupt(struct pt_regs *);
-extern void ppc_irq_dispatch_handler(struct pt_regs *regs, int irq);
 
 #define INLINE_IRQS
 
