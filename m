Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750900AbWH3MnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbWH3MnL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 08:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbWH3MnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 08:43:11 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:62481 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750900AbWH3MnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 08:43:08 -0400
Date: Wed, 30 Aug 2006 14:43:05 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org, gregkh@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Please pull git390 'for-linus' branch
Message-ID: <20060830124305.GD22276@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from 'for-linus' branch of

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

 arch/s390/lib/uaccess.S         |   33 +++---
 arch/s390/lib/uaccess64.S       |   35 +++----
 drivers/s390/block/dasd.c       |  192 +++++++++++++++++++++++++++-------------
 drivers/s390/block/dasd_genhd.c |   10 +-
 drivers/s390/cio/ccwgroup.c     |   14 +-
 drivers/s390/cio/chsc.c         |   10 --
 drivers/s390/cio/device.c       |   19 +--
 drivers/s390/cio/device_fsm.c   |   20 +---
 drivers/s390/cio/device_pgid.c  |   27 ++++-
 9 files changed, 217 insertions(+), 143 deletions(-)

Heiko Carstens:
      [S390] cio: kernel stack overflow.

Horst Hummel:
      [S390] dasd: fix device shutdown process.

Martin Schwidefsky:
      [S390] broken copy_in_user function.

Peter Oberparleiter:
      [S390] cio: no path after machine check.

Stefan Bader:
      [S390] cio: unsolicited interrupts during sense pgid.

diff --git a/arch/s390/lib/uaccess.S b/arch/s390/lib/uaccess.S
index 5d59e26..8372752 100644
--- a/arch/s390/lib/uaccess.S
+++ b/arch/s390/lib/uaccess.S
@@ -88,30 +88,31 @@ __copy_to_user_asm:
         .globl __copy_in_user_asm
 	# %r2 = from, %r3 = n, %r4 = to
 __copy_in_user_asm:
+	ahi	%r3,-1
+	jo	6f
 	sacf	256
-	bras	1,1f
-	mvc	0(1,%r4),0(%r2)
-0:	mvc	0(256,%r4),0(%r2)
-	la	%r2,256(%r2)
-	la	%r4,256(%r4)
-1:	ahi	%r3,-256
-	jnm	0b
-2:	ex	%r3,0(%r1)
-	sacf	0
-	slr	%r2,%r2
-	br	14
-3:	mvc	0(1,%r4),0(%r2)
+	bras	%r1,4f
+0:	ahi	%r3,257
+1:	mvc	0(1,%r4),0(%r2)
 	la	%r2,1(%r2)
 	la	%r4,1(%r4)
 	ahi	%r3,-1
+	jnz	1b
+2:	lr	%r2,%r3
+	br	%r14
+3:	mvc	0(256,%r4),0(%r2)
+	la	%r2,256(%r2)
+	la	%r4,256(%r4)
+4:	ahi	%r3,-256
 	jnm	3b
-4:	lr	%r2,%r3
+5:	ex	%r3,4(%r1)
 	sacf	0
+6:	slr	%r2,%r2
 	br	%r14
         .section __ex_table,"a"
-	.long	0b,3b
-	.long	2b,3b
-	.long	3b,4b
+	.long	1b,2b
+	.long	3b,0b
+	.long	5b,0b
         .previous
 
         .align 4
diff --git a/arch/s390/lib/uaccess64.S b/arch/s390/lib/uaccess64.S
index 19b41a3..1f755be 100644
--- a/arch/s390/lib/uaccess64.S
+++ b/arch/s390/lib/uaccess64.S
@@ -88,30 +88,31 @@ __copy_to_user_asm:
         .globl __copy_in_user_asm
 	# %r2 = from, %r3 = n, %r4 = to
 __copy_in_user_asm:
+	aghi	%r3,-1
+	jo	6f
 	sacf	256
-	bras	1,1f
-	mvc	0(1,%r4),0(%r2)
-0:	mvc	0(256,%r4),0(%r2)
-	la	%r2,256(%r2)
-	la	%r4,256(%r4)
-1:	aghi	%r3,-256
-	jnm	0b
-2:	ex	%r3,0(%r1)
-	sacf	0
-	slgr	%r2,%r2
-	br	14
-3:	mvc	0(1,%r4),0(%r2)
+	bras	%r1,4f
+0:	aghi	%r3,257
+1:	mvc	0(1,%r4),0(%r2)
 	la	%r2,1(%r2)
 	la	%r4,1(%r4)
 	aghi	%r3,-1
+	jnz	1b
+2:	lgr	%r2,%r3
+	br	%r14
+3:	mvc	0(256,%r4),0(%r2)
+	la	%r2,256(%r2)
+	la	%r4,256(%r4)
+4:	aghi	%r3,-256
 	jnm	3b
-4:	lgr	%r2,%r3
+5:	ex	%r3,4(%r1)
 	sacf	0
