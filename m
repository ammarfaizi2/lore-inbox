Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261945AbULPRKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261945AbULPRKW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 12:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbULPRKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 12:10:22 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:42975 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261945AbULPRDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 12:03:54 -0500
Date: Thu, 16 Dec 2004 17:03:26 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Dave Airlie <airlied@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at mm/rmap.c:480 in 2.6.10-rc3-bk7
In-Reply-To: <20041216142820.GN28286@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0412161618430.7344-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2004, Andrea Arcangeli wrote:
> them. I still don't excude they're a real fix though, the fact I can't
> tell the exact reason why they help doesn't mean they're not fixing the
> real bug

They avoid the bug because zap_pte_range only calls page_remove_rmap
if page_mapped(page): that's pretty much equivalent to saying "only
call page_remove_rmap if we won't hit its BUG_ON".

Though the likelihood is that the pages were found not pageable in
your patch's do_no_page (either PageReserved or !page->mapping or
both), so had page_mapcount 0 throughout, and zap_pte_range
was therefore quite right to be skipping their page_remove_rmap.

> Infact if a page becomes suddenly unreserved, shouldn't the accounting
> break anyways at the page->count level? The page would be freed twice
> instead of once.

There's very much a danger of that, and I'd been expecting Greg's
printks to show page_count 0; but in fact the page_counts were 3 or
2 or 1, none 0.  Might have fallen prematurely to 0 and below later,
I suppose (but my patch included a get_page to suppress the boring
clutter of stack backtraces which would follow in that case).
Depends on the sequence of gets, sets, clears, puts.

> I wonder if the sg_cleanup explains why some mapped reserved page
> suddenly become unreserved. Can you track if the DRM_IOCTL_SG_FREE is
> being called in a mapped vma? I guess you could start by enabling
> DRM(flags) in drm_init.h.
> 
> #if 0
> int DRM(flags) = DRM_FLAG_DEBUG;
> #else
> int DRM(flags) = 0;
> #endif
> 
> (set to 1 and then it should print something)

Very good suggestions, DRM_IOCTL_SG_FREE does look dangerous (unreserving
and freeing pages without regard to whether still in use).  Perhaps it's
not the only one, I haven't had time to recheck and must dash shortly.

But yesterday I claimed Greg's debug output showed it wasn't the
PageReserved -> !PageReserved issue I was expecting.  Turns out I had
a stupid stupid bug in my patch: I forget to delete the PageReserved
return from page_add_file_rmap before setting its PG_arch_1 shadow.
So of course no PG_arch_1 in the output, that patch of little value,
and my conclusion based on no evidence.  So today I'm again suspecting
it is that the PageReserved is cleared too early (and therefore page
likely to be freed to early).

Fixed (I hope!) patch below: Greg, please remove Andrea's patch (not
because we have our little disagreement about it, but because it will
prevent printing out the info I need), and please remove my patch of
yesterday, applying the patch below instead; then rebuild and redo
yesterday's test - sorry!  Can do that along with the DRM_FLAG_DEBUG
Andrea recommends, or separately if you prefer - certainly use of
DRM_IOCTL_SG_FREE will be very interesting.

The page flags yesterday showed 20000014: I hope the fixed patch
will show them as 20000414, which will confirm that PageReserved
got cleared too early.  No need to send all the lines, one will do.

I'm going out now, won't be able to respond until much later...

Hugh

