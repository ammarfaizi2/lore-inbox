Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264409AbTL3EeN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 23:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264405AbTL3EeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 23:34:13 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:28850 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S264409AbTL3Ech (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 23:32:37 -0500
Date: Mon, 29 Dec 2003 16:28:45 -0500
From: Willem Riede <wrlk@riede.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] sysfs support for osst
Message-ID: <20031229212845.GG1277@linnie.riede.org>
Reply-To: wrlk@riede.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since I was told not to port 2.4 style /proc support to 2.6,
here is a patch that provides the attributes through sysfs.

It leverages Greg KH's "simple" class device support.

For each attached drive, a directory with attributes is created:

#ls /sys/class/osst/osst0
ADR_rev  BOT_frame  capacity  dev  device  driver  EOD_frame  file_count  media_version

Let me know if this is appropriate.

Thanks, Willem Riede.

--- drivers/scsi/osst.c-nosysfs	2003-12-23 16:18:32.000000000 -0500
+++ drivers/scsi/osst.c	2003-12-29 15:49:53.814993622 -0500
@@ -16,15 +16,15 @@
   Copyright 1992 - 2002 Kai Makisara / Willem Riede
 	 email Kai.Makisara@metla.fi / osst@riede.org
 
-  $Header: /cvsroot/osst/Driver/osst.c,v 1.70 2003/12/23 14:22:12 wriede Exp $
+  $Header: /cvsroot/osst/Driver/osst.c,v 1.71 2003/12/29 20:49:06 wriede Exp $
 
   Microscopic alterations - Rik Ling, 2000/12/21
   Last st.c sync: Tue Oct 15 22:01:04 2002 by makisara
   Some small formal changes - aeb, 950809
 */
 
-static const char * cvsid = "$Id: osst.c,v 1.70 2003/12/23 14:22:12 wriede Exp $";
-const char * osst_version = "0.99.1";
+static const char * cvsid = "$Id: osst.c,v 1.71 2003/12/29 20:49:06 wriede Exp $";
+const char * osst_version = "0.99.2";
 
 /* The "failure to reconnect" firmware bug */
 #define OSST_FW_NEED_POLL_MIN 10601 /*(107A)*/
@@ -36,6 +36,7 @@
 #include <linux/fs.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/proc_fs.h>
 #include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/string.h>
@@ -46,6 +47,7 @@
 #include <linux/spinlock.h>
 #include <linux/vmalloc.h>
 #include <linux/blkdev.h>
+#include <linux/moduleparam.h>
 #include <linux/devfs_fs_kernel.h>
 #include <asm/uaccess.h>
 #include <asm/dma.h>
@@ -81,13 +83,13 @@
 MODULE_DESCRIPTION("OnStream {DI-|FW-|SC-|USB}{30|50} Tape Driver");
 MODULE_LICENSE("GPL");
 
-MODULE_PARM(max_dev, "i");
+module_param(max_dev, int, 0444);
 MODULE_PARM_DESC(max_dev, "Maximum number of OnStream Tape Drives to attach (4)");
 
-MODULE_PARM(write_threshold_kbs, "i");
+module_param(write_threshold_kbs, int, 0644);
 MODULE_PARM_DESC(write_threshold_kbs, "Asynchronous write threshold (KB; 32)");
 
