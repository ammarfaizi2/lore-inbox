Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267205AbUITTEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267205AbUITTEh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 15:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267234AbUITTEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 15:04:37 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:63460 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S267205AbUITTCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 15:02:46 -0400
Date: Mon, 20 Sep 2004 12:00:33 -0700 (PDT)
From: Ray Bryant <raybry@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Ray Bryant <raybry@austin.rr.com>
Cc: Ray Bryant <raybry@austin.rr.com>, linux-mm <linux-mm@kvack.org>,
       Jesse Barnes <jbarnes@sgi.com>, Dan Higgins <djh@sgi.com>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Brent Casavant <bcasavan@sgi.com>, Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ray Bryant <raybry@sgi.com>, Paul Jackson <pj@sgi.com>,
       Dave Hansen <haveblue@us.ibm.com>
Message-Id: <20040920190033.26965.64678.54625@tomahawk.engr.sgi.com>
Subject: [PATCH 2.6.9-rc2-mm1 0/2] mm: memory policy for page cache allocation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first working release of this patch.  It was previously
proposed as an RFC (see
  http://marc.theaimsgroup.com/?l=linux-mm&m=109416852113561&w=2
).

Background
----------

Last month, Jesse Barnes proposed a patch to do round robin
allocation of page cache pages on NUMA machines.  This got shot down
for a number of reasons (see
  http://marc.theaimsgroup.com/?l=linux-kernel&m=109235420329360&w=2
and the related thread), but it seemed to me that one of the most
significant issues was that this was a workload dependent optimization.
That is, for an Altix running an HPC workload, it was a good thing,
but for web servers or file servers it was not such a good idea.

So the idea of this patch is the following:  it creates a new memory
policy structure (default_pagecache_policy) that is used to control
how storage for page cache pages is allocated.  So, for a large Altix
running HPC workloads, we can specify a policy that does round robin
allocations, and for other workloads you can specify the default policy
(which results in page cache pages being allocated locally).

The default_pagecache_policy is overrideable on a per process basis, so
that if your application prefers to allocate page cache pages locally,
it can.

This is all done by making default_policy and current->mempolicy an array
of size 2 and of type "struct mempolicy *".   Entry POLICY_PAGE in these
arrays is the old default_policy and process memory policy, respectively.
Entry POLICY_PAGECACHE in these arrays contains the system default and
per process page cache allocation policies, respectively.

A new worker routine is defined:
	alloc_pages_by_policy(gfp, order, policy)
This routine allocates the requested number of pages using the policy
index specified.

alloc_pages_current() and page_cache_alloc() are then defined in terms
of alloc_pages_by_policy().

This patch is in two parts.  The first part is Brent Casavant's patch for
MPOL_ROUNDROBIN.  We need this because there is no handy offset to use
when you get a call to allocate a page cache page in "page_cache_alloc()",
so MPOL_INTERLEAVE doesn't do what we need.

The second part of the patch is the set of changes to create the
default_pagecache_policy and see that it is used in page_cache_alloc()
as well as the changes to supporting setting a policy given a policy
index.

Caveats
-------

(1)  Right now, there is no mechanism to set any of the memory policies
from user space.  The NUMA API library will have to be modified to match
the new format of the sys_set/get_mempolicy() system calls (these calls
have an additional integer argument that specifies which policy to set.)
This is work that I will start on once we get agreement with this patch.

(It also appears to me that there is no mechanism to set the default
policies, but perhaps its there and I am just missing it.)

(I tested this stuff by hard compiling policis into my test kernel.)

(2)  page_cache_alloc_local() is defined, but is not currently called.
This was added in SGI ProPack to make sure that mmap'd() files were
allocated locally rather than round-robin'd (i. e. to override the
round robin allocation in that case.)  This was an SGI MPT requirement.
It may be this is not needed with the current mempolicy code if we can
associate the default mempolicy with mmap()'d files for those MPT users.

