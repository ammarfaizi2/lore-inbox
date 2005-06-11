Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261644AbVFKHzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbVFKHzN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 03:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbVFKHyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 03:54:47 -0400
Received: from mail.kroah.org ([69.55.234.183]:64707 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261644AbVFKHsk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 03:48:40 -0400
Subject: [PATCH] Remove devfs_*_tape() functions from the kernel tree
In-Reply-To: <11184761103552@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Sat, 11 Jun 2005 00:48:31 -0700
Message-Id: <1118476111192@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Removes the devfs_register_tape() and devfs_unregister_tape() functions
and all callers of them.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/char/viotape.c          |    3 ---
 drivers/ide/ide-tape.c          |    3 +--
 drivers/scsi/osst.c             |    3 +--
 drivers/scsi/st.c               |    3 +--
 include/linux/devfs_fs_kernel.h |    7 -------
 5 files changed, 3 insertions(+), 16 deletions(-)

--- gregkh-2.6.orig/include/linux/devfs_fs_kernel.h	2005-06-10 23:36:41.000000000 -0700
+++ gregkh-2.6/include/linux/devfs_fs_kernel.h	2005-06-10 23:38:24.000000000 -0700
@@ -26,11 +26,4 @@
 static inline void devfs_remove(const char *fmt, ...)
 {
 }
-static inline int devfs_register_tape(const char *name)
-{
-	return -1;
-}
-static inline void devfs_unregister_tape(int num)
-{
-}
 #endif				/*  _LINUX_DEVFS_FS_KERNEL_H  */
--- gregkh-2.6.orig/drivers/scsi/st.c	2005-06-10 23:29:08.000000000 -0700
+++ gregkh-2.6/drivers/scsi/st.c	2005-06-10 23:38:18.000000000 -0700
@@ -3997,7 +3997,7 @@
 			      S_IFCHR | S_IRUGO | S_IWUGO,
 			      "%s/mt%sn", SDp->devfs_name, st_formats[i]);
 	}
-	disk->number = devfs_register_tape(SDp->devfs_name);
+	disk->number = -1;
 
 	printk(KERN_WARNING
 	"Attached scsi tape %s at scsi%d, channel %d, id %d, lun %d\n",
@@ -4054,7 +4054,6 @@
 			scsi_tapes[i] = NULL;
 			st_nr_dev--;
 			write_unlock(&st_dev_arr_lock);
-			devfs_unregister_tape(tpnt->disk->number);
 			sysfs_remove_link(&tpnt->device->sdev_gendev.kobj,
 					  "tape");
 			for (mode = 0; mode < ST_NBR_MODES; ++mode) {
--- gregkh-2.6.orig/drivers/char/viotape.c	2005-06-10 23:29:08.000000000 -0700
+++ gregkh-2.6/drivers/char/viotape.c	2005-06-10 23:38:18.000000000 -0700
@@ -247,7 +247,6 @@
  */
 static struct {
 	unsigned char	cur_part;
-	int		dev_handle;
 	unsigned char	part_stat_rwi[MAX_PARTITIONS];
 } state[VIOTAPE_MAX_TAPE];
 
@@ -965,7 +964,6 @@
 	devfs_mk_cdev(MKDEV(VIOTAPE_MAJOR, i | 0x80),
 			S_IFCHR | S_IRUSR | S_IWUSR, "iseries/nvt%d", i);
 	sprintf(tapename, "iseries/vt%d", i);
-	state[i].dev_handle = devfs_register_tape(tapename);
 	printk(VIOTAPE_KERN_INFO "tape %s is iSeries "
 			"resource %10.10s type %4.4s, model %3.3s\n",
 			tapename, viotape_unitinfo[i].rsrcname,
@@ -979,7 +977,6 @@
 
 	devfs_remove("iseries/nvt%d", i);
 	devfs_remove("iseries/vt%d", i);
-	devfs_unregister_tape(state[i].dev_handle);
 	class_device_destroy(tape_class, MKDEV(VIOTAPE_MAJOR, i | 0x80));
 	class_device_destroy(tape_class, MKDEV(VIOTAPE_MAJOR, i));
 	return 0;
--- gregkh-2.6.orig/drivers/ide/ide-tape.c	2005-06-10 23:29:08.000000000 -0700
+++ gregkh-2.6/drivers/ide/ide-tape.c	2005-06-10 23:38:18.000000000 -0700
@@ -4707,7 +4707,6 @@
 	drive->driver_data = NULL;
 	devfs_remove("%s/mt", drive->devfs_name);
 	devfs_remove("%s/mtn", drive->devfs_name);
-	devfs_unregister_tape(g->number);
 	idetape_devs[tape->minor] = NULL;
 	g->private_data = NULL;
 	put_disk(g);
@@ -4886,7 +4885,7 @@
 			S_IFCHR | S_IRUGO | S_IWUGO,
 			"%s/mtn", drive->devfs_name);
 
-	g->number = devfs_register_tape(drive->devfs_name);
+	g->number = -1;
 	g->fops = &idetape_block_ops;
 	ide_register_region(g);
 
--- gregkh-2.6.orig/drivers/scsi/osst.c	2005-06-10 23:29:08.000000000 -0700
+++ gregkh-2.6/drivers/scsi/osst.c	2005-06-10 23:38:18.000000000 -0700
@@ -5815,7 +5815,7 @@
 				S_IFCHR | S_IRUGO | S_IWUGO,
 				"%s/ot%sn", SDp->devfs_name, osst_formats[mode]);
 	}
-	drive->number = devfs_register_tape(SDp->devfs_name);
+	drive->number = -1;
 
 	printk(KERN_INFO
 		"osst :I: Attached OnStream %.5s tape at scsi%d, channel %d, id %d, lun %d as %s\n",
@@ -5847,7 +5847,6 @@
 				devfs_remove("%s/ot%s", SDp->devfs_name, osst_formats[mode]);
 				devfs_remove("%s/ot%sn", SDp->devfs_name, osst_formats[mode]);
 			}
-			devfs_unregister_tape(tpnt->drive->number);
 			put_disk(tpnt->drive);
 			os_scsi_tapes[i] = NULL;
 			osst_nr_dev--;

