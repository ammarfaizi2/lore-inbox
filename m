Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261710AbTCZPLF>; Wed, 26 Mar 2003 10:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261728AbTCZPLE>; Wed, 26 Mar 2003 10:11:04 -0500
Received: from d12lmsgate.de.ibm.com ([194.196.100.234]:62902 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S261710AbTCZPHs> convert rfc822-to-8bit; Wed, 26 Mar 2003 10:07:48 -0500
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 update (4/9): common i/o layer update.
Date: Wed, 26 Mar 2003 16:10:16 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200303261610.16448.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Fix for path no operational condition in cio_start.
* Fix handling of user interruption parameter.
* Add code to wait for devices in init_ccw_bus_type.
* Move qdio states out of main cio state machine.

diffstat:
 cio/airq.c          |    6 
 cio/airq.h          |    4 
 cio/chsc.c          |  106 +++++++++++-----
 cio/cio.c           |   30 +---
 cio/cio.h           |    9 -
 cio/css.c           |    8 -
 cio/css.h           |    1 
 cio/device.c        |   70 ++++++++++-
 cio/device.h        |    9 -
 cio/device_fsm.c    |  147 ++++++-----------------
 cio/device_id.c     |   10 -
 cio/device_ops.c    |   40 +++---
 cio/device_pgid.c   |   27 +++-
 cio/device_status.c |    2 
 cio/qdio.c          |  328 ++++++++++++++++++++++++++--------------------------
 cio/qdio.h          |   38 ++----
 s390mach.c          |   14 +-
 17 files changed, 450 insertions(+), 399 deletions(-)

diff -urN linux-2.5.66/drivers/s390/cio/airq.c linux-2.5.66-s390/drivers/s390/cio/airq.c
--- linux-2.5.66/drivers/s390/cio/airq.c	Mon Mar 24 23:01:15 2003
+++ linux-2.5.66-s390/drivers/s390/cio/airq.c	Wed Mar 26 15:45:16 2003
@@ -2,7 +2,7 @@
  *  drivers/s390/cio/airq.c
  *   S/390 common I/O routines -- support for adapter interruptions
  *
- *   $Revision: 1.10 $
+ *   $Revision: 1.11 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -87,14 +87,14 @@
 }
 
 void
