Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265077AbSKAQSE>; Fri, 1 Nov 2002 11:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265081AbSKAQSE>; Fri, 1 Nov 2002 11:18:04 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:30382 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S265077AbSKAQSC>;
	Fri, 1 Nov 2002 11:18:02 -0500
Date: Fri, 1 Nov 2002 11:24:28 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Gerd Knorr <kraxel@bytesex.org>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: 2.5.45: initrd broken?
In-Reply-To: <20021101123132.GA30901@bytesex.org>
Message-ID: <Pine.GSO.4.21.0211011117450.20793-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 1 Nov 2002, Gerd Knorr wrote:

> Updated today to the latest bk tree.  Still doesn't boot, but crashes
> in a different way ...

OK, that's my fuckup in rd.c (not on initrd path, actually) + couple of
fuckups from Pat (mine: forgot to bump ->bd_count in rd_open(), Pat's:
dropped reference to gendisk on del_gendisk(), resulting in use of
kfree'd object + tried to remove a symlink that didn't exit).

Patch below fixes these.  It also changes order of blkdev_put()/del_gendisk()
in initrd_release() - better safe than sorry.

It got initrd working on my boxen...

diff -urN C45-no-rq_dev/drivers/block/rd.c C45-current/drivers/block/rd.c
--- C45-no-rq_dev/drivers/block/rd.c	Wed Oct 30 20:15:11 2002
+++ C45-current/drivers/block/rd.c	Fri Nov  1 11:12:33 2002
@@ -300,6 +300,8 @@
 {
 	extern void free_initrd_mem(unsigned long, unsigned long);
 
+	blkdev_put(inode->i_bdev, BDEV_FILE);
+
 	spin_lock(&initrd_users_lock);
 	if (!--initrd_users) {
 		spin_unlock(&initrd_users_lock);
@@ -309,8 +311,6 @@
 	} else {
 		spin_unlock(&initrd_users_lock);
 	}
-		
-	blkdev_put(inode->i_bdev, BDEV_FILE);
 	return 0;
 }
 
@@ -348,6 +348,7 @@
 	 */
 	if (rd_bdev[unit] == NULL) {
 		struct block_device *bdev = inode->i_bdev;
+		atomic_inc(&bdev->bd_count);
 		rd_bdev[unit] = bdev;
 		bdev->bd_openers++;
 		bdev->bd_block_size = rd_blocksize;
diff -urN C45-no-rq_dev/fs/partitions/check.c C45-current/fs/partitions/check.c
--- C45-no-rq_dev/fs/partitions/check.c	Fri Nov  1 08:17:14 2002
+++ C45-current/fs/partitions/check.c	Fri Nov  1 10:39:22 2002
@@ -535,12 +535,13 @@
 	disk->time_in_queue = 0;
 	disk->stamp = disk->stamp_idle = 0;
 	devfs_remove_partitions(disk);
-	kobject_unregister(&disk->kobj);
-	sysfs_remove_link(&disk->kobj, "device");
 	if (disk->driverfs_dev) {
+		sysfs_remove_link(&disk->kobj, "device");
 		sysfs_remove_link(&disk->driverfs_dev->kobj, "block");
 		put_device(disk->driverfs_dev);
 	}
+	kobject_get(&disk->kobj);	/* kobject model is fucked in head */
+	kobject_unregister(&disk->kobj);
 }
 
 struct dev_name {

