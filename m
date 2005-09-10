Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbVIJL6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbVIJL6x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 07:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbVIJL6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 07:58:53 -0400
Received: from ns.suse.de ([195.135.220.2]:35759 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750763AbVIJL6v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 07:58:51 -0400
Date: Sat, 10 Sep 2005 13:58:49 +0200
From: "Andi Kleen" <ak@suse.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [2/3] {PREFIX:-x86_64}: Convert mempolicies to nodemask_t
Message-ID: <4322CA79.mailAO51VX9XB@suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert mempolicies to nodemask_t

[Note to Andrew: this has a hunk for the /proc/*/numa_maps
code to make it compile again. But you said you queued a revert
patch, with which this will likely conflict. If yes just
remove the fs/proc/task_mmu.c hunk. Thanks.]

The NUMA policy code predated nodemask_t so it used open coded bitmaps.
Convert everything to nodemask_t. Big patch, but shouldn't have any
actual behaviour changes (except I removed one unnecessary check
against node_online_map and one unnecessary BUG_ON) 

Index: linux/include/linux/mempolicy.h
===================================================================
--- linux.orig/include/linux/mempolicy.h
+++ linux/include/linux/mempolicy.h
@@ -31,6 +31,7 @@
 #include <linux/slab.h>
 #include <linux/rbtree.h>
 #include <linux/spinlock.h>
+#include <linux/nodemask.h>
 
 struct vm_area_struct;
 
@@ -63,7 +64,7 @@ struct mempolicy {
 	union {
 		struct zonelist  *zonelist;	/* bind */
 		short 		 preferred_node; /* preferred */
-		DECLARE_BITMAP(nodes, MAX_NUMNODES); /* interleave */
+		nodemask_t	 nodes;		/* interleave */
 		/* undefined for default */
 	} v;
 };
Index: linux/mm/mempolicy.c
===================================================================
--- linux.orig/mm/mempolicy.c
+++ linux/mm/mempolicy.c
@@ -93,23 +93,10 @@ struct mempolicy default_policy = {
 	.policy = MPOL_DEFAULT,
 };
 
-/* Check if all specified nodes are online */
-static int nodes_online(unsigned long *nodes)
-{
-	DECLARE_BITMAP(online2, MAX_NUMNODES);
-
-	bitmap_copy(online2, nodes_addr(node_online_map), MAX_NUMNODES);
-	if (bitmap_empty(online2, MAX_NUMNODES))
-		set_bit(0, online2);
-	if (!bitmap_subset(nodes, online2, MAX_NUMNODES))
-		return -EINVAL;
-	return 0;
-}
-
 /* Do sanity checking on a policy */
