Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266867AbUITTJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266867AbUITTJy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 15:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266705AbUITTJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 15:09:54 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:34741 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267234AbUITTFa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 15:05:30 -0400
Date: Mon, 20 Sep 2004 12:00:38 -0700 (PDT)
From: Ray Bryant <raybry@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Ray Bryant <raybry@austin.rr.com>
Cc: linux-mm <linux-mm@kvack.org>, Jesse Barnes <jbarnes@sgi.com>,
       Dan Higgins <djh@sgi.com>, Dave Hansen <haveblue@us.ibm.com>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Brent Casavant <bcasavan@sgi.com>, Ray Bryant <raybry@austin.rr.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ray Bryant <raybry@sgi.com>, Paul Jackson <pj@sgi.com>,
       Nick Piggin <piggin@cyberone.com.au>
Message-Id: <20040920190038.26965.18231.42543@tomahawk.engr.sgi.com>
In-Reply-To: <20040920190033.26965.64678.54625@tomahawk.engr.sgi.com>
References: <20040920190033.26965.64678.54625@tomahawk.engr.sgi.com>
Subject: [PATCH 2.6.9-rc2-mm1 1/2] mm: memory policy for page cache allocation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch creates MPOL_ROUNDROBIN.  This is like MPOL_INTERLEAVE,
but doesn't require a global offset or index to be specified.

Index: linux-2.6.9-rc1-mm3-kdb-pagecache/include/linux/sched.h
===================================================================
--- linux-2.6.9-rc1-mm3-kdb-pagecache.orig/include/linux/sched.h	2004-09-03 09:45:42.000000000 -0700
+++ linux-2.6.9-rc1-mm3-kdb-pagecache/include/linux/sched.h	2004-09-03 09:47:42.000000000 -0700
@@ -596,6 +596,7 @@
 #ifdef CONFIG_NUMA
   	struct mempolicy *mempolicy;
   	short il_next;		/* could be shared with used_math */
+	short rr_next;
 #endif
 #ifdef CONFIG_CPUSETS
 	struct cpuset *cpuset;
Index: linux-2.6.9-rc1-mm3-kdb-pagecache/mm/mempolicy.c
===================================================================
--- linux-2.6.9-rc1-mm3-kdb-pagecache.orig/mm/mempolicy.c	2004-09-03 09:45:40.000000000 -0700
+++ linux-2.6.9-rc1-mm3-kdb-pagecache/mm/mempolicy.c	2004-09-03 09:47:42.000000000 -0700
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
Index: linux-2.6.9-rc1-mm3-kdb-pagecache/include/linux/mempolicy.h
===================================================================
--- linux-2.6.9-rc1-mm3-kdb-pagecache.orig/include/linux/mempolicy.h	2004-08-27 10:06:15.000000000 -0700
+++ linux-2.6.9-rc1-mm3-kdb-pagecache/include/linux/mempolicy.h	2004-09-16 09:27:08.000000000 -0700
@@ -13,8 +13,9 @@
 #define MPOL_PREFERRED	1
 #define MPOL_BIND	2
 #define MPOL_INTERLEAVE	3
+#define MPOL_ROUNDROBIN 4
 
-#define MPOL_MAX MPOL_INTERLEAVE
+#define MPOL_MAX MPOL_ROUNDROBIN
 
 /* Flags for get_mem_policy */
 #define MPOL_F_NODE	(1<<0)	/* return next IL mode instead of node mask */

-- 
Best Regards,
Ray
-----------------------------------------------
Ray Bryant                       raybry@sgi.com
The box said: "Requires Windows 98 or better",
           so I installed Linux.
-----------------------------------------------
