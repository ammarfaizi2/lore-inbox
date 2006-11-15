Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161811AbWKOWBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161811AbWKOWBu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 17:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161812AbWKOWBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 17:01:50 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:24967 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1161811AbWKOWBt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 17:01:49 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
Date: Wed, 15 Nov 2006 22:58:51 +0100
User-Agent: KMail/1.9.1
Cc: David Chinner <dgc@sgi.com>, Alasdair G Kergon <agk@redhat.com>,
       Eric Sandeen <sandeen@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       Srinivasa DS <srinivasa@in.ibm.com>,
       Nigel Cunningham <nigel@suspend2.net>
References: <20061107183459.GG6993@agk.surrey.redhat.com> <200611152100.35054.rjw@sisk.pl> <20061115202348.GB3875@elf.ucw.cz>
In-Reply-To: <20061115202348.GB3875@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611152258.52160.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday, 15 November 2006 21:23, Pavel Machek wrote:
> Hi!
> 
> > > There's one more thing, actually.  If the on-disk data and metadata are
> > > changed _after_ the sync we do and _before_ we create the snapshot image,
> > > and the subsequent  resume fails,
> > 
> > Well, but this is equivalent to a power failure immediately after the sync, so
> > there _must_ be a way to recover the filesystem from that, no?
> 
> Exactly.
> 
> > I think I'll prepare a patch for freezing the work queues and we'll see what
> > to do next.
> 
> Thanks!

Okay, the patch follows.

I've been running it for some time on my boxes and it doesn't seem to break
anything.  However, I don't use XFS, so well ...

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 fs/xfs/linux-2.6/xfs_buf.c |    4 ++--
 include/linux/workqueue.h  |    8 +++++---
 kernel/workqueue.c         |   20 ++++++++++++++------
 3 files changed, 21 insertions(+), 11 deletions(-)

Index: linux-2.6.19-rc5-mm2/include/linux/workqueue.h
===================================================================
--- linux-2.6.19-rc5-mm2.orig/include/linux/workqueue.h	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.19-rc5-mm2/include/linux/workqueue.h	2006-11-15 21:58:40.000000000 +0100
@@ -55,9 +55,11 @@ struct execute_work {
 	} while (0)
 
 extern struct workqueue_struct *__create_workqueue(const char *name,
-						    int singlethread);
-#define create_workqueue(name) __create_workqueue((name), 0)
-#define create_singlethread_workqueue(name) __create_workqueue((name), 1)
+						    int singlethread,
+						    int freezeable);
+#define create_workqueue(name) __create_workqueue((name), 0, 0)
+#define create_freezeable_workqueue(name) __create_workqueue((name), 0, 1)
+#define create_singlethread_workqueue(name) __create_workqueue((name), 1, 0)
 
 extern void destroy_workqueue(struct workqueue_struct *wq);
 
Index: linux-2.6.19-rc5-mm2/kernel/workqueue.c
===================================================================
--- linux-2.6.19-rc5-mm2.orig/kernel/workqueue.c	2006-11-15 21:32:13.000000000 +0100
+++ linux-2.6.19-rc5-mm2/kernel/workqueue.c	2006-11-15 22:27:40.000000000 +0100
@@ -31,6 +31,7 @@
 #include <linux/mempolicy.h>
 #include <linux/kallsyms.h>
 #include <linux/debug_locks.h>
+#include <linux/freezer.h>
 
 /*
  * The per-CPU workqueue (if single thread, we always use the first
@@ -57,6 +58,8 @@ struct cpu_workqueue_struct {
 	struct task_struct *thread;
 
 	int run_depth;		/* Detect run_workqueue() recursion depth */