(3)  alloc_pages_current() is now an inline, but there is no easy way
to do that totally correclty with the current include file order (that I
could figure out at least...)  The problem is that alloc_pages_current()
wants to use the define constant POLICY_PAGE, but that is defined yet.
We know it is zero, so we just use zero.  A comment in mempolicy.h
suggests not to change the value of this constant to something other
than zero, and references the file gfp.h.

(4)  I've not thought a bit about locking issues related to changing a
mempolicy whilst the system is actually running. 

(5)  It seems there may be a potential conflict between the page cache
mempolicy and a mmap mempolicy (do those exist?).  Here's the concern:
If you mmap() a file, and any pages of that file are in the page cache,
then the location of those pages will (have been) dictated by the page
cache mempolicy, which could differ (will likely differ) from the mmap
mempolicy.  It seems that the only solution to this is to migrate those
pages (when they are touched) after the mmap().

Comments, flames, etc to the undersigned.

Best Regards,

Ray

PS:  Both patches are relative to 2.6.9-rc2-mm1.  However, since that
kernel doesn't boot on Altix for me at the moment, the testing was done
using 2.6.9-rc1-mm3.

PPS: This is not a final patch, but lets keep the lawyers happy anyway:

Signed-off-by: Brent Casavant <bcasavan@sgi.com>
Signed-off-by: Ray Bryant <raybry@sgi.com>

===========================================================================
Index: linux-2.6.9-rc1-mm2-kdb/include/linux/sched.h
===================================================================
--- linux-2.6.9-rc1-mm2-kdb.orig/include/linux/sched.h	2004-08-31 13:32:20.000000000 -0700
+++ linux-2.6.9-rc1-mm2-kdb/include/linux/sched.h	2004-09-02 13:17:45.000000000 -0700
@@ -596,6 +596,7 @@
 #ifdef CONFIG_NUMA
   	struct mempolicy *mempolicy;
   	short il_next;		/* could be shared with used_math */
+	short rr_next;
 #endif
 #ifdef CONFIG_CPUSETS
 	struct cpuset *cpuset;
===================================================================
Index: linux-2.6.9-rc1-mm2-kdb/mm/mempolicy.c
===================================================================
--- linux-2.6.9-rc1-mm2-kdb.orig/mm/mempolicy.c	2004-08-31 13:32:20.000000000 -0700
+++ linux-2.6.9-rc1-mm2-kdb/mm/mempolicy.c	2004-09-02 13:17:45.000000000 -0700
@@ -7,10 +7,17 @@
  * NUMA policy allows the user to give hints in which node(s) memory should
  * be allocated.
  *
- * Support four policies per VMA and per process:
+ * Support five policies per VMA and per process:
  *
  * The VMA policy has priority over the process policy for a page fault.
  *
+ * roundrobin     Allocate memory round-robined over a set of nodes,
+ *                with normal fallback if it fails.  The round-robin is
+ *                based on a per-thread rotor both to provide predictability
+ *                of allocation locations and to avoid cacheline contention
+ *                compared to a global rotor.  This policy is distinct from
+ *                interleave in that it seeks to distribute allocations evenly
+ *                across nodes, whereas interleave seeks to maximize bandwidth.
  * interleave     Allocate memory interleaved over a set of nodes,
  *                with normal fallback if it fails.
  *                For VMA based allocations this interleaves based on the
@@ -117,6 +124,7 @@
 		break;
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
+	case MPOL_ROUNDROBIN:
 		/* Preferred will only use the first bit, but allow
 		   more for now. */
 		if (empty)
