Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbVLaUPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbVLaUPM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 15:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbVLaUPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 15:15:12 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:64650 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932317AbVLaUPK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 15:15:10 -0500
Date: Sat, 31 Dec 2005 12:14:26 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Dave Jones <davej@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Eric Dumazet <dada1@cosmosbay.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, vatsa@in.ibm.com
Subject: Re: [patch] latency tracer, 2.6.15-rc7
Message-ID: <20051231201426.GD5124@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051229202848.GC29546@elte.hu> <1135908980.4568.10.camel@mindpipe> <20051230080032.GA26152@elte.hu> <1135990270.31111.46.camel@mindpipe> <Pine.LNX.4.64.0512301701320.3249@g5.osdl.org> <1135991732.31111.57.camel@mindpipe> <Pine.LNX.4.64.0512301726190.3249@g5.osdl.org> <1136001615.3050.5.camel@mindpipe> <20051231042902.GA3428@us.ibm.com> <1136004855.3050.8.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136004855.3050.8.camel@mindpipe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2005 at 11:54:14PM -0500, Lee Revell wrote:
> On Fri, 2005-12-30 at 20:29 -0800, Paul E. McKenney wrote:
> > This should help in UP configurations, or in SMP configurations where
> > all CPUs are doing call_rcu_bh() very frequently.  I would not expect
> > it to help in cases where one of several CPUs is frequently executing
> > call_rcu_bh(), but where the other CPUs are either CPU-bound in user
> > space or are in a tickful idle state. 
> 
> This and net/decnet/dn_route.c are the only two uses of call_rcu_bh in
> the kernel.  And this one does not seem to be invoked frequently, it
> took ~48 hours to show up in the latency tracer.  Of course a server
> workload might call it all the time.

Well, most old-style server workloads wouldn't notice a 10ms hit to
latency.  I expect server workloads to become much more sensitive to
latency over time, however.  There are several reasons for this:
(1) as more and more workloads are spread over many machines, the
latency of each individual machine must improve just to maintain
the same overall latency (2) as computers continue to get less expensive
relative to people (and this trend is most pronounced in -developing-
countries, -not- developed countries!), it will be less and less
acceptable to have people waiting on computers (3) the trend of which
VOIP is part will continue, so that traditional server workloads will
have increasingly large latency-sensitive components.

But back to the problem at hand.

So it seems to me that Linus's patch is part of the solution, but
needs to also have a global component, perhaps as follows:

	if (unlikely(rdp->count > 100)) {
		set_need_resched();
		if (unlikely(rdp->count - rdp->last_rs_count > 1000)) {
			int cpu;

			rdp->last_rs_count = rdp->count;
			spin_lock_bh(&rcu_bh_state.lock);
			for_each_cpu_mask(cpu, rdp->rcu_bh_state.cpumask)
				smp_send_reschedule(cpu);
			spin_unlock_bh(&rcu_bh_state.lock);
		}
	}

I am sure that I am missing some interaction or another with tickless
idle and CPU hotplug covered.

There also needs to be some adjustment in rcu_do_batch(), which will
have to somehow get back to a quiescent state periodically.  Dipankar,
Vatsa, thoughts?

							Thanx, Paul
