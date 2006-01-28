Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751446AbWA1Pr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbWA1Pr3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 10:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWA1Pr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 10:47:28 -0500
Received: from silver.veritas.com ([143.127.12.111]:37934 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751446AbWA1Pr2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 10:47:28 -0500
Date: Sat, 28 Jan 2006 15:48:04 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Ken MacFerrin <lists@macferrin.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: kernel BUG at mm/rmap.c:486 - kernel 2.6.15-r1
In-Reply-To: <43DAE307.5010306@macferrin.com>
Message-ID: <Pine.LNX.4.61.0601281537120.5929@goblin.wat.veritas.com>
References: <43DAE307.5010306@macferrin.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 28 Jan 2006 15:47:27.0747 (UTC) FILETIME=[23F64D30:01C62422]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2006, Ken MacFerrin wrote:
> I started getting hard lockups on my desktop PC with the error "kernel BUG at
> mm/rmap.c:487" starting with kernel 2.6.13 and continuing through 2.6.14.
> After switching to 2.6.15 the lockups have continued with the message "kernel
> BUG at mm/rmap.c:486".

That's progress, we're hoping to get it to vanish at line 0 eventually ;)

> The frequency and circumstance are completely random which originally had me
> suspecting bad memory but after running Memtest86+ for over 12 hours without
> error I'm at a loss.
> 
> I'm running the binary Nvidia driver so I'll understand if I can't get help
> here but in searching through the list archives it would seem I'm not alone
> and I am willing to try any patches that may help diagnose the issue.  The
> crash happens at least daily and I've seen no difference in running kernels
> with or without PREEMPT enabled.
> 
> The machine is a P4 3.00GHz with 2048MB PC3200 Unbuffered RAM on an ASUS
> motherboard with an ICH5 chipset.  XFX GF 6600GT video card, 600W power supply
> and plenty of cooling.

You raise several worthwhile points there, I needn't repeat them back to you.

Here's the 2.6.15 version of the patch I traditionally send out for this
(smaller than for earlier releases because of several advances in 2.6.15).

Please apply and let me know of all "Bad page state" and "Bad rmap"
messages you get.  Our record at nailing these problems is not good,
but the patch should at least let you go on running for much longer.

Thanks,
Hugh

