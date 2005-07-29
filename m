Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbVG2J6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbVG2J6c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 05:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262552AbVG2J4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 05:56:41 -0400
Received: from tim.rpsys.net ([194.106.48.114]:1472 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S262560AbVG2JrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 05:47:08 -0400
Subject: [patch 5/8] Corgi Touchscreen: Code cleanup / fixes
From: Richard Purdie <rpurdie@rpsys.net>
To: akpm@osdl.org
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 29 Jul 2005 10:46:51 +0100
Message-Id: <1122630411.7747.94.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up some Corgi Touchscreen logic and merge the repeat calls to 
w100fb_blanking() in anticipation of the w100fb patch.

Fix a pm_message_t reference.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.12/drivers/input/touchscreen/corgi_ts.c
===================================================================
--- linux-2.6.12.orig/drivers/input/touchscreen/corgi_ts.c	2005-07-28 16:20:38.000000000 +0100
+++ linux-2.6.12/drivers/input/touchscreen/corgi_ts.c	2005-07-28 16:21:17.000000000 +0100
@@ -79,6 +79,9 @@
 	int w100fb_xres = w100fb_get_xres();
 	unsigned int waittime = 0;
 
+	if (w100fb_get_blanking())
+		return 0;
+
 	if (w100fb_xres == 480 || w100fb_xres == 640) {
 		waittime = WAIT_HS_400_VGA * get_clk_frequency_khz(0) / 398131U;
 
@@ -98,11 +101,8 @@
 {
 	unsigned long timer1 = 0, timer2, pmnc = 0;
 	int pos = 0;
-	int dosleep;
-
-	dosleep = !w100fb_get_blanking();
 
-	if (dosleep && doSend) {
+	if (wait_time && doSend) {
 		PMNC_GET(pmnc);
 		if (!(pmnc & 0x01))
 			PMNC_SET(pmnc | 0x01);
@@ -122,11 +122,11 @@
 		corgi_ssp_ads7846_put(cmd);
 		corgi_ssp_ads7846_get();
 
-		if (dosleep) {
+		if (wait_time) {
 			/* Wait after HSync */
 			CCNT(timer2);
 			if (timer2-timer1 > wait_time) {
-				/* timeout */
+				/* too slow - timeout, try again */
 				SyncHS();
 				/* get OSCR */
 				CCNT(timer1);
@@ -137,7 +137,7 @@
 				CCNT(timer2);
 		}
 		corgi_ssp_ads7846_put(cmd);
-		if (dosleep && !(pmnc & 0x01))
+		if (wait_time && !(pmnc & 0x01))
 			PMNC_SET(pmnc);
 	}
 	return pos;
@@ -247,7 +247,7 @@
 }
 
 #ifdef CONFIG_PM
-static int corgits_suspend(struct device *dev, uint32_t state, uint32_t level)
+static int corgits_suspend(struct device *dev, pm_message_t state, uint32_t level)
 {
 	if (level == SUSPEND_POWER_DOWN) {
 		struct corgi_ts *corgi_ts = dev_get_drvdata(dev);


