Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262618AbVDANRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262618AbVDANRb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 08:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbVDANRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 08:17:30 -0500
Received: from general.keba.co.at ([193.154.24.243]:45684 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S262742AbVDANQ6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 08:16:58 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.11, USB: High latency?
Date: Fri, 1 Apr 2005 15:16:51 +0200
Message-ID: <AAD6DA242BC63C488511C611BD51F3673231DB@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.11, USB: High latency?
Thread-Index: AcU15RE6HU4xM1/PSE6m5JNLN+9IYAA13tqA
From: "kus Kusche Klaus" <kus@keba.com>
To: "Ingo Molnar" <mingo@elte.hu>, "kus Kusche Klaus" <kus@keba.com>
Cc: <stern@rowland.harvard.edu>, <linux-usb-users@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Even when the errors described in my previous mail does not occur, 
> > massive USB stick transfers cause latencies of 1 to 2 milliseconds, 
> > which is way too much for realtime control systems.
> 
> do these occur under PREEMPT_RT? If yes, do you get any 
> useful trace if 
> you enable all the tracing options but keep wakeup-timing off:
> 
>  # CONFIG_WAKEUP_TIMING is not set
>  CONFIG_PREEMPT_TRACE=y
>  CONFIG_CRITICAL_PREEMPT_TIMING=y
>  CONFIG_CRITICAL_IRQSOFF_TIMING=y
>  CONFIG_CRITICAL_TIMING=y
>  CONFIG_LATENCY_TIMING=y
>  CONFIG_LATENCY_TRACE=y
>  CONFIG_MCOUNT=y
> 
> this should catch any type of preempt-off section, irqs-off and 
> preempt_disable() alike. (unless the tracer has a bug.)

I tried with the trace settings above, but I didn't have good luck:

1.) Tracing slows things down *a lot* (even *before* turned on):
* My own rtc test program causes 97 % CPU load when tracing is on.
  On an RT kernel with tracing off, it consumes just below 20 %,
  on the standard kernel, it consumes less than 3 %.
* With -f 8192, rtc_wakeup does not even start:
  It blocks the whole system for about 1 minute at 
  "setting up consumer thread".
  After that, it starts running and produces output, but ends with
  "ringbuffer full" almost immediately.
  Surprisingly, when started under the control of "strace", it runs,
  but reports tons of missed interrupts.
  With "-f 1024", it works.

2.) Tracing still doesn't seem to catch everything:
rtc_wakeup sometimes reported a max. jitter of several milliseconds,
but the max trace from /proc/latency_trace showed around 50
microseconds...

3.) However, I got some interesting traces later (see below).
They seem to be related to USB read load.

4.) When running rtc_wakeup at low rtpri (e.g. 2(12)),
I can still generate very bad "missed interrupts" counts
(even on a kernel *without* latency tracing):
core dumps: Up to 10 missed interrupts, almost continuously
USB reads:  Also up to 10 missed interrupts, almost continuously
USB reads, mmap load in parallel: Up to 50, almost continuously
OOM: Up to 500
CF reads: Up to 600
Moreover, rtc_wakeup shows jitter up to 2500 microseconds

Even if there is no special test load running, 
rtc_wakeup now and then misses an interrupt!

All the load is generated at shell priority, not at rt priority!
(so, ideally, it should not influence rt threads *at all*)

5.) I still do not understand the effect of "chrt"-ing "IRQ 8" to 95:
"IRQ 8" is at 49 per default, and there is no process with rtpri>49
(except for rtc_wakeup itself).
Hence, to my understanding, there should not be *any* difference 
between running "IRQ 8" at 49 or 95!
However, when "IRQ 8" is at 95, a dd from the CF card doesn't hurt much.
When "IRQ 8" is at 49, the dd causes jitter of several milliseconds!
(both measured with rtc_wakeup at 89(99)).
Why? "IRQ 14" (IDE) is at 47! There is nothing except rtc_wakeup
which could block or preempt the RTC "IRQ 8"?



