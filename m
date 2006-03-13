Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbWCMIFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWCMIFg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 03:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWCMIFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 03:05:36 -0500
Received: from mail15.syd.optusnet.com.au ([211.29.132.196]:23759 "EHLO
	mail15.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932337AbWCMIFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 03:05:35 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>
Subject: [PATCH][1/4] sched: store weighted load on up
Date: Mon, 13 Mar 2006 19:05:16 +1100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Peter Williams <pwil3058@bigpond.net.au>, ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 4553
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200603131905.17349.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the smp nice code to store load_weight on uniprocessor as well to
allow relative niceness on one cpu to be assessed. Minor cleanups and
uninline set_load_weight().

Signed-off-by: Con Kolivas <kernel@kolivas.org>

---
 include/linux/sched.h |    4 ++--
 kernel/sched.c        |   24 ++++++------------------
 2 files changed, 8 insertions(+), 20 deletions(-)

Index: linux-2.6.16-rc6-mm1/include/linux/sched.h
===================================================================
--- linux-2.6.16-rc6-mm1.orig/include/linux/sched.h	2006-03-13 10:08:36.000000000 +1100
+++ linux-2.6.16-rc6-mm1/include/linux/sched.h	2006-03-13 18:29:37.000000000 +1100
@@ -546,9 +546,9 @@ enum idle_type
 /*
  * sched-domains (multiprocessor balancing) declarations:
  */
-#ifdef CONFIG_SMP
 #define SCHED_LOAD_SCALE	128UL	/* increase resolution of load */
 
+#ifdef CONFIG_SMP
 #define SD_LOAD_BALANCE		1	/* Do load balancing on this domain. */
 #define SD_BALANCE_NEWIDLE	2	/* Balance when about to become idle */
 #define SD_BALANCE_EXEC		4	/* Balance on exec */
@@ -704,8 +704,8 @@ struct task_struct {
 #ifdef __ARCH_WANT_UNLOCKED_CTXSW
 	int oncpu;
 #endif
-	int load_weight;	/* for load balancing purposes */
 #endif
+	int load_weight;	/* for niceness load balancing purposes */
 	int prio, static_prio;
 	struct list_head run_list;
 	prio_array_t *array;
Index: linux-2.6.16-rc6-mm1/kernel/sched.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/kernel/sched.c	2006-03-13 10:08:36.000000000 +1100
+++ linux-2.6.16-rc6-mm1/kernel/sched.c	2006-03-13 18:29:37.000000000 +1100
@@ -170,12 +170,12 @@
  */
 
 #define SCALE_PRIO(x, prio) \
-	max(x * (MAX_PRIO - prio) / (MAX_USER_PRIO/2), MIN_TIMESLICE)
+	max(x * (MAX_PRIO - prio) / (MAX_USER_PRIO / 2), MIN_TIMESLICE)
 
 static unsigned int static_prio_timeslice(int static_prio)
 {
 	if (static_prio < NICE_TO_PRIO(0))
-		return SCALE_PRIO(DEF_TIMESLICE*4, static_prio);
+		return SCALE_PRIO(DEF_TIMESLICE * 4, static_prio);
 	else
 		return SCALE_PRIO(DEF_TIMESLICE, static_prio);
 }
@@ -217,8 +217,8 @@ struct runqueue {
 	 * remote CPUs use both these fields when doing load calculation.
 	 */
 	unsigned long nr_running;
-#ifdef CONFIG_SMP
 	unsigned long raw_weighted_load;
+#ifdef CONFIG_SMP
 	unsigned long cpu_load[3];
 #endif
 	unsigned long long nr_switches;
@@ -672,7 +672,6 @@ static int effective_prio(task_t *p)
 	return prio;
 }
 
-#ifdef CONFIG_SMP
 /*
  * To aid in avoiding the subversion of "niceness" due to uneven distribution
  * of tasks with abnormal "nice" values across CPUs the contribution that
@@ -695,9 +694,10 @@ static int effective_prio(task_t *p)
 #define RTPRIO_TO_LOAD_WEIGHT(rp) \
 	(PRIO_TO_LOAD_WEIGHT(MAX_RT_PRIO) + LOAD_WEIGHT(rp))
 
-static inline void set_load_weight(task_t *p)
+static void set_load_weight(task_t *p)
 {
 	if (rt_task(p)) {
+#ifdef CONFIG_SMP
 		if (p == task_rq(p)->migration_thread)
 			/*
 			 * The migration thread does the actual balancing.
@@ -706,6 +706,7 @@ static inline void set_load_weight(task_
 			 */
 			p->load_weight = 0;
 		else
+#endif
 			p->load_weight = RTPRIO_TO_LOAD_WEIGHT(p->rt_priority);
 	} else
 		p->load_weight = PRIO_TO_LOAD_WEIGHT(p->static_prio);
@@ -720,19 +721,6 @@ static inline void dec_raw_weighted_load
 {
 	rq->raw_weighted_load -= p->load_weight;
 }
-#else
-static inline void set_load_weight(task_t *p)
-{
-}
-
-static inline void inc_raw_weighted_load(runqueue_t *rq, const task_t *p)
-{
-}
-
-static inline void dec_raw_weighted_load(runqueue_t *rq, const task_t *p)
-{
-}
-#endif
 
 static inline void inc_nr_running(task_t *p, runqueue_t *rq)
 {
