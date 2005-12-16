Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbVLPVIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbVLPVIW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 16:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbVLPVIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 16:08:21 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:58799 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932389AbVLPVII
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 16:08:08 -0500
Date: Fri, 16 Dec 2005 22:08:09 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, frankeh@watson.ibm.com,
       rhim@cc.gatech.edu
Subject: [rfc][patch 5/6] Page host virtual assist: discarded page list.
Message-ID: <20051216210809.GF11062@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>
From: Hubertus Franke <frankeh@watson.ibm.com>
From: Himanshu Raj <rhim@cc.gatech.edu>

[rfc][patch 5/6] Page host virtual assist: discarded page list.

The implementation of the page host virtual assist on s390 has an
additional hazard that is quite difficult to resolve. The discard
fault exception calls the guest system with the absolute address
of the page that caused the fault instead of the virtual address
of the access. With the virtual address we could have used the
page table entry of the current process to safely get a reference
to the discarded page. We can get the struct page pointer from the
absolute page address but its rather hard to get to a proper page
reference. The page that caused the fault could have already been
freed and reused for a different purpose. None of the fields in
the struct page are reliable to use. 

To get around this problem discarded pages that are about to be
freed need special handling because there might be a pending
discard fault for them we haven't completed yet.
A check is added in __remove_from_page_cache that sets the
PG_discarded bit if the page has been removed by the host. That bit
is tested for each page that gets freed via free_hot_cold_page.
If it is set the page is put on a list of discarded pages.
The pages on this list are only freed after all cpus have gone
through enabled state at least once. With the requirement that
a cpu that gets a discard fault is disabled for interrupts while
handling the fault it is possible for the discard fault handler to
safely get a page reference from the struct page by using an
atomic_inc_if_not_zero operation on the reference count.

The nice thing about the discard list is that discarded pages do
not get reused immediatly. The host system needs to back discarded
guest pages again before they can be reused. So even for "nice"
platforms who deliver the virtual page address on the discard fault
get a benefit out of this patch.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 include/linux/page_hva.h |    5 +++++
 mm/filemap.c             |    4 +++-
 mm/page_alloc.c          |   26 ++++++++++++++++++++++++++
 mm/vmscan.c              |   28 ++++++++++++++++++++++++++++
 4 files changed, 62 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/include/linux/page_hva.h linux-2.6-patched/include/linux/page_hva.h
--- linux-2.6/include/linux/page_hva.h	2005-12-16 20:40:52.000000000 +0100
+++ linux-2.6-patched/include/linux/page_hva.h	2005-12-16 20:40:53.000000000 +0100
@@ -16,6 +16,9 @@
 
 #include <asm/page_hva.h>
 
+extern spinlock_t page_hva_discard_list_lock;
+extern struct list_head page_hva_discard_list;
+
 extern int page_hva_make_stable(struct page *page);
 extern void page_hva_discard_page(struct page *page);
 extern void __page_hva_discard_page(struct page *page);
@@ -54,6 +57,8 @@ static inline void page_hva_reset_write(
 #define page_hva_set_volatile(_page)		do { } while (0)
 #define page_hva_set_stable_if_resident(_page)	(1)
 
+#define page_hva_discarded(_page)		(0)
+
 #define page_hva_make_stable(_page)		(1)
 #define page_hva_make_volatile(_page,_offset)	do { } while (0)
 
diff -urpN linux-2.6/mm/filemap.c linux-2.6-patched/mm/filemap.c
--- linux-2.6/mm/filemap.c	2005-12-16 20:40:53.000000000 +0100
+++ linux-2.6-patched/mm/filemap.c	2005-12-16 20:40:53.000000000 +0100
@@ -121,7 +121,9 @@ void __remove_from_page_cache(struct pag
 	 * in the discard fault for multiple discards of a single
 	 * page. Clear the mapping now.
 	 */
-	if (unlikely(PageDiscarded(page))) {
+	if (unlikely(PageDiscarded(page) ||
+		     (page_hva_discarded(page) &&
+		      TestSetPageDiscarded(page)))) {
 		page->mapping = NULL;
 		return;
 	}
diff -urpN linux-2.6/mm/page_alloc.c linux-2.6-patched/mm/page_alloc.c
--- linux-2.6/mm/page_alloc.c	2005-12-16 20:40:52.000000000 +0100
+++ linux-2.6-patched/mm/page_alloc.c	2005-12-16 20:40:53.000000000 +0100
@@ -742,6 +742,12 @@ static void zone_statistics(struct zonel
 #endif
 }
 
+#ifdef CONFIG_PAGE_HVA
+static DEFINE_PER_CPU(struct pagevec, page_hva_discard_pvecs) = { 0, };
+DEFINE_SPINLOCK(page_hva_discard_list_lock);
+LIST_HEAD(page_hva_discard_list);
+#endif
+
 /*
  * Free a 0-order page
  */
@@ -751,6 +757,26 @@ static void fastcall free_hot_cold_page(
 	struct per_cpu_pages *pcp;
 	unsigned long flags;
 
+#ifdef CONFIG_PAGE_HVA
+	if (unlikely(PageDiscarded(page))) {
+		struct pagevec *pvec;
+		pvec = &get_cpu_var(page_hva_discard_pvecs);
+		if (!pagevec_add(pvec, page)) {
+			int i;
+			spin_lock(&page_hva_discard_list_lock);
+			for (i = 0; i < pagevec_count(pvec); i++) {
+				struct page *page = pvec->pages[i];
+				list_add_tail(&page->lru,
+					      &page_hva_discard_list);
+			}
+			spin_unlock(&page_hva_discard_list_lock);
+			pagevec_reinit(pvec);
+		}
+		put_cpu_var(page_hva_discard_pvecs);
+		return;
+	}
+#endif
+
 	arch_free_page(page, 0);
 
 	if (PageAnon(page))
diff -urpN linux-2.6/mm/vmscan.c linux-2.6-patched/mm/vmscan.c
--- linux-2.6/mm/vmscan.c	2005-12-16 20:40:50.000000000 +0100
+++ linux-2.6-patched/mm/vmscan.c	2005-12-16 20:40:53.000000000 +0100
@@ -668,6 +668,33 @@ void page_hva_discard_page(struct page *
 	unlock_page(page);
 }
 EXPORT_SYMBOL(page_hva_discard_page);
+
+static void page_hva_sync(void *info)
+{
+}
+
+void shrink_discards(struct scan_control *sc)
+{
+	struct list_head pages_to_free = LIST_HEAD_INIT(pages_to_free);
+	struct page *page, *next;
+
+	spin_lock(&page_hva_discard_list_lock);
+	list_splice_init(&page_hva_discard_list, &pages_to_free);
+	spin_unlock(&page_hva_discard_list_lock);
+
+	if (list_empty(&pages_to_free))
+		return;
+
+	smp_call_function(page_hva_sync, NULL, 0, 1);
+
+	list_for_each_entry_safe(page, next, &pages_to_free, lru) {
+		ClearPageDiscarded(page);
+		page->mapping = NULL;
+		free_cold_page(page);
+	}
+}
+#else
+#define shrink_discards(sc)	do { } while (0)
 #endif
 
 #ifdef CONFIG_MIGRATION
@@ -1300,6 +1327,7 @@ int try_to_free_pages(struct zone **zone
 		sc.swap_cluster_max = SWAP_CLUSTER_MAX;
 		if (!priority)
 			disable_swap_token();
+		shrink_discards(&sc);
 		shrink_caches(zones, &sc);
 		shrink_slab(sc.nr_scanned, gfp_mask, lru_pages);
 		if (reclaim_state) {
