Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261737AbULJPxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbULJPxp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 10:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbULJPxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 10:53:45 -0500
Received: from mail.convergence.de ([212.227.36.84]:44190 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S261737AbULJPiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 10:38:52 -0500
Message-ID: <41B9C2D9.4060203@linuxtv.org>
Date: Fri, 10 Dec 2004 16:38:01 +0100
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][DVB][4/6] dvb-core update
Content-Type: multipart/mixed;
 boundary="------------060702060506070703060904"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060702060506070703060904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------060702060506070703060904
Content-Type: text/plain;
 name="04-dvb-dvb-core.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="04-dvb-dvb-core.diff"

- [DVB] dvb-core: remove unused frequency bending code, simplify internal frontend handling
- [DVB] dvb-net: add ULE dvb-net support according to draft-ietf-ipdvb-ule-03

Signed-off-by: Michael Hunold <hunold@linuxtv.org>

diff -uraNwB linux-2.6.10-rc3-bk3/drivers/media/dvb/dvb-core/dvb_frontend.c linux-2.6.10-rc3-bk3-p/drivers/media/dvb/dvb-core/dvb_frontend.c
--- linux-2.6.10-rc3-bk3/drivers/media/dvb/dvb-core/dvb_frontend.c	2004-12-08 14:31:32.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/drivers/media/dvb/dvb-core/dvb_frontend.c	2004-12-08 14:57:35.000000000 +0100
@@ -43,18 +43,14 @@
 
 static int dvb_frontend_debug;
 static int dvb_shutdown_timeout = 5;
-static int dvb_override_frequency_bending;
 static int dvb_force_auto_inversion;
 static int dvb_override_tune_delay;
 static int dvb_powerdown_on_sleep = 1;
-static int do_frequency_bending;
 
 module_param_named(frontend_debug, dvb_frontend_debug, int, 0644);
 MODULE_PARM_DESC(dvb_frontend_debug, "Turn on/off frontend core debugging (default:off).");
 module_param(dvb_shutdown_timeout, int, 0444);
 MODULE_PARM_DESC(dvb_shutdown_timeout, "wait <shutdown_timeout> seconds after close() before suspending hardware");
-module_param(dvb_override_frequency_bending, int, 0444);
-MODULE_PARM_DESC(dvb_override_frequency_bending, "0: normal (default), 1: never use frequency bending, 2: always use frequency bending");
 module_param(dvb_force_auto_inversion, int, 0444);
 MODULE_PARM_DESC(dvb_force_auto_inversion, "0: normal (default), 1: INVERSION_AUTO forced always");
 module_param(dvb_override_tune_delay, int, 0444);
@@ -91,113 +87,9 @@
  * FESTATE_LOSTLOCK. When the lock has been lost, and we're searching it again.
  */
 
-#define MAX_EVENT 8
-
-struct dvb_fe_events {
-	struct dvb_frontend_event events[MAX_EVENT];
-	int                       eventw;
-	int                       eventr;
-	int                       overflow;
-	wait_queue_head_t         wait_queue;
-	struct semaphore          sem;
-};
-
-
-struct dvb_frontend_data {
-	struct dvb_frontend *frontend;
-	struct dvb_device *dvbdev;
-	struct dvb_frontend_parameters parameters;
-	struct dvb_fe_events events;
-	struct semaphore sem;
-	struct list_head list_head;
-	wait_queue_head_t wait_queue;
-	pid_t thread_pid;
-	unsigned long release_jiffies;
-	int state;
-	int bending;
-	int lnb_drift;
-	int inversion;
-	int auto_step;
-	int auto_sub_step;
-	int started_auto_step;
-	int min_delay;
-	int max_drift;
-	int step_size;
-	int exit;
-	int wakeup;
-        fe_status_t status;
-};
-
-static LIST_HEAD(frontend_list);
-
 static DECLARE_MUTEX(frontend_mutex);
 
-
-
-/**
- *  if 2 tuners are located side by side you can get interferences when
- *  they try to tune to the same frequency, so both lose sync.
- *  We will slightly mistune in this case. The AFC of the demodulator
- *  should make it still possible to receive the requested transponder 
- *  on both tuners...
- */
-static void dvb_bend_frequency (struct dvb_frontend_data *this_fe, int recursive)
-{
-	struct list_head *entry;
-	int stepsize = this_fe->frontend->ops->info.frequency_stepsize;
-	int this_fe_adap_num = this_fe->frontend->dvb->num;
-	int frequency;
-
-	if (!stepsize || recursive > 10) {
-		printk ("%s: too deep recursion, check frequency_stepsize "
-			"in your frontend code!\n", __FUNCTION__);
-		return;
-	}
-
-	dprintk ("%s\n", __FUNCTION__);
-
-	if (!recursive) {
-		if (down_interruptible (&frontend_mutex))
-			return;
-
-		this_fe->bending = 0;
-	}
-
-	list_for_each (entry, &frontend_list) {
-		struct dvb_frontend_data *fe;
-		int f;
-
-		fe = list_entry (entry, struct dvb_frontend_data, list_head);
-
-		if (fe->frontend->dvb->num != this_fe_adap_num)
-			continue;
-
-		f = fe->parameters.frequency;
-		f += fe->lnb_drift;
-		f += fe->bending;
-
-		frequency = this_fe->parameters.frequency;
-		frequency += this_fe->lnb_drift;
-		frequency += this_fe->bending;
-
-		if (this_fe != fe && (fe->state != FESTATE_IDLE) &&
-                    frequency > f - stepsize && frequency < f + stepsize)
-		{
-			if (recursive % 2)
-				this_fe->bending += stepsize;
-			else
-				this_fe->bending = -this_fe->bending;
-
-			dvb_bend_frequency (this_fe, recursive + 1);
-			goto done;
-		}
-	}
-done:
-	if (!recursive)
-		up (&frontend_mutex);
-}
-
-static void dvb_frontend_add_event (struct dvb_frontend_data *fe, fe_status_t status)
+static void dvb_frontend_add_event(struct dvb_frontend *fe, fe_status_t status)
 {
 	struct dvb_fe_events *events = &fe->events;
 	struct dvb_frontend_event *e;
@@ -221,7 +113,8 @@
 		sizeof (struct dvb_frontend_parameters));
 
 	if (status & FE_HAS_LOCK)
-		if (fe->frontend->ops->get_frontend) fe->frontend->ops->get_frontend(fe->frontend, &e->parameters);
+		if (fe->ops->get_frontend)
+			fe->ops->get_frontend(fe, &e->parameters);
 
 	events->eventw = wp;
 
@@ -232,8 +125,7 @@
 	wake_up_interruptible (&events->wait_queue);
 }
 
-
-static int dvb_frontend_get_event (struct dvb_frontend_data *fe,
+static int dvb_frontend_get_event(struct dvb_frontend *fe,
 			    struct dvb_frontend_event *event, int flags)
 {
         struct dvb_fe_events *events = &fe->events;
@@ -276,13 +168,14 @@
         return 0;
 }
 
-static void dvb_frontend_init (struct dvb_frontend_data *fe)
+static void dvb_frontend_init(struct dvb_frontend *fe)
 {
 	dprintk ("DVB: initialising frontend %i (%s)...\n",
-		 fe->frontend->dvb->num,
-		 fe->frontend->ops->info.name);
+		 fe->dvb->num,
+		 fe->ops->info.name);
 
-	if (fe->frontend->ops->init) fe->frontend->ops->init(fe->frontend);
+	if (fe->ops->init)
+		fe->ops->init(fe);
 }
 
 static void update_delay (int *quality, int *delay, int min_delay, int locked)
@@ -309,7 +202,7 @@
  * @param check_wrapped Checks if an iteration has completed. DO NOT SET ON THE FIRST ATTEMPT
  * @returns Number of complete iterations that have been performed.
  */