-do_adapter_IO (__u32 intparm)
+do_adapter_IO (void)
 {
 	CIO_TRACE_EVENT (4, "doaio");
 
 	spin_lock (&adapter_lock);
 
 	if (adapter_handler)
-		(*adapter_handler) (intparm);
+		(*adapter_handler) ();
 
 	spin_unlock (&adapter_lock);
 
diff -urN linux-2.5.66/drivers/s390/cio/airq.h linux-2.5.66-s390/drivers/s390/cio/airq.h
--- linux-2.5.66/drivers/s390/cio/airq.h	Mon Mar 24 23:01:16 2003
+++ linux-2.5.66-s390/drivers/s390/cio/airq.h	Wed Mar 26 15:45:16 2003
@@ -1,10 +1,10 @@
 #ifndef S390_AINTERRUPT_H
 #define S390_AINTERRUPT_H
 
-typedef	int (*adapter_int_handler_t)(__u32 intparm);
+typedef	int (*adapter_int_handler_t)(void);
 
 extern int s390_register_adapter_interrupt(adapter_int_handler_t handler);
 extern int s390_unregister_adapter_interrupt(adapter_int_handler_t handler);
-extern void do_adapter_IO (__u32 intparm);
+extern void do_adapter_IO (void);
 
 #endif
diff -urN linux-2.5.66/drivers/s390/cio/chsc.c linux-2.5.66-s390/drivers/s390/cio/chsc.c
--- linux-2.5.66/drivers/s390/cio/chsc.c	Mon Mar 24 23:00:45 2003
+++ linux-2.5.66-s390/drivers/s390/cio/chsc.c	Wed Mar 26 15:45:16 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/chsc.c
  *   S/390 common I/O routines -- channel subsystem call
- *   $Revision: 1.57 $
+ *   $Revision: 1.63 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -82,20 +82,19 @@
 	 * allocation or prove that this function does not have to be
 	 * reentrant! */
 	static struct ssd_area chsc_area_ssd 
-		__attribute__ ((aligned(PAGE_SIZE)));
-
-	typeof (chsc_area_ssd.response_block)
-		*ssd_res = &chsc_area_ssd.response_block;
-
-	chsc_area_ssd = (struct ssd_area) {
+		__attribute__ ((aligned(PAGE_SIZE))) = {
 		.request_block = {
 			.command_code1 = 0x0010,
 			.command_code2 = 0x0004,
-			.f_sch = irq,
-			.l_sch = irq,
 		}
 	};
 
+	typeof (chsc_area_ssd.response_block)
+		*ssd_res = &chsc_area_ssd.response_block;
+	
+	chsc_area_ssd.request_block.f_sch = irq;
+	chsc_area_ssd.request_block.l_sch = irq,
+
 	ccode = chsc(&chsc_area_ssd);
 	if (ccode > 0) {
 		pr_debug("chsc returned with ccode = %d\n", ccode);
@@ -216,6 +215,7 @@
 s390_subchannel_remove_chpid(struct subchannel *sch, __u8 chpid)
 {
 	int j;
+	int mask;
 
 	for (j = 0; j < 8; j++)
 		if (sch->schib.pmcw.chpid[j] == chpid)
@@ -223,16 +223,68 @@
 	if (j >= 8)
 		return;
 
+	mask = 0x80 >> j;
 	spin_lock(&sch->lock);
 
 	chsc_validate_chpids(sch);
 
-	/* just to be sure... */
-	sch->lpm &= ~(0x80>>j);
+	stsch(sch->irq, &sch->schib);
+	if (sch->vpm == mask) {
+		dev_fsm_event(sch->dev.driver_data, DEV_EVENT_NOTOPER);
+		goto out_unlock;
+	}
+	if ((sch->schib.scsw.actl & (SCSW_ACTL_CLEAR_PEND |
+				     SCSW_ACTL_HALT_PEND |
+				     SCSW_ACTL_START_PEND |
+				     SCSW_ACTL_RESUME_PEND)) &&
+	    (sch->schib.pmcw.lpum == mask)) {
+		int cc = cio_cancel(sch);
+		
+		if (cc == -ENODEV) {
+			dev_fsm_event(sch->dev.driver_data, DEV_EVENT_NOTOPER);
+			goto out_unlock;
+		}
+
+		if (cc == -EINVAL) {
+			struct ccw_device *cdev;
+
+			cc = cio_clear(sch);
+			if (cc == -ENODEV) {
+				dev_fsm_event(sch->dev.driver_data,
+					      DEV_EVENT_NOTOPER);
+				goto out_unlock;
+			}
+			/* Call handler. */
+			cdev = sch->dev.driver_data;
+			cdev->private->state = DEV_STATE_CLEAR_VERIFY;
+			if (cdev->handler)
+				cdev->handler(cdev, cdev->private->intparm,
+					      ERR_PTR(-EIO));
+			goto out_unlock;
+		}
+	} else if ((sch->schib.scsw.actl & SCSW_ACTL_DEVACT) &&
+		   (sch->schib.scsw.actl & SCSW_ACTL_SCHACT) &&
+		   (sch->schib.pmcw.lpum == mask)) {
+		struct ccw_device *cdev;
+		int cc;
+
+		cc = cio_clear(sch);
+		if (cc == -ENODEV) {
+			dev_fsm_event(sch->dev.driver_data, DEV_EVENT_NOTOPER);
+			goto out_unlock;
+		}
+		/* Call handler. */
+		cdev = sch->dev.driver_data;
+		cdev->private->state = DEV_STATE_CLEAR_VERIFY;
+		if (cdev->handler)
+			cdev->handler(cdev, cdev->private->intparm,
+				      ERR_PTR(-EIO));
+		goto out_unlock;
+	}
 
 	/* trigger path verification. */
 	dev_fsm_event(sch->dev.driver_data, DEV_EVENT_VERIFY);
-
+out_unlock:
 	spin_unlock(&sch->lock);
 }
 
@@ -265,7 +317,7 @@
 		sch = ioinfo[irq];
 		if (sch == NULL)
 			continue;  /* we don't know the device anyway */
-		/* FIXME: Kill pending I/O. */
+
 		s390_subchannel_remove_chpid(sch, chpid);
 	}
 #endif
@@ -349,7 +401,7 @@
 	if (!test_bit(chpid, chpids_logical))
 		return; /* no need to do the rest */
 
-	for (irq = 0; irq <= __MAX_SUBCHANNELS; irq++) {
+	for (irq = 0; irq < __MAX_SUBCHANNELS; irq++) {
 		int chp_mask;
 
 		sch = ioinfo[irq];
@@ -369,7 +421,6 @@
 			continue;
 		}
 	
-		/* FIXME: Kill pending I/O. */
 		spin_lock_irq(&sch->lock);
 
 		chp_mask = s390_process_res_acc_sch(chpid, fla, fla_mask, sch);
@@ -539,7 +590,7 @@
 {
 	static DECLARE_WORK(work, do_process_crw, 0);
 
-	schedule_work(&work);
+	queue_work(ccw_device_work, &work);
 }
 
 static void
@@ -555,7 +606,7 @@
 	sprintf(dbf_txt, "cadd%x", chpid);
 	CIO_TRACE_EVENT(2, dbf_txt);
 
-	for (irq = 0; irq <= __MAX_SUBCHANNELS; irq++) {
+	for (irq = 0; irq < __MAX_SUBCHANNELS; irq++) {
 		int i;
 
 		sch = ioinfo[irq];
@@ -599,26 +650,9 @@
  * Handling of crw machine checks with channel path source.
  */
 void
-chp_process_crw(int chpid)
+chp_process_crw(int chpid, int on)
 {
-	/*
-	 * Update our descriptions. We need this since we don't always
-	 * get machine checks for path come and can't rely on our information
-	 * being consistent otherwise.
-	 */
-	chsc_get_sch_descriptions();
-	if (!cio_chsc_desc_avail) {
-		/*
-		 * Something went wrong...
-		 * We can't reliably say whether a path was there before.
-		 */
-		CIO_CRW_EVENT(0, "Error: Could not retrieve "
-			      "subchannel descriptions, will not process chp"
-			      "machine check...\n");
-		return;
-	}
-
-	if (!test_bit(chpid, chpids)) {
+	if (on == 0) {
 		/* Path has gone. We use the link incident routine.*/
 		s390_set_chpid_offline(chpid);
 	} else {
diff -urN linux-2.5.66/drivers/s390/cio/cio.c linux-2.5.66-s390/drivers/s390/cio/cio.c
--- linux-2.5.66/drivers/s390/cio/cio.c	Mon Mar 24 23:01:47 2003
+++ linux-2.5.66-s390/drivers/s390/cio/cio.c	Wed Mar 26 15:45:16 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/cio.c
  *   S/390 common I/O routines -- low level i/o calls
- *   $Revision: 1.91 $
+ *   $Revision: 1.94 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -176,13 +176,16 @@
 	CIO_TRACE_EVENT(0, dbf_text);
 	CIO_HEX_EVENT(0, &sch->schib, sizeof (struct schib));
 
-	return -ENODEV;
+	if (sch->lpm == 0)
+		return -ENODEV;
+	else
+		return -EACCES;
 }
 
 int
 cio_start (struct subchannel *sch,	/* subchannel structure */
 	   struct ccw1 * cpa,		/* logical channel prog addr */
-	   unsigned long intparm,	/* interruption parameter */
+	   unsigned int intparm,	/* interruption parameter */
 	   __u8 lpm)			/* logical path mask */
 {
 	char dbf_txt[15];
@@ -191,7 +194,7 @@
 	sprintf (dbf_txt, "stIO%x", sch->irq);
 	CIO_TRACE_EVENT (4, dbf_txt);
 
-	sch->orb.intparm = (__u32) (long) &sch->u_intparm;
+	sch->orb.intparm = intparm;
 	sch->orb.fmt = 1;
 
 	sch->orb.pfch = sch->options.prefetch == 0;
@@ -219,7 +222,6 @@
 		/*
 		 * initialize device status information
 		 */
-		sch->u_intparm = intparm;
 		sch->schib.scsw.actl |= SCSW_ACTL_START_PEND;
 		return 0;
 	case 1:		/* status pending */
@@ -265,13 +267,10 @@
 }
 
 /*
- * Note: The "intparm" parameter is not used by the halt_IO() function
- *	 itself, as no ORB is built for the HSCH instruction. However,
- *	 it allows the device interrupt handler to associate the upcoming
- *	 interrupt with the halt_IO() request.
+ * halt I/O operation
  */
 int
-cio_halt(struct subchannel *sch, unsigned long intparm)
+cio_halt(struct subchannel *sch)
 {
 	char dbf_txt[15];
 	int ccode;
@@ -297,7 +296,6 @@
 
 	switch (ccode) {
 	case 0:
-		sch->u_intparm = intparm;
 		sch->schib.scsw.actl |= SCSW_ACTL_HALT_PEND;
 		return 0;
 	case 1:		/* status pending */
@@ -309,13 +307,10 @@
 }
 
 /*
- * Note: The "intparm" parameter is not used by the clear_IO() function
- *	 itself, as no ORB is built for the CSCH instruction. However,
- *	 it allows the device interrupt handler to associate the upcoming
- *	 interrupt with the clear_IO() request.
+ * Clear I/O operation
  */
 int
-cio_clear(struct subchannel *sch, unsigned long intparm)
+cio_clear(struct subchannel *sch)
 {
 	char dbf_txt[15];
 	int ccode;
@@ -340,7 +335,6 @@
 
 	switch (ccode) {
 	case 0:
-		sch->u_intparm = intparm;
 		sch->schib.scsw.actl |= SCSW_ACTL_CLEAR_PEND;
 		return 0;
 	default:		/* device not operational */
@@ -620,7 +614,7 @@
 		 */
 		if (tpi_info->adapter_IO == 1 &&
 		    tpi_info->int_type == IO_INTERRUPT_TYPE) {
-			do_adapter_IO (tpi_info->intparm);
+			do_adapter_IO();
 			continue;
 		}
 		sch = ioinfo[tpi_info->irq];
diff -urN linux-2.5.66/drivers/s390/cio/cio.h linux-2.5.66-s390/drivers/s390/cio/cio.h
--- linux-2.5.66/drivers/s390/cio/cio.h	Mon Mar 24 22:59:54 2003
+++ linux-2.5.66-s390/drivers/s390/cio/cio.h	Wed Mar 26 15:45:16 2003
@@ -98,8 +98,6 @@
 
 	__u8 vpm;		/* verified path mask */
 	__u8 lpm;		/* logical path mask */
-	// TODO: intparm for second start i/o
-	unsigned long u_intparm;	/* user interruption parameter */
 	struct schib schib;	/* subchannel information block */
 	struct orb orb;		/* operation request block */
 	struct ccw1 sense_ccw;	/* static ccw for sense command */
@@ -116,11 +114,10 @@
 extern int cio_enable_subchannel (struct subchannel *, unsigned int);
 extern int cio_disable_subchannel (struct subchannel *);
 extern int cio_cancel (struct subchannel *);
-extern int cio_clear (struct subchannel *, unsigned long);
-extern int cio_do_io (struct subchannel *, struct ccw1 *, unsigned long, __u8);
+extern int cio_clear (struct subchannel *);
 extern int cio_resume (struct subchannel *);
-extern int cio_halt (struct subchannel *, unsigned long);
-extern int cio_start (struct subchannel *, struct ccw1 *, unsigned long, __u8);
+extern int cio_halt (struct subchannel *);
+extern int cio_start (struct subchannel *, struct ccw1 *, unsigned int, __u8);
 extern int cio_cancel (struct subchannel *);
 extern int cio_set_options (struct subchannel *, int);
 extern int cio_get_options (struct subchannel *);
diff -urN linux-2.5.66/drivers/s390/cio/css.c linux-2.5.66-s390/drivers/s390/cio/css.c
--- linux-2.5.66/drivers/s390/cio/css.c	Mon Mar 24 23:00:03 2003
+++ linux-2.5.66-s390/drivers/s390/cio/css.c	Wed Mar 26 15:45:16 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/css.c
  *  driver for channel subsystem
- *   $Revision: 1.40 $
+ *   $Revision: 1.43 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
@@ -41,7 +41,7 @@
 		/* There already is a struct subchannel for this irq. */
 		return -EBUSY;
 
-	sch = kmalloc (sizeof (*sch), GFP_DMA);
+	sch = kmalloc (sizeof (*sch), GFP_KERNEL | GFP_DMA);
 	if (sch == NULL)
 		return -ENOMEM;
 	ret = cio_validate_subchannel (sch, irq);
@@ -161,7 +161,7 @@
 
 	sch = ioinfo[irq];
 	if (sch == NULL) {
-		schedule_work(&work);
+		queue_work(ccw_device_work, &work);
 		return;
 	}
 	if (!sch->dev.driver_data)
@@ -172,7 +172,7 @@
 	ccode = stsch(irq, &sch->schib);
 	if (!ccode)
 		if (devno != sch->schib.pmcw.dev)
-			schedule_work(&work);
+			queue_work(ccw_device_work, &work);
 }
 
 /*
diff -urN linux-2.5.66/drivers/s390/cio/css.h linux-2.5.66-s390/drivers/s390/cio/css.h
--- linux-2.5.66/drivers/s390/cio/css.h	Mon Mar 24 23:01:53 2003
+++ linux-2.5.66-s390/drivers/s390/cio/css.h	Wed Mar 26 15:45:16 2003
@@ -79,6 +79,7 @@
 		unsigned int esid:1;        /* Ext. SenseID supported by HW */
 		unsigned int dosense:1;	    /* delayed SENSE required */
 	} __attribute__((packed)) flags;
+	unsigned long intparm;	/* user interruption parameter */
 	struct qdio_irq *qdio_data;
 	struct irb irb;		/* device status */
 	struct senseid senseid;	/* SenseID info */
diff -urN linux-2.5.66/drivers/s390/cio/device.c linux-2.5.66-s390/drivers/s390/cio/device.c
--- linux-2.5.66/drivers/s390/cio/device.c	Mon Mar 24 23:01:14 2003
+++ linux-2.5.66-s390/drivers/s390/cio/device.c	Wed Mar 26 15:45:16 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/device.c
  *  bus driver for ccw devices
- *   $Revision: 1.50 $
+ *   $Revision: 1.53 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/list.h>
 #include <linux/device.h>
+#include <linux/workqueue.h>
 
 #include <asm/ccwdev.h>
 #include <asm/cio.h>
@@ -126,14 +127,32 @@
 	.irq = io_subchannel_irq,
 };
 
+struct workqueue_struct *ccw_device_work;
+static wait_queue_head_t ccw_device_init_wq;
+static atomic_t ccw_device_init_count;
+
 static int __init
 init_ccw_bus_type (void)
 {
 	int ret;
+
+	init_waitqueue_head(&ccw_device_init_wq);
+	atomic_set(&ccw_device_init_count, 0);
+
+	ccw_device_work = create_workqueue("cio");
+	if (!ccw_device_work)
+		return -ENOMEM; /* FIXME: better errno ? */
+
 	if ((ret = bus_register (&ccw_bus_type)))
 		return ret;
 
-	return driver_register(&io_subchannel_driver.drv);
+	if ((ret = driver_register(&io_subchannel_driver.drv)))
+		return ret;
+
+	wait_event(ccw_device_init_wq,
+		   atomic_read(&ccw_device_init_count) == 0);
+	flush_workqueue(ccw_device_work);
+	return 0;
 }
 
 static void __exit
@@ -141,6 +160,7 @@
 {
 	driver_unregister(&io_subchannel_driver.drv);
 	bus_unregister(&ccw_bus_type);
+	destroy_workqueue(ccw_device_work);
 }
 
 subsys_initcall(init_ccw_bus_type);
@@ -360,7 +380,7 @@
 /*
  * Register recognized device.
  */
-void
+static void
 io_subchannel_register(void *data)
 {
 	struct ccw_device *cdev;
@@ -389,6 +409,42 @@
 	put_device(&sch->dev);
 }
 
+/*
+ * subchannel recognition done. Called from the state machine.
+ */
+void
+io_subchannel_recog_done(struct ccw_device *cdev)
+{
+	struct subchannel *sch;
+
+	if (css_init_done == 0)
+		return;
+	switch (cdev->private->state) {
+	case DEV_STATE_NOT_OPER:
+		/* Remove device found not operational. */
+		sch = to_subchannel(cdev->dev.parent);
+		sch->dev.driver_data = 0;
+		put_device(&sch->dev);
+		if (cdev->dev.release)
+			cdev->dev.release(&cdev->dev);
+		break;
+	case DEV_STATE_OFFLINE:
+		/* 
+		 * We can't register the device in interrupt context so
+		 * we schedule a work item.
+		 */
+		INIT_WORK(&cdev->private->kick_work,
+			  io_subchannel_register, (void *) cdev);
+		queue_work(ccw_device_work, &cdev->private->kick_work);
+		break;
+	case DEV_STATE_BOXED:
+		/* Device did not respond in time. */
+		break;
+	}
+	if (atomic_dec_and_test(&ccw_device_init_count))
+		wake_up(&ccw_device_init_wq);
+}
+
 static void
 io_subchannel_recog(struct ccw_device *cdev, struct subchannel *sch)
 {
@@ -419,6 +475,9 @@
 	/* Do first half of device_register. */
 	device_initialize(&cdev->dev);
 
+	/* Increase counter of devices currently in recognition. */
+	atomic_inc(&ccw_device_init_count);
+
 	/* Start async. device sensing. */
 	spin_lock_irq(cdev->ccwlock);
 	rc = ccw_device_recognition(cdev);
@@ -428,6 +487,8 @@
 		put_device(&sch->dev);
 		if (cdev->dev.release)
 			cdev->dev.release(&cdev->dev);
+		if (atomic_dec_and_test(&ccw_device_init_count))
+			wake_up(&ccw_device_init_wq);
 	}
 }
 
@@ -452,7 +513,8 @@
 	if (!cdev)
 		return -ENOMEM;
 	memset(cdev, 0, sizeof(struct ccw_device));
-	cdev->private = kmalloc(sizeof(struct ccw_device_private), GFP_DMA);
+	cdev->private = kmalloc(sizeof(struct ccw_device_private), 
+				GFP_KERNEL | GFP_DMA);
 	if (!cdev->private) {
 		kfree(cdev);
 		return -ENOMEM;
diff -urN linux-2.5.66/drivers/s390/cio/device.h linux-2.5.66-s390/drivers/s390/cio/device.h
--- linux-2.5.66/drivers/s390/cio/device.h	Mon Mar 24 23:01:15 2003
+++ linux-2.5.66-s390/drivers/s390/cio/device.h	Wed Mar 26 15:45:16 2003
@@ -14,13 +14,10 @@
 	DEV_STATE_W4SENSE,
 	DEV_STATE_DISBAND_PGID,
 	DEV_STATE_BOXED,
-	/* special states for qdio */
-	DEV_STATE_QDIO_INIT,
-	DEV_STATE_QDIO_ACTIVE,
-	DEV_STATE_QDIO_CLEANUP,
 	/* states to wait for i/o completion before doing something */
 	DEV_STATE_ONLINE_VERIFY,
 	DEV_STATE_W4SENSE_VERIFY,
+	DEV_STATE_CLEAR_VERIFY,
 	/* last element! */
 	NR_DEV_STATES
 };
@@ -63,7 +60,9 @@
 		cdev->private->state == DEV_STATE_BOXED);
 }
 
-void io_subchannel_register(void *data);
+extern struct workqueue_struct *ccw_device_work;
+
+void io_subchannel_recog_done(struct ccw_device *cdev);
 
 int ccw_device_recognition(struct ccw_device *);
 int ccw_device_online(struct ccw_device *);
diff -urN linux-2.5.66/drivers/s390/cio/device_fsm.c linux-2.5.66-s390/drivers/s390/cio/device_fsm.c
--- linux-2.5.66/drivers/s390/cio/device_fsm.c	Mon Mar 24 23:00:40 2003
+++ linux-2.5.66-s390/drivers/s390/cio/device_fsm.c	Wed Mar 26 15:45:16 2003
@@ -81,14 +81,14 @@
 	if (!(sch->schib.scsw.actl & SCSW_ACTL_CLEAR_PEND)) {
 		/* Stage 2: halt io. */
 		while (cdev->private->iretry-- > 0)
-			if (cio_halt (sch, 0xC8C1D3E3) == 0)
+			if (cio_halt (sch) == 0)
 				return -EBUSY;
 		/* halt io unsuccessful. */
 		cdev->private->iretry = 255;	/* 255 clear retries. */
 	}
 	/* Stage 3: clear io. */
 	while (cdev->private->iretry-- > 0)
-		if (cio_clear (sch, 0x40C3D3D9) == 0)
+		if (cio_clear (sch) == 0)
 			return -EBUSY;
 	panic("Can't stop i/o on subchannel.\n");
 }
@@ -112,10 +112,6 @@
 		CIO_DEBUG(KERN_WARNING, 2,
 			  "SenseID : unknown device %04X on subchannel %04X\n",
 			  sch->schib.pmcw.dev, sch->irq);
-		sch->dev.driver_data = 0;
-		put_device(&sch->dev);
-		if (cdev->dev.release)
-			cdev->dev.release(&cdev->dev);
 		break;
 	case DEV_STATE_OFFLINE:
 		/* fill out sense information */
@@ -131,11 +127,6 @@
 			  "%04X/%02X\n", sch->schib.pmcw.dev,
 			  cdev->id.cu_type, cdev->id.cu_model,
 			  cdev->id.dev_type, cdev->id.dev_model);
-		if (css_init_done == 0)
-			break;
-		INIT_WORK(&cdev->private->kick_work,
-			  io_subchannel_register, (void *) cdev);
-		schedule_work(&cdev->private->kick_work);
 		break;
 	case DEV_STATE_BOXED:
 		CIO_DEBUG(KERN_WARNING, 2,
@@ -143,6 +134,7 @@
 			  sch->schib.pmcw.dev, sch->irq);
 		break;
 	}
+	io_subchannel_recog_done(cdev);
 	wake_up(&cdev->private->wait_q);
 }
 
