Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261962AbVBLBl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbVBLBl2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 20:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbVBLBl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 20:41:28 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:63951 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261962AbVBLBkR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 20:40:17 -0500
Date: Fri, 11 Feb 2005 17:37:44 -0800
From: Chandra Seetharaman <sekharan@us.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, dino@in.ibm.com, mbligh@aracnet.com,
       pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, Simon.Derr@bull.net, ak@suse.de,
       sivanich@sgi.com
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-ID: <20050212013744.GC22159@chandralinux.beaverton.ibm.com>
References: <20041003083936.7c844ec3.pj@sgi.com> <834330000.1096847619@[10.10.2.4]> <1097014749.4065.48.camel@arrakis> <420800F5.9070504@us.ibm.com> <20050208095440.GA3976@in.ibm.com> <42090C42.7020700@us.ibm.com> <20050208124234.6aed9e28.pj@sgi.com> <20050209175928.GA5710@chandralinux.beaverton.ibm.com> <20050211024606.GB19997@chandralinux.beaverton.ibm.com> <20050211012112.4913a3e2.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050211012112.4913a3e2.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2005 at 01:21:12AM -0800, Paul Jackson wrote:
> [ For those who have already reached a conclusion on this
>   subject, there is little that is new below.  It's just
>   cast in a different light, as an analysis of how well
>   the CKRM cpuset/memset task class that Chandra describes
>   meets the needs of cpusets.  The conclusion is: not well.
> 
>   A pickup truck and a motorcycle both have their uses.
>   It's just difficult to combine them in a useful fashion.
> 
>   Feel free to skim or skip the rest of this message. -pj ]
> 
[ As replied in a earlier mail I am not advocating for cpuset to be
  a ckrm controller. In this mail I am just providing clarifications
  for some of Paul's comments. -chandra ]

> 
> Chandra writes:
> > If I missed some feature of cpuset that shows a bigger problem, please
> > let me know.
> 
> Perhaps it would be better if first you ask yourself what
> features your cpuset/memset taskclasses provide beyond

First off, I wasn't pitching for 'our' cpuset/memset taskclass. I was 
suggesting that 'your' cpuset can be a ckrm controller.


> what's available in the basic sched_setaffinity (for cpu)
> and mbind/set_mempolicy (for memory) calls.  Offhand, I don't
> see any.

and it don't have to be same as what the above functions provide. cpuset
can function exactly the same way under ckrm as it does otherwise.

> 
> But, I will grant, with my apologies, that I wrote the above
> more in irritation than in a sincere effort to explain.
> 
> So, let me come at this through another door.
> 
> Since it seems apparent by now that both numa placement and
> workload management cause some form of mutually exclusive brain
> damage to its practitioners, making it difficult for either to
> understand the other, let me:
>  1) describe the important properties of cpusets,
>  2) examine how well your proposal provides such, and
>  3) examine its additional costs compared to cpusets.
> 
> 1. The important properties of cpusets.
> =======================================
>  
> Cpusets facilitate integrated processor and memory placement
> of jobs on large systems, especially useful on numa systems,
> where the co-ordinated placement of jobs on cpus and memory is
> important, sometimes critical, to obtaining good performance.
> 
> It is becoming increasingly obvious, as Intel, IBM and AMD
> push more and more cores into one package at one end, and as
> NEC, IBM, Bull, SGI and others push more and more packages into
> single image systems at the other end, that complex layered numa
> topologies are here to stay, in increasing number and complexity.
> 
> Cpusets helps manage numa placement of jobs in a way that
> numa folks seem to find makes sense.  The names of key
> interface elements, and the opening remarks in commentary and
> documentation are specific and relevant to the needs of those
> doing numa placement.
> 
> It does so with a minimal, low cost patch in the main kernel.
> Running diffstat on the cpuset* patches in 2.6.11-rc1-mm2 shows
> the following summary stats:
> 
>   19 files changed, 2362 insertions(+), 253 deletions(-)
> 
> The runtime costs are nearly zero, consisting in the usual
> case on any hot paths of a usage counter increment at fork, a
> usage counter decrement at exit, a usually inconsequential
> bitmask test in mm/page_alloc.c, and a generation number
> check in the mm/mempolicy.c alloc_page_vma() wrapper to
> __alloc_pages().
> 
> Cpusets handles any number of CPUs and Memory Nodes, with no
> practical hard limit imposed by the API or data types.
> 
> Cpusets can be used in combination with a workload manager
> such as CKRM.  You can use cpusets to create "soft partitions"
> that are subsets of the entire system, and then in each such
> partition, you can run a separate instance of a workload manager
> to obtain the desired resource sharing.

