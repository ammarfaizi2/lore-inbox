Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbVKRBwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbVKRBwF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 20:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbVKRBwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 20:52:05 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:22986 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750750AbVKRBwD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 20:52:03 -0500
Date: Thu, 17 Nov 2005 17:51:54 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: linux-kernel@vger.kernel.org
cc: linux-mm@kvack.org, akpm@osdl.org, ak@suse.de
Subject: [PATCH] NUMA policies in the slab allocator V2
Message-ID: <Pine.LNX.4.62.0511171745410.22486@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a regression in 2.6.14 against 2.6.13 that causes an
imbalance in memory allocation during bootup.

The slab allocator in 2.6.13 is not numa aware and simply calls alloc_pages().
This means that memory policies may control the behavior of alloc_pages().
During bootup the memory policy is set to MPOL_INTERLEAVE resulting in the
spreading out of allocations during bootup over all available nodes.
The slab allocator in 2.6.13 has only a single list of slab pages. As a result
the per cpu slab cache and the spinlock controlled page lists may contain slab
entries from off node memory. The slab allocator in 2.6.13 makes no effort
to discern the locality of an entry on its lists.

The NUMA aware slab allocator in 2.6.14 controls locality of the slab pages
explicitly by calling alloc_pages_node(). The NUMA slab allocator
manages slab entries by having lists of available slab pages for each node.
The per cpu slab cache can only contain slab entries associated with the node
local to the processor. This guarantees that the default allocation mode
of the slab allocator always assigns local memory if available.

Setting MPOL_INTERLEAVE as a default policy during bootup has no effect
anymore. In 2.6.14 all node unspecific slab allocations are performed
on the boot processor. This means that most of key data structures are
allocated on one node. Most processors will have to refer to these 
structures making the boot node a potential bottleneck. This may 
reduce performance and cause unnecessary memory pressure on the boot node.

This patch implements NUMA policies in the slab layer. There is
the need of explicit application of NUMA memory policies by the slab
allcator itself since the NUMA slab allocator does no longer let the
page_allocator control locality.

The check for policies is made directly at the beginning of __cache_alloc
using current->mempolicy. The memory policy is already frequently checked
by the page allocator (alloc_page_vma() and alloc_page_current()). So
it is highly likely that the cacheline is present. For MPOL_INTERLEAVE
kmalloc() will spread out each request to one node after another so
that an equal distribution of allocations can be obtained during bootup.

It is not possible to push the policy check to lower layers of the NUMA
slab allocator since the per cpu caches are now only containing slab entries
from the current node. If the policy says that the local node is not
to be preferred or forbidden then there is no point in checking the
slab cache or local list of slab pages. The allocation better be directed
immediately to the lists containing slab entries for the allowed set of
nodes.

This way of applying policy also fixes another strange behavior in 2.6.13.
alloc_pages() is controlled by the memory allocation policy of the
current process. It could therefore be that one process is running with
MPOL_INTERLEAVE and would f.e. obtain a new page following that
policy since no slab entries are in the lists anymore. A page can 
typically be used for multiple slab entries but lets say that the current 
process is only using one. The other entries are then added to the slab 
lists. These are now non local entries in the slab lists despite of the 
possible availability of local pages that would provide faster access and
increase the performance of the application.

Another process without MPOL_INTERLEAVE may now run and expect a local
slab entry from kmalloc(). However, there are still these free slab 
entries from the off node page obtained from the other process via 
MPOL_INTERLEAVE in the cache. The process will then get an off node slab 
entry although other slab entries may be available that are local to that 
process. This means that the policy if one process may contaminate
the locality of the slab caches for other processes.

This patch in effect insures that a per process policy is followed for
the allocation of slab entries and that there cannot be a memory policy 
influence from one process to another. A process with default policy will 
always get a local slab entry if one is available. And the process using 
memory policies will get its memory arranged as requested. Off-node
slab allocation will require the use of spinlocks and will make the use
of per cpu caches not possible. A process using memory policies to redirect
allocations offnode will have to cope with additional lock overhead in
addition to the latency added by the need to access a remote slab entry.

