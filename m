Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263760AbTLXRgc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 12:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263758AbTLXRfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 12:35:53 -0500
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:12469 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263734AbTLXRey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 12:34:54 -0500
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: linux-kernel@vger.kernel.org
Subject: [NEW FEATURE]Partitions on loop device for 2.6
Date: Wed, 24 Dec 2003 18:20:22 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Message-Id: <200312241341.23523.blaisorblade_spam@yahoo.it>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Wrc6/iSBVdrTN4q"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_Wrc6/iSBVdrTN4q
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

NEED:
I have the need to loop mount files containing not plain filesystems, but 
whole disk images.

This is especially needed when using User-mode-linux, since to run any distro 
installer you must partition the virtual disks(and on the host, the backing 
file of the disk contains a partition table).

Currently this could be done by specifying a positive offset, but letting the 
kernel partition code handle this is better, isn't it? Would you ever accept 
this feature into stock kernel?

CC me on replies, as I'm not subscribed, please.

WHAT I DID:
The attached patch is not at all "cleaned up", nor meant for official 
inclusion yet; some problems are there, and I need allocating a new major; 
also, I'd like to use the new 32 bit dev_t, as for know I can have only 15 
partitions(instead of 63) and 16 devices. It is against stock 2.6.0 and nearby 
kernels; but it already contains the patch in "[PATCH] loop.c doesn't fail 
init gracefully" from me. I have the separate patch.

No change in the "real" loop code is done, so the patch is non-intrusive; the 
driver IO code just sees some more devices to handle, but the init routine 
map those more devices to a different major and call alloc_disk(16) rather 
than alloc_disk(1).
A HD_GETGEO ioctl is also added to make fdisk happy.

So, I've modified a bit loop.c to handle this on a new set of devices, 
/dev/ploop#p#. This because /dev/ploop1 can't have minor 1, but 16; by 
creating separate loop devices, I remove the need of recreating 
/dev/loop*(i.e. people trying to use /dev/loop1 and seeing that it's a 
partition of /dev/loop0).

Currently on major 60(to change soon, as this is experimental), and on minors 
from 0 onwards; 16 partitions per disk, so you do:
mknod /dev/ploop0 b 60 0
mknod /dev/ploop0p# b 60 #
(where # is a number from 1 to 15) and so on.

You use losetup on /dev/ploop0 normally, and can mount /dev/ploop0(if the file 
has no partition table) and SHOULD be able to mount /dev/ploop0p#. And you 
can do that and work well, but only after a BLKRRPART ioctl :-(...

ISSUES:
A) the partition table is scanned at the moment of calling add_disk, when 
there is no file attached.
So when calling losetup, the code must somehow rescan the partition. I tried 
various way, but either they don't work, I'm not sure of them, or they are 
just hacks, or all these things together. Has anyone a clue? I thought of 
calling del_gendisk and add_disk again, but I'm not sure if it's right.

 I tried these:
1)                 err = blkdev_ioctl(inode, file, BLKRRPART, 0);
which I tried but doesn't work(i.e. I get only a "unknown partition table" 
when it's called; moreover that function is not intended for such use nor is 
exported).
2) so I thought of calling ioctl, which is impossible as that needs an fd, so 
this isn't clean either.
3) none of blkdev_reread_part(even static) or rescan_partitions is exported, 
so calling them would be unclean, and calling them directly doesn't seem safe 
to me, for locking issues(i.e. rescan_partitions doesn't do any locking, 
blkdev_reread_part does it but it's static).
B) calling losetup(i.e. the ioctl's) on a partition device is the same thing 
as calling it on the whole disk, if that partition existed last time the 
partition table was read. Bug or useless feature? Avoiding this would be 
anyway difficult, I think.
C) I'm not sure the returned geometry(HD_GETGEO ioctl) is ok. What will fdisk 
do when a cylinder is not complete(i.e. cylinders*sectors*heads*512 != 
totalsize)? Or if there is less than one cylinder? Also, if the max. number 
of cylinders is 2^20(as fdisk says: is this true?), the maximum capacity is 
32Gb. If there is the need, this can be improved quite easily. Just suggest 
better geometries.

Thanks for your attention and bye!
-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN





--Boundary-00=_Wrc6/iSBVdrTN4q
Content-Type: text/x-diff;
  charset="us-ascii";
  name="B-combo-Partitioned_loop_support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="B-combo-Partitioned_loop_support.patch"

--- ./drivers/block/loop.c.nofix	2003-12-11 19:37:08.000000000 +0100
+++ ./drivers/block/loop.c	2003-12-23 13:15:04.000000000 +0100
@@ -39,6 +39,9 @@
  * Support up to 256 loop devices
  * Heinz Mauelshagen <mge@sistina.com>, Feb 2002
  *
