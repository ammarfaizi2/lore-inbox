Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965024AbWBGLZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbWBGLZN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 06:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965026AbWBGLZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 06:25:12 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:61572 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S965024AbWBGLZK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 06:25:10 -0500
Subject: preempt-rt, NUMA and strange latency traces
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>
Date: Tue, 07 Feb 2006 12:28:09 +0100
Message-Id: <1139311689.19708.36.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 07/02/2006 12:26:02,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 07/02/2006 12:26:07,
	Serialize complete at 07/02/2006 12:26:07
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

  I've been experimenting with 2.6.15-rt16 on a dual 2.8GHz Xeon box 
with quite good results and decided to make a run on a NUMA dual node
IBM x440 (8 1.4GHz Xeon, 28GB ram).

  However, the kernel crashes early when creating the slabs. Does the
current preempt-rt patchset supports NUMA machines or has support
been disabled until things settle down?

  Going on, I compiled a non NUMA RT kernel which booted just fine,
but when examining the latency traces, I came upon strange jumps
in the latencies such as:


   <...>-6459  2D.h1   42us : rcu_pending (update_process_times)
   <...>-6459  2D.h1   42us : scheduler_tick (update_process_times)
   <...>-6459  2D.h1   43us : sched_clock (scheduler_tick)
   <...>-6459  2D.h1   44us!: _raw_spin_lock (scheduler_tick)
   <...>-6459  2D.h2 28806us : _raw_spin_unlock (scheduler_tick)
   <...>-6459  2D.h1 28806us : rebalance_tick (scheduler_tick)
   <...>-6459  2D.h1 28807us : irq_exit (smp_apic_timer_interrupt)
   <...>-6459  2D..1 28808us < (608)
   <...>-6459  2D..1 28809us : smp_apic_timer_interrupt (c03e2a02 0 0)
   <...>-6459  2D.h1 28810us : handle_nextevent_update (smp_apic_timer_interrupt)
   <...>-6459  2D.h1 28810us : hrtimer_interrupt (handle_nextevent_update)

or 

  <idle>-0     0Dn..   11us : __schedule (cpu_idle)
  <idle>-0     0Dn..   12us : profile_hit (__schedule)
  <idle>-0     0Dn.1   12us : sched_clock (__schedule)
  <idle>-0     0Dn.1   13us : _raw_spin_lock_irq (__schedule)
   <...>-6459  0D..2   14us : __switch_to (__schedule)
   <...>-6459  0D..2   15us : __schedule <<idle>-0> (8c 0)
   <...>-6459  0D..2   16us : _raw_spin_unlock_irq (__schedule)
   <...>-6459  0...1   16us!: trace_stop_sched_switched (__schedule)
   <...>-6459  0D..1 28585us : smp_apic_timer_interrupt (c013babb 0 0)
   <...>-6459  0D.h1 28585us : handle_nextevent_update (smp_apic_timer_interrupt)
   <...>-6459  0D.h1 28586us : hrtimer_interrupt (handle_nextevent_update)

or even

  <idle>-0     3D.h4    0us!: __trace_start_sched_wakeup (try_to_wake_up)
  <idle>-0     3D.h4 28899us : __trace_start_sched_wakeup <<...>-6459> (0 3)
  <idle>-0     3D.h4 28900us : _raw_spin_unlock (__trace_start_sched_wakeup)
  <idle>-0     3D.h3 28900us : resched_task (try_to_wake_up)


  There does not seem to be a precise code path leading to those jumps, it seems
they can appear anywhere. Furthermore the jump seems to always be of ~ 27 ms

  I tried running on only 1 CPU, tried using the TSC instead of the cyclone
timer but to no avail, the phenomenon is still there.

  My test program only consists in a thread running at max RT priority doing
a nanosleep().

  What could be going on here? 


  Thanks,

  Sébastien.



