Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264495AbTF0O5C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 10:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264486AbTF0O4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 10:56:08 -0400
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:14747 "EHLO
	d12lmsgate-4.de.ibm.com") by vger.kernel.org with ESMTP
	id S264465AbTF0Ox1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 10:53:27 -0400
Date: Fri, 27 Jun 2003 17:06:29 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (4/7): dasd driver.
Message-ID: <20030627150629.GE3591@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Simplify long busy condition handling, add quiesce/resume ioctl.
- Add sense data area to reserve/release/steal_lock ccw-chains.

diffstat:
 drivers/s390/block/dasd.c          |   43 +++++--------------------
 drivers/s390/block/dasd_3990_erp.c |   21 +++++-------
 drivers/s390/block/dasd_eckd.c     |   62 +++++++++++++------------------------
 drivers/s390/block/dasd_erp.c      |   51 ++++++++++--------------------
 drivers/s390/block/dasd_int.h      |   10 ++++-
 drivers/s390/block/dasd_ioctl.c    |   54 ++++++++++++++++++++++++++++++++
 include/asm-s390/dasd.h            |   14 ++------
 7 files changed, 124 insertions(+), 131 deletions(-)

diff -urN linux-2.5/drivers/s390/block/dasd.c linux-2.5-s390/drivers/s390/block/dasd.c
--- linux-2.5/drivers/s390/block/dasd.c	Sun Jun 22 20:32:43 2003
+++ linux-2.5-s390/drivers/s390/block/dasd.c	Fri Jun 27 16:04:39 2003
@@ -7,7 +7,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999-2001
  *
- * $Revision: 1.99 $
+ * $Revision: 1.101 $
  */
 
 #include <linux/config.h>
@@ -32,7 +32,7 @@
 /*
  * SECTION: Constant definitions to be used within this file
  */
-#define DASD_CHANQ_MAX_SIZE 5
+#define DASD_CHANQ_MAX_SIZE 4
 
 /*
  * SECTION: exported variables of dasd.c
@@ -803,24 +803,18 @@
  *  2) delayed start of request where start_IO failed with -EBUSY
  *  3) timeout for missing state change interrupts
  * The head of the ccw queue will have status DASD_CQR_IN_IO for 1),
- * DASD_CQR_QUEUED for 2) and DASD_CQR_PENDING for 3).
+ * DASD_CQR_QUEUED for 2) and 3).
  */
 static void
 dasd_timeout_device(unsigned long ptr)
 {
 	unsigned long flags;
 	struct dasd_device *device;
-	struct dasd_ccw_req *cqr;
 
 	device = (struct dasd_device *) ptr;
 	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
 	/* re-activate first request in queue */
-	if (!list_empty(&device->ccw_queue)) {
-		cqr = list_entry(device->ccw_queue.next,
-				 struct dasd_ccw_req, list);
-		if (cqr->status == DASD_CQR_PENDING)
-			cqr->status = DASD_CQR_QUEUED;
-	}
+        device->stopped &= ~DASD_STOPPED_PENDING;
 	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
 	dasd_schedule_bh(device);
 }
@@ -861,10 +855,6 @@
 
 /*
  *   Handles the state change pending interrupt.
- *   Search for the device related request queue and check if the first
- *   cqr in queue in in status 'DASD_CQR_PENDING'.
- *   If so the status is set to 'DASD_CQR_QUEUED' to reactivate
- *   the device.
  */
 static void
 do_state_change_pending(void *data)
@@ -874,29 +864,12 @@
 		struct dasd_device *device;
 	} *p;
 	struct dasd_device *device;
-	struct dasd_ccw_req *cqr;
 
 	p = data;
 	device = p->device;
 	DBF_EVENT(DBF_NOTICE, "State change Interrupt for bus_id %s",
 		  device->cdev->dev.bus_id);
