Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbWGLXDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbWGLXDU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 19:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWGLXDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 19:03:20 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:40860 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932460AbWGLXDT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 19:03:19 -0400
Date: Wed, 12 Jul 2006 18:02:29 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, hugh@veritas.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: please revert kthread from loop.c
Message-ID: <20060712230228.GA19656@sergelap.austin.ibm.com>
References: <Pine.LNX.4.64.0606261920440.1330@blonde.wat.veritas.com> <20060627054612.GA15657@sergelap.austin.ibm.com> <Pine.LNX.4.64.0606281933300.24170@blonde.wat.veritas.com> <20060711194932.GA27176@sergelap.austin.ibm.com> <20060711171752.4993903a.akpm@osdl.org> <20060712032647.GA24595@sergelap.austin.ibm.com> <20060711204637.bba6e966.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060711204637.bba6e966.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Morton (akpm@osdl.org):
> I'm not sure why it's all so tricky in there, really.  Loop is doing a
> pretty conventional stop, wakeup, stick-things-on-lists operation and we do
> that all over the kernel using pretty well-understood idioms.  But for some
> reason, loop is all difficult about it.  I wonder why.  hm.

Does this version, going back to using a completion - lo->lo_wait - seem
a touch simpler?

thanks,
-serge

From: "Serge E. Hallyn" <serue@us.ibm.com>
Subject: [PATCH] kthread: convert loop.c to kthread

Convert loop.c from the deprecated kernel_thread to kthread.

This version goes back to using a completion for waking the
loop_thread when there is work to do.  Ending the loop thread
is done by first setting the state, then waking the thread
using the completion, and finally calling kthread_stop().
The loop_thread is either already awake serving requests,
or is awoken by loop_clr_fd()s complete.  It does one more
loop to serve pending requests, after which it sees it's
state is no longer running, and starts a short busyloop
while waiting to be reaped.

Signed-off-by: Serge Hallyn <serue@us.ibm.com>

---

 drivers/block/loop.c |   73 +++++++++++++++++++-------------------------------
 include/linux/loop.h |    4 +--
 2 files changed, 30 insertions(+), 47 deletions(-)

5aa946838754cc8bd1582ca3f926cf51d7e21df8
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index ccaada1..8779194 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -72,6 +72,7 @@
 #include <linux/completion.h>
 #include <linux/highmem.h>
 #include <linux/gfp.h>
+#include <linux/kthread.h>
 
 #include <asm/uaccess.h>
 
