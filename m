Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbVHKMWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbVHKMWy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 08:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbVHKMWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 08:22:53 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:28086 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932393AbVHKMWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 08:22:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=KlCy1CkXUA/16K0+V4mSUUJNKf//iA+PD+uQYwX4RSVeVsOHzmofnC1pLKUDfgsJrWqDFbH17NjM36UukCkLQtYAzgAmmx1vqdyQ6j/wq5nEJdb8PqO09wVC/e1uwP36RJp+74AAtNhMH8PnuW8w5oup/9pW+OUUxzXmdt+MNg0=  ;
Message-ID: <42FB4311.2070807@yahoo.com.au>
Date: Thu, 11 Aug 2005 22:22:41 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul McKenney <paul.mckenney@us.ibm.com>
CC: Dipankar Sarma <dipankar@in.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch 3/7] mm: speculative get_page
References: <42FB4201.7080304@yahoo.com.au> <42FB42BD.6020808@yahoo.com.au> <42FB42EF.1040401@yahoo.com.au>
In-Reply-To: <42FB42EF.1040401@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------040300080707090401050707"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040300080707090401050707
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

3/7

-- 
SUSE Labs, Novell Inc.


--------------040300080707090401050707
Content-Type: text/plain;
 name="mm-speculative-get_page.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-speculative-get_page.patch"

If we can be sure that elevating the page_count on a pagecache
page will pin it, we can speculatively run this operation, and
subsequently check to see if we hit the right page rather than
relying on holding a lock or otherwise pinning a reference to
the page.

This can be done if get_page/put_page behaves in the same manner
throughout the whole tree (ie. if we "get" the page after it has
been used for something else, we must be able to free it with a
put_page).

There needs to be some careful logic for freed pages so they aren't
freed again, and also some careful logic for pages in the process
of being removed from pagecache.

Index: linux-2.6/include/linux/page-flags.h
===================================================================
--- linux-2.6.orig/include/linux/page-flags.h
+++ linux-2.6/include/linux/page-flags.h
@@ -77,6 +77,7 @@
 #define PG_uncached		19	/* Page has been mapped as uncached */
 
 #define PG_free			20	/* Page is on the free lists */
