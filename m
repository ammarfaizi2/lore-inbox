Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266931AbUAXMVB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 07:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266922AbUAXMTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 07:19:37 -0500
Received: from dp.samba.org ([66.70.73.150]:23203 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266927AbUAXMSy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 07:18:54 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove More Unneccessary CPU Notifiers
Date: Sat, 24 Jan 2004 23:16:22 +1100
Message-Id: <20040124121909.93C8F2C222@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Three more removed CPU notifiers extracted from the hotplug CPU patch.

kernel/softirq.c: the tasklet cpu prepration callback is useless:
the vectors are already initialized to NULL.  Even with the hotplug
CPU patches, they're of little or no use.

fs/buffer.c: once again, they are already initialized to zero.

mm/page_alloc.c: once again, already initialized to zero.

Name: Useless CPU Notifier Removals: softirq.c, buffer.c, page_alloc.c
Author: Rusty Russell
Status: Experimental

D: kernel/softirq.c: the tasklet cpu prepration callback is useless:
D: the vectors are already initialized to NULL.  Even with the hotplug
D: CPU patches, they're of little or no use.
D: 
D: fs/buffer.c: once again, they are already initialized to zero.
D: 
D: mm/page_alloc.c: once again, already initialized to zero.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21256-linux-2.6.2-rc1-bk1/fs/buffer.c .21256-linux-2.6.2-rc1-bk1.updated/fs/buffer.c
--- .21256-linux-2.6.2-rc1-bk1/fs/buffer.c	2004-01-21 16:18:57.000000000 +1100
+++ .21256-linux-2.6.2-rc1-bk1.updated/fs/buffer.c	2004-01-24 19:12:58.000000000 +1100
@@ -2987,33 +2987,6 @@ init_buffer_head(void *data, kmem_cache_
 	}
 }
 
-static void buffer_init_cpu(int cpu)
-{
-	struct bh_accounting *bha = &per_cpu(bh_accounting, cpu);
-	struct bh_lru *bhl = &per_cpu(bh_lrus, cpu);
-
-	bha->nr = 0;
-	bha->ratelimit = 0;
-	memset(bhl, 0, sizeof(*bhl));
-}
-	
-static int __devinit buffer_cpu_notify(struct notifier_block *self, 
-				unsigned long action, void *hcpu)
-{
-	long cpu = (long)hcpu;
-	switch(action) {
-	case CPU_UP_PREPARE:
-		buffer_init_cpu(cpu);
-		break;
-	default:
-		break;
-	}
-	return NOTIFY_OK;
-}
-
-static struct notifier_block __devinitdata buffer_nb = {
-	.notifier_call	= buffer_cpu_notify,
-};
 
 void __init buffer_init(void)
 {
@@ -3031,9 +3004,6 @@ void __init buffer_init(void)
 	 */
 	nrpages = (nr_free_buffer_pages() * 10) / 100;
 	max_buffer_heads = nrpages * (PAGE_SIZE / sizeof(struct buffer_head));
-	buffer_cpu_notify(&buffer_nb, (unsigned long)CPU_UP_PREPARE,
-				(void *)(long)smp_processor_id());
-	register_cpu_notifier(&buffer_nb);
 }
 
 EXPORT_SYMBOL(__bforget);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21256-linux-2.6.2-rc1-bk1/kernel/softirq.c .21256-linux-2.6.2-rc1-bk1.updated/kernel/softirq.c
--- .21256-linux-2.6.2-rc1-bk1/kernel/softirq.c	2003-10-09 18:03:02.000000000 +1000
+++ .21256-linux-2.6.2-rc1-bk1.updated/kernel/softirq.c	2004-01-24 19:12:58.000000000 +1100
@@ -299,38 +299,10 @@ void tasklet_kill(struct tasklet_struct 
 
 EXPORT_SYMBOL(tasklet_kill);
 
-static void tasklet_init_cpu(int cpu)
-{
-	per_cpu(tasklet_vec, cpu).list = NULL;
-	per_cpu(tasklet_hi_vec, cpu).list = NULL;
-}
-	
-static int tasklet_cpu_notify(struct notifier_block *self, 
-				unsigned long action, void *hcpu)
-{
-	long cpu = (long)hcpu;
-	switch(action) {
-	case CPU_UP_PREPARE:
-		tasklet_init_cpu(cpu);
-		break;
-	default:
-		break;
-	}
-	return 0;
-}
-
-static struct notifier_block tasklet_nb = {
-	.notifier_call	= tasklet_cpu_notify,
-	.next		= NULL,
-};
-
 void __init softirq_init(void)
 {
 	open_softirq(TASKLET_SOFTIRQ, tasklet_action, NULL);
 	open_softirq(HI_SOFTIRQ, tasklet_hi_action, NULL);
-	tasklet_cpu_notify(&tasklet_nb, (unsigned long)CPU_UP_PREPARE,
-				(void *)(long)smp_processor_id());
-	register_cpu_notifier(&tasklet_nb);
 }
 
 static int ksoftirqd(void * __bind_cpu)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21256-linux-2.6.2-rc1-bk1/mm/page_alloc.c .21256-linux-2.6.2-rc1-bk1.updated/mm/page_alloc.c
--- .21256-linux-2.6.2-rc1-bk1/mm/page_alloc.c	2004-01-21 16:19:09.000000000 +1100
+++ .21256-linux-2.6.2-rc1-bk1.updated/mm/page_alloc.c	2004-01-24 19:12:58.000000000 +1100
@@ -1558,34 +1558,9 @@ struct seq_operations vmstat_op = {
 
 #endif /* CONFIG_PROC_FS */
 
-static void __devinit init_page_alloc_cpu(int cpu)
-{
-	struct page_state *ps = &per_cpu(page_states, cpu);
-	memset(ps, 0, sizeof(*ps));
-}
-	
-static int __devinit page_alloc_cpu_notify(struct notifier_block *self, 
-				unsigned long action, void *hcpu)
-{
-	int cpu = (unsigned long)hcpu;
-	switch(action) {
-	case CPU_UP_PREPARE:
-		init_page_alloc_cpu(cpu);
-		break;
-	default:
-		break;
-	}
-	return NOTIFY_OK;
-}
-
-static struct notifier_block __devinitdata page_alloc_nb = {
-	.notifier_call	= page_alloc_cpu_notify,
-};
 
 void __init page_alloc_init(void)
 {
-	init_page_alloc_cpu(smp_processor_id());
-	register_cpu_notifier(&page_alloc_nb);
 }
 
 /*

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
