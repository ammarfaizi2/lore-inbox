Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265869AbSKBDMz>; Fri, 1 Nov 2002 22:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265870AbSKBDMz>; Fri, 1 Nov 2002 22:12:55 -0500
Received: from holomorphy.com ([66.224.33.161]:24200 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265869AbSKBDMv>;
	Fri, 1 Nov 2002 22:12:51 -0500
Date: Fri, 1 Nov 2002 19:18:10 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: riel@surriel.com, akpm@zip.com.au, mingo@elte.hu, pbadari@us.ibm.com
Subject: idle time & iowait accounting
Message-ID: <20021102031810.GA12891@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, riel@surriel.com, akpm@zip.com.au,
	mingo@elte.hu, pbadari@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one caught me while watching kernel compiles for patches ppl
are actually hitting me up for:

Idle time accounting is disturbed by the iowait statistics, for several
reasons:

(1) iowait time is not subdivided among cpus.
	The only way the distinction between idle time subtracted from
	cpus (in order to be accounted as iowait) can be made is by
	summing counters for a total and dividing the individual tick
	counters by the proportions. Any tick type resolution which is
	not properly per-cpu breaks this, meaning that cpus which are
	entirely idle, when any iowait is present on the system, will
	have all idle ticks accounted to iowait instead of true idle time.

(2) kstat_read_proc() misreports iowait time
	The idle tick counter is passed twice to the sprintf(), once
	in the idle tick position, and once in the iowait tick position.

(3) performance enhancement
	The O(1) scheduler was very carefully constructed to perform
	accesses only to localized cachelines whenever possible. The
	global counter violates one of its core design principles,
	and the localization of "most" accesses is in greater harmony
	with its overall design and provides (at the very least) a
	qualitative performance improvement wrt. cache.

The method of correcting this is simple: embed an atomic iowait counter
in the runqueues, find the runqueue being manipulated in io_schedule(),
increment its atomic counter prior to schedule(), and decrement it
after returning from schedule(), which is guaranteed to be the same one,
as the counter incremented is tracked as a variable local to the procedure.
Then simply sum to obtain a global iowait statistic.

(Atomicity is required as the post-wait decrement may occur on a different
cpu from the one owning the counter.)

io_schedule() and io_schedule_timeout() are moved to sched.c as they must
access the runqueues, which are private to sched.c, and nr_iowait() is
created in order to export the sum of all runqueues' nr_iowait().


Before, while idle:
 01:33:45  up 30 min,  3 users,  load average: 0.63, 2.62, 1.41
92 processes: 91 sleeping, 1 running, 0 zombie, 0 stopped
CPU0 states:  0.0% user,  0.1% system,  0.0% nice, 49.9% iowait, 49.9% idle
CPU1 states:  0.0% user,  0.0% system,  0.0% nice, 50.0% iowait, 50.0% idle
CPU2 states:  0.0% user,  0.0% system,  0.0% nice, 50.0% iowait, 50.0% idle
CPU3 states:  0.0% user,  0.0% system,  0.0% nice, 50.0% iowait, 50.0% idle
CPU4 states:  0.0% user,  0.0% system,  0.0% nice, 50.0% iowait, 50.0% idle
CPU5 states:  0.1% user,  0.3% system,  0.0% nice, 49.8% iowait, 49.8% idle
CPU6 states:  0.0% user,  0.0% system,  0.0% nice, 50.0% iowait, 50.0% idle
CPU7 states:  0.0% user,  0.0% system,  0.0% nice, 50.0% iowait, 50.0% idle
CPU8 states:  0.0% user,  0.0% system,  0.0% nice, 50.0% iowait, 50.0% idle
CPU9 states:  0.0% user,  0.0% system,  0.0% nice, 50.0% iowait, 50.0% idle
CPU10 states:  0.0% user,  0.1% system,  0.0% nice, 49.9% iowait, 49.9% idle
CPU11 states:  0.0% user,  0.0% system,  0.0% nice, 50.0% iowait, 50.0% idle
CPU12 states:  0.0% user,  0.1% system,  0.0% nice, 49.9% iowait, 49.9% idle
CPU13 states:  0.0% user,  0.0% system,  0.0% nice, 50.0% iowait, 50.0% idle
CPU14 states:  0.0% user,  0.0% system,  0.0% nice, 50.0% iowait, 50.0% idle
CPU15 states:  0.0% user,  0.0% system,  0.0% nice, 50.0% iowait, 50.0% idle

This is clearly pathological reporting. Similar iowait == idle pathology
persists under load. When half-corrected by using the iowait tick counter
in /proc/, all cpus spend equal time in iowait, which is also qualitatively
incorrect/pathological.


After, while idle:
 02:15:48  up 0 min,  1 user,  load average: 0.17, 0.06, 0.02
89 processes: 88 sleeping, 1 running, 0 zombie, 0 stopped
CPU0 states:  0.0% user,  0.0% system,  0.0% nice,  0.0% iowait, 100.0% idle
CPU1 states:  0.0% user,  0.0% system,  0.0% nice,  0.0% iowait, 100.0% idle
CPU2 states:  0.0% user,  0.0% system,  0.0% nice,  0.0% iowait, 100.0% idle
CPU3 states:  0.0% user,  0.0% system,  0.0% nice,  0.0% iowait, 100.0% idle
CPU4 states:  0.0% user,  0.0% system,  0.0% nice,  0.0% iowait, 100.0% idle
CPU5 states:  0.0% user,  0.0% system,  0.0% nice,  0.0% iowait, 100.0% idle
CPU6 states:  0.0% user,  0.0% system,  0.0% nice,  0.0% iowait, 100.0% idle
CPU7 states:  0.0% user,  0.0% system,  0.0% nice,  0.0% iowait, 100.0% idle
CPU8 states:  0.0% user,  0.0% system,  0.0% nice,  0.0% iowait, 100.0% idle
CPU9 states:  0.0% user,  0.0% system,  0.0% nice,  0.0% iowait, 100.0% idle
CPU10 states:  0.0% user,  0.0% system,  0.0% nice,  0.0% iowait, 100.0% idle
CPU11 states:  0.0% user,  0.0% system,  0.0% nice,  0.0% iowait, 100.0% idle
CPU12 states:  0.0% user,  0.0% system,  0.0% nice,  0.0% iowait, 100.0% idle
CPU13 states:  1.0% user,  0.1% system,  0.0% nice,  0.0% iowait, 97.0% idle
CPU14 states:  0.0% user,  0.0% system,  0.0% nice,  0.0% iowait, 100.0% idle
CPU15 states:  0.0% user,  0.0% system,  0.0% nice,  0.0% iowait, 100.0% idle

This is correct. There is no activity (io or otherwise) on the system.


After, under load:
 02:17:00  up 2 min,  3 users,  load average: 5.48, 1.17, 0.38
419 processes: 385 sleeping, 34 running, 0 zombie, 0 stopped
CPU0 states: 32.4% user, 21.5% system,  0.0% nice, 18.2% iowait, 27.3% idle
CPU1 states: 31.6% user, 23.2% system,  0.0% nice, 16.2% iowait, 28.5% idle
CPU2 states: 30.0% user, 19.7% system,  0.0% nice, 17.2% iowait, 32.5% idle
CPU3 states: 32.6% user, 15.3% system,  0.0% nice, 15.2% iowait, 36.4% idle
CPU4 states: 26.0% user, 21.2% system,  0.0% nice, 12.4% iowait, 40.0% idle
CPU5 states: 28.3% user, 21.1% system,  0.0% nice, 15.2% iowait, 35.0% idle
CPU6 states: 25.0% user, 24.3% system,  0.0% nice, 15.7% iowait, 34.4% idle
CPU7 states: 27.1% user, 19.6% system,  0.0% nice, 16.5% iowait, 36.2% idle
CPU8 states: 26.4% user, 21.3% system,  0.0% nice, 12.6% iowait, 39.1% idle
CPU9 states: 30.5% user, 20.6% system,  0.0% nice, 23.1% iowait, 25.2% idle
CPU10 states: 26.5% user, 20.6% system,  0.0% nice, 18.1% iowait, 34.1% idle
CPU11 states: 26.3% user, 21.3% system,  0.0% nice, 17.0% iowait, 35.0% idle
CPU12 states: 29.0% user, 18.2% system,  0.0% nice, 18.2% iowait, 34.1% idle
CPU13 states: 25.6% user, 26.0% system,  0.0% nice, 11.7% iowait, 36.1% idle
CPU14 states: 26.5% user, 18.7% system,  0.0% nice, 19.7% iowait, 34.2% idle
CPU15 states: 26.1% user, 20.2% system,  0.0% nice, 12.3% iowait, 41.0% idle

This is qualitatively correct. Different cpus spend different
proportions of time stalled waiting on io owing to randomized pagecache
misses, and the iowait time is no longer uniformly identical to idle
time or uniformly identical across cpus. This is a kernel compile, so
10-25% cpu time spent waiting on random-access reads is faithful.

Acked by Rik.

cc:'d Badari as ISTR his reporting some anomalies wrt. idle time
reporting, Ingo because I'm touching sched.c (it maintains other
statistics, this one seems natural and clean to put here). This
fixes the anomalies I've seen wrt. iowait.


