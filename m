Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbVBXO4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbVBXO4f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 09:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262381AbVBXO41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 09:56:27 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:51105 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S262363AbVBXOsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 09:48:03 -0500
Date: Thu, 24 Feb 2005 15:39:51 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
cc: Tejun Heo <htejun@gmail.com>
Subject: [patch ide-dev 3/9] merge LBA28 and LBA48 Host Protected Area support
 code
Message-ID: <Pine.GSO.4.58.0502241539100.13534@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* merge idedisk_read_native_max_address()
  and idedisk_read_native_max_address_ext()
* merge idedisk_set_max_address()
  and idedisk_set_max_address_ext()

diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	2005-02-19 17:22:44 +01:00
+++ b/drivers/ide/ide-disk.c	2005-02-19 17:22:44 +01:00
@@ -325,32 +325,7 @@
  * Queries for true maximum capacity of the drive.
  * Returns maximum LBA address (> 0) of the drive, 0 if failed.
  */
-static unsigned long idedisk_read_native_max_address(ide_drive_t *drive)
-{
-	ide_task_t args;
-	struct ata_taskfile *tf = &args.tf;
-	unsigned long addr = 0;
-
-	/* Create IDE/ATA command request structure */
-	memset(&args, 0, sizeof(ide_task_t));
-
-	tf->device	= 0x40;
-	tf->command	= WIN_READ_NATIVE_MAX;
-
-	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
-	args.handler				= &task_no_data_intr;
-	/* submit command request */
-	ide_raw_taskfile(drive, &args, NULL);
-
-	/* if OK, compute maximum address value */
-	if ((tf->command & 1) == 0) {
-		addr = (u32)ide_tf_get_address(tf);
-		addr++;	/* since the return value is (maxlba - 1), we add 1 */
-	}
-	return addr;
-}
-
-static unsigned long long idedisk_read_native_max_address_ext(ide_drive_t *drive)
+static u64 idedisk_read_native_max_address(ide_drive_t *drive, unsigned int lba48)
 {
 	ide_task_t args;
 	struct ata_taskfile *tf = &args.tf;
@@ -360,13 +335,15 @@
 	memset(&args, 0, sizeof(ide_task_t));

 	tf->device	= 0x40;
-	tf->command	= WIN_READ_NATIVE_MAX_EXT;
+	if (lba48) {
+		tf->command = WIN_READ_NATIVE_MAX_EXT;
+		tf->flags |= ATA_TFLAG_LBA48;
+	} else
+		tf->command = WIN_READ_NATIVE_MAX;

 	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
 	args.handler				= &task_no_data_intr;

-	tf->flags |= ATA_TFLAG_LBA48;
-
         /* submit command request */
         ide_raw_taskfile(drive, &args, NULL);

@@ -382,35 +359,7 @@
  * Sets maximum virtual LBA address of the drive.
  * Returns new maximum virtual LBA address (> 0) or 0 on failure.
  */
-static unsigned long idedisk_set_max_address(ide_drive_t *drive, unsigned long addr_req)
-{
-	ide_task_t args;
-	struct ata_taskfile *tf = &args.tf;
-	unsigned long addr_set = 0;
-
-	addr_req--;
-	/* Create IDE/ATA command request structure */
-	memset(&args, 0, sizeof(ide_task_t));
-
-	tf->lbal	= addr_req;
-	tf->lbam	= addr_req >> 8;
-	tf->lbah	= addr_req >> 16;
-	tf->device	= ((addr_req >> 24) & 0xf) | 0x40;
-	tf->command	= WIN_SET_MAX;
-
-	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
-	args.handler				= &task_no_data_intr;
-	/* submit command request */
-	ide_raw_taskfile(drive, &args, NULL);
-	/* if OK, read new maximum address value */
-	if ((tf->command & 1) == 0) {
-		addr_set = (u32)ide_tf_get_address(tf);
-		addr_set++;
-	}
-	return addr_set;
-}
-
-static unsigned long long idedisk_set_max_address_ext(ide_drive_t *drive, unsigned long long addr_req)
+static u64 idedisk_set_max_address(ide_drive_t *drive, u64 addr_req, unsigned int lba48)
 {
 	ide_task_t args;
 	struct ata_taskfile *tf = &args.tf;
@@ -423,17 +372,22 @@
 	tf->lbal	= addr_req;
 	tf->lbam	= addr_req >> 8;
 	tf->lbah	= addr_req >> 16;
-	tf->device	= 0x40;
-	tf->command	= WIN_SET_MAX_EXT;
-	tf->hob_lbal	= addr_req >> 24;
-	tf->hob_lbam	= addr_req >> 32;
-	tf->hob_lbah	= addr_req >> 40;
+	if (lba48) {
+		tf->hob_lbal	= addr_req >> 24;
+		tf->hob_lbam	= addr_req >> 32;
+		tf->hob_lbah	= addr_req >> 40;
+		tf->device	= 0x40;
+		tf->command	= WIN_SET_MAX_EXT;
+
+		tf->flags |= ATA_TFLAG_LBA48;
+	} else {
+		tf->device	= ((addr_req >> 24) & 0xf) | 0x40;
+		tf->command	= WIN_SET_MAX;
+	}

 	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
 	args.handler				= &task_no_data_intr;

-	tf->flags |= ATA_TFLAG_LBA48;
-
 	/* submit command request */
 	ide_raw_taskfile(drive, &args, NULL);
 	/* if OK, compute maximum address value */
@@ -476,10 +430,8 @@
 	int lba48 = idedisk_supports_lba48(drive->id);

 	capacity = drive->capacity64;
-	if (lba48)
-		set_max = idedisk_read_native_max_address_ext(drive);
-	else
-		set_max = idedisk_read_native_max_address(drive);
+
+	set_max = idedisk_read_native_max_address(drive, lba48);

 	if (set_max <= capacity)
 		return;
@@ -491,10 +443,8 @@
 			 capacity, sectors_to_MB(capacity),
 			 set_max, sectors_to_MB(set_max));

-	if (lba48)
-		set_max = idedisk_set_max_address_ext(drive, set_max);
-	else
-		set_max = idedisk_set_max_address(drive, set_max);
+	set_max = idedisk_set_max_address(drive, set_max, lba48);
+
 	if (set_max) {
 		drive->capacity64 = set_max;
 		printk(KERN_INFO "%s: Host Protected Area disabled.\n",
