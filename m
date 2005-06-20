Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbVFUAbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbVFUAbT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 20:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVFUA36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 20:29:58 -0400
Received: from mail.kroah.org ([69.55.234.183]:48612 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261774AbVFTW75 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:57 -0400
Cc: gregkh@suse.de
Subject: [PATCH] class: convert drivers/scsi/* to use the new class api instead of class_simple
In-Reply-To: <11193083631119@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:23 -0700
Message-Id: <11193083632673@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] class: convert drivers/scsi/* to use the new class api instead of class_simple

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit d253878b3d9ae523c76118f5336a662780ad3757
tree 398e59c1d242183269dc8f4a9dd3d7a8057afa16
parent 7e25ab9155aef04e83da69545742cf65c9b801ce
author gregkh@suse.de <gregkh@suse.de> Wed, 23 Mar 2005 09:55:22 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:08 -0700

 drivers/scsi/osst.c |   10 +++++-----
 drivers/scsi/sg.c   |   14 +++++++-------
 drivers/scsi/st.c   |   28 +++++++++++++++-------------
 3 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/drivers/scsi/osst.c b/drivers/scsi/osst.c
--- a/drivers/scsi/osst.c
+++ b/drivers/scsi/osst.c
@@ -5608,13 +5608,13 @@ static ssize_t osst_filemark_cnt_show(st
 
 CLASS_DEVICE_ATTR(file_count, S_IRUGO, osst_filemark_cnt_show, NULL);
 
-static struct class_simple * osst_sysfs_class;
+static struct class *osst_sysfs_class;
 
 static int osst_sysfs_valid = 0;
 
 static void osst_sysfs_init(void)
 {
-	osst_sysfs_class = class_simple_create(THIS_MODULE, "onstream_tape");
+	osst_sysfs_class = class_create(THIS_MODULE, "onstream_tape");
 	if ( IS_ERR(osst_sysfs_class) )
 		printk(KERN_WARNING "osst :W: Unable to register sysfs class\n");
 	else
@@ -5627,7 +5627,7 @@ static void osst_sysfs_add(dev_t dev, st
 
 	if (!osst_sysfs_valid) return;
 
-	osst_class_member = class_simple_device_add(osst_sysfs_class, dev, device, "%s", name);
+	osst_class_member = class_device_create(osst_sysfs_class, dev, device, "%s", name);
 	if (IS_ERR(osst_class_member)) {
 		printk(KERN_WARNING "osst :W: Unable to add sysfs class member %s\n", name);
 		return;
@@ -5645,13 +5645,13 @@ static void osst_sysfs_destroy(dev_t dev
 {
 	if (!osst_sysfs_valid) return; 
 
-	class_simple_device_remove(dev);
+	class_device_destroy(osst_sysfs_class, dev);
 }
 
 static void osst_sysfs_cleanup(void)
 {
 	if (osst_sysfs_valid) {
-		class_simple_destroy(osst_sysfs_class);
+		class_destroy(osst_sysfs_class);
 		osst_sysfs_valid = 0;
 	}
 }
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1430,7 +1430,7 @@ static struct file_operations sg_fops = 
 	.fasync = sg_fasync,
 };
 
-static struct class_simple * sg_sysfs_class;
+static struct class *sg_sysfs_class;
 
 static int sg_sysfs_valid = 0;
 
@@ -1551,13 +1551,13 @@ sg_add(struct class_device *cl_dev)
 	if (sg_sysfs_valid) {
 		struct class_device * sg_class_member;
 
-		sg_class_member = class_simple_device_add(sg_sysfs_class, 
+		sg_class_member = class_device_create(sg_sysfs_class,
 				MKDEV(SCSI_GENERIC_MAJOR, k), 
 				cl_dev->dev, "%s", 
 				disk->disk_name);
 		if (IS_ERR(sg_class_member))
 			printk(KERN_WARNING "sg_add: "
-				"class_simple_device_add failed\n");
+				"class_device_create failed\n");
 		class_set_devdata(sg_class_member, sdp);
 		error = sysfs_create_link(&scsidp->sdev_gendev.kobj, 
 					  &sg_class_member->kobj, "generic");
@@ -1636,7 +1636,7 @@ sg_remove(struct class_device *cl_dev)
 
 	if (sdp) {
 		sysfs_remove_link(&scsidp->sdev_gendev.kobj, "generic");
-		class_simple_device_remove(MKDEV(SCSI_GENERIC_MAJOR, k));
+		class_device_destroy(sg_sysfs_class, MKDEV(SCSI_GENERIC_MAJOR, k));
 		cdev_del(sdp->cdev);
 		sdp->cdev = NULL;
 		devfs_remove("%s/generic", scsidp->devfs_name);
@@ -1677,7 +1677,7 @@ init_sg(void)
 				    SG_MAX_DEVS, "sg");
 	if (rc)
 		return rc;
-        sg_sysfs_class = class_simple_create(THIS_MODULE, "scsi_generic");
+        sg_sysfs_class = class_create(THIS_MODULE, "scsi_generic");
         if ( IS_ERR(sg_sysfs_class) ) {
 		rc = PTR_ERR(sg_sysfs_class);
 		goto err_out;
@@ -1690,7 +1690,7 @@ init_sg(void)
 #endif				/* CONFIG_SCSI_PROC_FS */
 		return 0;
 	}
