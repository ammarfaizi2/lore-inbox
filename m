Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbUFBK6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbUFBK6V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 06:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbUFBK6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 06:58:20 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:37770 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S261745AbUFBKwl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 06:52:41 -0400
Date: Wed, 2 Jun 2004 12:52:44 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (2/4): common i/o layer.
Message-ID: <20040602105244.GC7108@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: common i/o layer.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Common i/o layer changes:
 - qdio: Lose the adapter lock for thin interrupts to improve performance
   and do unregister of the adapter interrupt handler with rcu.
 - ccwgroup: Fix error handling when creating a ccwgroup device.
 - Convert the slow crw kernel thread to a single threaded workqueue.
 - Use the slow crw workqueue to unregister a subchannel after it was
   found not operational to serialize it with other possible unregister/
   register events coming in via machine checks.
 - Trigger a rescan of the css via the slow path if a missing channel path
   is found in __recover_lost_chpids.
 - Use saner default levels for the debug feature, add some debugging code.
 - Remove request_irq and free_irq stubs.
 - Remove bogus inlines.

diffstat:
 drivers/s390/cio/airq.c       |   38 +++++----------------
 drivers/s390/cio/ccwgroup.c   |   24 ++++++++-----
 drivers/s390/cio/chsc.c       |   39 +++++++++++----------
 drivers/s390/cio/cio.c        |    8 ++--
 drivers/s390/cio/css.c        |   75 +++++++++++++++++++++---------------------
 drivers/s390/cio/css.h        |    4 +-
 drivers/s390/cio/device.c     |   15 +++++---
 drivers/s390/cio/device_fsm.c |   14 -------
 drivers/s390/cio/requestirq.c |   17 ---------
 drivers/s390/s390mach.c       |   25 ++------------
 10 files changed, 109 insertions(+), 150 deletions(-)

diff -urN linux-2.6/drivers/s390/cio/airq.c linux-2.6-s390/drivers/s390/cio/airq.c
--- linux-2.6/drivers/s390/cio/airq.c	Mon May 10 04:33:10 2004
+++ linux-2.6-s390/drivers/s390/cio/airq.c	Wed Jun  2 11:29:35 2004
@@ -2,7 +2,7 @@
  *  drivers/s390/cio/airq.c
  *   S/390 common I/O routines -- support for adapter interruptions
  *
- *   $Revision: 1.11 $
+ *   $Revision: 1.12 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -14,11 +14,11 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/rcupdate.h>
 
 #include "cio_debug.h"
 #include "airq.h"
 
-static spinlock_t adapter_lock = SPIN_LOCK_UNLOCKED;
 static adapter_int_handler_t adapter_handler;
 
 /*
@@ -40,23 +40,17 @@
 
 	CIO_TRACE_EVENT (4, "rgaint");
 
-	spin_lock (&adapter_lock);
-
 	if (handler == NULL)
 		ret = -EINVAL;
-	else if (adapter_handler)
-		ret = -EBUSY;
-	else {
-		adapter_handler = handler;
-		ret = 0;
-	}
-
-	spin_unlock (&adapter_lock);
+	else
+		ret = (cmpxchg(&adapter_handler, NULL, handler) ? -EBUSY : 0);
+	if (!ret)
+		synchronize_kernel();
 
 	sprintf (dbf_txt, "ret:%d", ret);
 	CIO_TRACE_EVENT (4, dbf_txt);
 
-	return (ret);
+	return ret;
 }
 
 int
@@ -67,38 +61,26 @@
 
 	CIO_TRACE_EVENT (4, "urgaint");
 
-	spin_lock (&adapter_lock);
-
 	if (handler == NULL)
 		ret = -EINVAL;
-	else if (handler != adapter_handler)
-		ret = -EINVAL;
 	else {
 		adapter_handler = NULL;
+		synchronize_kernel();
 		ret = 0;
 	}
-
-	spin_unlock (&adapter_lock);
-
 	sprintf (dbf_txt, "ret:%d", ret);
 	CIO_TRACE_EVENT (4, dbf_txt);
 
-	return (ret);
+	return ret;
 }
 
 void
 do_adapter_IO (void)
 {
-	CIO_TRACE_EVENT (4, "doaio");
-
-	spin_lock (&adapter_lock);
+	CIO_TRACE_EVENT (6, "doaio");
 
 	if (adapter_handler)
 		(*adapter_handler) ();
-
-	spin_unlock (&adapter_lock);
-
-	return;
 }
 
 EXPORT_SYMBOL (s390_register_adapter_interrupt);
diff -urN linux-2.6/drivers/s390/cio/ccwgroup.c linux-2.6-s390/drivers/s390/cio/ccwgroup.c
--- linux-2.6/drivers/s390/cio/ccwgroup.c	Mon May 10 04:32:38 2004
+++ linux-2.6-s390/drivers/s390/cio/ccwgroup.c	Wed Jun  2 11:29:35 2004
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/ccwgroup.c
  *  bus driver for ccwgroup
- *   $Revision: 1.27 $
+ *   $Revision: 1.28 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *                       IBM Corporation
@@ -179,12 +179,12 @@
 		    || gdev->cdev[i]->id.driver_info !=
 		    gdev->cdev[0]->id.driver_info) {
 			rc = -EINVAL;
-			goto error;
+			goto free_dev;
 		}
 		/* Don't allow a device to belong to more than one group. */
 		if (gdev->cdev[i]->dev.driver_data) {
 			rc = -EINVAL;
-			goto error;
+			goto free_dev;
 		}
 	}
 	for (i = 0; i < argc; i++)
