Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264775AbUFGPOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264775AbUFGPOA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 11:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264777AbUFGPMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 11:12:51 -0400
Received: from holomorphy.com ([207.189.100.168]:37303 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263100AbUFGPL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 11:11:26 -0400
Date: Mon, 7 Jun 2004 08:11:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [PATCH] Staircase Scheduler v6.3 for 2.6.7-rc2
Message-ID: <20040607151115.GD21007@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Con Kolivas <kernel@kolivas.org>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
	Zwane Mwaikambo <zwane@linuxpower.ca>
References: <200406070139.38433.kernel@kolivas.org> <20040607135631.GY21007@holomorphy.com> <20040607135738.GZ21007@holomorphy.com> <20040607140445.GA21007@holomorphy.com> <20040607140714.GB21007@holomorphy.com> <20040607150037.GC21007@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040607150037.GC21007@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2004 at 07:07:14AM -0700, William Lee Irwin III wrote:
>> cpu_to_node_mask() is dead.

On Mon, Jun 07, 2004 at 08:00:37AM -0700, William Lee Irwin III wrote:
> task->array is nothing more than a boolean flag. Shove it into
> task->thread_info->flags, saving sizeof(prio_array_t *) from sizeof(task_t).
> Compiletested only on sparc64 only.

prio_array_t is no longer a useful abstraction. Compiletested only on
sparc64 only.


Index: kolivas-2.6.7-rc2/kernel/sched.c
===================================================================
--- kolivas-2.6.7-rc2.orig/kernel/sched.c	2004-06-07 07:59:22.711997000 -0700
+++ kolivas-2.6.7-rc2/kernel/sched.c	2004-06-07 08:07:09.705003000 -0700
@@ -81,15 +81,8 @@
  * These are the runqueue data structures:
  */
 
-#define BITMAP_SIZE ((((MAX_PRIO+1+7)/8)+sizeof(long)-1)/sizeof(long))
-
 typedef struct runqueue runqueue_t;
 
-typedef struct prio_array {
-	unsigned long bitmap[BITMAP_SIZE];
-	struct list_head queue[MAX_PRIO + 1];
-} prio_array_t;
-
 /*
  * This is the main, per-CPU runqueue data structure.
  *
@@ -113,7 +106,8 @@
 	unsigned long long timestamp_last_tick;
 	task_t *curr, *idle;
 	struct mm_struct *prev_mm;
-	prio_array_t array;
+	unsigned long bitmap[BITS_TO_LONGS(MAX_PRIO+1)];
+	struct list_head queue[MAX_PRIO + 1];
 	atomic_t nr_iowait;
 
 #ifdef CONFIG_SMP
@@ -207,21 +201,19 @@
 }
 
 /*
- * Adding/removing a task to/from a priority array:
+ * Adding/removing a task to/from a runqueue:
  */
 static void dequeue_task(struct task_struct *p, runqueue_t *rq)
 {
-	prio_array_t* array = &rq->array;
 	list_del(&p->run_list);
-	if (list_empty(array->queue + p->prio))
-		__clear_bit(p->prio, array->bitmap);
+	if (list_empty(rq->queue + p->prio))
+		__clear_bit(p->prio, rq->bitmap);
 }
 
 static void enqueue_task(struct task_struct *p, runqueue_t *rq)
 {
-	prio_array_t* array = &rq->array;
-	list_add_tail(&p->run_list, array->queue + p->prio);
-	__set_bit(p->prio, array->bitmap);
+	list_add_tail(&p->run_list, rq->queue + p->prio);
+	__set_bit(p->prio, rq->bitmap);
 	set_task_queued(p);
 }
 
@@ -232,9 +224,8 @@
  */
 static inline void enqueue_task_head(struct task_struct *p, runqueue_t *rq)
 {
-	prio_array_t* array = &rq->array;
-	list_add(&p->run_list, array->queue + p->prio);
-	__set_bit(p->prio, array->bitmap);
+	list_add(&p->run_list, rq->queue + p->prio);
+	__set_bit(p->prio, rq->bitmap);
 	set_task_queued(p);
 }
 
@@ -1257,27 +1248,24 @@
 		      unsigned long max_nr_move, struct sched_domain *sd,
 		      enum idle_type idle)
 {
-	prio_array_t* array, *dst_array;
 	struct list_head *head, *curr;
 	int idx, pulled = 0;
 	task_t *tmp;
 
 	if (max_nr_move <= 0 || busiest->nr_running <= 1)
 		goto out;
-	array = &busiest->array;
-	dst_array = &this_rq->array;
 
 	/* Start searching at priority 0: */
 	idx = 0;
 skip_bitmap:
 	if (!idx)
-		idx = sched_find_first_bit(array->bitmap);
+		idx = sched_find_first_bit(busiest->bitmap);
 	else
-		idx = find_next_bit(array->bitmap, MAX_PRIO, idx);
+		idx = find_next_bit(busiest->bitmap, MAX_PRIO, idx);
 	if (idx >= MAX_PRIO) 
 		goto out;
 
-	head = array->queue + idx;
+	head = busiest->queue + idx;
 	curr = head->prev;
 skip_queue:
 	tmp = list_entry(curr, task_t, run_list);
@@ -1919,7 +1907,6 @@
 	long *switch_count;
 	task_t *prev, *next;
 	runqueue_t *rq;
-	prio_array_t* array;
 	struct list_head *queue;
 	unsigned long long now;
 	int cpu, idx;
@@ -1971,9 +1958,8 @@
 		}
 	}
 
-	array = &rq->array;
-	idx = sched_find_first_bit(array->bitmap);
-	queue = array->queue + idx;
+	idx = sched_find_first_bit(rq->bitmap);
+	queue = rq->queue + idx;
 	next = list_entry(queue->next, task_t, run_list);
 
 	if (dependent_sleeper(cpu, rq, next))
@@ -3590,8 +3576,6 @@
 #endif
 
 	for (i = 0; i < NR_CPUS; i++) {
-		prio_array_t* array;
-
 		rq = cpu_rq(i);
 		spin_lock_init(&rq->lock);
 
@@ -3604,14 +3588,11 @@
 		INIT_LIST_HEAD(&rq->migration_queue);
 #endif
 		atomic_set(&rq->nr_iowait, 0);
-		array = &rq->array;
-
-		for (j = 0; j <= MAX_PRIO; j++) {
-			INIT_LIST_HEAD(array->queue + j);
-			__clear_bit(j, array->bitmap);
-		}
+		for (j = 0; j <= MAX_PRIO; j++)
+			INIT_LIST_HEAD(&rq->queue[j]);
+		memset(rq->bitmap, 0, BITS_TO_LONGS(MAX_PRIO+1)*sizeof(long));
 		// delimiter for bitsearch
-		__set_bit(MAX_PRIO, array->bitmap);
+		__set_bit(MAX_PRIO, rq->bitmap);
 	}
 	/*
 	 * We have to do a little magic to get the first
