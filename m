Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTGAHfl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 03:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbTGAHfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 03:35:41 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:9888
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261151AbTGAHfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 03:35:22 -0400
Date: Tue, 1 Jul 2003 09:49:15 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
Message-ID: <20030701074915.GQ3040@dualathlon.random>
References: <Pine.LNX.4.53.0307010238210.22576@skynet> <20030701022516.GL3040@dualathlon.random> <20030701032531.GC20413@holomorphy.com> <20030701043902.GP3040@dualathlon.random> <20030701063317.GF20413@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030701063317.GF20413@holomorphy.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 30, 2003 at 11:33:17PM -0700, William Lee Irwin III wrote:
> On Mon, Jun 30, 2003 at 08:25:31PM -0700, William Lee Irwin III wrote:
> >> Both of those are inaccurate.
> >> (a) performance
> >> 	This is not one-sided. Pagetable setup and teardown has higher
> >> 	overhead with the pte-based methods. The largest gain is from
> 
> On Tue, Jul 01, 2003 at 06:39:02AM +0200, Andrea Arcangeli wrote:
> > I said "until you actually have to swapout or pageout". I very much that
> > you're right and that pagetable teardown has higher overhead with the
> > pte-based methods.  If you were wrong about it rmap would be a total
> > waste on all sides, not just one.
> > I'm talking about the other side only (which is the one I want to run
> > fast on my machines).
> 
> Okay, so let's speed it up. I've got various hacks related to this in

last time we got stuck in objrmap due the complexty complains ( the
i_mmap links all the vmas of the file, not only the ones relative to the
range that maps the page that we need to free, so we would end checking
lots of vmas multiple times for each page)

