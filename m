Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbVAXXTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbVAXXTE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 18:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbVAXXTC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 18:19:02 -0500
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:47248 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261724AbVAXW5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 17:57:51 -0500
Message-ID: <41F57D94.4010500@kolivas.org>
Date: Tue, 25 Jan 2005 09:58:28 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jack O'Quin" <joq@io.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux <linux-kernel@vger.kernel.org>,
       CK Kernel <ck@vds.kolivas.org>, Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt scheduling
References: <200501201542.j0KFgOwo019109@localhost.localdomain>	<87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu>	<87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu>	<87pszvlvma.fsf@sulphur.joq.us> <41F42BD2.4000709@kolivas.org>	<877jm3ljo9.fsf@sulphur.joq.us> <41F44AC2.1080609@kolivas.org>	<87hdl7v3ik.fsf@sulphur.joq.us> <87651nv356.fsf@sulphur.joq.us>	<87ekgbqr2a.fsf@sulphur.joq.us> <41F49735.5000400@kolivas.org> <873bwrpb4o.fsf@sulphur.joq.us>
In-Reply-To: <873bwrpb4o.fsf@sulphur.joq.us>
Content-Type: multipart/mixed;
 boundary="------------030705020701070000060003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030705020701070000060003
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

-cc list trimmed to those who have recently responded.


Here is a patch to go on top of 2.6.11-rc2-mm1 that fixes some bugs in 
the general SCHED_ISO code, fixes the priority support between ISO 
threads, and implements SCHED_ISO_RR and SCHED_ISO_FIFO as separate 
policies. Note the bugfixes and cleanups mean the codepaths in this are 
leaner than the original ISO2 implementation despite the extra features.

This works safely and effectively on UP (but not tested on SMP yet) so 
Jack if/when you get a chance I'd love to see more benchmarks from you 
on this one. It seems on my machine the earlier ISO2 implementation 
without priority nor FIFO was enough for good results, but not on yours, 
which makes your testcase a more discriminating one.

Cheers,
Con

--------------030705020701070000060003
Content-Type: text/x-patch;
 name="iso2_prio_fifo.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="iso2_prio_fifo.diff"

