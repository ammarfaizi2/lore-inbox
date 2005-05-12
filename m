Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261962AbVELOcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbVELOcY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 10:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbVELOcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 10:32:24 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:2752 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261962AbVELOam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 10:30:42 -0400
Date: Thu, 12 May 2005 07:30:53 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: dipankar@in.ibm.com, Ingo Molnar <mingo@elte.hu>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] RCU and CONFIG_PREEMPT_RT progress
Message-ID: <20050512143053.GA1291@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050510012444.GA3011@us.ibm.com> <1115755692.26548.15.camel@twins> <20050510202915.GH1566@us.ibm.com> <1115758584.26548.33.camel@twins> <20050510223630.GJ1566@us.ibm.com> <1115886277.3326.16.camel@nspc0585.nedstat.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <1115886277.3326.16.camel@nspc0585.nedstat.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 12, 2005 at 10:24:37AM +0200, Peter Zijlstra wrote:
> On Tue, 2005-05-10 at 15:36 -0700, Paul E. McKenney wrote:

[ . . . ]

> > > > But the flip is an integral part of detecting a grace period.  So, if I
> > > > understand your proposal correctly, I would have to flip to figure out
> > > > when it was safe to flip.
> > > > 
> > > > What am I missing here?
> > > 
> > > 
> > > int can_flip = 1;
> > > int selector = 0;
> > > 
> > > int counter[2] = {0, 0};
> > > 
> > > void up()
> > > {
> > >   ++counter[current->selection = selector];
> > 
> > Suppose task 0 has just fetched the value of "selector".  How does
> > force_grace() know that it is now inappropriate to invert the value
> > of "selector"?
> > 
> > One might suppress preemption, but there can still be interrupts,
> > ECC error correction, and just plain bad luck.  So up() needs to
> > be able to deal with "selector" getting inverted out from under it.
> > 
> > Unless I am missing something still...
> 
> True, I see you point; there is a race between the = and ++ operators.
> 
> current->selection = selector;
> --> gap
> ++counter[current->selection];
> 
> if you flip and the then old current->selection reached 0 before this
> task gets executed again do_grace gets called and cleans the callbacks;
> which should not matter since this task has not yet started using any
> data. however it will be problematic because when it does get scheduled
> again it works on the wrong counter and thus does not prevent a grace
> period on the data will be using.

Yep, that is indeed my concern.

> however I assumed you had these problems solved with your counter-based
> approach. My code was meant to illustrate how I thought your double
> inversion problem could be avoided.
> 
> Do you by any chance have a RCU impl. based on the counter-based
> approach so I can try to understand and maybe try to intergrate my
> ideas?

There are a couple of counter-based implementations out there:

o	The K42/Tornado implementation of RCU.

o	Dipankar Sarma's rcu_preempt-2.5.8-3.patch and
	rcu_poll_preempt-2.5.14-2.patch that were proposed for
	Linux some years back.  These are attached.

Both of these can potentially suffer from huge grace periods, though
the K42/Tornado guys may have come up with some tricks to avoid this
by now.  These long grace periods were why the above patches were
passed over for Linux's RCU.

Both of these also rely on the fact that the time interval between
a pair of counter switches must have context switches on all CPUs
(or threads, depending on the exact implementation).  We need to
avoid this requirement in CONFIG_PREEMPT_RT in order to deal with
small-memory environments.

						Thanx, Paul

--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rcu_preempt-2.5.8-3.patch"

diff -urN linux-2.5.8-base/include/linux/init_task.h linux-2.5.8-rcu/include/linux/init_task.h
--- linux-2.5.8-base/include/linux/init_task.h	Mon Apr 15 00:48:45 2002
+++ linux-2.5.8-rcu/include/linux/init_task.h	Wed Apr 17 14:47:02 2002
@@ -79,6 +79,7 @@
     blocked:		{{0}},						\
     alloc_lock:		SPIN_LOCK_UNLOCKED,				\
     journal_info:	NULL,						\
+    cpu_preempt_cntr:	NULL,					\
 }
 
 
diff -urN linux-2.5.8-base/include/linux/rcupdate.h linux-2.5.8-rcu/include/linux/rcupdate.h
--- linux-2.5.8-base/include/linux/rcupdate.h	Thu Jan  1 05:30:00 1970
+++ linux-2.5.8-rcu/include/linux/rcupdate.h	Wed Apr 17 14:38:14 2002
@@ -0,0 +1,73 @@
+/*
+ * Read-Copy Update mechanism for mutual exclusion 
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (c) International Business Machines Corp., 2001
+ *
+ * Author: Dipankar Sarma <dipankar@in.ibm.com>
+ * 
+ * Based on the original work by Paul McKenney <paul.mckenney@us.ibm.com>
+ * and inputs from Andrea Arcangeli, Rusty Russell, Andi Kleen etc.
+ * Papers:
+ * http://www.rdrop.com/users/paulmck/paper/rclockpdcsproof.pdf
+ * http://lse.sourceforge.net/locking/rclock_OLS.2001.05.01c.sc.pdf (OLS2001)
+ *
+ * For detailed explanation of Read-Copy Update mechanism see -
+ * 		http://lse.sourceforge.net/locking/rcupdate.html
+ *
+ */
+
+#ifndef __LINUX_RCUPDATE_H
+#define __LINUX_RCUPDATE_H
+
+#include <linux/list.h>
+#include <linux/smp.h>
+
+/*
+ * Callback structure for use with call_rcu(). 
+ */
+struct rcu_head {
+	struct list_head list;
+	void (*func)(void *obj);
+	void *arg;
+};
+
+#define RCU_HEAD_INIT(head) { LIST_HEAD_INIT(head.list), NULL, NULL }
+#define RCU_HEAD(head) struct rcu_head head = RCU_HEAD_INIT(head)
+#define INIT_RCU_HEAD(ptr) do { \
+	INIT_LIST_HEAD(&(ptr)->list); (ptr)->func = NULL; (ptr)->arg = NULL; \
+} while (0)
+
+/* Batch counter type. */
+typedef long rcu_batch_t;
+
+/*
+ * RCU_BATCH_XX(rcu_batch_t a, rcu_batch_t b)
+ * 
+ * Returns true if batch number ``a'' compares as specified to ``b''.
+ * This comparison allows for the fact that the batch numbers wrap.
+ */
+#define RCU_BATCH_EQ(a, b)		((a) - (b) == 0)
+#define RCU_BATCH_GE(a, b)		((a) - (b) >= 0)
+#define RCU_BATCH_GT(a, b)		((a) - (b) > 0)
+#define RCU_BATCH_LE(a, b)		((a) - (b) <= 0)
+#define RCU_BATCH_LT(a, b)		((a) - (b) < 0)
+#define RCU_BATCH_NE(a, b)		((a) - (b) != 0)
+
+extern void call_rcu(struct rcu_head *head, void (*func)(void *arg), void *arg);
+extern void synchronize_kernel(void);
+
+#endif /* __LINUX_RCUPDATE_H */
diff -urN linux-2.5.8-base/include/linux/sched.h linux-2.5.8-rcu/include/linux/sched.h
--- linux-2.5.8-base/include/linux/sched.h	Mon Apr 15 00:48:45 2002
+++ linux-2.5.8-rcu/include/linux/sched.h	Fri Apr 19 22:10:43 2002
@@ -28,6 +28,7 @@
 #include <linux/securebits.h>
 #include <linux/fs_struct.h>
 #include <linux/compiler.h>
