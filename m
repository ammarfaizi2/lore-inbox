Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266903AbUIXDfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266903AbUIXDfL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 23:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266196AbUIWUd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:33:59 -0400
Received: from baikonur.stro.at ([213.239.196.228]:39845 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266876AbUIWU0A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:26:00 -0400
Subject: [patch 24/26]  char/synclinkmp: replace 	schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:26:01 +0200
Message-ID: <E1CAaAD-0000P5-FU@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep_interruptible() instead of schedule_timeout() to
guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/char/synclinkmp.c |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

diff -puN drivers/char/synclinkmp.c~msleep_interruptible-drivers_char_synclinkmp drivers/char/synclinkmp.c
--- linux-2.6.9-rc2-bk7/drivers/char/synclinkmp.c~msleep_interruptible-drivers_char_synclinkmp	2004-09-21 21:08:25.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/char/synclinkmp.c	2004-09-21 21:08:25.000000000 +0200
@@ -856,8 +856,7 @@ static void close(struct tty_struct *tty
 
 	if (info->blocked_open) {
 		if (info->close_delay) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(info->close_delay);
+			msleep_interruptible(jiffies_to_msecs(info->close_delay));
 		}
 		wake_up_interruptible(&info->open_wait);
 	}
@@ -1142,8 +1141,7 @@ static void wait_until_sent(struct tty_s
 
 	if ( info->params.mode == MGSL_MODE_HDLC ) {
 		while (info->tx_active) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(char_time);
+			msleep_interruptible(jiffies_to_msecs(char_time));
 			if (signal_pending(current))
 				break;
 			if (timeout && time_after(jiffies, orig_jiffies + timeout))
@@ -1153,8 +1151,7 @@ static void wait_until_sent(struct tty_s
 		//TODO: determine if there is something similar to USC16C32
 		// 	TXSTATUS_ALL_SENT status
 		while ( info->tx_active && info->tx_enabled) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(char_time);
+			msleep_interruptible(jiffies_to_msecs(char_time));
 			if (signal_pending(current))
 				break;
 			if (timeout && time_after(jiffies, orig_jiffies + timeout))
@@ -5202,8 +5199,7 @@ int irq_test(SLMP_INFO *info)
 
 	timeout=100;
 	while( timeout-- && !info->irq_occurred ) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(msecs_to_jiffies(10));
+		msleep_interruptible(10);
 	}
 
 	spin_lock_irqsave(&info->lock,flags);
@@ -5353,8 +5349,7 @@ int loopback_test(SLMP_INFO *info)
 	/* wait for receive complete */
 	/* Set a timeout for waiting for interrupt. */
 	for ( timeout = 100; timeout; --timeout ) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(msecs_to_jiffies(10));
+		msleep_interruptible(10);
 
 		if (rx_get_frame(info)) {
 			rc = TRUE;
_