Index: linux-2.6.11-rc2-mm1/include/linux/sched.h
===================================================================
--- linux-2.6.11-rc2-mm1.orig/include/linux/sched.h	2005-01-25 08:50:33.000000000 +1100
+++ linux-2.6.11-rc2-mm1/include/linux/sched.h	2005-01-25 09:08:47.000000000 +1100
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
--- linux-2.6.11-rc2-mm1.orig/kernel/sched.c	2005-01-25 08:50:33.000000000 +1100
+++ linux-2.6.11-rc2-mm1/kernel/sched.c	2005-01-25 09:07:02.000000000 +1100
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
+	unsigned int iso_active;
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
@@ -590,14 +605,13 @@ static inline void sched_info_switch(tas
 #define sched_info_switch(t, next)	do { } while (0)
 #endif /* CONFIG_SCHEDSTATS */
 
-static inline int iso_queued(runqueue_t *rq)
-{
-	return !list_empty(&rq->iso_queue);
-}
-
-static inline void dequeue_iso_task(struct task_struct *p)
+static void dequeue_iso_task(struct task_struct *p)
 {
+	runqueue_t *rq = task_rq(p);
+	rq->iso_active--;
 	list_del(&p->iso_list);
+	if (list_empty(rq->iso_queue + p->rt_priority))
+		__clear_bit(p->rt_priority, rq->iso_bitmap);
 }
 
 /*
@@ -605,23 +619,25 @@ static inline void dequeue_iso_task(stru
  */
 static void dequeue_task(struct task_struct *p, prio_array_t *array)
 {
-	array->nr_active--;
 	if (iso_task(p))
 		dequeue_iso_task(p);
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
 static void enqueue_iso_task(struct task_struct *p)
 {
 	runqueue_t *rq = task_rq(p);
-	list_add_tail(&p->iso_list, &rq->iso_queue);
+	list_add_tail(&p->iso_list, rq->iso_queue + p->rt_priority);
+	__set_bit(p->rt_priority, rq->iso_bitmap);
+	rq->iso_active++;
 }
 
 static void enqueue_task(struct task_struct *p, prio_array_t *array)
@@ -638,7 +654,7 @@ static void enqueue_task(struct task_str
 static void requeue_iso_task(struct task_struct *p)
 {
 	runqueue_t *rq = task_rq(p);
-	list_move_tail(&p->iso_list, &rq->iso_queue);
+	list_move_tail(&p->iso_list, rq->iso_queue + p->rt_priority);
 }
 
 /*
@@ -2503,30 +2519,17 @@ void scheduler_tick(void)
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
+			requeue_task(p, rq->active);
 		}
-		if (!p->time_slice)
-			p->time_slice = task_timeslice(p);
 		goto out_unlock;
 	}
 
@@ -2580,30 +2583,46 @@ out:
 
 static inline int iso_ready(runqueue_t *rq)
 {
-	if (iso_queued(rq) && !rq->iso_refractory)
+	if (rq->iso_active && !rq->iso_refractory)
 		return 1;
 	return 0;
 }
 
 /*
- * When a SCHED_ISO task is ready to be scheduled, we re-queue it with an
- * effective prio of MAX_RT_PRIO for userspace to know its relative prio.
+ * When a SCHED_ISO task is ready to be scheduled, we ensure it is queued
+ * on the active array.
  */
 static task_t* queue_iso(runqueue_t *rq, prio_array_t *array)
 {
-	task_t *p = list_entry(rq->iso_queue.next, task_t, iso_list);
-	if (p->prio == MAX_RT_PRIO)
+	prio_array_t *old_array;
+	task_t *p;
+	int idx = find_first_bit(rq->iso_bitmap, MAX_USER_RT_PRIO);
+
+	BUG_ON(idx == MAX_USER_RT_PRIO);
+	p = list_entry(rq->iso_queue[idx].next, task_t, iso_list);
+	if (p->array == rq->active)
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
+		return queue_iso(rq, array);
+	return list_entry(array->queue[idx].next, task_t, run_list);
+}
+
 #ifdef CONFIG_SCHED_SMT
 static inline void wake_sleeping_dependent(int this_cpu, runqueue_t *this_rq)
 {
@@ -2655,7 +2674,7 @@ static inline int dependent_sleeper(int 
 	struct sched_domain *sd = this_rq->sd;
 	cpumask_t sibling_map;
 	prio_array_t *array;
-	int ret = 0, i, idx;
+	int ret = 0, i;
 	task_t *p;
 
 	if (!(sd->flags & SD_SHARE_CPUPOWER))
@@ -2682,11 +2701,7 @@ static inline int dependent_sleeper(int 
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
@@ -2774,10 +2789,9 @@ asmlinkage void __sched schedule(void)
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
@@ -2885,13 +2899,7 @@ go_idle:
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
@@ -3446,6 +3454,10 @@ asmlinkage long sys_nice(int increment)
  */
 int task_prio(const task_t *p)
 {
+	if (iso_task(p))
+		return -(p->rt_priority);
+	if (rt_task(p))
+		return -(MAX_RT_PRIO + p->rt_priority);
 	return p->prio - MAX_RT_PRIO;
 }
 
@@ -3524,28 +3536,36 @@ int sched_setscheduler(struct task_struc
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
@@ -4006,10 +4026,11 @@ asmlinkage long sys_sched_get_priority_m
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
@@ -4030,10 +4051,11 @@ asmlinkage long sys_sched_get_priority_m
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
@@ -5092,7 +5114,7 @@ void __init sched_init(void)
 		rq->active = rq->arrays;
 		rq->expired = rq->arrays + 1;
 		rq->best_expired_prio = MAX_PRIO;
-		rq->iso_refractory = rq->iso_ticks = 0;
+		rq->iso_refractory = rq->iso_ticks = rq->iso_active = 0;
 
 #ifdef CONFIG_SMP
 		rq->sd = &sched_domain_dummy;
@@ -5113,7 +5135,11 @@ void __init sched_init(void)
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

--------------030705020701070000060003--
