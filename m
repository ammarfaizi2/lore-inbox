Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262186AbVAZJs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbVAZJs4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 04:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbVAZJs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 04:48:56 -0500
Received: from mail07.syd.optusnet.com.au ([211.29.132.188]:44467 "EHLO
	mail07.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262186AbVAZJsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 04:48:23 -0500
Message-ID: <41F76746.5050801@kolivas.org>
Date: Wed, 26 Jan 2005 20:47:50 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Alexander Nyberg <alexn@dsv.su.se>, "Jack O'Quin" <joq@io.com>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: [PATCH] sched - Implement priority and fifo support for SCHED_ISO
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE1636C6957F24E7C34FAF0D2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE1636C6957F24E7C34FAF0D2
Content-Type: multipart/mixed;
 boundary="------------040709030706040808000206"

This is a multi-part message in MIME format.
--------------040709030706040808000206
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

While it is not clear what form the final soft real time implementation 
is, we should complete the partial implementation of SCHED_ISO that is 
in 2.6.11-rc2-mm1.

Thanks to Alex Nyberg and Zwane Mwaikambo for debugging help.

Cheers,
Con


--------------040709030706040808000206
Content-Type: text/x-diff;
 name="iso-add_prio-fifo.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="iso-add_prio-fifo.diff"

This patch completes the implementation of the SCHED_ISO scheduling policy.

This splits the SCHED_ISO policy into two discrete policies which are the
unprivileged counterparts of SCHED_RR and SCHED_FIFO, calling them
SCHED_ISO_RR and SCHED_ISO_FIFO. When an unprivileged user calls for a real
time task they are downgraded to their SCHED_ISO counterparts.

This patch also adds full priority support to the isochronous scheduling
policies. Their range is the same size as the range available to
MAX_USER_RT_PRIO but their effective priority is lower than any privileged
real time tasks.

The priorities as seen to userspace would appear as:
0 -> 39  SCHED_NORMAL
-100 -> -1  Isochronous
-200 -> -101  Real time

Signed-off-by: Con Kolivas <kernel@kolivas.org>

Index: linux-2.6.11-rc2-mm1/include/linux/sched.h
===================================================================
--- linux-2.6.11-rc2-mm1.orig/include/linux/sched.h	2005-01-25 20:35:05.000000000 +1100
+++ linux-2.6.11-rc2-mm1/include/linux/sched.h	2005-01-25 20:36:01.000000000 +1100
@@ -132,18 +132,26 @@ extern unsigned long nr_iowait(void);
 #define SCHED_FIFO		1
 #define SCHED_RR		2
 /* policy 3 reserved for SCHED_BATCH */
-#define SCHED_ISO		4
+#define SCHED_ISO_RR		4
+#define SCHED_ISO_FIFO		5
 
 extern int iso_cpu, iso_period;
 
 #define SCHED_RANGE(policy)	((policy) == SCHED_NORMAL || \
 				(policy) == SCHED_FIFO || \
 				(policy) == SCHED_RR || \
-				(policy) == SCHED_ISO)
+				(policy) == SCHED_ISO_RR || \
+				(policy) == SCHED_ISO_FIFO)
 
 #define SCHED_RT(policy)	((policy) == SCHED_FIFO || \
 				(policy) == SCHED_RR)
 
+#define SCHED_ISO(policy)	((policy) == SCHED_ISO_RR || \
+				(policy) == SCHED_ISO_FIFO)
+
+/* The policies that support a real time priority setting */
+#define SCHED_RT_PRIO(policy)	(SCHED_RT(policy) || SCHED_ISO(policy))
+
 struct sched_param {
 	int sched_priority;
 };