-	class_simple_destroy(sg_sysfs_class);
+	class_destroy(sg_sysfs_class);
 err_out:
 	unregister_chrdev_region(MKDEV(SCSI_GENERIC_MAJOR, 0), SG_MAX_DEVS);
 	return rc;
@@ -1703,7 +1703,7 @@ exit_sg(void)
 	sg_proc_cleanup();
 #endif				/* CONFIG_SCSI_PROC_FS */
 	scsi_unregister_interface(&sg_interface);
-	class_simple_destroy(sg_sysfs_class);
+	class_destroy(sg_sysfs_class);
 	sg_sysfs_valid = 0;
 	unregister_chrdev_region(MKDEV(SCSI_GENERIC_MAJOR, 0),
 				 SG_MAX_DEVS);
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -84,7 +84,7 @@ static int try_wdio = 1;
 static int st_dev_max;
 static int st_nr_dev;
 
-static struct class_simple *st_sysfs_class;
+static struct class *st_sysfs_class;
 
 MODULE_AUTHOR("Kai Makisara");
 MODULE_DESCRIPTION("SCSI Tape Driver");
@@ -4024,8 +4024,9 @@ out_free_tape:
 			if (STm->cdevs[j]) {
 				if (cdev == STm->cdevs[j])
 					cdev = NULL;
-				class_simple_device_remove(MKDEV(SCSI_TAPE_MAJOR,
-								 TAPE_MINOR(i, mode, j)));
+				class_device_destroy(st_sysfs_class,
+						     MKDEV(SCSI_TAPE_MAJOR,
+							   TAPE_MINOR(i, mode, j)));
 				cdev_del(STm->cdevs[j]);
 			}
 		}
@@ -4068,8 +4069,9 @@ static int st_remove(struct device *dev)
 				devfs_remove("%s/mt%s", SDp->devfs_name, st_formats[j]);
 				devfs_remove("%s/mt%sn", SDp->devfs_name, st_formats[j]);
 				for (j=0; j < 2; j++) {
-					class_simple_device_remove(MKDEV(SCSI_TAPE_MAJOR,
-									 TAPE_MINOR(i, mode, j)));
+					class_device_destroy(st_sysfs_class,
+							     MKDEV(SCSI_TAPE_MAJOR,
+								   TAPE_MINOR(i, mode, j)));
 					cdev_del(tpnt->modes[mode].cdevs[j]);
 					tpnt->modes[mode].cdevs[j] = NULL;
 				}
@@ -4134,7 +4136,7 @@ static int __init init_st(void)
 		"st: Version %s, fixed bufsize %d, s/g segs %d\n",
 		verstr, st_fixed_buffer_size, st_max_sg_segs);
 
-	st_sysfs_class = class_simple_create(THIS_MODULE, "scsi_tape");
+	st_sysfs_class = class_create(THIS_MODULE, "scsi_tape");
 	if (IS_ERR(st_sysfs_class)) {
 		st_sysfs_class = NULL;
 		printk(KERN_ERR "Unable create sysfs class for SCSI tapes\n");
@@ -4148,7 +4150,7 @@ static int __init init_st(void)
 			return 0;
 		}
 		if (st_sysfs_class)
-			class_simple_destroy(st_sysfs_class);		
+			class_destroy(st_sysfs_class);
 		unregister_chrdev_region(MKDEV(SCSI_TAPE_MAJOR, 0),
 
 					 ST_MAX_TAPE_ENTRIES);
@@ -4161,7 +4163,7 @@ static int __init init_st(void)
 static void __exit exit_st(void)
 {
 	if (st_sysfs_class)
-		class_simple_destroy(st_sysfs_class);
+		class_destroy(st_sysfs_class);
 	st_sysfs_class = NULL;
 	do_remove_driverfs_files();
 	scsi_unregister_driver(&st_template.gendrv);
@@ -4284,12 +4286,12 @@ static void do_create_class_files(struct
 		snprintf(name, 10, "%s%s%s", rew ? "n" : "",
 			 STp->disk->disk_name, st_formats[i]);
 		st_class_member =
-			class_simple_device_add(st_sysfs_class,
-						MKDEV(SCSI_TAPE_MAJOR,
-						      TAPE_MINOR(dev_num, mode, rew)),
-						&STp->device->sdev_gendev, "%s", name);
+			class_device_create(st_sysfs_class,
+					    MKDEV(SCSI_TAPE_MAJOR,
+						  TAPE_MINOR(dev_num, mode, rew)),
+					    &STp->device->sdev_gendev, "%s", name);
 		if (IS_ERR(st_class_member)) {
-			printk(KERN_WARNING "st%d: class_simple_device_add failed\n",
+			printk(KERN_WARNING "st%d: class_device_create failed\n",
 			       dev_num);
 			goto out;
 		}

