Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262208AbVEMAuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbVEMAuL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 20:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbVEMAsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 20:48:07 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:37899 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262200AbVEMArS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 20:47:18 -0400
Date: Fri, 13 May 2005 02:47:16 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] kernel/sched.c: remove two unused functions
Message-ID: <20050513004716.GR3603@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the unused functions wait_for_completion_timeout and 
wait_for_completion_interruptible_timeout.

Is any usage for them planned or is this patch OK?

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 7 May 2005

 include/linux/completion.h |    4 --
 kernel/sched.c             |   66 -------------------------------------
 2 files changed, 70 deletions(-)

--- linux-2.6.12-rc3-mm2-full/include/linux/completion.h.old	2005-05-03 07:52:14.000000000 +0200
+++ linux-2.6.12-rc3-mm2-full/include/linux/completion.h	2005-05-03 07:52:32.000000000 +0200
@@ -29,10 +29,6 @@
 
 extern void FASTCALL(wait_for_completion(struct completion *));
 extern int FASTCALL(wait_for_completion_interruptible(struct completion *x));
-extern unsigned long FASTCALL(wait_for_completion_timeout(struct completion *x,
-						   unsigned long timeout));
-extern unsigned long FASTCALL(wait_for_completion_interruptible_timeout(
-			struct completion *x, unsigned long timeout));
 
 extern void FASTCALL(complete(struct completion *));
 extern void FASTCALL(complete_all(struct completion *));
--- linux-2.6.12-rc3-mm2-full/kernel/sched.c.old	2005-05-03 07:52:42.000000000 +0200
+++ linux-2.6.12-rc3-mm2-full/kernel/sched.c	2005-05-03 07:53:03.000000000 +0200
@@ -3146,36 +3146,6 @@
 }
 EXPORT_SYMBOL(wait_for_completion);
 
-unsigned long fastcall __sched
-wait_for_completion_timeout(struct completion *x, unsigned long timeout)
-{
-	might_sleep();
-
-	spin_lock_irq(&x->wait.lock);
-	if (!x->done) {
-		DECLARE_WAITQUEUE(wait, current);
-
-		wait.flags |= WQ_FLAG_EXCLUSIVE;
-		__add_wait_queue_tail(&x->wait, &wait);
-		do {
-			__set_current_state(TASK_UNINTERRUPTIBLE);
-			spin_unlock_irq(&x->wait.lock);
-			timeout = schedule_timeout(timeout);
-			spin_lock_irq(&x->wait.lock);
-			if (!timeout) {
-				__remove_wait_queue(&x->wait, &wait);
-				goto out;
-			}
-		} while (!x->done);
-		__remove_wait_queue(&x->wait, &wait);
-	}
-	x->done--;
-out:
-	spin_unlock_irq(&x->wait.lock);
-	return timeout;
-}
-EXPORT_SYMBOL(wait_for_completion_timeout);
-
 int fastcall __sched wait_for_completion_interruptible(struct completion *x)
 {
 	int ret = 0;
@@ -3209,42 +3179,6 @@
 }
 EXPORT_SYMBOL(wait_for_completion_interruptible);
 
-unsigned long fastcall __sched
-wait_for_completion_interruptible_timeout(struct completion *x,
-					  unsigned long timeout)
-{
-	might_sleep();
-
-	spin_lock_irq(&x->wait.lock);
-	if (!x->done) {
-		DECLARE_WAITQUEUE(wait, current);
-
-		wait.flags |= WQ_FLAG_EXCLUSIVE;
-		__add_wait_queue_tail(&x->wait, &wait);
-		do {
-			if (signal_pending(current)) {
-				timeout = -ERESTARTSYS;
-				__remove_wait_queue(&x->wait, &wait);
-				goto out;
-			}
-			__set_current_state(TASK_INTERRUPTIBLE);
-			spin_unlock_irq(&x->wait.lock);
-			timeout = schedule_timeout(timeout);
-			spin_lock_irq(&x->wait.lock);
-			if (!timeout) {
-				__remove_wait_queue(&x->wait, &wait);
-				goto out;
-			}
-		} while (!x->done);
-		__remove_wait_queue(&x->wait, &wait);
-	}
-	x->done--;
-out:
-	spin_unlock_irq(&x->wait.lock);
-	return timeout;
-}
-EXPORT_SYMBOL(wait_for_completion_interruptible_timeout);
-
 
 #define	SLEEP_ON_VAR					\
 	unsigned long flags;				\

