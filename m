Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbWEBGR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWEBGR6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 02:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbWEBGR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 02:17:58 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:18818 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932393AbWEBGR5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 02:17:57 -0400
Date: Tue, 2 May 2006 11:45:05 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: lse-tech@lists.sourceforge.net, jlan@engr.sgi.com
Subject: [Patch 3/8] cpu delay collection via schedstats
Message-ID: <20060502061505.GN13962@in.ibm.com>
Reply-To: balbir@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Changelog

Fixes comments by akpm
- comments about locking used in rq_sched_info_arrive/depart

No fix needed/possible
- redundant extern declaration of delayacct_on in sched.h
suggested location (delayacct.h) cannot be used as it includes sched.h
extern declaration moved to where its needed
- move unlikely declaration inside sched_info_on
Function only returns constants. Cannot be done.
- removal of #if defined in sched_fork (Dave Hansen)
Refactoring suggested does not work if only SCHEDSTATS is configured

delayacct-shedstats.patch

Make the task-related schedstats functions
callable by delay accounting even if schedstats
collection isn't turned on. This removes the
dependency of delay accounting on schedstats.

Signed-off-by: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>
Signed-off-by: Balbir Singh <balbir@in.ibm.com>
---

 include/linux/sched.h |   20 ++++++++++++++---
 kernel/sched.c        |   58 +++++++++++++++++++++++++++++++++++---------------
 2 files changed, 58 insertions(+), 20 deletions(-)

diff -puN include/linux/sched.h~delayacct-schedstats include/linux/sched.h
--- linux-2.6.17-rc3/include/linux/sched.h~delayacct-schedstats	2006-05-02 07:31:18.000000000 +0530
+++ linux-2.6.17-rc3-balbir/include/linux/sched.h	2006-05-02 07:34:27.000000000 +0530
@@ -521,7 +521,7 @@ typedef struct prio_array prio_array_t;
 struct backing_dev_info;
 struct reclaim_state;
 
