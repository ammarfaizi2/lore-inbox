Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751908AbWFWSil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908AbWFWSil (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 14:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751906AbWFWSil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 14:38:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2985 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751908AbWFWSik (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 14:38:40 -0400
Date: Fri, 23 Jun 2006 19:38:29 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] dm: support ioctls on mapped devices: fix with fake file
Message-ID: <20060623183829.GZ19222@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[This applies after all the current dm patches.]


From: Milan Broz <mbroz@redhat.com>

The new ioctl code passes the wrong file pointer to the underlying device.
No file pointer is available so make a temporary fake one.

Signed-off-by: Milan Broz <mbroz@redhat.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.17/drivers/md/dm-mpath.c
===================================================================
--- linux-2.6.17.orig/drivers/md/dm-mpath.c	2006-06-23 19:17:27.000000000 +0100
+++ linux-2.6.17/drivers/md/dm-mpath.c	2006-06-23 19:17:40.000000000 +0100
@@ -1272,15 +1272,22 @@ static int multipath_ioctl(struct dm_tar
 	struct multipath *m = (struct multipath *) ti->private;
 	struct block_device *bdev = NULL;
 	unsigned long flags;
+	struct file fake_file = {};
+	struct dentry fake_dentry = {};
 	int r = 0;
 
+	fake_file.f_dentry = &fake_dentry;
+
 	spin_lock_irqsave(&m->lock, flags);
 
 	if (!m->current_pgpath)
 		__choose_pgpath(m);
 
-	if (m->current_pgpath)
+	if (m->current_pgpath) {
 		bdev = m->current_pgpath->path.dev->bdev;
+		fake_dentry.d_inode = bdev->bd_inode;
+		fake_file.f_mode = m->current_pgpath->path.dev->mode;
+	}
 
 	if (m->queue_io)
 		r = -EAGAIN;
@@ -1289,8 +1296,8 @@ static int multipath_ioctl(struct dm_tar
 
 	spin_unlock_irqrestore(&m->lock, flags);
 
-	return r ? : blkdev_driver_ioctl(bdev->bd_inode, filp, bdev->bd_disk,
-		     cmd, arg);
+	return r ? : blkdev_driver_ioctl(bdev->bd_inode, &fake_file,
+					 bdev->bd_disk, cmd, arg);
 }
 
 /*-----------------------------------------------------------------
Index: linux-2.6.17/drivers/md/dm-linear.c
===================================================================
--- linux-2.6.17.orig/drivers/md/dm-linear.c	2006-06-23 19:17:27.000000000 +0100
+++ linux-2.6.17/drivers/md/dm-linear.c	2006-06-23 19:17:40.000000000 +0100
@@ -104,8 +104,14 @@ static int linear_ioctl(struct dm_target
 {
 	struct linear_c *lc = (struct linear_c *) ti->private;
 	struct block_device *bdev = lc->dev->bdev;
+	struct file fake_file = {};
+	struct dentry fake_dentry = {};
 
-	return blkdev_driver_ioctl(bdev->bd_inode, filp, bdev->bd_disk, cmd, arg);
+	fake_file.f_mode = lc->dev->mode;
+	fake_file.f_dentry = &fake_dentry;
+	fake_dentry.d_inode = bdev->bd_inode;
+
+	return blkdev_driver_ioctl(bdev->bd_inode, &fake_file, bdev->bd_disk, cmd, arg);
 }
 
 static struct target_type linear_target = {
