Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269622AbUJFXLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269622AbUJFXLU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 19:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269617AbUJFXJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 19:09:30 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:62616 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S269603AbUJFXDj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 19:03:39 -0400
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Paul Jackson <pj@sgi.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Simon.Derr@bull.net,
       pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, LSE Tech <lse-tech@lists.sourceforge.net>,
       hch@infradead.org, steiner@sgi.com, Jesse Barnes <jbarnes@sgi.com>,
       sylvain.jeaugey@bull.net, djh@sgi.com,
       LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       sivanich@sgi.com
In-Reply-To: <20041005190852.7b1fd5b5.pj@sgi.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	 <20040805190500.3c8fb361.pj@sgi.com> <247790000.1091762644@[10.10.2.4]>
	 <200408061730.06175.efocht@hpce.nec.com>
	 <20040806231013.2b6c44df.pj@sgi.com> <411685D6.5040405@watson.ibm.com>
	 <20041001164118.45b75e17.akpm@osdl.org>
	 <20041001230644.39b551af.pj@sgi.com> <20041002145521.GA8868@in.ibm.com>
	 <415ED3E3.6050008@watson.ibm.com> <415F37F9.6060002@bigpond.net.au>
	 <821020000.1096814205@[10.10.2.4]> <20041003083936.7c844ec3.pj@sgi.com>
	 <834330000.1096847619@[10.10.2.4]> <835810000.1096848156@[10.10.2.4]>
	 <20041003175309.6b02b5c6.pj@sgi.com> <838090000.1096862199@[10.10.2.4]>
	 <20041003212452.1a15a49a.pj@sgi.com> <843670000.1096902220@[10.10.2.4]>
	 <Pine.LNX.4.61.0410051111200.19964@openx3.frec.bull.fr>
	 <58780000.1097004886@flay> <20041005172808.64d3cc2b.pj@sgi.com>
	 <1193270000.1097025361@[10.10.2.4]>  <20041005190852.7b1fd5b5.pj@sgi.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1097103580.4907.84.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 06 Oct 2004 15:59:41 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-05 at 19:08, Paul Jackson wrote:
> Martin writes:
> > I agree with the basic partitioning stuff - and see a need for that. The
> > non-exclusive stuff I think is fairly obscure, and unnecessary complexity
> > at this point, as 90% of it is covered by CKRM. It's Andrew and Linus's 
> > decision, but that's my input.
> 
> Now you're trying to marginalize non-exclusive cpusets as a fringe
> requirement.  Thanks a bunch ;).
> 
> Instead of requiring complete exclusion for all cpusets, and pointing to
> the current 'exclusive' flag as the wrong flag at the wrong place at the
> wrong time (sorry - my radio is turned to the V.P. debate in the
> background) how about let's being clear what sort of exclusion the
> schedulers, the allocators and here the resource manager (CKRM) require.

I think what Martin is trying to say, in his oh so eloquent way, is that
the difference between 'non-exclusive' cpusets and, say, CKRM
taskclasses isn't very clear.  It seems to me that non-exclusive cpusets
are little more than a convenient way to group tasks.  Now, I'm not
saying that I don't think that is a useful functionality, but I am
saying that cpusets seem like the wrong way to go about it.


> I can envision dividing a machine into a few large, quite separate,
> 'soft' partitions, where each such partition is represented by a subtree
> of the cpuset hierarchy, and where there is no overlap of CPUs, Memory
> Nodes or tasks between the 'soft' partitions, even though there is a
> possibly richly nested cpuset (cpu and memory affinity) structure within
> any given 'soft' partition.
> 
> Nothing would cross 'soft' partition boundaries.  So far as CPUs, Memory
> Nodes, Tasks and their Affinity, the 'soft' partitions would be
> separate, isolated, and non-overlapping.

Ok.  These imaginary 'soft' partitions sound much like what I expected
'exclusive' cpusets to be based on the terminology.  They also sound
exactly like what I am trying to implement through my sched_domains
work.


