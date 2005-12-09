Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbVLIDAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbVLIDAb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 22:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbVLIDAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 22:00:31 -0500
Received: from fmr24.intel.com ([143.183.121.16]:15570 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751248AbVLIDAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 22:00:31 -0500
Date: Thu, 8 Dec 2005 19:00:16 -0800
From: Rohit Seth <rohit.seth@intel.com>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH]: Making high and batch sizes of per_cpu_pagelists configurable
Message-ID: <20051208190016.A3975@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As recently there has been lot of traffic on the right values for 
batch and high water marks for per_cpu_pagelists. This patch makes 
these two variables configurable through /proc interface.

A new tunable /proc/sys/vm/percpu_pagelist_fraction is added.  This 
entry controls the fraction of pages at most in each zone that are 
allocated for each per cpu page list.  The min value for this is 8. 
It means that we don't allow more than 1/8th of pages in each zone 
to be allocated in any single per_cpu_pagelist.

The batch value of each per cpu pagelist is also updated as a
result.  It is set to pcp->high/4.  The upper limit of batch
is (PAGE_SHIFT * 8)


Thanks to Andrew for providing early feedback.

Signed-off-by: Rohit Seth <rohit.seth@intel.com>

--- a/Documentation/sysctl/vm.txt	2005-12-08 10:44:12.000000000 -0800
+++ linux-2.6.15-rc5-mm1/Documentation/sysctl/vm.txt	2005-12-08 10:23:42.000000000 -0800
@@ -27,6 +27,7 @@
 - laptop_mode
 - block_dump
 - swap_prefetch
+- percpu_pagelist_fraction
 
 ==============================================================
 
@@ -114,3 +115,22 @@
 Setting it to 0 disables prefetching entirely.
 
 The default value is dependant on ramsize.
+
+==============================================================
+
+percpu_pagelist_fraction
+
+This is fraction of pages at most (high mark pcp->high) in each zone
+that are allocated for each per cpu page list.  The min value for this 
+is 8. It means that we don't allow more than 1/8th of pages in each zone 
+to be allocated in any single per_cpu_pagelist.  This entry only 
+changes the value of hot per cpu pagelists.  User can specify a number 
+like 100 to allocate 1/100th of each zone to each per cpu page list.
+
+The batch value of each per cpu pagelist is also updated as a 
+result.  It is set to pcp->high/4.  The upper limit of batch 
+is (PAGE_SHIFT * 8)
+
+The initial value is zero.  Kernel does not use this value at boot time
+to set the high water marks for each per cpu page list.
+
--- a/include/linux/mmzone.h	2005-12-08 10:44:49.000000000 -0800
+++ linux-2.6.15-rc5-mm1/include/linux/mmzone.h	2005-12-08 09:49:48.000000000 -0800
@@ -437,6 +437,8 @@
 extern int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES-1];
 int lowmem_reserve_ratio_sysctl_handler(struct ctl_table *, int, struct file *,
 					void __user *, size_t *, loff_t *);
+int percpu_pagelist_fraction_sysctl_handler(struct ctl_table *, int, struct file *,
+					void __user *, size_t *, loff_t *);
 
 #include <linux/topology.h>
 /* Returns the number of the current Node. */
--- a/include/linux/sysctl.h	2005-12-08 10:45:04.000000000 -0800
+++ linux-2.6.15-rc5-mm1/include/linux/sysctl.h	2005-12-08 09:50:08.000000000 -0800
@@ -183,6 +183,7 @@
 	VM_SWAP_TOKEN_TIMEOUT=28, /* default time for token time out */
 	VM_DROP_PAGECACHE=29,	/* int: nuke lots of pagecache */
 	VM_SWAP_PREFETCH=30,	/* int: amount to swap prefetch */
+	VM_PERCPU_PAGELIST_FRACTION=31,/* int: fraction of pages in each percpu_pagelist */
 };
 
 
--- a/kernel/sysctl.c	2005-12-08 10:45:44.000000000 -0800
+++ linux-2.6.15-rc5-mm1/kernel/sysctl.c	2005-12-08 10:29:40.000000000 -0800
@@ -68,6 +68,7 @@
 extern int printk_ratelimit_jiffies;
 extern int printk_ratelimit_burst;
 extern int pid_max_min, pid_max_max;
+extern int percpu_pagelist_fraction;
 
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
 int unknown_nmi_panic;
@@ -78,6 +79,7 @@
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
 static int minolduid;
+static int min_percpu_pagelist_fract = 8;
 
 static int ngroups_max = NGROUPS_MAX;
 
@@ -801,6 +803,16 @@
 		.strategy	= &sysctl_intvec,
 		.extra1		= &zero,
 	},
+	{
+		.ctl_name	= VM_PERCPU_PAGELIST_FRACTION,
+		.procname	= "percpu_pagelist_fraction",
+		.data		= &percpu_pagelist_fraction,
+		.maxlen		= sizeof(percpu_pagelist_fraction),
+		.mode		= 0644,
+		.proc_handler	= &percpu_pagelist_fraction_sysctl_handler,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &min_percpu_pagelist_fract,
+	},
 #ifdef CONFIG_MMU
 	{
 		.ctl_name	= VM_MAX_MAP_COUNT,
--- a/mm/page_alloc.c	2005-12-08 10:45:30.000000000 -0800
+++ linux-2.6.15-rc5-mm1/mm/page_alloc.c	2005-12-08 10:39:29.000000000 -0800
@@ -2676,6 +2676,49 @@
 	return 0;
 }
 
+int percpu_pagelist_fraction;
+
+/* setup_pagelist_highmark sets the high water mark for hot per_cpu_pagelist
+ * to the value high for the pagesrt p.
+ */
+
+static inline void setup_pagelist_highmark(struct per_cpu_pageset *p, unsigned long high)
+{
+	struct per_cpu_pages *pcp;
+	
+	pcp = &p->pcp[0]; /* hot list */
+	pcp->high = high;
+	pcp->batch = max(1UL, high/4);
+	if ((high/4) > (PAGE_SHIFT * 8))
+		pcp->batch = PAGE_SHIFT * 8;
+}
+
+/*
+ * percpu_pagelist_fraction - changes the pcp->high for each zone on each
+ * cpu.  It is the fraction of total pages in each zone that a hot per cpu pagelist
+ * can have before it gets flushed back to buddy allocator.
+ */
+
+int percpu_pagelist_fraction_sysctl_handler(ctl_table *table, int write,
+	struct file *file, void __user *buffer, size_t *length, loff_t *ppos)
+{
+	struct zone *zone;
+	unsigned int cpu;
+	int ret;
+
+	ret = proc_dointvec_minmax(table, write, file, buffer, length, ppos);
+	if (!write || (ret == -EINVAL))
+		return ret;
+	for_each_zone(zone) {
+		for_each_online_cpu(cpu) {
+			unsigned long  high;
+			high = zone->present_pages / percpu_pagelist_fraction;
+			setup_pagelist_highmark(zone_pcp(zone, cpu), high);
+		}
+	}
+	return 0;
+}
+
 __initdata int hashdist = HASHDIST_DEFAULT;
 
 #ifdef CONFIG_NUMA
