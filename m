Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265788AbTGDFlE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 01:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265802AbTGDFlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 01:41:04 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:8839
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265788AbTGDFkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 01:40:11 -0400
Date: Fri, 4 Jul 2003 07:54:26 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, Rik van Riel <riel@redhat.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
Message-ID: <20030704055426.GW23578@dualathlon.random>
References: <20030703125839.GZ23578@dualathlon.random> <Pine.LNX.4.44.0307030904260.16582-100000@chimarrao.boston.redhat.com> <20030703185341.GJ20413@holomorphy.com> <20030703192750.GM23578@dualathlon.random> <20030703201607.GK20413@holomorphy.com> <20030704004000.GQ23578@dualathlon.random> <20030704014624.GN20413@holomorphy.com> <20030704023414.GV23578@dualathlon.random> <20030704041048.GO20413@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030704041048.GO20413@holomorphy.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 03, 2003 at 09:10:48PM -0700, William Lee Irwin III wrote:
> On Thu, Jul 03, 2003 at 06:46:24PM -0700, William Lee Irwin III wrote:
> >> What minor faults? remap_file_pages() does pagecache lookups and
> 
> On Fri, Jul 04, 2003 at 04:34:14AM +0200, Andrea Arcangeli wrote:
> > with minor faults I meant the data in cache, and you calling
> > remap_file_pages to make it visible to the app. with minor faults I
> > meant only the cpu cost of the remap_file_pages operation, without the
> > need of hitting on the disk with ->readpage.
> 
> Well, those aren't minor faults. That's prefaulting.

you still enter the kernel, just via the syscall as opposed than via an
exception of the usual minor faults, the overhead should be similar.
Also note that the linear mapping would never need to enter kernel after
the initial major fault (until you start doing paging because you run
out of resources, and that's managed by the vm at best w/o replication
of replacement algorithms in the user program).

> On Thu, Jul 03, 2003 at 06:46:24PM -0700, William Lee Irwin III wrote:
> >> Space _does_ matter. Everywhere. All the time. And it's not just
> >> virtualspace this time. Throw away space, and you go into page or
> >> pagetable replacement.
> 
> On Fri, Jul 04, 2003 at 04:34:14AM +0200, Andrea Arcangeli wrote:
> > So you admit you're wrong and that your usage is only meant to save
> > ram and that given enough ram your usage of remap_file_pages only wastes
> > cpu? Note that I given as strong assumption the non-interest in saving
> > ram. You're now saying that the benefit of your usage is to save ram.
> > Sure it will save ram.
> 
> That was its explicit purpose for 32-bit and it's usable for that
> same purpose on 64-bit. You're citing the precise scenario where
> remap_file_pages() is used on 32-bit!

on 64bit you don't need remap_file_pages to keep all the shm mapped. I
said it a dozen of times in the last emails.

> On Fri, Jul 04, 2003 at 04:34:14AM +0200, Andrea Arcangeli wrote:
> > But if your object is to save ram you're still wrong, it's an order of
> > magnitude more efficient to use shm and to load your scattered data with
> > aio + O_DIRECT/rawio to do the I/O, so you will also be able to
> > trivially use largepages and other things w/o messing the pagecache with
> > larepage knowledge, and furthmore without ever needing a tlb flush or a
> > pte mangling (pte mangling assuming you don't use largepages, pmd
> > mangling if you user largepages).
> > So your usage of remap_file_pages is worthless always.
> 
> Incorrect. First, the above scenario is precisely where databases are
> using remap_file_pages() on 32-bit. Second, the above circumvents the

also in 64bit and they're right since they don't want to mangle
pagetables and flush tlb every time they have to look at a different
piece of the db. You have to if you use remap_file_pages on the mapped
"pool" of pages. The pool being the shm is the most efficient solution
to avoid flushing and replacing ptes all the time.

> pagecache and on machines with limited resources incurs swap overhead
> as opposed to the data cache being reclaimable via simple VM writeback.

I addressed this in the last email.

> Third, it requires an application to perform its own writeback, which
> is a transparency deficit in the above API's (though for database
> engines it's fine as they would very much like to be aware of such
> things and to more or less have the entire machine dedicated to them).