@@ -215,6 +223,7 @@
 	atomic_set(&policy->refcnt, 1);
 	switch (mode) {
 	case MPOL_INTERLEAVE:
+	case MPOL_ROUNDROBIN:
 		bitmap_copy(policy->v.nodes, nodes, MAX_NUMNODES);
 		break;
 	case MPOL_PREFERRED:
@@ -406,6 +415,8 @@
 	current->mempolicy = new;
 	if (new && new->policy == MPOL_INTERLEAVE)
 		current->il_next = find_first_bit(new->v.nodes, MAX_NUMNODES);
+	if (new && new->policy == MPOL_ROUNDROBIN)
+		current->rr_next = find_first_bit(new->v.nodes, MAX_NUMNODES);
 	return 0;
 }
 
@@ -423,6 +434,7 @@
 	case MPOL_DEFAULT:
 		break;
 	case MPOL_INTERLEAVE:
+	case MPOL_ROUNDROBIN:
 		bitmap_copy(nodes, p->v.nodes, MAX_NUMNODES);
 		break;
 	case MPOL_PREFERRED:
@@ -507,6 +519,9 @@
 		} else if (pol == current->mempolicy &&
 				pol->policy == MPOL_INTERLEAVE) {
 			pval = current->il_next;
+		} else if (pol == current->mempolicy &&
+				pol->policy == MPOL_ROUNDROBIN) {
+			pval = current->rr_next;
 		} else {
 			err = -EINVAL;
 			goto out;
@@ -585,6 +600,7 @@
 				return policy->v.zonelist;
 		/*FALL THROUGH*/
 	case MPOL_INTERLEAVE: /* should not happen */
+	case MPOL_ROUNDROBIN: /* should not happen */
 	case MPOL_DEFAULT:
 		nd = numa_node_id();
 		break;
@@ -595,6 +611,21 @@
 	return NODE_DATA(nd)->node_zonelists + (gfp & GFP_ZONEMASK);
 }
 
+/* Do dynamic round-robin for a process */
+static unsigned roundrobin_nodes(struct mempolicy *policy)
+{
+	unsigned nid, next;
+	struct task_struct *me = current;
+
+	nid = me->rr_next;
+	BUG_ON(nid >= MAX_NUMNODES);
+	next = find_next_bit(policy->v.nodes, MAX_NUMNODES, 1+nid);
+	if (next >= MAX_NUMNODES)
+		next = find_first_bit(policy->v.nodes, MAX_NUMNODES);
+	me->rr_next = next;
+	return nid;
+}
+
 /* Do dynamic interleaving for a process */
 static unsigned interleave_nodes(struct mempolicy *policy)
 {
@@ -646,6 +677,27 @@
 	return page;
 }
 
+/* Allocate a page in round-robin policy.
+   Own path because first fallback needs to round-robin. */
+static struct page *alloc_page_roundrobin(unsigned gfp, unsigned order, struct mempolicy* policy)
+{
+	struct zonelist *zl;
+	struct page *page;
+	unsigned nid;
+	int i, numnodes = bitmap_weight(policy->v.nodes, MAX_NUMNODES);
+
+	for (i = 0; i < numnodes; i++) {
+		nid = roundrobin_nodes(policy);
+		BUG_ON(!test_bit(nid, (const volatile void *) &node_online_map));
+		zl = NODE_DATA(nid)->node_zonelists + (gfp & GFP_ZONEMASK);
+		page = __alloc_pages(gfp, order, zl);
+		if (page)
+			return page;
+	}
+
+	return NULL;
+}
+
 /**
  * 	alloc_page_vma	- Allocate a page for a VMA.
  *
@@ -671,26 +723,30 @@
 struct page *
 alloc_page_vma(unsigned gfp, struct vm_area_struct *vma, unsigned long addr)
 {
+	unsigned nid;
 	struct mempolicy *pol = get_vma_policy(vma, addr);
 
 	cpuset_update_current_mems_allowed();
 
-	if (unlikely(pol->policy == MPOL_INTERLEAVE)) {
-		unsigned nid;
-		if (vma) {
-			unsigned long off;
-			BUG_ON(addr >= vma->vm_end);
-			BUG_ON(addr < vma->vm_start);
-			off = vma->vm_pgoff;
-			off += (addr - vma->vm_start) >> PAGE_SHIFT;
-			nid = offset_il_node(pol, vma, off);
-		} else {
-			/* fall back to process interleaving */
-			nid = interleave_nodes(pol);
-		}
-		return alloc_page_interleave(gfp, 0, nid);
+	switch (pol->policy) {
+		case MPOL_INTERLEAVE:
+			if (vma) {
+				unsigned long off;
+				BUG_ON(addr >= vma->vm_end);
+				BUG_ON(addr < vma->vm_start);
+				off = vma->vm_pgoff;
+				off += (addr - vma->vm_start) >> PAGE_SHIFT;
+				nid = offset_il_node(pol, vma, off);
+			} else {
+				/* fall back to process interleaving */
+				nid = interleave_nodes(pol);
+			}
+			return alloc_page_interleave(gfp, 0, nid);
+		case MPOL_ROUNDROBIN:
+			return alloc_page_roundrobin(gfp, 0, pol);
+		default:
+			return __alloc_pages(gfp, 0, zonelist_policy(gfp, pol));
 	}
