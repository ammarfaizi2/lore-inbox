Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262305AbUBXRM4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 12:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262320AbUBXRMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 12:12:23 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:22975 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262315AbUBXRJK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 12:09:10 -0500
Subject: Re: [BK PATCH] SCSI update for 2.6.3
From: James Bottomley <James.Bottomley@steeleye.com>
To: Greg KH <greg@kroah.com>
Cc: Kai Makisara <Kai.Makisara@metla.fi>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, kai.makisara@kolumbus.fi
In-Reply-To: <20040224170412.GA31268@kroah.com>
References: <Pine.LNX.4.58.0402240919490.1129@spektro.metla.fi> 
	<20040224170412.GA31268@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 24 Feb 2004 11:08:48 -0600
Message-Id: <1077642529.1804.170.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-02-24 at 11:04, Greg KH wrote:
> Can you post it here so we can review it?
> 
> And yes, using class_simple should relieve you of Al flamage :)

The one in the tree is attached.  I did verify it myself, and tried it
out on some old QIC tapes I had lying around.

James

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1574  -> 1.1575 
#	Documentation/scsi/st.txt	1.12    -> 1.13   
#	   drivers/scsi/st.c	1.77    -> 1.78   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/02/22	Kai.Makisara@kolumbus.fi	1.1575
# [PATCH] Sysfs class support for SCSI tapes
# 
# This is a new version of the patch I sent two weeks ago. The code is the
# same but now diffed against 2.6.3. Some documentation has been added.
# Creation and removal of the st device files has been tested with
# udev-018.
# 
# The patch adds support for /sys/class/scsi_tape. It also removes the links
# to/from the st files in /sys/cdev/major.
# 
# A file is created for each mode and rewind/non-rewind device for each
# tape drive. Here is an example for one drive:
# > ls /sys/class/scsi_tape/
# st0m0  st0m0n  st0m1  st0m1n  st0m2  st0m2n  st0m3  st0m3n
# 
# In addition to the automatic links (dev, driver), each directory contains
# files that export some of the mode parameters:
# > ls /sys/class/scsi_tape/st0m0
# default_blksize      default_density  dev     driver
# default_compression  defined          device
# 
# A link is made from the SCSI device directory back to the mode 0
# auto-rewind class file:
# > ls -l
# /sys/devices/pci0000:00/0000:00:1e.0/0000:02:01.1/host1/1:0:5:0/tape
# lrwxrwxrwx    1 root     root           39 2004-02-05 23:14
# /sys/devices/pci0000:00/0000:00:1e.0/0000:02:01.1/host1/1:0:5:0/tape ->
# ../../../../../../class/scsi_tape/st0m0
# --------------------------------------------
#
diff -Nru a/Documentation/scsi/st.txt b/Documentation/scsi/st.txt
--- a/Documentation/scsi/st.txt	Tue Feb 24 11:07:42 2004
+++ b/Documentation/scsi/st.txt	Tue Feb 24 11:07:42 2004
@@ -2,7 +2,7 @@
 The driver is currently maintained by Kai Mäkisara (email
 Kai.Makisara@kolumbus.fi)
 
-Last modified: Sun Nov  9 22:36:02 2003 by makisara
+Last modified: Thu Feb 19 21:57:30 2004 by makisara
 

 BASICS
@@ -113,6 +113,26 @@
 only 8 bits wide.
 

+SYSFS SUPPORT
+
+The driver creates the directory /sys/class/scsi_tape and populates it with
+directories corresponding to the existing tape devices. There are autorewind
+and non-rewind entries for each mode. The names are stxmy and stxmyn, where x
+is the tape number and y is the mode. For example, the directories for the
+first tape device are (assuming four modes): st0m0  st0m0n  st0m1  st0m1n
+st0m2  st0m2n  st0m3  st0m3n.
+
+Each directory contains the entries: default_blksize  default_compression
+default_density  defined  dev  device  driver. The file 'defined' contains 1
+if the mode is defined and zero if not defined. The files 'default_*' contain
+the defaults set by the user. The value -1 means the default is not set. The
+file 'dev' contains the device numbers corresponding to this device. The links
+'device' and 'driver' point to the SCSI device and driver entries.
+
+A link named 'tape' is made from the SCSI device directory to the class
+directory corresponding to the mode 0 auto-rewind device (e.g., st0m0). 
+
+
 BSD AND SYS V SEMANTICS
 
 The user can choose between these two behaviours of the tape driver by
@@ -126,7 +146,7 @@
 
 BUFFERING
 
-The driver tries to do tranfers directly to/from user space. If this
+The driver tries to do transfers directly to/from user space. If this
 is not possible, a driver buffer allocated at run-time is used. If
 direct i/o is not possible for the whole transfer, the driver buffer
 is used (i.e., bounce buffers for individual pages are not
@@ -147,6 +167,12 @@
 size). Because of this the actual buffer size may be larger than the
 minimum allowable buffer size.
 
