Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261921AbVCNVRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbVCNVRb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 16:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbVCNVRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 16:17:25 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:62699 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261924AbVCNVPn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 16:15:43 -0500
Subject: [PATCH 4/4] sparsemem base: early_pfn_to_nid() (works before sparse is initialized)
To: akpm@osdl.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>, apw@shadowen.org
From: Dave Hansen <haveblue@us.ibm.com>
Date: Mon, 14 Mar 2005 13:15:34 -0800
Message-Id: <E1DAwuV-0008MT-00@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We _know_ which node pages in general belong to, at least at a
very gross level in node_{start,end}_pfn[].  Use those to target
the allocations of pages.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 arch/ia64/mm/numa.c                      |    0 
 memhotplug-dave/arch/i386/mm/discontig.c |   15 +++++++++++++++
 2 files changed, 15 insertions(+)

diff -puN arch/i386/mm/discontig.c~B-sparse-130-add-early_pfn_to_nid arch/i386/mm/discontig.c
--- memhotplug/arch/i386/mm/discontig.c~B-sparse-130-add-early_pfn_to_nid	2005-03-14 11:52:51.000000000 -0800
+++ memhotplug-dave/arch/i386/mm/discontig.c	2005-03-14 11:52:51.000000000 -0800
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
diff -puN arch/ppc64/mm/numa.c~B-sparse-130-add-early_pfn_to_nid arch/ppc64/mm/numa.c
diff -puN arch/ia64/mm/numa.c~B-sparse-130-add-early_pfn_to_nid arch/ia64/mm/numa.c
_
