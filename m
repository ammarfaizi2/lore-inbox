Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266936AbTATVEd>; Mon, 20 Jan 2003 16:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266933AbTATVEd>; Mon, 20 Jan 2003 16:04:33 -0500
Received: from mx1.elte.hu ([157.181.1.137]:10393 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S266936AbTATVEN>;
	Mon, 20 Jan 2003 16:04:13 -0500
Date: Mon, 20 Jan 2003 22:18:46 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Theurer <habanero@us.ibm.com>, Erich Focht <efocht@ess.nec.de>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Anton Blanchard <anton@samba.org>, Andrea Arcangeli <andrea@suse.de>
Subject: [patch] HT scheduler, sched-2.5.59-D7
In-Reply-To: <264880000.1043092340@flay>
Message-ID: <Pine.LNX.4.44.0301202204210.18235-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch (against 2.5.59) is my current scheduler tree, it
includes two main areas of changes:

 - interactivity improvements, mostly reworked bits from Andrea's tree and 
   various tunings.

 - HT scheduler: 'shared runqueue' concept plus related logic: HT-aware
   passive load balancing, active-balancing, HT-aware task pickup,
   HT-aware affinity and HT-aware wakeup.

the sched-2.5.59-D7 patch can also be downloaded from:

	http://redhat.com/~mingo/O(1)-scheduler/

the NUMA code compiles, but the boot code needs to be updated to make use
of sched_map_runqueue(). Usage is very simple, the following call:

	sched_map_runqueue(0, 1);

merges CPU#1's runqueue into CPU#0's runqueue, so both CPU#0 and CPU#1
maps to runqueue#0 - runqueue#1 is inactive from that point on. The NUMA
boot code needs to interpret the topology and merge CPUs that are on the
same physical core, into one runqueue. The scheduler code will take care
of all the rest.

there's a 'test_ht' boot option available on x86, that can be used to
trigger a shared runqueue for the first two CPUs, for those who have no
genuine HT boxes but want to give it a go.

(it complicates things that the interactivity changes to the scheduler are
included here as well, but this was my base tree and i didnt want to go
back.)

	Ingo

--- linux/arch/i386/kernel/cpu/proc.c.orig	2003-01-20 22:25:23.000000000 +0100
+++ linux/arch/i386/kernel/cpu/proc.c	2003-01-20 22:58:35.000000000 +0100
@@ -1,4 +1,5 @@
 #include <linux/smp.h>
+#include <linux/sched.h>
 #include <linux/timex.h>
 #include <linux/string.h>
 #include <asm/semaphore.h>
@@ -101,6 +102,13 @@
 		     fpu_exception ? "yes" : "no",
 		     c->cpuid_level,
 		     c->wp_works_ok ? "yes" : "no");
+#if CONFIG_SHARE_RUNQUEUE
+{
+	extern long __rq_idx[NR_CPUS];
+
+	seq_printf(m, "\nrunqueue\t: %d\n", __rq_idx[n]);
+}
+#endif
 
 	for ( i = 0 ; i < 32*NCAPINTS ; i++ )
 		if ( test_bit(i, c->x86_capability) &&
--- linux/arch/i386/kernel/smpboot.c.orig	2003-01-20 19:29:09.000000000 +0100
+++ linux/arch/i386/kernel/smpboot.c	2003-01-20 22:58:35.000000000 +0100
@@ -38,6 +38,7 @@
 #include <linux/kernel.h>
 
 #include <linux/mm.h>
+#include <linux/sched.h>
 #include <linux/kernel_stat.h>
 #include <linux/smp_lock.h>
 #include <linux/irq.h>
@@ -945,6 +946,16 @@
 
 int cpu_sibling_map[NR_CPUS] __cacheline_aligned;
 
+static int test_ht;
+
+static int __init ht_setup(char *str)
+{
+	test_ht = 1;
+	return 1;
+}
+
+__setup("test_ht", ht_setup);
+
 static void __init smp_boot_cpus(unsigned int max_cpus)
 {
 	int apicid, cpu, bit;
@@ -1087,16 +1098,31 @@
 	Dprintk("Boot done.\n");
 
 	/*
-	 * If Hyper-Threading is avaialble, construct cpu_sibling_map[], so
+	 * Here we can be sure that there is an IO-APIC in the system. Let's
+	 * go and set it up:
+	 */
+	smpboot_setup_io_apic();
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
@@ -1112,17 +1138,41 @@
 				printk(KERN_WARNING "WARNING: No sibling found for CPU %d.\n", cpu);
 			}
 		}
