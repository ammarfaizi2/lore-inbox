Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbWAPNn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWAPNn0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 08:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWAPNn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 08:43:26 -0500
Received: from soundwarez.org ([217.160.171.123]:2440 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1750758AbWAPNnZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 08:43:25 -0500
Date: Mon, 16 Jan 2006 14:43:14 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Subject: Re: unify sysfs device tree
Message-ID: <20060116134314.GA10813@vrfy.org>
References: <20060113015652.GA30796@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060113015652.GA30796@vrfy.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2006 at 02:56:52AM +0100, Kay Sievers wrote:

> Here is a first test of the unification of the sysfs device tree. As already
> discussed to end in the context of stacked class devices, it moves all device
> objects into a single device tree at /sys/devices to expose the kernels device
> hierarchy to userspace.
> 
> All former objects in /sys/class will become only symlinks and are compatible
> to our current layout. This approach will not mix classification and device
> hierarchy.
> 
> The hierarchy in /sys/devices is not necessarily expected to be stable across
> kernel versions, it must be allowed to insert devices in the tree if needed,
> without breaking userspace applications. But the links in /sys/class are
> expected to be kept stable, but that's easy now, cause they will always be
> simple flat directories.
> 
> Every device event sent to userspace contains its natural dependency path in the
> DEVPATH, the ugly "device" symlink can be removed.
> 
> This patch is a simple hack, cause I want to prepare userspace to work with
> that. It already works without any problems on a recent udev system. (Besides
> HAL which needs to be adapted.)
> 
> The same way /sys/class is represented, /sys/block should be converted, so we
> finally end up with a buch of symlinks in /sys/class/block.
> 
> There is a lot of room for improvement in the driver core, cause a whole lot
> of infrastructure could be shared between the class / block / device core, if
> we only build a single device tree, but that's a different issue and independent
> from how it will looks like to userspace.
> 
> Here is for illustration the "input" layer as a flat /sys/class directory. All
> devices point to /sys/devices which exposes the device hierarchy if userspace
> wants to know that:
> 	/sys/class/
> 	...
> 	|-- input
> 	|   |-- input0 -> ../../devices/platform/i8042/serio1/input0
> 	|   |-- input1 -> ../../devices/platform/i8042/serio0/input1
> 	|   |-- input3 -> ../../devices/platform/i8042/serio0/serio2/input3
> 	|   |-- input4 -> ../../devices/pci0000:00/0000:00:1d.1/usb3/3-2/3-2:1.0/input4
> 	|   |-- mice -> ../../devices/mice
> 	|   |-- mouse0 -> ../../devices/platform/i8042/serio0/input1/mouse0
> 	|   |-- mouse1 -> ../../devices/pci0000:00/0000:00:1d.1/usb3/3-2/3-2:1.0/input4/mouse1
> 	|   `-- mouse2 -> ../../devices/platform/i8042/serio0/serio2/input3/mouse2
> 	|-- mem
> 	|   |-- full -> ../../devices/full
> 	|   |-- kmem -> ../../devices/kmem
> 	|   |-- kmsg -> ../../devices/kmsg
> 	|   |-- mem -> ../../devices/mem
> 	|   |-- null -> ../../devices/null
> 	|   |-- port -> ../../devices/port
> 	|   |-- random -> ../../devices/random
> 	|   |-- urandom -> ../../devices/urandom
> 	|   `-- zero -> ../../devices/zero
> 	...
> 
> 
> 	/sys/devices/
> 	|-- platform
> 	|   |-- i8042
> 	|   |   |-- bus -> ../../../bus/platform
> 	|   |   |-- driver -> ../../../bus/platform/drivers/i8042
> 	|   |   |-- power
> 	|   |   |   |-- state
> 	|   |   |   `-- wakeup
> 	|   |   |-- serio0
> 	|   |   |   |-- bind_mode
> 	|   |   |   |-- bus -> ../../../../bus/serio
> 	|   |   |   |-- description
> 	|   |   |   |-- driver -> ../../../../bus/serio/drivers/psmouse
> 	|   |   |   |-- drvctl
> 	|   |   |   |-- id
> 	...
> 	|   |   |   |   `-- type
> 	|   |   |   |-- input1
> 	|   |   |   |   |-- capabilities
> 	...
> 	|   |   |   |   |   `-- sw
> 	|   |   |   |   |-- device -> ../../../../../devices/platform/i8042/serio0
> 	|   |   |   |   |-- id
> 	...
> 	|   |   |   |   |   `-- version
> 	|   |   |   |   |-- modalias
> 	|   |   |   |   |-- mouse0
> 	|   |   |   |   |   |-- dev
> 	|   |   |   |   |   |-- device -> ../../../../../../devices/platform/i8042/serio0
> 	|   |   |   |   |   |-- subsystem -> ../../../../../../class/input
> 	|   |   |   |   |   `-- uevent
> 	...
> 
> 
> This is the event sequence for a USB mouse, there are no "class" events
> anymore:
> 	add@/devices/pci0000:00/0000:00:1d.1/usb3/3-2
> 	add@/devices/pci0000:00/0000:00:1d.1/usb3/3-2/3-2:1.0
> 	add@/devices/pci0000:00/0000:00:1d.1/usb3/3-2/3-2:1.0/input5
> 	add@/devices/pci0000:00/0000:00:1d.1/usb3/3-2/3-2:1.0/input5/mouse1
> 	add@/devices/pci0000:00/0000:00:1d.1/usb3/3-2/usbdev3.4

Here is an updated patch, that:
  o moves the devices in /sys/block to /sys/devices to match the
    class layout. Block devices will be childs of their physical
    device chain like every other class device too. Partitions
    will be childs of the disk device. A usual DEVPATH looks like:
      /devices/pci0000:00/0000:00:1f.2/host0/target0:0:0/0:0:0:0/sda/sda1

  o flattens the block class view and moves the block symlinks to
    /sys/class/block. Disks and partitons like /sys/class/block/sda
    and /sys/class/block/sda1 will be at the same level. /sys/block
    does not longer exist.

  o removes all "device" links, cause the these devices are just the
    parent devices in /sys/devices and contained in the devpath anyway.

  o removes all "block:<devname>" and "<classname>:<devname>" links,
    cause this relationship is expressed by the hierarchy in
    /sys/devices and these devices are just found as child devices.

  o removes PHYSDEVBUS, PHYSDEVPATH, PHYSDEVDRIVER from the event
    environment. These have been added to work around bad sysfs timing
    and let udev know what to expect from sysfs. It's not longer needed,
    cause the dependency of devices is nicely contained in every device
    devpath itself.

  o removes all "bus" links to make no distinction between the kernel
    implementation details at the device itself. All devices in /sys/devices
    have a "subsystem" symlink now, which points back to the bus or
    class directory the device belongs to. Class devices are collected by
    symlinks in /sys/class/<classname>/, bus devices are collected in
    /sys/bus/<busname>/devices/.

It looks like this for block:
  /sys/
  |-- class
  |   |-- block
  |   |   |-- loop0 -> ../../devices/loop0
  |   |   |-- loop1 -> ../../devices/loop1
  |   |   |-- loop2 -> ../../devices/loop2
  ...
  |   |   |-- sda -> ../../devices/pci0000:00/0000:00:1f.2/host0/target0:0:0/0:0:0:0/sda
  |   |   |-- sda1 -> ../../devices/pci0000:00/0000:00:1f.2/host0/target0:0:0/0:0:0:0/sda/sda1
  ...
  |   |   `-- sda9 -> ../../devices/pci0000:00/0000:00:1f.2/host0/target0:0:0/0:0:0:0/sda/sda9
  ...
  |-- devices
  ...
  |   |-- loop0
  |   |   |-- dev
  |   |   |-- range
  |   |   |-- removable
  |   |   |-- size
  |   |   |-- stat
  |   |   |-- subsystem -> ../../class/block
  |   |   `-- uevent
  |   |-- loop1
  |   |   |-- dev
  |   |   |-- range
  |   |   |-- removable
  |   |   |-- size
  |   |   |-- stat
  |   |   |-- subsystem -> ../../class/block
  |   |   `-- uevent
  |   |-- loop2
  |   |   |-- dev
  ...
  |   |-- pci0000:00
  |   |   |-- 0000:00:1f.2
  |   |   |   |-- class
  |   |   |   |-- config
  |   |   |   |-- device
  |   |   |   |-- driver -> ../../../bus/pci/drivers/ata_piix
  |   |   |   |-- host0
  |   |   |   |   |-- host0
  |   |   |   |   |   |-- cmd_per_lun
  |   |   |   |   |   |-- host_busy
  |   |   |   |   |   |-- proc_name
  |   |   |   |   |   |-- scan
  |   |   |   |   |   |-- sg_tablesize
  |   |   |   |   |   |-- state
  |   |   |   |   |   |-- subsystem -> ../../../../../class/scsi_host
  |   |   |   |   |   |-- uevent
  |   |   |   |   |   |-- unchecked_isa_dma
  |   |   |   |   |   `-- unique_id
  |   |   |   |   |-- power
  |   |   |   |   |   |-- state
  |   |   |   |   |   `-- wakeup
  |   |   |   |   |-- target0:0:0
  |   |   |   |   |   |-- 0:0:0:0
  |   |   |   |   |   |   |-- 0:0:0:0
  |   |   |   |   |   |   |   |-- subsystem -> ../../../../../../../class/scsi_device
  |   |   |   |   |   |   |   `-- uevent
  |   |   |   |   |   |   |-- delete
  |   |   |   |   |   |   |-- device_blocked
  |   |   |   |   |   |   |-- driver -> ../../../../../../bus/scsi/drivers/sd
  |   |   |   |   |   |   |-- generic -> ../../../../../../devices/pci0000:00/0000:00:1f.2/host0/target0:0:0/0:0:0:0/sg0
  |   |   |   |   |   |   |-- iocounterbits
  |   |   |   |   |   |   |-- iodone_cnt
  |   |   |   |   |   |   |-- ioerr_cnt
  |   |   |   |   |   |   |-- iorequest_cnt
  |   |   |   |   |   |   |-- model
  |   |   |   |   |   |   |-- power
  |   |   |   |   |   |   |   |-- state
  |   |   |   |   |   |   |   `-- wakeup
  |   |   |   |   |   |   |-- queue_depth
  |   |   |   |   |   |   |-- queue_type
  |   |   |   |   |   |   |-- rescan
  |   |   |   |   |   |   |-- rev
  |   |   |   |   |   |   |-- scsi_level
  |   |   |   |   |   |   |-- sda
  |   |   |   |   |   |   |   |-- dev
  |   |   |   |   |   |   |   |-- queue
  |   |   |   |   |   |   |   |   |-- iosched
  |   |   |   |   |   |   |   |   |   |-- antic_expire
  |   |   |   |   |   |   |   |   |   |-- est_time
  |   |   |   |   |   |   |   |   |   |-- read_batch_expire
  |   |   |   |   |   |   |   |   |   |-- read_expire
  |   |   |   |   |   |   |   |   |   |-- write_batch_expire
  |   |   |   |   |   |   |   |   |   `-- write_expire
  |   |   |   |   |   |   |   |   |-- max_hw_sectors_kb
  |   |   |   |   |   |   |   |   |-- max_sectors_kb
  |   |   |   |   |   |   |   |   |-- nr_requests
  |   |   |   |   |   |   |   |   |-- read_ahead_kb
  |   |   |   |   |   |   |   |   `-- scheduler
  |   |   |   |   |   |   |   |-- range
  |   |   |   |   |   |   |   |-- removable
  |   |   |   |   |   |   |   |-- sda1
  |   |   |   |   |   |   |   |   |-- dev
  |   |   |   |   |   |   |   |   |-- size
  |   |   |   |   |   |   |   |   |-- start
  |   |   |   |   |   |   |   |   |-- stat
  |   |   |   |   |   |   |   |   |-- subsystem -> ../../../../../../../../class/block
  |   |   |   |   |   |   |   |   `-- uevent
  |   |   |   |   |   |   |   |-- sda10
  |   |   |   |   |   |   |   |   |-- dev
  |   |   |   |   |   |   |   |   |-- size
  |   |   |   |   |   |   |   |   |-- start
  |   |   |   |   |   |   |   |   |-- stat
  |   |   |   |   |   |   |   |   |-- subsystem -> ../../../../../../../../class/block
  |   |   |   |   |   |   |   |   `-- uevent
  ...

Note, that this is still a patch, only to _fake_ sysfs to look like it
should in the end and nothing to merge in the kernel tree. I didn't care
about the implementation, it is just to prepare userspace to work with
that long before we actually will change the kernel. The current udev
already works with this patch and a fully dynamic /dev, that is populated
from scratch on bootup.

I've removed all historical stuff like the "device" and "bus" link,
cause they don't make sense anymore. What we will actually remove with
the real conversion, does nobody know at this point. But this patch can
be used today, to test software that uses sysfs. For udev, the udev
related tools and HAL I will take care of and prepare them. Libsysfs,
which udev does not longer use, will need to be adapted to this layout.

Thanks,
Kay


Unify sysfs device tree

Move device objects from /sys/class and /sys/block to /sys/devices and add
a link from /sys/class to the device object.
---
 Documentation/Changes    |    2 -
 block/genhd.c            |   40 ++++-----------------
 drivers/base/bus.c       |    4 +-
 drivers/base/class.c     |   89 +++++++++--------------------------------------
 drivers/input/evdev.c    |    5 --
 drivers/input/joydev.c   |    5 --
 drivers/input/mousedev.c |    5 --
 drivers/input/tsdev.c    |    5 --
 fs/partitions/check.c    |   78 +++++++++++++++++++----------------------
 init/do_mounts.c         |    4 +-
 10 files changed, 68 insertions(+), 169 deletions(-)

diff --git a/Documentation/Changes b/Documentation/Changes
index fe5ae0f..b541e18 100644
--- a/Documentation/Changes
+++ b/Documentation/Changes
@@ -63,7 +63,7 @@ o  isdn4k-utils           3.1pre1       
 o  nfs-utils              1.0.5                   # showmount --version
 o  procps                 3.2.0                   # ps --version
 o  oprofile               0.9                     # oprofiled --version
-o  udev                   071                     # udevinfo -V
+o  udev                   081                     # udevinfo -V
 
 Kernel compilation
 ==================
diff --git a/block/genhd.c b/block/genhd.c
index db57546..8acc309 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -17,9 +17,8 @@
 #include <linux/buffer_head.h>
 
 #define MAX_PROBE_HASH 255	/* random */
-
-static struct subsystem block_subsys;
-
+struct subsystem block_subsys;
+extern struct subsystem class_subsys;
 static DECLARE_MUTEX(block_subsys_sem);
 
 /*
@@ -312,7 +311,7 @@ static void *part_next(struct seq_file *
 {
 	struct list_head *p = ((struct gendisk *)v)->kobj.entry.next;
 	++*pos;
-	return p==&block_subsys.kset.list ? NULL : 
+	return p == &block_subsys.kset.list ? NULL : 
 		list_entry(p, struct gendisk, kobj.entry);
 }
 
@@ -379,6 +378,8 @@ static int __init genhd_device_init(void
 {
 	bdev_map = kobj_map_init(base_probe, &block_subsys_sem);
 	blk_dev_init();
+
+	block_subsys.kset.kobj.parent = &class_subsys.kset.kobj;
 	subsystem_register(&block_subsys);
 	return 0;
 }
@@ -532,7 +533,6 @@ static int block_uevent(struct kset *kse
 			 int num_envp, char *buffer, int buffer_size)
 {
 	struct kobj_type *ktype = get_ktype(kobj);
-	struct device *physdev;
 	struct gendisk *disk;
 	struct hd_struct *part;
 	int length = 0;
@@ -554,28 +554,6 @@ static int block_uevent(struct kset *kse
 	add_uevent_var(envp, num_envp, &i, buffer, buffer_size, &length,
 		       "MAJOR=%u", disk->major);
 
-	/* add physical device, backing this device  */
-	physdev = disk->driverfs_dev;
-	if (physdev) {
-		char *path = kobject_get_path(&physdev->kobj, GFP_KERNEL);
-
-		add_uevent_var(envp, num_envp, &i, buffer, buffer_size,
-			       &length, "PHYSDEVPATH=%s", path);
-		kfree(path);
-
-		if (physdev->bus)
-			add_uevent_var(envp, num_envp, &i,
-				       buffer, buffer_size, &length,
-				       "PHYSDEVBUS=%s",
-				       physdev->bus->name);
-
-		if (physdev->driver)
-			add_uevent_var(envp, num_envp, &i,
-				       buffer, buffer_size, &length,
-				       "PHYSDEVDRIVER=%s",
-				       physdev->driver->name);
-	}
-
 	/* terminate, set to next free slot, shrink available space */
 	envp[i] = NULL;
 	envp = &envp[i];
@@ -591,9 +569,7 @@ static struct kset_uevent_ops block_ueve
 	.uevent		= block_uevent,
 };
 
