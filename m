Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbVCEWs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbVCEWs6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 17:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVCEWs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 17:48:26 -0500
Received: from coderock.org ([193.77.147.115]:50853 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261312AbVCEWnO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 17:43:14 -0500
Subject: [patch 06/15] block/xd: replace schedule_timeout() with msleep()
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com
From: domen@coderock.org
Date: Sat, 05 Mar 2005 23:42:59 +0100
Message-Id: <20050305224259.E16941F203@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Use msleep() instead of schedule_timeout() to guarantee the task
delays as expected. The current code wishes to sleep for 1 jiffy, but I am not
sure if this is actually intended, as with the change to HZ=1000, the time
equivalent of 1 jiffy changed from 10ms to 1ms. I have assumed the former in
this case; however the patch can be easily changed to assume the latter.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/block/xd.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff -puN drivers/block/xd.c~msleep-drivers_block_xd2 drivers/block/xd.c
--- kj/drivers/block/xd.c~msleep-drivers_block_xd2	2005-03-05 16:10:47.000000000 +0100
+++ kj-domen/drivers/block/xd.c	2005-03-05 16:10:47.000000000 +0100
@@ -47,6 +47,7 @@
 #include <linux/wait.h>
 #include <linux/blkdev.h>
 #include <linux/blkpg.h>
+#include <linux/delay.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
@@ -529,10 +530,8 @@ static inline u_char xd_waitport (u_shor
 	int success;
 
 	xdc_busy = 1;
-	while ((success = ((inb(port) & mask) != flags)) && time_before(jiffies, expiry)) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(1);
-	}
+	while ((success = ((inb(port) & mask) != flags)) && time_before(jiffies, expiry))
+		msleep(10);
 	xdc_busy = 0;
 	return (success);
 }
_
