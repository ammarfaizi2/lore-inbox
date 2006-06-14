Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964944AbWFNOAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbWFNOAU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 10:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964948AbWFNOAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 10:00:20 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:64574 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S964944AbWFNOAR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 10:00:17 -0400
Date: Wed, 14 Jun 2006 16:00:17 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, peter.oberparleiter@de.ibm.com
Subject: [patch 7/24] s390: cio async subchannel reprobe.
Message-ID: <20060614140017.GH9475@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

[S390] cio async subchannel reprobe.

Changes in the DASD driver require an asynchronous implementation of the
subchannel reprobe loop. This loop was so far only used by the blacklisting
mechanism but is now available to all CCW device drivers.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/blacklist.c |   35 -----------------------
 drivers/s390/cio/css.c       |   63 +++++++++++++++++++++++++++++++++++++++++++
 drivers/s390/cio/device.c    |    4 +-
 drivers/s390/cio/device.h    |    6 ++++
 include/asm-s390/cio.h       |    2 +
 5 files changed, 74 insertions(+), 36 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/blacklist.c linux-2.6-patched/drivers/s390/cio/blacklist.c
--- linux-2.6/drivers/s390/cio/blacklist.c	2006-06-14 14:29:18.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/blacklist.c	2006-06-14 14:29:40.000000000 +0200
@@ -224,39 +224,6 @@ is_blacklisted (int ssid, int devno)
 }
 
 #ifdef CONFIG_PROC_FS
-static int
-__s390_redo_validation(struct subchannel_id schid, void *data)
-{
-	int ret;
-	struct subchannel *sch;
-
-	sch = get_subchannel_by_schid(schid);
-	if (sch) {
-		/* Already known. */
-		put_device(&sch->dev);
-		return 0;
-	}
-	ret = css_probe_device(schid);
-	if (ret == -ENXIO)
-		return ret; /* We're through. */
-	if (ret == -ENOMEM)
-		/* Stop validation for now. Bad, but no need for a panic. */
-		return ret;
-	return 0;
-}
-
-/*
- * Function: s390_redo_validation
- * Look for no longer blacklisted devices
- * FIXME: there must be a better way to do this */
-static inline void
-s390_redo_validation (void)
-{
-	CIO_TRACE_EVENT (0, "redoval");
-
-	for_each_subchannel(__s390_redo_validation, NULL);
-}
-
 /*
  * Function: blacklist_parse_proc_parameters
  * parse the stuff which is piped to /proc/cio_ignore
@@ -281,7 +248,7 @@ blacklist_parse_proc_parameters (char *b
 		return;
 	}
 
-	s390_redo_validation ();
+	css_schedule_reprobe();
 }
 
 /* Iterator struct for all devices. */
diff -urpN linux-2.6/drivers/s390/cio/css.c linux-2.6-patched/drivers/s390/cio/css.c
--- linux-2.6/drivers/s390/cio/css.c	2006-06-14 14:29:18.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/css.c	2006-06-14 14:29:40.000000000 +0200
@@ -19,9 +19,11 @@
 #include "cio_debug.h"
 #include "ioasm.h"
 #include "chsc.h"
+#include "device.h"
 
 int need_rescan = 0;
 int css_init_done = 0;
+static int need_reprobe = 0;
 static int max_ssid = 0;
 
 struct channel_subsystem *css[__MAX_CSSID + 1];
@@ -339,6 +341,67 @@ typedef void (*workfunc)(void *);
 DECLARE_WORK(slow_path_work, (workfunc)css_trigger_slow_path, NULL);
 struct workqueue_struct *slow_path_wq;
 
+/* Reprobe subchannel if unregistered. */
+static int reprobe_subchannel(struct subchannel_id schid, void *data)
+{
+	struct subchannel *sch;
+	int ret;
+
+	CIO_DEBUG(KERN_INFO, 6, "cio: reprobe 0.%x.%04x\n",
+		  schid.ssid, schid.sch_no);
+	if (need_reprobe)
+		return -EAGAIN;
+
+	sch = get_subchannel_by_schid(schid);
+	if (sch) {
+		/* Already known. */
+		put_device(&sch->dev);
+		return 0;
+	}
+
+	ret = css_probe_device(schid);
+	switch (ret) {
+	case 0:
+		break;
+	case -ENXIO:
+	case -ENOMEM:
+		/* These should abort looping */
+		break;
+	default:
+		ret = 0;
+	}
+
+	return ret;
+}
+
+/* Work function used to reprobe all unregistered subchannels. */
+static void reprobe_all(void *data)
+{
+	int ret;
+
+	CIO_MSG_EVENT(2, "reprobe start\n");
+
+	need_reprobe = 0;
+	/* Make sure initial subchannel scan is done. */
+	wait_event(ccw_device_init_wq,
+		   atomic_read(&ccw_device_init_count) == 0);
+	ret = for_each_subchannel(reprobe_subchannel, NULL);
+
+	CIO_MSG_EVENT(2, "reprobe done (rc=%d, need_reprobe=%d)\n", ret,
+		      need_reprobe);
+}
+
+DECLARE_WORK(css_reprobe_work, reprobe_all, NULL);
+
+/* Schedule reprobing of all unregistered subchannels. */
+void css_schedule_reprobe(void)
+{
+	need_reprobe = 1;
+	queue_work(ccw_device_work, &css_reprobe_work);
+}
+
+EXPORT_SYMBOL_GPL(css_schedule_reprobe);
+
 /*
  * Rescan for new devices. FIXME: This is slow.
  * This function is called when we have lost CRWs due to overflows and we have
diff -urpN linux-2.6/drivers/s390/cio/device.c linux-2.6-patched/drivers/s390/cio/device.c
--- linux-2.6/drivers/s390/cio/device.c	2006-06-14 14:29:18.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device.c	2006-06-14 14:29:40.000000000 +0200
@@ -133,8 +133,8 @@ struct css_driver io_subchannel_driver =
 
 struct workqueue_struct *ccw_device_work;
 struct workqueue_struct *ccw_device_notify_work;
-static wait_queue_head_t ccw_device_init_wq;
-static atomic_t ccw_device_init_count;
+wait_queue_head_t ccw_device_init_wq;
+atomic_t ccw_device_init_count;
 
 static int __init
 init_ccw_bus_type (void)
diff -urpN linux-2.6/drivers/s390/cio/device.h linux-2.6-patched/drivers/s390/cio/device.h
--- linux-2.6/drivers/s390/cio/device.h	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device.h	2006-06-14 14:29:40.000000000 +0200
@@ -1,6 +1,10 @@
 #ifndef S390_DEVICE_H
 #define S390_DEVICE_H
 
+#include <asm/ccwdev.h>
+#include <asm/atomic.h>
+#include <linux/wait.h>
+
 /*
  * states of the device statemachine
  */
@@ -67,6 +71,8 @@ dev_fsm_final_state(struct ccw_device *c
 
 extern struct workqueue_struct *ccw_device_work;
 extern struct workqueue_struct *ccw_device_notify_work;
+extern wait_queue_head_t ccw_device_init_wq;
+extern atomic_t ccw_device_init_count;
 
 void io_subchannel_recog_done(struct ccw_device *cdev);
 
diff -urpN linux-2.6/include/asm-s390/cio.h linux-2.6-patched/include/asm-s390/cio.h
--- linux-2.6/include/asm-s390/cio.h	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/cio.h	2006-06-14 14:29:40.000000000 +0200
@@ -276,6 +276,8 @@ extern void wait_cons_dev(void);
 
 extern void clear_all_subchannels(void);
 
+extern void css_schedule_reprobe(void);
+
 #endif
 
 #endif
