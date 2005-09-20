Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932771AbVITRXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932771AbVITRXf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 13:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932772AbVITRXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 13:23:15 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:9951 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932771AbVITRXN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 13:23:13 -0400
Subject: [RFC][PATCH 1/4] build_zonelists(): create zone_index_to_type() helper
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 20 Sep 2005 10:23:09 -0700
References: <20050920172303.8CD9190C@kernel.beaverton.ibm.com>
In-Reply-To: <20050920172303.8CD9190C@kernel.beaverton.ibm.com>
Message-Id: <20050920172309.5C36CE4C@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The two build_zonelists() do identical conversions from a
zone index variable (__GFP_*) to a zone type variable
(ZONE_*).  Create a common helper.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/mm/page_alloc.c |   24 ++++++++++++++----------
 1 files changed, 14 insertions(+), 10 deletions(-)

diff -puN mm/page_alloc.c~B1-build_zonelists_unification mm/page_alloc.c
--- memhotplug/mm/page_alloc.c~B1-build_zonelists_unification	2005-09-14 09:32:37.000000000 -0700
+++ memhotplug-dave/mm/page_alloc.c	2005-09-14 09:32:37.000000000 -0700
@@ -1451,6 +1451,18 @@ static int __init build_zonelists_node(p
 	return j;
 }
 
+static inline zone_index_to_type(int index)
+{
+	int type = ZONE_NORMAL;
+
+	if (index & __GFP_HIGHMEM)
+		type = ZONE_HIGHMEM;
+	if (index & __GFP_DMA)
+		type = ZONE_DMA;
+	return type;
+}
+
+
 #ifdef CONFIG_NUMA
 #define MAX_NODE_LOAD (num_online_nodes())
 static int __initdata node_load[MAX_NUMNODES];
@@ -1547,11 +1559,7 @@ static void __init build_zonelists(pg_da
 			zonelist = pgdat->node_zonelists + i;
 			for (j = 0; zonelist->zones[j] != NULL; j++);
 
-			k = ZONE_NORMAL;
-			if (i & __GFP_HIGHMEM)
-				k = ZONE_HIGHMEM;
-			if (i & __GFP_DMA)
-				k = ZONE_DMA;
+			k = zone_index_to_type(i);
 
 	 		j = build_zonelists_node(NODE_DATA(node), zonelist, j, k);
 			zonelist->zones[j] = NULL;
@@ -1572,11 +1580,7 @@ static void __init build_zonelists(pg_da
 		zonelist = pgdat->node_zonelists + i;
 
 		j = 0;
-		k = ZONE_NORMAL;
-		if (i & __GFP_HIGHMEM)
-			k = ZONE_HIGHMEM;
-		if (i & __GFP_DMA)
-			k = ZONE_DMA;
+		k = zone_index_to_type(i);
 
  		j = build_zonelists_node(pgdat, zonelist, j, k);
  		/*
_
