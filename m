Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbVDSP3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbVDSP3v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 11:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVDSP3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 11:29:50 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:54507 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261613AbVDSP3X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 11:29:23 -0400
Date: Tue, 19 Apr 2005 08:26:39 -0700
From: Paul Jackson <pj@sgi.com>
To: dino@in.ibm.com
Cc: nickpiggin@yahoo.com.au, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, akpm@osdl.org, dipankar@in.ibm.com,
       colpatch@us.ibm.com
Subject: Re: [RFC PATCH] Dynamic sched domains aka Isolated cpusets
Message-Id: <20050419082639.62d706ca.pj@sgi.com>
In-Reply-To: <20050419095230.GC3963@in.ibm.com>
References: <1097110266.4907.187.camel@arrakis>
	<20050418202644.GA5772@in.ibm.com>
	<20050418225427.429accd5.pj@sgi.com>
	<1113891575.5074.46.camel@npiggin-nld.site>
	<20050419095230.GC3963@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar, replying to Nick:
> > It doesn't work if you have *most* jobs bound to either
> > {0, 1, 2, 3} or {4, 5, 6, 7} but one which should be allowed
> > to use any CPU from 0-7.
> 
> That is the current definition of cpu_exclusive on cpusets.
> I initially thought of attaching exclusive cpusets to sched domains,
> but that would not work because of this reason

I can't make any sense of this reply, Dinakar.

You say "_That_" is the current definition of cpu_exclusive -- I have no
idea what "_That_" refers to.  I see nothing in what Nick wrote that has
anything much to do with the definition of cpu_exclusive.  If a cpuset
is marked cpu_exclusive, it means that the kernel will not allow any of
its siblings to have overlapping CPUs.  It doesn't mean that its parent
can't overlap CPUs -- indeed it's parent must contain a superset of all
the CPUs in a cpu_exclusive cpuset and its siblings.  It doesn't mean
that there cannot be tasks attached to each of the cpu_exclusive cpuset,
its siblings and its parent.

You say "attaching exclusive cpusets to sched domains ... would not work
because of this reason."  I have no idea what "this reason" is.

I am pretty sure of a couple of things:
 * Your understanding of "cpu_exclusive" is not the same as mine.
 * We want to avoid any dependency on "cpu_exclusive" here.

> Since isolated cpusets are trying to partition the system, this
> can be restricted to only the first level of cpusets.

I do not think such a restriction is a good idea.  For example, lets say
our 8 CPU system has the following cpusets:

	/		# 0-7
	/Alpha		#   0-3
	/Alpha/phi	#     0-1
	/Alpha/chi	#     2-3
	/Beta		#   4-7

Then I see no problem with cpusets /Alpha/phi, /Alpha/chi and /Beta
being the isolated cpusets, with corresponding scheduler domains.  But
phi and chi are not "first level cpusets."  If we require a partition
(disjoint cover) of the CPUs in the system, then enforce exactly that.
Do not confuse a rough approximation with a simplified model.


> Also I think we can add further restrictions in terms not being able
> to change (add/remove) cpus within a isolated cpuset.

My approach agrees on this restriction.  Earlier I wrote:
> Also note that adding or removing a cpu from a cpuset that has
> its domain_cpu_current flag set true must fail, and similarly
> for domain_mem_current.

This restriction is required in my approach because the CPUs in the
domain_cpu_current cpusets (the isolated CPUs, in your terms) form a
partition (disjoint cover) of the CPUs in the system, which property
would be violated immediately if any CPU were added or removed from any
cpuset defining the partition.

> Instead one would
> have to tear down an existing cpuset and make a new one with the
> required configuration. that would simplify things even further

You've just come close to describing the approach that it took me
"several more" words to describe.  Though one doesn't need to tear down
or make any new cpusets; rather one atomically selects a new set of
cpusets to define the partition.

If one had to tear down and remake cpusets to change the partition, then
one would be in trouble -- it would be difficult to provide an API that
allowed doing that atomically.  If its not atomic, then we have illegal
intermediate states, where one cpuset is gone and the new one has not
arrived, and our partition of the cpusets in the system no longer covers
the system ("our cover is blown", as they say in undercover police
work.)

> And maybe also have a flag that says whether to have load balancing
> in this domain or not

It's probably too early to think about that.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
