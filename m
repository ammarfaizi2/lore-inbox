Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262506AbSJFWbg>; Sun, 6 Oct 2002 18:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262512AbSJFWbf>; Sun, 6 Oct 2002 18:31:35 -0400
Received: from almesberger.net ([63.105.73.239]:10515 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S262506AbSJFWbb>; Sun, 6 Oct 2002 18:31:31 -0400
Date: Sun, 6 Oct 2002 19:36:57 -0300
From: Werner Almesberger <wa@almesberger.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] loop devices from NFS broken in 2.5
Message-ID: <20021006193657.B14894@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5 kernels from ~2.5.24 up to 2.5.40 break loop devices using
files on NFS, because inode->i_sb->s_bdev is NULL, so you get
an oops in loop_set_fd, and recently also in loop_get_status.

The patch below fixes this, and I haven't found any ill
side-effects for non-NFS use. The patch is for 2.5.40.

This patch also removes redundant setting of LO_FLAGS_READ_ONLY

(I've posted a similar patch about three months ago. The only
new things now are the loop_get_status change, and that I'm a
little more confident that my solution works :-)

- Werner

---------------------------------- cut here -----------------------------------

--- linux-2.5.40.orig/drivers/block/loop.c	Tue Oct  1 04:07:04 2002
+++ linux-2.5.40/drivers/block/loop.c	Sun Oct  6 19:18:37 2002
@@ -333,7 +333,9 @@
 
 static inline int loop_get_bs(struct loop_device *lo)
 {
-	return block_size(lo->lo_device);
+	if (lo->lo_device)
+		return block_size(lo->lo_device);
+	return lo->lo_backing_file->f_dentry->d_inode->i_blksize;
 }
 
 static inline unsigned long loop_get_iv(struct loop_device *lo,
@@ -662,9 +664,6 @@
 	error = -EINVAL;
 	inode = file->f_dentry->d_inode;
 
-	if (!(file->f_mode & FMODE_WRITE))
-		lo_flags |= LO_FLAGS_READ_ONLY;
-
 	if (S_ISBLK(inode->i_mode)) {
 		lo_device = inode->i_bdev;
 		if (lo_device == bdev) {
@@ -691,7 +690,7 @@
 
 	get_file(file);
 
-	if (IS_RDONLY (inode) || bdev_read_only(lo_device)
+	if (IS_RDONLY (inode) || (lo_device && bdev_read_only(lo_device))
 	    || !(lo_file->f_mode & FMODE_WRITE))
 		lo_flags |= LO_FLAGS_READ_ONLY;
 
@@ -706,7 +705,7 @@
 	lo->old_gfp_mask = inode->i_mapping->gfp_mask;
 	inode->i_mapping->gfp_mask = GFP_NOIO;
 
-	set_blocksize(bdev, block_size(lo_device));
+	set_blocksize(bdev, loop_get_bs(lo));
 
 	lo->lo_bio = lo->lo_biotail = NULL;
 
@@ -878,7 +877,7 @@
 	info.lo_number = lo->lo_number;
 	info.lo_device = stat.dev;
 	info.lo_inode = stat.ino;
-	info.lo_rdevice = lo->lo_device->bd_dev;
+	info.lo_rdevice = lo->lo_device ? lo->lo_device->bd_dev : 0;
 	info.lo_offset = lo->lo_offset;
 	info.lo_flags = lo->lo_flags;
 	strncpy(info.lo_name, lo->lo_name, LO_NAME_SIZE);

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
