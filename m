Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130150AbQKTDwa>; Sun, 19 Nov 2000 22:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129732AbQKTDwV>; Sun, 19 Nov 2000 22:52:21 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:3339 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S129942AbQKTDwN>;
	Sun, 19 Nov 2000 22:52:13 -0500
Date: Mon, 20 Nov 2000 04:21:51 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: viro@math.psu.edu
Cc: jchua@fedex.com, linux-kernel@vger.kernel.org
Subject: [PATCH,RFC] initrd vs. BLKFLSBUF
Message-ID: <20001120042151.A599@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

Jeff Chua reported a while ago that BLKFLSBUF returns EBUSY on a RAM disk
that was obtained via initrd. I think the problem is that the effect of
the blkdev_open(out_inode, ...) in drivers/block/rd.c:rd_load_image is
not undone at the end. I've attached a patch for 2.4.0-test11-pre7 that
seems to solve the problem. Since I'm not quite sure I understand the
reference counting rules there, I would appreciate your comment.

Thanks,
- Werner

---------------------------------- cut here -----------------------------------

--- linux.orig/drivers/block/rd.c	Mon Nov 20 02:07:47 2000
+++ linux/drivers/block/rd.c	Mon Nov 20 04:03:42 2000
@@ -690,6 +690,7 @@
 done:
 	if (infile.f_op->release)
 		infile.f_op->release(inode, &infile);
+	blkdev_put(out_inode->i_bdev, BDEV_FILE);
 	set_fs(fs);
 	return;
 free_inodes: /* free inodes on error */ 

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
