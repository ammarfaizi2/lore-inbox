Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272068AbTHHXZu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 19:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272118AbTHHXZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 19:25:49 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:45974 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S272068AbTHHXZf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 19:25:35 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] disk geometry/capacity cleanups
Date: Sat, 9 Aug 2003 01:25:57 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308090125.57284.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Incremental to "kill HDIO_GETGEO_BIG_RAW ioctl" patch.

--bartlomiej


ide: disk geometry/capacity cleanups

>From Andries.Brouwer@cwi.nl.

- kill redundant, never executed code in lba_capacity_is_ok()
- add idedisk_supports_{hpa,lba48}() helpers
- don't recalculate drive->cyl for drives using LBA addressing,
  we never fall-back to CHS, so its useless and confusing
- remove wrong drive->head and drive->sect assignments for LBA-48
- don't overwrite id->lba_capacity and id->lba_capacity_2

 drivers/ide/ide-disk.c |   92 +++++++++++++++++++++++++++----------------------
 1 files changed, 52 insertions(+), 40 deletions(-)

diff -puN drivers/ide/ide-disk.c~ide-disk-andries drivers/ide/ide-disk.c
--- linux-2.6.0-test2-bk7/drivers/ide/ide-disk.c~ide-disk-andries	2003-08-09 00:17:35.567186112 +0200
+++ linux-2.6.0-test2-bk7-root/drivers/ide/ide-disk.c	2003-08-09 00:17:35.572185352 +0200
@@ -86,11 +86,6 @@ static int lba_capacity_is_ok (struct hd
 {
 	unsigned long lba_sects, chs_sects, head, tail;
 
-	if ((id->command_set_2 & 0x0400) && (id->cfs_enable_2 & 0x0400)) {
-		printk("48-bit Drive: %llu \n", id->lba_capacity_2);
-		return 1;
-	}
-
 	/*
 	 * The ATA spec tells large drives to return
 	 * C/H/S = 16383/16/63 independent of their size.
@@ -1074,11 +1069,29 @@ static unsigned long long sectors_to_MB(
 	return n;
 }
 
+/*
+ * Bits 10 of command_set_1 and cfs_enable_1 must be equal,
+ * so on non-buggy drives we need test only one.
+ * However, we should also check whether these fields are valid.
+ */
+static inline int idedisk_supports_hpa(const struct hd_driveid *id)
+{
+	return (id->command_set_1 & 0x0400) && (id->cfs_enable_1 & 0x0400);
+}
+
+/*
+ * The same here.
+ */
+static inline int idedisk_supports_lba48(const struct hd_driveid *id)
+{
+	return (id->command_set_2 & 0x0400) && (id->cfs_enable_2 & 0x0400);
+}
+
 static inline void idedisk_check_hpa_lba28(ide_drive_t *drive)
 {
 	unsigned long capacity, set_max;
 
-	capacity = drive->id->lba_capacity;
+	capacity = drive->capacity;
 	set_max = idedisk_read_native_max_address(drive);
 
 	if (set_max <= capacity)
@@ -1093,7 +1106,7 @@ static inline void idedisk_check_hpa_lba
 #ifdef CONFIG_IDEDISK_STROKE
 	set_max = idedisk_set_max_address(drive, set_max);
 	if (set_max) {
-		drive->id->lba_capacity = set_max;
+		drive->capacity = set_max;
 		printk(KERN_INFO "%s: Host Protected Area disabled.\n",
 				 drive->name);
 	}
@@ -1104,7 +1117,7 @@ static inline void idedisk_check_hpa_lba
 {
 	unsigned long long capacity_2, set_max_ext;
 
-	capacity_2 = drive->id->lba_capacity_2;
+	capacity_2 = drive->capacity48;
 	set_max_ext = idedisk_read_native_max_address_ext(drive);
 
 	if (set_max_ext <= capacity_2)
@@ -1119,7 +1132,8 @@ static inline void idedisk_check_hpa_lba
 #ifdef CONFIG_IDEDISK_STROKE
 	set_max_ext = idedisk_set_max_address_ext(drive, set_max_ext);
 	if (set_max_ext) {
-		drive->id->lba_capacity_2 = set_max_ext;
+		drive->capacity48 = set_max_ext;
+		drive->capacity = (unsigned long) set_max_ext;
 		printk(KERN_INFO "%s: Host Protected Area disabled.\n",
 				 drive->name);
 	}
@@ -1147,32 +1161,21 @@ static void init_idedisk_capacity (ide_d
 	 * If this drive supports the Host Protected Area feature set,
 	 * then we may need to change our opinion about the drive's capacity.
 	 */
-	int hpa = (id->command_set_1 & 0x0400) && (id->cfs_enable_1 & 0x0400);
+	int hpa = idedisk_supports_hpa(id);
 
-	if ((id->command_set_2 & 0x0400) && (id->cfs_enable_2 & 0x0400)) {
+	if (idedisk_supports_lba48(id)) {
 		/* drive speaks 48-bit LBA */
-		unsigned long long capacity_2;
-
 		drive->select.b.lba = 1;
+		drive->capacity48 = id->lba_capacity_2;
+		drive->capacity = (unsigned long) drive->capacity48;
 		if (hpa)
 			idedisk_check_hpa_lba48(drive);
-		capacity_2 = id->lba_capacity_2;
-		drive->head		= drive->bios_head = 255;
-		drive->sect		= drive->bios_sect = 63;
-		drive->cyl = (unsigned int) capacity_2 / (drive->head * drive->sect);
-		drive->bios_cyl		= drive->cyl;
-		drive->capacity48	= capacity_2;
-		drive->capacity		= (unsigned long) capacity_2;
 	} else if ((id->capability & 2) && lba_capacity_is_ok(id)) {
 		/* drive speaks 28-bit LBA */
-		unsigned long capacity;
-
 		drive->select.b.lba = 1;
+		drive->capacity = id->lba_capacity;
 		if (hpa)
 			idedisk_check_hpa_lba28(drive);
-		capacity = id->lba_capacity;
-		drive->cyl = capacity / (drive->head * drive->sect);
-		drive->capacity = capacity;
 	} else {
 		/* drive speaks boring old 28-bit CHS */
 		drive->capacity = drive->cyl * drive->head * drive->sect;
@@ -1181,7 +1184,7 @@ static void init_idedisk_capacity (ide_d
 
 static sector_t idedisk_capacity (ide_drive_t *drive)
 {
-	if (drive->id->cfs_enable_2 & 0x0400)
+	if (idedisk_supports_lba48(drive->id))
 		return (drive->capacity48 - drive->sect0);
 	return (drive->capacity - drive->sect0);
 }
@@ -1472,7 +1475,7 @@ static int probe_lba_addressing (ide_dri
 	if (HWIF(drive)->addressing)
 		return 0;
 
-	if (!(drive->id->cfs_enable_2 & 0x0400))
+	if (!idedisk_supports_lba48(drive->id))
                 return -EIO;
 	drive->addressing = arg;
 	return 0;
@@ -1642,19 +1645,28 @@ static void idedisk_setup (ide_drive_t *
 	 * by correcting bios_cyls:
 	 */
 	capacity = idedisk_capacity (drive);
-	if (!drive->forced_geom && drive->bios_sect && drive->bios_head) {
-		unsigned int cap0 = capacity;	/* truncate to 32 bits */
-		unsigned int cylsz, cyl;
-
-		if (cap0 != capacity)
-			drive->bios_cyl = 65535;
-		else {
-			cylsz = drive->bios_sect * drive->bios_head;
-			cyl = cap0 / cylsz;
-			if (cyl > 65535)
-				cyl = 65535;
-			if (cyl > drive->bios_cyl)
-				drive->bios_cyl = cyl;
+	if (!drive->forced_geom) {
+
+		if (idedisk_supports_lba48(drive->id)) {
+			/* compatibility */
+			drive->bios_sect = 63;
+			drive->bios_head = 255;
+		}
+
+		if (drive->bios_sect && drive->bios_head) {
+			unsigned int cap0 = capacity; /* truncate to 32 bits */
+			unsigned int cylsz, cyl;
+
+			if (cap0 != capacity)
+				drive->bios_cyl = 65535;
+			else {
+				cylsz = drive->bios_sect * drive->bios_head;
+				cyl = cap0 / cylsz;
+				if (cyl > 65535)
+					cyl = 65535;
+				if (cyl > drive->bios_cyl)
+					drive->bios_cyl = cyl;
+			}
 		}
 	}
 	printk(KERN_INFO "%s: %llu sectors (%llu MB)",

_

