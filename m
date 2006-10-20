Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946149AbWJTDiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946149AbWJTDiJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 23:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946150AbWJTDiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 23:38:08 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:13767 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1946149AbWJTDiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 23:38:05 -0400
Date: Thu, 19 Oct 2006 20:37:44 -0700
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: akpm@osdl.org, mbligh@google.com, menage@google.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, dino@in.ibm.com, rohitseth@google.com,
       holt@sgi.com, dipankar@in.ibm.com, suresh.b.siddha@intel.com,
       clameter@sgi.com
Subject: Re: [RFC] cpuset: add interface to isolated cpus
Message-Id: <20061019203744.09b8c800.pj@sgi.com>
In-Reply-To: <4537CC1E.60204@yahoo.com.au>
References: <20061019092607.17547.68979.sendpatchset@sam.engr.sgi.com>
	<453750AA.1050803@yahoo.com.au>
	<20061019105515.080675fb.pj@sgi.com>
	<4537BEDA.8030005@yahoo.com.au>
	<20061019115652.562054ca.pj@sgi.com>
	<4537CC1E.60204@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  1) If your other patch to manipulate sched domains
> >     has code that belongs in kernel/cpuset.c, and
> >     special files that belong in /dev/cpuset, why
> >     shouldn't this one naturally go in the same places?
> 
> Because they are cpuset specific. This is not.

Bizarre.  That other patch of yours, that had cpu_exclusive cpusets
only at the top level defining sched domain partitions, is cpuset
specific only because you're hijacking the cpu_exclusive flag to add
new semantics to it, and then claiming you're not adding new semantics
to it, and then claiming we should be doing this all implicitly without
additional kernel-user API apparatus, and then claiming that if your
new abuse of cpuset flags intrudes on other usage patterns of cpusets
or if they have need of a particular sched domain partitioning that
they have to explicitly set up top level cpusets to get a desired sched
domain partitioning ...

Stop already ...  this is getting insane.

Where are we?

By now, I think everyone (that is still following this thread ;)
seems to agree that the current code linking cpu_exclusive and
sched domain partitions is borked.

    I responded to that realization earlier this week by proposing
    a patch to add new sched_domain flags to each cpuset.

    Suresh responded to this realization by writing:
    > ...I don't know much about how job manager interacts with
    > cpusets but this behavior sounds bad to me.

    You responded by proposing a patch to use just the cpu_exclusive
    flags in the top level cpusets to define sched domain partitions.

The current code linking cpu_exclusive and sched domain partitions
is borked, and serving almost no purpose.  One of its goals was to
provide a way to workaround the scaling issues with the scheduler
load balancer code on humongous CPU count systems.  This current code
hasn't helped us a bit there.  We're starting to address these scaling
issues in various other ways.

So far as I can tell, the only actual successful application of this
current code to manipulate sched domain partitions has been by a real
time group, who have managed to isolate CPUs from load balancing with
this.

Everyone rejects the current code, and so far, for every replacement
suggested, at least one person rejects it.  You don't like my patches,
and I don't like yours.

Sounds to me like we don't have concensus yet ;).  Agreed?

And its not just the code that would try to define sched domains
via some implicit or explicit cpuset hooks that is in question here.

The sched domain related code in kernel/sched.c is overly complicated
and ifdef'd.  I can't personally critique that code, because my brain
is too small.  After repeated efforts to make sense of it, I still don't
understand it.  But I have it on good authority from colleagues whose
brains are bigger than mine that this code could use an overhaul.

So ... not only do we not have concensus on the specific patch to control
the definition of sched domain partitions, this is moreover part of a larger
ball of yarn that should be unraveled.

We'd be fools to try to settle on the specifics of the (possibly cpuset
related) API to define sched domain partitions in isolation.  We should
do that as part of such an overhaul of the rest of the sched domain code.

The current implicit hooks between cpu_exclusive cpusets and sched domain
partitions should be removed, as proposed in my patch:

     [RFC] cpuset: remove sched domain hooks from cpusets

I will submit this patch to Andrew for inclusion in *-mm.  It doesn't
change any explicit kernel API's - just removes the sched domain
side affects of the cpu_exclusive flag, which are currently borked
and more dangerous than useful.  So long as any rework we do provides
some way to isolate CPUs from load balancing sometime in the next
several months, before whenever the one real time group doing this
needs to see it, no one will miss these current sched domain hooks in
cpusets.

I will agree to NAK your (Nick's) patch to overload the cpu_exclusive
flags in the top level cpusets with sched domain partitioning side
affects, if you agree to NAK my patches to create an 'isolated_cpus'
file in the top cpuset.

My colleague Christoph Lameter will be looking into overhauling some of
this the sched domain code.  I am firmly convinced that any kernel
API's, implicit or explicit, cpuset related or not, involving these
sched domains and their partitioning should arise naturally out of that
effort, and not be band-aided on ahead of time.

Let's agree to give Christoph a clean shot at this, and join him in
this effort where we can.

Thanks.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
