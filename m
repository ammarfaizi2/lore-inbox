Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030385AbVIBG35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030385AbVIBG35 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 02:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030384AbVIBG35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 02:29:57 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:42599 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1030385AbVIBG34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 02:29:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:References:In-Reply-To:Content-Type;
  b=rNHAheUnvK+UfnSD2Jhfv/7GDkVLzrQyiHEkjt+NHs9ghGkQdHmtsHDdPi/MfzCAjyhnlGVkr4EbK2SYgy2JP4VSgsWiXNh4//tyEVbqyM8R0mgJerTtUP7QBp4iyD8HYZo+Ex4HygFI/2LE0/O9DuVpg9UL1qMDa4mUWEXtp18=  ;
Message-ID: <4317F17F.5050306@yahoo.com.au>
Date: Fri, 02 Sep 2005 16:30:23 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Memory Management <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.13] lockless pagecache 3/7
References: <4317F071.1070403@yahoo.com.au> <4317F0F9.1080602@yahoo.com.au> <4317F136.4040601@yahoo.com.au>
In-Reply-To: <4317F136.4040601@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------000802000001060008080009"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000802000001060008080009
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

3/7

-- 
SUSE Labs, Novell Inc.


--------------000802000001060008080009
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

This needs an atomic_cmpxchg operation to ensure we don't try to
grab a free page.

Index: linux-2.6/include/linux/page-flags.h
===================================================================
--- linux-2.6.orig/include/linux/page-flags.h
+++ linux-2.6/include/linux/page-flags.h
@@ -76,6 +76,8 @@
 #define PG_nosave_free		18	/* Free, should not be written */
 #define PG_uncached		19	/* Page has been mapped as uncached */
 
+#define PG_freeing		20	/* Pagecache is about to be freed */
+
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
  * allowed.
@@ -306,6 +308,11 @@ extern void __mod_page_state(unsigned lo
 #define SetPageUncached(page)	set_bit(PG_uncached, &(page)->flags)
 #define ClearPageUncached(page)	clear_bit(PG_uncached, &(page)->flags)
 
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
@@ -50,6 +50,36 @@ static inline void mapping_set_gfp_mask(
 #define page_cache_release(page)	put_page(page)
 void release_pages(struct page **pages, int nr, int cold);
 
+static inline struct page *page_cache_get_speculative(struct page **pagep)
+{
+	struct page *page;
+	int count;
+
+	page = *pagep;
+	if (!page)
+		return NULL;
+
+	do {
+		count = atomic_read(&page->_count);
+		if (unlikely(count == -1)) /* Picked up a free page. */
+			return NULL;
+	} while (unlikely(atomic_cmpxchg(&page->_count, count, count+1) != count));
+
+	/* Note that atomic_load_lock provides a memory barrier */
+
+	if (unlikely(PageFreeing(page) || page != *pagep)) {
+		/*
+		 * Picked up a page being freed, or one that is no longer
+		 * being pointed to by pagep. Now that we have a reference
+		 * to the page, we must do a put_page.
+		 */
+		put_page(page);
+		return NULL;
+	}
+
+	return page;
+}
+
 static inline struct page *page_cache_alloc(struct address_space *x)
 {
 	return alloc_pages(mapping_gfp_mask(x)|__GFP_NORECLAIM, 0);
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
+		ClearPageFreeing(page);
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
 

--------------000802000001060008080009--
Send instant messages to your online friends http://au.messenger.yahoo.com 
