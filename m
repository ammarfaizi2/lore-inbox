Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbVJSHwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbVJSHwx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 03:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbVJSHwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 03:52:53 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:31105 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S1750800AbVJSHww
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 03:52:52 -0400
Date: Wed, 19 Oct 2005 09:52:15 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       david singleton <dsingleton@mvista.com>
Subject: Re: 1.6ms jitter in rtc_wakeup (Re: 2.6.14-rc4-rt1)
In-Reply-To: <Pine.OSF.4.05.10510142325150.24215-100000@da410.phys.au.dk>
Message-Id: <Pine.OSF.4.05.10510190946360.22661-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Oct 2005, Esben Nielsen wrote:

> On Fri, 14 Oct 2005, Ingo Molnar wrote:
> 
> > 
> > * Esben Nielsen <simlo@phys.au.dk> wrote:
> > 
> > > I set up rtc_wakeup and got a jitter up 1.6ms!
> > > It came when I cd'en into a nfs-mount and typed ls.
> > 
> > >       ls-11239 0Dn..    4us : profile_hit (__schedule)
> > >       ls-11239 0Dn.1    4us : sched_clock (__schedule)
> > >       ls-11239 0Dn.1    5us : check_tsc_unstable (sched_clock)
> > >       ls-11239 0Dn.1    5us : tsc_read_c3_time (sched_clock)
> > >    IRQ 8-775   0D..2    6us : __switch_to (__schedule)
> > >    IRQ 8-775   0D..2    7us!: __schedule <ls-11239> (75 0)
> > >    IRQ 8-775   0...1 1594us : trace_stop_sched_switched (__schedule)
> > >    IRQ 8-775   0D..2 1594us : trace_stop_sched_switched <IRQ 8-775> (0 0)
> > >    IRQ 8-775   0D..2 1595us : trace_stop_sched_switched (__schedule)
> > 
> > ouch! This very much looks like a hardware induced latency, because the 
> > codepath from those two __schedule points is extremely short and there 
> > is no loop there. Have you tested this particular box before too? If 
> > not, can you reproduce this latency with older versions of -rt too on 
> > the same box, or is this completely new? 
> I have been testing on this box before but never with such long latencies
> before.

I could not reproduce it on linux-2.6.14-rc3-rt10. The maximum meassured
rtc_wakeup is 146us with the same config options. 
Running linux-2.6.14-rc4-rt1 with ethernet disabled gave a maximum latency
of 1468us while building the kernel:

preemption latency trace v1.1.5 on 2.6.14-rc4-rt1
--------------------------------------------------------------------
 latency: 1468 us, #19/19, CPU#0 | (M:rt VP:0, KP:0, SP:1 HP:1)
    -----------------
    | task: IRQ 8-775 (uid:0 nice:-5 policy:1 rt_prio:99)
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
     cc1-8357  0D.h3    0us : __trace_start_sched_wakeup (try_to_wake_up)
     cc1-8357  0D.h3    0us : __trace_start_sched_wakeup <IRQ 8-775> (0 0)
     cc1-8357  0Dnh2    1us : try_to_wake_up <IRQ 8-775> (0 76)
     cc1-8357  0Dnh1    1us : preempt_schedule (try_to_wake_up)
     cc1-8357  0Dnh1    2us : wake_up_process (redirect_hardirq)
     cc1-8357  0Dnh.    2us : preempt_schedule (__do_IRQ)
     cc1-8357  0Dnh.    2us : irq_exit (do_IRQ)
     cc1-8357  0Dn..    3us : preempt_schedule_irq (need_resched)
     cc1-8357  0Dn..    3us : __schedule (preempt_schedule_irq)
     cc1-8357  0Dn..    4us : profile_hit (__schedule)
     cc1-8357  0Dn.1    4us : sched_clock (__schedule)
     cc1-8357  0Dn.1    4us : check_tsc_unstable (sched_clock)
   IRQ 8-775   0D..2    6us : __switch_to (__schedule)
   IRQ 8-775   0D..2    6us!: __schedule <cc1-8357> (76 0)
   IRQ 8-775   0...1 1467us : trace_stop_sched_switched (__schedule)
   IRQ 8-775   0D..2 1467us : trace_stop_sched_switched <IRQ 8-775> (0 0)
   IRQ 8-775   0D..2 1468us : trace_stop_sched_switched (__schedule)

I have not yet got around to try without ACPI/APM/CPU frequency scaling.

Esben