+#include <linux/percpu.h>
 
 struct exec_domain;
 
@@ -346,6 +347,7 @@
 
 /* journalling filesystem info */
 	void *journal_info;
+	atomic_t *cpu_preempt_cntr;
 };
 
 extern void __put_task_struct(struct task_struct *tsk);
@@ -418,6 +420,7 @@
 
 extern struct   mm_struct init_mm;
 extern struct task_struct *init_tasks[NR_CPUS];
+extern long cpu_quiescent __per_cpu_data;
 
 /* PID hashing. (shouldnt this be dynamic?) */
 #define PIDHASH_SZ (4096 >> 2)
@@ -883,6 +886,53 @@
 		clear_thread_flag(TIF_SIGPENDING);
 }
 
+#ifdef CONFIG_PREEMPT
+
+extern atomic_t rcu_preempt_cntr[2] __per_cpu_data;
+extern atomic_t *curr_preempt_cntr __per_cpu_data;
+extern atomic_t *next_preempt_cntr __per_cpu_data;
+
+static inline void rcu_switch_preempt_cntr(int cpu)
+{
+	atomic_t *tmp;
+	tmp = per_cpu(curr_preempt_cntr, cpu);
+	per_cpu(curr_preempt_cntr, cpu) = per_cpu(next_preempt_cntr, cpu);
+	per_cpu(next_preempt_cntr, cpu) = tmp;
+
+}
+
+static inline void rcu_preempt_put(void)
+{
+	if (unlikely(current->cpu_preempt_cntr != NULL)) {
+		atomic_dec(current->cpu_preempt_cntr);
+		current->cpu_preempt_cntr = NULL;
+	}
+}
+
+/* Must not be preempted */
+static inline void rcu_preempt_get(void)
+{
+	if (likely(current->cpu_preempt_cntr == NULL)) {
+		current->cpu_preempt_cntr = 
+				this_cpu(next_preempt_cntr);
+		atomic_inc(current->cpu_preempt_cntr);
+	}
+}
+
+static inline int rcu_cpu_preempted(int cpu)
+{
+	return (atomic_read(per_cpu(curr_preempt_cntr, cpu)) != 0);
+}
+#else
+
+#define rcu_init_preempt_cntr(cpu) do { } while(0)
+#define rcu_switch_preempt_cntr(cpu) do { } while(0)
+#define rcu_preempt_put() do { } while(0)
+#define rcu_preempt_get() do { } while(0)
+#define rcu_cpu_preempted(cpu) (0)
+
+#endif
+
 #endif /* __KERNEL__ */
 
 #endif
diff -urN linux-2.5.8-base/kernel/Makefile linux-2.5.8-rcu/kernel/Makefile
--- linux-2.5.8-base/kernel/Makefile	Mon Apr 15 00:48:47 2002
+++ linux-2.5.8-rcu/kernel/Makefile	Tue Apr 16 12:32:09 2002
@@ -10,12 +10,12 @@
 O_TARGET := kernel.o
 
 export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
-		printk.o platform.o 
+		printk.o platform.o rcupdate.o
 
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o futex.o platform.o
+	    signal.o sys.o kmod.o context.o futex.o platform.o rcupdate.o
 
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
diff -urN linux-2.5.8-base/kernel/exit.c linux-2.5.8-rcu/kernel/exit.c
--- linux-2.5.8-base/kernel/exit.c	Mon Apr 15 00:48:49 2002
+++ linux-2.5.8-rcu/kernel/exit.c	Wed Apr 17 11:25:01 2002
@@ -518,6 +518,7 @@
 
 	tsk->exit_code = code;
 	exit_notify();
