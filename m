Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264479AbUEMTT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbUEMTT3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 15:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264450AbUEMTSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 15:18:44 -0400
Received: from mtagate7.de.ibm.com ([195.212.29.156]:61149 "EHLO
	mtagate7.de.ibm.com") by vger.kernel.org with ESMTP id S264430AbUEMTOn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 15:14:43 -0400
Date: Thu, 13 May 2004 21:14:40 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (3/6): dasd driver.
Message-ID: <20040513191440.GD2916@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: dasd driver.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

dasd driver changes:
 - Do error recovery for error recovery requests.
 - Retry request if the start_IO failed because of a timeout.

diffstat:
 drivers/s390/block/dasd.c      |   21 +++++++++++----------
 drivers/s390/block/dasd_eckd.c |    4 ++--
 drivers/s390/block/dasd_erp.c  |    5 +++--
 3 files changed, 16 insertions(+), 14 deletions(-)

diff -urN linux-2.6/drivers/s390/block/dasd.c linux-2.6-s390/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	Mon May 10 04:32:29 2004
+++ linux-2.6-s390/drivers/s390/block/dasd.c	Thu May 13 21:01:00 2004
@@ -7,7 +7,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999-2001
  *
- * $Revision: 1.139 $
+ * $Revision: 1.141 $
  */
 
 #include <linux/config.h>
@@ -751,16 +751,16 @@
 		break;
 	case -EBUSY:
 		DBF_DEV_EVENT(DBF_ERR, device, "%s",
-			      "device busy, retry later");
+			      "start_IO: device busy, retry later");
 		break;
 	case -ETIMEDOUT:
 		DBF_DEV_EVENT(DBF_ERR, device, "%s",
-			      "request timeout - terminated");
+			      "start_IO: request timeout, retry later");
+		break;
 	case -ENODEV:
 	case -EIO:
-		cqr->status = DASD_CQR_FAILED;
-		cqr->stopclk = cqr->startclk;
-		dasd_schedule_bh(device);
+		DBF_DEV_EVENT(DBF_ERR, device, "%s",
+			      "start_IO: device gone, retry");
 		break;
 	default:
 		DEV_MESSAGE(KERN_ERR, device,
@@ -1008,8 +1008,9 @@
 				if (device->discipline->start_IO(next) == 0)
 					expires = next->expires;
 				else
-					MESSAGE(KERN_WARNING, "%s",
-						"Interrupt fastpath failed!");
+					DEV_MESSAGE(KERN_DEBUG, device, "%s",
+						    "Interrupt fastpath "
+						    "failed!");
 			}
 		}
 	} else {		/* error */
@@ -1018,8 +1019,8 @@
 		if (cqr->dstat)
 			memcpy(cqr->dstat, irb, sizeof (struct irb));
 		else
-			MESSAGE(KERN_ERR, "%s",
-				"no memory for dstat...ignoring");
+			DEV_MESSAGE(KERN_ERR, device, "%s",
+				    "no memory for dstat...ignoring");
 #ifdef ERP_DEBUG
 		/* dump sense data */
 		dasd_log_sense(cqr, irb);
diff -urN linux-2.6/drivers/s390/block/dasd_eckd.c linux-2.6-s390/drivers/s390/block/dasd_eckd.c
--- linux-2.6/drivers/s390/block/dasd_eckd.c	Mon May 10 04:31:57 2004
+++ linux-2.6-s390/drivers/s390/block/dasd_eckd.c	Thu May 13 21:01:00 2004
@@ -7,7 +7,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.54 $
+ * $Revision: 1.55 $
  */
 
 #include <linux/config.h>
@@ -1070,7 +1070,7 @@
 	cqr->device = device;
 	cqr->expires = 5 * 60 * HZ;	/* 5 minutes */
 	cqr->lpm = LPM_ANYPATH;
-	cqr->retries = 2;
+	cqr->retries = 256;
 	cqr->buildclk = get_clock();
 	cqr->status = DASD_CQR_FILLED;
 	return cqr;
diff -urN linux-2.6/drivers/s390/block/dasd_erp.c linux-2.6-s390/drivers/s390/block/dasd_erp.c
--- linux-2.6/drivers/s390/block/dasd_erp.c	Mon May 10 04:32:01 2004
+++ linux-2.6-s390/drivers/s390/block/dasd_erp.c	Thu May 13 21:01:00 2004
@@ -7,7 +7,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999-2001
  *
- * $Revision: 1.10 $
+ * $Revision: 1.11 $
  */
 
 #include <linux/config.h>
@@ -67,7 +67,8 @@
 	}
 	strncpy((char *) &cqr->magic, magic, 4);
 	ASCEBC((char *) &cqr->magic, 4);
-	atomic_inc(&device->ref_count);
+	set_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
+	dasd_get_device(device);
 	return cqr;
 }
 
