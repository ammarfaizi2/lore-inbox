Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269153AbUIHVQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269153AbUIHVQA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 17:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268111AbUIHVPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 17:15:47 -0400
Received: from mx1.elte.hu ([157.181.1.137]:40172 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269153AbUIHVMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 17:12:49 -0400
Date: Wed, 8 Sep 2004 23:14:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Christoph Hellwig <hch@infradead.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org, Scott Wood <scott@timesys.com>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: [patch] generic-hardirqs-2.6.9-rc1-mm4.patch
Message-ID: <20040908211415.GA20168@elte.hu>
References: <20040908120613.GA16916@elte.hu> <20040908133445.A31267@infradead.org> <20040908124547.GA19231@elte.hu> <20040908125755.GC3106@holomorphy.com> <Pine.LNX.4.53.0409080932050.15087@montezuma.fsmlabs.com> <20040908143143.A32002@infradead.org> <Pine.LNX.4.53.0409080938470.15087@montezuma.fsmlabs.com> <1094652572.2800.14.camel@laptop.fenrus.com> <20040908182509.GA6009@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <20040908182509.GA6009@elte.hu>
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


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Ingo Molnar <mingo@elte.hu> wrote:

> latest patch attached - this should compile on every architecture.
> It's basically what Christoph suggested first time around :-)
> Compiles/boots on x86. Any other observations?

i've attached generic-hardirqs-2.6.9-rc1-mm4.patch which is a merge
against -mm4. x86 and x64 compiles & boots fine. Since there are zero
changes to non-x86 architectures it should build fine on all platforms.

	Ingo

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="generic-hardirqs-2.6.9-rc1-mm4.patch"

--- linux/arch/i386/kernel/irq.c.orig	
+++ linux/arch/i386/kernel/irq.c	
@@ -73,8 +73,6 @@ irq_desc_t irq_desc[NR_IRQS] __cacheline
 	}
 };
 
-static void register_irq_proc (unsigned int irq);
-
 /*
  * per-CPU IRQ handling stacks
  */
@@ -196,89 +194,6 @@ skip:
 	return 0;
 }
 
-
-
-
-#ifdef CONFIG_SMP
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
-asmlinkage int handle_IRQ_event(unsigned int irq,
-		struct pt_regs *regs, struct irqaction *action)
-{
-	int status = 1;	/* Force the "do bottom halves" bit */
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
-	printk(KERN_INFO "IRQ lockup detection disabled\n");
-	return 1;
-}
-
-__setup("noirqdebug", noirqdebug_setup);
-
 static int irqfixup;
 
 static int __init irqfixup_setup(char *str)