CKRM's controllers currently may not play well with cpusets.
> 
> Cpusets may provide a practical API to support administrative
> refinements of scheduler domains, along more optimal natural
> job boundaries, instead of just along automatic, artificial
> architecture boundaries.  Matthew and Nick both seem to be
> making mumblings in this direction, but the jury is still out.
> Indeed, we're still investigating.  I have not heard of anyone
> proposing to integrate CKRM and sched domains in this manner,
> nor do I expect to.

I haven't looked at sched_domains closely. May be I should and see how we
can form a synergy.

> 
> There is no reason to artificially limit the depth of the cpuset
> hierarchy, which represents subsets of subsets of cpus and nodes.
> The rules (invariants) of cpusets have been carefully chosen
> so as to never require any global or wide ranging analysis of
> the cpuset hierarchy in order to enforce.  Each child must be
> a subset of its parent, and exclusive cpusets cannot overlap
> their siblings.  That's about it.  Both rules can be evaluated
> locally, using just the nearest relatives of an affected cpuset.
> 
> An essential feature of the cpuset proposal is its file system
> model of the 'nested subsets of cpus and nodes'.  This provides
> a name space, and permission model, that supports sensible
> administration of numa friendly subsets of the compute resources
> of large systems in complex administration environments.
> A system can be dynamically 'partitioned' and 'sub-partitioned',
> with sensible names and permissions for the partitions, while
> maintaining the benefits of a single system image.  This is
> a classic use of a kernel, to manage a system wide resource
> with a name space, structure rules, resource attributes, and
> a permission/access model.
> 
> In sum, cpusets provides substantial benefit past the individual
> sched_setaffinity/mbind/set_mempolicy calls for managing the
> numa placement of jobs on large systems, at modest cost in
> code size, runtime, maintenance and intellectual mastery.
> 
> 
> 2. How much of the above does your proposal provide?
> ====================================================
> 
> Not much.  As best as I can tell, it provides an alternative
> to the existing numa cpu and memory calls, at the cost of
> considerable code, complexity and obtuseness above and beyond
> cpusets.  That additional complexity may well be necessary,
> for the more difficult job it is trying to accomplish.  But it
> is not necessary for the simpler task of numa placement of jobs
> on named, controlled, subsets of cpus and memory nodes.

I was answering a different question: whether ckrm can accomodate
cpuset or not ? ( i 'll talk about the complexity part later).

> 
> Your proposal doesn't provide a distinguished "numa computation
> unit" (cpu + memory), but rather tends to lose those two elements
> in a longer list of task class elements.

It doesn't readily provide it, but the architecture can provide it.

> 
> I can't tell if it's just because you didn't take much time to
> study cpusets, or if it's due to more essential limitations
> of the CKRM implementation, but you got the subsetting and
> exclusive rules wrong (or at least different).

My understanding was that, if a class/cpuset has an exclusive flag
set, then those cpus can be used only by this cpuset and its parent,
and no other cpusets in the system. 

I did get one thing wrong, I did not realize that you do not allow
setting the exclusive flag in a cpuset if any of its siblings has
any of this cpuset's cpus. (May be i still didn't get it right)....

But, that doesn't change what I wrote in my earlier mail,
because, all these details are controller specific and i do not see
any limitation from ckrm's point of view in this context.

> 
> The CKRM documentation and the names of key flags and such are
> not intuitive to those doing numa work.  If one comes at CKRM
> from the perspective of someone trying to solve a numa placement
> problem, the interfaces, documentation and naming really don't
> make sense.  Even if your architecture is more general and
> powerful, I suspect your presentation is not widely accessible
> outside those with a workload focus.  Or perhaps I'm just more
> dimwitted than most.  It's difficult for me to know which.
> But certainly both Matthew and I have struggled to make sense
> of CKRM from a numa perspective.

