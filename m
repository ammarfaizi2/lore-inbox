Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270230AbTHLMUe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 08:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270243AbTHLMUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 08:20:33 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:39315
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S270230AbTHLMUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 08:20:32 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH]O15int for interactivity
Date: Tue, 12 Aug 2003 22:26:11 +1000
User-Agent: KMail/1.5.3
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308122226.11557.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch addresses the problem of tasks that preempt their children when 
they're forking, wasting cpu cycles until they get demoted to a priority where 
they no longer preempt their child. Although this has been said to be a design 
flaw in the applications, it can cause sustained periods of starvation due to 
this coding problem, and the more I looked, the more examples I found of this 
happening.

Tasks now cannot preempt their own children. This speeds up the startup of 
child applications (eg pgp signed email).

This change has allowed tasks to stay at higher priority for much longer so 
the sleep avg decay of high credit tasks has been changed to match the rate of 
rise during periods of sleep (which I wanted to do originally but was limited 
by the first problem). This makes for much more sustained interactivity at 
extreme loads, and much less X jerkiness.

Con

Patch against 2.6.0-test3-mm1:

--- linux-2.6.0-test3-mm1-O14.1/kernel/sched.c	2003-08-12 22:04:13.000000000 +1000
+++ linux-2.6.0-test3-mm1/kernel/sched.c	2003-08-12 22:03:47.000000000 +1000
@@ -620,8 +620,13 @@ repeat_lock_task:
 				__activate_task(p, rq);
 			else {
 				activate_task(p, rq);
-				if (TASK_PREEMPTS_CURR(p, rq))
-					resched_task(rq->curr);
+				/*
+				 * Parents are not allowed to preempt their
+				 * children
+				 */
+				if (TASK_PREEMPTS_CURR(p, rq) &&
+					p != rq->curr->parent)
+						resched_task(rq->curr);
 			}
 			success = 1;
 		}
@@ -1124,7 +1129,7 @@ static inline void pull_task(runqueue_t 
 	 * Note that idle threads have a prio of MAX_PRIO, for this test
 	 * to be always true for them.
 	 */
-	if (TASK_PREEMPTS_CURR(p, this_rq))
+	if (TASK_PREEMPTS_CURR(p, this_rq) && p != this_rq->curr->parent)
 		set_need_resched();
 }
 
@@ -1493,9 +1498,8 @@ need_resched:
 	 * priority bonus
 	 */
 	if (HIGH_CREDIT(prev))
-		run_time /= (MAX_BONUS + 1 -
-			(NS_TO_JIFFIES(prev->sleep_avg) * MAX_BONUS /
-			MAX_SLEEP_AVG));
+		run_time /= ((NS_TO_JIFFIES(prev->sleep_avg) * MAX_BONUS /
+				MAX_SLEEP_AVG) ? : 1);
 
 	spin_lock_irq(&rq->lock);
 

