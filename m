Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965259AbWIROPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965259AbWIROPB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 10:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965261AbWIROPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 10:15:01 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:15598 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S965259AbWIROO7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 10:14:59 -0400
Date: Mon, 18 Sep 2006 16:14:56 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, peter.oberparleiter@de.ibm.com
Subject: [S390] cio: always query all paths on path verification.
Message-ID: <20060918141456.GC5612@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

[S390] cio: always query all paths on path verification.

Reappearing channel paths are sometimes not utilized by CCW devices
because path verification incorrectly relies on path-operational-mask
information which is not updated until a channel path has been used
again.
Modify path verification procedure to always query all available paths
to a device.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/chsc.c        |    2 -
 drivers/s390/cio/cio.c         |    5 --
 drivers/s390/cio/device_fsm.c  |   39 +++++++++++--------
 drivers/s390/cio/device_ops.c  |    2 -
 drivers/s390/cio/device_pgid.c |   81 +++++++++++++++++++++--------------------
 5 files changed, 68 insertions(+), 61 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/chsc.c linux-2.6-patched/drivers/s390/cio/chsc.c
--- linux-2.6/drivers/s390/cio/chsc.c	2006-09-18 14:12:00.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/chsc.c	2006-09-18 14:12:02.000000000 +0200
@@ -256,7 +256,7 @@ s390_subchannel_remove_chpid(struct devi
 	/* trigger path verification. */
 	if (sch->driver && sch->driver->verify)
 		sch->driver->verify(&sch->dev);
-	else if (sch->vpm == mask)
+	else if (sch->lpm == mask)
 		goto out_unreg;
 out_unlock:
 	spin_unlock_irq(&sch->lock);
diff -urpN linux-2.6/drivers/s390/cio/cio.c linux-2.6-patched/drivers/s390/cio/cio.c
--- linux-2.6/drivers/s390/cio/cio.c	2006-09-18 14:12:02.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/cio.c	2006-09-18 14:12:02.000000000 +0200
@@ -569,10 +569,7 @@ cio_validate_subchannel (struct subchann
 	sch->opm = 0xff;
 	if (!cio_is_console(sch->schid))
 		chsc_validate_chpids(sch);
-	sch->lpm = sch->schib.pmcw.pim &
-		sch->schib.pmcw.pam &
-		sch->schib.pmcw.pom &
-		sch->opm;
+	sch->lpm = sch->schib.pmcw.pam & sch->opm;
 
 	CIO_DEBUG(KERN_INFO, 0,
 		  "Detected device %04x on subchannel 0.%x.%04X"
diff -urpN linux-2.6/drivers/s390/cio/device_fsm.c linux-2.6-patched/drivers/s390/cio/device_fsm.c
--- linux-2.6/drivers/s390/cio/device_fsm.c	2006-09-18 14:11:43.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device_fsm.c	2006-09-18 14:12:02.000000000 +0200
@@ -232,10 +232,7 @@ ccw_device_recog_done(struct ccw_device 
 	 */
 	old_lpm = sch->lpm;
 	stsch(sch->schid, &sch->schib);
-	sch->lpm = sch->schib.pmcw.pim &
-		sch->schib.pmcw.pam &
-		sch->schib.pmcw.pom &
-		sch->opm;
+	sch->lpm = sch->schib.pmcw.pam & sch->opm;
 	/* Check since device may again have become not operational. */
 	if (!sch->schib.pmcw.dnv)
 		state = DEV_STATE_NOT_OPER;
@@ -455,8 +452,8 @@ ccw_device_sense_pgid_done(struct ccw_de
 		return;
 	}
 	/* Start Path Group verification. */
-	sch->vpm = 0;	/* Start with no path groups set. */
 	cdev->private->state = DEV_STATE_VERIFY;
+	cdev->private->flags.doverify = 0;
 	ccw_device_verify_start(cdev);
 }
 
@@ -556,7 +553,19 @@ ccw_device_nopath_notify(void *data)
 void
 ccw_device_verify_done(struct ccw_device *cdev, int err)
 {
-	cdev->private->flags.doverify = 0;
+	struct subchannel *sch;
+
+	sch = to_subchannel(cdev->dev.parent);
+	/* Update schib - pom may have changed. */
+	stsch(sch->schid, &sch->schib);
+	/* Update lpm with verified path mask. */
+	sch->lpm = sch->vpm;
+	/* Repeat path verification? */
+	if (cdev->private->flags.doverify) {
+		cdev->private->flags.doverify = 0;
+		ccw_device_verify_start(cdev);
+		return;
+	}
 	switch (err) {
 	case -EOPNOTSUPP: /* path grouping not supported, just set online. */
 		cdev->private->options.pgroup = 0;
@@ -614,6 +623,7 @@ ccw_device_online(struct ccw_device *cde
 	if (!cdev->private->options.pgroup) {
 		/* Start initial path verification. */
 		cdev->private->state = DEV_STATE_VERIFY;
+		cdev->private->flags.doverify = 0;
 		ccw_device_verify_start(cdev);
 		return 0;
 	}
@@ -660,7 +670,6 @@ ccw_device_offline(struct ccw_device *cd
 	/* Are we doing path grouping? */
 	if (!cdev->private->options.pgroup) {
 		/* No, set state offline immediately. */
-		sch->vpm = 0;
 		ccw_device_done(cdev, DEV_STATE_OFFLINE);
 		return 0;
 	}
@@ -781,6 +790,7 @@ ccw_device_online_verify(struct ccw_devi
 	}
 	/* Device is idle, we can do the path verification. */
 	cdev->private->state = DEV_STATE_VERIFY;
+	cdev->private->flags.doverify = 0;
 	ccw_device_verify_start(cdev);
 }
 
@@ -1043,9 +1053,9 @@ ccw_device_wait4io_timeout(struct ccw_de
 }
 
 static void
-ccw_device_wait4io_verify(struct ccw_device *cdev, enum dev_event dev_event)
+ccw_device_delay_verify(struct ccw_device *cdev, enum dev_event dev_event)
 {
-	/* When the I/O has terminated, we have to start verification. */
+	/* Start verification after current task finished. */
 	cdev->private->flags.doverify = 1;
 }
 
@@ -1111,10 +1121,7 @@ device_trigger_reprobe(struct subchannel
 	 * The pim, pam, pom values may not be accurate, but they are the best
 	 * we have before performing device selection :/
 	 */
-	sch->lpm = sch->schib.pmcw.pim &
-		sch->schib.pmcw.pam &
-		sch->schib.pmcw.pom &
-		sch->opm;
+	sch->lpm = sch->schib.pmcw.pam & sch->opm;
 	/* Re-set some bits in the pmcw that were lost. */
 	sch->schib.pmcw.isc = 3;
 	sch->schib.pmcw.csense = 1;
@@ -1238,7 +1245,7 @@ fsm_func_t *dev_jumptable[NR_DEV_STATES]
 		[DEV_EVENT_NOTOPER]	= ccw_device_online_notoper,
 		[DEV_EVENT_INTERRUPT]	= ccw_device_verify_irq,
 		[DEV_EVENT_TIMEOUT]	= ccw_device_onoff_timeout,
-		[DEV_EVENT_VERIFY]	= ccw_device_nop,
+		[DEV_EVENT_VERIFY]	= ccw_device_delay_verify,
 	},
 	[DEV_STATE_ONLINE] = {
 		[DEV_EVENT_NOTOPER]	= ccw_device_online_notoper,
@@ -1281,7 +1288,7 @@ fsm_func_t *dev_jumptable[NR_DEV_STATES]
 		[DEV_EVENT_NOTOPER]	= ccw_device_online_notoper,
 		[DEV_EVENT_INTERRUPT]	= ccw_device_wait4io_irq,
 		[DEV_EVENT_TIMEOUT]	= ccw_device_wait4io_timeout,
-		[DEV_EVENT_VERIFY]	= ccw_device_wait4io_verify,
+		[DEV_EVENT_VERIFY]	= ccw_device_delay_verify,
 	},
 	[DEV_STATE_QUIESCE] = {
 		[DEV_EVENT_NOTOPER]	= ccw_device_quiesce_done,
@@ -1294,7 +1301,7 @@ fsm_func_t *dev_jumptable[NR_DEV_STATES]
 		[DEV_EVENT_NOTOPER]	= ccw_device_nop,
 		[DEV_EVENT_INTERRUPT]	= ccw_device_start_id,
 		[DEV_EVENT_TIMEOUT]	= ccw_device_bug,
-		[DEV_EVENT_VERIFY]	= ccw_device_nop,
+		[DEV_EVENT_VERIFY]	= ccw_device_start_id,
 	},
 	[DEV_STATE_DISCONNECTED_SENSE_ID] = {
 		[DEV_EVENT_NOTOPER]	= ccw_device_recog_notoper,
diff -urpN linux-2.6/drivers/s390/cio/device_ops.c linux-2.6-patched/drivers/s390/cio/device_ops.c
--- linux-2.6/drivers/s390/cio/device_ops.c	2006-09-18 14:12:02.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device_ops.c	2006-09-18 14:12:02.000000000 +0200
@@ -256,7 +256,7 @@ ccw_device_get_path_mask(struct ccw_devi
 	if (!sch)
 		return 0;
 	else
-		return sch->vpm;
+		return sch->lpm;
 }
 
 static void
diff -urpN linux-2.6/drivers/s390/cio/device_pgid.c linux-2.6-patched/drivers/s390/cio/device_pgid.c
--- linux-2.6/drivers/s390/cio/device_pgid.c	2006-09-18 14:11:04.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device_pgid.c	2006-09-18 14:12:02.000000000 +0200
@@ -245,18 +245,17 @@ __ccw_device_do_pgid(struct ccw_device *
 	memset(&cdev->private->irb, 0, sizeof(struct irb));
 
 	/* Try multiple times. */
-	ret = -ENODEV;
+	ret = -EACCES;
 	if (cdev->private->iretry > 0) {
 		cdev->private->iretry--;
 		ret = cio_start (sch, cdev->private->iccws,
 				 cdev->private->imask);
-		/* ret is 0, -EBUSY, -EACCES or -ENODEV */
-		if ((ret != -EACCES) && (ret != -ENODEV))
+		/* We expect an interrupt in case of success or busy
+		 * indication. */
+		if ((ret == 0) || (ret == -EBUSY))
 			return ret;
 	}
-	/* PGID command failed on this path. Switch it off. */
-	sch->lpm &= ~cdev->private->imask;
-	sch->vpm &= ~cdev->private->imask;
+	/* PGID command failed on this path. */
 	CIO_MSG_EVENT(2, "SPID - Device %04x on Subchannel "
 		      "0.%x.%04x, lpm %02X, became 'not operational'\n",
 		      cdev->private->devno, sch->schid.ssid,
@@ -286,18 +285,17 @@ static int __ccw_device_do_nop(struct cc
 	memset(&cdev->private->irb, 0, sizeof(struct irb));
 
 	/* Try multiple times. */
-	ret = -ENODEV;
+	ret = -EACCES;
 	if (cdev->private->iretry > 0) {
 		cdev->private->iretry--;
 		ret = cio_start (sch, cdev->private->iccws,
 				 cdev->private->imask);
-		/* ret is 0, -EBUSY, -EACCES or -ENODEV */
-		if ((ret != -EACCES) && (ret != -ENODEV))
+		/* We expect an interrupt in case of success or busy
+		 * indication. */
+		if ((ret == 0) || (ret == -EBUSY))
 			return ret;
 	}
-	/* nop command failed on this path. Switch it off. */
-	sch->lpm &= ~cdev->private->imask;
-	sch->vpm &= ~cdev->private->imask;
+	/* nop command failed on this path. */
 	CIO_MSG_EVENT(2, "NOP - Device %04x on Subchannel "
 		      "0.%x.%04x, lpm %02X, became 'not operational'\n",
 		      cdev->private->devno, sch->schid.ssid,
@@ -372,27 +370,32 @@ static void
 __ccw_device_verify_start(struct ccw_device *cdev)
 {
 	struct subchannel *sch;
-	__u8 imask, func;
+	__u8 func;
 	int ret;
 
 	sch = to_subchannel(cdev->dev.parent);
-	while (sch->vpm != sch->lpm) {
-		/* Find first unequal bit in vpm vs. lpm */
-		for (imask = 0x80; imask != 0; imask >>= 1)
-			if ((sch->vpm & imask) != (sch->lpm & imask))
-				break;
-		cdev->private->imask = imask;
+	/* Repeat for all paths. */
+	for (; cdev->private->imask; cdev->private->imask >>= 1,
+				     cdev->private->iretry = 5) {
+		if ((cdev->private->imask & sch->schib.pmcw.pam) == 0)
+			/* Path not available, try next. */
+			continue;
 		if (cdev->private->options.pgroup) {
-			func = (sch->vpm & imask) ?
-				SPID_FUNC_RESIGN : SPID_FUNC_ESTABLISH;
+			if (sch->opm & cdev->private->imask)
+				func = SPID_FUNC_ESTABLISH;
+			else
+				func = SPID_FUNC_RESIGN;
 			ret = __ccw_device_do_pgid(cdev, func);
 		} else
 			ret = __ccw_device_do_nop(cdev);
+		/* We expect an interrupt in case of success or busy
+		 * indication. */
 		if (ret == 0 || ret == -EBUSY)
 			return;
-		cdev->private->iretry = 5;
+		/* Permanent path failure, try next. */
 	}
-	ccw_device_verify_done(cdev, (sch->lpm != 0) ? 0 : -ENODEV);
+	/* Done with all paths. */
+	ccw_device_verify_done(cdev, (sch->vpm != 0) ? 0 : -ENODEV);
 }
 		
 /*
@@ -421,14 +424,14 @@ ccw_device_verify_irq(struct ccw_device 
 	else
 		ret = __ccw_device_check_nop(cdev);
 	memset(&cdev->private->irb, 0, sizeof(struct irb));
+
 	switch (ret) {
 	/* 0, -ETIME, -EAGAIN, -EOPNOTSUPP or -EACCES */
 	case 0:
-		/* Establish or Resign Path Group done. Update vpm. */
-		if ((sch->lpm & cdev->private->imask) != 0)
-			sch->vpm |= cdev->private->imask;
-		else
-			sch->vpm &= ~cdev->private->imask;
+		/* Path verification ccw finished successfully, update lpm. */
+		sch->vpm |= sch->opm & cdev->private->imask;
+		/* Go on with next path. */
+		cdev->private->imask >>= 1;
 		cdev->private->iretry = 5;
 		__ccw_device_verify_start(cdev);
 		break;
@@ -441,6 +444,10 @@ ccw_device_verify_irq(struct ccw_device 
 			cdev->private->options.pgroup = 0;
 		else
 			cdev->private->flags.pgid_single = 1;
+		/* Retry */
+		sch->vpm = 0;
+		cdev->private->imask = 0x80;
+		cdev->private->iretry = 5;
 		/* fall through. */
 	case -EAGAIN:		/* Try again. */
 		__ccw_device_verify_start(cdev);
@@ -449,8 +456,7 @@ ccw_device_verify_irq(struct ccw_device 
 		ccw_device_verify_done(cdev, -ETIME);
 		break;
 	case -EACCES:		/* channel is not operational. */
-		sch->lpm &= ~cdev->private->imask;
-		sch->vpm &= ~cdev->private->imask;
+		cdev->private->imask >>= 1;
 		cdev->private->iretry = 5;
 		__ccw_device_verify_start(cdev);
 		break;
@@ -463,19 +469,17 @@ ccw_device_verify_start(struct ccw_devic
 	struct subchannel *sch = to_subchannel(cdev->dev.parent);
 
 	cdev->private->flags.pgid_single = 0;
+	cdev->private->imask = 0x80;
 	cdev->private->iretry = 5;
-	/*
-	 * Update sch->lpm with current values to catch paths becoming
-	 * available again.
-	 */
+
+	/* Start with empty vpm. */
+	sch->vpm = 0;
+
+	/* Get current pam. */
 	if (stsch(sch->schid, &sch->schib)) {
 		ccw_device_verify_done(cdev, -ENODEV);
 		return;
 	}
-	sch->lpm = sch->schib.pmcw.pim &
-		sch->schib.pmcw.pam &
-		sch->schib.pmcw.pom &
-		sch->opm;
 	__ccw_device_verify_start(cdev);
 }
 
@@ -524,7 +528,6 @@ ccw_device_disband_irq(struct ccw_device
 	switch (ret) {
 	/* 0, -ETIME, -EAGAIN, -EOPNOTSUPP or -EACCES */
 	case 0:			/* disband successful. */
-		sch->vpm = 0;
 		ccw_device_disband_done(cdev, ret);
 		break;
 	case -EOPNOTSUPP:
