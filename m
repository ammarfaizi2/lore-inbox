Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964965AbVHIVFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbVHIVFK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 17:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbVHIVFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 17:05:10 -0400
Received: from verein.lst.de ([213.95.11.210]:12966 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S964965AbVHIVFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 17:05:09 -0400
Date: Tue, 9 Aug 2005 23:04:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: neilb@cse.unsw.edu.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] use kthread infrastructure in md
Message-ID: <20050809210446.GA29308@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Switch MD to use the kthread infrastructure, to simplify the code and
get rid of tasklist_lock abuse in md_unregister_thread.  Long-term I
wonder whether workqueues wouldn't be a better choice than the
MD-specific thread wrappers for the lowlevel drivers.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/drivers/md/md.c
===================================================================
--- linux-2.6.orig/drivers/md/md.c	2005-08-09 19:28:16.000000000 +0200
+++ linux-2.6/drivers/md/md.c	2005-08-09 20:17:21.000000000 +0200
@@ -34,6 +34,7 @@
 
 #include <linux/module.h>
 #include <linux/config.h>
+#include <linux/kthread.h>
 #include <linux/linkage.h>
 #include <linux/raid/md.h>
 #include <linux/raid/bitmap.h>
@@ -2947,18 +2948,6 @@
 {
 	mdk_thread_t *thread = arg;
 
-	lock_kernel();
-
-	/*
-	 * Detach thread
-	 */
-
-	daemonize(thread->name, mdname(thread->mddev));
-
-	current->exit_signal = SIGCHLD;
-	allow_signal(SIGKILL);
-	thread->tsk = current;
-
 	/*
 	 * md_thread is a 'system-thread', it's priority should be very
 	 * high. We avoid resource deadlocks individually in each
@@ -2970,10 +2959,9 @@
 	 * bdflush, otherwise bdflush will deadlock if there are too
 	 * many dirty RAID5 blocks.
 	 */
-	unlock_kernel();
 
 	complete(thread->event);
-	while (thread->run) {
+	while (!kthread_should_stop()) {
 		void (*run)(mddev_t *);
 
 		wait_event_interruptible_timeout(thread->wqueue,
@@ -2986,11 +2974,8 @@
 		run = thread->run;
 		if (run)
 			run(thread->mddev);
-
-		if (signal_pending(current))
-			flush_signals(current);
 	}
-	complete(thread->event);
+
 	return 0;
 }
 
@@ -3007,11 +2992,9 @@
 				 const char *name)
 {
 	mdk_thread_t *thread;
-	int ret;
 	struct completion event;
 
-	thread = (mdk_thread_t *) kmalloc
-				(sizeof(mdk_thread_t), GFP_KERNEL);
+	thread = kmalloc(sizeof(mdk_thread_t), GFP_KERNEL);
 	if (!thread)
 		return NULL;
 
@@ -3024,8 +3007,8 @@
 	thread->mddev = mddev;
 	thread->name = name;
 	thread->timeout = MAX_SCHEDULE_TIMEOUT;
-	ret = kernel_thread(md_thread, thread, 0);
-	if (ret < 0) {
+	thread->tsk = kthread_run(md_thread, thread, mdname(thread->mddev));
+	if (IS_ERR(thread->tsk)) {
 		kfree(thread);
 		return NULL;
 	}
@@ -3035,21 +3018,9 @@
 
 void md_unregister_thread(mdk_thread_t *thread)
 {
-	struct completion event;
-
-	init_completion(&event);
-
-	thread->event = &event;
-
-	/* As soon as ->run is set to NULL, the task could disappear,
-	 * so we need to hold tasklist_lock until we have sent the signal
-	 */
 	dprintk("interrupting MD-thread pid %d\n", thread->tsk->pid);
-	read_lock(&tasklist_lock);
-	thread->run = NULL;
-	send_sig(SIGKILL, thread->tsk, 1);
-	read_unlock(&tasklist_lock);
-	wait_for_completion(&event);
+
+	kthread_stop(thread->tsk);
 	kfree(thread);
 }
 
