Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbWGZTnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbWGZTnK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 15:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbWGZTnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 15:43:10 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:4286 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S932381AbWGZTnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 15:43:09 -0400
Subject: Re: [patch] Reorganize the cpufreq cpu hotplug locking to not be
	totally bizare
From: Arjan van de Ven <arjan@linux.intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dave Jones <davej@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Ashok Raj <ashok.raj@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607261007530.29649@g5.osdl.org>
References: <200607242023_MC3-1-C5FE-CADB@compuserve.com>
	 <Pine.LNX.4.64.0607241752290.29649@g5.osdl.org>
	 <20060725185449.GA8074@elte.hu>
	 <1153855844.8932.56.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0607251355080.29649@g5.osdl.org>
	 <1153921207.3381.21.camel@laptopd505.fenrus.org>
	 <20060726155114.GA28945@redhat.com>
	 <Pine.LNX.4.64.0607261007530.29649@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 26 Jul 2006 21:42:34 +0200
Message-Id: <1153942954.3381.50.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-26 at 10:09 -0700, Linus Torvalds wrote:

> It looked sensible to me too, although it still shows some "Lukewarm IQ" 
> notices for the ondemand driver:
> 
> 	Lukewarm IQ detected in hotplug locking
> 	BUG: warning at kernel/cpu.c:38/lock_cpu_hotplug()
> 	 [<c0103d07>] show_trace+0xd/0x10
> 	 [<c01042ec>] dump_stack+0x19/0x1b
> 	 [<c013778d>] lock_cpu_hotplug+0x43/0x69
> 	 [<c012f9df>] __create_workqueue+0x52/0x11f
> 	 [<df0ec34b>] cpufreq_governor_dbs+0x9f/0x2bd [cpufreq_ondemand]

ok so this is messy. ondemand wants to create a workqueue, but this
function is called (after my patch) with the lock_cpu_hotplug() already
held, and all the workqueue functions take the lock_cpu_hotplug
themselves (looking at that code I'm not 100% convinced it's quite right
how it does that, but that's a separate matter). Before my first patch
it wasn't doing that, but that situation was even nastier; there is a
lock that is taken in the caller, and the lock_cpu_hotplug() lock
*really* wants to nest outside that lock ;( 

As a quick hack I made non-lock_cpu_hotplug()'ing versions of the 3 key
workqueue functions (patch below). It works, it's correct, it's just so
ugly that I'm almost too ashamed to post it. I haven't found a better
solution yet though... time to take a step back I suppose.

Index: linux-2.6.18-rc2-git5/include/linux/workqueue.h
===================================================================
--- linux-2.6.18-rc2-git5.orig/include/linux/workqueue.h
+++ linux-2.6.18-rc2-git5/include/linux/workqueue.h
@@ -55,17 +55,20 @@ struct execute_work {
 	} while (0)
 
 extern struct workqueue_struct *__create_workqueue(const char *name,
-						    int singlethread);
-#define create_workqueue(name) __create_workqueue((name), 0)
-#define create_singlethread_workqueue(name) __create_workqueue((name), 1)
+						    int singlethread, int locked);
+#define create_workqueue(name) __create_workqueue((name), 0, 0)
+#define create_workqueue_cpulocked(name) __create_workqueue((name), 0, 1)
+#define create_singlethread_workqueue(name) __create_workqueue((name), 1, 0)
 
 extern void destroy_workqueue(struct workqueue_struct *wq);
+extern void destroy_workqueue_cpulock(struct workqueue_struct *wq);
 
 extern int FASTCALL(queue_work(struct workqueue_struct *wq, struct work_struct *work));
 extern int FASTCALL(queue_delayed_work(struct workqueue_struct *wq, struct work_struct *work, unsigned long delay));
 extern int queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
 	struct work_struct *work, unsigned long delay);
 extern void FASTCALL(flush_workqueue(struct workqueue_struct *wq));
