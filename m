Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263945AbTL2SxI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 13:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264095AbTL2SxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 13:53:08 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:43492 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S263945AbTL2SxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 13:53:00 -0500
Date: Mon, 29 Dec 2003 10:51:26 -0800 (PST)
From: John Hawkes <hawkes@google.engr.sgi.com>
Message-Id: <200312291851.KAA25312@google.engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] 2.6.0-test11 sched_clock() broken for "drifty ITC"
Cc: lse-tech@lists.sourceforge.net, mingo@elte.hu,
       linux-kernel@vger.kernel.org
References: <200312182044.hBIKiCLY5477429@babylon.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could you please finalise it, cook up the ia64 and numaq implementations
> and send it over?

I believe the "ia64 implementation" stands as-is, since it uses the low-
overhead ITC.

I'm not familiar with NUMAQ issues, but perhaps this timer_tsc.c change
would be appropriate?  It allows i386 CONFIG_NUMA platforms to potentially
use the TSC for sched_clock() timings, given that sched_clock() no longer
requires that the TSC be synchronized across all CPUs.  It does, however,
require that "use_tsc" be properly initialized for i386 CONFIG_NUMA.  Is
that a valid assumption?

Also, I have added a comment to sched.h to make note of the change
in sched_clock() semantics.

John Hawkes


diff -X /home/hawkes/Patches/ignore.dirs -Naur linux-2.6.0/arch/i386/kernel/timers/timer_tsc.c linux-2.6.0-schedclock2/arch/i386/kernel/timers/timer_tsc.c
--- linux-2.6.0/arch/i386/kernel/timers/timer_tsc.c	Mon Nov 24 12:18:20 2003
+++ linux-2.6.0-schedclock2/arch/i386/kernel/timers/timer_tsc.c	Sat Dec 13 11:33:04 2003
@@ -138,9 +138,7 @@
 	 * In the NUMA case we dont use the TSC as they are not
 	 * synchronized across all CPUs.
 	 */
-#ifndef CONFIG_NUMA
 	if (!use_tsc)
-#endif
 		return (unsigned long long)jiffies * (1000000000 / HZ);
 
 	/* Read the Time Stamp Counter */
diff -X /home/hawkes/Patches/ignore.dirs -Naur linux-2.6.0/include/linux/sched.h linux-2.6.0-schedclock2/include/linux/sched.h
--- linux-2.6.0/include/linux/sched.h	Mon Nov 24 12:18:20 2003
+++ linux-2.6.0-schedclock2/include/linux/sched.h	Mon Dec 29 10:47:55 2003
@@ -510,6 +510,7 @@
 }
 #endif
 
+/* nanosecond granularity, not necessarily synchronized across all CPUs */
 extern unsigned long long sched_clock(void);
 
 #ifdef CONFIG_NUMA
diff -X /home/hawkes/Patches/ignore.dirs -Naur linux-2.6.0/kernel/sched.c linux-2.6.0-schedclock2/kernel/sched.c
--- linux-2.6.0/kernel/sched.c	Mon Nov 24 12:18:20 2003
+++ linux-2.6.0-schedclock2/kernel/sched.c	Mon Dec 15 17:13:24 2003
@@ -199,7 +199,7 @@
 struct runqueue {
 	spinlock_t lock;
 	unsigned long nr_running, nr_switches, expired_timestamp,
-			nr_uninterruptible;
+			nr_uninterruptible, timestamp_last_tick;
 	task_t *curr, *idle;
 	struct mm_struct *prev_mm;
 	prio_array_t *active, *expired, arrays[2];
@@ -1135,6 +1135,7 @@
 	set_task_cpu(p, this_cpu);
 	nr_running_inc(this_rq);
 	enqueue_task(p, this_rq->active);
+	p->timestamp = sched_clock() - (src_rq->timestamp_last_tick - p->timestamp);
 	/*
 	 * Note that idle threads have a prio of MAX_PRIO, for this test
 	 * to be always true for them.
@@ -1155,7 +1156,7 @@
 static inline int
 can_migrate_task(task_t *tsk, runqueue_t *rq, int this_cpu, int idle)
 {
-	unsigned long delta = sched_clock() - tsk->timestamp;
+	unsigned long delta = rq->timestamp_last_tick - tsk->timestamp;
 
 	if (!idle && (delta <= JIFFIES_TO_NS(cache_decay_ticks)))
 		return 0;
@@ -1361,6 +1362,8 @@
 	runqueue_t *rq = this_rq();
 	task_t *p = current;
 
+	rq->timestamp_last_tick = sched_clock();
+
 	if (rcu_pending(cpu))
 		rcu_check_callbacks(cpu, user_ticks);
 
@@ -2639,6 +2642,8 @@
 		if (p->prio < rq_dest->curr->prio)
 			resched_task(rq_dest->curr);
 	}
+	p->timestamp = rq_dest->timestamp_last_tick;
+
  out:
 	double_rq_unlock(this_rq(), rq_dest);
 	local_irq_restore(flags);
