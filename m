Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264507AbTF0O6O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 10:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264505AbTF0O5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 10:57:51 -0400
Received: from d12lmsgate-3.de.ibm.com ([194.196.100.236]:38531 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id S264476AbTF0Owu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 10:52:50 -0400
Date: Fri, 27 Jun 2003 17:05:52 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (3/7): common i/o layer.
Message-ID: <20030627150552.GD3591@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Make ccwgroup online attribute consistent with ccw online attribute.
- Add link incident record handling to channel subsystem code.
- Do path grouping only if the device driver explicitly requests it.
- Fix multicast or broadcast flood ping hand on HiperSockets.

diffstat:
 drivers/s390/block/dasd_eckd.c |    8 ++-
 drivers/s390/block/dasd_fba.c  |   10 +++
 drivers/s390/char/tape_core.c  |    6 +-
 drivers/s390/cio/ccwgroup.c    |   10 ++-
 drivers/s390/cio/chsc.c        |   54 +++++++++++++++-----
 drivers/s390/cio/css.h         |    2 
 drivers/s390/cio/device.c      |   35 +++++++------
 drivers/s390/cio/device.h      |    2 
 drivers/s390/cio/device_fsm.c  |  109 ++++++++++++++++++++++++-----------------
 drivers/s390/cio/device_ops.c  |    1 
 drivers/s390/cio/device_pgid.c |    6 --
 drivers/s390/cio/qdio.h        |   12 +++-
 include/asm-s390/ccwdev.h      |    2 
 13 files changed, 169 insertions(+), 88 deletions(-)

diff -urN linux-2.5/drivers/s390/block/dasd_eckd.c linux-2.5-s390/drivers/s390/block/dasd_eckd.c
--- linux-2.5/drivers/s390/block/dasd_eckd.c	Sun Jun 22 20:32:28 2003
+++ linux-2.5-s390/drivers/s390/block/dasd_eckd.c	Fri Jun 27 16:04:38 2003
@@ -80,7 +80,13 @@
 static int
 dasd_eckd_probe (struct ccw_device *cdev)
 {
-	return dasd_generic_probe (cdev, &dasd_eckd_discipline);
+	int ret;
+
+	ret = dasd_generic_probe (cdev, &dasd_eckd_discipline);
+	if (ret)
+		return ret;
+	ccw_device_set_options(cdev, CCWDEV_DO_PATHGROUP);
+	return 0;
 }
 
 static int
diff -urN linux-2.5/drivers/s390/block/dasd_fba.c linux-2.5-s390/drivers/s390/block/dasd_fba.c
--- linux-2.5/drivers/s390/block/dasd_fba.c	Sun Jun 22 20:32:58 2003
+++ linux-2.5-s390/drivers/s390/block/dasd_fba.c	Fri Jun 27 16:04:38 2003
@@ -4,7 +4,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.29 $
+ * $Revision: 1.30 $
  */
 
 #include <linux/config.h>
@@ -57,7 +57,13 @@
 static int
 dasd_fba_probe(struct ccw_device *cdev)
 {
-	return  dasd_generic_probe (cdev, &dasd_fba_discipline);
+	int ret;
+
+	ret = dasd_generic_probe (cdev, &dasd_fba_discipline);
+	if (ret)
+		return ret;
+	ccw_device_set_options(cdev, CCWDEV_DO_PATHGROUP);
+	return 0;
 }
 
 static int
diff -urN linux-2.5/drivers/s390/char/tape_core.c linux-2.5-s390/drivers/s390/char/tape_core.c
--- linux-2.5/drivers/s390/char/tape_core.c	Sun Jun 22 20:32:37 2003
+++ linux-2.5-s390/drivers/s390/char/tape_core.c	Fri Jun 27 16:04:38 2003
@@ -372,6 +372,8 @@
 	device->cdev = cdev;
 	cdev->handler = tape_do_irq;
 
+	ccw_device_set_options(cdev, CCWDEV_DO_PATHGROUP);
+
 	return 0;
 }
 
