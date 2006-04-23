Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbWDWLkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWDWLkZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 07:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWDWLkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 07:40:24 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:62475 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751381AbWDWLkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 07:40:24 -0400
Date: Sun, 23 Apr 2006 13:40:23 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] kernel/kthread.c: make kthread_stop_sem() static
Message-ID: <20060423114022.GJ5010@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global kthread_stop_sem() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/kthread.h |   12 ------------
 kernel/kthread.c        |   26 +++++++++++++++++---------
 2 files changed, 17 insertions(+), 21 deletions(-)

--- linux-2.6.17-rc1-mm3-full/include/linux/kthread.h.old	2006-04-23 01:32:40.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/include/linux/kthread.h	2006-04-23 01:33:20.000000000 +0200
@@ -70,18 +70,6 @@
 int kthread_stop(struct task_struct *k);
 
 /**
- * kthread_stop_sem: stop a thread created by kthread_create().
- * @k: thread created by kthread_create().
- * @s: semaphore that @k waits on while idle.
- *
- * Does essentially the same thing as kthread_stop() above, but wakes
- * @k by calling up(@s).
- *
- * Returns the result of threadfn(), or -EINTR if wake_up_process()
- * was never called. */
-int kthread_stop_sem(struct task_struct *k, struct semaphore *s);
-
-/**
  * kthread_should_stop: should this kthread return now?
  *
  * When someone calls kthread_stop on your kthread, it will be woken
--- linux-2.6.17-rc1-mm3-full/kernel/kthread.c.old	2006-04-23 01:30:48.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/kernel/kthread.c	2006-04-23 01:33:11.000000000 +0200
@@ -164,15 +164,18 @@
 	set_task_cpu(k, cpu);
 	k->cpus_allowed = cpumask_of_cpu(cpu);
 }
-EXPORT_SYMBOL(kthread_bind);
 
-int kthread_stop(struct task_struct *k)
-{
-	return kthread_stop_sem(k, NULL);
-}
-EXPORT_SYMBOL(kthread_stop);
-
-int kthread_stop_sem(struct task_struct *k, struct semaphore *s)
+/**
+ * kthread_stop_sem: stop a thread created by kthread_create().
+ * @k: thread created by kthread_create().
+ * @s: semaphore that @k waits on while idle.
+ *
+ * Does essentially the same thing as kthread_stop() above, but wakes
+ * @k by calling up(@s).
+ *
+ * Returns the result of threadfn(), or -EINTR if wake_up_process()
+ * was never called. */
+static int kthread_stop_sem(struct task_struct *k, struct semaphore *s)
 {
 	int ret;
 
@@ -201,7 +204,12 @@
 
 	return ret;
 }
-EXPORT_SYMBOL(kthread_stop_sem);
+
+int kthread_stop(struct task_struct *k)
+{
+	return kthread_stop_sem(k, NULL);
+}
+EXPORT_SYMBOL(kthread_stop);
 
 static __init int helper_init(void)
 {