In practice it didn't look bad enough to me though, there's mainly the
security concerns where an user could force the vm not to schedule for
the time it takes to reach that page (or we could make it schedule w/o
guaranteeing the unmap, the unmap isn't guaranteed in 2.4 either if the
user keeps looping, and that's also a feature)

> my -wli tree (which are even quite a bit beyond objrmap). It includes
> an NIH of hugh's old anobjrmap patches with some tiny speedups like
> inlining the rmap functions, which became small enough to do that with,
> and RCU'ing ->i_shared_lock and anon->lock.
> 
> 
> On Mon, Jun 30, 2003 at 08:25:31PM -0700, William Lee Irwin III wrote:
> >> 	being able to atomically unmap pages. The overhead is generally
> >> 	from the atomic operations involved with the pagewise locking.
> 
> On Tue, Jul 01, 2003 at 06:39:02AM +0200, Andrea Arcangeli wrote:
> > which is a scalability cost. Those so called atomic operations are
> > spinlocks (actually they're slower than spinlocks), that's the
> > cpu/scalability cost I mentioned above.
> 
> Okay this is poorly stated. Those cpu costs do not affect scaling
> factors.

those atomic operations happens on the page and the page is shared.
That's where the smp scalability costs cames from, the cacheline bounces
off across all cpus that executes gcc at the same time.

> 
> 
> On Mon, Jun 30, 2003 at 08:25:31PM -0700, William Lee Irwin III wrote:
> >> 	metadata, by me and others, including Hugh Dickins, Andrew
> >> 	Morton, Martin Bligh, and Dave McCracken. In some of my newer
> 
> On Tue, Jul 01, 2003 at 06:39:02AM +0200, Andrea Arcangeli wrote:
> > I was mainly talking about mainline, I also have a design that would
> > reduce the overhead to zero still having the same swapout, but there are
> > too many variables and if it has a chance to work, I'll talk about it
> > after I checked it actually works but likely it won't work well (I mean
> > during swap for some exponential recursion issue, because the other
> > costs would be zero), it's just an idea for now.
> 
> The anobjrmap code from Hugh Dickins that I NIH'd for -wli essentially
> does this, apart from eliminating the per-page locking, and it's
> already out there.

I said it would provide the same swapout features, so without the
complexity issue in the swapout. objrmap has the complexity issue,
that's its main problem as far as I know. But personally I prefer it.

> On Mon, Jun 30, 2003 at 08:25:31PM -0700, William Lee Irwin III wrote:
> >> (b) SMP scalability
> >> 	There are scalability issues, but they have absolutely nothing
> >> 	to do with SMP or locking. The largest such issue is the
> 
> On Tue, Jul 01, 2003 at 06:39:02AM +0200, Andrea Arcangeli wrote:
> > readprofile shows it at the top constantly, so it's either cpu or
> > scalability. And the spinlock by hand in the minor page faults is a
> > scalability showstopper IMHO. You know the kernel compile on the 32way
> > w/ rmap and w/o rmap (with objrmap).
> 
> Kernel compiles aren't really very good benchmarks. I've moved on to

true, many important workloads aren't nearly similar to kernel compiles,
but still kernel compiles are relevant.

> SDET and gotten various things done to cut down on process creation
> and destruction, including but not limited to NIH'ing various object-
> based ptov resolution patches and RCU'ing locks they pound on.

I'm unsure if RCU is worthwhile for this, here the cost is the writer
not the reader, the readers is the swapout code (ok, also
mprotoect/mremap and friends) but the real issue is the writer. The
reader is always been ok with the spinlock (or at the very least I don't
mind about the scalability of the reader). RCU (unless you benefit
greatly from the coalescing of the free operations) could make the
writer even slower to benefit the reader. So overall RCU here doesn't
make much sense to me.

> On Mon, Jun 30, 2003 at 08:25:31PM -0700, William Lee Irwin III wrote:
> >> 	resource scalability issue on PAE. There are several long-
> >> 	suffering patches with various amounts of work being put into
> >> 	them that are trying to address this, by the same authors as
> >> 	above. They are largely effective.
> 
> On Tue, Jul 01, 2003 at 06:39:02AM +0200, Andrea Arcangeli wrote:
> > yes, this is why I wrote the email, to try not to forget that rmap in
> > mainline would better be replaced with one of those solutions under
> > development.
> 
> There are some steps that need to be taken before merging them, but
> AFAICT they're progressing toward merging smoothly.

Which steps? And how did you solve the complexity issue? Who given the
agreement for merging objrmap? AFIK there was disagreement due the
complexity issues (hence I thought at a different way that probably
won't work but that would solve all the complexity issues and the cost
in the page faults, though it wouldn't be simple at all even if it works)

> On Mon, Jun 30, 2003 at 08:25:31PM -0700, William Lee Irwin III wrote:
> >> Well, the truncate() breakage is just a bug that I guess we'll have to
> >> clean up soon to get rid of criticisms like this. Tagging the vma for
> >> exhaustive search during truncate() when it's touched by
> >> remap_file_pages() sounds like a plausible fix.
> 
> On Mon, Jun 30, 2003 at 08:25:31PM -0700, William Lee Irwin III wrote:
> >> IMHO mlock() should be the VM bypass, and refrain from creating
> >> metadata like pte_chains or buffer_heads. Some additional but not very
> 
> On Tue, Jul 01, 2003 at 06:39:02AM +0200, Andrea Arcangeli wrote:
> > mlock doesn't prevent rmap to be created on the mapping.
> > If mlock was enough as a vm bypass, you wouldn't need remap_file_pages
> > in the first place.
> 
> I was proposing that it should be used to prevent pte_chains from being
> created, not suggesting that it does so now.

if you want to change mlock to drop the pte_chains then it would
definitely make mlock a VM bypass, even if not as strong as the
remap_file_pages that bypass the vma layer too (not only the
pte/pte_chain side).

> On Tue, Jul 01, 2003 at 06:39:02AM +0200, Andrea Arcangeli wrote:
> > remap_file_pages is the vm bypass, mlock is not. VM bypass doesn't only
> > mean that you can't swap it, it means that the vm just pins the pages
> > and forget about them like if it was a framebuffer with PG_reserved set.
> > And as such it doesn't make much sense to give vm knowledge to
> > remap_file_pages when also remap_file_pages only makes sense in the 99%
> > of the usages in production together with largepages (which is not
> > possible in 2.5.73 yet), it would be an order of magnitude more
> > worhtwhile to include the fd as parameter in the API than to be able to
> > page it IMHO.
> 
> There is nothing particularly special about remap_file_pages() apart
> from the fact some additional checks are needed when walking ->i_mmap
> and ->i_mmap_shared to avoid range checks being fooled by it.

there is something very special about remap_file_pages: it is the only
way to avoid rmap right now. And if you claim that remap_file_pages
works better than mmap() for the simulator that allocates more highmem
than ram, you're just saying that rmap is completely useless even during
the pte teardown. So either you admit remap_file_pages would be a bad
idea to use with heavy paging (i.e. as much highmem as you want, booting
64G of ram emulated on a 4G box) because it misses rmap, or you admit
rmap is useless.

> 
> remap_file_pages() in combination with hugetlb just doesn't make sense.
> The buffer pool does not use 2MB windows (though it's configurable, so
> in principle you _could_). Furthermore 2MB windows are so large the vma
> overhead of using mmap() could already be tolerated.

remap_file_pages theoretically provides the lowest possible overhead if
implemented as I'm advocating for some month. The full true VM bypass,
even stronger than your mlock that drops the pte_chains and reconstruct
them when the mlock goes away.

I mean, nothing can be faster than remap_file_pages if implemented as I
describe (with support of largepages as well). Done that way it would be
an obvious improvement, for the emulators too (provided a sysctl that
voids all the security concerns w.r.t. to the amount of pinned ram).

But as soon as you refuse to support largepages with remap_file_pages
you automatically make it slower than mmap, and then remap_file_pages
becomes almost useless (except for the emulators).

Note: remap_file_pages is not needed at all with current kernels, the
only reason we may want to backport it to 2.4 is for the lower vma
overhead (very minor issue) so maybe it's a 0.5-1% or similar (I'm only
guessing). But the lack of largepage support would offset whatever
benefit the vma overhead avoidance can provide IMHO (that applies to 2.5
too of course).

> On Mon, Jun 30, 2003 at 08:25:31PM -0700, William Lee Irwin III wrote:
> >> complex mechanics appear to be required to do this. The emulator case
> >> is precisely the one which would like to use remap_file_pages() with
> >> all the VM metadata attached, as they often prefer to not run with
> >> elevated privileges as required by mlock(), and may in fact be using
> >> data sets larger than RAM despite the slowness thereof. The immediate
> >> application I see is for bochs to emulate highmem on smaller machines.
> 
> On Tue, Jul 01, 2003 at 06:39:02AM +0200, Andrea Arcangeli wrote:
> > if it has to swap that much, the cost of walking the vma tree wouldn't
> > be that significant anymore (though you would save the ram for the vma).
> > Also normally the emulators are very strict at not allowing you to
> > allocate insane amount of emulated ram because otherwise it slowsdown
> > like a crawl, they look at the ram in the box to limit it. Thought it
> > would be theroetically possible to do what you mentioned, but the
> > benefit of remap_file_pages would be not noticeable under such a
> > workload IMHO. You want remap_file_pages when you have zero background
> > vm kernel activity in the mapping while you use it as far as I can tell.
> > If you have vm background activity, you want the most efficent way to
> > teardown that pte as you said at the top of the email.
> 
> In general the way to use it would be to treat virtualspace as a fully
> associative cache. This also does not imply swapping since the stuff may
> just as easily be cached in highmem. The fact one _could_ do it with
> data sets large than RAM, albeit slowly, is also of interest. It would
> effectively want random page replacement, e.g. a FIFO queue, and some
> method of mitigating its impact on other applications on the system.

that would imply that those methods would be almost as fast as the true
rmap algorithm for swapping? So why we don't use them for everything and
we drop rmap? Or are you going to hack the kernel and reboot just before
running a special emulator and hack this algorithm and reboot every time
you change the application that uses remap_file_pages to get sane heavy
swapping out of it?

with your "swapping emulator" workload all the ram (either 1T or 10M)
will be mapped in this vma populated with remap_file_pages. It's like
running the emulator in a 2.4 kernel w/o rmap, with only the vma tree
cost removed. If it's still always faster it means rmap saves less than
the rbtree cost, and so basically rmap is useless since its main
advantage is in terms of computational complexity IMHO.

The fact is that as far as it's true that rmap pays off (I mean more
than the rbtree cost), if you need to page the nonlinear vma, you'd
better not use a nonlinear vma but to use the linear vmas instead so
you'll get the real scalabile and optimized swapping algorithm. And in
turn IMHO remap_file_pages makes sense only when you don't need to swap.