+ * Added partition support
+ * Paolo Giarrusso <blaisorblade_work@yahoo.it>, Dec 2003
+ * 
  * Still To Fix:
  * - Advisory locking is ignored here.
  * - Should use an own CAP_* category instead of CAP_SYS_ADMIN
@@ -65,10 +68,17 @@
 #include <linux/suspend.h>
 #include <linux/writeback.h>
 #include <linux/buffer_head.h>		/* for invalidate_bdev() */
+#include <linux/hdreg.h>
 
 #include <asm/uaccess.h>
 
-static int max_loop = 8;
+#define PLOOP_MAJOR 60 			/* FIXME: move to the right place */
+#define PARTN_BITS 4
+
+static int max_loop;
+static int max_part_loop = 8;
+static int max_nopart_loop = 8;		/* This is the number of normal loop devices
+					   (i.e. no partition support)*/
 static struct loop_device *loop_dev;
 static struct gendisk **disks;
 
@@ -607,7 +617,10 @@
 	struct loop_device *lo = data;
 	struct bio *bio;
 
-	daemonize("loop%d", lo->lo_number);
+	if (lo->lo_number < max_nopart_loop)
+	  daemonize("loop%d", lo->lo_number);
+	else
+	  daemonize("ploop%d", lo->lo_number - max_nopart_loop);
 
 	/*
 	 * loop can be used in an encrypted device,
@@ -1055,6 +1068,22 @@
 
 	return err;
 }
+static int loop_get_geo(struct loop_device *lo, struct hd_geometry *arg)
+{
+	long size;
+	struct hd_geometry geo;
+
+	size = get_capacity(disks[lo->lo_number]);
+	/* Maximum is 1 Mega cyls, so we get heads * sectors * 512 MiB as max size, i.e. 32GB; minimum is
+	 * heads * sector * 512, i.e. 32 KiB. Else no cylinders, but you just can't partition it.*/
+	geo.cylinders = (size & ~0x3f) >> 6;
+	geo.heads = 4;
+	geo.sectors = 16;
+	geo.start = 4;
+	if (copy_to_user(arg, &geo, sizeof(geo)))
+		return -EFAULT;
+	return 0;
+}
 
 static int lo_ioctl(struct inode * inode, struct file * file,
 	unsigned int cmd, unsigned long arg)
@@ -1066,6 +1095,11 @@
 	switch (cmd) {
 	case LOOP_SET_FD:
 		err = loop_set_fd(lo, file, inode->i_bdev, arg);
+		/* We need to reread the partition table. Do it here to avoid
+		 * passing the extra param down. But since this doesn't work,
+		 * comment it out for now.*/
+		/*if (!err && lo->lo_number >= max_nopart_loop)
+		  err = blkdev_ioctl(inode, file, BLKRRPART, 0); */
 		break;
 	case LOOP_CLR_FD:
 		err = loop_clr_fd(lo, inode->i_bdev);
@@ -1082,6 +1116,9 @@
 	case LOOP_GET_STATUS64:
 		err = loop_get_status64(lo, (struct loop_info64 *) arg);
 		break;
+	case HDIO_GETGEO:
+		err = loop_get_geo(lo, (struct hd_geometry *) arg);
+		break;
 	default:
 		err = lo->ioctl ? lo->ioctl(lo, cmd, arg) : -EINVAL;
 	}
@@ -1121,8 +1158,10 @@
 /*
  * And now the modules code and kernel interface.
  */
-MODULE_PARM(max_loop, "i");
-MODULE_PARM_DESC(max_loop, "Maximum number of loop devices (1-256)");
+MODULE_PARM(max_nopart_loop, "i");
+MODULE_PARM_DESC(max_nopart_loop, "Maximum number of loop devices (1-256)");
+MODULE_PARM(max_part_loop, "i");
+MODULE_PARM_DESC(max_part_loop, "Maximum number of partitionable loop devices (1-256)");
 MODULE_LICENSE("GPL");
 
 int loop_register_transfer(struct loop_func_table *funcs)