@@ -446,6 +438,18 @@
 	ccw_device_call_handler(cdev);
 }
 
+/*
+ * Got an timeout in online state.
+ */
+static void
+ccw_device_online_timeout(struct ccw_device *cdev, enum dev_event dev_event)
+{
+	ccw_device_set_timeout(cdev, 0);
+	if (cdev->private->qdio_data &&
+	    cdev->private->qdio_data->timeout)
+		cdev->private->qdio_data->timeout(cdev);
+}
+
 static void
 ccw_device_irq_verify(struct ccw_device *cdev, enum dev_event dev_event)
 {
@@ -527,103 +531,44 @@
 	ccw_device_call_handler(cdev);
 }
 
-/*
- * No operation action. This is used e.g. to ignore a timeout event in
- * state offline.
- */
-static void
-ccw_device_nop(struct ccw_device *cdev, enum dev_event dev_event)
-{
-}
-
-/*
- * Bug operation action. 
- */
-static void
-ccw_device_bug(struct ccw_device *cdev, enum dev_event dev_event)
-{
-	printk(KERN_EMERG "dev_jumptable[%i][%i] == NULL\n",
-	       cdev->private->state, dev_event);
-	BUG();
-}
-
-/*
- * We've got an interrupt on establish queues. Check for errors and
- * accordingly retry or move on.
- */
 static void
