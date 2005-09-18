Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbVIRPFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbVIRPFr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 11:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbVIRPFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 11:05:47 -0400
Received: from mx1.rowland.org ([192.131.102.7]:21777 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S932099AbVIRPFr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 11:05:47 -0400
Date: Sun, 18 Sep 2005 11:05:43 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: Rusty Russell <rusty@rustcorp.com.au>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Unusually long delay in the kernel
In-Reply-To: <20050917164117.1eee31c2.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44L0.0509181057570.27009-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Sep 2005, Andrew Morton wrote:

> > > That code could be converted to the kthread API btw.
> > 
> > Hmph.  Near as I can tell, the only changes that would involve are:
> > 
> > 	Converting the thread creation call from kernel_thread to
> > 	kthread_run.
> > 
> > 	Adding another call to wake the thread up once it has been
> > 	created.
> > 
> > 	Removing the call to daemonize.
> > 
> > There wouldn't be any need to call kthread_stop -- and in fact it wouldn't 
> > work, as the thread waits on a semaphore while it is idle (kthread_stop 
> > can't cope with things like that).
> 
> Well I was assuming that the semaphore would go away as well.  Kernel
> threads normally use waitqueues to await more work.

Some kernel threads have a producer-consumer relationship with their
clients, and it's important that they wake exactly once each time they are
invoked.  A semaphore is the natural way to manage such a thread, but the
kthread API isn't set up to handle such things.  It's possible to make
this work, by using a manual poor-man's semaphore implementation, but that
seems ridiculous.

Would this patch be acceptable?

Alan Stern



Enhance the kthread API so that it can be used with threads that wait on a 
semaphore when they are idle.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

--- a/include/linux/kthread.h	Mon Sep 12 23:12:09 2005
+++ b/include/linux/kthread.h	Sat Sep 17 23:24:59 2005
@@ -67,7 +67,19 @@
  *
  * Returns the result of threadfn(), or -EINTR if wake_up_process()
  * was never called. */
-int kthread_stop(struct task_struct *k);
+#define kthread_stop(k)		kthread_stop_sem(k, NULL)
+
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
+int kthread_stop_sem(struct task_struct *k, struct semaphore *s);
 
 /**
  * kthread_should_stop: should this kthread return now?
--- a/kernel/kthread.c	Mon Sep 12 23:12:09 2005
+++ b/kernel/kthread.c	Sat Sep 17 23:19:08 2005
@@ -163,7 +163,7 @@
 }
 EXPORT_SYMBOL(kthread_bind);
 
-int kthread_stop(struct task_struct *k)
+int kthread_stop_sem(struct task_struct *k, struct semaphore *s)
 {
 	int ret;
 
@@ -178,7 +178,10 @@
 
 	/* Now set kthread_should_stop() to true, and wake it up. */
 	kthread_stop_info.k = k;
-	wake_up_process(k);
+	if (s)
+		up(s);
+	else
+		wake_up_process(k);
 	put_task_struct(k);
 
 	/* Once it dies, reset stop ptr, gather result and we're done. */
@@ -189,7 +192,7 @@
 
 	return ret;
 }
-EXPORT_SYMBOL(kthread_stop);
+EXPORT_SYMBOL(kthread_stop_sem);
 
 static __init int helper_init(void)
 {

