Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbVKKAox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbVKKAox (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 19:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbVKKAox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 19:44:53 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:31659 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932285AbVKKAow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 19:44:52 -0500
Date: Thu, 10 Nov 2005 16:44:40 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: Adam Litke <agl@us.ibm.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: RE: [PATCH] dequeue a huge page near to this node
In-Reply-To: <200511102334.jAANY1g21612@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.62.0511101643120.17138@schroedinger.engr.sgi.com>
References: <200511102334.jAANY1g21612@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2005, Chen, Kenneth W wrote:

> Looks great!

Well in that case, we may do even more:

Make huge pages obey cpusets.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.14-mm1/mm/hugetlb.c
===================================================================
--- linux-2.6.14-mm1.orig/mm/hugetlb.c	2005-11-10 15:02:05.000000000 -0800
+++ linux-2.6.14-mm1/mm/hugetlb.c	2005-11-10 16:29:16.000000000 -0800
@@ -11,6 +11,7 @@
 #include <linux/highmem.h>
 #include <linux/nodemask.h>
 #include <linux/pagemap.h>
+#include <linux/cpuset.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
 
@@ -41,7 +42,8 @@ static struct page *dequeue_huge_page(vo
 
 	for (z = zonelist->zones; *z; z++) {
 		nid = (*z)->zone_pgdat->node_id;
-		if (!list_empty(&hugepage_freelists[nid]))
+		if (cpuset_zone_allowed(*z, GFP_HIGHUSER) &&
+		    !list_empty(&hugepage_freelists[nid]))
 			break;
 	}
 
