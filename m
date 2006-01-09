Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932385AbWAIPTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbWAIPTk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 10:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbWAIPTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 10:19:40 -0500
Received: from ap1.cs.vt.edu ([128.173.40.39]:36008 "EHLO ap1.cs.vt.edu")
	by vger.kernel.org with ESMTP id S932385AbWAIPTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 10:19:39 -0500
Date: Mon, 9 Jan 2006 10:19:30 -0500
From: Matt Tolentino <metolent@cs.vt.edu>
Message-Id: <200601091519.k09FJUi3022305@ap1.cs.vt.edu>
To: ak@suse.de, akpm@osdl.org
Subject: [patch 1/2] add __meminit for memory hotplug
Cc: discuss@x86-64.org, kmannth@us.ibm.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add __meminit to the __init lineup to ensure functions default
to __init when memory hotplug is not enabled.  Replace __devinit
with __meminit on functions that were changed when the memory
hotplug code was introduced.  

Signed-off-by: Matt Tolentino <matthew.e.tolentino@intel.com>
---
diff -urNp linux-2.6.15/arch/i386/mm/init.c linux-2.6.15-matt/arch/i386/mm/init.c
--- linux-2.6.15/arch/i386/mm/init.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15-matt/arch/i386/mm/init.c	2006-01-06 11:06:44.000000000 -0500
@@ -268,7 +268,7 @@ static void __init permanent_kmaps_init(
 	pkmap_page_table = pte;	
 }
 
-static void __devinit free_new_highpage(struct page *page)
+static void __meminit free_new_highpage(struct page *page)
 {
 	set_page_count(page, 1);
 	__free_page(page);
diff -urNp linux-2.6.15/include/linux/init.h linux-2.6.15-matt/include/linux/init.h
--- linux-2.6.15/include/linux/init.h	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15-matt/include/linux/init.h	2006-01-06 11:04:10.000000000 -0500
@@ -241,6 +241,18 @@ void __init parse_early_param(void);
 #define __cpuexitdata	__exitdata
 #endif
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+#define __meminit
+#define __meminitdata
+#define __memexit
+#define __memexitdata
+#else
+#define __meminit	__init
+#define __meminitdata __initdata
+#define __memexit __exit
+#define __memexitdata	__exitdata
+#endif
+
 /* Functions marked as __devexit may be discarded at kernel link time, depending
    on config options.  Newer versions of binutils detect references from
    retained sections to discarded sections and flag an error.  Pointers to
diff -urNp linux-2.6.15/mm/page_alloc.c linux-2.6.15-matt/mm/page_alloc.c
--- linux-2.6.15/mm/page_alloc.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15-matt/mm/page_alloc.c	2006-01-06 11:05:54.000000000 -0500
@@ -1699,7 +1699,7 @@ static void __init calculate_zone_totalp
  * up by free_all_bootmem() once the early boot process is
  * done. Non-atomic initialization, single-pass.
  */
-void __devinit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
+void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 		unsigned long start_pfn)
 {
 	struct page *page;
@@ -1754,7 +1754,7 @@ void zonetable_add(struct zone *zone, in
 	memmap_init_zone((size), (nid), (zone), (start_pfn))
 #endif
 
-static int __devinit zone_batchsize(struct zone *zone)
+static int __meminit zone_batchsize(struct zone *zone)
 {
 	int batch;
 
@@ -1832,7 +1832,7 @@ static struct per_cpu_pageset
  * Dynamically allocate memory for the
  * per cpu pageset array in struct zone.
  */
-static int __devinit process_zones(int cpu)
+static int __meminit process_zones(int cpu)
 {
 	struct zone *zone, *dzone;
 
@@ -1871,7 +1871,7 @@ static inline void free_zone_pagesets(in
 #endif
 }
 
-static int __devinit pageset_cpuup_callback(struct notifier_block *nfb,
+static int __meminit pageset_cpuup_callback(struct notifier_block *nfb,
 		unsigned long action,
 		void *hcpu)
 {
@@ -1911,7 +1911,7 @@ void __init setup_per_cpu_pageset(void)
 
 #endif
 
-static __devinit
+static __meminit
 void zone_wait_table_init(struct zone *zone, unsigned long zone_size_pages)
 {
 	int i;
@@ -1931,7 +1931,7 @@ void zone_wait_table_init(struct zone *z
 		init_waitqueue_head(zone->wait_table + i);
 }
 
-static __devinit void zone_pcp_init(struct zone *zone)
+static __meminit void zone_pcp_init(struct zone *zone)
 {
 	int cpu;
 	unsigned long batch = zone_batchsize(zone);
@@ -1949,7 +1949,7 @@ static __devinit void zone_pcp_init(stru
 		zone->name, zone->present_pages, batch);
 }
 
-static __devinit void init_currently_empty_zone(struct zone *zone,
+static __meminit void init_currently_empty_zone(struct zone *zone,
 		unsigned long zone_start_pfn, unsigned long size)
 {
 	struct pglist_data *pgdat = zone->zone_pgdat;
