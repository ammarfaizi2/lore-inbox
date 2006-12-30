Return-Path: <linux-kernel-owner+w=401wt.eu-S1030205AbWL3Cbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbWL3Cbo (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 21:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbWL3Cbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 21:31:43 -0500
Received: from mga03.intel.com ([143.182.124.21]:27159 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030205AbWL3Cbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 21:31:43 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,220,1165219200"; 
   d="scan'208"; a="163608391:sNHT20624401"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>, <zach.brown@oracle.com>
Cc: <linux-aio@kvack.org>, <linux-kernel@vger.kernel.org>,
       "'Benjamin LaHaise'" <bcrl@kvack.org>, <suparna@in.ibm.com>
Subject: [patch] aio: add per task aio wait event condition
Date: Fri, 29 Dec 2006 18:31:42 -0800
Message-ID: <000201c72bba$a44a1b60$d634030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccruqQQI2TXAm/jQl6nLg5d9LwVLQ==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The AIO wake-up notification from aio_complete is really inefficient
in current AIO implementation in the presence of process waiting in
io_getevents().

For example, if app calls io_getevents with min_nr > 1, and aio event
queue doesn't have enough completed aio event, the process will block
in read_events().  However, aio_complete() will wake up the waiting
process for *each* complete I/O even though number of events that an
app is waiting for is much larger than 1.  This makes excessive and
unnecessary context switch because the waiting process will just reap
one single event and goes back to sleep again.  It is much more efficient
to wake up the waiting process when there are enough events for it to
reap.

This patch adds a wait condition to the wait queue and only wake-up
process when that condition meets.  And this condition is added on a
per task base for handling multi-threaded app that shares single ioctx.

To show the effect of this patch, here is an vmstat output before and
after the patch. The app does random O_DIRECT AIO on 60 disks. Context
switch is reduced from 13 thousand+ down to just 40+, an significant
improvement.

Before:
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0      0 3972608   7056  31312    0    0 14000     0 7840 13715  0  2 98  0
 0  0      0 3972608   7056  31312    0    0 14300     0 7793 13641  0  2 98  0
 0  0      0 3972608   7056  31312    0    0 14100     0 7885 13747  0  2 98  0

After:
 0  0      0 3972608   7056  31312    0    0 14000     0 7840    49  0  2 98  0
 0  0      0 3972608   7056  31312    0    0 13800     0 7793    53  0  2 98  0
 0  0      0 3972608   7056  31312    0    0 13800     0 7885    42  0  2 98  0


Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>


--- ./fs/aio.c.orig	2006-12-24 16:41:39.000000000 -0800
+++ ./fs/aio.c	2006-12-24 16:52:15.000000000 -0800
@@ -193,6 +193,17 @@ static int aio_setup_ring(struct kioctx 
 	kunmap_atomic((void *)((unsigned long)__event & PAGE_MASK), km); \
 } while(0)
 
+struct aio_wait_queue {
+	int		nr_wait;	/* wake-up condition */
+	wait_queue_t	wait;
+};
+
+static inline void aio_init_wait(struct aio_wait_queue *wait)
+{
+	wait->nr_wait = 0;
+	init_wait(&wait->wait);
+}
+
 /* ioctx_alloc
  *	Allocates and initializes an ioctx.  Returns an ERR_PTR if it failed.
  */
@@ -296,13 +307,14 @@ static void aio_cancel_all(struct kioctx
 static void wait_for_all_aios(struct kioctx *ctx)
 {
 	struct task_struct *tsk = current;
-	DECLARE_WAITQUEUE(wait, tsk);
+	struct aio_wait_queue wait;
 
 	spin_lock_irq(&ctx->ctx_lock);
 	if (!ctx->reqs_active)
 		goto out;
 
-	add_wait_queue(&ctx->wait, &wait);
+	aio_init_wait(&wait);
+	add_wait_queue(&ctx->wait, &wait.wait);
 	set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 	while (ctx->reqs_active) {
 		spin_unlock_irq(&ctx->ctx_lock);
@@ -311,7 +323,7 @@ static void wait_for_all_aios(struct kio
 		spin_lock_irq(&ctx->ctx_lock);
 	}
 	__set_task_state(tsk, TASK_RUNNING);
-	remove_wait_queue(&ctx->wait, &wait);
+	remove_wait_queue(&ctx->wait, &wait.wait);
 
 out:
 	spin_unlock_irq(&ctx->ctx_lock);
@@ -932,6 +944,7 @@ int fastcall aio_complete(struct kiocb *
 	unsigned long	flags;
 	unsigned long	tail;
 	int		ret;
+	int		nr_evt = 0;
 
 	/*
 	 * Special case handling for sync iocbs:
@@ -992,6 +1005,9 @@ int fastcall aio_complete(struct kiocb *
 	info->tail = tail;
 	ring->tail = tail;
 
+	nr_evt = ring->tail - ring->head;
+	if (nr_evt < 0)
+		nr_evt += info->nr;
 	put_aio_ring_event(event, KM_IRQ0);
 	kunmap_atomic(ring, KM_IRQ1);
 
@@ -1000,8 +1016,13 @@ put_rq:
 	/* everything turned out well, dispose of the aiocb. */
 	ret = __aio_put_req(ctx, iocb);
 
-	if (waitqueue_active(&ctx->wait))
-		wake_up(&ctx->wait);
+	if (waitqueue_active(&ctx->wait)) {
+		struct aio_wait_queue *wait;
+		wait = container_of(ctx->wait.task_list.next,
+				    struct aio_wait_queue, wait.task_list);
+		if (nr_evt >= wait->nr_wait)
+			wake_up(&ctx->wait);
+	}
 
 	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
 	return ret;
@@ -1094,7 +1115,7 @@ static int read_events(struct kioctx *ct
 {
 	long			start_jiffies = jiffies;
 	struct task_struct	*tsk = current;
-	DECLARE_WAITQUEUE(wait, tsk);
+	struct aio_wait_queue	wait;
 	int			ret;
 	int			i = 0;
 	struct io_event		ent;
@@ -1152,10 +1173,11 @@ retry:
 		set_timeout(start_jiffies, &to, &ts);
 	}
 
+	aio_init_wait(&wait);
 	while (likely(i < nr)) {
-		add_wait_queue_exclusive(&ctx->wait, &wait);
 		do {
-			set_task_state(tsk, TASK_INTERRUPTIBLE);
+			prepare_to_wait_exclusive(&ctx->wait, &wait.wait,
+						  TASK_INTERRUPTIBLE);
 			ret = aio_read_evt(ctx, &ent);
 			if (ret)
 				break;
@@ -1164,6 +1186,7 @@ retry:
 			ret = 0;
 			if (to.timed_out)	/* Only check after read evt */
 				break;
+			wait.nr_wait = min_nr - i;
 			schedule();
 			if (signal_pending(tsk)) {
 				ret = -EINTR;
@@ -1171,9 +1194,7 @@ retry:
 			}
 			/*ret = aio_read_evt(ctx, &ent);*/
 		} while (1) ;
-
-		set_task_state(tsk, TASK_RUNNING);
-		remove_wait_queue(&ctx->wait, &wait);
+		finish_wait(&ctx->wait, &wait.wait);
 
 		if (unlikely(ret <= 0))
 			break;

