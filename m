Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbTIKWge (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 18:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbTIKWge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 18:36:34 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:14249 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261522AbTIKWgD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 18:36:03 -0400
Message-Id: <200309112235.h8BMZcM03839@owlet.beaverton.ibm.com>
To: akpm@osdl.org, kernel@kolivas.org, piggin@cyberone.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] schedstat-2.6.0-test5-A1 measuring process scheduling latency
Date: Thu, 11 Sep 2003 15:35:38 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All the tweaking of the scheduler for interactive processes is still
rather reliant on "when I run X, Y, and Z, and wiggle the mouse, it feels
slower."  At best, we might get a more concrete "the music skips every
now and then."  It's very hard to develop changes for an environment I
don't have in front of me and can't ever seem to precisely duplicate.

It's my contention that what we're seeing is scheduler latency: processes
want to run but end up waiting for some period of time.  There's currently
no way to capture that short of the descriptions above.  This patch adds
counters at various places to measure, among other things, the scheduler
latency.  That is, we can now measure the time processes spend waiting
to run after being made runnable.  We can also see on average how long
a process runs before giving up (or being kicked off) the cpu.

The patch is included below (about 20K) but more info on what it does
and how to use it can be found at

    http://eaglet.rain.com/rick/linux/schedstat/index.html
    - and -
    http://eaglet.rain.com/rick/linux/schedstat/format-4.html

If we could get testers to apply this patch and either

    * capture /proc/schedstat output with a

	    while true do
		cat /proc/schedstat >> savefile
		sleep 20
	    done
      
      script in the background, OR

    * utilize the latency program on the above web pages to trace specific
      processes

we could be making statements like "process X is only running 8ms before
yielding the processor but taking 64ms to get back on" or "processes seem
to be waiting about 15% less than before" rather than "the window seems
to open more slowly" or "xmms had some skips but fewer than I remember
last time".

One caveat is that this patch makes scheduler statistics a config option,
and I put it under i386 because I didn't know how to make it globally
accessible. (I'll be happy if a config guru can make a suggestion there.)
So if you don't run i386, you may not be able to use this "out of the
box" (although there's no i386-specific code here that I'm aware of).
If you make it run on your machine, I'll gladly accept the diffs and
integrate them.

Rick

diff -rupN linux-2.6.0-test5/arch/i386/Kconfig linux-2.6.0-test5-ss+/arch/i386/Kconfig
--- linux-2.6.0-test5/arch/i386/Kconfig	Mon Sep  8 12:49:53 2003
+++ linux-2.6.0-test5-ss+/arch/i386/Kconfig	Wed Sep 10 21:48:51 2003
@@ -1323,6 +1323,18 @@ config FRAME_POINTER
 	  If you don't debug the kernel, you can say N, but we may not be able
 	  to solve problems without frame pointers.
 
+config SCHEDSTATS
+	bool "Collect scheduler statistics"
+	help
+	  If you say Y here, additional code will be inserted into the
+	  scheduler and related routines to collect statistics about
+	  scheduler behavior and provide them in /proc/schedstat.  These
+	  stats may be useful for both tuning and debugging the scheduler
+	  If you aren't debugging the scheduler or trying to tune a specific
+	  application, you can say N to avoid the very slight overhead
+	  this adds.
+	default y
+
 config X86_EXTRA_IRQS
 	bool
 	depends on X86_LOCAL_APIC || X86_VOYAGER
diff -rupN linux-2.6.0-test5/fs/proc/array.c linux-2.6.0-test5-ss+/fs/proc/array.c
--- linux-2.6.0-test5/fs/proc/array.c	Mon Sep  8 12:50:07 2003
+++ linux-2.6.0-test5-ss+/fs/proc/array.c	Wed Sep 10 21:50:19 2003
@@ -336,7 +336,7 @@ int proc_pid_stat(struct task_struct *ta
 	read_unlock(&tasklist_lock);
 	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
 %lu %lu %lu %lu %lu %ld %ld %ld %ld %ld %ld %llu %lu %ld %lu %lu %lu %lu %lu \
-%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu\n",
+%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu %lu %lu %lu\n",
 		task->pid,
 		task->comm,
 		state,
@@ -382,7 +382,14 @@ int proc_pid_stat(struct task_struct *ta
 		task->exit_signal,
 		task_cpu(task),
 		task->rt_priority,
+#ifdef CONFIG_SCHEDSTATS
+		task->policy,
+		task->sched_info.cpu_time,
+		task->sched_info.run_delay,
+		task->sched_info.pcnt);
+#else
 		task->policy);
+#endif /* CONFIG_SCHEDSTATS */
 	if(mm)
 		mmput(mm);
 	return res;
diff -rupN linux-2.6.0-test5/fs/proc/proc_misc.c linux-2.6.0-test5-ss+/fs/proc/proc_misc.c
--- linux-2.6.0-test5/fs/proc/proc_misc.c	Mon Sep  8 12:49:53 2003
+++ linux-2.6.0-test5-ss+/fs/proc/proc_misc.c	Mon Sep  8 18:38:46 2003
@@ -286,6 +286,11 @@ static struct file_operations proc_vmsta
 	.release	= seq_release,
 };
 
