Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265841AbTGDIBY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 04:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265843AbTGDIBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 04:01:24 -0400
Received: from holomorphy.com ([66.224.33.161]:63178 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265841AbTGDIBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 04:01:14 -0400
Date: Fri, 4 Jul 2003 01:15:22 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Rik van Riel <riel@redhat.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
Message-ID: <20030704081522.GP20413@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@redhat.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>, Mel Gorman <mel@csn.ul.ie>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030703125839.GZ23578@dualathlon.random> <Pine.LNX.4.44.0307030904260.16582-100000@chimarrao.boston.redhat.com> <20030703185341.GJ20413@holomorphy.com> <20030703192750.GM23578@dualathlon.random> <20030703201607.GK20413@holomorphy.com> <20030704004000.GQ23578@dualathlon.random> <20030704014624.GN20413@holomorphy.com> <20030704023414.GV23578@dualathlon.random> <20030704041048.GO20413@holomorphy.com> <20030704055426.GW23578@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030704055426.GW23578@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 03, 2003 at 09:10:48PM -0700, William Lee Irwin III wrote:
>> Well, those aren't minor faults. That's prefaulting.

On Fri, Jul 04, 2003 at 07:54:26AM +0200, Andrea Arcangeli wrote:
> you still enter the kernel, just via the syscall as opposed than via an
> exception of the usual minor faults, the overhead should be similar.
> Also note that the linear mapping would never need to enter kernel after
> the initial major fault (until you start doing paging because you run
> out of resources, and that's managed by the vm at best w/o replication
> of replacement algorithms in the user program).

remap_file_pages() prefaults a range, not a single pte.


On Fri, Jul 04, 2003 at 07:54:26AM +0200, Andrea Arcangeli wrote:
> on 64bit you don't need remap_file_pages to keep all the shm mapped. I
> said it a dozen of times in the last emails.

That's not what it's used for on 64-bit. shm segments are far too small
anyway; they're normally smaller than RAM. Obviously the cost of
pagetables is insignificant until much larger areas (by a factor of
at least PAGE_SIZE/sizeof(pte_t) and usually much larger in the case of
sparse mappings) are mapped.


On Thu, Jul 03, 2003 at 09:10:48PM -0700, William Lee Irwin III wrote:
>> Incorrect. First, the above scenario is precisely where databases are
>> using remap_file_pages() on 32-bit. Second, the above circumvents the

On Fri, Jul 04, 2003 at 07:54:26AM +0200, Andrea Arcangeli wrote:
> also in 64bit and they're right since they don't want to mangle
> pagetables and flush tlb every time they have to look at a different
> piece of the db. You have to if you use remap_file_pages on the mapped
> "pool" of pages. The pool being the shm is the most efficient solution
> to avoid flushing and replacing ptes all the time.

Anything with intelligence would treat the virtualspace as a cache of
mappings and so won't incur that overhead unless wildly thrashing,
and that's no different on 32-bit or 64-bit.


On Thu, Jul 03, 2003 at 09:10:48PM -0700, William Lee Irwin III wrote:
>> pagecache and on machines with limited resources incurs swap overhead
>> as opposed to the data cache being reclaimable via simple VM writeback.

On Fri, Jul 04, 2003 at 07:54:26AM +0200, Andrea Arcangeli wrote:
> I addressed this in the last email.

Where I refuted it.


On Thu, Jul 03, 2003 at 09:10:48PM -0700, William Lee Irwin III wrote:
>> Third, it requires an application to perform its own writeback, which
>> is a transparency deficit in the above API's (though for database
>> engines it's fine as they would very much like to be aware of such
>> things and to more or less have the entire machine dedicated to them).

On Fri, Jul 04, 2003 at 07:54:26AM +0200, Andrea Arcangeli wrote:
> This is my point. Either you go w/o the OS, or you trust the OS and you
> take the linear map. The intermediate thing is not as efficient and
> flexible as the shm and the linear mapping, and you need to take all the
> difficult decisions about what has to be mapped and what not in
> userspace anyways.

