Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313568AbSEEU6c>; Sun, 5 May 2002 16:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313571AbSEEU5P>; Sun, 5 May 2002 16:57:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47369 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313559AbSEEU4h>;
	Sun, 5 May 2002 16:56:37 -0400
Message-ID: <3CD59D0F.49E4C321@zip.com.au>
Date: Sun, 05 May 2002 13:58:55 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 8/10] Fix PG_launder
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Set PG_launder against pages which are under VM writeback.  So page
allocators will throttle against them.


=====================================

--- 2.5.13/mm/page-writeback.c~page_launder-fix	Sun May  5 13:32:03 2002
+++ 2.5.13-akpm/mm/page-writeback.c	Sun May  5 13:32:03 2002
@@ -354,6 +354,8 @@ int generic_writeback_mapping(struct add
 		lock_page(page);
 
 		if (TestClearPageDirty(page)) {
+			if (current->flags & PF_MEMALLOC)
+				SetPageLaunder(page);
 			err = writepage(page);
 			if (!ret)
 				ret = err;
--- 2.5.13/fs/fs-writeback.c~page_launder-fix	Sun May  5 13:32:03 2002
+++ 2.5.13-akpm/fs/fs-writeback.c	Sun May  5 13:32:03 2002
@@ -17,6 +17,7 @@
 #include <linux/spinlock.h>
 #include <linux/sched.h>
 #include <linux/fs.h>
+#include <linux/mm.h>
 #include <linux/writeback.h>
 
 /**
@@ -135,7 +136,7 @@ static void __sync_single_inode(struct i
 	if (mapping->a_ops->writeback_mapping)
 		mapping->a_ops->writeback_mapping(mapping, nr_to_write);
 	else
-		filemap_fdatawrite(mapping);
+		generic_writeback_mapping(mapping, NULL);
 
 	/* Don't write the inode if only I_DIRTY_PAGES was set */
 	if (dirty & (I_DIRTY_SYNC | I_DIRTY_DATASYNC))
--- 2.5.13/mm/filemap.c~page_launder-fix	Sun May  5 13:32:03 2002
+++ 2.5.13-akpm/mm/filemap.c	Sun May  5 13:32:03 2002
@@ -659,7 +659,6 @@ EXPORT_SYMBOL(wait_on_page_writeback);
 void unlock_page(struct page *page)
 {
 	wait_queue_head_t *waitqueue = page_waitqueue(page);
-	clear_bit(PG_launder, &(page)->flags);
 	smp_mb__before_clear_bit();
 	if (!TestClearPageLocked(page))
 		BUG();
@@ -674,7 +673,7 @@ void unlock_page(struct page *page)
 void end_page_writeback(struct page *page)
 {
 	wait_queue_head_t *waitqueue = page_waitqueue(page);
-	clear_bit(PG_launder, &(page)->flags);
+	ClearPageLaunder(page);
 	smp_mb__before_clear_bit();
 	if (!TestClearPageWriteback(page))
 		BUG();
--- 2.5.13/include/linux/page-flags.h~page_launder-fix	Sun May  5 13:32:03 2002
+++ 2.5.13-akpm/include/linux/page-flags.h	Sun May  5 13:32:03 2002
@@ -174,6 +174,7 @@ extern void get_page_state(struct page_s
 
 #define PageLaunder(page)	test_bit(PG_launder, &(page)->flags)
 #define SetPageLaunder(page)	set_bit(PG_launder, &(page)->flags)
+#define ClearPageLaunder(page)	clear_bit(PG_launder, &(page)->flags)
 
 #define SetPagePrivate(page)	set_bit(PG_private, &(page)->flags)
 #define ClearPagePrivate(page)	clear_bit(PG_private, &(page)->flags)


-
