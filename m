Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266941AbUAXONr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 09:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266942AbUAXONr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 09:13:47 -0500
Received: from dp.samba.org ([66.70.73.150]:23474 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266941AbUAXONn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 09:13:43 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Use CPU_UP_PREPARE properly
Date: Sun, 25 Jan 2004 01:11:46 +1100
Message-Id: <20040124141358.6EC382C016@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

The cpu hotplug code actually provides two notifiers: CPU_UP_PREPARE
which preceeds the online and can fail, and CPU_ONLINE which can't.

Current usage is only done at boot, so this distinction doesn't
matter, but it's a bad example to set.  This also means that the
migration threads do not have to be higher priority than the
others, since they are ready to go before any CPU_ONLINE callbacks
are done.

This patch is experimental but fairly straight foward: I haven't been
able to test it since extracting it from the hotplug cpu code, so it's
possible I screwed something up.

Name: Use CPU_UP_PREPARE notifier in sched.c and softirq.c
Author: Rusty Russell
Status: Experimental
Depends: Hotcpu/use-kthread-simple.patch.gz

D: The cpu hotplug code actually provides two notifiers: CPU_UP_PREPARE
D: which preceeds the online and can fail, and CPU_ONLINE which can't.
D: 
D: Current usage is only done at boot, so this distinction doesn't
D: matter, but it's a bad example to set.  This also means that the
D: migration threads do not have to be higher priority than the
D: others, since they are ready to go before any CPU_ONLINE callbacks
D: are done.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .19555-linux-2.6.2-rc1-bk1/kernel/sched.c .19555-linux-2.6.2-rc1-bk1.updated/kernel/sched.c
--- .19555-linux-2.6.2-rc1-bk1/kernel/sched.c	2004-01-24 18:54:51.000000000 +1100
+++ .19555-linux-2.6.2-rc1-bk1.updated/kernel/sched.c	2004-01-24 18:54:52.000000000 +1100
@@ -2803,29 +2803,36 @@ static int migration_call(struct notifie
 	struct task_struct *p;
 
 	switch (action) {
-	case CPU_ONLINE:
+	case CPU_UP_PREPARE:
 		p = kthread_create(migration_thread, hcpu, "migration/%d",cpu);
 		if (IS_ERR(p))
 			return NOTIFY_BAD;
 		kthread_bind(p, cpu);
 		cpu_rq(cpu)->migration_thread = p;
-		wake_up_process(p);
 		break;
+
+	case CPU_ONLINE:
+		/* Strictly unneccessary, as first user will wake it. */
+		wake_up_process(cpu_rq(cpu)->migration_thread);
+		break;
+
 	}
 	return NOTIFY_OK;
 }
 
-/* Want this before the other threads, so they can use set_cpus_allowed. */
+/* Want this after the other threads, so they can use set_cpus_allowed
+ * from their CPU_OFFLINE callback. */
 static struct notifier_block __devinitdata migration_notifier = { 
 	.notifier_call = migration_call,
-	.priority = 10,
+	.priority = -10,
 };
 
 __init int migration_init(void)
 {
+	void *cpu = (void *)(long)smp_processor_id();
 	/* Start one for boot CPU. */
-	migration_call(&migration_notifier, CPU_ONLINE,
-		       (void *)(long)smp_processor_id());
+	migration_call(&migration_notifier, CPU_UP_PREPARE, cpu);
+	migration_call(&migration_notifier, CPU_ONLINE, cpu);
 	register_cpu_notifier(&migration_notifier);
 	return 0;
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .19555-linux-2.6.2-rc1-bk1/kernel/softirq.c .19555-linux-2.6.2-rc1-bk1.updated/kernel/softirq.c
--- .19555-linux-2.6.2-rc1-bk1/kernel/softirq.c	2004-01-24 18:54:51.000000000 +1100
+++ .19555-linux-2.6.2-rc1-bk1.updated/kernel/softirq.c	2004-01-24 18:54:52.000000000 +1100
@@ -367,8 +367,11 @@ static int __devinit cpu_callback(struct
 {
 	int hotcpu = (unsigned long)hcpu;
 	struct task_struct *p;
-
-	if (action == CPU_ONLINE) {
+  
+	switch (action) {
+	case CPU_UP_PREPARE:
+		BUG_ON(per_cpu(tasklet_vec, hotcpu).list);
+		BUG_ON(per_cpu(tasklet_hi_vec, hotcpu).list);
 		p = kthread_create(ksoftirqd, hcpu, "ksoftirqd/%d", hotcpu);
 		if (IS_ERR(p)) {
 			printk("ksoftirqd for %i failed\n", hotcpu);
@@ -376,7 +379,11 @@ static int __devinit cpu_callback(struct
 		}
 		per_cpu(ksoftirqd, hotcpu) = p;
 		kthread_bind(p, hotcpu);
-		wake_up_process(p);
+  		per_cpu(ksoftirqd, hotcpu) = p;
+ 		break;
+	case CPU_ONLINE:
+		wake_up_process(per_cpu(ksoftirqd, hotcpu));
+		break;
  	}
 	return NOTIFY_OK;
 }
@@ -387,7 +394,9 @@ static struct notifier_block __devinitda
 
 __init int spawn_ksoftirqd(void)
 {
-	cpu_callback(&cpu_nfb, CPU_ONLINE, (void *)(long)smp_processor_id());
+	void *cpu = (void *)(long)smp_processor_id();
+	cpu_callback(&cpu_nfb, CPU_UP_PREPARE, cpu);
+	cpu_callback(&cpu_nfb, CPU_ONLINE, cpu);
 	register_cpu_notifier(&cpu_nfb);
 	return 0;
 }
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