The app is trusting the kernel regardless unless it's running in
supervisor mode; this is merely another memory mapping API.


On Thu, Jul 03, 2003 at 09:10:48PM -0700, William Lee Irwin III wrote:
>> That's quite some limitation!
>> At any rate, as unimpressed as I was with the other arguments, this
>> really fails to impress me as you're directly arguing for enforcing
>> one of the resource scalability limitation remap_file_pages() lifts.

On Fri, Jul 04, 2003 at 07:54:26AM +0200, Andrea Arcangeli wrote:
> I don't care about memory resources for the ptes. And just to make the
> most obvious example you're not hitting any harddisk when you click "I'm
> feeling lucky" in google.

Well it seems you either don't understand pagetable space issues or
deliberately refuse to acknowledge they exist. Which seems highly
unusual for the originator of pte-highmem (which IIRC shoved pmd's
into highmem too =).

Denying the issue exists isn't going to make it go away.


On Fri, Jul 04, 2003 at 07:54:26AM +0200, Andrea Arcangeli wrote:
> And the limitation exists only because it's not a limitation and nobody
> cares. The day somebody will complain zeroed pmd will be reclaimed and
> it'll go away (as Rik suggested a dozen of emails ago).

PTE garbage collection's inefficiency is rather obvious. It's necessary
for correctness, not desirable (apart from correctness being desirable
and the PTE's being such worthless garbage you'd much rather dump them).


On Thu, Jul 03, 2003 at 09:10:48PM -0700, William Lee Irwin III wrote:
>> There's nothing wrong with linearly mapping something when it
>> doesn't present a problem (e.g. pagetable space out the wazoo).

On Fri, Jul 04, 2003 at 07:54:26AM +0200, Andrea Arcangeli wrote:
> so then go ahead and fix it, if the exploit for you is still not running
> good enough.

What the hell? This isn't an exploit. This is the kernel giving
userspace a way to carry out perfectly valid userspace farting around
without degenerating into butt slow uselessness.

Virtual mappings are not free. Virtual mappings cost physical memory.
remap_file_pages() is a more space-efficient virtual mapping API
(which is also the 32-bit case -- there it can actually squeeze into
the tiny virtualspace where linear mappings cannot).

There's nothing particularly hard to understand about this.


On Fri, Jul 04, 2003 at 07:54:26AM +0200, Andrea Arcangeli wrote:
> Linus already fixed the biggest issue with the exploit, what was needed
> to be fixed years ago, nobody ever complained again. That's the pmd
> reclaim when the whole pgd is empty.

That's not the biggest issue, though it does count as a space leak.


On Fri, Jul 04, 2003 at 07:54:26AM +0200, Andrea Arcangeli wrote:
> I would at least like to hear a real life request or bugreport about
> running out of pte with the linear mapping or whatever real life usage,
> before falling into what I consier worthless overengeneering. At least
> until somebody complains and asks for it. Especially given I can't see
> any benefit.

Already exists and has since something like 2.4.0, and on a 64-bit
platform at that. I'll see what I can fish out of internal sources.

For fsck's sake, "worthless overengineering"? This is approaching
trolling. The thing is literally already in the kernel and I'm
literally arguing nothing more than preserving its current semantics.


On Thu, Jul 03, 2003 at 09:10:48PM -0700, William Lee Irwin III wrote:
>> What on earth? Virtual locality is exactly what remap_file_pages()

On Fri, Jul 04, 2003 at 07:54:26AM +0200, Andrea Arcangeli wrote:
> I'm talking about I/O locality, on the file. This is why I said that
> there are worse problems than the vm side, if you costantly seek with
> the I/O.

You said something about VM heuristics. But anyway.

The memory footprint is actually irrelevant to this; it'll seek
regardless of whether the mapping is linear or not as it will access
the same data regardless. With a smaller pagetable overhead, it can
cache more data.


On Thu, Jul 03, 2003 at 09:10:48PM -0700, William Lee Irwin III wrote:
>> restores to otherwise sparse access. Also c.f. the prior post as to
>> maintaining a large enough cache so as not to be seek-bound. If your

