Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262731AbVAVRrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbVAVRrA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 12:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbVAVRqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 12:46:15 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:17618 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262611AbVAVRdP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 12:33:15 -0500
Cc: linux-kernel@vger.kernel.org, js@linuxtv.org
In-Reply-To: <1106415266247@linuxtv.org>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sat, 22 Jan 2005 18:34:30 +0100
Message-Id: <1106415270932@linuxtv.org>
Mime-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
From: Johannes Stezenbach <js@linuxtv.org>
X-SA-Exim-Connect-IP: 217.231.47.99
Subject: [PATCH 5/9] add ATSC support, misc fixes
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] dvb-core: vfree() checking cleanups, patch by Domen Puncer
- [DVB] dvb-core: fix handling of discontinuity indicator in section filter,
        bug reported by Frank Rosengart
- [DVB] dvb-core: handle PUSI in section filter correctly, patch by Emard,
        bug reported by Patrick Valsecchi
- [DVB] dvb-core: add support for ATSC/VSB frontends, patch by Taylor Jacob
- [DVB] dvb-core: removed semi-colon from a very wrong place; FE_ENABLE_HIGH_LNB_VOLTAGE
        kernel oops; thanks to Christophe Massiot
- [DVB] dvb-core: Fixed slow tuning problems, remove frequeny bending support from
        frontend code, code simplification

Signed-off-by: Michael Hunold <hunold@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

diff -uraNwB linux-2.6.11-rc2/drivers/media/dvb/dvb-core/dvb_demux.c linux-2.6.11-rc2-dvb/drivers/media/dvb/dvb-core/dvb_demux.c
--- linux-2.6.11-rc2/drivers/media/dvb/dvb-core/dvb_demux.c	2005-01-20 19:54:05.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/dvb/dvb-core/dvb_demux.c	2005-01-20 19:56:37.000000000 +0100
@@ -247,7 +249,22 @@
 		}
 
 /* 
-** Losless Section Demux 1.4 by Emard
+** Losless Section Demux 1.4.1 by Emard
+** Valsecchi Patrick:
+**  - middle of section A  (no PUSI)
+**  - end of section A and start of section B 
+**    (with PUSI pointing to the start of the second section)
+**  
+**  In this case, without feed->pusi_seen you'll receive a garbage section
+**  consisting of the end of section A. Basically because tsfeedp
+**  is incemented and the use=0 condition is not raised
+**  when the second packet arrives.
+**
+** Fix:
+** when demux is started, let feed->pusi_seen = 0 to
+** prevent initial feeding of garbage from the end of
+** previous section. When you for the first time see PUSI=1
+** then set feed->pusi_seen = 1
 */
 static int dvb_dmx_swfilter_section_copy_dump(struct dvb_demux_feed *feed, const u8 *buf, u8 len)
 {
@@ -293,7 +310,12 @@
 		sec->seclen = seclen;
 		sec->crc_val = ~0;
 		/* dump [secbuf .. secbuf+seclen) */
+		if(feed->pusi_seen)
 		dvb_dmx_swfilter_section_feed(feed);
+#ifdef DVB_DEMUX_SECTION_LOSS_LOG
+		else
+			printk("dvb_demux.c pusi not seen, discarding section data\n");
+#endif
 		sec->secbufp += seclen; /* secbufp and secbuf moving together is */
 		sec->secbuf += seclen; /* redundand but saves pointer arithmetic */
 		}
