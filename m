Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263281AbSKMVG0>; Wed, 13 Nov 2002 16:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263291AbSKMVG0>; Wed, 13 Nov 2002 16:06:26 -0500
Received: from [195.39.17.254] ([195.39.17.254]:9732 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S263281AbSKMVGS>;
	Wed, 13 Nov 2002 16:06:18 -0500
Date: Wed, 13 Nov 2002 22:12:30 +0100
From: Pavel Machek <pavel@ucw.cz>
To: alan@redhat.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Kill unused/obsolete power managment from ide
Message-ID: <20021113211230.GA7553@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is same patch you already seen, just rediffed to -ac2. Please
apply. No code should be changed except for case of ide-disk connected
using ATAPI. Such thing does not exist, AFAIK.
								Pavel

--- clean-ac/drivers/ide/ide-disk.c	2002-11-12 18:40:35.000000000 +0100
+++ linux-ac/drivers/ide/ide-disk.c	2002-11-13 22:00:22.000000000 +0100
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
@@ -1671,6 +1646,7 @@
 {
 	struct gendisk *g = drive->disk;
 
+	do_idedisk_standby(drive);
 	if ((drive->id->cfs_enable_2 & 0x3000) && drive->wcache)
 		if (do_idedisk_flushcache(drive))
 			printk (KERN_INFO "%s: Write Cache FAILED Flushing!\n",
@@ -1696,9 +1672,6 @@
 	.supports_dma		= 1,
 	.supports_dsc_overlap	= 0,
 	.cleanup		= idedisk_cleanup,
-	.standby		= do_idedisk_standby,
-	.suspend		= do_idedisk_suspend,
-	.resume			= do_idedisk_resume,
 	.flushcache		= do_idedisk_flushcache,
 	.do_request		= do_rw_disk,
 	.sense			= idedisk_dump_status,
@@ -1835,8 +1808,7 @@
 
 static int idedisk_init (void)
 {
-	ide_register_driver(&idedisk_driver);
-	return 0;
+	return ide_register_driver(&idedisk_driver);
 }
 
 module_init(idedisk_init);
--- clean-ac/drivers/ide/ide.c	2002-11-13 21:38:11.000000000 +0100
+++ linux-ac/drivers/ide/ide.c	2002-11-13 22:01:12.000000000 +0100
@@ -2145,36 +2145,6 @@
 	drive->dead = 1;
 	return 0;
 }
- 
-/*
- *	Default function to use on an APM standby. This is going away
- *	as Pavel is moving this to sysfs
- */
- 
-static int default_standby (ide_drive_t *drive)
-{
-	return 0;
-}
-
-/*
- *	Default function to use on an APM suspend. This is going away
- *	as Pavel is moving this to sysfs
- */
- 
-static int default_suspend (ide_drive_t *drive)
-{
-	return 0;
-}
-
-/*
- *	Default function to use on an APM suspend. This is going away
- *	as Pavel is moving this to sysfs
- */
- 
-static int default_resume (ide_drive_t *drive)
-{
-	return 0;
-}
 
 /*
  *	Default function to use for the cache flush operation. This
@@ -2243,9 +2213,6 @@
 
 	if (d->cleanup == NULL)		d->cleanup = default_cleanup;
 	if (d->shutdown == NULL)	d->shutdown = default_shutdown;
-	if (d->standby == NULL)		d->standby = default_standby;
-	if (d->suspend == NULL)		d->suspend = default_suspend;
-	if (d->resume == NULL)		d->resume = default_resume;
 	if (d->flushcache == NULL)	d->flushcache = default_flushcache;
 	if (d->do_request == NULL)	d->do_request = default_do_request;
 	if (d->end_request == NULL)	d->end_request = default_end_request;
@@ -2324,13 +2291,8 @@
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
 
--- clean-ac/include/linux/ide.h	2002-11-13 21:38:17.000000000 +0100
+++ linux-ac/include/linux/ide.h	2002-11-13 22:00:36.000000000 +0100
@@ -1191,9 +1191,6 @@
 	unsigned supports_dsc_overlap	: 1;
 	int		(*cleanup)(ide_drive_t *);
 	int		(*shutdown)(ide_drive_t *);
-	int		(*standby)(ide_drive_t *);
-	int		(*suspend)(ide_drive_t *);
-	int		(*resume)(ide_drive_t *);
 	int		(*flushcache)(ide_drive_t *);
 	ide_startstop_t	(*do_request)(ide_drive_t *, struct request *, sector_t);
 	int		(*end_request)(ide_drive_t *, int, int);

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