-	}
-
-	smpboot_setup_io_apic();
-
-	setup_boot_APIC_clock();
+#if CONFIG_SHARE_RUNQUEUE
+		/*
+		 * At this point APs would have synchronised TSC and
+		 * waiting for smp_commenced, with their APIC timer
+		 * disabled. So BP can go ahead do some initialization
+		 * for Hyper-Threading (if needed).
+		 */
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
+#if CONFIG_SHARE_RUNQUEUE
+	if (smp_num_siblings == 1 && test_ht) {
+		printk("Simulating a 2-sibling 1-phys-CPU HT setup!\n");
+		sched_map_runqueue(0, 1);
+	}
+#endif
 }
 
 /* These are wrappers to interface to the new boot process.  Someone
--- linux/arch/i386/Kconfig.orig	2003-01-20 20:19:23.000000000 +0100
+++ linux/arch/i386/Kconfig	2003-01-20 22:58:35.000000000 +0100
@@ -408,6 +408,24 @@
 
 	  If you don't know what to do here, say N.
 
+choice
+
+	prompt "Hyperthreading Support"
+	depends on SMP
+	default NR_SIBLINGS_0
+
+config NR_SIBLINGS_0
+	bool "off"
+
+config NR_SIBLINGS_2
+	bool "2 siblings"
+
+config NR_SIBLINGS_4
+	bool "4 siblings"
+
+endchoice
+
+
 config PREEMPT
 	bool "Preemptible Kernel"
 	help
--- linux/fs/pipe.c.orig	2003-01-20 19:28:43.000000000 +0100
+++ linux/fs/pipe.c	2003-01-20 22:58:35.000000000 +0100
@@ -117,7 +117,7 @@
 	up(PIPE_SEM(*inode));
 	/* Signal writers asynchronously that there is more room.  */
 	if (do_wakeup) {
-		wake_up_interruptible(PIPE_WAIT(*inode));
+		wake_up_interruptible_sync(PIPE_WAIT(*inode));
 		kill_fasync(PIPE_FASYNC_WRITERS(*inode), SIGIO, POLL_OUT);
 	}
 	if (ret > 0)
@@ -205,7 +205,7 @@
 	}
 	up(PIPE_SEM(*inode));
 	if (do_wakeup) {
-		wake_up_interruptible(PIPE_WAIT(*inode));
+		wake_up_interruptible_sync(PIPE_WAIT(*inode));
 		kill_fasync(PIPE_FASYNC_READERS(*inode), SIGIO, POLL_IN);
 	}
 	if (ret > 0) {
@@ -275,7 +275,7 @@
 		free_page((unsigned long) info->base);
 		kfree(info);
 	} else {
-		wake_up_interruptible(PIPE_WAIT(*inode));
+		wake_up_interruptible_sync(PIPE_WAIT(*inode));
 		kill_fasync(PIPE_FASYNC_READERS(*inode), SIGIO, POLL_IN);
 		kill_fasync(PIPE_FASYNC_WRITERS(*inode), SIGIO, POLL_OUT);
 	}
--- linux/include/linux/sched.h.orig	2003-01-20 19:29:09.000000000 +0100
+++ linux/include/linux/sched.h	2003-01-20 22:58:35.000000000 +0100
@@ -147,6 +147,24 @@
 extern void sched_init(void);
 extern void init_idle(task_t *idle, int cpu);
 
