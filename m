Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbWHTRpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbWHTRpM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 13:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbWHTRpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 13:45:12 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:30096 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751047AbWHTRpK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 13:45:10 -0400
Date: Sun, 20 Aug 2006 23:14:42 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@openvz.org>, Mike Galbraith <efault@gmx.de>,
       Balbir Singh <balbir@in.ibm.com>, sekharan@us.ibm.com,
       Andrew Morton <akpm@osdl.org>, nagar@watson.ibm.com,
       matthltc@us.ibm.com, dipankar@in.ibm.com
Subject: [PATCH 3/7] CPU controller V1 - deal with movement of tasks
Message-ID: <20060820174442.GD13917@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060820174015.GA13917@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060820174015.GA13917@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When a task moves between groups (as initiated by an administrator), it has to
be removed from the runqueue of its old group and added to the runqueue of its
new group. This patch defines this move operation.

Signed-off-by : Srivatsa Vaddagiri <vatsa@in.ibm.com>



 include/linux/sched.h |    3 ++
 kernel/sched.c        |   63 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff -puN kernel/sched.c~cpu_ctlr_move_task kernel/sched.c
--- linux-2.6.18-rc3/kernel/sched.c~cpu_ctlr_move_task	2006-08-20 21:56:09.000000000 +0530
+++ linux-2.6.18-rc3-root/kernel/sched.c	2006-08-20 21:57:36.000000000 +0530
@@ -7141,10 +7141,73 @@ int sched_get_quota(struct task_grp *tg)
 	return cpu_quota(tg);
 }
 
+/*
+ * Move a task from one group to another. If the task is already on a
+ * runqueue, this involves removing the task from its old group's runqueue
+ * and adding to its new group's runqueue.
+ *
+ * This however is slightly tricky, given the facts that:
+ *
+ *	- some pointer in the task struct (ex: cpuset) represents the group
+ *  	  to which it belongs.
+ * 	- At any give point during the move operation, the pointer either
+ * 	  points to the old group or to the new group, but not both!
+ *	- dequeue_task/enqueue_task rely on this pointer to know which
+ * 	  task_grp_rq the task is to be removed from/added to.
+ *
+ * Hence the dequeue_task/enqueue_task is accomplished in two steps.
+ *
+ *	1. In first step, sched_pre_move_task() is called with the group
+ * 	   pointer set to the old group to which the task belonged.
+ * 	   If the task was on a runqueue, sched_pre_move_task() merely
+ * 	   removes it from the runqueue and returns 1 back to its
+ *	   caller indicating that step 2 is necessary.
+ *
+ * 	2. In second step, sched_post_move_task() is called with the group
+ *	   pointer set to the new group to which the task belongs.
+ *	   sched_post_move_task() merely invokes __activate_task() to add the
+ *	   task in its new runqueue.
+ * 
+ */
+
+static unsigned long irq_flags;
+
+int sched_pre_move_task(struct task_struct *tsk, struct task_grp *tg_old,
+	       					struct task_grp *tg_new)
+{
+	int activate = 0;
+	struct rq *rq;
+
+	if (tg_new == tg_old)
+		return 0;
+
+	rq = task_rq_lock(tsk, &irq_flags);
+
+	if (tsk->array) {
+		deactivate_task(tsk, rq);
+		activate = 1;
+	} else
+		task_rq_unlock(rq, &irq_flags);
+
+	return activate;
+}
+
+/* called with rq lock held */
+void sched_post_move_task(struct task_struct *tsk)
+{
+	struct rq *rq = task_rq(tsk);
+
+	__activate_task(tsk, rq);
+
+	task_rq_unlock(rq, &irq_flags);
+}
+
 static struct task_grp_ops sched_grp_ops = {
 	.alloc_group = sched_alloc_group,
 	.dealloc_group = sched_dealloc_group,
 	.assign_quota = sched_assign_quota,
+	.pre_move_task = sched_pre_move_task,
+	.post_move_task = sched_post_move_task,
 	.get_quota = sched_get_quota,
 };
 
diff -puN include/linux/sched.h~cpu_ctlr_move_task include/linux/sched.h
--- linux-2.6.18-rc3/include/linux/sched.h~cpu_ctlr_move_task	2006-08-20 21:56:09.000000000 +0530
+++ linux-2.6.18-rc3-root/include/linux/sched.h	2006-08-20 21:56:09.000000000 +0530
@@ -1611,6 +1611,9 @@ struct task_grp_ops {
 	void *(*alloc_group)(void);
 	void (*dealloc_group)(struct task_grp *grp);
 	void (*assign_quota)(struct task_grp *grp, int quota);
+	int (*pre_move_task)(struct task_struct *tsk, struct task_grp *old,
+		       					struct task_grp *new);
+	void (*post_move_task)(struct task_struct *tsk);
 	int (*get_quota)(struct task_grp *grp);
 };
 

_
-- 
Regards,
vatsa
