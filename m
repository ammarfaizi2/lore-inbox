Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287756AbSAFHDO>; Sun, 6 Jan 2002 02:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287754AbSAFHDF>; Sun, 6 Jan 2002 02:03:05 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:49673 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S287756AbSAFHCw>; Sun, 6 Jan 2002 02:02:52 -0500
Date: Sat, 5 Jan 2002 23:07:41 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Ingo Molnar <mingo@elte.hu>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] mqo1 changes (2) ...
Message-ID: <Pine.LNX.4.40.0201052304400.945-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A piece was missing, the swap count must be updated when the task leaves
the run queue.



- Davide



include/linux/sched.h |    6 --
kernel/fork.c         |    1
kernel/ksyms.c        |    2
kernel/sched.c        |  125 ++++++++------------------------------------------
4 files changed, 24 insertions, 110 deletions




diff -Nru linux-2.5.2-pre9.ingo/include/linux/sched.h linux-2.5.2-pre9.mqo1/include/linux/sched.h
--- linux-2.5.2-pre9.ingo/include/linux/sched.h	Sat Jan  5 22:34:11 2002
+++ linux-2.5.2-pre9.mqo1/include/linux/sched.h	Sat Jan  5 21:33:23 2002
@@ -306,10 +306,7 @@

 	unsigned int time_slice;
 	unsigned long sleep_timestamp, run_timestamp;
-
-	#define SLEEP_HIST_SIZE 4
-	int sleep_hist[SLEEP_HIST_SIZE];
-	int sleep_idx;
+	unsigned long swap_cnt_last;

 	unsigned long policy;
 	unsigned long cpus_allowed;
@@ -522,6 +519,7 @@
     active_mm:		&init_mm,					\
     run_list:		LIST_HEAD_INIT(tsk.run_list),			\
     time_slice:		PRIO_TO_TIMESLICE(DEF_PRIO),			\
+	swap_cnt_last:	0,							\
     next_task:		&tsk,						\
     prev_task:		&tsk,						\
     p_opptr:		&tsk,						\
diff -Nru linux-2.5.2-pre9.ingo/kernel/fork.c linux-2.5.2-pre9.mqo1/kernel/fork.c
--- linux-2.5.2-pre9.ingo/kernel/fork.c	Sat Jan  5 22:34:10 2002
+++ linux-2.5.2-pre9.mqo1/kernel/fork.c	Sat Jan  5 21:16:20 2002
@@ -708,7 +708,6 @@
 		expire_task(current);
 	}
 	p->sleep_timestamp = p->run_timestamp = jiffies;
-	p->sleep_hist[p->sleep_idx] = 0;
 	__restore_flags(flags);

 	/*
diff -Nru linux-2.5.2-pre9.ingo/kernel/ksyms.c linux-2.5.2-pre9.mqo1/kernel/ksyms.c
--- linux-2.5.2-pre9.ingo/kernel/ksyms.c	Sat Jan  5 22:34:11 2002
+++ linux-2.5.2-pre9.mqo1/kernel/ksyms.c	Sat Jan  5 21:19:14 2002
@@ -441,7 +441,7 @@
 EXPORT_SYMBOL(interruptible_sleep_on_timeout);
 EXPORT_SYMBOL(schedule);
 EXPORT_SYMBOL(schedule_timeout);
-EXPORT_SYMBOL(sys_sched_yield)
+EXPORT_SYMBOL(sys_sched_yield);
 EXPORT_SYMBOL(jiffies);
 EXPORT_SYMBOL(xtime);
 EXPORT_SYMBOL(do_gettimeofday);
diff -Nru linux-2.5.2-pre9.ingo/kernel/sched.c linux-2.5.2-pre9.mqo1/kernel/sched.c
--- linux-2.5.2-pre9.ingo/kernel/sched.c	Sat Jan  5 22:34:10 2002
+++ linux-2.5.2-pre9.mqo1/kernel/sched.c	Sat Jan  5 23:02:25 2002
@@ -45,6 +45,8 @@
 	unsigned long nr_running, nr_switches;
 	task_t *curr, *idle;
 	prio_array_t *active, *expired, arrays[2];
+	unsigned long swap_cnt;
+	unsigned long rt_checkp;
 	char __pad [SMP_CACHE_BYTES];
 } runqueues [NR_CPUS] __cacheline_aligned;

@@ -71,6 +73,7 @@
  */
 static spinlock_t rt_lock = SPIN_LOCK_UNLOCKED;
 static prio_array_t rt_array;
+static unsigned long rt_status = 0;

 #define rt_task(p)		((p)->policy != SCHED_OTHER)

@@ -83,6 +86,7 @@
 	list_del_init(&p->run_list);
 	if (list_empty(array->queue + p->prio))
 		__set_bit(p->prio, array->bitmap);
+	p->swap_cnt_last = task_rq(p)->swap_cnt;
 }

 static inline void enqueue_task(struct task_struct *p, prio_array_t *array)
@@ -93,105 +97,21 @@
 	p->array = array;
 }

