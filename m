Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266007AbUAVIXQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 03:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266006AbUAVIXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 03:23:15 -0500
Received: from dp.samba.org ([66.70.73.150]:41913 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265983AbUAVIWs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 03:22:48 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: davem@redhat.com, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Simplify net/flow.c
Date: Thu, 22 Jan 2004 18:49:37 +1100
Message-Id: <20040122082303.3B1BC2C18C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

	I still have this cleanup sitting around, and frankly it gets
in the way for the hotplug CPU code.  It works fine here, and is
basically trivial, but I'm happy to put it in -mm first for wider
testing if you want?

Thanks,
Rusty.

Name: Simplify CPU Handling in net/core/flow.c
Author: Rusty Russell
Status: Booted on 2.6.0-test9-bk6

D: The cpu handling in net/core/flow.c is complex: it tries to allocate
D: flow cache as each CPU comes up.  It might as well allocate them for
D: each possible CPU at boot.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16782-linux-2.6.1-bk5/net/core/flow.c .16782-linux-2.6.1-bk5.updated/net/core/flow.c
--- .16782-linux-2.6.1-bk5/net/core/flow.c	2003-11-24 15:42:33.000000000 +1100
+++ .16782-linux-2.6.1-bk5.updated/net/core/flow.c	2004-01-20 17:54:01.000000000 +1100
@@ -66,24 +66,18 @@ static struct timer_list flow_hash_rnd_t
 
 struct flow_flush_info {
 	atomic_t cpuleft;
-	cpumask_t cpumap;
 	struct completion completion;
 };
 static DEFINE_PER_CPU(struct tasklet_struct, flow_flush_tasklets) = { NULL };
 
 #define flow_flush_tasklet(cpu) (&per_cpu(flow_flush_tasklets, cpu))
 
-static DECLARE_MUTEX(flow_cache_cpu_sem);
-static cpumask_t flow_cache_cpu_map;
-static unsigned int flow_cache_cpu_count;
-
 static void flow_cache_new_hashrnd(unsigned long arg)
 {
 	int i;
 
-	for (i = 0; i < NR_CPUS; i++)
-		if (cpu_isset(i, flow_cache_cpu_map))
-			flow_hash_rnd_recalc(i) = 1;
+	for_each_cpu(i)
+		flow_hash_rnd_recalc(i) = 1;
 
 	flow_hash_rnd_timer.expires = jiffies + FLOW_HASH_RND_PERIOD;
 	add_timer(&flow_hash_rnd_timer);
@@ -179,7 +173,9 @@ void *flow_cache_lookup(struct flowi *ke
 	cpu = smp_processor_id();
 
 	fle = NULL;
-	if (!cpu_isset(cpu, flow_cache_cpu_map))
+	/* Packet really early in init?  Making flow_cache_init a
+	 * pre-smp initcall would solve this.  --RR */
+	if (!flow_table(cpu))
 		goto nocache;
 
 	if (flow_hash_rnd_recalc(cpu))
@@ -278,8 +274,6 @@ static void flow_cache_flush_per_cpu(voi
 	struct tasklet_struct *tasklet;
 
 	cpu = smp_processor_id();
-	if (!cpu_isset(cpu, info->cpumap))
-		return;
 
 	tasklet = flow_flush_tasklet(cpu);
 	tasklet->data = (unsigned long)info;
@@ -289,29 +283,23 @@ static void flow_cache_flush_per_cpu(voi
 void flow_cache_flush(void)
 {
 	struct flow_flush_info info;
-	static DECLARE_MUTEX(flow_flush_sem);
-
-	down(&flow_cache_cpu_sem);
-	info.cpumap = flow_cache_cpu_map;
-	atomic_set(&info.cpuleft, flow_cache_cpu_count);
-	up(&flow_cache_cpu_sem);
 
+	/* Don't want cpus going down or up during this, also protects
+	 * against multiple callers. */
+	down(&cpucontrol);
+	atomic_set(&info.cpuleft, num_online_cpus());
 	init_completion(&info.completion);
 
-	down(&flow_flush_sem);
-
 	local_bh_disable();
 	smp_call_function(flow_cache_flush_per_cpu, &info, 1, 0);
-	if (cpu_isset(smp_processor_id(), info.cpumap))
-		flow_cache_flush_tasklet((unsigned long)&info);
+	flow_cache_flush_tasklet((unsigned long)&info);
 	local_bh_enable();
 
 	wait_for_completion(&info.completion);
-
-	up(&flow_flush_sem);
+	up(&cpucontrol);
 }
 
-static int __devinit flow_cache_cpu_prepare(int cpu)
+static void __devinit flow_cache_cpu_prepare(int cpu)
 {
 	struct tasklet_struct *tasklet;
 	unsigned long order;
@@ -324,9 +312,8 @@ static int __devinit flow_cache_cpu_prep
 
 	flow_table(cpu) = (struct flow_cache_entry **)
 		__get_free_pages(GFP_KERNEL, order);
-
 	if (!flow_table(cpu))
-		return NOTIFY_BAD;
+		panic("NET: failed to allocate flow cache order %lu\n", order);
 
 	memset(flow_table(cpu), 0, PAGE_SIZE << order);
 
@@ -335,39 +322,8 @@ static int __devinit flow_cache_cpu_prep
 
 	tasklet = flow_flush_tasklet(cpu);
 	tasklet_init(tasklet, flow_cache_flush_tasklet, 0);
-
-	return NOTIFY_OK;
 }
 
-static int __devinit flow_cache_cpu_online(int cpu)
-{
-	down(&flow_cache_cpu_sem);
-	cpu_set(cpu, flow_cache_cpu_map);
-	flow_cache_cpu_count++;
-	up(&flow_cache_cpu_sem);
-
-	return NOTIFY_OK;
-}
-
-static int __devinit flow_cache_cpu_notify(struct notifier_block *self,
-					   unsigned long action, void *hcpu)
-{
-	unsigned long cpu = (unsigned long)cpu;
-	switch (action) {
-	case CPU_UP_PREPARE:
-		return flow_cache_cpu_prepare(cpu);
-		break;
-	case CPU_ONLINE:
-		return flow_cache_cpu_online(cpu);
-		break;
-	}
-	return NOTIFY_OK;
-}
-
-static struct notifier_block __devinitdata flow_cache_cpu_nb = {
-	.notifier_call = flow_cache_cpu_notify,
-};
-
 static int __init flow_cache_init(void)
 {
 	int i;
@@ -389,15 +345,8 @@ static int __init flow_cache_init(void)
 	flow_hash_rnd_timer.expires = jiffies + FLOW_HASH_RND_PERIOD;
 	add_timer(&flow_hash_rnd_timer);
 
-	register_cpu_notifier(&flow_cache_cpu_nb);
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_online(i))
-			continue;
-		if (flow_cache_cpu_prepare(i) == NOTIFY_OK &&
-		    flow_cache_cpu_online(i) == NOTIFY_OK)
-			continue;
-		panic("NET: failed to initialise flow cache hash table\n");
-	}
+	for_each_cpu(i)
+		flow_cache_cpu_prepare(i);
 
 	return 0;
 }

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
