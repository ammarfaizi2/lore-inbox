Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbTEZROq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 13:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbTEZROa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 13:14:30 -0400
Received: from d12lmsgate.de.ibm.com ([194.196.100.234]:49868 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S261840AbTEZRM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 13:12:58 -0400
Date: Mon, 26 May 2003 19:25:12 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (4/10): steal lock support.
Message-ID: <20030526172512.GE3748@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cio: Add code to break a reservation of a device (steal lock).

diffstat:
 drivers/s390/cio/device.c     |   67 +++++++++++++++++++++++++++++++++++++++++-
 drivers/s390/cio/device.h     |    3 +
 drivers/s390/cio/device_fsm.c |   28 ++++++++++++++++-
 drivers/s390/cio/device_ops.c |   47 +++++++++++++++++++++++++++++
 include/asm-s390/cio.h        |    1 
 5 files changed, 143 insertions(+), 3 deletions(-)

diff -urN linux-2.5/drivers/s390/cio/device.c linux-2.5-s390/drivers/s390/cio/device.c
--- linux-2.5/drivers/s390/cio/device.c	Mon May  5 01:53:36 2003
+++ linux-2.5-s390/drivers/s390/cio/device.c	Mon May 26 19:20:44 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/device.c
  *  bus driver for ccw devices
- *   $Revision: 1.53 $
+ *   $Revision: 1.54 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
@@ -316,11 +316,63 @@
 	return count;
 }
 
+static void ccw_device_unbox_recog(void *data);
+
+static ssize_t
+stlck_store(struct device *dev, const char *buf, size_t count)
+{
+	struct ccw_device *cdev = to_ccwdev(dev);
+	int ret;
+
+	/* We don't care what was piped to the attribute 8) */
+	ret = ccw_device_stlck(cdev);
+	if (ret != 0) {
+		printk(KERN_WARNING
+		       "Unconditional reserve failed on device %s, rc=%d\n",
+		       dev->bus_id, ret);
+		return ret;
+	}
+
+	/*
+	 * Device was successfully unboxed.
+	 * Trigger removal of stlck attribute and device recognition.
+	 */
+	INIT_WORK(&cdev->private->kick_work,
+		  ccw_device_unbox_recog, (void *) cdev);
+	queue_work(ccw_device_work, &cdev->private->kick_work);
+	
+	return 0;
+}
+
 static DEVICE_ATTR(chpids, 0444, chpids_show, NULL);
 static DEVICE_ATTR(pimpampom, 0444, pimpampom_show, NULL);
 static DEVICE_ATTR(devtype, 0444, devtype_show, NULL);
 static DEVICE_ATTR(cutype, 0444, cutype_show, NULL);
 static DEVICE_ATTR(online, 0644, online_show, online_store);
+static DEVICE_ATTR(steal_lock, 0200, NULL, stlck_store);
+
+/* A device has been unboxed. Start device recognition. */
+static void
+ccw_device_unbox_recog(void *data)
+{
+	struct ccw_device *cdev;
+
+	cdev = (struct ccw_device *)data;
+	if (!cdev)
+		return;
+
+	/* Remove stlck attribute. */
+	device_remove_file(&cdev->dev, &dev_attr_steal_lock);
+
+	spin_lock_irq(cdev->ccwlock);
+
+	/* Device is no longer boxed. */
+	cdev->private->state = DEV_STATE_NOT_OPER;
+
+	/* Finally start device recognition. */
+	ccw_device_recognition(cdev);
+	spin_unlock_irq(cdev->ccwlock);
+}
 
 static inline int
 subchannel_add_files (struct device *dev)
@@ -348,6 +400,19 @@
 	return ret;
 }
 
+/*
+ * Add a "steal lock" attribute to boxed devices.
+ * This allows to trigger an unconditional reserve ccw to eckd dasds
+ * (if the device is something else, there should be no problems more than
+ * a command reject; we don't have any means of finding out the device's
+ * type if it was boxed at ipl/attach).
+ */
+void
+ccw_device_add_stlck(struct ccw_device *cdev)
+{
+	device_create_file(&cdev->dev, &dev_attr_steal_lock);
+}
+
 /* this is a simple abstraction for device_register that sets the
  * correct bus type and adds the bus specific files */
 static int
diff -urN linux-2.5/drivers/s390/cio/device.h linux-2.5-s390/drivers/s390/cio/device.h
--- linux-2.5/drivers/s390/cio/device.h	Mon May  5 01:53:37 2003
+++ linux-2.5-s390/drivers/s390/cio/device.h	Mon May 26 19:20:44 2003
@@ -95,6 +95,9 @@
 
 void ccw_device_call_handler(struct ccw_device *);
 
+void ccw_device_add_stlck(struct ccw_device *);
+int ccw_device_stlck(struct ccw_device *);
+
 /* qdio needs this. */
 void ccw_device_set_timeout(struct ccw_device *, int);
 #endif
diff -urN linux-2.5/drivers/s390/cio/device_fsm.c linux-2.5-s390/drivers/s390/cio/device_fsm.c
--- linux-2.5/drivers/s390/cio/device_fsm.c	Mon May  5 01:53:31 2003
+++ linux-2.5-s390/drivers/s390/cio/device_fsm.c	Mon May 26 19:20:44 2003
@@ -132,6 +132,7 @@
 		CIO_DEBUG(KERN_WARNING, 2,
 			  "SenseID : boxed device %04X on subchannel %04X\n",
 			  sch->schib.pmcw.dev, sch->irq);
