Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268828AbUJMPPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268828AbUJMPPU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 11:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268846AbUJMPPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 11:15:19 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:50060 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S268828AbUJMPOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 11:14:51 -0400
Date: Wed, 13 Oct 2004 08:14:35 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: akpm@osdl.org
cc: nickpiggin@yahoo.com.au, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: NUMA: Patch for node based swapping V2
In-Reply-To: <416D0AA4.30701@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0410130812560.9057@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0410121151220.13693-100000@chimarrao.boston.redhat.com>
 <Pine.LNX.4.58.0410121319510.5785@schroedinger.engr.sgi.com>
 <416D0AA4.30701@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was discussed yesterday on linux-mm.

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

Index: linux-2.6.9-rc4/mm/page_alloc.c
===================================================================
--- linux-2.6.9-rc4.orig/mm/page_alloc.c	2004-10-10 19:57:03.000000000 -0700
+++ linux-2.6.9-rc4/mm/page_alloc.c	2004-10-13 07:58:57.000000000 -0700
@@ -41,6 +41,19 @@
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
+ * a file. If local memory is not available the off node memory
+ * will be allocated to a process which makes all memory access
+ * less efficient then they could be.
+ */
+int sysctl_node_swap = 0;
+#endif

 EXPORT_SYMBOL(totalram_pages);
 EXPORT_SYMBOL(nr_swap_pages);
@@ -483,6 +496,14 @@
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
