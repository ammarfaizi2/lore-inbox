Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965149AbVJ1Gju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965149AbVJ1Gju (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965136AbVJ1Gil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:38:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:34794 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965115AbVJ1GbR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:31:17 -0400
Cc: kay.sievers@suse.de
Subject: [PATCH] add sysfs attr to re-emit device hotplug event
In-Reply-To: <11304810231493@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 27 Oct 2005 23:30:23 -0700
Message-Id: <1130481023770@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] add sysfs attr to re-emit device hotplug event

A "coldplug + udevstart" can be simple like this:
  for i in /sys/block/*/*/uevent; do echo 1 > $i; done
  for i in /sys/class/*/*/uevent; do echo 1 > $i; done
  for i in /sys/bus/*/devices/*/uevent; do echo 1 > $i; done

Signed-off-by: Kay Sievers <kay.sievers@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit d54bc6daa47cc8821fee219877916b32119ab919
tree 10276fc0e96b02d7afb906dcef19737d935d0828
parent 6f5ace97359fa038cffb977dcf057764197f0df5
author Kay Sievers <kay.sievers@suse.de> Sat, 01 Oct 2005 14:49:43 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:48:00 -0700

 drivers/base/class.c   |   16 ++++++++++++-
 drivers/base/core.c    |   16 +++++++++++++
 drivers/block/genhd.c  |   25 +++++++++++++++++++++
 fs/partitions/check.c  |   27 ++++++++++++++++++++++-
 include/linux/device.h |   57 ++++++++++++++++++++++++------------------------
 include/linux/genhd.h  |    1 +
 6 files changed, 110 insertions(+), 32 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index 73d44cf..3cf6eb3 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -442,6 +442,13 @@ static ssize_t show_dev(struct class_dev
 	return print_dev_t(buf, class_dev->devt);
 }
 
