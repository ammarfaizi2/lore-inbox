Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262235AbSJ2ROA>; Tue, 29 Oct 2002 12:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262425AbSJ2ROA>; Tue, 29 Oct 2002 12:14:00 -0500
Received: from cmailm4.svr.pol.co.uk ([195.92.193.211]:4620 "EHLO
	cmailm4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S262235AbSJ2RNy>; Tue, 29 Oct 2002 12:13:54 -0500
Date: Tue, 29 Oct 2002 17:20:16 +0000
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] dm update 3/3
Message-ID: <20021029172016.GC1779@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keep track of allocated minors in a bitset rather than abusing
get_gendisk.


--- diff/drivers/md/dm.c	2002-10-29 16:22:36.000000000 +0000
+++ source/drivers/md/dm.c	2002-10-29 16:34:45.000000000 +0000
@@ -15,7 +15,7 @@
 #include <linux/slab.h>
 
 static const char *_name = DM_NAME;
-#define MAX_DEVICES 256
+#define MAX_DEVICES (1 << KDEV_MINOR_BITS)
 #define SECTOR_SHIFT 9
 
 static int major = 0;
@@ -483,13 +483,25 @@
 	return 0;
 }
 
+/*-----------------------------------------------------------------
+ * A bitset is used to keep track of allocated minor numbers.
+ *---------------------------------------------------------------*/
+static spinlock_t _minor_lock = SPIN_LOCK_UNLOCKED;
+static unsigned long _minor_bits[MAX_DEVICES / BITS_PER_LONG];
+
+static void free_minor(int minor)
+{
+	spin_lock(&_minor_lock);
+	clear_bit(minor, _minor_bits);
+	spin_unlock(&_minor_lock);
+}
+
 /*
  * See if the device with a specific minor # is free.
  */
-static int specific_dev(int minor, struct mapped_device *md)
+static int specific_minor(int minor)
 {
-	struct gendisk *disk;
-	int part;
+	int r = -EBUSY;
 
 	if (minor >= MAX_DEVICES) {
 		DMWARN("request for a mapped_device beyond MAX_DEVICES (%d)",
@@ -497,26 +509,32 @@
 		return -EINVAL;
 	}
 
-	disk = get_gendisk(MKDEV(_major, minor), &part);
-	if (disk) {
-		put_disk(disk);
-		return -EBUSY;
+	spin_lock(&_minor_lock);
+	if (!test_bit(minor, _minor_bits)) {
+		r = minor;
+		set_bit(minor, _minor_bits);
 	}
+	spin_unlock(&_minor_lock);
 
-	return minor;
+	return r;
 }
 
-static int any_old_dev(struct mapped_device *md)
+static int any_old_minor(void)
 {
-	int i;
+	int i, r = -EBUSY;
 
-	for (i = 0; i < MAX_DEVICES; i++)
-		if (specific_dev(i, md) >= 0) {
+	spin_lock(&_minor_lock);
+	for (i = 0; i < MAX_DEVICES; i++) {
+		if (!test_bit(i, _minor_bits)) {
+			r = i;
+			set_bit(i, _minor_bits);
 			DMWARN("allocating minor = %d", i);
-			return i;
+			break;
 		}
+	}
+	spin_unlock(&_minor_lock);
 
-	return -EBUSY;
+	return r;
 }
 
 /*
@@ -532,7 +550,7 @@
 	}
 
 	/* get a minor number for the dev */
-	minor = (minor < 0) ? any_old_dev(md) : specific_dev(minor, md);
+	minor = (minor < 0) ? any_old_minor() : specific_minor(minor);
 	if (minor < 0) {
 		kfree(md);
 		return NULL;
@@ -547,6 +565,7 @@
 
 	md->disk = alloc_disk(1);
 	if (!md->disk) {
+		free_minor(md->disk->first_minor);
 		kfree(md);
 		return NULL;
 	}
@@ -566,6 +585,7 @@
 
 static void free_dev(struct mapped_device *md)
 {
+	free_minor(md->disk->first_minor);
 	del_gendisk(md->disk);
 	put_disk(md->disk);
 	kfree(md);