+/*
+ * Is there a way to do this via Kconfig?
+ */
+#define CONFIG_NR_SIBLINGS 0
+
+#if CONFIG_NR_SIBLINGS_2
+# define CONFIG_NR_SIBLINGS 2
+#elif CONFIG_NR_SIBLINGS_4
+# define CONFIG_NR_SIBLINGS 4
+#endif
+
+#if CONFIG_NR_SIBLINGS
+# define CONFIG_SHARE_RUNQUEUE 1
+#else
+# define CONFIG_SHARE_RUNQUEUE 0
+#endif
+extern void sched_map_runqueue(int cpu1, int cpu2);
+
 extern void show_state(void);
 extern void show_trace(unsigned long *stack);
 extern void show_stack(unsigned long *stack);
@@ -293,7 +311,7 @@
 	prio_array_t *array;
 
 	unsigned long sleep_avg;
-	unsigned long sleep_timestamp;
+	unsigned long last_run;
 
 	unsigned long policy;
 	unsigned long cpus_allowed;
@@ -605,6 +623,8 @@
 #define remove_parent(p)	list_del_init(&(p)->sibling)
 #define add_parent(p, parent)	list_add_tail(&(p)->sibling,&(parent)->children)
 
+#if 1
+
 #define REMOVE_LINKS(p) do {					\
 	if (thread_group_leader(p))				\
 		list_del_init(&(p)->tasks);			\
@@ -633,6 +653,31 @@
 #define while_each_thread(g, t) \
 	while ((t = next_thread(t)) != g)
 
+#else
+
+#define REMOVE_LINKS(p) do {					\
+	list_del_init(&(p)->tasks);				\
+	remove_parent(p);					\
+	} while (0)
+
+#define SET_LINKS(p) do {					\
+	list_add_tail(&(p)->tasks,&init_task.tasks);		\
+	add_parent(p, (p)->parent);				\
+	} while (0)
+
+#define next_task(p)	list_entry((p)->tasks.next, struct task_struct, tasks)
+#define prev_task(p)	list_entry((p)->tasks.prev, struct task_struct, tasks)
+
+#define for_each_process(p) \
+	for (p = &init_task ; (p = next_task(p)) != &init_task ; )
+
+#define do_each_thread(g, t) \
+	for (t = &init_task ; (t = next_task(t)) != &init_task ; )
+
+#define while_each_thread(g, t)
+
+#endif
+
 extern task_t * FASTCALL(next_thread(task_t *p));
 
 #define thread_group_leader(p)	(p->pid == p->tgid)
--- linux/include/asm-i386/apic.h.orig	2003-01-20 19:28:31.000000000 +0100
+++ linux/include/asm-i386/apic.h	2003-01-20 22:58:35.000000000 +0100
@@ -98,4 +98,6 @@
 
 #endif /* CONFIG_X86_LOCAL_APIC */
 
+extern int phys_proc_id[NR_CPUS];
+
 #endif /* __ASM_APIC_H */
--- linux/kernel/fork.c.orig	2003-01-20 19:29:09.000000000 +0100
+++ linux/kernel/fork.c	2003-01-20 22:58:35.000000000 +0100
@@ -876,7 +876,7 @@
 	 */
 	p->first_time_slice = 1;
 	current->time_slice >>= 1;