preemption latency trace v1.1.4 on 2.6.12-rc1-RT-V0.7.42-08
--------------------------------------------------------------------
 latency: 833 us, #7/7, CPU#0 | (M:rt VP:0, KP:1, SP:1 HP:1 #P:1)
    -----------------
    | task: IRQ 7-724 (uid:0 nice:-5 policy:1 rt_prio:46)
    -----------------

                 _------=> CPU#
                / _-----=> irqs-off
               | / _----=> need-resched
               || / _---=> hardirq/softirq
               ||| / _--=> preempt-depth
               |||| /
               |||||     delay
   cmd     pid ||||| time  |   caller
      \   /    |||||   \   |   /
   IRQ 7-724   0d...    0us : do_hardirq (do_irqd)
   IRQ 7-724   0d..1    0us : note_interrupt (do_hardirq)
   IRQ 7-724   0d..1    1us : end_8259A_irq (do_hardirq)
   IRQ 7-724   0d..1    1us!: enable_8259A_irq (do_hardirq)
   IRQ 7-724   0d...  832us : do_hardirq (do_irqd)
   IRQ 7-724   0d...  833us : trace_irqs_on (do_hardirq)

Some more of those:

preemption latency trace v1.1.4 on 2.6.12-rc1-RT-V0.7.42-08
--------------------------------------------------------------------
 latency: 675 us, #47/47, CPU#0 | (M:rt VP:0, KP:1, SP:1 HP:1 #P:1)
    -----------------
    | task: ksoftirqd/0-2 (uid:0 nice:-10 policy:0 rt_prio:0)
    -----------------

                 _------=> CPU#
                / _-----=> irqs-off
               | / _----=> need-resched
               || / _---=> hardirq/softirq
               ||| / _--=> preempt-depth
               |||| /
               |||||     delay
   cmd     pid ||||| time  |   caller
      \   /    |||||   \   |   /
    mmap-1000  0d...    0us : common_interrupt ((0))
    mmap-1000  0d.h.    0us : do_IRQ (c028e90e 0 0)
    mmap-1000  0d.h1    1us+: mask_and_ack_8259A (__do_IRQ)
    mmap-1000  0d.h1    5us : redirect_hardirq (__do_IRQ)
    mmap-1000  0d.h.    5us : handle_IRQ_event (__do_IRQ)
    mmap-1000  0d.h.    6us : timer_interrupt (handle_IRQ_event)
    mmap-1000  0d.h1    6us+: mark_offset_tsc (timer_interrupt)
    mmap-1000  0d.h1   14us : do_timer (timer_interrupt)
    mmap-1000  0d.h1   14us : update_process_times (timer_interrupt)
    mmap-1000  0d.h1   15us : account_system_time (update_process_times)
    mmap-1000  0d.h1   15us : update_mem_hiwater (update_process_times)
    mmap-1000  0d.h1   16us : run_local_timers (update_process_times)
    mmap-1000  0d.h1   17us : raise_softirq (update_process_times)
    mmap-1000  0d.h1   18us : scheduler_tick (timer_interrupt)
    mmap-1000  0d.h1   18us : sched_clock (scheduler_tick)
    mmap-1000  0d.h1   20us : profile_hit (timer_interrupt)
    mmap-1000  0d.h1   20us : note_interrupt (__do_IRQ)
    mmap-1000  0d.h1   21us : end_8259A_irq (__do_IRQ)
    mmap-1000  0d.h1   22us!: enable_8259A_irq (__do_IRQ)
    mmap-1000  0d.h.  662us : irq_exit (do_IRQ)
    mmap-1000  0d..1  662us : do_softirq (irq_exit)
    mmap-1000  0d..1  663us : __do_softirq (do_softirq)
    mmap-1000  0d..1  663us : wake_up_process (do_softirq)
    mmap-1000  0d..1  664us : try_to_wake_up (wake_up_process)
    mmap-1000  0d..2  664us : activate_task (try_to_wake_up)
    mmap-1000  0d..2  664us : sched_clock (activate_task)
    mmap-1000  0d..2  665us : recalc_task_prio (activate_task)
    mmap-1000  0d..2  665us : effective_prio (recalc_task_prio)
    mmap-1000  0d..2  665us : activate_task <<...>-2> (69 1):
    mmap-1000  0d..2  666us : enqueue_task (activate_task)
    mmap-1000  0dn.2  666us : try_to_wake_up <<...>-2> (69 76):
    mmap-1000  0dn.1  667us : preempt_schedule (try_to_wake_up)
    mmap-1000  0dn.1  667us : wake_up_process (do_softirq)
    mmap-1000  0dn..  668us : preempt_schedule_irq (need_resched)
    mmap-1000  0dn..  668us : __schedule (preempt_schedule_irq)
    mmap-1000  0dn..  668us : profile_hit (__schedule)
    mmap-1000  0dn.1  669us : sched_clock (__schedule)
    mmap-1000  0dn.2  670us : dequeue_task (__schedule)
    mmap-1000  0dn.2  671us : recalc_task_prio (__schedule)
    mmap-1000  0dn.2  671us : effective_prio (recalc_task_prio)
    mmap-1000  0dn.2  671us : enqueue_task (__schedule)
   <...>-2     0d..2  672us : __switch_to (__schedule)
   <...>-2     0d..2  673us : __schedule <mmap-1000> (76 69):
   <...>-2     0d...  674us : schedule (ksoftirqd)
   <...>-2     0d...  674us : trace_irqs_on (schedule)

