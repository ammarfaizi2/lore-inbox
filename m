Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbWFLVOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWFLVOy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 17:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWFLVOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 17:14:51 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:41897 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932305AbWFLVOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 17:14:37 -0400
Date: Mon, 12 Jun 2006 14:14:28 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Con Kolivas <kernel@kolivas.org>, Marcelo Tosatti <marcelo@kvack.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Dave Chinner <dgc@sgi.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20060612211428.20862.63424.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060612211244.20862.41106.sendpatchset@schroedinger.engr.sgi.com>
References: <20060612211244.20862.41106.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 20/21] Conversion of nr_bounce to per zone counter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: zoned vm counters: conversion of nr_bounce to per zone counter
From: Christoph Lameter <clameter@sgi.com>

Conversion of nr_bounce to a per zone counter

nr_bounce is only used for proc output.  So it could be left as an
event counter.  However, the event counters are not accurate and nr_bounce is
categorizing types of pages in a zone.  So we really need this to also be a
per zone counter.

Signed-off-by: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>

Index: linux-2.6.17-rc6-cl/drivers/base/node.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/drivers/base/node.c	2006-06-12 13:03:17.226722868 -0700
+++ linux-2.6.17-rc6-cl/drivers/base/node.c	2006-06-12 13:03:40.552426736 -0700
@@ -65,6 +65,7 @@ static ssize_t node_read_meminfo(struct 
 		       "Node %d Anonymous:    %8lu kB\n"
 		       "Node %d PageTables:   %8lu kB\n"
 		       "Node %d Unstable:     %8lu kB\n"
+		       "Node %d Bounce:       %8lu kB\n"
 		       "Node %d Slab:         %8lu kB\n",
 		       nid, K(i.totalram),
 		       nid, K(i.freeram),
@@ -82,6 +83,7 @@ static ssize_t node_read_meminfo(struct 
 		       nid, K(node_page_state(nid, NR_ANON)),
 		       nid, K(node_page_state(nid, NR_PAGETABLE)),
 		       nid, K(node_page_state(nid, NR_UNSTABLE)),
+		       nid, K(node_page_state(nid, NR_BOUNCE)),
 		       nid, K(node_page_state(nid, NR_SLAB)));
 	n += hugetlb_report_node_meminfo(nid, buf + n);
 	return n;
Index: linux-2.6.17-rc6-cl/include/linux/mmzone.h
===================================================================
--- linux-2.6.17-rc6-cl.orig/include/linux/mmzone.h	2006-06-12 13:03:17.229652374 -0700
+++ linux-2.6.17-rc6-cl/include/linux/mmzone.h	2006-06-12 13:03:40.553403238 -0700
@@ -56,6 +56,7 @@ enum zone_stat_item {
 	NR_DIRTY,
 	NR_WRITEBACK,
 	NR_UNSTABLE,	/* NFS unstable pages */
+	NR_BOUNCE,
 	NR_STAT_ITEMS };
 
 struct per_cpu_pages {
Index: linux-2.6.17-rc6-cl/mm/highmem.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/highmem.c	2006-06-05 17:57:02.000000000 -0700
+++ linux-2.6.17-rc6-cl/mm/highmem.c	2006-06-12 13:03:40.553403238 -0700
@@ -316,7 +316,7 @@ static void bounce_end_io(struct bio *bi
 			continue;
 
 		mempool_free(bvec->bv_page, pool);	
-		dec_page_state(nr_bounce);
+		dec_zone_page_state(bvec->bv_page, NR_BOUNCE);
 	}
 
 	bio_endio(bio_orig, bio_orig->bi_size, err);
@@ -397,7 +397,7 @@ static void __blk_queue_bounce(request_q
 		to->bv_page = mempool_alloc(pool, q->bounce_gfp);
 		to->bv_len = from->bv_len;
 		to->bv_offset = from->bv_offset;
-		inc_page_state(nr_bounce);
+		inc_zone_page_state(to->bv_page, NR_BOUNCE);
 
 		if (rw == WRITE) {
 			char *vto, *vfrom;
Index: linux-2.6.17-rc6-cl/mm/vmstat.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/vmstat.c	2006-06-12 13:03:33.967873583 -0700
+++ linux-2.6.17-rc6-cl/mm/vmstat.c	2006-06-12 13:03:54.972432138 -0700
@@ -471,6 +471,7 @@ static char *vmstat_text[] = {
 	"nr_dirty",
 	"nr_writeback",
 	"nr_unstable",
+	"nr_bounce",
 
 	/* Event counters */
 	"pgpgin",
@@ -518,7 +519,6 @@ static char *vmstat_text[] = {
 	"allocstall",
 
 	"pgrotated",
-	"nr_bounce",
 };
 
 /*
