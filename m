Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbUL1Prd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbUL1Prd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 10:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbUL1Prd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 10:47:33 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:61853 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261784AbUL1Pqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 10:46:53 -0500
Subject: PATCH: 2.6.10 - IDE CD is very noisy
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: torvalds@osdl.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-ide@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104244967.20898.81.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 28 Dec 2004 14:42:47 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ide-cd code has never been updated over the years to include printk
levels. This patch extracts the printk level updating from the -ac tree
seperated from other changes.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.10/drivers/ide/ide-cd.c linux.oldide-2.6.10/drivers/ide/ide-cd.c
--- linux.vanilla-2.6.10/drivers/ide/ide-cd.c	2004-12-25 21:15:34.000000000 +0000
+++ linux.oldide-2.6.10/drivers/ide/ide-cd.c	2004-12-28 14:59:09.411737224 +0000
@@ -456,7 +456,7 @@
 				s = "(reserved error code)";
 		}
 
-		printk("  %s -- (asc=0x%02x, ascq=0x%02x)\n",
+		printk(KERN_ERR "  %s -- (asc=0x%02x, ascq=0x%02x)\n",
 			s, sense->asc, sense->ascq);
 
 		if (failed_command != NULL) {
@@ -478,7 +478,7 @@
 					lo = mid+1;
 			}
 
-			printk ("  The failed \"%s\" packet command was: \n  \"", s);
+			printk (KERN_ERR "  The failed \"%s\" packet command was: \n  \"", s);
 			for (i=0; i<sizeof (failed_command->cmd); i++)
 				printk ("%02x ", failed_command->cmd[i]);
 			printk ("\"\n");
@@ -491,13 +491,13 @@
 		 */
 		if (sense->sense_key == NOT_READY && (sense->sks[0] & 0x80)) {
 			int progress = (sense->sks[1] << 8 | sense->sks[2]) * 100;
-			printk("  Command is %02d%% complete\n", progress / 0xffff);
+			printk(KERN_ERR "  Command is %02d%% complete\n", progress / 0xffff);
 
 		}
 
 		if (sense->sense_key == ILLEGAL_REQUEST &&
 		    (sense->sks[0] & 0x80) != 0) {
-			printk("  Error in %s byte %d",
+			printk(KERN_ERR "  Error in %s byte %d",
 				(sense->sks[0] & 0x40) != 0 ?
 				"command packet" : "command data",
 				(sense->sks[1] << 8) + sense->sks[2]);
@@ -518,8 +518,8 @@
 	    (sense->sense_key == NOT_READY && (sense->asc == 4 ||
 						sense->asc == 0x3a)))
 		return;
-
-	printk("%s: error code: 0x%02x  sense_key: 0x%02x  asc: 0x%02x  ascq: 0x%02x\n",
+		
+	printk(KERN_ERR "%s: error code: 0x%02x  sense_key: 0x%02x  asc: 0x%02x  ascq: 0x%02x\n",
 		drive->name,
 		sense->error_code, sense->sense_key,
 		sense->asc, sense->ascq);
@@ -1014,7 +1014,7 @@
 		return 0;
 	else if (ireason == 0) {
 		/* Whoops... The drive is expecting to receive data from us! */
-		printk("%s: read_intr: Drive wants to transfer data the "
+		printk(KERN_ERR "%s: read_intr: Drive wants to transfer data the "
 						"wrong way!\n", drive->name);
 
 		/* Throw some data at the drive so it doesn't hang
@@ -1032,7 +1032,7 @@
 		return 0;
 	} else {
 		/* Drive wants a command packet, or invalid ireason... */
-		printk("%s: read_intr: bad interrupt reason %x\n", drive->name,
+		printk(KERN_ERR "%s: read_intr: bad interrupt reason %x\n", drive->name,
 								ireason);
 	}
 
@@ -1085,7 +1085,7 @@
 		/* If we're not done filling the current buffer, complain.
 		   Otherwise, complete the command normally. */
 		if (rq->current_nr_sectors > 0) {
-			printk ("%s: cdrom_read_intr: data underrun (%d blocks)\n",
+			printk (KERN_ERR "%s: cdrom_read_intr: data underrun (%d blocks)\n",
 				drive->name, rq->current_nr_sectors);
 			rq->flags |= REQ_FAILED;
 			cdrom_end_request(drive, 0);
@@ -1102,12 +1102,12 @@
 	   of at least SECTOR_SIZE, as it gets hairy to keep track
 	   of the transfers otherwise. */
 	if ((len % SECTOR_SIZE) != 0) {
-		printk ("%s: cdrom_read_intr: Bad transfer size %d\n",
+		printk (KERN_ERR "%s: cdrom_read_intr: Bad transfer size %d\n",
 			drive->name, len);
 		if (CDROM_CONFIG_FLAGS(drive)->limit_nframes)
-			printk ("  This drive is not supported by this version of the driver\n");
+			printk (KERN_ERR "  This drive is not supported by this version of the driver\n");
 		else {
-			printk ("  Trying to limit transfer sizes\n");
+			printk (KERN_ERR "  Trying to limit transfer sizes\n");
 			CDROM_CONFIG_FLAGS(drive)->limit_nframes = 1;
 		}
 		cdrom_end_request(drive, 0);
@@ -1221,7 +1221,7 @@
 	   paranoid and check. */
 	if (rq->current_nr_sectors < bio_cur_sectors(rq->bio) &&
 	    (rq->sector & (sectors_per_frame - 1))) {
-		printk("%s: cdrom_read_from_buffer: buffer botch (%ld)\n",
+		printk(KERN_ERR "%s: cdrom_read_from_buffer: buffer botch (%ld)\n",
 			drive->name, (long)rq->sector);
 		cdrom_end_request(drive, 0);
 		return -1;
@@ -1256,7 +1256,7 @@
 		/* Sanity check... */
 		if (rq->current_nr_sectors != bio_cur_sectors(rq->bio) &&
 			(rq->sector & (sectors_per_frame - 1))) {
-			printk ("%s: cdrom_start_read_continuation: buffer botch (%u)\n",
+			printk(KERN_ERR "%s: cdrom_start_read_continuation: buffer botch (%u)\n",
 				drive->name, rq->current_nr_sectors);
 			cdrom_end_request(drive, 0);
 			return ide_stopped;
@@ -1481,7 +1481,7 @@
 			rq->sense_len += thislen;
 	} else {
 confused:
-		printk ("%s: cdrom_pc_intr: The drive "
+		printk (KERN_ERR "%s: cdrom_pc_intr: The drive "
 			"appears confused (ireason = 0x%02x)\n",
 			drive->name, ireason);
 		rq->flags |= REQ_FAILED;
@@ -1595,7 +1595,7 @@
 		return 0;
 	else if (ireason == 2) {
 		/* Whoops... The drive wants to send data. */
-		printk("%s: write_intr: wrong transfer direction!\n",
+		printk(KERN_ERR "%s: write_intr: wrong transfer direction!\n",
 							drive->name);
 
 		while (len > 0) {
@@ -1605,7 +1605,7 @@
 		}
 	} else {
 		/* Drive wants a command packet, or invalid ireason... */
-		printk("%s: write_intr: bad interrupt reason %x\n",
+		printk(KERN_ERR "%s: write_intr: bad interrupt reason %x\n",
 							drive->name, ireason);
 	}
 
@@ -1671,7 +1671,7 @@
 	 */
 	if (dma) {
 		if (dma_error) {
-			printk("ide-cd: dma error\n");
+			printk(KERN_ERR "ide-cd: dma error\n");
 			__ide_dma_off(drive);
 			return DRIVER(drive)->error(drive, "dma error", stat);
 		}
@@ -1736,7 +1736,7 @@
 		}
 
 		if (!ptr) {
-			printk("%s: confused, missing data\n", drive->name);
+			printk(KERN_ERR "%s: confused, missing data\n", drive->name);
 			break;
 		}
 
@@ -1798,7 +1798,7 @@
 	if (dma) {
 		info->dma = 0;
 		if ((dma_error = HWIF(drive)->ide_dma_end(drive))) {
-			printk("ide-cd: write dma error\n");
+			printk(KERN_ERR "ide-cd: write dma error\n");
 			__ide_dma_off(drive);
 		}
 	}
@@ -1831,7 +1831,7 @@
 		 */
 		uptodate = 1;
 		if (rq->current_nr_sectors > 0) {
-			printk("%s: write_intr: data underrun (%d blocks)\n",
+			printk(KERN_ERR "%s: write_intr: data underrun (%d blocks)\n",
 			drive->name, rq->current_nr_sectors);
 			uptodate = 0;
 		}
@@ -1852,7 +1852,7 @@
 		int this_transfer;
 
 		if (!rq->current_nr_sectors) {
-			printk("ide-cd: write_intr: oops\n");
+			printk(KERN_ERR "ide-cd: write_intr: oops\n");
 			break;
 		}
 
@@ -1998,7 +1998,7 @@
 					ide_stall_queue(drive, IDECD_SEEK_TIMER);
 					return ide_stopped;
 				}
-				printk ("%s: DSC timeout\n", drive->name);
+				printk (KERN_ERR "%s: DSC timeout\n", drive->name);
 			}
 			CDROM_CONFIG_FLAGS(drive)->seeking = 0;
 		}
@@ -2134,7 +2134,7 @@
 	if (stat != 0 &&
 	    sense->sense_key == ILLEGAL_REQUEST &&
 	    (sense->asc == 0x24 || sense->asc == 0x20)) {
-		printk ("%s: door locking not supported\n",
+		printk (KERN_ERR "%s: door locking not supported\n",
 			drive->name);
 		CDROM_CONFIG_FLAGS(drive)->no_doorlock = 1;
 		stat = 0;
@@ -2252,7 +2252,7 @@
 						    GFP_KERNEL);
 		info->toc = toc;
 		if (toc == NULL) {
-			printk ("%s: No cdrom TOC buffer!\n", drive->name);
+			printk (KERN_ERR "%s: No cdrom TOC buffer!\n", drive->name);
 			return -ENOMEM;
 		}
 	}
@@ -2939,7 +2939,7 @@
 	if (drive->media == ide_optical) {
 		CDROM_CONFIG_FLAGS(drive)->mo_drive = 1;
 		CDROM_CONFIG_FLAGS(drive)->ram = 1;
-		printk("%s: ATAPI magneto-optical drive\n", drive->name);
+		printk(KERN_ERR "%s: ATAPI magneto-optical drive\n", drive->name);
 		return nslots;
 	}
 
@@ -3029,7 +3029,7 @@
 
 	/* don't print speed if the drive reported 0.
 	 */
-	printk("%s: ATAPI", drive->name);
+	printk(KERN_INFO "%s: ATAPI", drive->name);
 	if (CDROM_CONFIG_FLAGS(drive)->max_speed)
 		printk(" %dX", CDROM_CONFIG_FLAGS(drive)->max_speed);
 	printk(" %s", CDROM_CONFIG_FLAGS(drive)->dvd ? "DVD-ROM" : "CD-ROM");
@@ -3272,7 +3272,7 @@
 #endif
 
 	if (ide_cdrom_register(drive, nslots)) {
-		printk ("%s: ide_cdrom_setup failed to register device with the cdrom driver.\n", drive->name);
+		printk (KERN_ERR "%s: ide_cdrom_setup failed to register device with the cdrom driver.\n", drive->name);
 		info->devinfo.handle = NULL;
 		return 1;
 	}
@@ -3299,7 +3299,7 @@
 	struct gendisk *g = drive->disk;
 
 	if (ide_unregister_subdriver(drive)) {
-		printk("%s: %s: failed to ide_unregister_subdriver\n",
+		printk(KERN_ERR "%s: %s: failed to ide_unregister_subdriver\n",
 			__FUNCTION__, drive->name);
 		return 1;
 	}
@@ -3310,7 +3310,7 @@
 	if (info->changer_info != NULL)
 		kfree(info->changer_info);
 	if (devinfo->handle == drive && unregister_cdrom(devinfo))
-		printk("%s: ide_cdrom_cleanup failed to unregister device from the cdrom driver.\n", drive->name);
+		printk(KERN_ERR "%s: ide_cdrom_cleanup failed to unregister device from the cdrom driver.\n", drive->name);
 	kfree(info);
 	drive->driver_data = NULL;
 	blk_queue_prep_rq(drive->queue, NULL);
@@ -3462,21 +3462,21 @@
 	/* skip drives that we were told to ignore */
 	if (ignore != NULL) {
 		if (strstr(ignore, drive->name)) {
-			printk("ide-cd: ignoring drive %s\n", drive->name);
+			printk(KERN_INFO "ide-cd: ignoring drive %s\n", drive->name);
 			goto failed;
 		}
 	}
 	if (drive->scsi) {
-		printk("ide-cd: passing drive %s to ide-scsi emulation.\n", drive->name);
+		printk(KERN_INFO "ide-cd: passing drive %s to ide-scsi emulation.\n", drive->name);
 		goto failed;
 	}
 	info = (struct cdrom_info *) kmalloc (sizeof (struct cdrom_info), GFP_KERNEL);
 	if (info == NULL) {
-		printk("%s: Can't allocate a cdrom structure\n", drive->name);
+		printk(KERN_ERR "%s: Can't allocate a cdrom structure\n", drive->name);
 		goto failed;
 	}
 	if (ide_register_subdriver(drive, &ide_cdrom_driver)) {
-		printk("%s: Failed to register the driver with ide.c\n",
+		printk(KERN_ERR "%s: Failed to register the driver with ide.c\n",
 			drive->name);
 		kfree(info);
 		goto failed;
@@ -3500,7 +3500,7 @@
 		if (info->changer_info != NULL)
 			kfree(info->changer_info);
 		if (devinfo->handle == drive && unregister_cdrom(devinfo))
-			printk ("%s: ide_cdrom_cleanup failed to unregister device from the cdrom driver.\n", drive->name);
+			printk (KERN_ERR "%s: ide_cdrom_cleanup failed to unregister device from the cdrom driver.\n", drive->name);
 		kfree(info);
 		drive->driver_data = NULL;
 		goto failed;