making remap_file_pages pageables only helps in terms of security
requirements as far as I can tell but that can be addressed more simply
by a sysctl too (and then we can pass the fd to remap_file_pages too as
last argument, which would be a very nice addition IMHO).

> On Mon, Jun 30, 2003 at 08:25:31PM -0700, William Lee Irwin III wrote:
> >> This is wildly inaccurate. Highly complex mappings rarely fall upon
> >> boundaries suitable for large TLB entries apart from on architectures
> 
> On Tue, Jul 01, 2003 at 06:39:02AM +0200, Andrea Arcangeli wrote:
> > If they don't fit it's an userspace issue, not a kernel issue.
> 
> You say that as if it's in the least bit feasible to get major apps to
> change. They're almost as bad as hardware.

yes. But some db is allocating ~32G of shm in largepages and it runs
significantly faster when the largepags are enabled, so I assume it must
use 2M granularity somewhere to measure this difference.

> On Mon, Jun 30, 2003 at 08:25:31PM -0700, William Lee Irwin III wrote:
> >> (saner than x86) with things like 32KB TLB entry sizes. The only
> >> overhead there is to be saved is metadata (i.e. space conservation)
> >> like buffer_heads and pte_chains, which can just as easily be done with
> >> proper mlock() bypasses.
> >> Basically, this is for the buffer pool, not the shared segment, and
> >> so it can't use large tlb entries anyway on account of the granularity.
> 
> On Tue, Jul 01, 2003 at 06:39:02AM +0200, Andrea Arcangeli wrote:
> > the granularity is 2M, not 32k. The cost of 2M granularity is the same
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > as 32k if you use bigpages, infact it's much less because you only walk
> > 2 level, not 3. so such an application using 32k granularity isn't
> > designed for the high end and it'll have to be fixed to compete with
> > better apps, so no matter the kernel it won't run as fast as the
> > hardware can deliver, it's not a kernel issue.
> 
> What on earth? 32KB granularity still needs the 3rd-level. I also fail

