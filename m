Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751466AbWCSI6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbWCSI6r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 03:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbWCSI6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 03:58:22 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:14721 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751460AbWCSI6D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 03:58:03 -0500
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org,
       Christoph Lameter <clameter@sgi.com>
Date: Sun, 19 Mar 2006 00:58:01 -0800
Message-Id: <20060319085801.18847.8908.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] mm: hugetlb alloc_fresh_huge_page bogus node loop fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

Fix bogus node loop in hugetlb.c alloc_fresh_huge_page(),
which was assuming that nodes are numbered contiguously
from 0 to num_online_nodes().  Once the hotplug folks
get this far, that will be false.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 mm/hugetlb.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

--- 2.6.16-rc6-mm2.orig/mm/hugetlb.c	2006-03-18 17:29:46.645251774 -0800
+++ 2.6.16-rc6-mm2/mm/hugetlb.c	2006-03-18 21:43:05.101700297 -0800
@@ -105,7 +105,9 @@ static int alloc_fresh_huge_page(void)
 	struct page *page;
 	page = alloc_pages_node(nid, GFP_HIGHUSER|__GFP_COMP|__GFP_NOWARN,
 					HUGETLB_PAGE_ORDER);
-	nid = (nid + 1) % num_online_nodes();
+	nid = next_node(nid, node_online_map);
+	if (nid == MAX_NUMNODES)
+		nid = first_node(node_online_map);
 	if (page) {
 		page[1].lru.next = (void *)free_huge_page;	/* dtor */
 		spin_lock(&hugetlb_lock);

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
