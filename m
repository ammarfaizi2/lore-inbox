Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270833AbTHKCgL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 22:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270861AbTHKCgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 22:36:11 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:61352 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S270833AbTHKCgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 22:36:08 -0400
From: NeilBrown <neilb@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@osdl.org>
Date: Mon, 11 Aug 2003 12:35:57 +1000
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2 of 2 - Allow O_EXCL on a block device to claim exclusive use.
Message-Id: <E19m2XN-0002BU-00@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

### Comments for ChangeSet

the blockdev layer has a concept of 'claiming' a device,
so for example it can be claimed when a filesystem is
mounted or when it is included into a raid array.
Only one subsystem can claim it at a time.

This patch matches this functionality available to user-space
via the O_EXCL flag to open.

This allows user-space programs to easily test if a device
is currently mounted etc, and to prevent a device from being
mounted or otherwise claimed.

 ----------- Diffstat output ------------
 ./fs/block_dev.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletion(-)

diff ./fs/block_dev.c~current~ ./fs/block_dev.c
--- ./fs/block_dev.c~current~	2003-08-11 09:01:38.000000000 +1000
+++ ./fs/block_dev.c	2003-08-11 09:01:41.000000000 +1000
@@ -643,6 +643,7 @@ int blkdev_get(struct block_device *bdev
 int blkdev_open(struct inode * inode, struct file * filp)
 {
 	struct block_device *bdev;
+	int res;
 
 	/*
 	 * Preserve backwards compatibility and allow large file access
@@ -655,7 +656,18 @@ int blkdev_open(struct inode * inode, st
 	bd_acquire(inode);
 	bdev = inode->i_bdev;
 
-	return do_open(bdev, inode, filp);
+	res = do_open(bdev, inode, filp);
+	if (res)
+		return res;
+
+	if (!(filp->f_flags & O_EXCL) )
+		return 0;
+
+	if (!(res = bd_claim(bdev, filp)))
+		return 0;
+
+	blkdev_put(bdev, BDEV_FILE);
+	return res;
 }
 
 int blkdev_put(struct block_device *bdev, int kind)
@@ -704,6 +716,8 @@ int blkdev_put(struct block_device *bdev
 
 int blkdev_close(struct inode * inode, struct file * filp)
 {
+	if (inode->i_bdev->bd_holder == filp)
+		bd_release(inode->i_bdev);
 	return blkdev_put(inode->i_bdev, BDEV_FILE);
 }
 