@@ -207,8 +207,8 @@
 	rc = device_register(&gdev->dev);
 	
 	if (rc)
-		goto error;
-
+		goto free_dev;
+	get_device(&gdev->dev);
 	rc = device_create_file(&gdev->dev, &dev_attr_ungroup);
 
 	if (rc) {
@@ -217,20 +217,28 @@
 	}
 
 	rc = __ccwgroup_create_symlinks(gdev);
-	if (!rc)
+	if (!rc) {
+		put_device(&gdev->dev);
 		return 0;
-
+	}
 	device_remove_file(&gdev->dev, &dev_attr_ungroup);
 	device_unregister(&gdev->dev);
 error:
 	for (i = 0; i < argc; i++)
 		if (gdev->cdev[i]) {
 			put_device(&gdev->cdev[i]->dev);
+			gdev->cdev[i]->dev.driver_data = NULL;
+		}
+	put_device(&gdev->dev);
+	return rc;
+free_dev:
+	for (i = 0; i < argc; i++)
+		if (gdev->cdev[i]) {
+			put_device(&gdev->cdev[i]->dev);
 			if (del_drvdata)
 				gdev->cdev[i]->dev.driver_data = NULL;
 		}
 	kfree(gdev);
-
 	return rc;
 }
 
diff -urN linux-2.6/drivers/s390/cio/chsc.c linux-2.6-s390/drivers/s390/cio/chsc.c
--- linux-2.6/drivers/s390/cio/chsc.c	Mon May 10 04:32:38 2004
+++ linux-2.6-s390/drivers/s390/cio/chsc.c	Wed Jun  2 11:29:35 2004
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/chsc.c
  *   S/390 common I/O routines -- channel subsystem call
- *   $Revision: 1.110 $
+ *   $Revision: 1.111 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -62,11 +62,11 @@
 	int state;
 
 	state = get_chp_status(chp);
-	if (state < 0)
-		new_channel_path(chp);
-	else
+	if (state < 0) {
+		need_rescan = 1;
+		queue_work(slow_path_wq, &slow_path_work);
+	} else
 		WARN_ON(!state);
-	/* FIXME: should notify other subchannels here */
 }
 
 /* FIXME: this is _always_ called for every subchannel. shouldn't we
@@ -285,8 +285,10 @@
 out_unreg:
 	spin_unlock(&sch->lock);
 	sch->lpm = 0;
-	/* We can't block here. */
-	device_call_nopath_notify(sch);
+	if (css_enqueue_subchannel_slow(sch->irq)) {
+		css_clear_subchannel_slow_list();
+		need_rescan = 1;
+	}
 	return 0;
 }
 