@@ -305,7 +327,7 @@
 static int dvb_dmx_swfilter_section_packet(struct dvb_demux_feed *feed, const u8 *buf) 
 {
 	u8 p, count;
-	int ccok;
+	int ccok, dc_i = 0;
 	u8 cc;
 
 	count = payload(buf);
@@ -316,31 +338,41 @@
 	p = 188-count; /* payload start */
 
 	cc = buf[3] & 0x0f;
-	ccok = ((feed->cc+1) & 0x0f) == cc ? 1 : 0;
+	ccok = ((feed->cc + 1) & 0x0f) == cc;
 	feed->cc = cc;
-	if(ccok == 0)
-	{
+
+	if (buf[3] & 0x20) {
+		/* adaption field present, check for discontinuity_indicator */
+		if ((buf[4] > 0) && (buf[5] & 0x80))
+			dc_i = 1;
+	}
+
+	if (!ccok || dc_i) {
 #ifdef DVB_DEMUX_SECTION_LOSS_LOG
 		printk("dvb_demux.c discontinuity detected %d bytes lost\n", count);
 		/* those bytes under sume circumstances will again be reported
 		** in the following dvb_dmx_swfilter_section_new
 		*/
 #endif
+		/* Discontinuity detected. Reset pusi_seen = 0 to
+		** stop feeding of suspicious data until next PUSI=1 arrives
+		*/
+		feed->pusi_seen = 0;
 		dvb_dmx_swfilter_section_new(feed);
 		return 0;
 	}
 
-	if(buf[1] & 0x40)
-	{
+	if (buf[1] & 0x40) {
 		// PUSI=1 (is set), section boundary is here
-		if(count > 1 && buf[p] < count)
-		{
+		if (count > 1 && buf[p] < count) {
 			const u8 *before = buf+p+1;
 			u8 before_len = buf[p];
 			const u8 *after = before+before_len;
 			u8 after_len = count-1-before_len;
 
 			dvb_dmx_swfilter_section_copy_dump(feed, before, before_len);
+			/* before start of new section, set pusi_seen = 1 */
+			feed->pusi_seen = 1;
 			dvb_dmx_swfilter_section_new(feed);
 			dvb_dmx_swfilter_section_copy_dump(feed, after, after_len);
 		}
@@ -349,9 +381,7 @@
 			if(count > 0)
 				printk("dvb_demux.c PUSI=1 but %d bytes lost\n", count);
 #endif
-	}
-	else
-	{
+	} else {
 		// PUSI=0 (is not set), no section boundary
 		const u8 *entire = buf+p;
 		u8 entire_len = count;
@@ -784,10 +814,8 @@
 	}
 
 #ifndef NOBUFS
-	if (feed->buffer) { 
 		vfree(feed->buffer);
 		feed->buffer=0;
-	}
 #endif
 
 	feed->state = DMX_STATE_FREE;
@@ -1055,10 +1094,8 @@
 		return -EINVAL;
 	}
 #ifndef NOBUFS
-	if (dvbdmxfeed->buffer) {
 		vfree(dvbdmxfeed->buffer);
 		dvbdmxfeed->buffer=0;
-	}
 #endif
 	dvbdmxfeed->state=DMX_STATE_FREE;
 
@@ -1269,9 +1317,7 @@
 	struct dmx_demux *dmx = &dvbdemux->dmx;
 
 	dmx_unregister_demux(dmx);
-	if (dvbdemux->filter)
 		vfree(dvbdemux->filter);
-	if (dvbdemux->feed)
 		vfree(dvbdemux->feed);
 	return 0;
 }
diff -uraNwB linux-2.6.11-rc2/drivers/media/dvb/dvb-core/dvb_demux.h linux-2.6.11-rc2-dvb/drivers/media/dvb/dvb-core/dvb_demux.h
--- linux-2.6.11-rc2/drivers/media/dvb/dvb-core/dvb_demux.h	2005-01-20 19:54:05.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/dvb/dvb-core/dvb_demux.h	2005-01-20 19:56:37.000000000 +0100
@@ -93,6 +93,7 @@
         enum dmx_ts_pes pes_type;
 
         int cc;
+        int pusi_seen; /* prevents feeding of garbage from previous section */
 
         u16 peslen;
 
diff -uraNwB linux-2.6.11-rc2/drivers/media/dvb/dvb-core/dvb_frontend.c linux-2.6.11-rc2-dvb/drivers/media/dvb/dvb-core/dvb_frontend.c
--- linux-2.6.11-rc2/drivers/media/dvb/dvb-core/dvb_frontend.c	2005-01-20 19:54:05.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/dvb/dvb-core/dvb_frontend.c	2005-01-20 19:56:37.000000000 +0100
@@ -89,9 +89,36 @@
 
 static DECLARE_MUTEX(frontend_mutex);
 
+struct dvb_frontend_private {
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
+};
+
+
 static void dvb_frontend_add_event(struct dvb_frontend *fe, fe_status_t status)
 {
-	struct dvb_fe_events *events = &fe->events;
+	struct dvb_frontend_private *fepriv = (struct dvb_frontend_private*) fe->frontend_priv;
+	struct dvb_fe_events *events = &fepriv->events;
 	struct dvb_frontend_event *e;
 	int wp;
 
@@ -109,7 +136,7 @@
 
 	e = &events->events[events->eventw];
 
-	memcpy (&e->parameters, &fe->parameters, 
+	memcpy (&e->parameters, &fepriv->parameters,
 		sizeof (struct dvb_frontend_parameters));
 
 	if (status & FE_HAS_LOCK)
@@ -128,7 +155,8 @@
 static int dvb_frontend_get_event(struct dvb_frontend *fe,
 			    struct dvb_frontend_event *event, int flags)
 {
-        struct dvb_fe_events *events = &fe->events;
+	struct dvb_frontend_private *fepriv = (struct dvb_frontend_private*) fe->frontend_priv;
+	struct dvb_fe_events *events = &fepriv->events;
 
 	dprintk ("%s\n", __FUNCTION__);
 
@@ -143,12 +171,12 @@
                 if (flags & O_NONBLOCK)
                         return -EWOULDBLOCK;
 
-		up(&fe->sem);
+		up(&fepriv->sem);
 
                 ret = wait_event_interruptible (events->wait_queue,
                                                 events->eventw != events->eventr);
 
-        	if (down_interruptible (&fe->sem))
+		if (down_interruptible (&fepriv->sem))
 			return -ERESTARTSYS;
 
                 if (ret < 0)
@@ -206,27 +234,28 @@
 {
 	int autoinversion;
 	int ready = 0;
-	int original_inversion = fe->parameters.inversion;
-	u32 original_frequency = fe->parameters.frequency;
+	struct dvb_frontend_private *fepriv = (struct dvb_frontend_private*) fe->frontend_priv;
+	int original_inversion = fepriv->parameters.inversion;
+	u32 original_frequency = fepriv->parameters.frequency;
 
 	/* are we using autoinversion? */
 	autoinversion = ((!(fe->ops->info.caps & FE_CAN_INVERSION_AUTO)) &&
-			 (fe->parameters.inversion == INVERSION_AUTO));
+			 (fepriv->parameters.inversion == INVERSION_AUTO));
 
 	/* setup parameters correctly */
 	while(!ready) {
 		/* calculate the lnb_drift */
-		fe->lnb_drift = fe->auto_step * fe->step_size;
+		fepriv->lnb_drift = fepriv->auto_step * fepriv->step_size;
 
 		/* wrap the auto_step if we've exceeded the maximum drift */
-		if (fe->lnb_drift > fe->max_drift) {
-			fe->auto_step = 0;
-			fe->auto_sub_step = 0;
-			fe->lnb_drift = 0;
+		if (fepriv->lnb_drift > fepriv->max_drift) {
+			fepriv->auto_step = 0;
+			fepriv->auto_sub_step = 0;
+			fepriv->lnb_drift = 0;
 		}
 
 		/* perform inversion and +/- zigzag */
-		switch(fe->auto_sub_step) {
+		switch(fepriv->auto_sub_step) {
 		case 0:
 			/* try with the current inversion and current drift setting */
 			ready = 1;
@@ -235,68 +264,70 @@
 		case 1:
 			if (!autoinversion) break;
 
-			fe->inversion = (fe->inversion == INVERSION_OFF) ? INVERSION_ON : INVERSION_OFF;
+			fepriv->inversion = (fepriv->inversion == INVERSION_OFF) ? INVERSION_ON : INVERSION_OFF;
 			ready = 1;
 			break;
 
 		case 2:
-			if (fe->lnb_drift == 0) break;
+			if (fepriv->lnb_drift == 0) break;
 		    
-			fe->lnb_drift = -fe->lnb_drift;
+			fepriv->lnb_drift = -fepriv->lnb_drift;
 			ready = 1;
 			break;
 	    
 		case 3:
-			if (fe->lnb_drift == 0) break;
+			if (fepriv->lnb_drift == 0) break;
 			if (!autoinversion) break;
 		    
-			fe->inversion = (fe->inversion == INVERSION_OFF) ? INVERSION_ON : INVERSION_OFF;
-			fe->lnb_drift = -fe->lnb_drift;
+			fepriv->inversion = (fepriv->inversion == INVERSION_OFF) ? INVERSION_ON : INVERSION_OFF;
+			fepriv->lnb_drift = -fepriv->lnb_drift;
 			ready = 1;
 			break;
 		    
 		default:
-			fe->auto_step++;
-			fe->auto_sub_step = -1; /* it'll be incremented to 0 in a moment */
+			fepriv->auto_step++;
+			fepriv->auto_sub_step = -1; /* it'll be incremented to 0 in a moment */
 			break;
 		}
 	    
-		if (!ready) fe->auto_sub_step++;
+		if (!ready) fepriv->auto_sub_step++;
 	}
 
 	/* if this attempt would hit where we started, indicate a complete
 	 * iteration has occurred */
-	if ((fe->auto_step == fe->started_auto_step) &&
-	    (fe->auto_sub_step == 0) && check_wrapped) {
+	if ((fepriv->auto_step == fepriv->started_auto_step) &&
+	    (fepriv->auto_sub_step == 0) && check_wrapped) {
 		return 1;
 		}
 
 	dprintk("%s: drift:%i inversion:%i auto_step:%i "
 		"auto_sub_step:%i started_auto_step:%i\n",
-		__FUNCTION__, fe->lnb_drift, fe->inversion,
-		fe->auto_step, fe->auto_sub_step, fe->started_auto_step);
+		__FUNCTION__, fepriv->lnb_drift, fepriv->inversion,
+		fepriv->auto_step, fepriv->auto_sub_step, fepriv->started_auto_step);
     
 	/* set the frontend itself */
-	fe->parameters.frequency += fe->lnb_drift;
+	fepriv->parameters.frequency += fepriv->lnb_drift;
 	if (autoinversion)
-		fe->parameters.inversion = fe->inversion;
+		fepriv->parameters.inversion = fepriv->inversion;
 	if (fe->ops->set_frontend)
-		fe->ops->set_frontend(fe, &fe->parameters);
+		fe->ops->set_frontend(fe, &fepriv->parameters);
 
-	fe->parameters.frequency = original_frequency;
-	fe->parameters.inversion = original_inversion;
+	fepriv->parameters.frequency = original_frequency;
+	fepriv->parameters.inversion = original_inversion;
 
-	fe->auto_sub_step++;
+	fepriv->auto_sub_step++;
 	return 0;
 }
 
 static int dvb_frontend_is_exiting(struct dvb_frontend *fe)
 {
-	if (fe->exit)
+	struct dvb_frontend_private *fepriv = (struct dvb_frontend_private*) fe->frontend_priv;
+
+	if (fepriv->exit)
 		return 1;
 
-	if (fe->dvbdev->writers == 1)
-		if (jiffies - fe->release_jiffies > dvb_shutdown_timeout * HZ)
+	if (fepriv->dvbdev->writers == 1)
+		if (jiffies - fepriv->release_jiffies > dvb_shutdown_timeout * HZ)
 			return 1;
 
 	return 0;
@@ -304,8 +335,10 @@
 
 static int dvb_frontend_should_wakeup(struct dvb_frontend *fe)
 {
-	if (fe->wakeup) {
-		fe->wakeup = 0;
+	struct dvb_frontend_private *fepriv = (struct dvb_frontend_private*) fe->frontend_priv;
+
+	if (fepriv->wakeup) {
+		fepriv->wakeup = 0;
 		return 1;
 	}
 	return dvb_frontend_is_exiting(fe);
@@ -313,8 +346,10 @@
 
 static void dvb_frontend_wakeup(struct dvb_frontend *fe)
 {
-	fe->wakeup = 1;
-	wake_up_interruptible(&fe->wait_queue);
+	struct dvb_frontend_private *fepriv = (struct dvb_frontend_private*) fe->frontend_priv;
+
+	fepriv->wakeup = 1;
+	wake_up_interruptible(&fepriv->wait_queue);
 }
 
 /*
@@ -323,6 +358,7 @@
 static int dvb_frontend_thread (void *data)
 {
 	struct dvb_frontend *fe = (struct dvb_frontend *) data;
+	struct dvb_frontend_private *fepriv = (struct dvb_frontend_private*) fe->frontend_priv;
 	unsigned long timeout;
 	char name [15];
 	int quality = 0, delay = 3*HZ;
@@ -338,14 +374,14 @@
         sigfillset (&current->blocked);
         unlock_kernel ();
 
-	fe->status = 0;
+	fepriv->status = 0;
 	dvb_frontend_init (fe);
-	fe->wakeup = 0;
+	fepriv->wakeup = 0;
 
 	while (1) {
-		up (&fe->sem);      /* is locked when we enter the thread... */
+		up(&fepriv->sem);	    /* is locked when we enter the thread... */
 
-		timeout = wait_event_interruptible_timeout(fe->wait_queue,
+		timeout = wait_event_interruptible_timeout(fepriv->wait_queue,
 							   dvb_frontend_should_wakeup(fe),
 							   delay);
 		if (0 != dvb_frontend_is_exiting (fe)) {
@@ -356,44 +392,43 @@
 		if (current->flags & PF_FREEZE)
 			refrigerator(PF_FREEZE);
 
-		if (down_interruptible (&fe->sem))
+		if (down_interruptible(&fepriv->sem))
 			break;
 
 		/* if we've got no parameters, just keep idling */
-		if (fe->state & FESTATE_IDLE) {
+		if (fepriv->state & FESTATE_IDLE) {
 			delay = 3*HZ;
 			quality = 0;
 			continue;
 		}
 
-retune:
 		/* get the frontend status */
-		if (fe->state & FESTATE_RETUNE) {
+		if (fepriv->state & FESTATE_RETUNE) {
 			s = 0;
 		} else {
 			if (fe->ops->read_status)
 				fe->ops->read_status(fe, &s);
-			if (s != fe->status) {
+			if (s != fepriv->status) {
 			dvb_frontend_add_event (fe, s);
-				fe->status = s;
+				fepriv->status = s;
 			}
 		}
 		/* if we're not tuned, and we have a lock, move to the TUNED state */
-		if ((fe->state & FESTATE_WAITFORLOCK) && (s & FE_HAS_LOCK)) {
-			update_delay(&quality, &delay, fe->min_delay, s & FE_HAS_LOCK);
-			fe->state = FESTATE_TUNED;
+		if ((fepriv->state & FESTATE_WAITFORLOCK) && (s & FE_HAS_LOCK)) {
+			update_delay(&quality, &delay, fepriv->min_delay, s & FE_HAS_LOCK);
+			fepriv->state = FESTATE_TUNED;
 
 			/* if we're tuned, then we have determined the correct inversion */
 			if ((!(fe->ops->info.caps & FE_CAN_INVERSION_AUTO)) &&
-			    (fe->parameters.inversion == INVERSION_AUTO)) {
-				fe->parameters.inversion = fe->inversion;
+			    (fepriv->parameters.inversion == INVERSION_AUTO)) {
+				fepriv->parameters.inversion = fepriv->inversion;
 			}
 			continue;
 		}
 
 		/* if we are tuned already, check we're still locked */
-		if (fe->state & FESTATE_TUNED) {
-			update_delay(&quality, &delay, fe->min_delay, s & FE_HAS_LOCK);
+		if (fepriv->state & FESTATE_TUNED) {
+			update_delay(&quality, &delay, fepriv->min_delay, s & FE_HAS_LOCK);
 
 			/* we're tuned, and the lock is still good... */
 			if (s & FE_HAS_LOCK)
@@ -401,49 +436,49 @@
 			else {
 				/* if we _WERE_ tuned, but now don't have a lock,
 				 * need to zigzag */
-				fe->state = FESTATE_ZIGZAG_FAST;
-				fe->started_auto_step = fe->auto_step;
+				fepriv->state = FESTATE_ZIGZAG_FAST;
+				fepriv->started_auto_step = fepriv->auto_step;
 				check_wrapped = 0;
 			}
 		}
 
 		/* don't actually do anything if we're in the LOSTLOCK state,
 		 * the frontend is set to FE_CAN_RECOVER, and the max_drift is 0 */
-		if ((fe->state & FESTATE_LOSTLOCK) && 
-		    (fe->ops->info.caps & FE_CAN_RECOVER) && (fe->max_drift == 0)) {
-			update_delay(&quality, &delay, fe->min_delay, s & FE_HAS_LOCK);
+		if ((fepriv->state & FESTATE_LOSTLOCK) &&
+		    (fe->ops->info.caps & FE_CAN_RECOVER) && (fepriv->max_drift == 0)) {
+			update_delay(&quality, &delay, fepriv->min_delay, s & FE_HAS_LOCK);
 						continue;
 				}
 	    
 		/* don't do anything if we're in the DISEQC state, since this
 		 * might be someone with a motorized dish controlled by DISEQC.
 		 * If its actually a re-tune, there will be a SET_FRONTEND soon enough.	*/
-		if (fe->state & FESTATE_DISEQC) {
-			update_delay(&quality, &delay, fe->min_delay, s & FE_HAS_LOCK);
+		if (fepriv->state & FESTATE_DISEQC) {
+			update_delay(&quality, &delay, fepriv->min_delay, s & FE_HAS_LOCK);
 			continue;
 				}
 
 		/* if we're in the RETUNE state, set everything up for a brand
 		 * new scan, keeping the current inversion setting, as the next
 		 * tune is _very_ likely to require the same */
-		if (fe->state & FESTATE_RETUNE) {
-			fe->lnb_drift = 0;
-			fe->auto_step = 0;
-			fe->auto_sub_step = 0;
-			fe->started_auto_step = 0;
+		if (fepriv->state & FESTATE_RETUNE) {
+			fepriv->lnb_drift = 0;
+			fepriv->auto_step = 0;
+			fepriv->auto_sub_step = 0;
+			fepriv->started_auto_step = 0;
 			check_wrapped = 0;
 		}
 
 		/* fast zigzag. */
-		if ((fe->state & FESTATE_SEARCHING_FAST) || (fe->state & FESTATE_RETUNE)) {
-			delay = fe->min_delay;
+		if ((fepriv->state & FESTATE_SEARCHING_FAST) || (fepriv->state & FESTATE_RETUNE)) {
+			delay = fepriv->min_delay;
 
 			/* peform a tune */
 			if (dvb_frontend_autotune(fe, check_wrapped)) {
 				/* OK, if we've run out of trials at the fast speed.
 				 * Drop back to slow for the _next_ attempt */
-				fe->state = FESTATE_SEARCHING_SLOW;
-				fe->started_auto_step = fe->auto_step;
+				fepriv->state = FESTATE_SEARCHING_SLOW;
+				fepriv->started_auto_step = fepriv->auto_step;
 				continue;
 			}
 			check_wrapped = 1;
@@ -452,15 +487,14 @@
 			 * This ensures we cannot return from an
 			 * FE_SET_FRONTEND ioctl before the first frontend tune
 			 * occurs */
-			if (fe->state & FESTATE_RETUNE) {
-				fe->state = FESTATE_TUNING_FAST;
-				goto retune;
+			if (fepriv->state & FESTATE_RETUNE) {
+				fepriv->state = FESTATE_TUNING_FAST;
 			}
 		}
 
 		/* slow zigzag */
-		if (fe->state & FESTATE_SEARCHING_SLOW) {
-			update_delay(&quality, &delay, fe->min_delay, s & FE_HAS_LOCK);
+		if (fepriv->state & FESTATE_SEARCHING_SLOW) {
+			update_delay(&quality, &delay, fepriv->min_delay, s & FE_HAS_LOCK);
 		    
 			/* Note: don't bother checking for wrapping; we stay in this
 			 * state until we get a lock */
@@ -476,7 +510,7 @@
 			fe->ops->sleep(fe);
 	}
 
-	fe->thread_pid = 0;
+	fepriv->thread_pid = 0;
 	mb();
 
 	dvb_frontend_wakeup(fe);
@@ -486,21 +520,22 @@
 static void dvb_frontend_stop(struct dvb_frontend *fe)
 {
 	unsigned long ret;
+	struct dvb_frontend_private *fepriv = (struct dvb_frontend_private*) fe->frontend_priv;
 
 	dprintk ("%s\n", __FUNCTION__);
 
-		fe->exit = 1;
+	fepriv->exit = 1;
 	mb();
 
-	if (!fe->thread_pid)
+	if (!fepriv->thread_pid)
 		return;
 
 	/* check if the thread is really alive */
-	if (kill_proc(fe->thread_pid, 0, 1) == -ESRCH) {
+	if (kill_proc(fepriv->thread_pid, 0, 1) == -ESRCH) {
 		printk("dvb_frontend_stop: thread PID %d already died\n",
-				fe->thread_pid);
+				fepriv->thread_pid);
 		/* make sure the mutex was not held by the thread */
-		init_MUTEX (&fe->sem);
+		init_MUTEX (&fepriv->sem);
 		return;
 	}
 
@@ -508,27 +543,28 @@
 	dvb_frontend_wakeup(fe);
 
 	/* wait until the frontend thread has exited */
-	ret = wait_event_interruptible(fe->wait_queue,0 == fe->thread_pid);
+	ret = wait_event_interruptible(fepriv->wait_queue,0 == fepriv->thread_pid);
 	if (-ERESTARTSYS != ret) {
-		fe->state = FESTATE_IDLE;
+		fepriv->state = FESTATE_IDLE;
 		return;
 	}
-	fe->state = FESTATE_IDLE;
+	fepriv->state = FESTATE_IDLE;
 
 	/* paranoia check in case a signal arrived */
-	if (fe->thread_pid)
+	if (fepriv->thread_pid)
 		printk("dvb_frontend_stop: warning: thread PID %d won't exit\n",
-				fe->thread_pid);
+				fepriv->thread_pid);
 }
 
 static int dvb_frontend_start(struct dvb_frontend *fe)
 {
 	int ret;
+	struct dvb_frontend_private *fepriv = (struct dvb_frontend_private*) fe->frontend_priv;
 
 	dprintk ("%s\n", __FUNCTION__);
 
-	if (fe->thread_pid) {
-		if (!fe->exit)
+	if (fepriv->thread_pid) {
+		if (!fepriv->exit)
 			return 0;
 		else
 		dvb_frontend_stop (fe);
@@ -536,12 +572,12 @@
 
 	if (signal_pending(current))
 		return -EINTR;
-	if (down_interruptible (&fe->sem))
+	if (down_interruptible (&fepriv->sem))
 		return -EINTR;
 
-	fe->state = FESTATE_IDLE;
-	fe->exit = 0;
-	fe->thread_pid = 0;
+	fepriv->state = FESTATE_IDLE;
+	fepriv->exit = 0;
+	fepriv->thread_pid = 0;
 	mb();
 
 	ret = kernel_thread (dvb_frontend_thread, fe, 0);
@@ -545,12 +581,13 @@
 	mb();
 
 	ret = kernel_thread (dvb_frontend_thread, fe, 0);
+
 	if (ret < 0) {
 		printk("dvb_frontend_start: failed to start kernel_thread (%d)\n", ret);
-		up(&fe->sem);
+		up(&fepriv->sem);
 		return ret;
 	}
-	fe->thread_pid = ret;
+	fepriv->thread_pid = ret;
 
 	return 0;
 }
@@ -561,11 +597,12 @@
 {
 	struct dvb_device *dvbdev = file->private_data;
 	struct dvb_frontend *fe = dvbdev->priv;
+	struct dvb_frontend_private *fepriv = (struct dvb_frontend_private*) fe->frontend_priv;
 	int err = -EOPNOTSUPP;
 
 	dprintk ("%s\n", __FUNCTION__);
 
-	if (!fe || fe->exit)
+	if (!fe || fepriv->exit)
 		return -ENODEV;
 
 	if ((file->f_flags & O_ACCMODE) == O_RDONLY &&
@@ -573,7 +610,7 @@
 	     cmd == FE_DISEQC_RECV_SLAVE_REPLY))
 		return -EPERM;
 
-	if (down_interruptible (&fe->sem))
+	if (down_interruptible (&fepriv->sem))
 		return -ERESTARTSYS;
 
 	switch (cmd) {
@@ -617,48 +654,48 @@
 	case FE_DISEQC_RESET_OVERLOAD:
 		if (fe->ops->diseqc_reset_overload) {
 			err = fe->ops->diseqc_reset_overload(fe);
-			fe->state = FESTATE_DISEQC;
-			fe->status = 0;
+			fepriv->state = FESTATE_DISEQC;
+			fepriv->status = 0;
 		}
 		break;
 
 	case FE_DISEQC_SEND_MASTER_CMD:
 		if (fe->ops->diseqc_send_master_cmd) {
 			err = fe->ops->diseqc_send_master_cmd(fe, (struct dvb_diseqc_master_cmd*) parg);
-			fe->state = FESTATE_DISEQC;
-			fe->status = 0;
+			fepriv->state = FESTATE_DISEQC;
+			fepriv->status = 0;
 		}
 		break;
 
 	case FE_DISEQC_SEND_BURST:
 		if (fe->ops->diseqc_send_burst) {
 			err = fe->ops->diseqc_send_burst(fe, (fe_sec_mini_cmd_t) parg);
-			fe->state = FESTATE_DISEQC;
-			fe->status = 0;
+			fepriv->state = FESTATE_DISEQC;
+			fepriv->status = 0;
 		}
 		break;
 
 	case FE_SET_TONE:
 		if (fe->ops->set_tone) {
 			err = fe->ops->set_tone(fe, (fe_sec_tone_mode_t) parg);
-			fe->state = FESTATE_DISEQC;
-			fe->status = 0;
+			fepriv->state = FESTATE_DISEQC;
+			fepriv->status = 0;
 		}
 		break;
 
 	case FE_SET_VOLTAGE:
 		if (fe->ops->set_voltage) {
 			err = fe->ops->set_voltage(fe, (fe_sec_voltage_t) parg);
-		fe->state = FESTATE_DISEQC;
-			fe->status = 0;
+			fepriv->state = FESTATE_DISEQC;
+			fepriv->status = 0;
 		}
 		break;
 
 	case FE_DISHNETWORK_SEND_LEGACY_CMD:
 		if (fe->ops->dishnetwork_send_legacy_command) {
 			err = fe->ops->dishnetwork_send_legacy_command(fe, (unsigned int) parg);
-			fe->state = FESTATE_DISEQC;
-			fe->status = 0;
+			fepriv->state = FESTATE_DISEQC;
+			fepriv->status = 0;
 		}
 		break;
 
@@ -668,14 +705,14 @@
 		break;
 
 	case FE_ENABLE_HIGH_LNB_VOLTAGE:
-		if (fe->ops->enable_high_lnb_voltage);
+		if (fe->ops->enable_high_lnb_voltage)
 			err = fe->ops->enable_high_lnb_voltage(fe, (int) parg);
 		break;
 
 	case FE_SET_FRONTEND: {
 		struct dvb_frontend_tune_settings fetunesettings;
 	    
-		memcpy (&fe->parameters, parg,
+		memcpy (&fepriv->parameters, parg,
 			sizeof (struct dvb_frontend_parameters));
 
 		memset(&fetunesettings, 0, sizeof(struct dvb_frontend_tune_settings));
@@ -684,41 +721,41 @@
 		    
 		/* force auto frequency inversion if requested */
 		if (dvb_force_auto_inversion) {
-			fe->parameters.inversion = INVERSION_AUTO;
+			fepriv->parameters.inversion = INVERSION_AUTO;
 			fetunesettings.parameters.inversion = INVERSION_AUTO;
 		}
 		if (fe->ops->info.type == FE_OFDM) {
 			/* without hierachical coding code_rate_LP is irrelevant,
 			 * so we tolerate the otherwise invalid FEC_NONE setting */
-			if (fe->parameters.u.ofdm.hierarchy_information == HIERARCHY_NONE &&
-			    fe->parameters.u.ofdm.code_rate_LP == FEC_NONE)
-				fe->parameters.u.ofdm.code_rate_LP = FEC_AUTO;
+			if (fepriv->parameters.u.ofdm.hierarchy_information == HIERARCHY_NONE &&
+			    fepriv->parameters.u.ofdm.code_rate_LP == FEC_NONE)
+				fepriv->parameters.u.ofdm.code_rate_LP = FEC_AUTO;
 		}
 
 		/* get frontend-specific tuning settings */
 		if (fe->ops->get_tune_settings && (fe->ops->get_tune_settings(fe, &fetunesettings) == 0)) {
-			fe->min_delay = (fetunesettings.min_delay_ms * HZ) / 1000;
-			fe->max_drift = fetunesettings.max_drift;
-			fe->step_size = fetunesettings.step_size;
+			fepriv->min_delay = (fetunesettings.min_delay_ms * HZ) / 1000;
+			fepriv->max_drift = fetunesettings.max_drift;
+			fepriv->step_size = fetunesettings.step_size;
 		} else {
 			/* default values */
 			switch(fe->ops->info.type) {
 			case FE_QPSK:
-				fe->min_delay = HZ/20;
-				fe->step_size = fe->parameters.u.qpsk.symbol_rate / 16000;
-				fe->max_drift = fe->parameters.u.qpsk.symbol_rate / 2000;
+				fepriv->min_delay = HZ/20;
+				fepriv->step_size = fepriv->parameters.u.qpsk.symbol_rate / 16000;
+				fepriv->max_drift = fepriv->parameters.u.qpsk.symbol_rate / 2000;
 		break;
 			    
 			case FE_QAM:
-				fe->min_delay = HZ/20;
-				fe->step_size = 0; /* no zigzag */
-				fe->max_drift = 0;
+				fepriv->min_delay = HZ/20;
+				fepriv->step_size = 0; /* no zigzag */
+				fepriv->max_drift = 0;
 				break;
 			    
 			case FE_OFDM:
-				fe->min_delay = HZ/20;
-				fe->step_size = fe->ops->info.frequency_stepsize * 2;
-				fe->max_drift = (fe->ops->info.frequency_stepsize * 2) + 1;
+				fepriv->min_delay = HZ/20;
+				fepriv->step_size = fe->ops->info.frequency_stepsize * 2;
+				fepriv->max_drift = (fe->ops->info.frequency_stepsize * 2) + 1;
 				break;
 			case FE_ATSC:
 				printk("dvb-core: FE_ATSC not handled yet.\n");
@@ -726,12 +763,12 @@
 			}
 		}
 		if (dvb_override_tune_delay > 0)
-		       fe->min_delay = (dvb_override_tune_delay * HZ) / 1000;
+			fepriv->min_delay = (dvb_override_tune_delay * HZ) / 1000;
 
-		fe->state = FESTATE_RETUNE;
+		fepriv->state = FESTATE_RETUNE;
 		dvb_frontend_wakeup(fe);
 		dvb_frontend_add_event (fe, 0);	    
-		fe->status = 0;
+		fepriv->status = 0;
 		err = 0;
 		break;
 	}
@@ -742,13 +779,13 @@
 
 	case FE_GET_FRONTEND:
 		if (fe->ops->get_frontend) {
-			memcpy (parg, &fe->parameters, sizeof (struct dvb_frontend_parameters));
+			memcpy (parg, &fepriv->parameters, sizeof (struct dvb_frontend_parameters));
 			err = fe->ops->get_frontend(fe, (struct dvb_frontend_parameters*) parg);
 		}
 		break;
 	};
 
-	up (&fe->sem);
+	up (&fepriv->sem);
 	return err;
 }
 
@@ -757,12 +793,13 @@
 {
 	struct dvb_device *dvbdev = file->private_data;
 	struct dvb_frontend *fe = dvbdev->priv;
+	struct dvb_frontend_private *fepriv = (struct dvb_frontend_private*) fe->frontend_priv;
 
 	dprintk ("%s\n", __FUNCTION__);
 
-	poll_wait (file, &fe->events.wait_queue, wait);
+	poll_wait (file, &fepriv->events.wait_queue, wait);
 
-	if (fe->events.eventw != fe->events.eventr)
+	if (fepriv->events.eventw != fepriv->events.eventr)
 		return (POLLIN | POLLRDNORM | POLLPRI);
 
 	return 0;
@@ -773,6 +809,7 @@
 {
 	struct dvb_device *dvbdev = file->private_data;
 	struct dvb_frontend *fe = dvbdev->priv;
+	struct dvb_frontend_private *fepriv = (struct dvb_frontend_private*) fe->frontend_priv;
 	int ret;
 
 	dprintk ("%s\n", __FUNCTION__);
@@ -786,7 +823,7 @@
 			dvb_generic_release (inode, file);
 
 		/*  empty event queue */
-		fe->events.eventr = fe->events.eventw = 0;
+		fepriv->events.eventr = fepriv->events.eventw = 0;
 	}
 	
 	return ret;
@@ -797,11 +833,12 @@
 {
 	struct dvb_device *dvbdev = file->private_data;
 	struct dvb_frontend *fe = dvbdev->priv;
+	struct dvb_frontend_private *fepriv = (struct dvb_frontend_private*) fe->frontend_priv;
 
 	dprintk ("%s\n", __FUNCTION__);
 
 	if ((file->f_flags & O_ACCMODE) != O_RDONLY)
-		fe->release_jiffies = jiffies;
+		fepriv->release_jiffies = jiffies;
 
 	return dvb_generic_release (inode, file);
 }
@@ -818,6 +854,7 @@
 int dvb_register_frontend(struct dvb_adapter* dvb,
 			  struct dvb_frontend* fe)
 {
+	struct dvb_frontend_private *fepriv;
 	static const struct dvb_device dvbdev_template = {
 		.users = ~0,
 		.writers = 1,
@@ -831,20 +868,26 @@
 	if (down_interruptible (&frontend_mutex))
 		return -ERESTARTSYS;
 
-	init_MUTEX (&fe->sem);
-	init_waitqueue_head (&fe->wait_queue);
-	init_waitqueue_head (&fe->events.wait_queue);
-	init_MUTEX (&fe->events.sem);
-	fe->events.eventw = fe->events.eventr = 0;
-	fe->events.overflow = 0;
+	fe->frontend_priv = kmalloc(sizeof(struct dvb_frontend_private), GFP_KERNEL);
+	if (fe->frontend_priv == NULL) {
+		up(&frontend_mutex);
+		return -ENOMEM;
+	}
+	fepriv = (struct dvb_frontend_private*) fe->frontend_priv;
+	memset(fe->frontend_priv, 0, sizeof(struct dvb_frontend_private));
+
+	init_MUTEX (&fepriv->sem);
+	init_waitqueue_head (&fepriv->wait_queue);
+	init_waitqueue_head (&fepriv->events.wait_queue);
+	init_MUTEX (&fepriv->events.sem);
 	fe->dvb = dvb;
-	fe->inversion = INVERSION_OFF;
+	fepriv->inversion = INVERSION_OFF;
 
 	printk ("DVB: registering frontend %i (%s)...\n",
 		fe->dvb->num,
 		fe->ops->info.name);
 
-	dvb_register_device (fe->dvb, &fe->dvbdev, &dvbdev_template,
+	dvb_register_device (fe->dvb, &fepriv->dvbdev, &dvbdev_template,
 			     fe, DVB_DEVICE_FRONTEND);
 
 	up (&frontend_mutex);
@@ -854,15 +897,18 @@
 
 int dvb_unregister_frontend(struct dvb_frontend* fe)
 {
+	struct dvb_frontend_private *fepriv = (struct dvb_frontend_private*) fe->frontend_priv;
 	dprintk ("%s\n", __FUNCTION__);
 
 	down (&frontend_mutex);
-			dvb_unregister_device (fe->dvbdev);
+	dvb_unregister_device (fepriv->dvbdev);
 			dvb_frontend_stop (fe);
 	if (fe->ops->release)
 		fe->ops->release(fe);
 	else
 		printk("dvb_frontend: Demodulator (%s) does not have a release callback!\n", fe->ops->info.name);
+	if (fe->frontend_priv)
+		kfree(fe->frontend_priv);
 	up (&frontend_mutex);
 	return 0;
 }
diff -uraNwB linux-2.6.11-rc2/drivers/media/dvb/dvb-core/dvb_frontend.h linux-2.6.11-rc2-dvb/drivers/media/dvb/dvb-core/dvb_frontend.h
--- linux-2.6.11-rc2/drivers/media/dvb/dvb-core/dvb_frontend.h	2005-01-20 19:54:05.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/dvb/dvb-core/dvb_frontend.h	2005-01-20 19:56:37.000000000 +0100
@@ -115,28 +115,7 @@
 	struct dvb_frontend_ops* ops;
 	struct dvb_adapter *dvb;
 	void* demodulator_priv;
-
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
-	fe_status_t status;
+	void* frontend_priv;
 };
 
 extern int dvb_register_frontend(struct dvb_adapter* dvb,
diff -uraNwB linux-2.6.11-rc2/drivers/media/dvb/dvb-core/dvb_net.c linux-2.6.11-rc2-dvb/drivers/media/dvb/dvb-core/dvb_net.c
--- linux-2.6.11-rc2/drivers/media/dvb/dvb-core/dvb_net.c	2005-01-20 19:54:05.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/dvb/dvb-core/dvb_net.c	2005-01-20 19:56:37.000000000 +0100
@@ -123,7 +123,6 @@
 struct dvb_net_priv {
 	int in_use;
         struct net_device_stats stats;
-        char name[6];
 	u16 pid;
 	struct dvb_net *host;
         struct dmx_demux *demux;
@@ -1165,12 +1162,17 @@
 	if ((if_num = get_if(dvbnet)) < 0)
 		return -EINVAL;
 
-	net = alloc_netdev(sizeof(struct dvb_net_priv), "dvb",
-			   dvb_net_setup);
+	net = alloc_netdev(sizeof(struct dvb_net_priv), "dvb", dvb_net_setup);
 	if (!net)
 		return -ENOMEM;
 	
-	sprintf(net->name, "dvb%d_%d", dvbnet->dvbdev->adapter->num, if_num);
+	if (dvbnet->dvbdev->id)
+		snprintf(net->name, IFNAMSIZ, "dvb%d%u%d",
+			 dvbnet->dvbdev->adapter->num, dvbnet->dvbdev->id, if_num);
+	else
+		/* compatibility fix to keep dvb0_0 format */
+		snprintf(net->name, IFNAMSIZ, "dvb%d_%d",
+			 dvbnet->dvbdev->adapter->num, if_num);
 
 	net->addr_len  		= 6;
 	memcpy(net->dev_addr, dvbnet->dvbdev->adapter->proposed_mac, 6);
@@ -1196,6 +1198,7 @@
 		free_netdev(net);
 		return result;
 	}
+	printk("dvb_net: created network interface %s\n", net->name);
 
         return if_num;
 }
@@ -1214,6 +1216,7 @@
 
 	dvb_net_stop(net);
 	flush_scheduled_work();
+	printk("dvb_net: removed network interface %s\n", net->name);
         unregister_netdev(net);
 	dvbnet->state[num]=0;
 	dvbnet->device[num] = NULL;
diff -uraNwB linux-2.6.11-rc2/drivers/media/dvb/ttusb-dec/ttusb_dec.c linux-2.6.11-rc2-dvb/drivers/media/dvb/ttusb-dec/ttusb_dec.c
--- linux-2.6.11-rc2/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2005-01-20 19:55:47.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2005-01-20 19:56:40.000000000 +0100
@@ -756,7 +755,7 @@
 
 	if (!dec->iso_stream_count) {
 		for (i = 0; i < ISO_BUF_COUNT; i++)
-			usb_unlink_urb(dec->iso_urb[i]);
+			usb_kill_urb(dec->iso_urb[i]);
 	}
 
 	up(&dec->iso_sem);
@@ -821,7 +820,7 @@
 				       "error %d\n", __FUNCTION__, i, result);
 
 				while (i) {
-					usb_unlink_urb(dec->iso_urb[i - 1]);
+					usb_kill_urb(dec->iso_urb[i - 1]);
 					i--;
 				}
 
@@ -1379,7 +1378,7 @@
 	dec->iso_stream_count = 0;
 
 	for (i = 0; i < ISO_BUF_COUNT; i++)
-		usb_unlink_urb(dec->iso_urb[i]);
+		usb_kill_urb(dec->iso_urb[i]);
 
 	ttusb_dec_free_iso_urbs(dec);
 }
diff -uraNwB linux-2.6.11-rc2/include/linux/dvb/frontend.h linux-2.6.11-rc2-dvb/include/linux/dvb/frontend.h
--- linux-2.6.11-rc2/include/linux/dvb/frontend.h	2005-01-20 19:53:19.000000000 +0100
+++ linux-2.6.11-rc2-dvb/include/linux/dvb/frontend.h	2004-12-17 22:00:18.000000000 +0100
@@ -158,10 +158,11 @@
         QAM_64,
         QAM_128,
         QAM_256,
-	QAM_AUTO
+	QAM_AUTO,
+	VSB_8,
+	VSB_16
 } fe_modulation_t;
 
-
 typedef enum fe_transmit_mode {
 	TRANSMISSION_MODE_2K,
 	TRANSMISSION_MODE_8K,
@@ -206,6 +206,9 @@
         fe_modulation_t  modulation;  /* modulation type (see above) */
 };
 
+struct dvb_vsb_parameters {
+	fe_modulation_t	modulation;  /* modulation type (see above) */
+};
 
 struct dvb_ofdm_parameters {
         fe_bandwidth_t      bandwidth;
@@ -219,13 +222,14 @@
 
 
 struct dvb_frontend_parameters {
-        __u32 frequency;     /* (absolute) frequency in Hz for QAM/OFDM */
+	__u32 frequency;     /* (absolute) frequency in Hz for QAM/OFDM/ATSC */
                                   /* intermediate frequency in kHz for QPSK */
 	fe_spectral_inversion_t inversion;
 	union {
 		struct dvb_qpsk_parameters qpsk;
 		struct dvb_qam_parameters  qam;
 		struct dvb_ofdm_parameters ofdm;
+		struct dvb_vsb_parameters vsb;
 	} u;
 };
 
diff -uraNwB linux-2.6.11-rc2/include/linux/dvb/version.h linux-2.6.11-rc2-dvb/include/linux/dvb/version.h
--- linux-2.6.11-rc2/include/linux/dvb/version.h	2005-01-20 19:53:19.000000000 +0100
+++ linux-2.6.11-rc2-dvb/include/linux/dvb/version.h	2004-12-17 22:00:18.000000000 +0100
@@ -24,6 +24,7 @@
 #define _DVBVERSION_H_
 
 #define DVB_API_VERSION 3
+#define DVB_API_VERSION_MINOR 1
 
 #endif /*_DVBVERSION_H_*/
 

