Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbUFBKzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbUFBKzO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 06:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbUFBKy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 06:54:57 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:51850 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S261832AbUFBKxE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 06:53:04 -0400
Date: Wed, 2 Jun 2004 12:53:05 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (3/4): block device driver.
Message-ID: <20040602105305.GD7108@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: block device driver.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

block device driver changes:
 - dasd: Fix diag discipline if it is loaded as a module.
 - dcssblk: Replace r/w lock with r/w semaphore to be able to call
   device_register inside a critical section.
 - dcssblk: Fix error handling in write function for dcss "add" attribute.
 - xpram & dcssblk: Fix sanity check for sector number.

diffstat:
 drivers/s390/block/dasd.c      |    6 +-
 drivers/s390/block/dasd_diag.c |    8 ++
 drivers/s390/block/dasd_int.h  |    9 ---
 drivers/s390/block/dcssblk.c   |  114 +++++++++++++++++++----------------------
 drivers/s390/block/xpram.c     |    2 
 5 files changed, 68 insertions(+), 71 deletions(-)

diff -urN linux-2.6/drivers/s390/block/dasd.c linux-2.6-s390/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	Wed Jun  2 11:29:04 2004
+++ linux-2.6-s390/drivers/s390/block/dasd.c	Wed Jun  2 11:29:39 2004
@@ -7,7 +7,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999-2001
  *
- * $Revision: 1.141 $
+ * $Revision: 1.142 $
  */
 
 #include <linux/config.h>
@@ -37,6 +37,7 @@
  * SECTION: exported variables of dasd.c
  */
 debug_info_t *dasd_debug_area;
+struct dasd_discipline *dasd_diag_discipline_pointer;
 
 MODULE_AUTHOR("Holger Smolinski <Holger.Smolinski@de.ibm.com>");
 MODULE_DESCRIPTION("Linux on S/390 DASD device driver,"
@@ -1990,6 +1991,8 @@
 
 	DBF_EVENT(DBF_EMERG, "%s", "debug area created");
 
+	dasd_diag_discipline_pointer = NULL;
+
 	rc = devfs_mk_dir("dasd");
 	if (rc)
 		goto failed;
@@ -2022,6 +2025,7 @@
 module_exit(dasd_exit);
 
 EXPORT_SYMBOL(dasd_debug_area);
+EXPORT_SYMBOL(dasd_diag_discipline_pointer);
 
 EXPORT_SYMBOL(dasd_add_request_head);
 EXPORT_SYMBOL(dasd_add_request_tail);
diff -urN linux-2.6/drivers/s390/block/dasd_diag.c linux-2.6-s390/drivers/s390/block/dasd_diag.c
--- linux-2.6/drivers/s390/block/dasd_diag.c	Mon May 10 04:31:58 2004
+++ linux-2.6-s390/drivers/s390/block/dasd_diag.c	Wed Jun  2 11:29:39 2004
@@ -6,7 +6,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.34 $
+ * $Revision: 1.36 $
  */
 
 #include <linux/config.h>
@@ -35,6 +35,8 @@
 
 MODULE_LICENSE("GPL");
 
+struct dasd_discipline dasd_diag_discipline;
+
 struct dasd_diag_private {
 	struct dasd_diag_characteristics rdc_data;
 	struct dasd_diag_rw_io iob;
@@ -292,7 +294,7 @@
 		mdsk_term_io(device);
 	}
 	if (bsize <= PAGE_SIZE && label[3] == bsize &&
-	    label[0] == 0xc3d4e2f1 && label[13] != 0) {
+	    label[0] == 0xc3d4e2f1) {
 		device->blocks = label[7];
 		device->bp_block = bsize;
 		device->s2b_shift = 0;	/* bits to shift 512 to get a block */
@@ -489,6 +491,7 @@
 
 	ctl_set_bit(0, 9);
 	register_external_interrupt(0x2603, dasd_ext_handler);
+	dasd_diag_discipline_pointer = &dasd_diag_discipline;
 	return 0;
 }
 
@@ -503,6 +506,7 @@
 	}
 	unregister_external_interrupt(0x2603, dasd_ext_handler);
 	ctl_clear_bit(0, 9);
+	dasd_diag_discipline_pointer = NULL;
 }
 
 module_init(dasd_diag_init);