@@ -303,6 +305,9 @@
 
 	bus_for_each_dev(&css_bus_type, NULL, &chpid,
 			 s390_subchannel_remove_chpid);
+
+	if (need_rescan || css_slow_subchannels_exist())
+		queue_work(slow_path_wq, &slow_path_work);
 }
 
 static int
@@ -737,10 +742,12 @@
 			 * can successfully terminate, even using the
 			 * just varied off path. Then kill it.
 			 */
-			if (!__check_for_io_and_kill(sch, chp) && !sch->lpm)
-				/* Get over with it now. */
-				device_call_nopath_notify(sch);
-			else if (sch->driver && sch->driver->verify)
+			if (!__check_for_io_and_kill(sch, chp) && !sch->lpm) {
+				if (css_enqueue_subchannel_slow(sch->irq)) {
+					css_clear_subchannel_slow_list();
+					need_rescan = 1;
+				}
+			} else if (sch->driver && sch->driver->verify)
 				sch->driver->verify(&sch->dev);
 		}
 		break;
@@ -773,11 +780,6 @@
 	return 0;
 }
 
-extern void css_trigger_slow_path(void);
-typedef void (*workfunc)(void *);
-static DECLARE_WORK(varyonoff_work, (workfunc)css_trigger_slow_path,
-		    NULL);
-
 /*
  * Function: s390_vary_chpid
  * Varies the specified chpid online or offline
@@ -813,7 +815,7 @@
 			 s390_subchannel_vary_chpid_on :
 			 s390_subchannel_vary_chpid_off);
 	if (!on)
-		return 0;
+		goto out;
 	/* Scan for new devices on varied on path. */
 	for (irq = 0; irq < __MAX_SUBCHANNELS; irq++) {
 		struct schib schib;
@@ -835,8 +837,9 @@
 			need_rescan = 1;
 		}
 	}
+out:
 	if (need_rescan || css_slow_subchannels_exist())
-		schedule_work(&varyonoff_work);
+		queue_work(slow_path_wq, &slow_path_work);
 	return 0;
 }
 
diff -urN linux-2.6/drivers/s390/cio/cio.c linux-2.6-s390/drivers/s390/cio/cio.c
--- linux-2.6/drivers/s390/cio/cio.c	Mon May 10 04:33:21 2004
+++ linux-2.6-s390/drivers/s390/cio/cio.c	Wed Jun  2 11:29:35 2004
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/cio.c
  *   S/390 common I/O routines -- low level i/o calls
- *   $Revision: 1.121 $
+ *   $Revision: 1.123 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -67,17 +67,17 @@
 	if (!cio_debug_msg_id)
 		goto out_unregister;
 	debug_register_view (cio_debug_msg_id, &debug_sprintf_view);
-	debug_set_level (cio_debug_msg_id, 6);
+	debug_set_level (cio_debug_msg_id, 2);
 	cio_debug_trace_id = debug_register ("cio_trace", 4, 4, 8);
 	if (!cio_debug_trace_id)
 		goto out_unregister;
 	debug_register_view (cio_debug_trace_id, &debug_hex_ascii_view);
-	debug_set_level (cio_debug_trace_id, 6);
+	debug_set_level (cio_debug_trace_id, 2);
 	cio_debug_crw_id = debug_register ("cio_crw", 2, 4, 16*sizeof (long));
 	if (!cio_debug_crw_id)
 		goto out_unregister;
 	debug_register_view (cio_debug_crw_id, &debug_sprintf_view);
-	debug_set_level (cio_debug_crw_id, 6);
+	debug_set_level (cio_debug_crw_id, 2);
 	pr_debug("debugging initialized\n");
 	return 0;
 
diff -urN linux-2.6/drivers/s390/cio/css.c linux-2.6-s390/drivers/s390/cio/css.c
--- linux-2.6/drivers/s390/cio/css.c	Wed Jun  2 11:29:04 2004
+++ linux-2.6-s390/drivers/s390/cio/css.c	Wed Jun  2 11:29:35 2004
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/css.c
  *  driver for channel subsystem
