Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264114AbUCZSaO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 13:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264127AbUCZSaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 13:30:13 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:23186 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S264114AbUCZSVX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 13:21:23 -0500
Date: Fri, 26 Mar 2004 19:21:06 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (5/7): tape driver.
Message-ID: <20040326182106.GF2523@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

s390 tape driver changes:
 - Prevent offline while device is in use.
 - Do not use bus_id string in debug feature messages.
 - Check for IS_ERR(irb) error conditions in interrupt handler.
 - Fix removing tape discipline modules.

diffstat:
 drivers/s390/char/tape.h       |    5 -
 drivers/s390/char/tape_34xx.c  |   24 ++---
 drivers/s390/char/tape_block.c |    7 +
 drivers/s390/char/tape_core.c  |  196 +++++++++++++++++++++++++++++++++--------
 drivers/s390/char/tape_std.c   |   22 +++-
 5 files changed, 198 insertions(+), 56 deletions(-)

diff -urN linux-2.6/drivers/s390/char/tape.h linux-2.6-s390/drivers/s390/char/tape.h
--- linux-2.6/drivers/s390/char/tape.h	Fri Mar 26 18:24:55 2004
+++ linux-2.6-s390/drivers/s390/char/tape.h	Fri Mar 26 18:25:58 2004
@@ -198,6 +198,7 @@
 	/* entry in tape_device_list */
 	struct list_head		node;
 
+	int				cdev_id;
 	struct ccw_device *		cdev;
 	struct tape_class_device *	nt;
 	struct tape_class_device *	rt;
@@ -263,8 +264,8 @@
 extern int tape_mtop(struct tape_device *, int, int);
 extern void tape_state_set(struct tape_device *, enum tape_state);
 
-extern int tape_enable_device(struct tape_device *, struct tape_discipline *);
-extern void tape_disable_device(struct tape_device *device);
+extern int tape_generic_online(struct tape_device *, struct tape_discipline *);
+extern int tape_generic_offline(struct tape_device *device);
 
 /* Externals from tape_devmap.c */
 extern int tape_generic_probe(struct ccw_device *);
diff -urN linux-2.6/drivers/s390/char/tape_34xx.c linux-2.6-s390/drivers/s390/char/tape_34xx.c
--- linux-2.6/drivers/s390/char/tape_34xx.c	Thu Mar 11 03:55:25 2004
+++ linux-2.6-s390/drivers/s390/char/tape_34xx.c	Fri Mar 26 18:25:58 2004
@@ -202,8 +202,7 @@
 		tape_34xx_delete_sbid_from(device, 0);
 		tape_34xx_schedule_work(device, TO_MSEN);
 	} else {
-		DBF_EVENT(3, "unsol.irq! dev end: %s\n",
-				device->cdev->dev.bus_id);
+		DBF_EVENT(3, "unsol.irq! dev end: %08x\n", device->cdev_id);
 		PRINT_WARN("Unsolicited IRQ (Device End) caught.\n");
 		tape_dump_sense(device, NULL, irb);
 	}
@@ -1314,17 +1313,18 @@
 };
 
 static int
-tape_34xx_enable(struct ccw_device *cdev)
+tape_34xx_online(struct ccw_device *cdev)
 {
-	return tape_enable_device(cdev->dev.driver_data,
-				  &tape_discipline_34xx);
+	return tape_generic_online(
+		cdev->dev.driver_data,
+		&tape_discipline_34xx
+	);
 }
 
 static int
-tape_34xx_disable(struct ccw_device *cdev)
+tape_34xx_offline(struct ccw_device *cdev)
 {
-	tape_disable_device(cdev->dev.driver_data);
-	return 0;
+	return tape_generic_offline(cdev->dev.driver_data);
 }
 
 static struct ccw_driver tape_34xx_driver = {
@@ -1333,8 +1333,8 @@
 	.ids = tape_34xx_ids,
 	.probe = tape_generic_probe,
 	.remove = tape_generic_remove,
-	.set_online = tape_34xx_enable,
-	.set_offline = tape_34xx_disable,
+	.set_online = tape_34xx_online,
+	.set_offline = tape_34xx_offline,
 };
 
 static int
