Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316439AbSEOQxm>; Wed, 15 May 2002 12:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316440AbSEOQxl>; Wed, 15 May 2002 12:53:41 -0400
Received: from host194.steeleye.com ([216.33.1.194]:7184 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S316439AbSEOQxk>; Wed, 15 May 2002 12:53:40 -0400
Message-Id: <200205151653.g4FGrV702962@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: viro@math.psu.edu
cc: linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com
Subject: [PATCH] fix for initrd breakage in 2.5.13+
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_18615634120"
Date: Wed, 15 May 2002 12:53:31 -0400
From: James Bottomley <James.Bottomley@SteelEye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_18615634120
Content-Type: text/plain; charset=us-ascii

Hi Al,

initrd was completely broken by your change set 1.447.69.4 ([PATCH] (4/6) 
blksize_size[] removal).  As part of this change, you completely divorced the 
ramdisk from the setup parameter rd_blocksize, so it now has the default 512 
byte block size and thus initrd fails to mount.

The fix corrects the ramdisk problem (by setting the queue hardsect size to 
rd_blocksize), but there also has to be a fix in do_open because of the way 
it's now working.  The attached change is clearly incorrect, since it will 
reset the ramdisk blocksize for every open, but it does allow initrd to work 
again.  I can't see how to fix it correctly---for no reason I can fathom, 
bd_openers seems to be set for a ramdisk even on the first call into do_open.  
Can you find a correct fix to do_open?

James Bottomley


--==_Exmh_18615634120
Content-Type: text/plain ; name="viro_rd.diff"; charset=us-ascii
Content-Description: viro_rd.diff
Content-Disposition: attachment; filename="viro_rd.diff"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.513   -> 1.515  
#	      fs/block_dev.c	1.55    -> 1.56   
#	  drivers/block/rd.c	1.35    -> 1.36   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/15	jejb@mulgrave.(none)	1.514
# [RD FIX]
# 
# tie hardsect_size of the queue to rd_blocksize
# --------------------------------------------
# 02/05/15	jejb@mulgrave.(none)	1.515
# [RD FIX]
# 
# Make do_open respect the rd_hardsect limit (this fix is incorrect
# since it will reset the size on every call into do_open).  Need to
# find out why bd_openers is always set for rd.
# --------------------------------------------
#
diff -Nru a/drivers/block/rd.c b/drivers/block/rd.c
--- a/drivers/block/rd.c	Wed May 15 12:40:29 2002
+++ b/drivers/block/rd.c	Wed May 15 12:40:29 2002
@@ -424,6 +424,7 @@
 	}
 
 	blk_queue_make_request(BLK_DEFAULT_QUEUE(MAJOR_NR), &rd_make_request);
+	blk_queue_hardsect_size(BLK_DEFAULT_QUEUE(MAJOR_NR), rd_blocksize);
 
 	for (i = 0; i < NUM_RAMDISKS; i++) {
 		/* rd_size is given in kB */
diff -Nru a/fs/block_dev.c b/fs/block_dev.c
--- a/fs/block_dev.c	Wed May 15 12:40:29 2002
+++ b/fs/block_dev.c	Wed May 15 12:40:29 2002
@@ -606,7 +606,15 @@
 			goto out2;
 	}
 	bdev->bd_inode->i_size = blkdev_size(dev);
-	if (!bdev->bd_openers) {
+	if (major(dev) == RAMDISK_MAJOR) {
+		/* always set the bd_block_size to the hardsect size */
+		unsigned bsize = bdev_hardsect_size(bdev);
+
+		bdev->bd_block_size = bsize;
+		bdev->bd_inode->i_blkbits = blksize_bits(bsize);
+		printk("SETTING %d:%d to hardsect %d\n",
+		       major(dev), minor(dev), bsize);
+	} else if (!bdev->bd_openers) {
 		unsigned bsize = bdev_hardsect_size(bdev);
 		while (bsize < PAGE_CACHE_SIZE) {
 			if (bdev->bd_inode->i_size & bsize)

--==_Exmh_18615634120--


