Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319067AbSHMUqx>; Tue, 13 Aug 2002 16:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319070AbSHMUqw>; Tue, 13 Aug 2002 16:46:52 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:28315 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319067AbSHMUqu>;
	Tue, 13 Aug 2002 16:46:50 -0400
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200208132050.g7DKoYV05706@eng2.beaverton.ibm.com>
Subject: [PATCH] 2.5.31 small bug fix for blkdev_reread_part()
To: linux-kernel@vger.kernel.org, akpm@zip.com.au
Date: Tue, 13 Aug 2002 13:50:33 -0700 (PDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a trivial bug fix for blkdev_reread_part() in 2.5.31.
Without this fix,  "fdisk" hangs with following messages:

	Calling ioctl() to re-read partition table.

	WARNING: Re-reading the partition table failed with error 16: 
			Device or resource busy.
	The kernel still uses the old table.
	The new table will be used at the next reboot.


Please apply.


Thanks,
Badari

--- linux-2.5.31/fs/block_dev.c		Tue Aug 13 13:25:37 2002
+++ linux-2.5.31.new/fs/block_dev.c	Tue Aug 13 13:25:48 2002
@@ -797,7 +797,7 @@
 	part = disk->part + minor(dev) - disk->first_minor;
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
-	if (down_trylock(&bdev->bd_sem));
+	if (down_trylock(&bdev->bd_sem))
 		return -EBUSY;
 	if (bdev->bd_part_count) {
 		up(&bdev->bd_sem);
