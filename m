Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbWCRUkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWCRUkd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 15:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbWCRUkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 15:40:33 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:2512 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750968AbWCRUkc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 15:40:32 -0500
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@suse.de>,
       Paul Jackson <pj@sgi.com>, Dave Hansen <haveblue@us.ibm.com>,
       Ingo Molnar <mingo@elte.hu>, Christoph Lameter <clameter@sgi.com>
Date: Sat, 18 Mar 2006 12:40:27 -0800
Message-Id: <20060318204027.13217.34767.sendpatchset@sam.engr.sgi.com>
Subject: [PATCH] Cpuset: alloc_pages_node overrides cpuset constraints
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Christoph Lameter <clameter@sgi.com>

Make alloc_pages_node() ignore cpusets.

Currently alloc_pages_node() obeys cpusets.  If you ask for a page
on a node outside the current tasks cpuset, you will be forced to
take a page within your cpuset instead.

Several kernel mechanisms use alloc_pages_node(), directly or
indirectly, including the numa-aware slab allocator, various device
and bus controller drivers, the page migration facility, the hugetlb
allocator, node local data, numa aware block io scheduler, per-node
mmtimers, per-node network buffers, per-node oprofile buffers, memory
pools, some netfilter counters, and any other caller of kmalloc_node()
or vmalloc_node().

These mechanisms are expecting to get memory on the node they asked
for, regardless of user imposed cpuset memory placement constraints.

This patch adds a __GFP_NOCPUSET flag to disable cpuset memory
placement.  It is set in alloc_pages_node() and checked in
__cpuset_zone_allowed().  The routine alloc_pages_node() is the
common routine that all node-specific allocation calls resolve to, and
__cpuset_zone_allowed() is called from the hook beneath __alloc_pages()
to enforce cpuset memory constraints.

Signed-off-by: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Paul Jackson <pj@sgi.com>

---

Andrew,

This is needed for memory migration to work if it is invoked from
a task that is cpuset memory constrained.  Without this, writing a
cpusets 'mems' file (when its memory_migrate flag is set '1') from
a task that is in some limited cpuset (not all memory nodes allowed)
causes the migration to go to the memory nodes in that writing tasks
cpuset, not to the requested memory nodes in the 'mems' value written.

I recommend it as a fix in 2.6.16.          -pj

 include/linux/gfp.h |    6 ++++++
 kernel/cpuset.c     |    2 ++
 2 files changed, 8 insertions(+)

--- 2.6.16-rc6.orig/include/linux/gfp.h	2006-03-13 20:19:30.000000000 -0800
+++ 2.6.16-rc6/include/linux/gfp.h	2006-03-17 21:52:03.000000000 -0800
@@ -47,6 +47,7 @@ struct vm_area_struct;
 #define __GFP_ZERO	((__force gfp_t)0x8000u)/* Return zeroed page on success */
 #define __GFP_NOMEMALLOC ((__force gfp_t)0x10000u) /* Don't use emergency reserves */
 #define __GFP_HARDWALL   ((__force gfp_t)0x20000u) /* Enforce hardwall cpuset memory allocs */
+#define __GFP_NOCPUSET	((__force gfp_t)0x40000u)/* Ignore cpuset constraints */
 
 #define __GFP_BITS_SHIFT 20	/* Room for 20 __GFP_FOO bits */
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
@@ -113,6 +114,11 @@ static inline struct page *alloc_pages_n
 	/* Unknown node is current node */
 	if (nid < 0)
 		nid = numa_node_id();
+	/*
+	 * Specified (or implied by nid < 0) node overrides cpuset placement.
+	 * Various slab, page and device node specific allocations need this.
+	 */
+	gfp_mask |= __GFP_NOCPUSET;
 
 	return __alloc_pages(gfp_mask, order,
 		NODE_DATA(nid)->node_zonelists + gfp_zone(gfp_mask));
--- 2.6.16-rc6.orig/kernel/cpuset.c	2006-03-13 20:19:36.000000000 -0800
+++ 2.6.16-rc6/kernel/cpuset.c	2006-03-17 21:52:18.000000000 -0800
@@ -2164,6 +2164,8 @@ int __cpuset_zone_allowed(struct zone *z
 	node = z->zone_pgdat->node_id;
 	if (node_isset(node, current->mems_allowed))
 		return 1;
+	if (gfp_mask & __GFP_NOCPUSET)
+		return 1;
 	if (gfp_mask & __GFP_HARDWALL)	/* If hardwall request, stop here */
 		return 0;
 

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
