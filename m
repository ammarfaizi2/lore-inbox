Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbVFTQ1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVFTQ1W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 12:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVFTQ1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 12:27:05 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:60090 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261362AbVFTQYI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 12:24:08 -0400
Date: Mon, 20 Jun 2005 22:03:22 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org
Cc: linux-kernel@vger.kernel.org, bcrl@kvack.org, wli@holomorphy.com,
       zab@zabbo.net, mason@suse.com
Subject: Re: [PATCH 5/6] AIO wait bit and AIO wake bit for filtered wakeups
Message-ID: <20050620163322.GE5380@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20050620120154.GA4810@in.ibm.com> <20050620160126.GA5271@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050620160126.GA5271@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 09:31:26PM +0530, Suparna Bhattacharya wrote:
> > (1) Updating AIO to use wait-bit based filtered wakeups (me/wli)
> > 	Status: Updated to 2.6.12-rc6, needs review
> 

Enable wait bit based filtered wakeups to work for AIO.
Replaces the wait queue entry in the kiocb with a wait bit
structure, to allow enough space for the wait bit key.
This adds an extra level of indirection in references to the 
wait queue entry in the iocb. Also, adds an extra check
in aio_wake_function to allow for other kinds of waiters 
which do not require wait bit, based on the assumption that
the key passed in would be NULL in such cases.

Signed-off-by: Suparna Bhattacharya <suparna@in.ibm.com>

 fs/aio.c             |   20 +++++++++++++-------
 include/linux/aio.h  |    4 ++--
 include/linux/wait.h |   18 ++++++++++++++++++
 kernel/wait.c        |   17 ++++++++++++++---
 4 files changed, 47 insertions(+), 12 deletions(-)

diff -puN fs/aio.c~aio-wait-bit fs/aio.c
--- linux-2.6.9-rc1-mm4/fs/aio.c~aio-wait-bit	2004-09-15 16:02:13.000000000 +0530
+++ linux-2.6.9-rc1-mm4-suparna/fs/aio.c	2004-09-15 16:41:22.000000000 +0530
@@ -725,13 +725,13 @@ static ssize_t aio_run_iocb(struct kiocb
 	 * the aio_wake_function callback).
 	 */
