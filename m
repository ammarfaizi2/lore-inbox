Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264879AbTFWBfK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 21:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264884AbTFWBfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 21:35:09 -0400
Received: from dp.samba.org ([66.70.73.150]:61929 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264879AbTFWBew (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 21:34:52 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: torvalds@transmeta.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, mingo@redhat.com
Subject: Re: [PATCH] workqueue.c subtle fix and core extraction 
In-reply-to: Your message of "Sat, 21 Jun 2003 11:43:08 -0400."
             <3EF47D0C.100@pobox.com> 
Date: Sun, 22 Jun 2003 14:52:53 +1000
Message-Id: <20030623014858.A4C0B2C105@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3EF47D0C.100@pobox.com> you write:
> Linux Kernel Mailing List wrote:
> > ChangeSet 1.1384, 2003/06/20 22:14:56-07:00, akpm@digeo.com
> > 
> > 	[PATCH] workqueue.c subtle fix and core extraction
> > 	
> > 	From: Rusty Russell <rusty@rustcorp.com.au>
> > 	
> > 	A barrier is needed on workqueue shutdown: there's a chance that the thead
> > 	could see the wq->thread set to NULL before the completion is initialized.
> 
> Look at the larger problem.
> 
> The completion initialization should be done before you call 
> kernel_thread to start the worker.
> 
> Otherwise, there is a still the general problem:  if any event occurs to 
> cause worker_thread to exit its main loop, you hit an uninitialized 
> completion.

Agreed.  While I don't believe that can ever happen, your suggested
fix is *much* cleaner.  Below.

> Please do this in separate patches next time.  I'm looking into the 
> above change, and including this second change just obfuscated matters 
> and slowed down analysis of the first change.

Guilty of laziness as changed.  Follows on as a separate patch below.

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Workqueue Exit Completion Race Fix
Author: Rusty Russell
Status: Trivial

D: Initializing the exit-completion at exit time without a barrier leaves 
D: a potential race: it is much cleaner to do it at thread creation time
D: when everything else is initialized (the workqueue can only be destroyed
D: once, so it is only used once).
D: 
D: Initial barrier implementation rightly trashed by Jeff Garzik.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.72-bk3/kernel/workqueue.c working-2.5.72-bk3-workqueue/kernel/workqueue.c
--- linux-2.5.72-bk3/kernel/workqueue.c	2003-04-20 18:05:16.000000000 +1000
+++ working-2.5.72-bk3-workqueue/kernel/workqueue.c	2003-06-22 13:57:42.000000000 +1000
@@ -286,6 +286,7 @@ struct workqueue_struct *create_workqueu
 		INIT_LIST_HEAD(&cwq->worklist);
 		init_waitqueue_head(&cwq->more_work);
 		init_waitqueue_head(&cwq->work_done);
+		init_completion(&cwq->exit);
 
 		init_completion(&startup.done);
 		startup.cwq = cwq;
@@ -321,10 +322,7 @@ void destroy_workqueue(struct workqueue_
 		cwq = wq->cpu_wq + cpu;
 		if (!cwq->thread)
 			continue;
-		/*
-		 * Initiate an exit and wait for it:
-		 */
-		init_completion(&cwq->exit);
+		/* Tell thread to exit and and wait for it: */
 		cwq->thread = NULL;
 		wake_up(&cwq->more_work);
 

Name: workqueue.c Neatening
Author: Rusty Russell
Status: Tested on 2.5.70-bk16
Depends: Misc/workqueue-exit-race.patch.gz

D: Extracts functions which actually create and destroy workqueues,
D: for use by hotplug CPU patch.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .23631-linux-2.5.72-bk3/kernel/workqueue.c .23631-linux-2.5.72-bk3.updated/kernel/workqueue.c
--- .23631-linux-2.5.72-bk3/kernel/workqueue.c	2003-06-22 14:01:48.000000000 +1000
+++ .23631-linux-2.5.72-bk3.updated/kernel/workqueue.c	2003-06-22 14:22:17.000000000 +1000
@@ -259,15 +259,41 @@ void flush_workqueue(struct workqueue_st
 	}
 }
 
-struct workqueue_struct *create_workqueue(const char *name)
+static int create_workqueue_thread(struct workqueue_struct *wq,
+				   const char *name,
+				   int cpu)
 {
-	int ret, cpu, destroy = 0;
-	struct cpu_workqueue_struct *cwq;
 	startup_t startup;
+	struct cpu_workqueue_struct *cwq = wq->cpu_wq + cpu;
+	int ret;
+
+	spin_lock_init(&cwq->lock);
+	cwq->wq = wq;
+	cwq->thread = NULL;
+	cwq->insert_sequence = 0;
+	cwq->remove_sequence = 0;
+	INIT_LIST_HEAD(&cwq->worklist);
+	init_waitqueue_head(&cwq->more_work);
+	init_waitqueue_head(&cwq->work_done);
+	init_completion(&cwq->exit);
+
+	init_completion(&startup.done);
+	startup.cwq = cwq;
+	startup.name = name;
+	ret = kernel_thread(worker_thread, &startup, CLONE_FS | CLONE_FILES);
+	if (ret >= 0) {
+		wait_for_completion(&startup.done);
+		BUG_ON(!cwq->thread);
+	}
+	return ret;
+}
+
+struct workqueue_struct *create_workqueue(const char *name)
+{
+	int cpu, destroy = 0;
 	struct workqueue_struct *wq;
 
 	BUG_ON(strlen(name) > 10);
-	startup.name = name;
 
 	wq = kmalloc(sizeof(*wq), GFP_KERNEL);
 	if (!wq)
@@ -276,28 +302,9 @@ struct workqueue_struct *create_workqueu
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 		if (!cpu_online(cpu))
 			continue;
-		cwq = wq->cpu_wq + cpu;
-
-		spin_lock_init(&cwq->lock);
-		cwq->wq = wq;
-		cwq->thread = NULL;
-		cwq->insert_sequence = 0;
-		cwq->remove_sequence = 0;
-		INIT_LIST_HEAD(&cwq->worklist);
-		init_waitqueue_head(&cwq->more_work);
-		init_waitqueue_head(&cwq->work_done);
-		init_completion(&cwq->exit);
 
-		init_completion(&startup.done);
-		startup.cwq = cwq;
-		ret = kernel_thread(worker_thread, &startup,
-						CLONE_FS | CLONE_FILES);
-		if (ret < 0)
+		if (create_workqueue_thread(wq, name, cpu) < 0)		
 			destroy = 1;
-		else {
-			wait_for_completion(&startup.done);
-			BUG_ON(!cwq->thread);
-		}
 	}
 	/*
 	 * Was there any error during startup? If yes then clean up:
@@ -309,25 +316,30 @@ struct workqueue_struct *create_workqueu
 	return wq;
 }
 
-void destroy_workqueue(struct workqueue_struct *wq)
+static void cleanup_workqueue_thread(struct workqueue_struct *wq, int cpu)
 {
 	struct cpu_workqueue_struct *cwq;
-	int cpu;
-
-	flush_workqueue(wq);
 
-	for (cpu = 0; cpu < NR_CPUS; cpu++) {
-		if (!cpu_online(cpu))
-			continue;
-		cwq = wq->cpu_wq + cpu;
-		if (!cwq->thread)
-			continue;
+	cwq = wq->cpu_wq + cpu;
+	if (cwq->thread) {
 		/* Tell thread to exit and and wait for it: */
 		cwq->thread = NULL;
 		wake_up(&cwq->more_work);
 
 		wait_for_completion(&cwq->exit);
 	}
+}
+
+void destroy_workqueue(struct workqueue_struct *wq)
+{
+	int cpu;
+
+	flush_workqueue(wq);
+
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		if (cpu_online(cpu))
+			cleanup_workqueue_thread(wq, cpu);
+	}
 	kfree(wq);
 }
 
