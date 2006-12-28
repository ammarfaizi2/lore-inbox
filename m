Return-Path: <linux-kernel-owner+w=401wt.eu-S965001AbWL1Iig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965001AbWL1Iig (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 03:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964997AbWL1Iif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 03:38:35 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:47837 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964998AbWL1Ii3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 03:38:29 -0500
Date: Thu, 28 Dec 2006 14:12:52 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, akpm@osdl.org, drepper@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       jakub@redhat.com, mingo@elte.hu
Subject: [FSAIO][PATCH 7/8] Filesystem AIO read
Message-ID: <20061228084252.GG6971@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20061227153855.GA25898@in.ibm.com> <20061228082308.GA4476@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061228082308.GA4476@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Converts the wait for page to become uptodate (lock page)
after readahead/readpage (in do_generic_mapping_read) to a retry
exit, to make buffered filesystem AIO reads actually synchronous.

The patch avoids exclusive wakeups with AIO, a problem originally
spotted by Chris Mason, though the reasoning for why it is an
issue is now much clearer (see explanation in the comment below
in aio.c), and the solution is perhaps slightly simpler.

Signed-off-by: Suparna Bhattacharya <suparna@in.ibm.com>
Acked-by: Ingo Molnar <mingo@elte.hu>
---

 linux-2.6.20-rc1-root/fs/aio.c            |   11 ++++++++++-
 linux-2.6.20-rc1-root/include/linux/aio.h |    5 +++++
 linux-2.6.20-rc1-root/mm/filemap.c        |   19 ++++++++++++++++---
 3 files changed, 31 insertions(+), 4 deletions(-)

diff -puN fs/aio.c~aio-fs-read fs/aio.c
--- linux-2.6.20-rc1/fs/aio.c~aio-fs-read	2006-12-21 08:46:13.000000000 +0530
+++ linux-2.6.20-rc1-root/fs/aio.c	2006-12-28 09:26:30.000000000 +0530
@@ -1529,7 +1529,16 @@ static int aio_wake_function(wait_queue_
 
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
diff -puN mm/filemap.c~aio-fs-read mm/filemap.c
--- linux-2.6.20-rc1/mm/filemap.c~aio-fs-read	2006-12-21 08:46:13.000000000 +0530
+++ linux-2.6.20-rc1-root/mm/filemap.c	2006-12-28 09:31:48.000000000 +0530
@@ -909,6 +909,11 @@ void do_generic_mapping_read(struct addr
 	if (!isize)
 		goto out;
 
+	if (in_aio()) {
+		/* Avoid repeat readahead */
+		if (kiocbTryRestart(io_wait_to_kiocb(current->io_wait)))
+			next_index = last_index;
+	}
 	end_index = (isize - 1) >> PAGE_CACHE_SHIFT;
 	for (;;) {
 		struct page *page;
@@ -978,7 +983,10 @@ page_ok:
 
 page_not_up_to_date:
 		/* Get exclusive access to the page ... */
-		lock_page(page);
+
+		if ((error = __lock_page(page, current->io_wait))) {
+			goto readpage_error;
+		}
 
 		/* Did it get truncated before we got the lock? */
 		if (!page->mapping) {
@@ -1006,7 +1014,8 @@ readpage:
 		}
 
 		if (!PageUptodate(page)) {
-			lock_page(page);
+			if ((error = __lock_page(page, current->io_wait)))
+				goto readpage_error;
 			if (!PageUptodate(page)) {
 				if (page->mapping == NULL) {
 					/*
@@ -1052,7 +1061,11 @@ readpage:
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
diff -puN include/linux/aio.h~aio-fs-read include/linux/aio.h
--- linux-2.6.20-rc1/include/linux/aio.h~aio-fs-read	2006-12-21 08:46:13.000000000 +0530
+++ linux-2.6.20-rc1-root/include/linux/aio.h	2006-12-28 09:26:27.000000000 +0530
@@ -34,21 +34,26 @@ struct kioctx;
 /* #define KIF_LOCKED		0 */
 #define KIF_KICKED		1
 #define KIF_CANCELLED		2
+#define KIF_RESTARTED		3
 
 #define kiocbTryLock(iocb)	test_and_set_bit(KIF_LOCKED, &(iocb)->ki_flags)
 #define kiocbTryKick(iocb)	test_and_set_bit(KIF_KICKED, &(iocb)->ki_flags)
+#define kiocbTryRestart(iocb)	test_and_set_bit(KIF_RESTARTED, &(iocb)->ki_flags)
 
 #define kiocbSetLocked(iocb)	set_bit(KIF_LOCKED, &(iocb)->ki_flags)
 #define kiocbSetKicked(iocb)	set_bit(KIF_KICKED, &(iocb)->ki_flags)
 #define kiocbSetCancelled(iocb)	set_bit(KIF_CANCELLED, &(iocb)->ki_flags)
+#define kiocbSetRestarted(iocb)	set_bit(KIF_RESTARTED, &(iocb)->ki_flags)
 
 #define kiocbClearLocked(iocb)	clear_bit(KIF_LOCKED, &(iocb)->ki_flags)
 #define kiocbClearKicked(iocb)	clear_bit(KIF_KICKED, &(iocb)->ki_flags)
 #define kiocbClearCancelled(iocb)	clear_bit(KIF_CANCELLED, &(iocb)->ki_flags)
+#define kiocbClearRestarted(iocb)	clear_bit(KIF_RESTARTED, &(iocb)->ki_flags)
 
 #define kiocbIsLocked(iocb)	test_bit(KIF_LOCKED, &(iocb)->ki_flags)
 #define kiocbIsKicked(iocb)	test_bit(KIF_KICKED, &(iocb)->ki_flags)
 #define kiocbIsCancelled(iocb)	test_bit(KIF_CANCELLED, &(iocb)->ki_flags)
+#define kiocbIsRestarted(iocb)	test_bit(KIF_RESTARTED, &(iocb)->ki_flags)
 
 /* is there a better place to document function pointer methods? */
 /**
_
-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