@@ -1342,7 +1342,7 @@
 {
 	int rc;
 
-	DBF_EVENT(3, "34xx init: $Revision: 1.18 $\n");
+	DBF_EVENT(3, "34xx init: $Revision: 1.19 $\n");
 	/* Register driver for 3480/3490 tapes. */
 	rc = ccw_driver_register(&tape_34xx_driver);
 	if (rc)
@@ -1361,7 +1361,7 @@
 MODULE_DEVICE_TABLE(ccw, tape_34xx_ids);
 MODULE_AUTHOR("(C) 2001-2002 IBM Deutschland Entwicklung GmbH");
 MODULE_DESCRIPTION("Linux on zSeries channel attached 3480 tape "
-		   "device driver ($Revision: 1.18 $)");
+		   "device driver ($Revision: 1.19 $)");
 MODULE_LICENSE("GPL");
 
 module_init(tape_34xx_init);
diff -urN linux-2.6/drivers/s390/char/tape_block.c linux-2.6-s390/drivers/s390/char/tape_block.c
--- linux-2.6/drivers/s390/char/tape_block.c	Thu Mar 11 03:55:37 2004
+++ linux-2.6-s390/drivers/s390/char/tape_block.c	Fri Mar 26 18:25:58 2004
@@ -274,12 +274,19 @@
 	flush_scheduled_work();
 	device->blk_data.requeue_task.data = tape_put_device(device);
 
+	if (!device->blk_data.disk) {
+		PRINT_ERR("(%s): No gendisk to clean up!\n",
+			device->cdev->dev.bus_id);
+		goto cleanup_queue;
+	}
+
 	del_gendisk(device->blk_data.disk);
 	device->blk_data.disk->private_data =
 		tape_put_device(device->blk_data.disk->private_data);
 	put_disk(device->blk_data.disk);
 
 	device->blk_data.disk = NULL;
+cleanup_queue:
 	device->blk_data.request_queue->queuedata = tape_put_device(device);
 
 	blk_cleanup_queue(device->blk_data.request_queue);
diff -urN linux-2.6/drivers/s390/char/tape_core.c linux-2.6-s390/drivers/s390/char/tape_core.c
--- linux-2.6/drivers/s390/char/tape_core.c	Thu Mar 11 03:55:24 2004
+++ linux-2.6-s390/drivers/s390/char/tape_core.c	Fri Mar 26 18:25:58 2004
@@ -69,6 +69,34 @@
 	[TO_UNASSIGN] = "UAS"
 };
 
+static inline int
+busid_to_int(char *bus_id)
+{
+	int	dec;
+	int	d;
+	char *	s;
+
+	for(s = bus_id, d = 0; *s != '\0' && *s != '.'; s++)
+		d = (d * 10) + (*s - '0');
+	dec = d;
+	for(s++, d = 0; *s != '\0' && *s != '.'; s++)
+		d = (d * 10) + (*s - '0');
+	dec = (dec << 8) + d;
+
+	for(s++; *s != '\0'; s++) {
+		if (*s >= '0' && *s <= '9') {
+			d = *s - '0';
+		} else if (*s >= 'a' && *s <= 'f') {
+			d = *s - 'a' + 10;
+		} else {
+			d = *s - 'A' + 10;
+		}
+		dec = (dec << 4) + d;
+	}
+
+	return dec;
+}
+
 /*
  * Some channel attached tape specific attributes.
  *
@@ -296,10 +324,15 @@
 }
 
 /*
- * Enable tape device
+ * Set a device online.
+ *
+ * This function is called by the common I/O layer to move a device from the
+ * detected but offline into the online state.
+ * If we return an error (RC < 0) the device remains in the offline state. This
+ * can happen if the device is assigned somewhere else, for example.
  */
 int
