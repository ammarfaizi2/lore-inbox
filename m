Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290816AbSAaBii>; Wed, 30 Jan 2002 20:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290811AbSAaBiT>; Wed, 30 Jan 2002 20:38:19 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:29280 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S290817AbSAaBhy>; Wed, 30 Jan 2002 20:37:54 -0500
Date: Thu, 31 Jan 2002 02:39:12 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 18pre7aa1 mm init
Message-ID: <20020131023912.U1309@athlon.random>
In-Reply-To: <Pine.LNX.4.21.0201302026490.1305-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.21.0201302026490.1305-100000@localhost.localdomain>; from hugh@veritas.com on Wed, Jan 30, 2002 at 09:16:05PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 09:16:05PM +0000, Hugh Dickins wrote:
> Thanks for putting in my HIGHMEM64G 3GB,2GB,1GB menu; but I was
> sorry you didn't integrate the corresponding arch/i386/mm/init.c,
> choosing instead to make fixrange_init yet more complicated...
> 
> There are at least three bugs there, I gave up and went back to
> the version I tested before instead of trying to patch up yours.
> 
> The three bugs I found (1GB uvirtual 2GB physical HIGHMEM64G):
> 1. You use a pgd_none test in your CONFIG_X86_PAE additions to
>    fixrange_init, but pgd_none always 0 when PAE: you'd have to
>    compare against empty_zero_page instead.

that's a problem for 1GB and 2GB with PAE, yes agreed (incidentally I
only tested 3GB with PAE :). thanks.

> 2. You calculate nr_pte one too few since start is not PMD_SIZE
>    aligned, so final page table still discontiguous in some cases
>    e.g. when it finds it does need to allocate another pmd.

I don't see this one. nr_pte = (end - start + PMD_SIZE - 1) >>
PMD_SHIFT. This is the max number of pagetables necessary for the whole
array pointed by pkmap_page_table. I don't see any problem in the nr_pte
calculation.

One important things is to map the PKMAP area before the FIXMAP one,
because the PKMAP needs to allocate all the pagetable contigous, and it
needs all the pagetables over PKMAP_START to be missing, or they won't
be guaranteed to be contigous. Just running the fixrange_init for the
PKMAP first guarantees this, and all the BUG checks won't allow anything
to go wrong here (modulo the pgd_none broken check in mainline for PAE
that leads to 1GB and 2GB not to work with PAE, but that currently a
noop for 3GB where the pgd at 3G-4G is guaranteed to be mapped).

If feel much safer with lots of bugchecks there, they're zero cost and
in case somebody changes some #define, he will get a not booting kernel
and he will be able to debug it with an early printk patch (in any case
he won't ship patches that later breaks at runtime). I fall into the
"somebody" category as well of course :).

> 3. If 1GB uvirtual 1GB physical HIGHMEM64G then pgd[2]
>    will remain empty_zero_page, and vmallocs will fail.

I don't see this one as well. At least with the current definition of
VMALLOC_SIZE. the vmalloc cames befor the PKMAP_START and vmalloc start
will remain above 3G, no matter where the PAGE_OFFSET is. So it will
always be in the pgd[3] that is always allocated by the fixrange_init
(as soon as I fix the pgd_none check for PAE at least :).

But yes, I'd also prefer if we could set VMALLOC_SIZE to 2G when 3G are
available, so that's a possible improvement.

>    
> Imagine my distress if next time around I discover you've
> fixed those three with even more code in fixrange_init!

don't worry, you will certainly find parts of it merged :). See below
for some other comment.

