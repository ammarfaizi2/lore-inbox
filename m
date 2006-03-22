Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932870AbWCVWcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932870AbWCVWcV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932869AbWCVWcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:32:21 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:57974 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S932865AbWCVWcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:32:12 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Bob Picco <bob.picco@hp.com>, Andrew Morton <akpm@osdl.org>,
       IWAMOTO Toshihiro <iwamoto@valinux.co.jp>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20060322223138.12658.20496.sendpatchset@twins.localnet>
In-Reply-To: <20060322223107.12658.14997.sendpatchset@twins.localnet>
References: <20060322223107.12658.14997.sendpatchset@twins.localnet>
Subject: [PATCH 03/34] mm: page-replace-insert.patch
Date: Wed, 22 Mar 2006 23:32:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

Abstract the insertion of pages into the page cache.

API:

give a hint to the page replace algorithm as to the 
importance of the given page.

	void page_replace_hint_active(struct page *);

insert the given page in a per cpu pagevec

	void fastcall page_replace_add(struct page *);

flush either the current or given cpu's pagevec.

	void page_replace_add_drain(void);
	void __page_replace_add_drain(unsigned int);

functions to insert a pagevec worth of pages

	void __pagevec_page_replace_add(struct pagevec *);
	void pagevec_page_replace_add(struct pagevec *);


Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

---

 fs/cifs/file.c                     |    4 -
 fs/exec.c                          |    4 -
 fs/mpage.c                         |    5 -
 fs/ntfs/file.c                     |    4 -
 fs/ramfs/file-nommu.c              |    2 
 include/linux/mm_page_replace.h    |   36 +++++++++
 include/linux/mm_use_once_policy.h |   12 +++
 include/linux/pagevec.h            |    8 --
 include/linux/swap.h               |    4 -
 mm/filemap.c                       |    7 +
 mm/memory.c                        |   14 ++-
 mm/mempolicy.c                     |    3 
 mm/mmap.c                          |    5 -
 mm/readahead.c                     |    9 +-
 mm/shmem.c                         |    2 
 mm/swap.c                          |  134 -------------------------------------
 mm/swap_state.c                    |    6 +
 mm/useonce.c                       |  134 +++++++++++++++++++++++++++++++++++++
 mm/vmscan.c                        |   16 +---
 19 files changed, 229 insertions(+), 180 deletions(-)

Index: linux-2.6-git/include/linux/mm_use_once_policy.h
===================================================================
--- /dev/null
+++ linux-2.6-git/include/linux/mm_use_once_policy.h
@@ -0,0 +1,12 @@
+#ifndef _LINUX_MM_USEONCE_POLICY_H
+#define _LINUX_MM_USEONCE_POLICY_H
+
+#ifdef __KERNEL__
+
+static inline void page_replace_hint_active(struct page *page)
+{
+	SetPageActive(page);
+}
+
+#endif /* __KERNEL__ */
+#endif /* _LINUX_MM_USEONCE_POLICY_H */
Index: linux-2.6-git/include/linux/mm_page_replace.h
===================================================================
--- /dev/null
+++ linux-2.6-git/include/linux/mm_page_replace.h
@@ -0,0 +1,36 @@
+#ifndef _LINUX_MM_PAGE_REPLACE_H
+#define _LINUX_MM_PAGE_REPLACE_H
+
+#ifdef __KERNEL__
+
+#include <linux/mmzone.h>
+#include <linux/mm.h>
+#include <linux/pagevec.h>
+
+/* void page_replace_hint_active(struct page *); */
+extern void fastcall page_replace_add(struct page *);
+/* void page_replace_add_drain(void); */
+extern void __page_replace_add_drain(unsigned int);
+extern int page_replace_add_drain_all(void);
+extern void __pagevec_page_replace_add(struct pagevec *);
+
+#ifdef CONFIG_MM_POLICY_USEONCE
+#include <linux/mm_use_once_policy.h>
+#else
+#error no mm policy
+#endif
+
+static inline void pagevec_page_replace_add(struct pagevec *pvec)
+{
+	if (pagevec_count(pvec))
+		__pagevec_page_replace_add(pvec);
+}
+
+static inline void page_replace_add_drain(void)
+{
+	__page_replace_add_drain(get_cpu());
+	put_cpu();
+}
+
+#endif /* __KERNEL__ */
+#endif /* _LINUX_MM_PAGE_REPLACE_H */
Index: linux-2.6-git/mm/filemap.c
===================================================================
--- linux-2.6-git.orig/mm/filemap.c
+++ linux-2.6-git/mm/filemap.c
@@ -29,6 +29,7 @@
 #include <linux/blkdev.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
