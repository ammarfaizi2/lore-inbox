Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423239AbWJZKys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423239AbWJZKys (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 06:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423248AbWJZKyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 06:54:47 -0400
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:37584 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1423239AbWJZKyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 06:54:46 -0400
Date: Thu, 26 Oct 2006 16:25:23 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: Gautham R Shenoy <ego@in.ibm.com>
Cc: rusty@rustcorp.com.au, torvalds@osdl.org, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, vatsa@in.ibm.com,
       dipankar@in.ibm.com, gaughen@us.ibm.com, arjan@linux.intel.org,
       davej@redhat.com, venkatesh.pallipadi@intel.com, kiran@scalex86.org
Subject: [PATCH 3/5] lock_cpu_hotplug:Redesign - Use lock_cpu_hotplug in workqueue.c instead of workqueue_mutex.
Message-ID: <20061026105523.GD11803@in.ibm.com>
Reply-To: ego@in.ibm.com
References: <20061026104858.GA11803@in.ibm.com> <20061026105058.GB11803@in.ibm.com> <20061026105342.GC11803@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061026105342.GC11803@in.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use lock_cpu_hotplug() instead of workqueue_mutex to prevent a 
cpu-hotplug event in kernel/workqueue.c.

Signed-off-by: Gautham R Shenoy <ego@in.ibm.com>

---
 kernel/workqueue.c |   37 +++++++++++++------------------------
 1 files changed, 13 insertions(+), 24 deletions(-)

Index: hotplug/kernel/workqueue.c
===================================================================
--- hotplug.orig/kernel/workqueue.c
+++ hotplug/kernel/workqueue.c
@@ -67,9 +67,7 @@ struct workqueue_struct {
 	struct list_head list; 	/* Empty if single thread */
 };
 
-/* All the per-cpu workqueues on the system, for hotplug cpu to add/remove
-   threads to each one as cpus come/go. */
-static DEFINE_MUTEX(workqueue_mutex);
+static DEFINE_SPINLOCK(workqueue_lock);
 static LIST_HEAD(workqueues);
 
 static int singlethread_cpu;
@@ -328,10 +326,10 @@ void fastcall flush_workqueue(struct wor
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
@@ -379,7 +377,7 @@ struct workqueue_struct *__create_workqu
 	}
 
 	wq->name = name;
-	mutex_lock(&workqueue_mutex);
+	lock_cpu_hotplug();
 	if (singlethread) {
 		INIT_LIST_HEAD(&wq->list);
 		p = create_workqueue_thread(wq, singlethread_cpu);
@@ -388,7 +386,9 @@ struct workqueue_struct *__create_workqu
 		else
 			wake_up_process(p);
 	} else {
+		spin_lock(&workqueue_lock);
 		list_add(&wq->list, &workqueues);
+		spin_unlock(&workqueue_lock);
 		for_each_online_cpu(cpu) {
 			p = create_workqueue_thread(wq, cpu);
 			if (p) {
@@ -398,8 +398,7 @@ struct workqueue_struct *__create_workqu
 				destroy = 1;
 		}
 	}
-	mutex_unlock(&workqueue_mutex);
-
+	unlock_cpu_hotplug();
 	/*
 	 * Was there any error during startup? If yes then clean up:
 	 */
@@ -439,15 +438,17 @@ void destroy_workqueue(struct workqueue_
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
@@ -519,13 +520,13 @@ int schedule_on_each_cpu(void (*func)(vo
 	if (!works)
 		return -ENOMEM;
 
-	mutex_lock(&workqueue_mutex);
+	lock_cpu_hotplug();
 	for_each_online_cpu(cpu) {
 		INIT_WORK(per_cpu_ptr(works, cpu), func, info);
 		__queue_work(per_cpu_ptr(keventd_wq->cpu_wq, cpu),
 				per_cpu_ptr(works, cpu));
 	}
-	mutex_unlock(&workqueue_mutex);
+	unlock_cpu_hotplug();
 	flush_workqueue(keventd_wq);
 	free_percpu(works);
 	return 0;
@@ -641,7 +642,6 @@ static int __devinit workqueue_cpu_callb
 
 	switch (action) {
 	case CPU_UP_PREPARE:
-		mutex_lock(&workqueue_mutex);
 		/* Create a new workqueue thread for it. */
 		list_for_each_entry(wq, &workqueues, list) {
 			if (!create_workqueue_thread(wq, hotcpu)) {
@@ -660,7 +660,6 @@ static int __devinit workqueue_cpu_callb
 			kthread_bind(cwq->thread, hotcpu);
 			wake_up_process(cwq->thread);
 		}
-		mutex_unlock(&workqueue_mutex);
 		break;
 
 	case CPU_UP_CANCELED:
@@ -672,15 +671,6 @@ static int __devinit workqueue_cpu_callb
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
@@ -688,7 +678,6 @@ static int __devinit workqueue_cpu_callb
 			cleanup_workqueue_thread(wq, hotcpu);
 		list_for_each_entry(wq, &workqueues, list)
 			take_over_work(wq, hotcpu);
-		mutex_unlock(&workqueue_mutex);
 		break;
 	}
 
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
