Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262562AbVCSPEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbVCSPEQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 10:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbVCSPEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 10:04:16 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:2596 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262562AbVCSPDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 10:03:49 -0500
Date: Sat, 19 Mar 2005 15:03:05 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: hib2743 <hib2743@log1.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG at rmap:482
In-Reply-To: <1111240264.31141.13.camel@mxmail.log1.net>
Message-ID: <Pine.LNX.4.61.0503191457070.5185@goblin.wat.veritas.com>
References: <1111240264.31141.13.camel@mxmail.log1.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Mar 2005, hib2743 wrote:
>  I have seen discussion about this in recent months on the list, and
> unfortunately I am experiencing the same problem myself now on a new
> machine. I have run memtest86 for some hours and there seems to be no
> problem. The machine has 1GB DDR PC3200 RAM/AMD Athlon(tm) 64 Processor
> 3500+/ASUS A8V motherboard/120GB Seagate SATA HDD. If you have a patch
> you would like me to try I am willing to have a go, this is a new
> machine which I waiting to deploy, so there is no production data on it
> at all yet. I can reproduce the problem fairly regularly, just set the
> machine to compile something big like glibc, and I get it within an hour
> usually...

That's the first sighting I've heard of on x86_64: I've only tried the
patch on i386, but it should be good for x86_64 too.  Please do give it
a try, and report back (probably better just to me) what "Bad rmap" and
"Bad page state" messages you then find.  As a side-effect, it should
allow you to go on running (showing more messages) for longer.

Thanks,
Hugh

