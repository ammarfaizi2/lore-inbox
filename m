Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265317AbUHAHjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265317AbUHAHjK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 03:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265429AbUHAHjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 03:39:09 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:35001 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S265317AbUHAHi3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 03:38:29 -0400
Date: Sun, 1 Aug 2004 13:17:51 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] Writeback page range hint
Message-ID: <20040801074751.GA7327@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20040801074518.GA7310@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040801074518.GA7310@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 01, 2004 at 01:15:18PM +0530, Suparna Bhattacharya wrote:
> 
> The attached patches (generated against 2.6.8-rc2) enable concurrent 
> O_SYNC writers to different parts of the same file by avoiding 
> serialising on i_sem across the wait for IO completion.
> 
> This is mostly your work, ported to the tagged radix tree VFS changes
> and a few fixes. I have been carrying these patches for sometime now; 
> they can be the merged upstream. Please apply.
> 

[1] writepages-range.patch

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

------------------------------------------------------

From: Andrew Morton <akpm@osdl.org>

Modify mpage_writepages to optionally only write back dirty pages within
a specified range in a file (as in the case of O_SYNC). Cheat a
little to avoid changes to prototypes of aops - just put the
<start, end> hint into the writeback_control struct instead.
If <start, end> are not set, then default to writing back all
the mapping's dirty pages.

Signed-off-by: Suparna Bhattacharya <suparna@in.ibm.com>

 linux-2.6.8-rc2-suparna/fs/mpage.c                |   27 +++++++++++++++++++---
 linux-2.6.8-rc2-suparna/include/linux/writeback.h |   21 +++++++++++++----
 2 files changed, 40 insertions(+), 8 deletions(-)

diff -puN fs/mpage.c~writepages-range fs/mpage.c
--- linux-2.6.8-rc2/fs/mpage.c~writepages-range	2004-08-01 12:30:15.000000000 +0530
+++ linux-2.6.8-rc2-suparna/fs/mpage.c	2004-08-01 12:30:15.000000000 +0530
@@ -622,7 +622,9 @@ mpage_writepages(struct address_space *m
 	struct pagevec pvec;
 	int nr_pages;
 	pgoff_t index;
+	pgoff_t end = -1;		/* Inclusive */
 	int scanned = 0;
+	int is_range = 0;
 
 	if (wbc->nonblocking && bdi_write_congested(bdi)) {
 		wbc->encountered_congestion = 1;
@@ -640,9 +642,16 @@ mpage_writepages(struct address_space *m
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
@@ -659,10 +668,21 @@ retry:
 
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
@@ -701,7 +721,8 @@ retry:
 		index = 0;
 		goto retry;
 	}
-	mapping->writeback_index = index;
+	if (!is_range)
+		mapping->writeback_index = index;
 	if (bio)
 		mpage_bio_submit(WRITE, bio);
 	return ret;
diff -puN include/linux/writeback.h~writepages-range include/linux/writeback.h
--- linux-2.6.8-rc2/include/linux/writeback.h~writepages-range	2004-08-01 12:30:15.000000000 +0530
+++ linux-2.6.8-rc2-suparna/include/linux/writeback.h	2004-08-01 12:30:15.000000000 +0530
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

_
