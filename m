Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbVDSF4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVDSF4a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 01:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVDSF4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 01:56:30 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:11678 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261331AbVDSFzh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 01:55:37 -0400
Date: Mon, 18 Apr 2005 22:54:27 -0700
From: Paul Jackson <pj@sgi.com>
To: dino@in.ibm.com
Cc: Simon.Derr@bull.net, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, akpm@osdl.org, dipankar@in.ibm.com,
       colpatch@us.ibm.com
Subject: Re: [RFC PATCH] Dynamic sched domains aka Isolated cpusets
Message-Id: <20050418225427.429accd5.pj@sgi.com>
In-Reply-To: <20050418202644.GA5772@in.ibm.com>
References: <1097110266.4907.187.camel@arrakis>
	<20050418202644.GA5772@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm ... interesting patch.  My reaction to the changes in
kernel/cpuset.c are complicated:

 * I'm supposed to be on vacation the rest of this month,
   so trying (entirely unsuccessfully so far) not to think
   about this.
 * This is perhaps the first non-trivial cpuset patch to come
   in the last many months from someone other than Simon or
   myself - welcome.
 * Some coding style and comment details will need working.
 * The conceptual model for how to represent this in cpusets
   needs some work.

Let me do two things in this reply.  First I'll just shoot off
shotgun style the nit picking coding and comment details that
I notice, in a scan of the patch.  Then I will step back to a
discussion of the conceptual model.  I suspect that by the time
we nail the conceptual model, the code will be sufficiently
rewritten that most of the coding and comment nits will no
longer apply anyway.

But, since nit picking is easier than real thinking ...

 * I'd probably ditch the all_cpus() macro, on the
   concern that it obfuscates more than it helps.
 * The need for _both_ a per-cpuset flag 'CS_CPU_ISOLATED'
   and another per-cpuset mask 'isolated_map' concerns me.
   I guess that the isolated_map is just a cache of the
   set of CPUs isolated in child cpusets, not an independently
   settable mask, but it needs to be clearly marked as such
   if so.
 * Some code lines go past column 80.
 * The name 'isolated'  probably won't work.  There is already
   a boottime option "isolcpus=..." for 'isolated' cpus which
   is (I think ?) rather different.  Perhaps a better name will
   fall out of the conceptual discussion, below.
 * The change to the output format of the special cpuset file
   'cpus', to look like '0-3[4-7]' bothers me in a couple of
   ways.  It complicates the format from being a simple list.
   And it means that the output format is not the same as the
   input format (you can't just write back what you read from
   such a file anymore).
 * Several comments start with the word 'Set', as in:
 	Set isolated ON on a non exclusive cpuset
   Such wording suggests to me that something is being set,
   some bit or value changed or turned on.  But in each case,
   you are just testing for some condition that will return
   or error out.  Some phrasing such as "If ..." or other
   conditional would be clearer.
 * The update_sched_domains() routine is complicated, and
   hence a primary clue that the conceptual model is not
   clean yet.
 * None of this was explained in Documentation/cpusets.txt.
 * Too bad that cpuset_common_file_write() has to have special
   logic for this isolated case.  The other flag settings just
   turn on and off the associated bit, and don't trigger any
   kernel code to adapt to new cpu or memory settings.  We
   should make an exception to that behaviour only if we must,
   and then we must be explicit about the exception.

Ok - enough nits.

Now, onto the real stuff.

This same issue, in a strange way, comes up on the memory side,
as well as on the cpu side.

First, let me verify one thing.  I understand that the _key_
purpose of your patch is not so much to isolate cpus, as it
is to allow for structuring scheduling domains to align with
cpuset boundaries.  I understand real isolated cpus to be ones
that don't have a scheduling domain (have only the dummy one),
as requested by the "isolcpus=..." boot flag.

The following code snippet from kernel/sched.c is what I derive
this understanding from:

