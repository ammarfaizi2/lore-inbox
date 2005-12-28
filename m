Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbVL1BQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbVL1BQS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 20:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbVL1BQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 20:16:18 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:936 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932438AbVL1BQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 20:16:17 -0500
Subject: Re: 2.6.14-rt22 (and mainline): netstat -anop triggers excessive
	latencies
From: Lee Revell <rlrevell@joe-job.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1135204629.14810.43.camel@localhost.localdomain>
References: <1135145065.29182.10.camel@mindpipe>
	 <1135204629.14810.43.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 27 Dec 2005 20:21:27 -0500
Message-Id: <1135732888.22744.51.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-21 at 17:37 -0500, Steven Rostedt wrote:
> On Wed, 2005-12-21 at 01:04 -0500, Lee Revell wrote:
> > Here is a 13ms+ trace caused by "netstat -anop".  I noticed that the
> > preempt count is 0 so there are no locks to drop, would adding a
> > cond_resched() be acceptable?  Or should this be considered more
> > evidence of the need for softirq preemption?
> > 
> > preemption latency trace v1.1.5 on 2.6.14-rt22
> > --------------------------------------------------------------------
> >  latency: 13824 us, #16533/16533, CPU#0 | (M:preempt VP:0, KP:0, SP:0 HP:0)
> >     -----------------
> >     | task: softirq-timer/0-3 (uid:0 nice:0 policy:1 rt_prio:1)
> >     -----------------
> >  
> >                  _------=> CPU#            
> >                 / _-----=> irqs-off        
> >                | / _----=> need-resched    
> >                || / _---=> hardirq/softirq 
> >                ||| / _--=> preempt-depth   
> >                |||| /                      
> >                |||||     delay             
> >    cmd     pid ||||| time  |   caller      
> >       \   /    |||||   \   |   /           
> >  netstat-29157 0D.h2    0us : __trace_start_sched_wakeup (try_to_wake_up)
> >  netstat-29157 0D.h2    1us : __trace_start_sched_wakeup <<...>-3> (62 0)
> >  netstat-29157 0D.h.    2us : wake_up_process (wakeup_softirqd)
> 
> Hi Lee, I've seen the same thing here.  I wrote up this patch as a case
> study to see if it can work and it does.  Now this sacrifices memory for
> speed.  I added a bitmask in the inet_hash to keep track of all the
> buckets that are used, and use the find_next_bit to search the list in
> established_get_first.
> 
> After running the netstat -anop I get the following:
> 
> preemption latency trace v1.1.5 on 2.6.14-rt22
> --------------------------------------------------------------------
>  latency: 377 us, #225/225, CPU#0 | (M:preempt VP:0, KP:0, SP:0 HP:0)
>     -----------------
>     | task: softirq-timer/0-3 (uid:0 nice:0 policy:1 rt_prio:1)
>     -----------------
> 
>                  _------=> CPU#
>                 / _-----=> irqs-off
>                | / _----=> need-resched
>                || / _---=> hardirq/softirq
>                ||| / _--=> preempt-depth
>                |||| /
>                |||||     delay
>    cmd     pid ||||| time  |   caller
>       \   /    |||||   \   |   /
>   <idle>-0     0D.h4    0us : __trace_start_sched_wakeup (try_to_wake_up)
>   <idle>-0     0D.h4    0us : __trace_start_sched_wakeup <<...>-3> (62 0)
>   <idle>-0     0Dnh3    0us : try_to_wake_up <<...>-3> (62 8c)
>   <idle>-0     0Dnh2    1us : preempt_schedule (try_to_wake_up)
>   <idle>-0     0Dnh2    1us : wake_up_process (wakeup_softirqd)
> [snip]
> 
> So it really does improve the latency here.  Now is this worth the
> overhead?  This might be useful in other places to.

Any chance you can regenerate the patch against 2.6.15-rc5-rt4?

Lee

