Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbWHTRpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWHTRpv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 13:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbWHTRpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 13:45:51 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:45202 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751057AbWHTRpu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 13:45:50 -0400
Date: Sun, 20 Aug 2006 23:15:22 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@openvz.org>, Mike Galbraith <efault@gmx.de>,
       Balbir Singh <balbir@in.ibm.com>, sekharan@us.ibm.com,
       Andrew Morton <akpm@osdl.org>, nagar@watson.ibm.com,
       matthltc@us.ibm.com, dipankar@in.ibm.com
Subject: [PATCH 4/7] CPU controller V1 - Handle dont care groups
Message-ID: <20060820174522.GE13917@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060820174015.GA13917@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060820174015.GA13917@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Deal with task-groups whose bandwidth hasnt been explicitly set by the
administrator. Unallocated CPU bandwidth is equally distributed among such
"don't care" groups.

Signed-off-by : Srivatsa Vaddagiri <vatsa@in.ibm.com>


 include/linux/sched.h |    2 -
 kernel/sched.c        |   82 ++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 80 insertions(+), 4 deletions(-)

diff -puN kernel/sched.c~cpu_ctlr_handle_dont_cares kernel/sched.c
--- linux-2.6.18-rc3/kernel/sched.c~cpu_ctlr_handle_dont_cares	2006-08-20 21:58:30.000000000 +0530
+++ linux-2.6.18-rc3-root/kernel/sched.c	2006-08-20 21:59:19.000000000 +0530
@@ -229,6 +229,12 @@ static DEFINE_PER_CPU(struct task_grp_rq
 /* task-group object - maintains information about each task-group */
 struct task_grp {
 	int ticks;			 /* bandwidth given to the task-group */
+	int left_over_pct;
+	int total_dont_care_grps;
+	int dont_care;          /* Does this group care for its bandwidth ? */
+	struct task_grp *parent;
+	struct list_head dont_care_list;
+	struct list_head list;
 	struct task_grp_rq *rq[NR_CPUS]; /* runqueue pointer for every cpu */
 };
 
@@ -6915,6 +6921,12 @@ void __init sched_init(void)
 	int i, j, k;
 
 	init_task_grp.ticks = -1;     /* Unlimited bandwidth */
+	init_task_grp.left_over_pct = 100;  /* 100% unallocated bandwidth */
+	init_task_grp.parent = NULL;
+	init_task_grp.total_dont_care_grps = 1;	/* init_task_grp itself */
+	init_task_grp.dont_care = 1;
+	INIT_LIST_HEAD(&init_task_grp.dont_care_list);
+	list_add_tail(&init_task_grp.list, &init_task_grp.dont_care_list);
 
 	for_each_possible_cpu(i) {
 		struct prio_array *array;
@@ -7069,8 +7081,31 @@ void set_curr_task(int cpu, struct task_
 
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
+	ticks = ((tg_root->left_over_pct /
+			 tg_root->total_dont_care_grps) * 5 * HZ) / 100;
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
@@ -7081,6 +7116,11 @@ void *sched_alloc_group(void)
 		return NULL;
 
 	tg->ticks = -1;		/* No limit */
+	tg->parent = tg_parent;
+	tg->dont_care = 1;
+	tg->left_over_pct = 100;
+	tg->ticks = -1;		/* No limit */
+	INIT_LIST_HEAD(&tg->dont_care_list);
 
 	for_each_possible_cpu(i) {
 		tgrq = kzalloc(sizeof(*tgrq), GFP_KERNEL);
@@ -7090,6 +7130,15 @@ void *sched_alloc_group(void)
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
@@ -7103,6 +7152,16 @@ oom:
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
@@ -7113,7 +7172,20 @@ void sched_dealloc_group(struct task_grp
 /* Assign quota to this group */
 void sched_assign_quota(struct task_grp *tg, int quota)
 {
-	int i;
+	int i, old_quota = 0;
+	struct task_grp *tg_root = tg->parent;
+
+	if (!tg_root)
+		tg_root = tg;
+
+	if (tg->dont_care) {
+		tg->dont_care = 0;
+		tg_root->total_dont_care_grps--;
+		list_del(&tg->list);
+	} else
+		old_quota = (tg->ticks * 100) / (5 * HZ);
+
+	tg_root->left_over_pct -= (quota - old_quota);
 
 	/* xxx: check validity of quota */
 	tg->ticks = (quota * 5 * HZ) / 100;
@@ -7121,6 +7193,7 @@ void sched_assign_quota(struct task_grp 
 	for_each_possible_cpu(i)
 		tg->rq[i]->ticks = tg->ticks;
 
+	recalc_dontcare(tg_root);
 }
 
 static inline int cpu_quota(struct task_grp *tg)
@@ -7138,7 +7211,10 @@ static inline int cpu_quota(struct task_
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
--- linux-2.6.18-rc3/include/linux/sched.h~cpu_ctlr_handle_dont_cares	2006-08-20 21:58:30.000000000 +0530
+++ linux-2.6.18-rc3-root/include/linux/sched.h	2006-08-20 21:58:30.000000000 +0530
@@ -1608,7 +1608,7 @@ static inline int try_to_freeze(void) { 
 #ifdef CONFIG_CPUMETER
 struct task_grp;
 struct task_grp_ops {
-	void *(*alloc_group)(void);
+	void *(*alloc_group)(struct task_grp *grp_parent);
 	void (*dealloc_group)(struct task_grp *grp);
 	void (*assign_quota)(struct task_grp *grp, int quota);
 	int (*pre_move_task)(struct task_struct *tsk, struct task_grp *old,

_
-- 
Regards,
vatsa