when the granularity is 2M (not 32k) it only walks 2 levels, the 3rd
level doesn't exist with largepages. of course the pagetables will be
the PAE ones still, but the largepages only generates 2 walks, there's
no PTE, there's the pmd only. So it's like if it's a 2 level pagetables
for the whole shm. If the app is smart enough to have some locality, the
single tlb entry will cache what could otherwise generate multiple mmaps
(and in turn tlb flushes) and multiple tlb entries.

> to see a resource scalability impact for the kernels bigpages are used
> on since although they will be eliminated from consideration for
> swapping, it's not in use in combination with rmap-based VM's that I
> know of.

not sure to understand this sentence. There's no scalability issue at
all related to remap_file_pages and largepages. If something they can
help scalability by avoiding rmap (i.e. like mlock or with "slow swap
ala 2.4").

> On Mon, Jun 30, 2003 at 08:25:31PM -0700, William Lee Irwin III wrote:
> >> The per-zone LRU lists are not related to SMP scalability either. They
> 
> On Tue, Jul 01, 2003 at 06:39:02AM +0200, Andrea Arcangeli wrote:
> > I never said SMP scalability, I said just plain _scalability_.
> 
> To measure scaling a performance metric (possibly workload feasibility)
> and an input are required. For instance, throughput on SDET and number
> of cpus, or amount of RAM and number of processes. "Scalability",
> wherever it's unqualified by such things, is meaningless.

This was a ram scalability, the more you increase the amount of ram, the
more you lose in those loops for GFP_KERNEL allocations. Overall I
simply meant it works much better the biggest the box is.

> On Mon, Jun 30, 2003 at 08:25:31PM -0700, William Lee Irwin III wrote:
> >> are for:
> >> (a) node locality
> >> 	So a node's kswapd or processes doing try_to_free_pages() only
> >> 	references struct pages on the local nodes.
> 
> On Tue, Jul 01, 2003 at 06:39:02AM +0200, Andrea Arcangeli wrote:
> > I'm talking about the per-zone, not per-node. Since they're per-zone
> > they're also per-node, but per-node is completely different than
> > per-zone. Infact originally I even had per-node lrus at some point
> > around 2.4.0-testsomething for the reasons you said above. then I giveup
> > since there were too few numa users and more basic numa issues to
> > address first at that time and nobody cared much about numa, I even
> > heard the argument that classzone was bad for numa at some point ;)
> 
> Well, the reason why it's per-zone and not just per-node is in point (b).

