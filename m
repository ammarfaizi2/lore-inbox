Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751403AbWHDFG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbWHDFG4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWHDFG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:06:56 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:39306 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751403AbWHDFGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:06:55 -0400
Date: Fri, 4 Aug 2006 10:41:21 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@openvz.org>, Mike Galbraith <efault@gmx.de>,
       Balbir Singh <balbir@in.ibm.com>, sekharan@us.ibm.com,
       Andrew Morton <akpm@osdl.org>, nagar@watson.ibm.com,
       haveblue@us.ibm.com, pj@sgi.com
Subject: [ RFC, PATCH 3/5 ] CPU controller - deal with movement of tasks
Message-ID: <20060804051121.GG27194@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060804050753.GD27194@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060804050753.GD27194@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When a task moves between groups (as initiated by an administrator), it has to
be removed from the runqueue of its old group and added to the runqueue of the
new group. This patch defines this move operation.

Also during this move operation identity of a task can be ambiguous, since
identity is usually derived from some pointer in the task_struct. The pointer 
can point to either the old group or new group and not both! Hence 
pass explicitly into de(en)queue_task() functions the task-group runqueue from 
which the task is being removed and added to respectively.


Signed-off-by : Srivatsa Vaddagiri <vatsa@in.ibm.com>



 include/linux/sched.h |    1 
 kernel/sched.c        |   90 ++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 66 insertions(+), 25 deletions(-)

