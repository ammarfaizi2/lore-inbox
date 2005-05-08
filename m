Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262960AbVEHTV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbVEHTV2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 15:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262969AbVEHTV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 15:21:27 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:60566 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262879AbVEHTJs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 15:09:48 -0400
Message-Id: <20050508184347.078268000@abc>
References: <20050508184229.957247000@abc>
Date: Sun, 08 May 2005 20:42:44 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-fe-stv0299-dishnw.patch
X-SA-Exim-Connect-IP: 217.231.45.168
Subject: [DVB patch 15/37] stv0299: fix FE_DISHNETWORK_SEND_LEGACY_CMD
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fix the current stv0299 code that handles FE_DISHNETWORK_SEND_LEGACY_CMD.
(supports the legacy SW21, SW44, and SW64 switches)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 drivers/media/dvb/frontends/stv0299.c |   78 ++++++++++++++++++++++++++++------
 1 files changed, 66 insertions(+), 12 deletions(-)

Index: linux-2.6.12-rc4/drivers/media/dvb/frontends/stv0299.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/frontends/stv0299.c	2005-05-08 15:55:38.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/frontends/stv0299.c	2005-05-08 16:20:39.000000000 +0200
@@ -70,6 +70,7 @@ struct stv0299_state {
 #define STATUS_UCBLOCKS 1
 
 static int debug;
+static int debug_legacy_dish_switch;
 #define dprintk(args...) \
 	do { \
 		if (debug) printk(KERN_DEBUG "stv0299: " args); \
@@ -385,34 +386,84 @@ static int stv0299_set_voltage (struct d
 	};
 }
 
-static int stv0299_send_legacy_dish_cmd(struct dvb_frontend* fe, u32 cmd)
+static inline s32 stv0299_calc_usec_delay (struct timeval lasttime, struct timeval curtime)
 {
+	return ((curtime.tv_usec < lasttime.tv_usec) ?
+		1000000 - lasttime.tv_usec + curtime.tv_usec :
+		curtime.tv_usec - lasttime.tv_usec);
+}
+
+static void stv0299_sleep_until (struct timeval *waketime, u32 add_usec)
+{
+	struct timeval lasttime;
+	s32 delta, newdelta;
+
+	waketime->tv_usec += add_usec;
+	if (waketime->tv_usec >= 1000000) {
+		waketime->tv_usec -= 1000000;
+		waketime->tv_sec++;
+	}
+
+	do_gettimeofday (&lasttime);
+	delta = stv0299_calc_usec_delay (lasttime, *waketime);
+	if (delta > 2500) {
+		msleep ((delta - 1500) / 1000);
+		do_gettimeofday (&lasttime);
+		newdelta = stv0299_calc_usec_delay (lasttime, *waketime);
+		delta = (newdelta > delta) ? 0 : newdelta;
+	}
+	if (delta > 0)
+		udelay (delta);
+}
+
+static int stv0299_send_legacy_dish_cmd (struct dvb_frontend* fe, u32 cmd)
+{
+	struct stv0299_state* state = fe->demodulator_priv;
+	u8 reg0x08;
+	u8 reg0x0c;
+	u8 lv_mask = 0x40;
 	u8 last = 1;
 	int i;
+	struct timeval nexttime;
+	struct timeval tv[10];
 
-	/* reset voltage at the end
-	if((0x50 & stv0299_readreg (i2c, 0x0c)) == 0x50)
-		cmd |= 0x80;
-	else
-		cmd &= 0x7F;
-	*/
+	reg0x08 = stv0299_readreg (state, 0x08);
+	reg0x0c = stv0299_readreg (state, 0x0c);
+	reg0x0c &= 0x0f;
+	stv0299_writeregI (state, 0x08, (reg0x08 & 0x3f) | (state->config->lock_output << 6));
+	if (state->config->volt13_op0_op1 == STV0299_VOLT13_OP0)
+		lv_mask = 0x10;
 
 	cmd = cmd << 1;
-	dprintk("%s switch command: 0x%04x\n",__FUNCTION__, cmd);
+	if (debug_legacy_dish_switch)
+		printk ("%s switch command: 0x%04x\n",__FUNCTION__, cmd);
+
+	do_gettimeofday (&nexttime);
+	if (debug_legacy_dish_switch)
+		memcpy (&tv[0], &nexttime, sizeof (struct timeval));
+	stv0299_writeregI (state, 0x0c, reg0x0c | 0x50); /* set LNB to 18V */
 
-	stv0299_set_voltage(fe,SEC_VOLTAGE_18);
-	msleep(32);
+	stv0299_sleep_until (&nexttime, 32000);
 
 	for (i=0; i<9; i++) {
+		if (debug_legacy_dish_switch)
+			do_gettimeofday (&tv[i+1]);
 		if((cmd & 0x01) != last) {
-			stv0299_set_voltage(fe, last ? SEC_VOLTAGE_13 : SEC_VOLTAGE_18);
+			/* set voltage to (last ? 13V : 18V) */
+			stv0299_writeregI (state, 0x0c, reg0x0c | (last ? lv_mask : 0x50));
 			last = (last) ? 0 : 1;
 		}
 
 		cmd = cmd >> 1;
 
 		if (i != 8)
-			msleep(8);
+			stv0299_sleep_until (&nexttime, 8000);
+	}
+	if (debug_legacy_dish_switch) {
+		printk ("%s(%d): switch delay (should be 32k followed by all 8k\n",
+			__FUNCTION__, fe->dvb->num);
+		for (i=1; i < 10; i++)
+			printk ("%d: %d\n", i, stv0299_calc_usec_delay (tv[i-1] , tv[i]));
 	}
 
 	return 0;
@@ -719,6 +770,9 @@ static struct dvb_frontend_ops stv0299_o
 	.dishnetwork_send_legacy_command = stv0299_send_legacy_dish_cmd,
 };
 
+module_param(debug_legacy_dish_switch, int, 0444);
+MODULE_PARM_DESC(debug_legacy_dish_switch, "Enable timing analysis for Dish Network legacy switches");
+
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Turn on/off frontend debugging (default:off).");
 

--

