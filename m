Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271321AbTGQQ0q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 12:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271290AbTGQQ0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 12:26:35 -0400
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:38863 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id S271321AbTGQQZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 12:25:11 -0400
Date: Thu, 17 Jul 2003 18:38:58 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (4/6): common i/o layer.
Message-ID: <20030717163858.GE2045@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - Fix two memory leaks.
 - Clear pending status in cio_enable_subchannel.
 - Don't call device_unregister from interrupt context.
 - Fix refcounting problems on static device structures for the ccw console.
 - Delete timeouts for qdio after successful startup.

diffstat:
 drivers/s390/cio/chsc.c       |   10 +++---
 drivers/s390/cio/cio.c        |    7 +++-
 drivers/s390/cio/device.c     |   66 ++++++++++++++++++++++++++++++------------
 drivers/s390/cio/device.h     |    2 +
 drivers/s390/cio/device_fsm.c |   12 +++++--
 drivers/s390/cio/qdio.c       |   48 +++++++++---------------------
 6 files changed, 85 insertions(+), 60 deletions(-)

diff -urN linux-2.6.0-test1/drivers/s390/cio/chsc.c linux-2.6.0-s390/drivers/s390/cio/chsc.c
--- linux-2.6.0-test1/drivers/s390/cio/chsc.c	Mon Jul 14 05:34:40 2003
+++ linux-2.6.0-s390/drivers/s390/cio/chsc.c	Thu Jul 17 17:27:33 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/chsc.c
  *   S/390 common I/O routines -- channel subsystem call
- *   $Revision: 1.73 $
+ *   $Revision: 1.74 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -206,6 +206,7 @@
 	if (!page)
 		return -ENOMEM;
 
+	err = 0;
 	for (irq = 0; irq <= highest_subchannel; irq++) {
 		/*
 		 * retrieve information for each sch
@@ -222,13 +223,14 @@
 				       "not work\n", err);
 				cio_chsc_err_msg = 1;
 			}
-			return err;
+			goto out;
 		}
 		clear_page(page);
 	}
 	cio_chsc_desc_avail = 1;
+out:
 	free_page((unsigned long)page);
-	return 0;
+	return err;
 }
 
 __initcall(chsc_get_sch_descriptions);
@@ -428,7 +430,7 @@
 			ret = css_probe_device(irq);
 			if (ret == -ENXIO)
 				/* We're through */
-				return;
+				break;
 			continue;
 		}
 	
diff -urN linux-2.6.0-test1/drivers/s390/cio/cio.c linux-2.6.0-s390/drivers/s390/cio/cio.c
--- linux-2.6.0-test1/drivers/s390/cio/cio.c	Thu Jul 17 17:27:30 2003
+++ linux-2.6.0-s390/drivers/s390/cio/cio.c	Thu Jul 17 17:27:33 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/cio.c
  *   S/390 common I/O routines -- low level i/o calls
- *   $Revision: 1.98 $
+ *   $Revision: 1.100 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -444,6 +444,11 @@
 			if (sch->schib.pmcw.ena)
 				break;
 		}
+		if (ret == -EBUSY) {
+			struct irb irb;
+			if (tsch(sch->irq, &irb) != 0)
+				break;
+		}
 	}
 	sprintf (dbf_txt, "ret:%d", ret);
 	CIO_TRACE_EVENT (2, dbf_txt);
diff -urN linux-2.6.0-test1/drivers/s390/cio/device.c linux-2.6.0-s390/drivers/s390/cio/device.c
--- linux-2.6.0-test1/drivers/s390/cio/device.c	Mon Jul 14 05:36:42 2003
+++ linux-2.6.0-s390/drivers/s390/cio/device.c	Thu Jul 17 17:27:33 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/device.c
  *  bus driver for ccw devices
- *   $Revision: 1.58 $
+ *   $Revision: 1.60 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
@@ -434,6 +434,13 @@
 	return ret;
 }
 
+void
+ccw_device_unregister(void *data)
+{
+	device_unregister((struct device *)data);
+}
+	
+
 static void
 ccw_device_release(struct device *dev)
 {
@@ -513,17 +520,11 @@
 		wake_up(&ccw_device_init_wq);
 }
 
