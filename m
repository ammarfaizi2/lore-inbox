Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbTE2NjN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 09:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262252AbTE2NjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 09:39:13 -0400
Received: from [212.6.122.211] ([212.6.122.211]:59825 "EHLO mail3.ewetel.de")
	by vger.kernel.org with ESMTP id S262251AbTE2NjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 09:39:10 -0400
Date: Thu, 29 May 2003 15:52:26 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5-bkcvs] capability flag for ATAPI MO drives
Message-ID: <Pine.LNX.4.44.0305291545220.8842-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

Now that ide-cd in 2.5 deals with ATAPI MO drivers, I think there
should be a configuration/capability flag to identify the drive
as an MO drive. This will be needed for later write support so that
drivers/cdrom.c can tell that this drive is capable of writing.

Please apply and/or comment.

Jens, how will ide-cd.c/cdrom.c fly with sector sizes of 512 or
1024 bytes? There are MO disks with those sector sizes. I only have
640 MB disks with 2048 byte sector size, so I can't test.



Index: drivers/ide/ide-cd.c
===================================================================
RCS file: /home/bkcvs/linux-2.5/drivers/ide/ide-cd.c,v
retrieving revision 1.110
diff -u -3 -b -p -r1.110 ide-cd.c
--- drivers/ide/ide-cd.c	27 May 2003 14:42:16 -0000	1.110
+++ drivers/ide/ide-cd.c	29 May 2003 13:34:50 -0000
@@ -2794,7 +2794,7 @@ static struct cdrom_device_ops ide_cdrom
 				CDC_MEDIA_CHANGED | CDC_PLAY_AUDIO | CDC_RESET |
 				CDC_IOCTLS | CDC_DRIVE_STATUS | CDC_CD_R |
 				CDC_CD_RW | CDC_DVD | CDC_DVD_R| CDC_DVD_RAM |
-				CDC_GENERIC_PACKET,
+				CDC_GENERIC_PACKET | CDC_OPTICAL,
 	.generic_packet		= ide_cdrom_packet,
 };
 
@@ -2827,6 +2827,8 @@ static int ide_cdrom_register (ide_drive
 		devinfo->mask |= CDC_PLAY_AUDIO;
 	if (!CDROM_CONFIG_FLAGS(drive)->close_tray)
 		devinfo->mask |= CDC_CLOSE_TRAY;
+	if (!CDROM_CONFIG_FLAGS(drive)->optical)
+		devinfo->mask |= CDC_OPTICAL;
 
 	return register_cdrom(devinfo);
 }
@@ -2873,6 +2875,7 @@ int ide_cdrom_probe_capabilities (ide_dr
 	int nslots = 1;
 
 	if (drive->media == ide_optical) {
+		CDROM_CONFIG_FLAGS(drive)->optical = 1;
 		printk("%s: ATAPI magneto-optical drive\n", drive->name);
 		return nslots;
 	}
Index: drivers/ide/ide-cd.h
===================================================================
RCS file: /home/bkcvs/linux-2.5/drivers/ide/ide-cd.h,v
retrieving revision 1.16
diff -u -3 -b -p -r1.16 ide-cd.h
--- drivers/ide/ide-cd.h	2 Nov 2002 21:12:01 -0000	1.16
+++ drivers/ide/ide-cd.h	8 May 2003 14:21:50 -0000
@@ -85,7 +85,8 @@ struct ide_cd_config_flags {
 	__u8 audio_play		: 1; /* can do audio related commands */
 	__u8 close_tray		: 1; /* can close the tray */
 	__u8 writing		: 1; /* pseudo write in progress */
-	__u8 reserved		: 3;
+	__u8 optical		: 1; /* drive is an MO device */
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
+++ include/linux/cdrom.h	8 May 2003 14:23:21 -0000
@@ -387,6 +387,7 @@ struct cdrom_generic_command
 #define CDC_DVD			0x8000	/* drive is a DVD */
 #define CDC_DVD_R		0x10000	/* drive can write DVD-R */
 #define CDC_DVD_RAM		0x20000	/* drive can write DVD-RAM */
+#define CDC_OPTICAL		0x40000 /* drive is an MO device */
 
 /* drive status possibilities returned by CDROM_DRIVE_STATUS ioctl */
 #define CDS_NO_INFO		0	/* if not implemented */


-- 
Ciao,
Pascal

