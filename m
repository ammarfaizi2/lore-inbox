Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262156AbVGFDVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbVGFDVw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 23:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbVGFDVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 23:21:15 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:9881 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262074AbVGFCT2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:28 -0400
Subject: [PATCH] [36/48] Suspend2 2.1.9.8 for 2.6.12: 612-pagedir.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:43 +1000
Message-Id: <11206164431230@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 613-pageflags.patch-old/kernel/power/suspend2_core/pageflags.c 613-pageflags.patch-new/kernel/power/suspend2_core/pageflags.c
--- 613-pageflags.patch-old/kernel/power/suspend2_core/pageflags.c	1970-01-01 10:00:00.000000000 +1000
+++ 613-pageflags.patch-new/kernel/power/suspend2_core/pageflags.c	2005-07-04 23:14:19.000000000 +1000
@@ -0,0 +1,126 @@
+/*
+ * kernel/power/suspend2_core/pageflags.c
+ *
+ * Copyright (C) 2004-2005 Nigel Cunningham <ncunningham@cyclades.com>
+ * 
+ * This file is released under the GPLv2.
+ *
+ * Routines for dynamically allocating and releasing bitmaps
+ * used as pseudo-pageflags.
+ *
+ * Arrays are not contiguous. The first sizeof(void *) bytes are
+ * the pointer to the next page in the bitmap. This allows us to
+ * 1) work under low memory conditions where order 0 might be all
+ *    that's available
+ * 2) save the pages at suspend time, reload and relocate them as
+ *    necessary at resume time without breaking anything (cf
+ *    extent pages).
+ */
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/bitops.h>
+#include <linux/list.h>
+#include <linux/suspend.h>
+#include "pageflags.h"
+#include "plugins.h"
+#include "pagedir.h"
+
+/* Maps used in copying the image back are in builtin.c */
+dyn_pageflags_t pageset1_map;
+dyn_pageflags_t pageset1_copy_map;
+dyn_pageflags_t pageset2_map;
+dyn_pageflags_t in_use_map;
+dyn_pageflags_t allocd_pages_map;
+#ifdef CONFIG_DEBUG_PAGEALLOC
+dyn_pageflags_t unmap_map;
+#endif
+
+/* suspend_allocate_dyn_pageflags
+ *
+ * Description:	Allocate a bitmap for local page flags.
+ * Arguments:	dyn_pageflags_t *:	Pointer to the bitmap.
+ *
+ * A version of allocate_dyn_pageflags that saves us then having
+ * to relocate the flags when resuming.
+ */
+int suspend_allocate_dyn_pageflags(dyn_pageflags_t *pagemap)
+{
+	int i;
+
+	BUG_ON(*pagemap);
+
+	if (test_suspend_state(SUSPEND_NOW_RESUMING)) {
+		/* 
+		 * We use kfree unconditionally below. That's not a problem
+		 * because we only use this path when reloading pageset1.
+		 */
+		*pagemap = (dyn_pageflags_t) suspend2_get_nonconflicting_page();
+		if (! *pagemap) {
+			printk("Failed to allocate a non-conflicting page for pageflags.\n");
+			return 1;
+		}
+	} else 
+		*pagemap = kmalloc(sizeof(void *) * PAGES_PER_BITMAP, GFP_ATOMIC);
+
+	for (i = 0; i < PAGES_PER_BITMAP; i++) {
+		(*pagemap)[i] = (unsigned long *) get_zeroed_page(GFP_ATOMIC);
+		if (!(*pagemap)[i]) {
+			printk("Error. Unable to allocate memory for "
+					"local page flags.");
+			free_dyn_pageflags(pagemap);
+			return 1;
+		}
+	}
+	return 0;
+}
+
+/* savepageflags
+ *
+ * Description: Save a set of pageflags.
+ * Arguments:   dyn_pageflags_t *: Pointer to the bitmap being saved.
+ */
+
+void save_dyn_pageflags(dyn_pageflags_t pagemap)
+{
+	int i;
+
+	if (!*pagemap)
+		return;
+
+	for (i = 0; i < PAGES_PER_BITMAP; i++)
+		active_writer->ops.writer.write_header_chunk((char *) pagemap[i], PAGE_SIZE);
+}
+
+/* loadpageflags
+ *
+ * Description: Load a set of pageflags.
+ * Arguments:   dyn_pageflags_t *: Pointer to the bitmap being loaded.
+ *              (It must be allocated before calling this routine).
+ */
+
+void load_dyn_pageflags(dyn_pageflags_t pagemap)
+{
+	int i;
+
+	if (!pagemap)
+		return;
+
+	for (i = 0; i < PAGES_PER_BITMAP; i++)
+		active_writer->ops.writer.read_header_chunk((char *) pagemap[i], PAGE_SIZE);
+}
+
+void relocate_dyn_pageflags(dyn_pageflags_t *pagemap)
+{
+	int i;
+	LIST_HEAD(rejected_pages);
+
+	if (!*pagemap)
+		return;
+
+	suspend2_relocate_page_if_required((void *) pagemap);
+
+	for (i = 0; i < PAGES_PER_BITMAP; i++)
+		suspend2_relocate_page_if_required((void *) &((*pagemap)[i]));
+}
diff -ruNp 613-pageflags.patch-old/kernel/power/suspend2_core/pageflags.h 613-pageflags.patch-new/kernel/power/suspend2_core/pageflags.h
--- 613-pageflags.patch-old/kernel/power/suspend2_core/pageflags.h	1970-01-01 10:00:00.000000000 +1000
+++ 613-pageflags.patch-new/kernel/power/suspend2_core/pageflags.h	2005-07-05 23:48:59.000000000 +1000
@@ -0,0 +1,84 @@
+/*
+ * kernel/power/pageflags.h
+ *
+ * Copyright (C) 2004-2005 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * Suspend2 needs a few pageflags while working that aren't otherwise
+ * used. To save the struct page pageflags, we dynamically allocate
+ * a bitmap and use that. These are the only non order-0 allocations
+ * we do.
+ *
+ * NOTE!!!
+ * We assume that PAGE_SIZE - sizeof(void *) is a multiple of
+ * sizeof(unsigned long). Is this ever false?
+ */
+
+#include <linux/dyn_pageflags.h>
+#include <linux/suspend.h>
+
+extern dyn_pageflags_t in_use_map;
+extern dyn_pageflags_t allocd_pages_map;
+#ifdef CONFIG_DEBUG_PAGEALLOC
+extern dyn_pageflags_t unmap_map;
+#endif
+extern dyn_pageflags_t	pageset2_map;
+
+/* 
+ * inusemap is used in two ways: 
+ * - During suspend, to tag pages which are not used (to speed up 
+ *   count_data_pages);
+ * - During resume, to tag pages which are in pagedir1. This does not tag 
+ *   pagedir2 pages, so !== first use.
+ */
+#define PageInUse(page)	\
+	test_bit(PAGEBIT(page), PAGE_UL_PTR(in_use_map, page))
+#define SetPageInUse(page) \
+	set_bit(PAGEBIT(page), PAGE_UL_PTR(in_use_map, page))
+#define ClearPageInUse(page) \
+	clear_bit(PAGEBIT(page), PAGE_UL_PTR(in_use_map, page))
+
+#define PagePageset1(page) \
+	(pageset1_map ? test_bit(PAGEBIT(page), PAGE_UL_PTR(pageset1_map, page)): 0)
+#define SetPagePageset1(page) \
+	set_bit(PAGEBIT(page), PAGE_UL_PTR(pageset1_map, page))
+#define ClearPagePageset1(page) \
+	clear_bit(PAGEBIT(page), PAGE_UL_PTR(pageset1_map, page))
+
+#define PagePageset1Copy(page) \
+	(pageset1_copy_map ? \
+	 test_bit(PAGEBIT(page), PAGE_UL_PTR(pageset1_copy_map, page)): 0)
+#define SetPagePageset1Copy(page) \
+	set_bit(PAGEBIT(page), PAGE_UL_PTR(pageset1_copy_map, page))
+#define ClearPagePageset1Copy(page) \
+	clear_bit(PAGEBIT(page), PAGE_UL_PTR(pageset1_copy_map, page))
+
+#define PagePageset2(page) \
+	(pageset2_map ? \
+	 test_bit(PAGEBIT(page), PAGE_UL_PTR(pageset2_map, page)): 0)
+#define SetPagePageset2(page) \
+	set_bit(PAGEBIT(page), PAGE_UL_PTR(pageset2_map, page))
+#define ClearPagePageset2(page) \
+	clear_bit(PAGEBIT(page), PAGE_UL_PTR(pageset2_map, page))
+
+#define PageAllocd(page)	\
+	test_bit(PAGEBIT(page), PAGE_UL_PTR(allocd_pages_map, page))
+#define SetPageAllocd(page) \
+	set_bit(PAGEBIT(page), PAGE_UL_PTR(allocd_pages_map, page))
+#define ClearPageAllocd(page) \
+	clear_bit(PAGEBIT(page), PAGE_UL_PTR(alloc_pages_map, page))
+
+#define SetPageUnmap(page) \
+	set_bit(PAGEBIT(page), PAGE_UL_PTR(unmap_map, page))
+#define PageUnmap(page) \
+	test_bit(PAGEBIT(page), PAGE_UL_PTR(unmap_map, page))
+
+#define BITMAP_FOR_EACH_SET(bitmap, counter) \
+	for (counter = __get_next_bit_on(bitmap, -1); counter < max_mapnr; \
+		counter = __get_next_bit_on(bitmap, counter))
+
+extern void save_dyn_pageflags(dyn_pageflags_t pagemap);
+extern void load_dyn_pageflags(dyn_pageflags_t pagemap);
+int suspend_allocate_dyn_pageflags(dyn_pageflags_t *pagemap);
+void relocate_dyn_pageflags(dyn_pageflags_t *pagemap);

