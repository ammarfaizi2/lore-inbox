Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263818AbUDZN55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbUDZN55 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 09:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbUDZN55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 09:57:57 -0400
Received: from mail.convergence.de ([212.84.236.4]:48260 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S263818AbUDZNmL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 09:42:11 -0400
To: hunold@linuxtv.org, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
From: Michael Hunold <hunold@linuxtv.org>
Subject: [PATCH 5/9] DVB: Other DVB core updates
In-Reply-To: <1082986832779@convergence.de>
Message-Id: <10829868582688@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring_mihu_extended
Date: Mon, 26 Apr 2004 09:42:11 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] remove superflous memset() which caused section data to be overwritten when a) there are two sections in one TS packet, and b) the first section was smaller than 18 bytes; thanks to Jean-Claude Repetto for tracking this down
- [DVB] starting a ts filter on a running section filter's pid did break the section filter; fixed.
- [DVB] integrate ULE Decapsulation code, thanks to gcs - Global Communication & Services GmbH. and Institute for Computer Sciences Salzburg University. Hilmar Linder <hlinder@cosy.sbg.ac.at> and Wolfram Stering <wstering@cosy.sbg.ac.at>
- [DVB] fix the module use count bugs, thanks to Hernan A.Perez Masci for his initial work on this problem
- [DVB] if dvb_frontend_internal_ioctl() returns an error code, be sure to deliver it to the calling application, don't ignore it (fixes the bug that the frontend0 doesn't respond properly to unknown ioctls...)
- [DVB] major frontend code clean up, rewritten core tuning loop. Thanks to Andrew de Quincey.
- [DVB] follow changes in dvb-core in skystar2, dvb-bt8xx
diff -urawBN xx-linux-2.6.5/drivers/media/dvb/b2c2/skystar2.c linux-2.6.5-patched/drivers/media/dvb/b2c2/skystar2.c
--- xx-linux-2.6.5/drivers/media/dvb/b2c2/skystar2.c	2004-03-12 20:31:28.000000000 +0100
+++ linux-2.6.5-patched/drivers/media/dvb/b2c2/skystar2.c	2004-03-31 11:55:31.000000000 +0200
@@ -2242,7 +2243,7 @@
 	if (driver_initialize(pdev) != 0)
 		return -ENODEV;
 
-	dvb_register_adapter(&dvb_adapter, skystar2_pci_driver.name);
+	dvb_register_adapter(&dvb_adapter, skystar2_pci_driver.name, THIS_MODULE);
 
 	if (dvb_adapter == NULL) {
 		printk("%s: Error registering DVB adapter\n", __FUNCTION__);
@@ -2342,6 +2343,8 @@
 	{0,},
 };
 
+MODULE_DEVICE_TABLE(pci, skystar2_pci_tbl);
+
 static struct pci_driver skystar2_pci_driver = {
 	.name = "Technisat SkyStar2 driver",
 	.id_table = skystar2_pci_tbl,
diff -urawBN xx-linux-2.6.5/drivers/media/dvb/bt8xx/dvb-bt8xx.c linux-2.6.5-patched/drivers/media/dvb/bt8xx/dvb-bt8xx.c
--- xx-linux-2.6.5/drivers/media/dvb/bt8xx/dvb-bt8xx.c	2004-01-16 18:25:17.000000000 +0100
+++ linux-2.6.5-patched/drivers/media/dvb/bt8xx/dvb-bt8xx.c	2004-04-23 21:55:25.000000000 +0200
@@ -286,7 +286,7 @@
 	
 	}
 
-	if ((result = dvb_register_adapter(&card->dvb_adapter, card->card_name)) < 0) {
+	if ((result = dvb_register_adapter(&card->dvb_adapter, card->card_name, THIS_MODULE)) < 0) {
 	
 		printk("dvb_bt8xx: dvb_register_adapter failed (errno = %d)\n", result);
 		
diff -urawBN xx-linux-2.6.5/drivers/media/dvb/dvb-core/dvb_demux.c linux-2.6.5-patched/drivers/media/dvb/dvb-core/dvb_demux.c
--- xx-linux-2.6.5/drivers/media/dvb/dvb-core/dvb_demux.c	2004-02-22 14:48:47.000000000 +0100
+++ linux-2.6.5-patched/drivers/media/dvb/dvb-core/dvb_demux.c	2004-03-03 16:48:27.000000000 +0100
@@ -192,7 +194,6 @@
 	struct dvb_demux *demux = feed->demux;
 	struct dvb_demux_filter *f = feed->filter;
 	struct dmx_section_feed *sec = &feed->feed.sec;
-	u8 *buf = sec->secbuf;
 	int section_syntax_indicator;
 
 	if (!sec->is_filtering)
@@ -215,8 +216,6 @@
 
 	sec->seclen = 0;
 
-	memset(buf, 0, DVB_DEMUX_MASK_MAX);
- 
 	return 0;
 }
 
diff -urawBN xx-linux-2.6.5/drivers/media/dvb/dvb-core/dvbdev.c linux-2.6.5-patched/drivers/media/dvb/dvb-core/dvbdev.c
--- xx-linux-2.6.5/drivers/media/dvb/dvb-core/dvbdev.c	2003-12-18 03:58:18.000000000 +0100
+++ linux-2.6.5-patched/drivers/media/dvb/dvb-core/dvbdev.c	2004-04-23 21:50:41.000000000 +0200
@@ -211,6 +210,8 @@
 	dvbdev->adapter = adap;
 	dvbdev->priv = priv;
 
+	dvbdev->fops->owner = adap->module;
+
 	list_add_tail (&dvbdev->list_head, &adap->device_list);
 
 	devfs_mk_cdev(MKDEV(DVB_MAJOR, nums2minor(adap->num, type, id)),
@@ -227,9 +228,12 @@
 
 void dvb_unregister_device(struct dvb_device *dvbdev)
 {
-	if (dvbdev) {
+	if (!dvbdev)
+		return;
+
 		devfs_remove("dvb/adapter%d/%s%d", dvbdev->adapter->num,
 				dnames[dvbdev->type], dvbdev->id);
+
 		list_del(&dvbdev->list_head);
 		kfree(dvbdev);
 	}
@@ -233,7 +237,6 @@
 		list_del(&dvbdev->list_head);
 		kfree(dvbdev);
 	}
-}
 
 
 static int dvbdev_get_free_adapter_num (void)
@@ -257,7 +260,7 @@
 }
 
 
-int dvb_register_adapter(struct dvb_adapter **padap, const char *name)
+int dvb_register_adapter(struct dvb_adapter **padap, const char *name, struct module *module)
 {
 	struct dvb_adapter *adap;
 	int num;
@@ -281,8 +284,10 @@
 	printk ("DVB: registering new adapter (%s).\n", name);
 	
 	devfs_mk_dir("dvb/adapter%d", num);
+
 	adap->num = num;
 	adap->name = name;
+	adap->module = module;
 
 	list_add_tail (&adap->list_head, &dvb_adapter_list);
 
diff -urawBN xx-linux-2.6.5/drivers/media/dvb/dvb-core/dvbdev.h linux-2.6.5-patched/drivers/media/dvb/dvb-core/dvbdev.h
--- xx-linux-2.6.5/drivers/media/dvb/dvb-core/dvbdev.h	2003-12-18 03:58:39.000000000 +0100
+++ linux-2.6.5-patched/drivers/media/dvb/dvb-core/dvbdev.h	2004-04-23 21:48:36.000000000 +0200
@@ -48,6 +48,8 @@
 	struct list_head device_list;
 	const char *name;
 	u8 proposed_mac [6];
+
+	struct module *module;
 };
 
 
@@ -75,7 +74,7 @@
 };
 
 
