Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWCVPOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWCVPOo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWCVPOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:14:43 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:5841 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750702AbWCVPOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:14:43 -0500
Date: Wed, 22 Mar 2006 16:15:10 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, cornelia.huck@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 1/24] s390: wrong interrupt delivered for hsch() or csch()
Message-ID: <20060322151510.GA5801@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

[patch 1/24] s390: wrong interrupt delivered for hsch() or csch()

When cio waits for the interrupt for a basic sense, interrupts for
hsch() or csch() issued in the meantime are wrongly counted as
interrupts for the basic sense and the accumulated irb is passed to
the device driver. In ccw_device_w4sense(), check for clear or halt
function in the irb and pass the irb for the csch() or hsch() to the
device driver.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device_fsm.c |   12 ++++++++++++
 1 files changed, 12 insertions(+)

diff -urpN linux-2.6/drivers/s390/cio/device_fsm.c linux-2.6-patched/drivers/s390/cio/device_fsm.c
--- linux-2.6/drivers/s390/cio/device_fsm.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device_fsm.c	2006-03-22 14:36:09.000000000 +0100
@@ -827,6 +827,17 @@ ccw_device_w4sense(struct ccw_device *cd
 		}
 		return;
 	}
+	/*
+	 * Check if a halt or clear has been issued in the meanwhile. If yes,
+	 * only deliver the halt/clear interrupt to the device driver as if it
+	 * had killed the original request.
+	 */
+	if (irb->scsw.fctl & (SCSW_FCTL_CLEAR_FUNC | SCSW_FCTL_HALT_FUNC)) {
+		cdev->private->flags.dosense = 0;
+		memset(&cdev->private->irb, 0, sizeof(struct irb));
+		ccw_device_accumulate_irb(cdev, irb);
+		goto call_handler;
+	}
 	/* Add basic sense info to irb. */
 	ccw_device_accumulate_basic_sense(cdev, irb);
 	if (cdev->private->flags.dosense) {
@@ -834,6 +845,7 @@ ccw_device_w4sense(struct ccw_device *cd
 		ccw_device_do_sense(cdev, irb);
 		return;
 	}
+call_handler:
 	cdev->private->state = DEV_STATE_ONLINE;
 	/* Call the handler. */
 	if (ccw_device_call_handler(cdev) && cdev->private->flags.doverify)
