Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270461AbTHGUJt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 16:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270473AbTHGUJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 16:09:49 -0400
Received: from hera.cwi.nl ([192.16.191.8]:28398 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S270461AbTHGUJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 16:09:44 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 7 Aug 2003 22:09:43 +0200 (MEST)
Message-Id: <UTC200308072009.h77K9hm01960.aeb@smtp.cwi.nl>
To: B.Zolnierkiewicz@elka.pw.edu.pl
Subject: [PATCH] kill superfluous capacity
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have both capacity and capacity48.
Kill one of them.  A nice simplification.

[I left capacity48 instead of capacity on the one hand
to remind users that it is 64 bits, and on the other hand
because that is easier to grep for. We have enough uses
of capacity already.]

Andries


diff -u --recursive --new-file -X /linux/dontdiff a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	Thu Aug  7 21:24:45 2003
+++ b/drivers/ide/ide-disk.c	Thu Aug  7 21:29:06 2003
@@ -1108,58 +1108,41 @@
 
 /*
  * See whether some part of the disk was set off as Host Protected Area.
- * If so, report this, and possible enable access to it.
+ * If so, report this, and possibly enable access to it.
  */
 static void
 do_add_hpa(ide_drive_t *drive) {
-	unsigned int capacity;
-	unsigned long set_max;
+	unsigned long long set_max;
 
-	capacity = drive->capacity;
-	set_max = idedisk_read_native_max_address(drive);
-
-	if (set_max > capacity) {
-		/* Report */
-		printk(KERN_INFO "%s: Host Protected Area detected.\n"
-		       "    current capacity is %u sectors (%u MB)\n"
-		       "    native  capacity is %lu sectors (%lu MB)\n",
-		       drive->name, capacity,
-		       (capacity - capacity/625 + 974)/1950,
-		       set_max, (set_max - set_max/625 + 974)/1950);
-#ifdef CONFIG_IDEDISK_STROKE
-		/* Raise limit */
-		set_max = idedisk_set_max_address(drive, set_max);
-		if (set_max) {
-			drive->capacity = set_max;
-			printk(KERN_INFO "%s: Host Protected Area Disabled\n",
-			       drive->name);
-		}
-#endif
-	}
-}
-
-static void
-do_add_hpa48(ide_drive_t *drive) {
-	unsigned long long set_max_ext;
+	if (idedisk_supports_lba48(drive->id))
+		set_max = idedisk_read_native_max_address_ext(drive);
+	else
+		set_max = idedisk_read_native_max_address(drive);
 
-	set_max_ext = idedisk_read_native_max_address_ext(drive);
-	if (set_max_ext > drive->capacity48) {
+	if (set_max > drive->capacity48) {
 		unsigned long long nativeMB, currentMB;
 
 		/* Report on additional space */
-		nativeMB = sectors_to_MB(set_max_ext);
+		nativeMB = sectors_to_MB(set_max);
 		currentMB = sectors_to_MB(drive->capacity48);
 		printk(KERN_INFO
 		       "%s: Host Protected Area detected.\n"
 		       "    current capacity is %llu sectors (%llu MB)\n"
 		       "    native  capacity is %llu sectors (%llu MB)\n",
 		       drive->name, drive->capacity48, currentMB,
-		       set_max_ext, nativeMB);
+		       set_max, nativeMB);
+
 #ifdef CONFIG_IDEDISK_STROKE
 		/* Raise limit */
-		set_max_ext = idedisk_set_max_address_ext(drive, set_max_ext);
-		if (set_max_ext) {
-			drive->capacity48 = set_max_ext;
+		if (idedisk_supports_lba48(drive->id)) {
+			/* (void) idedisk_read_native_max_address_ext(drive);*/
+			set_max = idedisk_set_max_address_ext(drive, set_max);
+		} else {
+			/* (void) idedisk_read_native_max_address(drive); */
+			set_max = idedisk_set_max_address(drive, set_max);
+		}
+		if (set_max) {
+			drive->capacity48 = set_max;
 			printk(KERN_INFO
 			       "%s: Host Protected Area Disabled\n",
 			       drive->name);
@@ -1169,8 +1152,7 @@
 }
 
 /*
- * Compute drive->capacity, the amount accessible with CHS/LBA commands,
- * and drive->capacity48, the amount accessible with LBA48 commands.
+ * Compute drive->capacity.
  * Also sets drive->select.b.lba.
  *
  * Called with drive->id != NULL.
@@ -1178,46 +1160,30 @@
 static void init_idedisk_capacity(ide_drive_t *drive)
 {
 	struct hd_driveid *id;
-	unsigned long capacity;
-	unsigned long long capacity48;
 
 	id = drive->id;
 
 	if (idedisk_supports_lba48(id)) {
 		/* drive speaks 48-bit LBA */
-		drive->capacity48 = capacity48 = lba48_capacity(id);
-		capacity = capacity48;		/* truncate to 32 bits */
-		if (capacity == capacity48)
-			drive->capacity = capacity;
-		else
-			drive->capacity = 0xffffffff;
+		drive->capacity48 = lba48_capacity(id);
 		drive->select.b.lba = 1;
 	} else if (idedisk_supports_lba(id) && lba_capacity_is_ok(id)) {
 		/* drive speaks 28-bit LBA */
-		drive->capacity = capacity = id->lba_capacity;
-		drive->capacity48 = 0;
+		drive->capacity48 = id->lba_capacity;
 		drive->select.b.lba = 1;
 	} else {
 		/* drive speaks CHS only */
-		capacity = drive->cyl * drive->head * drive->sect;
-		drive->capacity = capacity;
-		drive->capacity48 = 0;
+		drive->capacity48 = drive->cyl * drive->head * drive->sect;
 		drive->select.b.lba = 0;
 	}
 
-	if (idedisk_supports_host_protected_area(id)) {
-		if (idedisk_supports_lba48(id))
-			do_add_hpa48(drive);
-		else
-			do_add_hpa(drive);
-	}
+	if (idedisk_supports_host_protected_area(id))
+		do_add_hpa(drive);
 }
 
 static sector_t idedisk_capacity (ide_drive_t *drive)
 {
-	if (idedisk_supports_lba48(drive->id))
-		return (drive->capacity48 - drive->sect0);
-	return (drive->capacity - drive->sect0);
+	return (drive->capacity48 - drive->sect0);
 }
 
 static ide_startstop_t idedisk_special (ide_drive_t *drive)
diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	Wed Aug  6 23:02:38 2003
+++ b/include/linux/ide.h	Thu Aug  7 13:35:35 2003
@@ -765,7 +765,6 @@
 	unsigned int	failures;	/* current failure count */
 	unsigned int	max_failures;	/* maximum allowed failure count */
 
-	u32		capacity;	/* total number of sectors */
 	u64		capacity48;	/* total number of sectors */
 
 	int		last_lun;	/* last logical unit */