+#include <linux/mm_page_replace.h>
 #include "filemap.h"
 /*
  * FIXME: remove all knowledge of the buffer layer from the core VM
@@ -421,7 +422,7 @@ int add_to_page_cache_lru(struct page *p
 {
 	int ret = add_to_page_cache(page, mapping, offset, gfp_mask);
 	if (ret == 0)
-		lru_cache_add(page);
+		page_replace_add(page);
 	return ret;
 }
 
@@ -1721,7 +1722,7 @@ repeat:
 			page = *cached_page;
 			page_cache_get(page);
 			if (!pagevec_add(lru_pvec, page))
-				__pagevec_lru_add(lru_pvec);
+				__pagevec_page_replace_add(lru_pvec);
 			*cached_page = NULL;
 		}
 	}
@@ -2051,7 +2052,7 @@ generic_file_buffered_write(struct kiocb
 	if (unlikely(file->f_flags & O_DIRECT) && written)
 		status = filemap_write_and_wait(mapping);
 
-	pagevec_lru_add(&lru_pvec);
+	pagevec_page_replace_add(&lru_pvec);
 	return written ? written : status;
 }
 EXPORT_SYMBOL(generic_file_buffered_write);
Index: linux-2.6-git/mm/useonce.c
===================================================================
--- linux-2.6-git.orig/mm/useonce.c
+++ linux-2.6-git/mm/useonce.c
@@ -1,3 +1,137 @@
+#include <linux/mm_page_replace.h>
+#include <linux/mm_inline.h>
+#include <linux/swap.h>
+#include <linux/module.h>
+#include <linux/pagemap.h>
 
+/**
+ * lru_cache_add: add a page to the page lists
+ * @page: the page to add
+ */
+static DEFINE_PER_CPU(struct pagevec, lru_add_pvecs) = { 0, };
+static DEFINE_PER_CPU(struct pagevec, lru_add_active_pvecs) = { 0, };
 
