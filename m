Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317978AbSIOIqd>; Sun, 15 Sep 2002 04:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317980AbSIOIqd>; Sun, 15 Sep 2002 04:46:33 -0400
Received: from mx2.elte.hu ([157.181.151.9]:18656 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317978AbSIOIqc>;
	Sun, 15 Sep 2002 04:46:32 -0400
Date: Sun, 15 Sep 2002 10:58:05 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] detached-fix-2.5.34-A0, BK-curr
Message-ID: <Pine.LNX.4.44.0209151055410.29172-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch fixes three resource accounting related bugs introduced
by detached threads:

 - the 'child CPU usage' fields were updated in wait4 until now - this was
   slightly buggy for a number of reasons, eg. if the exit_code writout
   faults then it's possible to trigger this code multiple times.

 - those threads that do not go through wait4 were not properly accounted.

 - sched_exit() was incorrectly assuming that current == parent. In the
   detached case p->parent is the real parent.

with this patch applied things like 'time' work again for new-style
threaded apps.

	Ingo

--- linux/kernel/exit.c.orig	Sun Sep 15 10:40:03 2002
+++ linux/kernel/exit.c	Sun Sep 15 10:46:11 2002
@@ -71,19 +71,19 @@
 	write_lock_irq(&tasklist_lock);
 	__exit_sighand(p);
 	proc_dentry = __unhash_process(p);
+	p->parent->cutime += p->utime + p->cutime;
+	p->parent->cstime += p->stime + p->cstime;
+	p->parent->cmin_flt += p->min_flt + p->cmin_flt;
+	p->parent->cmaj_flt += p->maj_flt + p->cmaj_flt;
+	p->parent->cnswap += p->nswap + p->cnswap;
+	sched_exit(p);
 	write_unlock_irq(&tasklist_lock);
+
 	if (unlikely(proc_dentry != NULL)) {
 		shrink_dcache_parent(proc_dentry);
 		dput(proc_dentry);
 	}
-
 	release_thread(p);
-	if (p != current) {
-		current->cmin_flt += p->min_flt + p->cmin_flt;
-		current->cmaj_flt += p->maj_flt + p->cmaj_flt;
-		current->cnswap += p->nswap + p->cnswap;
-		sched_exit(p);
-	}
 	put_task_struct(p);
 }
 
@@ -794,8 +794,6 @@
 				}
 				goto end_wait4;
 			case TASK_ZOMBIE:
-				current->cutime += p->utime + p->cutime;
-				current->cstime += p->stime + p->cstime;
 				read_unlock(&tasklist_lock);
 				retval = ru ? getrusage(p, RUSAGE_BOTH, ru) : 0;
 				if (!retval && stat_addr) {
--- linux/kernel/sched.c.orig	Sun Sep 15 10:45:24 2002
+++ linux/kernel/sched.c	Sun Sep 15 10:45:59 2002
@@ -479,17 +479,17 @@
 {
 	local_irq_disable();
 	if (p->first_time_slice) {
-		current->time_slice += p->time_slice;
-		if (unlikely(current->time_slice > MAX_TIMESLICE))
-			current->time_slice = MAX_TIMESLICE;
+		p->parent->time_slice += p->time_slice;
+		if (unlikely(p->parent->time_slice > MAX_TIMESLICE))
+			p->parent->time_slice = MAX_TIMESLICE;
 	}
 	local_irq_enable();
 	/*
 	 * If the child was a (relative-) CPU hog then decrease
 	 * the sleep_avg of the parent as well.
 	 */
-	if (p->sleep_avg < current->sleep_avg)
-		current->sleep_avg = (current->sleep_avg * EXIT_WEIGHT +
+	if (p->sleep_avg < p->parent->sleep_avg)
+		p->parent->sleep_avg = (p->parent->sleep_avg * EXIT_WEIGHT +
 			p->sleep_avg) / (EXIT_WEIGHT + 1);
 }
 

