Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268515AbUJOVwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268515AbUJOVwH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 17:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268470AbUJOVuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 17:50:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18085 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268488AbUJOVsy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 17:48:54 -0400
Date: Fri, 15 Oct 2004 17:00:41 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: page fault scalability patch V10: [2/7] defer/omit taking page_table_lock
Message-ID: <20041015200041.GD4937@logos.cnet>
References: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0409201348070.4628@schroedinger.engr.sgi.com> <20040920205752.GH4242@wotan.suse.de> <200409211841.25507.vda@port.imtp.ilyichevsk.odessa.ua> <20040921154542.GB12132@wotan.suse.de> <41527885.8020402@myrealbox.com> <20040923090345.GA6146@wotan.suse.de> <Pine.LNX.4.58.0409271204180.31769@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0410151201020.26697@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0410151203521.26697@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410151203521.26697@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Christoph,

Nice work! 

On Fri, Oct 15, 2004 at 12:04:53PM -0700, Christoph Lameter wrote:
> Changelog
> 	* Increase parallelism in SMP configurations by deferring
> 	  the acquisition of page_table_lock in handle_mm_fault
> 	* Anonymous memory page faults bypass the page_table_lock
> 	  through the use of atomic page table operations
> 	* Swapper does not set pte to empty in transition to swap
> 	* Simulate atomic page table operations using the
> 	  page_table_lock if an arch does not define
> 	  __HAVE_ARCH_ATOMIC_TABLE_OPS. This still provides
> 	  a performance benefit since the page_table_lock
> 	  is held for shorter periods of time.
> 
> Signed-off-by: Christoph Lameter <clameter@sgi.com>
> 
> Index: linux-2.6.9-rc4/mm/memory.c
> ===================================================================
> --- linux-2.6.9-rc4.orig/mm/memory.c	2004-10-14 12:22:14.000000000 -0700
> +++ linux-2.6.9-rc4/mm/memory.c	2004-10-14 12:22:14.000000000 -0700
> @@ -1314,8 +1314,7 @@
>  }
> 
>  /*
> - * We hold the mm semaphore and the page_table_lock on entry and
> - * should release the pagetable lock on exit..
> + * We hold the mm semaphore
>   */
>  static int do_swap_page(struct mm_struct * mm,
>  	struct vm_area_struct * vma, unsigned long address,
> @@ -1327,15 +1326,13 @@
>  	int ret = VM_FAULT_MINOR;
> 
>  	pte_unmap(page_table);
> -	spin_unlock(&mm->page_table_lock);
>  	page = lookup_swap_cache(entry);
>  	if (!page) {
>   		swapin_readahead(entry, address, vma);
>   		page = read_swap_cache_async(entry, vma, address);
>  		if (!page) {
>  			/*
> -			 * Back out if somebody else faulted in this pte while
> -			 * we released the page table lock.
> +			 * Back out if somebody else faulted in this pte
>  			 */
>  			spin_lock(&mm->page_table_lock);
>  			page_table = pte_offset_map(pmd, address);

The comment above, which is a few lines down on do_swap_page() is now 
bogus (the "while we released the page table lock"). 

        /*
         * Back out if somebody else faulted in this pte while we
         * released the page table lock.
         */
        spin_lock(&mm->page_table_lock);
        page_table = pte_offset_map(pmd, address);
        if (unlikely(!pte_same(*page_table, orig_pte))) {

> @@ -1406,14 +1403,12 @@
>  }
> 
>  /*
> - * We are called with the MM semaphore and page_table_lock
> - * spinlock held to protect against concurrent faults in
> - * multithreaded programs.
> + * We are called with the MM semaphore held.
>   */
>  static int
>  do_anonymous_page(struct mm_struct *mm, struct vm_area_struct *vma,
>  		pte_t *page_table, pmd_t *pmd, int write_access,
> -		unsigned long addr)
> +		unsigned long addr, pte_t orig_entry)
>  {
>  	pte_t entry;
>  	struct page * page = ZERO_PAGE(addr);
> @@ -1425,7 +1420,6 @@
>  	if (write_access) {
>  		/* Allocate our own private page. */
>  		pte_unmap(page_table);
> -		spin_unlock(&mm->page_table_lock);
> 
>  		if (unlikely(anon_vma_prepare(vma)))
>  			goto no_mem;
> @@ -1434,30 +1428,39 @@
>  			goto no_mem;
>  		clear_user_highpage(page, addr);
> 
> -		spin_lock(&mm->page_table_lock);
> +		lock_page(page);

Question: Why do you need to hold the pagelock now?

I can't seem to figure that out myself.

>  		page_table = pte_offset_map(pmd, addr);
> 
> -		if (!pte_none(*page_table)) {
> -			pte_unmap(page_table);
> -			page_cache_release(page);
> -			spin_unlock(&mm->page_table_lock);
> -			goto out;
> -		}
> -		atomic_inc(&mm->mm_rss);
>  		entry = maybe_mkwrite(pte_mkdirty(mk_pte(page,
>  							 vma->vm_page_prot)),
>  				      vma);
> -		lru_cache_add_active(page);
>  		mark_page_accessed(page);
> -		page_add_anon_rmap(page, vma, addr);
>  	}
> 
> -	set_pte(page_table, entry);
> +	/* update the entry */
> +	if (!ptep_cmpxchg(vma, addr, page_table, orig_entry, entry)) {
> +		if (write_access) {
> +			pte_unmap(page_table);
> +			unlock_page(page);
> +			page_cache_release(page);
> +		}
> +		goto out;
> +	}
> +	if (write_access) {
> +		/*
> +		 * The following two functions are safe to use without
> +		 * the page_table_lock but do they need to come before
> +		 * the cmpxchg?
> +		 */

They do need to come after AFAICS - from the point they are in the reverse map 
and the page is on the LRU try_to_unmap() can come in and try to 
unmap the pte (now that we dont hold page_table_lock anymore).

> +		lru_cache_add_active(page);
> +		page_add_anon_rmap(page, vma, addr);
> +		atomic_inc(&mm->mm_rss);
> +		unlock_page(page);
> +	}
>  	pte_unmap(page_table);
> 
>  	/* No need to invalidate - it was non-present before */
>  	update_mmu_cache(vma, addr, entry);
> -	spin_unlock(&mm->page_table_lock);
>  out:
>  	return VM_FAULT_MINOR;
>  no_mem:
> @@ -1473,12 +1476,12 @@
>   * As this is called only for pages that do not currently exist, we
>   * do not need to flush old virtual caches or the TLB.
>   *
> - * This is called with the MM semaphore held and the page table
> - * spinlock held. Exit with the spinlock released.
> + * This is called with the MM semaphore held.
>   */
>  static int
>  do_no_page(struct mm_struct *mm, struct vm_area_struct *vma,
> -	unsigned long address, int write_access, pte_t *page_table, pmd_t *pmd)
> +	unsigned long address, int write_access, pte_t *page_table,
> +        pmd_t *pmd, pte_t orig_entry)
>  {
>  	struct page * new_page;
>  	struct address_space *mapping = NULL;
> @@ -1489,9 +1492,8 @@
> 
>  	if (!vma->vm_ops || !vma->vm_ops->nopage)
>  		return do_anonymous_page(mm, vma, page_table,
> -					pmd, write_access, address);
> +					pmd, write_access, address, orig_entry);
>  	pte_unmap(page_table);
> -	spin_unlock(&mm->page_table_lock);
> 
>  	if (vma->vm_file) {
>  		mapping = vma->vm_file->f_mapping;
> @@ -1589,7 +1591,7 @@
>   * nonlinear vmas.
>   */
>  static int do_file_page(struct mm_struct * mm, struct vm_area_struct * vma,
> -	unsigned long address, int write_access, pte_t *pte, pmd_t *pmd)
> +	unsigned long address, int write_access, pte_t *pte, pmd_t *pmd, pte_t entry)
>  {
>  	unsigned long pgoff;
>  	int err;
> @@ -1602,13 +1604,12 @@
>  	if (!vma->vm_ops || !vma->vm_ops->populate ||
>  			(write_access && !(vma->vm_flags & VM_SHARED))) {
>  		pte_clear(pte);
> -		return do_no_page(mm, vma, address, write_access, pte, pmd);
> +		return do_no_page(mm, vma, address, write_access, pte, pmd, entry);
>  	}
> 
>  	pgoff = pte_to_pgoff(*pte);
> 
>  	pte_unmap(pte);
> -	spin_unlock(&mm->page_table_lock);
> 
>  	err = vma->vm_ops->populate(vma, address & PAGE_MASK, PAGE_SIZE, vma->vm_page_prot, pgoff, 0);
>  	if (err == -ENOMEM)
> @@ -1627,49 +1628,49 @@
>   * with external mmu caches can use to update those (ie the Sparc or
>   * PowerPC hashed page tables that act as extended TLBs).
>   *
> - * Note the "page_table_lock". It is to protect against kswapd removing
> - * pages from under us. Note that kswapd only ever _removes_ pages, never
> - * adds them. As such, once we have noticed that the page is not present,
> - * we can drop the lock early.
> - *
> + * Note that kswapd only ever _removes_ pages, never adds them.
> + * We need to insure to handle that case properly.
> + *
>   * The adding of pages is protected by the MM semaphore (which we hold),
>   * so we don't need to worry about a page being suddenly been added into
>   * our VM.
> - *
> - * We enter with the pagetable spinlock held, we are supposed to
> - * release it when done.
>   */
>  static inline int handle_pte_fault(struct mm_struct *mm,
>  	struct vm_area_struct * vma, unsigned long address,
>  	int write_access, pte_t *pte, pmd_t *pmd)
>  {
>  	pte_t entry;
> +	pte_t new_entry;
> 
>  	entry = *pte;
>  	if (!pte_present(entry)) {
>  		/*
>  		 * If it truly wasn't present, we know that kswapd
>  		 * and the PTE updates will not touch it later. So
> -		 * drop the lock.
> +		 * no need to acquire the page_table_lock.
>  		 */
>  		if (pte_none(entry))
> -			return do_no_page(mm, vma, address, write_access, pte, pmd);
> +			return do_no_page(mm, vma, address, write_access, pte, pmd, entry);
>  		if (pte_file(entry))
> -			return do_file_page(mm, vma, address, write_access, pte, pmd);
> +			return do_file_page(mm, vma, address, write_access, pte, pmd, entry);
>  		return do_swap_page(mm, vma, address, pte, pmd, entry, write_access);
>  	}

I wonder what happens if kswapd, through try_to_unmap_one(), unmap's the
pte right here ? 

Aren't we going to proceed with the "pte_mkyoung(entry)" of a potentially 
now unmapped pte? Isnt that case possible now?