Changes V1->V2
- Remove #ifdef CONFIG_NUMA by moving forward declaration into
  prior #ifdef CONFIG_NUMA section.

- Give the function determining the node number to use a saner
  name.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc1-mm1/mm/slab.c
===================================================================
--- linux-2.6.15-rc1-mm1.orig/mm/slab.c	2005-11-17 15:17:32.000000000 -0800
+++ linux-2.6.15-rc1-mm1/mm/slab.c	2005-11-17 16:54:24.000000000 -0800
@@ -103,6 +103,7 @@
 #include	<linux/rcupdate.h>
 #include	<linux/string.h>
 #include	<linux/nodemask.h>
+#include	<linux/mempolicy.h>
 
 #include	<asm/uaccess.h>
 #include	<asm/cacheflush.h>
@@ -775,6 +776,8 @@ static struct array_cache *alloc_arrayca
 }
 
 #ifdef CONFIG_NUMA
+static void *__cache_alloc_node(kmem_cache_t *, gfp_t, int);
+
 static inline struct array_cache **alloc_alien_cache(int node, int limit)
 {
 	struct array_cache **ac_ptr;
@@ -2538,6 +2541,15 @@ static inline void *____cache_alloc(kmem
 	void* objp;
 	struct array_cache *ac;
 
+#ifdef CONFIG_NUMA
+	if (current->mempolicy) {
+		int nid = slab_node(current->mempolicy);
+
+		if (nid != numa_node_id())
+			return __cache_alloc_node(cachep, flags, nid);
+	}
+#endif
+
 	check_irq_off();
 	ac = ac_data(cachep);
 	if (likely(ac->avail)) {
Index: linux-2.6.15-rc1-mm1/mm/mempolicy.c
===================================================================
--- linux-2.6.15-rc1-mm1.orig/mm/mempolicy.c	2005-11-17 15:17:32.000000000 -0800
+++ linux-2.6.15-rc1-mm1/mm/mempolicy.c	2005-11-17 16:54:24.000000000 -0800
@@ -975,6 +975,33 @@ static unsigned interleave_nodes(struct 
 	return nid;
 }
 
+/*
+ * Depending on the memory policy provide a node from which to allocate the
+ * next slab entry.
+ */
+unsigned slab_node(struct mempolicy *policy)
+{
+	switch (policy->policy) {
+	case MPOL_INTERLEAVE:
+		return interleave_nodes(policy);
+
+	case MPOL_BIND:
+		/*
+		 * Follow bind policy behavior and start allocation at the
+		 * first node.
+		 */
+		return policy->v.zonelist->zones[0]->zone_pgdat->node_id;
+
+	case MPOL_PREFERRED:
+		if (policy->v.preferred_node >= 0)
+			return policy->v.preferred_node;
+		/* Fall through */
+
+	default:
+		return numa_node_id();
+	}
+}
+
 /* Do static interleaving for a VMA with known offset. */
 static unsigned offset_il_node(struct mempolicy *pol,
 		struct vm_area_struct *vma, unsigned long off)
Index: linux-2.6.15-rc1-mm1/include/linux/mempolicy.h
===================================================================
--- linux-2.6.15-rc1-mm1.orig/include/linux/mempolicy.h	2005-11-17 15:17:31.000000000 -0800
+++ linux-2.6.15-rc1-mm1/include/linux/mempolicy.h	2005-11-17 16:54:24.000000000 -0800
@@ -153,6 +153,7 @@ extern void numa_policy_rebind(const nod
 extern struct mempolicy default_policy;
 extern struct zonelist *huge_zonelist(struct vm_area_struct *vma,
 		unsigned long addr);
+extern unsigned slab_node(struct mempolicy *policy);
 
 int do_migrate_pages(struct mm_struct *mm,
 	const nodemask_t *from_nodes, const nodemask_t *to_nodes, int flags);
