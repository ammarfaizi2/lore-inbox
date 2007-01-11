Return-Path: <linux-kernel-owner+w=401wt.eu-S1030210AbXAKIFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbXAKIFV (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 03:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030206AbXAKIFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 03:05:21 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:35505 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030210AbXAKIFS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 03:05:18 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PmErpHg7LTHZO56BV5pNdtKgI56NWI+01DVItm9i4hlMd2BMQu5L3tmXCOMy040agBZP5z7jZxjeeYTyBJU+JnqrLCWw5A9MkMpuGHEvlVR+KRzcvZTbcFC7uMfUEnfn7YS19tp0kVNVihTKRCygvsqt1MZzwoSXLnvDKzIvRDI=
Message-ID: <afe668f90701110005ya2e8187pc6604c5aad24cc84@mail.gmail.com>
Date: Thu, 11 Jan 2007 16:05:16 +0800
From: "Roy Huang" <royhuang9@gmail.com>
To: Aubrey <aubreylee@gmail.com>
Subject: Re: O_DIRECT question
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>, "Andrew Morton" <akpm@osdl.org>,
       "Linus Torvalds" <torvalds@osdl.org>, "Hua Zhong" <hzhong@gmail.com>,
       "Hugh Dickins" <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, mjt@tls.msk.ru
In-Reply-To: <6d6a94c50701102354l7ab41a3bp4761566204f1d992@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>
	 <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org>
	 <6d6a94c50701102150w4c3b46d0w6981267e2b873d37@mail.gmail.com>
	 <20070110220603.f3685385.akpm@osdl.org>
	 <6d6a94c50701102245g6afe6aacxfcb2136baee5cbfa@mail.gmail.com>
	 <20070110225720.7a46e702.akpm@osdl.org>
	 <45A5E1B2.2050908@yahoo.com.au>
	 <6d6a94c50701102354l7ab41a3bp4761566204f1d992@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a embedded systerm, limiting page cache can relieve memory
fragmentation. There is a patch against 2.6.19, which limit every
opened file page cache and total pagecache. When the limit reach, it
will release the page cache overrun the limit.


Index: include/linux/pagemap.h
===================================================================
--- include/linux/pagemap.h	(revision 2628)
+++ include/linux/pagemap.h	(working copy)
@@ -12,6 +12,7 @@
 #include <asm/uaccess.h>
 #include <linux/gfp.h>

+extern int total_pagecache_limit;
 /*
  * Bits in mapping->flags.  The lower __GFP_BITS_SHIFT bits are the page
  * allocation mode flags.
Index: include/linux/fs.h
===================================================================
--- include/linux/fs.h	(revision 2628)
+++ include/linux/fs.h	(working copy)
@@ -444,6 +444,10 @@
 	spinlock_t		private_lock;	/* for use by the address_space */
 	struct list_head	private_list;	/* ditto */
 	struct address_space	*assoc_mapping;	/* ditto */
+#ifdef CONFIG_LIMIT_PAGECACHE
+	unsigned long 		pages_limit;
+	struct list_head	page_head;
+#endif
 } __attribute__((aligned(sizeof(long))));
 	/*
 	 * On most architectures that alignment is already the case; but
Index: include/linux/mm.h
===================================================================
--- include/linux/mm.h	(revision 2628)
+++ include/linux/mm.h	(working copy)
@@ -231,6 +231,9 @@
 #else
 #define VM_BUG_ON(condition) do { } while(0)
 #endif
+#ifdef CONFIG_LIMIT_PAGECACHE
+	struct list_head page_list;
+#endif

 /*
  * Methods to modify the page usage count.
@@ -1030,7 +1033,21 @@

 /* mm/page-writeback.c */
 int write_one_page(struct page *page, int wait);
+/* possible outcome of pageout() */

+typedef enum {
+	/* failed to write page out, page is locked */
+	PAGE_KEEP,
+	/* move page to the active list, page is locked */
+	PAGE_ACTIVATE,
+	/* page has been sent to the disk successfully, page is unlocked */
+	PAGE_SUCCESS,
+	/* page is clean and locked */
+	PAGE_CLEAN,
+} pageout_t;
+
+pageout_t pageout(struct page *page, struct address_space *mapping);
+
 /* readahead.c */
 #define VM_MAX_READAHEAD	128	/* kbytes */
 #define VM_MIN_READAHEAD	16	/* kbytes (includes current page) */
Index: init/Kconfig
===================================================================
--- init/Kconfig	(revision 2628)
+++ init/Kconfig	(working copy)
@@ -419,6 +419,19 @@
 	  option replaces shmem and tmpfs with the much simpler ramfs code,
 	  which may be appropriate on small systems without swap.