+NOTE that if direct i/o is used, the small writes are not buffered. This may
+cause a surprise when moving from 2.4. There small writes (e.g., tar without
+-b option) may have had good throughput but this is not true any more with
+2.6. Direct i/o can be turned off to solve this problem but a better solution
+is to use bigger write() byte counts (e.g., tar -b 64).
+
 Asynchronous writing. Writing the buffer contents to the tape is
 started and the write call returns immediately. The status is checked
 at the next tape operation. Asynchronous writes are not done with
@@ -453,7 +479,7 @@
 
 To enable debugging messages, edit st.c and #define DEBUG 1. As seen
 above, debugging can be switched off with an ioctl if debugging is
-compiled into the driver. The debugging output is not voluminuous.
+compiled into the driver. The debugging output is not voluminous.
 
 If the tape seems to hang, I would be very interested to hear where
 the driver is waiting. With the command 'ps -l' you can see the state
diff -Nru a/drivers/scsi/st.c b/drivers/scsi/st.c
--- a/drivers/scsi/st.c	Tue Feb 24 11:07:42 2004
+++ b/drivers/scsi/st.c	Tue Feb 24 11:07:42 2004
@@ -17,7 +17,7 @@
    Last modified: 18-JAN-1998 Richard Gooch <rgooch@atnf.csiro.au> Devfs support
  */
 
-static char *verstr = "20040122";
+static char *verstr = "20040213";
 
 #include <linux/module.h>
 
@@ -77,6 +77,8 @@
 static int st_dev_max;
 static int st_nr_dev;
 
+static struct class_simple *st_sysfs_class;
+
 MODULE_AUTHOR("Kai Makisara");
 MODULE_DESCRIPTION("SCSI Tape Driver");
 MODULE_LICENSE("GPL");
@@ -183,7 +185,7 @@
 
 static void do_create_driverfs_files(void);
 static void do_remove_driverfs_files(void);
-
+static void do_create_class_files(Scsi_Tape *, int, int);
 
 static struct scsi_driver st_template = {
 	.owner			= THIS_MODULE,
@@ -3902,20 +3904,8 @@
 			}
 			STm->cdevs[j] = cdev;
 
-			error = sysfs_create_link(&STm->cdevs[j]->kobj, &SDp->sdev_gendev.kobj,
-						  "device");
-			if (error) {
-				printk(KERN_ERR
-				       "st%d: Can't create sysfs link from SCSI device.\n",
-				       dev_num);
-			}
 		}