preemption latency trace v1.1.4 on 2.6.12-rc1-RT-V0.7.42-08
--------------------------------------------------------------------
 latency: 951 us, #27/27, CPU#0 | (M:rt VP:0, KP:1, SP:1 HP:1 #P:1)
    -----------------
    | task: IRQ 7-724 (uid:0 nice:-5 policy:1 rt_prio:46)
    -----------------

                 _------=> CPU#
                / _-----=> irqs-off
               | / _----=> need-resched
               || / _---=> hardirq/softirq
               ||| / _--=> preempt-depth
               |||| /
               |||||     delay
   cmd     pid ||||| time  |   caller
      \   /    |||||   \   |   /
    mmap-1000  0d...    0us : common_interrupt ((0))
    mmap-1000  0d.h.    0us : do_IRQ (c012d6d5 7 0)
    mmap-1000  0d.h1    2us!: mask_and_ack_8259A (__do_IRQ)
    mmap-1000  0d.h1  938us : redirect_hardirq (__do_IRQ)
    mmap-1000  0d.h1  939us : wake_up_process (redirect_hardirq)
    mmap-1000  0d.h1  939us : try_to_wake_up (wake_up_process)
    mmap-1000  0d.h2  940us : activate_task (try_to_wake_up)
    mmap-1000  0d.h2  940us : sched_clock (activate_task)
    mmap-1000  0d.h2  941us : recalc_task_prio (activate_task)
    mmap-1000  0d.h2  941us : effective_prio (recalc_task_prio)
    mmap-1000  0d.h2  942us : activate_task <<...>-724> (35 1):
    mmap-1000  0d.h2  942us : enqueue_task (activate_task)
    mmap-1000  0dnh2  943us : try_to_wake_up <<...>-724> (35 7d):
    mmap-1000  0dnh1  943us : preempt_schedule (try_to_wake_up)
    mmap-1000  0dnh1  944us : wake_up_process (redirect_hardirq)
    mmap-1000  0dnh.  944us : preempt_schedule (__do_IRQ)
    mmap-1000  0dnh.  945us : irq_exit (do_IRQ)
    mmap-1000  0dn..  945us : preempt_schedule_irq (need_resched)
    mmap-1000  0dn..  945us : __schedule (preempt_schedule_irq)
    mmap-1000  0dn..  946us : profile_hit (__schedule)
    mmap-1000  0dn.1  946us : sched_clock (__schedule)
   <...>-724   0d..2  948us : __switch_to (__schedule)
   <...>-724   0d..2  949us : __schedule <mmap-1000> (7d 35):
   <...>-724   0d...  950us : schedule (do_irqd)
   <...>-724   0d...  950us : trace_irqs_on (schedule)

