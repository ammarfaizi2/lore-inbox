Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319053AbSH1WNJ>; Wed, 28 Aug 2002 18:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319054AbSH1WNJ>; Wed, 28 Aug 2002 18:13:09 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:54028 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S319053AbSH1WNI>; Wed, 28 Aug 2002 18:13:08 -0400
Message-ID: <3D6D4B80.F84F71E4@zip.com.au>
Date: Wed, 28 Aug 2002 15:15:28 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] adjustments to dirty memory thresholds
References: <3D6C53ED.32044CAD@zip.com.au> <20020828200857.GB888@holomorphy.com> <3D6D3216.D472CBC3@zip.com.au> <20020828214243.GC888@holomorphy.com> <3D6D477C.F5116BA7@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> ...
> Well it's presumably the GFP_NOIO which has killed it - we can't wait
> on PG_writeback pages and we can't write out dirty pages.  Taking a
> nap in mempool_alloc is appropriate.

Actually, it might be better to teach mempool_alloc to not call page reclaim
at all if __GFP_FS is not set.  Just kick bdflush and go to sleep.

I really, really, really dislike the VM's tendency to go and scan hundreds
of thousands of pages.  It's a clear sign of an inappropriate algorithm.

Test something like this, please?


--- 2.5.32/mm/mempool.c~wli	Wed Aug 28 15:07:31 2002
+++ 2.5.32-akpm/mm/mempool.c	Wed Aug 28 15:12:53 2002
@@ -196,10 +196,11 @@ repeat_alloc:
 		return element;
 
 	/*
-	 * If the pool is less than 50% full then try harder
-	 * to allocate an element:
+	 * If the pool is less than 50% full and we can perform effective
+	 * page reclaim then try harder to allocate an element:
 	 */
-	if ((gfp_mask != gfp_nowait) && (pool->curr_nr <= pool->min_nr/2)) {
+	if ((gfp_mask & __GFP_FS) && (gfp_mask != gfp_nowait) &&
+			(pool->curr_nr <= pool->min_nr/2)) {
 		element = pool->alloc(gfp_mask, pool->pool_data);
 		if (likely(element != NULL))
 			return element;

.
