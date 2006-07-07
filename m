Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbWGGUpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWGGUpm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 16:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWGGUpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 16:45:42 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:16656 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751248AbWGGUpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 16:45:41 -0400
Date: Fri, 7 Jul 2006 22:45:41 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] remove kernel/kthread.c:kthread_stop_sem()
Message-ID: <20060707204541.GD26941@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves the otherwise unused kthread_stop_sem() into 
kthread_stop().

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 29 Jun 2006

 include/linux/kthread.h |   12 ------------
 kernel/kthread.c        |   14 ++------------
 2 files changed, 2 insertions(+), 24 deletions(-)

--- linux-2.6.17-mm4-full/include/linux/kthread.h.old	2006-06-29 19:07:40.000000000 +0200
+++ linux-2.6.17-mm4-full/include/linux/kthread.h	2006-06-29 19:07:49.000000000 +0200
@@ -28,7 +28,6 @@
 
 void kthread_bind(struct task_struct *k, unsigned int cpu);
 int kthread_stop(struct task_struct *k);
-int kthread_stop_sem(struct task_struct *k, struct semaphore *s);
 int kthread_should_stop(void);
 
 #endif /* _LINUX_KTHREAD_H */
--- linux-2.6.17-mm4-full/kernel/kthread.c.old	2006-06-29 19:08:00.000000000 +0200
+++ linux-2.6.17-mm4-full/kernel/kthread.c	2006-06-29 19:08:22.000000000 +0200
@@ -216,23 +216,6 @@
  */
 int kthread_stop(struct task_struct *k)
 {
-	return kthread_stop_sem(k, NULL);
-}
-EXPORT_SYMBOL(kthread_stop);
-
-/**
- * kthread_stop_sem - stop a thread created by kthread_create().
- * @k: thread created by kthread_create().
- * @s: semaphore that @k waits on while idle.
- *
- * Does essentially the same thing as kthread_stop() above, but wakes
- * @k by calling up(@s).
- *
- * Returns the result of threadfn(), or %-EINTR if wake_up_process()
- * was never called.
- */
-int kthread_stop_sem(struct task_struct *k, struct semaphore *s)
-{
 	int ret;
 
 	mutex_lock(&kthread_stop_lock);
@@ -246,10 +229,7 @@
 
 	/* Now set kthread_should_stop() to true, and wake it up. */
 	kthread_stop_info.k = k;
-	if (s)
-		up(s);
-	else
-		wake_up_process(k);
+	wake_up_process(k);
 	put_task_struct(k);
 
 	/* Once it dies, reset stop ptr, gather result and we're done. */
@@ -260,7 +240,7 @@
 
 	return ret;
 }
-EXPORT_SYMBOL(kthread_stop_sem);
+EXPORT_SYMBOL(kthread_stop);
 
 static __init int helper_init(void)
 {
