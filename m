Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932648AbWCJDoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932648AbWCJDoe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 22:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932703AbWCJDoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 22:44:34 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:15535 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S932648AbWCJDo0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 22:44:26 -0500
From: Magnus Damm <magnus@valinux.co.jp>
To: Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc: Magnus Damm <magnus@valinux.co.jp>
Message-Id: <20060310034429.8340.61997.sendpatchset@cherry.local>
In-Reply-To: <20060310034412.8340.90939.sendpatchset@cherry.local>
References: <20060310034412.8340.90939.sendpatchset@cherry.local>
Subject: [PATCH 03/03] Unmapped: Add guarantee code
Date: Fri, 10 Mar 2006 12:44:25 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement per-LRU guarantee through sysctl.

This patch introduces the two new sysctl files "node_mapped_guar" and
"node_unmapped_guar". Each file contains one percentage per node and tells
the system how many percentage of all pages that should be kept in RAM as 
unmapped or mapped pages.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
---

 include/linux/mmzone.h |    7 ++++
 include/linux/sysctl.h |    2 +
 kernel/sysctl.c        |   18 ++++++++++++
 mm/vmscan.c            |   68 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 95 insertions(+)

--- from-0003/include/linux/mmzone.h
+++ to-work/include/linux/mmzone.h	2006-03-06 18:07:22.000000000 +0900
@@ -124,6 +124,7 @@ struct lru {
 	unsigned long		nr_inactive;
 	unsigned long		nr_scan_active;
 	unsigned long		nr_scan_inactive;
+	unsigned long		nr_guaranteed;
 };
 
 #define LRU_MAPPED 0
@@ -459,6 +460,12 @@ int lowmem_reserve_ratio_sysctl_handler(
 					void __user *, size_t *, loff_t *);
 int percpu_pagelist_fraction_sysctl_handler(struct ctl_table *, int, struct file *,
 					void __user *, size_t *, loff_t *);
+extern int sysctl_node_mapped_guar[MAX_NUMNODES];
+int node_mapped_guar_sysctl_handler(struct ctl_table *, int, struct file *,
+					void __user *, size_t *, loff_t *);
+extern int sysctl_node_unmapped_guar[MAX_NUMNODES];
+int node_unmapped_guar_sysctl_handler(struct ctl_table *, int, struct file *,
+					void __user *, size_t *, loff_t *);
 
 #include <linux/topology.h>
 /* Returns the number of the current Node. */
--- from-0002/include/linux/sysctl.h
+++ to-work/include/linux/sysctl.h	2006-03-06 18:07:22.000000000 +0900
@@ -185,6 +185,8 @@ enum
 	VM_PERCPU_PAGELIST_FRACTION=30,/* int: fraction of pages in each percpu_pagelist */
 	VM_ZONE_RECLAIM_MODE=31, /* reclaim local zone memory before going off node */
 	VM_ZONE_RECLAIM_INTERVAL=32, /* time period to wait after reclaim failure */
+	VM_NODE_MAPPED_GUAR=33, /* percent of node memory guaranteed mapped */
+	VM_NODE_UNMAPPED_GUAR=34, /* percent of node memory guaranteed unmapped */
 };
 
 
--- from-0002/kernel/sysctl.c
+++ to-work/kernel/sysctl.c	2006-03-06 18:07:22.000000000 +0900
@@ -899,6 +899,24 @@ static ctl_table vm_table[] = {
 		.strategy	= &sysctl_jiffies,
 	},
 #endif
+	{
+		.ctl_name	= VM_NODE_MAPPED_GUAR,
+		.procname	= "node_mapped_guar",
+		.data		= &sysctl_node_mapped_guar,
+		.maxlen		= sizeof(sysctl_node_mapped_guar),
+		.mode		= 0644,
+		.proc_handler	= &node_mapped_guar_sysctl_handler,
+		.strategy	= &sysctl_intvec,
+	},
+	{
+		.ctl_name	= VM_NODE_UNMAPPED_GUAR,
+		.procname	= "node_unmapped_guar",
+		.data		= &sysctl_node_unmapped_guar,
+		.maxlen		= sizeof(sysctl_node_unmapped_guar),
+		.mode		= 0644,
+		.proc_handler	= &node_unmapped_guar_sysctl_handler,
+		.strategy	= &sysctl_intvec,
+	},
 	{ .ctl_name = 0 }
 };
 
