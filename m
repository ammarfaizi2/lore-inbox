Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263857AbTCUTc1>; Fri, 21 Mar 2003 14:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263856AbTCUTcG>; Fri, 21 Mar 2003 14:32:06 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:57220
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263842AbTCUTai>; Fri, 21 Mar 2003 14:30:38 -0500
Date: Fri, 21 Mar 2003 20:45:54 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212045.h2LKjsJF026473@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: update ide-cd to new changes, add abort() handlers
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/ide-cd.c linux-2.5.65-ac2/drivers/ide/ide-cd.c
--- linux-2.5.65/drivers/ide/ide-cd.c	2003-03-06 17:04:26.000000000 +0000
+++ linux-2.5.65-ac2/drivers/ide/ide-cd.c	2003-03-14 00:49:24.000000000 +0000
@@ -294,7 +294,7 @@
  *
  *************************************************************************/
  
-#define IDECD_VERSION "4.59"
+#define IDECD_VERSION "4.59-ac1"
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -635,6 +635,23 @@
 	return ide_stopped;
 }
 
+ide_startstop_t ide_cdrom_abort (ide_drive_t *drive, const char *msg)
+{
+	struct request *rq;
+
+	if (drive == NULL || (rq = HWGROUP(drive)->rq) == NULL)
+		return ide_stopped;
+	/* retry only "normal" I/O: */
+	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK)) {
+		rq->errors = 1;
+		ide_end_drive_cmd(drive, BUSY_STAT, 0);
+		return ide_stopped;
+	}
+	rq->errors |= ERROR_RESET;
+	DRIVER(drive)->end_request(drive, 0, 0);
+	return ide_stopped;
+}
+
 static void cdrom_end_request (ide_drive_t *drive, int uptodate)
 {
 	struct request *rq = HWGROUP(drive)->rq;
@@ -899,9 +916,6 @@
 			return startstop;
 	}
 
-	if (HWGROUP(drive)->handler != NULL)	/* paranoia check */
-		BUG();
-
 	/* Arm the interrupt handler. */
 	ide_set_handler(drive, handler, rq->timeout, cdrom_timer_expiry);
 
@@ -1133,9 +1147,6 @@
 		}
 	}
 
-	if (HWGROUP(drive)->handler != NULL)    /* paranoia check */
-		BUG();
-
 	/* Done moving data!  Wait for another interrupt. */
 	ide_set_handler(drive, &cdrom_read_intr, WAIT_CMD, NULL);
 	return ide_started;
@@ -1470,9 +1481,6 @@
 		rq->flags |= REQ_FAILED;
 	}
 
-	if (HWGROUP(drive)->handler != NULL)
-		BUG();
-
 	/* Now we wait for another interrupt. */
 	ide_set_handler(drive, &cdrom_pc_intr, WAIT_CMD, cdrom_timer_expiry);
 	return ide_started;
@@ -1863,9 +1871,6 @@
 			cdrom_end_request(drive, 1);
 	}
 
-	if (HWGROUP(drive)->handler != NULL)	/* paranoia check */
-		BUG();
-
 	/* re-arm handler */
 	ide_set_handler(drive, &cdrom_write_intr, 5 * WAIT_CMD, NULL);
 	return ide_started;
@@ -2837,11 +2842,9 @@
 	 * ACER50 (and others?) require the full spec length mode sense
 	 * page capabilities size, but older drives break.
 	 */
-	if (drive->id) {
-		if (!(!strcmp(drive->id->model, "ATAPI CD ROM DRIVE 50X MAX") ||
-		    !strcmp(drive->id->model, "WPI CDS-32X")))
-			size -= sizeof(cap->pad);
-	}
+	if (!(!strcmp(drive->id->model, "ATAPI CD ROM DRIVE 50X MAX") ||
+	    !strcmp(drive->id->model, "WPI CDS-32X")))
+		size -= sizeof(cap->pad);
 
 	/* we have to cheat a little here. the packet will eventually
 	 * be queued with ide_cdrom_packet(), which extracts the
@@ -2924,7 +2927,7 @@
 	}
 
 	/* The ACER/AOpen 24X cdrom has the speed fields byte-swapped */
