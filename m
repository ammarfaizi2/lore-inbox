Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbTGAIqf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 04:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbTGAIqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 04:46:35 -0400
Received: from holomorphy.com ([66.224.33.161]:40621 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261300AbTGAIqF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 04:46:05 -0400
Date: Tue, 1 Jul 2003 01:59:39 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Joel.Becker@oracle.com, Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
Message-ID: <20030701085939.GG20413@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, Joel.Becker@oracle.com,
	Mel Gorman <mel@csn.ul.ie>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53.0307010238210.22576@skynet> <20030701022516.GL3040@dualathlon.random> <20030701032531.GC20413@holomorphy.com> <20030701043902.GP3040@dualathlon.random> <20030701063317.GF20413@holomorphy.com> <20030701074915.GQ3040@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030701074915.GQ3040@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 30, 2003 at 11:33:17PM -0700, William Lee Irwin III wrote:
>> Okay, so let's speed it up. I've got various hacks related to this in

On Tue, Jul 01, 2003 at 09:49:15AM +0200, Andrea Arcangeli wrote:
> last time we got stuck in objrmap due the complexty complains ( the
> i_mmap links all the vmas of the file, not only the ones relative to the
> range that maps the page that we need to free, so we would end checking
> lots of vmas multiple times for each page)
> In practice it didn't look bad enough to me though, there's mainly the
> security concerns where an user could force the vm not to schedule for
> the time it takes to reach that page (or we could make it schedule w/o
> guaranteeing the unmap, the unmap isn't guaranteed in 2.4 either if the
> user keeps looping, and that's also a feature)

What I found was that enough vma walking was done even on unpressured
systems (something like 4GB/32GB utilized) that RCU'ing the lock helped.
I went from semaphore -> spinlock -> rwlock -> RCU, each with some small
speed increase on the 16x/32GB system.


On Mon, Jun 30, 2003 at 11:33:17PM -0700, William Lee Irwin III wrote:
>> my -wli tree (which are even quite a bit beyond objrmap). It includes
>> an NIH of hugh's old anobjrmap patches with some tiny speedups like
>> inlining the rmap functions, which became small enough to do that with,
>> and RCU'ing ->i_shared_lock and anon->lock.
>> Okay this is poorly stated. Those cpu costs do not affect scaling
>> factors.

On Tue, Jul 01, 2003 at 09:49:15AM +0200, Andrea Arcangeli wrote:
> those atomic operations happens on the page and the page is shared.
> That's where the smp scalability costs cames from, the cacheline bounces
> off across all cpus that executes gcc at the same time.

Yes, that's why I'm trying to use RCU to eliminate the bitwise locking
overhead on the page except in the two rare situations where chaining is
required in hugh's scheme, i.e. in-flight mremap() and remap_file_pages().
I've been having a very tough time doing this. If you'd like to get
involved I'd more than welcome it.


On Mon, Jun 30, 2003 at 11:33:17PM -0700, William Lee Irwin III wrote:
>> The anobjrmap code from Hugh Dickins that I NIH'd for -wli essentially
>> does this, apart from eliminating the per-page locking, and it's
>> already out there.

On Tue, Jul 01, 2003 at 09:49:15AM +0200, Andrea Arcangeli wrote:
> I said it would provide the same swapout features, so without the
> complexity issue in the swapout. objrmap has the complexity issue,
> that's its main problem as far as I know. But personally I prefer it.

I actually outright dislike it, but it addresses the resource
scalability issue.


On Mon, Jun 30, 2003 at 11:33:17PM -0700, William Lee Irwin III wrote:
>> Kernel compiles aren't really very good benchmarks. I've moved on to

On Tue, Jul 01, 2003 at 09:49:15AM +0200, Andrea Arcangeli wrote:
> true, many important workloads aren't nearly similar to kernel compiles,
> but still kernel compiles are relevant.

First I ask, "What is this exercising?" That answer is largely process
creation and destruction and SMP scheduling latency when there are very
rapidly fluctuating imbalances.

After observing that, the benchmark is flawed because
(a) it doesn't run long enough to produce stable numbers
(b) the results are apparently measured with gettimeofday(), which is
	wildly inaccurate for such short-lived phenomena
(c) large differences in performance appear to come about as a result
	of differing versions of common programs (i.e. gcc)

The retired #$%@.org benchmark whose name I actually shouldn't have
mentioned in my prior post without consulting a lawyer, while being
some of the shittiest code on earth, seems to have a-c covered.


On Mon, Jun 30, 2003 at 11:33:17PM -0700, William Lee Irwin III wrote:
>> #$%@ and gotten various things done to cut down on process creation
>> and destruction, including but not limited to NIH'ing various object-
>> based ptov resolution patches and RCU'ing locks they pound on.

On Tue, Jul 01, 2003 at 09:49:15AM +0200, Andrea Arcangeli wrote:
> I'm unsure if RCU is worthwhile for this, here the cost is the writer
> not the reader, the readers is the swapout code (ok, also
> mprotoect/mremap and friends) but the real issue is the writer. The
> reader is always been ok with the spinlock (or at the very least I don't
> mind about the scalability of the reader). RCU (unless you benefit
> greatly from the coalescing of the free operations) could make the
> writer even slower to benefit the reader. So overall RCU here doesn't
> make much sense to me.

I saw spintime in the vma modifiers, and RCU'd as a brute-force cookbook
attack on it without really considering what it was or who it came from.
And it worked. Open & shut case if you ask me. =)


On Mon, Jun 30, 2003 at 11:33:17PM -0700, William Lee Irwin III wrote:
>> There are some steps that need to be taken before merging them, but
>> AFAICT they're progressing toward merging smoothly.

On Tue, Jul 01, 2003 at 09:49:15AM +0200, Andrea Arcangeli wrote:
> Which steps? And how did you solve the complexity issue? Who given the
> agreement for merging objrmap? AFIK there was disagreement due the
> complexity issues (hence I thought at a different way that probably
> won't work but that would solve all the complexity issues and the cost
> in the page faults, though it wouldn't be simple at all even if it works)

Dave McCracken is doing something unusual involving truncate() locking
to prevent the situation that causes objrmap trouble. I'm not convinced
I like the approach but I'll settle for results.


On Mon, Jun 30, 2003 at 11:33:17PM -0700, William Lee Irwin III wrote:
>> I was proposing that it should be used to prevent pte_chains from being
>> created, not suggesting that it does so now.

On Tue, Jul 01, 2003 at 09:49:15AM +0200, Andrea Arcangeli wrote:
> if you want to change mlock to drop the pte_chains then it would
> definitely make mlock a VM bypass, even if not as strong as the
> remap_file_pages that bypass the vma layer too (not only the
> pte/pte_chain side).

Well, the thing is it's closer to the primitive. You're suggesting
making remap_file_pages() both locked and unaligned with the vma, where
it seems to me the real underlying mechanism is using the semantics of
locked memory to avoid creating pte_chains. Bypassing vma's doesn't
seem to be that exciting. There are only a couple of places where an
assumption remap_file_pages() breaks matters, i.e. vmtruncate() and
try_to_unmap_one_obj(), and that can be dodged with exhaustive search
in the non-anobjrmap VM's and is naturally handled by chaining the
distinct virtual addresses where pages are mapped against the page by
the anobjrmap VM's.


On Mon, Jun 30, 2003 at 11:33:17PM -0700, William Lee Irwin III wrote:
>> There is nothing particularly special about remap_file_pages() apart
>> from the fact some additional checks are needed when walking ->i_mmap
>> and ->i_mmap_shared to avoid range checks being fooled by it.

On Tue, Jul 01, 2003 at 09:49:15AM +0200, Andrea Arcangeli wrote:
> there is something very special about remap_file_pages: it is the only
> way to avoid rmap right now. And if you claim that remap_file_pages
> works better than mmap() for the simulator that allocates more highmem
> than ram, you're just saying that rmap is completely useless even during
> the pte teardown. So either you admit remap_file_pages would be a bad
> idea to use with heavy paging (i.e. as much highmem as you want, booting
> 64G of ram emulated on a 4G box) because it misses rmap, or you admit
> rmap is useless.

What do you mean? pte_chains are still created for remap_file_pages().
The resource scalability issue it addresses is vma's, not pte_chains.
vma creation is largely useless for such complex mappings because it
would create close to one 64B+ structure per PTE.


On Mon, Jun 30, 2003 at 11:33:17PM -0700, William Lee Irwin III wrote:
>> remap_file_pages() in combination with hugetlb just doesn't make sense.
>> The buffer pool does not use 2MB windows (though it's configurable, so
>> in principle you _could_). Furthermore 2MB windows are so large the vma
>> overhead of using mmap() could already be tolerated.

On Tue, Jul 01, 2003 at 09:49:15AM +0200, Andrea Arcangeli wrote:
> remap_file_pages theoretically provides the lowest possible overhead if
> implemented as I'm advocating for some month. The full true VM bypass,
> even stronger than your mlock that drops the pte_chains and reconstruct
> them when the mlock goes away.

Well, that would basically be the "no pte_chains for mlock()'d memory"
trick plus forcing remap_file_pages() to be mlock()'d plus
remap_file_pages(). Which I don't find terribly offensive, but sounds
a bit less flexible than just using the mlock() trick.


On Tue, Jul 01, 2003 at 09:49:15AM +0200, Andrea Arcangeli wrote:
> I mean, nothing can be faster than remap_file_pages if implemented as I
> describe (with support of largepages as well). Done that way it would be
> an obvious improvement, for the emulators too (provided a sysctl that
> voids all the security concerns w.r.t. to the amount of pinned ram).

Some environments would probably dislike the privilege requirements.

If I ever get the time to do some farting around in userspace (highly
unlikely), I'd like to write an MUA that uses an aio remap_file_pages()
(freshly implemented for that specific purpose) to window into indices
and mailspools.


On Tue, Jul 01, 2003 at 09:49:15AM +0200, Andrea Arcangeli wrote:
> But as soon as you refuse to support largepages with remap_file_pages
> you automatically make it slower than mmap, and then remap_file_pages
> becomes almost useless (except for the emulators).

I'm really terribly unconvinced of this hugetlb + remap_file_pages()
stuff. I'm going to write it anyway, but there really isn't enough
overhead as it stands to save anything.


On Tue, Jul 01, 2003 at 09:49:15AM +0200, Andrea Arcangeli wrote:
> Note: remap_file_pages is not needed at all with current kernels, the
> only reason we may want to backport it to 2.4 is for the lower vma
> overhead (very minor issue) so maybe it's a 0.5-1% or similar (I'm only
> guessing). But the lack of largepage support would offset whatever
> benefit the vma overhead avoidance can provide IMHO (that applies to 2.5
> too of course).

AIUI it was a large issue for some databases (obviously not just the
standalone engine) that had large numbers of processes all performing
highly complex mappings (e.g. 5K vma's per process, 1500 processes or
some such nonsense on the same order(s) of magnitude).


On Mon, Jun 30, 2003 at 11:33:17PM -0700, William Lee Irwin III wrote:
>> In general the way to use it would be to treat virtualspace as a fully
>> associative cache. This also does not imply swapping since the stuff may
>> just as easily be cached in highmem. The fact one _could_ do it with
>> data sets large than RAM, albeit slowly, is also of interest. It would
>> effectively want random page replacement, e.g. a FIFO queue, and some
>> method of mitigating its impact on other applications on the system.

On Tue, Jul 01, 2003 at 09:49:15AM +0200, Andrea Arcangeli wrote:
> that would imply that those methods would be almost as fast as the true
> rmap algorithm for swapping? So why we don't use them for everything and
> we drop rmap? Or are you going to hack the kernel and reboot just before
> running a special emulator and hack this algorithm and reboot every time
> you change the application that uses remap_file_pages to get sane heavy
> swapping out of it?

So we're considering this case:
(a) single-threaded emulator
(b) a large file representing the memory windowed with remap_file_pages()
(c) best case page replacement == FIFO/random

Now, to get FIFO you have to queue pages in order and follow that order
when dequeueing them. Which means you have to be able to unmap an
arbitrary page determined by it falling off the cold end of the not-LRU
queue.

rmap would actually shine here. No pte_chains: every page mapped by the
emulator is PG_direct. It falls off the end of the FIFO queue and the
PTE is pointed at directly by the struct page and everything can be
unmapped in the perfectly random order it wants.

But what I was actually trying to hint at was local page replacment
with adaptive policies. And _no_, that has absolutely nothing to do
with walking the mmlist, and _no_, "local" does not mean some global
thread pounding over the known universe holding locks until the end
of time while doing O(processes*avg_virtualspace) algorithms. Trolls,
I know who you are. Don't jump in on this thread and don't bother me.


On Tue, Jul 01, 2003 at 09:49:15AM +0200, Andrea Arcangeli wrote:
> with your "swapping emulator" workload all the ram (either 1T or 10M)
> will be mapped in this vma populated with remap_file_pages. It's like
> running the emulator in a 2.4 kernel w/o rmap, with only the vma tree
> cost removed. If it's still always faster it means rmap saves less than
> the rbtree cost, and so basically rmap is useless since its main
> advantage is in terms of computational complexity IMHO.

No more RAM than fits into either the vma or virtualspace can be mapped
by a single process, even with remap_file_pages().

Could you restate this?


On Tue, Jul 01, 2003 at 09:49:15AM +0200, Andrea Arcangeli wrote:
> The fact is that as far as it's true that rmap pays off (I mean more
> than the rbtree cost), if you need to page the nonlinear vma, you'd
> better not use a nonlinear vma but to use the linear vmas instead so
> you'll get the real scalabile and optimized swapping algorithm. And in
> turn IMHO remap_file_pages makes sense only when you don't need to swap.
> making remap_file_pages pageables only helps in terms of security
> requirements as far as I can tell but that can be addressed more simply
> by a sysctl too (and then we can pass the fd to remap_file_pages too as
> last argument, which would be a very nice addition IMHO).

