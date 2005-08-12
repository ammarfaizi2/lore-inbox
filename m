Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbVHLNK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbVHLNK3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 09:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbVHLNK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 09:10:28 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:60821 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751168AbVHLNK2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 09:10:28 -0400
Subject: [-mm patch] Avoid divide by zero errors in sched.c
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>
Content-Type: text/plain
Date: Fri, 12 Aug 2005 08:10:22 -0500
Message-Id: <1123852222.9234.7.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a divide-by-zero error that I hit on a two-way i386
machine.  rq->nr_running is tested to be non-zero, but may change by the
time it is used in the division.  Saving the value to a local variable
ensures that the same value that is checked is used in the division.

Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: Con Kolivas <kernel@kolivas.org>

diff -urp linux-2.6.13-rc5-mm1/kernel/sched.c linux/kernel/sched.c
--- linux-2.6.13-rc5-mm1/kernel/sched.c	2005-08-11 09:41:30.000000000 -0500
+++ linux/kernel/sched.c	2005-08-11 09:47:27.000000000 -0500
@@ -989,15 +989,16 @@ void kick_process(task_t *p)
 static inline unsigned long __source_load(int cpu, int type, enum idle_type idle)
 {
 	runqueue_t *rq = cpu_rq(cpu);
+	unsigned long running = rq->nr_running;
 	unsigned long source_load, cpu_load = rq->cpu_load[type-1],
-		load_now = rq->nr_running * SCHED_LOAD_SCALE;
+		load_now = running * SCHED_LOAD_SCALE;
 
 	if (type == 0)
 		source_load = load_now;
 	else
 		source_load = min(cpu_load, load_now);
 
-	if (rq->nr_running > 1 || (idle == NOT_IDLE && rq->nr_running))
+	if (running > 1 || (idle == NOT_IDLE && running))
 		/*
 		 * If we are busy rebalancing the load is biased by
 		 * priority to create 'nice' support across cpus. When
@@ -1006,7 +1007,7 @@ static inline unsigned long __source_loa
 		 * prevent idle rebalance from trying to pull tasks from a
 		 * queue with only one running task.
 		 */
-		source_load = source_load * rq->prio_bias / rq->nr_running;
+		source_load = source_load * rq->prio_bias / running;
 
 	return source_load;
 }
@@ -1022,16 +1023,17 @@ static inline unsigned long source_load(
 static inline unsigned long __target_load(int cpu, int type, enum idle_type idle)
 {
 	runqueue_t *rq = cpu_rq(cpu);
+	unsigned long running = rq->nr_running;
 	unsigned long target_load, cpu_load = rq->cpu_load[type-1],
-		load_now = rq->nr_running * SCHED_LOAD_SCALE;
+		load_now = running * SCHED_LOAD_SCALE;
 
 	if (type == 0)
 		target_load = load_now;
 	else
 		target_load = max(cpu_load, load_now);
 
-	if (rq->nr_running > 1 || (idle == NOT_IDLE && rq->nr_running))
-		target_load = target_load * rq->prio_bias / rq->nr_running;
+	if (running > 1 || (idle == NOT_IDLE && running))
+		target_load = target_load * rq->prio_bias / running;
 
 	return target_load;
 }

-- 
David Kleikamp
IBM Linux Technology Center

