Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbVBZFxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbVBZFxy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 00:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbVBZFxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 00:53:54 -0500
Received: from soundwarez.org ([217.160.171.123]:41625 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261406AbVBZFxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 00:53:19 -0500
Date: Sat, 26 Feb 2005 06:53:16 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Subject: split kobject creation and hotplug event generation
Message-ID: <20050226055316.GA14317@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This splits the implicit generation of a hotplug events from
kobject_add() and kobject_del(), to give the user of of these
functions control over the time the event is created.

The kobject_register() and unregister functions still have the same
behavior and emit the events by themselves.

The class, block and device core is changed now to emit the hotplug
event _after_ the "dev" file, the "device" symlink and the default
attributes are created. This will save udev from spinning in a stat() loop
to wait for the files to appear, which is expensive if we have a lot of
concurrent events.

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>

===== drivers/base/class.c 1.62 vs edited =====
--- 1.62/drivers/base/class.c	2005-02-18 19:44:34 +01:00
+++ edited/drivers/base/class.c	2005-02-26 04:49:37 +01:00
@@ -430,6 +430,7 @@ int class_device_add(struct class_device
 		sysfs_create_link(&class_dev->kobj,
 				  &class_dev->dev->kobj, "device");
 
+	kobject_hotplug(&class_dev->kobj, KOBJ_ADD);
  register_done:
 	if (error && parent)
 		class_put(parent);
@@ -461,6 +462,7 @@ void class_device_del(struct class_devic
 		sysfs_remove_link(&class_dev->kobj, "device");
 	class_device_remove_attrs(class_dev);
 
+	kobject_hotplug(&class_dev->kobj, KOBJ_REMOVE);
 	kobject_del(&class_dev->kobj);
 
 	if (parent)
===== drivers/base/core.c 1.91 vs edited =====
--- 1.91/drivers/base/core.c	2004-11-12 13:16:42 +01:00
+++ edited/drivers/base/core.c	2005-02-26 04:55:10 +01:00
@@ -260,6 +260,8 @@ int device_add(struct device *dev)
 	/* notify platform of device entry */
 	if (platform_notify)
 		platform_notify(dev);
+
+	kobject_hotplug(&dev->kobj, KOBJ_ADD);
  Done:
 	put_device(dev);
 	return error;
@@ -349,6 +351,7 @@ void device_del(struct device * dev)
 		platform_notify_remove(dev);
 	bus_remove_device(dev);
 	device_pm_remove(dev);
+	kobject_hotplug(&dev->kobj, KOBJ_REMOVE);
 	kobject_del(&dev->kobj);
 	if (parent)
 		put_device(parent);
===== drivers/usb/host/hc_crisv10.c 1.7 vs edited =====
--- 1.7/drivers/usb/host/hc_crisv10.c	2004-12-21 02:15:10 +01:00
+++ edited/drivers/usb/host/hc_crisv10.c	2005-02-26 04:56:09 +01:00
@@ -4396,6 +4396,7 @@ static int __init etrax_usb_hc_init(void
         device_initialize(&fake_device);
         kobject_set_name(&fake_device.kobj, "etrax_usb");
         kobject_add(&fake_device.kobj);
+        kobject_hotplug(&fake_device.kobj, KOBJ_ADD);
         hc->bus->controller = &fake_device;
 	usb_register_bus(hc->bus);
 
===== fs/partitions/check.c 1.129 vs edited =====
--- 1.129/fs/partitions/check.c	2005-01-31 07:33:40 +01:00
+++ edited/fs/partitions/check.c	2005-02-26 04:50:56 +01:00
@@ -337,6 +337,7 @@ void register_disk(struct gendisk *disk)
 	if ((err = kobject_add(&disk->kobj)))
 		return;
 	disk_sysfs_symlinks(disk);
+	kobject_add(&disk->kobj);
 
 	/* No minors to use for partitions */
 	if (disk->minors == 1) {
@@ -441,5 +442,6 @@ void del_gendisk(struct gendisk *disk)
 		sysfs_remove_link(&disk->driverfs_dev->kobj, "block");
 		put_device(disk->driverfs_dev);
 	}
+	kobject_hotplug(&disk->kobj, KOBJ_REMOVE);
 	kobject_del(&disk->kobj);
 }
===== lib/kobject.c 1.58 vs edited =====
--- 1.58/lib/kobject.c	2005-02-18 08:56:36 +01:00
+++ edited/lib/kobject.c	2005-02-26 04:48:18 +01:00
@@ -184,8 +184,6 @@ int kobject_add(struct kobject * kobj)
 		unlink(kobj);
 		if (parent)
 			kobject_put(parent);
-	} else {
-		kobject_hotplug(kobj, KOBJ_ADD);
 	}
 
 	return error;
@@ -207,7 +205,8 @@ int kobject_register(struct kobject * ko
 			printk("kobject_register failed for %s (%d)\n",
 			       kobject_name(kobj),error);
 			dump_stack();
-		}
+		} else
+			kobject_hotplug(kobj, KOBJ_ADD);
 	} else
 		error = -EINVAL;
 	return error;
@@ -301,7 +300,6 @@ int kobject_rename(struct kobject * kobj
 
 void kobject_del(struct kobject * kobj)
 {
-	kobject_hotplug(kobj, KOBJ_REMOVE);
 	sysfs_remove_dir(kobj);
 	unlink(kobj);
 }
@@ -314,6 +312,7 @@ void kobject_del(struct kobject * kobj)
 void kobject_unregister(struct kobject * kobj)
 {
 	pr_debug("kobject %s: unregistering\n",kobject_name(kobj));
+	kobject_hotplug(kobj, KOBJ_REMOVE);
 	kobject_del(kobj);
 	kobject_put(kobj);
 }
===== net/bridge/br_sysfs_if.c 1.2 vs edited =====
--- 1.2/net/bridge/br_sysfs_if.c	2004-06-18 22:15:34 +02:00
+++ edited/net/bridge/br_sysfs_if.c	2005-02-26 04:51:32 +01:00
@@ -248,6 +248,7 @@ int br_sysfs_addif(struct net_bridge_por
 	if (err)
 		goto out2;
 
+	kobject_hotplug(&p->kobj, KOBJ_ADD);
 	return 0;
  out2:
 	kobject_del(&p->kobj);
@@ -259,6 +260,7 @@ void br_sysfs_removeif(struct net_bridge
 {
 	pr_debug("br_sysfs_removeif\n");
 	sysfs_remove_link(&p->br->ifobj, p->dev->name);
+	kobject_hotplug(&p->kobj, KOBJ_REMOVE);
 	kobject_del(&p->kobj);
 }
 