diff -urN linux-2.6/drivers/s390/block/dasd_int.h linux-2.6-s390/drivers/s390/block/dasd_int.h
--- linux-2.6/drivers/s390/block/dasd_int.h	Mon May 10 04:32:54 2004
+++ linux-2.6-s390/drivers/s390/block/dasd_int.h	Wed Jun  2 11:29:39 2004
@@ -6,7 +6,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.57 $
+ * $Revision: 1.58 $
  */
 
 #ifndef DASD_INT_H
@@ -260,12 +260,7 @@
 	int (*fill_info) (struct dasd_device *, struct dasd_information2_t *);
 };
 
-extern struct dasd_discipline dasd_diag_discipline;
-#ifdef CONFIG_DASD_DIAG
-#define dasd_diag_discipline_pointer (&dasd_diag_discipline)
-#else
-#define dasd_diag_discipline_pointer (0)
-#endif
+extern struct dasd_discipline *dasd_diag_discipline_pointer;
 
 struct dasd_device {
 	/* Block device stuff. */
diff -urN linux-2.6/drivers/s390/block/dcssblk.c linux-2.6-s390/drivers/s390/block/dcssblk.c
--- linux-2.6/drivers/s390/block/dcssblk.c	Mon May 10 04:32:25 2004
+++ linux-2.6-s390/drivers/s390/block/dcssblk.c	Wed Jun  2 11:29:39 2004
@@ -76,8 +76,7 @@
 };
 
 static struct list_head dcssblk_devices = LIST_HEAD_INIT(dcssblk_devices);
-static rwlock_t dcssblk_devices_lock = RW_LOCK_UNLOCKED;
-
+static struct rw_semaphore dcssblk_devices_sem;
 
 /*
  * release function for segment device.
@@ -92,8 +91,8 @@
 
 /*
  * get a minor number. needs to be called with
- * write_lock(&dcssblk_devices_lock) and the
- * device needs to be enqueued before the lock is
+ * down_write(&dcssblk_devices_sem) and the
+ * device needs to be enqueued before the semaphore is
  * freed.
  */
 static inline int
@@ -121,7 +120,7 @@
 /*
  * get the struct dcssblk_dev_info from dcssblk_devices
  * for the given name.
- * read_lock(&dcssblk_devices_lock) must be held.
+ * down_read(&dcssblk_devices_sem) must be held.
  */
 static struct dcssblk_dev_info *
 dcssblk_get_device_by_name(char *name)
@@ -137,31 +136,6 @@
 }
 
 /*
- * register the device that represents a segment in sysfs,
- * also add the attributes for the device
- */
-static inline int
-dcssblk_register_segment_device(struct device *dev)
-{
-	int rc;
-
-	rc = device_register(dev);
-	if (rc)
-		return rc;
-	rc = device_create_file(dev, &dev_attr_shared);
-	if (rc)
-		goto unregister_dev;
-	rc = device_create_file(dev, &dev_attr_save);
-	if (rc)
-		goto unregister_dev;
-	return rc;
-
-unregister_dev:
-	device_unregister(dev);
-	return rc;
-}
-
-/*
  * device attribute for switching shared/nonshared (exclusive)
  * operation (show + store)
  */
@@ -184,24 +158,24 @@
 		PRINT_WARN("Invalid value, must be 0 or 1\n");
 		return -EINVAL;
 	}
-	write_lock(&dcssblk_devices_lock);
+	down_write(&dcssblk_devices_sem);
 	dev_info = container_of(dev, struct dcssblk_dev_info, dev);
 	if (atomic_read(&dev_info->use_count)) {
 		PRINT_ERR("share: segment %s is busy!\n",
 			  dev_info->segment_name);
-		write_unlock(&dcssblk_devices_lock);
+		up_write(&dcssblk_devices_sem);
 		return -EBUSY;
 	}
 	if ((inbuf[0] == '1') && (dev_info->is_shared == 1)) {
 		PRINT_WARN("Segment %s already loaded in shared mode!\n",
 			   dev_info->segment_name);
-		write_unlock(&dcssblk_devices_lock);
+		up_write(&dcssblk_devices_sem);
 		return count;
 	}
 	if ((inbuf[0] == '0') && (dev_info->is_shared == 0)) {
 		PRINT_WARN("Segment %s already loaded in exclusive mode!\n",
 			   dev_info->segment_name);
-		write_unlock(&dcssblk_devices_lock);
+		up_write(&dcssblk_devices_sem);
 		return count;
 	}
 	if (inbuf[0] == '1') {
@@ -231,7 +205,7 @@
 		PRINT_INFO("Segment %s reloaded, exclusive (read-write) mode.\n",
 			   dev_info->segment_name);
 	} else {
-		write_unlock(&dcssblk_devices_lock);
+		up_write(&dcssblk_devices_sem);
 		PRINT_WARN("Invalid value, must be 0 or 1\n");
 		return -EINVAL;
 	}
