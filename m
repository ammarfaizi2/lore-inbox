Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbVFMWhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbVFMWhs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 18:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbVFMWh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 18:37:27 -0400
Received: from mf00.sitadelle.com ([212.94.174.79]:64369 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S261576AbVFMWe3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 18:34:29 -0400
Message-ID: <42AE09FA.404@tremplin-utc.net>
Date: Tue, 14 Jun 2005 00:34:34 +0200
From: Eric Piel <Eric.Piel@tremplin-utc.net>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: en, fr, ja, es
MIME-Version: 1.0
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [2/2] IDE CD more STANDARD_ATAPI ifdef
Content-Type: multipart/mixed;
 boundary="------------040804000009090302070104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040804000009090302070104
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

This little patch adds more ifdef's to surround code not necessary for 
the standard ATAPI drives. I've tried to find all the code that was 
handling special cases. It reduces slightly more the module size :-) As 
most of the non standard drives handled seem quite old, this is very safe.

This patch has to be applied after my previous patch 
(ide-cd-2.6.12-report-current-speed.patch) but I can remake it directly 
against latest vanilla kernel if you prefer. BTW, I'd like to make a 
Kconfig option for STANDARD_ATAPI, would you accept it?

please apply,

Eric
--

Specify, in the ide-cd driver, additional code which is for non standard 
ATAPI drives.

Signed-off-by: Eric Piel <eric.piel@tremplin-utc.net>
--

--------------040804000009090302070104
Content-Type: text/x-patch;
 name="ide-cd-2.6.12-more-standard-atapi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-cd-2.6.12-more-standard-atapi.patch"

--- linux-2.6.12-rc6.orig/drivers/ide/ide-cd.c	2005-06-12 13:40:45.000000000 +0200
+++ linux-2.6.12-rc6/drivers/ide/ide-cd.c	2005-06-12 13:52:10.000000000 +0200
@@ -2662,15 +2662,17 @@ int ide_cdrom_get_capabilities(ide_drive
 	struct cdrom_info *info = drive->driver_data;
 	struct cdrom_device_info *cdi = &info->devinfo;
 	struct packet_command cgc;
-	int stat, attempts = 3, size = sizeof(*cap);
+	int stat, attempts = 3, size = sizeof(*cap) - sizeof(cap->pad);
 
+#if ! STANDARD_ATAPI
 	/*
 	 * ACER50 (and others?) require the full spec length mode sense
 	 * page capabilities size, but older drives break.
 	 */
-	if (!(!strcmp(drive->id->model, "ATAPI CD ROM DRIVE 50X MAX") ||
-	    !strcmp(drive->id->model, "WPI CDS-32X")))
-		size -= sizeof(cap->pad);
+	if (!strcmp(drive->id->model, "ATAPI CD ROM DRIVE 50X MAX") ||
+	    !strcmp(drive->id->model, "WPI CDS-32X"))
+		size = sizeof(*cap);
+#endif  /* not STANDARD_ATAPI */
 
 	init_cdrom_command(&cgc, cap, size, CGC_DATA_UNKNOWN);
 	do { /* we seem to get stat=0x01,err=0x00 the first time (??) */
@@ -2684,6 +2686,7 @@ int ide_cdrom_get_capabilities(ide_drive
 static
 void ide_cdrom_update_speed (ide_drive_t *drive, struct atapi_capabilities_page *cap)
 {
+#if ! STANDARD_ATAPI
 	/* The ACER/AOpen 24X cdrom has the speed fields byte-swapped */
 	if (!drive->id->model[0] &&
 	    !strncmp(drive->id->fw_rev, "241N", 4)) {
@@ -2691,7 +2694,9 @@ void ide_cdrom_update_speed (ide_drive_t
 			(((unsigned int)cap->curspeed) + (176/2)) / 176;
 		CDROM_CONFIG_FLAGS(drive)->max_speed = 
 			(((unsigned int)cap->maxspeed) + (176/2)) / 176;
-	} else {
+	} else
+#endif  /* not STANDARD_ATAPI */
+	{
 		CDROM_STATE_FLAGS(drive)->current_speed  = 
 			(ntohs(cap->curspeed) + (176/2)) / 176;
 		CDROM_CONFIG_FLAGS(drive)->max_speed = 
@@ -2930,12 +2935,14 @@ int ide_cdrom_probe_capabilities (ide_dr
 		return nslots;
 	}
 
+#if ! STANDARD_ATAPI
 	if (CDROM_CONFIG_FLAGS(drive)->nec260 ||
 	    !strcmp(drive->id->model,"STINGRAY 8422 IDE 8X CD-ROM 7-27-95")) {
 		CDROM_CONFIG_FLAGS(drive)->no_eject = 0;
 		CDROM_CONFIG_FLAGS(drive)->audio_play = 1;
 		return nslots;
 	}
+#endif /* not STANDARD_ATAPI */
 
 	/*
 	 * we have to cheat a little here. the packet will eventually
@@ -2975,6 +2982,7 @@ int ide_cdrom_probe_capabilities (ide_dr
 	if (cap.mechtype == mechtype_caddy || cap.mechtype == mechtype_popup)
 		CDROM_CONFIG_FLAGS(drive)->close_tray = 0;
 
+#if ! STANDARD_ATAPI
 	/* Some drives used by Apple don't advertise audio play
 	 * but they do support reading TOC & audio datas
 	 */
@@ -2984,7 +2992,6 @@ int ide_cdrom_probe_capabilities (ide_dr
 	    strcmp(drive->id->model, "MATSHITADVD-ROM SR-8174") == 0)
 		CDROM_CONFIG_FLAGS(drive)->audio_play = 1;
 
-#if ! STANDARD_ATAPI
 	if (cdi->sanyo_slot > 0) {
 		CDROM_CONFIG_FLAGS(drive)->is_changer = 1;
 		nslots = 3;
@@ -3157,6 +3164,7 @@ int ide_cdrom_setup (ide_drive_t *drive)
 	
 	/* limit transfer size per interrupt. */
 	CDROM_CONFIG_FLAGS(drive)->limit_nframes = 0;
+#if ! STANDARD_ATAPI
 	/* a testament to the nice quality of Samsung drives... */
 	if (!strcmp(drive->id->model, "SAMSUNG CD-ROM SCR-2430"))
 		CDROM_CONFIG_FLAGS(drive)->limit_nframes = 1;
@@ -3166,7 +3174,6 @@ int ide_cdrom_setup (ide_drive_t *drive)
 	else if (!strcmp(drive->id->model, "SAMSUNG CD-ROM SCR-3231"))
 		cdi->mask |= CDC_SELECT_SPEED;
 
-#if ! STANDARD_ATAPI
 	/* by default Sanyo 3 CD changer support is turned off and
            ATAPI Rev 2.2+ standard support for CD changers is used */
 	cdi->sanyo_slot = 0;

--------------040804000009090302070104--
