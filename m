Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318326AbSH0BhZ>; Mon, 26 Aug 2002 21:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318327AbSH0BhZ>; Mon, 26 Aug 2002 21:37:25 -0400
Received: from mx1.elte.hu ([157.181.1.137]:1950 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318326AbSH0BhN>;
	Mon, 26 Aug 2002 21:37:13 -0400
Date: Tue, 27 Aug 2002 03:44:23 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [patch] "fully HT-aware scheduler" support, 2.5.31-BK-curr
Message-ID: <Pine.LNX.4.44.0208270226190.12947-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


symmetric multithreading (hyperthreading) is an interesting new concept
that IMO deserves full scheduler support. Physical CPUs can have multiple
(typically 2) logical CPUs embedded, and can run multiple tasks 'in
parallel' by utilizing fast hardware-based context-switching between the
two register sets upon things like cache-misses or special instructions.
To the OSs the logical CPUs are almost undistinguishable from physical
CPUs. In fact the current scheduler treats each logical CPU as a separate
physical CPU - which works but does not maximize multiprocessing
performance on SMT/HT boxes.

The following properties have to be provided by a scheduler that wants to
be 'fully HT-aware':

 - HT-aware passive load-balancing: the irq-driven balancing has to be
   per-physical-CPU, not per-logical-CPU.

   Otherwise it might happen that one physical CPU runs 2 tasks, while
   another physical CPU runs no threads. The stock scheduler does not
   recognize this condition as 'imbalance' - to the scheduler it appears
   as if the first two CPUs had 1-1 task running, the second two CPUs had
   0-0 tasks running. The stock scheduler does not realize that the two
   logical CPUs belong to the same physical CPU.

 - 'active' load-balancing when a logical CPU goes idle and thus causes a
   physical CPU imbalance.

   This is a mechanism that simply does not exist in the stock 1:1
   scheduler - the imbalance caused by an idle CPU can be solved via the
   normal load-balancer. In the HT case the situation is special because
   the source physical CPU might have just two tasks running, both
   runnable - this is a situation that the stock load-balancer is unable
   to handle - running tasks are hard to be migrated away. But it's
   essential to do this - otherwise a physical CPU can get stuck running 2 
   tasks, while another physical CPU stays idle.

 - HT-aware task pickup.

   When the scheduler picks a new task, it should prefer all tasks that 
   share the same physical CPU - before trying to pull in tasks from other 
   CPUs. The stock scheduler only picked tasks that were scheduled to that
   particular logical CPU.

 - HT-aware affinity.

   Tasks should attempt to 'stick' to physical CPUs, not logical CPUs.

 - HT-aware wakeup.

   again this is something completely new - the stock scheduler only knows
   about the 'current' CPU, it does not know about any sibling [== logical
   CPUs on the same physical CPU] logical CPUs. On HT, if a thread is
   woken up on a logical CPU that is already executing a task, and if a
   sibling CPU is idle, then the sibling CPU has to be woken up and has to
   execute the newly woken up task immediately.

the attached patch (against 2.5.31-BK-curr) implements all the above
HT-scheduling needs by introducing the concept of a shared runqueue:
multiple CPUs can share the same runqueue. A shared, per-physical-CPU
runqueue magically fulfills all the above HT-scheduling needs. Obviously
this complicates scheduling and load-balancing somewhat (see the patch for
details), so great care has been taken to not impact the non-HT schedulers
(SMP, UP). In fact the SMP scheduler is a compile-time special case of the
HT scheduler. (and the UP scheduler is a compile-time special case of the
SMP scheduler)

the patch is based on Jun Nakajima's prototyping work - the lowlevel
x86/Intel bits are still those from Jun, the sched.c bits are newly
implemented and generalized.

There's a single flexible interface for lowlevel boot code to set up
physical CPUs: sched_map_runqueue(cpu1, cpu2) maps cpu2 into cpu1's
runqueue. The patch also implements the lowlevel bits for P4 HT boxes for
the 2/package case.

(NUMA systems which have tightly coupled CPUs with a smaller cache and
protected by a large L3 cache might benefit from sharing the runqueue as
well - but the target for this concept is SMT.)

some numbers:

compiling a standalone floppy.c in an infinite loop takes 2.55 seconds per
iteration. Starting up two such loops in parallel, on a 2-physical,
2-logical (total of 4 logical CPUs) P4 HT box gives the following numbers:

  2.5.31-BK-curr:     - fluctuates between 2.60 secs and 4.6 seconds.

  BK-curr + sched-F3: - stable 2.60 sec results.

the results under the stock scheduler depends on pure luck: which CPUs get
the tasks scheduled. In the HT-aware case each task gets scheduled on a
separate physical CPU, all the time.

compiling the kernel source via "make -j2" [under-utilizes CPUs]:

  2.5.31-BK-curr:              45.3 sec

  BK-curr + sched-F3:          41.3 sec

ie. a ~10% improvement. The tests were the best results picked from lots
of (>10) runs. The no-HT numbers fluctuate much more (again the randomness
effect), so the average compilation time in the no-HT case is higher.

saturated compilation "make -j5" results are roughly equivalent, as
expected - the one-runqueue-per-CPU concept works adequately when the
number of tasks is larger than the number of logical CPUs. The stock
scheduler works well on HT boxes in the boundary conditions: when there's
1 task running, and when there's more nr_cpus tasks running.

the patch also unifies some of the other code and removes a few more
#ifdef CONFIG_SMP branches from the scheduler proper.

(the patch compiles/boots/works just fine on UP and SMP as well, on the P4
box and on another PIII SMP box as well.)

Testreports, comments, suggestions welcome,

	Ingo

--- linux/arch/i386/kernel/smpboot.c.orig	Tue Aug 27 02:21:33 2002
+++ linux/arch/i386/kernel/smpboot.c	Tue Aug 27 02:22:17 2002
@@ -1149,16 +1149,32 @@
 	Dprintk("Boot done.\n");
 
 	/*
-	 * If Hyper-Threading is avaialble, construct cpu_sibling_map[], so
+	 * Here we can be sure that there is an IO-APIC in the system. Let's
+	 * go and set it up:
+	 */
+	if (!skip_ioapic_setup && nr_ioapics)
+		setup_IO_APIC();
+
+	setup_boot_APIC_clock();
+
+	/*
+	 * Synchronize the TSC with the AP
+	 */
+	if (cpu_has_tsc && cpucount)
+		synchronize_tsc_bp();
+	/*
+	 * If Hyper-Threading is available, construct cpu_sibling_map[], so
 	 * that we can tell the sibling CPU efficiently.
 	 */
+printk("cpu_has_ht: %d, smp_num_siblings: %d, num_online_cpus(): %d.\n", cpu_has_ht, smp_num_siblings, num_online_cpus());
 	if (cpu_has_ht && smp_num_siblings > 1) {
 		for (cpu = 0; cpu < NR_CPUS; cpu++)
 			cpu_sibling_map[cpu] = NO_PROC_ID;
 		
 		for (cpu = 0; cpu < NR_CPUS; cpu++) {
 			int 	i;
-			if (!test_bit(cpu, &cpu_callout_map)) continue;
+			if (!test_bit(cpu, &cpu_callout_map))
+				continue;
 
 			for (i = 0; i < NR_CPUS; i++) {
 				if (i == cpu || !test_bit(i, &cpu_callout_map))
@@ -1174,24 +1190,34 @@
 				printk(KERN_WARNING "WARNING: No sibling found for CPU %d.\n", cpu);
 			}
 		}
-	}
-	     
-#ifndef CONFIG_VISWS
-	/*
-	 * Here we can be sure that there is an IO-APIC in the system. Let's
-	 * go and set it up:
+#if CONFIG_SHARE_RUNQUEUE
+	/* At this point APs would have synchronised TSC and waiting for 
+	 * smp_commenced, with their APIC timer disabled. So BP can go ahead
+	 * do some initializations for Hyper-Threading(if needed).
 	 */
-	if (!skip_ioapic_setup && nr_ioapics)
-		setup_IO_APIC();
-#endif
-
-	setup_boot_APIC_clock();
+		for (cpu = 0; cpu < NR_CPUS; cpu++) {
+			int i;
+			if (!test_bit(cpu, &cpu_callout_map))
+				continue;
+			for (i = 0; i < NR_CPUS; i++) {
+				if (i <= cpu)
+					continue;
+				if (!test_bit(i, &cpu_callout_map))
+					continue;
 
-	/*
-	 * Synchronize the TSC with the AP
-	 */
-	if (cpu_has_tsc && cpucount)
-		synchronize_tsc_bp();
+				if (phys_proc_id[cpu] != phys_proc_id[i])
+					continue;
+				/*
+				 * merge runqueues, resulting in one
+				 * runqueue per package:
+				 */
+				sched_map_runqueue(cpu, i);
+				break;
+			}
+		}
+#endif
+	}
+	     
 }
 
 /* These are wrappers to interface to the new boot process.  Someone
--- linux/arch/i386/config.in.orig	Tue Aug 27 02:21:33 2002
+++ linux/arch/i386/config.in	Tue Aug 27 02:22:17 2002
@@ -155,6 +155,20 @@
 fi
 
 bool 'Symmetric multi-processing support' CONFIG_SMP
+
+if [ "$CONFIG_SMP" = "y" ]; then
+   if [ "$CONFIG_MPENTIUM4" = "y" ]; then
+      choice 'Hyperthreading Support' \
+          "off           CONFIG_NR_SIBLINGS_0 \
+           2-siblings    CONFIG_NR_SIBLINGS_2" off
+   fi
+fi
+
+if [ "$CONFIG_NR_SIBLINGS_2" = "y" ]; then
+   define_bool CONFIG_SHARE_RUNQUEUE y
+   define_int CONFIG_MAX_NR_SIBLINGS 2
+fi
+
 bool 'Preemptible Kernel' CONFIG_PREEMPT
 if [ "$CONFIG_SMP" != "y" ]; then
    bool 'Local APIC support on uniprocessors' CONFIG_X86_UP_APIC
--- linux/include/linux/sched.h.orig	Tue Aug 27 02:21:35 2002
+++ linux/include/linux/sched.h	Tue Aug 27 02:22:17 2002
@@ -147,6 +147,7 @@
 
 extern void sched_init(void);
 extern void init_idle(task_t *idle, int cpu);
+extern void sched_map_runqueue(int cpu1, int cpu2);
 extern void show_state(void);
 extern void cpu_init (void);
 extern void trap_init(void);
--- linux/include/asm-i386/apic.h.orig	Tue Aug 27 02:21:15 2002
+++ linux/include/asm-i386/apic.h	Tue Aug 27 02:22:17 2002
@@ -98,4 +98,6 @@
 
 #endif /* CONFIG_X86_LOCAL_APIC */
 