-
-	spin_lock_irq(get_ccwdev_lock(device->cdev));
-	/* re-activate first request in queue */
-	if (!list_empty(&device->ccw_queue)) {
-		cqr = list_entry(device->ccw_queue.next,
-				 struct dasd_ccw_req, list);
-		if (cqr == NULL) {
-			MESSAGE (KERN_DEBUG,
-				 "got state change pending interrupt on"
-				 "an idle device: bus_id %s",
-				 device->cdev->dev.bus_id);
-			return;
-		}
-		if (cqr->status == DASD_CQR_PENDING)
-			cqr->status = DASD_CQR_QUEUED;
-	}
-	spin_unlock_irq(get_ccwdev_lock(device->cdev));
+	device->stopped &= ~DASD_STOPPED_PENDING;
 	dasd_schedule_bh(device);
 	dasd_put_device(device);
 	kfree(p);
@@ -1036,7 +1009,8 @@
 		if (cqr->list.next != &device->ccw_queue) {
 			next = list_entry(cqr->list.next,
 					  struct dasd_ccw_req, list);
-			if (next->status == DASD_CQR_QUEUED) {
+			if ((next->status == DASD_CQR_QUEUED) &&
+			    (!device->stopped)) {
 				if (device->discipline->start_IO(next) == 0)
 					expires = next->expires;
 				else
@@ -1264,7 +1238,8 @@
 	if (list_empty(&device->ccw_queue))
 		return;
 	cqr = list_entry(device->ccw_queue.next, struct dasd_ccw_req, list);
-	if (cqr->status == DASD_CQR_QUEUED) {
+	if ((cqr->status == DASD_CQR_QUEUED) &&
+	    (!device->stopped)) {
 		/* try to start the first I/O that can be started */
 		rc = device->discipline->start_IO(cqr);
 		if (rc == 0)
diff -urN linux-2.5/drivers/s390/block/dasd_3990_erp.c linux-2.5-s390/drivers/s390/block/dasd_3990_erp.c
--- linux-2.5/drivers/s390/block/dasd_3990_erp.c	Sun Jun 22 20:33:12 2003
+++ linux-2.5-s390/drivers/s390/block/dasd_3990_erp.c	Fri Jun 27 16:04:39 2003
@@ -5,7 +5,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 2000, 2001
  *
- * $Revision: 1.24 $
+ * $Revision: 1.25 $
  */
 
 #include <linux/timer.h>
@@ -221,13 +221,6 @@
  *   Block the given device request queue to prevent from further
  *   processing until the started timer has expired or an related
  *   interrupt was received.
- *
- *  PARAMETER
- *   erp		request to be blocked
- *   expires		time to wait until restart (in jiffies) 
- *
- * RETURN VALUES
- *   void		
  */
 static void
 dasd_3990_erp_block_queue(struct dasd_ccw_req * erp, int expires)
@@ -238,7 +231,9 @@
 	DEV_MESSAGE(KERN_INFO, device,
 		    "blocking request queue for %is", expires);
 
-	erp->status = DASD_CQR_PENDING;
+	device->stopped |= DASD_STOPPED_PENDING;
+	erp->status = DASD_CQR_QUEUED;
+
 	dasd_set_timer(device, expires);
 }
 
@@ -453,9 +448,11 @@
 
 		if (sense[25] == 0x1D) {	/* state change pending */
 
-			DEV_MESSAGE(KERN_INFO, device, "%s",
-				    "waiting for state change pending " "int");
-
+			DEV_MESSAGE(KERN_INFO, device, 
+				    "waiting for state change pending "
+				    "interrupt, %d retries left",
+				    erp->retries);
+			
 			dasd_3990_erp_block_queue(erp, 30*HZ);
 
 		} else {
diff -urN linux-2.5/drivers/s390/block/dasd_eckd.c linux-2.5-s390/drivers/s390/block/dasd_eckd.c
--- linux-2.5/drivers/s390/block/dasd_eckd.c	Fri Jun 27 16:04:39 2003
+++ linux-2.5-s390/drivers/s390/block/dasd_eckd.c	Fri Jun 27 16:04:39 2003
@@ -7,7 +7,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.42 $
+ * $Revision: 1.46 $
  */
 
 #include <linux/config.h>
@@ -210,7 +210,7 @@
                 data->ep_sys_time = get_clock ();
                 
                 de_ccw->count = sizeof (struct DE_eckd_data);
-                de_ccw->flags = CCW_FLAG_SLI;  
+                de_ccw->flags |= CCW_FLAG_SLI;  
         }
 
         return;
@@ -287,19 +287,11 @@
 	/* check for sequential prestage - enhance cylinder range */
 	if (data->attributes.operation == DASD_SEQ_PRESTAGE ||
 	    data->attributes.operation == DASD_SEQ_ACCESS) {
-
-		if (end.cyl + private->attrib.nr_cyl < geo.cyl) {
+		
+		if (end.cyl + private->attrib.nr_cyl < geo.cyl) 
 			end.cyl += private->attrib.nr_cyl;
-			DBF_DEV_EVENT(DBF_NOTICE, device,
-				      "Enhanced DE Cylinder from  %x to %x",
-				      (totrk / geo.head), end.cyl);
-		} else {
+		else
 			end.cyl = (geo.cyl - 1);
-			DBF_DEV_EVENT(DBF_NOTICE, device,
-				      "Enhanced DE Cylinder from  %x to "
-				      "End of device %x",
-				      (totrk / geo.head), end.cyl);
-		}
 	}
 
 	data->beg_ext.cyl = beg.cyl;
@@ -518,12 +510,6 @@
 		    private->rdc_data.cu_type,
 		    private->rdc_data.cu_model.model);
 	return 0;
-
-        /* get characteristis via diag to determine the kind of
-	 * minidisk under VM needed beacause XRC is not support
-	 * by VM (jet). Can be removed as soon as VM supports XRC
-	 * FIXME: TBD ??? HUM
-	 */
 }
 
 static struct dasd_ccw_req *
@@ -1136,13 +1122,16 @@
 		return -ENODEV;
 
 	cqr = dasd_smalloc_request(dasd_eckd_discipline.name,
-				   1, 0, device);
+				   1, 32, device);
 	if (cqr == NULL) {
 		MESSAGE(KERN_WARNING, "%s",
 			"No memory to allocate initialization request");
 		return -ENOMEM;
 	}
 	cqr->cpaddr->cmd_code = DASD_ECKD_CCW_RELEASE;
+        cqr->cpaddr->flags |= CCW_FLAG_SLI;
+        cqr->cpaddr->count = 32;
+	cqr->cpaddr->cda = (__u32)(addr_t) cqr->data;
 	cqr->device = device;
 	cqr->retries = 0;
 	cqr->expires = 10 * HZ;
@@ -1151,14 +1140,14 @@
 
 	rc = dasd_sleep_on_immediatly(cqr);
 
-	dasd_kfree_request(cqr, cqr->device);
+	dasd_sfree_request(cqr, cqr->device);
 	return rc;
 }
 
 /*
  * Reserve device ioctl.
  * Options are set to 'synchronous wait for interrupt' and
- * 'timeout the request'. This leads to an terminate IO if 
+ * 'timeout the request'. This leads to a terminate IO if 
  * the interrupt is outstanding for a certain time. 
  */
 static int