- *   $Revision: 1.74 $
+ *   $Revision: 1.77 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
@@ -166,10 +166,12 @@
 	if (sch && sch->schib.pmcw.dnv &&
 	    (schib.pmcw.dev != sch->schib.pmcw.dev))
 		return CIO_REVALIDATE;
+	if (sch && !sch->lpm)
+		return CIO_NO_PATH;
 	return CIO_OPER;
 }
 	
-static inline int
+static int
 css_evaluate_subchannel(int irq, int slow)
 {
 	int event, ret, disc;
@@ -188,7 +190,11 @@
 		return -EAGAIN; /* Will be done on the slow path. */
 	}
 	event = css_get_subchannel_status(sch, irq);
+	CIO_MSG_EVENT(4, "Evaluating schid %04x, event %d, %s, %s path.\n",
+		      irq, event, sch?(disc?"disconnected":"normal"):"unknown",
+		      slow?"slow":"fast");
 	switch (event) {
+	case CIO_NO_PATH:
 	case CIO_GONE:
 		if (!sch) {
 			/* Never used this subchannel. Ignore. */
@@ -196,7 +202,8 @@
 			break;
 		}
 		if (sch->driver && sch->driver->notify &&
-		    sch->driver->notify(&sch->dev, CIO_GONE)) {
+		    sch->driver->notify(&sch->dev, event)) {
+			cio_disable_subchannel(sch);
 			device_set_disconnected(sch);
 			ret = 0;
 			break;
@@ -205,6 +212,7 @@
 		 * Unregister subchannel.
 		 * The device will be killed automatically.
 		 */
+		cio_disable_subchannel(sch);
 		device_unregister(&sch->dev);
 		/* Reset intparm to zeroes. */
 		sch->schib.pmcw.intparm = 0;
@@ -266,23 +274,44 @@
 	}
 }
 
-static void
-css_evaluate_slow_subchannel(unsigned long schid)
-{
-	css_evaluate_subchannel(schid, 1);
-}
+struct slow_subchannel {
+	struct list_head slow_list;
+	unsigned long schid;
+};
 
-void
+static LIST_HEAD(slow_subchannels_head);
+static spinlock_t slow_subchannel_lock = SPIN_LOCK_UNLOCKED;
+
+static void
 css_trigger_slow_path(void)
 {
+	CIO_TRACE_EVENT(4, "slowpath");
+
 	if (need_rescan) {
 		need_rescan = 0;
 		css_rescan_devices();
 		return;
 	}
-	css_walk_subchannel_slow_list(css_evaluate_slow_subchannel);
+
+	spin_lock_irq(&slow_subchannel_lock);
+	while (!list_empty(&slow_subchannels_head)) {
+		struct slow_subchannel *slow_sch =
+			list_entry(slow_subchannels_head.next,
+				   struct slow_subchannel, slow_list);
+
+		list_del_init(slow_subchannels_head.next);
+		spin_unlock_irq(&slow_subchannel_lock);
+		css_evaluate_subchannel(slow_sch->schid, 1);
+		spin_lock_irq(&slow_subchannel_lock);
+		kfree(slow_sch);
+	}
+	spin_unlock_irq(&slow_subchannel_lock);
 }
 
