Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263150AbTJUPKh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 11:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263157AbTJUPKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 11:10:36 -0400
Received: from d12lmsgate-5.de.ibm.com ([194.196.100.238]:17584 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S263150AbTJUPId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 11:08:33 -0400
Date: Tue, 21 Oct 2003 17:08:54 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (5/8): tape driver fixes.
Message-ID: <20031021150854.GC1690@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - Fix device reference counting.
 - Fix online-offline-online cycle.
 - Add module license gpl.

diffstat:
 drivers/s390/char/tape.h       |    3 -
 drivers/s390/char/tape_34xx.c  |    9 +--
 drivers/s390/char/tape_block.c |   18 +++++--
 drivers/s390/char/tape_char.c  |    7 +-
 drivers/s390/char/tape_core.c  |   98 +++++++++++++++++++++--------------------
 5 files changed, 73 insertions(+), 62 deletions(-)

diff -urN linux-2.6/drivers/s390/char/tape.h linux-2.6-s390/drivers/s390/char/tape.h
--- linux-2.6/drivers/s390/char/tape.h	Fri Oct 17 23:43:20 2003
+++ linux-2.6-s390/drivers/s390/char/tape.h	Tue Oct 21 16:37:37 2003
@@ -246,7 +246,8 @@
 extern int tape_generic_remove(struct ccw_device *);
 
 extern struct tape_device *tape_get_device(int devindex);
-extern void tape_put_device(struct tape_device *);
+extern struct tape_device *tape_get_device_reference(struct tape_device *);
+extern struct tape_device *tape_put_device(struct tape_device *);
 
 /* Externals from tape_char.c */
 extern int tapechar_init(void);
diff -urN linux-2.6/drivers/s390/char/tape_34xx.c linux-2.6-s390/drivers/s390/char/tape_34xx.c
--- linux-2.6/drivers/s390/char/tape_34xx.c	Fri Oct 17 23:43:02 2003
+++ linux-2.6-s390/drivers/s390/char/tape_34xx.c	Tue Oct 21 16:37:37 2003
@@ -104,7 +104,7 @@
 			DBF_EVENT(3, "T34XX: internal error: unknown work\n");
 	}
 
-	tape_put_device(p->device);
+	p->device = tape_put_device(p->device);
 	kfree(p);
 }
 
@@ -123,8 +123,7 @@
 	memset(p, 0, sizeof(*p));
 	INIT_WORK(&p->work, tape_34xx_work_handler, p);
 
-	atomic_inc(&device->ref_count);
-	p->device = device;
+	p->device = tape_get_device_reference(device);
 	p->op     = op;
 
 	schedule_work(&p->work);
@@ -1041,7 +1040,7 @@
 {
 	int rc;
 
-	DBF_EVENT(3, "34xx init: $Revision: 1.8 $\n");
+	DBF_EVENT(3, "34xx init: $Revision: 1.9 $\n");
 	/* Register driver for 3480/3490 tapes. */
 	rc = ccw_driver_register(&tape_34xx_driver);
 	if (rc)
@@ -1060,7 +1059,7 @@
 MODULE_DEVICE_TABLE(ccw, tape_34xx_ids);
 MODULE_AUTHOR("(C) 2001-2002 IBM Deutschland Entwicklung GmbH");
 MODULE_DESCRIPTION("Linux on zSeries channel attached 3480 tape "
-		   "device driver ($Revision: 1.8 $)");
+		   "device driver ($Revision: 1.9 $)");
 MODULE_LICENSE("GPL");
 
 module_init(tape_34xx_init);
diff -urN linux-2.6/drivers/s390/char/tape_block.c linux-2.6-s390/drivers/s390/char/tape_block.c
--- linux-2.6/drivers/s390/char/tape_block.c	Fri Oct 17 23:43:24 2003
+++ linux-2.6-s390/drivers/s390/char/tape_block.c	Tue Oct 21 16:37:37 2003
@@ -214,7 +214,8 @@
 	if (!disk)
 		return -ENOMEM;
 
-	tasklet_init(&d->tasklet, tapeblock_tasklet, (unsigned long)device);
+	tasklet_init(&d->tasklet, tapeblock_tasklet,
+		(unsigned long) tape_get_device_reference(device));
 
 	spin_lock_init(&d->request_queue_lock);
 	q = blk_init_queue(tapeblock_request_fn, &d->request_queue_lock);
@@ -239,7 +240,7 @@
 	disk->major = tapeblock_major;
 	disk->first_minor = device->first_minor;
 	disk->fops = &tapeblock_fops;
-	disk->private_data = device;
+	disk->private_data = tape_get_device_reference(device);
 	disk->queue = q;
 	//set_capacity(disk, size);
 
@@ -262,10 +263,12 @@
 	struct tape_blk_data *d = &device->blk_data;
 
 	del_gendisk(d->disk);
