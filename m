Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263128AbUDUOys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263128AbUDUOys (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 10:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263164AbUDUOyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 10:54:47 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:14317 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S263128AbUDUOrq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 10:47:46 -0400
Date: Wed, 21 Apr 2004 16:47:32 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (5/9): dasd device driver.
Message-ID: <20040421144732.GF2951@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: dasd driver

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

dasd device driver changes:
 - Initialize open_count with -1 to account for blkdev_open in
   dasd_scan_partitions.
 - Introduce USE_ERP request flag to selectivly switch off error
   recovery for reserve, release & unconditional reserve ioctls.

diffstat:
 drivers/s390/block/dasd.c          |   15 +++++++++++----
 drivers/s390/block/dasd_3990_erp.c |    3 ++-
 drivers/s390/block/dasd_eckd.c     |    5 ++++-
 drivers/s390/block/dasd_int.h      |    6 +++++-
 4 files changed, 22 insertions(+), 7 deletions(-)

diff -urN linux-2.6/drivers/s390/block/dasd.c linux-2.6-s390/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	Sun Apr  4 05:37:06 2004
+++ linux-2.6-s390/drivers/s390/block/dasd.c	Wed Apr 21 16:29:38 2004
@@ -7,7 +7,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999-2001
  *
- * $Revision: 1.136 $
+ * $Revision: 1.139 $
  */
 
 #include <linux/config.h>
@@ -74,6 +74,8 @@
 	if (device == NULL)
 		return ERR_PTR(-ENOMEM);
 	memset(device, 0, sizeof (struct dasd_device));
+	/* open_count = 0 means device online but not in use */
+	atomic_set(&device->open_count, -1); 
 
 	/* Get two pages for normal block device operations. */
 	device->ccw_mem = (void *) __get_free_pages(GFP_ATOMIC | GFP_DMA, 1);
@@ -549,6 +551,7 @@
 	}
 	strncpy((char *) &cqr->magic, magic, 4);
 	ASCEBC((char *) &cqr->magic, 4);
+	set_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
 	dasd_get_device(device);
 	return cqr;
 }
@@ -597,6 +600,7 @@
 	}
 	strncpy((char *) &cqr->magic, magic, 4);
 	ASCEBC((char *) &cqr->magic, 4);
+	set_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
 	dasd_get_device(device);
 	return cqr;
 }
@@ -688,9 +692,10 @@
 		rc = ccw_device_clear(device->cdev, (long) cqr);
 		switch (rc) {
 		case 0:	/* termination successful */
-			if (cqr->retries > 0)
+		        if (cqr->retries > 0) {
+				cqr->retries--;
 				cqr->status = DASD_CQR_QUEUED;
-			else
+			} else
 				cqr->status = DASD_CQR_FAILED;
 			cqr->stopclk = get_clock();
 			break;
@@ -982,6 +987,8 @@
 		 irb->scsw.cstat == 0 &&
 		 !irb->esw.esw0.erw.cons)
 		era = dasd_era_none;
+	else if (!test_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags))
+ 	        era = dasd_era_fatal; /* don't recover this request */
 	else if (irb->esw.esw0.erw.cons)
 		era = device->discipline->examine_error(cqr, irb);
 	else 
@@ -1875,7 +1882,7 @@
 	 * the blkdev_get in dasd_scan_partitions. We are only interested
 	 * in the other openers.
 	 */
-	max_count = device->bdev ? 1 : 0;
+	max_count = device->bdev ? 0 : -1;
 	if (atomic_read(&device->open_count) > max_count) {
 		printk (KERN_WARNING "Can't offline dasd device with open"
 			" count = %i.\n",
diff -urN linux-2.6/drivers/s390/block/dasd_3990_erp.c linux-2.6-s390/drivers/s390/block/dasd_3990_erp.c
--- linux-2.6/drivers/s390/block/dasd_3990_erp.c	Sun Apr  4 05:38:00 2004
+++ linux-2.6-s390/drivers/s390/block/dasd_3990_erp.c	Wed Apr 21 16:29:38 2004
@@ -5,7 +5,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 2000, 2001
  *
- * $Revision: 1.28 $
+ * $Revision: 1.30 $
  */
 
 #include <linux/timer.h>
@@ -1763,6 +1763,7 @@
 	erp->magic = default_erp->magic;
 	erp->expires = 0;
 	erp->retries = 256;
+	cqr->buildclk = get_clock();
 	erp->status = DASD_CQR_FILLED;
 
 	/* remove the default erp */
diff -urN linux-2.6/drivers/s390/block/dasd_eckd.c linux-2.6-s390/drivers/s390/block/dasd_eckd.c
--- linux-2.6/drivers/s390/block/dasd_eckd.c	Sun Apr  4 05:36:13 2004
+++ linux-2.6-s390/drivers/s390/block/dasd_eckd.c	Wed Apr 21 16:29:38 2004
@@ -7,7 +7,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.53 $
+ * $Revision: 1.54 $
  */
 
 #include <linux/config.h>
@@ -1130,6 +1130,7 @@
         cqr->cpaddr->count = 32;
 	cqr->cpaddr->cda = (__u32)(addr_t) cqr->data;
 	cqr->device = device;
+	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
 	cqr->retries = 0;
 	cqr->expires = 2 * HZ;
 	cqr->buildclk = get_clock();
@@ -1173,6 +1174,7 @@
         cqr->cpaddr->count = 32;
 	cqr->cpaddr->cda = (__u32)(addr_t) cqr->data;
 	cqr->device = device;
+	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
 	cqr->retries = 0;
 	cqr->expires = 2 * HZ;
 	cqr->buildclk = get_clock();
@@ -1215,6 +1217,7 @@
         cqr->cpaddr->count = 32;
 	cqr->cpaddr->cda = (__u32)(addr_t) cqr->data;
 	cqr->device = device;
+	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
 	cqr->retries = 0;
 	cqr->expires = 2 * HZ;
 	cqr->buildclk = get_clock();
diff -urN linux-2.6/drivers/s390/block/dasd_int.h linux-2.6-s390/drivers/s390/block/dasd_int.h
--- linux-2.6/drivers/s390/block/dasd_int.h	Sun Apr  4 05:37:37 2004
+++ linux-2.6-s390/drivers/s390/block/dasd_int.h	Wed Apr 21 16:29:38 2004
@@ -6,7 +6,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.56 $
+ * $Revision: 1.57 $
  */
 
 #ifndef DASD_INT_H
@@ -159,6 +159,7 @@
 	struct ccw1 *cpaddr;		/* address of channel program */
 	char status;	        	/* status of this request */
 	short retries;			/* A retry counter */
+	unsigned long flags;        	/* flags of this request */
 
 	/* ... and how */
 	unsigned long starttime;	/* jiffies time of request start */
@@ -192,6 +193,9 @@
 #define DASD_CQR_ERROR    0x04	/* request is completed with error */
 #define DASD_CQR_FAILED   0x05	/* request is finally failed */
 
+/* per dasd_ccw_req flags */
+#define DASD_CQR_FLAGS_USE_ERP   0	/* use ERP for this request */
+
 /* Signature for error recovery functions. */
 typedef struct dasd_ccw_req *(*dasd_erp_fn_t) (struct dasd_ccw_req *);
 
