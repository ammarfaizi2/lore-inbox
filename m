Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315483AbSHMPA2>; Tue, 13 Aug 2002 11:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315503AbSHMPA2>; Tue, 13 Aug 2002 11:00:28 -0400
Received: from iere.net.avaya.com ([198.152.12.101]:8933 "EHLO
	iere.net.avaya.com") by vger.kernel.org with ESMTP
	id <S315483AbSHMPA0>; Tue, 13 Aug 2002 11:00:26 -0400
Date: Tue, 13 Aug 2002 09:04:16 -0600 (MDT)
From: "Bhavesh P. Davda" <bhaveshd@drmail.dr.avaya.com>
To: linux-kernel@vger.kernel.org
cc: marcelo@conectiva.com.br
Subject: Re: Linux 2.4.20-pre2
Message-ID: <Pine.LNX.4.21.0208130859160.9829-100000@cof110earth.dr.avaya.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Aug 2002 15:04:16.0617 (UTC) FILETIME=[B1633D90:01C242DA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For the Nth time, here again is the patch for fixing the scheduler for
correct SCHED_FIFO and SCHED_RR behaviour.

I waited to see it in 2.4.20-pre1, not there, 2.4.20-pre2, not there...

Please apply it in 2.4.20-pre3

Thanks

- Bhavesh
-- 
Bhavesh P. Davda
Avaya Inc.
bhavesh@avaya.com


diff -aur linux-2.4.19/kernel/sched.c linux-2.4.19-sched/kernel/sched.c
--- linux-2.4.19/kernel/sched.c	Tue Aug  6 11:37:49 2002
+++ linux-2.4.19-sched/kernel/sched.c	Tue Aug  6 13:42:20 2002
@@ -318,13 +318,17 @@
 /*
  * Careful!
  *
- * This has to add the process to the _beginning_ of the
- * run-queue, not the end. See the comment about "This is
- * subtle" in the scheduler proper..
+ * This has to add the process to the _end_ of the 
+ * run-queue, not the beginning. The goodness value will
+ * determine whether this process will run next. This is
+ * important to get SCHED_FIFO and SCHED_RR right, where
+ * a process that is either pre-empted or its time slice
+ * has expired, should be moved to the tail of the run 
+ * queue for its priority - Bhavesh Davda
  */
 static inline void add_to_runqueue(struct task_struct * p)
 {
-	list_add(&p->run_list, &runqueue_head);
+	list_add_tail(&p->run_list, &runqueue_head);
 	nr_running++;
 }
 
@@ -334,12 +338,6 @@
 	list_add_tail(&p->run_list, &runqueue_head);
 }
 
-static inline void move_first_runqueue(struct task_struct * p)
-{
-	list_del(&p->run_list);
-	list_add(&p->run_list, &runqueue_head);
-}
-
 /*
  * Wake up a process. Put it on the run-queue if it's not
  * already there.  The "current" process is always on the
@@ -955,8 +953,6 @@
 	retval = 0;
 	p->policy = policy;
 	p->rt_priority = lp.sched_priority;
-	if (task_on_runqueue(p))
-		move_first_runqueue(p);
 
 	current->need_resched = 1;
 
diff -aur linux-2.4.19/kernel/timer.c linux-2.4.19-sched/kernel/timer.c
--- linux-2.4.19/kernel/timer.c	Tue Aug  6 11:37:49 2002
+++ linux-2.4.19-sched/kernel/timer.c	Tue Aug  6 13:42:20 2002
@@ -601,7 +601,14 @@
 	if (p->pid) {
 		if (--p->counter <= 0) {
 			p->counter = 0;
-			p->need_resched = 1;
+			/*
+			 * SCHED_FIFO is priority preemption, so this is 
+			 * not the place to decide whether to reschedule a
+			 * SCHED_FIFO task or not - Bhavesh Davda
+			 */
+			if (p->policy != SCHED_FIFO) {
+				p->need_resched = 1;
+			}
 		}
 		if (p->nice > 0)
 			kstat.per_cpu_nice[cpu] += user_tick;

