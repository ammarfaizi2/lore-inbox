Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265856AbTGAEZX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 00:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265938AbTGAEZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 00:25:23 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:47488
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265856AbTGAEZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 00:25:06 -0400
Date: Tue, 1 Jul 2003 06:39:02 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
Message-ID: <20030701043902.GP3040@dualathlon.random>
References: <Pine.LNX.4.53.0307010238210.22576@skynet> <20030701022516.GL3040@dualathlon.random> <20030701032531.GC20413@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030701032531.GC20413@holomorphy.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 30, 2003 at 08:25:31PM -0700, William Lee Irwin III wrote:
> On Tue, Jul 01, 2003 at 02:39:47AM +0100, Mel Gorman wrote:
> >>    Reverse Page Table Mapping
> >>    ==========================
> >>    One of the most important introductions in the 2.6 kernel is Reverse
> >>    Mapping commonly referred to as rmap. In 2.4, there is a one way mapping
> >>    from a PTE to a struct page which is sufficient for process addressing.
> >>    However, this presents a problem for the page replacement algorithm when
> >>    dealing with shared pages are used as there is no way in 2.4 to acquire a
> 
> On Tue, Jul 01, 2003 at 04:25:16AM +0200, Andrea Arcangeli wrote:
> > you mention only the positive things, and never the fact that's the most
> > hurting piece of kernel code in terms of performance and smp scalability
> > until you actually have to swapout or pageout.
> 
> Both of those are inaccurate.
> 
> (a) performance
> 	This is not one-sided. Pagetable setup and teardown has higher
> 	overhead with the pte-based methods. The largest gain is from

I said "until you actually have to swapout or pageout". I very much that
you're right and that pagetable teardown has higher overhead with the
pte-based methods.  If you were wrong about it rmap would be a total
waste on all sides, not just one.

I'm talking about the other side only (which is the one I want to run
fast on my machines).

> 	being able to atomically unmap pages. The overhead is generally
> 	from the atomic operations involved with the pagewise locking.

which is a scalability cost. Those so called atomic operations are
spinlocks (actually they're slower than spinlocks), that's the
cpu/scalability cost I mentioned above.

> 	metadata, by me and others, including Hugh Dickins, Andrew
> 	Morton, Martin Bligh, and Dave McCracken. In some of my newer

I was mainly talking about mainline, I also have a design that would
reduce the overhead to zero still having the same swapout, but there are
too many variables and if it has a chance to work, I'll talk about it
after I checked it actually works but likely it won't work well (I mean
during swap for some exponential recursion issue, because the other
costs would be zero), it's just an idea for now.

> (b) SMP scalability
> 	There are scalability issues, but they have absolutely nothing
> 	to do with SMP or locking. The largest such issue is the

readprofile shows it at the top constantly, so it's either cpu or
scalability. And the spinlock by hand in the minor page faults is a
scalability showstopper IMHO. You know the kernel compile on the 32way
w/ rmap and w/o rmap (with objrmap).

> 	resource scalability issue on PAE. There are several long-
> 	suffering patches with various amounts of work being put into
> 	them that are trying to address this, by the same authors as
> 	above. They are largely effective.

yes, this is why I wrote the email, to try not to forget that rmap in
mainline would better be replaced with one of those solutions under
development.

