Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289198AbSA1O4g>; Mon, 28 Jan 2002 09:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289211AbSA1O43>; Mon, 28 Jan 2002 09:56:29 -0500
Received: from mx2.elte.hu ([157.181.151.9]:42945 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289198AbSA1O4P>;
	Mon, 28 Jan 2002 09:56:15 -0500
Date: Mon, 28 Jan 2002 17:53:48 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [patch] [sched] yield speedup, 2.5.3-pre5
Message-ID: <Pine.LNX.4.33.0201281751130.9992-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch speeds up sched_yield() context switch performance by
about 5%. (This patch depends on the previous bitmap-cleanup patch,
functionality-wise.)

instead of dequeueing/enqueue the task from the same array we can skip a
number of steps even in the generic case. If a yielded task has reached
maximum priority (as they do if they yield a number of times) then we can
skip even more steps - the task only has to be queued to the end of the
runqueue.

	Ingo

diff -rNu linux/kernel/sched.c linux/kernel/sched.c
--- linux/kernel/sched.c	Mon Jan 28 15:23:50 2002
+++ linux/kernel/sched.c	Mon Jan 28 15:24:44 2002
@@ -1084,12 +1112,22 @@
 	 */
 	spin_lock_irq(&rq->lock);
 	array = current->array;
-	dequeue_task(current, array);
-	if (likely(!rt_task(current)))
-		if (current->prio < MAX_PRIO-1)
-			current->prio++;
-	enqueue_task(current, array);
-	spin_unlock_irq(&rq->lock);
+	/*
+	 * If the task has reached maximum priority (or is a RT task)
+	 * then just requeue the task to the end of the runqueue:
+	 */
+	if (likely(current->prio == MAX_PRIO-1 || rt_task(current))) {
+		list_del(&current->run_list);
+		list_add_tail(&current->run_list, array->queue + current->prio);
+	} else {
+		list_del(&current->run_list);
+		if (list_empty(array->queue + current->prio))
+			__clear_bit(current->prio, array->bitmap);
+		current->prio++;
+		list_add_tail(&current->run_list, array->queue + current->prio);
+		__set_bit(current->prio, array->bitmap);
+	}
+	spin_unlock(&rq->lock);

 	schedule();


