Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932566AbVLFNfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbVLFNfZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 08:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbVLFNfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 08:35:24 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:43224 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932571AbVLFNfV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 08:35:21 -0500
Message-Id: <20051206135733.910543000@localhost.localdomain>
References: <20051206135608.860737000@localhost.localdomain>
Date: Tue, 06 Dec 2005 21:56:11 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <christoph@lameter.com>,
       Rik van Riel <riel@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Magnus Damm <magnus.damm@gmail.com>, Nick Piggin <npiggin@suse.de>,
       Andrea Arcangeli <andrea@suse.de>, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 03/13] mm: supporting variables and functions for balanced zone aging
Content-Disposition: inline; filename=mm-balance-zone-aging-supporting-facilities.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The zone aging rates are currently imbalanced, the gap can be as large as 3
times, which can severely damage read-ahead requests and shorten their
effective life time.

This patch adds three variables in struct zone
	- aging_total
	- aging_milestone
	- page_age
to keep track of page aging rate, and keep it in sync on page reclaim time.

The aging_total is just a per-zone counter-part to the per-cpu
pgscan_{kswapd,direct}_{zone name}. But it is not direct comparable between
zones, so the aging_milestone/page_age are maintained based on aging_total.

The page_age is a normalized value that can be direct compared between zones
with the helper macro age_ge/age_gt. The goal of balancing logics are to keep
this normalized value in sync between zones.

One can check the balanced aging progress by running:
                        tar c / | cat > /dev/null &
                        watch -n1 'grep "age " /proc/zoneinfo'

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 include/linux/mmzone.h |   14 ++++++++++++++
 mm/page_alloc.c        |   11 +++++++++++
 mm/vmscan.c            |   43 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

--- linux-2.6.15-rc5-mm1.orig/include/linux/mmzone.h
+++ linux-2.6.15-rc5-mm1/include/linux/mmzone.h
@@ -149,6 +149,20 @@ struct zone {
 	unsigned long		pages_scanned;	   /* since last reclaim */
 	int			all_unreclaimable; /* All pages pinned */
 
+	/* Fields for balanced page aging:
+	 * aging_total     - The accumulated number of activities that may
+	 *                   cause page aging, that is, make some pages closer
+	 *                   to the tail of inactive_list.
+	 * aging_milestone - A snapshot of total_scan every time a full
+	 *                   inactive_list of pages become aged.
+	 * page_age        - A normalized value showing the percent of pages
+	 *                   have been aged.  It is compared between zones to
+	 *                   balance the rate of page aging.
+	 */
+	unsigned long		aging_total;
+	unsigned long		aging_milestone;
+	unsigned long		page_age;
+
 	/*
 	 * Does the allocator try to reclaim pages from the zone as soon
 	 * as it fails a watermark_ok() in __alloc_pages?
--- linux-2.6.15-rc5-mm1.orig/mm/vmscan.c
+++ linux-2.6.15-rc5-mm1/mm/vmscan.c
@@ -123,6 +123,48 @@ static long total_memory;
 static LIST_HEAD(shrinker_list);
 static DECLARE_RWSEM(shrinker_rwsem);
 
+#ifdef CONFIG_HIGHMEM64G
+#define		PAGE_AGE_SHIFT  8
+#elif BITS_PER_LONG == 32
+#define		PAGE_AGE_SHIFT  12
+#elif BITS_PER_LONG == 64
+#define		PAGE_AGE_SHIFT  20
+#else
+#error unknown BITS_PER_LONG
+#endif
+#define		PAGE_AGE_SIZE   (1 << PAGE_AGE_SHIFT)
+#define		PAGE_AGE_MASK   (PAGE_AGE_SIZE - 1)
+
+/*
+ * The simplified code is:
+ * 	age_ge: (a->page_age >= b->page_age)
+ * 	age_gt: (a->page_age > b->page_age)
+ * The complexity deals with the wrap-around problem.
+ * Two page ages not close enough(gap >= 1/8) should also be ignored:
+ * they are out of sync and the comparison may be nonsense.
+ */
+#define age_ge(a, b) \
+	(((a->page_age - b->page_age) & PAGE_AGE_MASK) < PAGE_AGE_SIZE / 8)
+#define age_gt(a, b) \
+	(((b->page_age - a->page_age) & PAGE_AGE_MASK) > PAGE_AGE_SIZE * 7 / 8)
+
+/*
+ * Keep track of the percent of cold pages that have been scanned / aged.
+ * It's not really ##%, but a high resolution normalized value.
+ */
+static inline void update_zone_age(struct zone *z, int nr_scan)
+{
+	unsigned long len = z->nr_inactive | 1;
+
+	z->aging_total += nr_scan;
+
+	if (z->aging_total - z->aging_milestone > len)
+		z->aging_milestone += len;
+
+	z->page_age = ((z->aging_total - z->aging_milestone)
+						<< PAGE_AGE_SHIFT) / len;
+}
+
 /*
  * Add a shrinker callback to be called from the vm
  */
@@ -887,6 +929,7 @@ static void shrink_cache(struct zone *zo
 					     &page_list, &nr_scan);
 		zone->nr_inactive -= nr_taken;
 		zone->pages_scanned += nr_scan;
+		update_zone_age(zone, nr_scan);
 		spin_unlock_irq(&zone->lru_lock);
 
 		if (nr_taken == 0)
--- linux-2.6.15-rc5-mm1.orig/mm/page_alloc.c
+++ linux-2.6.15-rc5-mm1/mm/page_alloc.c
@@ -1522,6 +1522,8 @@ void show_free_areas(void)
 			" active:%lukB"
 			" inactive:%lukB"
 			" present:%lukB"
+			" aging:%lukB"
+			" age:%lu"
 			" pages_scanned:%lu"
 			" all_unreclaimable? %s"
 			"\n",
@@ -1533,6 +1535,8 @@ void show_free_areas(void)
 			K(zone->nr_active),
 			K(zone->nr_inactive),
 			K(zone->present_pages),
+			K(zone->aging_total),
+			zone->page_age,
 			zone->pages_scanned,
 			(zone->all_unreclaimable ? "yes" : "no")
 			);
@@ -2144,6 +2148,9 @@ static void __init free_area_init_core(s
 		zone->nr_scan_inactive = 0;
 		zone->nr_active = 0;
 		zone->nr_inactive = 0;
+		zone->aging_total = 0;
+		zone->aging_milestone = 0;
+		zone->page_age = 0;
 		atomic_set(&zone->reclaim_in_progress, 0);
 		if (!size)
 			continue;
@@ -2292,6 +2299,8 @@ static int zoneinfo_show(struct seq_file
 			   "\n        high     %lu"
 			   "\n        active   %lu"
 			   "\n        inactive %lu"
+			   "\n        aging    %lu"
+			   "\n        age      %lu"
 			   "\n        scanned  %lu (a: %lu i: %lu)"
 			   "\n        spanned  %lu"
 			   "\n        present  %lu",
@@ -2301,6 +2310,8 @@ static int zoneinfo_show(struct seq_file
 			   zone->pages_high,
 			   zone->nr_active,
 			   zone->nr_inactive,
+			   zone->aging_total,
+			   zone->page_age,
 			   zone->pages_scanned,
 			   zone->nr_scan_active, zone->nr_scan_inactive,
 			   zone->spanned_pages,

--