+#define PG_freeing		21	/* PG_refcount about to be freed */
 
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
@@ -312,6 +313,11 @@ extern void __mod_page_state(unsigned lo
 #define __SetPageFree(page)	__set_bit(PG_free, &(page)->flags)
 #define __ClearPageFree(page)	__clear_bit(PG_free, &(page)->flags)
 
+#define PageFreeing(page)	test_bit(PG_freeing, &(page)->flags)
+#define SetPageFreeing(page)	set_bit(PG_freeing, &(page)->flags)
+#define ClearPageFreeing(page)	clear_bit(PG_freeing, &(page)->flags)
+#define __ClearPageFreeing(page) __clear_bit(PG_freeing, &(page)->flags)
+
 struct page;	/* forward declaration */
 
 int test_clear_page_dirty(struct page *page);
Index: linux-2.6/include/linux/pagemap.h
===================================================================
--- linux-2.6.orig/include/linux/pagemap.h
+++ linux-2.6/include/linux/pagemap.h
@@ -50,6 +50,64 @@ static inline void mapping_set_gfp_mask(
 #define page_cache_release(page)	put_page(page)
 void release_pages(struct page **pages, int nr, int cold);
 
+static inline struct page *page_cache_get_speculative(struct page **pagep)
+{
+	unsigned long flags;
+	struct page *page;
+
+	/*
+	 * Disable IRQs (and preempt) so we don't deadlock with the page
+	 * allocator who might be waiting for us to drop the speculative
+	 * reference.
+	 *
+	 * Interrupts could be disabled _after_ loading *pagep, however
+	 * we want to really minimise the window between taking a spec
+	 * ref on the page and retesting the page.
+	 */
+	local_irq_save(flags);
+
+	page = *pagep;
+	if (!page)
+		goto out_failed;
+
+	/* Note that get_page_testone provides a memory barrier */
+	if (unlikely(get_page_testone(page) || PageFree(page))) {
+		/*
+		 * Picked up a freed page. Note order of evaluation of the
+		 * above is important. If we are not the first speculative
+		 * getter on a free page, then we'll fall through to the
+		 * PageFree test, which is stable because the previous getters
+		 * are keeping page allocation spinning on this page.
+		 */
+		__put_page(page);
+		page = NULL;
+		goto out_failed;
+	}
+
+	/*
+	 * interrupts and preempt could be enabled here (only need to be
+	 * disabled because page allocation can spin on the elevated refcount,
+	 * but we don't want to hold a reference on an unrelated page for too
+	 * long, so keep preempt off until we know we have the right page
+	 */
+
+	if (unlikely(PageFreeing(page) || page != *pagep)) {
+		/*
+		 * Picked up a page being freed, or one that is no longer
+		 * being pointed to by pagep. Note that we do the complete
+		 * put_page, because unlike the above case, this page is
+		 * not free and our reference is pinning it.
+		 */
+		put_page(page);
+		page = NULL;
+		goto out_failed;
+	}
+
+out_failed:
+	local_irq_restore(flags);
+	return page;
+}
+
 static inline struct page *page_cache_alloc(struct address_space *x)
 {
 	return alloc_pages(mapping_gfp_mask(x)|__GFP_NORECLAIM, 0);
Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -116,7 +116,6 @@ static void bad_page(const char *functio
 			1 << PG_writeback |
 			1 << PG_reserved |
 			1 << PG_free );
-	set_page_count(page, 0);
 	reset_page_mapcount(page);
 	page->mapping = NULL;
 	tainted |= TAINT_BAD_PAGE;
@@ -316,7 +315,6 @@ static inline void free_pages_check(cons
 {
 	if (	page_mapcount(page) ||
 		page->mapping != NULL ||
-		page_count(page) != 0 ||
 		(page->flags & (
 			1 << PG_lru	|
 			1 << PG_private |
@@ -424,7 +422,7 @@ expand(struct zone *zone, struct page *p
 void set_page_refs(struct page *page, int order)
 {
 #ifdef CONFIG_MMU
-	set_page_count(page, 1);
+	get_page(page);
 #else
 	int i;
 
@@ -434,7 +432,7 @@ void set_page_refs(struct page *page, in
 	 * - eg: access_process_vm()
 	 */
 	for (i = 0; i < (1 << order); i++)
-		set_page_count(page + i, 1);
+		get_page(page + i);
 #endif /* CONFIG_MMU */
 }
 
@@ -445,7 +443,6 @@ static void prep_new_page(struct page *p
 {
 	if (	page_mapcount(page) ||
 		page->mapping != NULL ||
-		page_count(page) != 0 ||
 		(page->flags & (
 			1 << PG_lru	|
 			1 << PG_private	|
@@ -464,7 +461,13 @@ static void prep_new_page(struct page *p
 			1 << PG_referenced | 1 << PG_arch_1 |
 			1 << PG_checked | 1 << PG_mappedtodisk);
 	page->private = 0;
+
 	set_page_refs(page, order);
+	smp_mb();
+	/* Wait for speculative get_page after count has been elevated. */
+	while (unlikely(page_count(page) > 1))
+		cpu_relax();
+
 	kernel_map_pages(page, 1 << order, 1);
 }
 
Index: linux-2.6/mm/vmscan.c
===================================================================
--- linux-2.6.orig/mm/vmscan.c
+++ linux-2.6/mm/vmscan.c
@@ -504,6 +504,7 @@ static int shrink_list(struct list_head 
 		if (!mapping)
 			goto keep_locked;	/* truncate got there first */
 
+		SetPageFreeing(page);
 		write_lock_irq(&mapping->tree_lock);
 
 		/*
@@ -513,6 +514,7 @@ static int shrink_list(struct list_head 
 		 */
 		if (page_count(page) != 2 || PageDirty(page)) {
 			write_unlock_irq(&mapping->tree_lock);
+			ClearPageFreeing(page);
 			goto keep_locked;
 		}
 
@@ -533,6 +535,7 @@ static int shrink_list(struct list_head 
 
 free_it:
 		unlock_page(page);
+		__ClearPageFreeing(page);
 		reclaimed++;
 		if (!pagevec_add(&freed_pvec, page))
 			__pagevec_release_nonlru(&freed_pvec);
Index: linux-2.6/mm/bootmem.c
===================================================================
--- linux-2.6.orig/mm/bootmem.c
+++ linux-2.6/mm/bootmem.c
@@ -289,19 +289,20 @@ static unsigned long __init free_all_boo
 			int j, order;
 
 			page = pfn_to_page(pfn);
+			prefetchw(page);
+
 			count += BITS_PER_LONG;
-			__ClearPageReserved(page);
 			order = ffs(BITS_PER_LONG) - 1;
-			set_page_refs(page, order);
-			for (j = 1; j < BITS_PER_LONG; j++) {
-				if (j + 16 < BITS_PER_LONG)
-					prefetchw(page + j + 16);
+			for (j = 0; j < BITS_PER_LONG; j++) {
+				if (j + 1 < BITS_PER_LONG)
+					prefetchw(page + j + 1);
 				__ClearPageReserved(page + j);
 				set_page_count(page + j, 0);
 			}
+			set_page_refs(page, order);
 			__free_pages(page, order);
+
 			i += BITS_PER_LONG;
-			page += BITS_PER_LONG;
 		} else if (v) {
 			unsigned long m;
 
@@ -310,6 +311,7 @@ static unsigned long __init free_all_boo
 				if (v & m) {
 					count++;
 					__ClearPageReserved(page);
+					set_page_count(page, 0);
 					set_page_refs(page, 0);
 					__free_page(page);
 				}
Index: linux-2.6/mm/swapfile.c
===================================================================
--- linux-2.6.orig/mm/swapfile.c
+++ linux-2.6/mm/swapfile.c
@@ -338,6 +338,7 @@ int remove_exclusive_swap_page(struct pa
 	retval = 0;
 	if (p->swap_map[swp_offset(entry)] == 1) {
 		/* Recheck the page count with the swapcache lock held.. */
+		SetPageFreeing(page);
 		write_lock_irq(&swapper_space.tree_lock);
 		if ((page_count(page) == 2) && !PageWriteback(page)) {
 			__delete_from_swap_cache(page);
@@ -345,6 +346,7 @@ int remove_exclusive_swap_page(struct pa
 			retval = 1;
 		}
 		write_unlock_irq(&swapper_space.tree_lock);
+		ClearPageFreeing(page);
 	}
 	swap_info_put(p);
 

--------------040300080707090401050707--
Send instant messages to your online friends http://au.messenger.yahoo.com 