Bill

 drivers/block/ll_rw_blk.c |   22 ----------------------
 fs/proc/proc_misc.c       |    4 ++--
 include/linux/blkdev.h    |    5 -----
 include/linux/sched.h     |    3 +++
 kernel/sched.c            |   43 ++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 47 insertions(+), 30 deletions(-)


diff -urpN numaq-2.5.45/drivers/block/ll_rw_blk.c iowait-2.5.45/drivers/block/ll_rw_blk.c
--- numaq-2.5.45/drivers/block/ll_rw_blk.c	2002-11-01 00:53:40.000000000 -0800
+++ iowait-2.5.45/drivers/block/ll_rw_blk.c	2002-11-01 01:29:00.000000000 -0800
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
diff -urpN numaq-2.5.45/fs/proc/proc_misc.c iowait-2.5.45/fs/proc/proc_misc.c
--- numaq-2.5.45/fs/proc/proc_misc.c	2002-11-01 00:53:40.000000000 -0800
+++ iowait-2.5.45/fs/proc/proc_misc.c	2002-11-01 02:02:04.000000000 -0800
@@ -385,7 +385,7 @@ static int kstat_read_proc(char *page, c
 			jiffies_to_clock_t(kstat_cpu(i).cpustat.nice),
 			jiffies_to_clock_t(kstat_cpu(i).cpustat.system),
 			jiffies_to_clock_t(kstat_cpu(i).cpustat.idle),
-			jiffies_to_clock_t(kstat_cpu(i).cpustat.idle));
+			jiffies_to_clock_t(kstat_cpu(i).cpustat.iowait));
 	}
 	len += sprintf(page + len, "intr %u", sum);
 
