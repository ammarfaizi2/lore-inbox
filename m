Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbUCEWXP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 17:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbUCEWXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 17:23:15 -0500
Received: from ns.suse.de ([195.135.220.2]:5254 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261331AbUCEWXL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 17:23:11 -0500
Subject: [PATCH] loop setup race
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Type: text/plain
Message-Id: <1078525541.25064.136.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 05 Mar 2004 17:25:41 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

There's a race in loopback setup, it's easiest to trigger with one or
more procs doing loopback mounts at the same time.  The problem is that
fs/block_dev.c:do_open() only calls bdev_set_size on the first open. 
Picture two procs:

proc1: mount -o loop file1 mnt1
proc2: mount -o loop file2 mnt2

proc1                   proc2 
open /dev/loop0                         # bd_openers now 1
do_open
 bd_set_size(bdev, 0)                   # loop unbound, so bdev size is 0
                        open /dev/loop0 # bd_openers now 2
loop_set_fd                             # disk capacity now correct, but 
				        # bdev not updated
mount /dev/loop0 /mnt   
do_open

Because bd_openers != 0 for the last do_open, bd_set_size is not called
again and a size of 0 is used.  This eventually leads to an oops when
the loop device is unmounted, because fsync_bdev calls
block_write_full_page who decides every page on the block device is
outside i_size and unmaps them.

When ext2 or reiserfs try to sync a metadata buffer, we get an oops on
because the buffers are no longer mapped.

The patch below changes loop_set_fd and loop_clr_fd to also manipulate
the size of the block device, which fixes things for me.  It might need
some massaging to fit into -mm, but I think the bug is still present
there.

Index: linux.t/drivers/block/loop.c
===================================================================
--- linux.t.orig/drivers/block/loop.c	2004-03-05 11:41:12.000000000 -0500
+++ linux.t/drivers/block/loop.c	2004-03-05 11:44:00.000000000 -0500
@@ -559,6 +559,7 @@
 		error = -EFBIG;
 		goto out_putf;
 	}
+	bd_set_size(bdev,(loff_t)get_capacity(disks[lo->lo_number])<<9);
 	lo->old_gfp_mask = mapping_gfp_mask(mapping);
 	mapping_set_gfp_mask(mapping, lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
 
@@ -659,6 +660,7 @@
 	memset(lo->lo_file_name, 0, LO_NAME_SIZE);
 	invalidate_bdev(bdev, 0);
 	set_capacity(disks[lo->lo_number], 0);
+	bd_set_size(bdev, 0);
 	mapping_set_gfp_mask(filp->f_mapping, gfp);
 	lo->lo_state = Lo_unbound;
 	fput(filp);
Index: linux.t/fs/block_dev.c
===================================================================
--- linux.t.orig/fs/block_dev.c	2004-03-05 11:39:19.000000000 -0500
+++ linux.t/fs/block_dev.c	2004-03-05 11:39:43.000000000 -0500
@@ -523,7 +523,7 @@
 
 EXPORT_SYMBOL(check_disk_change);
 
-static void bd_set_size(struct block_device *bdev, loff_t size)
+void bd_set_size(struct block_device *bdev, loff_t size)
 {
 	unsigned bsize = bdev_hardsect_size(bdev);
 
@@ -536,6 +536,7 @@
 	bdev->bd_block_size = bsize;
 	bdev->bd_inode->i_blkbits = blksize_bits(bsize);
 }
+EXPORT_SYMBOL(bd_set_size);
 
 static int do_open(struct block_device *bdev, struct file *file)
 {
Index: linux.t/include/linux/fs.h
===================================================================
--- linux.t.orig/include/linux/fs.h	2004-03-04 11:40:05.000000000 -0500
+++ linux.t/include/linux/fs.h	2004-03-05 11:40:45.000000000 -0500
@@ -1138,6 +1139,7 @@
 extern int register_blkdev(unsigned int, const char *);
 extern int unregister_blkdev(unsigned int, const char *);
 extern struct block_device *bdget(dev_t);
+extern void bd_set_size(struct block_device *, loff_t size);
 extern void bd_forget(struct inode *inode);
 extern void bdput(struct block_device *);
 extern int blkdev_open(struct inode *, struct file *);


