Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265016AbSKFMxG>; Wed, 6 Nov 2002 07:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265017AbSKFMxG>; Wed, 6 Nov 2002 07:53:06 -0500
Received: from h-64-105-136-52.SNVACAID.covad.net ([64.105.136.52]:7366 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265016AbSKFMxE>; Wed, 6 Nov 2002 07:53:04 -0500
Date: Wed, 6 Nov 2002 04:59:29 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: viro@math.psu.edu
Cc: linux-kernel@vger.kernel.org
Subject: Patch?: 2.5.46/drivers/block/genhd.c - static allocation of gendisks
Message-ID: <20021106045929.A341@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	The following patch allows for initializing a gendisk for a
given chunk of memory in a way that cannot fail, instead of having
alloc_gendisk do the kmalloc.  This will allow embedding a struct
gendisk in a larger structure, reducing rarely tested error branches.
Other marginal benefits include saving a few CPU cycles with fewer
kmalloc and kfree (not in any critical path though) and perhaps a tad
better cache locality from the gendisk being contiguous with some
related data structures.

	Many (all?) users of alloc_gendisk pass a constant maximum
number of partitions and already allocate a struct that the gendisk
and gendisk->part could be embedded in.

	Also, since I was editing alloc_disk anyhow, I changed it to
allocate its memory in a single kmalloc.  (Same minor benefits: now
the disk partitions are contiguous with the struct gendisk, so perhaps
that may save an occasional cache miss, the allocator is smaller,
etc.).

	To me, the important thing is to have an interface for
initializing a struct gendisk in a given chunk of memory that cannot
return failure.  As for my implementation choices, I'm happy to
rebuild to suit.  Here are couple of notes about those choices.

	1. I made this change by making a gendisk.destructor function,
	   on the theory that some other code might find it useful to
	   trap gendisk destruction.  If that does not sound so useful,
	   I can change it to use a bit gendisk.flags, so as not to
	   grow struct gendisk by 4-8 bytes.

	2. I made a disk_destructor function to avoid type conversions.
	   Alternatively, I could just do "disk->destructor = (cast) kfree;",
	   which should work on all hardware that Linux supports or
	   probably will, although I don't believe it is absolutely
	   guaranteed to work by ANSI C.  I could also change the argument
	   that disk->destructor takes to a void* to use kfree without a
	   cast, which loses a little type checking.

	I am running the code now, although I have not really tested
it.  This patch is hand editted to remove some unrelated changes, so
patch may report that the line numbers are off slightly.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="genhd.diff"

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
+++ linux/drivers/block/genhd.c	2002-11-06 04:19:04.000000000 -0800
@@ -369,12 +366,16 @@
 	NULL,
 };
 
+static void disk_destructor(struct gendisk *disk)
+{
+	kfree(disk);
+}
+
 static void disk_release(struct kobject * kobj)
 {
 	struct gendisk *disk = to_disk(kobj);
-	kfree(disk->random);
-	kfree(disk->part);
-	kfree(disk);
+	if (disk->destructor)
+		(*disk->destructor)(disk);
 }
 
 struct subsystem block_subsys = {
@@ -384,28 +385,31 @@
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
 
@@ -426,6 +430,7 @@
 		kobject_put(&disk->kobj);
 }
 
+EXPORT_SYMBOL(init_disk);
 EXPORT_SYMBOL(alloc_disk);
 EXPORT_SYMBOL(get_disk);
 EXPORT_SYMBOL(put_disk);

--xHFwDpU9dbj6ez1V--
