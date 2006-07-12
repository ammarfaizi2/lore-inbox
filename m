Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbWGLPMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWGLPMO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 11:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWGLPMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 11:12:13 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:43259 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751392AbWGLPML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 11:12:11 -0400
Date: Wed, 12 Jul 2006 17:12:11 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, cornelia.huck@de.ibm.com
Subject: [patch] s390: path grouping and path verifications fixes.
Message-ID: <20060712151211.GB10588@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

[S390] path grouping and path verifications fixes.

1. Multipath devices for which SetPGID is not supported are not handled well.
   Use NOP ccws for path verification (sans path grouping) when SetPGID is not
   supported.
2. Check for PGIDs already set with SensePGID on _all_ paths (not just the
   first one) and try to find a common one. Moan if no common PGID can be
   found (and use NOP verification). If no PGIDs have been set, use the css
   global PGID (as before). (Rationale: SetPGID will get a command reject if
   the PGID it tries to set does not match the already set PGID.)
3. Immediately before reboot, issue RESET CHANNEL PATH (rcp) on all chpids. This
   will remove the old PGIDs. rcp will generate solicited CRWs which can be
   savely ignored by the machine check handler (all other actions create
   unsolicited CRWs).

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/machine_kexec.c |    1 
 drivers/s390/cio/chsc.c          |   34 ++++++++++
 drivers/s390/cio/cio.c           |    1 
 drivers/s390/cio/css.c           |   12 ++-
 drivers/s390/cio/css.h           |    2 
 drivers/s390/cio/device_fsm.c    |   85 +++++++++++++++++++++------
 drivers/s390/cio/device_pgid.c   |  122 +++++++++++++++++++++++++++++++--------
 drivers/s390/cio/device_status.c |    7 --
 drivers/s390/s390mach.c          |   10 +++
 include/asm-s390/cio.h           |    2 
 10 files changed, 228 insertions(+), 48 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/machine_kexec.c linux-2.6-patched/arch/s390/kernel/machine_kexec.c
--- linux-2.6/arch/s390/kernel/machine_kexec.c	2006-07-12 16:25:01.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/machine_kexec.c	2006-07-12 16:25:29.000000000 +0200
@@ -63,6 +63,7 @@ NORET_TYPE void
 machine_kexec(struct kimage *image)
 {
 	clear_all_subchannels();
+	cio_reset_channel_paths();
 
 	/* Disable lowcore protection */
 	ctl_clear_bit(0,28);
diff -urpN linux-2.6/drivers/s390/cio/chsc.c linux-2.6-patched/drivers/s390/cio/chsc.c
--- linux-2.6/drivers/s390/cio/chsc.c	2006-07-12 16:25:07.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/chsc.c	2006-07-12 16:25:29.000000000 +0200
@@ -1464,6 +1464,40 @@ chsc_get_chp_desc(struct subchannel *sch
 	return desc;
 }
 
+static int reset_channel_path(struct channel_path *chp)
+{
+	int cc;
+
+	cc = rchp(chp->id);
+	switch (cc) {
+	case 0:
+		return 0;
+	case 2:
+		return -EBUSY;
+	default:
+		return -ENODEV;
+	}
+}
+
+static void reset_channel_paths_css(struct channel_subsystem *css)
+{
+	int i;
+
+	for (i = 0; i <= __MAX_CHPID; i++) {
+		if (css->chps[i])
+			reset_channel_path(css->chps[i]);
+	}
+}
+
+void cio_reset_channel_paths(void)
+{
+	int i;
+
+	for (i = 0; i <= __MAX_CSSID; i++) {
+		if (css[i] && css[i]->valid)
+			reset_channel_paths_css(css[i]);
+	}
+}
 
 static int __init
 chsc_alloc_sei_area(void)
diff -urpN linux-2.6/drivers/s390/cio/cio.c linux-2.6-patched/drivers/s390/cio/cio.c
--- linux-2.6/drivers/s390/cio/cio.c	2006-07-12 16:25:26.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/cio.c	2006-07-12 16:25:29.000000000 +0200
@@ -876,5 +876,6 @@ void
 reipl(unsigned long devno)
 {
 	clear_all_subchannels();
+	cio_reset_channel_paths();
 	do_reipl(devno);
 }
diff -urpN linux-2.6/drivers/s390/cio/css.c linux-2.6-patched/drivers/s390/cio/css.c
--- linux-2.6/drivers/s390/cio/css.c	2006-07-12 16:25:26.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/css.c	2006-07-12 16:25:29.000000000 +0200
@@ -623,9 +623,13 @@ init_channel_subsystem (void)
 		ret = device_register(&css[i]->device);
 		if (ret)
 			goto out_free;
-		if (css_characteristics_avail && css_chsc_characteristics.secm)
-			device_create_file(&css[i]->device,
-					   &dev_attr_cm_enable);
+		if (css_characteristics_avail &&
+		    css_chsc_characteristics.secm) {
+			ret = device_create_file(&css[i]->device,
+						 &dev_attr_cm_enable);
+			if (ret)
+				goto out_device;
+		}
 	}
 	css_init_done = 1;
 