+/*
+ * Add the passed pages to the LRU, then drop the caller's refcount
+ * on them.  Reinitialises the caller's pagevec.
+ */
+void __pagevec_page_replace_add(struct pagevec *pvec)
+{
+	int i;
+	struct zone *zone = NULL;
 
+	for (i = 0; i < pagevec_count(pvec); i++) {
+		struct page *page = pvec->pages[i];
+		struct zone *pagezone = page_zone(page);
+
+		if (pagezone != zone) {
+			if (zone)
+				spin_unlock_irq(&zone->lru_lock);
+			zone = pagezone;
+			spin_lock_irq(&zone->lru_lock);
+		}
+		if (TestSetPageLRU(page))
+			BUG();
+		add_page_to_inactive_list(zone, page);
+	}
+	if (zone)
+		spin_unlock_irq(&zone->lru_lock);
+	release_pages(pvec->pages, pvec->nr, pvec->cold);
+	pagevec_reinit(pvec);
+}
+
+EXPORT_SYMBOL(__pagevec_page_replace_add);
+
+static void __pagevec_lru_add_active(struct pagevec *pvec)
+{
+	int i;
+	struct zone *zone = NULL;
+
+	for (i = 0; i < pagevec_count(pvec); i++) {
+		struct page *page = pvec->pages[i];
+		struct zone *pagezone = page_zone(page);
+
+		if (pagezone != zone) {
+			if (zone)
+				spin_unlock_irq(&zone->lru_lock);
+			zone = pagezone;
+			spin_lock_irq(&zone->lru_lock);
+		}
+		if (TestSetPageLRU(page))
+			BUG();
+		if (TestSetPageActive(page))
+			BUG();
+		add_page_to_active_list(zone, page);
+	}
+	if (zone)
+		spin_unlock_irq(&zone->lru_lock);
+	release_pages(pvec->pages, pvec->nr, pvec->cold);
+	pagevec_reinit(pvec);
+}
+
+static inline void lru_cache_add(struct page *page)
+{
+	struct pagevec *pvec = &get_cpu_var(lru_add_pvecs);
+
+	page_cache_get(page);
+	if (!pagevec_add(pvec, page))
+		__pagevec_page_replace_add(pvec);
+	put_cpu_var(lru_add_pvecs);
+}
+
+static inline void lru_cache_add_active(struct page *page)
+{
+	struct pagevec *pvec = &get_cpu_var(lru_add_active_pvecs);
+
+	page_cache_get(page);
+	if (!pagevec_add(pvec, page))
+		__pagevec_lru_add_active(pvec);
+	put_cpu_var(lru_add_active_pvecs);
+}
+
+void fastcall page_replace_add(struct page *page)
+{
+	if (PageActive(page)) {
+		ClearPageActive(page);
+		lru_cache_add_active(page);
+	} else {
+		lru_cache_add(page);
+	}
+}
+
+void __page_replace_add_drain(unsigned int cpu)
+{
+	struct pagevec *pvec = &per_cpu(lru_add_pvecs, cpu);
+
+	if (pagevec_count(pvec))
+		__pagevec_page_replace_add(pvec);
+	pvec = &per_cpu(lru_add_active_pvecs, cpu);
+	if (pagevec_count(pvec))
+		__pagevec_lru_add_active(pvec);
+}
+
+#ifdef CONFIG_NUMA
+static void drain_per_cpu(void *dummy)
+{
+	page_replace_add_drain();
+}
+
+/*
+ * Returns 0 for success
+ */
+int page_replace_add_drain_all(void)
+{
+	return schedule_on_each_cpu(drain_per_cpu, NULL);
+}
+
+#else
+
+/*
+ * Returns 0 for success
+ */
+int page_replace_add_drain_all(void)
+{
+	page_replace_add_drain();
+	return 0;
+}
+#endif
Index: linux-2.6-git/mm/memory.c
===================================================================
--- linux-2.6-git.orig/mm/memory.c
+++ linux-2.6-git/mm/memory.c
@@ -48,6 +48,7 @@
 #include <linux/rmap.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/mm_page_replace.h>
 
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -872,7 +873,7 @@ unsigned long zap_page_range(struct vm_a
 	unsigned long end = address + size;
 	unsigned long nr_accounted = 0;
 
-	lru_add_drain();
+	page_replace_add_drain();
 	tlb = tlb_gather_mmu(mm, 0);
 	update_hiwater_rss(mm);
 	end = unmap_vmas(&tlb, vma, address, end, &nr_accounted, details);
@@ -1507,7 +1508,8 @@ gotten:
 		ptep_establish(vma, address, page_table, entry);
 		update_mmu_cache(vma, address, entry);
 		lazy_mmu_prot_update(entry);
-		lru_cache_add_active(new_page);
+		page_replace_hint_active(new_page);
+		page_replace_add(new_page);
 		page_add_new_anon_rmap(new_page, vma, address);
 
 		/* Free the old page.. */
@@ -1859,7 +1861,7 @@ void swapin_readahead(swp_entry_t entry,
 		}
 #endif
 	}