-ccw_device_qdio_init_irq(struct ccw_device *cdev, enum dev_event dev_event)
+ccw_device_clear_verify(struct ccw_device *cdev, enum dev_event dev_event)
 {
 	struct irb *irb;
-	struct subchannel *sch;
 
 	irb = (struct irb *) __LC_IRB;
 	/* Check for unsolicited interrupt. */
 	if (irb->scsw.stctl ==
 	    		(SCSW_STCTL_STATUS_PEND | SCSW_STCTL_ALERT_STATUS)) {
-		if (cdev->private->qdio_data && 
-		    cdev->private->qdio_data->establish_irq)
-			cdev->private->qdio_data->establish_irq(cdev, 0, irb);
-		wake_up(&cdev->private->wait_q);
+		if (cdev->handler)
+			cdev->handler (cdev, 0, irb);
 		return;
 	}
+	/* Accumulate status. We don't do basic sense. */
 	ccw_device_accumulate_irb(cdev, irb);
-	//FIXME: Basic sense?
-	sch = to_subchannel(cdev->dev.parent);
-	if (cdev->private->qdio_data && cdev->private->qdio_data->establish_irq)
-		cdev->private->qdio_data->establish_irq(cdev, sch->u_intparm,
-							&cdev->private->irb);
-	wake_up(&cdev->private->wait_q);
+	/* Try to start delayed device verification. */
+	ccw_device_online_verify(cdev, 0);
+	/* Note: Don't call handler for cio initiated clear! */
 }
 
 /*
- * Run into a timeout after establish queues, retry if needed.
+ * No operation action. This is used e.g. to ignore a timeout event in
+ * state offline.
  */
 static void
-ccw_device_qdio_init_timeout(struct ccw_device *cdev, enum dev_event dev_event)
-{
-	ccw_device_set_timeout(cdev, 0);
-	if (cdev->private->qdio_data &&
-	    cdev->private->qdio_data->establish_timeout)
-		cdev->private->qdio_data->establish_timeout(cdev);
-	wake_up(&cdev->private->wait_q);
-}
-
-static void
-ccw_device_qdio_cleanup_irq(struct ccw_device *cdev,
-			    enum dev_event dev_event)
+ccw_device_nop(struct ccw_device *cdev, enum dev_event dev_event)
 {
-	struct irb *irb;
-	struct subchannel *sch;
-
-	irb = (struct irb *) __LC_IRB;
-	/* Check for unsolicited interrupt. */
-	if (irb->scsw.stctl ==
-	    		(SCSW_STCTL_STATUS_PEND | SCSW_STCTL_ALERT_STATUS)) {
-		if (cdev->private->qdio_data && 
-		    cdev->private->qdio_data->cleanup_irq)
-			cdev->private->qdio_data->cleanup_irq(cdev, 0, irb);
-		wake_up(&cdev->private->wait_q);
-		return;
-	}
-	ccw_device_accumulate_irb(cdev, irb);
-	//FIXME: Basic sense?
-	sch = to_subchannel(cdev->dev.parent);
-	if (cdev->private->qdio_data && cdev->private->qdio_data->cleanup_irq)
-		cdev->private->qdio_data->cleanup_irq(cdev, sch->u_intparm,
-						      &cdev->private->irb);
-	wake_up(&cdev->private->wait_q);
 }
 
+/*
+ * Bug operation action. 
+ */
 static void
-ccw_device_qdio_cleanup_timeout(struct ccw_device *cdev,
-				enum dev_event dev_event)
+ccw_device_bug(struct ccw_device *cdev, enum dev_event dev_event)
 {
-	ccw_device_set_timeout(cdev, 0);
-	if (cdev->private->qdio_data &&
-	    cdev->private->qdio_data->cleanup_timeout)
-		cdev->private->qdio_data->cleanup_timeout(cdev);
-	wake_up(&cdev->private->wait_q);
+	printk(KERN_EMERG "dev_jumptable[%i][%i] == NULL\n",
+	       cdev->private->state, dev_event);
+	BUG();
 }
 
 /*
@@ -663,7 +608,7 @@
 	[DEV_STATE_ONLINE] {
 		[DEV_EVENT_NOTOPER]	ccw_device_online_notoper,
 		[DEV_EVENT_INTERRUPT]	ccw_device_irq,
-		[DEV_EVENT_TIMEOUT]	ccw_device_nop,
+		[DEV_EVENT_TIMEOUT]	ccw_device_online_timeout,
 		[DEV_EVENT_VERIFY]	ccw_device_online_verify,
 	},
 	[DEV_STATE_W4SENSE] {
@@ -684,25 +629,6 @@
 		[DEV_EVENT_TIMEOUT]	ccw_device_nop,
 		[DEV_EVENT_VERIFY]	ccw_device_nop,
 	},
-	/* special states for qdio */
-	[DEV_STATE_QDIO_INIT] {
-		[DEV_EVENT_NOTOPER]     ccw_device_online_notoper,
-		[DEV_EVENT_INTERRUPT]   ccw_device_qdio_init_irq,
-		[DEV_EVENT_TIMEOUT]     ccw_device_qdio_init_timeout,
-		[DEV_EVENT_VERIFY]      ccw_device_nop,
-	},
-	[DEV_STATE_QDIO_ACTIVE] {
-		[DEV_EVENT_NOTOPER]     ccw_device_online_notoper,
-		[DEV_EVENT_INTERRUPT]   ccw_device_irq,
-		[DEV_EVENT_TIMEOUT]     ccw_device_nop,
-		[DEV_EVENT_VERIFY]      ccw_device_nop,
-	},
-	[DEV_STATE_QDIO_CLEANUP] {
-		[DEV_EVENT_NOTOPER]     ccw_device_online_notoper,
-		[DEV_EVENT_INTERRUPT]   ccw_device_qdio_cleanup_irq,
-		[DEV_EVENT_TIMEOUT]     ccw_device_qdio_cleanup_timeout,
-		[DEV_EVENT_VERIFY]      ccw_device_nop,
-	},
 	/* states to wait for i/o completion before doing something */
 	[DEV_STATE_ONLINE_VERIFY] {
 		[DEV_EVENT_NOTOPER]	ccw_device_online_notoper,
@@ -716,6 +642,12 @@
 		[DEV_EVENT_TIMEOUT]	ccw_device_nop,
 		[DEV_EVENT_VERIFY]	ccw_device_nop,
 	},
+	[DEV_STATE_CLEAR_VERIFY] {
+		[DEV_EVENT_NOTOPER]     ccw_device_online_notoper,
+		[DEV_EVENT_INTERRUPT]   ccw_device_clear_verify,
+		[DEV_EVENT_TIMEOUT]	ccw_device_nop,
+		[DEV_EVENT_VERIFY]	ccw_device_nop,
+	},
 };
 
 /*
@@ -736,3 +668,4 @@
 	dev_fsm_event(cdev, DEV_EVENT_INTERRUPT);
 }
 
+EXPORT_SYMBOL(ccw_device_set_timeout);
diff -urN linux-2.5.66/drivers/s390/cio/device_id.c linux-2.5.66-s390/drivers/s390/cio/device_id.c
--- linux-2.5.66/drivers/s390/cio/device_id.c	Mon Mar 24 22:59:46 2003
+++ linux-2.5.66-s390/drivers/s390/cio/device_id.c	Wed Mar 26 15:45:16 2003
@@ -198,11 +198,13 @@
 			/* 0x00E2C9C4 == ebcdic "SID" */
 			ret = cio_start (sch, cdev->private->iccws,
 					 0x00E2C9C4, cdev->private->imask);
-			/* ret is 0, -EBUSY or -ENODEV */
-			if (ret != -EBUSY)
+			/* ret is 0, -EBUSY, -EACCES or -ENODEV */
+			if (ret == -EBUSY) {
+				udelay(100);
+				continue;
+			}
+			if (ret != -EACCES)
 				return ret;
-			udelay(100);
-			continue;
 		}
 		cdev->private->imask >>= 1;
 		cdev->private->iretry = 5;
diff -urN linux-2.5.66/drivers/s390/cio/device_ops.c linux-2.5.66-s390/drivers/s390/cio/device_ops.c
--- linux-2.5.66/drivers/s390/cio/device_ops.c	Mon Mar 24 23:01:14 2003
+++ linux-2.5.66-s390/drivers/s390/cio/device_ops.c	Wed Mar 26 15:45:16 2003
@@ -48,13 +48,14 @@
 	if (!cdev)
 		return -ENODEV;
 	if (cdev->private->state != DEV_STATE_ONLINE &&
-	    cdev->private->state != DEV_STATE_W4SENSE &&
-	    cdev->private->state != DEV_STATE_QDIO_ACTIVE)
+	    cdev->private->state != DEV_STATE_W4SENSE)
 		return -EINVAL;
 	sch = to_subchannel(cdev->dev.parent);
 	if (!sch)
 		return -ENODEV;
