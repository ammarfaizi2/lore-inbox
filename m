Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265665AbTGDD4p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 23:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265762AbTGDD4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 23:56:45 -0400
Received: from holomorphy.com ([66.224.33.161]:51910 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265665AbTGDD4i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 23:56:38 -0400
Date: Thu, 3 Jul 2003 21:10:48 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Rik van Riel <riel@redhat.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
Message-ID: <20030704041048.GO20413@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@redhat.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>, Mel Gorman <mel@csn.ul.ie>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030703125839.GZ23578@dualathlon.random> <Pine.LNX.4.44.0307030904260.16582-100000@chimarrao.boston.redhat.com> <20030703185341.GJ20413@holomorphy.com> <20030703192750.GM23578@dualathlon.random> <20030703201607.GK20413@holomorphy.com> <20030704004000.GQ23578@dualathlon.random> <20030704014624.GN20413@holomorphy.com> <20030704023414.GV23578@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030704023414.GV23578@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 03, 2003 at 06:46:24PM -0700, William Lee Irwin III wrote:
>> What minor faults? remap_file_pages() does pagecache lookups and

On Fri, Jul 04, 2003 at 04:34:14AM +0200, Andrea Arcangeli wrote:
> with minor faults I meant the data in cache, and you calling
> remap_file_pages to make it visible to the app. with minor faults I
> meant only the cpu cost of the remap_file_pages operation, without the
> need of hitting on the disk with ->readpage.

Well, those aren't minor faults. That's prefaulting.


On Thu, Jul 03, 2003 at 06:46:24PM -0700, William Lee Irwin III wrote:
>> Space _does_ matter. Everywhere. All the time. And it's not just
>> virtualspace this time. Throw away space, and you go into page or
>> pagetable replacement.

On Fri, Jul 04, 2003 at 04:34:14AM +0200, Andrea Arcangeli wrote:
> So you admit you're wrong and that your usage is only meant to save
> ram and that given enough ram your usage of remap_file_pages only wastes
> cpu? Note that I given as strong assumption the non-interest in saving
> ram. You're now saying that the benefit of your usage is to save ram.
> Sure it will save ram.

That was its explicit purpose for 32-bit and it's usable for that
same purpose on 64-bit. You're citing the precise scenario where
remap_file_pages() is used on 32-bit!


On Fri, Jul 04, 2003 at 04:34:14AM +0200, Andrea Arcangeli wrote:
> But if your object is to save ram you're still wrong, it's an order of
> magnitude more efficient to use shm and to load your scattered data with
> aio + O_DIRECT/rawio to do the I/O, so you will also be able to
> trivially use largepages and other things w/o messing the pagecache with
> larepage knowledge, and furthmore without ever needing a tlb flush or a
> pte mangling (pte mangling assuming you don't use largepages, pmd
> mangling if you user largepages).
> So your usage of remap_file_pages is worthless always.

Incorrect. First, the above scenario is precisely where databases are
using remap_file_pages() on 32-bit. Second, the above circumvents the
pagecache and on machines with limited resources incurs swap overhead
as opposed to the data cache being reclaimable via simple VM writeback.
Third, it requires an application to perform its own writeback, which
is a transparency deficit in the above API's (though for database
engines it's fine as they would very much like to be aware of such
things and to more or less have the entire machine dedicated to them).


On Fri, Jul 04, 2003 at 04:34:14AM +0200, Andrea Arcangeli wrote:
> In short:
> 1) if you want to save space it's the wrong design since it's an order of
> magnitude slower of using direct-io on shared memory (with all the advantage
> that it provides in terms of largepages and tlb preservation)

I already countered this argument in the earlier post, even before
you made it.


