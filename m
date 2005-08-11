Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbVHKMWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbVHKMWS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 08:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbVHKMWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 08:22:18 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:17054 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932393AbVHKMWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 08:22:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=XrA+0Jz2QwcACM2oTORfQu/sAFCRkcik3JnZXcfZh32ftXRWO6v5aAYw3jkTCLQ7HuLuVoUPOblJB3IJx/kehukAeU4aDbV0Cdn/VFglLSFgRbMbuicA8HAl60imL0wBIj2NTms4fZaVQfMRdt6nu/P0bkISmP9p0/ESmUbpNns=  ;
Message-ID: <42FB42EF.1040401@yahoo.com.au>
Date: Thu, 11 Aug 2005 22:22:07 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul McKenney <paul.mckenney@us.ibm.com>
CC: Dipankar Sarma <dipankar@in.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch 2/7] mm: PG_free flag
References: <42FB4201.7080304@yahoo.com.au> <42FB42BD.6020808@yahoo.com.au>
In-Reply-To: <42FB42BD.6020808@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------090405020101040701040309"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090405020101040701040309
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

2/7

-- 
SUSE Labs, Novell Inc.


--------------090405020101040701040309
Content-Type: text/plain;
 name="mm-PG_free-flag.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-PG_free-flag.patch"

In a future patch we can no longer rely on page_count being stable at any
time, so we can no longer overload PagePrivate && page_count == 0 to mean
the page is free and on the buddy lists.

Index: linux-2.6/include/linux/page-flags.h
===================================================================
--- linux-2.6.orig/include/linux/page-flags.h
+++ linux-2.6/include/linux/page-flags.h
@@ -76,6 +76,8 @@
 #define PG_nosave_free		18	/* Free, should not be written */
 #define PG_uncached		19	/* Page has been mapped as uncached */
 
+#define PG_free			20	/* Page is on the free lists */
+
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
  * allowed.
@@ -306,6 +308,10 @@ extern void __mod_page_state(unsigned lo
 #define SetPageUncached(page)	set_bit(PG_uncached, &(page)->flags)
 #define ClearPageUncached(page)	clear_bit(PG_uncached, &(page)->flags)
 
+#define PageFree(page)		test_bit(PG_free, &(page)->flags)
+#define __SetPageFree(page)	__set_bit(PG_free, &(page)->flags)
+#define __ClearPageFree(page)	__clear_bit(PG_free, &(page)->flags)
+
 struct page;	/* forward declaration */
 
 int test_clear_page_dirty(struct page *page);
Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -114,7 +114,8 @@ static void bad_page(const char *functio
 			1 << PG_slab    |
 			1 << PG_swapcache |
 			1 << PG_writeback |
-			1 << PG_reserved );
+			1 << PG_reserved |
+			1 << PG_free );
 	set_page_count(page, 0);
 	reset_page_mapcount(page);
 	page->mapping = NULL;
@@ -191,12 +192,12 @@ static inline unsigned long page_order(s
 
 static inline void set_page_order(struct page *page, int order) {
 	page->private = order;
-	__SetPagePrivate(page);
+	__SetPageFree(page);
 }
 
 static inline void rmv_page_order(struct page *page)
 {
-	__ClearPagePrivate(page);
+	__ClearPageFree(page);
 	page->private = 0;
 }
 
@@ -242,9 +243,7 @@ __find_combined_index(unsigned long page
  */
 static inline int page_is_buddy(struct page *page, int order)
 {
-       if (PagePrivate(page)           &&
-           (page_order(page) == order) &&
-            page_count(page) == 0)
+       if (PageFree(page) && (page_order(page) == order))
                return 1;
        return 0;
 }
@@ -327,7 +326,8 @@ static inline void free_pages_check(cons
 			1 << PG_slab	|
 			1 << PG_swapcache |
 			1 << PG_writeback |
-			1 << PG_reserved )))
+			1 << PG_reserved |
+			1 << PG_free )))
 		bad_page(function, page);
 	if (PageDirty(page))
 		__ClearPageDirty(page);
@@ -456,7 +456,8 @@ static void prep_new_page(struct page *p
 			1 << PG_slab    |
 			1 << PG_swapcache |
 			1 << PG_writeback |
-			1 << PG_reserved )))
+			1 << PG_reserved |
+			1 << PG_free )))
 		bad_page(__FUNCTION__, page);
 
 	page->flags &= ~(1 << PG_uptodate | 1 << PG_error |

--------------090405020101040701040309--
Send instant messages to your online friends http://au.messenger.yahoo.com 
