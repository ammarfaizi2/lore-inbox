Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbVBSClj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbVBSClj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 21:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbVBSClj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 21:41:39 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:4333 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261609AbVBSClY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 21:41:24 -0500
Subject: [RFC][PATCH] Dynamically allocated pageflags.
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Dave Hansen <haveblue@us.ibm.com>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain
Message-Id: <1108780994.4077.63.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 19 Feb 2005 13:43:14 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

For some time now, we've been running out of bits for pageflags.

In Suspend2, I need the functional equivalent of pageflags, but don't
need them when Suspend isn't running. One of the outcomes of the last
submission of Suspend2 for review was that I changed the format in which
that data is stored, creating something I call dynamically allocated
pageflags.

It's a simple idea: we tie together a bunch of order zero allocated
pages using a kmalloc'd list of poiinters to those pages, and store the
location of that kmalloc'd list in what's really an unsigned long **
(typedef'd). We also provide macros so that calls for setting and
clearing flags can look just like ordinary pageflag set/clear/test
invocations.

Helpers are also provided for allocating and freeing the maps.

Speaking with Dave Hansen this morning on IRC prompted me to send this
ahead of the rest of Suspend2 (I hope to do another submission soon), so
that he (and perhaps others) can utilise it in the mean time. A couple
of obvious candidates for using these flags are the Nosave and
NoSaveFree flags.

I make no claim that the calculations are done in the most efficient
way; just that it works and is well tested.

For sample usage, see the example in dyn_pageflags.h.

Regards,

Nigel

diff -ruNp 992-dynamic-pageflags-old/include/linux/dyn_pageflags.h 992-dynamic-pageflags-new/include/linux/dyn_pageflags.h
--- 992-dynamic-pageflags-old/include/linux/dyn_pageflags.h	1970-01-01 10:00:00.000000000 +1000
+++ 992-dynamic-pageflags-new/include/linux/dyn_pageflags.h	2005-02-19 13:11:31.000000000 +1100
@@ -0,0 +1,47 @@
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
+/* Used by Suspend2 */
+extern void save_dyn_pageflags(dyn_pageflags_t pagemap);
+extern void load_dyn_pageflags(dyn_pageflags_t pagemap);
+void relocate_dyn_pageflags(dyn_pageflags_t *pagemap);
+int compare_dyn_pageflags(dyn_pageflags_t map1, dyn_pageflags_t map2);
diff -ruNp 992-dynamic-pageflags-old/lib/dyn_pageflags.c 992-dynamic-pageflags-new/lib/dyn_pageflags.c
--- 992-dynamic-pageflags-old/lib/dyn_pageflags.c	1970-01-01 10:00:00.000000000 +1000
+++ 992-dynamic-pageflags-new/lib/dyn_pageflags.c	2005-02-19 13:11:31.000000000 +1100
@@ -0,0 +1,82 @@
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
+
+EXPORT_SYMBOL(clear_dyn_pageflags);
+EXPORT_SYMBOL(allocate_dyn_pageflags);
+EXPORT_SYMBOL(free_dyn_pageflags);
diff -ruNp 992-dynamic-pageflags-old/lib/Makefile 992-dynamic-pageflags-new/lib/Makefile
--- 992-dynamic-pageflags-old/lib/Makefile	2005-02-19 13:18:07.000000000 +1100
+++ 992-dynamic-pageflags-new/lib/Makefile	2005-02-19 13:11:31.000000000 +1100
@@ -5,7 +5,8 @@
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 kobject.o kref.o idr.o div64.o parser.o int_sqrt.o \
-	 bitmap.o extable.o kobject_uevent.o prio_tree.o
+	 bitmap.o extable.o kobject_uevent.o prio_tree.o \
+	 dyn_pageflags.o
 
 ifeq ($(CONFIG_DEBUG_KOBJECT),y)
 CFLAGS_kobject.o += -DDEBUG

-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574

