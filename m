Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265902AbTGADLb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 23:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265881AbTGADLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 23:11:31 -0400
Received: from holomorphy.com ([66.224.33.161]:3500 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265902AbTGADLV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 23:11:21 -0400
Date: Mon, 30 Jun 2003 20:25:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
Message-ID: <20030701032531.GC20413@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, Mel Gorman <mel@csn.ul.ie>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53.0307010238210.22576@skynet> <20030701022516.GL3040@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030701022516.GL3040@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 01, 2003 at 02:39:47AM +0100, Mel Gorman wrote:
>>    Reverse Page Table Mapping
>>    ==========================
>>    One of the most important introductions in the 2.6 kernel is Reverse
>>    Mapping commonly referred to as rmap. In 2.4, there is a one way mapping
>>    from a PTE to a struct page which is sufficient for process addressing.
>>    However, this presents a problem for the page replacement algorithm when
>>    dealing with shared pages are used as there is no way in 2.4 to acquire a

On Tue, Jul 01, 2003 at 04:25:16AM +0200, Andrea Arcangeli wrote:
> you mention only the positive things, and never the fact that's the most
> hurting piece of kernel code in terms of performance and smp scalability
> until you actually have to swapout or pageout.

Both of those are inaccurate.

(a) performance
	This is not one-sided. Pagetable setup and teardown has higher
	overhead with the pte-based methods. The largest gain is from
	being able to atomically unmap pages. The overhead is generally
	from the atomic operations involved with the pagewise locking.
	This is generally not an issue for major workloads as process
	creation and destruction is not heavily exercised by any but
	the most naive applications. No lock contention arises as a
	result of the pte_chains, but there are single-threaded cpu
	costs arising from the atomic operations for pagewise locking.

	Work has been done and is still being done to reduce the number
	of atomic operations required to manipulate pages' mapping
	metadata, by me and others, including Hugh Dickins, Andrew
	Morton, Martin Bligh, and Dave McCracken. In some of my newer
	patches I've been experimenting with RCU as a method for
	reducing the number of atomic operations required to establish
	a page's mappings.

	The aspect of performance this benefits is pageout and minor
	faults. When page replacement happens, it's no longer a
	catastrophe. LRU scanning also does not unmap pages that aren't
	specifically targeted for eviction, which reduces the number of
	minor faults incurred. Both of these are benefits targeted
	primarily at smaller machines, as, of course, larger machines
	rarely ever do page replacement apart from some slow turnover
	of unmapped cached file contents.

(b) SMP scalability
	There are scalability issues, but they have absolutely nothing
	to do with SMP or locking. The largest such issue is the
	resource scalability issue on PAE. There are several long-
	suffering patches with various amounts of work being put into
	them that are trying to address this, by the same authors as
	above. They are largely effective.


On Tue, Jul 01, 2003 at 02:39:47AM +0100, Mel Gorman wrote:
>>    Non-Linear Populating of Virtual Areas
>>    ======================================
>>    In 2.4, a VMA backed by a file would be populated in a linear fashion.
>>    This can be optionally changed in 2.6 with the introduction of the
>>    MAP_POPULATE flag to mmap() and the new system call remap_file_pages().
>>    This system call allows arbitrary pages in an existing VMA to be remapped
>>    to an arbitrary location on the backing file. This is mainly of interest
>>    to database servers which previously simulated this behavior by the
>>    creation of many VMAs.
>>    On page-out, the non-linear address for the file is encoded within the PTE
>>    so that it can be installed again correctly on page fault. How it is
>>    encoded is architecture specific so two macros are defined called
>>    pgoff_to_pte() and pte_to_pgoff() for the task.

On Tue, Jul 01, 2003 at 04:25:16AM +0200, Andrea Arcangeli wrote:
> and it was used to break truncate, furthmore the API doesn't look good
> to me, the vma should have a special VM_NONLINEAR created with a
> MAP_NONLINEAR so the vm will skip it enterely and it should be possible
> to put multiple files in the same vma IMHO. If these areas are
> vmtruncated the VM_NONLINEAR will keep vmtruncate out of them and the
> pages will become anonymous, which is perfectly fine since they're
> created with a special MAP_NONLINEAR that can have different semantics.

Well, the truncate() breakage is just a bug that I guess we'll have to
clean up soon to get rid of criticisms like this. Tagging the vma for
exhaustive search during truncate() when it's touched by
remap_file_pages() sounds like a plausible fix.


On Tue, Jul 01, 2003 at 04:25:16AM +0200, Andrea Arcangeli wrote:
> Also this feature is mainly useful only in kernels with rmap while using
> the VLM, to workaround the otherwise overkill cpu and memory overhead
> generated by rmap. It is discouraged to use it as a default API unless
> you fall into those special corner cases. the object of this API is to
> bypass the VM so you would lose security and the VM advantages. if you
> want the same features you have w/o nonlinaer w/ nonlinear, then you
> invalidate the whole point of nonlinear.
> The other very corner cases are emulators, they also could benefit from
> a VM bypass like remap_file_pags provides.
> Pinning ram from multiple files plus a sysctl or a sudo wrapper would be
> an optimal API and it would avoid the VM to even look at the pagetables
> of those areas.

IMHO mlock() should be the VM bypass, and refrain from creating
metadata like pte_chains or buffer_heads. Some additional but not very
complex mechanics appear to be required to do this. The emulator case
is precisely the one which would like to use remap_file_pages() with
all the VM metadata attached, as they often prefer to not run with
elevated privileges as required by mlock(), and may in fact be using
data sets larger than RAM despite the slowness thereof. The immediate
application I see is for bochs to emulate highmem on smaller machines.


On Tue, Jul 01, 2003 at 04:25:16AM +0200, Andrea Arcangeli wrote:
> Last but not the least, remap_file_pages is nearly useless (again modulo
> emulators) w/o bigpages support backing it (not yet the case in 2.5 as
> far as I can see so it's unusable compared to 2.4-aa [but 2.5 -
> remap_file_pages is even less usable than 2.5 + remap_file_pages due
> rmap that wouldn't only run slow but it wouldn't run at all]). objrmap
> fixes that despites it introduces some complex algorithm.
> the only significant cost is the tlb flushing and pagetable walking at
> 32G of working set in cache with a 30-31bit window on the cache. 

