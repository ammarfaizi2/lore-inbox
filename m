Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbWDDJcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbWDDJcK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 05:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbWDDJcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 05:32:10 -0400
Received: from mail.suse.de ([195.135.220.2]:49585 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932429AbWDDJcI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 05:32:08 -0400
From: Nick Piggin <npiggin@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>
Message-Id: <20060219020159.9923.94877.sendpatchset@linux.site>
In-Reply-To: <20060219020140.9923.43378.sendpatchset@linux.site>
References: <20060219020140.9923.43378.sendpatchset@linux.site>
Subject: [patch 2/3] mm: speculative get_page
Date: Tue,  4 Apr 2006 11:32:01 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If we can be sure that elevating the page_count on a pagecache
page will pin it, we can speculatively run this operation, and
subsequently check to see if we hit the right page rather than
relying on holding a lock or otherwise pinning a reference to the
page.

This can be done if get_page/put_page behaves consistently
throughout the whole tree (ie. if we "get" the page after it has
been used for something else, we must be able to free it with a
put_page).

Actually, there is a period where the count behaves differently:
when the page is free or if it is a constituent page of a compound
page. We need an atomic_inc_not_zero operation to ensure we don't
try to grab the page in either case.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/include/linux/page-flags.h
===================================================================
--- linux-2.6.orig/include/linux/page-flags.h
+++ linux-2.6/include/linux/page-flags.h
@@ -76,6 +76,9 @@
 #define PG_nosave_free		18	/* Free, should not be written */
 #define PG_uncached		19	/* Page has been mapped as uncached */
 
+#define PG_nonewrefs		20	/* Block concurrent pagecache lookups
+					 * while testing refcount */
+
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
  * allowed.
@@ -346,6 +349,11 @@ extern void __mod_page_state_offset(unsi
 #define SetPageUncached(page)	set_bit(PG_uncached, &(page)->flags)
 #define ClearPageUncached(page)	clear_bit(PG_uncached, &(page)->flags)
 
+#define PageNoNewRefs(page)	test_bit(PG_nonewrefs, &(page)->flags)
+#define SetPageNoNewRefs(page)	set_bit(PG_nonewrefs, &(page)->flags)
+#define ClearPageNoNewRefs(page) clear_bit(PG_nonewrefs, &(page)->flags)
+#define __ClearPageNoNewRefs(page) __clear_bit(PG_nonewrefs, &(page)->flags)
+
 struct page;	/* forward declaration */
 
 int test_clear_page_dirty(struct page *page);
Index: linux-2.6/include/linux/pagemap.h
===================================================================
--- linux-2.6.orig/include/linux/pagemap.h
+++ linux-2.6/include/linux/pagemap.h
@@ -11,6 +11,8 @@
 #include <linux/compiler.h>
 #include <asm/uaccess.h>
 #include <linux/gfp.h>
+#include <linux/page-flags.h>
+#include <linux/hardirq.h> /* for in_interrupt() */
 
 /*
  * Bits in mapping->flags.  The lower __GFP_BITS_SHIFT bits are the page
@@ -51,6 +53,91 @@ static inline void mapping_set_gfp_mask(
 #define page_cache_release(page)	put_page(page)
 void release_pages(struct page **pages, int nr, int cold);
 
+static inline struct page *page_cache_get_speculative(struct page **pagep)
+{
+	struct page *page;
+
+	VM_BUG_ON(in_interrupt());
+
+#ifndef CONFIG_SMP
+	page = *pagep;
+	if (unlikely(!page))
+		return NULL;
+
+	VM_BUG_ON(!in_atomic());
+	/*
+	 * Preempt must be disabled here - we rely on rcu_read_lock doing
+	 * this for us.
+	 *
+	 * Pagecache won't be truncated from interrupt context, so if we have
+	 * found a page in the radix tree here, we have pinned its refcount by
+	 * disabling preempt, and hence no need for the "speculative get" that
+	 * SMP requires.
+	 */
+	VM_BUG_ON(page_count(page) == 0);
+	atomic_inc(&page->_count);
+	VM_BUG_ON(page != *pagep);
+
+#else
+ again:
+	page = rcu_dereference(*pagep);
+	if (unlikely(!page))
+		return NULL;
+
+	if (unlikely(!get_page_unless_zero(page)))
+		goto again; /* page has been freed */
+
+	/*
+	 * Note that get_page_unless_zero provides a memory barrier.
+	 * This is needed to ensure PageNoNewRefs is evaluated after the
+	 * page refcount has been raised. See below comment.
+	 */
+
+	/*
+	 * PageNoNewRefs is set in order to prevent new references to the
+	 * page (eg. before it gets removed from pagecache). Wait until it
+	 * becomes clear (and checks below will ensure we still have the
+	 * correct one).
+	 */
+	while (unlikely(PageNoNewRefs(page)))
+		cpu_relax();
+
+	/*
+	 * smp_rmb is to ensure the load of page->flags (for PageNoNewRefs())
+	 * is performed before the load of *pagep in the below comparison.
+	 *
+	 * Those places that set PageNoNewRefs have the following pattern:
+	 * 	SetPageNoNewRefs(page)
+	 * 	wmb();
+	 * 	if (page_count(page) == X)
+	 * 		remove page from pagecache
+	 * 	wmb();
+	 * 	ClearPageNoNewRefs(page)
+	 *
+	 * So PageNoNewRefs() becomes clear _after_ we've elevated page
+	 * refcount, then either the page will be safely pinned in pagecache,
+	 * or it will have been already removed. In the latter case, *pagep
+	 * will be changed in the below test - provided it is loaded after
+	 * testing PageNoNewRefs() (which is what the smp_rmb is for).
+	 *
+	 * If the load was out of order, *pagep might be loaded before the
+	 * page is removed from pagecache while PageNoNewRefs evaluated after
+	 * the ClearPageNoNewRefs().
+	 */
+	smp_rmb();
+
+	if (unlikely(page != *pagep)) {
+		/* page no longer at *pagep */
+		put_page(page);
+		goto again;
+	}
+
+#endif
+	VM_BUG_ON(PageCompound(page) && (struct page *)page_private(page) != page);
+
+	return page;
+}
+
 #ifdef CONFIG_NUMA
 extern struct page *page_cache_alloc(struct address_space *x);
 extern struct page *page_cache_alloc_cold(struct address_space *x);
Index: linux-2.6/mm/vmscan.c
===================================================================
--- linux-2.6.orig/mm/vmscan.c
+++ linux-2.6/mm/vmscan.c
@@ -365,6 +365,7 @@ int remove_mapping(struct address_space 
 	if (!mapping)
 		return 0;		/* truncate got there first */
 
+	SetPageNoNewRefs(page);
 	write_lock_irq(&mapping->tree_lock);
 
 	/*
@@ -383,17 +384,20 @@ int remove_mapping(struct address_space 
 		__delete_from_swap_cache(page);
 		write_unlock_irq(&mapping->tree_lock);
 		swap_free(swap);
-		__put_page(page);	/* The pagecache ref */
-		return 1;
+		goto free_it;
 	}
 
 	__remove_from_page_cache(page);
 	write_unlock_irq(&mapping->tree_lock);
-	__put_page(page);
+
+free_it:
+	__ClearPageNoNewRefs(page);
+	__put_page(page); /* The pagecache ref */
 	return 1;
 
 cannot_free:
 	write_unlock_irq(&mapping->tree_lock);
+	ClearPageNoNewRefs(page);
 	return 0;
 }
 
