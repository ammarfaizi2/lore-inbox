Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbTH2ROR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 13:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbTH2RNC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 13:13:02 -0400
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:25831 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S261451AbTH2RKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 13:10:34 -0400
Date: Fri, 29 Aug 2003 19:10:05 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (5/8): common i/o layer.
Message-ID: <20030829171005.GF1242@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Remove initialization of device.name.
- Don't do put_device after failed get_device in get_ccwdev_by_busid.
- Fix read_dev_chars and read_conf_data.
- Call interrupt function of ccw device if path verification has been started.
- Replace atomic_return_add by atomic_add_return in qdio.

diffstat:
 drivers/s390/cio/chsc.c       |    6 +-----
 drivers/s390/cio/css.c        |   17 ++---------------
 drivers/s390/cio/device.c     |    9 +++++----
 drivers/s390/cio/device_ops.c |   37 ++++++++++++++++++++++++-------------
 drivers/s390/cio/qdio.c       |   23 ++++++-----------------
 5 files changed, 38 insertions(+), 54 deletions(-)

diff -urN linux-2.6/drivers/s390/cio/chsc.c linux-2.6-s390/drivers/s390/cio/chsc.c
--- linux-2.6/drivers/s390/cio/chsc.c	Sat Aug 23 01:56:32 2003
+++ linux-2.6-s390/drivers/s390/cio/chsc.c	Fri Aug 29 18:55:10 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/chsc.c
  *   S/390 common I/O routines -- channel subsystem call
- *   $Revision: 1.74 $
+ *   $Revision: 1.76 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -865,10 +865,6 @@
 	chp->state = status;
 	chp->dev.parent = &css_bus_device;
 