On Fri, Jul 04, 2003 at 04:34:14AM +0200, Andrea Arcangeli wrote:
> 2) you don't need to save space then you'd better not waste time with
> remap_file_pages and mmap the file linearly (my whole argument for all
> my previous emails) And if something if you go to rewrite the app to
> coalesce the VM side, you'd better coalesce the I/O side instead, then
> the vm side will be free with the linear mapping with huge performance
> advantages thanks to the locality knowledge (much more significant than
> whatever remap_file_pages improvement, especially for the I/O side with
> the major faults that will for sure happen at least once during startup,
> often the disks are much bigger than ram). Of course the linear mapping
> also involves trusting the OS paging meachanism to unmap pages
> efficiently, while you do it by hand, and the OS can be much smarter
> and efficient than duplicating VM management algorithms in every
> userspace app using remap_file_pages. The OS will only unmap the
> overflowing pages of data. the only requirement is to have ram >=
> sizeofdisk >> 12 (this wouldn't even be a requirement with Rik's
> pmd reclaim).

That's quite some limitation!

At any rate, as unimpressed as I was with the other arguments, this
really fails to impress me as you're directly arguing for enforcing
one of the resource scalability limitation remap_file_pages() lifts.


On Thu, Jul 03, 2003 at 06:46:24PM -0700, William Lee Irwin III wrote:
>> Filesystems don't use mmap() to simulate access to the B-trees, they

On Fri, Jul 04, 2003 at 04:34:14AM +0200, Andrea Arcangeli wrote:
> One of the reasons I did the blkdev in pagecache in 2.4 is that the
> partd developer asked me to use a _linear_ mmap to make the VM
> management an order of magnitude more efficient for parsing the fs.
> Otherwise he never knows how much ram it can allocate and during boot
> the ram may be limited. mmap solves this completely leaving the decision
> to the VM and it basically gives no limit in how low memory a system can
> be to run parted.

There's nothing wrong with linearly mapping something when it
doesn't present a problem (e.g. pagetable space out the wazoo).


On Fri, Jul 04, 2003 at 04:34:14AM +0200, Andrea Arcangeli wrote:
> Your saying that the in-kernel fs don't use mmap is a red-herring, of
> course I know about that but it's totally unrelated to my point. The
> only reason they do it is for the major faults (they can't care less if
> they get the data through a linear mapping or a bh or a bio or a
> pagecache entry). But of course if you add some locality the vm side
> will be better to with mmap. I mean, there are worse problems than the
> vm side if you costsantly seek all over the place.

What on earth? Virtual locality is exactly what remap_file_pages()
restores to otherwise sparse access. Also c.f. the prior post as to
maintaining a large enough cache so as not to be seek-bound. If your
cache isn't getting a decent number of hits, you're dead with or
without remap_file_pages(); it can only save you from the contents of
it not being file offset contiguous. And it has to be that much
better of a cache for not being so.


On Fri, Jul 04, 2003 at 04:34:14AM +0200, Andrea Arcangeli wrote:
> And if you always seek reproducibly in the same places scattered
> everywhere, then you can fix it on the design application side likely.

That's fine. If you really get that many seeks, you need to fix it.


On Fri, Jul 04, 2003 at 04:34:14AM +0200, Andrea Arcangeli wrote:
> And anyways the linear mapping will always be faster than
> remap_file_pages, as worse you need pagetable reclaim if you can't live
> with ram >= btreesize >> 12. And if you really want to save pagetable
> ram you must use shm + aio/o_direct, remap_file_pages is worthless.

A linear mapping will be dog slow if an entire pagetable page must be
reconstituted for each minor fault and a minor fault is taken on a
large proportion of accesses (due to the pagetables needing to be GC'd
and page replacement evicting what could otherwise be used as cache),
which is effectively what you're proposing.


On Fri, Jul 04, 2003 at 04:34:14AM +0200, Andrea Arcangeli wrote:
> The only reason remap_file_pages exists is to have a window on the
> SHM!!!! On the 64bit this makes no sense at all. It would make no sense
> at all to take a window on the shm.

It was what motivated its creation. It is more generally useful and
doesn't smack of a brutal database hack, which is why I don't find it
as distasteful as DSHM etc. from other kernels.


On Thu, Jul 03, 2003 at 06:46:24PM -0700, William Lee Irwin III wrote:
>> Also, mmap()/munmap() do not have equivalent costs to remap_file_pages();
>> they do not instantiate ptes like remap_file_pages() and hence accesses

