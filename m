Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272590AbRIYDSu>; Mon, 24 Sep 2001 23:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274450AbRIYDSj>; Mon, 24 Sep 2001 23:18:39 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:45955
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S272590AbRIYDSc>; Mon, 24 Sep 2001 23:18:32 -0400
Date: Mon, 24 Sep 2001 23:18:54 -0400
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org
cc: andrea@suse.de, viro@math.psu.edu, torvalds@transmeta.com
Subject: [PATCH] invalidate buffers on blkdev_put
Message-ID: <251250000.1001387934@tiny>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi guys,

I had sent this to Al, but couldn't tell if he hated it, thought it was
broken, or just didn't think it was required.  So, I opted for wider
testing.  This only affects 2.4.10pre15+, as it was caused by the blkdev
changes there.

Anyway, the bug looks like this:

dd if=ext2-image-1 of=/dev/ram0
mount /dev/ram0 /mnt
umount /mnt

dd if=ext2-image-2 of=/dev/ram0
mount /dev/ram0 /mnt
ls -la /mnt (FS looks corrupted and wrong).

The problem is that on unmount, the ramdisk's buffer cache isn't cleared
because bd_openers is still one.  So, even if a new image is copied in, you
still see the old image's superblock/inodes etc on mount.

In this case, we want to leave the dirty pages in the page cache, but get
rid of the buffer cache copies.

This should not drop any updated data in the ramdisk because
rd_blkdev_pagecache_IO dirties pages as the higher layers send down
modified buffer heads (and other rd.c funcs do the same).  Patch is below.
Linus, please consider (pending lack of nays from Al).

An additional patch is probably to remove the second invalidate_buffers
call, since only the filesystems should have buffer cache entries.  

-chris

--- 3.1/fs/block_dev.c Sun, 23 Sep 2001 20:11:16 -0400 
+++ 3.1(w)/fs/block_dev.c Mon, 24 Sep 2001 15:11:49 -0400 
@@ -802,8 +802,10 @@
 			unlock_super(sb);
 			drop_super(sb);
 		}
-	} else if (kind == BDEV_FS)
+	} else if (kind == BDEV_FS) {
 		fsync_no_super(rdev);
+		invalidate_buffers(rdev);
+	}
 	if (!--bdev->bd_openers) {
 		truncate_inode_pages(bd_inode->i_mapping, 0);
 		invalidate_buffers(rdev);

