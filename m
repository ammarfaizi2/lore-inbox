Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbVKUPM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbVKUPM0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 10:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbVKUPM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 10:12:26 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:21927 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750866AbVKUPMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 10:12:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:From:To:Cc:Message-Id:In-Reply-To:References:Subject;
  b=yoicIq5GOhK9ddVFipvSd+7AbhdUKRXI0nofj/JnYe+eZQpz/+4S3jjhabC6RsCq+jl5WK+RZtbbRW3lp4/MzrMKmhUgdLiI53TOHIm3FuVwBWGUHlQk4HJ4zQPyYvT2aVQrPYM7qGsPOAMtJEHtY98X2Jtfg5YASwpxb8Rz/tw=  ;
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>
Message-Id: <20051121124126.14370.50844.sendpatchset@didi.local0.net>
In-Reply-To: <20051121123906.14370.3039.sendpatchset@didi.local0.net>
References: <20051121123906.14370.3039.sendpatchset@didi.local0.net>
Subject: [patch 6/12] mm: remove bad_range
Date: Mon, 21 Nov 2005 10:12:25 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bad_range is supposed to be a temporary check. It would be a pity to throw
it out. Make it depend on CONFIG_DEBUG_VM instead.

CONFIG_HOLES_IN_ZONE systems were relying on this to check pfn_valid in
the page allocator. Add that to page_is_buddy instead.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -81,6 +81,7 @@ int min_free_kbytes = 1024;
 unsigned long __initdata nr_kernel_pages;
 unsigned long __initdata nr_all_pages;
 
+#ifdef CONFIG_DEBUG_VM
 static int page_outside_zone_boundaries(struct zone *zone, struct page *page)
 {
 	int ret = 0;
@@ -122,6 +123,13 @@ static int bad_range(struct zone *zone, 
 	return 0;
 }
 
+#else
+static inline int bad_range(struct zone *zone, struct page *page)
+{
+	return 0;
+}
+#endif
+
 static void bad_page(const char *function, struct page *page)
 {
 	printk(KERN_EMERG "Bad page state at %s (in process '%s', page %p)\n",
@@ -261,14 +269,20 @@ __find_combined_index(unsigned long page
 /*
  * This function checks whether a page is free && is the buddy
  * we can do coalesce a page and its buddy if
- * (a) the buddy is free &&
- * (b) the buddy is on the buddy system &&
- * (c) a page and its buddy have the same order.
+ * (a) the buddy is not in a hole &&
+ * (b) the buddy is free &&
+ * (c) the buddy is on the buddy system &&
+ * (d) a page and its buddy have the same order.
  * for recording page's order, we use page_private(page) and PG_private.
  *
  */
 static inline int page_is_buddy(struct page *page, int order)
 {
+#ifdef CONFIG_HOLES_IN_ZONE
+	if (!pfn_valid(page_to_pfn(page)))
+		return 0;
+#endif
+
        if (PagePrivate(page)           &&
            (page_order(page) == order) &&
             page_count(page) == 0)
@@ -320,17 +334,15 @@ static inline void __free_pages_bulk (st
 		struct free_area *area;
 		struct page *buddy;
 
-		combined_idx = __find_combined_index(page_idx, order);
 		buddy = __page_find_buddy(page, page_idx, order);
-
-		if (bad_range(zone, buddy))
-			break;
 		if (!page_is_buddy(buddy, order))
 			break;		/* Move the buddy up one level. */
+
 		list_del(&buddy->lru);
 		area = zone->free_area + order;
 		area->nr_free--;
 		rmv_page_order(buddy);
+		combined_idx = __find_combined_index(page_idx, order);
 		page = page + (combined_idx - page_idx);
 		page_idx = combined_idx;
 		order++;
Index: linux-2.6/lib/Kconfig.debug
===================================================================
--- linux-2.6.orig/lib/Kconfig.debug
+++ linux-2.6/lib/Kconfig.debug
@@ -172,7 +172,8 @@ config DEBUG_VM
 	bool "Debug VM"
 	depends on DEBUG_KERNEL
 	help
-	  Enable this to debug the virtual-memory system.
+	  Enable this to turn on extended checks in the virtual-memory system
+          that may impact performance.
 
 	  If unsure, say N.
 
Send instant messages to your online friends http://au.messenger.yahoo.com 
