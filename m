Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267384AbTBXSOP>; Mon, 24 Feb 2003 13:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267383AbTBXSNG>; Mon, 24 Feb 2003 13:13:06 -0500
Received: from d06lmsgate-6.uk.ibm.com ([194.196.100.252]:32169 "EHLO
	d06lmsgate-6.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S267024AbTBXSKL> convert rfc822-to-8bit; Mon, 24 Feb 2003 13:10:11 -0500
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (2/13): common i/o layer.
Date: Mon, 24 Feb 2003 19:07:54 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200302241907.54129.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

updates for the channel subsystem and qdio driver

This adds the missing support for chp machine checks, i.e.
enabling or disabling a set of devices from the service element.
Some minor bugs in the driver are fixed as well.

diff -urN linux-2.5.62/drivers/s390/cio/ccwgroup.c linux-2.5.62-s390/drivers/s390/cio/ccwgroup.c
--- linux-2.5.62/drivers/s390/cio/ccwgroup.c	Mon Feb 17 23:56:16 2003
+++ linux-2.5.62-s390/drivers/s390/cio/ccwgroup.c	Mon Feb 24 18:18:38 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/ccwgroup.c
  *  bus driver for ccwgroup
- *   $Revision: 1.5 $
+ *   $Revision: 1.6 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *                       IBM Corporation
diff -urN linux-2.5.62/drivers/s390/cio/chsc.c linux-2.5.62-s390/drivers/s390/cio/chsc.c
--- linux-2.5.62/drivers/s390/cio/chsc.c	Mon Feb 24 18:17:44 2003
+++ linux-2.5.62-s390/drivers/s390/cio/chsc.c	Mon Feb 24 18:23:32 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/chsc.c
  *   S/390 common I/O routines -- channel subsystem call
- *   $Revision: 1.46 $
+ *   $Revision: 1.57 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -53,12 +53,6 @@
 	return test_bit (sch->schib.pmcw.chpid[chp], chpids_logical);
 }
 
-static inline void
-chsc_clear_chpid(struct subchannel *sch, int chp)
-{
-	clear_bit(sch->schib.pmcw.chpid[chp], chpids);
-}
-
 void
 chsc_validate_chpids(struct subchannel *sch)
 {
@@ -69,17 +63,10 @@
 
 	for (chp = 0; chp <= 7; chp++) {
 		mask = 0x80 >> chp;
-		if (sch->lpm & mask) {
+		if (sch->lpm & mask)
 			if (!chsc_chpid_logical(sch, chp))
 				/* disable using this path */
 				sch->lpm &= ~mask;
-		} else {
-			/* This chpid is not
-			 * available to us */
-			chsc_clear_chpid(sch, chp);
-			if (test_bit(chp, chpids_known))
-				set_chp_status(chp, CHP_STANDBY);
-		}
 	}
 }
 
@@ -278,6 +265,7 @@
 		sch = ioinfo[irq];
 		if (sch == NULL)
 			continue;  /* we don't know the device anyway */
+		/* FIXME: Kill pending I/O. */
 		s390_subchannel_remove_chpid(sch, chpid);
 	}
 #endif
@@ -381,6 +369,7 @@
 			continue;
 		}
 	
+		/* FIXME: Kill pending I/O. */
 		spin_lock_irq(&sch->lock);
 
 		chp_mask = s390_process_res_acc_sch(chpid, fla, fla_mask, sch);
@@ -413,7 +402,7 @@
 static void
 do_process_crw(void *ignore)
 {
-	int ccode;
+	int do_sei;
 
 	/*
 	 * build the chsc request block for store event information
@@ -438,94 +427,212 @@
 
 	CIO_TRACE_EVENT( 2, "prcss");
 
-	ccode = chsc(&chsc_area_sei);
-	if (ccode > 0)
-		return;
+	do_sei = 1;
 
-	switch (chsc_area_sei.response_block.response_code) {
-		/* for debug purposes, check for problems */
-	case 0x0001:
-		break; /* everything ok */
-	case 0x0002:
-		CIO_CRW_EVENT(2, "chsc_process_crw:invalid command!\n");
-	case 0x0003:
-		CIO_CRW_EVENT(2, "chsc_process_crw: error in chsc "
-			      "request block!\n");
-		return;
-	case 0x0005:
-		CIO_CRW_EVENT(2, "chsc_process_crw: no event information "
-			      "stored\n");
-		return;
-	default:
-		CIO_CRW_EVENT(2, "chsc_process_crw: chsc response %d\n",
-			      chsc_area_sei.response_block.response_code);
-		return;
-	}
+	while (do_sei) {
+		int ccode;
 
-	CIO_CRW_EVENT(4, "chsc_process_crw: event information successfully "
-		      "stored\n");
+		ccode = chsc(&chsc_area_sei);
+		if (ccode > 0)
+			return;
+
+		switch (sei_res->response_code) {
+			/* for debug purposes, check for problems */
+		case 0x0001:
+			break; /* everything ok */
+		case 0x0002:
+			CIO_CRW_EVENT(2,
+				      "chsc_process_crw: invalid command!\n");
+			return;
+		case 0x0003:
+			CIO_CRW_EVENT(2, "chsc_process_crw: error in chsc "
+				      "request block!\n");
+			return;
+		case 0x0005:
+			CIO_CRW_EVENT(2, "chsc_process_crw: no event "
+				      "information stored\n");
+			return;
+		default:
+			CIO_CRW_EVENT(2, "chsc_process_crw: chsc response %d\n",
+				      sei_res->response_code);
+			return;
+		}
+		
+		CIO_CRW_EVENT(4, "chsc_process_crw: event information "
+			      "successfully stored\n");
+
+		/* Check if there is more event information pending. */
+		if (sei_res->flags & 0x80)
+			CIO_CRW_EVENT( 2, "chsc_process_crw: "
+				       "further event information pending\n");
+		else
+			do_sei = 0;
 
-	if (sei_res->rs != 4) {
-		CIO_CRW_EVENT(2, "chsc_process_crw: "
-			      "reporting source (%04X) isn't a chpid!"
-			      "Aborting processing of machine check...\n",
-			      sei_res->rsid);
-		return;
+		/* Check if we might have lost some information. */
+		if (sei_res->flags & 0x40)
+			CIO_CRW_EVENT( 2, "chsc_process_crw: Event information "
+				       "has been lost due to overflow!\n");
+
+		if (sei_res->rs != 4) {
+			CIO_CRW_EVENT(2, "chsc_process_crw: reporting source "
+				      "(%04X) isn't a chpid!\n",
+				      sei_res->rsid);
+			continue;
+		}
+		
+		/* which kind of information was stored? */
+		switch (sei_res->cc) {
+		case 1: /* link incident*/
+			CIO_CRW_EVENT(4, "chsc_process_crw: "
+				      "channel subsystem reports link incident,"
+				      " source is chpid %x\n", sei_res->rsid);
+			
+			s390_set_chpid_offline(sei_res->rsid);
+			break;
+			
+		case 2: /* i/o resource accessibiliy */
+			CIO_CRW_EVENT(4, "chsc_process_crw: "
+				      "channel subsystem reports some I/O "
+				      "devices may have become accessible\n");
+			pr_debug("Data received after sei: \n");
+			pr_debug("Validity flags: %x\n", sei_res->vf);
+			
+			/* allocate a new channel path structure, if needed */
+			if (chps[sei_res->rsid] == NULL)
+				new_channel_path(sei_res->rsid, CHP_ONLINE);
+			else
+				set_chp_status(sei_res->rsid, CHP_ONLINE);
+			
+			if ((sei_res->vf & 0x80) == 0) {
+				pr_debug("chpid: %x\n", sei_res->rsid);
+				s390_process_res_acc(sei_res->rsid, 0, 0);
+			} else if ((sei_res->vf & 0xc0) == 0x80) {
+				pr_debug("chpid: %x link addr: %x\n",
+					 sei_res->rsid, sei_res->fla);
+				s390_process_res_acc(sei_res->rsid,
+						     sei_res->fla, 0xff00);
+			} else if ((sei_res->vf & 0xc0) == 0xc0) {
+				pr_debug("chpid: %x full link addr: %x\n",
+					 sei_res->rsid, sei_res->fla);
+				s390_process_res_acc(sei_res->rsid,
+						     sei_res->fla, 0xffff);
+			}
+			pr_debug("\n");
+			
+			break;
+			
+		default: /* other stuff */
+			CIO_CRW_EVENT(4, "chsc_process_crw: event %d\n",
+				      sei_res->cc);
+			break;
+		}
+		if (do_sei) {
+			memset(&chsc_area_sei, 0, sizeof(struct sei_area));
+			chsc_area_sei.request_block.command_code1 = 0x0010;
+			chsc_area_sei.request_block.command_code2 = 0x000e;
+		}
 	}
+}
 