-#ifdef CONFIG_SCHEDSTATS
+#if defined(CONFIG_SCHEDSTATS) || defined(CONFIG_TASK_DELAY_ACCT)
 struct sched_info {
 	/* cumulative counters */
 	unsigned long	cpu_time,	/* time spent on the cpu */
@@ -532,9 +532,11 @@ struct sched_info {
 	unsigned long	last_arrival,	/* when we last ran on a cpu */
 			last_queued;	/* when we were last queued to run */
 };
+#endif /* defined(CONFIG_SCHEDSTATS) || defined(CONFIG_TASK_DELAY_ACCT) */
 
+#ifdef CONFIG_SCHEDSTATS
 extern struct file_operations proc_schedstat_operations;
-#endif
+#endif /* CONFIG_SCHEDSTATS */
 
 #ifdef CONFIG_TASK_DELAY_ACCT
 struct task_delay_info {
@@ -557,7 +559,19 @@ struct task_delay_info {
 	u32 blkio_count;
 	u32 swapin_count;
 };
+#endif	/* CONFIG_TASK_DELAY_ACCT */
+
+static inline int sched_info_on(void)
+{
+#ifdef CONFIG_SCHEDSTATS
+	return 1;
+#elif defined(CONFIG_TASK_DELAY_ACCT)
+	extern int delayacct_on;
+	return delayacct_on;
+#else
+	return 0;
 #endif
+}
 
 enum idle_type
 {
@@ -744,7 +758,7 @@ struct task_struct {
 	cpumask_t cpus_allowed;
 	unsigned int time_slice, first_time_slice;
 
-#ifdef CONFIG_SCHEDSTATS
+#if defined(CONFIG_SCHEDSTATS) || defined(CONFIG_TASK_DELAY_ACCT)
 	struct sched_info sched_info;
 #endif
 
diff -puN kernel/sched.c~delayacct-schedstats kernel/sched.c
--- linux-2.6.17-rc3/kernel/sched.c~delayacct-schedstats	2006-05-02 07:31:18.000000000 +0530
+++ linux-2.6.17-rc3-balbir/kernel/sched.c	2006-05-02 07:31:18.000000000 +0530
@@ -469,9 +469,34 @@ struct file_operations proc_schedstat_op
 	.release = single_release,
 };
 
+/*
+ * Expects runqueue lock to be held for atomicity of update
+ */
+static inline void rq_sched_info_arrive(struct runqueue *rq,
+						unsigned long diff)
+{
+	if (rq) {
+		rq->rq_sched_info.run_delay += diff;
+		rq->rq_sched_info.pcnt++;
+	}
+}
+
+/*
+ * Expects runqueue lock to be held for atomicity of update
+ */
+static inline void rq_sched_info_depart(struct runqueue *rq,
+						unsigned long diff)
+{
+	if (rq)
+		rq->rq_sched_info.cpu_time += diff;
+}
 # define schedstat_inc(rq, field)	do { (rq)->field++; } while (0)
 # define schedstat_add(rq, field, amt)	do { (rq)->field += (amt); } while (0)
 #else /* !CONFIG_SCHEDSTATS */
+static inline void rq_sched_info_arrive(struct runqueue *rq, unsigned long diff)
+{}
+static inline void rq_sched_info_depart(struct runqueue *rq, unsigned long diff)
+{}
 # define schedstat_inc(rq, field)	do { } while (0)
 # define schedstat_add(rq, field, amt)	do { } while (0)
 #endif
@@ -491,7 +516,7 @@ static inline runqueue_t *this_rq_lock(v
 	return rq;
 }
 
-#ifdef CONFIG_SCHEDSTATS
+#if defined(CONFIG_SCHEDSTATS) || defined(CONFIG_TASK_DELAY_ACCT)
 /*
  * Called when a process is dequeued from the active array and given
  * the cpu.  We should note that with the exception of interactive
@@ -520,7 +545,6 @@ static inline void sched_info_dequeued(t
 static void sched_info_arrive(task_t *t)
 {
 	unsigned long now = jiffies, diff = 0;
-	struct runqueue *rq = task_rq(t);
 
 	if (t->sched_info.last_queued)
 		diff = now - t->sched_info.last_queued;
@@ -529,11 +553,7 @@ static void sched_info_arrive(task_t *t)
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
@@ -553,8 +573,9 @@ static void sched_info_arrive(task_t *t)
  */
 static inline void sched_info_queued(task_t *t)
 {
-	if (!t->sched_info.last_queued)
-		t->sched_info.last_queued = jiffies;
+	if (unlikely(sched_info_on()))
+		if (!t->sched_info.last_queued)
+			t->sched_info.last_queued = jiffies;
 }
 
 /*
@@ -563,13 +584,10 @@ static inline void sched_info_queued(tas
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
@@ -577,7 +595,7 @@ static inline void sched_info_depart(tas
  * their time slice.  (This may also be called when switching to or from
  * the idle task.)  We are only called when prev != next.
  */
-static inline void sched_info_switch(task_t *prev, task_t *next)
+static inline void __sched_info_switch(task_t *prev, task_t *next)
 {
 	struct runqueue *rq = task_rq(prev);
 
@@ -592,10 +610,15 @@ static inline void sched_info_switch(tas
 	if (next != rq->idle)
 		sched_info_arrive(next);
 }
+static inline void sched_info_switch(task_t *prev, task_t *next)
+{
+	if (unlikely(sched_info_on()))
+		__sched_info_switch(prev, next);
+}
 #else
 #define sched_info_queued(t)		do { } while (0)
 #define sched_info_switch(t, next)	do { } while (0)
-#endif /* CONFIG_SCHEDSTATS */
+#endif /* CONFIG_SCHEDSTATS || CONFIG_TASK_DELAY_ACCT */
 
 /*
  * Adding/removing a task to/from a priority array:
@@ -1393,8 +1416,9 @@ void fastcall sched_fork(task_t *p, int 
 	p->state = TASK_RUNNING;
 	INIT_LIST_HEAD(&p->run_list);
 	p->array = NULL;
-#ifdef CONFIG_SCHEDSTATS
-	memset(&p->sched_info, 0, sizeof(p->sched_info));
+#if defined(CONFIG_SCHEDSTATS) || defined(CONFIG_TASK_DELAY_ACCT)
+	if (unlikely(sched_info_on()))
+		memset(&p->sched_info, 0, sizeof(p->sched_info));
 #endif
 #if defined(CONFIG_SMP) && defined(__ARCH_WANT_UNLOCKED_CTXSW)
 	p->oncpu = 0;
_