@@ -903,7 +905,7 @@
 {
 	tape_dbf_area = debug_register ( "tape", 1, 2, 3*sizeof(long));
 	debug_register_view(tape_dbf_area, &debug_sprintf_view);
-	DBF_EVENT(3, "tape init: ($Revision: 1.25 $)\n");
+	DBF_EVENT(3, "tape init: ($Revision: 1.26 $)\n");
 	tape_proc_init();
 	tapechar_init ();
 	tapeblock_init ();
@@ -928,7 +930,7 @@
 MODULE_AUTHOR("(C) 2001 IBM Deutschland Entwicklung GmbH by Carsten Otte and "
 	      "Michael Holzheu (cotte@de.ibm.com,holzheu@de.ibm.com)");
 MODULE_DESCRIPTION("Linux on zSeries channel attached "
-		   "tape device driver ($Revision: 1.25 $)");
+		   "tape device driver ($Revision: 1.26 $)");
 
 module_init(tape_init);
 module_exit(tape_exit);
diff -urN linux-2.5/drivers/s390/cio/ccwgroup.c linux-2.5-s390/drivers/s390/cio/ccwgroup.c
--- linux-2.5/drivers/s390/cio/ccwgroup.c	Sun Jun 22 20:32:55 2003
+++ linux-2.5-s390/drivers/s390/cio/ccwgroup.c	Fri Jun 27 16:04:38 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/ccwgroup.c
  *  bus driver for ccwgroup
- *   $Revision: 1.6 $
+ *   $Revision: 1.7 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *                       IBM Corporation
@@ -196,10 +196,12 @@
 
 	value = simple_strtoul(buf, 0, 0);
 
-	if (value)
+	if (value == 1)
 		ccwgroup_set_online(gdev);
-	else
+	else if (value == 0)
 		ccwgroup_set_offline(gdev);
+	else
+		return -EINVAL;
 
 	return count;
 }
@@ -211,7 +213,7 @@
 
 	online = (to_ccwgroupdev(dev)->state == CCWGROUP_ONLINE);
 
-	return sprintf(buf, online ? "1\n" : "0\n");
+	return sprintf(buf, online ? "yes\n" : "no\n");
 }
 
 static DEVICE_ATTR(online, 0644, ccwgroup_online_show, ccwgroup_online_store);
diff -urN linux-2.5/drivers/s390/cio/chsc.c linux-2.5-s390/drivers/s390/cio/chsc.c
--- linux-2.5/drivers/s390/cio/chsc.c	Sun Jun 22 20:32:55 2003
+++ linux-2.5-s390/drivers/s390/cio/chsc.c	Fri Jun 27 16:04:38 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/chsc.c
  *   S/390 common I/O routines -- channel subsystem call
- *   $Revision: 1.69 $
+ *   $Revision: 1.73 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -322,10 +322,6 @@
 	sprintf(dbf_txt, "chpr%x", chpid);
 	CIO_TRACE_EVENT(2, dbf_txt);
 
-	/*
-	 * TODO: the chpid may be not the chpid with the link incident,
-	 * but the chpid the report came in through. How to handle???
-	 */
 	clear_bit(chpid, chpids);
 	if (!test_and_clear_bit(chpid, chpids_known))
 		return;	 /* we didn't know the chpid anyway */
@@ -469,9 +465,40 @@
 	free_page((unsigned long)page);
 }
 
+static int
+__get_chpid_from_lir(void *data)
+{
+	struct lir {
+		u8  iq;
+		u8  ic;
+		u16 sci;
+		/* incident-node descriptor */
+		u32 indesc[28];
+		/* attached-node descriptor */
+		u32 andesc[28];
+		/* incident-specific information */
+		u32 isinfo[28];
+	} *lir;
+
+	lir = (struct lir*) data;
+	if (!(lir->iq&0x80))
+		/* NULL link incident record */
+		return -EINVAL;
+	if (!(lir->indesc[0]&0xc0000000))
+		/* node descriptor not valid */
+		return -EINVAL;
+	if (!(lir->indesc[0]&0x10000000))
+		/* don't handle device-type nodes - FIXME */
+		return -EINVAL;
+	/* Byte 3 contains the chpid. Could also be CTCA, but we don't care */
+
+	return (u16) (lir->indesc[0]&0x000000ff);
+}
+
 static void
 do_process_crw(void *ignore)
 {
+	int chpid;
 	struct {
 		struct chsc_header request;
 		u32 reserved1;
@@ -487,10 +514,8 @@
 		u16 rsid;	/* reporting source id */
 		u32 reserved5;
 		u32 reserved6;
-		u32 ccdf;	/* content-code dependent field */
-		u32 reserved7;
-		u32 reserved8;
-		u32 reserved9;
+		u32 ccdf[96];	/* content-code dependent field */
+		/* ccdf has to be big enough for a link-incident record */
 	} *sei_area;
 
 	/*
@@ -560,9 +585,14 @@
 		case 1: /* link incident*/
 			CIO_CRW_EVENT(4, "chsc_process_crw: "
 				      "channel subsystem reports link incident,"
-				      " source is chpid %x\n", sei_area->rsid);
-			
-			s390_set_chpid_offline(sei_area->rsid);
+				      " reporting source is chpid %x\n",
+				      sei_area->rsid);
+			chpid = __get_chpid_from_lir(sei_area->ccdf);
+			if (chpid < 0)
+				CIO_CRW_EVENT(4, "%s: Invalid LIR, skipping\n",
+					      __FUNCTION__);
+			else
+				s390_set_chpid_offline(chpid);
 			break;
 			
 		case 2: /* i/o resource accessibiliy */
