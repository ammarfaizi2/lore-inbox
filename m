Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265074AbSKFNur>; Wed, 6 Nov 2002 08:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265077AbSKFNuq>; Wed, 6 Nov 2002 08:50:46 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:13831 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S265074AbSKFNuo>; Wed, 6 Nov 2002 08:50:44 -0500
Date: Wed, 6 Nov 2002 14:57:21 +0100
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       benh@kernel.crashing.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: don't eat ide disks
Message-ID: <20021106135721.GH5366@atrey.karlin.mff.cuni.cz>
References: <20021103225656.GR28704@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.44.0211031535540.23444-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211031535540.23444-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I sleep all devices by telling driverfs to sleep them. Should I tell
> > all block devices, then tell driverfs? Seems hacky to me. Or should
> > idedisk_suspend generate request for itself, then pass it through
> > queues?
> 
> I would strongly encourage letting the device hierarchy suspend() (now
> called sysfs, not driverfs) call be the _only_ call the disk controller
> ever gets. Having two different suspend mechanisms is just too confusing
> for words, and there's no point.

Okay, here's the fix. It kills private suspend/resume infrastructure
in ide, it was unused, anyway. Only change is that standby is called
from cleanup(). That's okay, only place where standby() was not called
before cleanup was ATAPI and that does not apply to disks.

								Pavel

--- linux-swsusp.prague/drivers/ide/ide-disk.c	2002-11-01 21:36:54.000000000 +0100
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
@@ -1721,6 +1693,7 @@
 {
 	struct gendisk *g = drive->disk;
 
+	do_idedisk_standby(drive);
 	if ((drive->id->cfs_enable_2 & 0x3000) && drive->wcache)
 		if (do_idedisk_flushcache(drive))
 			printk (KERN_INFO "%s: Write Cache FAILED Flushing!\n",
@@ -1746,9 +1719,6 @@
 	.supports_dma		= 1,
 	.supports_dsc_overlap	= 0,
 	.cleanup		= idedisk_cleanup,
-	.standby		= do_idedisk_standby,
-	.suspend		= do_idedisk_suspend,
-	.resume			= do_idedisk_resume,
 	.flushcache		= do_idedisk_flushcache,
 	.do_request		= do_rw_disk,
 	.sense			= idedisk_dump_status,
--- linux-swsusp.prague/drivers/ide/ide.c	2002-11-01 00:44:15.000000000 +0100
+++ linux-swsusp/drivers/ide/ide.c	2002-11-06 14:08:53.000000000 +0100
@@ -3111,21 +3111,6 @@
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
@@ -3182,9 +3167,6 @@
 {
 	ide_driver_t *d = drive->driver;
 
-	if (d->standby == NULL)		d->standby = default_standby;
-	if (d->suspend == NULL)		d->suspend = default_suspend;
-	if (d->resume == NULL)		d->resume = default_resume;
 	if (d->flushcache == NULL)	d->flushcache = default_flushcache;
 	if (d->do_request == NULL)	d->do_request = default_do_request;
 	if (d->end_request == NULL)	d->end_request = default_end_request;
@@ -3262,13 +3244,8 @@
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
 
--- linux-swsusp.prague/include/linux/ide.h	2002-11-01 00:45:02.000000000 +0100
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
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
