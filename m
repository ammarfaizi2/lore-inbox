Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267334AbUJVTkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267334AbUJVTkE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 15:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267304AbUJVTj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 15:39:29 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:2537 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S266888AbUJVThY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 15:37:24 -0400
Date: Fri, 22 Oct 2004 12:37:13 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: Hugepages demand paging V1 [4/4]: Numa patch
In-Reply-To: <20041022110038.GN17038@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0410221235300.9549@schroedinger.engr.sgi.com>
References: <B05667366EE6204181EABE9C1B1C0EB501F2ADFB@scsmsx401.amr.corp.intel.com>
 <Pine.LNX.4.58.0410212151310.3524@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0410212158290.3524@schroedinger.engr.sgi.com>
 <20041022110038.GN17038@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2004, William Lee Irwin III wrote:

> On Thu, Oct 21, 2004 at 09:58:54PM -0700, Christoph Lameter wrote:
> > Changelog
> > 	* NUMA enhancements (rough first implementation)
> > 	* Do not begin search for huge page memory at the first node
> > 	  but start at the current node and then search previous and
> > 	  the following nodes for memory.
> > Signed-off-by: Christoph Lameter <clameter@sgi.com>
>
> dequeue_huge_page() seems to want a nodemask, not a vma, though I
> suppose it's not particularly pressing.

How about this variation following __alloc_page:

Index: linux-2.6.9/mm/hugetlb.c
===================================================================
--- linux-2.6.9.orig/mm/hugetlb.c	2004-10-21 20:39:50.000000000 -0700
+++ linux-2.6.9/mm/hugetlb.c	2004-10-22 10:53:18.000000000 -0700
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
+		if (list_empty(&hugepage_freelists[node_id]))
+			break;
 	}
-	if (nid >= 0 && nid < MAX_NUMNODES &&
-	    !list_empty(&hugepage_freelists[nid])) {
+	if (z) {
 		page = list_entry(hugepage_freelists[nid].next,
 				  struct page, lru);
 		list_del(&page->lru);