-	return __alloc_pages(gfp, 0, zonelist_policy(gfp, pol));
 }
 
 /**
@@ -716,8 +772,11 @@
 		cpuset_update_current_mems_allowed();
 	if (!pol || in_interrupt())
 		pol = &default_policy;
-	if (pol->policy == MPOL_INTERLEAVE)
+	if (pol->policy == MPOL_INTERLEAVE) {
 		return alloc_page_interleave(gfp, order, interleave_nodes(pol));
+	} else if (pol->policy == MPOL_ROUNDROBIN) {
+		return alloc_page_roundrobin(gfp, order, pol);
+	}
 	return __alloc_pages(gfp, order, zonelist_policy(gfp, pol));
 }
 EXPORT_SYMBOL(alloc_pages_current);
@@ -754,6 +813,7 @@
 	case MPOL_DEFAULT:
 		return 1;
 	case MPOL_INTERLEAVE:
+	case MPOL_ROUNDROBIN:
 		return bitmap_equal(a->v.nodes, b->v.nodes, MAX_NUMNODES);
 	case MPOL_PREFERRED:
 		return a->v.preferred_node == b->v.preferred_node;
@@ -798,6 +858,8 @@
 		return pol->v.zonelist->zones[0]->zone_pgdat->node_id;
 	case MPOL_INTERLEAVE:
 		return interleave_nodes(pol);
+	case MPOL_ROUNDROBIN:
+		return roundrobin_nodes(pol);
 	case MPOL_PREFERRED:
 		return pol->v.preferred_node >= 0 ?
 				pol->v.preferred_node : numa_node_id();
@@ -815,6 +877,7 @@
 	case MPOL_PREFERRED:
 	case MPOL_DEFAULT:
 	case MPOL_INTERLEAVE:
+	case MPOL_ROUNDROBIN:
 		return 1;
 	case MPOL_BIND: {
 		struct zone **z;
===================================================================
Index: linux-2.6.9-rc1-mm2-kdb/include/linux/mempolicy.h
===================================================================
--- linux-2.6.9-rc1-mm2-kdb.orig/include/linux/mempolicy.h	2004-08-27 10:06:15.000000000 -0700
+++ linux-2.6.9-rc1-mm2-kdb/include/linux/mempolicy.h	2004-09-02 13:19:38.000000000 -0700
@@ -13,6 +13,7 @@
 #define MPOL_PREFERRED	1
 #define MPOL_BIND	2
 #define MPOL_INTERLEAVE	3
+#define MPOL_ROUNDROBIN 4
 
 #define MPOL_MAX MPOL_INTERLEAVE
 

-- 
Best Regards,
Ray
-----------------------------------------------
Ray Bryant                       raybry@sgi.com
The box said: "Requires Windows 98 or better",
           so I installed Linux.
-----------------------------------------------
