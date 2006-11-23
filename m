Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933817AbWKWPmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933817AbWKWPmS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 10:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933810AbWKWPmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 10:42:18 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:42887 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S933817AbWKWPmR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 10:42:17 -0500
Date: Thu, 23 Nov 2006 18:42:17 +0300
From: Vitaly Wool <vitalywool@gmail.com>
To: drzeus-mmc@drzeus.cx
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix "prev->state: 2 != TASK_RUNNING??" problem on SD/MMC
 card removal
Message-Id: <20061123184217.a971d267.vitalywool@gmail.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.13; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pierre,

currently on SD/MMC card removal the system exhibits the following message (the platform is ARM Versatile):

    prev->state: 2 != TASK_RUNNING??
    mmcqd/762[CPU#0]: BUG in __schedule at linux-2.6/kernel/sched.c:3826

The patch inlined below fixes this problem.

 drivers/mmc/mmc_queue.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Signed-off-by: Vitaly Wool <vitalywool@gmail.com>

Index: linux-2.6.18/drivers/mmc/mmc_queue.c
===================================================================
--- linux-2.6.18.orig/drivers/mmc/mmc_queue.c
+++ linux-2.6.18/drivers/mmc/mmc_queue.c
@@ -84,8 +84,10 @@ static int mmc_queue_thread(void *d)
 		spin_unlock_irq(q->queue_lock);
 
 		if (!req) {
-			if (mq->flags & MMC_QUEUE_EXIT)
+			if (mq->flags & MMC_QUEUE_EXIT) {
+				set_current_state(TASK_RUNNING);
 				break;
+			}
 			up(&mq->thread_sem);
 			schedule();
 			down(&mq->thread_sem);
