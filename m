Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030324AbWFOM3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030324AbWFOM3J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 08:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030330AbWFOM3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 08:29:09 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:51165
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1030324AbWFOM3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 08:29:08 -0400
Date: Thu, 15 Jun 2006 13:28:38 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: apw@shadowen.org, y-goto@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com,
       mbligh@google.com, linux-kernel@vger.kernel.org,
       76306.1226@compuserve.com
Subject: [PATCH] zone handle unaligned zone boundaries
Message-ID: <20060615122838.GA22439@shadowen.org>
References: <20060607093535.229bbda4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <20060607093535.229bbda4.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one has been though my tests ok.  It simply enables
the test unconditionally.  This should replace all four
unaligned-zones patches.

-apw

=== 8< ===
From: Andy Whitcroft <apw@shadowen.org>

The buddy allocator has a requirement that boundaries between
contigious zones occur aligned with the the MAX_ORDER ranges.  Where
they do not we will incorrectly merge pages cross zone boundaries.
This can lead to pages from the wrong zone being handed out.

Originally the buddy allocator would check that buddies were in the
same zone by referencing the zone start and end page frame numbers.
This was removed as it became very expensive and the buddy allocator
already made the assumption that zones boundaries were aligned.

It is clear that not all configurations and architectures are
honouring this alignment requirement.  Therefore it seems safest
to reintroduce support for non-aligned zone boundaries.  This patch
introduces a new check when considering a page a buddy it compares
the zone_table index for the two pages and refuses to merge the
pages where they do not match.  The zone_table index is unique for
each node/zone combination when FLATMEM/DISCONTIGMEM is enabled
and for each section/zone combination when SPARSEMEM is enabled
(a SPARSEMEM section is at least a MAX_ORDER size).

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 include/linux/mm.h |    7 +++++--
 mm/page_alloc.c    |   17 +++++++++++------
 2 files changed, 16 insertions(+), 8 deletions(-)
diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/include/linux/mm.h current/include/linux/mm.h
--- reference/include/linux/mm.h
+++ current/include/linux/mm.h
@@ -484,10 +484,13 @@ static inline unsigned long page_zonenum
 struct zone;
 extern struct zone *zone_table[];
 
+static inline int page_zone_id(struct page *page)
+{
+	return (page->flags >> ZONETABLE_PGSHIFT) & ZONETABLE_MASK;
+}
 static inline struct zone *page_zone(struct page *page)
 {
-	return zone_table[(page->flags >> ZONETABLE_PGSHIFT) &
-			ZONETABLE_MASK];
+	return zone_table[page_zone_id(page)];
 }
 
 static inline unsigned long page_to_nid(struct page *page)
diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/mm/page_alloc.c current/mm/page_alloc.c
--- reference/mm/page_alloc.c
+++ current/mm/page_alloc.c
@@ -301,22 +301,27 @@ __find_combined_index(unsigned long page
  * we can do coalesce a page and its buddy if
  * (a) the buddy is not in a hole &&
  * (b) the buddy is in the buddy system &&
- * (c) a page and its buddy have the same order.
+ * (c) a page and its buddy have the same order &&
+ * (d) a page and its buddy are in the same zone.
  *
  * For recording whether a page is in the buddy system, we use PG_buddy.
  * Setting, clearing, and testing PG_buddy is serialized by zone->lock.
  *
  * For recording page's order, we use page_private(page).
  */
-static inline int page_is_buddy(struct page *page, int order)
+static inline int page_is_buddy(struct page *page, struct page *buddy,
+								int order)
 {
 #ifdef CONFIG_HOLES_IN_ZONE
-	if (!pfn_valid(page_to_pfn(page)))
+	if (!pfn_valid(page_to_pfn(buddy)))
 		return 0;
 #endif
 
-	if (PageBuddy(page) && page_order(page) == order) {
-		BUG_ON(page_count(page) != 0);
+	if (page_zone_id(page) != page_zone_id(buddy))
+		return 0;
+
+	if (PageBuddy(buddy) && page_order(buddy) == order) {
+		BUG_ON(page_count(buddy) != 0);
 		return 1;
 	}
 	return 0;
@@ -367,7 +372,7 @@ static inline void __free_one_page(struc
 		struct page *buddy;
 
 		buddy = __page_find_buddy(page, page_idx, order);
-		if (!page_is_buddy(buddy, order))
+		if (!page_is_buddy(page, buddy, order))
 			break;		/* Move the buddy up one level. */
 
 		list_del(&buddy->lru);
