Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262036AbSIYRan>; Wed, 25 Sep 2002 13:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262037AbSIYRan>; Wed, 25 Sep 2002 13:30:43 -0400
Received: from thunk.org ([140.239.227.29]:53662 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S262036AbSIYRam>;
	Wed, 25 Sep 2002 13:30:42 -0400
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] loop device broken in 2.5.38
From: tytso@mit.edu
Phone: (781) 391-3464
Message-Id: <E17uG42-0002gm-00@think.thunk.org>
Date: Wed, 25 Sep 2002 13:35:06 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The loop device driver was broken in 2.5.38 when it was converted over
to use gendisk.  I discovered this while doing final regression testing
on the ext3 htree code.

The problem is that figure_loop_size() is setting the capacity of the
loop device in kilobytes (because that's what compute_loop_size()
returns), but set_capacity() expects the size in 512 byte sectors.

I've enclosed a patch which fixes the problem, as well as simplifying
the code by eliminating compute_loop_size(), since it is a static
function is only used once by figure_loop_size().

						- Ted

===== drivers/block/loop.c 1.57 vs edited =====
--- 1.57/drivers/block/loop.c	Sat Sep 21 02:08:48 2002
+++ edited/drivers/block/loop.c	Wed Sep 25 13:28:37 2002
@@ -157,18 +157,12 @@
 
 #define MAX_DISK_SIZE 1024*1024*1024
 
-static unsigned long
-compute_loop_size(struct loop_device *lo, struct dentry * lo_dentry)
-{
-	loff_t size = lo_dentry->d_inode->i_mapping->host->i_size;
-	return (size - lo->lo_offset) >> BLOCK_SIZE_BITS;
-}
-
 static void figure_loop_size(struct loop_device *lo)
 {
-	set_capacity(disks + lo->lo_number, compute_loop_size(lo,
-					lo->lo_backing_file->f_dentry));
-					
+	loff_t size = lo->lo_backing_file->f_dentry->d_inode->i_size;
+
+	set_capacity(disks + lo->lo_number,
+		     (size - lo->lo_offset) >> (BLOCK_SIZE_BITS-1));
 }
 
 static inline int lo_do_transfer(struct loop_device *lo, int cmd, char *rbuf,
