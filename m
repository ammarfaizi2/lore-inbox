Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261733AbVCRQts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbVCRQts (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 11:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbVCRQts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 11:49:48 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:57250 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261733AbVCRQt0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 11:49:26 -0500
Date: Fri, 18 Mar 2005 17:48:52 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, dipankar@in.ibm.com,
       shemminger@osdl.org, akpm@osdl.org, torvalds@osdl.org,
       rusty@au1.ibm.com, tgall@us.ibm.com, jim.houston@comcast.net,
       manfred@colorfullife.com, gh@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and RCU
In-Reply-To: <20050318113053.GA18905@elte.hu>
Message-Id: <Pine.OSF.4.05.10503181336310.2466-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: 0 () 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2005, Ingo Molnar wrote:

> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > [...] How about something like:
> > 
> >         void
> >         rcu_read_lock(void)
> >         {
> >                 preempt_disable();
> >                 if (current->rcu_read_lock_nesting++ == 0) {
> >                         current->rcu_read_lock_ptr =
> >                                 &__get_cpu_var(rcu_data).lock;
> >                         preempt_enable();
> >                         read_lock(current->rcu_read_lock_ptr);
> >                 } else
> >                         preempt_enable();
> >         }
> > 
> > this would still make it 'statistically scalable' - but is it correct?
> 
> thinking some more about it, i believe it's correct, because it picks
> one particular CPU's lock and correctly releases that lock.
> 
> (read_unlock() is atomic even on PREEMPT_RT, so rcu_read_unlock() is
> fine.)
> 

Why can should there only be one RCU-reader per CPU at each given
instance? Even on a real-time UP system it would be very helpfull to have
RCU areas to be enterable by several tasks as once. It would perform
better, both wrt. latencies and throughput: 
With the above implementation an high priority task entering an RCU area
will have to boost the current RCU reader, make a task switch until that
one finishes and makes yet another task switch. to get back to the high
priority task. With an RCU implementation which can take n RCU readers per CPU
there is no such problem.

Also having all tasks serializing on one lock (per CPU) really destroys
the real-time properties: The latency of anything which uses RCU will be
the worst latency of anything done under the RCU lock.

When I looked briefly at it in the fall the following solution jumped into
mind: Have a RCU-reader count, rcu_read_count, for each CPU. When you
enter an RCU read region increment it and decrement it when you go out of
it. When it is 0, RCU cleanups are allowed - a perfect quiescent state. At
that point call rcu_qsctr_inc() at that point. Or call it in schedule() as
now just with a if(rcu_read_count==0) around it.

I don't think I understand the current code. But if it works now with
preempt_disable()/preempt_enable() around all the read-regions it ought to
work with 
    preempt_enable();
    rcu_read_count++/--;
    preempt_disable() 
around the same regions and the above check for rcu_read_count==0 in or
around rcu_qsctr_inc() as well.

It might take a long time before the rcu-batches are actually called,
though, but that is a different story, which can be improved upon. An
improvemnt would be to boost the none-RT tasks entering a rcu-read region
into the lowest RT-priority. That way there can't be a lot of low
priority tasks hanging around making rcu_read_count non-zero for a long
period of time since these tasks only can be preempted by RT tasks while
in the RCU-region.

> 	Ingo

Esben



