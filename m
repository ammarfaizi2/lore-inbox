Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261881AbVBOU5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbVBOU5Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 15:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbVBOU5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 15:57:15 -0500
Received: from soundwarez.org ([217.160.171.123]:27037 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261881AbVBOUxw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 15:53:52 -0500
Date: Tue, 15 Feb 2005 21:53:44 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH ] add "bus" symlink to class/block devices
Message-ID: <20050215205344.GA1207@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a "bus" symlink to the class and block devices, just like the "driver"
and "device" links. This may be a huge speed gain for e.g. udev to determine
the bus value of a device, as we currently need to do a brute-force scan in
/sys/bus/* to find this value.

/sys
|-- block
|   |-- fd0
|   |   |-- bus -> ../../bus/platform
|   |   |-- dev
|   |   |-- device -> ../../devices/platform/floppy0
|   |   |-- queue
|   |   |   |-- iosched

|-- class
|   |-- net
|   |   |-- eth0
|   |   |   |-- addr_len
|   |   |   |-- address
|   |   |   |-- broadcast
|   |   |   |-- bus -> ../../../bus/pci
|   |   |   |-- carrier
...
|   |   |-- ttyS0
|   |   |   |-- bus -> ../../../bus/pnp
|   |   |   |-- dev
|   |   |   |-- device -> ../../../devices/pnp0/00:09
|   |   |   `-- driver -> ../../../bus/pnp/drivers/serial
...
|   |-- sound
|   |   |-- controlC0
|   |   |   |-- bus -> ../../../bus/pci
|   |   |   |-- dev
|   |   |   |-- device -> ../../../devices/pci0000:00/0000:00:1f.5
|   |   |   `-- driver -> ../../../bus/pci/drivers/Intel ICH

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>

===== drivers/base/class.c 1.58 vs edited =====
--- 1.58/drivers/base/class.c	2005-02-05 19:35:12 +01:00
+++ edited/drivers/base/class.c	2005-02-15 21:31:06 +01:00
@@ -196,33 +196,33 @@ void class_device_remove_bin_file(struct
 		sysfs_remove_bin_file(&class_dev->kobj, attr);
 }
 
-static int class_device_dev_link(struct class_device * class_dev)
+static void class_device_add_dev_symlinks(struct class_device *class_dev)
 {
-	if (class_dev->dev)
-		return sysfs_create_link(&class_dev->kobj,
-					 &class_dev->dev->kobj, "device");
-	return 0;
-}
+	if (!class_dev->dev)
+		return 0;
 
-static void class_device_dev_unlink(struct class_device * class_dev)
-{
-	sysfs_remove_link(&class_dev->kobj, "device");
-}
+	sysfs_create_link(&class_dev->kobj, &class_dev->dev->kobj, "device");
 
-static int class_device_driver_link(struct class_device * class_dev)
-{
-	if ((class_dev->dev) && (class_dev->dev->driver))
-		return sysfs_create_link(&class_dev->kobj,
-					 &class_dev->dev->driver->kobj, "driver");
-	return 0;
+	if (class_dev->dev->driver)
+		sysfs_create_link(&class_dev->kobj,
+				  &class_dev->dev->driver->kobj, "driver");
+
+	if (class_dev->dev->bus)
+		sysfs_create_link(&class_dev->kobj,
+				  &class_dev->dev->bus->subsys.kset.kobj,
+				  "bus");
 }
 
-static void class_device_driver_unlink(struct class_device * class_dev)
+static void class_device_remove_dev_symlinks(struct class_device *class_dev)
 {
+	if (!class_dev->dev)
+		return 0;
+
+	sysfs_remove_link(&class_dev->kobj, "device");
 	sysfs_remove_link(&class_dev->kobj, "driver");
+	sysfs_remove_link(&class_dev->kobj, "bus");
 }
 
-
 static ssize_t
 class_device_attr_show(struct kobject * kobj, struct attribute * attr,
 		       char * buf)
@@ -452,8 +452,7 @@ int class_device_add(struct class_device
 		class_device_create_file(class_dev, &class_device_attr_dev);
 
 	class_device_add_attrs(class_dev);
-	class_device_dev_link(class_dev);
-	class_device_driver_link(class_dev);
+	class_device_add_dev_symlinks(class_dev);
 
  register_done:
 	if (error && parent)
@@ -482,8 +481,7 @@ void class_device_del(struct class_devic
 		up_write(&parent->subsys.rwsem);
 	}
 
-	class_device_dev_unlink(class_dev);
-	class_device_driver_unlink(class_dev);
+	class_device_remove_dev_symlinks(class_dev);
 	class_device_remove_attrs(class_dev);
 
 	kobject_del(&class_dev->kobj);
===== fs/partitions/check.c 1.129 vs edited =====
--- 1.129/fs/partitions/check.c	2005-01-31 07:33:40 +01:00
+++ edited/fs/partitions/check.c	2005-02-15 21:14:43 +01:00
@@ -318,6 +318,8 @@ static void disk_sysfs_symlinks(struct g
 	struct device *target = get_device(disk->driverfs_dev);
 	if (target) {
 		sysfs_create_link(&disk->kobj,&target->kobj,"device");
+		if (target->bus)
+			sysfs_create_link(&disk->kobj,&target->bus->subsys.kset.kobj,"bus");
 		sysfs_create_link(&target->kobj,&disk->kobj,"block");
 	}
 }
@@ -438,6 +440,7 @@ void del_gendisk(struct gendisk *disk)
 
 	if (disk->driverfs_dev) {
 		sysfs_remove_link(&disk->kobj, "device");
+		sysfs_remove_link(&disk->kobj, "bus");
 		sysfs_remove_link(&disk->driverfs_dev->kobj, "block");
 		put_device(disk->driverfs_dev);
 	}