+config LIMIT_PAGECACHE
+	bool "Limit page caches" if EMBEDDED
+
+config PAGECACHE_LIMIT
+	int "Page cache limit for every file in page unit"
+	depends on LIMIT_PAGECACHE
+	default 32
+
+config PAGECACHE_LIMIT_TOTAL
+	int "Total page cache limit in MB unit"
+	depends on LIMIT_PAGECACHE
+	default 10
+
 choice
        prompt "Page frame management algorithm"
        default BUDDY
Index: fs/inode.c
===================================================================
--- fs/inode.c	(revision 2628)
+++ fs/inode.c	(working copy)
@@ -205,6 +205,10 @@
 	INIT_LIST_HEAD(&inode->inotify_watches);
 	mutex_init(&inode->inotify_mutex);
 #endif
+#ifdef CONFIG_LIMIT_PAGECACHE
+	INIT_LIST_HEAD(&inode->i_data.page_head);
+	inode->i_data.pages_limit = CONFIG_PAGECACHE_LIMIT;
+#endif
 }

 EXPORT_SYMBOL(inode_init_once);
Index: mm/filemap.c
===================================================================
--- mm/filemap.c	(revision 2628)
+++ mm/filemap.c	(working copy)
@@ -18,6 +18,7 @@
 #include <linux/capability.h>
 #include <linux/kernel_stat.h>
 #include <linux/mm.h>
+#include <linux/mm_inline.h>
 #include <linux/swap.h>
 #include <linux/mman.h>
 #include <linux/pagemap.h>
@@ -30,6 +31,9 @@
 #include <linux/security.h>
 #include <linux/syscalls.h>
 #include <linux/cpuset.h>
+#include <linux/rmap.h>
+#include <linux/buffer_head.h>
+#include <linux/page-flags.h>
 #include "filemap.h"
 #include "internal.h"

@@ -119,6 +123,9 @@
 	radix_tree_delete(&mapping->page_tree, page->index);
 	page->mapping = NULL;
 	mapping->nrpages--;
+#ifdef CONFIG_LIMIT_PAGECACHE
+	list_del_init(&page->page_list);
+#endif
 	__dec_zone_page_state(page, NR_FILE_PAGES);
 }

@@ -169,6 +176,96 @@
 	return 0;
 }