-	/* which kind of information was stored? */
-	switch (sei_res->cc) {
-	case 1: /* link incident*/
-		CIO_CRW_EVENT(4, "chsc_process_crw: "
-			      "channel subsystem reports link incident,"
-			      " source is chpid %x\n", sei_res->rsid);
+void
+chsc_process_crw(void)
+{
+	static DECLARE_WORK(work, do_process_crw, 0);
 
-		s390_set_chpid_offline(sei_res->rsid);
-		break;
+	schedule_work(&work);
+}
 
-	case 2: /* i/o resource accessibiliy */
-		CIO_CRW_EVENT(4, "chsc_process_crw: "
-			      "channel subsystem reports some I/O "
-			      "devices may have become accessible\n");
-		pr_debug( KERN_DEBUG "Data received after sei: \n");
-		pr_debug( KERN_DEBUG "Validity flags: %x\n", sei_res->vf);
-
-		/* allocate a new channel path structure, if needed */
-		if (chps[sei_res->rsid] == NULL)
-			new_channel_path(sei_res->rsid, CHP_ONLINE);
-		else
-			set_chp_status(sei_res->rsid, CHP_ONLINE);
+static void
+chp_add(int chpid)
+{
+	struct subchannel *sch;
+	int irq, ret;
+	char dbf_txt[15];
+
+	if (!test_bit(chpid, chpids_logical))
+		return; /* no need to do the rest */
+	
+	sprintf(dbf_txt, "cadd%x", chpid);
+	CIO_TRACE_EVENT(2, dbf_txt);
+
+	for (irq = 0; irq <= __MAX_SUBCHANNELS; irq++) {
+		int i;
 
-		if ((sei_res->vf & 0x80) == 0) {
-			pr_debug( KERN_DEBUG "chpid: %x\n", sei_res->rsid);
-			s390_process_res_acc(sei_res->rsid, 0, 0);
-		} else if ((sei_res->vf & 0xc0) == 0x80) {
-			pr_debug( KERN_DEBUG "chpid: %x link addr: %x\n",
-			       sei_res->rsid, sei_res->fla);
-			s390_process_res_acc(sei_res->rsid, sei_res->fla,
-					     0xff00);
-		} else if ((sei_res->vf & 0xc0) == 0xc0) {
-			pr_debug( KERN_DEBUG "chpid: %x full link addr: %x\n",
-			       sei_res->rsid, sei_res->fla);
-			s390_process_res_acc(sei_res->rsid, sei_res->fla,
-					     0xffff);
+		sch = ioinfo[irq];
+		if (!sch) {
+			ret = css_probe_device(irq);
+			if (ret == -ENXIO)
+				/* We're through */
+				return;
+			continue;
 		}
-		pr_debug( KERN_DEBUG "\n");
+	
+		/* FIXME: Kill pending I/O. */
+		spin_lock(&sch->lock);
+		for (i=0; i<8; i++)
+			if (sch->schib.pmcw.chpid[i] == chpid) {
+				if (stsch(sch->irq, &sch->schib) != 0) {
+					/* Endgame. */
+					spin_unlock(&sch->lock);
+					return;
+				}
+				break;
+			}
+		if (i==8) {
+			spin_unlock(&sch->lock);
+			return;
+		}
+		sch->lpm = (sch->schib.pmcw.pim &
+			    sch->schib.pmcw.pam &
+			    sch->schib.pmcw.pom)
+			| 0x80 >> i;
 
-		break;
+		chsc_validate_chpids(sch);
 
-	default: /* other stuff */
-		CIO_CRW_EVENT(4, "chsc_process_crw: event %d\n", sei_res->cc);
-		break;
+		dev_fsm_event(sch->dev.driver_data, DEV_EVENT_VERIFY);
+
+		spin_unlock(&sch->lock);
 	}
 }
 
+/* 
+ * Handling of crw machine checks with channel path source.
+ */
 void
-chsc_process_crw(void)
+chp_process_crw(int chpid)
 {
-	static DECLARE_WORK(work, do_process_crw, 0);
+	/*
+	 * Update our descriptions. We need this since we don't always
+	 * get machine checks for path come and can't rely on our information
+	 * being consistent otherwise.
+	 */
+	chsc_get_sch_descriptions();
+	if (!cio_chsc_desc_avail) {
+		/*
+		 * Something went wrong...
+		 * We can't reliably say whether a path was there before.
+		 */
+		CIO_CRW_EVENT(0, "Error: Could not retrieve "
+			      "subchannel descriptions, will not process chp"
+			      "machine check...\n");
+		return;
+	}
 
-	schedule_work(&work);
+	if (!test_bit(chpid, chpids)) {
+		/* Path has gone. We use the link incident routine.*/
+		s390_set_chpid_offline(chpid);
+	} else {
+		/* 
+		 * Path has come. Allocate a new channel path structure,
+		 * if needed. 
+		 */
+		if (chps[chpid] == NULL)
+			new_channel_path(chpid, CHP_ONLINE);
+		else
+			set_chp_status(chpid, CHP_ONLINE);
+		/* Avoid the extra overhead in process_rec_acc. */
+		chp_add(chpid);
+	}
 }
 
 /*
@@ -608,8 +715,7 @@
 static ssize_t
 chp_status_show(struct device *dev, char *buf)
 {
-	struct sys_device *sdev = container_of(dev, struct sys_device, dev);
-	struct channel_path *chp = container_of(sdev, struct channel_path, sdev);
+	struct channel_path *chp = container_of(dev, struct channel_path, dev);
 
 	if (!chp)
 		return 0;
@@ -631,8 +737,7 @@
 static ssize_t
 chp_status_write(struct device *dev, const char *buf, size_t count)
 {
-	struct sys_device *sdev = container_of(dev, struct sys_device, dev);
-	struct channel_path *cp = container_of(sdev, struct channel_path, sdev);
+	struct channel_path *cp = container_of(dev, struct channel_path, dev);
 	char cmd[10];
 	int num_args;
 	int error;
@@ -667,29 +772,29 @@
 	chp = kmalloc(sizeof(struct channel_path), GFP_KERNEL);
 	if (!chp)
 		return -ENOMEM;
+	memset(chp, 0, sizeof(struct channel_path));
 
 	chps[chpid] = chp;
 
 	/* fill in status, etc. */
 	chp->id = chpid;
 	chp->state = status;
+	chp->dev.parent = &css_bus_device;
 
-	snprintf(chp->sdev.dev.name, DEVICE_NAME_SIZE,
+	snprintf(chp->dev.name, DEVICE_NAME_SIZE,
 		 "channel path %x", chpid);
-	chp->sdev.name = "channel_path";
-
-	chp->sdev.id = chpid;
+	snprintf(chp->dev.bus_id, DEVICE_ID_SIZE, "chp%x", chpid);
 
 	/* make it known to the system */
-	ret = sys_device_register(&chp->sdev);
+	ret = device_register(&chp->dev);
 	if (ret) {
 		printk(KERN_WARNING "%s: could not register %02x\n",
 		       __func__, chpid);
 		return ret;
 	}
-	ret = device_create_file(&chp->sdev.dev, &dev_attr_status);
+	ret = device_create_file(&chp->dev, &dev_attr_status);
 	if (ret)
-		sys_device_unregister(&chp->sdev);
+		device_unregister(&chp->dev);
 
 	return ret;
 }
diff -urN linux-2.5.62/drivers/s390/cio/chsc.h linux-2.5.62-s390/drivers/s390/cio/chsc.h
--- linux-2.5.62/drivers/s390/cio/chsc.h	Mon Feb 17 23:56:48 2003
+++ linux-2.5.62-s390/drivers/s390/cio/chsc.h	Mon Feb 24 18:18:38 2003
@@ -95,7 +95,7 @@
 struct channel_path {
 	int id;
 	int state;
-	struct sys_device sdev;
+	struct device dev;
 };
 
 extern struct channel_path *chps[];
diff -urN linux-2.5.62/drivers/s390/cio/cio.c linux-2.5.62-s390/drivers/s390/cio/cio.c
--- linux-2.5.62/drivers/s390/cio/cio.c	Mon Feb 17 23:57:18 2003
+++ linux-2.5.62-s390/drivers/s390/cio/cio.c	Mon Feb 24 18:18:38 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/cio.c
  *   S/390 common I/O routines -- low level i/o calls
- *   $Revision: 1.90 $
+ *   $Revision: 1.91 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -197,8 +197,7 @@
 	sch->orb.pfch = sch->options.prefetch == 0;
 	sch->orb.spnd = sch->options.suspend;
 	sch->orb.ssic = sch->options.suspend && sch->options.inter;
-	sch->orb.lpm = (lpm != 0) ? (lpm & sch->lpm) : sch->lpm;
-
+	sch->orb.lpm = (lpm != 0) ? lpm : sch->lpm;
 #ifdef CONFIG_ARCH_S390X
 	/*
 	 * for 64 bit we always support 64 bit IDAWs with 4k page size only
diff -urN linux-2.5.62/drivers/s390/cio/device.c linux-2.5.62-s390/drivers/s390/cio/device.c
--- linux-2.5.62/drivers/s390/cio/device.c	Mon Feb 17 23:56:43 2003
+++ linux-2.5.62-s390/drivers/s390/cio/device.c	Mon Feb 24 18:18:38 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/device.c
  *  bus driver for ccw devices
- *   $Revision: 1.45 $
+ *   $Revision: 1.50 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
@@ -215,6 +215,8 @@
 void
 ccw_device_set_offline(struct ccw_device *cdev)
 {
+	int ret;
+
 	if (!cdev)
 		return;
 	if (!cdev->online || !cdev->drv)
@@ -226,23 +228,36 @@
 
 	cdev->online = 0;
 	spin_lock_irq(cdev->ccwlock);
-	ccw_device_offline(cdev);
+	ret = ccw_device_offline(cdev);
 	spin_unlock_irq(cdev->ccwlock);
-	wait_event(cdev->private->wait_q, dev_fsm_final_state(cdev));
+	if (ret == 0)
+		wait_event(cdev->private->wait_q, dev_fsm_final_state(cdev));
+	else
+		//FIXME: we can't fail!
+		pr_debug("ccw_device_offline returned %d, device %s\n",
+			 ret, cdev->dev.bus_id);
 }
 
 void
 ccw_device_set_online(struct ccw_device *cdev)
 {
-	if (!cdev || !cdev->handler)
+	int ret;
+
+	if (!cdev)
 		return;
 	if (cdev->online || !cdev->drv)
 		return;
 
 	spin_lock_irq(cdev->ccwlock);
-	ccw_device_online(cdev);
+	ret = ccw_device_online(cdev);
 	spin_unlock_irq(cdev->ccwlock);
-	wait_event(cdev->private->wait_q, dev_fsm_final_state(cdev));
+	if (ret == 0)
+		wait_event(cdev->private->wait_q, dev_fsm_final_state(cdev));
+	else {
+		pr_debug("ccw_device_online returned %d, device %s\n",
+			 ret, cdev->dev.bus_id);
+		return;
+	}
 	if (cdev->private->state != DEV_STATE_ONLINE)
 		return;
 	if (!cdev->drv->set_online || cdev->drv->set_online(cdev) == 0) {
@@ -250,9 +265,13 @@
 		return;
 	}
 	spin_lock_irq(cdev->ccwlock);
-	ccw_device_offline(cdev);
+	ret = ccw_device_offline(cdev);
 	spin_unlock_irq(cdev->ccwlock);
-	wait_event(cdev->private->wait_q, dev_fsm_final_state(cdev));
+	if (ret == 0)
+		wait_event(cdev->private->wait_q, dev_fsm_final_state(cdev));
+	else 
+		pr_debug("ccw_device_offline returned %d, device %s\n",
+			 ret, cdev->dev.bus_id);
 }
 
 static ssize_t
@@ -574,7 +593,7 @@
 	 * doubled code.
 	 * This is safe because of the checks in ccw_device_set_offline.
 	 */
-	pr_debug(KERN_INFO "removing device %s, sch %d, devno %x\n",
+	pr_debug("removing device %s, sch %d, devno %x\n",
 		 cdev->dev.name,
 		 cdev->private->irq,
 		 cdev->private->devno);
diff -urN linux-2.5.62/drivers/s390/cio/device_id.c linux-2.5.62-s390/drivers/s390/cio/device_id.c
--- linux-2.5.62/drivers/s390/cio/device_id.c	Mon Feb 17 23:55:48 2003
+++ linux-2.5.62-s390/drivers/s390/cio/device_id.c	Mon Feb 24 18:18:38 2003
@@ -136,7 +136,7 @@
 	ccode = diag210 (&diag_data);
 	ps->reserved = 0xff;
 
-	/* Special case for bloddy osa devices. */
+	/* Special case for bloody osa devices. */
 	if (diag_data.vrdcvcla == 0x02 &&
 	    diag_data.vrdcvtyp == 0x20) {
 		ps->cu_type = 0x3088;
diff -urN linux-2.5.62/drivers/s390/cio/device_ops.c linux-2.5.62-s390/drivers/s390/cio/device_ops.c
--- linux-2.5.62/drivers/s390/cio/device_ops.c	Mon Feb 17 23:56:43 2003
+++ linux-2.5.62-s390/drivers/s390/cio/device_ops.c	Mon Feb 24 18:18:38 2003
@@ -48,7 +48,8 @@
 	if (!cdev)
 		return -ENODEV;
 	if (cdev->private->state != DEV_STATE_ONLINE &&
-	    cdev->private->state != DEV_STATE_W4SENSE)
+	    cdev->private->state != DEV_STATE_W4SENSE &&
+	    cdev->private->state != DEV_STATE_QDIO_ACTIVE)
 		return -EINVAL;
 	sch = to_subchannel(cdev->dev.parent);
 	if (!sch)
@@ -122,6 +123,15 @@
 {
 	struct subchannel *sch;
 	unsigned int stctl;
+	void (*handler)(struct ccw_device *, unsigned long, struct irb *);
+
+	if (cdev->private->state == DEV_STATE_QDIO_ACTIVE) {
+		if (cdev->private->qdio_data)
+			handler = cdev->private->qdio_data->handler;
+		else
+			handler = NULL;
+	} else
+		handler = cdev->handler;
 
 	sch = to_subchannel(cdev->dev.parent);
 
@@ -144,13 +154,9 @@
 	/*
 	 * Now we are ready to call the device driver interrupt handler.
 	 */
-	if (cdev->private->state == DEV_STATE_QDIO_ACTIVE) {
-		if (cdev->private->qdio_data &&
-		    cdev->private->qdio_data->handler)
-			cdev->private->qdio_data->handler(cdev, sch->u_intparm,
-							  &cdev->private->irb);
-	} else
-		cdev->handler (cdev, sch->u_intparm, &cdev->private->irb);
+	if (handler)
+		handler(cdev, sch->u_intparm, &cdev->private->irb);
+
 	/*
 	 * Clear the old and now useless interrupt response block.
 	 */
@@ -245,6 +251,8 @@
 			wait_event(cdev->private->wait_q,
 				   sch->schib.scsw.actl == 0);
 			spin_lock_irqsave(&sch->lock, flags);
+			/* FIXME: Check if we got sensible stuff. */
+			break;
 		}
 	}
 	/* Restore interrupt handler. */
@@ -317,6 +325,8 @@
 		spin_unlock_irqrestore(&sch->lock, flags);
 		wait_event(cdev->private->wait_q, sch->schib.scsw.actl == 0);
 		spin_lock_irqsave(&sch->lock, flags);
+		/* FIXME: Check if we got sensible stuff. */
+		break;
 	}
 	/* Restore interrupt handler. */
 	cdev->handler = handler;
diff -urN linux-2.5.62/drivers/s390/cio/device_pgid.c linux-2.5.62-s390/drivers/s390/cio/device_pgid.c
--- linux-2.5.62/drivers/s390/cio/device_pgid.c	Mon Feb 17 23:56:16 2003
+++ linux-2.5.62-s390/drivers/s390/cio/device_pgid.c	Mon Feb 24 18:18:38 2003
@@ -141,6 +141,8 @@
 	struct subchannel *sch;
 	struct irb *irb;
 	int ret;
+	int opm;
+	int i;
 
 	irb = (struct irb *) __LC_IRB;
 	/* Ignore unsolicited interrupts. */
@@ -154,6 +156,16 @@
 	/* 0, -ETIME, -EOPNOTSUPP, -EAGAIN, -EACCES or -EUSERS */
 	case 0:			/* Sense Path Group ID successful. */
 		cdev->private->flags.pgid_supp = 1;
+		opm = sch->schib.pmcw.pim &
+			sch->schib.pmcw.pam &
+			sch->schib.pmcw.pom;
+		for (i=0;i<8;i++) {
+			if (opm == (0x80 << i)) {
+				/* Don't group single path devices. */
+				cdev->private->flags.pgid_supp = 0;
+				break;
+			}
+		}
 		if (cdev->private->pgid.inf.ps.state1 == SNID_STATE1_RESET)
 			memcpy(&cdev->private->pgid, &global_pgid,
 			       sizeof(struct pgid));
diff -urN linux-2.5.62/drivers/s390/cio/device_status.c linux-2.5.62-s390/drivers/s390/cio/device_status.c
--- linux-2.5.62/drivers/s390/cio/device_status.c	Mon Feb 17 23:56:14 2003
+++ linux-2.5.62-s390/drivers/s390/cio/device_status.c	Mon Feb 24 18:18:38 2003
@@ -62,8 +62,9 @@
 	sch = to_subchannel(cdev->dev.parent);
 	stsch (sch->irq, &sch->schib);
 
-	CIO_MSG_EVENT(0, "cio_process_irq(%04X) - path(s) %02x are "
-		      "not operational ", sch->irq, sch->schib.pmcw.pnom);
+	CIO_MSG_EVENT(0, "%s(%04X) - path(s) %02x are "
+		      "not operational \n", __FUNCTION__, sch->irq,
+		      sch->schib.pmcw.pnom);
 
 	sch->lpm &= ~sch->schib.pmcw.pnom;
 	dev_fsm_event(cdev, DEV_EVENT_VERIFY);
@@ -289,7 +290,7 @@
 	sch = to_subchannel(cdev->dev.parent);
 
 	/* A sense is required, can we do it now ? */
-	if (irb->scsw.actl != 0)
+	if ((irb->scsw.actl  & (SCSW_ACTL_DEVACT | SCSW_ACTL_SCHACT)) != 0)
 		/*
 		 * we received an Unit Check but we have no final
 		 *  status yet, therefore we must delay the SENSE
@@ -348,7 +349,7 @@
 ccw_device_accumulate_and_sense(struct ccw_device *cdev, struct irb *irb)
 {
 	ccw_device_accumulate_irb(cdev, irb);
-	if (irb->scsw.actl != 0)
+	if ((irb->scsw.actl  & (SCSW_ACTL_DEVACT | SCSW_ACTL_SCHACT)) != 0)
 		return -EBUSY;
 	/* Check for basic sense. */
 	if (cdev->private->flags.dosense &&
diff -urN linux-2.5.62/drivers/s390/cio/ioasm.h linux-2.5.62-s390/drivers/s390/cio/ioasm.h
--- linux-2.5.62/drivers/s390/cio/ioasm.h	Mon Feb 17 23:57:22 2003
+++ linux-2.5.62-s390/drivers/s390/cio/ioasm.h	Mon Feb 24 18:18:38 2003
@@ -2,83 +2,6 @@
 #define S390_CIO_IOASM_H
 
 /*
- * area for channel subsystem call
- */
-struct chsc_area {
-	struct {
-		/* word 0 */
-		__u16 command_code1;
-		__u16 command_code2;
-		union {
-			struct {
-				/* word 1 */
-				__u32 reserved1;
-				/* word 2 */
-				__u32 reserved2;
-			} __attribute__ ((packed,aligned(8))) sei_req;
-			struct {
-				/* word 1 */
-				__u16 reserved1;
-				__u16 f_sch;	 /* first subchannel */
-				/* word 2 */
-				__u16 reserved2;
-				__u16 l_sch;	/* last subchannel */
-			} __attribute__ ((packed,aligned(8))) ssd_req;
-		} request_block_data;
-		/* word 3 */
-		__u32 reserved3;
-	} __attribute__ ((packed,aligned(8))) request_block;
-	struct {
-		/* word 0 */
-		__u16 length;
-		__u16 response_code;
-		/* word 1 */
-		__u32 reserved1;
-		union {
-			struct {
-				/* word 2 */
-				__u8  flags;
-				__u8  vf;	  /* validity flags */
-				__u8  rs;	  /* reporting source */
-				__u8  cc;	  /* content code */
-				/* word 3 */
-				__u16 fla;	  /* full link address */
-				__u16 rsid;	  /* reporting source id */
-				/* word 4 */
-				__u32 reserved2;
-				/* word 5 */
-				__u32 reserved3;
-				/* word 6 */
-				__u32 ccdf;	  /* content-code dependent field */
-				/* word 7 */
-				__u32 reserved4;
-				/* word 8 */
-				__u32 reserved5;
-				/* word 9 */
-				__u32 reserved6;
-			} __attribute__ ((packed,aligned(8))) sei_res;
-			struct {
-				/* word 2 */
-				__u8 sch_valid : 1;
-				__u8 dev_valid : 1;
-				__u8 st	       : 3; /* subchannel type */
-				__u8 zeroes    : 3;
-				__u8  unit_addr;  /* unit address */
-				__u16 devno;	  /* device number */
-				/* word 3 */
-				__u8 path_mask;
-				__u8 fla_valid_mask;
-				__u16 sch;	  /* subchannel */
-				/* words 4-5 */
-				__u8 chpid[8];	  /* chpids 0-7 */
-				/* words 6-9 */
-				__u16 fla[8];	  /* full link addresses 0-7 */
-			} __attribute__ ((packed,aligned(8))) ssd_res;
-		} response_block_data;
-	} __attribute__ ((packed,aligned(8))) response_block;
-} __attribute__ ((packed,aligned(PAGE_SIZE)));
-
-/*
  * TPI info structure
  */
 struct tpi_info {
diff -urN linux-2.5.62/drivers/s390/cio/qdio.c linux-2.5.62-s390/drivers/s390/cio/qdio.c
--- linux-2.5.62/drivers/s390/cio/qdio.c	Mon Feb 17 23:56:19 2003
+++ linux-2.5.62-s390/drivers/s390/cio/qdio.c	Mon Feb 24 18:18:38 2003
@@ -55,7 +55,7 @@
 #include "qdio.h"
 #include "ioasm.h"
 
-#define VERSION_QDIO_C "$Revision: 1.18 $"
+#define VERSION_QDIO_C "$Revision: 1.34 $"
 
 /****************** MODULE PARAMETER VARIABLES ********************/
 MODULE_AUTHOR("Utz Bacher <utz.bacher@de.ibm.com>");
@@ -87,8 +87,6 @@
 static debug_info_t *qdio_dbf_slsb_in;
 #endif /* QDIO_DBF_LIKE_HELL */
 
-static struct semaphore init_sema;
-
 static struct qdio_chsc_area *chsc_area;
 /* iQDIO stuff: */
 static volatile struct qdio_q *iq_list=NULL; /* volatile as it could change
@@ -752,7 +750,7 @@
 #endif /* QDIO_DBF_LIKE_HELL */
 
 	if (q->state==QDIO_IRQ_STATE_ACTIVE)
-		q->handler(q->irq,
+		q->handler(q->cdev,
 			   QDIO_STATUS_INBOUND_INT|q->error_status_flags,
 			   q->qdio_error,q->siga_error,q->q_no,start,count,
 			   q->int_parm);
@@ -1039,7 +1037,7 @@
 #endif /* QDIO_DBF_LIKE_HELL */
 
 	if (q->state==QDIO_IRQ_STATE_ACTIVE)
-		q->handler(q->irq,QDIO_STATUS_OUTBOUND_INT|
+		q->handler(q->cdev,QDIO_STATUS_OUTBOUND_INT|
 			   q->error_status_flags,
 			   q->qdio_error,q->siga_error,q->q_no,start,count,
 			   q->int_parm);
@@ -1283,7 +1281,8 @@
 }
 
 static int
-qdio_alloc_qs(struct qdio_irq *irq_ptr, int no_input_qs, int no_output_qs,
+qdio_alloc_qs(struct qdio_irq *irq_ptr, struct ccw_device *cdev,
+	      int no_input_qs, int no_output_qs,
 	      qdio_handler_t *input_handler,
 	      qdio_handler_t *output_handler,
 	      unsigned long int_parm,int q_format,
@@ -1327,6 +1326,7 @@
 		q->int_parm=int_parm;
 		irq_ptr->input_qs[i]=q;
 		q->irq=irq_ptr->irq;
+		q->cdev = cdev;
 		q->mask=1<<(31-i);
 		q->q_no=i;
 		q->is_input_q=1;
@@ -1403,6 +1403,7 @@
 		irq_ptr->output_qs[i]=q;
 		q->is_input_q=0;
 		q->irq=irq_ptr->irq;
+		q->cdev = cdev;
 		q->mask=1<<(31-i);
 		q->q_no=i;
 		q->first_to_check=0;
@@ -1626,7 +1627,7 @@
 				       "device %s!?\n", cdev->dev.bus_id);
 			goto omit_handler_call;
 		}
-		q->handler(q->irq,QDIO_STATUS_ACTIVATE_CHECK_CONDITION|
+		q->handler(q->cdev,QDIO_STATUS_ACTIVATE_CHECK_CONDITION|
 			   QDIO_STATUS_LOOK_FOR_ERROR,
 			   0,0,0,-1,-1,q->int_parm);
 	omit_handler_call:
@@ -1636,7 +1637,6 @@
 
 }
 
-/* this is for mp3 */
 int
 qdio_synchronize(struct ccw_device *cdev, unsigned int flags,
 		 unsigned int queue_number)
@@ -1882,10 +1882,8 @@
 qdio_cleanup(struct ccw_device *cdev, int how)
 {
 	struct qdio_irq *irq_ptr;
-	int i,result;
-	unsigned long flags;
-	int timeout;
-	char dbf_text[15]="12345678";
+	char dbf_text[15];
+	int rc;
 
 	irq_ptr = cdev->private->qdio_data;
 	if (!irq_ptr)
@@ -1895,9 +1893,31 @@
 	QDIO_DBF_TEXT1(0,trace,dbf_text);
 	QDIO_DBF_TEXT0(0,setup,dbf_text);
 
-	spin_lock(&irq_ptr->setting_up_lock);
+	rc = qdio_shutdown(cdev, how);
+	if (rc == 0)
+		rc = qdio_free(cdev);
+	return rc;
+}
 
-	result=0;
+int
+qdio_shutdown(struct ccw_device *cdev, int how)
+{
+	struct qdio_irq *irq_ptr;
+	int i;
+	int result = 0;
+	unsigned long flags;
+	int timeout;
+	char dbf_text[15]="12345678";
+
+	irq_ptr = cdev->private->qdio_data;
+	if (!irq_ptr)
+		return -ENODEV;
+
+	down(&irq_ptr->setting_up_sema);
+
+	sprintf(dbf_text,"qsqs%4x",irq_ptr->irq);
+	QDIO_DBF_TEXT1(0,trace,dbf_text);
+	QDIO_DBF_TEXT0(0,setup,dbf_text);
 
 	/* mark all qs as uninteresting */
 	for (i=0;i<irq_ptr->no_input_qs;i++)
@@ -1913,6 +1933,13 @@
 		tasklet_kill(&irq_ptr->input_qs[i]->tasklet);
 		if (qdio_wait_for_no_use_count(&irq_ptr->input_qs[i]->
 					       use_count))
+			/*
+			 * FIXME:
+			 * nobody cares about such retval,
+			 * does a timeout make sense at all?
+			 * can this case be eliminated?
+			 * mutex should be released anyway, shouldn't it?
+			 */ 
 			result=-EINPROGRESS;
 	}
 
@@ -1920,9 +1947,19 @@
 		tasklet_kill(&irq_ptr->output_qs[i]->tasklet);
 		if (qdio_wait_for_no_use_count(&irq_ptr->output_qs[i]->
 					       use_count))
+			/*
+			 * FIXME:
+			 * nobody cares about such retval,
+			 * does a timeout make sense at all?
+			 * can this case be eliminated?
+			 * mutex should be released anyway, shouldn't it?
+			 */ 
 			result=-EINPROGRESS;
 	}
 
+	if (result)
+		goto out;
+
 	/* cleanup subchannel */
 	spin_lock_irqsave(get_ccwdev_lock(cdev),flags);
 	if (how&QDIO_FLAG_CLEANUP_USING_CLEAR) {
@@ -1940,7 +1977,10 @@
 	spin_unlock_irqrestore(get_ccwdev_lock(cdev),flags);
 
 	wait_event(cdev->private->wait_q, dev_fsm_final_state(cdev));
-	return 0;
+
+out:
+	up(&irq_ptr->setting_up_sema);
+	return result;
 }
 
 static inline void
@@ -1955,6 +1995,34 @@
 	qdio_set_state(irq_ptr,QDIO_IRQ_STATE_INACTIVE);
 }
 
+int
+qdio_free(struct ccw_device *cdev)
+{
+	struct qdio_irq *irq_ptr;
+	char dbf_text[15];
+
+	irq_ptr = cdev->private->qdio_data;
+	if (!irq_ptr)
+		return -ENODEV;
+
+	down(&irq_ptr->setting_up_sema);
+
+	sprintf(dbf_text,"qfqs%4x",irq_ptr->irq);
+	QDIO_DBF_TEXT1(0,trace,dbf_text);
+	QDIO_DBF_TEXT0(0,setup,dbf_text);
+
+	if (cdev->private->state != DEV_STATE_ONLINE)
+		return -EINVAL;
+
+	qdio_cleanup_finish(irq_ptr);
+	cdev->private->qdio_data = 0;
+
+	up(&irq_ptr->setting_up_sema);
+
+	qdio_release_irq_memory(irq_ptr);
+	return 0;
+}
+
 static void
 qdio_cleanup_handle_timeout(struct ccw_device *cdev)
 {
@@ -1967,14 +2035,8 @@
 	QDIO_PRINT_INFO("Did not get interrupt on cleanup, irq=0x%x.\n",
 			irq_ptr->irq);
 
-	qdio_cleanup_finish(irq_ptr);
-
 	spin_unlock_irqrestore(get_ccwdev_lock(cdev),flags);
 
-	spin_unlock(&irq_ptr->setting_up_lock);
-
-	cdev->private->qdio_data = 0;
-	qdio_release_irq_memory(irq_ptr);
 	cdev->private->state = DEV_STATE_ONLINE;
 	wake_up(&cdev->private->wait_q);
 }
@@ -1984,10 +2046,6 @@
 			struct irb *irb)
 {
 	struct qdio_irq *irq_ptr;
-	int cstat,dstat;
-
-	cstat = irb->scsw.cstat;
-        dstat = irb->scsw.dstat;
 
 	if (intparm == 0)
 		QDIO_PRINT_WARN("Got unsolicited interrupt on cleanup "
@@ -1997,22 +2055,16 @@
 
 	qdio_irq_check_sense(irq_ptr->irq, irb);
 
-	qdio_cleanup_finish(irq_ptr);
-
-	spin_unlock(&irq_ptr->setting_up_lock);
-
-	cdev->private->qdio_data = 0;
-	qdio_release_irq_memory(irq_ptr);
 	cdev->private->state = DEV_STATE_ONLINE;
 	wake_up(&cdev->private->wait_q);
 }
 
 static inline void
-qdio_initialize_do_dbf(struct qdio_initialize *init_data)
+qdio_allocate_do_dbf(struct qdio_initialize *init_data)
 {
 	char dbf_text[20]; /* if a printf would print out more than 8 chars */
 
-	sprintf(dbf_text,"qini%4x",init_data->cdev->private->irq);
+	sprintf(dbf_text,"qalc%4x",init_data->cdev->private->irq);
 	QDIO_DBF_TEXT0(0,setup,dbf_text);
 	QDIO_DBF_TEXT0(0,trace,dbf_text);
 	sprintf(dbf_text,"qfmt:%x",init_data->q_format);
@@ -2045,7 +2097,7 @@
 }
 
 static inline void
-qdio_initialize_fill_input_desc(struct qdio_irq *irq_ptr, int i, int iqfmt)
+qdio_allocate_fill_input_desc(struct qdio_irq *irq_ptr, int i, int iqfmt)
 {
 	irq_ptr->input_qs[i]->is_iqdio_q = iqfmt;
 
@@ -2063,8 +2115,8 @@
 }
 
 static inline void
-qdio_initialize_fill_output_desc(struct qdio_irq *irq_ptr, int i, 
-				 int j, int iqfmt)
+qdio_allocate_fill_output_desc(struct qdio_irq *irq_ptr, int i,
+			       int j, int iqfmt)
 {
 	irq_ptr->output_qs[i]->is_iqdio_q = iqfmt;
 
@@ -2092,10 +2144,13 @@
 	QDIO_PRINT_ERR("establish queues on irq %04x: timed out\n",
 		       irq_ptr->irq);
 	QDIO_DBF_TEXT2(1,setup,"eq:timeo");
-	spin_unlock(&irq_ptr->setting_up_lock);
-	qdio_cleanup(cdev,QDIO_FLAG_CLEANUP_USING_CLEAR);
-
-	up(&init_sema);
+	/*
+	 * FIXME:
+	 * this is broken,
+	 * we are in the context of a timer interrupt and
+	 * qdio_shutdown calls schedule
+	 */
+	qdio_shutdown(cdev,QDIO_FLAG_CLEANUP_USING_CLEAR);
 }
 
 static inline void
@@ -2163,9 +2218,13 @@
 		QDIO_PRINT_ERR("establish queues on irq %04x: didn't get "
 			       "device end: dstat=%02x, cstat=%02x\n",
 			       irq_ptr->irq, dstat, cstat);
-		spin_unlock(&irq_ptr->setting_up_lock);
-		qdio_cleanup(cdev,QDIO_FLAG_CLEANUP_USING_CLEAR);
-		up(&init_sema);
+		/*
+		 * FIXME:
+		 * this is broken,
+		 * we are probably in the context of an i/o interrupt and
+		 * qdio_shutdown calls schedule
+		 */
+		qdio_shutdown(cdev,QDIO_FLAG_CLEANUP_USING_CLEAR);
 		return 1;
 	}
 
@@ -2178,9 +2237,6 @@
 			       "cstat=%02x\n",
 			       irq_ptr->irq, dstat, cstat);
 		cdev->private->state = DEV_STATE_ONLINE;