-	ret = cio_clear(sch, intparm);
+	ret = cio_clear(sch);
+	if (ret == 0)
+		cdev->private->intparm = intparm;
 	return ret;
 }
 
@@ -68,8 +69,7 @@
 	if (!cdev)
 		return -ENODEV;
 	if (cdev->private->state != DEV_STATE_ONLINE &&
-	    cdev->private->state != DEV_STATE_W4SENSE &&
-	    cdev->private->state != DEV_STATE_QDIO_INIT)
+	    cdev->private->state != DEV_STATE_W4SENSE)
 		return -EINVAL;
 	sch = to_subchannel(cdev->dev.parent);
 	if (!sch)
@@ -77,7 +77,10 @@
 	ret = cio_set_options (sch, flags);
 	if (ret)
 		return ret;
-	ret = cio_start (sch, cpa, intparm, lpm);
+	/* 0xe4e2c5d9 == ebcdic "USER" */
+	ret = cio_start (sch, cpa, 0xe4e2c5d9, lpm);
+	if (ret == 0)
+		cdev->private->intparm = intparm;
 	return ret;
 }
 
@@ -95,7 +98,9 @@
 	sch = to_subchannel(cdev->dev.parent);
 	if (!sch)
 		return -ENODEV;
-	ret = cio_halt(sch, intparm);
+	ret = cio_halt(sch);
+	if (ret == 0)
+		cdev->private->intparm = intparm;
 	return ret;
 }
 
@@ -123,15 +128,6 @@
 {
 	struct subchannel *sch;
 	unsigned int stctl;
-	void (*handler)(struct ccw_device *, unsigned long, struct irb *);
-
-	if (cdev->private->state == DEV_STATE_QDIO_ACTIVE) {
-		if (cdev->private->qdio_data)
-			handler = cdev->private->qdio_data->handler;
-		else
-			handler = NULL;
-	} else
-		handler = cdev->handler;
 
 	sch = to_subchannel(cdev->dev.parent);
 
@@ -154,8 +150,9 @@
 	/*
 	 * Now we are ready to call the device driver interrupt handler.
 	 */
-	if (handler)
-		handler(cdev, sch->u_intparm, &cdev->private->irb);
+	if (cdev->handler)
+		cdev->handler(cdev, cdev->private->intparm,
+			      &cdev->private->irb);
 
 	/*
 	 * Clear the old and now useless interrupt response block.
@@ -300,7 +297,7 @@
 	if (!ciw || ciw->cmd == 0)
 		return -EOPNOTSUPP;
 
-	rcd_buf = kmalloc(ciw->count, GFP_DMA);
+	rcd_buf = kmalloc(ciw->count, GFP_KERNEL | GFP_DMA);
  	if (!rcd_buf)
 		return -ENOMEM;
  	memset (rcd_buf, 0, ciw->count);
@@ -363,13 +360,14 @@
 
 
 MODULE_LICENSE("GPL");
+EXPORT_SYMBOL(ccw_device_set_options);
 EXPORT_SYMBOL(ccw_device_clear);
 EXPORT_SYMBOL(ccw_device_halt);
 EXPORT_SYMBOL(ccw_device_resume);
 EXPORT_SYMBOL(ccw_device_start);
 EXPORT_SYMBOL(ccw_device_get_ciw);
 EXPORT_SYMBOL(ccw_device_get_path_mask);
-EXPORT_SYMBOL (read_conf_data);
-EXPORT_SYMBOL (read_dev_chars);
+EXPORT_SYMBOL(read_conf_data);
+EXPORT_SYMBOL(read_dev_chars);
 EXPORT_SYMBOL(_ccw_device_get_subchannel_number);
 EXPORT_SYMBOL(_ccw_device_get_device_number);
diff -urN linux-2.5.66/drivers/s390/cio/device_pgid.c linux-2.5.66-s390/drivers/s390/cio/device_pgid.c
--- linux-2.5.66/drivers/s390/cio/device_pgid.c	Mon Mar 24 23:00:44 2003
+++ linux-2.5.66-s390/drivers/s390/cio/device_pgid.c	Wed Mar 26 15:45:16 2003
@@ -51,14 +51,23 @@
 			/* 0xe2d5c9c4 == ebcdic "SNID" */
 			ret = cio_start (sch, cdev->private->iccws, 
 					 0xE2D5C9C4, cdev->private->imask);
-			/* ret is 0, -EBUSY or -ENODEV */
-			if (ret != -EBUSY)
+			/* ret is 0, -EBUSY, -EACCES or -ENODEV */
+			if (ret == -EBUSY) {
+				CIO_MSG_EVENT(2, 
+					      "SNID - device %04X, start_io() "
+					      "reports rc : %d, retrying ...\n",
+					      sch->schib.pmcw.dev, ret);
+				udelay(100);
+				continue;
+			}
+			if (ret != -EACCES)
 				return ret;
-			CIO_MSG_EVENT(2, "SNID - device %04X, start_io() "
-				      "reports rc : %d, retrying ...\n",
-				      sch->schib.pmcw.dev, ret);
-			udelay(100);
-			continue;
+			CIO_MSG_EVENT(2, "SNID - Device %04X on Subchannel "
+				      "%04X, lpm %02X, became 'not "
+				      "operational'\n",
+				      sch->schib.pmcw.dev, sch->irq,
+				      cdev->private->imask);
+
 		}
 		cdev->private->imask >>= 1;
 		cdev->private->iretry = 5;
@@ -231,7 +240,9 @@
 		/* 0xE2D7C9C4 == ebcdic "SPID" */
 		ret = cio_start (sch, cdev->private->iccws,
 				 0xE2D7C9C4, cdev->private->imask);
-		/* ret is 0, -EBUSY or -ENODEV */
+		/* ret is 0, -EBUSY, -EACCES or -ENODEV */
+		if (ret == -EACCES)
+			break;
 		if (ret != -EBUSY)
 			return ret;
 		udelay(100);
diff -urN linux-2.5.66/drivers/s390/cio/device_status.c linux-2.5.66-s390/drivers/s390/cio/device_status.c
--- linux-2.5.66/drivers/s390/cio/device_status.c	Mon Mar 24 23:00:34 2003
+++ linux-2.5.66-s390/drivers/s390/cio/device_status.c	Wed Mar 26 15:45:16 2003
@@ -309,7 +309,7 @@
 	sch->sense_ccw.flags = CCW_FLAG_SLI;
 
 	/* 0xe2C5D5E2 == "SENS" in ebcdic */
-	return cio_start (sch, &sch->sense_ccw, 0xE2C5D5E2, 0);
+	return cio_start (sch, &sch->sense_ccw, 0xE2C5D5E2, 0xff);
 }
 
 /*
diff -urN linux-2.5.66/drivers/s390/cio/qdio.c linux-2.5.66-s390/drivers/s390/cio/qdio.c
--- linux-2.5.66/drivers/s390/cio/qdio.c	Mon Mar 24 23:00:49 2003
+++ linux-2.5.66-s390/drivers/s390/cio/qdio.c	Wed Mar 26 15:45:16 2003
@@ -55,7 +55,7 @@
 #include "qdio.h"
 #include "ioasm.h"
 
-#define VERSION_QDIO_C "$Revision: 1.34 $"
+#define VERSION_QDIO_C "$Revision: 1.40 $"
 
 /****************** MODULE PARAMETER VARIABLES ********************/
 MODULE_AUTHOR("Utz Bacher <utz.bacher@de.ibm.com>");
@@ -1239,8 +1239,6 @@
 	if (irq_ptr->qdr)
 		kfree(irq_ptr->qdr);
 	kfree(irq_ptr);
-	QDIO_DBF_TEXT3(0,setup,"MOD_DEC_");
-	MOD_DEC_USE_COUNT;
 }
 
 static void
@@ -1482,7 +1480,7 @@
 }
 
 static int
-iqdio_thinint_handler(__u32 intparm)
+iqdio_thinint_handler(void)
 {
 	QDIO_DBF_TEXT4(0,trace,"thin_int");
 
@@ -1500,7 +1498,7 @@
 }
 
 static void
-qdio_set_state(struct qdio_irq *irq_ptr,int state)
+qdio_set_state(struct qdio_irq *irq_ptr, enum qdio_irq_states state)
 {
 	int i;
 	char dbf_text[15];
@@ -1570,11 +1568,48 @@
 	}
 }
 
