Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261529AbUKCJQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbUKCJQa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 04:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbUKCJPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 04:15:15 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:59308 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261529AbUKCJNI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 04:13:08 -0500
Date: Wed, 3 Nov 2004 14:52:01 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       wli@holomorphy.com
Subject: Re: [PATCH 5/6] AIO wake bit and AIO wait bit
Message-ID: <20041103092201.GE5737@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20041103091036.GA4041@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041103091036.GA4041@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 02:40:36PM +0530, Suparna Bhattacharya wrote:
> 
> The series of patches that follow integrate AIO with 
> William Lee Irwin's wait bit changes, to support asynchronous
> page waits.
> 
> [1] modify-wait-bit-action-args.patch
> 	Add a wait queue arg to the wait_bit action() routine
> 
> [2] lock_page_slow.patch
> 	Rename __lock_page to lock_page_slow
> 
> [3] init-wait-bit-key.patch
> 	Interfaces to init and to test wait bit key
> 
> [4] tsk-default-io-wait.patch
> 	Add default io wait bit field in task struct
> 
> [5] aio-wait-bit.patch
> 	AIO wake bit and AIO wait bit
> 

Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

----------------------------------------------------------

Enable wait bit based filtered wakeups to work for AIO.
Replaces the wait queue entry in the kiocb with a wait bit
structure, to allow enough space for the wait bit key.
This adds an extra level of indirection in references to the 
wait queue entry in the iocb. Also, an extra check had to be
added in aio_wake_function to allow for other kinds of waiters 
which do not require wait bit, based on the assumption that
the key passed in would be NULL in such cases.

Thanks to Chinmay for help with testing.

Signed-off-by: Suparna Bhattacharya <suparna@in.ibm.com>

diff -puN fs/aio.c~aio-wait-bit fs/aio.c


 linux-2.6.10-rc1-suparna/fs/aio.c            |   22 ++++++++++++++--------
 linux-2.6.10-rc1-suparna/include/linux/aio.h |    4 ++--
 linux-2.6.10-rc1-suparna/kernel/wait.c       |   17 ++++++++++++++---
 3 files changed, 30 insertions(+), 13 deletions(-)

diff -puN fs/aio.c~aio-wait-bit fs/aio.c
--- linux-2.6.10-rc1/fs/aio.c~aio-wait-bit	2004-11-03 14:35:17.000000000 +0530
+++ linux-2.6.10-rc1-suparna/fs/aio.c	2004-11-03 14:35:17.000000000 +0530
@@ -725,14 +725,14 @@ static ssize_t aio_run_iocb(struct kiocb
 	 * cause the iocb to be kicked for continuation (through
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
@@ -741,7 +741,7 @@ static ssize_t aio_run_iocb(struct kiocb
 		 * Issue an additional retry to avoid waiting forever if
 		 * no waits were queued (e.g. in case of a short read).
 		 */
-		if (list_empty(&iocb->ki_wait.task_list))
+		if (list_empty(&iocb->ki_wait.wait.task_list))
 			kiocbSetKicked(iocb);
 	}
 out:
@@ -887,7 +887,7 @@ void queue_kicked_iocb(struct kiocb *ioc
 	unsigned long flags;
 	int run = 0;
 
-	WARN_ON((!list_empty(&iocb->ki_wait.task_list)));
+	WARN_ON((!list_empty(&iocb->ki_wait.wait.task_list)));
 
 	spin_lock_irqsave(&ctx->ctx_lock, flags);
 	run = __queue_kicked_iocb(iocb);
@@ -1473,7 +1473,13 @@ ssize_t aio_setup_iocb(struct kiocb *kio
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
@@ -1529,8 +1535,8 @@ int fastcall io_submit_one(struct kioctx
 	req->ki_buf = (char __user *)(unsigned long)iocb->aio_buf;
 	req->ki_left = req->ki_nbytes = iocb->aio_nbytes;
 	req->ki_opcode = iocb->aio_lio_opcode;
-	init_waitqueue_func_entry(&req->ki_wait, aio_wake_function);
-	INIT_LIST_HEAD(&req->ki_wait.task_list);
+	init_waitqueue_func_entry(&req->ki_wait.wait, aio_wake_function);
+	INIT_LIST_HEAD(&req->ki_wait.wait.task_list);
 	req->ki_run_list.next = req->ki_run_list.prev = NULL;
 	req->ki_retry = NULL;
 	req->ki_retried = 0;
diff -puN include/linux/aio.h~aio-wait-bit include/linux/aio.h
--- linux-2.6.10-rc1/include/linux/aio.h~aio-wait-bit	2004-11-03 14:35:17.000000000 +0530
+++ linux-2.6.10-rc1-suparna/include/linux/aio.h	2004-11-03 14:35:17.000000000 +0530
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
diff -puN kernel/wait.c~aio-wait-bit kernel/wait.c
--- linux-2.6.10-rc1/kernel/wait.c~aio-wait-bit	2004-11-03 14:35:17.000000000 +0530
+++ linux-2.6.10-rc1-suparna/kernel/wait.c	2004-11-03 14:35:17.000000000 +0530
@@ -132,7 +132,8 @@ EXPORT_SYMBOL(autoremove_wake_function);
 
 int wake_bit_function(wait_queue_t *wait, unsigned mode, int sync, void *arg)
 {
-	if (!test_wait_bit_key(wait, arg))
+	/* Assumes that a non-NULL key implies wait bit filtering */
+	if (arg && !test_wait_bit_key(wait, arg))
 		return 0;
 	return autoremove_wake_function(wait, mode, sync, arg);
 }
@@ -154,7 +155,12 @@ __wait_on_bit(wait_queue_head_t *wq, str
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
@@ -183,7 +189,12 @@ __wait_on_bit_lock(wait_queue_head_t *wq
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

_