+	rcu_preempt_put();
 	schedule();
 	BUG();
 /*
diff -urN linux-2.5.8-base/kernel/rcupdate.c linux-2.5.8-rcu/kernel/rcupdate.c
--- linux-2.5.8-base/kernel/rcupdate.c	Thu Jan  1 05:30:00 1970
+++ linux-2.5.8-rcu/kernel/rcupdate.c	Fri Apr 19 16:59:03 2002
@@ -0,0 +1,393 @@
+/*
+ * Read-Copy Update mechanism for mutual exclusion
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (c) International Business Machines Corp., 2001
+ *
+ * Author: Dipankar Sarma <dipankar@in.ibm.com>
+ * 
+ * Based on the original work by Paul McKenney <paul.mckenney@us.ibm.com>
+ * and inputs from Andrea Arcangeli, Rusty Russell, Andi Kleen etc.
+ *
+ * Papers:
+ * http://www.rdrop.com/users/paulmck/paper/rclockpdcsproof.pdf
+ * http://lse.sourceforge.net/locking/rclock_OLS.2001.05.01c.sc.pdf (OLS2001)
+ *
+ * For detailed explanation of Read-Copy Update mechanism see -
+ * 		http://lse.sourceforge.net/locking/rcupdate.html
+ *
+ */
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/config.h>
+#include <linux/spinlock.h>
+#include <linux/smp.h>
+#include <linux/interrupt.h>
+#include <linux/sched.h>
+#include <asm/atomic.h>
+#include <asm/bitops.h>
+#include <linux/module.h>
+#include <linux/completion.h>
+#include <linux/smp.h>
+#include <linux/init.h>
+#include <linux/percpu.h>
+#include <linux/rcupdate.h>
+
+/*
+ * Per-CPU data for Read-Copy UPdate.
+ * We maintain callbacks in 3 per-cpu lists. Each list represents
+ * a batch and every batch is given a number that is global across
+ * all CPUs. The global current batch number (curbatch) represents
+ * the current batch of callbacks for which the quiescent cycle
+ * has started.
+ * rcu_nextlist - new callbacks are added here
+ * rcu_currlist - current batch for which quiescent cycle started if any
+ * rcu_donelist - one or more batches that have finished waiting to be invoked
+ */
+
+static long rcu_last_qsctr __per_cpu_data;
+static rcu_batch_t rcu_batch __per_cpu_data;
+static struct list_head  rcu_nextlist __per_cpu_data;
+struct list_head  rcu_currlist __per_cpu_data;
+struct list_head  rcu_donelist __per_cpu_data;
+struct tasklet_struct  rcu_tasklet __per_cpu_data;
+struct task_struct *rcu_task __per_cpu_data;
+struct semaphore rcu_sema __per_cpu_data;
+
+#define RCU_QSCTR_INVALID	0
+
+static spinlock_t	rcu_lock = SPIN_LOCK_UNLOCKED;
+static rcu_batch_t	rcu_curbatch = 1; /* Current batch number */
+static rcu_batch_t	rcu_maxbatch = 1; /* Max requested batch number*/
+
+
+/* CPUs that need to switch in order for current RCU batch to proceed */
+static unsigned long	rcu_cpumask = 0; 	
+/* CPUs that have active RCUs */
+static unsigned long	rcu_active_cpumask = 0;
+/* Global timer to nudge CPUs */
+static struct timer_list rcu_timer;	
+
+asmlinkage long sys_sched_get_priority_max(int policy);
+
+/*
+ * Register a new rcu callback. This will be invoked as soon
+ * as all CPUs have performed a context switch or been seen in the
+ * idle loop or in a user process.
+ */
+void call_rcu(struct rcu_head *head, void (*func)(void *arg), void *arg)
+{
+	unsigned long flags;
+
+	head->func = func;
+	head->arg = arg;
+	local_irq_save(flags);
+	list_add_tail(&head->list, &this_cpu(rcu_nextlist));
+	local_irq_restore(flags);
+	tasklet_schedule(&this_cpu(rcu_tasklet));
+}
+
+/*
+ * Invoke the completed RCU callbacks. They are expected to be in
+ * a per-cpu list.
+ */
+static inline void rcu_invoke_callbacks(struct list_head *list)
+{
+	struct list_head *entry;
+	struct rcu_head *head;
+
+	while (!list_empty(list)) {
+		entry = list->next;
+		list_del(entry);
+		head = list_entry(entry, struct rcu_head, list);
+		head->func(head->arg);
+	}
+}
+
+/*
+ * Register a new batch of callbacks with the global state maintainers.
+ * Caller must hold the rcu global lock.
+ */
+static inline void rcu_reg_batch(rcu_batch_t newbatch)
+{
+	int cpu = cpu_number_map(smp_processor_id());
+	
+	if (RCU_BATCH_LT(rcu_maxbatch, newbatch)) {
+		rcu_maxbatch = newbatch;
+	}
+	if (RCU_BATCH_LT(rcu_maxbatch, rcu_curbatch) || (rcu_cpumask != 0)) {
+		return;
+	}
+	rcu_cpumask = cpu_online_map;
+	rcu_switch_preempt_cntr(cpu);
+}
+
+/*
+ * Check if the cpu has gone through a quiescent state.
+ * If so and if it already hasn't done so in this RCU
+ * quiescent cycle, then indicate that it has done so.
+ */
+static void rcu_check_quiescent_state(void)
+{
+	int cpu = cpu_number_map(smp_processor_id());
+
+	if (!test_bit(cpu, &rcu_cpumask)) {
+		return;
+	}
+
+	/* 
+	 * May race with rcu per-cpu tick - in the worst case
+	 * we may miss one quiescent state of that CPU. That is
+	 * tolerable. So no need to disable interrupts.
+	 */
+	if (this_cpu(rcu_last_qsctr) == RCU_QSCTR_INVALID) {
+		this_cpu(rcu_last_qsctr) = this_cpu(cpu_quiescent);
+		return;
+	}
+	if (this_cpu(cpu_quiescent) == this_cpu(rcu_last_qsctr) ||
+		rcu_cpu_preempted(cpu)) {
+		return;
+	}
+
+	spin_lock(&rcu_lock);
+	if (!test_bit(cpu, &rcu_cpumask)) {
+		spin_unlock(&rcu_lock);
+		return;
+	}
+	clear_bit(cpu, &rcu_cpumask);
+	this_cpu(rcu_last_qsctr) = RCU_QSCTR_INVALID;
+	if (rcu_cpumask != 0) {
+		/* All CPUs haven't gone through a quiescent state */
+		spin_unlock(&rcu_lock);
+		return;
+	}
+	rcu_curbatch++;
+	rcu_reg_batch(rcu_maxbatch);
+	spin_unlock(&rcu_lock);
+}
+
+static void rcu_move_next_batch(void)
+{
+	int rcu_timer_active;
+	int cpu = cpu_number_map(smp_processor_id());
+
+	local_irq_disable();
+	if (!list_empty(&this_cpu(rcu_nextlist)) && 
+			list_empty(&this_cpu(rcu_currlist))) {
+		list_splice(&this_cpu(rcu_nextlist), &this_cpu(rcu_currlist));
+		INIT_LIST_HEAD(&this_cpu(rcu_nextlist));
+		local_irq_enable();
+
+		/*
+		 * start the next batch of callbacks
+		 */
+		spin_lock(&rcu_lock);
+		rcu_timer_active = (rcu_active_cpumask != 0);
+		if (!test_bit(cpu, &rcu_active_cpumask))
+			set_bit(cpu, &rcu_active_cpumask);
+		if (!rcu_timer_active && 
+		    !timer_pending(&rcu_timer)) {
+			rcu_timer.expires = jiffies + 5;
+			add_timer(&rcu_timer);
+		}
+		this_cpu(rcu_batch) = rcu_curbatch + 1;
+		rcu_reg_batch(this_cpu(rcu_batch));
+		spin_unlock(&rcu_lock);
+	} else {
+		local_irq_enable();
+	}
+}
+
+/*
+ * Look into the per-cpu callback information to see if there is
+ * any processing necessary - if so do it.
+ */
+static void rcu_process_callbacks(unsigned long data)
+{
+	int cpu = cpu_number_map(smp_processor_id());
+
+	if (!list_empty(&this_cpu(rcu_currlist)) &&
+	    RCU_BATCH_GT(rcu_curbatch, this_cpu(rcu_batch))) {
+		list_splice(&this_cpu(rcu_currlist), &this_cpu(rcu_donelist));
+		INIT_LIST_HEAD(&this_cpu(rcu_currlist));
+	}
+
+	rcu_move_next_batch();
+
+	/* 
+	 * No race between nxtlist here & call_rcu() from irq -
+         * call_rcu() will anyway reschedule the tasklet so if the
+	 * bit in cpu_active_mask gets cleared, it will get set again.
+	 */
+	if (list_empty(&this_cpu(rcu_nextlist)) && 
+			list_empty(&this_cpu(rcu_currlist))) {
+		spin_lock(&rcu_lock);
+		clear_bit(cpu, &rcu_active_cpumask);
+		spin_unlock(&rcu_lock);
+	}
+	rcu_check_quiescent_state();
+
+	if (!list_empty(&this_cpu(rcu_donelist))) {
+		rcu_invoke_callbacks(&this_cpu(rcu_donelist));
+	}
+}
+
+/*
+ * Per-cpu tick that processes per-cpu queues
+ */
+static void rcu_percpu_tick_common(void)
+{
+	/* Take this opportunity to check for idle loop */
+	if (idle_cpu(smp_processor_id()))
+		this_cpu(cpu_quiescent)++;
+	rcu_process_callbacks(0);
+}
+
+
+#ifdef CONFIG_SMP
+static void rcu_percpu_tick(void)
+{
+	int cpu;
+
+	for (cpu = 0; cpu < smp_num_cpus; cpu++) {
+		up(&per_cpu(rcu_sema, cpu));
+	}
+}
+#else
+static void rcu_percpu_tick(void)
+{
+	rcu_percpu_tick_common();
+}
+#endif
+
+/*
+ * RCU timer handler - called one in every 50ms only if there is
+ * any RCU pending in the system. It nudges every CPU.
+ */
+static void rcu_timer_handler(unsigned long data)
+{
+	rcu_percpu_tick();
+	spin_lock(&rcu_lock);
+	if (rcu_active_cpumask) {
+		rcu_timer.expires = jiffies + 5;
+		add_timer(&rcu_timer);
+	}
+	spin_unlock(&rcu_lock);
+
+}
+
+#ifdef CONFIG_SMP
+/*
+ * Per-CPU RCU dameon. It runs at an absurdly high priority so
+ * that it is not starved out by the scheduler thereby holding
+ * up RC updates.
+ */
+static int krcud(void * __bind_cpu)
+{
+	int bind_cpu = *(int *) __bind_cpu;
+	int cpu = cpu_logical_map(bind_cpu);
+
+	daemonize();
+        current->policy = SCHED_FIFO;
+        current->rt_priority = 1001 + sys_sched_get_priority_max(SCHED_FIFO);
+
+	sigfillset(&current->blocked);
+
+	/* Migrate to the right CPU */
+	set_cpus_allowed(current, 1UL << cpu);
+
+	sprintf(current->comm, "krcud_CPU%d", bind_cpu);
+	sema_init(&this_cpu(rcu_sema), 0);
+
+	this_cpu(rcu_task) = current;
+
+	for (;;) {
+		while (down_interruptible(&this_cpu(rcu_sema)));
+		local_bh_disable();
+		rcu_percpu_tick_common();
+		local_bh_enable();
+	}
+}
+
+static void spawn_krcud(void)
+{
+	int cpu;
+
+	for (cpu = 0; cpu < smp_num_cpus; cpu++) {
+		if (kernel_thread(krcud, (void *) &cpu,
+				  CLONE_FS | CLONE_FILES | CLONE_SIGNAL) < 0)
+			printk(KERN_ERR "spawn_krcud() failed for cpu %d\n", 
+									cpu);
+		else {
+			while (!per_cpu(rcu_task, cpu)) {
+				schedule();
+			}
+		}
+	}
+}
+
+#endif
+
+/*
+ * Initializes rcu mechanism.  Assumed to be called early.
+ * That is before local timer(SMP) or jiffie timer (uniproc) is setup.
+ * Note that cpu_quiescent and friends are implicitly
+ * initialized due to the choice of ``0'' for RCU_CTR_INVALID.
+ */
+static __init int rcu_init(void)
+{
+	int i;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		tasklet_init(&per_cpu(rcu_tasklet, i), 
+				rcu_process_callbacks, 0UL);
+		INIT_LIST_HEAD(&per_cpu(rcu_nextlist, i));
+		INIT_LIST_HEAD(&per_cpu(rcu_currlist, i));
+		INIT_LIST_HEAD(&per_cpu(rcu_donelist, i));
+	}
+	init_timer(&rcu_timer);
+	rcu_timer.function = rcu_timer_handler;
+#ifdef CONFIG_SMP
+	spawn_krcud();
+#endif
+	return 0;
+}
+
+/* Because of FASTCALL declaration of complete, we use this wrapper */
+static void wakeme_after_rcu(void *completion)
+{
+	complete(completion);
+}
+
+/*
+ * Wait until all the CPUs have gone through a "quiescent" state.
+ */
+void synchronize_kernel(void)
+{
+	struct rcu_head rcu;
+	DECLARE_COMPLETION(completion);
+
+	/* Will wake me after RCU finished */
+	call_rcu(&rcu, wakeme_after_rcu, &completion);
+
+	/* Wait for it */
+	wait_for_completion(&completion);
+}
+
+__initcall(rcu_init);
+
+EXPORT_SYMBOL(call_rcu);
+EXPORT_SYMBOL(synchronize_kernel);
diff -urN linux-2.5.8-base/kernel/sched.c linux-2.5.8-rcu/kernel/sched.c
--- linux-2.5.8-base/kernel/sched.c	Mon Apr 15 00:48:47 2002
+++ linux-2.5.8-rcu/kernel/sched.c	Fri Apr 19 18:26:09 2002
@@ -17,11 +17,13 @@
 #include <linux/init.h>
 #include <asm/uaccess.h>
 #include <linux/highmem.h>
