Return-Path: <linux-kernel-owner+w=401wt.eu-S964987AbWL1Igd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbWL1Igd (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 03:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbWL1Igd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 03:36:33 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:57753 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964981AbWL1Igc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 03:36:32 -0500
Date: Thu, 28 Dec 2006 14:10:55 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, akpm@osdl.org, drepper@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       jakub@redhat.com, mingo@elte.hu
Subject: [FSAIO][PATCH 5/8] Enable wait bit based filtered wakeups to work for AIO
Message-ID: <20061228084055.GE6971@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20061227153855.GA25898@in.ibm.com> <20061228082308.GA4476@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061228082308.GA4476@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Enable wait bit based filtered wakeups to work for AIO.
Replaces the wait queue entry in the kiocb with a wait bit
structure, to allow enough space for the wait bit key.
This adds an extra level of indirection in references to the 
wait queue entry in the iocb. Also, an extra check had to be
added in aio_wake_function to allow for other kinds of waiters 
which do not require wait bit, based on the assumption that
the key passed in would be NULL in such cases.

Signed-off-by: Suparna Bhattacharya <suparna@in.ibm.com>
Acked-by: Ingo Molnar <mingo@elte.hu>

---

 linux-2.6.20-rc1-root/fs/aio.c            |   21 ++++++++++++++-------
 linux-2.6.20-rc1-root/include/linux/aio.h |    7 ++++---
 linux-2.6.20-rc1-root/kernel/wait.c       |   17 ++++++++++++++---
 3 files changed, 32 insertions(+), 13 deletions(-)

diff -puN fs/aio.c~aio-wait-bit fs/aio.c
--- linux-2.6.20-rc1/fs/aio.c~aio-wait-bit	2006-12-21 08:45:57.000000000 +0530
+++ linux-2.6.20-rc1-root/fs/aio.c	2006-12-28 09:32:27.000000000 +0530
@@ -719,13 +719,13 @@ static ssize_t aio_run_iocb(struct kiocb
 	 * cause the iocb to be kicked for continuation (through
 	 * the aio_wake_function callback).
 	 */
-	BUG_ON(current->io_wait != NULL);
-	current->io_wait = &iocb->ki_wait;
+	BUG_ON(!is_sync_wait(current->io_wait));
+	current->io_wait = &iocb->ki_wait.wait;
 	ret = retry(iocb);
 	current->io_wait = NULL;
 
 	if (ret != -EIOCBRETRY && ret != -EIOCBQUEUED) {
-		BUG_ON(!list_empty(&iocb->ki_wait.task_list));
+		BUG_ON(!list_empty(&iocb->ki_wait.wait.task_list));
 		aio_complete(iocb, ret, 0);
 	}
 out:
@@ -883,7 +883,7 @@ static void try_queue_kicked_iocb(struct
 	 * than retry has happened before we could queue the iocb.  This also
 	 * means that the retry could have completed and freed our iocb, no
 	 * good. */
-	BUG_ON((!list_empty(&iocb->ki_wait.task_list)));
+	BUG_ON((!list_empty(&iocb->ki_wait.wait.task_list)));
 
 	spin_lock_irqsave(&ctx->ctx_lock, flags);
 	/* set this inside the lock so that we can't race with aio_run_iocb()
@@ -1519,7 +1519,13 @@ static ssize_t aio_setup_iocb(struct kio
 static int aio_wake_function(wait_queue_t *wait, unsigned mode,
 			     int sync, void *key)
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
@@ -1574,8 +1580,9 @@ int fastcall io_submit_one(struct kioctx
 	req->ki_buf = (char __user *)(unsigned long)iocb->aio_buf;
 	req->ki_left = req->ki_nbytes = iocb->aio_nbytes;
 	req->ki_opcode = iocb->aio_lio_opcode;
-	init_waitqueue_func_entry(&req->ki_wait, aio_wake_function);
-	INIT_LIST_HEAD(&req->ki_wait.task_list);
+	init_waitqueue_func_entry(&req->ki_wait.wait, aio_wake_function);
+	INIT_LIST_HEAD(&req->ki_wait.wait.task_list);
+ 	req->ki_run_list.next = req->ki_run_list.prev = NULL;
 
 	ret = aio_setup_iocb(req);
 
diff -puN include/linux/aio.h~aio-wait-bit include/linux/aio.h
--- linux-2.6.20-rc1/include/linux/aio.h~aio-wait-bit	2006-12-21 08:45:57.000000000 +0530
+++ linux-2.6.20-rc1-root/include/linux/aio.h	2006-12-28 09:32:27.000000000 +0530
@@ -102,7 +102,7 @@ struct kiocb {
 	} ki_obj;
 
 	__u64			ki_user_data;	/* user's data for completion */
-	wait_queue_t		ki_wait;
+	struct wait_bit_queue	ki_wait;
 	loff_t			ki_pos;
 
 	atomic_t		ki_bio_count;	/* num bio used for this iocb */
@@ -135,7 +135,7 @@ struct kiocb {
 		(x)->ki_dtor = NULL;			\
 		(x)->ki_obj.tsk = tsk;			\
 		(x)->ki_user_data = 0;                  \
-		init_wait((&(x)->ki_wait));             \
+		init_wait_bit_task((&(x)->ki_wait), current);\
 	} while (0)
 
 #define AIO_RING_MAGIC			0xa10a10a1
@@ -237,7 +237,8 @@ do {									\
 	}								\
 } while (0)
 
-#define io_wait_to_kiocb(wait) container_of(wait, struct kiocb, ki_wait)
+#define io_wait_to_kiocb(io_wait) container_of(container_of(io_wait,	\
+	struct wait_bit_queue, wait), struct kiocb, ki_wait)
 
 #include <linux/aio_abi.h>
 
diff -puN kernel/wait.c~aio-wait-bit kernel/wait.c
--- linux-2.6.20-rc1/kernel/wait.c~aio-wait-bit	2006-12-21 08:45:57.000000000 +0530
+++ linux-2.6.20-rc1-root/kernel/wait.c	2006-12-21 08:45:57.000000000 +0530
@@ -139,7 +139,8 @@ EXPORT_SYMBOL(autoremove_wake_function);
 
 int wake_bit_function(wait_queue_t *wait, unsigned mode, int sync, void *arg)
 {
-	if (!test_wait_bit_key(wait, arg))
+	/* Assumes that a non-NULL key implies wait bit filtering */
+	if (arg && !test_wait_bit_key(wait, arg))
 		return 0;
 	return autoremove_wake_function(wait, mode, sync, arg);
 }
@@ -161,7 +162,12 @@ __wait_on_bit(wait_queue_head_t *wq, str
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
@@ -190,7 +196,12 @@ __wait_on_bit_lock(wait_queue_head_t *wq
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
-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