--- 2.6.15/include/linux/rmap.h	2006-01-03 03:21:10.000000000 +0000
+++ linux/include/linux/rmap.h	2006-01-03 17:08:21.000000000 +0000
@@ -72,7 +72,7 @@ void __anon_vma_link(struct vm_area_stru
  */
 void page_add_anon_rmap(struct page *, struct vm_area_struct *, unsigned long);
 void page_add_file_rmap(struct page *);
-void page_remove_rmap(struct page *);
+void page_remove_rmap(struct page *, struct vm_area_struct *, unsigned long);
 
 /**
  * page_dup_rmap - duplicate pte mapping to a page
--- 2.6.15/mm/filemap_xip.c	2006-01-03 03:21:10.000000000 +0000
+++ linux/mm/filemap_xip.c	2006-01-03 17:08:21.000000000 +0000
@@ -189,7 +189,7 @@ __xip_unmap (struct address_space * mapp
 			/* Nuke the page table entry. */
 			flush_cache_page(vma, address, pte_pfn(*pte));
 			pteval = ptep_clear_flush(vma, address, pte);
-			page_remove_rmap(page);
+			page_remove_rmap(page, vma, address);
 			dec_mm_counter(mm, file_rss);
 			BUG_ON(pte_dirty(pteval));
 			pte_unmap_unlock(pte, ptl);
--- 2.6.15/mm/fremap.c	2006-01-03 03:21:10.000000000 +0000
+++ linux/mm/fremap.c	2006-01-03 17:08:21.000000000 +0000
@@ -33,7 +33,7 @@ static int zap_pte(struct mm_struct *mm,
 		if (page) {
 			if (pte_dirty(pte))
 				set_page_dirty(page);
-			page_remove_rmap(page);
+			page_remove_rmap(page, vma, addr);
 			page_cache_release(page);
 		}
 	} else {
--- 2.6.15/mm/memory.c	2006-01-03 03:21:10.000000000 +0000
+++ linux/mm/memory.c	2006-01-03 17:08:21.000000000 +0000
@@ -656,7 +656,7 @@ static unsigned long zap_pte_range(struc
 					mark_page_accessed(page);
 				file_rss--;
 			}
-			page_remove_rmap(page);
+			page_remove_rmap(page, vma, addr);
 			tlb_remove_page(tlb, page);
 			continue;
 		}
@@ -1484,7 +1484,7 @@ gotten:
 	page_table = pte_offset_map_lock(mm, pmd, address, &ptl);
 	if (likely(pte_same(*page_table, orig_pte))) {
 		if (old_page) {
-			page_remove_rmap(old_page);
+			page_remove_rmap(old_page, vma, address);
 			if (!PageAnon(old_page)) {
 				dec_mm_counter(mm, file_rss);
 				inc_mm_counter(mm, anon_rss);
--- 2.6.15/mm/rmap.c	2006-01-03 03:21:10.000000000 +0000
+++ linux/mm/rmap.c	2006-01-03 17:08:21.000000000 +0000
@@ -480,10 +480,40 @@ void page_add_file_rmap(struct page *pag
  *
  * The caller needs to hold the pte lock.
  */
-void page_remove_rmap(struct page *page)
+void page_remove_rmap(struct page *page,
+	struct vm_area_struct *vma, unsigned long address)
 {
+	struct address_space *mapping = NULL;
+	unsigned long index;
+
+	index = (address - vma->vm_start) >> PAGE_SHIFT;
+	index += vma->vm_pgoff;
+
+	if (PageAnon(page))
+		mapping = (void *) vma->anon_vma + PAGE_MAPPING_ANON;
+	else if (page->mapping)
+		mapping = vma->vm_file? vma->vm_file->f_mapping: (void *)(-1);
+
+	if (page_mapcount(page) <= 0 || page_count(page) <= 0 ||
+	    (mapping && (mapping != page->mapping || index != page->index))) {
+		pgd_t *pgd = pgd_offset(vma->vm_mm, address);
+		pud_t *pud = pud_offset(pgd, address);
+		pmd_t *pmd = pmd_offset(pud, address);
+		unsigned long ptpfn = pmd_val(*pmd) >> PAGE_SHIFT;
+
+		printk(KERN_ERR "Bad rmap: "
+			"page %p flags %lx count %d mapcount %d\n",
+			page, page->flags,
+			page_count(page), page_mapcount(page));
+		printk(KERN_ERR "  %s addr %lx ptpfn %lx vm_flags %lx\n",
+			current->comm, address, ptpfn, vma->vm_flags);
+		printk(KERN_ERR "  page mapping %p %lx vma mapping %p %lx\n",
+			page->mapping, page->index, mapping, index);
+		get_page(page);	/* corrupt, so leak rather than free it */
+		return;
+	}
+
 	if (atomic_add_negative(-1, &page->_mapcount)) {
-		BUG_ON(page_mapcount(page) < 0);
 		/*
 		 * It would be tidy to reset the PageAnon mapping here,
 		 * but that might overwrite a racing page_add_anon_rmap
@@ -562,7 +592,7 @@ static int try_to_unmap_one(struct page 
 	} else
 		dec_mm_counter(mm, file_rss);
 
-	page_remove_rmap(page);
+	page_remove_rmap(page, vma, address);
 	page_cache_release(page);
 
 out_unmap:
@@ -652,7 +682,7 @@ static void try_to_unmap_cluster(unsigne
 		if (pte_dirty(pteval))
 			set_page_dirty(page);
 
-		page_remove_rmap(page);
+		page_remove_rmap(page, vma, address);
 		page_cache_release(page);
 		dec_mm_counter(mm, file_rss);
 		(*mapcount)--;
