Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbUCPNv7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 08:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbUCPNv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 08:51:58 -0500
Received: from mtagate5.de.ibm.com ([195.212.29.154]:45011 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S261696AbUCPNt7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 08:49:59 -0500
Date: Tue, 16 Mar 2004 14:49:40 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (2/10): common i/o layer.
Message-ID: <20040316134940.GC2785@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Common i/o layer fixes:
 - Improve blacklist argument parsing.
 - Fix device recognition for devices where SenseID fails.
 - Don't try to set a device online that has no driver.
 - Chain a release ccw to the unconditional reserve ccw for forced online.
 - Fix irb accumulation for pure status pending with eswf set.
 - Fix rc handling in qdio_shutdown.
 - Improve retry behavious for busy conditions on qdio.
 - Fix activity check in ccw_device_start/read_dev_chars and read_conf_data.

diffstat:
 Documentation/s390/driver-model.txt |    2 
 drivers/s390/cio/blacklist.c        |   64 +++++++++++++-------
 drivers/s390/cio/css.h              |    1 
 drivers/s390/cio/device.c           |   55 ++++++++++++-----
 drivers/s390/cio/device_fsm.c       |    3 
 drivers/s390/cio/device_ops.c       |   40 +++++++++---
 drivers/s390/cio/device_status.c    |    2 
 drivers/s390/cio/qdio.c             |  112 ++++++++++++++++++++++++++++++------
 drivers/s390/cio/qdio.h             |    7 +-
 include/asm-s390/cio.h              |    1 
 10 files changed, 216 insertions(+), 71 deletions(-)

diff -urN linux-2.6/Documentation/s390/driver-model.txt linux-2.6-s390/Documentation/s390/driver-model.txt
--- linux-2.6/Documentation/s390/driver-model.txt	Thu Mar 11 03:55:20 2004
+++ linux-2.6-s390/Documentation/s390/driver-model.txt	Tue Mar 16 14:03:06 2004
@@ -250,7 +250,7 @@
 -----------
 
 The netiucv driver creates an attribute 'connection' under
-bus/iucv/drivers/NETIUCV. Piping to this attibute creates a new netiucv
+bus/iucv/drivers/netiucv. Piping to this attibute creates a new netiucv
 connection to the specified host.
 
 Netiucv connections show up under devices/iucv/ as "netiucv<ifnum>". The interface
diff -urN linux-2.6/drivers/s390/cio/blacklist.c linux-2.6-s390/drivers/s390/cio/blacklist.c
--- linux-2.6/drivers/s390/cio/blacklist.c	Thu Mar 11 03:55:24 2004
+++ linux-2.6-s390/drivers/s390/cio/blacklist.c	Tue Mar 16 14:03:06 2004
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/blacklist.c
  *   S/390 common I/O routines -- blacklisting of specific devices
- *   $Revision: 1.29 $
+ *   $Revision: 1.31 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -72,7 +72,10 @@
 blacklist_busid(char **str, int *id0, int *id1, int *devno)
 {
 	int val, old_style;
- 
+	char *sav;
+
+	sav = *str;
+
 	/* check for leading '0x' */
 	old_style = 0;
 	if ((*str)[0] == '0' && (*str)[1] == 'x') {
@@ -80,44 +83,54 @@
 		old_style = 1;
 	}
 	if (!isxdigit((*str)[0]))	/* We require at least one hex digit */
-		return -EINVAL;
+		goto confused;
 	val = simple_strtoul(*str, str, 16);
 	if (old_style || (*str)[0] != '.') {
 		*id0 = *id1 = 0;
 		if (val < 0 || val > 0xffff)
-			return -EINVAL;
+			goto confused;
 		*devno = val;
+		if ((*str)[0] != ',' && (*str)[0] != '-' &&
+		    (*str)[0] != '\n' && (*str)[0] != '\0')
+			goto confused;
 		return 0;
 	}
 	/* New style x.y.z busid */
 	if (val < 0 || val > 0xff)
-		return -EINVAL;
+		goto confused;
 	*id0 = val;
 	(*str)++;
 	if (!isxdigit((*str)[0]))	/* We require at least one hex digit */
-		return -EINVAL;
+		goto confused;
 	val = simple_strtoul(*str, str, 16);
 	if (val < 0 || val > 0xff || (*str)++[0] != '.')
-		return -EINVAL;
+		goto confused;
 	*id1 = val;
 	if (!isxdigit((*str)[0]))	/* We require at least one hex digit */
-		return -EINVAL;
+		goto confused;
 	val = simple_strtoul(*str, str, 16);
 	if (val < 0 || val > 0xffff)
-		return -EINVAL;
+		goto confused;
 	*devno = val;
+	if ((*str)[0] != ',' && (*str)[0] != '-' &&
+	    (*str)[0] != '\n' && (*str)[0] != '\0')
+		goto confused;
 	return 0;
+confused:
+	strsep(str, ",\n");
+	printk(KERN_WARNING "Invalid cio_ignore parameter '%s'\n", sav);
+	return 1;
 }
 
 static inline int
 blacklist_parse_parameters (char *str, range_action action)
 {
 	unsigned int from, to, from_id0, to_id0, from_id1, to_id1;
-	char *sav;
 
-	sav = str;
 	while (*str != 0 && *str != '\n') {
 		range_action ra = action;
+		while(*str == ',')
+			str++;
 		if (*str == '!') {
 			ra = !action;
 			++str;
@@ -138,32 +151,37 @@
 			rc = blacklist_busid(&str, &from_id0,
 					     &from_id1, &from);
 			if (rc)
-				goto out_err;
+				continue;
 			to = from;
 			to_id0 = from_id0;
 			to_id1 = from_id1;
 			if (*str == '-') {
 				str++;
-				rc = blacklist_busid(&str, &to_id0, &to_id1,
-						     &to);
+				rc = blacklist_busid(&str, &to_id0,
+						     &to_id1, &to);
 				if (rc)
-					goto out_err;
+					continue;
+			}
+			if (*str == '-') {
+				printk(KERN_WARNING "invalid cio_ignore "
+					"parameter '%s'\n",
+					strsep(&str, ",\n"));
+				continue;
+			}
+			if ((from_id0 != to_id0) || (from_id1 != to_id1)) {
+				printk(KERN_WARNING "invalid cio_ignore range "
+					"%x.%x.%04x-%x.%x.%04x\n",
+					from_id0, from_id1, from,
+					to_id0, to_id1, to);
+				continue;
 			}
-			if ((from_id0 != to_id0) || (from_id1 != to_id1))
-				goto out_err;
 		}
 		/* FIXME: ignoring id0 and id1 here. */
 		pr_debug("blacklist_setup: adding range "
 			 "from 0.0.%04x to 0.0.%04x\n", from, to);
 		blacklist_range (ra, from, to);
-
-		if (*str == ',')
-			str++;
 	}
 	return 1;
-out_err:
-	printk(KERN_WARNING "blacklist_setup: error parsing \"%s\"\n", sav);
-	return 0;
 }
 
 /* Parsing the commandline for blacklist parameters, e.g. to blacklist
diff -urN linux-2.6/drivers/s390/cio/css.h linux-2.6-s390/drivers/s390/cio/css.h
--- linux-2.6/drivers/s390/cio/css.h	Thu Mar 11 03:55:57 2004
+++ linux-2.6-s390/drivers/s390/cio/css.h	Tue Mar 16 14:03:06 2004
@@ -82,6 +82,7 @@
 		unsigned int dosense:1;	    /* delayed SENSE required */
 		unsigned int doverify:1;    /* delayed path verification */
 		unsigned int donotify:1;    /* call notify function */
+		unsigned int recog_done:1;  /* dev. recog. complete */
 	} __attribute__((packed)) flags;
 	unsigned long intparm;	/* user interruption parameter */
 	struct qdio_irq *qdio_data;
