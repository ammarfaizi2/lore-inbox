Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291082AbSAaONq>; Thu, 31 Jan 2002 09:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291084AbSAaONh>; Thu, 31 Jan 2002 09:13:37 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:63325 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S291082AbSAaONZ>; Thu, 31 Jan 2002 09:13:25 -0500
Date: Thu, 31 Jan 2002 14:15:41 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 18pre7aa1 mm init
In-Reply-To: <20020131023912.U1309@athlon.random>
Message-ID: <Pine.LNX.4.21.0201311209460.1021-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2002, Andrea Arcangeli wrote:
> On Wed, Jan 30, 2002 at 09:16:05PM +0000, Hugh Dickins wrote:
> 
> > 2. You calculate nr_pte one too few since start is not PMD_SIZE
> >    aligned, so final page table still discontiguous in some cases
> >    e.g. when it finds it does need to allocate another pmd.
> 
> I don't see this one. nr_pte = (end - start + PMD_SIZE - 1) >>
> PMD_SHIFT. This is the max number of pagetables necessary for the whole
> array pointed by pkmap_page_table. I don't see any problem in the nr_pte
> calculation.

Let's do it with some actual numbers: 1GB uvirtual 2GB physical PAE SMP,
VMALLOC_START 0xc0800000, PKMAP_BASE 0xff335000, FIXADDR_START 0xfff36000,
PMD_SIZE 0x00200000, LAST_PKMAP 1024, KM_NR_SERIES 3.  The contiguous call
to fixrange_init then has start 0xff335000 and end 0xfff35000, calculates
nr_pte as 6, is given contiguous physical pages 5,6,7,8,9,10; page 11 is
allocated to topmost pmd in pgd[3]; and page 12 is allocated to topmost
page table in your next fixrange_init on FIXADDR_START.  pkmap_page_table
array begins at 0x400059a8 and has size 0x6000 so last byte at 0x4000b9a7:
so kmap_pagetable2() will in due course corrupt the topmost pmd (page 11).

The (end - start) to fixrange_init was a multiple of PMD_SIZE, but start
was _not_ a multiple of PMD_SIZE, so nr_pte should have been 7 not 6.

That's easy enough to correct, but it seems so misguided to keep adding
further refinements (uglinesses!) to fixrange_init, when it can all be
done so much more simply and safely - fewer lines of code, less room
for bugs (this is all __init code, so I can't argue by saving memory).
Allocate init_mm's pmds upfront at the beginning of pagetable_init,
allocate directmap pagetables in the middle of pagetable_init (just
as before), allocate the high kmap and fixmap pagetables at the end.

> If feel much safer with lots of bugchecks there, they're zero cost and
> in case somebody changes some #define, he will get a not booting kernel
> and he will be able to debug it with an early printk patch (in any case
> he won't ship patches that later breaks at runtime). I fall into the
> "somebody" category as well of course :).

I'm not generally against putting in BUG()s (the ones in free_pages_ok,
for example, are very very useful); but the ones you have here failed
to catch this error, even if they caught it you'd have to go back with
early printks and other stuff to work it out, and most of the BUG()s
in this module smell of "I'm not sure what I'm doing here, but if I
throw in enough BUG()s and scrape through, then it must be alright":
leftovers from initial development, now guards against falling into
a parallel universe, rather than checks against plausible errors.

> > 3. If 1GB uvirtual 1GB physical HIGHMEM64G then pgd[2]
> >    will remain empty_zero_page, and vmallocs will fail.
> 
> I don't see this one as well. At least with the current definition of
> VMALLOC_SIZE. the vmalloc cames befor the PKMAP_START and vmalloc start
> will remain above 3G, no matter where the PAGE_OFFSET is. So it will
> always be in the pgd[3] that is always allocated by the fixrange_init
> (as soon as I fix the pgd_none check for PAE at least :).
> 
> But yes, I'd also prefer if we could set VMALLOC_SIZE to 2G when 3G are
> available, so that's a possible improvement.

