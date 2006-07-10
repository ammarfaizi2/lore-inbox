Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965242AbWGJVdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965242AbWGJVdO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 17:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965244AbWGJVdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 17:33:13 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:59088 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S965242AbWGJVdN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 17:33:13 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm 1/2] swsusp: clean up browsing of pfns
Date: Mon, 10 Jul 2006 22:51:39 +0200
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
References: <200607102240.45365.rjw@sisk.pl>
In-Reply-To: <200607102240.45365.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607102251.40083.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up some loops over pfns for each zone in snapshot.c: reduce the number
of additions to perform, rework detection of saveable pages and make the code
a bit less difficult to understand, hopefully.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/snapshot.c |   62 ++++++++++++++++++++++++------------------------
 1 files changed, 32 insertions(+), 30 deletions(-)

Index: linux-2.6.18-rc1/kernel/power/snapshot.c
===================================================================
--- linux-2.6.18-rc1.orig/kernel/power/snapshot.c	2006-07-09 19:48:05.000000000 +0200
+++ linux-2.6.18-rc1/kernel/power/snapshot.c	2006-07-09 20:26:19.000000000 +0200
@@ -156,7 +156,7 @@ static inline int save_highmem(void) {re
 static inline int restore_highmem(void) {return 0;}
 #endif
 
-static int pfn_is_nosave(unsigned long pfn)
+static inline int pfn_is_nosave(unsigned long pfn)
 {
 	unsigned long nosave_begin_pfn = __pa(&__nosave_begin) >> PAGE_SHIFT;
 	unsigned long nosave_end_pfn = PAGE_ALIGN(__pa(&__nosave_end)) >> PAGE_SHIFT;
@@ -167,43 +167,43 @@ static int pfn_is_nosave(unsigned long p
  *	saveable - Determine whether a page should be cloned or not.
  *	@pfn:	The page PFN
  *
- *	We save a page if it's Reserved, and not in the range of pages
- *	statically defined as 'unsaveable', or if it isn't reserved, and
- *	isn't part of a free chunk of pages.
+ *	We save a page if it isn't Nosave, and is not in the range of pages
+ *	statically defined as 'unsaveable', and it
+ *	isn't a part of a free chunk of pages.
  */
 
-static int saveable(struct zone *zone, unsigned long *zone_pfn)
+static struct page *saveable_page(unsigned long pfn)
 {
-	unsigned long pfn = *zone_pfn + zone->zone_start_pfn;
 	struct page *page;
 
 	if (!pfn_valid(pfn))
-		return 0;
+		return NULL;
 
 	page = pfn_to_page(pfn);
-	BUG_ON(PageReserved(page) && PageNosave(page));
+
 	if (PageNosave(page))
-		return 0;
+		return NULL;
 	if (PageReserved(page) && pfn_is_nosave(pfn))
-		return 0;
+		return NULL;
 	if (PageNosaveFree(page))
-		return 0;
+		return NULL;
 
-	return 1;
+	return page;
 }
 
 unsigned int count_data_pages(void)
 {
 	struct zone *zone;
-	unsigned long zone_pfn;
+	unsigned long pfn, max_zone_pfn;
 	unsigned int n = 0;
 
 	for_each_zone (zone) {
 		if (is_highmem(zone))
 			continue;
 		mark_free_pages(zone);
-		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
-			n += saveable(zone, &zone_pfn);
+		max_zone_pfn = zone->zone_start_pfn + zone->spanned_pages;
+		for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; pfn++)
+			n += !!saveable_page(pfn);
 	}
 	return n;
 }
@@ -211,7 +211,7 @@ unsigned int count_data_pages(void)
 static void copy_data_pages(struct pbe *pblist)
 {
 	struct zone *zone;
-	unsigned long zone_pfn;
+	unsigned long pfn, max_zone_pfn;
 	struct pbe *pbe, *p;
 
 	pbe = pblist;
@@ -224,13 +224,14 @@ static void copy_data_pages(struct pbe *
 			SetPageNosaveFree(virt_to_page(p));
 		for_each_pbe (p, pblist)
 			SetPageNosaveFree(virt_to_page(p->address));
-		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
-			if (saveable(zone, &zone_pfn)) {
-				struct page *page;
+		max_zone_pfn = zone->zone_start_pfn + zone->spanned_pages;
+		for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; pfn++) {
+			struct page *page = saveable_page(pfn);
+
+			if (page) {
 				long *src, *dst;
 				int n;
 
-				page = pfn_to_page(zone_pfn + zone->zone_start_pfn);
 				BUG_ON(!pbe);
 				pbe->orig_address = (unsigned long)page_address(page);
 				/* copy_page and memcpy are not usable for copying task structs. */
@@ -383,13 +384,14 @@ static struct pbe *alloc_pagedir(unsigne
 void swsusp_free(void)
 {
 	struct zone *zone;
-	unsigned long zone_pfn;
+	unsigned long pfn, max_zone_pfn;
 
 	for_each_zone(zone) {
-		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
-			if (pfn_valid(zone_pfn + zone->zone_start_pfn)) {
-				struct page *page;
-				page = pfn_to_page(zone_pfn + zone->zone_start_pfn);
+		max_zone_pfn = zone->zone_start_pfn + zone->spanned_pages;
+		for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; pfn++)
+			if (pfn_valid(pfn)) {
+				struct page *page = pfn_to_page(pfn);
+
 				if (PageNosave(page) && PageNosaveFree(page)) {
 					ClearPageNosave(page);
 					ClearPageNosaveFree(page);
@@ -598,7 +600,7 @@ int snapshot_read_next(struct snapshot_h
 static int mark_unsafe_pages(struct pbe *pblist)
 {
 	struct zone *zone;
-	unsigned long zone_pfn;
+	unsigned long pfn, max_zone_pfn;
 	struct pbe *p;
 
 	if (!pblist) /* a sanity check */
@@ -606,10 +608,10 @@ static int mark_unsafe_pages(struct pbe 
 
 	/* Clear page flags */
 	for_each_zone (zone) {
-		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
-			if (pfn_valid(zone_pfn + zone->zone_start_pfn))
-				ClearPageNosaveFree(pfn_to_page(zone_pfn +
-					zone->zone_start_pfn));
+		max_zone_pfn = zone->zone_start_pfn + zone->spanned_pages;
+		for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; pfn++)
+			if (pfn_valid(pfn))
+				ClearPageNosaveFree(pfn_to_page(pfn));
 	}
 
 	/* Mark orig addresses */

