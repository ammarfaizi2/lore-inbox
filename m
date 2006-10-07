Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbWJGMEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbWJGMEB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 08:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbWJGMEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 08:04:01 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:19681 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750980AbWJGMEA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 08:04:00 -0400
From: Dominique Dumont <domi.dumont@free.fr>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-user <alsa-user@lists.sourceforge.net>,
       Francesco Peeters <Francesco@FamPeeters.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Alsa-user] Pb with simultaneous SATA and ALSA I/O
References: <877izsp3dm.fsf@gandalf.hd.free.fr>
	<13158.212.123.217.246.1159186633.squirrel@www.fampeeters.com>
	<87y7rusddc.fsf@gandalf.hd.free.fr>
	<1160081110.2481.104.camel@mindpipe>
	<87r6xmscif.fsf@gandalf.hd.free.fr>
	<1160083137.2481.108.camel@mindpipe>
Date: Sat, 07 Oct 2006 14:03:57 +0200
Message-ID: <878xjs1geq.fsf@gandalf.hd.free.fr>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: domi.dumont@free.fr
X-SA-Exim-Scanned: No (on gandalf.hd.free.fr); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> writes:

> Did you ever try the latency tracer?  (See LKML archives for
> instructions)

Yes I did (this time better than 2 or 3 days ago :-/ ).

- I compiled and booted 2.6.28-rt5 with latency tracer enabled
- I verified that I got latency trace enabled (seen trace in kern.log)

I only got some traces after running this (detail added for the sake
of other newbies like me) :

   gandalf:/proc/sys/kernel# echo 0 > preempt_max_latency

Here's the max latency trace I got (note that I got a similar trace
*before* running the test, so I'd say it's unrelated to the AC3
drop-out problem.):

preemption latency trace v1.1.5 on 2.6.18-rt5
--------------------------------------------------------------------
 latency: 19 us, #58/58, CPU#0 | (M:rt VP:0, KP:0, SP:1 HP:1)
    -----------------
    | task: posix_cpu_timer-2 (uid:0 nice:0 policy:1 rt_prio:99)
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
  <idle>-0     0Dnh2    0us : __trace_start_sched_wakeup (try_to_wake_up)
  <idle>-0     0Dnh2    0us : __trace_start_sched_wakeup <<...>-2> (0 0)
  <idle>-0     0Dnh2    0us : try_to_wake_up <<...>-2> (199 20)
  <idle>-0     0Dnh1    0us : preempt_schedule (try_to_wake_up)
  <idle>-0     0Dnh1    0us : wake_up_process (run_posix_cpu_timers)
  <idle>-0     0Dnh1    0us : note_interrupt (handle_level_irq)
  <idle>-0     0Dnh2    0us : enable_8259A_irq (handle_level_irq)
  <idle>-0     0Dnh2    1us : preempt_schedule (enable_8259A_irq)
  <idle>-0     0Dnh1    1us : preempt_schedule (handle_level_irq)
  <idle>-0     0Dnh1    2us : irq_exit (do_IRQ)
  <idle>-0     0Dnh1    3us : do_IRQ (b0101ade b 0)
  <idle>-0     0Dnh1    3us : handle_level_irq (do_IRQ)
  <idle>-0     0Dnh2    3us+: mask_and_ack_8259A (handle_level_irq)
  <idle>-0     0Dnh2    8us : preempt_schedule (mask_and_ack_8259A)
  <idle>-0     0Dnh2    8us : redirect_hardirq (handle_level_irq)
  <idle>-0     0Dnh2    9us : wake_up_process (redirect_hardirq)
  <idle>-0     0Dnh2    9us : try_to_wake_up (wake_up_process)
  <idle>-0     0Dnh2    9us : task_rq_lock (try_to_wake_up)
  <idle>-0     0Dnh3    9us : activate_task (try_to_wake_up)
  <idle>-0     0Dnh3    9us : sched_clock (activate_task)
  <idle>-0     0Dnh3    9us : __activate_task (activate_task)
  <idle>-0     0Dnh3    9us : __activate_task <<...>-2006> (59 1)
  <idle>-0     0Dnh3    9us : enqueue_task (__activate_task)
  <idle>-0     0Dnh3    9us : __trace_start_sched_wakeup (try_to_wake_up)
  <idle>-0     0Dnh3    9us : try_to_wake_up <<...>-2006> (140 20)
  <idle>-0     0Dnh2    9us : preempt_schedule (try_to_wake_up)
  <idle>-0     0Dnh2    9us : wake_up_process (redirect_hardirq)
  <idle>-0     0Dnh1   10us : preempt_schedule (handle_level_irq)
  <idle>-0     0Dnh1   10us : irq_exit (do_IRQ)
  <idle>-0     0Dnh1   11us : do_IRQ (b0101ade e 0)
  <idle>-0     0Dnh1   11us : handle_level_irq (do_IRQ)
  <idle>-0     0Dnh2   11us+: mask_and_ack_8259A (handle_level_irq)
  <idle>-0     0Dnh2   16us : preempt_schedule (mask_and_ack_8259A)
  <idle>-0     0Dnh2   16us : redirect_hardirq (handle_level_irq)
  <idle>-0     0Dnh2   16us : wake_up_process (redirect_hardirq)
  <idle>-0     0Dnh2   16us : try_to_wake_up (wake_up_process)
  <idle>-0     0Dnh2   16us : task_rq_lock (try_to_wake_up)
  <idle>-0     0Dnh3   17us : activate_task (try_to_wake_up)
  <idle>-0     0Dnh3   17us : sched_clock (activate_task)
  <idle>-0     0Dnh3   17us : __activate_task (activate_task)
  <idle>-0     0Dnh3   17us : __activate_task <<...>-861> (53 2)
  <idle>-0     0Dnh3   17us : enqueue_task (__activate_task)
  <idle>-0     0Dnh3   17us : __trace_start_sched_wakeup (try_to_wake_up)
  <idle>-0     0Dnh3   17us : try_to_wake_up <<...>-861> (146 20)
  <idle>-0     0Dnh2   17us : preempt_schedule (try_to_wake_up)
  <idle>-0     0Dnh2   17us : wake_up_process (redirect_hardirq)
  <idle>-0     0Dnh1   17us : preempt_schedule (handle_level_irq)
  <idle>-0     0Dnh1   17us : irq_exit (do_IRQ)
  <idle>-0     0Dn..   17us : __schedule (cpu_idle)
  <idle>-0     0Dn..   17us : profile_hit (__schedule)
  <idle>-0     0Dn.1   18us : sched_clock (__schedule)
   <...>-2     0D..2   18us : __switch_to (__schedule)
   <...>-2     0D..2   18us : __schedule <<idle>-0> (20 199)
   <...>-2     0...1   18us : trace_stop_sched_switched (__schedule)
   <...>-2     0D..1   18us : trace_stop_sched_switched <<...>-2> (0 0)
   <...>-2     0D..2   18us : __schedule (__schedule)


vim:ft=help



Cheers