-static void
+static int
 io_subchannel_recog(struct ccw_device *cdev, struct subchannel *sch)
 {
 	int rc;
 
-	if (!get_device(&sch->dev)) {
-		if (cdev->dev.release)
-			cdev->dev.release(&cdev->dev);
-		return;
-	}
-
 	sch->dev.driver_data = cdev;
 	sch->driver = &io_subchannel_driver;
 	cdev->ccwlock = &sch->lock;
@@ -540,9 +541,6 @@
 	snprintf (cdev->dev.bus_id, DEVICE_ID_SIZE, "0:%04x",
 		  sch->schib.pmcw.dev);
 
-	/* Do first half of device_register. */
-	device_initialize(&cdev->dev);
-
 	/* Increase counter of devices currently in recognition. */
 	atomic_inc(&ccw_device_init_count);
 
@@ -551,13 +549,10 @@
 	rc = ccw_device_recognition(cdev);
 	spin_unlock_irq(cdev->ccwlock);
 	if (rc) {
-		sch->dev.driver_data = 0;
-		put_device(&sch->dev);
-		if (cdev->dev.release)
-			cdev->dev.release(&cdev->dev);
 		if (atomic_dec_and_test(&ccw_device_init_count))
 			wake_up(&ccw_device_init_wq);
 	}
+	return rc;
 }
 
 static int
@@ -565,6 +560,7 @@
 {
 	struct subchannel *sch;
 	struct ccw_device *cdev;
+	int rc;
 
 	sch = to_subchannel(pdev);
 	if (sch->dev.driver_data) {
@@ -573,8 +569,20 @@
 		 * Register it and exit. This happens for all early
 		 * device, e.g. the console.
 		 */
-		ccw_device_register(sch->dev.driver_data);
+		cdev = sch->dev.driver_data;
+		device_initialize(&cdev->dev);
+		ccw_device_register(cdev);
 		subchannel_add_files(&sch->dev);
+		/*
+		 * Check if the device is already online. If it is
+		 * the reference count needs to be corrected
+		 * (see ccw_device_online and css_init_done for the
+		 * ugly details).
+		 */
+		if (cdev->private->state != DEV_STATE_NOT_OPER &&
+		    cdev->private->state != DEV_STATE_OFFLINE &&
+		    cdev->private->state != DEV_STATE_BOXED)
+			get_device(&cdev->dev);
 		return 0;
 	}
 	cdev  = kmalloc (sizeof(*cdev), GFP_KERNEL);
@@ -592,7 +600,23 @@
 		.parent = pdev,
 		.release = ccw_device_release,
 	};
-	io_subchannel_recog(cdev, to_subchannel(pdev));
+	/* Do first half of device_register. */
+	device_initialize(&cdev->dev);
+
+	if (!get_device(&sch->dev)) {
+		if (cdev->dev.release)
+			cdev->dev.release(&cdev->dev);
+		return 0;
+	}
+
+	rc = io_subchannel_recog(cdev, to_subchannel(pdev));
+	if (rc) {
+		sch->dev.driver_data = 0;
+		put_device(&sch->dev);
+		if (cdev->dev.release)
+			cdev->dev.release(&cdev->dev);
+	}
+
 	return 0;
 }
 
@@ -604,6 +628,8 @@
 static int
 ccw_device_console_enable (struct ccw_device *cdev, struct subchannel *sch)
 {
+	int rc;
+
 	/* Initialize the ccw_device structure. */
 	cdev->dev = (struct device) {
 		.parent = &sch->dev,
@@ -613,7 +639,11 @@
 		.parent = &css_bus_device,
 		.bus	= &css_bus_type,
 	};
-	io_subchannel_recog(cdev, sch);
+
+	rc = io_subchannel_recog(cdev, sch);
+	if (rc)
+		return rc;
+
 	/* Now wait for the async. recognition to come to an end. */
 	while (!dev_fsm_final_state(cdev))
 		wait_cons_dev();
diff -urN linux-2.6.0-test1/drivers/s390/cio/device.h linux-2.6.0-s390/drivers/s390/cio/device.h
--- linux-2.6.0-test1/drivers/s390/cio/device.h	Mon Jul 14 05:37:13 2003
+++ linux-2.6.0-s390/drivers/s390/cio/device.h	Thu Jul 17 17:27:33 2003
@@ -65,6 +65,8 @@
 
 void io_subchannel_recog_done(struct ccw_device *cdev);
 
+void ccw_device_unregister(void *);
+
 int ccw_device_recognition(struct ccw_device *);
 int ccw_device_online(struct ccw_device *);
 int ccw_device_offline(struct ccw_device *);
diff -urN linux-2.6.0-test1/drivers/s390/cio/device_fsm.c linux-2.6.0-s390/drivers/s390/cio/device_fsm.c
--- linux-2.6.0-test1/drivers/s390/cio/device_fsm.c	Mon Jul 14 05:34:32 2003
+++ linux-2.6.0-s390/drivers/s390/cio/device_fsm.c	Thu Jul 17 17:27:33 2003
@@ -188,7 +188,7 @@
 
 	wake_up(&cdev->private->wait_q);
 
-	if (state != DEV_STATE_ONLINE)
+	if (css_init_done && state != DEV_STATE_ONLINE)
 		put_device (&cdev->dev);
 }
 
@@ -293,7 +293,7 @@
 	if (cdev->private->state != DEV_STATE_OFFLINE)
 		return -EINVAL;
 	sch = to_subchannel(cdev->dev.parent);
-	if (!get_device(&cdev->dev))
+	if (css_init_done && !get_device(&cdev->dev))
 		return -ENODEV;
 	if (cio_enable_subchannel(sch, sch->schib.pmcw.isc) != 0) {
 		/* Couldn't enable the subchannel for i/o. Sick device. */
@@ -384,7 +384,9 @@
 ccw_device_offline_notoper(struct ccw_device *cdev, enum dev_event dev_event)
 {
 	cdev->private->state = DEV_STATE_NOT_OPER;
-	device_unregister(&cdev->dev);
+	INIT_WORK(&cdev->private->kick_work,
+		  ccw_device_unregister, (void *) &cdev->dev);
+	queue_work(ccw_device_work, &cdev->private->kick_work);
 	wake_up(&cdev->private->wait_q);
 }
 
@@ -403,8 +405,10 @@
 		// FIXME: not-oper indication to device driver ?
 		ccw_device_call_handler(cdev);
 	}
+	INIT_WORK(&cdev->private->kick_work,
+		  ccw_device_unregister, (void *) &cdev->dev);
+	queue_work(ccw_device_work, &cdev->private->kick_work);
 	wake_up(&cdev->private->wait_q);
-	device_unregister(&cdev->dev);
 }
 
 /*
diff -urN linux-2.6.0-test1/drivers/s390/cio/qdio.c linux-2.6.0-s390/drivers/s390/cio/qdio.c
--- linux-2.6.0-test1/drivers/s390/cio/qdio.c	Mon Jul 14 05:35:14 2003
+++ linux-2.6.0-s390/drivers/s390/cio/qdio.c	Thu Jul 17 17:27:33 2003
@@ -55,7 +55,7 @@
 #include "ioasm.h"
 #include "chsc.h"
 
-#define VERSION_QDIO_C "$Revision: 1.51 $"
+#define VERSION_QDIO_C "$Revision: 1.55 $"
 
 /****************** MODULE PARAMETER VARIABLES ********************/
 MODULE_AUTHOR("Utz Bacher <utz.bacher@de.ibm.com>");
@@ -1643,6 +1643,7 @@
 	default:
 		BUG();
 	}
+	ccw_device_set_timeout(cdev, 0);
 	wake_up(&cdev->private->wait_q);
 
 }
@@ -1891,26 +1892,25 @@
 		result=-EIO;
 		goto exit;
 	}
