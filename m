Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbWA1SAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbWA1SAJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 13:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751604AbWA1SAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 13:00:09 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:37322 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751045AbWA1SAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 13:00:08 -0500
Subject: Re: RCU latency regression in 2.6.16-rc1
From: Lee Revell <rlrevell@joe-job.com>
To: dipankar@in.ibm.com
Cc: paulmck@us.ibm.com, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20060128170302.GB5633@in.ibm.com>
References: <20060124081301.GC25855@elte.hu>
	 <1138090527.2771.91.camel@mindpipe> <20060124091730.GA31204@us.ibm.com>
	 <20060124092330.GA7060@elte.hu> <1138095856.2771.103.camel@mindpipe>
	 <20060124162846.GA7139@in.ibm.com> <20060124213802.GC7139@in.ibm.com>
	 <1138224506.3087.22.camel@mindpipe> <20060126191809.GC6182@us.ibm.com>
	 <1138388123.3131.26.camel@mindpipe>  <20060128170302.GB5633@in.ibm.com>
Content-Type: text/plain
Date: Sat, 28 Jan 2006 13:00:02 -0500
Message-Id: <1138471203.2799.13.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-28 at 22:33 +0530, Dipankar Sarma wrote:
> On Fri, Jan 27, 2006 at 01:55:22PM -0500, Lee Revell wrote:
> > On Thu, 2006-01-26 at 11:18 -0800, Paul E. McKenney wrote:
> > > >     Xorg-2154  0d.s.  213us : call_rcu_bh (rt_run_flush)
> > > >     Xorg-2154  0d.s.  215us : local_bh_enable (rt_run_flush)
> > > >     Xorg-2154  0d.s.  222us : local_bh_enable (rt_run_flush)
> > > >     Xorg-2154  0d.s.  223us : call_rcu_bh (rt_run_flush)
> > > > 
> > > > [ zillions of these deleted ]
> > > > 
> > > >     Xorg-2154  0d.s. 7335us : local_bh_enable (rt_run_flush)
> > > 
> > > Dipankar's latest patch should hopefully address this problem.
> > > 
> > > Could you please give it a spin when you get a chance? 
> > 
> > Nope, no improvement at all, furthermore, the machine locked up once
> > under heavy disk activity.
> > 
> > I just got an 8ms+ latency from rt_run_flush that looks basically
> > identical to the above.  It's still flushing routes in huge batches:
> 
> I am not supprised that the earlier patch doesn't help your
> test. Once you reach the high watermark, the "desperation mode"
> latency can be fairly bad since the RCU batch size is pretty
> big.
> 
> How about trying out the patch included below ? It doesn't reduce
> amount of work done from softirq context, but decreases the
> *number of RCUs* generated during rt_run_flush() by using
> one RCU per hash chain. Can you check if this makes any
> difference ?
> 
> Thanks
> Dipankar
> 
> 
> Reduce the number of RCU callbacks by flushing one hash chain
> at a time. This is intended to reduce RCU overhead during
> frequent flushing.
> 
> Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>

OK, now we are making progress.  I've been running my Gnutella client
for half an hour and the worst latency is only ~1ms, in what looks like
a closely related code path, but due to holding a spinlock
(rt_hash_lock_addr() in rt_check_expire), rather than merely being in
softirq context like the previous case.  Whether 1ms is too long to be
holding a spinlock can be addressed later; this is a significant
improvement.

