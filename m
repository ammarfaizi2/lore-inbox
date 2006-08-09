Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbWHIPYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWHIPYy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 11:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbWHIPYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 11:24:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26244 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750993AbWHIPYw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 11:24:52 -0400
Date: Wed, 9 Aug 2006 08:24:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, davej@codemonkey.org.uk
Subject: Re: rc4: lukewarm irq warning during boot
Message-Id: <20060809082442.16879b17.akpm@osdl.org>
In-Reply-To: <20060809085534.GA1694@elf.ucw.cz>
References: <20060809085534.GA1694@elf.ucw.cz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2006 10:55:35 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> I'm getting this... I guess this is known and too hard to fix for
> 2.6.18... but perhaps warning should be disabled? (Or is that already
> a plan for 2.6.18?)
> 
> 								Pavel
> Lukewarm IQ detected in hotplug locking
> BUG: warning at kernel/cpu.c:38/lock_cpu_hotplug()
>  [<c0104343>] show_trace_log_lvl+0x163/0x190
>  [<c01057af>] show_trace+0xf/0x20
>  [<c01057d5>] dump_stack+0x15/0x20
>  [<c01427fc>] lock_cpu_hotplug+0x7c/0x90
>  [<c0138af7>] __create_workqueue+0x47/0x140
>  [<c04bb58b>] cpufreq_governor_dbs+0x2cb/0x320
>  [<c04b97d6>] __cpufreq_governor+0x46/0xf0
>  [<c04b9a82>] __cpufreq_set_policy+0xf2/0x140
>  [<c04b9d22>] store_scaling_governor+0xd2/0x1c0
>  [<c04b95cd>] store+0x3d/0x60
>  [<c01ab55f>] sysfs_write_file+0x8f/0xe0
>  [<c016e056>] vfs_write+0xa6/0x160
>  [<c016ea11>] sys_write+0x41/0x70
>  [<c010303f>] syscall_call+0x7/0xb
>  [<b7ec52ce>] 0xb7ec52ce
>  [<c01427fc>] lock_cpu_hotplug+0x7c/0x90
>  [<c0138af7>] __create_workqueue+0x47/0x140
>  [<c04bb58b>] cpufreq_governor_dbs+0x2cb/0x320
>  [<c013531b>] notifier_call_chain+0x2b/0x60
>  [<c04b97d6>] __cpufreq_governor+0x46/0xf0
>  [<c04b9a82>] __cpufreq_set_policy+0xf2/0x140
>  [<c04b9d22>] store_scaling_governor+0xd2/0x1c0
>  [<c04ba710>] handle_update+0x0/0x10
>  [<c0269500>] kobject_set_name+0x20/0xb0
>  [<c04b9c50>] store_scaling_governor+0x0/0x1c0
>  [<c04b95cd>] store+0x3d/0x60
>  [<c01ab55f>] sysfs_write_file+0x8f/0xe0
>  [<c016e056>] vfs_write+0xa6/0x160
>  [<c01ab4d0>] sysfs_write_file+0x0/0xe0
>  [<c016ea11>] sys_write+0x41/0x70
>  [<c010303f>] syscall_call+0x7/0xb
> 

This should fix that particular bogon:



From: Andrew Morton <akpm@osdl.org>

Use a private lock instead.  It protects all per-cpu data structures in
workqueue.c, including the workqueues list.

Fix a bug in schedule_on_each_cpu(): it was forgetting to lock down the
per-cpu resources.

Unfixed long-standing bug: if someone unplugs the CPU identified by
`singlethread_cpu' the kernel will get very sick.

Cc: Dave Jones <davej@codemonkey.org.uk>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 kernel/workqueue.c |   33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff -puN kernel/workqueue.c~workqueue-remove-lock_cpu_hotplug kernel/workqueue.c
--- a/kernel/workqueue.c~workqueue-remove-lock_cpu_hotplug
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

