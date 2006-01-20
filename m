Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWATVXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWATVXp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 16:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWATVXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 16:23:45 -0500
Received: from gold.veritas.com ([143.127.12.110]:34310 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932213AbWATVXo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 16:23:44 -0500
Date: Fri, 20 Jan 2006 21:24:08 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Dave McCracken <dmccr@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH/RFC] Shared page tables
In-Reply-To: <A6D73CCDC544257F3D97F143@[10.1.1.4]>
Message-ID: <Pine.LNX.4.61.0601202020001.8821@goblin.wat.veritas.com>
References: <A6D73CCDC544257F3D97F143@[10.1.1.4]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 20 Jan 2006 21:23:36.0228 (UTC) FILETIME=[C6024640:01C61E07]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jan 2006, Dave McCracken wrote:
> 
> Here's a new version of my shared page tables patch.
> 
> The primary purpose of sharing page tables is improved performance for
> large applications that share big memory areas between multiple processes.
> It eliminates the redundant page tables and significantly reduces the
> number of minor page faults.  Tests show significant performance
> improvement for large database applications, including those using large
> pages.  There is no measurable performance degradation for small processes.
> 
> This version of the patch uses Hugh's new locking mechanism, extending it
> up the page table tree as far as necessary for proper concurrency control.
> 
> The patch also includes the proper locking for following the vma chains.
> 
> Hugh, I believe I have all the lock points nailed down.  I'd appreciate
> your input on any I might have missed.
> 
> The architectures supported are i386 and x86_64.  I'm working on 64 bit
> ppc, but there are still some issues around proper segment handling that
> need more testing.  This will be available in a separate patch once it's
> solid.
> 
> Dave McCracken

The locking looks much better now, and I like the way i_mmap_lock seems
to fall naturally into place where the pte lock doesn't work.  But still
some raciness noted in comments on patch below.

The main thing I dislike is the
 16 files changed, 937 insertions(+), 69 deletions(-)
(with just i386 and x86_64 included): it's adding more complexity than
I can welcome, and too many unavoidable "if (shared) ... else ..."s.
With significant further change needed, not just adding architectures.

Worthwhile additional complexity?  I'm not the one to judge that.
Brian has posted dramatic improvments (25%, 49%) for the non-huge OLTP,
and yes, it's sickening the amount of memory we're wasting on pagetables
in that particular kind of workload.  Less dramatic (3%, 4%) in the
hugetlb case: and as yet (since last summer even) no profiles to tell
where that improvement actually comes from.

Could it be simpler?  I'd love you to chuck out the pud and pmd sharing
and just stick to sharing the lowest level of pagetable (though your
handling of the different levels is decently symmetrical).  But you
told me last time around that sharing at pmd level is somehow essential
to having it work on ppc64.

An annoying piece of work you have yet to do: getting file_rss working.
You may want to leave that undone, until/unless there's some signal
that mainline really wants shared pagetables: it's off your track,
and probably not worth the effort while prototyping.

I guess what you'll have to do is keep file_rss and anon_rss per
pagetable page (in its struct page) when split ptlock - which would
have the benefit that they can revert back from being atomics in that
case.  Tiresome (prohibitive?) downside being that gatherers of rss
would have to walk the pagetable pages to sum up rss.

Unless we can persuade ourselves that file_rss just isn't worth
supporting any more: tempting for us, but not for those who look at
rss stats.  Even though properly accounted file_rss becomes somewhat
misleading in the shared pagetable world - a process which never
faulted being suddenly graced with thousands of pages.

A more serious omission that you need to fix soon: the TLB flushing
in mm/rmap.c.  In a shared pagetable, you have no record of which
cpus the pte is exposed on (unlike mm->cpu_vm_mask), and so you'll
probably have to flush TLB on all online cpus each time (per pte,
or perhaps can be rearranged to do so only once for the page).  I
don't think you can keep a cpu_vm_mask with the pagetable - we
wouldn't want scheduling a task to have to walk its pagetables.

Well, I say "no record", but I suppose if you change the code somehow
to leave the pte in place when the page is first found, and accumulate
the mm->cpu_vm_masks of all the vmas in which the page is found, and
only clear it at the end.  Not sure if that can fly, or worthwhile.

More comments, mostly trivial, against extracts from the patch below.
(Quite often I comment on one instance, but same applies in similar places.)

