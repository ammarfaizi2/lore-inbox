Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316300AbSFUQMz>; Fri, 21 Jun 2002 12:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316667AbSFUQMy>; Fri, 21 Jun 2002 12:12:54 -0400
Received: from ierw.net.avaya.com ([198.152.13.101]:41093 "EHLO
	ierw.net.avaya.com") by vger.kernel.org with ESMTP
	id <S316300AbSFUQMx>; Fri, 21 Jun 2002 12:12:53 -0400
Date: Fri, 21 Jun 2002 16:12:56 -0600 (MDT)
From: "Bhavesh P. Davda" <bhavesh@avaya.com>
X-X-Sender: bhavesh@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: alan@lxorguk.ukuu.org.uk, <torvalds@transmeta.com>
Subject: [PATCH] SCHED_FIFO and SCHED_RR scheduler fix, kernel 2.2.21
Message-ID: <Pine.LNX.4.44.0206211558070.6781-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 21 Jun 2002 16:12:54.0550 (UTC) FILETIME=[7FF93360:01C2193E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The 2.2.21 kernel was behaving incorrectly for SCHED_FIFO and SCHED_RR 
scheduling.

The correct behaviour for SCHED_FIFO is priority preemption: run to 
completion, or system call, or preemption by higher priority process. The 
correct behaviour for SCHED_RR is the same as SCHED_FIFO for the 
preemption case, or run for a time slice, and go to the back of the run 
queue for that priority.

More details can be found at:

http://www.opengroup.org/onlinepubs/7908799/xsh/realtime.html

This is a small patch, but fixes the behaviour for SCHED_FIFO and SCHED_RR 
scheduling in the 2.2.21 kernel. It also improves the efficiency of the 
kernel by NOT calling schedule() for every tick for a SCHED_FIFO process.

--
Bhavesh P. Davda
Avaya, Inc.
bhavesh@avaya.com


diff -aur linux-2.2.21/kernel/sched.c linux-2.2.21-bpd/kernel/sched.c
--- linux-2.2.21/kernel/sched.c	Sun Mar 25 09:37:40 2001
+++ linux-2.2.21-bpd/kernel/sched.c	Fri Jun 21 09:54:55 2002
@@ -749,7 +749,16 @@
 	/* Default process to select.. */
 	next = idle_task(this_cpu);
 	c = -1000;
-	if (prev->state == TASK_RUNNING)
+	/* 
+	 * If a SCHED_RR task has exhausted its time slice, 
+	 * it is at the back of the runqueue, even if it is
+	 * still running. On the other hand, if a SCHED_RR task
+	 * is still running and still has time left in its
+	 * time slice, then it is still the first process in its
+	 * priority band, so it will run next if it is the first
+	 * highest priority SCHED_RR task
+	 */
+	if ((prev->state == TASK_RUNNING) && (prev->policy != SCHED_RR))
 		goto still_running;
 still_running_back:
 
@@ -1492,7 +1501,12 @@
 		p->counter -= ticks;
 		if (p->counter < 0) {
 			p->counter = 0;
-			p->need_resched = 1;
+			/* SCHED_FIFO is priority preemption, so this is
+			 * not the place to reschedule it
+			 */
+			if (p->policy != SCHED_FIFO) {
+				p->need_resched = 1;
+			}
 		}
 		if (p->priority < DEF_PRIORITY)
 			kstat.cpu_nice += user;
@@ -1785,8 +1799,6 @@
 	retval = 0;
 	p->policy = policy;
 	p->rt_priority = lp.sched_priority;
-	if (p->next_run)
-		move_first_runqueue(p);
 
 	current->need_resched = 1;