--- from-0004/mm/vmscan.c
+++ to-work/mm/vmscan.c	2006-03-06 18:07:22.000000000 +0900
@@ -29,6 +29,7 @@
 #include <linux/backing-dev.h>
 #include <linux/rmap.h>
 #include <linux/topology.h>
+#include <linux/sysctl.h>
 #include <linux/cpu.h>
 #include <linux/cpuset.h>
 #include <linux/notifier.h>
@@ -1284,6 +1285,11 @@ shrink_lru(struct zone *zone, int lru_nr
 	unsigned long nr_active;
 	unsigned long nr_inactive;
 
+	/* No need to scan if guarantee is not fulfilled */
+
+	if ((lru->nr_active + lru->nr_inactive) <= lru->nr_guaranteed)
+		return;
+
 	atomic_inc(&zone->reclaim_in_progress);
 
 	/*
@@ -1325,6 +1331,68 @@ shrink_lru(struct zone *zone, int lru_nr
 	atomic_dec(&zone->reclaim_in_progress);
 }
 
+spinlock_t sysctl_node_guar_lock = SPIN_LOCK_UNLOCKED;
+int sysctl_node_mapped_guar[MAX_NUMNODES];
+int sysctl_node_mapped_guar_ok[MAX_NUMNODES];
+int sysctl_node_unmapped_guar[MAX_NUMNODES];
+int sysctl_node_unmapped_guar_ok[MAX_NUMNODES];
+
+static void setup_per_lru_guarantee(int lru_nr)
+{
+	struct zone *zone;
+	unsigned long nr;
+	int nid, i;
+
+	for_each_zone(zone) {
+		nid = zone->zone_pgdat->node_id;
+
+		if ((sysctl_node_mapped_guar[nid] + 
+		     sysctl_node_unmapped_guar[nid]) > 100) {
+			if (lru_nr == LRU_MAPPED) {
+				i = sysctl_node_mapped_guar_ok[nid];
+				sysctl_node_mapped_guar[nid] = i;
+			}
+			else {
+				i = sysctl_node_unmapped_guar_ok[nid];
+				sysctl_node_unmapped_guar[nid] = i;
+			}
+		}
+
+		if (lru_nr == LRU_MAPPED) {
+			i = sysctl_node_mapped_guar[nid];
+			sysctl_node_mapped_guar_ok[nid] = i;
+		}
+		else {
+			i = sysctl_node_unmapped_guar[nid];
+			sysctl_node_unmapped_guar_ok[nid] = i;
+		}
+
+		nr = zone->present_pages - zone->pages_high;
+
+		zone->lru[lru_nr].nr_guaranteed = (nr * i) / 100;
+	}
+}
+
+int node_mapped_guar_sysctl_handler(ctl_table *table, int write,
+	struct file *file, void __user *buffer, size_t *length, loff_t *ppos)
+{
+	spin_lock(&sysctl_node_guar_lock);
+	proc_dointvec_minmax(table, write, file, buffer, length, ppos);
+	setup_per_lru_guarantee(LRU_MAPPED);
+	spin_unlock(&sysctl_node_guar_lock);
+	return 0;
+}
+
+int node_unmapped_guar_sysctl_handler(ctl_table *table, int write,
+	struct file *file, void __user *buffer, size_t *length, loff_t *ppos)
+{
+	spin_lock(&sysctl_node_guar_lock);
+	proc_dointvec_minmax(table, write, file, buffer, length, ppos);
+	setup_per_lru_guarantee(LRU_UNMAPPED);
+	spin_unlock(&sysctl_node_guar_lock);
+	return 0;
+}
+
 /*
  * This is a basic per-zone page freer. Used by both kswapd and direct reclaim.
  */
