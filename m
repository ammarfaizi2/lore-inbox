Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262404AbULORZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262404AbULORZA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 12:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbULORY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 12:24:59 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:56799 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262405AbULORXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 12:23:43 -0500
Date: Wed, 15 Dec 2004 17:23:14 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Greg KH <greg@kroah.com>
cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at mm/rmap.c:480 in 2.6.10-rc3-bk7
In-Reply-To: <20041215011132.GA16099@kroah.com>
Message-ID: <Pine.LNX.4.44.0412151656010.2704-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Dec 2004, Greg KH wrote:
> 
> Yes, I can duplicate it easily now:
> 	- running X with drm and the radeon driver
> 	- start a gish game up in 640x480 mode and start the initial
> 	  level.
> 	- as the laptop just can't handle the cpu demands of this
> 	  program, everything runs way too slow.
> 	- switch back to the console that I started X up on and hit
> 	  ctrl-C.
> 	- X dies, and the kernel oops happens.
> 
> And yes, it does only show up when I'm using drm/agp for me, as this is
> the only way I've ever seen this error.  I can't really even get gish to
> start up without drm, but I guess I could try to see if I can do that
> later tonight.

Great you can duplicate it, useful info, thanks a lot.

I think it very likely that your page_remove_rmap BUGs are caused by
the first idea that occurred to me, months back, which intervening
reports didn't seem to fit with: PageReserved(page) when the page is
mapped into userspace, but !PageReserved(page) when it gets unmapped.

Which would suggest some kind of refcounting bug in drivers/char/drm/,
such that the reserved pages get unreserved and freed before their
last unmap.  I've started looking for that, but drivers/char/drm/ is
unfamiliar territory to me, so I'd be glad for someone to beat me to it.

> Any testing you want me to do?

It would be sensible to test out whether that hypothesis fits, so please
rebuild a kernel with the patch below (for testing, on i386, only), and
try out your procedure above.  But while running gish, before killing X,
please take a copy of /proc/$(pidof gish)/maps to mail me.  Then when
you kill X, there should be a number (perhaps an irritatingly large
number: but because pages have been wrongly freed so perhaps reused,
relying on a single page report seems unwise) of "Bad rmap" messages.
Please mail all those along with gish's maps to me (may well be too
much for lkml), I'll report back whether they confirm or refute the
hypothesis.

> Oh, and this also happens on 2.6.10-rc3-bk8.

I've made the patch against -bk8 but expect it'll be good for either.

There looks to be little change in drivers/char/drm/ since 2.6.9,
so I'd expect the same problem in that too, if not even earlier.
But of course I may prove quite wrong to be placing blame there.

Thanks,
Hugh

--- 2.6.10-rc3-bk8/include/linux/rmap.h	2004-12-05 12:56:10.000000000 +0000
+++ linux/include/linux/rmap.h	2004-12-15 15:54:32.842874344 +0000
@@ -72,7 +72,7 @@ void __anon_vma_link(struct vm_area_stru
  */
 void page_add_anon_rmap(struct page *, struct vm_area_struct *, unsigned long);
 void page_add_file_rmap(struct page *);
-void page_remove_rmap(struct page *);
+void page_remove_rmap(struct page *, struct vm_area_struct *, unsigned long);
 
 /**
  * page_dup_rmap - duplicate pte mapping to a page
--- 2.6.10-rc3-bk8/mm/fremap.c	2004-12-05 12:56:12.000000000 +0000
+++ linux/mm/fremap.c	2004-12-15 15:50:11.464609880 +0000
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
+++ linux/mm/memory.c	2004-12-15 16:03:21.143560432 +0000
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
+++ linux/mm/rmap.c	2004-12-15 16:36:06.772739376 +0000
@@ -461,6 +461,10 @@ void page_add_file_rmap(struct page *pag
 	BUG_ON(PageAnon(page));
 	if (!pfn_valid(page_to_pfn(page)) || PageReserved(page))
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

