Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbUKCJIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbUKCJIA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 04:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbUKCJGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 04:06:45 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:32191 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261494AbUKCJFK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 04:05:10 -0500
Date: Wed, 3 Nov 2004 14:44:50 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       wli@holomorphy.com
Subject: Re: [PATCH 2/6] Rename __lock_page to lock_page_slow
Message-ID: <20041103091450.GB5737@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20041103091036.GA4041@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041103091036.GA4041@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 02:40:36PM +0530, Suparna Bhattacharya wrote:
> 
> The series of patches that follow integrate AIO with 
> William Lee Irwin's wait bit changes, to support asynchronous
> page waits.
> 
> [1] modify-wait-bit-action-args.patch
> 	Add a wait queue arg to the wait_bit action() routine
> 
> [2] lock_page_slow.patch
> 	Rename __lock_page to lock_page_slow
> 

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

------------------------------------------------------------


In order to allow for interruptible and asynchronous versions of
lock_page in conjunction with the wait_on_bit changes, we need to
define low-level lock page routines which take an additional
argument, i.e a wait queue entry and may return non-zero status,
e.g -EINTR, -EIOCBRETRY, -EWOULDBLOCK etc. This patch renames 
__lock_page to lock_page_slow, so that __lock_page and 
__lock_page_slow can denote the versions which take a wait queue 
parameter.

Signed-off-by: Suparna Bhattacharya <suparna@in.ibm.com>

diff -puN include/linux/pagemap.h~lock_page_slow include/linux/pagemap.h


 linux-2.6.10-rc1-suparna/include/linux/pagemap.h |    4 ++--
 linux-2.6.10-rc1-suparna/mm/filemap.c            |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff -puN include/linux/pagemap.h~lock_page_slow include/linux/pagemap.h
--- linux-2.6.10-rc1/include/linux/pagemap.h~lock_page_slow	2004-11-03 14:34:57.000000000 +0530
+++ linux-2.6.10-rc1-suparna/include/linux/pagemap.h	2004-11-03 14:34:57.000000000 +0530
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
--- linux-2.6.10-rc1/mm/filemap.c~lock_page_slow	2004-11-03 14:34:57.000000000 +0530
+++ linux-2.6.10-rc1-suparna/mm/filemap.c	2004-11-03 14:34:57.000000000 +0530
@@ -436,14 +436,14 @@ EXPORT_SYMBOL(end_page_writeback);
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
  * a rather lightweight function, finding and getting a reference to a

_