-		spin_unlock(&irq_ptr->setting_up_lock);
-
-		up(&init_sema);
 		return 1;
 	}
 	return 0;
@@ -2202,7 +2258,7 @@
 	if (intparm == 0) {
 		QDIO_PRINT_WARN("Got unsolicited interrupt on establish "
 				"queues (irq 0x%x).\n", cdev->private->irq);
-		goto out;
+		return;
 	}
 
 	qdio_irq_check_sense(irq_ptr->irq, irb);
@@ -2231,46 +2287,51 @@
 	qdio_initialize_set_siga_flags_output(irq_ptr);
 
 	qdio_set_state(irq_ptr,QDIO_IRQ_STATE_ESTABLISHED);
+}
 
- out:
-	if (irq_ptr)
-		spin_unlock(&irq_ptr->setting_up_lock);
+int
+qdio_initialize(struct qdio_initialize *init_data)
+{
+	int rc;
+	char dbf_text[15];
+
+	sprintf(dbf_text,"qini%4x",init_data->cdev->private->irq);
+	QDIO_DBF_TEXT0(0,setup,dbf_text);
+	QDIO_DBF_TEXT0(0,trace,dbf_text);
 
-	up(&init_sema);
+	rc = qdio_allocate(init_data);
+	if (rc == 0) {
+		rc = qdio_establish(init_data->cdev);
+		if (rc != 0)
+			qdio_free(init_data->cdev);
+	}
 
+	return rc;
 }
 
