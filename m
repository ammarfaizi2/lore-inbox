Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261778AbVCYUoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbVCYUoG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 15:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbVCYUoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 15:44:06 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:46304 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261778AbVCYUn7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 15:43:59 -0500
Subject: resubmit - [PATCH 1/4] sparsemem base: early_pfn_to_nid() (works before sparse is initialized)
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Dave Hansen <haveblue@us.ibm.com>, apw@shadowen.org
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 25 Mar 2005 12:43:56 -0800
Message-Id: <E1DEvev-0004Pa-00@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We _know_ which node pages in general belong to, at least at a
very gross level in node_{start,end}_pfn[].  Use those to target
the allocations of pages.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/arch/i386/mm/discontig.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+)

diff -puN arch/i386/mm/discontig.c~FROM-MM-add-early_pfn_to_nid arch/i386/mm/discontig.c
--- memhotplug/arch/i386/mm/discontig.c~FROM-MM-add-early_pfn_to_nid	2005-03-25 08:17:12.000000000 -0800
+++ memhotplug-dave/arch/i386/mm/discontig.c	2005-03-25 08:17:12.000000000 -0800
@@ -149,6 +149,21 @@ static void __init find_max_pfn_node(int
 		BUG();
 }
 
+/* Find the owning node for a pfn. */
+int early_pfn_to_nid(unsigned long pfn)
+{
+	int nid;
+
+	for_each_node(nid) {
+		if (node_end_pfn[nid] == 0)
+			break;
+		if (node_start_pfn[nid] <= pfn && node_end_pfn[nid] >= pfn)
+			return nid;
+	}
+
+	return 0;
+}
+
 /* 
  * Allocate memory for the pg_data_t for this node via a crude pre-bootmem
  * method.  For node zero take this from the bottom of memory, for
_