diff -urN linux-2.5/drivers/s390/cio/css.h linux-2.5-s390/drivers/s390/cio/css.h
--- linux-2.5/drivers/s390/cio/css.h	Sun Jun 22 20:33:37 2003
+++ linux-2.5-s390/drivers/s390/cio/css.h	Fri Jun 27 16:04:38 2003
@@ -72,9 +72,9 @@
 	struct {
 		unsigned int fast:1;	/* post with "channel end" */
 		unsigned int repall:1;	/* report every interrupt status */
+		unsigned int pgroup:1;  /* do path grouping */
 	} __attribute__ ((packed)) options;
 	struct {
-		unsigned int pgid_supp:1;   /* "path group ID" supported */
 		unsigned int pgid_single:1; /* use single path for Set PGID */
 		unsigned int esid:1;        /* Ext. SenseID supported by HW */
 		unsigned int dosense:1;	    /* delayed SENSE required */
diff -urN linux-2.5/drivers/s390/cio/device.c linux-2.5-s390/drivers/s390/cio/device.c
--- linux-2.5/drivers/s390/cio/device.c	Sun Jun 22 20:33:04 2003
+++ linux-2.5-s390/drivers/s390/cio/device.c	Fri Jun 27 16:04:38 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/device.c
  *  bus driver for ccw devices
- *   $Revision: 1.54 $
+ *   $Revision: 1.57 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
@@ -298,20 +298,19 @@
 online_store (struct device *dev, const char *buf, size_t count)
 {
 	struct ccw_device *cdev = to_ccwdev(dev);
-	unsigned int value;
+	int i;
+	char *tmp;
 
 	if (!cdev->drv)
 		return count;
 
-	sscanf(buf, "%u", &value);
-
-	if (value) {
-		if (cdev->drv->set_online)
-			ccw_device_set_online(cdev);
-	} else {
-		if (cdev->drv->set_offline)
-			ccw_device_set_offline(cdev);
-	}
+	i = simple_strtoul(buf, &tmp, 16);
+	if (i == 0 && cdev->drv->set_online)
+		ccw_device_set_online(cdev);
+	else if (i == 1 && cdev->drv->set_offline)
+		ccw_device_set_offline(cdev);
+	else
+		return -EINVAL;
 
 	return count;
 }
@@ -405,11 +404,14 @@
  * This allows to trigger an unconditional reserve ccw to eckd dasds
  * (if the device is something else, there should be no problems more than
  * a command reject; we don't have any means of finding out the device's
- * type if it was boxed at ipl/attach).
+ * type if it was boxed at ipl/attach for older devices and under VM).
  */
 void
-ccw_device_add_stlck(struct ccw_device *cdev)
+ccw_device_add_stlck(void *data)
 {
+	struct ccw_device *cdev;
+
+	cdev = (struct ccw_device *)data;
 	device_create_file(&cdev->dev, &dev_attr_steal_lock);
 }
 
@@ -470,6 +472,8 @@
 	if (ret)
 		printk(KERN_WARNING "%s: could not add attributes to %04x\n",
 		       __func__, sch->irq);
+	if (cdev->private->state == DEV_STATE_BOXED)
+		device_create_file(&cdev->dev, &dev_attr_steal_lock);
 out:
 	put_device(&sch->dev);
 }
@@ -493,6 +497,8 @@
 		if (cdev->dev.release)
 			cdev->dev.release(&cdev->dev);
 		break;
