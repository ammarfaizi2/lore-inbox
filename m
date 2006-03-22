Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932897AbWCVWih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932897AbWCVWih (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932906AbWCVWiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:38:05 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:16572 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S932907AbWCVWhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:37:08 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Bob Picco <bob.picco@hp.com>, Andrew Morton <akpm@osdl.org>,
       IWAMOTO Toshihiro <iwamoto@valinux.co.jp>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20060322223634.12658.27826.sendpatchset@twins.localnet>
In-Reply-To: <20060322223107.12658.14997.sendpatchset@twins.localnet>
References: <20060322223107.12658.14997.sendpatchset@twins.localnet>
Subject: [PATCH 32/34] mm: cart-cart.patch
Date: Wed, 22 Mar 2006 23:37:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

This patch contains a Page Replacement Algorithm based on CART
Please refer to the CART paper here -
  http://www.almaden.ibm.com/cs/people/dmodha/clockfast.pdf

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

---

 include/linux/mm_cart_data.h         |   31 +
 include/linux/mm_cart_policy.h       |  134 ++++++
 include/linux/mm_page_replace.h      |    6 
 include/linux/mm_page_replace_data.h |    6 
 mm/Kconfig                           |    5 
 mm/Makefile                          |    1 
 mm/cart.c                            |  678 +++++++++++++++++++++++++++++++++++
 7 files changed, 857 insertions(+), 4 deletions(-)

Index: linux-2.6-git/mm/cart.c
===================================================================
--- /dev/null
+++ linux-2.6-git/mm/cart.c
@@ -0,0 +1,678 @@
+/*
+ * mm/cart.c
+ *
+ * Written by Peter Zijlstra <a.p.zijlstra@chello.nl>
+ * Released under the GPLv2, see the file COPYING for details.
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
+ *  - fault before reference,
+ *  - expensive refernce check.
+ *
+ * The multiple memory zones are handled by decoupling the T lists from the
+ * B lists, keeping T lists per zone while having global B lists. See
+ * mm/nonresident.c for the B list implementation. List sizes are scaled on
+ * comparison.
+ *
+ * The paper seems to assume we insert after/on the first reference, we
+ * actually insert before the first reference. In order to give 'S' pages
+ * a chance we will not mark them 'L' on their first cycle (PG_new).
+ *
+ * Also for efficiency's sake the replace operation is batched. This to
+ * avoid holding the much contended zone->lru_lock while calling the
+ * possibly slow page_referenced().
+ *
+ * All functions that are prefixed with '__' assume that zone->lru_lock is taken.
+ */
+
+#include <linux/mm_page_replace.h>
+#include <linux/rmap.h>
+#include <linux/buffer_head.h>
+#include <linux/pagevec.h>
+#include <linux/bootmem.h>
+#include <linux/init.h>
+#include <linux/nonresident-cart.h>
+#include <linux/swap.h>
+#include <linux/module.h>
+#include <linux/percpu.h>
+#include <linux/writeback.h>
+
+#include <asm/div64.h>
+
+
+static DEFINE_PER_CPU(unsigned long, cart_nr_q);
+
+void __init page_replace_init(void)
+{
+	int i;
+
+	nonresident_init();
+
+	for_each_cpu(i)
+		per_cpu(cart_nr_q, i) = 0;
+}
+
+void __init page_replace_init_zone(struct zone *zone)
+{
+	INIT_LIST_HEAD(&zone->policy.list_T1);
+	INIT_LIST_HEAD(&zone->policy.list_T2);
+	zone->policy.nr_T1 = 0;
+	zone->policy.nr_T2 = 0;
+	zone->policy.nr_shortterm = 0;
+	zone->policy.nr_p = 0;
+	zone->policy.flags = 0;
+}
+
+static inline unsigned long cart_c(struct zone *zone)
+{
+	return zone->policy.nr_T1 + zone->policy.nr_T2 + zone->free_pages;
+}
+
+#define scale(x, y, z) ({ unsigned long long tmp = (x); \
+			  tmp *= (y); \
+			  do_div(tmp, (z)); \
+			  (unsigned long)tmp; })
+
+#define B2T(x) scale((x), cart_c(zone), nonresident_total())
+#define T2B(x) scale((x), nonresident_total(), cart_c(zone))
+
+static inline unsigned long cart_longterm(struct zone *zone)
+{
+	return zone->policy.nr_T1 + zone->policy.nr_T2 - zone->policy.nr_shortterm;
+}
+
+static inline unsigned long __cart_q(void)
+{
+	return __sum_cpu_var(unsigned long, cart_nr_q);
+}
+
+static void __cart_q_inc(struct zone *zone, unsigned long dq)
+{
+	/* if (|T2| + |B2| + |T1| - ns >= c) q = min(q + 1, 2c - |T1|) */
+	/*     |B2| + nl               >= c                            */
+	if (B2T(nonresident_count(NR_b2)) + cart_longterm(zone) >=
+	    cart_c(zone)) {
+		unsigned long nr_q = __cart_q();
+		unsigned long target = 2*nonresident_total() - T2B(zone->policy.nr_T1);
+
+		__get_cpu_var(cart_nr_q) += dq;
+		nr_q += dq;
+
+		if (nr_q > target) {
+			unsigned long tmp = nr_q - target;
+			__get_cpu_var(cart_nr_q) -= tmp;
+		}
+	}
+}
+
+static void __cart_q_dec(struct zone *zone, unsigned long dq)
+{
+	/* q = max(q - 1, c - |T1|) */
+	unsigned long nr_q = __cart_q();
+	unsigned long target = nonresident_total() - T2B(zone->policy.nr_T1);
+
+	if (nr_q < dq) {
+		__get_cpu_var(cart_nr_q) -= nr_q;
+		nr_q = 0;
+	} else {
+		__get_cpu_var(cart_nr_q) -= dq;
+		nr_q -= dq;
+	}
+
+	if (nr_q < target) {
+		unsigned long tmp = target - nr_q;
+		__get_cpu_var(cart_nr_q) += tmp;
+	}
+}
+
+static inline unsigned long cart_q(void)
+{
+	unsigned long q;
+	preempt_disable();
+	q = __cart_q();
+	preempt_enable();
+	return q;
+}
+
+static inline void __cart_p_inc(struct zone *zone)
+{
+	/* p = min(p + max(1, ns/|B1|), c) */
+	unsigned long ratio;
+	ratio = (zone->policy.nr_shortterm /
+		 (B2T(nonresident_count(NR_b1)) + 1)) ?: 1UL;
+	zone->policy.nr_p += ratio;
+	if (unlikely(zone->policy.nr_p > cart_c(zone)))
+		zone->policy.nr_p = cart_c(zone);
+}
+
+static inline void __cart_p_dec(struct zone *zone)
+{
+	/* p = max(p - max(1, nl/|B2|), 0) */
+	unsigned long ratio;
+	ratio = (cart_longterm(zone) /
+		 (B2T(nonresident_count(NR_b2)) + 1)) ?: 1UL;
+	if (zone->policy.nr_p >= ratio)
+		zone->policy.nr_p -= ratio;
+	else
+		zone->policy.nr_p = 0UL;
+}
+
+static unsigned long list_count(struct list_head *list, int PG_flag, int result)
+{
+	unsigned long nr = 0;
+	struct page *page;
+	list_for_each_entry(page, list, lru) {
+		if (!!test_bit(PG_flag, &(page)->flags) == result)
+			++nr;
+	}
+	return nr;
+}
+
+static void __validate_zone(struct zone *zone)
+{
+#if 0
+	int bug = 0;
+	unsigned long cnt0 = list_count(&zone->policy.list_T1, PG_lru, 0);
+	unsigned long cnt1 = list_count(&zone->policy.list_T1, PG_lru, 1);
+	if (cnt1 != zone->policy.nr_T1) {
+		printk(KERN_ERR "__validate_zone: T1: %lu,%lu,%lu\n", cnt0, cnt1, zone->policy.nr_T1);
+		bug = 1;
+	}
+
+	cnt0 = list_count(&zone->policy.list_T2, PG_lru, 0);
+	cnt1 = list_count(&zone->policy.list_T2, PG_lru, 1);
+	if (cnt1 != zone->policy.nr_T2 || bug) {
+		printk(KERN_ERR "__validate_zone: T2: %lu,%lu,%lu\n", cnt0, cnt1, zone->policy.nr_T2);
+		bug = 1;
+	}
+
+	cnt0 = list_count(&zone->policy.list_T1, PG_longterm, 0) +
+	       list_count(&zone->policy.list_T2, PG_longterm, 0);
+	cnt1 = list_count(&zone->policy.list_T1, PG_longterm, 1) +
+	       list_count(&zone->policy.list_T2, PG_longterm, 1);
+	if (cnt0 != zone->policy.nr_shortterm || bug) {
+		printk(KERN_ERR "__validate_zone: shortterm: %lu,%lu,%lu\n", cnt0, cnt1, zone->policy.nr_shortterm);
+		bug = 1;
+	}
+
+	cnt0 = list_count(&zone->policy.list_T2, PG_longterm, 0);
+	cnt1 = list_count(&zone->policy.list_T2, PG_longterm, 1);
+	if (cnt1 != zone->policy.nr_T2 || bug) {
+		printk(KERN_ERR "__validate_zone: longterm: %lu,%lu,%lu\n", cnt0, cnt1, zone->policy.nr_T2);
+		bug = 1;
+	}
+
+	if (bug) {
+		BUG();
+	}
+#endif
+}
+
+/*
+ * Insert page into @zones CART and update adaptive parameters.
+ *
+ * @zone: target zone.
+ * @page: new page.
+ */
+void __page_replace_add(struct zone *zone, struct page *page)
+{
+	unsigned int rflags;
+
+	/*
+	 * Note: we could give hints to the insertion process using the LRU
+	 * specific PG_flags like: PG_t1, PG_longterm and PG_referenced.
+	 */
+
+	rflags = nonresident_get(page_mapping(page), page_index(page));
+
+	if (rflags & NR_found) {
+		SetPageLongTerm(page);
+		rflags &= NR_listid;
+		if (rflags == NR_b1) {
+			__cart_p_inc(zone);
+		} else if (rflags == NR_b2) {
+			__cart_p_dec(zone);
+			__cart_q_inc(zone, 1);
+		}
+		/* ++cart_longterm(zone); */
+	} else {
+		ClearPageLongTerm(page);
+		++zone->policy.nr_shortterm;
+	}
+	SetPageT1(page);
+
+	list_add(&page->lru, &zone->policy.list_T1);
+
+	++zone->policy.nr_T1;
+	BUG_ON(!PageLRU(page));
+
+	__validate_zone(zone);
+}
+
+static DEFINE_PER_CPU(struct pagevec, cart_add_pvecs) = { 0, };
+
+void fastcall page_replace_add(struct page *page)
+{
+	struct pagevec *pvec = &get_cpu_var(cart_add_pvecs);
+
+	page_cache_get(page);
+	if (!pagevec_add(pvec, page))
+		__pagevec_page_replace_add(pvec);
+	put_cpu_var(cart_add_pvecs);
+}
+
+void __page_replace_add_drain(unsigned int cpu)
+{
+	struct pagevec *pvec = &per_cpu(cart_add_pvecs, cpu);
+
+	if (pagevec_count(pvec))
+		__pagevec_page_replace_add(pvec);
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
+
+#ifdef CONFIG_MIGRATION
+/*
+ * Isolate one page from the LRU lists and put it on the
+ * indicated list with elevated refcount.
+ *
+ * Result:
+ *  0 = page not on LRU list
+ *  1 = page removed from LRU list and added to the specified list.
+ */
+int page_replace_isolate(struct page *page)
+{
+	int ret = 0;
+
+	if (PageLRU(page)) {
+		struct zone *zone = page_zone(page);
+		spin_lock_irq(&zone->lru_lock);
+		if (TestClearPageLRU(page)) {
+			ret = 1;
+			get_page(page);
+
+			if (PageT1(page))
+				--zone->policy.nr_T1;
+			else
+				--zone->policy.nr_T2;
+
+			if (!PageLongTerm(page))
+				--zone->policy.nr_shortterm;
+		}
+		spin_unlock_irq(&zone->lru_lock);
+	}
+
+	return ret;
+}
+#endif
+
+/*
+ * Add page to a release pagevec, temp. drop zone lock to release pagevec if full.
+ *
+ * @zone: @pages zone.
+ * @page: page to be released.
+ * @pvec: pagevec to collect pages in.
+ */
+static inline void __page_release(struct zone *zone, struct page *page,
+				       struct pagevec *pvec)
+{
+	if (TestSetPageLRU(page))
+		BUG();
+	if (!PageLongTerm(page))
+		++zone->policy.nr_shortterm;
+	if (PageT1(page))
+		++zone->policy.nr_T1;
+	else
+		++zone->policy.nr_T2;
+
+	if (!pagevec_add(pvec, page)) {
+		spin_unlock_irq(&zone->lru_lock);
+		if (buffer_heads_over_limit)
+			pagevec_strip(pvec);
+		__pagevec_release(pvec);
+		spin_lock_irq(&zone->lru_lock);
+	}
+}
+
+void page_replace_reinsert(struct list_head *page_list)
+{
+	struct page *page, *page2;
+	struct zone *zone = NULL;
+	struct pagevec pvec;
+
+	pagevec_init(&pvec, 1);
+	list_for_each_entry_safe(page, page2, page_list, lru) {
+		struct zone *pagezone = page_zone(page);
+		if (pagezone != zone) {
+			if (zone)
+				spin_unlock_irq(&zone->lru_lock);
+			zone = pagezone;
+			spin_lock_irq(&zone->lru_lock);
+		}
+		if (PageT1(page))
+			list_move(&page->lru, &zone->policy.list_T1);
+		else
+			list_move(&page->lru, &zone->policy.list_T2);
+
+		__page_release(zone, page, &pvec);
+	}
+	if (zone)
+		spin_unlock_irq(&zone->lru_lock);
+	pagevec_release(&pvec);
+}
+
+/*
+ * zone->lru_lock is heavily contended.  Some of the functions that
+ * shrink the lists perform better by taking out a batch of pages
+ * and working on them outside the LRU lock.
+ *
+ * For pagecache intensive workloads, this function is the hottest
+ * spot in the kernel (apart from copy_*_user functions).
+ *
+ * Appropriate locks must be held before calling this function.
+ *
+ * @nr_to_scan:	The number of pages to look through on the list.
+ * @src:	The LRU list to pull pages off.
+ * @dst:	The temp list to put pages on to.
+ * @scanned:	The number of pages that were scanned.
+ *
+ * returns how many pages were moved onto *@dst.
+ */
+static int isolate_pages(struct zone *zone, int nr_to_scan,
+			 struct list_head *src,
+			 struct list_head *dst, int *scanned)
+{
+	int nr_taken = 0;
+	struct page *page;
+	int scan = 0;
+
+	while (scan++ < nr_to_scan && !list_empty(src)) {
+		page = lru_to_page(src);
+		prefetchw_prev_lru_page(page, src, flags);
+
+		if (!TestClearPageLRU(page))
+			BUG();
+		list_del(&page->lru);
+		if (get_page_testone(page)) {
+			/*
+			 * It is being freed elsewhere
+			 */
+			__put_page(page);
+			SetPageLRU(page);
+			list_add(&page->lru, src);
+			continue;
+		} else {
+			list_add(&page->lru, dst);
+			nr_taken++;
+			if (!PageLongTerm(page))
+				--zone->policy.nr_shortterm;
+		}
+	}
+
+	zone->pages_scanned += scan;
+	if (src == &zone->policy.list_T1)
+		zone->policy.nr_T1 -= nr_taken;
+	else
+		zone->policy.nr_T2 -= nr_taken;
+
+	*scanned = scan;
+	return nr_taken;
+}
+
+static inline int cart_reclaim_T1(struct zone *zone)
+{
+	int t1 = zone->policy.nr_T1 > zone->policy.nr_p;
+	int sat = TestClearZoneSaturated(zone);
+	int rec = ZoneReclaimedT1(zone);
+
+	if (t1) {
+		if (sat && rec)
+			return 0;
+		return 1;
+	}
+
+	if (sat && !rec)
+		return 1;
+	return 0;
+}
+
+
+void page_replace_candidates(struct zone *zone, int nr_to_scan,
+		struct list_head *page_list)
+{
+	int nr_scan;
+	int nr_taken;
+	struct list_head *list;
+
+	page_replace_add_drain();
+	spin_lock_irq(&zone->lru_lock);
+
+	if (cart_reclaim_T1(zone)) {
+		list = &zone->policy.list_T1;
+		SetZoneReclaimedT1(zone);
+	} else {
+		list = &zone->policy.list_T2;
+		ClearZoneReclaimedT1(zone);
+	}
+
+	nr_taken = isolate_pages(zone, nr_to_scan, list, page_list,
+			         &nr_scan);
+
+	if (!nr_taken) {
+		if (list == &zone->policy.list_T1) {
+			list = &zone->policy.list_T2;
+			ClearZoneReclaimedT1(zone);
+		} else {
+			list = &zone->policy.list_T1;
+			SetZoneReclaimedT1(zone);
+		}
+
+		nr_taken = isolate_pages(zone, nr_to_scan, list,
+				         page_list, &nr_scan);
+	}
+	spin_unlock(&zone->lru_lock);
+	if (current_is_kswapd())
+		__mod_page_state_zone(zone, pgscan_kswapd, nr_scan);
+	else
+		__mod_page_state_zone(zone, pgscan_direct, nr_scan);
+	local_irq_enable();
+}
+
+void page_replace_reinsert_zone(struct zone *zone, struct list_head *page_list, int nr_freed)
+{
+	struct pagevec pvec;
+	unsigned long dqi = 0;
+	unsigned long dqd = 0;
+	unsigned long dsl = 0;
+	unsigned long target;
+
+	pagevec_init(&pvec, 1);
+	spin_lock_irq(&zone->lru_lock);
+
+	target = min(zone->policy.nr_p + 1UL, B2T(nonresident_count(NR_b1)));
+
+	while (!list_empty(page_list)) {
+		struct page * page = lru_to_page(page_list);
+		prefetchw_prev_lru_page(page, page_list, flags);
+
+		if (PageT1(page)) { /* T1 */
+			if (TestClearPageReferenced(page)) {
+				if (!PageLongTerm(page) &&
+				    (zone->policy.nr_T1 - dqd + dqi) >= target) {
+					SetPageLongTerm(page);
+					++dsl;
+				}
+				list_move(&page->lru, &zone->policy.list_T1);
+			} else if (PageLongTerm(page)) {
+				ClearPageT1(page);
+				++dqd;
+				list_move(&page->lru, &zone->policy.list_T2);
+			} else {
+				/* should have been reclaimed or was PG_new */
+				list_move(&page->lru, &zone->policy.list_T1);
+			}
+		} else { /* T2 */
+			if (TestClearPageReferenced(page)) {
+				SetPageT1(page);
+				++dqi;
+				list_move(&page->lru, &zone->policy.list_T1);
+			} else {
+				/* should have been reclaimed */
+				list_move(&page->lru, &zone->policy.list_T2);
+			}
+		}
+		__page_release(zone, page, &pvec);
+	}
+
+	if (!nr_freed) SetZoneSaturated(zone);
+
+	if (dqi > dqd)
+		__cart_q_inc(zone, dqi - dqd);
+	else
+		__cart_q_dec(zone, dqd - dqi);
+
+	spin_unlock_irq(&zone->lru_lock);
+	pagevec_release(&pvec);
+}
+
+void __page_replace_rotate_reclaimable(struct zone *zone, struct page *page)
+{
+	if (PageLRU(page)) {
+		if (PageLongTerm(page)) {
+			if (TestClearPageT1(page)) {
+				--zone->policy.nr_T1;
+				++zone->policy.nr_T2;
+				__cart_q_dec(zone, 1);
+			}
+			list_move_tail(&page->lru, &zone->policy.list_T2);
+		} else {
+			if (!PageT1(page))
+				BUG();
+			list_move_tail(&page->lru, &zone->policy.list_T1);
+		}
+	}
+}
+
+void page_replace_remember(struct zone *zone, struct page *page)
+{
+	int target_list = PageT1(page) ? NR_b1 : NR_b2;
+	int evict_list = (nonresident_count(NR_b1) > cart_q())
+		? NR_b1 : NR_b2;
+
+	nonresident_put(page_mapping(page), page_index(page),
+			target_list, evict_list);
+}
+
+void page_replace_forget(struct address_space *mapping, unsigned long index)
+{
+	nonresident_get(mapping, index);
+}
+
+#define K(x) ((x) << (PAGE_SHIFT-10))
+
+void page_replace_show(struct zone *zone)
+{
+	printk("%s"
+	       " free:%lukB"
+	       " min:%lukB"
+	       " low:%lukB"
+	       " high:%lukB"
+	       " T1:%lukB"
+	       " T2:%lukB"
+	       " shortterm:%lukB"
+	       " present:%lukB"
+	       " pages_scanned:%lu"
+	       " all_unreclaimable? %s"
+	       "\n",
+	       zone->name,
+	       K(zone->free_pages),
+	       K(zone->pages_min),
+	       K(zone->pages_low),
+	       K(zone->pages_high),
+	       K(zone->policy.nr_T1),
+	       K(zone->policy.nr_T2),
+	       K(zone->policy.nr_shortterm),
+	       K(zone->present_pages),
+	       zone->pages_scanned,
+	       (zone->all_unreclaimable ? "yes" : "no")
+	      );
+}
+
+void page_replace_zoneinfo(struct zone *zone, struct seq_file *m)
+{
+	seq_printf(m,
+		   "\n  pages free       %lu"
+		   "\n        min        %lu"
+		   "\n        low        %lu"
+		   "\n        high       %lu"
+		   "\n        T1         %lu"
+		   "\n        T2         %lu"
+		   "\n        shortterm  %lu"
+		   "\n        p          %lu"
+		   "\n        flags      %lu"
+		   "\n        scanned    %lu"
+		   "\n        spanned    %lu"
+		   "\n        present    %lu",
+		   zone->free_pages,
+		   zone->pages_min,
+		   zone->pages_low,
+		   zone->pages_high,
+		   zone->policy.nr_T1,
+		   zone->policy.nr_T2,
+		   zone->policy.nr_shortterm,
+		   zone->policy.nr_p,
+		   zone->policy.flags,
+		   zone->pages_scanned,
+		   zone->spanned_pages,
+		   zone->present_pages);
+}
+
+void __page_replace_counts(unsigned long *active, unsigned long *inactive,
+			   unsigned long *free, struct pglist_data *pgdat)
+{
+	struct zone *zones = pgdat->node_zones;
+	int i;
+
+	*active = 0;
+	*inactive = 0;
+	*free = 0;
+	for (i = 0; i < MAX_NR_ZONES; i++) {
+		*active += zones[i].policy.nr_T1 + zones[i].policy.nr_T2 -
+			zones[i].policy.nr_shortterm;
+		*inactive += zones[i].policy.nr_shortterm;
+		*free += zones[i].free_pages;
+	}
+}
Index: linux-2.6-git/include/linux/mm_page_replace.h
===================================================================
--- linux-2.6-git.orig/include/linux/mm_page_replace.h
+++ linux-2.6-git/include/linux/mm_page_replace.h
@@ -112,10 +112,12 @@ extern int page_replace_isolate(struct p
 static inline int page_replace_isolate(struct page *p) { return -ENOSYS; }
 #endif
 
-#ifdef CONFIG_MM_POLICY_USEONCE
+#if defined CONFIG_MM_POLICY_USEONCE
 #include <linux/mm_use_once_policy.h>
-#elif CONFIG_MM_POLICY_CLOCKPRO
+#elif defined CONFIG_MM_POLICY_CLOCKPRO
 #include <linux/mm_clockpro_policy.h>
+#elif defined CONFIG_MM_POLICY_CART
+#include <linux/mm_cart_policy.h>
 #else
 #error no mm policy
 #endif
Index: linux-2.6-git/include/linux/mm_page_replace_data.h
===================================================================
--- linux-2.6-git.orig/include/linux/mm_page_replace_data.h
+++ linux-2.6-git/include/linux/mm_page_replace_data.h
@@ -3,10 +3,12 @@
 
 #ifdef __KERNEL__
 
-#ifdef CONFIG_MM_POLICY_USEONCE
+#if defined CONFIG_MM_POLICY_USEONCE
 #include <linux/mm_use_once_data.h>
-#elif CONFIG_MM_POLICY_CLOCKPRO
+#elif defined CONFIG_MM_POLICY_CLOCKPRO
 #include <linux/mm_clockpro_data.h>
+#elif defined CONFIG_MM_POLICY_CART
+#include <linux/mm_cart_data.h>
 #else
 #error no mm policy
 #endif
Index: linux-2.6-git/mm/Kconfig
===================================================================
--- linux-2.6-git.orig/mm/Kconfig
+++ linux-2.6-git/mm/Kconfig
@@ -147,6 +147,11 @@ config MM_POLICY_CLOCKPRO
 	help
 	  This option selects a CLOCK-Pro based policy
 
+config MM_POLICY_CART
+	bool "CART"
+	help
+	  This option selects a CART based policy
+
 endchoice
 
 #
Index: linux-2.6-git/mm/Makefile
===================================================================
--- linux-2.6-git.orig/mm/Makefile
+++ linux-2.6-git/mm/Makefile
@@ -14,6 +14,7 @@ obj-y			:= bootmem.o filemap.o mempool.o
 
 obj-$(CONFIG_MM_POLICY_USEONCE) += useonce.o
 obj-$(CONFIG_MM_POLICY_CLOCKPRO) += nonresident.o clockpro.o
+obj-$(CONFIG_MM_POLICY_CART) += nonresident-cart.o cart.o
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
Index: linux-2.6-git/include/linux/mm_cart_data.h
===================================================================
--- /dev/null
+++ linux-2.6-git/include/linux/mm_cart_data.h
@@ -0,0 +1,31 @@
+#ifndef _LINUX_CART_DATA_H_
+#define _LINUX_CART_DATA_H_
+
+#ifdef __KERNEL__
+
+#include <asm/bitops.h>
+
+struct page_replace_data {
+	struct list_head        list_T1;
+	struct list_head        list_T2;
+	unsigned long		nr_scan;
+	unsigned long		nr_T1;
+	unsigned long		nr_T2;
+	unsigned long           nr_shortterm;
+	unsigned long           nr_p;
+	unsigned long		flags;
+};
+
+#define CART_RECLAIMED_T1	0
+#define CART_SATURATED		1
+
+#define ZoneReclaimedT1(z)	test_bit(CART_RECLAIMED_T1, &((z)->policy.flags))
+#define SetZoneReclaimedT1(z)	__set_bit(CART_RECLAIMED_T1, &((z)->policy.flags))
+#define ClearZoneReclaimedT1(z)	__clear_bit(CART_RECLAIMED_T1, &((z)->policy.flags))
+
+#define ZoneSaturated(z)	test_bit(CART_SATURATED, &((z)->policy.flags))
+#define SetZoneSaturated(z)	__set_bit(CART_SATURATED, &((z)->policy.flags))
+#define TestClearZoneSaturated(z)  __test_and_clear_bit(CART_SATURATED, &((z)->policy.flags))
+
+#endif /* __KERNEL__ */
+#endif /* _LINUX_CART_DATA_H_ */
Index: linux-2.6-git/include/linux/mm_cart_policy.h
===================================================================
--- /dev/null
+++ linux-2.6-git/include/linux/mm_cart_policy.h
@@ -0,0 +1,134 @@
+#ifndef _LINUX_MM_CART_POLICY_H
+#define _LINUX_MM_CART_POLICY_H
+
+#ifdef __KERNEL__
+
+#include <linux/rmap.h>
+#include <linux/page-flags.h>
+
+#define PG_t1		PG_reclaim1
+#define PG_longterm	PG_reclaim2
+#define PG_new		PG_reclaim3
+
+#define PageT1(page)		test_bit(PG_t1, &(page)->flags)
+#define SetPageT1(page)		set_bit(PG_t1, &(page)->flags)
+#define ClearPageT1(page)	clear_bit(PG_t1, &(page)->flags)
+#define TestClearPageT1(page)	test_and_clear_bit(PG_t1, &(page)->flags)
+#define TestSetPageT1(page)	test_and_set_bit(PG_t1, &(page)->flags)
+
+#define PageLongTerm(page)	test_bit(PG_longterm, &(page)->flags)
+#define SetPageLongTerm(page)	set_bit(PG_longterm, &(page)->flags)
+#define TestSetPageLongTerm(page) test_and_set_bit(PG_longterm, &(page)->flags)
+#define ClearPageLongTerm(page)	clear_bit(PG_longterm, &(page)->flags)
+#define TestClearPageLongTerm(page) test_and_clear_bit(PG_longterm, &(page)->flags)
+
+#define PageNew(page)		test_bit(PG_new, &(page)->flags)
+#define SetPageNew(page)	set_bit(PG_new, &(page)->flags)
+#define TestSetPageNew(page)	test_and_set_bit(PG_new, &(page)->flags)
+#define ClearPageNew(page)	clear_bit(PG_new, &(page)->flags)
+#define TestClearPageNew(page)	test_and_clear_bit(PG_new, &(page)->flags)
+
+static inline void page_replace_hint_active(struct page *page)
+{
+}
+
+static inline void page_replace_hint_use_once(struct page *page)
+{
+	if (PageLRU(page))
+		BUG();
+	SetPageNew(page);
+}
+
+extern void __page_replace_add(struct zone *, struct page *);
+
+static inline void page_replace_copy_state(struct page *dpage, struct page *spage)
+{
+	if (PageT1(spage))
+		SetPageT1(dpage);
+	if (PageLongTerm(spage))
+		SetPageLongTerm(dpage);
+	if (PageNew(spage))
+		SetPageNew(dpage);
+}
+
+static inline void page_replace_clear_state(struct page *page)
+{
+	if (PageT1(page))
+		ClearPageT1(page);
+	if (PageLongTerm(page))
+		ClearPageLongTerm(page);
+	if (PageNew(page))
+		ClearPageNew(page);
+}
+
+static inline int page_replace_is_active(struct page *page)
+{
+	return PageLongTerm(page);
+}
+
+static inline void page_replace_remove(struct zone *zone, struct page *page)
+{
+	list_del(&page->lru);
+	if (PageT1(page))
+		--zone->policy.nr_T1;
+	else
+		--zone->policy.nr_T2;
+
+	if (!PageLongTerm(page))
+		--zone->policy.nr_shortterm;
+
+	page_replace_clear_state(page);
+}
+
+static inline int page_replace_reclaimable(struct page *page)
+{
+	if (page_referenced(page, 1, 0))
+		return RECLAIM_ACTIVATE;
+
+	if (PageNew(page))
+		ClearPageNew(page);
+
+	if ((PageT1(page) && PageLongTerm(page)) ||
+	    (!PageT1(page) && !PageLongTerm(page)))
+		return RECLAIM_KEEP;
+
+	return RECLAIM_OK;
+}
+
+static inline int fastcall page_replace_activate(struct page *page)
+{
+	/* just set PG_referenced, handle the rest in
+	 * page_replace_reinsert()
+	 */
+	if (!TestClearPageNew(page)) {
+		SetPageReferenced(page);
+		return 1;
+	}
+
+	return 0;
+}
+
+extern void __page_replace_rotate_reclaimable(struct zone *, struct page *);
+
+static inline void page_replace_mark_accessed(struct page *page)
+{
+	SetPageReferenced(page);
+}
+
+#define MM_POLICY_HAS_NONRESIDENT
+
+extern void page_replace_remember(struct zone *, struct page *);
+extern void page_replace_forget(struct address_space *, unsigned long);
+
+static inline unsigned long __page_replace_nr_pages(struct zone *zone)
+{
+	return zone->policy.nr_T1 + zone->policy.nr_T2;
+}
+
+static inline unsigned long __page_replace_nr_scan(struct zone *zone)
+{
+	return zone->policy.nr_T1 + zone->policy.nr_T2;
+}
+
+#endif /* __KERNEL__ */
+#endif /* _LINUX_MM_CART_POLICY_H_ */
