Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264668AbUGBQNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264668AbUGBQNW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 12:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264677AbUGBQNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 12:13:22 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:43694 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264668AbUGBQNN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 12:13:13 -0400
Date: Fri, 2 Jul 2004 21:52:43 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Cc: linux-osdl@osdl.org
Subject: Re: [PATCH 14/22] mpage writepages range limit fix
Message-ID: <20040702162243.GD3450@in.ibm.com>
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

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

----------------------------------------------------

From: Suparna Bhattacharya

Safeguard to make sure we break out of pagevec_lookup_tag loop if we
are beyond the specified range.


 mpage.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

--- aio/fs/mpage.c.orig	2004-06-18 14:55:21.937871440 -0700
+++ fix-writepages-range/fs/mpage.c	2004-06-18 14:56:10.739452472 -0700
@@ -636,7 +636,8 @@ mpage_writepages(struct address_space *m
 		scanned = 1;
 	}
 retry:
-	while (!done && (nr_pages = pagevec_lookup_tag(&pvec, mapping, &index,
+	while (!done && (index <= end) && 
+			(nr_pages = pagevec_lookup_tag(&pvec, mapping, &index,
 			PAGECACHE_TAG_DIRTY,
 			min(end - index, (pgoff_t)PAGEVEC_SIZE-1) + 1))) {
 		unsigned i;
