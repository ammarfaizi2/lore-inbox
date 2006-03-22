Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbWCVPYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbWCVPYK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWCVPYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:24:10 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:22486 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751309AbWCVPYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:24:08 -0500
Date: Wed, 22 Mar 2006 16:24:35 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, shbader@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 17/24] s390: tape retry flooding by deferred CC in interrupt.
Message-ID: <20060322152435.GQ5801@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Bader <shbader@de.ibm.com>

[patch 17/24] s390: tape retry flooding by deferred CC in interrupt.

If a deferred CC happens there will be lots of messages, because the retry is
done immediatly in the interrupt handler which can be too fast. To avoid this
requeue the request and schedule the queue to be processed.

Signed-off-by: Stefan Bader <shbader@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/tape_core.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff -urpN linux-2.6/drivers/s390/char/tape_core.c linux-2.6-patched/drivers/s390/char/tape_core.c
--- linux-2.6/drivers/s390/char/tape_core.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/tape_core.c	2006-03-22 14:36:30.000000000 +0100
@@ -1064,15 +1064,16 @@ __tape_do_irq (struct ccw_device *cdev, 
 	/*
 	 * If the condition code is not zero and the start function bit is
 	 * still set, this is an deferred error and the last start I/O did
-	 * not succeed. Restart the request now.
+	 * not succeed. At this point the condition that caused the deferred
+	 * error might still apply. So we just schedule the request to be
+	 * started later.
 	 */
 	if (irb->scsw.cc != 0 && (irb->scsw.fctl & SCSW_FCTL_START_FUNC)) {
 		PRINT_WARN("(%s): deferred cc=%i. restaring\n",
 			cdev->dev.bus_id,
 			irb->scsw.cc);
-		rc = __tape_start_io(device, request);
-		if (rc)
-			__tape_end_request(device, request, rc);
+		request->status = TAPE_REQUEST_QUEUED;
+		schedule_work(&device->tape_dnr);
 		return;
 	}
 
