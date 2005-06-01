Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVFAL6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVFAL6h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 07:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbVFAL6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 07:58:37 -0400
Received: from mail05.syd.optusnet.com.au ([211.29.132.186]:12209 "EHLO
	mail05.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261342AbVFAL6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 07:58:12 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] Sample fix for hyperthread exploit
Date: Wed, 1 Jun 2005 21:58:39 +1000
User-Agent: KMail/1.8.1
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_vLanCUF5Qn4BCPI"
Message-Id: <200506012158.39805.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_vLanCUF5Qn4BCPI
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

With respect to the recently publicised theoretical exploit for tasks running 
on hyperthread siblings, we already have in our hyperthreading code the 
ability to suspend running of tasks on siblings based on their behaviour. We 
could extend that if so desired as a plug for this theoretical exploit. We 
could suspend tasks that run on siblings based on their uid to prevent 
another user from being able to instrument cache misses from another user's 
task. Attached is a sample patch to do just that. It is my understanding that 
this exploit is not deemed significant risk anyway, and the attached solution 
would cost us in throughput if multiple users' tasks are running 
concurrently, but would still be better than disabling hyperthreading. This 
patch is more for discussion than inclusion, and is otherwise untested.

Comments?

Signed-off-by: Con Kolivas <kernel@kolivas.org>


--Boundary-00=_vLanCUF5Qn4BCPI
Content-Type: text/x-diff;
  charset="us-ascii";
  name="dependent_sleep_on_uid.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="dependent_sleep_on_uid.diff"

Index: linux-2.6.12-rc5-uiddep/kernel/sched.c
===================================================================
--- linux-2.6.12-rc5-uiddep.orig/kernel/sched.c	2005-05-29 19:54:30.000000000 +1000
+++ linux-2.6.12-rc5-uiddep/kernel/sched.c	2005-06-01 21:46:54.000000000 +1000
@@ -2530,6 +2530,21 @@ static inline int dependent_sleeper(int 
 		task_t *smt_curr = smt_rq->curr;
 
 		/*
+		 * Don't let tasks from different users run on siblings that
+		 * share caches to avoid the security risk of cache misses.
+		 * If an equal priority task is already running let that one
+		 * continue, otherwise let only the better priority task run.
+		 */
+		if (p->uid != smt_curr->uid && p->mm && smt_curr->mm) {
+			if (smt_curr->prio <= p->prio) {
+				ret = 1;
+				continue;
+			}
+			resched_task(smt_curr);
+			continue;
+		}
+
+		/*
 		 * If a user task with lower static priority than the
 		 * running task on the SMT sibling is trying to schedule,
 		 * delay it till there is proportionately less timeslice

--Boundary-00=_vLanCUF5Qn4BCPI--
