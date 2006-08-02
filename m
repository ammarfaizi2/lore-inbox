Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbWHBUto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbWHBUto (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 16:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWHBUto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 16:49:44 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:39846 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751353AbWHBUtn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 16:49:43 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 1/3] swsusp: Fix mark_free_pages
Date: Wed, 2 Aug 2006 22:48:54 +0200
User-Agent: KMail/1.9.3
Cc: Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
References: <200608021842.21774.rjw@sisk.pl> <200608022212.48293.rjw@sisk.pl> <20060802203005.GF8124@elf.ucw.cz>
In-Reply-To: <20060802203005.GF8124@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608022248.54162.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 August 2006 22:30, Pavel Machek wrote:
> Hi!
> 
> Looks good to me (ACK).
> 
> >  			if (page) {
> > -				long *src, *dst;
> > -				int n;
> > +				void *ptr = page_address(page);;
> 
> You probably want to remove one of ";"s.

Ouch.

I hope this is the final one.
---
Clean up mm/page_alloc.c#mark_free_pages() and make it avoid clearing
PageNosaveFree for PageNosave pages.  This allows us to get rid of an ugly
hack in kernel/power/snapshot.c#copy_data_pages().

Additionally, the page-copying loop in copy_data_pages() is moved to an
inline function.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/snapshot.c |   27 +++++++++++++--------------
 mm/page_alloc.c         |   24 ++++++++++++++++--------
 2 files changed, 29 insertions(+), 22 deletions(-)

Index: linux-2.6.18-rc2-mm1/mm/page_alloc.c
===================================================================
--- linux-2.6.18-rc2-mm1.orig/mm/page_alloc.c
+++ linux-2.6.18-rc2-mm1/mm/page_alloc.c
@@ -703,7 +703,8 @@ static void __drain_pages(unsigned int c
 
 void mark_free_pages(struct zone *zone)
 {
-	unsigned long zone_pfn, flags;
+	unsigned long pfn, max_zone_pfn;
+	unsigned long flags;
 	int order;
 	struct list_head *curr;
 
@@ -711,18 +712,25 @@ void mark_free_pages(struct zone *zone)
 		return;
 
 	spin_lock_irqsave(&zone->lock, flags);
-	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
-		ClearPageNosaveFree(pfn_to_page(zone_pfn + zone->zone_start_pfn));
+
+	max_zone_pfn = zone->zone_start_pfn + zone->spanned_pages;
+	for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; pfn++)
+		if (pfn_valid(pfn)) {
+			struct page *page = pfn_to_page(pfn);
+
+			if (!PageNosave(page))
+				ClearPageNosaveFree(page);
+		}
 
 	for (order = MAX_ORDER - 1; order >= 0; --order)
 		list_for_each(curr, &zone->free_area[order].free_list) {
-			unsigned long start_pfn, i;
+			unsigned long i;
 
-			start_pfn = page_to_pfn(list_entry(curr, struct page, lru));
+			pfn = page_to_pfn(list_entry(curr, struct page, lru));
+			for (i = 0; i < (1UL << order); i++)
+				SetPageNosaveFree(pfn_to_page(pfn + i));
+		}
 
-			for (i=0; i < (1<<order); i++)
-				SetPageNosaveFree(pfn_to_page(start_pfn+i));
-	}
 	spin_unlock_irqrestore(&zone->lock, flags);
 }
 
Index: linux-2.6.18-rc2-mm1/kernel/power/snapshot.c
===================================================================
--- linux-2.6.18-rc2-mm1.orig/kernel/power/snapshot.c
+++ linux-2.6.18-rc2-mm1/kernel/power/snapshot.c
@@ -208,37 +208,36 @@ unsigned int count_data_pages(void)
 	return n;
 }
 
+static inline void copy_data_page(long *dst, long *src)
+{
+	int n;
+
+	/* copy_page and memcpy are not usable for copying task structs. */
+	for (n = PAGE_SIZE / sizeof(long); n; n--)
+		*dst++ = *src++;
+}
+
 static void copy_data_pages(struct pbe *pblist)
 {
 	struct zone *zone;
 	unsigned long pfn, max_zone_pfn;
-	struct pbe *pbe, *p;
+	struct pbe *pbe;
 
 	pbe = pblist;
 	for_each_zone (zone) {
 		if (is_highmem(zone))
 			continue;
 		mark_free_pages(zone);
-		/* This is necessary for swsusp_free() */
-		for_each_pb_page (p, pblist)
-			SetPageNosaveFree(virt_to_page(p));
-		for_each_pbe (p, pblist)
-			SetPageNosaveFree(virt_to_page(p->address));
 		max_zone_pfn = zone->zone_start_pfn + zone->spanned_pages;
 		for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; pfn++) {
 			struct page *page = saveable_page(pfn);
 
 			if (page) {
-				long *src, *dst;
-				int n;
+				void *ptr = page_address(page);
 
 				BUG_ON(!pbe);
-				pbe->orig_address = (unsigned long)page_address(page);
-				/* copy_page and memcpy are not usable for copying task structs. */
-				dst = (long *)pbe->address;
-				src = (long *)pbe->orig_address;
-				for (n = PAGE_SIZE / sizeof(long); n; n--)
-					*dst++ = *src++;
+				copy_data_page((void *)pbe->address, ptr);
+				pbe->orig_address = (unsigned long)ptr;
 				pbe = pbe->next;
 			}
 		}
