Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbUJ1Pcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbUJ1Pcu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 11:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbUJ1PaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 11:30:22 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:47299 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261693AbUJ1PYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 11:24:32 -0400
Date: Thu, 28 Oct 2004 08:23:09 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: NUMA node swapping V3
Message-ID: <Pine.LNX.4.58.0410280820500.25586@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from V2: better documentation, fix missing #ifdef

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

The minimum may be controlled through /proc/sys/vm/node_swap which is set
to zero by default and thus is off.

If it is set for example to 100 then kswapd will be run on
a zone/node if less than 10% of pages are available after an allocation.

Changelog:
	* NUMA: Add ability to invoke kswapd on a node if local memory falls below a
	  certain threshold. A node may fill up its memory by simply copying a file
	  which will fill up the nodes memory with cached pages. The nodes memory will
	  currently only be reclaimed if all nodes in the system fall below a certain
	  threshhold. Until that time the processes on the node will only be allocated
	  off node memory. Invoking kswapd on a node fixes this situation until
	  a better solution can be found.
	* Threshold may be set in /proc/sys/vm/node_swap in percent * 10. The threshold
	  is set to zero by default which means that node swapping is off.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.9/mm/page_alloc.c
===================================================================
--- linux-2.6.9.orig/mm/page_alloc.c	2004-10-25 13:09:18.000000000 -0700
+++ linux-2.6.9/mm/page_alloc.c	2004-10-25 13:18:21.000000000 -0700
@@ -43,6 +43,19 @@
 long nr_swap_pages;
 int numnodes = 1;
 int sysctl_lower_zone_protection = 0;
+#ifdef CONFIG_NUMA
+/*
+ * sysctl_node_swap is a percentage of the pages available
+ * in a zone multiplied by 10. If the available pages
+ * in a zone drop below this limit then kswapd is invoked
+ * for this zone alone. This results in the reclaiming
+ * of local memory. Local memory may be filled up by simply reading
+ * a file. If local memory is not available then off node memory
+ * will be allocated to a process which makes all memory access
+ * less efficient then they could be.
+ */
+int sysctl_node_swap = 0;
+#endif

 EXPORT_SYMBOL(totalram_pages);
 EXPORT_SYMBOL(nr_swap_pages);
@@ -486,6 +499,14 @@
 	p = &z->pageset[cpu];
 	if (pg == orig) {
 		z->pageset[cpu].numa_hit++;
+		/*
+		 * If zone allocation has left less than
+		 * (sysctl_node_swap / 10) %  of the zone free invoke kswapd.
+		 * (the page limit is obtained through (pages*limit)/1024 to
+		 * make the calculation more efficient)
+		 */
+		if (z->free_pages < (z->present_pages * sysctl_node_swap) << 10)
+			wakeup_kswapd(z);
 	} else {
 		p->numa_miss++;
 		zonelist->zones[0]->pageset[cpu].numa_foreign++;
Index: linux-2.6.9/kernel/sysctl.c
===================================================================
--- linux-2.6.9.orig/kernel/sysctl.c	2004-10-25 13:09:18.000000000 -0700
+++ linux-2.6.9/kernel/sysctl.c	2004-10-25 13:10:14.000000000 -0700
@@ -67,6 +67,9 @@
 extern int printk_ratelimit_jiffies;
 extern int printk_ratelimit_burst;
 extern int pid_max_min, pid_max_max;
+#ifdef CONFIG_NUMA
+extern int sysctl_node_swap;
+#endif

 #if defined(CONFIG_X86_LOCAL_APIC) && defined(__i386__)
 int unknown_nmi_panic;
@@ -816,7 +819,17 @@
 		.strategy	= &sysctl_jiffies,
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
Index: linux-2.6.9/include/linux/sysctl.h
===================================================================
--- linux-2.6.9.orig/include/linux/sysctl.h	2004-10-25 13:09:18.000000000 -0700
+++ linux-2.6.9/include/linux/sysctl.h	2004-10-25 13:12:53.000000000 -0700
@@ -168,6 +168,7 @@
 	VM_VFS_CACHE_PRESSURE=26, /* dcache/icache reclaim pressure */
 	VM_LEGACY_VA_LAYOUT=27, /* legacy/compatibility virtual address space layout */
 	VM_SWAP_TOKEN_TIMEOUT=28, /* default time for token time out */
+	VM_NODE_SWAP=29,	/* Swap local node memory limit (in % *10) */
 };


Index: linux-2.6.9/mm/vmscan.c
===================================================================
--- linux-2.6.9.orig/mm/vmscan.c	2004-10-18 14:53:21.000000000 -0700
+++ linux-2.6.9/mm/vmscan.c	2004-10-25 13:21:17.000000000 -0700
@@ -1171,9 +1171,17 @@
  */
 void wakeup_kswapd(struct zone *zone)
 {
+#ifdef CONFIG_NUMA
+	extern int sysctl_node_swap;
+#endif
+
 	if (zone->present_pages == 0)
 		return;
+#ifdef CONFIG_NUMA
+	if (zone->free_pages > (zone->present_pages * sysctl_node_swap) << 10 && zone->free_pages > zone->pages_low)
+#else
 	if (zone->free_pages > zone->pages_low)
+#endif
 		return;
 	if (!waitqueue_active(&zone->zone_pgdat->kswapd_wait))
 		return;
Index: linux-2.6.9/Documentation/vm/numa_node_swap
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.9/Documentation/vm/numa_node_swap	2004-10-25 13:17:07.000000000 -0700
@@ -0,0 +1,24 @@
+In a NUMA systems single nodes may run out of memory. This may occur even
+by only reading from files which will clutter node memory with cached
+pages from the file.
+
+However, as long as the system as a whole does have enough memory
+available, kswapd is not run at all. This means that a process allocating
+memory and running on a node that has no memory left, will get memory
+allocated from other nodes which is inefficient to handle. It would be
+better if kswapd would throw out some pages (maybe some of the cached
+pages from files that have only once been read) to reclaim memory in the
+node.
+
+The following patch checks the memory usage after each allocation in a
+zone. If the allocation in a zone falls below a certain minimum, kswapd is
+started for that zone alone.
+
+The minimum may be controlled through /proc/sys/vm/node_swap which is set
+to zero by default and thus is off.
+
+If it is set for example to 100 then kswapd will be run on
+a zone/node if less than 10% of pages are available after an allocation.
+
+October 25, 2004, Christoph Lameter <christoph@lameter.com>
+

