Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751478AbWIALKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbWIALKw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 07:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWIALKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 07:10:51 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:59988 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751486AbWIALKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 07:10:50 -0400
Date: Fri, 1 Sep 2006 13:10:46 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
Cc: akpm@osdl.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com,
       rhim@cc.gateh.edu
Subject: [patch 6/9] Guest page hinting: writable page table entries.
Message-ID: <20060901111046.GG15684@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>
From: Hubertus Franke <frankeh@watson.ibm.com>
From: Himanshu Raj <rhim@cc.gatech.edu>

[patch 6/9] Guest page hinting: writable page table entries.

The volatile state for page cache and swap cache pages requires that
the host system needs to be able to determine if a volatile page is
dirty before removing it. This excludes almost all platforms from using
the scheme. What is needed is a way to distinguish between pages that
are purely read-ony and pages that might get written to. This allows
platforms with per-pte dirty bits to use the scheme and platforms with
per-page dirty bits a small optimization.

Whenever a writable pte is created a check is added that allows to
move the page into the correct state. This needs to be done before
the writable pte is established. To avoid unnecessary state transitions
and the need for a counter, a new page flag PG_writable is added. Only
the creation of the first writable pte will do a page state change.
Even if all the writable ptes pointing to a page are removed again,
the page stays in the safe state until all read-only users of the page
have unmapped it as well. Only then is the PG_writable bit reset.

The state a page needs to have if a writable pte is present depends
on the platform. A platform with per-pte dirty bits wants to move the
page into stable state, a platform with per-page dirty bits like s390
can decide to move the page into a special state that requires the host
system to check the dirty bit before discarding a page.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 fs/exec.c                   |    6 +++--
 include/linux/page-flags.h  |    5 ++++
 include/linux/page-states.h |   25 +++++++++++++++++++++-
 mm/fremap.c                 |    1 
 mm/memory.c                 |    5 ++++
 mm/mprotect.c               |    1 
 mm/page-discard.c           |   49 +++++++++++++++++++++++++++++++++++++++++++-
 mm/page_alloc.c             |    3 +-
 mm/rmap.c                   |    1 
 9 files changed, 91 insertions(+), 5 deletions(-)