I know and it works perfectly for the highend but I seriously doubt it
is the optimal design for normal 1-2G boxes.

> Per-node would suffice to reap the qualitative benefits in point (a).

yes.

> 
> 
> On Mon, Jun 30, 2003 at 08:25:31PM -0700, William Lee Irwin III wrote:
> >> (b) segregating the search space for page replacement
> >> 	So the search for ZONE_NORMAL or ZONE_DMA pages doesn't scan
> >> 	the known universe hunting for a needle in a haystack and spend
> >> 	24+ hours doing so.
> 
> On Tue, Jul 01, 2003 at 06:39:02AM +0200, Andrea Arcangeli wrote:
> > yes, and that is good only for the very infrequent allocations, and
> > wastes aging for the common highmem ones. That was my whole point.
> 
> The question is largely of whether the algorithm explodes when it's
> asked to recover lowmem.

yeah the ram scalability. So we penalize the boxes where it wouldn't
explode.

I agree being able to scale on the ~32G is much more important to run
optimally on the 1-2G. My whole email is about pointing out and not
forgetting that there are also downsides in those scalability
enhacements. It's not always the case, but in this case definitely yes.
In the 2.3.x days I definitely cared more about the 1-2G boxes than
about the 32G ones.

> On Mon, Jun 30, 2003 at 08:25:31PM -0700, William Lee Irwin III wrote:
> >> Lock contention was addressed differently, by amortizing the lock
> >> acquisitions using the pagevec infrastructure. In general the
> 
> On Tue, Jul 01, 2003 at 06:39:02AM +0200, Andrea Arcangeli wrote:
> > I said scalability feature, it is definitely a scalability feature, not
> > an smp scalabity one, I never spoke about lock contention, but you will
> > definitely appreciate it more on the 8G boxes due the tiny zone normal
> > they have compared to the highmem one, which is definitely a scalability
> > issue (loads of wasted cpu) but very worthless on a 1G box.
> 
> Unfortunately I don't have such a machine at my disposal (the discontig
> code barfs on mem= at the moment). But I'd like to see the results.

A plain bonnie run with -s 1800 on a 2G box would be very interesting
(it should in theory read it all from cache, and if my theory is right
it will do some  worthless I/O instead during the read).

> On Mon, Jun 30, 2003 at 08:25:31PM -0700, William Lee Irwin III wrote:
> >> global aging and/or queue ordering information has not been found to be
> >> particularly valuable, or at least no one's complaining that they miss it.
> 
> On Tue, Jul 01, 2003 at 06:39:02AM +0200, Andrea Arcangeli wrote:
> > in -aa on a 64G I don't allow a single byte of normal zone to be
> > assigned to highmem capable users, so nobody could ever complain about
> > that in the high end on a good kernel since the whole lru should populated
> > only by highmem users regardless - which would be equivalent to 2.5. On
> > the highend the normal zone is so tiny, that you don't waste if it's
> > loaded in old worthless cache or completely unused, the aging difference
> > with be near zero anyways. But for the low end if you will provide a
> > patch to revert it to a global list and if you give that patch on the
> > list to the 1G-1.5G ram users, then maybe somebody will have a chance to
> > notice the potential regression.
> 
> I would like to hear of the results of testing on such systems. I
> personally have doubts any significant difference will be found.

that's why I mentioned those issues. I'd be glad to get numbers
confirming that I'm plain wrong on all of them ;)

Andrea
