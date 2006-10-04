Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161186AbWJDJXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161186AbWJDJXM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 05:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161180AbWJDJXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 05:23:12 -0400
Received: from havoc.gtf.org ([69.61.125.42]:41350 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1030770AbWJDJXJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 05:23:09 -0400
Date: Wed, 4 Oct 2006 05:23:04 -0400
From: Jeff Garzik <jeff@garzik.org>
To: linux-scsi@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] SCSI osst: add error handling to module init, sysfs
Message-ID: <20061004092304.GA14685@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- check all sysfs-related return codes, and propagate them back to callers

- properly unwind errors in osst_probe(), init_osst().  This fixes a
  leak that occured if scsi driver registration failed, and fixes an
  oops if sysfs creation returned an error.

(unrelated)
- kzalloc() cleanup in new_tape_buf()

Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/scsi/osst.c |  131 ++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 91 insertions(+), 40 deletions(-)

diff --git a/drivers/scsi/osst.c b/drivers/scsi/osst.c
index 4a2fed3..4b2845e 100644
--- a/drivers/scsi/osst.c
+++ b/drivers/scsi/osst.c
@@ -5207,12 +5207,12 @@ static struct osst_buffer * new_tape_buf
 		priority = GFP_KERNEL;
 
 	i = sizeof(struct osst_buffer) + (osst_max_sg_segs - 1) * sizeof(struct scatterlist);
-	tb = (struct osst_buffer *)kmalloc(i, priority);
+	tb = kzalloc(i, priority);
 	if (!tb) {
 		printk(KERN_NOTICE "osst :I: Can't allocate new tape buffer.\n");
 		return NULL;
 	}
-	memset(tb, 0, i);
+
 	tb->sg_segs = tb->orig_sg_segs = 0;
 	tb->use_sg = max_sg;
 	tb->in_use = 1;
