Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262369AbVG2J4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbVG2J4R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 05:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262557AbVG2JrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 05:47:17 -0400
Received: from tim.rpsys.net ([194.106.48.114]:63935 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S262555AbVG2Jq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 05:46:58 -0400
Subject: [patch 4/8] Corgi Touchscreen: Allow the driver to share the PMU
From: Richard Purdie <rpurdie@rpsys.net>
To: akpm@osdl.org
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 29 Jul 2005 10:46:46 +0100
Message-Id: <1122630406.7747.92.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Corgi Touchscreen driver uses the PMU as an accurate timing source
which conflicts with its usage for performance monitoring. This patch
allows it to be shared with other users such as oprofile.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.12/drivers/input/touchscreen/corgi_ts.c
===================================================================
--- linux-2.6.12.orig/drivers/input/touchscreen/corgi_ts.c	2005-07-28 15:21:39.000000000 +0100
+++ linux-2.6.12/drivers/input/touchscreen/corgi_ts.c	2005-07-28 16:20:38.000000000 +0100
@@ -53,8 +53,8 @@
 
 #define SyncHS()	while((STATUS_HSYNC) == 0); while((STATUS_HSYNC) != 0);
 #define CCNT(a)		asm volatile ("mrc p14, 0, %0, C1, C0, 0" : "=r"(a))
-#define CCNT_ON()	{int pmnc = 1; asm volatile ("mcr p14, 0, %0, C0, C0, 0" : : "r"(pmnc));}
-#define CCNT_OFF()	{int pmnc = 0; asm volatile ("mcr p14, 0, %0, C0, C0, 0" : : "r"(pmnc));}
+#define PMNC_GET(x)	asm volatile ("mrc p14, 0, %0, C0, C0, 0" : "=r"(x))
+#define PMNC_SET(x)	asm volatile ("mcr p14, 0, %0, C0, C0, 0" : : "r"(x))
 
 #define WAIT_HS_400_VGA		7013U	// 17.615us
 #define WAIT_HS_400_QVGA	16622U	// 41.750us
@@ -96,14 +96,17 @@
 
 static int sync_receive_data_send_cmd(int doRecive, int doSend, unsigned int address, unsigned long wait_time)
 {
+	unsigned long timer1 = 0, timer2, pmnc = 0;
 	int pos = 0;
-	unsigned long timer1 = 0, timer2;
 	int dosleep;
 
 	dosleep = !w100fb_get_blanking();
 
 	if (dosleep && doSend) {
-		CCNT_ON();
+		PMNC_GET(pmnc);
+		if (!(pmnc & 0x01))
+			PMNC_SET(pmnc | 0x01);
+
 		/* polling HSync */
 		SyncHS();
 		/* get CCNT */
@@ -134,8 +137,8 @@
 				CCNT(timer2);
 		}
 		corgi_ssp_ads7846_put(cmd);
-		if (dosleep)
-			CCNT_OFF();
+		if (dosleep && !(pmnc & 0x01))
+			PMNC_SET(pmnc);
 	}
 	return pos;
 }


