Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262178AbVFUQoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262178AbVFUQoP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 12:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbVFUQbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 12:31:05 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:13754 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S262178AbVFUQZJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 12:25:09 -0400
Date: Tue, 21 Jun 2005 18:25:07 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, shbader@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 8/16] s390: channel tape fixes.
Message-ID: <20050621162507.GH6053@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 8/16] s390: channel tape fixes.

From: Stefan Bader <shbader@de.ibm.com>

Tape driver fixes:
 - Added deferred condition handling to tape driver core.
 - Added ability to handle busy conditions.
 - Code cleanup.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/char/tape.h      |    7 
 drivers/s390/char/tape_core.c |  299 ++++++++++++++++++++++++------------------
 2 files changed, 181 insertions(+), 125 deletions(-)

diff -urpN linux-2.6/drivers/s390/char/tape_core.c linux-2.6-patched/drivers/s390/char/tape_core.c
--- linux-2.6/drivers/s390/char/tape_core.c	2005-06-21 17:36:39.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/tape_core.c	2005-06-21 17:36:50.000000000 +0200
@@ -3,11 +3,12 @@
  *    basic function of the tape device driver
  *
  *  S390 and zSeries version
- *    Copyright (C) 2001,2002 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Copyright (C) 2001,2005 IBM Deutschland Entwicklung GmbH, IBM Corporation
  *    Author(s): Carsten Otte <cotte@de.ibm.com>
  *		 Michael Holzheu <holzheu@de.ibm.com>
  *		 Tuan Ngo-Anh <ngoanh@de.ibm.com>
  *		 Martin Schwidefsky <schwidefsky@de.ibm.com>
+ *		 Stefan Bader <shbader@de.ibm.com>
  */
 
 #include <linux/config.h>
@@ -28,7 +29,7 @@
 #define PRINTK_HEADER "TAPE_CORE: "
 
 static void __tape_do_irq (struct ccw_device *, unsigned long, struct irb *);
-static void __tape_remove_request(struct tape_device *, struct tape_request *);
+static void tape_delayed_next_request(void * data);
 
 /*
  * One list to contain all tape devices of all disciplines, so
@@ -257,7 +258,7 @@ tape_med_state_set(struct tape_device *d
  * Stop running ccw. Has to be called with the device lock held.
  */
 static inline int
