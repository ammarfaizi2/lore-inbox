Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264430AbUGBNIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264430AbUGBNIy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 09:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264502AbUGBNIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 09:08:53 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:60139 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264430AbUGBNIY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 09:08:24 -0400
Date: Fri, 2 Jul 2004 18:48:00 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Cc: linux-osdl@osdl.org
Subject: Re: [PATCH 6/22] FS AIO read
Message-ID: <20040702131800.GF4374@in.ibm.com>
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

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

------------------------------------------------
From: Suparna Bhattacharya <suparna@in.ibm.com>

Filesystem aio read

Converts the wait for page to become uptodate (wait for page lock)
after readahead/readpage (in do_generic_mapping_read) to a retry
exit.


 filemap.c |   21 ++++++++++++++++++---
 1 files changed, 18 insertions(+), 3 deletions(-)

--- aio/mm/filemap.c	2004-06-17 15:39:49.866081192 -0700
+++ aio-fs_read/mm/filemap.c	2004-06-17 15:34:14.042134192 -0700
@@ -771,7 +771,12 @@ page_ok:
 
 page_not_up_to_date:
 		/* Get exclusive access to the page ... */
-		lock_page(page);
+
+		if (lock_page_wq(page, current->io_wait)) {
+			pr_debug("queued lock page \n");
+			error = -EIOCBRETRY;
+			goto sync_error;
+		}
 
 		/* Did it get unhashed before we got the lock? */
 		if (!page->mapping) {
@@ -793,13 +798,23 @@ readpage:
 		if (!error) {
 			if (PageUptodate(page))
 				goto page_ok;
-			wait_on_page_locked(page);
+			if (wait_on_page_locked_wq(page, current->io_wait)) {
+				pr_debug("queued wait_on_page \n");
+				error = -EIOCBRETRY;
+				goto sync_error;
+			}
+
 			if (PageUptodate(page))
 				goto page_ok;
 			error = -EIO;
 		}
 
-		/* UHHUH! A synchronous read error occurred. Report it */
+sync_error:
+		/* We don't have uptodate data in the page yet */
+		/* Could be due to an error or because we need to
+		 * retry when we get an async i/o notification.
+		 * Report the reason.
+		 */
 		desc->error = error;
 		page_cache_release(page);
 		break;
