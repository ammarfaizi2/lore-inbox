Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbWAEAuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbWAEAuL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbWAEAuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:50:10 -0500
Received: from mail.kroah.org ([69.55.234.183]:6074 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750995AbWAEAt7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:49:59 -0500
Cc: kay.sievers@vrfy.org
Subject: [PATCH] ide: MODALIAS support for autoloading of ide-cd, ide-disk, ...
In-Reply-To: <11364221703787@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 Jan 2006 16:49:30 -0800
Message-Id: <11364221702858@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] ide: MODALIAS support for autoloading of ide-cd, ide-disk, ...

IDE: MODALIAS support for autoloading of ide-cd, ide-disk, ...

Add MODULE_ALIAS to IDE midlayer modules: ide-disk, ide-cd, ide-floppy and
ide-tape, to autoload these modules depending on the probed media type of
the IDE device.

It is used by udev and replaces the former agent shell script of the hotplug
package, which was required to lookup the media type in the proc filesystem.
Using proc was racy, cause the media file is created after the hotplug event
is sent out.

The module autoloading does not take any effect, until something like the
following udev rule is configured:
  SUBSYSTEM=="ide",  ACTION=="add", ENV{MODALIAS}=="?*", RUN+="/sbin/modprobe $env{MODALIAS}"

The module ide-scsi will not be autoloaded, cause it requires manual
configuration. It can't be, and never was supported for automatic setup in
the hotplug package. Adding a MODULE_ALIAS to ide-scsi for all supported
media types, would just lead to a default blacklist entry anyway.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 263756ec228f1cdd49fc50b1f87001a4cebdfe12
tree 502925a94655348a768f25180e49126688100a8d
parent f743ca5e10f4145e0b3e6d11b9b46171e16af7ce
author Kay Sievers <kay.sievers@vrfy.org> Mon, 12 Dec 2005 18:03:44 +0100
committer Greg Kroah-Hartman <gregkh@suse.de> Wed, 04 Jan 2006 16:18:09 -0800

 drivers/ide/ide-cd.c     |    1 +
 drivers/ide/ide-disk.c   |    1 +
 drivers/ide/ide-floppy.c |    1 +
 drivers/ide/ide-tape.c   |    1 +
 drivers/ide/ide.c        |   60 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index b4d7a3e..70aeb3a 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -3509,6 +3509,7 @@ static int __init ide_cdrom_init(void)
 	return driver_register(&ide_cdrom_driver.gen_driver);
 }
 
+MODULE_ALIAS("ide:*m-cdrom*");
 module_init(ide_cdrom_init);
 module_exit(ide_cdrom_exit);
 MODULE_LICENSE("GPL");
diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
index 449522f..4e57679 100644
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
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 7d7944e..fab9b2b 100644
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
index 8af179b..4b524f6 100644
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -1904,9 +1904,69 @@ static int ide_bus_match(struct device *
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
+	ide_drive_t *drive = to_ide_device(dev);
+	return sprintf(buf, "%s\n", media_string(drive));
+}
+
+static ssize_t drivename_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	ide_drive_t *drive = to_ide_device(dev);
+	return sprintf(buf, "%s\n", drive->name);
+}
+
+static ssize_t modalias_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	ide_drive_t *drive = to_ide_device(dev);
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
+	ide_drive_t *drive = to_ide_device(dev);
+	int i = 0;
+	int length = 0;
+
+	add_uevent_var(envp, num_envp, &i, buffer, buffer_size, &length,
+		       "MEDIA=%s", media_string(drive));
+	add_uevent_var(envp, num_envp, &i, buffer, buffer_size, &length,
+		       "DRIVENAME=%s", drive->name);
+	add_uevent_var(envp, num_envp, &i, buffer, buffer_size, &length,
+		       "MODALIAS=ide:m-%s", media_string(drive));
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