+
 int
-qdio_initialize(struct qdio_initialize *init_data)
+qdio_allocate(struct qdio_initialize *init_data)
 {
 	int i;
-	unsigned long saveflags;
 	struct qdio_irq *irq_ptr;
 	struct ciw *ciw;
-	int result,result2;
+	int result;
 	int is_iqdio;
-	char dbf_text[20]; /* if a printf would print out more than 8 chars */
-
-	down_interruptible(&init_sema);
 
 	if ( (init_data->no_input_qs>QDIO_MAX_QUEUES_PER_IRQ) ||
 	     (init_data->no_output_qs>QDIO_MAX_QUEUES_PER_IRQ) ||
 	     ((init_data->no_input_qs) && (!init_data->input_handler)) ||
-	     ((init_data->no_output_qs) && (!init_data->output_handler)) ) {
-		result=-EINVAL;
-		goto out;
-	}
+	     ((init_data->no_output_qs) && (!init_data->output_handler)) )
+		return -EINVAL;
 
-	if (!init_data->input_sbal_addr_array) {
-		result=-EINVAL;
-		goto out;
-	}
-	if (!init_data->output_sbal_addr_array) {
-		result=-EINVAL;
-		goto out;
-	}
+	if (!init_data->input_sbal_addr_array)
+		return -EINVAL;
+
+	if (!init_data->output_sbal_addr_array)
+		return -EINVAL;
 
