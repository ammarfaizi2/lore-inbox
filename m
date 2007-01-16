Return-Path: <linux-kernel-owner+w=401wt.eu-S1750861AbXAPK2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbXAPK2i (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 05:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbXAPK20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 05:28:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43214 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750788AbXAPK2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 05:28:23 -0500
Message-Id: <20070116101815.426856000@taijtu.programming.kicks-ass.net>
References: <20070116094557.494892000@taijtu.programming.kicks-ass.net>
User-Agent: quilt/0.46-1
Date: Tue, 16 Jan 2007 10:46:00 +0100
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-mm@kvack.org
Cc: David Miller <davem@davemloft.net>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 3/9] mm: allow PF_MEMALLOC from softirq context
Content-Disposition: inline; filename=PF_MEMALLOC-softirq.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allow PF_MEMALLOC to be set in softirq context. When running softirqs from
a borrowed context save current->flags, ksoftirqd will have its own 
task_struct.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 kernel/softirq.c |    3 +++
 mm/internal.h    |   14 ++++++++------
 2 files changed, 11 insertions(+), 6 deletions(-)

Index: linux-2.6-git/mm/internal.h
===================================================================
--- linux-2.6-git.orig/mm/internal.h	2006-12-14 10:02:52.000000000 +0100
+++ linux-2.6-git/mm/internal.h	2006-12-14 10:10:09.000000000 +0100
@@ -75,9 +75,10 @@ static int inline gfp_to_alloc_flags(gfp
 		alloc_flags |= ALLOC_HARDER;
 
 	if (likely(!(gfp_mask & __GFP_NOMEMALLOC))) {
-		if (!in_interrupt() &&
-		    ((p->flags & PF_MEMALLOC) ||
-		     unlikely(test_thread_flag(TIF_MEMDIE))))
+		if (!in_irq() && (p->flags & PF_MEMALLOC))
+			alloc_flags |= ALLOC_NO_WATERMARKS;
+		else if (!in_interrupt() &&
+				unlikely(test_thread_flag(TIF_MEMDIE)))
 			alloc_flags |= ALLOC_NO_WATERMARKS;
 	}
 
@@ -117,9 +118,10 @@ static inline int gfp_to_rank(gfp_t gfp_
 	 */
 
 	if (likely(!(gfp_mask & __GFP_NOMEMALLOC))) {
-		if (!in_interrupt() &&
-		    ((current->flags & PF_MEMALLOC) ||
-		     unlikely(test_thread_flag(TIF_MEMDIE))))
+		if (!in_irq() && (current->flags & PF_MEMALLOC))
+			return 0;
+		else if (!in_interrupt() &&
+				unlikely(test_thread_flag(TIF_MEMDIE)))
 			return 0;
 	}
 
Index: linux-2.6-git/kernel/softirq.c
===================================================================
--- linux-2.6-git.orig/kernel/softirq.c	2006-12-14 10:02:18.000000000 +0100
+++ linux-2.6-git/kernel/softirq.c	2006-12-14 10:02:52.000000000 +0100
@@ -209,6 +209,8 @@ asmlinkage void __do_softirq(void)
 	__u32 pending;
 	int max_restart = MAX_SOFTIRQ_RESTART;
 	int cpu;
+	unsigned long pflags = current->flags;
+	current->flags &= ~PF_MEMALLOC;
 
 	pending = local_softirq_pending();
 	account_system_vtime(current);
@@ -247,6 +249,7 @@ restart:
 
 	account_system_vtime(current);
 	_local_bh_enable();
+	current->flags = pflags;
 }
 
 #ifndef __ARCH_HAS_DO_SOFTIRQ

-- 

