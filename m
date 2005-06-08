Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVFHOEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVFHOEo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 10:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVFHOEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 10:04:30 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:16283
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261242AbVFHOCl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 10:02:41 -0400
Subject: [PATCH -RT] Softirq splitting
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: linutronix
Date: Wed, 08 Jun 2005 16:03:29 +0200
Message-Id: <1118239409.20785.628.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch splits the softirq handling into seperate threads. This allows
to prioritize the softirq handling and decouples the various softirqs
from each other.

The split prepares the next logical step to bind specific softirq
processing to an interrupt thread.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


diff --exclude='*~' -urN linux-2.6.12-rc6-rt/include/linux/interrupt.h linux-2.6.12-rc6-rt-work/include/linux/interrupt.h
--- linux-2.6.12-rc6-rt/include/linux/interrupt.h	2005-06-08 00:38:35.000000000 +0200
+++ linux-2.6.12-rc6-rt-work/include/linux/interrupt.h	2005-06-08 15:31:48.000000000 +0200
@@ -113,6 +113,8 @@
 	NET_RX_SOFTIRQ,
 	SCSI_SOFTIRQ,
 	TASKLET_SOFTIRQ
+	/* Entries after this are ignored in the split softirq mode */
+	MAX_SOFTIRQ,
 };
 
 /* softirq mask and active fields moved to irq_cpustat_t in
diff --exclude='*~' -urN linux-2.6.12-rc6-rt/kernel/Makefile linux-2.6.12-rc6-rt-work/kernel/Makefile
--- linux-2.6.12-rc6-rt/kernel/Makefile	2005-06-08 00:38:33.000000000 +0200
+++ linux-2.6.12-rc6-rt-work/kernel/Makefile	2005-06-08 15:30:06.000000000 +0200
@@ -3,12 +3,14 @@
 #
 
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o profile.o \
-	    exit.o itimer.o time.o softirq.o resource.o \
+	    exit.o itimer.o time.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
 	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o
 
+obj-$(CONFIG_SOFTIRQ_ONE) += softirq.o
+obj-$(CONFIG_SOFTIRQ_SPLIT) += softirq-split.o
 obj-$(CONFIG_PREEMPT_RT) += rt.o
 
 obj-$(CONFIG_DEBUG_PREEMPT) += latency.o
diff --exclude='*~' -urN linux-2.6.12-rc6-rt/kernel/softirq-split.c linux-2.6.12-rc6-rt-work/kernel/softirq-split.c
--- linux-2.6.12-rc6-rt/kernel/softirq-split.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.12-rc6-rt-work/kernel/softirq-split.c	2005-06-08 15:46:16.000000000 +0200
@@ -0,0 +1,417 @@
+/*
+ *	linux/kernel/softirq-split.c
+ *
+ * 	Split softirq implementation for enhanced configurability
+ *	and controlability in RT environments
+ *
+ *	Copyright (C) 1992 Linus Torvalds
+ *
+ *	Split implemetation by
+ *	Copyright (C) 2005 Thomas Gleixner 
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/kernel_stat.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/notifier.h>
+#include <linux/percpu.h>
+#include <linux/cpu.h>
+#include <linux/kthread.h>
+#include <linux/rcupdate.h>
+#include <linux/kallsyms.h>
+#include <linux/syscalls.h>
+
+#include <asm/irq.h>
+/*
+   - No shared variables, all the data are CPU local.
+   - If a softirq needs serialization, let it serialize itself
+     by its own spinlocks.
+   - Even if softirq is serialized, only local cpu is marked for
+     execution. Hence, we get something sort of weak cpu binding.
+     Though it is still not clear, will it result in better locality
+     or will not.
+
+   Examples:
+   - NET RX softirq. It is multithreaded and does not require
+     any global serialization.
+   - NET TX softirq. It kicks software netdevice queues, hence
+     it is logically serialized per device, but this serialization
+     is invisible to common code.
+   - Tasklets: serialized wrt itself.
+ */
+
+#ifndef CONFIG_PREEMPT_RT
+# error "Works only with RT-PREEMPT"
+#endif
+
+int softirq_preemption = 1;
+EXPORT_SYMBOL(softirq_preemption);
+
+#ifndef __ARCH_IRQ_STAT
+irq_cpustat_t irq_stat[NR_CPUS] ____cacheline_aligned;
+EXPORT_SYMBOL(irq_stat);
+#endif
+
+static struct softirq_action softirq_vec[32] __cacheline_aligned_in_smp;
+
+/* 
+ * We have to store some more data as the bind cpu arg is not enough for
+ * the split thread implementation 
+ */
+struct softirqdata {
+	int                nr;
+	void               *__bind_cpu;
+	struct task_struct *tsk;
+};
+
+static DEFINE_PER_CPU(struct softirqdata, ksoftirqd[MAX_SOFTIRQ]);
+
+/*
+ * Wakeup the softirq thread for the given softirq
+ */
+void wakeup_softirqd(int softirq)
+{
+	/* Interrupts are disabled: no need to stop preemption */
+	struct task_struct *tsk = __get_cpu_var(ksoftirqd[softirq].tsk);
+
+	if (tsk && tsk->state != TASK_RUNNING)
+		wake_up_process(tsk);
+}
+EXPORT_SYMBOL(wakeup_softirqd);
+
+/*
+ * Wake up the softirq threads which have work
+ */
+static inline void invoke_softirqs(void)
+{
+	u32 pending = local_softirq_pending();
+	int cur = 0;
+
+	while (pending) {
+		if (pending & 1)
+			wakeup_softirqd(cur);
+		pending >>= 1;
+		cur++;
+	}
+}
+
+/*
+ * Solely for net/dev.c
+ */
+asmlinkage void do_softirq(void)
+{
+	invoke_softirqs();
+}
+EXPORT_SYMBOL(do_softirq);
+
+/*
+ * Solely for irq/manage.c compability
+ * Can go away as it is bound to PREEMPT_RT anyway
+ */
+asmlinkage void __do_softirq(void)
+{
+	invoke_softirqs();
+}
+
+/*
+ * Exit an interrupt context. 
+ * No softirq processing here. The softirqs are
+ * threaded and we dont want to interfere here.
+ * The threads are woken up by the according
+ * raise_softirq(NR) in the interrupt threads.
+ */
+void irq_exit(void)
+{
+	account_system_vtime(current);
+	sub_preempt_count(IRQ_EXIT_OFFSET);
+	__preempt_enable_no_resched();
+}
+
+/*
+ * This function must run with irqs disabled!
+ */
+inline fastcall void raise_softirq_irqoff(unsigned int nr)
+{
+	__raise_softirq_irqoff(nr);
+
+	/*
+	 * If we're in an interrupt or softirq, we're done
+	 * (this also catches softirq-disabled code). We will
+	 * actually run the softirq once we return from
+	 * the irq or softirq.
+	 *
+	 * Otherwise we wake up ksoftirqd to make sure we
+	 * schedule the softirq soon.
+	 */
+	if (!in_interrupt())
+		wakeup_softirqd(nr);
+}
+
+EXPORT_SYMBOL(raise_softirq_irqoff);
+
+void fastcall raise_softirq(unsigned int nr)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	raise_softirq_irqoff(nr);
+	local_irq_restore(flags);
+}
+
+void open_softirq(int nr, void (*action)(struct softirq_action*), void *data)
+{
+	softirq_vec[nr].data = data;
+	softirq_vec[nr].action = action;
+}
+
+EXPORT_SYMBOL(open_softirq);
+
+/* Tasklets */
+struct tasklet_head
+{
+	struct tasklet_struct *list;
+};
+
+/* Some compilers disobey section attribute on statics when not
+   initialized -- RR */
+static DEFINE_PER_CPU(struct tasklet_head, tasklet_vec) = { NULL };
+static DEFINE_PER_CPU(struct tasklet_head, tasklet_hi_vec) = { NULL };
+
+void fastcall __tasklet_schedule(struct tasklet_struct *t)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	t->next = __get_cpu_var(tasklet_vec).list;
+	__get_cpu_var(tasklet_vec).list = t;
+	raise_softirq_irqoff(TASKLET_SOFTIRQ);
+	local_irq_restore(flags);
+}
+
+EXPORT_SYMBOL(__tasklet_schedule);
+
+void fastcall __tasklet_hi_schedule(struct tasklet_struct *t)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	t->next = __get_cpu_var(tasklet_hi_vec).list;
+	__get_cpu_var(tasklet_hi_vec).list = t;
+	raise_softirq_irqoff(HI_SOFTIRQ);
+	local_irq_restore(flags);
+}
+
+EXPORT_SYMBOL(__tasklet_hi_schedule);
+
+static void tasklet_action(struct softirq_action *a)
+{
+	struct tasklet_struct *list;
+
+	local_irq_disable();
+	list = __get_cpu_var(tasklet_vec).list;
+	__get_cpu_var(tasklet_vec).list = NULL;
+	local_irq_enable();
+
+	while (list) {
+		struct tasklet_struct *t = list;
+
+		list = list->next;
+
+		if (tasklet_trylock(t)) {
+			if (!atomic_read(&t->count)) {
+				if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
+					BUG();
+				t->func(t->data);
+				tasklet_unlock(t);
+				continue;
+			}
+			tasklet_unlock(t);
+		}
+
+		local_irq_disable();
+		t->next = __get_cpu_var(tasklet_vec).list;
+		__get_cpu_var(tasklet_vec).list = t;
+		__raise_softirq_irqoff(TASKLET_SOFTIRQ);
+		local_irq_enable();
+	}
+}
+
+static void tasklet_hi_action(struct softirq_action *a)
+{
+	struct tasklet_struct *list;
+
+	local_irq_disable();
+	list = __get_cpu_var(tasklet_hi_vec).list;
+	__get_cpu_var(tasklet_hi_vec).list = NULL;
+	local_irq_enable();
+
+	while (list) {
+		struct tasklet_struct *t = list;
+
+		list = list->next;
+
+		if (tasklet_trylock(t)) {
+			if (!atomic_read(&t->count)) {
+				if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
+					BUG();
+				t->func(t->data);
+				tasklet_unlock(t);
+				continue;
+			}
+			tasklet_unlock(t);
+		}
+
+		local_irq_disable();
+		t->next = __get_cpu_var(tasklet_hi_vec).list;
+		__get_cpu_var(tasklet_hi_vec).list = t;
+		__raise_softirq_irqoff(HI_SOFTIRQ);
+		local_irq_enable();
+	}
+}
+
+
+void tasklet_init(struct tasklet_struct *t,
+		  void (*func)(unsigned long), unsigned long data)
+{
+	t->next = NULL;
+	t->state = 0;
+	atomic_set(&t->count, 0);
+	t->func = func;
+	t->data = data;
+}
+
+EXPORT_SYMBOL(tasklet_init);
+
+void tasklet_kill(struct tasklet_struct *t)
+{
+	if (in_interrupt())
+		printk("Attempt to kill tasklet from interrupt\n");
+
+	while (test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
+		do
+			yield();
+		while (test_bit(TASKLET_STATE_SCHED, &t->state));
+	}
+	tasklet_unlock_wait(t);
+	clear_bit(TASKLET_STATE_SCHED, &t->state);
+}
+
+EXPORT_SYMBOL(tasklet_kill);
+
+void __init softirq_init(void)
+{
+	open_softirq(TASKLET_SOFTIRQ, tasklet_action, NULL);
+	open_softirq(HI_SOFTIRQ, tasklet_hi_action, NULL);
+}
+
+static int ksoftirqd(void *__data)
+{
+	struct sched_param param = { .sched_priority = MAX_RT_PRIO/4-1 };
+	struct softirqdata *data = (struct softirqdata*) __data;
+	struct softirq_action *h;
+	u32 msk = (1 << data->nr);
+
+	printk("ksoftirqd %d started up.\n", data->nr);
+	printk("softirq RT prio: %d.\n", param.sched_priority);
+//	sys_sched_setscheduler(current->pid, SCHED_FIFO, &param);
+	set_user_nice(current, -10);
+	current->flags |= PF_NOFREEZE | PF_SOFTIRQ;
+
+	set_current_state(TASK_INTERRUPTIBLE);
+
+	while (!kthread_should_stop()) {
+		preempt_disable();
+		if (!(local_softirq_pending() & msk)) {
+			__preempt_enable_no_resched();
+			schedule();
+			preempt_disable();
+		}
+		__set_current_state(TASK_RUNNING);
+
+		if (cpu_is_offline((long)data->__bind_cpu))
+			goto wait_to_die;
+
+		local_irq_disable();
+		if (local_softirq_pending() & msk) {
+			local_softirq_pending() &= ~msk;
+			__preempt_enable_no_resched();
+			local_irq_enable();
+			h = &softirq_vec[data->nr];
+			if (h)
+				h->action(h);
+		
+			rcu_bh_qsctr_inc(smp_processor_id());
+		} else {
+			local_irq_enable();
+			preempt_enable();
+		}
+		set_current_state(TASK_INTERRUPTIBLE);
+	}
+	__set_current_state(TASK_RUNNING);
+	return 0;
+
+wait_to_die:
+	preempt_enable();
+	/* Wait for kthread_stop */
+	set_current_state(TASK_INTERRUPTIBLE);
+	while (!kthread_should_stop()) {
+		schedule();
+		set_current_state(TASK_INTERRUPTIBLE);
+	}
+	__set_current_state(TASK_RUNNING);
+	return 0;
+}
+
+static int __devinit cpu_callback(struct notifier_block *nfb,
+				  unsigned long action,
+				  void *hcpu)
+{
+	int hotcpu = (unsigned long)hcpu;
+	int i;
+	struct task_struct *p;
+
+	switch (action) {
+	case CPU_UP_PREPARE:
+		/* We may have tasklets already scheduled on
+		   processor 0, so don't check there. */
+		if (hotcpu != 0) {
+			BUG_ON(per_cpu(tasklet_vec, hotcpu).list);
+			BUG_ON(per_cpu(tasklet_hi_vec, hotcpu).list);
+		}
+		for (i = 0; i < MAX_SOFTIRQ; i++) {
+			per_cpu(ksoftirqd[i].nr, hotcpu) = i;
+			per_cpu(ksoftirqd[i].__bind_cpu, hotcpu) = hcpu;
+			p = kthread_create(ksoftirqd, &per_cpu(ksoftirqd[i], hotcpu),
+					   "ksoftirqd/%d/%d", i, hotcpu);
+			if (IS_ERR(p)) {
+				printk("ksoftirqd %d for %i failed\n", i, hotcpu);
+				return NOTIFY_BAD;
+			}
+			kthread_bind(p, hotcpu);
+			per_cpu(ksoftirqd[i].tsk, hotcpu) = p;
+		}
+ 		break;
+	case CPU_ONLINE:
+		for (i = 0; i < MAX_SOFTIRQ; i++)
+			wake_up_process(per_cpu(ksoftirqd[i].tsk, hotcpu));
+		break;
+ 	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block __devinitdata cpu_nfb = {
+	.notifier_call = cpu_callback
+};
+
+__init int spawn_ksoftirqd(void)
+{
+	void *cpu = (void *)(long)smp_processor_id();
+	cpu_callback(&cpu_nfb, CPU_UP_PREPARE, cpu);
+	cpu_callback(&cpu_nfb, CPU_ONLINE, cpu);
+	register_cpu_notifier(&cpu_nfb);
+	return 0;
+}
+
diff --exclude='*~' -urN linux-2.6.12-rc6-rt/lib/Kconfig.RT linux-2.6.12-rc6-rt-work/lib/Kconfig.RT
--- linux-2.6.12-rc6-rt/lib/Kconfig.RT	2005-06-08 00:38:35.000000000 +0200
+++ linux-2.6.12-rc6-rt-work/lib/Kconfig.RT	2005-06-08 15:31:06.000000000 +0200
@@ -150,3 +150,15 @@
 	depends on PREEMPT_RT || !SPINLOCK_BKL
 	default n if !PREEMPT
 	default y
+
+config SOFTIRQ_SPLIT
+	bool "Split softirq threads"
+	depends on PREEMPT_RT
+	default n if !PREEMPT_RT
+	default y
+
+config SOFTIRQ_ONE
+	bool
+	depends on !SOFTIRQ_SPLIT
+	default y
+



