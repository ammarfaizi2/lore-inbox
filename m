Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262756AbVAKOKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbVAKOKt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 09:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbVAKOKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 09:10:49 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:43566 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262756AbVAKOKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 09:10:22 -0500
Date: Tue, 11 Jan 2005 14:09:51 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Daniel Fenert <daniel@fenert.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: "kernel BUG at mm/rmap.c:474!" error on 2.6.9
In-Reply-To: <20050111095908.GA5041@fenert.net>
Message-ID: <Pine.LNX.4.44.0501111331260.2603-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2005, Daniel Fenert wrote:
> What could be the real cause of such messages? (I assume that it was not
> really apache or php fault (httpd and php shown in logs below)).

We still do not know; we'd very much like to know.

It would not be the fault of any userspace program
(unless they corrupt via /dev/mem or something like that).

It may be a core kernel problem, but I've searched repeatedly and
failed.  It may be a driver problem e.g. GregKH's incident suggested
a problem in DRM, and Andrea has pointed to a worrying ioctl there
(looks like it could ClearPageReserved too early): I've been halfway
through following that up for a few weeks now.  Are you using DRM?
(but the hallmarks in your case are different.)

It can be caused by somewhere freeing a page it no longer holds;
but in that case we'd usually expect to see the Bad page state
error coming from free_pages_check rather than prep_new_page,
and to be followed by the rmap.c BUG rather than following it.

It could easily be caused by bad memory bitflipping in a page table
(but in general, we'd expect to be hearing of swap_free errors,
or random corruption, if that were generally the case - I think).
Please give memtest86 a good run to rule out that possibility.

If memtest86 is satifisfied, would you mind running with the patch
below (against 2.6.9, suitable for i386 or x86_64, but not suitable
for the various architectures which use PG_arch_1)?  To give us more
debug info - it's unlikely to solve the mystery on it's own, but I
hope it might help us to look in the right direction.  And send me
any "Bad rmap" and "Bad page state" log entries you find (but
perhaps this was a one-off, and nothing more will appear).

Thanks,
Hugh

> Kernel 2.6.9, SATA drive on intel chipset (ICH5), processor is P4 with HT,
> 1GB of memory. Glibc 2.3.2, gcc version 3.3.4.

> Jan 11 10:00:44 sh kernel: kernel BUG at mm/rmap.c:474!
> Jan 11 10:00:44 sh kernel: EIP is at page_remove_rmap+0x3f/0x53
> Jan 11 10:00:44 sh kernel: eax: ffffffff   ebx: 00000000   ecx: c17b4580 edx: c17b4580
> Jan 11 10:00:44 sh kernel: esi: de3dd27c   edi: c17b4580   ebp: 00000020 esp: ce236e84
> Jan 11 10:01:01 sh kernel: Bad page state at prep_new_page (in process 'php', page c17b4580)
> Jan 11 10:01:01 sh kernel: flags:0x40000114 mapping:00000000 mapcount:-1 count:0