-__tape_halt_io(struct tape_device *device, struct tape_request *request)
+__tape_cancel_io(struct tape_device *device, struct tape_request *request)
 {
 	int retries;
 	int rc;
@@ -270,20 +271,23 @@ __tape_halt_io(struct tape_device *devic
 	for (retries = 0; retries < 5; retries++) {
 		rc = ccw_device_clear(device->cdev, (long) request);
 
-		if (rc == 0) {                     /* Termination successful */
-			request->rc     = -EIO;
-			request->status = TAPE_REQUEST_DONE;
-			return 0;
+		switch (rc) {
+			case 0:
+				request->status	= TAPE_REQUEST_DONE;
+				return 0;
+			case -EBUSY:
+				request->status	= TAPE_REQUEST_CANCEL;
+				schedule_work(&device->tape_dnr);
+				return 0;
+			case -ENODEV:
+				DBF_EXCEPTION(2, "device gone, retry\n");
+				break;
+			case -EIO:
+				DBF_EXCEPTION(2, "I/O error, retry\n");
+				break;
+			default:
+				BUG();
 		}
-
-		if (rc == -ENODEV)
-			DBF_EXCEPTION(2, "device gone, retry\n");
-		else if (rc == -EIO)
-			DBF_EXCEPTION(2, "I/O error, retry\n");
-		else if (rc == -EBUSY)
-			DBF_EXCEPTION(2, "device busy, retry late\n");
-		else
-			BUG();
 	}
 
 	return rc;
@@ -473,6 +477,7 @@ tape_alloc_device(void)
 	*device->modeset_byte = 0;
 	device->first_minor = -1;
 	atomic_set(&device->ref_count, 1);
+	INIT_WORK(&device->tape_dnr, tape_delayed_next_request, device);
 
 	return device;
 }
@@ -708,54 +713,119 @@ tape_free_request (struct tape_request *
 	kfree(request);
 }
 
+static inline int
+__tape_start_io(struct tape_device *device, struct tape_request *request)
+{
+	int rc;
+
+#ifdef CONFIG_S390_TAPE_BLOCK
+	if (request->op == TO_BLOCK)
+		device->discipline->check_locate(device, request);
+#endif
+	rc = ccw_device_start(
+		device->cdev,
+		request->cpaddr,
+		(unsigned long) request,
+		0x00,
+		request->options
+	);
+	if (rc == 0) {
+		request->status = TAPE_REQUEST_IN_IO;
+	} else if (rc == -EBUSY) {
+		/* The common I/O subsystem is currently busy. Retry later. */
+		request->status = TAPE_REQUEST_QUEUED;
+		schedule_work(&device->tape_dnr);
+		rc = 0;
+	} else {
+		/* Start failed. Remove request and indicate failure. */
+		DBF_EVENT(1, "tape: start request failed with RC = %i\n", rc);
+	}
+	return rc;
+}
+
 static inline void
-__tape_do_io_list(struct tape_device *device)
+__tape_start_next_request(struct tape_device *device)
 {
 	struct list_head *l, *n;
 	struct tape_request *request;
 	int rc;
 
-	DBF_LH(6, "__tape_do_io_list(%p)\n", device);
+	DBF_LH(6, "__tape_start_next_request(%p)\n", device);
 	/*
 	 * Try to start each request on request queue until one is
 	 * started successful.
 	 */
 	list_for_each_safe(l, n, &device->req_queue) {
 		request = list_entry(l, struct tape_request, list);
-#ifdef CONFIG_S390_TAPE_BLOCK
-		if (request->op == TO_BLOCK)
-			device->discipline->check_locate(device, request);
-#endif
-		rc = ccw_device_start(device->cdev, request->cpaddr,
-				      (unsigned long) request, 0x00,
-				      request->options);
-		if (rc == 0) {
-			request->status = TAPE_REQUEST_IN_IO;
-			break;
+
+		/*
+		 * Avoid race condition if bottom-half was triggered more than
+		 * once.
+		 */
+		if (request->status == TAPE_REQUEST_IN_IO)
+			return;
+
+		/*
+		 * We wanted to cancel the request but the common I/O layer
+		 * was busy at that time. This can only happen if this
+		 * function is called by delayed_next_request.
+		 * Otherwise we start the next request on the queue.
+		 */
+		if (request->status == TAPE_REQUEST_CANCEL) {
+			rc = __tape_cancel_io(device, request);
+		} else {
+			rc = __tape_start_io(device, request);
 		}
-		/* Start failed. Remove request and indicate failure. */
-		DBF_EVENT(1, "tape: DOIO failed with er = %i\n", rc);
+		if (rc == 0)
+			return;
 
-		/* Set ending status and do callback. */
+		/* Set ending status. */
 		request->rc = rc;
 		request->status = TAPE_REQUEST_DONE;
-		__tape_remove_request(device, request);
+
+		/* Remove from request queue. */
+		list_del(&request->list);
+
+		/* Do callback. */
+		if (request->callback != NULL)
+			request->callback(request, request->callback_data);
 	}
 }
 
 static void
-__tape_remove_request(struct tape_device *device, struct tape_request *request)
+tape_delayed_next_request(void *data)
 {
-	/* Remove from request queue. */
-	list_del(&request->list);
+	struct tape_device *	device;
 
-	/* Do callback. */
-	if (request->callback != NULL)
-		request->callback(request, request->callback_data);
+	device = (struct tape_device *) data;
+	DBF_LH(6, "tape_delayed_next_request(%p)\n", device);
+	spin_lock_irq(get_ccwdev_lock(device->cdev));
+	__tape_start_next_request(device);
+	spin_unlock_irq(get_ccwdev_lock(device->cdev));
+}
+
+static inline void
+__tape_end_request(
+	struct tape_device *	device,
+	struct tape_request *	request,
+	int			rc)
+{
+	DBF_LH(6, "__tape_end_request(%p, %p, %i)\n", device, request, rc);
+	if (request) {
+		request->rc = rc;
+		request->status = TAPE_REQUEST_DONE;
+
+		/* Remove from request queue. */
+		list_del(&request->list);
+
+		/* Do callback. */
+		if (request->callback != NULL)
+			request->callback(request, request->callback_data);
+	}
 
 	/* Start next request. */
 	if (!list_empty(&device->req_queue))
-		__tape_do_io_list(device);
+		__tape_start_next_request(device);
 }
 
 /*
@@ -812,7 +882,7 @@ tape_dump_sense_dbf(struct tape_device *
  * the device lock held.
  */
 static inline int
-__tape_do_io(struct tape_device *device, struct tape_request *request)
+__tape_start_request(struct tape_device *device, struct tape_request *request)
 {
 	int rc;
 
@@ -837,24 +907,16 @@ __tape_do_io(struct tape_device *device,
 
 	if (list_empty(&device->req_queue)) {
 		/* No other requests are on the queue. Start this one. */
-#ifdef CONFIG_S390_TAPE_BLOCK
-		if (request->op == TO_BLOCK)
-			device->discipline->check_locate(device, request);
-#endif
-		rc = ccw_device_start(device->cdev, request->cpaddr,
-				      (unsigned long) request, 0x00,
-				      request->options);
-		if (rc) {
-			DBF_EVENT(1, "tape: DOIO failed with rc = %i\n", rc);
+		rc = __tape_start_io(device, request);
+		if (rc)
 			return rc;
-		}
+
 		DBF_LH(5, "Request %p added for execution.\n", request);
 		list_add(&request->list, &device->req_queue);
-		request->status = TAPE_REQUEST_IN_IO;
 	} else {
 		DBF_LH(5, "Request %p add to queue.\n", request);
-		list_add_tail(&request->list, &device->req_queue);
 		request->status = TAPE_REQUEST_QUEUED;
+		list_add_tail(&request->list, &device->req_queue);
 	}
 	return 0;
 }
@@ -872,7 +934,7 @@ tape_do_io_async(struct tape_device *dev
 
 	spin_lock_irq(get_ccwdev_lock(device->cdev));
 	/* Add request to request queue and try to start it. */
-	rc = __tape_do_io(device, request);
+	rc = __tape_start_request(device, request);
 	spin_unlock_irq(get_ccwdev_lock(device->cdev));
 	return rc;
 }
@@ -901,7 +963,7 @@ tape_do_io(struct tape_device *device, s
 	request->callback = __tape_wake_up;
 	request->callback_data = &wq;
 	/* Add request to request queue and try to start it. */
-	rc = __tape_do_io(device, request);
+	rc = __tape_start_request(device, request);
 	spin_unlock_irq(get_ccwdev_lock(device->cdev));
 	if (rc)
 		return rc;
@@ -935,7 +997,7 @@ tape_do_io_interruptible(struct tape_dev
 	/* Setup callback */
 	request->callback = __tape_wake_up_interruptible;
 	request->callback_data = &wq;
-	rc = __tape_do_io(device, request);
+	rc = __tape_start_request(device, request);
 	spin_unlock_irq(get_ccwdev_lock(device->cdev));
 	if (rc)
 		return rc;
@@ -944,36 +1006,27 @@ tape_do_io_interruptible(struct tape_dev
 	if (rc != -ERESTARTSYS)
 		/* Request finished normally. */
 		return request->rc;
+
 	/* Interrupted by a signal. We have to stop the current request. */
 	spin_lock_irq(get_ccwdev_lock(device->cdev));
-	rc = __tape_halt_io(device, request);
+	rc = __tape_cancel_io(device, request);
+	spin_unlock_irq(get_ccwdev_lock(device->cdev));
 	if (rc == 0) {
+		/* Wait for the interrupt that acknowledges the halt. */
+		do {
+			rc = wait_event_interruptible(
+				wq,
+				(request->callback == NULL)
+			);
+		} while (rc != -ERESTARTSYS);
+
 		DBF_EVENT(3, "IO stopped on %08x\n", device->cdev_id);
 		rc = -ERESTARTSYS;
 	}
-	spin_unlock_irq(get_ccwdev_lock(device->cdev));
 	return rc;
 }
 
 /*
- * Handle requests that return an i/o error in the irb.
- */
-static inline void
-tape_handle_killed_request(
-	struct tape_device *device,
-	struct tape_request *request)
-{
-	if(request != NULL) {
-		/* Set ending status. FIXME: Should the request be retried? */
-		request->rc = -EIO;
-		request->status = TAPE_REQUEST_DONE;
-		__tape_remove_request(device, request);
-	} else {
-		__tape_do_io_list(device);
-	}
-}
-
-/*
  * Tape interrupt routine, called from the ccw_device layer
  */
 static void
@@ -981,7 +1034,6 @@ __tape_do_irq (struct ccw_device *cdev, 
 {
 	struct tape_device *device;
 	struct tape_request *request;
-	int final;
 	int rc;
 
 	device = (struct tape_device *) cdev->dev.driver_data;
@@ -996,12 +1048,13 @@ __tape_do_irq (struct ccw_device *cdev, 
 
 	/* On special conditions irb is an error pointer */
 	if (IS_ERR(irb)) {
+		/* FIXME: What to do with the request? */
 		switch (PTR_ERR(irb)) {
 			case -ETIMEDOUT:
 				PRINT_WARN("(%s): Request timed out\n",
 					cdev->dev.bus_id);
 			case -EIO:
-				tape_handle_killed_request(device, request);
+				__tape_end_request(device, request, -EIO);
 				break;
 			default:
 				PRINT_ERR("(%s): Unexpected i/o error %li\n",
@@ -1011,6 +1064,21 @@ __tape_do_irq (struct ccw_device *cdev, 
 		return;
 	}
 
+	/*
+	 * If the condition code is not zero and the start function bit is
+	 * still set, this is an deferred error and the last start I/O did
+	 * not succeed. Restart the request now.
+	 */
+	if (irb->scsw.cc != 0 && (irb->scsw.fctl & SCSW_FCTL_START_FUNC)) {
+		PRINT_WARN("(%s): deferred cc=%i. restaring\n",
+			cdev->dev.bus_id,
+			irb->scsw.cc);
+		rc = __tape_start_io(device, request);
+		if (rc)
+			__tape_end_request(device, request, rc);
+		return;
+	}
+
 	/* May be an unsolicited irq */
 	if(request != NULL)
 		request->rescnt = irb->scsw.count;
@@ -1042,7 +1110,7 @@ __tape_do_irq (struct ccw_device *cdev, 
 	 * To detect these request the state will be set to TAPE_REQUEST_DONE.
 	 */
 	if(request != NULL && request->status == TAPE_REQUEST_DONE) {
-		__tape_remove_request(device, request);
+		__tape_end_request(device, request, -EIO);
 		return;
 	}
 
@@ -1054,51 +1122,34 @@ __tape_do_irq (struct ccw_device *cdev, 
 	 * rc == TAPE_IO_RETRY: request finished but needs another go.
 	 * rc == TAPE_IO_STOP: request needs to get terminated.
 	 */
-	final = 0;
 	switch (rc) {
-	case TAPE_IO_SUCCESS:
-		/* Upon normal completion the device _is_ online */
-		device->tape_generic_status |= GMT_ONLINE(~0);
-		final = 1;
-		break;
-	case TAPE_IO_PENDING:
-		break;
-	case TAPE_IO_RETRY:
-#ifdef CONFIG_S390_TAPE_BLOCK
-		if (request->op == TO_BLOCK)
-			device->discipline->check_locate(device, request);
-#endif
-		rc = ccw_device_start(cdev, request->cpaddr,
-				      (unsigned long) request, 0x00,
-				      request->options);
-		if (rc) {
-			DBF_EVENT(1, "tape: DOIO failed with er = %i\n", rc);
-			final = 1;
-		}
-		break;
-	case TAPE_IO_STOP:
-		__tape_halt_io(device, request);
-		break;
-	default:
-		if (rc > 0) {
-			DBF_EVENT(6, "xunknownrc\n");
-			PRINT_ERR("Invalid return code from discipline "
-				  "interrupt function.\n");
-			rc = -EIO;
-		}
-		final = 1;
-		break;
-	}
-	if (final) {
-		/* May be an unsolicited irq */
-		if(request != NULL) {
-			/* Set ending status. */
-			request->rc = rc;
-			request->status = TAPE_REQUEST_DONE;
-			__tape_remove_request(device, request);
-		} else {
-			__tape_do_io_list(device);
-		}
+		case TAPE_IO_SUCCESS:
+			/* Upon normal completion the device _is_ online */
+			device->tape_generic_status |= GMT_ONLINE(~0);
+			__tape_end_request(device, request, rc);
+			break;
+		case TAPE_IO_PENDING:
+			break;
+		case TAPE_IO_RETRY:
+			rc = __tape_start_io(device, request);
+			if (rc)
+				__tape_end_request(device, request, rc);
+			break;
+		case TAPE_IO_STOP:
+			rc = __tape_cancel_io(device, request);
+			if (rc)
+				__tape_end_request(device, request, rc);
+			break;
+		default:
+			if (rc > 0) {
+				DBF_EVENT(6, "xunknownrc\n");
+				PRINT_ERR("Invalid return code from discipline "
+				  	"interrupt function.\n");
+				__tape_end_request(device, request, -EIO);
+			} else {
+				__tape_end_request(device, request, rc);
+			}
+			break;
 	}
 }
 
@@ -1191,7 +1242,7 @@ tape_init (void)
 #ifdef DBF_LIKE_HELL
 	debug_set_level(TAPE_DBF_AREA, 6);
 #endif
-	DBF_EVENT(3, "tape init: ($Revision: 1.51 $)\n");
+	DBF_EVENT(3, "tape init: ($Revision: 1.54 $)\n");
 	tape_proc_init();
 	tapechar_init ();
 	tapeblock_init ();
@@ -1216,7 +1267,7 @@ tape_exit(void)
 MODULE_AUTHOR("(C) 2001 IBM Deutschland Entwicklung GmbH by Carsten Otte and "
 	      "Michael Holzheu (cotte@de.ibm.com,holzheu@de.ibm.com)");
 MODULE_DESCRIPTION("Linux on zSeries channel attached "
-		   "tape device driver ($Revision: 1.51 $)");
+		   "tape device driver ($Revision: 1.54 $)");
 MODULE_LICENSE("GPL");
 
 module_init(tape_init);
diff -urpN linux-2.6/drivers/s390/char/tape.h linux-2.6-patched/drivers/s390/char/tape.h
--- linux-2.6/drivers/s390/char/tape.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/tape.h	2005-06-21 17:36:50.000000000 +0200
@@ -3,10 +3,11 @@
  *    tape device driver for 3480/3490E/3590 tapes.
  *
  *  S390 and zSeries version
- *    Copyright (C) 2001,2002 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Copyright (C) 2001,2005 IBM Deutschland Entwicklung GmbH, IBM Corporation
  *    Author(s): Carsten Otte <cotte@de.ibm.com>
  *		 Tuan Ngo-Anh <ngoanh@de.ibm.com>
  *		 Martin Schwidefsky <schwidefsky@de.ibm.com>
+ *		 Stefan Bader <shbader@de.ibm.com>
  */
 
 #ifndef _TAPE_H
@@ -111,6 +112,7 @@ enum tape_request_status {
 	TAPE_REQUEST_QUEUED,	/* request is queued to be processed */
 	TAPE_REQUEST_IN_IO,	/* request is currently in IO */
 	TAPE_REQUEST_DONE,	/* request is completed. */
+	TAPE_REQUEST_CANCEL,	/* request should be canceled. */
 };
 
 /* Tape CCW request */
@@ -237,6 +239,9 @@ struct tape_device {
 	/* Block dev frontend data */
 	struct tape_blk_data		blk_data;
 #endif
+
+	/* Function to start or stop the next request later. */
+	struct work_struct		tape_dnr;
 };
 
 /* Externals from tape_core.c */
