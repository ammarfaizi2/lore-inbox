Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318147AbSGMLTu>; Sat, 13 Jul 2002 07:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318149AbSGMLTt>; Sat, 13 Jul 2002 07:19:49 -0400
Received: from holomorphy.com ([66.224.33.161]:30881 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318147AbSGMLTl>;
	Sat, 13 Jul 2002 07:19:41 -0400
Date: Sat, 13 Jul 2002 04:21:28 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Subject: lazy_buddy-2.5.25-4
Message-ID: <20020713112128.GT23693@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After still more prodding here is yet another release of my lazy buddy
algorithm -based deferred coalescing patch for the Linux page allocator.
Basically, other people saw the bugs I postponed fixing on my TODO list
and said "fix it" so here are the TODO items addressed.

At some point I'll be able to let this sit for a while and go back to
finding ways to make highpte_chain not look like a train wreck.

This release features conversion of /proc/fraginfo to seq_file and the
fix for the theoretical bug (never seen in practice) where spurious
allocation failures are reported due to higher-order pages trapped on
deferred queues.

Testboot, kernel compile, tbench, and netperf tested on a 16 cpu i386
machine with 16GB of RAM.

TODO:
(1) make the buddy and deferred lists singly-linked
(2) find a better home for /proc/fraginfo somewhere in /proc/
(3) analyze cache performance
(4) get real benchmark numbers out of the thing as opposed to the
	one-shot few-rounds stuff I've done thus far. Thus far
	benefits for local network bandwidth and latency have been
	seen in lmbench and netperf.
(5) collect statistics on the allocation rates for various orders
(6) collect statistics on the allocation failures for various orders
(7) collect statistics on allocation failures due to frgamentation
(8) collect qualitative information on long-term fragmentation

Follow-on patch TODO item:
(9) integration with upcoming gang allocation patches
(10) gang preassembly and bulk transfer to and from per-cpu pools.

This patch is also available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/wli/vm/lazy_buddy/lazy_buddy-2.5.25-4
bk://linux-wli.bkbits.net/lazy_buddy/


Cheers,
Bill


diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/fs/proc/proc_misc.c lazy_buddy/fs/proc/proc_misc.c
--- linux-2.5/fs/proc/proc_misc.c	Sat Jul 13 00:00:36 2002
+++ lazy_buddy/fs/proc/proc_misc.c	Sat Jul 13 03:13:33 2002
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
@@ -174,13 +176,29 @@
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
 
+extern struct seq_operations fragmentation_op;
+static int fragmentation_open(struct inode *inode, struct file *file)
+{
+	(void)inode;
+	return seq_open(file, &fragmentation_op);
+}
+
+static struct file_operations fragmentation_file_operations = {
+	open:		fragmentation_open,
+	read:		seq_read,
+	llseek:		seq_lseek,
+	release:	seq_release,
+};
+
+
 static int version_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
@@ -585,6 +603,7 @@
 	create_seq_entry("partitions", 0, &proc_partitions_operations);
 	create_seq_entry("interrupts", 0, &proc_interrupts_operations);
 	create_seq_entry("slabinfo",S_IWUSR|S_IRUGO,&proc_slabinfo_operations);
+	create_seq_entry("fraginfo",S_IRUGO, &fragmentation_file_operations);
 #ifdef CONFIG_MODULES
 	create_seq_entry("modules", 0, &proc_modules_operations);
 	create_seq_entry("ksyms", 0, &proc_ksyms_operations);
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/include/linux/mmzone.h lazy_buddy/include/linux/mmzone.h
--- linux-2.5/include/linux/mmzone.h	Sat Jul 13 00:01:23 2002
+++ lazy_buddy/include/linux/mmzone.h	Sat Jul 13 03:14:11 2002
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
--- linux-2.5/mm/bootmem.c	Sat Jul 13 00:01:28 2002
+++ lazy_buddy/mm/bootmem.c	Sat Jul 13 03:14:17 2002
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
--- linux-2.5/mm/page_alloc.c	Sat Jul 13 00:01:28 2002
+++ lazy_buddy/mm/page_alloc.c	Sat Jul 13 03:14:17 2002
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
@@ -210,24 +306,65 @@
 			index = page - zone->zone_mem_map;
 			if (curr_order != MAX_ORDER-1)
 				MARK_USED(index, curr_order, area);
-			zone->free_pages -= 1UL << order;
+			area->globally_free--;
 
 			page = expand(zone, page, index, order, curr_order, area);
-			spin_unlock_irqrestore(&zone->lock, flags);
 
 			if (bad_range(zone, page))
 				BUG();
-			prep_new_page(page);
 			return page;	
 		}
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
+static struct page *FASTCALL(steal_deferred_page(zone_t *, int));
+static struct page *steal_deferred_page(zone_t *zone, int order)
+{
+	struct page *page;
+	free_area_t *area = zone->free_area;
+	int found_order;
+
+	for (found_order = order+1; found_order < MAX_ORDER; ++found_order)
+		if (!list_empty(&area[found_order].deferred_pages))
+			goto found_page;
+
+	return NULL;
+
+found_page:
+	page = list_entry(area[found_order].deferred_pages.next, struct page, list);
+	list_del(&page->list);
+	area[found_order].locally_free--;
+	split_pages(zone, page, order, found_order);
+	return page;
+}
+
 #ifdef CONFIG_SOFTWARE_SUSPEND
 int is_head_of_free_region(struct page *page)
 {
@@ -241,6 +378,7 @@
 	 * suspend anyway, but...
 	 */
 	spin_lock_irqsave(&zone->lock, flags);
+	forced_coalesce(zone);
 	for (order = MAX_ORDER - 1; order >= 0; --order)
 		list_for_each(curr, &zone->free_area[order].free_list)
 			if (page == list_entry(curr, struct page, list)) {
@@ -252,6 +390,42 @@
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
+	if (unlikely(!page)) {
+		page = steal_deferred_page(zone, order);
+		if (likely(!page))
+		goto out;
+	}
+
+	prep_new_page(page);
+	area->active++;
+	zone->free_pages -= 1UL << order;
+out:
+	spin_unlock_irqrestore(&zone->lock, flags);
+	return page;
+}
+
 #ifndef CONFIG_DISCONTIGMEM
 struct page *_alloc_pages(unsigned int gfp_mask, unsigned int order)
 {
@@ -335,7 +509,7 @@
 
 		min += z->pages_low;
 		if (z->free_pages > min) {
-			page = rmqueue(z, order);
+			page = low_level_alloc(z, order);
 			if (page)
 				return page;
 		}
@@ -359,7 +533,7 @@
 			local_min >>= 2;
 		min += local_min;
 		if (z->free_pages > min) {
-			page = rmqueue(z, order);
+			page = low_level_alloc(z, order);
 			if (page)
 				return page;
 		}
@@ -375,7 +549,7 @@
 			if (!z)
 				break;
 
-			page = rmqueue(z, order);
+			page = low_level_alloc(z, order);
 			if (page)
 				return page;
 		}
@@ -405,7 +579,7 @@
 
 		min += z->pages_min;
 		if (z->free_pages > min) {
-			page = rmqueue(z, order);
+			page = low_level_alloc(z, order);
 			if (page)
 				return page;
 		}
@@ -537,6 +711,23 @@
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
+				pages += node_zones[i].free_area[order].locally_free << order;
+		}
+	}
+	return pages;
+}
+
 /*
  * Accumulate the page_state information across all CPUs.
  * The result is unavoidably approximate - it can change
@@ -879,6 +1070,7 @@
 		offset += size;
 		for (i = 0; ; i++) {
 			unsigned long bitmap_size;
+			INIT_LIST_HEAD(&zone->free_area[i].deferred_pages);
 
 			INIT_LIST_HEAD(&zone->free_area[i].free_list);
 			if (i == MAX_ORDER-1) {
@@ -935,3 +1127,74 @@
 }
 
 __setup("memfrac=", setup_mem_frac);
+
+#ifdef CONFIG_PROC_FS
+
+#include <linux/seq_file.h>
+
+static void *frag_start(struct seq_file *m, loff_t *pos)
+{
+	pg_data_t *pgdat;
+	loff_t node = *pos;
+
+	(void)m;
+
+	for (pgdat = pgdat_list; pgdat && node; pgdat = pgdat->node_next)
+		--node;
+
+	return pgdat;
+}
+
+static void *frag_next(struct seq_file *m, void *arg, loff_t *pos)
+{
+	pg_data_t *pgdat = (pg_data_t *)arg;
+
+	(void)m;
+	(*pos)++;
+	return pgdat->node_next;
+}
+
+static void frag_stop(struct seq_file *m, void *arg)
+{
+	(void)m;
+	(void)arg;
+}
+
+/*
+ * Render fragmentation statistics for /proc/ reporting.
+ * It simply formats the counters maintained by the queueing
+ * discipline in the buffer passed to it.
+ */
+static int frag_show(struct seq_file *m, void *arg)
+{
+	pg_data_t *pgdat = (pg_data_t *)arg;
+	zone_t *zone, *node_zones = pgdat->node_zones;
+	unsigned long flags;
+	int order;
+
+	for (zone = node_zones; zone - node_zones < MAX_NR_ZONES; ++zone) {
+		spin_lock_irqsave(&zone->lock, flags);
+		seq_printf(m, "Node %d, zone %8s\n", pgdat->node_id, zone->name);
+		seq_puts(m, "buddy:  ");
+		for (order = 0; order < MAX_ORDER; ++order)
+			seq_printf(m, "%6lu ", zone->free_area[order].globally_free);
+		seq_puts(m, "\ndefer:  ");
+		for (order = 0; order < MAX_ORDER; ++order)
+			seq_printf(m, "%6lu ", zone->free_area[order].locally_free);
+		seq_puts(m, "\nactive: ");
+		for (order = 0; order < MAX_ORDER; ++order)
+			seq_printf(m, "%6lu ", zone->free_area[order].active);
+		spin_unlock_irqrestore(&zone->lock, flags);
+		seq_putc(m, '\n');
+	}
+	return 0;
+}
+
+struct seq_operations fragmentation_op = {
+	start:	frag_start,
+	next:	frag_next,
+	stop:	frag_stop,
+	show:	frag_show,
+};
+
+#endif /* CONFIG_PROC_FS */
