Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264693AbUGBQ1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264693AbUGBQ1i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 12:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264737AbUGBQ03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 12:26:29 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:7575 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264702AbUGBQZR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 12:25:17 -0400
Date: Fri, 2 Jul 2004 22:04:38 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Cc: linux-osdl@osdl.org
Subject: Re: [PATCH 19/22] Fix math error in AIO wait on writeback
Message-ID: <20040702163438.GI3450@in.ibm.com>
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
> [18] aio-O_SYNC.patch
> [19] O_SYNC-write-fix.patch
> 

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India
-----------------------------------------------------------

From: Chris Mason <mason@suse.com>

BUG 40701 correct math errors for aio O_SYNC writes that lead
to the aio code thinking the write is complete while we are still
waiting for some pages


 filemap.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)


--- aio/mm/filemap.c	2004-06-26 15:50:43.132941192 -0700
+++ O_SYNC-write/mm/filemap.c	2004-06-26 16:01:26.559125544 -0700
@@ -208,7 +208,7 @@ static ssize_t wait_on_page_writeback_ra
 	struct pagevec pvec;
 	int nr_pages;
 	int ret = 0, done = 0;
-	pgoff_t index, curr = start;
+	pgoff_t index;
 
 	if (end < start)
 		return 0;
@@ -232,12 +232,9 @@ static ssize_t wait_on_page_writeback_ra
 				unlock_page(page);
 				continue;
                        }
-			curr = page->index;
 			unlock_page(page);
 			ret = wait_on_page_writeback_wq(page, wait);
 			if (ret == -EIOCBRETRY) {
-				if (curr > start)
-					ret = curr - start;
 				done = 1;
 				break;
 			}
