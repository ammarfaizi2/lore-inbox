Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbUDHOaV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 10:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbUDHOaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 10:30:00 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:10487 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S261784AbUDHO2p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 10:28:45 -0400
Date: Thu, 8 Apr 2004 16:28:33 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (3/12): tape driver fixes.
Message-ID: <20040408142833.GD1793@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tape driver changes:
 - Add missing break in tape_34xx_work_handler to avoid misleading message.
 - Cleanup offline/remove code.

diffstat:
 drivers/s390/char/tape_34xx.c  |    5 +
 drivers/s390/char/tape_class.c |    6 +-
 drivers/s390/char/tape_core.c  |  112 ++++++++++++++++++++++++++---------------
 3 files changed, 78 insertions(+), 45 deletions(-)

diff -urN linux-2.6/drivers/s390/char/tape_34xx.c linux-2.6-s390/drivers/s390/char/tape_34xx.c
--- linux-2.6/drivers/s390/char/tape_34xx.c	Sun Apr  4 05:36:56 2004
+++ linux-2.6-s390/drivers/s390/char/tape_34xx.c	Thu Apr  8 15:21:25 2004
@@ -113,6 +113,7 @@
 	switch(p->op) {
 		case TO_MSEN:
 			tape_34xx_medium_sense(p->device);
+			break;
 		default:
 			DBF_EVENT(3, "T34XX: internal error: unknown work\n");
 	}
@@ -1342,7 +1343,7 @@
 {
 	int rc;
 
-	DBF_EVENT(3, "34xx init: $Revision: 1.19 $\n");
+	DBF_EVENT(3, "34xx init: $Revision: 1.20 $\n");
 	/* Register driver for 3480/3490 tapes. */
 	rc = ccw_driver_register(&tape_34xx_driver);
 	if (rc)
@@ -1361,7 +1362,7 @@
 MODULE_DEVICE_TABLE(ccw, tape_34xx_ids);
 MODULE_AUTHOR("(C) 2001-2002 IBM Deutschland Entwicklung GmbH");
 MODULE_DESCRIPTION("Linux on zSeries channel attached 3480 tape "
-		   "device driver ($Revision: 1.19 $)");
+		   "device driver ($Revision: 1.20 $)");
 MODULE_LICENSE("GPL");
 
 module_init(tape_34xx_init);
diff -urN linux-2.6/drivers/s390/char/tape_class.c linux-2.6-s390/drivers/s390/char/tape_class.c
--- linux-2.6/drivers/s390/char/tape_class.c	Sun Apr  4 05:38:16 2004
+++ linux-2.6-s390/drivers/s390/char/tape_class.c	Thu Apr  8 15:21:25 2004
@@ -1,6 +1,6 @@
 /*
  * (C) Copyright IBM Corp. 2004
- * tape_class.c ($Revision: 1.6 $)
+ * tape_class.c ($Revision: 1.8 $)
  *
  * Tape class device support
  *
@@ -12,7 +12,7 @@
 MODULE_AUTHOR("Stefan Bader <shbader@de.ibm.com>");
 MODULE_DESCRIPTION(
 	"(C) Copyright IBM Corp. 2004   All Rights Reserved.\n"
-	"tape_class.c ($Revision: 1.6 $)"
+	"tape_class.c ($Revision: 1.8 $)"
 );
 MODULE_LICENSE("GPL");
 
@@ -85,7 +85,7 @@
 	return tcd;
 
 fail_with_cdev:
-	cdev_del(&tcd->char_device);
+	cdev_del(tcd->char_device);
 
 fail_with_tcd:
 	kfree(tcd);
diff -urN linux-2.6/drivers/s390/char/tape_core.c linux-2.6-s390/drivers/s390/char/tape_core.c
--- linux-2.6/drivers/s390/char/tape_core.c	Sun Apr  4 05:36:47 2004
+++ linux-2.6-s390/drivers/s390/char/tape_core.c	Thu Apr  8 15:21:25 2004
@@ -377,6 +377,16 @@
 	return rc;
 }
 
+static inline void
+tape_cleanup_device(struct tape_device *device)
+{
+	tapeblock_cleanup_device(device);
+	tapechar_cleanup_device(device);
+	device->discipline->cleanup_device(device);
+	tape_remove_minor(device);
+	tape_med_state_set(device, MS_UNKNOWN);
+}
+
 /*
  * Set device offline.
  *
@@ -399,12 +409,13 @@
 	switch (device->tape_state) {
 		case TS_INIT:
 		case TS_NOT_OPER:
+			spin_unlock_irq(get_ccwdev_lock(device->cdev));
 			break;
 		case TS_UNUSED:
-			tapeblock_cleanup_device(device);
-			tapechar_cleanup_device(device);
-			device->discipline->cleanup_device(device);
-			tape_remove_minor(device);
+			tape_state_set(device, TS_INIT);
+			spin_unlock_irq(get_ccwdev_lock(device->cdev));
+			tape_cleanup_device(device);
+			break;
 		default:
 			DBF_EVENT(3, "(%08x): Set offline failed "
 				"- drive in use.\n",
@@ -415,9 +426,6 @@
 			spin_unlock_irq(get_ccwdev_lock(device->cdev));
 			return -EBUSY;
 	}
-	spin_unlock_irq(get_ccwdev_lock(device->cdev));
-
-	tape_med_state_set(device, MS_UNKNOWN);
 
 	DBF_LH(3, "(%08x): Drive set offline.\n", device->cdev_id);
 	return 0;
@@ -543,26 +551,12 @@
 	return 0;
 }
 
-/*
- * Driverfs tape remove function.
- *
- * This function is called whenever the common I/O layer detects the device
- * gone. This can happen at any time and we cannot refuse.
- */
-void
-tape_generic_remove(struct ccw_device *cdev)
+static inline void
+__tape_discard_requests(struct tape_device *device)
 {
-	struct tape_device *	device;
 	struct tape_request *	request;
 	struct list_head *	l, *n;
 
-	device = cdev->dev.driver_data;
-	DBF_LH(3, "(%08x): tape_generic_remove(%p)\n", device->cdev_id, cdev);
-
-	/*
-	 * No more requests may be processed. So just post them as i/o errors.
-	 */
-	spin_lock_irq(get_ccwdev_lock(device->cdev));
 	list_for_each_safe(l, n, &device->req_queue) {
 		request = list_entry(l, struct tape_request, list);
 		if (request->status == TAPE_REQUEST_IN_IO)
@@ -575,28 +569,66 @@
 		if (request->callback != NULL)
 			request->callback(request, request->callback_data);
 	}
+}
 
