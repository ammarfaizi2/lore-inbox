Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbVLCRYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbVLCRYV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 12:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbVLCRYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 12:24:20 -0500
Received: from soundwarez.org ([217.160.171.123]:63182 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S932099AbVLCRYU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 12:24:20 -0500
Date: Sat, 3 Dec 2005 18:24:18 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Greg KH <greg@kroah.com>
Subject: ide: MODALIAS support for autoloading of ide-cd, ide-disk, ...
Message-ID: <20051203172418.GA12297@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This applies on top of the changes currently in the -mm tree, which
rename ".hotplug" to ".uevent". I don't have any IDE hardware left
around here, so I've tested it only with a PCMCIA CF adapter. :)

Thanks,
Kay



From: Kay Sievers <kay.sievers@suse.de>

IDE: MODALIAS support for autoloading of ide-cd, ide-disk, ...

Add MODULE_ALIAS to IDE midlayer modules to autoload them depending
on the probed media type.

  $ modinfo ide-disk
  filename:       /lib/modules/2.6.15-rc4-g1b0997f5/kernel/drivers/ide/ide-disk.ko
  description:    ATA DISK Driver
  alias:          ide:*m-disk*
  license:        GPL
  ...

  $ modprobe -vn ide:m-disk
  insmod /lib/modules/2.6.15-rc4-g1b0997f5/kernel/drivers/ide/ide-disk.ko 

  $ cat /sys/bus/ide/devices/0.0/modalias
  ide:m-disk

It also adds attributes to the IDE device:
  $ tree /sys/bus/ide/devices/0.0/
  /sys/bus/ide/devices/0.0/
  |-- bus -> ../../../../../../../bus/ide
  |-- drivename
  |-- media
  |-- modalias
  |-- power
  |   |-- state
  |   `-- wakeup
  `-- uevent

  $ cat /sys/bus/ide/devices/0.0/{modalias,drivename,media}
  ide:m-disk
  hda
  disk

Signed-off-by: Kay Sievers <kay.sievers@suse.de>
---
diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 9455e42..24e3e64 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -3516,6 +3516,7 @@ static int __init ide_cdrom_init(void)
 	return driver_register(&ide_cdrom_driver.gen_driver);
 }
 
+MODULE_ALIAS("ide:*m-cdrom*");
 module_init(ide_cdrom_init);
 module_exit(ide_cdrom_exit);
 MODULE_LICENSE("GPL");
diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
index f4e3d35..06fb261 100644
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -1271,6 +1271,7 @@ static int __init idedisk_init(void)
 	return driver_register(&idedisk_driver.gen_driver);
 }
 
+MODULE_ALIAS("ide:*m-disk*");
 module_init(idedisk_init);
 module_exit(idedisk_exit);
 MODULE_LICENSE("GPL");
diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index 9e293c8..fba3fff 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -2197,6 +2197,7 @@ static int __init idefloppy_init(void)
 	return driver_register(&idefloppy_driver.gen_driver);
 }
 
+MODULE_ALIAS("ide:*m-floppy*");
 module_init(idefloppy_init);
 module_exit(idefloppy_exit);
 MODULE_LICENSE("GPL");
diff --git a/drivers/ide/ide-generic.c b/drivers/ide/ide-generic.c
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 7d7944e..a621548 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -4947,6 +4947,7 @@ out:
 	return error;
 }
 
+MODULE_ALIAS("ide:*m-tape*");
 module_init(idetape_init);
 module_exit(idetape_exit);
 MODULE_ALIAS_CHARDEV_MAJOR(IDETAPE_MAJOR);
diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
index 8af179b..96d39a1 100644
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -1904,9 +1904,73 @@ static int ide_bus_match(struct device *
 	return 1;
 }
 
+static char *media_string(ide_drive_t *drive)
+{
+	switch (drive->media) {
+	case ide_disk:
+		return "disk";
+	case ide_cdrom:
+		return "cdrom";
+	case ide_tape:
+		return "tape";
+	case ide_floppy:
+		return "floppy";
+	default:
+		return "UNKNOWN";
+	}
+}
+
+static ssize_t media_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	ide_drive_t *drive = dev->driver_data;
+	return sprintf(buf, "%s\n", media_string(drive));
+}
+
+static ssize_t drivename_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	ide_drive_t *drive = dev->driver_data;
+	return sprintf(buf, "%s\n", drive->name);
+}
+
+static ssize_t modalias_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	ide_drive_t *drive = dev->driver_data;
+	return sprintf(buf, "ide:m-%s\n", media_string(drive));
+}
+
+static struct device_attribute ide_dev_attrs[] = {
+	__ATTR_RO(media),
+	__ATTR_RO(drivename),
+	__ATTR_RO(modalias),
+	__ATTR_NULL
+};
+
+static int ide_uevent(struct device *dev, char **envp, int num_envp,
+		      char *buffer, int buffer_size)
+{
+	ide_drive_t *drive = dev->driver_data;
+	int i = 0;
+	int length = 0;
+
+	add_uevent_var(envp, num_envp, &i, buffer, buffer_size, &length,
+		       "MEDIA=%s", media_string(drive));
+
+	add_uevent_var(envp, num_envp, &i, buffer, buffer_size, &length,
+		       "DRIVENAME=%s", drive->name);
+
+	add_uevent_var(envp, num_envp, &i, buffer, buffer_size, &length,
+		       "MODALIAS=ide:m-%s",
+		       media_string(drive));
+
+	envp[i] = NULL;
+	return 0;
+}
+
 struct bus_type ide_bus_type = {
 	.name		= "ide",
 	.match		= ide_bus_match,
+	.uevent		= ide_uevent,
+	.dev_attrs	= ide_dev_attrs,
 	.suspend	= generic_ide_suspend,
 	.resume		= generic_ide_resume,
 };


