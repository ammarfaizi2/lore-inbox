Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265669AbTGDCZk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 22:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265653AbTGDCZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 22:25:19 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:49881
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265669AbTGDCTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 22:19:52 -0400
Date: Fri, 4 Jul 2003 04:34:14 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, Rik van Riel <riel@redhat.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
Message-ID: <20030704023414.GV23578@dualathlon.random>
References: <20030703125839.GZ23578@dualathlon.random> <Pine.LNX.4.44.0307030904260.16582-100000@chimarrao.boston.redhat.com> <20030703185341.GJ20413@holomorphy.com> <20030703192750.GM23578@dualathlon.random> <20030703201607.GK20413@holomorphy.com> <20030704004000.GQ23578@dualathlon.random> <20030704014624.GN20413@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030704014624.GN20413@holomorphy.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 03, 2003 at 06:46:24PM -0700, William Lee Irwin III wrote:
> On Fri, Jul 04, 2003 at 02:40:00AM +0200, Andrea Arcangeli wrote:
> > the fact is, no matter the VM side, your app has no way to nearly
> > perform in terms of I/O seeks if you're filling a page per pmd due the
> > huge seek it will generate with the major faults. And even the minor
> > faults if has no locality at all and it seeks all over the place in a
> > non predictable manner, the tlb flushes will kill performance compared
> > to keeping the file mapped statically, and it'll make it even slower
> > than accessing a new pte every time.
> 
> What minor faults? remap_file_pages() does pagecache lookups and

with minor faults I meant the data in cache, and you calling
remap_file_pages to make it visible to the app. with minor faults I
meant only the cpu cost of the remap_file_pages operation, without the
need of hitting on the disk with ->readpage.

> On Fri, Jul 04, 2003 at 02:40:00AM +0200, Andrea Arcangeli wrote:
> > Until you produce pratical results IMHO the usage you advocated to use
> > remap_file_pages to avoid doing big linear mappings that may allocate
> > more ptes, sounds completely vapourware overkill overdesign that won't
> > last past emails.  All in my humble opinion of course. I've no problem
> > to be wrong, I just don't buy what you say since it is not obvious at
> > all given the huge cost of entering exiting kernel, reaching the
> > pagetable in software, mangling them, flushing the tlb (on all common
> > archs that I'm assuming this doesn't only mean to flush a range but to
> > flush it all but it'd be slower even with a range-flush operation),
> > compared to doing nothing with a static linear mapping (regardless the
> > fact there are more ptes with a big linear mapping, I don't care to save
> > ram).
> 
> Space _does_ matter. Everywhere. All the time. And it's not just
> virtualspace this time. Throw away space, and you go into page or
> pagetable replacement.

So you admit you're wrong and that your usage is only meant to save
ram and that given enough ram your usage of remap_file_pages only wastes
cpu? Note that I given as strong assumption the non-interest in saving
ram. You're now saying that the benefit of your usage is to save ram.

Sure it will save ram.

But if your object is to save ram you're still wrong, it's an order of
magnitude more efficient to use shm and to load your scattered data with
aio + O_DIRECT/rawio to do the I/O, so you will also be able to
trivially use largepages and other things w/o messing the pagecache with
larepage knowledge, and furthmore without ever needing a tlb flush or a
pte mangling (pte mangling assuming you don't use largepages, pmd
mangling if you user largepages).

So your usage of remap_file_pages is worthless always.

In short:

1) if you want to save space it's the wrong design since it's an order of
magnitude slower of using direct-io on shared memory (with all the advantage
that it provides in terms of largepages and tlb preservation)

2) you don't need to save space then you'd better not waste time with
remap_file_pages and mmap the file linearly (my whole argument for all
my previous emails) And if something if you go to rewrite the app to
coalesce the VM side, you'd better coalesce the I/O side instead, then
the vm side will be free with the linear mapping with huge performance
advantages thanks to the locality knowledge (much more significant than
whatever remap_file_pages improvement, especially for the I/O side with
the major faults that will for sure happen at least once during startup,
often the disks are much bigger than ram). Of course the linear mapping
also involves trusting the OS paging meachanism to unmap pages
efficiently, while you do it by hand, and the OS can be much smarter
and efficient than duplicating VM management algorithms in every
userspace app using remap_file_pages. The OS will only unmap the
overflowing pages of data. the only requirement is to have ram >=
sizeofdisk >> 12 (this wouldn't even be a requirement with Rik's
pmd reclaim).