@@ -633,6 +637,8 @@ init_channel_subsystem (void)
 
 	for_each_subchannel(__init_channel_subsystem, NULL);
 	return 0;
+out_device:
+	device_unregister(&css[i]->device);
 out_free:
 	kfree(css[i]);
 out_unregister:
diff -urpN linux-2.6/drivers/s390/cio/css.h linux-2.6-patched/drivers/s390/cio/css.h
--- linux-2.6/drivers/s390/cio/css.h	2006-07-12 16:25:26.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/css.h	2006-07-12 16:25:29.000000000 +0200
@@ -100,7 +100,7 @@ struct ccw_device_private {
 	struct qdio_irq *qdio_data;
 	struct irb irb;		/* device status */
 	struct senseid senseid;	/* SenseID info */
-	struct pgid pgid;	/* path group ID */
+	struct pgid pgid[8];	/* path group IDs per chpid*/
 	struct ccw1 iccws[2];	/* ccws for SNID/SID/SPGID commands */
 	struct work_struct kick_work;
 	wait_queue_head_t wait_q;
diff -urpN linux-2.6/drivers/s390/cio/device_fsm.c linux-2.6-patched/drivers/s390/cio/device_fsm.c
--- linux-2.6/drivers/s390/cio/device_fsm.c	2006-07-12 16:25:07.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device_fsm.c	2006-07-12 16:25:29.000000000 +0200
@@ -378,6 +378,56 @@ ccw_device_done(struct ccw_device *cdev,
 		put_device (&cdev->dev);
 }
 
+static inline int cmp_pgid(struct pgid *p1, struct pgid *p2)
+{
+	char *c1;
+	char *c2;
+
+	c1 = (char *)p1;
+	c2 = (char *)p2;
+
+	return memcmp(c1 + 1, c2 + 1, sizeof(struct pgid) - 1);
+}
+
+static void __ccw_device_get_common_pgid(struct ccw_device *cdev)
+{
+	int i;
+	int last;
+
+	last = 0;
+	for (i = 0; i < 8; i++) {
+		if (cdev->private->pgid[i].inf.ps.state1 == SNID_STATE1_RESET)
+			/* No PGID yet */
+			continue;
+		if (cdev->private->pgid[last].inf.ps.state1 ==
+		    SNID_STATE1_RESET) {
+			/* First non-zero PGID */
+			last = i;
+			continue;
+		}
+		if (cmp_pgid(&cdev->private->pgid[i],
+			     &cdev->private->pgid[last]) == 0)
+			/* Non-conflicting PGIDs */
+			continue;
+
+		/* PGID mismatch, can't pathgroup. */
+		CIO_MSG_EVENT(0, "SNID - pgid mismatch for device "
+			      "0.%x.%04x, can't pathgroup\n",
+			      cdev->private->ssid, cdev->private->devno);
+		cdev->private->options.pgroup = 0;
+		return;
+	}
+	if (cdev->private->pgid[last].inf.ps.state1 ==
+	    SNID_STATE1_RESET)
+		/* No previous pgid found */
+		memcpy(&cdev->private->pgid[0], &css[0]->global_pgid,
+		       sizeof(struct pgid));
+	else
+		/* Use existing pgid */
+		memcpy(&cdev->private->pgid[0], &cdev->private->pgid[last],
+		       sizeof(struct pgid));
+}
+
 /*
  * Function called from device_pgid.c after sense path ground has completed.
  */
@@ -388,24 +438,26 @@ ccw_device_sense_pgid_done(struct ccw_de
 
 	sch = to_subchannel(cdev->dev.parent);
 	switch (err) {
-	case 0:
-		/* Start Path Group verification. */
-		sch->vpm = 0;	/* Start with no path groups set. */
-		cdev->private->state = DEV_STATE_VERIFY;
-		ccw_device_verify_start(cdev);
+	case -EOPNOTSUPP: /* path grouping not supported, use nop instead. */
+		cdev->private->options.pgroup = 0;
+		break;
+	case 0: /* success */
+	case -EACCES: /* partial success, some paths not operational */
+		/* Check if all pgids are equal or 0. */
+		__ccw_device_get_common_pgid(cdev);
 		break;
 	case -ETIME:		/* Sense path group id stopped by timeout. */
 	case -EUSERS:		/* device is reserved for someone else. */
 		ccw_device_done(cdev, DEV_STATE_BOXED);
-		break;
-	case -EOPNOTSUPP: /* path grouping not supported, just set online. */
-		cdev->private->options.pgroup = 0;
-		ccw_device_done(cdev, DEV_STATE_ONLINE);
-		break;
+		return;
 	default:
 		ccw_device_done(cdev, DEV_STATE_NOT_OPER);
-		break;
+		return;
 	}
+	/* Start Path Group verification. */
+	sch->vpm = 0;	/* Start with no path groups set. */
+	cdev->private->state = DEV_STATE_VERIFY;
+	ccw_device_verify_start(cdev);
 }
 
 /*
@@ -562,8 +614,9 @@ ccw_device_online(struct ccw_device *cde
 	}
 	/* Do we want to do path grouping? */
 	if (!cdev->private->options.pgroup) {
-		/* No, set state online immediately. */
-		ccw_device_done(cdev, DEV_STATE_ONLINE);
+		/* Start initial path verification. */
+		cdev->private->state = DEV_STATE_VERIFY;
+		ccw_device_verify_start(cdev);
 		return 0;
 	}
 	/* Do a SensePGID first. */
@@ -609,6 +662,7 @@ ccw_device_offline(struct ccw_device *cd
 	/* Are we doing path grouping? */
 	if (!cdev->private->options.pgroup) {
 		/* No, set state offline immediately. */
+		sch->vpm = 0;
 		ccw_device_done(cdev, DEV_STATE_OFFLINE);
 		return 0;
 	}
@@ -705,8 +759,6 @@ ccw_device_online_verify(struct ccw_devi
 {
 	struct subchannel *sch;
 
-	if (!cdev->private->options.pgroup)
-		return;
 	if (cdev->private->state == DEV_STATE_W4SENSE) {
 		cdev->private->flags.doverify = 1;
 		return;
@@ -995,8 +1047,7 @@ static void
 ccw_device_wait4io_verify(struct ccw_device *cdev, enum dev_event dev_event)
 {
 	/* When the I/O has terminated, we have to start verification. */
-	if (cdev->private->options.pgroup)
-		cdev->private->flags.doverify = 1;
+	cdev->private->flags.doverify = 1;
 }
 
 static void
diff -urpN linux-2.6/drivers/s390/cio/device_pgid.c linux-2.6-patched/drivers/s390/cio/device_pgid.c
--- linux-2.6/drivers/s390/cio/device_pgid.c	2006-07-12 16:25:07.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device_pgid.c	2006-07-12 16:25:29.000000000 +0200
@@ -33,12 +33,17 @@ __ccw_device_sense_pgid_start(struct ccw
 	struct subchannel *sch;
 	struct ccw1 *ccw;
 	int ret;
+	int i;
 
 	sch = to_subchannel(cdev->dev.parent);
+	/* Return if we already checked on all paths. */
+	if (cdev->private->imask == 0)
+		return (sch->lpm == 0) ? -ENODEV : -EACCES;
+	i = 8 - ffs(cdev->private->imask);
+
 	/* Setup sense path group id channel program. */
 	ccw = cdev->private->iccws;
 	ccw->cmd_code = CCW_CMD_SENSE_PGID;
-	ccw->cda = (__u32) __pa (&cdev->private->pgid);
 	ccw->count = sizeof (struct pgid);
 	ccw->flags = CCW_FLAG_SLI;
 
@@ -48,6 +53,7 @@ __ccw_device_sense_pgid_start(struct ccw
 	ret = -ENODEV;
 	while (cdev->private->imask != 0) {
 		/* Try every path multiple times. */
+		ccw->cda = (__u32) __pa (&cdev->private->pgid[i]);
 		if (cdev->private->iretry > 0) {
 			cdev->private->iretry--;
 			ret = cio_start (sch, cdev->private->iccws, 
@@ -64,7 +70,9 @@ __ccw_device_sense_pgid_start(struct ccw
 		}
 		cdev->private->imask >>= 1;
 		cdev->private->iretry = 5;
+		i++;
 	}
+
 	return ret;
 }
 
@@ -76,7 +84,7 @@ ccw_device_sense_pgid_start(struct ccw_d
 	cdev->private->state = DEV_STATE_SENSE_PGID;
 	cdev->private->imask = 0x80;
 	cdev->private->iretry = 5;
-	memset (&cdev->private->pgid, 0, sizeof (struct pgid));
+	memset (&cdev->private->pgid, 0, sizeof (cdev->private->pgid));
 	ret = __ccw_device_sense_pgid_start(cdev);
 	if (ret && ret != -EBUSY)
 		ccw_device_sense_pgid_done(cdev, ret);
@@ -91,6 +99,7 @@ __ccw_device_check_sense_pgid(struct ccw
 {
 	struct subchannel *sch;
 	struct irb *irb;
+	int i;
 
 	sch = to_subchannel(cdev->dev.parent);
 	irb = &cdev->private->irb;
@@ -124,7 +133,8 @@ __ccw_device_check_sense_pgid(struct ccw
 			      sch->schid.sch_no, sch->orb.lpm);
 		return -EACCES;
 	}
-	if (cdev->private->pgid.inf.ps.state2 == SNID_STATE2_RESVD_ELSE) {
+	i = 8 - ffs(cdev->private->imask);
+	if (cdev->private->pgid[i].inf.ps.state2 == SNID_STATE2_RESVD_ELSE) {
 		CIO_MSG_EVENT(2, "SNID - Device %04x on Subchannel 0.%x.%04x "
 			      "is reserved by someone else\n",
 			      cdev->private->devno, sch->schid.ssid,
@@ -162,12 +172,6 @@ ccw_device_sense_pgid_irq(struct ccw_dev
 	memset(&cdev->private->irb, 0, sizeof(struct irb));
 	switch (ret) {
 	/* 0, -ETIME, -EOPNOTSUPP, -EAGAIN, -EACCES or -EUSERS */
-	case 0:			/* Sense Path Group ID successful. */
-		if (cdev->private->pgid.inf.ps.state1 == SNID_STATE1_RESET)
-			memcpy(&cdev->private->pgid, &css[0]->global_pgid,
-			       sizeof(struct pgid));
-		ccw_device_sense_pgid_done(cdev, 0);
-		break;
 	case -EOPNOTSUPP:	/* Sense Path Group ID not supported */
 		ccw_device_sense_pgid_done(cdev, -EOPNOTSUPP);
 		break;
@@ -176,13 +180,15 @@ ccw_device_sense_pgid_irq(struct ccw_dev
 		break;
 	case -EACCES:		/* channel is not operational. */
 		sch->lpm &= ~cdev->private->imask;
+		/* Fall through. */
+	case 0:			/* Sense Path Group ID successful. */
 		cdev->private->imask >>= 1;
 		cdev->private->iretry = 5;
 		/* Fall through. */
 	case -EAGAIN:		/* Try again. */
 		ret = __ccw_device_sense_pgid_start(cdev);
 		if (ret != 0 && ret != -EBUSY)
-			ccw_device_sense_pgid_done(cdev, -ENODEV);
+			ccw_device_sense_pgid_done(cdev, ret);
 		break;
 	case -EUSERS:		/* device is reserved for someone else. */
 		ccw_device_sense_pgid_done(cdev, -EUSERS);
@@ -203,20 +209,20 @@ __ccw_device_do_pgid(struct ccw_device *
 	sch = to_subchannel(cdev->dev.parent);
 
 	/* Setup sense path group id channel program. */
-	cdev->private->pgid.inf.fc = func;
+	cdev->private->pgid[0].inf.fc = func;
 	ccw = cdev->private->iccws;
 	if (!cdev->private->flags.pgid_single) {
-		cdev->private->pgid.inf.fc |= SPID_FUNC_MULTI_PATH;
+		cdev->private->pgid[0].inf.fc |= SPID_FUNC_MULTI_PATH;
 		ccw->cmd_code = CCW_CMD_SUSPEND_RECONN;
 		ccw->cda = 0;
 		ccw->count = 0;
 		ccw->flags = CCW_FLAG_SLI | CCW_FLAG_CC;
 		ccw++;
 	} else
-		cdev->private->pgid.inf.fc |= SPID_FUNC_SINGLE_PATH;
+		cdev->private->pgid[0].inf.fc |= SPID_FUNC_SINGLE_PATH;
 
 	ccw->cmd_code = CCW_CMD_SET_PGID;
-	ccw->cda = (__u32) __pa (&cdev->private->pgid);
+	ccw->cda = (__u32) __pa (&cdev->private->pgid[0]);
 	ccw->count = sizeof (struct pgid);
 	ccw->flags = CCW_FLAG_SLI;
 
@@ -244,6 +250,48 @@ __ccw_device_do_pgid(struct ccw_device *
 }
 
 /*
+ * Helper function to send a nop ccw down a path.
+ */
+static int __ccw_device_do_nop(struct ccw_device *cdev)
+{
+	struct subchannel *sch;
+	struct ccw1 *ccw;
+	int ret;
+
+	sch = to_subchannel(cdev->dev.parent);
+
+	/* Setup nop channel program. */
+	ccw = cdev->private->iccws;
+	ccw->cmd_code = CCW_CMD_NOOP;
+	ccw->cda = 0;
+	ccw->count = 0;
+	ccw->flags = CCW_FLAG_SLI;
+
+	/* Reset device status. */
+	memset(&cdev->private->irb, 0, sizeof(struct irb));
+
+	/* Try multiple times. */
+	ret = -ENODEV;
+	if (cdev->private->iretry > 0) {
+		cdev->private->iretry--;
+		ret = cio_start (sch, cdev->private->iccws,
+				 cdev->private->imask);
+		/* ret is 0, -EBUSY, -EACCES or -ENODEV */
+		if ((ret != -EACCES) && (ret != -ENODEV))
+			return ret;
+	}
+	/* nop command failed on this path. Switch it off. */
+	sch->lpm &= ~cdev->private->imask;
+	sch->vpm &= ~cdev->private->imask;
+	CIO_MSG_EVENT(2, "NOP - Device %04x on Subchannel "
+		      "0.%x.%04x, lpm %02X, became 'not operational'\n",
+		      cdev->private->devno, sch->schid.ssid,
+		      sch->schid.sch_no, cdev->private->imask);
+	return ret;
+}
+
+
+/*
  * Called from interrupt context to check if a valid answer
  * to Set Path Group ID was received.
  */
@@ -282,6 +330,29 @@ __ccw_device_check_pgid(struct ccw_devic
 	return 0;
 }
 
+/*
+ * Called from interrupt context to check the path status after a nop has
+ * been send.
+ */
+static int __ccw_device_check_nop(struct ccw_device *cdev)
+{
+	struct subchannel *sch;
+	struct irb *irb;
+
+	sch = to_subchannel(cdev->dev.parent);
+	irb = &cdev->private->irb;
+	if (irb->scsw.fctl & (SCSW_FCTL_HALT_FUNC | SCSW_FCTL_CLEAR_FUNC))
+		return -ETIME;
+	if (irb->scsw.cc == 3) {
+		CIO_MSG_EVENT(2, "NOP - Device %04x on Subchannel 0.%x.%04x,"
+			      " lpm %02X, became 'not operational'\n",
+			      cdev->private->devno, sch->schid.ssid,
+			      sch->schid.sch_no, cdev->private->imask);
+		return -EACCES;
+	}
+	return 0;
+}
+
 static void
 __ccw_device_verify_start(struct ccw_device *cdev)
 {
@@ -296,9 +367,12 @@ __ccw_device_verify_start(struct ccw_dev
 			if ((sch->vpm & imask) != (sch->lpm & imask))
 				break;
 		cdev->private->imask = imask;
-		func = (sch->vpm & imask) ?
-			SPID_FUNC_RESIGN : SPID_FUNC_ESTABLISH;
-		ret = __ccw_device_do_pgid(cdev, func);
+		if (cdev->private->options.pgroup) {
+			func = (sch->vpm & imask) ?
+				SPID_FUNC_RESIGN : SPID_FUNC_ESTABLISH;
+			ret = __ccw_device_do_pgid(cdev, func);
+		} else
+			ret = __ccw_device_do_nop(cdev);
 		if (ret == 0 || ret == -EBUSY)
 			return;
 		cdev->private->iretry = 5;
@@ -327,7 +401,10 @@ ccw_device_verify_irq(struct ccw_device 
 	if (ccw_device_accumulate_and_sense(cdev, irb) != 0)
 		return;
 	sch = to_subchannel(cdev->dev.parent);
-	ret = __ccw_device_check_pgid(cdev);
+	if (cdev->private->options.pgroup)
+		ret = __ccw_device_check_pgid(cdev);
+	else
+		ret = __ccw_device_check_nop(cdev);
 	memset(&cdev->private->irb, 0, sizeof(struct irb));
 	switch (ret) {
 	/* 0, -ETIME, -EAGAIN, -EOPNOTSUPP or -EACCES */
@@ -345,11 +422,10 @@ ccw_device_verify_irq(struct ccw_device 
 		 * One of those strange devices which claim to be able
 		 * to do multipathing but not for Set Path Group ID.
 		 */
-		if (cdev->private->flags.pgid_single) {
-			ccw_device_verify_done(cdev, -EOPNOTSUPP);
-			break;
-		}
-		cdev->private->flags.pgid_single = 1;
+		if (cdev->private->flags.pgid_single)
+			cdev->private->options.pgroup = 0;
+		else
+			cdev->private->flags.pgid_single = 1;
 		/* fall through. */
 	case -EAGAIN:		/* Try again. */
 		__ccw_device_verify_start(cdev);
diff -urpN linux-2.6/drivers/s390/cio/device_status.c linux-2.6-patched/drivers/s390/cio/device_status.c
--- linux-2.6/drivers/s390/cio/device_status.c	2006-07-12 16:25:07.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device_status.c	2006-07-12 16:25:29.000000000 +0200
@@ -67,8 +67,7 @@ ccw_device_path_notoper(struct ccw_devic
 		      sch->schib.pmcw.pnom);
 
 	sch->lpm &= ~sch->schib.pmcw.pnom;
-	if (cdev->private->options.pgroup)
-		cdev->private->flags.doverify = 1;
+	cdev->private->flags.doverify = 1;
 }
 
 /*
@@ -180,7 +179,7 @@ ccw_device_accumulate_esw(struct ccw_dev
 	cdev_irb->esw.esw0.erw.auth = irb->esw.esw0.erw.auth;
 	/* Copy path verification required flag. */
 	cdev_irb->esw.esw0.erw.pvrf = irb->esw.esw0.erw.pvrf;
-	if (irb->esw.esw0.erw.pvrf && cdev->private->options.pgroup)
+	if (irb->esw.esw0.erw.pvrf)
 		cdev->private->flags.doverify = 1;
 	/* Copy concurrent sense bit. */
 	cdev_irb->esw.esw0.erw.cons = irb->esw.esw0.erw.cons;
@@ -354,7 +353,7 @@ ccw_device_accumulate_basic_sense(struct
 	}
 	/* Check if path verification is required. */
 	if (ccw_device_accumulate_esw_valid(irb) &&
-	    irb->esw.esw0.erw.pvrf && cdev->private->options.pgroup) 
+	    irb->esw.esw0.erw.pvrf)
 		cdev->private->flags.doverify = 1;
 }
 
diff -urpN linux-2.6/drivers/s390/s390mach.c linux-2.6-patched/drivers/s390/s390mach.c
--- linux-2.6/drivers/s390/s390mach.c	2006-07-12 16:25:07.000000000 +0200
+++ linux-2.6-patched/drivers/s390/s390mach.c	2006-07-12 16:25:29.000000000 +0200
@@ -111,6 +111,16 @@ repeat:
 			break;
 		case CRW_RSC_CPATH:
 			pr_debug("source is channel path %02X\n", crw[0].rsid);
+			/*
+			 * Check for solicited machine checks. These are
+			 * created by reset channel path and need not be
+			 * reported to the common I/O layer.
+			 */
+			if (crw[chain].slct) {
+				DBG(KERN_INFO"solicited machine check for "
+				    "channel path %02X\n", crw[0].rsid);
+				break;
+			}
 			switch (crw[0].erc) {
 			case CRW_ERC_IPARM: /* Path has come. */
 				ret = chp_process_crw(crw[0].rsid, 1);
diff -urpN linux-2.6/include/asm-s390/cio.h linux-2.6-patched/include/asm-s390/cio.h
--- linux-2.6/include/asm-s390/cio.h	2006-07-12 16:25:14.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/cio.h	2006-07-12 16:25:29.000000000 +0200
@@ -276,6 +276,8 @@ extern void wait_cons_dev(void);
 
 extern void clear_all_subchannels(void);
 
+extern void cio_reset_channel_paths(void);
+
 extern void css_schedule_reprobe(void);
 
 #endif