On Fri, Jul 04, 2003 at 07:54:26AM +0200, Andrea Arcangeli wrote:
> you've also to write the stuff, besides trying to avoid nearly unused
> pagetables at the same time, locality always helps even with lots of
> cache. They're not all reads.

But the linear mapping does nothing to address the file offset locality.
The access pattern with respect to file offset is identical in both
cases.


On Thu, Jul 03, 2003 at 09:10:48PM -0700, William Lee Irwin III wrote:
>> A linear mapping will be dog slow if an entire pagetable page must be
>> reconstituted for each minor fault and a minor fault is taken on a
>> large proportion of accesses (due to the pagetables needing to be GC'd
>> and page replacement evicting what could otherwise be used as cache),
>> which is effectively what you're proposing.

On Fri, Jul 04, 2003 at 07:54:26AM +0200, Andrea Arcangeli wrote:
> minor faults should happen raraly with pure mmap I/O. Depends enterely
> on the vm algorithms though. And the pageout will happen with
> remap_file_pages with the difference that remap_file_page forces the
> user to code for a certain number of pagetables, that he can't know
> about. So it's as hard as the shm + aio + largepages + rawio/O_DIRECT
> from the end user and it needs more tuning as well. And it is slower
> than the linear mapping due the tlb flushing that may happen even if
> you're not out of resources if tuning isn't perfect for your hardware.

Minor faults rare on sparse linear mappings? NFI what you're smoking
but pass it here, I could use something to cheer me up.


On Fri, Jul 04, 2003 at 07:54:26AM +0200, Andrea Arcangeli wrote:
> the only difference w.r.t. minor faults is the initial state post mmap
> (vs post remap_file_pages), but nothing prevents me to add a
> sys_populate, that in a single kernel entry/exit overhead will populate
> all the needed ranges (you can pass an array of ranges to the kernel).
> That would avoid the issue with mlock that is privilegied and a single
> call could load all important regions of the data.

On Thu, Jul 03, 2003 at 09:10:48PM -0700, William Lee Irwin III wrote:
>> It was what motivated its creation. It is more generally useful and
>> doesn't smack of a brutal database hack, which is why I don't find it
>> as distasteful as DSHM etc. from other kernels.

On Fri, Jul 04, 2003 at 07:54:26AM +0200, Andrea Arcangeli wrote:
> database hack? Give me a faster database hack and I'm sure database will
> start using it immediatly, no matter if you find it cleaner or not.

A moment ago remap_file_pages() was slow, now it's fast. Which is it?


On Fri, Jul 04, 2003 at 07:54:26AM +0200, Andrea Arcangeli wrote:
> In this case you are trying to convince me of the superiority of a
> solution that in your own opinion is "cleaner", but that's slower
> lacks aio, largepages and it mangles pagetables and flushes tlbs for no
> good reasons at every new bit of window watched from disk and it can't
> even control writeback in a finegrined manner (again with aio). I'm
> pretty sure nobody will care about it.

Where on earth are aio and large pages coming into the picture?

Well, anyway, I can burn a few minutes and bang out remap_file_pages()
for hugetlbfs and an aio remap_file_pages() opcode to silence this one
when I'm done with the truncate() bug.


On Fri, Jul 04, 2003 at 07:54:26AM +0200, Andrea Arcangeli wrote:
> Oh and you need to control writeback anyways, with msync minimum, or
> if the box crashes you'll find nothing on disk.

If the box crashes you're in deep shit regardless of API.


On Fri, Jul 04, 2003 at 07:54:26AM +0200, Andrea Arcangeli wrote:
> If you start dropping the disavantages and you start adding at least one
> advantage, there's a chance that your design solution will change from
> inferior to superior than what you call the "database hack".

Presumably you're going on about the unimplemented space conservation
features. I'll have to bang them out to silence this kind of crap.


On Thu, Jul 03, 2003 at 09:10:48PM -0700, William Lee Irwin III wrote:
>> This is incorrect. Minor faults are large overheads, especially when
>> they require pagetable pages to be instantiated. They are every bit as
>> expensive as interrupts (modulo drivers doing real device access there)
>> or int $0x80 -based system calls.

