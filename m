Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWGCMUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWGCMUq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 08:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWGCMUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 08:20:46 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:61108 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750706AbWGCMUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 08:20:45 -0400
Message-ID: <44A90B9A.5080805@de.ibm.com>
Date: Mon, 03 Jul 2006 14:20:42 +0200
From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: viro@zeniv.linux.org.uk, Jens Axboe <axboe@suse.de>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH/RFC] partitions: let partitions inherit policy from disk
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to suggest to change the partition code in
fs/partitions/check.c to initialize a newly detected partition's policy
field with that of the containing block device (see patch below).

My reasoning is that function set_disk_ro() in block/genhd.c
modifies the policy field (read-only indicator) of a disk and all
contained partitions. When a partition is detected after the call to
set_disk_ro(), the policy field of this partition will currently not
inherit the disk's policy field. This behavior poses a problem in cases
where a block device can be 'logically de- and reactivated' like e.g.
the s390 DASD driver because partition detection may run after the
policy field has been modified.

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

Initialize the policy field of partitions with that of the containing
block device.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
---
diff -Naurp linux-2.6.17/fs/partitions/check.c linux-2.6.17b/fs/partitions/check.c
--- linux-2.6.17/fs/partitions/check.c	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6.17b/fs/partitions/check.c	2006-07-03 12:49:13.000000000 +0200
@@ -348,6 +348,7 @@ void add_partition(struct gendisk *disk,
 	p->start_sect = start;-
 	p->nr_sects = len;
 	p->partno = part;
+	p->policy = disk->policy;

 	devfs_mk_bdev(MKDEV(disk->major, disk->first_minor + part),
 			S_IFBLK|S_IRUSR|S_IWUSR,