> Patch rediffed below.
> 
> Hugh
> 
> --- 2.4.18-pre7aa1/arch/i386/mm/init.c	Wed Jan 30 15:10:34 2002
> +++ linux/arch/i386/mm/init.c	Wed Jan 30 20:02:17 2002
> @@ -167,69 +167,6 @@
>  	set_pte_phys(address, phys, flags);
>  }
>  
> -static void __init fixrange_init (unsigned long start, unsigned long end, pgd_t *pgd_base, int contigous_pte)
> -{
> -	pgd_t *pgd;
> -	pmd_t *pmd;
> -	pte_t *pte;
> -	int i, j;
> -	int nr_pte;
> -	void * pte_array;
> -
> -	if (start & ~PAGE_MASK)
> -		BUG();
> -
> -	i = __pgd_offset(start);
> -	j = __pmd_offset(start);
> -	pgd = pgd_base + i;
> -
> -	if (contigous_pte) {
> -		if (start >= end)
> -			BUG();
> -		nr_pte = (end - start + PMD_SIZE - 1) >> PMD_SHIFT;
> -#if CONFIG_X86_PAE
> -		/* no pmd w/o PAE enabled */
> -		if (j + nr_pte > PTRS_PER_PMD)
> -			BUG();
> -#endif
> -		pte_array = alloc_bootmem_low_pages(PAGE_SIZE * nr_pte);
> -	}
> -	for ( ; (i < PTRS_PER_PGD) && (start < end); pgd++, i++) {
> -#if CONFIG_X86_PAE
> -		if (pgd_none(*pgd)) {
> -			pmd = (pmd_t *) alloc_bootmem_low_pages(PAGE_SIZE);
> -			set_pgd(pgd, __pgd(__pa(pmd) + 0x1));
> -			if (pmd != pmd_offset(pgd, 0))
> -				printk("PAE BUG #02!\n");
> -		}
> -		pmd = pmd_offset(pgd, start);
> -#else
> -		pmd = (pmd_t *)pgd;
> -#endif
> -		for (; (j < PTRS_PER_PMD) && (start < end); pmd++, j++) {
> -			if (pmd_none(*pmd)) {
> -				if (contigous_pte) {
> -					pte = (pte_t *) pte_array;
> -					pte_array += PAGE_SIZE;
> -					nr_pte--;
> -				} else
> -					pte = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
> -				set_pmd(pmd, mk_pmd_phys(__pa(pte), __pgprot(_KERNPG_TABLE)));
> -				if (pte != pte_offset_lowmem(pmd, 0))
> -					BUG();
> -			}
> -			start += PMD_SIZE;
> -		}
> -		j = 0;
> -	}
> -	if (contigous_pte) {
> -		if (nr_pte < 0)
> -			BUG();
> -		if (nr_pte > 0)
> -			free_bootmem((unsigned long) pte_array, nr_pte * PAGE_SIZE);
> -	}
> -}
> -
>  static void __init pagetable_init (void)
>  {
>  	unsigned long vaddr, end;
> @@ -246,8 +183,24 @@
>  
>  	pgd_base = swapper_pg_dir;
>  #if CONFIG_X86_PAE
> -	for (i = 0; i < PTRS_PER_PGD; i++)
> +	/*
> +	 * First set all four entries of the pgd.
> +	 * Usually only one page is needed here: if PAGE_OFFSET lowered,
> +	 * maybe three pages: need not be contiguous, but might as well.
> +	 */
> +	pmd = (pmd_t *)alloc_bootmem_low_pages(KERNEL_PGD_PTRS*PAGE_SIZE);
> +	for (i = 1; i < USER_PGD_PTRS; i++)
>  		set_pgd(pgd_base + i, __pgd(1 + __pa(empty_zero_page)));
> +	for (; i < PTRS_PER_PGD; i++, pmd += PTRS_PER_PMD)
> +		set_pgd(pgd_base + i, __pgd(1 + __pa(pmd)));
> +	/*
> +	 * Add low memory identity-mappings - SMP needs it when
> +	 * starting up on an AP from real-mode. In the non-PAE
> +	 * case we already have these mappings through head.S.
> +	 * All user-space mappings are explicitly cleared after
> +	 * SMP startup.
> +	 */
> +	pgd_base[0] = pgd_base[USER_PGD_PTRS];
>  #endif
>  	i = __pgd_offset(PAGE_OFFSET);
>  	pgd = pgd_base + i;
> @@ -256,14 +209,7 @@
>  		vaddr = i*PGDIR_SIZE;
>  		if (end && (vaddr >= end))
>  			break;
> -#if CONFIG_X86_PAE
> -		pmd = (pmd_t *) alloc_bootmem_low_pages(PAGE_SIZE);
> -		set_pgd(pgd, __pgd(__pa(pmd) + 0x1));
> -#else
> -		pmd = (pmd_t *)pgd;
> -#endif
> -		if (pmd != pmd_offset(pgd, 0))
> -			BUG();
> +		pmd = pmd_offset(pgd, 0);
>  		for (j = 0; j < PTRS_PER_PMD; pmd++, j++) {
>  			vaddr = i*PGDIR_SIZE + j*PMD_SIZE;
>  			if (end && (vaddr >= end))

This part alone will solve the vmalloc problem with VMALLOC_SIZE larger
than 1G if 3G are available to the kernel space. It's good, applied.
thanks.

> @@ -298,36 +244,28 @@
>  		}
>  	}
>  
> -#if CONFIG_HIGHMEM
>  	/*
> -	 * Permanent kmaps: initialize before the fixmap area
> -	 * because here the ptes needs to be contigous.
> +	 * Leave vmalloc() to create its own page tables as needed,
> +	 * but create the page tables at top of virtual memory, to be
> +	 * populated by kmap_high(), kmap_atomic(), and set_fixmap().
> +	 * kmap_high() assumes pkmap_page_table contiguous throughout.
>  	 */
> +#if CONFIG_HIGHMEM
>  	vaddr = PKMAP_BASE;
> -	fixrange_init(vaddr, vaddr + PKMAP_SIZE, pgd_base, 1);
> +#else
> +	vaddr = FIXADDR_START;
> +#endif
> +	pmd = pmd_offset(pgd_offset_k(vaddr), vaddr);
> +	i = (0UL - (vaddr & PMD_MASK)) >> PMD_SHIFT;
> +	pte = (pte_t *)alloc_bootmem_low_pages(i*PAGE_SIZE);
> +	for (; --i >= 0; pmd++, pte += PTRS_PER_PTE)
> +		set_pmd(pmd, mk_pmd_phys(__pa(pte), __pgprot(_KERNPG_TABLE)));

