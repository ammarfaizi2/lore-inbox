Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbVAWHnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVAWHnh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 02:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVAWHng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 02:43:36 -0500
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:30107 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261251AbVAWHmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 02:42:04 -0500
Message-ID: <41F35520.50405@kolivas.org>
Date: Sun, 23 Jan 2005 18:41:20 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jack O'Quin" <joq@io.com>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Davis <paul@linuxaudiosystems.com>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt scheduling
References: <200501201542.j0KFgOwo019109@localhost.localdomain>	<87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu>	<87wtu6fho8.fsf@sulphur.joq.us> <87y8ekvblj.fsf@sulphur.joq.us>
In-Reply-To: <87y8ekvblj.fsf@sulphur.joq.us>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0C282BD2250BC6B814E7385C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0C282BD2250BC6B814E7385C
Content-Type: multipart/mixed;
 boundary="------------010004060609040808040403"

This is a multi-part message in MIME format.
--------------010004060609040808040403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jack O'Quin wrote:
> I'm wondering now if the lack of priority support in the two
> prototypes might explain the problems I'm seeing.

Distinctly possible since my results got better with priority support. 
However I'm still bugfixing what I've got. Just as a data point here is 
an incremental patch for testing which applies to mm2. This survives
a jackd test run at my end but is not ready for inclusion yet.

Cheers,
Con


--------------010004060609040808040403
Content-Type: text/x-diff;
 name="isoprio3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="isoprio3.diff"

Index: linux-2.6.11-rc1-mm2/include/linux/sched.h
===================================================================
--- linux-2.6.11-rc1-mm2.orig/include/linux/sched.h	2005-01-22 20:42:44.000000000 +1100
+++ linux-2.6.11-rc1-mm2/include/linux/sched.h	2005-01-22 20:50:29.000000000 +1100
@@ -144,6 +144,10 @@ extern int iso_cpu, iso_period;
 #define SCHED_RT(policy)	((policy) == SCHED_FIFO || \
 				(policy) == SCHED_RR)
 
+/* The policies that support a real time priority setting */
+#define SCHED_RT_PRIO(policy)	(SCHED_RT(policy) || \
+				(policy) == SCHED_ISO)
+
 struct sched_param {
 	int sched_priority;
 };
