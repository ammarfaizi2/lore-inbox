Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264677AbUGBQPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264677AbUGBQPr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 12:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264639AbUGBQPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 12:15:46 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:27783 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264677AbUGBQPk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 12:15:40 -0400
Date: Fri, 2 Jul 2004 21:55:05 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Cc: linux-osdl@osdl.org
Subject: Re: [PATCH 15/22] filemap_fdatawrite range interface
Message-ID: <20040702162505.GE3450@in.ibm.com>
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

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

----------------------------------------------------------

From: Suparna Bhattacharya

Range based equivalent of filemap_fdatawrite for O_SYNC writers (to go
with writepages range support added to mpage_writepages).
If both <start> and <end> are zero, then it defaults to writing
back all of the mapping's dirty pages.


 filemap.c |   23 +++++++++++++++++++++--
 1 files changed, 21 insertions(+), 2 deletions(-)

--- aio/mm/filemap.c	2004-06-18 13:58:26.682069240 -0700
+++ fdatawrite-range/mm/filemap.c	2004-06-18 14:07:25.456163128 -0700
@@ -134,20 +134,26 @@ static inline int sync_page(struct page 
 }
 
 /**
- * filemap_fdatawrite - start writeback against all of a mapping's dirty pages
+ * filemap_fdatawrite_range - start writeback against all of a mapping's 
+ * dirty pages that lie within the byte offsets <start, end> 
  * @mapping: address space structure to write
+ * @start: offset in bytes where the range starts
+ * @end : offset in bytes where the range ends
  *
  * If sync_mode is WB_SYNC_ALL then this is a "data integrity" operation, as
  * opposed to a regular memory * cleansing writeback.  The difference between
  * these two operations is that if a dirty page/buffer is encountered, it must
  * be waited upon, and not just skipped over.
  */
-static int __filemap_fdatawrite(struct address_space *mapping, int sync_mode)
+static int __filemap_fdatawrite_range(struct address_space *mapping, 
+	loff_t start, loff_t end, int sync_mode)
 {
 	int ret;
 	struct writeback_control wbc = {
 		.sync_mode = sync_mode,
 		.nr_to_write = mapping->nrpages * 2,
+		.start = start,
+		.end = end,
 	};
 
 	if (mapping->backing_dev_info->memory_backed)
@@ -157,12 +163,25 @@ static int __filemap_fdatawrite(struct a
 	return ret;
 }
 
+static inline int __filemap_fdatawrite(struct address_space *mapping,
+	int sync_mode)
+{
+	return __filemap_fdatawrite_range(mapping, 0, 0, sync_mode);
+}
+
 int filemap_fdatawrite(struct address_space *mapping)
 {
 	return __filemap_fdatawrite(mapping, WB_SYNC_ALL);
 }
 EXPORT_SYMBOL(filemap_fdatawrite);
 
+int filemap_fdatawrite_range(struct address_space *mapping, 
+	loff_t start, loff_t end)
+{
+	return __filemap_fdatawrite_range(mapping, start, end, WB_SYNC_ALL);
+}
+EXPORT_SYMBOL(filemap_fdatawrite_range);
+
 /*
  * This is a mostly non-blocking flush.  Not suitable for data-integrity
  * purposes - I/O may not be started against all dirty pages.