I also don't like here the assumption about mapping through the end of
the address space, you implicitly assume the end of the fixmap is
-PAGE_SIZE that will fit into the last pagetables. Ok, I know at worst
it will be a few page lost if somebody lowers the fixmap end for whatever
reason (embedded/custom usages), but I hope you can see why I consider
the fixrange_init a goodness somehow, it's more accurate.

Also here you make the assumption you won't need cross any pgd entry to
map the pagetables. Again, a fair requirement for normal usage, but
fixrange_init doesn't need this requirement to work ok.  And you don't
BUG() check if something goes wrong. (btw, the if (j + nr_pte >
PTRS_PER_PMD) check in pte-highmem is superflous, fixrange_init could
cross over different pgd entries and still generating a contigous pte
array for the pkmaps) So I hope you can see some of the reasons I didn't
merged your patch stright, it's not that I considered it wrong, it only
assumes more implicit things, not in function of the defines, without
any bugcheck, so if somebody setup some weird define the kernel will
crash later in a random place.  fixrange_init (with the few updates for
the pgd_none thing) will instead work more transparently, with less
assumptions, so any custom/weird usage will only need to fixup the
#defines and it won't waste any memory or crash later in ramdom places.

>  
> +#if CONFIG_HIGHMEM
>  	pgd = swapper_pg_dir + __pgd_offset(vaddr);
>  	pmd = pmd_offset(pgd, vaddr);
>  	pte = pte_offset_lowmem(pmd, vaddr);
>  	pkmap_page_table = pte;
> -#endif
> -
> -	/*
> -	 * Fixed mappings, only the page table structure has to be
> -	 * created - mappings will be set by set_fixmap():
> -	 */
> -	vaddr = FIXADDR_START;
> -	fixrange_init(vaddr, vaddr + FIXADDR_SIZE, pgd_base, 0);
> -
> -#if CONFIG_X86_PAE
> -	/*
> -	 * Add low memory identity-mappings - SMP needs it when
> -	 * starting up on an AP from real-mode. In the non-PAE
> -	 * case we already have these mappings through head.S.
> -	 * All user-space mappings are explicitly cleared after
> -	 * SMP startup.
> -	 */
> -	pgd_base[0] = pgd_base[USER_PTRS_PER_PGD];
>  #endif
>  }
>  


Andrea