+extern void FASTCALL(__flush_workqueue(struct workqueue_struct *wq));
 
 extern int FASTCALL(schedule_work(struct work_struct *work));
 extern int FASTCALL(schedule_delayed_work(struct work_struct *work, unsigned long delay));
Index: linux-2.6.18-rc2-git5/kernel/workqueue.c
===================================================================
--- linux-2.6.18-rc2-git5.orig/kernel/workqueue.c
+++ linux-2.6.18-rc2-git5/kernel/workqueue.c
@@ -307,6 +307,22 @@ void fastcall flush_workqueue(struct wor
 }
 EXPORT_SYMBOL_GPL(flush_workqueue);
 
+void fastcall __flush_workqueue(struct workqueue_struct *wq)
+{
+	might_sleep();
+
+	if (is_single_threaded(wq)) {
+		/* Always use first cpu's area. */
+		flush_cpu_workqueue(per_cpu_ptr(wq->cpu_wq, singlethread_cpu));
+	} else {
+		int cpu;
+
+		for_each_online_cpu(cpu)
+			flush_cpu_workqueue(per_cpu_ptr(wq->cpu_wq, cpu));
+	}
+}
+EXPORT_SYMBOL_GPL(__flush_workqueue);
+
 static struct task_struct *create_workqueue_thread(struct workqueue_struct *wq,
 						   int cpu)
 {
@@ -333,7 +349,7 @@ static struct task_struct *create_workqu
 }
 
 struct workqueue_struct *__create_workqueue(const char *name,
-					    int singlethread)
+					    int singlethread, int locked)
 {
 	int cpu, destroy = 0;
 	struct workqueue_struct *wq;
@@ -351,7 +367,8 @@ struct workqueue_struct *__create_workqu
 
 	wq->name = name;
 	/* We don't need the distraction of CPUs appearing and vanishing. */
-	lock_cpu_hotplug();
+	if (!locked)
+		lock_cpu_hotplug();
 	if (singlethread) {
 		INIT_LIST_HEAD(&wq->list);
 		p = create_workqueue_thread(wq, singlethread_cpu);
@@ -372,7 +389,8 @@ struct workqueue_struct *__create_workqu
 				destroy = 1;
 		}
 	}
-	unlock_cpu_hotplug();
+	if (!locked)
+		unlock_cpu_hotplug();
 
 	/*
 	 * Was there any error during startup? If yes then clean up:
@@ -400,14 +418,17 @@ static void cleanup_workqueue_thread(str
 		kthread_stop(p);
 }
 
-void destroy_workqueue(struct workqueue_struct *wq)
+static void __destroy_workqueue(struct workqueue_struct *wq, int locked)
 {
 	int cpu;
 
-	flush_workqueue(wq);
 
 	/* We don't need the distraction of CPUs appearing and vanishing. */
-	lock_cpu_hotplug();
+	if (!locked)
+		lock_cpu_hotplug();
+
+	__flush_workqueue(wq);
+
 	if (is_single_threaded(wq))
 		cleanup_workqueue_thread(wq, singlethread_cpu);
 	else {
@@ -417,11 +438,22 @@ void destroy_workqueue(struct workqueue_
 		list_del(&wq->list);
 		spin_unlock(&workqueue_lock);
 	}
-	unlock_cpu_hotplug();
+	if (!locked)
+		unlock_cpu_hotplug();
 	free_percpu(wq->cpu_wq);
 	kfree(wq);
 }
+
+void destroy_workqueue(struct workqueue_struct *wq)
+{
+	__destroy_workqueue(wq, 0);
+}
 EXPORT_SYMBOL_GPL(destroy_workqueue);
+void destroy_workqueue_cpulock(struct workqueue_struct *wq)
+{
+	__destroy_workqueue(wq, 1);
+}
+EXPORT_SYMBOL_GPL(destroy_workqueue_cpulock);
 
 static struct workqueue_struct *keventd_wq;
 