diff -urpN linux-2.6/fs/exec.c linux-2.6-patched/fs/exec.c
--- linux-2.6/fs/exec.c	2006-09-01 12:49:30.000000000 +0200
+++ linux-2.6-patched/fs/exec.c	2006-09-01 12:50:24.000000000 +0200
@@ -307,6 +307,7 @@ void install_arg_page(struct vm_area_str
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pte_t * pte;
+	pte_t pte_val;
 	spinlock_t *ptl;
 
 	if (unlikely(anon_vma_prepare(vma)))
@@ -322,8 +323,9 @@ void install_arg_page(struct vm_area_str
 	}
 	inc_mm_counter(mm, anon_rss);
 	lru_cache_add_active(page);
-	set_pte_at(mm, address, pte, pte_mkdirty(pte_mkwrite(mk_pte(
-					page, vma->vm_page_prot))));
+	pte_val = pte_mkdirty(pte_mkwrite(mk_pte(page, vma->vm_page_prot)));
+	page_check_writable(page, pte_val);
+	set_pte_at(mm, address, pte, pte_val);
 	page_add_new_anon_rmap(page, vma, address);
 	pte_unmap_unlock(pte, ptl);
 
diff -urpN linux-2.6/include/linux/page-flags.h linux-2.6-patched/include/linux/page-flags.h
--- linux-2.6/include/linux/page-flags.h	2006-09-01 12:50:23.000000000 +0200
+++ linux-2.6-patched/include/linux/page-flags.h	2006-09-01 12:50:24.000000000 +0200
@@ -107,6 +107,7 @@
 
 #define PG_state_change		21	/* HV page state is changing. */
 #define PG_discarded		22	/* HV page has been discarded. */
+#define PG_writable		23	/* HV page is mapped writable. */
 
 /*
  * Manipulation of page state flags
@@ -267,6 +268,10 @@
 #define TestSetPageDiscarded(page) \
 		test_and_set_bit(PG_discarded, &(page)->flags)
 
+#define PageWritable(page) test_bit(PG_writable, &(page)->flags)
+#define SetPageWritable(page) set_bit(PG_writable, &(page)->flags)
+#define ClearPageWritable(page) clear_bit(PG_writable, &(page)->flags)
+
 struct page;	/* forward declaration */
 
 int test_clear_page_dirty(struct page *page);
diff -urpN linux-2.6/include/linux/page-states.h linux-2.6-patched/include/linux/page-states.h
--- linux-2.6/include/linux/page-states.h	2006-09-01 12:50:23.000000000 +0200
+++ linux-2.6-patched/include/linux/page-states.h	2006-09-01 12:50:24.000000000 +0200
@@ -40,7 +40,7 @@
 #define page_host_discards()			(0)
 #define page_set_unused(_page,_order)		do { } while (0)
 #define page_set_stable(_page,_order)		do { } while (0)
-#define page_set_volatile(_page)		do { } while (0)
+#define page_set_volatile(_page,_writable)	do { } while (0)
 #define page_set_stable_if_present(_page)	(1)
 #define page_discarded(_page)			(0)
 
@@ -63,6 +63,12 @@
  *     from the LRU list and the radix tree of its mapping.
  *     page_discard uses page_unmap_all to remove all page table
  *     entries for a page.
+ * - page_check_writable:
+ *     Checks if the page states needs to be adapted because a new
+ *     writable page table entry refering to the page is established.
+ * - page_reset_writable:
+ *     Resets the page state after the last writable page table entry
+ *     refering to the page has been removed.
  */
 extern void page_unmap_all(struct page *page);
 extern void page_discard(struct page *page);
@@ -84,4 +90,21 @@ static inline void page_make_volatile(st
 		__page_make_volatile(page, offset);
 }
 
+static inline void page_check_writable(struct page *page, pte_t pte)
+{
+	extern void __page_check_writable(struct page *, pte_t);
+	if (!page_host_discards() || !pte_write(pte) ||
+	    test_bit(PG_writable, &page->flags))
+		return;
+	__page_check_writable(page, pte);
+}
+
+static inline void page_reset_writable(struct page *page)
+{
+	extern void __page_reset_writable(struct page *);
+	if (!page_host_discards() || !test_bit(PG_writable, &page->flags))
+		return;
+	__page_reset_writable(page);
+}
+
 #endif /* _LINUX_PAGE_STATES_H */
diff -urpN linux-2.6/mm/fremap.c linux-2.6-patched/mm/fremap.c
--- linux-2.6/mm/fremap.c	2006-09-01 12:49:33.000000000 +0200
+++ linux-2.6-patched/mm/fremap.c	2006-09-01 12:50:24.000000000 +0200
@@ -80,6 +80,7 @@ int install_page(struct mm_struct *mm, s
 
 	flush_icache_page(vma, page);
 	pte_val = mk_pte(page, prot);
+	page_check_writable(page, pte_val);
 	set_pte_at(mm, addr, pte, pte_val);
 	page_add_file_rmap(page);
 	update_mmu_cache(vma, addr, pte_val);
diff -urpN linux-2.6/mm/memory.c linux-2.6-patched/mm/memory.c
--- linux-2.6/mm/memory.c	2006-09-01 12:50:24.000000000 +0200
+++ linux-2.6-patched/mm/memory.c	2006-09-01 12:50:24.000000000 +0200
@@ -1558,6 +1558,7 @@ static int do_wp_page(struct mm_struct *
 		flush_cache_page(vma, address, pte_pfn(orig_pte));
 		entry = pte_mkyoung(orig_pte);
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+		page_check_writable(old_page, entry);
 		ptep_set_access_flags(vma, address, page_table, entry, 1);
 		update_mmu_cache(vma, address, entry);
 		lazy_mmu_prot_update(entry);
@@ -1607,6 +1608,7 @@ gotten:
 		flush_cache_page(vma, address, pte_pfn(orig_pte));
 		entry = mk_pte(new_page, vma->vm_page_prot);
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+		page_check_writable(new_page, entry);
 		lazy_mmu_prot_update(entry);
 		ptep_establish(vma, address, page_table, entry);
 		update_mmu_cache(vma, address, entry);
@@ -2055,6 +2057,7 @@ static int do_swap_page(struct mm_struct
 	}
 
 	flush_icache_page(vma, page);
+	page_check_writable(page, pte);
 	set_pte_at(mm, address, page_table, pte);
 	page_add_anon_rmap(page, vma, address);
 
@@ -2117,6 +2120,7 @@ static int do_anonymous_page(struct mm_s
 
 		entry = mk_pte(page, vma->vm_page_prot);
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+		page_check_writable(page, entry);
 
 		page_table = pte_offset_map_lock(mm, pmd, address, &ptl);
 		if (!pte_none(*page_table))
@@ -2268,6 +2272,7 @@ retry:
 		entry = mk_pte(new_page, vma->vm_page_prot);
 		if (write_access)
 			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+		page_check_writable(new_page, entry);
 		set_pte_at(mm, address, page_table, entry);
 		if (anon) {
 			inc_mm_counter(mm, anon_rss);
diff -urpN linux-2.6/mm/mprotect.c linux-2.6-patched/mm/mprotect.c
--- linux-2.6/mm/mprotect.c	2006-09-01 12:49:33.000000000 +0200
+++ linux-2.6-patched/mm/mprotect.c	2006-09-01 12:50:24.000000000 +0200
@@ -52,6 +52,7 @@ static void change_pte_range(struct mm_s
 			 */
 			if (dirty_accountable && pte_dirty(ptent))
 				ptent = pte_mkwrite(ptent);
+			page_check_writable(pte_page(ptent), ptent);
 			set_pte_at(mm, addr, pte, ptent);
 			lazy_mmu_prot_update(ptent);
 #ifdef CONFIG_MIGRATION
diff -urpN linux-2.6/mm/page_alloc.c linux-2.6-patched/mm/page_alloc.c
--- linux-2.6/mm/page_alloc.c	2006-09-01 12:50:23.000000000 +0200
+++ linux-2.6-patched/mm/page_alloc.c	2006-09-01 12:50:24.000000000 +0200
@@ -615,7 +615,8 @@ static int prep_new_page(struct page *pa
 
 	page->flags &= ~(1 << PG_uptodate | 1 << PG_error | 1 << PG_readahead |
 			1 << PG_referenced | 1 << PG_arch_1 |
-			1 << PG_fs_misc | 1 << PG_mappedtodisk);
+			1 << PG_fs_misc | 1 << PG_mappedtodisk |
+			1 << PG_writable );
 	set_page_private(page, 0);
 	set_page_refcounted(page);
 	kernel_map_pages(page, 1 << order, 1);
diff -urpN linux-2.6/mm/page-discard.c linux-2.6-patched/mm/page-discard.c
--- linux-2.6/mm/page-discard.c	2006-09-01 12:50:24.000000000 +0200
+++ linux-2.6-patched/mm/page-discard.c	2006-09-01 12:50:24.000000000 +0200
@@ -81,7 +81,7 @@ void __page_make_volatile(struct page *p
 	preempt_disable();
 	if (!TestSetPageStateChange(page)) {
 		if (__page_discardable(page, offset))
-			page_set_volatile(page);
+			page_set_volatile(page, PageWritable(page));
 		ClearPageStateChange(page);
 	}
 	preempt_enable();
@@ -117,6 +117,53 @@ int __page_make_stable(struct page *page
 EXPORT_SYMBOL(__page_make_stable);
 
 /**
+ * __page_check_writable() - check page state for new writable pte
+ *
+ * @page: the page the new writable pte refers to
+ * @pte: the new writable pte
+ */
+void __page_check_writable(struct page *page, pte_t pte)
+{
+	preempt_disable();
+	while (TestSetPageStateChange(page))
+		cpu_relax();
+
+	if (!PageWritable(page)) {
+		if (__page_discardable(page, 2))
+			page_set_volatile(page, 1);
+		else
+			/*
+			 * If two processes create a write mapping at the
+			 * same time __page_discardable will return
+			 * false but the page IS in volatile state.
+			 * We have to take care about the dirty bit so the
+			 * only option left is to make the page stable.
+			 */
+			page_set_stable_if_present(page);
+		SetPageWritable(page);
+	}
+	ClearPageStateChange(page);
+	preempt_enable();
+}
+EXPORT_SYMBOL(__page_check_writable);
+
+/**
+ * __page_reset_writable() - clear the PageWritable bit
+ *
+ * @page: the page
+ */
+void __page_reset_writable(struct page *page)
+{
+	preempt_disable();
+	if (!TestSetPageStateChange(page)) {
+		ClearPageWritable(page);
+		ClearPageStateChange(page);
+	}
+	preempt_enable();
+}
+EXPORT_SYMBOL(__page_reset_writable);
+
+/**
  * __page_discard() - remove a discarded page from the cache
  *
  * @page: the page
diff -urpN linux-2.6/mm/rmap.c linux-2.6-patched/mm/rmap.c
--- linux-2.6/mm/rmap.c	2006-09-01 12:50:24.000000000 +0200
+++ linux-2.6-patched/mm/rmap.c	2006-09-01 12:50:24.000000000 +0200
@@ -600,6 +600,7 @@ void page_remove_rmap(struct page *page)
 			set_page_dirty(page);
 		__dec_zone_page_state(page,
 				PageAnon(page) ? NR_ANON_PAGES : NR_FILE_MAPPED);
+		page_reset_writable(page);
 	}
 }
 
