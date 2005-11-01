Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965041AbVKAIWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbVKAIWK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965060AbVKAIPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:15:11 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:64216 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S965041AbVKAIPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:15:06 -0500
Message-ID: <436723DB.2000300@m1k.net>
Date: Tue, 01 Nov 2005 03:14:19 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: [PATCH 18/37] dvb: let other frontends support FE_DISHNETWORK_SEND_LEGACY_CMD
Content-Type: multipart/mixed;
 boundary="------------030907040907070400060109"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030907040907070400060109
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit




--------------030907040907070400060109
Content-Type: text/x-patch;
 name="2382.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2382.patch"

From: NooneImportant <nxhxzi702@sneakemail.com>

Add support to FE_DISHNETWORK_SEND_LEGACY_CMD code to support other
frontends besides stv0299.  The generic code is a fallback in the case
that it doesn't work for some specific frontends (again stv0299 being
a good example).

Signed-off-by: NooneImportant <nxhxzi702@sneakemail.com>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>

 drivers/media/dvb/dvb-core/dvb_frontend.c |   97 ++++++++++++++++++++++++++++++
 drivers/media/dvb/dvb-core/dvb_frontend.h |    3 
 drivers/media/dvb/frontends/stv0299.c     |   38 +----------
 3 files changed, 104 insertions(+), 34 deletions(-)

--- linux-2.6.14-git3.orig/drivers/media/dvb/dvb-core/dvb_frontend.c
+++ linux-2.6.14-git3/drivers/media/dvb/dvb-core/dvb_frontend.c
@@ -577,6 +577,49 @@
 				fepriv->thread_pid);
 }
 
+s32 timeval_usec_diff(struct timeval lasttime, struct timeval curtime)
+{
+	return ((curtime.tv_usec < lasttime.tv_usec) ?
+		1000000 - lasttime.tv_usec + curtime.tv_usec :
+		curtime.tv_usec - lasttime.tv_usec);
+}
+EXPORT_SYMBOL(timeval_usec_diff);
+
+static inline void timeval_usec_add(struct timeval *curtime, u32 add_usec)
+{
+	curtime->tv_usec += add_usec;
+	if (curtime->tv_usec >= 1000000) {
+		curtime->tv_usec -= 1000000;
+		curtime->tv_sec++;
+	}
+}
+
+/*
+ * Sleep until gettimeofday() > waketime + add_usec
+ * This needs to be as precise as possible, but as the delay is
+ * usually between 2ms and 32ms, it is done using a scheduled msleep
+ * followed by usleep (normally a busy-wait loop) for the remainder
+ */
+void dvb_frontend_sleep_until(struct timeval *waketime, u32 add_usec)
+{
+	struct timeval lasttime;
+	s32 delta, newdelta;
+
+	timeval_usec_add(waketime, add_usec);
+
+	do_gettimeofday(&lasttime);
+	delta = timeval_usec_diff(lasttime, *waketime);
+	if (delta > 2500) {
+		msleep((delta - 1500) / 1000);
+		do_gettimeofday(&lasttime);
+		newdelta = timeval_usec_diff(lasttime, *waketime);
+		delta = (newdelta > delta) ? 0 : newdelta;
+	}
+	if (delta > 0)
+		udelay(delta);
+}
+EXPORT_SYMBOL(dvb_frontend_sleep_until);
+
 static int dvb_frontend_start(struct dvb_frontend *fe)
 {
 	int ret;
@@ -728,6 +771,60 @@
 			err = fe->ops->dishnetwork_send_legacy_command(fe, (unsigned int) parg);
 			fepriv->state = FESTATE_DISEQC;
 			fepriv->status = 0;
+		} else if (fe->ops->set_voltage) {
+			/*
+			 * NOTE: This is a fallback condition.  Some frontends
+			 * (stv0299 for instance) take longer than 8msec to
+			 * respond to a set_voltage command.  Those switches
+			 * need custom routines to switch properly.  For all
+			 * other frontends, the following shoule work ok.
+			 * Dish network legacy switches (as used by Dish500)
+			 * are controlled by sending 9-bit command words
+			 * spaced 8msec apart.
+			 * the actual command word is switch/port dependant
+			 * so it is up to the userspace application to send
+			 * the right command.
+			 * The command must always start with a '0' after
+			 * initialization, so parg is 8 bits and does not
+			 * include the initialization or start bit
+			 */
+			unsigned int cmd = ((unsigned int) parg) << 1;
+			struct timeval nexttime;
+			struct timeval tv[10];
+			int i;
+			u8 last = 1;
+			if (dvb_frontend_debug)
+				printk("%s switch command: 0x%04x\n", __FUNCTION__, cmd);
+			do_gettimeofday(&nexttime);
+			if (dvb_frontend_debug)
+				memcpy(&tv[0], &nexttime, sizeof(struct timeval));
+			/* before sending a command, initialize by sending
+			 * a 32ms 18V to the switch
+			 */
+			fe->ops->set_voltage(fe, SEC_VOLTAGE_18);
+			dvb_frontend_sleep_until(&nexttime, 32000);
+
+			for (i = 0; i < 9; i++) {
+				if (dvb_frontend_debug)
+					do_gettimeofday(&tv[i + 1]);
+				if ((cmd & 0x01) != last) {
+					/* set voltage to (last ? 13V : 18V) */
+					fe->ops->set_voltage(fe, (last) ? SEC_VOLTAGE_13 : SEC_VOLTAGE_18);
+					last = (last) ? 0 : 1;
+				}
+				cmd = cmd >> 1;
+				if (i != 8)
+					dvb_frontend_sleep_until(&nexttime, 8000);
+			}
+			if (dvb_frontend_debug) {
+				printk("%s(%d): switch delay (should be 32k followed by all 8k\n",
+					__FUNCTION__, fe->dvb->num);
+				for (i = 1; i < 10; i++)
+					printk("%d: %d\n", i, timeval_usec_diff(tv[i-1] , tv[i]));
+			}
+			err = 0;
+			fepriv->state = FESTATE_DISEQC;
+			fepriv->status = 0;
 		}
 		break;
 