-/* declare block_subsys. */
-static decl_subsys(block, &ktype_block, &block_uevent_ops);
-
+decl_subsys(block, &ktype_block, &block_uevent_ops);
 
 /*
  * aggregate disk stat collector.  Uses the same stats that the sysfs
@@ -622,7 +598,7 @@ static void *diskstats_next(struct seq_f
 {
 	struct list_head *p = ((struct gendisk *)v)->kobj.entry.next;
 	++*pos;
-	return p==&block_subsys.kset.list ? NULL :
+	return p == &block_subsys.kset.list ? NULL :
 		list_entry(p, struct gendisk, kobj.entry);
 }
 
@@ -708,7 +684,7 @@ struct gendisk *alloc_disk_node(int mino
 			memset(disk->part, 0, size);
 		}
 		disk->minors = minors;
-		kobj_set_kset_s(disk,block_subsys);
+		kobj_set_kset_s(disk, block_subsys);
 		kobject_init(&disk->kobj);
 		rand_initialize_disk(disk);
 	}
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 29f6af5..e7dddc4 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -369,7 +369,7 @@ int bus_add_device(struct device * dev)
 		error = device_add_attrs(bus, dev);
 		if (!error) {
 			sysfs_create_link(&bus->devices.kobj, &dev->kobj, dev->bus_id);
-			sysfs_create_link(&dev->kobj, &dev->bus->subsys.kset.kobj, "bus");
+			sysfs_create_link(&dev->kobj, &dev->bus->subsys.kset.kobj, "subsystem");
 		}
 	}
 	return error;
@@ -387,7 +387,7 @@ int bus_add_device(struct device * dev)
 void bus_remove_device(struct device * dev)
 {
 	if (dev->bus) {
-		sysfs_remove_link(&dev->kobj, "bus");
+		sysfs_remove_link(&dev->kobj, "subsystem");
 		sysfs_remove_link(&dev->bus->devices.kobj, dev->bus_id);
 		device_remove_attrs(dev->bus, dev);
 		klist_remove(&dev->knode_bus);
diff --git a/drivers/base/class.c b/drivers/base/class.c
index df7fdab..b82e700 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -20,6 +20,9 @@
 #include <linux/slab.h>
 #include "base.h"
 
+extern struct subsystem devices_subsys;
+struct subsystem class_subsys;
+
 #define to_class_attr(_attr) container_of(_attr, struct class_attribute, attr)
 #define to_class(obj) container_of(obj, struct class, subsys.kset.kobj)
 
@@ -71,9 +74,7 @@ static struct kobj_type ktype_class = {
 	.release	= class_release,
 };
 
-/* Hotplug events for classes go to the class_obj subsys */
-static decl_subsys(class, &ktype_class, NULL);
-
+decl_subsys(class, &ktype_class, NULL);
 
 int class_create_file(struct class * cls, const struct class_attribute * attr)
 {
@@ -360,26 +361,6 @@ static int class_uevent(struct kset *kse
 
 	pr_debug("%s - name = %s\n", __FUNCTION__, class_dev->class_id);
 
-	if (class_dev->dev) {
-		/* add physical device, backing this device  */
-		struct device *dev = class_dev->dev;
-		char *path = kobject_get_path(&dev->kobj, GFP_KERNEL);
-
-		add_uevent_var(envp, num_envp, &i, buffer, buffer_size,
-			       &length, "PHYSDEVPATH=%s", path);
-		kfree(path);
-
-		if (dev->bus)
-			add_uevent_var(envp, num_envp, &i,
-				       buffer, buffer_size, &length,
-				       "PHYSDEVBUS=%s", dev->bus->name);
-
-		if (dev->driver)
-			add_uevent_var(envp, num_envp, &i,
-				       buffer, buffer_size, &length,
-				       "PHYSDEVDRIVER=%s", dev->driver->name);
-	}
-
 	if (MAJOR(class_dev->devt)) {
 		add_uevent_var(envp, num_envp, &i,
 			       buffer, buffer_size, &length,
@@ -475,24 +456,6 @@ void class_device_initialize(struct clas
 	INIT_LIST_HEAD(&class_dev->node);
 }
 
-static char *make_class_name(struct class_device *class_dev)
-{
-	char *name;
-	int size;
-
-	size = strlen(class_dev->class->name) +
-		strlen(kobject_name(&class_dev->kobj)) + 2;
-
-	name = kmalloc(size, GFP_KERNEL);
-	if (!name)
-		return ERR_PTR(-ENOMEM);
-
-	strcpy(name, class_dev->class->name);
-	strcat(name, ":");
-	strcat(name, kobject_name(&class_dev->kobj));
-	return name;
-}
-
 int class_device_add(struct class_device *class_dev)
 {
 	struct class *parent_class = NULL;
@@ -518,15 +481,25 @@ int class_device_add(struct class_device
 
 	/* first, register with generic layer. */
 	kobject_set_name(&class_dev->kobj, "%s", class_dev->class_id);
+
+	/* set parent for sysfs location */
 	if (parent_class_dev)
 		class_dev->kobj.parent = &parent_class_dev->kobj;
+	else if (class_dev->dev)
+		class_dev->kobj.parent = &class_dev->dev->kobj;
 	else
-		class_dev->kobj.parent = &parent_class->subsys.kset.kobj;
+		class_dev->kobj.parent = &devices_subsys.kset.kobj;
 
 	error = kobject_add(&class_dev->kobj);
 	if (error)
 		goto register_done;
 
+	/* create link from class to device object */
+	sysfs_create_link(&parent_class->subsys.kset.kobj, &class_dev->kobj, class_dev->class_id);
+
+	/* create link from device object back to class */
+	sysfs_create_link(&class_dev->kobj, &parent_class->subsys.kset.kobj, "subsystem");
+
 	/* add the needed attributes to this device */
 	class_dev->uevent_attr.attr.name = "uevent";
 	class_dev->uevent_attr.attr.mode = S_IWUSR;
@@ -551,14 +524,6 @@ int class_device_add(struct class_device
 	}
 
 	class_device_add_attrs(class_dev);
-	if (class_dev->dev) {
-		class_name = make_class_name(class_dev);
-		sysfs_create_link(&class_dev->kobj,
-				  &class_dev->dev->kobj, "device");
-		sysfs_create_link(&class_dev->dev->kobj, &class_dev->kobj,
-				  class_name);
-	}
-
 	kobject_uevent(&class_dev->kobj, KOBJ_ADD);
 
 	/* notify any interfaces this device is now here */
@@ -664,17 +629,15 @@ void class_device_del(struct class_devic
 		up(&parent_class->sem);
 	}
 
-	if (class_dev->dev) {
-		class_name = make_class_name(class_dev);
-		sysfs_remove_link(&class_dev->kobj, "device");
-		sysfs_remove_link(&class_dev->dev->kobj, class_name);
-	}
+	sysfs_remove_link(&class_dev->kobj, "subsystem");
+
 	class_device_remove_file(class_dev, &class_dev->uevent_attr);
 	if (class_dev->devt_attr)
 		class_device_remove_file(class_dev, class_dev->devt_attr);
 	class_device_remove_attrs(class_dev);
 
 	kobject_uevent(&class_dev->kobj, KOBJ_REMOVE);
+	sysfs_remove_link(&parent_class->subsys.kset.kobj, class_dev->class_id);
 	kobject_del(&class_dev->kobj);
 
 	class_device_put(parent_device);
@@ -719,7 +682,6 @@ void class_device_destroy(struct class *
 int class_device_rename(struct class_device *class_dev, char *new_name)
 {
 	int error = 0;
-	char *old_class_name = NULL, *new_class_name = NULL;
 
 	class_dev = class_device_get(class_dev);
 	if (!class_dev)
@@ -728,24 +690,9 @@ int class_device_rename(struct class_dev
 	pr_debug("CLASS: renaming '%s' to '%s'\n", class_dev->class_id,
 		 new_name);
 
-	if (class_dev->dev)
-		old_class_name = make_class_name(class_dev);
-
 	strlcpy(class_dev->class_id, new_name, KOBJ_NAME_LEN);
-
 	error = kobject_rename(&class_dev->kobj, new_name);
-
-	if (class_dev->dev) {
-		new_class_name = make_class_name(class_dev);
-		sysfs_create_link(&class_dev->dev->kobj, &class_dev->kobj,
-				  new_class_name);
-		sysfs_remove_link(&class_dev->dev->kobj, old_class_name);
-	}
 	class_device_put(class_dev);
-
-	kfree(old_class_name);
-	kfree(new_class_name);
-
 	return error;
 }
 
diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 745979f..f78fb1d 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -630,10 +630,6 @@ static struct input_handle *evdev_connec
 			MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + minor),
 			dev->cdev.dev, evdev->name);
 
-	/* temporary symlink to keep userspace happy */
-	sysfs_create_link(&input_class.subsys.kset.kobj, &cdev->kobj,
-			  evdev->name);
-
 	return &evdev->handle;
 }
 
@@ -642,7 +638,6 @@ static void evdev_disconnect(struct inpu
 	struct evdev *evdev = handle->private;
 	struct evdev_list *list;
 
-	sysfs_remove_link(&input_class.subsys.kset.kobj, evdev->name);
 	class_device_destroy(&input_class,
 			MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + evdev->minor));
 	evdev->exist = 0;
diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index 20e2972..ecf8919 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -518,10 +518,6 @@ static struct input_handle *joydev_conne
 			MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + minor),
 			dev->cdev.dev, joydev->name);
 
-	/* temporary symlink to keep userspace happy */
-	sysfs_create_link(&input_class.subsys.kset.kobj, &cdev->kobj,
-			  joydev->name);
-
 	return &joydev->handle;
 }
 
@@ -530,7 +526,6 @@ static void joydev_disconnect(struct inp
 	struct joydev *joydev = handle->private;
 	struct joydev_list *list;
 
-	sysfs_remove_link(&input_class.subsys.kset.kobj, joydev->name);
 	class_device_destroy(&input_class, MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + joydev->minor));
 	joydev->exist = 0;
 
diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
index 81fd7a9..4e0881b 100644
--- a/drivers/input/mousedev.c
+++ b/drivers/input/mousedev.c
@@ -653,10 +653,6 @@ static struct input_handle *mousedev_con
 			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + minor),
 			dev->cdev.dev, mousedev->name);
 