-	qdio_initialize_do_dbf(init_data);
+	qdio_allocate_do_dbf(init_data);
 
 	/* create irq */
 	irq_ptr=kmalloc(sizeof(struct qdio_irq),GFP_DMA);
@@ -2280,8 +2341,7 @@
 
 	if (!irq_ptr) {
 		QDIO_PRINT_ERR("kmalloc of irq_ptr failed!\n");
-		result=-ENOMEM;
-		goto out;
+		return -ENOMEM;
 	}
 
 	memset(irq_ptr,0,sizeof(struct qdio_irq));
@@ -2292,8 +2352,7 @@
    		kfree(irq_ptr->qdr);
    		kfree(irq_ptr);
     		QDIO_PRINT_ERR("kmalloc of irq_ptr->qdr failed!\n");
-     		result=-ENOMEM;
-      		goto out;
+		return -ENOMEM;
        	}
 	memset(irq_ptr->qdr,0,sizeof(struct qdr));
 	QDIO_DBF_TEXT0(0,setup,"qdr:");
@@ -2313,9 +2372,13 @@
 		if (!irq_ptr->dev_st_chg_ind) {
 			QDIO_PRINT_WARN("no indicator location available " \
 					"for irq 0x%x\n",irq_ptr->irq);
+			/*
+			 * FIXME:
+			 * qdio_release_irq_memory does MOD_DEC_USE_COUNT
+			 * in an unbalanced fashion (see 30 lines farther down)
+			 */
 			qdio_release_irq_memory(irq_ptr);
-			result=-ENOBUFS;
-			goto out;
+			return -ENOBUFS;
 		}
 	}
 
