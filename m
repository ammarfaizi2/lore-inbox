Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUJ3XJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUJ3XJf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 19:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbUJ3WuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 18:50:08 -0400
Received: from baikonur.stro.at ([213.239.196.228]:37002 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261387AbUJ3WrW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 18:47:22 -0400
Subject: [patch 5/8]  serial/68360serial: replace 	schedule_timeout() with msleep_interruptible()
To: rmk+lkml@arm.linux.org.uk
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, janitor@sternwelten.at,
       nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Sun, 31 Oct 2004 00:47:12 +0200
Message-ID: <E1CO209-00037f-0u@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep_interruptible() instead of
schedule_timeout() to guarantee the task delays as expected.
Use set_current_state() instead of direct assignment of current->state.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.10-rc1-max/drivers/serial/68360serial.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff -puN drivers/serial/68360serial.c~msleep_interruptible-drivers_serial_68360serial drivers/serial/68360serial.c
--- linux-2.6.10-rc1/drivers/serial/68360serial.c~msleep_interruptible-drivers_serial_68360serial	2004-10-24 17:05:28.000000000 +0200
+++ linux-2.6.10-rc1-max/drivers/serial/68360serial.c	2004-10-24 17:05:28.000000000 +0200
@@ -1396,7 +1396,7 @@ static void end_break(ser_info_t *info)
  */
 static void send_break(ser_info_t *info, int duration)
 {
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 #ifdef SERIAL_DEBUG_SEND_BREAK
 	printk("rs_send_break(%d) jiff=%lu...", duration, jiffies);
 #endif
@@ -1707,8 +1707,7 @@ static void rs_360_close(struct tty_stru
 	info->tty = 0;
 	if (info->blocked_open) {
 		if (info->close_delay) {
-			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(info->close_delay);
+			msleep_interruptible(jiffies_to_msecs(info->close_delay));
 		}
 		wake_up_interruptible(&info->open_wait);
 	}
@@ -1761,9 +1760,8 @@ static void rs_360_wait_until_sent(struc
 #ifdef SERIAL_DEBUG_RS_WAIT_UNTIL_SENT
 		printk("lsr = %d (jiff=%lu)...", lsr, jiffies);
 #endif
-		current->state = TASK_INTERRUPTIBLE;
 /*		current->counter = 0;	 make us low-priority */
-		schedule_timeout(char_time);
+		msleep_interruptible(jiffies_to_msecs(char_time));
 		if (signal_pending(current))
 			break;
 		if (timeout && ((orig_jiffies + timeout) < jiffies))
_
