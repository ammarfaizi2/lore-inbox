Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264359AbTH1XS2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 19:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264378AbTH1XS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 19:18:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:54457 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264359AbTH1XSZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 19:18:25 -0400
Date: Thu, 28 Aug 2003 16:18:53 -0700
From: Dave Olien <dmo@osdl.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.0-test4-mm2 drivers/char.c Oops on open()
Message-ID: <20030828231853.GA7192@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The raw.c character device Oopses dereferencing a NULL pointer in bd_claim()
This problem occurred after bd_claim() in block_dev.c was modified to "claim
the whole device when a partition is claimed".

raw_open() made the mistake of calling bd_claim BEFORE calling
blkdev_get().  At that time, the bdev->bd_contains field. has't been
initialized yet.  Switching the order allows blkdev_get() to initialize
those fields before calling bd_claim().

Also fixed up some error return paths:

igrab() should never fail under these circumstances since the caller
already has a reference to that inode through the bdev at that time.

In the event of blkdev_get() failure or set_blocksize() failure, not
all the work to unwind from the error was done.

--- linux-2.6.0-test4-mm2_original/drivers/char/raw.c	2003-08-28 13:16:03.000000000 -0700
+++ linux-2.6.0-test4-mm2_raw/drivers/char/raw.c	2003-08-28 14:07:44.000000000 -0700
@@ -60,25 +60,25 @@
 	bdev = raw_devices[minor].binding;
 	err = -ENODEV;
 	if (bdev) {
-		err = bd_claim(bdev, raw_open);
+		err = blkdev_get(bdev, filp->f_mode, 0, BDEV_RAW);
 		if (err)
 			goto out;
-		err = -ENODEV;
-		if (!igrab(bdev->bd_inode))
+		igrab(bdev->bd_inode);
+		err = bd_claim(bdev, raw_open);
+		if (err) {
+			blkdev_put(bdev, BDEV_RAW);
 			goto out;
-		err = blkdev_get(bdev, filp->f_mode, 0, BDEV_RAW);
+		}
+		err = set_blocksize(bdev, bdev_hardsect_size(bdev));
 		if (err) {
 			bd_release(bdev);
+			blkdev_put(bdev, BDEV_RAW);
 			goto out;
-		} else {
-			err = set_blocksize(bdev, bdev_hardsect_size(bdev));
-			if (err == 0) {
-				filp->f_flags |= O_DIRECT;
-				if (++raw_devices[minor].inuse == 1)
-					filp->f_dentry->d_inode->i_mapping =
-						bdev->bd_inode->i_mapping;
-			}
 		}
+		filp->f_flags |= O_DIRECT;
+		if (++raw_devices[minor].inuse == 1)
+			filp->f_dentry->d_inode->i_mapping =
+				bdev->bd_inode->i_mapping;
 	}
 	filp->private_data = bdev;
 out:
