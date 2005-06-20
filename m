Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbVFUGXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVFUGXh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 02:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVFUGXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 02:23:11 -0400
Received: from coderock.org ([193.77.147.115]:4505 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261724AbVFTVyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:54:40 -0400
Message-Id: <20050620215133.675387000@nd47.coderock.org>
Date: Mon, 20 Jun 2005 23:51:34 +0200
From: domen@coderock.org
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       domen@coderock.org
Subject: [patch 04/12] block/xd: replace schedule_timeout() with msleep()
Content-Disposition: inline; filename=msleep-drivers_block_xd2.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nishanth Aravamudan <nacc@us.ibm.com>



Use msleep() instead of schedule_timeout() to guarantee the task
delays as expected. The current code wishes to sleep for 1 jiffy, but I am not
sure if this is actually intended, as with the change to HZ=1000, the time
equivalent of 1 jiffy changed from 10ms to 1ms. I have assumed the former in
this case; however the patch can be easily changed to assume the latter.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 xd.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

Index: quilt/drivers/block/xd.c
===================================================================
--- quilt.orig/drivers/block/xd.c
+++ quilt/drivers/block/xd.c
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

--
