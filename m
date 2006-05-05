Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751694AbWEERhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbWEERhT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 13:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751696AbWEERhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 13:37:15 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:12165 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751691AbWEERhK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 13:37:10 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Message-Id: <20060505173707.9030.3383.sendpatchset@skynet>
In-Reply-To: <20060505173446.9030.42837.sendpatchset@skynet>
References: <20060505173446.9030.42837.sendpatchset@skynet>
Subject: [PATCH 7/8] Allow HugeTLB allocations to use ZONE_EASYRCLM
Date: Fri,  5 May 2006 18:37:07 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On ppc64 at least, a HugeTLB is the same size as a memory section. Hence,
it causes no fragmentation that is worth caring about because a section can
still be offlined.

Once HugeTLB is allowed to use ZONE_EASYRCLM, the size of the zone becomes a
"soft" area where HugeTLB allocations may be satisified. For example, take
a situation where a system administrator is not willing to reserve HugeTLB
pages at boot time. In this case, he can use kernelcore to size the EasyRclm
zone which is still usable by normal processes. If a job starts that need
HugeTLB pages, one could dd a file the size of physical memory, delete it
and have a good chance of getting a number of HugeTLB pages. To get all of
EasyRclm as HugeTLB pages, the ability to drain per-cpu pages is required.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-rc3-mm1-zonesizing-106_ia64coremem/mm/hugetlb.c linux-2.6.17-rc3-mm1-zonesizing-107_hugetlb_use_easyrclm/mm/hugetlb.c
--- linux-2.6.17-rc3-mm1-zonesizing-106_ia64coremem/mm/hugetlb.c	2006-05-03 09:41:33.000000000 +0100
+++ linux-2.6.17-rc3-mm1-zonesizing-107_hugetlb_use_easyrclm/mm/hugetlb.c	2006-05-03 09:50:27.000000000 +0100
@@ -73,7 +73,7 @@ static struct page *dequeue_huge_page(st
 
 	for (z = zonelist->zones; *z; z++) {
 		nid = (*z)->zone_pgdat->node_id;
-		if (cpuset_zone_allowed(*z, GFP_HIGHUSER) &&
+		if (cpuset_zone_allowed(*z, GFP_RCLMUSER) &&
 		    !list_empty(&hugepage_freelists[nid]))
 			break;
 	}
@@ -103,7 +103,7 @@ static int alloc_fresh_huge_page(void)
 {
 	static int nid = 0;
 	struct page *page;
-	page = alloc_pages_node(nid, GFP_HIGHUSER|__GFP_COMP|__GFP_NOWARN,
+	page = alloc_pages_node(nid, GFP_RCLMUSER|__GFP_COMP|__GFP_NOWARN,
 					HUGETLB_PAGE_ORDER);
 	nid = next_node(nid, node_online_map);
 	if (nid == MAX_NUMNODES)
