Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263356AbUARSmT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 13:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262888AbUARSki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 13:40:38 -0500
Received: from mail.convergence.de ([212.84.236.4]:46828 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S262965AbUARSfl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 13:35:41 -0500
To: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       hunold@linuxtv.org
From: Michael Hunold <hunold@linuxtv.org>
Subject: [PATCH 3/5] Update DVB core
In-Reply-To: <1074450922352@convergence.de>
Message-Id: <10744509231692@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring_mihu_extended
Date: Sun, 18 Jan 2004 13:35:41 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] demux: fix nasty bug where setting multiple filters resulted in ts packet duplication
- [DVB] frontend: merge frontend improvements from 2.4 DVB tree:
         - schedule_timeout(1) in dvb_frontend.c after setting frontend and before waking up frontend thread
         - do FE_RESET in each iteration of frontend thread if !FE_HAS_LOCK
         - use aquire_signal flag to call FE_RESET only after tuning until FE_HAS_LOCK has been signalled, and not when FE_HAS_LOCK drops out for short periods of time later
- [DVB] - follow frontend changes in ves1x93 driver
diff -uraNbBw xx-linux-2.6.1-mm4/drivers/media/dvb/dvb-core/dvb_demux.c linux-2.6.1-mm4.patched/drivers/media/dvb/dvb-core/dvb_demux.c
--- xx-linux-2.6.1-mm4/drivers/media/dvb/dvb-core/dvb_demux.c	2004-01-16 19:48:22.000000000 +0100
+++ linux-2.6.1-mm4.patched/drivers/media/dvb/dvb-core/dvb_demux.c	2004-01-16 18:21:56.000000000 +0100
@@ -395,17 +397,35 @@
 	}
 }
 
+#define DVR_FEED(f)							\
+	(((f)->type == DMX_TYPE_TS) &&					\
+	((f)->feed.ts.is_filtering) &&					\
+	(((f)->ts_type & (TS_PACKET|TS_PAYLOAD_ONLY)) == TS_PACKET))
 
 void dvb_dmx_swfilter_packet(struct dvb_demux *demux, const u8 *buf)
 {
 	struct dvb_demux_feed *feed;
 	struct list_head *pos, *head=&demux->feed_list;
 	u16 pid = ts_pid(buf);
+	int dvr_done = 0;
 
 	list_for_each(pos, head) {
 		feed = list_entry(pos, struct dvb_demux_feed, list_head);
-		if (feed->pid == pid)
+
+		if ((feed->pid != pid) && (feed->pid != 0x2000))
+			continue;
+
+		/* copy each packet only once to the dvr device, even
+		 * if a PID is in multiple filters (e.g. video + PCR) */
+		if ((DVR_FEED(feed)) && (dvr_done++))
+			continue;
+
+		if (feed->pid == pid) {
 			dvb_dmx_swfilter_packet_type (feed, buf);
+			if (DVR_FEED(feed))
+				continue;
+		}
+
 		if (feed->pid == 0x2000)
 			feed->cb.ts(buf, 188, 0, 0, &feed->feed.ts, DMX_OK);
 	}
diff -uraNbBw xx-linux-2.6.1-mm4/drivers/media/dvb/dvb-core/dvb_frontend.c linux-2.6.1-mm4.patched/drivers/media/dvb/dvb-core/dvb_frontend.c
--- xx-linux-2.6.1-mm4/drivers/media/dvb/dvb-core/dvb_frontend.c	2004-01-16 19:48:22.000000000 +0100
+++ linux-2.6.1-mm4.patched/drivers/media/dvb/dvb-core/dvb_frontend.c	2004-01-16 18:21:56.000000000 +0100
@@ -67,6 +67,7 @@
 	pid_t thread_pid;
 	unsigned long release_jiffies;
 	unsigned long lost_sync_jiffies;
+	int aquire_signal;
 	int bending;
 	int lnb_drift;
 	int timeout_count;
@@ -305,6 +306,7 @@
 		fe->lost_sync_count = 0;
 		fe->lost_sync_jiffies = jiffies;
 		fe->lnb_drift = 0;
+		fe->aquire_signal = 1;
 		if (fe->status & ~FE_TIMEDOUT)
 			dvb_frontend_add_event (fe, 0);
 		memcpy (&fe->parameters, param,
@@ -364,6 +366,9 @@
  */
 static void dvb_frontend_recover (struct dvb_frontend_data *fe)
 {
+	int j = fe->lost_sync_count;
+	int stepsize;
+
 	dprintk ("%s\n", __FUNCTION__);
 
 #if 0
@@ -383,10 +388,6 @@
 	/**
 	 *  let's start a zigzag scan to compensate LNB drift...
 	 */
-	{
-		int j = fe->lost_sync_count;
-		int stepsize;
-		
 		if (fe->info->type == FE_QPSK)
 			stepsize = fe->parameters.u.qpsk.symbol_rate / 16000;
 		else if (fe->info->type == FE_QAM)
@@ -403,7 +404,6 @@
 		}
 
 		dvb_frontend_set_parameters (fe, &fe->parameters, 0);
-	}
 
 	dvb_frontend_internal_ioctl (&fe->frontend, FE_RESET, NULL);
 }
@@ -467,13 +467,19 @@
 		if (s & FE_HAS_LOCK) {
 			fe->timeout_count = 0;
 			fe->lost_sync_count = 0;
+			fe->aquire_signal = 0;
 		} else {
 			fe->lost_sync_count++;
 			if (!(fe->info->caps & FE_CAN_RECOVER)) {
 				if (!(fe->info->caps & FE_CAN_CLEAN_SETUP)) {
-					if (fe->lost_sync_count < 10)
+					if (fe->lost_sync_count < 10) {
+						if (fe->aquire_signal)
+							dvb_frontend_internal_ioctl(
+									&fe->frontend,
+									FE_RESET, NULL);
 						continue;
 				}
+				}
 				dvb_frontend_recover (fe);
 				delay = HZ/5;
 			}
@@ -589,6 +611,9 @@
 		break;
 	case FE_SET_FRONTEND:
 		err = dvb_frontend_set_parameters (fe, parg, 1);
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(1);
+		wake_up_interruptible(&fe->wait_queue);
 		break;
 	case FE_GET_EVENT:
 		err = dvb_frontend_get_event (fe, parg, file->f_flags);
diff -uraNbBw xx-linux-2.6.1-mm4/drivers/media/dvb/frontends/ves1x93.c linux-2.6.1-mm4.patched/drivers/media/dvb/frontends/ves1x93.c
--- xx-linux-2.6.1-mm4/drivers/media/dvb/frontends/ves1x93.c	2004-01-16 19:48:22.000000000 +0100
+++ linux-2.6.1-mm4.patched/drivers/media/dvb/frontends/ves1x93.c	2004-01-16 18:21:56.000000000 +0100
@@ -395,9 +395,6 @@
 	else
 		ves1x93_writereg (i2c, 0x05, init_1x93_tab[0x05] & 0x7f);
 
-	ves1x93_writereg (i2c, 0x00, 0x00);
-	ves1x93_writereg (i2c, 0x00, 0x01);
-
 	/* ves1993 hates this, will lose lock */
 	if (demod_type != DEMOD_VES1993)
 		ves1x93_clr_bit (i2c);