@@ -1176,14 +1165,16 @@
 		return -ENODEV;
 
 	cqr = dasd_smalloc_request(dasd_eckd_discipline.name,
-				   1, 0, device);
-
+				   1, 32, device);
 	if (cqr == NULL) {
 		MESSAGE(KERN_WARNING, "%s",
 			"No memory to allocate initialization request");
 		return -ENOMEM;
 	}
 	cqr->cpaddr->cmd_code = DASD_ECKD_CCW_RESERVE;
+        cqr->cpaddr->flags |= CCW_FLAG_SLI;
+        cqr->cpaddr->count = 32;
+	cqr->cpaddr->cda = (__u32)(addr_t) cqr->data;
 	cqr->device = device;
 	cqr->retries = 0;
 	cqr->expires = 10 * HZ;
@@ -1192,11 +1183,7 @@
 
 	rc = dasd_sleep_on_immediatly(cqr);
 
-	if (rc == -EIO) {
-		/* Request got an error or has been timed out. */
-		dasd_eckd_release(bdev, no, args);
-	}
-	dasd_kfree_request(cqr, cqr->device);
+	dasd_sfree_request(cqr, cqr->device);
 	return rc;
 }
 
@@ -1220,13 +1207,16 @@
 		return -ENODEV;
 
 	cqr = dasd_smalloc_request(dasd_eckd_discipline.name,
-				   1, 0, device);
+				   1, 32, device);
 	if (cqr == NULL) {
 		MESSAGE(KERN_WARNING, "%s",
 			"No memory to allocate initialization request");
 		return -ENOMEM;
 	}
 	cqr->cpaddr->cmd_code = DASD_ECKD_CCW_SLCK;