On Fri, Jul 04, 2003 at 07:54:26AM +0200, Andrea Arcangeli wrote:
> and you suffer from them too, since remap_file_pages is pageable.

But since it's conserved RAM, it won't need to be paged out.


On Thu, Jul 03, 2003 at 09:10:48PM -0700, William Lee Irwin III wrote:
>> I'm with you on everything except shm; in fact, shm can never be used
>> directly with it (only through tmpfs) as it requires fd's to operate.

On Fri, Jul 04, 2003 at 07:54:26AM +0200, Andrea Arcangeli wrote:
> shm == shmfs == tmpfs, I only care about the internals in-kernel, I
> don't mind which api you use, go with MAP_SHARED on /dev/zero if that's
> what you like. Of course tmpfs is the cleanest to handle while coding.

But those _are_ the internals, the userspace-visible API's are vastly
different (hence the distinction I made).


On Thu, Jul 03, 2003 at 09:10:48PM -0700, William Lee Irwin III wrote:
>> This is a valid thing to do, especially for database engines. It's
>> not for everything, of course, especially things that don't want to
>> take over the entire machine.

On Fri, Jul 04, 2003 at 07:54:26AM +0200, Andrea Arcangeli wrote:
> problem is that you've to take over the whole machine anyways with your
> "pte saving" remap_file_pages to know how many ptes you can allocate you
> need all the hardware details and your program won't be a generic simple
> and flexible libgdbm then.

Not at all. All that information is unprivileged and available from
/proc/ and other sources. Being self-tuning and adapting to the
surroundings based on unprivileged information is nothing remotely
like taking over the machine at all.


On Fri, Jul 04, 2003 at 07:54:26AM +0200, Andrea Arcangeli wrote:
> Sure you saves ptes, but you waste tlb and forbids all the other
> features that you're going to need if you do anything remotely that can
> go near to hit a pte limitation issue at runtime.

You do need enough virtualspace to have an effective cache.

I'm unconvinced of the alternative pte mitigation strategy argument:

(a) x86 and/or that disgusting attempt to immortalize it are the only
	ones that truncate the radix tree with large pages (worse yet
	they actually interpret the FPOS's in hardware), and even worse
	yet, the approach risks severe internal cache fragmentation.

(b) shared pagetables require something to share with
	the assumption all along here is a single process

(c) sure, GC'ing pagetables will make it feasible, but it just turns
	from a kernel correctness issue to an API efficiency issue

It's a different situation, which wants a different technique used
to cope with and/or optimize it.


On Thu, Jul 03, 2003 at 09:10:48PM -0700, William Lee Irwin III wrote:
>> Why is it inappropriate for normal apps that aren't going to take over
>> the entire machine to be space-efficient with respect to pagetables?

On Fri, Jul 04, 2003 at 07:54:26AM +0200, Andrea Arcangeli wrote:
> because it's a kind of intermediate solution that doesn't worth, linear
> vma will be more efficient, and it is completely generic.
> I ask you to find an app that runs out of pte today, tell me the
> bugzilla #number in kernel.org, and that remap_file_pages is what it
> wants, IMHO if something likely it wants the pte reclaim instead. Or it
> wants to switch to using shm.

I'll see if I can get the internal sources to ship a writeup to
bugme.osdl.org. IIRC this is truly ancient (and on 64-bit) so I may
have to find different internal contacts from the original ones.


On Thu, Jul 03, 2003 at 09:10:48PM -0700, William Lee Irwin III wrote:
>> what. And that effort is close to 99% wasted counting userbase-wise if

On Fri, Jul 04, 2003 at 07:54:26AM +0200, Andrea Arcangeli wrote:
> What do you think your pmdhighmem effort will be useful for, 10 years
> from now? (I hope, otherwise we'd be screwed anyways moving everything
> into highmem, not just the pte and pmd ;) It's the same logic, temporary
> 32bit hacks useful for the short term.

The 32-bit machines won't ever change. It will be every bit as useful
on 32-bit machines 10 years from now as it is now, not to say they'll
be much more than legacy systems at that point. But legacy systems
aren't unimportant.

This hardware switcharoo argument is utter bullshit; all the grossly
offensive attempts to immortalize x86 in the world won't fix a single
bug that prevents my SS1 from booting and so on and so forth.

Unfortunately there's nothing obvious I can do to shut up the
disseminators of this insidious tripe.


On Fri, Jul 04, 2003 at 07:54:26AM +0200, Andrea Arcangeli wrote:
> Are you going to implement highmem on 64bit archs so it won't be a
> wasted effort? I think it's the same problem (modulo the emulator case

No. This is a patently ridiculous notion. One architecture's needs for
core kernel support are generally unrelated to another's.


On Fri, Jul 04, 2003 at 07:54:26AM +0200, Andrea Arcangeli wrote:
> that IMHO should be ok with the sysctl too, the VM bypass as a concept
> sounds clean enough to me). I also think I forgot why the emulator it's
> not using the more efficient solution of shm + O_DIRECT.

