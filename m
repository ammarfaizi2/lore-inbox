Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbUJ3Wt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbUJ3Wt6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 18:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUJ3WtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 18:49:11 -0400
Received: from baikonur.stro.at ([213.239.196.228]:36758 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261392AbUJ3Wr2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 18:47:28 -0400
Subject: [patch 7/8]  serial/serial_core: replace 	schedule_timeout() with msleep()/msleep_interruptible()
To: rmk+lkml@arm.linux.org.uk
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, janitor@sternwelten.at,
       nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Sun, 31 Oct 2004 00:47:19 +0200
Message-ID: <E1CO20F-0003EA-LZ@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep()/msleep_interruptible() [as appropriate]
instead of schedule_timeout() to guarantee the task delays
as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.10-rc1-max/drivers/serial/serial_core.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff -puN drivers/serial/serial_core.c~msleep+msleep_interruptible-drivers_serial_serial_core drivers/serial/serial_core.c
--- linux-2.6.10-rc1/drivers/serial/serial_core.c~msleep+msleep_interruptible-drivers_serial_serial_core	2004-10-24 17:05:36.000000000 +0200
+++ linux-2.6.10-rc1-max/drivers/serial/serial_core.c	2004-10-24 17:05:36.000000000 +0200
@@ -32,6 +32,7 @@
 #include <linux/smp_lock.h>
 #include <linux/device.h>
 #include <linux/serial.h> /* for serial_state and serial_icounter_struct */
+#include <linux/delay.h>
 
 #include <asm/irq.h>
 #include <asm/uaccess.h>
@@ -1272,8 +1273,7 @@ static void uart_close(struct tty_struct
 
 	if (state->info->blocked_open) {
 		if (state->close_delay) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(state->close_delay);
+			msleep_interruptible(jiffies_to_msecs(state->close_delay));
 		}
 	} else if (!uart_console(port)) {
 		uart_change_pm(state, 3);
@@ -1338,8 +1338,7 @@ static void uart_wait_until_sent(struct 
 	 * we wait.
 	 */
 	while (!port->ops->tx_empty(port)) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(char_time);
+		msleep_interruptible(jiffies_to_msecs(char_time));
 		if (signal_pending(current))
 			break;
 		if (time_after(jiffies, expire))
@@ -1896,10 +1895,8 @@ int uart_suspend_port(struct uart_driver
 		 * Wait for the transmitter to empty.
 		 */
 		while (!ops->tx_empty(port)) {
-			set_current_state(TASK_UNINTERRUPTIBLE);
-			schedule_timeout(10*HZ/1000);
+			msleep(10);
 		}
-		set_current_state(TASK_RUNNING);
 
 		ops->shutdown(port);
 	}
_
