Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbVLIPXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbVLIPXV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 10:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbVLIPXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 10:23:21 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:35514 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932307AbVLIPXP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 10:23:15 -0500
Date: Fri, 9 Dec 2005 16:23:12 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, cohuck@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 2/17] s390: re-activated path detection.
Message-ID: <20051209152312.GC6532@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cohuck@de.ibm.com>

[patch 2/17] s390: re-activated path detection.

If we receive path not operational indications (pnom in pmcw nonzero), we
switch off those paths. To catch them becoming available again, we have to
recalculate the lpm from the pmcw each time we start path verification.

Signed-off-by: Cornelia Huck <cohuck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 drivers/s390/cio/device_pgid.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+)

diff -urpN linux-2.6/drivers/s390/cio/device_pgid.c linux-2.6-patched/drivers/s390/cio/device_pgid.c
--- linux-2.6/drivers/s390/cio/device_pgid.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device_pgid.c	2005-12-09 14:24:21.000000000 +0100
@@ -22,6 +22,7 @@
 #include "cio_debug.h"
 #include "css.h"
 #include "device.h"
+#include "ioasm.h"
 
 /*
  * Start Sense Path Group ID helper function. Used in ccw_device_recog
@@ -364,8 +365,22 @@ ccw_device_verify_irq(struct ccw_device 
 void
 ccw_device_verify_start(struct ccw_device *cdev)
 {
+	struct subchannel *sch = to_subchannel(cdev->dev.parent);
+
 	cdev->private->flags.pgid_single = 0;
 	cdev->private->iretry = 5;
+	/*
+	 * Update sch->lpm with current values to catch paths becoming
+	 * available again.
+	 */
+	if (stsch(sch->irq, &sch->schib)) {
+		ccw_device_verify_done(cdev, -ENODEV);
+		return;
+	}
+	sch->lpm = sch->schib.pmcw.pim &
+		sch->schib.pmcw.pam &
+		sch->schib.pmcw.pom &
+		sch->opm;
 	__ccw_device_verify_start(cdev);
 }
 