+#include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <asm/mmu_context.h>
 #include <linux/interrupt.h>
 #include <linux/completion.h>
 #include <linux/kernel_stat.h>
+#include <linux/percpu.h>
 
 /*
  * Priority of a process goes from 0 to 139. The 0-99
@@ -150,6 +152,7 @@
 } ____cacheline_aligned;
 
 static struct runqueue runqueues[NR_CPUS] __cacheline_aligned;
+long cpu_quiescent __per_cpu_data;
 
 #define cpu_rq(cpu)		(runqueues + (cpu))
 #define this_rq()		cpu_rq(smp_processor_id())
@@ -157,6 +160,24 @@
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 #define rt_task(p)		((p)->prio < MAX_RT_PRIO)
 
+#ifdef CONFIG_PREEMPT
+atomic_t rcu_preempt_cntr[2] __per_cpu_data;
+atomic_t *curr_preempt_cntr __per_cpu_data;
+atomic_t *next_preempt_cntr __per_cpu_data;
+#endif
+
+#ifdef CONFIG_PREEMPT
+static inline void rcu_init_preempt_cntr(int cpu)
+{
+        atomic_set(&per_cpu(rcu_preempt_cntr[0], cpu), 0);
+        atomic_set(&per_cpu(rcu_preempt_cntr[1], cpu), 0);
+	per_cpu(curr_preempt_cntr, cpu) = 
+			&per_cpu(rcu_preempt_cntr[1], cpu);
+	per_cpu(next_preempt_cntr, cpu) = 
+			&per_cpu(rcu_preempt_cntr[0], cpu);
+}
+#endif
+
 static inline runqueue_t *task_rq_lock(task_t *p, unsigned long *flags)
 {
 	struct runqueue *rq;
@@ -768,8 +789,11 @@
 	 * if entering from preempt_schedule, off a kernel preemption,
 	 * go straight to picking the next task.
 	 */
