Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936944AbWLDO5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936944AbWLDO5c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 09:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936960AbWLDO52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 09:57:28 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:6297 "EHLO
	mtagate6.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936944AbWLDO5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 09:57:17 -0500
Date: Mon, 4 Dec 2006 15:57:12 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, cornelia.huck@de.ibm.com
Subject: [S390] cio: Retry internal operations after vary off.
Message-ID: <20061204145712.GF32059@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

[S390] cio: Retry internal operations after vary off.

If I/O was running on a just varied off chpid, it will be terminated.
If this was a common I/O layer internal I/O, it needs to be retried.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/chsc.c          |   37 ++++++++++++++++++++++++++++++-------
 drivers/s390/cio/css.h           |    2 ++
 drivers/s390/cio/device.c        |    3 +++
 drivers/s390/cio/device_fsm.c    |   16 ++++++++++++++++
 drivers/s390/cio/device_id.c     |   10 +++++++++-
 drivers/s390/cio/device_pgid.c   |   30 +++++++++++++++++++++++++++---
 drivers/s390/cio/device_status.c |    3 +++
 7 files changed, 90 insertions(+), 11 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/chsc.c linux-2.6-patched/drivers/s390/cio/chsc.c
--- linux-2.6/drivers/s390/cio/chsc.c	2006-12-04 14:51:05.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/chsc.c	2006-12-04 14:51:05.000000000 +0100
@@ -251,6 +251,8 @@ s390_subchannel_remove_chpid(struct devi
 		cc = cio_clear(sch);
 		if (cc == -ENODEV)
 			goto out_unreg;
+		/* Request retry of internal operation. */
+		device_set_intretry(sch);
 		/* Call handler. */
 		if (sch->driver && sch->driver->termination)
 			sch->driver->termination(&sch->dev);
@@ -711,9 +713,6 @@ static inline int check_for_io_on_path(s
 {
 	int cc;
 
-	if (!device_is_online(sch))
-		/* cio could be doing I/O. */
-		return 0;
 	cc = stsch(sch->schid, &sch->schib);
 	if (cc)
 		return 0;
@@ -722,6 +721,26 @@ static inline int check_for_io_on_path(s
 	return 0;
 }
 
+static void terminate_internal_io(struct subchannel *sch)
+{
+	if (cio_clear(sch)) {
+		/* Recheck device in case clear failed. */
+		sch->lpm = 0;
+		if (device_trigger_verify(sch) != 0) {
+			if(css_enqueue_subchannel_slow(sch->schid)) {
+				css_clear_subchannel_slow_list();
+				need_rescan = 1;
+			}
+		}
+		return;
+	}
+	/* Request retry of internal operation. */
+	device_set_intretry(sch);
+	/* Call handler. */
+	if (sch->driver && sch->driver->termination)
+		sch->driver->termination(&sch->dev);
+}
+
 static inline void
 __s390_subchannel_vary_chpid(struct subchannel *sch, __u8 chpid, int on)
 {
@@ -748,10 +767,14 @@ __s390_subchannel_vary_chpid(struct subc
 		}
 		sch->opm &= ~(0x80 >> chp);
 		sch->lpm &= ~(0x80 >> chp);
-		if (check_for_io_on_path(sch, chp))
-			/* Path verification is done after killing. */
-			device_kill_io(sch);
-		else if (!sch->lpm) {
+		if (check_for_io_on_path(sch, chp)) {
+			if (device_is_online(sch))
+				/* Path verification is done after killing. */
+				device_kill_io(sch);
+			else
+				/* Kill and retry internal I/O. */
+				terminate_internal_io(sch);
+		} else if (!sch->lpm) {
 			if (device_trigger_verify(sch) != 0) {
 				if (css_enqueue_subchannel_slow(sch->schid)) {
 					css_clear_subchannel_slow_list();
diff -urpN linux-2.6/drivers/s390/cio/css.h linux-2.6-patched/drivers/s390/cio/css.h
--- linux-2.6/drivers/s390/cio/css.h	2006-12-04 14:51:05.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/css.h	2006-12-04 14:51:05.000000000 +0100
@@ -94,6 +94,7 @@ struct ccw_device_private {
 		unsigned int donotify:1;    /* call notify function */
 		unsigned int recog_done:1;  /* dev. recog. complete */
 		unsigned int fake_irb:1;    /* deliver faked irb */
+		unsigned int intretry:1;    /* retry internal operation */
 	} __attribute__((packed)) flags;
 	unsigned long intparm;	/* user interruption parameter */
 	struct qdio_irq *qdio_data;
@@ -171,6 +172,7 @@ void device_trigger_reprobe(struct subch
 /* Helper functions for vary on/off. */
 int device_is_online(struct subchannel *);
 void device_kill_io(struct subchannel *);
+void device_set_intretry(struct subchannel *sch);
 int device_trigger_verify(struct subchannel *sch);
 
 /* Machine check helper function. */
diff -urpN linux-2.6/drivers/s390/cio/device.c linux-2.6-patched/drivers/s390/cio/device.c
--- linux-2.6/drivers/s390/cio/device.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device.c	2006-12-04 14:51:05.000000000 +0100
@@ -948,6 +948,9 @@ io_subchannel_ioterm(struct device *dev)
 	cdev = dev->driver_data;
 	if (!cdev)
 		return;
+	/* Internal I/O will be retried by the interrupt handler. */
+	if (cdev->private->flags.intretry)
+		return;
 	cdev->private->state = DEV_STATE_CLEAR_VERIFY;
 	if (cdev->handler)
 		cdev->handler(cdev, cdev->private->intparm,
diff -urpN linux-2.6/drivers/s390/cio/device_fsm.c linux-2.6-patched/drivers/s390/cio/device_fsm.c
--- linux-2.6/drivers/s390/cio/device_fsm.c	2006-12-04 14:51:05.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device_fsm.c	2006-12-04 14:51:05.000000000 +0100
@@ -59,6 +59,16 @@ device_set_disconnected(struct subchanne
 	cdev->private->state = DEV_STATE_DISCONNECTED;
 }
 
+void device_set_intretry(struct subchannel *sch)
+{
+	struct ccw_device *cdev;
+
+	cdev = sch->dev.driver_data;
+	if (!cdev)
+		return;
+	cdev->private->flags.intretry = 1;
+}
+
 int device_trigger_verify(struct subchannel *sch)
 {
 	struct ccw_device *cdev;
@@ -904,6 +914,12 @@ ccw_device_w4sense(struct ccw_device *cd
 	 * had killed the original request.
 	 */
 	if (irb->scsw.fctl & (SCSW_FCTL_CLEAR_FUNC | SCSW_FCTL_HALT_FUNC)) {
+		/* Retry Basic Sense if requested. */
+		if (cdev->private->flags.intretry) {
+			cdev->private->flags.intretry = 0;
+			ccw_device_do_sense(cdev, irb);
+			return;
+		}
 		cdev->private->flags.dosense = 0;
 		memset(&cdev->private->irb, 0, sizeof(struct irb));
 		ccw_device_accumulate_irb(cdev, irb);
diff -urpN linux-2.6/drivers/s390/cio/device_id.c linux-2.6-patched/drivers/s390/cio/device_id.c
--- linux-2.6/drivers/s390/cio/device_id.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device_id.c	2006-12-04 14:51:05.000000000 +0100
@@ -191,6 +191,8 @@ __ccw_device_sense_id_start(struct ccw_d
 		if ((sch->opm & cdev->private->imask) != 0 &&
 		    cdev->private->iretry > 0) {
 			cdev->private->iretry--;
+			/* Reset internal retry indication. */
+			cdev->private->flags.intretry = 0;
 			ret = cio_start (sch, cdev->private->iccws,
 					 cdev->private->imask);
 			/* ret is 0, -EBUSY, -EACCES or -ENODEV */
@@ -237,8 +239,14 @@ ccw_device_check_sense_id(struct ccw_dev
 		return 0; /* Success */
 	}
 	/* Check the error cases. */
-	if (irb->scsw.fctl & (SCSW_FCTL_HALT_FUNC | SCSW_FCTL_CLEAR_FUNC))
+	if (irb->scsw.fctl & (SCSW_FCTL_HALT_FUNC | SCSW_FCTL_CLEAR_FUNC)) {
+		/* Retry Sense ID if requested. */
+		if (cdev->private->flags.intretry) {
+			cdev->private->flags.intretry = 0;
+			return -EAGAIN;
+		}
 		return -ETIME;
+	}
 	if (irb->esw.esw0.erw.cons && (irb->ecw[0] & SNS0_CMD_REJECT)) {
 		/*
 		 * if the device doesn't support the SenseID
diff -urpN linux-2.6/drivers/s390/cio/device_pgid.c linux-2.6-patched/drivers/s390/cio/device_pgid.c
--- linux-2.6/drivers/s390/cio/device_pgid.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device_pgid.c	2006-12-04 14:51:05.000000000 +0100
@@ -71,6 +71,8 @@ __ccw_device_sense_pgid_start(struct ccw
 		ccw->cda = (__u32) __pa (&cdev->private->pgid[i]);
 		if (cdev->private->iretry > 0) {
 			cdev->private->iretry--;
+			/* Reset internal retry indication. */
+			cdev->private->flags.intretry = 0;
 			ret = cio_start (sch, cdev->private->iccws, 
 					 cdev->private->imask);
 			/* ret is 0, -EBUSY, -EACCES or -ENODEV */
@@ -122,8 +124,14 @@ __ccw_device_check_sense_pgid(struct ccw
 
 	sch = to_subchannel(cdev->dev.parent);
 	irb = &cdev->private->irb;
-	if (irb->scsw.fctl & (SCSW_FCTL_HALT_FUNC | SCSW_FCTL_CLEAR_FUNC))
+	if (irb->scsw.fctl & (SCSW_FCTL_HALT_FUNC | SCSW_FCTL_CLEAR_FUNC)) {
+		/* Retry Sense PGID if requested. */
+		if (cdev->private->flags.intretry) {
+			cdev->private->flags.intretry = 0;
+			return -EAGAIN;
+		}
 		return -ETIME;
+	}
 	if (irb->esw.esw0.erw.cons &&
 	    (irb->ecw[0]&(SNS0_CMD_REJECT|SNS0_INTERVENTION_REQ))) {
 		/*
@@ -253,6 +261,8 @@ __ccw_device_do_pgid(struct ccw_device *
 	ret = -EACCES;
 	if (cdev->private->iretry > 0) {
 		cdev->private->iretry--;
+		/* Reset internal retry indication. */
+		cdev->private->flags.intretry = 0;
 		ret = cio_start (sch, cdev->private->iccws,
 				 cdev->private->imask);
 		/* We expect an interrupt in case of success or busy
@@ -293,6 +303,8 @@ static int __ccw_device_do_nop(struct cc
 	ret = -EACCES;
 	if (cdev->private->iretry > 0) {
 		cdev->private->iretry--;
+		/* Reset internal retry indication. */
+		cdev->private->flags.intretry = 0;
 		ret = cio_start (sch, cdev->private->iccws,
 				 cdev->private->imask);
 		/* We expect an interrupt in case of success or busy
@@ -321,8 +333,14 @@ __ccw_device_check_pgid(struct ccw_devic
 
 	sch = to_subchannel(cdev->dev.parent);
 	irb = &cdev->private->irb;
-	if (irb->scsw.fctl & (SCSW_FCTL_HALT_FUNC | SCSW_FCTL_CLEAR_FUNC))
+	if (irb->scsw.fctl & (SCSW_FCTL_HALT_FUNC | SCSW_FCTL_CLEAR_FUNC)) {
+		/* Retry Set PGID if requested. */
+		if (cdev->private->flags.intretry) {
+			cdev->private->flags.intretry = 0;
+			return -EAGAIN;
+		}
 		return -ETIME;
+	}
 	if (irb->esw.esw0.erw.cons) {
 		if (irb->ecw[0] & SNS0_CMD_REJECT)
 			return -EOPNOTSUPP;
@@ -360,8 +378,14 @@ static int __ccw_device_check_nop(struct
 
 	sch = to_subchannel(cdev->dev.parent);
 	irb = &cdev->private->irb;
-	if (irb->scsw.fctl & (SCSW_FCTL_HALT_FUNC | SCSW_FCTL_CLEAR_FUNC))
+	if (irb->scsw.fctl & (SCSW_FCTL_HALT_FUNC | SCSW_FCTL_CLEAR_FUNC)) {
+		/* Retry NOP if requested. */
+		if (cdev->private->flags.intretry) {
+			cdev->private->flags.intretry = 0;
+			return -EAGAIN;
+		}
 		return -ETIME;
+	}
 	if (irb->scsw.cc == 3) {
 		CIO_MSG_EVENT(2, "NOP - Device %04x on Subchannel 0.%x.%04x,"
 			      " lpm %02X, became 'not operational'\n",
diff -urpN linux-2.6/drivers/s390/cio/device_status.c linux-2.6-patched/drivers/s390/cio/device_status.c
--- linux-2.6/drivers/s390/cio/device_status.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device_status.c	2006-12-04 14:51:05.000000000 +0100
@@ -319,6 +319,9 @@ ccw_device_do_sense(struct ccw_device *c
 	sch->sense_ccw.count = SENSE_MAX_COUNT;
 	sch->sense_ccw.flags = CCW_FLAG_SLI;
 
+	/* Reset internal retry indication. */
+	cdev->private->flags.intretry = 0;
+
 	return cio_start (sch, &sch->sense_ccw, 0xff);
 }
 
