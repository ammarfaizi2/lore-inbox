Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266741AbUIXCJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266741AbUIXCJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 22:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266578AbUIWUkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:40:43 -0400
Received: from baikonur.stro.at ([213.239.196.228]:32150 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266705AbUIWUZN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:25:13 -0400
Subject: [patch 07/26]  char/generic_serial: 	replace schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:25:12 +0200
Message-ID: <E1CAa9R-00080U-6o@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated. 

Description: Use msleep_interruptible() instead of schedule_timeout() to
guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/char/generic_serial.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff -puN drivers/char/generic_serial.c~msleep_interruptible-drivers_char_generic_serial drivers/char/generic_serial.c
--- linux-2.6.9-rc2-bk7/drivers/char/generic_serial.c~msleep_interruptible-drivers_char_generic_serial	2004-09-21 21:08:06.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/char/generic_serial.c	2004-09-21 21:08:06.000000000 +0200
@@ -26,6 +26,7 @@
 #include <linux/mm.h>
 #include <linux/generic_serial.h>
 #include <linux/interrupt.h>
+#include <linux/delay.h>
 #include <asm/semaphore.h>
 #include <asm/uaccess.h>
 
@@ -399,8 +400,7 @@ static int gs_wait_tx_flushed (void * pt
 		gs_dprintk (GS_DEBUG_FLUSH, "Expect to finish in %d jiffies "
 			    "(%d chars).\n", jiffies_to_transmit, charsleft); 
 
-		set_current_state (TASK_INTERRUPTIBLE);
-		schedule_timeout(jiffies_to_transmit);
+		msleep_interruptible(jiffies_to_msecs(jiffies_to_transmit));
 		if (signal_pending (current)) {
 			gs_dprintk (GS_DEBUG_FLUSH, "Signal pending. Bombing out: "); 
 			rv = -EINTR;
@@ -771,8 +771,7 @@ void gs_close(struct tty_struct * tty, s
 
 	if (port->blocked_open) {
 		if (port->close_delay) {
-			set_current_state (TASK_INTERRUPTIBLE);
-			schedule_timeout(port->close_delay);
+			msleep_interruptible(jiffies_to_msecs(port->close_delay));
 		}
 		wake_up_interruptible(&port->open_wait);
 	}
_