-extern int dvb_register_adapter (struct dvb_adapter **padap, const char *name);
+extern int dvb_register_adapter (struct dvb_adapter **padap, const char *name, struct module *module);
 extern int dvb_unregister_adapter (struct dvb_adapter *adap);
 
 extern int dvb_register_device (struct dvb_adapter *adap,
diff -urawBN xx-linux-2.6.5/drivers/media/dvb/dvb-core/dvb_frontend.c linux-2.6.5-patched/drivers/media/dvb/dvb-core/dvb_frontend.c
--- xx-linux-2.6.5/drivers/media/dvb/dvb-core/dvb_frontend.c	2004-03-12 20:31:28.000000000 +0100
+++ linux-2.6.5-patched/drivers/media/dvb/dvb-core/dvb_frontend.c	2004-04-23 21:51:35.000000000 +0200
@@ -6,6 +6,8 @@
  *                         Holger Waechtler 
  *                                    for convergence integrated media GmbH
  *
+ * Copyright (C) 2004 Andrew de Quincey (tuning thread cleanup)
+ *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
  * as published by the Free Software Foundation; either version 2
@@ -37,9 +39,41 @@
 #include "dvbdev.h"
 #include "dvb_functions.h"
 
+#define FESTATE_IDLE 1
+#define FESTATE_RETUNE 2
+#define FESTATE_TUNING_FAST 4
+#define FESTATE_TUNING_SLOW 8
+#define FESTATE_TUNED 16
+#define FESTATE_ZIGZAG_FAST 32
+#define FESTATE_ZIGZAG_SLOW 64
+#define FESTATE_DISEQC 128
+#define FESTATE_WAITFORLOCK (FESTATE_TUNING_FAST | FESTATE_TUNING_SLOW | FESTATE_ZIGZAG_FAST | FESTATE_ZIGZAG_SLOW | FESTATE_DISEQC)
+#define FESTATE_SEARCHING_FAST (FESTATE_TUNING_FAST | FESTATE_ZIGZAG_FAST)
+#define FESTATE_SEARCHING_SLOW (FESTATE_TUNING_SLOW | FESTATE_ZIGZAG_SLOW)
+#define FESTATE_LOSTLOCK (FESTATE_ZIGZAG_FAST | FESTATE_ZIGZAG_SLOW)
+/*
+ * FESTATE_IDLE. No tuning parameters have been supplied and the loop is idling.
+ * FESTATE_RETUNE. Parameters have been supplied, but we have not yet performed the first tune.
+ * FESTATE_TUNING_FAST. Tuning parameters have been supplied and fast zigzag scan is in progress.
+ * FESTATE_TUNING_SLOW. Tuning parameters have been supplied. Fast zigzag failed, so we're trying again, but slower.
+ * FESTATE_TUNED. The frontend has successfully locked on.
+ * FESTATE_ZIGZAG_FAST. The lock has been lost, and a fast zigzag has been initiated to try and regain it.
+ * FESTATE_ZIGZAG_SLOW. The lock has been lost. Fast zigzag has been failed, so we're trying again, but slower.
+ * FESTATE_DISEQC. A DISEQC command has just been issued.
+ * FESTATE_WAITFORLOCK. When we're waiting for a lock.
+ * FESTATE_SEARCHING_FAST. When we're searching for a signal using a fast zigzag scan.
+ * FESTATE_SEARCHING_SLOW. When we're searching for a signal using a slow zigzag scan.
+ * FESTATE_LOSTLOCK. When the lock has been lost, and we're searching it again.
+ */
+
 
 static int dvb_frontend_debug = 0;
 static int dvb_shutdown_timeout = 5;
+static int dvb_override_frequency_bending = 0;
+static int dvb_force_auto_inversion = 0;
+static int dvb_override_tune_delay = 0;
+
+static int do_frequency_bending = 0;
 
 #define dprintk if (dvb_frontend_debug) printk
 
@@ -66,13 +100,18 @@
 	wait_queue_head_t wait_queue;
 	pid_t thread_pid;
 	unsigned long release_jiffies;
-	unsigned long lost_sync_jiffies;
-	int acquire_signal;
+	int state;
 	int bending;
 	int lnb_drift;
-	int timeout_count;
-	int lost_sync_count;
+	int inversion;
+	int auto_step;
+	int auto_sub_step;
+	int started_auto_step;
+	int min_delay;
+	int max_drift;
+	int step_size;
 	int exit;
+	int wakeup;
         fe_status_t status;
 };
 
@@ -170,7 +209,7 @@
 		frequency += this_fe->lnb_drift;
 		frequency += this_fe->bending;
 
