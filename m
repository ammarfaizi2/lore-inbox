Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755519AbWK1VET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755519AbWK1VET (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 16:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755523AbWK1VET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 16:04:19 -0500
Received: from smtp3.Stanford.EDU ([171.67.20.26]:24992 "EHLO
	smtp3.stanford.edu") by vger.kernel.org with ESMTP id S1755519AbWK1VES
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 16:04:18 -0500
Subject: Re: 2.6.19-rc6-rt8: alsa xruns
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU, "Linux-Kernel," <linux-kernel@vger.kernel.org>
In-Reply-To: <1164746224.15887.40.camel@cmn3.stanford.edu>
References: <1164743931.15887.34.camel@cmn3.stanford.edu>
	 <20061128200927.GA26934@elte.hu>
	 <1164746224.15887.40.camel@cmn3.stanford.edu>
Content-Type: text/plain
Date: Tue, 28 Nov 2006 13:04:14 -0800
Message-Id: <1164747854.15887.48.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-28 at 12:37 -0800, Fernando Lopez-Lezcano wrote:
> On Tue, 2006-11-28 at 21:09 +0100, Ingo Molnar wrote:
> > * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> > 
> > > Hi, I'm trying out the latest -rt patch and getting alsa xruns when 
> > > using jackd and jack clients. This is a sample from the output of 
> > > qjackctl / jackd (jack 0.102.25, qjackctl 0.2.21):
> > 
> > > (            japa-4096 |#0): new 17 us maximum-latency wakeup.
> > > (         beagled-3412 |#1): new 19 us maximum-latency wakeup.
> > > (          IRQ 18-1081 |#1): new 26 us maximum-latency wakeup.
> > > (             snd-4040 |#1): new 1107 us maximum-latency wakeup.
> > > (            japa-4096 |#0): new 1445 us maximum-latency wakeup.
> > > (            japa-4096 |#0): new 2110 us maximum-latency wakeup.
> > > (        qjackctl-4038 |#1): new 2328 us maximum-latency wakeup.
> > > (            japa-4096 |#0): new 2548 us maximum-latency wakeup.
> > > (          IRQ 18-1081 |#0): new 10291 us maximum-latency wakeup.
> > 
> > hm, lets fix this. Could you enable tracing (on the yum rpm) via:
> > 
> > 	echo 1 > /proc/sys/kernel/trace_enabled
> > 
> > does /proc/latency_trace have any meaningful events included for such a 
> > long delay? If not then it would be nice to rebuild the kernel with 
> > CONFIG_LATENCY_TRACING - and in any case my previous suggestion holds 
> > too: booting with maxcpus=1 to reproduce the latencies will give easier 
> > to interpret latency traces. 
> 
> Sorry, it looks like it is an smp issue. Booting with maxcpus=1 reduces
> the xrun reports significantly (only three so far but very short, in the
> range of 0.029 to 0.041 ms). The long ones seem to have gone away, so
> far...

Strange, I rebooted smp and I'm not seeing the very long xruns I was
seeing before, only short ones as reported above. Here are some traces,
but nothing that makes sense I think.

I'll turn off the machine and cold boot it...)
-- Fernando


preemption latency trace v1.1.5 on 2.6.18-1.0001.3.rt8.fc6.ccrma
--------------------------------------------------------------------
 latency: 16023 us, #8/8, CPU#0 | (M:rt VP:0, KP:0, SP:1 HP:1 #P:2)
    -----------------
    | task: jackd-3739 (uid:500 nice:0 policy:1 rt_prio:62)
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
qjackctl-3740  0Dn.1    1us : __trace_start_sched_wakeup <<...>-3739>
(37 0)
qjackctl-3740  0Dn.1    3us : try_to_wake_up <<...>-3739> (162 161)
qjackctl-3740  0Dn.1    4us : trace_special_sym (ffffffff802668da 0 0)
   <...>-3739  1D..2    8us : thread_return <softirq--17> (199 162)
   <...>-3739  1D..1   10us+: trace_stop_sched_switched <<...>-3739> (37
1)
   <...>-3739  1...1   13us : thread_return (thread_return)


vim:ft=help

preemption latency trace v1.1.5 on 2.6.18-1.0001.3.rt8.fc6.ccrma
--------------------------------------------------------------------
 latency: 71 us, #14/14, CPU#1 | (M:rt VP:0, KP:0, SP:1 HP:1 #P:2)
    -----------------
    | task: IRQ 18-813 (uid:0 nice:-5 policy:1 rt_prio:70)
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
  <idle>-0     1Dnh3    3us+: __trace_start_sched_wakeup <<...>-813> (29
1)
  <idle>-0     1Dnh3    8us+: try_to_wake_up <<...>-813> (170 20)
  <idle>-0     1Dnh1   22us+: do_IRQ (ffffffff8026f32c 12 0)
  <idle>-0     1Dnh2   25us+: trace_special_sym (ffffffff8028f2ad 0 0)
  <idle>-0     1Dnh3   29us+: __activate_task <<...>-412> (149 1)
  <idle>-0     1Dnh3   33us+: try_to_wake_up <<...>-412> (149 20)
  <idle>-0     1.n.1   40us+: hrtimer_restart_sched_tick (d48a31262d 0)
  <idle>-0     1Dn.2   44us+: enqueue_hrtimer (d48a527afd
ffff81000407a950)
  <idle>-0     1Dn.1   52us+: trace_special_sym (ffffffff8024b93e 0 0)
   <...>-813   1D..2   60us+: thread_return <<idle>-0> (20 170)
   <...>-813   1D..1   64us+: trace_stop_sched_switched <<...>-813> (29
1)
   <...>-813   1...1   71us : thread_return (thread_return)


vim:ft=help

preemption latency trace v1.1.5 on 2.6.18-1.0001.3.rt8.fc6.ccrma
--------------------------------------------------------------------
 latency: 2255 us, #11/11, CPU#0 | (M:rt VP:0, KP:0, SP:1 HP:1 #P:2)
    -----------------
    | task: japa-3782 (uid:500 nice:0 policy:1 rt_prio:61)
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
  <idle>-0     0Dnh2 2236us : hrtimer_interrupt (ec6e49749d
ffff81006a68ddc8)
  <idle>-0     0Dnh2 2237us : trace_special_sym (ffffffff8028f2ad 0 0)
  <idle>-0     0Dnh3 2239us : effective_prio <<...>-3619> (-5 -5)
  <idle>-0     0Dnh3 2241us : __activate_task <<...>-3619> (-5 1)
  <idle>-0     0Dnh3 2243us+: try_to_wake_up <<...>-3619> (-5 20)
  <idle>-0     0Dn.1 2246us : trace_special_sym (ffffffff8024b93e 0 0)
   <...>-3782  0D..2 2250us : thread_return <<idle>-0> (20 161)
   <...>-3782  0D..1 2252us+: trace_stop_sched_switched <<...>-3782> (38
0)
   <...>-3782  0...1 2255us : thread_return (thread_return)


vim:ft=help


