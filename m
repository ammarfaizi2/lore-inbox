Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130067AbRAOKQV>; Mon, 15 Jan 2001 05:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130225AbRAOKQM>; Mon, 15 Jan 2001 05:16:12 -0500
Received: from slc107.modem.xmission.com ([166.70.9.107]:6413 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S130067AbRAOKQA>; Mon, 15 Jan 2001 05:16:00 -0500
To: Ralf Baechle <ralf@uni-koblenz.de>
Cc: David Weinehall <tao@acc.umu.se>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andrea Arcangeli <andrea@suse.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Zlatko Calusic <zlatko@iskon.hr>, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org, linux-mm@frodo.biederman.org
Subject: Caches, page coloring, virtual indexed caches, and more
In-Reply-To: <Pine.LNX.4.10.10101101100001.4457-100000@penguin.transmeta.com> <E14GR38-0000nM-00@the-village.bc.nu> <20010111005657.B2243@khan.acc.umu.se> <20010112035620.B1254@bacchus.dhis.org> <m17l40hhtd.fsf@frodo.biederman.org> <20010115005315.D1656@bacchus.dhis.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 15 Jan 2001 01:41:06 -0700
In-Reply-To: Ralf Baechle's message of "Mon, 15 Jan 2001 00:53:15 -0200"
Message-ID: <m1snmlfbrx.fsf_-_@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Baechle <ralf@uni-koblenz.de> writes:

> On Fri, Jan 12, 2001 at 09:10:54AM -0700, Eric W. Biederman wrote:
> 
> > > Having a reverse mappings is the least sucky way to handle virtual aliases
> > > of certain types of MIPS caches.
> > 
> > Hmm.  I would think that increasing the logical page size in the kernel would
> > be the trivial way to handle virtual aliases.  (i.e.) with a large enough page

O.k. I stepped back and took a little refresher to make certain I know what
is going on.  The only problem besides context switches with a virtually mapped
cache is that without some care you can have multiple cache blocks for
the same data. This is what we must avoid to be correct.

I admit that using a reverse mapping is one way we could prevent these
duplicate blocks. 

#define VIRT_INDEX_BITS 18 /* number of bits in the L1 virtually indexed cache */

These are the places I know of in the kernel that create page mappings.
fork, anonymous pages, mmap, sysv shared memory, mremap, kmap

fork just duplicates something that is already there but in a
different mm, so no bad virtual aliases are created.

anonymous pages only belong to one process, and have effectively only
one mapping so again not a problem.  Unless you need kmap.  To make
that work well we'd have to make the restriction that the swap cache
index and the virtual address are identical in their VIRT_INDEX_BITS.
That's better than doing it in alloc_pages especially as you never
alloc high order swap pages but it worries me a little.   This is
fairly close to what we do with swap clustering but it's still
a pain.

shared mmap.  This is the important one.  Since we have a logical
backing store this is easy to handle.  We just enforce that the
virtual address in a process that we mmap something to must match the
logical address to VIRT_INDEX_BITS.  The effect is the same as a
larger page size with virtually no overhead.

sysv shared memory is exactly the same as shared mmap.  Except instead
of a file offset you have an offset into the sysv segment.

mremap.  Linux specific but pretty much the same as mmap, but easier.
We just enforce that the virtual address of the source of mremap,
and the destination of mremap match on VIRT_INDEX_BITS.

kmap is a little different.  using VIRT_INDEX_BITS is a little
subtle but should work.  Currently kmap is used only with the page
cache so we can take advantage of the page->index field.  From page->index 
we can compute the logical offset of the page and make certain the
page mapped with all VIRT_INDEX_BITS the same as a mmap alias.

kmap and the swap cache are a little different.  Since index holds
the location of a page on the swap file we'd have to make that index
be the same for VIRT_INDEX_BITS as well.


> 
> > size you can't actually have a virtual alias.
> 
> That's a possible solution; I'm not clear how bad the overhead would be.
> Right now a virtual alias is a relativly rare event and we don't want the
> common case of no virtual alias to make pay a high price.  Or?

I guess the question is how big would these logical pages need to be?
Answer big enough to turn your virtually indexed cache into a
physically indexed cache.  Which means they would have to be cache
size.  

Increasing PAGE_SIZE a few bits shouldn't be bad but going up two
orders of magnitude would likely skewer your swapping, and memory
management performance.  You'd just have way to few pages.

But I have a better suggestion so see above.

> > You could also play some games with simply allocating pages only with the
> > proper proper high bits.   These games might also be useful on architectures
> > for L2 caches who have significant physical bits than PAGE_SHIFT bits.
> 
> An alternative but less efficient solution.  I tried to implement it; I ran
> into problems with running out of larger pages soon as I had to split order 2
> pages into 4 order 0 pages to implement this; the fragmentation was _really_
> bad.

O.k. this is scratched off my list of possible good ideas.  Duh.  This
fails for exactly the same reason as increasing as increasing page
size.  at 256K cache and 4K PAGE_SIZE you'd need 256/4 = 64 different
types of pages, fairly nasty.
 
> > But how does a reverse mapping help to handle virtual aliases?  What are those
> 
> > caches doing?
> 
> You leave only mappings of one color accessible.  All other mappings are made
> unaccessible in the page table, so accessing will result in a TLB fault.
> The TLB fault handler then flushes the active mappings, makes them
> unaccessible by clearing the MIPS hw dirty / accessible bits, then makes the
> mapping of the new color accessible in the page table.  This is already
> possible right now but doing the necessary reverse mappings can be rather
> inefficient as is.

Hmm.  This doesn't sound right.  And this sounds like a silly way to
use reverse mappings anyway, since you can do it up front in mmap and
their kin.  Which means you don't have to slow any of the page fault
logic up.

> 
> > The only model in my head is having a virtually indexed cache where you
> > have more index bits than PAGE_SHIFT bits.
> 
> Which is exactly what many MIPS implementations are suffering from.  At
> least they're tagged with the physical address, so no flushes on context
> switch necessary.

Hmm.  Correct.  If you have the page aliases appropriately colored across
address spaces you will always hit the same cache block, and since you
do virtual to physical before the tag compare a false hit won't hurt
either.

Well virtually indexed caches look like worth supporting in the kernel
since it is easy to do, and can be compiled out on architectures that
don't support it.

For keeping cache collisions down I think we probably do a decent job
already.  All we need to do is to continuously cycle through cache
aliases.

For not ensuring too many cache collisions I think we probably do a
decent job already.  Only the least significant bits are significant.
And virtual addresses matter not at all.  In the buddy system where we
walk backward linearly through memory it feels o.k.  Only profiling
would tell if we were helping of if we could even help with that.
Reverse page tables of course are totally irrelevant when you are
dealing in all physical addresses though ;)

Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
