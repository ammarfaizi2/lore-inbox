Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbWJKNfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbWJKNfn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 09:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWJKNfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 09:35:43 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:6425 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751295AbWJKNfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 09:35:41 -0400
Date: Wed, 11 Oct 2006 15:35:42 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, cornelia.huck@de.ibm.com
Subject: [S390] cio: Use ccw_dev_id and subchannel_id in ccw_device_private
Message-ID: <20061011133542.GD9305@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

[S390] cio: Use ccw_dev_id and subchannel_id in ccw_device_private

Use the proper structures to identify device and subchannel. Change
get_disc_ccwdev_by_devno() to get_disc_ccwdev_by_dev_id().

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/css.h           |    5 ++---
 drivers/s390/cio/device.c        |   32 +++++++++++++++-----------------
 drivers/s390/cio/device_fsm.c    |   14 ++++++++------
 drivers/s390/cio/device_id.c     |   14 ++++++++------
 drivers/s390/cio/device_ops.c    |    4 ++--
 drivers/s390/cio/device_pgid.c   |   23 +++++++++++++----------
 drivers/s390/cio/device_status.c |    7 +++----
 drivers/s390/cio/qdio.c          |   10 +++++-----
 include/asm-s390/cio.h           |    6 ++++++
 9 files changed, 62 insertions(+), 53 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/css.h linux-2.6-patched/drivers/s390/cio/css.h
