Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751425AbWBQOTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbWBQOTJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 09:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbWBQOTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 09:19:09 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:26590 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751425AbWBQOS6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 09:18:58 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Message-Id: <20060217141752.7621.68392.sendpatchset@skynet.csn.ul.ie>
In-Reply-To: <20060217141552.7621.74444.sendpatchset@skynet.csn.ul.ie>
References: <20060217141552.7621.74444.sendpatchset@skynet.csn.ul.ie>
Subject: [PATCH 6/7] Allow HugeTLB allocations to use ZONE_EASYRCLM
Date: Fri, 17 Feb 2006 14:17:52 +0000 (GMT)
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
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.16-rc3-mm1-106_zonechoose/mm/hugetlb.c linux-2.6.16-rc3-mm1-107_hugetlb_use_easyrclm/mm/hugetlb.c
--- linux-2.6.16-rc3-mm1-106_zonechoose/mm/hugetlb.c	2006-02-16 09:50:44.000000000 +0000
+++ linux-2.6.16-rc3-mm1-107_hugetlb_use_easyrclm/mm/hugetlb.c	2006-02-17 09:44:58.000000000 +0000
@@ -49,7 +49,7 @@ static struct page *dequeue_huge_page(st
 
 	for (z = zonelist->zones; *z; z++) {
 		nid = (*z)->zone_pgdat->node_id;
-		if (cpuset_zone_allowed(*z, GFP_HIGHUSER) &&
+		if (cpuset_zone_allowed(*z, GFP_RCLMUSER) &&
 		    !list_empty(&hugepage_freelists[nid]))
 			break;
 	}
@@ -68,7 +68,7 @@ static int alloc_fresh_huge_page(void)
 {
 	static int nid = 0;
 	struct page *page;
-	page = alloc_pages_node(nid, GFP_HIGHUSER|__GFP_COMP|__GFP_NOWARN,
+	page = alloc_pages_node(nid, GFP_RCLMUSER|__GFP_COMP|__GFP_NOWARN,
 					HUGETLB_PAGE_ORDER);
 	nid = (nid + 1) % num_online_nodes();
 	if (page) {
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.16-rc3-mm1-106_zonechoose/mm/mempolicy.c linux-2.6.16-rc3-mm1-107_hugetlb_use_easyrclm/mm/mempolicy.c
--- linux-2.6.16-rc3-mm1-106_zonechoose/mm/mempolicy.c	2006-02-16 09:50:44.000000000 +0000
+++ linux-2.6.16-rc3-mm1-107_hugetlb_use_easyrclm/mm/mempolicy.c	2006-02-17 09:44:58.000000000 +0000
@@ -1201,7 +1201,7 @@ struct zonelist *huge_zonelist(struct vm
 		unsigned nid;
 
 		nid = interleave_nid(pol, vma, addr, HPAGE_SHIFT);
-		return NODE_DATA(nid)->node_zonelists + gfp_zone(GFP_HIGHUSER);
+		return NODE_DATA(nid)->node_zonelists + gfp_zone(GFP_RCLMUSER);
 	}
 	return zonelist_policy(GFP_HIGHUSER, pol);
 }
