Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030621AbWKULXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030621AbWKULXg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 06:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966964AbWKULXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 06:23:36 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:65485 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S966961AbWKULXf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 06:23:35 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: nigelc@bur.st
Subject: Re: [PATCH -mm 0/2] Use freezeable workqueues to avoid suspend-related XFS corruptions
Date: Tue, 21 Nov 2006 12:19:52 +0100
User-Agent: KMail/1.9.1
Cc: David Chinner <dgc@sgi.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
References: <200611160912.51226.rjw@sisk.pl> <200611202355.50487.rjw@sisk.pl> <1164070310.15714.15.camel@nigel.suspend2.net>
In-Reply-To: <1164070310.15714.15.camel@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ZDuYFrZDuEdhvdQ"
Message-Id: <200611211219.53086.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_ZDuYFrZDuEdhvdQ
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Tuesday, 21 November 2006 01:51, Nigel Cunningham wrote:
> Hi.
> 
> On Mon, 2006-11-20 at 23:55 +0100, Rafael J. Wysocki wrote:
> > On Monday, 20 November 2006 23:39, Nigel Cunningham wrote:
> > > (Sorry to reply again)
> > 
> > (No big deal)
> > 
> > > On Tue, 2006-11-21 at 09:26 +1100, Nigel Cunningham wrote:
> > > > Hi.
> > > > 
> > > > On Mon, 2006-11-20 at 23:18 +0100, Rafael J. Wysocki wrote:
> > > > > I think I/O can only be submitted from the process context.  Thus if we freeze
> > > > > all (and I mean _all_) threads that are used by filesystems, including worker
> > > > > threads, we should effectively prevent fs-related I/O from being submitted
> > > > > after tasks have been frozen.
> > > > 
> > > > I know that will work. It's what I used to do before the switch to bdev
> > > > freezing. I guess I need to look again at why I made the switch. Perhaps
> > > > it was just because you guys gave freezing kthreads a bad wrap as too
> > > > invasive or something. Bdev freezing is certainly fewer lines of code.
> > > 
> > > No, it looks like I wrongly believed that XFS was submitting I/O off a
> > > timer, so that freezing kthreads wasn't enough. In that case, it looks
> > > like freezing kthreads should be a good solution.
> > 
> > Okay, so let's implement it. :-)
> 
> Agreed. I'm a bit confused now about what the latest version of your
> patches is, but I'll be happy to switch back to kthread freezing in the
> next Suspend2 release if it will help with getting them wider testing.

The latest are:

support-for-freezeable-workqueues.patch
use-freezeable-workqueues-in-xfs.patch

(both attached for convenience) and the freezing of bdevs patch has been
dropped.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller

--Boundary-00=_ZDuYFrZDuEdhvdQ
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="support-for-freezeable-workqueues.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="support-for-freezeable-workqueues.patch"

 include/linux/workqueue.h |    8 +++++---
 kernel/workqueue.c        |   20 ++++++++++++++------
 2 files changed, 19 insertions(+), 9 deletions(-)

Index: linux-2.6.19-rc5-mm2/include/linux/workqueue.h
===================================================================
--- linux-2.6.19-rc5-mm2.orig/include/linux/workqueue.h
+++ linux-2.6.19-rc5-mm2/include/linux/workqueue.h
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
--- linux-2.6.19-rc5-mm2.orig/kernel/workqueue.c
+++ linux-2.6.19-rc5-mm2/kernel/workqueue.c
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

--Boundary-00=_ZDuYFrZDuEdhvdQ
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="use-freezeable-workqueues-in-xfs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="use-freezeable-workqueues-in-xfs.patch"

---
 fs/xfs/linux-2.6/xfs_buf.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.19-rc5-mm2/fs/xfs/linux-2.6/xfs_buf.c
===================================================================
--- linux-2.6.19-rc5-mm2.orig/fs/xfs/linux-2.6/xfs_buf.c
+++ linux-2.6.19-rc5-mm2/fs/xfs/linux-2.6/xfs_buf.c
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
 

--Boundary-00=_ZDuYFrZDuEdhvdQ--
