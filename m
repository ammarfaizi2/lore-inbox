Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262781AbVAQMXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262781AbVAQMXg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 07:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262783AbVAQMXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 07:23:08 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:4629 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262781AbVAQMWd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 07:22:33 -0500
Date: Mon, 17 Jan 2005 12:21:51 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "man_josewanadoo.es" <man_jose@wanadoo.es>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel bug: mm/rmap.c:483
In-Reply-To: <E1CqHh7-0000uQ-93@mb05.in.mad.eresmas.com>
Message-ID: <Pine.LNX.4.44.0501171209360.4412-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Jan 2005, man_josewanadoo.es wrote:
> My name is José María García Pérez (Spain). My system is an: AMD Athlon 800 (this is not an Athlon-XP). I was trying Gentoo for the first time (I'm a newbie). The kernel 2.6.9-r1 makes a similar bug. Then I try to upgrade to kernel-2.6.10-r4. The error persist. It appears when I try to "emerge" with Gentoo. 
> 
> What is next is with the kernel-2.6.10-r4
> 
> Would you post me to say if the bug is closed or if is my system who is broken?
> kernel BUG at mm/rmap.c:483!
> invalid operand: 0000 [#1]
> Modules linked in:
> CPU:    0
> EIP:    0060:[<c0143ed9>]    Not tainted VLI
> EFLAGS: 00010296   (2.6.10-gentoo-r4)
> EIP is at page_remove_rmap+0x29/0x40

This bug has not yet been closed, I am anxious to solve it.
If you can get reproduce it as easily as it sounds you can,
you can really help us to fix it.

Let me quote what I wrote on it last week.  Below is a patch
for you to try (this one against 2.6.10, if another kernel would
suit you better let me know), to give us more debug info about it.
But first thing to try would be an (overnight?) run of memtest86.

> We still do not know; we'd very much like to know.
> 
> It would not be the fault of any userspace program
> (unless they corrupt via /dev/mem or something like that).
> 
> It may be a core kernel problem, but I've searched repeatedly and
> failed.  It may be a driver problem e.g. GregKH's incident suggested
> a problem in DRM, and Andrea has pointed to a worrying ioctl there
> (looks like it could ClearPageReserved too early): I've been halfway
> through following that up for a few weeks now.  Are you using DRM?
> (but the hallmarks in your case are different.)
> 
> It can be caused by somewhere freeing a page it no longer holds;
> but in that case we'd usually expect to see the Bad page state
> error coming from free_pages_check rather than prep_new_page,
> and to be followed by the rmap.c BUG rather than following it.
> 
> It could easily be caused by bad memory bitflipping in a page table
> (but in general, we'd expect to be hearing of swap_free errors,
> or random corruption, if that were generally the case - I think).
> Please give memtest86 a good run to rule out that possibility.
> 
> If memtest86 is satifisfied, would you mind running with the patch
> below (against 2.6.9, suitable for i386 or x86_64, but not suitable
> for the various architectures which use PG_arch_1)?  To give us more
> debug info - it's unlikely to solve the mystery on it's own, but I
> hope it might help us to look in the right direction.  And send me
> any "Bad rmap" and "Bad page state" log entries you find (but
> perhaps this was a one-off, and nothing more will appear).

Are you using DRM?  Please mail me your .config.  As I ask above,
please mail me any "Bad rmap" and "Bad page state" log entries you
get with the patch below (including the date and time on the left).

You will find me particularly slow to respond at the moment,
sorry; but I am nonetheless very keen to solve this finally.

Thanks a lot,
Hugh

--- 2.6.10/include/linux/rmap.h	2004-12-24 21:36:18.000000000 +0000
+++ linux/include/linux/rmap.h	2005-01-17 11:36:16.626371920 +0000
@@ -72,7 +72,7 @@ void __anon_vma_link(struct vm_area_stru
  */
 void page_add_anon_rmap(struct page *, struct vm_area_struct *, unsigned long);
 void page_add_file_rmap(struct page *);
-void page_remove_rmap(struct page *);
+void page_remove_rmap(struct page *, struct vm_area_struct *, unsigned long);
 
 /**
  * page_dup_rmap - duplicate pte mapping to a page
--- 2.6.10/mm/fremap.c	2004-12-24 21:36:17.000000000 +0000
+++ linux/mm/fremap.c	2005-01-17 11:36:16.679363864 +0000
@@ -37,7 +37,7 @@ static inline void zap_pte(struct mm_str
 			if (!PageReserved(page)) {
 				if (pte_dirty(pte))
 					set_page_dirty(page);
-				page_remove_rmap(page);
+				page_remove_rmap(page, vma, addr);
 				page_cache_release(page);
 				mm->rss--;
 			}
--- 2.6.10/mm/memory.c	2004-12-24 21:36:48.000000000 +0000
+++ linux/mm/memory.c	2005-01-17 11:36:16.706359760 +0000
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
--- 2.6.10/mm/rmap.c	2004-12-24 21:37:19.000000000 +0000
+++ linux/mm/rmap.c	2005-01-17 11:36:16.709359304 +0000
@@ -462,8 +462,12 @@ void page_add_anon_rmap(struct page *pag
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
@@ -475,12 +479,36 @@ void page_add_file_rmap(struct page *pag
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
@@ -596,7 +624,7 @@ static int try_to_unmap_one(struct page 
 	}
 
 	mm->rss--;
-	page_remove_rmap(page);
+	page_remove_rmap(page, vma, address);
 	page_cache_release(page);
 
 out_unmap:
@@ -693,7 +721,7 @@ static void try_to_unmap_cluster(unsigne
 		if (pte_dirty(pteval))
 			set_page_dirty(page);
 
-		page_remove_rmap(page);
+		page_remove_rmap(page, vma, address);
 		page_cache_release(page);
 		mm->rss--;
 		(*mapcount)--;

