Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbWAKMD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWAKMD3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 07:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWAKMD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 07:03:29 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:45702 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S1751198AbWAKMD3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 07:03:29 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17348.62479.70227.421232@jaguar.mkp.net>
Date: Wed, 11 Jan 2006 07:03:27 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: [patch] sem2mutex floppy.c
X-Mailer: VM 7.19 under Emacs 21.4.1
From: jes@trained-monkey.org (Jes Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This one converts the floppy driver to a mutex. Patch tested by Ingo as
I don't have anything floppy capable to test it on.

Cheers,
Jes

Convert from semaphore to mutex.

Signed-off-by: Jes Sorensen <jes@sgi.com>

----

 drivers/block/floppy.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

Index: linux-2.6/drivers/block/floppy.c
===================================================================
--- linux-2.6.orig/drivers/block/floppy.c
+++ linux-2.6/drivers/block/floppy.c
@@ -179,6 +179,7 @@
 #include <linux/devfs_fs_kernel.h>
 #include <linux/platform_device.h>
 #include <linux/buffer_head.h>	/* for invalidate_buffers() */
+#include <linux/mutex.h>
 
 /*
  * PS/2 floppies have much slower step rates than regular floppies.
@@ -414,7 +415,7 @@
 static struct timer_list motor_off_timer[N_DRIVE];
 static struct gendisk *disks[N_DRIVE];
 static struct block_device *opened_bdev[N_DRIVE];
-static DECLARE_MUTEX(open_lock);
+static DEFINE_MUTEX(open_lock);
 static struct floppy_raw_cmd *raw_cmd, default_raw_cmd;
 
 /*
@@ -3334,7 +3335,7 @@
 	if (type) {
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		down(&open_lock);
+		mutex_lock(&open_lock);
 		LOCK_FDC(drive, 1);
 		floppy_type[type] = *g;
 		floppy_type[type].name = "user format";
@@ -3348,7 +3349,7 @@
 				continue;
 			__invalidate_device(bdev);
 		}
-		up(&open_lock);
+		mutex_unlock(&open_lock);
 	} else {
 		int oldStretch;
 		LOCK_FDC(drive, 1);
@@ -3675,7 +3676,7 @@
 {
 	int drive = (long)inode->i_bdev->bd_disk->private_data;
 
-	down(&open_lock);
+	mutex_lock(&open_lock);
 	if (UDRS->fd_ref < 0)
 		UDRS->fd_ref = 0;
 	else if (!UDRS->fd_ref--) {
@@ -3685,7 +3686,7 @@
 	if (!UDRS->fd_ref)
 		opened_bdev[drive] = NULL;
 	floppy_release_irq_and_dma();
-	up(&open_lock);
+	mutex_unlock(&open_lock);
 	return 0;
 }
 
@@ -3703,7 +3704,7 @@
 	char *tmp;
 
 	filp->private_data = (void *)0;
-	down(&open_lock);
+	mutex_lock(&open_lock);
 	old_dev = UDRS->fd_device;
 	if (opened_bdev[drive] && opened_bdev[drive] != inode->i_bdev)
 		goto out2;
@@ -3786,7 +3787,7 @@
 		if ((filp->f_mode & 2) && !(UTESTF(FD_DISK_WRITABLE)))
 			goto out;
 	}
-	up(&open_lock);
+	mutex_unlock(&open_lock);
 	return 0;
 out:
 	if (UDRS->fd_ref < 0)
@@ -3797,7 +3798,7 @@
 		opened_bdev[drive] = NULL;
 	floppy_release_irq_and_dma();
 out2:
-	up(&open_lock);
+	mutex_unlock(&open_lock);
 	return res;
 }
 
