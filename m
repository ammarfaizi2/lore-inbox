Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262316AbULMUl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbULMUl5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 15:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262277AbULMU3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 15:29:38 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:33409 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261342AbULMUOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 15:14:41 -0500
Date: Mon, 13 Dec 2004 14:14:13 -0600
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] export sched_setscheduler() for kernel module use
Message-ID: <41BDF815.mailx9L513T2H5@aqua.americas.sgi.com>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: dcn@sgi.com (Dean Nelson)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch exports sched_setscheduler() so that it can be used by a kernel
module to set a kthread's scheduling policy and associated parameters.

Signed-off-by: Dean Nelson <dcn@sgi.com>


Index: linux-2.6/include/linux/sched.h
===================================================================
--- linux-2.6.orig/include/linux/sched.h	2004-12-09 09:08:24.551332932 -0600
+++ linux-2.6/include/linux/sched.h	2004-12-09 09:08:32.286956855 -0600
@@ -740,6 +740,7 @@
 extern int task_nice(const task_t *p);
 extern int task_curr(const task_t *p);
 extern int idle_cpu(int cpu);
+extern int sched_setscheduler(struct task_struct *, int, struct sched_param *);
 
 void yield(void);
 
Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c	2004-12-09 09:08:24.552309405 -0600
+++ linux-2.6/kernel/sched.c	2004-12-09 09:12:28.183308108 -0600
@@ -2955,7 +2955,7 @@
 	 */
 	rq = task_rq_lock(p, &flags);
 	/*
-	 * The RT priorities are set via setscheduler(), but we still
+	 * The RT priorities are set via sched_setscheduler(), but we still
 	 * allow the 'normal' nice value to be set - but as expected
 	 * it wont have any effect on scheduling until the task is
 	 * not SCHED_NORMAL:
@@ -3087,67 +3087,48 @@
 		p->prio = p->static_prio;
 }
 
-/*
- * setscheduler - change the scheduling policy and/or RT priority of a thread.
+/**
+ * sched_setscheduler - change the scheduling policy and/or RT priority of
+ * a thread.
+ * @p: the task in question.
+ * @policy: new policy.
+ * @param: structure containing the new RT priority.
  */
-static int setscheduler(pid_t pid, int policy, struct sched_param __user *param)
+int sched_setscheduler(struct task_struct *p, int policy, struct sched_param *param)
 {
-	struct sched_param lp;
-	int retval = -EINVAL;
+	int retval;
 	int oldprio, oldpolicy = -1;
 	prio_array_t *array;
 	unsigned long flags;
 	runqueue_t *rq;
-	task_t *p;
-
-	if (!param || pid < 0)
-		goto out_nounlock;
-
-	retval = -EFAULT;
-	if (copy_from_user(&lp, param, sizeof(struct sched_param)))
-		goto out_nounlock;
 
-	/*
-	 * We play safe to avoid deadlocks.
-	 */
-	read_lock_irq(&tasklist_lock);
-
-	p = find_process_by_pid(pid);
-
-	retval = -ESRCH;
-	if (!p)
-		goto out_unlock;
 recheck:
 	/* double check policy once rq lock held */
 	if (policy < 0)
 		policy = oldpolicy = p->policy;
-	else {
-		retval = -EINVAL;
-		if (policy != SCHED_FIFO && policy != SCHED_RR &&
+	else if (policy != SCHED_FIFO && policy != SCHED_RR &&
 				policy != SCHED_NORMAL)
-			goto out_unlock;
-	}
+			return -EINVAL;
 	/*
 	 * Valid priorities for SCHED_FIFO and SCHED_RR are
 	 * 1..MAX_USER_RT_PRIO-1, valid priority for SCHED_NORMAL is 0.
 	 */
-	retval = -EINVAL;
-	if (lp.sched_priority < 0 || lp.sched_priority > MAX_USER_RT_PRIO-1)
-		goto out_unlock;
-	if ((policy == SCHED_NORMAL) != (lp.sched_priority == 0))
-		goto out_unlock;
+	if (param->sched_priority < 0 ||
+	    param->sched_priority > MAX_USER_RT_PRIO-1)
+		return -EINVAL;
+	if ((policy == SCHED_NORMAL) != (param->sched_priority == 0))
+		return -EINVAL;
 
-	retval = -EPERM;
 	if ((policy == SCHED_FIFO || policy == SCHED_RR) &&
 	    !capable(CAP_SYS_NICE))
-		goto out_unlock;
+		return -EPERM;
 	if ((current->euid != p->euid) && (current->euid != p->uid) &&
 	    !capable(CAP_SYS_NICE))
-		goto out_unlock;
+		return -EPERM;
 
-	retval = security_task_setscheduler(p, policy, &lp);
+	retval = security_task_setscheduler(p, policy, param);
 	if (retval)
-		goto out_unlock;
+		return retval;
 	/*
 	 * To be able to change p->policy safely, the apropriate
 	 * runqueue lock must be held.
@@ -3162,9 +3143,8 @@
 	array = p->array;
 	if (array)
 		deactivate_task(p, task_rq(p));
-	retval = 0;
 	oldprio = p->prio;
-	__setscheduler(p, policy, lp.sched_priority);
+	__setscheduler(p, policy, param->sched_priority);
 	if (array) {
 		__activate_task(p, task_rq(p));
 		/*
@@ -3179,22 +3159,41 @@
 			resched_task(rq->curr);
 	}
 	task_rq_unlock(rq, &flags);
-out_unlock:
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sched_setscheduler);
+
+static int do_sched_setscheduler(pid_t pid, int policy, struct sched_param __user *param)
+{
+	int retval;
+	struct sched_param lparam;
+	struct task_struct *p;
+
+	if (!param || pid < 0)
+		return -EINVAL;
+	if (copy_from_user(&lparam, param, sizeof(struct sched_param)))
+		return -EFAULT;
+	read_lock_irq(&tasklist_lock);
+	p = find_process_by_pid(pid);
+	if (!p) {
+		read_unlock_irq(&tasklist_lock);
+		return -ESRCH;
+	}
+	retval = sched_setscheduler(p, policy, &lparam);
 	read_unlock_irq(&tasklist_lock);
-out_nounlock:
 	return retval;
 }
 
 /**
  * sys_sched_setscheduler - set/change the scheduler policy and RT priority
  * @pid: the pid in question.
- * @policy: new policy
+ * @policy: new policy.
  * @param: structure containing the new RT priority.
  */
 asmlinkage long sys_sched_setscheduler(pid_t pid, int policy,
 				       struct sched_param __user *param)
 {
-	return setscheduler(pid, policy, param);
+	return do_sched_setscheduler(pid, policy, param);
 }
 
 /**
@@ -3204,7 +3203,7 @@
  */
 asmlinkage long sys_sched_setparam(pid_t pid, struct sched_param __user *param)
 {
-	return setscheduler(pid, -1, param);
+	return do_sched_setscheduler(pid, -1, param);
 }
 
 /**
