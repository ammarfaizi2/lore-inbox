Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbVLTIyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbVLTIyn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 03:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbVLTIym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 03:54:42 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:26043 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750881AbVLTIyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 03:54:41 -0500
Date: Tue, 20 Dec 2005 17:53:24 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
Subject: [Patch] New zone ZONE_EASY_RECLAIM take 4. (/proc/meminfo)[6/8]
Cc: Joel Schopp <jschopp@austin.ibm.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.057
Message-Id: <20051220173049.1B14.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is add information of easy reclaim zone to /proc/meminfo.

This is new patch at take 4.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

--
Index: zone_reclaim/fs/proc/proc_misc.c
===================================================================
--- zone_reclaim.orig/fs/proc/proc_misc.c	2005-12-15 19:48:29.000000000 +0900
+++ zone_reclaim/fs/proc/proc_misc.c	2005-12-15 20:43:27.000000000 +0900
@@ -126,6 +126,7 @@ static int meminfo_read_proc(char *page,
 	unsigned long free;
 	unsigned long committed;
 	unsigned long allowed;
+	unsigned long totalhigh, freehigh;
 	struct vmalloc_info vmi;
 	long cached;
 
@@ -147,7 +148,13 @@ static int meminfo_read_proc(char *page,
 		cached = 0;
 
 	get_vmalloc_info(&vmi);
-
+	if (i.totalhigh) {
+		totalhigh = i.totalhigh - i.total_easyreclaim;
+		freehigh = i.freehigh - i.free_easyreclaim;
+	} else {
+		totalhigh = 0;
+		freehigh = 0;
+	}
 	/*
 	 * Tagged format, for easy grepping and expansion.
 	 */
@@ -161,6 +168,8 @@ static int meminfo_read_proc(char *page,
 		"Inactive:     %8lu kB\n"
 		"HighTotal:    %8lu kB\n"
 		"HighFree:     %8lu kB\n"
+		"ReclaimTotal: %8lu kB\n"
+		"ReclaimFree:  %8lu kB\n"
 		"LowTotal:     %8lu kB\n"
 		"LowFree:      %8lu kB\n"
 		"SwapTotal:    %8lu kB\n"
@@ -182,8 +191,10 @@ static int meminfo_read_proc(char *page,
 		K(total_swapcache_pages),
 		K(active),
 		K(inactive),
-		K(i.totalhigh),
-		K(i.freehigh),
+		K(totalhigh),
+		K(freehigh),
+		K(i.total_easyreclaim),
+		K(i.free_easyreclaim),
 		K(i.totalram-i.totalhigh),
 		K(i.freeram-i.freehigh),
 		K(i.totalswap),
Index: zone_reclaim/include/linux/kernel.h
===================================================================
--- zone_reclaim.orig/include/linux/kernel.h	2005-12-15 19:48:30.000000000 +0900
+++ zone_reclaim/include/linux/kernel.h	2005-12-15 20:43:27.000000000 +0900
@@ -303,6 +303,8 @@ struct sysinfo {
 	unsigned short pad;		/* explicit padding for m68k */
 	unsigned long totalhigh;	/* Total high memory size */
 	unsigned long freehigh;		/* Available high memory size */
+	unsigned long total_easyreclaim;/* Total easy reclaim size */
+	unsigned long free_easyreclaim; /* Available easy reclaim size */
 	unsigned int mem_unit;		/* Memory unit size in bytes */
 	char _f[20-2*sizeof(long)-sizeof(int)];	/* Padding: libc5 uses this.. */
 };
Index: zone_reclaim/mm/page_alloc.c
===================================================================
--- zone_reclaim.orig/mm/page_alloc.c	2005-12-15 20:11:43.000000000 +0900
+++ zone_reclaim/mm/page_alloc.c	2005-12-16 11:19:50.000000000 +0900
@@ -1275,17 +1275,45 @@ unsigned int nr_free_pagecache_pages(voi
 }
 
 #ifdef CONFIG_HIGHMEM
-unsigned int nr_free_highpages (void)
+unsigned int nr_total_highpages (void)
 {
 	pg_data_t *pgdat;
 	unsigned int pages = 0;
+	for_each_pgdat(pgdat) {
+		pages += pgdat->node_zones[ZONE_HIGHMEM].present_pages;
+	}
+	return pages;
+}
 
-	for_each_pgdat(pgdat)
+unsigned int nr_free_highpages (void)
+{
+	pg_data_t *pgdat;
+	unsigned int pages = 0;
+	for_each_pgdat(pgdat) {
 		pages += pgdat->node_zones[ZONE_HIGHMEM].free_pages;
-
+	}
 	return pages;
 }
 #endif
+unsigned int nr_total_easyreclaim (void)
+{
+	pg_data_t *pgdat;
+	unsigned int pages = 0;
+	for_each_pgdat(pgdat) {
+		pages += pgdat->node_zones[ZONE_EASY_RECLAIM].present_pages;
+	}
+	return pages;
+}
+
+unsigned int nr_free_easyreclaim (void)
+{
+	pg_data_t *pgdat;
+	unsigned int pages = 0;
+	for_each_pgdat(pgdat) {
+		pages += pgdat->node_zones[ZONE_EASY_RECLAIM].free_pages;
+	}
+	return pages;
+}
 
 #ifdef CONFIG_NUMA
 static void show_node(struct zone *zone)
@@ -1436,12 +1464,15 @@ void si_meminfo(struct sysinfo *val)
 	val->freeram = nr_free_pages();
 	val->bufferram = nr_blockdev_pages();
 #ifdef CONFIG_HIGHMEM
-	val->totalhigh = totalhigh_pages;
-	val->freehigh = nr_free_highpages();
+	/* if highmem!=0, totalhigh includes easy reclaim pages. */
+	val->totalhigh = nr_total_highpages() + nr_total_easyreclaim();
+	val->freehigh = nr_free_highpages() + nr_free_easyreclaim();
 #else
 	val->totalhigh = 0;
 	val->freehigh = 0;
 #endif
+	val->total_easyreclaim = nr_total_easyreclaim();
+	val->free_easyreclaim = nr_free_easyreclaim();
 	val->mem_unit = PAGE_SIZE;
 }
 

-- 
Yasunori Goto 


