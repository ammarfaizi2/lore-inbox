Return-Path: <linux-kernel-owner+w=401wt.eu-S932784AbWL0Lyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932784AbWL0Lyb (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 06:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932780AbWL0Lya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 06:54:30 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:36044 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932707AbWL0Ly1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 06:54:27 -0500
Date: Wed, 27 Dec 2006 12:52:07 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>
Subject: [patch] block: remove BKL dependency from drivers/block/loop.c
Message-ID: <20061227115207.GA20721@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch] block: remove BKL dependency from drivers/block/loop.c
From: Ingo Molnar <mingo@elte.hu>

the block loopback device is protected by lo->lo_ctl_mutex and it does 
not need to hold the BKL anywhere. Convert its ioctl to unlocked_ioctl 
and remove the BKL acquire/release from its compat_ioctl.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 drivers/block/loop.c |   20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

Index: linux/drivers/block/loop.c
===================================================================
--- linux.orig/drivers/block/loop.c
+++ linux/drivers/block/loop.c
@@ -1130,9 +1130,9 @@ loop_get_status64(struct loop_device *lo
 	return err;
 }
 
-static int lo_ioctl(struct inode * inode, struct file * file,
-	unsigned int cmd, unsigned long arg)
+static long lo_ioctl(struct file * file, unsigned int cmd, unsigned long arg)
 {
+	struct inode *inode = file->f_path.dentry->d_inode;
 	struct loop_device *lo = inode->i_bdev->bd_disk->private_data;
 	int err;
 
@@ -1291,8 +1291,7 @@ static long lo_compat_ioctl(struct file 
 	struct loop_device *lo = inode->i_bdev->bd_disk->private_data;
 	int err;
 
-	lock_kernel();
-	switch(cmd) {
+	switch (cmd) {
 	case LOOP_SET_STATUS:
 		mutex_lock(&lo->lo_ctl_mutex);
 		err = loop_set_status_compat(
@@ -1311,13 +1310,12 @@ static long lo_compat_ioctl(struct file 
 		arg = (unsigned long) compat_ptr(arg);
 	case LOOP_SET_FD:
 	case LOOP_CHANGE_FD:
-		err = lo_ioctl(inode, file, cmd, arg);
+		err = lo_ioctl(file, cmd, arg);
 		break;
 	default:
 		err = -ENOIOCTLCMD;
 		break;
 	}
-	unlock_kernel();
 	return err;
 }
 #endif
@@ -1345,12 +1343,12 @@ static int lo_release(struct inode *inod
 }
 
 static struct block_device_operations lo_fops = {
-	.owner =	THIS_MODULE,
-	.open =		lo_open,
-	.release =	lo_release,
-	.ioctl =	lo_ioctl,
+	.owner =		THIS_MODULE,
+	.open =			lo_open,
+	.release =		lo_release,
+	.unlocked_ioctl =	lo_ioctl,
 #ifdef CONFIG_COMPAT
-	.compat_ioctl =	lo_compat_ioctl,
+	.compat_ioctl =		lo_compat_ioctl,
 #endif
 };
 
