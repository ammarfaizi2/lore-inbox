Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262653AbTCPLOb>; Sun, 16 Mar 2003 06:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262654AbTCPLOb>; Sun, 16 Mar 2003 06:14:31 -0500
Received: from mx2.elte.hu ([157.181.151.9]:46229 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S262653AbTCPLO3>;
	Sun, 16 Mar 2003 06:14:29 -0500
Date: Sun, 16 Mar 2003 12:24:58 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>, Mike Galbraith <efault@gmx.de>,
       Andrew Morton <akpm@zip.com.au>
Subject: [patch] sched-2.5.64-bk10-C4
Message-ID: <Pine.LNX.4.44.0303161213200.4930-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch fixes a fundamental (and long-standing) bug in the
sleep-average estimator which is the root cause of the "contest
process_load" problems reported by Mike Galbraith and Andrew Morton, and
which problem is addressed by Mike's patch.

the bug is the following: the sleep_time code in activate_task()  
over-estimates the true sleep time by 0.5 jiffies on average (0.5 msecs on
recent 2.5 kernels). Furthermore, for highly context-switch intensive and
CPU-intensive workloads it means a constant 1 jiffy over-estimation. This
turns the balance of giving and removing ticks and nils the effect of the
CPU busy-tick, catapulting the task(s) to highly interactive status -
while in reality they are constantly burning CPU time.

the fix is to round down sleep_time, not to round it up. This slightly
under-estimates the sleep time, but this is not a real problem, any task
with a sleep time in the 1 jiffy range will see timekeeping granularity
artifacts from various parts of the kernel anyway. We could use rdtsc to
estimate the sleep time, but i think that's unnecessary overhead.

the fixups in Mike's scheduler patch (which is in -mm8) basically work
around this bug. The patch below definitely fixes the contest-load
starvation bug, but it remains to be seen what other effects it has on
interactivity. In any case, this bug in the estimator is real and if
there's any other interactivity problem around then we need to deal with
it ontop of this patch.

this bug has been in the O(1) scheduler from day 1 on basically, so i'm
quite hopeful that a number of interactivity complaints are fixed by this
patch.

	Ingo

--- linux/kernel/sched.c.orig	
+++ linux/kernel/sched.c	
@@ -342,10 +342,10 @@ static inline void __activate_task(task_
  */
 static inline int activate_task(task_t *p, runqueue_t *rq)
 {
-	unsigned long sleep_time = jiffies - p->last_run;
+	long sleep_time = jiffies - p->last_run - 1;
 	int requeue_waker = 0;
 
-	if (sleep_time) {
+	if (sleep_time > 0) {
 		int sleep_avg;
 
 		/*

