Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751391AbWEIFgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbWEIFgG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 01:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbWEIFgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 01:36:06 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:47004 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751391AbWEIFgF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 01:36:05 -0400
Date: Mon, 8 May 2006 22:35:12 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Add SYSTEM_BOOTING_KMALLOC_AVAIL system_state
Message-ID: <20060509053512.GA20073@monkey.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few places that check the system_state variable to
determine if they should use the bootmem or kmalloc allocator.
However, this is not accurate as system_state transitions from
SYSTEM_BOOTING to SYSTEM_RUNNING well after the bootmem allocator
is no longer usable.  Introduce the SYSTEM_BOOTING_KMALLOC_AVAIL
state which indicates the kmalloc allocator is available for use.

Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>

diff -Naupr linux-2.6.17-rc3-mm1/arch/arm/kernel/setup.c linux-2.6.17-rc3-mm1.work/arch/arm/kernel/setup.c
--- linux-2.6.17-rc3-mm1/arch/arm/kernel/setup.c	2006-05-09 03:17:57.000000000 +0000
+++ linux-2.6.17-rc3-mm1.work/arch/arm/kernel/setup.c	2006-05-09 04:22:12.000000000 +0000
@@ -378,7 +378,7 @@ void cpu_init(void)
 		BUG();
 	}
 
