Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbWGHAHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbWGHAHA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 20:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbWGHAGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 20:06:49 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:62162 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932428AbWGHAFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 20:05:33 -0400
Date: Fri, 7 Jul 2006 17:05:22 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Hellwig <hch@infradead.org>,
       Marcelo Tosatti <marcelo@kvack.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Martin Bligh <mbligh@google.com>, Christoph Lameter <clameter@sgi.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Andi Kleen <ak@suse.de>
Message-Id: <20060708000522.3829.85832.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060708000501.3829.25578.sendpatchset@schroedinger.engr.sgi.com>
References: <20060708000501.3829.25578.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC 4/8] page allocator: Optional ZONE_DMA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make ZONE_DMA optional in the page allocator

- ifdef all code for ZONE_DMA and related definitions.

- Without ZONE_DMA, ZONE_HIGHMEM and ZONE_DMA32 we fall back
  to an empty GFP_ZONEMASK and a ZONES_SHIFT of zero (since there
  is only one zone....).

- We need to fix the use of ZONE_DMA in the memory policy layer.
  ZONE_DMA is used there as the first zone so use 0 instead.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-mm6/include/linux/mmzone.h
===================================================================
--- linux-2.6.17-mm6.orig/include/linux/mmzone.h	2006-07-07 15:29:50.265384678 -0700
+++ linux-2.6.17-mm6/include/linux/mmzone.h	2006-07-07 16:44:03.067357437 -0700
@@ -88,6 +88,7 @@ struct per_cpu_pageset {
 #endif
 
 typedef enum {
+#ifdef CONFIG_ZONE_DMA
 	/*
 	 * ZONE_DMA is used when there are devices that are not able
 	 * to do DMA to all of addressable memory (ZONE_NORMAL). Then we
@@ -108,6 +109,7 @@ typedef enum {
 	 * 			<16M.
 	 */
 	ZONE_DMA,
+#endif
 #ifdef CONFIG_ZONE_DMA32
 	/*
 	 * x86_64 needs two ZONE_DMAs because it supports devices that are
@@ -172,8 +174,13 @@ typedef enum {
 #define GFP_ZONEMASK		0x03
 #define	ZONES_SHIFT		2
 #else
+#ifdef CONFIG_DMA
 #define GFP_ZONEMASK		0x01
 #define ZONES_SHIFT		1
+#else
+#define GFP_ZONEMASK		0x00
+#define ZONES_SHIFT		0
+#endif
 #endif
 #endif
 
@@ -464,7 +471,11 @@ static inline int is_dma32(struct zone *
 
 static inline int is_dma(struct zone *zone)
 {
+#ifdef CONFIG_ZONE_DMA
 	return zone == zone->zone_pgdat->node_zones + ZONE_DMA;
+#else
+	return 0;
+#endif
 }
 
 /* These two functions are used to setup the per zone pages min values */
Index: linux-2.6.17-mm6/mm/page_alloc.c
===================================================================
--- linux-2.6.17-mm6.orig/mm/page_alloc.c	2006-07-07 15:29:50.265384678 -0700
+++ linux-2.6.17-mm6/mm/page_alloc.c	2006-07-07 16:44:03.069310441 -0700
@@ -69,7 +69,9 @@ static void __free_pages_ok(struct page 
  * don't need any ZONE_NORMAL reservation
  */
 int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES-1] = {
+#ifdef CONFIG_ZONE_DMA
 	 256,
+#endif
 #ifdef CONFIG_ZONE_DMA32
 	 256,
 #endif
@@ -88,7 +90,9 @@ struct zone *zone_table[1 << ZONETABLE_S
 EXPORT_SYMBOL(zone_table);
 
 static char *zone_names[MAX_NR_ZONES] = {
+#ifdef CONFIG_ZONE_DMA
 	 "DMA",
+#endif
 #ifdef CONFIG_ZONE_DMA32
 	 "DMA32",
 #endif
@@ -1485,8 +1489,10 @@ static inline int highest_zone(int zone_
 	if (zone_bits & (__force int)__GFP_DMA32)
 		res = ZONE_DMA32;
 #endif
+#ifdef CONFIG_ZONE_DMA
 	if (zone_bits & (__force int)__GFP_DMA)
 		res = ZONE_DMA;
+#endif
 	return res;
 }
 
Index: linux-2.6.17-mm6/mm/mempolicy.c
===================================================================
--- linux-2.6.17-mm6.orig/mm/mempolicy.c	2006-07-06 11:46:23.152072668 -0700
+++ linux-2.6.17-mm6/mm/mempolicy.c	2006-07-07 16:44:03.070286943 -0700
@@ -105,7 +105,7 @@ static struct kmem_cache *sn_cache;
 
 /* Highest zone. An specific allocation for a zone below that is not
    policied. */
-int policy_zone = ZONE_DMA;
+int policy_zone = 0;
 
 struct mempolicy default_policy = {
 	.refcnt = ATOMIC_INIT(1), /* never free it */
