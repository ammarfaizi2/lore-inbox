Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262438AbSJISft>; Wed, 9 Oct 2002 14:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262432AbSJISfp>; Wed, 9 Oct 2002 14:35:45 -0400
Received: from air-2.osdl.org ([65.172.181.6]:6064 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S262424AbSJISf3>;
	Wed, 9 Oct 2002 14:35:29 -0400
Date: Wed, 9 Oct 2002 11:43:39 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [bk/patch] IDE driver model update
In-Reply-To: <Pine.LNX.4.44.0210091131360.16276-100000@cherise.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0210091143330.16276-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet@1.728, 2002-10-09 10:52:46-07:00, mochel@osdl.org
  IDE: register ide driver for all ide drives; not just for disk drives. 
    
  This adds
        struct device_driver    gen_driver;
    
  to ide_driver_t, which is filled in with necessary fields when an ide
  driver calls ide_register_driver(). That then registers the driver with
  the driver model core. 
    
  As a result, this gives us the following output in driverfs:
    
  # tree -d /sys/bus/ide/drivers/
  /sys/bus/ide/drivers/
  |-- ide-cdrom
  `-- ide-disk
    
  The suspend/resume callbacks in ide-disk.c have been temporarily
  disabled until the ide core implements generic methods which forward
  the calls to the drive drivers. 

diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	Wed Oct  9 11:41:39 2002
+++ b/drivers/ide/ide-disk.c	Wed Oct  9 11:41:39 2002
@@ -1664,14 +1664,6 @@
 /* This is just a hook for the overall driver tree.
  */
 
-static struct device_driver idedisk_devdrv = {
-	.bus = &ide_bus_type,
-	.name = "IDE disk driver",
-
-	.suspend = idedisk_suspend,
-	.resume = idedisk_resume,
-};
-
 static int idedisk_ioctl (ide_drive_t *drive, struct inode *inode,
 	struct file *file, unsigned int cmd, unsigned long arg)
 {
@@ -1717,12 +1709,6 @@
 			drive->doorlocking = 1;
 		}
 	}
-	{
-		sprintf(drive->disk->disk_dev.name, "ide-disk");
-		drive->disk->disk_dev.driver = &idedisk_devdrv;
-		drive->disk->disk_dev.driver_data = drive;
-	}
-
 #if 1
 	(void) probe_lba_addressing(drive, 1);
 #else
@@ -1806,7 +1792,7 @@
 {
 	struct gendisk *g = drive->disk;
 
-	device_unregister(&drive->disk->disk_dev);
+	device_unregister(&drive->gendev);
 	if ((drive->id->cfs_enable_2 & 0x3000) && drive->wcache)
 		if (do_idedisk_flushcache(drive))
 			printk (KERN_INFO "%s: Write Cache FAILED Flushing!\n",
@@ -1905,7 +1891,6 @@
 static int idedisk_init (void)
 {
 	ide_register_driver(&idedisk_driver);
-	driver_register(&idedisk_devdrv);
 	return 0;
 }
 
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	Wed Oct  9 11:41:39 2002
+++ b/drivers/ide/ide.c	Wed Oct  9 11:41:39 2002
@@ -3440,7 +3440,9 @@
 		list_del_init(&drive->list);
 		ata_attach(drive);
 	}
-	return 0;
+	driver->gen_driver.name = driver->name;
+	driver->gen_driver.bus = &ide_bus_type;
+	return driver_register(&driver->gen_driver);
 }
 
 EXPORT_SYMBOL(ide_register_driver);
diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	Wed Oct  9 11:41:39 2002
+++ b/include/linux/ide.h	Wed Oct  9 11:41:39 2002
@@ -1200,6 +1200,7 @@
 	int		(*attach)(ide_drive_t *);
 	void		(*ata_prebuilder)(ide_drive_t *);
 	void		(*atapi_prebuilder)(ide_drive_t *);
+	struct device_driver	gen_driver;
 	struct list_head drives;
 	struct list_head drivers;
 } ide_driver_t;