+	d->disk->private_data = tape_put_device(d->disk->private_data);
 	put_disk(d->disk);
 	blk_cleanup_queue(d->request_queue);
 
 	tasklet_kill(&d->tasklet);
+	tape_put_device(device);
 }
 
 /*
@@ -301,9 +304,9 @@
 static int
 tapeblock_open(struct inode *inode, struct file *filp)
 {
-	struct gendisk *disk = inode->i_bdev->bd_disk;
-	struct tape_device *device = disk->private_data;
-	int rc;
+	struct gendisk *	disk;
+	struct tape_device *	device;
+	int			rc;
 
 	/*
 	 * FIXME: this new tapeblock_open function is from 2.5.69.
@@ -311,6 +314,9 @@
 	 * pointer from disk->private_data. It is stored in 
 	 * tapeblock_setup_device but WITHOUT proper ref-counting.
 	 */
+	disk   = inode->i_bdev->bd_disk;
+	device = tape_get_device_reference(disk->private_data);
+
 	rc = tape_open(device);
 	if (rc)
 		goto put_device;
@@ -341,8 +347,8 @@
 	struct gendisk *disk = inode->i_bdev->bd_disk;
 	struct tape_device *device = disk->private_data;
 
-	tape_release(device);
 	tape_unassign(device);
+	tape_release(device);
 	tape_put_device(device);
 
 	return 0;
diff -urN linux-2.6/drivers/s390/char/tape_char.c linux-2.6-s390/drivers/s390/char/tape_char.c
--- linux-2.6/drivers/s390/char/tape_char.c	Fri Oct 17 23:43:24 2003
+++ linux-2.6-s390/drivers/s390/char/tape_char.c	Tue Oct 21 16:37:37 2003
@@ -267,8 +267,9 @@
 {
 	struct tape_device *device;
 
-	device = (struct tape_device *) filp->private_data;
 	DBF_EVENT(6, "TCHAR:release: %x\n", iminor(inode));
+	device = (struct tape_device *) filp->private_data;
+
 #if 0
 	// FIXME: this is broken. Either MTWEOF/MTWEOF/MTBSR is done
 	// EVERYTIME the user switches from write to something different
@@ -287,9 +288,9 @@
 		device->char_data.idal_buf = NULL;
 	}
 	device->char_data.block_size = 0;
-	tape_release(device);
 	tape_unassign(device);
-	tape_put_device(device);
+	tape_release(device);
+	filp->private_data = tape_put_device(device);
 	return 0;
 }
 
diff -urN linux-2.6/drivers/s390/char/tape_core.c linux-2.6-s390/drivers/s390/char/tape_core.c
--- linux-2.6/drivers/s390/char/tape_core.c	Fri Oct 17 23:42:57 2003
+++ linux-2.6-s390/drivers/s390/char/tape_core.c	Tue Oct 21 16:37:37 2003
@@ -36,11 +36,6 @@
 static rwlock_t tape_device_lock = RW_LOCK_UNLOCKED;
 
 /*
- * Wait queue for tape_delete_device waits.
- */
-static DECLARE_WAIT_QUEUE_HEAD(tape_delete_wq);
-
-/*
  * Pointer to debug area.
  */
 debug_info_t *tape_dbf_area = NULL;
@@ -258,7 +253,7 @@
 			__tape_halt_io(device, request);
 		list_del(&request->list);
 		/* Decrease ref_count for removed request. */
-		tape_put_device(device);
+		request->device = tape_put_device(device);
 		request->rc = -EIO;
 		if (request->callback != NULL)
 			request->callback(request, request->callback_data);
@@ -269,6 +264,9 @@
 	tapechar_cleanup_device(device);
 	device->discipline->cleanup_device(device);
 	tape_remove_minor(device);
+
+	/* FIXME: This should be more something like TS_OFFLINE */
+	device->tape_state = TS_INIT;
 }
 
 /*
@@ -301,17 +299,50 @@
 	device->tape_state = TS_INIT;
 	device->medium_state = MS_UNKNOWN;
 	*device->modeset_byte = 0;
+	atomic_set(&device->ref_count, 1);
+
 	return device;
 }
 
 /*
- * Free memory of a device structure.
+ * Get a reference to an existing device structure. This will automatically
+ * increment the reference count.
  */
