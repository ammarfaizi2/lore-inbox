Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263469AbRFFEIv>; Wed, 6 Jun 2001 00:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263479AbRFFEIl>; Wed, 6 Jun 2001 00:08:41 -0400
Received: from adsl-64-109-89-110.chicago.il.ameritech.net ([64.109.89.110]:9299
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S263469AbRFFEI3>; Wed, 6 Jun 2001 00:08:29 -0400
Message-Id: <200106060408.AAA03634@localhost.localdomain>
X-Mailer: exmh version 2.1.1 10/15/1999
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix for initrd panic in 2.4.5
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-161795120"
Date: Wed, 06 Jun 2001 00:08:21 -0400
From: James Bottomley <James.Bottomley@SteelEye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_-161795120
Content-Type: text/plain; charset=us-ascii

Not many people have seen this, but the i_bdev field in fake_inode in 
ioctl_by_bdev() is uninitialised.  Since this field is dereferenced by 
BLKFLSBUF in rd_ioctl, it can lead to a panic (depending on what happens to be 
on the stack).  The attached fixes the problem and clears all the fields in 
fake_inode to make any other problems like this show up.

James Bottomley


--==_Exmh_-161795120
Content-Type: text/plain ; name="linux-2.4.5-initrd.diff"; charset=us-ascii
Content-Description: linux-2.4.5-initrd.diff
Content-Disposition: attachment; filename="linux-2.4.5-initrd.diff"

Index: fs/block_dev.c
===================================================================
RCS file: /home/jejb/CVSROOT/linux/2.4/fs/block_dev.c,v
retrieving revision 1.1.1.10
diff -u -r1.1.1.10 block_dev.c
--- fs/block_dev.c	2001/05/26 15:33:37	1.1.1.10
+++ fs/block_dev.c	2001/06/02 13:14:35
@@ -596,13 +596,14 @@
 int ioctl_by_bdev(struct block_device *bdev, unsigned cmd, unsigned long arg)
 {
 	kdev_t rdev = to_kdev_t(bdev->bd_dev);
-	struct inode inode_fake;
+	struct inode inode_fake = { 0 };
 	int res;
 	mm_segment_t old_fs = get_fs();
 
 	if (!bdev->bd_op->ioctl)
 		return -EINVAL;
 	inode_fake.i_rdev=rdev;
+	inode_fake.i_bdev = bdev;
 	init_waitqueue_head(&inode_fake.i_wait);
 	set_fs(KERNEL_DS);
 	res = bdev->bd_op->ioctl(&inode_fake, NULL, cmd, arg);

--==_Exmh_-161795120--


