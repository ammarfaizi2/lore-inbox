Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265395AbUJLPIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265395AbUJLPIA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 11:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264648AbUJLPG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 11:06:58 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:64687 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265943AbUJLPFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 11:05:09 -0400
Date: Tue, 12 Oct 2004 08:02:40 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: linux-kernel@vger.kernel.org
cc: nickpiggin@yahoo.com.au, linux-mm@kvack.org
Subject: NUMA: Patch for node based swapping
Message-ID: <Pine.LNX.4.58.0410120751010.11558@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In a NUMA systems single nodes may run out of memory. This may occur even
by only reading from files which will clutter node memory with cached
pages from the file.

However, as long as the system as a whole does have enough memory
available, kswapd is not run at all. This means that a process allocating
memory and running on a node that has no memory left, will get memory
allocated from other nodes which is inefficient to handle. It would be
better if kswapd would throw out some pages (maybe some of the cached
pages from files that have only once been read) to reclaim memory in the
node.

The following patch checks the memory usage after each allocation in a
zone. If the allocation in a zone falls below a certain minimum, kswapd is
started for that zone alone.

The minimum may be controlled through /proc/sys/vm/node_swap.
By default node_swap is set to 100 which means that kswapd will be run on
a zone if less than 10% are available after allocation.

Nick Piggin has a much better overall solution in the overhaul of the
memory subsystem that he is working on. I hope this patch may provide
a solution until Nick's patch gets into the kernel.

Index: linux-2.6.9-rc4/mm/page_alloc.c
===================================================================
--- linux-2.6.9-rc4.orig/mm/page_alloc.c	2004-10-10 19:57:03.000000000 -0700
+++ linux-2.6.9-rc4/mm/page_alloc.c	2004-10-11 12:54:51.000000000 -0700
@@ -41,6 +41,9 @@
 long nr_swap_pages;
 int numnodes = 1;
 int sysctl_lower_zone_protection = 0;
+#ifdef CONFIG_NUMA
+int sysctl_node_swap = 100;		/* invoke kswapd when local node memory lower than 20% */
+#endif

 EXPORT_SYMBOL(totalram_pages);
 EXPORT_SYMBOL(nr_swap_pages);
@@ -483,6 +486,13 @@
 	p = &z->pageset[cpu];
 	if (pg == orig) {
 		z->pageset[cpu].numa_hit++;
+		/*
+		 * If zone allocation leaves less than a (sysctl_node_swap * 10) %
+		 * of the zone free then invoke kswapd.
+		 * (to make it efficient we do (pages * sysctl_node_swap) / 1024))
+		 */
+		if (z->free_pages < (z->present_pages * sysctl_node_swap) << 10)
+			wakeup_kswapd(z);
 	} else {
 		p->numa_miss++;
 		zonelist->zones[0]->pageset[cpu].numa_foreign++;
Index: linux-2.6.9-rc4/kernel/sysctl.c
===================================================================
--- linux-2.6.9-rc4.orig/kernel/sysctl.c	2004-10-10 19:57:03.000000000 -0700
+++ linux-2.6.9-rc4/kernel/sysctl.c	2004-10-11 12:54:51.000000000 -0700
@@ -65,6 +65,9 @@
 extern int min_free_kbytes;
 extern int printk_ratelimit_jiffies;
 extern int printk_ratelimit_burst;
+#ifdef CONFIG_NUMA
+extern int sysctl_node_swap;
+#endif

 #if defined(CONFIG_X86_LOCAL_APIC) && defined(__i386__)
 int unknown_nmi_panic;
@@ -800,7 +803,17 @@
 		.extra1		= &zero,
 	},
 #endif
-	{ .ctl_name = 0 }
+#ifdef CONFIG_NUMA
+	{
+		.ctl_name	= VM_NODE_SWAP,
+		.procname	= "node_swap",
+		.data		= &sysctl_node_swap,
+		.maxlen		= sizeof(sysctl_node_swap),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec
+	},
+#endif
+		{ .ctl_name = 0 }
 };

 static ctl_table proc_table[] = {
Index: linux-2.6.9-rc4/include/linux/sysctl.h
===================================================================
--- linux-2.6.9-rc4.orig/include/linux/sysctl.h	2004-10-10 19:58:05.000000000 -0700
+++ linux-2.6.9-rc4/include/linux/sysctl.h	2004-10-11 12:54:51.000000000 -0700
@@ -167,6 +167,7 @@
 	VM_HUGETLB_GROUP=25,	/* permitted hugetlb group */
 	VM_VFS_CACHE_PRESSURE=26, /* dcache/icache reclaim pressure */
 	VM_LEGACY_VA_LAYOUT=27, /* legacy/compatibility virtual address space layout */
+	VM_NODE_SWAP=28,	/* Swap local node memory limit (in % *10) */
 };


Index: linux-2.6.9-rc4/mm/vmscan.c
===================================================================
--- linux-2.6.9-rc4.orig/mm/vmscan.c	2004-10-10 19:57:04.000000000 -0700
+++ linux-2.6.9-rc4/mm/vmscan.c	2004-10-11 12:54:51.000000000 -0700
@@ -1168,9 +1168,11 @@
  */
 void wakeup_kswapd(struct zone *zone)
 {
+	extern int sysctl_node_swap;
+
 	if (zone->present_pages == 0)
 		return;
-	if (zone->free_pages > zone->pages_low)
+	if (zone->free_pages > (zone->present_pages * sysctl_node_swap) << 10 && zone->free_pages > zone->pages_low)
 		return;
 	if (!waitqueue_active(&zone->zone_pgdat->kswapd_wait))
 		return;