-	if (system_state == SYSTEM_BOOTING)
+	if (system_state < SYSTEM_RUNNING)
 		dump_cpu_info(cpu);
 
 	/*
diff -Naupr linux-2.6.17-rc3-mm1/arch/powerpc/kernel/smp.c linux-2.6.17-rc3-mm1.work/arch/powerpc/kernel/smp.c
--- linux-2.6.17-rc3-mm1/arch/powerpc/kernel/smp.c	2006-04-27 02:19:25.000000000 +0000
+++ linux-2.6.17-rc3-mm1.work/arch/powerpc/kernel/smp.c	2006-05-09 04:25:28.000000000 +0000
@@ -540,7 +540,7 @@ int __devinit start_secondary(void *unus
 	if (smp_ops->take_timebase)
 		smp_ops->take_timebase();
 
-	if (system_state > SYSTEM_BOOTING)
+	if (system_state >= SYSTEM_RUNNING)
 		snapshot_timebase();
 
 	spin_lock(&call_lock);
diff -Naupr linux-2.6.17-rc3-mm1/include/linux/kernel.h linux-2.6.17-rc3-mm1.work/include/linux/kernel.h
--- linux-2.6.17-rc3-mm1/include/linux/kernel.h	2006-05-09 03:18:05.000000000 +0000
+++ linux-2.6.17-rc3-mm1.work/include/linux/kernel.h	2006-05-09 04:33:12.000000000 +0000
@@ -189,6 +189,7 @@ extern void add_taint(unsigned);
 /* Values used for system_state */
 extern enum system_states {
 	SYSTEM_BOOTING,
+	SYSTEM_BOOTING_KMALLOC_AVAIL,
 	SYSTEM_RUNNING,
 	SYSTEM_HALT,
 	SYSTEM_POWER_OFF,
diff -Naupr linux-2.6.17-rc3-mm1/init/main.c linux-2.6.17-rc3-mm1.work/init/main.c
--- linux-2.6.17-rc3-mm1/init/main.c	2006-05-09 03:18:05.000000000 +0000
+++ linux-2.6.17-rc3-mm1.work/init/main.c	2006-05-09 04:59:03.000000000 +0000
@@ -513,6 +513,7 @@ asmlinkage void __init start_kernel(void
 	cpuset_init_early();
 	mem_init();
 	kmem_cache_init();
+	system_state = SYSTEM_BOOTING_KMALLOC_AVAIL;
 	setup_per_cpu_pageset();
 	numa_policy_init();
 	if (late_time_init)
diff -Naupr linux-2.6.17-rc3-mm1/kernel/sched.c linux-2.6.17-rc3-mm1.work/kernel/sched.c
--- linux-2.6.17-rc3-mm1/kernel/sched.c	2006-05-09 03:18:05.000000000 +0000
+++ linux-2.6.17-rc3-mm1.work/kernel/sched.c	2006-05-09 04:28:15.000000000 +0000
@@ -5917,7 +5917,7 @@ static void calibrate_migration_costs(co
 			-1
 #endif
 		);
-	if (system_state == SYSTEM_BOOTING) {
+	if (system_state < SYSTEM_RUNNING) {
 		printk("migration_cost=");
 		for (distance = 0; distance <= max_distance; distance++) {
 			if (distance)
diff -Naupr linux-2.6.17-rc3-mm1/kernel/sys.c linux-2.6.17-rc3-mm1.work/kernel/sys.c
--- linux-2.6.17-rc3-mm1/kernel/sys.c	2006-05-09 03:18:05.000000000 +0000
+++ linux-2.6.17-rc3-mm1.work/kernel/sys.c	2006-05-09 04:27:15.000000000 +0000
@@ -259,7 +259,7 @@ int blocking_notifier_chain_register(str
 	 * not yet working and interrupts must remain disabled.  At
 	 * such times we must not call down_write().
 	 */
-	if (unlikely(system_state == SYSTEM_BOOTING))
+	if (unlikely(system_state < SYSTEM_RUNNING))
 		return notifier_chain_register(&nh->head, n);
 
 	down_write(&nh->rwsem);
@@ -290,7 +290,7 @@ int blocking_notifier_chain_unregister(s
 	 * not yet working and interrupts must remain disabled.  At
 	 * such times we must not call down_write().
 	 */
-	if (unlikely(system_state == SYSTEM_BOOTING))
+	if (unlikely(system_state < SYSTEM_RUNNING))
 		return notifier_chain_unregister(&nh->head, n);
 
 	down_write(&nh->rwsem);
diff -Naupr linux-2.6.17-rc3-mm1/mm/page_alloc.c linux-2.6.17-rc3-mm1.work/mm/page_alloc.c
--- linux-2.6.17-rc3-mm1/mm/page_alloc.c	2006-05-09 03:18:05.000000000 +0000
+++ linux-2.6.17-rc3-mm1.work/mm/page_alloc.c	2006-05-09 05:31:33.000000000 +0000
@@ -1782,7 +1782,7 @@ static int __meminit __build_all_zonelis
 
 void __meminit build_all_zonelists(void)
 {
-	if (system_state == SYSTEM_BOOTING) {
+	if (system_state < SYSTEM_RUNNING) {
 		__build_all_zonelists(0);
 		cpuset_init_current_mems_allowed();
 	} else {
@@ -2136,7 +2136,7 @@ int zone_wait_table_init(struct zone *zo
 	alloc_size = zone->wait_table_hash_nr_entries
 					* sizeof(wait_queue_head_t);
 
- 	if (system_state == SYSTEM_BOOTING) {
+ 	if (system_state < SYSTEM_RUNNING) {
 		zone->wait_table = (wait_queue_head_t *)
 			alloc_bootmem_node(pgdat, alloc_size);
 	} else {
diff -Naupr linux-2.6.17-rc3-mm1/mm/sparse.c linux-2.6.17-rc3-mm1.work/mm/sparse.c
--- linux-2.6.17-rc3-mm1/mm/sparse.c	2006-05-09 03:18:05.000000000 +0000
+++ linux-2.6.17-rc3-mm1.work/mm/sparse.c	2006-05-09 04:29:56.000000000 +0000
@@ -32,7 +32,7 @@ static struct mem_section *sparse_index_
 	unsigned long array_size = SECTIONS_PER_ROOT *
 				   sizeof(struct mem_section);
 
-	if (system_state == SYSTEM_RUNNING)
+	if (system_state >= SYSTEM_BOOTING_KMALLOC_AVAIL)
 		section = kmalloc_node(array_size, GFP_KERNEL, nid);
 	else
 		section = alloc_bootmem_node(NODE_DATA(nid), array_size);
diff -Naupr linux-2.6.17-rc3-mm1/mm/vmscan.c linux-2.6.17-rc3-mm1.work/mm/vmscan.c
--- linux-2.6.17-rc3-mm1/mm/vmscan.c	2006-05-09 03:18:05.000000000 +0000
+++ linux-2.6.17-rc3-mm1.work/mm/vmscan.c	2006-05-09 04:29:00.000000000 +0000
@@ -1477,7 +1477,7 @@ int kswapd_run(int nid)
 	pgdat->kswapd = kthread_run(kswapd, pgdat, "kswapd%d", nid);
 	if (IS_ERR(pgdat->kswapd)) {
 		/* failure at boot is fatal */
-		BUG_ON(system_state == SYSTEM_BOOTING);
+		BUG_ON(system_state < SYSTEM_RUNNING);
 		printk("Failed to start kswapd on node %d\n",nid);
 		ret = -1;
 	}
