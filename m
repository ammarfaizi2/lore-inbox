Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318917AbSG1HUs>; Sun, 28 Jul 2002 03:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318918AbSG1HUs>; Sun, 28 Jul 2002 03:20:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51461 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318917AbSG1HUq>;
	Sun, 28 Jul 2002 03:20:46 -0400
Message-ID: <3D439E10.67A839A5@zip.com.au>
Date: Sun, 28 Jul 2002 00:32:32 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 2/13] remove pages from the LRU in __free_pages_ok()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



There are some situations where a page's final release is performed by
put_page().  Such as in access_process_vm().  This tends to go BUG()
because the page is on the LRU.

The patch changes __free_pages_ok() to remove the page from the LRU
in this case, as in 2.4.

We need to make changes to this code again later - I have workloads in
which page_cache_release() consumes 5% of CPU resources.  But this
should keep people out of trouble meanwhile.



 page_alloc.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

--- 2.5.29/mm/page_alloc.c~lru-removal	Sat Jul 27 23:38:59 2002
+++ 2.5.29-akpm/mm/page_alloc.c	Sat Jul 27 23:49:03 2002
@@ -89,10 +89,14 @@ static void __free_pages_ok (struct page
 
 	KERNEL_STAT_ADD(pgfree, 1<<order);
 
+	if (PageLRU(page)) {
+		BUG_ON(in_interrupt());		/* It could deadlock */
+		lru_cache_del(page);
+	}
+
 	BUG_ON(PagePrivate(page));
 	BUG_ON(page->mapping != NULL);
 	BUG_ON(PageLocked(page));
-	BUG_ON(PageLRU(page));
 	BUG_ON(PageActive(page));
 	BUG_ON(PageWriteback(page));
 	BUG_ON(page->pte.chain != NULL);
@@ -451,11 +455,8 @@ unsigned long get_zeroed_page(unsigned i
 
 void page_cache_release(struct page *page)
 {
-	if (!PageReserved(page) && put_page_testzero(page)) {
-		if (PageLRU(page))
-			lru_cache_del(page);
+	if (!PageReserved(page) && put_page_testzero(page))
 		__free_pages_ok(page, 0);
-	}
 }
 
 void __free_pages(struct page *page, unsigned int order)

.
