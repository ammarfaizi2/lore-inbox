Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVABNqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVABNqi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 08:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVABNqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 08:46:36 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:12979 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261253AbVABNqY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 08:46:24 -0500
Date: Sun, 02 Jan 2005 13:46:17 +0000
From: Willem Riede <wriede@riede.org>
Subject: [PATCH 3/3] osst upgrade to 0.99.3 [osst@riede.org]
To: linux-kernel@vger.kernel.org
References: <1104627599l.3427l.4l@serve.riede.org>
In-Reply-To: <1104627599l.3427l.4l@serve.riede.org> (from osst@riede.org on
	Sat Jan  1 19:59:59 2005)
X-Mailer: Balsa 2.2.6
Message-Id: <1104673577l.3427l.7l@serve.riede.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Sending again as it doesn't seem to have made it here the first time...)
On 01/01/2005 07:59:59 PM, Willem Riede wrote:

Here is patch 3 (see previous mail for context), providing osst sysfs support.

signed-off-by: Willem Riede <osst@riede.org>

--- osst-patches/osst.c	2005-01-01 19:27:15.000000000 -0500
+++ /home/wriede/SfOsstCVS/Driver26/osst.c	2005-01-01 16:13:34.000000000 -0500
@@ -13,18 +13,18 @@
   order) Klaus Ehrenfried, Wolfgang Denk, Steve Hirsch, Andreas Koppenh"ofer,
   Michael Leodolter, Eyal Lebedinsky, J"org Weule, and Eric Youngdale.
 
-  Copyright 1992 - 2002 Kai Makisara / Willem Riede
-	 email Kai.Makisara@metla.fi / osst@riede.org
+  Copyright 1992 - 2002 Kai Makisara / 2000 - 2004 Willem Riede
+	 email osst@riede.org
 
-  $Header: /cvsroot/osst/Driver/osst.c,v 1.70 2003/12/23 14:22:12 wriede Exp $
+  $Header: /cvsroot/osst/Driver/osst.c,v 1.73 2005/01/01 21:13:34 wriede Exp $
 
   Microscopic alterations - Rik Ling, 2000/12/21
   Last st.c sync: Tue Oct 15 22:01:04 2002 by makisara
   Some small formal changes - aeb, 950809
 */
 
-static const char * cvsid = "$Id: osst.c,v 1.70 2003/12/23 14:22:12 wriede Exp $";
-const char * osst_version = "0.99.1";
+static const char * cvsid = "$Id: osst.c,v 1.73 2005/01/01 21:13:34 wriede Exp $";
+const char * osst_version = "0.99.3";
 
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
@@ -5485,6 +5486,151 @@
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
+	struct osst_tape * STp = (struct osst_tape *) class_get_devdata (class_dev);
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
+	struct osst_tape * STp = (struct osst_tape *) class_get_devdata (class_dev);
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
+	struct osst_tape * STp = (struct osst_tape *) class_get_devdata (class_dev);
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
+	struct osst_tape * STp = (struct osst_tape *) class_get_devdata (class_dev);
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
+	struct osst_tape * STp = (struct osst_tape *) class_get_devdata (class_dev);
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
+	struct osst_tape * STp = (struct osst_tape *) class_get_devdata (class_dev);
+	ssize_t l = 0;
+
+	if (STp && STp->header_ok && STp->linux_media)
+		l = snprintf(buf, PAGE_SIZE, "%d\n", STp->filemark_cnt);
+	return l;
+}
+
+CLASS_DEVICE_ATTR(file_count, S_IRUGO, osst_filemark_cnt_show, NULL);
+
+static struct class_simple * osst_sysfs_class;
+
+static int osst_sysfs_valid = 0;
+
+static void osst_sysfs_init(void)
+{
+	osst_sysfs_class = class_simple_create(THIS_MODULE, "onstream_tape");
+	if ( IS_ERR(osst_sysfs_class) )
+		printk(KERN_WARNING "osst :W: Unable to register sysfs class\n");
+	else
+		osst_sysfs_valid = TRUE;
+}
+
+static void osst_sysfs_add(dev_t dev, struct device *device, struct osst_tape * STp, char * name)
+{
+	struct class_device *osst_class_member;
+
+	if (!osst_sysfs_valid) return;
+
+	osst_class_member = class_simple_device_add(osst_sysfs_class, dev, device, "%s", name);
+	if (IS_ERR(osst_class_member)) {
+		printk(KERN_WARNING "osst :W: Unable to add sysfs class member %s\n", name);
+		return;
+	}
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
+	class_simple_device_remove(dev);
+}
+
+static void osst_sysfs_cleanup(void)
+{
+	if (osst_sysfs_valid) {
+		class_simple_destroy(osst_sysfs_class);
+		osst_sysfs_valid = 0;
+	}
+}
+
+/*
  * osst startup / cleanup code
  */
 
@@ -5624,7 +5770,14 @@
 	init_MUTEX(&tpnt->lock);
 	osst_nr_dev++;
 	write_unlock(&os_scsi_tapes_lock);
-
+	{
+		char name[8];
+		/*  Rewind entry  */
+		osst_sysfs_add(MKDEV(OSST_MAJOR, dev_num), dev, tpnt, tape_name(tpnt));
+		/*  No-rewind entry  */
+		snprintf(name, 8, "%s%s", "n", tape_name(tpnt));
+		osst_sysfs_add(MKDEV(OSST_MAJOR, dev_num + 128), dev, tpnt, name);
+	}
 	for (mode = 0; mode < ST_NBR_MODES; ++mode) {
 		/*  Rewind entry  */
 		devfs_mk_cdev(MKDEV(OSST_MAJOR, dev_num + (mode << 5)),
@@ -5661,6 +5814,8 @@
 	write_lock(&os_scsi_tapes_lock);
 	for(i=0; i < osst_max_dev; i++) {
 		if((tpnt = os_scsi_tapes[i]) && (tpnt->device == SDp)) {
+			osst_sysfs_destroy(MKDEV(OSST_MAJOR, i));
+			osst_sysfs_destroy(MKDEV(OSST_MAJOR, i+128));
 			tpnt->device = NULL;
 			for (mode = 0; mode < ST_NBR_MODES; ++mode) {
 				devfs_remove("%s/ot%s", SDp->devfs_name, osst_formats[mode]);
@@ -5689,11 +5844,14 @@
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
@@ -5703,8 +5861,10 @@
 	int i;
 	struct osst_tape * STp;
 
+	osst_remove_driverfs_files(&osst_template.gendrv);
 	scsi_unregister_driver(&osst_template.gendrv);
 	unregister_chrdev(OSST_MAJOR, "osst");
+	osst_sysfs_cleanup();
 
 	if (os_scsi_tapes) {
 		for (i=0; i < osst_max_dev; ++i) {




