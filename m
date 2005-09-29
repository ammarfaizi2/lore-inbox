Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbVI2SQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbVI2SQo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 14:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbVI2SQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 14:16:44 -0400
Received: from amsfep13-int.chello.nl ([213.46.243.23]:2913 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S932322AbVI2SQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 14:16:35 -0400
Message-Id: <20050929181622.780879649@twins>
References: <20050929180845.910895444@twins>
Date: Thu, 29 Sep 2005 20:08:48 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-mm@kvack.org
Subject: [PATCH 3/7] CART - an advanced page replacement policy
Content-Disposition: inline; filename=cart-cart.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The flesh of the CART implementation. Again comments in the file should be
clear.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

 include/linux/mm_inline.h  |   37 --
 include/linux/mmzone.h     |   11 
 include/linux/page-flags.h |   15 +
 include/linux/swap.h       |   20 +
 init/main.c                |    1 
 mm/Makefile                |    2 
 mm/cart.c                  |  631 +++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 682 insertions(+), 35 deletions(-)

Index: linux-2.6-git/mm/cart.c
===================================================================
--- /dev/null
+++ linux-2.6-git/mm/cart.c
@@ -0,0 +1,639 @@
+/*
+ * mm/cart.c
+ *
+ * Written by Peter Zijlstra <a.p.zijlstra@chello.nl>
+ * Released under the GPL, see the file COPYING for details.
+ *
+ * This file contains a Page Replacement Algorithm based on CART
+ * Please refer to the CART paper here -
+ *   http://www.almaden.ibm.com/cs/people/dmodha/clockfast.pdf
+ *
+ * T1 -> active_list     |T1| -> nr_active
+ * T2 -> inactive_list   |T2| -> nr_inactive
+ * filter bit -> PG_longterm
+ *
+ * The algorithm was adapted to work for linux which poses the following
+ * extra constraints:
+ *  - multiple memory zones,
+ *  - async pageout (PG_writeback),
+ *  - fault before reference.
+ *
+ * The multiple memory zones are handled by decoupling the T lists from the
+ * B lists, keeping T lists per zone while having global B lists. See
+ * mm/nonresident.c for the B list implementation. List sizes are scaled on
+ * comparison.
+ *
+ * The asynchronous pageout makes for the problem of pages that are selected
+ * for eviction but can not (yet) be freed. And since they are not evicted
+ * they could be referenced again, so we have to keep them on the resident
+ * lists. Handling this issue gives rise to the PG_writeback checks in
+ * cart_rebalance_T[12] and the cart_reinsert and cart_rotate_reclaimable
+ * functions.
+ *
+ * The paper seems to assume we insert after/on the first reference, we
+ * actually insert before the first reference. In order to give 'S' pages
+ * a chance we will not mark them 'L' on their first cycle (PG_new).
+ *
+ * Also for efficiency's sake the replace operation is batched. This to
+ * avoid holding the much contended zone->lru_lock while calling the
+ * possibly slow page_referenced().
+ *
+ *
+ * All functions that are prefixed with '__' assume that zone->lru_lock is taken.
+ */
+
+#include <linux/swap.h>
+#include <linux/mm.h>
+#include <linux/page-flags.h>
+#include <linux/mm_inline.h>
+#include <linux/rmap.h>
+#include <linux/buffer_head.h>
+#include <linux/pagevec.h>
+
+#define cart_cT ((zone)->nr_active + (zone)->nr_inactive + (zone)->free_pages)
+#define cart_cB ((zone)->present_pages)
+
+#define T2B(x) (((x) * cart_cB) / cart_cT)
+#define B2T(x) (((x) * cart_cT) / cart_cB)
+
+#define size_T1 ((zone)->nr_active)
+#define size_T2 ((zone)->nr_inactive)
+
+#define list_T1 (&(zone)->active_list)
+#define list_T2 (&(zone)->inactive_list)
+
+#define cart_p ((zone)->nr_p)
+#define cart_q ((zone)->nr_q)
+
+#define size_B1 ((zone)->nr_evicted_active)
+#define size_B2 ((zone)->nr_evicted_inactive)
+
+#define nr_Ns ((zone)->nr_shortterm)
+#define nr_Nl (size_T1 + size_T2 - nr_Ns)
+
+/* Called from init/main.c to initialize the cart parameters */
+void __init cart_init(void)
+{
+	struct zone *zone;
+	for_each_zone(zone) {
+		zone->nr_evicted_active = 0;
+		zone->nr_evicted_inactive = 0;
+		zone->nr_shortterm = 0;
+		zone->nr_p = 0;
+		zone->nr_q = 0;
+	}
+}
+
+static inline void __cart_q_inc(struct zone *zone, unsigned long dq)
+{
+	/* if (|T2| + |B2| + |T1| - ns >= c) q = min(q + 1, 2c - |T1|) */
+	/* |B2| + nl >= c */
+	if (B2T(size_B2) + nr_Nl >= cart_cT)
+		cart_q = min(cart_q + dq, 2*cart_cB - T2B(size_T1));
+}
+
+static inline void __cart_q_dec(struct zone *zone, unsigned long dq)
+{
+	/* q = max(q - 1, c - |T1|) */
+	unsigned long target = cart_cB - T2B(size_T1);
+	if (cart_q <= target)
+		cart_q = target;
+	else if (cart_q >= dq)
+		cart_q -= dq;
+	else
+		cart_q = 0;
+}
+
+/*
+ * Insert page into @zones CART and update adaptive parameters.
+ *
+ * @zone: target zone.
+ * @page: new page.
+ */
+void __cart_insert(struct zone *zone, struct page *page)
+{
+	unsigned int rflags;
+	unsigned long ratio;
+
+	/*
+	 * Note: we could give hints to the insertion process using the LRU
+	 * specific PG_flags like: PG_active, PG_longterm and PG_referenced.
+	 */
+
+	rflags = nonresident_find(page_mapping(page), page_index(page));
+
+	if (rflags & NR_found) {
+		rflags &= NR_listid;
+		if (rflags == NR_b1) {
+			if (likely(size_B1)) --size_B1;
+
+			/* p = min(p + max(1, ns/|B1|), c) */
+			ratio = (nr_Ns / (B2T(size_B1) + 1)) ?: 1UL;
+			cart_p += ratio;
+			if (unlikely(cart_p > cart_cT))
+				cart_p = cart_cT;
+
+			SetPageLongTerm(page);
+		} else if (rflags == NR_b2) {
+			if (likely(size_B2)) --size_B2;
+
+			/* p = max(p - max(1, nl/|B2|), 0) */
+			ratio = (nr_Nl / (B2T(size_B2) + 1)) ?: 1UL;
+			if (cart_p >= ratio)
+				cart_p -= ratio;
+			else
+				cart_p = 0UL;
+
+			SetPageLongTerm(page);
+			__cart_q_inc(zone, 1);
+		}
+		/* ++nr_Nl; */
+	} else {
+		ClearPageLongTerm(page);
+		++nr_Ns;
+	}
+
+	SetPageNew(page);
+	ClearPageReferenced(page);
+	SetPageActive(page);
+	list_add_tail(&page->lru, list_T1);
+	++size_T1;
+	BUG_ON(!PageLRU(page));
+}
+
+#define head_to_page(list) list_entry((list)->next, struct page, lru)
+#define tail_to_page(list) list_entry((list)->prev, struct page, lru)
+
+#ifdef ARCH_HAS_PREFETCH
+#define prefetch_next_lru_page(_page, _base, _field)			\
+	do {								\
+		if ((_page)->lru.next != _base) {			\
+			struct page *next;				\
+			\
+			next = head_to_page(&(_page->lru));		\
+			prefetch(&next->_field);			\
+		}							\
+	} while (0)
+
+#define prefetch_prev_lru_page(_page, _base, _field)			\
+	do {								\
+		if ((_page)->lru.prev != _base) {			\
+			struct page *prev;				\
+			\
+			prev = tail_to_page(&(_page->lru));		\
+			prefetch(&prev->_field);			\
+		}							\
+	} while (0)
+#else
+#define prefetch_next_lru_page(_page, _base, _field) do { } while (0)
+#define prefetch_prev_lru_page(_page, _base, _field) do { } while (0)
+#endif
+
+#ifdef ARCH_HAS_PREFETCHW
+#define prefetchw_next_lru_page(_page, _base, _field)			\
+	do {								\
+		if ((_page)->lru.next != _base) {			\
+			struct page *next;				\
+			\
+			next = head_to_page(&(_page->lru));		\
+			prefetchw(&next->_field);			\
+		}							\
+	} while (0)
+
+#define prefetchw_prev_lru_page(_page, _base, _field)			\
+	do {								\
+		if ((_page)->lru.prev != _base) {			\
+			struct page *prev;				\
+			\
+			prev = tail_to_page(&(_page->lru));		\
+			prefetchw(&prev->_field);			\
+		}							\
+	} while (0)
+#else
+#define prefetchw_next_lru_page(_page, _base, _field) do { } while (0)
+#define prefetchw_prev_lru_page(_page, _base, _field) do { } while (0)
+#endif
+
+/*
+ * Try to grab a specified number of pages of a list head.
+ * Ups the refcount on the grabbed pages.
+ *
+ * @zone: zone to take pages from.
+ * @dst: temp list to hold pages.
+ * @src: list to take pages from.
+ * @nr_dst: target number of pages to grab.
+ * @nr_scanned: counter that keeps the number of pages touched.
+ *
+ * returns how many pages were moved to @dst.
+ */
+static unsigned long cart_isolate(struct zone *zone, struct list_head *dst,
+				  struct list_head *src, unsigned long nr_dst,
+				  unsigned long *nr_scanned)
+{
+	struct page *page;
+	unsigned long nr_taken = 0, scan = 0;
+
+	spin_lock_irq(&zone->lru_lock);
+	while (scan++ < nr_dst && !list_empty(src)) {
+		page = head_to_page(src);
+		if (!get_page_testone(page)) {
+			list_move_tail(&page->lru, dst);
+			++nr_taken;
+		} else {
+			list_move_tail(&page->lru, src);
+			__put_page(page);
+		}
+	}
+	spin_unlock_irq(&zone->lru_lock);
+
+	*nr_scanned += scan;
+	return nr_taken;
+}
+
+/*
+ * Add page to a release pagevec, temp. drop zone lock to release pagevec if full.
+ *
+ * @zone: @pages zone.
+ * @page: page to be released.
+ * @pvec: pagevec to collect pages in.
+ */
+static void __cart_page_release(struct zone *zone, struct page *page,
+				struct pagevec *pvec)
+{
+	if (!pagevec_add(pvec, page)) {
+		spin_unlock_irq(&zone->lru_lock);
+		if (buffer_heads_over_limit)
+			pagevec_strip(pvec);
+		__pagevec_release(pvec);
+		spin_lock_irq(&zone->lru_lock);
+	}
+}
+
+/*
+ * Append list to head and releases pages.
+ *
+ * @zone: zone of pages.
+ * @list: temp list of pages (1 ref).
+ * @head: zone pagelist.
+ * @pvec: pagevec for release.
+ */
+static void __cart_list_splice_tail_release(struct zone *zone, struct list_head *list,
+					    struct list_head *head, struct pagevec *pvec)
+{
+	while (!list_empty(list)) {	/* head = { head, list } */
+		struct page *page = head_to_page(list);
+		list_move_tail(&page->lru, head);
+		__cart_page_release(zone, page, pvec);
+	}
+}
+
+static void __cart_list_splice_release(struct zone *zone, struct list_head *list,
+				       struct list_head *head, struct pagevec *pvec)
+{
+	while (!list_empty(list)) {	/* head = { list, head } */
+		struct page *page = tail_to_page(list);
+		list_move(&page->lru, head);
+		__cart_page_release(zone, page, pvec);
+	}
+}
+
+/*
+ * Rebalance the T2 list:
+ *  move referenced pages to T1s' tail,
+ *  take unreffed pages for reclaim.
+ *
+ * @zone: target zone.
+ * @l_t2_head: temp list of reclaimable pages (1 ref).
+ * @nr_dst: quantum of pages.
+ * @nr_scanned: counter that keeps the number of pages touched.
+ * @pvec: pagevec used to release pages.
+ * @ignore_token: ignore the swap-token when checking for page_reference().
+ *
+ * returns if we encountered more PG_writeback pages than reclaimable pages.
+ */
+static int cart_rebalance_T2(struct zone *zone, struct list_head *l_t2_head,
+			     unsigned long nr_dst, unsigned long *nr_scanned,
+			     struct pagevec *pvec, int ignore_token)
+{
+	struct page *page;
+	LIST_HEAD(l_hold);
+	LIST_HEAD(l_t1);
+	unsigned long nr, dq;
+	unsigned long nr_reclaim = 0, nr_writeback = 0;
+
+	do {
+		nr = cart_isolate(zone, &l_hold, list_T2, nr_dst, nr_scanned);
+		if (!nr)
+			break;
+
+		dq = 0;
+		while (!list_empty(&l_hold)) {
+			page = head_to_page(&l_hold);
+			prefetchw_next_lru_page(page, &l_hold, flags);
+
+			if (page_referenced(page, 0, ignore_token) ||
+			    (PageWriteback(page) && ++nr_writeback)) {
+				list_move_tail(&page->lru, &l_t1);
+				SetPageActive(page);
+				++dq;
+			} else {
+				list_move_tail(&page->lru, l_t2_head);
+				++nr_reclaim;
+			}
+		}
+
+		spin_lock_irq(&zone->lru_lock);
+		__cart_list_splice_tail_release(zone, &l_t1, list_T1, pvec);
+		size_T2 -= dq;
+		size_T1 += dq;
+		__cart_q_inc(zone, dq);
+		spin_unlock_irq(&zone->lru_lock);
+	} while (list_empty(l_t2_head) && nr_writeback < nr_reclaim);
+
+	return nr_writeback >= nr_reclaim;
+}
+
+/*
+ * Rebalance the T1 list:
+ *  move referenced pages to tail and possibly mark 'L',
+ *  move unreffed 'L' pages to tail T2,
+ *  take unreffed 'S' pages for reclaim.
+ *
+ * @zone: target zone.
+ * @l_t1_head: temp list of reclaimable pages (1 ref).
+ * @nr_dst: quantum of pages.
+ * @nr_scanned: counter that keeps the number of pages touched.
+ * @pvec: pagevec used to release pages.
+ * @ignore_token: ignore the swap-token when checking for page_reference().
+ *
+ * returns if we encountered more PG_writeback pages than reclaimable pages.
+ */
+static int cart_rebalance_T1(struct zone *zone, struct list_head *l_t1_head,
+			     unsigned long nr_dst, unsigned long *nr_scanned,
+			     struct pagevec *pvec, int ignore_token)
+{
+	struct page *page;
+	LIST_HEAD(l_hold);
+	LIST_HEAD(l_t1);
+	LIST_HEAD(l_t2);
+	unsigned long nr, dq, dsl;
+	unsigned long nr_reclaim = 0, nr_writeback = 0;
+	int new, referenced;
+
+	do {
+		nr = cart_isolate(zone, &l_hold, list_T1, nr_dst, nr_scanned);
+		if (!nr)
+			break;
+
+		dq = 0;
+		dsl = 0;
+		while (!list_empty(&l_hold)) {
+			page = head_to_page(&l_hold);
+			prefetchw_next_lru_page(page, &l_hold, flags);
+
+			referenced = page_referenced(page, 0, ignore_token);
+			new = TestClearPageNew(page);
+
+			if (referenced ||
+			    (PageWriteback(page) && ++nr_writeback)) {
+				list_move_tail(&page->lru, &l_t1);
+
+				/* ( |T1| >= min(p + 1, |B1|) ) and ( filter = 'S' ) */
+				if (referenced && !PageLongTerm(page) && !new &&
+				    (size_T1 - dq) >= min(cart_p + 1, B2T(size_B1))) {
+					SetPageLongTerm(page);
+					++dsl;
+				}
+			} else if (PageLongTerm(page)) {
+				list_move_tail(&page->lru, &l_t2);
+				ClearPageActive(page);
+				++dq;
+			} else {
+				list_move_tail(&page->lru, l_t1_head);
+				++nr_reclaim;
+			}
+		}
+
+		spin_lock_irq(&zone->lru_lock);
+		__cart_list_splice_tail_release(zone, &l_t2, list_T2, pvec);
+		__cart_list_splice_tail_release(zone, &l_t1, list_T1, pvec);
+		nr_Ns -= dsl;
+		/* nr_Nl += dsl; */
+		size_T1 -= dq;
+		size_T2 += dq;
+		__cart_q_dec(zone, dq);
+		spin_unlock_irq(&zone->lru_lock);
+	} while (list_empty(l_t1_head) && nr_writeback < nr_reclaim);
+
+	return nr_writeback >= nr_reclaim;
+}
+
+/*
+ * Try to reclaim a specified number of pages.
+ *
+ * Clears PG_lru of reclaimed pages, but does take 1 reference.
+ *
+ * @zone: target zone to reclaim pages from.
+ * @dst: temp list of reclaimable pages (1 ref).
+ * @nr_dst: target number of pages to reclaim.
+ * @nr_scanned: counter that keeps the number of pages touched.
+ * @ignore_token: ignore the swap-token when checking for page_reference().
+ *
+ * returns number of pages on @dst.
+ */
+unsigned long cart_replace(struct zone *zone, struct list_head *dst,
+			   unsigned long nr_dst, unsigned long *nr_scanned,
+			   int ignore_token)
+{
+	struct page *page;
+	LIST_HEAD(l_t1);
+	LIST_HEAD(l_t2);
+	struct pagevec pvec;
+	unsigned long nr;
+	unsigned int nonres_total;
+	int wr1 = 0, wr2 = 0;
+
+	pagevec_init(&pvec, 1);
+
+	/*
+	 * Rebalance nonresident lists to zone size
+	 */
+	nonres_total = nonresident_total();
+
+	spin_lock_irq(&zone->lru_lock);
+	size_B1 = (nonresident_count(NR_b1) * cart_cB) / nonres_total;
+	size_B2 = (nonresident_count(NR_b2) * cart_cB) / nonres_total;
+	spin_unlock_irq(&zone->lru_lock);
+
+	for (nr = 0; nr < nr_dst;) {
+		if (list_empty(&l_t2))
+			wr2 = cart_rebalance_T2(zone, &l_t2, nr_dst/2, nr_scanned,
+						&pvec, ignore_token);
+		if (list_empty(&l_t1))
+			wr1 = cart_rebalance_T1(zone, &l_t1, nr_dst/2, nr_scanned,
+						&pvec, ignore_token);
+
+		if (list_empty(&l_t1) && list_empty(&l_t2))
+			break;
+
+		spin_lock_irq(&zone->lru_lock);
+		while (!list_empty(&l_t1) &&
+		       (size_T1 > cart_p || !size_T2 || wr2) && nr < nr_dst) {
+			page = head_to_page(&l_t1);
+			prefetchw_next_lru_page(page, &l_t1, flags);
+
+			if (!TestClearPageLRU(page))
+				BUG();
+			if (PageLongTerm(page))
+				BUG();
+			--nr_Ns;
+			--size_T1;
+			++nr;
+			list_move(&page->lru, dst);
+		}
+		while (!list_empty(&l_t2) &&
+		       (size_T1 <= cart_p || wr1) && nr < nr_dst) {
+			page = head_to_page(&l_t2);
+			prefetchw_next_lru_page(page, &l_t2, flags);
+
+			if (!TestClearPageLRU(page))
+				BUG();
+			if (!PageLongTerm(page))
+				BUG();
+			/* --nr_Nl; */
+			--size_T2;
+			++nr;
+			list_move(&page->lru, dst);
+		}
+		spin_unlock_irq(&zone->lru_lock);
+
+		cond_resched();
+	}
+
+	spin_lock_irq(&zone->lru_lock);
+	__cart_list_splice_release(zone, &l_t1, list_T1, &pvec);
+	__cart_list_splice_release(zone, &l_t2, list_T2, &pvec);
+	spin_unlock_irq(&zone->lru_lock);
+	pagevec_release(&pvec);
+
+	return nr;
+}
+
+/*
+ * Re-insert pages that were elected for replacement but could not be freed,
+ * writeback has started agains them. Rotate as referenced to let the relaim
+ * path make progress.
+ *
+ * Assumes PG_lru is clear and will set for re-inserted pages.
+ * Assumes the pages have 1 reference taken and will return it.
+ *
+ * @zone: target zone for re-insertion.
+ * @list: list of left over pages.
+ */
+void cart_reinsert(struct zone *zone, struct list_head *list)
+{
+	struct pagevec pvec;
+
+	pagevec_init(&pvec, 1);
+	spin_lock_irq(&zone->lru_lock);
+	while (!list_empty(list))
+	{
+		struct page *page = tail_to_page(list);
+		prefetchw_prev_lru_page(page, list, flags);
+
+		if (TestSetPageLRU(page))
+			BUG();
+		if (!PageActive(page)) { /* T2 */
+			if (!PageLongTerm(page))
+				BUG();
+
+			SetPageActive(page);
+			list_move_tail(&page->lru, list_T1);
+			++size_T1;
+
+			__cart_q_inc(zone, 1);
+		} else { /* T1 */
+			if (!PageLongTerm(page))
+				++nr_Ns;
+			/* else ++nr_Nl; */
+
+			list_move_tail(&page->lru, list_T1);
+			++size_T1;
+
+			/* ( |T1| >= min(p + 1, |B1| ) and ( filter = 'S' ) */
+			/*
+			 * Don't modify page state; it wasn't actually referenced
+			 */
+		}
+		__cart_page_release(zone, page, &pvec);
+	}
+	spin_unlock_irq(&zone->lru_lock);
+	pagevec_release(&pvec);
+}
+
+/*
+ * Make page available for direct reclaim.
+ *
+ * @zone: page's zone.
+ * @page: page.
+ */
+void __cart_rotate_reclaimable(struct zone *zone, struct page *page)
+{
+	if (PageLongTerm(page)) {
+		if (TestClearPageActive(page)) {
+			--size_T1;
+			++size_T2;
+			__cart_q_dec(zone, 1);
+		}
+		list_move(&page->lru, list_T2);
+	} else {
+		if (!PageActive(page))
+			BUG();
+		list_move(&page->lru, list_T1);
+	}
+}
+
+/*
+ * Puts pages on the non-resident lists on swap-out
+ * XXX: lose the reliance on zone->lru_lock !!!
+ *
+ * @zone: dead pages zone.
+ * @page: dead page.
+ */
+void __cart_remember(struct zone *zone, struct page *page)
+{
+	int listid;
+	int listid_evict;
+
+	if (PageActive(page)) {
+		listid = NR_b1;
+		++size_B1;
+	} else {
+		listid = NR_b2;
+		++size_B2;
+	}
+
+	/*
+	 * Assume |B1| + |B2| == c + 1, since |B1_j| + |B2_j| := c_j.
+	 * The list_empty check is done on the Bn_j side.
+	 */
+	/* |B1| > max(0, q) */
+	if (size_B1 > cart_q)
+		listid_evict = NR_b1;
+	else
+		listid_evict = NR_b2;
+
+	listid_evict = nonresident_put(page_mapping(page),
+				       page_index(page),
+				       listid, listid_evict);
+
+	switch (listid_evict) {
+		case NR_b1:
+			if (likely(size_B1)) --size_B1;
+			break;
+
+		case NR_b2:
+			if (likely(size_B2)) --size_B2;
+			break;
+	}
+}
Index: linux-2.6-git/include/linux/mm_inline.h
===================================================================
--- linux-2.6-git.orig/include/linux/mm_inline.h
+++ linux-2.6-git/include/linux/mm_inline.h
@@ -1,40 +1,15 @@
-
-static inline void
-add_page_to_active_list(struct zone *zone, struct page *page)
-{
-	list_add(&page->lru, &zone->active_list);
-	zone->nr_active++;
-}
-
-static inline void
-add_page_to_inactive_list(struct zone *zone, struct page *page)
-{
-	list_add(&page->lru, &zone->inactive_list);
-	zone->nr_inactive++;
-}
-
-static inline void
-del_page_from_active_list(struct zone *zone, struct page *page)
-{
-	list_del(&page->lru);
-	zone->nr_active--;
-}
-
-static inline void
-del_page_from_inactive_list(struct zone *zone, struct page *page)
-{
-	list_del(&page->lru);
-	zone->nr_inactive--;
-}
-
 static inline void
 del_page_from_lru(struct zone *zone, struct page *page)
 {
 	list_del(&page->lru);
-	if (PageActive(page)) {
-		ClearPageActive(page);
+	if (TestClearPageActive(page)) {
 		zone->nr_active--;
 	} else {
 		zone->nr_inactive--;
 	}
+	if (TestClearPageLongTerm(page)) {
+		/* zone->nr_longterm--; */
+	} else {
+		zone->nr_shortterm--;
+	}
 }
Index: linux-2.6-git/include/linux/mmzone.h
===================================================================
--- linux-2.6-git.orig/include/linux/mmzone.h
+++ linux-2.6-git/include/linux/mmzone.h
@@ -143,13 +143,18 @@ struct zone {
 	ZONE_PADDING(_pad1_)
 
 	/* Fields commonly accessed by the page reclaim scanner */
-	spinlock_t		lru_lock;	
-	struct list_head	active_list;
-	struct list_head	inactive_list;
+	spinlock_t		lru_lock;
+	struct list_head	active_list;	/* The T1 list of CART */
+	struct list_head	inactive_list;  /* The T2 list of CART */
 	unsigned long		nr_scan_active;
 	unsigned long		nr_scan_inactive;
 	unsigned long		nr_active;
 	unsigned long		nr_inactive;
+	unsigned long 		nr_evicted_active;
+	unsigned long 		nr_evicted_inactive;
+	unsigned long 		nr_shortterm;	/* number of short term pages */
+	unsigned long		nr_p;		/* p from the CART paper */
+	unsigned long 		nr_q;		/* q from the cart paper */
 	unsigned long		pages_scanned;	   /* since last reclaim */
 	int			all_unreclaimable; /* All pages pinned */
 
Index: linux-2.6-git/include/linux/page-flags.h
===================================================================
--- linux-2.6-git.orig/include/linux/page-flags.h
+++ linux-2.6-git/include/linux/page-flags.h
@@ -76,6 +76,9 @@
 #define PG_nosave_free		18	/* Free, should not be written */
 #define PG_uncached		19	/* Page has been mapped as uncached */
 
+#define PG_longterm		20	/* Filter bit for CART see mm/cart.c */
+#define PG_new			21	/* New page, skip first reference */
+
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
  * allowed.
@@ -305,6 +308,18 @@ extern void __mod_page_state(unsigned lo
 #define SetPageUncached(page)	set_bit(PG_uncached, &(page)->flags)
 #define ClearPageUncached(page)	clear_bit(PG_uncached, &(page)->flags)
 
+#define PageLongTerm(page)	test_bit(PG_longterm, &(page)->flags)
+#define SetPageLongTerm(page)	set_bit(PG_longterm, &(page)->flags)
+#define TestSetPageLongTerm(page) test_and_set_bit(PG_longterm, &(page)->flags)
+#define ClearPageLongTerm(page)	clear_bit(PG_longterm, &(page)->flags)
+#define TestClearPageLongTerm(page) test_and_clear_bit(PG_longterm, &(page)->flags)
+
+#define PageNew(page)	test_bit(PG_new, &(page)->flags)
+#define SetPageNew(page)	set_bit(PG_new, &(page)->flags)
+#define TestSetPageNew(page) test_and_set_bit(PG_new, &(page)->flags)
+#define ClearPageNew(page)	clear_bit(PG_new, &(page)->flags)
+#define TestClearPageNew(page) test_and_clear_bit(PG_new, &(page)->flags)
+
 struct page;	/* forward declaration */
 
 int test_clear_page_dirty(struct page *page);
Index: linux-2.6-git/include/linux/swap.h
===================================================================
--- linux-2.6-git.orig/include/linux/swap.h
+++ linux-2.6-git/include/linux/swap.h
@@ -7,6 +7,7 @@
 #include <linux/mmzone.h>
 #include <linux/list.h>
 #include <linux/sched.h>
+#include <linux/mm.h>
 
 #include <asm/atomic.h>
 #include <asm/page.h>
@@ -170,6 +171,16 @@ extern unsigned int nonresident_count(in
 extern unsigned int nonresident_total(void);
 extern void nonresident_init(void);
 
+/* linux/mm/cart.c */
+extern void cart_init(void);
+extern void __cart_insert(struct zone *, struct page *);
+extern unsigned long cart_replace(struct zone *, struct list_head *,
+				  unsigned long, unsigned long *,
+				  int);
+extern void cart_reinsert(struct zone *, struct list_head *);
+extern void __cart_rotate_reclaimable(struct zone *, struct page *);
+extern void __cart_remember(struct zone *, struct page*);
+
 /* linux/mm/page_alloc.c */
 extern unsigned long totalram_pages;
 extern unsigned long totalhigh_pages;
Index: linux-2.6-git/init/main.c
===================================================================
--- linux-2.6-git.orig/init/main.c
+++ linux-2.6-git/init/main.c
@@ -497,6 +497,7 @@ asmlinkage void __init start_kernel(void
 	vfs_caches_init_early();
 	nonresident_init();
 	mem_init();
+	cart_init();
 	kmem_cache_init();
 	setup_per_cpu_pageset();
 	numa_policy_init();
Index: linux-2.6-git/mm/Makefile
===================================================================
--- linux-2.6-git.orig/mm/Makefile
+++ linux-2.6-git/mm/Makefile
@@ -13,7 +13,7 @@ obj-y			:= bootmem.o filemap.o mempool.o
 			   prio_tree.o $(mmu-y)
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o \
-				nonresident.o
+				nonresident.o cart.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
 obj-$(CONFIG_NUMA) 	+= mempolicy.o
 obj-$(CONFIG_SPARSEMEM)	+= sparse.o

--