+static void qdio_establish_handle_irq(struct ccw_device*, int, int);
+
+static inline void
+qdio_handle_activate_check(struct ccw_device *cdev, unsigned long intparm,
+			   int cstat, int dstat)
+{
+	struct qdio_irq *irq_ptr;
+	struct qdio_q *q;
+	char dbf_text[15];
+
+	irq_ptr = cdev->private->qdio_data;
+
+	QDIO_DBF_TEXT2(1, trace, "ick2");
+	sprintf(dbf_text,"%s", cdev->dev.bus_id);
+	QDIO_DBF_TEXT2(1,trace,dbf_text);
+	QDIO_DBF_HEX2(0,trace,&intparm,sizeof(int));
+	QDIO_DBF_HEX2(0,trace,&dstat,sizeof(int));
+	QDIO_DBF_HEX2(0,trace,&cstat,sizeof(int));
+	QDIO_PRINT_ERR("received check condition on activate " \
+		       "queues on device %s (cs=x%x, ds=x%x).\n",
+		       cdev->dev.bus_id, cstat, dstat);
+	if (irq_ptr->no_input_qs) {
+		q=irq_ptr->input_qs[0];
+	} else if (irq_ptr->no_output_qs) {
+		q=irq_ptr->output_qs[0];
+	} else {
+		QDIO_PRINT_ERR("oops... no queue registered for device %s!?\n",
+			       cdev->dev.bus_id);
+		goto omit_handler_call;
+	}
+	q->handler(q->cdev,QDIO_STATUS_ACTIVATE_CHECK_CONDITION|
+		   QDIO_STATUS_LOOK_FOR_ERROR,
+		   0,0,0,-1,-1,q->int_parm);
+omit_handler_call:
+	qdio_set_state(irq_ptr,QDIO_IRQ_STATE_STOPPED);
+
+}
+
 static void
 qdio_handler(struct ccw_device *cdev, unsigned long intparm, struct irb *irb)
 {
 	struct qdio_irq *irq_ptr;
-	struct qdio_q *q;
 	int cstat,dstat;
 	char dbf_text[15];
 
@@ -1585,8 +1620,8 @@
 	sprintf(dbf_text, "%s", cdev->dev.bus_id);
 	QDIO_DBF_TEXT4(0, trace, dbf_text);
 	
-	if (!intparm || !cdev) {
-		QDIO_PRINT_STUPID("got unsolicited interrupt in qdio " \
+	if (!intparm) {
+		QDIO_PRINT_ERR("got unsolicited interrupt in qdio " \
 				  "handler, device %s\n", cdev->dev.bus_id);
 		return;
 	}
@@ -1603,37 +1638,80 @@
 
 	qdio_irq_check_sense(irq_ptr->irq, irb);
 
-	if (cstat & SCHN_STAT_PCI) {
-		qdio_handle_pci(irq_ptr);
-		return;
+	sprintf(dbf_text, "state:%d", irq_ptr->state);
+	QDIO_DBF_TEXT4(0, trace, dbf_text);
+
+	switch (irq_ptr->state) {
+	case QDIO_IRQ_STATE_INACTIVE:
+		qdio_establish_handle_irq(cdev, cstat, dstat);
+		break;
+
+	case QDIO_IRQ_STATE_CLEANUP:
+		qdio_set_state(irq_ptr, QDIO_IRQ_STATE_INACTIVE);
+		break;
+
+	case QDIO_IRQ_STATE_ESTABLISHED:
+	case QDIO_IRQ_STATE_ACTIVE:
+		if (cstat & SCHN_STAT_PCI) {
+			qdio_handle_pci(irq_ptr);
+			break;
+		}
+
+		if ((cstat&~SCHN_STAT_PCI)||dstat) {
+			qdio_handle_activate_check(cdev, intparm, cstat, dstat);
+			break;
+		}
+	default:
+		QDIO_PRINT_ERR("got interrupt for queues in state %d on " \
+			       "device %s?!\n",
+			       irq_ptr->state, cdev->dev.bus_id);
 	}
+	wake_up(&cdev->private->wait_q);
 
-	if ((cstat&~SCHN_STAT_PCI)||dstat) {
-		QDIO_DBF_TEXT2(1, trace, "ick2");
-		sprintf(dbf_text,"%s", cdev->dev.bus_id);
-		QDIO_DBF_TEXT2(1,trace,dbf_text);
-		QDIO_DBF_HEX2(0,trace,&intparm,sizeof(int));
-		QDIO_DBF_HEX2(0,trace,&dstat,sizeof(int));
-		QDIO_DBF_HEX2(0,trace,&cstat,sizeof(int));
-		QDIO_PRINT_ERR("received check condition on activate " \
-			       "queues on device %s (cs=x%x, ds=x%x).\n",
-			       cdev->dev.bus_id, cstat, dstat);
-		if (irq_ptr->no_input_qs) {
-			q=irq_ptr->input_qs[0];
-		} else if (irq_ptr->no_output_qs) {
-			q=irq_ptr->output_qs[0];
-		} else {
-			QDIO_PRINT_ERR("oops... no queue registered for " \
-				       "device %s!?\n", cdev->dev.bus_id);
-			goto omit_handler_call;
-		}
-		q->handler(q->cdev,QDIO_STATUS_ACTIVATE_CHECK_CONDITION|
-			   QDIO_STATUS_LOOK_FOR_ERROR,
-			   0,0,0,-1,-1,q->int_parm);
-	omit_handler_call:
-		qdio_set_state(irq_ptr,QDIO_IRQ_STATE_STOPPED);
+}
+
+static void
+qdio_timeout_handler(struct ccw_device *cdev)
+{
+	struct qdio_irq *irq_ptr;
+	char dbf_text[15];
+
+	QDIO_DBF_TEXT2(0, trace, "qtoh");
+	sprintf(dbf_text, "%s", cdev->dev.bus_id);
+	QDIO_DBF_TEXT2(0, trace, dbf_text);
+
+	irq_ptr = cdev->private->qdio_data;
+	if (!irq_ptr) {
+		QDIO_PRINT_ERR("received timeout on unused device %s!\n",
+			       cdev->dev.bus_id);
 		return;
 	}
+	sprintf(dbf_text, "state:%d", irq_ptr->state);
+	QDIO_DBF_TEXT2(0, trace, dbf_text);
+
+	switch (irq_ptr->state) {
+	case QDIO_IRQ_STATE_ESTABLISHED:
+		/*
+		 * Fine, activate queues timed out.
+		 * This means we are up and running now.
+		 */
+		qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ACTIVE);
+		break;
+	case QDIO_IRQ_STATE_INACTIVE:
+		QDIO_PRINT_ERR("establish queues on irq %04x: timed out\n",
+			       irq_ptr->irq);
+		QDIO_DBF_TEXT2(1,setup,"eq:timeo");
+		qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ERR);
+		break;
+	case QDIO_IRQ_STATE_CLEANUP:
+		QDIO_PRINT_INFO("Did not get interrupt on cleanup, irq=0x%x.\n",
+				irq_ptr->irq);
+		qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ERR);
+		break;
+	default:
+		BUG();
+	}
+	wake_up(&cdev->private->wait_q);
 
 }
 
@@ -1972,19 +2050,22 @@
 		ccw_device_halt(cdev, QDIO_DOING_CLEANUP);
 		timeout=QDIO_CLEANUP_HALT_TIMEOUT;
 	}
-	cdev->private->state = DEV_STATE_QDIO_CLEANUP;
+	qdio_set_state(irq_ptr, QDIO_IRQ_STATE_CLEANUP);
 	ccw_device_set_timeout(cdev, timeout);
 	spin_unlock_irqrestore(get_ccwdev_lock(cdev),flags);
 
-	wait_event(cdev->private->wait_q, dev_fsm_final_state(cdev));
-
+	wait_event(cdev->private->wait_q,
+		   irq_ptr->state == QDIO_IRQ_STATE_INACTIVE ||
+		   irq_ptr->state == QDIO_IRQ_STATE_ERR);
+	/* Ignore errors. */
+	qdio_set_state(irq_ptr, QDIO_IRQ_STATE_INACTIVE);
 out:
 	up(&irq_ptr->setting_up_sema);
 	return result;
 }
 
 static inline void
-qdio_cleanup_finish(struct qdio_irq *irq_ptr)
+qdio_cleanup_finish(struct ccw_device *cdev, struct qdio_irq *irq_ptr)
 {
 	if (irq_ptr->is_iqdio_irq) {
 		qdio_put_indicator((__u32*)irq_ptr->dev_st_chg_ind);
@@ -1992,6 +2073,10 @@
                 /* reset adapter interrupt indicators */
 	}
 
+ 	/* exchange int handlers, if necessary */
+ 	if ((void*)cdev->handler == (void*)qdio_handler)
+ 		cdev->handler=irq_ptr->original_int_handler;
+
 	qdio_set_state(irq_ptr,QDIO_IRQ_STATE_INACTIVE);
 }
 
@@ -2014,51 +2099,16 @@
 	if (cdev->private->state != DEV_STATE_ONLINE)
 		return -EINVAL;
 
-	qdio_cleanup_finish(irq_ptr);
+	qdio_cleanup_finish(cdev, irq_ptr);
 	cdev->private->qdio_data = 0;
 
 	up(&irq_ptr->setting_up_sema);
 
 	qdio_release_irq_memory(irq_ptr);
+	module_put(THIS_MODULE);
 	return 0;
 }
 