@@ -5575,9 +5575,9 @@ static ssize_t osst_version_show(struct 
 
 static DRIVER_ATTR(version, S_IRUGO, osst_version_show, NULL);
 
-static void osst_create_driverfs_files(struct device_driver *driverfs)
+static int osst_create_driverfs_files(struct device_driver *driverfs)
 {
-	driver_create_file(driverfs, &driver_attr_version);
+	return driver_create_file(driverfs, &driver_attr_version);
 }
 
 static void osst_remove_driverfs_files(struct device_driver *driverfs)
@@ -5663,50 +5663,70 @@ CLASS_DEVICE_ATTR(file_count, S_IRUGO, o
 
 static struct class *osst_sysfs_class;
 
-static int osst_sysfs_valid = 0;
-
-static void osst_sysfs_init(void)
+static int osst_sysfs_init(void)
 {
 	osst_sysfs_class = class_create(THIS_MODULE, "onstream_tape");
-	if ( IS_ERR(osst_sysfs_class) )
-		printk(KERN_WARNING "osst :W: Unable to register sysfs class\n");
-	else
-		osst_sysfs_valid = 1;
+	if (IS_ERR(osst_sysfs_class)) {
+		printk(KERN_ERR "osst :W: Unable to register sysfs class\n");
+		return PTR_ERR(osst_sysfs_class);
+	}
+
+	return 0;
 }
 
-static void osst_sysfs_add(dev_t dev, struct device *device, struct osst_tape * STp, char * name)
+static void osst_sysfs_destroy(dev_t dev)
 {
-	struct class_device *osst_class_member;
+	class_device_destroy(osst_sysfs_class, dev);
+}
 
-	if (!osst_sysfs_valid) return;
+static int osst_sysfs_add(dev_t dev, struct device *device, struct osst_tape * STp, char * name)
+{
+	struct class_device *osst_class_member;
+	int err;
 
-	osst_class_member = class_device_create(osst_sysfs_class, NULL, dev, device, "%s", name);
+	osst_class_member = class_device_create(osst_sysfs_class, NULL, dev,
+						device, "%s", name);
 	if (IS_ERR(osst_class_member)) {
 		printk(KERN_WARNING "osst :W: Unable to add sysfs class member %s\n", name);
-		return;
+		return PTR_ERR(osst_class_member);
 	}
+
 	class_set_devdata(osst_class_member, STp);
-	class_device_create_file(osst_class_member, &class_device_attr_ADR_rev);
-	class_device_create_file(osst_class_member, &class_device_attr_media_version);
-	class_device_create_file(osst_class_member, &class_device_attr_capacity);
-	class_device_create_file(osst_class_member, &class_device_attr_BOT_frame);
-	class_device_create_file(osst_class_member, &class_device_attr_EOD_frame);
-	class_device_create_file(osst_class_member, &class_device_attr_file_count);
-}
+	err = class_device_create_file(osst_class_member,
+				       &class_device_attr_ADR_rev);
+	if (err)
+		goto err_out;
+	err = class_device_create_file(osst_class_member,
+				       &class_device_attr_media_version);
+	if (err)
+		goto err_out;
+	err = class_device_create_file(osst_class_member,
+				       &class_device_attr_capacity);
+	if (err)
+		goto err_out;
+	err = class_device_create_file(osst_class_member,
+				       &class_device_attr_BOT_frame);
+	if (err)
+		goto err_out;
+	err = class_device_create_file(osst_class_member,
+				       &class_device_attr_EOD_frame);
+	if (err)
+		goto err_out;
+	err = class_device_create_file(osst_class_member,
+				       &class_device_attr_file_count);
+	if (err)
+		goto err_out;
 
-static void osst_sysfs_destroy(dev_t dev)
-{
-	if (!osst_sysfs_valid) return; 
+	return 0;
 
-	class_device_destroy(osst_sysfs_class, dev);
+err_out:
+	osst_sysfs_destroy(dev);
+	return err;
 }
 
 static void osst_sysfs_cleanup(void)
 {
-	if (osst_sysfs_valid) {
-		class_destroy(osst_sysfs_class);
-		osst_sysfs_valid = 0;
-	}
+	class_destroy(osst_sysfs_class);
 }
 
 /*
@@ -5721,7 +5741,7 @@ static int osst_probe(struct device *dev
 	struct st_partstat * STps;
 	struct osst_buffer * buffer;
 	struct gendisk	   * drive;
-	int		     i, dev_num;
+	int		     i, dev_num, err = -ENODEV;
 
 	if (SDp->type != TYPE_TAPE || !osst_supports(SDp))
 		return -ENODEV;
@@ -5849,13 +5869,20 @@ static int osst_probe(struct device *dev
 	init_MUTEX(&tpnt->lock);
 	osst_nr_dev++;
 	write_unlock(&os_scsi_tapes_lock);
+
 	{
 		char name[8];
+
 		/*  Rewind entry  */
-		osst_sysfs_add(MKDEV(OSST_MAJOR, dev_num), dev, tpnt, tape_name(tpnt));
+		err = osst_sysfs_add(MKDEV(OSST_MAJOR, dev_num), dev, tpnt, tape_name(tpnt));
+		if (err)
+			goto out_free_buffer;
+
 		/*  No-rewind entry  */
 		snprintf(name, 8, "%s%s", "n", tape_name(tpnt));
-		osst_sysfs_add(MKDEV(OSST_MAJOR, dev_num + 128), dev, tpnt, name);
+		err = osst_sysfs_add(MKDEV(OSST_MAJOR, dev_num + 128), dev, tpnt, name);
+		if (err)
+			goto out_free_sysfs1;
 	}
 
 	sdev_printk(KERN_INFO, SDp,
@@ -5864,9 +5891,13 @@ static int osst_probe(struct device *dev
 
 	return 0;
 
+out_free_sysfs1:
+	osst_sysfs_destroy(MKDEV(OSST_MAJOR, dev_num));
+out_free_buffer:
+	kfree(buffer);
 out_put_disk:
         put_disk(drive);
-        return -ENODEV;
+        return err;
 };
 
 static int osst_remove(struct device *dev)
@@ -5903,19 +5934,39 @@ static int osst_remove(struct device *de
 
 static int __init init_osst(void) 
 {
+	int err;
+
 	printk(KERN_INFO "osst :I: Tape driver with OnStream support version %s\nosst :I: %s\n", osst_version, cvsid);
 
 	validate_options();
-	osst_sysfs_init();
 
-	if ((register_chrdev(OSST_MAJOR,"osst", &osst_fops) < 0) || scsi_register_driver(&osst_template.gendrv)) {
+	err = osst_sysfs_init();
+	if (err)
+		return err;
+
+	err = register_chrdev(OSST_MAJOR, "osst", &osst_fops);
+	if (err < 0) {
 		printk(KERN_ERR "osst :E: Unable to register major %d for OnStream tapes\n", OSST_MAJOR);
-		osst_sysfs_cleanup();
-		return 1;
+		goto err_out;
 	}
-	osst_create_driverfs_files(&osst_template.gendrv);
+
+	err = scsi_register_driver(&osst_template.gendrv);
+	if (err)
+		goto err_out_chrdev;
+
+	err = osst_create_driverfs_files(&osst_template.gendrv);
+	if (err)
+		goto err_out_scsidrv;
 
 	return 0;
+
+err_out_scsidrv:
+	scsi_unregister_driver(&osst_template.gendrv);
+err_out_chrdev:
+	unregister_chrdev(OSST_MAJOR, "osst");
+err_out:
+	osst_sysfs_cleanup();
+	return err;
 }
 
 static void __exit exit_osst (void)