diff -urN linux-2.6/drivers/s390/cio/device.c linux-2.6-s390/drivers/s390/cio/device.c
--- linux-2.6/drivers/s390/cio/device.c	Thu Mar 11 03:55:37 2004
+++ linux-2.6-s390/drivers/s390/cio/device.c	Tue Mar 16 14:03:06 2004
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/device.c
  *  bus driver for ccw devices
- *   $Revision: 1.107 $
+ *   $Revision: 1.110 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
@@ -263,10 +263,10 @@
 
 	if (!cdev)
 		return -ENODEV;
-	if (!cdev->online)
+	if (!cdev->online || !cdev->drv)
 		return -EINVAL;
 
-	if (cdev->drv && cdev->drv->set_offline) {
+	if (cdev->drv->set_offline) {
 		ret = cdev->drv->set_offline(cdev);
 		if (ret != 0)
 			return ret;
@@ -292,7 +292,7 @@
 
 	if (!cdev)
 		return -ENODEV;
-	if (cdev->online)
+	if (cdev->online || !cdev->drv)
 		return -EINVAL;
 
 	spin_lock_irq(cdev->ccwlock);
@@ -307,8 +307,7 @@
 	}
 	if (cdev->private->state != DEV_STATE_ONLINE)
 		return -ENODEV;
-	if (!cdev->drv || !cdev->drv->set_online ||
-	    cdev->drv->set_online(cdev) == 0) {
+	if (!cdev->drv->set_online || cdev->drv->set_online(cdev) == 0) {
 		cdev->online = 1;
 		return 0;
 	}
@@ -327,7 +326,7 @@
 online_store (struct device *dev, const char *buf, size_t count)
 {
 	struct ccw_device *cdev = to_ccwdev(dev);
-	int i, force;
+	int i, force, ret;
 	char *tmp;
 
 	if (atomic_compare_and_swap(0, 1, &cdev->private->onoff))
@@ -347,29 +346,46 @@
 	if (i == 1) {
 		/* Do device recognition, if needed. */
 		if (cdev->id.cu_type == 0) {
-			ccw_device_recognition(cdev);
+			ret = ccw_device_recognition(cdev);
+			if (ret) {
+				printk(KERN_WARNING"Couldn't start recognition "
+				       "for device %s (ret=%d)\n",
+				       cdev->dev.bus_id, ret);
+				goto out;
+			}
 			wait_event(cdev->private->wait_q,
-				   dev_fsm_final_state(cdev));
+				   cdev->private->flags.recog_done);
 		}
-		ccw_device_set_online(cdev);
+		if (cdev->drv && cdev->drv->set_online) 
+			ccw_device_set_online(cdev);
 	} else if (i == 0) {
 		if (cdev->private->state == DEV_STATE_DISCONNECTED)
 			ccw_device_remove_disconnected(cdev);
-		else
+		else if (cdev->drv && cdev->drv->set_offline)
 			ccw_device_set_offline(cdev);
 	}
 	if (force && cdev->private->state == DEV_STATE_BOXED) {
-		int ret;
 		ret = ccw_device_stlck(cdev);
-		if (ret)
+		if (ret) {
+			printk(KERN_WARNING"ccw_device_stlck for device %s "
+			       "returned %d!\n", cdev->dev.bus_id, ret);
 			goto out;
+		}
 		/* Do device recognition, if needed. */
 		if (cdev->id.cu_type == 0) {
-			ccw_device_recognition(cdev);
+			cdev->private->state = DEV_STATE_NOT_OPER;
+			ret = ccw_device_recognition(cdev);
+			if (ret) {
+				printk(KERN_WARNING"Couldn't start recognition "
+				       "for device %s (ret=%d)\n",
+				       cdev->dev.bus_id, ret);
+				goto out;
+			}
 			wait_event(cdev->private->wait_q,
-				   dev_fsm_final_state(cdev));
+				   cdev->private->flags.recog_done);
 		}
-		ccw_device_set_online(cdev);
+		if (cdev->drv && cdev->drv->set_online) 
+			ccw_device_set_online(cdev);
 	}
 	out:
 	if (cdev->drv)
@@ -530,7 +546,9 @@
 		       __func__, sch->dev.bus_id);
 	put_device(&cdev->dev);
 out:
