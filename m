Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315251AbSFDRDU>; Tue, 4 Jun 2002 13:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315222AbSFDRDT>; Tue, 4 Jun 2002 13:03:19 -0400
Received: from pizda.ninka.net ([216.101.162.242]:6822 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315251AbSFDRDH>;
	Tue, 4 Jun 2002 13:03:07 -0400
Date: Tue, 04 Jun 2002 09:59:56 -0700 (PDT)
Message-Id: <20020604.095956.25157054.davem@redhat.com>
To: jasonp@boo.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] page coloring for 2.4.18 kernel
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020604.061640.118624496.davem@redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For those interested I forward ported Jason's patch to
2.4.19-pre10, cleaned up a few things, and even added
sparc64 support.

--- drivers/char/Config.in.~1~	Tue Jun  4 06:25:28 2002
+++ drivers/char/Config.in	Tue Jun  4 06:25:32 2002
@@ -212,6 +212,8 @@ if [ "$CONFIG_WATCHDOG" != "n" ]; then
 fi
 endmenu
 
+tristate 'Page Coloring' CONFIG_PAGE_COLORING
+
 if [ "$CONFIG_ARCH_NETWINDER" = "y" ]; then
    tristate 'NetWinder thermometer support' CONFIG_DS1620
    tristate 'NetWinder Button' CONFIG_NWBUTTON
--- drivers/char/Makefile.~1~	Tue Jun  4 06:25:28 2002
+++ drivers/char/Makefile	Tue Jun  4 06:25:32 2002
@@ -268,6 +268,11 @@ ifeq ($(CONFIG_MWAVE),y)
   obj-y += mwave/mwave.o
 endif
 
+ifeq ($(CONFIG_PAGE_COLORING),m)
+  CONFIG_PAGE_COLORING_MODULE=y
+  obj-m += page_color.o
+endif
+
 include $(TOPDIR)/Rules.make
 
 fastdep:
--- drivers/char/page_color.c.~1~	Tue Jun  4 06:32:08 2002
+++ drivers/char/page_color.c	Tue Jun  4 06:25:32 2002
@@ -0,0 +1,167 @@
+/*
+ *	This module implements page coloring, a systematic way
+ * 	to get the most performance out of the expensive cache
+ *	memory your computer has. At present the code is *only*
+ *	to be built as a loadable kernel module.
+ *
+ *	After building the kernel and rebooting, load the module
+ *	and specify the cache size to use, like so:
+ *
+ *	insmod <path to page_color.o> cache_size=X
+ *
+ *	where X is the size of the largest cache your system has.
+ *	For machines with three cache levels (Alpha 21164, AMD K6-III)
+ *	this will be the size in bytes of the L3 cache, and for all
+ *	others it will be the size of the L2 cache. If your system
+ *	doesn't have at least L2 cache, fer cryin' out loud GET SOME!
+ *	When specifying the cache size you can use 'K' or 'M' to signify
+ *	kilobytes or megabytes, respectively. In any case, the cache
+ *	size *must* be a power of two.
+ * 
+ * 	insmod will create a module called 'page_color' which changes
+ *	the way Linux allocates pages from the free list. It is always
+ *	safe to start and stop the module while other processes are running.
+ *
+ *	If linux is configured for a /proc filesystem, the module will
+ *	also create /proc/page_color as a means of reporting statistics.
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/version.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <asm/page.h>
+#include <linux/mm.h>
+#include <linux/proc_fs.h>
+
+extern unsigned int page_miss_count;
+extern unsigned int page_hit_count;
+extern unsigned int page_colors;
+extern unsigned int page_alloc_count;
+extern struct list_head *page_color_table;
+
+void page_color_start(void);
+void page_color_stop(void);
+
+#if defined(__alpha__)
+#define CACHE_SIZE_GUESS (4*1024*1024)
+#elif defined(__i386__)
+#define CACHE_SIZE_GUESS (256*1024)
+#else
+#define CACHE_SIZE_GUESS (1*1024*1024)
+#endif 
+
+#ifdef CONFIG_PROC_FS
+
+int page_color_getinfo(char *buf, char **start, off_t fpos, int length)
+{
+	int i, j, k, count, num_colors;
+	struct list_head *queue, *curr;
+	char *p = buf;
+
+	p += sprintf(p, "colors: %d\n", page_colors);
+	p += sprintf(p, "hits: %d\n", page_hit_count);
+	p += sprintf(p, "misses: %d\n", page_miss_count);
+	p += sprintf(p, "pages allocated: %d\n", page_alloc_count);
+
+	queue = page_color_table;
+	for(i=0; i<MAX_NR_ZONES; i++) {
+		num_colors = page_colors;
+
+		for(j=0; j<MAX_ORDER; j++) {
+			for(k=0; k<num_colors; k++) {
+				count = 0;
+				if (!queue->next)
+					goto getinfo_done;
+
+				list_for_each(curr, queue) {
+					count++;
+				}
+				p += sprintf(p, "%d ", count);
+				queue++;
+			}
+	
+			p += sprintf(p, "\n");
+			if (num_colors > 1)
+				num_colors >>= 1;
+		}
+	}
+
+getinfo_done:
+        return p - buf;
+}
+
+#endif
+
+void cleanup_module(void)
+{
+	printk("page_color: terminating page coloring\n");
+
+#ifdef CONFIG_PROC_FS
+	remove_proc_entry("page_color", NULL);
+#endif
+
+	page_color_stop();
+	kfree(page_color_table);
+}
+
+static char *cache_size;
+MODULE_PARM(cache_size, "s");
+
+int init_module(void)
+{
+	unsigned int cache_size_int;
+	unsigned int alloc_size;
+
+	if (cache_size) {
+		cache_size_int = simple_strtoul(cache_size, 
+					(char **)NULL, 10);
+		if ( strchr(cache_size, 'M') || 
+		     strchr(cache_size, 'm') )
+			cache_size_int *= 1024*1024;
+
+		if ( strchr(cache_size, 'K') || 
+		     strchr(cache_size, 'k') )
+			cache_size_int *= 1024;
+	} 
+	else {
+		cache_size_int = CACHE_SIZE_GUESS;
+	}
+
+	if( (-cache_size_int & cache_size_int) != cache_size_int ) {
+		printk ("page_color: cache size is not a power of two\n");
+		return 1;
+	}
+
+	page_colors = cache_size_int / PAGE_SIZE;
+	page_hit_count = 0;
+	page_miss_count = 0;
+	page_alloc_count = 0;
+	alloc_size = MAX_NR_ZONES * sizeof(struct list_head) *
+				(2 * page_colors + MAX_ORDER);
+	page_color_table = (struct list_head *)kmalloc(alloc_size, GFP_KERNEL);
+	if (!page_color_table) {
+		printk("page_color: memory allocation failed\n");
+		return 1;
+	}
+	memset(page_color_table, 0, alloc_size);
+
+	page_color_start();
+
+#ifdef CONFIG_PROC_FS
+	create_proc_info_entry("page_color", 0, NULL, page_color_getinfo);
+#endif
+
+	printk("page_color: starting with %d colors\n", page_colors );
+	return 0;
+}
--- include/linux/mmzone.h.~1~	Tue Jun  4 06:25:28 2002
+++ include/linux/mmzone.h	Tue Jun  4 06:25:32 2002
@@ -22,6 +22,12 @@
 typedef struct free_area_struct {
 	struct list_head	free_list;
 	unsigned long		*map;
+
+#ifdef CONFIG_PAGE_COLORING_MODULE
+	unsigned long		count;
+	struct list_head	*color_list;
+#endif
+
 } free_area_t;
 
 struct pglist_data;
--- include/linux/sched.h.~1~	Tue Jun  4 06:25:28 2002
+++ include/linux/sched.h	Tue Jun  4 06:25:32 2002
@@ -418,6 +418,11 @@ struct task_struct {
 
 /* journalling filesystem info */
 	void *journal_info;