-	if (unlikely(preempt_get_count() & PREEMPT_ACTIVE))
+	if (unlikely(preempt_get_count() & PREEMPT_ACTIVE)) {
 		goto pick_next_task;
+	} else {
+		rcu_preempt_put();
+	}
 	
 	switch (prev->state) {
 	case TASK_INTERRUPTIBLE:
@@ -812,6 +836,7 @@
 switch_tasks:
 	prefetch(next);
 	clear_tsk_need_resched(prev);
+	per_cpu(cpu_quiescent, prev->thread_info->cpu)++;
 
 	if (likely(prev != next)) {
 		rq->nr_switches++;
@@ -852,6 +877,7 @@
 		return;
 
 	ti->preempt_count = PREEMPT_ACTIVE;
+	rcu_preempt_get();
 	schedule();
 	ti->preempt_count = 0;
 	barrier();
@@ -1575,6 +1601,7 @@
 		spin_lock_init(&rq->lock);
 		spin_lock_init(&rq->frozen);
 		INIT_LIST_HEAD(&rq->migration_queue);
+		rcu_init_preempt_cntr(i);
 
 		for (j = 0; j < 2; j++) {
 			array = rq->arrays + j;

--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rcu_poll_preempt-2.5.14-2.patch"

diff -urN linux-2.5.14-base/include/linux/init_task.h linux-2.5.14-rcu_poll_preempt/include/linux/init_task.h
--- linux-2.5.14-base/include/linux/init_task.h	Mon May  6 09:07:54 2002
+++ linux-2.5.14-rcu_poll_preempt/include/linux/init_task.h	Tue May  7 17:23:51 2002
@@ -79,6 +79,7 @@
     blocked:		{{0}},						\
     alloc_lock:		SPIN_LOCK_UNLOCKED,				\
     journal_info:	NULL,						\
+    cpu_preempt_cntr:	NULL,					\
 }
 
 
diff -urN linux-2.5.14-base/include/linux/rcupdate.h linux-2.5.14-rcu_poll_preempt/include/linux/rcupdate.h
--- linux-2.5.14-base/include/linux/rcupdate.h	Thu Jan  1 05:30:00 1970
+++ linux-2.5.14-rcu_poll_preempt/include/linux/rcupdate.h	Tue May  7 17:23:51 2002
@@ -0,0 +1,71 @@
+/*
+ * Read-Copy Update mechanism for mutual exclusion 
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (c) International Business Machines Corp., 2001
+ *
+ * Author: Dipankar Sarma <dipankar@in.ibm.com>
+ * 
+ * Based on the original work by Paul McKenney <paul.mckenney@us.ibm.com>
+ * and inputs from Andrea Arcangeli, Rusty Russell, Andi Kleen etc.
+ * Papers:
+ * http://www.rdrop.com/users/paulmck/paper/rclockpdcsproof.pdf
+ * http://lse.sourceforge.net/locking/rclock_OLS.2001.05.01c.sc.pdf (OLS2001)
+ *
+ * For detailed explanation of Read-Copy Update mechanism see -
+ * 		http://lse.sourceforge.net/locking/rcupdate.html
+ *
+ */
+
+#ifndef __LINUX_RCUPDATE_H
+#define __LINUX_RCUPDATE_H
+
+#include <linux/list.h>
+
+/*
+ * Callback structure for use with call_rcu(). 
+ */
+struct rcu_head {
+	struct list_head list;
+	void (*func)(void *obj);
+	void *arg;
+};
+
+#define RCU_HEAD_INIT(head) { LIST_HEAD_INIT(head.list), NULL, NULL }
+#define RCU_HEAD(head) struct rcu_head head = RCU_HEAD_INIT(head)
+#define INIT_RCU_HEAD(ptr) do { \
+	INIT_LIST_HEAD(&(ptr)->list); (ptr)->func = NULL; (ptr)->arg = NULL; \
+} while (0)
+
+
+extern void FASTCALL(call_rcu(struct rcu_head *head, void (*func)(void *arg), void *arg));
+
+#ifdef CONFIG_PREEMPT
+extern void FASTCALL(call_rcu_preempt(struct rcu_head *head, void (*func)(void *arg), void *arg));
+#else
+static inline void call_rcu_preempt(struct rcu_head *head, 
+                               void (*func)(void *arg), void *arg)
+{
+	call_rcu(head, func, arg);
+}
+#endif
+
+extern void synchronize_kernel(void);
+extern void synchronize_kernel(void);
+
+extern void rcu_init(void);
+
+#endif /* __LINUX_RCUPDATE_H */
diff -urN linux-2.5.14-base/include/linux/sched.h linux-2.5.14-rcu_poll_preempt/include/linux/sched.h
--- linux-2.5.14-base/include/linux/sched.h	Mon May  6 09:07:54 2002
+++ linux-2.5.14-rcu_poll_preempt/include/linux/sched.h	Tue May  7 17:23:51 2002
@@ -28,6 +28,7 @@
 #include <linux/securebits.h>
 #include <linux/fs_struct.h>
 #include <linux/compiler.h>
+#include <linux/percpu.h>
 
 struct exec_domain;
 
@@ -162,6 +163,7 @@
 extern void flush_scheduled_tasks(void);
 extern int start_context_thread(void);
 extern int current_is_keventd(void);
+extern void force_cpu_reschedule(int cpu);
 
 struct namespace;
 
@@ -347,6 +349,7 @@
 /* journalling filesystem info */
 	void *journal_info;
 	struct dentry *proc_dentry;
+	atomic_t *cpu_preempt_cntr;
 };
 
 extern void __put_task_struct(struct task_struct *tsk);
