Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264686AbUGBQWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264686AbUGBQWt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 12:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264701AbUGBQWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 12:22:49 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:41162 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264686AbUGBQWF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 12:22:05 -0400
Date: Fri, 2 Jul 2004 22:01:29 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Cc: linux-osdl@osdl.org
Subject: Re: [PATCH 17/22] AIO wait on writeback
Message-ID: <20040702163129.GG3450@in.ibm.com>
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
> [13] fix-writeback-range.patch
> [14] fix-writepages-range.patch
> [15] fdatawrite-range.patch
> [16] O_SYNC-speedup.patch
> 
> AIO O_SYNC write
> [17] aio-wait_on_page_writeback_range.patch

Todo: merge with the fix in [19] 
-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

-----------------------------------------------------------

From: Suparna Bhattacharya

Implements async support for wait_on_page_writeback_range.
Accepts a wait queue entry as an additional parameter,
invokes the async version wait_on_page_writeback and takes care
of propagating how much of writeback in the range completed so
far (in terms of number of pages), on an -EIOCBRETRY, so that
subqueuent retries can accordingly check/wait only on the
remaining part of the range.


 filemap.c |  137 +++++++++++++++++++++++++++++++++++++++++++++++++------------- 1 files changed, 109 insertions(+), 28 deletions(-)

--- aio/mm/filemap.c	2004-06-18 14:11:49.144076472 -0700
+++ aio-wait_on_page_writeback_range/mm/filemap.c	2004-06-18 14:16:38.620069432 -0700
@@ -194,24 +194,29 @@ EXPORT_SYMBOL(filemap_flush);
 
 /*
  * Wait for writeback to complete against pages indexed by start->end
- * inclusive
+ * inclusive. 
+ * This could be a synchronous wait or could just queue an async
+ * notification callback depending on the wait queue entry parameter
+ * Returns the size of the range for which writeback has been completed 
+ * in terms of number of pages. This value is used in the AIO case
+ * to retry the wait for the remaining part of the range through on
+ * async notification.
  */
-static int wait_on_page_writeback_range(struct address_space *mapping,
-				pgoff_t start, pgoff_t end)
+static ssize_t wait_on_page_writeback_range_wq(struct address_space *mapping,
+				pgoff_t start, pgoff_t end, wait_queue_t *wait)
 {
 	struct pagevec pvec;
 	int nr_pages;
-	int ret = 0;
-	pgoff_t index;
+	int ret = 0, done = 0;
+	pgoff_t index, curr = start;
 
 	if (end < start)
 		return 0;
 
 	pagevec_init(&pvec, 0);
 	index = start;
-	while ((index <= end) && 
-			(nr_pages = pagevec_lookup_tag(&pvec, mapping, &index,
-			PAGECACHE_TAG_WRITEBACK,
+	while (!done && (index <= end) && (nr_pages = pagevec_lookup_tag(&pvec,
+			 mapping, &index, PAGECACHE_TAG_WRITEBACK,
 			min(end - index, (pgoff_t)PAGEVEC_SIZE-1) + 1))) {
 		unsigned i;
 
@@ -222,7 +227,20 @@ static int wait_on_page_writeback_range(
 			if (page->index > end) {
 				continue;
 			}
-			wait_on_page_writeback(page);
+			lock_page(page);
+			if (unlikely(page->mapping != mapping)) {
+				unlock_page(page);
+				continue;
+                       }
+			curr = page->index;
+			unlock_page(page);
+			ret = wait_on_page_writeback_wq(page, wait);
+			if (ret == -EIOCBRETRY) {
+				if (curr > start)
+					ret = curr - start;
+				done = 1;
+				break;
+			}
 			if (PageError(page))
 				ret = -EIO;
 		}
@@ -236,9 +254,17 @@ static int wait_on_page_writeback_range(
 	if (test_and_clear_bit(AS_EIO, &mapping->flags))
 		ret = -EIO;
 
+	if (ret == 0)
+		ret = end - start + 1;
+
 	return ret;
 }
 
+static inline ssize_t wait_on_page_writeback_range(struct address_space 
+				*mapping, pgoff_t start, pgoff_t end)
+{
+	return wait_on_page_writeback_range_wq(mapping, start, end, NULL);
+}

 /*
  * Write and wait upon all the pages in the passed range.  This is a "data
