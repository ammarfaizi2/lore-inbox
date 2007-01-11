Return-Path: <linux-kernel-owner+w=401wt.eu-S964901AbXAKXNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbXAKXNT (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 18:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932670AbXAKXNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 18:13:19 -0500
Received: from mail.screens.ru ([213.234.233.54]:52963 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932657AbXAKXNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 18:13:18 -0500
Date: Fri, 12 Jan 2007 02:12:19 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>,
       Nigel Cunningham <nigel@suspend2.net>, David Chinner <dgc@sgi.com>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Gautham shenoy <ego@in.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] workqueue: fix freezeable workqueues implementation
Message-ID: <20070111231219.GA2981@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently ->freezeable is per-cpu, this is wrong. CPU_UP_PREPARE creates
cwq->thread which is not freezeable. Move ->freezeable to workqueue_struct.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- mm-6.20-rc3/kernel/workqueue.c~1_freeze	2007-01-11 21:34:21.000000000 +0300
+++ mm-6.20-rc3/kernel/workqueue.c	2007-01-11 21:38:12.000000000 +0300
@@ -49,8 +49,6 @@ struct cpu_workqueue_struct {
 	struct work_struct *current_work;
 
 	int run_depth;		/* Detect run_workqueue() recursion depth */
-
-	int freezeable;		/* Freeze the thread during suspend */
 } ____cacheline_aligned;
 
 /*
@@ -61,6 +59,7 @@ struct workqueue_struct {
 	struct cpu_workqueue_struct *cpu_wq;
 	const char *name;
 	struct list_head list; 	/* Empty if single thread */
+	int freezeable;		/* Freeze threads during suspend */
 };
 
 /* All the per-cpu workqueues on the system, for hotplug cpu to add/remove
@@ -351,7 +350,7 @@ static int worker_thread(void *__cwq)
 	struct k_sigaction sa;
 	sigset_t blocked;
 
-	if (!cwq->freezeable)
+	if (!cwq->wq->freezeable)
 		current->flags |= PF_NOFREEZE;
 
 	set_user_nice(current, -5);
@@ -375,7 +374,7 @@ static int worker_thread(void *__cwq)
 
 	set_current_state(TASK_INTERRUPTIBLE);
 	while (!kthread_should_stop()) {
-		if (cwq->freezeable)
+		if (cwq->wq->freezeable)
 			try_to_freeze();
 
 		add_wait_queue(&cwq->more_work, &wait);
@@ -546,7 +545,7 @@ out:
 EXPORT_SYMBOL_GPL(flush_work);
 
 static struct task_struct *create_workqueue_thread(struct workqueue_struct *wq,
-						   int cpu, int freezeable)
+							int cpu)
 {
 	struct cpu_workqueue_struct *cwq = per_cpu_ptr(wq->cpu_wq, cpu);
 	struct task_struct *p;
@@ -554,7 +553,6 @@ static struct task_struct *create_workqu
 	spin_lock_init(&cwq->lock);
 	cwq->wq = wq;
 	cwq->thread = NULL;
-	cwq->freezeable = freezeable;
 	INIT_LIST_HEAD(&cwq->worklist);
 	init_waitqueue_head(&cwq->more_work);
 
@@ -586,10 +584,12 @@ struct workqueue_struct *__create_workqu
 	}
 
 	wq->name = name;
+	wq->freezeable = freezeable;
+
 	mutex_lock(&workqueue_mutex);
 	if (singlethread) {
 		INIT_LIST_HEAD(&wq->list);
-		p = create_workqueue_thread(wq, singlethread_cpu, freezeable);
+		p = create_workqueue_thread(wq, singlethread_cpu);
 		if (!p)
 			destroy = 1;
 		else
@@ -597,7 +597,7 @@ struct workqueue_struct *__create_workqu
 	} else {
 		list_add(&wq->list, &workqueues);
 		for_each_online_cpu(cpu) {
-			p = create_workqueue_thread(wq, cpu, freezeable);
+			p = create_workqueue_thread(wq, cpu);
 			if (p) {
 				kthread_bind(p, cpu);
 				wake_up_process(p);
@@ -859,7 +859,7 @@ static int __devinit workqueue_cpu_callb
 	case CPU_UP_PREPARE:
 		/* Create a new workqueue thread for it. */
 		list_for_each_entry(wq, &workqueues, list) {
-			if (!create_workqueue_thread(wq, hotcpu, 0)) {
+			if (!create_workqueue_thread(wq, hotcpu)) {
 				printk("workqueue for %i failed\n", hotcpu);
 				return NOTIFY_BAD;
 			}

