Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317508AbSGJI5g>; Wed, 10 Jul 2002 04:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317512AbSGJI5f>; Wed, 10 Jul 2002 04:57:35 -0400
Received: from holomorphy.com ([66.224.33.161]:32398 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317508AbSGJI5b>;
	Wed, 10 Jul 2002 04:57:31 -0400
Date: Wed, 10 Jul 2002 01:59:17 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: lazy_buddy-2.5.25-1
Message-ID: <20020710085917.GP25360@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements deferred coalescing for the Linux page-level
allocator, or the lazy buddy algorithm. This appears to reduce the
allocator overhead in some AF_UNIX and local TCP connection scenarios
according to LMbench (hopefully I can follow up with numbers soon).

This is a simple forward port of the 2.5.23-based version decoupled
from some of the cleanups previously bundled with it.

TODO:
(1)  make the buddy and deferred lists singly-linked
(2)  convert /proc/fraginfo to seq_file()
(3)  find a better home for /proc/fraginfo somewhere in /proc/
(4)  analyze for cache performance
(5)  use split_free_pages() to recover pages from higher-order
	deferred queues to avoid spuriously failing under fragmentation
(6)  get real benchmark numbers out of the thing
(7)  collect statistics on allocation rates for various orders
(8)  collect statistics on allocation failures for various orders
(9)  collect statistics on allocation failures due to fragmentation
(10) collect qualitative information on long-term fragmentation

Follow-on patch TODO item:
(11) gang preassembly and bulk transfer to and from per-cpu pools


This "release" doesn't feature any real development; it's mostly just a
forward port. In fact, it removes various cleanups tied to prior
releases. For some, this may provide some clarification as to what
the additional mechanics involved are. Gang allocation support will be
decoupled from this, and will be my main focus in the allocator before
coming back to this again.

This patch may also be found at:

ftp://ftp.kernel.org/pub/linux/kernel/people/wli/vm/lazy_buddy/lazy_buddy-2.5.25-1
bk://linux-wli.bkbits.net/lazy_buddy/


Cheers,
Bill


diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/fs/proc/proc_misc.c lazy_buddy/fs/proc/proc_misc.c
--- linux-2.5/fs/proc/proc_misc.c	Tue Jul  9 14:53:54 2002
+++ lazy_buddy/fs/proc/proc_misc.c	Tue Jul  9 14:53:03 2002
@@ -132,6 +132,7 @@
 	struct sysinfo i;
 	int len;
 	struct page_state ps;
+	extern unsigned long nr_deferred_pages(void);
 
 	get_page_state(&ps);
 /*
@@ -159,7 +160,8 @@
 		"SwapTotal:    %8lu kB\n"
 		"SwapFree:     %8lu kB\n"
 		"Dirty:        %8lu kB\n"
-		"Writeback:    %8lu kB\n",
+		"Writeback:    %8lu kB\n"
+		"Deferred:     %8lu kB\n",
 		K(i.totalram),
 		K(i.freeram),
 		K(i.sharedram),
@@ -174,13 +176,30 @@
 		K(i.totalswap),
 		K(i.freeswap),
 		K(ps.nr_dirty),
-		K(ps.nr_writeback)
+		K(ps.nr_writeback),
+		K(nr_deferred_pages())
 		);
 
 	return proc_calc_metrics(page, start, off, count, eof, len);
 #undef K
 }
 
+extern int fragmentation_stats(char *, int);
+static int fragmentation_read_proc(	char *page,
+					char **start,
+					off_t off,
+					int count,
+					int *eof,
+					void *data)
+{
+	int nid, len = 0;
+
+	for (nid = 0; nid < numnodes; ++nid)
+		len += fragmentation_stats(page + len, nid);
+
+	return proc_calc_metrics(page, start, off, count, eof, len);
+}
+
 static int version_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
@@ -550,6 +569,7 @@
 		{"loadavg",     loadavg_read_proc},
 		{"uptime",	uptime_read_proc},
 		{"meminfo",	meminfo_read_proc},
+		{"fraginfo",	fragmentation_read_proc},
 		{"version",	version_read_proc},
 #ifdef CONFIG_PROC_HARDWARE
 		{"hardware",	hardware_read_proc},
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/include/linux/mmzone.h lazy_buddy/include/linux/mmzone.h
--- linux-2.5/include/linux/mmzone.h	Tue Jul  9 14:54:01 2002
+++ lazy_buddy/include/linux/mmzone.h	Tue Jul  9 14:53:10 2002
@@ -20,8 +20,9 @@
 #endif
 
 typedef struct free_area_struct {
-	struct list_head	free_list;
-	unsigned long		*map;
+	unsigned long	globally_free, active, locally_free;
+	list_t		free_list, deferred_pages;
+	unsigned long	*map;
 } free_area_t;
 
 struct pglist_data;
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/mm/bootmem.c lazy_buddy/mm/bootmem.c
--- linux-2.5/mm/bootmem.c	Tue Jul  9 14:54:03 2002
+++ lazy_buddy/mm/bootmem.c	Tue Jul  9 14:53:12 2002
@@ -242,6 +242,7 @@
 	return ret;
 }
 
+extern void forced_coalesce(zone_t *zone);
 static unsigned long __init free_all_bootmem_core(pg_data_t *pgdat)
 {
 	struct page *page = pgdat->node_mem_map;
@@ -288,6 +289,9 @@
 	}
 	total += count;
 	bdata->node_bootmem_map = NULL;
+
+	for (i = 0; i < MAX_NR_ZONES; ++i)
+		forced_coalesce(&pgdat->node_zones[i]);
 
 	return total;
 }
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/mm/page_alloc.c lazy_buddy/mm/page_alloc.c
--- linux-2.5/mm/page_alloc.c	Tue Jul  9 14:54:03 2002
+++ lazy_buddy/mm/page_alloc.c	Tue Jul  9 14:53:12 2002
@@ -10,6 +10,7 @@
  *  Reshaped it to be a zoned allocator, Ingo Molnar, Red Hat, 1999
  *  Discontiguous memory support, Kanoj Sarcar, SGI, Nov 1999
  *  Zone balancing, Kanoj Sarcar, SGI, Jan 2000
+ *  Lazy buddy allocation, William Irwin, IBM, May 2002
  */
 
 #include <linux/config.h>
@@ -78,14 +79,10 @@
  * -- wli
  */
 
+static void FASTCALL(low_level_free(struct page *page, unsigned int order));
 static void FASTCALL(__free_pages_ok (struct page *page, unsigned int order));
 static void __free_pages_ok (struct page *page, unsigned int order)
 {
-	unsigned long index, page_idx, mask, flags;
-	free_area_t *area;
-	struct page *base;
-	zone_t *zone;
-
 	BUG_ON(PagePrivate(page));
 	BUG_ON(page->mapping != NULL);
 	BUG_ON(PageLocked(page));
@@ -101,12 +98,22 @@
 			list_add(&page->list, &current->local_pages);
 			page->index = order;
 			current->nr_local_pages++;
-			goto out;
+			return;
 		}
 	}
 