I'm very unconvinced by these arguments. remap_file_pages() makes good
sense whenever objects are very sparsely used, and I'd really rather
not restrict it to privileged apps.


On Mon, Jun 30, 2003 at 11:33:17PM -0700, William Lee Irwin III wrote:
>> You say that as if it's in the least bit feasible to get major apps to
>> change. They're almost as bad as hardware.

On Tue, Jul 01, 2003 at 09:49:15AM +0200, Andrea Arcangeli wrote:
> yes. But some db is allocating ~32G of shm in largepages and it runs
> significantly faster when the largepags are enabled, so I assume it must
> use 2M granularity somewhere to measure this difference.

This doesn't sound like a resource scalability issue. I'd not mind
hearing of where the speedups came from since there doesn't seem to be
anything that should make a large difference.


On Mon, Jun 30, 2003 at 11:33:17PM -0700, William Lee Irwin III wrote:
>> What on earth? 32KB granularity still needs the 3rd-level. I also fail

On Tue, Jul 01, 2003 at 09:49:15AM +0200, Andrea Arcangeli wrote:
> when the granularity is 2M (not 32k) it only walks 2 levels, the 3rd
> level doesn't exist with largepages. of course the pagetables will be
> the PAE ones still, but the largepages only generates 2 walks, there's
> no PTE, there's the pmd only. So it's like if it's a 2 level pagetables
> for the whole shm. If the app is smart enough to have some locality, the
> single tlb entry will cache what could otherwise generate multiple mmaps
> (and in turn tlb flushes) and multiple tlb entries.

