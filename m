Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161230AbWG1Sne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161230AbWG1Sne (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 14:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161234AbWG1Sne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 14:43:34 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:61414 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1161232AbWG1Snd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 14:43:33 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Al Boldi <a1426z@gawab.com>
Subject: Re: swsusp hangs on headless resume-from-ram
Date: Fri, 28 Jul 2006 20:42:51 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <200607262206.48801.a1426z@gawab.com> <200607281658.37794.a1426z@gawab.com> <200607281623.55290.rjw@sisk.pl>
In-Reply-To: <200607281623.55290.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607282042.51831.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 July 2006 16:23, Rafael J. Wysocki wrote:
> On Friday 28 July 2006 15:58, Al Boldi wrote:
> > Rafael J. Wysocki wrote:
> > > On Wednesday 26 July 2006 23:34, Al Boldi wrote:
> > > > Rafael J. Wysocki wrote:
> > > > > On Wednesday 26 July 2006 21:06, Al Boldi wrote:
> > > > > > swsusp is really great, most of the time.  But sometimes it hangs
> > > > > > after coming out of STR.  I suspect it's got something to do with
> > > > > > display access, as this problem seems hw related.  So I removed the
> > > > > > display card, and it positively does not resume from ram on 2.6.16+.
> > > > > >
> > > > > > Any easy fix for this?
> > > > >
> > > > > I have one idea, but you'll need a patch to test.  I'll try to prepare
> > > > > it tomorrow.
> > > > >
> > > > > I guess your box is an i386?
> > > >
> > > > That should be assumed by default :)
> > >
> > > I had hoped I would be able to test it somewhere, but I couldn't.  I hope
> > > it will compile. :-)
> > >
> > > If it does, please send me the output of dmesg after a fresh boot.
> > 
> > See attached.  patched against 2.6.17.
> 
> Well, the nosave ranges are the same in both cases, so it doesn't look
> very promising.
> 
> Have you tried to suspend with the patch applied?

Ouch, sorry, it won't work.  It will have a chance to work with the appended
patch applied.

However, I've just noticed you said it didn't resume from RAM and these
two patches could only fix the resume from disk. ;-)  As far as the
resume from RAM is concerned, I can only advise you to use a
newest possible kernel and see if the problem is still there.

Greetings,
Rafael


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
  *	@pfn:	The page
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