-	zone = page_zone(page);
+	low_level_free(page, order);
+}
 
+static void FASTCALL(buddy_free(struct page *, int order));
+static void buddy_free(struct page *page, int order)
+{
+	unsigned long index, page_idx, mask;
+	free_area_t *area;
+	struct page *base;
+	zone_t *zone;
+
+	zone = page_zone(page);
 	mask = (~0UL) << order;
 	base = zone->zone_mem_map;
 	page_idx = page - base;
@@ -115,8 +122,6 @@
 	index = page_idx >> (1 + order);
 	area = zone->free_area + order;
 
-	spin_lock_irqsave(&zone->lock, flags);
-	zone->free_pages -= mask;
 	while (mask + (1 << (MAX_ORDER-1))) {
 		struct page *buddy1, *buddy2;
 
@@ -136,15 +141,101 @@
 		BUG_ON(bad_range(zone, buddy1));
 		BUG_ON(bad_range(zone, buddy2));
 		list_del(&buddy1->list);
+		area->globally_free--;
 		mask <<= 1;
 		area++;
 		index >>= 1;
 		page_idx &= mask;
 	}
 	list_add(&(base + page_idx)->list, &area->free_list);
+	area->globally_free++;
+}
+
+/*
+ * Deferred coalescing for the page-level allocator. Each size of memory
+ * block has 3 different variables associated with it:
+ * (1) active			-- granted to a caller
+ * (2) locally free		-- on the deferred coalescing queues
+ * (3) globally free		-- marked on the buddy bitmap
+ *
+ * The algorithm must enforce the invariant that active >= locally_free.
+ * There are three distinct regimes (states) identified by the allocator:
+ *
+ * (1) lazy regime		-- area->active > area->locally_free + 1
+ *	allocate and free from deferred queues
+ * (2) reclaiming regime	-- area->active == area->locally_free + 1
+ *	allocate and free from buddy queues
+ * (3) accelerated regime	-- area->active == area->locally_free
+ *	allocate and free from buddy queues, plus free extra deferred pages
+ */
+static void low_level_free(struct page *page, unsigned int order)
+{
+	zone_t *zone = page_zone(page);
+	unsigned long offset;
+	unsigned long flags;
+	free_area_t *area;
+	struct page *deferred_page;
+
+	spin_lock_irqsave(&zone->lock, flags);
+
+	offset = page - zone->zone_mem_map;
+	area = &zone->free_area[order];
+
+	switch (area->active - area->locally_free) {
+		case 0:
+			/*
+			 * Free a deferred page; this is the accelerated
+			 * regime for page coalescing.
+			 */
+			if (likely(!list_empty(&area->deferred_pages))) {
+				deferred_page = list_entry(area->deferred_pages.next, struct page, list);
+				list_del(&deferred_page->list);
+				area->locally_free--;
+				buddy_free(deferred_page, order);
+			}
+			/*
+			 * Fall through and also free the page we were
+			 * originally asked to free.
+			 */
+		case 1:
+			buddy_free(page, order);
+			break;
+		default:
+			list_add(&page->list, &area->deferred_pages);
+			area->locally_free++;
+			break;
+	}
+
+	area->active -= min(area->active, 1UL);
+	zone->free_pages += 1UL << order;
 	spin_unlock_irqrestore(&zone->lock, flags);
-out:
-	return;
+}
+
+/*
+ * In order satisfy high-order boottime allocations a further pass is
+ * made at boot-time to fully coalesce all pages. Furthermore, swsusp
+ * also seems to want to be able to detect free regions by making use
+ * of full coalescing, and so the functionality is provided here.
+ */
+void forced_coalesce(zone_t *zone)
+{
+	int order;
+	struct page *page;
+	free_area_t *area;
+	list_t *save, *elem;
+
+	if (!zone->size)
+		return;
+
+	for (order = MAX_ORDER - 1; order >= 0; --order) {
+		area = &zone->free_area[order];
+		list_for_each_safe(elem, save, &area->deferred_pages) {
+			page = list_entry(elem, struct page, list);
+			list_del(&page->list);
+			area->locally_free--;
+			buddy_free(page, order);
+		}
+	}
 }
 
 #define MARK_USED(index, order, area) \