This is my point. Either you go w/o the OS, or you trust the OS and you
take the linear map. The intermediate thing is not as efficient and
flexible as the shm and the linear mapping, and you need to take all the
difficult decisions about what has to be mapped and what not in
userspace anyways.

> On Fri, Jul 04, 2003 at 04:34:14AM +0200, Andrea Arcangeli wrote:
> > In short:
> > 1) if you want to save space it's the wrong design since it's an order of
> > magnitude slower of using direct-io on shared memory (with all the advantage
> > that it provides in terms of largepages and tlb preservation)
> 
> I already countered this argument in the earlier post, even before
> you made it.
> 
> 
> On Fri, Jul 04, 2003 at 04:34:14AM +0200, Andrea Arcangeli wrote:
> > 2) you don't need to save space then you'd better not waste time with
> > remap_file_pages and mmap the file linearly (my whole argument for all
> > my previous emails) And if something if you go to rewrite the app to
> > coalesce the VM side, you'd better coalesce the I/O side instead, then
> > the vm side will be free with the linear mapping with huge performance
> > advantages thanks to the locality knowledge (much more significant than
> > whatever remap_file_pages improvement, especially for the I/O side with
> > the major faults that will for sure happen at least once during startup,
> > often the disks are much bigger than ram). Of course the linear mapping
> > also involves trusting the OS paging meachanism to unmap pages
> > efficiently, while you do it by hand, and the OS can be much smarter
> > and efficient than duplicating VM management algorithms in every
> > userspace app using remap_file_pages. The OS will only unmap the
> > overflowing pages of data. the only requirement is to have ram >=
> > sizeofdisk >> 12 (this wouldn't even be a requirement with Rik's
> > pmd reclaim).
> 
> That's quite some limitation!
> 
> At any rate, as unimpressed as I was with the other arguments, this
> really fails to impress me as you're directly arguing for enforcing
> one of the resource scalability limitation remap_file_pages() lifts.

I don't care about memory resources for the ptes. And just to make the
most obvious example you're not hitting any harddisk when you click "I'm
feeling lucky" in google.

And the limitation exists only because it's not a limitation and nobody
cares. The day somebody will complain zeroed pmd will be reclaimed and
it'll go away (as Rik suggested a dozen of emails ago).

> On Thu, Jul 03, 2003 at 06:46:24PM -0700, William Lee Irwin III wrote:
> >> Filesystems don't use mmap() to simulate access to the B-trees, they
> 
> On Fri, Jul 04, 2003 at 04:34:14AM +0200, Andrea Arcangeli wrote:
> > One of the reasons I did the blkdev in pagecache in 2.4 is that the
> > partd developer asked me to use a _linear_ mmap to make the VM
> > management an order of magnitude more efficient for parsing the fs.
> > Otherwise he never knows how much ram it can allocate and during boot
> > the ram may be limited. mmap solves this completely leaving the decision
> > to the VM and it basically gives no limit in how low memory a system can
> > be to run parted.
> 
> There's nothing wrong with linearly mapping something when it
> doesn't present a problem (e.g. pagetable space out the wazoo).

so then go ahead and fix it, if the exploit for you is still not running
good enough.

Linus already fixed the biggest issue with the exploit, what was needed
to be fixed years ago, nobody ever complained again. That's the pmd
reclaim when the whole pgd is empty.

I would at least like to hear a real life request or bugreport about
running out of pte with the linear mapping or whatever real life usage,
before falling into what I consier worthless overengeneering. At least
until somebody complains and asks for it. Especially given I can't see
any benefit.

> On Fri, Jul 04, 2003 at 04:34:14AM +0200, Andrea Arcangeli wrote:
> > Your saying that the in-kernel fs don't use mmap is a red-herring, of
> > course I know about that but it's totally unrelated to my point. The
> > only reason they do it is for the major faults (they can't care less if
> > they get the data through a linear mapping or a bh or a bio or a
> > pagecache entry). But of course if you add some locality the vm side
> > will be better to with mmap. I mean, there are worse problems than the
> > vm side if you costsantly seek all over the place.
> 
> What on earth? Virtual locality is exactly what remap_file_pages()

I'm talking about I/O locality, on the file. This is why I said that
there are worse problems than the vm side, if you costantly seek with
the I/O.

