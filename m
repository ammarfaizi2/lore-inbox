Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbWBGBzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWBGBzd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 20:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbWBGBzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 20:55:33 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:44229 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932186AbWBGBzc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 20:55:32 -0500
Date: Mon, 6 Feb 2006 17:55:27 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Paul Jackson <pj@sgi.com>
cc: ak@suse.de, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: OOM behavior in constrained memory situations
In-Reply-To: <20060206145922.3eb3c404.pj@sgi.com>
Message-ID: <Pine.LNX.4.62.0602061745480.20189@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0602061253020.18594@schroedinger.engr.sgi.com>
 <20060206145922.3eb3c404.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just tried to oom a process that has restricted its mem allocation to 
node 0 using a memory policy. Instead of an OOM the system began to swap 
on node zero. The swapping is restricted to the zones passed to 
__alloc_pages. It was thus swapping node zero alone.

If a cpuset restriction is in place then we will still swap to all the 
zones passed to alloc_pages(). This includes zones not in the current 
cpusets. Thats somewhat strange behavior.

Only if swap is off then we will reach the OOM killer if node zero or the 
cpuset is exhausted.

So swap memory fulfills all requirements of memory policies and cpusets?
Weird.


Here is a first of all a proposal of a patch that kills the process that 
constrains the allocations instead of starting the OOM killer (in the not 
swapped case).

Do not invoke OOM killer for constrained allocations

Add some code to detect policies that do not include all nodes in the system.
For those policies invoke the page allocator with the newly added
__GFP_NO_OOM_KILLER flags. Allocations will then not invoke the OOM killer
(finding no page just means that the system has no available page for
that particular process) but terminate the application instead.

This may interfere with the cpusets mechanism for killing processes
through the OOM killer. This could be fixed by setting __GFP_NO_OOM_KILLER
if the __alloc_pages detects that the active cpuset is constraining allocations.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.16-rc2/mm/page_alloc.c
===================================================================
--- linux-2.6.16-rc2.orig/mm/page_alloc.c	2006-02-02 22:03:08.000000000 -0800
+++ linux-2.6.16-rc2/mm/page_alloc.c	2006-02-06 17:07:41.000000000 -0800
@@ -1011,6 +1011,13 @@ rebalance:
 		if (page)
 			goto got_pg;
 
+		if (gfp_mask & __GFP_NO_OOM_KILLER)
+			/*
+			 * Process uses constrained allocations.
+			 * Terminate the application instead.
+			 */
+			return NULL;
+
 		out_of_memory(gfp_mask, order);
 		goto restart;
 	}
Index: linux-2.6.16-rc2/mm/mempolicy.c
===================================================================
--- linux-2.6.16-rc2.orig/mm/mempolicy.c	2006-02-02 22:03:08.000000000 -0800
+++ linux-2.6.16-rc2/mm/mempolicy.c	2006-02-06 17:07:41.000000000 -0800
@@ -161,6 +161,11 @@ static struct mempolicy *mpol_new(int mo
 	if (!policy)
 		return ERR_PTR(-ENOMEM);
 	atomic_set(&policy->refcnt, 1);
+
+	policy->gfp_flags = 0;
+	if (!nodes_equal(*nodes, node_online_map))
+		policy->gfp_flags |= __GFP_NO_OOM_KILLER;
+
 	switch (mode) {
 	case MPOL_INTERLEAVE:
 		policy->v.nodes = *nodes;
@@ -1219,6 +1224,7 @@ alloc_page_vma(gfp_t gfp, struct vm_area
 
 	cpuset_update_task_memory_state();
 
+	gfp |= pol->gfp_flags;
 	if (unlikely(pol->policy == MPOL_INTERLEAVE)) {
 		unsigned nid;
 
@@ -1255,6 +1261,7 @@ struct page *alloc_pages_current(gfp_t g
 		cpuset_update_task_memory_state();
 	if (!pol || in_interrupt())
 		pol = &default_policy;
+	gfp |= pol->gfp_flags;
 	if (pol->policy == MPOL_INTERLEAVE)
 		return alloc_page_interleave(gfp, order, interleave_nodes(pol));
 	return __alloc_pages(gfp, order, zonelist_policy(gfp, pol));
@@ -1590,6 +1597,9 @@ void mpol_rebind_policy(struct mempolicy
 	if (nodes_equal(*mpolmask, *newmask))
 		return;
 
+	if (!nodes_equal(*newmask, node_online_map))
+		pol->gfp_flags |= __GFP_NO_OOM_KILLER;
+
 	switch (pol->policy) {
 	case MPOL_DEFAULT:
 		break;
Index: linux-2.6.16-rc2/include/linux/mempolicy.h
===================================================================
--- linux-2.6.16-rc2.orig/include/linux/mempolicy.h	2006-02-02 22:03:08.000000000 -0800
+++ linux-2.6.16-rc2/include/linux/mempolicy.h	2006-02-06 17:07:41.000000000 -0800
@@ -62,6 +62,7 @@ struct vm_area_struct;
 struct mempolicy {
 	atomic_t refcnt;
 	short policy; 	/* See MPOL_* above */
+	gfp_t gfp_flags;	/* flags ORed into gfp_flags for each allocation */
 	union {
 		struct zonelist  *zonelist;	/* bind */
 		short 		 preferred_node; /* preferred */
Index: linux-2.6.16-rc2/include/linux/gfp.h
===================================================================
--- linux-2.6.16-rc2.orig/include/linux/gfp.h	2006-02-02 22:03:08.000000000 -0800
+++ linux-2.6.16-rc2/include/linux/gfp.h	2006-02-06 17:07:41.000000000 -0800
@@ -47,6 +47,7 @@ struct vm_area_struct;
 #define __GFP_ZERO	((__force gfp_t)0x8000u)/* Return zeroed page on success */
 #define __GFP_NOMEMALLOC ((__force gfp_t)0x10000u) /* Don't use emergency reserves */
 #define __GFP_HARDWALL   ((__force gfp_t)0x20000u) /* Enforce hardwall cpuset memory allocs */
+#define __GFP_NO_OOM_KILLER ((__force gfp_t)0x40000u) /* Terminate process do not call OOM killer */
 
 #define __GFP_BITS_SHIFT 20	/* Room for 20 __GFP_FOO bits */
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