-	BUG_ON(current->io_wait != NULL);
-	current->io_wait = &iocb->ki_wait;
+	BUG_ON(!is_sync_wait(current->io_wait));
+	current->io_wait = &iocb->ki_wait.wait;
 	ret = retry(iocb);
 	current->io_wait = NULL;
 
 	if (-EIOCBRETRY != ret) {
  		if (-EIOCBQUEUED != ret) {
-			BUG_ON(!list_empty(&iocb->ki_wait.task_list));
+			BUG_ON(!list_empty(&iocb->ki_wait.wait.task_list));
 			aio_complete(iocb, ret, 0);
 			/* must not access the iocb after this */
 		}
@@ -740,7 +740,7 @@ static ssize_t aio_run_iocb(struct kiocb
 		 * Issue an additional retry to avoid waiting forever if
 		 * no waits were queued (e.g. in case of a short read).
 		 */
-		if (list_empty(&iocb->ki_wait.task_list))
+		if (list_empty(&iocb->ki_wait.wait.task_list))
 			kiocbSetKicked(iocb);
 	}
 out:
@@ -886,7 +886,7 @@ void queue_kicked_iocb(struct kiocb *ioc
 	unsigned long flags;
 	int run = 0;
 
-	WARN_ON((!list_empty(&iocb->ki_wait.task_list)));
+	WARN_ON((!list_empty(&iocb->ki_wait.wait.task_list)));
 
 	spin_lock_irqsave(&ctx->ctx_lock, flags);
 	run = __queue_kicked_iocb(iocb);
@@ -1472,7 +1472,13 @@ ssize_t aio_setup_iocb(struct kiocb *kio
  */
 int aio_wake_function(wait_queue_t *wait, unsigned mode, int sync, void *key)
 {
-	struct kiocb *iocb = container_of(wait, struct kiocb, ki_wait);
+	struct wait_bit_queue *wait_bit
+		= container_of(wait, struct wait_bit_queue, wait);
+	struct kiocb *iocb = container_of(wait_bit, struct kiocb, ki_wait);
+
+	/* Assumes that a non-NULL key implies wait bit filtering */
+	if (key && !test_wait_bit_key(wait, key))
+		return 0;
 
 	list_del_init(&wait->task_list);
 	kick_iocb(iocb);
@@ -1528,8 +1534,9 @@ int fastcall io_submit_one(struct kioctx
 	req->ki_buf = (char __user *)(unsigned long)iocb->aio_buf;
 	req->ki_left = req->ki_nbytes = iocb->aio_nbytes;
 	req->ki_opcode = iocb->aio_lio_opcode;
-	init_waitqueue_func_entry(&req->ki_wait, aio_wake_function);
-	INIT_LIST_HEAD(&req->ki_wait.task_list);
+	init_waitqueue_func_entry(&req->ki_wait.wait, aio_wake_function);
+	INIT_LIST_HEAD(&req->ki_wait.wait.task_list);
+ 	req->ki_run_list.next = req->ki_run_list.prev = NULL;
 	req->ki_retried = 0;
  
 	ret = aio_setup_iocb(req);
diff -puN kernel/wait.c~aio-wait-bit kernel/wait.c
--- linux-2.6.9-rc1-mm4/kernel/wait.c~aio-wait-bit	2004-09-15 16:02:13.000000000 +0530
+++ linux-2.6.9-rc1-mm4-suparna/kernel/wait.c	2004-09-20 14:59:24.000000000 +0530
@@ -132,7 +132,8 @@ EXPORT_SYMBOL(autoremove_wake_function);
 
 int wake_bit_function(wait_queue_t *wait, unsigned mode, int sync, void *arg)
 {
-	if (!test_wait_bit_key(wait, arg))
+	/* Assumes that a non-NULL key implies wait bit filtering */
+	if (arg && !test_wait_bit_key(wait, arg))
 		return 0;
 	return autoremove_wake_function(wait, mode, sync, key);
 }
@@ -152,7 +153,12 @@ __wait_on_bit(wait_queue_head_t *wq, str
 		if (test_bit(q->key.bit_nr, q->key.flags))
 			ret = (*action)(q->key.flags, &q->wait);
	} while (test_bit(q->key.bit_nr, q->key.flags) && !ret);
-	finish_wait(wq, &q->wait);
+	/*
+	 * AIO retries require the wait queue entry to remain queued
+	 * for async notification
+	 */
+	if (ret != -EIOCBRETRY)
+		finish_wait(wq, &q->wait);
 	return ret;
 }
 EXPORT_SYMBOL(__wait_on_bit);
@@ -181,7 +187,12 @@ __wait_on_bit_lock(wait_queue_head_t *wq
 				break;
 		}
 	} while (test_and_set_bit(q->key.bit_nr, q->key.flags));
-	finish_wait(wq, &q->wait);
+	/*
+	 * AIO retries require the wait queue entry to remain queued
+	 * for async notification
+	 */
+	if (ret != -EIOCBRETRY)
+		finish_wait(wq, &q->wait);
 	return ret;
 }
 EXPORT_SYMBOL(__wait_on_bit_lock);
diff -puN include/linux/aio.h~aio-wait-bit include/linux/aio.h
--- linux-2.6.9-rc1-mm4/include/linux/aio.h~aio-wait-bit	2004-09-15 16:05:40.000000000 +0530
+++ linux-2.6.9-rc1-mm4-suparna/include/linux/aio.h	2004-09-20 15:20:58.000000000 +0530
@@ -69,7 +69,7 @@ struct kiocb {
 	size_t			ki_nbytes; 	/* copy of iocb->aio_nbytes */
 	char 			__user *ki_buf;	/* remaining iocb->aio_buf */
 	size_t			ki_left; 	/* remaining bytes */
-	wait_queue_t		ki_wait;
+	struct wait_bit_queue	ki_wait;
 	long			ki_retried; 	/* just for testing */
 	long			ki_kicked; 	/* just for testing */
 	long			ki_queued; 	/* just for testing */
@@ -90,7 +90,7 @@ struct kiocb {
 		(x)->ki_dtor = NULL;			\
 		(x)->ki_obj.tsk = tsk;			\
 		(x)->ki_user_data = 0;                  \
-		init_wait((&(x)->ki_wait));             \
+		init_wait_bit_task((&(x)->ki_wait), current);\
 	} while (0)
 
 #define AIO_RING_MAGIC			0xa10a10a1

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