+#ifdef CONFIG_LIMIT_PAGECACHE
+static void balance_cache(struct address_space *mapping)
+{
+	/* Release half of the pages */
+	int count ;
+	int nr_released = 0;
+	struct page *page;
+	struct zone *zone= NULL;
+	struct pagevec freed_pvec;
+	struct list_head ret_list;
+
+	count = mapping->nrpages /2;
+	pagevec_init(&freed_pvec, 0);
+	INIT_LIST_HEAD(&ret_list);
+	lru_add_drain();
+	while(count-->0) {
+		page = list_entry(mapping->page_head.prev, struct page, page_list);
+		zone = page_zone(page);
+		TestClearPageLRU(page);
+		if (PageActive(page))
+			del_page_from_active_list(zone, page);
+		else
+			del_page_from_inactive_list(zone, page);
+
+		list_del_init(&page->page_list); /* Remove from current process's
page list */
+		get_page(page);
+
+		if (TestSetPageLocked(page))
+			goto __keep;
+		if (PageWriteback(page))
+			goto __keep_locked;
+		if (page_referenced(page, 1))
+			goto __keep_locked;
+		if (PageDirty(page)) {
+			switch(pageout(page, mapping)) {
+				case PAGE_KEEP:
+				case PAGE_ACTIVATE:
+					goto __keep_locked;
+				case PAGE_SUCCESS:
+					if (PageWriteback(page) || PageDirty(page))
+						goto __keep;
+					if (TestSetPageLocked(page))
+						goto __keep;
+					if (PageDirty(page) || PageWriteback(page))
+						goto __keep_locked;
+				case PAGE_CLEAN:
+					;
+			}
+		}
+
+		if (PagePrivate(page) && !try_to_release_page(page, GFP_KERNEL))
+			goto __keep_locked;
+		if (!remove_mapping(mapping, page))
+			goto __keep_locked;
+
+		unlock_page(page);
+		nr_released++;
+		/* This page maybe in Active LRU */
+		ClearPageActive(page);
+		ClearPageUptodate(page);
+		if (!pagevec_add(&freed_pvec, page))
+			__pagevec_release_nonlru(&freed_pvec);
+		continue;
+__keep_locked:
+		unlock_page(page);
+__keep:
+		SetPageLRU(page);
+		if (PageActive(page)) {
+			add_page_to_active_list(zone, page);
+		} else {
+			add_page_to_inactive_list(zone, page);
+		}
+
+		list_add(&page->page_list, &ret_list);
+	}
+	while(!list_empty(&ret_list)) {
+		page = list_entry(ret_list.prev, struct page, page_list);
+		list_move_tail(&page->page_list, &mapping->page_head);
+		put_page(page);
+	}
+	if (pagevec_count(&freed_pvec))
+		__pagevec_release_nonlru(&freed_pvec);
+
+	if (global_page_state(NR_FILE_PAGES) > total_pagecache_limit)
+		if (zone) {
+			wakeup_kswapd(zone, 0);
+		}
+}
+#endif
+
 /**
  * __filemap_fdatawrite_range - start writeback on mapping dirty pages in range
  * @mapping:	address space structure to write
@@ -448,6 +545,10 @@
 			page->mapping = mapping;
 			page->index = offset;
 			mapping->nrpages++;
+#ifdef CONFIG_LIMIT_PAGECACHE
+			list_add(&page->page_list, &mapping->page_head);
+#endif
+
 			__inc_zone_page_state(page, NR_FILE_PAGES);
 		}
 		write_unlock_irq(&mapping->tree_lock);
@@ -1085,6 +1186,10 @@
 		page_cache_release(cached_page);
 	if (filp)
 		file_accessed(filp);
+#ifdef CONFIG_LIMIT_PAGECACHE
+	if (mapping->nrpages >= mapping->pages_limit)
+		balance_cache(mapping);
+#endif	
 }
 EXPORT_SYMBOL(do_generic_mapping_read);

@@ -2195,6 +2300,11 @@
 	if (cached_page)
 		page_cache_release(cached_page);

+#ifdef CONFIG_LIMIT_PAGECACHE
+	if (mapping->nrpages >= mapping->pages_limit)
+		balance_cache(mapping);
+#endif
+	
 	/*
 	 * For now, when the user asks for O_SYNC, we'll actually give O_DSYNC
 	 */
Index: mm/vmscan.c
===================================================================
--- mm/vmscan.c	(revision 2628)
+++ mm/vmscan.c	(working copy)
@@ -116,6 +116,7 @@

 static LIST_HEAD(shrinker_list);
 static DECLARE_RWSEM(shrinker_rwsem);
+int total_pagecache_limit = CONFIG_PAGECACHE_LIMIT_TOTAL * 1024 / 4;

 /*
  * Add a shrinker callback to be called from the vm
@@ -292,23 +293,11 @@
 	unlock_page(page);
 }

-/* possible outcome of pageout() */
-typedef enum {
-	/* failed to write page out, page is locked */
-	PAGE_KEEP,
-	/* move page to the active list, page is locked */
-	PAGE_ACTIVATE,
-	/* page has been sent to the disk successfully, page is unlocked */
-	PAGE_SUCCESS,
-	/* page is clean and locked */
-	PAGE_CLEAN,
-} pageout_t;
-
 /*
  * pageout is called by shrink_page_list() for each dirty page.
  * Calls ->writepage().
  */
-static pageout_t pageout(struct page *page, struct address_space *mapping)
+pageout_t pageout(struct page *page, struct address_space *mapping)
 {
 	/*
 	 * If the page is dirty, only perform writeback if that write
@@ -1328,7 +1317,11 @@
 			order = pgdat->kswapd_max_order;
 		}
 		finish_wait(&pgdat->kswapd_wait, &wait);
-		balance_pgdat(pgdat, order);
+		if (global_page_state(NR_FILE_PAGES) >= total_pagecache_limit)
+			balance_pgdat(pgdat, (global_page_state(NR_FILE_PAGES) \
+						- total_pagecache_limit), order);
+		else
+			balance_pgdat(pgdat, order);
 	}
 	return 0;
 }
@@ -1344,8 +1337,10 @@
 		return;

 	pgdat = zone->zone_pgdat;
-	if (zone_watermark_ok(zone, order, zone->pages_low, 0, 0))
-		return;
+	if (zone_watermark_ok(zone, order, zone->pages_low, 0, 0)) {
+		if (global_page_state(NR_FILE_PAGES) < total_pagecache_limit)
+			return;
+	}
 	if (pgdat->kswapd_max_order < order)
 		pgdat->kswapd_max_order = order;
 	if (!cpuset_zone_allowed(zone, __GFP_HARDWALL))
