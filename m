Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWA0AMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWA0AMr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 19:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbWA0AMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 19:12:47 -0500
Received: from soundwarez.org ([217.160.171.123]:15538 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S932136AbWA0AMq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 19:12:46 -0500
Date: Fri, 27 Jan 2006 01:12:32 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unify sysfs device tree
Message-ID: <20060127001232.GA25315@vrfy.org>
References: <20060113015652.GA30796@vrfy.org> <20060116134314.GA10813@vrfy.org> <20060125161006.GA30295@vrfy.org> <20060125220344.GA10082@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060125220344.GA10082@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2006 at 02:03:44PM -0800, Greg KH wrote:
> On Wed, Jan 25, 2006 at 05:10:06PM +0100, Kay Sievers wrote:
> > 
> > Unify sysfs device tree
> > 
> > Move device objects from /sys/class and /sys/block to /sys/devices and add
> > ---
> 
> Seems like your description got cut off on, and you forgot a
> Signed-off-by: line so I can take it and start merging it in :)

Here it is, with a big note and disclaimer what it is good for.

Thanks,
Kay


Author: Kay Sievers <kay.sievers@suse.de>

unify sysfs device tree

Move all devices into a unified tree at /sys/devices. All former objects in
/sys/class become only symlinks and are compatible to our current layout.

This approach does not longer mix classification and device hierarchy. and
avoids the stacking of devices in /sys/class, it does _not_ introduce a bunch
of trees spreaded around /sys, with the need to be interconnected by a lot
of symlinks.

The hierarchy in /sys/devices must not be expected to be stable across kernel
releases, it should be allowed to insert devices here if needed, without
breaking userspace applications. Users that walk up the devpath to find a
parent device, must always check for the subsystem and search until they
find the needed device and not expect a static device order.

The links in /sys/class and their names are expected to be kept stable, but
that's easy, cause they are flat directories and will not have any hierarchy.

Every device event sent to userspace contains its complete dependency path
in the DEVPATH now. The "device" link hack and the other cross reference
link hacks, that have been used to bring the devices in /sys/class and
/sys/devices together are no longer needed.

Note and Disclaimer:
This is _not_ a final implementation, it does not really care about the
in-kernel implementation and does not improve anything in the driver core.
It is just to let userspace look like it should look in the end and
prepare sysfs users before the real change will happen.

It is the most extrem way to do such a transition, all the old and no longer
needed stuff is removed, cause this patch is for users of sysfs to be adapted
and tested with the new layout. How it will look like in the end, what will
need to stay and what will be removed, needs to be decided case by case along
with the _real_ driver core change.

Signed-off-by: Kay Sievers <kay.sievers@suse.de>
---
 Documentation/Changes    |    2 -
 block/genhd.c            |   40 ++++-----------------
 drivers/base/bus.c       |    4 +-
 drivers/base/class.c     |   89 +++++++++--------------------------------------
 drivers/base/core.c      |   21 -----------
 drivers/input/evdev.c    |    5 --
 drivers/input/joydev.c   |    5 --
 drivers/input/mousedev.c |    5 --
 drivers/input/tsdev.c    |    5 --
 fs/partitions/check.c    |   78 +++++++++++++++++++----------------------
 init/do_mounts.c         |    4 +-
 11 files changed, 68 insertions(+), 190 deletions(-)

diff --git a/Documentation/Changes b/Documentation/Changes
index fe5ae0f..e8ff505 100644
--- a/Documentation/Changes
+++ b/Documentation/Changes
@@ -63,7 +63,7 @@ o  isdn4k-utils           3.1pre1       
 o  nfs-utils              1.0.5                   # showmount --version
 o  procps                 3.2.0                   # ps --version
 o  oprofile               0.9                     # oprofiled --version
-o  udev                   071                     # udevinfo -V
+o  udev                   082                     # udevinfo -V
 
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
 
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 6b355bd..551daaa 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -113,29 +113,8 @@ static int dev_uevent(struct kset *kset,
 			int num_envp, char *buffer, int buffer_size)
 {
 	struct device *dev = to_dev(kobj);
-	int i = 0;
-	int length = 0;
 	int retval = 0;
 
-	/* add bus name of physical device */
-	if (dev->bus)
-		add_uevent_var(envp, num_envp, &i,
-			       buffer, buffer_size, &length,
-			       "PHYSDEVBUS=%s", dev->bus->name);
-
-	/* add driver name of physical device */
-	if (dev->driver)
-		add_uevent_var(envp, num_envp, &i,
-			       buffer, buffer_size, &length,
-			       "PHYSDEVDRIVER=%s", dev->driver->name);
-
-	/* terminate, set to next free slot, shrink available space */
-	envp[i] = NULL;
-	envp = &envp[i];
-	num_envp -= i;
-	buffer = &buffer[length];
-	buffer_size -= length;
-
 	if (dev->bus && dev->bus->uevent) {
 		/* have the bus specific function add its stuff */
 		retval = dev->bus->uevent(dev, envp, num_envp, buffer, buffer_size);
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
index f924f45..e82ee99 100644
--- a/fs/partitions/check.c
+++ b/fs/partitions/check.c
@@ -37,6 +37,9 @@
 #include "efi.h"
 #include "karma.h"
 
+extern struct subsystem devices_subsys;
+extern struct subsystem block_subsys;
+
 #ifdef CONFIG_BLK_DEV_MD
 extern void md_autodetect_dev(dev_t dev);
 #endif
@@ -310,6 +313,8 @@ void delete_partition(struct gendisk *di
 	p->ios[0] = p->ios[1] = 0;
 	p->sectors[0] = p->sectors[1] = 0;
 	devfs_remove("%s/part%d", disk->devfs_name, part);
+	sysfs_remove_link(&block_subsys.kset.kobj, p->kobj.name);
+	sysfs_remove_link(&p->kobj, "subsystem");
 	kobject_unregister(&p->kobj);
 }
 
@@ -320,7 +325,7 @@ void add_partition(struct gendisk *disk,
 	p = kmalloc(sizeof(*p), GFP_KERNEL);
 	if (!p)
 		return;
-	
+
 	memset(p, 0, sizeof(*p));
 	p->start_sect = start;
 	p->nr_sects = len;
@@ -336,53 +341,49 @@ void add_partition(struct gendisk *disk,
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
@@ -483,15 +484,10 @@ void del_gendisk(struct gendisk *disk)
 
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

