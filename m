Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262539AbUKEAzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262539AbUKEAzG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 19:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbUKEAyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 19:54:41 -0500
Received: from mail.kroah.org ([69.55.234.183]:5855 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262532AbUKEAt0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 19:49:26 -0500
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] More Driver Core patches for 2.6.10-rc1
In-Reply-To: <10996157042662@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Thu, 4 Nov 2004 16:48:24 -0800
Message-Id: <109961570456@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2449.2.3, 2004/11/04 10:12:44-08:00, kay.sievers@vrfy.org

[PATCH] add the physical device and the bus to the hotplug environment

Add the sysfs path of the physical device to the hotplug event of class
and block devices. This should solve the userspace issue not to know if
the device is a virtual one and the "device" symlink will never be created,
but we sit there and wait for it to show up not knowing when we should
give up.

Also the bus name is added to the hotplug event, so we don't need to
reverse lookup in the /sys/bus/* directory which bus our physical
device belongs to. This is e.g. the value matched against the BUS= key,
that may be used in an udev rule.

This is a PCI network card:
  ACTION=add
  SUBSYSTEM=net
  DEVPATH=/class/net/eth0
  PHYSDEVPATH=/devices/pci0000:00/0000:00:1e.0/0000:02:01.0
  PHYSDEVBUS=pci
  INTERFACE=eth0
  SEQNUM=827
  PATH=/sbin:/bin:/usr/sbin:/usr/bin
  HOME=/

This is a IDE CDROM:
  ACTION=add
  SUBSYSTEM=block
  DEVPATH=/block/hdc
  PHYSDEVPATH=/devices/pci0000:00/0000:00:1f.1/ide1/1.0
  PHYSDEVBUS=ide
  SEQNUM=1017
  PATH=/sbin:/bin:/usr/sbin:/usr/bin
  HOME=/

This is an USB-stick partition:
  ACTION=add
  SUBSYSTEM=block
  DEVPATH=/block/sda/sda1
  PHYSDEVPATH=/devices/pci0000:00/0000:00:1d.1/usb3/3-1/3-1:1.0/host1/target1:0:0/1:0:0:0
  PHYSDEVBUS=scsi
  SEQNUM=1032
  PATH=/sbin:/bin:/usr/sbin:/usr/bin
  HOME=/


Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/class.c  |   26 ++++++++++++++++++++++++++
 drivers/block/genhd.c |   40 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 65 insertions(+), 1 deletion(-)


diff -Nru a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c	2004-11-04 16:31:01 -08:00
+++ b/drivers/base/class.c	2004-11-04 16:31:01 -08:00
@@ -283,8 +283,34 @@
 {
 	struct class_device *class_dev = to_class_dev(kobj);
 	int retval = 0;
+	int i = 0;
+	int length = 0;
 
 	pr_debug("%s - name = %s\n", __FUNCTION__, class_dev->class_id);
+
+	if (class_dev->dev) {
+		/* add physical device, backing this device  */
+		struct device *dev = class_dev->dev;
+		char *path = kobject_get_path(&dev->kobj, GFP_KERNEL);
+
+		add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size,
+				    &length, "PHYSDEVPATH=%s", path);
+		kfree(path);
+
+		/* add bus name of physical device */
+		if (dev->bus)
+			add_hotplug_env_var(envp, num_envp, &i,
+					    buffer, buffer_size, &length,
+					    "PHYSDEVBUS=%s", dev->bus->name);
+
+		/* terminate, set to next free slot, shrink available space */
+		envp[i] = NULL;
+		envp = &envp[i];
+		num_envp -= i;
+		buffer = &buffer[length];
+		buffer_size -= length;
+	}
+
 	if (class_dev->class->hotplug) {
 		/* have the bus specific function add its stuff */
 		retval = class_dev->class->hotplug (class_dev, envp, num_envp,
diff -Nru a/drivers/block/genhd.c b/drivers/block/genhd.c
--- a/drivers/block/genhd.c	2004-11-04 16:31:01 -08:00
+++ b/drivers/block/genhd.c	2004-11-04 16:31:01 -08:00
@@ -438,8 +438,46 @@
 	return ((ktype == &ktype_block) || (ktype == &ktype_part));
 }
 
+static int block_hotplug(struct kset *kset, struct kobject *kobj, char **envp,
+			 int num_envp, char *buffer, int buffer_size)
+{
+	struct device *dev = NULL;
+	struct kobj_type *ktype = get_ktype(kobj);
+	int length = 0;
+	int i = 0;
+
+	/* get physical device backing disk or partition */
+	if (ktype == &ktype_block) {
+		struct gendisk *disk = container_of(kobj, struct gendisk, kobj);
+		dev = disk->driverfs_dev;
+	} else if (ktype == &ktype_part) {
+		struct gendisk *disk = container_of(kobj->parent, struct gendisk, kobj);
+		dev = disk->driverfs_dev;
+	}
+
+	if (dev) {
+		/* add physical device, backing this device  */
+		char *path = kobject_get_path(&dev->kobj, GFP_KERNEL);
+
+		add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size,
+				    &length, "PHYSDEVPATH=%s", path);
+		kfree(path);
+
+		/* add bus name of physical device */
+		if (dev->bus)
+			add_hotplug_env_var(envp, num_envp, &i,
+					    buffer, buffer_size, &length,
+					    "PHYSDEVBUS=%s", dev->bus->name);
+
+		envp[i] = NULL;
+	}
+
+	return 0;
+}
+
 static struct kset_hotplug_ops block_hotplug_ops = {
-	.filter	= block_hotplug_filter,
+	.filter		= block_hotplug_filter,
+	.hotplug	= block_hotplug,
 };
 
 /* declare block_subsys. */

