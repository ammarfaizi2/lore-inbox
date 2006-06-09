Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030407AbWFITDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030407AbWFITDf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 15:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030406AbWFITDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 15:03:35 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:4754 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030407AbWFITDe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 15:03:34 -0400
Date: Fri, 9 Jun 2006 12:03:22 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hugh@veritas.com,
       ak@suse.de, npiggin@suse.de
Subject: zoned VM counters: Drop VM_STAT macros and vm_stat_t
Message-ID: <Pine.LNX.4.64.0606091202200.1028@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems that they are not needed since UP has no special needs.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc6-mm1/mm/page_alloc.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/page_alloc.c	2006-06-09 11:41:32.525809812 -0700
+++ linux-2.6.17-rc6-mm1/mm/page_alloc.c	2006-06-09 12:00:00.272620254 -0700
@@ -639,13 +639,13 @@ char *vm_stat_item_descr[NR_STAT_ITEMS] 
  *
  * vm_stat contains the global counters
  */
-vm_stat_t vm_stat[NR_STAT_ITEMS];
+atomic_long_t vm_stat[NR_STAT_ITEMS];
 
 static inline void zone_page_state_add(long x, struct zone *zone,
 				 enum zone_stat_item item)
 {
-	VM_STAT_ADD(zone->vm_stat[item], x);
-	VM_STAT_ADD(vm_stat[item], x);
+	atomic_long_add(x, &zone->vm_stat[item]);
+	atomic_long_add(x, &vm_stat[item]);
 }
 
 #ifdef CONFIG_SMP
@@ -899,7 +899,7 @@ unsigned long node_page_state(int node, 
 	long v = 0;
 
 	for (i = 0; i < MAX_NR_ZONES; i++)
-		v += VM_STAT_GET(zones[i].vm_stat[item]);
+		v += atomic_long_read(&zones[i].vm_stat[item]);
 	if (v < 0)
 		v = 0;
 	return v;
Index: linux-2.6.17-rc6-mm1/include/linux/page-flags.h
===================================================================
--- linux-2.6.17-rc6-mm1.orig/include/linux/page-flags.h	2006-06-09 10:30:52.400790734 -0700
+++ linux-2.6.17-rc6-mm1/include/linux/page-flags.h	2006-06-09 11:47:36.275737668 -0700
@@ -223,11 +223,11 @@ extern void __mod_page_state_offset(unsi
 /*
  * Zone based accounting with per cpu differentials.
  */
-extern vm_stat_t vm_stat[NR_STAT_ITEMS];
+extern atomic_long_t vm_stat[NR_STAT_ITEMS];
 
 static inline unsigned long global_page_state(enum zone_stat_item item)
 {
-	long x = VM_STAT_GET(vm_stat[item]);
+	long x = atomic_long_read(&vm_stat[item]);
 #ifdef CONFIG_SMP
 	if (x < 0)
 		x = 0;
@@ -238,7 +238,7 @@ static inline unsigned long global_page_
 static inline unsigned long zone_page_state(struct zone *zone,
 					enum zone_stat_item item)
 {
-	long x = VM_STAT_GET(zone->vm_stat[item]);
+	long x = atomic_long_read(&zone->vm_stat[item]);
 #ifdef CONFIG_SMP
 	if (x < 0)
 		x = 0;
Index: linux-2.6.17-rc6-mm1/include/linux/mmzone.h
===================================================================
--- linux-2.6.17-rc6-mm1.orig/include/linux/mmzone.h	2006-06-09 11:26:59.388494756 -0700
+++ linux-2.6.17-rc6-mm1/include/linux/mmzone.h	2006-06-09 11:45:11.299366735 -0700
@@ -59,16 +59,6 @@ enum zone_stat_item {
 	NR_BOUNCE,
 	NR_STAT_ITEMS };
 
-#ifdef CONFIG_SMP
-typedef atomic_long_t vm_stat_t;
-#define VM_STAT_GET(x) atomic_long_read(&(x))
-#define VM_STAT_ADD(x,v) atomic_long_add(v, &(x))
-#else
-typedef unsigned long vm_stat_t;
-#define VM_STAT_GET(x) (x)
-#define VM_STAT_ADD(x,v) (x) += (v)
-#endif
-
 struct per_cpu_pages {
 	int count;		/* number of pages in the list */
 	int high;		/* high watermark, emptying needed */
@@ -198,7 +188,7 @@ struct zone {
 	atomic_t		reclaim_in_progress;
 
 	/* Zone statistics */
-	vm_stat_t		vm_stat[NR_STAT_ITEMS];
+	atomic_long_t		vm_stat[NR_STAT_ITEMS];
 
 	/*
 	 * prev_priority holds the scanning priority for this zone.  It is
