Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315198AbSESTo3>; Sun, 19 May 2002 15:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315210AbSESTnY>; Sun, 19 May 2002 15:43:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20740 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314987AbSESTmd>;
	Sun, 19 May 2002 15:42:33 -0400
Message-ID: <3CE80102.C0577264@zip.com.au>
Date: Sun, 19 May 2002 12:46:10 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 15/15] remove PG_launder
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Removal of PG_launder.

It's not obvious (to me) why this ever existed.  If it's to prevent
deadlocks then I'd like to know who was performing __GFP_FS allocations
while holding a page lock?

But in 2.5, the only memory allocations which are performed when the
caller holds PG_writeback against an unsubmitted page are those which
occur inside submit_bh().  There will be no __GFS_FS allocations in
that call chain.

Removing PG_launder means that memory allocators can block on any
PageWriteback() page at all, which reduces the risk of very long list
walks inside pagemap_lru_lock in shrink_cache().


=====================================

--- 2.5.16/mm/vmscan.c~pg_launder	Sun May 19 11:49:50 2002
+++ 2.5.16-akpm/mm/vmscan.c	Sun May 19 11:49:50 2002
@@ -424,11 +424,10 @@ static int shrink_cache(int nr_pages, zo
 			goto page_mapped;
 
 		/*
-		 * The page is locked. IO in progress?
-		 * Move it to the back of the list.
+		 * IO in progress? Leave it at the back of the list.
 		 */
 		if (unlikely(PageWriteback(page))) {
-			if (PageLaunder(page) && (gfp_mask & __GFP_FS)) {
+			if (gfp_mask & __GFP_FS) {
 				page_cache_get(page);
 				spin_unlock(&pagemap_lru_lock);
 				wait_on_page_writeback(page);
--- 2.5.16/mm/page-writeback.c~pg_launder	Sun May 19 11:49:50 2002
+++ 2.5.16-akpm/mm/page-writeback.c	Sun May 19 11:49:50 2002
@@ -373,8 +373,6 @@ int generic_writeback_mapping(struct add
 				}
 				spin_unlock(&pagemap_lru_lock);
 			}
-			if (current->flags & PF_MEMALLOC)
-				SetPageLaunder(page);
 			err = writepage(page);
 			if (!ret)
 				ret = err;
--- 2.5.16/mm/shmem.c~pg_launder	Sun May 19 11:49:50 2002
+++ 2.5.16-akpm/mm/shmem.c	Sun May 19 11:49:50 2002
@@ -438,7 +438,8 @@ static int shmem_writepage(struct page *
 
 	if (!PageLocked(page))
 		BUG();
-	if (!PageLaunder(page))
+
+	if (!(current->flags & PF_MEMALLOC))
 		return fail_writepage(page);
 
 	mapping = page->mapping;
--- 2.5.16/mm/filemap.c~pg_launder	Sun May 19 11:49:50 2002
+++ 2.5.16-akpm/mm/filemap.c	Sun May 19 11:49:50 2002
@@ -432,7 +432,7 @@ void invalidate_inode_pages2(struct addr
 int fail_writepage(struct page *page)
 {
 	/* Only activate on memory-pressure, not fsync.. */
-	if (PageLaunder(page)) {
+	if (current->flags & PF_MEMALLOC) {
 		activate_page(page);
 		SetPageReferenced(page);
 	}
@@ -652,7 +652,6 @@ void unlock_page(struct page *page)
 void end_page_writeback(struct page *page)
 {
 	wait_queue_head_t *waitqueue = page_waitqueue(page);
-	ClearPageLaunder(page);
 	smp_mb__before_clear_bit();
 	if (!TestClearPageWriteback(page))
 		BUG();
--- 2.5.16/include/linux/page-flags.h~pg_launder	Sun May 19 11:49:50 2002
+++ 2.5.16-akpm/include/linux/page-flags.h	Sun May 19 11:49:50 2002
@@ -62,9 +62,8 @@
 #define PG_arch_1		10
 #define PG_reserved		11
 
-#define PG_launder		12	/* written out by VM pressure.. */
-#define PG_private		13	/* Has something at ->private */
-#define PG_writeback		14	/* Page is under writeback */
+#define PG_private		12	/* Has something at ->private */
+#define PG_writeback		13	/* Page is under writeback */
 
 /*
  * Global page accounting.  One instance per CPU.
@@ -172,10 +171,6 @@ extern void get_page_state(struct page_s
 #define SetPageReserved(page)	set_bit(PG_reserved, &(page)->flags)
 #define ClearPageReserved(page)	clear_bit(PG_reserved, &(page)->flags)
 
-#define PageLaunder(page)	test_bit(PG_launder, &(page)->flags)
-#define SetPageLaunder(page)	set_bit(PG_launder, &(page)->flags)
-#define ClearPageLaunder(page)	clear_bit(PG_launder, &(page)->flags)
-
 #define SetPagePrivate(page)	set_bit(PG_private, &(page)->flags)
 #define ClearPagePrivate(page)	clear_bit(PG_private, &(page)->flags)
 #define PagePrivate(page)	test_bit(PG_private, &(page)->flags)

-