+	case DEV_STATE_BOXED:
+		/* Device did not respond in time. */
 	case DEV_STATE_OFFLINE:
 		/* 
 		 * We can't register the device in interrupt context so
@@ -502,9 +508,6 @@
 			  io_subchannel_register, (void *) cdev);
 		queue_work(ccw_device_work, &cdev->private->kick_work);
 		break;
-	case DEV_STATE_BOXED:
-		/* Device did not respond in time. */
-		break;
 	}
 	if (atomic_dec_and_test(&ccw_device_init_count))
 		wake_up(&ccw_device_init_wq);
diff -urN linux-2.5/drivers/s390/cio/device.h linux-2.5-s390/drivers/s390/cio/device.h
--- linux-2.5/drivers/s390/cio/device.h	Sun Jun 22 20:33:07 2003
+++ linux-2.5-s390/drivers/s390/cio/device.h	Fri Jun 27 16:04:38 2003
@@ -95,7 +95,7 @@
 
 void ccw_device_call_handler(struct ccw_device *);
 
-void ccw_device_add_stlck(struct ccw_device *);
+void ccw_device_add_stlck(void *);
 int ccw_device_stlck(struct ccw_device *);
 
 /* qdio needs this. */
diff -urN linux-2.5/drivers/s390/cio/device_fsm.c linux-2.5-s390/drivers/s390/cio/device_fsm.c
--- linux-2.5/drivers/s390/cio/device_fsm.c	Sun Jun 22 20:32:46 2003
+++ linux-2.5-s390/drivers/s390/cio/device_fsm.c	Fri Jun 27 16:04:38 2003
@@ -132,11 +132,11 @@
 		CIO_DEBUG(KERN_WARNING, 2,
 			  "SenseID : boxed device %04X on subchannel %04X\n",
 			  sch->schib.pmcw.dev, sch->irq);
-		ccw_device_add_stlck(cdev);
 		break;
 	}
 	io_subchannel_recog_done(cdev);
-	wake_up(&cdev->private->wait_q);
+	if (state != DEV_STATE_NOT_OPER)
+		wake_up(&cdev->private->wait_q);
 }
 
 /*
@@ -159,22 +159,65 @@
 }
 
 /*
+ * Finished with online/offline processing.
+ */
+static void
+ccw_device_done(struct ccw_device *cdev, int state)
+{
+	struct subchannel *sch;
+
+	sch = to_subchannel(cdev->dev.parent);
+
+	if (state != DEV_STATE_ONLINE)
+		cio_disable_subchannel(sch);
+
+	/* Reset device status. */
+	memset(&cdev->private->irb, 0, sizeof(struct irb));
+
+	cdev->private->state = state;
+
+
+	if (state == DEV_STATE_BOXED) {
+		CIO_DEBUG(KERN_WARNING, 2,
+			  "Boxed device %04X on subchannel %04X\n",
+			  sch->schib.pmcw.dev, sch->irq);
+		INIT_WORK(&cdev->private->kick_work,
+			  ccw_device_add_stlck, (void *) cdev);
+		queue_work(ccw_device_work, &cdev->private->kick_work);
+	}
+
+	wake_up(&cdev->private->wait_q);
+
+	if (state != DEV_STATE_ONLINE)
+		put_device (&cdev->dev);
+}
+
+/*
  * Function called from device_pgid.c after sense path ground has completed.
  */
 void
 ccw_device_sense_pgid_done(struct ccw_device *cdev, int err)
 {
+	struct subchannel *sch;
+
+	sch = to_subchannel(cdev->dev.parent);
 	switch (err) {
 	case 0:
-		cdev->private->state = DEV_STATE_SENSE_ID;
-		ccw_device_sense_id_start(cdev);
+		/* Start Path Group verification. */
+		sch->vpm = 0;	/* Start with no path groups set. */
+		cdev->private->state = DEV_STATE_VERIFY;
+		ccw_device_verify_start(cdev);
 		break;
 	case -ETIME:		/* Sense path group id stopped by timeout. */
 	case -EUSERS:		/* device is reserved for someone else. */
-		ccw_device_recog_done(cdev, DEV_STATE_BOXED);
+		ccw_device_done(cdev, DEV_STATE_BOXED);
+		break;
+	case -EOPNOTSUPP: /* path grouping not supported, just set online. */
+		cdev->private->options.pgroup = 0;
+		ccw_device_done(cdev, DEV_STATE_ONLINE);
 		break;
 	default:
-		ccw_device_recog_done(cdev, DEV_STATE_NOT_OPER);
+		ccw_device_done(cdev, DEV_STATE_NOT_OPER);
 		break;
 	}
 }
