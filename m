Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267592AbUHWWfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267592AbUHWWfK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 18:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267840AbUHWWc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 18:32:26 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:21229 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S267532AbUHWWS3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 18:18:29 -0400
Date: Mon, 23 Aug 2004 18:18:16 -0400
To: mingo@elte.hu
Cc: manas.saksena@timesys.com, linux-kernel@vger.kernel.org
Subject: [patch] PPC/PPC64 port of voluntary preempt patch
Message-ID: <20040823221816.GA31671@yoda.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have attached a port of the voluntary preempt patch to PPC and
PPC64.  The patch is against P7, but it applies against P8 as well.

I've tested it on a dual G5 Mac, both in uniprocessor and SMP.

Some notes on changes to the generic part of the patch/existing
generic code:

	I changed the generic code so that request_irq() prior to the
	scheduler being ready to run.  Previously, if this happened,
	it'd try to spawn a thread anyway, and oops.
	
	I changed the no-op definitions of voluntary_resched() and such
	to be empty inline functions, rather than #defined to 0.  When 0
	is used, newer GCCs (I'm using 3.4.1) issue a warning about
	statements with no effect.  Due to this, I removed the redundant
	definition of voluntary_resched() from sched.h (it's also in
	kernel.h, which is always included by sched.h).  Does it need to
	be in kernel.h?
	
	The WARN_ON(system_state == SYSTEM_BOOTING) was flooding me
	with warnings; this stopped when I moved the setting of
	system_state before the init thread was started (it seems
	rather odd that one would not be able to schedule when creating
	a thread...).
	
	The latency tracker at one point used cpu_khz/1000, and at another
	used cpu_khz/1024.  Is there a reason why cycles_to_usecs isn't
	used in both places?
	
	It's not exactly related to PPC, but I changed 
	if (latency < preempt_max_latency) to use <= instead, as I was
	getting the same latency printed out over and over.
	
I haven't (yet) fixed any of the specific latencies I've found on the
Mac; this patch just supplies the generic functionality.

Signed-off-by: Scott Wood <scott.wood@timesys.com>

diff -urN vpP7/arch/ppc/Kconfig vpP7-ppc/arch/ppc/Kconfig
--- vpP7/arch/ppc/Kconfig	2004-08-17 15:22:33.000000000 -0400
+++ vpP7-ppc/arch/ppc/Kconfig	2004-08-23 13:57:14.000000000 -0400
@@ -808,6 +808,19 @@
 	  Say Y here if you are building a kernel for a desktop, embedded
 	  or real-time system.  Say N if you are unsure.
 
+config PREEMPT_VOLUNTARY
+	bool "Voluntary Kernel Preemption"
+	default y
+	help
+	  This option reduces the latency of the kernel by adding more
+	  "explicit preemption points" to the kernel code. These new
+	  preemption points have been selected to minimize the maximum
+	  latency of rescheduling, providing faster application reactions.
+
+	  Say Y here if you are building a kernel for a desktop system.
+	  Say N if you are unsure.
+
+
 config HIGHMEM
 	bool "High memory support"
 
diff -urN vpP7/arch/ppc/kernel/entry.S vpP7-ppc/arch/ppc/kernel/entry.S
--- vpP7/arch/ppc/kernel/entry.S	2004-08-17 15:22:33.000000000 -0400
+++ vpP7-ppc/arch/ppc/kernel/entry.S	2004-08-23 13:57:14.000000000 -0400
@@ -610,6 +610,11 @@
 
 /* N.B. the only way to get here is from the beq following ret_from_except. */
 resume_kernel:
+	lis	r9, kernel_preemption@ha
+	lwz	r9, kernel_preemption@l(r9)
+	cmpwi	r9, 0
+	bne	restore
+
 	/* check current_thread_info->preempt_count */
 	rlwinm	r9,r1,0,0,18
 	lwz	r0,TI_PREEMPT(r9)
diff -urN vpP7/arch/ppc/kernel/irq.c vpP7-ppc/arch/ppc/kernel/irq.c
--- vpP7/arch/ppc/kernel/irq.c	2004-08-17 15:22:33.000000000 -0400
+++ vpP7-ppc/arch/ppc/kernel/irq.c	2004-08-23 13:57:14.000000000 -0400
@@ -64,8 +64,6 @@
 void enable_irq(unsigned int irq_nr);
 void disable_irq(unsigned int irq_nr);
 
-static void register_irq_proc (unsigned int irq);
-
 #define MAXCOUNT 10000000
 
 irq_desc_t irq_desc[NR_IRQS] __cacheline_aligned = {
@@ -100,6 +98,7 @@
 	unsigned int i;
 	if ( mem_init_done )
 		return kmalloc(size,pri);
+		
 	for ( i = 0; i < IRQ_KMALLOC_ENTRIES ; i++ )
 		if ( ! ( cache_bitmask & (1<<i) ) )
 		{
@@ -121,107 +120,6 @@
 	kfree(ptr);
 }
 
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
 int request_irq(unsigned int irq,
 	irqreturn_t (*handler)(int, void *, struct pt_regs *),
 	unsigned long irqflags, const char * devname, void *dev_id)
@@ -262,95 +160,6 @@
 
 EXPORT_SYMBOL(request_irq);
 
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
@@ -410,24 +219,6 @@
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
@@ -482,6 +273,8 @@
 	if (unlikely(!action))
 		goto out;
 
+	if (generic_redirect_hardirq(desc))
+		goto out_no_end;
 
 	/*
 	 * Edge triggered interrupts need to remember
@@ -494,10 +287,14 @@
 	 * SMP environment.
 	 */
 	for (;;) {
+		irqreturn_t action_ret;
+	
 		spin_unlock(&desc->lock);
-		handle_irq_event(irq, regs, action);
+		action_ret = generic_handle_IRQ_event(irq, regs, action);
 		spin_lock(&desc->lock);
-
+		
+		if (!noirqdebug)
+			generic_note_interrupt(irq, desc, action_ret);
 		if (likely(!(desc->status & IRQ_PENDING)))
 			break;
 		desc->status &= ~IRQ_PENDING;
@@ -514,13 +311,15 @@
 		else if (irq_desc[irq].handler->enable)
 			irq_desc[irq].handler->enable(irq);
 	}
+
+out_no_end:
 	spin_unlock(&desc->lock);
 }
 
 void do_IRQ(struct pt_regs *regs)
 {
 	int irq, first = 1;
-        irq_enter();
+	irq_enter();
 
 	/*
 	 * Every platform is required to implement ppc_md.get_irq.
@@ -537,7 +336,7 @@
 	if (irq != -2 && first)
 		/* That's not SMP safe ... but who cares ? */
 		ppc_spurious_interrupts++;
-        irq_exit();
+	irq_exit();
 }
 
 unsigned long probe_irq_on (void)
@@ -559,148 +358,6 @@
 	return 0;
 }
 
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
-static int prof_cpu_mask_read_proc (char *page, char **start, off_t off,
-			int count, int *eof, void *data)
-{
-	int len = cpumask_scnprintf(page, count, *(cpumask_t *)data);
-	if (count - len < 2)
-		return -EINVAL;
-	len += sprintf(page + len, "\n");
-	return len;
-}
-
-static int prof_cpu_mask_write_proc (struct file *file, const char __user *buffer,
-					unsigned long count, void *data)
-{
-	int err;
-	int full_count = count;
-	cpumask_t *mask = (cpumask_t *)data;
-	cpumask_t new_value;
-
-	err = cpumask_parse(buffer, count, new_value);
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
-	root_irq_dir = proc_mkdir("irq", NULL);
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
 irqreturn_t no_action(int irq, void *dev, struct pt_regs *regs)
 {
 	return IRQ_NONE;
@@ -708,10 +365,7 @@
 
 void __init init_IRQ(void)
 {
-	int i;
-
-	for (i = 0; i < NR_IRQS; ++i)
-		irq_affinity[i] = DEFAULT_CPU_AFFINITY;
-
 	ppc_md.init_IRQ();
 }
+
+struct hw_interrupt_type no_irq_type;
diff -urN vpP7/arch/ppc/kernel/misc.S vpP7-ppc/arch/ppc/kernel/misc.S
--- vpP7/arch/ppc/kernel/misc.S	2004-08-17 15:22:33.000000000 -0400
+++ vpP7-ppc/arch/ppc/kernel/misc.S	2004-08-23 16:07:29.000000000 -0400
@@ -1165,6 +1165,60 @@
 _GLOBAL(__main)
 	blr
 
+#ifdef CONFIG_LATENCY_TRACE
+
+_GLOBAL(_mcount)
+	stwu	r1, -48(r1)
+
+	stw	r3, 8(r1)
+	stw	r4, 12(r1)
+	stw	r5, 16(r1)
+	stw	r6, 20(r1)
+	stw	r7, 24(r1)
+	stw	r8, 28(r1)
+	stw	r9, 32(r1)
+	stw	r10, 36(r1)
+
+	mflr	r3
+	stw	r3, 40(r1)
+
+	mfcr	r0
+	stw	r0, 44(r1)
+
+	lwz	r4, 52(r1)
+
+	// Don't call do_mcount if we haven't relocated to 0xc0000000 yet.
+	// This assumes that the ordinary load address is below
+	// 0x80000000.
+
+	andis.	r0, r3, 0x8000
+	beq-	mcount_out
+	bl	do_mcount
+mcount_out:
+
+	lwz	r3, 8(r1)
+	lwz	r4, 12(r1)
+	lwz	r5, 16(r1)
+	lwz	r6, 20(r1)
+	lwz	r7, 24(r1)
+	lwz	r8, 28(r1)
+	lwz	r9, 32(r1)
+	lwz	r10, 36(r1)
+
+	lwz	r0, 40(r1)
+	mtctr	r0
+
+	lwz	r0, 44(r1)
+	mtcr	r0
+
+	lwz	r0, 52(r1)
+	mtlr	r0
+
+	addi	r1, r1, 48
+	bctr
+
+#endif
+
 #define SYSCALL(name) \
 _GLOBAL(name) \
 	li	r0,__NR_##name; \
diff -urN vpP7/arch/ppc/kernel/ppc_ksyms.c vpP7-ppc/arch/ppc/kernel/ppc_ksyms.c
--- vpP7/arch/ppc/kernel/ppc_ksyms.c	2004-08-17 15:22:33.000000000 -0400
+++ vpP7-ppc/arch/ppc/kernel/ppc_ksyms.c	2004-08-23 13:57:14.000000000 -0400
@@ -84,9 +84,6 @@
 EXPORT_SYMBOL(sys_sigreturn);
 EXPORT_SYMBOL(ppc_n_lost_interrupts);
 EXPORT_SYMBOL(ppc_lost_interrupts);
-EXPORT_SYMBOL(enable_irq);
-EXPORT_SYMBOL(disable_irq);
-EXPORT_SYMBOL(disable_irq_nosync);
 EXPORT_SYMBOL(probe_irq_mask);
 
 EXPORT_SYMBOL(ISA_DMA_THRESHOLD);
@@ -205,7 +202,6 @@
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL(smp_call_function);
 EXPORT_SYMBOL(smp_hw_index);
-EXPORT_SYMBOL(synchronize_irq);
 #endif
 
 EXPORT_SYMBOL(ppc_md);
diff -urN vpP7/arch/ppc/platforms/pmac_pic.c vpP7-ppc/arch/ppc/platforms/pmac_pic.c
--- vpP7/arch/ppc/platforms/pmac_pic.c	2004-08-17 15:22:33.000000000 -0400
+++ vpP7-ppc/arch/ppc/platforms/pmac_pic.c	2004-08-23 13:57:14.000000000 -0400
@@ -440,8 +440,9 @@
 				OpenPIC_InitSenses = senses;
 				OpenPIC_NumInitSenses = 128;
 				openpic2_init(PMAC_OPENPIC2_OFFSET);
-				if (request_irq(irqctrler2->intrs[0].line, k2u3_action, 0,
-						"U3->K2 Cascade", NULL))
+				if (request_irq(irqctrler2->intrs[0].line, k2u3_action,
+				                SA_NODELAY | SA_INTERRUPT,
+				                "U3->K2 Cascade", NULL))
 					printk("Unable to get OpenPIC IRQ for cascade\n");
 			}
 #endif /* CONFIG_POWER4 */
@@ -455,7 +456,7 @@
 				if (pswitch && pswitch->n_intrs) {
 					nmi_irq = pswitch->intrs[0].line;
 					openpic_init_nmi_irq(nmi_irq);
-					request_irq(nmi_irq, xmon_irq, 0,
+					request_irq(nmi_irq, xmon_irq, SA_NODELAY,
 						    "NMI - XMON", NULL);
 				}
 			}
@@ -553,7 +554,7 @@
 			(int)irq_cascade);
 		for ( i = max_real_irqs ; i < max_irqs ; i++ )
 			irq_desc[i].handler = &gatwick_pic;
