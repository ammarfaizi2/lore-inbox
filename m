Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbVIZSA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbVIZSA1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 14:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbVIZSA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 14:00:27 -0400
Received: from smtp1.Stanford.EDU ([171.67.16.123]:51909 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S932400AbVIZSA0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 14:00:26 -0400
Subject: Re: jack, PREEMPT_DESKTOP, delayed interrupts?
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: jackit-devel@lists.sourceforge.net, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, cc@ccrma.Stanford.EDU,
       Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <20050831073518.GA7582@elte.hu>
References: <1125453795.25823.121.camel@cmn37.stanford.edu>
	 <20050831073518.GA7582@elte.hu>
Content-Type: text/plain
Date: Mon, 26 Sep 2005 10:59:57 -0700
Message-Id: <1127757597.4587.11.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-31 at 09:35 +0200, Ingo Molnar wrote:
> * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> > Do a "tar cvf usr.tar /usr" just to read/write a lot to disk (this 
> > within the same SATA disk). Watch memory being used in a system 
> > monitor applet up to 100%. After a while, hard to say how long (maybe 
> > 10/15 minutes?) the system eventually can get into a state where Jack 
> > starts printing messages of the type "delay of 3856.000 usecs exceeds 
> > estimated spare time of 2653.000; restart ..." (if I understand 
> > correctly this means interrupts are being delayed on their way to 
> > Jack, or at least Jack thinks they are arriving too late), along with 
> > some less frequent xun notices.
> > 
> > Now the strange thing is that this condition seems to be persistent.  
> > Nothing I do after it starts to happen seems to halt those messages.  
> > Including stopping Jack and starting it again, and even (tried it 
> > once) stopping the alsa sound driver and loading it again. Nothing out 
> > of the ordinary in dmesg or /var/log/messages. I would guess that 
> > something "breaks" inside the kernel with regards to interrupt 
> > handling and/or whatever Jack uses to measure time inside the kernel?  
> > Interrupts are prioritized correctly (rtc, then audio and jack runs at 
> > lower realtime priority than the audio interrupts), everything else 
> > looks fine.
> 
[MUNCH]
> - please enable all latency tracing options like Lee suggested, and do 
>   "echo 0 > /proc/sys/kernel/preempt_max_latency" to get some traces. 

I have done that, finally, but I'm not sure I'm clear on the sequence of
things I have to do, sorry. 

echo 0 > /proc/sys/kernel/preempt_max_latency
(zeroes the max latency, I guess). 

When should I look at /proc/latency_trace? What exactly does it show? (I
know it is nicely commented :-) Is it just one trace?

I'm including one sample output...
-- Fernando


# cat /proc/latency_trace
preemption latency trace v1.1.5 on 2.6.13-0.3.rdtd.rhfc4.ccrmasmp
--------------------------------------------------------------------
 latency: 10852 us, #70/70, CPU#0 | (M:preempt VP:0, KP:1, SP:1 HP:1
