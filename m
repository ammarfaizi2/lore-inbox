Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbVLIPYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbVLIPYj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 10:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbVLIPYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 10:24:39 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:24826 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932331AbVLIPYb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 10:24:31 -0500
Date: Fri, 9 Dec 2005 16:24:29 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, horst.hummel@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 5/17] s390: dasd failfast support.
Message-ID: <20051209152429.GF6532@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horst Hummel <horst.hummel@de.ibm.com>

[patch 5/17] s390: dasd failfast support.

To properly support multipath-failover handling, the linux
block layer has introduced a special request flag, 'REQ_FAILFAST'.
This flag is now used to return requests immediately in case
the device is not operational.

Signed-off-by: Horst Hummel <horst.hummel@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 drivers/s390/block/dasd.c      |   28 ++++++++++++++++++++--------
 drivers/s390/block/dasd_diag.c |    4 +++-
 drivers/s390/block/dasd_eckd.c |    7 ++++++-
 drivers/s390/block/dasd_fba.c  |    4 +++-
 drivers/s390/block/dasd_int.h  |    3 ++-
 5 files changed, 34 insertions(+), 12 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/dasd.c linux-2.6-patched/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	2005-12-09 14:24:15.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd.c	2005-12-09 14:24:24.000000000 +0100
@@ -7,7 +7,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999-2001
  *
- * $Revision: 1.169 $
+ * $Revision: 1.172 $
  */
 
 #include <linux/config.h>
