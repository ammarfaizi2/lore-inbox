Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264192AbUHBXgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264192AbUHBXgm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 19:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbUHBXgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 19:36:42 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:30925 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264192AbUHBXfM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 19:35:12 -0400
Date: Mon, 2 Aug 2004 16:35:06 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
Cc: Paul Jackson <pj@sgi.com>
Message-Id: <20040802233516.11477.10063.34205@sam.engr.sgi.com>
Subject: [PATCH] subset zonelists and big numa friendly mempolicy MPOL_MBIND
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I hope that this patch will end up in *-mm soon.

But not yet -- first it must be reviewed by Andi Kleen, the mempolicy
author, and whomever else would like to comment.

This patch adds support for subset_zonelists.  These are zonelists
suitable for passing to __alloc_pages() for allocations that are
restricted to some subset of the systems memory nodes.

This patch also modifies the MPOL_BIND code in mm/mempolicy.c to
use these subset_zonelists.  This replaces an earlier, simpler,
implementation of such restricted zonelists that was in mm/mempolicy.c.

The current implementation provides a single list, sorted in node
order, for all nodes in the subset.  This is numa unfriendly when
used on sets of several memory nodes.  It loads up the first node in
the list, not trying the cpu local node first, and pays no regard to
distance between nodes (not trying near nodes before far nodes).

This new implementation preserves the "first-touch" preference
(allocate on the node currently executing on, if that node is
in the allowed subset).  It also preserves the zonelist ordering
that favors nearer nodes over further nodes on large NUMA systems.
And it removes the mempolicy restriction that only the highest zone
in the zone hierarchy is policied.

For smaller (a few nodes) dedicated application servers, this is
probably not essential.  But for larger (hundreds of nodes) NUMA
systems, running several simultaneous jobs in disjoint node subsets
of dozens or hundreds of nodes each, the numa friendly placement of
memory within each subset is critical to system performance.

The bulk of the code for constructing subset zonelists is moved
into mm/page_alloc.c, where other zonelist management code lives.
The code goes to some length to keep the data representation of a
subset zonelist small.  On systems where all memory is GFP_DMA,
the system wide zonelists off each nodes NODE_DATA are inflated
about 9x larger than necessary.  For the initial zonelists created
in the restricted context of boottime, this is probably not worth
worrying about.  But for dozens or hundreds of subset zonelists that
are dynamically created in a large system (one each call to mbind
or mempolicy requesting MPOL_BIND), it is worthwhile to compress the
zonelists to a more compact representation.  The code to compress the
zonelists (removing unused and duplicate entries) is arch-neutral,
NUMA-only, not performance critical and fairly isolated.  So it won't
impact non-NUMA kernel text size, and once it's working, it should
be low maintenance.

This version of the patch is against 2.6.8-rc2-mm1.  It has been
compiled, booted and passed a simple test for sn2_defconfig (ia64 arch,
SN2 hardware).

 include/linux/mempolicy.h |    2 
 include/linux/mmzone.h    |   40 +++++
 mm/mempolicy.c            |   99 ++++----------
 mm/page_alloc.c           |  313 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 383 insertions(+), 71 deletions(-)