-		if (this_fe != fe && fe->lost_sync_count != -1 &&
+		if (this_fe != fe && (fe->state != FESTATE_IDLE) &&
                     frequency > f - stepsize && frequency < f + stepsize)
 		{
 			if (recursive % 2)
@@ -193,9 +232,6 @@
 {
 	dprintk ("%s\n", __FUNCTION__);
 
-	if ((fe->status & FE_HAS_LOCK) && !(s & FE_HAS_LOCK))
-		fe->lost_sync_jiffies = jiffies;
-
 	if (((s ^ fe->status) & FE_HAS_LOCK) && (s & FE_HAS_LOCK))
 		dvb_delay (fe->info->notifier_delay);
 
@@ -293,40 +329,6 @@
         return 0;
 }
 
-
-static int dvb_frontend_set_parameters (struct dvb_frontend_data *fe,
-				 struct dvb_frontend_parameters *param,
-				 int first_trial)
-{
-	struct dvb_frontend *frontend = &fe->frontend;
-	int err;
-
-	if (first_trial) {
-		fe->timeout_count = 0;
-		fe->lost_sync_count = 0;
-		fe->lost_sync_jiffies = jiffies;
-		fe->lnb_drift = 0;
-		fe->acquire_signal = 1;
-		if (fe->status & ~FE_TIMEDOUT)
-			dvb_frontend_add_event (fe, 0);
-		memcpy (&fe->parameters, param,
-			sizeof (struct dvb_frontend_parameters));
-	}
-
-	dvb_bend_frequency (fe, 0);
-
-	dprintk ("%s: f == %i, drift == %i\n",
-		 __FUNCTION__, (int) param->frequency, (int) fe->lnb_drift);
-
-	param->frequency += fe->lnb_drift + fe->bending;
-	err = dvb_frontend_internal_ioctl (frontend, FE_SET_FRONTEND, param);
-	param->frequency -= fe->lnb_drift + fe->bending;
-
-	wake_up_interruptible (&fe->wait_queue);
-
-	return err;
-}
-
 static void dvb_frontend_init (struct dvb_frontend_data *fe)
 {
 	struct dvb_frontend *frontend = &fe->frontend;
@@ -338,8 +340,7 @@
 	dvb_frontend_internal_ioctl (frontend, FE_INIT, NULL);
 }
 
-
-static void update_delay (int *quality, int *delay, int locked)
+static void update_delay (int *quality, int *delay, int min_delay, int locked)
 {
 	int q2;
 
@@ -353,59 +354,101 @@
 	q2 = *quality - 128;
 	q2 *= q2;
 
-	*delay = HZ/20 + q2 * HZ / (128*128);
+	    *delay = min_delay + q2 * HZ / (128*128);
 }
 
-
-#define LNB_DRIFT 1024  /*  max. tolerated LNB drift, XXX FIXME: adjust! */
-#define TIMEOUT 2*HZ
-
 /**
- *  here we only come when we have lost the lock bit, 
- *  let's try to do something useful...
+ * Performs automatic twiddling of frontend parameters.
+ * 
+ * @param fe The frontend concerned.
+ * @param check_wrapped Checks if an iteration has completed. DO NOT SET ON THE FIRST ATTEMPT
+ * @returns Number of complete iterations that have been performed.
  */
-static void dvb_frontend_recover (struct dvb_frontend_data *fe)
+static int dvb_frontend_autotune(struct dvb_frontend_data *fe, int check_wrapped)
 {
-	int j = fe->lost_sync_count;
-	int stepsize;
+	int autoinversion;
+	int ready = 0;
+	int original_inversion = fe->parameters.inversion;
+	u32 original_frequency = fe->parameters.frequency;
+
+	// are we using autoinversion?
+	autoinversion = ((!(fe->info->caps & FE_CAN_INVERSION_AUTO)) && (fe->parameters.inversion == INVERSION_AUTO));
+
+	// setup parameters correctly
+	while(!ready) {
+		// calculate the lnb_drift
+		fe->lnb_drift = fe->auto_step * fe->step_size;
+
+		// wrap the auto_step if we've exceeded the maximum drift
+		if (fe->lnb_drift > fe->max_drift) {
+			fe->auto_step = 0;
+			fe->auto_sub_step = 0;
+			fe->lnb_drift = 0;
+		}
 
-	dprintk ("%s\n", __FUNCTION__);
+		// perform inversion and +/- zigzag
+		switch(fe->auto_sub_step) {
+		case 0:
+			// try with the current inversion and current drift setting
+			ready = 1;
+			break;
 
-#if 0
-	if (fe->timeout_count > 3) {
-		printk ("%s: frontend seems dead, reinitializing...\n",
-			__FUNCTION__);
-		dvb_call_frontend_notifiers (fe, 0);
-		dvb_frontend_internal_ioctl (&fe->frontend, FE_INIT, NULL);
-		dvb_frontend_set_parameters (fe, &fe->parameters, 1);
-		dvb_frontend_add_event (fe, FE_REINIT);
-		fe->lost_sync_jiffies = jiffies;
-		fe->timeout_count = 0;
-		return;
-	}
-#endif
+		case 1:
+			if (!autoinversion) break;
 
-	/**
-	 *  let's start a zigzag scan to compensate LNB drift...
-	 */
-		if (fe->info->type == FE_QPSK)
-			stepsize = fe->parameters.u.qpsk.symbol_rate / 16000;
-		else if (fe->info->type == FE_QAM)
-			stepsize = 0;
-		else
-			stepsize = fe->info->frequency_stepsize * 2;
+			fe->inversion = (fe->inversion == INVERSION_OFF) ? INVERSION_ON : INVERSION_OFF;
+			ready = 1;
+			break;
 
-		if (j % 32 == 0) {
-			fe->lnb_drift = 0;
-		} else {
+		case 2:
+			if (fe->lnb_drift == 0) break;
+		    
+			fe->lnb_drift = -fe->lnb_drift;
+			ready = 1;
+			break;
+	    
+		case 3:
+			if (fe->lnb_drift == 0) break;
+			if (!autoinversion) break;
+		    
+			fe->inversion = (fe->inversion == INVERSION_OFF) ? INVERSION_ON : INVERSION_OFF;
 			fe->lnb_drift = -fe->lnb_drift;
-			if (j % 2)
-				fe->lnb_drift += stepsize;
+			ready = 1;
+			break;
+		    
+		default:
+			fe->auto_step++;
+			fe->auto_sub_step = -1; // it'll be incremented to 0 in a moment
+			break;
+		}
+	    
+		if (!ready) fe->auto_sub_step++;
+	}
+
+	// if this attempt would hit where we started, indicate a complete iteration has occurred
+	if ((fe->auto_step == fe->started_auto_step) && (fe->auto_sub_step == 0) && check_wrapped) {
+		return 1;
 		}
 
-		dvb_frontend_set_parameters (fe, &fe->parameters, 0);
+	// perform frequency bending if necessary
+	if ((dvb_override_frequency_bending != 1) && do_frequency_bending)
+		dvb_bend_frequency(fe, 0);
+
+	// instrumentation
+	dprintk("%s: drift:%i bending:%i inversion:%i auto_step:%i auto_sub_step:%i started_auto_step:%i\n", 
+		__FUNCTION__, fe->lnb_drift, fe->bending, fe->inversion, fe->auto_step, fe->auto_sub_step,
+		fe->started_auto_step);
+    
+	// set the frontend itself
+	fe->parameters.frequency += fe->lnb_drift + fe->bending;
+	if (autoinversion) fe->parameters.inversion = fe->inversion;
+	dvb_frontend_internal_ioctl (&fe->frontend, FE_SET_FRONTEND, &fe->parameters);
+	fe->parameters.frequency = original_frequency;
+	fe->parameters.inversion = original_inversion;
 
-	dvb_frontend_internal_ioctl (&fe->frontend, FE_RESET, NULL);
+	// normal return
+	fe->auto_sub_step++;
+	return 0;
 }
 
 
@@ -422,6 +465,19 @@
 	return 0;
 }
 
+static int dvb_frontend_should_wakeup (struct dvb_frontend_data *fe)
+{
+	if (fe->wakeup) {
+		fe->wakeup = 0;
+		return 1;
+	}
+	return dvb_frontend_is_exiting(fe);
+}
+
+static void dvb_frontend_wakeup (struct dvb_frontend_data *fe) {
+	fe->wakeup = 1;
+	wake_up_interruptible(&fe->wait_queue);
+}
 
 static int dvb_frontend_thread (void *data)
 {
@@ -430,6 +486,7 @@
 	char name [15];
 	int quality = 0, delay = 3*HZ;
 	fe_status_t s;
+	int check_wrapped = 0;
 
 	dprintk ("%s\n", __FUNCTION__);
 
@@ -438,15 +495,14 @@
 
 	dvb_kernel_thread_setup (name);
 
-	fe->lost_sync_count = -1;
-
 	dvb_call_frontend_notifiers (fe, 0);
 	dvb_frontend_init (fe);
+	fe->wakeup = 0;
 
 	while (1) {
 		up (&fe->sem);      /* is locked when we enter the thread... */
 
-		timeout = wait_event_interruptible_timeout(fe->wait_queue,0 != dvb_frontend_is_exiting (fe), delay);
+		timeout = wait_event_interruptible_timeout(fe->wait_queue,0 != dvb_frontend_should_wakeup (fe), delay);
 		if (-ERESTARTSYS == timeout || 0 != dvb_frontend_is_exiting (fe)) {
 			/* got signal or quitting */
 			break;
@@ -455,43 +511,104 @@
 		if (down_interruptible (&fe->sem))
 			break;
 
-		if (fe->lost_sync_count == -1)
+		// if we've got no parameters, just keep idling
+		if (fe->state & FESTATE_IDLE) {
+			delay = 3*HZ;
+			quality = 0;
 			continue;
+		}
 
+		// get the frontend status
 		dvb_frontend_internal_ioctl (&fe->frontend, FE_READ_STATUS, &s);
+		if (s != fe->status)
+			dvb_frontend_add_event (fe, s);
 
-		update_delay (&quality, &delay, s & FE_HAS_LOCK);
+		// if we're not tuned, and we have a lock, move to the TUNED state
+		if ((fe->state & FESTATE_WAITFORLOCK) && (s & FE_HAS_LOCK)) {
+			update_delay(&quality, &delay, fe->min_delay, s & FE_HAS_LOCK);
+			fe->state = FESTATE_TUNED;
+
+			// if we're tuned, then we have determined the correct inversion
+			if ((!(fe->info->caps & FE_CAN_INVERSION_AUTO)) && (fe->parameters.inversion == INVERSION_AUTO)) {
+				fe->parameters.inversion = fe->inversion;
+			}
+			continue;
+		}
 
-		s &= ~FE_TIMEDOUT;
+		// if we are tuned already, check we're still locked
+		if (fe->state & FESTATE_TUNED) {
+			update_delay(&quality, &delay, fe->min_delay, s & FE_HAS_LOCK);
 
+			// we're tuned, and the lock is still good...
 		if (s & FE_HAS_LOCK) {
-			fe->timeout_count = 0;
-			fe->lost_sync_count = 0;
-			fe->acquire_signal = 0;
+				continue;
 		} else {
-			fe->lost_sync_count++;
-			if (!(fe->info->caps & FE_CAN_RECOVER)) {
-				if (!(fe->info->caps & FE_CAN_CLEAN_SETUP)) {
-					if (fe->lost_sync_count < 10) {
-						if (fe->acquire_signal)
-							dvb_frontend_internal_ioctl(
-									&fe->frontend,
-									FE_RESET, NULL);
+				// if we _WERE_ tuned, but now don't have a lock, need to zigzag
+				fe->state = FESTATE_ZIGZAG_FAST;
+				fe->started_auto_step = fe->auto_step;
+				check_wrapped = 0;
+				// fallthrough
+			}
+		}
+
+		// don't actually do anything if we're in the LOSTLOCK state, the frontend is set to
+		// FE_CAN_RECOVER, and the max_drift is 0
+		if ((fe->state & FESTATE_LOSTLOCK) && 
+		    (fe->info->caps & FE_CAN_RECOVER) && (fe->max_drift == 0)) {
+			update_delay(&quality, &delay, fe->min_delay, s & FE_HAS_LOCK);
 						continue;
 				}
+	    
+		// don't do anything if we're in the DISEQC state, since this might be someone
+		// with a motorized dish controlled by DISEQC. If its actually a re-tune, there will
+		// be a SET_FRONTEND soon enough.
+		if (fe->state & FESTATE_DISEQC) {
+			update_delay(&quality, &delay, fe->min_delay, s & FE_HAS_LOCK);
+			continue;
 				}
-				dvb_frontend_recover (fe);
-				delay = HZ/5;
+
+		// if we're in the RETUNE state, set everything up for a brand new scan,
+		// keeping the current inversion setting, as the next tune is _very_ likely
+		// to require the same
+		if (fe->state & FESTATE_RETUNE) {
+			fe->lnb_drift = 0;
+			fe->auto_step = 0;
+			fe->auto_sub_step = 0;
+			fe->started_auto_step = 0;
+			check_wrapped = 0;
+		}
+
+		// fast zigzag.
+		if ((fe->state & FESTATE_SEARCHING_FAST) || (fe->state & FESTATE_RETUNE)) {
+			delay = fe->min_delay;
+
+			// peform a tune
+			if (dvb_frontend_autotune(fe, check_wrapped)) {
+				// OK, if we've run out of trials at the fast speed. Drop back to
+				// slow for the _next_ attempt
+				fe->state = FESTATE_SEARCHING_SLOW;
+				fe->started_auto_step = fe->auto_step;
+				continue;
 			}
-			if (jiffies - fe->lost_sync_jiffies > TIMEOUT) {
-				s |= FE_TIMEDOUT;
-				if ((fe->status & FE_TIMEDOUT) == 0)
-					fe->timeout_count++;
+			check_wrapped = 1;
+
+			// if we've just retuned, enter the ZIGZAG_FAST state. This ensures
+			// we cannot return from an FE_SET_FRONTEND ioctl before the first frontend
+			// tune occurs
+			if (fe->state & FESTATE_RETUNE) {
+				fe->state = FESTATE_TUNING_FAST;
+				wake_up_interruptible(&fe->wait_queue);
 			}
 		}
 
-		if (s != fe->status)
-			dvb_frontend_add_event (fe, s);
+		// slow zigzag
+		if (fe->state & FESTATE_SEARCHING_SLOW) {
+			update_delay(&quality, &delay, fe->min_delay, s & FE_HAS_LOCK);
+		    
+			// Note: don't bother checking for wrapping; we stay in this state 
+			// until we get a lock
+			dvb_frontend_autotune(fe, 0);
+		}
 	};
 
 	if (dvb_shutdown_timeout)
@@ -502,7 +619,7 @@
 	fe->thread_pid = 0;
 	mb();
 
-	wake_up_interruptible (&fe->wait_queue);
+	dvb_frontend_wakeup(fe);
 	return 0;
 }
 
@@ -529,13 +646,15 @@
 	}
 
 	/* wake up the frontend thread, so it notices that fe->exit == 1 */
-		wake_up_interruptible (&fe->wait_queue);
+	dvb_frontend_wakeup(fe);
 
 	/* wait until the frontend thread has exited */
 	ret = wait_event_interruptible(fe->wait_queue,0 == fe->thread_pid);
 	if (-ERESTARTSYS != ret) {
+		fe->state = FESTATE_IDLE;
 		return;
 	}
+	fe->state = FESTATE_IDLE;
 
 	/* paranoia check in case a signal arrived */
 	if (fe->thread_pid)
@@ -562,6 +681,7 @@
 	if (down_interruptible (&fe->sem))
 		return -EINTR;
 
+	fe->state = FESTATE_IDLE;
 	fe->exit = 0;
 	fe->thread_pid = 0;
 	mb();
@@ -583,6 +703,7 @@
 {
 	struct dvb_device *dvbdev = file->private_data;
 	struct dvb_frontend_data *fe = dvbdev->priv;
+	struct dvb_frontend_tune_settings fetunesettings;
 	int err = 0;
 
 	dprintk ("%s\n", __FUNCTION__);
@@ -600,13 +721,59 @@
 		if (fe->status)
 			dvb_call_frontend_notifiers (fe, 0);
 		dvb_frontend_internal_ioctl (&fe->frontend, cmd, parg);
+		fe->state = FESTATE_DISEQC;
 		break;
+
 	case FE_SET_FRONTEND:
-		err = dvb_frontend_set_parameters (fe, parg, 1);
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(1);
-		wake_up_interruptible(&fe->wait_queue);
+		fe->state = FESTATE_RETUNE;
+	    
+		memcpy (&fe->parameters, parg,
+			sizeof (struct dvb_frontend_parameters));
+
+		memset(&fetunesettings, 0, sizeof(struct dvb_frontend_tune_settings));
+		memcpy(&fetunesettings.parameters, parg,
+		       sizeof (struct dvb_frontend_parameters));
+		    
+		// force auto frequency inversion if requested
+		if (dvb_force_auto_inversion) {
+			fe->parameters.inversion = INVERSION_AUTO;
+			fetunesettings.parameters.inversion = INVERSION_AUTO;
+		}
+
+		// get frontend-specific tuning settings
+		if (dvb_frontend_internal_ioctl(&fe->frontend, FE_GET_TUNE_SETTINGS, &fetunesettings) == 0) {
+			fe->min_delay = (fetunesettings.min_delay_ms * HZ) / 1000;
+			fe->max_drift = fetunesettings.max_drift;
+			fe->step_size = fetunesettings.step_size;
+		} else {
+			// default values
+			switch(fe->info->type) {
+			case FE_QPSK:
+				fe->min_delay = HZ/20; // default mindelay of 50ms
+				fe->step_size = fe->parameters.u.qpsk.symbol_rate / 16000;
+				fe->max_drift = fe->parameters.u.qpsk.symbol_rate / 2000;
 		break;
+			    
+			case FE_QAM:
+				fe->min_delay = HZ/20; // default mindelay of 50ms
+				fe->step_size = 0;
+				fe->max_drift = 0; // don't want any zigzagging under DVB-C frontends
+				break;
+			    
+			case FE_OFDM:
+				fe->min_delay = HZ/20; // default mindelay of 50ms
+				fe->step_size = fe->info->frequency_stepsize * 2;
+				fe->max_drift = (fe->info->frequency_stepsize * 2) + 1;
+				break;
+			}
+		}
+		if (dvb_override_tune_delay > 0) {
+		       fe->min_delay = (dvb_override_tune_delay * HZ) / 1000;
+		}
+
+		dvb_frontend_add_event (fe, 0);	    
+		break;
+
 	case FE_GET_EVENT:
 		err = dvb_frontend_get_event (fe, parg, file->f_flags);
 		break;
@@ -615,10 +783,26 @@
 			sizeof (struct dvb_frontend_parameters));
 		/*  fall-through... */
 	default:
-		dvb_frontend_internal_ioctl (&fe->frontend, cmd, parg);
+		err = dvb_frontend_internal_ioctl (&fe->frontend, cmd, parg);
 	};
 
 	up (&fe->sem);
+	if (err < 0)
+		return err;
+
+	// Force the CAN_INVERSION_AUTO bit on. If the frontend doesn't do it, it is done for it.
+	if ((cmd == FE_GET_INFO) && (err == 0)) {
+		struct dvb_frontend_info* tmp = (struct dvb_frontend_info*) parg;
+		tmp->caps |= FE_CAN_INVERSION_AUTO;
+	}
+
+	// if the frontend has just been set, wait until the first tune has finished.
+	// This ensures the app doesn't start reading data too quickly, perhaps from the
+	// previous lock, which is REALLY CONFUSING TO DEBUG!
+	if ((cmd == FE_SET_FRONTEND) && (err == 0)) {
+		dvb_frontend_wakeup(fe);
+		err = wait_event_interruptible(fe->wait_queue, fe->state & ~FESTATE_RETUNE);
+	}
 
 	return err;
 }
@@ -915,6 +1099,7 @@
 	fe->frontend.i2c = i2c;
 	fe->frontend.data = data;
 	fe->info = info;
+	fe->inversion = INVERSION_OFF;
 
 	list_for_each (entry, &frontend_ioctl_list) {
 		struct dvb_frontend_ioctl_data *ioctl;
@@ -954,6 +1139,9 @@
 	dvb_register_device (i2c->adapter, &fe->dvbdev, &dvbdev_template,
 			     fe, DVB_DEVICE_FRONTEND);
 
+	if ((info->caps & FE_NEEDS_BENDING) || (dvb_override_frequency_bending == 2))
+		do_frequency_bending = 1;
+    
 	up (&frontend_mutex);
 
 	return 0;
@@ -991,6 +1179,12 @@
 
 MODULE_PARM(dvb_frontend_debug,"i");
 MODULE_PARM(dvb_shutdown_timeout,"i");
+MODULE_PARM(dvb_override_frequency_bending,"i");
+MODULE_PARM(dvb_force_auto_inversion,"i");
+MODULE_PARM(dvb_override_tune_delay,"i");
+
 MODULE_PARM_DESC(dvb_frontend_debug, "enable verbose debug messages");
 MODULE_PARM_DESC(dvb_shutdown_timeout, "wait <shutdown_timeout> seconds after close() before suspending hardware");
-
+MODULE_PARM_DESC(dvb_override_frequency_bending, "0: normal (default), 1: never use frequency bending, 2: always use frequency bending");
+MODULE_PARM_DESC(dvb_force_auto_inversion, "0: normal (default), 1: INVERSION_AUTO forced always");
+MODULE_PARM_DESC(dvb_override_tune_delay, "0: normal (default), >0 => delay in milliseconds to wait for lock after a tune attempt");
diff -urawBN xx-linux-2.6.5/drivers/media/dvb/dvb-core/dvb_frontend.h linux-2.6.5-patched/drivers/media/dvb/dvb-core/dvb_frontend.h
--- xx-linux-2.6.5/drivers/media/dvb/dvb-core/dvb_frontend.h	2003-12-18 03:59:42.000000000 +0100
+++ linux-2.6.5-patched/drivers/media/dvb/dvb-core/dvb_frontend.h	2004-03-11 19:40:44.000000000 +0100
@@ -56,14 +56,25 @@
 	void *data;                /*  can be used by hardware module... */
 };
 
+struct dvb_frontend_tune_settings {
+        int min_delay_ms;
+        int step_size;
+        int max_drift;
+        struct dvb_frontend_parameters parameters;
+};
+
 
 /**
  *   private frontend command ioctl's.
  *   keep them in sync with the public ones defined in linux/dvb/frontend.h
+ * 
+ *   FE_SLEEP. Ioctl used to put frontend into a low power mode.
+ *   FE_INIT. Ioctl used to initialise the frontend.
+ *   FE_GET_TUNE_SETTINGS. Get the frontend-specific tuning loop settings for the supplied set of parameters.
  */
 #define FE_SLEEP              _IO('v', 80)
 #define FE_INIT               _IO('v', 81)
-#define FE_RESET              _IO('v', 82)
+#define FE_GET_TUNE_SETTINGS  _IOWR('v', 83, struct dvb_frontend_tune_settings)
 
 
 extern int
diff -urawBN xx-linux-2.6.5/drivers/media/dvb/dvb-core/dvb_net.c linux-2.6.5-patched/drivers/media/dvb/dvb-core/dvb_net.c
--- xx-linux-2.6.5/drivers/media/dvb/dvb-core/dvb_net.c	2004-03-12 20:31:28.000000000 +0100
+++ linux-2.6.5-patched/drivers/media/dvb/dvb-core/dvb_net.c	2004-04-23 21:52:51.000000000 +0200
@@ -5,33 +5,53 @@
  *                    Ralph Metzler <ralph@convergence.de>
  * Copyright (C) 2002 Ralph Metzler <rjkm@metzlerbros.de>
  *
+ * ULE Decapsulation code:
+ * Copyright (C) 2003 gcs - Global Communication & Services GmbH.
+ *                and Institute for Computer Sciences
+ *                    Salzburg University.
+ *                    Hilmar Linder <hlinder@cosy.sbg.ac.at>
+ *                and Wolfram Stering <wstering@cosy.sbg.ac.at>
+ *
+ * ULE Decaps according to draft-fair-ipdvb-ule-01.txt.
+ *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
  * as published by the Free Software Foundation; either version 2
  * of the License, or (at your option) any later version.
  * 
- *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  * 
- *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  * Or, point your browser to http://www.gnu.org/copyleft/gpl.html
- * 
  */
 
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
 #include <linux/dvb/net.h>
+#include <linux/uio.h>
 #include <asm/uaccess.h>
+#include <linux/crc32.h>
 
 #include "dvb_demux.h"
 #include "dvb_net.h"
 #include "dvb_functions.h"
 
 
+static inline __u32 iov_crc32( __u32 c, struct iovec *iov, unsigned int cnt )
+{
+	unsigned int j;
+	for (j = 0; j < cnt; j++)
+		c = crc32_be( c, iov[j].iov_base, iov[j].iov_len );
+	return c;
+}
+
+
 #if 1
 #define dprintk(x...) printk(x)
 #else
@@ -41,14 +61,46 @@
 
 #define DVB_NET_MULTICAST_MAX 10
 
+#define isprint(c)	((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || (c >= '0' && c <= '9'))
+
+static void hexdump( const unsigned char *buf, unsigned short len )
+{
+	char str[80], octet[10];
+	int ofs, i, l;
+
+	for (ofs = 0; ofs < len; ofs += 16) {
+		sprintf( str, "%03d: ", ofs );
+
+		for (i = 0; i < 16; i++) {
+			if ((i + ofs) < len)
+				sprintf( octet, "%02x ", buf[ofs + i] );
+			else
+				strcpy( octet, "   " );
+
+			strcat( str, octet );
+		}
+		strcat( str, "  " );
+		l = strlen( str );
+
+		for (i = 0; (i < 16) && ((i + ofs) < len); i++)
+			str[l++] = isprint( buf[ofs + i] ) ? buf[ofs + i] : '.';
+
+		str[l] = '\0';
+		printk( KERN_WARNING "%s\n", str );
+	}
+}
+
+
 struct dvb_net_priv {
 	int in_use;
         struct net_device_stats stats;
         char name[6];
 	u16 pid;
+	struct dvb_net *host;
         struct dmx_demux *demux;
 	struct dmx_section_feed *secfeed;
 	struct dmx_section_filter *secfilter;
+	struct dmx_ts_feed *tsfeed;
 	int multi_num;
 	struct dmx_section_filter *multi_secfilter[DVB_NET_MULTICAST_MAX];
 	unsigned char multi_macs[DVB_NET_MULTICAST_MAX][6];
@@ -59,6 +111,18 @@
 #define RX_MODE_PROMISC 3
 	struct work_struct set_multicast_list_wq;
 	struct work_struct restart_net_feed_wq;
+	unsigned char feedtype;
+	int need_pusi;
+	unsigned char tscc;			/* TS continuity counter after sync. */
+	struct sk_buff *ule_skb;
+	unsigned short ule_sndu_len;
+	unsigned short ule_sndu_type;
+	unsigned char ule_sndu_type_1;
+	unsigned char ule_dbit;			/* whether the DestMAC address present
+						 * bit is set or not. */
+	unsigned char ule_ethhdr_complete;	/* whether we have completed the Ethernet
+						 * header for the current ULE SNDU. */
+	int ule_sndu_remain;
 };
 
 
@@ -107,35 +171,442 @@
 	return htons(ETH_P_802_2);
 }
 
+#define TS_SZ	188
+#define TS_SYNC	0x47
+#define TS_TEI	0x80
+#define TS_PUSI	0x40
+#define TS_AF_A	0x20
+#define TS_AF_D	0x10
+
+#define ULE_TEST	0
+#define ULE_BRIDGED	1
+#define ULE_LLC		2
+
+static inline void reset_ule( struct dvb_net_priv *p )
+{
+	p->ule_skb = NULL;
+	p->ule_sndu_len = 0;
+	p->ule_sndu_type = 0;
+	p->ule_sndu_type_1 = 0;
+	p->ule_sndu_remain = 0;
+	p->ule_dbit = 0xFF;
+	p->ule_ethhdr_complete = 0;
+}
+
+static const char eth_dest_addr[] = { 0x0b, 0x0a, 0x09, 0x08, 0x04, 0x03 };
+
+static void dvb_net_ule( struct net_device *dev, const u8 *buf, size_t buf_len )
+{
+	struct dvb_net_priv *priv = (struct dvb_net_priv *)dev->priv;
+	unsigned long skipped = 0L, skblen = 0L;
+	u8 *ts, *ts_end, *from_where = NULL, ts_remain = 0, how_much = 0, new_ts = 1;
+	struct ethhdr *ethh = NULL;
+	unsigned int emergency_count = 0;
+
+	if (dev == NULL) {
+		printk( KERN_ERR "NO netdev struct!\n" );
+		return;
+	}
+
+	for (ts = (char *)buf, ts_end = (char *)buf + buf_len; ts < ts_end; ) {
+
+		if (emergency_count++ > 200) {
+			/* Huh?? */
+			hexdump(ts, TS_SZ);
+			printk(KERN_WARNING "*** LOOP ALERT! ts %p ts_remain %u "
+				"how_much %u, ule_skb %p, ule_len %u, ule_remain %u\n",
+				ts, ts_remain, how_much, priv->ule_skb,
+				priv->ule_sndu_len, priv->ule_sndu_remain);
+			break;
+		}
+
+		if (new_ts) {
+			if ((ts[0] != TS_SYNC) || (ts[1] & TS_TEI)) {
+				printk(KERN_WARNING "Invalid TS cell: SYNC %#x, TEI %u.\n",
+				       ts[0], ts[1] & TS_TEI >> 7);
+				continue;
+			}
+			ts_remain = 184;
+			from_where = ts + 4;
+		}
+		/* Synchronize on PUSI, if required. */
+		if (priv->need_pusi) {
+			if (ts[1] & TS_PUSI) {
+				/* Find beginning of first ULE SNDU in current TS cell.
+				 * priv->need_pusi = 0; */
+				priv->tscc = ts[3] & 0x0F;
+				/* There is a pointer field here. */
+				if (ts[4] > ts_remain) {
+					printk(KERN_ERR "Invalid ULE packet "
+					       "(pointer field %d)\n", ts[4]);
+					continue;
+				}
+				from_where = &ts[5] + ts[4];
+				ts_remain -= 1 + ts[4];
+				skipped = 0;
+			} else {
+				skipped++;
+				continue;
+			}
+		}
+
+		/* Check continuity counter. */
+		if (new_ts) {
+			if ((ts[3] & 0x0F) == priv->tscc)
+				priv->tscc = (priv->tscc + 1) & 0x0F;
+			else {
+				/* TS discontinuity handling: */
+				if (priv->ule_skb) {
+					dev_kfree_skb( priv->ule_skb );
+					/* Prepare for next SNDU. */
+					reset_ule(priv);
+					((struct dvb_net_priv *) dev->priv)->stats.rx_errors++;
+					((struct dvb_net_priv *) dev->priv)->stats.rx_frame_errors++;
+				}
+				/* skip to next PUSI. */
+				printk(KERN_WARNING "TS discontinuity: got %#x, "
+				       "exptected %#x.\n", ts[3] & 0x0F, priv->tscc);
+				priv->need_pusi = 1;
+				continue;
+			}
+			/* If we still have an incomplete payload, but PUSI is
+			 * set, some TS cells are missing.
+			 * This is only possible here, if we missed exactly 16 TS
+			 * cells (continuity counter). */
+			if (ts[1] & TS_PUSI) {
+				if (! priv->need_pusi) {
+					/* printk(KERN_WARNING "Skipping pointer field %u.\n", *from_where); */
+					if (*from_where > 181) {
+						printk(KERN_WARNING "*** Invalid pointer "
+						       "field: %u.  Current TS cell "
+						       "follows:\n", *from_where);
+						hexdump( ts, TS_SZ );
+						printk(KERN_WARNING "-------------------\n");
+					}
+					/* Skip pointer field (we're processing a
+					 * packed payload). */
+					from_where += 1;
+					ts_remain -= 1;
+				} else
+					priv->need_pusi = 0;
+
+				if (priv->ule_sndu_remain > 183) {
+					((struct dvb_net_priv *) dev->priv)->stats.rx_errors++;
+					((struct dvb_net_priv *) dev->priv)->stats.rx_length_errors++;
+					printk(KERN_WARNING "Expected %d more SNDU bytes, but "
+					       "got PUSI.  Flushing incomplete payload.\n",
+					       priv->ule_sndu_remain);
+					dev_kfree_skb(priv->ule_skb);
+					/* Prepare for next SNDU. */
+					reset_ule(priv);
+				}
+			}
+		}
+
+		/* Check if new payload needs to be started. */
+		if (priv->ule_skb == NULL) {
+			/* Start a new payload w/ skb.
+			 * Find ULE header.  It is only guaranteed that the
+			 * length field (2 bytes) is contained in the current
+			 * TS.
+			 * Check ts_remain has to be >= 2 here. */
+			if (ts_remain < 2) {
+				printk(KERN_WARNING "Invalid payload packing: only %d "
+				       "bytes left in TS.  Resyncing.\n", ts_remain);
+				priv->ule_sndu_len = 0;
+				priv->need_pusi = 1;
+				continue;
+			}
+
+			if (! priv->ule_sndu_len) {
+				priv->ule_sndu_len = from_where[0] << 8 | from_where[1];
+				if (priv->ule_sndu_len & 0x8000) {
+					/* D-Bit is set: no dest mac present. */
+					priv->ule_sndu_len &= 0x7FFF;
+					priv->ule_dbit = 1;
+				} else
+					priv->ule_dbit = 0;
+
+				/* printk(KERN_WARNING "ULE D-Bit: %d, SNDU len %u.\n",
+				          priv->ule_dbit, priv->ule_sndu_len); */
+
+				if (priv->ule_sndu_len > 32763) {
+					printk(KERN_WARNING "Invalid ULE SNDU length %u. "
+					       "Resyncing.\n", priv->ule_sndu_len);
+					hexdump(ts, TS_SZ);
+					priv->ule_sndu_len = 0;
+					priv->need_pusi = 1;
+					new_ts = 1;
+					ts += TS_SZ;
+					continue;
+				}
+				ts_remain -= 2;	/* consume the 2 bytes SNDU length. */
+				from_where += 2;
+			}
+
+			/*
+			 * State of current TS:
+			 *   ts_remain (remaining bytes in the current TS cell)
+			 *   0	ule_type is not available now, we need the next TS cell
+			 *   1	the first byte of the ule_type is present
+			 * >=2	full ULE header present, maybe some payload data as well.
+			 */
+			switch (ts_remain) {
+				case 1:
+					priv->ule_sndu_type = from_where[0] << 8;
+					priv->ule_sndu_type_1 = 1; /* first byte of ule_type is set. */
+					/* ts_remain -= 1; from_where += 1;
+					 *   here not necessary, because we continue. */
+				case 0:
+					new_ts = 1;
+					ts += TS_SZ;
+					continue;
+
+				default: /* complete ULE header is present in current TS. */
+					/* Extract ULE type field. */
+					if (priv->ule_sndu_type_1) {
+						priv->ule_sndu_type |= from_where[0];
+						from_where += 1; /* points to payload start. */
+						ts_remain -= 1;
+					} else {
+						/* Complete type is present in new TS. */
+						priv->ule_sndu_type = from_where[0] << 8 | from_where[1];
+						from_where += 2; /* points to payload start. */
+						ts_remain -= 2;
+					}
+					break;
+			}
+
+			if (priv->ule_sndu_type == ULE_TEST) {
+				/* Test SNDU, discarded by the receiver. */
+				printk(KERN_WARNING "Discarding ULE Test SNDU (%d bytes). "
+				       "Resyncing.\n", priv->ule_sndu_len);
+				priv->ule_sndu_len = 0;
+				priv->need_pusi = 1;
+				continue;
+			}
+
+			skblen = priv->ule_sndu_len;	/* Including CRC32 */
+			if (priv->ule_sndu_type != ULE_BRIDGED) {
+				skblen += ETH_HLEN;
+#if 1
+				if (! priv->ule_dbit)
+					skblen -= ETH_ALEN;
+#endif
+			}
+			priv->ule_skb = dev_alloc_skb(skblen);
+			if (priv->ule_skb == NULL) {
+				printk(KERN_NOTICE "%s: Memory squeeze, dropping packet.\n",
+				       dev->name);
+				((struct dvb_net_priv *)dev->priv)->stats.rx_dropped++;
+				return;
+			}
+
+#if 0
+			if (priv->ule_sndu_type != ULE_BRIDGED) {
+				// skb_reserve(priv->ule_skb, 2);    /* longword align L3 header */
+				// Create Ethernet header.
+				ethh = (struct ethhdr *)skb_put( priv->ule_skb, ETH_HLEN );
+				memset( ethh->h_source, 0x00, ETH_ALEN );
+				if (priv->ule_dbit) {
+					// Dest MAC address not present --> generate our own.
+					memcpy( ethh->h_dest, eth_dest_addr, ETH_ALEN );
+				} else {
+					// Dest MAC address could be split across two TS cells.
+					// FIXME: implement.
+
+					printk( KERN_WARNING "%s: got destination MAC "
+						"address.\n", dev->name );
+					memcpy( ethh->h_dest, eth_dest_addr, ETH_ALEN );
+				}
+				ethh->h_proto = htons(priv->ule_sndu_type == ULE_LLC ?
+						      priv->ule_sndu_len : priv->ule_sndu_type);
+			}
+#endif
+			/* this includes the CRC32 _and_ dest mac, if !dbit! */
+			priv->ule_sndu_remain = priv->ule_sndu_len;
+			priv->ule_skb->dev = dev;
+		}
+
+		/* Copy data into our current skb. */
+		how_much = min(priv->ule_sndu_remain, (int)ts_remain);
+		if ((priv->ule_ethhdr_complete < ETH_ALEN) &&
+		    (priv->ule_sndu_type != ULE_BRIDGED)) {
+			ethh = (struct ethhdr *)priv->ule_skb->data;
+			if (! priv->ule_dbit) {
+				if (how_much >= (ETH_ALEN - priv->ule_ethhdr_complete)) {
+					/* copy dest mac address. */
+					memcpy(skb_put(priv->ule_skb,
+						       (ETH_ALEN - priv->ule_ethhdr_complete)),
+					       from_where,
+					       (ETH_ALEN - priv->ule_ethhdr_complete));
+					memset(ethh->h_source, 0x00, ETH_ALEN);
+					ethh->h_proto = htons(priv->ule_sndu_type == ULE_LLC ?
+							      priv->ule_sndu_len :
+							      priv->ule_sndu_type);
+					skb_put(priv->ule_skb, ETH_ALEN + 2);
+
+					how_much -= (ETH_ALEN - priv->ule_ethhdr_complete);
+					priv->ule_sndu_remain -= (ETH_ALEN -
+								  priv->ule_ethhdr_complete);
+					ts_remain -= (ETH_ALEN - priv->ule_ethhdr_complete);
+					from_where += (ETH_ALEN - priv->ule_ethhdr_complete);
+					priv->ule_ethhdr_complete = ETH_ALEN;
+				}
+			} else {
+				/* Generate whole Ethernet header. */
+				memcpy(ethh->h_dest, eth_dest_addr, ETH_ALEN);
+				memset(ethh->h_source, 0x00, ETH_ALEN);
+				ethh->h_proto = htons(priv->ule_sndu_type == ULE_LLC ?
+						      priv->ule_sndu_len : priv->ule_sndu_type);
+				skb_put(priv->ule_skb, ETH_HLEN);
+				priv->ule_ethhdr_complete = ETH_ALEN;
+			}
+		}
+		/* printk(KERN_WARNING "Copying %u bytes, ule_sndu_remain = %u, "
+		          "ule_sndu_len = %u.\n", how_much, priv->ule_sndu_remain,
+			  priv->ule_sndu_len); */
+		memcpy(skb_put(priv->ule_skb, how_much), from_where, how_much);
+		priv->ule_sndu_remain -= how_much;
+		ts_remain -= how_much;
+		from_where += how_much;
+
+		if ((priv->ule_ethhdr_complete < ETH_ALEN) &&
+		    (priv->ule_sndu_type != ULE_BRIDGED)) {
+			priv->ule_ethhdr_complete += how_much;
+		}
+
+		/* Check for complete payload. */
+		if (priv->ule_sndu_remain <= 0) {
+			/* Check CRC32, we've got it in our skb already. */
+			unsigned short ulen = htons(priv->ule_sndu_len);
+			unsigned short utype = htons(priv->ule_sndu_type);
+			struct iovec iov[4] = {
+				{ &ulen, sizeof ulen },
+				{ &utype, sizeof utype },
+				{ NULL, 0 },
+				{ priv->ule_skb->data + ETH_HLEN,
+					priv->ule_skb->len - ETH_HLEN - 4 }
+			};
+			unsigned long ule_crc = ~0L, expected_crc;
+			if (priv->ule_dbit) {
+				/* Set D-bit for CRC32 verification,
+				 * if it was set originally. */
+				ulen |= 0x0080;
+			} else {
+				iov[2].iov_base = priv->ule_skb->data;
+				iov[2].iov_len = ETH_ALEN;
+			}
+			ule_crc = iov_crc32(ule_crc, iov, 4);
+			expected_crc = *((u8 *)priv->ule_skb->tail - 4) << 24 |
+				*((u8 *)priv->ule_skb->tail - 3) << 16 |
+				*((u8 *)priv->ule_skb->tail - 2) << 8 |
+				*((u8 *)priv->ule_skb->tail - 1);
+			if (ule_crc != expected_crc) {
+				printk(KERN_WARNING "CRC32 check %s: %#lx / %#lx.\n",
+				       ule_crc != expected_crc ? "FAILED" : "OK",
+				       ule_crc, expected_crc);
+				hexdump(priv->ule_skb->data + ETH_HLEN,
+					priv->ule_skb->len - ETH_HLEN);
+
+				((struct dvb_net_priv *) dev->priv)->stats.rx_errors++;
+				((struct dvb_net_priv *) dev->priv)->stats.rx_crc_errors++;
+				dev_kfree_skb(priv->ule_skb);
+			} else {
+				/* CRC32 was OK. Remove it from skb. */
+				priv->ule_skb->tail -= 4;
+				priv->ule_skb->len -= 4;
+				/* Stuff into kernel's protocol stack. */
+				priv->ule_skb->protocol = dvb_net_eth_type_trans(priv->ule_skb, dev);
+				/* If D-bit is set (i.e. destination MAC address not present),
+				 * receive the packet anyhw. */
+				/* if (priv->ule_dbit && skb->pkt_type == PACKET_OTHERHOST) */
+					priv->ule_skb->pkt_type = PACKET_HOST;
+				((struct dvb_net_priv *) dev->priv)->stats.rx_packets++;
+				((struct dvb_net_priv *) dev->priv)->stats.rx_bytes += priv->ule_skb->len;
+				netif_rx(priv->ule_skb);
+			}
+			/* Prepare for next SNDU. */
+			reset_ule(priv);
+		}
+
+		/* More data in current TS (look at the bytes following the CRC32)? */
+		if (ts_remain >= 2 && *((unsigned short *)from_where) != 0xFFFF) {
+			/* Next ULE SNDU starts right there. */
+			new_ts = 0;
+			priv->ule_skb = NULL;
+			priv->ule_sndu_type_1 = 0;
+			priv->ule_sndu_len = 0;
+			// printk(KERN_WARNING "More data in current TS: [%#x %#x %#x %#x]\n",
+			//	*(from_where + 0), *(from_where + 1),
+			//	*(from_where + 2), *(from_where + 3));
+			// printk(KERN_WARNING "ts @ %p, stopped @ %p:\n", ts, from_where + 0);
+			// hexdump(ts, 188);
+		} else {
+			new_ts = 1;
+			ts += TS_SZ;
+			if (priv->ule_skb == NULL) {
+				priv->need_pusi = 1;
+				priv->ule_sndu_type_1 = 0;
+				priv->ule_sndu_len = 0;
+			}
+		}
+	}	/* for all available TS cells */
+}
+
+static int dvb_net_ts_callback(const u8 *buffer1, size_t buffer1_len,
+			       const u8 *buffer2, size_t buffer2_len,
+			       struct dmx_ts_feed *feed, enum dmx_success success)
+{
+	struct net_device *dev = (struct net_device *)feed->priv;
+
+	if (buffer2 != 0)
+		printk(KERN_WARNING "buffer2 not 0: %p.\n", buffer2);
+	if (buffer1_len > 32768)
+		printk(KERN_WARNING "length > 32k: %u.\n", buffer1_len);
+	/* printk("TS callback: %u bytes, %u TS cells @ %p.\n",
+	          buffer1_len, buffer1_len / TS_SZ, buffer1); */
+	dvb_net_ule(dev, buffer1, buffer1_len);
+	return 0;
+}
+
 
 static void dvb_net_sec(struct net_device *dev, u8 *pkt, int pkt_len)
 {
         u8 *eth;
         struct sk_buff *skb;
+	struct net_device_stats *stats = &(((struct dvb_net_priv *) dev->priv)->stats);
 
 	/* note: pkt_len includes a 32bit checksum */
 	if (pkt_len < 16) {
 		printk("%s: IP/MPE packet length = %d too small.\n",
 			dev->name, pkt_len);
-		((struct dvb_net_priv *) dev->priv)->stats.rx_errors++;
-		((struct dvb_net_priv *) dev->priv)->stats.rx_length_errors++;
+		stats->rx_errors++;
+		stats->rx_length_errors++;
 		return;
 	}
+/* it seems some ISPs manage to screw up here, so we have to
+ * relax the error checks... */
+#if 0
 	if ((pkt[5] & 0xfd) != 0xc1) {
 		/* drop scrambled or broken packets */
-		((struct dvb_net_priv *) dev->priv)->stats.rx_errors++;
-		((struct dvb_net_priv *) dev->priv)->stats.rx_crc_errors++;
+#else
+	if ((pkt[5] & 0x3c) != 0x00) {
+		/* drop scrambled */
+#endif
+		stats->rx_errors++;
+		stats->rx_crc_errors++;
 		return;
 	}
 	if (pkt[5] & 0x02) {
 		//FIXME: handle LLC/SNAP
-                ((struct dvb_net_priv *)dev->priv)->stats.rx_dropped++;
+                stats->rx_dropped++;
                 return;
         }
 	if (pkt[7]) {
 		/* FIXME: assemble datagram from multiple sections */
-		((struct dvb_net_priv *) dev->priv)->stats.rx_errors++;
-		((struct dvb_net_priv *) dev->priv)->stats.rx_frame_errors++;
+		stats->rx_errors++;
+		stats->rx_frame_errors++;
 		return;
 	}
 
@@ -144,7 +615,7 @@
 	 */
 	if (!(skb = dev_alloc_skb(pkt_len - 4 - 12 + 14 + 2))) {
 		//printk(KERN_NOTICE "%s: Memory squeeze, dropping packet.\n", dev->name);
-		((struct dvb_net_priv *) dev->priv)->stats.rx_dropped++;
+		stats->rx_dropped++;
 		return;
 	}
 	skb_reserve(skb, 2);    /* longword align L3 header */
@@ -169,12 +640,12 @@
 
 	skb->protocol = dvb_net_eth_type_trans(skb, dev);
         
-        ((struct dvb_net_priv *)dev->priv)->stats.rx_packets++;
-        ((struct dvb_net_priv *)dev->priv)->stats.rx_bytes+=skb->len;
+	stats->rx_packets++;
+	stats->rx_bytes+=skb->len;
         netif_rx(skb);
 }
  
-static int dvb_net_callback(const u8 *buffer1, size_t buffer1_len,
+static int dvb_net_sec_callback(const u8 *buffer1, size_t buffer1_len,
 		 const u8 *buffer2, size_t buffer2_len,
 		 struct dmx_section_filter *filter,
 		 enum dmx_success success)
@@ -199,7 +670,7 @@
 static u8 mac_allmulti[6]={0x01, 0x00, 0x5e, 0x00, 0x00, 0x00};
 static u8 mask_promisc[6]={0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
 
-static int dvb_net_filter_set(struct net_device *dev, 
+static int dvb_net_filter_sec_set(struct net_device *dev,
 		   struct dmx_section_filter **secfilter,
 		   u8 *mac, u8 *mac_mask)
 {
@@ -257,10 +728,12 @@
 
 	priv->secfeed=0;
 	priv->secfilter=0;
+	priv->tsfeed = 0;
 
+	if (priv->feedtype == DVB_NET_FEEDTYPE_MPE) {
 	dprintk("%s: alloc secfeed\n", __FUNCTION__);
 	ret=demux->allocate_section_feed(demux, &priv->secfeed, 
-					 dvb_net_callback);
+					 dvb_net_sec_callback);
 	if (ret<0) {
 		printk("%s: could not allocate section feed\n", dev->name);
 		return ret;
@@ -277,41 +750,74 @@
 
 	if (priv->rx_mode != RX_MODE_PROMISC) {
 		dprintk("%s: set secfilter\n", __FUNCTION__);
-		dvb_net_filter_set(dev, &priv->secfilter, mac, mask_normal);
+			dvb_net_filter_sec_set(dev, &priv->secfilter, mac, mask_normal);
 	}
 
 	switch (priv->rx_mode) {
 	case RX_MODE_MULTI:
 		for (i = 0; i < priv->multi_num; i++) {
 			dprintk("%s: set multi_secfilter[%d]\n", __FUNCTION__, i);
-			dvb_net_filter_set(dev, &priv->multi_secfilter[i],
+				dvb_net_filter_sec_set(dev, &priv->multi_secfilter[i],
 					   priv->multi_macs[i], mask_normal);
 		}
 		break;
 	case RX_MODE_ALL_MULTI:
 		priv->multi_num=1;
 		dprintk("%s: set multi_secfilter[0]\n", __FUNCTION__);
-		dvb_net_filter_set(dev, &priv->multi_secfilter[0],
+			dvb_net_filter_sec_set(dev, &priv->multi_secfilter[0],
 				   mac_allmulti, mask_allmulti);
 		break;
 	case RX_MODE_PROMISC:
 		priv->multi_num=0;
 		dprintk("%s: set secfilter\n", __FUNCTION__);
-		dvb_net_filter_set(dev, &priv->secfilter, mac, mask_promisc);
+			dvb_net_filter_sec_set(dev, &priv->secfilter, mac, mask_promisc);
 		break;
 	}
 	
 	dprintk("%s: start filtering\n", __FUNCTION__);
 	priv->secfeed->start_filtering(priv->secfeed);
+	} else if (priv->feedtype == DVB_NET_FEEDTYPE_ULE) {
+		struct timespec timeout = { 0, 30000000 }; // 30 msec
+
+		/* we have payloads encapsulated in TS */
+		dprintk("%s: alloc tsfeed\n", __FUNCTION__);
+		ret = demux->allocate_ts_feed(demux, &priv->tsfeed, dvb_net_ts_callback);
+		if (ret < 0) {
+			printk("%s: could not allocate ts feed\n", dev->name);
+			return ret;
+		}
+
+		/* Set netdevice pointer for ts decaps callback. */
+		priv->tsfeed->priv = (void *)dev;
+		ret = priv->tsfeed->set(priv->tsfeed, priv->pid,
+					TS_PACKET, DMX_TS_PES_OTHER,
+					188 * 100, /* nr. of bytes delivered per callback */
+					32768,     /* circular buffer size */
+					0,         /* descramble */
+					timeout);
+
+		if (ret < 0) {
+			printk("%s: could not set ts feed\n", dev->name);
+			priv->demux->release_ts_feed(priv->demux, priv->tsfeed);
+			priv->tsfeed = 0;
+			return ret;
+		}
+
+		dprintk("%s: start filtering\n", __FUNCTION__);
+		priv->tsfeed->start_filtering(priv->tsfeed);
+	} else
+		return -EINVAL;
+
 	return 0;
 }
 
-static void dvb_net_feed_stop(struct net_device *dev)
+static int dvb_net_feed_stop(struct net_device *dev)
 {
 	struct dvb_net_priv *priv = (struct dvb_net_priv*) dev->priv;
 	int i;
 
 	dprintk("%s\n", __FUNCTION__);
+	if (priv->feedtype == DVB_NET_FEEDTYPE_MPE) {
         if (priv->secfeed) {
 		if (priv->secfeed->is_filtering) {
 			dprintk("%s: stop secfeed\n", __FUNCTION__);
@@ -327,7 +833,8 @@
 
 		for (i=0; i<priv->multi_num; i++) {
 			if (priv->multi_secfilter[i]) {
-				dprintk("%s: release multi_filter[%d]\n", __FUNCTION__, i);
+					dprintk("%s: release multi_filter[%d]\n",
+						__FUNCTION__, i);
 				priv->secfeed->release_filter(priv->secfeed,
 						       priv->multi_secfilter[i]);
 			priv->multi_secfilter[i]=0;
@@ -338,6 +845,20 @@
 		priv->secfeed=0;
 	} else
 		printk("%s: no feed to stop\n", dev->name);
+	} else if (priv->feedtype == DVB_NET_FEEDTYPE_ULE) {
+		if (priv->tsfeed) {
+			if (priv->tsfeed->is_filtering) {
+				dprintk("%s: stop tsfeed\n", __FUNCTION__);
+				priv->tsfeed->stop_filtering(priv->tsfeed);
+			}
+			priv->demux->release_ts_feed(priv->demux, priv->tsfeed);
+			priv->tsfeed = 0;
+		}
+		else
+			printk("%s: no ts feed to stop\n", dev->name);
+	} else
+		return -EINVAL;
+	return 0;
 }
 
 
@@ -446,8 +967,7 @@
 	struct dvb_net_priv *priv = (struct dvb_net_priv*) dev->priv;
 
 	priv->in_use--;
-        dvb_net_feed_stop(dev);
-	return 0;
+        return dvb_net_feed_stop(dev);
 }
 
 static struct net_device_stats * dvb_net_get_stats(struct net_device *dev)
@@ -489,14 +1007,15 @@
 	return i;
 }
 
-
-static int dvb_net_add_if(struct dvb_net *dvbnet, u16 pid)
+static int dvb_net_add_if(struct dvb_net *dvbnet, u16 pid, u8 feedtype)
 {
         struct net_device *net;
 	struct dvb_net_priv *priv;
 	int result;
 	int if_num;
  
+	if (feedtype != DVB_NET_FEEDTYPE_MPE && feedtype != DVB_NET_FEEDTYPE_ULE)
+		return -EINVAL;
 	if ((if_num = get_if(dvbnet)) < 0)
 		return -EINVAL;
 
@@ -516,6 +1035,10 @@
         priv->demux = dvbnet->demux;
         priv->pid = pid;
 	priv->rx_mode = RX_MODE_UNI;
+	priv->need_pusi = 1;
+	priv->tscc = 0;
+	priv->feedtype = feedtype;
+	reset_ule(priv);
 
 	INIT_WORK(&priv->set_multicast_list_wq, wq_set_multicast_list, net);
 	INIT_WORK(&priv->restart_net_feed_wq, wq_restart_net_feed, net);
@@ -570,7 +1091,7 @@
 		
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		result=dvb_net_add_if(dvbnet, dvbnetif->pid);
+		result=dvb_net_add_if(dvbnet, dvbnetif->pid, dvbnetif->feedtype);
 		if (result<0)
 			return result;
 		dvbnetif->if_num=result;
@@ -584,19 +1105,50 @@
 
 		if (dvbnetif->if_num >= DVB_NET_DEVICES_MAX ||
 		    !dvbnet->state[dvbnetif->if_num])
-			return -EFAULT;
+			return -EINVAL;
 
-		netdev=(struct net_device*)&dvbnet->device[dvbnetif->if_num];
+		netdev = dvbnet->device[dvbnetif->if_num];
 		priv_data=(struct dvb_net_priv*)netdev->priv;
 		dvbnetif->pid=priv_data->pid;
+		dvbnetif->feedtype=priv_data->feedtype;
 		break;
 	}
 	case NET_REMOVE_IF:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
 		return dvb_net_remove_if(dvbnet, (int) (long) parg);
-	default:
+
+	/* binary compatiblity cruft */
+	case __NET_ADD_IF_OLD:
+	{
+		struct __dvb_net_if_old *dvbnetif=(struct __dvb_net_if_old *)parg;
+		int result;
+
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		result=dvb_net_add_if(dvbnet, dvbnetif->pid, DVB_NET_FEEDTYPE_MPE);
+		if (result<0)
+			return result;
+		dvbnetif->if_num=result;
+		break;
+	}
+	case __NET_GET_IF_OLD:
+	{
+		struct net_device *netdev;
+		struct dvb_net_priv *priv_data;
+		struct __dvb_net_if_old *dvbnetif=(struct __dvb_net_if_old *)parg;
+
+		if (dvbnetif->if_num >= DVB_NET_DEVICES_MAX ||
+		    !dvbnet->state[dvbnetif->if_num])
 		return -EINVAL;
+
+		netdev = dvbnet->device[dvbnetif->if_num];
+		priv_data=(struct dvb_net_priv*)netdev->priv;
+		dvbnetif->pid=priv_data->pid;
+		break;
+	}
+	default:
+		return -ENOTTY;
 	}
 	return 0;
 }
diff -urawBN xx-linux-2.6.5/include/linux/dvb/frontend.h linux-2.6.5-patched/include/linux/dvb/frontend.h
--- xx-linux-2.6.5/include/linux/dvb/frontend.h	2003-12-18 03:58:49.000000000 +0100
+++ linux-2.6.5-patched/include/linux/dvb/frontend.h	2004-03-11 19:40:45.000000000 +0100
@@ -59,9 +59,9 @@
 	FE_CAN_BANDWIDTH_AUTO         = 0x40000,
 	FE_CAN_GUARD_INTERVAL_AUTO    = 0x80000,
 	FE_CAN_HIERARCHY_AUTO         = 0x100000,
-	FE_CAN_RECOVER                = 0x20000000,
-	FE_CAN_CLEAN_SETUP            = 0x40000000,
-	FE_CAN_MUTE_TS                = 0x80000000
+	FE_NEEDS_BENDING              = 0x20000000, // frontend requires frequency bending
+	FE_CAN_RECOVER                = 0x40000000, // frontend can recover from a cable unplug automatically
+	FE_CAN_MUTE_TS                = 0x80000000  // frontend can stop spurious TS data output
 } fe_caps_t;
 
 
diff -urawBN xx-linux-2.6.5/include/linux/dvb/net.h linux-2.6.5-patched/include/linux/dvb/net.h
--- xx-linux-2.6.5/include/linux/dvb/net.h	2003-12-18 03:58:08.000000000 +0100
+++ linux-2.6.5-patched/include/linux/dvb/net.h	2004-04-14 19:10:57.000000000 +0200
@@ -30,6 +30,9 @@
 struct dvb_net_if {
 	__u16 pid;
 	__u16 if_num;
+	__u8 feedtype;
+#define DVB_NET_FEEDTYPE_MPE 0	/* multi protocol encapsulation */
+#define DVB_NET_FEEDTYPE_ULE 1	/* ultra lightweight encapsulation */
 };
 
 
@@ -37,5 +40,14 @@
 #define NET_REMOVE_IF              _IO('o', 53)
 #define NET_GET_IF                 _IOWR('o', 54, struct dvb_net_if)
 
-#endif /*_DVBNET_H_*/
 
+/* binary compatibility cruft: */
+struct __dvb_net_if_old {
+	__u16 pid;
+	__u16 if_num;
+};
+#define __NET_ADD_IF_OLD _IOWR('o', 52, struct __dvb_net_if_old)
+#define __NET_GET_IF_OLD _IOWR('o', 54, struct __dvb_net_if_old)
+
+
+#endif /*_DVBNET_H_*/


