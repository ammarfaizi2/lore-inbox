Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbTJFJ0O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 05:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263978AbTJFJ0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 05:26:13 -0400
Received: from d12lmsgate.de.ibm.com ([194.196.100.234]:25051 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S262802AbTJFJZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 05:25:32 -0400
Date: Mon, 6 Oct 2003 11:24:48 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (2/7): common i/o layer.
Message-ID: <20031006092448.GC1786@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - Remove atomic_read hack to test for presence of ccw device directory.
 - Add dummy release function to channel path object and cu3088 group devices.
 - Don't rely on the chaining bit of the channel report word. 
 - Don't call schedule while holding a lock in read_dev_chars/read_conf_data.

diffstat:
 drivers/s390/cio/ccwgroup.c   |    9 +++------
 drivers/s390/cio/chsc.c       |   14 +++++++++++---
 drivers/s390/cio/device_ops.c |   25 +++++++++++++------------
 drivers/s390/cio/qdio.c       |    8 +++-----
 drivers/s390/net/cu3088.c     |    8 +++++++-
 drivers/s390/s390mach.c       |    4 ++--
 6 files changed, 39 insertions(+), 29 deletions(-)

diff -urN linux-2.6/drivers/s390/cio/ccwgroup.c linux-2.6-s390/drivers/s390/cio/ccwgroup.c
--- linux-2.6/drivers/s390/cio/ccwgroup.c	Sun Sep 28 02:50:26 2003
+++ linux-2.6-s390/drivers/s390/cio/ccwgroup.c	Mon Oct  6 10:59:18 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/ccwgroup.c
  *  bus driver for ccwgroup
- *   $Revision: 1.15 $
+ *   $Revision: 1.17 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *                       IBM Corporation
@@ -67,10 +67,7 @@
 	for (i = 0; i < gdev->count; i++) {
 		sprintf(str, "cdev%d", i);
 		sysfs_remove_link(&gdev->dev.kobj, str);
-		/* Hack: Make sure we act on still valid subdirs. */
-		if (atomic_read(&gdev->cdev[i]->dev.kobj.dentry->d_count))
-			sysfs_remove_link(&gdev->cdev[i]->dev.kobj,
-					  "group_device");
+		sysfs_remove_link(&gdev->cdev[i]->dev.kobj, "group_device");
 	}
 	
 }
@@ -187,7 +184,7 @@
 		.dev = {
 			.bus = &ccwgroup_bus_type,
 			.parent = root,
-			.release = &ccwgroup_release,
+			.release = ccwgroup_release,
 		},
 	};
 
diff -urN linux-2.6/drivers/s390/cio/chsc.c linux-2.6-s390/drivers/s390/cio/chsc.c
--- linux-2.6/drivers/s390/cio/chsc.c	Sun Sep 28 02:50:26 2003
+++ linux-2.6-s390/drivers/s390/cio/chsc.c	Mon Oct  6 10:59:18 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/chsc.c
  *   S/390 common I/O routines -- channel subsystem call
- *   $Revision: 1.77 $
+ *   $Revision: 1.78 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -843,6 +843,12 @@
 
 static DEVICE_ATTR(status, 0644, chp_status_show, chp_status_write);
 
+
+static void
+chp_release(struct device *dev)
+{
+}
+
 /*
  * Entries for chpids on the system bus.
  * This replaces /proc/chpids.
@@ -863,8 +869,10 @@
 	/* fill in status, etc. */
 	chp->id = chpid;
 	chp->state = status;
-	chp->dev.parent = &css_bus_device;
-
+	chp->dev = (struct device) {
+		.parent  = &css_bus_device,
+		.release = chp_release,
+	};
 	snprintf(chp->dev.bus_id, BUS_ID_SIZE, "chp0.%x", chpid);
 
 	/* make it known to the system */
diff -urN linux-2.6/drivers/s390/cio/device_ops.c linux-2.6-s390/drivers/s390/cio/device_ops.c
--- linux-2.6/drivers/s390/cio/device_ops.c	Sun Sep 28 02:50:38 2003
+++ linux-2.6-s390/drivers/s390/cio/device_ops.c	Mon Oct  6 10:59:18 2003
@@ -244,8 +244,7 @@
 }
 
 static inline int
