Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270058AbUJSRsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270058AbUJSRsW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 13:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269982AbUJSRjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 13:39:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:1192 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S269945AbUJSRdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 13:33:35 -0400
X-Authenticated: #4399952
Date: Tue, 19 Oct 2004 19:49:16 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U6
Message-ID: <20041019194916.470617aa@mango.fruits.de>
In-Reply-To: <20041019165646.GA14053@elte.hu>
References: <20041014002433.GA19399@elte.hu>
	<20041014143131.GA20258@elte.hu>
	<20041014234202.GA26207@elte.hu>
	<20041015102633.GA20132@elte.hu>
	<20041016153344.GA16766@elte.hu>
	<20041018145008.GA25707@elte.hu>
	<20041019124605.GA28896@elte.hu>
	<20041019144642.GA6512@elte.hu>
	<28172.195.245.190.93.1098199429.squirrel@195.245.190.93>
	<20041019185016.2af4fa86@mango.fruits.de>
	<20041019165646.GA14053@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2004 18:56:46 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> do you get the same pauses if you do 'dmesg -n 1'? Also, are you using
> preempt_thresh or the maximum-searching variant? preempt_thresh can
> generate _tons_ of messages with a low threshold, freezing the system in
> essence for long periods of time.

afaik i use the maximum search:

mango:~# cat /proc/sys/kernel/preempt_thresh 
0
mango:~# cat /proc/sys/kernel/preempt_max_latency 
1841

I'll compile a kernel w/o preempt-timing and tracing. But i will get to it
tomorrow the earliest.

> but this trace is weird:

 [snip]
 
> this doesnt seem like normal behavior. It seems two tasks are
> ping-pong-ing a semaphore but are unable to make any progress. The whole
> thing is non-preemptible because this semaphore was taken while in a 
> PREEMPT_ACTIVE section.
> 
> (i'd say this is the BKL semaphore - it is quite special in that
> regard.)

btw: afaics these long critical sections reports do not correlate to the
pauses X makes (not sure though). I have anther long one. This is from
syslog as i haven't had the tracing enabled at that time:

(IRQ 3/117/CPU#0): new 1385 us maximum-latency critical section.
 => started at timestamp 2293619762: <call_console_drivers+0x76/0x140>
 =>   ended at timestamp 2293621147: <finish_task_switch+0x43/0xb0>
 [<c012f630>] sub_preempt_count+0x60/0x90
 [<c012f31e>] check_preempt_timing+0x15e/0x270
 [<c0114ae3>] finish_task_switch+0x43/0xb0
 [<c012f630>] sub_preempt_count+0x60/0x90
 [<c0114ae3>] finish_task_switch+0x43/0xb0
 [<c0114ae3>] finish_task_switch+0x43/0xb0
 [<c02a7917>] __schedule+0x2d7/0x5d0
 [<c0136faa>] do_irqd+0x5a/0x80
 [<c0112440>] mcount+0x14/0x18
 [<c0136faa>] do_irqd+0x5a/0x80
 [<c012d82a>] kthread+0xaa/0xb0
 [<c0136f50>] do_irqd+0x0/0x80
 [<c012d780>] kthread+0x0/0xb0
 [<c0104099>] kernel_thread_helper+0x5/0xc
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: __schedule+0x3b/0x5d0 / (do_irqd+0x5a/0x80)
.. entry 2: print_traces+0x1d/0x80 / (dump_stack+0x23/0x30)

 =>   dump-end timestamp 2293621634



Here's a similar (to the one from my last mail) shorter one:

preemption latency trace v1.0.7 on 2.6.9-rc4-mm1-RT-U6
-------------------------------------------------------
 latency: 471 us, entries: 2562 (2562)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:1]
    -----------------
    | task: xterm/3155, uid:1000 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: cond_resched+0x23/0x80 <c02a82b3>
 => ended at:   finish_task_switch+0x43/0xb0 <c0114ae3>