-	p->sleep_timestamp = jiffies;
+	p->last_run = jiffies;
 	if (!current->time_slice) {
 		/*
 	 	 * This case is rare, it happens when the parent has only
--- linux/kernel/sys.c.orig	2003-01-20 19:28:52.000000000 +0100
+++ linux/kernel/sys.c	2003-01-20 22:58:36.000000000 +0100
@@ -220,7 +220,7 @@
 
 	if (error == -ESRCH)
 		error = 0;
-	if (niceval < task_nice(p) && !capable(CAP_SYS_NICE))
+	if (0 && niceval < task_nice(p) && !capable(CAP_SYS_NICE))
 		error = -EACCES;
 	else
 		set_user_nice(p, niceval);
--- linux/kernel/sched.c.orig	2003-01-20 19:29:09.000000000 +0100
+++ linux/kernel/sched.c	2003-01-20 22:58:36.000000000 +0100
@@ -54,20 +54,21 @@
 /*
  * These are the 'tuning knobs' of the scheduler:
  *
- * Minimum timeslice is 10 msecs, default timeslice is 150 msecs,
- * maximum timeslice is 300 msecs. Timeslices get refilled after
+ * Minimum timeslice is 10 msecs, default timeslice is 100 msecs,
+ * maximum timeslice is 200 msecs. Timeslices get refilled after
  * they expire.
  */
 #define MIN_TIMESLICE		( 10 * HZ / 1000)
-#define MAX_TIMESLICE		(300 * HZ / 1000)
-#define CHILD_PENALTY		95
+#define MAX_TIMESLICE		(200 * HZ / 1000)
+#define CHILD_PENALTY		50
 #define PARENT_PENALTY		100
 #define EXIT_WEIGHT		3
 #define PRIO_BONUS_RATIO	25
 #define INTERACTIVE_DELTA	2
-#define MAX_SLEEP_AVG		(2*HZ)
-#define STARVATION_LIMIT	(2*HZ)
-#define NODE_THRESHOLD          125
+#define MAX_SLEEP_AVG		(10*HZ)
+#define STARVATION_LIMIT	(30*HZ)
+#define SYNC_WAKEUPS		1
+#define SMART_WAKE_CHILD	1
 
 /*
  * If a task is 'interactive' then we reinsert it in the active
@@ -141,6 +142,48 @@
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
+# define MAX_NR_SIBLINGS CONFIG_NR_SIBLINGS
+  long __rq_idx[NR_CPUS] __cacheline_aligned;
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
+	struct list_head migration_queue;
+	int active_balance;
+	int cpu;
+} cpu_t;
+
+/*
  * This is the main, per-CPU runqueue data structure.
  *
  * Locking rule: those places that want to lock multiple runqueues
@@ -151,7 +194,7 @@
 	spinlock_t lock;
 	unsigned long nr_running, nr_switches, expired_timestamp,
 			nr_uninterruptible;
-	task_t *curr, *idle;
+	struct mm_struct *prev_mm;
 	prio_array_t *active, *expired, arrays[2];
 	int prev_nr_running[NR_CPUS];
 #ifdef CONFIG_NUMA
@@ -159,27 +202,39 @@
 	unsigned int nr_balanced;
 	int prev_node_load[MAX_NUMNODES];
 #endif
-	task_t *migration_thread;
-	struct list_head migration_queue;
+	int nr_cpus;
+	cpu_t cpu[MAX_NR_SIBLINGS];
 
 	atomic_t nr_iowait;
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
+# define task_running(p)		(cpu_curr_ptr(task_cpu(p)) == (p))
 #endif
 
 #ifdef CONFIG_NUMA
@@ -322,16 +377,21 @@
  * Also update all the scheduling statistics stuff. (sleep average
  * calculation, priority modifiers, etc.)
  */
+static inline void __activate_task(task_t *p, runqueue_t *rq)
+{
+	enqueue_task(p, rq->active);
+	nr_running_inc(rq);
+}
+
 static inline void activate_task(task_t *p, runqueue_t *rq)
 {
-	unsigned long sleep_time = jiffies - p->sleep_timestamp;
-	prio_array_t *array = rq->active;
+	unsigned long sleep_time = jiffies - p->last_run;
 
 	if (!rt_task(p) && sleep_time) {
 		/*
 		 * This code gives a bonus to interactive tasks. We update
 		 * an 'average sleep time' value here, based on
-		 * sleep_timestamp. The more time a task spends sleeping,
+		 * ->last_run. The more time a task spends sleeping,
 		 * the higher the average gets - and the higher the priority
 		 * boost gets as well.
 		 */
@@ -340,8 +400,7 @@
 			p->sleep_avg = MAX_SLEEP_AVG;
 		p->prio = effective_prio(p);
 	}
-	enqueue_task(p, array);
-	nr_running_inc(rq);
+	__activate_task(p, rq);
 }
 
 /*
@@ -382,6 +441,11 @@
 #endif
 }
 
+static inline void resched_cpu(int cpu)
+{
+	resched_task(cpu_curr_ptr(cpu));
+}
+
 #ifdef CONFIG_SMP
 
 /*
@@ -398,7 +462,7 @@
 repeat:
 	preempt_disable();
 	rq = task_rq(p);
-	if (unlikely(task_running(rq, p))) {
+	if (unlikely(task_running(p))) {
 		cpu_relax();
 		/*
 		 * enable/disable preemption just to make this
@@ -409,7 +473,7 @@
 		goto repeat;
 	}
 	rq = task_rq_lock(p, &flags);
-	if (unlikely(task_running(rq, p))) {
+	if (unlikely(task_running(p))) {
 		task_rq_unlock(rq, &flags);
 		preempt_enable();
 		goto repeat;
@@ -431,10 +495,39 @@
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
 /***
  * try_to_wake_up - wake up a thread
  * @p: the to-be-woken-up thread
@@ -455,6 +548,7 @@
 	long old_state;
 	runqueue_t *rq;
 
+	sync &= SYNC_WAKEUPS;
 repeat_lock_task:
 	rq = task_rq_lock(p, &flags);
 	old_state = p->state;
@@ -463,7 +557,7 @@
 		 * Fast-migrate the task if it's not running or runnable
 		 * currently. Do not violate hard affinity.
 		 */
-		if (unlikely(sync && !task_running(rq, p) &&
+		if (unlikely(sync && !task_running(p) &&
 			(task_cpu(p) != smp_processor_id()) &&
 			(p->cpus_allowed & (1UL << smp_processor_id())))) {
 
@@ -473,10 +567,12 @@
 		}
 		if (old_state == TASK_UNINTERRUPTIBLE)
 			rq->nr_uninterruptible--;
-		activate_task(p, rq);
-
-		if (p->prio < rq->curr->prio)
-			resched_task(rq->curr);
+		if (sync)
+			__activate_task(p, rq);
+		else {
+			activate_task(p, rq);
+			wake_up_cpu(rq, task_cpu(p), p);
+		}
 		success = 1;
 	}
 	p->state = TASK_RUNNING;
@@ -512,8 +608,19 @@
 		p->prio = effective_prio(p);
 	}
 	set_task_cpu(p, smp_processor_id());
-	activate_task(p, rq);
 
+	if (SMART_WAKE_CHILD) {
+		if (unlikely(!current->array))
+			__activate_task(p, rq);
+		else {
+			p->prio = current->prio;
+			list_add_tail(&p->run_list, &current->run_list);
+			p->array = current->array;
+			p->array->nr_active++;
+			nr_running_inc(rq);
+		}
+	} else
+		activate_task(p, rq);
 	rq_unlock(rq);
 }
 
