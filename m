Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265174AbTCEJOw>; Wed, 5 Mar 2003 04:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265177AbTCEJOw>; Wed, 5 Mar 2003 04:14:52 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:52989 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265174AbTCEJOr>;
	Wed, 5 Mar 2003 04:14:47 -0500
Date: Wed, 5 Mar 2003 15:00:26 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: bcrl@redhat.com, akpm@digeo.com
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch 2/2] Retry based aio read - filesystem read changes
Message-ID: <20030305150026.B1627@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20030305144754.A1600@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030305144754.A1600@in.ibm.com>; from suparna@in.ibm.com on Wed, Mar 05, 2003 at 02:47:54PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 05, 2003 at 02:47:54PM +0530, Suparna Bhattacharya wrote:
> For the last few days I've been playing with prototyping 
> a particular flavour of a retry based implementation for 
> filesystem aio read.

# aioread.patch  : Modifications for aio read in 
# particular (generic_file_aio_read)


diff -ur linux-2.5.62/include/linux/pagemap.h linux-2.5.62-aio/include/linux/pagemap.h
--- linux-2.5.62/include/linux/pagemap.h	Tue Feb 18 04:25:49 2003
+++ linux-2.5.62-aio/include/linux/pagemap.h	Thu Feb 27 19:01:39 2003
@@ -93,6 +93,16 @@
 	if (TestSetPageLocked(page))
 		__lock_page(page);
 }
+
+extern int FASTCALL(__aio_lock_page(struct page *page));
+static inline int aio_lock_page(struct page *page)
+{
+	if (TestSetPageLocked(page))
+		return __aio_lock_page(page);
+	else
+		return 0;
+}
+
 	
 /*
  * This is exported only for wait_on_page_locked/wait_on_page_writeback.
@@ -113,6 +123,15 @@
 		wait_on_page_bit(page, PG_locked);
 }
 
+extern int FASTCALL(aio_wait_on_page_bit(struct page *page, int bit_nr));
+static inline int aio_wait_on_page_locked(struct page *page)
+{
+	if (PageLocked(page))
+		return aio_wait_on_page_bit(page, PG_locked);
+	else
+		return 0;
+}
+
 /* 
  * Wait for a page to complete writeback
  */
diff -ur linux-2.5.62/mm/filemap.c linux-2.5.62-aio/mm/filemap.c
--- linux-2.5.62/mm/filemap.c	Tue Feb 18 04:26:11 2003
+++ linux-2.5.62-aio/mm/filemap.c	Mon Mar  3 19:32:40 2003
@@ -268,6 +268,43 @@
 }
 EXPORT_SYMBOL(wait_on_page_bit);
 
+int aio_schedule(void)
+{
+	if (!current->iocb) {
+		io_schedule();
+		return 0;
+	} else {
+		pr_debug("aio schedule");
+		return -EIOCBQUEUED;
+	}
+}
+
+int aio_wait_on_page_bit(struct page *page, int bit_nr)
+{
+	wait_queue_head_t *waitqueue = page_waitqueue(page);
+	DEFINE_WAIT(sync_wait);
+	wait_queue_t *wait = &sync_wait;
+	int state = TASK_UNINTERRUPTIBLE;
+		
+	if (current->iocb) {
+		wait = &current->iocb->ki_wait;
+		state = TASK_RUNNING;
+	}
+
+	do {
+		prepare_to_wait(waitqueue, wait, state);
+		if (test_bit(bit_nr, &page->flags)) {
+			sync_page(page);
+			if (-EIOCBQUEUED == aio_schedule())
+				return -EIOCBQUEUED;
+		}
+	} while (test_bit(bit_nr, &page->flags));
+	finish_wait(waitqueue, wait);
+
+	return 0;
+}
+EXPORT_SYMBOL(aio_wait_on_page_bit);
+
 /**
  * unlock_page() - unlock a locked page
  *
@@ -336,6 +373,31 @@
 }
 EXPORT_SYMBOL(__lock_page);
 
+int __aio_lock_page(struct page *page)
+{
+	wait_queue_head_t *wqh = page_waitqueue(page);
+	DEFINE_WAIT(sync_wait);
+	wait_queue_t *wait = &sync_wait;
+	int state = TASK_UNINTERRUPTIBLE;
+		
+	if (current->iocb) {
+		wait = &current->iocb->ki_wait;
+		state = TASK_RUNNING;
+	}
+
+	while (TestSetPageLocked(page)) {
+		prepare_to_wait(wqh, wait, state);
+		if (PageLocked(page)) {
+			sync_page(page);
+			if (-EIOCBQUEUED == aio_schedule())
+				return -EIOCBQUEUED;
+		}
+	}
+	finish_wait(wqh, wait);
+	return 0;
+}
+EXPORT_SYMBOL(__aio_lock_page);
+
 /*
  * a rather lightweight function, finding and getting a reference to a
  * hashed page atomically.
@@ -614,7 +676,13 @@
 			goto page_ok;
 
 		/* Get exclusive access to the page ... */
-		lock_page(page);
+		
+		if (aio_lock_page(page)) {
+			pr_debug("queued lock page \n");
+			error = -EIOCBQUEUED;
+			/* TBD: should we hold on to the cached page ? */
+			goto sync_error;
+		}
 
 		/* Did it get unhashed before we got the lock? */
 		if (!page->mapping) {
@@ -636,12 +704,18 @@
 		if (!error) {
 			if (PageUptodate(page))
 				goto page_ok;
-			wait_on_page_locked(page);
+			if (aio_wait_on_page_locked(page)) {
+				pr_debug("queued wait_on_page \n");
+				error = -EIOCBQUEUED;
+				/*TBD:should we hold on to the cached page ?*/
+				goto sync_error;
+			}
 			if (PageUptodate(page))
 				goto page_ok;
 			error = -EIO;
 		}
 
+sync_error:
 		/* UHHUH! A synchronous read error occurred. Report it */
 		desc->error = error;
 		page_cache_release(page);
@@ -813,6 +887,7 @@
 	ssize_t ret;
 
 	init_sync_kiocb(&kiocb, filp);
+	BUG_ON(current->iocb != NULL);
 	ret = __generic_file_aio_read(&kiocb, &local_iov, 1, ppos);
 	if (-EIOCBQUEUED == ret)
 		ret = wait_on_sync_kiocb(&kiocb);
@@ -844,6 +919,7 @@
 {
 	read_descriptor_t desc;
 
+	BUG_ON(current->iocb != NULL);
 	if (!count)
 		return 0;
 