@@ -160,6 +251,7 @@
 		area--;
 		high--;
 		size >>= 1;
+		area->globally_free++;
 		list_add(&page->list, &area->free_list);
 		MARK_USED(index, high, area);
 		index += size;
@@ -187,16 +279,20 @@
 	set_page_count(page, 1);
 }
 
-static FASTCALL(struct page * rmqueue(zone_t *zone, unsigned int order));
-static struct page * rmqueue(zone_t *zone, unsigned int order)
+/*
+ * Mark the bitmap checking our buddy, and descend levels breaking off
+ * free fragments in the bitmap along the way. When done, wrap up with
+ * the single pass of expand() to break off the various fragments from
+ * the free lists.
+ */
+static FASTCALL(struct page *buddy_alloc(zone_t *zone, unsigned int order));
+static struct page *buddy_alloc(zone_t *zone, unsigned int order)
 {
 	free_area_t * area = zone->free_area + order;
 	unsigned int curr_order = order;
 	struct list_head *head, *curr;
-	unsigned long flags;
 	struct page *page;
 
-	spin_lock_irqsave(&zone->lock, flags);
 	do {
 		head = &area->free_list;
 		curr = head->next;
@@ -210,10 +306,9 @@
 			index = page - zone->zone_mem_map;
 			if (curr_order != MAX_ORDER-1)
 				MARK_USED(index, curr_order, area);
-			zone->free_pages -= 1UL << order;
+			area->globally_free--;
 
 			page = expand(zone, page, index, order, curr_order, area);
-			spin_unlock_irqrestore(&zone->lock, flags);
 
 			if (bad_range(zone, page))
 				BUG();
@@ -223,11 +318,33 @@
 		curr_order++;
 		area++;
 	} while (curr_order < MAX_ORDER);
-	spin_unlock_irqrestore(&zone->lock, flags);
 
 	return NULL;
 }
 
