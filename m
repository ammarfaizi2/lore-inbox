Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265045AbUD3DBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265045AbUD3DBD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 23:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265046AbUD3DBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 23:01:03 -0400
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:62054 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265045AbUD3DAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 23:00:55 -0400
Message-ID: <4091C15D.7040800@yahoo.com.au>
Date: Fri, 30 Apr 2004 13:00:45 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>,
       brettspamacct@fastclick.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
References: <Pine.LNX.4.44.0404291027050.9152-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0404291027050.9152-100000@chimarrao.boston.redhat.com>
Content-Type: multipart/mixed;
 boundary="------------080701060500030107030905"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080701060500030107030905
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Rik van Riel wrote:
> On Thu, 29 Apr 2004, Nick Piggin wrote:
> 
> 
>>I'm not very impressed with the pagecache use-once logic, and I
>>have a patch to remove it completely and treat non-mapped touches
>>(IMO) more sanely.
> 
> 
> The basic idea of use-once isn't bad (search for LIRS and
> ARC page replacement), however the Linux implementation
> doesn't have any of the checks and balances that the
> researched replacement algorithms have...
> 
> However, adding the checks and balancing required for LIRS,
> ARC and CAR(S) isn't easy since it requires keeping track of
> a number of recently evicted pages.  That could be quite a 
> bit of infrastructure, though it might be well worth it.
> 

No, use once logic is good in theory I think. Unfortunately
our implementation is quite fragile IMO (although it seems
to have been "good enough").

This is what I'm currently doing (on top of a couple of other
patches, but you get the idea). I should be able to transform
it into a proper use-once logic if I pick up Nikita's inactive
list second chance bit.


--------------080701060500030107030905
Content-Type: text/x-patch;
 name="vm-dropbehind.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-dropbehind.patch"


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