+extern int phys_proc_id[NR_CPUS];
+
 #endif /* __ASM_APIC_H */
--- linux/kernel/sched.c.orig	Tue Aug 27 02:21:35 2002
+++ linux/kernel/sched.c	Tue Aug 27 03:27:31 2002
@@ -20,15 +20,15 @@
 #include <linux/nmi.h>
 #include <linux/init.h>
 #include <asm/uaccess.h>
+#include <linux/delay.h>
 #include <linux/highmem.h>
+#include <linux/security.h>
+#include <linux/notifier.h>
 #include <linux/smp_lock.h>
 #include <asm/mmu_context.h>
 #include <linux/interrupt.h>
 #include <linux/completion.h>
 #include <linux/kernel_stat.h>
-#include <linux/security.h>
-#include <linux/notifier.h>
-#include <linux/delay.h>
 
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
@@ -137,6 +137,48 @@
 };
 
 /*
+ * It's possible for two CPUs to share the same runqueue.
+ * This makes sense if they eg. share caches.
+ *
+ * We take the common 1:1 (SMP, UP) case and optimize it,
+ * the rest goes via remapping: rq_idx(cpu) gives the
+ * runqueue on which a particular cpu is on, cpu_idx(cpu)
+ * gives the rq-specific index of the cpu.
+ *
+ * (Note that the generic scheduler code does not impose any
+ *  restrictions on the mappings - there can be 4 CPUs per
+ *  runqueue or even assymetric mappings.)
+ */
+#if CONFIG_SHARE_RUNQUEUE
+# define MAX_NR_SIBLINGS CONFIG_MAX_NR_SIBLINGS
+  static long __rq_idx[NR_CPUS] __cacheline_aligned;
+  static long __cpu_idx[NR_CPUS] __cacheline_aligned;
+# define rq_idx(cpu) (__rq_idx[(cpu)])
+# define cpu_idx(cpu) (__cpu_idx[(cpu)])
+# define for_each_sibling(idx, rq) \
+		for ((idx) = 0; (idx) < (rq)->nr_cpus; (idx)++)
+# define rq_nr_cpus(rq) ((rq)->nr_cpus)
+# define cpu_active_balance(c) (cpu_rq(c)->cpu[0].active_balance)
+#else
+# define MAX_NR_SIBLINGS 1
+# define rq_idx(cpu) (cpu)
+# define cpu_idx(cpu) 0
+# define for_each_sibling(idx, rq) while (0)
+# define cpu_active_balance(c) 0
+# define do_active_balance(rq, cpu) do { } while (0)
+# define rq_nr_cpus(rq) 1
+  static inline void active_load_balance(runqueue_t *rq, int this_cpu) { }
+#endif
+
+typedef struct cpu_s {
+	task_t *curr, *idle;
+	task_t *migration_thread;
+	list_t migration_queue;
+	int active_balance;
+	int cpu;
+} cpu_t;
+
+/*
  * This is the main, per-CPU runqueue data structure.
  *
  * Locking rule: those places that want to lock multiple runqueues
@@ -147,30 +189,42 @@
 	spinlock_t lock;
 	unsigned long nr_running, nr_switches, expired_timestamp,
 			nr_uninterruptible;
-	task_t *curr, *idle;
 	prio_array_t *active, *expired, arrays[2];
 	int prev_nr_running[NR_CPUS];
 
-	task_t *migration_thread;
-	list_t migration_queue;
+	int nr_cpus;
+	cpu_t cpu[MAX_NR_SIBLINGS];
 
 } ____cacheline_aligned;
 
 static struct runqueue runqueues[NR_CPUS] __cacheline_aligned;
 
-#define cpu_rq(cpu)		(runqueues + (cpu))
+#define cpu_rq(cpu)		(runqueues + (rq_idx(cpu)))
+#define cpu_int(c)		((cpu_rq(c))->cpu + cpu_idx(c))
+#define cpu_curr_ptr(cpu)	(cpu_int(cpu)->curr)
+#define cpu_idle_ptr(cpu)	(cpu_int(cpu)->idle)
+
 #define this_rq()		cpu_rq(smp_processor_id())
 #define task_rq(p)		cpu_rq(task_cpu(p))
-#define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 #define rt_task(p)		((p)->prio < MAX_RT_PRIO)
 
+#define migration_thread(cpu)	(cpu_int(cpu)->migration_thread)
+#define migration_queue(cpu)	(&cpu_int(cpu)->migration_queue)
+
+#if NR_CPUS > 1
+# define task_allowed(p, cpu)	((p)->cpus_allowed & (1UL << (cpu)))
+#else
+# define task_allowed(p, cpu)	1
+#endif
+
 /*
  * Default context-switch locking:
  */
 #ifndef prepare_arch_switch
 # define prepare_arch_switch(rq, next)	do { } while(0)
 # define finish_arch_switch(rq, next)	spin_unlock_irq(&(rq)->lock)
