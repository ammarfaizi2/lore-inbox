Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266772AbSKLRqN>; Tue, 12 Nov 2002 12:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266790AbSKLRqN>; Tue, 12 Nov 2002 12:46:13 -0500
Received: from [195.39.17.254] ([195.39.17.254]:11780 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S266772AbSKLRpo>;
	Tue, 12 Nov 2002 12:45:44 -0500
Date: Tue, 12 Nov 2002 18:51:54 +0100
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Cc: alan@redhat.com
Subject: Kill obsolete and  unused suspend/resume code from IDE
Message-ID: <20021112175154.GA6881@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This code in ide is obsolete and unused. I have followup patch to
integrate IDE into sysfs. Please apply,
								Pavel

--- clean/drivers/ide/ide-disk.c	2002-11-01 00:37:14.000000000 +0100
+++ linux-swsusp/drivers/ide/ide-disk.c	2002-11-06 14:33:35.000000000 +0100
@@ -1412,24 +1412,6 @@
 	return call_idedisk_standby(drive, 0);
 }
 
-static int call_idedisk_suspend (ide_drive_t *drive, int arg)
-{
-	ide_task_t args;
-	u8 suspend = (arg) ? WIN_SLEEPNOW2 : WIN_SLEEPNOW1;
-	memset(&args, 0, sizeof(ide_task_t));
-	args.tfRegister[IDE_COMMAND_OFFSET]	= suspend;
-	args.command_type			= ide_cmd_type_parser(&args);
-	return ide_raw_taskfile(drive, &args, NULL);
-}
-
-static int do_idedisk_suspend (ide_drive_t *drive)
-{
-	if (drive->suspend_reset)
-		return 1;
-
-	return call_idedisk_suspend(drive, 0);
-}
-
 #if 0
 static int call_idedisk_checkpower (ide_drive_t *drive, int arg)
 {
@@ -1456,13 +1438,6 @@
 }
 #endif
 
-static int do_idedisk_resume (ide_drive_t *drive)
-{
-	if (!drive->suspend_reset)
-		return 1;
-	return 0;
-}
-
 static int do_idedisk_flushcache (ide_drive_t *drive)
 {
 	ide_task_t args;
@@ -1671,6 +1693,7 @@
 {
 	struct gendisk *g = drive->disk;
 
+	do_idedisk_standby(drive);
 	if ((drive->id->cfs_enable_2 & 0x3000) && drive->wcache)
 		if (do_idedisk_flushcache(drive))
 			printk (KERN_INFO "%s: Write Cache FAILED Flushing!\n",
@@ -1696,9 +1719,6 @@
 	.supports_dma		= 1,
 	.supports_dsc_overlap	= 0,
 	.cleanup		= idedisk_cleanup,
-	.standby		= do_idedisk_standby,
-	.suspend		= do_idedisk_suspend,
-	.resume			= do_idedisk_resume,
 	.flushcache		= do_idedisk_flushcache,
 	.do_request		= do_rw_disk,
 	.sense			= idedisk_dump_status,
--- clean/drivers/ide/ide.c	2002-11-07 16:39:48.000000000 +0100
+++ linux-swsusp/drivers/ide/ide.c	2002-11-07 17:19:42.000000000 +0100
@@ -3110,21 +3110,6 @@
 #endif
 }
 
-static int default_standby (ide_drive_t *drive)
-{
-	return 0;
-}
-
-static int default_suspend (ide_drive_t *drive)
-{
-	return 0;
-}
-
-static int default_resume (ide_drive_t *drive)
-{
-	return 0;
-}
-
 static int default_flushcache (ide_drive_t *drive)
 {
 	return 0;
@@ -3181,9 +3166,6 @@
 {
 	ide_driver_t *d = drive->driver;
 
-	if (d->standby == NULL)		d->standby = default_standby;
-	if (d->suspend == NULL)		d->suspend = default_suspend;
-	if (d->resume == NULL)		d->resume = default_resume;
 	if (d->flushcache == NULL)	d->flushcache = default_flushcache;
 	if (d->do_request == NULL)	d->do_request = default_do_request;
 	if (d->end_request == NULL)	d->end_request = default_end_request;
@@ -3261,13 +3243,8 @@
 	ide_drive_t * drive = container_of(dev,ide_drive_t,gendev);
 	ide_driver_t * driver = drive->driver;
 
-	if (driver) {
-		if (driver->standby)
-			driver->standby(drive);
-		if (driver->cleanup)
-			driver->cleanup(drive);
-	}
-	
+	if (driver && driver->cleanup)
+		driver->cleanup(drive);
 	return 0;
 }
 
--- clean/include/linux/ide.h	2002-11-01 00:37:40.000000000 +0100
+++ linux-swsusp/include/linux/ide.h	2002-11-06 14:07:05.000000000 +0100
@@ -1180,9 +1180,6 @@
 	unsigned supports_dma		: 1;
 	unsigned supports_dsc_overlap	: 1;
 	int		(*cleanup)(ide_drive_t *);
-	int		(*standby)(ide_drive_t *);
-	int		(*suspend)(ide_drive_t *);
-	int		(*resume)(ide_drive_t *);
 	int		(*flushcache)(ide_drive_t *);
 	ide_startstop_t	(*do_request)(ide_drive_t *, struct request *, sector_t);
 	int		(*end_request)(ide_drive_t *, int, int);

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
