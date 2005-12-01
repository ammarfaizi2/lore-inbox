Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbVLAKMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbVLAKMZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 05:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbVLAKMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 05:12:24 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:37784 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932099AbVLAKMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 05:12:07 -0500
Message-Id: <20051201101933.936973000@localhost.localdomain>
References: <20051201101810.837245000@localhost.localdomain>
Date: Thu, 01 Dec 2005 18:18:12 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <christoph@lameter.com>,
       Rik van Riel <riel@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Nick Piggin <npiggin@suse.de>, Andrea Arcangeli <andrea@suse.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Magnus Damm <magnus.damm@gmail.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 02/12] mm: supporting variables and functions for balanced zone aging
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
with the helper macro pages_more_aged(). The goal of balancing logics are to
keep this normalized value in sync between zones.

One can check the balanced aging progress by running:
                        tar c / | cat > /dev/null &
                        watch -n1 'grep "age " /proc/zoneinfo'

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 include/linux/mmzone.h |   14 ++++++++++++++
 mm/page_alloc.c        |   11 +++++++++++
 mm/vmscan.c            |   39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+)

--- linux.orig/include/linux/mmzone.h
+++ linux/include/linux/mmzone.h
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
--- linux.orig/mm/vmscan.c
+++ linux/mm/vmscan.c
@@ -123,6 +123,44 @@ static long total_memory;
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
+#define		PAGE_AGE_MASK   ((1 << PAGE_AGE_SHIFT) - 1)
+
+/*
+ * The simplified code is: (a->page_age > b->page_age)
+ * The complexity deals with the wrap-around problem.
+ * Two page ages not close enough should also be ignored:
+ * they are out of sync and the comparison may be nonsense.
+ */
+#define pages_more_aged(a, b) 						\
+	((b->page_age - a->page_age) & PAGE_AGE_MASK) >			\
+			PAGE_AGE_MASK - (1 << (PAGE_AGE_SHIFT - 3))	\
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
@@ -888,6 +926,7 @@ static void shrink_cache(struct zone *zo
 					     &page_list, &nr_scan);
 		zone->nr_inactive -= nr_taken;
 		zone->pages_scanned += nr_scan;
+		update_zone_age(zone, nr_scan);
 		spin_unlock_irq(&zone->lru_lock);
 
 		if (nr_taken == 0)
--- linux.orig/mm/page_alloc.c
+++ linux/mm/page_alloc.c
@@ -1521,6 +1521,8 @@ void show_free_areas(void)
 			" active:%lukB"
 			" inactive:%lukB"
 			" present:%lukB"
+			" aging:%lukB"
+			" age:%lu"
 			" pages_scanned:%lu"
 			" all_unreclaimable? %s"
 			"\n",
@@ -1532,6 +1534,8 @@ void show_free_areas(void)
 			K(zone->nr_active),
 			K(zone->nr_inactive),
 			K(zone->present_pages),
+			K(zone->aging_total),
+			zone->page_age,
 			zone->pages_scanned,
 			(zone->all_unreclaimable ? "yes" : "no")
 			);
@@ -2145,6 +2149,9 @@ static void __init free_area_init_core(s
 		zone->nr_scan_inactive = 0;
 		zone->nr_active = 0;
 		zone->nr_inactive = 0;
+		zone->aging_total = 0;
+		zone->aging_milestone = 0;
+		zone->page_age = 0;
 		atomic_set(&zone->reclaim_in_progress, 0);
 		if (!size)
 			continue;
@@ -2293,6 +2300,8 @@ static int zoneinfo_show(struct seq_file
 			   "\n        high     %lu"
 			   "\n        active   %lu"
 			   "\n        inactive %lu"
+			   "\n        aging    %lu"
+			   "\n        age      %lu"
 			   "\n        scanned  %lu (a: %lu i: %lu)"
 			   "\n        spanned  %lu"
 			   "\n        present  %lu",
@@ -2302,6 +2311,8 @@ static int zoneinfo_show(struct seq_file
 			   zone->pages_high,
 			   zone->nr_active,
 			   zone->nr_inactive,
+			   zone->aging_total,
+			   zone->page_age,
 			   zone->pages_scanned,
 			   zone->nr_scan_active, zone->nr_scan_inactive,
 			   zone->spanned_pages,

--
