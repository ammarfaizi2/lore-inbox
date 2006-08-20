Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbWHTRrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbWHTRrb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 13:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWHTRra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 13:47:30 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:17567 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751070AbWHTRr1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 13:47:27 -0400
Date: Sun, 20 Aug 2006 23:16:13 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@openvz.org>, Mike Galbraith <efault@gmx.de>,
       Balbir Singh <balbir@in.ibm.com>, sekharan@us.ibm.com,
       Andrew Morton <akpm@osdl.org>, nagar@watson.ibm.com,
       matthltc@us.ibm.com, dipankar@in.ibm.com
Subject: [PATCH 5/7] CPU controller V1 - Extend smpnice to be task-group aware
Message-ID: <20060820174613.GF13917@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060820174015.GA13917@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060820174015.GA13917@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch extends the smpnice mechanism to be aware of task-groups and the
quota given to each task-group.

Signed-off-by : Srivatsa Vaddagiri <vatsa@in.ibm.com>


 kernel/sched.c |  127 +++++++++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 96 insertions(+), 31 deletions(-)

diff -puN kernel/sched.c~cpu_ctlr_smp_nice kernel/sched.c
--- linux-2.6.18-rc3/kernel/sched.c~cpu_ctlr_smp_nice	2006-08-20 22:03:42.000000000 +0530
+++ linux-2.6.18-rc3-root/kernel/sched.c	2006-08-20 22:03:42.000000000 +0530
@@ -874,6 +874,25 @@ static inline int __normal_prio(struct t
 #define RTPRIO_TO_LOAD_WEIGHT(rp) \
 	(PRIO_TO_LOAD_WEIGHT(MAX_RT_PRIO) + LOAD_WEIGHT(rp))
 
+#ifdef CONFIG_CPUMETER
+
+static inline int cpu_quota(struct task_grp *tg)
+{
+	int val;
+
+	if (tg->ticks == -1)
+		val = 100;
+	else
+		val = (tg->ticks * 100) / (5 * HZ);
+
+	return val;
+}
+
+#define TASK_GROUP_QUOTA(p)    cpu_quota(task_grp(p)) / 100
+#else
+#define TASK_GROUP_QUOTA(p)    1
+#endif
+
 static void set_load_weight(struct task_struct *p)
 {
 	if (has_rt_policy(p)) {
@@ -887,9 +906,11 @@ static void set_load_weight(struct task_
 			p->load_weight = 0;
 		else
 #endif
-			p->load_weight = RTPRIO_TO_LOAD_WEIGHT(p->rt_priority);
+			p->load_weight = RTPRIO_TO_LOAD_WEIGHT(p->rt_priority)
+						* TASK_GROUP_QUOTA(p);
 	} else
-		p->load_weight = PRIO_TO_LOAD_WEIGHT(p->static_prio);
+		p->load_weight = PRIO_TO_LOAD_WEIGHT(p->static_prio)
+						* TASK_GROUP_QUOTA(p);
 }
 
 static inline void
@@ -2209,7 +2230,8 @@ int can_migrate_task(struct task_struct 
 	return 1;
 }
 
-#define rq_best_prio(rq) min((rq)->curr->prio, (rq)->expired->best_static_prio)
+#define rq_best_prio(rq) min((rq)->active->best_dyn_prio, \
+			     (rq)->expired->best_static_prio)
 
 /*
  * move_tasks tries to move up to max_nr_move tasks and max_load_move weighted
@@ -2218,17 +2240,17 @@ int can_migrate_task(struct task_struct 
  *
  * Called with both runqueues locked.
  */
-static int move_tasks(struct rq *this_rq, int this_cpu, struct rq *busiest,
-		      unsigned long max_nr_move, unsigned long max_load_move,
-		      struct sched_domain *sd, enum idle_type idle,
-		      int *all_pinned)
+static int __move_tasks(struct task_grp_rq *this_rq, int this_cpu,
+			struct task_grp_rq *busiest, unsigned long max_nr_move,
+			unsigned long max_load_move, struct sched_domain *sd,
+			enum idle_type idle, int *all_pinned, long *load_moved)
 {
 	int idx, pulled = 0, pinned = 0, this_best_prio, best_prio,
-	    best_prio_seen, skip_for_load;
+	    best_prio_seen = 0, skip_for_load;
 	struct prio_array *array, *dst_array;
 	struct list_head *head, *curr;
 	struct task_struct *tmp;
-	long rem_load_move;
+	long rem_load_move = 0;
 
 	if (max_nr_move == 0 || max_load_move == 0)
 		goto out;
@@ -2237,14 +2259,6 @@ static int move_tasks(struct rq *this_rq
 	pinned = 1;
 	this_best_prio = rq_best_prio(this_rq);
 	best_prio = rq_best_prio(busiest);
-	/*
-	 * Enable handling of the case where there is more than one task
-	 * with the best priority.   If the current running task is one
-	 * of those with prio==best_prio we know it won't be moved
-	 * and therefore it's safe to override the skip (based on load) of
-	 * any task we find with that prio.
-	 */
-	best_prio_seen = best_prio == busiest->curr->prio;
 
 	/*
 	 * We first consider expired tasks. Those will likely not be
@@ -2293,7 +2307,7 @@ skip_queue:
 	if (skip_for_load && idx < this_best_prio)
 		skip_for_load = !best_prio_seen && idx == best_prio;
 	if (skip_for_load ||
-	    !can_migrate_task(tmp, busiest, this_cpu, sd, idle, &pinned)) {
+	    !can_migrate_task(tmp, task_rq(tmp), this_cpu, sd, idle, &pinned)) {
 
 		best_prio_seen |= idx == best_prio;
 		if (curr != head)
@@ -2307,7 +2321,8 @@ skip_queue:
 		schedstat_inc(sd, lb_hot_gained[idle]);
 #endif
 
-	pull_task(busiest, array, tmp, this_rq, dst_array, this_cpu);
+	pull_task(task_rq(tmp), array, tmp, cpu_rq(this_cpu), dst_array,
+		       						this_cpu);
 	pulled++;
 	rem_load_move -= tmp->load_weight;
 
@@ -2333,9 +2348,70 @@ out:
 
 	if (all_pinned)
 		*all_pinned = pinned;
+	*load_moved = max_load_move - rem_load_move;
 	return pulled;
 }
 
+static int move_tasks(struct rq *this_rq, int this_cpu, struct rq *busiest,
+		      unsigned long max_nr_move, unsigned long max_load_move,
+		      struct sched_domain *sd, enum idle_type idle,
+		      int *all_pinned)
+{
+	int idx;
+	long load_moved;
+	unsigned long total_nr_moved = 0, nr_moved;
+	struct prio_array *array;
+	struct task_grp_rq *busy_q, *this_q;
+	struct list_head *head, *curr;
+
+	if (busiest->expired->nr_active)
+		array = busiest->expired;
+	else
+		array = busiest->active;
+
+new_array:
+	/* Start searching at priority 0: */
+	idx = 0;
+skip_bitmap:
+	if (!idx)
+		idx = sched_find_first_bit(array->bitmap);
+	else
+		idx = find_next_bit(array->bitmap, MAX_PRIO, idx);
+	if (idx >= MAX_PRIO) {
+		if (array == busiest->expired && busiest->active->nr_active) {
+			array = busiest->active;
+			goto new_array;
+		}
+		goto out;
+	}
+
+	head = array->queue + idx;
+	curr = head->prev;
+skip_queue:
+	busy_q = list_entry(curr, struct task_grp_rq, list);
+	this_q = busy_q->tg->rq[this_cpu];
+
+	curr = curr->prev;
+
+	nr_moved = __move_tasks(this_q, this_cpu, busy_q, max_nr_move,
+			max_load_move, sd, idle, all_pinned, &load_moved);
+
+	total_nr_moved += nr_moved;
+	max_nr_move -= nr_moved;
+	max_load_move -= load_moved;
+
+	BUG_ON(max_load_move < 0);
+	BUG_ON(max_nr_move < 0);
+
+	if (curr != head)
+		goto skip_queue;
+	idx++;
+	goto skip_bitmap;
+
+out:
+	return total_nr_moved;
+}
+
 /*
  * find_busiest_group finds and returns the busiest CPU group within the
  * domain. It calculates and returns the amount of weighted load which
@@ -7196,18 +7272,6 @@ void sched_assign_quota(struct task_grp 
 	recalc_dontcare(tg_root);
 }
 
-static inline int cpu_quota(struct task_grp *tg)
-{
-	int val;
-
-	if (tg->ticks == -1)
-		val = 100;
-	else
-		val = (tg->ticks * 100) / (5 * HZ);
-
-	return val;
-}
-
 /* Return assigned quota for this group */
 int sched_get_quota(struct task_grp *tg)
 {
@@ -7273,6 +7337,7 @@ void sched_post_move_task(struct task_st
 {
 	struct rq *rq = task_rq(tsk);
 
+	set_load_weight(tsk);
 	__activate_task(tsk, rq);
 
 	task_rq_unlock(rq, &irq_flags);

_
-- 
Regards,
vatsa
