Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWIJNI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWIJNI5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 09:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWIJNI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 09:08:57 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:44455 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP id S932122AbWIJNIz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 09:08:55 -0400
Date: Sun, 10 Sep 2006 15:07:44 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 1/2] own header file for struct page v3
Message-ID: <20060910130744.GA12084@osiris.ibm.com>
References: <20060908111716.GA6913@osiris.boeblingen.de.ibm.com> <Pine.LNX.4.64.0609092248400.6762@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609092248400.6762@scrub.home>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

This moves the definition of struct page from mm.h into a new header file
mm_types.h.
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
In order to avoid all these problems caused by macros it seems to
be a good idea to get rid of them and convert them to static inline
functions. Because of header file include order it's necessary to have a
seperate header file for the struct page definition.

Cc: Roman Zippel <zippel@linux-m68k.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

Updated patch:	v2:
		- against -mm
		- changed name to page-struct.h instead of page.h
		- moved mem_map declaration to mmzone.h

		v3:
		- mm_types.h instead of page-struct.h. To be used if someone
		  wants to move more definitions from mm.h to a seperate
		  header file.

 include/linux/mm.h       |   67 -------------------------------------------
 include/linux/mm_types.h |   72 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmzone.h   |    5 +++
 3 files changed, 78 insertions(+), 66 deletions(-)

Index: linux-2.6.18-rc6-mm1/include/linux/mm.h
===================================================================
--- linux-2.6.18-rc6-mm1.orig/include/linux/mm.h	2006-09-10 14:40:09.000000000 +0200
+++ linux-2.6.18-rc6-mm1/include/linux/mm.h	2006-09-10 14:45:30.000000000 +0200
@@ -16,6 +16,7 @@
 #include <linux/mutex.h>
 #include <linux/debug_locks.h>
 #include <linux/backing-dev.h>
+#include <linux/mm_types.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -215,67 +216,6 @@
 struct mmu_gather;
 struct inode;
 
-/*
- * Each physical page in the system has a struct page associated with
- * it to keep track of whatever it is we are using the page for at the
- * moment. Note that we have no way to track which tasks are using
- * a page, though if it is a pagecache page, rmap structures can tell us
- * who is mapping it.
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
-#ifdef CONFIG_PAGE_OWNER
-	int order;
-	unsigned int gfp_mask;
-	unsigned long trace[8];
-#endif
-};
-
 #define page_private(page)		((page)->private)
 #define set_page_private(page, v)	((page)->private = (v))
 
@@ -551,11 +491,6 @@
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
Index: linux-2.6.18-rc6-mm1/include/linux/mmzone.h
===================================================================
--- linux-2.6.18-rc6-mm1.orig/include/linux/mmzone.h	2006-09-10 14:40:09.000000000 +0200
+++ linux-2.6.18-rc6-mm1/include/linux/mmzone.h	2006-09-10 14:40:13.000000000 +0200
@@ -318,6 +318,11 @@
 };
 #endif /* CONFIG_ARCH_POPULATES_NODE_MAP */
 
+#ifndef CONFIG_DISCONTIGMEM
+/* The array of struct pages - for discontigmem use pgdat->lmem_map */
+extern struct page *mem_map;
+#endif
+
 /*
  * The pg_data_t structure is used in machines with CONFIG_DISCONTIGMEM
  * (mostly NUMA machines?) to denote a higher-level memory zone than the
Index: linux-2.6.18-rc6-mm1/include/linux/mm_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-rc6-mm1/include/linux/mm_types.h	2006-09-10 14:44:32.000000000 +0200
@@ -0,0 +1,72 @@
+#ifndef _LINUX_MM_TYPES_H
+#define _LINUX_MM_TYPES_H
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
+ * a page, though if it is a pagecache page, rmap structures can tell us
+ * who is mapping it.
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
+#ifdef CONFIG_PAGE_OWNER
+	int order;
+	unsigned int gfp_mask;
+	unsigned long trace[8];
+#endif
+};
+
+#endif /* _LINUX_MM_TYPES_H */