+/*
+ * split_pages() is much like expand, but operates only on the queues
+ * of deferred coalesced pages.
+ */
+static void FASTCALL(split_pages(zone_t *, struct page *, int, int));
+static void split_pages(zone_t *zone, struct page *page,
+			int page_order, int deferred_order)
+{
+	int split_order;
+	unsigned long split_offset;
+	struct page *split_page;
+
+	split_order = deferred_order - 1;
+	split_offset = 1UL << split_order;
+	while (split_order >= page_order) {
+		split_page = &page[split_offset];
+		list_add(&split_page->list, &zone->free_area[split_order].deferred_pages);
+		zone->free_area[split_order].locally_free++;
+		--split_order;
+		split_offset >>= 1;
+	}
+}
+
 #ifdef CONFIG_SOFTWARE_SUSPEND
 int is_head_of_free_region(struct page *page)
 {
@@ -241,6 +358,7 @@
 	 * suspend anyway, but...
 	 */
 	spin_lock_irqsave(&zone->lock, flags);
+	forced_coalesce(zone);
 	for (order = MAX_ORDER - 1; order >= 0; --order)
 		list_for_each(curr, &zone->free_area[order].free_list)
 			if (page == list_entry(curr, struct page, list)) {
@@ -252,6 +370,81 @@
 }
 #endif /* CONFIG_SOFTWARE_SUSPEND */
 
+/*
+ * low_level_alloc() exports free page search functionality to the
+ * internal VM allocator. It uses the strategy outlined above
+ * low_level_free() in order to decide where to obtain its pages.
+ */
+static FASTCALL(struct page *low_level_alloc(zone_t *, unsigned int));
+static struct page *low_level_alloc(zone_t *zone, unsigned int order)
+{
+	struct page *page;
+	unsigned long flags;
+	free_area_t *area;
+
+	spin_lock_irqsave(&zone->lock, flags);
+
+	area = &zone->free_area[order];
+
+	if (likely(!list_empty(&area->deferred_pages))) {
+		page = list_entry(area->deferred_pages.next, struct page, list);
+		list_del(&page->list);
+		area->locally_free--;
+	} else
+		page = buddy_alloc(zone, order);
+	if (unlikely(!page))
+		goto out;
+	set_page_count(page, 1);
+	area->active++;
+	zone->free_pages -= 1UL << order;
+out:
+	spin_unlock_irqrestore(&zone->lock, flags);
+	return page;
+}
+
+/*
+ * Render fragmentation statistics for /proc/ reporting.
+ * It simply formats the counters maintained by the queueing
+ * discipline in the buffer passed to it.
+ */
+int fragmentation_stats(char *buf, int nid)
+{
+	int order, len = 0;
+	unsigned long flags;
+	zone_t *zone, *node_zones;
+
+	node_zones = NODE_DATA(nid)->node_zones;
+
+	for (zone = node_zones; zone - node_zones < MAX_NR_ZONES; ++zone) {
+		spin_lock_irqsave(&zone->lock, flags);
+		len += sprintf(	buf + len,
+				"Node %d, zone %8s\n",
+				nid,
+				zone->name);
+		len += sprintf(buf + len, "buddy:  ");
+		for (order = 0; order < MAX_ORDER; ++order) {
+			len += sprintf( buf + len,
+					"%6lu ",
+					zone->free_area[order].globally_free);
+		}
+		len += sprintf(buf + len, "\ndefer:  ");
+		for (order = 0; order < MAX_ORDER; ++order) {
+			len += sprintf( buf + len,
+					"%6lu ",
+					zone->free_area[order].locally_free);
+		}
+		len += sprintf(buf + len, "\nactive: ");
+		for (order = 0; order < MAX_ORDER; ++order) {
+			len += sprintf( buf + len,
+					"%6lu ",
+					zone->free_area[order].active);
+		}
+		spin_unlock_irqrestore(&zone->lock, flags);
+		len += sprintf(buf + len, "\n");
+	}
+	return len;
+}
+
 #ifndef CONFIG_DISCONTIGMEM
 struct page *_alloc_pages(unsigned int gfp_mask, unsigned int order)
 {
@@ -335,7 +528,7 @@
 
 		min += z->pages_low;
 		if (z->free_pages > min) {
-			page = rmqueue(z, order);
+			page = low_level_alloc(z, order);
 			if (page)
 				return page;
 		}
@@ -359,7 +552,7 @@
 			local_min >>= 2;
 		min += local_min;
 		if (z->free_pages > min) {
-			page = rmqueue(z, order);
+			page = low_level_alloc(z, order);
 			if (page)
 				return page;
 		}
@@ -375,7 +568,7 @@
 			if (!z)
 				break;
 
-			page = rmqueue(z, order);
+			page = low_level_alloc(z, order);
 			if (page)
 				return page;
 		}
@@ -405,7 +598,7 @@
 
 		min += z->pages_min;
 		if (z->free_pages > min) {
-			page = rmqueue(z, order);
+			page = low_level_alloc(z, order);
 			if (page)
 				return page;
 		}
@@ -537,6 +730,23 @@
 }
 #endif
 
+unsigned long nr_deferred_pages(void)
+{
+	pg_data_t *pgdat;
+	zone_t *node_zones;
+	int i, order;
+	unsigned long pages = 0;
+
+	for (pgdat = pgdat_list; pgdat; pgdat = pgdat->node_next) {
+		node_zones = pgdat->node_zones;
+		for (i = 0; i < MAX_NR_ZONES; ++i) {
+			for (order = 0; order < MAX_ORDER; ++order)
+				pages += node_zones[i].free_area[order].locally_free;
+		}
+	}
+	return pages;
+}
+
 /*
  * Accumulate the page_state information across all CPUs.
  * The result is unavoidably approximate - it can change
@@ -879,6 +1089,7 @@
 		offset += size;
 		for (i = 0; ; i++) {
 			unsigned long bitmap_size;
+			INIT_LIST_HEAD(&zone->free_area[i].deferred_pages);
 
 			INIT_LIST_HEAD(&zone->free_area[i].free_list);
 			if (i == MAX_ORDER-1) {