#P:2)
    -----------------
    | task: qjackctl-4797 (uid:743 nice:0 policy:1 rt_prio:61)
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
   <...>-4593  1Dnh3    0us : MacPrivateStat (SkPnmiGetStruct)
   <...>-4593  1Dnh3    0us : MacPrivateStat (SkPnmiGetStruct)
   <...>-4593  1Dnh3    0us : MacUpdate (MacPrivateStat)
   <...>-4593  1Dnh3    0us : GetStatVal (MacPrivateStat)
   <...>-4593  1Dnh3    0us : GetPhysStatVal (GetStatVal)
   <...>-4593  1Dnh3    1us+: SkGmMacStatistic (GetPhysStatVal)
   <...>-4593  1Dnh3    3us : MacPrivateStat (SkPnmiGetStruct)
   <...>-4593  1Dnh3    3us : MacUpdate (MacPrivateStat)
   <...>-4593  1Dnh3    3us : GetStatVal (MacPrivateStat)
   <...>-4593  1Dnh3    3us : GetPhysStatVal (GetStatVal)
   <...>-4593  1Dnh3    3us+: SkGmMacStatistic (GetPhysStatVal)
   <...>-4593  1Dnh3    5us : MacPrivateStat (SkPnmiGetStruct)
   <...>-4593  1Dnh3    6us : MacPrivateStat (SkPnmiGetStruct)
   <...>-4593  1Dnh3    6us : MacUpdate (MacPrivateStat)
   <...>-4593  1Dnh3    6us : GetStatVal (MacPrivateStat)
   <...>-4593  1Dnh3    6us : GetPhysStatVal (GetStatVal)
   <...>-4593  1Dnh3    6us+: SkGmMacStatistic (GetPhysStatVal)
   <...>-4593  1Dnh3    8us : MacPrivateStat (SkPnmiGetStruct)
   <...>-4593  1Dnh3    9us : MacUpdate (MacPrivateStat)
   <...>-4593  1Dnh3    9us : GetStatVal (MacPrivateStat)
   <...>-4593  1Dnh3    9us : GetPhysStatVal (GetStatVal)
   <...>-4593  1Dnh3    9us+: SkGmMacStatistic (GetPhysStatVal)
   <...>-4593  1Dnh3   11us : MacPrivateStat (SkPnmiGetStruct)
   <...>-4593  1Dnh3   11us : MacPrivateStat (SkPnmiGetStruct)
   <...>-4593  1Dnh3   12us : MacUpdate (MacPrivateStat)
   <...>-4593  1Dnh3   12us : GetStatVal (MacPrivateStat)
   <...>-4593  1Dnh3   12us : GetPhysStatVal (GetStatVal)
   <...>-4593  1Dnh3   12us : MacPrivateStat (SkPnmiGetStruct)
   <...>-4593  1Dnh3   12us : MacUpdate (MacPrivateStat)
   <...>-4593  1Dnh3   12us : GetStatVal (MacPrivateStat)
   <...>-4593  1Dnh3   13us : GetPhysStatVal (GetStatVal)
   <...>-4593  1Dnh3   13us : MacPrivateStat (SkPnmiGetStruct)
   <...>-4593  1Dnh3   13us : MacPrivateStat (SkPnmiGetStruct)
   <...>-4593  1Dnh3   13us : MacUpdate (MacPrivateStat)
   <...>-4593  1Dnh3   13us : GetStatVal (MacPrivateStat)
   <...>-4593  1Dnh3   13us : GetPhysStatVal (GetStatVal)
   <...>-4593  1Dnh3   13us : MacPrivateStat (SkPnmiGetStruct)
   <...>-4593  1Dnh3   13us : MacUpdate (MacPrivateStat)
   <...>-4593  1Dnh3   13us : GetStatVal (MacPrivateStat)
   <...>-4593  1Dnh3   14us : GetPhysStatVal (GetStatVal)
   <...>-4593  1Dnh3   14us : MacPrivateStat (SkPnmiGetStruct)
   <...>-4593  1Dnh3   14us : MacPrivateStat (SkPnmiGetStruct)
   <...>-4593  1Dnh3   14us : MacUpdate (MacPrivateStat)
   <...>-4593  1Dnh3   14us : GetStatVal (MacPrivateStat)
   <...>-4593  1Dnh3   14us : GetPhysStatVal (GetStatVal)
   <...>-4593  1Dnh3   14us+: SkGmMacStatistic (GetPhysStatVal)
   <...>-4593  1Dnh3   17us : GetStatVal (MacPrivateStat)
   <...>-4593  1Dnh3   18us : GetPhysStatVal (GetStatVal)
   <...>-4593  1Dnh3   18us : SkGmMacStatistic (GetPhysStatVal)
   <...>-4593  1Dnh3   20us : GetStatVal (MacPrivateStat)
   <...>-4593  1Dnh3   20us : GetPhysStatVal (GetStatVal)
   <...>-4593  1Dnh3   20us+: SkGmMacStatistic (GetPhysStatVal)
   <...>-4593  1Dnh3   22us : GetStatVal (MacPrivateStat)
   <...>-4593  1Dnh3   22us : GetPhysStatVal (GetStatVal)
   <...>-4593  1Dnh3   22us+: SkGmMacStatistic (GetPhysStatVal)
   <...>-4593  1Dnh3   24us!: MacPrivateStat (SkPnmiGetStruct)
softirq--8     0Dnh4 9901us : trace_change_sched_cpu (1 0 0)
softirq--8     0Dnh4 9901us : _raw_spin_unlock (trace_change_sched_cpu)
softirq--8     0Dnh3 9902us : enqueue_task (move_tasks)
softirq--8     0Dnh3 9902us : resched_task (move_tasks)
softirq--8     0Dnh3 9902us : _raw_spin_unlock (load_balance_newidle)
softirq--8     0Dnh2 9902us : preempt_schedule (_raw_spin_unlock)
   <...>-4797  0Dnh2 9903us : __switch_to (__schedule)
   <...>-4797  0Dnh2 9904us : __schedule <softirq--8> (62 26)
   <...>-4797  0Dnh2 9904us : _raw_spin_unlock_irq (__schedule)
   <...>-4797  0...1 9904us : trace_stop_sched_switched (__schedule)
   <...>-4797  0Dnh1 9905us : _raw_spin_lock (trace_stop_sched_switched)
   <...>-4797  0Dnh2 9905us : trace_stop_sched_switched <<...>-4797> (26
0)
   <...>-4797  0Dnh2 9905us : trace_stop_sched_switched (__schedule)




