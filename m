Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030265AbWI1RcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbWI1RcO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 13:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030267AbWI1RcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 13:32:14 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:62598 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030265AbWI1RcM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 13:32:12 -0400
Date: Thu, 28 Sep 2006 23:02:02 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, Kirill Korotaev <dev@openvz.org>,
       Mike Galbraith <efault@gmx.de>, Balbir Singh <balbir@in.ibm.com>,
       sekharan@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, matthltc@us.ibm.com, dipankar@in.ibm.com,
       ckrm-tech@lists.sourceforge.net
Subject: [RFC, PATCH 6/9] CPU Controller V2 - Handle dont care groups
Message-ID: <20060928173202.GG8746@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060928172520.GA8746@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060928172520.GA8746@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Deal with task-groups whose bandwidth hasnt been explicitly set by the
administrator. Unallocated CPU bandwidth is equally distributed among such
"don't care" groups.

Signed-off-by : Srivatsa Vaddagiri <vatsa@in.ibm.com>

---

 linux-2.6.18-root/include/linux/sched.h |    2 
 linux-2.6.18-root/kernel/sched.c        |   92 ++++++++++++++++++++++++++++++--
 2 files changed, 88 insertions(+), 6 deletions(-)

diff -puN kernel/sched.c~cpu_ctlr_handle_dont_cares kernel/sched.c
--- linux-2.6.18/kernel/sched.c~cpu_ctlr_handle_dont_cares	2006-09-28 16:40:28.772666712 +0530
+++ linux-2.6.18-root/kernel/sched.c	2006-09-28 17:23:16.989238448 +0530
@@ -226,6 +226,12 @@ static DEFINE_PER_CPU(struct task_grp_rq
 /* task-group object - maintains information about each task-group */
 struct task_grp {
 	unsigned short ticks, long_ticks; /* bandwidth given to task-group */
+ 	int left_over_pct;
+ 	int total_dont_care_grps;
+ 	int dont_care;          /* Does this group care for its bandwidth ? */
+ 	struct task_grp *parent;
+ 	struct list_head dont_care_list;
+ 	struct list_head list;
 	struct task_grp_rq *rq[NR_CPUS]; /* runqueue pointer for every cpu */
 };
 
@@ -7031,6 +7037,12 @@ void __init sched_init(void)
 
 	init_task_grp.ticks = CPU_CONTROL_SHORT_WINDOW;   /* 100% bandwidth */
 	init_task_grp.long_ticks = NUM_LONG_TICKS;
+ 	init_task_grp.left_over_pct = 100;  /* 100% unallocated bandwidth */
+ 	init_task_grp.parent = NULL;
+ 	init_task_grp.total_dont_care_grps = 1;	/* init_task_grp itself */
+ 	init_task_grp.dont_care = 1;
+ 	INIT_LIST_HEAD(&init_task_grp.dont_care_list);
+	list_add_tail(&init_task_grp.list, &init_task_grp.dont_care_list);
 
 	for_each_possible_cpu(i) {
 		struct rq *rq;
@@ -7195,8 +7207,31 @@ void set_curr_task(int cpu, struct task_
 
 #ifdef CONFIG_CPUMETER
 
+/* Distribute left over bandwidth equally to all "dont care" task groups */
+static void recalc_dontcare(struct task_grp *tg_root)
+{
+	int ticks;
+	struct list_head *entry;
+
+	if (!tg_root->total_dont_care_grps)
+		return;
+
+	ticks = ((tg_root->left_over_pct / tg_root->total_dont_care_grps) *
+		       				CPU_CONTROL_SHORT_WINDOW) / 100;
+
+	list_for_each(entry, &tg_root->dont_care_list) {
+		struct task_grp *tg;
+		int i;
+
+		tg = list_entry(entry, struct task_grp, list);
+		tg->ticks = ticks;
+		for_each_possible_cpu(i)
+			tg->rq[i]->ticks = tg->ticks;
+	}
+}
+
 /* Allocate runqueue structures for the new task-group */
-void *sched_alloc_group(void)
+void *sched_alloc_group(struct task_grp *tg_parent)
 {
 	struct task_grp *tg;
 	struct task_grp_rq *tgrq;
@@ -7208,6 +7243,10 @@ void *sched_alloc_group(void)
 
 	tg->ticks = CPU_CONTROL_SHORT_WINDOW;
 	tg->long_ticks = NUM_LONG_TICKS;
+	tg->parent = tg_parent;
+	tg->dont_care = 1;
+	tg->left_over_pct = 100;
+	INIT_LIST_HEAD(&tg->dont_care_list);
 
 	for_each_possible_cpu(i) {
 		tgrq = kzalloc(sizeof(*tgrq), GFP_KERNEL);
@@ -7217,6 +7256,15 @@ void *sched_alloc_group(void)
 		task_grp_rq_init(tgrq, tg);
 	}
 
+	if (tg->parent) {
+		tg->parent->total_dont_care_grps++;
+		list_add_tail(&tg->list, &tg->parent->dont_care_list);
+		recalc_dontcare(tg->parent);
+	} else {
+		tg->total_dont_care_grps = 1;
+		list_add_tail(&tg->list, &tg->dont_care_list);
+	}
+
 	return tg;
 oom:
 	while (i--)
@@ -7230,6 +7278,16 @@ oom:
 void sched_dealloc_group(struct task_grp *tg)
 {
 	int i;
+	struct task_grp *tg_root = tg->parent;
+
+	if (!tg_root)
+		tg_root = tg;
+
+	if (tg->dont_care) {
+		tg_root->total_dont_care_grps--;
+		list_del(&tg->list);
+		recalc_dontcare(tg_root);
+	}
 
 	for_each_possible_cpu(i)
 		kfree(tg->rq[i]);
@@ -7240,12 +7298,33 @@ void sched_dealloc_group(struct task_grp
 /* Assign quota to this group */
 int sched_assign_quota(struct task_grp *tg, int quota)
 {
-	int i;
+	int i, old_quota = 0;
+	struct task_grp *tg_root = tg->parent;
+
+	if (!tg_root)
+		tg_root = tg;
+
+	if (!tg->dont_care)
+		old_quota = (tg->ticks * 100) / CPU_CONTROL_SHORT_WINDOW;
+
+	if (quota > (tg_root->left_over_pct - old_quota))
+		return -EINVAL;
+
+	if (tg->dont_care) {
+		tg->dont_care = 0;
+		tg_root->total_dont_care_grps--;
+		list_del(&tg->list);
+	}
 
 	tg->ticks = (quota * CPU_CONTROL_SHORT_WINDOW) / 100;
+	for_each_possible_cpu(i) {
+  		tg->rq[i]->ticks = tg->ticks;
+		tg->rq[i]->long_ticks = tg->long_ticks;
+	}
 
-	for_each_possible_cpu(i)
-		tg->rq[i]->ticks = tg->ticks;
+	/* xxx: needs some locking */
+	tg_root->left_over_pct -= (quota - old_quota);
+	recalc_dontcare(tg_root);
 
 	return 0;
 }
@@ -7258,7 +7337,10 @@ static inline int cpu_quota(struct task_
 /* Return assigned quota for this group */
 int sched_get_quota(struct task_grp *tg)
 {
-	return cpu_quota(tg);
+	if (tg->dont_care)
+		return 0;
+	else
+		return cpu_quota(tg);
 }
 
 /*
diff -puN include/linux/sched.h~cpu_ctlr_handle_dont_cares include/linux/sched.h
--- linux-2.6.18/include/linux/sched.h~cpu_ctlr_handle_dont_cares	2006-09-28 16:40:28.777665952 +0530
+++ linux-2.6.18-root/include/linux/sched.h	2006-09-28 16:40:28.801662304 +0530
@@ -1615,7 +1615,7 @@ static inline int try_to_freeze(void) { 
 #ifdef CONFIG_CPUMETER
 struct task_grp;
 struct task_grp_ops {
-	void *(*alloc_group)(void);
+	void *(*alloc_group)(struct task_grp *grp_parent);
 	void (*dealloc_group)(struct task_grp *grp);
 	int (*assign_quota)(struct task_grp *grp, int quota);
 	int (*pre_move_task)(struct task_struct *tsk, unsigned long *,
_
-- 
Regards,
vatsa
