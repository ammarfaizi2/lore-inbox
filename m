Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbVFTQPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVFTQPK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 12:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbVFTQPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 12:15:10 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:33251 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261374AbVFTQOq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 12:14:46 -0400
Date: Mon, 20 Jun 2005 21:54:04 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org
Cc: linux-kernel@vger.kernel.org, bcrl@kvack.org, wli@holomorphy.com,
       zab@zabbo.net, mason@suse.com
Subject: Re: [PATCH 2/6] Rename __lock_page to lock_page_slow
Message-ID: <20050620162404.GB5380@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20050620120154.GA4810@in.ibm.com> <20050620160126.GA5271@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050620160126.GA5271@in.ibm.com>
User-Agent: Mutt/1.4i
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

 include/linux/pagemap.h |    4 ++--
 mm/filemap.c            |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff -puN include/linux/pagemap.h~lock_page_slow include/linux/pagemap.h
--- linux-2.6.9-rc1-mm4/include/linux/pagemap.h~lock_page_slow	2004-09-13 11:46:23.000000000 +0530
+++ linux-2.6.9-rc1-mm4-suparna/include/linux/pagemap.h	2004-09-13 12:01:03.000000000 +0530
@@ -151,14 +151,14 @@ static inline pgoff_t linear_page_index(
 	return pgoff >> (PAGE_CACHE_SHIFT - PAGE_SHIFT);
 }
 
-extern void FASTCALL(__lock_page(struct page *page));
+extern void FASTCALL(lock_page_slow(struct page *page));
 extern void FASTCALL(unlock_page(struct page *page));
 
 static inline void lock_page(struct page *page)
 {
 	might_sleep();
 	if (TestSetPageLocked(page))
-		__lock_page(page);
+		lock_page_slow(page);
 }
 	
 /*
diff -puN mm/filemap.c~lock_page_slow mm/filemap.c
--- linux-2.6.9-rc1-mm4/mm/filemap.c~lock_page_slow	2004-09-13 11:46:23.000000000 +0530
+++ linux-2.6.9-rc1-mm4-suparna/mm/filemap.c	2004-09-13 12:07:53.000000000 +0530
@@ -438,14 +438,14 @@ EXPORT_SYMBOL(end_page_writeback);
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
  * Note completion of filesystem specific page synchronisation

_
-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

