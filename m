Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271353AbTHDBXN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 21:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271355AbTHDBXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 21:23:13 -0400
Received: from hera.cwi.nl ([192.16.191.8]:19407 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S271353AbTHDBXG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 21:23:06 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 4 Aug 2003 03:23:01 +0200 (MEST)
Message-Id: <UTC200308040123.h741N1311674.aeb@smtp.cwi.nl>
To: akpm@osdl.org, torvalds@osdl.org
Subject: [PATCH] ide capacity
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is already nine months ago that I first had to provide people
with a patch that made the boot messages report disk capacity
in 32 bits instead of 31.
No doubt 2.6 will last long enough to make disk capacity
(for RAIDs at least) pass the 2^32 sectors. Probably we
should keep track of disk capacities in sector_t instead of long.

Andries

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
--- a/drivers/ide/ide-cd.c	Mon Jul 28 05:39:23 2003
+++ b/drivers/ide/ide-cd.c	Mon Aug  4 03:44:18 2003
@@ -3228,7 +3228,7 @@
 }
 
 static
-unsigned long ide_cdrom_capacity (ide_drive_t *drive)
+sector_t ide_cdrom_capacity (ide_drive_t *drive)
 {
 	unsigned long capacity;
 
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	Mon Jul 28 05:39:23 2003
+++ b/drivers/ide/ide-disk.c	Mon Aug  4 04:02:21 2003
@@ -1065,6 +1065,13 @@
 
 #endif /* CONFIG_IDEDISK_STROKE */
 
+static unsigned long long
+sectors_to_MB(unsigned long long n) {
+	n <<= 9;			/* make it bytes */
+	do_div(n, 1000000);	 /* make it MB */
+	return n;
+}
+
 /*
  * Tests if the drive supports Host Protected Area feature.
  * Returns true if supported, false otherwise.
@@ -1165,7 +1172,7 @@
 	}
 }
 
-static unsigned long idedisk_capacity (ide_drive_t *drive)
+static sector_t idedisk_capacity (ide_drive_t *drive)
 {
 	if (drive->id->cfs_enable_2 & 0x0400)
 		return (drive->capacity48 - drive->sect0);
@@ -1564,7 +1571,7 @@
 static void idedisk_setup (ide_drive_t *drive)
 {
 	struct hd_driveid *id = drive->id;
-	unsigned long capacity;
+	unsigned long long capacity;
 
 	idedisk_add_settings(drive);
 
@@ -1628,14 +1635,23 @@
 	 * by correcting bios_cyls:
 	 */
 	capacity = idedisk_capacity (drive);
-	if ((capacity >= (drive->bios_cyl * drive->bios_sect * drive->bios_head)) &&
-	    (!drive->forced_geom) && drive->bios_sect && drive->bios_head)
-		drive->bios_cyl = (capacity / drive->bios_sect) / drive->bios_head;
-	printk (KERN_INFO "%s: %ld sectors", drive->name, capacity);
-
-	/* Give size in megabytes (MB), not mebibytes (MiB). */
-	/* We compute the exact rounded value, avoiding overflow. */
-	printk (" (%ld MB)", (capacity - capacity/625 + 974)/1950);
+	if (!drive->forced_geom && drive->bios_sect && drive->bios_head) {
+		unsigned int cap0 = capacity;   /* truncate to 32 bits */
+		unsigned int cylsz, cyl;
+
+		if (cap0 != capacity)
+			drive->bios_cyl = 65535;
+		else {
+			cylsz = drive->bios_sect * drive->bios_head;
+			cyl = cap0 / cylsz;
+			if (cyl > 65535)
+				cyl = 65535;
+			if (cyl > drive->bios_cyl)
+				drive->bios_cyl = cyl;
+		}
+	}
+	printk(KERN_INFO "%s: %llu sectors (%llu MB)",
+	       drive->name, capacity, sectors_to_MB(capacity));
 
 	/* Only print cache size when it was specified */
 	if (id->buf_size)
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
--- a/drivers/ide/ide-floppy.c	Sun Jun 15 01:40:55 2003
+++ b/drivers/ide/ide-floppy.c	Mon Aug  4 03:41:20 2003
@@ -1626,7 +1626,7 @@
 /*
  *	Return the current floppy capacity to ide.c.
  */
-static unsigned long idefloppy_capacity (ide_drive_t *drive)
+static sector_t idefloppy_capacity (ide_drive_t *drive)
 {
 	idefloppy_floppy_t *floppy = drive->driver_data;
 	unsigned long capacity = floppy->blocks * floppy->bs_factor;
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	Thu Jul  3 09:26:43 2003
+++ b/drivers/ide/ide.c	Mon Aug  4 03:45:37 2003
@@ -351,7 +351,7 @@
  * current_capacity() returns the capacity (in sectors) of a drive
  * according to its current geometry/LBA settings.
  */
-unsigned long current_capacity (ide_drive_t *drive)
+sector_t current_capacity (ide_drive_t *drive)
 {
 	if (!drive->present)
 		return 0;
@@ -2391,7 +2391,7 @@
 {
 }
 
-static unsigned long default_capacity (ide_drive_t *drive)
+static sector_t default_capacity (ide_drive_t *drive)
 {
 	return 0x7fffffff;
 }
diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	Mon Jul 28 05:39:35 2003
+++ b/include/linux/ide.h	Mon Aug  4 03:48:04 2003
@@ -1225,7 +1225,7 @@
 	ide_startstop_t	(*abort)(ide_drive_t *, const char *);
 	int		(*ioctl)(ide_drive_t *, struct inode *, struct file *, unsigned int, unsigned long);
 	void		(*pre_reset)(ide_drive_t *);
-	unsigned long	(*capacity)(ide_drive_t *);
+	sector_t	(*capacity)(ide_drive_t *);
 	ide_startstop_t	(*special)(ide_drive_t *);
 	ide_proc_entry_t	*proc;
 	int		(*attach)(ide_drive_t *);
@@ -1358,7 +1358,7 @@
 /*
  * Return the current idea about the total capacity of this drive.
  */
-extern unsigned long current_capacity (ide_drive_t *drive);
+extern sector_t current_capacity (ide_drive_t *drive);
 
 /*
  * Start a reset operation for an IDE interface.