@@ -382,15 +390,21 @@ struct signal_struct {
  * user-space.  This allows kernel threads to set their
  * priority to a value higher than any user task. Note:
  * MAX_RT_PRIO must not be smaller than MAX_USER_RT_PRIO.
+ *
+ * SCHED_ISO tasks have a rt priority of the same range as
+ * real time tasks. They are seen as having either a priority
+ * of ISO_PRIO if below starvation limits or their underlying 
+ * equivalent SCHED_NORMAL priority if above.
  */
 
 #define MAX_USER_RT_PRIO	100
 #define MAX_RT_PRIO		MAX_USER_RT_PRIO
+#define ISO_PRIO		(MAX_RT_PRIO - 1)
 
 #define MAX_PRIO		(MAX_RT_PRIO + 40)
 
-#define rt_task(p)		(unlikely((p)->prio < MAX_RT_PRIO))
-#define iso_task(p)		(unlikely((p)->policy == SCHED_ISO))
+#define rt_task(p)		(unlikely((p)->prio < ISO_PRIO))
+#define iso_task(p)		(unlikely(SCHED_ISO((p)->policy)))
 
 /*
  * Some day this will be a full-fledged user tracking system..
Index: linux-2.6.11-rc2-mm1/kernel/sched.c
===================================================================
--- linux-2.6.11-rc2-mm1.orig/kernel/sched.c	2005-01-25 20:35:05.000000000 +1100
+++ linux-2.6.11-rc2-mm1/kernel/sched.c	2005-01-25 23:25:06.000000000 +1100
@@ -184,6 +184,8 @@ int iso_period = 5;	/* The time over whi
  */
 
 #define BITMAP_SIZE ((((MAX_PRIO+1+7)/8)+sizeof(long)-1)/sizeof(long))
+#define ISO_BITMAP_SIZE ((((MAX_USER_RT_PRIO+1+7)/8)+sizeof(long)-1)/ \
+			sizeof(long))
 
 typedef struct runqueue runqueue_t;
 
