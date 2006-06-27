Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbWF0FrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWF0FrJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 01:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWF0FrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 01:47:08 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:6335 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751119AbWF0FrG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 01:47:06 -0400
Date: Tue, 27 Jun 2006 00:46:12 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@osdl.org>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: please revert kthread from loop.c
Message-ID: <20060627054612.GA15657@sergelap.austin.ibm.com>
References: <Pine.LNX.4.64.0606261920440.1330@blonde.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606261920440.1330@blonde.wat.veritas.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hugh Dickins (hugh@veritas.com):
> Please revert c7b2eff059fcc2d1b7085ee3d84b79fd657a537b
> [PATCH] kthread: update loop.c to use kthread
> 
> It seems too little tested: "losetup -d /dev/loop0" fails with
> EINVAL because nothing sets lo_thread; but even when you patch
> loop_thread() to set lo->lo_thread = current, it can't survive
> more than a few dozen iterations of the loop below (with a tmpfs
> mounted on /tst): collapses with failed ioctl then BUG_ON(!bio).
> I think the original lo_done completion was more subtle and safe
> than the kthread conversion has allowed for.
> 
> j=0
> cp /dev/zero /tst
> while :
> do
> 	let j=j+1
> 	echo "Doing pass $j"
> 	losetup /dev/loop0 /tst/zero
> 	mkfs -t ext2 -b 1024 /dev/loop0 >/dev/null 2>&1
> 	mount -t ext2 /dev/loop0 /mnt
> 	umount /mnt
> 	losetup -d /dev/loop0
> done

Very sorry.


Subject: [PATCH] kthread: convert loop.c to use kthread

Convert loop.c to use kthread in place of the deprecated
kernel_thread.

Update: Keep the lo_done completion to indicate when the
	loop_thread is ready.  Otherwise a user gets the
	go-ahead early and may start an ioctl before
	loop_thread is in fact ready.

	Also fix some other bugs including misnaming the thread,
	found by Andrew Morton, and not setting lo->thread as
	pointed out by Hugh Dickins.

	This version has passed parallel runs of the following
	script (on different devices of course), i.e.

	sh looptorture.sh 3 [ in screen 1 ]
	sh looptorture.sh 5 [ in screen 2 ]

	looptorture.sh contains the following script based
	on the one sent by Hugh Dickins earlier today:

	j=0
	if [ $# > 0 ]; then
	   num=$1
	else
	   num=0
	fi
	echo "starting loop ($num)"
	if [ ! -d /mnt/$num ]; then
		mkdir /mnt/$num
	fi
	dd if=/dev/zero of=/tst/zero$num bs=1M count=100
	while [ $j -lt 100 ]; do
		let j=j+1
		echo "Doing pass $j"
		losetup /dev/loop$num /tst/zero$num
		mkfs -t ext2 -b 1024 /dev/loop$num >/dev/null 2>&1
		mount -t ext2 /dev/loop$num /mnt/$num
		umount /mnt/$num
		losetup -d /dev/loop$num
	done

Signed-off-by: Serge Hallyn <serue@us.ibm.com>

---

 drivers/block/loop.c |   16 ++++++++++------
 include/linux/loop.h |    1 +
 2 files changed, 11 insertions(+), 6 deletions(-)

71c305041760195a3c96aedae52f7d8ce3982d72
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 3c74ea7..b3d1710 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -74,6 +74,7 @@
 #include <linux/completion.h>
 #include <linux/highmem.h>
 #include <linux/gfp.h>
+#include <linux/kthread.h>
 
 #include <asm/uaccess.h>
 
@@ -578,8 +579,7 @@ static int loop_thread(void *data)
 	struct loop_device *lo = data;
 	struct bio *bio;
 
-	daemonize("loop%d", lo->lo_number);
-
+	lo->lo_thread = current;
 	/*
 	 * loop can be used in an encrypted device,
 	 * hence, it mustn't be stopped at all
@@ -629,7 +629,6 @@ static int loop_thread(void *data)
 			break;
 	}
 
-	complete(&lo->lo_done);
 	return 0;
 }
 
@@ -747,6 +746,7 @@ static int loop_set_fd(struct loop_devic
 	int		lo_flags = 0;
 	int		error;
 	loff_t		size;
+	struct task_struct *tsk;
 
 	/* This is safe, since we have a reference from open(). */
 	__module_get(THIS_MODULE);
@@ -839,9 +839,11 @@ static int loop_set_fd(struct loop_devic
 
 	set_blocksize(bdev, lo_blocksize);
 
-	error = kernel_thread(loop_thread, lo, CLONE_KERNEL);
-	if (error < 0)
+	tsk = kthread_run(loop_thread, lo, "loop%d", lo->lo_number);
+	if (IS_ERR(tsk)) {
+		error = PTR_ERR(tsk);
 		goto out_putf;
+	}
 	wait_for_completion(&lo->lo_done);
 	return 0;
 
@@ -911,7 +913,7 @@ static int loop_clr_fd(struct loop_devic
 		complete(&lo->lo_bh_done);
 	spin_unlock_irq(&lo->lo_lock);
 
-	wait_for_completion(&lo->lo_done);
+	kthread_stop(lo->lo_thread);
 
 	lo->lo_backing_file = NULL;
 
@@ -921,6 +923,7 @@ static int loop_clr_fd(struct loop_devic
 	lo->lo_device = NULL;
 	lo->lo_encryption = NULL;
 	lo->lo_offset = 0;
+	lo->lo_thread = NULL;
 	lo->lo_sizelimit = 0;
 	lo->lo_encrypt_key_size = 0;
 	lo->lo_flags = 0;
@@ -1288,6 +1291,7 @@ static int __init loop_init(void)
 		if (!lo->lo_queue)
 			goto out_mem4;
 		mutex_init(&lo->lo_ctl_mutex);
+		lo->lo_thread = NULL;
 		init_completion(&lo->lo_done);
 		init_completion(&lo->lo_bh_done);
 		lo->lo_number = i;
diff --git a/include/linux/loop.h b/include/linux/loop.h
index e76c761..4bd4cde 100644
--- a/include/linux/loop.h
+++ b/include/linux/loop.h
@@ -59,6 +59,7 @@ struct loop_device {
 	struct bio 		*lo_bio;
 	struct bio		*lo_biotail;
 	int			lo_state;
+	struct task_struct	*lo_thread;
 	struct completion	lo_done;
 	struct completion	lo_bh_done;
 	struct mutex		lo_ctl_mutex;
-- 
1.1.6
