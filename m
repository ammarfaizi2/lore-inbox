Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266867AbUIXDSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266867AbUIXDSx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 23:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266876AbUIWUeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:34:17 -0400
Received: from baikonur.stro.at ([213.239.196.228]:56532 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266871AbUIWUZ5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:25:57 -0400
Subject: [patch 23/26]  char/synclink_cs: replace 	schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:25:58 +0200
Message-ID: <E1CAaAA-0000MS-N9@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep_interruptible() instead of schedule_timeout() to
guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/char/pcmcia/synclink_cs.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff -puN drivers/char/pcmcia/synclink_cs.c~msleep_interruptible-drivers_char_synclink_cs drivers/char/pcmcia/synclink_cs.c
--- linux-2.6.9-rc2-bk7/drivers/char/pcmcia/synclink_cs.c~msleep_interruptible-drivers_char_synclink_cs	2004-09-21 21:08:24.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/char/pcmcia/synclink_cs.c	2004-09-21 21:08:24.000000000 +0200
@@ -2584,8 +2584,7 @@ static void mgslpc_close(struct tty_stru
 	
 	if (info->blocked_open) {
 		if (info->close_delay) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(info->close_delay);
+			msleep_interruptible(jiffies_to_msecs(info->close_delay));
 		}
 		wake_up_interruptible(&info->open_wait);
 	}
@@ -2640,8 +2639,7 @@ static void mgslpc_wait_until_sent(struc
 		
 	if (info->params.mode == MGSL_MODE_HDLC) {
 		while (info->tx_active) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(char_time);
+			msleep_interruptible(jiffies_to_msecs(char_time));
 			if (signal_pending(current))
 				break;
 			if (timeout && time_after(jiffies, orig_jiffies + timeout))
@@ -2650,8 +2648,7 @@ static void mgslpc_wait_until_sent(struc
 	} else {
 		while ((info->tx_count || info->tx_active) &&
 			info->tx_enabled) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(char_time);
+			msleep_interruptible(jiffies_to_msecs(char_time));
 			if (signal_pending(current))
 				break;
 			if (timeout && time_after(jiffies, orig_jiffies + timeout))
@@ -4108,8 +4105,7 @@ BOOLEAN irq_test(MGSLPC_INFO *info)
 
 	end_time=100;
 	while(end_time-- && !info->irq_occurred) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(msecs_to_jiffies(10));
+		msleep_interruptible(10);
 	}
 	
 	info->testing_irq = FALSE;
_
