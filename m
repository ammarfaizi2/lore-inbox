Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265702AbSKFPLo>; Wed, 6 Nov 2002 10:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265700AbSKFPLo>; Wed, 6 Nov 2002 10:11:44 -0500
Received: from h-64-105-136-52.SNVACAID.covad.net ([64.105.136.52]:25545 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265702AbSKFPLj>; Wed, 6 Nov 2002 10:11:39 -0500
Date: Wed, 6 Nov 2002 07:18:10 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: viro@math.psu.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch?: 2.5.46/drivers/block/genhd.c - static allocation of gendisks
Message-ID: <20021106071810.A1603@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	Sorry pelting you with duplicate patches.  Here is yet
another version of my init_disk() patch.

	I changed init_disk to take the disk partitions pointer
as a parameter to make it hard for users of this interface to
forget to set it.

	Also, I replaced disk.destructor() with disk.kfree_arg,
to avoid having to write a bunch of destructors that look like this:

void foo_destructor(struct gendisk *disk)
{
	struct foo_private *foo_priv =
		container_of(disk, struct foo_private, mygendisk);
	kfree(foo_priv);
}

	foo's hardware removal function would call put_disk,
and the disk's destructor would be called when the disk's reference
count dropped to zero.  However, I'd rather not have to write
a bunch of duplicative destructor functions and I think they
all would just call kfree.

	By the way, I believe that the example of the IDE changes that
I posted does not currently have this issue because the gendisks are in
the static hwifs[] array, which is not deallocated until the module is
unloaded, and the module is protected by a reference count.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="genhd.diff"

--- linux-2.5.46/include/linux/genhd.h	2002-11-04 14:30:08.000000000 -0800
+++ linux/include/linux/genhd.h	2002-11-06 06:56:41.000000000 -0800
@@ -107,6 +108,7 @@
 	int in_flight;
 	unsigned long stamp, stamp_idle;
 	unsigned time_in_queue;
+	void *kfree_arg;
 };
 
 /* drivers/block/ll_rw_blk.c */
@@ -283,8 +285,10 @@
 extern void add_partition(struct gendisk *, int, sector_t, sector_t);
 extern void delete_partition(struct gendisk *, int);
 
+extern void init_disk(struct gendisk *disk, int minors,
+		      struct hd_struct *partitions);
 extern struct gendisk *alloc_disk(int minors);
 extern struct gendisk *get_disk(struct gendisk *disk);
 extern void put_disk(struct gendisk *disk);
--- linux-2.5.46/drivers/block/genhd.c	2002-11-04 14:30:27.000000000 -0800
+++ linux/drivers/block/genhd.c	2002-11-06 06:58:53.000000000 -0800
@@ -373,8 +370,7 @@
 {
 	struct gendisk *disk = to_disk(kobj);
 	kfree(disk->random);
-	kfree(disk->part);
-	kfree(disk);
+	kfree(disk->kfree_arg);
 }
 
 struct subsystem block_subsys = {
@@ -384,28 +380,33 @@
 	.default_attrs	= default_attrs,
 };
 
+/* init_disk assumes disk should is initialized to all zeroes,
+   except for disk->part, which points to the partitions structures,
+   which are also assumed to be initialized to all zeroes. */
+void init_disk(struct gendisk *disk, int minors, struct hd_struct *parts)
+{
+	BUG_ON(minors > 1 && parts == NULL);
+
+	disk->minors = minors;
+	disk->part = parts;
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
+		init_disk(disk, minors, (struct hd_struct*) &disk[1]);
+		disk->kfree_arg = disk;
 	}
-	rand_initialize_disk(disk);
 	return disk;
 }
 
@@ -426,6 +427,7 @@
 		kobject_put(&disk->kobj);
 }
 
+EXPORT_SYMBOL(init_disk);
 EXPORT_SYMBOL(alloc_disk);
 EXPORT_SYMBOL(get_disk);
 EXPORT_SYMBOL(put_disk);

--x+6KMIRAuhnl3hBn--