+        cqr->cpaddr->flags |= CCW_FLAG_SLI;
+        cqr->cpaddr->count = 32;
+	cqr->cpaddr->cda = (__u32)(addr_t) cqr->data;
 	cqr->device = device;
 	cqr->retries = 0;
 	cqr->expires = 10 * HZ;
@@ -1235,11 +1225,7 @@
 
 	rc = dasd_sleep_on_immediatly(cqr);
 
-	if (rc == -EIO) {
-		/* Request got an error or has been timed out. */
-		dasd_eckd_release(bdev, no, args);
-	}
-	dasd_kfree_request(cqr, cqr->device);
+	dasd_sfree_request(cqr, cqr->device);
 	return rc;
 }
 
@@ -1336,17 +1322,13 @@
 
 	private = (struct dasd_eckd_private *) device->private;
 
-	DBF_DEV_EVENT(DBF_ERR, device,
-		      "cache operation mode got "
-		      "%x (%i cylinder prestage)",
-		      attrib.operation, attrib.nr_cyl);
-
 	private->attrib = attrib;
 
 	DBF_DEV_EVENT(DBF_ERR, device,
 		      "cache operation mode set to "
 		      "%x (%i cylinder prestage)",
 		      private->attrib.operation, private->attrib.nr_cyl);
+	
 	return 0;
 }
 
diff -urN linux-2.5/drivers/s390/block/dasd_erp.c linux-2.5-s390/drivers/s390/block/dasd_erp.c
--- linux-2.5/drivers/s390/block/dasd_erp.c	Sun Jun 22 20:32:33 2003
+++ linux-2.5-s390/drivers/s390/block/dasd_erp.c	Fri Jun 27 16:04:39 2003
@@ -7,7 +7,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999-2001
  *
- * $Revision: 1.9 $
+ * $Revision: 1.10 $
  */
 
 #include <linux/config.h>
@@ -86,48 +86,31 @@
 	atomic_dec(&device->ref_count);
 }
 
