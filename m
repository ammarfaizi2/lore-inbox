Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133097AbREHWch>; Tue, 8 May 2001 18:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135181AbREHWc1>; Tue, 8 May 2001 18:32:27 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:43198 "EHLO
	c0mailgw05.prontomail.com") by vger.kernel.org with ESMTP
	id <S133097AbREHWcK>; Tue, 8 May 2001 18:32:10 -0400
Message-ID: <3AF873D1.20463840@mvista.com>
Date: Tue, 08 May 2001 15:31:45 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Child first after fork violates the SCHED_FIFO and SCHED_RR standard.
Content-Type: multipart/mixed;
 boundary="------------D803C38B48364446709099D0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D803C38B48364446709099D0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The standard says a SCHED_FIFO task only gives up the processor if it
blocks, yields, or changes its priority.  

The counter is not really used by SCHED_FIFO tasks, however the
update_process_times() code will set the "need_resched" flag on a
SCHED_FIFO task, even though schedule() effectively ignores the entry. 
The attached patch addresses these issues by setting the counter to -100
for SCHED_FIFO tasks and "teaching" update_process_timers() to not count
down negative counters.  This avoids the calling of schedule() every
jiffie while a SCHED_FIFO task is running.

I tried to keep the change to recalculate confined to only the data
elements it was already touching, however, the standard really doesn't
allow recalculate to touch the SCHED_RR counter.  A standard conforming
test would restrict recalculate to only SCHED_OTHER tasks.

Comments?

George
--------------D803C38B48364446709099D0
Content-Type: text/plain; charset=us-ascii;
 name="fifo-2.4.4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fifo-2.4.4.patch"

diff -urP -X /usr/src/patch.exclude linux-2.4.4-kb/kernel/fork.c linux/kernel/fork.c
--- linux-2.4.4-kb/kernel/fork.c	Mon May  7 14:46:17 2001
+++ linux/kernel/fork.c	Tue May  8 15:17:51 2001
@@ -673,10 +673,14 @@
 	 * if the child for a fork() just wants to do a few simple things
 	 * and then exec(). This is only important in the first timeslice.
 	 * In the long run, the scheduling behavior is unchanged.
+         * SCHED_FIFO tasks don't count down and have a negative counter.
+         * Don't change these, least they all end up at -1.
 	 */
-	p->counter = current->counter;
-	current->counter = 0;
-	current->need_resched = 1;
+        if (p->policy == SCHED_OTHER){
+                p->counter = current->counter;
+                current->counter = 0;
+                current->need_resched = 1;
+        }
 
 	/*
 	 * Ok, add it to the run-queues and make it
diff -urP -X /usr/src/patch.exclude linux-2.4.4-kb/kernel/sched.c linux/kernel/sched.c
--- linux-2.4.4-kb/kernel/sched.c	Mon May  7 14:46:17 2001
+++ linux/kernel/sched.c	Tue May  8 13:43:54 2001
@@ -682,7 +682,10 @@
 		spin_unlock_irq(&runqueue_lock);
 		read_lock(&tasklist_lock);
 		for_each_task(p)
-			p->counter = (p->counter >> 1) + NICE_TO_TICKS(p->nice);
+                        if (p->counter >= 0 ){
+                                p->counter = (p->counter >> 1) + 
+                                        NICE_TO_TICKS(p->nice);
+                        }
 		read_unlock(&tasklist_lock);
 		spin_lock_irq(&runqueue_lock);
 	}
@@ -932,6 +935,11 @@
 
 	retval = 0;
 	p->policy = policy;
+        if ( policy == SCHED_FIFO) {
+                p->counter = -100;        /* we don't count down neg couters */
+        }else{
+                p->counter = NICE_TO_TICKS(p->nice);
+        }
 	p->rt_priority = lp.sched_priority;
 	if (task_on_runqueue(p))
 		move_first_runqueue(p);
diff -urP -X /usr/src/patch.exclude linux-2.4.4-kb/kernel/timer.c linux/kernel/timer.c
--- linux-2.4.4-kb/kernel/timer.c	Sun Dec 10 09:53:19 2000
+++ linux/kernel/timer.c	Tue May  8 15:14:37 2001
@@ -583,7 +583,11 @@
 
 	update_one_process(p, user_tick, system, cpu);
 	if (p->pid) {
-		if (--p->counter <= 0) {
+                /*
+                 * SCHED_FIFO and the idle(s) have counters set to -100, 
+                 * so we won't count them.
+                 */
+		if (p->counter >= 0 && --p->counter <= 0) {
 			p->counter = 0;
 			p->need_resched = 1;
 		}

--------------D803C38B48364446709099D0--

