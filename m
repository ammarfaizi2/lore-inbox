Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262409AbSJOFmD>; Tue, 15 Oct 2002 01:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262443AbSJOFmD>; Tue, 15 Oct 2002 01:42:03 -0400
Received: from modemcable061.219-201-24.mtl.mc.videotron.ca ([24.201.219.61]:8076
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262409AbSJOFmB>; Tue, 15 Oct 2002 01:42:01 -0400
Date: Tue, 15 Oct 2002 01:34:36 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Andre Hedrick <andre@linux-ide.org>, Russell King <rmk@arm.linux.org.uk>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [PATCH][2.5][RFC] ide_drive_remove oddity?
Message-ID: <Pine.LNX.4.44.0210150108550.1795-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you really issue a cache flush command after issuing a device standby?

Here is an untested/uncompiled patch which makes it standby after a 
cleanup.

Clue sticks at the ready gentlemen!

	Zwane

Index: linux-2.5.42/drivers/ide/ide-cd.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.42/drivers/ide/ide-cd.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 ide-cd.c
--- linux-2.5.42/drivers/ide/ide-cd.c	12 Oct 2002 16:54:46 -0000	1.1.1.1
+++ linux-2.5.42/drivers/ide/ide-cd.c	15 Oct 2002 05:22:18 -0000
@@ -3026,13 +3026,7 @@
 {
 	struct cdrom_info *info = drive->driver_data;
 	struct cdrom_device_info *devinfo = &info->devinfo;
-	struct gendisk *g = drive->disk;
 
-	if (ide_unregister_subdriver(drive)) {
-		printk("%s: %s: failed to ide_unregister_subdriver\n",
-			__FUNCTION__, drive->name);
-		return 1;
-	}
 	if (info->buffer != NULL)
 		kfree(info->buffer);
 	if (info->toc != NULL)
@@ -3043,7 +3037,6 @@
 		printk("%s: ide_cdrom_cleanup failed to unregister device from the cdrom driver.\n", drive->name);
 	kfree(info);
 	drive->driver_data = NULL;
-	del_gendisk(g);
 	return 0;
 }
 
Index: linux-2.5.42/drivers/ide/ide-disk.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.42/drivers/ide/ide-disk.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 ide-disk.c
--- linux-2.5.42/drivers/ide/ide-disk.c	12 Oct 2002 16:54:46 -0000	1.1.1.1
+++ linux-2.5.42/drivers/ide/ide-disk.c	15 Oct 2002 05:19:14 -0000
@@ -1790,15 +1790,10 @@
 
 static int idedisk_cleanup (ide_drive_t *drive)
 {
-	struct gendisk *g = drive->disk;
-
 	if ((drive->id->cfs_enable_2 & 0x3000) && drive->wcache)
 		if (do_idedisk_flushcache(drive))
 			printk (KERN_INFO "%s: Write Cache FAILED Flushing!\n",
 				drive->name);
-	if (ide_unregister_subdriver(drive))
-		return 1;
-	del_gendisk(g);
 	return 0;
 }
 
Index: linux-2.5.42/drivers/ide/ide-floppy.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.42/drivers/ide/ide-floppy.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 ide-floppy.c
--- linux-2.5.42/drivers/ide/ide-floppy.c	12 Oct 2002 16:54:46 -0000	1.1.1.1
+++ linux-2.5.42/drivers/ide/ide-floppy.c	15 Oct 2002 05:23:47 -0000
@@ -2014,13 +2014,8 @@
 static int idefloppy_cleanup (ide_drive_t *drive)
 {
 	idefloppy_floppy_t *floppy = drive->driver_data;
-	struct gendisk *g = drive->disk;
-
-	if (ide_unregister_subdriver(drive))
-		return 1;
 	drive->driver_data = NULL;
 	kfree(floppy);
-	del_gendisk(g);
 	return 0;
 }
 
Index: linux-2.5.42/drivers/ide/ide-tape.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.42/drivers/ide/ide-tape.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 ide-tape.c
--- linux-2.5.42/drivers/ide/ide-tape.c	12 Oct 2002 16:54:46 -0000	1.1.1.1
+++ linux-2.5.42/drivers/ide/ide-tape.c	15 Oct 2002 05:24:28 -0000
@@ -6145,7 +6145,6 @@
 	idetape_chrdevs[minor].drive = NULL;
 	spin_unlock_irqrestore(&ide_lock, flags);
 	DRIVER(drive)->busy = 0;
-	(void) ide_unregister_subdriver(drive);
 	drive->driver_data = NULL;
 	devfs_unregister(tape->de_r);
 	devfs_unregister(tape->de_n);
Index: linux-2.5.42/drivers/ide/ide.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.42/drivers/ide/ide.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 ide.c
--- linux-2.5.42/drivers/ide/ide.c	12 Oct 2002 16:54:46 -0000	1.1.1.1
+++ linux-2.5.42/drivers/ide/ide.c	15 Oct 2002 05:30:33 -0000
@@ -3426,14 +3426,22 @@
 static int ide_drive_remove(struct device * dev)
 {
 	ide_drive_t * drive = container_of(dev,ide_drive_t,gendev);
+	struct gendisk *g = drive->disk;
 	ide_driver_t * driver = drive->driver;
 
 	if (driver) {
-		if (driver->standby)
-			driver->standby(drive);
 		if (driver->cleanup)
 			driver->cleanup(drive);
+
+		if (driver->standby)
+			driver->standby(drive);
+
+		if (ide_unregister_subdriver(drive))
+			return 1;
 	}
+	
+	if (g)
+		del_gendisk(g);
 	
 	return 0;
 }

-- 
function.linuxpower.ca


