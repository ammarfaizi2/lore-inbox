Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWFRHbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWFRHbt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 03:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWFRHbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 03:31:48 -0400
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:18660 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932122AbWFRHbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 03:31:40 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>
Subject: [ckpatch][10/29] sched-limit_policy_changes.patch
Date: Sun, 18 Jun 2006 17:31:36 +1000
User-Agent: KMail/1.9.3
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 3108
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200606181731.36393.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Many applications explicitly set SCHED_NORMAL on threads thus undoing the
usefulness of the SCHED_ISO, SCHED_BATCH and SCHED_IDLEPRIO policies.

For unprivileged users:

Only allow non realtime policies to be downgraded from ISO->BATCH->IDLEPRIO
but not back to NORMAL.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

---
 kernel/sched.c |   52 +++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 39 insertions(+), 13 deletions(-)

Index: linux-ck-dev/kernel/sched.c
===================================================================
--- linux-ck-dev.orig/kernel/sched.c	2006-06-18 15:23:46.000000000 +1000
+++ linux-ck-dev/kernel/sched.c	2006-06-18 15:23:49.000000000 +1000
@@ -3700,19 +3700,44 @@ recheck:
 	 * Allow unprivileged RT tasks to decrease priority:
 	 */
 	if (!capable(CAP_SYS_NICE)) {
-		/*
-		 * can't change policy, except between SCHED_NORMAL
-		 * and SCHED_BATCH:
-		 */
-		if (SCHED_RT(policy) && policy != p->policy &&
-				!p->signal->rlim[RLIMIT_RTPRIO].rlim_cur)
-			return -EPERM;
-		/* can't increase priority */
-		if (SCHED_RT(policy) &&
-		    param->sched_priority > p->rt_priority &&
-		    param->sched_priority >
-				p->signal->rlim[RLIMIT_RTPRIO].rlim_cur)
-			return -EPERM;
+		if (SCHED_RT(policy)) {
+			/*
+			 * can't change policy to a realtime policy
+			 */
+			if (policy != p->policy &&
+			    !p->signal->rlim[RLIMIT_RTPRIO].rlim_cur)
+				return -EPERM;
+			/* can't increase priority */
+			if (param->sched_priority > p->rt_priority &&
+			    param->sched_priority >
+			    p->signal->rlim[RLIMIT_RTPRIO].rlim_cur)
+				return -EPERM;
+		} else {
+			switch (p->policy) {
+				/*
+				 * Can only downgrade policies but not back to
+				 * SCHED_NORMAL
+				 */
+				case SCHED_ISO:
+					if (policy == SCHED_ISO)
+						goto out;
+					if (policy == SCHED_NORMAL)
+						return -EPERM;
+					break;
+				case SCHED_BATCH:
+					if (policy == SCHED_BATCH)
+						goto out;
+					if (policy != SCHED_IDLEPRIO)
+					    	return -EPERM;
+					break;
+				case SCHED_IDLEPRIO:
+					if (policy == SCHED_IDLEPRIO)
+						goto out;
+					return -EPERM;
+				default:
+					break;
+			}
+		}
 		/* can't change other user's priorities */
 		if ((current->euid != p->euid) &&
 		    (current->euid != p->uid))
@@ -3756,6 +3781,7 @@ recheck:
 			preempt(p, rq);
 	}
 	task_rq_unlock(rq, &flags);
+out:
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sched_setscheduler);

-- 
-ck