-MODULE_PARM(max_sg_segs, "i");
+module_param(max_sg_segs, int, 0644);
 MODULE_PARM_DESC(max_sg_segs, "Maximum number of scatter/gather segments to use (9)");
 #else
 static struct osst_dev_parm {
@@ -5419,6 +5421,150 @@
 }
 
 /*
+ * sysfs support for osst driver parameter information
+ */
+
+static ssize_t osst_version_show(struct device_driver *ddd, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%s\n", osst_version);
+}
+
+static DRIVER_ATTR(version, S_IRUGO, osst_version_show, NULL);
+
+static void osst_create_driverfs_files(struct device_driver *driverfs)
+{
+	driver_create_file(driverfs, &driver_attr_version);
+}
+
+static void osst_remove_driverfs_files(struct device_driver *driverfs)
+{
+	driver_remove_file(driverfs, &driver_attr_version);
+}
+
+/*
+ * sysfs support for accessing ADR header information
+ */
+
+static ssize_t osst_adr_rev_show(struct class_device *class_dev, char *buf)
+{
+	OS_Scsi_Tape * STp = (OS_Scsi_Tape *) class_get_devdata (class_dev);
+	ssize_t l = 0;
+
+	if (STp && STp->header_ok && STp->linux_media)
+		l = snprintf(buf, PAGE_SIZE, "%d.%d\n", STp->header_cache->major_rev, STp->header_cache->minor_rev);
+	return l;
+}
+
+CLASS_DEVICE_ATTR(ADR_rev, S_IRUGO, osst_adr_rev_show, NULL);
+
+static ssize_t osst_linux_media_version_show(struct class_device *class_dev, char *buf)
+{
+	OS_Scsi_Tape * STp = (OS_Scsi_Tape *) class_get_devdata (class_dev);
+	ssize_t l = 0;
+
+	if (STp && STp->header_ok && STp->linux_media)
+		l = snprintf(buf, PAGE_SIZE, "LIN%d\n", STp->linux_media_version);
+	return l;
+}
+
+CLASS_DEVICE_ATTR(media_version, S_IRUGO, osst_linux_media_version_show, NULL);
+
+static ssize_t osst_capacity_show(struct class_device *class_dev, char *buf)
+{
+	OS_Scsi_Tape * STp = (OS_Scsi_Tape *) class_get_devdata (class_dev);
+	ssize_t l = 0;
+
+	if (STp && STp->header_ok && STp->linux_media)
+		l = snprintf(buf, PAGE_SIZE, "%d\n", STp->capacity);
+	return l;
+}
+
+CLASS_DEVICE_ATTR(capacity, S_IRUGO, osst_capacity_show, NULL);
+
+static ssize_t osst_first_data_ppos_show(struct class_device *class_dev, char *buf)
+{
+	OS_Scsi_Tape * STp = (OS_Scsi_Tape *) class_get_devdata (class_dev);
+	ssize_t l = 0;
+
+	if (STp && STp->header_ok && STp->linux_media)
+		l = snprintf(buf, PAGE_SIZE, "%d\n", STp->first_data_ppos);
+	return l;
+}
+
+CLASS_DEVICE_ATTR(BOT_frame, S_IRUGO, osst_first_data_ppos_show, NULL);
+
+static ssize_t osst_eod_frame_ppos_show(struct class_device *class_dev, char *buf)
+{
+	OS_Scsi_Tape * STp = (OS_Scsi_Tape *) class_get_devdata (class_dev);
+	ssize_t l = 0;
+
+	if (STp && STp->header_ok && STp->linux_media)
+		l = snprintf(buf, PAGE_SIZE, "%d\n", STp->eod_frame_ppos);
+	return l;
+}
+
+CLASS_DEVICE_ATTR(EOD_frame, S_IRUGO, osst_eod_frame_ppos_show, NULL);
+
+static ssize_t osst_filemark_cnt_show(struct class_device *class_dev, char *buf)
+{
+	OS_Scsi_Tape * STp = (OS_Scsi_Tape *) class_get_devdata (class_dev);
+	ssize_t l = 0;
+
+	if (STp && STp->header_ok && STp->linux_media)
+		l = snprintf(buf, PAGE_SIZE, "%d\n", STp->filemark_cnt);
+	return l;
+}
+
+CLASS_DEVICE_ATTR(file_count, S_IRUGO, osst_filemark_cnt_show, NULL);
+
+static struct class osst_sysfs_class = {
+	.name		= "osst",
+//	.hotplug	= tbd,
+//	.release	= tbd,
+};
+
+static int osst_sysfs_valid = 0;
+
+static void osst_sysfs_init(void)
+{
+	if (class_register(&osst_sysfs_class))
+		printk(KERN_WARNING "osst :W: Unable to register sysfs class\n");
+	else
+		osst_sysfs_valid = TRUE;
+}
+
+static void osst_sysfs_create(dev_t dev, struct device *device, OS_Scsi_Tape * STp, char * name)
+{
+	struct class_device *osst_class_member;
+
+	if (!osst_sysfs_valid) return;
+
+	osst_class_member = simple_add_class_device(&osst_sysfs_class, dev, device, "%s", name);
+	class_set_devdata(osst_class_member, STp);
+	class_device_create_file(osst_class_member, &class_device_attr_ADR_rev);
+	class_device_create_file(osst_class_member, &class_device_attr_media_version);
+	class_device_create_file(osst_class_member, &class_device_attr_capacity);
+	class_device_create_file(osst_class_member, &class_device_attr_BOT_frame);
+	class_device_create_file(osst_class_member, &class_device_attr_EOD_frame);
+	class_device_create_file(osst_class_member, &class_device_attr_file_count);
+}
+
+static void osst_sysfs_destroy(dev_t dev)
+{
+	if (!osst_sysfs_valid) return; 
+
+	simple_remove_class_device(dev);
+}
+
+static void osst_sysfs_cleanup(void)
+{
+	if (osst_sysfs_valid) {
+		class_unregister(&osst_sysfs_class);
+		osst_sysfs_valid = 0;
+	}
+}
+
+/*
  * osst startup / cleanup code
  */
 
