Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbWDCRXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbWDCRXW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 13:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbWDCRXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 13:23:21 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:55068 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751769AbWDCRXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 13:23:20 -0400
Date: Mon, 3 Apr 2006 19:23:19 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, peter.oberparleiter@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: [patch 7/9] s390: fail-fast requests on quiesced devices.
Message-ID: <20060403172318.GG11049@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

[patch 7/9] s390: fail-fast requests on quiesced devices.

Using the fail-fast flag in i/o requests on a dasd disk which has
been quiesced leads to kernel panics. Modify the request start
function to only work on requests in a valid state.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd.c |   29 ++++++++++++++++-------------
 1 files changed, 16 insertions(+), 13 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/dasd.c linux-2.6-patched/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	2006-04-03 18:46:40.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd.c	2006-04-03 18:46:40.000000000 +0200
@@ -1257,25 +1257,28 @@ __dasd_start_head(struct dasd_device * d
 	if (list_empty(&device->ccw_queue))
 		return;
 	cqr = list_entry(device->ccw_queue.next, struct dasd_ccw_req, list);
-        /* check FAILFAST */
+	if (cqr->status != DASD_CQR_QUEUED)
+		return;
+	/* Non-temporary stop condition will trigger fail fast */
 	if (device->stopped & ~DASD_STOPPED_PENDING &&
 	    test_bit(DASD_CQR_FLAGS_FAILFAST, &cqr->flags) &&
 	    (!dasd_eer_enabled(device))) {
 		cqr->status = DASD_CQR_FAILED;
 		dasd_schedule_bh(device);
+		return;
 	}
-	if ((cqr->status == DASD_CQR_QUEUED) &&
-	    (!device->stopped)) {
-		/* try to start the first I/O that can be started */
-		rc = device->discipline->start_IO(cqr);
-		if (rc == 0)
-			dasd_set_timer(device, cqr->expires);
-		else if (rc == -EACCES) {
-			dasd_schedule_bh(device);
-		} else
-			/* Hmpf, try again in 1/2 sec */
-			dasd_set_timer(device, 50);
-	}
+	/* Don't try to start requests if device is stopped */
+	if (device->stopped)
+		return;
+
+	rc = device->discipline->start_IO(cqr);
+	if (rc == 0)
+		dasd_set_timer(device, cqr->expires);
+	else if (rc == -EACCES) {
+		dasd_schedule_bh(device);
+	} else
+		/* Hmpf, try again in 1/2 sec */
+		dasd_set_timer(device, 50);
 }
 
 /*