diff -puN kernel/sched.c~cpu_ctlr_move_task kernel/sched.c
--- linux-2.6.18-rc3/kernel/sched.c~cpu_ctlr_move_task	2006-08-04 07:59:08.000000000 +0530
+++ linux-2.6.18-rc3-root/kernel/sched.c	2006-08-04 08:09:15.000000000 +0530
@@ -755,15 +755,14 @@ static inline void update_task_grp_prio(
 /*
  * Adding/removing a task to/from a priority array:
  */
-static void dequeue_task(struct task_struct *p, struct prio_array *array)
+static void dequeue_task(struct task_struct *p, struct prio_array *array,
+				struct task_grp_rq *tgrq)
 {
 	array->nr_active--;
 	list_del(&p->run_list);
 	if (list_empty(array->queue + p->prio)) {
 		__clear_bit(p->prio, array->bitmap);
 		if (p->prio == array->best_dyn_prio) {
-			struct task_grp_rq *tgrq = task_grp(p)->rq[task_cpu(p)];
-
 			array->best_dyn_prio =
 					sched_find_first_bit(array->bitmap);
 			if (array == tgrq->active || !tgrq->active->nr_active)
@@ -772,7 +771,8 @@ static void dequeue_task(struct task_str
 	}
 }
 
-static void enqueue_task(struct task_struct *p, struct prio_array *array)
+static void enqueue_task(struct task_struct *p, struct prio_array *array,
+				struct task_grp_rq *tgrq)
 {
 	sched_info_queued(p);
 	list_add_tail(&p->run_list, array->queue + p->prio);
@@ -781,8 +781,6 @@ static void enqueue_task(struct task_str
 	p->array = array;
 
 	if (p->prio < array->best_dyn_prio) {
-		struct task_grp_rq *tgrq = task_grp(p)->rq[task_cpu(p)];
-
 		array->best_dyn_prio = p->prio;
 		if (array == tgrq->active || !tgrq->active->nr_active)
 			update_task_grp_prio(tgrq, task_rq(p), 0);
@@ -799,7 +797,8 @@ static void requeue_task(struct task_str
 }
 
 static inline void
-enqueue_task_head(struct task_struct *p, struct prio_array *array)
+enqueue_task_head(struct task_struct *p, struct prio_array *array,
+				struct task_grp_rq *tgrq)
 {
 	list_add(&p->run_list, array->queue + p->prio);
 	__set_bit(p->prio, array->bitmap);
@@ -807,8 +806,6 @@ enqueue_task_head(struct task_struct *p,
 	p->array = array;
 
 	if (p->prio < array->best_dyn_prio) {
-		struct task_grp_rq *tgrq = task_grp(p)->rq[task_cpu(p)];
-
 		array->best_dyn_prio = p->prio;
 		if (array == tgrq->active || !tgrq->active->nr_active)
 			update_task_grp_prio(tgrq, task_rq(p), 1);
@@ -956,7 +953,7 @@ static void __activate_task(struct task_
 
 	if (batch_task(p))
 		target = tgrq->expired;
-	enqueue_task(p, target);
+	enqueue_task(p, target, tgrq);
 	inc_nr_running(p, rq);
 }
 
@@ -968,7 +965,7 @@ static inline void __activate_idle_task(
 	struct task_grp_rq *tgrq = task_grp(p)->rq[task_cpu(p)];
 	struct prio_array *target = tgrq->active;
 
-	enqueue_task_head(p, target);
+	enqueue_task_head(p, target, tgrq);
 	inc_nr_running(p, rq);
 }
 
@@ -1097,8 +1094,10 @@ static void activate_task(struct task_st
  */
 static void deactivate_task(struct task_struct *p, struct rq *rq)
 {
+	struct task_grp_rq *tgrq = task_grp(p)->rq[task_cpu(p)];
+
 	dec_nr_running(p, rq);
-	dequeue_task(p, p->array);
+	dequeue_task(p, p->array, tgrq);
 	p->array = NULL;
 }
 
@@ -2151,11 +2150,15 @@ static void pull_task(struct rq *src_rq,
 		      struct task_struct *p, struct rq *this_rq,
 		      struct prio_array *this_array, int this_cpu)
 {
-	dequeue_task(p, src_array);
+	struct task_grp_rq *tgrq;
+       
+	tgrq = task_grp(p)->rq[task_cpu(p)];
+	dequeue_task(p, src_array, tgrq);
 	dec_nr_running(p, src_rq);
 	set_task_cpu(p, this_cpu);
 	inc_nr_running(p, this_rq);
-	enqueue_task(p, this_array);
+	tgrq = task_grp(p)->rq[task_cpu(p)];
+	enqueue_task(p, this_array, tgrq);
 	p->timestamp = (p->timestamp - src_rq->timestamp_last_tick)
 				+ this_rq->timestamp_last_tick;
 	/*
@@ -3159,7 +3162,7 @@ void scheduler_tick(void)
 		goto out_unlock;
 	}
 	if (!--p->time_slice) {
-		dequeue_task(p, tgrq->active);
+		dequeue_task(p, tgrq->active, tgrq);
 		set_tsk_need_resched(p);
 		p->prio = effective_prio(p);
 		p->time_slice = task_timeslice(p);
@@ -3168,12 +3171,12 @@ void scheduler_tick(void)
 		if (!tgrq->expired_timestamp)
 			tgrq->expired_timestamp = jiffies;
 		if (!TASK_INTERACTIVE(p) || expired_starving(tgrq)) {
-			enqueue_task(p, tgrq->expired);
+			enqueue_task(p, tgrq->expired, tgrq);
 			if (p->static_prio < tgrq->expired->best_static_prio)
 				tgrq->expired->best_static_prio =
 							 p->static_prio;
 		} else
-			enqueue_task(p, tgrq->active);
+			enqueue_task(p, tgrq->active, tgrq);
 	} else {
 		/*
 		 * Prevent a too long timeslice allowing a task to monopolize
@@ -3523,9 +3526,11 @@ need_resched_nonpreemptible:
 		new_prio = recalc_task_prio(next, next->timestamp + delta);
 
 		if (unlikely(next->prio != new_prio)) {
-			dequeue_task(next, array);
+			struct task_grp_rq *tgrq =
+			       		task_grp(next)->rq[task_cpu(next)];
+			dequeue_task(next, array, tgrq);
 			next->prio = new_prio;
-			enqueue_task(next, array);
+			enqueue_task(next, array, tgrq);
 		}
 	}
 	next->sleep_type = SLEEP_NORMAL;
@@ -3982,16 +3987,18 @@ void rt_mutex_setprio(struct task_struct
 	struct prio_array *array;
 	unsigned long flags;
 	struct rq *rq;
+	struct task_grp_rq *tgrq;
 	int oldprio;
 
 	BUG_ON(prio < 0 || prio > MAX_PRIO);
 
 	rq = task_rq_lock(p, &flags);
+	tgrq = task_grp(p)->rq[task_cpu(p)];
 
 	oldprio = p->prio;
 	array = p->array;
 	if (array)
-		dequeue_task(p, array);
+		dequeue_task(p, array, tgrq);
 	p->prio = prio;
 
 	if (array) {
@@ -4001,7 +4008,7 @@ void rt_mutex_setprio(struct task_struct
 		 */
 		if (rt_task(p))
 			array = rq->active;
-		enqueue_task(p, array);
+		enqueue_task(p, array, tgrq);
 		/*
 		 * Reschedule if we are currently running on this runqueue and
 		 * our priority decreased, or if we are not currently running on
@@ -4024,6 +4031,7 @@ void set_user_nice(struct task_struct *p
 	int old_prio, delta;
 	unsigned long flags;
 	struct rq *rq;
+	struct task_grp_rq *tgrq;
 
 	if (TASK_NICE(p) == nice || nice < -20 || nice > 19)
 		return;
@@ -4032,6 +4040,8 @@ void set_user_nice(struct task_struct *p
 	 * the task might be in the middle of scheduling on another CPU.
 	 */
 	rq = task_rq_lock(p, &flags);
+	tgrq = task_grp(p)->rq[task_cpu(p)];
+
 	/*
 	 * The RT priorities are set via sched_setscheduler(), but we still
 	 * allow the 'normal' nice value to be set - but as expected
@@ -4044,7 +4054,7 @@ void set_user_nice(struct task_struct *p
 	}
 	array = p->array;
 	if (array) {
-		dequeue_task(p, array);
+		dequeue_task(p, array, tgrq);
 		dec_raw_weighted_load(rq, p);
 	}
 
@@ -4055,7 +4065,7 @@ void set_user_nice(struct task_struct *p
 	delta = p->prio - old_prio;
 
 	if (array) {
-		enqueue_task(p, array);
+		enqueue_task(p, array, tgrq);
 		inc_raw_weighted_load(rq, p);
 		/*
 		 * If the task increased its priority or is running and
@@ -4591,8 +4601,8 @@ asmlinkage long sys_sched_yield(void)
 		schedstat_inc(rq, yld_exp_empty);
 
 	if (array != target) {
-		dequeue_task(current, array);
-		enqueue_task(current, target);
+		dequeue_task(current, array, tgrq);
+		enqueue_task(current, target, tgrq);
 	} else
 		/*
 		 * requeue_task is cheaper so perform that if possible.
@@ -7132,10 +7142,40 @@ int sched_get_quota(void *grp)
 	return quota;
 }
 
+/* Move a task from one task_grp_rq to another */
+void sched_move_task(struct task_struct *tsk, void *grp_old, void *grp_new)
+{
+	struct rq *rq;
+	unsigned long flags;
+	struct task_grp *tg_old = (struct task_grp *)grp_old,
+			*tg_new = (struct task_grp *)grp_new;
+	struct task_grp_rq *tgrq;
+
+	if (tg_new == tg_old)
+		return;
+
+	if (!tg_new)
+		tg_new = &init_task_grp;
+	if (!tg_old)
+		tg_old = &init_task_grp;
+
+	rq = task_rq_lock(tsk, &flags);
+
+	if (tsk->array) {
+		tgrq = tg_old->rq[task_cpu(tsk)];
+		dequeue_task(tsk, tsk->array, tgrq);
+		tgrq = tg_new->rq[task_cpu(tsk)];
+		enqueue_task(tsk, tg_new->rq[task_cpu(tsk)]->active, tgrq);
+	}
+
+	task_rq_unlock(rq, &flags);
+}
+
 static struct task_grp_ops sched_grp_ops = {
 	.alloc_group = sched_alloc_group,
 	.dealloc_group = sched_dealloc_group,
 	.assign_quota = sched_assign_quota,
+	.move_task = sched_move_task,
 	.get_quota = sched_get_quota,
 };
 
diff -puN include/linux/sched.h~cpu_ctlr_move_task include/linux/sched.h
--- linux-2.6.18-rc3/include/linux/sched.h~cpu_ctlr_move_task	2006-08-04 08:09:27.000000000 +0530
+++ linux-2.6.18-rc3-root/include/linux/sched.h	2006-08-04 08:09:41.000000000 +0530
@@ -1610,6 +1610,7 @@ struct task_grp_ops {
 	void *(*alloc_group)(void);
 	void (*dealloc_group)(void *grp);
 	void (*assign_quota)(void *grp, int quota);
+	void (*move_task)(struct task_struct *tsk, void *old, void *new);
 	int (*get_quota)(void *grp);
 };
 

_
-- 
Regards,
vatsa
-- 
Regards,
vatsa
