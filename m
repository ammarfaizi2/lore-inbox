Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbWCQNFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbWCQNFS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 08:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWCQNFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 08:05:17 -0500
Received: from mail27.syd.optusnet.com.au ([211.29.133.168]:6792 "EHLO
	mail27.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932177AbWCQNFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 08:05:15 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH][2/2] sched: sched.c runqueue_t cleanup
Date: Sat, 18 Mar 2006 00:04:59 +1100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 4263
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200603180004.59946.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace all struct runqueue instances in sched.c with runqueue_t

Signed-off-by: Con Kolivas <kernel@kolivas.org>

---
 kernel/sched.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

Index: linux-2.6.16-rc6-mm1/kernel/sched.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/kernel/sched.c	2006-03-18 00:02:37.000000000 +1100
+++ linux-2.6.16-rc6-mm1/kernel/sched.c	2006-03-18 00:02:43.000000000 +1100
@@ -194,8 +194,6 @@ static inline unsigned int task_timeslic
 
 #define BITMAP_SIZE ((((MAX_PRIO+1+7)/8)+sizeof(long)-1)/sizeof(long))
 
-typedef struct runqueue runqueue_t;
-
 struct prio_array {
 	unsigned int nr_active;
 	unsigned long bitmap[BITMAP_SIZE];
@@ -271,7 +269,9 @@ struct runqueue {
 #endif
 };
 
-static DEFINE_PER_CPU(struct runqueue, runqueues);
+typedef struct runqueue runqueue_t;
+
+static DEFINE_PER_CPU(runqueue_t, runqueues);
 
 /*
  * The domain tree (rq->sd) is protected by RCU's quiescent state transition.
@@ -366,7 +366,7 @@ static inline void finish_lock_switch(ru
 static inline runqueue_t *task_rq_lock(task_t *p, unsigned long *flags)
 	__acquires(rq->lock)
 {
-	struct runqueue *rq;
+	runqueue_t *rq;
 
 repeat_lock_task:
 	local_irq_save(*flags);
@@ -527,7 +527,7 @@ static inline void sched_info_dequeued(t
 static void sched_info_arrive(task_t *t)
 {
 	unsigned long now = jiffies, diff = 0;
-	struct runqueue *rq = task_rq(t);
+	runqueue_t *rq = task_rq(t);
 
 	if (t->sched_info.last_queued)
 		diff = now - t->sched_info.last_queued;
@@ -570,7 +570,7 @@ static inline void sched_info_queued(tas
  */
 static inline void sched_info_depart(task_t *t)
 {
-	struct runqueue *rq = task_rq(t);
+	runqueue_t *rq = task_rq(t);
 	unsigned long diff = jiffies - t->sched_info.last_arrival;
 
 	t->sched_info.cpu_time += diff;
@@ -586,7 +586,7 @@ static inline void sched_info_depart(tas
  */
 static inline void sched_info_switch(task_t *prev, task_t *next)
 {
-	struct runqueue *rq = task_rq(prev);
+	runqueue_t *rq = task_rq(prev);
 
 	/*
 	 * prev now departs the cpu.  It's not interesting to record
@@ -4257,7 +4257,7 @@ EXPORT_SYMBOL(yield);
  */
 void __sched io_schedule(void)
 {
-	struct runqueue *rq = &per_cpu(runqueues, raw_smp_processor_id());
+	runqueue_t *rq = &per_cpu(runqueues, raw_smp_processor_id());
 
 	atomic_inc(&rq->nr_iowait);
 	schedule();
@@ -4268,7 +4268,7 @@ EXPORT_SYMBOL(io_schedule);
 
 long __sched io_schedule_timeout(long timeout)
 {
-	struct runqueue *rq = &per_cpu(runqueues, raw_smp_processor_id());
+	runqueue_t *rq = &per_cpu(runqueues, raw_smp_processor_id());
 	long ret;
 
 	atomic_inc(&rq->nr_iowait);
@@ -4790,7 +4790,7 @@ void idle_task_exit(void)
 
 static void migrate_dead(unsigned int dead_cpu, task_t *tsk)
 {
-	struct runqueue *rq = cpu_rq(dead_cpu);
+	runqueue_t *rq = cpu_rq(dead_cpu);
 
 	/* Must be exiting, otherwise would be on tasklist. */
 	BUG_ON(tsk->exit_state != EXIT_ZOMBIE && tsk->exit_state != EXIT_DEAD);
@@ -4816,7 +4816,7 @@ static void migrate_dead(unsigned int de
 static void migrate_dead_tasks(unsigned int dead_cpu)
 {
 	unsigned arr, i;
-	struct runqueue *rq = cpu_rq(dead_cpu);
+	runqueue_t *rq = cpu_rq(dead_cpu);
 
 	for (arr = 0; arr < 2; arr++) {
 		for (i = 0; i < MAX_PRIO; i++) {
@@ -4953,7 +4953,7 @@ static int migration_call(struct notifie
 {
 	int cpu = (long)hcpu;
 	task_t *p;
-	struct runqueue *rq;
+	runqueue_t *rq;
 	unsigned long flags;
 
 	switch (action) {