-	br	%r14
+6:	slgr	%r2,%r2
+	br	14
         .section __ex_table,"a"
-	.quad	0b,3b
-	.quad	2b,3b
-	.quad	3b,4b
+	.quad	1b,2b
+	.quad	3b,0b
+	.quad	5b,0b
         .previous
 
         .align 4
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index d8e9b95..25c1ef6 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
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
diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index 4c272b7..d163632 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
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
diff --git a/drivers/s390/cio/ccwgroup.c b/drivers/s390/cio/ccwgroup.c
index 3cba6c9..38954f5 100644
--- a/drivers/s390/cio/ccwgroup.c
+++ b/drivers/s390/cio/ccwgroup.c
@@ -183,11 +183,9 @@ ccwgroup_create(struct device *root,
 
 	gdev->creator_id = creator_id;
 	gdev->count = argc;
-	gdev->dev = (struct device ) {
-		.bus = &ccwgroup_bus_type,
-		.parent = root,
-		.release = ccwgroup_release,
-	};
+	gdev->dev.bus = &ccwgroup_bus_type;
+	gdev->dev.parent = root;
+	gdev->dev.release = ccwgroup_release;
 
 	snprintf (gdev->dev.bus_id, BUS_ID_SIZE, "%s",
 			gdev->cdev[0]->dev.bus_id);
@@ -391,10 +389,8 @@ int
 ccwgroup_driver_register (struct ccwgroup_driver *cdriver)
 {
 	/* register our new driver with the core */
-	cdriver->driver = (struct device_driver) {
-		.bus = &ccwgroup_bus_type,
-		.name = cdriver->name,
-	};
+	cdriver->driver.bus = &ccwgroup_bus_type;
+	cdriver->driver.name = cdriver->name;
 
 	return driver_register(&cdriver->driver);
 }
diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
index 61ce3f1..c28444a 100644
--- a/drivers/s390/cio/chsc.c
+++ b/drivers/s390/cio/chsc.c
@@ -238,8 +238,6 @@ s390_subchannel_remove_chpid(struct devi
 	/* Check for single path devices. */
 	if (sch->schib.pmcw.pim == 0x80)
 		goto out_unreg;
-	if (sch->vpm == mask)
-		goto out_unreg;
 
 	if ((sch->schib.scsw.actl & SCSW_ACTL_DEVACT) &&
 	    (sch->schib.scsw.actl & SCSW_ACTL_SCHACT) &&
@@ -258,6 +256,8 @@ s390_subchannel_remove_chpid(struct devi
 	/* trigger path verification. */
 	if (sch->driver && sch->driver->verify)
 		sch->driver->verify(&sch->dev);
+	else if (sch->vpm == mask)
+		goto out_unreg;
 out_unlock:
 	spin_unlock_irq(&sch->lock);
 	return 0;
@@ -1391,10 +1391,8 @@ new_channel_path(int chpid)
 	/* fill in status, etc. */
 	chp->id = chpid;
 	chp->state = 1;
-	chp->dev = (struct device) {
-		.parent  = &css[0]->device,
-		.release = chp_release,
-	};
+	chp->dev.parent = &css[0]->device;
+	chp->dev.release = chp_release;
 	snprintf(chp->dev.bus_id, BUS_ID_SIZE, "chp0.%x", chpid);
 
 	/* Obtain channel path description and fill it in. */
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 585fa04..646da56 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -556,12 +556,11 @@ get_disc_ccwdev_by_devno(unsigned int de
 			 struct ccw_device *sibling)
 {
 	struct device *dev;
-	struct match_data data = {
-		.devno   = devno,
-		.ssid    = ssid,
-		.sibling = sibling,
-	};
+	struct match_data data;
 
+	data.devno = devno;
+	data.ssid = ssid;
+	data.sibling = sibling;
 	dev = bus_find_device(&ccw_bus_type, NULL, &data, match_devno);
 
 	return dev ? to_ccwdev(dev) : NULL;
@@ -835,10 +834,8 @@ io_subchannel_probe (struct subchannel *
 		return -ENOMEM;
 	}
 	atomic_set(&cdev->private->onoff, 0);
-	cdev->dev = (struct device) {
-		.parent = &sch->dev,
-		.release = ccw_device_release,
-	};
+	cdev->dev.parent = &sch->dev;
+	cdev->dev.release = ccw_device_release;
 	INIT_LIST_HEAD(&cdev->private->kick_work.entry);
 	/* Do first half of device_register. */
 	device_initialize(&cdev->dev);
@@ -977,9 +974,7 @@ ccw_device_console_enable (struct ccw_de
 	int rc;
 
 	/* Initialize the ccw_device structure. */
-	cdev->dev = (struct device) {
-		.parent = &sch->dev,
-	};
+	cdev->dev.parent= &sch->dev;
 	rc = io_subchannel_recog(cdev, sch);
 	if (rc)
 		return rc;
diff --git a/drivers/s390/cio/device_fsm.c b/drivers/s390/cio/device_fsm.c
index 6d91c2e..35e162b 100644
--- a/drivers/s390/cio/device_fsm.c
+++ b/drivers/s390/cio/device_fsm.c
@@ -267,12 +267,10 @@ ccw_device_recog_done(struct ccw_device 
 			notify = 1;
 		}
 		/* fill out sense information */
-		cdev->id = (struct ccw_device_id) {
-			.cu_type   = cdev->private->senseid.cu_type,
-			.cu_model  = cdev->private->senseid.cu_model,
-			.dev_type  = cdev->private->senseid.dev_type,
-			.dev_model = cdev->private->senseid.dev_model,
-		};
+		cdev->id.cu_type   = cdev->private->senseid.cu_type;
+		cdev->id.cu_model  = cdev->private->senseid.cu_model;
+		cdev->id.dev_type  = cdev->private->senseid.dev_type;
+		cdev->id.dev_model = cdev->private->senseid.dev_model;
 		if (notify) {
 			cdev->private->state = DEV_STATE_OFFLINE;
 			if (same_dev) {
@@ -566,12 +564,10 @@ ccw_device_verify_done(struct ccw_device
 		/* Deliver fake irb to device driver, if needed. */
 		if (cdev->private->flags.fake_irb) {
 			memset(&cdev->private->irb, 0, sizeof(struct irb));
-			cdev->private->irb.scsw = (struct scsw) {
-				.cc = 1,
-				.fctl = SCSW_FCTL_START_FUNC,
-				.actl = SCSW_ACTL_START_PEND,
-				.stctl = SCSW_STCTL_STATUS_PEND,
-			};
+			cdev->private->irb.scsw.cc = 1;
+			cdev->private->irb.scsw.fctl = SCSW_FCTL_START_FUNC;
+			cdev->private->irb.scsw.actl = SCSW_ACTL_START_PEND;
+			cdev->private->irb.scsw.stctl = SCSW_STCTL_STATUS_PEND;
 			cdev->private->flags.fake_irb = 0;
 			if (cdev->handler)
 				cdev->handler(cdev, cdev->private->intparm,
diff --git a/drivers/s390/cio/device_pgid.c b/drivers/s390/cio/device_pgid.c
index 32610fd..1693a10 100644
--- a/drivers/s390/cio/device_pgid.c
+++ b/drivers/s390/cio/device_pgid.c
@@ -24,6 +24,21 @@ #include "device.h"
 #include "ioasm.h"
 
 /*
+ * Helper function called from interrupt context to decide whether an
+ * operation should be tried again.
+ */
+static int __ccw_device_should_retry(struct scsw *scsw)
+{
+	/* CC is only valid if start function bit is set. */
+	if ((scsw->fctl & SCSW_FCTL_START_FUNC) && scsw->cc == 1)
+		return 1;
+	/* No more activity. For sense and set PGID we stubbornly try again. */
+	if (!scsw->actl)
+		return 1;
+	return 0;
+}
+
+/*
  * Start Sense Path Group ID helper function. Used in ccw_device_recog
  * and ccw_device_sense_pgid.
  */
@@ -155,10 +170,10 @@ ccw_device_sense_pgid_irq(struct ccw_dev
 	int ret;
 
 	irb = (struct irb *) __LC_IRB;
-	/* Retry sense pgid for cc=1. */
+
 	if (irb->scsw.stctl ==
 	    (SCSW_STCTL_STATUS_PEND | SCSW_STCTL_ALERT_STATUS)) {
-		if (irb->scsw.cc == 1) {
+		if (__ccw_device_should_retry(&irb->scsw)) {
 			ret = __ccw_device_sense_pgid_start(cdev);
 			if (ret && ret != -EBUSY)
 				ccw_device_sense_pgid_done(cdev, ret);
@@ -391,10 +406,10 @@ ccw_device_verify_irq(struct ccw_device 
 	int ret;
 
 	irb = (struct irb *) __LC_IRB;
-	/* Retry set pgid for cc=1. */
+
 	if (irb->scsw.stctl ==
 	    (SCSW_STCTL_STATUS_PEND | SCSW_STCTL_ALERT_STATUS)) {
-		if (irb->scsw.cc == 1)
+		if (__ccw_device_should_retry(&irb->scsw))
 			__ccw_device_verify_start(cdev);
 		return;
 	}
@@ -494,10 +509,10 @@ ccw_device_disband_irq(struct ccw_device
 	int ret;
 
 	irb = (struct irb *) __LC_IRB;
-	/* Retry set pgid for cc=1. */
+
 	if (irb->scsw.stctl ==
 	    (SCSW_STCTL_STATUS_PEND | SCSW_STCTL_ALERT_STATUS)) {
-		if (irb->scsw.cc == 1)
+		if (__ccw_device_should_retry(&irb->scsw))
 			__ccw_device_disband_start(cdev);
 		return;
 	}
