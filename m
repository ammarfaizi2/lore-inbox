Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272070AbTHHX1f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 19:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272130AbTHHX1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 19:27:34 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:45974 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S272070AbTHHX1Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 19:27:16 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ide: always store disk capacity in u64
Date: Sat, 9 Aug 2003 01:27:40 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308090127.40839.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Incremental to "ide: disk geometry/capacity cleanups" patch.

--bartlomiej


ide: always store disk capacity in u64

>From Andries.Brouwer@cwi.nl.

- always use drive->capacity48 and kill drive->capacity

I've changed drive->capacity48 to drive->capacity64 to avoid confusion.

 drivers/ide/ide-disk.c |   69 ++++++++++++++++---------------------------------
 include/linux/ide.h    |    3 --
 2 files changed, 24 insertions(+), 48 deletions(-)

diff -puN drivers/ide/ide-disk.c~ide-disk-capacity64 drivers/ide/ide-disk.c
--- linux-2.6.0-test2-bk7/drivers/ide/ide-disk.c~ide-disk-capacity64	2003-08-09 00:25:47.344424608 +0200
+++ linux-2.6.0-test2-bk7-root/drivers/ide/ide-disk.c	2003-08-09 00:25:47.352423392 +0200
@@ -1087,53 +1087,33 @@ static inline int idedisk_supports_lba48
 	return (id->command_set_2 & 0x0400) && (id->cfs_enable_2 & 0x0400);
 }
 
-static inline void idedisk_check_hpa_lba28(ide_drive_t *drive)
+static inline void idedisk_check_hpa(ide_drive_t *drive)
 {
-	unsigned long capacity, set_max;
+	unsigned long long capacity, set_max;
+	int lba48 = idedisk_supports_lba48(drive->id);
 
-	capacity = drive->capacity;
-	set_max = idedisk_read_native_max_address(drive);
+	capacity = drive->capacity64;
+	if (lba48)
+		set_max = idedisk_read_native_max_address_ext(drive);
+	else
+		set_max = idedisk_read_native_max_address(drive);
 
 	if (set_max <= capacity)
 		return;
 
 	printk(KERN_INFO "%s: Host Protected Area detected.\n"
-			 "\tcurrent capacity is %ld sectors (%ld MB)\n"
-			 "\tnative  capacity is %ld sectors (%ld MB)\n",
+			 "\tcurrent capacity is %llu sectors (%llu MB)\n"
+			 "\tnative  capacity is %llu sectors (%llu MB)\n",
 			 drive->name,
-			 capacity, (capacity - capacity/625 + 974)/1950,
-			 set_max, (set_max - set_max/625 + 974)/1950);
+			 capacity, sectors_to_MB(capacity),
+			 set_max, sectors_to_MB(set_max));
 #ifdef CONFIG_IDEDISK_STROKE
-	set_max = idedisk_set_max_address(drive, set_max);
+	if (lba48)
+		set_max = idedisk_set_max_address_ext(drive, set_max);
+	else
+		set_max = idedisk_set_max_address(drive, set_max);
 	if (set_max) {
-		drive->capacity = set_max;
-		printk(KERN_INFO "%s: Host Protected Area disabled.\n",
-				 drive->name);
-	}
-#endif
-}
-
-static inline void idedisk_check_hpa_lba48(ide_drive_t *drive)
-{
-	unsigned long long capacity_2, set_max_ext;
-
-	capacity_2 = drive->capacity48;
-	set_max_ext = idedisk_read_native_max_address_ext(drive);
-
-	if (set_max_ext <= capacity_2)
-		return;
-
-	printk(KERN_INFO "%s: Host Protected Area detected.\n"
-			 "\tcurrent capacity is %lld sectors (%lld MB)\n"
-			 "\tnative  capacity is %lld sectors (%lld MB)\n",
-			 drive->name,
-			 capacity_2, sectors_to_MB(capacity_2),
-			 set_max_ext, sectors_to_MB(set_max_ext));
-#ifdef CONFIG_IDEDISK_STROKE
-	set_max_ext = idedisk_set_max_address_ext(drive, set_max_ext);
-	if (set_max_ext) {
-		drive->capacity48 = set_max_ext;
-		drive->capacity = (unsigned long) set_max_ext;
+		drive->capacity64 = set_max;
 		printk(KERN_INFO "%s: Host Protected Area disabled.\n",
 				 drive->name);
 	}
@@ -1166,27 +1146,24 @@ static void init_idedisk_capacity (ide_d
 	if (idedisk_supports_lba48(id)) {
 		/* drive speaks 48-bit LBA */
 		drive->select.b.lba = 1;
-		drive->capacity48 = id->lba_capacity_2;
-		drive->capacity = (unsigned long) drive->capacity48;
+		drive->capacity64 = id->lba_capacity_2;
 		if (hpa)
-			idedisk_check_hpa_lba48(drive);
+			idedisk_check_hpa(drive);
 	} else if ((id->capability & 2) && lba_capacity_is_ok(id)) {
 		/* drive speaks 28-bit LBA */
 		drive->select.b.lba = 1;
-		drive->capacity = id->lba_capacity;
+		drive->capacity64 = id->lba_capacity;
 		if (hpa)
-			idedisk_check_hpa_lba28(drive);
+			idedisk_check_hpa(drive);
 	} else {
 		/* drive speaks boring old 28-bit CHS */
-		drive->capacity = drive->cyl * drive->head * drive->sect;
+		drive->capacity64 = drive->cyl * drive->head * drive->sect;
 	}
 }
 
 static sector_t idedisk_capacity (ide_drive_t *drive)
 {
-	if (idedisk_supports_lba48(drive->id))
-		return (drive->capacity48 - drive->sect0);
-	return (drive->capacity - drive->sect0);
+	return drive->capacity64 - drive->sect0;
 }
 
 static ide_startstop_t idedisk_special (ide_drive_t *drive)
diff -puN include/linux/ide.h~ide-disk-capacity64 include/linux/ide.h
--- linux-2.6.0-test2-bk7/include/linux/ide.h~ide-disk-capacity64	2003-08-09 00:25:47.347424152 +0200
+++ linux-2.6.0-test2-bk7-root/include/linux/ide.h	2003-08-09 00:25:47.353423240 +0200
@@ -766,8 +766,7 @@ typedef struct ide_drive_s {
 	unsigned int	failures;	/* current failure count */
 	unsigned int	max_failures;	/* maximum allowed failure count */
 
-	u32		capacity;	/* total number of sectors */
-	u64		capacity48;	/* total number of sectors */
+	u64		capacity64;	/* total number of sectors */
 
 	int		last_lun;	/* last logical unit */
 	int		forced_lun;	/* if hdxlun was given at boot */

_

