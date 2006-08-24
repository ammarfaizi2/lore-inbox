Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbWHXL3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWHXL3A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 07:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWHXL3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 07:29:00 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:58089 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751137AbWHXL26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 07:28:58 -0400
Date: Thu, 24 Aug 2006 13:28:56 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, horst.hummel@de.ibm.com
Subject: [patch] s390: dasd offline processing.
Message-ID: <20060824112856.GC7022@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horst Hummel <horst.hummel@de.ibm.com>

[S390] dasd offline processing.

Fix clear_IO handling (need to wait for interrupt) and
introduced error-handling in shutdown processing.

Signed-off-by: Horst Hummel <horst.hummel@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd.c       |  192 +++++++++++++++++++++++++++-------------
 drivers/s390/block/dasd_genhd.c |   10 +-
 2 files changed, 137 insertions(+), 65 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/dasd.c linux-2.6-patched/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	2006-08-24 12:09:53.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd.c	2006-08-24 12:10:52.000000000 +0200
@@ -52,7 +52,7 @@ static void dasd_setup_queue(struct dasd
 static void dasd_free_queue(struct dasd_device * device);
 static void dasd_flush_request_queue(struct dasd_device *);
 static void dasd_int_handler(struct ccw_device *, unsigned long, struct irb *);
-static void dasd_flush_ccw_queue(struct dasd_device *, int);
+static int dasd_flush_ccw_queue(struct dasd_device *, int);
 static void dasd_tasklet(struct dasd_device *);
 static void do_kick_device(void *data);
 
@@ -60,6 +60,7 @@ static void do_kick_device(void *data);
  * SECTION: Operations on the device structure.
  */
 static wait_queue_head_t dasd_init_waitq;
+static wait_queue_head_t dasd_flush_wq;
 
 /*
  * Allocate memory for a new device structure.
@@ -121,7 +122,7 @@ dasd_free_device(struct dasd_device *dev
 /*
  * Make a new device known to the system.
  */
-static inline int
+static int
 dasd_state_new_to_known(struct dasd_device *device)
 {
 	int rc;
@@ -145,7 +146,7 @@ dasd_state_new_to_known(struct dasd_devi
 /*
  * Let the system forget about a device.
  */
-static inline void
+static int
 dasd_state_known_to_new(struct dasd_device * device)
 {
 	/* Disable extended error reporting for this device. */
@@ -163,12 +164,13 @@ dasd_state_known_to_new(struct dasd_devi
 
 	/* Give up reference we took in dasd_state_new_to_known. */
 	dasd_put_device(device);
+	return 0;
 }
 
 /*
  * Request the irq line for the device.
  */
-static inline int
+static int
 dasd_state_known_to_basic(struct dasd_device * device)
 {
 	int rc;
@@ -192,17 +194,23 @@ dasd_state_known_to_basic(struct dasd_de
 /*
  * Release the irq line for the device. Terminate any running i/o.
  */
-static inline void
+static int
 dasd_state_basic_to_known(struct dasd_device * device)
 {
+	int rc;
+
 	dasd_gendisk_free(device);
-	dasd_flush_ccw_queue(device, 1);
+	rc = dasd_flush_ccw_queue(device, 1);
+	if (rc)
+		return rc;
+
 	DBF_DEV_EVENT(DBF_EMERG, device, "%p debug area deleted", device);
 	if (device->debug_area != NULL) {
 		debug_unregister(device->debug_area);
 		device->debug_area = NULL;
 	}
 	device->state = DASD_STATE_KNOWN;
+	return 0;
 }
 
 /*
@@ -219,7 +227,7 @@ dasd_state_basic_to_known(struct dasd_de
  * In case the analysis returns an error, the device setup is stopped
  * (a fake disk was already added to allow formatting).
  */
-static inline int
+static int
 dasd_state_basic_to_ready(struct dasd_device * device)
 {
 	int rc;
@@ -247,25 +255,31 @@ dasd_state_basic_to_ready(struct dasd_de
  * Forget format information. Check if the target level is basic
  * and if it is create fake disk for formatting.
  */
-static inline void
+static int
 dasd_state_ready_to_basic(struct dasd_device * device)
 {
-	dasd_flush_ccw_queue(device, 0);
+	int rc;
+
+	rc = dasd_flush_ccw_queue(device, 0);
+	if (rc)
+		return rc;
 	dasd_destroy_partitions(device);
 	dasd_flush_request_queue(device);
 	device->blocks = 0;
 	device->bp_block = 0;
 	device->s2b_shift = 0;
 	device->state = DASD_STATE_BASIC;
+	return 0;
 }
 
 /*
  * Back to basic.
  */
-static inline void
+static int
 dasd_state_unfmt_to_basic(struct dasd_device * device)
 {
 	device->state = DASD_STATE_BASIC;
+	return 0;
 }
 
 /*
@@ -273,7 +287,7 @@ dasd_state_unfmt_to_basic(struct dasd_de
  * the requeueing of requests from the linux request queue to the
  * ccw queue.
  */
-static inline int
+static int
 dasd_state_ready_to_online(struct dasd_device * device)
 {
 	device->state = DASD_STATE_ONLINE;
@@ -284,16 +298,17 @@ dasd_state_ready_to_online(struct dasd_d
 /*
  * Stop the requeueing of requests again.
  */
-static inline void
+static int
 dasd_state_online_to_ready(struct dasd_device * device)
 {
 	device->state = DASD_STATE_READY;
+	return 0;
 }
 
 /*
  * Device startup state changes.
  */
-static inline int
+static int
 dasd_increase_state(struct dasd_device *device)
 {
 	int rc;
@@ -329,30 +344,37 @@ dasd_increase_state(struct dasd_device *
 /*
  * Device shutdown state changes.
  */
-static inline int
+static int
 dasd_decrease_state(struct dasd_device *device)
 {
+	int rc;
+
+	rc = 0;
 	if (device->state == DASD_STATE_ONLINE &&
 	    device->target <= DASD_STATE_READY)
-		dasd_state_online_to_ready(device);
+		rc = dasd_state_online_to_ready(device);
 
-	if (device->state == DASD_STATE_READY &&
+	if (!rc &&
+	    device->state == DASD_STATE_READY &&
 	    device->target <= DASD_STATE_BASIC)
-		dasd_state_ready_to_basic(device);
+		rc = dasd_state_ready_to_basic(device);
 
-	if (device->state == DASD_STATE_UNFMT &&
+	if (!rc &&
+	    device->state == DASD_STATE_UNFMT &&
 	    device->target <= DASD_STATE_BASIC)
-		dasd_state_unfmt_to_basic(device);
+		rc = dasd_state_unfmt_to_basic(device);
 
-	if (device->state == DASD_STATE_BASIC &&
+	if (!rc &&
+	    device->state == DASD_STATE_BASIC &&
 	    device->target <= DASD_STATE_KNOWN)
-		dasd_state_basic_to_known(device);
+		rc = dasd_state_basic_to_known(device);
 
-	if (device->state == DASD_STATE_KNOWN &&
+	if (!rc &&
+	    device->state == DASD_STATE_KNOWN &&
 	    device->target <= DASD_STATE_NEW)
-		dasd_state_known_to_new(device);
+		rc = dasd_state_known_to_new(device);
 
-	return 0;
+	return rc;
 }
 
 /*
@@ -701,6 +723,7 @@ dasd_term_IO(struct dasd_ccw_req * cqr)
 			cqr->retries--;
 			cqr->status = DASD_CQR_CLEAR;
 			cqr->stopclk = get_clock();
+			cqr->starttime = 0;
 			DBF_DEV_EVENT(DBF_DEBUG, device,
 				      "terminate cqr %p successful",
 				      cqr);
@@ -978,6 +1001,7 @@ dasd_int_handler(struct ccw_device *cdev
 	    irb->scsw.fctl & SCSW_FCTL_CLEAR_FUNC) {
 		cqr->status = DASD_CQR_QUEUED;
 		dasd_clear_timer(device);
+		wake_up(&dasd_flush_wq);
 		dasd_schedule_bh(device);
 		return;
 	}
@@ -1241,6 +1265,10 @@ __dasd_check_expire(struct dasd_device *
 	cqr = list_entry(device->ccw_queue.next, struct dasd_ccw_req, list);
 	if (cqr->status == DASD_CQR_IN_IO && cqr->expires != 0) {
 		if (time_after_eq(jiffies, cqr->expires + cqr->starttime)) {
+			DEV_MESSAGE(KERN_ERR, device,
+				    "internal error - timeout (%is) expired "
+				    "for cqr %p (%i retries left)",
+				    (cqr->expires/HZ), cqr, cqr->retries);
 			if (device->discipline->term_IO(cqr) != 0)
 				/* Hmpf, try again in 1/10 sec */
 				dasd_set_timer(device, 10);
@@ -1285,46 +1313,100 @@ __dasd_start_head(struct dasd_device * d
 		dasd_set_timer(device, 50);
 }
 
+static inline int
+_wait_for_clear(struct dasd_ccw_req *cqr)
+{
+	return (cqr->status == DASD_CQR_QUEUED);
+}
+
 /*
- * Remove requests from the ccw queue.
+ * Remove all requests from the ccw queue (all = '1') or only block device
+ * requests in case all = '0'.
+ * Take care of the erp-chain (chained via cqr->refers) and remove either
+ * the whole erp-chain or none of the erp-requests.
+ * If a request is currently running, term_IO is called and the request
+ * is re-queued. Prior to removing the terminated request we need to wait
+ * for the clear-interrupt.
+ * In case termination is not possible we stop processing and just finishing
+ * the already moved requests.
  */
-static void
+static int
 dasd_flush_ccw_queue(struct dasd_device * device, int all)
 {
+	struct dasd_ccw_req *cqr, *orig, *n;
+	int rc, i;
+
 	struct list_head flush_queue;
-	struct list_head *l, *n;
-	struct dasd_ccw_req *cqr;
 
 	INIT_LIST_HEAD(&flush_queue);
 	spin_lock_irq(get_ccwdev_lock(device->cdev));
-	list_for_each_safe(l, n, &device->ccw_queue) {
-		cqr = list_entry(l, struct dasd_ccw_req, list);
+	rc = 0;
+restart:
+	list_for_each_entry_safe(cqr, n, &device->ccw_queue, list) {
+		/* get original request of erp request-chain */
+		for (orig = cqr; orig->refers != NULL; orig = orig->refers);
+
 		/* Flush all request or only block device requests? */
-		if (all == 0 && cqr->callback == dasd_end_request_cb)
+		if (all == 0 && cqr->callback != dasd_end_request_cb &&
+		    orig->callback != dasd_end_request_cb) {
 			continue;
-		if (cqr->status == DASD_CQR_IN_IO)
-			device->discipline->term_IO(cqr);
-		if (cqr->status != DASD_CQR_DONE ||
-		    cqr->status != DASD_CQR_FAILED) {
-			cqr->status = DASD_CQR_FAILED;
+		}
+		/* Check status and move request to flush_queue */
+		switch (cqr->status) {
+		case DASD_CQR_IN_IO:
+			rc = device->discipline->term_IO(cqr);
+			if (rc) {
+				/* unable to terminate requeust */
+				DEV_MESSAGE(KERN_ERR, device,
+					    "dasd flush ccw_queue is unable "
+					    " to terminate request %p",
+					    cqr);
+				/* stop flush processing */
+				goto finished;
+			}
+			break;
+		case DASD_CQR_QUEUED:
+		case DASD_CQR_ERROR:
+			/* set request to FAILED */
 			cqr->stopclk = get_clock();
+			cqr->status = DASD_CQR_FAILED;
+			break;
+		default: /* do not touch the others */
+			break;
+		}
+		/* Rechain request (including erp chain) */
+		for (i = 0; cqr != NULL; cqr = cqr->refers, i++) {
+			cqr->endclk = get_clock();
+			list_move_tail(&cqr->list, &flush_queue);
+		}
+		if (i > 1)
+			/* moved more than one request - need to restart */
+			goto restart;
+	}
+
+finished:
+	spin_unlock_irq(get_ccwdev_lock(device->cdev));
+	/* Now call the callback function of flushed requests */
+restart_cb:
+	list_for_each_entry_safe(cqr, n, &flush_queue, list) {
+		if (cqr->status == DASD_CQR_CLEAR) {
+			/* wait for clear interrupt! */
+			wait_event(dasd_flush_wq, _wait_for_clear(cqr));
+			cqr->status = DASD_CQR_FAILED;
 		}
 		/* Process finished ERP request. */
 		if (cqr->refers) {
 			__dasd_process_erp(device, cqr);
-			continue;
+			/* restart list_for_xx loop since dasd_process_erp
+			 * might remove multiple elements */
+			goto restart_cb;
 		}
-		/* Rechain request on device request queue */
+		/* call the callback function */
 		cqr->endclk = get_clock();
-		list_move_tail(&cqr->list, &flush_queue);
-	}
-	spin_unlock_irq(get_ccwdev_lock(device->cdev));
-	/* Now call the callback function of flushed requests */
-	list_for_each_safe(l, n, &flush_queue) {
-		cqr = list_entry(l, struct dasd_ccw_req, list);
 		if (cqr->callback != NULL)
 			(cqr->callback)(cqr, cqr->callback_data);
 	}
+	return rc;
 }
 
 /*
@@ -1510,10 +1592,8 @@ dasd_sleep_on_interruptible(struct dasd_
 			if (device->discipline->term_IO) {
 				cqr->retries = -1;
 				device->discipline->term_IO(cqr);
-				/*nished =
-				 * wait (non-interruptible) for final status
-				 * because signal ist still pending
-				 */
+				/* wait (non-interruptible) for final status
+				 * because signal ist still pending */
 				spin_unlock_irq(get_ccwdev_lock(device->cdev));
 				wait_event(wait_q, _wait_for_wakeup(cqr));
 				spin_lock_irq(get_ccwdev_lock(device->cdev));
@@ -1546,19 +1626,11 @@ static inline int
 _dasd_term_running_cqr(struct dasd_device *device)
 {
 	struct dasd_ccw_req *cqr;
-	int rc;
 
 	if (list_empty(&device->ccw_queue))
 		return 0;
 	cqr = list_entry(device->ccw_queue.next, struct dasd_ccw_req, list);
-	rc = device->discipline->term_IO(cqr);
-	if (rc == 0) {
-		/* termination successful */
-		cqr->status = DASD_CQR_QUEUED;
-		cqr->startclk = cqr->stopclk = 0;
-		cqr->starttime = 0;
-	}
-	return rc;
+	return device->discipline->term_IO(cqr);
 }
 
 int
@@ -1726,10 +1798,7 @@ dasd_flush_request_queue(struct dasd_dev
 		return;
 
 	spin_lock_irq(&device->request_queue_lock);
-	while (!list_empty(&device->request_queue->queue_head)) {
-		req = elv_next_request(device->request_queue);
-		if (req == NULL)
-			break;
+	while ((req = elv_next_request(device->request_queue))) {
 		blkdev_dequeue_request(req);
 		dasd_end_request(req, 0);
 	}
@@ -2091,6 +2160,7 @@ dasd_init(void)
 	int rc;
 
 	init_waitqueue_head(&dasd_init_waitq);
+	init_waitqueue_head(&dasd_flush_wq);
 
 	/* register 'common' DASD debug area, used for all DBF_XXX calls */
 	dasd_debug_area = debug_register("dasd", 1, 2, 8 * sizeof (long));
diff -urpN linux-2.6/drivers/s390/block/dasd_genhd.c linux-2.6-patched/drivers/s390/block/dasd_genhd.c
--- linux-2.6/drivers/s390/block/dasd_genhd.c	2006-08-24 12:09:53.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_genhd.c	2006-08-24 12:10:52.000000000 +0200
@@ -83,10 +83,12 @@ dasd_gendisk_alloc(struct dasd_device *d
 void
 dasd_gendisk_free(struct dasd_device *device)
 {
-	del_gendisk(device->gdp);
-	device->gdp->queue = NULL;
-	put_disk(device->gdp);
-	device->gdp = NULL;
+	if (device->gdp) {
+		del_gendisk(device->gdp);
+		device->gdp->queue = NULL;
+		put_disk(device->gdp);
+		device->gdp = NULL;
+	}
 }
 
 /*
