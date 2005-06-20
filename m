Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbVFTWqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbVFTWqW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 18:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVFTWnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 18:43:22 -0400
Received: from coderock.org ([193.77.147.115]:28827 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262290AbVFTWFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:05:37 -0400
Message-Id: <20050620215719.436045000@nd47.coderock.org>
Date: Mon, 20 Jun 2005 23:57:19 +0200
From: domen@coderock.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       domen@coderock.org
Subject: [patch 1/4] serial/68360serial: replace schedule_timeout() with msleep_interruptible()
Content-Disposition: inline; filename=msleep-drivers_serial_68360serial.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nishanth Aravamudan <nacc@us.ibm.com>



Use msleep_interruptible() instead of schedule_timeout() in
send_break() to guarantee the task delays as expected. Change
@duration's units to milliseconds, and modify arguments in callers
appropriately.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 68360serial.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

Index: quilt/drivers/serial/68360serial.c
===================================================================
--- quilt.orig/drivers/serial/68360serial.c
+++ quilt/drivers/serial/68360serial.c
@@ -1394,14 +1394,13 @@ static void end_break(ser_info_t *info)
 /*
  * This routine sends a break character out the serial port.
  */
-static void send_break(ser_info_t *info, int duration)
+static void send_break(ser_info_t *info, unsigned int duration)
 {
-	set_current_state(TASK_INTERRUPTIBLE);
 #ifdef SERIAL_DEBUG_SEND_BREAK
 	printk("rs_send_break(%d) jiff=%lu...", duration, jiffies);
 #endif
 	begin_break(info);
-	schedule_timeout(duration);
+	msleep_interruptible(duration);
 	end_break(info);
 #ifdef SERIAL_DEBUG_SEND_BREAK
 	printk("done jiffies=%lu\n", jiffies);
@@ -1436,7 +1435,7 @@ static int rs_360_ioctl(struct tty_struc
 			if (signal_pending(current))
 				return -EINTR;
 			if (!arg) {
-				send_break(info, HZ/4);	/* 1/4 second */
+				send_break(info, 250);	/* 1/4 second */
 				if (signal_pending(current))
 					return -EINTR;
 			}
@@ -1448,7 +1447,7 @@ static int rs_360_ioctl(struct tty_struc
 			tty_wait_until_sent(tty, 0);
 			if (signal_pending(current))
 				return -EINTR;
-			send_break(info, arg ? arg*(HZ/10) : HZ/4);
+			send_break(info, arg ? arg*100 : 250);
 			if (signal_pending(current))
 				return -EINTR;
 			return 0;

--