+
 /*
- * DESCRIPTION
- *   sets up the default-ERP struct dasd_ccw_req, namely one, which performs
- *   a TIC to the original channel program with a retry counter of 16
- *
- * PARAMETER
- *   cqr		failed CQR
- *
- * RETURN VALUES
- *   erp		CQR performing the ERP
+ * dasd_default_erp_action just retries the current cqr
  */
 struct dasd_ccw_req *
 dasd_default_erp_action(struct dasd_ccw_req * cqr)
 {
 	struct dasd_device *device;
-	struct dasd_ccw_req *erp;
 
-	MESSAGE(KERN_DEBUG, "%s", "Default ERP called... ");
 	device = cqr->device;
-	erp = dasd_alloc_erp_request((char *) &cqr->magic, 1, 0, device);
-	if (IS_ERR(erp)) {
-		DEV_MESSAGE(KERN_ERR, device, "%s",
-			    "Unable to allocate request for default ERP");
-		cqr->status = DASD_CQR_FAILED;
-		cqr->stopclk = get_clock();
-		return cqr;
-	}
-
-	erp->cpaddr->cmd_code = CCW_CMD_TIC;
-	erp->cpaddr->cda = (__u32) (addr_t) cqr->cpaddr;
-	erp->function = dasd_default_erp_action;
-	erp->refers = cqr;
-	erp->device = device;
-	erp->magic = cqr->magic;
-	erp->retries = 16;
-	erp->status = DASD_CQR_FILLED;
-
-	list_add(&erp->list, &device->ccw_queue);
-	erp->status = DASD_CQR_QUEUED;
-
-	return erp;
 
+        /* just retry - there is nothing to save ... I got no sense data.... */
+        if (cqr->retries > 0) {
+                DEV_MESSAGE (KERN_DEBUG, device, 
+                             "default ERP called (%i retries left)",
+                             cqr->retries);
+		cqr->status = DASD_CQR_QUEUED;
+        } else {
+                DEV_MESSAGE (KERN_WARNING, device, "%s",
+			     "default ERP called (NO retry left)");
+		
+		cqr->status = DASD_CQR_FAILED;
+		cqr->stopclk = get_clock ();
+        }
+        return cqr;
 }				/* end dasd_default_erp_action */
 
 /*
diff -urN linux-2.5/drivers/s390/block/dasd_int.h linux-2.5-s390/drivers/s390/block/dasd_int.h
--- linux-2.5/drivers/s390/block/dasd_int.h	Sun Jun 22 20:33:01 2003
+++ linux-2.5-s390/drivers/s390/block/dasd_int.h	Fri Jun 27 16:04:39 2003
@@ -6,7 +6,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.40 $
+ * $Revision: 1.42 $
  */
 
 #ifndef DASD_INT_H
@@ -188,7 +188,6 @@
 #define DASD_CQR_DONE     0x03	/* request is completed successfully */
 #define DASD_CQR_ERROR    0x04	/* request is completed with error */
 #define DASD_CQR_FAILED   0x05	/* request is finally failed */
-#define DASD_CQR_PENDING  0x06  /* request is waiting for interrupt - ERP only */ 
 
 /* Signature for error recovery functions. */
 typedef struct dasd_ccw_req *(*dasd_erp_fn_t) (struct dasd_ccw_req *);
@@ -279,6 +278,7 @@
 
 	/* Device state and target state. */
 	int state, target;
+	int stopped;		/* device (ccw_device_start) was stopped */
 
 	/* Open and reference count. */
         atomic_t ref_count;
@@ -306,6 +306,12 @@
 #endif
 };
 