-	/* temporary symlink to keep userspace happy */
-	sysfs_create_link(&input_class.subsys.kset.kobj, &cdev->kobj,
-			  mousedev->name);
-
 	return &mousedev->handle;
 }
 
@@ -665,7 +661,6 @@ static void mousedev_disconnect(struct i
 	struct mousedev *mousedev = handle->private;
 	struct mousedev_list *list;
 
-	sysfs_remove_link(&input_class.subsys.kset.kobj, mousedev->name);
 	class_device_destroy(&input_class,
 			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + mousedev->minor));
 	mousedev->exist = 0;
diff --git a/drivers/input/tsdev.c b/drivers/input/tsdev.c
index ca15479..cfd4dee 100644
--- a/drivers/input/tsdev.c
+++ b/drivers/input/tsdev.c
@@ -414,10 +414,6 @@ static struct input_handle *tsdev_connec
 			MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + minor),
 			dev->cdev.dev, tsdev->name);
 
-	/* temporary symlink to keep userspace happy */
-	sysfs_create_link(&input_class.subsys.kset.kobj, &cdev->kobj,
-			  tsdev->name);
-
 	return &tsdev->handle;
 }
 
@@ -426,7 +422,6 @@ static void tsdev_disconnect(struct inpu
 	struct tsdev *tsdev = handle->private;
 	struct tsdev_list *list;
 
-	sysfs_remove_link(&input_class.subsys.kset.kobj, tsdev->name);
 	class_device_destroy(&input_class,
 			MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + tsdev->minor));
 	tsdev->exist = 0;
