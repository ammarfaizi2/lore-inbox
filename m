Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270386AbUJTTZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270386AbUJTTZT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 15:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269168AbUJTTOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 15:14:35 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:50082
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S269080AbUJTTHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:07:52 -0400
Subject: [PATCH] Loopback: Use Completion instead semaphore
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Content-Type: text/plain
Organization: linutronix
Message-Id: <1098298791.20821.48.camel@thomas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 20:59:51 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use completion instead of the abused semaphore. Semaphores are slower
and trigger owner conflicts during semaphore debugging.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
---

 2.6.9-bk-041020-thomas/drivers/block/loop.c |   22
+++++++++++-----------
 2.6.9-bk-041020-thomas/include/linux/loop.h |    4 ++--
 2 files changed, 13 insertions(+), 13 deletions(-)

diff -puN drivers/block/loop.c~loop drivers/block/loop.c
--- 2.6.9-bk-041020/drivers/block/loop.c~loop	2004-10-20
15:56:15.000000000 +0200
+++ 2.6.9-bk-041020-thomas/drivers/block/loop.c	2004-10-20
15:56:15.000000000 +0200
@@ -378,7 +378,7 @@ static void loop_add_bio(struct loop_dev
 		lo->lo_bio = lo->lo_biotail = bio;
 	spin_unlock_irqrestore(&lo->lo_lock, flags);
 
-	up(&lo->lo_bh_mutex);
+	complete(&lo->lo_bh_done);
 }
 
 /*
@@ -427,7 +427,7 @@ static int loop_make_request(request_que
 	return 0;
 err:
 	if (atomic_dec_and_test(&lo->lo_pending))
-		up(&lo->lo_bh_mutex);
+		complete(&lo->lo_bh_done);
 out:
 	bio_io_error(old_bio, old_bio->bi_size);
 	return 0;
@@ -495,12 +495,12 @@ static int loop_thread(void *data)
 	/*
 	 * up sem, we are running
 	 */
-	up(&lo->lo_sem);
+	complete(&lo->lo_done);
 
 	for (;;) {
-		down_interruptible(&lo->lo_bh_mutex);
+		wait_for_completion_interruptible(&lo->lo_bh_done);
 		/*
-		 * could be upped because of tear-down, not because of
+		 * could be completed because of tear-down, not because of
 		 * pending work
 		 */
 		if (!atomic_read(&lo->lo_pending))
@@ -521,7 +521,7 @@ static int loop_thread(void *data)
 			break;
 	}
 
-	up(&lo->lo_sem);
+	complete(&lo->lo_done);
 	return 0;
 }
 
@@ -708,7 +708,7 @@ static int loop_set_fd(struct loop_devic
 	set_blocksize(bdev, lo_blocksize);
 
 	kernel_thread(loop_thread, lo, CLONE_KERNEL);
-	down(&lo->lo_sem);
+	wait_for_completion(&lo->lo_done);
 	return 0;
 
  out_putf:
@@ -773,10 +773,10 @@ static int loop_clr_fd(struct loop_devic
 	spin_lock_irq(&lo->lo_lock);
 	lo->lo_state = Lo_rundown;
 	if (atomic_dec_and_test(&lo->lo_pending))
-		up(&lo->lo_bh_mutex);
+		complete(&lo->lo_bh_done);
 	spin_unlock_irq(&lo->lo_lock);
 
-	down(&lo->lo_sem);
+	wait_for_completion(&lo->lo_done);
 
 	lo->lo_backing_file = NULL;
 
@@ -1153,8 +1153,8 @@ int __init loop_init(void)
 		if (!lo->lo_queue)
 			goto out_mem4;
 		init_MUTEX(&lo->lo_ctl_mutex);
-		init_MUTEX_LOCKED(&lo->lo_sem);
-		init_MUTEX_LOCKED(&lo->lo_bh_mutex);
+		init_completion(&lo->lo_done);
+		init_completion(&lo->lo_bh_done);
 		lo->lo_number = i;
 		spin_lock_init(&lo->lo_lock);
 		disk->major = LOOP_MAJOR;
diff -puN include/linux/loop.h~loop include/linux/loop.h
--- 2.6.9-bk-041020/include/linux/loop.h~loop	2004-10-20
15:56:15.000000000 +0200
+++ 2.6.9-bk-041020-thomas/include/linux/loop.h	2004-10-20
15:56:15.000000000 +0200
@@ -58,9 +58,9 @@ struct loop_device {
 	struct bio 		*lo_bio;
 	struct bio		*lo_biotail;
 	int			lo_state;
-	struct semaphore	lo_sem;
+	struct completion	lo_done;
+	struct completion	lo_bh_done;
 	struct semaphore	lo_ctl_mutex;
-	struct semaphore	lo_bh_mutex;
 	atomic_t		lo_pending;
 
 	request_queue_t		*lo_queue;
_