@@ -419,6 +422,7 @@
 
 extern struct   mm_struct init_mm;
 extern struct task_struct *init_tasks[NR_CPUS];
+extern long cpu_quiescent __per_cpu_data;
 
 /* PID hashing. (shouldnt this be dynamic?) */
 #define PIDHASH_SZ (4096 >> 2)
@@ -876,6 +880,53 @@
 		clear_thread_flag(TIF_SIGPENDING);
 }
 
+#ifdef CONFIG_PREEMPT
+
+extern atomic_t rcu_preempt_cntr[2] __per_cpu_data;
+extern atomic_t *curr_preempt_cntr __per_cpu_data;
+extern atomic_t *next_preempt_cntr __per_cpu_data;
+
+static inline void rcu_switch_preempt_cntr(int cpu)
+{
+	atomic_t *tmp;
+	tmp = per_cpu(curr_preempt_cntr, cpu);
+	per_cpu(curr_preempt_cntr, cpu) = per_cpu(next_preempt_cntr, cpu);
+	per_cpu(next_preempt_cntr, cpu) = tmp;
+
+}
+
+static inline void rcu_preempt_put(void)
+{
+	if (unlikely(current->cpu_preempt_cntr != NULL)) {
+		atomic_dec(current->cpu_preempt_cntr);
+		current->cpu_preempt_cntr = NULL;
+	}
+}
+
+/* Must not be preempted */
+static inline void rcu_preempt_get(void)
+{
+	if (likely(current->cpu_preempt_cntr == NULL)) {
+		current->cpu_preempt_cntr = 
+				this_cpu(next_preempt_cntr);
+		atomic_inc(current->cpu_preempt_cntr);
+	}
+}
+
+static inline int rcu_cpu_preempted(int cpu)
+{
+	return (atomic_read(per_cpu(curr_preempt_cntr, cpu)) != 0);
+}
+#else
+
+#define rcu_init_preempt_cntr(cpu) do { } while(0)
+#define rcu_switch_preempt_cntr(cpu) do { } while(0)
+#define rcu_preempt_put() do { } while(0)
+#define rcu_preempt_get() do { } while(0)
+#define rcu_cpu_preempted(cpu) (0)
+
+#endif
+
 #endif /* __KERNEL__ */
 
 #endif
diff -urN linux-2.5.14-base/init/main.c linux-2.5.14-rcu_poll_preempt/init/main.c
--- linux-2.5.14-base/init/main.c	Mon May  6 09:07:56 2002
+++ linux-2.5.14-rcu_poll_preempt/init/main.c	Tue May  7 17:23:51 2002
@@ -28,6 +28,7 @@
 #include <linux/bootmem.h>
 #include <linux/tty.h>
 #include <linux/percpu.h>
+#include <linux/rcupdate.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -346,6 +347,7 @@
 	printk("Kernel command line: %s\n", saved_command_line);
 	parse_options(command_line);
 	trap_init();
+	rcu_init();
 	init_IRQ();
 	sched_init();
 	softirq_init();
diff -urN linux-2.5.14-base/kernel/Makefile linux-2.5.14-rcu_poll_preempt/kernel/Makefile
--- linux-2.5.14-base/kernel/Makefile	Mon May  6 09:07:56 2002
+++ linux-2.5.14-rcu_poll_preempt/kernel/Makefile	Tue May  7 17:23:51 2002
@@ -10,12 +10,12 @@
 O_TARGET := kernel.o
 
 export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
-		printk.o platform.o 
+		printk.o platform.o rcupdate.o
 
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o futex.o platform.o
+	    signal.o sys.o kmod.o context.o futex.o platform.o rcupdate.o
 
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
diff -urN linux-2.5.14-base/kernel/exit.c linux-2.5.14-rcu_poll_preempt/kernel/exit.c
--- linux-2.5.14-base/kernel/exit.c	Mon May  6 09:07:59 2002
+++ linux-2.5.14-rcu_poll_preempt/kernel/exit.c	Tue May  7 17:23:51 2002
@@ -550,6 +550,7 @@
 
 	tsk->exit_code = code;
 	exit_notify();
