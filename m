Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266939AbTBXSL0>; Mon, 24 Feb 2003 13:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267329AbTBXSKe>; Mon, 24 Feb 2003 13:10:34 -0500
Received: from d06lmsgate-6.uk.ibm.com ([194.196.100.252]:30889 "EHLO
	d06lmsgate-6.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S265773AbTBXSKK> convert rfc822-to-8bit; Mon, 24 Feb 2003 13:10:10 -0500
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (4/13): dasd block device driver.
Date: Mon, 24 Feb 2003 19:08:53 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200302241908.53888.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

updates for s390 dasd driver

Some problems have been found in the dasd error handling code, they
are fixed by the update to dasd_3990_erp.c.

Dasd is one of only two remaining drivers that use the null 
elevator instead of iosched. Appearantly, the null elevator
has some bitrot and can result in random data loss. For now,
we just don't use it.

diff -urN linux-2.5.62/drivers/s390/block/dasd.c linux-2.5.62-s390/drivers/s390/block/dasd.c
--- linux-2.5.62/drivers/s390/block/dasd.c	Mon Feb 24 18:17:44 2003
+++ linux-2.5.62-s390/drivers/s390/block/dasd.c	Mon Feb 24 18:23:59 2003
@@ -7,7 +7,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999-2001
  *
- * $Revision: 1.71 $
+ * $Revision: 1.74 $
  *
  * History of changes (starts July 2000)
  * 11/09/00 complete redesign after code review
@@ -1656,17 +1656,20 @@
 	device->request_queue = kmalloc(sizeof (request_queue_t), GFP_KERNEL);
 	if (device->request_queue == NULL)
 		return -ENOMEM;
+	memset(device->request_queue, 0, sizeof(request_queue_t));
 	device->request_queue->queuedata = device;
 	rc = blk_init_queue(device->request_queue, do_dasd_request,
 			    &device->request_queue_lock);
 	if (rc)
 		return rc;
+#if 0
 	elevator_exit(device->request_queue);
 	rc = elevator_init(device->request_queue, &elevator_noop);
 	if (rc) {
 		blk_cleanup_queue(device->request_queue);
 		return rc;
 	}
+#endif
 	blk_queue_hardsect_size(device->request_queue, device->bp_block);
 	max = device->discipline->max_blocks << device->s2b_shift;
 	blk_queue_max_sectors(device->request_queue, max);
diff -urN linux-2.5.62/drivers/s390/block/dasd_3990_erp.c linux-2.5.62-s390/drivers/s390/block/dasd_3990_erp.c
--- linux-2.5.62/drivers/s390/block/dasd_3990_erp.c	Mon Feb 17 23:56:50 2003
+++ linux-2.5.62-s390/drivers/s390/block/dasd_3990_erp.c	Mon Feb 24 18:23:59 2003
@@ -5,7 +5,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 2000, 2001
  *
- * $Revision: 1.19 $
+ * $Revision: 1.20 $
  *
  * History of changes:
  * 05/14/01 fixed PL030160GTO (BUG() in erp_action_5)
@@ -454,7 +454,7 @@
 
 	} else {
 
-		if (sense[25] & 0x1D) {	/* state change pending */
+		if (sense[25] == 0x1D) {	/* state change pending */
 
 			DEV_MESSAGE(KERN_INFO, device, "%s",
 				    "waiting for state change pending " "int");
@@ -464,6 +464,10 @@
 		} else {
 
 			/* no state change pending - retry */
+			DEV_MESSAGE (KERN_INFO, device, 
+				     "redriving request immediately, "
+				     "%d retries left", 
+				     erp->retries);
 			erp->status = DASD_CQR_QUEUED;
 		}
 	}
@@ -2273,27 +2277,41 @@
 {
 
 	dasd_device_t *device = cqr->device;
+	struct ccw1 *ccw;
 
 	/* allocate additional request block */
 	dasd_ccw_req_t *erp;
 
-	erp = dasd_alloc_erp_request((char *) &cqr->magic, 1, 0, cqr->device);
+	erp = dasd_alloc_erp_request((char *) &cqr->magic, 2, 0, cqr->device);
 	if (IS_ERR(erp)) {
-		DEV_MESSAGE(KERN_ERR, device, "%s",
-			    "Unable to allocate ERP request");
-		cqr->status = DASD_CQR_FAILED;
+                if (cqr->retries <= 0) {
+		        DEV_MESSAGE(KERN_ERR, device, "%s",
+				    "Unable to allocate ERP request");
+			cqr->status = DASD_CQR_FAILED;
+                        cqr->stopclk = get_clock ();
+		} else {
+                        DEV_MESSAGE (KERN_ERR, device,
+                                     "Unable to allocate ERP request "
+				     "(%i retries left)",
+                                     cqr->retries);
+			dasd_set_timer(device, (HZ << 3));
+                }
 		return cqr;
 	}
 
 	/* initialize request with default TIC to current ERP/CQR */
-	erp->cpaddr->cmd_code = CCW_CMD_TIC;
-	erp->cpaddr->cda = (long) (cqr->cpaddr);
+	ccw = erp->cpaddr;
+	ccw->cmd_code = CCW_CMD_NOOP;
+	ccw->flags = CCW_FLAG_CC;
+	ccw++;
+	ccw->cmd_code = CCW_CMD_TIC;
+	ccw->cda      = (long)(cqr->cpaddr);
 	erp->function = dasd_3990_erp_add_erp;
-	erp->refers = cqr;
-	erp->device = cqr->device;
-	erp->magic = cqr->magic;
-	erp->expires = 0;
-	erp->retries = 256;
+	erp->refers   = cqr;
+	erp->device   = cqr->device;
+	erp->magic    = cqr->magic;
+	erp->expires  = 0;
+	erp->retries  = 256;
 
 	erp->status = DASD_CQR_FILLED;
 
@@ -2362,7 +2380,7 @@
 	}
 
 	/* check sense data; byte 0-2,25,27 */
-	if (!((strncmp(cqr1->dstat->ecw, cqr2->dstat->ecw, 3) == 0) &&
+	if (!((memcmp (cqr1->dstat->ecw, cqr2->dstat->ecw, 3) == 0) &&
 	      (cqr1->dstat->ecw[27] == cqr2->dstat->ecw[27]) &&
 	      (cqr1->dstat->ecw[25] == cqr2->dstat->ecw[25]))) {
 
@@ -2549,7 +2567,7 @@
 
 	if (erp->retries > 0) {
 
-		char *sense = erp->dstat->ecw;
+		char *sense = erp->refers->dstat->ecw;
 
 		/* check for special retries */
 		if (erp->function == dasd_3990_erp_action_4) {
@@ -2680,35 +2698,9 @@
 		dasd_log_ccw(erp, 1, cpa);
 
 	/* enqueue added ERP request */
-	if ((erp != cqr) && (erp->status == DASD_CQR_FILLED)) {
+	if (erp->status == DASD_CQR_FILLED) {
 		erp->status = DASD_CQR_QUEUED;
 		list_add(&erp->list, &device->ccw_queue);
-	} else {
-		if ((erp->status == DASD_CQR_FILLED) || (erp != cqr)) {
-			/* something strange happened - log the error and throw a BUG() */
-			DEV_MESSAGE(KERN_ERR, device, "%s",
-				    "Problems with ERP chain!!! BUG");
-
-			/* print current erp_chain */
-			DEV_MESSAGE(KERN_DEBUG, device, "%s",
-				    "ERP chain at END of ERP-ACTION");
-			{
-				dasd_ccw_req_t *temp_erp = NULL;
-				for (temp_erp = erp;
-				     temp_erp != NULL;
-				     temp_erp = temp_erp->refers) {
-
-					DEV_MESSAGE(KERN_DEBUG, device,
-						    "	   erp %p (function %p)"
-						    " refers to %p",
-						    temp_erp,
-						    temp_erp->function,
-						    temp_erp->refers);
-				}
-			}
-			BUG();
-		}
-
 	}
 
 	return erp;
diff -urN linux-2.5.62/drivers/s390/block/dasd_eckd.c linux-2.5.62-s390/drivers/s390/block/dasd_eckd.c
--- linux-2.5.62/drivers/s390/block/dasd_eckd.c	Mon Feb 17 23:55:49 2003
+++ linux-2.5.62-s390/drivers/s390/block/dasd_eckd.c	Mon Feb 24 18:23:59 2003
@@ -7,7 +7,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.35 $
+ * $Revision: 1.36 $
  *
  * History of changes (starts July 2000)
  * 07/11/00 Enabled rotational position sensing
diff -urN linux-2.5.62/drivers/s390/block/dasd_ioctl.c linux-2.5.62-s390/drivers/s390/block/dasd_ioctl.c
--- linux-2.5.62/drivers/s390/block/dasd_ioctl.c	Mon Feb 17 23:56:17 2003
+++ linux-2.5.62-s390/drivers/s390/block/dasd_ioctl.c	Mon Feb 24 18:23:59 2003
@@ -111,7 +111,7 @@
 		ioctl = list_entry(l, dasd_ioctl_list_t, list);
 		if (ioctl->no == no) {
 			/* Found a matching ioctl. Call it. */
-			if (try_module_get(ioctl->owner) != 0)
+			if (!try_module_get(ioctl->owner))
 				continue;
 			rc = ioctl->handler(bdev, no, data);
 			module_put(ioctl->owner);
@@ -263,7 +263,7 @@
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 
-	device = = bdev->bd_disk->private_data;
+	device = bdev->bd_disk->private_data;
 	if (device == NULL)
 		return -ENODEV;
 
@@ -279,7 +279,7 @@
 {
 	dasd_device_t *device;
 
-	device = = bdev->bd_disk->private_data;
+	device = bdev->bd_disk->private_data;
 	if (device == NULL)
 		return -ENODEV;
 