--- 2.6.11/include/linux/rmap.h	2004-12-24 21:36:18.000000000 +0000
+++ linux/include/linux/rmap.h	2005-02-24 20:52:17.000000000 +0000
@@ -72,7 +72,7 @@ void __anon_vma_link(struct vm_area_stru
  */
 void page_add_anon_rmap(struct page *, struct vm_area_struct *, unsigned long);
 void page_add_file_rmap(struct page *);
-void page_remove_rmap(struct page *);
+void page_remove_rmap(struct page *, struct vm_area_struct *, unsigned long);
 
 /**
  * page_dup_rmap - duplicate pte mapping to a page
--- 2.6.11/mm/fremap.c	2005-02-24 20:11:11.000000000 +0000
+++ linux/mm/fremap.c	2005-02-24 20:52:17.000000000 +0000
@@ -37,7 +37,7 @@ static inline void zap_pte(struct mm_str
 			if (!PageReserved(page)) {
 				if (pte_dirty(pte))
 					set_page_dirty(page);
-				page_remove_rmap(page);
+				page_remove_rmap(page, vma, addr);
 				page_cache_release(page);
 				mm->rss--;
 			}
--- 2.6.11/mm/memory.c	2005-02-24 20:11:11.000000000 +0000
+++ linux/mm/memory.c	2005-02-24 20:52:17.000000000 +0000
@@ -452,6 +452,7 @@ next_pgd:
 }
 
 static void zap_pte_range(struct mmu_gather *tlb,
+		struct vm_area_struct *vma,
 		pmd_t *pmd, unsigned long address,
 		unsigned long size, struct zap_details *details)
 {
@@ -517,7 +518,7 @@ static void zap_pte_range(struct mmu_gat
 			else if (pte_young(pte))
 				mark_page_accessed(page);
 			tlb->freed++;
-			page_remove_rmap(page);
+			page_remove_rmap(page, vma, address+offset);
 			tlb_remove_page(tlb, page);
 			continue;
 		}
@@ -535,6 +536,7 @@ static void zap_pte_range(struct mmu_gat
 }
 
 static void zap_pmd_range(struct mmu_gather *tlb,
+		struct vm_area_struct *vma,
 		pud_t *pud, unsigned long address,
 		unsigned long size, struct zap_details *details)
 {
@@ -553,13 +555,14 @@ static void zap_pmd_range(struct mmu_gat
 	if (end > ((address + PUD_SIZE) & PUD_MASK))
 		end = ((address + PUD_SIZE) & PUD_MASK);
 	do {
-		zap_pte_range(tlb, pmd, address, end - address, details);
+		zap_pte_range(tlb, vma, pmd, address, end - address, details);
 		address = (address + PMD_SIZE) & PMD_MASK; 
 		pmd++;
 	} while (address && (address < end));
 }
 
 static void zap_pud_range(struct mmu_gather *tlb,
+		struct vm_area_struct *vma,
 		pgd_t * pgd, unsigned long address,
 		unsigned long end, struct zap_details *details)
 {
@@ -574,7 +577,7 @@ static void zap_pud_range(struct mmu_gat
 	}
 	pud = pud_offset(pgd, address);
 	do {
-		zap_pmd_range(tlb, pud, address, end - address, details);
+		zap_pmd_range(tlb, vma, pud, address, end - address, details);
 		address = (address + PUD_SIZE) & PUD_MASK; 
 		pud++;
 	} while (address && (address < end));
@@ -595,7 +598,7 @@ static void unmap_page_range(struct mmu_
 		next = (address + PGDIR_SIZE) & PGDIR_MASK;
 		if (next <= address || next > end)
 			next = end;
-		zap_pud_range(tlb, pgd, address, next, details);
+		zap_pud_range(tlb, vma, pgd, address, next, details);
 		address = next;
 		pgd++;
 	}
@@ -1343,7 +1346,7 @@ static int do_wp_page(struct mm_struct *
 			acct_update_integrals();
 			update_mem_hiwater();
 		} else
-			page_remove_rmap(old_page);
+			page_remove_rmap(old_page, vma, address);
 		break_cow(vma, new_page, address, page_table);
 		lru_cache_add_active(new_page);
 		page_add_anon_rmap(new_page, vma, address);
--- 2.6.11/mm/page_alloc.c	2005-02-24 19:44:06.000000000 +0000
+++ linux/mm/page_alloc.c	2005-03-01 19:58:44.000000000 +0000
@@ -276,7 +276,7 @@ static inline void __free_pages_bulk (st
 
 static inline void free_pages_check(const char *function, struct page *page)
 {
-	if (	page_mapped(page) ||
+	if (	page_mapcount(page) ||
 		page->mapping != NULL ||
 		page_count(page) != 0 ||
 		(page->flags & (
@@ -404,7 +404,7 @@ void set_page_refs(struct page *page, in
  */
 static void prep_new_page(struct page *page, int order)
 {
-	if (page->mapping || page_mapped(page) ||
+	if (page->mapping || page_mapcount(page) ||
 	    (page->flags & (
 			1 << PG_private	|
 			1 << PG_locked	|
--- 2.6.11/mm/rmap.c	2005-02-24 20:11:11.000000000 +0000
+++ linux/mm/rmap.c	2005-02-24 21:33:37.000000000 +0000
@@ -461,8 +461,12 @@ void page_add_anon_rmap(struct page *pag
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
@@ -474,12 +478,43 @@ void page_add_file_rmap(struct page *pag
  *
  * Caller needs to hold the mm->page_table_lock.
  */
-void page_remove_rmap(struct page *page)
+void page_remove_rmap(struct page *page,
+	struct vm_area_struct *vma, unsigned long address)
 {
+	struct address_space *mapping = NULL;
+	unsigned long index;
+
 	BUG_ON(PageReserved(page));
 
+	index = (address - vma->vm_start) >> PAGE_SHIFT;
+	index += vma->vm_pgoff;
+
+	if (PageAnon(page))
+		mapping = (void *) vma->anon_vma + PAGE_MAPPING_ANON;
+	else if (!(vma->vm_flags & (VM_IO|VM_RESERVED)))
+		mapping = vma->vm_file? vma->vm_file->f_mapping: (void *)(-1);
+
+	if (page_mapcount(page) <= 0 || page_count(page) <= 0 ||
+	    (mapping && (mapping != page->mapping || index != page->index)) ||
+	    test_bit(PG_arch_1, &page->flags) /* was PageReserved before */) {
+		pgd_t *pgd = pgd_offset(vma->vm_mm, address);
+		pud_t *pud = pud_offset(pgd, address);
+		pmd_t *pmd = pmd_offset(pud, address);
+		unsigned long ptpfn = pmd_val(*pmd) >> PAGE_SHIFT;
+
+		printk(KERN_ERR "Bad rmap: "
+			"page %p flags %lx count %d mapcount %d\n",
+			page, (unsigned long)page->flags,
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
@@ -601,7 +636,7 @@ static int try_to_unmap_one(struct page 
 
 	mm->rss--;
 	acct_update_integrals();
-	page_remove_rmap(page);
+	page_remove_rmap(page, vma, address);
 	page_cache_release(page);
 
 out_unmap:
@@ -703,7 +738,7 @@ static void try_to_unmap_cluster(unsigne
 		if (pte_dirty(pteval))
 			set_page_dirty(page);
 
-		page_remove_rmap(page);
+		page_remove_rmap(page, vma, address);
 		page_cache_release(page);
 		acct_update_integrals();
 		mm->rss--;