-# define task_running(rq, p)		((rq)->curr == (p))
+# define task_running(p) \
+		(cpu_curr_ptr(task_cpu(p)) == (p))
 #endif
 
 /*
@@ -217,6 +271,15 @@
 	spin_unlock_irq(&rq->lock);
 }
 
+/**
+ * idle_cpu - is a given cpu idle currently?
+ * @cpu: the processor in question.
+ */
+inline int idle_cpu(int cpu)
+{
+	return cpu_curr_ptr(cpu) == cpu_idle_ptr(cpu);
+}
+
 /*
  * Adding/removing a task to/from a priority array:
  */
@@ -305,32 +368,6 @@
 	p->array = NULL;
 }
 
-/*
- * resched_task - mark a task 'to be rescheduled now'.
- *
- * On UP this means the setting of the need_resched flag, on SMP it
- * might also involve a cross-CPU call to trigger the scheduler on
- * the target CPU.
- */
-static inline void resched_task(task_t *p)
-{
-#ifdef CONFIG_SMP
-	int need_resched, nrpolling;
-
-	preempt_disable();
-	/* minimise the chance of sending an interrupt to poll_idle() */
-	nrpolling = test_tsk_thread_flag(p,TIF_POLLING_NRFLAG);
-	need_resched = test_and_set_tsk_thread_flag(p,TIF_NEED_RESCHED);
-	nrpolling |= test_tsk_thread_flag(p,TIF_POLLING_NRFLAG);
-
-	if (!need_resched && !nrpolling && (task_cpu(p) != smp_processor_id()))
-		smp_send_reschedule(task_cpu(p));
-	preempt_enable();
-#else
-	set_tsk_need_resched(p);
-#endif
-}
-
 #ifdef CONFIG_SMP
 
 /*
@@ -347,7 +384,7 @@
 repeat:
 	preempt_disable();
 	rq = task_rq(p);
-	if (unlikely(task_running(rq, p))) {
+	if (unlikely(task_running(p))) {
 		cpu_relax();
 		/*
 		 * enable/disable preemption just to make this
@@ -358,7 +395,7 @@
 		goto repeat;
 	}
 	rq = task_rq_lock(p, &flags);
-	if (unlikely(task_running(rq, p))) {
+	if (unlikely(task_running(p))) {
 		task_rq_unlock(rq, &flags);
 		preempt_enable();
 		goto repeat;
@@ -366,8 +403,43 @@
 	task_rq_unlock(rq, &flags);
 	preempt_enable();
 }
+
+/*
+ * resched_task - mark a task 'to be rescheduled now'.
+ *
+ * On UP this means the setting of the need_resched flag, on SMP it
+ * might also involve a cross-CPU call to trigger the scheduler on
+ * the target CPU.
+ */
+static inline void resched_task(task_t *p)
+{
+	int need_resched, nrpolling;
+
+	preempt_disable();
+	/* minimise the chance of sending an interrupt to poll_idle() */
+	nrpolling = test_tsk_thread_flag(p,TIF_POLLING_NRFLAG);
+	need_resched = test_and_set_tsk_thread_flag(p,TIF_NEED_RESCHED);
+	nrpolling |= test_tsk_thread_flag(p,TIF_POLLING_NRFLAG);
+
+	if (!need_resched && !nrpolling && (task_cpu(p) != smp_processor_id()))
+		smp_send_reschedule(task_cpu(p));
+	preempt_enable();
+}
+
+#else
+
+static inline void resched_task(task_t *p)
+{
+	set_tsk_need_resched(p);
+}
+
 #endif
 
