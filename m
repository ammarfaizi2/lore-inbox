Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262056AbVFUHsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbVFUHsu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 03:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbVFUHs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 03:48:27 -0400
Received: from mail.kroah.org ([69.55.234.183]:45283 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261980AbVFUGaq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 02:30:46 -0400
Cc: gregkh@suse.de
Subject: [PATCH] devfs: Remove devfs_*_tape() functions from the kernel tree
In-Reply-To: <11193354423479@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 23:30:42 -0700
Message-Id: <111933544291@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] devfs: Remove devfs_*_tape() functions from the kernel tree

Removes the devfs_register_tape() and devfs_unregister_tape() functions
and all callers of them.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit c33068e42ebb3b3515fe0e382a0aaeae3009135e
tree 31e5bc4c62ef2e63bc6f4b00b1e4bb205f359543
parent a11119341f9337cda564a7a37ec24749dda092f9
author Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 21:15:16 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 23:13:31 -0700

 drivers/char/viotape.c          |    3 ---
 drivers/ide/ide-tape.c          |    3 +--
 drivers/scsi/osst.c             |    3 +--
 drivers/scsi/st.c               |    3 +--
 include/linux/devfs_fs_kernel.h |    7 -------
 5 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/char/viotape.c b/drivers/char/viotape.c
--- a/drivers/char/viotape.c
+++ b/drivers/char/viotape.c
@@ -247,7 +247,6 @@ static struct device *tape_device[VIOTAP
  */
 static struct {
 	unsigned char	cur_part;
-	int		dev_handle;
 	unsigned char	part_stat_rwi[MAX_PARTITIONS];
 } state[VIOTAPE_MAX_TAPE];
 
@@ -965,7 +964,6 @@ static int viotape_probe(struct vio_dev 
 	devfs_mk_cdev(MKDEV(VIOTAPE_MAJOR, i | 0x80),
 			S_IFCHR | S_IRUSR | S_IWUSR, "iseries/nvt%d", i);
 	sprintf(tapename, "iseries/vt%d", i);
-	state[i].dev_handle = devfs_register_tape(tapename);
 	printk(VIOTAPE_KERN_INFO "tape %s is iSeries "
 			"resource %10.10s type %4.4s, model %3.3s\n",
 			tapename, viotape_unitinfo[i].rsrcname,
@@ -979,7 +977,6 @@ static int viotape_remove(struct vio_dev
 
 	devfs_remove("iseries/nvt%d", i);
 	devfs_remove("iseries/vt%d", i);
-	devfs_unregister_tape(state[i].dev_handle);
 	class_device_destroy(tape_class, MKDEV(VIOTAPE_MAJOR, i | 0x80));
 	class_device_destroy(tape_class, MKDEV(VIOTAPE_MAJOR, i));
 	return 0;
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -4707,7 +4707,6 @@ static void ide_tape_release(struct kref
 	drive->driver_data = NULL;
 	devfs_remove("%s/mt", drive->devfs_name);
 	devfs_remove("%s/mtn", drive->devfs_name);
-	devfs_unregister_tape(g->number);
 	idetape_devs[tape->minor] = NULL;
 	g->private_data = NULL;
 	put_disk(g);
@@ -4886,7 +4885,7 @@ static int ide_tape_probe(struct device 
 			S_IFCHR | S_IRUGO | S_IWUGO,
 			"%s/mtn", drive->devfs_name);
 
-	g->number = devfs_register_tape(drive->devfs_name);
+	g->number = -1;
 	g->fops = &idetape_block_ops;
 	ide_register_region(g);
 
diff --git a/drivers/scsi/osst.c b/drivers/scsi/osst.c
--- a/drivers/scsi/osst.c
+++ b/drivers/scsi/osst.c
@@ -5815,7 +5815,7 @@ static int osst_probe(struct device *dev
 				S_IFCHR | S_IRUGO | S_IWUGO,
 				"%s/ot%sn", SDp->devfs_name, osst_formats[mode]);
 	}
-	drive->number = devfs_register_tape(SDp->devfs_name);
+	drive->number = -1;
 
 	printk(KERN_INFO
 		"osst :I: Attached OnStream %.5s tape at scsi%d, channel %d, id %d, lun %d as %s\n",
@@ -5847,7 +5847,6 @@ static int osst_remove(struct device *de
 				devfs_remove("%s/ot%s", SDp->devfs_name, osst_formats[mode]);
 				devfs_remove("%s/ot%sn", SDp->devfs_name, osst_formats[mode]);
 			}
-			devfs_unregister_tape(tpnt->drive->number);
 			put_disk(tpnt->drive);
 			os_scsi_tapes[i] = NULL;
 			osst_nr_dev--;
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -4004,7 +4004,7 @@ static int st_probe(struct device *dev)
 			      S_IFCHR | S_IRUGO | S_IWUGO,
 			      "%s/mt%sn", SDp->devfs_name, st_formats[i]);
 	}
-	disk->number = devfs_register_tape(SDp->devfs_name);
+	disk->number = -1;
 
 	printk(KERN_WARNING
 	"Attached scsi tape %s at scsi%d, channel %d, id %d, lun %d\n",
@@ -4061,7 +4061,6 @@ static int st_remove(struct device *dev)
 			scsi_tapes[i] = NULL;
 			st_nr_dev--;
 			write_unlock(&st_dev_arr_lock);
-			devfs_unregister_tape(tpnt->disk->number);
 			sysfs_remove_link(&tpnt->device->sdev_gendev.kobj,
 					  "tape");
 			for (mode = 0; mode < ST_NBR_MODES; ++mode) {
diff --git a/include/linux/devfs_fs_kernel.h b/include/linux/devfs_fs_kernel.h
--- a/include/linux/devfs_fs_kernel.h
+++ b/include/linux/devfs_fs_kernel.h
@@ -26,11 +26,4 @@ static inline int devfs_mk_dir(const cha
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