@@ -1164,16 +1203,28 @@
 int __init loop_init(void)
 {
 	int	i;
+	int 	ret = -ENOMEM;
 
-	if (max_loop < 1 || max_loop > 256) {
-		printk(KERN_WARNING "loop: invalid max_loop (must be between"
+	if (max_nopart_loop < 1 || max_nopart_loop > 256) {
+		printk(KERN_WARNING "loop: invalid max_nopart_loop (must be between"
 				    " 1 and 256), using default (8)\n");
-		max_loop = 8;
+		max_nopart_loop = 8;
+	}
+	if (max_part_loop < 1 || max_part_loop > (256 >> PARTN_BITS)) {
+		printk(KERN_WARNING "loop: invalid max_part_loop (must be between"
+				    " 1 and %d), using default (8)\n", 256 >> PARTN_BITS);
+		max_part_loop = 8;
 	}
+	max_loop = max_nopart_loop + max_part_loop;
 
 	if (register_blkdev(LOOP_MAJOR, "loop"))
 		return -EIO;
 
+	if (register_blkdev(PLOOP_MAJOR, "ploop")) {
+		ret = -EIO;
+		goto out_noreg;
+	}
+
 	loop_dev = kmalloc(max_loop * sizeof(struct loop_device), GFP_KERNEL);
 	if (!loop_dev)
 		goto out_mem1;
@@ -1183,13 +1234,19 @@
 	if (!disks)
 		goto out_mem2;
 
-	for (i = 0; i < max_loop; i++) {
+	for (i = 0; i < max_nopart_loop; i++) {
 		disks[i] = alloc_disk(1);
 		if (!disks[i])
 			goto out_mem3;
 	}
+	for ( ; i < max_loop; i++) {
+		disks[i] = alloc_disk(1 << PARTN_BITS);
+		if (!disks[i])
+			goto out_mem3;
+	}
 
 	devfs_mk_dir("loop");
+	devfs_mk_dir("ploop");
 
 	for (i = 0; i < max_loop; i++) {
 		struct loop_device *lo = &loop_dev[i];
@@ -1205,21 +1262,36 @@
 		init_MUTEX_LOCKED(&lo->lo_bh_mutex);
 		lo->lo_number = i;
 		spin_lock_init(&lo->lo_lock);
-		disk->major = LOOP_MAJOR;
-		disk->first_minor = i;
 		disk->fops = &lo_fops;
-		sprintf(disk->disk_name, "loop%d", i);
-		sprintf(disk->devfs_name, "loop/%d", i);
+		if (i < max_nopart_loop) {
+			disk->major = LOOP_MAJOR;
+			disk->first_minor = i;
+			sprintf(disk->disk_name, "loop%d", i);
+			sprintf(disk->devfs_name, "loop/%d", i);
+		} else {
+			int idx = i - max_nopart_loop;
+			disk->major = PLOOP_MAJOR;
+			disk->first_minor = idx << PARTN_BITS;
+			sprintf(disk->disk_name, "ploop%d", idx);
+			sprintf(disk->devfs_name, "ploop/%d", idx);
+		}
+
 		disk->private_data = lo;
 		disk->queue = lo->lo_queue;
-		add_disk(disk);
 	}
-	printk(KERN_INFO "loop: loaded (max %d devices)\n", max_loop);
+
+	/* We cannot fail after we call this, so another loop!*/
+	for (i = 0; i < max_loop; i++)
+		add_disk(disks[i]);
+	printk(KERN_INFO "loop: loaded (max %d not partitioned devices "
+	    		 "and %d partitioned ones)\n", max_nopart_loop, max_part_loop);
 	return 0;
 
 out_mem4:
 	while (i--)
 		blk_put_queue(loop_dev[i].lo_queue);
+	devfs_remove("ploop");
+	devfs_remove("loop");
 	i = max_loop;
 out_mem3:
 	while (i--)
@@ -1228,9 +1300,12 @@
 out_mem2:
 	kfree(loop_dev);
 out_mem1:
+	unregister_blkdev(PLOOP_MAJOR, "ploop");
+out_noreg:
 	unregister_blkdev(LOOP_MAJOR, "loop");
-	printk(KERN_ERR "loop: ran out of memory\n");
-	return -ENOMEM;
+	if (ret == -ENOMEM) 
+		printk(KERN_ERR "loop: ran out of memory\n");
+	return ret;
 }
 
 void loop_exit(void)
@@ -1246,6 +1321,9 @@
 	if (unregister_blkdev(LOOP_MAJOR, "loop"))
 		printk(KERN_WARNING "loop: cannot unregister blkdev\n");
 
+	if (unregister_blkdev(PLOOP_MAJOR, "ploop"))
+		printk(KERN_WARNING "loop: cannot unregister blkdev #2\n");
+
 	kfree(disks);
 	kfree(loop_dev);
 }
@@ -1256,7 +1334,7 @@
 #ifndef MODULE
 static int __init max_loop_setup(char *str)
 {
-	max_loop = simple_strtol(str, NULL, 0);
+	max_part_loop = simple_strtol(str, NULL, 0);
 	return 1;
 }
 

--Boundary-00=_Wrc6/iSBVdrTN4q--


