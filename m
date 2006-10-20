Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992801AbWJTTAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992801AbWJTTAh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 15:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992803AbWJTTAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 15:00:37 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:51882 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S2992799AbWJTTAe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 15:00:34 -0400
Date: Fri, 20 Oct 2006 12:00:05 -0700
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: mbligh@google.com, akpm@osdl.org, menage@google.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, dino@in.ibm.com, rohitseth@google.com,
       holt@sgi.com, dipankar@in.ibm.com, suresh.b.siddha@intel.com,
       clameter@sgi.com
Subject: Re: [RFC] cpuset: remove sched domain hooks from cpusets
Message-Id: <20061020120005.61239317.pj@sgi.com>
In-Reply-To: <4538F34A.7070703@yahoo.com.au>
References: <20061019092358.17547.51425.sendpatchset@sam.engr.sgi.com>
	<4537527B.5050401@yahoo.com.au>
	<20061019120358.6d302ae9.pj@sgi.com>
	<4537D056.9080108@yahoo.com.au>
	<4537D6E8.8020501@google.com>
	<4538F34A.7070703@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The patch I posted previously should (modulo bugs) only do partitioning
> in the top-most cpuset. I still need clarification from Paul as to why
> this is unacceptable, though.

That patch partitioned on the children of the top cpuset, not the
top cpuset itself.

There is only one top cpuset - and that covers the entire system.

Consider the following example:

	/dev/cpuset		cpu_exclusive=1, cpus=0-7, task A
	/dev/cpuset/a		cpu_exclusive=1, cpus=0-3, task B
	/dev/cpuset/b		cpu_exclusive=1, cpus=4-7, task C

We have three cpusets - the top cpuset and two children, 'a' and 'b'.

We have three tasks, A, B and C.  Task A is running in the top cpuset,
with access to all 8 cpus on the system.  Tasks B and C are each in
a child cpuset, with access to just 4 cpus.

By your patch, the cpu_exclusive cpusets 'a' and 'b' partition the
sched domains in two halves, each covering 4 of the systems 8 cpus.
(That, or I'm still a sched domain idiot - quite possible.)

As a result, task A is screwed.  If it happens to be on any of cpus
0-3 when the above is set up and the sched domains become partitioned,
it will never be considered for load balancing on any of cpus 4-7.
Or vice versa, if it is on any of cpus 4-7, it has no chance of
subsequently running on cpus 0-3.

If your patch had been just an implicit optimization, benefiting
sched domains, by optimizing for smaller domains when it could do so
without any noticable harm, then it would at least be neutral, and
we could continue the discussion of that patch to ask if it provided
an optimization that helped enough to be worth doing.

But that's not the case, as the above example shows.

I do not see any way to harmlessly optimize sched domain partitioning
based on a systems cpuset configuration.

I am not aware of any possible cpuset configuration that defines a
partitioning of the systems cpus.  In particular, the top cpuset
always covers all online cpus, and any task in that top cpuset can
run anywhere, so far as cpusets is concerned.

So ... what can we do.

    What -would- be a useful partitioning of sched domains?

Not being a sched domain wizard, I can only hazard a guess, but I'd
guess it would be a partitioning that significantly reduced the typical
size of a sched domain below the full size of the system (apparently it
is quicker to balance several smaller domains than one big one), while
not cutting off any legitimate load balancing possibilities.

The static cpuset configuration doesn't tell us this (see the top
cpuset in the example above), but if one combined that with knowledge
of which cpusets had actively running jobs that should be load
balanced, then that could work.

I doubt we could detect this (which cpusets did or did not need to be
load balanced) automatically.  We probably need to have user code tell
us this.  That was the point of my patch that started this discussion
several days ago, adding explicit 'sched_domain' flag files to each
cpuset, so user code could mark the cpusets needing to be balanced.

Since proposing that patch, I've changed my recommendation.  Instead
of using cpusets to drive sched domain partitioning, better to just
provide a separate API, specific to the needs of sched domains, by
which user code can partition sched domains.  That, or make the
balancing fast enough, even on very large domains, that we don't need
to partition.  If we do have to partition, it would basically be for
performance reasons, and since I don't see any automatic way to
correctly partition sched domains, I think it would require some
explicit kernel-user API by which user space code can define the
partitioning.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
