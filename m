Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267450AbUIXDSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267450AbUIXDSx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 23:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266871AbUIWUem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:34:42 -0400
Received: from baikonur.stro.at ([213.239.196.228]:17889 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266867AbUIWUZz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:25:55 -0400
Subject: [patch 22/26]  char/synclink: replace 	schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:25:55 +0200
Message-ID: <E1CAaA7-0000Jp-VB@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep_interruptible() instead of schedule_timeout() to
guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/char/synclink.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff -puN drivers/char/synclink.c~msleep_interruptible-drivers_char_synclink drivers/char/synclink.c
--- linux-2.6.9-rc2-bk7/drivers/char/synclink.c~msleep_interruptible-drivers_char_synclink	2004-09-21 21:08:23.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/char/synclink.c	2004-09-21 21:08:23.000000000 +0200
@@ -82,6 +82,7 @@
 #include <linux/ioport.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/delay.h>
 
 #include <linux/netdevice.h>
 
@@ -3246,8 +3247,7 @@ static void mgsl_close(struct tty_struct
 	
 	if (info->blocked_open) {
 		if (info->close_delay) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(info->close_delay);
+			msleep_interruptible(jiffies_to_msecs(info->close_delay));
 		}
 		wake_up_interruptible(&info->open_wait);
 	}
@@ -3313,8 +3313,7 @@ static void mgsl_wait_until_sent(struct 
 	if ( info->params.mode == MGSL_MODE_HDLC ||
 		info->params.mode == MGSL_MODE_RAW ) {
 		while (info->tx_active) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(char_time);
+			msleep_interruptible(jiffies_to_msecs(char_time));
 			if (signal_pending(current))
 				break;
 			if (timeout && time_after(jiffies, orig_jiffies + timeout))
@@ -3323,8 +3322,7 @@ static void mgsl_wait_until_sent(struct 
 	} else {
 		while (!(usc_InReg(info,TCSR) & TXSTATUS_ALL_SENT) &&
 			info->tx_enabled) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(char_time);
+			msleep_interruptible(jiffies_to_msecs(char_time));
 			if (signal_pending(current))
 				break;
 			if (timeout && time_after(jiffies, orig_jiffies + timeout))
@@ -7193,8 +7191,7 @@ BOOLEAN mgsl_irq_test( struct mgsl_struc
 
 	EndTime=100;
 	while( EndTime-- && !info->irq_occurred ) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(msecs_to_jiffies(10));
+		msleep_interruptible(10);
 	}
 	
 	spin_lock_irqsave(&info->irq_spinlock,flags);
_