I agree. The filenames are not intuitive for cpuset purposes.

> 
> You state you'd have a 128 CPU limitation.  I don't know why
> that would be, but it would be a critical imitation for SGI --
> no small problem.

I understand it is critical for SGI. I said it is a small problem 
because it can be worked out easily.

> 
> As explained below, with your proposal, one could not readily do
> both workload management and numa placement at the same time,
> because the task class hierarchy needed for the two is not
> the same.
> 
> As noted above, while there seems to be a decent chance that
> cpusets will provide some benefit to scheduler domains, allowing
> the option of organizing sched domains along actual job usage
> lines instead of artificial architecture lines, I have seen
> no suggestion that CKRM task classes have that potential to
> improve sched domains.
> 
> Elsewhere I recall you've had to impose fairly modest bounds
> on the depth of your class hierarchy, because your resource
> balancing rules are expensive to evaluate across deep, large
> trees.  The cpuset hierarchy has no such restraint.

We put the limitation in the architecture because of controllers. 
We can open it up to allow deeper hierarchy and let the controllers
decide how deep they can support.

> 
> Your task class hierarchy, if hijacked for numa placement,

I wasn't suggestint the cpuset controller to hijack ckrm's task
hierarchy, I was suggesting to play within.

Controllers don't hijack hierarchy. Hierarchy is only for classes,
controllers have control over only their portion of a class.

> might provide the kernel managed naming, structure and
> access control of dynamic (soft) numa partitions that cpusets
> does.  I haven't looked closely at the permission model of
> CKRM to see if it matches the needs of cpusets, so I can't
> speak to that detail.

Are you talking about allowing users to manage their own class/cpusets ?
If so, we do have them.

> 
> In sum, your cpuset/memset CKRM proposal provides few, if any,
> of the additional benefits to numa placement work that cpusets
> provides over the existing affinity and numa system calls.
> 
> 
> 3. What are the additional costs of your proposal over cpusets?
> ===============================================================
> 
> Your proposal, while it seems to offer little advantage for
> numa placement to what we already have without cpusets, comes
> at a substantial cost great than cpusets.
> 
> The CKRM patch is five times the size of the cpuset patch,
> with diffstat on the ckrm-e17.2610.patch showing:
> 
>   65 files changed, 13020 insertions(+), 19 deletions(-)

ckrm-e17 has the whole stack(core, rcfs, taskclass, socketclass, delay
accounting, rbce, crbce, numtasks controller and listenaq controller).

But, for your purposes or our discussions one would need only 3 modules of
the above (core, rcfs and taskclass). I just compared it with the broken
up patches we posted on lkml recently. The whole stack has 12227 insertions
of which only 4554 insertions correspond to the 3 modules listed.

> 
> The CKRM runtime, from what I can tell on the lmbench slide
> from OLS 2004, costs several percent of available cycles.

The graph you see in the presentation is with the CPU controller. Not
for the core ckrm. We don't have to include CPU controller to get cpuset
working as a controller.

> 
> You propose to include the cpu/mem placement hierarchy in the
> task class hierarchy.  This presents difficulties.  Essentially,
> they are not the same hierarchies.  A jobs placement is
> independent of its priority.  Both high and low priority jobs
> may well require proper numa placement, and both high and low
> priority tasks may well run within the same cpuset.
> 
> So if your task class hierarchy is hijacked for numa placement,
> it will not serve you well for workload management.  On a system
> that required numa placement using something like cpusets, the
> fives times larger size of the kernel patch required for CKRM

As explained above, it is not 5 timer larger.

> would be entirely unjustified, as CKRM would only be usable
> for its cpuset-like capabilities.
> 
> Much of what you have now in CKRM would be useless for cpuset
> work.  As you observed in your proposal, you would need new
> cpuset related rules for the subset and exclusive properties.

ckrm doesn't need new rules, the subset and exclusive property handling
will be the functionality of the cpuset controller.

