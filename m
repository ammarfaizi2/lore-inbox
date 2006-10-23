Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWJWU6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWJWU6n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 16:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWJWU6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 16:58:43 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:22943 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751250AbWJWU6m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 16:58:42 -0400
Date: Mon, 23 Oct 2006 13:58:19 -0700
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: dino@in.ibm.com, akpm@osdl.org, mbligh@google.com, menage@google.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, rohitseth@google.com,
       holt@sgi.com, dipankar@in.ibm.com, suresh.b.siddha@intel.com
Subject: Re: [RFC] cpuset: add interface to isolated cpus
Message-Id: <20061023135819.cbb72dc2.pj@sgi.com>
In-Reply-To: <453C5E77.2050905@yahoo.com.au>
References: <20061019092607.17547.68979.sendpatchset@sam.engr.sgi.com>
	<20061020210422.GA29870@in.ibm.com>
	<20061022201824.267525c9.pj@sgi.com>
	<453C4E22.9000308@yahoo.com.au>
	<20061022225108.21716614.pj@sgi.com>
	<453C5E77.2050905@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick wrote:
> I think this is much more of an automatic behind your back thing. If
> they don't want any load balancing to happen, they could pin the tasks
> in that cpuset to the cpu they're currently on, for example.
> 
> It would be trivial to make such a script to parse the root cpuset and
> do exactly this, wouldn't it?

Yeah ... but ...

Such a script is trivial.

But I'm getting mixed messages on this "automatic behind your back"
thing.

We can't actually run such a script automatically, without the user
asking for it.  We only run such a script, to move what tasks we can
out of the top cpuset into a smaller cpuset, when the user sets up
a configuration asking for it.

And saying "If they don't want any load balancing to happen, they could
pin the tasks ..." doesn't sound automatic to me.  It sounds like a
backdoor API.

So you might say, and continue to hope, that this sched domain
partitioning is automatic.  But your own words, and my (limited)
experience, don't match that expectation.

  - We agree that automatic, truly automatic with no user
    intervention, beats some manually invoked API knob.

  - But a straight forward, upfront API knob (such as a flag indicating
    "no need to load balance across this cpuset") beats a backdoor,
    indirect, API trying to pretend it's automatic when it not.


> In the sense that they get what they ask for, yes. The obvious route
> for the big SGI systems is to put them in the right cpuset. The job
> managers (or admins) on those things are surely up to the task.

This is touching on a key issue.

Sure, if the admins feel motivated, this is within their capacity.
For something like the real-time nodes, the admins seem willing to
jump through flaming hoops and perform all manner of unnatural acts,
to get those nodes running tight, low latency, jitter free.

But admins don't wake up in the morning -wanting- to think about
the performance of balancing sched domains.  Partitioning sched
domains is not a frequently requested feature.

Sched domain partitioning is a workaround (apparently) for some
(perhaps inevitable) scaling issues in the schedulers load balancer -
right?

So, just how bad is this scaling issue with huge sched domains?
And why can't it be addressed at the source?  Perhaps say, by
ratelimiting the balancing efforts at higher domain sizes?

    For instance, I can imagine a dynamically variable ratelimit
    throttle on how often we try to balance across the higher domain
    sizes.  If such load balancing efforts are not yielding much fruit
    (seldom yield a worthwhile task movement) then do them less often.

    Then if someone is truly running a mixed timeshare load, of
    varying job sizes, wide open on a big system, with no serious
    effort at confining the jobs into smaller cpusets, we would
    continue to spend considerable effort load balancing the system.
    Not the most efficient way to run a system, but it should work
    as expected when you do that.

    If on the other hand, someone is using lots of small cpusets and
    pinning to carefully manage thread placement on a large system,
    we would end up backing off the higher levels of load balancing,
    as it seldom bore any fruit.

==

To my limited awareness, this sched domain balancing performance
problem (due to huge domains) isn't that big a problem.

I've been guessing that this is because the balancer is actually
reasonably efficient when presented with a carefully pinned load
that has one long living compute bound thread per CPU, even on
very high CPU count systems.

I'm afraid we are creating a non-automatic band-aid for a problem, that
would only work on systems (running nicely pinned workloads in small
cpusets) for which it is not actually a problem, designing the backdoor
API under the false assumption that it is really automatic, where
instead this API will be the least capable of automatically working for
exactly the workloads (poorly placed generic timeshare loads) that it
is most needed for.

And if you can parse that last sentence, you're a smarter man than
I am ;).

==

I can imagine an algorithm, along the lines Nick suggested yesterday,
to extract partitions from the cpus_allowed masks of all the tasks:

    It would scan each byte of each cpus_allowed mask (it could do
    bits, but bytes provide sufficient granularity and are faster.)

    It would have an intermediate array of counters, one per cpumask_t
    byte (that is, NR_CPUS/8 counters.)

    For each task, it would note the lowest non-zero byte in that
    tasks cpus_allowed, and increment the corresponding counter.
    Then it also note the highest non-zero byte in that cpus_allowed,
    and decrement the corresponding counter.

    Then after this scan of all task cpus_allowed, it would make
    a single pass over the counter array, summing the counts in a
    running total.  Anytime during that pass that the running total
    was zero, a partition could be placed.

    This resembles the algorithm used to scan parenthesized expressions
    (Lisp, anyone?) to be sure that the parentheses are balanced
    (count doesn't go negative) and closed (count ends back at zero.)
    During such a scan, one increments a count on each open parenthesis,
    and decrements it on each close.

But I'm going to be surprised if such an algorithm actually finds good
sched domain partitions, without at least manual intervention by the
sysadmin to remove tasks from all of the large cpusets.

And if it does find good partitions, that will most likely happen on
systems that are already administered using detailed job placement,
which systems might (?) not have been a problem in the first place.

So we've got an algorithm that is automatic when we least need it,
but requires administrative intervention when it was needed (making
it not so automatic ;).

And if that's what this leads to, I'd prefer a straight forward flag
that tells the system where to partition, or perhaps better, where it
can skip load balancing if it wants to.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
