Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288842AbSAIFtY>; Wed, 9 Jan 2002 00:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288843AbSAIFtH>; Wed, 9 Jan 2002 00:49:07 -0500
Received: from boo-mda02.boo.net ([216.200.67.22]:64519 "EHLO
	boo-mda02.boo.net") by vger.kernel.org with ESMTP
	id <S288842AbSAIFsx>; Wed, 9 Jan 2002 00:48:53 -0500
Message-Id: <3.0.6.32.20020109005455.007bf4d0@boo.net>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Wed, 09 Jan 2002 00:54:55 -0500
To: linux-kernel@vger.kernel.org
From: Jason Papadopoulos <jasonp@boo.net>
Subject: [PATCH] page coloring for the 2.2.20 kernel
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello. The following patch modifies the free list handling in the
2.2.20 kernel so that round-robin page coloring is performed.

The code seems to be stable. It's fast, handles allocation of 
contiguous pages by color, and uses the hierarchical nature of the
free list to manufacture pages of the correct color when they are
not queued up already.

On an Alpha with a 2MB L2 cache, kernel compiles are 1-2% faster
and number crunching code that allocates big arrays runs much
faster and more reliably.

If somebody can try out the patch on other than an Alpha, or can
throw benchmarks at it, I'd be grateful. The 2.4 series kernel seems
to use the same methods to allocate pages, so in principle the same
modifications apply.

Please copy responses to this address, since I'm not subscribed to
LKML.

Thanks,
jasonp

-------------------------------------------------------------------
diff -ruN linux-2.2.20/drivers/char/Config.in
linux-2.2.20a/drivers/char/Config.in
--- linux-2.2.20/drivers/char/Config.in	Mon Dec 10 02:17:35 2001
+++ linux-2.2.20a/drivers/char/Config.in	Wed Dec 19 00:42:55 2001
@@ -118,6 +118,7 @@
   endmenu
 fi
 
+tristate 'Page Coloring' CONFIG_PAGE_COLORING
 
 tristate '/dev/nvram support' CONFIG_NVRAM
 bool 'Enhanced Real Time Clock Support' CONFIG_RTC
diff -ruN linux-2.2.20/drivers/char/Makefile
linux-2.2.20a/drivers/char/Makefile
--- linux-2.2.20/drivers/char/Makefile	Mon Dec 10 02:17:35 2001
+++ linux-2.2.20a/drivers/char/Makefile	Sat Dec 22 11:12:18 2001
@@ -729,6 +729,11 @@
 M_OBJS          += $(sort $(filter     $(module-list), $(obj-m)))
 
 
+ifeq ($(CONFIG_PAGE_COLORING),m)
+  CONFIG_PAGE_COLORING_MODULE=y
+  M_OBJS += page_color.o
+endif
+
 include $(TOPDIR)/Rules.make
 
 fastdep:
diff -ruN linux-2.2.20/drivers/char/page_color.c
linux-2.2.20a/drivers/char/page_color.c
--- linux-2.2.20/drivers/char/page_color.c	Wed Dec 31 19:00:00 1969
+++ linux-2.2.20a/drivers/char/page_color.c	Tue Jan  8 01:04:52 2002
@@ -0,0 +1,166 @@
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
+ *	the way Linux allocates pages from the free list. Once a page 
+ *	is given to another process the page coloring code will forget 
+ *	about it; thus it's always safe to start and stop the module 
+ *	while other processes are running.
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
+#include <linux/malloc.h>
+#include <asm/page.h>
+#include <linux/mm.h>
+#include <linux/proc_fs.h>
+
+extern unsigned int page_coloring;
+extern unsigned int page_miss_count;
+extern unsigned int page_hit_count;
+extern unsigned int page_colors;
+extern unsigned long *page_color_table;
+extern spinlock_t page_alloc_lock;
+
+void fill_color_pool(void);
+void empty_color_pool(void);
+unsigned int page_color_alloc(void);
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
+int page_color_getinfo(char *buf, char **start, off_t fpos, 
+			int length, int dummy)
+{
+        char *p = buf;
+
+        p += sprintf(p, "colors: %d\n", page_colors);
+        p += sprintf(p, "hits: %d\n", page_hit_count);
+        p += sprintf(p, "misses: %d\n", page_miss_count);
+
+        return p - buf;
+}
+
+static struct proc_dir_entry page_color_proc_entry = {
+        0, 
+	10, 
+	"page_color", 
+	S_IFREG | S_IRUGO, 
+	1, 0, 0, 
+	0, 0, 
+	page_color_getinfo
+};
+
+#endif
+
+
+#define	page_color_init	init_module
+
+void cleanup_module(void)
+{
+	unsigned long flags;
+
+	printk("page_color: terminating page coloring\n");
+
+#ifdef CONFIG_PROC_FS
+	proc_unregister( &proc_root, page_color_proc_entry.low_ino );
+#endif
+
+	spin_lock_irqsave(&page_alloc_lock, flags);
+	empty_color_pool();
+	page_coloring = 0;
+	spin_unlock_irqrestore(&page_alloc_lock, flags);
+
+	kfree(page_color_table);
+}
+
+static char *cache_size;
+MODULE_PARM(cache_size, "s");
+
+__initfunc(int page_color_init(void))
+{
+	unsigned int cache_size_int;
+	unsigned int alloc_size;
+	unsigned long flags;
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
+	alloc_size = page_color_alloc();
+	page_color_table = (unsigned long *)kmalloc(alloc_size, GFP_KERNEL);
+	if (!page_color_table) {
+		printk("page_color: memory allocation failed\n");
+		return 1;
+	}
+	memset(page_color_table, 0, alloc_size);
+
+ 	spin_lock_irqsave(&page_alloc_lock, flags);
+	fill_color_pool();
+	page_coloring = 1;
+ 	spin_unlock_irqrestore(&page_alloc_lock, flags);
+
+#ifdef CONFIG_PROC_FS
+	proc_register( &proc_root, &page_color_proc_entry );
+#endif
+
+	printk("page_color: starting with %d colors\n", page_colors );
+	return 0;
+}
diff -ruN linux-2.2.20/include/linux/sched.h
linux-2.2.20a/include/linux/sched.h
--- linux-2.2.20/include/linux/sched.h	Mon Dec 10 02:27:47 2001
+++ linux-2.2.20a/include/linux/sched.h	Tue Jan  1 16:45:52 2002
@@ -353,6 +353,11 @@
 
 /* oom handling */
 	int oom_kill_try;
+
+#ifdef CONFIG_PAGE_COLORING_MODULE
+	unsigned int color_init;
+	unsigned int color_offset;
+#endif
 };
 
 /*
diff -ruN linux-2.2.20/kernel/ksyms.c linux-2.2.20a/kernel/ksyms.c
--- linux-2.2.20/kernel/ksyms.c	Mon Dec 10 02:17:38 2001
+++ linux-2.2.20a/kernel/ksyms.c	Mon Jan  7 21:09:21 2002
@@ -447,4 +447,24 @@
 EXPORT_SYMBOL(_etext); 
 EXPORT_SYMBOL(module_list); 
 
+#ifdef CONFIG_PAGE_COLORING_MODULE
+extern unsigned int page_coloring;
+extern unsigned int page_miss_count;
+extern unsigned int page_hit_count;
+extern unsigned int page_colors;
+extern unsigned long *page_color_table;
+extern spinlock_t page_alloc_lock;
+void fill_color_pool(void);
+void empty_color_pool(void);
+unsigned int page_color_alloc(void);
 
+EXPORT_SYMBOL_NOVERS(page_coloring);
+EXPORT_SYMBOL_NOVERS(page_miss_count);
+EXPORT_SYMBOL_NOVERS(page_hit_count);
+EXPORT_SYMBOL_NOVERS(page_colors);
+EXPORT_SYMBOL_NOVERS(page_color_table);
+EXPORT_SYMBOL_NOVERS(page_alloc_lock);
+EXPORT_SYMBOL_NOVERS(fill_color_pool);
+EXPORT_SYMBOL_NOVERS(empty_color_pool);
+EXPORT_SYMBOL_NOVERS(page_color_alloc);
+#endif
diff -ruN linux-2.2.20/mm/page_alloc.c linux-2.2.20a/mm/page_alloc.c
--- linux-2.2.20/mm/page_alloc.c	Fri Mar 30 19:51:18 2001
+++ linux-2.2.20a/mm/page_alloc.c	Mon Jan  7 22:36:42 2002
@@ -74,6 +74,257 @@
 	prev->next = next;
 }
 
+#ifdef CONFIG_PAGE_COLORING_MODULE
+
+unsigned int page_coloring = 0;
+unsigned int page_miss_count;
+unsigned int page_hit_count;
+unsigned int page_colors = 0;
+struct free_area_struct *page_color_table;
+struct free_area_struct *queues[NR_MEM_TYPES][NR_MEM_LISTS];
+
+#define COLOR(x)  ((x) & cache_mask)
+
+unsigned int page_color_alloc(void)
+{
+	return NR_MEM_TYPES * sizeof(struct free_area_struct) *
+				( 2 * page_colors + NR_MEM_LISTS );
+}
+
+void fill_color_pool(void)
+{
+	/* For each of the NR_MEM_LISTS queues in
+	   free_area[], move the queued pages into
+	   a separate array of queues, one queue per
+	   distinct page color. empty_color_pool()
+	   reverses the process.
+	   
+	   This code and empty_color_pool() must be
+	   called atomically. */
+
+	int i, j, k;
+	unsigned int num_colors, cache_mask;
+	unsigned long map_nr;
+	struct free_area_struct *area, *old_area, **qptr;
+	struct page *page;
+ 
+ 	cache_mask = page_colors - 1;
+	area = page_color_table;
+
+	for(k = 0; k < NR_MEM_TYPES; k++) {
+		num_colors = page_colors;
+		qptr = queues[k];
+		old_area = free_area[k];
+
+		for(i = 0; i<NR_MEM_LISTS; i++) {
+			qptr[i] = area;
+			for(j = 0; j < num_colors; j++) {
+				init_mem_queue(area + j);
+				area[j].map = old_area->map;
+				area[j].count = 0;
+			}
+	
+			for(j = 0; j < old_area->count; j++) {
+				page = memory_head(old_area);
+				page = page->next;
+				remove_mem_queue(page);
+				map_nr = page - mem_map;
+				add_mem_queue(area + 
+					(COLOR(map_nr) >> i), page);
+			}
+	
+			old_area++;
+			area += num_colors;
+			if (num_colors > 1)
+				num_colors >>= 1;
+		}
+	}
+}
+
+void empty_color_pool(void)
+{
+	int i, j, k, m;
+	unsigned int num_colors;
+	struct free_area_struct *area, *old_area, **qptr;
+	struct page *page;
+ 
+	for(m = 0; m < NR_MEM_TYPES; m++) {
+ 		old_area = free_area[m];
+		qptr = queues[m];
+		num_colors = page_colors;
+
+		for(i = 0; i < NR_MEM_LISTS; i++) {
+			area = qptr[i];
+			old_area->count = 0;
+
+			for(j = 0; j < num_colors; j++) {
+				for(k = 0; k < area[j].count; k++) {
+					page = memory_head(area + j);
+					page = page->next;
+					remove_mem_queue(page);
+					add_mem_queue(old_area, page);
+				}
+			}
+			old_area++;
+			if (num_colors > 1)
+				num_colors >>= 1;
+		}
+	}
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
+unsigned long alloc_page_by_color(unsigned long order, unsigned long type)
+{
+	unsigned int i;
+	unsigned int mask, color;
+	struct free_area_struct *area, *old_area, **qptr;
+	struct page *prev, *ret;
+	unsigned long map_nr;
+ 	unsigned int cache_mask = page_colors - 1;
+
+	/* If this process hasn't asked for free pages
+	   before, assign it a random starting color. */
+
+	if (current->color_init != current->pid) {
+		current->color_init = current->pid;
+		current->color_offset = COLOR(get_rand());
+	}
+
+	/* Round the target color to look for up to the
+	   next 1<<order boundary. */
+
+	mask = (1 << order) - 1;
+	color = current->color_offset;
+	color = COLOR((color + mask) & ~mask);
+	current->color_offset = color;
+
+	/* Find out early if there are no free pages at all. */
+
+	qptr = queues[type];
+	old_area = free_area[type];
+
+	for(i = order; i < NR_MEM_LISTS; i++)
+		if (old_area[i].count)
+			break;
+	
+	if (i == NR_MEM_LISTS)
+		return 0;
+
+	/* The memory allocation is guaranteed to succeed
+	   (although we may not find the correct color) */
+
+	while(1) {
+		for(i = order; i < NR_MEM_LISTS; i++) {
+			area = qptr[i] + (color >> i);
+			if (area->count)
+				goto alloc_page_done;
+		}
+
+		page_miss_count++;
+		color = COLOR(color + (1<<order));
+	} 
+
+alloc_page_done:
+	prev = memory_head(area);
+	ret = prev->next;
+	(prev->next = ret->next)->prev = prev;
+	map_nr = ret - mem_map;
+	change_bit(map_nr >> (1+i), area->map);
+	nr_free_pages -= 1 << order;
+	area->count--;
+	old_area[i].count--;
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
+		mask = 1 << i;
+		area = qptr[i];
+		old_area[i].count++;
+		change_bit(map_nr >> (1+i), area->map);
+		if (color & mask) {
+			add_mem_queue(area + (COLOR(map_nr) >> i), ret);
+			map_nr += mask;
+			ret += mask;
+		}
+		else {
+			add_mem_queue(area + (COLOR(map_nr + mask) >> i), 
+							ret + mask);
+		}
+	}
+	atomic_set(&ret->count, 1);
+	current->color_offset = COLOR(color + (1<<order));
+	page_hit_count++;
+	return PAGE_OFFSET + (map_nr << PAGE_SHIFT);
+}
+
+void free_pages_by_color(unsigned long map_nr, unsigned long mask,
+			unsigned long order, unsigned long index,
+			unsigned long type)
+{
+	/* Works in the same way as __free_pages_ok, 
+	   except that the mem_queue operations are 
+	   color-dependent. */
+	
+	int i;
+	struct free_area_struct *area, *old_area, **qptr;
+ 	unsigned int cache_mask = page_colors - 1;
+
+	i = order;
+	old_area = free_area[type];
+	qptr = queues[type];
+	area = qptr[i];
+	nr_free_pages -= mask;
+
+	while (mask + (1 << (NR_MEM_LISTS-1))) {
+		if (!test_and_change_bit(index, area->map))
+			break;
+		remove_mem_queue(mem_map + (map_nr ^ -mask));
+		area[COLOR(map_nr ^ -mask) >> i].count--;
+		old_area[i].count--;
+		mask <<= 1;
+		i++;
+		area = qptr[i];
+		index >>= 1;
+		map_nr &= mask;
+	}
+
+	add_mem_queue(area + (COLOR(map_nr) >> i), mem_map + map_nr);
+	old_area[i].count++;
+}
+
+#endif	/* CONFIG_PAGE_COLORING_MODULE */
+
 /*
  * Free_page() adds the page to the free lists. This is optimized for
  * fast normal cases (no error jumps taken normally).
@@ -116,6 +367,13 @@
 	unsigned long mask = (~0UL) << order;
 	unsigned long index = map_nr >> (1 + order);
 
+#ifdef CONFIG_PAGE_COLORING_MODULE
+	if (page_coloring == 1) {
+		free_pages_by_color(map_nr, mask, order, index, type);
+		return;
+	}
+#endif
+
 	area = free_area[type] + order;
 	__free_pages_ok(map_nr, mask, area, index);
 }
@@ -137,6 +395,15 @@
 	map_nr &= mask;
 
 	spin_lock_irqsave(&page_alloc_lock, flags);
+
+#ifdef CONFIG_PAGE_COLORING_MODULE
+	if (page_coloring == 1) {
+		free_pages_by_color(map_nr, mask, order, index, type);
+		spin_unlock_irqrestore(&page_alloc_lock, flags);
+		return;
+	}
+#endif
+
 	area = free_area[type] + order;
 	__free_pages_ok(map_nr, mask, area, index);
 	spin_unlock_irqrestore(&page_alloc_lock, flags);
@@ -306,6 +573,19 @@
 		}
 	}
 ok_to_allocate:
+
+#ifdef CONFIG_PAGE_COLORING_MODULE
+	if (page_coloring == 1) {
+		unsigned long page = 0;
+		if (!(gfp_mask & __GFP_DMA))
+			page = alloc_page_by_color(order, 0);
+		if (!page)
+			page = alloc_page_by_color(order, 1);
+		spin_unlock_irqrestore(&page_alloc_lock, flags);
+		return page;
+	}
+#endif
+
 	/* if it's not a dma request, try non-dma first */
 	if (!(gfp_mask & __GFP_DMA))
 		RMQUEUE_TYPE(order, 0);