+	rcu_preempt_put();
 	schedule();
 	BUG();
 /*
diff -urN linux-2.5.14-base/kernel/fork.c linux-2.5.14-rcu_poll_preempt/kernel/fork.c
--- linux-2.5.14-base/kernel/fork.c	Mon May  6 09:07:54 2002
+++ linux-2.5.14-rcu_poll_preempt/kernel/fork.c	Tue May  7 17:23:51 2002
@@ -117,6 +117,7 @@
 	tsk->thread_info = ti;
 	ti->task = tsk;
 	atomic_set(&tsk->usage,1);
+	tsk->cpu_preempt_cntr = NULL;
 
 	return tsk;
 }
diff -urN linux-2.5.14-base/kernel/rcupdate.c linux-2.5.14-rcu_poll_preempt/kernel/rcupdate.c
--- linux-2.5.14-base/kernel/rcupdate.c	Thu Jan  1 05:30:00 1970
+++ linux-2.5.14-rcu_poll_preempt/kernel/rcupdate.c	Tue May  7 17:23:51 2002
@@ -0,0 +1,285 @@
+/*
+ * Read-Copy Update mechanism for mutual exclusion
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (c) International Business Machines Corp., 2001
+ * Copyright (C) Andrea Arcangeli <andrea@suse.de> SuSE, 2001
+ *
+ * Author: Dipankar Sarma <dipankar@in.ibm.com>,
+ *	   Andrea Arcangeli <andrea@suse.de>
+ * 
+ * Based on the original work by Paul McKenney <paul.mckenney@us.ibm.com>
+ * and inputs from Andrea Arcangeli, Rusty Russell, Andi Kleen etc.
+ * Papers:
+ * http://www.rdrop.com/users/paulmck/paper/rclockpdcsproof.pdf
+ * http://lse.sourceforge.net/locking/rclock_OLS.2001.05.01c.sc.pdf (OLS2001)
+ *
+ * For detailed explanation of Read-Copy Update mechanism see -
+ * 		http://lse.sourceforge.net/locking/rcupdate.html
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/sched.h>
+#include <linux/smp.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/completion.h>
+#include <linux/percpu.h>
+#include <linux/rcupdate.h>
+
+/* Definition for rcupdate internal data. */
+struct rcu_data {
+	spinlock_t lock;
+	struct list_head nxtlist;
+	struct list_head curlist;
+	struct tasklet_struct tasklet;
+	unsigned long qsmask;
+	int polling_in_progress;
+	long quiescent_checkpoint[NR_CPUS];
+};
+
+struct rcu_data rcu_data; 
+
+#ifdef CONFIG_PREEMPT
+struct rcu_data rcu_data_preempt;
+#endif
+
+#define RCU_quiescent(cpu) per_cpu(cpu_quiescent, cpu)
+
+/*
+ * Register a new rcu callback. This will be invoked as soon
+ * as all CPUs have performed a context switch or been seen in the
+ * idle loop or in a user process. It can be called only from
+ * process or BH context, however can be made to work from irq
+ * context too with minor code changes if necessary.
+ */
+void call_rcu(struct rcu_head *head, void (*func)(void *arg), void *arg)
+{
+	head->func = func;
+	head->arg = arg;
+
+	spin_lock_bh(&rcu_data.lock);
+	list_add(&head->list, &rcu_data.nxtlist);
+	spin_unlock_bh(&rcu_data.lock);
+
+	tasklet_hi_schedule(&rcu_data.tasklet);
+}
+
+#ifdef CONFIG_PREEMPT
+/*
+ * Same as call_rcu except that you don't need to disable preemption
+ * during the read-side of the RCU critical section. Preemption is
+ * handled transparently here.
+ */
+void call_rcu_preempt(struct rcu_head *head, void (*func)(void *arg), void *arg)
+{
+	head->func = func;
+	head->arg = arg;
+
+	spin_lock_bh(&rcu_data_preempt.lock);
+	list_add(&head->list, &rcu_data_preempt.nxtlist);
+	spin_unlock_bh(&rcu_data_preempt.lock);
+
+	tasklet_hi_schedule(&rcu_data_preempt.tasklet);
+}
+static inline void rcu_setup_grace_period(struct rcu_data *rdata, int cpu)
+{
+	rdata->qsmask |= 1UL << cpu;
+	rdata->quiescent_checkpoint[cpu] = RCU_quiescent(cpu);
+	if (rdata == &rcu_data_preempt)
+		rcu_switch_preempt_cntr(cpu);
+	force_cpu_reschedule(cpu);
+}
+static inline int rcu_grace_period_complete(struct rcu_data *rdata, int cpu)
+{
+	if (rdata == &rcu_data)  {
+		return ((rdata->qsmask & (1UL << cpu)) &&
+			(rdata->quiescent_checkpoint[cpu] != 
+						RCU_quiescent(cpu)));
+	} else {
+		return ((rdata->qsmask & (1UL << cpu)) &&
+			(rdata->quiescent_checkpoint[cpu] != 
+						RCU_quiescent(cpu)) &&
+              		!rcu_cpu_preempted(cpu));
+	}
+}
+#else
+static inline void rcu_setup_grace_period(struct rcu_data *rdata, int cpu)
+{
+	rdata->qsmask |= 1UL << cpu;
+	rdata->quiescent_checkpoint[cpu] = RCU_quiescent(cpu);
+	force_cpu_reschedule(cpu);
+}
+static inline int rcu_grace_period_complete(struct rcu_data *rdata, int cpu)
+{
+	return ((rdata->qsmask & (1UL << cpu)) &&
+		(rdata->quiescent_checkpoint[cpu] != RCU_quiescent(cpu)));
+}
+#endif
+
+
+static int rcu_prepare_polling(struct rcu_data *rdata)
+{
+	int stop;
+	int i;
+
+#ifdef DEBUG
+	if (!list_empty(&rdata->curlist))
+		BUG();
+#endif
+
+	stop = 1;
+	if (!list_empty(&rdata->nxtlist)) {
+		list_splice(&rdata->nxtlist, &rdata->curlist);
+		INIT_LIST_HEAD(&rdata->nxtlist);
+
+		rdata->polling_in_progress = 1;
+
+		for (i = 0; i < smp_num_cpus; i++) {
+			int cpu = cpu_logical_map(i);
+			rcu_setup_grace_period(rdata, cpu);
+		}
+		stop = 0;
+	}
+
+	return stop;
+}
+
+/*
+ * Invoke the completed RCU callbacks.
+ */
+static void rcu_invoke_callbacks(struct rcu_data *rdata)
+{
+	struct list_head *entry;
+	struct rcu_head *head;
+
+#ifdef DEBUG
+	if (list_empty(&rdata->curlist))
+		BUG();
+#endif
+
+	entry = rdata->curlist.prev;
+	do {
+		head = list_entry(entry, struct rcu_head, list);
+		entry = entry->prev;
+
+		head->func(head->arg);
+	} while (entry != &rdata->curlist);
+
+	INIT_LIST_HEAD(&rdata->curlist);
+}
+
+static int rcu_completion(struct rcu_data *rdata)
+{
+	int stop;
+
+	rdata->polling_in_progress = 0;
+	rcu_invoke_callbacks(rdata);
+
+	stop = rcu_prepare_polling(rdata);
+
+	return stop;
+}
+
+static int rcu_polling(struct rcu_data *rdata)
+{
+	int i;
+	int stop;
+
+	for (i = 0; i < smp_num_cpus; i++) {
+		int cpu = cpu_logical_map(i);
+
+		if (rcu_grace_period_complete(rdata, cpu))
+			rdata->qsmask &= ~(1UL << cpu);
+	}
+
+	stop = 0;
+	if (!rdata->qsmask)
+		stop = rcu_completion(rdata);
+
+	return stop;
+}
+
+/*
+ * Look into the per-cpu callback information to see if there is
+ * any processing necessary - if so do it.
+ */
+static void rcu_process_callbacks(unsigned long data)
+{
+	int stop;
+	struct rcu_data *rdata = (struct rcu_data *)data;
+
+	spin_lock(&rdata->lock);
+	if (!rdata->polling_in_progress)
+		stop = rcu_prepare_polling(rdata);
+	else
+		stop = rcu_polling(rdata);
+	spin_unlock(&rdata->lock);
+
+	if (!stop)
+		tasklet_hi_schedule(&rdata->tasklet);
+}
+
+/* Because of FASTCALL declaration of complete, we use this wrapper */
+static void wakeme_after_rcu(void *completion)
+{
+	complete(completion);
+}
+
+static void rcu_init_data(struct rcu_data *rdata)
+{
+	tasklet_init(&rdata->tasklet, rcu_process_callbacks, 
+			(unsigned long)rdata);
+	INIT_LIST_HEAD(&rdata->nxtlist);
+	INIT_LIST_HEAD(&rdata->curlist);
+	spin_lock_init(&rdata->lock);
+}
+
+/*
+ * Initializes rcu mechanism.  Assumed to be called early.
+ * That is before local timer(SMP) or jiffie timer (uniproc) is setup.
+ */
+void __init rcu_init(void)
+{
+	rcu_init_data(&rcu_data);
+#ifdef CONFIG_PREEMPT
+	rcu_init_data(&rcu_data_preempt);
+#endif
+}
+
+/*
+ * Wait until all the CPUs have gone through a "quiescent" state.
+ */
+void synchronize_kernel(void)
+{
+	struct rcu_head rcu;
+	DECLARE_COMPLETION(completion);
+
+	/* Will wake me after RCU finished */
+	call_rcu_preempt(&rcu, wakeme_after_rcu, &completion);
+
+	/* Wait for it */
+	wait_for_completion(&completion);
+}
+
+EXPORT_SYMBOL(call_rcu);
+#ifdef CONFIG_PREEMPT
+EXPORT_SYMBOL(call_rcu_preempt);
+#endif
+EXPORT_SYMBOL(synchronize_kernel);
diff -urN linux-2.5.14-base/kernel/sched.c linux-2.5.14-rcu_poll_preempt/kernel/sched.c
--- linux-2.5.14-base/kernel/sched.c	Mon May  6 09:07:57 2002
+++ linux-2.5.14-rcu_poll_preempt/kernel/sched.c	Tue May  7 17:23:51 2002
@@ -22,6 +22,7 @@
 #include <linux/interrupt.h>
 #include <linux/completion.h>
 #include <linux/kernel_stat.h>
