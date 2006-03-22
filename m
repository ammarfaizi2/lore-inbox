Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbWCVPYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbWCVPYu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWCVPYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:24:49 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:45279 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751310AbWCVPYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:24:47 -0500
Date: Wed, 22 Mar 2006 16:25:15 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, holzheu@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 19/24] s390: fix endless retry loop in tape driver.
Message-ID: <20060322152515.GS5801@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Holzheu <holzheu@de.ibm.com>

[patch 19/24] s390: fix endless retry loop in tape driver.

If a tape device is assigned to another host, the interrupt for
the assign operation comes back with deferred condition code 1.
Under some conditions this can lead to an endless loop of retries.
Check if the current request is still in IO in deferred condition
code handling and prevent retries when the request has already
been cancelled.

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/tape.h      |    1 +
 drivers/s390/char/tape_core.c |   32 +++++++++++++++++++++++++++-----
 drivers/s390/char/tape_std.c  |   15 +++++++--------
 3 files changed, 35 insertions(+), 13 deletions(-)

diff -urpN linux-2.6/drivers/s390/char/tape_core.c linux-2.6-patched/drivers/s390/char/tape_core.c
--- linux-2.6/drivers/s390/char/tape_core.c	2006-03-22 14:36:34.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/tape_core.c	2006-03-22 14:36:34.000000000 +0100
@@ -761,6 +761,13 @@ __tape_start_next_request(struct tape_de
 		 */
 		if (request->status == TAPE_REQUEST_IN_IO)
 			return;
+		/*
+		 * Request has already been stopped. We have to wait until
+		 * the request is removed from the queue in the interrupt
+		 * handling.
+		 */
+		if (request->status == TAPE_REQUEST_DONE)
+			return;
 
 		/*
 		 * We wanted to cancel the request but the common I/O layer
@@ -1024,6 +1031,20 @@ tape_do_io_interruptible(struct tape_dev
 }
 
 /*
+ * Stop running ccw.
+ */
+int
+tape_cancel_io(struct tape_device *device, struct tape_request *request)
+{
+	int rc;
+
+	spin_lock_irq(get_ccwdev_lock(device->cdev));
+	rc = __tape_cancel_io(device, request);
+	spin_unlock_irq(get_ccwdev_lock(device->cdev));
+	return rc;
+}
+
+/*
  * Tape interrupt routine, called from the ccw_device layer
  */
 static void
@@ -1068,12 +1089,12 @@ __tape_do_irq (struct ccw_device *cdev, 
 	 * error might still apply. So we just schedule the request to be
 	 * started later.
 	 */
-	if (irb->scsw.cc != 0 && (irb->scsw.fctl & SCSW_FCTL_START_FUNC)) {
-		PRINT_WARN("(%s): deferred cc=%i. restaring\n",
-			cdev->dev.bus_id,
-			irb->scsw.cc);
+	if (irb->scsw.cc != 0 && (irb->scsw.fctl & SCSW_FCTL_START_FUNC) &&
+	    (request->status == TAPE_REQUEST_IN_IO)) {
+		DBF_EVENT(3,"(%08x): deferred cc=%i, fctl=%i. restarting\n",
+			device->cdev_id, irb->scsw.cc, irb->scsw.fctl);
 		request->status = TAPE_REQUEST_QUEUED;
-		schedule_work(&device->tape_dnr);
+		schedule_delayed_work(&device->tape_dnr, HZ);
 		return;
 	}
 
@@ -1287,4 +1308,5 @@ EXPORT_SYMBOL(tape_dump_sense_dbf);
 EXPORT_SYMBOL(tape_do_io);
 EXPORT_SYMBOL(tape_do_io_async);
 EXPORT_SYMBOL(tape_do_io_interruptible);
+EXPORT_SYMBOL(tape_cancel_io);
 EXPORT_SYMBOL(tape_mtop);
diff -urpN linux-2.6/drivers/s390/char/tape.h linux-2.6-patched/drivers/s390/char/tape.h
--- linux-2.6/drivers/s390/char/tape.h	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/tape.h	2006-03-22 14:36:34.000000000 +0100
@@ -250,6 +250,7 @@ extern void tape_free_request(struct tap
 extern int tape_do_io(struct tape_device *, struct tape_request *);
 extern int tape_do_io_async(struct tape_device *, struct tape_request *);
 extern int tape_do_io_interruptible(struct tape_device *, struct tape_request *);
+extern int tape_cancel_io(struct tape_device *, struct tape_request *);
 void tape_hotplug_event(struct tape_device *, int major, int action);
 
 static inline int
diff -urpN linux-2.6/drivers/s390/char/tape_std.c linux-2.6-patched/drivers/s390/char/tape_std.c
--- linux-2.6/drivers/s390/char/tape_std.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/tape_std.c	2006-03-22 14:36:34.000000000 +0100
@@ -37,20 +37,19 @@ tape_std_assign_timeout(unsigned long da
 {
 	struct tape_request *	request;
 	struct tape_device *	device;
+	int rc;
 
 	request = (struct tape_request *) data;
 	if ((device = request->device) == NULL)
 		BUG();
 
-	spin_lock_irq(get_ccwdev_lock(device->cdev));
-	if (request->callback != NULL) {
-		DBF_EVENT(3, "%08x: Assignment timeout. Device busy.\n",
+	DBF_EVENT(3, "%08x: Assignment timeout. Device busy.\n",
 			device->cdev_id);
-		PRINT_ERR("%s: Assignment timeout. Device busy.\n",
-			device->cdev->dev.bus_id);
-		ccw_device_clear(device->cdev, (long) request);
-	}
-	spin_unlock_irq(get_ccwdev_lock(device->cdev));
+	rc = tape_cancel_io(device, request);
+	if(rc)
+		PRINT_ERR("(%s): Assign timeout: Cancel failed with rc = %i\n",
+			device->cdev->dev.bus_id, rc);
+
 }
 
 int
