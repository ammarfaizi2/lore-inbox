Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262162AbVGFT6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbVGFT6I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 15:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262203AbVGFT5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:57:07 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:44713 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S262194AbVGFPzr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 11:55:47 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Date: Wed, 6 Jul 2005 16:55:45 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <20050706133124.GA19467@elte.hu>
In-Reply-To: <20050706133124.GA19467@elte.hu>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_B8/yCRps9yw9e4t"
Message-Id: <200507061655.45801.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_B8/yCRps9yw9e4t
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 06 Jul 2005 14:31, Ingo Molnar wrote:
[snip]
>
> for the first bootup it makes sense to enable most of them - just to
> make sure everything is ok. They have performance overhead, but it
> shouldnt show up during everyday use. (it will show up in benchmarks
> though) Here's the options i have enabled, typically:

Okay, I enabled everything.

[snip]
> > [...] Also, I got a few unexpected messages in dmesg on bootup.
> > Firstly;
> >
> > spawn_desched_task(00000000)
> > desched cpu_callback 3/00000000
> > ksoftirqd started up.
> > softirq RT prio: 24.
> > ksoftirqd started up.
> > softirq RT prio: 24.
> > [...]
> > desched cpu_callback 2/00000000
> > desched thread 0 started up.
> > softlockup thread 0 started up.
> >
> > Why does it print out the same ksoftirqd message six times? Is this
> > expected behaviour?
>
> these messages are harmless status messages - they were added for
> debugging purposes. You are getting 6 of them because there are 6
> separate softirq threads. (but the message is the old one so it talks
> about ksoftirqd - very confusing.) In my tree i have removed these
> printks.

That's good. I'm deliberately critical because I thought there might be a 
problem on my machine somewhere. Normally I wouldn't think twice about 
ksoftirqd's messages.

>
> (generally i try to mark every message in the -RT kernel that signals
> some sort of anomaly with a 'BUG:' prefix - that makes it easy to do a
> 'dmesg | grep BUG:' to find out whether anything bad is going on. All
> other messages should be benign.)

Okay, I've got multiple other BUG: messages within 2-3 minutes of booting that 
highlight problems in areas other than ACPI. Are they useful to you?

>
> > [...] Next, I got a warning about CONFIG_CRITICAL_IRQSOFF_TIMING;
> > should this option be enabled?
>
> do you mean the bootup warning about performance? That is just a warning
> to make sure the kernel is not misconfigured during benchmarks - the
> debugging options are otherwise safe and you should be able to use any
> variations of them.

Great.

>
> > Finally, I got this:
> >
> > BUG: soft lockup detected on CPU#0!
> >  [<c013d7e9>] softlockup_tick+0x89/0xb0 (8)
> >  [<c0108590>] timer_interrupt+0x50/0xf0 (20)
> >  [<c013da91>] handle_IRQ_event+0x81/0x100 (16)
> >  [<c013dbfc>] __do_IRQ+0xec/0x190 (48)
> >  [<c0105a28>] do_IRQ+0x48/0x70 (40)
> >  =======================
> >  [<c024df3b>] acpi_processor_idle+0x0/0x258 (8)
> >  [<c0103d03>] common_interrupt+0x1f/0x24 (12)
> >  [<c024df3b>] acpi_processor_idle+0x0/0x258 (4)
> >  [<c024e05e>] acpi_processor_idle+0x123/0x258 (40)
> >  [<c024df3b>] acpi_processor_idle+0x0/0x258 (32)
> >  [<c0101116>] cpu_idle+0x56/0x80 (16)
> >  [<c03a486c>] start_kernel+0x17c/0x1c0 (12)
> >  [<c03a43b0>] unknown_bootoption+0x0/0x1f0 (20)
>
> yes, this is a problem. You can probably work it around by disabling
> ACPI, but it would be better to debug and fix it. The message was
> generated because the kernel spent too much time [more than 10 seconds]
> in acpi_processor_idle(), and the softlockup-thread (which runs at
> SCHED_FIFO prio 99) was not scheduled for that amount of time. [or it
> thought it was not scheduled.] Was there any suspend/resume activity
> while you got that message?