@@ -2325,26 +2388,29 @@
 	irq_ptr->aqueue.cmd=DEFAULT_ACTIVATE_QS_CMD;
 	irq_ptr->aqueue.count=DEFAULT_ACTIVATE_QS_COUNT;
 
-	if (!qdio_alloc_qs(irq_ptr,init_data->no_input_qs,
+	if (!qdio_alloc_qs(irq_ptr, init_data->cdev,
+			   init_data->no_input_qs,
 			   init_data->no_output_qs,
 			   init_data->input_handler,
 			   init_data->output_handler,init_data->int_parm,
 			   init_data->q_format,init_data->flags,
 			   init_data->input_sbal_addr_array,
 			   init_data->output_sbal_addr_array)) {
+		/*
+		 * FIXME:
+		 * qdio_release_irq_memory does MOD_DEC_USE_COUNT
+		 * in an unbalanced fashion (see 10 lines farther down)
+		 */
 		qdio_release_irq_memory(irq_ptr);
-		result=-ENOMEM;
-		goto out;
+		return -ENOMEM;
 	}
 
 	qdio_set_state(irq_ptr,QDIO_IRQ_STATE_INACTIVE);
 
-	irq_ptr->setting_up_lock=SPIN_LOCK_UNLOCKED;
-
 	MOD_INC_USE_COUNT;
 	QDIO_DBF_TEXT3(0,setup,"MOD_INC_");
 
-	spin_lock(&irq_ptr->setting_up_lock);
+	init_MUTEX_LOCKED(&irq_ptr->setting_up_sema);
 
 	init_data->cdev->private->qdio_data = irq_ptr;
 
@@ -2383,12 +2449,12 @@
 	/* first input descriptors, then output descriptors */
 	is_iqdio = (init_data->q_format == QDIO_IQDIO_QFMT) ? 1 : 0;
 	for (i=0;i<init_data->no_input_qs;i++)
-		qdio_initialize_fill_input_desc(irq_ptr, i, is_iqdio);
+		qdio_allocate_fill_input_desc(irq_ptr, i, is_iqdio);
 
 	for (i=0;i<init_data->no_output_qs;i++)
-		qdio_initialize_fill_output_desc(irq_ptr, i,
-						 init_data->no_input_qs,
-						 is_iqdio);
+		qdio_allocate_fill_output_desc(irq_ptr, i,
+					       init_data->no_input_qs,
+					       is_iqdio);
 
 	/* qdr, qib, sls, slsbs, slibs, sbales filled. */
 
@@ -2418,9 +2484,15 @@
 		}
 		result=iqdio_set_subchannel_ind(irq_ptr,0);
 		if (result) {
-			spin_unlock(&irq_ptr->setting_up_lock);
+			up(&irq_ptr->setting_up_sema);
+			/*
+			 * FIXME:
+			 * need some callback pointers to be set already,
+			 * i.e. irq_ptr->cleanup_irq and irq_ptr->cleanup_timeout?
+			 * (see 10 lines farther down)
+			 */
 			qdio_cleanup(init_data->cdev, QDIO_FLAG_CLEANUP_USING_CLEAR);
-			goto out2;
+			return result;
 		}
 		iqdio_set_delay_target(irq_ptr,IQDIO_DELAY_TARGET);
 	}
