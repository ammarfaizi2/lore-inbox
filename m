Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291204AbSAaRuz>; Thu, 31 Jan 2002 12:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291205AbSAaRun>; Thu, 31 Jan 2002 12:50:43 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:5931 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S291203AbSAaRuY>; Thu, 31 Jan 2002 12:50:24 -0500
Date: Thu, 31 Jan 2002 18:51:44 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 18pre7aa1 mm init
Message-ID: <20020131185144.H1309@athlon.random>
In-Reply-To: <20020131023912.U1309@athlon.random> <Pine.LNX.4.21.0201311209460.1021-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.21.0201311209460.1021-100000@localhost.localdomain>; from hugh@veritas.com on Thu, Jan 31, 2002 at 02:15:41PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 02:15:41PM +0000, Hugh Dickins wrote:
> On Thu, 31 Jan 2002, Andrea Arcangeli wrote:
> > On Wed, Jan 30, 2002 at 09:16:05PM +0000, Hugh Dickins wrote:
> > 
> > > 2. You calculate nr_pte one too few since start is not PMD_SIZE
> > >    aligned, so final page table still discontiguous in some cases
> > >    e.g. when it finds it does need to allocate another pmd.
> > 
> > I don't see this one. nr_pte = (end - start + PMD_SIZE - 1) >>
> > PMD_SHIFT. This is the max number of pagetables necessary for the whole
> > array pointed by pkmap_page_table. I don't see any problem in the nr_pte
> > calculation.
> 
> Let's do it with some actual numbers: 1GB uvirtual 2GB physical PAE SMP,
> VMALLOC_START 0xc0800000, PKMAP_BASE 0xff335000, FIXADDR_START 0xfff36000,
> PMD_SIZE 0x00200000, LAST_PKMAP 1024, KM_NR_SERIES 3.  The contiguous call
> to fixrange_init then has start 0xff335000 and end 0xfff35000, calculates
> nr_pte as 6, is given contiguous physical pages 5,6,7,8,9,10; page 11 is
> allocated to topmost pmd in pgd[3]; and page 12 is allocated to topmost
> page table in your next fixrange_init on FIXADDR_START.  pkmap_page_table
> array begins at 0x400059a8 and has size 0x6000 so last byte at 0x4000b9a7:
> so kmap_pagetable2() will in due course corrupt the topmost pmd (page 11).
> 
> The (end - start) to fixrange_init was a multiple of PMD_SIZE, but start
> was _not_ a multiple of PMD_SIZE, so nr_pte should have been 7 not 6.
> 
> That's easy enough to correct, but it seems so misguided to keep adding

this should correct it:

--- 2.4.18pre7aa2/arch/i386/mm/init.c.~1~	Thu Jan 31 04:16:52 2002
+++ 2.4.18pre7aa2/arch/i386/mm/init.c	Thu Jan 31 18:29:23 2002
@@ -179,6 +179,8 @@
 	if (start & ~PAGE_MASK)
 		BUG();
 
+	start &= PMD_MASK;
+
 	i = __pgd_offset(start);
 	j = __pmd_offset(start);
 	pgd = pgd_base + i;

> further refinements (uglinesses!) to fixrange_init, when it can all be
> done so much more simply and safely - fewer lines of code, less room
> for bugs (this is all __init code, so I can't argue by saving memory).
> Allocate init_mm's pmds upfront at the beginning of pagetable_init,
> allocate directmap pagetables in the middle of pagetable_init (just
> as before), allocate the high kmap and fixmap pagetables at the end.

and if you change some #define it will waste ram etc.. it's less
generic, less optimized and it makes more assumptions without checking
those assumption can really be trusted.

> 
> > If feel much safer with lots of bugchecks there, they're zero cost and
> > in case somebody changes some #define, he will get a not booting kernel
> > and he will be able to debug it with an early printk patch (in any case
> > he won't ship patches that later breaks at runtime). I fall into the
> > "somebody" category as well of course :).
> 
> I'm not generally against putting in BUG()s (the ones in free_pages_ok,
> for example, are very very useful); but the ones you have here failed
> to catch this error, even if they caught it you'd have to go back with
> early printks and other stuff to work it out, and most of the BUG()s
> in this module smell of "I'm not sure what I'm doing here, but if I
> throw in enough BUG()s and scrape through, then it must be alright":
> leftovers from initial development, now guards against falling into
> a parallel universe, rather than checks against plausible errors.

Ok.

> 
> > > 3. If 1GB uvirtual 1GB physical HIGHMEM64G then pgd[2]
> > >    will remain empty_zero_page, and vmallocs will fail.
> > 
> > I don't see this one as well. At least with the current definition of
> > VMALLOC_SIZE. the vmalloc cames befor the PKMAP_START and vmalloc start
> > will remain above 3G, no matter where the PAGE_OFFSET is. So it will
> > always be in the pgd[3] that is always allocated by the fixrange_init
> > (as soon as I fix the pgd_none check for PAE at least :).
> > 
> > But yes, I'd also prefer if we could set VMALLOC_SIZE to 2G when 3G are
> > available, so that's a possible improvement.
> 
> I can't find definition of VMALLOC_SIZE, but never mind.  1GB uvirtual
> 1GB physical PAE SMP, VMALLOC_START 0x80800000, PKMAP_BASE 0xff335000,
> FIXADDR_START 0xfff36000.  pagetable_init initializes pgd_base[0,1,2,3]
> with the empty_zero_page.  Setting directmap allocs pmd for pgd_base[1]
> only; first fixrange_init allocs pmd for pgd_base[3]; pgd_base[0] rightly
> remains empty_zero_page; pgd_base[2] wrongly remains empty_zero_pageC.

correct. I remebered wrong that vmalloc_size is fixed to some houndred
mbytes, while it extends after the direct mapping, all right.

> 
> vmalloc uses a virtual address space across pgd_base[2] and pgd_base[3].
> But I was wrong to say it would fail: now you've forced me to try it out
> in practice, I find that vmalloc is successfully using empty_zero_page
> as its pmd.  So, for example, even /dev/zero can no longer be relied
> upon to give you a clean sheet, there's a blot near the beginning of
> the page.  Hmm, time for the reset button!
> 
> > > Imagine my distress if next time around I discover you've
> > > fixed those three with even more code in fixrange_init!
> > 
> > don't worry, you will certainly find parts of it merged :). See below
> > for some other comment.
> 
> Aaargh!  Forget the parts, grab the whole, really it's painless!
> We have been using that code (well, the version before I minimized
> changes in deference to you) on many machines for almost a year.

I'm not very interested in making those changes, and I don't feel doing
the right thing by replacing the generic and pedantic code, with the
hardcoded assumptions version even if simpler.  Anyways we're really
only arguing about a few lines of code, the rest of the fixes for 1G/2G
is just merged of course.

Andrea
