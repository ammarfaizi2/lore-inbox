Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269186AbUJUBhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269186AbUJUBhi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 21:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270634AbUJUBeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 21:34:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:10176 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270623AbUJUBcq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 21:32:46 -0400
Date: Wed, 20 Oct 2004 18:32:38 -0700
From: Chris Wright <chrisw@osdl.org>
To: mingo@elte.hu
Cc: johansen@immunix.com, Stephen Smalley <sds@epoch.ncsc.mil>,
       Thomas Bleher <bleher@informatik.uni-muenchen.de>,
       linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] delay rq_lock acquisition in setscheduler
Message-ID: <20041020183238.U2357@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

Doing access control checks with rq_lock held can cause deadlock
when audit messages are created (via printk or audit infrastructure),
as noted by both SELinux and SubDomain folks.  This patch will let the
security checks happen w/out lock held, then re-sample the p->policy in
case it was raced.  Original patch from John Johansen, with some updates
from me.  What do you think?

From: John Johansen <johansen@immunix.com>
Signed-off-by: Chris Wright <chrisw@osdl.org>

===== kernel/sched.c 1.367 vs edited =====
--- 1.367/kernel/sched.c	2004-10-18 22:26:52 -07:00
+++ edited/kernel/sched.c	2004-10-20 15:55:12 -07:00
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
+		goto out_unlock;
 
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
@@ -3098,7 +3092,15 @@
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
+	retval = -EPERM;
+	if (unlikely(oldpolicy != -1 && oldpolicy != p->policy))
+		goto out_unlock_rq;
 	array = p->array;
 	if (array)
 		deactivate_task(p, task_rq(p));
@@ -3118,12 +3120,10 @@
 		} else if (TASK_PREEMPTS_CURR(p, rq))
 			resched_task(rq->curr);
 	}
-
-out_unlock:
+out_unlock_rq:
 	task_rq_unlock(rq, &flags);
-out_unlock_tasklist:
+out_unlock:
 	read_unlock_irq(&tasklist_lock);
-
 out_nounlock:
 	return retval;
 }