@@ -524,13 +525,11 @@ static int loop_make_request(request_que
 		goto out;
 	lo->lo_pending++;
 	loop_add_bio(lo, old_bio);
+	complete(&lo->lo_wait);
 	spin_unlock_irq(&lo->lo_lock);
-	complete(&lo->lo_bh_done);
 	return 0;
 
 out:
-	if (lo->lo_pending == 0)
-		complete(&lo->lo_bh_done);
 	spin_unlock_irq(&lo->lo_lock);
 	bio_io_error(old_bio, old_bio->bi_size);
 	return 0;
@@ -576,8 +575,6 @@ static int loop_thread(void *data)
 	struct loop_device *lo = data;
 	struct bio *bio;
 
-	daemonize("loop%d", lo->lo_number);
-
 	/*
 	 * loop can be used in an encrypted device,
 	 * hence, it mustn't be stopped at all
@@ -587,47 +584,28 @@ static int loop_thread(void *data)
 
 	set_user_nice(current, -20);
 
-	lo->lo_state = Lo_bound;
-	lo->lo_pending = 1;
-
-	/*
-	 * complete it, we are running
-	 */
-	complete(&lo->lo_done);
-
 	for (;;) {
-		int pending;
-
-		if (wait_for_completion_interruptible(&lo->lo_bh_done))
-			continue;
-
 		spin_lock_irq(&lo->lo_lock);
+		while (lo->lo_pending) {
+			bio = loop_get_bio(lo);
+			lo->lo_pending--;
 
-		/*
-		 * could be completed because of tear-down, not pending work
-		 */
-		if (unlikely(!lo->lo_pending)) {
 			spin_unlock_irq(&lo->lo_lock);
-			break;
+			BUG_ON(!bio);
+			loop_handle_bio(lo, bio);
+			spin_lock_irq(&lo->lo_lock);
 		}
 
-		bio = loop_get_bio(lo);
-		lo->lo_pending--;
-		pending = lo->lo_pending;
+		if (lo->lo_state == Lo_rundown) {
+			spin_unlock_irq(&lo->lo_lock);
+			while (!kthread_should_stop());
+			break;
+		}
 		spin_unlock_irq(&lo->lo_lock);
 
-		BUG_ON(!bio);
-		loop_handle_bio(lo, bio);
-
-		/*
-		 * upped both for pending work and tear-down, lo_pending
-		 * will hit zero then
-		 */
-		if (unlikely(!pending))
-			break;
+		wait_for_completion_interruptible(&lo->lo_wait);
 	}
 
-	complete(&lo->lo_done);
 	return 0;
 }
 
@@ -846,10 +824,16 @@ static int loop_set_fd(struct loop_devic
 
 	set_blocksize(bdev, lo_blocksize);
 
-	error = kernel_thread(loop_thread, lo, CLONE_KERNEL);
-	if (error < 0)
+	lo->lo_thread = kthread_create(loop_thread, lo, "loop%d",
+						lo->lo_number);
+	if (IS_ERR(lo->lo_thread)) {
+		error = PTR_ERR(lo->lo_thread);
+		lo->lo_thread = NULL;
 		goto out_putf;
-	wait_for_completion(&lo->lo_done);
+	}
+	lo->lo_pending = 0;
+	lo->lo_state = Lo_bound;
+	wake_up_process(lo->lo_thread);
 	return 0;
 
  out_putf:
@@ -913,12 +897,10 @@ static int loop_clr_fd(struct loop_devic
 
 	spin_lock_irq(&lo->lo_lock);
 	lo->lo_state = Lo_rundown;
-	lo->lo_pending--;
-	if (!lo->lo_pending)
-		complete(&lo->lo_bh_done);
+	complete(&lo->lo_wait);
 	spin_unlock_irq(&lo->lo_lock);
 
-	wait_for_completion(&lo->lo_done);
+	kthread_stop(lo->lo_thread);
 
 	lo->lo_backing_file = NULL;
 
@@ -928,6 +910,7 @@ static int loop_clr_fd(struct loop_devic
 	lo->lo_device = NULL;
 	lo->lo_encryption = NULL;
 	lo->lo_offset = 0;
+	lo->lo_thread = NULL;
 	lo->lo_sizelimit = 0;
 	lo->lo_encrypt_key_size = 0;
 	lo->lo_flags = 0;
@@ -1293,8 +1276,8 @@ static int __init loop_init(void)
 		if (!lo->lo_queue)
 			goto out_mem4;
 		mutex_init(&lo->lo_ctl_mutex);
-		init_completion(&lo->lo_done);
-		init_completion(&lo->lo_bh_done);
+		init_completion(&lo->lo_wait);
+		lo->lo_thread = NULL;
 		lo->lo_number = i;
 		spin_lock_init(&lo->lo_lock);
 		disk->major = LOOP_MAJOR;
diff --git a/include/linux/loop.h b/include/linux/loop.h
index e76c761..c9a0a45 100644
--- a/include/linux/loop.h
+++ b/include/linux/loop.h
@@ -59,8 +59,8 @@ struct loop_device {
 	struct bio 		*lo_bio;
 	struct bio		*lo_biotail;
 	int			lo_state;
-	struct completion	lo_done;
-	struct completion	lo_bh_done;
+	struct completion	lo_wait;
+	struct task_struct	*lo_thread;
 	struct mutex		lo_ctl_mutex;
 	int			lo_pending;
 
-- 
1.1.6
