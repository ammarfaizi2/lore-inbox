Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbUJ3Wt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbUJ3Wt6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 18:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbUJ3Wtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 18:49:33 -0400
Received: from baikonur.stro.at ([213.239.196.228]:654 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S261389AbUJ3WrZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 18:47:25 -0400
Subject: [patch 6/8]  serial/mcfserial: replace 	schedule_timeout() with msleep_interruptible()
To: rmk+lkml@arm.linux.org.uk
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, janitor@sternwelten.at,
       nacc@us.ibm.com, gerg@snapgear.com
From: janitor@sternwelten.at
Date: Sun, 31 Oct 2004 00:47:16 +0200
Message-ID: <E1CO20C-0003BB-Co@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep_interruptible() instead of schedule_timeout() to
guarantee the task delays as expected. Use set_current_state() instead
of direct assignment of current->state.

Acked-by: Greg Ungerer <gerg@snapgear.com>

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.10-rc1-max/drivers/serial/mcfserial.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff -puN drivers/serial/mcfserial.c~msleep_interruptible-drivers_serial_mcfserial drivers/serial/mcfserial.c
--- linux-2.6.10-rc1/drivers/serial/mcfserial.c~msleep_interruptible-drivers_serial_mcfserial	2004-10-24 17:05:29.000000000 +0200
+++ linux-2.6.10-rc1-max/drivers/serial/mcfserial.c	2004-10-24 17:05:29.000000000 +0200
@@ -35,6 +35,7 @@
 #include <linux/console.h>
 #include <linux/init.h>
 #include <linux/bitops.h>
+#include <linux/delay.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -978,7 +979,7 @@ static void send_break(	struct mcf_seria
 
 	if (!info->addr)
 		return;
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 	uartp = info->addr;
 
 	local_irq_save(flags);
@@ -1230,8 +1231,7 @@ static void mcfrs_close(struct tty_struc
 #endif	
 	if (info->blocked_open) {
 		if (info->close_delay) {
-			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(info->close_delay);
+			msleep_interruptible(jiffies_to_msecs(info->close_delay));
 		}
 		wake_up_interruptible(&info->open_wait);
 	}
@@ -1296,8 +1296,7 @@ mcfrs_wait_until_sent(struct tty_struct 
 			fifo_cnt++;
 		if (fifo_cnt == 0)
 			break;
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(char_time);
+		msleep_interruptible(jiffies_to_msecs(char_time));
 		if (signal_pending(current))
 			break;
 		if (timeout && time_after(jiffies, orig_jiffies + timeout))
_