+static ssize_t store_uevent(struct class_device *class_dev,
+			    const char *buf, size_t count)
+{
+	kobject_hotplug(&class_dev->kobj, KOBJ_ADD);
+	return count;
+}
+
 void class_device_initialize(struct class_device *class_dev)
 {
 	kobj_set_kset_s(class_dev, class_obj_subsys);
@@ -497,6 +504,12 @@ int class_device_add(struct class_device
 		goto register_done;
 
 	/* add the needed attributes to this device */
+	class_dev->uevent_attr.attr.name = "uevent";
+	class_dev->uevent_attr.attr.mode = S_IWUSR;
+	class_dev->uevent_attr.attr.owner = parent->owner;
+	class_dev->uevent_attr.store = store_uevent;
+	class_device_create_file(class_dev, &class_dev->uevent_attr);
+
 	if (MAJOR(class_dev->devt)) {
 		struct class_device_attribute *attr;
 		attr = kzalloc(sizeof(*attr), GFP_KERNEL);
@@ -505,12 +518,10 @@ int class_device_add(struct class_device
 			kobject_del(&class_dev->kobj);
 			goto register_done;
 		}
-
 		attr->attr.name = "dev";
 		attr->attr.mode = S_IRUGO;
 		attr->attr.owner = parent->owner;
 		attr->show = show_dev;
-		attr->store = NULL;
 		class_device_create_file(class_dev, attr);
 		class_dev->devt_attr = attr;
 	}
@@ -621,6 +632,7 @@ void class_device_del(struct class_devic
 		sysfs_remove_link(&class_dev->kobj, "device");
 		sysfs_remove_link(&class_dev->dev->kobj, class_name);
 	}
+	class_device_remove_file(class_dev, &class_dev->uevent_attr);
 	if (class_dev->devt_attr)
 		class_device_remove_file(class_dev, class_dev->devt_attr);
 	class_device_remove_attrs(class_dev);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 3110919..ac4b5fd 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -154,6 +154,13 @@ static struct kset_hotplug_ops device_ho
 	.hotplug =	dev_hotplug,
 };
 
+static ssize_t store_uevent(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	kobject_hotplug(&dev->kobj, KOBJ_ADD);
+	return count;
+}
+
 /**
  *	device_subsys - structure to be registered with kobject core.
  */
@@ -259,6 +266,14 @@ int device_add(struct device *dev)
 
 	if ((error = kobject_add(&dev->kobj)))
 		goto Error;
+
+	dev->uevent_attr.attr.name = "uevent";
+	dev->uevent_attr.attr.mode = S_IWUSR;
+	if (dev->driver)
+		dev->uevent_attr.attr.owner = dev->driver->owner;
+	dev->uevent_attr.store = store_uevent;
+	device_create_file(dev, &dev->uevent_attr);
+
 	kobject_hotplug(&dev->kobj, KOBJ_ADD);
 	if ((error = device_pm_add(dev)))
 		goto PMError;
@@ -350,6 +365,7 @@ void device_del(struct device * dev)
 
 	if (parent)
 		klist_del(&dev->knode_parent);
+	device_remove_file(dev, &dev->uevent_attr);
 
 	/* Notify the platform of the removal, in case they
 	 * need to do anything...
diff --git a/drivers/block/genhd.c b/drivers/block/genhd.c
index d42840c..486ce1f 100644
--- a/drivers/block/genhd.c
+++ b/drivers/block/genhd.c
@@ -337,10 +337,30 @@ static ssize_t disk_attr_show(struct kob
 	return ret;
 }
 
+static ssize_t disk_attr_store(struct kobject * kobj, struct attribute * attr,
+			       const char *page, size_t count)
+{
+	struct gendisk *disk = to_disk(kobj);
+	struct disk_attribute *disk_attr =
+		container_of(attr,struct disk_attribute,attr);
+	ssize_t ret = 0;
+
+	if (disk_attr->store)
+		ret = disk_attr->store(disk, page, count);
+	return ret;
+}
+
 static struct sysfs_ops disk_sysfs_ops = {
 	.show	= &disk_attr_show,
+	.store	= &disk_attr_store,
 };
 
+static ssize_t disk_uevent_store(struct gendisk * disk,
+				 const char *buf, size_t count)
+{
+	kobject_hotplug(&disk->kobj, KOBJ_ADD);
+	return count;
+}
 static ssize_t disk_dev_read(struct gendisk * disk, char *page)
 {
 	dev_t base = MKDEV(disk->major, disk->first_minor); 
@@ -382,6 +402,10 @@ static ssize_t disk_stats_read(struct ge
 		jiffies_to_msecs(disk_stat_read(disk, io_ticks)),
 		jiffies_to_msecs(disk_stat_read(disk, time_in_queue)));
 }
+static struct disk_attribute disk_attr_uevent = {
+	.attr = {.name = "uevent", .mode = S_IWUSR },
+	.store	= disk_uevent_store
+};
 static struct disk_attribute disk_attr_dev = {
 	.attr = {.name = "dev", .mode = S_IRUGO },
 	.show	= disk_dev_read
@@ -404,6 +428,7 @@ static struct disk_attribute disk_attr_s
 };
 
 static struct attribute * default_attrs[] = {
+	&disk_attr_uevent.attr,
 	&disk_attr_dev.attr,
 	&disk_attr_range.attr,
 	&disk_attr_removable.attr,
diff --git a/fs/partitions/check.c b/fs/partitions/check.c
index 77e178f..d95a110 100644
--- a/fs/partitions/check.c
+++ b/fs/partitions/check.c
@@ -192,6 +192,7 @@ check_partition(struct gendisk *hd, stru
 struct part_attribute {
 	struct attribute attr;
 	ssize_t (*show)(struct hd_struct *,char *);
+	ssize_t (*store)(struct hd_struct *,const char *, size_t);
 };
 
 static ssize_t 
@@ -201,14 +202,33 @@ part_attr_show(struct kobject * kobj, st
 	struct part_attribute * part_attr = container_of(attr,struct part_attribute,attr);
 	ssize_t ret = 0;
 	if (part_attr->show)
-		ret = part_attr->show(p,page);
+		ret = part_attr->show(p, page);
+	return ret;
+}
+static ssize_t
+part_attr_store(struct kobject * kobj, struct attribute * attr,
+		const char *page, size_t count)
+{
+	struct hd_struct * p = container_of(kobj,struct hd_struct,kobj);
+	struct part_attribute * part_attr = container_of(attr,struct part_attribute,attr);
+	ssize_t ret = 0;
+
+	if (part_attr->store)
+		ret = part_attr->store(p, page, count);
 	return ret;
 }
 
 static struct sysfs_ops part_sysfs_ops = {
 	.show	=	part_attr_show,
+	.store	=	part_attr_store,
 };
 
+static ssize_t part_uevent_store(struct hd_struct * p,
+				 const char *page, size_t count)
+{
+	kobject_hotplug(&p->kobj, KOBJ_ADD);
+	return count;
+}
 static ssize_t part_dev_read(struct hd_struct * p, char *page)
 {
 	struct gendisk *disk = container_of(p->kobj.parent,struct gendisk,kobj);
@@ -229,6 +249,10 @@ static ssize_t part_stat_read(struct hd_
 		       p->reads, (unsigned long long)p->read_sectors,
 		       p->writes, (unsigned long long)p->write_sectors);
 }
+static struct part_attribute part_attr_uevent = {
+	.attr = {.name = "uevent", .mode = S_IWUSR },
+	.store	= part_uevent_store
+};
 static struct part_attribute part_attr_dev = {
 	.attr = {.name = "dev", .mode = S_IRUGO },
 	.show	= part_dev_read
@@ -247,6 +271,7 @@ static struct part_attribute part_attr_s
 };
 
 static struct attribute * default_attrs[] = {
+	&part_attr_uevent.attr,
 	&part_attr_dev.attr,
 	&part_attr_start.attr,
 	&part_attr_size.attr,
diff --git a/include/linux/device.h b/include/linux/device.h
index a53a822..e86a580 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -190,6 +190,18 @@ struct class_attribute class_attr_##_nam
 extern int class_create_file(struct class *, const struct class_attribute *);
 extern void class_remove_file(struct class *, const struct class_attribute *);
 
+struct class_device_attribute {
+	struct attribute	attr;
+	ssize_t (*show)(struct class_device *, char * buf);
+	ssize_t (*store)(struct class_device *, const char * buf, size_t count);
+};
+
+#define CLASS_DEVICE_ATTR(_name,_mode,_show,_store)		\
+struct class_device_attribute class_device_attr_##_name = 	\
+	__ATTR(_name,_mode,_show,_store)
+
+extern int class_device_create_file(struct class_device *,
+				    const struct class_device_attribute *);
 
 struct class_device {
 	struct list_head	node;
@@ -198,6 +210,7 @@ struct class_device {
 	struct class		* class;	/* required */
 	dev_t			devt;		/* dev_t, creates the sysfs "dev" */
 	struct class_device_attribute *devt_attr;
+	struct class_device_attribute uevent_attr;
 	struct device		* dev;		/* not necessary, but nice to have */
 	void			* class_data;	/* class-specific data */
 
@@ -228,18 +241,6 @@ extern int class_device_rename(struct cl
 extern struct class_device * class_device_get(struct class_device *);
 extern void class_device_put(struct class_device *);
 
-struct class_device_attribute {
-	struct attribute	attr;
-	ssize_t (*show)(struct class_device *, char * buf);
-	ssize_t (*store)(struct class_device *, const char * buf, size_t count);
-};
-
-#define CLASS_DEVICE_ATTR(_name,_mode,_show,_store)		\
-struct class_device_attribute class_device_attr_##_name = 	\
-	__ATTR(_name,_mode,_show,_store)
-
-extern int class_device_create_file(struct class_device *, 
-				    const struct class_device_attribute *);
 extern void class_device_remove_file(struct class_device *, 
 				     const struct class_device_attribute *);
 extern int class_device_create_bin_file(struct class_device *,
@@ -266,6 +267,20 @@ extern struct class_device *class_device
 extern void class_device_destroy(struct class *cls, dev_t devt);
 
 
+/* interface for exporting device attributes */
+struct device_attribute {
+	struct attribute	attr;
+	ssize_t (*show)(struct device *dev, struct device_attribute *attr,
+			char *buf);
+	ssize_t (*store)(struct device *dev, struct device_attribute *attr,
+			 const char *buf, size_t count);
+};
+
+#define DEVICE_ATTR(_name,_mode,_show,_store) \
+struct device_attribute dev_attr_##_name = __ATTR(_name,_mode,_show,_store)
+
+extern int device_create_file(struct device *device, struct device_attribute * entry);
+extern void device_remove_file(struct device * dev, struct device_attribute * attr);
 struct device {
 	struct klist		klist_children;
 	struct klist_node	knode_parent;		/* node in sibling list */
@@ -275,6 +290,7 @@ struct device {
 
 	struct kobject kobj;
 	char	bus_id[BUS_ID_SIZE];	/* position on parent bus */
+	struct device_attribute uevent_attr;
 
 	struct semaphore	sem;	/* semaphore to synchronize calls to
 					 * its driver.
@@ -343,23 +359,6 @@ extern int  device_attach(struct device 
 extern void driver_attach(struct device_driver * drv);
 
 
-/* driverfs interface for exporting device attributes */
-
-struct device_attribute {
-	struct attribute	attr;
-	ssize_t (*show)(struct device *dev, struct device_attribute *attr,
-			char *buf);
-	ssize_t (*store)(struct device *dev, struct device_attribute *attr,
-			 const char *buf, size_t count);
-};
-
-#define DEVICE_ATTR(_name,_mode,_show,_store) \
-struct device_attribute dev_attr_##_name = __ATTR(_name,_mode,_show,_store)
-
-
-extern int device_create_file(struct device *device, struct device_attribute * entry);
-extern void device_remove_file(struct device * dev, struct device_attribute * attr);
-
 /*
  * Platform "fixup" functions - allow the platform to have their say
  * about devices and actions that the general device layer doesn't
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 01796c4..78af348 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -132,6 +132,7 @@ struct gendisk {
 struct disk_attribute {
 	struct attribute attr;
 	ssize_t (*show)(struct gendisk *, char *);
+	ssize_t (*store)(struct gendisk *, const char *, size_t);
 };
 
 /* 

