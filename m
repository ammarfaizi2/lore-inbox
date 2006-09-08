Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbWIHLSB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWIHLSB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 07:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWIHLSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 07:18:01 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:4178 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750805AbWIHLSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 07:18:00 -0400
Date: Fri, 8 Sep 2006 13:17:16 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 1/2] own header file for struct page.
Message-ID: <20060908111716.GA6913@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

This moves the definition of struct page from mm.h to its own header file
page.h.
This is a prereq to fix SetPageUptodate which is broken on s390:

#define SetPageUptodate(_page)
       do {
               struct page *__page = (_page);
               if (!test_and_set_bit(PG_uptodate, &__page->flags))
                       page_test_and_clear_dirty(_page);
       } while (0)

_page gets used twice in this macro which can cause subtle bugs. Using
__page for the page_test_and_clear_dirty call doesn't work since it
causes yet another problem with the page_test_and_clear_dirty macro as
well.
In order to get of all these problems caused by macros it seems to
be a good idea to get rid of them and convert them to static inline
functions. Because of header file include order it's necessary to have a
seperate header file for the struct page definition.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

Patches are against git tree as of today. Better ideas welcome of course.

 include/linux/mm.h   |   64 --------------------------------------------
 include/linux/page.h |   74 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+), 63 deletions(-)

Index: linux-2.6/include/linux/mm.h
===================================================================
--- linux-2.6.orig/include/linux/mm.h	2006-09-08 10:46:25.000000000 +0200
+++ linux-2.6/include/linux/mm.h	2006-09-08 12:41:49.000000000 +0200
@@ -15,6 +15,7 @@
 #include <linux/fs.h>
 #include <linux/mutex.h>
 #include <linux/debug_locks.h>
+#include <linux/page.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -215,64 +216,6 @@
 struct inode;
 
 /*
- * Each physical page in the system has a struct page associated with
- * it to keep track of whatever it is we are using the page for at the
- * moment. Note that we have no way to track which tasks are using
- * a page.
- */
-struct page {
-	unsigned long flags;		/* Atomic flags, some possibly
-					 * updated asynchronously */
-	atomic_t _count;		/* Usage count, see below. */
-	atomic_t _mapcount;		/* Count of ptes mapped in mms,
-					 * to show when page is mapped
-					 * & limit reverse map searches.
-					 */
-	union {
-	    struct {
-		unsigned long private;		/* Mapping-private opaque data:
-					 	 * usually used for buffer_heads
-						 * if PagePrivate set; used for
-						 * swp_entry_t if PageSwapCache;
-						 * indicates order in the buddy
-						 * system if PG_buddy is set.
-						 */
-		struct address_space *mapping;	/* If low bit clear, points to
-						 * inode address_space, or NULL.
-						 * If page mapped as anonymous
-						 * memory, low bit is set, and
-						 * it points to anon_vma object:
-						 * see PAGE_MAPPING_ANON below.
-						 */
-	    };
-#if NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS
-	    spinlock_t ptl;
-#endif
-	};
-	pgoff_t index;			/* Our offset within mapping. */
-	struct list_head lru;		/* Pageout list, eg. active_list
-					 * protected by zone->lru_lock !
-					 */
-	/*
-	 * On machines where all RAM is mapped into kernel address space,
-	 * we can simply calculate the virtual address. On machines with
-	 * highmem some memory is mapped into kernel virtual memory
-	 * dynamically, so we need a place to store that address.
-	 * Note that this field could be 16 bits on x86 ... ;)
-	 *
-	 * Architectures with slow multiplication can define
-	 * WANT_PAGE_VIRTUAL in asm/page.h
-	 */
-#if defined(WANT_PAGE_VIRTUAL)
-	void *virtual;			/* Kernel virtual address (NULL if
-					   not kmapped, ie. highmem) */
-#endif /* WANT_PAGE_VIRTUAL */
-};
-
-#define page_private(page)		((page)->private)
-#define set_page_private(page, v)	((page)->private = (v))
-
-/*
  * FIXME: take this include out, include page-flags.h in
  * files which need it (119 of them)
  */
@@ -521,11 +464,6 @@
  */
 #include <linux/vmstat.h>
 
-#ifndef CONFIG_DISCONTIGMEM
-/* The array of struct pages - for discontigmem use pgdat->lmem_map */
-extern struct page *mem_map;
-#endif
-
 static __always_inline void *lowmem_page_address(struct page *page)
 {
 	return __va(page_to_pfn(page) << PAGE_SHIFT);
Index: linux-2.6/include/linux/page.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/include/linux/page.h	2006-09-08 13:10:23.000000000 +0200
@@ -0,0 +1,74 @@
+#ifndef _LINUX_PAGE_H
+#define _LINUX_PAGE_H
+
+#include <linux/types.h>
+#include <linux/threads.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+
+struct address_space;
+
+/*
+ * Each physical page in the system has a struct page associated with
+ * it to keep track of whatever it is we are using the page for at the
+ * moment. Note that we have no way to track which tasks are using
+ * a page.
+ */
+struct page {
+	unsigned long flags;		/* Atomic flags, some possibly
+					 * updated asynchronously */
+	atomic_t _count;		/* Usage count, see below. */
+	atomic_t _mapcount;		/* Count of ptes mapped in mms,
+					 * to show when page is mapped
+					 * & limit reverse map searches.
+					 */
+	union {
+	    struct {
+		unsigned long private;		/* Mapping-private opaque data:
+						 * usually used for buffer_heads
+						 * if PagePrivate set; used for
+						 * swp_entry_t if PageSwapCache;
+						 * indicates order in the buddy
+						 * system if PG_buddy is set.
+						 */
+		struct address_space *mapping;	/* If low bit clear, points to
+						 * inode address_space, or NULL.
+						 * If page mapped as anonymous
+						 * memory, low bit is set, and
+						 * it points to anon_vma object:
+						 * see PAGE_MAPPING_ANON below.
+						 */
+	    };
+#if NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS
+	    spinlock_t ptl;
+#endif
+	};
+	pgoff_t index;			/* Our offset within mapping. */
+	struct list_head lru;		/* Pageout list, eg. active_list
+					 * protected by zone->lru_lock !
+					 */
+	/*
+	 * On machines where all RAM is mapped into kernel address space,
+	 * we can simply calculate the virtual address. On machines with
+	 * highmem some memory is mapped into kernel virtual memory
+	 * dynamically, so we need a place to store that address.
+	 * Note that this field could be 16 bits on x86 ... ;)
+	 *
+	 * Architectures with slow multiplication can define
+	 * WANT_PAGE_VIRTUAL in asm/page.h
+	 */
+#if defined(WANT_PAGE_VIRTUAL)
+	void *virtual;			/* Kernel virtual address (NULL if
+					   not kmapped, ie. highmem) */
+#endif /* WANT_PAGE_VIRTUAL */
+};
+
+#define page_private(page)		((page)->private)
+#define set_page_private(page, v)	((page)->private = (v))
+
+#ifndef CONFIG_DISCONTIGMEM
+/* The array of struct pages - for discontigmem use pgdat->lmem_map */
+extern struct page *mem_map;
+#endif
+
+#endif /*_LINUX_PAGE_H */
