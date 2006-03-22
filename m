Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932906AbWCVWim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932906AbWCVWim (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932918AbWCVWhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:37:52 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:43402 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S932909AbWCVWha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:37:30 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Bob Picco <bob.picco@hp.com>, Andrew Morton <akpm@osdl.org>,
       IWAMOTO Toshihiro <iwamoto@valinux.co.jp>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20060322223655.12658.95075.sendpatchset@twins.localnet>
In-Reply-To: <20060322223107.12658.14997.sendpatchset@twins.localnet>
References: <20060322223107.12658.14997.sendpatchset@twins.localnet>
Subject: [PATCH 34/34] mm: random.patch
Date: Wed, 22 Mar 2006 23:37:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

Random page replacement.

Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

---

 include/linux/mm_page_replace.h      |    2 
 include/linux/mm_page_replace_data.h |    2 
 include/linux/mm_random_data.h       |    9 +
 include/linux/mm_random_policy.h     |   47 +++++
 mm/Kconfig                           |    5 
 mm/Makefile                          |    1 
 mm/random_policy.c                   |  292 +++++++++++++++++++++++++++++++++++
 7 files changed, 358 insertions(+)

Index: linux-2.6-git/mm/random_policy.c
===================================================================
--- /dev/null
+++ linux-2.6-git/mm/random_policy.c
@@ -0,0 +1,292 @@
+
+/* Random page replacement policy */
+
+#include <linux/module.h>
+#include <linux/mm_page_replace.h>
+#include <linux/swap.h>
+#include <linux/pagevec.h>
+#include <linux/init.h>
+#include <linux/rmap.h>
+#include <linux/hash.h>
+#include <linux/seq_file.h>
+#include <linux/writeback.h>
+#include <linux/buffer_head.h>	/* for try_to_release_page(),
+					buffer_heads_over_limit */
+#include <asm/sections.h>
+
+void __init page_replace_init(void)
+{
+	printk(KERN_ERR "Random page replacement policy init!\n");
+}
+
+void __init page_replace_init_zone(struct zone *zone)
+{
+	zone->policy.nr_pages = 0;
+}
+
+static DEFINE_PER_CPU(struct pagevec, add_pvecs) = { 0, };
+
+void __page_replace_add(struct zone *zone, struct page *page)
+{
+	zone->policy.nr_pages++;
+}
+
+void fastcall page_replace_add(struct page *page)
+{
+	struct pagevec *pvec = &get_cpu_var(add_pvecs);
+
+	page_cache_get(page);
+	if (!pagevec_add(pvec, page))
+		__pagevec_page_replace_add(pvec);
+	put_cpu_var(add_pvecs);
+}
+
+void __page_replace_add_drain(unsigned int cpu)
+{
+	struct pagevec *pvec = &per_cpu(add_pvecs, cpu);
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
+			--zone->policy.nr_pages;
+		}
+		spin_unlock_irq(&zone->lru_lock);
+	}
+
+	return ret;
+}
+#endif
+
+static inline void __page_release(struct zone *zone, struct page *page,
+				       struct pagevec *pvec)
+{
+	if (TestSetPageLRU(page))
+		BUG();
+	++zone->policy.nr_pages;
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
+		__page_release(zone, page, &pvec);
+	}
+	if (zone)
+		spin_unlock_irq(&zone->lru_lock);
+	pagevec_release(&pvec);
+}
+
+/*
+ * Lehmer simple linear congruential PRNG
+ *
+ * Xn+1 = (a * Xn + c) mod m
+ *
+ * where a, c and m are constants.
+ *
+ * Note that "m" is zone->present_pages, so in this case its
+ * really not constant.
+ */
+
+static unsigned long get_random(struct zone *zone)
+{
+	zone->policy.seed =
+		hash_long(zone->policy.seed, BITS_PER_LONG) + 3147484177UL;
+	return zone->policy.seed;
+}
+
+static struct page *pick_random_cache_page(struct zone *zone)
+{
+	struct page *page;
+	unsigned long pfn;
+	do {
+		pfn = zone->zone_start_pfn +
+			get_random(zone) % zone->present_pages;
+		page = pfn_to_page(pfn);
+	} while (!PageLRU(page));
+	zone->policy.seed ^= page_index(page);
+	return page;
+}
+
+static int isolate_pages(struct zone *zone, int nr_to_scan,
+		struct list_head *pages, int *nr_scanned)
+{
+	int nr_taken = 0;
+	struct page *page;
+	int scan = 0;
+
+	while (scan++ < nr_to_scan && zone->policy.nr_pages) {
+		page = pick_random_cache_page(zone);
+
+		if (!TestClearPageLRU(page))
+			BUG();
+		if (get_page_testone(page)) {
+			/*
+			 * It is being freed elsewhere
+			 */
+			__put_page(page);
+			SetPageLRU(page);
+			continue;
+		} else {
+			list_add(&page->lru, pages);
+			nr_taken++;
+			--zone->policy.nr_pages;
+		}
+	}
+	zone->pages_scanned += scan;
+	*nr_scanned = scan;
+	return nr_taken;
+}
+
+void page_replace_candidates(struct zone *zone, int nr_to_scan, struct list_head *pages)
+{
+	int nr_scan;
+	page_replace_add_drain();
+	spin_lock_irq(&zone->lru_lock);
+	isolate_pages(zone, nr_to_scan, pages, &nr_scan);
+	spin_unlock(&zone->lru_lock);
+	if (current_is_kswapd())
+		__mod_page_state_zone(zone, pgscan_kswapd, nr_scan);
+	else
+		__mod_page_state_zone(zone, pgscan_direct, nr_scan);
+	local_irq_enable();
+}
+
+void page_replace_reinsert_zone(struct zone *zone, struct list_head *pages, int nr_freed)
+{
+	struct pagevec pvec;
+	pagevec_init(&pvec, 1);
+	spin_lock_irq(&zone->lru_lock);
+	while (!list_empty(pages)) {
+		struct page *page = lru_to_page(pages);
+		list_del(&page->lru);
+		__page_release(zone, page, &pvec);
+	}
+	spin_unlock_irq(&zone->lru_lock);
+	pagevec_release(&pvec);
+}
+
+#define K(x) ((x) << (PAGE_SHIFT-10))
+
+void page_replace_show(struct zone *zone)
+{
+	printk("%s"
+		" free:%lukB"
+		" min:%lukB"
+		" low:%lukB"
+		" high:%lukB"
+		" cached:%lukB"
+		" present:%lukB"
+		" pages_scanned:%lu"
+		" all_unreclaimable? %s"
+		"\n",
+		zone->name,
+		K(zone->free_pages),
+		K(zone->pages_min),
+		K(zone->pages_low),
+		K(zone->pages_high),
+		K(zone->policy.nr_pages),
+		K(zone->present_pages),
+		zone->pages_scanned,
+		(zone->all_unreclaimable ? "yes" : "no")
+		);
+}
+
+void page_replace_zoneinfo(struct zone *zone, struct seq_file *m)
+{
+	seq_printf(m,
+		   "\n  pages free     %lu"
+		   "\n        min      %lu"
+		   "\n        low      %lu"
+		   "\n        high     %lu"
+		   "\n        cached   %lu"
+		   "\n        scanned  %lu"
+		   "\n        spanned  %lu"
+		   "\n        present  %lu",
+		   zone->free_pages,
+		   zone->pages_min,
+		   zone->pages_low,
+		   zone->pages_high,
+		   zone->policy.nr_pages,
+		   zone->pages_scanned,
+		   zone->spanned_pages,
+		   zone->present_pages);
+}
+
+void __page_replace_counts(unsigned long *active, unsigned long *inactive,
+			unsigned long *free, struct pglist_data *pgdat)
+{
+	struct zone *zones = pgdat->node_zones;
+	int i;
+
+	*active = 0;
+	*inactive = 0;
+	*free = 0;
+	for (i = 0; i < MAX_NR_ZONES; i++) {
+		*free += zones[i].free_pages;
+	}
+}
Index: linux-2.6-git/mm/Kconfig
===================================================================
--- linux-2.6-git.orig/mm/Kconfig
+++ linux-2.6-git/mm/Kconfig
@@ -158,6 +158,11 @@ config MM_POLICY_CART_R
 	  This option selects a CART based policy modified to handle cyclic
 	  access patterns.
 
