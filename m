Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbUJ3P1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbUJ3P1S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 11:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbUJ3P0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 11:26:09 -0400
Received: from mail15.syd.optusnet.com.au ([211.29.132.196]:204 "EHLO
	mail15.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261207AbUJ3OkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 10:40:17 -0400
Message-ID: <4183A7BA.80701@kolivas.org>
Date: Sun, 31 Oct 2004 00:39:54 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Peter Williams <pwil3058@bigpond.net.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       Alexander Nyberg <alexn@dsv.su.se>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: [PATCH][plugsched 17/28] Make unique task_struct variables private
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig010F7BBEFEEA35AB930075C2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig010F7BBEFEEA35AB930075C2
Content-Type: multipart/mixed;
 boundary="------------080102070107050305050003"

This is a multi-part message in MIME format.
--------------080102070107050305050003
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Make unique task_struct variables private


--------------080102070107050305050003
Content-Type: text/x-patch;
 name="private_task_variables.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="private_task_variables.diff"

The task_struct needs to be flexible enough to have private entries unique
to each cpu scheduler design. Remove the variables that are likely to
differ between designs and put them in a separate per-scheduler struct
enclosed within a common union. 

Remove the private data from INIT_TASK and place it into sched_init().

Update all entries in sched.c to reflect the new task_struct design.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

Index: linux-2.6.10-rc1-mm2-plugsched1/include/linux/init_task.h
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/include/linux/init_task.h	2004-10-29 21:42:39.332506453 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/include/linux/init_task.h	2004-10-29 21:47:52.738595229 +1000
@@ -72,14 +72,10 @@ extern struct group_info init_groups;
 	.usage		= ATOMIC_INIT(2),				\
 	.flags		= 0,						\
 	.lock_depth	= -1,						\
-	.prio		= MAX_PRIO-20,					\
-	.static_prio	= MAX_PRIO-20,					\
 	.policy		= SCHED_NORMAL,					\
 	.cpus_allowed	= CPU_MASK_ALL,					\
 	.mm		= NULL,						\
 	.active_mm	= &init_mm,					\
-	.run_list	= LIST_HEAD_INIT(tsk.run_list),			\
-	.time_slice	= HZ,						\
 	.tasks		= LIST_HEAD_INIT(tsk.tasks),			\
 	.ptrace_children= LIST_HEAD_INIT(tsk.ptrace_children),		\
 	.ptrace_list	= LIST_HEAD_INIT(tsk.ptrace_list),		\
@@ -115,5 +111,4 @@ extern struct group_info init_groups;
 	.private_pages	= LIST_HEAD_INIT(tsk.private_pages),		\
 	.private_pages_count = 0,					\
 }
-
 #endif
Index: linux-2.6.10-rc1-mm2-plugsched1/include/linux/sched.h
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/include/linux/sched.h	2004-10-29 21:47:49.047171325 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/include/linux/sched.h	2004-10-29 21:47:52.739595073 +1000
@@ -524,18 +524,13 @@ struct task_struct {
 
 	int lock_depth;		/* Lock depth */
 
-	int prio, static_prio;
-	struct list_head run_list;
-	prio_array_t *array;
-
-	unsigned long sleep_avg;
-	long interactive_credit;
-	unsigned long long timestamp, last_ran;
-	int activated;
+	int static_prio;	/* A commonality between cpu schedulers */
+	union {
+		struct cpusched_ingo ingosched;
+	} u;
 
 	unsigned long policy;
 	cpumask_t cpus_allowed;
-	unsigned int time_slice, first_time_slice;
 
 #ifdef CONFIG_SCHEDSTATS
 	struct sched_info sched_info;
Index: linux-2.6.10-rc1-mm2-plugsched1/include/linux/scheduler.h
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/include/linux/scheduler.h	2004-10-29 21:47:49.048171169 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/include/linux/scheduler.h	2004-10-29 21:47:52.739595073 +1000
@@ -36,3 +36,16 @@ struct sched_drv
 	void (*cpu_attach_domain)(struct sched_domain *, int);
 #endif
 };
+
+struct cpusched_ingo {
+	int prio;
+	struct list_head run_list;
+	prio_array_t *array;
+	unsigned int time_slice;
+	unsigned int first_time_slice;
+	unsigned long sleep_avg;
+	long interactive_credit;
+	unsigned long timestamp;
+	unsigned long long last_ran;
+	int activated;
+};
Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/sched.c	2004-10-29 21:47:49.050170857 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c	2004-10-29 21:47:52.743594449 +1000
@@ -47,6 +47,7 @@
 #include <linux/sysctl.h>
 #include <linux/syscalls.h>
 #include <linux/times.h>
