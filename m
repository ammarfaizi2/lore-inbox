Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWEaXxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWEaXxX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 19:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWEaXxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 19:53:23 -0400
Received: from mga03.intel.com ([143.182.124.21]:16041 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751182AbWEaXxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 19:53:22 -0400
X-IronPort-AV: i="4.05,195,1146466800"; 
   d="scan'208"; a="44233221:sNHT76393737"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: "'Jens Axboe'" <axboe@suse.de>
Subject: Big kernel lock contention in do_open() and blkdev_put()
Date: Wed, 31 May 2006 16:53:21 -0700
Message-ID: <000001c6850d$660dfe60$d234030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcaFDWWKCqRjGaQFT4S67HZLmDtCZA==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently the latest kernel still uses big kernel lock in the opening/
closing of block device.  And on a moderate sized numa machine, we've see
huge lock contention with lock_kernel()/unlock_kernel() function coming
from fs/block_dev.c:do_open() and block_dev.c/blkdev_put().

This was found accidentally by a slightly non-optimal application environ-
ment: a multi-process application runs on 128P numa machine; it forks out
400 processes and each process tries to open ~3000 block devices. Because
of per process limit of file descriptor, this "smart ass" application went
into a mode where it dynamically open and close file descriptors on demand.
I know we can get around it by increasing "open file" limit.  But it darn
on me that current code won't allow concurrent opening of different block
devices either.

I've studied do_open() and blkdev_put(), and concluded that it is already
SMP safe because they are protected by per-device bdev->bd_mutex.  What's
left that I can tell is the call to each block device type via disk->fops
->open().  I would like to propose rid the BKL in the generic block device
open/close path and put the burden on each device specific code to use BKL
if necessary.  Most of the modern block device drivers shouldn't need them
because in fops->open() they already uses one of the three variants:
a) spin lock, b) mutex, or c) per device structure.

Out of the 63 hits I see in 2.6.17-rc4 with block_device_operations->open(),
floppy driver seems to be the only one that mucks around with a global
Variable without any protection. We can add a spin lock there.

Comments?


Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>


diff -Nurp linux-2.6.16/fs/block_dev.c linux-2.6.16.ken/fs/block_dev.c
--- linux-2.6.16/fs/block_dev.c	2006-05-31 17:45:37.000000000 -0700
+++ linux-2.6.16.ken/fs/block_dev.c	2006-05-31 17:44:48.000000000 -0700
@@ -860,10 +860,8 @@ static int do_open(struct block_device *
 	int part;
 
 	file->f_mapping = bdev->bd_inode->i_mapping;
-	lock_kernel();
 	disk = get_gendisk(bdev->bd_dev, &part);
 	if (!disk) {
-		unlock_kernel();
 		bdput(bdev);
 		return ret;
 	}
@@ -935,7 +933,6 @@ static int do_open(struct block_device *
 	}
 	bdev->bd_openers++;
 	mutex_unlock(&bdev->bd_mutex);
-	unlock_kernel();
 	return 0;
 
 out_first:
@@ -948,7 +945,6 @@ out_first:
 	module_put(owner);
 out:
 	mutex_unlock(&bdev->bd_mutex);
-	unlock_kernel();
 	if (ret)
 		bdput(bdev);
 	return ret;
@@ -1010,7 +1006,6 @@ int blkdev_put(struct block_device *bdev
 	struct gendisk *disk = bdev->bd_disk;
 
 	mutex_lock(&bdev->bd_mutex);
-	lock_kernel();
 	if (!--bdev->bd_openers) {
 		sync_blockdev(bdev);
 		kill_bdev(bdev);
@@ -1040,7 +1035,6 @@ int blkdev_put(struct block_device *bdev
 		}
 		bdev->bd_contains = NULL;
 	}
-	unlock_kernel();
 	mutex_unlock(&bdev->bd_mutex);
 	bdput(bdev);
 	return ret;
