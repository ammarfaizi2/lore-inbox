Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262165AbVGFDXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbVGFDXA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 23:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262152AbVGFDTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 23:19:44 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:9625 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262070AbVGFCT1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:27 -0400
Subject: [PATCH] [35/48] Suspend2 2.1.9.8 for 2.6.12: 611-io.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:43 +1000
Message-Id: <1120616443224@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 612-pagedir.patch-old/kernel/power/suspend2_core/pagedir.c 612-pagedir.patch-new/kernel/power/suspend2_core/pagedir.c
--- 612-pagedir.patch-old/kernel/power/suspend2_core/pagedir.c	1970-01-01 10:00:00.000000000 +1000
+++ 612-pagedir.patch-new/kernel/power/suspend2_core/pagedir.c	2005-07-05 23:48:59.000000000 +1000
@@ -0,0 +1,336 @@
+/*
+ * kernel/power/pagedir.c
+ *
+ * Copyright (C) 1998-2001 Gabor Kuti <seasons@fornax.hu>
+ * Copyright (C) 1998,2001,2002 Pavel Machek <pavel@suse.cz>
+ * Copyright (C) 2002-2003 Florent Chabaud <fchabaud@free.fr>
+ * Copyright (C) 2002-2005 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * Routines for handling pagesets.
+ * Note that pbes aren't actually stored as such. They're stored as
+ * bitmaps and extents.
+ */
+
+#include <linux/suspend.h>
+#include <linux/highmem.h>
+#include <linux/bootmem.h>
+
+#include "pageflags.h"
+#include "ui.h"
+#include "pagedir.h"
+
+int extra_pagedir_pages_allocated = 0;
+static LIST_HEAD(conflicting_pages);
+
+/* suspend2_free_pagedir_data
+ *
+ * Description:	Free a previously pagedir metadata.
+ */
+void suspend2_free_pagedir_data(void)
+{
+	int pagenumber;
+
+	free_dyn_pageflags(&pageset1_map);
+	free_dyn_pageflags(&pageset2_map);
+	free_dyn_pageflags(&pageset1_copy_map);
+
+	/* Free allocated pages */
+	if (allocd_pages_map) {
+		BITMAP_FOR_EACH_SET(allocd_pages_map, pagenumber) {
+			struct page * page = pfn_to_page(pagenumber);
+			ClearPageNosave(page);
+			__free_pages(page, 0);
+			extra_pagedir_pages_allocated--;
+		}
+		free_dyn_pageflags(&allocd_pages_map);
+	}
+
+	pagedir1.pageset_size = pagedir2.pageset_size = 0;
+}
+
+/* suspend2_allocate_extra_pagedir_memory
+ *
+ * Description:	Allocate memory for making the atomic copy of pagedir1 in the
+ * 		case where it is bigger than pagedir2.
+ * Arguments:	struct pagedir *: 	The pagedir for which we should 
+ * 					allocate memory.
+ * 		int:			Size of pageset 1.
+ * 		int:			Size of pageset 2.
+ * Result:	int. Zero on success. One if unable to allocate enough memory.
+ */
+int suspend2_allocate_extra_pagedir_memory(struct pagedir * p, int pageset_size,
+		int alloc_from)
+{
+	int num_to_alloc = pageset_size - alloc_from - extra_pagedir_pages_allocated;
+	int j, order;
+
+	if (num_to_alloc < 1)
+		num_to_alloc = 0;
+
+	if (num_to_alloc) {
+		int num_added = 0;
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
+			virt = __get_free_pages(GFP_ATOMIC, order);
+			while ((!virt) && (order > 0)) {
+				order--;
+				virt = __get_free_pages(GFP_ATOMIC, order);
+			}
+
+			if (!virt) {
+				p->pageset_size += num_added;
+				return 1;
+			}
+
+			newpage = virt_to_page(virt);
+			for (j = 0; j < (1 << order); j++) {
+				SetPageNosave(newpage + j);
+				/* Pages will be freed one at a time. */
+				set_page_count(newpage + j, 1);
+				SetPageAllocd(newpage + j);
+				extra_pagedir_pages_allocated++;
+			}
+			num_added+= (1 << order);
+		}
+	}
+
+	//p->pageset_size = pageset_size;
+	return 0;
+}
+
+/*
+ * suspend2_mark_task_as_pageset1
+ * Functionality   : Marks all the pages belonging to a given process as
+ *                   pageset 1 pages.
+ * Called From     : pagedir.c - mark_pages_for_pageset2
+ *
+ * This is a builtin to avoid exporting follow_page.
+ */
+void suspend2_mark_task_as_pageset1(struct task_struct *t)
+{
+	struct vm_area_struct *vma;
+	struct mm_struct *mm;
+
+	mm = t->active_mm;
+
+	if (!mm || !mm->mmap) return;
+
+	down_read(&mm->mmap_sem);
+	for (vma = mm->mmap; vma; vma = vma->vm_next) {
+		unsigned long posn;
+
+		if (!vma->vm_start)
+			continue;
+
+		for (posn = vma->vm_start; posn < vma->vm_end; posn += PAGE_SIZE) {
+			struct page *page = follow_page(mm, posn, 0);
+			if (page)
+				ClearPagePageset2(page);
+		}
+	}
+	up_read(&mm->mmap_sem);
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
+void suspend2_mark_pages_for_pageset2(void)
+{
+	struct zone * zone;
+	struct task_struct *p, *g;
+	unsigned long flags;
+	int i;
+
+	clear_dyn_pageflags(pageset2_map);
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
+	/* Now we find all userspace process (with task->mm) marked PF_NOFREEZE
+	 * and move them into pageset1.
+	 */
+	read_lock(&tasklist_lock);
+	do_each_thread(g, p) {
+		if ((p->mm || p->active_mm) && (p->flags & PF_NOFREEZE))
+			suspend2_mark_task_as_pageset1(p);
+	} while_each_thread(g, p);
+	read_unlock(&tasklist_lock);
+
+	for (i = 0; i < max_pfn; i++) {
+		struct page * page = pfn_to_page(i);
+		BUG_ON(PagePageset2(page) && PageSlab(page));
+	}
+}
+
+/* suspend2_get_nonconflicting_pages
+ *
+ * Description: Gets higher-order pages that won't be overwritten
+ *		while copying the original pages.
+ *
+ *		Note that if only one of the allocated pages overlaps
+ *		with the pages that overlap, another set must be
+ *		tried. Therefore, you shouldn't use this function
+ *		much, and not with high orders.
+ */
+
+unsigned long suspend2_get_nonconflicting_pages(const int order)
+{
+	struct page * page;
+	unsigned long new_page;
+	int more = 0;
+	unsigned long pgcount;
+
+	do {
+		new_page = __get_free_pages(GFP_ATOMIC | __GFP_NOWARN, order);
+		if (!new_page)
+			return 0;
+		more = 0;
+		for (pgcount = 0; pgcount < (1UL << order); pgcount++) {
+			page = virt_to_page(new_page + PAGE_SIZE * pgcount);
+			if (PagePageset1(page)) {
+				more = 1;
+				break;
+			}
+		}
+		if (more) {
+			page = virt_to_page(new_page);
+			list_add(&page->lru, &conflicting_pages);
+
+			/* since this page is technically free, we can abuse it to
+			 * store the order. When we resume it'll just be overwritten,
+			 * but we need this value when freeing it in
+			 * suspend2_release_conflicting_pages. */
+			*((int*)new_page) = order;
+		}
+	}
+	while (more);
+
+	memset((void*)new_page, 0, PAGE_SIZE * (1<<order));
+	return new_page;
+}
+
+/* suspend2_get_nonconflicting_page
+ *
+ * Description: Gets a page that will not be overwritten as we copy the
+ * 		original kernel page.
+ */
+
+unsigned long suspend2_get_nonconflicting_page(void)
+{
+	return suspend2_get_nonconflicting_pages(0);
+}
+
+/* suspend2_release_conflicting_pages
+ *
+ * Description: Release conflicting pages. If we resume, we don't care (their
+ * 		status will not matter), but if we abort for some reason, they
+ * 		should not leak.
+ */
+
+void suspend2_release_conflicting_pages(void)
+{
+	struct page *this_page, *next;
+	int order;
+
+	list_for_each_entry_safe(this_page, next, &conflicting_pages, lru)
+	{
+		order = *((int*)(page_address(this_page)));
+		__free_pages(virt_to_page(this_page), order);
+	}
+}
+
+/* relocate_page_if_required
+ *
+ * Description: Given the address of a pointer to a page, we check if the page
+ * 		needs relocating and do so if needs be, adjusting the pointer
+ * 		too.
+ */
+
+void suspend2_relocate_page_if_required(void ** page_pointer_addr)
+{
+	void * current_value = *page_pointer_addr;
+	if PagePageset1(virt_to_page(current_value)) {
+		unsigned long * new_page = (unsigned long *) suspend2_get_nonconflicting_page();
+		memcpy(new_page, current_value, PAGE_SIZE);
+		free_pages((unsigned long) current_value, 0);
+		*page_pointer_addr = new_page;
+	}
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
+int suspend2_get_pageset1_load_addresses(void)
+{
+	int i, nrdone = 0, result = 0;
+	void *this;
+
+	/*
+	 * Because we're trying to make this work when we're saving as much
+	 * memory as possible we need to remember the pages we reject here
+	 * and then free them when we're done.
+	 */
+	
+	for(i=0; i < pagedir1.pageset_size; i++) {
+		this = (void *) suspend2_get_nonconflicting_page();
+		if (!this) {
+			abort_suspend("Error: Ran out of memory seeking locations for reloading data.");
+			result = 1;
+			break;
+		}
+		SetPagePageset1Copy(virt_to_page(this));
+		nrdone++;
+	}
+	suspend2_release_conflicting_pages();
+
+	return result;
+}
diff -ruNp 612-pagedir.patch-old/kernel/power/suspend2_core/pagedir.h 612-pagedir.patch-new/kernel/power/suspend2_core/pagedir.h
--- 612-pagedir.patch-old/kernel/power/suspend2_core/pagedir.h	1970-01-01 10:00:00.000000000 +1000
+++ 612-pagedir.patch-new/kernel/power/suspend2_core/pagedir.h	2005-07-04 23:14:19.000000000 +1000
@@ -0,0 +1,55 @@
+/*
+ * kernel/power/suspend2_core/pagedir.h
+ *
+ * Copyright (C) 2004-2005 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * Declarations for routines for handling pagesets.
+ */
+
+/* Pagedir
+ *
+ * Contains the metadata for a set of pages saved in the image.
+ */
+
+struct pagedir {
+	int pageset_size;
+	int lastpageset_size;
+};
+
+extern struct pagedir pagedir1, pagedir2;
+
+#define pageset1_size (pagedir1.pageset_size)
+#define pageset2_size (pagedir2.pageset_size)
+
+extern void suspend2_copy_pageset1(void);
+
+extern void suspend2_free_pagedir_data(void);
+
+extern int suspend2_allocate_extra_pagedir_memory(struct pagedir * p, int pageset_size, int alloc_from);
+
+extern void suspend2_mark_task_as_pageset1 (struct task_struct *t);
+extern void suspend2_mark_pages_for_pageset2(void);
+
+extern void suspend2_release_conflicting_pages(void);
+extern void suspend2_relocate_page_if_required(void ** page_pointer_addr);
+extern int suspend2_get_pageset1_load_addresses(void);
+
+extern int extra_pagedir_pages_allocated;
+
+#ifdef CONFIG_DEBUG_PAGEALLOC
+/* Returns whether it was already in the requested state */
+extern int suspend2_map_kernel_page(struct page * page, int enable);
+
+extern void suspend2_map_atomic_copy_pages(void);
+extern void suspend2_unmap_atomic_copy_pages(void);
+#else
+#define suspend2_map_atomic_copy_pages() do { } while(0)
+#define suspend2_unmap_atomic_copy_pages() do { } while(0)
+static inline int suspend2_map_kernel_page(struct page * page, int enable)
+{
+	return 1;
+}
+#endif
+

