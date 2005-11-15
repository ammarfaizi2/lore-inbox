Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbVKOVpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbVKOVpi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 16:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbVKOVpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 16:45:38 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:56796 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751120AbVKOVph (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 16:45:37 -0500
Date: Tue, 15 Nov 2005 13:45:24 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: [PATCH] Remove old node based policy interface from mempolicy.c
Message-ID: <Pine.LNX.4.62.0511151344110.11001@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mempolicy.c contains provisional interface for huge page allocation
based on node numbers. This is in use in SLES9 but was never used (AFAIK) 
in upstream versions of Linux.

Huge page allocations now use zonelists to figure out where to allocate pages.
The use of zonelists allows us to find the closest hugepage which was
difficult to do with the SLES9 interface. As a result SLES9 never supported
the consideration of the NUMA distance for huge page allocations.

Remove the obsolete functions.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.14-mm2/mm/mempolicy.c
===================================================================
--- linux-2.6.14-mm2.orig/mm/mempolicy.c	2005-11-15 12:30:26.000000000 -0800
+++ linux-2.6.14-mm2/mm/mempolicy.c	2005-11-15 13:16:19.000000000 -0800
@@ -1181,54 +1181,6 @@ void __mpol_free(struct mempolicy *p)
 }
 
 /*
- * Hugetlb policy. Same as above, just works with node numbers instead of
- * zonelists.
- */
-
-/* Find first node suitable for an allocation */
-int mpol_first_node(struct vm_area_struct *vma, unsigned long addr)
-{
-	struct mempolicy *pol = get_vma_policy(current, vma, addr);
-
-	switch (pol->policy) {
-	case MPOL_DEFAULT:
-		return numa_node_id();
-	case MPOL_BIND:
-		return pol->v.zonelist->zones[0]->zone_pgdat->node_id;
-	case MPOL_INTERLEAVE:
-		return interleave_nodes(pol);
-	case MPOL_PREFERRED:
-		return pol->v.preferred_node >= 0 ?
-				pol->v.preferred_node : numa_node_id();
-	}
-	BUG();
-	return 0;
-}
-
-/* Find secondary valid nodes for an allocation */
-int mpol_node_valid(int nid, struct vm_area_struct *vma, unsigned long addr)
-{
-	struct mempolicy *pol = get_vma_policy(current, vma, addr);
-
-	switch (pol->policy) {
-	case MPOL_PREFERRED:
-	case MPOL_DEFAULT:
-	case MPOL_INTERLEAVE:
-		return 1;
-	case MPOL_BIND: {
-		struct zone **z;
-		for (z = pol->v.zonelist->zones; *z; z++)
-			if ((*z)->zone_pgdat->node_id == nid)
-				return 1;
-		return 0;
-	}
-	default:
-		BUG();
-		return 0;
-	}
-}
-
-/*
  * Shared memory backing store policy support.
  *
  * Remember policies even when nobody has shared memory mapped.
Index: linux-2.6.14-mm2/include/linux/mempolicy.h
===================================================================
--- linux-2.6.14-mm2.orig/include/linux/mempolicy.h	2005-11-15 12:30:26.000000000 -0800
+++ linux-2.6.14-mm2/include/linux/mempolicy.h	2005-11-15 13:16:19.000000000 -0800
@@ -112,14 +112,6 @@ static inline int mpol_equal(struct memp
 #define mpol_set_vma_default(vma) ((vma)->vm_policy = NULL)
 
 /*
- * Hugetlb policy. i386 hugetlb so far works with node numbers
- * instead of zone lists, so give it special interfaces for now.
- */
-extern int mpol_first_node(struct vm_area_struct *vma, unsigned long addr);
-extern int mpol_node_valid(int nid, struct vm_area_struct *vma,
-			unsigned long addr);
-
-/*
  * Tree of shared policies for a shared memory region.
  * Maintain the policies in a pseudo mm that contains vmas. The vmas
  * carry the policy. As a special twist the pseudo mm is indexed in pages, not
@@ -189,17 +181,6 @@ static inline struct mempolicy *mpol_cop
 	return NULL;
 }
 
-static inline int mpol_first_node(struct vm_area_struct *vma, unsigned long a)
-{
-	return numa_node_id();
-}
-
-static inline int
-mpol_node_valid(int nid, struct vm_area_struct *vma, unsigned long a)
-{
-	return 1;
-}
-
 struct shared_policy {};
 
 static inline int mpol_set_shared_policy(struct shared_policy *info,