+typedef void (*workfunc)(void *);
+DECLARE_WORK(slow_path_work, (workfunc)css_trigger_slow_path, NULL);
+struct workqueue_struct *slow_path_wq;
+
 /*
  * Rescan for new devices. FIXME: This is slow.
  * This function is called when we have lost CRWs due to overflows and we have
@@ -443,14 +472,6 @@
 		device_unregister(dev);
 }
 
-struct slow_subchannel {
-	struct list_head slow_list;
-	unsigned long schid;
-};
-
-static LIST_HEAD(slow_subchannels_head);
-static spinlock_t slow_subchannel_lock = SPIN_LOCK_UNLOCKED;
-
 int
 css_enqueue_subchannel_slow(unsigned long schid)
 {
@@ -484,25 +505,7 @@
 	spin_unlock_irqrestore(&slow_subchannel_lock, flags);
 }
 
-void
-css_walk_subchannel_slow_list(void (*fn)(unsigned long))
-{
-	unsigned long flags;
 
-	spin_lock_irqsave(&slow_subchannel_lock, flags);
-	while (!list_empty(&slow_subchannels_head)) {
-		struct slow_subchannel *slow_sch =
-			list_entry(slow_subchannels_head.next,
-				   struct slow_subchannel, slow_list);
-
-		list_del_init(slow_subchannels_head.next);
-		spin_unlock_irqrestore(&slow_subchannel_lock, flags);
-		fn(slow_sch->schid);
-		spin_lock_irqsave(&slow_subchannel_lock, flags);
-		kfree(slow_sch);
-	}
-	spin_unlock_irqrestore(&slow_subchannel_lock, flags);
-}
 
 int
 css_slow_subchannels_exist(void)
diff -urN linux-2.6/drivers/s390/cio/css.h linux-2.6-s390/drivers/s390/cio/css.h
--- linux-2.6/drivers/s390/cio/css.h	Mon May 10 04:33:22 2004
+++ linux-2.6-s390/drivers/s390/cio/css.h	Wed Jun  2 11:29:35 2004
@@ -136,7 +136,6 @@
 
 /* Helper functions for vary on/off. */
 void device_set_waiting(struct subchannel *);
-void device_call_nopath_notify(struct subchannel *);
 
 /* Helper functions to build lists for the slow path. */
 int css_enqueue_subchannel_slow(unsigned long schid);
@@ -144,4 +143,7 @@
 void css_clear_subchannel_slow_list(void);
 int css_slow_subchannels_exist(void);
 extern int need_rescan;
+
+extern struct workqueue_struct *slow_path_wq;
+extern struct work_struct slow_path_work;
 #endif
diff -urN linux-2.6/drivers/s390/cio/device.c linux-2.6-s390/drivers/s390/cio/device.c
--- linux-2.6/drivers/s390/cio/device.c	Wed Jun  2 11:29:04 2004
+++ linux-2.6-s390/drivers/s390/cio/device.c	Wed Jun  2 11:29:35 2004
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/device.c
  *  bus driver for ccw devices
- *   $Revision: 1.117 $
+ *   $Revision: 1.119 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
@@ -159,6 +159,11 @@
 		ret = -ENOMEM; /* FIXME: better errno ? */
 		goto out_err;
 	}
+	slow_path_wq = create_singlethread_workqueue("kslowcrw");
+	if (!slow_path_wq) {
+		ret = -ENOMEM; /* FIXME: better errno ? */
+		goto out_err;
+	}
 	if ((ret = bus_register (&ccw_bus_type)))
 		goto out_err;
 
@@ -174,6 +179,8 @@
 		destroy_workqueue(ccw_device_work);
 	if (ccw_device_notify_work)
 		destroy_workqueue(ccw_device_notify_work);
+	if (slow_path_wq)
+		destroy_workqueue(slow_path_wq);
 	return ret;
 }
 
@@ -646,9 +653,7 @@
 	struct subchannel *sch;
 
 	sch = to_subchannel(cdev->dev.parent);
-	/* Check if device is registered. */
-	if (!list_empty(&sch->dev.node))
-		device_unregister(&sch->dev);
+	device_unregister(&sch->dev);
 	/* Reset intparm to zeroes. */
 	sch->schib.pmcw.intparm = 0;
 	cio_modify(sch);
@@ -677,7 +682,7 @@
 		sch = to_subchannel(cdev->dev.parent);
 		INIT_WORK(&cdev->private->kick_work,
 			  ccw_device_call_sch_unregister, (void *) cdev);
-		queue_work(ccw_device_work, &cdev->private->kick_work);
+		queue_work(slow_path_wq, &cdev->private->kick_work);
 		break;
 	case DEV_STATE_BOXED:
 		/* Device did not respond in time. */
diff -urN linux-2.6/drivers/s390/cio/device_fsm.c linux-2.6-s390/drivers/s390/cio/device_fsm.c
--- linux-2.6/drivers/s390/cio/device_fsm.c	Wed Jun  2 11:29:04 2004
+++ linux-2.6-s390/drivers/s390/cio/device_fsm.c	Wed Jun  2 11:29:35 2004
@@ -459,20 +459,6 @@
 }
 
 void