> On Fri, Jul 04, 2003 at 02:40:00AM +0200, Andrea Arcangeli wrote:
> > If you really go to change the app to use remap_file_pages, rather than
> > just compact the vm side with remap_file_pages (which will waste lots of
> > cpu power and it'll run slower IMHO), you'd better introduce locality
> > knowledge so the I/O side will have a slight chance to perform too and
> > the VM side will be improved as well, potentially also sharing the same
> > page, not only the same pmd (and after you do that if you really need to
> > save ram [not cpu] you can munmap/mmap at the same cost but this is just
> > a said note, I said I don't care to save ram, I care to perform the
> > fastest). reiserfs and other huge btree users have to do this locality
> > stuff all the time with their trees, for example to avoid a directory to
> > be completely scattered everywhere in the tree and in turn triggering
> > an huge amount of I/O seeks that may not even fit in buffercache. w/o
> > the locality information there would be no way for reiserfs to perform
> > with big filesystems and many directories, this is just the simples
> > example I can think of huge btrees that we use everyday.
> 
> Filesystems don't use mmap() to simulate access to the B-trees, they

One of the reasons I did the blkdev in pagecache in 2.4 is that the
partd developer asked me to use a _linear_ mmap to make the VM
management an order of magnitude more efficient for parsing the fs.
Otherwise he never knows how much ram it can allocate and during boot
the ram may be limited. mmap solves this completely leaving the decision
to the VM and it basically gives no limit in how low memory a system can
be to run parted.

Your saying that the in-kernel fs don't use mmap is a red-herring, of
course I know about that but it's totally unrelated to my point. The
only reason they do it is for the major faults (they can't care less if
they get the data through a linear mapping or a bh or a bio or a
pagecache entry). But of course if you add some locality the vm side
will be better to with mmap. I mean, there are worse problems than the
vm side if you costsantly seek all over the place.

And if you always seek reproducibly in the same places scattered
everywhere, then you can fix it on the design application side likely.

And anyways the linear mapping will always be faster than
remap_file_pages, as worse you need pagetable reclaim if you can't live
with ram >= btreesize >> 12. And if you really want to save pagetable
ram you must use shm + aio/o_direct, remap_file_pages is worthless.

The only reason remap_file_pages exists is to have a window on the
SHM!!!! On the 64bit this makes no sense at all. It would make no sense
at all to take a window on the shm.

> Also, mmap()/munmap() do not have equivalent costs to remap_file_pages();
> they do not instantiate ptes like remap_file_pages() and hence accesses

mlock istantiate ptes like remap_file_pages.

> incur minor faults. So it also addresses minor fault costs. There is no
> API not requiring privileges that speculatively populates ptes of a
> mapping and would prevent minor faults like remap_file_pages().

minor faults means nothing, the minor faults happens the first time only
and the first time you've the major fault too. It happens to you that
minor faults matters becaue you go mess the vm of the task with
remap_file_pages.

> Another advantage of the remap_file_pages() approach is that the
> virtual arena can be made somewhat smaller than the actual pagecache,

it's all senseless you've to use shm if you don't want to incour into
the huge penalty of the pte mangling and tlb flushing.

> In principle, there are other ways to do these things in some cases,
> e.g. O_DIRECT. It's not truly an adequate substitute, of course, since

the coherency has to be handled anyways, reads are never a problem for
coherency, writes are a problem regardless. if a write happens under you
in the file where the btree is stored you'll have fun w/ or w/o
O_DIRECT.

> not only is the app then forced to deal with on-disk coherency, the
> mappings aren't shared with pagecache (i.e. evictable via mere writeback)
> and the cost of io is incurred for each miss of the process' cache of
> the on-disk data.

the only difference is that if memory goes low you will need swap space
if you don't want to run out of ram. No other difference. The
remap_file_pages approch would be able to be paged out to disk rather
than to swap. This is absolutely the only difference and given the
advantage that shm provides (no need of tlb flushes and trivially
utilization of largepages) there's no way you can claim remap_file_pages
superior to shm + o_DIRECT/rawio also given you always need aio anyways
and there's no way to deal with aio with remap_file_pages.

In short:

1) remap_file_pages will never take anything but shm as argument and as
   such it is only useful in two cases:
	a) 32bit with shmfs files larger than virtual address space of the task
	b) emulators (they need to map the stuff at fixed offsets
           hardcoded into the asm, so they can't use a linear mapping)
2) if you've to access data efficiently you've two ways in 64bit archs:
	a) trust the kernel and go with linear mapping, kernel
	   will do paging and everything for you with hopefully the
	   smartest algorithm efficiently in the background, it knows
	   what you don't need and with Rik's proposal it can even
	   discard null pmds

	   this way you let all the kernel heuristics to do their
	   work, they know nothing about the semantics of the data
	   so it's all best effort. This is the best design for
	   misc apps that doesn't need to be super tuned.
	b) you choose not to trust the kernel and to build your own
	   view on the files, so you use shm + aio + rawio/O_DIRECT
	   so you get largepages w/o messing the fs, and you never
	   flush the tlb or mangle pagetables, this will always be
	   faster than remap_file_pages

	   disavantage is that if you need to swap the shm you will
	   fall into the swap space

	   however when you fall into 2b (and not 2a) you basically are
	   at a level of optimization where you want to takeover the machine
	   enterely so usually no swap is needed and you can't use
	   remap_file_pages or mmap anyways since you need aio and
	   largepages and no tlb flushes etc..


normal apps should take 2a

big irons running on millions of installations should take 2b

> On Fri, Jul 04, 2003 at 02:40:00AM +0200, Andrea Arcangeli wrote:
> > Again, I don't care about saving ram, we're talking 64bit, I care about
> > speed, I hope I already made this clear enough in the previous email.
> 
> This is a very fundamentally mistaken set of priorities.

that was my basic assumption to make everything simpler, and to make
obvious that remap_file_pages can only hurt performance in that case.

Anyways it doesn't matter, it's still the fastest even when you start to
care about space, and remap_file_pages makes no sense if run on a
regular filesystem.

> On Fri, Jul 04, 2003 at 02:40:00AM +0200, Andrea Arcangeli wrote:
> > My arguments sounds all pretty strightforward to me.
> 
> Sorry, this line of argument is specious.

It's so strightforward that it's incidentally how all applications are
coded today and in no way remap_file_pages can give any performance or
space advantage (except for mapping the shm that can't be mapped all at
the same time in 32bit systems)

> 
> As for the security issue, I'm not terribly interested, as rlimits on
> numbers of processes and VSZ suffice (to get an idea of how much you've
> entitled a user to, check RLIMIT_NPROC*RLIMIT_AS*sizeof(pte_t)/PAGE_SIZE).
> This is primarily resource scalability and functionality, not
> bencnmark-mania or security.
> 
> 
> -- wli


Andrea
