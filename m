Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267994AbUIAVEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267994AbUIAVEQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 17:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267833AbUIAVCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 17:02:44 -0400
Received: from baikonur.stro.at ([213.239.196.228]:50580 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267992AbUIAU5X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:57:23 -0400
Subject: [patch 19/25]  dsp56k: replace schedule_timeout() with 	msleep()
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Wed, 01 Sep 2004 22:57:22 +0200
Message-ID: <E1C2cAV-0007Sl-33@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org







I would appreciate any comments from the janitor@sternweltens list. This is one (of
many) cases where I made a decision about replacing

set_current_state(TASK_INTERRUPTIBLE);
schedule_timeout(some_time);

with

msleep(jiffies_to_msecs(some_time));

msleep() is not exactly the same as the previous code, but I only did
this replacement where I thought long delays were *desired*. If this is
not the case here, then just disregard this patch.

Note: I looked for the appropriate maintainer of this driver, but I did
not find anyone. If someone could tell me who that would be, I would
appreciate it.

Thanks,
Nish



Description: Uses msleep() instead of schedule_timeout() to guarantee
the task delays at least the desired time amount.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/drivers/char/dsp56k.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff -puN drivers/char/dsp56k.c~msleep-drivers_char_dsp56k drivers/char/dsp56k.c
--- linux-2.6.9-rc1-bk7/drivers/char/dsp56k.c~msleep-drivers_char_dsp56k	2004-09-01 19:34:43.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/char/dsp56k.c	2004-09-01 19:34:43.000000000 +0200
@@ -58,12 +58,6 @@
 #define DSP56K_TRANSMIT		(dsp56k_host_interface.isr & DSP56K_ISR_TXDE)
 #define DSP56K_RECEIVE		(dsp56k_host_interface.isr & DSP56K_ISR_RXDF)
 
-#define wait_some(n) \
-{ \
-	set_current_state(TASK_INTERRUPTIBLE); \
-	schedule_timeout(n); \
-}
-
 #define handshake(count, maxio, timeout, ENABLE, f) \
 { \
 	long i, t, m; \
@@ -71,13 +65,13 @@
 		m = min_t(unsigned long, count, maxio); \
 		for (i = 0; i < m; i++) { \
 			for (t = 0; t < timeout && !ENABLE; t++) \
-				wait_some(HZ/50); \
+				msleep(20); \
 			if(!ENABLE) \
 				return -EIO; \
 			f; \
 		} \
 		count -= m; \
-		if (m == maxio) wait_some(HZ/50); \
+		if (m == maxio) msleep(20); \
 	} \
 }
 
@@ -85,7 +79,7 @@
 { \
 	int t; \
 	for(t = 0; t < n && !DSP56K_TRANSMIT; t++) \
-		wait_some(HZ/100); \
+		msleep(10); \
 	if(!DSP56K_TRANSMIT) { \
 		return -EIO; \
 	} \
@@ -95,7 +89,7 @@
 { \
 	int t; \
 	for(t = 0; t < n && !DSP56K_RECEIVE; t++) \
-		wait_some(HZ/100); \
+		msleep(10); \
 	if(!DSP56K_RECEIVE) { \
 		return -EIO; \
 	} \

_