@@ -198,11 +241,15 @@
 	ccw_device_set_timeout(cdev, 60*HZ);
 
 	/*
-	 * First thing we should do is a sensePGID in order to find out how
-	 * we can proceed with the recognition process.
+	 * We used to start here with a sense pgid to find out whether a device
+	 * is locked by someone else. Unfortunately, the sense pgid command
+	 * code has other meanings on devices predating the path grouping
+	 * algorithm, so we start with sense id and box the device after an
+	 * timeout (or if sense pgid during path verification detects the device
+	 * is locked, as may happen on newer devices).
 	 */
-	cdev->private->state = DEV_STATE_SENSE_PGID;
-	ccw_device_sense_pgid_start(cdev);
+	cdev->private->state = DEV_STATE_SENSE_ID;
+	ccw_device_sense_id_start(cdev);
 	return 0;
 }
 
@@ -218,29 +265,6 @@
 		ccw_device_set_timeout(cdev, 3*HZ);
 }
 
-/*
- * Finished with online/offline processing.
- */
-static void
-ccw_device_done(struct ccw_device *cdev, int state)
-{
-	struct subchannel *sch;
-
-	sch = to_subchannel(cdev->dev.parent);
-
-	if (state != DEV_STATE_ONLINE)
-		cio_disable_subchannel(sch);
-
-	/* Reset device status. */
-	memset(&cdev->private->irb, 0, sizeof(struct irb));
-
-	cdev->private->state = state;
-
-	wake_up(&cdev->private->wait_q);
-
-	if (state != DEV_STATE_ONLINE)
-		put_device (&cdev->dev);
-}
 
 void
 ccw_device_verify_done(struct ccw_device *cdev, int err)
@@ -276,16 +300,15 @@
 		dev_fsm_event(cdev, DEV_EVENT_NOTOPER);
 		return -ENODEV;
 	}
-	/* Is Set Path Group supported? */
-	if (!cdev->private->flags.pgid_supp) {
+	/* Do we want to do path grouping? */
+	if (!cdev->private->options.pgroup) {
 		/* No, set state online immediately. */
 		ccw_device_done(cdev, DEV_STATE_ONLINE);
 		return 0;
 	}
-	/* Start Path Group verification. */
-	sch->vpm = 0;	/* Start with no path groups set. */
-	cdev->private->state = DEV_STATE_VERIFY;
-	ccw_device_verify_start(cdev);
+	/* Do a SensePGID first. */
+	cdev->private->state = DEV_STATE_SENSE_PGID;
+	ccw_device_sense_pgid_start(cdev);
 	return 0;
 }
 
@@ -321,8 +344,8 @@
 	}
 	if (sch->schib.scsw.actl != 0)
 		return -EBUSY;