-	/* 4: request block
-	 * 2: general char
-	 * 512: chsc char */
-	if ((scsc_area->general_char[1] & 0x00800000) != 0x00800000) {
+	/* Check for bit 41. */
+	if ((scsc_area->general_char[1] & 0x00400000) != 0x00400000) {
 		QDIO_PRINT_WARN("Adapter interruption facility not " \
 				"installed.\n");
 		result=-ENOENT;
 		goto exit;
 	}
-	if ((scsc_area->chsc_char[2] & 0x00180000) != 0x00180000) {
+	/* Check for bits 107 and 108. */
+	if ((scsc_area->chsc_char[3] & 0x00180000) != 0x00180000) {
 		QDIO_PRINT_WARN("Set Chan Subsys. Char. & Fast-CHSCs " \
 				"not available.\n");
 		result=-ENOENT;
 		goto exit;
 	}
 
-	/* Check for hydra thin interrupts. */
+	/* Check for hydra thin interrupts (bit 67). */
 	hydra_thinints = ((scsc_area->general_char[2] & 0x10000000)
 		== 0x10000000);
-	sprintf(dbf_text,"hydra_ti%1x", hydra_thinints);
+	sprintf(dbf_text,"hydrati%1x", hydra_thinints);
 	QDIO_DBF_TEXT0(0,setup,dbf_text);
 exit:
 	free_page ((unsigned long) scsc_area);
@@ -2413,8 +2413,10 @@
 	QDIO_DBF_TEXT0(0,setup,dbf_text);
 	QDIO_DBF_TEXT0(0,trace,dbf_text);
 
-	if (qdio_establish_irq_check_for_errors(cdev, cstat, dstat))
+	if (qdio_establish_irq_check_for_errors(cdev, cstat, dstat)) {
+		ccw_device_set_timeout(cdev, 0);
 		return;
+	}
 
 	irq_ptr = cdev->private->qdio_data;
 
@@ -2439,7 +2441,7 @@
 	qdio_initialize_set_siga_flags_output(irq_ptr);
 
 	qdio_set_state(irq_ptr,QDIO_IRQ_STATE_ESTABLISHED);
-
+	ccw_device_set_timeout(cdev, 0);
 }
 
 int
@@ -2698,6 +2700,8 @@
                            "returned %i, next try returned %i\n",
                            irq_ptr->irq,result,result2);
 		result=result2;
+		if (result)
+			ccw_device_set_timeout(cdev, 0);
 	}
 
 	spin_unlock_irqrestore(get_ccwdev_lock(cdev),saveflags);
@@ -3000,7 +3004,6 @@
 			int buffer_length, int *eof, void *data)
 {
         int c=0;
-	int irq;
 
         /* we are always called with buffer_length=4k, so we all
            deliver on the first read */
@@ -3020,7 +3023,7 @@
 		 perf_stats.siga_ins);
 	_OUTP_IT("Number of SIGA out's issued                     : %u\n",
 		 perf_stats.siga_outs);
-	_OUTP_IT("Number of PCIs caught                          : %u\n",
+	_OUTP_IT("Number of PCIs caught                           : %u\n",
 		 perf_stats.pcis);
 	_OUTP_IT("Number of adapter interrupts caught             : %u\n",
 		 perf_stats.thinints);
@@ -3037,27 +3040,6 @@
 		 perf_stats.outbound_cnt);
 	_OUTP_IT("\n");
 
-	/* 
-	 * FIXME: Rather use driver_for_each_dev, if we had it. 
-	 * I know this loop destroys our layering, but at least gets the 
-	 * performance stats out...
-	 */
-	for (irq=0;irq <= highest_subchannel; irq++) {
-		struct qdio_irq *irq_ptr;
-		struct ccw_device *cdev;
-
-		if (!ioinfo[irq])
-			continue;
-		cdev = ioinfo[irq]->dev.driver_data;
-		if (!cdev)
-			continue;
-		irq_ptr = cdev->private->qdio_data;
-		if (!irq_ptr)
-			continue;
-		_OUTP_IT("Polling time on irq %4x                        " \
-			 ": %u\n",
-			 irq_ptr->irq,irq_ptr->input_qs[0]->timing.threshold);
-	}
         return c;
 }
 