+#include <linux/list.h>
 #include <asm/tlb.h>
 
 #include <asm/unistd.h>
@@ -131,7 +132,7 @@
  */
 
 #define CURRENT_BONUS(p) \
-	(NS_TO_JIFFIES((p)->sleep_avg) * MAX_BONUS / \
+	(NS_TO_JIFFIES((p)->u.ingosched.sleep_avg) * MAX_BONUS / \
 		MAX_SLEEP_AVG)
 
 #ifdef CONFIG_SMP
@@ -150,20 +151,20 @@
 	(SCALE(TASK_NICE(p), 40, MAX_BONUS) + INTERACTIVE_DELTA)
 
 #define TASK_INTERACTIVE(p) \
-	((p)->prio <= (p)->static_prio - DELTA(p))
+	((p)->u.ingosched.prio <= (p)->static_prio - DELTA(p))
 
 #define INTERACTIVE_SLEEP(p) \
 	(JIFFIES_TO_NS(MAX_SLEEP_AVG * \
 		(MAX_BONUS / 2 + DELTA((p)) + 1) / MAX_BONUS - 1))
 
 #define HIGH_CREDIT(p) \
-	((p)->interactive_credit > CREDIT_LIMIT)
+	((p)->u.ingosched.interactive_credit > CREDIT_LIMIT)
 
 #define LOW_CREDIT(p) \
-	((p)->interactive_credit < -CREDIT_LIMIT)
+	((p)->u.ingosched.interactive_credit < -CREDIT_LIMIT)
 
 #define TASK_PREEMPTS_CURR(p, rq) \
-	((p)->prio < (rq)->curr->prio)
+	((p)->u.ingosched.prio < (rq)->curr->u.ingosched.prio)
 
 /*
  * task_timeslice() scales user-nice values [ -20 ... 0 ... 19 ]
@@ -184,7 +185,7 @@ static unsigned int task_timeslice(task_
 	else
 		return SCALE_PRIO(DEF_TIMESLICE, p->static_prio);
 }
-#define task_hot(p, now, sd) ((long long) ((now) - (p)->last_ran)	\
+#define task_hot(p, now, sd) ((long long) ((now) - (p)->u.ingosched.last_ran)	\
 				< (long long) (sd)->cache_hot_time)
 
 /*
@@ -294,7 +295,7 @@ static DEFINE_PER_CPU(struct runqueue, r
 
 static int ingo_rt_task(task_t *p)
 {
-	return (unlikely((p)->prio < MAX_RT_PRIO));
+	return (unlikely((p)->u.ingosched.prio < MAX_RT_PRIO));
 }
 
 /*
@@ -577,18 +578,18 @@ static inline void sched_info_switch(tas
 static void dequeue_task(struct task_struct *p, prio_array_t *array)
 {
 	array->nr_active--;
-	list_del(&p->run_list);
-	if (list_empty(array->queue + p->prio))
-		__clear_bit(p->prio, array->bitmap);
+	list_del(&p->u.ingosched.run_list);
+	if (list_empty(array->queue + p->u.ingosched.prio))
+		__clear_bit(p->u.ingosched.prio, array->bitmap);
 }
 
 static void enqueue_task(struct task_struct *p, prio_array_t *array)
 {
 	sched_info_queued(p);
-	list_add_tail(&p->run_list, array->queue + p->prio);
-	__set_bit(p->prio, array->bitmap);
+	list_add_tail(&p->u.ingosched.run_list, array->queue + p->u.ingosched.prio);
+	__set_bit(p->u.ingosched.prio, array->bitmap);
 	array->nr_active++;
-	p->array = array;
+	p->u.ingosched.array = array;
 }
 
 /*
@@ -598,15 +599,15 @@ static void enqueue_task(struct task_str
  */
 static inline void enqueue_task_head(struct task_struct *p, prio_array_t *array)
 {
-	list_add(&p->run_list, array->queue + p->prio);
-	__set_bit(p->prio, array->bitmap);
+	list_add(&p->u.ingosched.run_list, array->queue + p->u.ingosched.prio);
+	__set_bit(p->u.ingosched.prio, array->bitmap);
 	array->nr_active++;
-	p->array = array;
+	p->u.ingosched.array = array;
 }
 
 static void ingo_set_oom_timeslice(task_t *p)
 {
-	p->time_slice = HZ;
+	p->u.ingosched.time_slice = HZ;
 }
 
 /*
@@ -628,7 +629,7 @@ static int effective_prio(task_t *p)
 	int bonus, prio;
 
 	if (rt_task(p))
-		return p->prio;
+		return p->u.ingosched.prio;
 
 	bonus = CURRENT_BONUS(p) - MAX_BONUS / 2;
 
@@ -660,7 +661,7 @@ static inline void __activate_idle_task(
 
 static void recalc_task_prio(task_t *p, unsigned long long now)
 {
-	unsigned long long __sleep_time = now - p->timestamp;
+	unsigned long long __sleep_time = now - p->u.ingosched.timestamp;
 	unsigned long sleep_time;
 
 	if (__sleep_time > NS_MAX_SLEEP_AVG)
@@ -675,12 +676,12 @@ static void recalc_task_prio(task_t *p, 
 		 * prevent them suddenly becoming cpu hogs and starving
 		 * other processes.
 		 */
-		if (p->mm && p->activated != -1 &&
+		if (p->mm && p->u.ingosched.activated != -1 &&
 			sleep_time > INTERACTIVE_SLEEP(p)) {
-				p->sleep_avg = JIFFIES_TO_NS(MAX_SLEEP_AVG -
+				p->u.ingosched.sleep_avg = JIFFIES_TO_NS(MAX_SLEEP_AVG -
 						DEF_TIMESLICE);
 				if (!HIGH_CREDIT(p))
-					p->interactive_credit++;
+					p->u.ingosched.interactive_credit++;
 		} else {
 			/*
 			 * The lower the sleep avg a task has the more
@@ -701,12 +702,12 @@ static void recalc_task_prio(task_t *p, 
 			 * sleep are limited in their sleep_avg rise as they
 			 * are likely to be cpu hogs waiting on I/O
 			 */
-			if (p->activated == -1 && !HIGH_CREDIT(p) && p->mm) {
-				if (p->sleep_avg >= INTERACTIVE_SLEEP(p))
+			if (p->u.ingosched.activated == -1 && !HIGH_CREDIT(p) && p->mm) {
+				if (p->u.ingosched.sleep_avg >= INTERACTIVE_SLEEP(p))
 					sleep_time = 0;
-				else if (p->sleep_avg + sleep_time >=
+				else if (p->u.ingosched.sleep_avg + sleep_time >=
 						INTERACTIVE_SLEEP(p)) {
-					p->sleep_avg = INTERACTIVE_SLEEP(p);
+					p->u.ingosched.sleep_avg = INTERACTIVE_SLEEP(p);
 					sleep_time = 0;
 				}
 			}
@@ -715,21 +716,21 @@ static void recalc_task_prio(task_t *p, 
 			 * This code gives a bonus to interactive tasks.
 			 *
 			 * The boost works by updating the 'average sleep time'
-			 * value here, based on ->timestamp. The more time a
+			 * value here, based on ->u.ingosched.timestamp. The more time a
 			 * task spends sleeping, the higher the average gets -
 			 * and the higher the priority boost gets as well.
 			 */
-			p->sleep_avg += sleep_time;
+			p->u.ingosched.sleep_avg += sleep_time;
 
-			if (p->sleep_avg > NS_MAX_SLEEP_AVG) {
-				p->sleep_avg = NS_MAX_SLEEP_AVG;
+			if (p->u.ingosched.sleep_avg > NS_MAX_SLEEP_AVG) {
+				p->u.ingosched.sleep_avg = NS_MAX_SLEEP_AVG;
 				if (!HIGH_CREDIT(p))
-					p->interactive_credit++;
+					p->u.ingosched.interactive_credit++;
 			}
 		}
 	}
 
-	p->prio = effective_prio(p);
+	p->u.ingosched.prio = effective_prio(p);
 }
 
 /*
@@ -758,7 +759,7 @@ static void activate_task(task_t *p, run
 	 * This checks to make sure it's not an uninterruptible task
 	 * that is now waking up.
 	 */
-	if (!p->activated) {
+	if (!p->u.ingosched.activated) {
 		/*
 		 * Tasks which were woken up by interrupts (ie. hw events)
 		 * are most likely of interactive nature. So we give them
@@ -767,16 +768,16 @@ static void activate_task(task_t *p, run
 		 * on a CPU, first time around:
 		 */
 		if (in_interrupt())
-			p->activated = 2;
+			p->u.ingosched.activated = 2;
 		else {
 			/*
 			 * Normal first-time wakeups get a credit too for
 			 * on-runqueue time, but it will be weighted down:
 			 */
-			p->activated = 1;
+			p->u.ingosched.activated = 1;
 		}
 	}
-	p->timestamp = now;
+	p->u.ingosched.timestamp = now;
 
 	__activate_task(p, rq);
 }
@@ -789,8 +790,8 @@ static void deactivate_task(struct task_
 	rq->nr_running--;
 	if (p->state == TASK_UNINTERRUPTIBLE)
 		rq->nr_uninterruptible++;
-	dequeue_task(p, p->array);
-	p->array = NULL;
+	dequeue_task(p, p->u.ingosched.array);
+	p->u.ingosched.array = NULL;
 }
 
 /*
@@ -863,7 +864,7 @@ static int migrate_task(task_t *p, int d
 	 * If the task is not on a runqueue (and not running), then
 	 * it is sufficient to simply update the task's cpu field.
 	 */
-	if (!p->array && !task_running(rq, p)) {
+	if (!p->u.ingosched.array && !task_running(rq, p)) {
 		set_task_cpu(p, dest_cpu);
 		return 0;
 	}
@@ -894,7 +895,7 @@ static void ingo_wait_task_inactive(task
 repeat:
 	rq = task_rq_lock(p, &flags);
 	/* Must be off runqueue entirely, not preempted. */
-	if (unlikely(p->array)) {
+	if (unlikely(p->u.ingosched.array)) {
 		/* If it's preempted, we yield.  It could be a while. */
 		preempted = !task_running(rq, p);
 		task_rq_unlock(rq, &flags);
@@ -1003,7 +1004,7 @@ static int ingo_try_to_wake_up(task_t * 
 	if (!(old_state & state))
 		goto out;
 
-	if (p->array)
+	if (p->u.ingosched.array)
 		goto out_running;
 
 	cpu = task_cpu(p);
@@ -1082,7 +1083,7 @@ out_set_cpu:
 		old_state = p->state;
 		if (!(old_state & state))
 			goto out;
-		if (p->array)
+		if (p->u.ingosched.array)
 			goto out_running;
 
 		this_cpu = smp_processor_id();
@@ -1097,7 +1098,7 @@ out_activate:
 		 * Tasks on involuntary sleep don't earn
 		 * sleep_avg beyond just interactive state.
 		 */
-		p->activated = -1;
+		p->u.ingosched.activated = -1;
 	}
 
 	/*
@@ -1141,8 +1142,8 @@ static void ingo_sched_fork(task_t *p)
 	 * event cannot wake it up and insert it on the runqueue either.
 	 */
 	p->state = TASK_RUNNING;
-	INIT_LIST_HEAD(&p->run_list);
-	p->array = NULL;
+	INIT_LIST_HEAD(&p->u.ingosched.run_list);
+	p->u.ingosched.array = NULL;
 	spin_lock_init(&p->switch_lock);
 #ifdef CONFIG_SCHEDSTATS
 	memset(&p->sched_info, 0, sizeof(p->sched_info));
@@ -1162,21 +1163,21 @@ static void ingo_sched_fork(task_t *p)
 	 * resulting in more scheduling fairness.
 	 */
 	local_irq_disable();
-	p->time_slice = (current->time_slice + 1) >> 1;
+	p->u.ingosched.time_slice = (current->u.ingosched.time_slice + 1) >> 1;
 	/*
 	 * The remainder of the first timeslice might be recovered by
 	 * the parent if the child exits early enough.
 	 */
-	p->first_time_slice = 1;
-	current->time_slice >>= 1;
-	p->timestamp = sched_clock();
-	if (unlikely(!current->time_slice)) {
+	p->u.ingosched.first_time_slice = 1;
+	current->u.ingosched.time_slice >>= 1;
+	p->u.ingosched.timestamp = sched_clock();
+	if (unlikely(!current->u.ingosched.time_slice)) {
 		/*
 		 * This case is rare, it happens when the parent has only
 		 * a single jiffy left from its timeslice. Taking the
 		 * runqueue lock is not a problem.
 		 */
-		current->time_slice = 1;
+		current->u.ingosched.time_slice = 1;
 		preempt_disable();
 		scheduler_tick();
 		local_irq_enable();
@@ -1211,12 +1212,12 @@ static void ingo_wake_up_new_task(task_t
 	 * from forking tasks that are max-interactive. The parent
 	 * (current) is done further down, under its lock.
 	 */
-	p->sleep_avg = JIFFIES_TO_NS(CURRENT_BONUS(p) *
+	p->u.ingosched.sleep_avg = JIFFIES_TO_NS(CURRENT_BONUS(p) *
 		CHILD_PENALTY / 100 * MAX_SLEEP_AVG / MAX_BONUS);
 
-	p->interactive_credit = 0;
+	p->u.ingosched.interactive_credit = 0;
 
-	p->prio = effective_prio(p);
+	p->u.ingosched.prio = effective_prio(p);
 
 	if (likely(cpu == this_cpu)) {
 		if (!(clone_flags & CLONE_VM)) {
@@ -1225,13 +1226,13 @@ static void ingo_wake_up_new_task(task_t
 			 * do child-runs-first in anticipation of an exec. This
 			 * usually avoids a lot of COW overhead.
 			 */
-			if (unlikely(!current->array))
+			if (unlikely(!current->u.ingosched.array))
 				__activate_task(p, rq);
 			else {
-				p->prio = current->prio;
-				list_add_tail(&p->run_list, &current->run_list);
-				p->array = current->array;
-				p->array->nr_active++;
+				p->u.ingosched.prio = current->u.ingosched.prio;
+				list_add_tail(&p->u.ingosched.run_list, &current->u.ingosched.run_list);
+				p->u.ingosched.array = current->u.ingosched.array;
+				p->u.ingosched.array->nr_active++;
 				rq->nr_running++;
 			}
 			set_need_resched();
@@ -1252,7 +1253,7 @@ static void ingo_wake_up_new_task(task_t
 		 * Not the local CPU - must adjust timestamp. This should
 		 * get optimised away in the !CONFIG_SMP case.
 		 */
-		p->timestamp = (p->timestamp - this_rq->timestamp_last_tick)
+		p->u.ingosched.timestamp = (p->u.ingosched.timestamp - this_rq->timestamp_last_tick)
 					+ rq->timestamp_last_tick;
 		__activate_task(p, rq);
 		if (TASK_PREEMPTS_CURR(p, rq))
@@ -1261,12 +1262,12 @@ static void ingo_wake_up_new_task(task_t
 		schedstat_inc(rq, wunt_moved);
 		/*
 		 * Parent and child are on different CPUs, now get the
-		 * parent runqueue to update the parent's ->sleep_avg:
+		 * parent runqueue to update the parent's ->u.ingosched.sleep_avg:
 		 */
 		task_rq_unlock(rq, &flags);
 		this_rq = task_rq_lock(current, &flags);
 	}
-	current->sleep_avg = JIFFIES_TO_NS(CURRENT_BONUS(current) *
+	current->u.ingosched.sleep_avg = JIFFIES_TO_NS(CURRENT_BONUS(current) *
 		PARENT_PENALTY / 100 * MAX_SLEEP_AVG / MAX_BONUS);
 	task_rq_unlock(this_rq, &flags);
 }
@@ -1290,14 +1291,14 @@ static void ingo_sched_exit(task_t * p)
 	 * the sleep_avg of the parent as well.
 	 */
 	rq = task_rq_lock(p->parent, &flags);
-	if (p->first_time_slice) {
-		p->parent->time_slice += p->time_slice;
-		if (unlikely(p->parent->time_slice > task_timeslice(p)))
-			p->parent->time_slice = task_timeslice(p);
-	}
-	if (p->sleep_avg < p->parent->sleep_avg)
-		p->parent->sleep_avg = p->parent->sleep_avg /
-		(EXIT_WEIGHT + 1) * EXIT_WEIGHT + p->sleep_avg /
+	if (p->u.ingosched.first_time_slice) {
+		p->parent->u.ingosched.time_slice += p->u.ingosched.time_slice;
+		if (unlikely(p->parent->u.ingosched.time_slice > task_timeslice(p)))
+			p->parent->u.ingosched.time_slice = task_timeslice(p);
+	}
+	if (p->u.ingosched.sleep_avg < p->parent->u.ingosched.sleep_avg)
+		p->parent->u.ingosched.sleep_avg = p->parent->u.ingosched.sleep_avg /
+		(EXIT_WEIGHT + 1) * EXIT_WEIGHT + p->u.ingosched.sleep_avg /
 		(EXIT_WEIGHT + 1);
 	task_rq_unlock(rq, &flags);
 }
@@ -1607,7 +1608,7 @@ void pull_task(runqueue_t *src_rq, prio_
 	set_task_cpu(p, this_cpu);
 	this_rq->nr_running++;
 	enqueue_task(p, this_array);
-	p->timestamp = (p->timestamp - src_rq->timestamp_last_tick)
+	p->u.ingosched.timestamp = (p->u.ingosched.timestamp - src_rq->timestamp_last_tick)
 				+ this_rq->timestamp_last_tick;
 	/*
 	 * Note that idle threads have a prio of MAX_PRIO, for this test
@@ -1703,7 +1704,7 @@ skip_bitmap:
 	head = array->queue + idx;
 	curr = head->prev;
 skip_queue:
-	tmp = list_entry(curr, task_t, run_list);
+	tmp = list_entry(curr, task_t, u.ingosched.run_list);
 
 	curr = curr->prev;
 
@@ -2390,7 +2391,7 @@ static void ingo_scheduler_tick(void)
 	}
 
 	/* Task might have expired already, but not scheduled off yet */
-	if (p->array != rq->active) {
+	if (p->u.ingosched.array != rq->active) {
 		set_tsk_need_resched(p);
 		goto out;
 	}
@@ -2407,9 +2408,9 @@ static void ingo_scheduler_tick(void)
 		 * RR tasks need a special form of timeslice management.
 		 * FIFO tasks have no timeslices.
 		 */
-		if ((p->policy == SCHED_RR) && !--p->time_slice) {
-			p->time_slice = task_timeslice(p);
-			p->first_time_slice = 0;
+		if ((p->policy == SCHED_RR) && !--p->u.ingosched.time_slice) {
+			p->u.ingosched.time_slice = task_timeslice(p);
+			p->u.ingosched.first_time_slice = 0;
 			set_tsk_need_resched(p);
 
 			/* put it at the end of the queue: */
@@ -2418,12 +2419,12 @@ static void ingo_scheduler_tick(void)
 		}
 		goto out_unlock;
 	}
-	if (!--p->time_slice) {
+	if (!--p->u.ingosched.time_slice) {
 		dequeue_task(p, rq->active);
 		set_tsk_need_resched(p);
-		p->prio = effective_prio(p);
-		p->time_slice = task_timeslice(p);
-		p->first_time_slice = 0;
+		p->u.ingosched.prio = effective_prio(p);
+		p->u.ingosched.time_slice = task_timeslice(p);
+		p->u.ingosched.first_time_slice = 0;
 
 		if (!rq->expired_timestamp)
 			rq->expired_timestamp = jiffies;
@@ -2451,13 +2452,13 @@ static void ingo_scheduler_tick(void)
 		 * delta range with at least TIMESLICE_GRANULARITY to requeue.
 		 */
 		if (TASK_INTERACTIVE(p) && !((task_timeslice(p) -
-			p->time_slice) % TIMESLICE_GRANULARITY(p)) &&
-			(p->time_slice >= TIMESLICE_GRANULARITY(p)) &&
-			(p->array == rq->active)) {
+			p->u.ingosched.time_slice) % TIMESLICE_GRANULARITY(p)) &&
+			(p->u.ingosched.time_slice >= TIMESLICE_GRANULARITY(p)) &&
+			(p->u.ingosched.array == rq->active)) {
 
 			dequeue_task(p, rq->active);
 			set_tsk_need_resched(p);
-			p->prio = effective_prio(p);
+			p->u.ingosched.prio = effective_prio(p);
 			enqueue_task(p, rq->active);
 		}
 	}
@@ -2546,7 +2547,7 @@ static inline int dependent_sleeper(int 
 	BUG_ON(!array->nr_active);
 
 	p = list_entry(array->queue[sched_find_first_bit(array->bitmap)].next,
-		task_t, run_list);
+		task_t, u.ingosched.run_list);
 
 	for_each_cpu_mask(i, sibling_map) {
 		runqueue_t *smt_rq = cpu_rq(i);
@@ -2560,7 +2561,7 @@ static inline int dependent_sleeper(int 
 		 * task from using an unfair proportion of the
 		 * physical cpu's resources. -ck
 		 */
-		if (((smt_curr->time_slice * (100 - sd->per_cpu_gain) / 100) >
+		if (((smt_curr->u.ingosched.time_slice * (100 - sd->per_cpu_gain) / 100) >
 			task_timeslice(p) || rt_task(smt_curr)) &&
 			p->mm && smt_curr->mm && !rt_task(p))
 				ret = 1;
@@ -2570,7 +2571,7 @@ static inline int dependent_sleeper(int 
 		 * or wake it up if it has been put to sleep for priority
 		 * reasons.
 		 */
-		if ((((p->time_slice * (100 - sd->per_cpu_gain) / 100) >
+		if ((((p->u.ingosched.time_slice * (100 - sd->per_cpu_gain) / 100) >
 			task_timeslice(smt_curr) || rt_task(p)) &&
 			smt_curr->mm && p->mm && !rt_task(smt_curr)) ||
 			(smt_curr == smt_rq->idle && smt_rq->nr_running))
@@ -2639,8 +2640,8 @@ need_resched_nonpreemptible:
 
 	schedstat_inc(rq, sched_cnt);
 	now = sched_clock();
-	if (likely(now - prev->timestamp < NS_MAX_SLEEP_AVG))
-		run_time = now - prev->timestamp;
+	if (likely(now - prev->u.ingosched.timestamp < NS_MAX_SLEEP_AVG))
+		run_time = now - prev->u.ingosched.timestamp;
 	else
 		run_time = NS_MAX_SLEEP_AVG;
 
@@ -2716,20 +2717,20 @@ go_idle:
 
 	idx = sched_find_first_bit(array->bitmap);
 	queue = array->queue + idx;
-	next = list_entry(queue->next, task_t, run_list);
+	next = list_entry(queue->next, task_t, u.ingosched.run_list);
 
-	if (!rt_task(next) && next->activated > 0) {
-		unsigned long long delta = now - next->timestamp;
+	if (!rt_task(next) && next->u.ingosched.activated > 0) {
+		unsigned long long delta = now - next->u.ingosched.timestamp;
 
-		if (next->activated == 1)
+		if (next->u.ingosched.activated == 1)
 			delta = delta * (ON_RUNQUEUE_WEIGHT * 128 / 100) / 128;
 
-		array = next->array;
+		array = next->u.ingosched.array;
 		dequeue_task(next, array);
-		recalc_task_prio(next, next->timestamp + delta);
+		recalc_task_prio(next, next->u.ingosched.timestamp + delta);
 		enqueue_task(next, array);
 	}
-	next->activated = 0;
+	next->u.ingosched.activated = 0;
 switch_tasks:
 	if (next == rq->idle)
 		schedstat_inc(rq, sched_goidle);
@@ -2737,17 +2738,17 @@ switch_tasks:
 	clear_tsk_need_resched(prev);
 	rcu_qsctr_inc(task_cpu(prev));
 
-	prev->sleep_avg -= run_time;
-	if ((long)prev->sleep_avg <= 0) {
-		prev->sleep_avg = 0;
+	prev->u.ingosched.sleep_avg -= run_time;
+	if ((long)prev->u.ingosched.sleep_avg <= 0) {
+		prev->u.ingosched.sleep_avg = 0;
 		if (!(HIGH_CREDIT(prev) || LOW_CREDIT(prev)))
-			prev->interactive_credit--;
+			prev->u.ingosched.interactive_credit--;
 	}
-	prev->timestamp = prev->last_ran = now;
+	prev->u.ingosched.timestamp = prev->u.ingosched.last_ran = now;
 
 	sched_info_switch(prev, next);
 	if (likely(prev != next)) {
-		next->timestamp = now;
+		next->u.ingosched.timestamp = now;
 		rq->nr_switches++;
 		rq->curr = next;
 		++*switch_count;
@@ -2814,15 +2815,15 @@ static void ingo_set_user_nice(task_t *p
 		p->static_prio = NICE_TO_PRIO(nice);
 		goto out_unlock;
 	}
-	array = p->array;
+	array = p->u.ingosched.array;
 	if (array)
 		dequeue_task(p, array);
 
-	old_prio = p->prio;
+	old_prio = p->u.ingosched.prio;
 	new_prio = NICE_TO_PRIO(nice);
 	delta = new_prio - old_prio;
 	p->static_prio = NICE_TO_PRIO(nice);
-	p->prio += delta;
+	p->u.ingosched.prio += delta;
 
 	if (array) {
 		enqueue_task(p, array);
@@ -2854,7 +2855,7 @@ struct task_struct *kgdb_get_idle(int th
  */
 static int ingo_task_prio(const task_t *p)
 {
-	return p->prio - MAX_RT_PRIO;
+	return p->u.ingosched.prio - MAX_RT_PRIO;
 }
 
 /**
@@ -2887,13 +2888,13 @@ static inline task_t *find_process_by_pi
 /* Actually do priority change: must hold rq lock. */
 static void __setscheduler(struct task_struct *p, int policy, int prio)
 {
-	BUG_ON(p->array);
+	BUG_ON(p->u.ingosched.array);
 	p->policy = policy;
 	p->rt_priority = prio;
 	if (policy != SCHED_NORMAL)
-		p->prio = MAX_USER_RT_PRIO-1 - p->rt_priority;
+		p->u.ingosched.prio = MAX_USER_RT_PRIO-1 - p->rt_priority;
 	else
-		p->prio = p->static_prio;
+		p->u.ingosched.prio = p->static_prio;
 }
 
 /*
@@ -2968,11 +2969,11 @@ recheck:
 		task_rq_unlock(rq, &flags);
 		goto recheck;
 	}
-	array = p->array;
+	array = p->u.ingosched.array;
 	if (array)
 		deactivate_task(p, task_rq(p));
 	retval = 0;
-	oldprio = p->prio;
+	oldprio = p->u.ingosched.prio;
 	__setscheduler(p, policy, lp.sched_priority);
 	if (array) {
 		__activate_task(p, task_rq(p));
@@ -2982,7 +2983,7 @@ recheck:
 		 * this runqueue and our priority is higher than the current's
 		 */
 		if (task_running(rq, p)) {
-			if (p->prio > oldprio)
+			if (p->u.ingosched.prio > oldprio)
 				resched_task(rq->curr);
 		} else if (TASK_PREEMPTS_CURR(p, rq))
 			resched_task(rq->curr);
@@ -3004,7 +3005,7 @@ out_nounlock:
 static long ingo_sys_sched_yield(void)
 {
 	runqueue_t *rq = this_rq_lock();
-	prio_array_t *array = current->array;
+	prio_array_t *array = current->u.ingosched.array;
 	prio_array_t *target = rq->expired;
 
 	schedstat_inc(rq, yld_cnt);
@@ -3018,7 +3019,7 @@ static long ingo_sys_sched_yield(void)
 	if (rt_task(current))
 		target = rq->active;
 
-	if (current->array->nr_active == 1) {
+	if (current->u.ingosched.array->nr_active == 1) {
 		schedstat_inc(rq, yld_act_empty);
 		if (!rq->expired->nr_active)
 			schedstat_inc(rq, yld_both_empty);
@@ -3111,10 +3112,10 @@ static void __devinit ingo_init_idle(tas
 	runqueue_t *rq = cpu_rq(cpu);
 	unsigned long flags;
 
-	idle->sleep_avg = 0;
-	idle->interactive_credit = 0;
-	idle->array = NULL;
-	idle->prio = MAX_PRIO;
+	idle->u.ingosched.sleep_avg = 0;
+	idle->u.ingosched.interactive_credit = 0;
+	idle->u.ingosched.array = NULL;
+	idle->u.ingosched.prio = MAX_PRIO;
 	idle->state = TASK_RUNNING;
 	set_task_cpu(idle, cpu);
 
@@ -3218,15 +3219,16 @@ static void __migrate_task(struct task_s
 		goto out;
 
 	set_task_cpu(p, dest_cpu);
-	if (p->array) {
+	if (p->u.ingosched.array) {
 		/*
 		 * Sync timestamp with rq_dest's before activating.
 		 * The same thing could be achieved by doing this step
 		 * afterwards, and pretending it was a local activate.
 		 * This way is cleaner and logically correct.
 		 */
-		p->timestamp = p->timestamp - rq_src->timestamp_last_tick
-				+ rq_dest->timestamp_last_tick;
+		p->u.ingosched.timestamp = p->u.ingosched.timestamp -
+			rq_src->timestamp_last_tick +
+			rq_dest->timestamp_last_tick;
 		deactivate_task(p, rq_src);
 		activate_task(p, rq_dest, 0);
 		if (TASK_PREEMPTS_CURR(p, rq_dest))
@@ -3424,7 +3426,7 @@ static void migrate_dead_tasks(unsigned 
 			while (!list_empty(list))
 				migrate_dead(dead_cpu,
 					     list_entry(list->next, task_t,
-							run_list));
+							u.ingosched.run_list));
 		}
 	}
 }
@@ -3961,6 +3963,11 @@ static void __init ingo_sched_init(void)
 	runqueue_t *rq;
 	int i, j, k;
 
+	init_task.u.ingosched.prio = MAX_PRIO - 20;
+	init_task.static_prio = MAX_PRIO - 20;
+	INIT_LIST_HEAD(&init_task.u.ingosched.run_list);
+	init_task.u.ingosched.time_slice = HZ;
+
 	for (i = 0; i < NR_CPUS; i++) {
 		prio_array_t *array;
 


--------------080102070107050305050003--

--------------enig010F7BBEFEEA35AB930075C2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBg6e6ZUg7+tp6mRURAiw+AJ4p3sqrXj+GS0GNdYOnI4AzqxLLrQCeIxlc
Zey6WV2HQvskzVe1cBmuPUw=
=4bg3
-----END PGP SIGNATURE-----

--------------enig010F7BBEFEEA35AB930075C2--
