Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbVIBU6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbVIBU6A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 16:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbVIBU5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 16:57:10 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:63619 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751225AbVIBU4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 16:56:51 -0400
Subject: [PATCH 04/11] memory hotplug prep: fixup bad_range()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 02 Sep 2005 13:56:46 -0700
References: <20050902205643.9A4EC17A@kernel.beaverton.ibm.com>
In-Reply-To: <20050902205643.9A4EC17A@kernel.beaverton.ibm.com>
Message-Id: <20050902205646.1D7619DA@kernel.beaverton.ibm.com>
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
--- memhotplug/mm/page_alloc.c~C5.1-bad_range-rework	2005-08-18 14:59:45.000000000 -0700
+++ memhotplug-dave/mm/page_alloc.c	2005-08-18 14:59:45.000000000 -0700
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