> --- 2.6.15/./arch/x86_64/Kconfig	2006-01-02 21:21:10.000000000 -0600
> +++ 2.6.15-shpt/./arch/x86_64/Kconfig	2006-01-03 10:30:01.000000000 -0600
> @@ -267,6 +267,38 @@ config NUMA_EMU
>  	  into virtual nodes when booted with "numa=fake=N", where N is the
>  	  number of nodes. This is only useful for debugging.
>  
> +config PTSHARE
> +	bool "Share page tables"
> +	default y
> +	help
> +	  Turn on sharing of page tables between processes for large shared
> +	  memory regions.
> +
> +menu "Page table levels to share"
> +	depends on PTSHARE
> +
> +config PTSHARE_PTE
> +	bool "Bottom level table (PTE)"
> +	depends on PTSHARE
> +	default y
> +
> +config PTSHARE_PMD
> +	bool "Middle level table (PMD)"
> +	depends on PTSHARE
> +	default y
> +
> +config PTSHARE_PUD
> +	bool "Upper level table (PUD)"
> +	depends on PTSHARE
> +	default n
> +
> +endmenu
> +
> +config PTSHARE_HUGEPAGE
> +	bool
> +	depends on PTSHARE && PTSHARE_PMD
> +	default y
> +

I presume this cornucopia of config options is for ease of testing the
performance effect of different aspects of the patch, and will go away
in due course.

