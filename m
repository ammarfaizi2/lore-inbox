Return-Path: <linux-kernel-owner+w=401wt.eu-S964972AbWL1Ib6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbWL1Ib6 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 03:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbWL1Ib6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 03:31:58 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:60199 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964966AbWL1Ib5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 03:31:57 -0500
Date: Thu, 28 Dec 2006 14:06:22 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, akpm@osdl.org, drepper@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       jakub@redhat.com, mingo@elte.hu
Subject: [FSAIO][PATCH 2/8] Rename __lock_page to lock_page_slow
Message-ID: <20061228083622.GB6971@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20061227153855.GA25898@in.ibm.com> <20061228082308.GA4476@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061228082308.GA4476@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In order to allow for interruptible and asynchronous versions of
lock_page in conjunction with the wait_on_bit changes, we need to
define low-level lock page routines which take an additional
argument, i.e a wait queue entry and may return non-zero status,
e.g -EINTR, -EIOCBRETRY, -EWOULDBLOCK etc. This patch renames 
__lock_page to lock_page_slow, so that __lock_page and 
__lock_page_slow can denote the versions which take a wait queue 
parameter.

Signed-off-by: Suparna Bhattacharya <suparna@in.ibm.com>
Acked-by: Ingo Molnar <mingo@elte.hu>
---

 linux-2.6.20-rc1-root/include/linux/pagemap.h |    4 ++--
 linux-2.6.20-rc1-root/mm/filemap.c            |    8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff -puN include/linux/pagemap.h~lock_page_slow include/linux/pagemap.h
--- linux-2.6.20-rc1/include/linux/pagemap.h~lock_page_slow	2006-12-21 08:45:40.000000000 +0530
+++ linux-2.6.20-rc1-root/include/linux/pagemap.h	2006-12-28 09:32:39.000000000 +0530
@@ -133,7 +133,7 @@ static inline pgoff_t linear_page_index(
 	return pgoff >> (PAGE_CACHE_SHIFT - PAGE_SHIFT);
 }
 
-extern void FASTCALL(__lock_page(struct page *page));
+extern void FASTCALL(lock_page_slow(struct page *page));
 extern void FASTCALL(__lock_page_nosync(struct page *page));
 extern void FASTCALL(unlock_page(struct page *page));
 
@@ -144,7 +144,7 @@ static inline void lock_page(struct page
 {
 	might_sleep();
 	if (TestSetPageLocked(page))
-		__lock_page(page);
+		lock_page_slow(page);
 }
 
 /*
diff -puN mm/filemap.c~lock_page_slow mm/filemap.c
--- linux-2.6.20-rc1/mm/filemap.c~lock_page_slow	2006-12-21 08:45:40.000000000 +0530
+++ linux-2.6.20-rc1-root/mm/filemap.c	2006-12-28 09:32:39.000000000 +0530
@@ -556,7 +556,7 @@ void end_page_writeback(struct page *pag
 EXPORT_SYMBOL(end_page_writeback);
 
 /**
- * __lock_page - get a lock on the page, assuming we need to sleep to get it
+ * lock_page_slow - get a lock on the page, assuming we need to sleep to get it
  * @page: the page to lock
  *
  * Ugly. Running sync_page() in state TASK_UNINTERRUPTIBLE is scary.  If some
@@ -564,14 +564,14 @@ EXPORT_SYMBOL(end_page_writeback);
  * chances are that on the second loop, the block layer's plug list is empty,
  * so sync_page() will then return in state TASK_UNINTERRUPTIBLE.
  */
-void fastcall __lock_page(struct page *page)
+void fastcall lock_page_slow(struct page *page)
 {
 	DEFINE_WAIT_BIT(wait, &page->flags, PG_locked);
 
 	__wait_on_bit_lock(page_waitqueue(page), &wait, sync_page,
 							TASK_UNINTERRUPTIBLE);
 }
-EXPORT_SYMBOL(__lock_page);
+EXPORT_SYMBOL(lock_page_slow);
 
 /*
  * Variant of lock_page that does not require the caller to hold a reference
@@ -647,7 +647,7 @@ repeat:
 		page_cache_get(page);
 		if (TestSetPageLocked(page)) {
 			read_unlock_irq(&mapping->tree_lock);
-			__lock_page(page);
+			lock_page_slow(page);
 			read_lock_irq(&mapping->tree_lock);
 
 			/* Has the page been truncated while we slept? */
_
-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

