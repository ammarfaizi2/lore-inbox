Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbULNEPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbULNEPp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 23:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbULNEOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 23:14:03 -0500
Received: from mx1.redhat.com ([66.187.233.31]:36553 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261400AbULND74 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 22:59:56 -0500
Date: Mon, 13 Dec 2004 19:59:52 -0800
Message-Id: <200412140359.iBE3xqVE008083@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: akpm@osdl.org, torvalds@osdl.org
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] timer.c cleanups
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After my recent patches, it becomes apparent that there are some useless
layers of function calls in timer.c, and a little outright dead code, that
really just confuse the situation and have no point.  This patch wipes out
some cruft.  (Despite the comment, run_local_timers is called by nothing.)


Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6/kernel/timer.c
+++ linux-2.6/kernel/timer.c
@@ -800,21 +800,6 @@ static void update_wall_time(unsigned lo
 	} while (ticks);
 }
 
-static inline void do_process_times(struct task_struct *p,
-	unsigned long user, unsigned long system)
-{
-	unsigned long psecs;
-
-	psecs = (p->utime += user);
-	psecs += (p->stime += system);
-}
-
-static void update_one_process(struct task_struct *p, unsigned long user,
-			unsigned long system, int cpu)
-{
-	do_process_times(p, user, system);
-}	
-
 /*
  * Called from the timer interrupt handler to charge one tick to the current 
  * process.  user_tick is 1 if the tick is user time, 0 for system.
@@ -822,10 +807,13 @@ static void update_one_process(struct ta
 void update_process_times(int user_tick)
 {
 	struct task_struct *p = current;
-	int cpu = smp_processor_id(), system = user_tick ^ 1;
+	int system = user_tick ^ 1;
+
+	p->utime += user_tick;
+	p->stime += system;
+
+	raise_softirq(TIMER_SOFTIRQ);
 
-	update_one_process(p, user_tick, system, cpu);
-	run_local_timers();
 	scheduler_tick(user_tick, system);
 	run_posix_cpu_timers(p);
 }
@@ -892,14 +880,6 @@ static void run_timer_softirq(struct sof
 }
 
 /*
- * Called by the local, per-CPU timer interrupt on SMP.
- */
-void run_local_timers(void)
-{
-	raise_softirq(TIMER_SOFTIRQ);
-}
-
-/*
  * Called by the timer interrupt. xtime_lock must already be taken
  * by the timer IRQ!
  */
--- linux-2.6/include/linux/timer.h
+++ linux-2.6/include/linux/timer.h
@@ -96,7 +96,6 @@ static inline void add_timer(struct time
 #endif
 
 extern void init_timers(void);
-extern void run_local_timers(void);
 extern void it_real_fn(unsigned long);
 
 #endif