> restores to otherwise sparse access. Also c.f. the prior post as to
> maintaining a large enough cache so as not to be seek-bound. If your

you've also to write the stuff, besides trying to avoid nearly unused
pagetables at the same time, locality always helps even with lots of
cache. They're not all reads.

> cache isn't getting a decent number of hits, you're dead with or
> without remap_file_pages(); it can only save you from the contents of
> it not being file offset contiguous. And it has to be that much
> better of a cache for not being so.
> 
> 
> On Fri, Jul 04, 2003 at 04:34:14AM +0200, Andrea Arcangeli wrote:
> > And if you always seek reproducibly in the same places scattered
> > everywhere, then you can fix it on the design application side likely.
> 
> That's fine. If you really get that many seeks, you need to fix it.

thanks, at least we can agree on this.

> 
> 
> On Fri, Jul 04, 2003 at 04:34:14AM +0200, Andrea Arcangeli wrote:
> > And anyways the linear mapping will always be faster than
> > remap_file_pages, as worse you need pagetable reclaim if you can't live
> > with ram >= btreesize >> 12. And if you really want to save pagetable
> > ram you must use shm + aio/o_direct, remap_file_pages is worthless.
> 
> A linear mapping will be dog slow if an entire pagetable page must be
> reconstituted for each minor fault and a minor fault is taken on a
> large proportion of accesses (due to the pagetables needing to be GC'd
> and page replacement evicting what could otherwise be used as cache),
> which is effectively what you're proposing.

minor faults should happen raraly with pure mmap I/O. Depends enterely
on the vm algorithms though. And the pageout will happen with
remap_file_pages with the difference that remap_file_page forces the
user to code for a certain number of pagetables, that he can't know
about. So it's as hard as the shm + aio + largepages + rawio/O_DIRECT
from the end user and it needs more tuning as well. And it is slower
than the linear mapping due the tlb flushing that may happen even if
you're not out of resources if tuning isn't perfect for your hardware.

the only difference w.r.t. minor faults is the initial state post mmap
(vs post remap_file_pages), but nothing prevents me to add a
sys_populate, that in a single kernel entry/exit overhead will populate
all the needed ranges (you can pass an array of ranges to the kernel).
That would avoid the issue with mlock that is privilegied and a single
call could load all important regions of the data.

> On Fri, Jul 04, 2003 at 04:34:14AM +0200, Andrea Arcangeli wrote:
> > The only reason remap_file_pages exists is to have a window on the
> > SHM!!!! On the 64bit this makes no sense at all. It would make no sense
> > at all to take a window on the shm.
> 
> It was what motivated its creation. It is more generally useful and
> doesn't smack of a brutal database hack, which is why I don't find it
> as distasteful as DSHM etc. from other kernels.

database hack? Give me a faster database hack and I'm sure database will
start using it immediatly, no matter if you find it cleaner or not.

In this case you are trying to convince me of the superiority of a
solution that in your own opinion is "cleaner", but that's slower
lacks aio, largepages and it mangles pagetables and flushes tlbs for no
good reasons at every new bit of window watched from disk and it can't
even control writeback in a finegrined manner (again with aio). I'm
pretty sure nobody will care about it.

Oh and you need to control writeback anyways, with msync minimum, or
if the box crashes you'll find nothing on disk.

If you start dropping the disavantages and you start adding at least one
advantage, there's a chance that your design solution will change from
inferior to superior than what you call the "database hack".

> This is incorrect. Minor faults are large overheads, especially when
> they require pagetable pages to be instantiated. They are every bit as
> expensive as interrupts (modulo drivers doing real device access there)
> or int $0x80 -based system calls.

and you suffer from them too, since remap_file_pages is pageable.

> I'm with you on everything except shm; in fact, shm can never be used
> directly with it (only through tmpfs) as it requires fd's to operate.

shm == shmfs == tmpfs, I only care about the internals in-kernel, I
don't mind which api you use, go with MAP_SHARED on /dev/zero if that's
what you like. Of course tmpfs is the cleanest to handle while coding.

> This is a valid thing to do, especially for database engines. It's
> not for everything, of course, especially things that don't want to
> take over the entire machine.

