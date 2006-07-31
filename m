Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbWGaHb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbWGaHb4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 03:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbWGaHb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 03:31:56 -0400
Received: from ns1.suse.de ([195.135.220.2]:20171 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964813AbWGaHby (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 03:31:54 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 31 Jul 2006 17:31:46 +1000
Message-Id: <1060731073146.24429@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 001 of 9] md: The scheduled removal of the START_ARRAY ioctl for md
References: <20060731172842.24323.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Adrian Bunk <bunk@stusta.de>

This patch contains the scheduled removal of the START_ARRAY ioctl for md.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./Documentation/feature-removal-schedule.txt |    9 --
 ./drivers/md/md.c                            |   82 ---------------------------
 ./include/linux/compat_ioctl.h               |    1 
 ./include/linux/raid/md_u.h                  |    2 
 4 files changed, 1 insertion(+), 93 deletions(-)

diff .prev/Documentation/feature-removal-schedule.txt ./Documentation/feature-removal-schedule.txt
--- .prev/Documentation/feature-removal-schedule.txt	2006-07-31 16:32:06.000000000 +1000
+++ ./Documentation/feature-removal-schedule.txt	2006-07-31 16:32:06.000000000 +1000
@@ -96,15 +96,6 @@ Who:    Arjan van de Ven
 
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

diff .prev/drivers/md/md.c ./drivers/md/md.c
--- .prev/drivers/md/md.c	2006-07-31 16:32:06.000000000 +1000
+++ ./drivers/md/md.c	2006-07-31 16:32:06.000000000 +1000
@@ -3427,67 +3427,6 @@ static void autorun_devices(int part)
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
@@ -4246,27 +4185,6 @@ static int md_ioctl(struct inode *inode,
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

diff .prev/include/linux/compat_ioctl.h ./include/linux/compat_ioctl.h
--- .prev/include/linux/compat_ioctl.h	2006-07-31 16:32:06.000000000 +1000
+++ ./include/linux/compat_ioctl.h	2006-07-31 16:32:06.000000000 +1000
@@ -120,7 +120,6 @@ COMPATIBLE_IOCTL(PROTECT_ARRAY)
 ULONG_IOCTL(HOT_ADD_DISK)
 ULONG_IOCTL(SET_DISK_FAULTY)
 COMPATIBLE_IOCTL(RUN_ARRAY)
-ULONG_IOCTL(START_ARRAY)
 COMPATIBLE_IOCTL(STOP_ARRAY)
 COMPATIBLE_IOCTL(STOP_ARRAY_RO)
 COMPATIBLE_IOCTL(RESTART_ARRAY_RW)

diff .prev/include/linux/raid/md_u.h ./include/linux/raid/md_u.h
--- .prev/include/linux/raid/md_u.h	2006-07-31 16:32:06.000000000 +1000
+++ ./include/linux/raid/md_u.h	2006-07-31 16:32:06.000000000 +1000
@@ -41,7 +41,7 @@
 
 /* usage */
 #define RUN_ARRAY		_IOW (MD_MAJOR, 0x30, mdu_param_t)
-#define START_ARRAY		_IO (MD_MAJOR, 0x31)
+/*  0x31 was START_ARRAY  */
 #define STOP_ARRAY		_IO (MD_MAJOR, 0x32)
 #define STOP_ARRAY_RO		_IO (MD_MAJOR, 0x33)
 #define RESTART_ARRAY_RW	_IO (MD_MAJOR, 0x34)
