Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266290AbUFPO17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266290AbUFPO17 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 10:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266318AbUFPO0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 10:26:07 -0400
Received: from cfcafw.sgi.com ([198.149.23.1]:35971 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S266309AbUFPOYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 10:24:30 -0400
Date: Wed, 16 Jun 2004 09:24:13 -0500
From: Dimitri Sivanich <sivanich@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH]: Option to run cache reap in thread mode
Message-ID: <20040616142413.GA5588@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In the process of testing per/cpu interrupt response times and CPU availability,
I've found that running cache_reap() as a timer as is done currently results
in some fairly long CPU holdoffs.

I would like to know what others think about running cache_reap() as a low
priority realtime kthread, at least on certain cpus that would be configured
that way (probably configured at boottime initially).  I've been doing some
testing running it this way on CPU's whose activity is mostly restricted to
realtime work (requiring rapid response times).

Here's my first cut at an initial patch for this (there will be other changes
later to set the configuration and to optimize locking in cache_reap()).

Dimitri Sivanich <sivanich@sgi.com>


--- linux/mm/slab.c.orig	2004-06-16 09:09:09.000000000 -0500
+++ linux/mm/slab.c	2004-06-16 09:10:03.000000000 -0500
@@ -91,6 +91,9 @@
 #include	<linux/cpu.h>
 #include	<linux/sysctl.h>
 #include	<linux/module.h>
+#include	<linux/kthread.h>
+#include	<linux/stop_machine.h>
+#include	<linux/syscalls.h>
 
 #include	<asm/uaccess.h>
 #include	<asm/cacheflush.h>
@@ -530,8 +533,15 @@ enum {
 	FULL
 } g_cpucache_up;
 
+cpumask_t threaded_reap;	/* CPUs configured to run reap in thread mode */
+
+static DEFINE_PER_CPU(task_t *, reap_thread);
 static DEFINE_PER_CPU(struct timer_list, reap_timers);
 
+static void start_reap_thread(unsigned long cpu);
+#ifdef CONFIG_HOTPLUG_CPU
+static void stop_reap_thread(unsigned long cpu);
+#endif
 static void reap_timer_fnc(unsigned long data);
 static void free_block(kmem_cache_t* cachep, void** objpp, int len);
 static void enable_cpucache (kmem_cache_t *cachep);
@@ -661,11 +671,13 @@ static int __devinit cpuup_callback(stru
 		up(&cache_chain_sem);
 		break;
 	case CPU_ONLINE:
+		start_reap_thread(cpu);
 		start_cpu_timer(cpu);
 		break;
 #ifdef CONFIG_HOTPLUG_CPU
 	case CPU_DEAD:
 		stop_cpu_timer(cpu);
+		stop_reap_thread(cpu);
 		/* fall thru */
 	case CPU_UP_CANCELED:
 		down(&cache_chain_sem);
@@ -802,6 +814,9 @@ void __init kmem_cache_init(void)
 		up(&cache_chain_sem);
 	}
 
+	/* Initialize to run cache_reap as a timer on all cpus. */
+	cpus_clear(threaded_reap);
+
 	/* Done! */
 	g_cpucache_up = FULL;
 
@@ -2762,6 +2777,63 @@ next:
 	up(&cache_chain_sem);
 }
 
+/**
+ * If cache reap is run in thread mode, we run it from here.
+ */
+static int reap_thread(void * data)
+{
+	set_current_state(TASK_INTERRUPTIBLE);
+	while (!kthread_should_stop()) {
+		cache_reap();
+		schedule();
+		set_current_state(TASK_INTERRUPTIBLE);
+	}
+	__set_current_state(TASK_RUNNING);
+	return 0;
+}
+
+/**
+ * If the cpu is configured to run in thread mode, start the reap
+ * thread here.
+ */
+static void start_reap_thread(unsigned long cpu)
+{
+	task_t * p;
+	task_t ** rthread = &per_cpu(reap_thread, cpu);
+	struct sched_param param;
+
+	if (!cpu_isset(cpu, threaded_reap)) {
+		*rthread = NULL;
+		return;
+	}
+
+	param.sched_priority = sys_sched_get_priority_min(SCHED_FIFO); 
+
+	p = kthread_create(reap_thread, NULL, "cache_reap/%d",cpu);
+	if (IS_ERR(p))
+		return;
+	*rthread = p;
+	kthread_bind(p, cpu);
+	sys_sched_setscheduler(p->pid, SCHED_FIFO, &param);
+	wake_up_process(p);
+}
+
+/**
+ * If the cpu is running a reap thread, stop it here.
+ */
+#ifdef CONFIG_HOTPLUG_CPU
+static void stop_reap_thread(unsigned long cpu)
+{
+	task_t ** rthread = &per_cpu(reap_thread, cpu);
+
+	if (*rthread != NULL) {
+		kthread_stop(*rthread);
+		*rthread = NULL;
+	}
+
+}
+#endif
+
 /*
  * This is a timer handler.  There is one per CPU.  It is called periodially
  * to shrink this CPU's caches.  Otherwise there could be memory tied up
@@ -2770,10 +2842,16 @@ next:
 static void reap_timer_fnc(unsigned long cpu)
 {
 	struct timer_list *rt = &__get_cpu_var(reap_timers);
+	task_t *rthread = __get_cpu_var(reap_thread);
 
 	/* CPU hotplug can drag us off cpu: don't run on wrong CPU */
 	if (!cpu_is_offline(cpu)) {
-		cache_reap();
+		/* If we're not running in thread mode, simply run cache reap */
+		if (likely(rthread == NULL)) {
+			cache_reap();
+		} else {
+			wake_up_process(rthread);
+		}
 		mod_timer(rt, jiffies + REAPTIMEOUT_CPUC + cpu);
 	}
 }
