Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750895AbWFWTG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbWFWTG5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 15:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751944AbWFWTG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 15:06:57 -0400
Received: from silver.veritas.com ([143.127.12.111]:26240 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1750895AbWFWTG4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 15:06:56 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.06,169,1149490800"; 
   d="scan'208"; a="39508197:sNHT26009032"
Date: Fri, 23 Jun 2006 20:06:34 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] mm: tracking shared dirty pages -v10
In-Reply-To: <1151019590.15744.144.camel@lappy>
Message-ID: <Pine.LNX.4.64.0606231933060.7524@blonde.wat.veritas.com>
References: <20060619175243.24655.76005.sendpatchset@lappy> 
 <20060619175253.24655.96323.sendpatchset@lappy> 
 <Pine.LNX.4.64.0606222126310.26805@blonde.wat.veritas.com>
 <1151019590.15744.144.camel@lappy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 23 Jun 2006 19:06:55.0154 (UTC) FILETIME=[31673120:01C696F8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006, Peter Zijlstra wrote:

> Preview of the goodness,
> 
> I'll repost the whole thing tomorrow after I've updated the other
> patches, esp. the msync one. I seem to be too tired to make any sense
> out of that atm.
> 
> (PS, 2.6.17-mm1 UML doesn't seem to boot)
> 
> -------------------------------------------------------
> 
> 
> From: Peter Zijlstra <a.p.zijlstra@chello.nl>
> 
> Tracking of dirty pages in shared writeable mmap()s.
> 
> The idea is simple: write protect clean shared writeable pages,
> catch the write-fault, make writeable and set dirty. On page write-back
> clean all the PTE dirty bits and write protect them once again.
> 
> The implementation is a tad harder, mainly because the default
> backing_dev_info capabilities were too loosely maintained. Hence it is
> not enough to test the backing_dev_info for cap_account_dirty.
> 
> The current heuristic is as follows, a VMA is eligible when:
>  - its shared writeable 
>     (vm_flags & (VM_WRITE|VM_SHARED)) == (VM_WRITE|VM_SHARED)
>  - it is not a PFN mapping
>     (vm_flags & VM_PFNMAP) == 0
>  - the backing_dev_info is cap_account_dirty
>     mapping_cap_account_dirty(vma->vm_file->f_mapping)
>  - f_op->mmap() didn't change the default page protection
> 
> NOTE: the last rule is only checked in do_mmap_pgoff(), other code-
> paths assume they will not be reached in that case.

(You've probably noticed that use of mprotect on problem vmas
is liable to remove the cache bits.  There have been occasional
complaints about that, and perhaps a patch to fix it.  But that's
long-standing behaviour, so not something you need worry about:
we've only had to worry about a new change in behaviour in mmap.)

> 
> Page from remap_pfn_range() are explicitly excluded because their
> COW semantics are already horrid enough (see vm_normal_page() in
> do_wp_page()) and because they don't have a backing store anyway.
> 
> copy_one_pte() cleans child PTEs, not wrong in the current context,
> but why?

Dates back to Linux 2.2 if not earlier.  I think the idea is that the
parent has its pte dirty, and that's enough to mark the page as dirty;
the child is unlikely to dirty the page further itself, and a second
instance of dirty pte for that page may entail some overhead.  What
overhead would vary from release to release, I've not thought through
what the current saving would be in 2.6.17, probably very little.
But you can imagine there might have been some release which would
write out the page each time it found pte dirty, in which case good
reason to clear it there.  But I'm guessing, it's from before my time.

> 
> mprotect() is taught about the new behaviour as well.
> 
> Cleaning the pages on write-back is done with page_mkclean() a new
> rmap call. It can be called on any page, but is currently only
> implemented for mapped pages (does it make sense to also implement
> anon pages?), if the page is found the be of a trackable VMA it
> will also wrprotect the PTE.
> 
> Finally, in fs/buffers.c:try_to_free_buffers(); remove clear_page_dirty()
> from under ->private_lock. This seems to be save, since ->private_lock 
> is used to serialize access to the buffers, not the page itself.
> This is needed because clear_page_dirty() will call into page_mkclean()
> and would thereby violate locking order.
> 
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> ---
> Changes in -v10
> 
>  - 2.6.17-mm1
>  - Drop the ugly duckling pgprotting, Hugh suggested resetting the
>    vma->vm_page_prot when f_op->mmap() didn't modify it. If it were
>    modified we're not interested anyway.
>  - abandon is_shared_writable() because its actually spelled writeable
>    and it didn't actually mean that any more.
>  - Comments all round.
> 
> Index: 2.6-mm/mm/memory.c
> ===================================================================
> --- 2.6-mm.orig/mm/memory.c	2006-06-22 17:59:07.000000000 +0200
> +++ 2.6-mm/mm/memory.c	2006-06-23 01:08:11.000000000 +0200
> @@ -1458,14 +1458,19 @@ static int do_wp_page(struct mm_struct *
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
> -	if (unlikely((vma->vm_flags & (VM_SHARED|VM_WRITE)) ==
> -				(VM_SHARED|VM_WRITE))) {
> +	/*
> +	 * Only catch write-faults on shared writable pages, read-only
> +	 * shared pages can get COWed by get_user_pages(.write=1, .force=1).
> +	 */
> +	if (unlikely(((vma->vm_flags & (VM_WRITE|VM_SHARED)) ==
> +					(VM_WRITE|VM_SHARED)))) {

I was about to say I'm satisfied with that test now, and it's all the
better for not mentioning VM_PFNMAP there - though odd that you've
exchanged WRITE and SHARED, and added extra unnecessary parentheses ;)

But grrr, sigh, damn, argh - I now realize it's right to the first
order (normal case) and to the second order (ptrace poke), but not
to the third order (ptrace poke anon page here to be COWed -
perhaps can't occur without intervening mprotects).

That's not an issue for you at all (there are other places which
are inconsistent on whether such pages are private or shared e.g.
copy_one_pte does not wrprotect them), but could be a problem for
David's page_mkwrite - there's a danger of passing it an anonymous
page, which (depending on what the ->page_mkwrite actually does)
could go seriously wrong.

I guess it ought to be restructured
	if (PageAnon(old_page)) {
		...
	} else if (shared writable vma) {
		...
	}
and a patch to do that should precede your dirty page patches
(and the only change your dirty page patches need add here on top
of that would be the dirty_page = old_page, get_page(dirty_page)).

Oh, it looks like Linus is keen to go ahead with your patches in
2.6.18, so in that case it'll be easier to go ahead with the patch
as you have it, and fix up this order-3 issue on top afterwards -
it's not something testers are going to be hitting every day,
especially without any ->page_mkwrite implementations.

> Index: 2.6-mm/mm/mmap.c
> ===================================================================
> --- 2.6-mm.orig/mm/mmap.c	2006-06-22 17:59:07.000000000 +0200
> +++ 2.6-mm/mm/mmap.c	2006-06-23 01:31:44.000000000 +0200
> @@ -1113,6 +1109,34 @@ munmap_back:
>  	pgoff = vma->vm_pgoff;
>  	vm_flags = vma->vm_flags;
>  
> +	/*
> +	 * Tracking of dirty pages for shared writable mappings. Do this by
> +	 * write protecting writable pages, and mark dirty in the write fault.
> +	 *
> +	 * Cannot do before because the condition depends on:
> +	 *  - backing_dev_info having the right capabilities
> +	 *  - vma->vm_flags being fully set
> +	 *    (finished in f_op->mmap(), which could call remap_pfn_range())
> +	 *
> +	 * If f_op->mmap() changed vma->vm_page_prot its a funny mapping
> +	 * and we won't touch it.
> +	 * NOTE: in a perfect world backing_dev_info would have the proper
> +	 * capabilities.
> +	 *
> +	 * OR
> +	 *
> +	 * Don't make the VMA automatically writable if it's shared, but the
> +	 * backer wishes to know when pages are first written to.
> +	 */
> +	if ((pgprot_val(vma->vm_page_prot) == pgprot_val(vm_page_prot) &&
> +	     ((vm_flags & (VM_WRITE|VM_SHARED|VM_PFNMAP|VM_INSERTPAGE)) ==
> +			  (VM_WRITE|VM_SHARED)) &&
> +	     vma->vm_file && vma->vm_file->f_mapping &&
> +	     mapping_cap_account_dirty(vma->vm_file->f_mapping)) ||
> +	    (vma->vm_ops && vma->vm_ops->page_mkwrite))
> +		vma->vm_page_prot =
> +			protection_map[vm_flags & (VM_READ|VM_WRITE|VM_EXEC)];
> +

I'm dazzled by the beauty of it!  Given the change you've made to
mapping_cap_account_dirty, you don't have to check vma->vm_file->f_mapping
there; but other than that, seems right to me.  May offend other tastes.

>  	if (!file || !vma_merge(mm, prev, addr, vma->vm_end,
>  			vma->vm_flags, NULL, file, pgoff, vma_policy(vma))) {
>  		file = vma->vm_file;
> Index: 2.6-mm/mm/rmap.c
> ===================================================================
> --- 2.6-mm.orig/mm/rmap.c	2006-06-22 17:59:07.000000000 +0200
> +++ 2.6-mm/mm/rmap.c	2006-06-23 01:14:39.000000000 +0200
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
> +	((vma->vm_flags & (VM_WRITE|VM_SHARED|VM_PFNMAP|VM_INSERTPAGE)) ==
> +	 		  (VM_WRITE|VM_SHARED));

I think you can forget about testing VM_PFNMAP|VM_INSERTPAGE here,
or else	BUG_ON or WARN_ON(vma->vm_flags & (VM_PFNMAP|VM_INSERTPAGE)):
those just shouldn't arrive here.

But I'm still puzzled, why did you move page_mkclean out from under
the mapping_cap_account_dirty tests in page-writeback.c: no explanation
in your change history.  Doesn't that just add some unnecessary work,
and this "protect" business?

If you're thinking ahead to other changes you want to make, you'd
do better to add these changes then, and for now just work on the
VM_SHARED vmas.

> +		ret += page_mkclean_one(page, vma, protect);
> +	}
> +	spin_unlock(&mapping->i_mmap_lock);
> +	return ret;
> +}

Hugh
