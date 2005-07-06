Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVGFDgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVGFDgg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 23:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVGFDfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 23:35:17 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:10649 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262073AbVGFCTa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:30 -0400
Subject: [PATCH] [39/48] Suspend2 2.1.9.8 for 2.6.12: 615-poweroff.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:43 +1000
Message-Id: <11206164431370@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 616-prepare_image.patch-old/kernel/power/suspend2_core/prepare_image.c 616-prepare_image.patch-new/kernel/power/suspend2_core/prepare_image.c
--- 616-prepare_image.patch-old/kernel/power/suspend2_core/prepare_image.c	1970-01-01 10:00:00.000000000 +1000
+++ 616-prepare_image.patch-new/kernel/power/suspend2_core/prepare_image.c	2005-07-04 23:14:19.000000000 +1000
@@ -0,0 +1,585 @@
+/*
+ * kernel/power/prepare_image.c
+ *
+ * Copyright (C) 2003-2005 Nigel Cunningham <nigel@suspend.net>
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
+#include <linux/highmem.h>
+
+#include "suspend.h"
+#include "pageflags.h"
+#include "plugins.h"
+#include "suspend2_common.h"
+#include "io.h"
+#include "ui.h"
+#include "extent.h"
+#include "prepare_image.h"
+
+#define EATEN_ENOUGH_MEMORY() (amount_needed(1) < 1)
+static int arefrozen = 0, numnosave = 0;
+static int header_space_allocated = 0;
+static int storage_allocated = 0;
+static int storage_available = 0;
+
+static int num_pcp_pages(void)
+{
+	struct zone *zone;
+	int result = 0, i = 0;
+
+	/* PCP lists */
+	for_each_zone(zone) {
+		struct per_cpu_pageset *pset;
+		int cpu;
+		
+		if (!zone->present_pages)
+			continue;
+		
+		for (cpu = 0; cpu < NR_CPUS; cpu++) {
+			if (!cpu_possible(cpu))
+				continue;
+
+			pset = &zone->pageset[cpu];
+
+			for (i = 0; i < ARRAY_SIZE(pset->pcp); i++) {
+				struct per_cpu_pages *pcp;
+
+				pcp = &pset->pcp[i];
+				result += pcp->count;
+			}
+		}
+	}
+	return result;
+}
+
+int real_nr_free_pages(void)
+{
+	return nr_free_pages() + num_pcp_pages();
+}
+
+/* generate_free_page_map
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
+		SetPageInUse(pfn_to_page(i));
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
+	while (((page_to_pfn(posn)) < max_mapnr) && (!PageInUse(posn))) 
+		posn++;
+	return (posn - page);
+}
+
+/* count_data_pages
+ *
+ * This routine generates our lists of pages to be stored in each
+ * pageset. Since we store the data using extents, and adding new
+ * extents might allocate a new extent page, this routine may well
+ * be called more than once.
+ */
+static struct pageset_sizes_result count_data_pages(void)
+{
+	int chunk_size, loop, numfree = 0;
+	int usepagedir2;
+	struct pageset_sizes_result result;
+
+	result.size1 = 0;
+	result.size1low = 0;
+	result.size2 = 0;
+	result.size2low = 0;
+
+	numnosave = 0;
+
+	clear_dyn_pageflags(pageset1_map);
+	clear_dyn_pageflags(pageset1_copy_map);
+
+	generate_free_page_map();
+
+	if (TEST_RESULT_STATE(SUSPEND_ABORTED))
+		return result;
+
+	if (max_mapnr != num_physpages) {
+		abort_suspend("Max_mapnr is not equal to num_physpages.");
+		return result;
+	}
+		
+	/*
+	 * Pages not to be saved are marked Nosave irrespective of being reserved
+	 */
+	for (loop = 0; loop < max_mapnr; loop++) {
+		struct page * page = pfn_to_page(loop);
+		if (PageNosave(page)) {
+			numnosave++;
+			continue;
+		}
+
+		if (!PageReserved(page)) {
+			if ((chunk_size=size_of_free_region(page))!=0) {
+				numfree += chunk_size;
+				loop += chunk_size - 1;
+				continue;
+			}
+		} else {
+			if (PageHighMem(page)) {
+				/* HighMem pages may be marked Reserved. We ignore them. */
+				numnosave++;
+				continue;
+			}
+		};
+
+		usepagedir2 = PagePageset2(page);
+
+		if (usepagedir2) {
+			result.size2++;
+			if (!PageHighMem(page))
+				result.size2low++;
+			SetPagePageset1Copy(page);
+		} else {
+			result.size1++;
+			SetPagePageset1(page);
+			if (!PageHighMem(page))
+				result.size1low++;
+		}
+	}
+	
+	suspend_message(SUSPEND_EAT_MEMORY, SUSPEND_MEDIUM, 0,
+		"Count data pages: Set1 (%d) + Set2 (%d) + Nosave (%d) + NumFree (%d) = %d.\n",
+		result.size1, result.size2, numnosave, numfree,
+		result.size1 + result.size2 + numnosave + numfree);
+	BITMAP_FOR_EACH_SET(allocd_pages_map, loop)
+		SetPagePageset1Copy(pfn_to_page(loop));
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
+			  nr_free_highpages()),
+			((int) (STORAGE_NEEDED(1) -  
+			  storage_available)));
+	if (use_image_size_limit)
+		return max( max1,
+			    (image_size_limit > 0) ? 
+			    ((int) (STORAGE_NEEDED(1) - (image_size_limit << 8))) : 0);
+	return max1;
+}
+
+/* display_stats
+ *
+ * Display the vital statistics.of the image.
+ */
+#ifdef CONFIG_PM_DEBUG
+static void display_stats(void)
+{ 
+	storage_allocated = active_writer->ops.writer.storage_allocated();
+	suspend_message(SUSPEND_EAT_MEMORY, SUSPEND_MEDIUM, 1,
+		"Free:%d(%d). Sets:%d(%d),%d(%d). Nosave:%d-%d=%d. Storage:%d/%d+%d=%d(%lu). Needed:%d|%d|%d.\n", 
+		
+		/* Free */
+		real_nr_free_pages(),
+		real_nr_free_pages() - nr_free_highpages(),
+		
+		/* Sets */
+		pageset1_size, pageset1_sizelow,
+		pageset2_size, pageset2_sizelow,
+
+		/* Nosave */
+		numnosave, extra_pagedir_pages_allocated,
+		numnosave - extra_pagedir_pages_allocated,
+
+		/* Storage */
+		storage_allocated,
+		MAIN_STORAGE_NEEDED(1), HEADER_STORAGE_NEEDED,
+		STORAGE_NEEDED(1),
+		storage_available,
+
+		/* Needed */
+		RAM_TO_SUSPEND - real_nr_free_pages() - nr_free_highpages(),
+		STORAGE_NEEDED(1) - storage_available, 
+		(image_size_limit > 0) ? (STORAGE_NEEDED(1) - (image_size_limit << 8)) : 0);
+}
+#else
+#define display_stats() do { } while(0)
+#endif
+
+/* suspend2_recalculate_stats
+ *
+ * Eaten is the number of pages which have been eaten.
+ * Pagedirincluded is the number of pages which have been allocated for the pagedir.
+ */
+struct pageset_sizes_result suspend2_recalculate_stats(void) 
+{
+	struct pageset_sizes_result result;
+
+	suspend2_mark_pages_for_pageset2();  /* Need to call this before getting pageset1_size! */
+	result = count_data_pages();
+	pageset1_sizelow = result.size1low;
+	pageset2_sizelow = result.size2low;
+	pagedir1.lastpageset_size = pageset1_size = result.size1;
+	pagedir2.lastpageset_size = pageset2_size = result.size2;
+	storage_available = active_writer->ops.writer.storage_available();
+	return result;
+}
+
+/* update_image
+ *
+ * Allocate [more] memory and storage for the image.
+ */
+static int update_image(void) 
+{ 
+	struct pageset_sizes_result result;
+	int result2, param_used;
+
+	result = suspend2_recalculate_stats();
+
+	/* Include allowance for growth in pagedir1 while writing pagedir 2 */
+	if (suspend2_allocate_extra_pagedir_memory(&pagedir1,
+				pageset1_size + EXTRA_PD1_PAGES_ALLOWANCE,
+				pageset2_sizelow)) {
+		suspend_message(SUSPEND_EAT_MEMORY, SUSPEND_LOW, 1,
+			"Still need to get more pages for pagedir 1.\n");
+		return 1;
+	}
+
+	thaw_processes(FREEZER_KERNEL_THREADS);
+
+	param_used = MAIN_STORAGE_NEEDED(1);
+	if ((result2 = active_writer->ops.writer.allocate_storage(param_used))) {
+		suspend_message(SUSPEND_EAT_MEMORY, SUSPEND_LOW, 1,
+			"Still need to get more storage space for the image proper.\n");
+		storage_allocated = active_writer->ops.writer.storage_allocated();
+		freeze_processes(1);
+		return 1;
+	}
+
+	param_used = HEADER_STORAGE_NEEDED;
+	if ((result2 = active_writer->ops.writer.allocate_header_space(HEADER_STORAGE_NEEDED))) {
+		suspend_message(SUSPEND_EAT_MEMORY, SUSPEND_LOW, 1,
+			"Still need to get more storage space for header.\n");
+		freeze_processes(1);
+		storage_allocated = active_writer->ops.writer.storage_allocated();
+		return 1;
+	}
+
+	header_space_allocated = HEADER_STORAGE_NEEDED;
+
+	/* 
+	 * Allocate remaining storage space, if possible, up to the
+	 * maximum we know we'll need. It's okay to allocate the
+	 * maximum if the writer is the swapwriter, but
+	 * we don't want to grab all available space on an NFS share.
+	 * We therefore ignore the expected compression ratio here,
+	 * thereby trying to allocate the maximum image size we could
+	 * need (assuming compression doesn't expand the image), but
+	 * don't complain if we can't get the full amount we're after.
+	 */
+
+	active_writer->ops.writer.allocate_storage(
+		min(storage_available,
+		    MAIN_STORAGE_NEEDED(0) + 100));
+
+	storage_allocated = active_writer->ops.writer.storage_allocated();
+
+	freeze_processes(1);
+
+	suspend2_recalculate_stats();
+	display_stats();
+
+	suspend_message(SUSPEND_EAT_MEMORY, SUSPEND_LOW, 1,
+		"Amount still needed (%d) > 0:%d. Header: %d < %d: %d,"
+		" Storage allocd: %d < %d + %d: %d.\n",
+			amount_needed(0),
+			(amount_needed(0) > 0),
+			header_space_allocated, HEADER_STORAGE_NEEDED,
+			header_space_allocated < HEADER_STORAGE_NEEDED,
+		 	storage_allocated,
+			HEADER_STORAGE_NEEDED, MAIN_STORAGE_NEEDED(1),
+			storage_allocated <
+			(HEADER_STORAGE_NEEDED + MAIN_STORAGE_NEEDED(1)));
+
+	check_shift_keys(0, NULL);
+
+	return ((amount_needed(0) > 0) ||
+		header_space_allocated < HEADER_STORAGE_NEEDED ||
+		 storage_allocated < 
+		 (HEADER_STORAGE_NEEDED + MAIN_STORAGE_NEEDED(1)));
+}
+
+/* --------------------------------------------------------------------------- */
+
+/* attempt_to_freeze
+ * 
+ * Try to freeze processes.
+ */
+
+static int attempt_to_freeze(void)
+{
+	int result;
+	
+	/* Stop processes before checking again */
+	thaw_processes(FREEZER_ALL_THREADS);
+	suspend2_prepare_status(1, 1, "Freezing processes");
+	result = freeze_processes(0);
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
+/* eat_memory
+ *
+ * Try to free some memory, either to meet hard or soft constraints on the image
+ * characteristics.
+ * 
+ * Hard constraints:
+ * - Pageset1 must be < half of memory;
+ * - We must have enough memory free at resume time to have pageset1
+ *   be able to be loaded in pages that don't conflict with where it has to
+ *   be restored.
+ * Soft constraints
+ * - User specificied image size limit.
+ */
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
+	suspend2_recalculate_stats();
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
+	while (((!EATEN_ENOUGH_MEMORY()) || (image_size_limit == -2)) && 
+		(!TEST_RESULT_STATE(SUSPEND_ABORTED)) && 
+		(times_criteria_met < 10)) {
+		int amount_freed;
+		int amount_wanted = orig_memory_still_to_eat - amount_needed(1);
+
+		suspend2_prepare_status(0, 1, "Seeking to free %dMB of memory.", MB(amount_needed(1)));
+
+		if (amount_wanted < 1)
+			amount_wanted = 1; /* image_size_limit == -2 */
+
+		if (orig_memory_still_to_eat)
+			suspend2_update_status(orig_memory_still_to_eat - amount_needed(1),
+				orig_memory_still_to_eat,
+				" Image size %d ",
+				MB(STORAGE_NEEDED(1)));
+		else
+			suspend2_update_status(0, 1, "Image size %d ", MB(STORAGE_NEEDED(1)));
+		
+		if ((last_amount_needed - amount_needed(1)) < 10)
+			times_criteria_met++;
+		else
+			times_criteria_met = 0;
+		last_amount_needed = amount_needed(1);
+		amount_freed = shrink_all_memory(last_amount_needed);
+		suspend2_recalculate_stats();
+		display_stats();
+
+		did_eat_memory = 1;
+
+		check_shift_keys(0, NULL);
+	}
+
+	if (did_eat_memory) {
+		unsigned long orig_state = get_suspend_state();
+		thaw_processes(FREEZER_KERNEL_THREADS);
+		/* Freeze_processes will call sys_sync too */
+		freeze_processes(1);
+		restore_suspend_state(orig_state);
+		suspend2_recalculate_stats();
+		display_stats();
+	}
+
+	/* Blank out image size display */
+	suspend2_update_status(100, 100, NULL);
+
+	if (!TEST_RESULT_STATE(SUSPEND_ABORTED)) {
+		/* Include image size limit when checking what to report */
+		if (amount_needed(1) > 0) 
+			SET_RESULT_STATE(SUSPEND_UNABLE_TO_FREE_ENOUGH_MEMORY);
+
+		/* But don't include it when deciding whether to abort (soft limit) */
+		if ((amount_needed(0) > 0)) {
+			printk("Unable to free sufficient memory to suspend. Still need %d pages.\n",
+				amount_needed(1));
+			SET_RESULT_STATE(SUSPEND_ABORTED);
+		}
+		
+		check_shift_keys(1, "Memory eating completed.");
+	}
+
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
+
+#define MAX_TRIES 4
+int suspend2_prepare_image(void)
+{
+	int result = 1, sizesought, tries = 0;
+
+	arefrozen = 0;
+
+	header_space_allocated = 0;
+
+	sizesought = 100 + memory_for_plugins();
+
+	if (attempt_to_freeze())
+		return 0;
+
+	storage_available = active_writer->ops.writer.storage_available();
+
+	if (!storage_available) {
+		printk(KERN_ERR "You need some storage available to be able to suspend.\n");
+		SET_RESULT_STATE(SUSPEND_ABORTED);
+		SET_RESULT_STATE(SUSPEND_NOSTORAGE_AVAILABLE);
+		return 0;
+	}
+
+	do {
+		suspend2_prepare_status(0, 1, "Preparing Image.");
+	
+		if (eat_memory() || TEST_RESULT_STATE(SUSPEND_ABORTED))
+			break;
+
+		result = update_image();
+
+		check_shift_keys(0, NULL);
+		
+		tries++;
+
+	} while ((result) && (tries < MAX_TRIES) && (!TEST_RESULT_STATE(SUSPEND_ABORTED)) &&
+		(!TEST_RESULT_STATE(SUSPEND_UNABLE_TO_FREE_ENOUGH_MEMORY)));
+
+	if (tries == MAX_TRIES)
+		abort_suspend("Unable to get sufficient storage for the image.\n");
+
+	check_shift_keys(1, "Image preparation complete.");
+
+	return !result;
+}
diff -ruNp 616-prepare_image.patch-old/kernel/power/suspend2_core/prepare_image.h 616-prepare_image.patch-new/kernel/power/suspend2_core/prepare_image.h
--- 616-prepare_image.patch-old/kernel/power/suspend2_core/prepare_image.h	1970-01-01 10:00:00.000000000 +1000
+++ 616-prepare_image.patch-new/kernel/power/suspend2_core/prepare_image.h	2005-07-04 23:14:19.000000000 +1000
@@ -0,0 +1,44 @@
+/*
+ * kernel/power/prepare_image.h
+ */
+
+extern int suspend2_prepare_image(void);
+extern struct pageset_sizes_result suspend2_recalculate_stats(void);
+extern int real_nr_free_pages(void);
+extern int image_size_limit;
+extern int pageset1_sizelow, pageset2_sizelow;
+
+struct pageset_sizes_result {
+	int size1; /* Can't be unsigned - breaks MAX function */
+	int size1low;
+	int size2;
+	int size2low;
+	int needmorespace;
+};
+
+#define MIN_FREE_RAM (max_low_pfn >> 7)
+
+#define EXTRA_PD1_PAGES_ALLOWANCE 100
+
+#define MAIN_STORAGE_NEEDED(USE_ECR) \
+	((pageset1_size + pageset2_size + 100 + \
+	  EXTRA_PD1_PAGES_ALLOWANCE) * \
+	 (USE_ECR ? expected_compression_ratio() : 100) / 100)
+
+#define HEADER_BYTES_NEEDED \
+	((extents_allocated * 2 * sizeof(unsigned long)) + \
+	 sizeof(struct suspend_header) + \
+	 sizeof(struct plugin_header) + \
+	 (int) header_storage_for_plugins() + \
+	 (PAGES_PER_BITMAP << PAGE_SHIFT) + \
+	 num_plugins * \
+	 	(sizeof(struct plugin_header) + sizeof(int)))
+	
+#define HEADER_STORAGE_NEEDED ((int) ((HEADER_BYTES_NEEDED + (int) PAGE_SIZE - 1) >> PAGE_SHIFT))
+
+#define STORAGE_NEEDED(USE_ECR) \
+	(MAIN_STORAGE_NEEDED(USE_ECR) + HEADER_STORAGE_NEEDED)
+
+#define RAM_TO_SUSPEND (1 + max((pageset1_size + EXTRA_PD1_PAGES_ALLOWANCE - pageset2_sizelow), 0) + \
+		MIN_FREE_RAM + memory_for_plugins())
+

