Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750946AbWIHM0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbWIHM0T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 08:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbWIHM0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 08:26:18 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:25748
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750942AbWIHM0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 08:26:17 -0400
Date: Fri, 8 Sep 2006 13:25:47 +0100
From: Andy Whitcroft <apw@shadowen.org>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH 2/5] linear reclaim export page_order and family
Message-ID: <20060908122547.GA1090@shadowen.org>
References: <exportbomb.1157718286@pinky>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <exportbomb.1157718286@pinky>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linear reclaim export page_order and family

We need the free page page order in the linear reclaim algorithm.
Export page_order and friends, adding a note indicating that they
are only valid when a page is free and owned by the buddy allocator.

Added in: V1

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5b3dacf..50f0922 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -292,6 +292,33 @@ #define VM_BUG_ON(condition) do { } whil
 #endif
 
 /*
+ * function for dealing with page's order in buddy system.
+ * zone->lock is already acquired when we use these.
+ * So, we don't need atomic page->flags operations here.
+ * NOTE: these are only valid on free pages owned by the buddy
+ * allocator.
+ */
+static inline unsigned long page_order(struct page *page)
+{
+	VM_BUG_ON(!PageBuddy(page));
+	return page_private(page);
+}
+
+static inline void set_page_order(struct page *page, int order)
+{
+	VM_BUG_ON(PageBuddy(page));
+	set_page_private(page, order);
+	__SetPageBuddy(page);
+}
+
+static inline void rmv_page_order(struct page *page)
+{
+	VM_BUG_ON(!PageBuddy(page));
+	__ClearPageBuddy(page);
+	set_page_private(page, 0);
+}
+
+/*
  * Methods to modify the page usage count.
  *
  * What counts for a page usage:
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index dc41137..825a433 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -290,28 +290,6 @@ static inline void prep_zero_page(struct
 }
 
 /*
- * function for dealing with page's order in buddy system.
- * zone->lock is already acquired when we use these.
- * So, we don't need atomic page->flags operations here.
- */
-static inline unsigned long page_order(struct page *page)
-{
-	return page_private(page);
-}
-
-static inline void set_page_order(struct page *page, int order)
-{
-	set_page_private(page, order);
-	__SetPageBuddy(page);
-}
-
-static inline void rmv_page_order(struct page *page)
-{
-	__ClearPageBuddy(page);
-	set_page_private(page, 0);
-}
-
-/*
  * Locate the struct page for both the matching buddy in our
  * pair (buddy1) and the combined O(n+1) page they form (page).
  *