-	}
-	error = sysfs_create_link(&SDp->sdev_gendev.kobj, &tpnt->modes[0].cdevs[0]->kobj,
-				  "tape");
-	if (error) {
-		printk(KERN_ERR "st%d: Can't create sysfs link from SCSI device.\n",
-		       dev_num);
+		do_create_class_files(tpnt, dev_num, mode);
 	}
 
 	for (mode = 0; mode < ST_NBR_MODES; ++mode) {
@@ -3941,11 +3931,14 @@
 out_free_tape:
 	for (mode=0; mode < ST_NBR_MODES; mode++) {
 		STm = &(tpnt->modes[mode]);
+		sysfs_remove_link(&tpnt->device->sdev_gendev.kobj,
+				  "tape");
 		for (j=0; j < 2; j++) {
 			if (STm->cdevs[j]) {
 				if (cdev == STm->cdevs[j])
 					cdev = NULL;
-				sysfs_remove_link(&STm->cdevs[j]->kobj, "device");
+				class_simple_device_remove(MKDEV(SCSI_TAPE_MAJOR,
+								 TAPE_MINOR(i, mode, j)));
 				cdev_del(STm->cdevs[j]);
 			}
 		}
@@ -3981,13 +3974,14 @@
 			st_nr_dev--;
 			write_unlock(&st_dev_arr_lock);
 			devfs_unregister_tape(tpnt->disk->number);
-			sysfs_remove_link(&SDp->sdev_gendev.kobj, "tape");
+			sysfs_remove_link(&tpnt->device->sdev_gendev.kobj,
+					  "tape");
 			for (mode = 0; mode < ST_NBR_MODES; ++mode) {
 				devfs_remove("%s/mt%s", SDp->devfs_name, st_formats[mode]);
 				devfs_remove("%s/mt%sn", SDp->devfs_name, st_formats[mode]);
 				for (j=0; j < 2; j++) {
-					sysfs_remove_link(&tpnt->modes[mode].cdevs[j]->kobj,
-							  "device");
+					class_simple_device_remove(MKDEV(SCSI_TAPE_MAJOR,
+									 TAPE_MINOR(i, mode, j)));
 					cdev_del(tpnt->modes[mode].cdevs[j]);
 					tpnt->modes[mode].cdevs[j] = NULL;
 				}
@@ -4052,13 +4046,23 @@
 		"st: Version %s, fixed bufsize %d, s/g segs %d\n",
 		verstr, st_fixed_buffer_size, st_max_sg_segs);
 
+	st_sysfs_class = class_simple_create(THIS_MODULE, "scsi_tape");
+	if (IS_ERR(st_sysfs_class)) {
+		st_sysfs_class = NULL;
+		printk(KERN_ERR "Unable create sysfs class for SCSI tapes\n");
+		return 1;
+	}
+
 	if (!register_chrdev_region(MKDEV(SCSI_TAPE_MAJOR, 0),
 				    ST_MAX_TAPE_ENTRIES, "st")) {
 		if (scsi_register_driver(&st_template.gendrv) == 0) {
 			do_create_driverfs_files();
 			return 0;
 		}
+		if (st_sysfs_class)
+			class_simple_destroy(st_sysfs_class);		
 		unregister_chrdev_region(MKDEV(SCSI_TAPE_MAJOR, 0),
+
 					 ST_MAX_TAPE_ENTRIES);
 	}
 
@@ -4068,6 +4072,9 @@
 
 static void __exit exit_st(void)
 {
+	if (st_sysfs_class)
+		class_simple_destroy(st_sysfs_class);
+	st_sysfs_class = NULL;
 	do_remove_driverfs_files();
 	scsi_unregister_driver(&st_template.gendrv);
 	unregister_chrdev_region(MKDEV(SCSI_TAPE_MAJOR, 0),
@@ -4080,7 +4087,7 @@
 module_exit(exit_st);
 

-/* The sysfs interface. Read-only at the moment */
+/* The sysfs driver interface. Read-only at the moment */
 static ssize_t st_try_direct_io_show(struct device_driver *ddp, char *buf)
 {
 	return snprintf(buf, PAGE_SIZE, "%d\n", try_direct_io);
@@ -4123,6 +4130,99 @@
 	driver_remove_file(driverfs, &driver_attr_max_sg_segs);
 	driver_remove_file(driverfs, &driver_attr_fixed_buffer_size);
 	driver_remove_file(driverfs, &driver_attr_try_direct_io);
+}
+
+
+/* The sysfs simple class interface */
+static ssize_t st_defined_show(struct class_device *class_dev, char *buf)
+{
+	ST_mode *STm = (ST_mode *)class_get_devdata(class_dev);
+	ssize_t l = 0;
+
+	l = snprintf(buf, PAGE_SIZE, "%d\n", STm->defined);
+	return l;
+}
+
+CLASS_DEVICE_ATTR(defined, S_IRUGO, st_defined_show, NULL);
+
+static ssize_t st_defblk_show(struct class_device *class_dev, char *buf)
+{
+	ST_mode *STm = (ST_mode *)class_get_devdata(class_dev);
+	ssize_t l = 0;
+
+	l = snprintf(buf, PAGE_SIZE, "%d\n", STm->default_blksize);
+	return l;
+}
+
+CLASS_DEVICE_ATTR(default_blksize, S_IRUGO, st_defblk_show, NULL);
+
+static ssize_t st_defdensity_show(struct class_device *class_dev, char *buf)
+{
+	ST_mode *STm = (ST_mode *)class_get_devdata(class_dev);
+	ssize_t l = 0;
+	char *fmt;
+
+	fmt = STm->default_density >= 0 ? "0x%02x\n" : "%d\n";
+	l = snprintf(buf, PAGE_SIZE, fmt, STm->default_density);
+	return l;
+}
+
+CLASS_DEVICE_ATTR(default_density, S_IRUGO, st_defdensity_show, NULL);
+
+static ssize_t st_defcompression_show(struct class_device *class_dev, char *buf)
+{
+	ST_mode *STm = (ST_mode *)class_get_devdata(class_dev);
+	ssize_t l = 0;
+
+	l = snprintf(buf, PAGE_SIZE, "%d\n", STm->default_compression - 1);
+	return l;
+}
+
+CLASS_DEVICE_ATTR(default_compression, S_IRUGO, st_defcompression_show, NULL);
+
+static void do_create_class_files(Scsi_Tape *STp, int dev_num, int mode)
+{
+	int rew, error;
+	struct class_device *st_class_member;
+
+	if (!st_sysfs_class)
+		return;
+
+	for (rew=0; rew < 2; rew++) {
+		st_class_member =
+			class_simple_device_add(st_sysfs_class,
+						MKDEV(SCSI_TAPE_MAJOR,
+						      TAPE_MINOR(dev_num, mode, rew)),
+						&STp->device->sdev_gendev, "%s",
+						STp->modes[mode].cdevs[rew]->kobj.name);
+		if (!st_class_member) {
+			printk(KERN_WARNING "st%d: class_simple_device_add failed\n",
+			       dev_num);
+			goto out;
+		}
+		class_set_devdata(st_class_member, &STp->modes[mode]);
+
+		class_device_create_file(st_class_member,
+					 &class_device_attr_defined);
+		class_device_create_file(st_class_member,
+					 &class_device_attr_default_blksize);
+		class_device_create_file(st_class_member,
+					 &class_device_attr_default_density);
+		class_device_create_file(st_class_member,
+					 &class_device_attr_default_compression);
+		if (mode == 0 && rew == 0) {
+			error = sysfs_create_link(&STp->device->sdev_gendev.kobj,
+						  &st_class_member->kobj,
+						  "tape");
+			if (error) {
+				printk(KERN_ERR
+				       "st%d: Can't create sysfs link from SCSI device.\n",
+				       dev_num);
+			}
+		}
+	}
+ out:
+	return;
 }
 


