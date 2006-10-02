Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965530AbWJBXV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965530AbWJBXV4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 19:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965534AbWJBXVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 19:21:46 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:29399 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S965530AbWJBXVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 19:21:40 -0400
From: Zach Brown <zach.brown@oracle.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org
Message-Id: <20061002232140.18827.64960.sendpatchset@tetsuo.zabbo.net>
In-Reply-To: <20061002232119.18827.96966.sendpatchset@tetsuo.zabbo.net>
References: <20061002232119.18827.96966.sendpatchset@tetsuo.zabbo.net>
Subject: [PATCH take2 4/5] dio: remove duplicate bio wait code
Date: Mon,  2 Oct 2006 16:21:40 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dio: remove duplicate bio wait code

Now that we have a single refcount and waiting path we can reuse it in the
async 'should_wait' path.  It continues to rely on the fragile link between the
conditional in dio_complete_aio() which decides to complete the AIO and the
conditional in direct_io_worker() which decides to wait and free.

By waiting before dropping the reference we stop dio_bio_end_aio() from calling
dio_complete_aio() which used to wake up the waiter after seeing the reference
count drop to 0.  We hoist this wake up into dio_bio_end_aio() which now
notices when it's left a single remaining reference that is held by the waiter.

Signed-off-by: Zach Brown <zach.brown@oracle.com>
---

 fs/direct-io.c |   41 ++++++++++++-----------------------------
 1 file changed, 12 insertions(+), 29 deletions(-)

Index: 2.6.18-rc6-dio-cleanup/fs/direct-io.c
===================================================================
--- 2.6.18-rc6-dio-cleanup.orig/fs/direct-io.c
+++ 2.6.18-rc6-dio-cleanup/fs/direct-io.c
@@ -256,7 +256,6 @@ static int dio_complete(struct dio *dio,
  */
 static void dio_complete_aio(struct dio *dio)
 {
-	unsigned long flags;
 	int ret;
 
 	ret = dio_complete(dio, dio->iocb->ki_pos, 0);
@@ -266,14 +265,6 @@ static void dio_complete_aio(struct dio 
 		((dio->rw == READ) && dio->result)) {
 		aio_complete(dio->iocb, ret, 0);
 		kfree(dio);
-	} else {
-		/*
-		 * Falling back to buffered
-		 */
-		spin_lock_irqsave(&dio->bio_lock, flags);
-		if (dio->waiter)
-			wake_up_process(dio->waiter);
-		spin_unlock_irqrestore(&dio->bio_lock, flags);
 	}
 }
 
@@ -284,6 +275,8 @@ static int dio_bio_complete(struct dio *
 static int dio_bio_end_aio(struct bio *bio, unsigned int bytes_done, int error)
 {
 	struct dio *dio = bio->bi_private;
+	int waiter_holds_ref = 0;
+	int remaining;
 
 	if (bio->bi_size)
 		return 1;
@@ -291,7 +284,12 @@ static int dio_bio_end_aio(struct bio *b
 	/* cleanup the bio */
 	dio_bio_complete(dio, bio);
 
-	if (atomic_dec_and_test(&dio->refcount))
+	waiter_holds_ref = !!dio->waiter;
+	remaining = atomic_sub_return(1, (&dio->refcount));
+	if (remaining == 1 && waiter_holds_ref)
+		wake_up_process(dio->waiter);
+
+	if (remaining == 0)
 		dio_complete_aio(dio);
 
 	return 0;
@@ -1089,30 +1087,15 @@ direct_io_worker(int rw, struct kiocb *i
 		if (ret == 0)
 			ret = dio->result;
 
+		if (should_wait)
+			dio_await_completion(dio);
+
 		/* this can free the dio */
 		if (atomic_dec_and_test(&dio->refcount))
 			dio_complete_aio(dio);
 
-		if (should_wait) {
-			unsigned long flags;
-			/*
-			 * Wait for already issued I/O to drain out and
-			 * release its references to user-space pages
-			 * before returning to fallback on buffered I/O
-			 */
-
-			spin_lock_irqsave(&dio->bio_lock, flags);
-			set_current_state(TASK_UNINTERRUPTIBLE);
-			while (atomic_read(&dio->refcount)) {
-				spin_unlock_irqrestore(&dio->bio_lock, flags);
-				io_schedule();
-				spin_lock_irqsave(&dio->bio_lock, flags);
-				set_current_state(TASK_UNINTERRUPTIBLE);
-			}
-			spin_unlock_irqrestore(&dio->bio_lock, flags);
-			set_current_state(TASK_RUNNING);
+		if (should_wait)
 			kfree(dio);
-		}
 	} else {
 		dio_await_completion(dio);
 