-static void
-qdio_cleanup_handle_timeout(struct ccw_device *cdev)
-{
-	unsigned long flags;
-	struct qdio_irq *irq_ptr;
-
-	irq_ptr = cdev->private->qdio_data;
-
-	spin_lock_irqsave(get_ccwdev_lock(cdev),flags);
-	QDIO_PRINT_INFO("Did not get interrupt on cleanup, irq=0x%x.\n",
-			irq_ptr->irq);
-
-	spin_unlock_irqrestore(get_ccwdev_lock(cdev),flags);
-
-	cdev->private->state = DEV_STATE_ONLINE;
-	wake_up(&cdev->private->wait_q);
-}
-
-static void
-qdio_cleanup_handle_irq(struct ccw_device *cdev, unsigned long intparm,
-			struct irb *irb)
-{
-	struct qdio_irq *irq_ptr;
-
-	if (intparm == 0)
-		QDIO_PRINT_WARN("Got unsolicited interrupt on cleanup "
-				"(irq 0x%x).\n", cdev->private->irq);
-
-	irq_ptr = cdev->private->qdio_data;
-
-	qdio_irq_check_sense(irq_ptr->irq, irb);
-
-	cdev->private->state = DEV_STATE_ONLINE;
-	wake_up(&cdev->private->wait_q);
-}
-
 static inline void
 qdio_allocate_do_dbf(struct qdio_initialize *init_data)
 {
@@ -2134,24 +2184,6 @@
 	irq_ptr->qdr->qdf0[i+j].dkey=QDIO_STORAGE_KEY;
 }
 
-void
-qdio_establish_handle_timeout(struct ccw_device *cdev)
-{
-	struct qdio_irq *irq_ptr;
-
-	irq_ptr = cdev->private->qdio_data;
-
-	QDIO_PRINT_ERR("establish queues on irq %04x: timed out\n",
-		       irq_ptr->irq);
-	QDIO_DBF_TEXT2(1,setup,"eq:timeo");
-	/*
-	 * FIXME:
-	 * this is broken,
-	 * we are in the context of a timer interrupt and
-	 * qdio_shutdown calls schedule
-	 */
-	qdio_shutdown(cdev,QDIO_FLAG_CLEANUP_USING_CLEAR);
-}
 
 static inline void
 qdio_initialize_set_siga_flags_input(struct qdio_irq *irq_ptr)
@@ -2208,7 +2240,7 @@
 		QDIO_PRINT_ERR("received check condition on establish " \
 			       "queues on irq 0x%x (cs=x%x, ds=x%x).\n",
 			       irq_ptr->irq,cstat,dstat);
-		qdio_set_state(irq_ptr,QDIO_IRQ_STATE_STOPPED);
+		qdio_set_state(irq_ptr,QDIO_IRQ_STATE_ERR);
 	}
 	
 	if (!(dstat & DEV_STAT_DEV_END)) {
@@ -2218,13 +2250,7 @@
 		QDIO_PRINT_ERR("establish queues on irq %04x: didn't get "
 			       "device end: dstat=%02x, cstat=%02x\n",
 			       irq_ptr->irq, dstat, cstat);
-		/*
-		 * FIXME:
-		 * this is broken,
-		 * we are probably in the context of an i/o interrupt and
-		 * qdio_shutdown calls schedule
-		 */
-		qdio_shutdown(cdev,QDIO_FLAG_CLEANUP_USING_CLEAR);
+		qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ERR);
 		return 1;
 	}
 
@@ -2236,36 +2262,27 @@
 			       "the following devstat: dstat=%02x, "
 			       "cstat=%02x\n",
 			       irq_ptr->irq, dstat, cstat);
-		cdev->private->state = DEV_STATE_ONLINE;
+		qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ERR);
 		return 1;
 	}
 	return 0;
 }
 
 static void
-qdio_establish_handle_irq(struct ccw_device *cdev, unsigned long intparm,
-			  struct irb *irb)
+qdio_establish_handle_irq(struct ccw_device *cdev, int cstat, int dstat)
 {
 	struct qdio_irq *irq_ptr;
-	int cstat, dstat;
 	char dbf_text[15];
 
-        cstat = irb->scsw.cstat;
-        dstat = irb->scsw.dstat;
-
-	irq_ptr = cdev->private->qdio_data;
-
-	if (intparm == 0) {
-		QDIO_PRINT_WARN("Got unsolicited interrupt on establish "
-				"queues (irq 0x%x).\n", cdev->private->irq);
-		return;
-	}
-
-	qdio_irq_check_sense(irq_ptr->irq, irb);
+	sprintf(dbf_text,"qehi%4x",cdev->private->irq);
+	QDIO_DBF_TEXT0(0,setup,dbf_text);
+	QDIO_DBF_TEXT0(0,trace,dbf_text);
 
 	if (qdio_establish_irq_check_for_errors(cdev, cstat, dstat))
 		return;
 
+	irq_ptr = cdev->private->qdio_data;
+
 	if (MACHINE_IS_VM)
 		irq_ptr->qdioac=qdio_check_siga_needs(irq_ptr->irq);
 	else
@@ -2287,6 +2304,7 @@
 	qdio_initialize_set_siga_flags_output(irq_ptr);
 
 	qdio_set_state(irq_ptr,QDIO_IRQ_STATE_ESTABLISHED);
+
 }
 
 int
@@ -2334,7 +2352,7 @@
 	qdio_allocate_do_dbf(init_data);
 
 	/* create irq */
-	irq_ptr=kmalloc(sizeof(struct qdio_irq),GFP_DMA);
+	irq_ptr=kmalloc(sizeof(struct qdio_irq), GFP_KERNEL | GFP_DMA);
 
 	QDIO_DBF_TEXT0(0,setup,"irq_ptr:");
 	QDIO_DBF_HEX0(0,setup,&irq_ptr,sizeof(void*));
@@ -2347,7 +2365,7 @@
 	memset(irq_ptr,0,sizeof(struct qdio_irq));
         /* wipes qib.ac, required by ar7063 */
 
-	irq_ptr->qdr=kmalloc(sizeof(struct qdr),GFP_DMA);
+	irq_ptr->qdr=kmalloc(sizeof(struct qdr), GFP_KERNEL | GFP_DMA);
   	if (!(irq_ptr->qdr)) {
    		kfree(irq_ptr->qdr);
    		kfree(irq_ptr);
@@ -2372,11 +2390,6 @@
 		if (!irq_ptr->dev_st_chg_ind) {
 			QDIO_PRINT_WARN("no indicator location available " \
 					"for irq 0x%x\n",irq_ptr->irq);
-			/*
-			 * FIXME:
-			 * qdio_release_irq_memory does MOD_DEC_USE_COUNT
-			 * in an unbalanced fashion (see 30 lines farther down)
-			 */
 			qdio_release_irq_memory(irq_ptr);
 			return -ENOBUFS;
 		}
@@ -2396,19 +2409,17 @@
 			   init_data->q_format,init_data->flags,
 			   init_data->input_sbal_addr_array,
 			   init_data->output_sbal_addr_array)) {
-		/*
-		 * FIXME:
-		 * qdio_release_irq_memory does MOD_DEC_USE_COUNT
-		 * in an unbalanced fashion (see 10 lines farther down)
-		 */
 		qdio_release_irq_memory(irq_ptr);
 		return -ENOMEM;
 	}
 
 	qdio_set_state(irq_ptr,QDIO_IRQ_STATE_INACTIVE);
 
-	MOD_INC_USE_COUNT;
-	QDIO_DBF_TEXT3(0,setup,"MOD_INC_");
+	if (!try_module_get(THIS_MODULE)) {
+		QDIO_PRINT_CRIT("try_module_get() failed!\n");
+		qdio_release_irq_memory(irq_ptr);
+		return -EINVAL;
+	}
 
 	init_MUTEX_LOCKED(&irq_ptr->setting_up_sema);
 
@@ -2474,6 +2485,13 @@
 	} else
 		irq_ptr->aqueue = *ciw;
 
+	/* Set callback. */
+	irq_ptr->timeout = qdio_timeout_handler;
+
+	/* Set new interrupt handler. */
+	irq_ptr->original_int_handler = init_data->cdev->handler;
+	init_data->cdev->handler = qdio_handler;
+
 	/* the iqdio CHSC stuff */
 	if (irq_ptr->is_iqdio_irq) {
 /*		iqdio_enable_adapter_int_facility(irq_ptr);*/
@@ -2485,25 +2503,12 @@
 		result=iqdio_set_subchannel_ind(irq_ptr,0);
 		if (result) {
 			up(&irq_ptr->setting_up_sema);
-			/*
-			 * FIXME:
-			 * need some callback pointers to be set already,
-			 * i.e. irq_ptr->cleanup_irq and irq_ptr->cleanup_timeout?
-			 * (see 10 lines farther down)
-			 */
 			qdio_cleanup(init_data->cdev, QDIO_FLAG_CLEANUP_USING_CLEAR);
 			return result;
 		}
 		iqdio_set_delay_target(irq_ptr,IQDIO_DELAY_TARGET);
 	}
 
