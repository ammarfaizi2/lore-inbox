Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263840AbTCUUKZ>; Fri, 21 Mar 2003 15:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263972AbTCUUJg>; Fri, 21 Mar 2003 15:09:36 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:57988
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263840AbTCUTbF>; Fri, 21 Mar 2003 14:31:05 -0500
Date: Fri, 21 Mar 2003 20:46:20 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212046.h2LKkKrW026479@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: update ide-disk to changes, remove all the driver ifs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/ide-disk.c linux-2.5.65-ac2/drivers/ide/ide-disk.c
--- linux-2.5.65/drivers/ide/ide-disk.c	2003-03-18 16:46:48.000000000 +0000
+++ linux-2.5.65-ac2/drivers/ide/ide-disk.c	2003-03-07 17:56:17.000000000 +0000
@@ -1,11 +1,10 @@
 /*
- *  linux/drivers/ide/ide-disk.c	Version 1.16	April 7, 2002
+ *  linux/drivers/ide/ide-disk.c	Version 1.18	Mar 05, 2003
  *
+ *  Copyright (C) 1994-1998  Linus Torvalds & authors (see below)
  *  Copyright (C) 1998-2002  Linux ATA Developemt
  *				Andre Hedrick <andre@linux-ide.org>
- *
- *
- *  Copyright (C) 1994-1998  Linus Torvalds & authors (see below)
+ *  Copyright (C) 2003	     Red Hat <alan@redhat.com>
  */
 
 /*
@@ -42,7 +41,7 @@
  *			fix wcache setup.
  */
 
-#define IDEDISK_VERSION	"1.17"
+#define IDEDISK_VERSION	"1.18"
 
 #undef REALLY_SLOW_IO		/* most systems can safely undef this */
 
@@ -154,8 +153,6 @@
 			return DRIVER(drive)->error(drive, "read_intr", stat);
 		}
 		/* no data yet, so wait for another interrupt */
-		if (HWGROUP(drive)->handler != NULL)
-			BUG();
 		ide_set_handler(drive, &read_intr, WAIT_CMD, NULL);
 		return ide_started;
 	}
@@ -189,8 +186,6 @@
 	if (i > 0) {
 		if (msect)
 			goto read_next;
-		if (HWGROUP(drive)->handler != NULL)
-			BUG();
 		ide_set_handler(drive, &read_intr, WAIT_CMD, NULL);
                 return ide_started;
 	}
@@ -230,8 +225,6 @@
 				char *to = ide_map_buffer(rq, &flags);
 				taskfile_output_data(drive, to, SECTOR_WORDS);
 				ide_unmap_buffer(rq, to, &flags);
-				if (HWGROUP(drive)->handler != NULL)
-					BUG();
 				ide_set_handler(drive, &write_intr, WAIT_CMD, NULL);
                                 return ide_started;
 			}
@@ -332,8 +325,6 @@
 			if (rq->nr_sectors) {
 				if (ide_multwrite(drive, drive->mult_count))
 					return ide_stopped;
-				if (HWGROUP(drive)->handler != NULL)
-					BUG();
 				ide_set_handler(drive, &multwrite_intr, WAIT_CMD, NULL);
 				return ide_started;
 			}
@@ -550,8 +541,6 @@
 	 * MAJOR DATA INTEGRITY BUG !!! only if we error 
 	 */
 			hwgroup->wrq = *rq; /* scratchpad */
-			if (HWGROUP(drive)->handler != NULL)
-				BUG();
 			ide_set_handler(drive, &multwrite_intr, WAIT_CMD, NULL);
 			if (ide_multwrite(drive, drive->mult_count)) {
 				unsigned long flags;
@@ -564,8 +553,6 @@
 		} else {
 			unsigned long flags;
 			char *to = ide_map_buffer(rq, &flags);
-			if (HWGROUP(drive)->handler != NULL)
-				BUG();
 			ide_set_handler(drive, &write_intr, WAIT_CMD, NULL);
 			taskfile_output_data(drive, to, SECTOR_WORDS);
 			ide_unmap_buffer(rq, to, &flags);
@@ -941,6 +928,26 @@
 	return ide_stopped;
 }
 
+ide_startstop_t idedisk_abort(ide_drive_t *drive, const char *msg)
+{
+	ide_hwif_t *hwif;
+	struct request *rq;
+
+	if (drive == NULL || (rq = HWGROUP(drive)->rq) == NULL)
+		return ide_stopped;
+
+	hwif = HWIF(drive);
+
+	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK | REQ_DRIVE_TASKFILE)) {
+		rq->errors = 1;
+		ide_end_drive_cmd(drive, BUSY_STAT, 0);
+		return ide_stopped;
+	}
+
+	DRIVER(drive)->end_request(drive, 0, 0);
+	return ide_stopped;
+}
+
 /*
  * Queries for true maximum capacity of the drive.
  * Returns maximum LBA address (> 0) of the drive, 0 if failed.
@@ -1073,7 +1080,7 @@
 {
 	int flag = (drive->id->cfs_enable_1 & 0x0400) ? 1 : 0;
 	if (flag)
-		printk("%s: host protected area => %d\n", drive->name, flag);
+		printk(KERN_INFO "%s: host protected area => %d\n", drive->name, flag);
 	return flag;
 }
 
@@ -1201,7 +1208,7 @@
 		}
 	} else if (s->b.set_multmode) {
 		s->b.set_multmode = 0;
-		if (drive->id && drive->mult_req > drive->id->max_multsect)
+		if (drive->mult_req > drive->id->max_multsect)
 			drive->mult_req = drive->id->max_multsect;
 		if (!IS_PDC4030_DRIVE) {
 			ide_task_t args;
@@ -1286,7 +1293,7 @@
 	char		*out = page;
 	int		len;
 
-	if (drive->id)
+	if (drive->id_read)
 		len = sprintf(out,"%i\n", drive->id->buf_size / 2);
 	else
 		len = sprintf(out,"(none)\n");
@@ -1549,7 +1556,7 @@
 	
 	idedisk_add_settings(drive);
 
-	if (id == NULL)
+	if (drive->id_read == 0)
 		return;
 
 	/*
@@ -1666,6 +1673,7 @@
 	.do_request		= do_rw_disk,
 	.sense			= idedisk_dump_status,
 	.error			= idedisk_error,
+	.abort			= idedisk_abort,
 	.pre_reset		= idedisk_pre_reset,
 	.capacity		= idedisk_capacity,
 	.special		= idedisk_special,
