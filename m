Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266321AbUANOa4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 09:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266322AbUANOa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 09:30:56 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:36321 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S266321AbUANOar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 09:30:47 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16389.21138.564775.207535@gargle.gargle.HOWL>
Date: Wed, 14 Jan 2004 09:30:42 -0500
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@sgi.com>
Subject: [patch] 2.6.1-mm3 quiet down SMP boot messages
X-Mailer: VM 7.03 under Emacs 21.2.1
From: Jes Sorensen <jes@trained-monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'd like to propose the following for 2.6.1-mm/2.6.2. On systems with a
large number of CPUs the number of printk's flowing by for each CPU
booting starts becoming a real console hog.

The following patch eliminates a couple of them (already sent a patch to
David for the ia64 specific ones) as well as changes the 
"Building zonelist : X" in "Built Y zonelists". IMHO it doesn't make any
sense to print for each zonelist since it's run in a for loop running
from 0 to Y-1 anyway.

The patch nukes a few new printk's that were introduced with the
scheduler changes to the NUMA code in -mm3, if these are still needed
then I won't fight for that part of the patch.

Cheers,
Jes

diff -urN -X /usr/people/jes/exclude-linux --exclude=acpi --exclude=ia64 orig/linux-2.6.1-mm3-boot/init/main.c linux-2.6.1-mm3/init/main.c
--- orig/linux-2.6.1-mm3-boot/init/main.c	Wed Jan 14 02:59:53 2004
+++ linux-2.6.1-mm3/init/main.c	Wed Jan 14 05:34:20 2004
@@ -346,13 +346,11 @@
 		if (num_online_cpus() >= max_cpus)
 			break;
 		if (cpu_possible(i) && !cpu_online(i)) {
-			printk("Bringing up %i\n", i);
 			cpu_up(i);
 		}
 	}
 
 	/* Any cleanup work */
-	printk("CPUS done %u\n", max_cpus);
 	smp_cpus_done(max_cpus);
 #if 0
 	/* Get other processors into their bootup holding patterns. */
diff -urN -X /usr/people/jes/exclude-linux --exclude=acpi --exclude=ia64 orig/linux-2.6.1-mm3-boot/kernel/cpu.c linux-2.6.1-mm3/kernel/cpu.c
--- orig/linux-2.6.1-mm3-boot/kernel/cpu.c	Wed Dec 17 18:59:35 2003
+++ linux-2.6.1-mm3/kernel/cpu.c	Wed Jan 14 05:34:45 2004
@@ -55,7 +55,6 @@
 		BUG();
 
 	/* Now call notifier in preparation. */
-	printk("CPU %u IS NOW UP!\n", cpu);
 	notifier_call_chain(&cpu_chain, CPU_ONLINE, hcpu);
 
 out_notify:
diff -urN -X /usr/people/jes/exclude-linux --exclude=acpi --exclude=ia64 orig/linux-2.6.1-mm3-boot/kernel/sched.c linux-2.6.1-mm3/kernel/sched.c
--- orig/linux-2.6.1-mm3-boot/kernel/sched.c	Wed Jan 14 03:18:28 2004
+++ linux-2.6.1-mm3/kernel/sched.c	Wed Jan 14 05:35:03 2004
@@ -3242,8 +3242,6 @@
 		if (cpus_empty(nodemask))
 			continue;
 
-		printk(KERN_INFO "NODE%d\n", i);
-
 		node->cpumask = nodemask;
 
 		for_each_cpu_mask(j, node->cpumask) {
@@ -3252,8 +3250,6 @@
 			cpus_clear(cpu->cpumask);
 			cpu_set(j, cpu->cpumask);
 
-			printk(KERN_INFO "CPU%d\n", j);
-
 			if (!first_cpu)
 				first_cpu = cpu;
 			if (last_cpu)
diff -urN -X /usr/people/jes/exclude-linux --exclude=acpi --exclude=ia64 orig/linux-2.6.1-mm3-boot/mm/page_alloc.c linux-2.6.1-mm3/mm/page_alloc.c
--- orig/linux-2.6.1-mm3-boot/mm/page_alloc.c	Wed Jan 14 02:59:53 2004
+++ linux-2.6.1-mm3/mm/page_alloc.c	Wed Jan 14 05:54:32 2004
@@ -1080,7 +1080,6 @@
 	int i, j, k, node, local_node;
 
 	local_node = pgdat->node_id;
-	printk("Building zonelist for node : %d\n", local_node);
 	for (i = 0; i < MAX_NR_ZONES; i++) {
 		struct zonelist *zonelist;
 
@@ -1118,6 +1117,7 @@
 
 	for(i = 0 ; i < numnodes ; i++)
 		build_zonelists(NODE_DATA(i));
+	printk("Built %i zonelists\n", numnodes);
 }
 
 /*
