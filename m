Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWDVVSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWDVVSL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 17:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWDVVSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 17:18:11 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:16859 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751223AbWDVVSJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 17:18:09 -0400
Message-ID: <44499604.4010400@watson.ibm.com>
Date: Fri, 21 Apr 2006 22:33:40 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: LSE <lse-tech@lists.sourceforge.net>, Jay Lan <jlan@engr.sgi.com>
Subject: [Patch 3/8] cpu delay collection via schedstats
References: <444991EF.3080708@watson.ibm.com>
In-Reply-To: <444991EF.3080708@watson.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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

 include/linux/sched.h |   21 +++++++++++++++---
 kernel/sched.c        |   56 ++++++++++++++++++++++++++++++++++----------------
 2 files changed, 56 insertions(+), 21 deletions(-)

Index: linux-2.6.17-rc1/include/linux/sched.h
===================================================================
--- linux-2.6.17-rc1.orig/include/linux/sched.h	2006-04-21 20:29:13.000000000 -0400
+++ linux-2.6.17-rc1/include/linux/sched.h	2006-04-21 20:29:15.000000000 -0400
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
@@ -557,8 +559,19 @@ struct task_delay_info {
 	u32 blkio_count;
 	u32 swapin_count;
 };
-#endif
+#endif	/* CONFIG_TASK_DELAY_ACCT */

+static inline int sched_info_on(void)
+{
+#ifdef CONFIG_SCHEDSTATS
+	return 1;
+#elif defined(CONFIG_TASK_DELAY_ACCT)
+	extern int delayacct_on;
+	return delayacct_on;
+#else
+	return 0;
+#endif
+}

 enum idle_type
 {
@@ -744,7 +757,7 @@ struct task_struct {
 	cpumask_t cpus_allowed;
 	unsigned int time_slice, first_time_slice;

-#ifdef CONFIG_SCHEDSTATS
+#if defined(CONFIG_SCHEDSTATS) || defined(CONFIG_TASK_DELAY_ACCT)
 	struct sched_info sched_info;
 #endif

Index: linux-2.6.17-rc1/kernel/sched.c
===================================================================
--- linux-2.6.17-rc1.orig/kernel/sched.c	2006-04-21 20:29:13.000000000 -0400
+++ linux-2.6.17-rc1/kernel/sched.c	2006-04-21 20:29:15.000000000 -0400
@@ -469,9 +469,32 @@ struct file_operations proc_schedstat_op
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
+static inline void rq_sched_info_arrive(struct runqueue *rq, unsigned long diff) {}
+static inline void rq_sched_info_depart(struct runqueue *rq, unsigned long diff) {}
 # define schedstat_inc(rq, field)	do { } while (0)
 # define schedstat_add(rq, field, amt)	do { } while (0)
 #endif
@@ -491,7 +514,7 @@ static inline runqueue_t *this_rq_lock(v
 	return rq;
 }

-#ifdef CONFIG_SCHEDSTATS
+#if defined(CONFIG_SCHEDSTATS) || defined(CONFIG_TASK_DELAY_ACCT)
 /*
  * Called when a process is dequeued from the active array and given
  * the cpu.  We should note that with the exception of interactive
@@ -520,7 +543,6 @@ static inline void sched_info_dequeued(t
 static void sched_info_arrive(task_t *t)
 {
 	unsigned long now = jiffies, diff = 0;
-	struct runqueue *rq = task_rq(t);

 	if (t->sched_info.last_queued)
 		diff = now - t->sched_info.last_queued;
@@ -529,11 +551,7 @@ static void sched_info_arrive(task_t *t)
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
@@ -553,8 +571,9 @@ static void sched_info_arrive(task_t *t)
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
@@ -563,13 +582,10 @@ static inline void sched_info_queued(tas
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
@@ -577,7 +593,7 @@ static inline void sched_info_depart(tas
  * their time slice.  (This may also be called when switching to or from
  * the idle task.)  We are only called when prev != next.
  */
-static inline void sched_info_switch(task_t *prev, task_t *next)
+static inline void __sched_info_switch(task_t *prev, task_t *next)
 {
 	struct runqueue *rq = task_rq(prev);

@@ -592,10 +608,15 @@ static inline void sched_info_switch(tas
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
@@ -1351,8 +1372,9 @@ void fastcall sched_fork(task_t *p, int
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
