Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262591AbSJGT0N>; Mon, 7 Oct 2002 15:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262589AbSJGT0I>; Mon, 7 Oct 2002 15:26:08 -0400
Received: from air-2.osdl.org ([65.172.181.6]:5798 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S262564AbSJGTYF>;
	Mon, 7 Oct 2002 15:24:05 -0400
Date: Mon, 7 Oct 2002 12:31:27 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: torvalds@transmeta.com
cc: alan@lxorguk.ukuu.org.uk, <viro@math.psu.edu>, <andre@linux-ide.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] IDE driver model update
In-Reply-To: <Pine.LNX.4.44.0210071220020.16276-100000@cherise.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0210071231180.16276-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet@1.696.19.2, 2002-10-07 10:27:16-07:00, mochel@osdl.org
  IDE: register ide driver for all ide drives; not just for disk drives. 
  
  This adds
  	struct device_driver	gen_driver;
  
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
--- a/drivers/ide/ide-disk.c	Mon Oct  7 12:19:14 2002
+++ b/drivers/ide/ide-disk.c	Mon Oct  7 12:19:14 2002
@@ -1550,14 +1550,6 @@
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
@@ -1603,12 +1595,6 @@
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
@@ -1791,7 +1777,6 @@
 static int idedisk_init (void)
 {
 	ide_register_driver(&idedisk_driver);
-	driver_register(&idedisk_devdrv);
 	return 0;
 }
 
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	Mon Oct  7 12:19:14 2002
+++ b/drivers/ide/ide.c	Mon Oct  7 12:19:14 2002
@@ -3414,7 +3414,9 @@
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
--- a/include/linux/ide.h	Mon Oct  7 12:19:14 2002
+++ b/include/linux/ide.h	Mon Oct  7 12:19:14 2002
@@ -1187,6 +1187,7 @@
 	int		(*attach)(ide_drive_t *);
 	void		(*ata_prebuilder)(ide_drive_t *);
 	void		(*atapi_prebuilder)(ide_drive_t *);
+	struct device_driver	gen_driver;
 	struct list_head drives;
 	struct list_head drivers;
 } ide_driver_t;

