Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbWFLVPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbWFLVPi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 17:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWFLVO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 17:14:59 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:3504 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932304AbWFLVO3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 17:14:29 -0400
Date: Mon, 12 Jun 2006 14:14:18 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Con Kolivas <kernel@kolivas.org>, Marcelo Tosatti <marcelo@kvack.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Dave Chinner <dgc@sgi.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20060612211418.20862.76154.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060612211244.20862.41106.sendpatchset@schroedinger.engr.sgi.com>
References: <20060612211244.20862.41106.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 18/21] Conversion of nr_unstable to per zone counter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: zoned vm counters: conversion of nr_unstable to per zone counter
From: Christoph Lameter <clameter@sgi.com>

Conversion of nr_unstable to a per zone counter

This converts the last critical page state of the VM and therefore
we need to remove several functions that were depending on
GET_PAGE_STATE_LAST in order to make the kernel compile again.
We are only left with event type counters in page state.

Signed-off-by: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>

Index: linux-2.6.17-rc6-cl/drivers/base/node.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/drivers/base/node.c	2006-06-12 13:03:04.914985335 -0700
+++ linux-2.6.17-rc6-cl/drivers/base/node.c	2006-06-12 13:03:17.226722868 -0700
@@ -40,13 +40,11 @@ static ssize_t node_read_meminfo(struct 
 	int n;
 	int nid = dev->id;
 	struct sysinfo i;
-	struct page_state ps;
 	unsigned long inactive;
 	unsigned long active;
 	unsigned long free;
 
 	si_meminfo_node(&i, nid);
-	get_page_state_node(&ps, nid);
 	__get_zone_counts(&active, &inactive, &free, NODE_DATA(nid));
 
 
@@ -66,6 +64,7 @@ static ssize_t node_read_meminfo(struct 
 		       "Node %d Mapped:       %8lu kB\n"
 		       "Node %d Anonymous:    %8lu kB\n"
 		       "Node %d PageTables:   %8lu kB\n"
+		       "Node %d Unstable:     %8lu kB\n"
 		       "Node %d Slab:         %8lu kB\n",
 		       nid, K(i.totalram),
 		       nid, K(i.freeram),
@@ -82,6 +81,7 @@ static ssize_t node_read_meminfo(struct 
 		       nid, K(node_page_state(nid, NR_MAPPED)),
 		       nid, K(node_page_state(nid, NR_ANON)),
 		       nid, K(node_page_state(nid, NR_PAGETABLE)),
+		       nid, K(node_page_state(nid, NR_UNSTABLE)),
 		       nid, K(node_page_state(nid, NR_SLAB)));
 	n += hugetlb_report_node_meminfo(nid, buf + n);
 	return n;
Index: linux-2.6.17-rc6-cl/fs/fs-writeback.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/fs/fs-writeback.c	2006-06-12 13:02:52.204834975 -0700
+++ linux-2.6.17-rc6-cl/fs/fs-writeback.c	2006-06-12 13:03:17.227699370 -0700
@@ -473,7 +473,7 @@ void sync_inodes_sb(struct super_block *
 		.range_end	= LLONG_MAX,
 	};
 	unsigned long nr_dirty = global_page_state(NR_DIRTY);
-	unsigned long nr_unstable = read_page_state(nr_unstable);
+	unsigned long nr_unstable = global_page_state(NR_UNSTABLE);
 
 	wbc.nr_to_write = nr_dirty + nr_unstable +
 			(inodes_stat.nr_inodes - inodes_stat.nr_unused) +
Index: linux-2.6.17-rc6-cl/fs/nfs/write.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/fs/nfs/write.c	2006-06-12 13:02:52.206787979 -0700
+++ linux-2.6.17-rc6-cl/fs/nfs/write.c	2006-06-12 13:03:17.228675872 -0700
@@ -525,7 +525,7 @@ nfs_mark_request_commit(struct nfs_page 
 	nfs_list_add_request(req, &nfsi->commit);
 	nfsi->ncommit++;
 	spin_unlock(&nfsi->req_lock);
-	inc_page_state(nr_unstable);
+	inc_zone_page_state(req->wb_page, NR_UNSTABLE);
 	mark_inode_dirty(inode);
 }
 #endif
@@ -1382,7 +1382,6 @@ static void nfs_commit_done(struct rpc_t
 {
 	struct nfs_write_data	*data = calldata;
 	struct nfs_page		*req;
-	int res = 0;
 
         dprintk("NFS: %4d nfs_commit_done (status %d)\n",
                                 task->tk_pid, task->tk_status);
@@ -1420,9 +1419,8 @@ static void nfs_commit_done(struct rpc_t
 		nfs_mark_request_dirty(req);
 	next:
 		nfs_clear_page_writeback(req);
-		res++;
+		dec_zone_page_state(req->wb_page, NR_UNSTABLE);
 	}
-	sub_page_state(nr_unstable,res);
 }
 
 static const struct rpc_call_ops nfs_commit_ops = {
Index: linux-2.6.17-rc6-cl/include/linux/mmzone.h
===================================================================
--- linux-2.6.17-rc6-cl.orig/include/linux/mmzone.h	2006-06-12 13:03:04.916938339 -0700
+++ linux-2.6.17-rc6-cl/include/linux/mmzone.h	2006-06-12 13:03:17.229652374 -0700
@@ -55,6 +55,7 @@ enum zone_stat_item {
 	NR_PAGETABLE,	/* used for pagetables */
 	NR_DIRTY,
 	NR_WRITEBACK,
+	NR_UNSTABLE,	/* NFS unstable pages */
 	NR_STAT_ITEMS };
 
 struct per_cpu_pages {
Index: linux-2.6.17-rc6-cl/mm/page_alloc.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/page_alloc.c	2006-06-12 13:03:04.919867845 -0700
+++ linux-2.6.17-rc6-cl/mm/page_alloc.c	2006-06-12 13:03:17.231605378 -0700
@@ -1361,7 +1361,6 @@ void si_meminfo_node(struct sysinfo *val
  */
 void show_free_areas(void)
 {
-	struct page_state ps;
 	int cpu, temperature;
 	unsigned long active;
 	unsigned long inactive;
@@ -1393,7 +1392,6 @@ void show_free_areas(void)
 		}
 	}
 
-	get_page_state(&ps);
 	get_zone_counts(&active, &inactive, &free);
 
 	printk("Free pages: %11ukB (%ukB HighMem)\n",
@@ -1406,7 +1404,7 @@ void show_free_areas(void)
 		inactive,
 		global_page_state(NR_DIRTY),
 		global_page_state(NR_WRITEBACK),
-		ps.nr_unstable,
+		global_page_state(NR_UNSTABLE),
 		nr_free_pages(),
 		global_page_state(NR_SLAB),
 		global_page_state(NR_MAPPED),
Index: linux-2.6.17-rc6-cl/mm/page-writeback.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/page-writeback.c	2006-06-12 13:03:04.919867845 -0700
+++ linux-2.6.17-rc6-cl/mm/page-writeback.c	2006-06-12 13:03:17.232581880 -0700
@@ -110,7 +110,7 @@ struct writeback_state
 static void get_writeback_state(struct writeback_state *wbs)
 {
 	wbs->nr_dirty = global_page_state(NR_DIRTY);
-	wbs->nr_unstable = read_page_state(nr_unstable);
+	wbs->nr_unstable = global_page_state(NR_UNSTABLE);
 	wbs->nr_mapped = global_page_state(NR_MAPPED) +
 				global_page_state(NR_ANON);
 	wbs->nr_writeback = global_page_state(NR_WRITEBACK);
Index: linux-2.6.17-rc6-cl/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/fs/proc/proc_misc.c	2006-06-12 13:03:04.915961837 -0700
+++ linux-2.6.17-rc6-cl/fs/proc/proc_misc.c	2006-06-12 13:03:17.233558382 -0700
@@ -120,7 +120,6 @@ static int meminfo_read_proc(char *page,
 {
 	struct sysinfo i;
 	int len;
-	struct page_state ps;
 	unsigned long inactive;
 	unsigned long active;
 	unsigned long free;
@@ -129,7 +128,6 @@ static int meminfo_read_proc(char *page,
 	struct vmalloc_info vmi;
 	long cached;
 
-	get_page_state(&ps);
 	get_zone_counts(&active, &inactive, &free);
 
 /*
Index: linux-2.6.17-rc6-cl/mm/vmstat.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/vmstat.c	2006-06-12 13:03:12.036614604 -0700
+++ linux-2.6.17-rc6-cl/mm/vmstat.c	2006-06-12 13:03:33.967873583 -0700
@@ -470,10 +470,9 @@ static char *vmstat_text[] = {
 	"nr_page_table_pages",
 	"nr_dirty",
 	"nr_writeback",
-
-	/* Page state */
 	"nr_unstable",
 
+	/* Event counters */
 	"pgpgin",
 	"pgpgout",
 	"pswpin",