-	lru_add_drain();	/* Push any new pages onto the LRU now */
+	page_replace_add_drain();	/* Push any new pages onto the LRU now */
 }
 
 /*
@@ -1993,7 +1995,8 @@ static int do_anonymous_page(struct mm_s
 		if (!pte_none(*page_table))
 			goto release;
 		inc_mm_counter(mm, anon_rss);
-		lru_cache_add_active(page);
+		page_replace_hint_active(page);
+		page_replace_add(page);
 		page_add_new_anon_rmap(page, vma, address);
 	} else {
 		/* Map the ZERO_PAGE - vm_page_prot is readonly */
@@ -2124,7 +2127,8 @@ retry:
 		set_pte_at(mm, address, page_table, entry);
 		if (anon) {
 			inc_mm_counter(mm, anon_rss);
-			lru_cache_add_active(new_page);
+			page_replace_hint_active(new_page);
+			page_replace_add(new_page);
 			page_add_new_anon_rmap(new_page, vma, address);
 		} else {
 			inc_mm_counter(mm, file_rss);
Index: linux-2.6-git/mm/mmap.c
===================================================================
--- linux-2.6-git.orig/mm/mmap.c
+++ linux-2.6-git/mm/mmap.c
@@ -25,6 +25,7 @@
 #include <linux/mount.h>
 #include <linux/mempolicy.h>
 #include <linux/rmap.h>
+#include <linux/mm_page_replace.h>
 
 #include <asm/uaccess.h>
 #include <asm/cacheflush.h>
@@ -1656,7 +1657,7 @@ static void unmap_region(struct mm_struc
 	struct mmu_gather *tlb;
 	unsigned long nr_accounted = 0;
 
-	lru_add_drain();
+	page_replace_add_drain();
 	tlb = tlb_gather_mmu(mm, 0);
 	update_hiwater_rss(mm);
 	unmap_vmas(&tlb, vma, start, end, &nr_accounted, NULL);
@@ -1937,7 +1938,7 @@ void exit_mmap(struct mm_struct *mm)
 	unsigned long nr_accounted = 0;
 	unsigned long end;
 
-	lru_add_drain();
+	page_replace_add_drain();
 	flush_cache_mm(mm);
 	tlb = tlb_gather_mmu(mm, 1);
 	/* Don't update_hiwater_rss(mm) here, do_exit already did */
Index: linux-2.6-git/mm/shmem.c
===================================================================
--- linux-2.6-git.orig/mm/shmem.c
+++ linux-2.6-git/mm/shmem.c
@@ -952,7 +952,7 @@ struct page *shmem_swapin(struct shmem_i
 			break;
 		page_cache_release(page);
 	}
-	lru_add_drain();	/* Push any new pages onto the LRU now */
+	page_replace_add_drain();	/* Push any new pages onto the LRU now */
 	return shmem_swapin_async(p, entry, idx);
 }
 
Index: linux-2.6-git/mm/swap.c
===================================================================
--- linux-2.6-git.orig/mm/swap.c
+++ linux-2.6-git/mm/swap.c
@@ -30,6 +30,7 @@
 #include <linux/cpu.h>
 #include <linux/notifier.h>
 #include <linux/init.h>
+#include <linux/mm_page_replace.h>
 
 /* How many pages do we try to swap or page in/out together? */
 int page_cluster;
@@ -132,77 +133,6 @@ void fastcall mark_page_accessed(struct 
 
 EXPORT_SYMBOL(mark_page_accessed);
 
-/**
- * lru_cache_add: add a page to the page lists
- * @page: the page to add
- */
-static DEFINE_PER_CPU(struct pagevec, lru_add_pvecs) = { 0, };
-static DEFINE_PER_CPU(struct pagevec, lru_add_active_pvecs) = { 0, };
-
-void fastcall lru_cache_add(struct page *page)
-{
-	struct pagevec *pvec = &get_cpu_var(lru_add_pvecs);
-
-	page_cache_get(page);
-	if (!pagevec_add(pvec, page))
-		__pagevec_lru_add(pvec);
-	put_cpu_var(lru_add_pvecs);
-}
-
-void fastcall lru_cache_add_active(struct page *page)
-{
-	struct pagevec *pvec = &get_cpu_var(lru_add_active_pvecs);
-
-	page_cache_get(page);
-	if (!pagevec_add(pvec, page))
-		__pagevec_lru_add_active(pvec);
-	put_cpu_var(lru_add_active_pvecs);
-}
-
-static void __lru_add_drain(int cpu)
-{
-	struct pagevec *pvec = &per_cpu(lru_add_pvecs, cpu);
-
-	/* CPU is dead, so no locking needed. */
-	if (pagevec_count(pvec))
-		__pagevec_lru_add(pvec);
-	pvec = &per_cpu(lru_add_active_pvecs, cpu);
-	if (pagevec_count(pvec))
-		__pagevec_lru_add_active(pvec);
-}
-
-void lru_add_drain(void)
-{
-	__lru_add_drain(get_cpu());
-	put_cpu();
-}
-
-#ifdef CONFIG_NUMA
-static void lru_add_drain_per_cpu(void *dummy)
-{
-	lru_add_drain();
-}
-
-/*
- * Returns 0 for success
- */
-int lru_add_drain_all(void)
-{
-	return schedule_on_each_cpu(lru_add_drain_per_cpu, NULL);
-}
-
-#else
-
-/*
- * Returns 0 for success
- */
-int lru_add_drain_all(void)
-{
-	lru_add_drain();
-	return 0;
-}
-#endif
-
 /*
  * This path almost never happens for VM activity - pages are normally
  * freed via pagevecs.  But it gets used by networking.
@@ -295,7 +225,7 @@ void release_pages(struct page **pages, 
  */
 void __pagevec_release(struct pagevec *pvec)
 {
-	lru_add_drain();
+	page_replace_add_drain();
 	release_pages(pvec->pages, pagevec_count(pvec), pvec->cold);
 	pagevec_reinit(pvec);
 }
@@ -325,64 +255,6 @@ void __pagevec_release_nonlru(struct pag
 }
 
 /*
- * Add the passed pages to the LRU, then drop the caller's refcount
- * on them.  Reinitialises the caller's pagevec.
- */
-void __pagevec_lru_add(struct pagevec *pvec)
-{
-	int i;
-	struct zone *zone = NULL;
-
-	for (i = 0; i < pagevec_count(pvec); i++) {
-		struct page *page = pvec->pages[i];
-		struct zone *pagezone = page_zone(page);
-
-		if (pagezone != zone) {
-			if (zone)
-				spin_unlock_irq(&zone->lru_lock);
-			zone = pagezone;
-			spin_lock_irq(&zone->lru_lock);
-		}
-		if (TestSetPageLRU(page))
-			BUG();
-		add_page_to_inactive_list(zone, page);
-	}
-	if (zone)
-		spin_unlock_irq(&zone->lru_lock);
-	release_pages(pvec->pages, pvec->nr, pvec->cold);
-	pagevec_reinit(pvec);
-}
-
-EXPORT_SYMBOL(__pagevec_lru_add);
-
-void __pagevec_lru_add_active(struct pagevec *pvec)
-{
-	int i;
-	struct zone *zone = NULL;
-
-	for (i = 0; i < pagevec_count(pvec); i++) {
-		struct page *page = pvec->pages[i];
-		struct zone *pagezone = page_zone(page);
-
-		if (pagezone != zone) {
-			if (zone)
-				spin_unlock_irq(&zone->lru_lock);
-			zone = pagezone;
-			spin_lock_irq(&zone->lru_lock);
-		}
-		if (TestSetPageLRU(page))
-			BUG();
-		if (TestSetPageActive(page))
-			BUG();
-		add_page_to_active_list(zone, page);
-	}
-	if (zone)
-		spin_unlock_irq(&zone->lru_lock);
-	release_pages(pvec->pages, pvec->nr, pvec->cold);
-	pagevec_reinit(pvec);
-}
-
-/*
  * Try to drop buffers from the pages in a pagevec
  */
 void pagevec_strip(struct pagevec *pvec)
@@ -470,7 +342,7 @@ static int cpu_swap_callback(struct noti
 	if (action == CPU_DEAD) {
 		atomic_add(*committed, &vm_committed_space);
 		*committed = 0;
-		__lru_add_drain((long)hcpu);
+		__page_replace_add_drain((long)hcpu);
 	}
 	return NOTIFY_OK;
 }
Index: linux-2.6-git/mm/swap_state.c
===================================================================
--- linux-2.6-git.orig/mm/swap_state.c
+++ linux-2.6-git/mm/swap_state.c
@@ -15,6 +15,7 @@
 #include <linux/buffer_head.h>
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
+#include <linux/mm_page_replace.h>
 
 #include <asm/pgtable.h>
 
@@ -276,7 +277,7 @@ void free_pages_and_swap_cache(struct pa
 {
 	struct page **pagep = pages;
 
-	lru_add_drain();
+	page_replace_add_drain();
 	while (nr) {
 		int todo = min(nr, PAGEVEC_SIZE);
 		int i;
@@ -354,7 +355,8 @@ struct page *read_swap_cache_async(swp_e
 			/*
 			 * Initiate read into locked page and return.
 			 */
-			lru_cache_add_active(new_page);
+			page_replace_hint_active(new_page);
+			page_replace_add(new_page);
 			swap_readpage(NULL, new_page);
 			return new_page;
 		}
Index: linux-2.6-git/mm/vmscan.c
===================================================================
--- linux-2.6-git.orig/mm/vmscan.c
+++ linux-2.6-git/mm/vmscan.c
@@ -33,6 +33,7 @@
 #include <linux/cpuset.h>
 #include <linux/notifier.h>
 #include <linux/rwsem.h>
+#include <linux/mm_page_replace.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -587,16 +588,7 @@ keep:
 static inline void move_to_lru(struct page *page)
 {
 	list_del(&page->lru);
-	if (PageActive(page)) {
-		/*
-		 * lru_cache_add_active checks that
-		 * the PG_active bit is off.
-		 */
-		ClearPageActive(page);
-		lru_cache_add_active(page);
-	} else {
-		lru_cache_add(page);
-	}
+	page_replace_add(page);
 	put_page(page);
 }
 
@@ -1111,7 +1103,7 @@ static void shrink_cache(struct zone *zo
 
 	pagevec_init(&pvec, 1);
 
-	lru_add_drain();
+	page_replace_add_drain();
 	spin_lock_irq(&zone->lru_lock);
 	while (max_scan > 0) {
 		struct page *page;
@@ -1237,7 +1229,7 @@ refill_inactive_zone(struct zone *zone, 
 			reclaim_mapped = 1;
 	}
 
-	lru_add_drain();
+	page_replace_add_drain();
 	spin_lock_irq(&zone->lru_lock);
 	pgmoved = isolate_lru_pages(nr_pages, &zone->active_list,
 				    &l_hold, &pgscanned);
Index: linux-2.6-git/fs/cifs/file.c
===================================================================
--- linux-2.6-git.orig/fs/cifs/file.c
+++ linux-2.6-git/fs/cifs/file.c
@@ -1604,7 +1604,7 @@ static void cifs_copy_cache_pages(struct
 		SetPageUptodate(page);
 		unlock_page(page);
 		if (!pagevec_add(plru_pvec, page))
-			__pagevec_lru_add(plru_pvec);
+			__pagevec_page_replace_add(plru_pvec);
 		data += PAGE_CACHE_SIZE;
 	}
 	return;
@@ -1758,7 +1758,7 @@ static int cifs_readpages(struct file *f
 		bytes_read = 0;
 	}
 
-	pagevec_lru_add(&lru_pvec);
+	pagevec_page_replace_add(&lru_pvec);
 
 /* need to free smb_read_data buf before exit */
 	if (smb_read_data) {
Index: linux-2.6-git/fs/mpage.c
===================================================================
--- linux-2.6-git.orig/fs/mpage.c
+++ linux-2.6-git/fs/mpage.c
@@ -26,6 +26,7 @@
 #include <linux/writeback.h>
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
+#include <linux/mm_page_replace.h>
 
 /*
  * I/O completion handler for multipage BIOs.
@@ -344,12 +345,12 @@ mpage_readpages(struct address_space *ma
 					nr_pages - page_idx,
 					&last_block_in_bio, get_block);
 			if (!pagevec_add(&lru_pvec, page))
-				__pagevec_lru_add(&lru_pvec);
+				__pagevec_page_replace_add(&lru_pvec);
 		} else {
 			page_cache_release(page);
 		}
 	}
-	pagevec_lru_add(&lru_pvec);
+	pagevec_page_replace_add(&lru_pvec);
 	BUG_ON(!list_empty(pages));
 	if (bio)
 		mpage_bio_submit(READ, bio);
Index: linux-2.6-git/fs/ntfs/file.c
===================================================================
--- linux-2.6-git.orig/fs/ntfs/file.c
+++ linux-2.6-git/fs/ntfs/file.c
@@ -441,7 +441,7 @@ static inline int __ntfs_grab_cache_page
 			pages[nr] = *cached_page;
 			page_cache_get(*cached_page);
 			if (unlikely(!pagevec_add(lru_pvec, *cached_page)))
-				__pagevec_lru_add(lru_pvec);
+				__pagevec_page_replace_add(lru_pvec);
 			*cached_page = NULL;
 		}
 		index++;
@@ -2121,7 +2121,7 @@ err_out:
 						OSYNC_METADATA|OSYNC_DATA);
 		}
   	}
-	pagevec_lru_add(&lru_pvec);
+	pagevec_page_replace_add(&lru_pvec);
 	ntfs_debug("Done.  Returning %s (written 0x%lx, status %li).",
 			written ? "written" : "status", (unsigned long)written,
 			(long)status);
Index: linux-2.6-git/mm/readahead.c
===================================================================
--- linux-2.6-git.orig/mm/readahead.c
+++ linux-2.6-git/mm/readahead.c
@@ -14,6 +14,7 @@
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
+#include <linux/mm_page_replace.h>
 
 void default_unplug_io_fn(struct backing_dev_info *bdi, struct page *page)
 {
@@ -135,7 +136,7 @@ int read_cache_pages(struct address_spac
 		}
 		ret = filler(data, page);
 		if (!pagevec_add(&lru_pvec, page))
-			__pagevec_lru_add(&lru_pvec);
+			__pagevec_page_replace_add(&lru_pvec);
 		if (ret) {
 			while (!list_empty(pages)) {
 				struct page *victim;
@@ -147,7 +148,7 @@ int read_cache_pages(struct address_spac
 			break;
 		}
 	}
-	pagevec_lru_add(&lru_pvec);
+	pagevec_page_replace_add(&lru_pvec);
 	return ret;
 }
 
@@ -174,13 +175,13 @@ static int read_pages(struct address_spa
 			ret = mapping->a_ops->readpage(filp, page);
 			if (ret != AOP_TRUNCATED_PAGE) {
 				if (!pagevec_add(&lru_pvec, page))
-					__pagevec_lru_add(&lru_pvec);
+					__pagevec_page_replace_add(&lru_pvec);
 				continue;
 			} /* else fall through to release */
 		}
 		page_cache_release(page);
 	}
-	pagevec_lru_add(&lru_pvec);
+	pagevec_page_replace_add(&lru_pvec);
 	ret = 0;
 out:
 	return ret;
Index: linux-2.6-git/fs/exec.c
===================================================================
--- linux-2.6-git.orig/fs/exec.c
+++ linux-2.6-git/fs/exec.c
@@ -49,6 +49,7 @@
 #include <linux/rmap.h>
 #include <linux/acct.h>
 #include <linux/cn_proc.h>
+#include <linux/mm_page_replace.h>
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
@@ -321,7 +322,8 @@ void install_arg_page(struct vm_area_str
 		goto out;
 	}
 	inc_mm_counter(mm, anon_rss);
-	lru_cache_add_active(page);
+	page_replace_hint_active(page);
+	page_replace_add(page);
 	set_pte_at(mm, address, pte, pte_mkdirty(pte_mkwrite(mk_pte(
 					page, vma->vm_page_prot))));
 	page_add_new_anon_rmap(page, vma, address);
Index: linux-2.6-git/include/linux/pagevec.h
===================================================================
--- linux-2.6-git.orig/include/linux/pagevec.h
+++ linux-2.6-git/include/linux/pagevec.h
@@ -23,8 +23,6 @@ struct pagevec {
 void __pagevec_release(struct pagevec *pvec);
 void __pagevec_release_nonlru(struct pagevec *pvec);
 void __pagevec_free(struct pagevec *pvec);
-void __pagevec_lru_add(struct pagevec *pvec);
-void __pagevec_lru_add_active(struct pagevec *pvec);
 void pagevec_strip(struct pagevec *pvec);
 unsigned pagevec_lookup(struct pagevec *pvec, struct address_space *mapping,
 		pgoff_t start, unsigned nr_pages);
@@ -81,10 +79,4 @@ static inline void pagevec_free(struct p
 		__pagevec_free(pvec);
 }
 
-static inline void pagevec_lru_add(struct pagevec *pvec)
-{
-	if (pagevec_count(pvec))
-		__pagevec_lru_add(pvec);
-}
-
 #endif /* _LINUX_PAGEVEC_H */
Index: linux-2.6-git/include/linux/swap.h
===================================================================
--- linux-2.6-git.orig/include/linux/swap.h
+++ linux-2.6-git/include/linux/swap.h
@@ -162,13 +162,11 @@ extern unsigned int nr_free_buffer_pages
 extern unsigned int nr_free_pagecache_pages(void);
 
 /* linux/mm/swap.c */
-extern void FASTCALL(lru_cache_add(struct page *));
-extern void FASTCALL(lru_cache_add_active(struct page *));
 extern void FASTCALL(mark_page_accessed(struct page *));
-extern void lru_add_drain(void);
 extern int lru_add_drain_all(void);
 extern int rotate_reclaimable_page(struct page *page);
 extern void swap_setup(void);
+extern void release_pages(struct page **, int, int);
 
 /* linux/mm/vmscan.c */
 extern int try_to_free_pages(struct zone **, gfp_t);
Index: linux-2.6-git/fs/ramfs/file-nommu.c
===================================================================
--- linux-2.6-git.orig/fs/ramfs/file-nommu.c
+++ linux-2.6-git/fs/ramfs/file-nommu.c
@@ -109,7 +109,7 @@ static int ramfs_nommu_expand_for_mappin
 			goto add_error;
 
 		if (!pagevec_add(&lru_pvec, page))
-			__pagevec_lru_add(&lru_pvec);
+			__pagevec_page_replace_add(&lru_pvec);
 
 		unlock_page(page);
 	}
Index: linux-2.6-git/mm/mempolicy.c
===================================================================
--- linux-2.6-git.orig/mm/mempolicy.c
+++ linux-2.6-git/mm/mempolicy.c
@@ -86,6 +86,7 @@
 #include <linux/swap.h>
 #include <linux/seq_file.h>
 #include <linux/proc_fs.h>
+#include <linux/mm_page_replace.h>
 
 #include <asm/tlbflush.h>
 #include <asm/uaccess.h>
@@ -332,7 +333,7 @@ check_range(struct mm_struct *mm, unsign
 
 	/* Clear the LRU lists so pages can be isolated */
 	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
-		lru_add_drain_all();
+		page_replace_add_drain_all();
 
 	first = find_vma(mm, start);
 	if (!first)
