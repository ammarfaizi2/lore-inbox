Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932471AbWGHAwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbWGHAwn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 20:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbWGHAwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 20:52:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15301 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932471AbWGHAwn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 20:52:43 -0400
Date: Fri, 7 Jul 2006 17:56:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, hugh@veritas.com, hch@infradead.org,
       kernel@kolivas.org, marcelo@kvack.org, arjan@infradead.org,
       nickpiggin@yahoo.com.au, clameter@sgi.com, ak@suse.de,
       kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: [PATCH 07/11] Use enum to define zones, reformat and comment
Message-Id: <20060707175602.71f47ec6.akpm@osdl.org>
In-Reply-To: <20060707231846.3790.10365.sendpatchset@schroedinger.engr.sgi.com>
References: <20060707231810.3790.19313.sendpatchset@schroedinger.engr.sgi.com>
	<20060707231846.3790.10365.sendpatchset@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> +typedef enum {
> ...
> +} zones_t;

ooooh noooooo you don't, big guy.



diff -puN include/linux/mm.h~reduce-max_nr_zones-use-enum-to-define-zones-reformat-and-comment-cleanup include/linux/mm.h
--- a/include/linux/mm.h~reduce-max_nr_zones-use-enum-to-define-zones-reformat-and-comment-cleanup
+++ a/include/linux/mm.h
@@ -469,7 +469,7 @@ void split_page(struct page *page, unsig
 #define SECTIONS_MASK		((1UL << SECTIONS_WIDTH) - 1)
 #define ZONETABLE_MASK		((1UL << ZONETABLE_SHIFT) - 1)
 
-static inline zones_t page_zonenum(struct page *page)
+static inline enum zone_type page_zonenum(struct page *page)
 {
 	return (page->flags >> ZONES_PGSHIFT) & ZONES_MASK;
 }
@@ -498,7 +498,7 @@ static inline unsigned long page_to_sect
 	return (page->flags >> SECTIONS_PGSHIFT) & SECTIONS_MASK;
 }
 
-static inline void set_page_zone(struct page *page, zones_t zone)
+static inline void set_page_zone(struct page *page, enum zone_type zone)
 {
 	page->flags &= ~(ZONES_MASK << ZONES_PGSHIFT);
 	page->flags |= (zone & ZONES_MASK) << ZONES_PGSHIFT;
@@ -515,7 +515,7 @@ static inline void set_page_section(stru
 	page->flags |= (section & SECTIONS_MASK) << SECTIONS_PGSHIFT;
 }
 
-static inline void set_page_links(struct page *page, zones_t zone,
+static inline void set_page_links(struct page *page, enum zone_type zone,
 	unsigned long node, unsigned long pfn)
 {
 	set_page_zone(page, zone);
diff -puN include/linux/mmzone.h~reduce-max_nr_zones-use-enum-to-define-zones-reformat-and-comment-cleanup include/linux/mmzone.h
--- a/include/linux/mmzone.h~reduce-max_nr_zones-use-enum-to-define-zones-reformat-and-comment-cleanup
+++ a/include/linux/mmzone.h
@@ -87,7 +87,7 @@ struct per_cpu_pageset {
 #define zone_pcp(__z, __cpu) (&(__z)->pageset[(__cpu)])
 #endif
 
-typedef enum {
+enum zone_type {
 	/*
 	 * ZONE_DMA is used when there are devices that are not able
 	 * to do DMA to all of addressable memory (ZONE_NORMAL). Then we
@@ -131,7 +131,7 @@ typedef enum {
 	ZONE_HIGHMEM,
 
 	MAX_NR_ZONES
-} zones_t;
+};
 
 #define	ZONES_SHIFT		2	/* ceil(log2(MAX_NR_ZONES)) */
 
@@ -400,12 +400,12 @@ static inline int populated_zone(struct 
 	return (!!zone->present_pages);
 }
 
-static inline int is_highmem_idx(zones_t idx)
+static inline int is_highmem_idx(enum zone_type idx)
 {
 	return (idx == ZONE_HIGHMEM);
 }
 
-static inline int is_normal_idx(zones_t idx)
+static inline int is_normal_idx(enum zone_type idx)
 {
 	return (idx == ZONE_NORMAL);
 }
diff -puN mm/page_alloc.c~reduce-max_nr_zones-use-enum-to-define-zones-reformat-and-comment-cleanup mm/page_alloc.c
--- a/mm/page_alloc.c~reduce-max_nr_zones-use-enum-to-define-zones-reformat-and-comment-cleanup
+++ a/mm/page_alloc.c
@@ -1498,7 +1498,8 @@ static void __meminit build_zonelists(pg
 static void __meminit build_zonelists(pg_data_t *pgdat)
 {
 	int i, node, local_node;
-	zones_t k,j;
+	enum zone_type k;
+	enum zone_type j;
 
 	local_node = pgdat->node_id;
 	for (i = 0; i < GFP_ZONETYPES; i++) {
@@ -1686,7 +1687,7 @@ void zone_init_free_lists(struct pglist_
 }
 
 #define ZONETABLE_INDEX(x, zone_nr)	((x << ZONES_SHIFT) | zone_nr)
-void zonetable_add(struct zone *zone, int nid, zones_t zid,
+void zonetable_add(struct zone *zone, int nid, enum zone_type zid,
 		unsigned long pfn, unsigned long size)
 {
 	unsigned long snum = pfn_to_section_nr(pfn);
@@ -1969,7 +1970,7 @@ __meminit int init_currently_empty_zone(
 static void __meminit free_area_init_core(struct pglist_data *pgdat,
 		unsigned long *zones_size, unsigned long *zholes_size)
 {
-	zones_t j;
+	enum zone_type j;
 	int nid = pgdat->node_id;
 	unsigned long zone_start_pfn = pgdat->node_start_pfn;
 	int ret;
_

