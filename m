Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262879AbSKDVXg>; Mon, 4 Nov 2002 16:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262881AbSKDVXg>; Mon, 4 Nov 2002 16:23:36 -0500
Received: from h-64-105-136-52.SNVACAID.covad.net ([64.105.136.52]:62648 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S262879AbSKDVXb>; Mon, 4 Nov 2002 16:23:31 -0500
Date: Mon, 4 Nov 2002 13:29:54 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: viro@math.psu.edu, tytso@mit.edu
Cc: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Patch(2.5.45): Eliminate unchecked kfree(disk->random)
Message-ID: <20021104132954.A337@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	alloc_disk in linux-2.5.45/drivers/block/genhd.c calls
rand_initialize_disk, which can set disk->random to NULL on kmalloc
failure.  disk_release does a kfree(disk->random) without checking.

	I could add an "if(disk->random == NULL)" to disk_release,
memory allocation policy for disk->random does not need to be split
between genhd.c and and random.c, and disk->random is so small that
there is really no benefit to kmalloc'ing it.

	More importantly, I want to reduce memory allocation error
branches (or, worse, lack of branches where they are needed as this
case as this case illustrates), especially because I'd eventually like
to have a variant of alloc_disk that doesn't do the kmalloc, so I can
embed the struct gendisk and have a gendisk initializer that doesn't
need an error branch (init_disk(disk, partitions_array,...), but
that's another matter).

	So, here is a patch to embed disk->random.  It is a net
deletion of ten lines.  It also moves the declarations for
add_disk_randomness and rand_initialize_disk to <linux/random.h> where
the other add_foo_randomness and rand_initialize_foo routines are
declared.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="random.diff"

--- linux-2.5.45/include/linux/random.h	2002-10-30 16:43:45.000000000 -0800
+++ linux/include/linux/random.h	2002-11-04 11:28:09.000000000 -0800
@@ -38,18 +38,36 @@
 	__u32	buf[0];
 };
 
+/* There is one of these per entropy source.  The contents of this
+   structure is private to random.c.  It is only declared in random.h
+   so that other data structures can embed it. */
+struct timer_rand_state {
+	__u32		last_time;
+	__s32		last_delta,last_delta2;
+	int		dont_count_entropy:1;
+};
+
 /* Exported functions */
 
 #ifdef __KERNEL__
 
+struct gendisk;
+
 extern void rand_initialize(void);
 extern void rand_initialize_irq(int irq);
 
+static inline void rand_initialize_disk(struct gendisk *disk)
+{
+	/* gendisk initializes &disk->random to all zeros and that
+	   is all that random.c currently wants.  */
+}
+
 extern void batch_entropy_store(u32 a, u32 b, int num);
 
 extern void add_keyboard_randomness(unsigned char scancode);
 extern void add_mouse_randomness(__u32 mouse_data);
 extern void add_interrupt_randomness(int irq);
+extern void add_disk_randomness(struct gendisk *disk);
 
 extern void get_random_bytes(void *buf, int nbytes);
 void generate_random_uuid(unsigned char uuid_out[16]);
--- linux-2.5.45/include/linux/blk.h	2002-10-30 16:43:39.000000000 -0800
+++ linux/include/linux/blk.h	2002-11-04 11:27:21.000000000 -0800
@@ -9,8 +9,6 @@
 
 extern void set_device_ro(struct block_device *bdev, int flag);
 extern void set_disk_ro(struct gendisk *disk, int flag);
-extern void add_disk_randomness(struct gendisk *disk);
-extern void rand_initialize_disk(struct gendisk *disk);
 
 #ifdef CONFIG_BLK_DEV_RAM
 
--- linux-2.5.45/include/linux/genhd.h	2002-10-30 16:41:57.000000000 -0800
+++ linux/include/linux/genhd.h	2002-11-04 10:50:38.000000000 -0800
@@ -13,6 +13,7 @@
 #include <linux/types.h>
 #include <linux/major.h>
 #include <linux/device.h>
+#include <linux/random.h>
 
 enum {
 /* These three have identical behaviour; use the second one if DOS fdisk gets
@@ -95,7 +96,7 @@
 	struct device *driverfs_dev;
 	struct device disk_dev;
 
-	struct timer_rand_state *random;
+	struct timer_rand_state random;
 	int policy;
 
 	unsigned sync_io;		/* RAID */
--- linux-2.5.45/drivers/block/genhd.c	2002-10-30 16:42:55.000000000 -0800
+++ linux/drivers/block/genhd.c	2002-11-04 11:29:27.000000000 -0800
@@ -27,7 +27,7 @@
 #include <linux/kmod.h>
 
 
-static rwlock_t gendisk_lock;
+static rwlock_t gendisk_lock = RW_LOCK_UNLOCKED;
 
 /*
  * Global kernel list of partitioning information.
@@ -249,9 +249,6 @@
 };
 #endif
 
-
-extern int blk_dev_init(void);
-
 struct device_class disk_devclass = {
 	.name		= "disk",
 };
@@ -272,14 +269,13 @@
 {
 	struct blk_probe *base = kmalloc(sizeof(struct blk_probe), GFP_KERNEL);
 	int i;
-	rwlock_init(&gendisk_lock);
+
 	memset(base, 0, sizeof(struct blk_probe));
 	base->dev = MKDEV(1,0);
 	base->range = MKDEV(MAX_BLKDEV-1, 255) - base->dev + 1;
 	base->get = base_probe;
 	for (i = 1; i < MAX_BLKDEV; i++)
 		probes[i] = base;
-	blk_dev_init();
 	devclass_register(&disk_devclass);
 	bus_register(&disk_bus);
 	return 0;
@@ -292,7 +288,6 @@
 static void disk_release(struct device *dev)
 {
 	struct gendisk *disk = dev->driver_data;
-	kfree(disk->random);
 	kfree(disk->part);
 	kfree(disk);
 }
@@ -319,8 +314,8 @@
 		disk->disk_dev.release = disk_release;
 		disk->disk_dev.driver_data = disk;
 		device_initialize(&disk->disk_dev);
+		rand_initialize_disk(disk);
 	}
-	rand_initialize_disk(disk);
 	return disk;
 }
 
--- linux-2.5.45/drivers/char/random.c	2002-10-30 16:41:52.000000000 -0800
+++ linux/drivers/char/random.c	2002-11-04 11:21:37.000000000 -0800
@@ -708,13 +708,6 @@
  *
  *********************************************************************/
 
-/* There is one of these per entropy source */
-struct timer_rand_state {
-	__u32		last_time;
-	__s32		last_delta,last_delta2;
-	int		dont_count_entropy:1;
-};
-
 static struct timer_rand_state keyboard_timer_state;
 static struct timer_rand_state mouse_timer_state;
 static struct timer_rand_state extract_timer_state;
@@ -814,10 +807,10 @@
 
 void add_disk_randomness(struct gendisk *disk)
 {
-	if (!disk || !disk->random)
+	if (!disk)
 		return;
 	/* first major is 1, so we get >= 0x200 here */
-	add_timer_randomness(disk->random, 0x100+MKDEV(disk->major, disk->first_minor));
+	add_timer_randomness(&disk->random, 0x100+MKDEV(disk->major, disk->first_minor));
 }
 
 /******************************************************************
@@ -1465,21 +1458,6 @@
 	}
 }
  
-void rand_initialize_disk(struct gendisk *disk)
-{
-	struct timer_rand_state *state;
-	
-	/*
-	 * If kmalloc returns null, we just won't use that entropy
-	 * source.
-	 */
-	state = kmalloc(sizeof(struct timer_rand_state), GFP_KERNEL);
-	if (state) {
-		memset(state, 0, sizeof(struct timer_rand_state));
-		disk->random = state;
-	}
-}
-
 static ssize_t
 random_read(struct file * file, char * buf, size_t nbytes, loff_t *ppos)
 {

--Q68bSM7Ycu6FN28Q--
