Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbWARQ7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbWARQ7k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 11:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWARQ7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 11:59:40 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:65180 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751355AbWARQ7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 11:59:39 -0500
Date: Wed, 18 Jan 2006 17:59:12 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Horst Hummel <horst.hummel@de.ibm.com>
Subject: [PATCH 7/7] s390: dasd wait for clear i/o interrupt.
Message-ID: <20060118165912.GG29266@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horst Hummel <horst.hummel@de.ibm.com>

The sleep_on function clears a running cqr without waiting for the
related interrupt. This can lead to a panic at the time the interrupt
is processed because the related memory might already be freed.
Wait for clear-interrupt and de-queue cqr prior to return.

Signed-off-by: Horst Hummel <horst.hummel@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 drivers/s390/block/dasd.c |   45 +++++++++++++++++++++++++++++++++------------
 1 files changed, 33 insertions(+), 12 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/dasd.c linux-2.6-patched/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	2006-01-18 17:25:49.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd.c	2006-01-18 17:25:54.000000000 +0100
@@ -674,11 +674,8 @@ dasd_term_IO(struct dasd_ccw_req * cqr)
 		rc = ccw_device_clear(device->cdev, (long) cqr);
 		switch (rc) {
 		case 0:	/* termination successful */
-		        if (cqr->retries > 0) {
-				cqr->retries--;
-				cqr->status = DASD_CQR_CLEAR;
-			} else
-				cqr->status = DASD_CQR_FAILED;
+			cqr->retries--;
+			cqr->status = DASD_CQR_CLEAR;
 			cqr->stopclk = get_clock();
 			DBF_DEV_EVENT(DBF_DEBUG, device,
 				      "terminate cqr %p successful",
@@ -1307,7 +1304,7 @@ dasd_tasklet(struct dasd_device * device
 	/* Now call the callback function of requests with final status */
 	list_for_each_safe(l, n, &final_queue) {
 		cqr = list_entry(l, struct dasd_ccw_req, list);
-		list_del(&cqr->list);
+		list_del_init(&cqr->list);
 		if (cqr->callback != NULL)
 			(cqr->callback)(cqr, cqr->callback_data);
 	}
@@ -1392,7 +1389,9 @@ _wait_for_wakeup(struct dasd_ccw_req *cq
 
 	device = cqr->device;
 	spin_lock_irq(get_ccwdev_lock(device->cdev));
-	rc = cqr->status == DASD_CQR_DONE || cqr->status == DASD_CQR_FAILED;
+	rc = ((cqr->status == DASD_CQR_DONE ||
+	       cqr->status == DASD_CQR_FAILED) &&
+	      list_empty(&cqr->list));
 	spin_unlock_irq(get_ccwdev_lock(device->cdev));
 	return rc;
 }
@@ -1456,15 +1455,37 @@ dasd_sleep_on_interruptible(struct dasd_
 	while (!finished) {
 		rc = wait_event_interruptible(wait_q, _wait_for_wakeup(cqr));
 		if (rc != -ERESTARTSYS) {
-			/* Request status is either done or failed. */
-			rc = (cqr->status == DASD_CQR_FAILED) ? -EIO : 0;
+			/* Request is final (done or failed) */
+			rc = (cqr->status == DASD_CQR_DONE) ? 0 : -EIO;
 			break;
 		}
 		spin_lock_irq(get_ccwdev_lock(device->cdev));
-		if (cqr->status == DASD_CQR_IN_IO &&
-		    device->discipline->term_IO(cqr) == 0) {
-			list_del(&cqr->list);
+		switch (cqr->status) {
+		case DASD_CQR_IN_IO:
+                        /* terminate runnig cqr */
+			if (device->discipline->term_IO) {
+				cqr->retries = -1;
+				device->discipline->term_IO(cqr);
+				/*nished =
+				 * wait (non-interruptible) for final status
+				 * because signal ist still pending
+				 */
+				spin_unlock_irq(get_ccwdev_lock(device->cdev));
+				wait_event(wait_q, _wait_for_wakeup(cqr));
+				spin_lock_irq(get_ccwdev_lock(device->cdev));
+				rc = (cqr->status == DASD_CQR_DONE) ? 0 : -EIO;
+				finished = 1;
+			}
+			break;
+		case DASD_CQR_QUEUED:
+			/* request  */
+			list_del_init(&cqr->list);
+			rc = -EIO;
 			finished = 1;
+			break;
+		default:
+			/* cqr with 'non-interruptable' status - just wait */
+			break;
 		}
 		spin_unlock_irq(get_ccwdev_lock(device->cdev));
 	}