+#ifdef CONFIG_SCHEDSTATS
+extern int schedstats_read_proc(char *page, char **start, off_t off,
+				 int count, int *eof, void *data);
+#endif
+
 #ifdef CONFIG_PROC_HARDWARE
 static int hardware_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
@@ -663,6 +668,9 @@ void __init proc_misc_init(void)
 #endif
 		{"locks",	locks_read_proc},
 		{"execdomains",	execdomains_read_proc},
+#ifdef CONFIG_SCHEDSTATS
+		{"schedstat",	schedstats_read_proc},
+#endif
 		{NULL,}
 	};
 	for (p = simple_ones; p->name; p++)
diff -rupN linux-2.6.0-test5/include/linux/sched.h linux-2.6.0-test5-ss+/include/linux/sched.h
--- linux-2.6.0-test5/include/linux/sched.h	Mon Sep  8 12:49:53 2003
+++ linux-2.6.0-test5-ss+/include/linux/sched.h	Wed Sep 10 21:52:03 2003
@@ -96,6 +96,11 @@ extern unsigned long nr_running(void);
 extern unsigned long nr_uninterruptible(void);
 extern unsigned long nr_iowait(void);
 
+#ifdef CONFIG_SCHEDSTATS
+struct sched_info;
+extern void cpu_sched_info(struct sched_info *, int);
+#endif
+
 #include <linux/time.h>
 #include <linux/param.h>
 #include <linux/resource.h>
@@ -322,6 +327,18 @@ struct k_itimer {
 	struct sigqueue *sigq;		/* signal queue entry. */
 };
 
+#ifdef CONFIG_SCHEDSTATS
+struct sched_info {
+	/* cumulative counters */
+	unsigned long	cpu_time,	/* time spent on the cpu */
+			run_delay,	/* time spent waiting on a runqueue */
+			pcnt;		/* # of timeslices run on this cpu */
+
+	/* timestamps */
+	unsigned long	last_arrival,	/* when we last ran on a cpu */
+			last_queued;	/* when we were last queued to run */
+};
+#endif /* CONFIG_SCHEDSTATS */
 
 struct io_context;			/* See blkdev.h */
 void exit_io_context(void);
