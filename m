Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965293AbWGJWgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965293AbWGJWgf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965294AbWGJWge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:36:34 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:27595
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S965290AbWGJWgd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:36:33 -0400
From: Michael Buesch <mb@bu3sch.de>
To: akpm@osdl.org
Subject: [PATCH] cancel_rearming_delayed_work infinite loop fix
Date: Tue, 11 Jul 2006 00:36:30 +0200
User-Agent: KMail/1.9.1
Cc: Jiri Benc <jbenc@suse.cz>, netdev@vger.kernel.org,
       bcm43xx-dev@lists.berlios.de, linville@tuxdriver.com,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200607110036.31574.mb@bu3sch.de>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cancel_rearming_delayed_work{queue} is broken, because it is
possible to enter an infinite loop if:
We call the function on a work that is currently not executing or pending.

But, as this is a synchronization function and as its only purpose
is to synchronize the work, that should not loop infinite.

This patch rewrites the function.
It now first cancels the work, but throws the retval of that function
away, because it is meaningless in this context. (The retval is 1,
if the work was pending and 0, if not)
After that we flush the queue to make sure any work function returns.
Now, if it was indeed running, it rescheduled itself. That is caught
by the test_bit(). If it rescheduled itself, we have the schedule-delay
time to cancel the work again (without it rescheduling itself again).
So we redo the loop. Most likely it will succeed on the
second loop iteration at least.

Signed-off-by: Michael Buesch <mb@bu3sch.de>

Index: wireless-dev-dscapeports/kernel/workqueue.c
===================================================================
--- wireless-dev-dscapeports.orig/kernel/workqueue.c	2006-06-13 14:44:16.000000000 +0200
+++ wireless-dev-dscapeports/kernel/workqueue.c	2006-07-11 00:19:06.000000000 +0200
@@ -461,8 +461,10 @@
 void cancel_rearming_delayed_workqueue(struct workqueue_struct *wq,
 				       struct work_struct *work)
 {
-	while (!cancel_delayed_work(work))
+	do {
+		cancel_delayed_work(work);
 		flush_workqueue(wq);
+	} while (test_bit(0, &work->pending));
 }
 EXPORT_SYMBOL(cancel_rearming_delayed_workqueue);

-- 
Greetings Michael.
