Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270735AbUJURdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270735AbUJURdF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 13:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270682AbUJUR3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 13:29:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:32680 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270735AbUJURZa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 13:25:30 -0400
Date: Thu, 21 Oct 2004 10:25:28 -0700
From: Chris Wright <chrisw@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrea Arcangeli <andrea@novell.com>, Chris Wright <chrisw@osdl.org>,
       johansen@immunix.com, Stephen Smalley <sds@epoch.ncsc.mil>,
       Thomas Bleher <bleher@informatik.uni-muenchen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] delay rq_lock acquisition in setscheduler
Message-ID: <20041021102528.Z2357@build.pdx.osdl.net>
References: <20041020183238.U2357@build.pdx.osdl.net> <20041021075613.GC20573@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041021075613.GC20573@elte.hu>; from mingo@elte.hu on Thu, Oct 21, 2004 at 09:56:13AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ingo Molnar (mingo@elte.hu) wrote:
> i dont this this patch is correct, because it changes semantics by
> pushing a security-subsystem failure back into userspace. There's
> nothing wrong with two tasks trying to change a third task's policy in
> parallel - our API allows that.

Andrea and John had similar concern.

> I agree that this is a very special case of lock dependency and that the
> security subsystem should not be burdened with double-buffering messages
> just to avoid the runqueue lock on syslogd wakeup. Only this single
> scheduling-related system-call is affected by this problem.
> 
> i think the right solution would be to retry the permission check if the
> policy has changed (an unlikely event). It is livelockable the same way
> seqlocks are livelockable so i'd not worry about it too much. It is also
> preemptible with PREEMPT so not a big issue. Also, the check & repeat
> code should possibly be #ifdef CONFIG_SECURITY.

I think ifdef would start to look messy in that function.  This one
simply rechecks permissions if the policy has changed.  Look OK?

Doing access control checks with rq_lock held can cause deadlock when
audit messages are created (via printk or audit infrastructure) which
trigger a wakeup and deadlock, as noted by both SELinux and SubDomain
folks.  This patch will let the security checks happen w/out lock held,
then re-sample the p->policy in case it was raced.  Originally from
John Johansen <johansen@immunix.com>, bits redone by me.

From: John Johansen <johansen@immunix.com>
Signed-off-by: Chris Wright <chrisw@osdl.org>

===== kernel/sched.c 1.367 vs edited =====
--- 1.367/kernel/sched.c	2004-10-18 22:26:52 -07:00
+++ edited/kernel/sched.c	2004-10-21 09:41:23 -07:00
@@ -3038,7 +3038,7 @@
 {
 	struct sched_param lp;
 	int retval = -EINVAL;
-	int oldprio;
+	int oldprio, oldpolicy = -1;
 	prio_array_t *array;
 	unsigned long flags;
 	runqueue_t *rq;
@@ -3060,23 +3060,17 @@
 
 	retval = -ESRCH;
 	if (!p)
-		goto out_unlock_tasklist;
-
-	/*
-	 * To be able to change p->policy safely, the apropriate
-	 * runqueue lock must be held.
-	 */
-	rq = task_rq_lock(p, &flags);
-
+		goto out_unlock;
+recheck:
+	/* double check policy once rq lock held */
 	if (policy < 0)
-		policy = p->policy;
+		policy = oldpolicy = p->policy;
 	else {
 		retval = -EINVAL;
 		if (policy != SCHED_FIFO && policy != SCHED_RR &&
 				policy != SCHED_NORMAL)
 			goto out_unlock;
 	}
-
 	/*
 	 * Valid priorities for SCHED_FIFO and SCHED_RR are
 	 * 1..MAX_USER_RT_PRIO-1, valid priority for SCHED_NORMAL is 0.
@@ -3098,7 +3092,17 @@
 	retval = security_task_setscheduler(p, policy, &lp);
 	if (retval)
 		goto out_unlock;
-
+	/*
+	 * To be able to change p->policy safely, the apropriate
+	 * runqueue lock must be held.
+	 */
+	rq = task_rq_lock(p, &flags);
+	/* recheck policy now with rq lock held */
+	if (unlikely(oldpolicy != -1 && oldpolicy != p->policy)) {
+		policy = oldpolicy = -1;
+		task_rq_unlock(rq, &flags);
+		goto recheck;
+	}
 	array = p->array;
 	if (array)
 		deactivate_task(p, task_rq(p));
@@ -3118,12 +3122,9 @@
 		} else if (TASK_PREEMPTS_CURR(p, rq))
 			resched_task(rq->curr);
 	}
-
-out_unlock:
 	task_rq_unlock(rq, &flags);
-out_unlock_tasklist:
+out_unlock:
 	read_unlock_irq(&tasklist_lock);
-
 out_nounlock:
 	return retval;
 }