@@ -561,7 +668,7 @@
  * context_switch - switch to the new MM and the new
  * thread's register state.
  */
-static inline task_t * context_switch(task_t *prev, task_t *next)
+static inline task_t * context_switch(runqueue_t *rq, task_t *prev, task_t *next)
 {
 	struct mm_struct *mm = next->mm;
 	struct mm_struct *oldmm = prev->active_mm;
@@ -575,7 +682,7 @@
 
 	if (unlikely(!prev->mm)) {
 		prev->active_mm = NULL;
-		mmdrop(oldmm);
+		rq->prev_mm = oldmm;
 	}
 
 	/* Here we just switch the register state and the stack. */
@@ -596,8 +703,9 @@
 	unsigned long i, sum = 0;
 
 	for (i = 0; i < NR_CPUS; i++)
-		sum += cpu_rq(i)->nr_running;
-
+		/* Shared runqueues are counted only once. */
+		if (!cpu_idx(i))
+			sum += cpu_rq(i)->nr_running;
 	return sum;
 }
 
@@ -608,7 +716,9 @@
 	for (i = 0; i < NR_CPUS; i++) {
 		if (!cpu_online(i))
 			continue;
-		sum += cpu_rq(i)->nr_uninterruptible;
+		/* Shared runqueues are counted only once. */
+		if (!cpu_idx(i))
+			sum += cpu_rq(i)->nr_uninterruptible;
 	}
 	return sum;
 }
@@ -790,7 +900,23 @@
 
 #endif /* CONFIG_NUMA */
 
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
@@ -906,12 +1032,7 @@
 	set_task_cpu(p, this_cpu);
 	nr_running_inc(this_rq);
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
@@ -922,9 +1043,9 @@
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
 	struct list_head *head, *curr;