===
static void __devinit arch_init_sched_domains(void)
{
        ...
        /*
         * Setup mask for cpus without special case scheduling requirements.
         * For now this just excludes isolated cpus, but could be used to
         * exclude other special cases in the future.
         */
        cpus_complement(cpu_default_map, cpu_isolated_map);
        cpus_and(cpu_default_map, cpu_default_map, cpu_online_map);

        /*
         * Set up domains. Isolated domains just stay on the dummy domain.
         */
        for_each_cpu_mask(i, cpu_default_map) {
		...
===

Second, let me describe how this same issue shows up on the
memory side.

    Let's say, for example, someone has partitioned a large
    system (100's of cpus and nodes) in two major halves
    using cpusets, each half being used by a different
    organization.

    On one of the halves, they are running a large scientific
    program that works on a huge data set that just fits in
    the memory available on that half, and they are running
    a set of related tools that run different passes over
    that data.

    Some of these tools might take several cpus, running
    parallel threads, and using a little more data shared
    by the threads in that tool.  Each of these tools might
    get its own cpuset, a child (subset) of the big cpuset
    that defines the half of the system that this large
    scientific program is running within.

    The big dataset has to be constrained to the big cpuset
    (that half of the system).  The smaller tools have to
    be constrained to their child cpusets, both for memory
    and scheduling.

    The individual threads of a tool should probably be
    placed using the set_mempolicy and sched_setaffinity
    calls, from within the tool.  But the tool placement
    typically needs to be done from the outside, which
    placement cpusets handles better.
    
    This results in some 'memory domains', which are
    larger than a leaf node cpuset, smaller than the
    entire system, and which will constrain some memory
    allocations.  In this example, the half of the
    system holding the big data set is a memory domain.
    
    These 'memory domains' can be naturally defined by
    the memory nodes contained in selected cpusets.

===

Looking at this mathematically, as a hierarchy of nested sets
and subsets, I think we have the same problem, on both the cpu
and memory side.

In both cases, we have an intermediate degree of partitioning
of a system, neither at the most detailed leaf cpuset, nor at
the all encompassing top cpuset.  And in both cases, we want
to partition the system, along cpuset boundaries.

Here I use "partition" in the mathematical sense:

===============================================================
A partition of a set X is a set of nonempty subsets of X such
that every element x in X is in exactly one of these subsets.

Equivalently, a set P of subsets of X, is a partition of X if

1. No element of P is empty.
2. The union of the elements of P is equal to X. (We say the
   elements of P cover X.)
3. The intersection of any two elements of P is empty. (We say
   the elements of P are pairwise disjoint.)

http://www.absoluteastronomy.com/encyclopedia/p/pa/partition_of_a_set.htm
===============================================================

In the case of cpus, we really do prefer the partitions to be
disjoint, because it would be better not to confuse the domain
scheduler with overlapping domains.

In the case of memory, we technically probably don't _have_ to
keep the partitions disjoint.  I doubt that the page allocator
(mm/page_alloc.c:__alloc_pages()) really cares.  It will strive
valiantly to satisfy the memory request from any of the zones
(each node specific) in the list passed into it.

But for the purposes of providing a clear conceptual model to
our users, I think it is best that we impose this constraint on
the memory side as well as on the cpu side.  And I don't think
it will deprive users of any useful configuration alternatives
that they will really miss.  Indeed, the typical user will be
striving to use this mechanism to separate different demands
for memory - to isolate them on to different nodes in your
sense of the word isolate.

So, what we want, I claim, is two partitions of the system.

 1) A partition of cpus.
 2) A partition of memory nodes.
 
I mean 'partition' in the above mathematical sense, with the
one additional constraint:

 * Each subset in both these partitions corresponds to
   some cpuset.

That is, for the partition of cpus, for each subset of the
partition, there is a cpuset having the exactly the same cpus
as that subset, no more, no less.

Similary, for the partition of memory nodes.

At any point in time, there would be exactly one such
partitioning of cpus, and one of memory nodes, on the system.

For the cpu case, we would provide a scheduler domain for each
subset of the cpu partitioning.

For the memory case, we would constrain a given allocation
request to either the current tasks cpuset, or to the containing
subset of the memory node partition, depending on per-cpuset
options which will need to be developed in future patches
that will enable marking either GFP_KERNEL allocations, or
allocations for a named shared memory region (mapped file or
such, not anonymous) to be constrained not by the current tasks
cpuset, but by the encompassing subset of the current partition
of memory nodes - (2) above.

Observe that:

* We can specify whether a given cpusets cpus define one of the
  subsets of the systems partitioning of cpus, in (1) above,
  using a per-cpuset boolean flag.

* We can similarly specify whether a given cpusets memory nodes
  define one of the subsets of the systems partitioning of memory
  nodes, in (2) above, using one more per-cpuset boolean flag.

* We cannot however do all this correctly just manipulating each
  cpuset in isolation, with per-cpuset atomic operations.  Or
  at least it _seems_ that we cannot do this.  Keep reading;
  I will find a way.

As you discovered in some of the more complex code in your
update_sched_domains() method, we are dealing with system
wide properties here.  The above mathematical properties of a
partition must be followed.  If we only have atomic operations on
individual cpusets, then it would _seem_ that more or less any
possible change in the partition subsets will require that we
go through an intermediate state that is illegal.  For example,
to move a cpu from one subset to another, it would seem that
we must pass through an intermediate state where it is either
in both subsets, or in neither.

So we require a way for the user to tell us which of the several
cpusets in the system define the current partitioning of cpus,
as will be used to determine scheduler domains, and we require
a way for the user to tell us which of the several cpusets in
the system define the current partitioning of memory nodes,
as will be used to determine where specified memory allocations
will be constrained, when they are allowed to escape the cpuset
of the allocating task.

In both these cases, we must handle the case that the user
didn't follow the properties of a partition (perhaps the subsets
overlap, or don't cover), and return an error without making
a change.

In both of these cases, the user must pass in a selection of
cpusets, some specified subset of all the cpusets on a system,
which the user wants to define the partition of the cpus or
memory nodes on the system, henceforth.

Well, not actually system wide.  If the user has rights to modify
some existing cpuset Foo in the system, and if the current cpu or
memory partition of the system exactly aligns with that cpuset
Foo (all subsets of the current cpu or memory partition of the
system are either entirely within, or entirely outside) then the
user could be allowed to redefine the partition subsets within
Foo to another that also aligned with Foo.  Perhaps the user
could choose two child cpusets of Foo to define the partitions
subsets, and then later revert to having just the cpuset Foo
define them.

This leads to a possible interface.  For each of cpus and
memory, add four per-cpuset control files.  Let me take the
cpu case first.

Add the per-cpuset control files:
  * domain_cpu_current 		# readonly boolean
  * domain_cpu_pending		# read/write boolean
  * domain_cpu_rebuild		# write only trigger
  * domain_cpu_error		# read only - last error msg
  
To rebuild the cpu partitioning below a given cpuset Foo,
the user would:
  1) Write 0 or 1 to the domain_cpu_pending file of
     each cpuset Foo and below, so that just the cpusets
     whose cpus were desired to define the partition
     subsets (and hence have dedicated scheduler domains)
     had the value '1' in this file.
  2) Write a 1 to the domain_cpu_rebuild trigger file
     of cpuset Foo.
  3) If the write succeeded, the scheduler domains within
     the set of cpus in Foo were rebuilt, at that time.
  4) If the write failed, read the domain_cpu_error file
     for an explanation.

