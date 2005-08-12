Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750943AbVHLOv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbVHLOv0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 10:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbVHLOrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 10:47:47 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:19909 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751034AbVHLOr0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 10:47:26 -0400
Subject: [RFC][PATCH 05/12] memory hotplug prep: fixup bad_range()
To: linux-kernel@vger.kernel.org
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 12 Aug 2005 07:47:23 -0700
References: <20050812144714.805F4B48@kernel.beaverton.ibm.com>
In-Reply-To: <20050812144714.805F4B48@kernel.beaverton.ibm.com>
Message-Id: <20050812144723.7C2B36A2@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When doing memory hotplug operations, the size of existing zones can
obviously change.  This means that zone->zone_{start_pfn,spanned_pages}
can change.

There are currently no locks that protect these structure members.
However, they are rarely accessed at runtime.  Outside of swsusp, the
only place that I can find is bad_range().

So, split bad_range() up into two pieces: one that needs to be locked
and anther that doesn't.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/mm/page_alloc.c |   26 +++++++++++++++++++++-----
 1 files changed, 21 insertions(+), 5 deletions(-)

diff -puN mm/page_alloc.c~C5.1-bad_range-rework mm/page_alloc.c
--- memhotplug/mm/page_alloc.c~C5.1-bad_range-rework	2005-08-12 07:43:46.000000000 -0700
+++ memhotplug-dave/mm/page_alloc.c	2005-08-12 07:43:46.000000000 -0700
@@ -77,21 +77,37 @@ int min_free_kbytes = 1024;
 unsigned long __initdata nr_kernel_pages;
 unsigned long __initdata nr_all_pages;
 
-/*
- * Temporary debugging check for pages not lying within a given zone.
- */
-static int bad_range(struct zone *zone, struct page *page)
+static int page_outside_zone_boundaries(struct zone *zone, struct page *page)
 {
 	if (page_to_pfn(page) >= zone->zone_start_pfn + zone->spanned_pages)
 		return 1;
 	if (page_to_pfn(page) < zone->zone_start_pfn)
 		return 1;
+
+	return 0;
+}
+
+static int page_is_consistent(struct zone *zone, struct page *page)
+{
 #ifdef CONFIG_HOLES_IN_ZONE
 	if (!pfn_valid(page_to_pfn(page)))
-		return 1;
+		return 0;
 #endif
 	if (zone != page_zone(page))
+		return 0;
+
+	return 1;
+}
+/*
+ * Temporary debugging check for pages not lying within a given zone.
+ */
+static int bad_range(struct zone *zone, struct page *page)
+{
+	if (page_outside_zone_boundaries(zone, page))
 		return 1;
+	if (!page_is_consistent(zone, page))
+		return 1;
+
 	return 0;
 }
 
_