> --- 2.6.15/./include/asm-x86_64/pgtable.h	2006-01-02 21:21:10.000000000 -0600
> +++ 2.6.15-shpt/./include/asm-x86_64/pgtable.h	2006-01-03 10:30:01.000000000 -0600
> @@ -324,7 +321,8 @@ static inline int pmd_large(pmd_t pte) {
>  /*
>   * Level 4 access.
>   */
> -#define pgd_page(pgd) ((unsigned long) __va((unsigned long)pgd_val(pgd) & PTE_MASK))
> +#define pgd_page_kernel(pgd) ((unsigned long) __va((unsigned long)pgd_val(pgd) & PTE_MASK))
> +#define pgd_page(pgd)		(pfn_to_page(pgd_val(pgd) >> PAGE_SHIFT))

Hmm, so pgd_page changes its meaning: is that wise?  Looks like it isn't
used much outside of include/ so perhaps you're okay, and I can see the
attraction of using "_page" for something that supplies a struct page *.
I can also see the attraction of appending "_kernel" to the other,
following pte_offset_kernel, but "_kernel" isn't really appropriate.
Musing aloud, no particular suggestion.

> --- 2.6.15/./include/linux/ptshare.h	1969-12-31 18:00:00.000000000 -0600
> +++ 2.6.15-shpt/./include/linux/ptshare.h	2006-01-03 10:30:01.000000000 -0600
> +
> +#ifdef CONFIG_PTSHARE
> +static inline int pt_is_shared(struct page *page)
> +{
> +	return (page_mapcount(page) > 1);

This looks like its uses will be racy: see further remarks below.

> +extern void pt_unshare_range(struct vm_area_struct *vma, unsigned long address,
> +			     unsigned long end);
> +#else /* CONFIG_PTSHARE */
> +#define	pt_is_shared(page)	(0)
> +#define	pt_increment_share(page)
> +#define	pt_decrement_share(page)
> +#define pt_shareable_vma(vma)	(0)
> +#define	pt_unshare_range(vma, address, end)
> +#endif /* CONFIG_PTSHARE */

Please keep to "#define<space>MACRO<tab(s)definition" throughout:
easiest thing would be to edit the patch itself.

> +static inline void pt_increment_pte(pmd_t pmdval)
> +{
> +	struct page *page;
> +
> +	page = pmd_page(pmdval);
> +	pt_increment_share(page);
> +	return;
> +}

Please leave out all these unnecessary "return;"s.

> +static inline int pt_shareable_pte(struct vm_area_struct *vma, unsigned long address)
> +{
> +	unsigned long base = address & PMD_MASK;
> +	unsigned long end = base + (PMD_SIZE-1);
> +
> +	if ((vma->vm_start <= base) &&
> +	    (vma->vm_end >= end))
> +		return 1;
> +
> +	return 0;
> +}

I think you have an off-by-one on the end test there (and in similar fns):
maybe you should be saying "(vma->vm_end - 1 >= end)".

> --- 2.6.15/./mm/fremap.c	2006-01-02 21:21:10.000000000 -0600
> +++ 2.6.15-shpt/./mm/fremap.c	2006-01-03 10:30:01.000000000 -0600
> @@ -193,6 +194,9 @@ asmlinkage long sys_remap_file_pages(uns
>  				has_write_lock = 1;
>  				goto retry;
>  			}
> +			if (pt_shareable_vma(vma))
> +				pt_unshare_range(vma, vma->vm_start, vma->vm_end);
> +

I do like the way you simply unshare whenever (or almost whenever) in
doubt, and the way unsharing doesn't have to copy the pagetable, because
it's known to be full of straight file mappings which can just be faulted
back.

But it's not robust to be using the "pt_shareable_vma" test for whether
you need to unshare.  Notably the PMD_SIZE part of the pt_shareable_vma
test is good for deciding whether it's worth trying to share, but not so
good for deciding whether in fact we are shared.  By all means have an
inline test for whether it's worth going off to the exceptional unshare
function, but use a safer test.

Even if you do fix up those places which reduce the size of the area
but don't at present unshare.  For example, madvise.c and mlock.c don't
appear in this patch, but madvise and mlock can split_vma bringing it
below PMD_SIZE.  It's not necessarily the case that we should then
unshare, but probably need to at least in the mlock case (since
try_to_unmap might unmap pte from non-VM_LOCKED vma before reaching
VM_LOCKED vma sharing the same pagetable).  You might decide it's
best to unshare in split_vma.

> --- 2.6.15/./mm/memory.c	2006-01-02 21:21:10.000000000 -0600
> +++ 2.6.15-shpt/./mm/memory.c	2006-01-03 10:30:01.000000000 -0600
> @@ -110,14 +113,25 @@ void pmd_clear_bad(pmd_t *pmd)
>   * Note: this doesn't free the actual pages themselves. That
>   * has been handled earlier when unmapping all the memory regions.
>   */
> -static void free_pte_range(struct mmu_gather *tlb, pmd_t *pmd)
> +static void free_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
> +			   unsigned long addr)
>  {
>  	struct page *page = pmd_page(*pmd);
> -	pmd_clear(pmd);
> -	pte_lock_deinit(page);
> -	pte_free_tlb(tlb, page);
> -	dec_page_state(nr_page_table_pages);
> -	tlb->mm->nr_ptes--;
> +	pmd_t pmdval= *pmd;
> +	int share;
> +
> +	share = pt_is_shared_pte(pmdval);
> +	if (share)
> +		pmd_clear_flush(tlb->mm, addr, pmd);
> +	else
> +		pmd_clear(pmd);
> +
> +	pt_decrement_pte(pmdval);
> +	if (!share) {
> +		pte_lock_deinit(page);
> +		pte_free_tlb(tlb, page);
> +		dec_page_state(nr_page_table_pages);
> +	}
>  }

Here's an example of where using pt_is_shared_pte is racy.
The last two tasks sharing might find page_mapcount > 1 at the same
time, so neither do the freeing.  In this case, haven't looked to
see if it's the same everywhere, you want pt_decrement_pte to
return the atomic_dec_and_test - I think.  Or else be holding
i_mmap_lock here and in more places, but that's probably worse.

>  int __pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long address)
>  {
>  	struct page *new = pte_alloc_one(mm, address);
> +	spinlock_t *ptl = pmd_lockptr(mm, pmd);
> +
>  	if (!new)
>  		return -ENOMEM;
>  
>  	pte_lock_init(new);
> -	spin_lock(&mm->page_table_lock);
> +	spin_lock(ptl);

Yes, that's nice - IF you really have to cover multiple levels.

>  	if (pmd_present(*pmd)) {	/* Another has populated it */
>  		pte_lock_deinit(new);
>  		pte_free(new);
>  	} else {
> -		mm->nr_ptes++;

So /proc/<pid>/status VmPTE will always be "0 kB"?
I think you ought to try a bit harder there (not sure if it should
include shared pagetables or not), guess best left along with rss.

>  static inline int copy_pmd_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>  		pud_t *dst_pud, pud_t *src_pud, struct vm_area_struct *vma,
> -		unsigned long addr, unsigned long end)
> +		unsigned long addr, unsigned long end, int shareable)
>  {
>  	pmd_t *src_pmd, *dst_pmd;
>  	unsigned long next;
> @@ -531,16 +579,20 @@ static inline int copy_pmd_range(struct 
>  		next = pmd_addr_end(addr, end);
>  		if (pmd_none_or_clear_bad(src_pmd))
>  			continue;
> -		if (copy_pte_range(dst_mm, src_mm, dst_pmd, src_pmd,
> -						vma, addr, next))
> -			return -ENOMEM;
> +		if (shareable && pt_shareable_pte(vma, addr)) {
> +			pt_copy_pte(dst_mm, dst_pmd, src_pmd);

I'd have preferred not to add the shareable argument at each level,
and work it out here; or is that significantly less efficient?

> @@ -610,6 +676,7 @@ static unsigned long zap_pte_range(struc
>  	do {
>  		pte_t ptent = *pte;
>  		if (pte_none(ptent)) {
> +
>  			(*zap_work)--;
>  			continue;
>  		}

An utterly inexcusable blank line!

> --- 2.6.15/./mm/ptshare.c	1969-12-31 18:00:00.000000000 -0600
> +++ 2.6.15-shpt/./mm/ptshare.c	2006-01-03 10:30:01.000000000 -0600
> +			spude = *spud;

I seem to have a strange aversion to the name "spude",
but you can safely ignore my affliction.

Hugh
