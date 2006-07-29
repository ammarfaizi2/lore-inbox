Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbWG2Rs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWG2Rs1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 13:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWG2Rs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 13:48:27 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:274 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932173AbWG2Rs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 13:48:26 -0400
Date: Sat, 29 Jul 2006 19:48:26 +0200
From: Adrian Bunk <bunk@stusta.de>
To: NeilBrown <neilb@suse.de>
Cc: mingo@redhat.com, linux-raid@vger.kernel.or, linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] the scheduled removal of the START_ARRAY ioctl for md
Message-ID: <20060729174826.GB26963@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the scheduled removal of the START_ARRAY ioctl for md.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/feature-removal-schedule.txt |    9 --
 drivers/md/md.c                            |   82 ---------------------
 include/linux/compat_ioctl.h               |    1 
 include/linux/raid/md_u.h                  |    2 
 4 files changed, 1 insertion(+), 93 deletions(-)

--- linux-2.6.18-rc2-mm1-full/Documentation/feature-removal-schedule.txt.old	2006-07-27 20:38:18.000000000 +0200
+++ linux-2.6.18-rc2-mm1-full/Documentation/feature-removal-schedule.txt	2006-07-27 20:38:30.000000000 +0200
@@ -87,15 +87,6 @@
 
 ---------------------------
 
-What:	START_ARRAY ioctl for md
-When:	July 2006
-Files:	drivers/md/md.c
-Why:	Not reliable by design - can fail when most needed.
-	Alternatives exist
-Who:	NeilBrown <neilb@suse.de>
-
----------------------------
-
 What:   eepro100 network driver
 When:   January 2007
 Why:    replaced by the e100 driver
--- linux-2.6.18-rc2-mm1-full/include/linux/raid/md_u.h.old	2006-07-27 20:38:39.000000000 +0200
+++ linux-2.6.18-rc2-mm1-full/include/linux/raid/md_u.h	2006-07-27 20:39:22.000000000 +0200
@@ -41,7 +41,7 @@
 
 /* usage */
 #define RUN_ARRAY		_IOW (MD_MAJOR, 0x30, mdu_param_t)
-#define START_ARRAY		_IO (MD_MAJOR, 0x31)
+/*  0x31 was START_ARRAY  */
 #define STOP_ARRAY		_IO (MD_MAJOR, 0x32)
 #define STOP_ARRAY_RO		_IO (MD_MAJOR, 0x33)
 #define RESTART_ARRAY_RW	_IO (MD_MAJOR, 0x34)
--- linux-2.6.18-rc2-mm1-full/include/linux/compat_ioctl.h.old	2006-07-27 20:39:30.000000000 +0200
+++ linux-2.6.18-rc2-mm1-full/include/linux/compat_ioctl.h	2006-07-27 20:39:44.000000000 +0200
@@ -120,7 +120,6 @@
 ULONG_IOCTL(HOT_ADD_DISK)
 ULONG_IOCTL(SET_DISK_FAULTY)
 COMPATIBLE_IOCTL(RUN_ARRAY)
-ULONG_IOCTL(START_ARRAY)
 COMPATIBLE_IOCTL(STOP_ARRAY)
 COMPATIBLE_IOCTL(STOP_ARRAY_RO)
 COMPATIBLE_IOCTL(RESTART_ARRAY_RW)
--- linux-2.6.18-rc2-mm1-full/drivers/md/md.c.old	2006-07-27 20:39:52.000000000 +0200
+++ linux-2.6.18-rc2-mm1-full/drivers/md/md.c	2006-07-27 20:41:04.000000000 +0200
@@ -3427,67 +3427,6 @@
 	printk(KERN_INFO "md: ... autorun DONE.\n");
 }
 
-/*
- * import RAID devices based on one partition
- * if possible, the array gets run as well.
- */
-
-static int autostart_array(dev_t startdev)
-{
-	char b[BDEVNAME_SIZE];
-	int err = -EINVAL, i;
-	mdp_super_t *sb = NULL;
-	mdk_rdev_t *start_rdev = NULL, *rdev;
-
-	start_rdev = md_import_device(startdev, 0, 0);
-	if (IS_ERR(start_rdev))
-		return err;
-
-
-	/* NOTE: this can only work for 0.90.0 superblocks */
-	sb = (mdp_super_t*)page_address(start_rdev->sb_page);
-	if (sb->major_version != 0 ||
-	    sb->minor_version != 90 ) {
-		printk(KERN_WARNING "md: can only autostart 0.90.0 arrays\n");
-		export_rdev(start_rdev);
-		return err;
-	}
-
-	if (test_bit(Faulty, &start_rdev->flags)) {
-		printk(KERN_WARNING 
-			"md: can not autostart based on faulty %s!\n",
-			bdevname(start_rdev->bdev,b));
-		export_rdev(start_rdev);
-		return err;
-	}
-	list_add(&start_rdev->same_set, &pending_raid_disks);
-
-	for (i = 0; i < MD_SB_DISKS; i++) {
-		mdp_disk_t *desc = sb->disks + i;
-		dev_t dev = MKDEV(desc->major, desc->minor);
-
-		if (!dev)
-			continue;
-		if (dev == startdev)
-			continue;
-		if (MAJOR(dev) != desc->major || MINOR(dev) != desc->minor)
-			continue;
-		rdev = md_import_device(dev, 0, 0);
-		if (IS_ERR(rdev))
-			continue;
-
-		list_add(&rdev->same_set, &pending_raid_disks);
-	}
-
-	/*
-	 * possibly return codes
-	 */
-	autorun_devices(0);
-	return 0;
-
-}
-
-
 static int get_version(void __user * arg)
 {
 	mdu_version_t ver;
@@ -4246,27 +4185,6 @@
 		goto abort;
 	}
 
-
-	if (cmd == START_ARRAY) {
-		/* START_ARRAY doesn't need to lock the array as autostart_array
-		 * does the locking, and it could even be a different array
-		 */
-		static int cnt = 3;
-		if (cnt > 0 ) {
-			printk(KERN_WARNING
-			       "md: %s(pid %d) used deprecated START_ARRAY ioctl. "
-			       "This will not be supported beyond July 2006\n",
-			       current->comm, current->pid);
-			cnt--;
-		}
-		err = autostart_array(new_decode_dev(arg));
-		if (err) {
-			printk(KERN_WARNING "md: autostart failed!\n");
-			goto abort;
-		}
-		goto done;
-	}
-
 	err = mddev_lock(mddev);
 	if (err) {
 		printk(KERN_INFO 

