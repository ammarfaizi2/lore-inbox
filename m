Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbUJ3XBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbUJ3XBV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 19:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbUJ3Wuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 18:50:40 -0400
Received: from baikonur.stro.at ([213.239.196.228]:53947 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261384AbUJ3WrS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 18:47:18 -0400
Subject: [patch 4/8]  serial/68328serial: replace 	schedule_timeout() with msleep_interruptible()
To: rmk+lkml@arm.linux.org.uk
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, janitor@sternwelten.at,
       nacc@us.ibm.com, davidm@snapgear.com
From: janitor@sternwelten.at
Date: Sun, 31 Oct 2004 00:47:09 +0200
Message-ID: <E1CO205-00034I-LO@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep_interruptible() instead of
schedule_timeout() to guarantee the task delays as expected.
The patch also uses set_current_state() instead of direct 
assignment of current->state.

Acked-by: David McCullough <davidm@snapgear.com>

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.10-rc1-max/drivers/serial/68328serial.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN drivers/serial/68328serial.c~msleep_interruptible-drivers_serial_68328serial drivers/serial/68328serial.c
--- linux-2.6.10-rc1/drivers/serial/68328serial.c~msleep_interruptible-drivers_serial_68328serial	2004-10-24 17:05:28.000000000 +0200
+++ linux-2.6.10-rc1-max/drivers/serial/68328serial.c	2004-10-24 17:05:28.000000000 +0200
@@ -35,6 +35,7 @@
 #include <linux/init.h>
 #include <linux/pm.h>
 #include <linux/bitops.h>
+#include <linux/delay.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -997,7 +998,7 @@ static void send_break(	struct m68k_seri
         unsigned long flags;
         if (!info->port)
                 return;
-        current->state = TASK_INTERRUPTIBLE;
+        set_current_state(TASK_INTERRUPTIBLE);
         save_flags(flags);
         cli();
 #ifdef USE_INTS	
@@ -1189,8 +1190,7 @@ static void rs_close(struct tty_struct *
 #endif	
 	if (info->blocked_open) {
 		if (info->close_delay) {
-			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(info->close_delay);
+			msleep_interruptible(jiffies_to_msecs(info->close_delay));
 		}
 		wake_up_interruptible(&info->open_wait);
 	}
_
