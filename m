Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317396AbSH1R1D>; Wed, 28 Aug 2002 13:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317743AbSH1R1D>; Wed, 28 Aug 2002 13:27:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42256 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317396AbSH1R1C>;
	Wed, 28 Aug 2002 13:27:02 -0400
Message-ID: <3D6D0B97.D1A40550@zip.com.au>
Date: Wed, 28 Aug 2002 10:42:47 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>,
       lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: MM patches against 2.5.31
References: <3D644C70.6D100EA5@zip.com.au> <E17jjWN-0002fo-00@starship> <20020828131445.25959.qmail@thales.mathematik.uni-ulm.de> <E17k6Sy-0002s6-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On Wednesday 28 August 2002 15:14, Christian Ehrhardt wrote:
> > Side note: The BUG in __pagevec_lru_del seems strange. refill_inactive
> > or shrink_cache could have removed the page from the lru before
> > __pagevec_lru_del acquired the lru lock.
> 
> It's suspect all right.  If there's a chain of assumptions that proves
> the page is always on the lru at the point, I haven't seen it yet.

Yeah.  __pagevec_lru_del is only used by invalidate_inode_pages.
A very simple solution is to just delete it.

untested code:

 include/linux/pagevec.h |    7 -------
 mm/filemap.c            |   10 +++++-----
 mm/swap.c               |   28 ----------------------------
 3 files changed, 5 insertions(+), 40 deletions(-)

--- 2.5.32/mm/filemap.c~pagevec_lru_del	Wed Aug 28 09:51:51 2002
+++ 2.5.32-akpm/mm/filemap.c	Wed Aug 28 09:51:51 2002
@@ -116,10 +116,10 @@ void invalidate_inode_pages(struct inode
 	struct list_head *head, *curr;
 	struct page * page;
 	struct address_space *mapping = inode->i_mapping;
-	struct pagevec lru_pvec;
+	struct pagevec pvec;
 
 	head = &mapping->clean_pages;
-	pagevec_init(&lru_pvec);
+	pagevec_init(&pvec);
 	write_lock(&mapping->page_lock);
 	curr = head->next;
 
@@ -143,8 +143,8 @@ void invalidate_inode_pages(struct inode
 
 		__remove_from_page_cache(page);
 		unlock_page(page);
-		if (!pagevec_add(&lru_pvec, page))
-			__pagevec_lru_del(&lru_pvec);
+		if (!pagevec_add(&pvec, page))
+			__pagevec_release(&pvec);
 		continue;
 unlock:
 		unlock_page(page);
@@ -152,7 +152,7 @@ unlock:
 	}
 
 	write_unlock(&mapping->page_lock);
-	pagevec_lru_del(&lru_pvec);
+	pagevec_release(&pvec);
 }
 
 static int do_invalidatepage(struct page *page, unsigned long offset)
--- 2.5.32/include/linux/pagevec.h~pagevec_lru_del	Wed Aug 28 09:51:51 2002
+++ 2.5.32-akpm/include/linux/pagevec.h	Wed Aug 28 09:51:51 2002
@@ -18,7 +18,6 @@ void __pagevec_release(struct pagevec *p
 void __pagevec_release_nonlru(struct pagevec *pvec);
 void __pagevec_free(struct pagevec *pvec);
 void __pagevec_lru_add(struct pagevec *pvec);
-void __pagevec_lru_del(struct pagevec *pvec);
 void lru_add_drain(void);
 void pagevec_deactivate_inactive(struct pagevec *pvec);
 
@@ -69,9 +68,3 @@ static inline void pagevec_lru_add(struc
 	if (pagevec_count(pvec))
 		__pagevec_lru_add(pvec);
 }
-
-static inline void pagevec_lru_del(struct pagevec *pvec)
-{
-	if (pagevec_count(pvec))
-		__pagevec_lru_del(pvec);
-}
--- 2.5.32/mm/swap.c~pagevec_lru_del	Wed Aug 28 09:51:51 2002
+++ 2.5.32-akpm/mm/swap.c	Wed Aug 28 09:51:58 2002
@@ -214,34 +214,6 @@ void __pagevec_lru_add(struct pagevec *p
 }
 
 /*
- * Remove the passed pages from the LRU, then drop the caller's refcount on
- * them.  Reinitialises the caller's pagevec.
- */
-void __pagevec_lru_del(struct pagevec *pvec)
-{
-	int i;
-	struct zone *zone = NULL;
-
-	for (i = 0; i < pagevec_count(pvec); i++) {
-		struct page *page = pvec->pages[i];
-		struct zone *pagezone = page_zone(page);
-
-		if (pagezone != zone) {
-			if (zone)
-				spin_unlock_irq(&zone->lru_lock);
-			zone = pagezone;
-			spin_lock_irq(&zone->lru_lock);
-		}
-		if (!TestClearPageLRU(page))
-			BUG();
-		del_page_from_lru(zone, page);
-	}
-	if (zone)
-		spin_unlock_irq(&zone->lru_lock);
-	pagevec_release(pvec);
-}
-
-/*
  * Perform any setup for the swap system
  */
 void __init swap_setup(void)

.
