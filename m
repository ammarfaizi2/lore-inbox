Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264652AbUGBP4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264652AbUGBP4w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 11:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264655AbUGBP4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 11:56:52 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:64479 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264652AbUGBP4i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 11:56:38 -0400
Date: Fri, 2 Jul 2004 21:35:59 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Cc: linux-osdl@osdl.org
Subject: Re: [PATCH 12/22] Writeback page range hint
Message-ID: <20040702160559.GA3450@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20040702130030.GA4256@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040702130030.GA4256@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2004 at 06:30:30PM +0530, Suparna Bhattacharya wrote:
> The patchset contains modifications and fixes to the AIO core
> to support the full retry model, an implementation of AIO
> support for buffered filesystem AIO reads and O_SYNC writes
> (the latter courtesy O_SYNC speedup changes from Andrew Morton),
> an implementation of AIO reads and writes to pipes (from
> Chris Mason) and AIO poll (again from Chris Mason).
> 
> Full retry infrastructure and fixes
> [1] aio-retry.patch
> [2] 4g4g-aio-hang-fix.patch
> [3] aio-retry-elevated-refcount.patch
> [4] aio-splice-runlist.patch
> 
> FS AIO read
> [5] aio-wait-page.patch
> [6] aio-fs_read.patch
> [7] aio-upfront-readahead.patch
> 
> AIO for pipes
> [8] aio-cancel-fix.patch
> [9] aio-read-immediate.patch
> [10] aio-pipe.patch
> [11] aio-context-switch.patch
> 
> Concurrent O_SYNC write speedups using radix-tree walks
> [12] writepages-range.patch

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India
----------------------------------------------------

From: Andrew Morton

Modify mpage_writepages to optionally only write back dirty pages within
a specified range in a file (as in the case of O_SYNC). Cheat a
little to avoid changes to prototypes of aops - just put the
<start, end> hint into the writeback_control struct instead.
If <start, end> are not set, then default to writing back all
the mapping's dirty pages.


 fs/mpage.c                |   27 ++++++++++++++++++++++++---
 include/linux/writeback.h |   21 ++++++++++++++++-----
 2 files changed, 40 insertions(+), 8 deletions(-)

--- aio/fs/mpage.c	2004-06-15 22:19:02.000000000 -0700
+++ writepages-range/fs/mpage.c	2004-06-18 13:24:41.829893560 -0700
@@ -609,7 +609,9 @@ mpage_writepages(struct address_space *m
 	struct pagevec pvec;
 	int nr_pages;
 	pgoff_t index;
+	pgoff_t end = -1;		/* Inclusive */
 	int scanned = 0;
+	int is_range = 0;
 
 	if (wbc->nonblocking && bdi_write_congested(bdi)) {
 		wbc->encountered_congestion = 1;
@@ -627,9 +629,16 @@ mpage_writepages(struct address_space *m
 		index = 0;			  /* whole-file sweep */
 		scanned = 1;
 	}
+	if (wbc->start || wbc->end) {
+		index = wbc->start >> PAGE_CACHE_SHIFT;
+		end = wbc->end >> PAGE_CACHE_SHIFT;
+		is_range = 1;
+		scanned = 1;
+	}
 retry:
 	while (!done && (nr_pages = pagevec_lookup_tag(&pvec, mapping, &index,
-					PAGECACHE_TAG_DIRTY, PAGEVEC_SIZE))) {
+			PAGECACHE_TAG_DIRTY,
+			min(end - index, (pgoff_t)PAGEVEC_SIZE-1) + 1))) {
 		unsigned i;
 
 		scanned = 1;
@@ -646,10 +655,21 @@ retry:
 
 			lock_page(page);
 
+			if (unlikely(page->mapping != mapping)) {
+				unlock_page(page);
+				continue;
+			}
+
+			if (unlikely(is_range) && page->index > end) {
+				done = 1;
+				unlock_page(page);
+				continue;
+			}
+
 			if (wbc->sync_mode != WB_SYNC_NONE)
 				wait_on_page_writeback(page);
 
-			if (page->mapping != mapping || PageWriteback(page) ||
+			if (PageWriteback(page) ||
 					!clear_page_dirty_for_io(page)) {
 				unlock_page(page);
 				continue;
@@ -688,7 +708,8 @@ retry:
 		index = 0;
 		goto retry;
 	}
-	mapping->writeback_index = index;
+	if (!is_range)
+		mapping->writeback_index = index;
 	if (bio)
 		mpage_bio_submit(WRITE, bio);
 	return ret;
--- linux-2.6.7/include/linux/writeback.h	2004-06-15 22:18:58.000000000 -0700
+++ aio/include/linux/writeback.h	2004-06-18 13:24:41.830893408 -0700
@@ -29,7 +29,9 @@ enum writeback_sync_modes {
 };
 
 /*
- * A control structure which tells the writeback code what to do
+ * A control structure which tells the writeback code what to do.  These are
+ * always on the stack, and hence need no locking.  They are always initialised
+ * in a manner such that unspecified fields are set to zero.
  */
 struct writeback_control {
 	struct backing_dev_info *bdi;	/* If !NULL, only write back this
@@ -40,10 +42,19 @@ struct writeback_control {
 	long nr_to_write;		/* Write this many pages, and decrement
 					   this for each page written */
 	long pages_skipped;		/* Pages which were not written */
-	int nonblocking;		/* Don't get stuck on request queues */
-	int encountered_congestion;	/* An output: a queue is full */
-	int for_kupdate;		/* A kupdate writeback */
-	int for_reclaim;		/* Invoked from the page allocator */
+
+	/*
+	 * For a_ops->writepages(): is start or end are non-zero then this is
+	 * a hint that the filesystem need only write out the pages inside that
+	 * byterange.  The byte at `end' is included in the writeout request.
+	 */
+	loff_t start;
+	loff_t end;
+
+	int nonblocking:1;		/* Don't get stuck on request queues */
+	int encountered_congestion:1;	/* An output: a queue is full */
+	int for_kupdate:1;		/* A kupdate writeback */
+	int for_reclaim:1;		/* Invoked from the page allocator */
 };
 
 /*