+#include <linux/percpu.h>
 
 /*
  * Priority of a process goes from 0 to 139. The 0-99
@@ -156,12 +157,32 @@
 
 static struct runqueue runqueues[NR_CPUS] __cacheline_aligned;
 
+long cpu_quiescent __per_cpu_data;
+
 #define cpu_rq(cpu)		(runqueues + (cpu))
 #define this_rq()		cpu_rq(smp_processor_id())
 #define task_rq(p)		cpu_rq((p)->thread_info->cpu)
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 #define rt_task(p)		((p)->prio < MAX_RT_PRIO)
 
+#ifdef CONFIG_PREEMPT
+atomic_t rcu_preempt_cntr[2] __per_cpu_data;
+atomic_t *curr_preempt_cntr __per_cpu_data;
+atomic_t *next_preempt_cntr __per_cpu_data;
+#endif
+
+#ifdef CONFIG_PREEMPT
+static inline void rcu_init_preempt_cntr(int cpu)
+{
+        atomic_set(&per_cpu(rcu_preempt_cntr[0], cpu), 0);
+        atomic_set(&per_cpu(rcu_preempt_cntr[1], cpu), 0);
+	per_cpu(curr_preempt_cntr, cpu) = 
+			&per_cpu(rcu_preempt_cntr[1], cpu);
+	per_cpu(next_preempt_cntr, cpu) = 
+			&per_cpu(rcu_preempt_cntr[0], cpu);
+}
+#endif
+
 static inline runqueue_t *task_rq_lock(task_t *p, unsigned long *flags)
 {
 	struct runqueue *rq;
@@ -773,8 +794,11 @@
 	 * if entering from preempt_schedule, off a kernel preemption,
 	 * go straight to picking the next task.
 	 */
-	if (unlikely(preempt_get_count() & PREEMPT_ACTIVE))
+	if (unlikely(preempt_get_count() & PREEMPT_ACTIVE)) {
 		goto pick_next_task;
+	} else {
+		rcu_preempt_put();
+	}
 	
 	switch (prev->state) {
 	case TASK_INTERRUPTIBLE:
@@ -817,6 +841,7 @@
 switch_tasks:
 	prefetch(next);
 	clear_tsk_need_resched(prev);
+	per_cpu(cpu_quiescent, prev->thread_info->cpu)++;
 
 	if (likely(prev != next)) {
 		rq->nr_switches++;
@@ -857,6 +882,7 @@
 		return;
 
 	ti->preempt_count = PREEMPT_ACTIVE;
+	rcu_preempt_get();
 	schedule();
 	ti->preempt_count = 0;
 	barrier();
@@ -1031,6 +1057,21 @@
 	task_rq_unlock(rq, &flags);
 }
 
+void force_cpu_reschedule(int cpu)
+{
+	unsigned long flags;
+	struct runqueue *rq, *newrq;
+	struct task_struct *p;
+
+	rq = cpu_rq(cpu);
+	p = rq->curr;
+	newrq = task_rq_lock(p, &flags);
+	if (newrq == rq)
+		resched_task(p);
+	task_rq_unlock(newrq, &flags);
+}
+
+
 #ifndef __alpha__
 
 /*
@@ -1592,6 +1633,7 @@
 		spin_lock_init(&rq->lock);
 		spin_lock_init(&rq->frozen);
 		INIT_LIST_HEAD(&rq->migration_queue);
+		rcu_init_preempt_cntr(i);
 
 		for (j = 0; j < 2; j++) {
 			array = rq->arrays + j;

--DocE+STaALJfprDB--