@@ -424,7 +424,7 @@ static int kstat_read_proc(char *page, c
 		xtime.tv_sec - jif / HZ,
 		total_forks,
 		nr_running(),
-		atomic_read(&nr_iowait_tasks));
+		nr_iowait());
 
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
diff -urpN numaq-2.5.45/include/linux/blkdev.h iowait-2.5.45/include/linux/blkdev.h
--- numaq-2.5.45/include/linux/blkdev.h	2002-11-01 00:53:40.000000000 -0800
+++ iowait-2.5.45/include/linux/blkdev.h	2002-11-01 01:40:57.000000000 -0800
@@ -467,9 +467,4 @@ static inline void put_dev_sector(Sector
 #endif 
  
 
-
-extern atomic_t nr_iowait_tasks;
-void io_schedule(void);
-void io_schedule_timeout(long timeout);
-
 #endif
diff -urpN numaq-2.5.45/include/linux/sched.h iowait-2.5.45/include/linux/sched.h
--- numaq-2.5.45/include/linux/sched.h	2002-11-01 00:53:41.000000000 -0800
+++ iowait-2.5.45/include/linux/sched.h	2002-11-01 01:41:12.000000000 -0800
@@ -89,6 +89,7 @@ extern int nr_threads;
 extern int last_pid;
 extern unsigned long nr_running(void);
 extern unsigned long nr_uninterruptible(void);
+extern unsigned long nr_iowait(void);
 
 #include <linux/time.h>
 #include <linux/param.h>
@@ -161,6 +162,8 @@ extern unsigned long cache_decay_ticks;
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
 asmlinkage void schedule(void);
+void io_schedule(void);
+void io_schedule_timeout(long timeout);
 
 struct namespace;
 
diff -urpN numaq-2.5.45/kernel/sched.c iowait-2.5.45/kernel/sched.c
--- numaq-2.5.45/kernel/sched.c	2002-11-01 00:53:41.000000000 -0800
+++ iowait-2.5.45/kernel/sched.c	2002-11-01 01:36:14.000000000 -0800
@@ -157,6 +157,7 @@ struct runqueue {
 	task_t *migration_thread;
 	struct list_head migration_queue;
 
+	atomic_t nr_iowait;
 } ____cacheline_aligned;
 
 static struct runqueue runqueues[NR_CPUS] __cacheline_aligned;
@@ -573,6 +574,16 @@ unsigned long nr_context_switches(void)
 	return sum;
 }
 