-	if (device->tape_state != TS_UNUSED && device->tape_state != TS_INIT) {
-		DBF_EVENT(3, "(%08x): Drive in use vanished!\n",
-			device->cdev_id);
-		PRINT_WARN("(%s): Drive in use vanished - expect trouble!\n",
-			device->cdev->dev.bus_id);
-		PRINT_WARN("State was %i\n", device->tape_state);
-		device->tape_state = TS_NOT_OPER;
-		tapeblock_cleanup_device(device);
-		tapechar_cleanup_device(device);
-		device->discipline->cleanup_device(device);
-		tape_remove_minor(device);
+/*
+ * Driverfs tape remove function.
+ *
+ * This function is called whenever the common I/O layer detects the device
+ * gone. This can happen at any time and we cannot refuse.
+ */
+void
+tape_generic_remove(struct ccw_device *cdev)
+{
+	struct tape_device *	device;
+
+	device = cdev->dev.driver_data;
+	if (!device) {
+		PRINT_ERR("No device pointer in tape_generic_remove!\n");
+		return;
+	}
+	DBF_LH(3, "(%08x): tape_generic_remove(%p)\n", device->cdev_id, cdev);
+
+	spin_lock_irq(get_ccwdev_lock(device->cdev));
+	switch (device->tape_state) {
+		case TS_INIT:
+			tape_state_set(device, TS_NOT_OPER);
+		case TS_NOT_OPER:
+			/*
+			 * Nothing to do.
+			 */
+			spin_unlock_irq(get_ccwdev_lock(device->cdev));
+			break;
+		case TS_UNUSED:
+			/*
+			 * Need only to release the device.
+			 */
+			tape_state_set(device, TS_NOT_OPER);
+			spin_unlock_irq(get_ccwdev_lock(device->cdev));
+			tape_cleanup_device(device);
+			break;
+		default:
+			/*
+			 * There may be requests on the queue. We will not get
+			 * an interrupt for a request that was running. So we
+			 * just post them all as I/O errors.
+			 */
+			DBF_EVENT(3, "(%08x): Drive in use vanished!\n",
+				device->cdev_id);
+			PRINT_WARN("(%s): Drive in use vanished - "
+				"expect trouble!\n",
+				device->cdev->dev.bus_id);
+			PRINT_WARN("State was %i\n", device->tape_state);
+			tape_state_set(device, TS_NOT_OPER);
+			__tape_discard_requests(device);
+			spin_unlock_irq(get_ccwdev_lock(device->cdev));
+			tape_cleanup_device(device);
 	}
-	device->tape_state = TS_NOT_OPER;
-	tape_med_state_set(device, MS_UNKNOWN);
-	spin_unlock_irq(get_ccwdev_lock(device->cdev));
 
 	if (cdev->dev.driver_data != NULL) {
 		sysfs_remove_group(&cdev->dev.kobj, &tape_attr_group);
 		cdev->dev.driver_data = tape_put_device(cdev->dev.driver_data);
 	}
-
 }
 
 /*
@@ -1149,7 +1181,7 @@
 #ifdef DBF_LIKE_HELL
 	debug_set_level(tape_dbf_area, 6);
 #endif
-	DBF_EVENT(3, "tape init: ($Revision: 1.48 $)\n");
+	DBF_EVENT(3, "tape init: ($Revision: 1.49 $)\n");
 	tape_proc_init();
 	tapechar_init ();
 	tapeblock_init ();
@@ -1174,7 +1206,7 @@
 MODULE_AUTHOR("(C) 2001 IBM Deutschland Entwicklung GmbH by Carsten Otte and "
 	      "Michael Holzheu (cotte@de.ibm.com,holzheu@de.ibm.com)");
 MODULE_DESCRIPTION("Linux on zSeries channel attached "
-		   "tape device driver ($Revision: 1.48 $)");
+		   "tape device driver ($Revision: 1.49 $)");
 MODULE_LICENSE("GPL");
 
 module_init(tape_init);