=======>
04000001 0.000ms (+0.000ms): __rwsem_deadlock (down_write)
04000000 0.000ms (+0.000ms): schedule (down_write)
04000000 0.000ms (+0.000ms): __schedule (down_write)
04000001 0.000ms (+0.000ms): sched_clock (__schedule)
04000000 0.000ms (+0.000ms): schedule (down_write)
04000000 0.000ms (+0.000ms): __schedule (down_write)
04000001 0.000ms (+0.000ms): sched_clock (__schedule)
04000000 0.001ms (+0.000ms): schedule (down_write)
04000000 0.001ms (+0.000ms): __schedule (down_write)
04000001 0.001ms (+0.000ms): sched_clock (__schedule)
04000000 0.001ms (+0.000ms): schedule (down_write)
04000000 0.001ms (+0.000ms): __schedule (down_write)
04000001 0.001ms (+0.000ms): sched_clock (__schedule)
04000000 0.002ms (+0.000ms): schedule (down_write)
04000000 0.002ms (+0.000ms): __schedule (down_write)
04000001 0.002ms (+0.000ms): sched_clock (__schedule)
04000000 0.002ms (+0.000ms): schedule (down_write)
04000000 0.002ms (+0.000ms): __schedule (down_write)
04000001 0.002ms (+0.000ms): sched_clock (__schedule)
04000000 0.002ms (+0.000ms): schedule (down_write)
04000000 0.002ms (+0.000ms): __schedule (down_write)
04000001 0.003ms (+0.000ms): sched_clock (__schedule)
04000000 0.003ms (+0.000ms): schedule (down_write)
04000000 0.003ms (+0.000ms): __schedule (down_write)
04000001 0.003ms (+0.000ms): sched_clock (__schedule)
04000000 0.003ms (+0.000ms): schedule (down_write)

[many many more]

04000000 0.445ms (+0.000ms): __schedule (down_write)
04000001 0.445ms (+0.000ms): sched_clock (__schedule)
04000000 0.446ms (+0.000ms): schedule (down_write)
04000000 0.446ms (+0.000ms): __schedule (down_write)
04000001 0.446ms (+0.000ms): sched_clock (__schedule)
04000000 0.446ms (+0.000ms): schedule (down_write)
04000000 0.446ms (+0.000ms): __schedule (down_write)
04000001 0.447ms (+0.000ms): sched_clock (__schedule)
04000000 0.447ms (+0.000ms): schedule (down_write)
04000000 0.447ms (+0.000ms): __schedule (down_write)
04000001 0.447ms (+0.000ms): sched_clock (__schedule)
04000000 0.447ms (+0.000ms): schedule (down_write)
04000000 0.447ms (+0.000ms): __schedule (down_write)
04000001 0.448ms (+0.000ms): sched_clock (__schedule)
04000000 0.448ms (+0.000ms): schedule (down_write)
04000000 0.448ms (+0.000ms): __schedule (down_write)
04000001 0.448ms (+0.000ms): sched_clock (__schedule)
04000000 0.448ms (+0.000ms): schedule (down_write)
04000000 0.449ms (+0.000ms): __schedule (down_write)
04000001 0.449ms (+0.000ms): sched_clock (__schedule)
04000000 0.449ms (+0.000ms): schedule (down_write)
04000000 0.449ms (+0.000ms): __schedule (down_write)
04000001 0.449ms (+0.000ms): sched_clock (__schedule)
04000000 0.449ms (+0.000ms): schedule (down_write)
04000000 0.450ms (+0.000ms): __schedule (down_write)
04000001 0.450ms (+0.000ms): sched_clock (__schedule)
04000000 0.450ms (+0.000ms): schedule (down_write)
04000000 0.450ms (+0.000ms): __schedule (down_write)
04000001 0.450ms (+0.000ms): sched_clock (__schedule)
04000000 0.450ms (+0.000ms): schedule (down_write)
04000000 0.451ms (+0.000ms): __schedule (down_write)
04000001 0.451ms (+0.000ms): sched_clock (__schedule)
04000000 0.451ms (+0.000ms): schedule (down_write)
04000000 0.451ms (+0.000ms): __schedule (down_write)
04000001 0.451ms (+0.000ms): sched_clock (__schedule)
04000000 0.452ms (+0.000ms): schedule (down_write)
04000000 0.452ms (+0.000ms): __schedule (down_write)
04000001 0.452ms (+0.000ms): sched_clock (__schedule)
04000000 0.452ms (+0.000ms): schedule (down_write)
04000000 0.452ms (+0.000ms): __schedule (down_write)
04000001 0.452ms (+0.000ms): sched_clock (__schedule)
04000000 0.453ms (+0.000ms): schedule (down_write)
04000000 0.453ms (+0.000ms): __schedule (down_write)
04000001 0.453ms (+0.000ms): sched_clock (__schedule)
04000000 0.453ms (+0.000ms): schedule (down_write)
04000000 0.453ms (+0.000ms): __schedule (down_write)
04000001 0.453ms (+0.000ms): sched_clock (__schedule)
04000000 0.454ms (+0.000ms): schedule (down_write)
04000000 0.454ms (+0.000ms): __schedule (down_write)
04000001 0.454ms (+0.000ms): sched_clock (__schedule)
04000000 0.454ms (+0.000ms): schedule (down_write)
04000000 0.454ms (+0.001ms): __schedule (down_write)
04010000 0.455ms (+0.000ms): do_IRQ (add_preempt_count)
04010000 0.455ms (+0.000ms): do_IRQ (<00000000>)
00010001 0.456ms (+0.001ms): mask_and_ack_8259A (__do_IRQ)
00010001 0.458ms (+0.000ms): redirect_hardirq (__do_IRQ)
00010000 0.458ms (+0.000ms): handle_IRQ_event (__do_IRQ)
00010000 0.458ms (+0.000ms): timer_interrupt (handle_IRQ_event)
00010001 0.458ms (+0.006ms): mark_offset_tsc (timer_interrupt)
00010001 0.464ms (+0.000ms): do_timer (timer_interrupt)
00010001 0.465ms (+0.000ms): update_wall_time (do_timer)
00010001 0.465ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
00010001 0.465ms (+0.000ms): update_process_times (timer_interrupt)
00010001 0.465ms (+0.000ms): update_one_process (update_process_times)
00010001 0.465ms (+0.000ms): run_local_timers (update_process_times)
00010001 0.466ms (+0.000ms): raise_softirq (update_process_times)
00010001 0.466ms (+0.000ms): scheduler_tick (update_process_times)
00010001 0.466ms (+0.000ms): sched_clock (scheduler_tick)
00010002 0.466ms (+0.000ms): task_timeslice (scheduler_tick)
00010002 0.467ms (+0.000ms): dequeue_task (scheduler_tick)
00010002 0.467ms (+0.000ms): effective_prio (scheduler_tick)
00010002 0.467ms (+0.000ms): enqueue_task (scheduler_tick)
00010001 0.468ms (+0.000ms): note_interrupt (__do_IRQ)
00010001 0.468ms (+0.000ms): end_8259A_irq (__do_IRQ)
00010001 0.468ms (+0.000ms): enable_8259A_irq (__do_IRQ)
04010000 0.469ms (+0.000ms): irq_exit (do_IRQ)
04000001 0.469ms (+0.000ms): sched_clock (__schedule)
00000002 0.470ms (+0.000ms): __switch_to (__schedule)
00000002 0.470ms (+0.000ms): finish_task_switch (__schedule)












