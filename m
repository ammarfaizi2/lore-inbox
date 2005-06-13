Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261515AbVFMWlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbVFMWlE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 18:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVFMWjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 18:39:12 -0400
Received: from mf00.sitadelle.com ([212.94.174.79]:58152 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S261515AbVFMWdd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 18:33:33 -0400
Message-ID: <42AE09BB.2090201@tremplin-utc.net>
Date: Tue, 14 Jun 2005 00:33:31 +0200
From: Eric Piel <Eric.Piel@tremplin-utc.net>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: en, fr, ja, es
MIME-Version: 1.0
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [1/2] IDE CD reports current speed
Content-Type: multipart/mixed;
 boundary="------------030303090709070908060308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030303090709070908060308
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

The current ide-cd driver reports the CDROM speed (as found in 
/proc/sys/dev/cdrom/info) as the current speed when loading the driver. 
Changing the speed of the cdrom drive (by "eject -x" for instance) 
doesn't update the speed reported by the kernel. Updating the info could 
be valuable for the user as it's the only way to know if the drive 
accepted the request or discarded it. It could even be used to list all 
the available speeds of the drive.

The attached patch modifies the ide-cd driver so that after every speed 
change request the new speed is updated. Please note that the actual 
modification is very little but I had to touch quite a few lines in 
order to avoid to pre-declare the sub-functions.

Please, let me know if that sounds a good behaviour for the CDROM 
interface. I hope you apply :-)

Eric
--

The IDE CD driver now updates the current speed of the CDROM drive every 
time it is changed.

Signed-off-by: Eric Piel <eric.piel@tremplin-utc.net>
--


--------------030303090709070908060308
Content-Type: text/x-patch;
 name="ide-cd-2.6.12-report-current-speed.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-cd-2.6.12-report-current-speed.patch"

--- linux-2.6.12-rc6.orig/drivers/ide/ide-cd.c	2005-06-12 13:26:26.000000000 +0200
+++ linux-2.6.12-rc6/drivers/ide/ide-cd.c	2005-06-12 13:39:15.000000000 +0200
@@ -2657,16 +2657,63 @@ int ide_cdrom_lock_door (struct cdrom_de
 }
 
 static
+int ide_cdrom_get_capabilities(ide_drive_t *drive, struct atapi_capabilities_page *cap)
+{
+	struct cdrom_info *info = drive->driver_data;
+	struct cdrom_device_info *cdi = &info->devinfo;
+	struct packet_command cgc;
+	int stat, attempts = 3, size = sizeof(*cap);
+
+	/*
+	 * ACER50 (and others?) require the full spec length mode sense
+	 * page capabilities size, but older drives break.
+	 */
+	if (!(!strcmp(drive->id->model, "ATAPI CD ROM DRIVE 50X MAX") ||
+	    !strcmp(drive->id->model, "WPI CDS-32X")))
+		size -= sizeof(cap->pad);
+
+	init_cdrom_command(&cgc, cap, size, CGC_DATA_UNKNOWN);
+	do { /* we seem to get stat=0x01,err=0x00 the first time (??) */
+		stat = cdrom_mode_sense(cdi, &cgc, GPMODE_CAPABILITIES_PAGE, 0);
+		if (!stat)
+			break;
+	} while (--attempts);
+	return stat;
+}
+
+static
+void ide_cdrom_update_speed (ide_drive_t *drive, struct atapi_capabilities_page *cap)
+{
+	/* The ACER/AOpen 24X cdrom has the speed fields byte-swapped */
+	if (!drive->id->model[0] &&
+	    !strncmp(drive->id->fw_rev, "241N", 4)) {
+		CDROM_STATE_FLAGS(drive)->current_speed  = 
+			(((unsigned int)cap->curspeed) + (176/2)) / 176;
+		CDROM_CONFIG_FLAGS(drive)->max_speed = 
+			(((unsigned int)cap->maxspeed) + (176/2)) / 176;
+	} else {
+		CDROM_STATE_FLAGS(drive)->current_speed  = 
+			(ntohs(cap->curspeed) + (176/2)) / 176;
+		CDROM_CONFIG_FLAGS(drive)->max_speed = 
+			(ntohs(cap->maxspeed) + (176/2)) / 176;
+	}
+}
+
+static
 int ide_cdrom_select_speed (struct cdrom_device_info *cdi, int speed)
 {
 	ide_drive_t *drive = (ide_drive_t*) cdi->handle;
 	struct request_sense sense;
+	struct atapi_capabilities_page cap;
 	int stat;
 
 	if ((stat = cdrom_select_speed(drive, speed, &sense)) < 0)
 		return stat;
 
-        cdi->speed = CDROM_STATE_FLAGS(drive)->current_speed;
+	if (!ide_cdrom_get_capabilities(drive, &cap)) {
+		ide_cdrom_update_speed(drive, &cap);
+		cdi->speed = CDROM_STATE_FLAGS(drive)->current_speed;
+	}
         return 0;
 }
 
@@ -2869,31 +2916,6 @@ static int ide_cdrom_register (ide_drive
 }
 
 static
-int ide_cdrom_get_capabilities(ide_drive_t *drive, struct atapi_capabilities_page *cap)
-{
-	struct cdrom_info *info = drive->driver_data;
-	struct cdrom_device_info *cdi = &info->devinfo;
-	struct packet_command cgc;
-	int stat, attempts = 3, size = sizeof(*cap);
-
-	/*
-	 * ACER50 (and others?) require the full spec length mode sense
-	 * page capabilities size, but older drives break.
-	 */
-	if (!(!strcmp(drive->id->model, "ATAPI CD ROM DRIVE 50X MAX") ||
-	    !strcmp(drive->id->model, "WPI CDS-32X")))
-		size -= sizeof(cap->pad);
-
-	init_cdrom_command(&cgc, cap, size, CGC_DATA_UNKNOWN);
-	do { /* we seem to get stat=0x01,err=0x00 the first time (??) */
-		stat = cdrom_mode_sense(cdi, &cgc, GPMODE_CAPABILITIES_PAGE, 0);
-		if (!stat)
-			break;
-	} while (--attempts);
-	return stat;
-}
-
-static
 int ide_cdrom_probe_capabilities (ide_drive_t *drive)
 {
 	struct cdrom_info *info = drive->driver_data;
@@ -2978,20 +3000,7 @@ int ide_cdrom_probe_capabilities (ide_dr
 		}
 	}
 
-	/* The ACER/AOpen 24X cdrom has the speed fields byte-swapped */
-	if (!drive->id->model[0] &&
-	    !strncmp(drive->id->fw_rev, "241N", 4)) {
-		CDROM_STATE_FLAGS(drive)->current_speed  = 
-			(((unsigned int)cap.curspeed) + (176/2)) / 176;
-		CDROM_CONFIG_FLAGS(drive)->max_speed = 
-			(((unsigned int)cap.maxspeed) + (176/2)) / 176;
-	} else {
-		CDROM_STATE_FLAGS(drive)->current_speed  = 
-			(ntohs(cap.curspeed) + (176/2)) / 176;
-		CDROM_CONFIG_FLAGS(drive)->max_speed = 
-			(ntohs(cap.maxspeed) + (176/2)) / 176;
-	}
-
+	ide_cdrom_update_speed(drive, &cap);
 	/* don't print speed if the drive reported 0.
 	 */
 	printk(KERN_INFO "%s: ATAPI", drive->name);

--------------030303090709070908060308--
