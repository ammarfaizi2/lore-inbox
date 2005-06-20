Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262049AbVFUGmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbVFUGmN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 02:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbVFUGVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 02:21:09 -0400
Received: from coderock.org ([193.77.147.115]:8345 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261729AbVFTVyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:54:51 -0400
Message-Id: <20050620215136.112146000@nd47.coderock.org>
Date: Mon, 20 Jun 2005 23:51:37 +0200
From: domen@coderock.org
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       domen@coderock.org
Subject: [patch 07/12] block/xd: remove sleep_on() usage
Content-Disposition: inline; filename=sleep_on-drivers_block_xd.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nishanth Aravamudan <nacc@us.ibm.com>



Directly use wait-queues instead of the deprecated sleep_on().
This required adding a local waitqueue. Patch is compile-tested.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 xd.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

Index: quilt/drivers/block/xd.c
===================================================================
--- quilt.orig/drivers/block/xd.c
+++ quilt/drivers/block/xd.c
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
 	

--