-	snprintf(chp->dev.name, DEVICE_NAME_SIZE,
-		 "channel path %x", chpid);
-	snprintf(chp->dev.bus_id, DEVICE_ID_SIZE, "chp%x", chpid);
-
 	/* make it known to the system */
 	ret = device_register(&chp->dev);
 	if (ret) {
diff -urN linux-2.6/drivers/s390/cio/css.c linux-2.6-s390/drivers/s390/cio/css.c
--- linux-2.6/drivers/s390/cio/css.c	Sat Aug 23 01:52:24 2003
+++ linux-2.6-s390/drivers/s390/cio/css.c	Fri Aug 29 18:55:10 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/css.c
  *  driver for channel subsystem
- *   $Revision: 1.43 $
+ *   $Revision: 1.48 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
@@ -27,7 +27,6 @@
 int css_init_done = 0;
 
 struct device css_bus_device = {
-	.name	= "Channel Subsystem 0",
 	.bus_id = "css0",
 };
 
@@ -79,17 +78,6 @@
 static int
 css_register_subchannel(struct subchannel *sch)
 {
-	static const char *subchannel_types[] = {
-		"I/O Subchannel",
-		"CHSC Subchannel",
-		"Message Subchannel",
-		"ADM Subchannel",
-		"undefined subchannel type 4",
-		"undefined subchannel type 5",
-		"undefined subchannel type 6",
-		"undefined subchannel type 7",
-		"undefined subchannel type 8",
-	};
 	int ret;
 
 	/* Initialize the subchannel structure */
@@ -97,8 +85,7 @@
 	sch->dev.bus = &css_bus_type;
 
 	/* Set a name for the subchannel */
-	strlcpy (sch->dev.name, subchannel_types[sch->st], DEVICE_NAME_SIZE);
-	snprintf (sch->dev.bus_id, DEVICE_ID_SIZE, "0:%04x", sch->irq);
+	snprintf (sch->dev.bus_id, DEVICE_ID_SIZE, "0.0.%04x", sch->irq);
 
 	/* make it known to the system */
 	ret = device_register(&sch->dev);
diff -urN linux-2.6/drivers/s390/cio/device.c linux-2.6-s390/drivers/s390/cio/device.c
--- linux-2.6/drivers/s390/cio/device.c	Sat Aug 23 01:58:10 2003
+++ linux-2.6-s390/drivers/s390/cio/device.c	Fri Aug 29 18:55:10 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/device.c
  *  bus driver for ccw devices
- *   $Revision: 1.60 $
+ *   $Revision: 1.65 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
@@ -537,8 +537,7 @@
 	init_timer(&cdev->private->timer);
 
 	/* Set an initial name for the device. */
-	snprintf (cdev->dev.name, DEVICE_NAME_SIZE,"ccw device");
-	snprintf (cdev->dev.bus_id, DEVICE_ID_SIZE, "0:%04x",
+	snprintf (cdev->dev.bus_id, DEVICE_ID_SIZE, "0.0.%04x",
 		  sch->schib.pmcw.dev);
 
 	/* Increase counter of devices currently in recognition. */
@@ -704,8 +703,10 @@
 
 		if (dev && !strncmp(bus_id, dev->bus_id, DEVICE_ID_SIZE))
 			break;
-		else
+		else if (dev) {
 			put_device(dev);
+			dev = NULL;
+		}
 	}
 	up_read(&drv->bus->subsys.rwsem);
 	put_driver(drv);
diff -urN linux-2.6/drivers/s390/cio/device_ops.c linux-2.6-s390/drivers/s390/cio/device_ops.c
--- linux-2.6/drivers/s390/cio/device_ops.c	Sat Aug 23 01:58:10 2003
+++ linux-2.6-s390/drivers/s390/cio/device_ops.c	Fri Aug 29 18:55:10 2003
@@ -160,13 +160,15 @@
 	 *  - we received an intermediate status
 	 *  - fast notification was requested (primary status)
 	 *  - unsolicited interrupts
+	 *  - device path verification has been started
 	 */
 	stctl = cdev->private->irb.scsw.stctl;
 	if (sch->schib.scsw.actl != 0 &&
 	    !cdev->private->options.repall &&
 	    !(stctl & SCSW_STCTL_INTER_STATUS) &&
 	    !(cdev->private->options.fast &&
-	      (stctl & SCSW_STCTL_PRIM_STATUS)))
+	      (stctl & SCSW_STCTL_PRIM_STATUS)) &&
+	    (cdev->private->state != DEV_STATE_VERIFY))
 		return;
 
 	/*
@@ -211,11 +213,19 @@
 static void
 ccw_device_wake_up(struct ccw_device *cdev, unsigned long ip, struct irb *irb)
 {
-	struct subchannel *sch;
+	if (!ip)
+		/* unsolicited interrupt */
+		return;
 
-	sch = to_subchannel(cdev->dev.parent);
-	if (!IS_ERR(irb))
-		memcpy(&sch->schib.scsw, &irb->scsw, sizeof(struct scsw));
+	/* Abuse intparm for error reporting. */
+	if (IS_ERR(irb))
+		cdev->private->intparm = -EIO;
+	else if ((irb->scsw.dstat !=
+		  (DEV_STAT_CHN_END|DEV_STAT_DEV_END)) ||
+		 (irb->scsw.cstat != 0))
+		cdev->private->intparm = -EIO;
+	else
+		cdev->private->intparm = 0;
 	wake_up(&cdev->private->wait_q);
 }
 
@@ -270,14 +280,14 @@
 			break;
 		if (ret == 0) {
 			/* Wait for end of request. */
+			cdev->private->intparm = 0x00524443;
 			spin_unlock_irqrestore(&sch->lock, flags);
 			wait_event(cdev->private->wait_q,
-				   sch->schib.scsw.actl == 0);
+				   (cdev->private->intparm == -EIO) ||
+				   (cdev->private->intparm == 0));
 			spin_lock_irqsave(&sch->lock, flags);
 			/* Check at least for channel end / device end */
