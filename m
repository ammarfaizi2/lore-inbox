Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283486AbRK3Cw7>; Thu, 29 Nov 2001 21:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283483AbRK3Cwy>; Thu, 29 Nov 2001 21:52:54 -0500
Received: from mail4.mx.voyager.net ([216.93.66.203]:20742 "EHLO
	mail4.mx.voyager.net") by vger.kernel.org with ESMTP
	id <S283486AbRK3Cwg>; Thu, 29 Nov 2001 21:52:36 -0500
Message-ID: <3C06F473.9EEB888B@megsinet.net>
Date: Thu, 29 Nov 2001 20:52:35 -0600
From: "M.H.VanLeeuwen" <vanl@megsinet.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: vanl@megsinet.net
Subject: [RFC][PATCH] start md devices in ascending order, etc.
Content-Type: multipart/mixed;
 boundary="------------A47DE9E89B9053779778FF1C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A47DE9E89B9053779778FF1C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The attached patch against 2.4.16 does the following:

Briefly:
a. auto started MD arrays are started in ascending order
b. auto start MD arrays that are mixed physical devices and other MD arrays
c. fsync's MD array after resync is complete.


Rational:
a. I think the characteristics of a system that attempts to guarantee the order
   arrays are initialized, rather than by depending on the physical device (disks
   and partitions) assignment in the system, is preferable.  That is to say, if you
   add new drives and/or partitions and create/change your RAID arrays the order that
   the arrays are started may change.  This is not necessarily a problem for arrays
   that are all true physical devices, i.e.. pure arrays.  Enter "b" kernel auto-start
   of non-pure arrays.
b. Allow the kernel to auto-start RAID arrays that consist of a mix of auto-start
   disk partitions (marked FD) and other running RAID arrays by starting all "pure"
   arrays first than "non-pure" arrays secondly.  As long as an array has at least
   one disk partition mark for auto-start, this patch will allow the kernel to also
   add to that array any MD device that is already running.
c. After RAID 1 resync the system sat for 4 hours on an idle system showing that there
   were a few blocks difference between the size of the array and the blocks that were sync'd.
   A manual "sync" finished the RAID resync.  Why hasn't the system flushed old buffers???

So far I've tested with:

1. md0 being a RAID 0 device consisting of 2 1G drives, and md1 being a RAID 1 device with
   a real 2G drive and md0 as the mirror device.
2. reverse the above... md1 is RAID 0 w/ 2 1G drives, and md0 being the RAID 1 device with
   a real 2G drive and md1 as the mirror device.

The kernel happily starts both arrays either way with this patch...no need for kernel command
line/lilo config options/parameters.

Please CC me.
Martin
--------------A47DE9E89B9053779778FF1C
Content-Type: text/plain; charset=us-ascii;
 name="raid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="raid.patch"

--- md_compatible.h.orig	Tue Nov 27 14:55:04 2001
+++ md_compatible.h	Wed Nov 28 22:41:07 2001
@@ -123,8 +123,10 @@
 #define MD_LIST_HEAD(name) LIST_HEAD(name)
 #define MD_INIT_LIST_HEAD(ptr) INIT_LIST_HEAD(ptr)
 #define md_list_add list_add
+#define md_list_add_tail list_add_tail
 #define md_list_del list_del
 #define md_list_empty list_empty
+#define md_list_splice list_splice
 
 #define md_list_entry(ptr, type, member) list_entry(ptr, type, member)
 
--- md.c.2.4.16.orig	Mon Nov 26 13:06:44 2001
+++ md.c	Thu Nov 29 00:28:59 2001
@@ -18,6 +18,9 @@
 
      Neil Brown <neilb@cse.unsw.edu.au>.
 
+   - start arrays in ascending order: Martin Van Leeuwen <vanl@megsinet.net>
+   - allow arrays as members of autostarted arrays: Martin Van Leeuwen <vanl@megsinet.net>
+
    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2, or (at your option)
@@ -1863,6 +1866,40 @@
 #undef OUT
 
 /*
+ * does the "rdev" contain this "dev"
+ */
+int dev_in_rdev(mdk_rdev_t *rdev, kdev_t dev)
+{
+	mdp_disk_t *desc;
+	int i;
+
+	for (i = 0; i < MD_SB_DISKS; i++) {
+		desc = rdev->sb->disks + i;
+		if (dev == MKDEV(desc->major, desc->minor))
+			return 1;
+	}
+	return 0;
+}
+
+/*
+ * does this rdev contain an md device(s) as the other part(s) of the raid array
+ */
+int any_md_in_rdev(mdk_rdev_t *rdev)
+{
+	mdp_disk_t *desc;
+	int i, minor;
+
+	for (i = 0; i < MD_SB_DISKS; i++) {
+		desc = rdev->sb->disks + i;
+		for (minor = 0; minor < MAX_MD_DEVS; minor++) {
+			if (MKDEV(MD_MAJOR, minor) == MKDEV(desc->major, desc->minor))
+				return 1;
+		}
+	}
+	return 0;
+}
+
+/*
  * We have to safely support old arrays too.
  */
 int detect_old_array(mdp_super_t *sb)
@@ -1879,6 +1916,7 @@
 static void autorun_array(mddev_t *mddev)
 {
 	mdk_rdev_t *rdev;
+	kdev_t dev;
 	struct md_list_head *tmp;
 	int err;
 
@@ -1902,7 +1940,37 @@
 		 */
 		mddev->sb_dirty = 0;
 		do_md_stop (mddev, 0);
-	}
+	} else {
+		dev = MKDEV(MD_MAJOR,mddev->sb->md_minor);
+		ITERATE_RDEV_PENDING(rdev,tmp) {
+			if (dev_in_rdev(rdev, dev)) {
+				if (md_import_device(dev,0)) return;
+				rdev = find_rdev_all(dev);
+				if (!rdev) return;
+				if (read_disk_sb(rdev)) goto return_free;
+				if (rdev->sb->md_magic != MD_SB_MAGIC) goto return_free;
+				if (check_disk_sb(rdev)) goto return_free;
+				if (rdev->sb->level != -4) {
+					rdev->old_dev = MKDEV(rdev->sb->this_disk.major,
+								rdev->sb->this_disk.minor);
+					rdev->desc_nr = rdev->sb->this_disk.number;
+				} else {
+					rdev->old_dev = MKDEV(0, 0);
+					rdev->desc_nr = -1;
+				}
+				md_list_add_tail(&rdev->pending, &pending_raid_disks);
+				return;
+			}
+		}
+		return;
+
+return_free:
+		unlock_rdev(rdev);
+		free_disk_sb(rdev);
+		md_list_del(&rdev->all);
+		MD_INIT_LIST_HEAD(&rdev->all);
+		kfree(rdev);
+        }
 }
 
 /*
@@ -3474,6 +3542,7 @@
 		} else
 			current->nice = -20;
 	}
+	fsync_dev(MKDEV(MD_MAJOR, mdidx(mddev)));
 	printk(KERN_INFO "md: md%d: sync done.\n",mdidx(mddev));
 	err = 0;
 	/*
@@ -3713,7 +3782,9 @@
 static void autostart_arrays(void)
 {
 	mdk_rdev_t *rdev;
-	int i;
+	struct md_list_head *tmp;
+	MD_LIST_HEAD(tmpending);
+	int i,minor;
 
 	printk(KERN_INFO "md: Autodetecting RAID arrays.\n");
 
@@ -3726,21 +3797,34 @@
 			continue;
 		}
 		/*
-		 * Sanity checks:
+		 * Sanity check:
 		 */
 		rdev = find_rdev_all(dev);
 		if (!rdev) {
 			MD_BUG();
 			continue;
 		}
