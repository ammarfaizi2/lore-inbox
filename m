Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261776AbULJRvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbULJRvz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 12:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbULJRvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 12:51:54 -0500
Received: from dfw-gate3.raytheon.com ([199.46.199.232]:57805 "EHLO
	dfw-gate3.raytheon.com") by vger.kernel.org with ESMTP
	id S261776AbULJRun convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 12:50:43 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Mark_H_Johnson@raytheon.com, Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-15
Date: Fri, 10 Dec 2004 11:49:44 -0600
Message-ID: <OF8AB2B6D9.572374AA-ON86256F66.0061EFA8-86256F66.0061F00A@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 12/10/2004 11:49:47 AM
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The -32-15 kernel can be downloaded from the
>usual place:
>
> http://redhat.com/~mingo/realtime-preempt/

By the time I started today, the directory had -18 so that is what I built
with. Here are some initial results from running cpu_delay (the simple
RT test / user tracing) on a -18 PREEMPT_RT kernel. Have not started
any of the stress tests yet.

To recap, all IRQ # tasks, ksoftirqd/# and events/# tasks are RT FIFO
priority 99. The test program runs at RT FIFO 30 and should use about
70% of the CPU time on the two CPU SMP system under test.

[1] I still do not get traces where cpu_delay switches CPU's. I only
get trace output if it starts and ends on a single CPU. I also had
several cases where I "triggered" a trace but no output - I assume
those are related symptoms. For example:

# ./cpu_delay 0.000100
Delay limit set to 0.00010000 seconds
calibrating loop ....
time diff= 0.504598 or 396354830 loops/sec.
Trace activated with 0.000100 second delay.
Trace triggered with 0.000102 second delay. [not recorded]
Trace activated with 0.000100 second delay.
Trace triggered with 0.000164 second delay. [not recorded]
Trace activated with 0.000100 second delay.
Trace triggered with 0.000132 second delay. [00]
Trace activated with 0.000100 second delay.
Trace triggered with 0.000128 second delay. [01]
Trace activated with 0.000100 second delay.
Trace triggered with 0.000144 second delay. [not recorded]
Trace triggered with 0.000355 second delay. [02]
Trace activated with 0.000100 second delay.
Trace triggered with 0.000101 second delay. [not recorded]
Trace activated with 0.000100 second delay.
Trace triggered with 0.000126 second delay. [not recorded]
Trace triggered with 0.000205 second delay. [not recorded]
Trace activated with 0.000100 second delay.
Trace triggered with 0.000147 second delay. [03]
Trace activated with 0.000100 second delay.
Trace triggered with 0.000135 second delay. [04]
Trace triggered with 0.000110 second delay. [not recorded]
Trace triggered with 0.000247 second delay. [05]
Trace triggered with 0.000120 second delay. [06]
Trace activated with 0.000100 second delay.
Trace triggered with 0.000107 second delay. [07]
Trace triggered with 0.000104 second delay. [not recorded]
Trace activated with 0.000100 second delay.
Trace triggered with 0.000100 second delay. [08]
Trace activated with 0.000100 second delay.
Trace triggered with 0.000201 second delay. [09]

# chrt -f 1 ./get_ltrace.sh 50
Current Maximum is 4965280, limit will be 50.
Resetting max latency from 4965280 to 50.
No new latency samples at Fri Dec 10 11:01:22 CST 2004.
No new latency samples at Fri Dec 10 11:01:32 CST 2004.
No new latency samples at Fri Dec 10 11:01:42 CST 2004.
No new latency samples at Fri Dec 10 11:01:53 CST 2004.
No new latency samples at Fri Dec 10 11:02:03 CST 2004.
No new latency samples at Fri Dec 10 11:02:13 CST 2004.
New trace 0 w/ 117 usec latency.
Resetting max latency from 117 to 50.
No new latency samples at Fri Dec 10 11:02:35 CST 2004.
No new latency samples at Fri Dec 10 11:02:45 CST 2004.
New trace 1 w/ 99 usec latency.
Resetting max latency from 99 to 50.
New trace 2 w/ 248 usec latency.
Resetting max latency from 248 to 50.
New trace 3 w/ 146 usec latency.
Resetting max latency from 146 to 50.
New trace 4 w/ 134 usec latency.
Resetting max latency from 134 to 50.
New trace 5 w/ 250 usec latency.
Resetting max latency from 250 to 50.
New trace 6 w/ 120 usec latency.
Resetting max latency from 120 to 50.
New trace 7 w/ 105 usec latency.
Resetting max latency from 105 to 50.
New trace 8 w/ 91 usec latency.
Resetting max latency from 91 to 50.
New trace 9 w/ 200 usec latency.

For the most part, the elapsed times in the traces match closely to what
was measured by the application.

[2] The all CPU traces appear to show some cases where both ksoftirqd
tasks are active during a preemption of the RT task. That is expected
with my priority settings. [though the first trace shows BOTH getting
activated within 2 usec!]

[3] Some traces show information on both CPU's and then a long period
with no traces from the other. Here is an example...

preemption latency trace v1.1.4 on 2.6.10-rc2-mm3-V0.7.32-18RT
--------------------------------------------------------------------
 latency: 99 us, #275/275, CPU#0 | (M:rt VP:0, KP:1, SP:1 HP:1 #P:2)
    -----------------
    | task: cpu_delay-3556 (uid:0 nice:0 policy:1 rt_prio:30)
    -----------------
 => started at: <00000000>
 => ended at:   <00000000>

                 _------=> CPU#
                / _-----=> irqs-off
               | / _----=> need-resched
               || / _---=> hardirq/softirq
               ||| / _--=> preempt-depth
               |||| /
               |||||     delay
   cmd     pid ||||| time  |   caller
      \   /    |||||   \   |   /
<unknown-2847  1d...    0�s : smp_apic_timer_interrupt (86a89bf 0 0)
cpu_dela-3556  0d.h1    0�s : update_process_times
(smp_apic_timer_interrupt)
cpu_dela-3556  0d.h1    0�s : account_system_time (update_process_times)
cpu_dela-3556  0d.h1    0�s : check_rlimit (account_system_time)
<unknown-2847  1d.h.    0�s : update_process_times
(smp_apic_timer_interrupt)
cpu_dela-3556  0d.h1    0�s : account_it_prof (account_system_time)
...
<unknown-2847  1d.h1    4�s : _raw_spin_unlock (scheduler_tick)
cpu_dela-3556  0d.h1    4�s : irq_exit (apic_timer_interrupt)
<unknown-2847  1d.h.    4�s : rebalance_tick (scheduler_tick)
cpu_dela-3556  0d..2    4�s : do_softirq (irq_exit)
cpu_dela-3556  0d..2    4�s : __do_softirq (do_softirq)
<unknown-2847  1d.h.    5�s : irq_exit (apic_timer_interrupt)
cpu_dela-3556  0d..2    5�s : wake_up_process (do_softirq)
cpu_dela-3556  0d..2    5�s : try_to_wake_up (wake_up_process)
cpu_dela-3556  0d..2    5�s : task_rq_lock (try_to_wake_up)
<unknown-2847  1d...    5�s < (0)
cpu_dela-3556  0d..2    5�s : _raw_spin_lock (task_rq_lock)
cpu_dela-3556  0d..3    6�s : activate_task (try_to_wake_up)
cpu_dela-3556  0d..3    6�s : sched_clock (activate_task)
cpu_dela-3556  0d..3    7�s : recalc_task_prio (activate_task)
cpu_dela-3556  0d..3    7�s : effective_prio (recalc_task_prio)
cpu_dela-3556  0d..3    7�s : activate_task <ksoftirq-4> (0 1):
cpu_dela-3556  0d..3    7�s : enqueue_task (activate_task)
cpu_dela-3556  0d..3    8�s : resched_task (try_to_wake_up)
cpu_dela-3556  0dn.3    8�s : __trace_start_sched_wakeup (try_to_wake_up)
cpu_dela-3556  0dn.3    8�s : try_to_wake_up <ksoftirq-4> (0 45):
cpu_dela-3556  0dn.3    9�s : _raw_spin_unlock_irqrestore (try_to_wake_up)
cpu_dela-3556  0dn.2    9�s : preempt_schedule (try_to_wake_up)
cpu_dela-3556  0dn.2    9�s : wake_up_process (do_softirq)
cpu_dela-3556  0dn.1   10�s < (0)
cpu_dela-3556  0.n.1   10�s : preempt_schedule (up)
cpu_dela-3556  0.n..   10�s : preempt_schedule (user_trace_start)
cpu_dela-3556  0dn..   11�s : __sched_text_start (preempt_schedule)
cpu_dela-3556  0dn.1   11�s : sched_clock (__sched_text_start)
cpu_dela-3556  0dn.1   11�s : _raw_spin_lock_irq (__sched_text_start)
cpu_dela-3556  0dn.1   12�s : _raw_spin_lock_irqsave (__sched_text_start)
cpu_dela-3556  0dn.2   12�s : pull_rt_tasks (__sched_text_start)
cpu_dela-3556  0dn.2   12�s : find_next_bit (pull_rt_tasks)
cpu_dela-3556  0dn.2   13�s : find_next_bit (pull_rt_tasks)
cpu_dela-3556  0d..2   13�s : trace_array (__sched_text_start)
cpu_dela-3556  0d..2   13�s : trace_array <ksoftirq-4> (0 1):
cpu_dela-3556  0d..2   15�s : trace_array <cpu_dela-3556> (45 46):
cpu_dela-3556  0d..2   16�s+: trace_array (__sched_text_start)
ksoftirq-4     0d..2   19�s : __switch_to (__sched_text_start)
ksoftirq-4     0d..2   20�s : __sched_text_start <cpu_dela-3556> (45 0):
ksoftirq-4     0d..2   20�s : finish_task_switch (__sched_text_start)
ksoftirq-4     0d..2   20�s : smp_send_reschedule_allbutself
(finish_task_switch)
ksoftirq-4     0d..2   20�s : send_IPI_allbutself
(smp_send_reschedule_allbutself)
ksoftirq-4     0d..2   21�s : __bitmap_weight (send_IPI_allbutself)
ksoftirq-4     0d..2   21�s : __send_IPI_shortcut (send_IPI_allbutself)
ksoftirq-4     0d..2   21�s : _raw_spin_unlock (finish_task_switch)
ksoftirq-4     0d..1   22�s : trace_stop_sched_switched
(finish_task_switch)
ksoftirq-4     0....   23�s : _do_softirq (ksoftirqd)
ksoftirq-4     0d...   23�s : ___do_softirq (_do_softirq)
ksoftirq-4     0....   23�s : run_timer_softirq (___do_softirq)
ksoftirq-4     0....   24�s : _spin_lock (run_timer_softirq)
ksoftirq-4     0....   24�s : __spin_lock (_spin_lock)
ksoftirq-4     0....   24�s : __might_sleep (__spin_lock)
<unknown-2847  1d...   24�s : smp_reschedule_interrupt (86a8bd8 0 0)
ksoftirq-4     0....   24�s : _down_mutex (__spin_lock)
<unknown-2847  1d...   25�s < (0)
ksoftirq-4     0....   25�s : __down_mutex (__spin_lock)
ksoftirq-4     0....   25�s : __might_sleep (__down_mutex)
ksoftirq-4     0d...   25�s : _raw_spin_lock (__down_mutex)
ksoftirq-4     0d..1   25�s : _raw_spin_lock (__down_mutex)
ksoftirq-4     0d..2   26�s : _raw_spin_lock (__down_mutex)
ksoftirq-4     0d..3   26�s : set_new_owner (__down_mutex)
ksoftirq-4     0d..3   26�s : set_new_owner <ksoftirq-4> (0 0):
ksoftirq-4     0d..3   27�s : _raw_spin_unlock (__down_mutex)
ksoftirq-4     0d..2   27�s : _raw_spin_unlock (__down_mutex)
ksoftirq-4     0d..1   27�s : _raw_spin_unlock (__down_mutex)
... no more traces from CPU 1 ...
ksoftirq-4     0....   77�s : rcu_check_quiescent_state
(__rcu_process_callbacks)
ksoftirq-4     0....   77�s : cond_resched_all (___do_softirq)
ksoftirq-4     0....   77�s : cond_resched (___do_softirq)
ksoftirq-4     0....   78�s : cond_resched (ksoftirqd)
ksoftirq-4     0....   78�s : kthread_should_stop (ksoftirqd)
ksoftirq-4     0....   78�s : schedule (ksoftirqd)
ksoftirq-4     0....   78�s : __sched_text_start (schedule)
ksoftirq-4     0...1   79�s : sched_clock (__sched_text_start)
ksoftirq-4     0...1   79�s : _raw_spin_lock_irq (__sched_text_start)
ksoftirq-4     0...1   79�s : _raw_spin_lock_irqsave (__sched_text_start)
ksoftirq-4     0d..2   80�s : deactivate_task (__sched_text_start)
ksoftirq-4     0d..2   80�s : dequeue_task (deactivate_task)
ksoftirq-4     0d..2   81�s : trace_array (__sched_text_start)
ksoftirq-4     0d..2   82�s : trace_array <cpu_dela-3556> (45 46):
ksoftirq-4     0d..2   84�s+: trace_array (__sched_text_start)
cpu_dela-3556  0d..2   86�s : __switch_to (__sched_text_start)
cpu_dela-3556  0d..2   87�s : __sched_text_start <ksoftirq-4> (0 45):
cpu_dela-3556  0d..2   87�s : finish_task_switch (__sched_text_start)
cpu_dela-3556  0d..2   87�s : _raw_spin_unlock (finish_task_switch)
cpu_dela-3556  0d..1   88�s : trace_stop_sched_switched
(finish_task_switch)
cpu_dela-3556  0d...   89�s+< (0)
cpu_dela-3556  0d...   92�s : math_state_restore (device_not_available)
cpu_dela-3556  0d...   92�s : restore_fpu (math_state_restore)
cpu_dela-3556  0d...   93�s < (0)
cpu_dela-3556  0....   93�s > sys_gettimeofday (00000000 00000000 0000007b)
cpu_dela-3556  0....   93�s : sys_gettimeofday (sysenter_past_esp)
cpu_dela-3556  0....   94�s : user_trace_stop (sys_gettimeofday)
cpu_dela-3556  0...1   94�s : user_trace_stop (sys_gettimeofday)
cpu_dela-3556  0...1   95�s : _raw_spin_lock_irqsave (user_trace_stop)
cpu_dela-3556  0d..2   95�s : _raw_spin_unlock_irqrestore (user_trace_stop)

If I read this right, we tried to reschedule cpu_delay on CPU #1 (at
24 usec) but it never happened and cpu_delay was still "ready to run"
on CPU #0 70 usec later.

[4] I have a trace where cpu_delay was bumped off of CPU #1 at 20 usec
while the X server (not RT) was the active process on CPU #0 for another
130 usec (several traces with preempt-depth ==0) when it finally gets
bumped by IRQ 0.

[5] More of a cosmetic problem, several traces still show the
application name as "unknown" - even for long lived processes like
ksoftirqd/0 and X.

Due to the file size, I will send the traces separately.
  --Mark

