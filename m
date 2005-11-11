Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbVKKRd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbVKKRd7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 12:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbVKKRd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 12:33:59 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:24775 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750941AbVKKRd6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 12:33:58 -0500
Date: Fri, 11 Nov 2005 09:33:42 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Adam Litke <agl@us.ibm.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com,
       akpm@osdl.org, "Paul T. Darga" <pdarga@umich.edu>
Subject: Re: [PATCH] dequeue a huge page near to this node
In-Reply-To: <1131718765.13502.8.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0511110931420.20360@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0511101521180.16770@schroedinger.engr.sgi.com>
 <1131718765.13502.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Nov 2005, Adam Litke wrote:

> On Thu, 2005-11-10 at 15:27 -0800, Christoph Lameter wrote:
> > The following patch changes the dequeueing to select a huge page near
> > the node executing instead of always beginning to check for free 
> > nodes from node 0. This will result in a placement of the huge pages near
> > the executing processor improving performance.
> > 
> > The existing implementation can place the huge pages far away from 
> > the executing processor causing significant degradation of performance.
> > The search starting from zero also means that the lower zones quickly 
> > run out of memory. Selecting a huge page near the process distributed the 
> > huge pages better.
> > 
> > Signed-off-by: Christoph Lameter <clameter@sgi.com>
> 
> I'll add my voice to the chorus of aye's.

There is a slight problem with the patch. We need to check *z instead of 
z. Here is a fixed patch. Thanks to Paul T. Darga to point that out.

Index: linux-2.6.14-mm1/mm/hugetlb.c
===================================================================
--- linux-2.6.14-mm1.orig/mm/hugetlb.c	2005-11-09 10:47:37.000000000 -0800
+++ linux-2.6.14-mm1/mm/hugetlb.c	2005-11-11 09:31:02.000000000 -0800
@@ -36,14 +36,16 @@ static struct page *dequeue_huge_page(vo
 {
 	int nid = numa_node_id();
 	struct page *page = NULL;
+	struct zonelist *zonelist = NODE_DATA(nid)->node_zonelists;
+	struct zone **z;
 
-	if (list_empty(&hugepage_freelists[nid])) {
-		for (nid = 0; nid < MAX_NUMNODES; ++nid)
-			if (!list_empty(&hugepage_freelists[nid]))
-				break;
+	for (z = zonelist->zones; *z; z++) {
+		nid = (*z)->zone_pgdat->node_id;
+		if (!list_empty(&hugepage_freelists[nid]))
+			break;
 	}
-	if (nid >= 0 && nid < MAX_NUMNODES &&
-	    !list_empty(&hugepage_freelists[nid])) {
+
+	if (*z) {
 		page = list_entry(hugepage_freelists[nid].next,
 				  struct page, lru);
 		list_del(&page->lru);