diff --git a/fs/partitions/check.c b/fs/partitions/check.c
index 7881ce0..029f272 100644
--- a/fs/partitions/check.c
+++ b/fs/partitions/check.c
@@ -36,6 +36,9 @@
 #include "ultrix.h"
 #include "efi.h"
 
+extern struct subsystem devices_subsys;
+extern struct subsystem block_subsys;
+
 #ifdef CONFIG_BLK_DEV_MD
 extern void md_autodetect_dev(dev_t dev);
 #endif
@@ -306,6 +309,8 @@ void delete_partition(struct gendisk *di
 	p->ios[0] = p->ios[1] = 0;
 	p->sectors[0] = p->sectors[1] = 0;
 	devfs_remove("%s/part%d", disk->devfs_name, part);
+	sysfs_remove_link(&block_subsys.kset.kobj, p->kobj.name);
+	sysfs_remove_link(&p->kobj, "subsystem");
 	kobject_unregister(&p->kobj);
 }
 
@@ -316,7 +321,7 @@ void add_partition(struct gendisk *disk,
 	p = kmalloc(sizeof(*p), GFP_KERNEL);
 	if (!p)
 		return;
-	
+
 	memset(p, 0, sizeof(*p));
 	p->start_sect = start;
 	p->nr_sects = len;
@@ -332,53 +337,49 @@ void add_partition(struct gendisk *disk,
 		snprintf(p->kobj.name,KOBJ_NAME_LEN,"%s%d",disk->kobj.name,part);
 	p->kobj.parent = &disk->kobj;
 	p->kobj.ktype = &ktype_part;
-	kobject_register(&p->kobj);
-	disk->part[part-1] = p;
-}
+	kobject_init(&p->kobj);
+	if (kobject_add(&p->kobj))
+		return;
 
-static char *make_block_name(struct gendisk *disk)
-{
-	char *name;
-	static char *block_str = "block:";
-	int size;
-
-	size = strlen(block_str) + strlen(disk->disk_name) + 1;
-	name = kmalloc(size, GFP_KERNEL);
-	if (!name)
-		return NULL;
-	strcpy(name, block_str);
-	strcat(name, disk->disk_name);
-	return name;
-}
+	/* create link from class to device object */
+	sysfs_create_link(&block_subsys.kset.kobj, &p->kobj, p->kobj.name);
 
-static void disk_sysfs_symlinks(struct gendisk *disk)
-{
-	struct device *target = get_device(disk->driverfs_dev);
-	if (target) {
-		char *disk_name = make_block_name(disk);
-		sysfs_create_link(&disk->kobj,&target->kobj,"device");
-		if (disk_name) {
-			sysfs_create_link(&target->kobj,&disk->kobj,disk_name);
-			kfree(disk_name);
-		}
-	}
+	/* create link from device object back to class */
+	sysfs_create_link(&p->kobj, &block_subsys.kset.kobj, "subsystem");
+
+	kobject_uevent(&p->kobj, KOBJ_ADD);
+	disk->part[part-1] = p;
 }
 
 /* Not exported, helper to add_disk(). */
 void register_disk(struct gendisk *disk)
 {
+	struct device *dev = disk->driverfs_dev;
 	struct block_device *bdev;
 	char *s;
-	int err;
 
-	strlcpy(disk->kobj.name,disk->disk_name,KOBJ_NAME_LEN);
+	strlcpy(disk->kobj.name, disk->disk_name, KOBJ_NAME_LEN);
+
 	/* ewww... some of these buggers have / in name... */
 	s = strchr(disk->kobj.name, '/');
 	if (s)
 		*s = '!';
-	if ((err = kobject_add(&disk->kobj)))
+
+	/* place disk object into device tree hierarchy */
+	if (dev) {
+		disk->kobj.parent = &dev->kobj;
+	} else
+		disk->kobj.parent = &devices_subsys.kset.kobj;
+
+	if (kobject_add(&disk->kobj))
 		return;
-	disk_sysfs_symlinks(disk);
+
+	/* create link from class to device object */
+	sysfs_create_link(&block_subsys.kset.kobj, &disk->kobj, disk->kobj.name);
+
+	/* create link from device object back to class */
+	sysfs_create_link(&disk->kobj, &block_subsys.kset.kobj, "subsystem");
+
 	kobject_uevent(&disk->kobj, KOBJ_ADD);
 
 	/* No minors to use for partitions */
@@ -479,15 +480,10 @@ void del_gendisk(struct gendisk *disk)
 
 	devfs_remove_disk(disk);
 
-	if (disk->driverfs_dev) {
-		char *disk_name = make_block_name(disk);
-		sysfs_remove_link(&disk->kobj, "device");
-		if (disk_name) {
-			sysfs_remove_link(&disk->driverfs_dev->kobj, disk_name);
-			kfree(disk_name);
-		}
+	if (disk->driverfs_dev)
 		put_device(disk->driverfs_dev);
-	}
+	sysfs_remove_link(&block_subsys.kset.kobj, disk->kobj.name);
+	sysfs_remove_link(&disk->kobj, "subsystem");
 	kobject_uevent(&disk->kobj, KOBJ_REMOVE);
 	kobject_del(&disk->kobj);
 }
diff --git a/init/do_mounts.c b/init/do_mounts.c
index b27c110..95b1598 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -65,7 +65,7 @@ static dev_t try_name(char *name, int pa
 
 	/* read device number from .../dev */
 
-	sprintf(path, "/sys/block/%s/dev", name);
+	sprintf(path, "/sys/class/block/%s/dev", name);
 	fd = sys_open(path, 0, 0);
 	if (fd < 0)
 		goto fail;
@@ -128,7 +128,7 @@ fail:
  *
  *	If name doesn't have fall into the categories above, we return 0.
  *	Sysfs is used to check if something is a disk name - it has
- *	all known disks under bus/block/devices.  If the disk name
+ *	all known disks under /sys/class/block/.  If the disk name
  *	contains slashes, name of sysfs node has them replaced with
  *	bangs.  try_name() does the actual checks, assuming that sysfs
  *	is mounted on rootfs /sys.

