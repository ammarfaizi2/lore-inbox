Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262788AbUKXROi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbUKXROi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 12:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262782AbUKXRKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 12:10:31 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:1173 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262765AbUKXREi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 12:04:38 -0500
Subject: Suspend 2 merge: 38/51: Page directory support.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101298736.5805.345.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 25 Nov 2004 00:00:57 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A pageset is a group of pages that are saved as part of the image.
Suspend uses two pagesets: pageset2 contains the LRU pages and pageset1
contains all other pages saved. A pagedir is the original name for
pagesets. I use it more to refer to the metadata for the pageset.

Note that all of our metadata is actually stored in extents (I called
them ranges before I knew what an extent was). The struct pbe2 is an
abstraction of this data, roughly equivalent to the pbes that swsusp
uses (hence the name) and the *pbe* functions at the top of this file.

Here we also have the code for making our atomic copy when suspending,
allocating and freeing the metadata and working to ensure the copy of
pagedir1 loaded at resume time doesn't get overwritten by itself
('collide') as we restore the kernel.

diff -ruN 828-pagedir-old/kernel/power/pagedir.c 828-pagedir-new/kernel/power/pagedir.c
--- 828-pagedir-old/kernel/power/pagedir.c	1970-01-01 10:00:00.000000000 +1000
+++ 828-pagedir-new/kernel/power/pagedir.c	2004-11-17 19:05:47.000000000 +1100
@@ -0,0 +1,532 @@
+/*
+ * kernel/power/pagedir.c
+ *
+ * Copyright (C) 1998-2001 Gabor Kuti <seasons@fornax.hu>
+ * Copyright (C) 1998,2001,2002 Pavel Machek <pavel@suse.cz>
+ * Copyright (C) 2002-2003 Florent Chabaud <fchabaud@free.fr>
+ * Copyright (C) 2002-2004 Nigel Cunningham <ncunningham@linuxmail.org>
+ *
+ * This file is released under the GPLv2.
+ *
+ * Routines for handling pagesets.
+ * Note that pbes aren't actually stored as such. They're stored as
+ * ranges (extents is the term, I'm told).
+ */
+
+#define SUSPEND_PAGEDIR_C
+#include <linux/suspend.h>
+#include <linux/highmem.h>
+#include <linux/module.h>
+
+extern struct pagedir pagedir1, pagedir2, pagedir_resume;
+
+#include "suspend.h"
+#include "pageflags.h"
+
+/* setup_pbe_variable
+ *
+ * Description:	Set up one variable in a page backup entry from the range list.
+ * Arguments:	unsigned long:		The variable which will contain the 
+ * 					value.
+ * 		struct range**:		Address of the pointer to the current
+ * 					range.
+ * 		struct rangechain*:	Address of the rangechain we are 
+ * 					traversing.
+ */
+static inline void setup_pbe_variable(unsigned long * variable, struct range ** currentrange,
+		struct rangechain * chain)
+{
+	*currentrange = chain->first;
+	if (chain->first)
+		*variable = chain->first->minimum;
+	else
+		*variable = 0;
+}
+
+/* get_first_pbe
+ *
+ * Description:	Get the first page backup entry for a pagedir.
+ * Arguments:	struct pbe2 *:	Address of the page backup entry we're 
+ * 				populating.
+ * 		struct pagedir: Pagedir providing the data.
+ */
+void get_first_pbe(struct pbe2 * pbe, struct pagedir * pagedir)
+{
+	unsigned long currentorig, currentaddress;
+
+	pbe->pagedir = pagedir;
+
+	/* Get raw initial values */
+	setup_pbe_variable((unsigned long *) &pbe->origaddress, 
+			&pbe->currentorigrange, &pagedir->origranges);
+	setup_pbe_variable((unsigned long *) &pbe->address,
+			&pbe->currentdestrange, &pagedir->destranges);
+
+	/* Convert to range values */
+	currentorig = (unsigned long) pbe->origaddress;
+	currentaddress = (unsigned long) pbe->address;
+
+	pbe->origaddress = mem_map + currentorig;
+	pbe->address = mem_map + currentaddress;
+
+	if ((currentaddress < 0) || (currentaddress > max_mapnr))
+		panic("Argh! Destination range value %ld is invalid!",
+				currentaddress);
+}
+
+/* get_next_pbe
+ *
+ * Description:	Get the next page backup entry in a pagedir.
+ * Arguments:	struct pbe2 *:	Address of the pbe we're updating.
+ */
+void get_next_pbe(struct pbe2 * pbe)
+{
+	unsigned long currentorig, currentaddress;
+
+	/* Convert to range values */
+	currentorig = (pbe->origaddress - mem_map);
+	currentaddress = (pbe->address - mem_map);
+
+	/* Update values */
+	GET_RANGE_NEXT(pbe->currentorigrange, currentorig);
+	GET_RANGE_NEXT(pbe->currentdestrange, currentaddress);
+	
+	pbe->origaddress = mem_map + currentorig;
+	pbe->address = mem_map + currentaddress;
+}
+
+/*
+ * --------------------------------------------------------------------------------------
+ *
+ * 	Local Page Flags routines.
+ *
+ * 	Rather than using the rare and precious flags in struct page, we allocate
+ * 	our own bitmaps dynamically.
+ * 
+ */
+
+/* ------------------------------------------------------------------------- */
+
+/* copy_pageset1
+ *
+ * Description:	Make the atomic copy of pageset1. We can't use copy_page (as we
+ * 		once did) because we can't be sure what side effects it has. On
+ * 		my old Duron, with 3DNOW, kernel_fpu_begin increments preempt
+ * 		count, making our preempt count at resume time 4 instead of 3.
+ * 		
+ * 		We don't want to call kmap_atomic unconditionally because it has
+ * 		the side effect of incrementing the preempt count, which will
+ * 		leave it one too high post resume (the page containing the
+ * 		preempt count will be copied after its incremented. This is
+ * 		essentially the same problem.
+ */
+
+void copy_pageset1(void)
+{
+	int i = 0;
+	struct pbe2 pbe;
+
+	get_first_pbe(&pbe, &pagedir1);
+
+	for (i = 0; i < pageset1_size; i++) {
+		int loop;
+		unsigned long * origpage;
+		unsigned long * copypage = page_address(pbe.address);
+
+	       	if (PageHighMem(pbe.origaddress))
+			origpage = kmap_atomic(pbe.origaddress, KM_USER1);
+		else
+			origpage = page_address(pbe.origaddress);
+
+		for (loop=0; loop < (PAGE_SIZE / sizeof(unsigned long)); loop++)
+			*(copypage + loop) = *(origpage + loop);
+	       	if (PageHighMem(pbe.origaddress))
+			kunmap_atomic(origpage, KM_USER1);
+
+		get_next_pbe(&pbe);
+	}
+}
+
+#ifdef CONFIG_DEBUG_PAGEALLOC
+void suspend_map_atomic_copy_pages(void)
+{
+	int i = 0;
+	struct pbe2 pbe;
+
+	get_first_pbe(&pbe, &pagedir1);
+
+	for (i = 0; i < pageset1_size; i++) {
+		int orig_was_mapped = 1, copy_was_mapped = 1;
+
+	       	if (!PageHighMem(pbe.origaddress)) {
+			orig_was_mapped = suspend_map_kernel_page(pbe.origaddress, 1);
+			if (!orig_was_mapped)
+				SetPageUnmap(pbe.origaddress);
+		}
+		copy_was_mapped = suspend_map_kernel_page(pbe.address, 1);
+		if (!copy_was_mapped)
+			SetPageUnmap(pbe.address);
+
+		get_next_pbe(&pbe);
+	}
+}
+
+void suspend_unmap_atomic_copy_pages(void)
+{
+	int i;
+	for (i = 0; i < max_mapnr; i++)
+		if (PageUnmap(mem_map + i))
+			suspend_map_kernel_page(mem_map + i, 0);
+}
+#endif
+
+/* free_pagedir
+ *
+ * Description:	Free a previously allocated pagedir.
+ * Arguments:	struct pagedir *:	Pointer to the pagedir being freed.
+ */
+void free_pagedir(struct pagedir * p)
+{
+	PRINTFREEMEM("at start of free_pagedir");
+
+	if (p->allocdranges.first) {
+		/* Free allocated pages */
+		struct range * rangepointer;
+		unsigned long pagenumber;
+		range_for_each(&p->allocdranges, rangepointer, pagenumber) {
+			ClearPageNosave(mem_map+pagenumber);
+			free_page((unsigned long) page_address(mem_map+pagenumber));
+		}
+	}
+
+	suspend_store_free_mem(SUSPEND_FREE_EXTRA_PD1, 1);
+
+	/* For pagedir 2, destranges == origranges */
+	if (p->pagedir_num == 2)
+		p->destranges.first = NULL;
+	
+	put_range_chain(&p->origranges);
+	put_range_chain(&p->destranges);
+	put_range_chain(&p->allocdranges);
+
+	PRINTFREEMEM("at end of free_pagedir");
+	suspend_message(SUSPEND_PAGESETS, SUSPEND_MEDIUM, 0,
+			"Pageset size was %d.\n", p->pageset_size);
+	p->pageset_size = 0;
+}
+
+/* PageInPagedir
+ *
+ * Description:	Determine whether a page is in a pagedir.
+ * Arguments:	struct pagedir *	The pagedir to search.
+ * 		struct page *		The page to look for.
+ * Result:	int			Bitmap of state:
+ * 					Bit 0: Source page
+ * 					Bit 1: Dest page
+ * 					Bit 2: Allocated
+ * 					(Should only result in 0, 1, 2 or 6).
+ */
+
+int PageInPagedir(struct pagedir * p, struct page * page)
+{
+	int page_sought = page_to_pfn(page);
+	int result = 0;
+
+	if (p->origranges.first) {
+		struct range * rangepointer;
+		unsigned long pagenumber;
+		range_for_each(&p->origranges, rangepointer, pagenumber) {
+			if (pagenumber == page_sought)
+				result |=  1;
+			if (pagenumber >= page_sought)
+				break;
+		}
+	}
+
+	if (p->destranges.first) {
+		/* Free allocated pages */
+		struct range * rangepointer;
+		unsigned long pagenumber;
+		range_for_each(&p->destranges, rangepointer, pagenumber) {
+			if (pagenumber == page_sought)
+				result |= 2;
+			if (pagenumber >= page_sought)
+				break;
+		}
+	}
+
+	if (p->allocdranges.first) {
+		/* Free allocated pages */
+		struct range * rangepointer;
+		unsigned long pagenumber;
+		range_for_each(&p->allocdranges, rangepointer, pagenumber) {
+			if (pagenumber == page_sought)
+				result |= 4;
+			if (pagenumber >= page_sought)
+				break;
+		}
+	}
+
+	return result;
+}
+
+/* allocate_extra_pagedir_memory
+ *
+ * Description:	Allocate memory for making the atomic copy of pagedir1 in the
+ * 		case where it is bigger than pagedir2.
+ * Arguments:	struct pagedir *: 	The pagedir for which we should 
+ * 					allocate memory.
+ * 		int:			Size of pageset 1.
+ * 		int:			Size of pageset 2.
+ * Result:	int. Zero on success. One if unable to allocate enough memory.
+ */
+int allocate_extra_pagedir_memory(struct pagedir * p, int pageset_size,
+		int alloc_from)
+{
+	int num_to_alloc = pageset_size - alloc_from - p->allocdranges.size;
+	int j, order;
+
+	prepare_status(0, 0, "Preparing page directory.");
+
+	PRINTFREEMEM("at start of allocate_extra_pagedir_memory");
+
+	if (num_to_alloc < 1)
+		num_to_alloc = 0;
+
+	if (num_to_alloc) {
+		int num_added = 0, numnosaveallocated=0;
+		int origallocd = alloc_from + p->allocdranges.size;
+	
+		PRINTFREEMEM("prior to attempt");
+
+		order = generic_fls(num_to_alloc);
+		if (order >= MAX_ORDER)
+			order = MAX_ORDER - 1;
+
+		while (num_added < num_to_alloc) {
+			struct page * newpage;
+			unsigned long virt;
+			
+			while ((1 << order) > (num_to_alloc - num_added))
+				order--;
+
+			virt = get_grabbed_pages(order);
+			while ((!virt) && (order > 0)) {
+				order--;
+				virt = get_grabbed_pages(order);
+			}
+
+			if (!virt) {
+				p->pageset_size += num_added;
+				suspend_message(SUSPEND_PAGESETS, SUSPEND_VERBOSE, 1,
+					"   Allocated (extra) memory for pages"
+					" from %d-%d (%d pages).\n",
+					origallocd + 1, pageset_size, 
+					pageset_size - origallocd);
+				printk("Couldn't get enough yet."
+						" %d pages short.\n",
+						num_to_alloc - num_added);
+				PRINTFREEMEM("at abort of "
+					"allocate_extra_pagedir_memory");
+				suspend_store_free_mem(SUSPEND_FREE_EXTRA_PD1, 0);
+				return 1;
+			}
+
+			newpage = virt_to_page(virt);
+			suspend_store_free_mem(SUSPEND_FREE_EXTRA_PD1, 0);
+			for (j = 0; j < (1 << order); j++) {
+				SetPageNosave(newpage + j);
+				/* Pages will be freed one at a time. */
+				set_page_count(newpage + j, 1);
+				add_to_range_chain(&p->allocdranges, newpage - mem_map + j);
+				numnosaveallocated++;
+			}
+			suspend_store_free_mem(SUSPEND_FREE_RANGE_PAGES, 0);
+			num_added+= (1 << order);
+		}
+		suspend_message(SUSPEND_PAGESETS, SUSPEND_VERBOSE, 1,
+			"   Allocated (extra) memory for pages "
+			"from %d-%d (%d pages).\n",
+			origallocd + 1, pageset_size, 
+			pageset_size - origallocd);
+	}
+
+	p->pageset_size = pageset_size;
+
+	suspend_store_free_mem(SUSPEND_FREE_EXTRA_PD1, 0);
+	PRINTFREEMEM("at end of allocate_extra_pagedir_memory");
+	return 0;
+}
+
+/* mark_pages_for_pageset2
+ *
+ * Description:	Mark unshared pages in processes not needed for suspend as
+ * 		being able to be written out in a separate pagedir.
+ * 		HighMem pages are simply marked as pageset2. They won't be
+ * 		needed during suspend.
+ */
+
+void mark_pages_for_pageset2(void)
+{
+	int i, numpageset2 = 0;
+	struct zone * zone;
+	unsigned long flags;
+
+	if (max_mapnr != num_physpages) {
+		abort_suspend("mapnr is not expected");
+		return;
+	}
+	
+	clear_map(pageset2_map);
+
+	/* 
+	 * Note that we don't clear the map to begin with!
+	 * This is because if we eat memory, we loose track
+	 * of LRU pages that are still in use but taken off
+	 * the LRU. If I can figure out how the VM keeps
+	 * track of them, I might be able to tweak this a
+	 * little further and decrease pageset one's size
+	 * further.
+	 *
+	 * (Memory grabbing clears the pageset2 flag on
+	 * pages that are really freed!).
+	 */
+	
+	/* Add LRU pages */
+	for_each_zone(zone) {
+		spin_lock_irqsave(&zone->lru_lock, flags);
+		if (zone->nr_inactive) {
+			struct page * page;
+			list_for_each_entry(page, &zone->inactive_list, lru)
+				SetPagePageset2(page);
+		}
+		if (zone->nr_active) {
+			struct page * page;
+			list_for_each_entry(page, &zone->active_list, lru)
+				SetPagePageset2(page);
+		}
+		spin_unlock_irqrestore(&zone->lru_lock, flags);
+	}
+
+
+	/* Ensure range pages are not Pageset2 */
+	if (num_range_pages) {
+		if (get_rangepages_list())
+			return;
+
+		for (i = 1; i <= num_range_pages; i++) {
+			struct page * page;
+			page = virt_to_page(get_rangepages_list_entry(i));
+			// Must be assigned by the time recalc stats is called
+			if (PagePageset2(page)) {
+				suspend_message(SUSPEND_PAGESETS, SUSPEND_ERROR, 1,
+					"Pagedir[%d] was marked as pageset2 -"
+					" unmarking.\n", i);
+				ClearPagePageset2(page);
+				numpageset2--;
+			}
+		}
+	}
+
+	/* Finally, ensure that Slab pages are not Pageset2. */
+
+	for (i = 0; i < max_mapnr; i++) {
+		if (PageSlab(mem_map+i)) {
+			if (TestAndClearPagePageset2(mem_map+i)) {
+				//suspend_message(SUSPEND_PAGESETS, SUSPEND_ERROR, 1,
+				printk(
+					"Found page %d is slab page "
+						"but marked pageset 2.\n", i);
+				numpageset2--;
+			}
+		}
+	}
+}
+
+/* warmup_collision_cache
+ *
+ * Description:	Mark the pages which are used by the original kernel.
+ */
+void warmup_collision_cache(void) {
+	int i;
+	struct range * rangepointer = NULL;
+	unsigned long pagenumber;
+	
+	/* Allocatemap doesn't get deallocated because it's forgotten when we
+	 * copy PageDir1 back. It doesn't matter if it collides because it is
+	 * not used during the copy back itself.
+	 */
+	allocate_local_pageflags(&in_use_map, 0);
+	suspend_message(SUSPEND_IO, SUSPEND_VERBOSE, 1, "Setting up pagedir cache...");
+	for (i = 0; i < max_mapnr; i++)
+		ClearPageInUse(mem_map+i);
+
+	range_for_each(&pagedir_resume.origranges, rangepointer, pagenumber)
+		SetPageInUse(mem_map+pagenumber);
+}
+
+/* get_pageset1_load_addresses
+ * 
+ * Description: We check here that pagedir & pages it points to won't collide
+ * 		with pages where we're going to restore from the loaded pages
+ * 		later.
+ * Returns:	Zero on success, one if couldn't find enough pages (shouldn't
+ * 		happen).
+ */
+
+int get_pageset1_load_addresses(void)
+{
+	int i, nrdone = 0, result = 0;
+	void **eaten_memory = NULL, **this;
+	struct page * pageaddr = NULL;
+
+	/*
+	 * Because we're trying to make this work when we're saving as much
+	 * memory as possible we need to remember the pages we reject here
+	 * and then free them when we're done.
+	 */
+	
+	for(i=0; i < pagedir_resume.pageset_size; i++) {
+		while ((this = (void *) get_zeroed_page(GFP_ATOMIC))) {
+			memset(this, 0, PAGE_SIZE);
+			pageaddr = virt_to_page(this);
+			if (!PageInUse(pageaddr)) {
+				break;
+			}
+			*this = eaten_memory;
+			eaten_memory = this;
+		}
+		if (!this) {
+			abort_suspend("Error: Ran out of memory seeking locations for reloading data.");
+			result = 1;
+			break;
+		}
+		add_to_range_chain(&pagedir_resume.destranges, pageaddr - mem_map);
+		nrdone++;
+	}
+
+	/* Free unwanted memory */
+	while(eaten_memory) {
+		this = eaten_memory;
+		eaten_memory = *eaten_memory;
+		free_page((unsigned long) this);
+	}
+	
+	return result;
+}
+
+/* set_chain_names
+ *
+ * Description:	Set the chain names for a pagedir. (For debugging).
+ * Arguments:	struct pagedir: The pagedir on which we want to set the names.
+ */
+
+void set_chain_names(struct pagedir * p)
+{
+	p->origranges.name = "original addresses";
+	p->destranges.name =  "destination addresses";
+	p->allocdranges.name = "allocated addresses";
+}
+
+EXPORT_SYMBOL(get_first_pbe);
+EXPORT_SYMBOL(get_next_pbe);