If you need a VM bypass, the VM isn't good enough.


On Thu, Jul 03, 2003 at 09:10:48PM -0700, William Lee Irwin III wrote:
>> Well, the conclusion isn't effectively supported by the evidence.
>> It's clear it does what it does, has its various features, and has its
>> uses.

On Fri, Jul 04, 2003 at 07:54:26AM +0200, Andrea Arcangeli wrote:
> also pmdhighmem can have uses on 64bit archs, it will work but it
> doesn't mean it's useful.

AFAICT highpmd is just source-level noise for 64-bit arches. The only
potential use would be establishing virtual contiguity for pmd's, but
IMHO that technique is not useful in Linux and appears to have a very
obvious poor interaction with the core VM that prevents it from ever
being an optimization.


On Thu, Jul 03, 2003 at 09:10:48PM -0700, William Lee Irwin III wrote:
>> The opponents of the thing seem to be vastly overestimating its impact
>> on the VM AFAICT.

On Fri, Jul 04, 2003 at 07:54:26AM +0200, Andrea Arcangeli wrote:
> Well, just the fact it has any impact at all is not a good thing IMHO.

It's a feature, it has to have _some_ impact.


On Fri, Jul 04, 2003 at 07:54:26AM +0200, Andrea Arcangeli wrote:
> Anyways, even if we've no time for benchmarks now, in a few years we'll
> see who's right, I'm sure if it's useful as you claim we'll have to see
> all the big apps switching to it in their 64bit ports.  My bet is that
> it will never happen unless something substantial changes in its
> features, because in its current 2.5 form it provides many disavantages
> and zero advantages as far as I can tell (especially if you want mlock
> and not remap_file_pages to be the way to destroy the rmap pte_chains).

This is something of an excessively high hurdle. It has uses, but it's
not a Swiss army knife.

As for the pte_chain savings, your entire argument was to bolt mlock()
semantics onto remap_file_pages() to accomplish (you guessed it!) the
exact same thing, in almost the same way, even.


On Fri, Jul 04, 2003 at 07:54:26AM +0200, Andrea Arcangeli wrote:
> Even in 2.4 it is almost not worth the effort w/o rmap. Would be very
> interesting to genreate some number to see -aa w/ remap_file_pages and
> w/o infact (2.5 is unusable in some high end setup due rmap currently,
> yeah i know you want to drop rmap via mlock and to use PAM to raise
> privilegies so you can call mlock on the shm, instead of implementing
> the trivial clean and non VM-visible VM bypass + sysctl; what's the 2.6
> planned release date btw?  end of August right? [I hope :) ])

And the benchmarks have already been done, and they showed rather hefty
speedups over mmap(). And that was with pte_chains and all.

As for 2.5 being unusable in high-end setups, I run it on 32GB i386
daily and test on 64GB i386 every once in a while, albeit with some
patches, and run and optimize various kinds of benchmarks there.


-- wli
