Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965067AbWFHXEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965067AbWFHXEg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 19:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965060AbWFHXEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 19:04:25 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:444 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965066AbWFHXDy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 19:03:54 -0400
Date: Thu, 8 Jun 2006 16:03:47 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20060608230347.25121.47306.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060608230239.25121.83503.sendpatchset@schroedinger.engr.sgi.com>
References: <20060608230239.25121.83503.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 13/14] Conversion of nr_bounce to per zone counter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Conversion of nr_bounce to a per zone counter

nr_bounce is only used for proc output. So it could be left as an eventcounter.
However, the eventcounters are not accurate and nr_bounce is categorizing one
type of page in a zone. So we really need this to also be a per zone counter.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc6-mm1/include/linux/mmzone.h
===================================================================
--- linux-2.6.17-rc6-mm1.orig/include/linux/mmzone.h	2006-06-08 14:57:31.889341062 -0700
+++ linux-2.6.17-rc6-mm1/include/linux/mmzone.h	2006-06-08 15:01:43.192115178 -0700
@@ -55,6 +55,7 @@ enum zone_stat_item {
 	NR_DIRTY,
 	NR_WRITEBACK,
 	NR_UNSTABLE,	/* NFS unstable pages */
+	NR_BOUNCE,
 	NR_STAT_ITEMS };
 
 #ifdef CONFIG_SMP
Index: linux-2.6.17-rc6-mm1/include/linux/page-flags.h
===================================================================
--- linux-2.6.17-rc6-mm1.orig/include/linux/page-flags.h	2006-06-08 14:58:56.228837442 -0700
+++ linux-2.6.17-rc6-mm1/include/linux/page-flags.h	2006-06-08 15:01:43.193091680 -0700
@@ -168,7 +168,6 @@ struct page_state {
 	unsigned long allocstall;	/* direct reclaim calls */
 
 	unsigned long pgrotated;	/* pages rotated to tail of the LRU */
-	unsigned long nr_bounce;	/* pages for bounce buffers */
 };
 
 extern void get_full_page_state(struct page_state *ret);
Index: linux-2.6.17-rc6-mm1/mm/highmem.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/highmem.c	2006-06-05 17:57:02.000000000 -0700
+++ linux-2.6.17-rc6-mm1/mm/highmem.c	2006-06-08 15:01:43.194068182 -0700
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
Index: linux-2.6.17-rc6-mm1/mm/page_alloc.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/page_alloc.c	2006-06-08 14:58:56.232743450 -0700
+++ linux-2.6.17-rc6-mm1/mm/page_alloc.c	2006-06-08 15:02:13.761508395 -0700
@@ -630,7 +630,7 @@ static int rmqueue_bulk(struct zone *zon
 
 char *vm_stat_item_descr[NR_STAT_ITEMS] = {
 	"mapped", "pagecache", "slab", "pagetable", "dirty", "writeback",
-	"unstable"
+	"unstable", "bounce"
 };
 
 /*
@@ -2788,6 +2788,7 @@ static char *vmstat_text[] = {
 	"nr_dirty",
 	"nr_writeback",
 	"nr_unstable",
+	"nr_bounce",
 
 	/* Page state */
 	"pgpgin",
@@ -2834,8 +2835,7 @@ static char *vmstat_text[] = {
 	"pageoutrun",
 	"allocstall",
 
-	"pgrotated",
-	"nr_bounce",
+	"pgrotated"
 };
 
 static void *vmstat_start(struct seq_file *m, loff_t *pos)
Index: linux-2.6.17-rc6-mm1/drivers/base/node.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/drivers/base/node.c	2006-06-08 14:58:56.229813944 -0700
+++ linux-2.6.17-rc6-mm1/drivers/base/node.c	2006-06-08 15:01:43.196997687 -0700
@@ -67,7 +67,8 @@ static ssize_t node_read_meminfo(struct 
 		       "Node %d Unstable:     %8lu kB\n"
 		       "Node %d Mapped:       %8lu kB\n"
 		       "Node %d Pagecache:    %8lu kB\n"
-		       "Node %d Slab:         %8lu kB\n",
+		       "Node %d Slab:         %8lu kB\n"
+		       "Node %d Bounce:       %8lu kB\n",
 		       nid, K(i.totalram),
 		       nid, K(i.freeram),
 		       nid, K(i.totalram - i.freeram),
@@ -82,7 +83,8 @@ static ssize_t node_read_meminfo(struct 
 		       nid, K(nr[NR_UNSTABLE]),
 		       nid, K(nr[NR_MAPPED]),
 		       nid, K(nr[NR_PAGECACHE]),
-		       nid, K(nr[NR_SLAB]));
+		       nid, K(nr[NR_SLAB]),
+		       nid, K(nr[NR_BOUNCE]));
 	n += hugetlb_report_node_meminfo(nid, buf + n);
 	return n;
 }
