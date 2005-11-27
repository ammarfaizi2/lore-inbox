Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751022AbVK0MvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbVK0MvJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 07:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbVK0MvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 07:51:09 -0500
Received: from silver.veritas.com ([143.127.12.111]:35341 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751022AbVK0MvI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 07:51:08 -0500
Date: Sun, 27 Nov 2005 12:51:08 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Vympel <vympel.br@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel bug
In-Reply-To: <00e101c5f228$1249d790$0301010a@home321>
Message-ID: <Pine.LNX.4.61.0511271241030.24517@goblin.wat.veritas.com>
References: <00e101c5f228$1249d790$0301010a@home321>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 27 Nov 2005 12:51:07.0497 (UTC) FILETIME=[3C07C590:01C5F351]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Nov 2005, Vympel wrote:
> Hi, I receive this error and must reboot my server,
> 
> Nov 23 15:35:09 mail kernel: kernel BUG at mm/rmap.c:487!
> Nov 23 15:35:09 mail kernel: EFLAGS: 00010286 (2.6.14-1.1637_FC4)
> Nov 23 15:35:09 mail kernel: EIP is at page_remove_rmap+0x37/0x41

I'm not very comfortable dealing with Fedora Core kernels: safer to
pursue it on their list rather than kernel.org.  But the problem,
whatever it is, is probably not specific to FC, and below is the
2.6.14 version of the debug patch I usually send out for this
(I haven't tried it on FC, but believe it will suit there).

The patch has the (generally welcome) side-effect of letting the
system run on longer, despite the errors observed.

Please let me know of any "Bad rmap" and "Bad page state" messages
you get after rebuilding and rebooting your kernel with this patch,
in case they can shed light on what the problem is in your case.

Most cases either remain unresolved, or are resolved as bad memory,
overheating etc.  Try memtest86 overnight to check your RAM.

Hugh

--- 2.6.14/arch/ia64/lib/swiotlb.c	2005-10-28 01:02:08.000000000 +0100
+++ linux/arch/ia64/lib/swiotlb.c	2005-11-05 19:32:12.000000000 +0000
@@ -449,6 +449,7 @@ swiotlb_map_single(struct device *hwdev,
 static void
 mark_clean(void *addr, size_t size)
 {
+#ifndef CONFIG_X86_64	/* Yes, arch/x86_64 builds this too */
 	unsigned long pg_addr, end;
 
 	pg_addr = PAGE_ALIGN((unsigned long) addr);
@@ -458,6 +459,7 @@ mark_clean(void *addr, size_t size)
 		set_bit(PG_arch_1, &page->flags);
 		pg_addr += PAGE_SIZE;
 	}
+#endif
 }
 
 /*
--- 2.6.14/arch/x86_64/ia32/syscall32.c	2005-10-28 01:02:08.000000000 +0100
+++ linux/arch/x86_64/ia32/syscall32.c	2005-11-05 19:32:12.000000000 +0000
@@ -25,7 +25,7 @@ static struct page *
 syscall32_nopage(struct vm_area_struct *vma, unsigned long adr, int *type)
 {
 	struct page *p = virt_to_page(adr - vma->vm_start + syscall32_page);
-	get_page(p);
+	SetPageReserved(p);
 	return p;
 }
 
--- 2.6.14/include/linux/rmap.h	2005-08-29 00:41:01.000000000 +0100
+++ linux/include/linux/rmap.h	2005-11-05 19:32:12.000000000 +0000
@@ -72,7 +72,7 @@ void __anon_vma_link(struct vm_area_stru
  */
 void page_add_anon_rmap(struct page *, struct vm_area_struct *, unsigned long);
 void page_add_file_rmap(struct page *);
-void page_remove_rmap(struct page *);
+void page_remove_rmap(struct page *, struct vm_area_struct *, unsigned long);
 
 /**
  * page_dup_rmap - duplicate pte mapping to a page
--- 2.6.14/mm/fremap.c	2005-10-28 01:02:08.000000000 +0100
+++ linux/mm/fremap.c	2005-11-05 19:32:12.000000000 +0000
@@ -37,7 +37,7 @@ static inline void zap_pte(struct mm_str
 			if (!PageReserved(page)) {
 				if (pte_dirty(pte))
 					set_page_dirty(page);
-				page_remove_rmap(page);
+				page_remove_rmap(page, vma, addr);
 				page_cache_release(page);
 				dec_mm_counter(mm, rss);
 			}
--- 2.6.14/mm/memory.c	2005-10-28 01:02:08.000000000 +0100
+++ linux/mm/memory.c	2005-11-05 19:32:12.000000000 +0000
@@ -526,6 +526,7 @@ int copy_page_range(struct mm_struct *ds
 }
 
 static void zap_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
+				struct vm_area_struct *vma,
 				unsigned long addr, unsigned long end,
 				struct zap_details *details)
 {
@@ -579,7 +580,7 @@ static void zap_pte_range(struct mmu_gat
 			else if (pte_young(ptent))
 				mark_page_accessed(page);
 			tlb->freed++;
-			page_remove_rmap(page);
+			page_remove_rmap(page, vma, addr);
 			tlb_remove_page(tlb, page);
 			continue;
 		}
@@ -597,6 +598,7 @@ static void zap_pte_range(struct mmu_gat
 }
 
 static inline void zap_pmd_range(struct mmu_gather *tlb, pud_t *pud,
+				struct vm_area_struct *vma,
 				unsigned long addr, unsigned long end,
 				struct zap_details *details)
 {
@@ -608,11 +610,12 @@ static inline void zap_pmd_range(struct 
 		next = pmd_addr_end(addr, end);
 		if (pmd_none_or_clear_bad(pmd))
 			continue;
-		zap_pte_range(tlb, pmd, addr, next, details);
+		zap_pte_range(tlb, pmd, vma, addr, next, details);
 	} while (pmd++, addr = next, addr != end);
 }
 
 static inline void zap_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
+				struct vm_area_struct *vma,
 				unsigned long addr, unsigned long end,
 				struct zap_details *details)
 {
@@ -624,7 +627,7 @@ static inline void zap_pud_range(struct 
 		next = pud_addr_end(addr, end);
 		if (pud_none_or_clear_bad(pud))
 			continue;
-		zap_pmd_range(tlb, pud, addr, next, details);
+		zap_pmd_range(tlb, pud, vma, addr, next, details);
 	} while (pud++, addr = next, addr != end);
 }
 
@@ -645,7 +648,7 @@ static void unmap_page_range(struct mmu_
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
-		zap_pud_range(tlb, pgd, addr, next, details);
+		zap_pud_range(tlb, pgd, vma, addr, next, details);
 	} while (pgd++, addr = next, addr != end);
 	tlb_end_vma(tlb, vma);
 }
@@ -1313,7 +1316,7 @@ static int do_wp_page(struct mm_struct *
 		if (PageReserved(old_page))
 			inc_mm_counter(mm, rss);
 		else
-			page_remove_rmap(old_page);
+			page_remove_rmap(old_page, vma, address);
 		flush_cache_page(vma, address, pfn);
 		break_cow(vma, new_page, address, page_table);
 		lru_cache_add_active(new_page);
--- 2.6.14/mm/rmap.c	2005-10-28 01:02:08.000000000 +0100
+++ linux/mm/rmap.c	2005-11-05 19:32:12.000000000 +0000
@@ -466,8 +466,12 @@ void page_add_anon_rmap(struct page *pag
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
@@ -479,12 +483,43 @@ void page_add_file_rmap(struct page *pag
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
@@ -560,7 +595,7 @@ static int try_to_unmap_one(struct page 
 	}
 
 	dec_mm_counter(mm, rss);
-	page_remove_rmap(page);
+	page_remove_rmap(page, vma, address);
 	page_cache_release(page);
 
 out_unmap:
@@ -661,7 +696,7 @@ static void try_to_unmap_cluster(unsigne
 		if (pte_dirty(pteval))
 			set_page_dirty(page);
 
-		page_remove_rmap(page);
+		page_remove_rmap(page, vma, address);
 		page_cache_release(page);
 		dec_mm_counter(mm, rss);
 		(*mapcount)--;