preemption latency trace v1.1.5 on 2.6.16-rc1
--------------------------------------------------------------------
 latency: 1036 us, #1001/1001, CPU#0 | (M:rt VP:0, KP:0, SP:0 HP:0)
    -----------------
    | task: Xorg-2221 (uid:0 nice:0 policy:0 rt_prio:0)
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
  <idle>-0     0d.s4    1us : __trace_start_sched_wakeup (try_to_wake_up)
  <idle>-0     0d.s4    1us : __trace_start_sched_wakeup <<...>-2221> (73 0)
  <idle>-0     0d.s2    2us : wake_up_state (signal_wake_up)
  <idle>-0     0d.s.    3us : hrtimer_forward (it_real_fn)
  <idle>-0     0d.s.    4us : ktime_get (hrtimer_forward)
  <idle>-0     0d.s.    5us : ktime_get_ts (ktime_get)
  <idle>-0     0d.s.    5us : getnstimeofday (ktime_get_ts)
  <idle>-0     0d.s.    6us : do_gettimeofday (getnstimeofday)
  <idle>-0     0d.s.    6us : get_offset_tsc (do_gettimeofday)
  <idle>-0     0d.s.    7us : set_normalized_timespec (ktime_get_ts)
  <idle>-0     0d.s1    8us : enqueue_hrtimer (hrtimer_run_queues)
  <idle>-0     0d.s1   10us+: rb_insert_color (enqueue_hrtimer)
  <idle>-0     0d.s.   12us+: rt_check_expire (run_timer_softirq)
  <idle>-0     0d.s1   14us : rt_may_expire (rt_check_expire)
  <idle>-0     0d.s1   16us : rt_may_expire (rt_check_expire)
  <idle>-0     0d.s1   17us : call_rcu_bh (rt_check_expire)
  <idle>-0     0d.s1   18us : rt_may_expire (rt_check_expire)
  <idle>-0     0d.s1   20us : rt_may_expire (rt_check_expire)
  <idle>-0     0d.s1   21us : call_rcu_bh (rt_check_expire)
  <idle>-0     0d.s1   22us : rt_may_expire (rt_check_expire)
  <idle>-0     0d.s1   23us : rt_may_expire (rt_check_expire)
  <idle>-0     0d.s1   24us : call_rcu_bh (rt_check_expire)
  <idle>-0     0d.s1   25us : rt_may_expire (rt_check_expire)
  <idle>-0     0d.s1   26us : call_rcu_bh (rt_check_expire)
  <idle>-0     0d.s1   27us : rt_may_expire (rt_check_expire)
  <idle>-0     0d.s1   27us : call_rcu_bh (rt_check_expire)

[ etc ]

  <idle>-0     0d.s1  995us : rt_may_expire (rt_check_expire)
  <idle>-0     0d.s1  996us : call_rcu_bh (rt_check_expire)
  <idle>-0     0d.s1  997us : rt_may_expire (rt_check_expire)
  <idle>-0     0d.s1  998us : call_rcu_bh (rt_check_expire)
  <idle>-0     0d.s.  999us : mod_timer (rt_check_expire)
  <idle>-0     0d.s. 1000us : __mod_timer (mod_timer)
  <idle>-0     0d.s. 1001us : lock_timer_base (__mod_timer)
  <idle>-0     0d.s1 1001us : internal_add_timer (__mod_timer)
  <idle>-0     0d.s. 1003us : run_timer_softirq (__do_softirq)
  <idle>-0     0d.s. 1004us : hrtimer_run_queues (run_timer_softirq)
  <idle>-0     0d.s. 1005us : ktime_get_real (hrtimer_run_queues)
  <idle>-0     0d.s. 1005us : getnstimeofday (ktime_get_real)
  <idle>-0     0d.s. 1006us : do_gettimeofday (getnstimeofday)
  <idle>-0     0d.s. 1007us : get_offset_tsc (do_gettimeofday)
  <idle>-0     0d.s. 1008us : ktime_get (hrtimer_run_queues)
  <idle>-0     0d.s. 1008us : ktime_get_ts (ktime_get)
  <idle>-0     0d.s. 1009us : getnstimeofday (ktime_get_ts)
  <idle>-0     0d.s. 1010us : do_gettimeofday (getnstimeofday)
  <idle>-0     0d.s. 1010us : get_offset_tsc (do_gettimeofday)
  <idle>-0     0d.s. 1011us : set_normalized_timespec (ktime_get_ts)
  <idle>-0     0d.s. 1013us : tasklet_action (__do_softirq)
  <idle>-0     0d.s. 1013us : rcu_process_callbacks (tasklet_action)
  <idle>-0     0d.s. 1014us : __rcu_process_callbacks (rcu_process_callbacks)
  <idle>-0     0d.s. 1015us : __rcu_process_callbacks (rcu_process_callbacks)
  <idle>-0     0d.s1 1016us+: rcu_start_batch (__rcu_process_callbacks)
  <idle>-0     0dn.1 1018us < (2097760)
  <idle>-0     0dn.. 1019us : schedule (cpu_idle)
  <idle>-0     0dn.. 1020us : stop_trace (schedule)
  <idle>-0     0dn.. 1020us : profile_hit (schedule)
  <idle>-0     0dn.1 1021us+: sched_clock (schedule)
  <idle>-0     0dn.2 1023us : recalc_task_prio (schedule)
  <idle>-0     0dn.2 1024us : effective_prio (recalc_task_prio)
  <idle>-0     0dn.2 1025us : requeue_task (schedule)
   <...>-2221  0d..2 1029us+: __switch_to (schedule)
   <...>-2221  0d..2 1031us : schedule <<idle>-0> (8c 73)
   <...>-2221  0d..1 1032us : trace_stop_sched_switched (schedule)
   <...>-2221  0d..2 1033us+: trace_stop_sched_switched <<...>-2221> (73 0)
   <...>-2221  0d..2 1035us : schedule (schedule)