-/*
- * This is the per-process load estimator. Processes that generate
- * more load than the system can handle get a priority penalty.
- *
- * The estimator uses a 4-entry load-history ringbuffer which is
- * updated whenever a task is moved to/from the runqueue. The load
- * estimate is also updated from the timer tick to get an accurate
- * estimation of currently executing tasks as well.
- */
-#define NEXT_IDX(idx) (((idx) + 1) % SLEEP_HIST_SIZE)
-
-static inline void update_sleep_avg_deactivate(task_t *p)
-{
-	unsigned int idx;
-	unsigned long j = jiffies, last_sample = p->run_timestamp / HZ,
-		curr_sample = j / HZ, delta = curr_sample - last_sample;
-
-	if (delta) {
-		if (delta < SLEEP_HIST_SIZE) {
-			for (idx = 0; idx < delta; idx++) {
-				p->sleep_idx++;
-				p->sleep_idx %= SLEEP_HIST_SIZE;
-				p->sleep_hist[p->sleep_idx] = 0;
-			}
-		} else {
-			for (idx = 0; idx < SLEEP_HIST_SIZE; idx++)
-				p->sleep_hist[idx] = 0;
-			p->sleep_idx = 0;
-		}
-	}
-	p->sleep_timestamp = j;
-}
-
-static inline unsigned int update_sleep_avg_activate(task_t *p)
-{
-	unsigned int idx;
-	unsigned long j = jiffies, last_sample = p->sleep_timestamp / HZ,
-		curr_sample = j / HZ, delta = curr_sample - last_sample,
-		delta_ticks, sum = 0;
-
-	if (delta) {
-		if (delta < SLEEP_HIST_SIZE) {
-			p->sleep_hist[p->sleep_idx] += HZ - (p->sleep_timestamp % HZ);
-			p->sleep_idx++;
-			p->sleep_idx %= SLEEP_HIST_SIZE;
-
-			for (idx = 1; idx < delta; idx++) {
-				p->sleep_idx++;
-				p->sleep_idx %= SLEEP_HIST_SIZE;
-				p->sleep_hist[p->sleep_idx] = HZ;
-			}
-		} else {
-			for (idx = 0; idx < SLEEP_HIST_SIZE; idx++)
-				p->sleep_hist[idx] = HZ;
-			p->sleep_idx = 0;
-		}
-		p->sleep_hist[p->sleep_idx] = 0;
-		delta_ticks = j % HZ;
-	} else
-		delta_ticks = j - p->sleep_timestamp;
-	p->sleep_hist[p->sleep_idx] += delta_ticks;
-	p->run_timestamp = j;
-
-	for (idx = 0; idx < SLEEP_HIST_SIZE; idx++)
-		sum += p->sleep_hist[idx];
-
-	return sum * HZ / ((SLEEP_HIST_SIZE-1)*HZ + (j % HZ));
-}
-
 static inline void activate_task(task_t *p, runqueue_t *rq)
 {
 	prio_array_t *array = rq->active;
-	unsigned int sleep, load;
-	int penalty;

-	if (p->run_timestamp == jiffies)
-		goto enqueue;
-	/*
-	 * Give the process a priority penalty if it has not slept often
-	 * enough in the past. We scale the priority penalty according
-	 * to the current load of the runqueue, and the 'load history'
-	 * this process has. Eg. if the CPU has 3 processes running
-	 * right now then a process that has slept more than two-thirds
-	 * of the time is considered to be 'interactive'. The higher
-	 * the load of the CPUs is, the easier it is for a process to
-	 * get an non-interactivity penalty.
-	 */
-#define MAX_BOOST (MAX_PRIO/3)
-	sleep = update_sleep_avg_activate(p);
-	load = HZ - sleep;
-	penalty = (MAX_BOOST * load)/HZ;
-	if (penalty) {
-		p->prio = NICE_TO_PRIO(p->__nice) + penalty;
-		if (p->prio < 0)
+	if (!rt_task(p)) {
+		unsigned long prio_bonus = rq->swap_cnt - p->swap_cnt_last;
+		p->swap_cnt_last = rq->swap_cnt;
+		if (prio_bonus < MAX_PRIO) {
+			p->prio -= prio_bonus;
+			if (p->prio < 0)
+				p->prio = 0;
+		} else
 			p->prio = 0;
-		if (p->prio > MAX_PRIO-1)
-			p->prio = MAX_PRIO-1;
-	}
-enqueue:
+	} else
+		++rt_status;
 	enqueue_task(p, array);
 	rq->nr_running++;
 }
@@ -201,7 +121,6 @@
 	rq->nr_running--;
 	dequeue_task(p, p->array);
 	p->array = NULL;
-	update_sleep_avg_deactivate(p);
 }

 static inline void resched_task(task_t *p)
@@ -550,14 +469,9 @@
 		 * priority penalty:
 		 */
 		dequeue_task(p, rq->active);
+		if (++p->prio >= MAX_PRIO)
+			p->prio = MAX_PRIO - 1;
 		enqueue_task(p, rq->expired);
-	} else {
-		/*
-		 * Deactivate + activate the task so that the
-		 * load estimator gets updated properly:
-		 */
-		deactivate_task(p, rq);
-		activate_task(p, rq);
 	}
 	load_balance(rq);
 	spin_unlock_irqrestore(&rq->lock, flags);
@@ -670,6 +584,7 @@
 	return 1;

 out_unlock_pick_other:
+	rq->rt_checkp = rt_status;
 	unlock_rt();
 	return 0;
 }
@@ -687,13 +602,13 @@

 need_resched_back:
 	prev = current;
+	rq = this_rq();
 	release_kernel_lock(prev, cpu());

-	if (unlikely(rt_array.nr_active))
+	if (unlikely(rt_array.nr_active && rq->rt_checkp != rt_status))
 		if (rt_schedule())
 			goto out_return;

-	rq = this_rq();
 	spin_lock_irq(&rq->lock);

 	switch (prev->state) {
@@ -724,6 +639,7 @@
 			/*
 			 * Switch the active and expired arrays.
 			 */
+			rq->swap_cnt++;
 			rq->active = rq->expired;
 			rq->expired = array;
 			array = rq->active;
@@ -1395,6 +1311,7 @@

 		rq->active = rq->arrays + 0;
 		rq->expired = rq->arrays + 1;
+		rq->swap_cnt = 0;
 		spin_lock_init(&rq->lock);
 		rq->cpu = i;