Index: linux-2.6/mm/filemap.c
===================================================================
--- linux-2.6.orig/mm/filemap.c
+++ linux-2.6/mm/filemap.c
@@ -407,6 +407,7 @@ int add_to_page_cache(struct page *page,
 	int error = radix_tree_preload(gfp_mask & ~__GFP_HIGHMEM);
 
 	if (error == 0) {
+		SetPageNoNewRefs(page);
 		write_lock_irq(&mapping->tree_lock);
 		error = radix_tree_insert(&mapping->page_tree, offset, page);
 		if (!error) {
@@ -418,6 +419,7 @@ int add_to_page_cache(struct page *page,
 			pagecache_acct(1);
 		}
 		write_unlock_irq(&mapping->tree_lock);
+		ClearPageNoNewRefs(page);
 		radix_tree_preload_end();
 	}
 	return error;
Index: linux-2.6/mm/swap_state.c
===================================================================
--- linux-2.6.orig/mm/swap_state.c
+++ linux-2.6/mm/swap_state.c
@@ -78,6 +78,7 @@ static int __add_to_swap_cache(struct pa
 	BUG_ON(PagePrivate(page));
 	error = radix_tree_preload(gfp_mask);
 	if (!error) {
+		SetPageNoNewRefs(page);
 		write_lock_irq(&swapper_space.tree_lock);
 		error = radix_tree_insert(&swapper_space.page_tree,
 						entry.val, page);
@@ -90,6 +91,7 @@ static int __add_to_swap_cache(struct pa
 			pagecache_acct(1);
 		}
 		write_unlock_irq(&swapper_space.tree_lock);
+		ClearPageNoNewRefs(page);
 		radix_tree_preload_end();
 	}
 	return error;
Index: linux-2.6/mm/migrate.c
===================================================================
--- linux-2.6.orig/mm/migrate.c
+++ linux-2.6/mm/migrate.c
@@ -28,8 +28,6 @@
 
 #include "internal.h"
 
-#include "internal.h"
-
 /* The maximum number of pages to take off the LRU for migration */
 #define MIGRATE_CHUNK_SIZE 256
 
@@ -225,6 +223,7 @@ int migrate_page_remove_references(struc
 	if (page_mapcount(page))
 		return -EAGAIN;
 
+	SetPageNoNewRefs(page);
 	write_lock_irq(&mapping->tree_lock);
 
 	radix_pointer = (struct page **)radix_tree_lookup_slot(
@@ -234,6 +233,7 @@ int migrate_page_remove_references(struc
 	if (!page_mapping(page) || page_count(page) != nr_refs ||
 			*radix_pointer != page) {
 		write_unlock_irq(&mapping->tree_lock);
+		ClearPageNoNewRefs(page);
 		return 1;
 	}
 
@@ -253,9 +253,13 @@ int migrate_page_remove_references(struc
 		set_page_private(newpage, page_private(page));
 	}
 
-	*radix_pointer = newpage;
+	SetPageNoNewRefs(newpage);
+	rcu_assign_pointer(*radix_pointer, newpage);
+
+  	write_unlock_irq(&mapping->tree_lock);
 	__put_page(page);
-	write_unlock_irq(&mapping->tree_lock);
+	ClearPageNoNewRefs(page);
+	ClearPageNoNewRefs(newpage);
 
 	return 0;
 }
