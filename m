Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030248AbWFUTxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbWFUTxs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbWFUTxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:53:19 -0400
Received: from cantor.suse.de ([195.135.220.2]:41905 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030248AbWFUTuK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:50:10 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Kay Sievers <kay.sievers@suse.de>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 19/22] [PATCH] Driver core: add generic "subsystem" link to all devices
Reply-To: Greg KH <greg@kroah.com>
Date: Wed, 21 Jun 2006 12:46:02 -0700
Message-Id: <11509192252062-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <1150919221158-git-send-email-greg@kroah.com>
References: <20060621194511.GA23982@kroah.com> <11509191652021-git-send-email-greg@kroah.com> <11509191682051-git-send-email-greg@kroah.com> <11509191721672-git-send-email-greg@kroah.com> <1150919175882-git-send-email-greg@kroah.com> <11509191781796-git-send-email-greg@kroah.com> <11509191812079-git-send-email-greg@kroah.com> <115091918546-git-send-email-greg@kroah.com> <11509191893358-git-send-email-greg@kroah.com> <1150919192294-git-send-email-greg@kroah.com> <11509191951525-git-send-email-greg@kroah.com> <11509191982588-git-send-email-greg@kroah.com> <11509192022315-git-send-email-greg@kroah.com> <11509192043044-git-send-email-greg@kroah.com> <11509192081167-git-send-email-greg@kroah.com> <11509192111668-git-send-email-greg@kroah.com> <1150919214366-git-send-email-greg@kroah.com> <1150919218895-git-send-email-greg@kroah.com> <1150919221158-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kay Sievers <kay.sievers@suse.de>

Like the SUBSYTEM= key we find in the environment of the uevent, this
creates a generic "subsystem" link in sysfs for every device. Userspace
usually doesn't care at all if its a "class" or a "bus" device. This
provides an unified way to determine the subsytem of a device, regardless
of the way the driver core has created it.

Signed-off-by: Kay Sievers <kay.sievers@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 block/genhd.c         |    7 ++-----
 drivers/base/bus.c    |    2 ++
 drivers/base/class.c  |    2 ++
 drivers/base/core.c   |    9 +++++++--
 fs/partitions/check.c |    4 ++++
 5 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 5a8d3bf..8d73395 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -17,8 +17,7 @@ #include <linux/kobj_map.h>
 #include <linux/buffer_head.h>
 #include <linux/mutex.h>
 
-static struct subsystem block_subsys;
-
+struct subsystem block_subsys;
 static DEFINE_MUTEX(block_subsys_lock);
 
 /*
@@ -511,9 +510,7 @@ static struct kset_uevent_ops block_ueve
 	.uevent		= block_uevent,
 };
 
-/* declare block_subsys. */
-static decl_subsys(block, &ktype_block, &block_uevent_ops);
-
+decl_subsys(block, &ktype_block, &block_uevent_ops);
 
 /*
  * aggregate disk stat collector.  Uses the same stats that the sysfs
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 64ba901..050d86d 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -374,6 +374,7 @@ int bus_add_device(struct device * dev)
 		error = device_add_attrs(bus, dev);
 		if (!error) {
 			sysfs_create_link(&bus->devices.kobj, &dev->kobj, dev->bus_id);
+			sysfs_create_link(&dev->kobj, &dev->bus->subsys.kset.kobj, "subsystem");
 			sysfs_create_link(&dev->kobj, &dev->bus->subsys.kset.kobj, "bus");
 		}
 	}
@@ -408,6 +409,7 @@ void bus_attach_device(struct device * d
 void bus_remove_device(struct device * dev)
 {
 	if (dev->bus) {
+		sysfs_remove_link(&dev->kobj, "subsystem");
 		sysfs_remove_link(&dev->kobj, "bus");
 		sysfs_remove_link(&dev->bus->devices.kobj, dev->bus_id);
 		device_remove_attrs(dev->bus, dev);
diff --git a/drivers/base/class.c b/drivers/base/class.c
index 50e841a..9aa1274 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -561,6 +561,7 @@ int class_device_add(struct class_device
 		goto out2;
 
 	/* add the needed attributes to this device */
