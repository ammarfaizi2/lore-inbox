Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbWHXK3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbWHXK3k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 06:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbWHXK3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 06:29:40 -0400
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:49581 "EHLO
	ausmtp05.au.ibm.com") by vger.kernel.org with ESMTP
	id S1751040AbWHXK3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 06:29:39 -0400
Date: Thu, 24 Aug 2006 16:00:43 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: rusty@rustcorp.com.au, torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, arjan@intel.linux.com, mingo@elte.hu,
       davej@redhat.com, vatsa@in.ibm.com, dipankar@in.ibm.com,
       ashok.raj@intel.com
Subject: [RFC][PATCH 2/4] Revert Changes to kernel/workqueue.c
Message-ID: <20060824103043.GC2395@in.ibm.com>
Reply-To: ego@in.ibm.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"

--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2of4.patch"

This patch removes the per-subsystem hot-cpu mutex, workqueue_lock
and reverts the implementation of workqueue.c to its older form.

Signed-off-by : Gautham R Shenoy <ego@in.ibm.com>

Index: current/kernel/workqueue.c
===================================================================
--- current.orig/kernel/workqueue.c	2006-08-24 09:33:29.000000000 +0530
+++ current/kernel/workqueue.c	2006-08-24 15:00:02.000000000 +0530
@@ -68,7 +68,7 @@ struct workqueue_struct {
 
 /* All the per-cpu workqueues on the system, for hotplug cpu to add/remove
    threads to each one as cpus come/go. */
-static DEFINE_MUTEX(workqueue_mutex);
+static DEFINE_SPINLOCK(workqueue_lock);
 static LIST_HEAD(workqueues);
 
 static int singlethread_cpu;
@@ -320,10 +320,10 @@ void fastcall flush_workqueue(struct wor
 	} else {
 		int cpu;
 
-		mutex_lock(&workqueue_mutex);
+		lock_cpu_hotplug();
 		for_each_online_cpu(cpu)
 			flush_cpu_workqueue(per_cpu_ptr(wq->cpu_wq, cpu));
-		mutex_unlock(&workqueue_mutex);
+		unlock_cpu_hotplug();
 	}
 }
 EXPORT_SYMBOL_GPL(flush_workqueue);
@@ -371,7 +371,8 @@ struct workqueue_struct *__create_workqu
 	}
 
 	wq->name = name;
-	mutex_lock(&workqueue_mutex);
+	/* We don't need the distraction of CPUs appearing and vanishing. */
+	lock_cpu_hotplug();
 	if (singlethread) {
 		INIT_LIST_HEAD(&wq->list);
 		p = create_workqueue_thread(wq, singlethread_cpu);
@@ -380,7 +381,9 @@ struct workqueue_struct *__create_workqu
 		else
 			wake_up_process(p);
 	} else {
+		spin_lock(&workqueue_lock);
 		list_add(&wq->list, &workqueues);
+		spin_unlock(&workqueue_lock);
 		for_each_online_cpu(cpu) {
 			p = create_workqueue_thread(wq, cpu);
 			if (p) {
@@ -390,7 +393,7 @@ struct workqueue_struct *__create_workqu
 				destroy = 1;
 		}
 	}
-	mutex_unlock(&workqueue_mutex);
+	unlock_cpu_hotplug();
 
 	/*
 	 * Was there any error during startup? If yes then clean up:
@@ -431,15 +434,17 @@ void destroy_workqueue(struct workqueue_
 	flush_workqueue(wq);
 
 	/* We don't need the distraction of CPUs appearing and vanishing. */
-	mutex_lock(&workqueue_mutex);
+	lock_cpu_hotplug();
 	if (is_single_threaded(wq))
 		cleanup_workqueue_thread(wq, singlethread_cpu);
 	else {
 		for_each_online_cpu(cpu)
 			cleanup_workqueue_thread(wq, cpu);
+		spin_lock(&workqueue_lock);
 		list_del(&wq->list);
+		spin_unlock(&workqueue_lock);
 	}
-	mutex_unlock(&workqueue_mutex);
+	unlock_cpu_hotplug();
 	free_percpu(wq->cpu_wq);
 	kfree(wq);
 }
@@ -510,13 +515,11 @@ int schedule_on_each_cpu(void (*func)(vo
 	if (!works)
 		return -ENOMEM;
 
-	mutex_lock(&workqueue_mutex);
 	for_each_online_cpu(cpu) {
 		INIT_WORK(per_cpu_ptr(works, cpu), func, info);
 		__queue_work(per_cpu_ptr(keventd_wq->cpu_wq, cpu),
 				per_cpu_ptr(works, cpu));
 	}
-	mutex_unlock(&workqueue_mutex);
 	flush_workqueue(keventd_wq);
 	free_percpu(works);
 	return 0;
@@ -632,7 +635,6 @@ static int __devinit workqueue_cpu_callb
 
 	switch (action) {
 	case CPU_UP_PREPARE:
-		mutex_lock(&workqueue_mutex);
 		/* Create a new workqueue thread for it. */
 		list_for_each_entry(wq, &workqueues, list) {
 			if (!create_workqueue_thread(wq, hotcpu)) {
@@ -651,7 +653,6 @@ static int __devinit workqueue_cpu_callb
 			kthread_bind(cwq->thread, hotcpu);
 			wake_up_process(cwq->thread);
 		}
-		mutex_unlock(&workqueue_mutex);
 		break;
 
 	case CPU_UP_CANCELED:
@@ -663,15 +664,6 @@ static int __devinit workqueue_cpu_callb
 				     any_online_cpu(cpu_online_map));
 			cleanup_workqueue_thread(wq, hotcpu);
 		}
-		mutex_unlock(&workqueue_mutex);
-		break;
-
-	case CPU_DOWN_PREPARE:
-		mutex_lock(&workqueue_mutex);
-		break;
-
-	case CPU_DOWN_FAILED:
-		mutex_unlock(&workqueue_mutex);
 		break;
 
 	case CPU_DEAD:
@@ -679,7 +671,6 @@ static int __devinit workqueue_cpu_callb
 			cleanup_workqueue_thread(wq, hotcpu);
 		list_for_each_entry(wq, &workqueues, list)
 			take_over_work(wq, hotcpu);
-		mutex_unlock(&workqueue_mutex);
 		break;
 	}
 

--TRYliJ5NKNqkz5bu--