@@ -2432,20 +2504,46 @@
 	irq_ptr->establish_timeout = qdio_establish_handle_timeout;
 	irq_ptr->handler = qdio_handler;
 
+	up(&irq_ptr->setting_up_sema);
+
+	return 0;
+}
+
+int
+qdio_establish(struct ccw_device *cdev)
+{
+	struct qdio_irq *irq_ptr;
+	unsigned long saveflags;
+	int result, result2;
+	char dbf_text[20];
+
+	irq_ptr = cdev->private->qdio_data;
+	if (!irq_ptr)
+		return -EINVAL;
+
+	if (cdev->private->state != DEV_STATE_ONLINE)
+		return -EINVAL;
+	
+	down(&irq_ptr->setting_up_sema);
+
+	sprintf(dbf_text,"qest%4x",cdev->private->irq);
+	QDIO_DBF_TEXT0(0,setup,dbf_text);
+	QDIO_DBF_TEXT0(0,trace,dbf_text);
+
 	/* establish q */
 	irq_ptr->ccw.cmd_code=irq_ptr->equeue.cmd;
 	irq_ptr->ccw.flags=CCW_FLAG_SLI;
 	irq_ptr->ccw.count=irq_ptr->equeue.count;
 	irq_ptr->ccw.cda=QDIO_GET_ADDR(irq_ptr->qdr);
 
-	spin_lock_irqsave(get_ccwdev_lock(init_data->cdev),saveflags);
+	spin_lock_irqsave(get_ccwdev_lock(cdev),saveflags);
 
-	ccw_device_set_timeout(init_data->cdev, QDIO_ESTABLISH_TIMEOUT);
-	ccw_device_set_options(init_data->cdev, 0);
-	result=ccw_device_start(init_data->cdev,&irq_ptr->ccw,
+	ccw_device_set_timeout(cdev, QDIO_ESTABLISH_TIMEOUT);
+	ccw_device_set_options(cdev, 0);
+	result=ccw_device_start(cdev,&irq_ptr->ccw,
 				QDIO_DOING_ESTABLISH,0,0);
 	if (result) {
-		result2=ccw_device_start(init_data->cdev,&irq_ptr->ccw,
+		result2=ccw_device_start(cdev,&irq_ptr->ccw,
 					 QDIO_DOING_ESTABLISH,0,0);
 		sprintf(dbf_text,"eq:io%4x",result);
 		QDIO_DBF_TEXT2(1,setup,dbf_text);
@@ -2459,28 +2557,25 @@
 		result=result2;
 	}
 	if (result == 0)
-		init_data->cdev->private->state = DEV_STATE_QDIO_INIT;
-	spin_unlock_irqrestore(get_ccwdev_lock(init_data->cdev),saveflags);
+		cdev->private->state = DEV_STATE_QDIO_INIT;
+	spin_unlock_irqrestore(get_ccwdev_lock(cdev),saveflags);
 
 	if (result) {
-		spin_unlock(&irq_ptr->setting_up_lock);
-		qdio_cleanup(init_data->cdev,QDIO_FLAG_CLEANUP_USING_CLEAR);
-		goto out2;
+		up(&irq_ptr->setting_up_sema);
+		qdio_shutdown(cdev,QDIO_FLAG_CLEANUP_USING_CLEAR);
+		return result;
 	}
 	
-	wait_event(init_data->cdev->private->wait_q,
-		   dev_fsm_final_state(init_data->cdev) ||
+	wait_event(cdev->private->wait_q,
+		   dev_fsm_final_state(cdev) ||
 		   (irq_ptr->state == QDIO_IRQ_STATE_ESTABLISHED));
 
-	if (init_data->cdev->private->state == DEV_STATE_QDIO_INIT)
-		return 0;
+	if (cdev->private->state == DEV_STATE_QDIO_INIT)
+		result = 0;
+	else 
+		result = -EIO;
 
-	result = -EIO;
- out:
-	if (irq_ptr)
-		spin_unlock(&irq_ptr->setting_up_lock);
- out2:
-	up(&init_sema);
+	up(&irq_ptr->setting_up_sema);
 
 	return result;
 	
@@ -2501,7 +2596,7 @@
 	if (cdev->private->state != DEV_STATE_QDIO_INIT)
 		return -EINVAL;
 
-	spin_lock(&irq_ptr->setting_up_lock);
+	down(&irq_ptr->setting_up_sema);
 	if (irq_ptr->state==QDIO_IRQ_STATE_INACTIVE) {
 		result=-EBUSY;
 		goto out;
@@ -2564,10 +2659,12 @@
 		}
 	}
 
+	qdio_wait_nonbusy(QDIO_ACTIVATE_DELAY);
+
 	qdio_set_state(irq_ptr,QDIO_IRQ_STATE_ACTIVE);
 
  out:
-	spin_unlock(&irq_ptr->setting_up_lock);
+	up(&irq_ptr->setting_up_sema);
 
 	return result;
 }
@@ -3016,8 +3113,6 @@
 	if (res)
 		return res;
 
-	sema_init(&init_sema,1);
-
 	res = qdio_register_dbf_views();
 	if (res)
 		return res;
@@ -3051,8 +3146,12 @@
 module_init(init_QDIO);
 module_exit(cleanup_QDIO);
 
+EXPORT_SYMBOL(qdio_allocate);
+EXPORT_SYMBOL(qdio_establish);
 EXPORT_SYMBOL(qdio_initialize);
 EXPORT_SYMBOL(qdio_activate);
 EXPORT_SYMBOL(do_QDIO);
+EXPORT_SYMBOL(qdio_shutdown);
+EXPORT_SYMBOL(qdio_free);
 EXPORT_SYMBOL(qdio_cleanup);
 EXPORT_SYMBOL(qdio_synchronize);
diff -urN linux-2.5.62/drivers/s390/cio/qdio.h linux-2.5.62-s390/drivers/s390/cio/qdio.h
--- linux-2.5.62/drivers/s390/cio/qdio.h	Mon Feb 17 23:56:01 2003
+++ linux-2.5.62-s390/drivers/s390/cio/qdio.h	Mon Feb 24 18:18:38 2003
@@ -1,7 +1,7 @@
 #ifndef _CIO_QDIO_H
 #define _CIO_QDIO_H
 
-#define VERSION_CIO_QDIO_H "$Revision: 1.8 $"
+#define VERSION_CIO_QDIO_H "$Revision: 1.11 $"
 
 //#define QDIO_DBF_LIKE_HELL
 
@@ -48,6 +48,10 @@
 #define QDIO_STATS_CLASSES 2
 #define QDIO_STATS_COUNT_NEEDED 2*/
 
+#define QDIO_ACTIVATE_DELAY 5 /* according to brenton belmar and paul
+				 gioquindo it can take up to 5ms before
+				 queues are really active */
+
 #define QDIO_NO_USE_COUNT_TIME 10
 #define QDIO_NO_USE_COUNT_TIMEOUT 1000 /* wait for 1 sec on each q before
 					  exiting without having use_count
@@ -579,6 +583,7 @@
 
 	int is_input_q;
 	int irq;
+	struct ccw_device *cdev;
 
 	unsigned int is_iqdio_q;
 
@@ -670,7 +675,7 @@
 	unsigned int sync_done_on_outb_pcis;
 
 	unsigned int state;
-	spinlock_t setting_up_lock;
+	struct semaphore setting_up_sema;
 
 	unsigned int no_input_qs;
 	unsigned int no_output_qs;
diff -urN linux-2.5.62/drivers/s390/s390mach.c linux-2.5.62-s390/drivers/s390/s390mach.c
--- linux-2.5.62/drivers/s390/s390mach.c	Mon Feb 17 23:57:19 2003
+++ linux-2.5.62-s390/drivers/s390/s390mach.c	Mon Feb 24 18:18:38 2003
@@ -21,6 +21,7 @@
 
 extern void css_process_crw(int);
 extern void chsc_process_crw(void);
+extern void chp_process_crw(int);
 
 static void
 s390_handle_damage(char *msg)
@@ -53,29 +54,25 @@
 		    crw.erc, crw.rsid);
 		switch (crw.rsc) {
 		case CRW_RSC_SCH:
-			pr_debug(KERN_NOTICE, "source is subchannel %04X\n",
-				 crw.rsid);
+			pr_debug("source is subchannel %04X\n", crw.rsid);
 			css_process_crw (crw.rsid);
 			break;
 		case CRW_RSC_MONITOR:
-			pr_debug(KERN_NOTICE,
-				 "source is monitoring facility\n");
+			pr_debug("source is monitoring facility\n");
 			break;
 		case CRW_RSC_CPATH:
-			pr_debug(KERN_NOTICE,
-				 "source is channel path %02X\n",
-				 pcrwe->crw.rsid);
+			pr_debug("source is channel path %02X\n", crw.rsid);
+			chp_process_crw(crw.rsid);
 			break;
 		case CRW_RSC_CONFIG:
-			pr_debug(KERN_NOTICE,
-				 "source is configuration-alert facility\n");
+			pr_debug("source is configuration-alert facility\n");
 			break;
 		case CRW_RSC_CSS:
-			pr_debug(KERN_NOTICE, "source is channel subsystem\n");
+			pr_debug("source is channel subsystem\n");
 			chsc_process_crw();
 			break;
 		default:
-			pr_debug(KERN_NOTICE, "unknown source\n");
+			pr_debug("unknown source\n");
 			break;
 		}
 	} while (crw.chn);
