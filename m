Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268090AbUHQEEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268090AbUHQEEx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 00:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268091AbUHQEEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 00:04:53 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:32147 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S268090AbUHQEEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 00:04:49 -0400
To: <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] fix 4K ext2fs support in 2.6 initrd's
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 16 Aug 2004 22:03:40 -0600
Message-ID: <m13c2ms95v.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The ramdisk_blocksize option has been broken for quite a while in 2.6.
Making an initrd with a 4K ext2 filesystem impossible to use.

After digging into this, the problem turned out to that rd.c was not
setting the hard sector size.  There were a few secondary problems
like i_blkbits was not being set, and the number KiB in uncompressed
ext2 images was not taking into account the block size.

I have also corrected the surrounding comments as they were not
just incorrect but misleading.

Eric

diff -uNrX linux-exclude-files linux-2.6.8.1/drivers/block/rd.c linux-2.6.8.1-initrdfix/drivers/block/rd.c
--- linux-2.6.8.1/drivers/block/rd.c	Tue Jun 15 23:19:37 2004
+++ linux-2.6.8.1-initrdfix/drivers/block/rd.c	Mon Aug 16 21:08:36 2004
@@ -349,13 +349,17 @@
 	if (rd_bdev[unit] == NULL) {
 		struct block_device *bdev = inode->i_bdev;
 		struct address_space *mapping;
+		unsigned bsize;
 		int gfp_mask;
 
 		inode = igrab(bdev->bd_inode);
 		rd_bdev[unit] = bdev;
 		bdev->bd_openers++;
-		bdev->bd_block_size = rd_blocksize;
-		inode->i_size = get_capacity(rd_disks[unit])<<9;
+		bsize = bdev_hardsect_size(bdev);
+		bdev->bd_block_size = bsize;
+		inode->i_blkbits = blksize_bits(bsize);
+		inode->i_size = get_capacity(bdev->bd_disk)<<9;
+
 		mapping = inode->i_mapping;
 		mapping->a_ops = &ramdisk_aops;
 		mapping->backing_dev_info = &rd_backing_dev_info;
@@ -449,6 +453,7 @@
 			goto out_queue;
 
 		blk_queue_make_request(rd_queue[i], &rd_make_request);
+		blk_queue_hardsect_size(rd_queue[i], rd_blocksize);
 
 		/* rd_size is given in kB */
 		disk->major = RAMDISK_MAJOR;
diff -uNrX linux-exclude-files linux-2.6.8.1/init/do_mounts_rd.c linux-2.6.8.1-initrdfix/init/do_mounts_rd.c
--- linux-2.6.8.1/init/do_mounts_rd.c	Tue Jun 15 23:19:43 2004
+++ linux-2.6.8.1-initrdfix/init/do_mounts_rd.c	Mon Aug 16 21:29:02 2004
@@ -122,7 +122,8 @@
 		printk(KERN_NOTICE
 		       "RAMDISK: ext2 filesystem found at block %d\n",
 		       start_block);
-		nblocks = le32_to_cpu(ext2sb->s_blocks_count);
+		nblocks = le32_to_cpu(ext2sb->s_blocks_count) <<
+			le32_to_cpu(ext2sb->s_log_block_size);
 		goto done;
 	}
 
@@ -173,10 +174,15 @@
 	}
 
 	/*
-	 * NOTE NOTE: nblocks suppose that the blocksize is BLOCK_SIZE, so
-	 * rd_load_image will work only with filesystem BLOCK_SIZE wide!
-	 * So make sure to use 1k blocksize while generating ext2fs
-	 * ramdisk-images.
+	 * NOTE NOTE: nblocks is not actually blocks but
+	 * the number of kibibytes of data to load into a ramdisk.
+	 * So any ramdisk block size that is a multiple of 1KiB should
+	 * work when the appropriate ramdisk_blocksize is specified
+	 * on the command line.
+	 * 
+	 * The default ramdisk_blocksize is 1KiB and it is generally
+	 * silly to use anything else, so make sure to use 1KiB
+	 * blocksize while generating ext2fs ramdisk-images.
 	 */
 	if (sys_ioctl(out_fd, BLKGETSIZE, (unsigned long)&rd_blocks) < 0)
 		rd_blocks = 0;
@@ -184,7 +190,7 @@
 		rd_blocks >>= 1;
 
 	if (nblocks > rd_blocks) {
-		printk("RAMDISK: image too big! (%d/%ld blocks)\n",
+		printk("RAMDISK: image too big! (%dKiB/%ldKiB)\n",
 		       nblocks, rd_blocks);
 		goto done;
 	}
@@ -211,7 +217,7 @@
 		goto done;
 	}
 
-	printk(KERN_NOTICE "RAMDISK: Loading %d blocks [%ld disk%s] into ram disk... ", 
+	printk(KERN_NOTICE "RAMDISK: Loading %dKiB [%ld disk%s] into ram disk... ", 
 		nblocks, ((nblocks-1)/devblocks)+1, nblocks>devblocks ? "s" : "");
 	for (i = 0, disk = 1; i < nblocks; i++) {
 		if (i && (i % devblocks == 0)) {

