Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbUCVRvc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 12:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbUCVRvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 12:51:32 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:42177
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261361AbUCVRvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 12:51:25 -0500
Date: Mon, 22 Mar 2004 18:52:16 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: VMA_MERGING_FIXUP and patch
Message-ID: <20040322175216.GJ3649@dualathlon.random>
References: <Pine.LNX.4.44.0403221640230.11645-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403221640230.11645-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2004 at 05:05:33PM +0000, Hugh Dickins wrote:
> Just a reminder that you still have several #if VMA_MERGING_FIXUPs
> in your 2.6.5-rc2-aa1 tree, so mprotects and mremaps are not merging
> vmas at all.
> 
> I can understand if you'd prefer to leave the mremaps that way,
> at least for now.  (I do have code to decide whether any page is
> shared, will post later in anobjrmap 7/6, you could use the same
> to allow mremap vma merging if unproblematic.)  But I think you
> ought to get to merging the mprotects, aren't there apps which
> will give you a frightening number of vmas unless merged?

agreed, enabling again the merging in mprotect is quite high prio,
but really some of those apps have never been able to merge in mprotect
because we would never been able to merge the file mappings after a
vma_split. The pros is that after we fixup, the file mappings will merge
fine too (the cons is that the merging code will have to be more
complicated than it was before ;).

> Here's some minor updates (no hurry) to objrmap.c,
> mirroring recentish s390 mods to mainline rmap.c:
> the page_test_and_clear_dirty I mentioned before.

this is greatly appreciated, I didn't notice this change (I got
uninteresting rejects in mm/rmap.c.rej too often and by mistake I
stopped looking at them at some point).

> Hmm, I wonder, is that safe to be calling set_page_dirty
> from inside the page rmap lock?  Andrew?

I agree, I don't feel safe running it there indeed (it will not hang
immediatly but it enforces an ordering of other spinlocks, the less
enforced ordering the better), I'd prefer to set a local
variable and run it after the page_map_unlock.  Actually re-reading
page->mapcount lockless should be ok too, if we don't read zero due a
race, it means somebody else will run the unmap or remove_page_rmap
again. All it matters is that the very last one unmapping the page reads
zero and that's guaranteed even without the spinlock.