-static void
-tape_free_device(struct tape_device *device)
+struct tape_device *
+tape_get_device_reference(struct tape_device *device)
+{
+	DBF_EVENT(4, "tape_get_device_reference(%p) = %i\n", device,
+		atomic_inc_return(&device->ref_count));
+
+	return device;
+}
+
+/*
+ * Decrease the reference counter of a devices structure. If the
+ * reference counter reaches zero free the device structure.
+ * The function returns a NULL pointer to be used by the caller
+ * for clearing reference pointers.
+ */
+struct tape_device *
+tape_put_device(struct tape_device *device)
 {
-	kfree(device->modeset_byte);
-	kfree(device);
+	int remain;
+
+	remain = atomic_dec_return(&device->ref_count);
+	if (remain > 0) {
+		DBF_EVENT(4, "tape_put_device(%p) -> %i\n", device, remain);
+	} else {
+		if (remain < 0) {
+			DBF_EVENT(4, "put device without reference\n");
+			PRINT_ERR("put device without reference\n");
+		} else {
+			DBF_EVENT(4, "tape_free_device(%p)\n", device);
+			kfree(device->modeset_byte);
+			kfree(device);
+		}
+	}
+
+	return NULL;			
 }
 
 /*
@@ -326,8 +357,7 @@
 	read_lock(&tape_device_lock);
 	list_for_each_entry(tmp, &tape_device_list, node) {
 		if (tmp->first_minor * TAPE_MINORS_PER_DEV == devindex) {
-			device = tmp;
-			atomic_inc(&device->ref_count);
+			device = tape_get_device_reference(tmp);
 			break;
 		}
 	}
@@ -336,25 +366,6 @@
 }
 
 /*
- * Decrease the reference counter of a devices structure. If the
- * reference counter reaches zero free the device structure and
- * wake up sleepers.
- */
-void
-tape_put_device(struct tape_device *device)
-{
-	if (atomic_dec_return(&device->ref_count) > 0)
-		return;
-	/*
-	 * Reference counter dropped to zero. This means
-	 * that the device is deleted and the last user
-	 * of the device structure is gone. That is what
-	 * tape_delete_device is waiting for. Do a wake up.
-	 */
-	wake_up(&tape_delete_wq);
-}
-
-/*
  * Driverfs tape probe function.
  */
 int
@@ -367,7 +378,6 @@
 	if (IS_ERR(device))
 		return -ENODEV;
 	PRINT_INFO("tape device %s found\n", bus_id);
-	atomic_inc(&device->ref_count);
 	cdev->dev.driver_data = device;
 	device->cdev = cdev;
 	cdev->handler = tape_do_irq;
@@ -383,14 +393,8 @@
 int
 tape_generic_remove(struct ccw_device *cdev)
 {
-	struct tape_device *device;
-
-	device = cdev->dev.driver_data;
-	cdev->dev.driver_data = NULL;
-	if (device != NULL) {
-		tape_put_device(device);
-		wait_event(tape_delete_wq, atomic_read(&device->ref_count) == 0);
-		tape_free_device(device);
+	if (cdev->dev.driver_data != NULL) {
+		cdev->dev.driver_data = tape_put_device(cdev->dev.driver_data);
 	}
 	return 0;
 }
@@ -446,8 +450,7 @@
 tape_free_request (struct tape_request * request)
 {
 	if (request->device != NULL) {
-		tape_put_device(request->device);
-		request->device = NULL;
+		request->device = tape_put_device(request->device);
 	}
 	if (request->cpdata != NULL)
 		kfree(request->cpdata);
@@ -518,8 +521,7 @@
 		return -ENODEV;
 
 	/* Increase use count of device for the added request. */
-	atomic_inc(&device->ref_count);
-	request->device = device;
+	request->device = tape_get_device_reference(device);
 
 	if (list_empty(&device->req_queue)) {
 		/* No other requests are on the queue. Start this one. */
@@ -905,7 +907,7 @@
 {
 	tape_dbf_area = debug_register ( "tape", 1, 2, 3*sizeof(long));
 	debug_register_view(tape_dbf_area, &debug_sprintf_view);
-	DBF_EVENT(3, "tape init: ($Revision: 1.26 $)\n");
+	DBF_EVENT(3, "tape init: ($Revision: 1.29 $)\n");
 	tape_proc_init();
 	tapechar_init ();
 	tapeblock_init ();
@@ -930,7 +932,8 @@
 MODULE_AUTHOR("(C) 2001 IBM Deutschland Entwicklung GmbH by Carsten Otte and "
 	      "Michael Holzheu (cotte@de.ibm.com,holzheu@de.ibm.com)");
 MODULE_DESCRIPTION("Linux on zSeries channel attached "
-		   "tape device driver ($Revision: 1.26 $)");
+		   "tape device driver ($Revision: 1.29 $)");
+MODULE_LICENSE("GPL");
 
 module_init(tape_init);
 module_exit(tape_exit);
@@ -941,6 +944,7 @@
 EXPORT_SYMBOL(tape_generic_probe);
 EXPORT_SYMBOL(tape_enable_device);
 EXPORT_SYMBOL(tape_put_device);
+EXPORT_SYMBOL(tape_get_device_reference);
 EXPORT_SYMBOL(tape_state_verbose);
 EXPORT_SYMBOL(tape_op_verbose);
 EXPORT_SYMBOL(tape_state_set);
