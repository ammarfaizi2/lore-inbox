Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWAQPuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWAQPuh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 10:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWAQPuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 10:50:37 -0500
Received: from 81-179-245-126.dsl.pipex.com ([81.179.245.126]:7063 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750754AbWAQPug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 10:50:36 -0500
Date: Tue, 17 Jan 2006 15:50:10 +0000
To: Andrew Morton <akpm@osdl.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] zonelists gfp_zone() is really gfp_zonelist()
Message-ID: <20060117155010.GA16135@shadowen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zonelists gfp_zone() is really gfp_zonelist()

[Following on from the discussions of the indexing of zonelists it
is clear that its not at all clear that this is not indexed by zone.
A major contributer to this is gfp_zone() which is used to generated
these indexes from the GFP flags.]

gfp_zone() returns an index into the per node zonelists.  This list
is indexed by 'gfp modifier space' not by zones and the section
of the flags so extracted represents this space.  It being called
gfp_zone() invites confusion between 'gfp modifier space' and
zone numbering.  Take this oppotunity to comment the return type
of this function.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 fs/buffer.c               |    2 +-
 include/linux/gfp.h       |   15 +++++++++------
 include/linux/mempolicy.h |    2 +-
 mm/mempolicy.c            |    9 +++++----
 mm/page_alloc.c           |    4 ++--
 5 files changed, 18 insertions(+), 14 deletions(-)
diff -upN reference/fs/buffer.c current/fs/buffer.c
--- reference/fs/buffer.c
+++ current/fs/buffer.c
@@ -497,7 +497,7 @@ static void free_more_memory(void)
 	yield();
 
 	for_each_pgdat(pgdat) {
-		zones = pgdat->node_zonelists[gfp_zone(GFP_NOFS)].zones;
+		zones = pgdat->node_zonelists[gfp_zonelist(GFP_NOFS)].zones;
 		if (*zones)
 			try_to_free_pages(zones, GFP_NOFS);
 	}
diff -upN reference/include/linux/gfp.h current/include/linux/gfp.h
--- reference/include/linux/gfp.h
+++ current/include/linux/gfp.h
@@ -74,12 +74,15 @@ struct vm_area_struct;
 /* 4GB DMA on some platforms */
 #define GFP_DMA32	__GFP_DMA32
 
-
-static inline int gfp_zone(gfp_t gfp)
+/*
+ * Extract the gfp modifier space index from the flags word.  Note that
+ * this is not a zone number.
+ */
+static inline int gfp_zonelist(gfp_t gfp)
 {
-	int zone = GFP_ZONEMASK & (__force int) gfp;
-	BUG_ON(zone >= GFP_ZONETYPES);
-	return zone;
+	int zonelist = GFP_ZONEMASK & (__force int) gfp;
+	BUG_ON(zonelist >= GFP_ZONETYPES);
+	return zonelist;
 }
 
 /*
@@ -115,7 +118,7 @@ static inline struct page *alloc_pages_n
 		nid = 0;
 
 	return __alloc_pages(gfp_mask, order,
-		NODE_DATA(nid)->node_zonelists + gfp_zone(gfp_mask));
+		NODE_DATA(nid)->node_zonelists + gfp_zonelist(gfp_mask));
 }
 
 #ifdef CONFIG_NUMA
diff -upN reference/include/linux/mempolicy.h current/include/linux/mempolicy.h
--- reference/include/linux/mempolicy.h
+++ current/include/linux/mempolicy.h
@@ -256,7 +256,7 @@ static inline void mpol_rebind_mm(struct
 static inline struct zonelist *huge_zonelist(struct vm_area_struct *vma,
 		unsigned long addr)
 {
-	return NODE_DATA(0)->node_zonelists + gfp_zone(GFP_HIGHUSER);
+	return NODE_DATA(0)->node_zonelists + gfp_zonelist(GFP_HIGHUSER);
 }
 
 static inline int do_migrate_pages(struct mm_struct *mm,
diff -upN reference/mm/mempolicy.c current/mm/mempolicy.c
--- reference/mm/mempolicy.c
+++ current/mm/mempolicy.c
@@ -1094,7 +1094,7 @@ static struct zonelist *zonelist_policy(
 	case MPOL_BIND:
 		/* Lower zones don't get a policy applied */
 		/* Careful: current->mems_allowed might have moved */
-		if (gfp_zone(gfp) >= policy_zone)
+		if (gfp_zonelist(gfp) >= policy_zone)
 			if (cpuset_zonelist_valid_mems_allowed(policy->v.zonelist))
 				return policy->v.zonelist;
 		/*FALL THROUGH*/
@@ -1106,7 +1106,7 @@ static struct zonelist *zonelist_policy(
 		nd = 0;
 		BUG();
 	}
-	return NODE_DATA(nd)->node_zonelists + gfp_zone(gfp);
+	return NODE_DATA(nd)->node_zonelists + gfp_zonelist(gfp);
 }
 
 /* Do dynamic interleaving for a process */
@@ -1190,7 +1190,8 @@ struct zonelist *huge_zonelist(struct vm
 		unsigned nid;
 
 		nid = interleave_nid(pol, vma, addr, HPAGE_SHIFT);
-		return NODE_DATA(nid)->node_zonelists + gfp_zone(GFP_HIGHUSER);
+		return NODE_DATA(nid)->node_zonelists +
+						gfp_zonelist(GFP_HIGHUSER);
 	}
 	return zonelist_policy(GFP_HIGHUSER, pol);
 }
@@ -1203,7 +1204,7 @@ static struct page *alloc_page_interleav
 	struct zonelist *zl;
 	struct page *page;
 
-	zl = NODE_DATA(nid)->node_zonelists + gfp_zone(gfp);
+	zl = NODE_DATA(nid)->node_zonelists + gfp_zonelist(gfp);
 	page = __alloc_pages(gfp, order, zl);
 	if (page && page_zone(page) == zl->zones[0]) {
 		zone_pcp(zl->zones[0],get_cpu())->interleave_hit++;
diff -upN reference/mm/page_alloc.c current/mm/page_alloc.c
--- reference/mm/page_alloc.c
+++ current/mm/page_alloc.c
@@ -1237,7 +1237,7 @@ static unsigned int nr_free_zone_pages(i
  */
 unsigned int nr_free_buffer_pages(void)
 {
-	return nr_free_zone_pages(gfp_zone(GFP_USER));
+	return nr_free_zone_pages(gfp_zonelist(GFP_USER));
 }
 
 /*
@@ -1245,7 +1245,7 @@ unsigned int nr_free_buffer_pages(void)
  */
 unsigned int nr_free_pagecache_pages(void)
 {
-	return nr_free_zone_pages(gfp_zone(GFP_HIGHUSER));
+	return nr_free_zone_pages(gfp_zonelist(GFP_HIGHUSER));
 }
 
 #ifdef CONFIG_HIGHMEM