@@ -5572,6 +5718,8 @@
 	}
 	drive->number = devfs_register_tape(SDp->devfs_name);
 
+	osst_sysfs_create(MKDEV(OSST_MAJOR, dev_num), dev, tpnt, tape_name(tpnt));
+
 	printk(KERN_INFO
 		"osst :I: Attached OnStream %.5s tape at scsi%d, channel %d, id %d, lun %d as %s\n",
 		SDp->model, SDp->host->host_no, SDp->channel, SDp->id, SDp->lun, tape_name(tpnt));
@@ -5595,6 +5743,7 @@
 	write_lock(&os_scsi_tapes_lock);
 	for(i=0; i < osst_max_dev; i++) {
 		if((tpnt = os_scsi_tapes[i]) && (tpnt->device == SDp)) {
+			osst_sysfs_destroy(MKDEV(OSST_MAJOR, i));
 			tpnt->device = NULL;
 			for (mode = 0; mode < ST_NBR_MODES; ++mode) {
 				devfs_remove("%s/ot%s", SDp->devfs_name, osst_formats[mode]);
@@ -5623,11 +5772,14 @@
 	printk(KERN_INFO "osst :I: Tape driver with OnStream support version %s\nosst :I: %s\n", osst_version, cvsid);
 
 	validate_options();
-	
+	osst_sysfs_init();
+
 	if ((register_chrdev(OSST_MAJOR,"osst", &osst_fops) < 0) || scsi_register_driver(&osst_template.gendrv)) {
 		printk(KERN_ERR "osst :E: Unable to register major %d for OnStream tapes\n", OSST_MAJOR);
+		osst_sysfs_cleanup();
 		return 1;
 	}
+	osst_create_driverfs_files(&osst_template.gendrv);
 
 	return 0;
 }
@@ -5637,8 +5789,10 @@
 	int i;
 	OS_Scsi_Tape * STp;
 
+	osst_remove_driverfs_files(&osst_template.gendrv);
 	scsi_unregister_driver(&osst_template.gendrv);
 	unregister_chrdev(OSST_MAJOR, "osst");
+	osst_sysfs_cleanup();
 
 	if (os_scsi_tapes) {
 		for (i=0; i < osst_max_dev; ++i) {

