Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbVCFKcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVCFKcA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 05:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVCFKcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 05:32:00 -0500
Received: from coderock.org ([193.77.147.115]:50344 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261357AbVCFKb5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 05:31:57 -0500
Subject: [patch 1/6] cdrom/sonycd535: replace schedule_timeout() with msleep()
To: emoenke@gwdg.de
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com
From: domen@coderock.org
Date: Sun, 06 Mar 2005 11:31:51 +0100
Message-Id: <20050306103152.15B771E46E@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Use msleep() instead of schedule_timeout() to guarantee the task
delays as expected. Although TASK_INTERRUPTIBLE is used in the original code,
the schedule_timeout() return conditions for such a state are not checked
appropriately; therefore, TASK_UNINTERRUPTIBLE should be ok (and, hence,
msleep()).

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/cdrom/sonycd535.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff -puN drivers/cdrom/sonycd535.c~msleep-drivers_cdrom_sonycd535 drivers/cdrom/sonycd535.c
--- kj/drivers/cdrom/sonycd535.c~msleep-drivers_cdrom_sonycd535	2005-03-05 16:10:47.000000000 +0100
+++ kj-domen/drivers/cdrom/sonycd535.c	2005-03-05 16:10:47.000000000 +0100
@@ -129,6 +129,7 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 
 #define REALLY_SLOW_IO
 #include <asm/system.h>
@@ -896,9 +897,8 @@ do_cdu535_request(request_queue_t * q)
 					}
 					if (readStatus == BAD_STATUS) {
 						/* Sleep for a while, then retry */
-						set_current_state(TASK_INTERRUPTIBLE);
 						spin_unlock_irq(&sonycd535_lock);
-						schedule_timeout(RETRY_FOR_BAD_STATUS*HZ/10);
+						msleep(RETRY_FOR_BAD_STATUS*100);
 						spin_lock_irq(&sonycd535_lock);
 					}
 #if DEBUG > 0
@@ -1478,8 +1478,7 @@ static int __init sony535_init(void)
 	/* look for the CD-ROM, follows the procedure in the DOS driver */
 	inb(select_unit_reg);
 	/* wait for 40 18 Hz ticks (reverse-engineered from DOS driver) */
-	set_current_state(TASK_INTERRUPTIBLE);
-	schedule_timeout((HZ+17)*40/18);
+	msleep(2222);
 	inb(result_reg);
 
 	outb(0, read_status_reg);	/* does a reset? */
_