@@ -346,6 +363,10 @@ struct task_struct {
 	cpumask_t cpus_allowed;
 	unsigned int time_slice, first_time_slice;
 
+#ifdef CONFIG_SCHEDSTATS
+	struct sched_info sched_info;
+#endif /* CONFIG_SCHEDSTATS */
+
 	struct list_head tasks;
 	struct list_head ptrace_children;
 	struct list_head ptrace_list;
diff -rupN linux-2.6.0-test5/kernel/fork.c linux-2.6.0-test5-ss+/kernel/fork.c
--- linux-2.6.0-test5/kernel/fork.c	Mon Sep  8 12:49:53 2003
+++ linux-2.6.0-test5-ss+/kernel/fork.c	Wed Sep 10 21:52:38 2003
@@ -868,6 +868,9 @@ struct task_struct *copy_process(unsigne
 	p->start_time = get_jiffies_64();
 	p->security = NULL;
 	p->io_context = NULL;
+#ifdef CONFIG_SCHEDSTATS
+	memset(&p->sched_info, 0, sizeof(p->sched_info));
+#endif /* CONFIG_SCHEDSTATS */
 
 	retval = -ENOMEM;
 	if ((retval = security_task_alloc(p)))
diff -rupN linux-2.6.0-test5/kernel/sched.c linux-2.6.0-test5-ss+/kernel/sched.c
--- linux-2.6.0-test5/kernel/sched.c	Mon Sep  8 12:50:21 2003
+++ linux-2.6.0-test5-ss+/kernel/sched.c	Wed Sep 10 21:59:29 2003
@@ -34,6 +34,7 @@
 #include <linux/rcupdate.h>
 #include <linux/cpu.h>
 #include <linux/percpu.h>
+#include <linux/times.h>
 
 #ifdef CONFIG_NUMA
 #define cpu_to_node_mask(cpu) node_to_cpumask(cpu_to_node(cpu))
@@ -160,6 +161,9 @@ struct runqueue {
 	unsigned long nr_running, nr_switches, expired_timestamp,
 			nr_uninterruptible;
 	task_t *curr, *idle;
+#ifdef CONFIG_SCHEDSTATS
+	int cpu;  /* to make easy reverse-lookups with per-cpu runqueues */
+#endif
 	struct mm_struct *prev_mm;
 	prio_array_t *active, *expired, arrays[2];
 	int prev_cpu_load[NR_CPUS];
@@ -171,6 +175,10 @@ struct runqueue {
 	struct list_head migration_queue;
 
 	atomic_t nr_iowait;
+
+#ifdef CONFIG_SCHEDSTATS
+	struct sched_info info;
+#endif
 };
 
 static DEFINE_PER_CPU(struct runqueue, runqueues);
@@ -235,6 +243,120 @@ __init void node_nr_running_init(void)
 
 #endif /* CONFIG_NUMA */
 
+
+#ifdef CONFIG_SCHEDSTATS
+struct schedstat {
+	/* sys_sched_yield stats */
+	unsigned long yld_exp_empty;
+	unsigned long yld_act_empty;
+	unsigned long yld_both_empty;
+	unsigned long yld_cnt;
+
+	/* schedule stats */
+	unsigned long sched_noswitch;
+	unsigned long sched_switch;
+	unsigned long sched_cnt;
+
+	/* load_balance stats */
+	unsigned long lb_imbalance;
+	unsigned long lb_idle;
+	unsigned long lb_busy;
+	unsigned long lb_resched;
+	unsigned long lb_cnt;
+	unsigned long lb_nobusy;
+	unsigned long lb_bnode;
+
+	/* pull_task stats */
+	unsigned long pt_gained;
+	unsigned long pt_lost;
+	unsigned long pt_node_gained;
+	unsigned long pt_node_lost;
+
+	/* balance_node stats */
+	unsigned long bn_cnt;
+	unsigned long bn_idle;
+} ____cacheline_aligned;
+
+/*
+ * bump this up when changing the output format or the meaning of an existing
+ * format, so that tools can adapt (or abort)
+ */
+#define SCHEDSTAT_VERSION	3
+
+struct schedstat schedstats[NR_CPUS];
+
+/*
+ * This could conceivably exceed a page's worth of output on machines with
+ * large number of cpus, where large == about 4096/100 or 40ish. Start
+ * worrying when we pass 32, probably. Then this has to stop being a
+ * "simple" entry in proc/proc_misc.c and needs to be an actual seq_file.
+ */
+int schedstats_read_proc(char *page, char **start, off_t off,
+				 int count, int *eof, void *data)
+{
+	struct schedstat sums;
+	int i, len;
+
+	memset(&sums, 0, sizeof(sums));
+	len = sprintf(page, "version %d\n", SCHEDSTAT_VERSION);
+	for (i = 0; i < NR_CPUS; i++) {
+
+		struct sched_info info;
+
+		if (!cpu_online(i)) continue;
+
+		cpu_sched_info(&info, i);
+
+		sums.yld_exp_empty += schedstats[i].yld_exp_empty;
+		sums.yld_act_empty += schedstats[i].yld_act_empty;
+		sums.yld_both_empty += schedstats[i].yld_both_empty;
+		sums.yld_cnt += schedstats[i].yld_cnt;
+		sums.sched_noswitch += schedstats[i].sched_noswitch;
+		sums.sched_switch += schedstats[i].sched_switch;
+		sums.sched_cnt += schedstats[i].sched_cnt;
+		sums.lb_idle += schedstats[i].lb_idle;
+		sums.lb_busy += schedstats[i].lb_busy;
+		sums.lb_resched += schedstats[i].lb_resched;
+		sums.lb_cnt += schedstats[i].lb_cnt;
+		sums.lb_imbalance += schedstats[i].lb_imbalance;
+		sums.lb_nobusy += schedstats[i].lb_nobusy;
+		sums.lb_bnode += schedstats[i].lb_bnode;
+		sums.pt_node_gained += schedstats[i].pt_node_gained;
+		sums.pt_node_lost += schedstats[i].pt_node_lost;
+		sums.pt_gained += schedstats[i].pt_gained;
+		sums.pt_lost += schedstats[i].pt_lost;
+		sums.bn_cnt += schedstats[i].bn_cnt;
+		sums.bn_idle += schedstats[i].bn_idle;
+		len += sprintf(page + len,
+		    "cpu%d %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu "
+		    "%lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu\n",
+		    i, schedstats[i].yld_both_empty,
+		    schedstats[i].yld_act_empty, schedstats[i].yld_exp_empty,
+		    schedstats[i].yld_cnt, schedstats[i].sched_noswitch,
+		    schedstats[i].sched_switch, schedstats[i].sched_cnt,
+		    schedstats[i].lb_idle, schedstats[i].lb_busy,
+		    schedstats[i].lb_resched,
+		    schedstats[i].lb_cnt, schedstats[i].lb_imbalance,
+		    schedstats[i].lb_nobusy, schedstats[i].lb_bnode,
+		    schedstats[i].pt_gained, schedstats[i].pt_lost,
+		    schedstats[i].pt_node_gained, schedstats[i].pt_node_lost,
+		    schedstats[i].bn_cnt, schedstats[i].bn_idle,
+		    info.cpu_time, info.run_delay, info.pcnt);
+	}
+	len += sprintf(page + len,
+	    "totals %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu "
+	    "%lu %lu %lu %lu %lu %lu %lu\n",
+	    sums.yld_both_empty, sums.yld_act_empty, sums.yld_exp_empty,
+	    sums.yld_cnt, sums.sched_noswitch, sums.sched_switch,
+	    sums.sched_cnt, sums.lb_idle, sums.lb_busy, sums.lb_resched,
+	    sums.lb_cnt, sums.lb_imbalance, sums.lb_nobusy, sums.lb_bnode,
+	    sums.pt_gained, sums.pt_lost, sums.pt_node_gained,
+	    sums.pt_node_lost, sums.bn_cnt, sums.bn_idle);
+
+	return len;
+}
+#endif
+
 /*
  * task_rq_lock - lock the runqueue a given task resides on and disable
  * interrupts.  Note the ordering: we can safely lookup the task_rq without
@@ -279,6 +401,110 @@ static inline void rq_unlock(runqueue_t 
 	spin_unlock_irq(&rq->lock);
 }
 
+#ifdef CONFIG_SCHEDSTATS
+/*
+ * Called when a process is dequeued from the active array and given
+ * the cpu.  We should note that with the exception of interactive
+ * tasks, the expired queue will become the active queue after the active
+ * queue is empty, without explicitly dequeuing and requeuing tasks in the
+ * expired queue.  (Interactive tasks may be requeued directly to the
+ * active queue, thus delaying tasks in the expired queue from running;
+ * see scheduler_tick()).
+ *
+ * This function is only called from sched_info_arrive(), rather than
+ * dequeue_task(). Even though a task may be queued and dequeued multiple
+ * times as it is shuffled about, we're really interested in knowing how
+ * long it was from the *first* time it was queued to the time that it
+ * finally hit a cpu.
+ */
+static inline void sched_info_dequeued(task_t *t)
+{
+	t->sched_info.last_queued = 0;
+}
+
+/*
+ * Called when a task finally hits the cpu.  We can now calculate how
+ * long it was waiting to run.  We also note when it began so that we
+ * can keep stats on how long its timeslice is.
+ */
+static inline void sched_info_arrive(task_t *t)
+{
+	unsigned long now  = jiffies;
+	unsigned long diff = 0;
+	struct runqueue *rq = task_rq(t);
+
+	if (t->sched_info.last_queued)
+		diff = now - t->sched_info.last_queued;
+	sched_info_dequeued(t);
+	t->sched_info.run_delay += diff;
+	t->sched_info.last_arrival = now;
+	t->sched_info.pcnt++;
+
+	if (!rq)
+		return;
+	
+	rq->info.run_delay += diff;
+	rq->info.pcnt++;
+}
+
+/*
+ * Called when a process is queued into either the active or expired
+ * array.  The time is noted and later used to determine how long we
+ * had to wait for us to reach the cpu.  Since the expired queue will
+ * become the active queue after active queue is empty, without dequeuing
+ * and requeuing any tasks, we are interested in queuing to either. It
+ * is unusual but not impossible for tasks to be dequeued and immediately
+ * requeued in the same or another array: this can happen in sched_yield(),
+ * set_user_nice(), and even load_balance() as it moves tasks from runqueue
+ * to runqueue.
+ *
+ * This function is only called from enqueue_task(), but also only updates
+ * the timestamp if it is already not set.  It's assumed that
+ * sched_info_dequeued() will clear that stamp when appropriate.
+ */
+static inline void sched_info_queued(task_t *t)
+{
+	if (!t->sched_info.last_queued)
+		t->sched_info.last_queued = jiffies;
+}
+
+/*
+ * Called when a process ceases being the active-running process, either
+ * voluntarily or involuntarily.  Now we can calculate how long we ran.
+ */
+static inline void sched_info_depart(task_t *t)
+{
+	struct runqueue *rq = task_rq(t);
+	unsigned long diff = jiffies - t->sched_info.last_arrival;
+
+	t->sched_info.cpu_time += diff;
+
+	if (rq)
+		rq->info.cpu_time += diff;
+}
+
+/*
+ * Called when tasks are switched involuntarily due, typically, to expiring
+ * their time slice.  (This may also be called when switching to or from
+ * the idle task.)  We are only called when prev != next.
+ */
+static inline void sched_info_switch(task_t *prev, task_t *next)
+{
+	struct runqueue *rq = task_rq(prev);
+
+	/*
+	 * prev now departs the cpu.  It's not interesting to record
+	 * stats about how efficient we were at scheduling the idle
+	 * process, however.
+	 */
+	if (prev != rq->idle)
+		sched_info_depart(prev);
+
+	if (next != rq->idle)
+		sched_info_arrive(next);
+}
+#endif /* CONFIG_SCHEDSTATS */
+
 /*
  * Adding/removing a task to/from a priority array:
  */
@@ -292,6 +518,9 @@ static inline void dequeue_task(struct t
 
 static inline void enqueue_task(struct task_struct *p, prio_array_t *array)
 {
+#ifdef CONFIG_SCHEDSTATS
+	sched_info_queued(p);
+#endif
 	list_add_tail(&p->run_list, array->queue + p->prio);
 	__set_bit(p->prio, array->bitmap);
 	array->nr_active++;
@@ -732,6 +961,13 @@ unsigned long nr_iowait(void)
 	return sum;
 }
 
+#ifdef CONFIG_SCHEDSTATS
+void cpu_sched_info(struct sched_info *info, int cpu)
+{
+	memcpy(info, &cpu_rq(cpu)->info, sizeof(struct sched_info));
+}
+#endif /* CONFIG_SCHEDSTATS */
+
 /*
  * double_rq_lock - safely lock two runqueues
  *
@@ -986,6 +1222,14 @@ out:
  */
 static inline void pull_task(runqueue_t *src_rq, prio_array_t *src_array, task_t *p, runqueue_t *this_rq, int this_cpu)
 {
+#ifdef CONFIG_SCHEDSTATS
+	if (cpu_to_node(this_cpu) != cpu_to_node(src_rq->cpu)) {
+		schedstats[this_cpu].pt_node_gained++;
+		schedstats[src_rq->cpu].pt_node_lost++;
+	}
+	schedstats[this_cpu].pt_gained++;
+	schedstats[src_rq->cpu].pt_lost++;
+#endif
 	dequeue_task(p, src_array);
 	nr_running_dec(src_rq);
 	set_task_cpu(p, this_cpu);
@@ -1020,9 +1264,20 @@ static void load_balance(runqueue_t *thi
 	struct list_head *head, *curr;
 	task_t *tmp;
 
+#ifdef CONFIG_SCHEDSTATS
+	schedstats[this_cpu].lb_cnt++;
+#endif
 	busiest = find_busiest_queue(this_rq, this_cpu, idle, &imbalance, cpumask);
-	if (!busiest)
-		goto out;
+	if (!busiest) {
+#ifdef CONFIG_SCHEDSTATS
+		schedstats[this_cpu].lb_nobusy++;
+#endif
+  		goto out;
+	}
+  
+#ifdef CONFIG_SCHEDSTATS
+	schedstats[this_cpu].lb_imbalance += imbalance;
+#endif
 
 	/*
 	 * We first consider expired tasks. Those will likely not be
@@ -1110,8 +1365,14 @@ static void balance_node(runqueue_t *thi
 {
 	int node = find_busiest_node(cpu_to_node(this_cpu));
 
+#ifdef CONFIG_SCHEDSTATS
+	schedstats[this_cpu].bn_cnt++;
+#endif
 	if (node >= 0) {
 		cpumask_t cpumask = node_to_cpumask(node);
+#ifdef CONFIG_SCHEDSTATS
+		schedstats[this_cpu].lb_bnode++;
+#endif
 		cpu_set(this_cpu, cpumask);
 		spin_lock(&this_rq->lock);
 		load_balance(this_rq, idle, cpumask);
@@ -1122,9 +1383,7 @@ static void balance_node(runqueue_t *thi
 
 static void rebalance_tick(runqueue_t *this_rq, int idle)
 {
-#ifdef CONFIG_NUMA
 	int this_cpu = smp_processor_id();
-#endif
 	unsigned long j = jiffies;
 
 	/*
@@ -1137,11 +1396,17 @@ static void rebalance_tick(runqueue_t *t
 	 */
 	if (idle) {
 #ifdef CONFIG_NUMA
-		if (!(j % IDLE_NODE_REBALANCE_TICK))
+		if (!(j % IDLE_NODE_REBALANCE_TICK)) {
+#ifdef CONFIG_SCHEDSTATS
+			schedstats[this_cpu].bn_idle++;
+#endif
 			balance_node(this_rq, idle, this_cpu);
 #endif
 		if (!(j % IDLE_REBALANCE_TICK)) {
 			spin_lock(&this_rq->lock);
+#ifdef CONFIG_SCHEDSTATS
+			schedstats[this_cpu].lb_idle++;
+#endif
 			load_balance(this_rq, idle, cpu_to_node_mask(this_cpu));
 			spin_unlock(&this_rq->lock);
 		}
@@ -1153,6 +1418,9 @@ static void rebalance_tick(runqueue_t *t
 #endif
 	if (!(j % BUSY_REBALANCE_TICK)) {
 		spin_lock(&this_rq->lock);
+#ifdef CONFIG_SCHEDSTATS
+		schedstats[this_cpu].lb_busy++;
+#endif
 		load_balance(this_rq, idle, cpu_to_node_mask(this_cpu));
 		spin_unlock(&this_rq->lock);
 	}
@@ -1287,13 +1555,17 @@ asmlinkage void schedule(void)
 	runqueue_t *rq;
 	prio_array_t *array;
 	struct list_head *queue;
-	int idx;
+	int idx, this_cpu = smp_processor_id();
+
 
 	/*
 	 * Test if we are atomic.  Since do_exit() needs to call into
 	 * schedule() atomically, we ignore that path for now.
 	 * Otherwise, whine if we are scheduling when we should not be.
 	 */
+#ifdef CONFIG_SCHEDSTATS
+	schedstats[this_cpu].sched_cnt++;
+#endif
 	if (likely(!(current->state & (TASK_DEAD | TASK_ZOMBIE)))) {
 		if (unlikely(in_atomic())) {
 			printk(KERN_ERR "bad: scheduling while atomic!\n");
@@ -1333,6 +1605,9 @@ need_resched:
 pick_next_task:
 	if (unlikely(!rq->nr_running)) {
 #ifdef CONFIG_SMP
+#ifdef CONFIG_SCHEDSTATS
+		schedstats[this_cpu].lb_resched++;
+#endif
 		load_balance(rq, 1, cpu_to_node_mask(smp_processor_id()));
 		if (rq->nr_running)
 			goto pick_next_task;
@@ -1347,11 +1622,17 @@ pick_next_task:
 		/*
 		 * Switch the active and expired arrays.
 		 */
+#ifdef CONFIG_SCHEDSTATS
+		schedstats[this_cpu].sched_switch++;
+#endif
 		rq->active = rq->expired;
 		rq->expired = array;
 		array = rq->active;
 		rq->expired_timestamp = 0;
 	}
+#ifdef CONFIG_SCHEDSTATS
+	schedstats[this_cpu].sched_noswitch++;
+#endif
 
 	idx = sched_find_first_bit(array->bitmap);
 	queue = array->queue + idx;
@@ -1362,6 +1643,9 @@ switch_tasks:
 	clear_tsk_need_resched(prev);
 	RCU_qsctr(task_cpu(prev))++;
 
+#ifdef CONFIG_SCHEDSTATS
+	sched_info_switch(prev, next);
+#endif /* CONFIG_SCHEDSTATS */
 	if (likely(prev != next)) {
 		rq->nr_switches++;
 		rq->curr = next;
@@ -2011,6 +2295,9 @@ asmlinkage long sys_sched_yield(void)
 {
 	runqueue_t *rq = this_rq_lock();
 	prio_array_t *array = current->array;
+#ifdef CONFIG_SCHEDSTATS
+	int this_cpu = smp_processor_id();
+#endif /* CONFIG_SCHEDSTATS */
 
 	/*
 	 * We implement yielding by moving the task into the expired
@@ -2019,7 +2306,19 @@ asmlinkage long sys_sched_yield(void)
 	 * (special rule: RT tasks will just roundrobin in the active
 	 *  array.)
 	 */
+#ifdef CONFIG_SCHEDSTATS
+	schedstats[this_cpu].yld_cnt++;
+#endif
 	if (likely(!rt_task(current))) {
+#ifdef CONFIG_SCHEDSTATS
+		if (current->array->nr_active == 1) {
+		    schedstats[this_cpu].yld_act_empty++;
+		    if (!rq->expired->nr_active)
+			schedstats[this_cpu].yld_both_empty++;
+		} else if (!rq->expired->nr_active) {
+			schedstats[this_cpu].yld_exp_empty++;
+		}
+#endif
 		dequeue_task(current, array);
 		enqueue_task(current, rq->expired);
 	} else {
@@ -2524,6 +2823,9 @@ void __init sched_init(void)
 		rq = cpu_rq(i);
 		rq->active = rq->arrays;
 		rq->expired = rq->arrays + 1;
+#ifdef CONFIG_SCHEDSTATS
+		rq->cpu = i;
+#endif /* CONFIG_SCHEDSTATS */
 		spin_lock_init(&rq->lock);
 		INIT_LIST_HEAD(&rq->migration_queue);
 		atomic_set(&rq->nr_iowait, 0);
