Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbTDCVok 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 16:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S261304AbTDCVok 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 16:44:40 -0500
Received: from [12.47.58.55] ([12.47.58.55]:35726 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S261165AbTDCVoi 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 16:44:38 -0500
Date: Thu, 3 Apr 2003 13:55:22 -0800
From: Andrew Morton <akpm@digeo.com>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.66-mm3] New page_convert_anon
Message-Id: <20030403135522.254e700c.akpm@digeo.com>
In-Reply-To: <61050000.1049405305@baldur.austin.ibm.com>
References: <61050000.1049405305@baldur.austin.ibm.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Apr 2003 21:56:02.0364 (UTC) FILETIME=[D168CFC0:01C2FA2B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave McCracken <dmccr@us.ibm.com> wrote:
>
> 
> Ok, here's my cut at a simpler page_convert_anon.  It passes Hugh and
> Ingo's test cases, plus passes stress testing.
> 

OK.  I'd still be more comfortable if that page was locked though.  I expect
page->mapping is safe because truncate takes down pagetable before pagecache,
but it seems way cleaner.

Is there any reason you didn't do that?

 25-akpm/mm/filemap.c |    3 +++
 25-akpm/mm/fremap.c  |    5 ++++-
 25-akpm/mm/rmap.c    |   20 ++++++++++++--------
 3 files changed, 19 insertions(+), 9 deletions(-)

diff -puN mm/filemap.c~page_convert_anon-lock_page mm/filemap.c
--- 25/mm/filemap.c~page_convert_anon-lock_page	Thu Apr  3 13:44:29 2003
+++ 25-akpm/mm/filemap.c	Thu Apr  3 13:45:39 2003
@@ -64,6 +64,9 @@
  *  ->mmap_sem
  *    ->i_shared_sem		(various places)
  *
+ *  ->lock_page
+ *    ->i_shared_sem		(page_convert_anon)
+ *
  *  ->inode_lock
  *    ->sb_lock			(fs/fs-writeback.c)
  *    ->mapping->page_lock	(__sync_single_inode)
diff -puN mm/rmap.c~page_convert_anon-lock_page mm/rmap.c
--- 25/mm/rmap.c~page_convert_anon-lock_page	Thu Apr  3 13:44:34 2003
+++ 25-akpm/mm/rmap.c	Thu Apr  3 13:50:45 2003
@@ -764,12 +764,16 @@ out:
  * Find all the mappings for an object-based page and convert them
  * to 'anonymous', ie create a pte_chain and store all the pte pointers there.
  *
- * This function takes the address_space->i_shared_sem, sets the PageAnon flag, then
- * sets the mm->page_table_lock for each vma and calls page_add_rmap.  This means
- * there is a period when PageAnon is set, but still has some mappings with no
- * pte_chain entry.  This is in fact safe, since page_remove_rmap will simply not
- * find it.  try_to_unmap might erroneously return success, but kswapd will correctly
- * see that there are still users of the page and send it around again.
+ * This function takes the address_space->i_shared_sem, sets the PageAnon flag,
+ * then sets the mm->page_table_lock for each vma and calls page_add_rmap. This
+ * means there is a period when PageAnon is set, but still has some mappings
+ * with no pte_chain entry.  This is in fact safe, since page_remove_rmap will
+ * simply not find it.  try_to_unmap might erroneously return success, but it
+ * will never be called because the page_convert_anon() caller has locked the
+ * page.
+ *
+ * page_referenced() may fail to scan all the appropriate pte's and may return
+ * an inaccurate result.  This is so rare that it does not matter.
  */
 int page_convert_anon(struct page *page)
 {
@@ -801,8 +805,8 @@ int page_convert_anon(struct page *page)
 	page->pte.mapcount = 0;
 
 	/*
-	 * Now that the page is marked as anon, unlock it.  page_add_rmap will lock
-	 * it as necessary.
+	 * Now that the page is marked as anon, unlock it.  page_add_rmap will
+	 * lock it as necessary.
 	 */
 	pte_chain_unlock(page);
 
diff -puN mm/fremap.c~page_convert_anon-lock_page mm/fremap.c
--- 25/mm/fremap.c~page_convert_anon-lock_page	Thu Apr  3 13:44:49 2003
+++ 25-akpm/mm/fremap.c	Thu Apr  3 13:51:30 2003
@@ -73,7 +73,10 @@ int install_page(struct mm_struct *mm, s
 	pgidx += vma->vm_pgoff;
 	pgidx >>= PAGE_CACHE_SHIFT - PAGE_SHIFT;
 	if (!PageAnon(page) && (page->index != pgidx)) {
-		if (page_convert_anon(page) < 0)
+		lock_page(page);
+		err = page_convert_anon(page);
+		unlock_page(page);
+		if (err < 0)
 			goto err_free;
 	}
 

_

