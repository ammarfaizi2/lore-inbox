Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbWC3Amc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWC3Amc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 19:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWC3Amc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 19:42:32 -0500
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:5057 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751208AbWC3Amc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 19:42:32 -0500
Message-ID: <442B2967.6010704@watson.ibm.com>
Date: Wed, 29 Mar 2006 19:42:15 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Patch 3/8] cpu delays
References: <442B271D.10208@watson.ibm.com>
In-Reply-To: <442B271D.10208@watson.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

delayacct-schedstats.patch

Make the task-related schedstats functions
callable by delay accounting even if schedstats
collection isn't turned on. This removes the
dependency of delay accounting on schedstats and allows
cpu delays to be exported.

Signed-off-by: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>

 include/linux/sched.h |   10 +++++---
 kernel/sched.c        |   59 ++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 50 insertions(+), 19 deletions(-)

Index: linux-2.6.16/include/linux/sched.h
===================================================================
--- linux-2.6.16.orig/include/linux/sched.h	2006-03-29 18:13:13.000000000 -0500
+++ linux-2.6.16/include/linux/sched.h	2006-03-29 18:13:15.000000000 -0500
@@ -525,7 +525,7 @@ typedef struct prio_array prio_array_t;
 struct backing_dev_info;
 struct reclaim_state;

-#ifdef CONFIG_SCHEDSTATS
+#if defined(CONFIG_SCHEDSTATS) || defined(CONFIG_TASK_DELAY_ACCT)
 struct sched_info {
 	/* cumulative counters */
 	unsigned long	cpu_time,	/* time spent on the cpu */
@@ -537,10 +537,14 @@ struct sched_info {
 			last_queued;	/* when we were last queued to run */
 };

+#ifdef CONFIG_SCHEDSTATS
 extern struct file_operations proc_schedstat_operations;
-#endif
+#endif /* CONFIG_SCHEDSTATS */
+#endif /* defined(CONFIG_SCHEDSTATS) || defined(CONFIG_TASK_DELAY_ACCT) */

 #ifdef CONFIG_TASK_DELAY_ACCT
+extern int delayacct_on;
+
 struct task_delay_info {
 	spinlock_t	lock;

@@ -736,7 +740,7 @@ struct task_struct {
 	cpumask_t cpus_allowed;
 	unsigned int time_slice, first_time_slice;

-#ifdef CONFIG_SCHEDSTATS
+#if defined(CONFIG_SCHEDSTATS) || defined(CONFIG_TASK_DELAY_ACCT)
 	struct sched_info sched_info;
 #endif

Index: linux-2.6.16/kernel/sched.c
===================================================================
--- linux-2.6.16.orig/kernel/sched.c	2006-03-29 18:13:13.000000000 -0500
+++ linux-2.6.16/kernel/sched.c	2006-03-29 18:13:15.000000000 -0500
@@ -466,9 +466,26 @@ struct file_operations proc_schedstat_op
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
@@ -488,7 +505,18 @@ static inline runqueue_t *this_rq_lock(v
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
+	return delayacct_on;
+#endif
+}
+
 /*
  * Called when a process is dequeued from the active array and given
  * the cpu.  We should note that with the exception of interactive
@@ -517,7 +545,6 @@ static inline void sched_info_dequeued(t
 static void sched_info_arrive(task_t *t)
 {
 	unsigned long now = jiffies, diff = 0;
-	struct runqueue *rq = task_rq(t);

 	if (t->sched_info.last_queued)
 		diff = now - t->sched_info.last_queued;
@@ -526,11 +553,7 @@ static void sched_info_arrive(task_t *t)
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
@@ -550,8 +573,9 @@ static void sched_info_arrive(task_t *t)
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
@@ -560,13 +584,10 @@ static inline void sched_info_queued(tas
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
@@ -574,7 +595,7 @@ static inline void sched_info_depart(tas
  * their time slice.  (This may also be called when switching to or from
  * the idle task.)  We are only called when prev != next.
  */
-static inline void sched_info_switch(task_t *prev, task_t *next)
+static inline void __sched_info_switch(task_t *prev, task_t *next)
 {
 	struct runqueue *rq = task_rq(prev);

@@ -589,10 +610,15 @@ static inline void sched_info_switch(tas
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
@@ -1346,8 +1372,9 @@ void fastcall sched_fork(task_t *p, int
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