@@ -972,12 +1093,14 @@
 	 * 1) running (obviously), or
 	 * 2) cannot be migrated to this CPU due to cpus_allowed, or
 	 * 3) are cache-hot on their current CPU.
+	 *
+	 * (except if we are in idle mode which is a more agressive
+	 *  form of rebalancing.)
 	 */
 
-#define CAN_MIGRATE_TASK(p,rq,this_cpu)					\
-	((jiffies - (p)->sleep_timestamp > cache_decay_ticks) &&	\
-		!task_running(rq, p) &&					\
-			((p)->cpus_allowed & (1UL << (this_cpu))))
+#define CAN_MIGRATE_TASK(p,rq,cpu)					\
+	((idle || (jiffies - (p)->last_run > cache_decay_ticks)) && \
+		!task_running(p) && task_allowed(p, cpu))
 
 	curr = curr->prev;
 
@@ -1000,31 +1123,136 @@
 	;
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
 /*
- * One of the idle_cpu_tick() and busy_cpu_tick() functions will
- * get called every timer tick, on every CPU. Our balancing action
- * frequency and balancing agressivity depends on whether the CPU is
- * idle or not.
+ * This routine is called to map a CPU into another CPU's runqueue.
  *
- * busy-rebalance every 250 msecs. idle-rebalance every 1 msec. (or on
- * systems with HZ=100, every 10 msecs.)
+ * This must be called during bootup with the merged runqueue having
+ * no tasks.
  */
-#define BUSY_REBALANCE_TICK (HZ/4 ?: 1)
-#define IDLE_REBALANCE_TICK (HZ/1000 ?: 1)
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
 
-static inline void idle_tick(runqueue_t *rq)
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
+#endif
+#endif
+
+DEFINE_PER_CPU(struct kernel_stat, kstat) = { { 0 } };
+
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
 
-#endif
-
-DEFINE_PER_CPU(struct kernel_stat, kstat) = { { 0 } };
-
 /*
  * We place interactive tasks back into the active array, if possible.
  *
@@ -1035,9 +1263,9 @@
  * increasing number of running tasks:
  */
 #define EXPIRED_STARVING(rq) \
-		((rq)->expired_timestamp && \
+		(STARVATION_LIMIT && ((rq)->expired_timestamp && \
 		(jiffies - (rq)->expired_timestamp >= \
-			STARVATION_LIMIT * ((rq)->nr_running) + 1))
+			STARVATION_LIMIT * ((rq)->nr_running) + 1)))
 
 /*
  * This function gets called by the timer code, with HZ frequency.
@@ -1050,12 +1278,13 @@
 {
 	int cpu = smp_processor_id();
 	runqueue_t *rq = this_rq();
+	unsigned long j = jiffies;
 	task_t *p = current;
 
  	if (rcu_pending(cpu))
  		rcu_check_callbacks(cpu, user_ticks);
 
-	if (p == rq->idle) {
+	if (p == cpu_idle_ptr(cpu)) {
 		/* note: this timer irq context must be accounted for as well */
 		if (irq_count() - HARDIRQ_OFFSET >= SOFTIRQ_OFFSET)
 			kstat_cpu(cpu).cpustat.system += sys_ticks;
@@ -1063,9 +1292,7 @@
 			kstat_cpu(cpu).cpustat.iowait += sys_ticks;
 		else
 			kstat_cpu(cpu).cpustat.idle += sys_ticks;
-#if CONFIG_SMP
-		idle_tick(rq);
-#endif
+		idle_tick(rq, j);
 		return;
 	}
 	if (TASK_NICE(p) > 0)
@@ -1074,12 +1301,13 @@
 		kstat_cpu(cpu).cpustat.user += user_ticks;
 	kstat_cpu(cpu).cpustat.system += sys_ticks;
 
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
@@ -1115,16 +1343,14 @@
 
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
 
