Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316677AbSFQDvW>; Sun, 16 Jun 2002 23:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316678AbSFQDvW>; Sun, 16 Jun 2002 23:51:22 -0400
Received: from mx1.elte.hu ([157.181.1.137]:13512 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S316677AbSFQDvU>;
	Sun, 16 Jun 2002 23:51:20 -0400
Date: Mon, 17 Jun 2002 05:49:16 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Robert Love <rml@tech9.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
       <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] 2.4.19-pre10-ac2: O(1) scheduler merge, -A3.
In-Reply-To: <1024272924.922.35.camel@sinai>
Message-ID: <Pine.LNX.4.44.0206170525520.2941-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i agree with the comment fixes, except these items:

> -	if (unlikely(in_interrupt()))
> -		BUG();
> +	BUG_ON(in_interrupt());
> +

see the previous mail.

> @@ -1790,4 +1790,4 @@
>  		while (!cpu_rq(cpu_logical_map(cpu))->migration_thread)
>  			schedule_timeout(2);
>  }
> -#endif
> +#endif /* CONFIG_SMP */

and this is just silly... I can see the point in doing #if comments in
include files, but the nesting here is just so obvious.

the rest looks fine. (patch of my current 2.5 scheduler tree attached,
against 2.5.22, with some more other nonfunctional bits added as well.)

	Ingo

--- linux/kernel/sched.c.orig	Mon Jun 17 05:43:53 2002
+++ linux/kernel/sched.c	Mon Jun 17 05:42:03 2002
@@ -6,14 +6,14 @@
  *  Copyright (C) 1991-2002  Linus Torvalds
  *
  *  1996-12-23  Modified by Dave Grothe to fix bugs in semaphores and
- *              make semaphores SMP safe
+ *		make semaphores SMP safe
  *  1998-11-19	Implemented schedule_timeout() and related stuff
  *		by Andrea Arcangeli
  *  2002-01-04	New ultra-scalable O(1) scheduler by Ingo Molnar:
- *  		hybrid priority-list and round-robin design with
- *  		an array-switch method of distributing timeslices
- *  		and per-CPU runqueues.  Additional code by Davide
- *  		Libenzi, Robert Love, and Rusty Russell.
+ *		hybrid priority-list and round-robin design with
+ *		an array-switch method of distributing timeslices
+ *		and per-CPU runqueues.  Additional code by Davide
+ *		Libenzi, Robert Love, and Rusty Russell.
  */
 
 #include <linux/mm.h>
@@ -797,7 +797,8 @@
 	list_t *queue;
 	int idx;
 
-	BUG_ON(in_interrupt());
+	if (in_interrupt())
+		BUG();
 
 #if CONFIG_DEBUG_HIGHMEM
 	check_highmem_ptes();
@@ -1392,25 +1393,35 @@
 
 asmlinkage long sys_sched_yield(void)
 {
-	runqueue_t *rq;
-	prio_array_t *array;
-
-	rq = rq_lock(rq);
+	runqueue_t *rq = rq_lock(rq);
+	prio_array_t *array = current->array;
 
 	/*
-	 * Decrease the yielding task's priority by one, to avoid
-	 * livelocks. This priority loss is temporary, it's recovered
-	 * once the current timeslice expires.
+	 * There are three levels of how a yielding task will give up
+	 * the current CPU:
 	 *
-	 * If priority is already MAX_PRIO-1 then we still
-	 * roundrobin the task within the runlist.
-	 */
-	array = current->array;
-	/*
-	 * If the task has reached maximum priority (or is a RT task)
-	 * then just requeue the task to the end of the runqueue:
+	 *  #1 - it decreases its priority by one. This priority loss is
+	 *       temporary, it's recovered once the current timeslice
+	 *       expires.
+	 *
+	 *  #2 - once it has reached the lowest priority level,
+	 *       it will give up timeslices one by one. (We do not
+	 *       want to give them up all at once, it's gradual,
+	 *       to protect the casual yield()er.)
+	 *
+	 *  #3 - once all timeslices are gone we put the process into
+	 *       the expired array.
+	 *
+	 *  (special rule: RT tasks do not lose any priority, they just
+	 *  roundrobin on their current priority level.)
 	 */
-	if (likely(current->prio == MAX_PRIO-1 || rt_task(current))) {
+	if (likely(current->prio == MAX_PRIO-1)) {
+		if (current->time_slice <= 1) {
+			dequeue_task(current, rq->active);
+			enqueue_task(current, rq->expired);
+		} else
+			current->time_slice--;
+	} else if (unlikely(rt_task(current))) {
 		list_del(&current->run_list);
 		list_add_tail(&current->run_list, array->queue + current->prio);
 	} else {
@@ -1836,15 +1847,14 @@
 	int cpu;
 
 	current->cpus_allowed = 1UL << cpu_logical_map(0);
-	for (cpu = 0; cpu < smp_num_cpus; cpu++) {
+	for (cpu = 0; cpu < smp_num_cpus; cpu++)
 		if (kernel_thread(migration_thread, (void *) (long) cpu,
 				CLONE_FS | CLONE_FILES | CLONE_SIGNAL) < 0)
 			BUG();
-	}
 	current->cpus_allowed = -1L;
 
 	for (cpu = 0; cpu < smp_num_cpus; cpu++)
 		while (!cpu_rq(cpu_logical_map(cpu))->migration_thread)
 			schedule_timeout(2);
 }
-#endif /* CONFIG_SMP */
+#endif

