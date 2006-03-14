Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932527AbWCNBBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbWCNBBv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 20:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932530AbWCNBBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 20:01:51 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:54762 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932527AbWCNBBu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 20:01:50 -0500
Subject: [Patch 6/9] cpu delay collection
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>
In-Reply-To: <1142296834.5858.3.camel@elinux04.optonline.net>
References: <1142296834.5858.3.camel@elinux04.optonline.net>
Content-Type: text/plain
Organization: IBM
Message-Id: <1142298108.5858.36.camel@elinux04.optonline.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 13 Mar 2006 20:01:48 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

delayacct-schedstats.patch

Collect cpu delays through the 
task-related schedstats functions, extracted
as common code to remove dependence of delay 
accounting on rest of schedstats. 

Signed-off-by: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>

 include/linux/sched.h |    8 +++++---
 kernel/sched.c        |   49 +++++++++++++++++++++++++++++++++++++------------
 2 files changed, 42 insertions(+), 15 deletions(-)

Index: linux-2.6.16-rc5/include/linux/sched.h
===================================================================
--- linux-2.6.16-rc5.orig/include/linux/sched.h	2006-03-11 07:41:39.000000000 -0500
+++ linux-2.6.16-rc5/include/linux/sched.h	2006-03-11 07:41:40.000000000 -0500
@@ -524,7 +524,7 @@ typedef struct prio_array prio_array_t;
 struct backing_dev_info;
 struct reclaim_state;
 
-#ifdef CONFIG_SCHEDSTATS
+#if defined(CONFIG_SCHEDSTATS) || defined(CONFIG_TASK_DELAY_ACCT)
 struct sched_info {
 	/* cumulative counters */
 	unsigned long	cpu_time,	/* time spent on the cpu */
@@ -536,8 +536,10 @@ struct sched_info {
 			last_queued;	/* when we were last queued to run */
 };
 
+#ifdef CONFIG_SCHEDSTATS
 extern struct file_operations proc_schedstat_operations;
-#endif
+#endif /* CONFIG_SCHEDSTATS */
+#endif /* defined(CONFIG_SCHEDSTATS) || defined(CONFIG_TASK_DELAY_ACCT) */
 
 #ifdef CONFIG_TASK_DELAY_ACCT
 struct task_delay_info {
@@ -735,7 +737,7 @@ struct task_struct {
 	cpumask_t cpus_allowed;
 	unsigned int time_slice, first_time_slice;
 
-#ifdef CONFIG_SCHEDSTATS
+#if defined(CONFIG_SCHEDSTATS) || defined(CONFIG_TASK_DELAY_ACCT)
 	struct sched_info sched_info;
 #endif
 
Index: linux-2.6.16-rc5/kernel/sched.c
===================================================================
--- linux-2.6.16-rc5.orig/kernel/sched.c	2006-03-11 07:41:39.000000000 -0500
+++ linux-2.6.16-rc5/kernel/sched.c	2006-03-11 07:41:40.000000000 -0500
@@ -473,9 +473,26 @@ struct file_operations proc_schedstat_op
 	.release = single_release,
 };
 
+static inline void rq_sched_info_arrive(struct runqueue *rq,
+						unsigned long diff)
+{
+	if (rq) {
+		rq->rq_sched_info.run_delay += diff;
+		rq->rq_sched_info.pcnt++;
+	}
+}
+
+static inline void rq_sched_info_depart(struct runqueue *rq,
+						unsigned long diff)
+{
+	if (rq)
+		rq->rq_sched_info.cpu_time += diff;
+}
 # define schedstat_inc(rq, field)	do { (rq)->field++; } while (0)
 # define schedstat_add(rq, field, amt)	do { (rq)->field += (amt); } while (0)
 #else /* !CONFIG_SCHEDSTATS */
+static inline void rq_sched_info_arrive(struct runqueue *rq, unsigned long diff) {}
+static inline void rq_sched_info_depart(struct runqueue *rq, unsigned long diff) {}
 # define schedstat_inc(rq, field)	do { } while (0)
 # define schedstat_add(rq, field, amt)	do { } while (0)
 #endif
@@ -495,7 +512,19 @@ static inline runqueue_t *this_rq_lock(v
 	return rq;
 }
 
+#if defined(CONFIG_SCHEDSTATS) || defined(CONFIG_TASK_DELAY_ACCT)
+
+static inline int sched_info_on(void)
+{
 #ifdef CONFIG_SCHEDSTATS
+	return 1;
+#endif
+#ifdef CONFIG_TASK_DELAY_ACCT
+	extern int delayacct_on;
+	return delayacct_on;
+#endif
+}
+
 /*
  * Called when a process is dequeued from the active array and given
  * the cpu.  We should note that with the exception of interactive
@@ -524,7 +553,6 @@ static inline void sched_info_dequeued(t
 static void sched_info_arrive(task_t *t)
 {
 	unsigned long now = jiffies, diff = 0;
-	struct runqueue *rq = task_rq(t);
 
 	if (t->sched_info.last_queued)
 		diff = now - t->sched_info.last_queued;
@@ -533,11 +561,7 @@ static void sched_info_arrive(task_t *t)
 	t->sched_info.last_arrival = now;
 	t->sched_info.pcnt++;
 
-	if (!rq)
-		return;
-
-	rq->rq_sched_info.run_delay += diff;
-	rq->rq_sched_info.pcnt++;
+	rq_sched_info_arrive(task_rq(t), diff);
 }
 
 /*
@@ -557,8 +581,9 @@ static void sched_info_arrive(task_t *t)
  */
 static inline void sched_info_queued(task_t *t)
 {
-	if (!t->sched_info.last_queued)
-		t->sched_info.last_queued = jiffies;
+	if (sched_info_on())
+		if (!t->sched_info.last_queued)
+			t->sched_info.last_queued = jiffies;
 }
 
 /*
@@ -567,13 +592,10 @@ static inline void sched_info_queued(tas
  */
 static inline void sched_info_depart(task_t *t)
 {
-	struct runqueue *rq = task_rq(t);
 	unsigned long diff = jiffies - t->sched_info.last_arrival;
 
 	t->sched_info.cpu_time += diff;
-
-	if (rq)
-		rq->rq_sched_info.cpu_time += diff;
+	rq_sched_info_depart(task_rq(t), diff);
 }
 
 /*
@@ -585,6 +607,9 @@ static inline void sched_info_switch(tas
 {
 	struct runqueue *rq = task_rq(prev);
 
+ 	if (!sched_info_on())
+		return;
+
 	/*
 	 * prev now departs the cpu.  It's not interesting to record
 	 * stats about how efficient we were at scheduling the idle