+
+	int freezeable;		/* Freeze the thread during suspend */
 } ____cacheline_aligned;
 
 /*
@@ -251,7 +254,8 @@ static int worker_thread(void *__cwq)
 	struct k_sigaction sa;
 	sigset_t blocked;
 
-	current->flags |= PF_NOFREEZE;
+	if (!cwq->freezeable)
+		current->flags |= PF_NOFREEZE;
 
 	set_user_nice(current, -5);
 
@@ -274,6 +278,9 @@ static int worker_thread(void *__cwq)
 
 	set_current_state(TASK_INTERRUPTIBLE);
 	while (!kthread_should_stop()) {
+		if (cwq->freezeable)
+			try_to_freeze();
+
 		add_wait_queue(&cwq->more_work, &wait);
 		if (list_empty(&cwq->worklist))
 			schedule();
@@ -350,7 +357,7 @@ void fastcall flush_workqueue(struct wor
 EXPORT_SYMBOL_GPL(flush_workqueue);
 
 static struct task_struct *create_workqueue_thread(struct workqueue_struct *wq,
-						   int cpu)
+						   int cpu, int freezeable)
 {
 	struct cpu_workqueue_struct *cwq = per_cpu_ptr(wq->cpu_wq, cpu);
 	struct task_struct *p;
@@ -360,6 +367,7 @@ static struct task_struct *create_workqu
 	cwq->thread = NULL;
 	cwq->insert_sequence = 0;
 	cwq->remove_sequence = 0;
+	cwq->freezeable = freezeable;
 	INIT_LIST_HEAD(&cwq->worklist);
 	init_waitqueue_head(&cwq->more_work);
 	init_waitqueue_head(&cwq->work_done);
@@ -375,7 +383,7 @@ static struct task_struct *create_workqu
 }
 
 struct workqueue_struct *__create_workqueue(const char *name,
-					    int singlethread)
+					    int singlethread, int freezeable)
 {
 	int cpu, destroy = 0;
 	struct workqueue_struct *wq;
@@ -395,7 +403,7 @@ struct workqueue_struct *__create_workqu
 	mutex_lock(&workqueue_mutex);
 	if (singlethread) {
 		INIT_LIST_HEAD(&wq->list);
-		p = create_workqueue_thread(wq, singlethread_cpu);
+		p = create_workqueue_thread(wq, singlethread_cpu, freezeable);
 		if (!p)
 			destroy = 1;
 		else
@@ -403,7 +411,7 @@ struct workqueue_struct *__create_workqu
 	} else {
 		list_add(&wq->list, &workqueues);
 		for_each_online_cpu(cpu) {
-			p = create_workqueue_thread(wq, cpu);
+			p = create_workqueue_thread(wq, cpu, freezeable);
 			if (p) {
 				kthread_bind(p, cpu);
 				wake_up_process(p);
@@ -657,7 +665,7 @@ static int __devinit workqueue_cpu_callb
 		mutex_lock(&workqueue_mutex);
 		/* Create a new workqueue thread for it. */
 		list_for_each_entry(wq, &workqueues, list) {
-			if (!create_workqueue_thread(wq, hotcpu)) {
+			if (!create_workqueue_thread(wq, hotcpu, 0)) {
 				printk("workqueue for %i failed\n", hotcpu);
 				return NOTIFY_BAD;
 			}
Index: linux-2.6.19-rc5-mm2/fs/xfs/linux-2.6/xfs_buf.c
===================================================================
--- linux-2.6.19-rc5-mm2.orig/fs/xfs/linux-2.6/xfs_buf.c	2006-11-15 21:32:08.000000000 +0100
+++ linux-2.6.19-rc5-mm2/fs/xfs/linux-2.6/xfs_buf.c	2006-11-15 22:12:43.000000000 +0100
@@ -1826,11 +1826,11 @@ xfs_buf_init(void)
 	if (!xfs_buf_zone)
 		goto out_free_trace_buf;
 
-	xfslogd_workqueue = create_workqueue("xfslogd");
+	xfslogd_workqueue = create_freezeable_workqueue("xfslogd");
 	if (!xfslogd_workqueue)
 		goto out_free_buf_zone;
 
-	xfsdatad_workqueue = create_workqueue("xfsdatad");
+	xfsdatad_workqueue = create_freezeable_workqueue("xfsdatad");
 	if (!xfsdatad_workqueue)
 		goto out_destroy_xfslogd_workqueue;
 
