Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289739AbSBEScV>; Tue, 5 Feb 2002 13:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289741AbSBESb6>; Tue, 5 Feb 2002 13:31:58 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:25806 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S289739AbSBESbo>;
	Tue, 5 Feb 2002 13:31:44 -0500
Date: Wed, 6 Feb 2002 00:04:20 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
        Paul McKenney <paul.mckenney@us.ibm.com>
Subject: Re: [PATCH] New Read-Copy Update patch
Message-ID: <20020206000420.B427@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <20020205211826.B32506@in.ibm.com> <20020205181354.M3135@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020205181354.M3135@athlon.random>; from andrea@suse.de on Tue, Feb 05, 2002 at 06:13:54PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

On Tue, Feb 05, 2002 at 06:13:54PM +0100, Andrea Arcangeli wrote:
> On Tue, Feb 05, 2002 at 09:18:26PM +0530, Dipankar Sarma wrote:
> > Main features of rcu-2.5.3.patch -
> > 
> > 1. Unlike my previous patch based on the old DYNIX/ptx algorithm
> >    this does not have any code in arch-dependent directories. This
> >    should make Andrea happy ;-)
> > 2. No overhead in fastpath other than a per-cpu counter increment
> >    during context switch.
> > 3. RCU callbacks maintained in per-cpu lists, so global locking
> >    needs to be used only once in every quiescent cycle, not
> >    for queueing RCU callbacks.
> > 4. No changes to scheduler code.
> > 5. No RCU, no overhead other than the context switch counter increment.
> 
> I think you attached the wrong patch, the below one is based on the
> kernel thread that we don't need with the scheduler counter.

Actually that was a different patch from the earlier krcud based
patches - in this we don't have krcud for UP and use krcuds only to move
the per-cpu callback lists. My idea was to get it reviewed in lkml
and see if this would be acceptable.

> 
> BTW, I'd like to point out that the schedule counter is likely to be at
> zero cacheline cost.

Yes. Otherwise you wouldn't have it in schedule().

I apologize for the confusion. To set the records straight, we are
experimenting with two patches - one I mailed earlier
(rcu-2.5.3.patch) and rcu_poll which is a part of aa kernels.
I am including rcu_poll-2.5.2.patch along with this. BTW, the
sched.h changes in this can be avoided once we have Rusty's per-CPU
data patch.

The main difference between rcu and rcu_poll are these -

1. rcu uses per-cpu callback lists.
2. rcu_poll forces all CPUs to go through quiescent state
   whereas rcu uses a periodic per-cpu check to see if this
   happened.

In our measurements, we find that rcu is slightly faster than
rcu_poll. We have an ongoing work of determining exactly
what adds to overheads in different RCU implementations and
what helps in performance. Our initial measurements a few months
ago showed that any delay in call_rcu() significantly affects
the performance. There is more work to do here.
At the moment however, I would go with whichever approach 
is more acceptable.

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.


diff -urN linux-2.5.2/include/linux/rcupdate.h linux-2.5.2-rcu_poll/include/linux/rcupdate.h
--- linux-2.5.2/include/linux/rcupdate.h	Thu Jan  1 05:30:00 1970
+++ linux-2.5.2-rcu_poll/include/linux/rcupdate.h	Thu Jan 31 22:00:38 2002
@@ -0,0 +1,59 @@
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
+extern void synchronize_kernel(void);
+
+extern void rcu_init(void);
+
+#endif /* __LINUX_RCUPDATE_H */
diff -urN linux-2.5.2/include/linux/sched.h linux-2.5.2-rcu_poll/include/linux/sched.h
--- linux-2.5.2/include/linux/sched.h	Tue Jan 15 02:57:08 2002
+++ linux-2.5.2-rcu_poll/include/linux/sched.h	Thu Jan 31 22:01:06 2002
@@ -155,6 +155,7 @@
 extern void flush_scheduled_tasks(void);
 extern int start_context_thread(void);
 extern int current_is_keventd(void);
+extern void force_cpu_reschedule(int cpu);
 
 /*
  * The default fd array needs to be at least BITS_PER_LONG,
@@ -566,6 +567,39 @@
 extern struct   mm_struct init_mm;
 extern struct task_struct *init_tasks[NR_CPUS];
 
+#define BITMAP_SIZE ((MAX_PRIO+7)/8)
+#define PRIO_INTERACTIVE	(MAX_RT_PRIO + (MAX_PRIO - MAX_RT_PRIO) / 4)
+#define TASK_INTERACTIVE(p)	((p)->prio >= MAX_RT_PRIO && (p)->prio <= PRIO_INTERACTIVE)
+#define JSLEEP_TO_PRIO(t)	(((t) * 20) / HZ)
+
+typedef struct runqueue runqueue_t;
+
+struct prio_array {
+	int nr_active;
+	spinlock_t *lock;
+	runqueue_t *rq;
+	char bitmap[BITMAP_SIZE];
+	list_t queue[MAX_PRIO];
+};
+
+struct runqueue {
+	int cpu;
+	spinlock_t lock;
+	unsigned long nr_running, nr_switches;
+	task_t *curr, *idle;
+	prio_array_t *active, *expired, arrays[2];
+	long quiescent;
+} ____cacheline_aligned_in_smp;
+
+extern struct runqueue runqueues[];
+
+#define this_rq()		(runqueues + smp_processor_id())
+#define task_rq(p)		(runqueues + (p)->cpu)
+#define cpu_rq(cpu)		(runqueues + (cpu))
+#define cpu_curr(cpu)		(runqueues[(cpu)].curr)
+#define rt_task(p)		((p)->policy != SCHED_OTHER)
+#define RCU_quiescent(cpu)	((cpu_rq((cpu)))->quiescent)
+
 /* PID hashing. (shouldnt this be dynamic?) */
 #define PIDHASH_SZ (4096 >> 2)
 extern struct task_struct *pidhash[PIDHASH_SZ];
