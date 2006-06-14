Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbWFNMGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbWFNMGQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 08:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWFNMGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 08:06:16 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:32455 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751146AbWFNMGP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 08:06:15 -0400
Date: Wed, 14 Jun 2006 07:04:32 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH] kthread: update loop.c to use kthread
Message-ID: <20060614120432.GA15061@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update loop.c to use a kthread instead of a deprecated
kernel_thread for loop devices.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

---

 drivers/block/loop.c |   24 +++++++++++-------------
 include/linux/loop.h |    2 +-
 2 files changed, 12 insertions(+), 14 deletions(-)

63e791e7ed0191bada674e7e0eb4782e584c7e34
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 9c3b94e..1f34faf 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -74,6 +74,7 @@ #include <linux/buffer_head.h>		/* for i
 #include <linux/completion.h>
 #include <linux/highmem.h>
 #include <linux/gfp.h>
+#include <linux/kthread.h>
 
 #include <asm/uaccess.h>
 
@@ -578,8 +579,6 @@ static int loop_thread(void *data)
 	struct loop_device *lo = data;
 	struct bio *bio;
 
-	daemonize("loop%d", lo->lo_number);
-
 	/*
 	 * loop can be used in an encrypted device,
 	 * hence, it mustn't be stopped at all
@@ -592,11 +591,6 @@ static int loop_thread(void *data)
 	lo->lo_state = Lo_bound;
 	lo->lo_pending = 1;
 
-	/*
-	 * complete it, we are running
-	 */
-	complete(&lo->lo_done);
-
 	for (;;) {
 		int pending;
 
@@ -629,7 +623,6 @@ static int loop_thread(void *data)
 			break;
 	}
 
-	complete(&lo->lo_done);
 	return 0;
 }
 
@@ -746,6 +739,7 @@ static int loop_set_fd(struct loop_devic
 	unsigned lo_blocksize;
 	int		lo_flags = 0;
 	int		error;
+	struct task_struct *tsk;
 	loff_t		size;
 
 	/* This is safe, since we have a reference from open(). */
@@ -839,10 +833,11 @@ static int loop_set_fd(struct loop_devic
 
 	set_blocksize(bdev, lo_blocksize);
 
-	error = kernel_thread(loop_thread, lo, CLONE_KERNEL);
-	if (error < 0)
+	tsk = kthread_run(loop_thread, lo, "loop_%d", lo->lo_number);
+	if (IS_ERR(tsk)) {
+		error = PTR_ERR(tsk);
 		goto out_putf;
-	wait_for_completion(&lo->lo_done);
+	}
 	return 0;
 
  out_putf:
@@ -898,6 +893,9 @@ static int loop_clr_fd(struct loop_devic
 	if (lo->lo_state != Lo_bound)
 		return -ENXIO;
 
+	if (!lo->lo_thread)
+		return -EINVAL;
+
 	if (lo->lo_refcnt > 1)	/* we needed one fd for the ioctl */
 		return -EBUSY;
 
@@ -911,7 +909,7 @@ static int loop_clr_fd(struct loop_devic
 		complete(&lo->lo_bh_done);
 	spin_unlock_irq(&lo->lo_lock);
 
-	wait_for_completion(&lo->lo_done);
+	kthread_stop(lo->lo_thread);
 
 	lo->lo_backing_file = NULL;
 
@@ -924,6 +922,7 @@ static int loop_clr_fd(struct loop_devic
 	lo->lo_sizelimit = 0;
 	lo->lo_encrypt_key_size = 0;
 	lo->lo_flags = 0;
+	lo->lo_thread = NULL;
 	memset(lo->lo_encrypt_key, 0, LO_KEY_SIZE);
 	memset(lo->lo_crypt_name, 0, LO_NAME_SIZE);
 	memset(lo->lo_file_name, 0, LO_NAME_SIZE);
@@ -1288,7 +1287,6 @@ static int __init loop_init(void)
 		if (!lo->lo_queue)
 			goto out_mem4;
 		mutex_init(&lo->lo_ctl_mutex);
-		init_completion(&lo->lo_done);
 		init_completion(&lo->lo_bh_done);
 		lo->lo_number = i;
 		spin_lock_init(&lo->lo_lock);
diff --git a/include/linux/loop.h b/include/linux/loop.h
index e76c761..bf3d234 100644
--- a/include/linux/loop.h
+++ b/include/linux/loop.h
@@ -59,7 +59,7 @@ struct loop_device {
 	struct bio 		*lo_bio;
 	struct bio		*lo_biotail;
 	int			lo_state;
-	struct completion	lo_done;
+	struct task_struct	*lo_thread;
 	struct completion	lo_bh_done;
 	struct mutex		lo_ctl_mutex;
 	int			lo_pending;
-- 
1.3.3

