Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbWFAWzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWFAWzq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 18:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbWFAWzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 18:55:46 -0400
Received: from cantor2.suse.de ([195.135.220.15]:35513 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750853AbWFAWzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 18:55:44 -0400
From: Chris Mason <mason@suse.com>
To: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: [PATCH RFC] smt nice introduces significant lock contention
Date: Thu, 1 Jun 2006 18:55:37 -0400
User-Agent: KMail/1.9.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606011855.38110.mason@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

Recent benchmarks showed some performance regressions between 2.6.16 and 
2.6.5.  We tracked down one of the regressions to lock contention in schedule 
heavy workloads (~70,000 context switches per second)

kernel/sched.c:dependent_sleeper() was responsible for most of the lock 
contention, hammering on the run queue locks.  The patch below is more of 
a discussion point than a suggested fix (although it does reduce lock 
contention significantly).  The dependent_sleeper code looks very expensive 
to me, especially for using a spinlock to bounce control between two different 
siblings in the same cpu.

--- a/kernel/sched.c	Thu May 18 15:55:43 2006 -0400
+++ b/kernel/sched.c	Tue May 23 21:13:52 2006 -0400
@@ -2630,6 +2630,27 @@ static inline void wakeup_busy_runqueue(
 		resched_task(rq->idle);
 }
 
+static int trylock_smt_cpus(cpumask_t sibling_map)
+{
+	int ret = 1;
+	int numlocked = 0;
+	int i;
+	for_each_cpu_mask(i, sibling_map) {
+		ret = spin_trylock(&cpu_rq(i)->lock);
+		if (!ret)
+			break;
+		numlocked++;
+	}
+	if (ret || !numlocked)
+		return ret;
+	for_each_cpu_mask(i, sibling_map) {
+		spin_unlock(&cpu_rq(i)->lock);
+		if (--numlocked == 0)
+			break;
+	}
+	return 0;
+}
+
 static void wake_sleeping_dependent(int this_cpu, runqueue_t *this_rq)
 {
 	struct sched_domain *tmp, *sd = NULL;
@@ -2643,22 +2664,16 @@ static void wake_sleeping_dependent(int 
 	if (!sd)
 		return;
 
-	/*
-	 * Unlock the current runqueue because we have to lock in
-	 * CPU order to avoid deadlocks. Caller knows that we might
-	 * unlock. We keep IRQs disabled.
-	 */
-	spin_unlock(&this_rq->lock);
-
 	sibling_map = sd->span;
 
-	for_each_cpu_mask(i, sibling_map)
-		spin_lock(&cpu_rq(i)->lock);
 	/*
 	 * We clear this CPU from the mask. This both simplifies the
 	 * inner loop and keps this_rq locked when we exit:
 	 */
 	cpu_clear(this_cpu, sibling_map);
+
+	if (!trylock_smt_cpus(sibling_map))
+		return;
 
 	for_each_cpu_mask(i, sibling_map) {
 		runqueue_t *smt_rq = cpu_rq(i);
@@ -2703,11 +2718,10 @@ static int dependent_sleeper(int this_cp
 	 * The same locking rules and details apply as for
 	 * wake_sleeping_dependent():
 	 */
-	spin_unlock(&this_rq->lock);
 	sibling_map = sd->span;
-	for_each_cpu_mask(i, sibling_map)
-		spin_lock(&cpu_rq(i)->lock);
 	cpu_clear(this_cpu, sibling_map);
+	if (!trylock_smt_cpus(sibling_map))
+		return 0;
 
 	/*
 	 * Establish next task to be run - it might have gone away because