+/* reasons why device (ccw_device_start) was stopped */
+#define DASD_STOPPED_NOT_ACC 1         /* not accessible */
+#define DASD_STOPPED_QUIESCE 2         /* Quiesced */
+#define DASD_STOPPED_PENDING 4         /* long busy */
+
+
 void dasd_put_device_wake(struct dasd_device *);
 
 /*
diff -urN linux-2.5/drivers/s390/block/dasd_ioctl.c linux-2.5-s390/drivers/s390/block/dasd_ioctl.c
--- linux-2.5/drivers/s390/block/dasd_ioctl.c	Sun Jun 22 20:32:56 2003
+++ linux-2.5-s390/drivers/s390/block/dasd_ioctl.c	Fri Jun 27 16:04:39 2003
@@ -169,6 +169,58 @@
 }
 
 /*
+ * Quiesce device.
+ */
+static int
+dasd_ioctl_quiesce(struct block_device *bdev, int no, long args)
+{
+	struct dasd_device *device;
+	unsigned long flags;
+	
+	if (!capable (CAP_SYS_ADMIN))
+		return -EACCES;
+	
+	device = bdev->bd_disk->private_data;
+	if (device == NULL)
+		return -ENODEV;
+	
+	DEV_MESSAGE (KERN_DEBUG, device, "%s",
+		     "Quiesce IO on device");
+	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
+	device->stopped |= DASD_STOPPED_QUIESCE;
+	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
+	return 0;
+}
+
+
+/*
+ * Quiesce device.
+ */
+static int
+dasd_ioctl_resume(struct block_device *bdev, int no, long args)
+{
+	struct dasd_device *device;
+	unsigned long flags;
+	
+	if (!capable (CAP_SYS_ADMIN)) 
+		return -EACCES;
+
+	device = bdev->bd_disk->private_data;
+	if (device == NULL)
+		return -ENODEV;
+
+	DEV_MESSAGE (KERN_DEBUG, device, "%s",
+		     "resume IO on device");
+	
+	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
+	device->stopped &= ~DASD_STOPPED_QUIESCE;
+	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
+
+	dasd_schedule_bh (device);
+	return 0;
+}
+
+/*
  * performs formatting of _device_ according to _fdata_
  * Note: The discipline's format_function is assumed to deliver formatting
  * commands to format a single unit of the device. In terms of the ECKD
@@ -438,6 +490,8 @@
 {
 	{ BIODASDDISABLE, dasd_ioctl_disable },
 	{ BIODASDENABLE, dasd_ioctl_enable },
+	{ BIODASDQUIESCE, dasd_ioctl_quiesce },
+	{ BIODASDRESUME, dasd_ioctl_resume },
 	{ BIODASDFMT, dasd_ioctl_format },
 	{ BIODASDINFO, dasd_ioctl_information },
 	{ BIODASDINFO2, dasd_ioctl_information },
diff -urN linux-2.5/include/asm-s390/dasd.h linux-2.5-s390/include/asm-s390/dasd.h
--- linux-2.5/include/asm-s390/dasd.h	Sun Jun 22 20:32:34 2003
+++ linux-2.5-s390/include/asm-s390/dasd.h	Fri Jun 27 16:04:39 2003
@@ -8,16 +8,8 @@
  * any future changes wrt the API will result in a change of the APIVERSION reported
  * to userspace by the DASDAPIVER-ioctl
  *
- * $Revision: 1.3 $
+ * $Revision: 1.4 $
  *
- * History of changes (starts July 2000)
- * 05/04/01 created by moving the kernel interface to drivers/s390/block/dasd_int.h
- * 12/06/01 DASD_API_VERSION 2 - binary compatible to 0 (new BIODASDINFO2)
- * 01/23/02 DASD_API_VERSION 3 - added BIODASDPSRD (and BIODASDENAPAV) IOCTL
- * 02/15/02 DASD_API_VERSION 4 - added BIODASDSATTR IOCTL
- * ##/##/## DASD_API_VERSION 5 - added boxed dasd support TOBEDONE
- * 21/06/02 DASD_API_VERSION 6 - fixed HDIO_GETGEO: geo.start is in sectors!
- *         
  */
 
 #ifndef DASD_H
@@ -226,6 +218,10 @@
 #define BIODASDSLCK    _IO(DASD_IOCTL_LETTER,4) /* steal lock */
 /* reset profiling information of a device */
 #define BIODASDPRRST   _IO(DASD_IOCTL_LETTER,5)
+/* Quiesce IO on device */
+#define BIODASDQUIESCE _IO(DASD_IOCTL_LETTER,6) 
+/* Resume IO on device */
+#define BIODASDRESUME  _IO(DASD_IOCTL_LETTER,7) 
 
 
 /* retrieve API version number */
