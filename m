Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262892AbUJ1UtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262892AbUJ1UtE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 16:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262918AbUJ1Usx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 16:48:53 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:60617 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S263009AbUJ1UrC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 16:47:02 -0400
Date: Thu, 28 Oct 2004 13:45:53 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: NUMA node swapping V3
In-Reply-To: <41811C3B.2020700@kolumbus.fi>
Message-ID: <Pine.LNX.4.58.0410281034390.25983@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0410280820500.25586@schroedinger.engr.sgi.com>
 <41811C3B.2020700@kolumbus.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2004, Mika Penttilä wrote:

> >+		if (z->free_pages < (z->present_pages * sysctl_node_swap) << 10)
> >+			wakeup_kswapd(z);
> I think you mean >> 10 though.

Thanks for spotting that. This means we always were swapping before.

I did some additional test with various values of node_swap to see how it
does:

(test by filling node with pagecache pages through copy operation, then
 large anonymous alloc with touching of all pages)

setting|foreign| effectiveness
--------------------------------------
0	39136	0%
1	39138	0%
2	1460	96.3%
3	2429	93.8%
4	1171	97%
5	2868	92.7%
10	1995	95%
50	2242	94.3%
100	2348	94%
300	2768	93%

Seems that there are some sweet spots. Surprisingly these come early with
the swap ceiling even set to 0.2%. Higher values increase the number of
foreign pages?!?

Fixed patch:

Index: linux-2.6.9/mm/page_alloc.c
===================================================================
--- linux-2.6.9.orig/mm/page_alloc.c	2004-10-25 13:09:18.000000000 -0700
+++ linux-2.6.9/mm/page_alloc.c	2004-10-28 10:12:19.000000000 -0700
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
+		if (z->free_pages < (z->present_pages * sysctl_node_swap) >> 10)
+			wakeup_kswapd(z);
 	} else {
 		p->numa_miss++;
 		zonelist->zones[0]->pageset[cpu].numa_foreign++;
Index: linux-2.6.9/kernel/sysctl.c
===================================================================
--- linux-2.6.9.orig/kernel/sysctl.c	2004-10-25 13:09:18.000000000 -0700
+++ linux-2.6.9/kernel/sysctl.c	2004-10-28 10:12:19.000000000 -0700
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
+++ linux-2.6.9/include/linux/sysctl.h	2004-10-28 10:12:19.000000000 -0700
@@ -168,6 +168,7 @@
 	VM_VFS_CACHE_PRESSURE=26, /* dcache/icache reclaim pressure */
 	VM_LEGACY_VA_LAYOUT=27, /* legacy/compatibility virtual address space layout */
 	VM_SWAP_TOKEN_TIMEOUT=28, /* default time for token time out */
+	VM_NODE_SWAP=29,	/* Swap local node memory limit (in % *10) */
 };


Index: linux-2.6.9/mm/vmscan.c
===================================================================
--- linux-2.6.9.orig/mm/vmscan.c	2004-10-18 14:53:21.000000000 -0700
+++ linux-2.6.9/mm/vmscan.c	2004-10-28 10:12:19.000000000 -0700
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
+++ linux-2.6.9/Documentation/vm/numa_node_swap	2004-10-28 10:12:19.000000000 -0700
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
