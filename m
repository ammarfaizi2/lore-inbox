Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262088AbUBWXSb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 18:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbUBWXSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 18:18:31 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:50663 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S262088AbUBWXST convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 18:18:19 -0500
Date: Tue, 24 Feb 2004 10:17:05 +1100
From: Nathan Scott <nathans@sgi.com>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] blkdev_open/bd_claim vs BLKBSZSET
Message-ID: <20040223231705.GB773@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I was modifying mkfs.xfs to use O_EXCL for 2.6, and hit a snag.
It seems that once I've opened a block dev with O_EXCL I can no
longer issue the BLKBSZSET ioctl to it.  (Is that the expected
behavior?  If so, ignore...)

The fs/block_dev.c code for blkdev_open does:

int blkdev_open(struct inode * inode, struct file * filp)
	...
		if (!(res = bd_claim(bdev, filp)))
		return 0;


And the drivers/block/ioctl.c code for BLKBSZSET does this:

	int	holder;
	...
	case BLKBSZSET:
		...
		if (bd_claim(bdev, &holder) < 0)
			return -EBUSY;
		ret = set_blocksize(bdev, n);
		bd_release(bdev);

And mkfs gets EBUSY back from the ioctl.  Using the patch
below, the ioctl succeeds cos the original filp bdev owner
from open now matches with the owner in the ioctl call.  I
suspect that would be the correct behavior, but perhaps I'm
overlooking some good reason for it being this way?

cheers.

-- 
Nathan


--- /usr/tmp/TmpDir.4274-0/drivers/block/ioctl.c_1.1	2004-02-24 08:58:28.000000000 +1100
+++ drivers/block/ioctl.c	2004-02-23 20:12:24.216909064 +1100
@@ -138,7 +138,6 @@
 	struct block_device *bdev = inode->i_bdev;
 	struct gendisk *disk = bdev->bd_disk;
 	struct backing_dev_info *bdi;
-	int holder;
 	int ret, n;
 
 	switch (cmd) {
@@ -175,7 +174,7 @@
 			return -EINVAL;
 		if (get_user(n, (int *) arg))
 			return -EFAULT;
-		if (bd_claim(bdev, &holder) < 0)
+		if (bd_claim(bdev, file) < 0)
 			return -EBUSY;
 		ret = set_blocksize(bdev, n);
 		bd_release(bdev);
