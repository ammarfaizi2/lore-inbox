Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161027AbWJDBAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161027AbWJDBAl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 21:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161053AbWJDBAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 21:00:40 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:45513 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161027AbWJDBAj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 21:00:39 -0400
Message-ID: <452307B4.3050006@in.ibm.com>
Date: Tue, 03 Oct 2006 18:00:36 -0700
From: Suzuki Kp <suzuki@in.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060413 Red Hat/1.7.13-1.4.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>
Subject: [RFC] PATCH to fix rescan_partitions to return errors properly
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[resending]

Hi,

Currently the rescan_partition returns 0 (success), even if it is unable
to rescan the partition information ( may be due to disks offline, I/O
error reading the table or unknown partition ). This would make ioctl()
calls succeed for BLKRRPART requests even if partitions were not scanned
properly, which is not a good thing to do.

Attached here is patch to fix the issue. The patch makes
rescan_partition to return -EINVAL for unknown partitions and -EIO for
disk I/O errors ( or when disks are offline ).

Comments ?

Thanks,

Suzuki K P <suzuki@in.ibm.com>
Linux Technology Centre,
IBM Systems & Technology Labs.




* Fix recscan_partitions to return error when the partition is unknown
or there is an I/O error reading the partition information.


Signed Off by : Suzuki K P <suzuki@in.ibm.com>

Index: linux-2.6.18/fs/partitions/check.c
===================================================================
--- linux-2.6.18.orig/fs/partitions/check.c     2006-09-26
04:41:55.000000000 +0530
+++ linux-2.6.18/fs/partitions/check.c  2006-09-26 05:09:29.000000000 +0530
@@ -177,7 +177,7 @@
         else if (warn_no_part)
                 printk(" unable to read partition table\n");
         kfree(state);
-       return NULL;
+       return ERR_PTR(res);
  }

  /*
@@ -458,8 +458,13 @@
                 delete_partition(disk, p);
         if (disk->fops->revalidate_disk)
                 disk->fops->revalidate_disk(disk);
-       if (!get_capacity(disk) || !(state = check_partition(disk, bdev)))
-               return 0;
+       if (!get_capacity(disk))
+               return -EINVAL;
+       state = check_partition(disk, bdev);
+       if (!state)
+               return -EINVAL;
+       if (IS_ERR(state))
+               return -EIO;
         for (p = 1; p < state->limit; p++) {
                 sector_t size = state->parts[p].size;
                 sector_t from = state->parts[p].from;



