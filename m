Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbWCTNiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWCTNiz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 08:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbWCTNiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 08:38:54 -0500
Received: from uproxy.gmail.com ([66.249.92.206]:31624 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964788AbWCTNiV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 08:38:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=q3CyCfJJw+Tp4ewZBWDj8VKFyEWmV4qyUYCoaveSKJd2FYrWV+HbcFkmEmmQJ77zembpKCg73XVFI03TJoESZ8242iQoCcoZKTkIxMzeVeNsGRpnWQ7nfMXIXIWAr4ICqU0KVu6mo59CV+VJqGkH2fU2Vh2weI5gq/hncUvrFu8=
Message-ID: <bc56f2f0603200538s6ab7fb8h@mail.gmail.com>
Date: Mon, 20 Mar 2006 08:38:19 -0500
From: "Stone Wang" <pwstone@gmail.com>
To: akpm@osdl.org
Subject: [PATCH][7/8] mm: rmap add/remove interface change
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Modify rmap add/remove interface to support passing structure vm_area_struct,
for this structure contains necessary info(vma->vm_wire_change),
so not to wire the same page twice (make_pages_wired and page_add_*_rmap).

Signed-off-by: Shaoping Wang <pwstone@gmail.com>

--
 linux-2.6.15/include/linux/rmap.h |    4 ++--
 linux-2.6.15/mm/filemap_xip.c     |    2 +-
 linux-2.6.15/mm/fremap.c          |    6 ++++--
 linux-2.6.15/mm/memory.c          |    2 +-
 linux-2.6.15/mm/rmap.c            |   21 +++++++++++++++------
 mm/memory.c                       |   29 +++++++++++++++--------------
 6 files changed, 38 insertions(+), 26 deletions(-)

diff -urN linux-2.6.15.orig/include/linux/rmap.h
linux-2.6.15/include/linux/rmap.h
--- linux-2.6.15.orig/include/linux/rmap.h	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/include/linux/rmap.h	2006-03-06 06:30:07.000000000 -0500
@@ -71,8 +71,8 @@
  * rmap interfaces called when adding or removing pte of page
  */
 void page_add_anon_rmap(struct page *, struct vm_area_struct *, unsigned long);
-void page_add_file_rmap(struct page *);
-void page_remove_rmap(struct page *);
+void page_add_file_rmap(struct page *, struct vm_area_struct *);
+void page_remove_rmap(struct page *, struct vm_area_struct *);

 /**
  * page_dup_rmap - duplicate pte mapping to a page
diff -urN linux-2.6.15.orig/mm/filemap_xip.c linux-2.6.15/mm/filemap_xip.c
--- linux-2.6.15.orig/mm/filemap_xip.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/mm/filemap_xip.c	2006-03-06 06:30:07.000000000 -0500
@@ -189,7 +189,7 @@
 			/* Nuke the page table entry. */
 			flush_cache_page(vma, address, pte_pfn(*pte));
 			pteval = ptep_clear_flush(vma, address, pte);
-			page_remove_rmap(page);
+			page_remove_rmap(page, vma);
 			dec_mm_counter(mm, file_rss);
 			BUG_ON(pte_dirty(pteval));
 			pte_unmap_unlock(pte, ptl);
diff -urN linux-2.6.15.orig/mm/fremap.c linux-2.6.15/mm/fremap.c
--- linux-2.6.15.orig/mm/fremap.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/mm/fremap.c	2006-03-06 06:30:07.000000000 -0500
@@ -33,7 +33,7 @@
 		if (page) {
 			if (pte_dirty(pte))
 				set_page_dirty(page);
-			page_remove_rmap(page);
+			page_remove_rmap(page, vma);
 			page_cache_release(page);
 		}
 	} else {
@@ -80,7 +80,7 @@

 	flush_icache_page(vma, page);
 	set_pte_at(mm, addr, pte, mk_pte(page, prot));
-	page_add_file_rmap(page);
+	page_add_file_rmap(page, vma);
 	pte_val = *pte;
 	update_mmu_cache(vma, addr, pte_val);
 	err = 0;
@@ -203,6 +203,8 @@
 			spin_unlock(&mapping->i_mmap_lock);
 		}

