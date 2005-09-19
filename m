Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbVISOkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbVISOkb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 10:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbVISOkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 10:40:31 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:42917 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932439AbVISOka
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 10:40:30 -0400
Date: Mon, 19 Sep 2005 10:40:27 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: rusty@rustcorp.com.au, <linux-kernel@vger.kernel.org>
Subject: [Proposed PATCH] Add kthread_stop_sem
In-Reply-To: <20050918130902.23a824e0.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44L0.0509191033470.5306-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Sep 2005, Andrew Morton wrote:

> >  Would this patch be acceptable?
> 
> Well it makes all kthread_stop() callers pass an additional (unused)
> argument.  I'd make kthread_stop() and kthread_stop_sem() real C functions,
> hide the code sharing within kthread.c.

This may not be needed anywhere, since James Bottomley has said that the
SCSI error handler thread doesn't need a strict one-invocation <->
one-iteration relation.  I'll post it anyway just in case someone thinks
it may come in handy later.  At the moment the new routine has no callers.

Alan Stern



Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

Enlarge the kthread API by adding kthread_stop_sem, for use in stopping 
threads that spend their idle time waiting on a semaphore.

Index: usb-2.6/include/linux/kthread.h
===================================================================
--- usb-2.6.orig/include/linux/kthread.h
+++ usb-2.6/include/linux/kthread.h
@@ -70,6 +70,18 @@ void kthread_bind(struct task_struct *k,
 int kthread_stop(struct task_struct *k);
 
 /**
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
+
+/**
  * kthread_should_stop: should this kthread return now?
  *
  * When someone calls kthread_stop on your kthread, it will be woken
Index: usb-2.6/kernel/kthread.c
===================================================================
--- usb-2.6.orig/kernel/kthread.c
+++ usb-2.6/kernel/kthread.c
@@ -165,6 +165,12 @@ EXPORT_SYMBOL(kthread_bind);
 
 int kthread_stop(struct task_struct *k)
 {
+	return kthread_stop_sem(k, NULL);
+}
+EXPORT_SYMBOL(kthread_stop);
+
+int kthread_stop_sem(struct task_struct *k, struct semaphore *s)
+{
 	int ret;
 
 	down(&kthread_stop_lock);
@@ -178,7 +184,10 @@ int kthread_stop(struct task_struct *k)
 
 	/* Now set kthread_should_stop() to true, and wake it up. */
 	kthread_stop_info.k = k;
-	wake_up_process(k);
+	if (s)
+		up(s);
+	else
+		wake_up_process(k);
 	put_task_struct(k);
 
 	/* Once it dies, reset stop ptr, gather result and we're done. */
@@ -189,7 +198,7 @@ int kthread_stop(struct task_struct *k)
 
 	return ret;
 }
-EXPORT_SYMBOL(kthread_stop);
+EXPORT_SYMBOL(kthread_stop_sem);
 
 static __init int helper_init(void)
 {

