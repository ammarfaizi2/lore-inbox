Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264127AbTDJSlS (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 14:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264124AbTDJSlQ (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 14:41:16 -0400
Received: from pat.uio.no ([129.240.130.16]:37607 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264122AbTDJSlM (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 14:41:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16021.48508.659053.395724@charged.uio.no>
Date: Thu, 10 Apr 2003 20:52:44 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] make balance_dirty_pages() and NFSv3/v4 talk to one another...
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

  NFSv3 and v4 both have pages that can be in a state other than the
standard dirty/locked/writeback/clean. The case of 'unstable' writes
means that a page may be in a 'clean' state as far as the VM is
concerned (i.e. the page has been written to the server) but it may
not yet have been fsync()ed to disk on the server itself.

  The following patch sets up accounting of this extra state for the
benefit of the VM page reclaiming routines.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.67/fs/nfs/write.c linux-2.5.67-01-nr_dirty/fs/nfs/write.c
--- linux-2.5.67/fs/nfs/write.c	2003-02-10 02:30:00.000000000 +0100
+++ linux-2.5.67-01-nr_dirty/fs/nfs/write.c	2003-04-10 15:00:18.000000000 +0200
@@ -274,8 +274,14 @@
 	err = nfs_flush_file(inode, NULL, 0, 0, 0);
 	if (err < 0)
 		goto out;
-	if (is_sync)
+	if (wbc->sync_mode == WB_SYNC_HOLD)
+		goto out;
+	if (is_sync && wbc->sync_mode == WB_SYNC_ALL) {
 		err = nfs_wb_all(inode);
+	} else
+		nfs_commit_file(inode, NULL, 0, 0, 0);
+	/* Avoid races. Tell upstream we've done all we were told to do */
+	wbc->nr_to_write = 0;
 out:
 	return err;
 }
@@ -363,6 +369,7 @@
 	nfs_list_add_request(req, &nfsi->dirty);
 	nfsi->ndirty++;
 	spin_unlock(&nfs_wreq_lock);
+	inc_page_state(nr_dirty);
 	mark_inode_dirty(inode);
 }
 
@@ -390,6 +397,7 @@
 	nfs_list_add_request(req, &nfsi->commit);
 	nfsi->ncommit++;
 	spin_unlock(&nfs_wreq_lock);
+	inc_page_state(nr_unstable);
 	mark_inode_dirty(inode);
 }
 #endif
@@ -457,6 +465,7 @@
 	int	res;
 	res = nfs_scan_list(&nfsi->dirty, dst, file, idx_start, npages);
 	nfsi->ndirty -= res;
+	sub_page_state(nr_dirty,res);
 	if ((nfsi->ndirty == 0) != list_empty(&nfsi->dirty))
 		printk(KERN_ERR "NFS: desynchronized value of nfs_i.ndirty.\n");
 	return res;
@@ -481,6 +490,7 @@
 	int	res;
 	res = nfs_scan_list(&nfsi->commit, dst, file, idx_start, npages);
 	nfsi->ncommit -= res;
+	sub_page_state(nr_unstable,res);
 	if ((nfsi->ncommit == 0) != list_empty(&nfsi->commit))
 		printk(KERN_ERR "NFS: desynchronized value of nfs_i.ncommit.\n");
 	return res;
diff -u --recursive --new-file linux-2.5.67/include/linux/page-flags.h linux-2.5.67-01-nr_dirty/include/linux/page-flags.h
--- linux-2.5.67/include/linux/page-flags.h	2003-04-09 10:01:28.000000000 +0200
+++ linux-2.5.67-01-nr_dirty/include/linux/page-flags.h	2003-04-10 15:00:18.000000000 +0200
@@ -75,6 +75,7 @@
 #define PG_reclaim		18	/* To be reclaimed asap */
 #define PG_compound		19	/* Part of a compound page */
 
+
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
  * allowed.
