Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263201AbTGMO7n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 10:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267401AbTGMO7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 10:59:43 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:18192 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S263201AbTGMO7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 10:59:42 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.5.75] fix removable partitioned media with devfs
Date: Sun, 13 Jul 2003 18:38:07 +0400
User-Agent: KMail/1.5
Cc: devfs@oss.sgi.com
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_P7WE/Nf/oBjoHUO"
Message-Id: <200307131838.07341.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_P7WE/Nf/oBjoHUO
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Current 2.5 does not register any device node in devfs for empty media 
(capacity == 0) case. This makes removables unusable with devfs. Partition 
rescan is done only on bdev open, but without any device node for device it 
is impossible to open it.

In 2.4 it was finally solved by always registering .../disc node as 
representation for "whole" disk and using devfsd action to force partition 
rescan on access to (non-existing) partition name. For primary names it was 
handled internally by devfs - it kept track of removable devices in directory 
and initiated partition rescan when name was not found.

Both are obviously broken now. You can't do partition rescan because no node 
is registered at all and internal handling was removed. Very nice.

The attached patch makes resgister_disk always register at least disc node. 
This now works for old and new compat names as per devfsd configuration; 
canonical names are still broken:

{pts/3}% ll /dev/scsi/host1/bus0/target4/lun0/part4
ls: /dev/scsi/host1/bus0/target4/lun0/part4: No such file or directory

but it can be fixed using the same technique as above so I won't push it.

-andrey
--Boundary-00=_P7WE/Nf/oBjoHUO
Content-Type: text/x-diff;
  charset="us-ascii";
  name="2.5.75-removable_media_with_devfs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.5.75-removable_media_with_devfs.patch"

--- linux-2.5.75-smp/fs/partitions/check.c.removable	2003-06-26 21:41:24.000000000 +0400
+++ linux-2.5.75-smp/fs/partitions/check.c	2003-07-13 17:20:16.000000000 +0400
@@ -348,6 +348,9 @@ void register_disk(struct gendisk *disk)
 		return;
 	}
 
+	/* always add handle for the whole disk */
+	devfs_add_partitioned(disk);
+
 	/* No such device (e.g., media were just removed) */
 	if (!get_capacity(disk))
 		return;
@@ -356,7 +359,6 @@ void register_disk(struct gendisk *disk)
 	if (blkdev_get(bdev, FMODE_READ, 0, BDEV_RAW) < 0)
 		return;
 	state = check_partition(disk, bdev);
-	devfs_add_partitioned(disk);
 	if (state) {
 		for (j = 1; j < state->limit; j++) {
 			sector_t size = state->parts[j].size;

--Boundary-00=_P7WE/Nf/oBjoHUO--

