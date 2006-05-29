Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751385AbWE2VbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbWE2VbS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWE2V0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:26:49 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:35307 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751361AbWE2V0p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:26:45 -0400
Date: Mon, 29 May 2006 23:27:03 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 49/61] lock validator: special locking: sched.c
Message-ID: <20060529212703.GW3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

teach special (recursive) locking code to the lock validator. Has no
effect on non-lockdep kernels.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 kernel/sched.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c
+++ linux/kernel/sched.c
@@ -1963,7 +1963,7 @@ static void double_rq_unlock(runqueue_t 
 	__releases(rq1->lock)
 	__releases(rq2->lock)
 {
-	spin_unlock(&rq1->lock);
+	spin_unlock_non_nested(&rq1->lock);
 	if (rq1 != rq2)
 		spin_unlock(&rq2->lock);
 	else
@@ -1980,7 +1980,7 @@ static void double_lock_balance(runqueue
 {
 	if (unlikely(!spin_trylock(&busiest->lock))) {
 		if (busiest->cpu < this_rq->cpu) {
-			spin_unlock(&this_rq->lock);
+			spin_unlock_non_nested(&this_rq->lock);
 			spin_lock(&busiest->lock);
 			spin_lock(&this_rq->lock);
 		} else
@@ -2602,7 +2602,7 @@ static int load_balance_newidle(int this
 		nr_moved = move_tasks(this_rq, this_cpu, busiest,
 					minus_1_or_zero(busiest->nr_running),
 					imbalance, sd, NEWLY_IDLE, NULL);
-		spin_unlock(&busiest->lock);
+		spin_unlock_non_nested(&busiest->lock);
 	}
 
 	if (!nr_moved) {
@@ -2687,7 +2687,7 @@ static void active_load_balance(runqueue
 	else
 		schedstat_inc(sd, alb_failed);
 out:
-	spin_unlock(&target_rq->lock);
+	spin_unlock_non_nested(&target_rq->lock);
 }
 
 /*
@@ -3032,7 +3032,7 @@ static void wake_sleeping_dependent(int 
 	}
 
 	for_each_cpu_mask(i, sibling_map)
-		spin_unlock(&cpu_rq(i)->lock);
+		spin_unlock_non_nested(&cpu_rq(i)->lock);
 	/*
 	 * We exit with this_cpu's rq still held and IRQs
 	 * still disabled:
@@ -3068,7 +3068,7 @@ static int dependent_sleeper(int this_cp
 	 * The same locking rules and details apply as for
 	 * wake_sleeping_dependent():
 	 */
-	spin_unlock(&this_rq->lock);
+	spin_unlock_non_nested(&this_rq->lock);
 	sibling_map = sd->span;
 	for_each_cpu_mask(i, sibling_map)
 		spin_lock(&cpu_rq(i)->lock);
@@ -3146,7 +3146,7 @@ check_smt_task:
 	}
 out_unlock:
 	for_each_cpu_mask(i, sibling_map)
-		spin_unlock(&cpu_rq(i)->lock);
+		spin_unlock_non_nested(&cpu_rq(i)->lock);
 	return ret;
 }
 #else
@@ -6680,7 +6680,7 @@ void __init sched_init(void)
 		prio_array_t *array;
 
 		rq = cpu_rq(i);
-		spin_lock_init(&rq->lock);
+		spin_lock_init_static(&rq->lock);
 		rq->nr_running = 0;
 		rq->active = rq->arrays;
 		rq->expired = rq->arrays + 1;
