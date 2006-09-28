Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030261AbWI1RbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbWI1RbU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 13:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030262AbWI1RbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 13:31:20 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:60593 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030261AbWI1RbT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 13:31:19 -0400
Date: Thu, 28 Sep 2006 23:00:57 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, Kirill Korotaev <dev@openvz.org>,
       Mike Galbraith <efault@gmx.de>, Balbir Singh <balbir@in.ibm.com>,
       sekharan@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, matthltc@us.ibm.com, dipankar@in.ibm.com,
       ckrm-tech@lists.sourceforge.net
Subject: [RFC, PATCH 5/9] CPU Controller V2 - deal with movement of tasks
Message-ID: <20060928173057.GF8746@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060928172520.GA8746@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060928172520.GA8746@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When a task moves between groups (as initiated by an administrator), it has to
be removed from the runqueue of its old group and added to the runqueue of its
new group. This patch defines this move operation.

Signed-off-by : Srivatsa Vaddagiri <vatsa@in.ibm.com>

---

 linux-2.6.18-root/include/linux/sched.h |    3 +
 linux-2.6.18-root/kernel/sched.c        |   61 ++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff -puN kernel/sched.c~cpu_ctlr_move_task kernel/sched.c
--- linux-2.6.18/kernel/sched.c~cpu_ctlr_move_task	2006-09-28 16:40:24.971244616 +0530
+++ linux-2.6.18-root/kernel/sched.c	2006-09-28 17:23:18.115067296 +0530
@@ -7261,10 +7261,71 @@ int sched_get_quota(struct task_grp *tg)
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
+ *  	  to which a task belongs.
+ * 	- At any give point during the move operation, the pointer either
+ * 	  points to the old group or to the new group, but not both!
+ *	- dequeue_task/enqueue_task rely on this pointer to know which
+ * 	  task_grp_rq the task is to be removed from/added to.
+ *
+ * Hence the move is accomplished in two steps:
+ *
+ *	1. In first step, sched_pre_move_task() is called with the group
+ * 	   pointer set to the old group to which the task belonged.
+ * 	   If the task was on a runqueue, sched_pre_move_task() will
+ * 	   removes it from the runqueue.
+ *
+ * 	2. In second step, sched_post_move_task() is called with the group
+ *	   pointer set to the new group to which the task belongs.
+ *	   sched_post_move_task() will add the task in its new runqueue
+ * 	   if it was on a runqueue in step 1.
+ *
+ */
+
+int sched_pre_move_task(struct task_struct *tsk, unsigned long *flags,
+			 struct task_grp *tg_old, struct task_grp *tg_new)
+{
+	struct rq *rq;
+	int rc = 0;
+
+	if (tg_new == tg_old)
+		return rc;
+
+	rq = task_rq_lock(tsk, flags);
+
+	rc = 1;
+	if (tsk->array) {
+		rc = 2;
+		deactivate_task(tsk, rq);
+	}
+
+	return rc;
+}
+
+/* called with rq lock held */
+void sched_post_move_task(struct task_struct *tsk, unsigned long *flags, int rc)
+{
+	struct rq *rq = task_rq(tsk);
+
+	if (rc == 2)
+		__activate_task(tsk, rq);
+
+	task_rq_unlock(rq, flags);
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
--- linux-2.6.18/include/linux/sched.h~cpu_ctlr_move_task	2006-09-28 16:40:24.976243856 +0530
+++ linux-2.6.18-root/include/linux/sched.h	2006-09-28 17:23:18.119066688 +0530
@@ -1618,6 +1618,9 @@ struct task_grp_ops {
 	void *(*alloc_group)(void);
 	void (*dealloc_group)(struct task_grp *grp);
 	int (*assign_quota)(struct task_grp *grp, int quota);
+	int (*pre_move_task)(struct task_struct *tsk, unsigned long *,
+				struct task_grp *old, struct task_grp *new);
+	void (*post_move_task)(struct task_struct *tsk, unsigned long *, int);
 	int (*get_quota)(struct task_grp *grp);
 };
 
_
-- 
Regards,
vatsa