If cpuset Foo aligns with the current system cpu partition, and
if the cpus of the cpusets marked domain_cpu_pending below Foo
define a proper partition of the cpus in Foo, then the write
will succeed, updating the values of the domain_cpu_current
control files for Foo and below to the values that were in
the domain_cpu_pending files, and provoking a rebuild of the
scheduler domains below Foo.

Otherwise the write will fail, and an error message explaining
the problem made available in domain_cpu_error for subsequent
reading.  Just setting errno would be insufficient in this
case, as the possible reasons for error are too complex to be
adequately described that way.

Similarly for memory, add the per-cpuset control files:
  * domain_mem_current		# readonly boolean
  * domain_mem_pending		# read/write boolean
  * domain_mem_rebuild		# write only trigger
  * domain_mem_error		# read only - last error msg

Note, as a detail, that there is no interaction of this domain
feature with the cpu_exclusive or mem_exclusive feature.
This is good.  The exclusive feature is of narrow usefulness,
and attempting to integrate it into this domain feature will
cause more grief than benefit.

Also note that adding or removing a cpu from a cpuset that has
its domain_cpu_current flag set true must fail, and similarly
for domain_mem_current.

There are likely (hopefully ;) other possible API's that
accomplish the same thing.  But in the process of describing
this API, I hope I have touched on some of the properties that
cpuset domains for cpu and memory should have.

The above scheme should significantly reduce the number of
special cases in the update_sched_domains() routine (which I
would rename to update_cpu_domains, alongside another one to be
provided later, update_mem_domains.)  These new update routines
will verify that all the preconditions are met, tear down all
the cpu or mem domains within the scope of the specified cpuset,
and rebuild them according to the partition defined by the
pending_*_domain flags on the descendent cpusets.  It's the
same complete rebuild of the partitioning of some subtree,
each time, without all the special cases for incrementally
adding and removing cpus or mems from this or that.  Complex
nested if-else-if-else logic is a breeding ground for bugs --
good riddance.

As stated above, there is a single system wide partition of
cpus, and another of mems.  I suspect we should consider finding
a way to nest partitions.  My (shakey) understanding of what
Nick is doing with scheduler domains is that for the biggest of
systems, we will probably want little scheduler domains inside
bigger ones.

However, if we thought we could avoid, or at least delay
consideration of nested partitions, that would be nice.
This thing is already abstract enough to puzzle many users,
without adding that elaboration.

There -- what do you think of this alternative?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
