Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030362AbWEZEUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030362AbWEZEUz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 00:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030376AbWEZEUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 00:20:55 -0400
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:47514 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1030341AbWEZEUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 00:20:44 -0400
From: Peter Williams <pwil3058@bigpond.net.au>
To: Mike Galbraith <efault@gmx.de>
Cc: Con Kolivas <kernel@kolivas.org>, Peter Williams <pwil3058@bigpond.net.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
Date: Fri, 26 May 2006 14:20:41 +1000
Message-Id: <20060526042041.2886.69840.sendpatchset@heathwren.pw.nest>
In-Reply-To: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>
Subject: [RFC 2/5] sched: Add CPU rate soft caps
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements (soft) CPU rate caps per task as a proportion of a
single CPU's capacity expressed in parts per thousand.  The CPU usage
of capped tasks is determined by using Kalman filters to calculate the
(recent) average lengths of the task's scheduling cycle and the time
spent on the CPU each cycle and taking the ratio of the latter to the
former.  To minimize overhead associated with uncapped tasks these
statistics are not kept for them.

Notes:

1. To minimize the overhead incurred when testing to skip caps processing for
uncapped tasks a new flag PF_HAS_CAP has been added to flags.

2. The implementation involves the addition of two priority slots to the
run queue priority arrays and this means that MAX_PRIO no longer
represents the scheduling priority of the idle process and can't be used to
test whether priority values are in the valid range.  To alleviate this
problem a new function sched_idle_prio() has been provided.

3. Enforcement of caps is not as strict as it could be in order to
reduce the possibility of a task being starved of CPU while holding
an important system resource with resultant overall performance
degradation.  In effect, all runnable capped tasks will get some amount
of CPU access every active/expired swap cycle.  This will be most
apparent for small or zero soft caps.

Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>

 include/linux/sched.h  |   16 ++
 init/Kconfig           |    2 
 kernel/Kconfig.caps    |   13 +
 kernel/rtmutex-debug.c |    4 
 kernel/sched.c         |  362 ++++++++++++++++++++++++++++++++++++++++++++++---
 5 files changed, 375 insertions(+), 22 deletions(-)

