Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbVCEW7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVCEW7K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 17:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbVCEW42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 17:56:28 -0500
Received: from coderock.org ([193.77.147.115]:54181 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261291AbVCEWn3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 17:43:29 -0500
Subject: [patch 09/15] 10/34: block/xd: remove sleep_on() usage
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com
From: domen@coderock.org
Date: Sat, 05 Mar 2005 23:43:09 +0100
Message-Id: <20050305224310.4D4CE1EE1E@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Directly use wait-queues instead of the deprecated sleep_on().
This required adding a local waitqueue. Patch is compile-tested.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/block/xd.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

diff -puN drivers/block/xd.c~sleep_on-drivers_block_xd drivers/block/xd.c
--- kj/drivers/block/xd.c~sleep_on-drivers_block_xd	2005-03-05 16:11:45.000000000 +0100
+++ kj-domen/drivers/block/xd.c	2005-03-05 16:11:45.000000000 +0100
@@ -538,6 +538,7 @@ static inline u_char xd_waitport (u_shor
 
 static inline u_int xd_wait_for_IRQ (void)
 {
+	DEFINE_WAIT(wait);
 	unsigned long flags;
 	xd_watchdog_int.expires = jiffies + 8 * HZ;
 	add_timer(&xd_watchdog_int);
@@ -546,7 +547,9 @@ static inline u_int xd_wait_for_IRQ (voi
 	enable_dma(xd_dma);
 	release_dma_lock(flags);
 	
-	sleep_on(&xd_wait_int);
+	prepare_to_wait(&xd_wait_int, &wait, TASK_UNINTERRUPTIBLE);
+	schedule();
+	finish_wait(&xd_wait_int, &wait);
 	del_timer(&xd_watchdog_int);
 	xdc_busy = 0;
 	
_