diff -urN linux-2.5.2/init/main.c linux-2.5.2-rcu_poll/init/main.c
--- linux-2.5.2/init/main.c	Wed Jan  9 23:15:17 2002
+++ linux-2.5.2-rcu_poll/init/main.c	Tue Jan 29 21:29:22 2002
@@ -27,6 +27,7 @@
 #include <linux/iobuf.h>
 #include <linux/bootmem.h>
 #include <linux/tty.h>
+#include <linux/rcupdate.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -352,6 +353,7 @@
 	printk("Kernel command line: %s\n", saved_command_line);
 	parse_options(command_line);
 	trap_init();
+	rcu_init();
 	init_IRQ();
 	sched_init();
 	softirq_init();
diff -urN linux-2.5.2/kernel/Makefile linux-2.5.2-rcu_poll/kernel/Makefile
--- linux-2.5.2/kernel/Makefile	Fri Nov 30 06:23:45 2001
+++ linux-2.5.2-rcu_poll/kernel/Makefile	Thu Jan 31 21:53:22 2002
@@ -10,12 +10,12 @@
 O_TARGET := kernel.o
 
 export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
-		printk.o device.o
+		printk.o device.o rcupdate.o
 
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
 	    sysctl.o acct.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o device.o
+	    signal.o sys.o kmod.o context.o device.o rcupdate.o
 
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
diff -urN linux-2.5.2/kernel/rcupdate.c linux-2.5.2-rcu_poll/kernel/rcupdate.c
--- linux-2.5.2/kernel/rcupdate.c	Thu Jan  1 05:30:00 1970
+++ linux-2.5.2-rcu_poll/kernel/rcupdate.c	Thu Jan 31 21:38:46 2002
@@ -0,0 +1,212 @@
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
+#include <linux/rcupdate.h>
+
+/* Definition for rcupdate control block. */
+static spinlock_t rcu_lock;
+static struct list_head rcu_nxtlist;
+static struct list_head rcu_curlist;
+static struct tasklet_struct rcu_tasklet;
+static unsigned long rcu_qsmask;
+static int rcu_polling_in_progress;
+static long rcu_quiescent_checkpoint[NR_CPUS];
+
+/*
+ * Register a new rcu callback. This will be invoked as soon
+ * as all CPUs have performed a context switch or been seen in the
+ * idle loop or in a user process.
+ */
+void call_rcu(struct rcu_head *head, void (*func)(void *arg), void *arg)
+{
+	head->func = func;
+	head->arg = arg;
+
+	spin_lock_bh(&rcu_lock);
+	list_add(&head->list, &rcu_nxtlist);
+	spin_unlock_bh(&rcu_lock);
+
+	tasklet_hi_schedule(&rcu_tasklet);
+}
+
+static int rcu_prepare_polling(void)
+{
+	int stop;
+	int i;
+
+#ifdef DEBUG
+	if (!list_empty(&rcu_curlist))
+		BUG();
+#endif
+
+	stop = 1;
+	if (!list_empty(&rcu_nxtlist)) {
+		list_splice(&rcu_nxtlist, &rcu_curlist);
+		INIT_LIST_HEAD(&rcu_nxtlist);
+
+		rcu_polling_in_progress = 1;
+
+		for (i = 0; i < smp_num_cpus; i++) {
+			int cpu = cpu_logical_map(i);
+
+			if (cpu != smp_processor_id()) {
+				rcu_qsmask |= 1UL << cpu;
+				rcu_quiescent_checkpoint[cpu] = RCU_quiescent(cpu);
+				force_cpu_reschedule(cpu);
+			}
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
+static void rcu_invoke_callbacks(void)
+{
+	struct list_head *entry;
+	struct rcu_head *head;
+
+#ifdef DEBUG
+	if (list_empty(&rcu_curlist))
+		BUG();
+#endif
+
+	entry = rcu_curlist.prev;
+	do {
+		head = list_entry(entry, struct rcu_head, list);
+		entry = entry->prev;
+
+		head->func(head->arg);
+	} while (entry != &rcu_curlist);
+
+	INIT_LIST_HEAD(&rcu_curlist);
+}
+
+static int rcu_completion(void)
+{
+	int stop;
+
+	rcu_polling_in_progress = 0;
+	rcu_invoke_callbacks();
+
+	stop = rcu_prepare_polling();
+
+	return stop;
+}
+
+static int rcu_polling(void)
+{
+	int i;
+	int stop;
+
+	for (i = 0; i < smp_num_cpus; i++) {
+		int cpu = cpu_logical_map(i);
+
+		if (rcu_qsmask & (1UL << cpu))
+			if (rcu_quiescent_checkpoint[cpu] != RCU_quiescent(cpu))
+				rcu_qsmask &= ~(1UL << cpu);
+	}
+
+	stop = 0;
+	if (!rcu_qsmask)
+		stop = rcu_completion();
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
+
+	spin_lock(&rcu_lock);
+	if (!rcu_polling_in_progress)
+		stop = rcu_prepare_polling();
+	else
+		stop = rcu_polling();
+	spin_unlock(&rcu_lock);
+
+	if (!stop)
+		tasklet_hi_schedule(&rcu_tasklet);
+}
+
+/* Because of FASTCALL declaration of complete, we use this wrapper */
+static void wakeme_after_rcu(void *completion)
+{
+	complete(completion);
+}
+
+/*
+ * Initializes rcu mechanism.  Assumed to be called early.
+ * That is before local timer(SMP) or jiffie timer (uniproc) is setup.
+ */
+void __init rcu_init(void)
+{
+	tasklet_init(&rcu_tasklet, rcu_process_callbacks, 0UL);
+	INIT_LIST_HEAD(&rcu_nxtlist);
+	INIT_LIST_HEAD(&rcu_curlist);
+	spin_lock_init(&rcu_lock);
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
+EXPORT_SYMBOL(call_rcu);
+EXPORT_SYMBOL(synchronize_kernel);
diff -urN linux-2.5.2/kernel/sched.c linux-2.5.2-rcu_poll/kernel/sched.c
--- linux-2.5.2/kernel/sched.c	Tue Jan 15 01:09:31 2002
+++ linux-2.5.2-rcu_poll/kernel/sched.c	Fri Feb  1 17:17:39 2002
@@ -20,21 +20,6 @@
 #include <linux/interrupt.h>
 #include <asm/mmu_context.h>
 
-#define BITMAP_SIZE ((MAX_PRIO+7)/8)
-#define PRIO_INTERACTIVE	(MAX_RT_PRIO + (MAX_PRIO - MAX_RT_PRIO) / 4)
-#define TASK_INTERACTIVE(p)	((p)->prio >= MAX_RT_PRIO && (p)->prio <= PRIO_INTERACTIVE)
-#define JSLEEP_TO_PRIO(t)	(((t) * 20) / HZ)
-
-typedef struct runqueue runqueue_t;
-
-struct prio_array {
-	int nr_active;
-	spinlock_t *lock;
-	runqueue_t *rq;
-	char bitmap[BITMAP_SIZE];
-	list_t queue[MAX_PRIO];
-};
-
 /*
  * This is the main, per-CPU runqueue data structure.
  *
@@ -46,20 +31,7 @@
  * if there is a RT task active in an SMP system but there is no
  * RT scheduling activity otherwise.
  */
-static struct runqueue {
-	int cpu;
-	spinlock_t lock;
-	unsigned long nr_running, nr_switches;
-	task_t *curr, *idle;
-	prio_array_t *active, *expired, arrays[2];
-	char __pad [SMP_CACHE_BYTES];
-} runqueues [NR_CPUS] __cacheline_aligned;
-
-#define this_rq()		(runqueues + smp_processor_id())
-#define task_rq(p)		(runqueues + (p)->cpu)
-#define cpu_rq(cpu)		(runqueues + (cpu))
-#define cpu_curr(cpu)		(runqueues[(cpu)].curr)
-#define rt_task(p)		((p)->policy != SCHED_OTHER)
+struct runqueue runqueues [NR_CPUS] __cacheline_aligned;
 
 #define lock_task_rq(rq,p,flags)				\
 do {								\
@@ -515,6 +487,7 @@
 switch_tasks:
 	prev->need_resched = 0;
 
+	RCU_quiescent(prev->cpu)++;
 	if (likely(prev != next)) {
 		rq->nr_switches++;
 		rq->curr = next;
@@ -765,6 +738,20 @@
 	unlock_task_rq(rq, p, flags);
 }
 
+void force_cpu_reschedule(int cpu)
+{
+	unsigned long flags;
+	struct runqueue *rq, *newrq;
+	struct task_struct *p;
+
+	rq = cpu_rq(cpu);
+	p = rq->curr;
+	newrq = lock_task_rq(p, &flags);
+	if (newrq == rq)
+		resched_task(p);
+	unlock_task_rq(newrq, &flags);
+}
+
 #ifndef __alpha__
 
 /*

