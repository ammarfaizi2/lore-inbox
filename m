Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131685AbRAAILL>; Mon, 1 Jan 2001 03:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131759AbRAAILB>; Mon, 1 Jan 2001 03:11:01 -0500
Received: from mx1.sac.fedex.com ([199.81.208.10]:5901 "EHLO mx1.sac.fedex.com")
	by vger.kernel.org with ESMTP id <S131685AbRAAIKv>;
	Mon, 1 Jan 2001 03:10:51 -0500
Date: Mon, 1 Jan 2001 15:36:24 +0800
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
Message-Id: <200101010736.f017aOq23370@silk.corp.fedex.com>
To: linus@silk.corp.fedex.com, Werner.Almesberger@epfl.ch, viro@math.psu.edu,
        linux-kernel@silk.corp.fedex.com, jchua@fedex.com
Subject: Re: [PATCH,RFC] initrd vs. BLKFLSBUF
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Happy new year.

I hope that the following patch will be included in the final 2.4.0 release.
Without it, the memory held by initrd ramdisk will never be freed!!!

Thanks,
Jeff



From: "Werner Almesberger" <Werner.Almesberger@epfl.ch>
To: <viro@math.psu.edu>
Cc: <jchua@fedex.com>; <linux-kernel@vger.kernel.org>
Sent: Monday, November 20, 2000 11:21 AM
Subject: [PATCH,RFC] initrd vs. BLKFLSBUF

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

--- linux.orig/drivers/block/rd.c Mon Nov 20 02:07:47 2000
+++ linux/drivers/block/rd.c Mon Nov 20 04:03:42 2000
@@ -690,6 +690,7 @@
 done:
  if (infile.f_op->release)
  infile.f_op->release(inode, &infile);
+ blkdev_put(out_inode->i_bdev, BDEV_FILE);
  set_fs(fs);
  return;
 free_inodes: /* free inodes on error */

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
