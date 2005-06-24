Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263274AbVFXLR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263274AbVFXLR3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 07:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263272AbVFXLOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 07:14:54 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:43692 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263255AbVFXLLz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 07:11:55 -0400
Date: Fri, 24 Jun 2005 16:51:11 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org
Cc: linux-kernel@vger.kernel.org, bcrl@kvack.org, wli@holomorphy.com,
       zab@zabbo.net, mason@suse.com
Subject: [PATCH 1/2] Filesystem AIO read
Message-ID: <20050624112111.GA4574@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20050620120154.GA4810@in.ibm.com> <20050624104928.GA4408@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050624104928.GA4408@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2005 at 04:19:28PM +0530, Suparna Bhattacharya wrote:
> > (2) Buffered filesystem AIO read/write (me/Ben)

Filesystem aio read:

Converts the wait for page to become uptodate (lock page)
after readahead/readpage (in do_generic_mapping_read) to a retry
exit, to make buffered filesystem AIO reads actually synchronous.

The patch avoids exclusive wakeups with AIO, a problem originally
spotted by Chris Mason, though the reasoning for why it is an
issue is now much clearer (see explanation in the comment below
in aio.c), and the solution is perhaps slightly simpler.

 fs/aio.c     |   11 ++++++++++-
 mm/filemap.c |   20 +++++++++++++++++---
 2 files changed, 27 insertions(+), 4 deletions(-)


diff -u orig/mm/filemap.c linux-2.6.12-rc6/mm/filemap.c
--- orig/mm/filemap.c	2005-06-23 21:50:28.000000000 +0530
+++ linux-2.6.12-rc6/mm/filemap.c	2005-06-21 12:13:21.000000000 +0530
@@ -770,6 +770,11 @@
 	if (!isize)
 		goto out;
 
+	if (in_aio()) {
+		/* Avoid repeat readahead */
+		if (is_retried_kiocb(io_wait_to_kiocb(current->io_wait)))
+			next_index = last_index;
+	}
 	end_index = (isize - 1) >> PAGE_CACHE_SHIFT;
 	for (;;) {
 		struct page *page;
@@ -771,7 +771,11 @@ page_ok:
 
 page_not_up_to_date:
 		/* Get exclusive access to the page ... */
-		lock_page(page);
+
+		if ((error = __lock_page(page, current->io_wait))) {
+			pr_debug("queued lock page \n");
+			goto readpage_error;
+		}
 
 		/* Did it get unhashed before we got the lock? */
 		if (!page->mapping) {
@@ -793,7 +798,8 @@ readpage:
 		goto readpage_error;
 
 		if (!PageUptodate(page)) {
-			lock_page(page);
+			if ((error = __lock_page(page, current->io_wait)))
+				goto readpage_error;
 			if (!PageUptodate(page)) {
 				if (page->mapping == NULL) {
 					/*
@@ -880,7 +880,11 @@ readpage:
 		goto page_ok;
  
 readpage_error:
-		/* UHHUH! A synchronous read error occurred. Report it */
+		/* We don't have uptodate data in the page yet */
+		/* Could be due to an error or because we need to
+		 * retry when we get an async i/o notification.
+		 * Report the reason.
+		 */
 		desc->error = error;
 		page_cache_release(page);
 		goto out;
diff -u orig/fs/aio.c linux-2.6.12-rc6/fs/aio.c
--- orig/fs/aio.c	2005-06-23 21:51:14.000000000 +0530
+++ linux-2.6.12-rc6/fs/aio.c	2005-06-23 18:47:18.000000000 +0530
@@ -1473,7 +1473,16 @@
 
 	list_del_init(&wait->task_list);
 	kick_iocb(iocb);
-	return 1;
+	/* 
+	 * Avoid exclusive wakeups with retries since an exclusive wakeup
+	 * may involve implicit expectations of waking up the next waiter
+	 * and there is no guarantee that the retry will take a path that
+	 * would do so. For example if a page has become up-to-date, then
+	 * a retried read may end up straightaway performing a copyout 
+	 * and not go through a lock_page - unlock_page that would have
+	 * passed the baton to the next waiter.
+	 */
+	return 0;
 }
 
 int fastcall io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

