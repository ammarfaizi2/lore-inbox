Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbVDSGT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVDSGT6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 02:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbVDSGT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 02:19:58 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:4973 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261337AbVDSGTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 02:19:41 -0400
Subject: Re: [RFC PATCH] Dynamic sched domains aka Isolated cpusets
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Paul Jackson <pj@sgi.com>
Cc: dino@in.ibm.com, Simon.Derr@bull.net, lkml <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       dipankar@in.ibm.com, colpatch@us.ibm.com
In-Reply-To: <20050418225427.429accd5.pj@sgi.com>
References: <1097110266.4907.187.camel@arrakis>
	 <20050418202644.GA5772@in.ibm.com>  <20050418225427.429accd5.pj@sgi.com>
Content-Type: text/plain
Date: Tue, 19 Apr 2005 16:19:35 +1000
Message-Id: <1113891575.5074.46.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-18 at 22:54 -0700, Paul Jackson wrote:

> Now, onto the real stuff.
> 
> This same issue, in a strange way, comes up on the memory side,
> as well as on the cpu side.
> 
> First, let me verify one thing.  I understand that the _key_
> purpose of your patch is not so much to isolate cpus, as it
> is to allow for structuring scheduling domains to align with
> cpuset boundaries.  I understand real isolated cpus to be ones
> that don't have a scheduling domain (have only the dummy one),
> as requested by the "isolcpus=..." boot flag.
> 

Yes.

> The following code snippet from kernel/sched.c is what I derive
> this understanding from:
> 

Correct. A better name instead of isolated cpusets may be
'partitioned cpusets' or somesuch.

On the other hand, it is more or less equivalent to a single
isolated CPU. Instead of an isolated cpu, you have an isolated
cpuset.

Though I imagine this becomes a complete superset of the
isolcpus= functionality, and it would actually be easier to
manage a single isolated CPU and its associated processes with
the cpusets interfaces after this.


> In both cases, we have an intermediate degree of partitioning
> of a system, neither at the most detailed leaf cpuset, nor at
> the all encompassing top cpuset.  And in both cases, we want
> to partition the system, along cpuset boundaries.
> 

Yep. This sched-domains partitioning only works when you have
more than one completely disjoint top level cpusets. That is,
you effectively partition the CPUs.

It doesn't work if you have *most* jobs bound to either
{0, 1, 2, 3} or {4, 5, 6, 7} but one which should be allowed
to use any CPU from 0-7.

> Here I use "partition" in the mathematical sense:
> 
> ===============================================================
> A partition of a set X is a set of nonempty subsets of X such
> that every element x in X is in exactly one of these subsets.
> 
> Equivalently, a set P of subsets of X, is a partition of X if
> 
> 1. No element of P is empty.
> 2. The union of the elements of P is equal to X. (We say the
>    elements of P cover X.)
> 3. The intersection of any two elements of P is empty. (We say
>    the elements of P are pairwise disjoint.)
> 
> http://www.absoluteastronomy.com/encyclopedia/p/pa/partition_of_a_set.htm
> ===============================================================
> 
> In the case of cpus, we really do prefer the partitions to be
> disjoint, because it would be better not to confuse the domain
> scheduler with overlapping domains.
> 

Yes. The domain scheduler can't handle this at all, it would
have to fall back on cpus_allowed, which in turn can create
big problems for multiprocessor balancing.


> For the cpu case, we would provide a scheduler domain for each
> subset of the cpu partitioning.
> 

Yes.

[snip the rest, which I didn't finish reading :P]

>From what I gather, this partitioning does not exactly fit
the cpusets architecture. Because with cpusets you are specifying
on what cpus can a set of tasks run, not dividing the whole system.

Basically for the sched-domains code to be happy, there should be
some top level entity (whether it be cpusets or something else) which
records your current partitioning (the default being one set,
containing all cpus).

> As stated above, there is a single system wide partition of
> cpus, and another of mems.  I suspect we should consider finding
> a way to nest partitions.  My (shakey) understanding of what
> Nick is doing with scheduler domains is that for the biggest of
> systems, we will probably want little scheduler domains inside
> bigger ones.

The sched-domains setup code will take care of all that for you
already. It won't know or care about the partitions. If you
partition a 64-way system into 2 32-ways, the domain setup code
will just think it is setting up a 32-way system.

Don't worry about the sched-domains side of things at all, that's
pretty easy. Basically you just have to know that it has the
capability to partition the system in an arbitrary disjoint set
of sets of cpus.

If you can make use of that, then we're in business ;)

-- 
SUSE Labs, Novell Inc.