The buffer pool is windowed with a 32KB granularity AFAIK. Mind if I
ask someone from Oracle? jlbec, could you clarify?


On Mon, Jun 30, 2003 at 11:33:17PM -0700, William Lee Irwin III wrote:
>> to see a resource scalability impact for the kernels bigpages are used
>> on since although they will be eliminated from consideration for
>> swapping, it's not in use in combination with rmap-based VM's that I
>> know of.

On Tue, Jul 01, 2003 at 09:49:15AM +0200, Andrea Arcangeli wrote:
> not sure to understand this sentence. There's no scalability issue at
> all related to remap_file_pages and largepages. If something they can
> help scalability by avoiding rmap (i.e. like mlock or with "slow swap
> ala 2.4").

That appears to be what people are using hugetlb for at the moment.


On Mon, Jun 30, 2003 at 11:33:17PM -0700, William Lee Irwin III wrote:
>> To measure scaling a performance metric (possibly workload feasibility)
>> and an input are required. For instance, throughput on SDET and number
>> of cpus, or amount of RAM and number of processes. "Scalability",
>> wherever it's unqualified by such things, is meaningless.

On Tue, Jul 01, 2003 at 09:49:15AM +0200, Andrea Arcangeli wrote:
> This was a ram scalability, the more you increase the amount of ram, the
> more you lose in those loops for GFP_KERNEL allocations. Overall I
> simply meant it works much better the biggest the box is.

IMHO 2.5.x has brought about a modicum of sanity in all kinds of places
so that more aggressive methods for scaling can be attacked in 2.7.x.
There are several major WIP here.


On Mon, Jun 30, 2003 at 11:33:17PM -0700, William Lee Irwin III wrote:
>> Well, the reason why it's per-zone and not just per-node is in point (b).

On Tue, Jul 01, 2003 at 09:49:15AM +0200, Andrea Arcangeli wrote:
> I know and it works perfectly for the highend but I seriously doubt it
> is the optimal design for normal 1-2G boxes.

I'll try to get a hold of Scott Kaplan to get an idea of how to
instrument things and compare the effectiveness on several zone
proportionalities.


On Mon, Jun 30, 2003 at 11:33:17PM -0700, William Lee Irwin III wrote:
>> The question is largely of whether the algorithm explodes when it's
>> asked to recover lowmem.

On Tue, Jul 01, 2003 at 09:49:15AM +0200, Andrea Arcangeli wrote:
> yeah the ram scalability. So we penalize the boxes where it wouldn't
> explode.

I'm not sure that argument really flies; things shouldn't really
explode ever. Then again, that doesn't really fly either, because all
you have to do to send any kernel into perpetually spinning with
interrupts off is boot it on a box with a sufficient number of cpus.


On Tue, Jul 01, 2003 at 09:49:15AM +0200, Andrea Arcangeli wrote:
> I agree being able to scale on the ~32G is much more important to run
> optimally on the 1-2G. My whole email is about pointing out and not
> forgetting that there are also downsides in those scalability
> enhacements. It's not always the case, but in this case definitely yes.
> In the 2.3.x days I definitely cared more about the 1-2G boxes than
> about the 32G ones.

Did your results ever making it to mailing list archives?


On Mon, Jun 30, 2003 at 11:33:17PM -0700, William Lee Irwin III wrote:
>> Unfortunately I don't have such a machine at my disposal (the discontig
>> code barfs on mem= at the moment). But I'd like to see the results.

On Tue, Jul 01, 2003 at 09:49:15AM +0200, Andrea Arcangeli wrote:
> A plain bonnie run with -s 1800 on a 2G box would be very interesting
> (it should in theory read it all from cache, and if my theory is right
> it will do some  worthless I/O instead during the read).

I borrowed a specweb client from Dave Hansen overnight. If I finish
debugging whatever went wrong with highpmd I'll try booting with mem=2G
since that isn't discontig.


-- wli