> --- 2.6.5-rc2-aa1/mm/objrmap.c	2004-03-22 11:38:55.000000000 +0000
> +++ linux/mm/objrmap.c	2004-03-22 16:34:29.421216936 +0000
> @@ -212,7 +212,7 @@ int fastcall page_referenced(struct page
>  	BUG_ON(!page->mapping);
>  
>  	if (page_test_and_clear_young(page))
> -		mark_page_accessed(page);
> +		referenced++;
>  
>  	if (TestClearPageReferenced(page))
>  		referenced++;

I definitely agree with this one.

what about this?

thanks for spotting these s390 bugs! 

--- x/mm/vmscan.c.~1~	2004-03-21 15:21:42.000000000 +0100
+++ x/mm/vmscan.c	2004-03-22 18:39:05.551793088 +0100
@@ -313,16 +313,14 @@ shrink_list(struct list_head *page_list,
 		if (page_mapped(page) && mapping) {
 			switch (try_to_unmap(page)) {
 			case SWAP_FAIL:
-				page_map_unlock(page);
 				goto activate_locked;
 			case SWAP_AGAIN:
-				page_map_unlock(page);
 				goto keep_locked;
 			case SWAP_SUCCESS:
 				; /* try to free the page below */
 			}
-		}
-		page_map_unlock(page);
+		} else
+			page_map_unlock(page);
 
 		/*
 		 * If the page is dirty, only perform writeback if that write
--- x/mm/memory.c.~1~	2004-03-21 15:21:42.000000000 +0100
+++ x/mm/memory.c	2004-03-22 13:40:26.852849384 +0100
@@ -324,9 +324,11 @@ skip_copy_pte_range:
 					 * Device driver pages must not be
 					 * tracked by the VM for unmapping.
 					 */
-					BUG_ON(!page_mapped(page));
-					BUG_ON(!page->mapping);
-					page_add_rmap(page, vma, address, PageAnon(page));
+					if (likely(page_mapped(page) && page->mapping))
+						page_add_rmap(page, vma, address, PageAnon(page));
+					else
+						printk("Badness in %s at %s:%d\n",
+						       __FUNCTION__, __FILE__, __LINE__);
 				} else {
 					BUG_ON(page_mapped(page));
 					BUG_ON(page->mapping);
@@ -1429,7 +1431,9 @@ retry:
 	 * real anonymous pages, they're "device" reserved pages instead.
 	 */
 	reserved = !!(vma->vm_flags & VM_RESERVED);
-	WARN_ON(reserved == pageable);
+	if (unlikely(reserved == pageable))
+		printk("Badness in %s at %s:%d\n",
+		       __FUNCTION__, __FILE__, __LINE__);
 
 	/*
 	 * Should we do an early C-O-W break?
--- x/mm/objrmap.c.~1~	2004-03-21 15:21:42.000000000 +0100
+++ x/mm/objrmap.c	2004-03-22 18:41:56.434814920 +0100
@@ -48,6 +48,12 @@ static inline void validate_anon_vma_fin
 #endif
 }
 
+static pte_t *
+find_pte_nonlinear(struct mm_struct * mm, struct vm_area_struct *vma, struct page *page)
+{
+	
+}
+
 /**
  * find_pte - Find a pte pointer given a vma and a struct page.
  * @vma: the vma to search
@@ -62,7 +68,7 @@ static inline void validate_anon_vma_fin
  * 
  * It is the caller's responsibility to unmap the pte if it is returned.
  */
-static inline pte_t *
+static pte_t *
 find_pte(struct vm_area_struct *vma, struct page *page, unsigned long *addr)
 {
 	struct mm_struct *mm = vma->vm_mm;
@@ -72,6 +78,9 @@ find_pte(struct vm_area_struct *vma, str
 	unsigned long loffset;
 	unsigned long address;
 
+	if (vma->vm_flags & VM_NONLINEAR)
+		return find_pte_nonlinear(mm, vma, page);
+
 	loffset = (page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT));
 	address = vma->vm_start + ((loffset - vma->vm_pgoff) << PAGE_SHIFT);
 	if (address < vma->vm_start || address >= vma->vm_end)
@@ -120,6 +129,13 @@ page_referenced_one(struct vm_area_struc
 	pte_t *pte;
 	int referenced = 0;
 
+	/*
+	 * Tracking the referenced info is too expensive
+	 * for nonlinear mappings.
+	 */
+	if (vma->vm_flags & VM_NONLINEAR)
+		goto out;
+
 	if (!spin_trylock(&mm->page_table_lock))
 		goto out;
 
@@ -212,7 +228,7 @@ int fastcall page_referenced(struct page
 	BUG_ON(!page->mapping);
 
 	if (page_test_and_clear_young(page))
-		mark_page_accessed(page);
+		referenced++;
 
 	if (TestClearPageReferenced(page))
 		referenced++;
@@ -344,6 +360,10 @@ void fastcall page_remove_rmap(struct pa
   
  out_unlock:
 	page_map_unlock(page);
+
+	if (page_test_and_clear_dirty(page) && !page_mapped(page))
+		set_page_dirty(page);
+
 	return;
 }
 
@@ -523,6 +543,11 @@ int fastcall try_to_unmap(struct page * 
 		dec_page_state(nr_mapped);
 		ret = SWAP_SUCCESS;
 	}
+	page_map_unlock(page);
+
+	if (page_test_and_clear_dirty(page) && ret == SWAP_SUCCESS)
+		set_page_dirty(page);
+
 	return ret;
 }
 