one more:

preemption latency trace v1.0.7 on 2.6.9-rc4-mm1-RT-U6
-------------------------------------------------------
 latency: 2363 us, entries: 4000 (15429)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:1]
    -----------------
    | task: xterm/3155, uid:1000 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: cond_resched+0x23/0x80 <c02a82b3>
 => ended at:   finish_task_switch+0x43/0xb0 <c0114ae3>
=======>
04000001 0.000ms (+0.000ms): __rwsem_deadlock (down_write)
04000000 0.000ms (+0.000ms): schedule (down_write)
04000000 0.000ms (+0.000ms): __schedule (down_write)
04000001 0.000ms (+0.000ms): sched_clock (__schedule)
04000000 0.000ms (+0.000ms): schedule (down_write)
04000000 0.000ms (+0.000ms): __schedule (down_write)

[more]

04000000 0.347ms (+0.000ms): schedule (down_write)
04000000 0.348ms (+0.000ms): __schedule (down_write)
04000001 0.348ms (+0.000ms): sched_clock (__schedule)
04000000 0.348ms (+0.000ms): schedule (down_write)
04000000 0.348ms (+0.000ms): __schedule (down_write)
04000001 0.348ms (+0.000ms): sched_clock (__schedule)
04000000 0.349ms (+0.000ms): schedule (down_write)
04000000 0.349ms (+0.000ms): __schedule (down_write)
04000001 0.349ms (+0.000ms): sched_clock (__schedule)
04000000 0.349ms (+0.000ms): schedule (down_write)
04000000 0.349ms (+0.000ms): __schedule (down_write)
04000001 0.349ms (+0.000ms): sched_clock (__schedule)
04000000 0.350ms (+0.000ms): schedule (down_write)
04000000 0.350ms (+0.000ms): __schedule (down_write)
04000001 0.350ms (+0.000ms): sched_clock (__schedule)
04000000 0.350ms (+0.000ms): schedule (down_write)
04000000 0.350ms (+0.000ms): __schedule (down_write)
04000001 0.351ms (+0.000ms): sched_clock (__schedule)
04000000 0.351ms (+0.000ms): schedule (down_write)
04000000 0.351ms (+0.000ms): __schedule (down_write)
04000001 0.351ms (+0.000ms): sched_clock (__schedule)
04000000 0.352ms (+0.000ms): schedule (down_write)
04000000 0.352ms (+0.000ms): __schedule (down_write)
04010001 0.352ms (+0.000ms): do_IRQ (add_preempt_count)
04010001 0.353ms (+0.000ms): do_IRQ (<00000000>)
00010001 0.353ms (+0.001ms): mask_and_ack_8259A (__do_IRQ)
00010001 0.355ms (+0.000ms): redirect_hardirq (__do_IRQ)
00010000 0.355ms (+0.000ms): handle_IRQ_event (__do_IRQ)
00010000 0.355ms (+0.000ms): timer_interrupt (handle_IRQ_event)
00010001 0.356ms (+0.006ms): mark_offset_tsc (timer_interrupt)
00010001 0.362ms (+0.000ms): do_timer (timer_interrupt)
00010001 0.363ms (+0.000ms): update_wall_time (do_timer)
00010001 0.363ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
00010001 0.363ms (+0.000ms): update_process_times (timer_interrupt)
00010001 0.363ms (+0.000ms): update_one_process (update_process_times)
00010001 0.363ms (+0.000ms): run_local_timers (update_process_times)
00010001 0.363ms (+0.000ms): raise_softirq (update_process_times)
00010001 0.364ms (+0.000ms): scheduler_tick (update_process_times)
00010001 0.364ms (+0.000ms): sched_clock (scheduler_tick)
00010002 0.364ms (+0.000ms): task_timeslice (scheduler_tick)
00010001 0.365ms (+0.000ms): note_interrupt (__do_IRQ)
00010001 0.365ms (+0.000ms): end_8259A_irq (__do_IRQ)
00010001 0.365ms (+0.000ms): enable_8259A_irq (__do_IRQ)
04010001 0.366ms (+0.000ms): irq_exit (do_IRQ)
04000001 0.367ms (+0.000ms): sched_clock (__schedule)
04000000 0.367ms (+0.000ms): schedule (down_write)
04000000 0.367ms (+0.000ms): __schedule (down_write)
04000001 0.367ms (+0.000ms): sched_clock (__schedule)
04000000 0.368ms (+0.000ms): schedule (down_write)
04000000 0.368ms (+0.000ms): __schedule (down_write)
04000001 0.368ms (+0.000ms): sched_clock (__schedule)
04000000 0.368ms (+0.000ms): schedule (down_write)
04000000 0.368ms (+0.000ms): __schedule (down_write)
04000001 0.369ms (+0.000ms): sched_clock (__schedule)
04000000 0.369ms (+0.000ms): schedule (down_write)
04000000 0.369ms (+0.000ms): __schedule (down_write)
04000001 0.369ms (+0.000ms): sched_clock (__schedule)
04000000 0.370ms (+0.000ms): schedule (down_write)
04000000 0.370ms (+0.000ms): __schedule (down_write)
04000001 0.370ms (+0.000ms): sched_clock (__schedule)
04000000 0.370ms (+0.000ms): schedule (down_write)

[more]

04000000 0.797ms (+0.000ms): schedule (down_write)
04000000 0.797ms (+0.000ms): __schedule (down_write)
04000001 0.797ms (+0.000ms): sched_clock (__schedule)
04000000 0.797ms (+0.000ms): schedule (down_write)
04000000 0.798ms (+0.000ms): __schedule (down_write)
04000001 0.798ms (+0.000ms): sched_clock (__schedule)
04000000 0.798ms (+0.000ms): schedule (down_write)
04000000 0.798ms (+0.000ms): __schedule (down_write)
04000001 0.798ms (+0.000ms): sched_clock (__schedule)
04000000 0.799ms (+0.000ms): schedule (down_write)
04000000 0.799ms (+0.000ms): __schedule (down_write)
04000001 0.799ms (+0.000ms): sched_clock (__schedule)
04000000 0.799ms (+0.000ms): schedule (down_write)
04000000 0.799ms (+0.000ms): __schedule (down_write)
04000001 0.800ms (+0.000ms): sched_clock (__schedule)
04000000 0.800ms (+0.000ms): schedule (down_write)
04000000 0.800ms (+0.000ms): __schedule (down_write)
04000001 0.800ms (+877840.005ms): sched_clock (__schedule)



fio