Index: 2.6.8-rc2-mm1/include/linux/mempolicy.h
===================================================================
--- 2.6.8-rc2-mm1.orig/include/linux/mempolicy.h	2004-08-02 04:37:03.000000000 -0700
+++ 2.6.8-rc2-mm1/include/linux/mempolicy.h	2004-08-02 04:37:15.000000000 -0700
@@ -61,7 +61,7 @@ struct mempolicy {
 	atomic_t refcnt;
 	short policy; 	/* See MPOL_* above */
 	union {
-		struct zonelist  *zonelist;	/* bind */
+		struct subset_zonelists *zonelists;   /* bind */
 		short 		 preferred_node; /* preferred */
 		DECLARE_BITMAP(nodes, MAX_NUMNODES); /* interleave */
 		/* undefined for default */
Index: 2.6.8-rc2-mm1/include/linux/mmzone.h
===================================================================
--- 2.6.8-rc2-mm1.orig/include/linux/mmzone.h	2004-08-02 04:37:03.000000000 -0700
+++ 2.6.8-rc2-mm1/include/linux/mmzone.h	2004-08-02 16:16:04.000000000 -0700
@@ -11,6 +11,7 @@
 #include <linux/cache.h>
 #include <linux/threads.h>
 #include <linux/numa.h>
+#include <linux/kref.h>
 #include <asm/atomic.h>
 
 /* Free memory management - zoned buddy allocator.  */
@@ -237,6 +238,45 @@ struct zonelist {
 	struct zone *zones[MAX_NUMNODES * MAX_NR_ZONES + 1]; // NULL delimited
 };
 
+#ifdef CONFIG_NUMA
+
+/*
+ * Subset_zonelists are used when allocating memory from a restricted
+ * set of Memory Nodes.  They provide for each node in the set
+ * a zonelist containing only the zones on the nodes in the set.
+ * These restricted zonelists are extracted from the system-wide
+ * NODE_DATA node_zonelists, preserving order.
+ *
+ * Subset_zonelists are used for running jobs on a strictly limited
+ * subsets of a systems entire available memory (e.g. MPOL_MBIND).
+ *
+ * The 'zones' field points to a linear list of zonelists, packed one
+ * after the other, each NULL terminated.  The 'cg2z' (for "cpu gfp
+ * to zone map" field is a kmalloc'd 2-D array cg2z[cpu][gfp_type]
+ * of indices into 'zones', where the zonelist to use for faults on
+ * a given 'cpu' of 'gfp_type' begins at zone + cg2z[cpu][gfp_type].
+ *
+ * The special case of zones == cg2z == NULL is used to represent
+ * the set of all nodes.  Use the normal system-wide NODE_DATA
+ * node_zonelists directly in that case.
+ *
+ * The 'nodes' field caches a bitmap of the nodes in the subset.
+ *
+ * These can be big and they're shared and read-only once built, so
+ * 'ref' field provides a reference count.  On release, kfree 'cg2z'
+ * and 'zones'.
+ */
+
+struct subset_zonelists {
+	struct zone **zones;
+	int (*cg2z)[GFP_ZONETYPES];
+	struct kref ref;
+	DECLARE_BITMAP(nodes, MAX_NUMNODES);
+};
+
+struct subset_zonelists *build_subset_zonelists(const unsigned long *nodes);
+
+#endif
 
 /*
  * The pg_data_t structure is used in machines with CONFIG_DISCONTIGMEM
Index: 2.6.8-rc2-mm1/mm/mempolicy.c
===================================================================
--- 2.6.8-rc2-mm1.orig/mm/mempolicy.c	2004-08-02 04:37:03.000000000 -0700
+++ 2.6.8-rc2-mm1/mm/mempolicy.c	2004-08-02 13:39:16.000000000 -0700
@@ -37,11 +37,6 @@
  * is not applied, but the majority should be handled. When process policy
  * is used it is not remembered over swap outs/swap ins.
  *
- * Only the highest zone in the zone hierarchy gets policied. Allocations
- * requesting a lower zone just use default policy. This implies that
- * on systems with highmem kernel lowmem allocation don't get policied.
- * Same with GFP_DMA allocations.
- *
  * For shmfs/tmpfs/hugetlbfs shared memory the policy is shared between
  * all users and remembered even when nobody has memory mapped.
  */
@@ -74,6 +69,7 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/compat.h>
+#include <linux/topology.h>
 #include <linux/mempolicy.h>
 #include <asm/uaccess.h>
 
@@ -82,10 +78,6 @@ static kmem_cache_t *sn_cache;
 
 #define PDprintk(fmt...)
 
-/* Highest zone. An specific allocation for a zone below that is not
-   policied. */
-static int policy_zone;
-
 static struct mempolicy default_policy = {
 	.refcnt = ATOMIC_INIT(1), /* never free it */
 	.policy = MPOL_DEFAULT,
@@ -167,35 +159,6 @@ static int get_nodes(unsigned long *node
 	return mpol_check_policy(mode, nodes);
 }
 
-/* Generate a custom zonelist for the BIND policy. */
-static struct zonelist *bind_zonelist(unsigned long *nodes)
-{
-	struct zonelist *zl;
-	int num, max, nd;
-
-	max = 1 + MAX_NR_ZONES * bitmap_weight(nodes, MAX_NUMNODES);
-	zl = kmalloc(sizeof(void *) * max, GFP_KERNEL);
-	if (!zl)
-		return NULL;
-	num = 0;
-	for (nd = find_first_bit(nodes, MAX_NUMNODES);
-	     nd < MAX_NUMNODES;
-	     nd = find_next_bit(nodes, MAX_NUMNODES, 1+nd)) {
-		int k;
-		for (k = MAX_NR_ZONES-1; k >= 0; k--) {
-			struct zone *z = &NODE_DATA(nd)->node_zones[k];
-			if (!z->present_pages)
-				continue;
-			zl->zones[num++] = z;
-			if (k > policy_zone)
-				policy_zone = k;
-		}
-	}
-	BUG_ON(num >= max);
-	zl->zones[num] = NULL;
-	return zl;
-}
-
 /* Create a new policy */
 static struct mempolicy *mpol_new(int mode, unsigned long *nodes)
 {
@@ -218,10 +181,11 @@ static struct mempolicy *mpol_new(int mo
 			policy->v.preferred_node = -1;
 		break;
 	case MPOL_BIND:
-		policy->v.zonelist = bind_zonelist(nodes);
-		if (policy->v.zonelist == NULL) {
+		policy->v.zonelists = build_subset_zonelists(nodes);
+		if (IS_ERR(policy->v.zonelists)) {
+			int err = PTR_ERR(policy->v.zonelists);
 			kmem_cache_free(policy_cache, policy);
-			return ERR_PTR(-ENOMEM);
+			return ERR_PTR(err);
 		}
 		break;
 	}
@@ -407,13 +371,10 @@ asmlinkage long sys_set_mempolicy(int mo
 /* Fill a zone bitmap for a policy */
 static void get_zonemask(struct mempolicy *p, unsigned long *nodes)
 {
-	int i;
-
 	bitmap_zero(nodes, MAX_NUMNODES);
 	switch (p->policy) {
 	case MPOL_BIND:
-		for (i = 0; p->v.zonelist->zones[i]; i++)
-			__set_bit(p->v.zonelist->zones[i]->zone_pgdat->node_id, nodes);
+		bitmap_copy(nodes, p->v.zonelists->nodes, MAX_NUMNODES);
 		break;
 	case MPOL_DEFAULT:
 		break;
@@ -572,13 +533,22 @@ static struct zonelist *zonelist_policy(
 		if (nd < 0)
 			nd = numa_node_id();
 		break;
-	case MPOL_BIND:
-		/* Lower zones don't get a policy applied */
-		if (gfp >= policy_zone)
-			return policy->v.zonelist;
-		/*FALL THROUGH*/
+	case MPOL_BIND: {
+		struct subset_zonelists *sz;
+		int i, cpu;
+		struct zone **zone;
+
+		sz = policy->v.zonelists;
+		if (sz->zones == NULL)
+			goto defaultcase;
+		cpu = smp_processor_id();
+		i = gfp & GFP_ZONEMASK;
+		zone = sz->zones + sz->cg2z[cpu][i];
+		return (struct zonelist *)zone;
+	}
 	case MPOL_INTERLEAVE: /* should not happen */
 	case MPOL_DEFAULT:
+defaultcase:
 		nd = numa_node_id();
 		break;
 	default:
@@ -720,15 +690,8 @@ struct mempolicy *__mpol_copy(struct mem
 		return ERR_PTR(-ENOMEM);
 	*new = *old;
 	atomic_set(&new->refcnt, 1);
-	if (new->policy == MPOL_BIND) {
-		int sz = ksize(old->v.zonelist);
-		new->v.zonelist = kmalloc(sz, SLAB_KERNEL);
-		if (!new->v.zonelist) {
-			kmem_cache_free(policy_cache, new);
-			return ERR_PTR(-ENOMEM);
-		}
-		memcpy(new->v.zonelist, old->v.zonelist, sz);
-	}
+	if (new->policy == MPOL_BIND)
+		kref_get(&new->v.zonelists->ref);
 	return new;
 }
 
@@ -746,13 +709,9 @@ int __mpol_equal(struct mempolicy *a, st
 		return bitmap_equal(a->v.nodes, b->v.nodes, MAX_NUMNODES);
 	case MPOL_PREFERRED:
 		return a->v.preferred_node == b->v.preferred_node;
-	case MPOL_BIND: {
-		int i;
-		for (i = 0; a->v.zonelist->zones[i]; i++)
-			if (a->v.zonelist->zones[i] != b->v.zonelist->zones[i])
-				return 0;
-		return b->v.zonelist->zones[i] == NULL;
-	}
+	case MPOL_BIND:
+		return bitmap_equal(a->v.zonelists->nodes,
+					b->v.zonelists->nodes, MAX_NUMNODES);
 	default:
 		BUG();
 		return 0;
@@ -765,7 +724,7 @@ void __mpol_free(struct mempolicy *p)
 	if (!atomic_dec_and_test(&p->refcnt))
 		return;
 	if (p->policy == MPOL_BIND)
-		kfree(p->v.zonelist);
+		kref_put(&p->v.zonelists->ref);
 	p->policy = MPOL_DEFAULT;
 	kmem_cache_free(policy_cache, p);
 }
@@ -784,7 +743,7 @@ int mpol_first_node(struct vm_area_struc
 	case MPOL_DEFAULT:
 		return numa_node_id();
 	case MPOL_BIND:
-		return pol->v.zonelist->zones[0]->zone_pgdat->node_id;
+		return find_first_bit(pol->v.zonelists->nodes, MAX_NUMNODES);
 	case MPOL_INTERLEAVE:
 		return interleave_nodes(pol);
 	case MPOL_PREFERRED:
@@ -805,13 +764,8 @@ int mpol_node_valid(int nid, struct vm_a
 	case MPOL_DEFAULT:
 	case MPOL_INTERLEAVE:
 		return 1;
-	case MPOL_BIND: {
-		struct zone **z;
-		for (z = pol->v.zonelist->zones; *z; z++)
-			if ((*z)->zone_pgdat->node_id == nid)
-				return 1;
-		return 0;
-	}
+	case MPOL_BIND:
+		return test_bit(nid, pol->v.zonelists->nodes);
 	default:
 		BUG();
 		return 0;
Index: 2.6.8-rc2-mm1/mm/page_alloc.c
===================================================================
--- 2.6.8-rc2-mm1.orig/mm/page_alloc.c	2004-08-02 04:37:03.000000000 -0700
+++ 2.6.8-rc2-mm1/mm/page_alloc.c	2004-08-02 14:37:19.000000000 -0700
@@ -1279,6 +1279,320 @@ static void __init build_zonelists(pg_da
 	}
 }
 
+/*
+ * Cost function for build_subset_zonelists().
+ */
+static int szcost(int cpu, int n1, int *node_load)
+{
+	int n2 = cpu_to_node(cpu);
+	int d = node_distance(n1, n2);
+	/*
+	 * node_load[]:
+	 *	Slight penalty to prior best nodes.
+	 * 	Spreads load across otherwise equivalent nodes.
+	 */
+	return MAX_NUMNODES * d + node_load[n1];
+}
+
+/*
+ * Kref release function for subset_zonelists.
+ */
+static void subset_zonelist_release(struct kref *kref)
+{
+	struct subset_zonelists *sz = container_of(kref, typeof(*sz), ref);
+	kfree(sz->zones);
+	kfree(sz->cg2z);
+	kfree(sz);
+}
+
+/*
+ * cpu_top_range is the smallest integer such that for all possible
+ * cpus c, c < cpu_top_range.  Useful in minimizing size of subset
+ * zonelists.
+ */
+static int cpu_top_range;
+
+/* For 2-D arrays of ints, each row of length GFP_ZONETYPES */
+typedef int (*gfp_array_t)[GFP_ZONETYPES];
+
+/*
+ * For each system zonelist, on each node's NODE_DATA, record whether
+ * that zonelist is a duplicate of the one just below it?
+ *
+ * Useful in building subset zonelists without wasted duplication
+ * of zonelists.  On nodes without all three of DMA, NORMAL and HIGH
+ * memory, some zonelists are just duplicates of others, not unique.
+ */
+enum dup_zl_flag_t {
+	dzl_unset,
+	dzl_unique,
+	dzl_duplicate
+} __attribute__ ((packed));
+
+static enum dup_zl_flag_t dup_zonelist_flag[MAX_NUMNODES][GFP_ZONETYPES];
+
+/*
+ * Set this flag non-zero once cpu_top_range and dup_zonelist_flag
+ * are initialized.
+ */
+static int subset_zonelists_initialized;
+
+/*
+ * The first task to get this semaphore is responsible for initializing
+ * cpu_top_range, dup_zonelist_flag.
+ */
+static DECLARE_MUTEX(subset_zonelist_init_sem);
+
+/*
+ * True iff two zonelists are identical.
+ */
+static int zonelist_same(int node, int gfp1, int gfp2)
+{
+	struct zonelist *nodelists = NODE_DATA(node)->node_zonelists;
+	struct zone **z1 = nodelists[gfp1].zones;
+	struct zone **z2 = nodelists[gfp2].zones;
+
+	return memcmp(z1, z2, sizeof(struct zonelist)) == 0;
+}
+
+/*
+ * The first time someone tries to build a subset_zonelist, we
+ * have a little init work to do: initialize cpu_top_range and
+ * dup_zonelist_flag[][].
+ */
+static void init_subset_zonelists(void)
+{
+	int c = 0, cpu;
+	int node, i;
+
+	down(&subset_zonelist_init_sem);
+	if (unlikely(subset_zonelists_initialized))
+		goto done;
+
+	for_each_cpu(cpu)
+		c = cpu;
+	cpu_top_range = c + 1;
+
+	for_each_online_node(node) {
+		for (i = 0; i < GFP_ZONETYPES; i++) {
+			if (i > 0 && zonelist_same(node, i - 1, i))
+				dup_zonelist_flag[node][i] = dzl_duplicate;
+			else
+				dup_zonelist_flag[node][i] = dzl_unique;
+		}
+	}
+
+	subset_zonelists_initialized = 1;
+done:
+	up(&subset_zonelist_init_sem);
+}
+
+/*
+ * Support for building the subset_zonelists described in mmzone.h.
+ */
+
+/*
+ * We need to know, for each <cpu, gfp> in the system, which subset
+ * zonelist to use if a task running on that cpu wants memory in
+ * that gfp.  This is the sz->cg2z field of struct subset_zonelists.
+ * Call it map [C].
+ *
+ * For each cpu, we determine on which node in the subset to get this
+ * zonelist by choosing the node in the subset closest to that cpu
+ * (see the function szcost(), above).  This produces cpu2node[].
+ * Call it map [A].
+ *
+ * And for each node in the subset, we record the starting index in
+ * sz->zones of its gfp's subset zonelists.  This produces ng2z[][].
+ * Call it map [B].
+ *
+ * The needed map [C] is then just the composition of maps [A] and [B].
+ *
+ * The steps are:
+ *    - Allocate and compute map [A].
+ *    - Allocate and compute map [B].
+ *    - Allocate and compute map [C] by composing [A] and [B].
+ *    - Free the temporary maps [A] and [B].
+ *
+ * The subset zonelists in sz->zones are allocated and filled in as
+ * part of doing map [B].  This takes two loops over all the unique
+ * system zonelists of each node in the subset.  Loop (B1) computes
+ * the length "zcnt" of sz->zones (just zones for nodes in our subset).
+ * Then we can allocate map [B] and sb->zones.  Loop (B2) computes map
+ * [B] and fills in sz->zones.
+ */
+
+/* map [A] - each cpu in the system to best node in subsets 'nodes' */
+static int *sz_allocate_map_A(void)
+{
+	int cpu2nodelen = sizeof(int) * cpu_top_range;
+	return kmalloc(cpu2nodelen, GFP_KERNEL);
+}
+
+static void sz_compute_map_A(int *cpu2node, const nodemask_t *np)
+{
+	int node_load[MAX_NUMNODES];
+	int c, n;
+
+	memset(node_load, 0, sizeof(node_load));
+	for_each_cpu(c) {
+		int bestnode = first_node(*np), bestcost = INT_MAX;
+		for_each_node_mask(n, *np) {
+		     	int thiscost = szcost(c, n, node_load);
+			if (thiscost < bestcost) {
+				bestnode = n;
+				bestcost = thiscost;
+			}
+		}
+		node_load[bestnode]++;
+		cpu2node[c] = bestnode;
+	}
+}
+
+/* loop (B1) - compute 'zcnt' - exact number zone pointers in sz->zones */
+static int sz_compute_B1(const nodemask_t *np)
+{
+	int z, n, gfp;
+	struct zone **zp;
+
+	z = 0;
+	for_each_node_mask(n, *np) {
+		struct zonelist *nodelists = NODE_DATA(n)->node_zonelists;
+		for (gfp = 0; gfp < GFP_ZONETYPES; gfp++) {
+			if (dup_zonelist_flag[n][gfp] == dzl_unique) {
+				for (zp = nodelists[gfp].zones; *zp; zp++) {
+					int nid = (*zp)->zone_pgdat->node_id;
+					if (node_isset(nid, *np))
+						z++;
+				}
+				z++;		/* NULL */
+			}
+		}
+	}
+	return z;
+}
+
+static struct zone **sz_allocate_zones(int zcnt)
+{
+	int zoneslen = sizeof(struct zone *) * zcnt;
+	return kmalloc(zoneslen, GFP_KERNEL);
+}
+
+/* map [B] - each node in subset to its zonelists in sz->zones */
+static gfp_array_t sz_allocate_map_B(void)
+{
+	int ng2zlen = sizeof(int) * MAX_NUMNODES * GFP_ZONETYPES;
+	return kmalloc(ng2zlen, GFP_KERNEL);
+}
+
+/* loop (B2) - setup both map [B] ng2z and zonelists sz->zones */
+static void sz_compute_B2(gfp_array_t ng2z, struct zone **zones,
+						const nodemask_t *np)
+{
+	int z, n, gfp, zactive = 0;
+	struct zone **zp;
+
+	z = 0;
+	for_each_node_mask(n, *np) {
+		struct zonelist *nodelists = NODE_DATA(n)->node_zonelists;
+		for (gfp = 0; gfp < GFP_ZONETYPES; gfp++) {
+			if (dup_zonelist_flag[n][gfp] == dzl_unique) {
+				zactive = z;
+				for (zp = nodelists[gfp].zones; *zp; zp++) {
+					int nid = (*zp)->zone_pgdat->node_id;
+					if (node_isset(nid, *np))
+						zones[z++] = *zp;
+				}
+				zones[z++] = NULL;
+			}
+			ng2z[n][gfp] = zactive;
+		}
+	}
+}
+
+/* map [C] - sz->cg2z maps <cpu, gfp> to index of its zonelist in sz->zones */
+static gfp_array_t sz_allocate_map_C(void)
+{
+	int cg2zlen = sizeof(int) * cpu_top_range * GFP_ZONETYPES;
+	return kmalloc(cg2zlen, GFP_KERNEL);
+}
+
+static void sz_compute_map_C(gfp_array_t cg2z, const int *cpu2node,
+					gfp_array_t ng2z)
+{
+	int c, gfp;
+
+	for_each_cpu(c)
+		for (gfp = 0; gfp < GFP_ZONETYPES; gfp++)
+			cg2z[c][gfp] = ng2z[cpu2node[c]][gfp];
+}
+
+/*
+ * Build a subset zonelist, that only allocates memory on the
+ * specified nodes, regardless of what cpu executes the request.
+ *
+ * Preserve the system wide zonelist node order when building
+ * these subset zonelists, and provide alternative zonelists
+ * for each possible cpu and gfp.
+ *
+ * Most of the detail work is done in the helper routines above,
+ * as described in the big comment above.
+ */
+struct subset_zonelists *build_subset_zonelists(const unsigned long *xnodes)
+{
+	nodemask_t nodes;
+	struct subset_zonelists *sz;
+	int *cpu2node;		/* map [A] */
+	gfp_array_t ng2z;	/* map [B] */
+	int zcnt;
+
+	if (!subset_zonelists_initialized)
+		init_subset_zonelists();
+
+	sz = kmalloc(sizeof(*sz), GFP_KERNEL);
+	if (sz == NULL)
+		goto err1;
+	kref_init(&sz->ref, subset_zonelist_release);
+	bitmap_copy(nodes_addr(nodes), xnodes, MAX_NUMNODES);
+	nodes_and(nodes, nodes, node_online_map);
+	bitmap_copy(sz->nodes, nodes_addr(nodes), MAX_NUMNODES);
+	if (nodes_equal(node_online_map, nodes)) {
+		/* Use system-wide NODE_DATA node_zonelists */
+		sz->zones = NULL;
+		sz->cg2z = NULL;
+		return sz;
+	}
+
+	if ((cpu2node = sz_allocate_map_A()) == NULL)
+		goto err2;
+	sz_compute_map_A(cpu2node, &nodes);
+	zcnt = sz_compute_B1(&nodes);
+	if ((ng2z = sz_allocate_map_B()) == NULL)
+		goto err3;
+	if ((sz->zones = sz_allocate_zones(zcnt)) == NULL)
+		goto err4;
+	sz_compute_B2(ng2z, sz->zones, &nodes);
+	if ((sz->cg2z = sz_allocate_map_C()) == NULL)
+		goto err5;
+	sz_compute_map_C(sz->cg2z, cpu2node, ng2z);
+
+	kfree(cpu2node);
+	kfree(ng2z);
+
+	return sz;
+
+err5:
+	kfree(sz->zones);
+err4:
+	kfree(ng2z);
+err3:
+	kfree(cpu2node);
+err2:
+	kfree(sz);
+err1:
+	return ERR_PTR(-ENOMEM);
+}
+
 #else	/* CONFIG_NUMA */
 
 static void __init build_zonelists(pg_data_t *pgdat)

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