-	if (drive->id && !drive->id->model[0] &&
+	if (!drive->id->model[0] &&
 	    !strncmp(drive->id->fw_rev, "241N", 4)) {
 		CDROM_STATE_FLAGS(drive)->current_speed  = 
 			(((unsigned int)cap.curspeed) + (176/2)) / 176;
@@ -3089,12 +3092,7 @@
 	CDROM_CONFIG_FLAGS(drive)->no_doorlock = 0;
 #endif
 
-	if (drive->id != NULL)
-		CDROM_CONFIG_FLAGS(drive)->drq_interrupt =
-			((drive->id->config & 0x0060) == 0x20);
-	else
-		CDROM_CONFIG_FLAGS(drive)->drq_interrupt = 0;
-
+	CDROM_CONFIG_FLAGS(drive)->drq_interrupt = ((drive->id->config & 0x0060) == 0x20);
 	CDROM_CONFIG_FLAGS(drive)->is_changer = 0;
 	CDROM_CONFIG_FLAGS(drive)->cd_r = 0;
 	CDROM_CONFIG_FLAGS(drive)->cd_rw = 0;
@@ -3109,16 +3107,14 @@
 	
 	/* limit transfer size per interrupt. */
 	CDROM_CONFIG_FLAGS(drive)->limit_nframes = 0;
-	if (drive->id != NULL) {
-		/* a testament to the nice quality of Samsung drives... */
-		if (!strcmp(drive->id->model, "SAMSUNG CD-ROM SCR-2430"))
-			CDROM_CONFIG_FLAGS(drive)->limit_nframes = 1;
-		else if (!strcmp(drive->id->model, "SAMSUNG CD-ROM SCR-2432"))
-			CDROM_CONFIG_FLAGS(drive)->limit_nframes = 1;
-		/* the 3231 model does not support the SET_CD_SPEED command */
-		else if (!strcmp(drive->id->model, "SAMSUNG CD-ROM SCR-3231"))
-			cdi->mask |= CDC_SELECT_SPEED;
-	}
+	/* a testament to the nice quality of Samsung drives... */
+	if (!strcmp(drive->id->model, "SAMSUNG CD-ROM SCR-2430"))
+		CDROM_CONFIG_FLAGS(drive)->limit_nframes = 1;
+	else if (!strcmp(drive->id->model, "SAMSUNG CD-ROM SCR-2432"))
+		CDROM_CONFIG_FLAGS(drive)->limit_nframes = 1;
+	/* the 3231 model does not support the SET_CD_SPEED command */
+	else if (!strcmp(drive->id->model, "SAMSUNG CD-ROM SCR-3231"))
+		cdi->mask |= CDC_SELECT_SPEED;
 
 #if ! STANDARD_ATAPI
 	/* by default Sanyo 3 CD changer support is turned off and
@@ -3131,55 +3127,47 @@
 	CDROM_CONFIG_FLAGS(drive)->playmsf_as_bcd = 0;
 	CDROM_CONFIG_FLAGS(drive)->subchan_as_bcd = 0;
 
-	if (drive->id != NULL) {
-		if (strcmp (drive->id->model, "V003S0DS") == 0 &&
-		    drive->id->fw_rev[4] == '1' &&
-		    drive->id->fw_rev[6] <= '2') {
-			/* Vertos 300.
-			   Some versions of this drive like to talk BCD. */
-			CDROM_CONFIG_FLAGS(drive)->toctracks_as_bcd = 1;
-			CDROM_CONFIG_FLAGS(drive)->tocaddr_as_bcd = 1;
-			CDROM_CONFIG_FLAGS(drive)->playmsf_as_bcd = 1;
-			CDROM_CONFIG_FLAGS(drive)->subchan_as_bcd = 1;
-		}
-
-		else if (strcmp (drive->id->model, "V006E0DS") == 0 &&
-		    drive->id->fw_rev[4] == '1' &&
-		    drive->id->fw_rev[6] <= '2') {
-			/* Vertos 600 ESD. */
-			CDROM_CONFIG_FLAGS(drive)->toctracks_as_bcd = 1;
-		}
-
-		else if (strcmp(drive->id->model,
-				 "NEC CD-ROM DRIVE:260") == 0 &&
-			 strncmp(drive->id->fw_rev, "1.01", 4) == 0) { /* FIXME */
-			/* Old NEC260 (not R).
-			   This drive was released before the 1.2 version
-			   of the spec. */
-			CDROM_CONFIG_FLAGS(drive)->tocaddr_as_bcd = 1;
-			CDROM_CONFIG_FLAGS(drive)->playmsf_as_bcd = 1;
-			CDROM_CONFIG_FLAGS(drive)->subchan_as_bcd = 1;
-			CDROM_CONFIG_FLAGS(drive)->nec260         = 1;
-		}
-
-		else if (strcmp(drive->id->model, "WEARNES CDD-120") == 0 &&
-			 strncmp(drive->id->fw_rev, "A1.1", 4) == 0) { /* FIXME */
-			/* Wearnes */
-			CDROM_CONFIG_FLAGS(drive)->playmsf_as_bcd = 1;
-			CDROM_CONFIG_FLAGS(drive)->subchan_as_bcd = 1;
-		}
-
-                /* Sanyo 3 CD changer uses a non-standard command
-                    for CD changing */
-                 else if ((strcmp(drive->id->model, "CD-ROM CDR-C3 G") == 0) ||
-                         (strcmp(drive->id->model, "CD-ROM CDR-C3G") == 0) ||
-                         (strcmp(drive->id->model, "CD-ROM CDR_C36") == 0)) {
-                        /* uses CD in slot 0 when value is set to 3 */
-                        cdi->sanyo_slot = 3;
-                }
-
-
-	}
+	if (strcmp (drive->id->model, "V003S0DS") == 0 &&
+	    drive->id->fw_rev[4] == '1' &&
+	    drive->id->fw_rev[6] <= '2') {
+		/* Vertos 300.
+		   Some versions of this drive like to talk BCD. */
+		CDROM_CONFIG_FLAGS(drive)->toctracks_as_bcd = 1;
+		CDROM_CONFIG_FLAGS(drive)->tocaddr_as_bcd = 1;
+		CDROM_CONFIG_FLAGS(drive)->playmsf_as_bcd = 1;
+		CDROM_CONFIG_FLAGS(drive)->subchan_as_bcd = 1;
+	}
+
+	else if (strcmp (drive->id->model, "V006E0DS") == 0 &&
+	    drive->id->fw_rev[4] == '1' &&
+	    drive->id->fw_rev[6] <= '2') {
+		/* Vertos 600 ESD. */
+		CDROM_CONFIG_FLAGS(drive)->toctracks_as_bcd = 1;
+	}
+	else if (strcmp(drive->id->model, "NEC CD-ROM DRIVE:260") == 0 &&
+		 strncmp(drive->id->fw_rev, "1.01", 4) == 0) { /* FIXME */
+		/* Old NEC260 (not R).
+		   This drive was released before the 1.2 version
+		   of the spec. */
+		CDROM_CONFIG_FLAGS(drive)->tocaddr_as_bcd = 1;
+		CDROM_CONFIG_FLAGS(drive)->playmsf_as_bcd = 1;
+		CDROM_CONFIG_FLAGS(drive)->subchan_as_bcd = 1;
+		CDROM_CONFIG_FLAGS(drive)->nec260         = 1;
+	}
+	else if (strcmp(drive->id->model, "WEARNES CDD-120") == 0 &&
+		 strncmp(drive->id->fw_rev, "A1.1", 4) == 0) { /* FIXME */
+		/* Wearnes */
+		CDROM_CONFIG_FLAGS(drive)->playmsf_as_bcd = 1;
+		CDROM_CONFIG_FLAGS(drive)->subchan_as_bcd = 1;
+	}
+        /* Sanyo 3 CD changer uses a non-standard command
+           for CD changing */
+        else if ((strcmp(drive->id->model, "CD-ROM CDR-C3 G") == 0) ||
+                 (strcmp(drive->id->model, "CD-ROM CDR-C3G") == 0) ||
+                 (strcmp(drive->id->model, "CD-ROM CDR_C36") == 0)) {
+                 /* uses CD in slot 0 when value is set to 3 */
+                 cdi->sanyo_slot = 3;
+        }
 #endif /* not STANDARD_ATAPI */
 
 	info->toc		= NULL;
@@ -3246,6 +3234,7 @@
 		printk("%s: ide_cdrom_cleanup failed to unregister device from the cdrom driver.\n", drive->name);
 	kfree(info);
 	drive->driver_data = NULL;
+	blk_queue_prep_rq(&drive->queue, NULL);
 	del_gendisk(g);
 	g->fops = ide_fops;
 	return 0;
@@ -3265,6 +3254,7 @@
 	.do_request		= ide_do_rw_cdrom,
 	.sense			= ide_cdrom_dump_status,
 	.error			= ide_cdrom_error,
+	.abort			= ide_cdrom_abort,
 	.capacity		= ide_cdrom_capacity,
 	.attach			= ide_cdrom_attach,
 	.drives			= LIST_HEAD_INIT(ide_cdrom_driver.drives),
