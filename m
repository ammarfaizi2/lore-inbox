Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272988AbRIIR2J>; Sun, 9 Sep 2001 13:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272989AbRIIR2A>; Sun, 9 Sep 2001 13:28:00 -0400
Received: from fenrus.demon.co.uk ([158.152.228.152]:54761 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S272988AbRIIR1q>;
	Sun, 9 Sep 2001 13:27:46 -0400
Message-Id: <m15g8NB-000QGIC@amadeus.home.nl>
Date: Sun, 9 Sep 2001 18:27:57 +0100 (BST)
From: arjan@fenrus.demon.nl
To: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Purpose of the mm/slab.c changes
cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0109090952380.14365-100000@penguin.transmeta.com>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0109090952380.14365-100000@penguin.transmeta.com> you wrote:

> Case (b) implies that the page allocator might also should also find
> per-CPU LIFO queues in front of the actual allocator useful. That might
> certainly be worth-while looking into - although it would also increase
> the risk of fragementation.

Hi,

Ingo Molnar did such a patch already; attached below.
This yields a 1.5% improvement on a 4 way machine using Oracle, more for
other applications (as the oracle tests is also IO bound).

Greetings,
   Arjan van de Ven


diff -urN linux.org/include/linux/mmzone.h linux/include/linux/mmzone.h
--- linux.org/include/linux/mmzone.h	Wed Aug 15 17:21:11 2001
+++ linux/include/linux/mmzone.h	Tue Sep  4 08:12:37 2001
@@ -7,12 +7,13 @@
 #include <linux/config.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
+#include <linux/smp.h>
 
 /*
  * Free memory management - zoned buddy allocator.
  */
 
-#define MAX_ORDER 10
+#define MAX_ORDER 11
 
 typedef struct free_area_struct {
 	struct list_head	free_list;
@@ -21,6 +22,14 @@
 
 struct pglist_data;
 
+#define MAX_PER_CPU_PAGES 64
+
+typedef struct per_cpu_pages_s {
+	int nr_pages;
+	int max_nr_pages;
+	struct list_head head;
+} __attribute__((aligned(L1_CACHE_BYTES))) per_cpu_t;
+
 /*
  * On machines where it is needed (eg PCs) we divide physical memory
  * into multiple physical zones. On a PC we have 3 zones:
@@ -33,6 +42,7 @@
 	/*
 	 * Commonly accessed fields:
 	 */
+	per_cpu_t		cpu_pages [NR_CPUS];
 	spinlock_t		lock;
 	unsigned long		free_pages;
 	unsigned long		inactive_clean_pages;
diff -urN linux.org/mm/page_alloc.c linux/mm/page_alloc.c
--- linux.org/mm/page_alloc.c	Thu Aug 16 12:43:02 2001
+++ linux/mm/page_alloc.c	Tue Sep  4 08:12:37 2001
@@ -7,6 +7,7 @@
  *  Reshaped it to be a zoned allocator, Ingo Molnar, Red Hat, 1999
  *  Discontiguous memory support, Kanoj Sarcar, SGI, Nov 1999
  *  Zone balancing, Kanoj Sarcar, SGI, Jan 2000
+ *  Per-CPU page pool, Ingo Molnar, Red Hat, 2001
  */
 
 #include <linux/config.h>
@@ -67,8 +68,16 @@
 	unsigned long index, page_idx, mask, flags;
 	free_area_t *area;
 	struct page *base;
+	per_cpu_t *per_cpu;
 	zone_t *zone;
 
+	/*
+	 * This late check is safe because reserved pages do not
+	 * have a valid page->count. This trick avoids overhead
+	 * in __free_pages().
+	 */
+	if (PageReserved(page))
+		return;
 	if (page->buffers)
 		BUG();
 	if (page->mapping)
@@ -102,7 +111,18 @@
 
 	area = zone->free_area + order;
 
-	spin_lock_irqsave(&zone->lock, flags);
+	per_cpu = zone->cpu_pages + smp_processor_id();
+
+	__save_flags(flags);
+	__cli();
+	if (!order && (per_cpu->nr_pages < per_cpu->max_nr_pages) && (!free_shortage())) {
+		list_add(&page->list, &per_cpu->head);
+		per_cpu->nr_pages++;
+		__restore_flags(flags);
+		return;
+	}
+
+	spin_lock(&zone->lock);
 
 	zone->free_pages -= mask;
 
@@ -169,16 +189,35 @@
 	return page;
 }
 
+
 static FASTCALL(struct page * rmqueue(zone_t *zone, unsigned long order));
 static struct page * rmqueue(zone_t *zone, unsigned long order)
 {
+	per_cpu_t *per_cpu = zone->cpu_pages + smp_processor_id();
 	free_area_t * area = zone->free_area + order;
 	unsigned long curr_order = order;
 	struct list_head *head, *curr;
 	unsigned long flags;
 	struct page *page;
+	int threshold=0;
 
-	spin_lock_irqsave(&zone->lock, flags);
+	if (!(current->flags & PF_MEMALLOC)) threshold = per_cpu->max_nr_pages/8;
+	__save_flags(flags);
+	__cli();
+
+	if (!order && (per_cpu->nr_pages>threshold)) {
+		if (list_empty(&per_cpu->head))
+			BUG();
+		page = list_entry(per_cpu->head.next, struct page, list);
+		list_del(&page->list);
+		per_cpu->nr_pages--;
+		__restore_flags(flags);
+
+		set_page_count(page, 1);
+		return page;
+	}
+
+	spin_lock(&zone->lock);
 	do {
 		head = &area->free_list;
 		curr = memlist_next(head);
@@ -534,7 +573,7 @@
 
 void __free_pages(struct page *page, unsigned long order)
 {
-	if (!PageReserved(page) && put_page_testzero(page))
+	if (put_page_testzero(page))
 		__free_pages_ok(page, order);
 }
 
@@ -796,6 +835,7 @@
 
 	offset = lmem_map - mem_map;	
 	for (j = 0; j < MAX_NR_ZONES; j++) {
+		int k;
 		zone_t *zone = pgdat->node_zones + j;
 		unsigned long mask;
 		unsigned long size, realsize;
@@ -807,6 +847,18 @@
 		printk("zone(%lu): %lu pages.\n", j, size);
 		zone->size = size;
 		zone->name = zone_names[j];
+
+		for (k = 0; k < NR_CPUS; k++) {
+			per_cpu_t *per_cpu = zone->cpu_pages + k;
+
+			INIT_LIST_HEAD(&per_cpu->head);
+			per_cpu->max_nr_pages = realsize / smp_num_cpus / 128;
+			if (per_cpu->max_nr_pages > MAX_PER_CPU_PAGES)
+				per_cpu->max_nr_pages = MAX_PER_CPU_PAGES;
+			else
+				if (!per_cpu->max_nr_pages)
+					per_cpu->max_nr_pages = 1;
+		}
 		zone->lock = SPIN_LOCK_UNLOCKED;
 		zone->zone_pgdat = pgdat;
 		zone->free_pages = 0;