+config MM_POLICY_RANDOM
+	bool "Random"
+	help
+	  This option selects the random replacement policy.
+
 endchoice
 
 #
Index: linux-2.6-git/include/linux/mm_page_replace.h
===================================================================
--- linux-2.6-git.orig/include/linux/mm_page_replace.h
+++ linux-2.6-git/include/linux/mm_page_replace.h
@@ -118,6 +118,8 @@ static inline int page_replace_isolate(s
 #include <linux/mm_clockpro_policy.h>
 #elif defined CONFIG_MM_POLICY_CART || defined CONFIG_MM_POLICY_CART_R
 #include <linux/mm_cart_policy.h>
+#elif defined CONFIG_MM_POLICY_RANDOM
+#include <linux/mm_random_policy.h>
 #else
 #error no mm policy
 #endif
Index: linux-2.6-git/include/linux/mm_page_replace_data.h
===================================================================
--- linux-2.6-git.orig/include/linux/mm_page_replace_data.h
+++ linux-2.6-git/include/linux/mm_page_replace_data.h
@@ -9,6 +9,8 @@
 #include <linux/mm_clockpro_data.h>
 #elif defined CONFIG_MM_POLICY_CART || defined CONFIG_MM_POLICY_CART_R
 #include <linux/mm_cart_data.h>
+#elif defined CONFIG_MM_POLICY_RANDOM
+#include <linux/mm_random_data.h>
 #else
 #error no mm policy
 #endif
Index: linux-2.6-git/include/linux/mm_random_policy.h
===================================================================
--- /dev/null
+++ linux-2.6-git/include/linux/mm_random_policy.h
@@ -0,0 +1,47 @@
+#ifndef _LINUX_MM_RANDOM_POLICY_H
+#define _LINUX_MM_RANDOM_POLICY_H
+
+#ifdef __KERNEL__
+
+#include <linux/page-flags.h>
+
+
+#define page_replace_hint_active(p) do { } while (0)
+#define page_replace_hint_use_once(p) do { } while (0)
+
+extern void __page_replace_add(struct zone *, struct page *);
+
+#define page_replace_activate(p) 0
+#define page_replace_reclaimable(p) RECLAIM_OK
+#define page_replace_mark_accessed(p) do { } while (0)
+
+static inline
+void page_replace_remove(struct zone *zone, struct page *page)
+{
+	zone->policy.nr_pages--;
+}
+
+static inline
+void __page_replace_rotate_reclaimable(struct zone *zone, struct page *page)
+{
+}
+
+#define page_replace_copy_state(d, s) do { } while (0)
+#define page_replace_clear_state(p) do { } while (0)
+#define page_replace_is_active(p) 0
+
+#define page_replace_remember(z, p) do { } while (0)
+#define page_replace_forget(m, i) do { } while (0)
+
+static inline unsigned long __page_replace_nr_pages(struct zone *zone)
+{
+	return zone->policy.nr_pages;
+}
+
+static inline unsigned long __page_replace_nr_scan(struct zone *zone)
+{
+	return zone->policy.nr_pages;
+}
+
+#endif /* __KERNEL__ */
+#endif /* _LINUX_MM_LRU_POLICY_H */
Index: linux-2.6-git/include/linux/mm_random_data.h
===================================================================
--- /dev/null
+++ linux-2.6-git/include/linux/mm_random_data.h
@@ -0,0 +1,9 @@
+#ifdef __KERNEL__
+
+struct page_replace_data {
+	unsigned long nr_scan;
+	unsigned long nr_pages;
+	unsigned long seed;
+};
+
+#endif /* __KERNEL__ */
Index: linux-2.6-git/mm/Makefile
===================================================================
--- linux-2.6-git.orig/mm/Makefile
+++ linux-2.6-git/mm/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_MM_POLICY_USEONCE) += useon
 obj-$(CONFIG_MM_POLICY_CLOCKPRO) += nonresident.o clockpro.o
 obj-$(CONFIG_MM_POLICY_CART) += nonresident-cart.o cart.o
 obj-$(CONFIG_MM_POLICY_CART_R) += nonresident-cart.o cart.o
+obj-$(CONFIG_MM_POLICY_RANDOM) += random_policy.o
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