+static inline void resched_cpu(int cpu)
+{
+	resched_task(cpu_curr_ptr(cpu));
+}
+
 /*
  * kick_if_running - kick the remote CPU if the task is running currently.
  *
@@ -380,10 +452,40 @@
  */
 void kick_if_running(task_t * p)
 {
-	if ((task_running(task_rq(p), p)) && (task_cpu(p) != smp_processor_id()))
+	if ((task_running(p)) && (task_cpu(p) != smp_processor_id()))
 		resched_task(p);
 }
 
+static void wake_up_cpu(runqueue_t *rq, int cpu, task_t *p)
+{
+	cpu_t *curr_cpu;
+	task_t *curr;
+	int idx;
+
+	if (idle_cpu(cpu))
+		return resched_cpu(cpu);
+
+	for_each_sibling(idx, rq) {
+		curr_cpu = rq->cpu + idx;
+		if (!task_allowed(p, curr_cpu->cpu))
+			continue;
+		if (curr_cpu->idle == curr_cpu->curr)
+			return resched_cpu(curr_cpu->cpu);
+	}
+
+	if (p->prio < cpu_curr_ptr(cpu)->prio)
+		return resched_task(cpu_curr_ptr(cpu));
+
+	for_each_sibling(idx, rq) {
+		curr_cpu = rq->cpu + idx;
+		if (!task_allowed(p, curr_cpu->cpu))
+			continue;
+		curr = curr_cpu->curr;
+		if (p->prio < curr->prio)
+			return resched_task(curr);
+	}
+}
+
 /***
  * try_to_wake_up - wake up a thread
  * @p: the to-be-woken-up thread
@@ -412,7 +514,7 @@
 		 * Fast-migrate the task if it's not running or runnable
 		 * currently. Do not violate hard affinity.
 		 */