This is wildly inaccurate. Highly complex mappings rarely fall upon
boundaries suitable for large TLB entries apart from on architectures
(saner than x86) with things like 32KB TLB entry sizes. The only
overhead there is to be saved is metadata (i.e. space conservation)
like buffer_heads and pte_chains, which can just as easily be done with
proper mlock() bypasses.

Basically, this is for the buffer pool, not the shared segment, and
so it can't use large tlb entries anyway on account of the granularity.
The shared segment could very easily use hugetlb as-is without issue.

Mixed-mode hugetlb has been requested various times. I would much
prefer to address the creation, destruction, and space overheads of
normal mappings and implement fully implicit large TLB entry
utilization than implement such.


On Tue, Jul 01, 2003 at 02:39:47AM +0100, Mel Gorman wrote:
>>    Delayed Coalescing
>>    ==================
>>    2.6 extends the buddy algorithm to resemble a lazy buddy algorithm [BL89]
>>    which delays the splitting and coalescing of buddies until it is
>>    necessary. The delay is implemented only for 0 order allocations with the

On Tue, Jul 01, 2003 at 04:25:16AM +0200, Andrea Arcangeli wrote:
> desribed this way it sounds like it's not O(1) anymore for order > 0
> allocations. Though it would be a nice feature for all the common cases.
> And of course it's still O(1) if one assumes the number of orders
> limited (and it's fixed at compile time).
> as for the per-zone lists, sure they increase scalability, but it loses
> aging information, the worst case will be reproducible on a 1.6G box,
> some day even 2.3 had per-zone lists, I backed it out to avoid losing
> information which is an order of magnitude more interesting than
> the pure smp scalability for normal users (i.e. 2-way systems with 1-2G
> of ram, of course the scalability numbers that people cares about on the
> 8-way with 32G of ram will be much better with the per-zone lru).
> Just trying not to forget the other side too ;) Not every improvement on
> one side cames for free on all other sides.

The per-zone LRU lists are not related to SMP scalability either. They
are for:
(a) node locality
	So a node's kswapd or processes doing try_to_free_pages() only
	references struct pages on the local nodes.
(b) segregating the search space for page replacement
	So the search for ZONE_NORMAL or ZONE_DMA pages doesn't scan
	the known universe hunting for a needle in a haystack and spend
	24+ hours doing so.

Lock contention was addressed differently, by amortizing the lock
acquisitions using the pagevec infrastructure. In general the
global aging and/or queue ordering information has not been found to be
particularly valuable, or at least no one's complaining that they miss it.


-- wli