+		if(vma->vm_flags & VM_LOCKED)
+			flags &= ~MAP_NONBLOCK;
 		err = vma->vm_ops->populate(vma, start, size,
 					    vma->vm_page_prot,
 					    pgoff, flags & MAP_NONBLOCK);
diff -urN linux-2.6.15.orig/mm/memory.c linux-2.6.15/mm/memory.c
--- linux-2.6.15.orig/mm/memory.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/mm/memory.c	2006-03-07 11:14:59.000000000 -0500
@@ -656,7 +656,7 @@
 					mark_page_accessed(page);
 				file_rss--;
 			}
-			page_remove_rmap(page);
+			page_remove_rmap(page, vma);
 			tlb_remove_page(tlb, page);
 			continue;
 		}

diff -urN linux-2.6.15.orig/mm/rmap.c linux-2.6.15/mm/rmap.c
--- linux-2.6.15.orig/mm/rmap.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/mm/rmap.c	2006-03-07 06:17:57.000000000 -0500
@@ -449,6 +449,8 @@
 		struct anon_vma *anon_vma = vma->anon_vma;

 		BUG_ON(!anon_vma);
+		if((vma->vm_flags & VM_LOCKED) && !vma->vm_wire_change)
+	        wire_page(page);
 		anon_vma = (void *) anon_vma + PAGE_MAPPING_ANON;
 		page->mapping = (struct address_space *) anon_vma;

@@ -465,11 +467,13 @@
  *
  * The caller needs to hold the pte lock.
  */
-void page_add_file_rmap(struct page *page)
+void page_add_file_rmap(struct page *page, struct vm_area_struct *vma)
 {
 	BUG_ON(PageAnon(page));
 	BUG_ON(!pfn_valid(page_to_pfn(page)));

+	if((vma->vm_flags & VM_LOCKED) && !vma->vm_wire_change)
+		wire_page(page);
 	if (atomic_inc_and_test(&page->_mapcount))
 		inc_page_state(nr_mapped);
 }
@@ -480,8 +484,11 @@
  *
  * The caller needs to hold the pte lock.
  */
-void page_remove_rmap(struct page *page)
+void page_remove_rmap(struct page *page, struct vm_area_struct *vma)
 {
+	if(PageWired(page) && (vma->vm_flags&VM_LOCKED))
+		unwire_page(page);
+
 	if (atomic_add_negative(-1, &page->_mapcount)) {
 		BUG_ON(page_mapcount(page) < 0);
 		/*
@@ -562,7 +569,7 @@
 	} else
 		dec_mm_counter(mm, file_rss);

-	page_remove_rmap(page);
+	page_remove_rmap(page, vma);
 	page_cache_release(page);

 out_unmap:
@@ -652,7 +659,7 @@
 		if (pte_dirty(pteval))
 			set_page_dirty(page);

-		page_remove_rmap(page);
+		page_remove_rmap(page, vma);
 		page_cache_release(page);
 		dec_mm_counter(mm, file_rss);
 		(*mapcount)--;
@@ -712,8 +719,10 @@

 	list_for_each_entry(vma, &mapping->i_mmap_nonlinear,
 						shared.vm_set.list) {
-		if (vma->vm_flags & VM_LOCKED)
-			continue;
+
+		/* If VM_LOCKED set, the page will be moved to Wired list.*/
+		if (vma->vm_flags & VM_LOCKED)
+			continue;
 		cursor = (unsigned long) vma->vm_private_data;
 		if (cursor > max_nl_cursor)
 			max_nl_cursor = cursor;
diff -urN linux-2.6.15.orig/mm/memory.c linux-2.6.15/mm/memory.c
--- linux-2.6.15.orig/mm/memory.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/mm/memory.c	2006-03-07 11:14:59.000000000 -0500
@@ -1089,7 +1120,7 @@
 		struct page *page = ZERO_PAGE(addr);
 		pte_t zero_pte = pte_wrprotect(mk_pte(page, prot));
 		page_cache_get(page);
-		page_add_file_rmap(page);
+		page_add_file_rmap(page,vma);
 		inc_mm_counter(mm, file_rss);
 		BUG_ON(!pte_none(*pte));
 		set_pte_at(mm, addr, pte, zero_pte);
@@ -1098,8 +1129,8 @@
 	return 0;
 }

-static inline int zeromap_pmd_range(struct mm_struct *mm, pud_t *pud,
-			unsigned long addr, unsigned long end, pgprot_t prot)
+static inline int zeromap_pmd_range(struct mm_struct *mm, struct
vm_area_struct *vma,
+			 pud_t *pud, unsigned long addr, unsigned long end, pgprot_t prot)
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -1109,14 +1140,14 @@
 		return -ENOMEM;
 	do {
 		next = pmd_addr_end(addr, end);
-		if (zeromap_pte_range(mm, pmd, addr, next, prot))
+		if (zeromap_pte_range(mm, vma, pmd, addr, next, prot))
 			return -ENOMEM;
 	} while (pmd++, addr = next, addr != end);
 	return 0;
 }

