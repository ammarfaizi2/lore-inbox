Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbVFWKOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbVFWKOI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 06:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbVFWKKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 06:10:12 -0400
Received: from holomorphy.com ([207.189.100.168]:17372 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262583AbVFWJv6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 05:51:58 -0400
Date: Thu, 23 Jun 2005 02:51:53 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>, Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [patch][rfc] 5/5: core remove PageReserved
Message-ID: <20050623095153.GB3334@holomorphy.com>
References: <42BA5F37.6070405@yahoo.com.au> <42BA5F5C.3080101@yahoo.com.au> <42BA5F7B.30904@yahoo.com.au> <42BA5FA8.7080905@yahoo.com.au> <42BA5FC8.9020501@yahoo.com.au> <42BA5FE8.2060207@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BA5FE8.2060207@yahoo.com.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2005 at 05:08:24PM +1000, Nick Piggin wrote:
> @@ -337,7 +338,7 @@ static inline void get_page(struct page 
>  static inline void put_page(struct page *page)
>  {
> -	if (!PageReserved(page) && put_page_testzero(page))
> +	if (put_page_testzero(page))
>  		__page_cache_release(page);
>  }

No sweep before this? I'm not so sure.


On Thu, Jun 23, 2005 at 05:08:24PM +1000, Nick Piggin wrote:
> @@ -514,7 +534,8 @@ int copy_page_range(struct mm_struct *ds
>  	return 0;
>  }
>  
> -static void zap_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
> +static void zap_pte_range(struct mmu_gather *tlb,
> +				struct vm_area_struct *vma, pmd_t *pmd,
>  				unsigned long addr, unsigned long end,
>  				struct zap_details *details)
>  {

As exciting as this is, !!(vma->vm_flags & VM_RESERVED) could trivially
go into struct zap_details without excess args or diff.


On Thu, Jun 23, 2005 at 05:08:24PM +1000, Nick Piggin wrote:
> @@ -1225,6 +1251,8 @@ static int do_wp_page(struct mm_struct *
>  	unsigned long pfn = pte_pfn(pte);
>  	pte_t entry;
>  
> +	BUG_ON(vma->vm_flags & VM_RESERVED);
> +
>  	if (unlikely(!pfn_valid(pfn))) {
>  		/*
>  		 * This should really halt the system so it can be debugged or

!pfn_valid(pfn) is banned when !(vma->vm_flags & VM_RESERVED); here we
BUG_ON the precondition then handle !pfn_valid(pfn) in the old manner
where some new infrastructure has been erected for reporting such errors.


On Thu, Jun 23, 2005 at 05:08:24PM +1000, Nick Piggin wrote:
> @@ -1259,13 +1286,16 @@ static int do_wp_page(struct mm_struct *
>  	/*
>  	 * Ok, we need to copy. Oh, well..
>  	 */
> -	if (!PageReserved(old_page))
> +	if (old_page == ZERO_PAGE(address))
> +		old_page = NULL;
> +	else
>  		page_cache_get(old_page);
> +
>  	spin_unlock(&mm->page_table_lock);
>  
>  	if (unlikely(anon_vma_prepare(vma)))
>  		goto no_new_page;
> -	if (old_page == ZERO_PAGE(address)) {
> +	if (old_page == NULL) {
>  		new_page = alloc_zeroed_user_highpage(vma, address);
>  		if (!new_page)
>  			goto no_new_page;

There are some micro-optimizations mixed in with this and some
subsequent do_wp_page() alterations.


On Thu, Jun 23, 2005 at 05:08:24PM +1000, Nick Piggin wrote:
> @@ -1654,7 +1656,7 @@ void __init memmap_init_zone(unsigned lo
>  
>  	for (page = start; page < (start + size); page++) {
>  		set_page_zone(page, NODEZONE(nid, zone));
> -		set_page_count(page, 0);
> +		set_page_count(page, 1);
>  		reset_page_mapcount(page);
>  		SetPageReserved(page);
>  		INIT_LIST_HEAD(&page->lru);

The refcounting and PG_reserved activity in memmap_init_zone() is
superfluous. bootmem.c does all the necessary accounting internally.


On Thu, Jun 23, 2005 at 05:08:24PM +1000, Nick Piggin wrote:
> Index: linux-2.6/mm/fremap.c
> ===================================================================
> --- linux-2.6.orig/mm/fremap.c
> +++ linux-2.6/mm/fremap.c
> @@ -29,18 +29,21 @@ static inline void zap_pte(struct mm_str
>  		return;
>  	if (pte_present(pte)) {
>  		unsigned long pfn = pte_pfn(pte);
> +		struct page *page;
>  
>  		flush_cache_page(vma, addr, pfn);
>  		pte = ptep_clear_flush(vma, addr, ptep);
> -		if (pfn_valid(pfn)) {
> -			struct page *page = pfn_to_page(pfn);
> -			if (!PageReserved(page)) {
> -				if (pte_dirty(pte))
> -					set_page_dirty(page);
> -				page_remove_rmap(page);
> -				page_cache_release(page);
> -				dec_mm_counter(mm, rss);
> -			}
> +		if (unlikely(!pfn_valid(pfn))) {
> +			print_invalid_pfn("zap_pte", pte, vma->vm_flags, addr);
> +			return;
> +		}
> +		page = pfn_to_page(pfn);
> +		if (page != ZERO_PAGE(addr)) {
> +			if (pte_dirty(pte))
> +				set_page_dirty(page);
> +			page_remove_rmap(page);
> +			dec_mm_counter(mm, rss);
> +			page_cache_release(page);
>  		}
>  	} else {
>  		if (!pte_file(pte))

There is no error returned here to be handled by the caller.


On Thu, Jun 23, 2005 at 05:08:24PM +1000, Nick Piggin wrote:
> @@ -65,6 +68,8 @@ int install_page(struct mm_struct *mm, s
>  	pgd_t *pgd;
>  	pte_t pte_val;
>  
> +	BUG_ON(vma->vm_flags & VM_RESERVED);
> +
>  	pgd = pgd_offset(mm, addr);
>  	spin_lock(&mm->page_table_lock);
>  	
> @@ -122,6 +127,8 @@ int install_file_pte(struct mm_struct *m
>  	pgd_t *pgd;
>  	pte_t pte_val;
>  
> +	BUG_ON(vma->vm_flags & VM_RESERVED);
> +
>  	pgd = pgd_offset(mm, addr);
>  	spin_lock(&mm->page_table_lock);

This has no effect but to artificially constrain the interface. There
is no a priori reason to avoid the use of install_page() to deposit
mappings to normal pages in VM_RESERVED vmas. It's only the reverse
being "banned" here. Similar comments also apply to zap_pte().


On Thu, Jun 23, 2005 at 05:08:24PM +1000, Nick Piggin wrote:
> Index: linux-2.6/drivers/scsi/sg.c
> ===================================================================
> --- linux-2.6.orig/drivers/scsi/sg.c
> +++ linux-2.6/drivers/scsi/sg.c
> @@ -1887,9 +1887,10 @@ st_unmap_user_pages(struct scatterlist *
>  	int i;
>  
>  	for (i=0; i < nr_pages; i++) {
> -		if (dirtied && !PageReserved(sgl[i].page))
> +		if (dirtied)
>  			SetPageDirty(sgl[i].page);
>  		/* unlock_page(sgl[i].page); */
> +		/* FIXME: XXX don't dirty/unmap VM_RESERVED regions? */
>  		/* FIXME: cache flush missing for rw==READ
>  		 * FIXME: call the correct reference counting function
>  		 */

An answer should be devised for this. My numerous SCSI CD-ROM devices
(I have 5 across several different machines of several different arches)
are rather unlikely to be happy with /* FIXME: XXX ... as an answer.


On Thu, Jun 23, 2005 at 05:08:24PM +1000, Nick Piggin wrote:
> Index: linux-2.6/drivers/scsi/st.c
> ===================================================================
> --- linux-2.6.orig/drivers/scsi/st.c
> +++ linux-2.6/drivers/scsi/st.c
> @@ -4435,8 +4435,9 @@ static int sgl_unmap_user_pages(struct s
>  	int i;
>  
>  	for (i=0; i < nr_pages; i++) {
> -		if (dirtied && !PageReserved(sgl[i].page))
> +		if (dirtied)
>  			SetPageDirty(sgl[i].page);
> +		/* FIXME: XXX don't dirty/unmap VM_RESERVED regions? */
>  		/* FIXME: cache flush missing for rw==READ
>  		 * FIXME: call the correct reference counting function
>  		 */

Mutatis mutandis for my SCSI tape drive.


On Thu, Jun 23, 2005 at 05:08:24PM +1000, Nick Piggin wrote:
> Index: linux-2.6/sound/core/pcm_native.c
> ===================================================================
> --- linux-2.6.orig/sound/core/pcm_native.c
> +++ linux-2.6/sound/core/pcm_native.c
> @@ -2942,8 +2942,7 @@ static struct page * snd_pcm_mmap_status
>  		return NOPAGE_OOM;
>  	runtime = substream->runtime;
>  	page = virt_to_page(runtime->status);
> -	if (!PageReserved(page))
> -		get_page(page);
> +	get_page(page);
>  	if (type)
>  		*type = VM_FAULT_MINOR;
>  	return page;

snd_malloc_pages() marks all pages it allocates PG_reserved. This
merits some commentary, and likely the removal of the superfluous
PG_reserved usage.


On Thu, Jun 23, 2005 at 05:08:24PM +1000, Nick Piggin wrote:
> Index: linux-2.6/mm/mmap.c
> ===================================================================
> --- linux-2.6.orig/mm/mmap.c
> +++ linux-2.6/mm/mmap.c
> @@ -1073,6 +1073,17 @@ munmap_back:
>  		error = file->f_op->mmap(file, vma);
>  		if (error)
>  			goto unmap_and_free_vma;
> +		if ((vma->vm_flags & (VM_SHARED | VM_WRITE | VM_RESERVED))
> +						== (VM_WRITE | VM_RESERVED)) {
> +			printk(KERN_WARNING "program %s is using MAP_PRIVATE, "
> +				"PROT_WRITE mmap of VM_RESERVED memory, which "
> +				"is deprecated. Please report this to "
> +				"linux-kernel@vger.kernel.org\n",current->comm);
> +			if (vma->vm_ops && vma->vm_ops->close)
> +				vma->vm_ops->close(vma);
> +			error = -EACCES;
> +			goto unmap_and_free_vma;
> +		}
>  	} else if (vm_flags & VM_SHARED) {
>  		error = shmem_zero_setup(vma);
>  		if (error)

This is user-triggerable where the driver honors mmap() protection
flags blindly.


On Thu, Jun 23, 2005 at 05:08:24PM +1000, Nick Piggin wrote:
> Index: linux-2.6/mm/bootmem.c
> ===================================================================
> --- linux-2.6.orig/mm/bootmem.c
> +++ linux-2.6/mm/bootmem.c
> @@ -286,6 +286,7 @@ static unsigned long __init free_all_boo
>  				if (j + 16 < BITS_PER_LONG)
>  					prefetchw(page + j + 16);
>  				__ClearPageReserved(page + j);
> +				set_page_count(page + j, 0);
>  			}
>  			__free_pages(page, order);
>  			i += BITS_PER_LONG;

ibid re: bootmem


On Thu, Jun 23, 2005 at 05:08:24PM +1000, Nick Piggin wrote:
> Index: linux-2.6/kernel/power/swsusp.c
> ===================================================================
> --- linux-2.6.orig/kernel/power/swsusp.c
> +++ linux-2.6/kernel/power/swsusp.c
> @@ -433,15 +433,12 @@ static int save_highmem_zone(struct zone
>  			continue;
>  		page = pfn_to_page(pfn);
>  		/*
> +		 * PageReserved(page) -
>  		 * This condition results from rvmalloc() sans vmalloc_32()
>  		 * and architectural memory reservations. This should be
>  		 * corrected eventually when the cases giving rise to this
>  		 * are better understood.
>  		 */
> -		if (PageReserved(page)) {
> -			printk("highmem reserved page?!\n");
> -			continue;
> -		}
>  		BUG_ON(PageNosave(page));
>  		if (PageNosaveFree(page))
>  			continue;

This behavioral change needs to be commented on. There are some additional
difficulties when memory holes are unintentionally covered by mem_map[];
It is beneficial otherwise. It's likely to triplefault on such holes.


On Thu, Jun 23, 2005 at 05:08:24PM +1000, Nick Piggin wrote:
> @@ -527,13 +524,8 @@ static int saveable(struct zone * zone, 
>  		return 0;
>  
>  	page = pfn_to_page(pfn);
> -	BUG_ON(PageReserved(page) && PageNosave(page));
>  	if (PageNosave(page))
>  		return 0;
> -	if (PageReserved(page) && pfn_is_nosave(pfn)) {
> -		pr_debug("[nosave pfn 0x%lx]", pfn);
> -		return 0;
> -	}
>  	if (PageNosaveFree(page))
>  		return 0;

The pfn_is_nosave() check must stand barring justification of why
unintentionally saving (and hence restoring) the page is tolerable.


-- wli
