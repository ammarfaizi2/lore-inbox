Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbVEPUGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbVEPUGx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 16:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbVEPUGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 16:06:52 -0400
Received: from serv01.siteground.net ([70.85.91.68]:5535 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S261819AbVEPUED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 16:04:03 -0400
Date: Mon, 16 May 2005 12:05:53 -0700 (PDT)
From: christoph <christoph@scalex86.org>
X-X-Sender: christoph@ScMPusgw
To: linux-mm@kvack.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Factor in buddy allocator alignment requirements in node
 memory alignment
Message-ID: <Pine.LNX.4.62.0505161204540.4977@ScMPusgw>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Memory for nodes on i386 is currently aligned on 2 MB boundaries.
However, the buddy allocator needs pages to be aligned on
PAGE_SIZE << MAX_ORDER which is 8MB if MAX_ORDER = 11.

The following patch determines the maximum alignment needed and will
chose 2MB boundaries if MAX_ORDER is very low but will align correctly
to a MAX_ORDER boundary if the alignment requirements of the page allocator
are greater than 2MB.

Signed-off-by: Christoph Lameter <christoph@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.11/arch/i386/mm/discontig.c
===================================================================
--- linux-2.6.11.orig/arch/i386/mm/discontig.c	2005-05-12 20:04:56.000000000 -0700
+++ linux-2.6.11/arch/i386/mm/discontig.c	2005-05-12 20:05:58.000000000 -0700
@@ -100,8 +100,6 @@ extern unsigned long max_low_pfn;
 extern unsigned long totalram_pages;
 extern unsigned long totalhigh_pages;
 
-#define LARGE_PAGE_BYTES (PTRS_PER_PTE * PAGE_SIZE)
-
 unsigned long node_remap_start_pfn[MAX_NUMNODES];
 unsigned long node_remap_size[MAX_NUMNODES];
 unsigned long node_remap_offset[MAX_NUMNODES];
@@ -185,6 +183,12 @@ static unsigned long calculate_numa_rema
 {
 	int nid;
 	unsigned long size, reserve_pages = 0;
+	/*
+	 * Alignment is either to the PMD boundary or to the boundary of the
+	 * largest order allowed by the buddy allocator whichever is bigger
+	 */
+	unsigned long alignment = (( 1 << MAX_ORDER ) > PTRS_PER_PTE) ?
+					 1 << MAX_ORDER : PTRS_PER_PTE;
 
 	for_each_online_node(nid) {
 		if (nid == 0)
@@ -204,10 +208,10 @@ static unsigned long calculate_numa_rema
 		/* ensure the remap includes space for the pgdat. */
 		size = node_remap_size[nid] + sizeof(pg_data_t);
 
-		/* convert size to large (pmd size) pages, rounding up */
-		size = (size + LARGE_PAGE_BYTES - 1) / LARGE_PAGE_BYTES;
+		/* convert size to the alignment, rounding up */
+		size = (size + (alignment * PAGE_SIZE) - 1) / (alignment * PAGE_SIZE);
 		/* now the roundup is correct, convert to PAGE_SIZE pages */
-		size = size * PTRS_PER_PTE;
+		size = size * alignment;
 		printk("Reserving %ld pages of KVA for lmem_map of node %d\n",
 				size, nid);
 		node_remap_size[nid] = size;