@@ -82,6 +83,7 @@
 struct page_state {
 	unsigned long nr_dirty;		/* Dirty writeable pages */
 	unsigned long nr_writeback;	/* Pages under writeback */
+	unsigned long nr_unstable;	/* NFS unstable pages */
 	unsigned long nr_page_table_pages;/* Pages used for pagetables */
 	unsigned long nr_mapped;	/* mapped into pagetables */
 	unsigned long nr_slab;		/* In slab */
@@ -130,6 +132,7 @@
 
 #define inc_page_state(member)	mod_page_state(member, 1UL)
 #define dec_page_state(member)	mod_page_state(member, 0UL - 1)
+#define sub_page_state(member,delta) mod_page_state(member, 0UL - (delta))
 
 
 /*
diff -u --recursive --new-file linux-2.5.67/mm/page_alloc.c linux-2.5.67-01-nr_dirty/mm/page_alloc.c
--- linux-2.5.67/mm/page_alloc.c	2003-04-09 10:01:28.000000000 +0200
+++ linux-2.5.67-01-nr_dirty/mm/page_alloc.c	2003-04-10 15:00:18.000000000 +0200
@@ -936,11 +936,13 @@
 		K(nr_free_pages()),
 		K(nr_free_highpages()));
 
-	printk("Active:%lu inactive:%lu dirty:%lu writeback:%lu free:%u\n",
+	printk("Active:%lu inactive:%lu dirty:%lu writeback:%lu "
+		"unstable:%lu free:%u\n",
 		active,
 		inactive,
 		ps.nr_dirty,
 		ps.nr_writeback,
+		ps.nr_unstable,
 		nr_free_pages());
 
 	for_each_zone(zone) {
@@ -1431,6 +1433,7 @@
 static char *vmstat_text[] = {
 	"nr_dirty",
 	"nr_writeback",
+	"nr_unstable",
 	"nr_page_table_pages",
 	"nr_mapped",
 	"nr_slab",
diff -u --recursive --new-file linux-2.5.67/mm/page-writeback.c linux-2.5.67-01-nr_dirty/mm/page-writeback.c
--- linux-2.5.67/mm/page-writeback.c	2003-04-08 12:16:30.000000000 +0200
+++ linux-2.5.67-01-nr_dirty/mm/page-writeback.c	2003-04-10 15:00:18.000000000 +0200
@@ -138,6 +138,7 @@
 void balance_dirty_pages(struct address_space *mapping)
 {
 	struct page_state ps;
+	long nr_reclaimable;
 	long background_thresh;
 	long dirty_thresh;
 	unsigned long pages_written = 0;
@@ -145,8 +146,7 @@
 
 	struct backing_dev_info *bdi = mapping->backing_dev_info;
 
-	get_dirty_limits(&ps, &background_thresh, &dirty_thresh);
-	while (ps.nr_dirty + ps.nr_writeback > dirty_thresh) {
+	for (;;) {
 		struct writeback_control wbc = {
 			.bdi		= bdi,
 			.sync_mode	= WB_SYNC_NONE,
@@ -154,24 +154,37 @@
 			.nr_to_write	= write_chunk,
 		};
 
+		get_dirty_limits(&ps, &background_thresh, &dirty_thresh);
+		nr_reclaimable = ps.nr_dirty + ps.nr_unstable;
+		if (nr_reclaimable + ps.nr_writeback <= dirty_thresh)
+			break;
+
 		dirty_exceeded = 1;
 
-		if (ps.nr_dirty)
+		/* Note: nr_reclaimable denotes nr_dirty + nr_unstable.
+		 * Unstable writes are a feature of certain networked
+		 * filesystems (i.e. NFS) in which data may have been
+		 * written to the server's write cache, but has not yet
+		 * been flushed to permanent storage.
+		 */
+		if (nr_reclaimable) {
 			writeback_inodes(&wbc);
-
-		get_dirty_limits(&ps, &background_thresh, &dirty_thresh);
-		if (ps.nr_dirty + ps.nr_writeback <= dirty_thresh)
-			break;
-		pages_written += write_chunk - wbc.nr_to_write;
-		if (pages_written >= write_chunk)
-			break;		/* We've done our duty */
+			get_dirty_limits(&ps, &background_thresh,
+					&dirty_thresh);
+			nr_reclaimable = ps.nr_dirty + ps.nr_unstable;
+			if (nr_reclaimable + ps.nr_writeback <= dirty_thresh)
+				break;
+			pages_written += write_chunk - wbc.nr_to_write;
+			if (pages_written >= write_chunk)
+				break;		/* We've done our duty */
+		}
 		blk_congestion_wait(WRITE, HZ/10);
 	}
 
-	if (ps.nr_dirty + ps.nr_writeback <= dirty_thresh)
+	if (nr_reclaimable + ps.nr_writeback <= dirty_thresh)
 		dirty_exceeded = 0;
 
-	if (!writeback_in_progress(bdi) && ps.nr_dirty > background_thresh)
+	if (!writeback_in_progress(bdi) && nr_reclaimable > background_thresh)
 		pdflush_operation(background_writeout, 0);
 }
 
@@ -231,7 +244,8 @@
 		long dirty_thresh;
 
 		get_dirty_limits(&ps, &background_thresh, &dirty_thresh);
-		if (ps.nr_dirty < background_thresh && min_pages <= 0)
+		if (ps.nr_dirty + ps.nr_unstable < background_thresh
+				&& min_pages <= 0)
 			break;
 		wbc.encountered_congestion = 0;
 		wbc.nr_to_write = MAX_WRITEBACK_PAGES;
@@ -302,7 +316,7 @@
 	oldest_jif = jiffies - (dirty_expire_centisecs * HZ) / 100;
 	start_jif = jiffies;
 	next_jif = start_jif + (dirty_writeback_centisecs * HZ) / 100;
-	nr_to_write = ps.nr_dirty;
+	nr_to_write = ps.nr_dirty + ps.nr_unstable;
 	while (nr_to_write > 0) {
 		wbc.encountered_congestion = 0;
 		wbc.nr_to_write = MAX_WRITEBACK_PAGES;
