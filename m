Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbWH3Mlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbWH3Mlr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 08:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbWH3Mlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 08:41:47 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:43793 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750900AbWH3Mlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 08:41:46 -0400
Date: Wed, 30 Aug 2006 14:41:43 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, shbader@de.ibm.com
Subject: [S390] cio: unsolicited interrupts during sense pgid.
Message-ID: <20060830124143.GC22276@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Bader <shbader@de.ibm.com>

[S390] cio: unsolicited interrupts during sense pgid.

Calls to set a device online with path grouping may get stuck in
some cases because certain device conditions where discarded after
unsolicited interrupts.
Check subchannel activity after unsolicited interrupts and retry
the operation if the subchannel is idle.

Signed-off-by: Stefan Bader <shbader@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device_pgid.c |   27 +++++++++++++++++++++------
 1 files changed, 21 insertions(+), 6 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/device_pgid.c linux-2.6-patched/drivers/s390/cio/device_pgid.c
--- linux-2.6/drivers/s390/cio/device_pgid.c	2006-08-30 14:24:13.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device_pgid.c	2006-08-30 14:24:35.000000000 +0200
@@ -24,6 +24,21 @@
 #include "ioasm.h"
 
 /*
+ * Helper function called from interrupt context to decide whether an
+ * operation should be tried again.
+ */
+static int __ccw_device_should_retry(struct scsw *scsw)
+{
+	/* CC is only valid if start function bit is set. */
+	if ((scsw->fctl & SCSW_FCTL_START_FUNC) && scsw->cc == 1)
+		return 1;
+	/* No more activity. For sense and set PGID we stubbornly try again. */
+	if (!scsw->actl)
+		return 1;
+	return 0;
+}
+
+/*
  * Start Sense Path Group ID helper function. Used in ccw_device_recog
  * and ccw_device_sense_pgid.
  */
@@ -155,10 +170,10 @@ ccw_device_sense_pgid_irq(struct ccw_dev
 	int ret;
 
 	irb = (struct irb *) __LC_IRB;
-	/* Retry sense pgid for cc=1. */
+
 	if (irb->scsw.stctl ==
 	    (SCSW_STCTL_STATUS_PEND | SCSW_STCTL_ALERT_STATUS)) {
-		if (irb->scsw.cc == 1) {
+		if (__ccw_device_should_retry(&irb->scsw)) {
 			ret = __ccw_device_sense_pgid_start(cdev);
 			if (ret && ret != -EBUSY)
 				ccw_device_sense_pgid_done(cdev, ret);
@@ -391,10 +406,10 @@ ccw_device_verify_irq(struct ccw_device 
 	int ret;
 
 	irb = (struct irb *) __LC_IRB;
-	/* Retry set pgid for cc=1. */
+
 	if (irb->scsw.stctl ==
 	    (SCSW_STCTL_STATUS_PEND | SCSW_STCTL_ALERT_STATUS)) {
-		if (irb->scsw.cc == 1)
+		if (__ccw_device_should_retry(&irb->scsw))
 			__ccw_device_verify_start(cdev);
 		return;
 	}
@@ -494,10 +509,10 @@ ccw_device_disband_irq(struct ccw_device
 	int ret;
 
 	irb = (struct irb *) __LC_IRB;
-	/* Retry set pgid for cc=1. */
+
 	if (irb->scsw.stctl ==
 	    (SCSW_STCTL_STATUS_PEND | SCSW_STCTL_ALERT_STATUS)) {
-		if (irb->scsw.cc == 1)
+		if (__ccw_device_should_retry(&irb->scsw))
 			__ccw_device_disband_start(cdev);
 		return;
 	}
