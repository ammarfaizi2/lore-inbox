Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278497AbRJPCKi>; Mon, 15 Oct 2001 22:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278498AbRJPCKa>; Mon, 15 Oct 2001 22:10:30 -0400
Received: from patan.Sun.COM ([192.18.98.43]:12687 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S278497AbRJPCKW>;
	Mon, 15 Oct 2001 22:10:22 -0400
Message-ID: <3BCB966E.82600865@sun.com>
Date: Mon, 15 Oct 2001 19:07:42 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@redhat.com, neilb@cse.unsw.edu.au,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alan@redhat.com, torvalds@transmeta.com
Subject: [PATCH] misc minor md fixes
Content-Type: multipart/mixed;
 boundary="------------DF276087E4676959B7318E52"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------DF276087E4676959B7318E52
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

All,

Attached is a small patch to fix up some md issues we've run across.

The changes are pretty obvious, and were needed here - please apply.  Let
me know if there is a problem with them.

Thanks

Tim
-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------DF276087E4676959B7318E52
Content-Type: text/plain; charset=us-ascii;
 name="md-misc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="md-misc.diff"

diff -ruN dist-2.4.12+patches/drivers/md/md.c cvs-2.4.12+patches/drivers/md/md.c
--- dist-2.4.12+patches/drivers/md/md.c	Mon Oct 15 10:21:57 2001
+++ cvs-2.4.12+patches/drivers/md/md.c	Mon Oct 15 10:21:57 2001
@@ -542,8 +542,10 @@
 		goto abort;
 	}
 
-	if (calc_sb_csum(sb) != sb->sb_csum)
+	if (calc_sb_csum(sb) != sb->sb_csum) {
 		printk(BAD_CSUM, partition_name(rdev->dev));
+		goto abort;
+	}
 	ret = 0;
 abort:
 	return ret;
diff -ruN dist-2.4.12+patches/drivers/md/raid1.c cvs-2.4.12+patches/drivers/md/raid1.c
--- dist-2.4.12+patches/drivers/md/raid1.c	Mon Oct 15 10:21:58 2001
+++ cvs-2.4.12+patches/drivers/md/raid1.c	Mon Oct 15 10:21:57 2001
@@ -1690,7 +1690,8 @@
 		}
 	}
 
-	if (!start_recovery && !(sb->state & (1 << MD_SB_CLEAN))) {
+	if (!start_recovery && !(sb->state & (1 << MD_SB_CLEAN)) &&
+	    (conf->working_disks > 1)) {
 		const char * name = "raid1syncd";
 
 		conf->resync_thread = md_register_thread(raid1syncd, conf,name);
diff -ruN dist-2.4.12+patches/drivers/md/raid5.c cvs-2.4.12+patches/drivers/md/raid5.c
--- dist-2.4.12+patches/drivers/md/raid5.c	Mon Oct 15 10:21:58 2001
+++ cvs-2.4.12+patches/drivers/md/raid5.c	Mon Oct 15 10:21:57 2001
@@ -488,22 +488,24 @@
 	PRINTK("raid5_error called\n");
 
 	for (i = 0, disk = conf->disks; i < conf->raid_disks; i++, disk++) {
-		if (disk->dev == dev && disk->operational) {
-			disk->operational = 0;
-			mark_disk_faulty(sb->disks+disk->number);
-			mark_disk_nonsync(sb->disks+disk->number);
-			mark_disk_inactive(sb->disks+disk->number);
-			sb->active_disks--;
-			sb->working_disks--;
-			sb->failed_disks++;
-			mddev->sb_dirty = 1;
-			conf->working_disks--;
-			conf->failed_disks++;
-			md_wakeup_thread(conf->thread);
-			printk (KERN_ALERT
-				"raid5: Disk failure on %s, disabling device."
-				" Operation continuing on %d devices\n",
-				partition_name (dev), conf->working_disks);
+		if (disk->dev == dev) {
+			if (disk->operational) {
+				disk->operational = 0;
+				mark_disk_faulty(sb->disks+disk->number);
+				mark_disk_nonsync(sb->disks+disk->number);
+				mark_disk_inactive(sb->disks+disk->number);
+				sb->active_disks--;
+				sb->working_disks--;
+				sb->failed_disks++;
+				mddev->sb_dirty = 1;
+				conf->working_disks--;
+				conf->failed_disks++;
+				md_wakeup_thread(conf->thread);
+				printk (KERN_ALERT
+					"raid5: Disk failure on %s, disabling device."
+					" Operation continuing on %d devices\n",
+					partition_name (dev), conf->working_disks);
+			}
 			return 0;
 		}
 	}

--------------DF276087E4676959B7318E52--