-		if (unlikely(sync && !task_running(rq, p) &&
+		if (unlikely(sync && !task_running(p) &&
 			(task_cpu(p) != smp_processor_id()) &&
 			(p->cpus_allowed & (1UL << smp_processor_id())))) {
 
@@ -424,8 +526,8 @@
 			rq->nr_uninterruptible--;
 		activate_task(p, rq);
 
-		if (p->prio < rq->curr->prio)
-			resched_task(rq->curr);
+		wake_up_cpu(rq, task_cpu(p), p);
+
 		success = 1;
 	}
 	p->state = TASK_RUNNING;
@@ -543,7 +645,9 @@
 	unsigned long i, sum = 0;
 
 	for (i = 0; i < NR_CPUS; i++)
-		sum += cpu_rq(i)->nr_running;
+		/* Shared runqueues are counted only once. */
+		if (!cpu_idx(i))
+			sum += cpu_rq(i)->nr_running;
 
 	return sum;
 }
@@ -553,7 +657,9 @@
 	unsigned long i, sum = 0;
 
 	for (i = 0; i < NR_CPUS; i++)
-		sum += cpu_rq(i)->nr_uninterruptible;
+		/* Shared runqueues are counted only once. */
+		if (!cpu_idx(i))
+			sum += cpu_rq(i)->nr_uninterruptible;
 
 	return sum;
 }
@@ -602,7 +708,23 @@
 		spin_unlock(&rq2->lock);
 }
 
-#if CONFIG_SMP
+/*
+ * One of the idle_cpu_tick() and busy_cpu_tick() functions will
+ * get called every timer tick, on every CPU. Our balancing action
+ * frequency and balancing agressivity depends on whether the CPU is
+ * idle or not.
+ *
+ * busy-rebalance every 250 msecs. idle-rebalance every 1 msec. (or on
+ * systems with HZ=100, every 10 msecs.)
+ */
+#define BUSY_REBALANCE_TICK (HZ/4 ?: 1)
+#define IDLE_REBALANCE_TICK (HZ/1000 ?: 1)
+
+#if !CONFIG_SMP
+
+static inline void load_balance(runqueue_t *rq, int this_cpu, int idle) { }
+
+#else
 
 /*
  * double_lock_balance - lock the busiest runqueue
@@ -718,12 +840,7 @@
 	set_task_cpu(p, this_cpu);
 	this_rq->nr_running++;
 	enqueue_task(p, this_rq->active);
-	/*
-	 * Note that idle threads have a prio of MAX_PRIO, for this test
-	 * to be always true for them.
-	 */
-	if (p->prio < this_rq->curr->prio)
-		set_need_resched();
+	wake_up_cpu(this_rq, this_cpu, p);
 }
 
 /*
@@ -734,9 +851,9 @@
  * We call this with the current runqueue locked,
  * irqs disabled.
  */
-static void load_balance(runqueue_t *this_rq, int idle)
+static void load_balance(runqueue_t *this_rq, int this_cpu, int idle)
 {
-	int imbalance, idx, this_cpu = smp_processor_id();
+	int imbalance, idx;
 	runqueue_t *busiest;
 	prio_array_t *array;
 	list_t *head, *curr;
@@ -783,12 +900,14 @@
 	 * 1) running (obviously), or
 	 * 2) cannot be migrated to this CPU due to cpus_allowed, or
 	 * 3) are cache-hot on their current CPU.
+	 *
+	 * (except if we are in idle mode which is a more agressive
+	 * form of rebalancing.)
 	 */
 
-#define CAN_MIGRATE_TASK(p,rq,this_cpu)					\
-	((jiffies - (p)->sleep_timestamp > cache_decay_ticks) &&	\
-		!task_running(rq, p) &&					\
-			((p)->cpus_allowed & (1UL << (this_cpu))))
+#define CAN_MIGRATE_TASK(p,rq,cpu)					\
+	((idle || (jiffies - (p)->sleep_timestamp > cache_decay_ticks)) && \
+		!task_running(p) && task_allowed(p, cpu))
 
 	curr = curr->prev;
 
@@ -811,27 +930,134 @@
 	;
 }
 
-/*
- * One of the idle_cpu_tick() and busy_cpu_tick() functions will
- * get called every timer tick, on every CPU. Our balancing action
- * frequency and balancing agressivity depends on whether the CPU is
- * idle or not.
- *
- * busy-rebalance every 250 msecs. idle-rebalance every 1 msec. (or on
- * systems with HZ=100, every 10 msecs.)
- */
-#define BUSY_REBALANCE_TICK (HZ/4 ?: 1)
-#define IDLE_REBALANCE_TICK (HZ/1000 ?: 1)
+#endif
 
