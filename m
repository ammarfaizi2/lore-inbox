Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264645AbSJ3KKI>; Wed, 30 Oct 2002 05:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264651AbSJ3KKH>; Wed, 30 Oct 2002 05:10:07 -0500
Received: from cmailg5.svr.pol.co.uk ([195.92.195.175]:41069 "EHLO
	cmailg5.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S264645AbSJ3KJc>; Wed, 30 Oct 2002 05:09:32 -0500
Date: Wed, 30 Oct 2002 10:15:58 +0000
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dm update 3/3
Message-ID: <20021030101558.GB10815@fib011235813.fsnet.co.uk>
References: <20021029172016.GC1779@fib011235813.fsnet.co.uk> <Pine.GSO.4.21.0210291240380.9171-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0210291240380.9171-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2002 at 12:42:24PM -0500, Alexander Viro wrote:
> Ugh.  See find_first_zero_bit() - no need to reinvent that wheel...


--- diff/drivers/md/dm.c	2002-10-30 09:38:39.000000000 +0000
+++ source/drivers/md/dm.c	2002-10-30 10:03:54.000000000 +0000
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
@@ -497,26 +509,27 @@
 		return -EINVAL;
 	}
 
-	disk = get_gendisk(MKDEV(_major, minor), &part);
-	if (disk) {
-		put_disk(disk);
-		return -EBUSY;
-	}
+	spin_lock(&_minor_lock);
+	if (!test_and_set_bit(minor, _minor_bits))
+		r = minor;
+	spin_unlock(&_minor_lock);
 
-	return minor;
+	return r;
 }
 
-static int any_old_dev(struct mapped_device *md)
+static int next_free_minor(void)
 {
-	int i;
+	int minor, r = -EBUSY;
 
-	for (i = 0; i < MAX_DEVICES; i++)
-		if (specific_dev(i, md) >= 0) {
-			DMWARN("allocating minor = %d", i);
-			return i;
-		}
+	spin_lock(&_minor_lock);
+	minor = find_first_zero_bit(_minor_bits, MAX_DEVICES);
+	if (minor != MAX_DEVICES) {
+		set_bit(minor, _minor_bits);
+		r = minor;
+	}
+	spin_unlock(&_minor_lock);
 
-	return -EBUSY;
+	return r;
 }
 
 /*
@@ -532,12 +545,13 @@
 	}
 
 	/* get a minor number for the dev */
-	minor = (minor < 0) ? any_old_dev(md) : specific_dev(minor, md);
+	minor = (minor < 0) ? next_free_minor() : specific_minor(minor);
 	if (minor < 0) {
 		kfree(md);
 		return NULL;
 	}
 
+	DMWARN("allocating minor %d.", minor);
 	memset(md, 0, sizeof(*md));
 	init_rwsem(&md->lock);
 	atomic_set(&md->holders, 1);
@@ -547,6 +561,7 @@
 
 	md->disk = alloc_disk(1);
 	if (!md->disk) {
+		free_minor(md->disk->first_minor);
 		kfree(md);
 		return NULL;
 	}
@@ -566,6 +581,7 @@
 
 static void free_dev(struct mapped_device *md)
 {
+	free_minor(md->disk->first_minor);
 	del_gendisk(md->disk);
 	put_disk(md->disk);
 	kfree(md);

