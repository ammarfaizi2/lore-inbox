Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262362AbVCBQwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbVCBQwr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 11:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbVCBQuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 11:50:52 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:33175 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S262356AbVCBQpk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 11:45:40 -0500
Date: Wed, 2 Mar 2005 17:45:39 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 5/9] s390: irb faking.
Message-ID: <20050302164539.GE27829@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 5/9] s390: irb faking.

From: Cornelia Huck <cohuck@de.ibm.com>

Common i/o layer changes:
 - If a device driver tries to start I/O while the common I/O layer wants
   to start path verification, don't reject the I/O with -EBUSY (which
   might prompt the driver to retry the next tick) but seemingly accept
   the I/O and deliver a fake irb with deferred cc 1 after path
   verification has finished (prompting the driver to retry the I/O).
   This prevents the device driver from doing useless retries while cio
   is still busy with path verification.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/cio/chsc.c       |    3 +++
 drivers/s390/cio/css.h        |    2 ++
 drivers/s390/cio/device_fsm.c |   29 +++++++++++++++++++++++++++++
 drivers/s390/cio/device_ops.c |   10 ++++++++++
 4 files changed, 44 insertions(+)

diff -urN linux-2.6/drivers/s390/cio/chsc.c linux-2.6-patched/drivers/s390/cio/chsc.c
--- linux-2.6/drivers/s390/cio/chsc.c	2005-03-02 17:00:12.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/chsc.c	2005-03-02 17:00:12.000000000 +0100
@@ -703,6 +703,9 @@
 {
 	int cc;
 
+	if (!device_is_online(sch))
+		/* cio could be doing I/O. */
+		return 0;
 	cc = stsch(sch->irq, &sch->schib);
 	if (cc)
 		return 0;
diff -urN linux-2.6/drivers/s390/cio/css.h linux-2.6-patched/drivers/s390/cio/css.h
--- linux-2.6/drivers/s390/cio/css.h	2005-03-02 08:38:34.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/css.h	2005-03-02 17:00:12.000000000 +0100
@@ -84,6 +84,7 @@
 		unsigned int doverify:1;    /* delayed path verification */
 		unsigned int donotify:1;    /* call notify function */
 		unsigned int recog_done:1;  /* dev. recog. complete */
+		unsigned int fake_irb:1;    /* deliver faked irb */
 	} __attribute__((packed)) flags;
 	unsigned long intparm;	/* user interruption parameter */
 	struct qdio_irq *qdio_data;
@@ -136,6 +137,7 @@
 void device_trigger_reprobe(struct subchannel *);
 
 /* Helper functions for vary on/off. */
+int device_is_online(struct subchannel *);
 void device_set_waiting(struct subchannel *);
 
 /* Machine check helper function. */
diff -urN linux-2.6/drivers/s390/cio/device_fsm.c linux-2.6-patched/drivers/s390/cio/device_fsm.c
--- linux-2.6/drivers/s390/cio/device_fsm.c	2005-03-02 17:00:12.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device_fsm.c	2005-03-02 17:00:12.000000000 +0100
@@ -24,6 +24,17 @@
 #include "qdio.h"
 
 int
+device_is_online(struct subchannel *sch)
+{
+	struct ccw_device *cdev;
+
+	if (!sch->dev.driver_data)
+		return 0;
+	cdev = sch->dev.driver_data;
+	return (cdev->private->state == DEV_STATE_ONLINE);
+}
+
+int
 device_is_disconnected(struct subchannel *sch)
 {
 	struct ccw_device *cdev;
@@ -44,6 +55,7 @@
 		return;
 	cdev = sch->dev.driver_data;
 	ccw_device_set_timeout(cdev, 0);
+	cdev->private->flags.fake_irb = 0;
 	cdev->private->state = DEV_STATE_DISCONNECTED;
 }
 
@@ -474,6 +486,7 @@
 	} else {
 		cio_disable_subchannel(sch);
 		ccw_device_set_timeout(cdev, 0);
+		cdev->private->flags.fake_irb = 0;
 		cdev->private->state = DEV_STATE_DISCONNECTED;
 		wake_up(&cdev->private->wait_q);
 	}
@@ -488,6 +501,21 @@
 		cdev->private->options.pgroup = 0;
 	case 0:
 		ccw_device_done(cdev, DEV_STATE_ONLINE);
+		/* Deliver fake irb to device driver, if needed. */
+		if (cdev->private->flags.fake_irb) {
+			memset(&cdev->private->irb, 0, sizeof(struct irb));
+			cdev->private->irb.scsw = (struct scsw) {
+				.cc = 1,
+				.fctl = SCSW_FCTL_START_FUNC,
+				.actl = SCSW_ACTL_START_PEND,
+				.stctl = SCSW_STCTL_STATUS_PEND,
+			};
+			cdev->private->flags.fake_irb = 0;
+			if (cdev->handler)
+				cdev->handler(cdev, cdev->private->intparm,
+					      &cdev->private->irb);
+			memset(&cdev->private->irb, 0, sizeof(struct irb));
+		}
 		break;
 	case -ETIME:
 		ccw_device_done(cdev, DEV_STATE_BOXED);
@@ -639,6 +667,7 @@
 	if (sch->driver->notify &&
 	    sch->driver->notify(&sch->dev, sch->lpm ? CIO_GONE : CIO_NO_PATH)) {
 			ccw_device_set_timeout(cdev, 0);
+			cdev->private->flags.fake_irb = 0;
 			cdev->private->state = DEV_STATE_DISCONNECTED;
 			wake_up(&cdev->private->wait_q);
 			return;
diff -urN linux-2.6/drivers/s390/cio/device_ops.c linux-2.6-patched/drivers/s390/cio/device_ops.c
--- linux-2.6/drivers/s390/cio/device_ops.c	2005-03-02 17:00:12.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device_ops.c	2005-03-02 17:00:12.000000000 +0100
@@ -81,6 +81,16 @@
 		return -ENODEV;
 	if (cdev->private->state == DEV_STATE_NOT_OPER)
 		return -ENODEV;
+	if (cdev->private->state == DEV_STATE_VERIFY) {
+		/* Remember to fake irb when finished. */
+		if (!cdev->private->flags.fake_irb) {
+			cdev->private->flags.fake_irb = 1;
+			cdev->private->intparm = intparm;
+			return 0;
+		} else
+			/* There's already a fake I/O around. */
+			return -EBUSY;
+	}
 	if (cdev->private->state != DEV_STATE_ONLINE ||
 	    ((sch->schib.scsw.stctl & SCSW_STCTL_PRIM_STATUS) &&
 	     !(sch->schib.scsw.stctl & SCSW_STCTL_SEC_STATUS)) ||
