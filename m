Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262767AbVFVKe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262767AbVFVKe4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 06:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262856AbVFVKeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 06:34:04 -0400
Received: from mx2.elte.hu ([157.181.151.9]:52908 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262767AbVFVK2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 06:28:43 -0400
Date: Wed, 22 Jun 2005 12:25:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
       William Weston <weston@sysex.net>
Subject: [patch] fix SMT scheduler latency bug
Message-ID: <20050622102541.GA10043@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


William Weston reported unusually high scheduling latencies on his x86 
HT box, on the -RT kernel. I managed to reproduce it on my HT box and 
the latency tracer shows the incident in action:

                 _------=> CPU#
                / _-----=> irqs-off
               | / _----=> need-resched
               || / _---=> hardirq/softirq
               ||| / _--=> preempt-depth
               |||| /
               |||||     delay
   cmd     pid ||||| time  |   caller
      \   /    |||||   \   |   /
      du-2803  3Dnh2    0us : __trace_start_sched_wakeup (try_to_wake_up)
        ..............................................................
        ... we are running on CPU#3, PID 2778 gets woken to CPU#1: ...
        ..............................................................
      du-2803  3Dnh2    0us : __trace_start_sched_wakeup <<...>-2778> (73 1)
      du-2803  3Dnh2    0us : _raw_spin_unlock (try_to_wake_up)
        ................................................
        ... still on CPU#3, we send an IPI to CPU#1: ...
        ................................................
      du-2803  3Dnh1    0us : resched_task (try_to_wake_up)
      du-2803  3Dnh1    1us : smp_send_reschedule (try_to_wake_up)
      du-2803  3Dnh1    1us : send_IPI_mask_bitmask (smp_send_reschedule)
      du-2803  3Dnh1    2us : _raw_spin_unlock_irqrestore (try_to_wake_up)
        ...............................................
        ... 1 usec later, the IPI arrives on CPU#1: ...
        ...............................................
  <idle>-0     1Dnh.    2us : smp_reschedule_interrupt (c0100c5a 0 0)

so far so good, this is the normal wakeup/preemption mechanism. But here
comes the scheduler anomaly on CPU#1:

  <idle>-0     1Dnh.    2us : preempt_schedule_irq (need_resched)
  <idle>-0     1Dnh.    2us : preempt_schedule_irq (need_resched)
  <idle>-0     1Dnh.    3us : __schedule (preempt_schedule_irq)
  <idle>-0     1Dnh.    3us : profile_hit (__schedule)
  <idle>-0     1Dnh1    3us : sched_clock (__schedule)
  <idle>-0     1Dnh1    4us : _raw_spin_lock_irq (__schedule)
  <idle>-0     1Dnh1    4us : _raw_spin_lock_irqsave (__schedule)
  <idle>-0     1Dnh2    5us : _raw_spin_unlock (__schedule)
  <idle>-0     1Dnh1    5us : preempt_schedule (__schedule)
  <idle>-0     1Dnh1    6us : _raw_spin_lock (__schedule)
  <idle>-0     1Dnh2    6us : find_next_bit (__schedule)
  <idle>-0     1Dnh2    6us : _raw_spin_lock (__schedule)
  <idle>-0     1Dnh3    7us : find_next_bit (__schedule)
  <idle>-0     1Dnh3    7us : find_next_bit (__schedule)
  <idle>-0     1Dnh3    8us : _raw_spin_unlock (__schedule)
  <idle>-0     1Dnh2    8us : preempt_schedule (__schedule)
  <idle>-0     1Dnh2    8us : find_next_bit (__schedule)
  <idle>-0     1Dnh2    9us : trace_stop_sched_switched (__schedule)
  <idle>-0     1Dnh2    9us : _raw_spin_lock (trace_stop_sched_switched)
  <idle>-0     1Dnh3   10us : trace_stop_sched_switched <<...>-2778> (73 8c)
  <idle>-0     1Dnh3   10us : _raw_spin_unlock (trace_stop_sched_switched)
  <idle>-0     1Dnh1   10us : _raw_spin_unlock (__schedule)
  <idle>-0     1Dnh.   11us : local_irq_enable_noresched (preempt_schedule_irq)
  <idle>-0     1Dnh.   11us < (0)

we didnt pick up pid 2778! It only gets scheduled much later:

   <...>-2778  1Dnh2  412us : __switch_to (__schedule)
   <...>-2778  1Dnh2  413us : __schedule <<idle>-0> (8c 73)
   <...>-2778  1Dnh2  413us : _raw_spin_unlock (__schedule)
   <...>-2778  1Dnh1  413us : trace_stop_sched_switched (__schedule)
   <...>-2778  1Dnh1  414us : _raw_spin_lock (trace_stop_sched_switched)
   <...>-2778  1Dnh2  414us : trace_stop_sched_switched <<...>-2778> (73 1)
   <...>-2778  1Dnh2  414us : _raw_spin_unlock (trace_stop_sched_switched)
   <...>-2778  1Dnh1  415us : trace_stop_sched_switched (__schedule)

the reason for this anomaly is the following code in dependent_sleeper():

                /*
                 * If a user task with lower static priority than the
                 * running task on the SMT sibling is trying to schedule,
                 * delay it till there is proportionately less timeslice
                 * left of the sibling task to prevent a lower priority
                 * task from using an unfair proportion of the
                 * physical cpu's resources. -ck
                 */
[...]
                        if (((smt_curr->time_slice * (100 - sd->per_cpu_gain) /
                                100) > task_timeslice(p)))
                                        ret = 1;

note that in contrast to the comment above, we dont actually do the 
check based on static priority, we do the check based on timeslices. But 
timeslices go up and down, and even highprio tasks can randomly have 
very low timeslices (just before their next refill) and can thus be 
judged as 'lowprio' by the above piece of code. This condition is 
clearly buggy. The correct test is to check for static_prio _and_ to 
check for the preemption priority. Even on different static priority 
levels, a higher-prio interactive task should not be delayed due to a 
higher-static-prio CPU hog.

there is a symmetric bug in the 'kick SMT sibling' code of this function 
as well, which can be solved in a similar way.

the patch below (against the current scheduler queue in -mm) fixes both 
bugs. I have build and boot-tested this on x86 SMT, and nice +20 tasks 
still get properly throttled - so the dependent-sleeper logic is still 
in action.

btw., these bugs pessimised the SMT scheduler because the 'delay wakeup' 
property was applied too liberally, so this fix is likely a throughput 
improvement as well.

i separated out a smt_slice() function to make the code easier to read.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 kernel/sched.c |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

Index: kernel/sched.c
===================================================================
--- kernel/sched.c.orig
+++ kernel/sched.c
@@ -2651,6 +2651,16 @@ static inline void wake_sleeping_depende
 	 */
 }
 
