Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265532AbSKFCZ6>; Tue, 5 Nov 2002 21:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265536AbSKFCZF>; Tue, 5 Nov 2002 21:25:05 -0500
Received: from holomorphy.com ([66.224.33.161]:63643 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265535AbSKFCYk>;
	Tue, 5 Nov 2002 21:24:40 -0500
To: linux-kernel@vger.kernel.org
Subject: [1/7] SMP iowait stats
Message-Id: <E189Fwj-0002YH-00@holomorphy>
From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 05 Nov 2002 18:29:33 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides qualitatively correct iowait time accounting on SMP
by using per-cpu counters. Detailed dumps of how the reports have been
improved by this patch can be found in prior postings.


 drivers/block/ll_rw_blk.c |   22 -------------------
 fs/proc/proc_misc.c       |    6 ++---
 include/linux/blkdev.h    |    5 ----
 include/linux/sched.h     |    3 ++
 kernel/sched.c            |   51 ++++++++++++++++++++++++++++++++++++++++++----
 5 files changed, 53 insertions(+), 34 deletions(-)

--- 25/drivers/block/ll_rw_blk.c~iowait-accounting-fix	Fri Nov  1 20:33:06 2002
+++ 25-akpm/drivers/block/ll_rw_blk.c	Fri Nov  1 20:33:06 2002
@@ -56,7 +56,6 @@ static int queue_nr_requests;
 static int batch_requests;
 
 unsigned long blk_max_low_pfn, blk_max_pfn;
-atomic_t nr_iowait_tasks = ATOMIC_INIT(0);
 int blk_nohighio = 0;
 
 static struct congestion_state {
@@ -115,27 +114,6 @@ static void set_queue_congested(request_
 		atomic_inc(&congestion_states[rw].nr_congested_queues);
 }
 
-/*
- * This task is about to go to sleep on IO.  Increment nr_iowait_tasks so
- * that process accounting knows that this is a task in IO wait state.
- *
- * But don't do that if it is a deliberate, throttling IO wait (this task
- * has set its backing_dev_info: the queue against which it should throttle)
- */
-void io_schedule(void)
-{
-	atomic_inc(&nr_iowait_tasks);
-	schedule();
-	atomic_dec(&nr_iowait_tasks);
-}
-
-void io_schedule_timeout(long timeout)
-{
-	atomic_inc(&nr_iowait_tasks);
-	schedule_timeout(timeout);
-	atomic_dec(&nr_iowait_tasks);
-}
-
 /**
  * blk_get_backing_dev_info - get the address of a queue's backing_dev_info
  * @dev:	device
--- 25/fs/proc/proc_misc.c~iowait-accounting-fix	Fri Nov  1 20:33:06 2002
+++ 25-akpm/fs/proc/proc_misc.c	Fri Nov  1 20:33:09 2002
@@ -372,7 +372,7 @@ static int kstat_read_proc(char *page, c
 			jiffies_to_clock_t(kstat_cpu(i).cpustat.nice),
 			jiffies_to_clock_t(kstat_cpu(i).cpustat.system),
 			jiffies_to_clock_t(kstat_cpu(i).cpustat.idle),
-			jiffies_to_clock_t(kstat_cpu(i).cpustat.idle));
+			jiffies_to_clock_t(kstat_cpu(i).cpustat.iowait));
 	}
 	len += sprintf(page + len, "intr %u", sum);
 
@@ -406,12 +406,12 @@ static int kstat_read_proc(char *page, c
 		"btime %lu\n"
 		"processes %lu\n"
 		"procs_running %lu\n"
-		"procs_blocked %u\n",
+		"procs_blocked %lu\n",
 		nr_context_switches(),
 		xtime.tv_sec - jif / HZ,
 		total_forks,
 		nr_running(),
-		atomic_read(&nr_iowait_tasks));
+		nr_iowait());
 
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
--- 25/include/linux/blkdev.h~iowait-accounting-fix	Fri Nov  1 20:33:06 2002
+++ 25-akpm/include/linux/blkdev.h	Fri Nov  1 20:33:06 2002
@@ -467,9 +467,4 @@ static inline void put_dev_sector(Sector
 #endif 
  
 
-
-extern atomic_t nr_iowait_tasks;
-void io_schedule(void);
-void io_schedule_timeout(long timeout);
-
 #endif
--- 25/include/linux/sched.h~iowait-accounting-fix	Fri Nov  1 20:33:06 2002
+++ 25-akpm/include/linux/sched.h	Fri Nov  1 20:33:06 2002
@@ -90,6 +90,7 @@ extern int nr_threads;
 extern int last_pid;
 extern unsigned long nr_running(void);
 extern unsigned long nr_uninterruptible(void);
+extern unsigned long nr_iowait(void);
 
 #include <linux/time.h>
 #include <linux/param.h>
@@ -149,6 +150,8 @@ extern void show_trace(unsigned long *st
 extern void show_stack(unsigned long *stack);
 extern void show_regs(struct pt_regs *);
 
+void io_schedule(void);
+void io_schedule_timeout(long timeout);
 
 extern void cpu_init (void);
 extern void trap_init(void);
--- 25/kernel/sched.c~iowait-accounting-fix	Fri Nov  1 20:33:06 2002
+++ 25-akpm/kernel/sched.c	Fri Nov  1 21:01:31 2002
@@ -157,6 +157,7 @@ struct runqueue {
 	task_t *migration_thread;
 	struct list_head migration_queue;
 
+	atomic_t nr_iowait;
 } ____cacheline_aligned;
 
 static struct runqueue runqueues[NR_CPUS] __cacheline_aligned;
@@ -557,9 +558,11 @@ unsigned long nr_uninterruptible(void)
 {
 	unsigned long i, sum = 0;
 
-	for (i = 0; i < NR_CPUS; i++)
+	for (i = 0; i < NR_CPUS; i++) {
+		if (!cpu_online(i))
+			continue;
 		sum += cpu_rq(i)->nr_uninterruptible;
-
+	}
 	return sum;
 }
 
@@ -567,9 +570,23 @@ unsigned long nr_context_switches(void)
 {
 	unsigned long i, sum = 0;
 
-	for (i = 0; i < NR_CPUS; i++)
+	for (i = 0; i < NR_CPUS; i++) {
+		if (!cpu_online(i))
+			continue;
 		sum += cpu_rq(i)->nr_switches;
+	}
+	return sum;
+}
+
+unsigned long nr_iowait(void)
+{
+	unsigned long i, sum = 0;
 
+	for (i = 0; i < NR_CPUS; ++i) {
+		if (!cpu_online(i))
+			continue;
+		sum += atomic_read(&cpu_rq(i)->nr_iowait);
+	}
 	return sum;
 }
 
@@ -875,7 +892,7 @@ void scheduler_tick(int user_ticks, int 
 		/* note: this timer irq context must be accounted for as well */
 		if (irq_count() - HARDIRQ_OFFSET >= SOFTIRQ_OFFSET)
 			kstat_cpu(cpu).cpustat.system += sys_ticks;
-		else if (atomic_read(&nr_iowait_tasks) > 0)
+		else if (atomic_read(&rq->nr_iowait) > 0)
 			kstat_cpu(cpu).cpustat.iowait += sys_ticks;
 		else
 			kstat_cpu(cpu).cpustat.idle += sys_ticks;
@@ -1712,6 +1729,31 @@ void yield(void)
 	sys_sched_yield();
 }
 
+/*
+ * This task is about to go to sleep on IO.  Increment rq->nr_iowait so
+ * that process accounting knows that this is a task in IO wait state.
+ *
+ * But don't do that if it is a deliberate, throttling IO wait (this task
+ * has set its backing_dev_info: the queue against which it should throttle)
+ */
+void io_schedule(void)
+{
+	struct runqueue *rq = this_rq();
+
+	atomic_inc(&rq->nr_iowait);
+	schedule();
+	atomic_dec(&rq->nr_iowait);
+}
+
+void io_schedule_timeout(long timeout)
+{
+	struct runqueue *rq = this_rq();
+
+	atomic_inc(&rq->nr_iowait);
+	schedule_timeout(timeout);
+	atomic_dec(&rq->nr_iowait);
+}
+
 /**
  * sys_sched_get_priority_max - return maximum RT priority.
  * @policy: scheduling class.
@@ -2160,6 +2202,7 @@ void __init sched_init(void)
 		rq->expired = rq->arrays + 1;
 		spin_lock_init(&rq->lock);
 		INIT_LIST_HEAD(&rq->migration_queue);
+		atomic_set(&rq->nr_iowait, 0);
 
 		for (j = 0; j < 2; j++) {
 			array = rq->arrays + j;

.
