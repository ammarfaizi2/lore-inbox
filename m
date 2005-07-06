Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262046AbVGFCWC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbVGFCWC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 22:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbVGFCVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 22:21:42 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:62616 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262049AbVGFCTQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:16 -0400
Subject: [PATCH] [15/48] Suspend2 2.1.9.8 for 2.6.12: 405-clear-swapfile-bdev-in-swapoff.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:41 +1000
Message-Id: <11206164413510@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 406-dynamic-pageflags.patch-old/include/linux/dyn_pageflags.h 406-dynamic-pageflags.patch-new/include/linux/dyn_pageflags.h
--- 406-dynamic-pageflags.patch-old/include/linux/dyn_pageflags.h	1970-01-01 10:00:00.000000000 +1000
+++ 406-dynamic-pageflags.patch-new/include/linux/dyn_pageflags.h	2005-07-04 23:14:20.000000000 +1000
@@ -0,0 +1,63 @@
+/*
+ * include/linux/dyn_pageflags.h
+ *
+ * Copyright (C) 2004-2005 Nigel Cunningham <ncunningham@cyclades.com>
+ *
+ * This file is released under the GPLv2.
+ *
+ * It implements support for dynamically allocated bitmaps that are
+ * used for temporary or infrequently used pageflags, in lieu of
+ * bits in the struct page flags entry.
+ */
+
+#ifndef DYN_PAGEFLAGS_H
+#define DYN_PAGEFLAGS_H
+
+#include <linux/mm.h>
+
+typedef unsigned long ** dyn_pageflags_t;
+
+#define BITNUMBER(page) (page_to_pfn(page))
+
+#define PAGEBIT(page) ((int) ((page_to_pfn(page))%(8 * sizeof(unsigned long))))
+
+#define BITS_PER_PAGE (PAGE_SIZE * 8)
+#define PAGES_PER_BITMAP ((max_mapnr + BITS_PER_PAGE - 1) / BITS_PER_PAGE)
+#define PAGENUMBER(page) (BITNUMBER(page) / BITS_PER_PAGE)
+
+#define PAGEINDEX(page) ((BITNUMBER(page) - (BITS_PER_PAGE * PAGENUMBER(page)))/(8*sizeof(unsigned long)))
+
+#define PAGE_UL_PTR(bitmap, pagenum) ((bitmap[PAGENUMBER(pagenum)])+PAGEINDEX(pagenum))
+
+#define __get_next_bit_on_safe(bitmap, counter) \
+	do { \
+		(counter)++; \
+	} while(((counter) < max_mapnr) && \
+		(!test_bit(PAGEBIT(pfn_to_page((counter))), \
+			PAGE_UL_PTR(bitmap, pfn_to_page((counter))))));
+
+static inline int __get_next_bit_on(dyn_pageflags_t bitmap, int counter)
+{
+	do {
+		counter++;
+	} while((counter < max_mapnr) &&
+		(!test_bit(PAGEBIT(pfn_to_page(counter)),
+			PAGE_UL_PTR(bitmap, pfn_to_page(counter)))));
+	return counter;
+}
+
+/* With the above macros defined, you can do...
+
+#define PageInUse(page)	\
+	test_bit(PAGEBIT(page), PAGE_UL_PTR(in_use_map, page))
+#define SetPageInUse(page) \
+	set_bit(PAGEBIT(page), PAGE_UL_PTR(in_use_map, page))
+#define ClearPageInUse(page) \
+	clear_bit(PAGEBIT(page), PAGE_UL_PTR(in_use_map, page))
+*/
+
+extern void clear_dyn_pageflags(dyn_pageflags_t pagemap);
+extern int allocate_dyn_pageflags(dyn_pageflags_t *pagemap);
+extern int free_dyn_pageflags(dyn_pageflags_t *pagemap);
+
+#endif
diff -ruNp 406-dynamic-pageflags.patch-old/lib/dyn_pageflags.c 406-dynamic-pageflags.patch-new/lib/dyn_pageflags.c
--- 406-dynamic-pageflags.patch-old/lib/dyn_pageflags.c	1970-01-01 10:00:00.000000000 +1000
+++ 406-dynamic-pageflags.patch-new/lib/dyn_pageflags.c	2005-07-04 23:14:20.000000000 +1000
@@ -0,0 +1,78 @@
+/*
+ * lib/dyn_pageflags.c
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
+ * work under low memory conditions where order 0 might be all
+ * that's available. In their original use (suspend2), it also
+ * lets us save the pages at suspend time, reload and relocate them
+ * as necessary at resume time without much effort.
+ */
+
+#include <linux/module.h>
+#include <linux/dyn_pageflags.h>
+
+/* clear_map
+ *
+ * Description:	Clear an array used to store local page flags.
+ * Arguments:	dyn_pageflags_t:	The pagemap to be cleared.
+ */
+
+void clear_dyn_pageflags(dyn_pageflags_t pagemap)
+{
+	int i = 0;
+	
+	for (i = 0; i < PAGES_PER_BITMAP; i++)
+		memset((pagemap[i]), 0, PAGE_SIZE);
+}
+
+/* allocate_local_pageflags
+ *
+ * Description:	Allocate a bitmap for local page flags.
+ * Arguments:	dyn_pageflags_t *:	Pointer to the bitmap.
+ */
+int allocate_dyn_pageflags(dyn_pageflags_t *pagemap)
+{
+	int i;
+
+	BUG_ON(*pagemap);
+
+	*pagemap = kmalloc(sizeof(void *) * PAGES_PER_BITMAP, GFP_ATOMIC);
+
+	for (i = 0; i < PAGES_PER_BITMAP; i++) {
+		(*pagemap)[i] = (unsigned long *) get_zeroed_page(GFP_ATOMIC);
+		if (!(*pagemap)[i]) {
+			printk("Error. Unable to allocate memory for "
+					"dynamic pageflags.");
+			free_dyn_pageflags(pagemap);
+			return 1;
+		}
+	}
+	return 0;
+}
+
+/* free_dyn_pageflags
+ *
+ * Description:	Free a dynamically allocated pageflags bitmap.
+ * Arguments:	dyn_pageflags_t *: Pointer to the bitmap being freed.
+ */
+int free_dyn_pageflags(dyn_pageflags_t *pagemap)
+{
+	int i = 0;
+	if (!*pagemap)
+		return 1;
+	
+	for (i = 0; i < PAGES_PER_BITMAP; i++)
+		free_pages((unsigned long) (*pagemap)[i], 0);
+	
+	kfree(*pagemap);
+	*pagemap = NULL;
+	return 0;
+}
diff -ruNp 406-dynamic-pageflags.patch-old/lib/Makefile 406-dynamic-pageflags.patch-new/lib/Makefile
--- 406-dynamic-pageflags.patch-old/lib/Makefile	2005-06-20 11:47:32.000000000 +1000
+++ 406-dynamic-pageflags.patch-new/lib/Makefile	2005-07-04 23:14:20.000000000 +1000
@@ -8,7 +8,7 @@ lib-y := errno.o ctype.o string.o vsprin
 	 bitmap.o extable.o kobject_uevent.o prio_tree.o sha1.o \
 	 halfmd4.o
 
-obj-y += sort.o parser.o
+obj-y += sort.o parser.o dyn_pageflags.o
 
 ifeq ($(CONFIG_DEBUG_KOBJECT),y)
 CFLAGS_kobject.o += -DDEBUG

