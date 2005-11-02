Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932603AbVKBMit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932603AbVKBMit (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 07:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932672AbVKBMit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 07:38:49 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:46245 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932603AbVKBMis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 07:38:48 -0500
Date: Wed, 2 Nov 2005 12:38:38 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Dave Hansen <haveblue@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19 - Summary
In-Reply-To: <43680D8C.5080500@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0511021231440.5235@skynet>
References: <20051030235440.6938a0e9.akpm@osdl.org>  <27700000.1130769270@[10.10.2.4]>
 <4366A8D1.7020507@yahoo.com.au>  <Pine.LNX.4.58.0510312333240.29390@skynet>
 <4366C559.5090504@yahoo.com.au>  <Pine.LNX.4.58.0511010137020.29390@skynet>
 <4366D469.2010202@yahoo.com.au>  <Pine.LNX.4.58.0511011014060.14884@skynet>
 <20051101135651.GA8502@elte.hu>  <1130854224.14475.60.camel@localhost> 
 <20051101142959.GA9272@elte.hu> <1130856555.14475.77.camel@localhost>
 <43680D8C.5080500@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2005, Nick Piggin wrote:

> Dave Hansen wrote:
>
> > What the fragmentation patches _can_ give us is the ability to have 100%
> > success in removing certain areas: the "user-reclaimable" areas
> > referenced in the patch.  This gives a customer at least the ability to
> > plan for how dynamically reconfigurable a system should be.
> >
>
> But the "user-reclaimable" areas can still be taken over by other
> areas which become fragmented.
>

This is true, we have worst case scenarios. With our patches though, our
assertion it takes a lot longer to degrade and in good scenarios like
where the workload is not using all of physical memory, we don't degrade
at all.  Assuming we get a page migration or active defragmentation in the
future, it will be a lot longer before they have to do any work. As we
only fragment when there is nothing else to do, page migration will also
have less work to do.

> That's like saying we can already guarantee 100% success in removing
> areas that are unfragmented and free, or freeable.
>
> > After these patches, the next logical steps are to increase the
> > knowledge that the slabs have about fragmentation, and to teach some of
> > the shrinkers about fragmentation.
> >
>
> I don't like all this work and complexity and overheads going into a
> partial solution.
>
> Look: if you have to guarantee memory can be shrunk, set aside a zone
> for it (that only fills with user reclaimable areas). This is better
> than the current frag patches because it will give you the 100%
> guarantee that you need (provided we have page migration to move mlocked
> pages).
>
> If you don't need a guarantee, then our current, simple system does the
> job perfectly.
>

Ok. To me, the rest of the thread are beating around the same points and
no one is giving ground. The points are made so lets summarise. Apologies
if anything is missing.

Problem
=======

Memory gets fragmented meaning that contiguous blocks of memory are not
free and not freeable no matter how much kswapd works

Impact
======
A number of different users are hit, in different ways
  Physical Hotplug remove: Hotplug remove needs to be able to free a large
	region of memory that is then unplugged. Different architectures have
	different ways of doing this
  Virtualization hotplug remove: The requirements are lighter here.
	Contiguous Regions from 1MiB to 64MiB (figure taken from thread)
	must be freed to move the memory between virtual machines
  High order allocations: With fragmentation, high order allocations fail.
	Depending on the workload, kswapd could work forever and not free up a
	4MiB chunk

Who cares
=========
  Physical hotplug remove: Vendors of the hardware that support this -
	Fujitsu, HP (I think), IBM etc

  Virtualization hotplug remove: Sellers of virtualization software, some
	hardware like any IBM machine that lists LPAR in it's list of
	features.  Probably software solutions like Xen are also affected
	if they want to be able to grow and shrink the virtual machines on
	demand

  High order allocations: Ultimately, hugepage users. Today, that is a
	feature only big server users like Oracle care about. In the
	future I reckon applications will be able to use them for things
	like backing the heap by huge pages. Other users like GigE,
	loopback devices with large MTUs, some filesystem like CIFS are
	all interested although they are also been told use use smaller
	pages.

Solutions
=========

Anti-defrag: This solution defines three groups of pages KernNoRclm,
	KernRclm and EasyRclm. Small sub-zone regions of size
	2^(MAX_ORDER-1) are reserved for each allocation type. If there
	are no large blocks available and no reserved pages available, it
	falls back and begins to fragment. This tries to delay
	fragmentation for as long as possible

New Zone: Add a new zone for easyrclm only allocations. This means that
	all kernel pages go in one place and all easyrclm go in another.
	This solution would allow us to reclaim contiguous blocks of
	(Note: This is basically what Solaris Kernel Cages are)

Note that I am leaving out Growing/Shrinking zone code for the moment.
While zones are currently able to get new pages with something like memory
hotadd, there is no mechanism available to move existing pages from one
zone into another. This will need planning and code. Code exists for page
migration so we can reasonable speculate about what it brings to the table
for both anti-defrag and New Zone approaches.

Pros/Cons of Solutions
======================

Anti-defrag Pros
  o Aim9 shows no significant regressions (.37% on page_test). On some
    tests, it shows performance gains (> 5% on fork_test)
  o Stress tests show that it manages to keep fragmentation down to a far
    lower level even without teaching kswapd how to linear reclaim
  o Stress tests with a linear reclaim experimental patch shows that it
    can successfully find large contiguous chunks of memory
  o It is known to help hotplug on PPC64
  o No tunables. The approach tries to manage itself as much as possible
  o It exists, heavily tested, and synced against the latest -mm1
  o Can be compiled away be redefining the RCLM_* macros and the
    __GFP_*RCLM flags

Anti-defrag Cons
  o More complexity within the page allocator
  o Adds a new layer onto the allocator that effectively creates subzones
  o Adding a new concept that maintainers have to work with
  o Depending on the workload, it fragments anyway

New Zone Pros
  o Zones are a well known and understood concept
  o For people that do not care about hotplug, they can easily get rid of it
  o Provides reliable areas of contiguous groups that can be freed for
    HugeTLB pages going to userspace
  o Uses existing zone infrastructure for balancing

New Zone Cons
  o Zones historically have introduced balancing problems
  o Been tried for hotplug and dropped because of being awkward to work with
  o It only helps hotplug and potentially HugeTLB pages for userspace
  o Tunable required. If you get it wrong, the system suffers a lot
  o Needs to be planned for and developed

Scenarios
=========

Lets outline some situations then or workloads that can occur

1. Heavy job running that consumes 75% of physical memory. Like a kernel
   build

  Anti-defrag: It will not fragment as it will never have to fallback.High
	order allocations will be possible in the remaining 25%.
  Zone-based: After been tuned to a kernel build load, it will not
	fragment. Get the tuning wrong, performance suffers or workload
	fails. High order allocations will be possible in the remaining 25%.

  Future work for scenario 1
    Anti-defrag: No problem.
    Zone-based: Tune some more if problems occur.

2. Heavy job running that needs 110% of physical memory, swap is used.
  	Example would be too many simultaneous kernel builds
  Anti-defrag: UserRclm regions are stolen to prevent too many fallbacks.
	KernNoRclm starts stealing UserRclm regions to avoid excessive
	fragmentation but some fragmentation occurs. Extent depends on the
	duration and heaviness of the load. High order allocations will
	work if kswapd runs for long enough as it will reclaim the
	UserRclm reserved areas. Your chances depend on the intensity of
	KernNoRclm allocations

  Zone-based: After been tuned to the new kernel build load, it will not
	fragment. Get it wrong and performance suffers. High order
	allocations will work if you're lucky enough to have enough
	reclaimable pages together. Your chances are not good

  Future work for scenario 2
    Anti-defrag: kswapd would need to know how to reclaim EasyRclm pages
	from the KernNoRclm, KernRclm and Fallback areas.
    Zone-based: Keep tuning

3. HighMem intensive workload with CONFIG_HIGHPTE set. Example would be a
	scientific job that was performing a very large calculation on an
	anonymous region of memory. Possible that some desktop
	workloads are like this - i.e. use large amounts of anonymous
	memory

  Anti-defrag: For ZONE_HIGHMEM, PTEs are grouped into one area,
	everything else into another, no fragmentation. HugeTLB
	allocations in ZONE_HIGHMEM will work if kswapd works long enough
  Zone-based: PTEs go to anywhere in ZONE_HIGHMEM. Easy-reclaimed goes to
	ZONE_HIGHMEM and ZONE_HOTREMOVABLE. ZONE_HIGHMEM fragments,
	ZONE_HOTREMOVABLE does not. HugeTLB pages will be available in
	ZONE_HOTREMOVABLE, but probably not in ZONE_HIGHMEM.

  Future work for scenario 3
    Anti-defrag: No problem. On-demand HugeTLB allocation for userspace is
	possible. Would work better with linear page reclaim.
    Zone-based: Depends if we care that ZONE_HIGHMEM gets fragmented. We
	would only care if trying to allocate HugeTLB pages on demand from
	ZONE_HIGHMEM. ZONE_HOTREMOVABLE depending on it's size would be
	possible. Linear reclaim will help ZONE_HOTREMOVABLE, but not
	ZONE_HIGHMEM

4. KBuild. Main concerns here are performance
  Anti-defrag: May cause problems because of the .37% drop on page_test.
	May cause improvements because of the 5% increase on fork_test. No
	figures on kbuild available
  Zone-based: No figures available. Depends heavily on being configured
	correctly

  Future work for scenario 4
    Anti-defrag: Try and optimise the paths affected. Alternatively make
	anti-defrag a configurable option by altering the values of RCLM_*
	and __GFP_*RCLM. (Note, would people be interested in a
	compile-time option for anti-defrag or would it make the complexity
	worse for people?)
    Zone-based: Tune for performance or compile away the zone

5. Physically unplug memory 25% of physical memory

  Anti-defrag: Memory in the region gets reclaimed if it's EasyRclm.
	Possibly will encounter awkward pages. Known that PPC64 has some
	success. Fujitsu's use nodes for hotplug, they would need to
	adjust the fallbacks to be fully reliable
  Zone-based: If we are unplugging the right zone, reclaim the pages.
	Possibly will encounter awkward pages (only mlock in this case)

  Future work for scenario 5
    Anti-defrag: fallback_allocs for each node for Fujitsu to be any way
	reliable. Ability to move awkward pages around. For 100% success,
	ability to move kernel pages
    Zone-based: Ability to move awkward pages around. There is no 100%
	success scenario here. You remove the ZONE_HOTREMOVEABLE area or
	you turn the machine off.

6. Fsck a large filesystem (known to be a KernNoRclm heavy workload)

  Anti-defrag: Memory fragments, but fsck is a short-lived kernel heavy
	workload. It is also known that free blocks reappear through the
	address space when it finishes. Contiguous blocks may appear in
	the middle of the zone rather than either end.
  Zone-based: If misconfigured, performance degrades. As a machine will
	not be tuned for fsck, changes of degrading are pretty high. On
	the other hand, fsck is something people can wait for

  Future work for scenario 6
    Anti-defrag: Ideally, in case of fallbacks, page migration would move
	awkward pages out of UserRclm areas
    Zone-based: Keep tuning if you run into problems

Lets say we agree on a way that ZONE_HOTREMOVABLE can be shrunk in such a
way to give pages to ZONE_NORMAL and ZONE_HIGHMEM as necessary (and we
have to be able to handle both), Situation 2 and 6 changes. Note that this
changing of zones sizes brings all the problems from the anti-defrag
approach to the zone-based approach.

2a. Heavy job running that needs 110% of physical memory, swap is used.
  Anti-defrag: UserRclm regions are stolen to prevent too many fallbacks.
	KernNoRclm starts stealing UserRclm regions to avoid excessive
	fragmentation but some fragmentation occurs. Extent depends on the
	duration and heaviness of the load.
  Zone-based: ZONE_NORMAL grows into ZONE_HOTREMOVALE. The zone cannot be
	shrunk so ZONE_NORMAL fragments as normal.

  Future work for scenario 2a
    Anti-defrag: kswapd would need to know how to clean EasyRclm pages
	from the KernNoRclm, KernRclm and Fallback reserved areas. When
	load drops off, regions will get reserved again for EasyRclm.
	Contiguous blocks will become whenever possible be it the
	beginning, middle or end of the zone. Page migration would help
	fix up single kernel pages left in EasyRclm areas.
    Zone-based: Page migration would need to move pages from the end of
	the zone so it could be shrunk.

6a. Fsck
    Anti-defrag: Memory fragments, but fsck is a short-lived kernel heavy
	workload. It is also known that free blocks reappear through the
	address space when it finishes. Once the free blocks appear, they
	get reserved for the different allocation types on demand and
	business continues as usual
    Zone-based: ZONE_NORMAL grows into ZONE_HOTREMOVABLE. No mechanism to
	shrink it so it doesn't recover

  Future work for scenario 2a

    Anti-defrag: Same as for Situation 2. kswapd would need to know how to
	clean UserRclm pages from the KernNoRclm, KernRclm and Fallback
	reserved areas.
    Zone-based: Same as for 2a. Page migration would need to move pages
	from the end of the zone so it could be shrunk

I've tried to be as objective as possible with the summary.

>From the points above though, I think that anti-defrag gets us a lot of
the way, with the complexity isolated in one place. It's downside is that
it can still break down and future work is needed to stop it degrading
(kswapd cleaning UserRclm areas and page migration when we get really
stuck). Zone-based is more reliable but only addresses a limited
situation, principally hotplug and it does not even go 100% of the way for
hotplug. It also depends on a tunable which is not cool and it is static.
If we make the zones growable+shrinkable, we run into all the same
problems that anti-defrag has today.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab

