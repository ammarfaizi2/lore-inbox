Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbWCPTKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbWCPTKh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 14:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964853AbWCPTKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 14:10:36 -0500
Received: from silver.veritas.com ([143.127.12.111]:31370 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S964838AbWCPTKg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 14:10:36 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.02,198,1139212800"; 
   d="scan'208"; a="35987525:sNHT24337280"
Date: Thu, 16 Mar 2006 19:11:14 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: [PATCH] fix free swap cache latency
Message-ID: <Pine.LNX.4.61.0603161853300.24463@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 16 Mar 2006 19:10:35.0585 (UTC) FILETIME=[4DE50B10:01C6492D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell reported 28ms latency when process with lots of swapped memory
exits.

2.6.15 introduced a latency regression when unmapping: in accounting the
zap_work latency breaker, pte_none counted 1, pte_present PAGE_SIZE, but
a swap entry counted nothing at all.  We think of pages present as the
slow case, but Lee's trace shows that free_swap_and_cache's radix tree
lookup can make a lot of work - and we could have been doing it many
thousands of times without a latency break.

Move the zap_work update up to account swap entries like pages present.
This does account non-linear pte_file entries, and unmap_mapping_range
skipping over swap entries, by the same amount even though they're quick:
but neither of those cases deserves complicating the code (and they're
treated no worse than they were in 2.6.14).

Signed-off-by: Hugh Dickins <hugh@veritas.com>
Acked-by: Nick Piggin <npiggin@suse.de>
---
Andrew, I recommend this one for 2.6.16: but you may fairly disagree,
so I'm sending it to you, to pass on to Linus or not as you see fit.
Lee doesn't expect to be able to reproduce the testcase quickly, so
the fix has not been verified: but we consider it self-evidently good.

 mm/memory.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

--- 2.6.16-rc6/mm/memory.c	2006-03-12 15:25:45.000000000 +0000
+++ linux/mm/memory.c	2006-03-15 07:32:36.000000000 +0000
@@ -623,11 +623,12 @@ static unsigned long zap_pte_range(struc
 			(*zap_work)--;
 			continue;
 		}
+
+		(*zap_work) -= PAGE_SIZE;
+
 		if (pte_present(ptent)) {
 			struct page *page;
 
-			(*zap_work) -= PAGE_SIZE;
-
 			page = vm_normal_page(vma, addr, ptent);
 			if (unlikely(details) && page) {
 				/*