-	/* Set callback functions. */
-	irq_ptr->cleanup_irq = qdio_cleanup_handle_irq;
-	irq_ptr->cleanup_timeout = qdio_cleanup_handle_timeout;
-	irq_ptr->establish_irq = qdio_establish_handle_irq;
-	irq_ptr->establish_timeout = qdio_establish_handle_timeout;
-	irq_ptr->handler = qdio_handler;
-
 	up(&irq_ptr->setting_up_sema);
 
 	return 0;
@@ -2556,8 +2561,7 @@
                            irq_ptr->irq,result,result2);
 		result=result2;
 	}
-	if (result == 0)
-		cdev->private->state = DEV_STATE_QDIO_INIT;
+
 	spin_unlock_irqrestore(get_ccwdev_lock(cdev),saveflags);
 
 	if (result) {
@@ -2567,13 +2571,15 @@
 	}
 	
 	wait_event(cdev->private->wait_q,
-		   dev_fsm_final_state(cdev) ||
-		   (irq_ptr->state == QDIO_IRQ_STATE_ESTABLISHED));
+		   irq_ptr->state == QDIO_IRQ_STATE_ESTABLISHED ||
+		   irq_ptr->state == QDIO_IRQ_STATE_ERR);
 
-	if (cdev->private->state == DEV_STATE_QDIO_INIT)
+	if (irq_ptr->state == QDIO_IRQ_STATE_ESTABLISHED)
 		result = 0;
-	else 
+	else {
+		qdio_shutdown(cdev, QDIO_FLAG_CLEANUP_USING_CLEAR);
 		result = -EIO;
+	}
 
 	up(&irq_ptr->setting_up_sema);
 
@@ -2593,7 +2599,7 @@
 	if (!irq_ptr)
 		return -ENODEV;
 
-	if (cdev->private->state != DEV_STATE_QDIO_INIT)
+	if (cdev->private->state != DEV_STATE_ONLINE)
 		return -EINVAL;
 
 	down(&irq_ptr->setting_up_sema);
@@ -2614,7 +2620,7 @@
 
 	spin_lock_irqsave(get_ccwdev_lock(cdev),saveflags);
 
-	ccw_device_set_timeout(cdev, 0);
+	ccw_device_set_timeout(cdev, QDIO_ACTIVATE_TIMEOUT);
 	ccw_device_set_options(cdev, CCWDEV_REPORT_ALL);
 	result=ccw_device_start(cdev,&irq_ptr->ccw,QDIO_DOING_ACTIVATE,
 				0, DOIO_DENY_PREFETCH);
@@ -2637,8 +2643,6 @@
 	if (result)
 		goto out;
 
-	cdev->private->state = DEV_STATE_QDIO_ACTIVE;
-
 	for (i=0;i<irq_ptr->no_input_qs;i++) {
 		if (irq_ptr->is_iqdio_irq) {
 			/* 
@@ -2659,10 +2663,18 @@
 		}
 	}
 
-	qdio_wait_nonbusy(QDIO_ACTIVATE_DELAY);
 
-	qdio_set_state(irq_ptr,QDIO_IRQ_STATE_ACTIVE);
+	wait_event(cdev->private->wait_q,
+		   irq_ptr->state == QDIO_IRQ_STATE_ACTIVE ||
+		   irq_ptr->state == QDIO_IRQ_STATE_ERR ||
+		   irq_ptr->state == QDIO_IRQ_STATE_STOPPED);
 
+	if (irq_ptr->state == QDIO_IRQ_STATE_ACTIVE)
+		result = 0;
+	else {
+		qdio_shutdown(cdev, QDIO_FLAG_CLEANUP_USING_CLEAR);
+		result = -EIO;
+	}
  out:
 	up(&irq_ptr->setting_up_sema);
 
@@ -2810,7 +2822,7 @@
 #ifdef QDIO_DBF_LIKE_HELL
 	char dbf_text[20];
 
-	sprintf(dbf_text,"doQD%04x",irq);
+	sprintf(dbf_text,"doQD%04x",cdev->private->irq);
 	QDIO_DBF_TEXT3(0,trace,dbf_text);
 #endif /* QDIO_DBF_LIKE_HELL */
 
diff -urN linux-2.5.66/drivers/s390/cio/qdio.h linux-2.5.66-s390/drivers/s390/cio/qdio.h
--- linux-2.5.66/drivers/s390/cio/qdio.h	Mon Mar 24 23:00:09 2003
+++ linux-2.5.66-s390/drivers/s390/cio/qdio.h	Wed Mar 26 15:45:16 2003
@@ -1,7 +1,7 @@
 #ifndef _CIO_QDIO_H
 #define _CIO_QDIO_H
 
-#define VERSION_CIO_QDIO_H "$Revision: 1.11 $"
+#define VERSION_CIO_QDIO_H "$Revision: 1.13 $"
 
 //#define QDIO_DBF_LIKE_HELL
 
@@ -48,25 +48,25 @@
 #define QDIO_STATS_CLASSES 2
 #define QDIO_STATS_COUNT_NEEDED 2*/
 
-#define QDIO_ACTIVATE_DELAY 5 /* according to brenton belmar and paul
-				 gioquindo it can take up to 5ms before
-				 queues are really active */
-
 #define QDIO_NO_USE_COUNT_TIME 10
 #define QDIO_NO_USE_COUNT_TIMEOUT 1000 /* wait for 1 sec on each q before
 					  exiting without having use_count
 					  of the queue to 0 */
 
 #define QDIO_ESTABLISH_TIMEOUT 1000
-#define QDIO_ACTIVATE_TIMEOUT 100
+#define QDIO_ACTIVATE_TIMEOUT 100  //FIXME: maybe downsize?
 #define QDIO_CLEANUP_CLEAR_TIMEOUT 20000
 #define QDIO_CLEANUP_HALT_TIMEOUT 10000
 
-#define QDIO_IRQ_STATE_FRESH 0 /* must be 0 -> memset has set it to 0 */
-#define QDIO_IRQ_STATE_INACTIVE 1
-#define QDIO_IRQ_STATE_ESTABLISHED 2
-#define QDIO_IRQ_STATE_ACTIVE 3
-#define QDIO_IRQ_STATE_STOPPED 4
+enum qdio_irq_states {
+	QDIO_IRQ_STATE_INACTIVE,
+	QDIO_IRQ_STATE_ESTABLISHED,
+	QDIO_IRQ_STATE_ACTIVE,
+	QDIO_IRQ_STATE_STOPPED,
+	QDIO_IRQ_STATE_CLEANUP,
+	QDIO_IRQ_STATE_ERR,
+	NR_QDIO_IRQ_STATES,
+};
 
 /* used as intparm in do_IO: */
 #define QDIO_DOING_SENSEID 0
@@ -623,7 +623,7 @@
 	struct tasklet_struct tasklet;
 #endif /* QDIO_USE_TIMERS_FOR_POLLING */
 
-	unsigned int state;
+	enum qdio_irq_states state;
 
 	/* used to store the error condition during a data transfer */
 	unsigned int qdio_error;
@@ -674,7 +674,7 @@
 	unsigned int hydra_gives_outbound_pcis;
 	unsigned int sync_done_on_outb_pcis;
 
-	unsigned int state;
+	enum qdio_irq_states state;
 	struct semaphore setting_up_sema;
 
 	unsigned int no_input_qs;
@@ -694,13 +694,11 @@
 
 	struct qib qib;
 	
-	/* Functions called via the generic cio layer */
-	void (*cleanup_irq) (struct ccw_device *, unsigned long, struct irb *);
-	void (*cleanup_timeout) (struct ccw_device *);
-	void (*establish_irq) (struct ccw_device *, unsigned long,
-			       struct irb *);
-	void (*establish_timeout) (struct ccw_device *);
-	void (*handler) (struct ccw_device *, unsigned long, struct irb *);
+	/* Function called via the generic cio layer */
+	void (*timeout) (struct ccw_device *);
+
+ 	void (*original_int_handler) (struct ccw_device *,
+ 				      unsigned long, struct irb *);
 
 };
 #endif
diff -urN linux-2.5.66/drivers/s390/s390mach.c linux-2.5.66-s390/drivers/s390/s390mach.c
--- linux-2.5.66/drivers/s390/s390mach.c	Mon Mar 24 23:01:48 2003
+++ linux-2.5.66-s390/drivers/s390/s390mach.c	Wed Mar 26 15:45:16 2003
@@ -21,7 +21,7 @@
 
 extern void css_process_crw(int);
 extern void chsc_process_crw(void);
-extern void chp_process_crw(int);
+extern void chp_process_crw(int, int);
 
 static void
 s390_handle_damage(char *msg)
@@ -62,7 +62,17 @@
 			break;
 		case CRW_RSC_CPATH:
 			pr_debug("source is channel path %02X\n", crw.rsid);
-			chp_process_crw(crw.rsid);
+			switch (crw.erc) {
+			case CRW_ERC_IPARM: /* Path has come. */
+				chp_process_crw(crw.rsid, 1);
+				break;
+			case CRW_ERC_PERRI: /* Path has gone. */
+				chp_process_crw(crw.rsid, 0);
+				break;
+			default:
+				pr_debug("Don't know how to handle erc=%x\n",
+					 crw.erc);
+			}
 			break;
 		case CRW_RSC_CONFIG:
 			pr_debug("source is configuration-alert facility\n");

