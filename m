Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266613AbUJAU44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266613AbUJAU44 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 16:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266631AbUJAUys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 16:54:48 -0400
Received: from scanner1.mail.elte.hu ([157.181.1.137]:51114 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266585AbUJAUpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 16:45:22 -0400
Date: Fri, 1 Oct 2004 22:46:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 1/5, 2.6.9-rc3] generic irq subsystem, core
Message-ID: <20041001204642.GA18750@elte.hu>
References: <20041001204533.GA18684@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041001204533.GA18684@elte.hu>
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


core bits of generic hardirqs.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Christoph Hellwig <hch@lst.de>

--- linux/kernel/irq/proc.c.orig
+++ linux/kernel/irq/proc.c
@@ -0,0 +1,183 @@
+/*
+ * linux/kernel/irq/proc.c
+ *
+ * Copyright (C) 1992, 1998-2004 Linus Torvalds, Ingo Molnar
+ *
+ * This file contains the /proc/irq/ handling code.
+ */
+
+#include <linux/irq.h>
+#include <linux/proc_fs.h>
+#include <linux/interrupt.h>
+
+unsigned long prof_cpu_mask = -1;
+
+static struct proc_dir_entry *root_irq_dir, *irq_dir[NR_IRQS];
+
+#ifdef CONFIG_SMP
+
+/*
+ * The /proc/irq/<irq>/smp_affinity values:
+ */
+static struct proc_dir_entry *smp_affinity_entry[NR_IRQS];
+
+cpumask_t irq_affinity[NR_IRQS] = { [0 ... NR_IRQS-1] = CPU_MASK_ALL };
+
+static int irq_affinity_read_proc(char *page, char **start, off_t off,
+				  int count, int *eof, void *data)
+{
+	int len = cpumask_scnprintf(page, count, irq_affinity[(long)data]);
+
+	if (count - len < 2)
+		return -EINVAL;
+	len += sprintf(page + len, "\n");
+	return len;
+}
+
+static int irq_affinity_write_proc(struct file *file, const char __user *buffer,
+				   unsigned long count, void *data)
+{
+	unsigned int irq = (int)(long)data, full_count = count, err;
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
+static int prof_cpu_mask_read_proc(char *page, char **start, off_t off,
+				   int count, int *eof, void *data)
+{
+	int len = cpumask_scnprintf(page, count, *(cpumask_t *)data);
+
+	if (count - len < 2)
+		return -EINVAL;
+	len += sprintf(page + len, "\n");
+	return len;
+}
+
+static int prof_cpu_mask_write_proc(struct file *file,
+				    const char __user *buffer,
+				    unsigned long count, void *data)
+{
+	unsigned long full_count = count, err;
+	cpumask_t *mask = (cpumask_t *)data;
+	cpumask_t new_value;
+
+	err = cpumask_parse(buffer, count, new_value);
+	if (err)
+		return err;
+
+	*mask = new_value;
+
+	return full_count;
+}
+
+#define MAX_NAMELEN 128
+
+void register_handler_proc(unsigned int irq, struct irqaction *action)
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
+#undef MAX_NAMELEN
+
+#define MAX_NAMELEN 10
+
+void register_irq_proc(unsigned int irq)
+{
+	char name [MAX_NAMELEN];
+
+	if (!root_irq_dir ||
+		(irq_desc[irq].handler == &no_irq_type) ||
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
+		/* create /proc/irq/<irq>/smp_affinity */
+		entry = create_proc_entry("smp_affinity", 0600, irq_dir[irq]);
+
+		if (entry) {
+			entry->nlink = 1;
+			entry->data = (void *)(long)irq;
+			entry->read_proc = irq_affinity_read_proc;
+			entry->write_proc = irq_affinity_write_proc;
+		}
+		smp_affinity_entry[irq] = entry;
+	}
+#endif
+}
+
+#undef MAX_NAMELEN
+
+void unregister_handler_proc(unsigned int irq, struct irqaction *action)
+{
+	if (action->dir)
+		remove_proc_entry(action->dir->name, irq_dir[irq]);
+}
+
+void init_irq_proc(void)
+{
+	struct proc_dir_entry *entry;
+	int i;
+
+	/* create /proc/irq */
+	root_irq_dir = proc_mkdir("irq", NULL);
+	if (!root_irq_dir)
+		return;
+
+	/* create /proc/irq/prof_cpu_mask */
+	entry = create_proc_entry("prof_cpu_mask", 0600, root_irq_dir);
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
+
--- linux/kernel/irq/manage.c.orig
+++ linux/kernel/irq/manage.c
@@ -0,0 +1,347 @@
+/*
+ * linux/kernel/irq/manage.c
+ *
+ * Copyright (C) 1992, 1998-2004 Linus Torvalds, Ingo Molnar
+ *
+ * This file contains driver APIs to the irq subsystem.
+ */
+
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/random.h>
+#include <linux/interrupt.h>
+
+#include "internals.h"
+
+#ifdef CONFIG_SMP
+
+/**
+ *	synchronize_irq - wait for pending IRQ handlers (on other CPUs)
+ *
+ *	This function waits for any pending IRQ handlers for this interrupt
+ *	to complete before returning. If you use this function while
+ *	holding a resource the IRQ handler may need you will deadlock.
+ *
+ *	This function may be called - with care - from IRQ context.
+ */
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
+#endif
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
+void disable_irq(unsigned int irq)
+{
+	irq_desc_t *desc = irq_desc + irq;
+
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
+void enable_irq(unsigned int irq)
+{
+	irq_desc_t *desc = irq_desc + irq;
+	unsigned long flags;
+
+	spin_lock_irqsave(&desc->lock, flags);
+	switch (desc->depth) {
+	case 0:
+		WARN_ON(1);
+		break;
+	case 1: {
+		unsigned int status = desc->status & ~IRQ_DISABLED;
+
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
+	}
+	spin_unlock_irqrestore(&desc->lock, flags);
+}
+
+EXPORT_SYMBOL(enable_irq);
+
+/*
+ * Internal function that tells the architecture code whether a
+ * particular irq has been exclusively allocated or is available
+ * for driver use.
+ */
+int can_request_irq(unsigned int irq, unsigned long irqflags)
+{
+	struct irqaction *action;
+
+	if (irq >= NR_IRQS)
+		return 0;
+
+	action = irq_desc[irq].action;
+	if (action)
+		if (irqflags & action->flags & SA_SHIRQ)
+			action = NULL;
+
+	return !action;
+}
+
+/*
+ * Internal function to register an irqaction - typically used to
+ * allocate special interrupts that are part of the architecture.
+ */
+int setup_irq(unsigned int irq, struct irqaction * new)
+{
+	struct irq_desc *desc = irq_desc + irq;
+	struct irqaction *old, **p;
+	unsigned long flags;
+	int shared = 0;
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
+		desc->status &= ~(IRQ_DISABLED | IRQ_AUTODETECT |
+				  IRQ_WAITING | IRQ_INPROGRESS);
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
+
+		if (action) {
+			struct irqaction **pp = p;
+
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
+			unregister_handler_proc(irq, action);
+
+			/* Make sure it's not being used on another CPU */
+			synchronize_irq(irq);
+			kfree(action);
+			return;
+		}
+		printk(KERN_ERR "Trying to free free IRQ%d\n",irq);
+		spin_unlock_irqrestore(&desc->lock,flags);
+		return;
+	}
+}
+
+EXPORT_SYMBOL(free_irq);
+
+/**
+ *	request_irq - allocate an interrupt line
+ *	@irq: Interrupt line to allocate
+ *	@handler: Function to be called when the IRQ occurs
+ *	@irqflags: Interrupt type flags
+ *	@devname: An ascii name for the claiming device
+ *	@dev_id: A cookie passed back to the handler function
+ *
+ *	This call allocates interrupt resources and enables the
+ *	interrupt line and IRQ handling. From the point this
+ *	call is made your handler function may be invoked. Since
+ *	your handler function must clear any interrupt the board
+ *	raises, you must take care both to initialise your hardware
+ *	and to set up the interrupt handler in the right order.
+ *
+ *	Dev_id must be globally unique. Normally the address of the
+ *	device data structure is used as the cookie. Since the handler
+ *	receives this value it makes sense to use it.
+ *
+ *	If your interrupt is shared you must pass a non NULL dev_id
+ *	as this is required when freeing the interrupt.
+ *
+ *	Flags:
+ *
+ *	SA_SHIRQ		Interrupt is shared
+ *	SA_INTERRUPT		Disable local interrupts while processing
+ *	SA_SAMPLE_RANDOM	The interrupt can be used for entropy
+ *
+ */
+int request_irq(unsigned int irq,
+		irqreturn_t (*handler)(int, void *, struct pt_regs *),
+		unsigned long irqflags, const char * devname, void *dev_id)
+{
+	struct irqaction * action;
+	int retval;
+
+	/*
+	 * Sanity-check: shared interrupts must pass in a real dev-ID,
+	 * otherwise we'll have trouble later trying to figure out
+	 * which interrupt is which (messes up the interrupt freeing
+	 * logic etc).
+	 */
+	if ((irqflags & SA_SHIRQ) && !dev_id)
+		return -EINVAL;
+	if (irq >= NR_IRQS)
+		return -EINVAL;
+	if (!handler)
+		return -EINVAL;
+
+	action = kmalloc(sizeof(struct irqaction), GFP_ATOMIC);
+	if (!action)
+		return -ENOMEM;
+
+	action->handler = handler;
+	action->flags = irqflags;
+	cpus_clear(action->mask);
+	action->name = devname;
+	action->next = NULL;
+	action->dev_id = dev_id;
+
+	retval = setup_irq(irq, action);
+	if (retval)
+		kfree(action);
+
+	return retval;
+}
+
+EXPORT_SYMBOL(request_irq);
+
--- linux/kernel/irq/spurious.c.orig
+++ linux/kernel/irq/spurious.c
@@ -0,0 +1,96 @@
+/*
+ * linux/kernel/irq/spurious.c
+ *
+ * Copyright (C) 1992, 1998-2004 Linus Torvalds, Ingo Molnar
+ *
+ * This file contains spurious interrupt handling.
+ */
+
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/kallsyms.h>
+#include <linux/interrupt.h>
+
+/*
+ * If 99,900 of the previous 100,000 interrupts have not been handled
+ * then assume that the IRQ is stuck in some manner. Drop a diagnostic
+ * and try to turn the IRQ off.
+ *
+ * (The other 100-of-100,000 interrupts may have been a correctly
+ *  functioning device sharing an IRQ with the failing one)
+ *
+ * Called under desc->lock
+ */
+
+static void
+__report_bad_irq(unsigned int irq, irq_desc_t *desc, irqreturn_t action_ret)
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
+void report_bad_irq(unsigned int irq, irq_desc_t *desc, irqreturn_t action_ret)
+{
+	static int count = 100;
+
+	if (count > 0) {
+		count--;
+		__report_bad_irq(irq, desc, action_ret);
+	}
+}
+
+void note_interrupt(unsigned int irq, irq_desc_t *desc, irqreturn_t action_ret)
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
+int noirqdebug;
+
+static int __init noirqdebug_setup(char *str)
+{
+	noirqdebug = 1;
+	printk(KERN_INFO "IRQ lockup detection disabled\n");
+	return 1;
+}
+
+__setup("noirqdebug", noirqdebug_setup);
+
--- linux/kernel/irq/handle.c.orig
+++ linux/kernel/irq/handle.c
@@ -0,0 +1,204 @@
+/*
+ * linux/kernel/irq/handle.c
+ *
+ * Copyright (C) 1992, 1998-2004 Linus Torvalds, Ingo Molnar
+ *
+ * This file contains the core interrupt handling code.
+ */
+
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/random.h>
+#include <linux/interrupt.h>
+#include <linux/kernel_stat.h>
+
+#include "internals.h"
+
+/*
+ * Linux has a controller-independent interrupt architecture.
+ * Every controller has a 'controller-template', that is used
+ * by the main code to do the right thing. Each driver-visible
+ * interrupt source is transparently wired to the apropriate
+ * controller. Thus drivers need not be aware of the
+ * interrupt-controller.
+ *
+ * The code is designed to be easily extended with new/different
+ * interrupt controllers, without having to do assembly magic or
+ * having to touch the generic code.
+ *
+ * Controller mappings for all interrupt sources:
+ */
+irq_desc_t irq_desc[NR_IRQS] __cacheline_aligned = {
+	[0 ... NR_IRQS-1] = {
+		.handler = &no_irq_type,
+		.lock = SPIN_LOCK_UNLOCKED
+	}
+};
+
+/*
+ * Generic 'no controller' code
+ */
+static void end_none(unsigned int irq) { }
+static void enable_none(unsigned int irq) { }
+static void disable_none(unsigned int irq) { }
+static void shutdown_none(unsigned int irq) { }
+static unsigned int startup_none(unsigned int irq) { return 0; }
+
+static void ack_none(unsigned int irq)
+{
+	/*
+	 * 'what should we do if we get a hw irq event on an illegal vector'.
+	 * each architecture has to answer this themself.
+	 */
+	ack_bad_irq(irq);
+}
+
+struct hw_interrupt_type no_irq_type = {
+	typename:	"none",
+	startup:	startup_none,
+	shutdown:	shutdown_none,
+	enable:		enable_none,
+	disable:	disable_none,
+	ack:		ack_none,
+	end:		end_none,
+	set_affinity:	NULL
+};
+
+/*
+ * Special, empty irq handler:
+ */
+irqreturn_t no_action(int cpl, void *dev_id, struct pt_regs *regs)
+{
+	return IRQ_NONE;
+}
+
+/*
+ * Exit an interrupt context. Process softirqs if needed and possible:
+ */
+void irq_exit(void)
+{
+	preempt_count() -= IRQ_EXIT_OFFSET;
+	if (!in_interrupt() && local_softirq_pending())
+		do_softirq();
+	preempt_enable_no_resched();
+}
+
+/*
+ * Have got an event to handle:
+ */
+asmlinkage int handle_IRQ_event(unsigned int irq, struct pt_regs *regs,
+				struct irqaction *action)
+{
+	int ret, retval = 0, status = 0;
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
+/*
+ * do_IRQ handles all normal device IRQ's (the special
+ * SMP cross-CPU interrupts have their own specific
+ * handlers).
+ */
+asmlinkage unsigned int __do_IRQ(unsigned int irq, struct pt_regs *regs)
+{
+	irq_desc_t *desc = irq_desc + irq;
+	struct irqaction * action;
+	unsigned int status;
+
+	kstat_this_cpu.irqs[irq]++;
+	if (desc->status & IRQ_PER_CPU) {
+		irqreturn_t action_ret;
+
+		/*
+		 * No locking required for CPU-local interrupts:
+		 */
+		desc->handler->ack(irq);
+		action_ret = handle_IRQ_event(irq, regs, desc->action);
+		if (!noirqdebug)
+			note_interrupt(irq, desc, action_ret);
+		desc->handler->end(irq);
+		return 1;
+	}
+
+	spin_lock(&desc->lock);
+	desc->handler->ack(irq);
+	/*
+	 * REPLAY is when Linux resends an IRQ that was dropped earlier
+	 * WAITING is used by probe to mark irqs that are being tested
+	 */
+	status = desc->status & ~(IRQ_REPLAY | IRQ_WAITING);
+	status |= IRQ_PENDING; /* we _want_ to handle it */
+
+	/*
+	 * If the IRQ is disabled for whatever reason, we cannot
+	 * use the action we have.
+	 */
+	action = NULL;
+	if (likely(!(status & (IRQ_DISABLED | IRQ_INPROGRESS)))) {
+		action = desc->action;
+		status &= ~IRQ_PENDING; /* we commit to handling */
+		status |= IRQ_INPROGRESS; /* we are handling it */
+	}
+	desc->status = status;
+
+	/*
+	 * If there is no IRQ handler or it was disabled, exit early.
+	 * Since we set PENDING, if another processor is handling
+	 * a different instance of this same irq, the other processor
+	 * will take care of it.
+	 */
+	if (unlikely(!action))
+		goto out;
+
+	/*
+	 * Edge triggered interrupts need to remember
+	 * pending events.
+	 * This applies to any hw interrupts that allow a second
+	 * instance of the same irq to arrive while we are in do_IRQ
+	 * or in the handler. But the code here only handles the _second_
+	 * instance of the irq, not the third or fourth. So it is mostly
+	 * useful for irq hardware that does not mask cleanly in an
+	 * SMP environment.
+	 */
+	for (;;) {
+		irqreturn_t action_ret;
+
+		spin_unlock(&desc->lock);
+
+		action_ret = handle_IRQ_event(irq, regs, action);
+
+		spin_lock(&desc->lock);
+		if (!noirqdebug)
+			note_interrupt(irq, desc, action_ret);
+		if (likely(!(desc->status & IRQ_PENDING)))
+			break;
+		desc->status &= ~IRQ_PENDING;
+	}
+	desc->status &= ~IRQ_INPROGRESS;
+
+out:
+	/*
+	 * The ->end() handler has to deal with interrupts which got
+	 * disabled while the handler was running.
+	 */
+	desc->handler->end(irq);
+	spin_unlock(&desc->lock);
+
+	return 1;
+}
+
--- linux/kernel/irq/Makefile.orig
+++ linux/kernel/irq/Makefile
@@ -0,0 +1,4 @@
+
+obj-y := autoprobe.o handle.o manage.o spurious.o
+obj-$(CONFIG_PROC_FS) += proc.o
+
--- linux/kernel/irq/autoprobe.c.orig
+++ linux/kernel/irq/autoprobe.c
@@ -0,0 +1,188 @@
+/*
+ * linux/kernel/irq/autoprobe.c
+ *
+ * Copyright (C) 1992, 1998-2004 Linus Torvalds, Ingo Molnar
+ *
+ * This file contains the interrupt probing code and driver APIs.
+ */
+
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+
+/*
+ * Autodetection depends on the fact that any interrupt that
+ * comes in on to an unassigned handler will get stuck with
+ * "IRQ_WAITING" cleared and the interrupt disabled.
+ */
+static DECLARE_MUTEX(probe_sem);
+
+/**
+ *	probe_irq_on	- begin an interrupt autodetect
+ *
+ *	Commence probing for an interrupt. The interrupts are scanned
+ *	and a mask of potential interrupt lines is returned.
+ *
+ */
+unsigned long probe_irq_on(void)
+{
+	unsigned long val, delay;
+	irq_desc_t *desc;
+	unsigned int i;
+
+	down(&probe_sem);
+	/*
+	 * something may have generated an irq long ago and we want to
+	 * flush such a longstanding irq before considering it as spurious.
+	 */
+	for (i = NR_IRQS-1; i > 0; i--) {
+		desc = irq_desc + i;
+
+		spin_lock_irq(&desc->lock);
+		if (!irq_desc[i].action)
+			irq_desc[i].handler->startup(i);
+		spin_unlock_irq(&desc->lock);
+	}
+
+	/* Wait for longstanding interrupts to trigger. */
+	for (delay = jiffies + HZ/50; time_after(delay, jiffies); )
+		/* about 20ms delay */ barrier();
+
+	/*
+	 * enable any unassigned irqs
+	 * (we must startup again here because if a longstanding irq
+	 * happened in the previous stage, it may have masked itself)
+	 */
+	for (i = NR_IRQS-1; i > 0; i--) {
+		desc = irq_desc + i;
+
+		spin_lock_irq(&desc->lock);
+		if (!desc->action) {
+			desc->status |= IRQ_AUTODETECT | IRQ_WAITING;
+			if (desc->handler->startup(i))
+				desc->status |= IRQ_PENDING;
+		}
+		spin_unlock_irq(&desc->lock);
+	}
+
+	/*
+	 * Wait for spurious interrupts to trigger
+	 */
+	for (delay = jiffies + HZ/10; time_after(delay, jiffies); )
+		/* about 100ms delay */ barrier();
+
+	/*
+	 * Now filter out any obviously spurious interrupts
+	 */
+	val = 0;
+	for (i = 0; i < NR_IRQS; i++) {
+		irq_desc_t *desc = irq_desc + i;
+		unsigned int status;
+
+		spin_lock_irq(&desc->lock);
+		status = desc->status;
+
+		if (status & IRQ_AUTODETECT) {
+			/* It triggered already - consider it spurious. */
+			if (!(status & IRQ_WAITING)) {
+				desc->status = status & ~IRQ_AUTODETECT;
+				desc->handler->shutdown(i);
+			} else
+				if (i < 32)
+					val |= 1 << i;
+		}
+		spin_unlock_irq(&desc->lock);
+	}
+
+	return val;
+}
+
+EXPORT_SYMBOL(probe_irq_on);
+
+/**
+ *	probe_irq_mask - scan a bitmap of interrupt lines
+ *	@val:	mask of interrupts to consider
+ *
+ *	Scan the interrupt lines and return a bitmap of active
+ *	autodetect interrupts. The interrupt probe logic state
+ *	is then returned to its previous value.
+ *
+ *	Note: we need to scan all the irq's even though we will
+ *	only return autodetect irq numbers - just so that we reset
+ *	them all to a known state.
+ */
+unsigned int probe_irq_mask(unsigned long val)
+{
+	unsigned int mask;
+	int i;
+
+	mask = 0;
+	for (i = 0; i < NR_IRQS; i++) {
+		irq_desc_t *desc = irq_desc + i;
+		unsigned int status;
+
+		spin_lock_irq(&desc->lock);
+		status = desc->status;
+
+		if (status & IRQ_AUTODETECT) {
+			if (i < 16 && !(status & IRQ_WAITING))
+				mask |= 1 << i;
+
+			desc->status = status & ~IRQ_AUTODETECT;
+			desc->handler->shutdown(i);
+		}
+		spin_unlock_irq(&desc->lock);
+	}
+	up(&probe_sem);
+
+	return mask & val;
+}
+
+/**
+ *	probe_irq_off	- end an interrupt autodetect
+ *	@val: mask of potential interrupts (unused)
+ *
+ *	Scans the unused interrupt lines and returns the line which
+ *	appears to have triggered the interrupt. If no interrupt was
+ *	found then zero is returned. If more than one interrupt is
+ *	found then minus the first candidate is returned to indicate
+ *	their is doubt.
+ *
+ *	The interrupt probe logic state is returned to its previous
+ *	value.
+ *
+ *	BUGS: When used in a module (which arguably shouldn't happen)
+ *	nothing prevents two IRQ probe callers from overlapping. The
+ *	results of this are non-optimal.
+ */
+int probe_irq_off(unsigned long val)
+{
+	int i, irq_found = 0, nr_irqs = 0;
+
+	for (i = 0; i < NR_IRQS; i++) {
+		irq_desc_t *desc = irq_desc + i;
+		unsigned int status;
+
+		spin_lock_irq(&desc->lock);
+		status = desc->status;
+
+		if (status & IRQ_AUTODETECT) {
+			if (!(status & IRQ_WAITING)) {
+				if (!nr_irqs)
+					irq_found = i;
+				nr_irqs++;
+			}
+			desc->status = status & ~IRQ_AUTODETECT;
+			desc->handler->shutdown(i);
+		}
+		spin_unlock_irq(&desc->lock);
+	}
+	up(&probe_sem);
+
+	if (nr_irqs > 1)
+		irq_found = -irq_found;
+	return irq_found;
+}
+
+EXPORT_SYMBOL(probe_irq_off);
+
--- linux/kernel/irq/internals.h.orig
+++ linux/kernel/irq/internals.h
@@ -0,0 +1,18 @@
+/*
+ * IRQ subsystem internal functions and variables:
+ */
+
+extern int noirqdebug;
+
+#ifdef CONFIG_PROC_FS
+extern void register_irq_proc(unsigned int irq);
+extern void register_handler_proc(unsigned int irq, struct irqaction *action);
+extern void unregister_handler_proc(unsigned int irq, struct irqaction *action);
+#else
+static inline void register_irq_proc(unsigned int irq) { }
+static inline void register_handler_proc(unsigned int irq,
+					 struct irqaction *action) { }
+static inline void unregister_handler_proc(unsigned int irq,
+					   struct irqaction *action) { }
+#endif
+
--- linux/kernel/Makefile.orig
+++ linux/kernel/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_STOP_MACHINE) += stop_machi
 obj-$(CONFIG_AUDIT) += audit.o
 obj-$(CONFIG_AUDITSYSCALL) += auditsc.o
 obj-$(CONFIG_KPROBES) += kprobes.o
+obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
--- linux/include/linux/irq.h.orig
+++ linux/include/linux/irq.h
@@ -13,6 +13,7 @@
 
 #if !defined(CONFIG_ARCH_S390)
 
+#include <linux/linkage.h>
 #include <linux/cache.h>
 #include <linux/spinlock.h>
 #include <linux/cpumask.h>
@@ -71,7 +72,19 @@ extern irq_desc_t irq_desc [NR_IRQS];
 
 #include <asm/hw_irq.h> /* the arch dependent stuff */
 
-extern int setup_irq(unsigned int , struct irqaction * );
+#ifdef CONFIG_GENERIC_HARDIRQS
+extern cpumask_t irq_affinity[NR_IRQS];
+
+extern asmlinkage int handle_IRQ_event(unsigned int irq, struct pt_regs *regs,
+				       struct irqaction *action);
+extern asmlinkage unsigned int __do_IRQ(unsigned int irq, struct pt_regs *regs);
+extern void note_interrupt(unsigned int irq, irq_desc_t *desc, int action_ret);
+extern void report_bad_irq(unsigned int irq, irq_desc_t *desc, int action_ret);
+extern int can_request_irq(unsigned int irq, unsigned long irqflags);
+extern int setup_irq(unsigned int irq, struct irqaction * new);
+
+extern void init_irq_proc(void);
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
@@ -48,6 +50,13 @@ extern int request_irq(unsigned int,
 		       unsigned long, const char *, void *);
 extern void free_irq(unsigned int, void *);
 
+
+#ifdef CONFIG_GENERIC_HARDIRQS
+extern void disable_irq_nosync(unsigned int irq);
+extern void disable_irq(unsigned int irq);
+extern void enable_irq(unsigned int irq);
+#endif
+
 /*
  * Temporary defines for UP kernels, until all code gets fixed.
  */
--- linux/include/linux/hardirq.h.orig
+++ linux/include/linux/hardirq.h
@@ -5,6 +5,40 @@
 #include <linux/smp_lock.h>
 #include <asm/hardirq.h>
 
+#ifdef CONFIG_GENERIC_HARDIRQS
+/*
+ * We put the hardirq and softirq counter into the preemption
+ * counter. The bitmask has the following meaning:
+ *
+ * - bits 0-7 are the preemption count (max preemption depth: 256)
+ * - bits 8-15 are the softirq count (max # of softirqs: 256)
+ * - bits 16-27 are the hardirq count (max # of hardirqs: 4096)
+ *
+ * - ( bit 26 is the PREEMPT_ACTIVE flag. )
+ *
+ * PREEMPT_MASK: 0x000000ff
+ * SOFTIRQ_MASK: 0x0000ff00
+ * HARDIRQ_MASK: 0x0fff0000
+ */
+
+#define PREEMPT_BITS	8
+#define SOFTIRQ_BITS	8
+#define HARDIRQ_BITS	12
+
+#define PREEMPT_SHIFT	0
+#define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
+#define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
+
+/*
+ * The hardirq mask has to be large enough to have
+ * space for potentially all IRQ sources in the system
+ * nesting on a single CPU:
+ */
+#if (1 << HARDIRQ_BITS) < NR_IRQS
+# error HARDIRQ_BITS is too low!
+#endif
+#endif /* CONFIG_GENERIC_HARDIRQS */
+
 #define __IRQ_MASK(x)	((1UL << (x))-1)
 
 #define PREEMPT_MASK	(__IRQ_MASK(PREEMPT_BITS) << PREEMPT_SHIFT)
@@ -43,4 +77,12 @@ extern void synchronize_irq(unsigned int
 # define synchronize_irq(irq)	barrier()
 #endif
 
+#ifdef CONFIG_GENERIC_HARDIRQS
+#define nmi_enter()		(preempt_count() += HARDIRQ_OFFSET)
+#define nmi_exit()		(preempt_count() -= HARDIRQ_OFFSET)
+
+#define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
+extern void irq_exit(void);
+#endif
+
 #endif /* LINUX_HARDIRQ_H */