-device_call_nopath_notify(struct subchannel *sch)
-{
-	struct ccw_device *cdev;
-
-	if (!sch->dev.driver_data)
-		return;
-	cdev = sch->dev.driver_data;
-	PREPARE_WORK(&cdev->private->kick_work,
-		     ccw_device_nopath_notify, (void *)cdev);
-	queue_work(ccw_device_notify_work, &cdev->private->kick_work);
-}
-
-
-void
 ccw_device_verify_done(struct ccw_device *cdev, int err)
 {
 	cdev->private->flags.doverify = 0;
diff -urN linux-2.6/drivers/s390/cio/requestirq.c linux-2.6-s390/drivers/s390/cio/requestirq.c
--- linux-2.6/drivers/s390/cio/requestirq.c	Mon May 10 04:32:54 2004
+++ linux-2.6-s390/drivers/s390/cio/requestirq.c	Wed Jun  2 11:29:35 2004
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/requestirq.c
  *   S/390 common I/O routines -- enabling and disabling of devices
- *   $Revision: 1.45 $
+ *   $Revision: 1.46 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -18,21 +18,6 @@
 
 #include "css.h"
 
-/* for compatiblity only... */
-int
-request_irq (unsigned int irq,
-	     void (*handler) (int, void *, struct pt_regs *),
-	     unsigned long irqflags, const char *devname, void *dev_id)
-{
-	return -EINVAL;
-}
-
-/* for compatiblity only... */
-void
-free_irq (unsigned int irq, void *dev_id)
-{
-}
-
 struct pgid global_pgid;
 EXPORT_SYMBOL_GPL(global_pgid);
 
diff -urN linux-2.6/drivers/s390/s390mach.c linux-2.6-s390/drivers/s390/s390mach.c
--- linux-2.6/drivers/s390/s390mach.c	Mon May 10 04:33:21 2004
+++ linux-2.6-s390/drivers/s390/s390mach.c	Wed Jun  2 11:29:35 2004
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/errno.h>
+#include <linux/workqueue.h>
 
 #include <asm/lowcore.h>
 
@@ -21,13 +22,14 @@
 // #define DBG(args,...) do {} while (0);
 
 static struct semaphore m_sem;
-static struct semaphore s_sem;
 
 extern int css_process_crw(int);
 extern int chsc_process_crw(void);
 extern int chp_process_crw(int, int);
 extern void css_reiterate_subchannels(void);
-extern void css_trigger_slow_path(void);
+
+extern struct workqueue_struct *slow_path_wq;
+extern struct work_struct slow_path_work;
 
 static void
 s390_handle_damage(char *msg)
@@ -39,21 +41,6 @@
 	disabled_wait((unsigned long) __builtin_return_address(0));
 }
 
-static int
-s390_mchk_slow_path(void *param)
-{
-	struct semaphore *sem;
-
-	sem = (struct semaphore *)param;
-	/* Set a nice name. */
-	daemonize("kslowcrw");
-repeat:
-	down_interruptible(sem);
-	css_trigger_slow_path();
-	goto repeat;
-	return 0;
-}
-
 /*
  * Retrieve CRWs and call function to handle event.
  *
@@ -130,7 +117,7 @@
 		}
 	}
 	if (slow)
-		up(&s_sem);
+		queue_work(slow_path_wq, &slow_path_work);
 	goto repeat;
 	return 0;
 }
@@ -202,7 +189,6 @@
 machine_check_init(void)
 {
 	init_MUTEX_LOCKED(&m_sem);
-	init_MUTEX_LOCKED( &s_sem );
 	ctl_clear_bit(14, 25);	/* disable damage MCH */
 	ctl_set_bit(14, 26);	/* enable degradation MCH */
 	ctl_set_bit(14, 27);	/* enable system recovery MCH */
@@ -226,7 +212,6 @@
 machine_check_crw_init (void)
 {
 	kernel_thread(s390_collect_crw_info, &m_sem, CLONE_FS|CLONE_FILES);
-	kernel_thread(s390_mchk_slow_path, &s_sem, CLONE_FS|CLONE_FILES);
 	ctl_set_bit(14, 28);	/* enable channel report MCH */
 	return 0;
 }