No, this is during bootup that it occurs. Suspend and resume do work and are 
compiled in on my laptop, but were never utilised.

[snip]
> > ( softirq-timer/0-3    |#0): new 3 us maximum-latency wakeup.
> > ( softirq-timer/0-3    |#0): new 1003 us maximum-latency wakeup.
> > ( softirq-timer/0-3    |#0): new 1001 us maximum-latency wakeup.
> >
> > Which is presumably a good sign.
>
> it's good in terms of stability, but the 1003 usecs maximum wakeup
> latency is bad - you should be getting much lower latencies. Could you
> enable LATENCY_TRACING and send me the /proc/latency_trace file? [if
> it's long then in bz2 format.] You can double-check that it's the right
> one: the trace is human-readable and should go roughly from 1 usec to
> 1003 usecs. Looking at that trace i can probably tell more about how
> this latency happened.

I've got a pair of nearly identical traces that highlight a 2645us latency in 
smp_apic_timer_interrupt. I don't know how the trace is formatted, so I can't 
tell if it occurred before or after this function call. I also can't see how 
a ~1000us latency translates to a ~2600us latency in the trace.

Since both traces were under 6K each, and I think the list limit is higher, I 
risked it and have attached both.

Annoyingly, my original messages (sent SEVERAL hours ago) seem not to have 
gotten through to the list. Whatever braindead filter is nuking them, it 
needs to be fixed.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.

--Boundary-00=_B8/yCRps9yw9e4t
Content-Type: text/plain;
  charset="iso-8859-1";
  name="trace"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="trace"

preemption latency trace v1.1.4 on 2.6.12-RT-V0.7.51-02
--------------------------------------------------------------------
 latency: 2693 us, #77/77, CPU#0 | (M:rt VP:0, KP:1, SP:1 HP:1 #P:1)
    -----------------
    | task: softirq-timer/0-3 (uid:0 nice:-10 policy:0 rt_prio:0)
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
  <idle>-0     0dnh3    0us!: <70617773> (<00726570>)
  <idle>-0     0dnh3    0us : __trace_start_sched_wakeup (try_to_wake_up)
  <idle>-0     0dnh3    0us : __trace_start_sched_wakeup <softirq--3> (69 0)
  <idle>-0     0dnh2    1us : try_to_wake_up <softirq--3> (69 8c)
  <idle>-0     0dnh1    1us : preempt_schedule (try_to_wake_up)
  <idle>-0     0dnh1    2us : wake_up_process (trigger_softirqs)
  <idle>-0     0dnh1    2us : local_irq_restore (do_softirq)
  <idle>-0     0dnh.    3us < (608)
  <idle>-0     0dn..    3us : acpi_hw_register_write (acpi_set_register)
  <idle>-0     0dn..    4us : acpi_hw_low_level_write (acpi_hw_register_write)
  <idle>-0     0dn..    4us+: acpi_os_write_port (acpi_hw_low_level_write)
  <idle>-0     0dn..    7us!: acpi_hw_low_level_write (acpi_hw_register_write)
  <idle>-0     0dnh. 2645us : smp_apic_timer_interrupt (c0252485 0 0)
  <idle>-0     0dnh. 2646us : irq_exit (apic_timer_interrupt)
  <idle>-0     0dnh1 2646us : do_softirq (irq_exit)
  <idle>-0     0dnh1 2646us : __local_irq_save (do_softirq)
  <idle>-0     0dnh1 2647us : __do_softirq (do_softirq)
  <idle>-0     0dnh1 2647us : trigger_softirqs (do_softirq)
  <idle>-0     0dnh1 2647us : wakeup_softirqd (trigger_softirqs)
  <idle>-0     0dnh1 2648us : local_irq_restore (do_softirq)
  <idle>-0     0dnh. 2648us+< (608)
  <idle>-0     0dnh. 2652us : do_IRQ (c0252485 0 0)
  <idle>-0     0dnh. 2652us : __local_irq_save (__do_IRQ)
  <idle>-0     0dnh1 2653us+: mask_and_ack_8259A (__do_IRQ)
  <idle>-0     0dnh1 2659us : preempt_schedule (__do_IRQ)
  <idle>-0     0dnh1 2660us : redirect_hardirq (__do_IRQ)
  <idle>-0     0dnh. 2660us : preempt_schedule (__do_IRQ)
  <idle>-0     0dnh. 2660us : handle_IRQ_event (__do_IRQ)
  <idle>-0     0dnh. 2661us : timer_interrupt (handle_IRQ_event)
  <idle>-0     0dnh1 2661us : mark_offset_tsc (timer_interrupt)
  <idle>-0     0dnh1 2662us : preempt_schedule (mark_offset_tsc)
  <idle>-0     0dnh1 2662us : preempt_schedule (mark_offset_tsc)
  <idle>-0     0dnh1 2663us : do_timer (timer_interrupt)
  <idle>-0     0dnh1 2663us : update_process_times (timer_interrupt)
  <idle>-0     0dnh1 2663us : account_system_time (update_process_times)
  <idle>-0     0dnh1 2664us : update_mem_hiwater (update_process_times)
  <idle>-0     0dnh1 2664us : run_local_timers (update_process_times)
  <idle>-0     0dnh1 2664us : raise_softirq (update_process_times)
  <idle>-0     0dnh1 2665us : scheduler_tick (update_process_times)
  <idle>-0     0dnh1 2665us : sched_clock (scheduler_tick)
  <idle>-0     0dnh1 2666us : softlockup_tick (timer_interrupt)
  <idle>-0     0dnh. 2666us : preempt_schedule (timer_interrupt)
  <idle>-0     0dnh1 2666us : note_interrupt (__do_IRQ)
  <idle>-0     0dnh1 2667us : end_8259A_irq (__do_IRQ)
  <idle>-0     0dnh1 2667us+: enable_8259A_irq (__do_IRQ)
  <idle>-0     0dnh1 2670us : preempt_schedule (__do_IRQ)
  <idle>-0     0dnh. 2670us : preempt_schedule (__do_IRQ)
  <idle>-0     0dnh. 2671us : local_irq_restore (__do_IRQ)
  <idle>-0     0dnh. 2671us : irq_exit (do_IRQ)
  <idle>-0     0dnh1 2671us : do_softirq (irq_exit)
  <idle>-0     0dnh1 2672us : __local_irq_save (do_softirq)
  <idle>-0     0dnh1 2672us : __do_softirq (do_softirq)
  <idle>-0     0dnh1 2672us : trigger_softirqs (do_softirq)
  <idle>-0     0dnh1 2672us : wakeup_softirqd (trigger_softirqs)
  <idle>-0     0dnh1 2673us : local_irq_restore (do_softirq)
  <idle>-0     0dnh. 2673us+< (608)
  <idle>-0     0dn.. 2679us : local_irq_enable (acpi_processor_idle)
  <idle>-0     0Dn.. 2679us : preempt_schedule (acpi_processor_idle)
  <idle>-0     0Dn.. 2679us : irqs_disabled (preempt_schedule)
  <idle>-0     0Dnh. 2680us : __schedule (preempt_schedule)
  <idle>-0     0Dnh. 2680us : profile_hit (__schedule)
  <idle>-0     0Dnh1 2681us : sched_clock (__schedule)
  <idle>-0     0Dnh2 2681us : dequeue_task (__schedule)
  <idle>-0     0Dnh2 2682us : recalc_task_prio (__schedule)
  <idle>-0     0Dnh2 2682us : effective_prio (recalc_task_prio)
  <idle>-0     0Dnh2 2683us : enqueue_task (__schedule)
  <idle>-0     0Dnh2 2683us+: trace_array (__schedule)
  <idle>-0     0Dnh2 2685us : trace_array <softirq--3> (69 6e)
  <idle>-0     0Dnh2 2686us+: trace_array (__schedule)
softirq--3     0Dnh2 2690us : __switch_to (__schedule)
softirq--3     0Dnh2 2691us : __schedule <<idle>-0> (8c 69)
softirq--3     0Dnh2 2691us : finish_task_switch (__schedule)
softirq--3     0Dnh1 2691us : trace_stop_sched_switched (finish_task_switch)
softirq--3     0Dnh2 2692us : trace_stop_sched_switched <softirq--3> (69 0)
softirq--3     0Dnh2 2693us : trace_stop_sched_switched (finish_task_switch)


vim:ft=help

--Boundary-00=_B8/yCRps9yw9e4t
Content-Type: text/plain;
  charset="iso-8859-1";
  name="trace2"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="trace2"

preemption latency trace v1.1.4 on 2.6.12-RT-V0.7.51-02
--------------------------------------------------------------------
 latency: 2692 us, #78/78, CPU#0 | (M:rt VP:0, KP:1, SP:1 HP:1 #P:1)
    -----------------
    | task: softirq-timer/0-3 (uid:0 nice:-10 policy:0 rt_prio:0)
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
  <idle>-0     0dnh3    0us!: <70617773> (<00726570>)
  <idle>-0     0dnh3    0us : __trace_start_sched_wakeup (try_to_wake_up)
  <idle>-0     0dnh3    0us : __trace_start_sched_wakeup <softirq--3> (69 0)
  <idle>-0     0dnh2    1us : try_to_wake_up <softirq--3> (69 8c)
  <idle>-0     0dnh1    1us : preempt_schedule (try_to_wake_up)
  <idle>-0     0dnh1    1us : wake_up_process (trigger_softirqs)
  <idle>-0     0dnh1    2us : local_irq_restore (do_softirq)
  <idle>-0     0dnh.    2us < (608)
  <idle>-0     0dn..    3us : acpi_hw_low_level_read (acpi_hw_register_read)
  <idle>-0     0dn..    4us : acpi_hw_register_write (acpi_set_register)
  <idle>-0     0dn..    4us : acpi_hw_low_level_write (acpi_hw_register_write)
  <idle>-0     0dn..    4us+: acpi_os_write_port (acpi_hw_low_level_write)
  <idle>-0     0dn..    7us!: acpi_hw_low_level_write (acpi_hw_register_write)
  <idle>-0     0dnh. 2645us : smp_apic_timer_interrupt (c0252485 0 0)
  <idle>-0     0dnh. 2646us : irq_exit (apic_timer_interrupt)
  <idle>-0     0dnh1 2646us : do_softirq (irq_exit)
  <idle>-0     0dnh1 2647us : __local_irq_save (do_softirq)
  <idle>-0     0dnh1 2647us : __do_softirq (do_softirq)
  <idle>-0     0dnh1 2647us : trigger_softirqs (do_softirq)
  <idle>-0     0dnh1 2648us : wakeup_softirqd (trigger_softirqs)
  <idle>-0     0dnh1 2648us : local_irq_restore (do_softirq)
  <idle>-0     0dnh. 2648us+< (608)
  <idle>-0     0dnh. 2652us : do_IRQ (c0252485 0 0)
  <idle>-0     0dnh. 2652us : __local_irq_save (__do_IRQ)
  <idle>-0     0dnh1 2653us+: mask_and_ack_8259A (__do_IRQ)
  <idle>-0     0dnh1 2659us : preempt_schedule (__do_IRQ)
  <idle>-0     0dnh1 2660us : redirect_hardirq (__do_IRQ)
  <idle>-0     0dnh. 2660us : preempt_schedule (__do_IRQ)
  <idle>-0     0dnh. 2661us : handle_IRQ_event (__do_IRQ)
  <idle>-0     0dnh. 2661us : timer_interrupt (handle_IRQ_event)
  <idle>-0     0dnh1 2661us : mark_offset_tsc (timer_interrupt)
  <idle>-0     0dnh1 2662us : preempt_schedule (mark_offset_tsc)
  <idle>-0     0dnh1 2662us : preempt_schedule (mark_offset_tsc)
  <idle>-0     0dnh1 2663us : do_timer (timer_interrupt)
  <idle>-0     0dnh1 2663us : update_process_times (timer_interrupt)
  <idle>-0     0dnh1 2663us : account_system_time (update_process_times)
  <idle>-0     0dnh1 2664us : update_mem_hiwater (update_process_times)
  <idle>-0     0dnh1 2664us : run_local_timers (update_process_times)
  <idle>-0     0dnh1 2664us : raise_softirq (update_process_times)
  <idle>-0     0dnh1 2665us : scheduler_tick (update_process_times)
  <idle>-0     0dnh1 2665us : sched_clock (scheduler_tick)
  <idle>-0     0dnh1 2666us : softlockup_tick (timer_interrupt)
  <idle>-0     0dnh. 2666us : preempt_schedule (timer_interrupt)
  <idle>-0     0dnh1 2666us : note_interrupt (__do_IRQ)
  <idle>-0     0dnh1 2667us : end_8259A_irq (__do_IRQ)
  <idle>-0     0dnh1 2667us+: enable_8259A_irq (__do_IRQ)
  <idle>-0     0dnh1 2670us : preempt_schedule (__do_IRQ)
  <idle>-0     0dnh. 2670us : preempt_schedule (__do_IRQ)
  <idle>-0     0dnh. 2671us : local_irq_restore (__do_IRQ)
  <idle>-0     0dnh. 2671us : irq_exit (do_IRQ)
  <idle>-0     0dnh1 2671us : do_softirq (irq_exit)
  <idle>-0     0dnh1 2672us : __local_irq_save (do_softirq)
  <idle>-0     0dnh1 2672us : __do_softirq (do_softirq)
  <idle>-0     0dnh1 2672us : trigger_softirqs (do_softirq)
  <idle>-0     0dnh1 2673us : wakeup_softirqd (trigger_softirqs)
  <idle>-0     0dnh1 2673us : local_irq_restore (do_softirq)
  <idle>-0     0dnh. 2673us+< (608)
  <idle>-0     0dn.. 2678us : local_irq_enable (acpi_processor_idle)
  <idle>-0     0Dn.. 2679us : preempt_schedule (acpi_processor_idle)
  <idle>-0     0Dn.. 2679us : irqs_disabled (preempt_schedule)
  <idle>-0     0Dnh. 2679us : __schedule (preempt_schedule)
  <idle>-0     0Dnh. 2680us : profile_hit (__schedule)
  <idle>-0     0Dnh1 2680us : sched_clock (__schedule)
  <idle>-0     0Dnh2 2681us : dequeue_task (__schedule)
  <idle>-0     0Dnh2 2681us : recalc_task_prio (__schedule)
  <idle>-0     0Dnh2 2681us : effective_prio (recalc_task_prio)
  <idle>-0     0Dnh2 2682us : enqueue_task (__schedule)
  <idle>-0     0Dnh2 2682us+: trace_array (__schedule)
  <idle>-0     0Dnh2 2684us : trace_array <softirq--3> (69 6e)
  <idle>-0     0Dnh2 2685us+: trace_array (__schedule)
softirq--3     0Dnh2 2689us : __switch_to (__schedule)
softirq--3     0Dnh2 2689us : __schedule <<idle>-0> (8c 69)
softirq--3     0Dnh2 2690us : finish_task_switch (__schedule)
softirq--3     0Dnh1 2690us : trace_stop_sched_switched (finish_task_switch)
softirq--3     0Dnh2 2691us : trace_stop_sched_switched <softirq--3> (69 0)
softirq--3     0Dnh2 2691us : trace_stop_sched_switched (finish_task_switch)


vim:ft=help

--Boundary-00=_B8/yCRps9yw9e4t--