-static int dvb_frontend_autotune(struct dvb_frontend_data *fe, int check_wrapped)
+static int dvb_frontend_autotune(struct dvb_frontend *fe, int check_wrapped)
 {
 	int autoinversion;
 	int ready = 0;
@@ -317,7 +210,7 @@
 	u32 original_frequency = fe->parameters.frequency;
 
 	/* are we using autoinversion? */
-	autoinversion = ((!(fe->frontend->ops->info.caps & FE_CAN_INVERSION_AUTO)) &&
+	autoinversion = ((!(fe->ops->info.caps & FE_CAN_INVERSION_AUTO)) &&
 			 (fe->parameters.inversion == INVERSION_AUTO));
 
 	/* setup parameters correctly */
@@ -378,19 +271,18 @@
 		return 1;
 		}
 
-	/* perform frequency bending if necessary */
-	if ((dvb_override_frequency_bending != 1) && do_frequency_bending)
-		dvb_bend_frequency(fe, 0);
-
-	dprintk("%s: drift:%i bending:%i inversion:%i auto_step:%i "
+	dprintk("%s: drift:%i inversion:%i auto_step:%i "
 		"auto_sub_step:%i started_auto_step:%i\n",
-		__FUNCTION__, fe->lnb_drift, fe->bending, fe->inversion,
+		__FUNCTION__, fe->lnb_drift, fe->inversion,
 		fe->auto_step, fe->auto_sub_step, fe->started_auto_step);
     
 	/* set the frontend itself */
-	fe->parameters.frequency += fe->lnb_drift + fe->bending;
-	if (autoinversion) fe->parameters.inversion = fe->inversion;
-	if (fe->frontend->ops->set_frontend) fe->frontend->ops->set_frontend(fe->frontend, &fe->parameters);
+	fe->parameters.frequency += fe->lnb_drift;
+	if (autoinversion)
+		fe->parameters.inversion = fe->inversion;
+	if (fe->ops->set_frontend)
+		fe->ops->set_frontend(fe, &fe->parameters);
+
 	fe->parameters.frequency = original_frequency;
 	fe->parameters.inversion = original_inversion;
 
@@ -398,9 +290,7 @@
 	return 0;
 }
 
-
-
-static int dvb_frontend_is_exiting (struct dvb_frontend_data *fe)
+static int dvb_frontend_is_exiting(struct dvb_frontend *fe)
 {
 	if (fe->exit)
 		return 1;
@@ -412,7 +302,7 @@
 	return 0;
 }
 
-static int dvb_frontend_should_wakeup (struct dvb_frontend_data *fe)
+static int dvb_frontend_should_wakeup(struct dvb_frontend *fe)
 {
 	if (fe->wakeup) {
 		fe->wakeup = 0;
@@ -421,7 +311,8 @@
 	return dvb_frontend_is_exiting(fe);
 }
 
-static void dvb_frontend_wakeup (struct dvb_frontend_data *fe) {
+static void dvb_frontend_wakeup(struct dvb_frontend *fe)
+{
 	fe->wakeup = 1;
 	wake_up_interruptible(&fe->wait_queue);
 }
@@ -431,7 +322,7 @@
  */
 static int dvb_frontend_thread (void *data)
 {
-	struct dvb_frontend_data *fe = (struct dvb_frontend_data *) data;
+	struct dvb_frontend *fe = (struct dvb_frontend *) data;
 	unsigned long timeout;
 	char name [15];
 	int quality = 0, delay = 3*HZ;
@@ -440,8 +331,7 @@
 
 	dprintk ("%s\n", __FUNCTION__);
 
-	snprintf (name, sizeof(name), "kdvb-fe-%i",
-		  fe->frontend->dvb->num);
+	snprintf (name, sizeof(name), "kdvb-fe-%i", fe->dvb->num);
 
         lock_kernel ();
         daemonize (name);
@@ -455,7 +345,9 @@
 	while (1) {
 		up (&fe->sem);      /* is locked when we enter the thread... */
 
-		timeout = wait_event_interruptible_timeout(fe->wait_queue,0 != dvb_frontend_should_wakeup (fe), delay);
+		timeout = wait_event_interruptible_timeout(fe->wait_queue,
+							   dvb_frontend_should_wakeup(fe),
+							   delay);
 		if (0 != dvb_frontend_is_exiting (fe)) {
 			/* got signal or quitting */
 			break;
@@ -474,11 +366,13 @@
 			continue;
 		}
 
+retune:
 		/* get the frontend status */
 		if (fe->state & FESTATE_RETUNE) {
 			s = 0;
 		} else {
-			if (fe->frontend->ops->read_status) fe->frontend->ops->read_status(fe->frontend, &s);
+			if (fe->ops->read_status)
+				fe->ops->read_status(fe, &s);
 			if (s != fe->status) {
 			dvb_frontend_add_event (fe, s);
 				fe->status = s;
@@ -490,7 +384,7 @@
 			fe->state = FESTATE_TUNED;
 
 			/* if we're tuned, then we have determined the correct inversion */
-			if ((!(fe->frontend->ops->info.caps & FE_CAN_INVERSION_AUTO)) &&
+			if ((!(fe->ops->info.caps & FE_CAN_INVERSION_AUTO)) &&
 			    (fe->parameters.inversion == INVERSION_AUTO)) {
 				fe->parameters.inversion = fe->inversion;
 			}
@@ -516,7 +410,7 @@
 		/* don't actually do anything if we're in the LOSTLOCK state,
 		 * the frontend is set to FE_CAN_RECOVER, and the max_drift is 0 */
 		if ((fe->state & FESTATE_LOSTLOCK) && 
-		    (fe->frontend->ops->info.caps & FE_CAN_RECOVER) && (fe->max_drift == 0)) {
+		    (fe->ops->info.caps & FE_CAN_RECOVER) && (fe->max_drift == 0)) {
 			update_delay(&quality, &delay, fe->min_delay, s & FE_HAS_LOCK);
 						continue;
 				}
@@ -560,7 +454,7 @@
 			 * occurs */
 			if (fe->state & FESTATE_RETUNE) {
 				fe->state = FESTATE_TUNING_FAST;
-				wake_up_interruptible(&fe->wait_queue);
+				goto retune;
 			}
 		}
 
@@ -572,12 +466,14 @@
 			 * state until we get a lock */
 			dvb_frontend_autotune(fe, 0);
 		}
-	};
+	}
 
 	if (dvb_shutdown_timeout) {
 		if (dvb_powerdown_on_sleep)
-			if (fe->frontend->ops->set_voltage) fe->frontend->ops->set_voltage(fe->frontend, SEC_VOLTAGE_OFF);
-		if (fe->frontend->ops->sleep) fe->frontend->ops->sleep(fe->frontend);
+			if (fe->ops->set_voltage)
+				fe->ops->set_voltage(fe, SEC_VOLTAGE_OFF);
+		if (fe->ops->sleep)
+			fe->ops->sleep(fe);
 	}
 
 	fe->thread_pid = 0;
@@ -587,8 +483,7 @@
 	return 0;
 }
 
-
-static void dvb_frontend_stop (struct dvb_frontend_data *fe)
+static void dvb_frontend_stop(struct dvb_frontend *fe)
 {
 	unsigned long ret;
 
@@ -626,8 +521,7 @@
 				fe->thread_pid);
 }
 
-
-static int dvb_frontend_start (struct dvb_frontend_data *fe)
+static int dvb_frontend_start(struct dvb_frontend *fe)
 {
 	int ret;
 
@@ -666,7 +560,7 @@
 			unsigned int cmd, void *parg)
 {
 	struct dvb_device *dvbdev = file->private_data;
-	struct dvb_frontend_data *fe = dvbdev->priv;
+	struct dvb_frontend *fe = dvbdev->priv;
 	int err = -EOPNOTSUPP;
 
 	dprintk ("%s\n", __FUNCTION__);
@@ -685,7 +579,7 @@
 	switch (cmd) {
 	case FE_GET_INFO: {
 		struct dvb_frontend_info* info = (struct dvb_frontend_info*) parg;
-		memcpy(info, &fe->frontend->ops->info, sizeof(struct dvb_frontend_info));
+		memcpy(info, &fe->ops->info, sizeof(struct dvb_frontend_info));
 
 		/* Force the CAN_INVERSION_AUTO bit on. If the frontend doesn't
 		 * do it, it is done for it. */
@@ -695,87 +589,87 @@
 	}
 
 	case FE_READ_STATUS:
-		if (fe->frontend->ops->read_status)
-			err = fe->frontend->ops->read_status(fe->frontend, (fe_status_t*) parg);
+		if (fe->ops->read_status)
+			err = fe->ops->read_status(fe, (fe_status_t*) parg);
 		break;
 
 	case FE_READ_BER:
-		if (fe->frontend->ops->read_ber)
-			err = fe->frontend->ops->read_ber(fe->frontend, (__u32*) parg);
+		if (fe->ops->read_ber)
+			err = fe->ops->read_ber(fe, (__u32*) parg);
 		break;
 
 	case FE_READ_SIGNAL_STRENGTH:
-		if (fe->frontend->ops->read_signal_strength)
-			err = fe->frontend->ops->read_signal_strength(fe->frontend, (__u16*) parg);
+		if (fe->ops->read_signal_strength)
+			err = fe->ops->read_signal_strength(fe, (__u16*) parg);
 		break;
 
 	case FE_READ_SNR:
-		if (fe->frontend->ops->read_snr)
-			err = fe->frontend->ops->read_snr(fe->frontend, (__u16*) parg);
+		if (fe->ops->read_snr)
+			err = fe->ops->read_snr(fe, (__u16*) parg);
 		break;
 
 	case FE_READ_UNCORRECTED_BLOCKS:
-		if (fe->frontend->ops->read_ucblocks)
-			err = fe->frontend->ops->read_ucblocks(fe->frontend, (__u32*) parg);
+		if (fe->ops->read_ucblocks)
+			err = fe->ops->read_ucblocks(fe, (__u32*) parg);
 		break;
 
 
 	case FE_DISEQC_RESET_OVERLOAD:
-		if (fe->frontend->ops->diseqc_reset_overload) {
-			err = fe->frontend->ops->diseqc_reset_overload(fe->frontend);
+		if (fe->ops->diseqc_reset_overload) {
+			err = fe->ops->diseqc_reset_overload(fe);
 			fe->state = FESTATE_DISEQC;
 			fe->status = 0;
 		}
 		break;
 
 	case FE_DISEQC_SEND_MASTER_CMD:
-		if (fe->frontend->ops->diseqc_send_master_cmd) {
-			err = fe->frontend->ops->diseqc_send_master_cmd(fe->frontend, (struct dvb_diseqc_master_cmd*) parg);
+		if (fe->ops->diseqc_send_master_cmd) {
+			err = fe->ops->diseqc_send_master_cmd(fe, (struct dvb_diseqc_master_cmd*) parg);
 			fe->state = FESTATE_DISEQC;
 			fe->status = 0;
 		}
 		break;
 
 	case FE_DISEQC_SEND_BURST:
-		if (fe->frontend->ops->diseqc_send_burst) {
-			err = fe->frontend->ops->diseqc_send_burst(fe->frontend, (fe_sec_mini_cmd_t) parg);
+		if (fe->ops->diseqc_send_burst) {
+			err = fe->ops->diseqc_send_burst(fe, (fe_sec_mini_cmd_t) parg);
 			fe->state = FESTATE_DISEQC;
 			fe->status = 0;
 		}
 		break;
 
 	case FE_SET_TONE:
-		if (fe->frontend->ops->set_tone) {
-			err = fe->frontend->ops->set_tone(fe->frontend, (fe_sec_tone_mode_t) parg);
+		if (fe->ops->set_tone) {
+			err = fe->ops->set_tone(fe, (fe_sec_tone_mode_t) parg);
 			fe->state = FESTATE_DISEQC;
 			fe->status = 0;
 		}
 		break;
 
 	case FE_SET_VOLTAGE:
-		if (fe->frontend->ops->set_voltage) {
-			err = fe->frontend->ops->set_voltage(fe->frontend, (fe_sec_voltage_t) parg);
+		if (fe->ops->set_voltage) {
+			err = fe->ops->set_voltage(fe, (fe_sec_voltage_t) parg);
 		fe->state = FESTATE_DISEQC;
 			fe->status = 0;
 		}
 		break;
 
 	case FE_DISHNETWORK_SEND_LEGACY_CMD:
-		if (fe->frontend->ops->dishnetwork_send_legacy_command) {
-			err = fe->frontend->ops->dishnetwork_send_legacy_command(fe->frontend, (unsigned int) parg);
+		if (fe->ops->dishnetwork_send_legacy_command) {
+			err = fe->ops->dishnetwork_send_legacy_command(fe, (unsigned int) parg);
 			fe->state = FESTATE_DISEQC;
 			fe->status = 0;
 		}
 		break;
 
 	case FE_DISEQC_RECV_SLAVE_REPLY:
-		if (fe->frontend->ops->diseqc_recv_slave_reply)
-			err = fe->frontend->ops->diseqc_recv_slave_reply(fe->frontend, (struct dvb_diseqc_slave_reply*) parg);
+		if (fe->ops->diseqc_recv_slave_reply)
+			err = fe->ops->diseqc_recv_slave_reply(fe, (struct dvb_diseqc_slave_reply*) parg);
 		break;
 
 	case FE_ENABLE_HIGH_LNB_VOLTAGE:
-		if (fe->frontend->ops->enable_high_lnb_voltage);
-			err = fe->frontend->ops->enable_high_lnb_voltage(fe->frontend, (int) parg);
+		if (fe->ops->enable_high_lnb_voltage);
+			err = fe->ops->enable_high_lnb_voltage(fe, (int) parg);
 		break;
 
 	case FE_SET_FRONTEND: {
@@ -793,7 +687,7 @@
 			fe->parameters.inversion = INVERSION_AUTO;
 			fetunesettings.parameters.inversion = INVERSION_AUTO;
 		}
-		if (fe->frontend->ops->info.type == FE_OFDM) {
+		if (fe->ops->info.type == FE_OFDM) {
 			/* without hierachical coding code_rate_LP is irrelevant,
 			 * so we tolerate the otherwise invalid FEC_NONE setting */
 			if (fe->parameters.u.ofdm.hierarchy_information == HIERARCHY_NONE &&
@@ -802,13 +696,13 @@
 		}
 
 		/* get frontend-specific tuning settings */
-		if (fe->frontend->ops->get_tune_settings && (fe->frontend->ops->get_tune_settings(fe->frontend, &fetunesettings) == 0)) {
+		if (fe->ops->get_tune_settings && (fe->ops->get_tune_settings(fe, &fetunesettings) == 0)) {
 			fe->min_delay = (fetunesettings.min_delay_ms * HZ) / 1000;
 			fe->max_drift = fetunesettings.max_drift;
 			fe->step_size = fetunesettings.step_size;
 		} else {
 			/* default values */
-			switch(fe->frontend->ops->info.type) {
+			switch(fe->ops->info.type) {
 			case FE_QPSK:
 				fe->min_delay = HZ/20;
 				fe->step_size = fe->parameters.u.qpsk.symbol_rate / 16000;
@@ -823,17 +717,16 @@
 			    
 			case FE_OFDM:
 				fe->min_delay = HZ/20;
-				fe->step_size = fe->frontend->ops->info.frequency_stepsize * 2;
-				fe->max_drift = (fe->frontend->ops->info.frequency_stepsize * 2) + 1;
+				fe->step_size = fe->ops->info.frequency_stepsize * 2;
+				fe->max_drift = (fe->ops->info.frequency_stepsize * 2) + 1;
 				break;
 			case FE_ATSC:
 				printk("dvb-core: FE_ATSC not handled yet.\n");
 				break;
 			}
 		}
-		if (dvb_override_tune_delay > 0) {
+		if (dvb_override_tune_delay > 0)
 		       fe->min_delay = (dvb_override_tune_delay * HZ) / 1000;
-		}
 
 		fe->state = FESTATE_RETUNE;
 		dvb_frontend_wakeup(fe);
@@ -848,9 +741,9 @@
 		break;
 
 	case FE_GET_FRONTEND:
-		if (fe->frontend->ops->get_frontend) {
+		if (fe->ops->get_frontend) {
 			memcpy (parg, &fe->parameters, sizeof (struct dvb_frontend_parameters));
-			err = fe->frontend->ops->get_frontend(fe->frontend, (struct dvb_frontend_parameters*) parg);
+			err = fe->ops->get_frontend(fe, (struct dvb_frontend_parameters*) parg);
 		}
 		break;
 	};
@@ -863,7 +755,7 @@
 static unsigned int dvb_frontend_poll (struct file *file, struct poll_table_struct *wait)
 {
 	struct dvb_device *dvbdev = file->private_data;
-	struct dvb_frontend_data *fe = dvbdev->priv;
+	struct dvb_frontend *fe = dvbdev->priv;
 
 	dprintk ("%s\n", __FUNCTION__);
 
@@ -879,7 +770,7 @@
 static int dvb_frontend_open (struct inode *inode, struct file *file)
 {
 	struct dvb_device *dvbdev = file->private_data;
-	struct dvb_frontend_data *fe = dvbdev->priv;
+	struct dvb_frontend *fe = dvbdev->priv;
 	int ret;
 
 	dprintk ("%s\n", __FUNCTION__);
@@ -903,7 +793,7 @@
 static int dvb_frontend_release (struct inode *inode, struct file *file)
 {
 	struct dvb_device *dvbdev = file->private_data;
-	struct dvb_frontend_data *fe = dvbdev->priv;
+	struct dvb_frontend *fe = dvbdev->priv;
 
 	dprintk ("%s\n", __FUNCTION__);
 
@@ -922,11 +811,9 @@
 	.release	= dvb_frontend_release
 };
 
-
 int dvb_register_frontend(struct dvb_adapter* dvb,
-			  struct dvb_frontend* frontend)
+			  struct dvb_frontend* fe)
 {
-	struct dvb_frontend_data *fe;
 	static const struct dvb_device dvbdev_template = {
 		.users = ~0,
 		.writers = 1,
@@ -940,71 +827,39 @@
 	if (down_interruptible (&frontend_mutex))
 		return -ERESTARTSYS;
 
-	if (!(fe = kmalloc (sizeof (struct dvb_frontend_data), GFP_KERNEL))) {
-		up (&frontend_mutex);
-		return -ENOMEM;
-	}
-
-	memset (fe, 0, sizeof (struct dvb_frontend_data));
-
 	init_MUTEX (&fe->sem);
 	init_waitqueue_head (&fe->wait_queue);
 	init_waitqueue_head (&fe->events.wait_queue);
 	init_MUTEX (&fe->events.sem);
 	fe->events.eventw = fe->events.eventr = 0;
 	fe->events.overflow = 0;
-
-	fe->frontend = frontend;
-	fe->frontend->dvb = dvb;
-
+	fe->dvb = dvb;
 	fe->inversion = INVERSION_OFF;
 
-	list_add_tail (&fe->list_head, &frontend_list);
-
 	printk ("DVB: registering frontend %i (%s)...\n",
-		fe->frontend->dvb->num,
-		fe->frontend->ops->info.name);
+		fe->dvb->num,
+		fe->ops->info.name);
 
-	dvb_register_device (fe->frontend->dvb, &fe->dvbdev, &dvbdev_template,
+	dvb_register_device (fe->dvb, &fe->dvbdev, &dvbdev_template,
 			     fe, DVB_DEVICE_FRONTEND);
 
-	if ((fe->frontend->ops->info.caps & FE_NEEDS_BENDING) || (dvb_override_frequency_bending == 2))
-		do_frequency_bending = 1;
-    
 	up (&frontend_mutex);
 	return 0;
 }
 EXPORT_SYMBOL(dvb_register_frontend);
 
-int dvb_unregister_frontend (struct dvb_frontend* frontend)
+int dvb_unregister_frontend(struct dvb_frontend* fe)
 {
-        struct list_head *entry, *n;
-
 	dprintk ("%s\n", __FUNCTION__);
 
 	down (&frontend_mutex);
-
-	list_for_each_safe (entry, n, &frontend_list) {
-		struct dvb_frontend_data *fe;
-
-		fe = list_entry (entry, struct dvb_frontend_data, list_head);
-
-		if (fe->frontend == frontend) {
 			dvb_unregister_device (fe->dvbdev);
-			list_del (entry);
-			up (&frontend_mutex);
 			dvb_frontend_stop (fe);
-			if (fe->frontend->ops->release) {
-				fe->frontend->ops->release(fe->frontend);
-			} else {
-				printk("dvb_frontend: Demodulator (%s) does not have a release callback!\n", fe->frontend->ops->info.name);
-			}
-			kfree (fe);
-			return 0;
-		}
-	}
-
+	if (fe->ops->release)
+		fe->ops->release(fe);
+	else
+		printk("dvb_frontend: Demodulator (%s) does not have a release callback!\n", fe->ops->info.name);
 	up (&frontend_mutex);
-	return -EINVAL;
+	return 0;
 }
 EXPORT_SYMBOL(dvb_unregister_frontend);
diff -uraNwB linux-2.6.10-rc3-bk3/drivers/media/dvb/dvb-core/dvb_frontend.h linux-2.6.10-rc3-bk3-p/drivers/media/dvb/dvb-core/dvb_frontend.h
--- linux-2.6.10-rc3-bk3/drivers/media/dvb/dvb-core/dvb_frontend.h	2004-12-08 14:31:33.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/drivers/media/dvb/dvb-core/dvb_frontend.h	2004-11-30 15:50:43.000000000 +0100
@@ -100,11 +100,43 @@
 	int (*dishnetwork_send_legacy_command)(struct dvb_frontend* fe, unsigned int cmd);
 };
 
-struct dvb_frontend {
+#define MAX_EVENT 8
+
+struct dvb_fe_events {
+	struct dvb_frontend_event events[MAX_EVENT];
+	int			  eventw;
+	int			  eventr;
+	int			  overflow;
+	wait_queue_head_t	  wait_queue;
+	struct semaphore	  sem;
+};
 
+struct dvb_frontend {
 	struct dvb_frontend_ops* ops;
 	struct dvb_adapter *dvb;
 	void* demodulator_priv;
+
+	struct dvb_device *dvbdev;
+	struct dvb_frontend_parameters parameters;
+	struct dvb_fe_events events;
+	struct semaphore sem;
+	struct list_head list_head;
+	wait_queue_head_t wait_queue;
+	pid_t thread_pid;
+	unsigned long release_jiffies;
+	int state;
+	int bending;
+	int lnb_drift;
+	int inversion;
+	int auto_step;
+	int auto_sub_step;
+	int started_auto_step;
+	int min_delay;
+	int max_drift;
+	int step_size;
+	int exit;
+	int wakeup;
+	fe_status_t status;
 };
 
 extern int dvb_register_frontend(struct dvb_adapter* dvb,
diff -uraNwB linux-2.6.10-rc3-bk3/drivers/media/dvb/dvb-core/dvb_net.c linux-2.6.10-rc3-bk3-p/drivers/media/dvb/dvb-core/dvb_net.c
--- linux-2.6.10-rc3-bk3/drivers/media/dvb/dvb-core/dvb_net.c	2004-12-08 14:31:33.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/drivers/media/dvb/dvb-core/dvb_net.c	2004-12-08 14:45:05.000000000 +0100
@@ -6,13 +6,13 @@
  * Copyright (C) 2002 Ralph Metzler <rjkm@metzlerbros.de>
  *
  * ULE Decapsulation code:
- * Copyright (C) 2003 gcs - Global Communication & Services GmbH.
- *                and Institute for Computer Sciences
- *                    Salzburg University.
+ * Copyright (C) 2003, 2004 gcs - Global Communication & Services GmbH.
+ *                      and Department of Scientific Computing
+ *                          Paris Lodron University of Salzburg.
  *                    Hilmar Linder <hlinder@cosy.sbg.ac.at>
  *                and Wolfram Stering <wstering@cosy.sbg.ac.at>
  *
- * ULE Decaps according to draft-fair-ipdvb-ule-01.txt.
+ * ULE Decaps according to draft-ietf-ipdvb-ule-03.txt.
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -30,6 +30,30 @@
  * Or, point your browser to http://www.gnu.org/copyleft/gpl.html
  */
 
+/*
+ * ULE ChangeLog:
+ * Feb 2004: hl/ws v1: Implementing draft-fair-ipdvb-ule-01.txt
+ *
+ * Dec 2004: hl/ws v2: Implementing draft-ietf-ipdvb-ule-03.txt:
+ *                       ULE Extension header handling.
+ *                     Bugreports by Moritz Vieth and Hanno Tersteegen,
+ *                       Fraunhofer Institute for Open Communication Systems
+ *                       Competence Center for Advanced Satellite Communications.
+ *                     Bugfixes and robustness improvements.
+ *                     Filtering on dest MAC addresses, if present (D-Bit = 0)
+ *                     ULE_DEBUG compile-time option.
+ */
+
+/*
+ * FIXME / TODO (dvb_net.c):
+ *
+ * Unloading does not work for 2.6.9 kernels: a refcount doesn't go to zero.
+ *
+ * TS_FEED callback is called once for every single TS cell although it is
+ * registered (in dvb_net_feed_start()) for 100 TS cells (used for dvb_net_ule()).
+ *
+ */
+
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
@@ -61,6 +85,10 @@
 
 #define DVB_NET_MULTICAST_MAX 10
 
+#undef ULE_DEBUG
+
+#ifdef ULE_DEBUG
+
 #define isprint(c)	((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || (c >= '0' && c <= '9'))
 
 static void hexdump( const unsigned char *buf, unsigned short len )
@@ -90,6 +118,7 @@
 	}
 }
 
+#endif
 
 struct dvb_net_priv {
 	int in_use;
@@ -111,18 +140,19 @@
 #define RX_MODE_PROMISC 3
 	struct work_struct set_multicast_list_wq;
 	struct work_struct restart_net_feed_wq;
-	unsigned char feedtype;
-	int need_pusi;
-	unsigned char tscc;			/* TS continuity counter after sync. */
-	struct sk_buff *ule_skb;
-	unsigned short ule_sndu_len;
-	unsigned short ule_sndu_type;
-	unsigned char ule_sndu_type_1;
-	unsigned char ule_dbit;			/* whether the DestMAC address present
-						 * bit is set or not. */
-	unsigned char ule_ethhdr_complete;	/* whether we have completed the Ethernet
-						 * header for the current ULE SNDU. */
-	int ule_sndu_remain;
+	unsigned char feedtype;			/* Either FEED_TYPE_ or FEED_TYPE_ULE */
+	int need_pusi;				/* Set to 1, if synchronization on PUSI required. */
+	unsigned char tscc;			/* TS continuity counter after sync on PUSI. */
+	struct sk_buff *ule_skb;		/* ULE SNDU decodes into this buffer. */
+	unsigned char *ule_next_hdr;		/* Pointer into skb to next ULE extension header. */
+	unsigned short ule_sndu_len;		/* ULE SNDU length in bytes, w/o D-Bit. */
+	unsigned short ule_sndu_type;		/* ULE SNDU type field, complete. */
+	unsigned char ule_sndu_type_1;		/* ULE SNDU type field, if split across 2 TS cells. */
+	unsigned char ule_dbit;			/* Whether the DestMAC address present
+						 * or not (bit is set). */
+	unsigned char ule_bridged;		/* Whether the ULE_BRIDGED extension header was found. */
+	int ule_sndu_remain;			/* Nr. of bytes still required for current ULE SNDU. */
+	unsigned long ts_count;			/* Current ts cell counter. */
 };
 
 
@@ -178,58 +208,169 @@
 #define TS_SZ	188
 #define TS_SYNC	0x47
 #define TS_TEI	0x80
+#define TS_SC	0xC0
 #define TS_PUSI	0x40
 #define TS_AF_A	0x20
 #define TS_AF_D	0x10
 
+/* ULE Extension Header handlers. */
+
 #define ULE_TEST	0
 #define ULE_BRIDGED	1
-#define ULE_LLC		2
 
+int ule_test_sndu( struct dvb_net_priv *p )
+{
+	return -1;
+}
+
+int ule_bridged_sndu( struct dvb_net_priv *p )
+{
+	/* BRIDGE SNDU handling sucks in draft-ietf-ipdvb-ule-03.txt.
+	 * This has to be the last extension header, otherwise it won't work.
+	 * Blame the authors!
+	 */ 
+	p->ule_bridged = 1;
+	return 0;
+}
+
+
+/** Handle ULE extension headers.
+ *  Function is called after a successful CRC32 verification of an ULE SNDU to complete its decoding.
+ *  Returns: >= 0: nr. of bytes consumed by next extension header
+ *  	     -1:   Mandatory extension header that is not recognized or TEST SNDU; discard.
+ */
+static int handle_one_ule_extension( struct dvb_net_priv *p )
+{
+	/* Table of mandatory extension header handlers.  The header type is the index. */
+	static int (*ule_mandatory_ext_handlers[255])( struct dvb_net_priv *p ) =
+		{ [0] = ule_test_sndu, [1] = ule_bridged_sndu, [2] = NULL,  };
+
+	/* Table of optional extension header handlers.  The header type is the index. */
+	static int (*ule_optional_ext_handlers[255])( struct dvb_net_priv *p ) = { NULL, };
+
+	int ext_len = 0;
+	unsigned char hlen = (p->ule_sndu_type & 0x0700) >> 8;
+	unsigned char htype = p->ule_sndu_type & 0x00FF;
+
+	/* Discriminate mandatory and optional extension headers. */
+	if (hlen == 0) {
+		/* Mandatory extension header */
+		if (ule_mandatory_ext_handlers[htype]) {
+			ext_len = ule_mandatory_ext_handlers[htype]( p );
+			p->ule_next_hdr += ext_len;
+			if (! p->ule_bridged) {
+				p->ule_sndu_type = ntohs( *(unsigned short *)p->ule_next_hdr );
+				p->ule_next_hdr += 2;
+			} else {
+				p->ule_sndu_type = ntohs( *(unsigned short *)(p->ule_next_hdr + ((p->ule_dbit ? 2 : 3) * ETH_ALEN)) );
+				/* This assures the extension handling loop will terminate. */
+			}
+		} else
+			ext_len = -1;	/* SNDU has to be discarded. */
+	} else {
+		/* Optional extension header.  Calculate the length. */
+		ext_len = hlen << 2;
+		/* Process the optional extension header according to its type. */
+		if (ule_optional_ext_handlers[htype])
+			(void)ule_optional_ext_handlers[htype]( p );
+		p->ule_next_hdr += ext_len;
+		p->ule_sndu_type = ntohs( *(unsigned short *)p->ule_next_hdr );
+		p->ule_next_hdr += 2;
+	}
+
+	return ext_len;
+}
+
+static int handle_ule_extensions( struct dvb_net_priv *p )
+{
+	int total_ext_len = 0, l;
+
+	p->ule_next_hdr = p->ule_skb->data;
+	do {
+		l = handle_one_ule_extension( p );
+		if (l == -1) return -1;	/* Stop extension header processing and discard SNDU. */
+		total_ext_len += l;
+
+	} while (p->ule_sndu_type < 1536);
+
+	return total_ext_len;
+}
+
+
+/** Prepare for a new ULE SNDU: reset the decoder state. */
 static inline void reset_ule( struct dvb_net_priv *p )
 {
 	p->ule_skb = NULL;
+	p->ule_next_hdr = NULL;
 	p->ule_sndu_len = 0;
 	p->ule_sndu_type = 0;
 	p->ule_sndu_type_1 = 0;
 	p->ule_sndu_remain = 0;
 	p->ule_dbit = 0xFF;
-	p->ule_ethhdr_complete = 0;
+	p->ule_bridged = 0;
 }
 
-static const char eth_dest_addr[] = { 0x0b, 0x0a, 0x09, 0x08, 0x04, 0x03 };
-
+/**
+ * Decode ULE SNDUs according to draft-ietf-ipdvb-ule-03.txt from a sequence of
+ * TS cells of a single PID.
+ */
 static void dvb_net_ule( struct net_device *dev, const u8 *buf, size_t buf_len )
 {
 	struct dvb_net_priv *priv = (struct dvb_net_priv *)dev->priv;
-	unsigned long skipped = 0L, skblen = 0L;
+	unsigned long skipped = 0L;
 	u8 *ts, *ts_end, *from_where = NULL, ts_remain = 0, how_much = 0, new_ts = 1;
 	struct ethhdr *ethh = NULL;
-	unsigned int emergency_count = 0;
+
+#ifdef ULE_DEBUG
+	/* The code inside ULE_DEBUG keeps a history of the last 100 TS cells processed. */
+	static unsigned char ule_hist[100*TS_SZ];
+	static unsigned char *ule_where = ule_hist, ule_dump = 0;
+#endif
 
 	if (dev == NULL) {
 		printk( KERN_ERR "NO netdev struct!\n" );
 		return;
 	}
 
-	for (ts = (char *)buf, ts_end = (char *)buf + buf_len; ts < ts_end; ) {
+	/* For all TS cells in current buffer.
+	 * Appearently, we are called for every single TS cell.
+	 */
+	for (ts = (char *)buf, ts_end = (char *)buf + buf_len; ts < ts_end; /* no default incr. */ ) {
 
-		if (emergency_count++ > 200) {
-			/* Huh?? */
-			hexdump(ts, TS_SZ);
-			printk(KERN_WARNING "*** LOOP ALERT! ts %p ts_remain %u "
-				"how_much %u, ule_skb %p, ule_len %u, ule_remain %u\n",
-				ts, ts_remain, how_much, priv->ule_skb,
-				priv->ule_sndu_len, priv->ule_sndu_remain);
-			break;
+		if (new_ts) {
+			/* We are about to process a new TS cell. */
+
+#ifdef ULE_DEBUG
+			if (ule_where >= &ule_hist[100*TS_SZ]) ule_where = ule_hist;
+			memcpy( ule_where, ts, TS_SZ );
+			if (ule_dump) {
+				hexdump( ule_where, TS_SZ );
+				ule_dump = 0;
 		}
+			ule_where += TS_SZ;
+#endif
 
-		if (new_ts) {
-			if ((ts[0] != TS_SYNC) || (ts[1] & TS_TEI)) {
-				printk(KERN_WARNING "Invalid TS cell: SYNC %#x, TEI %u.\n",
-				       ts[0], ts[1] & TS_TEI >> 7);
+			/* Check TS error conditions: sync_byte, transport_error_indicator, scrambling_control . */
+			if ((ts[0] != TS_SYNC) || (ts[1] & TS_TEI) || ((ts[3] & TS_SC) != 0)) {
+				printk(KERN_WARNING "%lu: Invalid TS cell: SYNC %#x, TEI %u, SC %#x.\n",
+				       priv->ts_count, ts[0], ts[1] & TS_TEI >> 7, ts[3] & 0xC0 >> 6);
+
+				/* Drop partly decoded SNDU, reset state, resync on PUSI. */
+				if (priv->ule_skb) {
+					dev_kfree_skb( priv->ule_skb );
+					/* Prepare for next SNDU. */
+					((struct dvb_net_priv *) dev->priv)->stats.rx_errors++;
+					((struct dvb_net_priv *) dev->priv)->stats.rx_frame_errors++;
+				}
+				reset_ule(priv);
+				priv->need_pusi = 1;
+
+				/* Continue with next TS cell. */
+				ts += TS_SZ;
+				priv->ts_count++;
 				continue;
 			}
+
 			ts_remain = 184;
 			from_where = ts + 4;
 		}
@@ -236,20 +377,25 @@
 		/* Synchronize on PUSI, if required. */
 		if (priv->need_pusi) {
 			if (ts[1] & TS_PUSI) {
-				/* Find beginning of first ULE SNDU in current TS cell.
-				 * priv->need_pusi = 0; */
+				/* Find beginning of first ULE SNDU in current TS cell. */
+				/* Synchronize continuity counter. */
 				priv->tscc = ts[3] & 0x0F;
 				/* There is a pointer field here. */
 				if (ts[4] > ts_remain) {
-					printk(KERN_ERR "Invalid ULE packet "
-					       "(pointer field %d)\n", ts[4]);
+					printk(KERN_ERR "%lu: Invalid ULE packet "
+					       "(pointer field %d)\n", priv->ts_count, ts[4]);
+					ts += TS_SZ;
+					priv->ts_count++;
 					continue;
 				}
+				/* Skip to destination of pointer field. */
 				from_where = &ts[5] + ts[4];
 				ts_remain -= 1 + ts[4];
 				skipped = 0;
 			} else {
 				skipped++;
+				ts += TS_SZ;
+				priv->ts_count++;
 				continue;
 			}
 		}
@@ -260,32 +406,45 @@
 				priv->tscc = (priv->tscc + 1) & 0x0F;
 			else {
 				/* TS discontinuity handling: */
+				printk(KERN_WARNING "%lu: TS discontinuity: got %#x, "
+				       "exptected %#x.\n", priv->ts_count, ts[3] & 0x0F, priv->tscc);
+				/* Drop partly decoded SNDU, reset state, resync on PUSI. */
 				if (priv->ule_skb) {
 					dev_kfree_skb( priv->ule_skb );
 					/* Prepare for next SNDU. */
-					reset_ule(priv);
+					// reset_ule(priv);  moved to below.
 					((struct dvb_net_priv *) dev->priv)->stats.rx_errors++;
 					((struct dvb_net_priv *) dev->priv)->stats.rx_frame_errors++;
 				}
+				reset_ule(priv);
 				/* skip to next PUSI. */
-				printk(KERN_WARNING "TS discontinuity: got %#x, "
-				       "exptected %#x.\n", ts[3] & 0x0F, priv->tscc);
 				priv->need_pusi = 1;
+				ts += TS_SZ;
+				priv->ts_count++;
 				continue;
 			}
 			/* If we still have an incomplete payload, but PUSI is
-			 * set, some TS cells are missing.
+			 * set; some TS cells are missing.
 			 * This is only possible here, if we missed exactly 16 TS
-			 * cells (continuity counter). */
+			 * cells (continuity counter wrap). */
 			if (ts[1] & TS_PUSI) {
 				if (! priv->need_pusi) {
-					/* printk(KERN_WARNING "Skipping pointer field %u.\n", *from_where); */
 					if (*from_where > 181) {
-						printk(KERN_WARNING "*** Invalid pointer "
-						       "field: %u.  Current TS cell "
-						       "follows:\n", *from_where);
-						hexdump( ts, TS_SZ );
-						printk(KERN_WARNING "-------------------\n");
+						/* Pointer field is invalid.  Drop this TS cell and any started ULE SNDU. */
+						printk(KERN_WARNING "%lu: Invalid pointer "
+						       "field: %u.\n", priv->ts_count, *from_where);
+
+						/* Drop partly decoded SNDU, reset state, resync on PUSI. */
+						if (priv->ule_skb) {
+							dev_kfree_skb( priv->ule_skb );
+							((struct dvb_net_priv *) dev->priv)->stats.rx_errors++;
+							((struct dvb_net_priv *) dev->priv)->stats.rx_frame_errors++;
+						}
+						reset_ule(priv);
+						priv->need_pusi = 1;
+						ts += TS_SZ;
+						priv->ts_count++;
+						continue;
 					}
 					/* Skip pointer field (we're processing a
 					 * packed payload). */
@@ -295,21 +454,26 @@
 					priv->need_pusi = 0;
 
 				if (priv->ule_sndu_remain > 183) {
+					/* Current SNDU lacks more data than there could be available in the
+					 * current TS cell. */
 					((struct dvb_net_priv *) dev->priv)->stats.rx_errors++;
 					((struct dvb_net_priv *) dev->priv)->stats.rx_length_errors++;
-					printk(KERN_WARNING "Expected %d more SNDU bytes, but "
-					       "got PUSI.  Flushing incomplete payload.\n",
-					       priv->ule_sndu_remain);
+					printk(KERN_WARNING "%lu: Expected %d more SNDU bytes, but "
+					       "got PUSI (pf %d, ts_remain %d).  Flushing incomplete payload.\n",
+					       priv->ts_count, priv->ule_sndu_remain, ts[4], ts_remain);
 					dev_kfree_skb(priv->ule_skb);
 					/* Prepare for next SNDU. */
 					reset_ule(priv);
+					/* Resync: go to where pointer field points to: start of next ULE SNDU. */
+					from_where += ts[4];
+					ts_remain -= ts[4];
 				}
 			}
 		}
 
 		/* Check if new payload needs to be started. */
 		if (priv->ule_skb == NULL) {
-			/* Start a new payload w/ skb.
+			/* Start a new payload with skb.
 			 * Find ULE header.  It is only guaranteed that the
 			 * length field (2 bytes) is contained in the current
 			 * TS.
@@ -323,6 +487,7 @@
 			}
 
 			if (! priv->ule_sndu_len) {
+				/* Got at least two bytes, thus extrace the SNDU length. */
 				priv->ule_sndu_len = from_where[0] << 8 | from_where[1];
 				if (priv->ule_sndu_len & 0x8000) {
 					/* D-Bit is set: no dest mac present. */
@@ -331,17 +496,14 @@
 				} else
 					priv->ule_dbit = 0;
 
-				/* printk(KERN_WARNING "ULE D-Bit: %d, SNDU len %u.\n",
-				          priv->ule_dbit, priv->ule_sndu_len); */
-
 				if (priv->ule_sndu_len > 32763) {
-					printk(KERN_WARNING "Invalid ULE SNDU length %u. "
-					       "Resyncing.\n", priv->ule_sndu_len);
-					hexdump(ts, TS_SZ);
+					printk(KERN_WARNING "%lu: Invalid ULE SNDU length %u. "
+					       "Resyncing.\n", priv->ts_count, priv->ule_sndu_len);
 					priv->ule_sndu_len = 0;
 					priv->need_pusi = 1;
 					new_ts = 1;
 					ts += TS_SZ;
+					priv->ts_count++;
 					continue;
 				}
 				ts_remain -= 2;	/* consume the 2 bytes SNDU length. */
@@ -359,11 +521,12 @@
 				case 1:
 					priv->ule_sndu_type = from_where[0] << 8;
 					priv->ule_sndu_type_1 = 1; /* first byte of ule_type is set. */
-					/* ts_remain -= 1; from_where += 1;
-					 *   here not necessary, because we continue. */
+					ts_remain -= 1; from_where += 1;
+					/* Continue w/ next TS. */
 				case 0:
 					new_ts = 1;
 					ts += TS_SZ;
+					priv->ts_count++;
 					continue;
 
 				default: /* complete ULE header is present in current TS. */
@@ -381,24 +544,9 @@
 					break;
 			}
 
-			if (priv->ule_sndu_type == ULE_TEST) {
-				/* Test SNDU, discarded by the receiver. */
-				printk(KERN_WARNING "Discarding ULE Test SNDU (%d bytes). "
-				       "Resyncing.\n", priv->ule_sndu_len);
-				priv->ule_sndu_len = 0;
-				priv->need_pusi = 1;
-				continue;
-			}
-
-			skblen = priv->ule_sndu_len;	/* Including CRC32 */
-			if (priv->ule_sndu_type != ULE_BRIDGED) {
-				skblen += ETH_HLEN;
-#if 1
-				if (! priv->ule_dbit)
-					skblen -= ETH_ALEN;
-#endif
-			}
-			priv->ule_skb = dev_alloc_skb(skblen);
+			/* Allocate the skb (decoder target buffer) with the correct size, as follows:
+			 * prepare for the largest case: bridged SNDU with MAC address (dbit = 0). */
+			priv->ule_skb = dev_alloc_skb( priv->ule_sndu_len + ETH_HLEN + ETH_ALEN );
 			if (priv->ule_skb == NULL) {
 				printk(KERN_NOTICE "%s: Memory squeeze, dropping packet.\n",
 				       dev->name);
@@ -406,130 +554,129 @@
 				return;
 			}
 
-#if 0
-			if (priv->ule_sndu_type != ULE_BRIDGED) {
-				// skb_reserve(priv->ule_skb, 2);    /* longword align L3 header */
-				// Create Ethernet header.
-				ethh = (struct ethhdr *)skb_put( priv->ule_skb, ETH_HLEN );
-				memset( ethh->h_source, 0x00, ETH_ALEN );
-				if (priv->ule_dbit) {
-					// Dest MAC address not present --> generate our own.
-					memcpy( ethh->h_dest, eth_dest_addr, ETH_ALEN );
-				} else {
-					// Dest MAC address could be split across two TS cells.
-					// FIXME: implement.
-
-					printk( KERN_WARNING "%s: got destination MAC "
-						"address.\n", dev->name );
-					memcpy( ethh->h_dest, eth_dest_addr, ETH_ALEN );
-				}
-				ethh->h_proto = htons(priv->ule_sndu_type == ULE_LLC ?
-						      priv->ule_sndu_len : priv->ule_sndu_type);
-			}
-#endif
-			/* this includes the CRC32 _and_ dest mac, if !dbit! */
+			/* This includes the CRC32 _and_ dest mac, if !dbit. */
 			priv->ule_sndu_remain = priv->ule_sndu_len;
 			priv->ule_skb->dev = dev;
+			/* Leave space for Ethernet or bridged SNDU header (eth hdr plus one MAC addr). */
+			skb_reserve( priv->ule_skb, ETH_HLEN + ETH_ALEN );
 		}
 
 		/* Copy data into our current skb. */
 		how_much = min(priv->ule_sndu_remain, (int)ts_remain);
-		if ((priv->ule_ethhdr_complete < ETH_ALEN) &&
-		    (priv->ule_sndu_type != ULE_BRIDGED)) {
-			ethh = (struct ethhdr *)priv->ule_skb->data;
-			if (! priv->ule_dbit) {
-				if (how_much >= (ETH_ALEN - priv->ule_ethhdr_complete)) {
-					/* copy dest mac address. */
-					memcpy(skb_put(priv->ule_skb,
-						       (ETH_ALEN - priv->ule_ethhdr_complete)),
-					       from_where,
-					       (ETH_ALEN - priv->ule_ethhdr_complete));
-					memset(ethh->h_source, 0x00, ETH_ALEN);
-					ethh->h_proto = htons(priv->ule_sndu_type == ULE_LLC ?
-							      priv->ule_sndu_len :
-							      priv->ule_sndu_type);
-					skb_put(priv->ule_skb, ETH_ALEN + 2);
-
-					how_much -= (ETH_ALEN - priv->ule_ethhdr_complete);
-					priv->ule_sndu_remain -= (ETH_ALEN -
-								  priv->ule_ethhdr_complete);
-					ts_remain -= (ETH_ALEN - priv->ule_ethhdr_complete);
-					from_where += (ETH_ALEN - priv->ule_ethhdr_complete);
-					priv->ule_ethhdr_complete = ETH_ALEN;
-				}
-			} else {
-				/* Generate whole Ethernet header. */
-				memcpy(ethh->h_dest, eth_dest_addr, ETH_ALEN);
-				memset(ethh->h_source, 0x00, ETH_ALEN);
-				ethh->h_proto = htons(priv->ule_sndu_type == ULE_LLC ?
-						      priv->ule_sndu_len : priv->ule_sndu_type);
-				skb_put(priv->ule_skb, ETH_HLEN);
-				priv->ule_ethhdr_complete = ETH_ALEN;
-			}
-		}
-		/* printk(KERN_WARNING "Copying %u bytes, ule_sndu_remain = %u, "
-		          "ule_sndu_len = %u.\n", how_much, priv->ule_sndu_remain,
-			  priv->ule_sndu_len); */
 		memcpy(skb_put(priv->ule_skb, how_much), from_where, how_much);
 		priv->ule_sndu_remain -= how_much;
 		ts_remain -= how_much;
 		from_where += how_much;
 
-		if ((priv->ule_ethhdr_complete < ETH_ALEN) &&
-		    (priv->ule_sndu_type != ULE_BRIDGED)) {
-			priv->ule_ethhdr_complete += how_much;
-		}
-
 		/* Check for complete payload. */
 		if (priv->ule_sndu_remain <= 0) {
 			/* Check CRC32, we've got it in our skb already. */
 			unsigned short ulen = htons(priv->ule_sndu_len);
 			unsigned short utype = htons(priv->ule_sndu_type);
-			struct kvec iov[4] = {
+			struct kvec iov[3] = {
 				{ &ulen, sizeof ulen },
 				{ &utype, sizeof utype },
-				{ NULL, 0 },
-				{ priv->ule_skb->data + ETH_HLEN,
-					priv->ule_skb->len - ETH_HLEN - 4 }
+				{ priv->ule_skb->data, priv->ule_skb->len - 4 }
 			};
 			unsigned long ule_crc = ~0L, expected_crc;
 			if (priv->ule_dbit) {
 				/* Set D-bit for CRC32 verification,
 				 * if it was set originally. */
 				ulen |= 0x0080;
-			} else {
-				iov[2].iov_base = priv->ule_skb->data;
-				iov[2].iov_len = ETH_ALEN;
 			}
-			ule_crc = iov_crc32(ule_crc, iov, 4);
+
+			ule_crc = iov_crc32(ule_crc, iov, 3);
 			expected_crc = *((u8 *)priv->ule_skb->tail - 4) << 24 |
 				*((u8 *)priv->ule_skb->tail - 3) << 16 |
 				*((u8 *)priv->ule_skb->tail - 2) << 8 |
 				*((u8 *)priv->ule_skb->tail - 1);
 			if (ule_crc != expected_crc) {
-				printk(KERN_WARNING "CRC32 check %s: %#lx / %#lx.\n",
-				       ule_crc != expected_crc ? "FAILED" : "OK",
-				       ule_crc, expected_crc);
-				hexdump(priv->ule_skb->data + ETH_HLEN,
-					priv->ule_skb->len - ETH_HLEN);
+				printk(KERN_WARNING "%lu: CRC32 check FAILED: %#lx / %#lx, SNDU len %d type %#x, ts_remain %d, next 2: %x.\n",
+				       priv->ts_count, ule_crc, expected_crc, priv->ule_sndu_len, priv->ule_sndu_type, ts_remain, ts_remain > 2 ? *(unsigned short *)from_where : 0);
+
+#ifdef ULE_DEBUG
+				hexdump( iov[0].iov_base, iov[0].iov_len );
+				hexdump( iov[1].iov_base, iov[1].iov_len );
+				hexdump( iov[2].iov_base, iov[2].iov_len );
+
+				if (ule_where == ule_hist) {
+					hexdump( &ule_hist[98*TS_SZ], TS_SZ );
+					hexdump( &ule_hist[99*TS_SZ], TS_SZ );
+				} else if (ule_where == &ule_hist[TS_SZ]) {
+					hexdump( &ule_hist[99*TS_SZ], TS_SZ );
+					hexdump( ule_hist, TS_SZ );
+				} else {
+					hexdump( ule_where - TS_SZ - TS_SZ, TS_SZ );
+					hexdump( ule_where - TS_SZ, TS_SZ );
+				}
+				ule_dump = 1;
+#endif
 
 				((struct dvb_net_priv *) dev->priv)->stats.rx_errors++;
 				((struct dvb_net_priv *) dev->priv)->stats.rx_crc_errors++;
 				dev_kfree_skb(priv->ule_skb);
 			} else {
+				/* CRC32 verified OK. */
+				/* Handle ULE Extension Headers. */
+				if (priv->ule_sndu_type < 1536) {
+					/* There is an extension header.  Handle it accordingly. */
+					int l = handle_ule_extensions( priv );
+					if (l < 0) {
+						/* Mandatory extension header unknown or TEST SNDU.  Drop it. */
+						// printk( KERN_WARNING "Dropping SNDU, extension headers.\n" );
+						dev_kfree_skb( priv->ule_skb );
+						goto sndu_done;
+					}
+					skb_pull( priv->ule_skb, l );
+				}
+
 				/* CRC32 was OK. Remove it from skb. */
 				priv->ule_skb->tail -= 4;
 				priv->ule_skb->len -= 4;
+
+				/* Filter on receiver's destination MAC address, if present. */
+				if (!priv->ule_dbit) {
+					/* The destination MAC address is the next data in the skb. */
+					if (memcmp( priv->ule_skb->data, dev->dev_addr, ETH_ALEN )) {
+						/* MAC addresses don't match.  Drop SNDU. */
+						// printk( KERN_WARNING "Dropping SNDU, MAC address.\n" );
+						dev_kfree_skb( priv->ule_skb );
+						goto sndu_done;
+					}
+					if (! priv->ule_bridged) {
+						skb_push( priv->ule_skb, ETH_ALEN + 2 );
+						ethh = (struct ethhdr *)priv->ule_skb->data;
+						memcpy( ethh->h_dest, ethh->h_source, ETH_ALEN );
+						memset( ethh->h_source, 0, ETH_ALEN );
+						ethh->h_proto = htons( priv->ule_sndu_type );
+					} else {
+						/* Skip the Receiver destination MAC address. */
+						skb_pull( priv->ule_skb, ETH_ALEN );
+					}
+				} else {
+					if (! priv->ule_bridged) {
+						skb_push( priv->ule_skb, ETH_HLEN );
+						ethh = (struct ethhdr *)priv->ule_skb->data;
+						memcpy( ethh->h_dest, dev->dev_addr, ETH_ALEN );
+						memset( ethh->h_source, 0, ETH_ALEN );
+						ethh->h_proto = htons( priv->ule_sndu_type );
+					} else {
+						/* skb is in correct state; nothing to do. */
+					}
+				}
+				priv->ule_bridged = 0;
+
 				/* Stuff into kernel's protocol stack. */
 				priv->ule_skb->protocol = dvb_net_eth_type_trans(priv->ule_skb, dev);
 				/* If D-bit is set (i.e. destination MAC address not present),
-				 * receive the packet anyhw. */
-				/* if (priv->ule_dbit && skb->pkt_type == PACKET_OTHERHOST) */
-					priv->ule_skb->pkt_type = PACKET_HOST;
+				 * receive the packet anyhow. */
+				/* if (priv->ule_dbit && skb->pkt_type == PACKET_OTHERHOST)
+					priv->ule_skb->pkt_type = PACKET_HOST; */
 				((struct dvb_net_priv *) dev->priv)->stats.rx_packets++;
 				((struct dvb_net_priv *) dev->priv)->stats.rx_bytes += priv->ule_skb->len;
 				netif_rx(priv->ule_skb);
 			}
+			sndu_done:
 			/* Prepare for next SNDU. */
 			reset_ule(priv);
 		}
@@ -549,6 +696,7 @@
 		} else {
 			new_ts = 1;
 			ts += TS_SZ;
+			priv->ts_count++;
 			if (priv->ule_skb == NULL) {
 				priv->need_pusi = 1;
 				priv->ule_sndu_type_1 = 0;
@@ -666,6 +814,7 @@
 
 static int dvb_net_tx(struct sk_buff *skb, struct net_device *dev)
 {
+	dev_kfree_skb(skb);
 	return 0;
 }
 
@@ -727,7 +876,7 @@
         unsigned char *mac = (unsigned char *) dev->dev_addr;
 		
 	dprintk("%s: rx_mode %i\n", __FUNCTION__, priv->rx_mode);
-	if (priv->secfeed || priv->secfilter || priv->multi_secfilter[0])
+	if (priv->tsfeed || priv->secfeed || priv->secfilter || priv->multi_secfilter[0])
 		printk("%s: BUG %d\n", __FUNCTION__, __LINE__);
 
 	priv->secfeed=NULL;

--------------060702060506070703060904--