@@ -262,14 +236,13 @@
 				dev_info->segment_name);
 		rc = -EPERM;
 	}
-	write_unlock(&dcssblk_devices_lock);
+	up_write(&dcssblk_devices_sem);
 	goto out;
 
 removeseg:
 	PRINT_ERR("Could not reload segment %s, removing it now!\n",
 			dev_info->segment_name);
 	list_del(&dev_info->lh);
-	write_unlock(&dcssblk_devices_lock);
 
 	del_gendisk(dev_info->gd);
 	blk_put_queue(dev_info->dcssblk_queue);
@@ -277,6 +250,7 @@
 	put_disk(dev_info->gd);
 	device_unregister(dev);
 	put_device(dev);
+	up_write(&dcssblk_devices_sem);
 out:
 	return rc;
 }
@@ -308,7 +282,7 @@
 	}
 	dev_info = container_of(dev, struct dcssblk_dev_info, dev);
 
-	write_lock(&dcssblk_devices_lock);
+	down_write(&dcssblk_devices_sem);
 	if (inbuf[0] == '1') {
 		if (atomic_read(&dev_info->use_count) == 0) {
 			// device is idle => we save immediately
@@ -332,11 +306,11 @@
 					dev_info->segment_name);
 		}
 	} else {
-		write_unlock(&dcssblk_devices_lock);
+		up_write(&dcssblk_devices_sem);
 		PRINT_WARN("Invalid value, must be 0 or 1\n");
 		return -EINVAL;
 	}
-	write_unlock(&dcssblk_devices_lock);
+	up_write(&dcssblk_devices_sem);
 	return count;
 }
 
@@ -375,9 +349,9 @@
 	/*
 	 * already loaded?
 	 */
-	read_lock(&dcssblk_devices_lock);
+	down_read(&dcssblk_devices_sem);
 	dev_info = dcssblk_get_device_by_name(local_buf);
-	read_unlock(&dcssblk_devices_lock);
+	up_read(&dcssblk_devices_sem);
 	if (dev_info != NULL) {
 		PRINT_WARN("Segment %s already loaded!\n", local_buf);
 		rc = -EEXIST;
@@ -433,10 +407,10 @@
 	/*
 	 * get minor, add to list
 	 */
-	write_lock(&dcssblk_devices_lock);
+	down_write(&dcssblk_devices_sem);
 	rc = dcssblk_assign_free_minor(dev_info);
 	if (rc) {
-		write_unlock(&dcssblk_devices_lock);
+		up_write(&dcssblk_devices_sem);
 		PRINT_ERR("No free minor number available! "
 			  "Unloading segment...\n");
 		goto unload_seg;
@@ -444,22 +418,29 @@
 	sprintf(dev_info->gd->disk_name, "dcssblk%d",
 		dev_info->gd->first_minor);
 	list_add_tail(&dev_info->lh, &dcssblk_devices);
+
+	if (!try_module_get(THIS_MODULE)) {
+		rc = -ENODEV;
+		goto list_del;
+	}
 	/*
 	 * register the device
 	 */
-	rc = dcssblk_register_segment_device(&dev_info->dev);
+	rc = device_register(&dev_info->dev);
 	if (rc) {
 		PRINT_ERR("Segment %s could not be registered RC=%d\n",
 				local_buf, rc);
+		module_put(THIS_MODULE);
 		goto list_del;
 	}
-
-	if (!try_module_get(THIS_MODULE)) {
-		rc = -ENODEV;
-		goto list_del;
-	}
-
 	get_device(&dev_info->dev);
+	rc = device_create_file(&dev_info->dev, &dev_attr_shared);
+	if (rc)
+		goto unregister_dev;
+	rc = device_create_file(&dev_info->dev, &dev_attr_save);
+	if (rc)
+		goto unregister_dev;
+
 	add_disk(dev_info->gd);
 
 	blk_queue_make_request(dev_info->dcssblk_queue, dcssblk_make_request);
@@ -476,13 +457,24 @@
 			break;
 	}
 	PRINT_DEBUG("Segment %s loaded successfully\n", local_buf);
-	write_unlock(&dcssblk_devices_lock);
+	up_write(&dcssblk_devices_sem);
 	rc = count;
 	goto out;
 
+unregister_dev:
+	PRINT_ERR("device_create_file() failed!\n");
+	list_del(&dev_info->lh);
+	blk_put_queue(dev_info->dcssblk_queue);
+	dev_info->gd->queue = NULL;
+	put_disk(dev_info->gd);
+	device_unregister(&dev_info->dev);
+	segment_unload(dev_info->segment_name);
+	put_device(&dev_info->dev);
+	up_write(&dcssblk_devices_sem);
+	goto out;
 list_del:
 	list_del(&dev_info->lh);
-	write_unlock(&dcssblk_devices_lock);
+	up_write(&dcssblk_devices_sem);
 unload_seg:
 	segment_unload(local_buf);
 dealloc_gendisk:
@@ -526,22 +518,21 @@
 		goto out_buf;
 	}
 