> On Tue, Jul 01, 2003 at 02:39:47AM +0100, Mel Gorman wrote:
> >>    Non-Linear Populating of Virtual Areas
> >>    ======================================
> >>    In 2.4, a VMA backed by a file would be populated in a linear fashion.
> >>    This can be optionally changed in 2.6 with the introduction of the
> >>    MAP_POPULATE flag to mmap() and the new system call remap_file_pages().
> >>    This system call allows arbitrary pages in an existing VMA to be remapped
> >>    to an arbitrary location on the backing file. This is mainly of interest
> >>    to database servers which previously simulated this behavior by the
> >>    creation of many VMAs.
> >>    On page-out, the non-linear address for the file is encoded within the PTE
> >>    so that it can be installed again correctly on page fault. How it is
> >>    encoded is architecture specific so two macros are defined called
> >>    pgoff_to_pte() and pte_to_pgoff() for the task.
> 
> On Tue, Jul 01, 2003 at 04:25:16AM +0200, Andrea Arcangeli wrote:
> > and it was used to break truncate, furthmore the API doesn't look good
> > to me, the vma should have a special VM_NONLINEAR created with a
> > MAP_NONLINEAR so the vm will skip it enterely and it should be possible
> > to put multiple files in the same vma IMHO. If these areas are
> > vmtruncated the VM_NONLINEAR will keep vmtruncate out of them and the
> > pages will become anonymous, which is perfectly fine since they're
> > created with a special MAP_NONLINEAR that can have different semantics.
> 
> Well, the truncate() breakage is just a bug that I guess we'll have to
> clean up soon to get rid of criticisms like this. Tagging the vma for
> exhaustive search during truncate() when it's touched by
> remap_file_pages() sounds like a plausible fix.
> 
> 
> On Tue, Jul 01, 2003 at 04:25:16AM +0200, Andrea Arcangeli wrote:
> > Also this feature is mainly useful only in kernels with rmap while using
> > the VLM, to workaround the otherwise overkill cpu and memory overhead
> > generated by rmap. It is discouraged to use it as a default API unless
> > you fall into those special corner cases. the object of this API is to
> > bypass the VM so you would lose security and the VM advantages. if you
> > want the same features you have w/o nonlinaer w/ nonlinear, then you
> > invalidate the whole point of nonlinear.
> > The other very corner cases are emulators, they also could benefit from
> > a VM bypass like remap_file_pags provides.
> > Pinning ram from multiple files plus a sysctl or a sudo wrapper would be
> > an optimal API and it would avoid the VM to even look at the pagetables
> > of those areas.
> 
> IMHO mlock() should be the VM bypass, and refrain from creating
> metadata like pte_chains or buffer_heads. Some additional but not very

mlock doesn't prevent rmap to be created on the mapping.

If mlock was enough as a vm bypass, you wouldn't need remap_file_pages
in the first place.

remap_file_pages is the vm bypass, mlock is not. VM bypass doesn't only
mean that you can't swap it, it means that the vm just pins the pages
and forget about them like if it was a framebuffer with PG_reserved set.
And as such it doesn't make much sense to give vm knowledge to
remap_file_pages when also remap_file_pages only makes sense in the 99%
of the usages in production together with largepages (which is not
possible in 2.5.73 yet), it would be an order of magnitude more
worhtwhile to include the fd as parameter in the API than to be able to
page it IMHO.

> complex mechanics appear to be required to do this. The emulator case
> is precisely the one which would like to use remap_file_pages() with
> all the VM metadata attached, as they often prefer to not run with
> elevated privileges as required by mlock(), and may in fact be using
> data sets larger than RAM despite the slowness thereof. The immediate
> application I see is for bochs to emulate highmem on smaller machines.

if it has to swap that much, the cost of walking the vma tree wouldn't
be that significant anymore (though you would save the ram for the vma).

Also normally the emulators are very strict at not allowing you to
allocate insane amount of emulated ram because otherwise it slowsdown
like a crawl, they look at the ram in the box to limit it. Thought it
would be theroetically possible to do what you mentioned, but the
benefit of remap_file_pages would be not noticeable under such a
workload IMHO. You want remap_file_pages when you have zero background
vm kernel activity in the mapping while you use it as far as I can tell.
If you have vm background activity, you want the most efficent way to
teardown that pte as you said at the top of the email.

> On Tue, Jul 01, 2003 at 04:25:16AM +0200, Andrea Arcangeli wrote:
> > Last but not the least, remap_file_pages is nearly useless (again modulo
> > emulators) w/o bigpages support backing it (not yet the case in 2.5 as
> > far as I can see so it's unusable compared to 2.4-aa [but 2.5 -
> > remap_file_pages is even less usable than 2.5 + remap_file_pages due
> > rmap that wouldn't only run slow but it wouldn't run at all]). objrmap
> > fixes that despites it introduces some complex algorithm.
> > the only significant cost is the tlb flushing and pagetable walking at
> > 32G of working set in cache with a 30-31bit window on the cache. 
> 
> This is wildly inaccurate. Highly complex mappings rarely fall upon
> boundaries suitable for large TLB entries apart from on architectures

If they don't fit it's an userspace issue, not a kernel issue.

