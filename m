Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261689AbUKOUfC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbUKOUfC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 15:35:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbUKOUfC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 15:35:02 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:22659 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261689AbUKOUdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 15:33:52 -0500
Date: Mon, 15 Nov 2004 14:33:43 -0600
From: Dean Nelson <dcn@sgi.com>
To: Chris Wright <chrisw@osdl.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch] export sched_setscheduler() for kernel module use
Message-ID: <20041115203343.GA32173@sgi.com>
References: <4198F70D.mailxMSZ11J00J@aqua.americas.sgi.com> <20041115105801.T14339@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041115105801.T14339@build.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2004 at 10:58:01AM -0800, Chris Wright wrote:
> * Dean Nelson (dcn@sgi.com) wrote:
> > +int do_sched_setscheduler(pid_t pid, int policy, struct sched_param __user *param)
> 
> this should be static.

You're right. I made another change in that one now passes the task_struct
pointer to sched_setscheduler() instead of the pid. This requires that
the caller of sched_setscheduler() hold the tasklist_lock. The new patch
for people's feedback follows.

Thanks,
Dean



Index: linux-2.6/include/linux/sched.h
===================================================================
--- linux-2.6.orig/include/linux/sched.h	2004-11-12 09:40:26.000000000 -0600
+++ linux-2.6/include/linux/sched.h	2004-11-15 13:43:48.000000000 -0600
@@ -727,6 +727,7 @@
 extern int task_nice(const task_t *p);
 extern int task_curr(const task_t *p);
 extern int idle_cpu(int cpu);
+extern int sched_setscheduler(struct task_struct *, int, struct sched_param *);
 
 void yield(void);
 
Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c	2004-11-12 09:40:26.000000000 -0600
+++ linux-2.6/kernel/sched.c	2004-11-15 14:22:45.000000000 -0600
@@ -2938,7 +2938,7 @@
 	 */
 	rq = task_rq_lock(p, &flags);
 	/*
-	 * The RT priorities are set via setscheduler(), but we still
+	 * The RT priorities are set via sched_setscheduler(), but we still
 	 * allow the 'normal' nice value to be set - but as expected
 	 * it wont have any effect on scheduling until the task is
 	 * not SCHED_NORMAL:
@@ -3072,67 +3072,50 @@
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
+ *
+ * The caller of this function must be holding the tasklist_lock.
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
-
-	/*
-	 * We play safe to avoid deadlocks.
-	 */
-	read_lock_irq(&tasklist_lock);
-
-	p = find_process_by_pid(pid);
 
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
@@ -3147,9 +3130,8 @@
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
@@ -3164,22 +3146,41 @@
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
@@ -3189,7 +3190,7 @@
  */
 asmlinkage long sys_sched_setparam(pid_t pid, struct sched_param __user *param)
 {
-	return setscheduler(pid, -1, param);
+	return do_sched_setscheduler(pid, -1, param);
 }
 
 /**