Index: MM-2.6.17-rc4-mm3/include/linux/sched.h
===================================================================
--- MM-2.6.17-rc4-mm3.orig/include/linux/sched.h	2006-05-26 10:43:21.000000000 +1000
+++ MM-2.6.17-rc4-mm3/include/linux/sched.h	2006-05-26 10:46:35.000000000 +1000
@@ -494,6 +494,12 @@ struct signal_struct {
 #define has_rt_policy(p) \
 	unlikely((p)->policy != SCHED_NORMAL && (p)->policy != SCHED_BATCH)
 
+#ifdef CONFIG_CPU_RATE_CAPS
+int sched_idle_prio(void);
+#else
+#define sched_idle_prio()	MAX_PRIO
+#endif
+
 /*
  * Some day this will be a full-fledged user tracking system..
  */
@@ -787,6 +793,10 @@ struct task_struct {
 	unsigned long sleep_avg;
 	unsigned long long timestamp, last_ran;
 	unsigned long long sched_time; /* sched_clock time spent running */
+#ifdef CONFIG_CPU_RATE_CAPS
+	unsigned long long avg_cpu_per_cycle, avg_cycle_length;
+	unsigned int cpu_rate_cap;
+#endif
 	enum sleep_type sleep_type;
 
 	unsigned long policy;
@@ -981,6 +991,11 @@ struct task_struct {
 #endif
 };
 
+#ifdef CONFIG_CPU_RATE_CAPS
+unsigned int get_cpu_rate_cap(const struct task_struct *);
+int set_cpu_rate_cap(struct task_struct *, unsigned int);
+#endif
+
 static inline pid_t process_group(struct task_struct *tsk)
 {
 	return tsk->signal->pgrp;
@@ -1040,6 +1055,7 @@ static inline void put_task_struct(struc
 #define PF_SPREAD_SLAB	0x08000000	/* Spread some slab caches over cpuset */
 #define PF_MEMPOLICY	0x10000000	/* Non-default NUMA mempolicy */
 #define PF_MUTEX_TESTER	0x02000000	/* Thread belongs to the rt mutex tester */
+#define PF_HAS_CAP	0x20000000	/* Has a CPU rate cap */
 
 /*
  * Only the _current_ task can read/write to tsk->flags, but other
Index: MM-2.6.17-rc4-mm3/init/Kconfig
===================================================================
--- MM-2.6.17-rc4-mm3.orig/init/Kconfig	2006-05-26 10:39:59.000000000 +1000
+++ MM-2.6.17-rc4-mm3/init/Kconfig	2006-05-26 10:45:26.000000000 +1000
@@ -286,6 +286,8 @@ config RELAY
 
 	  If unsure, say N.
 
+source "kernel/Kconfig.caps"
+
 source "usr/Kconfig"
 
 config UID16
Index: MM-2.6.17-rc4-mm3/kernel/Kconfig.caps
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ MM-2.6.17-rc4-mm3/kernel/Kconfig.caps	2006-05-26 10:45:26.000000000 +1000
@@ -0,0 +1,13 @@
+#
+# CPU Rate Caps Configuration
+#
+
+config CPU_RATE_CAPS
+	bool "Support (soft) CPU rate caps"
+	default n
+	---help---
+	  Say y here if you wish to be able to put a (soft) upper limit on
+	  the rate of CPU usage by individual tasks.  A task which has been
+	  allocated a soft CPU rate cap will be limited to that rate of CPU
+	  usage unless there is spare CPU resources available after the needs
+	  of uncapped tasks are met.
Index: MM-2.6.17-rc4-mm3/kernel/sched.c
===================================================================
--- MM-2.6.17-rc4-mm3.orig/kernel/sched.c	2006-05-26 10:44:51.000000000 +1000
+++ MM-2.6.17-rc4-mm3/kernel/sched.c	2006-05-26 11:00:02.000000000 +1000
@@ -57,6 +57,19 @@
 
 #include <asm/unistd.h>
 
+#ifdef CONFIG_CPU_RATE_CAPS
+#define IDLE_PRIO	(MAX_PRIO + 2)
+#else
+#define IDLE_PRIO	MAX_PRIO
+#endif
+#define BGND_PRIO	(IDLE_PRIO - 1)
+#define CAPPED_PRIO	(IDLE_PRIO - 2)
+
+int sched_idle_prio(void)
+{
+	return IDLE_PRIO;
+}
+
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
  * to static priority [ MAX_RT_PRIO..MAX_PRIO-1 ],
@@ -186,6 +199,149 @@ static inline unsigned int task_timeslic
 	return static_prio_timeslice(p->static_prio);
 }
 
+#ifdef CONFIG_CPU_RATE_CAPS
+#define CAP_STATS_OFFSET 8
+#define task_has_cap(p) unlikely((p)->flags & PF_HAS_CAP)
+/* this assumes that p is not a real time task */
+#define task_is_background(p) unlikely((p)->cpu_rate_cap == 0)
+#define task_being_capped(p) unlikely((p)->prio >= CAPPED_PRIO)
+#define cap_load_weight(p) (((p)->cpu_rate_cap * SCHED_LOAD_SCALE) / 1000)
+
+static void init_cpu_rate_caps(task_t *p)
+{
+	p->cpu_rate_cap = 1000;
+	p->flags &= ~PF_HAS_CAP;
+}
+
+static inline void set_cap_flag(task_t *p)
+{
+	if (p->cpu_rate_cap < 1000 && !has_rt_policy(p))
+		p->flags |= PF_HAS_CAP;
+	else
+		p->flags &= ~PF_HAS_CAP;
+}
+
+static inline int task_exceeding_cap(const task_t *p)
+{
+	return (p->avg_cpu_per_cycle * 1000) > (p->avg_cycle_length * p->cpu_rate_cap);
+}
+
+#ifdef CONFIG_SCHED_SMT
+static unsigned int smt_timeslice(task_t *p)
+{
+	if (task_has_cap(p) && task_being_capped(p))
+		return 0;
+
+	return task_timeslice(p);
+}
+
+static int task_priority_gt(const task_t *thisp, const task_t *thatp)
+{
+	if (task_has_cap(thisp) && (task_being_capped(thisp)))
+	    return 0;
+
+	if (task_has_cap(thatp) && (task_being_capped(thatp)))
+	    return 1;
+
+	return thisp->static_prio < thatp->static_prio;
+}
+#endif
+
+/*
+ * Update usage stats to "now" before making comparison
+ * Assume: task is actually on a CPU
+ */
+static int task_exceeding_cap_now(const task_t *p, unsigned long long now)
+{
+	unsigned long long delta, lhs, rhs;
+
+	delta = (now > p->timestamp) ? (now - p->timestamp) : 0;
+	lhs = (p->avg_cpu_per_cycle + delta) * 1000;
+	rhs = (p->avg_cycle_length + delta) * p->cpu_rate_cap;
+
+	return lhs > rhs;
+}
+
+static inline void init_cap_stats(task_t *p)
+{
+	p->avg_cpu_per_cycle = 0;
+	p->avg_cycle_length = 0;
+}
+
+static inline void inc_cap_stats_cycle(task_t *p, unsigned long long now)
+{
+	unsigned long long delta;
+
+	delta = (now > p->timestamp) ? (now - p->timestamp) : 0;
+	p->avg_cycle_length += delta;
+}
+
+static inline void inc_cap_stats_both(task_t *p, unsigned long long now)
+{
+	unsigned long long delta;
+
+	delta = (now > p->timestamp) ? (now - p->timestamp) : 0;
+	p->avg_cycle_length += delta;
+	p->avg_cpu_per_cycle += delta;
+}
+
+static inline void decay_cap_stats(task_t *p)
+{
+	p->avg_cycle_length *= ((1 << CAP_STATS_OFFSET) - 1);
+	p->avg_cycle_length >>= CAP_STATS_OFFSET;
+	p->avg_cpu_per_cycle *= ((1 << CAP_STATS_OFFSET) - 1);
+	p->avg_cpu_per_cycle >>= CAP_STATS_OFFSET;
+}
+#else
+#define task_has_cap(p) 0
+#define task_is_background(p) 0
+#define task_being_capped(p) 0
+#define cap_load_weight(p) SCHED_LOAD_SCALE
+
+static inline void init_cpu_rate_caps(task_t *p)
+{
+}
+
+static inline void set_cap_flag(task_t *p)
+{
+}
+
+static inline int task_exceeding_cap(const task_t *p)
+{
+	return 0;
+}
+
+#ifdef CONFIG_SCHED_SMT
+#define smt_timeslice(p) task_timeslice(p)
+
+static inline int task_priority_gt(const task_t *thisp, const task_t *thatp)
+{
+	return thisp->static_prio < thatp->static_prio;
+}
+#endif
+
+static inline int task_exceeding_cap_now(const task_t *p, unsigned long long now)
+{
+	return 0;
+}
+
+static inline void init_cap_stats(task_t *p)
+{
+}
+
+static inline void inc_cap_stats_cycle(task_t *p, unsigned long long now)
+{
+}
+
+static inline void inc_cap_stats_both(task_t *p, unsigned long long now)
+{
+}
+
+static inline void decay_cap_stats(task_t *p)
+{
+}
+#endif
+
 #define task_hot(p, now, sd) ((long long) ((now) - (p)->last_ran)	\
 				< (long long) (sd)->cache_hot_time)
 
@@ -197,8 +353,8 @@ typedef struct runqueue runqueue_t;
 
 struct prio_array {
 	unsigned int nr_active;
-	DECLARE_BITMAP(bitmap, MAX_PRIO+1); /* include 1 bit for delimiter */
-	struct list_head queue[MAX_PRIO];
+	DECLARE_BITMAP(bitmap, IDLE_PRIO+1); /* include 1 bit for delimiter */
+	struct list_head queue[IDLE_PRIO];
 };
 
 /*
@@ -710,6 +866,10 @@ static inline int __normal_prio(task_t *
 {
 	int bonus, prio;
 
+	/* Ensure that background tasks stay at BGND_PRIO */
+	if (task_is_background(p))
+		return BGND_PRIO;
+
 	bonus = CURRENT_BONUS(p) - MAX_BONUS / 2;
 
 	prio = p->static_prio - bonus;
@@ -786,6 +946,8 @@ static inline int expired_starving(runqu
 
 static void set_load_weight(task_t *p)
 {
+	set_cap_flag(p);
+
 	if (has_rt_policy(p)) {
 #ifdef CONFIG_SMP
 		if (p == task_rq(p)->migration_thread)
@@ -798,8 +960,22 @@ static void set_load_weight(task_t *p)
 		else
 #endif
 			p->load_weight = RTPRIO_TO_LOAD_WEIGHT(p->rt_priority);
-	} else
+	} else {
 		p->load_weight = PRIO_TO_LOAD_WEIGHT(p->static_prio);
+
+		/*
+		 * Reduce the probability of a task escaping its CPU rate cap
+		 * due to load balancing leaving it on a lighly used CPU
+		 * This will be optimized away if rate caps aren't configured
+		 */
+		if (task_has_cap(p)) {
+			unsigned int clw; /* load weight based on cap */
+
+			clw = cap_load_weight(p);
+			if (clw < p->load_weight)
+				p->load_weight = clw;
+		}
+	}
 }
 
 static inline void inc_raw_weighted_load(runqueue_t *rq, const task_t *p)
@@ -869,7 +1045,8 @@ static void __activate_task(task_t *p, r
 {
 	prio_array_t *target = rq->active;
 
-	if (unlikely(batch_task(p) || (expired_starving(rq) && !rt_task(p))))
+	if (unlikely(batch_task(p) || (expired_starving(rq) && !rt_task(p)) ||
+			task_being_capped(p)))
 		target = rq->expired;
 	enqueue_task(p, target);
 	inc_nr_running(p, rq);
@@ -975,8 +1152,30 @@ static void activate_task(task_t *p, run
 #endif
 
 	if (!rt_task(p))
+		/*
+		 * We want to do the recalculation even if we're exceeding
+		 * a cap so that everything still works when we stop
+		 * exceeding our cap.
+		 */
 		p->prio = recalc_task_prio(p, now);
 
+	if (task_has_cap(p)) {
+		inc_cap_stats_cycle(p, now);
+		/* Background tasks are handled in effective_prio()
+		 * in order to ensure that they stay at BGND_PRIO
+		 * but we need to be careful that we don't override
+		 * it here
+		 */
+		if (task_exceeding_cap(p) && !task_is_background(p)) {
+			p->normal_prio = CAPPED_PRIO;
+			/*
+			 * Don't undo any priority ineheritance
+			 */
+			if (!rt_task(p))
+				p->prio = CAPPED_PRIO;
+		}
+	}
+
 	/*
 	 * This checks to make sure it's not an uninterruptible task
 	 * that is now waking up.
@@ -1566,6 +1765,7 @@ void fastcall sched_fork(task_t *p, int 
 #endif
 	set_task_cpu(p, cpu);
 
+	init_cap_stats(p);
 	/*
 	 * We mark the process as running here, but have not actually
 	 * inserted it onto the runqueue yet. This guarantees that
@@ -2040,7 +2240,7 @@ void pull_task(runqueue_t *src_rq, prio_
 	p->timestamp = (p->timestamp - src_rq->timestamp_last_tick)
 				+ this_rq->timestamp_last_tick;
 	/*
-	 * Note that idle threads have a prio of MAX_PRIO, for this test
+	 * Note that idle threads have a prio of IDLE_PRIO, for this test
 	 * to be always true for them.
 	 */
 	if (TASK_PREEMPTS_CURR(p, this_rq))
@@ -2140,8 +2340,8 @@ skip_bitmap:
 	if (!idx)
 		idx = sched_find_first_bit(array->bitmap);
 	else
-		idx = find_next_bit(array->bitmap, MAX_PRIO, idx);
-	if (idx >= MAX_PRIO) {
+		idx = find_next_bit(array->bitmap, IDLE_PRIO, idx);
+	if (idx >= IDLE_PRIO) {
 		if (array == busiest->expired && busiest->active->nr_active) {
 			array = busiest->active;
 			dst_array = this_rq->active;
@@ -2931,15 +3131,58 @@ void scheduler_tick(void)
 		}
 		goto out_unlock;
 	}
+	/* Only check for task exceeding cap if it's worthwhile */
+	if (task_has_cap(p)) {
+		/*
+		 * Do this even if there's only one task on the queue as
+		 * we want to set the priority low so that any waking tasks
+		 * can preempt.
+		 */
+		if (task_being_capped(p)) {
+			/*
+			 * Tasks whose cap is currently being enforced will be
+			 * at CAPPED_PRIO or BGND_PRIO priority and preemption
+			 * should be enough to keep them in check provided we
+			 * don't let them adversely effect tasks on the expired
+			 * array
+			 */
+			if (!task_is_background(p) && !task_exceeding_cap_now(p, now)) {
+				dequeue_task(p, rq->active);
+				p->prio = effective_prio(p);
+				enqueue_task(p, rq->active);
+			} else if (rq->expired->nr_active && rq->best_expired_prio < p->prio) {
+				dequeue_task(p, rq->active);
+				enqueue_task(p, rq->expired);
+				set_tsk_need_resched(p);
+				goto out_unlock;
+			}
+		} else if (task_exceeding_cap_now(p, now)) {
+			dequeue_task(p, rq->active);
+			p->prio = CAPPED_PRIO;
+			enqueue_task(p, rq->expired);
+			/*
+			 * think about making this conditional to reduce
+			 * context switch rate
+			 */
+			set_tsk_need_resched(p);
+			goto out_unlock;
+		}
+	}
 	if (!--p->time_slice) {
 		dequeue_task(p, rq->active);
 		set_tsk_need_resched(p);
-		p->prio = effective_prio(p);
+		if (!task_being_capped(p))
+			p->prio = effective_prio(p);
 		p->time_slice = task_timeslice(p);
 		p->first_time_slice = 0;
 
 		if (!rq->expired_timestamp)
 			rq->expired_timestamp = jiffies;
+		/*
+		 * No need to do anything special for capped tasks as here
+		 * TASK_INTERACTIVE() should fail when they're exceeding
+		 * their caps.
+		 */
 		if (!TASK_INTERACTIVE(p) || expired_starving(rq)) {
 			enqueue_task(p, rq->expired);
 			if (p->static_prio < rq->best_expired_prio)
@@ -3104,9 +3347,9 @@ static int dependent_sleeper(int this_cp
 				(sd->per_cpu_gain * DEF_TIMESLICE / 100))
 					ret = 1;
 		} else
-			if (smt_curr->static_prio < p->static_prio &&
+			if (task_priority_gt(smt_curr, p) &&
 				!TASK_PREEMPTS_CURR(p, smt_rq) &&
-				smt_slice(smt_curr, sd) > task_timeslice(p))
+				smt_slice(smt_curr, sd) > smt_timeslice(p))
 					ret = 1;
 
 check_smt_task:
@@ -3129,7 +3372,7 @@ check_smt_task:
 					resched_task(smt_curr);
 		} else {
 			if (TASK_PREEMPTS_CURR(p, smt_rq) &&
-				smt_slice(p, sd) > task_timeslice(smt_curr))
+				smt_slice(p, sd) > smt_timeslice(smt_curr))
 					resched_task(smt_curr);
 			else
 				wakeup_busy_runqueue(smt_rq);
@@ -3265,6 +3508,10 @@ need_resched_nonpreemptible:
 		}
 	}
 
+	/* do this now so that stats are correct for SMT code */
+	if (task_has_cap(prev))
+		inc_cap_stats_both(prev, now);
+
 	cpu = smp_processor_id();
 	if (unlikely(!rq->nr_running)) {
 go_idle:
@@ -3305,7 +3552,7 @@ go_idle:
 		rq->expired = array;
 		array = rq->active;
 		rq->expired_timestamp = 0;
-		rq->best_expired_prio = MAX_PRIO;
+		rq->best_expired_prio = IDLE_PRIO;
 	}
 
 	idx = sched_find_first_bit(array->bitmap);
@@ -3323,7 +3570,7 @@ go_idle:
 		array = next->array;
 		new_prio = recalc_task_prio(next, next->timestamp + delta);
 
-		if (unlikely(next->prio != new_prio)) {
+		if (unlikely(next->prio != new_prio && !task_being_capped(next))) {
 			dequeue_task(next, array);
 			next->prio = new_prio;
 			enqueue_task(next, array);
@@ -3347,6 +3594,10 @@ switch_tasks:
 
 	sched_info_switch(prev, next);
 	if (likely(prev != next)) {
+		if (task_has_cap(next)) {
+			decay_cap_stats(next);
+			inc_cap_stats_cycle(next, now);
+		}
 		next->timestamp = now;
 		rq->nr_switches++;
 		rq->curr = next;
@@ -3792,7 +4043,7 @@ void rt_mutex_setprio(task_t *p, int pri
 	runqueue_t *rq;
 	int oldprio;
 
-	BUG_ON(prio < 0 || prio > MAX_PRIO);
+	BUG_ON(prio < 0 || prio > IDLE_PRIO);
 
 	rq = task_rq_lock(p, &flags);
 
@@ -4220,6 +4471,76 @@ out_unlock:
 	return retval;
 }
 
+#ifdef CONFIG_CPU_RATE_CAPS
+unsigned int get_cpu_rate_cap(const struct task_struct *p)
+{
+	return p->cpu_rate_cap;
+}
+
+EXPORT_SYMBOL(get_cpu_rate_cap);
+
+/*
+ * Require: 0 <= new_cap <= 1000
+ */
+int set_cpu_rate_cap(struct task_struct *p, unsigned int new_cap)
+{
+	int is_allowed;
+	unsigned long flags;
+	struct runqueue *rq;
+	prio_array_t *array;
+	int delta;
+
+	if (new_cap > 1000)
+		return -EINVAL;
+	is_allowed = capable(CAP_SYS_NICE);
+	/*
+	 * We have to be careful, if called from /proc code,
+	 * the task might be in the middle of scheduling on another CPU.
+	 */
+	rq = task_rq_lock(p, &flags);
+	delta = new_cap - p->cpu_rate_cap;
+	if (!is_allowed) {
+		/*
+		 * Ordinary users can set/change caps on their own tasks
+		 * provided that the new setting is MORE constraining
+		 */
+		if (((current->euid != p->uid) && (current->uid != p->uid)) || (delta > 0)) {
+			task_rq_unlock(rq, &flags);
+			return -EPERM;
+		}
+	}
+	/*
+	 * The RT tasks don't have caps, but we still allow the caps to be
+	 * set - but as expected it wont have any effect on scheduling until
+	 * the task becomes SCHED_NORMAL/SCHED_BATCH:
+	 */
+	p->cpu_rate_cap = new_cap;
+
+	if (has_rt_policy(p))
+		goto out;
+
+	array = p->array;
+	if (array) {
+		dec_raw_weighted_load(rq, p);
+		dequeue_task(p, array);
+	}
+
+	set_load_weight(p);
+	p->prio = effective_prio(p);
+
+	if (array) {
+		enqueue_task(p, array);
+		inc_raw_weighted_load(rq, p);
+	}
+out:
+	task_rq_unlock(rq, &flags);
+
+	return 0;
+}
+
+EXPORT_SYMBOL(set_cpu_rate_cap);
+#endif
+
 long sched_setaffinity(pid_t pid, cpumask_t new_mask)
 {
 	task_t *p;
@@ -4733,7 +5054,7 @@ void __devinit init_idle(task_t *idle, i
 	idle->timestamp = sched_clock();
 	idle->sleep_avg = 0;
 	idle->array = NULL;
-	idle->prio = idle->normal_prio = MAX_PRIO;
+	idle->prio = idle->normal_prio = IDLE_PRIO;
 	idle->state = TASK_RUNNING;
 	idle->cpus_allowed = cpumask_of_cpu(cpu);
 	set_task_cpu(idle, cpu);
@@ -5074,7 +5395,7 @@ static void migrate_dead_tasks(unsigned 
 	struct runqueue *rq = cpu_rq(dead_cpu);
 
 	for (arr = 0; arr < 2; arr++) {
-		for (i = 0; i < MAX_PRIO; i++) {
+		for (i = 0; i < IDLE_PRIO; i++) {
 			struct list_head *list = &rq->arrays[arr].queue[i];
 			while (!list_empty(list))
 				migrate_dead(dead_cpu,
@@ -5244,7 +5565,7 @@ static int migration_call(struct notifie
 		/* Idle task back to normal (off runqueue, low prio) */
 		rq = task_rq_lock(rq->idle, &flags);
 		deactivate_task(rq->idle, rq);
-		rq->idle->static_prio = MAX_PRIO;
+		rq->idle->static_prio = IDLE_PRIO;
 		__setscheduler(rq->idle, SCHED_NORMAL, 0);
 		migrate_dead_tasks(cpu);
 		task_rq_unlock(rq, &flags);
@@ -6657,7 +6978,7 @@ void __init sched_init(void)
 		rq->nr_running = 0;
 		rq->active = rq->arrays;
 		rq->expired = rq->arrays + 1;
-		rq->best_expired_prio = MAX_PRIO;
+		rq->best_expired_prio = IDLE_PRIO;
 
 #ifdef CONFIG_SMP
 		rq->sd = NULL;
@@ -6673,15 +6994,16 @@ void __init sched_init(void)
 
 		for (j = 0; j < 2; j++) {
 			array = rq->arrays + j;
-			for (k = 0; k < MAX_PRIO; k++) {
+			for (k = 0; k < IDLE_PRIO; k++) {
 				INIT_LIST_HEAD(array->queue + k);
 				__clear_bit(k, array->bitmap);
 			}
 			// delimiter for bitsearch
-			__set_bit(MAX_PRIO, array->bitmap);
+			__set_bit(IDLE_PRIO, array->bitmap);
 		}
 	}
 
+	init_cpu_rate_caps(&init_task);
 	set_load_weight(&init_task);
 	/*
 	 * The boot idle thread does lazy MMU switching as well:
Index: MM-2.6.17-rc4-mm3/kernel/rtmutex-debug.c
===================================================================
--- MM-2.6.17-rc4-mm3.orig/kernel/rtmutex-debug.c	2006-05-26 10:39:59.000000000 +1000
+++ MM-2.6.17-rc4-mm3/kernel/rtmutex-debug.c	2006-05-26 10:45:26.000000000 +1000
@@ -479,8 +479,8 @@ void debug_rt_mutex_proxy_unlock(struct 
 void debug_rt_mutex_init_waiter(struct rt_mutex_waiter *waiter)
 {
 	memset(waiter, 0x11, sizeof(*waiter));
-	plist_node_init(&waiter->list_entry, MAX_PRIO);
-	plist_node_init(&waiter->pi_list_entry, MAX_PRIO);
+	plist_node_init(&waiter->list_entry, sched_idle_prio());
+	plist_node_init(&waiter->pi_list_entry, sched_idle_prio());
 }
 
 void debug_rt_mutex_free_waiter(struct rt_mutex_waiter *waiter)

-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
 -- Ambrose Bierce
