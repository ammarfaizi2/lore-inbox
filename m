Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbUKOSgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbUKOSgQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 13:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbUKOSgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 13:36:16 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:2004 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261654AbUKOSgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 13:36:09 -0500
Date: Mon, 15 Nov 2004 12:35:57 -0600
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [Patch] export sched_setscheduler() for kernel module use
Message-ID: <4198F70D.mailxMSZ11J00J@aqua.americas.sgi.com>
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
--- linux-2.6.orig/include/linux/sched.h	2004-11-12 09:40:26.000000000 -0600
+++ linux-2.6/include/linux/sched.h	2004-11-15 06:49:02.000000000 -0600
@@ -727,6 +727,7 @@
 extern int task_nice(const task_t *p);
 extern int task_curr(const task_t *p);
 extern int idle_cpu(int cpu);
+extern int sched_setscheduler(pid_t, int, struct sched_param *);
 
 void yield(void);
 
Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c	2004-11-12 09:40:26.000000000 -0600
+++ linux-2.6/kernel/sched.c	2004-11-15 06:48:58.000000000 -0600
@@ -2938,7 +2938,7 @@
 	 */
 	rq = task_rq_lock(p, &flags);
 	/*
-	 * The RT priorities are set via setscheduler(), but we still
+	 * The RT priorities are set via sched_setscheduler(), but we still
 	 * allow the 'normal' nice value to be set - but as expected
 	 * it wont have any effect on scheduling until the task is
 	 * not SCHED_NORMAL:
@@ -3072,26 +3072,22 @@
 		p->prio = p->static_prio;
 }
 
-/*
- * setscheduler - change the scheduling policy and/or RT priority of a thread.
+/**
+ * sched_setscheduler - change the scheduling policy and/or RT priority of
+ * a thread.
+ * @pid: the pid in question.
+ * @policy: new policy.
+ * @param: structure containing the new RT priority.
  */
-static int setscheduler(pid_t pid, int policy, struct sched_param __user *param)
+int sched_setscheduler(pid_t pid, int policy, struct sched_param *param)
 {
-	struct sched_param lp;
-	int retval = -EINVAL;
+	int retval;
 	int oldprio, oldpolicy = -1;
 	prio_array_t *array;
 	unsigned long flags;
 	runqueue_t *rq;
 	task_t *p;
 
-	if (!param || pid < 0)
-		goto out_nounlock;
-
-	retval = -EFAULT;
-	if (copy_from_user(&lp, param, sizeof(struct sched_param)))
-		goto out_nounlock;
-
 	/*
 	 * We play safe to avoid deadlocks.
 	 */
@@ -3117,9 +3113,10 @@
 	 * 1..MAX_USER_RT_PRIO-1, valid priority for SCHED_NORMAL is 0.
 	 */
 	retval = -EINVAL;
-	if (lp.sched_priority < 0 || lp.sched_priority > MAX_USER_RT_PRIO-1)
+	if (param->sched_priority < 0 ||
+	    param->sched_priority > MAX_USER_RT_PRIO-1)
 		goto out_unlock;
-	if ((policy == SCHED_NORMAL) != (lp.sched_priority == 0))
+	if ((policy == SCHED_NORMAL) != (param->sched_priority == 0))
 		goto out_unlock;
 
 	retval = -EPERM;
@@ -3130,7 +3127,7 @@
 	    !capable(CAP_SYS_NICE))
 		goto out_unlock;
 
-	retval = security_task_setscheduler(p, policy, &lp);
+	retval = security_task_setscheduler(p, policy, param);
 	if (retval)
 		goto out_unlock;
 	/*
@@ -3149,7 +3146,7 @@
 		deactivate_task(p, task_rq(p));
 	retval = 0;
 	oldprio = p->prio;
-	__setscheduler(p, policy, lp.sched_priority);
+	__setscheduler(p, policy, param->sched_priority);
 	if (array) {
 		__activate_task(p, task_rq(p));
 		/*
@@ -3166,20 +3163,33 @@
 	task_rq_unlock(rq, &flags);
 out_unlock:
 	read_unlock_irq(&tasklist_lock);
-out_nounlock:
 	return retval;
 }
+EXPORT_SYMBOL_GPL(sched_setscheduler);
+
+int do_sched_setscheduler(pid_t pid, int policy, struct sched_param __user *param)
+{
+	struct sched_param lparam;
+
+	if (!param || pid < 0)
+		return -EINVAL;
+
+	if (copy_from_user(&lparam, param, sizeof(struct sched_param)))
+		return -EFAULT;
+
+	return sched_setscheduler(pid, policy, &lparam);
+}
 
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
@@ -3189,7 +3199,7 @@
  */
 asmlinkage long sys_sched_setparam(pid_t pid, struct sched_param __user *param)
 {
-	return setscheduler(pid, -1, param);
+	return do_sched_setscheduler(pid, -1, param);
 }
 
 /**
