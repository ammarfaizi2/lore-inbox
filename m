Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267324AbUJVUCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267324AbUJVUCy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 16:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266905AbUJVUCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 16:02:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:43731 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267338AbUJVT74 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 15:59:56 -0400
Date: Fri, 22 Oct 2004 12:59:50 -0700
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org, torvalds@osdl.org, Ingo Molnar <mingo@elte.hu>
Cc: Chris Wright <chrisw@osdl.org>, Andrea Arcangeli <andrea@novell.com>,
       johansen@immunix.com, Stephen Smalley <sds@epoch.ncsc.mil>,
       Thomas Bleher <bleher@informatik.uni-muenchen.de>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] delay rq_lock acquisition in setscheduler
Message-ID: <20041022125950.X2357@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doing access control checks with rq_lock held can cause deadlock when
audit messages are created (via printk or audit infrastructure) which
trigger a wakeup and deadlock, as noted by both SELinux and SubDomain
folks.  This patch will let the security checks happen w/out lock held,
then re-sample the p->policy in case it was raced.  Originally from John
Johansen <johansen@immunix.com>, reworked by me.  AFAIK, this version
drew no objections from Ingo or Andrea.  Please let me know if there's
any issue with the patch.

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

