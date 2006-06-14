Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbWFNBGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWFNBGO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 21:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWFNBEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 21:04:39 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:19173 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964849AbWFNBEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 21:04:20 -0400
Date: Tue, 13 Jun 2006 18:04:11 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Con Kolivas <kernel@kolivas.org>,
       Christoph Lameter <clameter@sgi.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Dave Chinner <dgc@sgi.com>
Message-Id: <20060614010411.859.99305.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060614010238.859.4228.sendpatchset@schroedinger.engr.sgi.com>
References: <20060614010238.859.4228.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 18/21] Conversion of nr_unstable to per zone counter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: zoned vm counters: conversion of nr_unstable to per zone counter
From: Christoph Lameter <clameter@sgi.com>

Conversion of nr_unstable to a per zone counter

We need to do some special modifications to the nfs code
since there are multiple cases of disposition and we need
to have a page ref for proper accounting. Needs to be
reviewed by one familiar with NFS.

This converts the last critical page state of the VM and therefore
we need to remove several functions that were depending on
GET_PAGE_STATE_LAST in order to make the kernel compile again.
We are only left with event type counters in page state.

Signed-off-by: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>

Index: linux-2.6.17-rc6-cl/drivers/base/node.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/drivers/base/node.c	2006-06-13 11:25:40.987179436 -0700
+++ linux-2.6.17-rc6-cl/drivers/base/node.c	2006-06-13 11:25:43.386444670 -0700
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
--- linux-2.6.17-rc6-cl.orig/fs/fs-writeback.c	2006-06-13 11:25:38.014707571 -0700
+++ linux-2.6.17-rc6-cl/fs/fs-writeback.c	2006-06-13 11:25:43.387421172 -0700
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
--- linux-2.6.17-rc6-cl.orig/fs/nfs/write.c	2006-06-13 11:25:38.016660575 -0700
+++ linux-2.6.17-rc6-cl/fs/nfs/write.c	2006-06-13 11:25:43.388397674 -0700
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
@@ -1419,10 +1418,10 @@ static void nfs_commit_done(struct rpc_t
 		dprintk(" mismatch\n");
 		nfs_mark_request_dirty(req);
 	next:
+		if (req->wb_page)
+			dec_zone_page_state(req->wb_page, NR_UNSTABLE);
 		nfs_clear_page_writeback(req);
-		res++;
 	}
-	sub_page_state(nr_unstable,res);
 }
 
 static const struct rpc_call_ops nfs_commit_ops = {
Index: linux-2.6.17-rc6-cl/include/linux/mmzone.h
===================================================================
--- linux-2.6.17-rc6-cl.orig/include/linux/mmzone.h	2006-06-13 11:25:40.989132440 -0700
+++ linux-2.6.17-rc6-cl/include/linux/mmzone.h	2006-06-13 11:25:43.389374176 -0700
@@ -55,6 +55,7 @@ enum zone_stat_item {
 	NR_PAGETABLE,	/* used for pagetables */
 	NR_DIRTY,
 	NR_WRITEBACK,
+	NR_UNSTABLE,	/* NFS unstable pages */
 	NR_VM_ZONE_STAT_ITEMS };
 
 struct per_cpu_pages {
Index: linux-2.6.17-rc6-cl/mm/page_alloc.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/page_alloc.c	2006-06-13 11:25:40.991085444 -0700
+++ linux-2.6.17-rc6-cl/mm/page_alloc.c	2006-06-13 11:25:43.391327180 -0700
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
--- linux-2.6.17-rc6-cl.orig/mm/page-writeback.c	2006-06-13 11:25:40.992061946 -0700
+++ linux-2.6.17-rc6-cl/mm/page-writeback.c	2006-06-13 11:25:43.391327180 -0700
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
--- linux-2.6.17-rc6-cl.orig/fs/proc/proc_misc.c	2006-06-13 11:25:40.988155938 -0700
+++ linux-2.6.17-rc6-cl/fs/proc/proc_misc.c	2006-06-13 11:26:17.045489603 -0700
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
@@ -172,6 +170,7 @@ static int meminfo_read_proc(char *page,
 		"Mapped:       %8lu kB\n"
 		"Slab:         %8lu kB\n"
 		"PageTables:   %8lu kB\n"
+		"Unstable:     %8lu kB\n"
 		"CommitLimit:  %8lu kB\n"
 		"Committed_AS: %8lu kB\n"
 		"VmallocTotal: %8lu kB\n"
@@ -196,6 +195,7 @@ static int meminfo_read_proc(char *page,
 		K(global_page_state(NR_MAPPED)),
 		K(global_page_state(NR_SLAB)),
 		K(global_page_state(NR_PAGETABLE)),
+		K(global_page_state(NR_UNSTABLE)),
 		K(allowed),
 		K(committed),
 		(unsigned long)VMALLOC_TOTAL >> 10,
Index: linux-2.6.17-rc6-cl/mm/vmstat.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/vmstat.c	2006-06-13 11:25:40.992061946 -0700
+++ linux-2.6.17-rc6-cl/mm/vmstat.c	2006-06-13 11:25:43.393280184 -0700
@@ -464,10 +464,9 @@ static char *vmstat_text[] = {
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
Index: linux-2.6.17-rc6-cl/fs/nfs/pagelist.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/fs/nfs/pagelist.c	2006-06-13 11:25:38.015684073 -0700
+++ linux-2.6.17-rc6-cl/fs/nfs/pagelist.c	2006-06-13 12:36:29.387269828 -0700
@@ -154,6 +154,7 @@ void nfs_clear_request(struct nfs_page *
 {
 	struct page *page = req->wb_page;
 	if (page != NULL) {
+		dec_zone_page_state(page, NR_UNSTABLE);
 		page_cache_release(page);
 		req->wb_page = NULL;
 	}