--- 2.6.9/include/linux/rmap.h	2004-10-18 22:55:54.000000000 +0100
+++ linux/include/linux/rmap.h	2005-01-11 13:16:39.000000000 +0000
@@ -71,7 +71,7 @@ void __anon_vma_link(struct vm_area_stru
  */
 void page_add_anon_rmap(struct page *, struct vm_area_struct *, unsigned long);
 void page_add_file_rmap(struct page *);
-void page_remove_rmap(struct page *);
+void page_remove_rmap(struct page *, struct vm_area_struct *, unsigned long);
 
 /**
  * page_dup_rmap - duplicate pte mapping to a page
--- 2.6.9/mm/fremap.c	2004-10-18 22:55:54.000000000 +0100
+++ linux/mm/fremap.c	2005-01-11 13:16:39.000000000 +0000
@@ -36,7 +36,7 @@ static inline void zap_pte(struct mm_str
 			if (!PageReserved(page)) {
 				if (pte_dirty(pte))
 					set_page_dirty(page);
-				page_remove_rmap(page);
+				page_remove_rmap(page, vma, addr);
 				page_cache_release(page);
 				mm->rss--;
 			}
--- 2.6.9/mm/memory.c	2004-10-18 22:56:29.000000000 +0100
+++ linux/mm/memory.c	2005-01-11 13:16:39.000000000 +0000
@@ -356,6 +356,7 @@ nomem:
 }
 
 static void zap_pte_range(struct mmu_gather *tlb,
+		struct vm_area_struct *vma,
 		pmd_t *pmd, unsigned long address,
 		unsigned long size, struct zap_details *details)
 {
@@ -419,7 +420,7 @@ static void zap_pte_range(struct mmu_gat
 			if (pte_young(pte) && !PageAnon(page))
 				mark_page_accessed(page);
 			tlb->freed++;
-			page_remove_rmap(page);
+			page_remove_rmap(page, vma, address+offset);
 			tlb_remove_page(tlb, page);
 			continue;
 		}
@@ -437,6 +438,7 @@ static void zap_pte_range(struct mmu_gat
 }
 
 static void zap_pmd_range(struct mmu_gather *tlb,
+		struct vm_area_struct *vma,
 		pgd_t * dir, unsigned long address,
 		unsigned long size, struct zap_details *details)
 {
@@ -455,7 +457,7 @@ static void zap_pmd_range(struct mmu_gat
 	if (end > ((address + PGDIR_SIZE) & PGDIR_MASK))
 		end = ((address + PGDIR_SIZE) & PGDIR_MASK);
 	do {
-		zap_pte_range(tlb, pmd, address, end - address, details);
+		zap_pte_range(tlb, vma, pmd, address, end - address, details);
 		address = (address + PMD_SIZE) & PMD_MASK; 
 		pmd++;
 	} while (address && (address < end));
@@ -471,7 +473,7 @@ static void unmap_page_range(struct mmu_
 	dir = pgd_offset(vma->vm_mm, address);
 	tlb_start_vma(tlb, vma);
 	do {
-		zap_pmd_range(tlb, dir, address, end - address, details);
+		zap_pmd_range(tlb, vma, dir, address, end - address, details);
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 	} while (address && (address < end));
@@ -1098,7 +1100,7 @@ static int do_wp_page(struct mm_struct *
 		if (PageReserved(old_page))
 			++mm->rss;
 		else
-			page_remove_rmap(old_page);
+			page_remove_rmap(old_page, vma, address);
 		break_cow(vma, new_page, address, page_table);
 		lru_cache_add_active(new_page);
 		page_add_anon_rmap(new_page, vma, address);
--- 2.6.9/mm/rmap.c	2004-10-18 22:57:03.000000000 +0100
+++ linux/mm/rmap.c	2005-01-11 13:20:28.000000000 +0000
@@ -453,8 +453,12 @@ void page_add_anon_rmap(struct page *pag
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
@@ -466,12 +470,36 @@ void page_add_file_rmap(struct page *pag
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
+	    test_bit(PG_arch_1, &page->flags)) {
+		printk("Bad rmap in %s: page %p flags %lx "
+			"count %d mapcount %d addr %lx vm_flags %lx\n",
+			current->comm, page, (unsigned long)page->flags,
+			page_count(page), page_mapcount(page), address,
+			vma->vm_flags);
+		printk("\tpage mapping %p index %lx vma mapping %p index %lx\n",
+			page->mapping, page->index, mapping, index);
+		get_page(page);
+		return;
+	}
 	if (atomic_add_negative(-1, &page->_mapcount)) {
-		BUG_ON(page_mapcount(page) < 0);
 		/*
 		 * It would be tidy to reset the PageAnon mapping here,
 		 * but that might overwrite a racing page_add_anon_rmap
@@ -581,7 +609,7 @@ static int try_to_unmap_one(struct page 
 	}
 
 	mm->rss--;
-	page_remove_rmap(page);
+	page_remove_rmap(page, vma, address);
 	page_cache_release(page);
 
 out_unmap:
@@ -678,7 +706,7 @@ static void try_to_unmap_cluster(unsigne
 		if (pte_dirty(pteval))
 			set_page_dirty(page);
 
-		page_remove_rmap(page);
+		page_remove_rmap(page, vma, address);
 		page_cache_release(page);
 		mm->rss--;
 		(*mapcount)--;

