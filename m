Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263761AbTEOCqC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 22:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263763AbTEOCqC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 22:46:02 -0400
Received: from h-64-105-35-119.SNVACAID.covad.net ([64.105.35.119]:23937 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP id S263761AbTEOCqB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 22:46:01 -0400
Date: Wed, 14 May 2003 19:58:37 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200305150258.h4F2wbR27255@freya.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: disk corruption in 2.5.66-bk5 - 2.5.69
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	linux-2.5.66-bk5 changed blkdev_put in fs/block_dev.c
to only call sync_blockdev if bdev->bd_openers drops to zero.
For me, this has resulted in disk corruption when lilo runs
under kernels 2.5.66-bk5 through 2.5.69, even if I run
"sync" repeatedly after running lilo.

	I am not sure why I seem to be the first person reporting
this disastrous problem.  I suspect it may have something to do
with the fact that I boot from an initial ramdisk that changes
the root without using pivot_root (instead, process 1 does a chroot
at a time when it is the only process on the system) and the fact
that I user partitions defined by partx rather than kernel-based
partitioning.  Perhaps bdev->bd_openers never drops to zero in this
configuration as a result of some other bug that only occurs in
such a configuration.

	I notice also that that change in 2.5.66-bk5 causes
sync_blockdev to be called with the big kernel lock held, although
I do not think that is the cause of the data corruption.

	With the following kludge, the lilo data corruption 
in 2.5.69 seems to be gone.  I have deliberately not cleaned
up this patch for integration at this point, because I don't
understand the issue enough yet to know the real problem
and the right fix.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Miplitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--- linux-2.5.69/fs/block_dev.c.orig	2003-05-14 17:43:40.000000000 -0700
+++ linux-2.5.69/fs/block_dev.c	2003-05-14 17:44:29.000000000 -0700
@@ -635,14 +635,24 @@
 int blkdev_put(struct block_device *bdev, int kind)
 {
 	int ret = 0;
 	struct inode *bd_inode = bdev->bd_inode;
 	struct gendisk *disk = bdev->bd_disk;
 
 	down(&bdev->bd_sem);
+
+	/* AJR start */
+	switch (kind) {
+	case BDEV_FILE:
+	case BDEV_FS:
+		sync_blockdev(bd_inode->i_bdev);
+		break;
+	}
+	/* AJR end */
+
 	lock_kernel();
 	if (!--bdev->bd_openers) {
 		switch (kind) {
 		case BDEV_FILE:
 		case BDEV_FS:
 			sync_blockdev(bd_inode->i_bdev);
 			break;
