Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264660AbUGBQIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264660AbUGBQIy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 12:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264665AbUGBQIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 12:08:54 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:52912 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264660AbUGBQIv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 12:08:51 -0400
Date: Fri, 2 Jul 2004 21:48:16 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Cc: linux-osdl@osdl.org
Subject: Re: [PATCH 13/22] Fix writeback page range to use exact limits
Message-ID: <20040702161816.GC3450@in.ibm.com>
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

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India
-------------------------------------------------------------

From: Suparna Bhattacharya

wait_on_page_writeback_range shouldn't wait for pages beyond the
specified range. Ideally, the radix-tree-lookup could accept an
end_index parameter so that it doesn't return the extra pages
in the first place, but for now we just add a few extra checks
to skip such pages.


 filemap.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

--- aio/mm/filemap.c	2004-06-18 09:24:19.169471216 -0700
+++ fix-writeback-range/mm/filemap.c	2004-06-18 13:56:24.786600168 -0700
@@ -190,7 +190,8 @@ static int wait_on_page_writeback_range(
 
 	pagevec_init(&pvec, 0);
 	index = start;
-	while ((nr_pages = pagevec_lookup_tag(&pvec, mapping, &index,
+	while ((index <= end) && 
+			(nr_pages = pagevec_lookup_tag(&pvec, mapping, &index,
 			PAGECACHE_TAG_WRITEBACK,
 			min(end - index, (pgoff_t)PAGEVEC_SIZE-1) + 1))) {
 		unsigned i;
@@ -198,6 +199,10 @@ static int wait_on_page_writeback_range(
 		for (i = 0; i < nr_pages; i++) {
 			struct page *page = pvec.pages[i];
 
+			/* until radix tree lookup accepts end_index */
+			if (page->index > end) {
+				continue;
+			}
 			wait_on_page_writeback(page);
 			if (PageError(page))
 				ret = -EIO;
