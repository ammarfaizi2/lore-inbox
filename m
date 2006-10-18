Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161180AbWJRRE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161180AbWJRRE2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 13:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161240AbWJRRE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 13:04:28 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:36077 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161180AbWJRRE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 13:04:27 -0400
Date: Wed, 18 Oct 2006 10:04:07 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>, linux-kernel@vger.kernel.org
Subject: [RFC] sched_tick with interrupts enabled
Message-ID: <Pine.LNX.4.64.0610181001480.28582@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

scheduler_tick() has the potential of running for some time if f.e.
sched_domains for a system with 1024 processors have to be balanced.
We currently do all of that with interrupts disabled. So we may be unable
to service interrupts for some time.

I wonder if it would be possible to put the sched_tick() into a tasklet and
allow interrupts to be enabled? Preemption is still disabled and so we
are stuck on a cpu.

This can only work if we are sure that no scheduler activity is performed
from interrupt code or from other tasklets that may potentially run.

sched_tick() takes the lock on a request queue without disabling interrupts.
So any other attempt to invoke scheduler functions from interrupts or
tasklets will cause a deadlock.

I tested this patch with AIM7 and things seem to be fine.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.19-rc2-mm1/kernel/timer.c
===================================================================
--- linux-2.6.19-rc2-mm1.orig/kernel/timer.c	2006-10-18 11:52:53.160984800 -0500
+++ linux-2.6.19-rc2-mm1/kernel/timer.c	2006-10-18 11:53:10.039399811 -0500
@@ -1210,8 +1210,14 @@ static void update_wall_time(void)
 	}
 }
 
+static void sched_tick_action(unsigned long dummy)
+{
+	scheduler_tick();
+}
+
+static DECLARE_TASKLET(scheduler_tick_tasklet, sched_tick_action, 0);
 /*
- * Called from the timer interrupt handler to charge one tick to the current 
+ * Called from the timer interrupt handler to charge one tick to the current
  * process.  user_tick is 1 if the tick is user time, 0 for system.
  */
 void update_process_times(int user_tick)
@@ -1227,7 +1233,7 @@ void update_process_times(int user_tick)
 	run_local_timers();
 	if (rcu_pending(cpu))
 		rcu_check_callbacks(cpu, user_tick);
-	scheduler_tick();
+	tasklet_schedule(&scheduler_tick_tasklet);
  	run_posix_cpu_timers(p);
 }
 
Index: linux-2.6.19-rc2-mm1/kernel/sched.c
===================================================================
--- linux-2.6.19-rc2-mm1.orig/kernel/sched.c	2006-10-18 11:52:51.768286047 -0500
+++ linux-2.6.19-rc2-mm1/kernel/sched.c	2006-10-18 11:53:10.003263868 -0500
@@ -1608,9 +1608,10 @@ void fastcall sched_fork(struct task_str
 		 * runqueue lock is not a problem.
 		 */
 		current->time_slice = 1;
+		local_irq_enable();
 		scheduler_tick();
-	}
-	local_irq_enable();
+	} else
+		local_irq_enable();
 	put_cpu();
 }
 
@@ -3040,7 +3041,8 @@ void account_steal_time(struct task_stru
 
 /*
  * This function gets called by the timer code, with HZ frequency.
- * We call it with interrupts disabled.
+ * We call it with interrupts enabled. However, the thread is
+ * pinned to a specific cpu.
  *
  * It also gets called by the fork code, when changing the parent's
  * timeslices.
