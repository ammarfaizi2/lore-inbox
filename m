Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264610AbTF2Tb3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 15:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264829AbTF2Tb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 15:31:28 -0400
Received: from mail2.ewetel.de ([212.6.122.20]:3578 "EHLO mail2.ewetel.de")
	by vger.kernel.org with ESMTP id S264610AbTF2TbC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 15:31:02 -0400
Date: Sun, 29 Jun 2003 21:45:14 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ide-cd: capability flag for MO drives 
Message-ID: <Pine.LNX.4.44.0306292142580.1272-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


3rd resend. Please apply or tell me what is wrong with it...

Add capability flag for MO drives. Since ATAPI MOs are now recognized
by the ide-cd driver, it is useful to have a capability flag to be able
to tell MO drives from other drives (needed for later write support).


Index: drivers/ide/ide-cd.c
===================================================================
RCS file: /home/bkcvs/linux-2.5/drivers/ide/ide-cd.c,v
retrieving revision 1.113
diff -u -3 -b -p -r1.113 ide-cd.c
--- drivers/ide/ide-cd.c	21 Jun 2003 16:17:21 -0000	1.113
+++ drivers/ide/ide-cd.c	15 Jun 2003 00:46:49 -0000
@@ -2805,7 +2805,7 @@ static struct cdrom_device_ops ide_cdrom
 				CDC_MEDIA_CHANGED | CDC_PLAY_AUDIO | CDC_RESET |
 				CDC_IOCTLS | CDC_DRIVE_STATUS | CDC_CD_R |
 				CDC_CD_RW | CDC_DVD | CDC_DVD_R| CDC_DVD_RAM |
-				CDC_GENERIC_PACKET,
+				CDC_GENERIC_PACKET | CDC_MO_DRIVE,
 	.generic_packet		= ide_cdrom_packet,
 };
 
@@ -2838,6 +2838,8 @@ static int ide_cdrom_register (ide_drive
 		devinfo->mask |= CDC_PLAY_AUDIO;
 	if (!CDROM_CONFIG_FLAGS(drive)->close_tray)
 		devinfo->mask |= CDC_CLOSE_TRAY;
+	if (!CDROM_CONFIG_FLAGS(drive)->mo_drive)
+		devinfo->mask |= CDC_MO_DRIVE;
 
 	return register_cdrom(devinfo);
 }
@@ -2884,6 +2886,7 @@ int ide_cdrom_probe_capabilities (ide_dr
 	int nslots = 1;
 
 	if (drive->media == ide_optical) {
+		CDROM_CONFIG_FLAGS(drive)->mo_drive = 1;
 		printk("%s: ATAPI magneto-optical drive\n", drive->name);
 		return nslots;
 	}
Index: drivers/ide/ide-cd.h
===================================================================
RCS file: /home/bkcvs/linux-2.5/drivers/ide/ide-cd.h,v
retrieving revision 1.16
diff -u -3 -b -p -r1.16 ide-cd.h
--- drivers/ide/ide-cd.h	2 Nov 2002 21:12:01 -0000	1.16
+++ drivers/ide/ide-cd.h	6 Jun 2003 13:06:08 -0000
@@ -85,7 +85,8 @@ struct ide_cd_config_flags {
 	__u8 audio_play		: 1; /* can do audio related commands */
 	__u8 close_tray		: 1; /* can close the tray */
 	__u8 writing		: 1; /* pseudo write in progress */
-	__u8 reserved		: 3;
+	__u8 mo_drive		: 1; /* drive is an MO device */
+	__u8 reserved		: 2;
 	byte max_speed;		     /* Max speed of the drive */
 };
 #define CDROM_CONFIG_FLAGS(drive) (&(((struct cdrom_info *)(drive->driver_data))->config_flags))
Index: include/linux/cdrom.h
===================================================================
RCS file: /home/bkcvs/linux-2.5/include/linux/cdrom.h,v
retrieving revision 1.14
diff -u -3 -b -p -r1.14 cdrom.h
--- include/linux/cdrom.h	24 Apr 2003 01:27:54 -0000	1.14
+++ include/linux/cdrom.h	6 Jun 2003 13:05:30 -0000
@@ -387,6 +387,7 @@ struct cdrom_generic_command
 #define CDC_DVD			0x8000	/* drive is a DVD */
 #define CDC_DVD_R		0x10000	/* drive can write DVD-R */
 #define CDC_DVD_RAM		0x20000	/* drive can write DVD-RAM */
+#define CDC_MO_DRIVE		0x40000 /* drive is an MO device */
 
 /* drive status possibilities returned by CDROM_DRIVE_STATUS ioctl */
 #define CDS_NO_INFO		0	/* if not implemented */


-- 
Ciao,
Pascal

