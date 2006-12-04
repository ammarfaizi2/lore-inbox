Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936939AbWLDOwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936939AbWLDOwz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 09:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936943AbWLDOwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 09:52:55 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:14359 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S936939AbWLDOwo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 09:52:44 -0500
Date: Mon, 4 Dec 2006 15:52:39 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, horst.hummel@de.ibm.com
Subject: [S390] Enhanced handling of failed termination requests.
Message-ID: <20061204145239.GL32059@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horst Hummel <horst.hummel@de.ibm.com>

[S390] Enhanced handling of failed termination requests.

In case a request timed out and termination did not work, the console was
flooded with retry messages (every 1/10s). Now we use a 5s delay per retry and
generate a more precise message.

Signed-off-by: Horst Hummel <horst.hummel@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/dasd.c linux-2.6-patched/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd.c	2006-12-04 14:50:42.000000000 +0100
@@ -1264,15 +1264,21 @@ __dasd_check_expire(struct dasd_device *
 	if (list_empty(&device->ccw_queue))
 		return;
 	cqr = list_entry(device->ccw_queue.next, struct dasd_ccw_req, list);
-	if (cqr->status == DASD_CQR_IN_IO && cqr->expires != 0) {
-		if (time_after_eq(jiffies, cqr->expires + cqr->starttime)) {
+	if ((cqr->status == DASD_CQR_IN_IO && cqr->expires != 0) &&
+	    (time_after_eq(jiffies, cqr->expires + cqr->starttime))) {
+		if (device->discipline->term_IO(cqr) != 0) {
+			/* Hmpf, try again in 5 sec */
+			dasd_set_timer(device, 5*HZ);
+			DEV_MESSAGE(KERN_ERR, device,
+				    "internal error - timeout (%is) expired "
+				    "for cqr %p, termination failed, "
+				    "retrying in 5s",
+				    (cqr->expires/HZ), cqr);
+		} else {
 			DEV_MESSAGE(KERN_ERR, device,
 				    "internal error - timeout (%is) expired "
 				    "for cqr %p (%i retries left)",
 				    (cqr->expires/HZ), cqr, cqr->retries);
-			if (device->discipline->term_IO(cqr) != 0)
-				/* Hmpf, try again in 1/10 sec */
-				dasd_set_timer(device, 10);
 		}
 	}
 }