@@ -1224,6 +1224,12 @@ __dasd_start_head(struct dasd_device * d
 	if (list_empty(&device->ccw_queue))
 		return;
 	cqr = list_entry(device->ccw_queue.next, struct dasd_ccw_req, list);
+        /* check FAILFAST */
+	if (device->stopped & ~DASD_STOPPED_PENDING &&
+	    test_bit(DASD_CQR_FLAGS_FAILFAST, &cqr->flags)) {
+		cqr->status = DASD_CQR_FAILED;
+		dasd_schedule_bh(device);
+	}
 	if ((cqr->status == DASD_CQR_QUEUED) &&
 	    (!device->stopped)) {
 		/* try to start the first I/O that can be started */
@@ -1750,8 +1756,10 @@ dasd_exit(void)
  * SECTION: common functions for ccw_driver use
  */
 
-/* initial attempt at a probe function. this can be simplified once
- * the other detection code is gone */
+/*
+ * Initial attempt at a probe function. this can be simplified once
+ * the other detection code is gone.
+ */
 int
 dasd_generic_probe (struct ccw_device *cdev,
 		    struct dasd_discipline *discipline)
@@ -1770,8 +1778,10 @@ dasd_generic_probe (struct ccw_device *c
 	return ret;
 }
 
-/* this will one day be called from a global not_oper handler.
- * It is also used by driver_unregister during module unload */
+/*
+ * This will one day be called from a global not_oper handler.
+ * It is also used by driver_unregister during module unload.
+ */
 void
 dasd_generic_remove (struct ccw_device *cdev)
 {
@@ -1798,9 +1808,11 @@ dasd_generic_remove (struct ccw_device *
 	dasd_delete_device(device);
 }
 
-/* activate a device. This is called from dasd_{eckd,fba}_probe() when either
+/*
+ * Activate a device. This is called from dasd_{eckd,fba}_probe() when either
  * the device is detected for the first time and is supposed to be used
- * or the user has started activation through sysfs */
+ * or the user has started activation through sysfs.
+ */
 int
 dasd_generic_set_online (struct ccw_device *cdev,
 			 struct dasd_discipline *discipline)
@@ -1917,7 +1929,6 @@ dasd_generic_notify(struct ccw_device *c
 				if (cqr->status == DASD_CQR_IN_IO)
 					cqr->status = DASD_CQR_FAILED;
 			device->stopped |= DASD_STOPPED_DC_EIO;
-			dasd_schedule_bh(device);
 		} else {
 			list_for_each_entry(cqr, &device->ccw_queue, list)
 				if (cqr->status == DASD_CQR_IN_IO) {
@@ -1927,6 +1938,7 @@ dasd_generic_notify(struct ccw_device *c
 			device->stopped |= DASD_STOPPED_DC_WAIT;
 			dasd_set_timer(device, 0);
 		}
+		dasd_schedule_bh(device);
 		ret = 1;
 		break;
 	case CIO_OPER:
diff -urpN linux-2.6/drivers/s390/block/dasd_diag.c linux-2.6-patched/drivers/s390/block/dasd_diag.c
--- linux-2.6/drivers/s390/block/dasd_diag.c	2005-12-09 14:24:16.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_diag.c	2005-12-09 14:24:24.000000000 +0100
@@ -6,7 +6,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.52 $
+ * $Revision: 1.53 $
  */
 
 #include <linux/config.h>
@@ -549,6 +549,8 @@ dasd_diag_build_cp(struct dasd_device * 
 	}
 	cqr->retries = DIAG_MAX_RETRIES;
 	cqr->buildclk = get_clock();
+	if (req->flags & REQ_FAILFAST)
+		set_bit(DASD_CQR_FLAGS_FAILFAST, &cqr->flags);
 	cqr->device = device;
 	cqr->expires = DIAG_TIMEOUT;
 	cqr->status = DASD_CQR_FILLED;
diff -urpN linux-2.6/drivers/s390/block/dasd_eckd.c linux-2.6-patched/drivers/s390/block/dasd_eckd.c
--- linux-2.6/drivers/s390/block/dasd_eckd.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_eckd.c	2005-12-09 14:24:24.000000000 +0100
@@ -7,7 +7,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.71 $
+ * $Revision: 1.74 $
  */
 
 #include <linux/config.h>
@@ -1136,6 +1136,8 @@ dasd_eckd_build_cp(struct dasd_device * 
 			recid++;
 		}
 	}
+	if (req->flags & REQ_FAILFAST)
+		set_bit(DASD_CQR_FLAGS_FAILFAST, &cqr->flags);
 	cqr->device = device;
 	cqr->expires = 5 * 60 * HZ;	/* 5 minutes */
 	cqr->lpm = private->path_data.ppm;
@@ -1252,6 +1254,7 @@ dasd_eckd_release(struct block_device *b
 	cqr->cpaddr->cda = (__u32)(addr_t) cqr->data;
 	cqr->device = device;
 	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
+	set_bit(DASD_CQR_FLAGS_FAILFAST, &cqr->flags);
 	cqr->retries = 0;
 	cqr->expires = 2 * HZ;
 	cqr->buildclk = get_clock();
@@ -1296,6 +1299,7 @@ dasd_eckd_reserve(struct block_device *b
 	cqr->cpaddr->cda = (__u32)(addr_t) cqr->data;
 	cqr->device = device;
 	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
+	set_bit(DASD_CQR_FLAGS_FAILFAST, &cqr->flags);
 	cqr->retries = 0;
 	cqr->expires = 2 * HZ;
 	cqr->buildclk = get_clock();
@@ -1339,6 +1343,7 @@ dasd_eckd_steal_lock(struct block_device
 	cqr->cpaddr->cda = (__u32)(addr_t) cqr->data;
 	cqr->device = device;
 	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
+	set_bit(DASD_CQR_FLAGS_FAILFAST, &cqr->flags);
 	cqr->retries = 0;
 	cqr->expires = 2 * HZ;
 	cqr->buildclk = get_clock();
diff -urpN linux-2.6/drivers/s390/block/dasd_fba.c linux-2.6-patched/drivers/s390/block/dasd_fba.c
--- linux-2.6/drivers/s390/block/dasd_fba.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_fba.c	2005-12-09 14:24:24.000000000 +0100
@@ -4,7 +4,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.40 $
+ * $Revision: 1.41 $
  */
 
 #include <linux/config.h>
@@ -352,6 +352,8 @@ dasd_fba_build_cp(struct dasd_device * d
 			recid++;
 		}
 	}
+	if (req->flags & REQ_FAILFAST)
+		set_bit(DASD_CQR_FLAGS_FAILFAST, &cqr->flags);
 	cqr->device = device;
 	cqr->expires = 5 * 60 * HZ;	/* 5 minutes */
 	cqr->retries = 32;
diff -urpN linux-2.6/drivers/s390/block/dasd_int.h linux-2.6-patched/drivers/s390/block/dasd_int.h
--- linux-2.6/drivers/s390/block/dasd_int.h	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_int.h	2005-12-09 14:24:24.000000000 +0100
@@ -6,7 +6,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.65 $
+ * $Revision: 1.68 $
  */
 
 #ifndef DASD_INT_H
@@ -208,6 +208,7 @@ struct dasd_ccw_req {
 
 /* per dasd_ccw_req flags */
 #define DASD_CQR_FLAGS_USE_ERP   0	/* use ERP for this request */
+#define DASD_CQR_FLAGS_FAILFAST  1	/* FAILFAST */
 
 /* Signature for error recovery functions. */
 typedef struct dasd_ccw_req *(*dasd_erp_fn_t) (struct dasd_ccw_req *);
