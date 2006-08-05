Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422720AbWHEHqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422720AbWHEHqM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 03:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422739AbWHEHqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 03:46:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58518 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422720AbWHEHqL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 03:46:11 -0400
Date: Sat, 5 Aug 2006 00:46:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: torvalds@osdl.org, michal.k.k.piotrowski@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-g3b445eea BUG: warning at
 /usr/src/linux-git/kernel/cpu.c:51/unlock_cpu_hotplug()
Message-Id: <20060805004600.2e63fcd9.akpm@osdl.org>
In-Reply-To: <20060805064727.GF13393@redhat.com>
References: <6bffcb0e0608041204u4dad7cd6rab0abc3eca6747c0@mail.gmail.com>
	<Pine.LNX.4.64.0608041222400.5167@g5.osdl.org>
	<20060804222400.GC18792@redhat.com>
	<20060805003142.GH18792@redhat.com>
	<20060805021051.GA13393@redhat.com>
	<20060805022356.GC13393@redhat.com>
	<20060805024947.GE13393@redhat.com>
	<20060805064727.GF13393@redhat.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Aug 2006 02:47:28 -0400
Dave Jones <davej@redhat.com> wrote:

> Creating a variant of __create_workqueue that doesn't take the lock
> seems really nasty.

Honestly, the default fix for lock_cpu_hotplug() problems should be to
delete the lock_cpu_hotplug() calls and to implement local locking.

Here's a not-runtime-tested workqueue.c example.



From: Andrew Morton <akpm@osdl.org>

Use a private lock instead.  It protects all per-cpu data structures in
workqueue.c, including the workqueues list.

Fix a bug in schedule_on_each_cpu(): it was forgetting to lock down the
per-cpu resources.

Unfixed long-standing bug: if someone unplugs the CPU identified by
`singlethread_cpu' the kernel will get very sick.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 kernel/workqueue.c |   33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff -puN kernel/workqueue.c~a kernel/workqueue.c
--- a/kernel/workqueue.c~a
+++ a/kernel/workqueue.c
@@ -68,7 +68,7 @@ struct workqueue_struct {
 
 /* All the per-cpu workqueues on the system, for hotplug cpu to add/remove
    threads to each one as cpus come/go. */
-static DEFINE_SPINLOCK(workqueue_lock);
+static DEFINE_MUTEX(workqueue_mutex);
 static LIST_HEAD(workqueues);
 
 static int singlethread_cpu;
@@ -320,10 +320,10 @@ void fastcall flush_workqueue(struct wor
 	} else {
 		int cpu;
 
-		lock_cpu_hotplug();
+		mutex_lock(&workqueue_mutex);
 		for_each_online_cpu(cpu)
 			flush_cpu_workqueue(per_cpu_ptr(wq->cpu_wq, cpu));
-		unlock_cpu_hotplug();
+		mutex_unlock(&workqueue_mutex);
 	}
 }
 EXPORT_SYMBOL_GPL(flush_workqueue);
@@ -371,8 +371,7 @@ struct workqueue_struct *__create_workqu
 	}
 
 	wq->name = name;
-	/* We don't need the distraction of CPUs appearing and vanishing. */
-	lock_cpu_hotplug();
+	mutex_lock(&workqueue_mutex);
 	if (singlethread) {
 		INIT_LIST_HEAD(&wq->list);
 		p = create_workqueue_thread(wq, singlethread_cpu);
@@ -381,9 +380,7 @@ struct workqueue_struct *__create_workqu
 		else
 			wake_up_process(p);
 	} else {
-		spin_lock(&workqueue_lock);
 		list_add(&wq->list, &workqueues);
-		spin_unlock(&workqueue_lock);
 		for_each_online_cpu(cpu) {
 			p = create_workqueue_thread(wq, cpu);
 			if (p) {
@@ -393,7 +390,7 @@ struct workqueue_struct *__create_workqu
 				destroy = 1;
 		}
 	}
-	unlock_cpu_hotplug();
+	mutex_unlock(&workqueue_mutex);
 
 	/*
 	 * Was there any error during startup? If yes then clean up:
@@ -434,17 +431,15 @@ void destroy_workqueue(struct workqueue_
 	flush_workqueue(wq);
 
 	/* We don't need the distraction of CPUs appearing and vanishing. */
-	lock_cpu_hotplug();
+	mutex_lock(&workqueue_mutex);
 	if (is_single_threaded(wq))
 		cleanup_workqueue_thread(wq, singlethread_cpu);
 	else {
 		for_each_online_cpu(cpu)
 			cleanup_workqueue_thread(wq, cpu);
-		spin_lock(&workqueue_lock);
 		list_del(&wq->list);
-		spin_unlock(&workqueue_lock);
 	}
-	unlock_cpu_hotplug();
+	mutex_unlock(&workqueue_mutex);
 	free_percpu(wq->cpu_wq);
 	kfree(wq);
 }
@@ -515,11 +510,13 @@ int schedule_on_each_cpu(void (*func)(vo
 	if (!works)
 		return -ENOMEM;
 
+	mutex_lock(&workqueue_mutex);
 	for_each_online_cpu(cpu) {
 		INIT_WORK(per_cpu_ptr(works, cpu), func, info);
 		__queue_work(per_cpu_ptr(keventd_wq->cpu_wq, cpu),
 				per_cpu_ptr(works, cpu));
 	}
+	mutex_unlock(&workqueue_mutex);
 	flush_workqueue(keventd_wq);
 	free_percpu(works);
 	return 0;
@@ -635,6 +632,7 @@ static int __devinit workqueue_cpu_callb
 
 	switch (action) {
 	case CPU_UP_PREPARE:
+		mutex_lock(&workqueue_mutex);
 		/* Create a new workqueue thread for it. */
 		list_for_each_entry(wq, &workqueues, list) {
 			if (!create_workqueue_thread(wq, hotcpu)) {
@@ -653,6 +651,7 @@ static int __devinit workqueue_cpu_callb
 			kthread_bind(cwq->thread, hotcpu);
 			wake_up_process(cwq->thread);
 		}
+		mutex_unlock(&workqueue_mutex);
 		break;
 
 	case CPU_UP_CANCELED:
@@ -664,6 +663,15 @@ static int __devinit workqueue_cpu_callb
 				     any_online_cpu(cpu_online_map));
 			cleanup_workqueue_thread(wq, hotcpu);
 		}
+		mutex_unlock(&workqueue_mutex);
+		break;
+
+	case CPU_DOWN_PREPARE:
+		mutex_lock(&workqueue_mutex);
+		break;
+
+	case CPU_DOWN_FAILED:
+		mutex_unlock(&workqueue_mutex);
 		break;
 
 	case CPU_DEAD:
@@ -671,6 +679,7 @@ static int __devinit workqueue_cpu_callb
 			cleanup_workqueue_thread(wq, hotcpu);
 		list_for_each_entry(wq, &workqueues, list)
 			take_over_work(wq, hotcpu);
+		mutex_unlock(&workqueue_mutex);
 		break;
 	}
 
_

