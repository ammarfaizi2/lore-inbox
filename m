Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315419AbSFYAKW>; Mon, 24 Jun 2002 20:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315420AbSFYAKW>; Mon, 24 Jun 2002 20:10:22 -0400
Received: from OL65-148.fibertel.com.ar ([24.232.148.65]:26828 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S315419AbSFYAKV>;
	Mon, 24 Jun 2002 20:10:21 -0400
Date: Mon, 24 Jun 2002 21:15:13 -0300
From: Werner Almesberger <wa@almesberger.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] loop devices from NFS broken in recent 2.5
Message-ID: <20020624211513.A5442@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recent 2.5 kernels break loop devices using files on NFS, because
inode->i_sb->s_bdev is NULL, so you get an oops in loop_set_fd.

The patch below fixes this. Note that I'm not entirely sure
whether using i_blksize is really correct. The patch is for
2.5.24.

This patch also removes redundant setting of LO_FLAGS_READ_ONLY

- Werner

---------------------------------- cut here -----------------------------------

--- drivers/block/loop.c.orig	Sun Jun 23 09:09:10 2002
+++ drivers/block/loop.c	Sun Jun 23 11:41:19 2002
@@ -336,7 +336,10 @@ lo_receive(struct loop_device *lo, struc
 
 static inline int loop_get_bs(struct loop_device *lo)
 {
-	return block_size(lo->lo_device);
+	if (lo->lo_device)
+		return block_size(lo->lo_device);
+	/* @@@ is this correct ? */
+	return lo->lo_backing_file->f_dentry->d_inode->i_blksize;
 }
 
 static inline unsigned long loop_get_iv(struct loop_device *lo,
@@ -662,9 +665,6 @@ static int loop_set_fd(struct loop_devic
 	error = -EINVAL;
 	inode = file->f_dentry->d_inode;
 
-	if (!(file->f_mode & FMODE_WRITE))
-		lo_flags |= LO_FLAGS_READ_ONLY;
-
 	if (S_ISBLK(inode->i_mode)) {
 		lo_device = inode->i_bdev;
 		if (lo_device == bdev) {
@@ -691,7 +691,7 @@ static int loop_set_fd(struct loop_devic
 
 	get_file(file);
 
-	if (IS_RDONLY (inode) || bdev_read_only(lo_device)
+	if (IS_RDONLY (inode) || (lo_device && bdev_read_only(lo_device))
 	    || !(lo_file->f_mode & FMODE_WRITE))
 		lo_flags |= LO_FLAGS_READ_ONLY;
 
@@ -706,7 +706,7 @@ static int loop_set_fd(struct loop_devic
 	lo->old_gfp_mask = inode->i_mapping->gfp_mask;
 	inode->i_mapping->gfp_mask = GFP_NOIO;
 
-	set_blocksize(bdev, block_size(lo_device));
+	set_blocksize(bdev, loop_get_bs(lo));
 
 	lo->lo_bio = lo->lo_biotail = NULL;
 	kernel_thread(loop_thread, lo, CLONE_FS | CLONE_FILES | CLONE_SIGHAND);

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://icapeople.epfl.ch/almesber/_____________________________________/