> Each such 'soft' partition could host a separate instance (domain) of
> the scheduler, allocator, and resource manager.  Any such domain would
> know what set of CPUs, Memory Nodes and Tasks it was managing, and would
> have complete and sole control of the scheduling, allocation or resource
> sharing of those entities.

I don't know that these partitions would necessarily need their own
scheduler, allocator and resource manager, or if we would just make the
current scheduler, allocator and resource manager aware of these
boundaries.  In either case, that is an implementation detail not to be
agonized over now.


> But also within a 'soft' partition, there would be finer grain placement,
> finer grain CPU and Memory affinity, whether by the current tasks
> cpus_allowed and mems_allowed, or by some improved mechanism that the
> schedulers, allocators and resource managers could better deal with.
> 
> There _has_ to be.  Even if cpusets, sched_setaffinity, mbind, and
> set_mempolicy all disappeared tomorrow, you still have the per-cpu
> kernel threads that have to be placed to a tighter specification than
> the whole of such a 'soft' partition.

Agreed.  I'm not proposing that we rip out sched_set/getaffinity, mbind,
etc.  What I'm saying is that tasks should not *default* to using these
mechanisms because, at least in their current incarnations, our
scheduler and allocator are written in such a way that these mechanisms
are secondary.  The assumption is that the scheduler/allocator can
schedule/allocate wherever they choose.  The scheduler does look at
these bindings and if they contradict the decision made we deal with
that after the fact.  The allocator has longer code paths and more logic
to deal with if there are bindings in place.  So our options are to
either:
1) find a way to not have to rely on these mechanisms for most/all tasks
in the system, or 
2) rewrite the scheduler/allocator to deal with these bindings up front,
and take them into consideration early in the scheduling/allocating
process.


> Could you or some appropriate CKRM guru please try to tell me what
> isolation you actually need for CKRM.  Matthew or Peter please do the
> same for the schedulers.
> 
> In particular, do you need to prohibit any finer grained placement
> within a particular domain, or not.  I believe not.  Is it not the case
> that what you really need is that the cpusets that correspond to one of
> your domains (my 'soft' partitions, above) be isolated from any other
> such 'soft' partition?  Is it not the case that further, finer grained
> placement within such an isolated 'soft' partition is acceptable?  Sure
> better be.  Indeed, that's pretty much what we have now, with what
> amounts to a single domain covering the entire system.

I must also plead ignorance to the gritty details of CKRM.  It would
seem to me, from discussions on this thread, that CKRM could be made to
deal with 'isolated' domains, 'soft' partitions, or 'exclusive' cpusets
without TOO much headache.  Basically just telling CKRM that the tasks
in this group are sharing CPU time from a pool of 4 CPUs, rather than
all 16 CPUs in the system.  Hubertus?  As far as supporting fine grained
binding inside domains, that should definitely be supported in any
solution worthy of acceptance.  CKRM, to the best of my knowledge,
currently deals with cpus_allowed, and there's no reason to think that
it wouldn't be able to deal with cpus_allowed in the multiple domain
case.


> Instead of throwing out half of cpusets on claims that it conflicts
> with the requirements of the schedulers, resource managers or (not yet
> raised) the allocators, please be more clear as to what the actual
> requirements are.

That's not really the reason that I was arguing against half of
cpusets.  My argument is not related to CKRM's requirements, as I really
don't know what those are! :)  My argument is that I don't see what
non-exclusive cpusets buys us.  If all we're looking for is basic
task-grouping functionality, I'm quite certain that we can implement
that in a much more light-weight way that doesn't conflict with the
scheduler's decision making process.  In fact, for non-exclusive
cpusets, I'd say that we can probably implement that type of
task-grouping in a non-intrusive way that will complement the scheduler
and possibly even improve performance by giving the scheduler a hint
about which tasks should be scheduled together.  Using cpus_allowed is
not that way.  cpus_allowed should be reserved for what it was
originally meant for: specifying a *strict* subset of CPUs that a task
is restricted to running on.

-Matt