--- 2.6.10-rc3-bk8/include/linux/rmap.h	2004-12-05 12:56:10.000000000 +0000
+++ linux/include/linux/rmap.h	2004-12-15 15:54:32.000000000 +0000
@@ -72,7 +72,7 @@ void __anon_vma_link(struct vm_area_stru
  */
 void page_add_anon_rmap(struct page *, struct vm_area_struct *, unsigned long);
 void page_add_file_rmap(struct page *);
-void page_remove_rmap(struct page *);
+void page_remove_rmap(struct page *, struct vm_area_struct *, unsigned long);
 
 /**
  * page_dup_rmap - duplicate pte mapping to a page
--- 2.6.10-rc3-bk8/mm/fremap.c	2004-12-05 12:56:12.000000000 +0000
+++ linux/mm/fremap.c	2004-12-15 15:50:11.000000000 +0000
@@ -37,7 +37,7 @@ static inline void zap_pte(struct mm_str
 			if (!PageReserved(page)) {
 				if (pte_dirty(pte))
 					set_page_dirty(page);
-				page_remove_rmap(page);
+				page_remove_rmap(page, vma, addr);
 				page_cache_release(page);
 				mm->rss--;
 			}
--- 2.6.10-rc3-bk8/mm/memory.c	2004-12-05 12:56:12.000000000 +0000
+++ linux/mm/memory.c	2004-12-15 16:03:21.000000000 +0000
@@ -366,6 +366,7 @@ nomem:
 }
 
 static void zap_pte_range(struct mmu_gather *tlb,
+		struct vm_area_struct *vma,
 		pmd_t *pmd, unsigned long address,
 		unsigned long size, struct zap_details *details)
 {
@@ -431,7 +432,7 @@ static void zap_pte_range(struct mmu_gat
 			else if (pte_young(pte))
 				mark_page_accessed(page);
 			tlb->freed++;
-			page_remove_rmap(page);
+			page_remove_rmap(page, vma, address+offset);
 			tlb_remove_page(tlb, page);
 			continue;
 		}
@@ -449,6 +450,7 @@ static void zap_pte_range(struct mmu_gat
 }
 
 static void zap_pmd_range(struct mmu_gather *tlb,
+		struct vm_area_struct *vma,
 		pgd_t * dir, unsigned long address,
 		unsigned long size, struct zap_details *details)
 {
@@ -467,7 +469,7 @@ static void zap_pmd_range(struct mmu_gat
 	if (end > ((address + PGDIR_SIZE) & PGDIR_MASK))
 		end = ((address + PGDIR_SIZE) & PGDIR_MASK);
 	do {
-		zap_pte_range(tlb, pmd, address, end - address, details);
+		zap_pte_range(tlb, vma, pmd, address, end - address, details);
 		address = (address + PMD_SIZE) & PMD_MASK; 
 		pmd++;
 	} while (address && (address < end));
@@ -483,7 +485,7 @@ static void unmap_page_range(struct mmu_
 	dir = pgd_offset(vma->vm_mm, address);
 	tlb_start_vma(tlb, vma);
 	do {
-		zap_pmd_range(tlb, dir, address, end - address, details);
+		zap_pmd_range(tlb, vma, dir, address, end - address, details);
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 	} while (address && (address < end));
@@ -1114,7 +1116,7 @@ static int do_wp_page(struct mm_struct *
 		if (PageReserved(old_page))
 			++mm->rss;
 		else
-			page_remove_rmap(old_page);
+			page_remove_rmap(old_page, vma, address);
 		break_cow(vma, new_page, address, page_table);
 		lru_cache_add_active(new_page);
 		page_add_anon_rmap(new_page, vma, address);
--- 2.6.10-rc3-bk8/mm/rmap.c	2004-12-05 12:56:12.000000000 +0000
+++ linux/mm/rmap.c	2004-12-16 16:14:03.172911152 +0000
@@ -459,8 +459,12 @@ void page_add_anon_rmap(struct page *pag
 void page_add_file_rmap(struct page *page)
 {
 	BUG_ON(PageAnon(page));
-	if (!pfn_valid(page_to_pfn(page)) || PageReserved(page))
+	if (!pfn_valid(page_to_pfn(page)))
 		return;
+	if (PageReserved(page)) {
+		set_bit(PG_arch_1, &page->flags);
+		return;
+	}
 
 	if (atomic_inc_and_test(&page->_mapcount))
 		inc_page_state(nr_mapped);
@@ -472,12 +476,22 @@ void page_add_file_rmap(struct page *pag
  *
  * Caller needs to hold the mm->page_table_lock.
  */
-void page_remove_rmap(struct page *page)
+void page_remove_rmap(struct page *page,
+	struct vm_area_struct *vma, unsigned long address)
 {
 	BUG_ON(PageReserved(page));
 
+	if (page_mapcount(page) <= 0 || page_count(page) <= 0 ||
+	    test_bit(PG_arch_1, &page->flags)) {
+		printk("Bad rmap in %s: page %p flags %lx "
+			"count %d mapcount %d addr %lx vm_flags %lx\n",
+			current->comm, page, (unsigned long)page->flags,
+			page_count(page), page_mapcount(page), address,
+			vma->vm_flags);
+		get_page(page);
+		return;
+	}
 	if (atomic_add_negative(-1, &page->_mapcount)) {
-		BUG_ON(page_mapcount(page) < 0);
 		/*
 		 * It would be tidy to reset the PageAnon mapping here,
 		 * but that might overwrite a racing page_add_anon_rmap
@@ -593,7 +607,7 @@ static int try_to_unmap_one(struct page 
 	}
 
 	mm->rss--;
-	page_remove_rmap(page);
+	page_remove_rmap(page, vma, address);
 	page_cache_release(page);
 
 out_unmap:
@@ -690,7 +704,7 @@ static void try_to_unmap_cluster(unsigne
 		if (pte_dirty(pteval))
 			set_page_dirty(page);
 
-		page_remove_rmap(page);
+		page_remove_rmap(page, vma, address);
 		page_cache_release(page);
 		mm->rss--;
 		(*mapcount)--;

