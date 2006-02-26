Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWBZCWC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWBZCWC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 21:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWBZCV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 21:21:59 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:34990 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751167AbWBZCV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 21:21:58 -0500
Date: Sun, 26 Feb 2006 11:21:38 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Aubin LaBrosse <aubin@stormboxes.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] for_each_online_pgdat (take2)  [2/5]  for_each_bootmem
Message-Id: <20060226112138.fbcebe0c.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <44006C0E.7030106@stormboxes.com>
References: <20060225151013.701ecc49.kamezawa.hiroyu@jp.fujitsu.com>
	<44006C0E.7030106@stormboxes.com>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Feb 2006 09:39:10 -0500
Aubin LaBrosse <aubin@stormboxes.com> wrote
>
> > +	/* insert in order */
> > +	list_for_each_entry(ent, &bdata_list, list) {
> > +		if (ent->node_boot_start < ent->node_boot_start) {
> >   
>        not a kernel hacker, but even I know that that 'if' isn't what 
> you want. :)
Oh, yes. thank you.

this is fixed one.
--Kame

This patch adds list_head to bootmem_data_t and make bootmems use it.
bootmem list is sorted by node_boot_start.

Only nodes against which init_bootmem() is called will be linked to the list.
(i386 allocates bootmem from only one node not from all online nodes.)

A summary:
 1. for_each_online_pgdat() traverses all *online* nodes.
 2. alloc_bootmem() allocates memory only from initialized-for-bootmem nodes.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: linux-2.6.16-rc4-mm2/include/linux/bootmem.h
===================================================================
--- linux-2.6.16-rc4-mm2.orig/include/linux/bootmem.h
+++ linux-2.6.16-rc4-mm2/include/linux/bootmem.h
@@ -38,6 +38,7 @@ typedef struct bootmem_data {
 	unsigned long last_pos;
 	unsigned long last_success;	/* Previous allocation point.  To speed
 					 * up searching */
+	struct list_head list;
 } bootmem_data_t;
 
 extern unsigned long __init bootmem_bootmap_pages (unsigned long);
Index: linux-2.6.16-rc4-mm2/mm/bootmem.c
===================================================================
--- linux-2.6.16-rc4-mm2.orig/mm/bootmem.c
+++ linux-2.6.16-rc4-mm2/mm/bootmem.c
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
+		if (bdata->node_boot_start < ent->node_boot_start) {
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
 