-static inline int zeromap_pud_range(struct mm_struct *mm, pgd_t *pgd,
-			unsigned long addr, unsigned long end, pgprot_t prot)
+static inline int zeromap_pud_range(struct mm_struct *mm, struct
vm_area_struct *vma,
+			pgd_t *pgd, unsigned long addr, unsigned long end, pgprot_t prot)
 {
 	pud_t *pud;
 	unsigned long next;
@@ -1126,7 +1157,7 @@
 		return -ENOMEM;
 	do {
 		next = pud_addr_end(addr, end);
-		if (zeromap_pmd_range(mm, pud, addr, next, prot))
+		if (zeromap_pmd_range(mm, vma, pud, addr, next, prot))
 			return -ENOMEM;
 	} while (pud++, addr = next, addr != end);
 	return 0;
@@ -1146,7 +1177,7 @@
 	flush_cache_range(vma, addr, end);
 	do {
 		next = pgd_addr_end(addr, end);
-		err = zeromap_pud_range(mm, pgd, addr, next, prot);
+		err = zeromap_pud_range(mm, vma, pgd, addr, next, prot);
 		if (err)
 			break;
 	} while (pgd++, addr = next, addr != end);
@@ -1172,7 +1203,8 @@
  * old drivers should use this, and they needed to mark their
  * pages reserved for the old functions anyway.
  */
-static int insert_page(struct mm_struct *mm, unsigned long addr,
struct page *page, pgprot_t prot)
+static int insert_page(struct mm_struct *mm, struct vm_area_struct *vma,
+			unsigned long addr, struct page *page, pgprot_t prot)
 {
 	int retval;
 	pte_t *pte;
@@ -1193,7 +1225,7 @@
 	/* Ok, finally just insert the thing.. */
 	get_page(page);
 	inc_mm_counter(mm, file_rss);
-	page_add_file_rmap(page);
+	page_add_file_rmap(page,vma);
 	set_pte_at(mm, addr, pte, mk_pte(page, prot));

 	retval = 0;
@@ -1229,7 +1261,7 @@
 	if (!page_count(page))
 		return -EINVAL;
 	vma->vm_flags |= VM_INSERTPAGE;
-	return insert_page(vma->vm_mm, addr, page, vma->vm_page_prot);
+	return insert_page(vma->vm_mm, vma, addr, page, vma->vm_page_prot);
 }
 EXPORT_SYMBOL(vm_insert_page);

@@ -1484,7 +1516,7 @@
 	page_table = pte_offset_map_lock(mm, pmd, address, &ptl);
 	if (likely(pte_same(*page_table, orig_pte))) {
 		if (old_page) {
-			page_remove_rmap(old_page);
+			page_remove_rmap(old_page, vma);
 			if (!PageAnon(old_page)) {
 				dec_mm_counter(mm, file_rss);
 				inc_mm_counter(mm, anon_rss);
@@ -1967,7 +1999,7 @@
 		if (!pte_none(*page_table))
 			goto release;
 		inc_mm_counter(mm, file_rss);
-		page_add_file_rmap(page);
+		page_add_file_rmap(page, vma);
 	}

 	set_pte_at(mm, address, page_table, entry);
@@ -2089,7 +2121,7 @@
 			page_add_anon_rmap(new_page, vma, address);
 		} else {
 			inc_mm_counter(mm, file_rss);
-			page_add_file_rmap(new_page);
+			page_add_file_rmap(new_page, vma);
 		}
 	} else {
 		/* One of our sibling threads was faster, back out. */