+	cdev->private->flags.recog_done = 1;
 	put_device(&sch->dev);
+	wake_up(&cdev->private->wait_q);
 }
 
 static void
@@ -555,10 +573,13 @@
 {
 	struct subchannel *sch;
 
-	if (css_init_done == 0)
+	if (css_init_done == 0) {
+		cdev->private->flags.recog_done = 1;
 		return;
+	}
 	switch (cdev->private->state) {
 	case DEV_STATE_NOT_OPER:
+		cdev->private->flags.recog_done = 1;
 		/* Remove device found not operational. */
 		if (!get_device(&cdev->dev))
 			break;
diff -urN linux-2.6/drivers/s390/cio/device_fsm.c linux-2.6-s390/drivers/s390/cio/device_fsm.c
--- linux-2.6/drivers/s390/cio/device_fsm.c	Thu Mar 11 03:55:27 2004
+++ linux-2.6-s390/drivers/s390/cio/device_fsm.c	Tue Mar 16 14:03:06 2004
@@ -148,6 +148,7 @@
 	struct subchannel *sch;
 
 	sch = to_subchannel(cdev->dev.parent);
+	cdev->private->flags.recog_done = 1;
 	/*
 	 * Check if cu type and device type still match. If
 	 * not, it is certainly another device and we have to
@@ -217,6 +218,7 @@
 		__recover_lost_chpids(sch, old_lpm);
 	if (cdev->private->state == DEV_STATE_DISCONNECTED_SENSE_ID) {
 		if (state == DEV_STATE_NOT_OPER) {
+			cdev->private->flags.recog_done = 1;
 			cdev->private->state = DEV_STATE_DISCONNECTED;
 			return;
 		}
@@ -393,6 +395,7 @@
 	 * timeout (or if sense pgid during path verification detects the device
 	 * is locked, as may happen on newer devices).
 	 */
+	cdev->private->flags.recog_done = 0;
 	cdev->private->state = DEV_STATE_SENSE_ID;
 	ccw_device_sense_id_start(cdev);
 	return 0;
diff -urN linux-2.6/drivers/s390/cio/device_ops.c linux-2.6-s390/drivers/s390/cio/device_ops.c
--- linux-2.6/drivers/s390/cio/device_ops.c	Thu Mar 11 03:55:37 2004
+++ linux-2.6-s390/drivers/s390/cio/device_ops.c	Tue Mar 16 14:03:06 2004
@@ -79,7 +79,8 @@
 	if (cdev->private->state == DEV_STATE_NOT_OPER)
 		return -ENODEV;
 	if (cdev->private->state != DEV_STATE_ONLINE ||
-	    sch->schib.scsw.actl != 0 ||
+	    ((sch->schib.scsw.stctl & SCSW_STCTL_PRIM_STATUS) &&
+	     !(sch->schib.scsw.stctl & SCSW_STCTL_SEC_STATUS)) ||
 	    cdev->private->flags.doverify)
 		return -EBUSY;
 	ret = cio_set_options (sch, flags);
@@ -347,7 +348,9 @@
 	cdev->handler = ccw_device_wake_up;
 	if (cdev->private->state != DEV_STATE_ONLINE)
 		ret = -ENODEV;
-	else if (sch->schib.scsw.actl != 0 || cdev->private->flags.doverify)
+	else if (((sch->schib.scsw.stctl & SCSW_STCTL_PRIM_STATUS) &&
+		  !(sch->schib.scsw.stctl & SCSW_STCTL_SEC_STATUS)) || 
+		 cdev->private->flags.doverify)
 		ret = -EBUSY;
 	else
 		/* 0x00D9C4C3 == ebcdic "RDC" */
@@ -414,7 +417,9 @@
 	cdev->handler = ccw_device_wake_up;
 	if (cdev->private->state != DEV_STATE_ONLINE)
 		ret = -ENODEV;
-	else if (sch->schib.scsw.actl != 0 || cdev->private->flags.doverify)
+	else if (((sch->schib.scsw.stctl & SCSW_STCTL_PRIM_STATUS) &&
+		  !(sch->schib.scsw.stctl & SCSW_STCTL_SEC_STATUS)) || 
+		 cdev->private->flags.doverify)
 		ret = -EBUSY;
 	else
 		/* 0x00D9C3C4 == ebcdic "RCD" */
@@ -441,12 +446,12 @@
 }
 
 /*
- * Try to issue an unconditional reserve on a boxed device.
+ * Try to break the lock on a boxed device.
  */
 int
 ccw_device_stlck(struct ccw_device *cdev)
 {
-	char buf[32];
+	void *buf, *buf2;
 	unsigned long flags;
 	struct subchannel *sch;
 	int ret;
@@ -462,16 +467,30 @@
 	CIO_TRACE_EVENT(2, "stl lock");
 	CIO_TRACE_EVENT(2, cdev->dev.bus_id);
 
+	buf = kmalloc(32*sizeof(char), GFP_DMA|GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	buf2 = kmalloc(32*sizeof(char), GFP_DMA|GFP_KERNEL);
+	if (!buf2) {
+		kfree(buf);
+		return -ENOMEM;
+	}
 	spin_lock_irqsave(&sch->lock, flags);
 	ret = cio_enable_subchannel(sch, 3);
 	if (ret)
 		goto out_unlock;
-	/* Setup ccw. This cmd code seems not to be in use elsewhere. */
+	/* 
+	 * Setup ccw. We chain an unconditional reserve and a release so we
+	 * only break the lock.
+	 */
 	cdev->private->iccws[0].cmd_code = CCW_CMD_STLCK;
 	cdev->private->iccws[0].cda = (__u32) __pa(buf);
 	cdev->private->iccws[0].count = 32;
-	cdev->private->iccws[0].flags = CCW_FLAG_SLI;
-
+	cdev->private->iccws[0].flags = CCW_FLAG_CC;
+	cdev->private->iccws[1].cmd_code = CCW_CMD_RELEASE;
+	cdev->private->iccws[1].cda = (__u32) __pa(buf2);
+	cdev->private->iccws[1].count = 32;
+	cdev->private->iccws[1].flags = 0;
 	ret = cio_start(sch, cdev->private->iccws, 0);
 	if (ret) {
 		cio_disable_subchannel(sch); //FIXME: return code?
@@ -486,10 +505,13 @@
 	     (DEV_STAT_CHN_END|DEV_STAT_DEV_END)) ||
 	    (cdev->private->irb.scsw.cstat != 0))
 		ret = -EIO;
-
 	/* Clear irb. */
 	memset(&cdev->private->irb, 0, sizeof(struct irb));
 out_unlock:
+	if (buf)
+		kfree(buf);
+	if (buf2)
+		kfree(buf2);
 	spin_unlock_irqrestore(&sch->lock, flags);
 	return ret;
 }
diff -urN linux-2.6/drivers/s390/cio/device_status.c linux-2.6-s390/drivers/s390/cio/device_status.c
--- linux-2.6/drivers/s390/cio/device_status.c	Thu Mar 11 03:55:27 2004
+++ linux-2.6-s390/drivers/s390/cio/device_status.c	Tue Mar 16 14:03:06 2004
@@ -99,7 +99,7 @@
 static inline int
 ccw_device_accumulate_esw_valid(struct irb *irb)
 {
-	if (irb->scsw.eswf && irb->scsw.stctl == SCSW_STCTL_STATUS_PEND)
+	if (!irb->scsw.eswf && irb->scsw.stctl == SCSW_STCTL_STATUS_PEND)
 		return 0;
 	if (irb->scsw.stctl == 
 	    		(SCSW_STCTL_INTER_STATUS|SCSW_STCTL_STATUS_PEND) &&
diff -urN linux-2.6/drivers/s390/cio/qdio.c linux-2.6-s390/drivers/s390/cio/qdio.c
--- linux-2.6/drivers/s390/cio/qdio.c	Thu Mar 11 03:55:34 2004
+++ linux-2.6-s390/drivers/s390/cio/qdio.c	Tue Mar 16 14:03:06 2004
@@ -56,7 +56,7 @@
 #include "ioasm.h"
 #include "chsc.h"
 
-#define VERSION_QDIO_C "$Revision: 1.74 $"
+#define VERSION_QDIO_C "$Revision: 1.78 $"
 
 /****************** MODULE PARAMETER VARIABLES ********************/
 MODULE_AUTHOR("Utz Bacher <utz.bacher@de.ibm.com>");
@@ -545,6 +545,7 @@
 qdio_kick_outbound_q(struct qdio_q *q)
 {
 	int result;
+	char dbf_text[15];
 
 	QDIO_DBF_TEXT4(0,trace,"kickoutq");
 	QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
@@ -552,15 +553,75 @@
 	if (!q->siga_out)
 		return;
 
-	result=qdio_siga_output(q);
+	/* here's the story with cc=2 and busy bit set (thanks, Rick):
+	 * VM's CP could present us cc=2 and busy bit set on SIGA-write
+	 * during reconfiguration of their Guest LAN (only in HIPERS mode,
+	 * QDIO mode is asynchronous -- cc=2 and busy bit there will take
+	 * the queues down immediately; and not being under VM we have a
+	 * problem on cc=2 and busy bit set right away).
+	 *
+	 * Therefore qdio_siga_output will try for a short time constantly,
+	 * if such a condition occurs. If it doesn't change, it will
+	 * increase the busy_siga_counter and save the timestamp, and
+	 * schedule the queue for later processing (via mark_q, using the
+	 * queue tasklet). __qdio_outbound_processing will check out the
+	 * counter. If non-zero, it will call qdio_kick_outbound_q as often
+	 * as the value of the counter. This will attempt further SIGA
+	 * instructions. For each successful SIGA, the counter is
+	 * decreased, for failing SIGAs the counter remains the same, after
+	 * all.
+	 * After some time of no movement, qdio_kick_outbound_q will
+	 * finally fail and reflect corresponding error codes to call
+	 * the upper layer module and have it take the queues down.
+	 *
+	 * Note that this is a change from the original HiperSockets design
+	 * (saying cc=2 and busy bit means take the queues down), but in
+	 * these days Guest LAN didn't exist... excessive cc=2 with busy bit
+	 * conditions will still take the queues down, but the threshold is
+	 * higher due to the Guest LAN environment.
+	 */
 
-	if (!result)
-		return;
 
-	if (q->siga_error)
-		q->error_status_flags|=QDIO_STATUS_MORE_THAN_ONE_SIGA_ERROR;
-	q->error_status_flags |= QDIO_STATUS_LOOK_FOR_ERROR;
-	q->siga_error=result;
+	result=qdio_siga_output(q);
+
+		switch (result) {
+		case 0:
+		/* went smooth this time, reset timestamp */
+			QDIO_DBF_TEXT3(0,trace,"cc2reslv");
+			sprintf(dbf_text,"%4x%2x%2x",q->irq,q->q_no,
+				atomic_read(&q->busy_siga_counter));
+			QDIO_DBF_TEXT3(0,trace,dbf_text);
+			q->timing.busy_start=0;
+			break;
+		case (2|QDIO_SIGA_ERROR_B_BIT_SET):
+			/* cc=2 and busy bit: */
+		atomic_inc(&q->busy_siga_counter);
+
+			/* if the last siga was successful, save
+			 * timestamp here */
+			if (!q->timing.busy_start)
+				q->timing.busy_start=NOW;
+
+			/* if we're in time, don't touch error_status_flags
+			 * and siga_error */
+			if (NOW-q->timing.busy_start<QDIO_BUSY_BIT_GIVE_UP) {
+				qdio_mark_q(q);
+				break;
+			}
+			QDIO_DBF_TEXT2(0,trace,"cc2REPRT");
+			sprintf(dbf_text,"%4x%2x%2x",q->irq,q->q_no,
+				atomic_read(&q->busy_siga_counter));
+			QDIO_DBF_TEXT3(0,trace,dbf_text);
+			/* else fallthrough and report error */
+		default:
+			/* for plain cc=1, 2 or 3: */
+			if (q->siga_error)
+				q->error_status_flags|=
+					QDIO_STATUS_MORE_THAN_ONE_SIGA_ERROR;
+			q->error_status_flags|=
+				QDIO_STATUS_LOOK_FOR_ERROR;
+			q->siga_error=result;
+		}
 }
 
 inline static void
@@ -599,6 +660,8 @@
 static inline void
 __qdio_outbound_processing(struct qdio_q *q)
 {
+	int siga_attempts;
+
 	QDIO_DBF_TEXT4(0,trace,"qoutproc");
 	QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
 
@@ -619,6 +682,14 @@
 	perf_stats.tl_runs++;
 #endif /* QDIO_PERFORMANCE_STATS */
 
+	/* see comment in qdio_kick_outbound_q */
+	siga_attempts=atomic_read(&q->busy_siga_counter);
+	while (siga_attempts) {
+		atomic_dec(&q->busy_siga_counter);
+		qdio_kick_outbound_q(q);
+		siga_attempts--;
+	}
+
 	if (qdio_has_outbound_q_moved(q))
 		qdio_kick_outbound_handler(q);
 
@@ -1368,6 +1439,10 @@
 			((irq_ptr->is_thinint_irq)?&tiqdio_inbound_processing:
 			 &qdio_inbound_processing);
 
+		/* actually this is not used for inbound queues. yet. */
+		atomic_set(&q->busy_siga_counter,0);
+		q->timing.busy_start=0;
+
 /*		for (j=0;j<QDIO_STATS_NUMBER;j++)
 			q->timing.last_transfer_times[j]=(qdio_get_micros()/
 							  QDIO_STATS_NUMBER)*j;
@@ -1432,6 +1507,9 @@
 		q->tasklet.func=(void(*)(unsigned long))
 			&qdio_outbound_processing;
 
+		atomic_set(&q->busy_siga_counter,0);
+		q->timing.busy_start=0;
+
 		/* fill in slib */
 		if (i>0) irq_ptr->output_qs[i-1]->slib->nsliba=
 				 (unsigned long)(q->slib);
@@ -2134,7 +2212,7 @@
 	QDIO_DBF_TEXT0(0,setup,dbf_text);
 
 	rc = qdio_shutdown(cdev, how);
-	if (rc == 0)
+	if ((rc == 0) || (rc == -EINPROGRESS))
 		rc = qdio_free(cdev);
 	return rc;
 }
@@ -2145,6 +2223,7 @@
 	struct qdio_irq *irq_ptr;
 	int i;
 	int result = 0;
+	int rc;
 	unsigned long flags;
 	int timeout;
 	char dbf_text[15];
@@ -2191,27 +2270,23 @@
 			result=-EINPROGRESS;
 	}
 
-	if (result)
-		goto out;
-
 	/* cleanup subchannel */
 	spin_lock_irqsave(get_ccwdev_lock(cdev),flags);
 	if (how&QDIO_FLAG_CLEANUP_USING_CLEAR) {
-		result = ccw_device_clear(cdev, QDIO_DOING_CLEANUP);
+		rc = ccw_device_clear(cdev, QDIO_DOING_CLEANUP);
 		timeout=QDIO_CLEANUP_CLEAR_TIMEOUT;
 	} else if (how&QDIO_FLAG_CLEANUP_USING_HALT) {
-		result = ccw_device_halt(cdev, QDIO_DOING_CLEANUP);
+		rc = ccw_device_halt(cdev, QDIO_DOING_CLEANUP);
 		timeout=QDIO_CLEANUP_HALT_TIMEOUT;
 	} else { /* default behaviour */
-		result = ccw_device_halt(cdev, QDIO_DOING_CLEANUP);
+		rc = ccw_device_halt(cdev, QDIO_DOING_CLEANUP);
 		timeout=QDIO_CLEANUP_HALT_TIMEOUT;
 	}
-	if (result == -ENODEV) {
+	if (rc == -ENODEV) {
 		/* No need to wait for device no longer present. */
 		qdio_set_state(irq_ptr, QDIO_IRQ_STATE_INACTIVE);
-		result = 0; /* No error. */
 		spin_unlock_irqrestore(get_ccwdev_lock(cdev), flags);
-	} else if (result == 0) {
+	} else if (rc == 0) {
 		qdio_set_state(irq_ptr, QDIO_IRQ_STATE_CLEANUP);
 		ccw_device_set_timeout(cdev, timeout);
 		spin_unlock_irqrestore(get_ccwdev_lock(cdev),flags);
@@ -2223,6 +2298,7 @@
 		QDIO_PRINT_INFO("ccw_device_{halt,clear} returned %d for "
 				"device %s\n", result, cdev->dev.bus_id);
 		spin_unlock_irqrestore(get_ccwdev_lock(cdev), flags);
+		result = rc;
 		goto out;
 	}
 	if (irq_ptr->is_thinint_irq) {
diff -urN linux-2.6/drivers/s390/cio/qdio.h linux-2.6-s390/drivers/s390/cio/qdio.h
--- linux-2.6/drivers/s390/cio/qdio.h	Thu Mar 11 03:55:23 2004
+++ linux-2.6-s390/drivers/s390/cio/qdio.h	Tue Mar 16 14:03:06 2004
@@ -1,7 +1,7 @@
 #ifndef _CIO_QDIO_H
 #define _CIO_QDIO_H
 
-#define VERSION_CIO_QDIO_H "$Revision: 1.22 $"
+#define VERSION_CIO_QDIO_H "$Revision: 1.23 $"
 
 //#define QDIO_DBF_LIKE_HELL
 
@@ -33,7 +33,8 @@
 
 #define TIQDIO_THININT_ISC 3
 #define TIQDIO_DELAY_TARGET 0
-#define QDIO_BUSY_BIT_PATIENCE 2000 /* in microsecs */
+#define QDIO_BUSY_BIT_PATIENCE 100 /* in microsecs */
+#define QDIO_BUSY_BIT_GIVE_UP 10000000 /* 10 seconds */
 #define IQDIO_GLOBAL_LAPS 2 /* GLOBAL_LAPS are not used as we */
 #define IQDIO_GLOBAL_LAPS_INT 1 /* don't global summary */
 #define IQDIO_LOCAL_LAPS 4
@@ -599,7 +600,9 @@
 		int last_transfer_index; */
 
 		__u64 last_transfer_time;
+		__u64 busy_start;
 	} timing;
+	atomic_t busy_siga_counter;
         unsigned int queue_type;
 
 	/* leave this member at the end. won't be cleared in qdio_fill_qs */
diff -urN linux-2.6/include/asm-s390/cio.h linux-2.6-s390/include/asm-s390/cio.h
--- linux-2.6/include/asm-s390/cio.h	Thu Mar 11 03:55:44 2004
+++ linux-2.6-s390/include/asm-s390/cio.h	Tue Mar 16 14:03:06 2004
@@ -132,6 +132,7 @@
 #define CCW_CMD_SENSE_PGID	0x34
 #define CCW_CMD_SUSPEND_RECONN	0x5B
 #define CCW_CMD_RDC		0x64
+#define CCW_CMD_RELEASE		0x94
 #define CCW_CMD_SET_PGID	0xAF
 #define CCW_CMD_SENSE_ID	0xE4
 #define CCW_CMD_DCTL		0xF3