problem is that you've to take over the whole machine anyways with your
"pte saving" remap_file_pages to know how many ptes you can allocate you
need all the hardware details and your program won't be a generic simple
and flexible libgdbm then.

Sure you saves ptes, but you waste tlb and forbids all the other
features that you're going to need if you do anything remotely that can
go near to hit a pte limitation issue at runtime.

> On Fri, Jul 04, 2003 at 04:34:14AM +0200, Andrea Arcangeli wrote:
> > 	   however when you fall into 2b (and not 2a) you basically are
> > 	   at a level of optimization where you want to takeover the machine
> > 	   enterely so usually no swap is needed and you can't use
> > 	   remap_file_pages or mmap anyways since you need aio and
> > 	   largepages and no tlb flushes etc..
> > normal apps should take 2a
> > big irons running on millions of installations should take 2b
> 
> Why is it inappropriate for normal apps that aren't going to take over
> the entire machine to be space-efficient with respect to pagetables?

because it's a kind of intermediate solution that doesn't worth, linear
vma will be more efficient, and it is completely generic.

I ask you to find an app that runs out of pte today, tell me the
bugzilla #number in kernel.org, and that remap_file_pages is what it
wants, IMHO if something likely it wants the pte reclaim instead. Or it
wants to switch to using shm.

> what. And that effort is close to 99% wasted counting userbase-wise if

What do you think your pmdhighmem effort will be useful for, 10 years
from now? (I hope, otherwise we'd be screwed anyways moving everything
into highmem, not just the pte and pmd ;) It's the same logic, temporary
32bit hacks useful for the short term.

Are you going to implement highmem on 64bit archs so it won't be a
wasted effort? I think it's the same problem (modulo the emulator case
that IMHO should be ok with the sysctl too, the VM bypass as a concept
sounds clean enough to me). I also think I forgot why the emulator it's
not using the more efficient solution of shm + O_DIRECT.

> On Thu, Jul 03, 2003 at 06:46:24PM -0700, William Lee Irwin III wrote:
> >> Sorry, this line of argument is specious.
> 
> On Fri, Jul 04, 2003 at 04:34:14AM +0200, Andrea Arcangeli wrote:
> > It's so strightforward that it's incidentally how all applications are
> > coded today and in no way remap_file_pages can give any performance or
> > space advantage (except for mapping the shm that can't be mapped all at
> > the same time in 32bit systems)
> 
> Well, the conclusion isn't effectively supported by the evidence.
> 
> It's clear it does what it does, has its various features, and has its
> uses.

also pmdhighmem can have uses on 64bit archs, it will work but it
doesn't mean it's useful.

> 
> On 64-bit, if you need to mmap() something that you would bog the box 
> down with pagetables when doing it, it's how apps can cooperate and not
> fill up RAM with redundant and useless garbage (pagetables with only
> one pte a piece set in them). On 32-bit, it's how you can get at many
> pieces of something simultaneously at all. We've already got it, let's
> not castrate it before it ever ships. Heck, I could have written the
> fixups for truncate() in the time it took to write all these messages.
> 
> How about this: I fix up truncate() and whatever else cares, and all
> this hassle ends right then?

I would certainly like to see the truncate fixed.

> 
> The opponents of the thing seem to be vastly overestimating its impact
> on the VM AFAICT.

Well, just the fact it has any impact at all is not a good thing IMHO.

Anyways, even if we've no time for benchmarks now, in a few years we'll
see who's right, I'm sure if it's useful as you claim we'll have to see
all the big apps switching to it in their 64bit ports.  My bet is that
it will never happen unless something substantial changes in its
features, because in its current 2.5 form it provides many disavantages
and zero advantages as far as I can tell (especially if you want mlock
and not remap_file_pages to be the way to destroy the rmap pte_chains).
Even in 2.4 it is almost not worth the effort w/o rmap. Would be very
interesting to genreate some number to see -aa w/ remap_file_pages and
w/o infact (2.5 is unusable in some high end setup due rmap currently,
yeah i know you want to drop rmap via mlock and to use PAM to raise
privilegies so you can call mlock on the shm, instead of implementing
the trivial clean and non VM-visible VM bypass + sysctl; what's the 2.6
planned release date btw?  end of August right? [I hope :) ])

Andrea
