Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265176AbUD3MxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265176AbUD3MxE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 08:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265177AbUD3MxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 08:53:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50625 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265176AbUD3Mwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 08:52:55 -0400
Date: Fri, 30 Apr 2004 08:50:53 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>,
       <brettspamacct@fastclick.com>, <jgarzik@pobox.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
In-Reply-To: <4091C15D.7040800@yahoo.com.au>
Message-ID: <Pine.LNX.4.44.0404300849480.6976-200000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY=------------080701060500030107030905
Content-ID: <Pine.LNX.4.44.0404300849481.6976@chimarrao.boston.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--------------080701060500030107030905
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Content-ID: <Pine.LNX.4.44.0404300849482.6976@chimarrao.boston.redhat.com>

On Fri, 30 Apr 2004, Nick Piggin wrote:
> Rik van Riel wrote:

> > The basic idea of use-once isn't bad (search for LIRS and
> > ARC page replacement), however the Linux implementation
> > doesn't have any of the checks and balances that the
> > researched replacement algorithms have...

> No, use once logic is good in theory I think. Unfortunately
> our implementation is quite fragile IMO (although it seems
> to have been "good enough").

Hey, that's what I said ;))))

> This is what I'm currently doing (on top of a couple of other
> patches, but you get the idea). I should be able to transform
> it into a proper use-once logic if I pick up Nikita's inactive
> list second chance bit.

Ummm nope, there just isn't enough info to keep things
as balanced as ARC/LIRS/CAR(T) can do.  No good way to
auto-tune the sizes of the active and inactive lists.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

--------------080701060500030107030905
Content-Type: TEXT/X-PATCH; NAME="vm-dropbehind.patch"
Content-ID: <Pine.LNX.4.44.0404300849483.6976@chimarrao.boston.redhat.com>
Content-Description: 
Content-Disposition: INLINE; FILENAME="vm-dropbehind.patch"


Changes mark_page_accessed to only set the PageAccessed bit, and
not move pages around the LRUs. This means we don't have to take
the lru_lock, and it also makes page ageing and scanning consistient
and all handled in mm/vmscan.c


 include/linux/buffer_head.h            |    0 
 linux-2.6-npiggin/include/linux/swap.h |    5 ++-
 linux-2.6-npiggin/mm/filemap.c         |    6 ----
 linux-2.6-npiggin/mm/swap.c            |   45 ---------------------------------
 4 files changed, 4 insertions(+), 52 deletions(-)

diff -puN mm/filemap.c~vm-dropbehind mm/filemap.c
--- linux-2.6/mm/filemap.c~vm-dropbehind	2004-04-29 17:31:38.000000000 +1000
+++ linux-2.6-npiggin/mm/filemap.c	2004-04-29 17:31:38.000000000 +1000
@@ -663,11 +663,7 @@ page_ok:
 		if (mapping_writably_mapped(mapping))
 			flush_dcache_page(page);
 
-		/*
-		 * Mark the page accessed if we read the beginning.
-		 */
-		if (!offset)
-			mark_page_accessed(page);
+		mark_page_accessed(page);
 
 		/*
 		 * Ok, we have the page, and it's up-to-date, so
diff -puN mm/swap.c~vm-dropbehind mm/swap.c
--- linux-2.6/mm/swap.c~vm-dropbehind	2004-04-29 17:31:38.000000000 +1000
+++ linux-2.6-npiggin/mm/swap.c	2004-04-29 17:31:38.000000000 +1000
@@ -100,51 +100,6 @@ int rotate_reclaimable_page(struct page 
 	return 0;
 }
 
-/*
- * FIXME: speed this up?
- */
-void fastcall activate_page(struct page *page)
-{
-	struct zone *zone = page_zone(page);
-
-	spin_lock_irq(&zone->lru_lock);
-	if (PageLRU(page)
-		&& !PageActiveMapped(page) && !PageActiveUnmapped(page)) {
-
-		del_page_from_inactive_list(zone, page);
-
-		if (page_mapped(page)) {
-			SetPageActiveMapped(page);
-			add_page_to_active_mapped_list(zone, page);
-		} else {
-			SetPageActiveUnmapped(page);
-			add_page_to_active_unmapped_list(zone, page);
-		}
-		inc_page_state(pgactivate);
-	}
-	spin_unlock_irq(&zone->lru_lock);
-}
-
-/*
- * Mark a page as having seen activity.
- *
- * inactive,unreferenced	->	inactive,referenced
- * inactive,referenced		->	active,unreferenced
- * active,unreferenced		->	active,referenced
- */
-void fastcall mark_page_accessed(struct page *page)
-{
-	if (!PageActiveMapped(page) && !PageActiveUnmapped(page)
-			&& PageReferenced(page) && PageLRU(page)) {
-		activate_page(page);
-		ClearPageReferenced(page);
-	} else if (!PageReferenced(page)) {
-		SetPageReferenced(page);
-	}
-}
-
-EXPORT_SYMBOL(mark_page_accessed);
-
 /**
  * lru_cache_add: add a page to the page lists
  * @page: the page to add
diff -puN include/linux/swap.h~vm-dropbehind include/linux/swap.h
--- linux-2.6/include/linux/swap.h~vm-dropbehind	2004-04-29 17:31:38.000000000 +1000
+++ linux-2.6-npiggin/include/linux/swap.h	2004-04-30 12:55:02.000000000 +1000
@@ -165,12 +165,13 @@ extern unsigned int nr_free_pagecache_pa
 /* linux/mm/swap.c */
 extern void FASTCALL(lru_cache_add(struct page *));
 extern void FASTCALL(lru_cache_add_active(struct page *));
-extern void FASTCALL(activate_page(struct page *));
-extern void FASTCALL(mark_page_accessed(struct page *));
 extern void lru_add_drain(void);
 extern int rotate_reclaimable_page(struct page *page);
 extern void swap_setup(void);
 
+/* Mark a page as having seen activity. */
+#define mark_page_accessed(page)	SetPageReferenced(page)
+
 /* linux/mm/vmscan.c */
 extern int try_to_free_pages(struct zone **, unsigned int, unsigned int);
 extern int shrink_all_memory(int);
diff -puN include/linux/mm_inline.h~vm-dropbehind include/linux/mm_inline.h
diff -puN mm/memory.c~vm-dropbehind mm/memory.c
diff -puN mm/shmem.c~vm-dropbehind mm/shmem.c
diff -puN include/linux/buffer_head.h~vm-dropbehind include/linux/buffer_head.h

_

--------------080701060500030107030905--