> 
> The cpuset scheduler hook is none - it only needs the
> existing cpus_allowed check that Ingo already added, years ago.
> You propose having the scheduler check the appropriate cpu mask
> in the task class, which would definitely increase the cache
> footprint size of the scheduler.

agree, one more level of indirection(instead of task->cpuset->cpus_allowed
it will be task->taskclass->res[CPUSET]->cpus_allowed).

> 
> The papers for CKRM speak of providing policy driven
> classification and differentiated service.  The focus is on
> managing resource sharing, to allow different classes of tasks
> to get controlled allocations of proportions of shared resources.
> 
> Cpusets is not about sharing proportions of a common resource,
> but rather about dedicating entire resources.  Granted,
> mathematically, there might be a mapping between these two.
> But is it certainly an impediment to those having to understand
> something, if it is implemented by abusing something quite
> larger and quite foreign in intention.
> 
> This flows through to the names of the specific files in the
> directory representing a cpuset or class.  The names for CKRM
> class directories are necessarily rather generic and abstract,
> whereas those for cpusets directly represent the particular
> need of placing tasks on cpus and memory nodes.  For someone
> doing numa placement, the latter are much easier to understand.
> 
> And as noted above, since you can't do both at the same time
> (both use the CKRM infrastructure for its traditional workload
> management and use it for numa placement) it's not like the
> administrator of such a system gains any from the more abstract
> names, if they are just using it for cpusets (numa placement).
> 
> There is no synergy in the kernel hooks required in the scheduler
> and memory allocator.  The hooks required by cpusets check
> bitmasks in order to allow or prohibit scheduling a task on
> a CPU, or allocating a page from a particular node to a task.
> These are quite distinct from the hooks required by CKRM when
> used as a fair share scheduler and workload manager, which
> requires adding delays to tasks in order to obtain the desired
> proportion of resource usage between classes.  Similarly, the
> CKRM memory allocator hooks manage the number of pages in use
> by each task class and/or the rate of page faults, while the
> cpuset memory allocator hooks manage which memory nodes are
> available to satisfy an allocation request.

I think this is where we go tangential. When you say CKRM you refer
the whole stack.

When we say CKRM, we mean only the framework(core, rcfs and taskclass or
socketclass).  It is the frame work that enables the user to define classes
and classify tasks or sockets.

All the other modules are optional and exchangable.

CKRM has different configurable modules that has their defined purposes.
One doesn't have to include a module if they don't need it.

> 
> The share usage hooks that monitor each resource, and its usage
> by each class, are useless for cpusets, which has no dependency
> on resource usage.  In cpusets, a task can use as much of its
> allowed CPUs and Memory Nodes, without throttling.  There is
> no feedback loop based on rates of resource usage per class.
> 
> Most of the hooks required by the CKRM classification engine to
> check for possible changes in a tasks class, such as in fork,
> exec, setuid, listen, and other points where a kernel object
> might change are not needed for cpusets.  The cpuset patch only
> requires such state change hooks in fork, exit and allocation,
> and only requires to increment or decrement a usage count in
> the fork and exit, and check a generation number in allocation.
> 
> Cpusets has no use for a kernel classification engine.  Outside
> of the trivial, automatic propagation of cpusets in fork and
> exit, the only changes in cpusets are mandated from user space.
> 
> Nor do cpusets have any need for the kernel to support externally
> defined policy rules.  Cpusets has no use for the classification
> engines callback mechanism.  In cpusets, no events that might
> affect state, such as fork, exit, reclassifications, changes in
> uid, or resource rate usage samples, need to be reported to any
> state agent, and there is no state agent, nor any communication
> channel thereto.
> 
> Cpusets has no use for a facility that lets server tasks tell
> some external classifier what phase they are operating in.
> Cpusets has no need for some workload manager to be sampling
> resource consumption and task state to determine resource
> consumption.  Cpusets has no need to track, in user space or
> kernel, the state of tasks after they exit. Cpusets has no use
> for delays nor for tracking them in the task struct.
> 
> Cpusets has no need for the hooks at the entry to, and exit from,
> memory allocation routines to distinguish delays due to memory
> allocation from those due to application i/o.  Cpusets has no
> need for sampling task state at fixed intervals, and our big
> iron scientific customers would without a doubt not tolerate a
> scan of the entire set of tasks every second for such resource
> and task state data collection.  Such a scan does _not_ scale
> well on big honkin numa boxes.  Whereas CKRM requires something
> like relayfs to pass back to user space the constant stream of
> such data, cpusets has no such needs and no such data.
> 
> Certainly, none of the network hooks that CKRM requires to
> provide differentiated service across priority classes would be
> of any use in a system (ab)using CKRM to provide cpuset style
> numa placement.