+
+#ifdef CONFIG_PAGE_COLORING_MODULE
+	unsigned int color_init;
+	unsigned int target_color;
+#endif
 };
 
 /*
--- kernel/ksyms.c.~1~	Tue Jun  4 06:25:28 2002
+++ kernel/ksyms.c	Tue Jun  4 06:25:32 2002
@@ -565,3 +565,21 @@ EXPORT_SYMBOL(init_task_union);
 
 EXPORT_SYMBOL(tasklist_lock);
 EXPORT_SYMBOL(pidhash);
+
+#ifdef CONFIG_PAGE_COLORING_MODULE
+extern unsigned int page_miss_count;
+extern unsigned int page_hit_count;
+extern unsigned int page_alloc_count;
+extern unsigned int page_colors;
+extern struct list_head *page_color_table;
+void page_color_start(void);
+void page_color_stop(void);
+
+EXPORT_SYMBOL_NOVERS(page_miss_count);
+EXPORT_SYMBOL_NOVERS(page_hit_count);
+EXPORT_SYMBOL_NOVERS(page_alloc_count);
+EXPORT_SYMBOL_NOVERS(page_colors);
+EXPORT_SYMBOL_NOVERS(page_color_table);
+EXPORT_SYMBOL_NOVERS(page_color_start);
+EXPORT_SYMBOL_NOVERS(page_color_stop);
+#endif
--- mm/page_alloc.c.~1~	Tue Jun  4 06:25:28 2002
+++ mm/page_alloc.c	Tue Jun  4 06:34:50 2002
@@ -48,6 +48,290 @@ static int zone_balance_max[MAX_NR_ZONES
 	|| ((zone) != page_zone(page))					\
 )
 
+
+#ifdef CONFIG_PAGE_COLORING_MODULE
+
+#ifdef CONFIG_DISCONTIGMEM
+#error "Page coloring implementation cannot handle NUMA architectures"
+#endif
+
+unsigned int page_coloring = 0;
+unsigned int page_miss_count;
+unsigned int page_hit_count;
+unsigned int page_alloc_count;
+unsigned int page_colors = 0;
+struct list_head *page_color_table;
+
+#define COLOR(x)  ((x) & cache_mask)
+
+void page_color_start(void)
+{
+	/* Empty the free list in each zone. For each
+	   queue in the free list, transfer the entries
+	   in the queue over to another set of queues
+	   (the destination queue is determined by the 
+	   color of each entry). */
+
+	int i, j, k;
+	unsigned int num_colors, cache_mask;
+	unsigned long index, flags;
+	struct list_head *color_list_start, *head, *curr;
+	free_area_t *area;
+	struct page *page;
+	zone_t *zone;
+	pg_data_t *pgdata;
+ 
+ 	cache_mask = page_colors - 1;
+	color_list_start = page_color_table;
+	pgdata = &contig_page_data;
+
+	/* Stop all allocation of free pages while the
+	   reshuffling is taking place */
+
+	local_irqsave(flags);
+	for(i = 0; i < MAX_NR_ZONES; i++) {
+		zone = pgdata->node_zones + i;
+		if (zone->size)
+			spin_lock(&zone->lock);
+	}
+
+	for(i = 0; i < MAX_NR_ZONES; i++) {
+		num_colors = page_colors;
+		zone = pgdata->node_zones + i;
+
+		if (!zone->size)
+			continue;
+
+		for(j = 0; j < MAX_ORDER; j++) {
+			area = zone->free_area + j;
+			area->count = 0;
+			area->color_list = color_list_start;
+			head = &area->free_list;
+			curr = head->next;
+
+			for(k = 0; k < num_colors; k++) 
+				INIT_LIST_HEAD(color_list_start + k);
+
+			while(curr != head) {
+				page = list_entry(curr, struct page, list);
+				list_del(curr);
+				index = page - zone->zone_mem_map;
+				list_add_head(curr, (area->color_list +
+						     (COLOR(index) >> j)));
+				area->count++;
+				curr = head->next;
+			}
+	
+			color_list_start += num_colors;
+			if (num_colors > 1)
+				num_colors >>= 1;
+		}
+	}
+
+	/* Allocation of free pages can continue */
+
+	page_coloring = 1;
+	for(i = 0; i < MAX_NR_ZONES; i++) {
+		zone = pgdata->node_zones + i;
+		if (zone->size)
+			spin_unlock(&zone->lock);
+	}
+	local_irqrestore(flags);
+}
+
+void page_color_stop(void)
+{
+	/* Reverse the operation of page_color_start(). */
+
+	int i, j, k;
+	unsigned int num_colors;
+	unsigned long flags;
+	struct list_head *head, *curr;
+	free_area_t *area;
+	zone_t *zone;
+	pg_data_t *pgdata;
+ 
+	pgdata = &contig_page_data;
+
+	local_irqsave(flags);
+	for(i = 0; i < MAX_NR_ZONES; i++) {
+		zone = pgdata->node_zones + i;
+		if (zone->size)
+			spin_lock(&zone->lock);
+	}
+
+	for(i = 0; i < MAX_NR_ZONES; i++) {
+		num_colors = page_colors;
+		zone = pgdata->node_zones + i;
+
+		if (!zone->size)
+			continue;
+
+		for(j = 0; j<MAX_ORDER; j++) {
+			area = zone->free_area + j;
+			area->count = 0;
+
+			for(k = 0; k < num_colors; k++) {
+				head = area->color_list + k;
+				curr = head->next;
+				while(curr != head) {
+					list_del(curr);
+					list_add_head(curr, 
+						      &area->free_list);
+					curr = list_next(head);
+				}
+			}
+	
+			if (num_colors > 1)
+				num_colors >>= 1;
+		}
+	}
+
+	page_coloring = 0;
+	for(i = 0; i < MAX_NR_ZONES; i++) {
+		zone = pgdata->node_zones + i;
+		if (zone->size)
+			spin_unlock(&zone->lock);
+	}
+	local_irqrestore(flags);
+}
+
+unsigned int rand_carry = 0x01234567;
+unsigned int rand_seed = 0x89abcdef;
+
+#define MULT 2131995753
+
+static inline unsigned int get_rand(void) 
+{
+	/* A multiply-with-carry random number generator by 
+	   George Marsaglia. The period is about 1<<63, and
+	   each call to get_rand() returns 32 random bits */
+
+	unsigned long long prod;
+
+	prod = (unsigned long long)rand_seed * 
+	       (unsigned long long)MULT + 
+	       (unsigned long long)rand_carry;
+	rand_seed = (unsigned int)prod;
+	rand_carry = (unsigned int)(prod >> 32);
+
+	return rand_seed;
+}
+
+static struct page *alloc_pages_by_color(zone_t *zone, unsigned int order)
+{
+	unsigned int i;
+	unsigned int mask, color;
+	unsigned long page_idx;
+	free_area_t *area;
+	struct list_head *curr, *head;
+	struct page *page;
+ 	unsigned int cache_mask = page_colors - 1;
+
+	/* If this process hasn't asked for free pages
+	   before, assign it a random starting color. */
+
+	if (current->color_init != current->pid) {
+		current->color_init = current->pid;
+		current->target_color = COLOR(get_rand());
+	}
+
+	/* Round the target color to look for up to the
+	   next 1<<order boundary. */
+
+	mask = (1 << order) - 1;
+	color = current->target_color;
+	color = COLOR((color + mask) & ~mask);
+
+	/* Find out early if there are no free pages at all. */
+
+	for(i = order; i < MAX_ORDER; i++)
+		if (zone->free_area[i].count)
+			break;
+	
+	if (i == MAX_ORDER) 
+		return NULL;
+
+	/* The memory allocation is guaranteed to succeed
+	   (although we may not find the correct color) */
+
+	while(1) {
+		area = zone->free_area + order;
+		for(i = order; i < MAX_ORDER; i++) {
+			head = area->color_list + (color >> i);
+			curr = head->next;
+			if (curr != head)
+				goto alloc_page_done;
+			area++;
+		}
+
+		page_miss_count++;
+		color = COLOR(color + (1<<order));
+	} 
+
+alloc_page_done:
+	page = list_entry(curr, struct page, list);
+	if (BAD_RANGE(zone,page))
+		BUG();
+
+	list_del(curr);
+	page_idx = page - zone->zone_mem_map;
+	zone->free_pages -= 1 << order;
+	area->count--;
+
+	if (i < (MAX_ORDER - 1))
+		__change_bit(page_idx >> (1+i), area->map);
+
+	while (i > order) {
+
+		/* Return 1<<order contiguous pages out of 
+		   the 1<<i available now. Without page coloring
+		   it would suffice to keep chopping the number of
+		   pages in half and return the last 1<<order of
+		   them. Here, the bottom bits of the index to 
+		   return must match the target color. We have to 
+		   keep chopping 1<<i in half but we can
+		   only ignore the halves that don't match the 
+		   bit pattern of the target color. */
+
+		i--;
+		area--;
+		mask = 1 << i;
+		area->count++;
+		__change_bit(page_idx >> (1+i), area->map);
+		if (color & mask) {
+			if (BAD_RANGE(zone,page + mask))
+				BUG();
+
+			list_add_head(&page->list, (area->color_list +
+						    (COLOR(page_idx) >> i)));
+			page_idx += mask;
+			page += mask;
+		} else {
+			list_add_head(&(page + mask)->list, 
+				      (area->color_list + 
+				       (COLOR(page_idx + mask) >> i)));
+		}
+	}
+
+	set_page_count(page, 1);
+
+	if (BAD_RANGE(zone,page))
+		BUG();
+	if (PageLRU(page))
+		BUG();
+	if (PageActive(page))
+		BUG();
+
+	current->target_color = COLOR(color + (1<<order));
+	page_hit_count++;
+	page_alloc_count += 1 << order;
+	return page;
+}
+
+#endif	/* CONFIG_PAGE_COLORING_MODULE */
+
+
 /*
  * Freeing function for a buddy system allocator.
  *
@@ -139,12 +423,26 @@ static void __free_pages_ok (struct page
 		if (BAD_RANGE(zone,buddy2))
 			BUG();
 
+#ifdef CONFIG_PAGE_COLORING_MODULE
+		area->count--;
+		order++;
+#endif
 		list_del(&buddy1->list);
 		mask <<= 1;
 		area++;
 		index >>= 1;
 		page_idx &= mask;
 	}
+
+#ifdef CONFIG_PAGE_COLORING_MODULE
+	if (page_coloring == 1) {
+		unsigned long cache_mask = page_colors - 1;
+		list_add_head(&(base + page_idx)->list, 
+			      area->color_list + (COLOR(page_idx) >> order));
+		spin_unlock_irqrestore(&zone->lock, flags);
+		return;
+	}
+#endif
 	list_add(&(base + page_idx)->list, &area->free_list);
 
 	spin_unlock_irqrestore(&zone->lock, flags);
@@ -195,6 +493,15 @@ static struct page * rmqueue(zone_t *zon
 	struct page *page;
 
 	spin_lock_irqsave(&zone->lock, flags);
+
+#ifdef CONFIG_PAGE_COLORING_MODULE
+	if (page_coloring == 1) {
+		page = alloc_pages_by_color(zone, order);
+		spin_unlock_irqrestore(&zone->lock, flags);
+		return page;
+	}
+#endif
+
 	do {
 		head = &area->free_list;
 		curr = head->next;
