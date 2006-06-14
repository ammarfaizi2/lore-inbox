Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964856AbWFNBHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbWFNBHO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 21:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbWFNBEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 21:04:33 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:25800 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964856AbWFNBEb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 21:04:31 -0400
Date: Tue, 13 Jun 2006 18:04:21 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Con Kolivas <kernel@kolivas.org>,
       Christoph Lameter <clameter@sgi.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Dave Chinner <dgc@sgi.com>
Message-Id: <20060614010421.859.91283.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060614010238.859.4228.sendpatchset@schroedinger.engr.sgi.com>
References: <20060614010238.859.4228.sendpatchset@schroedinger.engr.sgi.com>
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
--- linux-2.6.17-rc6-cl.orig/drivers/base/node.c	2006-06-13 11:25:43.386444670 -0700
+++ linux-2.6.17-rc6-cl/drivers/base/node.c	2006-06-13 11:26:21.881127149 -0700
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
--- linux-2.6.17-rc6-cl.orig/include/linux/mmzone.h	2006-06-13 11:25:43.389374176 -0700
+++ linux-2.6.17-rc6-cl/include/linux/mmzone.h	2006-06-13 11:26:21.882103651 -0700
@@ -56,6 +56,7 @@ enum zone_stat_item {
 	NR_DIRTY,
 	NR_WRITEBACK,
 	NR_UNSTABLE,	/* NFS unstable pages */
+	NR_BOUNCE,
 	NR_VM_ZONE_STAT_ITEMS };
 
 struct per_cpu_pages {
Index: linux-2.6.17-rc6-cl/mm/highmem.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/highmem.c	2006-06-05 17:57:02.000000000 -0700
+++ linux-2.6.17-rc6-cl/mm/highmem.c	2006-06-13 11:26:21.883080153 -0700
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
--- linux-2.6.17-rc6-cl.orig/mm/vmstat.c	2006-06-13 11:25:43.393280184 -0700
+++ linux-2.6.17-rc6-cl/mm/vmstat.c	2006-06-13 11:26:21.883080153 -0700
@@ -465,6 +465,7 @@ static char *vmstat_text[] = {
 	"nr_dirty",
 	"nr_writeback",
 	"nr_unstable",
+	"nr_bounce",
 
 	/* Event counters */
 	"pgpgin",
@@ -512,7 +513,6 @@ static char *vmstat_text[] = {
 	"allocstall",
 
 	"pgrotated",
-	"nr_bounce",
 };
 
 /*
Index: linux-2.6.17-rc6-cl/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/fs/proc/proc_misc.c	2006-06-13 11:26:17.045489603 -0700
+++ linux-2.6.17-rc6-cl/fs/proc/proc_misc.c	2006-06-13 11:26:52.629219866 -0700
@@ -171,6 +171,7 @@ static int meminfo_read_proc(char *page,
 		"Slab:         %8lu kB\n"
 		"PageTables:   %8lu kB\n"
 		"Unstable:     %8lu kB\n"
+		"Bounce:       %8lu kB\n"
 		"CommitLimit:  %8lu kB\n"
 		"Committed_AS: %8lu kB\n"
 		"VmallocTotal: %8lu kB\n"
@@ -196,6 +197,7 @@ static int meminfo_read_proc(char *page,
 		K(global_page_state(NR_SLAB)),
 		K(global_page_state(NR_PAGETABLE)),
 		K(global_page_state(NR_UNSTABLE)),
+		K(global_page_state(NR_BOUNCE)),
 		K(allowed),
 		K(committed),
 		(unsigned long)VMALLOC_TOTAL >> 10,