-static inline void idle_tick(runqueue_t *rq)
+static inline void idle_tick(runqueue_t *rq, unsigned long j)
 {
-	if (jiffies % IDLE_REBALANCE_TICK)
+	if (j % IDLE_REBALANCE_TICK)
 		return;
 	spin_lock(&rq->lock);
-	load_balance(rq, 1);
+	load_balance(rq, smp_processor_id(), 1);
 	spin_unlock(&rq->lock);
 }
 
+#if CONFIG_SHARE_RUNQUEUE
+static void active_load_balance(runqueue_t *this_rq, int this_cpu)
+{
+	runqueue_t *rq;
+	int i, idx;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		if (!cpu_online(i))
+			continue;
+		rq = cpu_rq(i);
+		if (rq == this_rq)
+			continue;
+		/*
+		 * Any SMT-specific imbalance?
+		 */
+		for_each_sibling(idx, rq)
+			if (rq->cpu[idx].idle == rq->cpu[idx].curr)
+				goto next_cpu;
+
+		/*
+		 * At this point it's sure that we have a SMT
+		 * imbalance: this (physical) CPU is idle but
+		 * another CPU has two tasks running.
+		 *
+		 * We wake up one of the migration threads (it
+		 * doesnt matter which one) and let it fix things up:
+		 */
+		if (!cpu_active_balance(this_cpu)) {
+			cpu_active_balance(this_cpu) = 1;
+			spin_unlock(&this_rq->lock);
+			wake_up_process(rq->cpu[0].migration_thread);
+			spin_lock(&this_rq->lock);
+		}
+next_cpu:
+		;
+	}
+}
+
+static void do_active_balance(runqueue_t *this_rq, int this_cpu)
+{
+	runqueue_t *rq;
+	int i, idx;
+
+	spin_unlock(&this_rq->lock);
+
+	cpu_active_balance(this_cpu) = 0;
+
+	/*
+	 * Is the imbalance still present?
+	 */
+	for_each_sibling(idx, this_rq)
+		if (this_rq->cpu[idx].idle == this_rq->cpu[idx].curr)
+			goto out;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		if (!cpu_online(i))
+			continue;
+		rq = cpu_rq(i);
+		if (rq == this_rq)
+			continue;
+
+		/* completely idle CPU? */
+		if (rq->nr_running)
+			continue;
+
+		/*
+		 * At this point it's reasonably sure that we have an
+		 * imbalance. Since we are the migration thread, try to
+	 	 * balance a thread over to the target queue.
+		 */
+		spin_lock(&rq->lock);
+		load_balance(rq, i, 1);
+		spin_unlock(&rq->lock);
+		goto out;
+	}
+out:
+	spin_lock(&this_rq->lock);
+}
+
+/*
+ * This routine is called to map a CPU into another CPU's runqueue.
+ *
+ * This must be called during bootup with the merged runqueue having
+ * no tasks.
+ */
+void sched_map_runqueue(int cpu1, int cpu2)
+{
+	runqueue_t *rq1 = cpu_rq(cpu1);
+	runqueue_t *rq2 = cpu_rq(cpu2);
+	int cpu2_idx_orig = cpu_idx(cpu2), cpu2_idx;
+
+	printk("sched_merge_runqueues: CPU#%d <=> CPU#%d, on CPU#%d.\n", cpu1, cpu2, smp_processor_id());
+	if (rq1 == rq2)
+		BUG();
+	if (rq2->nr_running)
+		BUG();
+	/*
+	 * At this point, we dont have anything in the runqueue yet. So,
+	 * there is no need to move processes between the runqueues.
+	 * Only, the idle processes should be combined and accessed
+	 * properly.
+	 */
+	cpu2_idx = rq1->nr_cpus++;
+
+	if (rq_idx(cpu1) != cpu1)
+		BUG();
+	rq_idx(cpu2) = cpu1;
+	cpu_idx(cpu2) = cpu2_idx;
+	rq1->cpu[cpu2_idx].cpu = cpu2;
+	rq1->cpu[cpu2_idx].idle = rq2->cpu[cpu2_idx_orig].idle;
+	rq1->cpu[cpu2_idx].curr = rq2->cpu[cpu2_idx_orig].curr;
+	INIT_LIST_HEAD(&rq1->cpu[cpu2_idx].migration_queue);
+
+	/* just to be safe: */
+	rq2->cpu[cpu2_idx_orig].idle = NULL;
+	rq2->cpu[cpu2_idx_orig].curr = NULL;
+}
 #endif
 
 /*
@@ -856,15 +1082,14 @@
 {
 	int cpu = smp_processor_id();
 	runqueue_t *rq = this_rq();
+	unsigned long j = jiffies;
 	task_t *p = current;
 
-	if (p == rq->idle) {
+	if (p == cpu_idle_ptr(cpu)) {
 		/* note: this timer irq context must be accounted for as well */
 		if (irq_count() - HARDIRQ_OFFSET >= SOFTIRQ_OFFSET)
 			kstat.per_cpu_system[cpu] += sys_ticks;
