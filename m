Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265994AbUAVJHP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 04:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266194AbUAVJHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 04:07:15 -0500
Received: from dp.samba.org ([66.70.73.150]:1477 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265994AbUAVJHN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 04:07:13 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove kstat cpu notifiers
Date: Thu, 22 Jan 2004 19:52:27 +1100
Message-Id: <20040122090728.814B02C242@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please take.

Some well-meaning person put a notifier in for CPUs to update the
kstat structures in sched.c.  However, it does nothing, and even
with the full hotplug CPU patch, it still does nothing.

Simple counters very rarely need anything done when CPUs come up
or go down.  If you have per-cpu caches, or per-cpu threads, you
need to do something.  But very rarely for stats.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31530-linux-2.6.1-bk6/kernel/sched.c .31530-linux-2.6.1-bk6.updated/kernel/sched.c
--- .31530-linux-2.6.1-bk6/kernel/sched.c	2004-01-21 10:02:33.000000000 +1100
+++ .31530-linux-2.6.1-bk6.updated/kernel/sched.c	2004-01-21 10:07:44.000000000 +1100
@@ -2848,45 +2999,11 @@ spinlock_t kernel_flag __cacheline_align
 EXPORT_SYMBOL(kernel_flag);
 #endif
 
-static void kstat_init_cpu(int cpu)
-{
-	/* Add any initialisation to kstat here */
-	/* Useful when cpu offlining logic is added.. */
-}
-
-static int __devinit kstat_cpu_notify(struct notifier_block *self,
-				      unsigned long action, void *hcpu)
-{
-	int cpu = (unsigned long)hcpu;
-	switch(action) {
-	case CPU_UP_PREPARE:
-		kstat_init_cpu(cpu);
-		break;
-	default:
-		break;
-	}
-	return NOTIFY_OK;
-}
-
-static struct notifier_block __devinitdata kstat_nb = {
-	.notifier_call	= kstat_cpu_notify,
-	.next		= NULL,
-};
-
-__init static void init_kstat(void)
-{
-	kstat_cpu_notify(&kstat_nb, (unsigned long)CPU_UP_PREPARE,
-			 (void *)(long)smp_processor_id());
-	register_cpu_notifier(&kstat_nb);
-}
-
 void __init sched_init(void)
 {
 	runqueue_t *rq;
 	int i, j, k;
 
-	/* Init the kstat counters */
-	init_kstat();
 	for (i = 0; i < NR_CPUS; i++) {
 		prio_array_t *array;
 

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
