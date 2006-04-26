Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbWDZMbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbWDZMbN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 08:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbWDZMbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 08:31:13 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:48901 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932416AbWDZMbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 08:31:13 -0400
Date: Wed, 26 Apr 2006 14:31:12 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] kernel/kthread.c: possible cleanups
Message-ID: <20060426123111.GA1528@stusta.de>
References: <20060423114022.GJ5010@stusta.de> <200604231537.55205.ioe-lkml@rameria.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604231537.55205.ioe-lkml@rameria.de>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 23, 2006 at 03:37:40PM +0200, Ingo Oeser wrote:
> Hi Adrian,
> 
> On Sunday, 23. April 2006 13:40, Adrian Bunk wrote:
> > This patch makes the needlessly global kthread_stop_sem() static.
> 
> Could you cleanup the code paths as well?
> 
> Now s is always NULL in kthread_stop_sem() and
> kthread_stop_sem() is degenerated to kthread_stop().
> So it can be folded into the latter.

Sounds reasonable, updated patch below.

> Regards
> 
> Ingo Oeser

cu
Adrian


<--  snip  -->


This patch contains the following possible cleanups:
- fold the otherwise unused kthread_stop_sem() into kthread_stop()
- remove the unused EXPORT_SYMBOL(kthread_bind)

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/kthread.h |   12 ------------
 kernel/kthread.c        |   14 ++------------
 2 files changed, 2 insertions(+), 24 deletions(-)

--- linux-2.6.17-rc1-mm3-full/include/linux/kthread.h.old	2006-04-26 12:46:06.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/include/linux/kthread.h	2006-04-26 12:46:33.000000000 +0200
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
--- linux-2.6.17-rc1-mm3-full/kernel/kthread.c.old	2006-04-26 12:46:16.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/kernel/kthread.c	2006-04-26 12:47:34.000000000 +0200
@@ -164,16 +164,9 @@
 	set_task_cpu(k, cpu);
 	k->cpus_allowed = cpumask_of_cpu(cpu);
 }
-EXPORT_SYMBOL(kthread_bind);
 
 int kthread_stop(struct task_struct *k)
 {
-	return kthread_stop_sem(k, NULL);
-}
-EXPORT_SYMBOL(kthread_stop);
-
-int kthread_stop_sem(struct task_struct *k, struct semaphore *s)
-{
 	int ret;
 
 	mutex_lock(&kthread_stop_lock);
@@ -187,10 +180,7 @@
 
 	/* Now set kthread_should_stop() to true, and wake it up. */
 	kthread_stop_info.k = k;
-	if (s)
-		up(s);
-	else
-		wake_up_process(k);
+	wake_up_process(k);
 	put_task_struct(k);
 
 	/* Once it dies, reset stop ptr, gather result and we're done. */
@@ -201,7 +191,7 @@
 
 	return ret;
 }
-EXPORT_SYMBOL(kthread_stop_sem);
+EXPORT_SYMBOL(kthread_stop);
 
 static __init int helper_init(void)
 {