@@ -1135,11 +1361,11 @@
  */
 asmlinkage void schedule(void)
 {
+	int idx, this_cpu, retry = 0;
+	struct list_head *queue;
 	task_t *prev, *next;
-	runqueue_t *rq;
 	prio_array_t *array;
-	struct list_head *queue;
-	int idx;
+	runqueue_t *rq;
 
 	/*
 	 * Test if we are atomic.  Since do_exit() needs to call into
@@ -1152,15 +1378,15 @@
 			dump_stack();
 		}
 	}
-
-	check_highmem_ptes();
 need_resched:
+	check_highmem_ptes();
+	this_cpu = smp_processor_id();
 	preempt_disable();
 	prev = current;
 	rq = this_rq();
 
 	release_kernel_lock(prev);
-	prev->sleep_timestamp = jiffies;
+	prev->last_run = jiffies;
 	spin_lock_irq(&rq->lock);
 
 	/*
@@ -1183,12 +1409,14 @@
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
@@ -1204,24 +1432,59 @@
 		rq->expired_timestamp = 0;
 	}
 
+new_array:
 	idx = sched_find_first_bit(array->bitmap);
 	queue = array->queue + idx;
 	next = list_entry(queue->next, task_t, run_list);
+	if ((next != prev) && (rq_nr_cpus(rq) > 1)) {
+		struct list_head *tmp = queue->next;
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
 	clear_tsk_need_resched(prev);
-	RCU_qsctr(prev->thread_info->cpu)++;
+	RCU_qsctr(task_cpu(prev))++;
 
 	if (likely(prev != next)) {
+		struct mm_struct *prev_mm;
 		rq->nr_switches++;
-		rq->curr = next;
+		cpu_curr_ptr(this_cpu) = next;
+		set_task_cpu(next, this_cpu);
 	
 		prepare_arch_switch(rq, next);
-		prev = context_switch(prev, next);
+		prev = context_switch(rq, prev, next);
 		barrier();
 		rq = this_rq();
+		prev_mm = rq->prev_mm;
+		rq->prev_mm = NULL;
 		finish_arch_switch(rq, prev);
+		if (prev_mm)
+			mmdrop(prev_mm);
 	} else
 		spin_unlock_irq(&rq->lock);
 
@@ -1481,9 +1744,8 @@
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
@@ -1561,7 +1823,7 @@
  */
 int task_curr(task_t *p)
 {
-	return cpu_curr(task_cpu(p)) == p;
+	return cpu_curr_ptr(task_cpu(p)) == p;
 }
 
 /**
@@ -1570,7 +1832,7 @@
  */
 int idle_cpu(int cpu)
 {
-	return cpu_curr(cpu) == cpu_rq(cpu)->idle;
+	return cpu_curr_ptr(cpu) == cpu_idle_ptr(cpu);
 }
 
 /**
@@ -1660,7 +1922,7 @@
 	else
 		p->prio = p->static_prio;
 	if (array)
-		activate_task(p, task_rq(p));
+		__activate_task(p, task_rq(p));
 
 out_unlock:
 	task_rq_unlock(rq, &flags);
@@ -2135,7 +2397,7 @@
 	local_irq_save(flags);
 	double_rq_lock(idle_rq, rq);
 
-	idle_rq->curr = idle_rq->idle = idle;
+	cpu_curr_ptr(cpu) = cpu_idle_ptr(cpu) = idle;
 	deactivate_task(idle, rq);
 	idle->array = NULL;
 	idle->prio = MAX_PRIO;
@@ -2190,6 +2452,7 @@
 	unsigned long flags;
 	migration_req_t req;
 	runqueue_t *rq;
+	int cpu;
 
 #if 0 /* FIXME: Grab cpu_lock, return error on this case. --RR */
 	new_mask &= cpu_online_map;
@@ -2211,31 +2474,31 @@
 	 * If the task is not on a runqueue (and not running), then
 	 * it is sufficient to simply update the task's cpu field.
 	 */
-	if (!p->array && !task_running(rq, p)) {
+	if (!p->array && !task_running(p)) {
 		set_task_cpu(p, __ffs(p->cpus_allowed));
 		task_rq_unlock(rq, &flags);
 		return;
 	}
 	init_completion(&req.done);
 	req.task = p;
-	list_add(&req.list, &rq->migration_queue);
+	cpu = task_cpu(p);
+	list_add(&req.list, migration_queue(cpu));
 	task_rq_unlock(rq, &flags);
-
-	wake_up_process(rq->migration_thread);
+	wake_up_process(migration_thread(cpu));
 
 	wait_for_completion(&req.done);
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
@@ -2250,7 +2513,8 @@
 	ret = setscheduler(0, SCHED_FIFO, &param);
 
 	rq = this_rq();
-	rq->migration_thread = current;
+	migration_thread(cpu) = current;
+	idx = cpu_idx(cpu);
 
 	sprintf(current->comm, "migration/%d", smp_processor_id());
 
@@ -2263,7 +2527,9 @@
 		task_t *p;
 
 		spin_lock_irqsave(&rq->lock, flags);
-		head = &rq->migration_queue;
+		if (cpu_active_balance(cpu))
+			do_active_balance(rq, cpu);
+		head = migration_queue(cpu);
 		current->state = TASK_INTERRUPTIBLE;
 		if (list_empty(head)) {
 			spin_unlock_irqrestore(&rq->lock, flags);
@@ -2292,9 +2558,8 @@
 			set_task_cpu(p, cpu_dest);
 			if (p->array) {
 				deactivate_task(p, rq_src);
-				activate_task(p, rq_dest);
-				if (p->prio < rq_dest->curr->prio)
-					resched_task(rq_dest->curr);
+				__activate_task(p, rq_dest);
+				wake_up_cpu(rq_dest, cpu_dest, p);
 			}
 		}
 		double_rq_unlock(rq_src, rq_dest);
@@ -2312,12 +2577,13 @@
 			  unsigned long action,
 			  void *hcpu)
 {
+	long cpu = (long) hcpu;
+
 	switch (action) {
 	case CPU_ONLINE:
-		printk("Starting migration thread for cpu %li\n",
-		       (long)hcpu);
-		kernel_thread(migration_thread, hcpu, CLONE_KERNEL);
-		while (!cpu_rq((long)hcpu)->migration_thread)
+		printk("Starting migration thread for cpu %li\n", cpu);
+		kernel_thread(migration_task, hcpu, CLONE_KERNEL);
+		while (!migration_thread(cpu))
 			yield();
 		break;
 	}
@@ -2392,11 +2658,20 @@
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
 		atomic_set(&rq->nr_iowait, 0);
 		nr_running_init(rq);
 
@@ -2414,9 +2689,13 @@
 	 * We have to do a little magic to get the first
 	 * thread right in SMP mode.
 	 */
-	rq = this_rq();
-	rq->curr = current;
-	rq->idle = current;
+	cpu_curr_ptr(smp_processor_id()) = current;
+	cpu_idle_ptr(smp_processor_id()) = current;
+	printk("sched_init().\n");
+	printk("smp_processor_id(): %d.\n", smp_processor_id());
+	printk("rq_idx(smp_processor_id()): %ld.\n", rq_idx(smp_processor_id()));
+	printk("this_rq(): %p.\n", this_rq());
+
 	set_task_cpu(current, smp_processor_id());
 	wake_up_process(current);
 
--- linux/init/main.c.orig	2003-01-20 19:29:09.000000000 +0100
+++ linux/init/main.c	2003-01-20 22:58:36.000000000 +0100
@@ -354,7 +354,14 @@
 
 static void rest_init(void)
 {
+	/* 
+	 *	We count on the initial thread going ok 
+	 *	Like idlers init is an unlocked kernel thread, which will
+	 *	make syscalls (and thus be locked).
+	 */
+	init_idle(current, smp_processor_id());
 	kernel_thread(init, NULL, CLONE_KERNEL);
+
 	unlock_kernel();
  	cpu_idle();
 } 
@@ -438,13 +445,6 @@
 	check_bugs();
 	printk("POSIX conformance testing by UNIFIX\n");
 
-	/* 
-	 *	We count on the initial thread going ok 
-	 *	Like idlers init is an unlocked kernel thread, which will
-	 *	make syscalls (and thus be locked).
-	 */
-	init_idle(current, smp_processor_id());
-
 	/* Do the rest non-__init'ed, we're now alive */
 	rest_init();
 }



