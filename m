Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266560AbUIWUmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266560AbUIWUmR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 16:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266555AbUIWUlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:41:53 -0400
Received: from baikonur.stro.at ([213.239.196.228]:57225 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266560AbUIWUZA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:25:00 -0400
Subject: [patch 02/26]  char/cyclades: replace 	schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:24:58 +0200
Message-ID: <E1CAa9D-0007mL-31@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated. 

Description: Use msleep_interruptible() instead of schedule_timeout()
to guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/char/cyclades.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff -puN drivers/char/cyclades.c~msleep_interruptible-drivers_char_cyclades drivers/char/cyclades.c
--- linux-2.6.9-rc2-bk7/drivers/char/cyclades.c~msleep_interruptible-drivers_char_cyclades	2004-09-21 21:07:58.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/char/cyclades.c	2004-09-21 21:07:58.000000000 +0200
@@ -2717,8 +2717,7 @@ cy_wait_until_sent(struct tty_struct *tt
 #ifdef CY_DEBUG_WAIT_UNTIL_SENT
 	    printk("Not clean (jiff=%lu)...", jiffies);
 #endif
-	    current->state = TASK_INTERRUPTIBLE;
-	    schedule_timeout(char_time);
+	    msleep_interruptible(msecs_to_jiffies(char_time));
 	    if (signal_pending(current))
 		break;
 	    if (timeout && time_after(jiffies, orig_jiffies + timeout))
@@ -2729,8 +2728,7 @@ cy_wait_until_sent(struct tty_struct *tt
 	// Nothing to do!
     }
     /* Run one more char cycle */
-    current->state = TASK_INTERRUPTIBLE;
-    schedule_timeout(char_time * 5);
+    msleep_interruptible(jiffies_to_msecs(char_time * 5));
 #ifdef CY_DEBUG_WAIT_UNTIL_SENT
     printk("Clean (jiff=%lu)...done\n", jiffies);
 #endif
@@ -2860,8 +2858,7 @@ cy_close(struct tty_struct *tty, struct 
     if (info->blocked_open) {
 	CY_UNLOCK(info, flags);
         if (info->close_delay) {
-            current->state = TASK_INTERRUPTIBLE;
-            schedule_timeout(info->close_delay);
+            msleep_interruptible(jiffies_to_msecs(info->close_delay));
         }
         wake_up_interruptible(&info->open_wait);
 	CY_LOCK(info, flags);
_
