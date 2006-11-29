Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967641AbWK2Ue1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967641AbWK2Ue1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 15:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967644AbWK2Ue1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 15:34:27 -0500
Received: from smtp2.Stanford.EDU ([171.67.20.25]:63129 "EHLO
	smtp2.stanford.edu") by vger.kernel.org with ESMTP id S967641AbWK2Ue0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 15:34:26 -0500
Subject: Re: 2.6.19-rc6-rt8: alsa xruns
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU, "Linux-Kernel," <linux-kernel@vger.kernel.org>
In-Reply-To: <20061129195144.GA8676@elte.hu>
References: <1164743931.15887.34.camel@cmn3.stanford.edu>
	 <20061128200927.GA26934@elte.hu>
	 <1164746224.15887.40.camel@cmn3.stanford.edu>
	 <1164747854.15887.48.camel@cmn3.stanford.edu>
	 <20061129134311.GA14566@elte.hu>
	 <1164825498.18954.5.camel@cmn3.stanford.edu>
	 <20061129195144.GA8676@elte.hu>
Content-Type: text/plain
Date: Wed, 29 Nov 2006 12:34:24 -0800
Message-Id: <1164832464.18954.33.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-29 at 20:51 +0100, Ingo Molnar wrote:
> * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> 
> > > ok, i reproduced something similar on one of my boxes and it turned 
> > > out to be a tracer bug. I've uploaded -rt10, could you try it? (The 
> > > xruns will likely remain, but at least the tracer should be more 
> > > usable now to find out the reason for the xruns.)
> > 
> > I'm testing -rt10 right now (your binary rpm). Looks like the number 
> > and length of the xruns went down, at least for now. All below 2mSec - 
> > jack is running 128x2 @ 48000Hz. I'll let it run for a while and 
> > report the traces (I have a script that collects all traces above 
> > 60us, but not all xruns trigger a trace).
> 
> ok.
> 
> How do you gather the traces, are you using manual control of tracing 
> via prctl(0,1) / prctl(0,0) - or the built-in wakeup tracing method? 

Just wakeup tracing (no manual control). 

> The wakeup tracing method will detect fundamental problems in -rt 
> scheduling, but other types of delays can be better debugged via 
> explicit tracing. [jackd used to have the gettimeofday(0,1)/(0,0) hack - 
> this API hack has been replaced by prctl(0,1)/(0,0) to start/stop 
> tracing] Take a look at linux/scripts/trace-it.c on how to set up 
> manually triggered tracing. [if you do that then all you need to do is 
> to start/stop the trace - the kernel will do a maximum search and will 
> record the longest delay between start/stop calls.]

I'll see if I can patch jack to use the new api so I can trigger this
stuff from within jack. That may give us more meaningful results (I'm
seeing traces but some don't have an "origin", they start with a big
offset already, see some below). 

Right now it is 12:25 and jack has not reported xruns since 10:43. Go
figure (several jack apps running, top running, and I'm installing and
testing packages as well == network + hard disk, but the load is not
very high in absolute terms). 

-- Fernando

[*] 

(          ardour-10060|#0): new 526 us maximum-latency wakeup.
preemption latency trace v1.1.5 on 2.6.18-3.rt10.0001
--------------------------------------------------------------------
 latency: 526 us, #13/13, CPU#0 | (M:rt VP:0, KP:0, SP:1 HP:1 #P:2)
    -----------------
    | task: ardour-10060 (uid:500 nice:0 policy:1 rt_prio:61)
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
  <idle>-0     0Dnh2  499us : hrtimer_interrupt (8137a917860
ffff8100382c3e98)
  <idle>-0     0Dnh2  501us : trace_special_sym (ffffffff8028e5f5 0 0)
  <idle>-0     0Dnh3  503us : effective_prio <<...>-14029> (-5 -5)
  <idle>-0     0Dnh3  504us : __activate_task <<...>-14029> (-5 1)
  <idle>-0     0Dnh3  506us+: try_to_wake_up <<...>-14029> (-5 20)
  <idle>-0     0.n.1  511us+: hrtimer_restart_sched_tick (8137a91b5fb 0)
  <idle>-0     0Dn.2  514us+: enqueue_hrtimer (8137a9b1d75
ffff8100040691f0)
  <idle>-0     0Dn.1  518us+: trace_special_sym (ffffffff8024a548 0 0)
   <...>-10060 0D..2  522us : thread_return <<idle>-0> (20 161)
   <...>-10060 0D..1  523us+: trace_stop_sched_switched <<...>-10060>
(38 0)
   <...>-10060 0...1  526us : thread_return (thread_return)


vim:ft=help
--------

or this one, but this is not long:

(          IRQ 18-746  |#1): new 70 us maximum-latency wakeup.
preemption latency trace v1.1.5 on 2.6.18-3.rt10.0001
--------------------------------------------------------------------
 latency: 70 us, #19/19, CPU#1 | (M:rt VP:0, KP:0, SP:1 HP:1 #P:2)
    -----------------
    | task: IRQ 18-746 (uid:0 nice:-5 policy:1 rt_prio:70)
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
  <idle>-0     1Dnh3    1us+: __trace_start_sched_wakeup <<...>-746> (29
1)
  <idle>-0     1Dnh3    4us+: trace_special_sym (ffffffff80247e98 0 0)
  <idle>-0     1Dnh3    8us+: try_to_wake_up <<...>-746> (170 20)
  <idle>-0     1Dnh2   29us+: hrtimer_interrupt (803de15eb1e
ffff81007dfc2160)
  <idle>-0     1Dnh1   34us : trace_special_sym (ffffffff8028e5f5 0 0)
  <idle>-0     1Dnh2   36us : __activate_task <<...>-22> (101 1)
  <idle>-0     1Dnh2   38us+: try_to_wake_up <<...>-22> (101 20)
  <idle>-0     1.n.1   41us : hrtimer_restart_sched_tick (803de16a56b 0)
  <idle>-0     1Dn.2   43us : enqueue_hrtimer (803de1ff5b2
ffff81000407a3f0)
  <idle>-0     1Dn.1   45us+: trace_special_sym (ffffffff8024a548 0 0)
   <...>-746   1D..2   50us+: thread_return <<idle>-0> (20 170)
   <...>-746   1D.h2   53us : hrtimer_interrupt (803de16b662
ffff8100382c3e98)
   <...>-746   1D.h2   55us+: trace_special_sym (ffffffff8028e5f5 0 0)
   <...>-746   1D.h3   58us+: effective_prio <<...>-14029> (-5 -5)
   <...>-746   1D.h3   60us+: __activate_task <<...>-14029> (-5 2)
   <...>-746   1D..1   65us+: trace_stop_sched_switched <<...>-746> (29
1)
   <...>-746   1...1   68us : thread_return (thread_return)