--- linux-2.6/drivers/s390/cio/css.h	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/css.h	2006-10-11 15:23:37.000000000 +0200
@@ -76,9 +76,8 @@ struct ccw_device_private {
 	int state;		/* device state */
 	atomic_t onoff;
 	unsigned long registered;
-	__u16 devno;		/* device number */
-	__u16 sch_no;		/* subchannel number */
-	__u8 ssid;              /* subchannel set id */
+	struct ccw_dev_id dev_id;	/* device id */
+	struct subchannel_id schid;	/* subchannel number */
 	__u8 imask;		/* lpm mask for SNID/SID/SPGID */
 	int iretry;		/* retry counter SNID/SID/SPGID */
 	struct {
diff -urpN linux-2.6/drivers/s390/cio/device.c linux-2.6-patched/drivers/s390/cio/device.c
--- linux-2.6/drivers/s390/cio/device.c	2006-10-11 15:23:22.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device.c	2006-10-11 15:23:37.000000000 +0200
@@ -552,21 +552,19 @@ ccw_device_register(struct ccw_device *c
 }
 
 struct match_data {
-	unsigned int devno;
-	unsigned int ssid;
+	struct ccw_dev_id dev_id;
 	struct ccw_device * sibling;
 };
 
 static int
 match_devno(struct device * dev, void * data)
 {
-	struct match_data * d = (struct match_data *)data;
+	struct match_data * d = data;
 	struct ccw_device * cdev;
 
 	cdev = to_ccwdev(dev);
 	if ((cdev->private->state == DEV_STATE_DISCONNECTED) &&
-	    (cdev->private->devno == d->devno) &&
-	    (cdev->private->ssid == d->ssid) &&
+	    ccw_dev_id_is_equal(&cdev->private->dev_id, &d->dev_id) &&
 	    (cdev != d->sibling)) {
 		cdev->private->state = DEV_STATE_NOT_OPER;
 		return 1;
@@ -574,15 +572,13 @@ match_devno(struct device * dev, void * 
 	return 0;
 }
 
-static struct ccw_device *
-get_disc_ccwdev_by_devno(unsigned int devno, unsigned int ssid,
-			 struct ccw_device *sibling)
+static struct ccw_device * get_disc_ccwdev_by_dev_id(struct ccw_dev_id *dev_id,
+						     struct ccw_device *sibling)
 {
 	struct device *dev;
 	struct match_data data;
 
-	data.devno = devno;
-	data.ssid = ssid;
+	data.dev_id = *dev_id;
 	data.sibling = sibling;
 	dev = bus_find_device(&ccw_bus_type, NULL, &data, match_devno);
 
@@ -618,7 +614,7 @@ ccw_device_do_unreg_rereg(void *data)
 
 	cdev = (struct ccw_device *)data;
 	sch = to_subchannel(cdev->dev.parent);
-	if (cdev->private->devno != sch->schib.pmcw.dev) {
+	if (cdev->private->dev_id.devno != sch->schib.pmcw.dev) {
 		/*
 		 * The device number has changed. This is usually only when
 		 * a device has been detached under VM and then re-appeared
@@ -633,10 +629,12 @@ ccw_device_do_unreg_rereg(void *data)
 		 *        get possibly sick...
 		 */
 		struct ccw_device *other_cdev;
+		struct ccw_dev_id dev_id;
 
 		need_rename = 1;
-		other_cdev = get_disc_ccwdev_by_devno(sch->schib.pmcw.dev,
-						      sch->schid.ssid, cdev);
+		dev_id.devno = sch->schib.pmcw.dev;
+		dev_id.ssid = sch->schid.ssid;
+		other_cdev = get_disc_ccwdev_by_dev_id(&dev_id, cdev);
 		if (other_cdev) {
 			struct subchannel *other_sch;
 
@@ -652,7 +650,7 @@ ccw_device_do_unreg_rereg(void *data)
 		}
 		/* Update ssd info here. */
 		css_get_ssd_info(sch);
-		cdev->private->devno = sch->schib.pmcw.dev;
+		cdev->private->dev_id.devno = sch->schib.pmcw.dev;
 	} else
 		need_rename = 0;
 	device_remove_files(&cdev->dev);
@@ -792,9 +790,9 @@ io_subchannel_recog(struct ccw_device *c
 
 	/* Init private data. */
 	priv = cdev->private;
-	priv->devno = sch->schib.pmcw.dev;
-	priv->ssid = sch->schid.ssid;
-	priv->sch_no = sch->schid.sch_no;
+	priv->dev_id.devno = sch->schib.pmcw.dev;
+	priv->dev_id.ssid = sch->schid.ssid;
+	priv->schid = sch->schid;
 	priv->state = DEV_STATE_NOT_OPER;
 	INIT_LIST_HEAD(&priv->cmb_list);
 	init_waitqueue_head(&priv->wait_q);
diff -urpN linux-2.6/drivers/s390/cio/device_fsm.c linux-2.6-patched/drivers/s390/cio/device_fsm.c
--- linux-2.6/drivers/s390/cio/device_fsm.c	2006-10-11 15:23:36.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device_fsm.c	2006-10-11 15:23:37.000000000 +0200
@@ -183,7 +183,7 @@ ccw_device_handle_oper(struct ccw_device
 	    cdev->id.cu_model != cdev->private->senseid.cu_model ||
 	    cdev->id.dev_type != cdev->private->senseid.dev_type ||
 	    cdev->id.dev_model != cdev->private->senseid.dev_model ||
-	    cdev->private->devno != sch->schib.pmcw.dev) {
+	    cdev->private->dev_id.devno != sch->schib.pmcw.dev) {
 		PREPARE_WORK(&cdev->private->kick_work,
 			     ccw_device_do_unreg_rereg, (void *)cdev);
 		queue_work(ccw_device_work, &cdev->private->kick_work);
@@ -255,7 +255,7 @@ ccw_device_recog_done(struct ccw_device 
 	case DEV_STATE_NOT_OPER:
 		CIO_DEBUG(KERN_WARNING, 2,
 			  "SenseID : unknown device %04x on subchannel "
-			  "0.%x.%04x\n", cdev->private->devno,
+			  "0.%x.%04x\n", cdev->private->dev_id.devno,
 			  sch->schid.ssid, sch->schid.sch_no);
 		break;
 	case DEV_STATE_OFFLINE:
@@ -282,14 +282,15 @@ ccw_device_recog_done(struct ccw_device 
 		CIO_DEBUG(KERN_INFO, 2, "SenseID : device 0.%x.%04x reports: "
 			  "CU  Type/Mod = %04X/%02X, Dev Type/Mod = "
 			  "%04X/%02X\n",
-			  cdev->private->ssid, cdev->private->devno,
+			  cdev->private->dev_id.ssid,
+			  cdev->private->dev_id.devno,
 			  cdev->id.cu_type, cdev->id.cu_model,
 			  cdev->id.dev_type, cdev->id.dev_model);
 		break;
 	case DEV_STATE_BOXED:
 		CIO_DEBUG(KERN_WARNING, 2,
 			  "SenseID : boxed device %04x on subchannel "
-			  "0.%x.%04x\n", cdev->private->devno,
+			  "0.%x.%04x\n", cdev->private->dev_id.devno,
 			  sch->schid.ssid, sch->schid.sch_no);
 		break;
 	}
@@ -363,7 +364,7 @@ ccw_device_done(struct ccw_device *cdev,
 	if (state == DEV_STATE_BOXED)
 		CIO_DEBUG(KERN_WARNING, 2,
 			  "Boxed device %04x on subchannel %04x\n",
-			  cdev->private->devno, sch->schid.sch_no);
+			  cdev->private->dev_id.devno, sch->schid.sch_no);
 
 	if (cdev->private->flags.donotify) {
 		cdev->private->flags.donotify = 0;
@@ -412,7 +413,8 @@ static void __ccw_device_get_common_pgid
 		/* PGID mismatch, can't pathgroup. */
 		CIO_MSG_EVENT(0, "SNID - pgid mismatch for device "
 			      "0.%x.%04x, can't pathgroup\n",
-			      cdev->private->ssid, cdev->private->devno);
+			      cdev->private->dev_id.ssid,
+			      cdev->private->dev_id.devno);
 		cdev->private->options.pgroup = 0;
 		return;
 	}
diff -urpN linux-2.6/drivers/s390/cio/device_id.c linux-2.6-patched/drivers/s390/cio/device_id.c
--- linux-2.6/drivers/s390/cio/device_id.c	2006-10-11 15:23:22.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device_id.c	2006-10-11 15:23:37.000000000 +0200
@@ -251,7 +251,7 @@ ccw_device_check_sense_id(struct ccw_dev
 		 */
 		CIO_MSG_EVENT(2, "SenseID : device %04x on Subchannel "
 			      "0.%x.%04x reports cmd reject\n",
-			      cdev->private->devno, sch->schid.ssid,
+			      cdev->private->dev_id.devno, sch->schid.ssid,
 			      sch->schid.sch_no);
 		return -EOPNOTSUPP;
 	}
@@ -259,7 +259,8 @@ ccw_device_check_sense_id(struct ccw_dev
 		CIO_MSG_EVENT(2, "SenseID : UC on dev 0.%x.%04x, "
 			      "lpum %02X, cnt %02d, sns :"
 			      " %02X%02X%02X%02X %02X%02X%02X%02X ...\n",
-			      cdev->private->ssid, cdev->private->devno,
+			      cdev->private->dev_id.ssid,
+			      cdev->private->dev_id.devno,
 			      irb->esw.esw0.sublog.lpum,
 			      irb->esw.esw0.erw.scnt,
 			      irb->ecw[0], irb->ecw[1],
@@ -274,14 +275,15 @@ ccw_device_check_sense_id(struct ccw_dev
 			CIO_MSG_EVENT(2, "SenseID : path %02X for device %04x "
 				      "on subchannel 0.%x.%04x is "
 				      "'not operational'\n", sch->orb.lpm,
-				      cdev->private->devno, sch->schid.ssid,
-				      sch->schid.sch_no);
+				      cdev->private->dev_id.devno,
+				      sch->schid.ssid, sch->schid.sch_no);
 		return -EACCES;
 	}
 	/* Hmm, whatever happened, try again. */
 	CIO_MSG_EVENT(2, "SenseID : start_IO() for device %04x on "
 		      "subchannel 0.%x.%04x returns status %02X%02X\n",
-		      cdev->private->devno, sch->schid.ssid, sch->schid.sch_no,
+		      cdev->private->dev_id.devno, sch->schid.ssid,
+		      sch->schid.sch_no,
 		      irb->scsw.dstat, irb->scsw.cstat);
 	return -EAGAIN;
 }
@@ -330,7 +332,7 @@ ccw_device_sense_id_irq(struct ccw_devic
 		/* fall through. */
 	default:		/* Sense ID failed. Try asking VM. */
 		if (MACHINE_IS_VM) {
-			VM_virtual_device_info (cdev->private->devno,
+			VM_virtual_device_info (cdev->private->dev_id.devno,
 						&cdev->private->senseid);
 			if (cdev->private->senseid.cu_type != 0xFFFF) {
 				/* Got the device information from VM. */
diff -urpN linux-2.6/drivers/s390/cio/device_ops.c linux-2.6-patched/drivers/s390/cio/device_ops.c
--- linux-2.6/drivers/s390/cio/device_ops.c	2006-10-11 15:23:22.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device_ops.c	2006-10-11 15:23:37.000000000 +0200
@@ -592,13 +592,13 @@ ccw_device_get_chp_desc(struct ccw_devic
 int
 _ccw_device_get_subchannel_number(struct ccw_device *cdev)
 {
-	return cdev->private->sch_no;
+	return cdev->private->schid.sch_no;
 }
 
 int
 _ccw_device_get_device_number(struct ccw_device *cdev)
 {
-	return cdev->private->devno;
+	return cdev->private->dev_id.devno;
 }
 
 
diff -urpN linux-2.6/drivers/s390/cio/device_pgid.c linux-2.6-patched/drivers/s390/cio/device_pgid.c
--- linux-2.6/drivers/s390/cio/device_pgid.c	2006-10-11 15:23:22.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device_pgid.c	2006-10-11 15:23:37.000000000 +0200
@@ -79,7 +79,8 @@ __ccw_device_sense_pgid_start(struct ccw
 			CIO_MSG_EVENT(2, "SNID - Device %04x on Subchannel "
 				      "0.%x.%04x, lpm %02X, became 'not "
 				      "operational'\n",
-				      cdev->private->devno, sch->schid.ssid,
+				      cdev->private->dev_id.devno,
+				      sch->schid.ssid,
 				      sch->schid.sch_no, cdev->private->imask);
 
 		}
@@ -135,7 +136,8 @@ __ccw_device_check_sense_pgid(struct ccw
 		CIO_MSG_EVENT(2, "SNID - device 0.%x.%04x, unit check, "
 			      "lpum %02X, cnt %02d, sns : "
 			      "%02X%02X%02X%02X %02X%02X%02X%02X ...\n",
-			      cdev->private->ssid, cdev->private->devno,
+			      cdev->private->dev_id.ssid,
+			      cdev->private->dev_id.devno,
 			      irb->esw.esw0.sublog.lpum,
 			      irb->esw.esw0.erw.scnt,
 			      irb->ecw[0], irb->ecw[1],
@@ -147,7 +149,7 @@ __ccw_device_check_sense_pgid(struct ccw
 	if (irb->scsw.cc == 3) {
 		CIO_MSG_EVENT(2, "SNID - Device %04x on Subchannel 0.%x.%04x,"
 			      " lpm %02X, became 'not operational'\n",
-			      cdev->private->devno, sch->schid.ssid,
+			      cdev->private->dev_id.devno, sch->schid.ssid,
 			      sch->schid.sch_no, sch->orb.lpm);
 		return -EACCES;
 	}
@@ -155,7 +157,7 @@ __ccw_device_check_sense_pgid(struct ccw
 	if (cdev->private->pgid[i].inf.ps.state2 == SNID_STATE2_RESVD_ELSE) {
 		CIO_MSG_EVENT(2, "SNID - Device %04x on Subchannel 0.%x.%04x "
 			      "is reserved by someone else\n",
-			      cdev->private->devno, sch->schid.ssid,
+			      cdev->private->dev_id.devno, sch->schid.ssid,
 			      sch->schid.sch_no);
 		return -EUSERS;
 	}
@@ -261,7 +263,7 @@ __ccw_device_do_pgid(struct ccw_device *
 	/* PGID command failed on this path. */
 	CIO_MSG_EVENT(2, "SPID - Device %04x on Subchannel "
 		      "0.%x.%04x, lpm %02X, became 'not operational'\n",
-		      cdev->private->devno, sch->schid.ssid,
+		      cdev->private->dev_id.devno, sch->schid.ssid,
 		      sch->schid.sch_no, cdev->private->imask);
 	return ret;
 }
@@ -301,7 +303,7 @@ static int __ccw_device_do_nop(struct cc
 	/* nop command failed on this path. */
 	CIO_MSG_EVENT(2, "NOP - Device %04x on Subchannel "
 		      "0.%x.%04x, lpm %02X, became 'not operational'\n",
-		      cdev->private->devno, sch->schid.ssid,
+		      cdev->private->dev_id.devno, sch->schid.ssid,
 		      sch->schid.sch_no, cdev->private->imask);
 	return ret;
 }
@@ -328,8 +330,9 @@ __ccw_device_check_pgid(struct ccw_devic
 		CIO_MSG_EVENT(2, "SPID - device 0.%x.%04x, unit check, "
 			      "cnt %02d, "
 			      "sns : %02X%02X%02X%02X %02X%02X%02X%02X ...\n",
-			      cdev->private->ssid,
-			      cdev->private->devno, irb->esw.esw0.erw.scnt,
+			      cdev->private->dev_id.ssid,
+			      cdev->private->dev_id.devno,
+			      irb->esw.esw0.erw.scnt,
 			      irb->ecw[0], irb->ecw[1],
 			      irb->ecw[2], irb->ecw[3],
 			      irb->ecw[4], irb->ecw[5],
@@ -339,7 +342,7 @@ __ccw_device_check_pgid(struct ccw_devic
 	if (irb->scsw.cc == 3) {
 		CIO_MSG_EVENT(2, "SPID - Device %04x on Subchannel 0.%x.%04x,"
 			      " lpm %02X, became 'not operational'\n",
-			      cdev->private->devno, sch->schid.ssid,
+			      cdev->private->dev_id.devno, sch->schid.ssid,
 			      sch->schid.sch_no, cdev->private->imask);
 		return -EACCES;
 	}
@@ -362,7 +365,7 @@ static int __ccw_device_check_nop(struct
 	if (irb->scsw.cc == 3) {
 		CIO_MSG_EVENT(2, "NOP - Device %04x on Subchannel 0.%x.%04x,"
 			      " lpm %02X, became 'not operational'\n",
-			      cdev->private->devno, sch->schid.ssid,
+			      cdev->private->dev_id.devno, sch->schid.ssid,
 			      sch->schid.sch_no, cdev->private->imask);
 		return -EACCES;
 	}
diff -urpN linux-2.6/drivers/s390/cio/device_status.c linux-2.6-patched/drivers/s390/cio/device_status.c
--- linux-2.6/drivers/s390/cio/device_status.c	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device_status.c	2006-10-11 15:23:37.000000000 +0200
@@ -32,19 +32,18 @@ ccw_device_msg_control_check(struct ccw_
 				 SCHN_STAT_CHN_CTRL_CHK |
 				 SCHN_STAT_INTF_CTRL_CHK)))
 		return;
-		
 	CIO_MSG_EVENT(0, "Channel-Check or Interface-Control-Check "
 		      "received"
 		      " ... device %04x on subchannel 0.%x.%04x, dev_stat "
 		      ": %02X sch_stat : %02X\n",
-		      cdev->private->devno, cdev->private->ssid,
-		      cdev->private->sch_no,
+		      cdev->private->dev_id.devno, cdev->private->schid.ssid,
+		      cdev->private->schid.sch_no,
 		      irb->scsw.dstat, irb->scsw.cstat);
 
 	if (irb->scsw.cc != 3) {
 		char dbf_text[15];
 
-		sprintf(dbf_text, "chk%x", cdev->private->sch_no);
+		sprintf(dbf_text, "chk%x", cdev->private->schid.sch_no);
 		CIO_TRACE_EVENT(0, dbf_text);
 		CIO_HEX_EVENT(0, irb, sizeof (struct irb));
 	}
diff -urpN linux-2.6/drivers/s390/cio/qdio.c linux-2.6-patched/drivers/s390/cio/qdio.c
--- linux-2.6/drivers/s390/cio/qdio.c	2006-10-11 15:23:22.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/qdio.c	2006-10-11 15:23:37.000000000 +0200
@@ -1741,7 +1741,7 @@ qdio_fill_qs(struct qdio_irq *irq_ptr, s
 	void *ptr;
 	int available;
 
-	sprintf(dbf_text,"qfqs%4x",cdev->private->sch_no);
+	sprintf(dbf_text,"qfqs%4x",cdev->private->schid.sch_no);
 	QDIO_DBF_TEXT0(0,setup,dbf_text);
 	for (i=0;i<no_input_qs;i++) {
 		q=irq_ptr->input_qs[i];
@@ -2924,7 +2924,7 @@ qdio_establish_handle_irq(struct ccw_dev
 
 	irq_ptr = cdev->private->qdio_data;
 
-	sprintf(dbf_text,"qehi%4x",cdev->private->sch_no);
+	sprintf(dbf_text,"qehi%4x",cdev->private->schid.sch_no);
 	QDIO_DBF_TEXT0(0,setup,dbf_text);
 	QDIO_DBF_TEXT0(0,trace,dbf_text);
 
@@ -2943,7 +2943,7 @@ qdio_initialize(struct qdio_initialize *
 	int rc;
 	char dbf_text[15];
 
-	sprintf(dbf_text,"qini%4x",init_data->cdev->private->sch_no);
+	sprintf(dbf_text,"qini%4x",init_data->cdev->private->schid.sch_no);
 	QDIO_DBF_TEXT0(0,setup,dbf_text);
 	QDIO_DBF_TEXT0(0,trace,dbf_text);
 
@@ -2964,7 +2964,7 @@ qdio_allocate(struct qdio_initialize *in
 	struct qdio_irq *irq_ptr;
 	char dbf_text[15];
 
-	sprintf(dbf_text,"qalc%4x",init_data->cdev->private->sch_no);
+	sprintf(dbf_text,"qalc%4x",init_data->cdev->private->schid.sch_no);
 	QDIO_DBF_TEXT0(0,setup,dbf_text);
 	QDIO_DBF_TEXT0(0,trace,dbf_text);
 	if ( (init_data->no_input_qs>QDIO_MAX_QUEUES_PER_IRQ) ||
@@ -3187,7 +3187,7 @@ qdio_establish(struct qdio_initialize *i
 		tiqdio_set_delay_target(irq_ptr,TIQDIO_DELAY_TARGET);
 	}
 
-	sprintf(dbf_text,"qest%4x",cdev->private->sch_no);
+	sprintf(dbf_text,"qest%4x",cdev->private->schid.sch_no);
 	QDIO_DBF_TEXT0(0,setup,dbf_text);
 	QDIO_DBF_TEXT0(0,trace,dbf_text);
 
diff -urpN linux-2.6/include/asm-s390/cio.h linux-2.6-patched/include/asm-s390/cio.h
--- linux-2.6/include/asm-s390/cio.h	2006-10-11 15:23:27.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/cio.h	2006-10-11 15:23:37.000000000 +0200
@@ -275,6 +275,12 @@ struct ccw_dev_id {
 	u16 devno;
 };
 
+static inline int ccw_dev_id_is_equal(struct ccw_dev_id *dev_id1,
+				      struct ccw_dev_id *dev_id2)
+{
+	return !memcmp(dev_id1, dev_id2, sizeof(struct ccw_dev_id));
+}
+
 extern int diag210(struct diag210 *addr);
 
 extern void wait_cons_dev(void);
