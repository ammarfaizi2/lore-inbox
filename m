Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030402AbWFVUwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030402AbWFVUwp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 16:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030398AbWFVUwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 16:52:45 -0400
Received: from silver.veritas.com ([143.127.12.111]:23950 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1030402AbWFVUwn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 16:52:43 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.06,166,1149490800"; 
   d="scan'208"; a="39479624:sNHT27593284"
Date: Thu, 22 Jun 2006 21:52:24 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/6] mm: tracking shared dirty pages
In-Reply-To: <20060619175253.24655.96323.sendpatchset@lappy>
Message-ID: <Pine.LNX.4.64.0606222126310.26805@blonde.wat.veritas.com>
References: <20060619175243.24655.76005.sendpatchset@lappy>
 <20060619175253.24655.96323.sendpatchset@lappy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 22 Jun 2006 20:52:42.0907 (UTC) FILETIME=[CE8BAEB0:01C6963D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2006, Peter Zijlstra wrote:
> 
> People expressed the need to track dirty pages in shared mappings.
> 
> Linus outlined the general idea of doing that through making clean
> writable pages write-protected and taking the write fault.
> 
> Index: 2.6-mm/include/linux/mm.h
> ===================================================================
> --- 2.6-mm.orig/include/linux/mm.h	2006-06-14 10:29:04.000000000 +0200
> +++ 2.6-mm/include/linux/mm.h	2006-06-19 14:45:18.000000000 +0200
> @@ -182,6 +182,12 @@ extern unsigned int kobjsize(const void 
>  #define VM_SequentialReadHint(v)	((v)->vm_flags & VM_SEQ_READ)
>  #define VM_RandomReadHint(v)		((v)->vm_flags & VM_RAND_READ)
>  
> +static inline int is_shared_writable(unsigned int flags)
> +{
> +	return (flags & (VM_SHARED|VM_WRITE|VM_PFNMAP)) ==
> +		(VM_SHARED|VM_WRITE);
> +}
> +

Andrew asked for the inclusion of VM_PFNMAP to be commented there,
I don't believe that's enough: a function called "is_shared_writable"
should be testing precisely that, or people will misuse it.

Either you change the name to "is_shared_writable_but_not_pfnmap"
or somesuch, or you split out the VM_PFNMAP test, or you do away
with the function and make the tests explicit inline.  As before,
my instinctive preference is the latter: I really want to see what's
being tested (especially in do_wp_page); but perhaps it'll just look
too ugly all over - give it a try and see.

>  /*
>   * mapping from the currently active vm_flags protection bits (the
>   * low four bits) to a page protection mask..
> Index: 2.6-mm/mm/memory.c
> ===================================================================
> --- 2.6-mm.orig/mm/memory.c	2006-06-14 10:29:06.000000000 +0200
> +++ 2.6-mm/mm/memory.c	2006-06-19 16:20:06.000000000 +0200
> @@ -938,6 +938,12 @@ struct page *follow_page(struct vm_area_
>  	pte = *ptep;
>  	if (!pte_present(pte))
>  		goto unlock;
> +	/*
> +	 * This is not fully correct in the light of trapping write faults
> +	 * for writable shared mappings. However since we're going to mark
> +	 * the page dirty anyway some few lines downward, we might as well
> +	 * take the write fault now.
> +	 */

I don't understand what you're getting at here: please explain,
what is not fully correct and why?  In mail first, then we can
decide what the comment should say, or if it should be removed.
follow_page isn't making a pte writable, so what's the issue?

>  	if ((flags & FOLL_WRITE) && !pte_write(pte))
>  		goto unlock;
>  	page = vm_normal_page(vma, address, pte);
> @@ -1458,13 +1464,14 @@ static int do_wp_page(struct mm_struct *
>  {
>  	struct page *old_page, *new_page;
>  	pte_t entry;
> -	int reuse, ret = VM_FAULT_MINOR;
> +	int reuse = 0, ret = VM_FAULT_MINOR;
> +	struct page *dirty_page = NULL;
>  
>  	old_page = vm_normal_page(vma, address, orig_pte);
>  	if (!old_page)
>  		goto gotten;
>  
> -	if (unlikely(vma->vm_flags & VM_SHARED)) {
> +	if (unlikely(is_shared_writable(vma->vm_flags))) {

Most interesting line in the series, yes, and I'd find it
easier to think through if it showed the flags test explicitly:
	if ((vma->vm_flags & (VM_SHARED|VM_WRITE|VM_PFNMAP)) ==
		(VM_SHARED|VM_WRITE))

Yes, Andrew, you're right it's a change in behaviour from David's
page_mkwrite patch.  I've realized that when I was originally
reviewing David's patch, I believed do_wp_page was mistaken to be
doing COW on VM_SHARED areas.  But Linus has since asserted very
forcefully that it's intentional, that ptrace poke on a VM_SHARED
area which is currently not !VM_WRITE should COW it, so I mentioned
that to Peter.

Has he got the test right there now?  Ummm... maybe: my brain
exploded weeks ago.  Several strangenesses collide here, I'll
try again tomorrow, maybe others will argue it to certainty before.

>  		if (vma->vm_ops && vma->vm_ops->page_mkwrite) {
>  			/*
>  			 * Notify the address space that the page is about to
> Index: 2.6-mm/mm/mmap.c
> ===================================================================
> --- 2.6-mm.orig/mm/mmap.c	2006-06-14 10:29:06.000000000 +0200
> +++ 2.6-mm/mm/mmap.c	2006-06-19 15:41:53.000000000 +0200
> @@ -25,6 +25,7 @@
>  #include <linux/mount.h>
>  #include <linux/mempolicy.h>
>  #include <linux/rmap.h>
> +#include <linux/backing-dev.h>
>  
>  #include <asm/uaccess.h>
>  #include <asm/cacheflush.h>
> @@ -888,6 +889,7 @@ unsigned long do_mmap_pgoff(struct file 
>  	struct rb_node ** rb_link, * rb_parent;
>  	int accountable = 1;
>  	unsigned long charged = 0, reqprot = prot;
> +	struct address_space *mapping = NULL;
>  
>  	if (file) {
>  		if (is_file_hugepages(file))
> @@ -1084,18 +1086,13 @@ munmap_back:
>  		error = file->f_op->mmap(file, vma);
>  		if (error)
>  			goto unmap_and_free_vma;
> +

Do you really need this blank line?

>  	} else if (vm_flags & VM_SHARED) {
>  		error = shmem_zero_setup(vma);
>  		if (error)
>  			goto free_vma;
>  	}
>  
> -	/* Don't make the VMA automatically writable if it's shared, but the
> -	 * backer wishes to know when pages are first written to */
> -	if (vma->vm_ops && vma->vm_ops->page_mkwrite)
> -		vma->vm_page_prot =
> -			protection_map[vm_flags & (VM_READ|VM_WRITE|VM_EXEC)];
> -
>  	/* We set VM_ACCOUNT in a shared mapping's vm_flags, to inform
>  	 * shmem_zero_setup (perhaps called through /dev/zero's ->mmap)
>  	 * that memory reservation must be checked; but that reservation
> @@ -1113,6 +1110,31 @@ munmap_back:
>  	pgoff = vma->vm_pgoff;
>  	vm_flags = vma->vm_flags;
>  
> +	/*
> +	 * Tracking of dirty pages for shared writable mappings. Do this by
> +	 * write protecting writable pages, and mark dirty in the write fault.
> +	 *
> +	 * Modify vma->vm_page_prot (the default protection for new pages)
> +	 * to this effect.
> +	 *
> +	 * Cannot do before because the condition depends on:
> +	 *  - backing_dev_info having the right capabilities
> +	 *    (set by f_op->open())

Is that so, backing_dev_info set by f_op->open()?
And how would that be a problem here if it were so?

> +	 *  - vma->vm_flags being fully set
> +	 *    (finished in f_op->mmap(), which could call remap_pfn_range())
> +	 *
> +	 *  Also, cannot reset vma->vm_page_prot from vma->vm_flags because
> +	 *  f_op->mmap() can modify it.
> +	 */
> +	if (is_shared_writable(vm_flags) && vma->vm_file)
> +		mapping = vma->vm_file->f_mapping;
> +	if ((mapping && mapping_cap_account_dirty(mapping)) ||
> +			(vma->vm_ops && vma->vm_ops->page_mkwrite))

The only way "mapping" might be set is just above.
Wouldn't it all be clearer (though more indented) if you said

	if (is_shared_writable(vm_flags) && vma->vm_file) {
		mapping = vma->vm_file->f_mapping;
		if ((mapping && mapping_cap_account_dirty(mapping)) ||
				(vma->vm_ops && vma->vm_ops->page_mkwrite)) {
			vma->vm_page_prot = whatever;
		}
	}

Or no need for "mapping" here at all if you change
mapping_cap_account_dirty(vma->vm_file->f_mapping)
to do the right thing with NULL.

> +		vma->vm_page_prot =
> +			__pgprot(pte_val
> +				(pte_wrprotect
> +				 (__pte(pgprot_val(vma->vm_page_prot)))));
> +

In other mail I've suggested saving vm_page_prot above, and
changing it here only if the driver's ->mmap did not change it.

I remain uneasy about interfering with the permissions expected by
strange drivers, but can't really justify my paranoia.  Certainly
you're right to exclude VM_PFNMAPs from this interference, that's
important; I'd be less uneasy if you also exclude VM_INSERTPAGEs,
they're strange too - but at least they're dealing with proper struct
pages, so should be able to handle an unexpected do_wp_page; that
leaves the driver nopage cases, which again should be okay now you're
(one way or another) protecting specially added vm_page_prot flags.

I guess I'm just paranoid; it's irritating me that we do not have
the right backing_dev_infos in place and having to hack around it.

>  	if (!file || !vma_merge(mm, prev, addr, vma->vm_end,
>  			vma->vm_flags, NULL, file, pgoff, vma_policy(vma))) {
>  		file = vma->vm_file;
> Index: 2.6-mm/mm/mprotect.c
> ===================================================================
> --- 2.6-mm.orig/mm/mprotect.c	2006-06-14 10:29:06.000000000 +0200
> +++ 2.6-mm/mm/mprotect.c	2006-06-19 16:19:42.000000000 +0200
> @@ -21,6 +21,7 @@
>  #include <linux/syscalls.h>
>  #include <linux/swap.h>
>  #include <linux/swapops.h>
> +#include <linux/backing-dev.h>
>  #include <asm/uaccess.h>
>  #include <asm/pgtable.h>
>  #include <asm/cacheflush.h>
> @@ -124,6 +125,7 @@ mprotect_fixup(struct vm_area_struct *vm
>  	long nrpages = (end - start) >> PAGE_SHIFT;
>  	unsigned long charged = 0;
>  	unsigned int mask;
> +	struct address_space *mapping = NULL;
>  	pgprot_t newprot;
>  	pgoff_t pgoff;
>  	int error;
> @@ -179,7 +181,10 @@ success:
>  	/* Don't make the VMA automatically writable if it's shared, but the
>  	 * backer wishes to know when pages are first written to */
>  	mask = VM_READ|VM_WRITE|VM_EXEC|VM_SHARED;
> -	if (vma->vm_ops && vma->vm_ops->page_mkwrite)
> +	if (is_shared_writable(newflags) && vma->vm_file)
> +		mapping = vma->vm_file->f_mapping;
> +	if ((mapping && mapping_cap_account_dirty(mapping)) ||
> +			(vma->vm_ops && vma->vm_ops->page_mkwrite))

Similar remarks on indenting,
or letting mapping_cap_account_dirty take NULL mapping.

>  		mask &= ~VM_SHARED;
>  
>  	newprot = protection_map[newflags & mask];
> Index: 2.6-mm/mm/rmap.c
> ===================================================================
> --- 2.6-mm.orig/mm/rmap.c	2006-06-14 10:29:07.000000000 +0200
> +++ 2.6-mm/mm/rmap.c	2006-06-19 14:45:18.000000000 +0200
> @@ -53,6 +53,7 @@
>  #include <linux/rmap.h>
>  #include <linux/rcupdate.h>
>  #include <linux/module.h>
> +#include <linux/backing-dev.h>
>  
>  #include <asm/tlbflush.h>
>  
> @@ -434,6 +435,73 @@ int page_referenced(struct page *page, i
>  	return referenced;
>  }
>  
> +static int page_mkclean_one(struct page *page, struct vm_area_struct *vma, int protect)
> +{
> +	struct mm_struct *mm = vma->vm_mm;
> +	unsigned long address;
> +	pte_t *pte, entry;
> +	spinlock_t *ptl;
> +	int ret = 0;
> +
> +	address = vma_address(page, vma);
> +	if (address == -EFAULT)
> +		goto out;
> +
> +	pte = page_check_address(page, mm, address, &ptl);
> +	if (!pte)
> +		goto out;
> +
> +	if (!(pte_dirty(*pte) || (protect && pte_write(*pte))))
> +		goto unlock;
> +
> +	entry = ptep_get_and_clear(mm, address, pte);
> +	entry = pte_mkclean(entry);
> +	if (protect)
> +		entry = pte_wrprotect(entry);
> +	ptep_establish(vma, address, pte, entry);
> +	lazy_mmu_prot_update(entry);
> +	ret = 1;
> +
> +unlock:
> +	pte_unmap_unlock(pte, ptl);
> +out:
> +	return ret;
> +}
> +
> +static int page_mkclean_file(struct address_space *mapping, struct page *page)
> +{
> +	pgoff_t pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
> +	struct vm_area_struct *vma;
> +	struct prio_tree_iter iter;
> +	int ret = 0;
> +
> +	BUG_ON(PageAnon(page));
> +
> +	spin_lock(&mapping->i_mmap_lock);
> +	vma_prio_tree_foreach(vma, &iter, &mapping->i_mmap, pgoff, pgoff) {
> +		int protect = mapping_cap_account_dirty(mapping) &&
> +			is_shared_writable(vma->vm_flags);
> +		ret += page_mkclean_one(page, vma, protect);

You have a good point here, one I'd completely missed: because a vma
may have been recently mprotected !VM_WRITE, you have to check readonly
mappings too.  Perhaps worth a comment.  But I think "is_shared_writable"
is not the best test here: just test for VM_SHARED vmas, they're the
only ones which can be mprotected to/from shared writable.  And then
I think you don't need to pass down an additional "protect" argument?
It's only being called for mapping_cap_account_dirty mappings anyway,
isn't it?

> +	}
> +	spin_unlock(&mapping->i_mmap_lock);
> +	return ret;
> +}

Hugh