@@ -380,7 +295,7 @@ static asmlinkage int misrouted_irq(int 
  *
  * Called under desc->lock
  */
-static void note_interrupt(int irq, irq_desc_t *desc, irqreturn_t action_ret, struct pt_regs *regs)
+static void x86_note_interrupt(int irq, irq_desc_t *desc, irqreturn_t action_ret, struct pt_regs *regs)
 {
 	if (action_ret != IRQ_HANDLED) {
 		desc->irqs_unhandled++;
@@ -464,97 +379,6 @@ static void note_interrupt(int irq, irq_
 	desc->irqs_unhandled = 0;
 }
 
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
- *	Disable the selected interrupt line.  Disables and Enables are
- *	nested.
- *	Unlike disable_irq(), this function does not ensure existing
- *	instances of the IRQ handler have completed before returning.
- *
- *	This function may be called from IRQ context.
- */
- 
-inline void disable_irq_nosync(unsigned int irq)
-{
-	irq_desc_t *desc = irq_desc + irq;
-	unsigned long flags;
-
-	spin_lock_irqsave(&desc->lock, flags);
-	if (!desc->depth++) {
-		desc->status |= IRQ_DISABLED;
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
- *	enable_irq - enable handling of an irq
- *	@irq: Interrupt to enable
- *
- *	Undoes the effect of one call to disable_irq().  If this
- *	matches the last disable, processing of interrupts on this
- *	IRQ line is re-enabled.
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
 #ifdef CONFIG_HOTPLUG_CPU
 static int irqs_stabilizing;
 
@@ -695,7 +519,7 @@ asmlinkage unsigned int do_IRQ(struct pt
 		}
 		spin_lock(&desc->lock);
 		if (!noirqdebug)
-			note_interrupt(irq, desc, action_ret, &regs);
+			x86_note_interrupt(irq, desc, action_ret, &regs);
 		if (curctx != irqctx)
 			irqctx->tinfo.task = NULL;
 		if (likely(!(desc->status & IRQ_PENDING)))
@@ -714,7 +538,7 @@ asmlinkage unsigned int do_IRQ(struct pt
 
 		spin_lock(&desc->lock);
 		if (!noirqdebug)
-			note_interrupt(irq, desc, action_ret, &regs);
+			x86_note_interrupt(irq, desc, action_ret, &regs);
 		if (likely(!(desc->status & IRQ_PENDING)))
 			break;
 		desc->status &= ~IRQ_PENDING;
@@ -830,62 +654,6 @@ int request_irq(unsigned int irq, 
 
 EXPORT_SYMBOL(request_irq);
 
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
- *	This function must not be called from interrupt context. 
- */
- 
-void free_irq(unsigned int irq, void *dev_id)
-{
-	irq_desc_t *desc;
-	struct irqaction **p;
-	unsigned long flags;
-
-	if (irq >= NR_IRQS)
-		return;
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
-EXPORT_SYMBOL(free_irq);
-
 /*
  * IRQ autodetection code..
  *
@@ -1081,115 +849,6 @@ int probe_irq_off(unsigned long val)
 
 EXPORT_SYMBOL(probe_irq_off);
 
-/* this was setup_x86_irq but it seems pretty generic */
-int setup_irq(unsigned int irq, struct irqaction * new)
-{
-	int shared = 0;
-	unsigned long flags;
-	struct irqaction *old, **p;
-	irq_desc_t *desc = irq_desc + irq;
-
-	if (desc->handler == &no_irq_type)
-		return -ENOSYS;
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
-		desc->handler->startup(irq);
-	}
-	spin_unlock_irqrestore(&desc->lock,flags);
-
-	register_irq_proc(irq);
-	return 0;
-}
-
-static struct proc_dir_entry * root_irq_dir;
-static struct proc_dir_entry * irq_dir [NR_IRQS];
-
-#ifdef CONFIG_SMP
-
-static struct proc_dir_entry *smp_affinity_entry[NR_IRQS];
-
-cpumask_t irq_affinity[NR_IRQS] = { [0 ... NR_IRQS-1] = CPU_MASK_ALL };
-
-static int irq_affinity_read_proc(char *page, char **start, off_t off,
-			int count, int *eof, void *data)
-{
-	int len = cpumask_scnprintf(page, count, irq_affinity[(long)data]);
-	if (count - len < 2)
-		return -EINVAL;
-	len += sprintf(page + len, "\n");
-	return len;
-}
-
-static int irq_affinity_write_proc(struct file *file, const char __user *buffer,
-					unsigned long count, void *data)
-{
-	int irq = (long)data, full_count = count, err;
-	cpumask_t new_value, tmp;
-
-	if (!irq_desc[irq].handler->set_affinity)
-		return -EIO;
-
-	err = cpumask_parse(buffer, count, new_value);
-	if (err)
-		return err;
-
-	/*
-	 * Do not allow disabling IRQs completely - it's a too easy
-	 * way to make the system unusable accidentally :-) At least
-	 * one online CPU still has to be targeted.
-	 */
-	cpus_and(tmp, new_value, cpu_online_map);
-	if (cpus_empty(tmp))
-		return -EINVAL;
-
-	irq_affinity[irq] = new_value;
-	irq_desc[irq].handler->set_affinity(irq,
-					cpumask_of_cpu(first_cpu(new_value)));
-
-	return full_count;
-}
-#endif
-
 #ifdef CONFIG_HOTPLUG_CPU
 #include <mach_apic.h>
 
@@ -1234,55 +893,6 @@ void fixup_irqs(void)
 #endif
 }
 #endif
-#define MAX_NAMELEN 10
-
-static void register_irq_proc (unsigned int irq)
-{
-	char name [MAX_NAMELEN];
-
-	if (!root_irq_dir || (irq_desc[irq].handler == &no_irq_type) ||
-			irq_dir[irq])
-		return;
-
-	memset(name, 0, MAX_NAMELEN);
-	sprintf(name, "%d", irq);
-
-	/* create /proc/irq/1234 */
-	irq_dir[irq] = proc_mkdir(name, root_irq_dir);
-
-#ifdef CONFIG_SMP
-	{
-		struct proc_dir_entry *entry;
-
-		/* create /proc/irq/1234/smp_affinity */
-		entry = create_proc_entry("smp_affinity", 0600, irq_dir[irq]);
-
-		if (entry) {
-			entry->nlink = 1;
-			entry->data = (void *)(long)irq;
-			entry->read_proc = irq_affinity_read_proc;
-			entry->write_proc = irq_affinity_write_proc;
-		}
-
-		smp_affinity_entry[irq] = entry;
-	}
-#endif
-}
-
-void init_irq_proc (void)
-{
-	int i;
-
-	/* create /proc/irq */
-	root_irq_dir = proc_mkdir("irq", NULL);
-	create_prof_cpu_mask(root_irq_dir);
-	/*
-	 * Create entries for all existing IRQs.
-	 */
-	for (i = 0; i < NR_IRQS; i++)
-		register_irq_proc(i);
-}
-
 
 #ifdef CONFIG_4KSTACKS
 /*
--- linux/arch/i386/kernel/i386_ksyms.c.orig	
+++ linux/arch/i386/kernel/i386_ksyms.c	
@@ -76,9 +76,6 @@ EXPORT_SYMBOL_GPL(kernel_fpu_begin);
 EXPORT_SYMBOL(__ioremap);
 EXPORT_SYMBOL(ioremap_nocache);
 EXPORT_SYMBOL(iounmap);
-EXPORT_SYMBOL(enable_irq);
-EXPORT_SYMBOL(disable_irq);
-EXPORT_SYMBOL(disable_irq_nosync);
 EXPORT_SYMBOL(probe_irq_mask);
 EXPORT_SYMBOL(kernel_thread);
 EXPORT_SYMBOL(pm_idle);
@@ -146,7 +143,6 @@ EXPORT_SYMBOL_NOVERS(__write_lock_failed
 EXPORT_SYMBOL_NOVERS(__read_lock_failed);
 
 /* Global SMP stuff */
-EXPORT_SYMBOL(synchronize_irq);
 EXPORT_SYMBOL(smp_call_function);
 
 /* TLB flushing */
--- linux/arch/i386/Kconfig.orig	
+++ linux/arch/i386/Kconfig	
@@ -1226,6 +1226,10 @@ source "crypto/Kconfig"
 
 source "lib/Kconfig"
 
+config GENERIC_HARDIRQS
+	bool
+	default y
+
 config X86_SMP
 	bool
 	depends on SMP && !X86_VOYAGER
--- linux/include/linux/irq.h.orig	
+++ linux/include/linux/irq.h	
@@ -10,12 +10,15 @@
  */
 
 #include <linux/config.h>
+#include <linux/linkage.h>
 
 #if !defined(CONFIG_ARCH_S390)
 
 #include <linux/cache.h>
 #include <linux/spinlock.h>
 #include <linux/cpumask.h>
+#include <linux/wait.h>
+#include <linux/signal.h>
 
 #include <asm/irq.h>
 #include <asm/ptrace.h>
@@ -71,7 +74,24 @@ extern irq_desc_t irq_desc [NR_IRQS];
 
 #include <asm/hw_irq.h> /* the arch dependent stuff */
 
-extern int setup_irq(unsigned int , struct irqaction * );
+
+extern int setup_irq(unsigned int irq, struct irqaction * new);
+
+#ifdef CONFIG_GENERIC_HARDIRQS
+extern asmlinkage int handle_IRQ_event(unsigned int irq, struct pt_regs *regs, struct irqaction *action);
+extern void synchronize_irq(unsigned int irq);
+extern void free_irq(unsigned int irq, void *dev_id);
+extern void disable_irq_nosync(unsigned int irq);
+extern void disable_irq(unsigned int irq);
+extern void enable_irq(unsigned int irq);
+extern void note_interrupt(int irq, irq_desc_t *desc, int action_ret);
+extern void __report_bad_irq(int irq, irq_desc_t *desc, int action_ret);
+extern void report_bad_irq(int irq, irq_desc_t *desc, int action_ret);
+extern void init_irq_proc(void);
+
+extern int noirqdebug;
+
+#endif
 
 extern hw_irq_controller no_irq_type;  /* needed in every arch ? */
 
--- linux/include/linux/interrupt.h.orig	
+++ linux/include/linux/interrupt.h	
@@ -40,6 +40,8 @@ struct irqaction {
 	const char *name;
 	void *dev_id;
 	struct irqaction *next;
+	int irq;
+	struct proc_dir_entry *dir;
 };
 
 extern irqreturn_t no_action(int cpl, void *dev_id, struct pt_regs *regs);
--- linux/include/asm-i386/irq.h.orig	
+++ linux/include/asm-i386/irq.h	
@@ -21,9 +21,6 @@ static __inline__ int irq_canonicalize(i
 	return ((irq == 2) ? 9 : irq);
 }
 
-extern void disable_irq(unsigned int);
-extern void disable_irq_nosync(unsigned int);
-extern void enable_irq(unsigned int);
 extern void release_x86_irqs(struct task_struct *);
 extern int can_request_irq(unsigned int, unsigned long flags);
 
--- linux/kernel/Makefile.orig	
+++ linux/kernel/Makefile	
@@ -12,6 +12,7 @@ obj-y     = sched.o fork.o exec_domain.o
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o spinlock.o
+obj-$(CONFIG_GENERIC_HARDIRQS) += hardirq.o
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += module.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
--- linux/kernel/hardirq.c.orig	
+++ linux/kernel/hardirq.c	
@@ -0,0 +1,529 @@
+/*
+ * linux/kernel/hardirq.c
+ *
+ * Copyright (C) 1992, 1998-2004 Linus Torvalds, Ingo Molnar
+ *
+ * This file contains the generic code used by various IRQ handling
+ * routines.
+ */
+
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/random.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/kallsyms.h>
+#include <linux/proc_fs.h>
+#include <linux/irq.h>
+#include <linux/wait.h>
+#include <asm/uaccess.h>
+
+int noirqdebug;
+
+extern struct irq_desc irq_desc[NR_IRQS];
+
+static struct proc_dir_entry * root_irq_dir;
+static struct proc_dir_entry * irq_dir [NR_IRQS];
+
+static void register_irq_proc(unsigned int irq);
+static void register_handler_proc(unsigned int irq, struct irqaction *action);
+
+/*
+ * This should really return information about whether
+ * we should do bottom half handling etc. Right now we
+ * end up _always_ checking the bottom half, which is a
+ * waste of time and is not what some drivers would
+ * prefer.
+ */
+asmlinkage int handle_IRQ_event(unsigned int irq,
+		struct pt_regs *regs, struct irqaction *action)
+{
+	int status = 1;	/* Force the "do bottom halves" bit */
+	int ret, retval = 0;
+
+	if (!(action->flags & SA_INTERRUPT))
+		local_irq_enable();
+
+	do {
+		ret = action->handler(irq, action->dev_id, regs);
+		if (ret == IRQ_HANDLED)
+			status |= action->flags;
+		retval |= ret;
+		action = action->next;
+	} while (action);
+
+	if (status & SA_SAMPLE_RANDOM)
+		add_interrupt_randomness(irq);
+	local_irq_disable();
+
+	return retval;
+}
+
+void __report_bad_irq(int irq, irq_desc_t *desc, irqreturn_t action_ret)
+{
+	struct irqaction *action;
+
+	if (action_ret != IRQ_HANDLED && action_ret != IRQ_NONE) {
+		printk(KERN_ERR "irq event %d: bogus return value %x\n",
+				irq, action_ret);
+	} else {
+		printk(KERN_ERR "irq %d: nobody cared!\n", irq);
+	}
+	dump_stack();
+	printk(KERN_ERR "handlers:\n");
+	action = desc->action;
+	while (action) {
+		printk(KERN_ERR "[<%p>]", action->handler);
+		print_symbol(" (%s)",
+			(unsigned long)action->handler);
+		printk("\n");
+		action = action->next;
+	}
+}
+
+void report_bad_irq(int irq, irq_desc_t *desc, irqreturn_t action_ret)
+{
+	static int count = 100;
+
+	if (count) {
+		count--;
+		__report_bad_irq(irq, desc, action_ret);
+	}
+}
+
+
+static int __init noirqdebug_setup(char *str)
+{
+	noirqdebug = 1;
+	printk("IRQ lockup detection disabled\n");
+	return 1;
+}
+
+__setup("noirqdebug", noirqdebug_setup);
+
+/*
+ * If 99,900 of the previous 100,000 interrupts have not been handled then
+ * assume that the IRQ is stuck in some manner.  Drop a diagnostic and try to
+ * turn the IRQ off.
+ *
+ * (The other 100-of-100,000 interrupts may have been a correctly-functioning
+ *  device sharing an IRQ with the failing one)
+ *
+ * Called under desc->lock
+ */
+void note_interrupt(int irq, irq_desc_t *desc, irqreturn_t action_ret)
+{
+	if (action_ret != IRQ_HANDLED) {
+		desc->irqs_unhandled++;
+		if (action_ret != IRQ_NONE)
+			report_bad_irq(irq, desc, action_ret);
+	}
+
+	desc->irq_count++;
+	if (desc->irq_count < 100000)
+		return;
+
+	desc->irq_count = 0;
+	if (desc->irqs_unhandled > 99900) {
+		/*
+		 * The interrupt is stuck
+		 */
+		__report_bad_irq(irq, desc, action_ret);
+		/*
+		 * Now kill the IRQ
+		 */
+		printk(KERN_EMERG "Disabling IRQ #%d\n", irq);
+		desc->status |= IRQ_DISABLED;
+		desc->handler->disable(irq);
+	}
+	desc->irqs_unhandled = 0;
+}
+
+void synchronize_irq(unsigned int irq)
+{
+	struct irq_desc *desc = irq_desc + irq;
+
+	while (desc->status & IRQ_INPROGRESS)
+		cpu_relax();
+}
+
+EXPORT_SYMBOL(synchronize_irq);
+
+/*
+ * Generic enable/disable code: this just calls
+ * down into the PIC-specific version for the actual
+ * hardware disable after having gotten the irq
+ * controller lock.
+ */
+
+/**
+ *	disable_irq_nosync - disable an irq without waiting
+ *	@irq: Interrupt to disable
+ *
+ *	Disable the selected interrupt line.  Disables and Enables are
+ *	nested.
+ *	Unlike disable_irq(), this function does not ensure existing
+ *	instances of the IRQ handler have completed before returning.
+ *
+ *	This function may be called from IRQ context.
+ */
+
+void disable_irq_nosync(unsigned int irq)
+{
+	irq_desc_t *desc = irq_desc + irq;
+	unsigned long flags;
+
+	spin_lock_irqsave(&desc->lock, flags);
+	if (!desc->depth++) {
+		desc->status |= IRQ_DISABLED;
+		desc->handler->disable(irq);
+	}
+	spin_unlock_irqrestore(&desc->lock, flags);
+}
+
+EXPORT_SYMBOL(disable_irq_nosync);
+
+/**
+ *	disable_irq - disable an irq and wait for completion
+ *	@irq: Interrupt to disable
+ *
+ *	Disable the selected interrupt line.  Enables and Disables are
+ *	nested.
+ *	This function waits for any pending IRQ handlers for this interrupt
+ *	to complete before returning. If you use this function while
+ *	holding a resource the IRQ handler may need you will deadlock.
+ *
+ *	This function may be called - with care - from IRQ context.
+ */
+
+void disable_irq(unsigned int irq)
+{
+	irq_desc_t *desc = irq_desc + irq;
+	disable_irq_nosync(irq);
+	if (desc->action)
+		synchronize_irq(irq);
+}
+
+EXPORT_SYMBOL(disable_irq);
+
+/**
+ *	enable_irq - enable handling of an irq
+ *	@irq: Interrupt to enable
+ *
+ *	Undoes the effect of one call to disable_irq().  If this
+ *	matches the last disable, processing of interrupts on this
+ *	IRQ line is re-enabled.
+ *
+ *	This function may be called from IRQ context.
+ */
+
+void enable_irq(unsigned int irq)
+{
+	irq_desc_t *desc = irq_desc + irq;
+	unsigned long flags;
+
+	spin_lock_irqsave(&desc->lock, flags);
+	switch (desc->depth) {
+	case 1: {
+		unsigned int status = desc->status & ~IRQ_DISABLED;
+		desc->status = status;
+		if ((status & (IRQ_PENDING | IRQ_REPLAY)) == IRQ_PENDING) {
+			desc->status = status | IRQ_REPLAY;
+			hw_resend_irq(desc->handler,irq);
+		}
+		desc->handler->enable(irq);
+		/* fall-through */
+	}
+	default:
+		desc->depth--;
+		break;
+	case 0:
+		printk("enable_irq(%u) unbalanced from %p\n", irq,
+		       __builtin_return_address(0));
+	}
+	spin_unlock_irqrestore(&desc->lock, flags);
+}
+
+EXPORT_SYMBOL(enable_irq);
+
+int setup_irq(unsigned int irq, struct irqaction * new)
+{
+	int shared = 0;
+	unsigned long flags;
+	struct irqaction *old, **p;
+	struct irq_desc *desc = irq_desc + irq;
+
+	if (desc->handler == &no_irq_type)
+		return -ENOSYS;
+	/*
+	 * Some drivers like serial.c use request_irq() heavily,
+	 * so we have to be careful not to interfere with a
+	 * running system.
+	 */
+	if (new->flags & SA_SAMPLE_RANDOM) {
+		/*
+		 * This function might sleep, we want to call it first,
+		 * outside of the atomic block.
+		 * Yes, this might clear the entropy pool if the wrong
+		 * driver is attempted to be loaded, without actually
+		 * installing a new handler, but is this really a problem,
+		 * only the sysadmin is able to do this.
+		 */
+		rand_initialize_irq(irq);
+	}
+
+	/*
+	 * The following block of code has to be executed atomically
+	 */
+	spin_lock_irqsave(&desc->lock,flags);
+	p = &desc->action;
+	if ((old = *p) != NULL) {
+		/* Can't share interrupts unless both agree to */
+		if (!(old->flags & new->flags & SA_SHIRQ)) {
+			spin_unlock_irqrestore(&desc->lock,flags);
+			return -EBUSY;
+		}
+
+		/* add new interrupt at end of irq queue */
+		do {
+			p = &old->next;
+			old = *p;
+		} while (old);
+		shared = 1;
+	}
+
+	*p = new;
+
+	if (!shared) {
+		desc->depth = 0;
+		desc->status &= ~(IRQ_DISABLED | IRQ_AUTODETECT | IRQ_WAITING | IRQ_INPROGRESS);
+		if (desc->handler->startup)
+			desc->handler->startup(irq);
+		else
+			desc->handler->enable(irq);
+	}
+	spin_unlock_irqrestore(&desc->lock,flags);
+
+	new->irq = irq;
+	register_irq_proc(irq);
+	new->dir = NULL;
+	register_handler_proc(irq, new);
+
+	return 0;
+}
+
+/**
+ *	free_irq - free an interrupt
+ *	@irq: Interrupt line to free
+ *	@dev_id: Device identity to free
+ *
+ *	Remove an interrupt handler. The handler is removed and if the
+ *	interrupt line is no longer in use by any driver it is disabled.
+ *	On a shared IRQ the caller must ensure the interrupt is disabled
+ *	on the card it drives before calling this function. The function
+ *	does not return until any executing interrupts for this IRQ
+ *	have completed.
+ *
+ *	This function must not be called from interrupt context.
+ */
+
+void free_irq(unsigned int irq, void *dev_id)
+{
+	struct irq_desc *desc;
+	struct irqaction **p;
+	unsigned long flags;
+
+	if (irq >= NR_IRQS)
+		return;
+
+	desc = irq_desc + irq;
+	spin_lock_irqsave(&desc->lock,flags);
+	p = &desc->action;
+	for (;;) {
+		struct irqaction * action = *p;
+		if (action) {
+			struct irqaction **pp = p;
+			p = &action->next;
+			if (action->dev_id != dev_id)
+				continue;
+
+			/* Found it - now remove it from the list of entries */
+			*pp = action->next;
+			if (!desc->action) {
+				desc->status |= IRQ_DISABLED;
+				if (desc->handler->shutdown)
+					desc->handler->shutdown(irq);
+				else
+					desc->handler->disable(irq);
+			}
+			spin_unlock_irqrestore(&desc->lock,flags);
+			if (action->dir)
+				remove_proc_entry(action->dir->name, irq_dir[irq]);
+
+			/* Wait to make sure it's not being used on another CPU */
+			synchronize_irq(irq);
+			kfree(action);
+			return;
+		}
+		printk("Trying to free free IRQ%d\n",irq);
+		spin_unlock_irqrestore(&desc->lock,flags);
+		return;
+	}
+}
+
+EXPORT_SYMBOL(free_irq);
+
+#ifdef CONFIG_SMP
+
+static struct proc_dir_entry *smp_affinity_entry[NR_IRQS];
+
+cpumask_t irq_affinity[NR_IRQS] = { [0 ... NR_IRQS-1] = CPU_MASK_ALL };
+
+static int irq_affinity_read_proc(char *page, char **start, off_t off,
+			int count, int *eof, void *data)
+{
+	int len = cpumask_scnprintf(page, count, irq_affinity[(long)data]);
+	if (count - len < 2)
+		return -EINVAL;
+	len += sprintf(page + len, "\n");
+	return len;
+}
+
+static int irq_affinity_write_proc(struct file *file, const char __user *buffer,
+					unsigned long count, void *data)
+{
+	int irq = (long)data, full_count = count, err;
+	cpumask_t new_value, tmp;
+
+	if (!irq_desc[irq].handler->set_affinity)
+		return -EIO;
+
+	err = cpumask_parse(buffer, count, new_value);
+	if (err)
+		return err;
+
+	/*
+	 * Do not allow disabling IRQs completely - it's a too easy
+	 * way to make the system unusable accidentally :-) At least
+	 * one online CPU still has to be targeted.
+	 */
+	cpus_and(tmp, new_value, cpu_online_map);
+	if (cpus_empty(tmp))
+		return -EINVAL;
+
+	irq_affinity[irq] = new_value;
+	irq_desc[irq].handler->set_affinity(irq,
+					cpumask_of_cpu(first_cpu(new_value)));
+
+	return full_count;
+}
+
+#endif
+
+static int prof_cpu_mask_read_proc (char *page, char **start, off_t off,
+			int count, int *eof, void *data)
+{
+	int len = cpumask_scnprintf(page, count, *(cpumask_t *)data);
+	if (count - len < 2)
+		return -EINVAL;
+	len += sprintf(page + len, "\n");
+	return len;
+}
+
+static int prof_cpu_mask_write_proc (struct file *file, const char __user *buffer,
+					unsigned long count, void *data)
+{
+	cpumask_t *mask = (cpumask_t *)data;
+	unsigned long full_count = count, err;
+	cpumask_t new_value;
+
+	err = cpumask_parse(buffer, count, new_value);
+	if (err)
+		return err;
+
+	*mask = new_value;
+	return full_count;
+}
+
+#define MAX_NAMELEN 10
+
+static void register_irq_proc(unsigned int irq)
+{
+	char name [MAX_NAMELEN];
+
+	if (!root_irq_dir || (irq_desc[irq].handler == &no_irq_type) ||
+			irq_dir[irq])
+		return;
+
+	memset(name, 0, MAX_NAMELEN);
+	sprintf(name, "%d", irq);
+
+	/* create /proc/irq/1234 */
+	irq_dir[irq] = proc_mkdir(name, root_irq_dir);
+
+#ifdef CONFIG_SMP
+	{
+		struct proc_dir_entry *entry;
+
+		/* create /proc/irq/1234/smp_affinity */
+		entry = create_proc_entry("smp_affinity", 0600, irq_dir[irq]);
+
+		if (entry) {
+			entry->nlink = 1;
+			entry->data = (void *)(long)irq;
+			entry->read_proc = irq_affinity_read_proc;
+			entry->write_proc = irq_affinity_write_proc;
+		}
+
+		smp_affinity_entry[irq] = entry;
+	}
+#endif
+}
+
+#undef MAX_NAMELEN
+
+#define MAX_NAMELEN 128
+
+static void register_handler_proc(unsigned int irq, struct irqaction *action)
+{
+	char name [MAX_NAMELEN];
+
+	if (!irq_dir[irq] || action->dir || !action->name)
+		return;
+
+	memset(name, 0, MAX_NAMELEN);
+	snprintf(name, MAX_NAMELEN, "%s", action->name);
+
+	/* create /proc/irq/1234/handler/ */
+	action->dir = proc_mkdir(name, irq_dir[irq]);
+}
+
+
+unsigned long prof_cpu_mask = -1;
+
+void init_irq_proc(void)
+{
+	struct proc_dir_entry *entry;
+	int i;
+
+	/* create /proc/irq */
+	root_irq_dir = proc_mkdir("irq", NULL);
+
+	/* create /proc/irq/prof_cpu_mask */
+	entry = create_proc_entry("prof_cpu_mask", 0600, root_irq_dir);
+
+	if (!entry)
+		return;
+
+	entry->nlink = 1;
+	entry->data = (void *)&prof_cpu_mask;
+	entry->read_proc = prof_cpu_mask_read_proc;
+	entry->write_proc = prof_cpu_mask_write_proc;
+
+	/*
+	 * Create entries for all existing IRQs.
+	 */
+	for (i = 0; i < NR_IRQS; i++)
+		register_irq_proc(i);
+}

--LZvS9be/3tNcYl/X--
