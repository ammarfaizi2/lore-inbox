Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310993AbSCHSMp>; Fri, 8 Mar 2002 13:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310300AbSCHSMh>; Fri, 8 Mar 2002 13:12:37 -0500
Received: from smtp3.vol.cz ([195.250.128.83]:50704 "EHLO smtp3.vol.cz")
	by vger.kernel.org with ESMTP id <S310994AbSCHSMY>;
	Fri, 8 Mar 2002 13:12:24 -0500
Date: Fri, 8 Mar 2002 19:02:05 +0100
From: Pavel Machek <pavel@ucw.cz>
To: dalecki@evision-ventures.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Suspend support for IDE
Message-ID: <20020308180204.GA7035@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This adds driver support to ide-disk.c. Does it look good to you? [If
so, applying it will not hurt, altrough it might change in near
future.]

									Pavel

--- clean.pre/drivers/ide/ide-disk.c	Fri Mar  8 18:40:34 2002
+++ linux-dm.pre/drivers/ide/ide-disk.c	Fri Mar  8 18:40:07 2002
@@ -123,6 +123,8 @@
  */
 static ide_startstop_t do_rw_disk (ide_drive_t *drive, struct request *rq, unsigned long block)
 {
+	if (drive->blocked)
+		panic("ide: Request while drive blocked? You don't like your data intact?");
 	if (!(rq->flags & REQ_CMD)) {
 		blk_dump_rq_flags(rq, "do_rw_disk, bad command");
 		ide_end_request(drive, 0);
@@ -910,13 +912,36 @@
 	ide_add_setting(drive,	"max_failures",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	65535,				1,	1,	&drive->max_failures,		NULL);
 }
 
+static int idedisk_suspend(struct device *dev, u32 state, u32 level)
+{
+	int i;
+	ide_drive_t *drive = dev->driver_data;
+
+	printk("ide_disk_suspend()\n");
+	while (HWGROUP(drive)->handler)
+		schedule();
+	drive->blocked = 1;
+}
+
+static int idedisk_resume(struct device *dev, u32 level)
+{
+	ide_drive_t *drive = dev->driver_data;
+	if (!drive->blocked)
+		panic("ide: Resume but not suspended?\n");
+	drive->blocked = 0;
+}
+
+
 /* This is just a hook for the overall driver tree.
  *
  * FIXME: This is soon goig to replace the custom linked list games played up
  * to great extend between the different components of the IDE drivers.
  */
 
-static struct device_driver idedisk_devdrv = {};
+static struct device_driver idedisk_devdrv = {
+	suspend: idedisk_suspend,
+	resume: idedisk_resume,
+};
 
 static void idedisk_setup(ide_drive_t *drive)
 {
@@ -963,6 +988,7 @@
 	    sprintf(drive->device.name, "ide-disk");
 	    drive->device.driver = &idedisk_devdrv;
 	    drive->device.parent = &HWIF(drive)->device;
+	    drive->device.driver_data = drive;
 	    device_register(&drive->device);
 	}
 
--- clean.pre/include/linux/ide.h	Fri Mar  8 18:40:38 2002
+++ linux-dm.pre/include/linux/ide.h	Fri Mar  8 18:37:44 2002
@@ -410,6 +410,7 @@
 	unsigned autotune	: 2;	/* 1=autotune, 2=noautotune, 0=default */
 	unsigned remap_0_to_1	: 2;	/* 0=remap if ezdrive, 1=remap, 2=noremap */
 	unsigned ata_flash	: 1;	/* 1=present, 0=default */
+	unsigned blocked        : 1;	/* 1=powermanagment told us not to do anything, so sleep nicely */
 	unsigned	addressing;	/* : 2; 0=28-bit, 1=48-bit, 2=64-bit */
 	byte		scsi;		/* 0=default, 1=skip current ide-subdriver for ide-scsi emulation */
 	select_t	select;		/* basic drive/head select reg value */

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
