Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbTFBNLc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 09:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262306AbTFBNLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 09:11:32 -0400
Received: from mail2.ewetel.de ([212.6.122.20]:45997 "EHLO mail2.ewetel.de")
	by vger.kernel.org with ESMTP id S262303AbTFBNLa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 09:11:30 -0400
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5-bkcvs] capability flag for ATAPI MO drives
In-Reply-To: <20030602105009$4590@gated-at.bofh.it>
References: <20030529140013$347f@gated-at.bofh.it> <20030602105009$4590@gated-at.bofh.it>
Date: Mon, 2 Jun 2003 15:24:53 +0200
Message-Id: <E19MpIz-00025Q-00@neptune.local>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Jun 2003 12:50:09 +0200, Jens Axboe wrote in linux-kernel:

>> Jens, how will ide-cd.c/cdrom.c fly with sector sizes of 512 or
>> 1024 bytes? There are MO disks with those sector sizes. I only have
>> 640 MB disks with 2048 byte sector size, so I can't test.
> It probably wont. I'd be reluctant to actually allow that without
> someone doing the footwork of making sure it generally works. I'm not
> sure it does.

I don't think that's critical at the moment, with read-only support the
worst that can happen is that you simply cannot use a 512 or 1024 byte
sector disk. No risk of data corruption.

I'll try to get my hands on such media and test. I'm also still trying
to get writing to work, but will only submit that as a patch when I know
that it works with smaller sector sizes than 2048.

> Patch looks fine, btw.

Please apply the patch below, it's the same with the flags renamed to
mo_drive and CDC_MO_DRIVE. I think those names are a bit clearer.


Index: drivers/ide/ide-cd.c
===================================================================
RCS file: /home/bkcvs/linux-2.5/drivers/ide/ide-cd.c,v
retrieving revision 1.122
diff -u -3 -b -p -r1.122 ide-cd.c
--- drivers/ide/ide-cd.c	31 May 2003 18:55:27 -0000	1.122
+++ drivers/ide/ide-cd.c	2 Jun 2003 13:13:37 -0000
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
retrieving revision 1.28
diff -u -3 -b -p -r1.28 ide-cd.h
--- drivers/ide/ide-cd.h	31 May 2003 19:01:09 -0000	1.28
+++ drivers/ide/ide-cd.h	2 Jun 2003 13:08:50 -0000
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
retrieving revision 1.26
diff -u -3 -b -p -r1.26 cdrom.h
--- include/linux/cdrom.h	31 May 2003 18:51:58 -0000	1.26
+++ include/linux/cdrom.h	2 Jun 2003 13:09:46 -0000
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