+unsigned long nr_iowait(void)
+{
+	unsigned long i, sum = 0;
+
+	for (i = 0; i < NR_CPUS; ++i)
+		sum += atomic_read(&cpu_rq(i)->nr_iowait);
+
+	return sum;
+}
+
 /*
  * double_rq_lock - safely lock two runqueues
  *
@@ -875,7 +886,7 @@ void scheduler_tick(int user_ticks, int 
 		/* note: this timer irq context must be accounted for as well */
 		if (irq_count() - HARDIRQ_OFFSET >= SOFTIRQ_OFFSET)
 			kstat_cpu(cpu).cpustat.system += sys_ticks;
-		else if (atomic_read(&nr_iowait_tasks) > 0)
+		else if (atomic_read(&rq->nr_iowait) > 0)
 			kstat_cpu(cpu).cpustat.iowait += sys_ticks;
 		else
 			kstat_cpu(cpu).cpustat.idle += sys_ticks;
@@ -1712,6 +1723,35 @@ void yield(void)
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
+	struct runqueue *rq;
+	preempt_disable();
+	rq = this_rq();
+	atomic_inc(&rq->nr_iowait);
+	schedule();
+	atomic_dec(&rq->nr_iowait);
+	preempt_enable();
+}
+
+void io_schedule_timeout(long timeout)
+{
+	struct runqueue *rq;
+	preempt_disable();
+	rq = this_rq();
+	atomic_inc(&rq->nr_iowait);
+	schedule_timeout(timeout);
+	atomic_dec(&rq->nr_iowait);
+	preempt_enable();
+}
+
 /**
  * sys_sched_get_priority_max - return maximum RT priority.
  * @policy: scheduling class.
@@ -2160,6 +2200,7 @@ void __init sched_init(void)
 		rq->expired = rq->arrays + 1;
 		spin_lock_init(&rq->lock);
 		INIT_LIST_HEAD(&rq->migration_queue);
+		atomic_set(&rq->nr_iowait, 0);
 
 		for (j = 0; j < 2; j++) {
 			array = rq->arrays + j;