-		if (rdev->faulty) {
-			MD_BUG();
-			continue;
-		}
-		md_list_add(&rdev->pending, &pending_raid_disks);
 	}
 	dev_cnt = 0;
 
+	/*
+	 * Order the pending list so that md arrays are started in ascending order,
+	 * but any arrays that include other md arrays are started after the pure arrays
+	 * in ascending order.
+	 */
+	for (minor = 0; minor < MAX_MD_DEVS; minor++ ) {
+		ITERATE_RDEV_ALL(rdev, tmp) {
+			if(rdev->sb) { 			/* faulty device check */
+				if(rdev->sb->md_minor == minor) {
+					if (any_md_in_rdev(rdev))
+						md_list_add_tail(&rdev->pending, &pending_raid_disks);
+					else
+						md_list_add_tail(&rdev->pending, &tmpending);
+				}
+			}
+		}
+	}
+	md_list_splice(&tmpending, &pending_raid_disks);
 	autorun_devices(-1);
 }
 
@@ -3766,9 +3850,9 @@
  *             md=n,-1,factor,fault,device-list  uses LINEAR for device n
  *             md=n,device-list      reads a RAID superblock from the devices
  *             elements in device-list are read by name_to_kdev_t so can be
- *             a hex number or something like /dev/hda1 /dev/sdb
+ *             a hex number or something like /dev/hda1,/dev/sdb
  * 2001-06-03: Dave Cinege <dcinege@psychosis.com>
- *		Shifted name_to_kdev_t() and related operations to md_set_drive()
+ *		Shifted name_to_kdev_t() and related operations to md_setup_drive()
  *		for later execution. Rewrote section to make devfs compatible.
  */
 static int md__init md_setup(char *str)


--------------A47DE9E89B9053779778FF1C--

