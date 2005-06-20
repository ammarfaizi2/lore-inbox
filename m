Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261748AbVFUGHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbVFUGHi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 02:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbVFUGH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 02:07:29 -0400
Received: from coderock.org ([193.77.147.115]:19097 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261743AbVFTVz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:55:29 -0400
Message-Id: <20050620215147.225013000@nd47.coderock.org>
Date: Mon, 20 Jun 2005 23:51:47 +0200
From: domen@coderock.org
To: emoenke@gwdg.de
Cc: linux-kernel@vger.kernel.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       domen@coderock.org
Subject: [patch 1/4] cdrom/sonycd535: replace schedule_timeout() with msleep()
Content-Disposition: inline; filename=msleep-drivers_cdrom_sonycd535.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nishanth Aravamudan <nacc@us.ibm.com>



Use msleep() instead of schedule_timeout() to guarantee the task
delays as expected. Although TASK_INTERRUPTIBLE is used in the original code,
the schedule_timeout() return conditions for such a state are not checked
appropriately; therefore, TASK_UNINTERRUPTIBLE should be ok (and, hence,
msleep()).

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 sonycd535.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

Index: quilt/drivers/cdrom/sonycd535.c
===================================================================
--- quilt.orig/drivers/cdrom/sonycd535.c
+++ quilt/drivers/cdrom/sonycd535.c
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

--