> (saner than x86) with things like 32KB TLB entry sizes. The only
> overhead there is to be saved is metadata (i.e. space conservation)
> like buffer_heads and pte_chains, which can just as easily be done with
> proper mlock() bypasses.
> 
> Basically, this is for the buffer pool, not the shared segment, and
> so it can't use large tlb entries anyway on account of the granularity.

the granularity is 2M, not 32k. The cost of 2M granularity is the same
as 32k if you use bigpages, infact it's much less because you only walk
2 level, not 3. so such an application using 32k granularity isn't
designed for the high end and it'll have to be fixed to compete with
better apps, so no matter the kernel it won't run as fast as the
hardware can deliver, it's not a kernel issue.

> The shared segment could very easily use hugetlb as-is without issue.
> 
> Mixed-mode hugetlb has been requested various times. I would much
> prefer to address the creation, destruction, and space overheads of
> normal mappings and implement fully implicit large TLB entry
> utilization than implement such.
> 
> 
> On Tue, Jul 01, 2003 at 02:39:47AM +0100, Mel Gorman wrote:
> >>    Delayed Coalescing
> >>    ==================
> >>    2.6 extends the buddy algorithm to resemble a lazy buddy algorithm [BL89]
> >>    which delays the splitting and coalescing of buddies until it is
> >>    necessary. The delay is implemented only for 0 order allocations with the
> 
> On Tue, Jul 01, 2003 at 04:25:16AM +0200, Andrea Arcangeli wrote:
> > desribed this way it sounds like it's not O(1) anymore for order > 0
> > allocations. Though it would be a nice feature for all the common cases.
> > And of course it's still O(1) if one assumes the number of orders
> > limited (and it's fixed at compile time).
> > as for the per-zone lists, sure they increase scalability, but it loses
> > aging information, the worst case will be reproducible on a 1.6G box,
> > some day even 2.3 had per-zone lists, I backed it out to avoid losing
> > information which is an order of magnitude more interesting than
> > the pure smp scalability for normal users (i.e. 2-way systems with 1-2G
> > of ram, of course the scalability numbers that people cares about on the
			  ^^^^^^^^^^^
> > 8-way with 32G of ram will be much better with the per-zone lru).
> > Just trying not to forget the other side too ;) Not every improvement on
> > one side cames for free on all other sides.
> 
> The per-zone LRU lists are not related to SMP scalability either. They

I never said SMP scalability, I said just plain _scalability_.

> are for:
> (a) node locality
> 	So a node's kswapd or processes doing try_to_free_pages() only
> 	references struct pages on the local nodes.

I'm talking about the per-zone, not per-node. Since they're per-zone
they're also per-node, but per-node is completely different than
per-zone. Infact originally I even had per-node lrus at some point
around 2.4.0-testsomething for the reasons you said above. then I giveup
since there were too few numa users and more basic numa issues to
address first at that time and nobody cared much about numa, I even
heard the argument that classzone was bad for numa at some point ;)

> (b) segregating the search space for page replacement
> 	So the search for ZONE_NORMAL or ZONE_DMA pages doesn't scan
> 	the known universe hunting for a needle in a haystack and spend
> 	24+ hours doing so.

yes, and that is good only for the very infrequent allocations, and
wastes aging for the common highmem ones. That was my whole point.

> Lock contention was addressed differently, by amortizing the lock
> acquisitions using the pagevec infrastructure. In general the

I said scalability feature, it is definitely a scalability feature, not
an smp scalabity one, I never spoke about lock contention, but you will
definitely appreciate it more on the 8G boxes due the tiny zone normal
they have compared to the highmem one, which is definitely a scalability
issue (loads of wasted cpu) but very worthless on a 1G box.

> global aging and/or queue ordering information has not been found to be
> particularly valuable, or at least no one's complaining that they miss it.

in -aa on a 64G I don't allow a single byte of normal zone to be
assigned to highmem capable users, so nobody could ever complain about
that in the high end on a good kernel since the whole lru should populated
only by highmem users regardless - which would be equivalent to 2.5. On
the highend the normal zone is so tiny, that you don't waste if it's
loaded in old worthless cache or completely unused, the aging difference
with be near zero anyways. But for the low end if you will provide a
patch to revert it to a global list and if you give that patch on the
list to the 1G-1.5G ram users, then maybe somebody will have a chance to
notice the potential regression.

Andrea