-static int mpol_check_policy(int mode, unsigned long *nodes)
+static int mpol_check_policy(int mode, nodemask_t *nodes)
 {
-	int empty = bitmap_empty(nodes, MAX_NUMNODES);
+	int empty = nodes_empty(*nodes);
 
 	switch (mode) {
 	case MPOL_DEFAULT:
@@ -124,11 +111,11 @@ static int mpol_check_policy(int mode, u
 			return -EINVAL;
 		break;
 	}
-	return nodes_online(nodes);
+	return nodes_subset(*nodes, node_online_map) ? 0 : -EINVAL;
 }
 
 /* Copy a node mask from user space. */
-static int get_nodes(unsigned long *nodes, unsigned long __user *nmask,
+static int get_nodes(nodemask_t *nodes, unsigned long __user *nmask,
 		     unsigned long maxnode, int mode)
 {
 	unsigned long k;
@@ -136,7 +123,7 @@ static int get_nodes(unsigned long *node
 	unsigned long endmask;
 
 	--maxnode;
-	bitmap_zero(nodes, MAX_NUMNODES);
+	nodes_clear(*nodes);
 	if (maxnode == 0 || !nmask)
 		return 0;
 
@@ -153,7 +140,7 @@ static int get_nodes(unsigned long *node
 			return -EINVAL;
 		for (k = BITS_TO_LONGS(MAX_NUMNODES); k < nlongs; k++) {
 			unsigned long t;
-			if (get_user(t,  nmask + k))
+			if (get_user(t, nmask + k))
 				return -EFAULT;
 			if (k == nlongs - 1) {
 				if (t & endmask)
@@ -165,30 +152,29 @@ static int get_nodes(unsigned long *node
 		endmask = ~0UL;
 	}
 
-	if (copy_from_user(nodes, nmask, nlongs*sizeof(unsigned long)))
+	if (copy_from_user(nodes_addr(*nodes), nmask, nlongs*sizeof(unsigned long)))
 		return -EFAULT;
-	nodes[nlongs-1] &= endmask;
+	nodes_addr(*nodes)[nlongs-1] &= endmask;
 	/* Update current mems_allowed */
 	cpuset_update_current_mems_allowed();
 	/* Ignore nodes not set in current->mems_allowed */
-	cpuset_restrict_to_mems_allowed(nodes);
+	/* AK: shouldn't this error out instead? */
+	cpuset_restrict_to_mems_allowed(nodes_addr(*nodes));
 	return mpol_check_policy(mode, nodes);
 }
 
 /* Generate a custom zonelist for the BIND policy. */
-static struct zonelist *bind_zonelist(unsigned long *nodes)
+static struct zonelist *bind_zonelist(nodemask_t *nodes)
 {
 	struct zonelist *zl;
 	int num, max, nd;
 
-	max = 1 + MAX_NR_ZONES * bitmap_weight(nodes, MAX_NUMNODES);
+	max = 1 + MAX_NR_ZONES * nodes_weight(*nodes);
 	zl = kmalloc(sizeof(void *) * max, GFP_KERNEL);
 	if (!zl)
 		return NULL;
 	num = 0;
-	for (nd = find_first_bit(nodes, MAX_NUMNODES);
-	     nd < MAX_NUMNODES;
-	     nd = find_next_bit(nodes, MAX_NUMNODES, 1+nd)) {
+	for_each_node_mask(nd, *nodes) { 
 		int k;
 		for (k = MAX_NR_ZONES-1; k >= 0; k--) {
 			struct zone *z = &NODE_DATA(nd)->node_zones[k];
@@ -205,11 +191,11 @@ static struct zonelist *bind_zonelist(un
 }
 
 /* Create a new policy */
-static struct mempolicy *mpol_new(int mode, unsigned long *nodes)
+static struct mempolicy *mpol_new(int mode, nodemask_t *nodes)
 {
 	struct mempolicy *policy;
 
-	PDprintk("setting mode %d nodes[0] %lx\n", mode, nodes[0]);
+	PDprintk("setting mode %d nodes[0] %lx\n", mode, nodes_addr(nodes)[0]);
 	if (mode == MPOL_DEFAULT)
 		return NULL;
 	policy = kmem_cache_alloc(policy_cache, GFP_KERNEL);
@@ -218,10 +204,10 @@ static struct mempolicy *mpol_new(int mo
 	atomic_set(&policy->refcnt, 1);
 	switch (mode) {
 	case MPOL_INTERLEAVE:
-		bitmap_copy(policy->v.nodes, nodes, MAX_NUMNODES);
+		policy->v.nodes = *nodes;
 		break;
 	case MPOL_PREFERRED:
-		policy->v.preferred_node = find_first_bit(nodes, MAX_NUMNODES);
+		policy->v.preferred_node = first_node(*nodes);
 		if (policy->v.preferred_node >= MAX_NUMNODES)
 			policy->v.preferred_node = -1;
 		break;
@@ -239,7 +225,7 @@ static struct mempolicy *mpol_new(int mo
 
 /* Ensure all existing pages follow the policy. */
 static int check_pte_range(struct mm_struct *mm, pmd_t *pmd,
-		unsigned long addr, unsigned long end, unsigned long *nodes)
+		unsigned long addr, unsigned long end, nodemask_t *nodes)
 {
 	pte_t *orig_pte;
 	pte_t *pte;
@@ -256,7 +242,7 @@ static int check_pte_range(struct mm_str
 		if (!pfn_valid(pfn))
 			continue;
 		nid = pfn_to_nid(pfn);
-		if (!test_bit(nid, nodes))
+		if (!node_isset(nid, *nodes))
 			break;
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 	pte_unmap(orig_pte);
@@ -265,7 +251,7 @@ static int check_pte_range(struct mm_str
 }
 
 static inline int check_pmd_range(struct mm_struct *mm, pud_t *pud,
-		unsigned long addr, unsigned long end, unsigned long *nodes)
+		unsigned long addr, unsigned long end, nodemask_t *nodes)
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -282,7 +268,7 @@ static inline int check_pmd_range(struct
 }
 
 static inline int check_pud_range(struct mm_struct *mm, pgd_t *pgd,
-		unsigned long addr, unsigned long end, unsigned long *nodes)
+		unsigned long addr, unsigned long end, nodemask_t *nodes)
 {
 	pud_t *pud;
 	unsigned long next;
@@ -299,7 +285,7 @@ static inline int check_pud_range(struct
 }
 
 static inline int check_pgd_range(struct mm_struct *mm,
-		unsigned long addr, unsigned long end, unsigned long *nodes)
+		unsigned long addr, unsigned long end, nodemask_t *nodes)
 {
 	pgd_t *pgd;
 	unsigned long next;
@@ -318,7 +304,7 @@ static inline int check_pgd_range(struct
 /* Step 1: check the range */
 static struct vm_area_struct *
 check_range(struct mm_struct *mm, unsigned long start, unsigned long end,
-	    unsigned long *nodes, unsigned long flags)
+	    nodemask_t *nodes, unsigned long flags)
 {
 	int err;
 	struct vm_area_struct *first, *vma, *prev;
@@ -403,7 +389,7 @@ asmlinkage long sys_mbind(unsigned long 
 	struct mm_struct *mm = current->mm;
 	struct mempolicy *new;
 	unsigned long end;
-	DECLARE_BITMAP(nodes, MAX_NUMNODES);
+	nodemask_t nodes;
 	int err;
 
 	if ((flags & ~(unsigned long)(MPOL_MF_STRICT)) || mode > MPOL_MAX)
@@ -419,19 +405,19 @@ asmlinkage long sys_mbind(unsigned long 
 	if (end == start)
 		return 0;
 
-	err = get_nodes(nodes, nmask, maxnode, mode);
+	err = get_nodes(&nodes, nmask, maxnode, mode);
 	if (err)
 		return err;
 
-	new = mpol_new(mode, nodes);
+	new = mpol_new(mode, &nodes);
 	if (IS_ERR(new))
 		return PTR_ERR(new);
 
 	PDprintk("mbind %lx-%lx mode:%ld nodes:%lx\n",start,start+len,
-			mode,nodes[0]);
+			mode,nodes_addr(nodes)[0]);
 
 	down_write(&mm->mmap_sem);
-	vma = check_range(mm, start, end, nodes, flags);
+	vma = check_range(mm, start, end, &nodes, flags);
 	err = PTR_ERR(vma);
 	if (!IS_ERR(vma))
 		err = mbind_range(vma, start, end, new);
@@ -446,45 +432,45 @@ asmlinkage long sys_set_mempolicy(int mo
 {
 	int err;
 	struct mempolicy *new;
-	DECLARE_BITMAP(nodes, MAX_NUMNODES);
+	nodemask_t nodes;
 
 	if (mode < 0 || mode > MPOL_MAX)
 		return -EINVAL;
-	err = get_nodes(nodes, nmask, maxnode, mode);
+	err = get_nodes(&nodes, nmask, maxnode, mode);
 	if (err)
 		return err;
-	new = mpol_new(mode, nodes);
+	new = mpol_new(mode, &nodes);
 	if (IS_ERR(new))
 		return PTR_ERR(new);
 	mpol_free(current->mempolicy);
 	current->mempolicy = new;
 	if (new && new->policy == MPOL_INTERLEAVE)
-		current->il_next = find_first_bit(new->v.nodes, MAX_NUMNODES);
+		current->il_next = first_node(new->v.nodes);
 	return 0;
 }
 
 /* Fill a zone bitmap for a policy */
-static void get_zonemask(struct mempolicy *p, unsigned long *nodes)
+static void get_zonemask(struct mempolicy *p, nodemask_t *nodes)
 {
 	int i;
 
-	bitmap_zero(nodes, MAX_NUMNODES);
+	nodes_clear(*nodes);
 	switch (p->policy) {
 	case MPOL_BIND:
 		for (i = 0; p->v.zonelist->zones[i]; i++)
-			__set_bit(p->v.zonelist->zones[i]->zone_pgdat->node_id, nodes);
+			node_set(p->v.zonelist->zones[i]->zone_pgdat->node_id, *nodes);
 		break;
 	case MPOL_DEFAULT:
 		break;
 	case MPOL_INTERLEAVE:
-		bitmap_copy(nodes, p->v.nodes, MAX_NUMNODES);
+		*nodes = p->v.nodes;
 		break;
 	case MPOL_PREFERRED:
 		/* or use current node instead of online map? */
 		if (p->v.preferred_node < 0)
-			bitmap_copy(nodes, nodes_addr(node_online_map), MAX_NUMNODES);
+			*nodes = node_online_map;
 		else
-			__set_bit(p->v.preferred_node, nodes);
+			node_set(p->v.preferred_node, *nodes);
 		break;
 	default:
 		BUG();
@@ -506,7 +492,7 @@ static int lookup_node(struct mm_struct 
 
 /* Copy a kernel node mask to user space */
 static int copy_nodes_to_user(unsigned long __user *mask, unsigned long maxnode,
-			      void *nodes, unsigned nbytes)
+			      nodemask_t *nodes, unsigned nbytes)
 {
 	unsigned long copy = ALIGN(maxnode-1, 64) / 8;
 
@@ -517,7 +503,7 @@ static int copy_nodes_to_user(unsigned l
 			return -EFAULT;
 		copy = nbytes;
 	}
-	return copy_to_user(mask, nodes, copy) ? -EFAULT : 0;
+	return copy_to_user(mask, nodes_addr(*nodes), copy) ? -EFAULT : 0;
 }
 
 /* Retrieve NUMA policy */
@@ -578,9 +564,9 @@ asmlinkage long sys_get_mempolicy(int __
 
 	err = 0;
 	if (nmask) {
-		DECLARE_BITMAP(nodes, MAX_NUMNODES);
-		get_zonemask(pol, nodes);
-		err = copy_nodes_to_user(nmask, maxnode, nodes, sizeof(nodes));
+		nodemask_t nodes;
+		get_zonemask(pol, &nodes);
+		err = copy_nodes_to_user(nmask, maxnode, &nodes, sizeof(nodes));
 	}
 
  out:
@@ -649,15 +635,15 @@ asmlinkage long compat_sys_mbind(compat_
 	long err = 0;
 	unsigned long __user *nm = NULL;
 	unsigned long nr_bits, alloc_size;
-	DECLARE_BITMAP(bm, MAX_NUMNODES);
+	nodemask_t bm;
 
 	nr_bits = min_t(unsigned long, maxnode-1, MAX_NUMNODES);
 	alloc_size = ALIGN(nr_bits, BITS_PER_LONG) / 8;
 
 	if (nmask) {
-		err = compat_get_bitmap(bm, nmask, nr_bits);
+		err = compat_get_bitmap(nodes_addr(bm), nmask, nr_bits);
 		nm = compat_alloc_user_space(alloc_size);
-		err |= copy_to_user(nm, bm, alloc_size);
+		err |= copy_to_user(nm, nodes_addr(bm), alloc_size);
 	}
 
 	if (err)
@@ -723,9 +709,9 @@ static unsigned interleave_nodes(struct 
 
 	nid = me->il_next;
 	BUG_ON(nid >= MAX_NUMNODES);
-	next = find_next_bit(policy->v.nodes, MAX_NUMNODES, 1+nid);
+	next = next_node(1+nid, policy->v.nodes);
 	if (next >= MAX_NUMNODES)
-		next = find_first_bit(policy->v.nodes, MAX_NUMNODES);
+		next = first_node(policy->v.nodes);
 	me->il_next = next;
 	return nid;
 }
@@ -734,18 +720,17 @@ static unsigned interleave_nodes(struct 
 static unsigned offset_il_node(struct mempolicy *pol,
 		struct vm_area_struct *vma, unsigned long off)
 {
-	unsigned nnodes = bitmap_weight(pol->v.nodes, MAX_NUMNODES);
+	unsigned nnodes = nodes_weight(pol->v.nodes);
 	unsigned target = (unsigned)off % nnodes;
 	int c;
 	int nid = -1;
 
 	c = 0;
 	do {
-		nid = find_next_bit(pol->v.nodes, MAX_NUMNODES, nid+1);
+		nid = next_node(nid+1, pol->v.nodes);
 		c++;
 	} while (c <= target);
 	BUG_ON(nid >= MAX_NUMNODES);
-	BUG_ON(!test_bit(nid, pol->v.nodes));
 	return nid;
 }
 
@@ -878,7 +863,7 @@ int __mpol_equal(struct mempolicy *a, st
 	case MPOL_DEFAULT:
 		return 1;
 	case MPOL_INTERLEAVE:
-		return bitmap_equal(a->v.nodes, b->v.nodes, MAX_NUMNODES);
+		return nodes_equal(a->v.nodes, b->v.nodes);
 	case MPOL_PREFERRED:
 		return a->v.preferred_node == b->v.preferred_node;
 	case MPOL_BIND: {
@@ -1117,7 +1102,7 @@ int mpol_set_shared_policy(struct shared
 	PDprintk("set_shared_policy %lx sz %lu %d %lx\n",
 		 vma->vm_pgoff,
 		 sz, npol? npol->policy : -1,
-		npol ? npol->v.nodes[0] : -1);
+		npol ? nodes_addr(npol->v.nodes)[0] : -1);
 
 	if (npol) {
 		new = sp_alloc(vma->vm_pgoff, vma->vm_pgoff + sz, npol);
Index: linux/fs/proc/task_mmu.c
===================================================================
--- linux.orig/fs/proc/task_mmu.c
+++ linux/fs/proc/task_mmu.c
@@ -469,7 +469,7 @@ static int show_numa_map(struct seq_file
 		seq_printf(m, " interleave={");
 		first = 1;
 		for_each_node(n) {
-			if (test_bit(n, pol->v.nodes)) {
+			if (node_isset(n, pol->v.nodes)) {
 				if (!first)
 					seq_putc(m,',');
 				else
