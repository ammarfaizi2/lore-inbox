Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263623AbTDXEsJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 00:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264400AbTDXEsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 00:48:08 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:26256 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264377AbTDXErx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 00:47:53 -0400
Date: Thu, 24 Apr 2003 10:34:55 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: bcrl@redhat.com, akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, linux-aio@kvack.org,
       linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/7] Filesystem AIO rdwr - aio read 
Message-ID: <20030424103455.B2288@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20030424102221.A2166@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030424102221.A2166@in.ibm.com>; from suparna@in.ibm.com on Thu, Apr 24, 2003 at 10:22:22AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24, 2003 at 10:22:22AM +0530, Suparna Bhattacharya wrote:
> Here is a revised version of the filesystem AIO patches
> for 2.5.68.
> 
> 02aiord.patch	 	: Filesystem aio read 

Changes to generic_file_aio_read code to use the aio
retry infrastructure. The main blocking points addressed
are lock_page and wait_on_page_locked.

Regards
Suparna
-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

02aiord.patch
.............
 include/linux/pagemap.h |   19 ++++++++++++++
 mm/filemap.c            |   63 ++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 72 insertions(+), 10 deletions(-)

diff -ur -X /home/kiran/dontdiff linux-2.5.68/include/linux/pagemap.h linux-aio-2568/include/linux/pagemap.h
--- linux-2.5.68/include/linux/pagemap.h	Mon Apr 21 23:30:40 2003
+++ linux-aio-2568/include/linux/pagemap.h	Mon Apr 21 17:26:58 2003
@@ -135,6 +135,16 @@
 	if (TestSetPageLocked(page))
 		__lock_page(page);
 }
+
+extern int FASTCALL(__lock_page_wq(struct page *page, wait_queue_t *wait));
+static inline int lock_page_wq(struct page *page, wait_queue_t *wait)
+{
+	if (TestSetPageLocked(page))
+		return __lock_page_wq(page, wait);
+	else
+		return 0;
+}
+
 	
 /*
  * This is exported only for wait_on_page_locked/wait_on_page_writeback.
@@ -155,6 +165,15 @@
 		wait_on_page_bit(page, PG_locked);
 }
 
+extern int FASTCALL(wait_on_page_bit_wq(struct page *page, int bit_nr, 
+	wait_queue_t *wait));
+static inline int wait_on_page_locked_wq(struct page *page, wait_queue_t *wait)
+{
+	if (PageLocked(page))
+		return wait_on_page_bit_wq(page, PG_locked, wait);
+	return 0;
+}
+
 /* 
  * Wait for a page to complete writeback
  */
diff -ur -X /home/kiran/dontdiff linux-2.5.68/mm/filemap.c linux-aio-2568/mm/filemap.c
--- linux-2.5.68/mm/filemap.c	Mon Apr 21 23:30:40 2003
+++ linux-aio-2568/mm/filemap.c	Tue Apr 22 00:28:55 2003
@@ -268,19 +268,32 @@
 	return &zone->wait_table[hash_ptr(page, zone->wait_table_bits)];
 }
 
-void wait_on_page_bit(struct page *page, int bit_nr)
+int wait_on_page_bit_wq(struct page *page, int bit_nr, wait_queue_t *wait)
 {
 	wait_queue_head_t *waitqueue = page_waitqueue(page);
-	DEFINE_WAIT(wait);
+	DEFINE_WAIT(local_wait);
 
+	if (!wait)
+		wait = &local_wait;
+		
 	do {
-		prepare_to_wait(waitqueue, &wait, TASK_UNINTERRUPTIBLE);
+		prepare_to_wait(waitqueue, wait, TASK_UNINTERRUPTIBLE);
 		if (test_bit(bit_nr, &page->flags)) {
 			sync_page(page);
+			if (!is_sync_wait(wait))
+				return -EIOCBRETRY;
 			io_schedule();
 		}
 	} while (test_bit(bit_nr, &page->flags));
-	finish_wait(waitqueue, &wait);
+	finish_wait(waitqueue, wait);
+
+	return 0;
+}
+EXPORT_SYMBOL(wait_on_page_bit_wq);
+
+void wait_on_page_bit(struct page *page, int bit_nr)
+{
+	wait_on_page_bit_wq(page, bit_nr, NULL);
 }
 EXPORT_SYMBOL(wait_on_page_bit);
 
@@ -336,19 +349,31 @@
  * chances are that on the second loop, the block layer's plug list is empty,
  * so sync_page() will then return in state TASK_UNINTERRUPTIBLE.
  */
-void __lock_page(struct page *page)
+int __lock_page_wq(struct page *page, wait_queue_t *wait)
 {
 	wait_queue_head_t *wqh = page_waitqueue(page);
-	DEFINE_WAIT(wait);
+	DEFINE_WAIT(local_wait);
 
+	if (!wait)
+		wait = &local_wait;
+		
 	while (TestSetPageLocked(page)) {
-		prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
+		prepare_to_wait(wqh, wait, TASK_UNINTERRUPTIBLE);
 		if (PageLocked(page)) {
 			sync_page(page);
+			if (!is_sync_wait(wait))
+				return -EIOCBRETRY;
 			io_schedule();
 		}
 	}
-	finish_wait(wqh, &wait);
+	finish_wait(wqh, wait);
+	return 0;
+}
+EXPORT_SYMBOL(__lock_page_wq);
+
+void __lock_page(struct page *page)
+{
+	__lock_page_wq(page, NULL);	
 }
 EXPORT_SYMBOL(__lock_page);
 
@@ -621,7 +655,13 @@
 			goto page_ok;
 
 		/* Get exclusive access to the page ... */
-		lock_page(page);
+		
+		if (lock_page_wq(page, current->io_wait)) {
+			pr_debug("queued lock page \n");
+			error = -EIOCBRETRY;
+			/* TBD: should we hold on to the cached page ? */
+			goto sync_error;
+		}
 
 		/* Did it get unhashed before we got the lock? */
 		if (!page->mapping) {
@@ -643,12 +683,19 @@
 		if (!error) {
 			if (PageUptodate(page))
 				goto page_ok;
-			wait_on_page_locked(page);
+			if (wait_on_page_locked_wq(page, current->io_wait)) {
+				pr_debug("queued wait_on_page \n");
+				error = -EIOCBRETRY;
+				/*TBD:should we hold on to the cached page ?*/
+				goto sync_error;
+			}
+			
 			if (PageUptodate(page))
 				goto page_ok;
 			error = -EIO;
 		}
 
+sync_error:
 		/* UHHUH! A synchronous read error occurred. Report it */
 		desc->error = error;
 		page_cache_release(page);
@@ -819,6 +866,10 @@
 	struct kiocb kiocb;
 	ssize_t ret;
 
+	if (current->io_wait != NULL) {
+		printk("current->io_wait != NULL\n");
+		dump_stack();
+	}
 	init_sync_kiocb(&kiocb, filp);
 	ret = __generic_file_aio_read(&kiocb, &local_iov, 1, ppos);
 	if (-EIOCBQUEUED == ret)
@@ -851,6 +902,7 @@
 {
 	read_descriptor_t desc;
 
+	BUG_ON(current->io_wait != NULL);
 	if (!count)
 		return 0;
 