-	/* Is Set Path Group supported? */
-	if (!cdev->private->flags.pgid_supp) {
+	/* Are we doing path grouping? */
+	if (!cdev->private->options.pgroup) {
 		/* No, set state offline immediately. */
 		ccw_device_done(cdev, DEV_STATE_OFFLINE);
 		return 0;
@@ -643,9 +666,9 @@
 		[DEV_EVENT_VERIFY]	ccw_device_nop,
 	},
 	[DEV_STATE_SENSE_PGID] {
-		[DEV_EVENT_NOTOPER]	ccw_device_recog_notoper,
+		[DEV_EVENT_NOTOPER]	ccw_device_online_notoper,
 		[DEV_EVENT_INTERRUPT]	ccw_device_sense_pgid_irq,
-		[DEV_EVENT_TIMEOUT]	ccw_device_recog_timeout,
+		[DEV_EVENT_TIMEOUT]	ccw_device_onoff_timeout,
 		[DEV_EVENT_VERIFY]	ccw_device_nop,
 	},
 	[DEV_STATE_SENSE_ID] {
diff -urN linux-2.5/drivers/s390/cio/device_ops.c linux-2.5-s390/drivers/s390/cio/device_ops.c
--- linux-2.5/drivers/s390/cio/device_ops.c	Sun Jun 22 20:33:04 2003
+++ linux-2.5-s390/drivers/s390/cio/device_ops.c	Fri Jun 27 16:04:38 2003
@@ -37,6 +37,7 @@
 		return -EINVAL;
 	cdev->private->options.fast = (flags & CCWDEV_EARLY_NOTIFICATION) != 0;
 	cdev->private->options.repall = (flags & CCWDEV_REPORT_ALL) != 0;
+	cdev->private->options.pgroup = (flags & CCWDEV_DO_PATHGROUP) != 0;
 	return 0;
 }
 
diff -urN linux-2.5/drivers/s390/cio/device_pgid.c linux-2.5-s390/drivers/s390/cio/device_pgid.c
--- linux-2.5/drivers/s390/cio/device_pgid.c	Sun Jun 22 20:32:55 2003
+++ linux-2.5-s390/drivers/s390/cio/device_pgid.c	Fri Jun 27 16:04:38 2003
@@ -84,7 +84,6 @@
 	cdev->private->state = DEV_STATE_SENSE_PGID;
 	cdev->private->imask = 0x80;
 	cdev->private->iretry = 5;
-	cdev->private->flags.pgid_supp = 0;
 	memset (&cdev->private->pgid, 0, sizeof (struct pgid));
 	ret = __ccw_device_sense_pgid_start(cdev);
 	if (ret)
@@ -165,14 +164,13 @@
 	switch (__ccw_device_check_sense_pgid(cdev)) {
 	/* 0, -ETIME, -EOPNOTSUPP, -EAGAIN, -EACCES or -EUSERS */
 	case 0:			/* Sense Path Group ID successful. */
-		cdev->private->flags.pgid_supp = 1;
 		opm = sch->schib.pmcw.pim &
 			sch->schib.pmcw.pam &
 			sch->schib.pmcw.pom;
 		for (i=0;i<8;i++) {
 			if (opm == (0x80 << i)) {
 				/* Don't group single path devices. */
-				cdev->private->flags.pgid_supp = 0;
+				cdev->private->options.pgroup = 0;
 				break;
 			}
 		}
@@ -181,7 +179,7 @@
 			       sizeof(struct pgid));
 		/* fall through. */
 	case -EOPNOTSUPP:	/* Sense Path Group ID not supported */
-		ccw_device_sense_pgid_done(cdev, 0);
+		ccw_device_sense_pgid_done(cdev, -EOPNOTSUPP);
 		break;
 	case -ETIME:		/* Sense path group id stopped by timeout. */
 		ccw_device_sense_pgid_done(cdev, -ETIME);
diff -urN linux-2.5/drivers/s390/cio/qdio.h linux-2.5-s390/drivers/s390/cio/qdio.h
--- linux-2.5/drivers/s390/cio/qdio.h	Sun Jun 22 20:32:36 2003
+++ linux-2.5-s390/drivers/s390/cio/qdio.h	Fri Jun 27 16:04:38 2003
@@ -1,7 +1,7 @@
 #ifndef _CIO_QDIO_H
 #define _CIO_QDIO_H
 
-#define VERSION_CIO_QDIO_H "$Revision: 1.16 $"
+#define VERSION_CIO_QDIO_H "$Revision: 1.17 $"
 
 //#define QDIO_DBF_LIKE_HELL
 
@@ -21,7 +21,15 @@
 #define QDIO_TIMER_POLL_VALUE 1
 #define IQDIO_TIMER_POLL_VALUE 1
 
-#define IQDIO_FILL_LEVEL_TO_POLL (QDIO_MAX_BUFFERS_PER_Q*4/3)
+/*
+ * unfortunately this can't be (QDIO_MAX_BUFFERS_PER_Q*4/3) or so -- as
+ * we never know, whether we'll get initiative again, e.g. to give the
+ * transmit skb's back to the stack, however the stack may be waiting for
+ * them... therefore we define 4 as threshold to start polling (which
+ * will stop as soon as the asynchronous queue catches up)
+ * btw, this only applies to the asynchronous HiperSockets queue
+ */
+#define IQDIO_FILL_LEVEL_TO_POLL 4
 
 #define IQDIO_THININT_ISC 3
 #define IQDIO_DELAY_TARGET 0
diff -urN linux-2.5/include/asm-s390/ccwdev.h linux-2.5-s390/include/asm-s390/ccwdev.h
--- linux-2.5/include/asm-s390/ccwdev.h	Sun Jun 22 20:33:15 2003
+++ linux-2.5-s390/include/asm-s390/ccwdev.h	Fri Jun 27 16:04:38 2003
@@ -115,6 +115,8 @@
 #define CCWDEV_EARLY_NOTIFICATION	0x0001
 /* Report all interrupt conditions. */
 #define CCWDEV_REPORT_ALL	 	0x0002
+/* Try to perform path grouping. */
+#define CCWDEV_DO_PATHGROUP             0x0004
 
 /*
  * ccw_device_start()
