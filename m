Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbVCRIZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbVCRIZW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 03:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVCRIXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 03:23:51 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:51935 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261492AbVCRITo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 03:19:44 -0500
Date: Fri, 18 Mar 2005 00:17:56 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org, Simon Derr <Simon.Derr@bull.net>,
       Ray Bryant <raybry@sgi.com>, Paul Jackson <pj@sgi.com>
Message-Id: <20050318081757.31530.88116.sendpatchset@sam.engr.sgi.com>
Subject: [Patch] cpusets alloc GFP_WAIT sleep fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    Linus - please apply.

The cpuset mems_allowed update code in alloc_pages_current could
(in theory) put a task to sleep that didn't allow sleeping (did
not have __GFP_WAIT flag set).  In the rare circumstance that
the current tasks mems_generation is outofdate compared to the
tasks cpuset mems_generation, this mems_allowed update code
needs to grap cpuset_sem, which can sleep.

We avoid this by not trying to update mems_allowed here if we
can't sleep (__GFP_WAIT not set).

Applies to top of Linus's bk tree (post 2.6.11)

Thanks to Ray Bryant <raybry@sgi.com> for noticing this.

Signed-off-by: Paul Jackson <pj@sgi.com>

===================================================================
--- 2.6.12-pj.orig/mm/mempolicy.c	2005-03-16 01:16:58.000000000 -0800
+++ 2.6.12-pj/mm/mempolicy.c	2005-03-16 01:32:05.000000000 -0800
@@ -788,12 +788,16 @@ alloc_page_vma(unsigned gfp, struct vm_a
  *	Allocate a page from the kernel page pool.  When not in
  *	interrupt context and apply the current process NUMA policy.
  *	Returns NULL when no page can be allocated.
+ *
+ *	Don't call cpuset_update_current_mems_allowed() unless
+ *	1) it's ok to take cpuset_sem (can WAIT), and
+ *	2) allocating for current task (not interrupt).
  */
 struct page *alloc_pages_current(unsigned gfp, unsigned order)
 {
 	struct mempolicy *pol = current->mempolicy;
 
-	if (!in_interrupt())
+	if ((gfp & __GFP_WAIT) && !in_interrupt())
 		cpuset_update_current_mems_allowed();
 	if (!pol || in_interrupt())
 		pol = &default_policy;

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
