Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262091AbUJZB7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262091AbUJZB7a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 21:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbUJZB6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 21:58:10 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:24277 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262071AbUJZB33 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:29:29 -0400
Date: Mon, 25 Oct 2004 18:28:53 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Hugepages demand paging V2 [3/8]: simple numa compatible allocator
In-Reply-To: <Pine.LNX.4.58.0410251825020.12962@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0410251828060.12962@schroedinger.engr.sgi.com>
References: <B05667366EE6204181EABE9C1B1C0EB504BFA47C@scsmsx401.amr.corp.intel.com>
 <Pine.LNX.4.58.0410251825020.12962@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog
	* Simple NUMA compatible allocation of hugepages in the nearest node

Index: linux-2.6.9/mm/hugetlb.c
===================================================================
--- linux-2.6.9.orig/mm/hugetlb.c	2004-10-22 13:28:27.000000000 -0700
+++ linux-2.6.9/mm/hugetlb.c	2004-10-25 16:56:22.000000000 -0700
@@ -32,14 +32,17 @@
 {
 	int nid = numa_node_id();
 	struct page *page = NULL;
-
-	if (list_empty(&hugepage_freelists[nid])) {
-		for (nid = 0; nid < MAX_NUMNODES; ++nid)
-			if (!list_empty(&hugepage_freelists[nid]))
-				break;
+	struct zonelist *zonelist = NODE_DATA(nid)->node_zonelists;
+	struct zone **zones = zonelist->zones;
+	struct zone *z;
+	int i;
+
+	for(i=0; (z = zones[i])!= NULL; i++) {
+		nid = z->zone_pgdat->node_id;
+		if (!list_empty(&hugepage_freelists[nid]))
+			break;
 	}
-	if (nid >= 0 && nid < MAX_NUMNODES &&
-	    !list_empty(&hugepage_freelists[nid])) {
+	if (z) {
 		page = list_entry(hugepage_freelists[nid].next,
 				  struct page, lru);
 		list_del(&page->lru);