@@ -356,7 +360,7 @@ struct signal_struct {
 /*
  * Priority of a process goes from 0..MAX_PRIO-1, valid RT
  * priority is 0..MAX_RT_PRIO-1, and SCHED_NORMAL tasks are
- * in the range MAX_RT_PRIO..MAX_PRIO-1. Priority values
+ * in the range MIN_NORMAL_PRIO..MAX_PRIO-1. Priority values
  * are inverted: lower p->prio value means higher priority.
  *
  * The MAX_USER_RT_PRIO value allows the actual maximum
@@ -364,12 +368,19 @@ struct signal_struct {
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
+#define ISO_PRIO		MAX_RT_PRIO
+#define MIN_NORMAL_PRIO		(ISO_PRIO + 1)
 
-#define MAX_PRIO		(MAX_RT_PRIO + 40)
+#define MAX_PRIO		(MIN_NORMAL_PRIO + 40)
 
 #define rt_task(p)		(unlikely((p)->prio < MAX_RT_PRIO))
 #define iso_task(p)		(unlikely((p)->policy == SCHED_ISO))
Index: linux-2.6.11-rc1-mm2/kernel/sched.c
===================================================================
--- linux-2.6.11-rc1-mm2.orig/kernel/sched.c	2005-01-22 09:19:42.000000000 +1100
+++ linux-2.6.11-rc1-mm2/kernel/sched.c	2005-01-23 17:38:27.848054361 +1100
@@ -55,11 +55,11 @@
 
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
- * to static priority [ MAX_RT_PRIO..MAX_PRIO-1 ],
+ * to static priority [ MIN_NORMAL_PRIO..MAX_PRIO-1 ],
  * and back.
  */
-#define NICE_TO_PRIO(nice)	(MAX_RT_PRIO + (nice) + 20)
-#define PRIO_TO_NICE(prio)	((prio) - MAX_RT_PRIO - 20)
+#define NICE_TO_PRIO(nice)	(MIN_NORMAL_PRIO + (nice) + 20)
+#define PRIO_TO_NICE(prio)	((prio) - MIN_NORMAL_PRIO - 20)
 #define TASK_NICE(p)		PRIO_TO_NICE((p)->static_prio)
 
 /*
@@ -67,7 +67,7 @@
  * can work with better when scaling various scheduler parameters,
  * it's a [ 0 ... 39 ] range.
  */
-#define USER_PRIO(p)		((p)-MAX_RT_PRIO)
+#define USER_PRIO(p)		((p)-MIN_NORMAL_PRIO)
 #define TASK_USER_PRIO(p)	USER_PRIO((p)->static_prio)
 #define MAX_USER_PRIO		(USER_PRIO(MAX_PRIO))
 
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
@@ -312,15 +316,20 @@ static DEFINE_PER_CPU(struct runqueue, r
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
+		goto check_preemption;
+	if (!rq->iso_refractory) {
+		if (iso_task(p))
+			p_prio = ISO_PRIO;
+		if (iso_task(rq->curr))
+			curr_prio = ISO_PRIO;
 	}
-	if (iso_task(p) && !iso_task(rq->curr))
+check_preemption:
+	if (p_prio < curr_prio)
 		return 1;
 	return 0;
 }
@@ -590,14 +599,13 @@ static inline void sched_info_switch(tas
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
@@ -605,9 +613,9 @@ static inline void dequeue_iso_task(stru
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
@@ -621,7 +629,9 @@ static void dequeue_task(struct task_str
 static void enqueue_iso_task(struct task_struct *p)
 {
 	runqueue_t *rq = task_rq(p);
-	list_add_tail(&p->iso_list, &rq->iso_queue);
+	list_add_tail(&p->iso_list, rq->iso_queue + p->rt_priority);
+	__set_bit(p->rt_priority, rq->iso_bitmap);
+	rq->iso_active++;
 }
 
 static void enqueue_task(struct task_struct *p, prio_array_t *array)
@@ -638,7 +648,7 @@ static void enqueue_task(struct task_str
 static void requeue_iso_task(struct task_struct *p)
 {
 	runqueue_t *rq = task_rq(p);
-	list_move_tail(&p->iso_list, &rq->iso_queue);
+	list_move_tail(&p->iso_list, rq->iso_queue + p->rt_priority);
 }
 
 /*
@@ -684,8 +694,8 @@ static int effective_prio(task_t *p)
 	bonus = CURRENT_BONUS(p) - MAX_BONUS / 2;
 
 	prio = p->static_prio - bonus;
-	if (prio < MAX_RT_PRIO)
-		prio = MAX_RT_PRIO;
+	if (prio < MIN_NORMAL_PRIO)
+		prio = MIN_NORMAL_PRIO;
 	if (prio > MAX_PRIO-1)
 		prio = MAX_PRIO-1;
 	return prio;
@@ -2499,7 +2509,13 @@ void scheduler_tick(void)
 	task_t *p = current;
 
 	rq->timestamp_last_tick = sched_clock();
-	if (iso_task(p) && !rq->iso_refractory)
+	/*
+	 * The iso_ticks accounting is incremented only when a SCHED_ISO task
+	 * is running in soft rt mode. Running rt_tasks are also accounted
+	 * to make the iso_cpu a proportion of cpu available for SCHED_NORMAL
+	 * tasks only.
+	 */
+	if (rt_task(p) || (iso_task(p) && !rq->iso_refractory))
 		inc_iso_ticks(rq, p);
 	else
 		dec_iso_ticks(rq, p);
@@ -2542,24 +2558,12 @@ void scheduler_tick(void)
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
 		if (!(--p->time_slice % GRANULARITY)) {
 			set_tsk_need_resched(p);
 			requeue_iso_task(p);
@@ -2619,30 +2623,46 @@ out:
 
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
+	int idx = sched_find_first_bit(rq->iso_bitmap);
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
@@ -2694,7 +2714,7 @@ static inline int dependent_sleeper(int 
 	struct sched_domain *sd = this_rq->sd;
 	cpumask_t sibling_map;
 	prio_array_t *array;
-	int ret = 0, i, idx;
+	int ret = 0, i;
 	task_t *p;
 
 	if (!(sd->flags & SD_SHARE_CPUPOWER))
@@ -2721,11 +2741,7 @@ static inline int dependent_sleeper(int 
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
@@ -2813,10 +2829,9 @@ asmlinkage void __sched schedule(void)
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
@@ -2924,13 +2939,7 @@ go_idle:
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
@@ -3483,7 +3492,11 @@ asmlinkage long sys_nice(int increment)
  */
 int task_prio(const task_t *p)
 {
-	return p->prio - MAX_RT_PRIO;
+	if (iso_task(p))
+		return -(p->rt_priority);
+	if (rt_task(p))
+		return -(MAX_RT_PRIO + p->rt_priority);
+	return p->prio - MIN_NORMAL_PRIO;
 }
 
 /**
@@ -3552,28 +3565,31 @@ int sched_setscheduler(struct task_struc
 	runqueue_t *rq;
 
 recheck:
+	if (SCHED_RT(policy) && !capable(CAP_SYS_NICE))
+		/*
+		 * If the caller requested an RT policy without having the
+		 * necessary rights, we downgrade the policy to SCHED_ISO.
+		 */
+		policy = SCHED_ISO;
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
@@ -4034,10 +4050,10 @@ asmlinkage long sys_sched_get_priority_m
 	switch (policy) {
 	case SCHED_FIFO:
 	case SCHED_RR:
+	case SCHED_ISO:
 		ret = MAX_USER_RT_PRIO-1;
 		break;
 	case SCHED_NORMAL:
-	case SCHED_ISO:
 		ret = 0;
 		break;
 	}
@@ -4058,10 +4074,10 @@ asmlinkage long sys_sched_get_priority_m
 	switch (policy) {
 	case SCHED_FIFO:
 	case SCHED_RR:
+	case SCHED_ISO:
 		ret = 1;
 		break;
 	case SCHED_NORMAL:
-	case SCHED_ISO:
 		ret = 0;
 	}
 	return ret;
@@ -5120,7 +5136,7 @@ void __init sched_init(void)
 		rq->active = rq->arrays;
 		rq->expired = rq->arrays + 1;
 		rq->best_expired_prio = MAX_PRIO;
-		rq->iso_refractory = rq->iso_ticks = 0;
+		rq->iso_refractory = rq->iso_ticks = rq->iso_active = 0;
 
 #ifdef CONFIG_SMP
 		rq->sd = &sched_domain_dummy;
@@ -5141,7 +5157,11 @@ void __init sched_init(void)
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

--------------010004060609040808040403--

--------------enig0C282BD2250BC6B814E7385C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB81UgZUg7+tp6mRURAlZyAJ9KDcJ/YIl2pZbKsDoNqQSW1l/HcwCgg7pd
yIa3uGNJA5zMG7tx9BrfLdY=
=19aL
-----END PGP SIGNATURE-----

--------------enig0C282BD2250BC6B814E7385C--