+/*
+ * number of 'lost' timeslices this task wont be able to fully
+ * utilize, if another task runs on a sibling. This models the
+ * slowdown effect of other tasks running on siblings:
+ */
+static inline unsigned long smt_slice(task_t *p, struct sched_domain *sd)
+{
+	return p->time_slice * (100 - sd->per_cpu_gain) / 100;
+}
+
 static inline int dependent_sleeper(int this_cpu, runqueue_t *this_rq)
 {
 	struct sched_domain *tmp, *sd = NULL;
@@ -2715,8 +2725,9 @@ static inline int dependent_sleeper(int 
 				(sd->per_cpu_gain * DEF_TIMESLICE / 100))
 					ret = 1;
 		} else
-			if (((smt_curr->time_slice * (100 - sd->per_cpu_gain) /
-				100) > task_timeslice(p)))
+			if (smt_curr->static_prio < p->static_prio &&
+				!TASK_PREEMPTS_CURR(p, smt_rq) &&
+				smt_slice(smt_curr, sd) > task_timeslice(p))
 					ret = 1;
 
 check_smt_task:
@@ -2738,8 +2749,8 @@ check_smt_task:
 				(sd->per_cpu_gain * DEF_TIMESLICE / 100))
 					resched_task(smt_curr);
 		} else {
-			if ((p->time_slice * (100 - sd->per_cpu_gain) / 100) >
-				task_timeslice(smt_curr))
+			if (TASK_PREEMPTS_CURR(p, smt_rq) &&
+				smt_slice(p, sd) > task_timeslice(smt_curr))
 					resched_task(smt_curr);
 			else
 				wakeup_busy_runqueue(smt_rq);
