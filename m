Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWFRHbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWFRHbN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 03:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWFRHbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 03:31:12 -0400
Received: from mail20.syd.optusnet.com.au ([211.29.132.201]:3552 "EHLO
	mail20.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932124AbWFRHbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 03:31:11 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>
Subject: [ckpatch][6/29] sched-range.patch
Date: Sun, 18 Jun 2006 17:30:57 +1000
User-Agent: KMail/1.9.3
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 3365
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200606181730.57652.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add SCHED_RANGE and SCHED_RT wrappers for easy policy management.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

 include/linux/sched.h |    7 +++++++
 kernel/sched.c        |   13 +++++--------
 2 files changed, 12 insertions(+), 8 deletions(-)

Index: linux-ck-dev/include/linux/sched.h
===================================================================
--- linux-ck-dev.orig/include/linux/sched.h	2006-06-18 15:23:21.000000000 +1000
+++ linux-ck-dev/include/linux/sched.h	2006-06-18 15:23:35.000000000 +1000
@@ -165,6 +165,13 @@ extern unsigned long weighted_cpuload(co
 #define SCHED_RR		2
 #define SCHED_BATCH		3
 
+#define SCHED_MIN		0
+#define SCHED_MAX		3
+
+#define SCHED_RANGE(policy)	((policy) <= SCHED_MAX)
+#define SCHED_RT(policy)	((policy) == SCHED_FIFO || \
+					(policy) == SCHED_RR)
+
 struct sched_param {
 	int sched_priority;
 };
Index: linux-ck-dev/kernel/sched.c
===================================================================
--- linux-ck-dev.orig/kernel/sched.c	2006-06-18 15:23:21.000000000 +1000
+++ linux-ck-dev/kernel/sched.c	2006-06-18 15:23:35.000000000 +1000
@@ -3548,7 +3548,7 @@ static void __setscheduler(struct task_s
 	BUG_ON(task_queued(p));
 	p->policy = policy;
 	p->rt_priority = prio;
-	if (policy != SCHED_NORMAL && policy != SCHED_BATCH) {
+	if (SCHED_RT(policy)) {
 		p->prio = MAX_RT_PRIO-1 - p->rt_priority;
 	} else
 		p->prio = p->static_prio;
@@ -3574,8 +3574,7 @@ recheck:
 	/* double check policy once rq lock held */
 	if (policy < 0)
 		policy = oldpolicy = p->policy;
-	else if (policy != SCHED_FIFO && policy != SCHED_RR &&
-			policy != SCHED_NORMAL && policy != SCHED_BATCH)
+	else if (!SCHED_RANGE(policy))
 		return -EINVAL;
 	/*
 	 * Valid priorities for SCHED_FIFO and SCHED_RR are
@@ -3586,8 +3585,7 @@ recheck:
 	    (p->mm && param->sched_priority > MAX_USER_RT_PRIO-1) ||
 	    (!p->mm && param->sched_priority > MAX_RT_PRIO-1))
 		return -EINVAL;
-	if ((policy == SCHED_NORMAL || policy == SCHED_BATCH)
-					!= (param->sched_priority == 0))
+	if ((!SCHED_RT(policy)) != (param->sched_priority == 0))
 		return -EINVAL;
 
 	/*
@@ -3598,12 +3596,11 @@ recheck:
 		 * can't change policy, except between SCHED_NORMAL
 		 * and SCHED_BATCH:
 		 */
-		if (((policy != SCHED_NORMAL && p->policy != SCHED_BATCH) &&
-			(policy != SCHED_BATCH && p->policy != SCHED_NORMAL)) &&
+		if (SCHED_RT(policy) && policy != p->policy &&
 				!p->signal->rlim[RLIMIT_RTPRIO].rlim_cur)
 			return -EPERM;
 		/* can't increase priority */
-		if ((policy != SCHED_NORMAL && policy != SCHED_BATCH) &&
+		if (SCHED_RT(policy) &&
 		    param->sched_priority > p->rt_priority &&
 		    param->sched_priority >
 				p->signal->rlim[RLIMIT_RTPRIO].rlim_cur)

-- 
-ck
