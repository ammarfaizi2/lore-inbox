Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262655AbUKXQsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbUKXQsQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 11:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262660AbUKXQrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 11:47:37 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:17301 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262655AbUKXNE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:04:59 -0500
Subject: Suspend 2 merge: 40/51: Prepare image
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101299282.5805.357.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 25 Nov 2004 00:01:13 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This file contains the main routines used to prepare an image. Note that
this is potentially an iterative process: our allocation of metadata for
the image we know about may change the characteristics of the image and
require the allocation of a few extra pages. The number of iterations is
definitely bound (and the user can always press escape - if they've
enabled it - to cancel if I was wrong here).

We account for every page of memory. They are either:

- LRU -> pageset 2
- allocated for memory pool -> pageset 1
- otherwise used -> pageset 1
- unused and not allocated for memory pool -> not saved
- used but marked NoSave -> not saved

Plugins tell us how much memory they need, and we put that much plus a
little more in the memory pool. (Can't account for device drivers).

diff -ruN 830-prepare-image-old/kernel/power/prepare_image.c 830-prepare-image-new/kernel/power/prepare_image.c
--- 830-prepare-image-old/kernel/power/prepare_image.c	1970-01-01 10:00:00.000000000 +1000
+++ 830-prepare-image-new/kernel/power/prepare_image.c	2004-11-18 11:52:47.000000000 +1100
@@ -0,0 +1,1050 @@
+/*
+ * kernel/power/prepare_image.c
+ *
+ * Copyright (C) 2003-2004 Nigel Cunningham <ncunningham@linuxmail.org>
+ *
+ * This file is released under the GPLv2.
+ *
+ * We need to eat memory until we can:
+ * 1. Perform the save without changing anything (RAM_NEEDED < max_mapnr)
+ * 2. Fit it all in available space (active_writer->available_space() >= STORAGE_NEEDED)
+ * 3. Reload the pagedir and pageset1 to places that don't collide with their
+ *    final destinations, not knowing to what extent the resumed kernel will
+ *    overlap with the one loaded at boot time. I think the resumed kernel should overlap
+ *    completely, but I don't want to rely on this as it is an unproven assumption. We
+ *    therefore assume there will be no overlap at all (worse case).
+ * 4. Meet the user's requested limit (if any) on the size of the image.
+ *    The limit is in MB, so pages/256 (assuming 4K pages).
+ *
+ *    (Final test in save_image doesn't use EATEN_ENOUGH_MEMORY)
+ */
+
+#define SUSPEND_PREPARE_IMAGE_C
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/suspend.h>
+#include <linux/highmem.h>
+#include <linux/notifier.h>
+
+#include "suspend.h"
+#include "pageflags.h"
+#include "plugins.h"
+#include "proc.h"
+
+extern int pageset1_sizelow, pageset2_sizelow;
+extern unsigned long orig_mem_free;
+extern void mark_pages_for_pageset2(void);
+extern int image_size_limit;
+extern int fill_suspend_memory_pool(int sizesought);
+
+int suspend_amount_grabbed = 0;
+static int arefrozen = 0, numnosave = 0;
+static int header_space_allocated = 0;
+extern unsigned long forced_ps1_size, forced_ps2_size;
+
+/*
+ * generate_free_page_map
+ *
+ * Description:	This routine generates a bitmap of free pages from the
+ * 		lists used by the memory manager. We then use the bitmap
+ * 		to quickly calculate which pages to save and in which
+ * 		pagesets.
+ */
+static void generate_free_page_map(void) 
+{
+	int i, order, loop, cpu;
+	struct page * page;
+	unsigned long flags;
+	struct zone *zone;
+	struct per_cpu_pageset *pset;
+
+	for(i=0; i < max_mapnr; i++)
+		SetPageInUse(mem_map+i);
+	
+	for_each_zone(zone) {
+		if (!zone->present_pages)
+			continue;
+		spin_lock_irqsave(&zone->lock, flags);
+		for (order = MAX_ORDER - 1; order >= 0; --order) {
+			list_for_each_entry(page, &zone->free_area[order].free_list, lru)
+				for(loop=0; loop < (1 << order); loop++) {
+					ClearPageInUse(page+loop);
+					ClearPagePageset2(page+loop);
+				}
+		}
+
+		
+		for (cpu = 0; cpu < NR_CPUS; cpu++) {
+			if (!cpu_possible(cpu))
+				continue;
+
+			pset = &zone->pageset[cpu];
+
+			for (i = 0; i < ARRAY_SIZE(pset->pcp); i++) {
+				struct per_cpu_pages *pcp;
+				struct page * page;
+
+				pcp = &pset->pcp[i];
+				list_for_each_entry(page, &pcp->list, lru) {
+					ClearPageInUse(page);
+					ClearPagePageset2(page);
+				}
+			}
+		}
+		
+		spin_unlock_irqrestore(&zone->lock, flags);
+	}
+}
+
+/* size_of_free_region
+ * 
+ * Description:	Return the number of pages that are free, beginning with and 
+ * 		including this one.
+ */
+static int size_of_free_region(struct page * page)
+{
+	struct page * posn = page;
+
+	while (((posn-mem_map) < max_mapnr) && (!PageInUse(posn))) 
+		posn++;
+	return (posn - page);
+}
+
+static void display_reserved_pages(void)
+{
+	int loop;
+	int rangemin = -1;
+
+	for (loop = 0; loop < max_mapnr; loop++) {
+		if (PageReserved(mem_map+loop)) {
+			if (rangemin == -1)
+				rangemin = loop;
+		} else {
+			if (rangemin > -1) {
+				printk("Reserved pages from %p to %p.\n",
+					page_address(mem_map+rangemin),
+					((char *) page_address(mem_map + loop)) - 1);
+				rangemin = -1;
+			}
+		}
+	}
+
+	if (rangemin > -1)
+		printk("Reserved pages from %p to %p.\n",
+			page_address(mem_map+rangemin),
+			((char *) page_address(mem_map + max_mapnr)) - 1);
+}
+
+/* 
+ * Description:	Display which pages are marked Nosave.
+ */
+void display_nosave_pages(void)
+{
+	int loop;
+	int rangemin = -1;
+
+	if (!TEST_DEBUG_STATE(SUSPEND_NOSAVE))
+		return;
+
+	display_reserved_pages();
+
+	for (loop = 0; loop < max_mapnr; loop++) {
+		if (PageNosave(mem_map+loop)) {
+			if (rangemin == -1)
+				rangemin = loop;
+		} else {
+			if (rangemin > -1) {
+				printk("Nosave pages from %p to %p.\n",
+					page_address(mem_map+rangemin),
+					((char *) page_address(mem_map + loop)) - 1);
+				rangemin = -1;
+			}
+		}
+	}
+
+	if (rangemin > -1)
+		printk("Nosave pages from %p to %p.\n",
+			page_address(mem_map+rangemin),
+			((char *) page_address(mem_map + max_mapnr)) - 1);
+}
+
+/*
+ * count_data_pages
+ *
+ * This routine generates our lists of pages to be stored in each
+ * pageset. Since we store the data using ranges, and adding new
+ * ranges might allocate a new range page, this routine may well
+ * be called more than once.
+ */
+static struct pageset_sizes_result count_data_pages(void)
+{
+	int chunk_size, loop, numfree = 0;
+	int ranges = 0, currentrange = 0;
+	int usepagedir2;
+	int rangemin = 0;
+	struct pageset_sizes_result result;
+	struct range * rangepointer;
+	unsigned long value;
+#ifdef CONFIG_HIGHMEM
+	unsigned long highstart_pfn = get_highstart_pfn();
+#endif
+
+	result.size1 = 0;
+	result.size1low = 0;
+	result.size2 = 0;
+	result.size2low = 0;
+	result.needmorespace = 0;
+
+	numnosave = 0;
+
+	put_range_chain(&pagedir1.origranges);
+	put_range_chain(&pagedir1.destranges);
+	put_range_chain(&pagedir2.origranges);
+	pagedir2.destranges.first = NULL;
+	pagedir2.destranges.size = 0;
+
+	generate_free_page_map();
+
+	if (TEST_RESULT_STATE(SUSPEND_ABORTED)) {
+		result.size1 = -1;
+		result.size1low = -1;
+		result.size2 = -1;
+		result.size2low = -1;
+		result.needmorespace = 0;
+		return result;
+	}
+
+	if (max_mapnr != num_physpages) {
+		abort_suspend("Max_mapnr is not equal to num_physpages.");
+		result.size1 = -1;
+		result.size1low = -1;
+		result.size2 = -1;
+		result.size2low = -1;
+		result.needmorespace = 0;
+		return result;
+	}
+	/*
+	 * Pages not to be saved are marked Nosave irrespective of being reserved
+	 */
+	for (loop = 0; loop < max_mapnr; loop++) {
+		if (PageNosave(mem_map+loop)) {
+			numnosave++;
+			if (currentrange) {
+				append_to_range_chain(currentrange, rangemin, loop - 1);
+				rangemin = loop;
+				currentrange = 0;
+			}
+			continue;
+		}
+
+		if (!PageReserved(mem_map+loop)) {
+			if ((chunk_size=size_of_free_region(mem_map+loop))!=0) {
+				if (currentrange) {
+					append_to_range_chain(currentrange, rangemin, loop - 1);
+					rangemin = loop;
+					currentrange = 0;
+				}
+				numfree += chunk_size;
+				loop += chunk_size - 1;
+				continue;
+			}
+		} else {
+#ifdef CONFIG_HIGHMEM
+			if (loop >= highstart_pfn) {
+				/* HighMem pages may be marked Reserved. We ignore them. */
+				numnosave++;
+				if (currentrange) {
+					append_to_range_chain(currentrange, rangemin, loop - 1);
+					rangemin = loop;
+					currentrange = 0;
+				}
+				continue;
+			}
+#endif
+		};
+
+		usepagedir2 = !!PagePageset2(mem_map+loop);
+
+		if (currentrange != (1 + usepagedir2)) {
+			if (currentrange)
+				append_to_range_chain(currentrange, rangemin, loop - 1);
+			currentrange = usepagedir2 + 1;
+			rangemin = loop;
+			ranges++;
+		}
+		
+		if (usepagedir2) {
+			result.size2++;
+			if (!PageHighMem(mem_map+loop))
+				result.size2low++;
+		} else {
+			result.size1++;
+			if (!PageHighMem(mem_map+loop))
+				result.size1low++;
+		}
+	}
+	
+	if (currentrange)
+		append_to_range_chain(currentrange, rangemin, loop - 1);
+
+	if ((pagedir1.pageset_size) && (result.size1 > pagedir1.pageset_size))
+		result.needmorespace = 1;
+	if ((pagedir2.pageset_size) && (result.size2 > pagedir2.pageset_size))
+		result.needmorespace = 1;
+	suspend_message(SUSPEND_RANGES, SUSPEND_MEDIUM, 0, "Counted %d ranges.\n", ranges);
+	pagedir2.destranges.first = pagedir2.origranges.first;
+	pagedir2.destranges.size = pagedir2.origranges.size;
+	range_for_each(&pagedir1.allocdranges, rangepointer, value) {
+		add_to_range_chain(&pagedir1.destranges, value);
+	}
+
+	suspend_message(SUSPEND_EAT_MEMORY, SUSPEND_MEDIUM, 0,
+		"Count data pages: Set1 (%d) + Set2 (%d) + Nosave (%d) + NumFree (%d) = %d.\n",
+		result.size1, result.size2, numnosave, numfree,
+		result.size1 + result.size2 + numnosave + numfree);
+	return result;
+}
+
+/* amount_needed
+ *
+ * Calculates the amount by which the image size needs to be reduced to meet
+ * our constraints.
+ */
+static int amount_needed(int use_image_size_limit)
+{
+
+	int max1 = max( (int) (RAM_TO_SUSPEND - real_nr_free_pages() - 
+			  nr_free_highpages() - suspend_amount_grabbed),
+			((int) (STORAGE_NEEDED(1) -  
+			  active_writer->ops.writer.storage_available())));
+	if (use_image_size_limit)
+		return max( max1,
+			    (image_size_limit > 0) ? 
+			    ((int) (STORAGE_NEEDED(1) - (image_size_limit << 8))) : 0);
+	return max1;
+}
+
+#define EATEN_ENOUGH_MEMORY() (amount_needed(1) < 1)
+unsigned long storage_available = 0;
+
+/* display_stats
+ *
+ * Display the vital statistics.
+ */
+#ifdef CONFIG_SOFTWARE_SUSPEND_DEBUG
+static void display_stats(void)
+{ 
+	unsigned long storage_allocated = active_writer->ops.writer.storage_allocated();
+	suspend_message(SUSPEND_EAT_MEMORY, SUSPEND_MEDIUM, 1,
+		"Free:%d+%d+%d=%d(%d). Sets:%d(%d),%d(%d). Header:%d. Nosave:%d-%d-%d=%d. Storage:%d/%lu(%lu). Needed:%d|%d|%d.\n", 
+		
+		/* Free */
+		real_nr_free_pages(), suspend_amount_grabbed, suspend_memory_pool_level(0),
+		real_nr_free_pages() + suspend_amount_grabbed + suspend_memory_pool_level(0),
+		real_nr_free_pages() - nr_free_highpages(),
+		
+		/* Sets */
+		pageset1_size, pageset1_sizelow,
+		pageset2_size, pageset2_sizelow,
+
+		/* Header */
+		num_range_pages,
+
+		/* Nosave */
+		numnosave, pagedir1.allocdranges.size, suspend_amount_grabbed,
+		numnosave - pagedir1.allocdranges.size - suspend_amount_grabbed,
+
+		/* Storage - converted to pages for comparison */
+		storage_allocated,
+		STORAGE_NEEDED(1),
+		storage_available,
+
+		/* Needed */
+		RAM_TO_SUSPEND - real_nr_free_pages() - nr_free_highpages() - suspend_amount_grabbed,
+		STORAGE_NEEDED(1) - storage_available, 
+		(image_size_limit > 0) ? (STORAGE_NEEDED(1) - (image_size_limit << 8)) : 0);
+}
+#else
+#define display_stats() do { } while(0)
+#endif
+
+struct bloat_pages {
+	struct bloat_pages * next;
+	int order;
+};
+
+static struct bloat_pages * bloat_pages = NULL;
+
+void free_pageset_size_bloat(void)
+{
+	while (bloat_pages) {
+		struct bloat_pages * next = bloat_pages->next;
+		free_pages((unsigned long) bloat_pages, bloat_pages->order);
+		bloat_pages = next;
+	}
+}
+
+#define redo_counts() \
+{ \
+	suspend_message(SUSPEND_PAGESETS, SUSPEND_VERBOSE, 1, \
+		"Recalculating counts. Currently %ld & %ld. ", \
+		ps1_get, ps2_get);  \
+	result = count_data_pages(); \
+	if (forced_ps1_size) \
+		ps1_get = forced_ps1_size - result.size1 - drop_one; \
+	if (forced_ps2_size) \
+		ps2_get = forced_ps2_size - result.size2; \
+	suspend_message(SUSPEND_PAGESETS, SUSPEND_VERBOSE, 1, \
+		"Now %ld and %ld.\n", ps1_get, ps2_get); \
+}
+
+void increase_pageset_size(struct pageset_sizes_result result)
+{
+	long ps1_get = 0, ps2_get = 0, order, j;
+	int drop_one = 0;
+
+	if (forced_ps1_size)
+		ps1_get = forced_ps1_size - result.size1;
+
+	suspend_message(SUSPEND_PAGESETS, SUSPEND_HIGH, 1,
+		"1: Forced size = %ld. Have %d -> ps1_get = %ld.\n",
+		forced_ps1_size, result.size1, ps1_get);
+	
+	/* 
+	 * We can make ps2 size exactly what was requested, but
+	 * not both.
+	 */
+	if (forced_ps2_size) {
+		ps2_get = forced_ps2_size - result.size2;
+		suspend_message(SUSPEND_PAGESETS, SUSPEND_HIGH, 1,
+			"2: Forced size = %ld. Have %d -> ps2_get = %ld.\n",
+			forced_ps2_size, result.size2, ps2_get);
+
+		if (ps2_get > 0) {
+			order = generic_fls(ps2_get);
+			if (order >= MAX_ORDER)
+				order = MAX_ORDER - 1;
+
+			while(ps2_get > 0) {
+				struct page * newpage;
+				unsigned long virt;
+				struct bloat_pages * link;
+			
+				if ((ps1_get - (1 << order)) < (1 << order))
+					redo_counts();
+				
+				while ((1 << order) > (ps2_get))
+					order--;
+
+				virt = get_grabbed_pages(order);
+
+				while ((!virt) && (order > 0)) {
+					order--;
+					if ((ps1_get - (1 << order)) < (1 << order))
+						redo_counts();
+					virt = get_grabbed_pages(order);
+				}
+
+				if (!virt) {
+					suspend_message(SUSPEND_PAGESETS, SUSPEND_MEDIUM, 1,
+						" Failed to allocate enough memory for"
+						" requested pageset sizes.\n");
+					return;
+				}
+	
+				newpage = virt_to_page(virt);
+				for (j = 0; j < (1 << order); j++)
+					SetPagePageset2(newpage + j);
+
+				link = (struct bloat_pages *) virt;
+				link->next = bloat_pages;
+				link->order = order;
+				bloat_pages = link;
+
+				ps2_get -= (1 << order);
+				suspend_message(SUSPEND_PAGESETS, SUSPEND_VERBOSE, 1,
+					"Allocated %d for ps2. To get %ld.\n",
+					1 << order, ps2_get);
+			}
+		} else
+		{
+			/* Here, we're making ps2 pages into ps1 pages */
+			int i;
+
+			suspend_message(SUSPEND_PAGESETS, SUSPEND_HIGH, 1,
+				"Moving %ld ps2 pages to ps1.\n", -ps2_get);
+			for (i = 0; i < max_mapnr; i++) {
+				if PagePageset2(mem_map + i) {
+					ClearPagePageset2(mem_map + i);
+					ps2_get++;
+					ps1_get--;
+				}
+				if (!ps2_get)
+					break;
+			}
+		}
+	} else {
+		suspend_message(SUSPEND_PAGESETS, SUSPEND_HIGH, 1,
+			"2: Forced size = %ld. Have %d -> ps2_get = %ld.\n",
+			forced_ps2_size, result.size2, ps2_get);
+	}
+	
+	if (ps1_get > 0) {
+
+		suspend_message(SUSPEND_PAGESETS, SUSPEND_HIGH, 1,
+			"Still to get %ld pages for ps1.\n", ps1_get);
+		
+		/* We might allocate an extra range page later. */
+		if (ps1_get > 1) {
+			suspend_message(SUSPEND_PAGESETS, SUSPEND_VERBOSE, 1,
+				"Reducing ps1_get by one.\n");
+			drop_one = 1;
+			ps1_get--;
+		}
+		
+		order = generic_fls(ps1_get);
+		if (order >= MAX_ORDER)
+			order = MAX_ORDER - 1;
+
+		while(ps1_get > 0) {
+			unsigned long virt;
+			struct bloat_pages * link;
+		
+			if ((ps1_get - (1 << order)) < (1 << order))
+				redo_counts();
+				
+			while ((1 << order) > (ps1_get))
+				order--;
+
+			virt = get_grabbed_pages(order);
+
+			while ((!virt) && (order > 0)) {
+				order--;
+				if ((ps1_get - (1 << order)) < (1 << order))
+					redo_counts();
+				virt = get_grabbed_pages(order);
+			}
+
+			if (!virt) {
+				suspend_message(SUSPEND_PAGESETS, SUSPEND_VERBOSE, 1,
+					"Couldn't get enough pages. Need %ld more.\n",
+					ps1_get);
+				return;
+			}
+	
+			link = (struct bloat_pages *) virt;
+			link->next = bloat_pages;
+			link->order = order;
+			bloat_pages = link;
+
+			ps1_get -= (1 << order);
+			suspend_message(SUSPEND_PAGESETS, SUSPEND_VERBOSE, 1,
+				"Allocated %d for ps1. To get %ld.\n", 1 << order, ps1_get);
+		}
+	}
+	suspend_message(SUSPEND_PAGESETS, SUSPEND_VERBOSE, 1,
+		"Exiting increase pageset size.\n\n");
+}
+
+/*
+ * Eaten is the number of pages which have been eaten.
+ * Pagedirincluded is the number of pages which have been allocated for the pagedir.
+ */
+extern int allocate_extra_pagedir_memory(struct pagedir * p, int pageset_size, int alloc_from);
+
+struct pageset_sizes_result recalculate_stats(void) 
+{
+	struct pageset_sizes_result result;
+
+	mark_pages_for_pageset2();  /* Need to call this before getting pageset1_size! */
+	result = count_data_pages();
+	suspend_message(SUSPEND_PAGESETS, SUSPEND_VERBOSE, 1,
+		"Forced sizes %ld and %ld. Result %d and %d.\n",
+		forced_ps1_size, forced_ps2_size,
+		result.size1, result.size2);
+	if ((forced_ps1_size && forced_ps1_size != result.size1) || 
+	    (forced_ps2_size && forced_ps2_size != result.size2)) {
+		increase_pageset_size(result);
+		result = count_data_pages();
+	}
+	pageset1_sizelow = result.size1low;
+	pageset2_sizelow = result.size2low;
+	pagedir1.lastpageset_size = pageset1_size = result.size1;
+	pagedir2.lastpageset_size = pageset2_size = result.size2;
+	storage_available = active_writer->ops.writer.storage_available();
+	suspend_store_free_mem(SUSPEND_FREE_RANGE_PAGES, 0);
+	return result;
+}
+
+/* update_image
+ *
+ * Allocate [more] memory and storage for the image.
+ * Remember, this is iterative!
+ */
+static int update_image(void) 
+{ 
+	struct pageset_sizes_result result;
+	int iteration = 0, orig_num_range_pages;
+
+	result = recalculate_stats();
+
+	suspend_store_free_mem(SUSPEND_FREE_RANGE_PAGES, 0);
+
+	do {
+		iteration++;
+
+		orig_num_range_pages = num_range_pages;
+
+		suspend_message(SUSPEND_ANY_SECTION, SUSPEND_LOW, 1,
+				"-- Iteration %d.\n", iteration);
+
+		if (suspend_allocate_checksum_pages()) {
+			suspend_message(SUSPEND_ANY_SECTION, SUSPEND_LOW, 1,
+				"Still need to get more pages for checksum pages.\n");
+			return 1;
+		}
+
+		if (allocate_extra_pagedir_memory(&pagedir1, pageset1_size, pageset2_sizelow)) {
+			suspend_message(SUSPEND_ANY_SECTION, SUSPEND_LOW, 1,
+				"Still need to get more pages for pagedir 1.\n");
+			return 1;
+		}
+
+		if (active_writer->ops.writer.allocate_storage(MAIN_STORAGE_NEEDED(1))) {
+			suspend_message(SUSPEND_ANY_SECTION, SUSPEND_LOW, 1,
+				"Still need to get more storage space for the image proper.\n");
+			suspend_store_free_mem(SUSPEND_FREE_WRITER_STORAGE, 0);
+			return 1;
+		}
+
+		suspend_store_free_mem(SUSPEND_FREE_WRITER_STORAGE, 0);
+
+		set_suspend_state(SUSPEND_SLAB_ALLOC_FALLBACK);
+
+		if (active_writer->ops.writer.allocate_header_space(HEADER_STORAGE_NEEDED)) {
+			suspend_message(SUSPEND_ANY_SECTION, SUSPEND_LOW, 1,
+				"Still need to get more storage space for header.\n");
+			return 1;
+		}
+
+		header_space_allocated = HEADER_STORAGE_NEEDED;
+
+		clear_suspend_state(SUSPEND_SLAB_ALLOC_FALLBACK);
+
+		/* 
+		 * Allocate remaining storage space, if possible, up to the
+		 * maximum we know we'll need. It's okay to allocate the
+		 * maximum if the writer is the swapwriter, but
+		 * we don't want to grab all available space on an NFS share.
+		 * We therefore ignore the expected compression ratio here,
+		 * thereby trying to allocate the maximum image size we could
+		 * need (assuming compression doesn't expand the image), but
+		 * don't complain if we can't get the full amount we're after.
+		 */
+
+		active_writer->ops.writer.allocate_storage(
+			max((long)(active_writer->ops.writer.storage_available() -
+				active_writer->ops.writer.storage_allocated()),
+			     (long)(HEADER_STORAGE_NEEDED + MAIN_STORAGE_NEEDED(1))));
+
+		suspend_store_free_mem(SUSPEND_FREE_WRITER_STORAGE, 0);
+
+		result = recalculate_stats();
+		display_stats();
+
+	} while (((orig_num_range_pages < num_range_pages) || 
+		   result.needmorespace ||
+		   header_space_allocated < HEADER_STORAGE_NEEDED ||
+		   active_writer->ops.writer.storage_allocated() < (HEADER_STORAGE_NEEDED + MAIN_STORAGE_NEEDED(1))) 
+		 && (!TEST_RESULT_STATE(SUSPEND_ABORTED)));
+	
+	suspend_message(SUSPEND_ANY_SECTION, SUSPEND_MEDIUM, 1, "-- Exit loop.\n");
+
+	return (amount_needed(0) > 0);
+}
+
+/* ----------------------- Memory grabbing --------------------------
+ *
+ * All of the memory that is available, we grab.
+ * This enables us to get the image size down, even when other
+ * processes might be trying to increase their memory usage. (We
+ * have a hook to disable the OOM killer).
+ *
+ * At the same time, suspend's own routines get memory from this
+ * pool, and so does slab growth. Only get_zeroed_page and siblings
+ * see no memory available.
+ */
+
+static spinlock_t suspend_grabbed_memory_lock = SPIN_LOCK_UNLOCKED;
+
+struct eaten_memory_t
+{
+	void * next;
+};
+
+struct eaten_memory_t *eaten_memory[MAX_ORDER];
+
+static void __grab_free_memory(void)
+{
+	int order, k;
+
+	/*
+	 * First, quickly eat all memory that's already free.
+	 */
+	
+	for (order = MAX_ORDER - 1; order > -1; order--) {
+		struct eaten_memory_t *prev = eaten_memory[order];
+		eaten_memory[order] = (struct eaten_memory_t *) __get_free_pages(GFP_ATOMIC, order);
+		while (eaten_memory[order]) {
+			struct page * page = virt_to_page(eaten_memory[order]);
+			eaten_memory[order]->next = prev;
+			prev = eaten_memory[order];
+			suspend_amount_grabbed += (1 << order);
+			for (k=0; k < (1 << order); k++) {
+				SetPageNosave(page + k);
+				ClearPagePageset2(page + k);
+			}
+			eaten_memory[order] = (struct eaten_memory_t *) __get_free_pages(GFP_ATOMIC, order);
+		}
+		eaten_memory[order] = prev;
+	}
+}
+
+static void grab_free_memory(void)
+{
+	unsigned long flags;
+	
+	spin_lock_irqsave(&suspend_grabbed_memory_lock, flags);
+	__grab_free_memory();
+	spin_unlock_irqrestore(&suspend_grabbed_memory_lock, flags);
+}
+
+static void free_grabbed_memory(void)
+{
+	struct eaten_memory_t *next = NULL, *this = NULL;
+	int j, num_freed = 0, order;
+	unsigned long flags;
+
+	spin_lock_irqsave(&suspend_grabbed_memory_lock, flags);
+
+	/* Free all eaten pages immediately */
+	for (order = MAX_ORDER - 1; order > -1; order--) {
+		this=eaten_memory[order];
+		while(this) {
+			struct page * page = virt_to_page(this);
+			next = this->next;
+			for (j=0; j < (1 << order); j++)
+				ClearPageNosave(page + j);
+			free_pages((unsigned long) this, order);
+			num_freed+= (1 << order);
+			this = next;
+		}
+		eaten_memory[order] = NULL;
+	}
+	suspend_amount_grabbed -= num_freed;
+	BUG_ON(suspend_amount_grabbed);
+	spin_unlock_irqrestore(&suspend_grabbed_memory_lock, flags);
+}
+
+unsigned long get_grabbed_pages(int order)
+{
+	unsigned long this = (unsigned long) eaten_memory[order];
+	int alternative, j;
+	unsigned long flags;
+	struct page * page;
+
+	/* Get grabbed lowmem pages for suspend's use */
+	spin_lock_irqsave(&suspend_grabbed_memory_lock, flags);
+
+try_again:	
+	if (this) {
+		page = virt_to_page(this);
+		eaten_memory[order] = eaten_memory[order]->next;
+		for (j=0; j < (1 << order); j++) {
+			ClearPageNosave(page + j);
+			ClearPagePageset2(page + j);
+			clear_page(page_address(page + j));
+		}
+		suspend_amount_grabbed -= (1 << order);
+		spin_unlock_irqrestore(&suspend_grabbed_memory_lock, flags);
+		return this;
+	}
+
+	alternative = order+1;
+	while ((!eaten_memory[alternative]) && (alternative < MAX_ORDER))
+		alternative++;
+
+	/* Maybe we didn't eat any memory - try normal get */
+	if (alternative == MAX_ORDER) {
+		this = __get_free_pages(GFP_ATOMIC, order);
+		if (this) {
+			page = virt_to_page(this);
+			for (j=0; j < (1 << order); j++) {
+				clear_page((char *) this + j * PAGE_SIZE);
+				ClearPagePageset2(page + j);
+			}
+		}
+		spin_unlock_irqrestore(&suspend_grabbed_memory_lock, flags);
+		return this;
+	}
+
+	{
+		unsigned long virt = (unsigned long) eaten_memory[alternative];
+		page = virt_to_page(eaten_memory[alternative]);
+		eaten_memory[alternative] = eaten_memory[alternative]->next;
+		for (j=0; j < (1 << (alternative)); j++) {
+			ClearPageNosave(page + j);
+			clear_page(page_address(page + j));
+			ClearPagePageset2(page + j);
+		}
+		free_pages(virt, alternative);
+		suspend_amount_grabbed -= (1 << alternative);
+	}
+
+	/* Get the chunk we want to return. May fail if something grabs
+	 * the memory before us. */
+	this = __get_free_pages(GFP_ATOMIC, order);
+	if (!this)
+		goto try_again;
+
+	page = virt_to_page(this);
+
+	/* Grab the rest */
+	__grab_free_memory();
+	
+	spin_unlock_irqrestore(&suspend_grabbed_memory_lock, flags);
+
+	return this;
+}
+
+/* --------------------------------------------------------------------------- */
+
+extern int freeze_processes(int no_progress);
+
+static int attempt_to_freeze(void)
+{
+	int result;
+	
+	/* Stop processes before checking again */
+	thaw_processes(FREEZER_ALL_THREADS);
+	prepare_status(1, 1, "Freezing processes");
+	result = freeze_processes(0);
+	suspend_message(SUSPEND_FREEZER, SUSPEND_VERBOSE, 0, "- Freeze_processes returned %d.\n",
+		result);
+
+	if (result) {
+		SET_RESULT_STATE(SUSPEND_ABORTED);
+		SET_RESULT_STATE(SUSPEND_FREEZING_FAILED);
+	} else
+		arefrozen = 1;
+
+	return result;
+}
+
+extern asmlinkage long sys_sync(void);
+
+static int eat_memory(void)
+{
+	int orig_memory_still_to_eat, last_amount_needed = 0, times_criteria_met = 0;
+	int free_flags = 0, did_eat_memory = 0;
+	
+	/*
+	 * Note that if we have enough storage space and enough free memory, we may
+	 * exit without eating anything. We give up when the last 10 iterations ate
+	 * no extra pages because we're not going to get much more anyway, but
+	 * the few pages we get will take a lot of time.
+	 *
+	 * We freeze processes before beginning, and then unfreeze them if we
+	 * need to eat memory until we think we have enough. If our attempts
+	 * to freeze fail, we give up and abort.
+	 */
+
+	/* ----------- Stage 1: Freeze Processes ------------- */
+
+	
+	prepare_status(0, 1, "Eating memory.");
+
+	recalculate_stats();
+	display_stats();
+
+	orig_memory_still_to_eat = amount_needed(1);
+	last_amount_needed = orig_memory_still_to_eat;
+
+	switch (image_size_limit) {
+		case -1: /* Don't eat any memory */
+			if (orig_memory_still_to_eat) {
+				SET_RESULT_STATE(SUSPEND_ABORTED);
+				SET_RESULT_STATE(SUSPEND_WOULD_EAT_MEMORY);
+			}
+			break;
+		case -2:  /* Free caches only */
+			free_flags = GFP_NOIO | __GFP_HIGHMEM;
+			break;
+		default:
+			free_flags = GFP_ATOMIC | __GFP_HIGHMEM;
+	}
+		
+	/* ----------- Stage 2: Eat memory ------------- */
+
+	while (((!EATEN_ENOUGH_MEMORY()) || (image_size_limit == -2)) && (!TEST_RESULT_STATE(SUSPEND_ABORTED)) && (times_criteria_met < 10)) {
+		int amount_freed;
+		int amount_wanted = orig_memory_still_to_eat - amount_needed(1);
+		if (amount_wanted < 1)
+			amount_wanted = 1; /* image_size_limit == -2 */
+
+		suspend_message(SUSPEND_EAT_MEMORY, SUSPEND_VERBOSE, 1,
+			"Times met criteria is %d.\n", times_criteria_met);
+		if (orig_memory_still_to_eat)
+			update_status(orig_memory_still_to_eat - amount_needed(1), orig_memory_still_to_eat, " Image size %d ", MB(STORAGE_NEEDED(1)));
+		else
+			update_status(0, 1, "Image size %d ", MB(STORAGE_NEEDED(1)));
+		
+		if ((last_amount_needed - amount_needed(1)) < 10)
+			times_criteria_met++;
+		else
+			times_criteria_met = 0;
+		last_amount_needed = amount_needed(1);
+		amount_freed = shrink_all_memory(last_amount_needed);
+		suspend_message(SUSPEND_EAT_MEMORY, SUSPEND_VERBOSE, 1,
+			"Given %d, shrink_all_memory returned %d.\n", last_amount_needed, amount_freed);
+		grab_free_memory();
+		recalculate_stats();
+		display_stats();
+
+		did_eat_memory = 1;
+
+		check_shift_keys(0, NULL);
+	}
+
+	grab_free_memory();
+	
+	suspend_message(SUSPEND_EAT_MEMORY, SUSPEND_VERBOSE, 1,
+		"Out of main eat memory loop.\n");
+
+	if (did_eat_memory) {
+		unsigned long orig_state = get_suspend_state();
+		suspend_message(SUSPEND_EAT_MEMORY, SUSPEND_VERBOSE, 1,
+			"Ate memory; letting kjournald etc run.\n");
+		clear_suspend_state(SUSPEND_USE_MEMORY_POOL);
+		thaw_processes(FREEZER_KERNEL_THREADS);
+		/* Freeze_processes will call sys_sync too */
+		freeze_processes(1);
+		grab_free_memory();
+		restore_suspend_state(orig_state);
+		recalculate_stats();
+		display_stats();
+	}
+
+	suspend_message(SUSPEND_EAT_MEMORY, 1, SUSPEND_VERBOSE, "\n");
+	
+	suspend_message(SUSPEND_EAT_MEMORY, SUSPEND_VERBOSE, 1,
+		"(Freezer exit:) Swap needed calculated as (%d+%d)*%d/100+%d+1+%d=%d.\n",
+		pageset1_size,
+		pageset2_size,
+		expected_compression_ratio(),
+		num_range_pages,
+	 	HEADER_STORAGE_NEEDED,
+		STORAGE_NEEDED(1));
+
+	/* Blank out image size display */
+	update_status(100, 100, "                   ");
+
+	/* Include image size limit when checking what to report */
+	if (amount_needed(1) > 0) 
+		SET_RESULT_STATE(SUSPEND_UNABLE_TO_FREE_ENOUGH_MEMORY);
+
+	/* But don't include it when deciding whether to abort (soft limit) */
+	if ((amount_needed(0) > 0)) {
+		printk("Unable to free sufficient memory to suspend. Still need %d pages. "
+			"You may be able to avoid this problem by reducing the async_io_limit\n",
+			amount_needed(1));
+		SET_RESULT_STATE(SUSPEND_ABORTED);
+	}
+	
+	check_shift_keys(1, "Memory eating completed.");
+	return 0;
+}
+
+/* prepare_image
+ *
+ * Entry point to the whole image preparation section.
+ *
+ * We do four things:
+ * - Freeze processes;
+ * - Ensure image size constraints are met;
+ * - Complete all the preparation for saving the image,
+ *   including allocation of storage. The only memory
+ *   that should be needed when we're finished is that
+ *   for actually storing the image (and we know how
+ *   much is needed for that because the plugins tell
+ *   us).
+ * - Make sure that all dirty buffers are written out.
+ */
+int prepare_image(void)
+{
+	int result = 1, sizesought;
+
+	arefrozen = 0;
+
+	header_space_allocated = 0;
+
+	sizesought = 100 + memory_for_plugins();
+
+	PRINTFREEMEM("prior to filling the memory pool");
+	
+	if (fill_suspend_memory_pool(sizesought))
+		return 1;
+
+	PRINTFREEMEM("after filling the memory pool");
+	suspend_store_free_mem(SUSPEND_FREE_MEM_POOL, 0);
+	
+	if (attempt_to_freeze())
+		return 1;
+
+	PRINTFREEMEM("after freezing processes");
+	suspend_store_free_mem(SUSPEND_FREE_FREEZER, 0);
+	
+	if (!active_writer->ops.writer.storage_available()) {
+		printk(KERN_ERR "You need some storage available to be able to suspend.\n");
+		SET_RESULT_STATE(SUSPEND_ABORTED);
+		SET_RESULT_STATE(SUSPEND_NOSTORAGE_AVAILABLE);
+		return 1;
+	}
+
+	do {
+		if (eat_memory() || TEST_RESULT_STATE(SUSPEND_ABORTED))
+			break;
+
+		PRINTFREEMEM("after eating memory");
+		suspend_store_free_mem(SUSPEND_FREE_EAT_MEMORY, 0);
+	
+		/* Top up */
+		if (fill_suspend_memory_pool(sizesought))
+			continue;
+	
+		PRINTFREEMEM("after refilling memory pool");
+		suspend_store_free_mem(SUSPEND_FREE_MEM_POOL, 0);
+	
+		result = update_image();
+		PRINTFREEMEM("after updating the image");
+
+	} while ((result) && (!TEST_RESULT_STATE(SUSPEND_ABORTED)) &&
+		(!TEST_RESULT_STATE(SUSPEND_UNABLE_TO_FREE_ENOUGH_MEMORY)));
+
+	PRINTFREEMEM("after preparing image");
+
+	/* Release memory that has been eaten */
+	free_grabbed_memory();
+	
+	PRINTFREEMEM("after freeing grabbed memory");
+	suspend_store_free_mem(SUSPEND_FREE_GRABBED_MEMORY, 1);
+	
+	set_suspend_state(SUSPEND_USE_MEMORY_POOL);
+
+	check_shift_keys(1, "Image preparation complete.");
+
+	return result;
+}
+
+EXPORT_SYMBOL(suspend_amount_grabbed);