-#if CONFIG_SMP
-		idle_tick(rq);
-#endif
+		idle_tick(rq, j);
 		return;
 	}
 	if (TASK_NICE(p) > 0)
@@ -873,12 +1098,13 @@
 		kstat.per_cpu_user[cpu] += user_ticks;
 	kstat.per_cpu_system[cpu] += sys_ticks;
 
+	spin_lock(&rq->lock);
 	/* Task might have expired already, but not scheduled off yet */
 	if (p->array != rq->active) {
 		set_tsk_need_resched(p);
+		spin_unlock(&rq->lock);
 		return;
 	}
-	spin_lock(&rq->lock);
 	if (unlikely(rt_task(p))) {
 		/*
 		 * RR tasks need a special form of timeslice management.
@@ -914,16 +1140,14 @@
 
 		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
 			if (!rq->expired_timestamp)
-				rq->expired_timestamp = jiffies;
+				rq->expired_timestamp = j;
 			enqueue_task(p, rq->expired);
 		} else
 			enqueue_task(p, rq->active);
 	}
 out:
-#if CONFIG_SMP
-	if (!(jiffies % BUSY_REBALANCE_TICK))
-		load_balance(rq, 0);
-#endif
+	if (!(j % BUSY_REBALANCE_TICK))
+		load_balance(rq, smp_processor_id(), 0);
 	spin_unlock(&rq->lock);
 }
 
@@ -935,18 +1159,20 @@
 asmlinkage void schedule(void)
 {
 	task_t *prev, *next;
-	runqueue_t *rq;
 	prio_array_t *array;
+	int idx, this_cpu;
+	runqueue_t *rq;
 	list_t *queue;
-	int idx;
+	int retry = 0;
 
 	if (unlikely(in_interrupt()))
 		BUG();
 
+need_resched:
 #if CONFIG_DEBUG_HIGHMEM
 	check_highmem_ptes();
 #endif
-need_resched:
+	this_cpu = smp_processor_id();
 	preempt_disable();
 	prev = current;
 	rq = this_rq();
@@ -975,12 +1201,14 @@
 	}
 pick_next_task:
 	if (unlikely(!rq->nr_running)) {
-#if CONFIG_SMP
-		load_balance(rq, 1);
+		load_balance(rq, this_cpu, 1);
 		if (rq->nr_running)
 			goto pick_next_task;
-#endif
-		next = rq->idle;
+		active_load_balance(rq, this_cpu);
+		if (rq->nr_running)
+			goto pick_next_task;
+pick_idle:
+		next = cpu_idle_ptr(this_cpu);
 		rq->expired_timestamp = 0;
 		goto switch_tasks;
 	}
@@ -996,9 +1224,38 @@
 		rq->expired_timestamp = 0;
 	}
 
+new_array:
 	idx = sched_find_first_bit(array->bitmap);
 	queue = array->queue + idx;
 	next = list_entry(queue->next, task_t, run_list);
+	if ((next != prev) && (rq_nr_cpus(rq) > 1)) {
+		list_t *tmp = queue->next;
+
+		while (task_running(next) || !task_allowed(next, this_cpu)) {
+			tmp = tmp->next;
+			if (tmp != queue) {
+				next = list_entry(tmp, task_t, run_list);
+				continue;
+			}
+			idx = find_next_bit(array->bitmap, MAX_PRIO, ++idx);
+			if (idx == MAX_PRIO) {
+				if (retry || !rq->expired->nr_active)
+					goto pick_idle;
+				/*
+				 * To avoid infinite changing of arrays,
+				 * when we have only tasks runnable by
+				 * sibling.
+				 */
+				retry = 1;
+
+				array = rq->expired;
+				goto new_array;
+			}
+			queue = array->queue + idx;
+			tmp = queue->next;
+			next = list_entry(tmp, task_t, run_list);
+		}
+	}
 
 switch_tasks:
 	prefetch(next);
@@ -1006,7 +1263,8 @@
 
 	if (likely(prev != next)) {
 		rq->nr_switches++;
-		rq->curr = next;
+		cpu_curr_ptr(this_cpu) = next;
+		set_task_cpu(next, this_cpu);
 	
 		prepare_arch_switch(rq, next);
 		prev = context_switch(prev, next);
@@ -1263,9 +1521,8 @@
 		 * If the task is running and lowered its priority,
 		 * or increased its priority then reschedule its CPU:
 		 */
-		if ((NICE_TO_PRIO(nice) < p->static_prio) ||
-							task_running(rq, p))
-			resched_task(rq->curr);
+		if ((NICE_TO_PRIO(nice) < p->static_prio) || task_running(p))
+			resched_task(cpu_curr_ptr(task_cpu(p)));
 	}
 out_unlock:
 	task_rq_unlock(rq, &flags);
@@ -1338,15 +1595,6 @@
 }
 
 /**
- * idle_cpu - is a given cpu idle currently?
- * @cpu: the processor in question.
- */
-int idle_cpu(int cpu)
-{
-	return cpu_curr(cpu) == cpu_rq(cpu)->idle;
-}
-
-/**
  * find_process_by_pid - find a process with a matching PID value.
  * @pid: the pid in question.
  */