On Fri, Jul 04, 2003 at 04:34:14AM +0200, Andrea Arcangeli wrote:
> mlock istantiate ptes like remap_file_pages.

If you're going to do tit for tat at least read the rest of the
paragraph.


On Thu, Jul 03, 2003 at 06:46:24PM -0700, William Lee Irwin III wrote:
>> incur minor faults. So it also addresses minor fault costs. There is no
>> API not requiring privileges that speculatively populates ptes of a
>> mapping and would prevent minor faults like remap_file_pages().

On Fri, Jul 04, 2003 at 04:34:14AM +0200, Andrea Arcangeli wrote:
> minor faults means nothing, the minor faults happens the first time only
> and the first time you've the major fault too. It happens to you that
> minor faults matters becaue you go mess the vm of the task with
> remap_file_pages.

This is incorrect. Minor faults are large overheads, especially when
they require pagetable pages to be instantiated. They are every bit as
expensive as interrupts (modulo drivers doing real device access there)
or int $0x80 -based system calls.


On Thu, Jul 03, 2003 at 06:46:24PM -0700, William Lee Irwin III wrote:
>> Another advantage of the remap_file_pages() approach is that the
>> virtual arena can be made somewhat smaller than the actual pagecache,

On Fri, Jul 04, 2003 at 04:34:14AM +0200, Andrea Arcangeli wrote:
> it's all senseless you've to use shm if you don't want to incour into
> the huge penalty of the pte mangling and tlb flushing.

It is a time/space tradeoff. When the amount of virtualspace (and hence
pagetable space) required to map it linearly mandates mapping it
nonlinearly instead, it is called for. So have it there and just do it.


On Thu, Jul 03, 2003 at 06:46:24PM -0700, William Lee Irwin III wrote:
>> In principle, there are other ways to do these things in some cases,
>> e.g. O_DIRECT. It's not truly an adequate substitute, of course, since

On Fri, Jul 04, 2003 at 04:34:14AM +0200, Andrea Arcangeli wrote:
> the coherency has to be handled anyways, reads are never a problem for
> coherency, writes are a problem regardless. if a write happens under you
> in the file where the btree is stored you'll have fun w/ or w/o
> O_DIRECT.

The coherency handling == the app has to do its own writeback. It is a
feature that since it's pagecache-coherent it automates that task for
the application. Other niceties are that it doesn't require tmpfs to
be mounted, doesn't bang against tmpfs resource limits with respect to
size, when paged out it's paged out to backing store, and so on.


On Thu, Jul 03, 2003 at 06:46:24PM -0700, William Lee Irwin III wrote:
>> not only is the app then forced to deal with on-disk coherency, the
>> mappings aren't shared with pagecache (i.e. evictable via mere writeback)
>> and the cost of io is incurred for each miss of the process' cache of
>> the on-disk data.

On Fri, Jul 04, 2003 at 04:34:14AM +0200, Andrea Arcangeli wrote:
> the only difference is that if memory goes low you will need swap space
> if you don't want to run out of ram. No other difference. The
> remap_file_pages approch would be able to be paged out to disk rather
> than to swap. This is absolutely the only difference and given the
> advantage that shm provides (no need of tlb flushes and trivially
> utilization of largepages) there's no way you can claim remap_file_pages
> superior to shm + o_DIRECT/rawio also given you always need aio anyways
> and there's no way to deal with aio with remap_file_pages.

It is a significant advantage. It's also trivial to write an aio
remap_file_pages() opcode. I've actually been muttering about doing so
for weeks and the specific application I've not been getting the time
to write wants it (along with pagecache coherency).


