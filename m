Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266540AbUA3Fzb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 00:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266547AbUA3Fzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 00:55:31 -0500
Received: from dp.samba.org ([66.70.73.150]:42631 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266540AbUA3Fy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 00:54:56 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: [PATCH 1/2] lock_cpu_hotplug only if CONFIG_CPU_HOTPLUG
Date: Fri, 30 Jan 2004 16:33:34 +1100
Message-Id: <20040130055510.ED9AC2C107@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The cpucontrol mutex is not required when no cpus can go up and down.
Andrew wrote a wrapper for it to avoid #ifdefs, this expands that to
only be defined for CONFIG_HOTPLUG_CPU, and uses it everywhere.

The only downside is that the cpucontrol lock was overloaded by my
recent patch to net/core/flow.c to protect it from reentrance, so
this reintroduces the local flow_flush_sem.  This code isn't speed
critical, so taking two locks when CONFIG_HOTPLUG_CPU=y is not really
an issue.

Name: lock_cpu_hotplug/unlock_cpu_hotplug Macros only if CONFIG_HOTPLUG_CPU
Author: Andrew Morton, Rusty Russell
Status: Booted on 2.6.2-rc2-bk2
Depends: 

D: The cpucontrol mutex is not required when no cpus can go up and down.
D: Andrew wrote a wrapper for it to avoid #ifdefs, this expands that to
D: only be defined for CONFIG_HOTPLUG_CPU, and uses it everywhere.
D: 
D: The only downside is that the cpucontrol lock was overloaded by my
D: recent patch to net/core/flow.c to protect it from reentrance, so
D: this reintroduces the local flow_flush_sem.  This code isn't speed
D: critical, so taking two locks when CONFIG_HOTPLUG_CPU=y is not really
D: an issue.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31749-linux-2.6.2-rc1-bk1/include/linux/cpu.h .31749-linux-2.6.2-rc1-bk1.updated/include/linux/cpu.h
--- .31749-linux-2.6.2-rc1-bk1/include/linux/cpu.h	2004-01-25 01:25:08.000000000 +1100
+++ .31749-linux-2.6.2-rc1-bk1.updated/include/linux/cpu.h	2004-01-25 01:25:46.000000000 +1100
@@ -38,9 +38,6 @@ extern void unregister_cpu_notifier(stru
 
 int cpu_up(unsigned int cpu);
 
-#define lock_cpu_hotplug()	down(&cpucontrol)
-#define unlock_cpu_hotplug()	up(&cpucontrol)
-
 #else
 
 static inline int register_cpu_notifier(struct notifier_block *nb)
@@ -51,12 +48,17 @@ static inline void unregister_cpu_notifi
 {
 }
 
-#define lock_cpu_hotplug()	do { } while (0)
-#define unlock_cpu_hotplug()		do { } while (0)
-
 #endif /* CONFIG_SMP */
 extern struct sysdev_class cpu_sysdev_class;
 
+#ifdef CONFIG_HOTPLUG_CPU
 /* Stop CPUs going up and down. */
 extern struct semaphore cpucontrol;
+#define lock_cpu_hotplug()	down(&cpucontrol)
+#define unlock_cpu_hotplug()	up(&cpucontrol)
+#else
+#define lock_cpu_hotplug()	do { } while (0)
+#define unlock_cpu_hotplug()	do { } while (0)
+#endif
+
 #endif /* _LINUX_CPU_H_ */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31749-linux-2.6.2-rc1-bk1/kernel/module.c .31749-linux-2.6.2-rc1-bk1.updated/kernel/module.c
--- .31749-linux-2.6.2-rc1-bk1/kernel/module.c	2004-01-21 16:19:08.000000000 +1100
+++ .31749-linux-2.6.2-rc1-bk1.updated/kernel/module.c	2004-01-25 01:25:14.000000000 +1100
@@ -554,7 +554,7 @@ static int stop_refcounts(void)
 	stopref_state = STOPREF_WAIT;
 
 	/* No CPUs can come up or down during this. */
-	down(&cpucontrol);
+	lock_cpu_hotplug();
 
 	for (i = 0; i < NR_CPUS; i++) {
 		if (i == cpu || !cpu_online(i))
@@ -572,7 +572,7 @@ static int stop_refcounts(void)
 	/* If some failed, kill them all. */
 	if (ret < 0) {
 		stopref_set_state(STOPREF_EXIT, 1);
-		up(&cpucontrol);
+		unlock_cpu_hotplug();
 		return ret;
 	}
 
@@ -595,7 +595,7 @@ static void restart_refcounts(void)
 	stopref_set_state(STOPREF_EXIT, 0);
 	local_irq_enable();
 	preempt_enable();
-	up(&cpucontrol);
+	unlock_cpu_hotplug();
 }
 #else /* ...!SMP */
 static inline int stop_refcounts(void)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31749-linux-2.6.2-rc1-bk1/net/core/flow.c .31749-linux-2.6.2-rc1-bk1.updated/net/core/flow.c
--- .31749-linux-2.6.2-rc1-bk1/net/core/flow.c	2004-01-25 01:25:08.000000000 +1100
+++ .31749-linux-2.6.2-rc1-bk1.updated/net/core/flow.c	2004-01-25 01:25:14.000000000 +1100
@@ -283,10 +283,11 @@ static void flow_cache_flush_per_cpu(voi
 void flow_cache_flush(void)
 {
 	struct flow_flush_info info;
+	static DECLARE_MUTEX(flow_flush_sem);
 
-	/* Don't want cpus going down or up during this, also protects
-	 * against multiple callers. */
+	/* Don't want cpus going down or up during this. */
 	lock_cpu_hotplug();
+	down(&flow_flush_sem);
 	atomic_set(&info.cpuleft, num_online_cpus());
 	init_completion(&info.completion);
 
@@ -296,6 +297,7 @@ void flow_cache_flush(void)
 	local_bh_enable();
 
 	wait_for_completion(&info.completion);
+	up(&flow_flush_sem);
 	unlock_cpu_hotplug();
 }
 

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
