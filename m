Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbWIFOZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWIFOZf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 10:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWIFOZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 10:25:34 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:30625 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751148AbWIFOZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 10:25:31 -0400
Message-Id: <20060906133956.488875000@chello.nl>
References: <20060906131630.793619000@chello.nl>>
User-Agent: quilt/0.45-1
Date: Wed, 06 Sep 2006 15:16:50 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Daniel Phillips <phillips@google.com>, Rik van Riel <riel@redhat.com>,
       David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Mike Christie <michaelc@cs.wisc.edu>
Subject: [PATCH 20/21] mm: a process flags to avoid blocking allocations
Content-Disposition: inline; filename=pf_mem_nowait.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PF_MEM_NOWAIT - will make allocations fail before blocking. This is usefull
to convert process behaviour to non-blocking.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: Mike Christie <michaelc@cs.wisc.edu>
---
 include/linux/sched.h |    1 +
 mm/page_alloc.c       |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

Index: linux-2.6/include/linux/sched.h
===================================================================
--- linux-2.6.orig/include/linux/sched.h
+++ linux-2.6/include/linux/sched.h
@@ -1056,6 +1056,7 @@ static inline void put_task_struct(struc
 #define PF_SPREAD_SLAB	0x02000000	/* Spread some slab caches over cpuset */
 #define PF_MEMPOLICY	0x10000000	/* Non-default NUMA mempolicy */
 #define PF_MUTEX_TESTER	0x20000000	/* Thread belongs to the rt mutex tester */
+#define PF_MEM_NOWAIT	0x40000000	/* Make allocations fail instead of block */
 
 /*
  * Only the _current_ task can read/write to tsk->flags, but other
Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -912,11 +912,11 @@ struct page * fastcall
 __alloc_pages(gfp_t gfp_mask, unsigned int order,
 		struct zonelist *zonelist)
 {
-	const gfp_t wait = gfp_mask & __GFP_WAIT;
+	struct task_struct *p = current;
+	const int wait = (gfp_mask & __GFP_WAIT) && !(p->flags & PF_MEM_NOWAIT);
 	struct zone **z;
 	struct page *page;
 	struct reclaim_state reclaim_state;
-	struct task_struct *p = current;
 	int do_retry;
 	int alloc_flags;
 	int did_some_progress;

--