@@ -212,7 +214,9 @@ struct runqueue {
 	unsigned long cpu_load;
 #endif
 	unsigned long iso_ticks;
-	struct list_head iso_queue;
+	unsigned long iso_running;
+	unsigned long iso_bitmap[ISO_BITMAP_SIZE];
+	struct list_head iso_queue[MAX_USER_RT_PRIO];
 	int iso_refractory;
 	/*
 	 * Refractory is the flag that we've hit the maximum iso cpu and are
@@ -312,15 +316,26 @@ static DEFINE_PER_CPU(struct runqueue, r
 # define task_running(rq, p)		((rq)->curr == (p))
 #endif
 
-static inline int task_preempts_curr(task_t *p, runqueue_t *rq)
+static int task_preempts_curr(task_t *p, runqueue_t *rq)
 {
-	if ((!iso_task(p) && !iso_task(rq->curr)) || rq->iso_refractory ||
-		rt_task(p) || rt_task(rq->curr)) {
-			if (p->prio < rq->curr->prio)
-				return 1;
-			return 0;
+	int p_prio = p->prio, curr_prio = rq->curr->prio;
+
+	if (!iso_task(p) && !iso_task(rq->curr))
+		goto out;
+	if (!rq->iso_refractory) {
+		if (iso_task(p)) {
+			if (iso_task(rq->curr)) {
+				p_prio = -p->rt_priority;
+				curr_prio = -rq->curr->rt_priority;
+				goto out;
+			}
+			p_prio = ISO_PRIO;
+		if (iso_task(rq->curr))
+			curr_prio = ISO_PRIO;
+		}
 	}
-	if (iso_task(p) && !iso_task(rq->curr))
+out:
+	if (p_prio < curr_prio)
 		return 1;
 	return 0;
 }
@@ -590,41 +605,43 @@ static inline void sched_info_switch(tas
 #define sched_info_switch(t, next)	do { } while (0)
 #endif /* CONFIG_SCHEDSTATS */
 
-static inline int iso_queued(runqueue_t *rq)
-{
-	return !list_empty(&rq->iso_queue);
-}
+/* We invert the ISO rt_priorities for queueing order */
+#define iso_prio(p)	(ISO_PRIO - (p)->rt_priority)
 
-static inline void dequeue_iso_task(struct task_struct *p)
+static void dequeue_iso_task(struct task_struct *p, runqueue_t *rq)
 {
+	rq->iso_running--;
 	list_del(&p->iso_list);
+	if (list_empty(rq->iso_queue + iso_prio(p)))
+		__clear_bit(iso_prio(p), rq->iso_bitmap);
 }
 
 /*
  * Adding/removing a task to/from a priority array:
  */
-static void dequeue_task(struct task_struct *p, prio_array_t *array)
+static void dequeue_task(struct task_struct *p, runqueue_t *rq, prio_array_t *array)
 {
-	array->nr_active--;
 	if (iso_task(p))
-		dequeue_iso_task(p);
+		dequeue_iso_task(p, rq);
+	array->nr_active--;
 	list_del(&p->run_list);
 	if (list_empty(array->queue + p->prio))
 		__clear_bit(p->prio, array->bitmap);
 }
 
 /*
- * SCHED_ISO tasks are queued at both runqueues. Their actual priority is
+ * SCHED_ISO tasks are queued on both runqueues. Their actual priority is
  * either better than SCHED_NORMAL if below starvation limits, or
- * the underlying SCHED_NORMAL dynamic priority.
+ * their underlying SCHED_NORMAL dynamic priority.
  */
-static void enqueue_iso_task(struct task_struct *p)
+static void enqueue_iso_task(struct task_struct *p, runqueue_t *rq)
 {
-	runqueue_t *rq = task_rq(p);
-	list_add_tail(&p->iso_list, &rq->iso_queue);
+	list_add_tail(&p->iso_list, rq->iso_queue + iso_prio(p));
+	__set_bit(iso_prio(p), rq->iso_bitmap);
+	rq->iso_running++;
 }
 
-static void enqueue_task(struct task_struct *p, prio_array_t *array)
+static void enqueue_task(struct task_struct *p, runqueue_t *rq, prio_array_t *array)
 {
 	sched_info_queued(p);
 	list_add_tail(&p->run_list, array->queue + p->prio);
@@ -632,24 +649,23 @@ static void enqueue_task(struct task_str
 	array->nr_active++;
 	p->array = array;
 	if (iso_task(p))
-		enqueue_iso_task(p);
+		enqueue_iso_task(p, rq);
 }
 
-static void requeue_iso_task(struct task_struct *p)
+static void requeue_iso_task(struct task_struct *p, runqueue_t *rq)
 {
-	runqueue_t *rq = task_rq(p);
-	list_move_tail(&p->iso_list, &rq->iso_queue);
+	list_move_tail(&p->iso_list, rq->iso_queue + iso_prio(p));
 }
 
 /*
  * Put task to the end of the run list without the overhead of dequeue
  * followed by enqueue.
  */
-static void requeue_task(struct task_struct *p, prio_array_t *array)
+static void requeue_task(struct task_struct *p, runqueue_t *rq, prio_array_t *array)
 {
 	list_move_tail(&p->run_list, array->queue + p->prio);
 	if (iso_task(p))
-		requeue_iso_task(p);
+		requeue_iso_task(p, rq);
 }
 
 static inline void enqueue_task_head(struct task_struct *p, prio_array_t *array)
@@ -696,7 +712,7 @@ static int effective_prio(task_t *p)
  */
 static inline void __activate_task(task_t *p, runqueue_t *rq)
 {
-	enqueue_task(p, rq->active);
+	enqueue_task(p, rq, rq->active);
 	rq->nr_running++;
 }
 
@@ -825,7 +841,7 @@ static void activate_task(task_t *p, run
 static void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
 	rq->nr_running--;
-	dequeue_task(p, p->array);
+	dequeue_task(p, rq, p->array);
 	p->array = NULL;
 }
 
@@ -1300,7 +1316,7 @@ void fastcall wake_up_new_task(task_t * 
 				p->array->nr_active++;
 				rq->nr_running++;
 				if (iso_task(p))
-					enqueue_iso_task(p);
+					enqueue_iso_task(p, rq);
 			}
 			set_need_resched();
 		} else
@@ -1689,11 +1705,11 @@ static inline
 void pull_task(runqueue_t *src_rq, prio_array_t *src_array, task_t *p,
 	       runqueue_t *this_rq, prio_array_t *this_array, int this_cpu)
 {
-	dequeue_task(p, src_array);
+	dequeue_task(p, src_rq, src_array);
 	src_rq->nr_running--;
 	set_task_cpu(p, this_cpu);
 	this_rq->nr_running++;
-	enqueue_task(p, this_array);
+	enqueue_task(p, this_rq, this_array);
 	p->timestamp = (p->timestamp - src_rq->timestamp_last_tick)
 				+ this_rq->timestamp_last_tick;
 	/*
@@ -2497,42 +2513,29 @@ void scheduler_tick(void)
 			set_tsk_need_resched(p);
 
 			/* put it at the end of the queue: */
-			requeue_task(p, rq->active);
+			requeue_task(p, rq, rq->active);
 		}
 		goto out_unlock;
 	}
 
 	if (iso_task(p)) {
-		if (rq->iso_refractory) {
+		if (rq->iso_refractory)
 			/*
 			 * If we are in the refractory period for SCHED_ISO
-			 * tasks we schedule them as SCHED_NORMAL. If their
-			 * priority is set to the ISO priority, change it.
+			 * tasks we schedule them as SCHED_NORMAL.
 			 */
-			if (p->prio == MAX_RT_PRIO) {
-				dequeue_task(p, rq->active);
-				p->prio = effective_prio(p);
-				enqueue_task(p, rq->active);
-			}
 			goto sched_normal;
-		}
-		if (p->prio > MAX_RT_PRIO) {
-			dequeue_task(p, rq->active);
-			p->prio = MAX_RT_PRIO;
-			enqueue_task(p, rq->active);
-		}
-		if (!(--p->time_slice % GRANULARITY)) {
+		if (p->policy == SCHED_ISO_RR && !--p->time_slice) {
+			p->time_slice = task_timeslice(p);
 			set_tsk_need_resched(p);
-			requeue_iso_task(p);
+			requeue_iso_task(p, rq);
 		}
-		if (!p->time_slice)
-			p->time_slice = task_timeslice(p);
 		goto out_unlock;
 	}
 
 sched_normal:
 	if (!--p->time_slice) {
-		dequeue_task(p, rq->active);
+		dequeue_task(p, rq, rq->active);
 		set_tsk_need_resched(p);
 		p->prio = effective_prio(p);
 		p->time_slice = task_timeslice(p);
@@ -2541,11 +2544,11 @@ sched_normal:
 		if (!rq->expired_timestamp)
 			rq->expired_timestamp = jiffies;
 		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
-			enqueue_task(p, rq->expired);
+			enqueue_task(p, rq, rq->expired);
 			if (p->static_prio < rq->best_expired_prio)
 				rq->best_expired_prio = p->static_prio;
 		} else
-			enqueue_task(p, rq->active);
+			enqueue_task(p, rq, rq->active);
 	} else {
 		/*
 		 * Prevent a too long timeslice allowing a task to monopolize
@@ -2568,7 +2571,7 @@ sched_normal:
 			(p->time_slice >= TIMESLICE_GRANULARITY(p)) &&
 			(p->array == rq->active)) {
 
-			requeue_task(p, rq->active);
+			requeue_task(p, rq, rq->active);
 			set_tsk_need_resched(p);
 		}
 	}
@@ -2580,30 +2583,45 @@ out:
 
 static inline int iso_ready(runqueue_t *rq)
 {
-	if (iso_queued(rq) && !rq->iso_refractory)
+	if (rq->iso_running && !rq->iso_refractory)
 		return 1;
 	return 0;
 }
 
 /*
- * When a SCHED_ISO task is ready to be scheduled, we re-queue it with an
- * effective prio of MAX_RT_PRIO for userspace to know its relative prio.
+ * When a SCHED_ISO task is ready to be scheduled, we ensure it is queued
+ * on the active array.
  */
-static task_t* queue_iso(runqueue_t *rq, prio_array_t *array)
+static task_t* find_iso(runqueue_t *rq, prio_array_t *array)
 {
-	task_t *p = list_entry(rq->iso_queue.next, task_t, iso_list);
-	if (p->prio == MAX_RT_PRIO)
+	prio_array_t *old_array;
+	task_t *p;
+	int idx = find_first_bit(rq->iso_bitmap, MAX_USER_RT_PRIO);
+
+	p = list_entry(rq->iso_queue[idx].next, task_t, iso_list);
+	if (p->array == array)
 		goto out;
+	old_array = p->array;
+	old_array->nr_active--;
 	list_del(&p->run_list);
-	if (list_empty(array->queue + p->prio))
-		__clear_bit(p->prio, array->bitmap);
-	p->prio = MAX_RT_PRIO;
+	if (list_empty(old_array->queue + p->prio))
+		__clear_bit(p->prio, old_array->bitmap);
 	list_add_tail(&p->run_list, array->queue + p->prio);
 	__set_bit(p->prio, array->bitmap);
-out:
+	array->nr_active++;
+	p->array = array;
+out:	
 	return p;
 }
 
+static inline task_t* find_next_task(runqueue_t *rq, prio_array_t *array)
+{
+	int idx = sched_find_first_bit(array->bitmap);
+	if (unlikely(iso_ready(rq) && idx > ISO_PRIO))
+		return find_iso(rq, array);
+	return list_entry(array->queue[idx].next, task_t, run_list);
+}
+
 #ifdef CONFIG_SCHED_SMT
 static inline void wake_sleeping_dependent(int this_cpu, runqueue_t *this_rq)
 {
@@ -2655,7 +2673,7 @@ static inline int dependent_sleeper(int 
 	struct sched_domain *sd = this_rq->sd;
 	cpumask_t sibling_map;
 	prio_array_t *array;
-	int ret = 0, i, idx;
+	int ret = 0, i;
 	task_t *p;
 
 	if (!(sd->flags & SD_SHARE_CPUPOWER))
@@ -2682,11 +2700,7 @@ static inline int dependent_sleeper(int 
 		array = this_rq->expired;
 	BUG_ON(!array->nr_active);
 
-	idx = sched_find_first_bit(array->bitmap);
-	if (unlikely(iso_ready(this_rq) && idx >= MAX_RT_PRIO))
-		p = queue_iso(this_rq, array);
-	else
-		p = list_entry(array->queue[idx].next, task_t, run_list);
+	p = find_next_task(this_rq, array);
 
 	for_each_cpu_mask(i, sibling_map) {
 		runqueue_t *smt_rq = cpu_rq(i);
@@ -2774,10 +2788,9 @@ asmlinkage void __sched schedule(void)
 	task_t *prev, *next;
 	runqueue_t *rq;
 	prio_array_t *array;
-	struct list_head *queue;
 	unsigned long long now;
 	unsigned long run_time;
-	int cpu, idx;
+	int cpu;
 
 	/*
 	 * Test if we are atomic.  Since do_exit() needs to call into
@@ -2885,13 +2898,7 @@ go_idle:
 	} else
 		schedstat_inc(rq, sched_noswitch);
 
-	idx = sched_find_first_bit(array->bitmap);
-	if (unlikely(iso_ready(rq) && idx >= MAX_RT_PRIO))
-		next = queue_iso(rq, array);
-	else {
-		queue = array->queue + idx;
-		next = list_entry(queue->next, task_t, run_list);
-	}
+	next = find_next_task(rq, array);
 
 	if (!rt_task(next) && !(iso_task(next) && !rq->iso_refractory) &&
 		next->activated > 0) {
@@ -2901,9 +2908,9 @@ go_idle:
 				delta = delta *
 					(ON_RUNQUEUE_WEIGHT * 128 / 100) / 128;
 			array = next->array;
-			dequeue_task(next, array);
+			dequeue_task(next, rq, array);
 			recalc_task_prio(next, next->timestamp + delta);
-		enqueue_task(next, array);
+		enqueue_task(next, rq, array);
 	}
 	next->activated = 0;
 switch_tasks:
@@ -3362,7 +3369,7 @@ void set_user_nice(task_t *p, long nice)
 	}
 	array = p->array;
 	if (array)
-		dequeue_task(p, array);
+		dequeue_task(p, rq, array);
 
 	old_prio = p->prio;
 	new_prio = NICE_TO_PRIO(nice);
@@ -3371,7 +3378,7 @@ void set_user_nice(task_t *p, long nice)
 	p->prio += delta;
 
 	if (array) {
-		enqueue_task(p, array);
+		enqueue_task(p, rq, array);
 		/*
 		 * If the task increased its priority or is running and
 		 * lowered its priority, then reschedule its CPU:
@@ -3446,6 +3453,10 @@ asmlinkage long sys_nice(int increment)
  */
 int task_prio(const task_t *p)
 {
+	if (iso_task(p))
+		return -(p->rt_priority);
+	if (rt_task(p))
+		return -(MAX_RT_PRIO + p->rt_priority);
 	return p->prio - MAX_RT_PRIO;
 }
 
@@ -3524,28 +3535,36 @@ int sched_setscheduler(struct task_struc
 	runqueue_t *rq;
 
 recheck:
+	if (SCHED_RT(policy) && !capable(CAP_SYS_NICE)) {
+		/*
+		 * If the caller requested an RT policy without having the
+		 * necessary rights, we downgrade the policy to the 
+		 * SCHED_ISO equivalent.
+		 */
+		if ((policy) == SCHED_RR)
+			policy = SCHED_ISO_RR;
+		else
+			policy = SCHED_ISO_FIFO;
+		}
+
 	/* double check policy once rq lock held */
 	if (policy < 0)
 		policy = oldpolicy = p->policy;
 	else if (!SCHED_RANGE(policy))
 		return -EINVAL;
 	/*
-	 * Valid priorities for SCHED_FIFO and SCHED_RR are
+	 * Valid priorities for SCHED_FIFO, SCHED_RR and SCHED_ISO are
 	 * 1..MAX_USER_RT_PRIO-1, valid priority for SCHED_NORMAL is 0.
 	 */
 	if (param->sched_priority < 0 ||
 	    param->sched_priority > MAX_USER_RT_PRIO-1)
 		return -EINVAL;
-	if ((!SCHED_RT(policy)) != (param->sched_priority == 0))
+	if (SCHED_RT(policy) && !capable(CAP_SYS_NICE))
+		return -EPERM;
+
+	if ((!SCHED_RT_PRIO(policy)) != (param->sched_priority == 0))
 		return -EINVAL;
 
-	if (SCHED_RT(policy) && !capable(CAP_SYS_NICE))
-		/*
-		 * If the caller requested an RT policy without having the
-		 * necessary rights, we downgrade the policy to SCHED_ISO.
-		 * Temporary hack for testing.
-		 */
-		policy = SCHED_ISO;
 	if ((current->euid != p->euid) && (current->euid != p->uid) &&
 	    !capable(CAP_SYS_NICE))
 		return -EPERM;
@@ -3862,13 +3881,13 @@ asmlinkage long sys_sched_yield(void)
 		schedstat_inc(rq, yld_exp_empty);
 
 	if (array != target) {
-		dequeue_task(current, array);
-		enqueue_task(current, target);
+		dequeue_task(current, rq, array);
+		enqueue_task(current, rq, target);
 	} else
 		/*
 		 * requeue_task is cheaper so perform that if possible.
 		 */
-		requeue_task(current, array);
+		requeue_task(current, rq, array);
 
 	/*
 	 * Since we are going to call schedule() anyway, there's
@@ -4006,10 +4025,11 @@ asmlinkage long sys_sched_get_priority_m
 	switch (policy) {
 	case SCHED_FIFO:
 	case SCHED_RR:
+	case SCHED_ISO_RR:
+	case SCHED_ISO_FIFO:
 		ret = MAX_USER_RT_PRIO-1;
 		break;
 	case SCHED_NORMAL:
-	case SCHED_ISO:
 		ret = 0;
 		break;
 	}
@@ -4030,10 +4050,11 @@ asmlinkage long sys_sched_get_priority_m
 	switch (policy) {
 	case SCHED_FIFO:
 	case SCHED_RR:
+	case SCHED_ISO_RR:
+	case SCHED_ISO_FIFO:
 		ret = 1;
 		break;
 	case SCHED_NORMAL:
-	case SCHED_ISO:
 		ret = 0;
 	}
 	return ret;
@@ -5092,7 +5113,7 @@ void __init sched_init(void)
 		rq->active = rq->arrays;
 		rq->expired = rq->arrays + 1;
 		rq->best_expired_prio = MAX_PRIO;
-		rq->iso_refractory = rq->iso_ticks = 0;
+		rq->iso_refractory = rq->iso_ticks = rq->iso_running = 0;
 
 #ifdef CONFIG_SMP
 		rq->sd = &sched_domain_dummy;
@@ -5113,7 +5134,11 @@ void __init sched_init(void)
 			// delimiter for bitsearch
 			__set_bit(MAX_PRIO, array->bitmap);
 		}
-		INIT_LIST_HEAD(&rq->iso_queue);
+		for (j = 0; j < MAX_USER_RT_PRIO; j++) {
+			INIT_LIST_HEAD(rq->iso_queue + j);
+			__clear_bit(j, rq->iso_bitmap);
+		}
+		__set_bit(MAX_USER_RT_PRIO, rq->iso_bitmap);
 	}
 
 	/*


--------------040709030706040808000206--

--------------enigE1636C6957F24E7C34FAF0D2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB92dJZUg7+tp6mRURAiaIAKCJ9fw7MZnPNmSzDUHrgKSQpf9MuwCfRCAU
9wNpqxK9wbg/jov7Ngv0hn0=
=1NDG
-----END PGP SIGNATURE-----

--------------enigE1636C6957F24E7C34FAF0D2--