diff -urN linux-2.5.62/include/asm-s390/qdio.h linux-2.5.62-s390/include/asm-s390/qdio.h
--- linux-2.5.62/include/asm-s390/qdio.h	Mon Feb 17 23:56:00 2003
+++ linux-2.5.62-s390/include/asm-s390/qdio.h	Mon Feb 24 18:18:38 2003
@@ -50,11 +50,11 @@
 } __attribute__ ((packed,aligned(256)));
 
 
-/* params are: irq, status, qdio_error, siga_error,
+/* params are: ccw_device, status, qdio_error, siga_error,
    queue_number, first element processed, number of elements processed,
    int_parm */
-typedef void qdio_handler_t(int,unsigned int,unsigned int,unsigned int,
-			    unsigned int,int,int,unsigned long);
+typedef void qdio_handler_t(struct ccw_device *,unsigned int,unsigned int,
+			    unsigned int,unsigned int,int,int,unsigned long);
 
 
 #define QDIO_STATUS_INBOUND_INT 0x01
@@ -100,6 +100,8 @@
 	void **output_sbal_addr_array; /* addr of n*128 void ptrs */
 };
 extern int qdio_initialize(struct qdio_initialize *init_data);
+extern int qdio_allocate(struct qdio_initialize *init_data);
+extern int qdio_establish(struct ccw_device *);
 
 extern int qdio_activate(struct ccw_device *,int flags);
 
@@ -127,6 +129,8 @@
 			    unsigned int queue_number);
 
 extern int qdio_cleanup(struct ccw_device*, int how);
+extern int qdio_shutdown(struct ccw_device*, int how);
+extern int qdio_free(struct ccw_device*);
 
 unsigned char qdio_get_slsb_state(struct ccw_device*, unsigned int flag,
 				  unsigned int queue_number,
diff -urN linux-2.5.62/include/asm-s390x/qdio.h linux-2.5.62-s390/include/asm-s390x/qdio.h
--- linux-2.5.62/include/asm-s390x/qdio.h	Mon Feb 17 23:56:14 2003
+++ linux-2.5.62-s390/include/asm-s390x/qdio.h	Mon Feb 24 18:18:38 2003
@@ -50,11 +50,11 @@
 } __attribute__ ((packed,aligned(256)));
 
 
-/* params are: irq, status, qdio_error, siga_error,
+/* params are: ccw_device, status, qdio_error, siga_error,
    queue_number, first element processed, number of elements processed,
    int_parm */
-typedef void qdio_handler_t(int,unsigned int,unsigned int,unsigned int,
-			    unsigned int,int,int,unsigned long);
+typedef void qdio_handler_t(struct ccw_device *,unsigned int,unsigned int,
+			    unsigned int,unsigned int,int,int,unsigned long);
 
 
 #define QDIO_STATUS_INBOUND_INT 0x01
@@ -100,6 +100,8 @@
 	void **output_sbal_addr_array; /* addr of n*128 void ptrs */
 };
 extern int qdio_initialize(struct qdio_initialize *init_data);
+extern int qdio_allocate(struct qdio_initialize *init_data);
+extern int qdio_establish(struct ccw_device *);
 
 extern int qdio_activate(struct ccw_device *,int flags);
 
@@ -127,6 +129,8 @@
 			    unsigned int queue_number);
 
 extern int qdio_cleanup(struct ccw_device*, int how);
+extern int qdio_shutdown(struct ccw_device*, int how);
+extern int qdio_free(struct ccw_device*);
 
 unsigned char qdio_get_slsb_state(struct ccw_device*, unsigned int flag,
 				  unsigned int queue_number,

