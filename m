Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263087AbTDVLP2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 07:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263096AbTDVLP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 07:15:28 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:27598 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263087AbTDVLPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 07:15:25 -0400
Date: Tue, 22 Apr 2003 07:27:29 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Rick Lindsley <ricklind@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] HT scheduler, sched-2.5.68-A9 
In-Reply-To: <200304221110.h3MBAE712394@owlet.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.44.0304220712580.28721-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 22 Apr 2003, Rick Lindsley wrote:

>     yes. This 'un-sharing' of contexts happens unconditionally, whenever
>     we notice the situation. (ie. whenever a CPU goes completely idle
>     and notices an overloaded physical CPU.) On the HT system i have i
>     have measure this to be a beneficial move even for the most trivial
>     things like infinite loop-counting.
> 
> I have access to a 4-proc HT so I can try it there too. Did you test
> with micro-benchmarks like the loop-counting or did you use something
> bigger?

it is very obviously the case that two tasks running on different physical
CPUs outperform two tasks running on the same physical CPU. I have
attempted to find the best-case sharing - and even that one underperforms.  
I measured cache-heavy gcc compilation as well, there there was almost no
speedup due to HT.

but it's not really a problem - the logical CPUs are probably quite cheap
on the physical side, so any improvement in overload situations is a help.  
But once the overload situation stops, we should avoid the false sharing
and balance over those tasks to one physical CPU each.

in any case, please feel free to do measurements in this direction
nevertheless, more numbers never hurt.

>     the more per-logical-CPU cache a given SMT implementation has,
>     the less beneficial this move becomes - in that case the system
>     should rather be set up as a NUMA topology and scheduled via the
>     NUMA scheduler.
> 
> 	whew. So why are we perverting the migration thread to push
> 	rather than pull? If active_load_balance() finds a imbalance,
> 	why must we use such indirection?  Why decrement nr_running?
> 	Couldn't we put together a migration_req_t for the target queue's
> 	migration thread?
> 
>     i'm not sure what you mean by perverting the migration thread to
>     push rather to pull, as migration threads always push - it's not
>     different in this case either.
> 
> My bad -- I read the comments around migration_thread(), and they could
> probably be improved. [...]

i'll fix the comments up. And the migration concept originally was a pull
thing, but now it has arrived to a clean push model.

> [...] When I looked at the code, yes, it's more of a push.  The
> migration thread process occupies the processor so that you can be sure
> the process-of-interest is not running and can be more easily
> manipulated.

yes, that's the core idea.

>     Also, active balancing is non-queued by nature. Is there a big
>     difference?
> 
> I'm not sure active balancing really is independent of cpus_allowed.

of course we never balance to a CPU not allowed, but what i meant is that
the forced migration triggered by a ->cpus_allowed change [ie. the removal
of the current CPU from the process' allowed CPU mask] is conceptually
different from the forced migration of a task between two allowed CPUs.

> Yes, all the searches are done without that restriction in place, but
> then we ultimately call load_balance(), which *will* care.
> load_balance() may end up not moving what we wanted (or anything at
> all.)

load_balance() will most definitly balance the task in question, in the
active-balance case. The only reason why it didnt succeed earlier is
because load_balance() is a passive "pull" concept, so it is not able to
break up the false sharing between those two tasks that are both actively
running. [it correctly sees a 2:0 imbalance between the runqueues and
tries to balance them, but both tasks are running.] This is why the "push"  
concept of active-balancing has to kick in.

in fact in the active-balance case the imbalance is 3:0, because the
migration thread is running too, so we decrease nr_running artifically,
before calling load_balance(). Otherwise a 3:1 setup could cause a false
migration. [the real load situation is 2:1 in that case.]

we dont keep the runqueues locked while these migration requests are
pending, so there's a small window for the balancing to get behind - but
that risk is present with any statistical approach anyway.

	Ingo

