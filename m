Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261955AbVDKWP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbVDKWP3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 18:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbVDKWP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 18:15:28 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:41154 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261955AbVDKWOw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 18:14:52 -0400
Date: Mon, 11 Apr 2005 15:15:06 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [patch 4/5] sched: RCU sched domains
Message-ID: <20050411221506.GA1304@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <425322E0.9070307@yahoo.com.au> <42532317.5000901@yahoo.com.au> <42532346.5050308@yahoo.com.au> <425323A1.5030603@yahoo.com.au> <20050406061838.GB5973@elte.hu> <4253975E.20804@yahoo.com.au> <20050407071101.GA26607@elte.hu> <4254E830.5040703@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4254E830.5040703@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 05:58:40PM +1000, Nick Piggin wrote:
> Ingo Molnar wrote:
> >* Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> >
> >
> >>>At a minimum i think we need the fix+comment below.
> >>
> >>Well if we say "this is actually RCU", then yes. And we should 
> >>probably change the preempt_{dis|en}ables in other places to 
> >>rcu_read_lock.
> >>
> >>OTOH, if we say we just want all running threads to process through a 
> >>preemption stage, then this would just be a preempt_disable/enable 
> >>pair.
> >>
> >>In practice that makes no difference yet, but it looks like you and 
> >>Paul are working to distinguish these two cases in the RCU code, to 
> >>accomodate your low latency RCU stuff?
> >
> >
> >it doesnt impact PREEMPT_RCU/PREEMPT_RT directly, because the scheduler 
> >itself always needs to be non-preemptible.
> >
> >those few places where we currently do preempt_disable(), which should 
> >thus be rcu_read_lock(), are never in codepaths that can take alot of 
> >time.
> >
> >but yes, in principle you are right, but in this particular (and 
> >special) case it's not a big issue. We should document the RCU read-lock 
> >dependencies cleanly and make all rcu-read-lock cases truly 
> >rcu_read_lock(), but it's not a pressing issue even considering possible 
> >future features like PREEMPT_RT.
> >
> >the only danger in this area is to PREEMPT_RT: it is a bug on PREEMPT_RT 
> >if kernel code has an implicit 'spinlock means preempt-off and thus 
> >RCU-read-lock' assumption. Most of the time these get discovered via 
> >PREEMPT_DEBUG. (preempt_disable() disables preemption on PREEMPT_RT too, 
> >so that is not a problem either.)
> >
> 
> OK thanks for the good explanation. So I'll keep it as is for now,
> and whatever needs cleaning up later can be worked out as it comes
> up.

Looking forward to the split of synchronize_kernel() into synchronize_rcu()
and synchronize_sched(), the two choices are:

o	Use synchronize_rcu(), but insert rcu_read_lock()/rcu_read_unlock()
	pairs on the read side.

o	Use synchronize_sched(), and make sure all read-side code is
	under preempt_disable().

Either way, there may also need to be some rcu_dereference()s when picking
up pointer and rcu_assign_pointer()s when updating the pointers.
For example, if traversing the domain parent list is to be RCU protected,
the for_each_domain() macro should change to something like:

#define for_each_domain(cpu, domain) \
	for (domain = cpu_rq(cpu)->sd; domain; domain = rcu_dereference(domain->parent))

							Thanx, Paul
