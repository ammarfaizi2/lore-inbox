Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268026AbUHZKN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268026AbUHZKN6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 06:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268580AbUHZKKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 06:10:36 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:43136
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S268026AbUHZKI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 06:08:58 -0400
To: akpm@osdl.org
Subject: [PATCH] use page_to_nid
Cc: apw@shadowen.org, linux-kernel@vger.kernel.org
Message-Id: <E1C0HBX-0003A4-E8@localhost.localdomain>
From: Andy Whitcroft <apw@shadowen.org>
Date: Thu, 26 Aug 2004 11:08:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are a couple of places where we seem to go round the houses
to get the numa node id from a page.  We have a macro for this
so it seems sensible to use that.

-apw

=== 8< ===
Both lookup_node and enqueue_huge_page use page_zone() to locate
the zone, that to locate node pgdat_t and that to get the node_id.
Its more efficient to use page_to_nid() which gets the nid from the
page flags, especially if we are not using the zone for anything
else it.  Change these to use page_to_nid().

Revision: $Rev: 494 $

Signed-off-by: Andy Whitcroft <apw@shadowen.org>

diffstat 100-use_page_to_nid
---
 hugetlb.c   |    2 +-
 mempolicy.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/mm/hugetlb.c current/mm/hugetlb.c
--- reference/mm/hugetlb.c	2004-08-06 10:00:18.000000000 +0100
+++ current/mm/hugetlb.c	2004-08-06 13:39:26.000000000 +0100
@@ -21,7 +21,7 @@ static spinlock_t hugetlb_lock = SPIN_LO
 
 static void enqueue_huge_page(struct page *page)
 {
-	int nid = page_zone(page)->zone_pgdat->node_id;
+	int nid = page_to_nid(page);
 	list_add(&page->lru, &hugepage_freelists[nid]);
 	free_huge_pages++;
 	free_huge_pages_node[nid]++;
diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/mm/mempolicy.c current/mm/mempolicy.c
--- reference/mm/mempolicy.c	2004-08-06 10:00:18.000000000 +0100
+++ current/mm/mempolicy.c	2004-08-06 13:33:36.000000000 +0100
@@ -438,7 +438,7 @@ static int lookup_node(struct mm_struct 
 
 	err = get_user_pages(current, mm, addr & PAGE_MASK, 1, 0, 0, &p, NULL);
 	if (err >= 0) {
-		err = page_zone(p)->zone_pgdat->node_id;
+		err = page_to_nid(p);
 		put_page(p);
 	}
 	return err;
