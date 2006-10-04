Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161202AbWJDKAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161202AbWJDKAk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 06:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161200AbWJDKAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 06:00:40 -0400
Received: from havoc.gtf.org ([69.61.125.42]:18823 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1161199AbWJDKAj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 06:00:39 -0400
Date: Wed, 4 Oct 2006 06:00:38 -0400
From: Jeff Garzik <jeff@garzik.org>
To: linux-scsi@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] SCSI st: fix error handling in module init, sysfs
Message-ID: <20061004100037.GA16915@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- Notice and handle sysfs errors in module init, tape init

- Properly unwind errors in module init

- Remove bogus st_sysfs_class==NULL test, it is guaranteed !NULL at that point

Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/scsi/st.c |  115 ++++++++++++++++++++++++++++++++++++------------------
 1 files changed, 78 insertions(+), 37 deletions(-)

diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 7f669b6..3babdc7 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -195,9 +195,9 @@ static int sgl_unmap_user_pages(struct s
 static int st_probe(struct device *);
 static int st_remove(struct device *);
 
-static void do_create_driverfs_files(void);
+static int do_create_driverfs_files(void);
 static void do_remove_driverfs_files(void);
-static void do_create_class_files(struct scsi_tape *, int, int);
+static int do_create_class_files(struct scsi_tape *, int, int);
 
 static struct scsi_driver st_template = {
 	.owner			= THIS_MODULE,
@@ -4048,7 +4048,9 @@ static int st_probe(struct device *dev)
 			STm->cdevs[j] = cdev;
 
 		}
-		do_create_class_files(tpnt, dev_num, mode);
+		error = do_create_class_files(tpnt, dev_num, mode);
+		if (error)
+			goto out_free_tape;
 	}
 
 	sdev_printk(KERN_WARNING, SDp,
@@ -4157,32 +4159,45 @@ static void scsi_tape_release(struct kre
 
 static int __init init_st(void)
 {
+	int err;
+
 	validate_options();
 
-	printk(KERN_INFO
-		"st: Version %s, fixed bufsize %d, s/g segs %d\n",
+	printk(KERN_INFO "st: Version %s, fixed bufsize %d, s/g segs %d\n",
 		verstr, st_fixed_buffer_size, st_max_sg_segs);
 
 	st_sysfs_class = class_create(THIS_MODULE, "scsi_tape");
 	if (IS_ERR(st_sysfs_class)) {
-		st_sysfs_class = NULL;
 		printk(KERN_ERR "Unable create sysfs class for SCSI tapes\n");
-		return 1;
+		return PTR_ERR(st_sysfs_class);
 	}
 
-	if (!register_chrdev_region(MKDEV(SCSI_TAPE_MAJOR, 0),
-				    ST_MAX_TAPE_ENTRIES, "st")) {
-		if (scsi_register_driver(&st_template.gendrv) == 0) {
-			do_create_driverfs_files();
-			return 0;
-		}
-		unregister_chrdev_region(MKDEV(SCSI_TAPE_MAJOR, 0),
-					 ST_MAX_TAPE_ENTRIES);
+	err = register_chrdev_region(MKDEV(SCSI_TAPE_MAJOR, 0),
+				     ST_MAX_TAPE_ENTRIES, "st");
+	if (err) {
+		printk(KERN_ERR "Unable to get major %d for SCSI tapes\n",
+		       SCSI_TAPE_MAJOR);
+		goto err_class;
 	}
-	class_destroy(st_sysfs_class);
 
-	printk(KERN_ERR "Unable to get major %d for SCSI tapes\n", SCSI_TAPE_MAJOR);
-	return 1;
+	err = scsi_register_driver(&st_template.gendrv);
+	if (err)
+		goto err_chrdev;
+
+	err = do_create_driverfs_files();
+	if (err)
+		goto err_scsidrv;
+
+	return 0;
+
+err_scsidrv:
+	scsi_unregister_driver(&st_template.gendrv);
+err_chrdev:
+	unregister_chrdev_region(MKDEV(SCSI_TAPE_MAJOR, 0),
+				 ST_MAX_TAPE_ENTRIES);
+err_class:
+	class_destroy(st_sysfs_class);
+	return err;
 }
 
 static void __exit exit_st(void)
@@ -4225,14 +4240,33 @@ static ssize_t st_version_show(struct de
 }
 static DRIVER_ATTR(version, S_IRUGO, st_version_show, NULL);
 
-static void do_create_driverfs_files(void)
+static int do_create_driverfs_files(void)
 {
 	struct device_driver *driverfs = &st_template.gendrv;
+	int err;
+
+	err = driver_create_file(driverfs, &driver_attr_try_direct_io);
+	if (err)
+		return err;
+	err = driver_create_file(driverfs, &driver_attr_fixed_buffer_size);
+	if (err)
+		goto err_try_direct_io;
+	err = driver_create_file(driverfs, &driver_attr_max_sg_segs);
+	if (err)
+		goto err_attr_fixed_buf;
+	err = driver_create_file(driverfs, &driver_attr_version);
+	if (err)
+		goto err_attr_max_sg;
 
-	driver_create_file(driverfs, &driver_attr_try_direct_io);
-	driver_create_file(driverfs, &driver_attr_fixed_buffer_size);
-	driver_create_file(driverfs, &driver_attr_max_sg_segs);
-	driver_create_file(driverfs, &driver_attr_version);
+	return 0;
+
+err_attr_max_sg:
+	driver_remove_file(driverfs, &driver_attr_max_sg_segs);
+err_attr_fixed_buf:
+	driver_remove_file(driverfs, &driver_attr_fixed_buffer_size);
+err_try_direct_io:
+	driver_remove_file(driverfs, &driver_attr_try_direct_io);
+	return err;
 }
 
 static void do_remove_driverfs_files(void)
@@ -4293,15 +4327,12 @@ static ssize_t st_defcompression_show(st
 
 CLASS_DEVICE_ATTR(default_compression, S_IRUGO, st_defcompression_show, NULL);
 
-static void do_create_class_files(struct scsi_tape *STp, int dev_num, int mode)
+static int do_create_class_files(struct scsi_tape *STp, int dev_num, int mode)
 {
 	int i, rew, error;
 	char name[10];
 	struct class_device *st_class_member;
 
-	if (!st_sysfs_class)
-		return;
-
 	for (rew=0; rew < 2; rew++) {
 		/* Make sure that the minor numbers corresponding to the four
 		   first modes always get the same names */
@@ -4316,18 +4347,24 @@ static void do_create_class_files(struct
 		if (IS_ERR(st_class_member)) {
 			printk(KERN_WARNING "st%d: class_device_create failed\n",
 			       dev_num);
+			error = PTR_ERR(st_class_member);
 			goto out;
 		}
 		class_set_devdata(st_class_member, &STp->modes[mode]);
 
-		class_device_create_file(st_class_member,
-					 &class_device_attr_defined);
-		class_device_create_file(st_class_member,
-					 &class_device_attr_default_blksize);
-		class_device_create_file(st_class_member,
-					 &class_device_attr_default_density);
-		class_device_create_file(st_class_member,
-					 &class_device_attr_default_compression);
+		error = class_device_create_file(st_class_member,
+					       &class_device_attr_defined);
+		if (error) goto out;
+		error = class_device_create_file(st_class_member,
+					    &class_device_attr_default_blksize);
+		if (error) goto out;
+		error = class_device_create_file(st_class_member,
+					    &class_device_attr_default_density);
+		if (error) goto out;
+		error = class_device_create_file(st_class_member,
+				        &class_device_attr_default_compression);
+		if (error) goto out;
+
 		if (mode == 0 && rew == 0) {
 			error = sysfs_create_link(&STp->device->sdev_gendev.kobj,
 						  &st_class_member->kobj,
@@ -4336,11 +4373,15 @@ static void do_create_class_files(struct
 				printk(KERN_ERR
 				       "st%d: Can't create sysfs link from SCSI device.\n",
 				       dev_num);
+				goto out;
 			}
 		}
 	}
- out:
-	return;
+
+	return 0;
+
+out:
+	return error;
 }
 
 /* The following functions may be useful for a larger audience. */
