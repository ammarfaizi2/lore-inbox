Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbVDSJeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbVDSJeS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 05:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVDSJeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 05:34:18 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:48855 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261434AbVDSJeL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 05:34:11 -0400
Date: Tue, 19 Apr 2005 15:22:30 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Paul Jackson <pj@sgi.com>, Simon.Derr@bull.net,
       lkml <linux-kernel@vger.kernel.org>, lse-tech@lists.sourceforge.net,
       Andrew Morton <akpm@osdl.org>, dipankar@in.ibm.com, colpatch@us.ibm.com
Subject: Re: [RFC PATCH] Dynamic sched domains aka Isolated cpusets
Message-ID: <20050419095230.GC3963@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <1097110266.4907.187.camel@arrakis> <20050418202644.GA5772@in.ibm.com> <20050418225427.429accd5.pj@sgi.com> <1113891575.5074.46.camel@npiggin-nld.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113891575.5074.46.camel@npiggin-nld.site>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2005 at 04:19:35PM +1000, Nick Piggin wrote:

[...Snip...]
> Though I imagine this becomes a complete superset of the
> isolcpus= functionality, and it would actually be easier to
> manage a single isolated CPU and its associated processes with
> the cpusets interfaces after this.

That is the idea, though I think that we need to be able to
provide users the option of not doing a load balance within a
sched domain

> It doesn't work if you have *most* jobs bound to either
> {0, 1, 2, 3} or {4, 5, 6, 7} but one which should be allowed
> to use any CPU from 0-7.

That is the current definition of cpu_exclusive on cpusets.
I initially thought of attaching exclusive cpusets to sched domains,
but that would not work because of this reason

> > 
> > In the case of cpus, we really do prefer the partitions to be
> > disjoint, because it would be better not to confuse the domain
> > scheduler with overlapping domains.
> > 
> 
> Yes. The domain scheduler can't handle this at all, it would
> have to fall back on cpus_allowed, which in turn can create
> big problems for multiprocessor balancing.
> 

I agree

> >From what I gather, this partitioning does not exactly fit
> the cpusets architecture. Because with cpusets you are specifying
> on what cpus can a set of tasks run, not dividing the whole system.

Since isolated cpusets are trying to partition the system, this
can be restricted to only the first level of cpusets. Keeping in mind
that we have a flat sched domain heirarchy, I think probably this
would simplify the update_sched_domains function quite a bit.

Also I think we can add further restrictions in terms not being able
to change (add/remove) cpus within a isolated cpuset. Instead one would
have to tear down an existing cpuset and make a new one with the
required configuration. that would simplify things even further

> The sched-domains setup code will take care of all that for you
> already. It won't know or care about the partitions. If you
> partition a 64-way system into 2 32-ways, the domain setup code
> will just think it is setting up a 32-way system.
> 
> Don't worry about the sched-domains side of things at all, that's
> pretty easy. Basically you just have to know that it has the
> capability to partition the system in an arbitrary disjoint set
> of sets of cpus.

And maybe also have a flag that says whether to have load balancing
in this domain or not

	-Dinakar
