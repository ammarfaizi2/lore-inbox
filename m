Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265033AbSKFNNf>; Wed, 6 Nov 2002 08:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265034AbSKFNNf>; Wed, 6 Nov 2002 08:13:35 -0500
Received: from h-64-105-136-52.SNVACAID.covad.net ([64.105.136.52]:35270 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265033AbSKFNNe>; Wed, 6 Nov 2002 08:13:34 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 6 Nov 2002 05:20:04 -0800
Message-Id: <200211061320.FAA28007@adam.yggdrasil.com>
To: viro@math.psu.edu
Subject: Re: Patch?: 2.5.46/drivers/block/genhd.c - static allocation of gendisks
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:

| static void disk_release(struct kobject * kobj)
| {
| 	struct gendisk *disk = to_disk(kobj);
|-	kfree(disk->random);
        ^^^^^^^^^^^^^^^^^^^^
|-	kfree(disk->part);
|-	kfree(disk);
|+	if (disk->destructor)
|+		(*disk->destructor)(disk);
| }


	Arg!  I did not mean to include that deletion in my patch.
That line is deleted from my source tree due to the disk->random
change that we discussed yestrday.  Here is a corrected version
of my patch.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."


--- linux-2.5.46/include/linux/genhd.h	2002-11-04 14:30:08.000000000 -0800
+++ linux/include/linux/genhd.h	2002-11-06 04:19:13.000000000 -0800
@@ -107,6 +108,7 @@
 	int in_flight;
 	unsigned long stamp, stamp_idle;
 	unsigned time_in_queue;
+	void (*destructor)(struct gendisk *disk);
 };
 
 /* drivers/block/ll_rw_blk.c */
@@ -283,8 +285,9 @@
 extern void add_partition(struct gendisk *, int, sector_t, sector_t);
 extern void delete_partition(struct gendisk *, int);
 
+extern void init_disk(struct gendisk *disk, int minors);
 extern struct gendisk *alloc_disk(int minors);
 extern struct gendisk *get_disk(struct gendisk *disk);
 extern void put_disk(struct gendisk *disk);
--- linux-2.5.46/drivers/block/genhd.c	2002-11-04 14:30:27.000000000 -0800
+++ linux/drivers/block/genhd.c	2002-11-06 05:17:01.000000000 -0800
@@ -369,14 +366,19 @@
 	NULL,
 };
 
-static void disk_release(struct kobject * kobj)
+static void disk_destructor(struct gendisk *disk)
 {
-	struct gendisk *disk = to_disk(kobj);
 	kfree(disk->random);
-	kfree(disk->part);
 	kfree(disk);
 }
 
+static void disk_release(struct kobject * kobj)
+{
+	struct gendisk *disk = to_disk(kobj);
+	if (disk->destructor)
+		(*disk->destructor)(disk);
+}
+
 struct subsystem block_subsys = {
 	.kobj	= { .name = "block" },
 	.release	= disk_release,
@@ -384,28 +386,31 @@
 	.default_attrs	= default_attrs,
 };
 
+/* init_disk assumes disk should is initialized to all zeroes,
+   except for disk->part, which points to the partitions structures,
+   which are also assumed to be initialized to all zeroes. */
+void init_disk(struct gendisk *disk, int minors)
+{
+	disk->minors = minors;
+	while (minors >>= 1)
+		disk->minor_shift++;
+	kobject_init(&disk->kobj);
+	disk->kobj.subsys = &block_subsys;
+	INIT_LIST_HEAD(&disk->full_list);
+	rand_initialize_disk(disk);
+}
+
 struct gendisk *alloc_disk(int minors)
 {
-	struct gendisk *disk = kmalloc(sizeof(struct gendisk), GFP_KERNEL);
+	int size = sizeof(struct gendisk) +
+		(minors - 1) * sizeof(struct hd_struct);
+	struct gendisk *disk = kmalloc(size, GFP_KERNEL);
 	if (disk) {
-		memset(disk, 0, sizeof(struct gendisk));
-		if (minors > 1) {
-			int size = (minors - 1) * sizeof(struct hd_struct);
-			disk->part = kmalloc(size, GFP_KERNEL);
-			if (!disk->part) {
-				kfree(disk);
-				return NULL;
-			}
-			memset(disk->part, 0, size);
-		}
-		disk->minors = minors;
-		while (minors >>= 1)
-			disk->minor_shift++;
-		kobject_init(&disk->kobj);
-		disk->kobj.subsys = &block_subsys;
-		INIT_LIST_HEAD(&disk->full_list);
+		memset(disk, 0, size);
+		disk->part = (struct hd_struct*) &disk[1];
+		init_disk(disk, minors);
+		disk->destructor = disk_destructor;
 	}
-	rand_initialize_disk(disk);
 	return disk;
 }
 
@@ -426,6 +431,7 @@
 		kobject_put(&disk->kobj);
 }
 
+EXPORT_SYMBOL(init_disk);
 EXPORT_SYMBOL(alloc_disk);
 EXPORT_SYMBOL(get_disk);
 EXPORT_SYMBOL(put_disk);
