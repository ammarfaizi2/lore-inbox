Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266631AbUGKWxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266631AbUGKWxT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 18:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266662AbUGKWxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 18:53:19 -0400
Received: from 234.69-93-232.reverse.theplanet.com ([69.93.232.234]:40108 "EHLO
	urbanisp01.urban-isp.net") by vger.kernel.org with ESMTP
	id S266631AbUGKWxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 18:53:14 -0400
From: "Shai Fultheim" <shai@scalex86.org>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: "'Linux Kernel ML'" <linux-kernel@vger.kernel.org>
Subject: [PATCH] Alignment for CPU maps, add padding semantics
Date: Sun, 11 Jul 2004 15:53:08 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2142
Thread-Index: AcRnmdVJsYFzcw33SlOwuTyynKYzSw==
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - urbanisp01.urban-isp.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Message-Id: <S266631AbUGKWxO/20040711225314Z+1231@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

The attached patch add missing alignments for CPU maps (cpu_online_map,
node_2_cpu_mask, cpu_2_node, cpu_2_logical_apicid).  It allows better
cache-line utilization by having the most usable part of each map on
same cache-line.

=====================================================================
===== arch/i386/kernel/smpboot.c 1.83 vs edited =====
--- 1.83/arch/i386/kernel/smpboot.c	2004-06-30 17:00:00 -07:00
+++ edited/arch/i386/kernel/smpboot.c	2004-07-11 12:59:17 -07:00
@@ -63,7 +63,7 @@
 int phys_proc_id[NR_CPUS]; /* Package ID of each logical CPU */
 
 /* bitmap of online cpus */
-cpumask_t cpu_online_map;
+cpumask_t cpu_online_map __cacheline_aligned;
 
 static cpumask_t cpu_callin_map;
 cpumask_t cpu_callout_map;
@@ -505,10 +505,10 @@
 #ifdef CONFIG_NUMA
 
 /* which logical CPUs are on which nodes */
-cpumask_t node_2_cpu_mask[MAX_NUMNODES] =
+cpumask_t node_2_cpu_mask[MAX_NUMNODES] __cacheline_aligned =
 				{ [0 ... MAX_NUMNODES-1] = CPU_MASK_NONE };
 /* which node each logical CPU is on */
-int cpu_2_node[NR_CPUS] = { [0 ... NR_CPUS-1] = 0 };
+int cpu_2_node[NR_CPUS] __cacheline_aligned = { [0 ... NR_CPUS-1] = 0 };
 EXPORT_SYMBOL(cpu_2_node);
 
 /* set up a mapping between cpu and node. */
@@ -536,7 +536,8 @@
 
 #endif /* CONFIG_NUMA */
 
-u8 cpu_2_logical_apicid[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
+u8 cpu_2_logical_apicid[NR_CPUS] __cacheline_aligned =
+			{ [0 ... NR_CPUS-1] = BAD_APICID };
 
 void map_cpu_to_logical_apicid(void)
 {
===== include/linux/cache.h 1.7 vs edited =====
--- 1.7/include/linux/cache.h	2004-02-25 21:43:49 -08:00
+++ edited/include/linux/cache.h	2004-07-11 15:09:35 -07:00
@@ -48,4 +48,12 @@
 #endif
 #endif
 
+#ifndef ____cacheline_pad_in_smp
+#if defined(CONFIG_SMP)
+#define ____cacheline_pad_in_smp struct { char  x; } ____cacheline_maxaligned_in_smp
+#else
+#define ____cacheline_pad_in_smp
+#endif
+#endif
+
 #endif /* __LINUX_CACHE_H */
===== include/linux/mmzone.h 1.62 vs edited =====
--- 1.62/include/linux/mmzone.h	2004-06-27 17:28:54 -07:00
+++ edited/include/linux/mmzone.h	2004-07-11 15:12:12 -07:00
@@ -39,21 +39,6 @@
 
 struct pglist_data;
 
-/*
- * zone->lock and zone->lru_lock are two of the hottest locks in the kernel.
- * So add a wild amount of padding here to ensure that they fall into separate
- * cachelines.  There are very few zone structures in the machine, so space
- * consumption is not a concern here.
- */
-#if defined(CONFIG_SMP)
-struct zone_padding {
-	int x;
-} ____cacheline_maxaligned_in_smp;
-#define ZONE_PADDING(name)	struct zone_padding name;
-#else
-#define ZONE_PADDING(name)
-#endif
-
 struct per_cpu_pages {
 	int count;		/* number of pages in the list */
 	int low;		/* low watermark, refill needed */
@@ -140,7 +125,14 @@
 	 */
 	unsigned long		protection[MAX_NR_ZONES];
 
-	ZONE_PADDING(_pad1_)
+	/*
+	 * zone->lock and zone->lru_lock are two of the hottest locks in the kernel.
+	 * So add a wild amount of padding here to ensure that they fall into separate
+	 * cachelines.  There are very few zone structures in the machine, so space
+	 * consumption is not a concern here.
+	 */
+
+	____cacheline_pad_in_smp;
 
 	spinlock_t		lru_lock;	
 	struct list_head	active_list;
@@ -152,7 +144,7 @@
 	int			all_unreclaimable; /* All pages pinned */
 	unsigned long		pages_scanned;	   /* since last reclaim */
 
-	ZONE_PADDING(_pad2_)
+	____cacheline_pad_in_smp;
 
 	/*
 	 * prev_priority holds the scanning priority for this zone.  It is
@@ -206,7 +198,7 @@
 	unsigned long		wait_table_size;
 	unsigned long		wait_table_bits;
 
-	ZONE_PADDING(_pad3_)
+	____cacheline_pad_in_smp;
 
 	struct per_cpu_pageset	pageset[NR_CPUS];
 
=====================================================================

 
-----------------
Shai Fultheim
Scalex86.org