On Fri, Jul 04, 2003 at 04:34:14AM +0200, Andrea Arcangeli wrote:
> In short:
> 1) remap_file_pages will never take anything but shm as argument and as
>    such it is only useful in two cases:
> 	a) 32bit with shmfs files larger than virtual address space of the task
> 	b) emulators (they need to map the stuff at fixed offsets
>            hardcoded into the asm, so they can't use a linear mapping)

I'm with you on everything except shm; in fact, shm can never be used
directly with it (only through tmpfs) as it requires fd's to operate.


On Fri, Jul 04, 2003 at 04:34:14AM +0200, Andrea Arcangeli wrote:
> 2) if you've to access data efficiently you've two ways in 64bit archs:
> 	a) trust the kernel and go with linear mapping, kernel
> 	   will do paging and everything for you with hopefully the
> 	   smartest algorithm efficiently in the background, it knows
> 	   what you don't need and with Rik's proposal it can even
> 	   discard null pmds
> 	   this way you let all the kernel heuristics to do their
> 	   work, they know nothing about the semantics of the data
> 	   so it's all best effort. This is the best design for
> 	   misc apps that doesn't need to be super tuned.

Linear mappings have their uses. What kernel heuristics are these?
I know of none that would be affected or "fooled" by its use.


On Fri, Jul 04, 2003 at 04:34:14AM +0200, Andrea Arcangeli wrote:
> 	b) you choose not to trust the kernel and to build your own
> 	   view on the files, so you use shm + aio + rawio/O_DIRECT
> 	   so you get largepages w/o messing the fs, and you never
> 	   flush the tlb or mangle pagetables, this will always be
> 	   faster than remap_file_pages
> 	   disavantage is that if you need to swap the shm you will
> 	   fall into the swap space

This is a valid thing to do, especially for database engines. It's
not for everything, of course, especially things that don't want to
take over the entire machine.


On Fri, Jul 04, 2003 at 04:34:14AM +0200, Andrea Arcangeli wrote:
> 	   however when you fall into 2b (and not 2a) you basically are
> 	   at a level of optimization where you want to takeover the machine
> 	   enterely so usually no swap is needed and you can't use
> 	   remap_file_pages or mmap anyways since you need aio and
> 	   largepages and no tlb flushes etc..
> normal apps should take 2a
> big irons running on millions of installations should take 2b

Why is it inappropriate for normal apps that aren't going to take over
the entire machine to be space-efficient with respect to pagetables?


On Fri, Jul 04, 2003 at 04:34:14AM +0200, Andrea Arcangeli wrote:
> that was my basic assumption to make everything simpler, and to make
> obvious that remap_file_pages can only hurt performance in that case.
> Anyways it doesn't matter, it's still the fastest even when you start to
> care about space, and remap_file_pages makes no sense if run on a
> regular filesystem.

Well, first off, given its mechanics, the only way it functions at all
is on regular filesystems. Second, time is not the only metric of
performance. Third, the other suggestions essentially put the operations
required for performing the tasks forever out of the reach of ordinary
applications and so limit their functionality.

One of the big reasons I want it to be generally useful is because it's
going to require some effort to cope with in the VM internals no matter
what. And that effort is close to 99% wasted counting userbase-wise if
the only thing that can use it is Oracle (not to cast aspersions; it's
generally worthwhile to help Oracle out in various ways).


On Thu, Jul 03, 2003 at 06:46:24PM -0700, William Lee Irwin III wrote:
>> Sorry, this line of argument is specious.

On Fri, Jul 04, 2003 at 04:34:14AM +0200, Andrea Arcangeli wrote:
> It's so strightforward that it's incidentally how all applications are
> coded today and in no way remap_file_pages can give any performance or
> space advantage (except for mapping the shm that can't be mapped all at
> the same time in 32bit systems)

Well, the conclusion isn't effectively supported by the evidence.

It's clear it does what it does, has its various features, and has its
uses.

On 64-bit, if you need to mmap() something that you would bog the box 
down with pagetables when doing it, it's how apps can cooperate and not
fill up RAM with redundant and useless garbage (pagetables with only
one pte a piece set in them). On 32-bit, it's how you can get at many
pieces of something simultaneously at all. We've already got it, let's
not castrate it before it ever ships. Heck, I could have written the
fixups for truncate() in the time it took to write all these messages.

How about this: I fix up truncate() and whatever else cares, and all
this hassle ends right then?

The opponents of the thing seem to be vastly overestimating its impact
on the VM AFAICT.


-- wli