-__ccw_device_retry_loop(struct ccw_device *cdev, struct ccw1 *ccw, long magic,
-			unsigned long flags)
+__ccw_device_retry_loop(struct ccw_device *cdev, struct ccw1 *ccw, long magic)
 {
 	int ret;
 	struct subchannel *sch;
@@ -255,7 +254,9 @@
 		ret = cio_start (sch, ccw, magic, 0);
 		if ((ret == -EBUSY) || (ret == -EACCES)) {
 			/* Try again later. */
+			spin_unlock_irq(&sch->lock);
 			schedule_timeout(1);
+			spin_lock_irq(&sch->lock);
 			continue;
 		}
 		if (ret != 0)
@@ -263,12 +264,12 @@
 			break;
 		/* Wait for end of request. */
 		cdev->private->intparm = magic;
-		spin_unlock_irqrestore(&sch->lock, flags);
+		spin_unlock_irq(&sch->lock);
 		wait_event(cdev->private->wait_q,
 			   (cdev->private->intparm == -EIO) ||
 			   (cdev->private->intparm == -EAGAIN) ||
 			   (cdev->private->intparm == 0));
-		spin_lock_irqsave(&sch->lock, flags);
+		spin_lock_irq(&sch->lock);
 		/* Check at least for channel end / device end */
 		if (cdev->private->intparm == -EIO) {
 			/* Non-retryable error. */
@@ -279,7 +280,9 @@
 			/* Success. */
 			break;
 		/* Try again later. */
+		spin_unlock_irq(&sch->lock);
 		schedule_timeout(1);
+		spin_lock_irq(&sch->lock);
 	} while (1);
 
 	return ret;
@@ -300,7 +303,6 @@
 {
 	void (*handler)(struct ccw_device *, unsigned long, struct irb *);
 	char dbf_txt[15];
-	unsigned long flags;
 	struct subchannel *sch;
 	int ret;
 	struct ccw1 *rdc_ccw;
@@ -327,7 +329,7 @@
 		return ret;
 	}
 
-	spin_lock_irqsave(&sch->lock, flags);
+	spin_lock_irq(&sch->lock);
 	/* Save interrupt handler. */
 	handler = cdev->handler;
 	/* Temporarily install own handler. */
@@ -338,11 +340,11 @@
 		ret = -EBUSY;
 	else
 		/* 0x00D9C4C3 == ebcdic "RDC" */
-		ret = __ccw_device_retry_loop(cdev, rdc_ccw, 0x00D9C4C3, flags);
+		ret = __ccw_device_retry_loop(cdev, rdc_ccw, 0x00D9C4C3);
 
 	/* Restore interrupt handler. */
 	cdev->handler = handler;
-	spin_unlock_irqrestore(&sch->lock, flags);
+	spin_unlock_irq(&sch->lock);
 
 	clear_normalized_cda (rdc_ccw);
 	kfree(rdc_ccw);
@@ -360,7 +362,6 @@
 	char dbf_txt[15];
 	struct subchannel *sch;
 	struct ciw *ciw;
-	unsigned long flags;
 	char *rcd_buf;
 	int ret;
 	struct ccw1 *rcd_ccw;
@@ -396,7 +397,7 @@
 	rcd_ccw->count = ciw->count;
 	rcd_ccw->flags = CCW_FLAG_SLI;
 
-	spin_lock_irqsave(&sch->lock, flags);
+	spin_lock_irq(&sch->lock);
 	/* Save interrupt handler. */
 	handler = cdev->handler;
 	/* Temporarily install own handler. */
@@ -407,11 +408,11 @@
 		ret = -EBUSY;
 	else
 		/* 0x00D9C3C4 == ebcdic "RCD" */
-		ret = __ccw_device_retry_loop(cdev, rcd_ccw, 0x00D9C3C4, flags);
+		ret = __ccw_device_retry_loop(cdev, rcd_ccw, 0x00D9C3C4);
 
 	/* Restore interrupt handler. */
 	cdev->handler = handler;
-	spin_unlock_irqrestore(&sch->lock, flags);
+	spin_unlock_irq(&sch->lock);
 
  	/*
  	 * on success we update the user input parms
diff -urN linux-2.6/drivers/s390/cio/qdio.c linux-2.6-s390/drivers/s390/cio/qdio.c
--- linux-2.6/drivers/s390/cio/qdio.c	Sun Sep 28 02:50:30 2003
+++ linux-2.6-s390/drivers/s390/cio/qdio.c	Mon Oct  6 10:59:18 2003
@@ -43,6 +43,7 @@
 #include <asm/io.h>
 #include <asm/atomic.h>
 #include <asm/semaphore.h>
+#include <asm/timex.h>
 
 #include <asm/debug.h>
 #include <asm/qdio.h>
@@ -55,7 +56,7 @@
 #include "ioasm.h"
 #include "chsc.h"
 
-#define VERSION_QDIO_C "$Revision: 1.61 $"
+#define VERSION_QDIO_C "$Revision: 1.62 $"
 
 /****************** MODULE PARAMETER VARIABLES ********************/
 MODULE_AUTHOR("Utz Bacher <utz.bacher@de.ibm.com>");
@@ -112,10 +113,7 @@
 static inline volatile __u64 
 qdio_get_micros(void)
 {
-        __u64 time;
-
-        asm volatile ("STCK %0" : "=m" (time));
-        return time>>12; /* time>>12 is microseconds*/
+        return (get_clock() >> 12); /* time>>12 is microseconds */
 }
 
 /* 
diff -urN linux-2.6/drivers/s390/net/cu3088.c linux-2.6-s390/drivers/s390/net/cu3088.c
--- linux-2.6/drivers/s390/net/cu3088.c	Sun Sep 28 02:50:15 2003
+++ linux-2.6-s390/drivers/s390/net/cu3088.c	Mon Oct  6 10:59:18 2003
@@ -1,5 +1,5 @@
 /*
- * $Id: cu3088.c,v 1.30 2003/08/28 11:14:11 cohuck Exp $
+ * $Id: cu3088.c,v 1.31 2003/09/29 15:24:27 cohuck Exp $
  *
  * CTC / LCS ccw_device driver
  *
@@ -55,8 +55,14 @@
 
 static struct ccw_driver cu3088_driver;
 
+static void
+cu3088_root_dev_release (struct device *dev)
+{
+}
+
 struct device cu3088_root_dev = {
 	.bus_id = "cu3088",
+	.release = cu3088_root_dev_release,
 };
 
 static ssize_t
diff -urN linux-2.6/drivers/s390/s390mach.c linux-2.6-s390/drivers/s390/s390mach.c
--- linux-2.6/drivers/s390/s390mach.c	Sun Sep 28 02:51:15 2003
+++ linux-2.6-s390/drivers/s390/s390mach.c	Mon Oct  6 10:59:18 2003
@@ -44,7 +44,7 @@
 	struct crw crw;
 	int ccode;
 
-	do {
+	while (1) {
 		ccode = stcrw(&crw);
 		if (ccode != 0)
 			break;
@@ -85,7 +85,7 @@
 			pr_debug("unknown source\n");
 			break;
 		}
-	} while (crw.chn);
+	}
 }
 
 /*
