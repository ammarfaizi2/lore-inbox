Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWAAFqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWAAFqX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 00:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWAAFqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 00:46:23 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:26583 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751096AbWAAFqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 00:46:22 -0500
Subject: Re: [patch] latency tracer, 2.6.15-rc7
From: Lee Revell <rlrevell@joe-job.com>
To: paulmck@us.ibm.com
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Dave Jones <davej@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Eric Dumazet <dada1@cosmosbay.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, vatsa@in.ibm.com
In-Reply-To: <20051231201426.GD5124@us.ibm.com>
References: <20051229202848.GC29546@elte.hu>
	 <1135908980.4568.10.camel@mindpipe> <20051230080032.GA26152@elte.hu>
	 <1135990270.31111.46.camel@mindpipe>
	 <Pine.LNX.4.64.0512301701320.3249@g5.osdl.org>
	 <1135991732.31111.57.camel@mindpipe>
	 <Pine.LNX.4.64.0512301726190.3249@g5.osdl.org>
	 <1136001615.3050.5.camel@mindpipe> <20051231042902.GA3428@us.ibm.com>
	 <1136004855.3050.8.camel@mindpipe>  <20051231201426.GD5124@us.ibm.com>
Content-Type: text/plain
Date: Sun, 01 Jan 2006 00:46:11 -0500
Message-Id: <1136094372.7005.19.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-31 at 12:14 -0800, Paul E. McKenney wrote:
> So it seems to me that Linus's patch is part of the solution, but
> needs to also have a global component, perhaps as follows:
> 
> 	if (unlikely(rdp->count > 100)) {
> 		set_need_resched();

In fact neither of these patches helps, because these RCU callbacks run
from a tasklet in softirq context, and softirqs are not preemptible
(unless they are running in threads, see below):

                 _------=> CPU#        
                / _-----=> irqs-off        
               | / _----=> need-resched    
               || / _---=> hardirq/softirq <---------***
               ||| / _--=> preempt-depth   
               |||| /        
               |||||     delay        
   cmd     pid ||||| time  |   caller      
      \   /    |||||   \   |   /        
  <idle>-0     0d.s2    1us : __trace_start_sched_wakeup (try_to_wake_up)
  <idle>-0     0d.s2    1us : __trace_start_sched_wakeup <<...>-21330> (73 0)
  <idle>-0     0d.s.    2us : wake_up_process (process_timeout)
  <idle>-0     0d.s.    3us : tasklet_action (__do_softirq)
  <idle>-0     0d.s.    4us : rcu_process_callbacks (tasklet_action)
  <idle>-0     0d.s.    5us : __rcu_process_callbacks (rcu_process_callbacks)
  <idle>-0     0d.s.    5us : rcu_check_quiescent_state (__rcu_process_callbacks)
  <idle>-0     0d.s.    6us : __rcu_process_callbacks (rcu_process_callbacks)
  <idle>-0     0d.s.    7us : rcu_check_quiescent_state (__rcu_process_callbacks)
  <idle>-0     0d.s.    7us : rcu_do_batch (__rcu_process_callbacks)
  <idle>-0     0d.s.    8us : dst_rcu_free (rcu_do_batch)

Fortunately softirq preemption is one of the simplest parts of the -rt
patch - since the kernel already runs all softirqs in threads under
heavy load, it's simply a matter of adding a .config option to always do
that.

Linus, would you accept CONFIG_PREEMPT_SOFTIRQS to always run softirqs
in threads (default N of course, it certainly has a slight throughput
cost) for mainline if Ingo were to submit it?

Lee

