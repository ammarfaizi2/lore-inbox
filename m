Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbWBVLGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWBVLGb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 06:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWBVLGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 06:06:31 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:29657 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751132AbWBVLG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 06:06:27 -0500
Date: Wed, 22 Feb 2006 20:06:10 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Yasunori Goto <y-goto@jp.fujitsu.com>
Subject: [PATCH] refine for_each_pgdat() [2/4] refine bootmem's list walk
Message-Id: <20060222200610.9fec01d8.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bootmem uses for_each_pgdat before pgdat is initialized.
This patch adds list_head to bootmem_data_t and make bootmems use it.
bootmem list is sorted by node_boot_start.
(some archs call init_bootmem_node() in reverse order to get orderd list,
 such complicate initialization will be removed by this...maybe...)

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: linux-2.6.16-rc4/include/linux/bootmem.h
===================================================================
--- linux-2.6.16-rc4.orig/include/linux/bootmem.h
+++ linux-2.6.16-rc4/include/linux/bootmem.h
@@ -38,6 +38,7 @@ typedef struct bootmem_data {
 	unsigned long last_pos;
 	unsigned long last_success;	/* Previous allocation point.  To speed
 					 * up searching */
+	struct list_head list;
 } bootmem_data_t;
 
 extern unsigned long __init bootmem_bootmap_pages (unsigned long);
Index: linux-2.6.16-rc4/mm/bootmem.c
===================================================================
--- linux-2.6.16-rc4.orig/mm/bootmem.c
+++ linux-2.6.16-rc4/mm/bootmem.c
@@ -33,6 +33,7 @@ EXPORT_SYMBOL(max_pfn);		/* This is expo
 				 * dma_get_required_mask(), which uses
 				 * it, can be an inline function */
 
+LIST_HEAD(bdata_list);
 #ifdef CONFIG_CRASH_DUMP
 /*
  * If we have booted due to a crash, max_pfn will be a very low value. We need
@@ -52,6 +53,27 @@ unsigned long __init bootmem_bootmap_pag
 
 	return mapsize;
 }
+/*
+ * link bdata in order
+ */
+static void link_bootmem(bootmem_data_t *bdata)
+{
+	bootmem_data_t *ent;
+	if (list_empty(&bdata_list)) {
+		list_add(&bdata->list, &bdata_list);
+		return;
+	}
+	/* insert in order */
+	list_for_each_entry(ent, &bdata_list, list) {
+		if (ent->node_boot_start < ent->node_boot_start) {
+			list_add_tail(&bdata->list, &ent->list);
+			return;
+		}
+	}
+	list_add_tail(&bdata->list, &bdata_list);
+	return;
+}
+
 
 /*
  * Called once to set up the allocator itself.
@@ -62,13 +84,11 @@ static unsigned long __init init_bootmem
 	bootmem_data_t *bdata = pgdat->bdata;
 	unsigned long mapsize = ((end - start)+7)/8;
 
-	pgdat->pgdat_next = pgdat_list;
-	pgdat_list = pgdat;
-
 	mapsize = ALIGN(mapsize, sizeof(long));
 	bdata->node_bootmem_map = phys_to_virt(mapstart << PAGE_SHIFT);
 	bdata->node_boot_start = (start << PAGE_SHIFT);
 	bdata->node_low_pfn = end;
+	link_bootmem(bdata);
 
 	/*
 	 * Initially all pages are reserved - setup_arch() has to
@@ -383,12 +403,11 @@ unsigned long __init free_all_bootmem (v
 
 void * __init __alloc_bootmem(unsigned long size, unsigned long align, unsigned long goal)
 {
-	pg_data_t *pgdat = pgdat_list;
+	bootmem_data_t *bdata;
 	void *ptr;
 
-	for_each_pgdat(pgdat)
-		if ((ptr = __alloc_bootmem_core(pgdat->bdata, size,
-						 align, goal, 0)))
+	list_for_each_entry(bdata, &bdata_list, list)
+		if ((ptr = __alloc_bootmem_core(bdata, size, align, goal, 0)))
 			return(ptr);
 
 	/*
@@ -416,11 +435,11 @@ void * __init __alloc_bootmem_node(pg_da
 
 void * __init __alloc_bootmem_low(unsigned long size, unsigned long align, unsigned long goal)
 {
-	pg_data_t *pgdat = pgdat_list;
+	bootmem_data_t *bdata;
 	void *ptr;
 
-	for_each_pgdat(pgdat)
-		if ((ptr = __alloc_bootmem_core(pgdat->bdata, size,
+	list_for_each_entry(bdata, &bdata_list, list)
+		if ((ptr = __alloc_bootmem_core(bdata, size,
 						 align, goal, LOW32LIMIT)))
 			return(ptr);
 