preemption latency trace v1.1.4 on 2.6.12-rc1-RT-V0.7.42-08
--------------------------------------------------------------------
 latency: 985 us, #76/76, CPU#0 | (M:rt VP:0, KP:1, SP:1 HP:1 #P:1)
    -----------------
    | task: ksoftirqd/0-2 (uid:0 nice:-10 policy:0 rt_prio:0)
    -----------------

                 _------=> CPU#
                / _-----=> irqs-off
               | / _----=> need-resched
               || / _---=> hardirq/softirq
               ||| / _--=> preempt-depth
               |||| /
               |||||     delay
   cmd     pid ||||| time  |   caller
      \   /    |||||   \   |   /
ksoftirq-2     0...1    0us : ksoftirqd (kthread)
ksoftirq-2     0d.h1    1us : do_IRQ (c01306da 7 0)
ksoftirq-2     0d.h2    2us!: mask_and_ack_8259A (__do_IRQ)
ksoftirq-2     0d.h2  944us : redirect_hardirq (__do_IRQ)
ksoftirq-2     0d.h2  944us : wake_up_process (redirect_hardirq)
ksoftirq-2     0d.h2  944us : try_to_wake_up (wake_up_process)
ksoftirq-2     0d.h3  945us : activate_task (try_to_wake_up)
ksoftirq-2     0d.h3  945us : sched_clock (activate_task)
ksoftirq-2     0d.h3  946us : recalc_task_prio (activate_task)
ksoftirq-2     0d.h3  946us : effective_prio (recalc_task_prio)
ksoftirq-2     0d.h3  947us : activate_task <<...>-724> (35 3):
ksoftirq-2     0d.h3  947us : enqueue_task (activate_task)
ksoftirq-2     0dnh3  948us : try_to_wake_up <<...>-724> (35 6a):
ksoftirq-2     0dnh2  948us : preempt_schedule (try_to_wake_up)
ksoftirq-2     0dnh2  948us : wake_up_process (redirect_hardirq)
ksoftirq-2     0dnh1  949us : preempt_schedule (__do_IRQ)
ksoftirq-2     0dnh1  949us : irq_exit (do_IRQ)
ksoftirq-2     0dn.1  950us < (608)
ksoftirq-2     0dnh1  951us : do_IRQ (c01306da 0 0)
ksoftirq-2     0dnh2  952us : mask_and_ack_8259A (__do_IRQ)
ksoftirq-2     0dnh2  953us : preempt_schedule (__do_IRQ)
ksoftirq-2     0dnh2  954us : redirect_hardirq (__do_IRQ)
ksoftirq-2     0dnh1  954us : preempt_schedule (__do_IRQ)
ksoftirq-2     0dnh1  955us : handle_IRQ_event (__do_IRQ)
ksoftirq-2     0dnh1  955us : timer_interrupt (handle_IRQ_event)
ksoftirq-2     0dnh2  956us+: mark_offset_tsc (timer_interrupt)
ksoftirq-2     0dnh3  959us : preempt_schedule (mark_offset_tsc)
ksoftirq-2     0dnh2  960us : preempt_schedule (mark_offset_tsc)
ksoftirq-2     0dnh2  960us : preempt_schedule (mark_offset_tsc)
ksoftirq-2     0dnh2  961us : do_timer (timer_interrupt)
ksoftirq-2     0dnh2  961us : update_process_times (timer_interrupt)
ksoftirq-2     0dnh2  961us : account_system_time (update_process_times)
ksoftirq-2     0dnh2  962us : update_mem_hiwater (update_process_times)
ksoftirq-2     0dnh2  962us : run_local_timers (update_process_times)
ksoftirq-2     0dnh2  962us : raise_softirq (update_process_times)
ksoftirq-2     0dnh2  963us : scheduler_tick (timer_interrupt)
ksoftirq-2     0dnh2  964us : sched_clock (scheduler_tick)
ksoftirq-2     0dnh2  965us : preempt_schedule (scheduler_tick)
ksoftirq-2     0dnh2  966us : profile_hit (timer_interrupt)
ksoftirq-2     0dnh1  966us : preempt_schedule (timer_interrupt)
ksoftirq-2     0dnh2  967us : note_interrupt (__do_IRQ)
ksoftirq-2     0dnh2  967us : end_8259A_irq (__do_IRQ)
ksoftirq-2     0dnh2  968us : enable_8259A_irq (__do_IRQ)
ksoftirq-2     0dnh2  969us : preempt_schedule (__do_IRQ)
ksoftirq-2     0dnh1  969us : preempt_schedule (__do_IRQ)
ksoftirq-2     0dnh1  970us : irq_exit (do_IRQ)
ksoftirq-2     0dn.2  970us : do_softirq (irq_exit)
ksoftirq-2     0dn.2  970us : __do_softirq (do_softirq)
ksoftirq-2     0dn.2  971us : wake_up_process (do_softirq)
ksoftirq-2     0dn.2  971us : try_to_wake_up (wake_up_process)
ksoftirq-2     0dn.2  972us : preempt_schedule (try_to_wake_up)
ksoftirq-2     0dn.2  972us : wake_up_process (do_softirq)
ksoftirq-2     0dn.1  973us < (608)
ksoftirq-2     0dnh1  974us : do_IRQ (c01306da 8 0)
ksoftirq-2     0dnh2  975us+: mask_and_ack_8259A (__do_IRQ)
ksoftirq-2     0dnh2  978us : preempt_schedule (__do_IRQ)
ksoftirq-2     0dnh2  978us : redirect_hardirq (__do_IRQ)
ksoftirq-2     0dnh2  979us : wake_up_process (redirect_hardirq)
ksoftirq-2     0dnh2  979us : try_to_wake_up (wake_up_process)
ksoftirq-2     0dnh3  979us : activate_task (try_to_wake_up)
ksoftirq-2     0dnh3  979us : sched_clock (activate_task)
ksoftirq-2     0dnh3  980us : recalc_task_prio (activate_task)
ksoftirq-2     0dnh3  980us : effective_prio (recalc_task_prio)
ksoftirq-2     0dnh3  981us : activate_task <<...>-664> (4 4):
ksoftirq-2     0dnh3  981us : enqueue_task (activate_task)
ksoftirq-2     0dnh3  981us : try_to_wake_up <<...>-664> (4 6a):
ksoftirq-2     0dnh2  982us : preempt_schedule (try_to_wake_up)
ksoftirq-2     0dnh2  982us : wake_up_process (redirect_hardirq)
ksoftirq-2     0dnh1  982us : preempt_schedule (__do_IRQ)
ksoftirq-2     0dnh1  983us : irq_exit (do_IRQ)
ksoftirq-2     0dn.2  983us : do_softirq (irq_exit)
ksoftirq-2     0dn.2  983us : __do_softirq (do_softirq)
ksoftirq-2     0dn.1  984us < (608)
ksoftirq-2     0.n.1  984us : ksoftirqd (kthread)
ksoftirq-2     0.n.1  985us : sub_preempt_count (ksoftirqd)


-- 
Klaus Kusche                 (Software Development - Control Systems)
KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-8919
E-Mail: kus@keba.com                                WWW: www.keba.com
