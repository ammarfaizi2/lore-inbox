Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbVHLOuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbVHLOuf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 10:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751035AbVHLOrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 10:47:52 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:64932 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751064AbVHLOr3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 10:47:29 -0400
Subject: [RFC][PATCH 07/12] memory hotplug locking: zone span seqlock
To: linux-kernel@vger.kernel.org
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 12 Aug 2005 07:47:26 -0700
References: <20050812144714.805F4B48@kernel.beaverton.ibm.com>
In-Reply-To: <20050812144714.805F4B48@kernel.beaverton.ibm.com>
Message-Id: <20050812144726.0E8B60FF@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


See the "fixup bad_range()" patch for more information, but this
actually creates a the lock to protect things making assumptions
about a zone's size staying constant at runtime.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/include/linux/memory_hotplug.h |   39 +++++++++++++++++++++++--
 memhotplug-dave/include/linux/mmzone.h         |   15 +++++++++
 memhotplug-dave/mm/page_alloc.c                |   19 ++++++++----
 txt                                            |    0 
 4 files changed, 66 insertions(+), 7 deletions(-)

diff -puN kernel/power/swsusp.c~C6-zone-span_seqlock kernel/power/swsusp.c
diff -puN include/linux/mmzone.h~C6-zone-span_seqlock include/linux/mmzone.h
--- memhotplug/include/linux/mmzone.h~C6-zone-span_seqlock	2005-08-12 07:43:47.000000000 -0700
+++ memhotplug-dave/include/linux/mmzone.h	2005-08-12 07:43:48.000000000 -0700
@@ -12,6 +12,7 @@
 #include <linux/threads.h>
 #include <linux/numa.h>
 #include <linux/init.h>
+#include <linux/seqlock.h>
 #include <asm/atomic.h>
 
 /* Free memory management - zoned buddy allocator.  */
@@ -137,6 +138,10 @@ struct zone {
 	 * free areas of different sizes
 	 */
 	spinlock_t		lock;
+#ifdef CONFIG_MEMORY_HOTPLUG
+	/* see spanned/present_pages for more description */
+	seqlock_t		span_seqlock;
+#endif
 	struct free_area	free_area[MAX_ORDER];
 
 
@@ -220,6 +225,16 @@ struct zone {
 	/* zone_start_pfn == zone_start_paddr >> PAGE_SHIFT */
 	unsigned long		zone_start_pfn;
 
+	/*
+	 * zone_start_pfn, spanned_pages and present_pages are all
+	 * protected by span_seqlock.  It is a seqlock because it has
+	 * to be read outside of zone->lock, and it is done in the main
+	 * allocator path.  But, it is written quite infrequently.
+	 *
+	 * The lock is declared along with zone->lock because it is
+	 * frequently read in proximity to zone->lock.  It's good to
+	 * give them a chance of being in the same cacheline.
+	 */
 	unsigned long		spanned_pages;	/* total size, including holes */
 	unsigned long		present_pages;	/* amount of memory (excluding holes) */
 
diff -puN mm/page_alloc.c~C6-zone-span_seqlock mm/page_alloc.c
--- memhotplug/mm/page_alloc.c~C6-zone-span_seqlock	2005-08-12 07:43:47.000000000 -0700
+++ memhotplug-dave/mm/page_alloc.c	2005-08-12 07:43:48.000000000 -0700
@@ -32,6 +32,7 @@
 #include <linux/sysctl.h>
 #include <linux/cpu.h>
 #include <linux/cpuset.h>
+#include <linux/memory_hotplug.h>
 #include <linux/nodemask.h>
 #include <linux/vmalloc.h>
 
@@ -79,12 +80,19 @@ unsigned long __initdata nr_all_pages;
 
 static int page_outside_zone_boundaries(struct zone *zone, struct page *page)
 {
-	if (page_to_pfn(page) >= zone->zone_start_pfn + zone->spanned_pages)
-		return 1;
-	if (page_to_pfn(page) < zone->zone_start_pfn)
-		return 1;
+	int ret = 0;
+	unsigned seq;
+	unsigned long pfn = page_to_pfn(page);
 
-	return 0;
+	do {
+		seq = zone_span_seqbegin(zone);
+		if (pfn >= zone->zone_start_pfn + zone->spanned_pages)
+			ret = 1;
+		else if (pfn < zone->zone_start_pfn)
+			ret = 1;
+	} while (zone_span_seqretry(zone, seq));
+
+	return ret;
 }
 
 static int page_is_consistent(struct zone *zone, struct page *page)
@@ -1959,6 +1967,7 @@ static void __init free_area_init_core(s
 		zone->name = zone_names[j];
 		spin_lock_init(&zone->lock);
 		spin_lock_init(&zone->lru_lock);
+		zone_seqlock_init(zone);
 		zone->zone_pgdat = pgdat;
 		zone->free_pages = 0;
 
diff -puN include/linux/memory_hotplug.h~C6-zone-span_seqlock include/linux/memory_hotplug.h
--- memhotplug/include/linux/memory_hotplug.h~C6-zone-span_seqlock	2005-08-12 07:43:48.000000000 -0700
+++ memhotplug-dave/include/linux/memory_hotplug.h	2005-08-12 07:43:48.000000000 -0700
@@ -16,13 +16,36 @@ void pgdat_resize_lock(struct pglist_dat
 static inline
 void pgdat_resize_unlock(struct pglist_data *pgdat, unsigned long *flags)
 {
-	spin_lock_irqrestore(&pgdat->node_size_lock, *flags);
+	spin_unlock_irqrestore(&pgdat->node_size_lock, *flags);
 }
 static inline
 void pgdat_resize_init(struct pglist_data *pgdat)
 {
 	spin_lock_init(&pgdat->node_size_lock);
 }
+/*
+ * Zone resizing functions
+ */
+static inline unsigned zone_span_seqbegin(struct zone *zone)
+{
+	return read_seqbegin(&zone->span_seqlock);
+}
+static inline int zone_span_seqretry(struct zone *zone, unsigned iv)
+{
+	return read_seqretry(&zone->span_seqlock, iv);
+}
+static inline void zone_span_writelock(struct zone *zone)
+{
+	write_seqlock(&zone->span_seqlock);
+}
+static inline void zone_span_writeunlock(struct zone *zone)
+{
+	write_sequnlock(&zone->span_seqlock);
+}
+static inline void zone_seqlock_init(struct zone *zone)
+{
+	seqlock_init(&zone->span_seqlock);
+}
 #else /* ! CONFIG_MEMORY_HOTPLUG */
 /*
  * Stub functions for when hotplug is off
@@ -30,5 +53,17 @@ void pgdat_resize_init(struct pglist_dat
 static inline void pgdat_resize_lock(struct pglist_data *p, unsigned long *f) {}
 static inline void pgdat_resize_unlock(struct pglist_data *p, unsigned long *f) {}
 static inline void pgdat_resize_init(struct pglist_data *pgdat) {}
-#endif
+
+static inline unsigned zone_span_seqbegin(struct zone *zone)
+{
+	return 0;
+}
+static inline int zone_span_seqretry(struct zone *zone, unsigned iv)
+{
+	return 0;
+}
+static inline void zone_span_writelock(struct zone *zone) {}
+static inline void zone_span_writeunlock(struct zone *zone) {}
+static inline void zone_seqlock_init(struct zone *zone) {}
+#endif /* ! CONFIG_MEMORY_HOTPLUG */
 #endif /* __LINUX_MEMORY_HOTPLUG_H */
diff -puN /dev/null txt
_
