Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290514AbSARCiJ>; Thu, 17 Jan 2002 21:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290584AbSARCiA>; Thu, 17 Jan 2002 21:38:00 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:43100 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S290514AbSARChu>; Thu, 17 Jan 2002 21:37:50 -0500
Date: Fri, 18 Jan 2002 03:38:00 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: pte-highmem-5
Message-ID: <20020118033800.C4847@athlon.random>
In-Reply-To: <20020117190924.B4847@athlon.random> <Pine.LNX.4.21.0201171833550.2407-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.21.0201171833550.2407-100000@localhost.localdomain>; from hugh@veritas.com on Thu, Jan 17, 2002 at 07:02:38PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2002 at 07:02:38PM +0000, Hugh Dickins wrote:
> On Thu, 17 Jan 2002, Andrea Arcangeli wrote:
> > On Thu, Jan 17, 2002 at 05:57:15PM +0000, Hugh Dickins wrote:
> > 
> > we need more than one serie, no way, or it can deadlock, the default
> > serie is for pages, the other series are for pagetables.
> > 
> > > 3.  KM_SERIE_PAGETABLE2 kmap_pagetable2 pmd_page2 pte_offset2 all just
> > >     for copy_page_range src?  Why distinguished from KM_SERIE_PAGETABLE?
> > >     Often it will already be KM_SERIE_PAGETABLE.  I can imagine you might
> > >     want an atomic at that point (holding spinlock), but I don't see what
> > >     the PAGETABLE2 distinction gives you.
> > 
> > deadlock avoidance. It's the same reason as the mempool, you need tow
> > mempool if you need two objects from the same task or it can deadlock
> > (yes, it would be hard to deadlock it but possible).
> 
> Sorry, I'm still struggling: I can imagine deadlocks from having too
> few kmaps altogether, and I can see how separating data from pagetables
> protects pagetable code from bugs (missing kunmaps) in other code, but
> I don't see how separating the three series make a crucial difference.

It really makes the cricial difference (deadlock avoidance is the only
reason there is the serie thing in the kmaps). see the thread with Ingo
about mempool, it's exactly the same problem.

in short: the same task cannot get two entries from the same serie
(/mempool) or the system can deadlock.

think of this, assume 3 entries in the pool and a single pool, all tasks
are running fork(2) so they need two kmaps, assume we have a single pool:

	task1	task2	task3	task4

	kmap	kmap	kmap
				kmap <- (hangs)
(hangs)->kmap	kmap	kmap  kmap


deadlock

thanks to the kmap series we cannot deadlock instead:

	task1	task2	task3	task4

	kmap	kmap	kmap
				kmap (hangs)
	kmap2	kmap2	kmap2
	kunmap .....
	kunmap2......
				kmap2
				kunmap
				kunmap2

> > in fork the pte_offset kmap could be an atomic one, but atomic are more
> > costly with the invlpg I believe, to do it in a raw the 2 variant with a
> > different serie should be faster for fork(2).
> 
> Yes, maybe, maybe not.

I guess it depends on the pagetable overhead and on the arch details
(invlpg overhead). If there are less than 1024 pagetables kmap to copy
kmap_serie is going to run faster than kmap_atomic because it may not
need any tlb flush at all, but if there are more we may need to do a
strong global tlb flush, so it is not obvious what is better. I usually
try to avoid the atomic kmaps unless we can't sleep, that's the main
reason for that choice. But I'm open to suggestions, the best would be
to benchmark it first with a few pagetables, and then with an huge
number of pagetables to get some number out of it. At least it is
something that we can change freely anytime as soon as we have some
number and in the meantime it is not a critical thing to sort out.

> 
> > > 4.  You've lifted the PAE restriction to LAST_PKMAP 512 in i386/highmem.h,
> > >     and use pkmap_page_table as one long array in mm/highmem.c, but I
> > >     don't see where you enforce the contiguity of page table pages in
> > >     i386/mm/init.c.  (I do already have a patch for lifting the 1024,512
> > >     kmaps limit, simplifying i386/mm/init.c, we've been using for months:
> > >     I can update that from 2.4.9 if you'd like it.)
> > 
> > correct, currently it works because the bootmem tends to return
> > physically contigous pages but it is not enforced and it may trigger
> > with a weird e820 layout. If you've a patch very feel free to post it!!  :)
> > thanks for the review.
> 
> Okay, I've attached the existing patch against 2.4.9 below.  It originated
> from my Large PAGE_SIZE patch, where it became clear that the fixmaps are
> appropriate for MMUPAGE_SIZE maps but the kmaps for PAGE_SIZE maps (later,
> with Ben's work on Large PAGE_CACHE_SIZE, it became clear that actually
> kmaps should be PAGE_CACHE_SIZE, but I've not added in that complication).
> 
> So the atomic kmaps are no longer done by fixmap.h, but come after the
> vmallocs, before the regular kmaps, in highmem.h.  It also doesn't waste
> so much virtual space either end of the vmalloc area.  The mm/init.c diff
> looks a lot, mainly because the result is a lot simpler.  If it would
> help you for me to update to a release of your choice, let me know
> (perhaps the next aa, with your mods in).

the below patch looks overkill, I don't want to change all that code,
I'd just need the few liner to have an array of pte pointers in function
of PTRS_PER_PTE and LAST_KMAP. Either that or even much better just
allocate all the pagetables at once with a single bootmem call, that is
certainly a safe approch too, just count the number of pte needed for
the persistente kmaps and then do a single bootmem call to allocate all
of them at once, this second approch sounds the most efficient one. If
you want to make a patch against pte-highmem-5 feel free to go ahead. It
should be a few liner. I didn't checked what other good things are
getting changed by the big patch, but I'd prefer to have only the
necessary changes at least for the 2.4 version of the patch.

> > > 5.  Shouldn't mm/vmscan.c be in the patch?
> > 
> > can you elaborate?
> 
> swap_out_pmd() uses pte_offset() on user page tables,
> so doesn't it need to pte_kunmap() afterwards?

Ouch, I completly overlooked vmscan.c!! So this definitely explains
hangs during swapout activities. Many thanks, that was an important one
to catch!

Andrea