-			if ((sch->schib.scsw.dstat !=
-			     (DEV_STAT_CHN_END|DEV_STAT_DEV_END)) ||
-			    (sch->schib.scsw.cstat != 0)) {
+			if (cdev->private->intparm) {
 				ret = -EIO;
 				continue;
 			}
@@ -350,13 +360,14 @@
 		if (ret)
 			continue;
 		/* Wait for end of request. */
+		cdev->private->intparm = 0x00524344; 
 		spin_unlock_irqrestore(&sch->lock, flags);
-		wait_event(cdev->private->wait_q, sch->schib.scsw.actl == 0);
+		wait_event(cdev->private->wait_q,
+			   (cdev->private->intparm == -EIO) ||
+			   (cdev->private->intparm == 0));
 		spin_lock_irqsave(&sch->lock, flags);
 		/* Check at least for channel end / device end */
-		if ((sch->schib.scsw.dstat != 
-		     (DEV_STAT_CHN_END|DEV_STAT_DEV_END)) ||
-		    (sch->schib.scsw.cstat != 0)) {
+		if (cdev->private->intparm) {
 			ret = -EIO;
 			continue;
 		}
diff -urN linux-2.6/drivers/s390/cio/qdio.c linux-2.6-s390/drivers/s390/cio/qdio.c
--- linux-2.6/drivers/s390/cio/qdio.c	Sat Aug 23 01:57:09 2003
+++ linux-2.6-s390/drivers/s390/cio/qdio.c	Fri Aug 29 18:55:10 2003
@@ -55,7 +55,7 @@
 #include "ioasm.h"
 #include "chsc.h"
 
-#define VERSION_QDIO_C "$Revision: 1.55 $"
+#define VERSION_QDIO_C "$Revision: 1.58 $"
 
 /****************** MODULE PARAMETER VARIABLES ********************/
 MODULE_AUTHOR("Utz Bacher <utz.bacher@de.ibm.com>");
@@ -120,15 +120,7 @@
 static inline unsigned long 
 qdio_get_millis(void)
 {
-	return (unsigned long)(qdio_get_micros()>>12);
-}
-
-static __inline__ int 
-atomic_return_add (int i, atomic_t *v)
-{
-	int old, new;
-	__CS_LOOP(old, new, v, i, "ar");
-	return old;
+	return (unsigned long)(qdio_get_micros()>>10);
 }
 
 static void 
@@ -181,7 +173,7 @@
 static inline int 
 qdio_reserve_q(struct qdio_q *q)
 {
-	return atomic_return_add(1,&q->use_count);
+	return atomic_add_return(1,&q->use_count) - 1;
 }
 
 static inline void 
@@ -1221,21 +1213,18 @@
 qdio_release_irq_memory(struct qdio_irq *irq_ptr)
 {
 	int i;
-	int available;
 
 	for (i=0;i<QDIO_MAX_QUEUES_PER_IRQ;i++) {
 		if (!irq_ptr->input_qs[i])
 			goto next;
-		available=0;
 
 		if (irq_ptr->input_qs[i]->slib)
 			kfree(irq_ptr->input_qs[i]->slib);
-			kfree(irq_ptr->input_qs[i]);
+		kfree(irq_ptr->input_qs[i]);
 
 next:
 		if (!irq_ptr->output_qs[i])
 			continue;
-		available=0;
 
 		if (irq_ptr->output_qs[i]->slib)
 			kfree(irq_ptr->output_qs[i]->slib);
@@ -2855,7 +2844,7 @@
 	int used_elements;
 
         /* This is the inbound handling of queues */
-	used_elements=atomic_return_add(count, &q->number_of_buffers_used);
+	used_elements=atomic_add_return(count, &q->number_of_buffers_used) - count;
 	
 	qdio_do_qdio_fill_input(q,qidx,count,buffers);
 	
@@ -2897,7 +2886,7 @@
 
 	qdio_do_qdio_fill_output(q,qidx,count,buffers);
 
-	used_elements=atomic_return_add(count, &q->number_of_buffers_used);
+	used_elements=atomic_add_return(count, &q->number_of_buffers_used) - count;
 
 	if (callflags&QDIO_FLAG_DONT_SIGA) {
 #ifdef QDIO_PERFORMANCE_STATS
