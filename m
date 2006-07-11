Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWGKTuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWGKTuU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 15:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbWGKTuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 15:50:20 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:681 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932106AbWGKTuS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 15:50:18 -0400
Date: Tue, 11 Jul 2006 14:49:32 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: please revert kthread from loop.c
Message-ID: <20060711194932.GA27176@sergelap.austin.ibm.com>
References: <Pine.LNX.4.64.0606261920440.1330@blonde.wat.veritas.com> <20060627054612.GA15657@sergelap.austin.ibm.com> <Pine.LNX.4.64.0606281933300.24170@blonde.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606281933300.24170@blonde.wat.veritas.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But not good for me.  Gets further e.g. 170 iterations,
> but then hangs while kthread_stop waits for completion.

After getting much more familiar with the code, here is a more invasive,
but pretty heavily tested patch.

> I haven't investigated further.  Is there really any reason
> to be messing with what has worked well for so long here?

If the EXPORT_SYMBOL(kernel_thread) is going to be removed, then
this code will have to be updated.  Otherwise, no, the code as is
doesn't use pids to reference tasks, so the original code would be
fine with me.

thanks,
-serge

From: Serge Hallyn <serue@us.ibm.com>
Subject: [PATCH] kthread: convert loop.c to kthread

Convert loop.c from the deprecated kernel_thread to kthread.
This patch also simplifies the code a bit.  It has passed
vigerous testing.  The following script, looptorture.sh,
which mounts and unmounts loopback device 1000 times,
completes in three terminals simultaneously on different
loop devices.  For example, started up screen, created
three screens, and typed each of the following lines into
a separate screen:
	sh loopback.sh 2
	sh loopback.sh 3
	sh loopback.sh 4

loopback.sh:
	j=0
	if [ $# > 0 ]; then
	   num=$1
	else
	   num="0"
	fi
	echo "starting loop ($num)"
	if [ ! -d /mnt/$num ]; then
		mkdir /mnt/$num
	fi
	dd if=/dev/zero of=/tst/zero$num bs=1M count=100
	while [ $j -lt 1000 ]; do
		let j=j+1
		echo "Doing pass $j"
		losetup /dev/loop$num /tst/zero$num
		mkfs -t ext2 -b 1024 /dev/loop$num >/dev/null 2>&1
		mount -t ext2 /dev/loop$num /mnt/$num
		echo hello > /mnt/$num/hw
		umount /mnt/$num
		losetup -d /dev/loop$num
	done

A partial kernel build on a loopback partition also worked fine.
I have not tested encrypted devices, or suspend to loopback device.

Changes since last attempt:
	Eliminated lo->lo_done and lo->lo_bh_done completions.
	The former is not needed because we can wake up the thread
	when we're ready.  The latter was used for waking the
	loop_thread up when there was something to do or it was
	time to quit, and we no longer need this since we simply
	wake the thread directly when there's data.

	The lo->pending count used to be set at one plus actual
	pending actions, and was reduced to 0 only when it was time
	to quit.  We now use kthread_should_stop() to find out whether
	we're done, though we do not actually stop until there are no
	pending actions.

Signed-off-by: Serge Hallyn <serue@us.ibm.com>

---

 drivers/block/loop.c |   71 ++++++++++++++++++--------------------------------
 include/linux/loop.h |    3 +-
 2 files changed, 27 insertions(+), 47 deletions(-)

b56590212f3050dbb6c630eeea3a44794c9c7439
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index ccaada1..bdad531 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -72,6 +72,7 @@
 #include <linux/completion.h>
 #include <linux/highmem.h>
 #include <linux/gfp.h>
+#include <linux/kthread.h>
 
 #include <asm/uaccess.h>
 
@@ -525,12 +526,10 @@ static int loop_make_request(request_que
 	lo->lo_pending++;
 	loop_add_bio(lo, old_bio);
 	spin_unlock_irq(&lo->lo_lock);
-	complete(&lo->lo_bh_done);
+	wake_up_process(lo->lo_thread);
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
+		if (kthread_should_stop()) {
+			spin_unlock_irq(&lo->lo_lock);
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
+		__set_current_state(TASK_INTERRUPTIBLE);
+		schedule();
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
@@ -913,12 +897,9 @@ static int loop_clr_fd(struct loop_devic
 
 	spin_lock_irq(&lo->lo_lock);
 	lo->lo_state = Lo_rundown;
-	lo->lo_pending--;
-	if (!lo->lo_pending)
-		complete(&lo->lo_bh_done);
 	spin_unlock_irq(&lo->lo_lock);
 
-	wait_for_completion(&lo->lo_done);
+	kthread_stop(lo->lo_thread);
 
 	lo->lo_backing_file = NULL;
 
@@ -928,6 +909,7 @@ static int loop_clr_fd(struct loop_devic
 	lo->lo_device = NULL;
 	lo->lo_encryption = NULL;
 	lo->lo_offset = 0;
+	lo->lo_thread = NULL;
 	lo->lo_sizelimit = 0;
 	lo->lo_encrypt_key_size = 0;
 	lo->lo_flags = 0;
@@ -1293,8 +1275,7 @@ static int __init loop_init(void)
 		if (!lo->lo_queue)
 			goto out_mem4;
 		mutex_init(&lo->lo_ctl_mutex);
-		init_completion(&lo->lo_done);
-		init_completion(&lo->lo_bh_done);
+		lo->lo_thread = NULL;
 		lo->lo_number = i;
 		spin_lock_init(&lo->lo_lock);
 		disk->major = LOOP_MAJOR;
diff --git a/include/linux/loop.h b/include/linux/loop.h
index e76c761..51dee29 100644
--- a/include/linux/loop.h
+++ b/include/linux/loop.h
@@ -59,8 +59,7 @@ struct loop_device {
 	struct bio 		*lo_bio;
 	struct bio		*lo_biotail;
 	int			lo_state;
-	struct completion	lo_done;
-	struct completion	lo_bh_done;
+	struct task_struct	*lo_thread;
 	struct mutex		lo_ctl_mutex;
 	int			lo_pending;
 
-- 
1.1.6
