Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270064AbUJHRKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270064AbUJHRKz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 13:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270068AbUJHRKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 13:10:55 -0400
Received: from lax-gate1.raytheon.com ([199.46.200.230]:21953 "EHLO
	lax-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S270064AbUJHRI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 13:08:57 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       "K.R. Foley" <kr@cybsft.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm3-T3
Date: Fri, 8 Oct 2004 12:07:41 -0500
Message-ID: <OFDE306985.96CC4F96-ON86256F27.005E168F-86256F27.005E16AD@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 10/08/2004 12:07:51 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>i've released the -T3 VP patch:

I ran another series of tests, this time without using threaded IRQ's. Both
/proc/sys/kernel/softirq_preemption and
/proc/sys/kernel/hardirq_preemption
were zero.

The results were somewhat similar to what I saw yesterday when both types
of
IRQ's were threaded. The number of latencies > 200 usec was higher:
  threaded IRQ's -  47
unthreaded IRQ's - 128

However, the application level overhead (as measured by latencytest)
appears to be less without threaded IRQ's than with. For example,
during the X11 stress test:

                            CPU task   samples within 0.1 msec
nominal duration:          1.16 msec     n/a
Max with threaded IRQ's:   1.38 msec     99.97%
Max with unthreaded IRQ's: 1.25 msec    100.00%

The green line in the chart is MUCH thinner in the unthreaded test
as well indicating much less overhead with unthreaded IRQ's. Please
note that in both tests, the audio IRQ was not threaded (all others
were...).

This trend continued until the disk tests were performed. In those
cases, the threaded overhead was less but I believe that is due to
the setting of the audio IRQ to be non-threaded.

The types of latency traces I saw are summarized as follows. Some
details are at the end and if anyone wants full traces, please let
me know. The numbers that follow refer to the trace numbers.

[1] rt_check_expire - hundreds of traces of _spin_lock and _spin_unlock
with the preempt count >1
00 02 78 82 87 92 101 110 126

[2] do_wait - preempt count bounces up / down many cycles
01

[3] do_IRQ - appears to be chaining of hard and soft IRQ's without any
opportunity for preemption. May also have timer tick as well. A few
different ways to start this symptom. Most traces are like one of these.
03... 37 39... 73 76 79 81 83... 86 88 89 94 96 97 99 100 102 103 106 107
109 111 114 119 122 123

[4] rt_run_flush - a VERY long trace (> 4000 samples)
38 106

[5] rcu / cache actions
74 75 77 90 95 113 124

[6] prune_icache - an interrupt causes some delays
80 91 98

[7] clear_page_tables - also seen without threaded IRQ's
92 108 112 115 ... 118 120 121 125 127

[8] avc_insert - a long delay at one step...
105

  --Mark

[1] rt_check_expire

The following is typical of this kind of trace.

preemption latency trace v1.0.7 on 2.6.9-rc3-mm3-VP-T3
-------------------------------------------------------
 latency: 295 us, entries: 882 (882)   |   [VP:1 KP:1 SP:0 HP:0 #CPUS:2]
    -----------------
    | task: X/2815, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: smp_apic_timer_interrupt+0x43/0xf0
 => ended at:   irq_exit+0x33/0x50
=======>
00010000 0.000ms (+0.000ms): smp_apic_timer_interrupt
(apic_timer_interrupt)
00010000 0.000ms (+0.000ms): profile_tick (smp_apic_timer_interrupt)
00010000 0.000ms (+0.000ms): profile_hook (profile_tick)
00010000 0.000ms (+0.000ms): _read_lock (profile_hook)
00010001 0.001ms (+0.000ms): notifier_call_chain (profile_hook)
00010001 0.001ms (+0.000ms): _read_unlock (profile_tick)
00010000 0.001ms (+0.000ms): update_process_times
(smp_apic_timer_interrupt)
00010000 0.001ms (+0.000ms): update_one_process (update_process_times)
00010000 0.002ms (+0.000ms): run_local_timers (update_process_times)
00010000 0.002ms (+0.000ms): raise_softirq (update_process_times)
00010000 0.002ms (+0.000ms): scheduler_tick (update_process_times)
00010000 0.002ms (+0.000ms): sched_clock (scheduler_tick)
00010000 0.003ms (+0.000ms): _spin_lock (scheduler_tick)
00010001 0.003ms (+0.000ms): _spin_unlock (scheduler_tick)
00010000 0.003ms (+0.000ms): rebalance_tick (scheduler_tick)
00010000 0.004ms (+0.000ms): irq_exit (smp_apic_timer_interrupt)
00000001 0.004ms (+0.000ms): do_softirq (irq_exit)
00000001 0.004ms (+0.000ms): __do_softirq (do_softirq)
00000101 0.004ms (+0.000ms): ___do_softirq (__do_softirq)
00000101 0.005ms (+0.000ms): run_timer_softirq (___do_softirq)
00000101 0.005ms (+0.000ms): _spin_lock_irq (run_timer_softirq)
00000101 0.005ms (+0.000ms): _spin_lock_irqsave (run_timer_softirq)
00000102 0.006ms (+0.000ms): _spin_unlock_irq (run_timer_softirq)
00000101 0.006ms (+0.000ms): peer_check_expire (run_timer_softirq)
00000101 0.007ms (+0.000ms): cleanup_once (peer_check_expire)
00000101 0.007ms (+0.000ms): _spin_lock_bh (cleanup_once)
00000101 0.008ms (+0.000ms): _spin_lock_irqsave (_spin_lock_bh)
00000202 0.008ms (+0.000ms): _spin_unlock_bh (cleanup_once)
00000201 0.008ms (+0.000ms): local_bh_enable (cleanup_once)
00000101 0.009ms (+0.000ms): __mod_timer (peer_check_expire)
00000101 0.009ms (+0.000ms): _spin_lock_irqsave (__mod_timer)
00000102 0.010ms (+0.000ms): _spin_lock (__mod_timer)
00000103 0.010ms (+0.000ms): internal_add_timer (__mod_timer)
00000103 0.011ms (+0.000ms): _spin_unlock (__mod_timer)
00000102 0.011ms (+0.000ms): _spin_unlock_irqrestore (__mod_timer)
00000101 0.012ms (+0.000ms): cond_resched_all (run_timer_softirq)
00000101 0.012ms (+0.000ms): cond_resched_softirq (run_timer_softirq)
00000101 0.012ms (+0.000ms): _spin_lock_irq (run_timer_softirq)
00000101 0.012ms (+0.000ms): _spin_lock_irqsave (run_timer_softirq)
00000102 0.013ms (+0.000ms): _spin_unlock_irq (run_timer_softirq)
00000101 0.013ms (+0.000ms): rt_check_expire (run_timer_softirq)
00000101 0.014ms (+0.000ms): _spin_lock (rt_check_expire)
00000102 0.014ms (+0.000ms): _spin_unlock (rt_check_expire)
00000101 0.015ms (+0.000ms): _spin_lock (rt_check_expire)
00000102 0.015ms (+0.000ms): _spin_unlock (rt_check_expire)
... MANY repetitions ...
00000101 0.151ms (+0.000ms): _spin_lock (rt_check_expire)
00000102 0.152ms (+0.000ms): _spin_unlock (rt_check_expire)
00000101 0.152ms (+0.001ms): _spin_lock (rt_check_expire)
00000102 0.153ms (+0.000ms): rt_may_expire (rt_check_expire)
00000102 0.153ms (+0.000ms): _spin_unlock (rt_check_expire)
00000101 0.154ms (+0.000ms): _spin_lock (rt_check_expire)
00000102 0.154ms (+0.000ms): _spin_unlock (rt_check_expire)
... MANY more repetitions ...
00000101 0.289ms (+0.000ms): _spin_lock (rt_check_expire)
00000102 0.289ms (+0.000ms): _spin_unlock (rt_check_expire)
00000101 0.290ms (+0.000ms): mod_timer (rt_check_expire)
00000101 0.290ms (+0.000ms): __mod_timer (rt_check_expire)
00000101 0.290ms (+0.000ms): _spin_lock_irqsave (__mod_timer)
00000102 0.291ms (+0.000ms): _spin_lock (__mod_timer)
00000103 0.291ms (+0.000ms): internal_add_timer (__mod_timer)
00000103 0.291ms (+0.000ms): _spin_unlock (__mod_timer)
00000102 0.292ms (+0.000ms): _spin_unlock_irqrestore (__mod_timer)
00000101 0.292ms (+0.000ms): cond_resched_all (run_timer_softirq)
00000101 0.292ms (+0.000ms): cond_resched_softirq (run_timer_softirq)
00000101 0.292ms (+0.000ms): _spin_lock_irq (run_timer_softirq)
00000101 0.292ms (+0.000ms): _spin_lock_irqsave (run_timer_softirq)
00000102 0.293ms (+0.000ms): _spin_unlock_irq (run_timer_softirq)
00000101 0.293ms (+0.000ms): __wake_up (run_timer_softirq)
00000101 0.293ms (+0.000ms): _spin_lock_irqsave (__wake_up)
00000102 0.293ms (+0.000ms): __wake_up_common (__wake_up)
00000102 0.294ms (+0.000ms): _spin_unlock_irqrestore (run_timer_softirq)
00000101 0.294ms (+0.000ms): cond_resched_all (___do_softirq)
00000101 0.294ms (+0.000ms): cond_resched_softirq (___do_softirq)
00000001 0.295ms (+0.000ms): sub_preempt_count (irq_exit)
00000001 0.295ms (+0.000ms): update_max_trace (check_preempt_timing)

[2] do_wait

Another example of several cycles up / down from preempt 1 to 2 to 1 ...

preemption latency trace v1.0.7 on 2.6.9-rc3-mm3-VP-T3
-------------------------------------------------------
 latency: 228 us, entries: 572 (572)   |   [VP:1 KP:1 SP:0 HP:0 #CPUS:2]
    -----------------
    | task: init/1, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: _read_lock+0x1b/0x80
 => ended at:   _read_unlock+0x1a/0x40
=======>
00000001 0.000ms (+0.000ms): _read_lock (do_wait)
00000001 0.000ms (+0.001ms): eligible_child (do_wait)
00000001 0.002ms (+0.000ms): selinux_task_wait (eligible_child)
00000001 0.003ms (+0.000ms): task_has_perm (selinux_task_wait)
00000001 0.004ms (+0.000ms): avc_has_perm (task_has_perm)
00000001 0.004ms (+0.000ms): avc_has_perm_noaudit (avc_has_perm)
00000001 0.004ms (+0.000ms): _spin_lock_irqsave (avc_has_perm_noaudit)
00000002 0.005ms (+0.000ms): avc_lookup (avc_has_perm_noaudit)
00000002 0.006ms (+0.000ms): _spin_unlock_irqrestore (avc_has_perm_noaudit)
00000001 0.007ms (+0.000ms): security_compute_av (avc_has_perm_noaudit)
00000001 0.007ms (+0.000ms): _spin_lock_irqsave (avc_has_perm_noaudit)
00000002 0.007ms (+0.000ms): avc_insert (avc_has_perm_noaudit)
00000002 0.008ms (+0.000ms): memcpy (avc_has_perm_noaudit)
00000002 0.008ms (+0.000ms): _spin_unlock_irqrestore (avc_has_perm_noaudit)
00000001 0.009ms (+0.000ms): avc_audit (avc_has_perm)
00000001 0.009ms (+0.000ms): eligible_child (do_wait)
00000001 0.010ms (+0.000ms): selinux_task_wait (eligible_child)
00000001 0.010ms (+0.000ms): task_has_perm (selinux_task_wait)
00000001 0.011ms (+0.000ms): avc_has_perm (task_has_perm)
00000001 0.011ms (+0.000ms): avc_has_perm_noaudit (avc_has_perm)
00000001 0.012ms (+0.000ms): _spin_lock_irqsave (avc_has_perm_noaudit)
...
00000001 0.221ms (+0.000ms): _spin_lock_irqsave (avc_has_perm_noaudit)
00000002 0.221ms (+0.000ms): memcpy (avc_has_perm_noaudit)
00000002 0.221ms (+0.000ms): _spin_unlock_irqrestore (avc_has_perm_noaudit)
00000001 0.222ms (+0.000ms): avc_audit (avc_has_perm)
00000001 0.222ms (+0.000ms): eligible_child (do_wait)
00000001 0.222ms (+0.000ms): selinux_task_wait (eligible_child)
00000001 0.223ms (+0.000ms): task_has_perm (selinux_task_wait)
00000001 0.223ms (+0.000ms): avc_has_perm (task_has_perm)
00000001 0.223ms (+0.000ms): avc_has_perm_noaudit (avc_has_perm)
00000001 0.224ms (+0.000ms): _spin_lock_irqsave (avc_has_perm_noaudit)
00000002 0.224ms (+0.000ms): memcpy (avc_has_perm_noaudit)
00000002 0.224ms (+0.000ms): _spin_unlock_irqrestore (avc_has_perm_noaudit)
00000001 0.224ms (+0.000ms): avc_audit (avc_has_perm)
00000001 0.225ms (+0.000ms): wait_task_zombie (do_wait)
00000001 0.226ms (+0.000ms): _spin_lock_irq (wait_task_zombie)
00000001 0.226ms (+0.000ms): _spin_lock_irqsave (wait_task_zombie)
00000002 0.227ms (+0.000ms): _spin_unlock_irq (wait_task_zombie)
00000001 0.227ms (+0.000ms): _read_unlock (wait_task_zombie)
00000001 0.228ms (+0.000ms): sub_preempt_count (_read_unlock)
00000001 0.228ms (+0.000ms): update_max_trace (check_preempt_timing)

[3] do_IRQ

Several traces look similar to those I reported previously, just have
some additional latency at the start & end. For example:


preemption latency trace v1.0.7 on 2.6.9-rc3-mm3-VP-T3
-------------------------------------------------------
 latency: 450 us, entries: 898 (898)   |   [VP:1 KP:1 SP:0 HP:0 #CPUS:2]
    -----------------
    | task: cpu_burn/13771, uid:0 nice:10 policy:0 rt_prio:0
    -----------------
 => started at: do_IRQ+0x19/0x90
 => ended at:   irq_exit+0x33/0x50
=======>
00010000 0.000ms (+0.000ms): do_IRQ (common_interrupt)
00010000 0.000ms (+0.000ms): do_IRQ (<08048340>)
00010000 0.000ms (+0.000ms): do_IRQ (<0000000b>)
00010000 0.000ms (+0.000ms): _spin_lock (__do_IRQ)
00010001 0.000ms (+0.000ms): mask_and_ack_level_ioapic_irq (__do_IRQ)
...
00020000 0.041ms (+0.000ms): irq_exit (do_IRQ)
00010000 0.041ms (+0.000ms): rtl8139_interrupt (handle_IRQ_event)
00010000 0.041ms (+0.001ms): _spin_lock (rtl8139_interrupt)
00010001 0.042ms (+0.000ms): _spin_unlock (rtl8139_interrupt)
00010000 0.043ms (+0.000ms): _spin_lock (__do_IRQ)
00010001 0.043ms (+0.000ms): note_interrupt (__do_IRQ)
00010001 0.043ms (+0.000ms): end_level_ioapic_irq (__do_IRQ)
00010001 0.043ms (+0.000ms): unmask_IO_APIC_irq (__do_IRQ)
00010001 0.044ms (+0.000ms): _spin_lock_irqsave (unmask_IO_APIC_irq)
00010002 0.044ms (+0.000ms): __unmask_IO_APIC_irq (unmask_IO_APIC_irq)
00010002 0.044ms (+0.013ms): __modify_IO_APIC_irq (__unmask_IO_APIC_irq)
00010002 0.058ms (+0.000ms): _spin_unlock_irqrestore (__do_IRQ)
00010001 0.058ms (+0.000ms): _spin_unlock (__do_IRQ)
00010000 0.058ms (+0.000ms): irq_exit (do_IRQ)
00000001 0.059ms (+0.000ms): do_softirq (irq_exit)
00000001 0.059ms (+0.000ms): __do_softirq (do_softirq)
00000101 0.059ms (+0.000ms): ___do_softirq (__do_softirq)
00000101 0.059ms (+0.000ms): net_rx_action (___do_softirq)
... if I read this right, 60 usec was taken prior to getting to
the soft IRQ w/o any preemption opportunities ...
... many more traces ...
00010101 0.427ms (+0.000ms): rtl8139_interrupt (handle_IRQ_event)
00010101 0.427ms (+0.001ms): _spin_lock (rtl8139_interrupt)
00010102 0.429ms (+0.000ms): rtl8139_tx_interrupt (rtl8139_interrupt)
00010102 0.430ms (+0.000ms): _spin_unlock (rtl8139_interrupt)
00010101 0.430ms (+0.000ms): preempt_schedule (rtl8139_interrupt)
00010101 0.431ms (+0.000ms): _spin_lock (__do_IRQ)
00010102 0.431ms (+0.000ms): note_interrupt (__do_IRQ)
00010102 0.431ms (+0.000ms): end_level_ioapic_irq (__do_IRQ)
00010102 0.431ms (+0.000ms): unmask_IO_APIC_irq (__do_IRQ)
00010102 0.432ms (+0.000ms): _spin_lock_irqsave (unmask_IO_APIC_irq)
00010103 0.432ms (+0.000ms): __unmask_IO_APIC_irq (unmask_IO_APIC_irq)
00010103 0.432ms (+0.013ms): __modify_IO_APIC_irq (__unmask_IO_APIC_irq)
00010103 0.446ms (+0.000ms): _spin_unlock_irqrestore (__do_IRQ)
00010102 0.446ms (+0.000ms): preempt_schedule (__do_IRQ)
00010102 0.447ms (+0.000ms): _spin_unlock (__do_IRQ)
00010101 0.447ms (+0.000ms): preempt_schedule (__do_IRQ)
00010101 0.447ms (+0.000ms): irq_exit (do_IRQ)
00000101 0.448ms (+0.000ms): __wake_up (run_timer_softirq)
00000101 0.448ms (+0.000ms): _spin_lock_irqsave (__wake_up)
00000102 0.448ms (+0.000ms): __wake_up_common (__wake_up)
00000102 0.448ms (+0.000ms): _spin_unlock_irqrestore (run_timer_softirq)
00000101 0.449ms (+0.000ms): preempt_schedule (run_timer_softirq)
00000101 0.449ms (+0.000ms): cond_resched_all (___do_softirq)
00000101 0.449ms (+0.001ms): cond_resched_softirq (___do_softirq)
00000001 0.450ms (+0.000ms): sub_preempt_count (irq_exit)
00000001 0.450ms (+0.000ms): update_max_trace (check_preempt_timing)

[not quite sure if the same symptom but has many of the same
features as above...]

preemption latency trace v1.0.7 on 2.6.9-rc3-mm3-VP-T3
-------------------------------------------------------
 latency: 507 us, entries: 609 (609)   |   [VP:1 KP:1 SP:0 HP:0 #CPUS:2]
    -----------------
    | task: rcp/13989, uid:2711 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: _spin_lock_irqsave+0x1f/0x80
 => ended at:   local_bh_enable+0x3f/0xb0

[16 - ditto, providing some detail]

preemption latency trace v1.0.7 on 2.6.9-rc3-mm3-VP-T3
-------------------------------------------------------
 latency: 474 us, entries: 919 (919)   |   [VP:1 KP:1 SP:0 HP:0 #CPUS:2]
    -----------------
    | task: klogd/1953, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: schedule+0x43/0x810
 => ended at:   schedule+0x412/0x810
=======>
00000001 0.000ms (+0.000ms): schedule (work_resched)
00000001 0.000ms (+0.000ms): sched_clock (schedule)
00000001 0.001ms (+0.000ms): _spin_lock_irq (schedule)
00000001 0.001ms (+0.001ms): _spin_lock_irqsave (schedule)
00000002 0.002ms (+0.000ms): dequeue_task (schedule)
00000002 0.003ms (+0.000ms): recalc_task_prio (schedule)
00000002 0.003ms (+0.000ms): effective_prio (recalc_task_prio)
00000002 0.003ms (+0.005ms): enqueue_task (schedule)
00000002 0.008ms (+0.001ms): __switch_to (schedule)
00000002 0.010ms (+0.000ms): finish_task_switch (schedule)
00000002 0.010ms (+0.001ms): _spin_unlock_irq (finish_task_switch)
00000002 0.011ms (+0.000ms): smp_apic_timer_interrupt (_spin_unlock_irq)
00010002 0.012ms (+0.000ms): profile_tick (smp_apic_timer_interrupt)
00010002 0.013ms (+0.000ms): profile_hook (profile_tick)
00010002 0.013ms (+0.001ms): _read_lock (profile_hook)
00010003 0.014ms (+0.000ms): notifier_call_chain (profile_hook)
00010003 0.015ms (+0.000ms): _read_unlock (profile_tick)
00010002 0.015ms (+0.000ms): profile_hit (smp_apic_timer_interrupt)
00010002 0.016ms (+0.000ms): update_process_times
(smp_apic_timer_interrupt)
00010002 0.017ms (+0.001ms): update_one_process (update_process_times)
00010002 0.018ms (+0.000ms): run_local_timers (update_process_times)
00010002 0.018ms (+0.000ms): raise_softirq (update_process_times)
00010002 0.019ms (+0.000ms): scheduler_tick (update_process_times)
00010002 0.019ms (+0.002ms): sched_clock (scheduler_tick)
00010002 0.021ms (+0.000ms): _spin_lock (scheduler_tick)
00010003 0.022ms (+0.000ms): task_timeslice (scheduler_tick)
00010003 0.022ms (+0.001ms): __bitmap_weight (scheduler_tick)
00010003 0.024ms (+0.000ms): __bitmap_weight (scheduler_tick)
00010003 0.024ms (+0.000ms): dequeue_task (scheduler_tick)
00010003 0.024ms (+0.000ms): effective_prio (scheduler_tick)
00010003 0.025ms (+0.000ms): enqueue_task (scheduler_tick)
00010003 0.025ms (+0.000ms): _spin_unlock (scheduler_tick)
00010002 0.025ms (+0.000ms): preempt_schedule (scheduler_tick)
00010002 0.025ms (+0.000ms): rebalance_tick (scheduler_tick)
00010002 0.026ms (+0.000ms): irq_exit (smp_apic_timer_interrupt)
00000003 0.026ms (+0.000ms): do_softirq (irq_exit)
00000003 0.027ms (+0.000ms): __do_softirq (do_softirq)
00000103 0.027ms (+0.000ms): ___do_softirq (__do_softirq)
00010103 0.028ms (+0.000ms): do_IRQ (___do_softirq)
00010103 0.028ms (+0.000ms): do_IRQ (<0000000b>)
00010103 0.029ms (+0.000ms): _spin_lock (__do_IRQ)
00010104 0.029ms (+0.000ms): mask_and_ack_level_ioapic_irq (__do_IRQ)
00010104 0.029ms (+0.000ms): mask_IO_APIC_irq
(mask_and_ack_level_ioapic_irq)
00010104 0.030ms (+0.000ms): _spin_lock_irqsave (mask_IO_APIC_irq)
00010105 0.030ms (+0.000ms): __mask_IO_APIC_irq (mask_IO_APIC_irq)
00010105 0.030ms (+0.014ms): __modify_IO_APIC_irq (__mask_IO_APIC_irq)
00010105 0.045ms (+0.000ms): _spin_unlock_irqrestore
(mask_and_ack_level_ioapic_irq)
00010104 0.045ms (+0.000ms): preempt_schedule
(mask_and_ack_level_ioapic_irq)
00010104 0.045ms (+0.000ms): redirect_hardirq (__do_IRQ)
00010104 0.045ms (+0.000ms): _spin_unlock (__do_IRQ)
00010103 0.046ms (+0.000ms): preempt_schedule (__do_IRQ)
00010103 0.046ms (+0.000ms): handle_IRQ_event (__do_IRQ)
00010103 0.047ms (+0.000ms): rtl8139_interrupt (handle_IRQ_event)
... pretty deep nesting ...
00000109 0.464ms (+0.000ms): activate_task (try_to_wake_up)
00000109 0.465ms (+0.000ms): sched_clock (activate_task)
00000109 0.465ms (+0.000ms): recalc_task_prio (activate_task)
00000109 0.465ms (+0.000ms): effective_prio (recalc_task_prio)
00000109 0.466ms (+0.000ms): enqueue_task (activate_task)
00000109 0.466ms (+0.000ms): _spin_unlock_irqrestore (try_to_wake_up)
00000108 0.466ms (+0.000ms): preempt_schedule (try_to_wake_up)
00000108 0.466ms (+0.000ms): _spin_unlock_irqrestore
(sk_stream_write_space)
00000107 0.467ms (+0.000ms): preempt_schedule (sk_stream_write_space)
00000107 0.467ms (+0.000ms): _spin_unlock (tcp_v4_rcv)
00000106 0.467ms (+0.000ms): preempt_schedule (tcp_v4_rcv)
00000105 0.468ms (+0.000ms): preempt_schedule (ip_local_deliver)
00000104 0.468ms (+0.000ms): preempt_schedule (netif_receive_skb)
00000104 0.469ms (+0.001ms): rtl8139_isr_ack (rtl8139_rx)
00000104 0.470ms (+0.000ms): _spin_unlock (rtl8139_poll)
00000103 0.471ms (+0.000ms): preempt_schedule (rtl8139_poll)
00000103 0.471ms (+0.000ms): cond_resched_all (___do_softirq)
00000103 0.471ms (+0.001ms): cond_resched_softirq (___do_softirq)
00000001 0.473ms (+0.001ms): preempt_schedule (finish_task_switch)
00000001 0.474ms (+0.000ms): sub_preempt_count (schedule)
00000001 0.474ms (+0.000ms): update_max_trace (check_preempt_timing)

[79 - ditto, different way to get started]

preemption latency trace v1.0.7 on 2.6.9-rc3-mm3-VP-T3
-------------------------------------------------------
 latency: 209 us, entries: 275 (275)   |   [VP:1 KP:1 SP:0 HP:0 #CPUS:2]
    -----------------
    | task: sleep/15758, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: unmap_vmas+0x12e/0x280
 => ended at:   _spin_unlock+0x2d/0x60


[4] rt_run_flush

The trace buffer filled up before this completed so I don't have
the sequence that stopped the trace.

preemption latency trace v1.0.7 on 2.6.9-rc3-mm3-VP-T3
-------------------------------------------------------
 latency: 2586 us, entries: 4000 (12487)   |   [VP:1 KP:1 SP:0 HP:0
#CPUS:2]
    -----------------
    | task: cpu_burn/13771, uid:0 nice:10 policy:0 rt_prio:0
    -----------------
 => started at: smp_apic_timer_interrupt+0x43/0xf0
 => ended at:   irq_exit+0x33/0x50
=======>
00010000 0.000ms (+0.000ms): smp_apic_timer_interrupt
(apic_timer_interrupt)
00010000 0.000ms (+0.000ms): profile_tick (smp_apic_timer_interrupt)
00010000 0.000ms (+0.000ms): profile_hook (profile_tick)
00010000 0.000ms (+0.000ms): _read_lock (profile_hook)
00010001 0.001ms (+0.000ms): notifier_call_chain (profile_hook)
00010001 0.001ms (+0.000ms): _read_unlock (profile_tick)
00010000 0.001ms (+0.000ms): update_process_times
(smp_apic_timer_interrupt)
00010000 0.001ms (+0.000ms): update_one_process (update_process_times)
00010000 0.002ms (+0.000ms): run_local_timers (update_process_times)
00010000 0.002ms (+0.000ms): raise_softirq (update_process_times)
00010000 0.002ms (+0.000ms): scheduler_tick (update_process_times)
00010000 0.002ms (+0.000ms): sched_clock (scheduler_tick)
00010000 0.003ms (+0.000ms): _spin_lock (scheduler_tick)
00010001 0.003ms (+0.000ms): _spin_unlock (scheduler_tick)
00010000 0.003ms (+0.000ms): rebalance_tick (scheduler_tick)
00010000 0.004ms (+0.000ms): irq_exit (smp_apic_timer_interrupt)
00000001 0.004ms (+0.000ms): do_softirq (irq_exit)
00000001 0.004ms (+0.000ms): __do_softirq (do_softirq)
00000101 0.004ms (+0.000ms): ___do_softirq (__do_softirq)
00000101 0.005ms (+0.000ms): run_timer_softirq (___do_softirq)
00000101 0.005ms (+0.000ms): _spin_lock_irq (run_timer_softirq)
00000101 0.005ms (+0.000ms): _spin_lock_irqsave (run_timer_softirq)
00000102 0.005ms (+0.000ms): _spin_unlock_irq (run_timer_softirq)
00000101 0.006ms (+0.000ms): rt_secret_rebuild (run_timer_softirq)
00000101 0.006ms (+0.000ms): rt_cache_flush (rt_secret_rebuild)
00000101 0.007ms (+0.000ms): _spin_lock_bh (rt_cache_flush)
00000101 0.007ms (+0.000ms): _spin_lock_irqsave (_spin_lock_bh)
00000202 0.007ms (+0.000ms): del_timer (rt_cache_flush)
00000202 0.008ms (+0.000ms): _spin_unlock_bh (rt_cache_flush)
00000201 0.008ms (+0.000ms): local_bh_enable (rt_cache_flush)
00000101 0.009ms (+0.000ms): rt_run_flush (rt_secret_rebuild)
00000101 0.009ms (+0.000ms): get_random_bytes (rt_run_flush)
00000101 0.009ms (+0.000ms): extract_entropy (get_random_bytes)
00000101 0.009ms (+0.000ms): _spin_lock_irqsave (extract_entropy)
00000102 0.010ms (+0.000ms): __wake_up (extract_entropy)
00000102 0.010ms (+0.000ms): _spin_lock_irqsave (__wake_up)
00000103 0.010ms (+0.000ms): __wake_up_common (__wake_up)
00000103 0.010ms (+0.000ms): _spin_unlock_irqrestore (extract_entropy)
00000102 0.011ms (+0.000ms): _spin_unlock_irqrestore (extract_entropy)
00000101 0.011ms (+0.000ms): SHATransform (extract_entropy)
00000101 0.011ms (+0.002ms): memcpy (SHATransform)
00000101 0.014ms (+0.000ms): add_entropy_words (extract_entropy)
00000101 0.014ms (+0.000ms): _spin_lock_irqsave (add_entropy_words)
00000102 0.014ms (+0.000ms): _spin_unlock_irqrestore (extract_entropy)
00000101 0.015ms (+0.000ms): SHATransform (extract_entropy)
00000101 0.015ms (+0.002ms): memcpy (SHATransform)
00000101 0.018ms (+0.000ms): add_entropy_words (extract_entropy)
00000101 0.018ms (+0.000ms): _spin_lock_irqsave (add_entropy_words)
00000102 0.018ms (+0.000ms): _spin_unlock_irqrestore (extract_entropy)
00000101 0.019ms (+0.000ms): _spin_lock_bh (rt_run_flush)
00000101 0.019ms (+0.000ms): _spin_lock_irqsave (_spin_lock_bh)
00000202 0.020ms (+0.000ms): _spin_unlock_bh (rt_run_flush)
00000201 0.020ms (+0.000ms): local_bh_enable (rt_run_flush)
00000101 0.020ms (+0.000ms): cond_resched_all (rt_run_flush)
00000101 0.020ms (+0.000ms): cond_resched_softirq (rt_run_flush)
00000101 0.021ms (+0.000ms): _spin_lock_bh (rt_run_flush)
00000101 0.021ms (+0.000ms): _spin_lock_irqsave (_spin_lock_bh)
00000202 0.021ms (+0.000ms): _spin_unlock_bh (rt_run_flush)
00000201 0.021ms (+0.000ms): local_bh_enable (rt_run_flush)
... this kind of cycle repeats a VERY long time and the watchdog
provides this piece of information ...
00000101 0.769ms (+0.000ms): _spin_lock_irqsave (_spin_lock_bh)
00000202 0.770ms (+0.000ms): _spin_unlock_bh (rt_run_flush)
00000201 0.770ms (+0.000ms): local_bh_enable (rt_run_flush)
00000101 0.770ms (+0.000ms): cond_resched_all (rt_run_flush)
00000101 0.771ms (+0.000ms): do_nmi (___trace)
00010101 0.771ms (+0.002ms): do_nmi (<08049b20>)
00010101 0.773ms (+0.000ms): notifier_call_chain (default_do_nmi)
00010101 0.773ms (+464353.452ms): nmi_watchdog_tick (default_do_nmi)
00000002 464354.226ms (+12313.439ms): _spin_unlock (release_console_sem)
00010101 0.774ms (+0.000ms): do_IRQ (___trace)
00010101 0.774ms (+0.000ms): do_IRQ (<00000000>)
00010101 0.774ms (+0.000ms): _spin_lock (__do_IRQ)
00010102 0.775ms (+0.000ms): ack_edge_ioapic_irq (__do_IRQ)
00010102 0.775ms (+0.000ms): redirect_hardirq (__do_IRQ)
00010102 0.775ms (+0.000ms): _spin_unlock (__do_IRQ)
00010101 0.776ms (+0.000ms): handle_IRQ_event (__do_IRQ)
00010101 0.776ms (+0.000ms): timer_interrupt (handle_IRQ_event)
00010101 0.776ms (+0.000ms): _spin_lock (timer_interrupt)
00010102 0.776ms (+0.000ms): mark_offset_tsc (timer_interrupt)
00010102 0.777ms (+0.000ms): _spin_lock (mark_offset_tsc)
00010103 0.777ms (+0.010ms): _spin_lock (mark_offset_tsc)
00010104 0.787ms (+0.000ms): _spin_unlock (mark_offset_tsc)
00010103 0.788ms (+0.000ms): _spin_unlock (mark_offset_tsc)
00010102 0.788ms (+0.003ms): _spin_lock (timer_interrupt)
00010103 0.792ms (+0.000ms): _spin_unlock (timer_interrupt)
00010102 0.792ms (+0.000ms): do_timer (timer_interrupt)
00010102 0.792ms (+0.000ms): update_wall_time (do_timer)
... more traces ...
00000101 1.023ms (+0.000ms): cond_resched_all (rt_run_flush)
00000101 1.023ms (+0.000ms): cond_resched_softirq (rt_run_flush)
00000101 1.023ms (+0.000ms): _spin_lock_bh (rt_run_flush)
00000101 1.024ms (+0.000ms): _spin_lock_irqsave (_spin_lock_bh)
00000202 1.024ms (+0.000ms): _spin_unlock_bh (rt_run_flush)
00000201 1.024ms (+0.000ms): local_bh_enable (rt_run_flush)
00000101 1.025ms (+0.000ms): cond_resched_all (rt_run_flush)
00000101 1.025ms (+0.000ms): cond_resched_softirq (rt_run_flush)
00000101 1.025ms (+0.000ms): _spin_lock_bh (rt_run_flush)
00000101 1.025ms (+0.000ms): _spin_lock_irqsave (_spin_lock_bh)
00000202 1.026ms (+0.000ms): _spin_unlock_bh (rt_run_flush)
00000201 1.026ms (+0.000ms): local_bh_enable (rt_run_flush)
00000101 1.026ms (+0.000ms): cond_resched_all (rt_run_flush)
00000101 1.026ms (+2915178.859ms): cond_resched_softirq (rt_run_flush)
[not sure why the odd values shown in some of the traces either]

[5] rcu / cache actions

May be a false positive due to latency tracing overhead.

preemption latency trace v1.0.7 on 2.6.9-rc3-mm3-VP-T3
-------------------------------------------------------
 latency: 207 us, entries: 431 (431)   |   [VP:1 KP:1 SP:0 HP:0 #CPUS:2]
    -----------------
    | task: kswapd0/72, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: cond_resched_lock+0x24/0xf0
 => ended at:   cond_resched_lock+0x60/0xf0
=======>
00000001 0.000ms (+0.000ms): touch_preempt_timing (cond_resched_lock)
00000001 0.000ms (+0.000ms): smp_apic_timer_interrupt
(touch_preempt_timing)
00010001 0.000ms (+0.000ms): profile_tick (smp_apic_timer_interrupt)
00010001 0.000ms (+0.000ms): profile_hook (profile_tick)
00010001 0.001ms (+0.000ms): _read_lock (profile_hook)
00010002 0.001ms (+0.000ms): notifier_call_chain (profile_hook)
00010002 0.001ms (+0.000ms): _read_unlock (profile_tick)
00010001 0.001ms (+0.000ms): profile_hit (smp_apic_timer_interrupt)
00010001 0.002ms (+0.000ms): update_process_times
(smp_apic_timer_interrupt)
00010001 0.002ms (+0.000ms): update_one_process (update_process_times)
00010001 0.002ms (+0.000ms): run_local_timers (update_process_times)
00010001 0.002ms (+0.000ms): raise_softirq (update_process_times)
00010001 0.003ms (+0.000ms): scheduler_tick (update_process_times)
00010001 0.003ms (+0.000ms): sched_clock (scheduler_tick)
00010001 0.003ms (+0.000ms): rcu_check_callbacks (scheduler_tick)
00010001 0.003ms (+0.000ms): idle_cpu (rcu_check_callbacks)
00010001 0.004ms (+0.000ms): __tasklet_schedule (scheduler_tick)
00010001 0.004ms (+0.000ms): _spin_lock (scheduler_tick)
00010002 0.004ms (+0.000ms): task_timeslice (scheduler_tick)
00010002 0.004ms (+0.000ms): __bitmap_weight (scheduler_tick)
00010002 0.005ms (+0.000ms): _spin_unlock (scheduler_tick)
00010001 0.005ms (+0.000ms): rebalance_tick (scheduler_tick)
00010001 0.005ms (+0.000ms): irq_exit (smp_apic_timer_interrupt)
00000002 0.006ms (+0.000ms): do_softirq (irq_exit)
00000002 0.006ms (+0.000ms): __do_softirq (do_softirq)
00000102 0.006ms (+0.000ms): ___do_softirq (__do_softirq)
00000102 0.006ms (+0.000ms): run_timer_softirq (___do_softirq)
00000102 0.006ms (+0.000ms): _spin_lock_irq (run_timer_softirq)
00000102 0.007ms (+0.000ms): _spin_lock_irqsave (run_timer_softirq)
00000103 0.007ms (+0.000ms): _spin_unlock_irq (run_timer_softirq)
00000102 0.007ms (+0.000ms): __wake_up (run_timer_softirq)
00000102 0.007ms (+0.000ms): _spin_lock_irqsave (__wake_up)
00000103 0.008ms (+0.000ms): __wake_up_common (__wake_up)
00000103 0.008ms (+0.000ms): _spin_unlock_irqrestore (run_timer_softirq)
00000102 0.008ms (+0.000ms): cond_resched_all (___do_softirq)
00000102 0.008ms (+0.000ms): cond_resched_softirq (___do_softirq)
00000102 0.009ms (+0.000ms): tasklet_action (___do_softirq)
00000102 0.009ms (+0.000ms): rcu_process_callbacks (tasklet_action)
00000102 0.009ms (+0.000ms): __rcu_process_callbacks
(rcu_process_callbacks)
00000102 0.010ms (+0.000ms): _spin_lock (__rcu_process_callbacks)
00000103 0.010ms (+0.000ms): rcu_start_batch (__rcu_process_callbacks)
00000103 0.010ms (+0.000ms): _spin_unlock (__rcu_process_callbacks)
00000102 0.010ms (+0.000ms): rcu_check_quiescent_state
(__rcu_process_callbacks)
00000102 0.011ms (+0.000ms): rcu_do_batch (rcu_process_callbacks)
00000102 0.012ms (+0.000ms): d_callback (rcu_do_batch)
00000102 0.012ms (+0.001ms): kmem_cache_free (d_callback)
00000102 0.013ms (+0.000ms): d_callback (rcu_do_batch)
00000102 0.014ms (+0.000ms): kmem_cache_free (d_callback)
00000102 0.014ms (+0.000ms): d_callback (rcu_do_batch)
00000102 0.015ms (+0.000ms): kmem_cache_free (d_callback)
00000102 0.016ms (+0.000ms): cache_flusharray (kmem_cache_free)
00000102 0.016ms (+0.001ms): _spin_lock (cache_flusharray)
00000103 0.017ms (+0.003ms): free_block (cache_flusharray)
00000103 0.021ms (+0.000ms): _spin_unlock (cache_flusharray)
00000102 0.021ms (+0.000ms): memmove (cache_flusharray)
00000102 0.021ms (+0.000ms): memcpy (memmove)
00000102 0.022ms (+0.000ms): d_callback (rcu_do_batch)
00000102 0.022ms (+0.000ms): kmem_cache_free (d_callback)
00000102 0.022ms (+0.000ms): d_callback (rcu_do_batch)
00000102 0.023ms (+0.000ms): kmem_cache_free (d_callback)
00000102 0.023ms (+0.000ms): d_callback (rcu_do_batch)
00000102 0.024ms (+0.000ms): kmem_cache_free (d_callback)
00000102 0.024ms (+0.000ms): d_callback (rcu_do_batch)
00000102 0.025ms (+0.000ms): kmem_cache_free (d_callback)
...
00000102 0.190ms (+0.000ms): cache_flusharray (kmem_cache_free)
00000102 0.190ms (+0.000ms): _spin_lock (cache_flusharray)
00000103 0.191ms (+0.003ms): free_block (cache_flusharray)
00000103 0.194ms (+0.000ms): _spin_unlock (cache_flusharray)
00000102 0.194ms (+0.000ms): memmove (cache_flusharray)
00000102 0.195ms (+0.000ms): memcpy (memmove)
00000102 0.195ms (+0.000ms): d_callback (rcu_do_batch)
00000102 0.195ms (+0.000ms): kmem_cache_free (d_callback)
00000102 0.196ms (+0.000ms): __tasklet_schedule (rcu_process_callbacks)
00000102 0.196ms (+0.000ms): __rcu_process_callbacks
(rcu_process_callbacks)
00000102 0.197ms (+0.000ms): rcu_check_quiescent_state
(__rcu_process_callbacks)
00000102 0.197ms (+0.000ms): cond_resched_all (___do_softirq)
00000102 0.197ms (+0.000ms): cond_resched_softirq (___do_softirq)
00000102 0.198ms (+0.000ms): wake_up_process (__do_softirq)
00000102 0.198ms (+0.000ms): try_to_wake_up (wake_up_process)
00000102 0.199ms (+0.000ms): task_rq_lock (try_to_wake_up)
00000102 0.199ms (+0.001ms): _spin_lock (task_rq_lock)
00000103 0.201ms (+0.000ms): activate_task (try_to_wake_up)
00000103 0.201ms (+0.000ms): sched_clock (activate_task)
00000103 0.202ms (+0.001ms): recalc_task_prio (activate_task)
00000103 0.203ms (+0.000ms): effective_prio (recalc_task_prio)
00000103 0.203ms (+0.001ms): enqueue_task (activate_task)
00000103 0.204ms (+0.000ms): resched_task (try_to_wake_up)
00000103 0.205ms (+0.001ms): _spin_unlock_irqrestore (try_to_wake_up)
00000102 0.206ms (+0.001ms): preempt_schedule (try_to_wake_up)
00000001 0.207ms (+0.000ms): sub_preempt_count (cond_resched_lock)
00000001 0.208ms (+0.000ms): update_max_trace (check_preempt_timing)

[6] prune_icache

If I read this right, an operation that should have taken 100 usec or
so, was preempted by an even longer duration series of operations.

preemption latency trace v1.0.7 on 2.6.9-rc3-mm3-VP-T3
-------------------------------------------------------
 latency: 263 us, entries: 597 (597)   |   [VP:1 KP:1 SP:0 HP:0 #CPUS:2]
    -----------------
    | task: kswapd0/72, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: _spin_lock+0x1f/0x70
 => ended at:   _spin_unlock+0x2d/0x60
=======>
00000001 0.000ms (+0.000ms): _spin_lock (prune_icache)
00000001 0.000ms (+0.000ms): inode_has_buffers (prune_icache)
00000001 0.001ms (+0.000ms): inode_has_buffers (prune_icache)
00000001 0.001ms (+0.000ms): inode_has_buffers (prune_icache)
00000001 0.002ms (+0.000ms): inode_has_buffers (prune_icache)
...
00000001 0.075ms (+0.000ms): smp_apic_timer_interrupt (prune_icache)
00010001 0.075ms (+0.000ms): profile_tick (smp_apic_timer_interrupt)
00010001 0.075ms (+0.000ms): profile_hook (profile_tick)
00010001 0.075ms (+0.000ms): _read_lock (profile_hook)
00010002 0.076ms (+0.000ms): notifier_call_chain (profile_hook)
00010002 0.076ms (+0.000ms): _read_unlock (profile_tick)
00010001 0.076ms (+0.000ms): profile_hit (smp_apic_timer_interrupt)
00010001 0.077ms (+0.000ms): update_process_times
(smp_apic_timer_interrupt)
00010001 0.077ms (+0.000ms): update_one_process (update_process_times)
00010001 0.078ms (+0.000ms): run_local_timers (update_process_times)
00010001 0.078ms (+0.000ms): raise_softirq (update_process_times)
00010001 0.078ms (+0.000ms): scheduler_tick (update_process_times)
00010001 0.078ms (+0.000ms): sched_clock (scheduler_tick)
00010001 0.079ms (+0.000ms): rcu_check_callbacks (scheduler_tick)
00010001 0.080ms (+0.000ms): idle_cpu (rcu_check_callbacks)
... it then runs later ...
00000102 0.097ms (+0.001ms): tasklet_action (___do_softirq)
00000102 0.098ms (+0.000ms): rcu_process_callbacks (tasklet_action)
00000102 0.098ms (+0.000ms): __rcu_process_callbacks
(rcu_process_callbacks)
00000102 0.099ms (+0.000ms): rcu_check_quiescent_state
(__rcu_process_callbacks)
00000102 0.100ms (+0.000ms): rcu_do_batch (rcu_process_callbacks)
00000102 0.100ms (+0.000ms): d_callback (rcu_do_batch)
00000102 0.101ms (+0.000ms): kmem_cache_free (d_callback)
00000102 0.101ms (+0.000ms): d_callback (rcu_do_batch)
00000102 0.102ms (+0.000ms): kmem_cache_free (d_callback)
... finally getting back to the original work ...
00000103 0.237ms (+0.000ms): resched_task (try_to_wake_up)
00000103 0.238ms (+0.000ms): _spin_unlock_irqrestore (try_to_wake_up)
00000102 0.238ms (+0.001ms): preempt_schedule (try_to_wake_up)
00000001 0.239ms (+0.001ms): inode_has_buffers (prune_icache)
00000001 0.240ms (+0.000ms): inode_has_buffers (prune_icache)
00000001 0.241ms (+0.000ms): inode_has_buffers (prune_icache)
...
00000001 0.262ms (+0.000ms): inode_has_buffers (prune_icache)
00000001 0.263ms (+0.001ms): _spin_unlock (prune_icache)
00000001 0.264ms (+0.000ms): sub_preempt_count (_spin_unlock)
00000001 0.264ms (+0.000ms): update_max_trace (check_preempt_timing)

[7] clear_page_tables

preemption latency trace v1.0.7 on 2.6.9-rc3-mm3-VP-T3
-------------------------------------------------------
 latency: 208 us, entries: 67 (67)   |   [VP:1 KP:1 SP:0 HP:0 #CPUS:2]
    -----------------
    | task: get_ltrace.sh/16132, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: unmap_vmas+0x12e/0x280
 => ended at:   _spin_unlock+0x2d/0x60
=======>
00000001 0.000ms (+0.000ms): touch_preempt_timing (unmap_vmas)
00000001 0.000ms (+0.000ms): __bitmap_weight (unmap_vmas)
00000001 0.000ms (+0.000ms): unmap_page_range (unmap_vmas)
00000001 0.000ms (+0.000ms): zap_pmd_range (unmap_page_range)
00000001 0.000ms (+0.000ms): zap_pte_range (zap_pmd_range)
00000001 0.001ms (+0.000ms): kmap_atomic (zap_pte_range)
00000002 0.001ms (+0.001ms): page_address (zap_pte_range)
00000002 0.002ms (+0.000ms): set_page_dirty (zap_pte_range)
00000002 0.002ms (+0.000ms): page_remove_rmap (zap_pte_range)
00000002 0.002ms (+0.000ms): set_page_dirty (zap_pte_range)
00000002 0.003ms (+0.000ms): page_remove_rmap (zap_pte_range)
00000002 0.003ms (+0.000ms): set_page_dirty (zap_pte_range)
00000002 0.003ms (+0.000ms): page_remove_rmap (zap_pte_range)
00000002 0.004ms (+0.000ms): kunmap_atomic (zap_pte_range)
00000001 0.004ms (+0.002ms): vm_acct_memory (exit_mmap)
00000001 0.007ms (+0.181ms): clear_page_tables (exit_mmap)
00000001 0.189ms (+0.000ms): flush_tlb_mm (exit_mmap)
...

[8] avc_insert

The watchdog timer woke this up but avc_insert appears to be
the long step.

preemption latency trace v1.0.7 on 2.6.9-rc3-mm3-VP-T3
-------------------------------------------------------
 latency: 248 us, entries: 35 (35)   |   [VP:1 KP:1 SP:0 HP:0 #CPUS:2]
    -----------------
    | task: fam/2929, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: _spin_lock_irqsave+0x1f/0x80
 => ended at:   _spin_unlock_irqrestore+0x32/0x70
=======>
00000001 0.000ms (+0.000ms): _spin_lock_irqsave (avc_has_perm_noaudit)
00000001 0.000ms (+0.020ms): avc_insert (avc_has_perm_noaudit)
00010001 0.020ms (+0.001ms): do_nmi (avc_insert)
00010001 0.022ms (+0.005ms): do_nmi (<08049b20>)
00010001 0.027ms (+0.000ms): notifier_call_chain (default_do_nmi)
00010001 0.027ms (+0.185ms): nmi_watchdog_tick (default_do_nmi)
00000001 0.213ms (+0.000ms): memcpy (avc_has_perm_noaudit)
00000001 0.213ms (+0.000ms): _spin_unlock_irqrestore (avc_has_perm_noaudit)
00010001 0.214ms (+0.000ms): do_IRQ (_spin_unlock_irqrestore)
00010001 0.214ms (+0.000ms): do_IRQ (<00000000>)
00010001 0.215ms (+0.000ms): _spin_lock (__do_IRQ)
00010002 0.215ms (+0.000ms): ack_edge_ioapic_irq (__do_IRQ)
00010002 0.216ms (+0.000ms): redirect_hardirq (__do_IRQ)
00010002 0.216ms (+0.000ms): _spin_unlock (__do_IRQ)
00010001 0.216ms (+0.000ms): handle_IRQ_event (__do_IRQ)
00010001 0.217ms (+0.000ms): timer_interrupt (handle_IRQ_event)
00010001 0.217ms (+0.000ms): _spin_lock (timer_interrupt)
00010002 0.218ms (+0.000ms): mark_offset_tsc (timer_interrupt)
00010002 0.218ms (+0.000ms): _spin_lock (mark_offset_tsc)
00010003 0.219ms (+0.013ms): _spin_lock (mark_offset_tsc)
00010004 0.232ms (+0.000ms): _spin_unlock (mark_offset_tsc)
00010003 0.233ms (+0.000ms): _spin_unlock (mark_offset_tsc)
00010002 0.234ms (+0.007ms): _spin_lock (timer_interrupt)
00010003 0.242ms (+0.000ms): _spin_unlock (timer_interrupt)
00010002 0.242ms (+0.000ms): do_timer (timer_interrupt)
00010002 0.243ms (+0.000ms): update_wall_time (do_timer)
00010002 0.243ms (+0.003ms): update_wall_time_one_tick (update_wall_time)
00010002 0.246ms (+0.000ms): _spin_unlock (timer_interrupt)
00010001 0.247ms (+0.000ms): _spin_lock (__do_IRQ)
00010002 0.247ms (+0.000ms): note_interrupt (__do_IRQ)
00010002 0.247ms (+0.000ms): end_edge_ioapic_irq (__do_IRQ)
00010002 0.247ms (+0.000ms): _spin_unlock (__do_IRQ)
00010001 0.248ms (+0.001ms): irq_exit (do_IRQ)
00000001 0.249ms (+0.001ms): sub_preempt_count (_spin_unlock_irqrestore)
00000001 0.250ms (+0.000ms): update_max_trace (check_preempt_timing)