--- linux-2.6.14-git3.orig/drivers/media/dvb/dvb-core/dvb_frontend.h
+++ linux-2.6.14-git3/drivers/media/dvb/dvb-core/dvb_frontend.h
@@ -101,4 +101,7 @@
 
 extern int dvb_unregister_frontend(struct dvb_frontend* fe);
 
+extern void dvb_frontend_sleep_until(struct timeval *waketime, u32 add_usec);
+extern s32 timeval_usec_diff(struct timeval lasttime, struct timeval curtime);
+
 #endif
--- linux-2.6.14-git3.orig/drivers/media/dvb/frontends/stv0299.c
+++ linux-2.6.14-git3/drivers/media/dvb/frontends/stv0299.c
@@ -387,36 +387,6 @@
 	};
 }
 
-static inline s32 stv0299_calc_usec_delay (struct timeval lasttime, struct timeval curtime)
-{
-	return ((curtime.tv_usec < lasttime.tv_usec) ?
-		1000000 - lasttime.tv_usec + curtime.tv_usec :
-		curtime.tv_usec - lasttime.tv_usec);
-}
-
-static void stv0299_sleep_until (struct timeval *waketime, u32 add_usec)
-{
-	struct timeval lasttime;
-	s32 delta, newdelta;
-
-	waketime->tv_usec += add_usec;
-	if (waketime->tv_usec >= 1000000) {
-		waketime->tv_usec -= 1000000;
-		waketime->tv_sec++;
-	}
-
-	do_gettimeofday (&lasttime);
-	delta = stv0299_calc_usec_delay (lasttime, *waketime);
-	if (delta > 2500) {
-		msleep ((delta - 1500) / 1000);
-		do_gettimeofday (&lasttime);
-		newdelta = stv0299_calc_usec_delay (lasttime, *waketime);
-		delta = (newdelta > delta) ? 0 : newdelta;
-	}
-	if (delta > 0)
-		udelay (delta);
-}
-
 static int stv0299_send_legacy_dish_cmd (struct dvb_frontend* fe, u32 cmd)
 {
 	struct stv0299_state* state = fe->demodulator_priv;
@@ -444,7 +414,7 @@
 		memcpy (&tv[0], &nexttime, sizeof (struct timeval));
 	stv0299_writeregI (state, 0x0c, reg0x0c | 0x50); /* set LNB to 18V */
 
-	stv0299_sleep_until (&nexttime, 32000);
+	dvb_frontend_sleep_until(&nexttime, 32000);
 
 	for (i=0; i<9; i++) {
 		if (debug_legacy_dish_switch)
@@ -458,13 +428,13 @@
 		cmd = cmd >> 1;
 
 		if (i != 8)
-			stv0299_sleep_until (&nexttime, 8000);
+			dvb_frontend_sleep_until(&nexttime, 8000);
 	}
 	if (debug_legacy_dish_switch) {
 		printk ("%s(%d): switch delay (should be 32k followed by all 8k\n",
 			__FUNCTION__, fe->dvb->num);
-		for (i=1; i < 10; i++)
-			printk ("%d: %d\n", i, stv0299_calc_usec_delay (tv[i-1] , tv[i]));
+		for (i = 1; i < 10; i++)
+			printk ("%d: %d\n", i, timeval_usec_diff(tv[i-1] , tv[i]));
 	}
 
 	return 0;


--------------030907040907070400060109--