With the explanations above, I think you would now agree that all 
the above comments are invalidated. Basically you don't have to
bring them in if you don't need them.

> 
> It is true that both cpusets and CKRM make good use of the Linux
> kernel's virtual file system (vfs).  Cpusets uses vfs to model
> the hierarchy of 'soft partitions' in the system.  CKRM uses vfs
> to model a resource priority hierarchy, essentially replacing a
> single 'task priority' with hierarchical resource allocations,
> managing what proportion, out of what is available, of fungible
> resources such as ticks, cycles, bytes or data transfers a
> given class of tasks is allowed to use in the aggregate.
> 
> Just because two facilities use vfs is certainly not sufficient
> basis for deciding that they should be combined into one
> facility.
> 
> The shares and stats control files in each task_class
> directory are not needed by cpusets, but new control files,
> for cpus_allowed and mems_allowed are needed.  That, or the
> existing names have to be overloaded, at the cost of obfuscating
> the interface.

shares file can accomodate these. But, for bigger configuration we 
have to use some file based interface.

> 
> The kernel hooks for cpusets are fewer, simpler and more specific
> than those for CKRM.  Our high performance customers would want
> the cpuset hooks compiled in, not the more generic ones for
> CKRM (which they could not easily use for any other workload
> management purpose anyway, if the task class hierarchy were
> hijacked for the needs of cpusets, as noted above).
> 
> The development costs of cpusets so far, which are perhaps the
> best predictor we have of future costs, have been substantially
> lower than they have been for CKRM.

I think you have to compare the developmental cost of a resource 
controller providing cpusetfunctionality and not ckrm itself.
> 
> In sum, your proposal costs alot more than cpusets, by a variety
> of metrics.
> 
> =================================================
> 
> In summary, I find that your cpuset/memset CKRM proposal provides
> little or no benefit past the simpler cpu and memory placement
> calls already available, while costing substantially more in
> a variety of ways than my cpuset proposal, when evaluated for
> its usefulness for numa placement.
> 
> (Of course, if evaluated for suitability for workload management,
> the table is turned, and your CKRM patch provides essential
> capability that my cpuset patch could never dream of doing.)
> 
> Moreover, the additional workload management benefits that your
> CKRM facility provides, and that some of my customers might
> want to use in combination with numa placement, would probably
> become unavailable to them if we integrated cpusets and CKRM,
> because cpusets would have to hijack the task class hierarchy
> for its own nefarious purposes.
> 
> Such an attempt to integrate cpusets and CKRM would be a major
> setback for cpusets, substantially increasing its costs and
> reducing is value, probably well past the point of it even being
> worth persuing further, in the mainstream kernel.  Adding all
> that foreign logic of cpusets to the CKRM patch probably
> wouldn't help CKRM much either.  The CKRM patch is already one
> that requires a bright mind and some careful thought to master.

If one reads the design and then looks at the broken down patches,
it may not be hard.

> Adding cpuset numa placement logic, which is typically different
> in detail, would add a complexity burden to the CKRM code that
> would serve no one well.
> 
> 
> > Note that I am not pitching for a marriage
> 
> We agree.
> 
> I just took more words to say it ').

The reasons we quote also are very different though. I meant that it
won't be a happy, productive marriage.

But, I infer that you are suggesting their species itself are
different, which I do not agree.

chandra
PS to everyone else: Wow, you have lot of patience :)
> 
> 
> 
> -- 
>                   I won't rest till it's the best ...
>                   Programmer, Linux Scalability
>                   Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
> 