-tape_enable_device(struct tape_device *device,
+tape_generic_online(struct tape_device *device,
 		   struct tape_discipline *discipline)
 {
 	int rc;
@@ -328,6 +361,9 @@
 		goto out_char;
 
 	tape_state_set(device, TS_UNUSED);
+
+	DBF_LH(3, "(%08x): Drive set online\n", device->cdev_id);
+
 	return 0;
 
 out_char:
@@ -342,37 +378,49 @@
 }
 
 /*
- * Disable tape device. Check if there is a running request and
- * terminate it. Post all queued requests with -EIO.
+ * Set device offline.
+ *
+ * Called by the common I/O layer if the drive should set offline on user
+ * request. We may prevent this by returning an error.
+ * Manual offline is only allowed while the drive is not in use.
  */
-void
-tape_disable_device(struct tape_device *device)
+int
+tape_generic_offline(struct tape_device *device)
 {
-	struct list_head *l, *n;
-	struct tape_request *request;
+	if (!device) {
+		PRINT_ERR("tape_generic_offline: no such device\n");
+		return -ENODEV;
+	}
+
+	DBF_LH(3, "(%08x): tape_generic_offline(%p)\n",
+		device->cdev_id, device);
 
 	spin_lock_irq(get_ccwdev_lock(device->cdev));
-	/* Post remaining requests with -EIO */
-	list_for_each_safe(l, n, &device->req_queue) {
-		request = list_entry(l, struct tape_request, list);
-		if (request->status == TAPE_REQUEST_IN_IO)
-			__tape_halt_io(device, request);
-		list_del(&request->list);
-		/* Decrease ref_count for removed request. */
-		request->device = tape_put_device(device);
-		request->rc = -EIO;
-		if (request->callback != NULL)
-			request->callback(request, request->callback_data);
+	switch (device->tape_state) {
+		case TS_INIT:
+		case TS_NOT_OPER:
+			break;
+		case TS_UNUSED:
+			tapeblock_cleanup_device(device);
+			tapechar_cleanup_device(device);
+			device->discipline->cleanup_device(device);
+			tape_remove_minor(device);
+		default:
+			DBF_EVENT(3, "(%08x): Set offline failed "
+				"- drive in use.\n",
+				device->cdev_id);
+			PRINT_WARN("(%s): Set offline failed "
+				"- drive in use.\n",
+				device->cdev->dev.bus_id);
+			spin_unlock_irq(get_ccwdev_lock(device->cdev));
+			return -EBUSY;
 	}
 	spin_unlock_irq(get_ccwdev_lock(device->cdev));
 
-	tapeblock_cleanup_device(device);
-	tapechar_cleanup_device(device);
-	device->discipline->cleanup_device(device);
-	tape_remove_minor(device);
-
 	tape_med_state_set(device, MS_UNKNOWN);
-	device->tape_state = TS_INIT;
+
+	DBF_LH(3, "(%08x): Drive set offline.\n", device->cdev_id);
+	return 0;
 }
 
 /*
@@ -479,14 +527,14 @@
 tape_generic_probe(struct ccw_device *cdev)
 {
 	struct tape_device *device;
-	char *bus_id = cdev->dev.bus_id;
 
 	device = tape_alloc_device();
 	if (IS_ERR(device))
 		return -ENODEV;
-	PRINT_INFO("tape device %s found\n", bus_id);
+	PRINT_INFO("tape device %s found\n", cdev->dev.bus_id);
 	cdev->dev.driver_data = device;
 	device->cdev = cdev;
+	device->cdev_id = busid_to_int(cdev->dev.bus_id);
 	cdev->handler = __tape_do_irq;
 
 	ccw_device_set_options(cdev, CCWDEV_DO_PATHGROUP);
@@ -497,15 +545,58 @@
 
 /*
  * Driverfs tape remove function.
+ *
+ * This function is called whenever the common I/O layer detects the device
+ * gone. This can happen at any time and we cannot refuse.
  */
 void
 tape_generic_remove(struct ccw_device *cdev)
 {
-	ccw_device_set_offline(cdev);
+	struct tape_device *	device;
+	struct tape_request *	request;
+	struct list_head *	l, *n;
+
+	device = cdev->dev.driver_data;
+	DBF_LH(3, "(%08x): tape_generic_remove(%p)\n", device->cdev_id, cdev);
+
+	/*
+	 * No more requests may be processed. So just post them as i/o errors.
+	 */
+	spin_lock_irq(get_ccwdev_lock(device->cdev));
+	list_for_each_safe(l, n, &device->req_queue) {
+		request = list_entry(l, struct tape_request, list);
+		if (request->status == TAPE_REQUEST_IN_IO)
+			request->status = TAPE_REQUEST_DONE;
+		list_del(&request->list);
+
+		/* Decrease ref_count for removed request. */
+		request->device = tape_put_device(device);
+		request->rc = -EIO;
+		if (request->callback != NULL)
+			request->callback(request, request->callback_data);
+	}
+
+	if (device->tape_state != TS_UNUSED && device->tape_state != TS_INIT) {
+		DBF_EVENT(3, "(%08x): Drive in use vanished!\n",
+			device->cdev_id);
+		PRINT_WARN("(%s): Drive in use vanished - expect trouble!\n",
+			device->cdev->dev.bus_id);
+		PRINT_WARN("State was %i\n", device->tape_state);
+		device->tape_state = TS_NOT_OPER;
+		tapeblock_cleanup_device(device);
+		tapechar_cleanup_device(device);
+		device->discipline->cleanup_device(device);
+		tape_remove_minor(device);
+	}
+	device->tape_state = TS_NOT_OPER;
+	tape_med_state_set(device, MS_UNKNOWN);
+	spin_unlock_irq(get_ccwdev_lock(device->cdev));
+
 	if (cdev->dev.driver_data != NULL) {
 		sysfs_remove_group(&cdev->dev.kobj, &tape_attr_group);
 		cdev->dev.driver_data = tape_put_device(cdev->dev.driver_data);
 	}
+
 }
 
 /*
@@ -665,7 +756,7 @@
 		op = "---";
 	DBF_EVENT(3, "DSTAT : %02x   CSTAT: %02x\n",
 		  irb->scsw.dstat,irb->scsw.cstat);
-	DBF_EVENT(3, "DEVICE: %s OP\t: %s\n", device->cdev->dev.bus_id,op);
+	DBF_EVENT(3, "DEVICE: %08x OP\t: %s\n", device->cdev_id, op);
 	sptr = (unsigned int *) irb->ecw;
 	DBF_EVENT(3, "%08x %08x\n", sptr[0], sptr[1]);
 	DBF_EVENT(3, "%08x %08x\n", sptr[2], sptr[3]);
@@ -815,7 +906,7 @@
 	spin_lock_irq(get_ccwdev_lock(device->cdev));
 	rc = __tape_halt_io(device, request);
 	if (rc == 0) {
-		DBF_EVENT(3, "IO stopped on %s\n", device->cdev->dev.bus_id);
+		DBF_EVENT(3, "IO stopped on %08x\n", device->cdev_id);
 		rc = -ERESTARTSYS;
 	}
 	spin_unlock_irq(get_ccwdev_lock(device->cdev));
@@ -823,6 +914,24 @@
 }
 
 /*
+ * Handle requests that return an i/o error in the irb.
+ */
+static inline void
+tape_handle_killed_request(
+	struct tape_device *device,
+	struct tape_request *request)
+{
+	if(request != NULL) {
+		/* Set ending status. FIXME: Should the request be retried? */
+		request->rc = -EIO;
+		request->status = TAPE_REQUEST_DONE;
+		__tape_remove_request(device, request);
+	} else {
+		__tape_do_io_list(device);
+	}
+}
+
+/*
  * Tape interrupt routine, called from the ccw_device layer
  */
 static void
@@ -835,7 +944,7 @@
 
 	device = (struct tape_device *) cdev->dev.driver_data;
 	if (device == NULL) {
-		PRINT_ERR("could not get device structure for bus_id %s "
+		PRINT_ERR("could not get device structure for %s "
 			  "in interrupt\n", cdev->dev.bus_id);
 		return;
 	}
@@ -843,6 +952,23 @@
 
 	DBF_LH(6, "__tape_do_irq(device=%p, request=%p)\n", device, request);
 
+	/* On special conditions irb is an error pointer */
+	if (IS_ERR(irb)) {
+		switch (PTR_ERR(irb)) {
+			case -ETIMEDOUT:
+				PRINT_WARN("(%s): Request timed out\n",
+					cdev->dev.bus_id);
+			case -EIO:
+				tape_handle_killed_request(device, request);
+				break;
+			default:
+				PRINT_ERR("(%s): Unexpected i/o error %li\n",
+					cdev->dev.bus_id,
+					PTR_ERR(irb));
+		}
+		return;
+	}
+
 	/* May be an unsolicited irq */
 	if(request != NULL)
 		request->rescnt = irb->scsw.count;
@@ -1023,7 +1149,7 @@
 #ifdef DBF_LIKE_HELL
 	debug_set_level(tape_dbf_area, 6);
 #endif
-	DBF_EVENT(3, "tape init: ($Revision: 1.44 $)\n");
+	DBF_EVENT(3, "tape init: ($Revision: 1.48 $)\n");
 	tape_proc_init();
 	tapechar_init ();
 	tapeblock_init ();
@@ -1048,7 +1174,7 @@
 MODULE_AUTHOR("(C) 2001 IBM Deutschland Entwicklung GmbH by Carsten Otte and "
 	      "Michael Holzheu (cotte@de.ibm.com,holzheu@de.ibm.com)");
 MODULE_DESCRIPTION("Linux on zSeries channel attached "
-		   "tape device driver ($Revision: 1.44 $)");
+		   "tape device driver ($Revision: 1.48 $)");
 MODULE_LICENSE("GPL");
 
 module_init(tape_init);
@@ -1056,9 +1182,9 @@
 
 EXPORT_SYMBOL(tape_dbf_area);
 EXPORT_SYMBOL(tape_generic_remove);
-EXPORT_SYMBOL(tape_disable_device);
 EXPORT_SYMBOL(tape_generic_probe);
-EXPORT_SYMBOL(tape_enable_device);
+EXPORT_SYMBOL(tape_generic_online);
+EXPORT_SYMBOL(tape_generic_offline);
 EXPORT_SYMBOL(tape_put_device);
 EXPORT_SYMBOL(tape_get_device_reference);
 EXPORT_SYMBOL(tape_state_verbose);
diff -urN linux-2.6/drivers/s390/char/tape_std.c linux-2.6-s390/drivers/s390/char/tape_std.c
--- linux-2.6/drivers/s390/char/tape_std.c	Thu Mar 11 03:55:20 2004
+++ linux-2.6-s390/drivers/s390/char/tape_std.c	Fri Mar 26 18:25:58 2004
@@ -42,8 +42,8 @@
 
 	spin_lock_irq(get_ccwdev_lock(device->cdev));
 	if (request->callback != NULL) {
-		DBF_EVENT(3, "%s: Assignment timeout. Device busy.\n",
-			device->cdev->dev.bus_id);
+		DBF_EVENT(3, "%08x: Assignment timeout. Device busy.\n",
+			device->cdev_id);
 		PRINT_ERR("%s: Assignment timeout. Device busy.\n",
 			device->cdev->dev.bus_id);
 		ccw_device_clear(device->cdev, (long) request);
@@ -84,10 +84,10 @@
 	if (rc != 0) {
 		PRINT_WARN("%s: assign failed - device might be busy\n",
 			device->cdev->dev.bus_id);
-		DBF_EVENT(3, "%s: assign failed - device might be busy\n",
-			device->cdev->dev.bus_id);
+		DBF_EVENT(3, "%08x: assign failed - device might be busy\n",
+			device->cdev_id);
 	} else {
-		DBF_EVENT(3, "%s: Tape assigned\n", device->cdev->dev.bus_id);
+		DBF_EVENT(3, "%08x: Tape assigned\n", device->cdev_id);
 	}
 	tape_free_request(request);
 	return rc;
@@ -102,6 +102,14 @@
 	int                  rc;
 	struct tape_request *request;
 
+	if (device->tape_state == TS_NOT_OPER) {
+		DBF_EVENT(3, "(%08x): Can't unassign device\n",
+			device->cdev_id);
+		PRINT_WARN("(%s): Can't unassign device - device gone\n",
+			device->cdev->dev.bus_id);
+		return -EIO;
+	}
+
 	request = tape_alloc_request(2, 11);
 	if (IS_ERR(request))
 		return PTR_ERR(request);
@@ -111,10 +119,10 @@
 	tape_ccw_end(request->cpaddr + 1, NOP, 0, NULL);
 
 	if ((rc = tape_do_io(device, request)) != 0) {
-		DBF_EVENT(3, "%s: Unassign failed\n", device->cdev->dev.bus_id);
+		DBF_EVENT(3, "%08x: Unassign failed\n", device->cdev_id);
 		PRINT_WARN("%s: Unassign failed\n", device->cdev->dev.bus_id);
 	} else {
-		DBF_EVENT(3, "%s: Tape unassigned\n", device->cdev->dev.bus_id);
+		DBF_EVENT(3, "%08x: Tape unassigned\n", device->cdev_id);
 	}
 	tape_free_request(request);
 	return rc;