-		request_irq( irq_cascade, gatwick_action, SA_INTERRUPT,
+		request_irq( irq_cascade, gatwick_action, SA_INTERRUPT | SA_NODELAY,
 			     "cascade", NULL );
 	}
 	printk("System has %d possible interrupts\n", max_irqs);
@@ -562,7 +563,7 @@
 			max_real_irqs);
 
 #ifdef CONFIG_XMON
-	request_irq(20, xmon_irq, 0, "NMI - XMON", NULL);
+	request_irq(20, xmon_irq, SA_NODELAY, "NMI - XMON", NULL);
 #endif	/* CONFIG_XMON */
 }
 
diff -urN vpP7/arch/ppc/platforms/sbc82xx.c vpP7-ppc/arch/ppc/platforms/sbc82xx.c
--- vpP7/arch/ppc/platforms/sbc82xx.c	2004-08-17 15:22:34.000000000 -0400
+++ vpP7-ppc/arch/ppc/platforms/sbc82xx.c	2004-08-23 13:57:14.000000000 -0400
@@ -212,7 +212,7 @@
 	sbc82xx_i8259_map[1] = sbc82xx_i8259_mask; /* Set interrupt mask */
 
 	/* Request cascade IRQ */
-	if (request_irq(SIU_INT_IRQ6, sbc82xx_i8259_demux, SA_INTERRUPT,
+	if (request_irq(SIU_INT_IRQ6, sbc82xx_i8259_demux, SA_INTERRUPT | SA_NODELAY,
 			"i8259 demux", 0)) {
 		printk("Installation of i8259 IRQ demultiplexer failed.\n");
 	}
diff -urN vpP7/arch/ppc/syslib/i8259.c vpP7-ppc/arch/ppc/syslib/i8259.c
--- vpP7/arch/ppc/syslib/i8259.c	2004-06-16 01:19:22.000000000 -0400
+++ vpP7-ppc/arch/ppc/syslib/i8259.c	2004-08-23 13:57:14.000000000 -0400
@@ -185,7 +185,7 @@
 	spin_unlock_irqrestore(&i8259_lock, flags);
 
 	/* reserve our resources */
-	request_irq( i8259_pic_irq_offset + 2, no_action, SA_INTERRUPT,
+	request_irq( i8259_pic_irq_offset + 2, no_action, SA_INTERRUPT | SA_NODELAY,
 				"82c59 secondary cascade", NULL );
 	request_resource(&ioport_resource, &pic1_iores);
 	request_resource(&ioport_resource, &pic2_iores);
diff -urN vpP7/arch/ppc/syslib/m8xx_setup.c vpP7-ppc/arch/ppc/syslib/m8xx_setup.c
--- vpP7/arch/ppc/syslib/m8xx_setup.c	2004-06-16 01:19:22.000000000 -0400
+++ vpP7-ppc/arch/ppc/syslib/m8xx_setup.c	2004-08-23 13:57:14.000000000 -0400
@@ -281,7 +281,8 @@
                 irq_desc[i].handler = &i8259_pic;
         i8259_pic.irq_offset = NR_SIU_INTS;
         i8259_init();
-        request_8xxirq(ISA_BRIDGE_INT, mbx_i8259_action, 0, "8259 cascade", NULL);
+        request_8xxirq(ISA_BRIDGE_INT, mbx_i8259_action,
+                       SA_INTERRUPT | SA_NODELAY, "8259 cascade", NULL);
         enable_irq(ISA_BRIDGE_INT);
 #endif
 }
diff -urN vpP7/arch/ppc/syslib/open_pic.c vpP7-ppc/arch/ppc/syslib/open_pic.c
--- vpP7/arch/ppc/syslib/open_pic.c	2004-08-17 15:22:34.000000000 -0400
+++ vpP7-ppc/arch/ppc/syslib/open_pic.c	2004-08-23 13:57:14.000000000 -0400
@@ -580,16 +580,16 @@
 
 	/* IPIs are marked SA_INTERRUPT as they must run with irqs disabled */
 	request_irq(OPENPIC_VEC_IPI+open_pic_irq_offset,
-		    openpic_ipi_action, SA_INTERRUPT,
+		    openpic_ipi_action, SA_INTERRUPT | SA_NODELAY,
 		    "IPI0 (call function)", NULL);
 	request_irq(OPENPIC_VEC_IPI+open_pic_irq_offset+1,
-		    openpic_ipi_action, SA_INTERRUPT,
+		    openpic_ipi_action, SA_INTERRUPT | SA_NODELAY,
 		    "IPI1 (reschedule)", NULL);
 	request_irq(OPENPIC_VEC_IPI+open_pic_irq_offset+2,
-		    openpic_ipi_action, SA_INTERRUPT,
+		    openpic_ipi_action, SA_INTERRUPT | SA_NODELAY,
 		    "IPI2 (invalidate tlb)", NULL);
 	request_irq(OPENPIC_VEC_IPI+open_pic_irq_offset+3,
-		    openpic_ipi_action, SA_INTERRUPT,
+		    openpic_ipi_action, SA_INTERRUPT | SA_NODELAY,
 		    "IPI3 (xmon break)", NULL);
 
 	for ( i = 0; i < OPENPIC_NUM_IPI ; i++ )
@@ -687,7 +687,7 @@
 {
 	openpic_cascade_irq = irq;
 	openpic_cascade_fn = cascade_fn;
-	if (request_irq(irq, no_action, SA_INTERRUPT, name, NULL))
+	if (request_irq(irq, no_action, SA_INTERRUPT | SA_NODELAY, name, NULL))
 		printk("Unable to get OpenPIC IRQ %d for cascade\n",
 				irq - open_pic_irq_offset);
 }
@@ -798,6 +798,10 @@
 }
 #endif /* notused */
 
+#ifdef CONFIG_PREEMPT_VOLUNTARY
+#define __SLOW_VERSION__
+#endif
+
 /* No spinlocks, should not be necessary with the OpenPIC
  * (1 register = 1 interrupt and we have the desc lock).
  */
diff -urN vpP7/arch/ppc64/Kconfig vpP7-ppc/arch/ppc64/Kconfig
--- vpP7/arch/ppc64/Kconfig	2004-08-17 15:22:34.000000000 -0400
+++ vpP7-ppc/arch/ppc64/Kconfig	2004-08-23 14:39:44.000000000 -0400
@@ -206,6 +206,18 @@
 	  Say Y here if you are building a kernel for a desktop, embedded
 	  or real-time system.  Say N if you are unsure.
 
+config PREEMPT_VOLUNTARY
+	bool "Voluntary Kernel Preemption"
+	default y
+	help
+	  This option reduces the latency of the kernel by adding more
+	  "explicit preemption points" to the kernel code. These new
+	  preemption points have been selected to minimize the maximum
+	  latency of rescheduling, providing faster application reactions.
+
+	  Say Y here if you are building a kernel for a desktop system.
+	  Say N if you are unsure.
+
 config MSCHUNKS
 	bool
 	depends on PPC_ISERIES
diff -urN vpP7/arch/ppc64/kernel/entry.S vpP7-ppc/arch/ppc64/kernel/entry.S
--- vpP7/arch/ppc64/kernel/entry.S	2004-08-17 15:22:34.000000000 -0400
+++ vpP7-ppc/arch/ppc64/kernel/entry.S	2004-08-23 13:57:14.000000000 -0400
@@ -548,6 +548,12 @@
 #ifdef CONFIG_PREEMPT
 	andi.	r0,r3,MSR_PR	/* Returning to user mode? */
 	bne	user_work
+
+	LOADBASE(r8, kernel_preemption)
+	lwz	r8, kernel_preemption@l(r8)
+	cmpwi	r8, 0
+	bne	restore
+
 	/* Check that preempt_count() == 0 and interrupts are enabled */
 	lwz	r8,TI_PREEMPT(r9)
 	cmpwi	cr1,r8,0
diff -urN vpP7/arch/ppc64/kernel/i8259.c vpP7-ppc/arch/ppc64/kernel/i8259.c
--- vpP7/arch/ppc64/kernel/i8259.c	2004-06-16 01:20:26.000000000 -0400
+++ vpP7-ppc/arch/ppc64/kernel/i8259.c	2004-08-23 13:57:14.000000000 -0400
@@ -160,7 +160,7 @@
         outb(cached_A1, 0xA1);
         outb(cached_21, 0x21);
 	spin_unlock_irqrestore(&i8259_lock, flags);
-        request_irq( i8259_pic_irq_offset + 2, no_action, SA_INTERRUPT,
+        request_irq( i8259_pic_irq_offset + 2, no_action, SA_INTERRUPT | SA_NODELAY,
                      "82c59 secondary cascade", NULL );
         
 }
diff -urN vpP7/arch/ppc64/kernel/irq.c vpP7-ppc/arch/ppc64/kernel/irq.c
--- vpP7/arch/ppc64/kernel/irq.c	2004-08-17 15:22:34.000000000 -0400
+++ vpP7-ppc/arch/ppc64/kernel/irq.c	2004-08-23 13:57:14.000000000 -0400
@@ -59,8 +59,6 @@
 extern void iSeries_smp_message_recv( struct pt_regs * );
 #endif
 
-static void register_irq_proc (unsigned int irq);
-
 irq_desc_t irq_desc[NR_IRQS] __cacheline_aligned = {
 	[0 ... NR_IRQS-1] = {
 		.lock = SPIN_LOCK_UNLOCKED
@@ -71,78 +69,6 @@
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
 int request_irq(unsigned int irq,
 	irqreturn_t (*handler)(int, void *, struct pt_regs *),
 	unsigned long irqflags, const char * devname, void *dev_id)
@@ -152,8 +78,10 @@
 
 	if (irq >= NR_IRQS)
 		return -EINVAL;
-	if (!handler)
-		return -EINVAL;
+	if (!handler) {
+		free_irq(irq, dev_id);
+		return 0;
+	}
 
 	action = (struct irqaction *)
 		kmalloc(sizeof(struct irqaction), GFP_KERNEL);
@@ -178,140 +106,6 @@
 
 EXPORT_SYMBOL(request_irq);
 
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
@@ -359,106 +153,6 @@
 	return 0;
 }
 
-int handle_irq_event(int irq, struct pt_regs *regs, struct irqaction *action)
-{
-	int status = 0;
-	int retval = 0;
-
-	if (!(action->flags & SA_INTERRUPT))
-		local_irq_enable();
-
-	do {
-		status |= action->flags;
-		retval |= action->handler(irq, action->dev_id, regs);
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
-
 /*
  * Eventually, this should take an array of interrupts and an array size
  * so it can dispatch multiple interrupts.
@@ -479,7 +173,7 @@
 	if (desc->status & IRQ_PER_CPU) {
 		/* no locking required for CPU-local interrupts: */
 		ack_irq(irq);
-		action_ret = handle_irq_event(irq, regs, desc->action);
+		action_ret = generic_handle_IRQ_event(irq, regs, desc->action);
 		desc->handler->end(irq);
 		return;
 	}
@@ -527,6 +221,9 @@
 	if (unlikely(!action))
 		goto out;
 
+	if (generic_redirect_hardirq(desc))
+		goto out_no_end;
+
 	/*
 	 * Edge triggered interrupts need to remember
 	 * pending events.
@@ -553,11 +250,11 @@
 				set_bits(irqtp->flags, &curtp->flags);
 		} else
 #endif
-			action_ret = handle_irq_event(irq, regs, action);
+			action_ret = generic_handle_IRQ_event(irq, regs, action);
 
 		spin_lock(&desc->lock);
 		if (!noirqdebug)
-			note_interrupt(irq, desc, action_ret);
+			generic_note_interrupt(irq, desc, action_ret);
 		if (likely(!(desc->status & IRQ_PENDING)))
 			break;
 		desc->status &= ~IRQ_PENDING;
@@ -574,6 +271,8 @@
 		else if (desc->handler->enable)
 			desc->handler->enable(irq);
 	}
+
+out_no_end:
 	spin_unlock(&desc->lock);
 }
 
@@ -687,174 +386,6 @@
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
-static int prof_cpu_mask_read_proc (char *page, char **start, off_t off,
-			int count, int *eof, void *data)
-{
-	int len = cpumask_scnprintf(page, count, *(cpumask_t *)data);
-	if (count - len < 2)
-		return -EINVAL;
-	len += sprintf(page + len, "\n");
-	return len;
-}
-
-static int prof_cpu_mask_write_proc (struct file *file, const char __user *buffer,
-					unsigned long count, void *data)
-{
-	cpumask_t *mask = (cpumask_t *)data;
-	unsigned long full_count = count, err;
-	cpumask_t new_value;
-
-	err = cpumask_parse(buffer, count, new_value);
-	if (err)
-		return err;
-
-	*mask = new_value;
-
-#ifdef CONFIG_PPC_ISERIES
-	{
-		unsigned i;
-		for (i=0; i<NR_CPUS; ++i) {
-			if ( paca[i].prof_buffer && cpu_isset(i, new_value) )
-				paca[i].prof_enabled = 1;
-			else
-				paca[i].prof_enabled = 0;
-		}
-	}
-#endif
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
-unsigned long prof_cpu_mask = -1;
-
-void init_irq_proc (void)
-{
-	struct proc_dir_entry *entry;
-	int i;
-
-	/* create /proc/irq */
-	root_irq_dir = proc_mkdir("irq", NULL);
-
-	/* create /proc/irq/prof_cpu_mask */
-	entry = create_proc_entry("prof_cpu_mask", 0600, root_irq_dir);
-
-	if (!entry)
-		return;
-
-	entry->nlink = 1;
-	entry->data = (void *)&prof_cpu_mask;
-	entry->read_proc = prof_cpu_mask_read_proc;
-	entry->write_proc = prof_cpu_mask_write_proc;
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
 irqreturn_t no_action(int irq, void *dev, struct pt_regs *regs)
 {
 	return IRQ_NONE;
@@ -1014,3 +545,4 @@
 
 #endif /* CONFIG_IRQSTACKS */
 
+struct hw_interrupt_type no_irq_type;
diff -urN vpP7/arch/ppc64/kernel/misc.S vpP7-ppc/arch/ppc64/kernel/misc.S
--- vpP7/arch/ppc64/kernel/misc.S	2004-08-17 15:22:34.000000000 -0400
+++ vpP7-ppc/arch/ppc64/kernel/misc.S	2004-08-23 17:27:11.000000000 -0400
@@ -120,7 +120,7 @@
 	std	r0,16(r1)
 	stdu	r1,THREAD_SIZE-112(r6)
 	mr	r1,r6
-	bl	.handle_irq_event
+	bl	.generic_handle_IRQ_event
 	ld	r1,0(r1)
 	ld	r0,16(r1)
 	mtlr	r0
@@ -600,6 +600,35 @@
 	ld	r30,-16(r1)
 	blr
 
+#ifdef CONFIG_LATENCY_TRACE
+
+_GLOBAL(_mcount)
+	ld	r5, 0(r1)
+	mflr	r3
+	stdu	r1, -112(r1)
+	ld	r4, 16(r5)
+	std	r3, 128(r1)
+
+	// Don't call do_mcount if we haven't relocated to
+	// 0xc000000000000000 yet.  This assumes that the ordinary
+	// load address is below 0x8000000000000000.
+
+	lis	r6, 0x8000
+	rldicr	r6, r6, 32, 31
+	and.	r0, r3, r6
+	
+	beq-	mcount_out
+	bl	.do_mcount
+mcount_out:
+
+	ld	r0, 128(r1)
+	mtlr	r0
+
+	addi	r1, r1, 112
+	blr
+
+#endif
+
 #ifdef CONFIG_PPC_ISERIES	/* hack hack hack */
 #define ppc_rtas	sys_ni_syscall
 #endif
diff -urN vpP7/arch/ppc64/kernel/open_pic.c vpP7-ppc/arch/ppc64/kernel/open_pic.c
--- vpP7/arch/ppc64/kernel/open_pic.c	2004-08-17 15:22:34.000000000 -0400
+++ vpP7-ppc/arch/ppc64/kernel/open_pic.c	2004-08-23 16:44:16.000000000 -0400
@@ -78,6 +78,12 @@
 
 OpenPIC_SourcePtr ISU[OPENPIC_MAX_ISU];
 
+#ifdef CONFIG_PREEMPT_VOLUNTARY
+static void openpic_ack_irq(unsigned int irq);
+#else
+#define openpic_ack_irq NULL
+#endif
+
 static void openpic_end_irq(unsigned int irq_nr);
 static void openpic_set_affinity(unsigned int irq_nr, cpumask_t cpumask);
 
@@ -87,7 +93,7 @@
 	NULL,
 	openpic_enable_irq,
 	openpic_disable_irq,
-	NULL,
+	openpic_ack_irq,
 	openpic_end_irq,
 	openpic_set_affinity
 };
@@ -440,7 +446,7 @@
 
 	if (naca->interrupt_controller == IC_OPEN_PIC) {
 		/* Initialize the cascade */
-		if (request_irq(NUM_ISA_INTERRUPTS, no_action, SA_INTERRUPT,
+		if (request_irq(NUM_ISA_INTERRUPTS, no_action, SA_INTERRUPT | SA_NODELAY,
 				"82c59 cascade", NULL))
 			printk(KERN_ERR "Unable to get OpenPIC IRQ 0 for cascade\n");
 		i8259_init();
@@ -641,13 +647,13 @@
 		return;
 
 	/* IPIs are marked SA_INTERRUPT as they must run with irqs disabled */
-	request_irq(openpic_vec_ipi, openpic_ipi_action, SA_INTERRUPT,
+	request_irq(openpic_vec_ipi, openpic_ipi_action, SA_INTERRUPT | SA_NODELAY,
 		    "IPI0 (call function)", NULL);
-	request_irq(openpic_vec_ipi+1, openpic_ipi_action, SA_INTERRUPT,
+	request_irq(openpic_vec_ipi+1, openpic_ipi_action, SA_INTERRUPT | SA_NODELAY,
 		   "IPI1 (reschedule)", NULL);
-	request_irq(openpic_vec_ipi+2, openpic_ipi_action, SA_INTERRUPT,
+	request_irq(openpic_vec_ipi+2, openpic_ipi_action, SA_INTERRUPT | SA_NODELAY,
 		   "IPI2 (unused)", NULL);
-	request_irq(openpic_vec_ipi+3, openpic_ipi_action, SA_INTERRUPT,
+	request_irq(openpic_vec_ipi+3, openpic_ipi_action, SA_INTERRUPT | SA_NODELAY,
 		   "IPI3 (debugger break)", NULL);
 
 	for ( i = 0; i < OPENPIC_NUM_IPI ; i++ )
@@ -834,11 +840,28 @@
 }
 #endif
 
+#ifdef CONFIG_PREEMPT_VOLUNTARY
+
+static void openpic_ack_irq(unsigned int irq_nr)
+{
+	openpic_disable_irq(irq_nr);
+	openpic_eoi();
+}
+
+static void openpic_end_irq(unsigned int irq_nr)
+{
+	openpic_enable_irq(irq_nr);
+}
+
+#else
+
 static void openpic_end_irq(unsigned int irq_nr)
 {
 	openpic_eoi();
 }
 
+#endif
+
 static void openpic_set_affinity(unsigned int irq_nr, cpumask_t cpumask)
 {
 	cpumask_t tmp;
diff -urN vpP7/arch/ppc64/kernel/open_pic_u3.c vpP7-ppc/arch/ppc64/kernel/open_pic_u3.c
--- vpP7/arch/ppc64/kernel/open_pic_u3.c	2004-06-16 01:18:37.000000000 -0400
+++ vpP7-ppc/arch/ppc64/kernel/open_pic_u3.c	2004-08-23 16:43:03.000000000 -0400
@@ -251,11 +251,30 @@
 				 (sense ? OPENPIC_SENSE_LEVEL : 0));
 }
 
+#ifdef CONFIG_PREEMPT_VOLUNTARY
+
+static void openpic2_ack_irq(unsigned int irq_nr)
+{
+	openpic2_disable_irq(irq_nr);
+	openpic2_eoi();
+}
+
+static void openpic2_end_irq(unsigned int irq_nr)
+{
+	openpic2_enable_irq(irq_nr);
+}
+
+#else
+
+#define openpic2_ack_irq NULL
+
 static void openpic2_end_irq(unsigned int irq_nr)
 {
 	openpic2_eoi();
 }
 
+#endif
+
 int openpic2_get_irq(struct pt_regs *regs)
 {
 	int irq = openpic2_irq();
@@ -271,7 +290,7 @@
 	NULL,
 	openpic2_enable_irq,
 	openpic2_disable_irq,
-	NULL,
+	openpic2_ack_irq,
 	openpic2_end_irq,
 };
 
diff -urN vpP7/arch/ppc64/kernel/pmac_setup.c vpP7-ppc/arch/ppc64/kernel/pmac_setup.c
--- vpP7/arch/ppc64/kernel/pmac_setup.c	2004-06-16 01:18:58.000000000 -0400
+++ vpP7-ppc/arch/ppc64/kernel/pmac_setup.c	2004-08-23 13:57:14.000000000 -0400
@@ -409,8 +409,8 @@
  */
 static int __init pmac_irq_cascade_init(void)
 {
-	if (request_irq(pmac_cascade_irq, pmac_u3_do_cascade, 0,
-			"U3->K2 Cascade", NULL))
+	if (request_irq(pmac_cascade_irq, pmac_u3_do_cascade,
+	                SA_NODELAY | SA_INTERRUPT, "U3->K2 Cascade", NULL))
 		printk(KERN_ERR "Unable to get OpenPIC IRQ for cascade\n");
 	return 0;
 }
diff -urN vpP7/arch/ppc64/kernel/xics.c vpP7-ppc/arch/ppc64/kernel/xics.c
--- vpP7/arch/ppc64/kernel/xics.c	2004-08-17 15:22:34.000000000 -0400
+++ vpP7-ppc/arch/ppc64/kernel/xics.c	2004-08-23 13:57:14.000000000 -0400
@@ -572,7 +572,7 @@
 	if (naca->interrupt_controller == IC_PPC_XIC &&
 	    xics_irq_8259_cascade != -1) {
 		if (request_irq(irq_offset_up(xics_irq_8259_cascade),
-				no_action, 0, "8259 cascade", NULL))
+				no_action, SA_NODELAY, "8259 cascade", NULL))
 			printk(KERN_ERR "xics_setup_i8259: couldn't get 8259 "
 					"cascade\n");
 		i8259_init();
@@ -587,7 +587,7 @@
 	virt_irq_to_real_map[XICS_IPI] = XICS_IPI;
 
 	/* IPIs are marked SA_INTERRUPT as they must run with irqs disabled */
-	request_irq(irq_offset_up(XICS_IPI), xics_ipi_action, SA_INTERRUPT,
+	request_irq(irq_offset_up(XICS_IPI), xics_ipi_action, SA_INTERRUPT | SA_NODELAY,
 		    "IPI", NULL);
 	get_irq_desc(irq_offset_up(XICS_IPI))->status |= IRQ_PER_CPU;
 }
diff -urN vpP7/include/asm-i386/hw_irq.h vpP7-ppc/include/asm-i386/hw_irq.h
--- vpP7/include/asm-i386/hw_irq.h	2004-08-23 13:41:28.000000000 -0400
+++ vpP7-ppc/include/asm-i386/hw_irq.h	2004-08-23 13:57:14.000000000 -0400
@@ -54,7 +54,6 @@
 void init_8259A(int aeoi);
 void FASTCALL(send_IPI_self(int vector));
 void init_VISWS_APIC_irqs(void);
-extern void init_hardirqs(void);
 void setup_IO_APIC(void);
 void disable_IO_APIC(void);
 void print_IO_APIC(void);
diff -urN vpP7/include/asm-ppc/hardirq.h vpP7-ppc/include/asm-ppc/hardirq.h
--- vpP7/include/asm-ppc/hardirq.h	2004-06-16 01:18:37.000000000 -0400
+++ vpP7-ppc/include/asm-ppc/hardirq.h	2004-08-23 13:57:14.000000000 -0400
@@ -5,7 +5,7 @@
 #include <linux/config.h>
 #include <linux/cache.h>
 #include <linux/smp_lock.h>
-#include <asm/irq.h>
+#include <linux/irq.h>
 
 /* The __last_jiffy_stamp field is needed to ensure that no decrementer
  * interrupt is lost on SMP machines. Since on most CPUs it is in the same
@@ -71,15 +71,11 @@
  * Are we doing bottom half or hardware interrupt processing?
  * Are we in a softirq context? Interrupt context?
  */
-#define in_irq()		(hardirq_count())
-#define in_softirq()		(softirq_count())
+#define in_irq()		(hardirq_count() || (current->flags & PF_HARDIRQ))
+#define in_softirq()		(softirq_count() || (current->flags & PF_SOFTIRQ))
 #define in_interrupt()		(irq_count())
 
-
-#define hardirq_trylock()	(!in_interrupt())
-#define hardirq_endlock()	do { } while (0)
-
-#define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
+#define irq_enter()		(add_preempt_count(HARDIRQ_OFFSET))
 
 #ifdef CONFIG_PREEMPT
 # define in_atomic()	((preempt_count() & ~PREEMPT_ACTIVE) != kernel_locked())
@@ -94,17 +90,41 @@
 
 #define irq_exit()							\
 do {									\
-	preempt_count() -= IRQ_EXIT_OFFSET;				\
+	sub_preempt_count(IRQ_EXIT_OFFSET);				\
 	if (!in_interrupt() && softirq_pending(smp_processor_id()))	\
 		do_softirq();						\
 	preempt_enable_no_resched();					\
 } while (0)
 
-#ifndef CONFIG_SMP
-# define synchronize_irq(irq)	barrier()
-#else
-  extern void synchronize_irq(unsigned int irq);
-#endif /* CONFIG_SMP */
+static inline void synchronize_irq(unsigned int irq)
+{
+	generic_synchronize_irq(irq);
+}
+
+static inline void free_irq(unsigned int irq, void *dev_id)
+{
+	generic_free_irq(irq, dev_id);
+}
+
+static inline void disable_irq_nosync(unsigned int irq)
+{
+	generic_disable_irq_nosync(irq);
+}
+
+static inline void disable_irq(unsigned int irq)
+{
+	generic_disable_irq(irq);
+}
+
+static inline void enable_irq(unsigned int irq)
+{
+	generic_enable_irq(irq);
+}
+
+static inline int setup_irq(unsigned int irq, struct irqaction *action)
+{
+	return generic_setup_irq(irq, action);
+}
 
 #endif /* __ASM_HARDIRQ_H */
 #endif /* __KERNEL__ */
diff -urN vpP7/include/asm-ppc/irq.h vpP7-ppc/include/asm-ppc/irq.h
--- vpP7/include/asm-ppc/irq.h	2004-08-17 15:22:36.000000000 -0400
+++ vpP7-ppc/include/asm-ppc/irq.h	2004-08-23 13:57:14.000000000 -0400
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
@@ -324,7 +320,6 @@
 
 struct irqaction;
 struct pt_regs;
-int handle_IRQ_event(unsigned int, struct pt_regs *, struct irqaction *);
 
 #endif /* _ASM_IRQ_H */
 #endif /* __KERNEL__ */
diff -urN vpP7/include/asm-ppc/signal.h vpP7-ppc/include/asm-ppc/signal.h
--- vpP7/include/asm-ppc/signal.h	2004-08-17 15:22:36.000000000 -0400
+++ vpP7-ppc/include/asm-ppc/signal.h	2004-08-23 13:57:14.000000000 -0400
@@ -111,6 +111,7 @@
 #define SA_PROBE		SA_ONESHOT
 #define SA_SAMPLE_RANDOM	SA_RESTART
 #define SA_SHIRQ		0x04000000
+#define SA_NODELAY              0x02000000
 #endif /* __KERNEL__ */
 
 #define SIG_BLOCK          0	/* for blocking signals */
diff -urN vpP7/include/asm-ppc64/hardirq.h vpP7-ppc/include/asm-ppc64/hardirq.h
--- vpP7/include/asm-ppc64/hardirq.h	2004-08-17 15:22:36.000000000 -0400
+++ vpP7-ppc/include/asm-ppc64/hardirq.h	2004-08-23 13:57:14.000000000 -0400
@@ -12,6 +12,7 @@
 #include <linux/config.h>
 #include <linux/cache.h>
 #include <linux/preempt.h>
+#include <linux/irq.h>
 
 typedef struct {
 	unsigned int __softirq_pending;
@@ -70,15 +71,11 @@
  * Are we doing bottom half or hardware interrupt processing?
  * Are we in a softirq context? Interrupt context?
  */
-#define in_irq()		(hardirq_count())
-#define in_softirq()		(softirq_count())
+#define in_irq()		(hardirq_count() || (current->flags & PF_HARDIRQ))
+#define in_softirq()		(softirq_count() || (current->flags & PF_SOFTIRQ))
 #define in_interrupt()		(irq_count())
 
-
-#define hardirq_trylock()	(!in_interrupt())
-#define hardirq_endlock()	do { } while (0)
-
-#define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
+#define irq_enter()		(add_preempt_count(HARDIRQ_OFFSET))
 
 #ifdef CONFIG_PREEMPT
 # define in_atomic()	((preempt_count() & ~PREEMPT_ACTIVE) != kernel_locked())
@@ -89,20 +86,44 @@
 # define preemptible()	0
 # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
 #endif
+
 #define irq_exit()							\
 do {									\
-		preempt_count() -= IRQ_EXIT_OFFSET;			\
-		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
-			do_softirq();					\
-		preempt_enable_no_resched();				\
+	sub_preempt_count(IRQ_EXIT_OFFSET);				\
+	if (!in_interrupt() && softirq_pending(smp_processor_id()))	\
+		do_softirq();						\
+	preempt_enable_no_resched();					\
 } while (0)
 
-#ifndef CONFIG_SMP
-# define synchronize_irq(irq)	barrier()
-#else
-  extern void synchronize_irq(unsigned int irq);
-#endif /* CONFIG_SMP */
+static inline void synchronize_irq(unsigned int irq)
+{
+	generic_synchronize_irq(irq);
+}
+
+static inline void free_irq(unsigned int irq, void *dev_id)
+{
+	generic_free_irq(irq, dev_id);
+}
+
+static inline void disable_irq_nosync(unsigned int irq)
+{
+	generic_disable_irq_nosync(irq);
+}
+
+static inline void disable_irq(unsigned int irq)
+{
+	generic_disable_irq(irq);
+}
+
+static inline void enable_irq(unsigned int irq)
+{
+	generic_enable_irq(irq);
+}
+
+static inline int setup_irq(unsigned int irq, struct irqaction *action)
+{
+	return generic_setup_irq(irq, action);
+}
 
-#endif /* __KERNEL__ */
-	
 #endif /* __ASM_HARDIRQ_H */
+#endif /* __KERNEL__ */
diff -urN vpP7/include/asm-ppc64/irq.h vpP7-ppc/include/asm-ppc64/irq.h
--- vpP7/include/asm-ppc64/irq.h	2004-08-17 15:22:36.000000000 -0400
+++ vpP7-ppc/include/asm-ppc64/irq.h	2004-08-23 15:42:48.000000000 -0400
@@ -17,10 +17,6 @@
  */
 #define NR_IRQS		512
 
-extern void disable_irq(unsigned int);
-extern void disable_irq_nosync(unsigned int);
-extern void enable_irq(unsigned int);
-
 /* this number is used when no interrupt has been assigned */
 #define NO_IRQ			(-1)
 
@@ -80,7 +76,6 @@
 
 struct irqaction;
 struct pt_regs;
-int handle_irq_event(int, struct pt_regs *, struct irqaction *);
 
 #ifdef CONFIG_IRQSTACKS
 /*
diff -urN vpP7/include/asm-ppc64/signal.h vpP7-ppc/include/asm-ppc64/signal.h
--- vpP7/include/asm-ppc64/signal.h	2004-08-17 15:22:36.000000000 -0400
+++ vpP7-ppc/include/asm-ppc64/signal.h	2004-08-23 13:57:14.000000000 -0400
@@ -108,6 +108,7 @@
 #define SA_PROBE		SA_ONESHOT
 #define SA_SAMPLE_RANDOM	SA_RESTART
 #define SA_SHIRQ		0x04000000
+#define SA_NODELAY              0x02000000
 #endif
 
 #define SIG_BLOCK          0	/* for blocking signals */
diff -urN vpP7/include/linux/interrupt.h vpP7-ppc/include/linux/interrupt.h
--- vpP7/include/linux/interrupt.h	2004-08-23 13:41:28.000000000 -0400
+++ vpP7-ppc/include/linux/interrupt.h	2004-08-23 13:57:14.000000000 -0400
@@ -95,7 +95,6 @@
 	void	*data;
 };
 
-extern void do_hardirq(irq_desc_t *desc);
 asmlinkage void do_softirq(void);
 extern void open_softirq(int nr, void (*action)(struct softirq_action*), void *data);
 extern void softirq_init(void);
diff -urN vpP7/include/linux/irq.h vpP7-ppc/include/linux/irq.h
--- vpP7/include/linux/irq.h	2004-08-23 13:41:28.000000000 -0400
+++ vpP7-ppc/include/linux/irq.h	2004-08-23 13:57:14.000000000 -0400
@@ -83,6 +83,8 @@
 extern void generic_disable_irq(unsigned int irq);
 extern void generic_enable_irq(unsigned int irq);
 extern void generic_note_interrupt(int irq, irq_desc_t *desc, int action_ret);
+extern void do_hardirq(irq_desc_t *desc);
+extern void init_hardirqs(void);
 
 extern hw_irq_controller no_irq_type;  /* needed in every arch ? */
 
diff -urN vpP7/include/linux/kernel.h vpP7-ppc/include/linux/kernel.h
--- vpP7/include/linux/kernel.h	2004-08-23 13:41:28.000000000 -0400
+++ vpP7-ppc/include/linux/kernel.h	2004-08-23 13:57:14.000000000 -0400
@@ -48,7 +48,10 @@
 #ifdef CONFIG_PREEMPT_VOLUNTARY
 extern int voluntary_resched(void);
 #else
-# define voluntary_resched() 0
+static inline int voluntary_resched(void)
+{
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_DEBUG_SPINLOCK_SLEEP
diff -urN vpP7/include/linux/sched.h vpP7-ppc/include/linux/sched.h
--- vpP7/include/linux/sched.h	2004-08-23 13:41:28.000000000 -0400
+++ vpP7-ppc/include/linux/sched.h	2004-08-23 13:57:14.000000000 -0400
@@ -1114,8 +1114,6 @@
  * submitted upstream will of course use need_resched()/cond_resched().
  */
 
-extern int voluntary_resched(void);
-
 static inline int voluntary_need_resched(void)
 {
 	if (voluntary_preemption >= 1)
@@ -1136,9 +1134,15 @@
 }
 
 #else
-# define voluntary_resched() 0
-# define voluntary_resched_lock(lock) 0
-# define voluntary_need_resched() 0
+static inline int voluntary_resched_lock(spinlock_t *lock)
+{
+	return 0;
+}
+
+static inline int voluntary_need_resched(void)
+{
+	return 0;
+}
 #endif
 
 /* Reevaluate whether the task has signals pending delivery.
diff -urN vpP7/init/main.c vpP7-ppc/init/main.c
--- vpP7/init/main.c	2004-08-23 13:41:28.000000000 -0400
+++ vpP7-ppc/init/main.c	2004-08-23 13:57:14.000000000 -0400
@@ -397,9 +397,9 @@
 
 static void noinline rest_init(void)
 {
+	system_state = SYSTEM_BOOTING_SCHEDULER_OK;
 	kernel_thread(init, NULL, CLONE_FS | CLONE_SIGHAND);
 	numa_default_policy();
-	system_state = SYSTEM_BOOTING_SCHEDULER_OK;
 	unlock_kernel();
  	cpu_idle();
 } 
@@ -669,6 +669,8 @@
 	smp_init();
 	sched_init_smp();
 
+	init_hardirqs();
+
 	/*
 	 * Do this before initcalls, because some drivers want to access
 	 * firmware files.
diff -urN vpP7/kernel/hardirq.c vpP7-ppc/kernel/hardirq.c
--- vpP7/kernel/hardirq.c	2004-08-23 13:41:28.000000000 -0400
+++ vpP7-ppc/kernel/hardirq.c	2004-08-23 13:57:14.000000000 -0400
@@ -11,6 +11,7 @@
 #include <linux/mm.h>
 #include <linux/kallsyms.h>
 #include <linux/proc_fs.h>
+#include <linux/irq.h>
 #include <asm/uaccess.h>
 
 extern struct irq_desc irq_desc[NR_IRQS];
@@ -31,9 +32,8 @@
 	if (voluntary_preemption < 3 || (desc->status & IRQ_NODELAY))
 		return 0;
 
-	BUG_ON(!desc->thread);
 	BUG_ON(!irqs_disabled());
-	if (desc->thread->state != TASK_RUNNING)
+	if (desc->thread && desc->thread->state != TASK_RUNNING)
 		wake_up_process(desc->thread);
 
 	return 1;
@@ -369,7 +369,10 @@
 	if (!shared) {
 		desc->depth = 0;
 		desc->status &= ~(IRQ_DISABLED | IRQ_AUTODETECT | IRQ_WAITING | IRQ_INPROGRESS);
-		desc->handler->startup(irq);
+		if (desc->handler->startup)
+			desc->handler->startup(irq);
+		else
+			desc->handler->enable(irq);
 	}
 	spin_unlock_irqrestore(&desc->lock,flags);
 
@@ -420,7 +423,10 @@
 			*pp = action->next;
 			if (!desc->action) {
 				desc->status |= IRQ_DISABLED;
-				desc->handler->shutdown(irq);
+				if (desc->handler->shutdown)
+					desc->handler->shutdown(irq);
+				else
+					desc->handler->disable(irq);
 			}
 			recalculate_desc_flags(desc);
 			spin_unlock_irqrestore(&desc->lock,flags);
@@ -480,9 +486,11 @@
 	return 0;
 }
 
+static int ok_to_create_irq_threads;
+
 static int start_irq_thread(int irq, struct irq_desc *desc)
 {
-	if (desc->thread)
+	if (desc->thread || !ok_to_create_irq_threads)
 		return 0;
 
 	printk("requesting new irq thread for IRQ%d...\n", irq);
@@ -492,9 +500,31 @@
 		return -ENOMEM;
 	}
 
+	// An interrupt may have come in before the thread pointer was
+	// stored in desc->thread; make sure the thread gets woken up in
+	// such a case.
+	
+	smp_mb();
+	
+	if (desc->status & IRQ_INPROGRESS)
+		wake_up_process(desc->thread);
+	
 	return 0;
 }
 
+void init_hardirqs(void)
+{	
+	int i;
+	ok_to_create_irq_threads = 1;
+
+	for (i = 0; i < NR_IRQS; i++) {
+		irq_desc_t *desc = irq_desc + i;
+		
+		if (desc->action && !(desc->status & IRQ_NODELAY))
+			start_irq_thread(i, desc);
+	}
+}
+
 #ifdef CONFIG_SMP
 
 static struct proc_dir_entry *smp_affinity_entry[NR_IRQS];
diff -urN vpP7/kernel/latency.c vpP7-ppc/kernel/latency.c
--- vpP7/kernel/latency.c	2004-08-23 13:41:28.000000000 -0400
+++ vpP7-ppc/kernel/latency.c	2004-08-23 14:06:38.000000000 -0400
@@ -16,6 +16,7 @@
 #include <linux/kallsyms.h>
 #include <linux/seq_file.h>
 #include <linux/interrupt.h>
+#include <asm/time.h>
 
 unsigned long preempt_thresh;
 unsigned long preempt_max_latency;
@@ -100,6 +101,8 @@
 	___trace(eip, parent_eip);
 }
 
+#ifdef CONFIG_X86
+
 void notrace mcount(void)
 {
 	MCOUNT_HEAD
@@ -112,6 +115,22 @@
 
 EXPORT_SYMBOL(mcount);
 
+#else
+
+#ifdef CONFIG_PPC
+void _mcount(void);
+EXPORT_SYMBOL(_mcount);
+#else
+#error What is mcount called?
+#endif
+
+void notrace do_mcount(void *func, void *called_from)
+{
+	___trace((unsigned long)func, (unsigned long)called_from);
+}
+
+#endif
+
 static void notrace print_name(struct seq_file *m, unsigned long eip)
 {
 	char namebuf[KSYM_NAME_LEN+1];
@@ -142,7 +161,13 @@
 
 static unsigned long notrace cycles_to_usecs(cycles_t delta)
 {
+#ifdef CONFIG_X86
 	do_div(delta, cpu_khz/1000);
+#elif defined(CONFIG_PPC)
+	delta = mulhwu(tb_to_us, delta);
+#else
+	#error Implement cycles_to_usecs.
+#endif
 
 	return (unsigned long) delta;
 }
@@ -248,18 +273,15 @@
 #endif
 	unsigned long parent_eip = (unsigned long)__builtin_return_address(1);
 	unsigned long latency;
-	cycles_t delta;
 
 	atomic_inc(&tr->disabled);
-	delta = get_cycles() - tr->preempt_timestamp;
-	do_div(delta, cpu_khz/1024);
-	latency = (unsigned long) delta;
+	latency = cycles_to_usecs(get_cycles() - tr->preempt_timestamp);
 
 	if (preempt_thresh) {
 		if (latency < preempt_thresh)
 			goto out;
 	} else {
-		if (latency < preempt_max_latency)
+		if (latency <= preempt_max_latency)
 			goto out;
 	}
 
--- vpP7/kernel/sysctl.c	2004-08-23 17:39:58.000000000 -0400
+++ vpP7-ppc/kernel/sysctl.c	2004-08-23 17:56:41.000000000 -0400
@@ -285,7 +285,7 @@
 		.data		= &preempt_max_latency,
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
-		.proc_handler	= &proc_dointvec,
+		.proc_handler	= &proc_doulongvec_minmax,
 	},
 #ifdef CONFIG_LATENCY_TRACE
 	{