+	sysfs_create_link(&class_dev->kobj, &parent_class->subsys.kset.kobj, "subsystem");
 	class_dev->uevent_attr.attr.name = "uevent";
 	class_dev->uevent_attr.attr.mode = S_IWUSR;
 	class_dev->uevent_attr.attr.owner = parent_class->owner;
@@ -737,6 +738,7 @@ void class_device_del(struct class_devic
 		sysfs_remove_link(&class_dev->kobj, "device");
 		sysfs_remove_link(&class_dev->dev->kobj, class_name);
 	}
+	sysfs_remove_link(&class_dev->kobj, "subsystem");
 	class_device_remove_file(class_dev, &class_dev->uevent_attr);
 	if (class_dev->devt_attr)
 		class_device_remove_file(class_dev, class_dev->devt_attr);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 252cf40..cc8bb97 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -319,9 +319,12 @@ int device_add(struct device *dev)
 		dev->devt_attr = attr;
 	}
 
-	if (dev->class)
+	if (dev->class) {
+		sysfs_create_link(&dev->kobj, &dev->class->subsys.kset.kobj,
+				  "subsystem");
 		sysfs_create_link(&dev->class->subsys.kset.kobj, &dev->kobj,
 				  dev->bus_id);
+	}
 
 	if ((error = device_pm_add(dev)))
 		goto PMError;
@@ -422,8 +425,10 @@ void device_del(struct device * dev)
 		klist_del(&dev->knode_parent);
 	if (dev->devt_attr)
 		device_remove_file(dev, dev->devt_attr);
-	if (dev->class)
+	if (dev->class) {
+		sysfs_remove_link(&dev->kobj, "subsystem");
 		sysfs_remove_link(&dev->class->subsys.kset.kobj, dev->bus_id);
+	}
 	device_remove_file(dev, &dev->uevent_attr);
 
 	/* Notify the platform of the removal, in case they
diff --git a/fs/partitions/check.c b/fs/partitions/check.c
index 7ef1f09..8851b81 100644
--- a/fs/partitions/check.c
+++ b/fs/partitions/check.c
@@ -329,6 +329,7 @@ void delete_partition(struct gendisk *di
 	p->ios[0] = p->ios[1] = 0;
 	p->sectors[0] = p->sectors[1] = 0;
 	devfs_remove("%s/part%d", disk->devfs_name, part);
+	sysfs_remove_link(&p->kobj, "subsystem");
 	if (p->holder_dir)
 		kobject_unregister(p->holder_dir);
 	kobject_uevent(&p->kobj, KOBJ_REMOVE);
@@ -363,6 +364,7 @@ void add_partition(struct gendisk *disk,
 	kobject_add(&p->kobj);
 	if (!disk->part_uevent_suppress)
 		kobject_uevent(&p->kobj, KOBJ_ADD);
+	sysfs_create_link(&p->kobj, &block_subsys.kset.kobj, "subsystem");
 	partition_sysfs_add_subdir(p);
 	disk->part[part-1] = p;
 }
@@ -398,6 +400,7 @@ static void disk_sysfs_symlinks(struct g
 			kfree(disk_name);
 		}
 	}
+	sysfs_create_link(&disk->kobj, &block_subsys.kset.kobj, "subsystem");
 }
 
 /* Not exported, helper to add_disk(). */
@@ -548,5 +551,6 @@ void del_gendisk(struct gendisk *disk)
 		put_device(disk->driverfs_dev);
 		disk->driverfs_dev = NULL;
 	}
+	sysfs_remove_link(&disk->kobj, "subsystem");
 	kobject_del(&disk->kobj);
 }
-- 
1.4.0