+		ccw_device_add_stlck(cdev);
 		break;
 	}
 	io_subchannel_recog_done(cdev);
@@ -588,6 +589,29 @@
 			      ERR_PTR(-ETIMEDOUT));
 }
 
+static void
+ccw_device_stlck_done(struct ccw_device *cdev, enum dev_event dev_event)
+{
+	struct irb *irb;
+
+	switch (dev_event) {
+	case DEV_EVENT_INTERRUPT:
+		irb = (struct irb *) __LC_IRB;
+		/* Check for unsolicited interrupt. */
+		if (irb->scsw.stctl ==
+		    (SCSW_STCTL_STATUS_PEND | SCSW_STCTL_ALERT_STATUS))
+			goto out_wakeup;
+
+		ccw_device_accumulate_irb(cdev, irb);
+		/* We don't care about basic sense etc. */
+		break;
+	default: /* timeout */
+		break;
+	}
+out_wakeup:
+	wake_up(&cdev->private->wait_q);
+}
+
 /*
  * No operation action. This is used e.g. to ignore a timeout event in
  * state offline.
@@ -662,8 +686,8 @@
 	},
 	[DEV_STATE_BOXED] {
 		[DEV_EVENT_NOTOPER]	ccw_device_offline_notoper,
-		[DEV_EVENT_INTERRUPT]	ccw_device_bug,
-		[DEV_EVENT_TIMEOUT]	ccw_device_nop,
+		[DEV_EVENT_INTERRUPT]	ccw_device_stlck_done,
+		[DEV_EVENT_TIMEOUT]	ccw_device_stlck_done,
 		[DEV_EVENT_VERIFY]	ccw_device_nop,
 	},
 	/* states to wait for i/o completion before doing something */
diff -urN linux-2.5/drivers/s390/cio/device_ops.c linux-2.5-s390/drivers/s390/cio/device_ops.c
--- linux-2.5/drivers/s390/cio/device_ops.c	Mon May  5 01:53:36 2003
+++ linux-2.5-s390/drivers/s390/cio/device_ops.c	Mon May 26 19:20:44 2003
@@ -6,6 +6,7 @@
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
  *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
+ *               Cornelia Huck (cohuck@de.ibm.com)
  */
 #include <linux/config.h>
 #include <linux/module.h>
@@ -378,6 +379,52 @@
 
 	return ret;
 }
+
+/*
+ * Try to issue an unconditional reserve on a boxed device.
+ */
+int
+ccw_device_stlck(struct ccw_device *cdev)
+{
+	char buf[32];
+	unsigned long flags;
+	struct subchannel *sch;
+	int ret;
+
+	if (!cdev)
+		return -ENODEV;
+
+	sch = to_subchannel(cdev->dev.parent);
+	
+	CIO_TRACE_EVENT(2, "stl lock");
+	CIO_TRACE_EVENT(2, cdev->dev.bus_id);
+
+	/* Setup ccw. This cmd code seems not to be in use elsewhere. */
+	cdev->private->iccws[0].cmd_code = CCW_CMD_STLCK;
+	cdev->private->iccws[0].cda = (__u32) __pa(buf);
+	cdev->private->iccws[0].count = 32;
+	cdev->private->iccws[0].flags = CCW_FLAG_SLI;
+
+	spin_lock_irqsave(&sch->lock, flags);
+	ret = cio_start(sch, cdev->private->iccws, 0xE2D3C3D2, 0);
+	spin_unlock_irqrestore(&sch->lock, flags);
+	if (ret)
+		return ret;
+
+	wait_event(cdev->private->wait_q, sch->schib.scsw.actl == 0);
+	spin_lock_irqsave(&sch->lock, flags);
+
+	if ((cdev->private->irb.scsw.dstat !=
+	     (DEV_STAT_CHN_END|DEV_STAT_DEV_END)) ||
+	    (cdev->private->irb.scsw.cstat != 0))
+		ret = -EIO;
+
+	/* Clear irb. */
+	memset(&cdev->private->irb, 0, sizeof(struct irb));
+	spin_unlock_irqrestore(&sch->lock, flags);
+
+	return ret;
+}
 
 // FIXME: these have to go:
 
diff -urN linux-2.5/include/asm-s390/cio.h linux-2.5-s390/include/asm-s390/cio.h
--- linux-2.5/include/asm-s390/cio.h	Mon May  5 01:53:41 2003
+++ linux-2.5-s390/include/asm-s390/cio.h	Mon May 26 19:20:44 2003
@@ -128,6 +128,7 @@
 #define CCW_CMD_NOOP		0x03
 #define CCW_CMD_BASIC_SENSE	0x04
 #define CCW_CMD_TIC		0x08
+#define CCW_CMD_STLCK           0x14
 #define CCW_CMD_SENSE_PGID	0x34
 #define CCW_CMD_SUSPEND_RECONN	0x5B
 #define CCW_CMD_RDC		0x64