-	write_lock(&dcssblk_devices_lock);
+	down_write(&dcssblk_devices_sem);
 	dev_info = dcssblk_get_device_by_name(local_buf);
 	if (dev_info == NULL) {
-		write_unlock(&dcssblk_devices_lock);
+		up_write(&dcssblk_devices_sem);
 		PRINT_WARN("Segment %s is not loaded!\n", local_buf);
 		rc = -ENODEV;
 		goto out_buf;
 	}
 	if (atomic_read(&dev_info->use_count) != 0) {
-		write_unlock(&dcssblk_devices_lock);
+		up_write(&dcssblk_devices_sem);
 		PRINT_WARN("Segment %s is in use!\n", local_buf);
 		rc = -EBUSY;
 		goto out_buf;
 	}
 	list_del(&dev_info->lh);
-	write_unlock(&dcssblk_devices_lock);
 
 	del_gendisk(dev_info->gd);
 	blk_put_queue(dev_info->dcssblk_queue);
@@ -552,6 +543,8 @@
 	PRINT_DEBUG("Segment %s unloaded successfully\n",
 			dev_info->segment_name);
 	put_device(&dev_info->dev);
+	up_write(&dcssblk_devices_sem);
+
 	rc = count;
 out_buf:
 	kfree(local_buf);
@@ -587,7 +580,7 @@
 		rc = -ENODEV;
 		goto out;
 	}
-	write_lock(&dcssblk_devices_lock);
+	down_write(&dcssblk_devices_sem);
 	if (atomic_dec_and_test(&dev_info->use_count)
 	    && (dev_info->save_pending)) {
 		PRINT_INFO("Segment %s became idle and is being saved now\n",
@@ -595,7 +588,7 @@
 		segment_replace(dev_info->segment_name);
 		dev_info->save_pending = 0;
 	}
-	write_unlock(&dcssblk_devices_lock);
+	up_write(&dcssblk_devices_sem);
 	rc = 0;
 out:
 	return rc;
@@ -616,7 +609,7 @@
 	dev_info = bio->bi_bdev->bd_disk->private_data;
 	if (dev_info == NULL)
 		goto fail;
-	if ((bio->bi_sector & 3) != 0 || (bio->bi_size & 4095) != 0)
+	if ((bio->bi_sector & 7) != 0 || (bio->bi_size & 4095) != 0)
 		/* Request is not page-aligned. */
 		goto fail;
 	if (((bio->bi_size >> 9) + bio->bi_sector)
@@ -695,6 +688,7 @@
 		return rc;
 	}
 	dcssblk_major = rc;
+	init_rwsem(&dcssblk_devices_sem);
 	PRINT_DEBUG("...finished!\n");
 	return 0;
 }
diff -urN linux-2.6/drivers/s390/block/xpram.c linux-2.6-s390/drivers/s390/block/xpram.c
--- linux-2.6/drivers/s390/block/xpram.c	Mon May 10 04:32:54 2004
+++ linux-2.6-s390/drivers/s390/block/xpram.c	Wed Jun  2 11:29:39 2004
@@ -290,7 +290,7 @@
 	unsigned long bytes;
 	int i;
 
-	if ((bio->bi_sector & 3) != 0 || (bio->bi_size & 4095) != 0)
+	if ((bio->bi_sector & 7) != 0 || (bio->bi_size & 4095) != 0)
 		/* Request is not page-aligned. */
 		goto fail;
 	if ((bio->bi_size >> 12) > xdev->size)