I can't find definition of VMALLOC_SIZE, but never mind.  1GB uvirtual
1GB physical PAE SMP, VMALLOC_START 0x80800000, PKMAP_BASE 0xff335000,
FIXADDR_START 0xfff36000.  pagetable_init initializes pgd_base[0,1,2,3]
with the empty_zero_page.  Setting directmap allocs pmd for pgd_base[1]
only; first fixrange_init allocs pmd for pgd_base[3]; pgd_base[0] rightly
remains empty_zero_page; pgd_base[2] wrongly remains empty_zero_pageC.

vmalloc uses a virtual address space across pgd_base[2] and pgd_base[3].
But I was wrong to say it would fail: now you've forced me to try it out
in practice, I find that vmalloc is successfully using empty_zero_page
as its pmd.  So, for example, even /dev/zero can no longer be relied
upon to give you a clean sheet, there's a blot near the beginning of
the page.  Hmm, time for the reset button!

> > Imagine my distress if next time around I discover you've
> > fixed those three with even more code in fixrange_init!
> 
> don't worry, you will certainly find parts of it merged :). See below
> for some other comment.

Aaargh!  Forget the parts, grab the whole, really it's painless!
We have been using that code (well, the version before I minimized
changes in deference to you) on many machines for almost a year.

> > @@ -256,14 +209,7 @@
> >  		vaddr = i*PGDIR_SIZE;
> >  		if (end && (vaddr >= end))
> >  			break;
> > -#if CONFIG_X86_PAE
> > -		pmd = (pmd_t *) alloc_bootmem_low_pages(PAGE_SIZE);
> > -		set_pgd(pgd, __pgd(__pa(pmd) + 0x1));
> > -#else
> > -		pmd = (pmd_t *)pgd;
> > -#endif
> > -		if (pmd != pmd_offset(pgd, 0))
> > -			BUG();
> > +		pmd = pmd_offset(pgd, 0);
> >  		for (j = 0; j < PTRS_PER_PMD; pmd++, j++) {
> >  			vaddr = i*PGDIR_SIZE + j*PMD_SIZE;
> >  			if (end && (vaddr >= end))
> 
> This part alone will solve the vmalloc problem with VMALLOC_SIZE larger
> than 1G if 3G are available to the kernel space. It's good, applied.
> thanks.

I don't know how far upwards "This part" extends - if as far as the
removal of fixrange_init (as you showed), then I'm happy; if as far
as the start of pagetable_init, then yes it solves the vmalloc problem
(the one you couldn't see?  I'm confused); if as far as the start of
this hunk, no, here we're just doing the directmap area.

> > +	pmd = pmd_offset(pgd_offset_k(vaddr), vaddr);
> > +	i = (0UL - (vaddr & PMD_MASK)) >> PMD_SHIFT;
> > +	pte = (pte_t *)alloc_bootmem_low_pages(i*PAGE_SIZE);
> > +	for (; --i >= 0; pmd++, pte += PTRS_PER_PTE)
> > +		set_pmd(pmd, mk_pmd_phys(__pa(pte), __pgprot(_KERNPG_TABLE)));
> 
> I also don't like here the assumption about mapping through the end of
> the address space, you implicitly assume the end of the fixmap is
> -PAGE_SIZE that will fit into the last pagetables. Ok, I know at worst
> it will be a few page lost if somebody lowers the fixmap end for whatever
> reason (embedded/custom usages), but I hope you can see why I consider
> the fixrange_init a goodness somehow, it's more accurate.
> 
> Also here you make the assumption you won't need cross any pgd entry to
> map the pagetables. Again, a fair requirement for normal usage, but
> fixrange_init doesn't need this requirement to work ok.  And you don't
> BUG() check if something goes wrong. (btw, the if (j + nr_pte >
> PTRS_PER_PMD) check in pte-highmem is superflous, fixrange_init could
> cross over different pgd entries and still generating a contigous pte
> array for the pkmaps) So I hope you can see some of the reasons I didn't
> merged your patch stright, it's not that I considered it wrong, it only
> assumes more implicit things, not in function of the defines, without
> any bugcheck, so if somebody setup some weird define the kernel will
> crash later in a random place.  fixrange_init (with the few updates for
> the pgd_none thing) will instead work more transparently, with less
> assumptions, so any custom/weird usage will only need to fixup the
> #defines and it won't waste any memory or crash later in ramdom places.

Let's assume that if the memory layout is changed, then the code laying
out the memory may need to be changed; and go for the safer simplicity.

Hugh

