Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbUC3VO4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 16:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUC3VO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 16:14:56 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:9164
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261210AbUC3VOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 16:14:52 -0500
Date: Tue, 30 Mar 2004 23:14:50 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: kuznet@ms2.inr.ac.ru
Cc: dipankar@in.ibm.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       Robert.Olsson@data.slu.se, "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dave Miller <davem@redhat.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: route cache DoS testing and softirqs
Message-ID: <20040330211450.GI3808@dualathlon.random>
References: <20040329222926.GF3808@dualathlon.random> <200403302005.AAA00466@yakov.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403302005.AAA00466@yakov.inr.ac.ru>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2004 at 12:05:05AM +0400, kuznet@ms2.inr.ac.ru wrote:
> Hello!
> 
> > > Robert demonstrated to us sometime ago with a small
> > > timestamping user program to show that it can get starved for
> > > more than 6 seconds in his system. So userland starvation is an
> > > issue.
> > 
> > softirqs are already capable of being offloaded to scheduler-friendy
> > kernel threads to avoid starvation, if this wasn't the case NAPI would
> > have no way to work in the first place and everything else would fall
> > apart too, not just the rcu-route-cache. I don't think high latencies
> > and starvation are the same thing, starvation means for "indefinite
> > time" and you can't hang userspace for indefinite time using softirqs.
> > For sure the irq based load, and in turn softirqs too, can take a large
> > amount of cpu (though not 100%, this is why it cannot be called
> > starvation).
> > 
> > the only real starvation you can claim is in presence of an _hard_irq
> > flood, not a softirq one.
> 
> There are no hardirqs in the case under investigation, remember?

no hardirqs? there must be tons of hardirqs if ksoftirqd never runs.

> 
> What's about the problem it really splits to two ones:
> 
> 1. The _new_ problem when bad latency of rcu hurts core
>    functionality. This is precise description:
> 
> > to keep up with the softirq load.  This has never been the case so far,
> > and serving softirq as fast as possible is normally a good thing for
> > server/firewalls, the small unfariness (note unfariness != starvation)
> > it generates has never been an issue, because so far the softirq never
> > required the scheduler to work in order to do their work, rcu changed
> > this in the routing cache specific case.
> 
> We had one full solution for this issue not changing anything
> in scheduler/softirq relationship: to run rcu task for the things
> sort of dst cache not from process context, but essentially as part
> of do_softirq(). Simple, stupid and apparently solves new problems
> which rcu created.

I don't understand exactly the details of how this works but I trust you ;)

> Another solution is just to increase memory consumption limits
> to deal with current rcu latency. F.e. 300ms latency just requires
> additional space for pps*300ms objects, which are handled by RCU.
> The problem with this is that pps is the thing which increases
> when cpu power grows and that 300ms is not a mathematically established
> limit too.

I consider this more a workaround than a solution ;). It also depends
how much boost you get from the rcu scalability in smp to evaluate if
the above solution could be worthwhile, I don't know the exact numbers
myself.

> > So you're simply asking the ksoftirqd offloading to become more
> > aggressive,
> 
> It is the second challenge.
> 
> Andrea, it is experimenatl fact: this "small unfariness" stalls process
> contexts for >=6 seconds and gives them microscopic slices. We could live
> with this (provided RCU problem is solved in some way). Essentially,

yes, we could live with this if it wasn't for RCU not making any
progress and the irq load depending on the RCU to make progress.

> the only trouble for me was that we could use existing rcu bits to make
> offloading to ksoftirqd more smart (not aggressive, _smart_). The absense
> of RCU quiescent states looks too close to absence of forward progress
> in process contexts, it was anticipating similarity. The dumb throttling
> do_softirq made not from ksoftirqd context when starvation is detected
> which we tested the last summer is not only ugly, it really might hurt
> router performance, you are right here too. It is the challenge:
> or we proceed with this idea and invent something, or we just forget
> about this concentrating on RCU.

So basically you're suggesting to use the rcu grace period "timeout" to
choose when to defer the softirq load to userspace, right? That should
work. I mean, it will need some instrumentation to define the "timeout",
but it's very similar to the patch I already posted, rather than
local_softirqd_running() we'll check for rcu_timed_out() and we'll
wakeup ksofitrqd in that case and we'll return immediatly from
do_softirq. That will still risk to lose some packet from the backlog
though, since we'll process softirqs at a slower peace (but that's
partly the feature).

That sounds a bit too rcu centric though, I mean, if we do this, maybe
we should make it indipendent from rcu, and we could detect a too long
time spent in softirq load, and we can offload softirqs in function of
that instead of the rcu_timed_out() thing.