@@ -1862,7 +2110,7 @@
 	local_irq_save(flags);
 	double_rq_lock(idle_rq, rq);
 
-	idle_rq->curr = idle_rq->idle = idle;
+	cpu_curr_ptr(cpu) = cpu_idle_ptr(cpu) = idle;
 	deactivate_task(idle, rq);
 	idle->array = NULL;
 	idle->prio = MAX_PRIO;
@@ -1917,6 +2165,7 @@
 	unsigned long flags;
 	migration_req_t req;
 	runqueue_t *rq;
+	int cpu;
 
 #if 0 /* FIXME: Grab cpu_lock, return error on this case. --RR */
 	new_mask &= cpu_online_map;
@@ -1939,16 +2188,17 @@
 	 * If the task is not on a runqueue (and not running), then
 	 * it is sufficient to simply update the task's cpu field.
 	 */
-	if (!p->array && !task_running(rq, p)) {
+	if (!p->array && !task_running(p)) {
 		set_task_cpu(p, __ffs(p->cpus_allowed));
 		task_rq_unlock(rq, &flags);
 		goto out;
 	}
 	init_MUTEX_LOCKED(&req.sem);
 	req.task = p;
-	list_add(&req.list, &rq->migration_queue);
+	cpu = task_cpu(p);
+	list_add(&req.list, migration_queue(cpu));
 	task_rq_unlock(rq, &flags);
-	wake_up_process(rq->migration_thread);
+	wake_up_process(migration_thread(cpu));
 
 	down(&req.sem);
 out:
@@ -1956,15 +2206,15 @@
 }
 
 /*
- * migration_thread - this is a highprio system thread that performs
+ * migration_task - this is a highprio system thread that performs
  * thread migration by 'pulling' threads into the target runqueue.
  */
-static int migration_thread(void * data)
+static int migration_task(void * data)
 {
 	struct sched_param param = { .sched_priority = MAX_RT_PRIO-1 };
 	int cpu = (long) data;
 	runqueue_t *rq;
-	int ret;
+	int ret, idx;
 
 	daemonize();
 	sigfillset(&current->blocked);
@@ -1979,11 +2229,12 @@
 	 * to the target CPU - we'll wake up there.
 	 */
 	if (smp_processor_id() != cpu)
-	printk("migration_task %d on cpu=%d\n", cpu, smp_processor_id());
+	printk("migration_thread %d on cpu=%d\n", cpu, smp_processor_id());
 	ret = setscheduler(0, SCHED_FIFO, &param);
 
 	rq = this_rq();
-	rq->migration_thread = current;
+	migration_thread(cpu) = current;
+	idx = cpu_idx(cpu);
 
 	sprintf(current->comm, "migration_CPU%d", smp_processor_id());
 
@@ -1996,7 +2247,9 @@
 		task_t *p;
 
 		spin_lock_irqsave(&rq->lock, flags);
-		head = &rq->migration_queue;
+		if (cpu_active_balance(cpu))
+			do_active_balance(rq, cpu);
+		head = migration_queue(cpu);
 		current->state = TASK_INTERRUPTIBLE;
 		if (list_empty(head)) {
 			spin_unlock_irqrestore(&rq->lock, flags);
@@ -2043,13 +2296,14 @@
 			  unsigned long action,
 			  void *hcpu)
 {
+	long cpu = (long) hcpu;
+
 	switch (action) {
 	case CPU_ONLINE:
-		printk("Starting migration thread for cpu %li\n",
-		       (long)hcpu);
-		kernel_thread(migration_thread, hcpu,
+		printk("Starting migration thread for cpu %li\n", cpu);
+		kernel_thread(migration_task, hcpu,
 			      CLONE_FS | CLONE_FILES | CLONE_SIGNAL);
-		while (!cpu_rq((long)hcpu)->migration_thread)
+		while (!migration_thread(cpu))
 			yield();
 		break;
 	}
@@ -2096,11 +2350,20 @@
 	for (i = 0; i < NR_CPUS; i++) {
 		prio_array_t *array;
 
+		/*
+		 * Start with a 1:1 mapping between CPUs and runqueues:
+		 */
+#if CONFIG_SHARE_RUNQUEUE
+		rq_idx(i) = i;
+		cpu_idx(i) = 0;
+#endif
 		rq = cpu_rq(i);
 		rq->active = rq->arrays;
 		rq->expired = rq->arrays + 1;
 		spin_lock_init(&rq->lock);
-		INIT_LIST_HEAD(&rq->migration_queue);
+		INIT_LIST_HEAD(migration_queue(i));
+		rq->nr_cpus = 1;
+		rq->cpu[cpu_idx(i)].cpu = i;
 
 		for (j = 0; j < 2; j++) {
 			array = rq->arrays + j;
@@ -2116,9 +2379,8 @@
 	 * We have to do a little magic to get the first
 	 * thread right in SMP mode.
 	 */
-	rq = this_rq();
-	rq->curr = current;
-	rq->idle = current;
+	cpu_curr_ptr(smp_processor_id()) = current;
+	cpu_idle_ptr(smp_processor_id()) = current;
 	set_task_cpu(current, smp_processor_id());
 	wake_up_process(current);
 

