Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964882AbWACXJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbWACXJk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbWACXJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:09:39 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:51637 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964882AbWACXI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:08:57 -0500
Date: Wed, 4 Jan 2006 00:08:49 +0100
From: Ingo Molnar <mingo@elte.hu>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [patch 20/20] mutex subsystem, semaphore to completion: drivers/block/loop.c
Message-ID: <20060103230849.GU13511@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


convert the block loop device from semaphores to completions.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 drivers/block/loop.c |   27 ++++++++++++---------------
 include/linux/loop.h |    4 ++--
 2 files changed, 14 insertions(+), 17 deletions(-)

Index: linux/drivers/block/loop.c
===================================================================
--- linux.orig/drivers/block/loop.c
+++ linux/drivers/block/loop.c
@@ -514,12 +514,12 @@ static int loop_make_request(request_que
 	lo->lo_pending++;
 	loop_add_bio(lo, old_bio);
 	spin_unlock_irq(&lo->lo_lock);
-	up(&lo->lo_bh_mutex);
+	complete(&lo->lo_bh_done);
 	return 0;
 
 out:
 	if (lo->lo_pending == 0)
-		up(&lo->lo_bh_mutex);
+		complete(&lo->lo_bh_done);
 	spin_unlock_irq(&lo->lo_lock);
 	bio_io_error(old_bio, old_bio->bi_size);
 	return 0;
@@ -580,23 +580,20 @@ static int loop_thread(void *data)
 	lo->lo_pending = 1;
 
 	/*
-	 * up sem, we are running
+	 * complete it, we are running
 	 */
-	up(&lo->lo_sem);
+	complete(&lo->lo_done);
 
 	for (;;) {
 		int pending;
 
-		/*
-		 * interruptible just to not contribute to load avg
-		 */
-		if (down_interruptible(&lo->lo_bh_mutex))
+		if (wait_for_completion_interruptible(&lo->lo_bh_done))
 			continue;
 
 		spin_lock_irq(&lo->lo_lock);
 
 		/*
-		 * could be upped because of tear-down, not pending work
+		 * could be completed because of tear-down, not pending work
 		 */
 		if (unlikely(!lo->lo_pending)) {
 			spin_unlock_irq(&lo->lo_lock);
@@ -619,7 +616,7 @@ static int loop_thread(void *data)
 			break;
 	}
 
-	up(&lo->lo_sem);
+	complete(&lo->lo_done);
 	return 0;
 }
 
@@ -830,7 +827,7 @@ static int loop_set_fd(struct loop_devic
 	set_blocksize(bdev, lo_blocksize);
 
 	kernel_thread(loop_thread, lo, CLONE_KERNEL);
-	down(&lo->lo_sem);
+	wait_for_completion(&lo->lo_done);
 	return 0;
 
  out_putf:
@@ -896,10 +893,10 @@ static int loop_clr_fd(struct loop_devic
 	lo->lo_state = Lo_rundown;
 	lo->lo_pending--;
 	if (!lo->lo_pending)
-		up(&lo->lo_bh_mutex);
+		complete(&lo->lo_bh_done);
 	spin_unlock_irq(&lo->lo_lock);
 
-	down(&lo->lo_sem);
+	wait_for_completion(&lo->lo_done);
 
 	lo->lo_backing_file = NULL;
 
@@ -1276,8 +1273,8 @@ static int __init loop_init(void)
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
Index: linux/include/linux/loop.h
===================================================================
--- linux.orig/include/linux/loop.h
+++ linux/include/linux/loop.h
@@ -58,9 +58,9 @@ struct loop_device {
 	struct bio 		*lo_bio;
 	struct bio		*lo_biotail;
 	int			lo_state;
-	struct semaphore	lo_sem;
+	struct completion	lo_done;
+	struct completion	lo_bh_done;
 	struct semaphore	lo_ctl_mutex;
-	struct semaphore	lo_bh_mutex;
 	int			lo_pending;
 
 	request_queue_t		*lo_queue;
