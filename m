Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281715AbRKQJOu>; Sat, 17 Nov 2001 04:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281720AbRKQJOi>; Sat, 17 Nov 2001 04:14:38 -0500
Received: from holomorphy.com ([216.36.33.161]:56969 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S281715AbRKQJOV>;
	Sat, 17 Nov 2001 04:14:21 -0500
Date: Sat, 17 Nov 2001 01:14:15 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC] tree-based bootmem
Message-ID: <20011117011415.B1180@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a repost including some corrections of a bootmem allocator that
tracks ranges explicitly, and uses segment trees to assist in searching
for available memory. Perhaps it is even a new version. Some prior
reports indicated mail headers were munged, preventing replies and some
people from seeing it at all.

The motivations for this work include:
(1) Several people expressing interest in having a different mechanism.
(2) Usefulness to myself in several instances.
(3) Handling very sparse or highly irregular address space layouts with
	less intervention by the caller.
(4) Insensitivity to range ordering or interleaving of nodes' memory.
(5) Memory conservation as a result of more precise allocation tracking.
(6) Time/space usage that does not grow with the size of memory.
(7) Graceful degradation under heavy memory reservation activity.

Critiques, testing results, and any commentary whatsoever are quite welcome.

Changelog:

(1) Rearranged #ifdef CONFIG_KERNEL_HACKING so that the freeing of the
	segment pool is not made conditional on it, only range reporting.
(2) reserve_bootmem() passed treap_node_t ** instead of treap_node_t *
	to start_segment_treap().
(3) Removed unused fields from bootmem_data_t.
(4) segment_tree_contains_point() and segment_tree_intersects() followed
	the wrong children during the search process.
(5) segment_complement() failed to detect the prefix removal and suffix
	removal cases properly.
(6) Adjusted comment preceding segment_complement() to match the order in
	which the cases occur.

Thanks to Robert Love for discovering (2). This patch tested on i386 and
IBM IA64 sparse memory machines.


Cheers,
Bill
-----------------
willir@us.ibm.com


diff -urN linux-2.4.15-pre5-virgin/mm/bootmem.c linux-2.4.15-pre5-bootmem/mm/bootmem.c
--- linux-2.4.15-pre5-virgin/mm/bootmem.c	Tue Sep 18 14:10:43 2001
+++ linux-2.4.15-pre5-bootmem/mm/bootmem.c	Fri Nov 16 19:38:09 2001
@@ -3,8 +3,9 @@
  *
  *  Copyright (C) 1999 Ingo Molnar
  *  Discontiguous memory support, Kanoj Sarcar, SGI, Nov 1999
+ *  Segment tree memory reservation system, William Irwin, IBM, Oct 2001
  *
- *  simple boot-time physical memory area allocator and
+ *  Simple boot-time physical memory area allocator and
  *  free memory collector. It's used to deal with reserved
  *  system memory and memory holes as well.
  */
@@ -17,40 +18,205 @@
 #include <linux/init.h>
 #include <linux/bootmem.h>
 #include <linux/mmzone.h>
-#include <asm/dma.h>
+#include <linux/segment_tree.h>
 
 /*
- * Access to this subsystem has to be serialized externally. (this is
- * true for the boot process anyway)
+ * Design notes:
+ *
+ * This design was arrived at by considering four principal concerns,
+ * beyond properly representing discontiguous memory machines:
+ *
+ * (1) Machines on which the physical address space is highly fragmented.
+ * (2) Machines where nodes' memory fragments may be interleaved.
+ * (3) Machines whose physical address space layouts are irregular.
+ * (4) Machines requiring heavy boot-time memory reservation activity.
+ *
+ * These design concerns led to an implementation which represented
+ * available physical memory explicitly in terms of intervals to save
+ * space and also one utilizing an efficient search structure. These
+ * design concerns may not be universally important; however, small
+ * benefits should be seen even on low-memory machines, or machines
+ * without significant boot-time memory reservation activity.
+ *
+ * Concern (3) is perhaps the principal concern. In this situation,
+ * there is very little prior knowledge of memory range to node
+ * mappings, so perhaps a large portion of the work the bootmem
+ * allocator is intended to do must be done "up front" when bitmaps
+ * associated with memory ranges are used to represent availability
+ * information. While it is possible to use bitmaps for that purpose,
+ * it is my belief that the reduced space overhead of the segment
+ * trees and the obliviousness of their storage management with
+ * respect to the address ranges they represent is advantageous.
+ *
+ * In order to motivate how (2) is addressed, the notion of
+ * "residency" is useful. When a memory range is associated with
+ * a node, only a certain portion of it is actually available.
+ * the ratio of available memory to the size of the memory range
+ * being tracked, sizeof(available memory)/sizeof(memory in map),
+ * is what I call the residency of the range. When the map of the
+ * available memory requires a contiguous range of memory that is
+ * a larger proportion of the range of memory being tracked than
+ * the residency of that range, then the algorithm can no longer
+ * properly function.
+ * So to address that, a representation has been chosen which does
+ * not grow with the size of the range of memory being represented.
+ * The residency requirements of the bitmap-based representation
+ * are 1/(8*sizeof(page)) on byte addressed machines. But the range
+ * set representation has no specific residency requirements.
+ * Segment pools need not be drawn from a contiguous range of memory
+ * larger than the combined size of a header for tracking all the
+ * segment pools and the size of a single range structure. Dynamic
+ * addition of segment pools is not implemented here yet.
+ */
+
+/*
+ * Access to this subsystem has to be serialized externally. (This is
+ * true for the boot process anyway.)
+ */
+
+/*
+ * NR_SEGMENTS is the number of line segment tree nodes held
+ * in the per-node segment pools.
+ *
+ * For the moment, this is a fixed size, because dynamically
+ * determining the number of segments per node would require
+ * a change of interface. On 32-bit machines with 4KB pages
+ * this is 170 distinct fragments of memory per page. It may
+ * be superior to move this definition to an architecture-
+ * specific file, but best to change the interface.
+ */
+#define NR_SEGMENTS (PAGE_SIZE/sizeof(segment_buf_t))
+
+/*
+ * Alignment has to be a power of 2 value.
+ * These macros abstract out common address calculations for alignments.
+ */
+#define RND_DN(x,n) ((x) & ~((n)-1))
+#define RND_UP(x,n) RND_DN((x) + (n) - 1, n)
+#define DIV_DN(x,n) (RND_DN(x,n) / (n))
+#define DIV_UP(x,n) (RND_UP(x,n) / (n))
+
+/*
+ * The highest and lowest page frame numbers on the system.
+ * These refer to physical addresses backed by memory regardless
+ * of runtime availability.
  */
 unsigned long max_low_pfn;
 unsigned long min_low_pfn;
 
-/* return the number of _pages_ that will be allocated for the boot bitmap */
-unsigned long __init bootmem_bootmap_pages (unsigned long pages)
+/*
+ * This is a poor choice of random seeds for deterministic
+ * behavior during debugging. Oddly enough it does not seem
+ * to damage the structure of the trees.
+ */
+static unsigned long __initdata random_seed = 1UL;
+
+/*
+ * Park-Miller random number generator, using Schrage's
+ * technique for overflow handling.
+ */
+static unsigned long __init rand(void)
+{
+	unsigned long a = 16807;
+	unsigned long q = 12773;
+	unsigned long r = 2386;
+	unsigned long k;
+
+	k = random_seed / q;
+	random_seed = a*(random_seed - k*q) - r*k;
+	return random_seed;
+}
+
+/*
+ * Initialize the segment pool, which occupies node_bootmem_map.
+ * This is the memory from which the tree nodes tracking available
+ * memory are allocated.
+ */
+static void __init segment_pool_init(bootmem_data_t *bdata)
+{
+	unsigned k;
+	segment_buf_t *segment_pool = (segment_buf_t *)bdata->node_bootmem_map;
+
+	for(k = 0; k < NR_SEGMENTS - 1; ++k)
+		segment_pool[k].next = &segment_pool[k+1];
+	segment_pool[NR_SEGMENTS-1].next = NULL;
+	bdata->free_segments = segment_pool;
+}
+
+/*
+ * Allocates a tree node from a node's segment pool, initializing the
+ * whole of the memory block to zeroes.
+ */
+static segment_tree_node_t * __init segment_alloc(bootmem_data_t *bdata)
+{
+	segment_tree_node_t *tmp = (segment_tree_node_t *)bdata->free_segments;
+
+	if(!bdata->free_segments)
+		return NULL;
+
+	bdata->free_segments = bdata->free_segments->next;
+	memset(tmp, 0, sizeof(segment_tree_node_t));
+	return tmp;
+}
+
+/*
+ * Convenience operation to insert a tree node into both
+ * of the segment trees associated with a node. The randomized
+ * priorities are used here.
+ */
+static void __init segment_insert(segment_tree_root_t *root,
+			segment_tree_node_t *node)
 {
-	unsigned long mapsize;
+	node->start.priority  = rand();
+	node->length.priority = rand();
+	treap_insert(&root->start_tree, &node->start);
+	treap_insert(&root->length_tree, &node->length);
+}
 
-	mapsize = (pages+7)/8;
-	mapsize = (mapsize + ~PAGE_MASK) & PAGE_MASK;
-	mapsize >>= PAGE_SHIFT;
+/*
+ * Returns a segment tree node to the node-local pool of available
+ * tree nodes.
+ */
+static void __init segment_free(bootmem_data_t *bdata,
+						segment_tree_node_t *node)
+{
+	segment_buf_t *tmp;
 
-	return mapsize;
+	if(!node)
+		return;
+
+	tmp = (segment_buf_t *)node;
+	tmp->next = bdata->free_segments;
+	bdata->free_segments = tmp;
+}
+
+/*
+ * Return the number of _pages_ that will be allocated for the bootmem
+ * segment pool. Its sole purpose is to warn callers of the bootmem
+ * interface in advance of its size, so that a suitably large range of
+ * physical memory may be found to hold it.
+ */
+unsigned long __init bootmem_bootmap_pages (unsigned long pages)
+{
+	return DIV_UP(NR_SEGMENTS*sizeof(segment_buf_t),PAGE_SIZE);
 }
 
 /*
  * Called once to set up the allocator itself.
+ * Its responsibilities are manipulate the bootmem_data_t within
+ * a node, initializing its address range and node-local segment
+ * pool fields. It is supposed to calculate the amount of memory
+ * required for the node_bootmem_map, but this is not possible
+ * without a change of interface.
  */
 static unsigned long __init init_bootmem_core (pg_data_t *pgdat,
 	unsigned long mapstart, unsigned long start, unsigned long end)
 {
 	bootmem_data_t *bdata = pgdat->bdata;
-	unsigned long mapsize = ((end - start)+7)/8;
 
 	pgdat->node_next = pgdat_list;
 	pgdat_list = pgdat;
 
-	mapsize = (mapsize + (sizeof(long) - 1UL)) & ~(sizeof(long) - 1UL);
 	bdata->node_bootmem_map = phys_to_virt(mapstart << PAGE_SHIFT);
 	bdata->node_boot_start = (start << PAGE_SHIFT);
 	bdata->node_low_pfn = end;
@@ -59,293 +225,695 @@
 	 * Initially all pages are reserved - setup_arch() has to
 	 * register free RAM areas explicitly.
 	 */
-	memset(bdata->node_bootmem_map, 0xff, mapsize);
+	bdata->segment_tree.start_tree = NULL;
+	bdata->segment_tree.length_tree = NULL;
+	segment_pool_init(bdata);
 
-	return mapsize;
+	return RND_UP(NR_SEGMENTS*sizeof(segment_buf_t), PAGE_SIZE);
 }
 
 /*
- * Marks a particular physical memory range as unallocatable. Usable RAM
- * might be used for boot-time allocations - or it might get added
- * to the free page pool later on.
+ * reserve_bootmem_core marks a particular segment of physical
+ * memory as unavailable. Available memory might be used for boot-time
+ * allocations, or it might be made available again later on.
+ *
+ * Its behavior is to mark the specified range of physical memory
+ * as unavailable, irrespective of alignment constraints (in contrast
+ * to prior incarnations, which page-aligned the starting and ending
+ * addresses of the unavailable interval of memory).
  */
-static void __init reserve_bootmem_core(bootmem_data_t *bdata, unsigned long addr, unsigned long size)
+static void __init reserve_bootmem_core(bootmem_data_t *bdata,
+					unsigned long addr, unsigned long size)
 {
-	unsigned long i;
+	unsigned long start;
+	unsigned long end;
+	segment_tree_node_t split_segment, segment;
+	segment_tree_node_t reserved_left, reserved_right;
+	segment_tree_node_t *multiple_left, *multiple_right;
+	treap_node_t *tmp, *parent, *intersect;
+
 	/*
-	 * round up, partially reserved pages are considered
-	 * fully reserved.
+	 * Round up, partially reserved pages are considered fully reserved.
 	 */
-	unsigned long sidx = (addr - bdata->node_boot_start)/PAGE_SIZE;
-	unsigned long eidx = (addr + size - bdata->node_boot_start + 
-							PAGE_SIZE-1)/PAGE_SIZE;
-	unsigned long end = (addr + size + PAGE_SIZE-1)/PAGE_SIZE;
+	start = addr;
+	end   = start + size - 1;
 
-	if (!size) BUG();
+	segment_set_endpoints(&segment, start, end);
 
-	if (sidx < 0)
-		BUG();
-	if (eidx < 0)
-		BUG();
-	if (sidx >= eidx)
-		BUG();
-	if ((addr >> PAGE_SHIFT) >= bdata->node_low_pfn)
-		BUG();
-	if (end > bdata->node_low_pfn)
-		BUG();
-	for (i = sidx; i < eidx; i++)
-		if (test_and_set_bit(i, bdata->node_bootmem_map))
-			printk("hm, page %08lx reserved twice.\n", i*PAGE_SIZE);
+	segment_all_intersect(&bdata->segment_tree.start_tree,
+				start, end, &intersect);
+
+	/*
+	 * If the set of intersecting intervals is empty, report
+	 * the entire interval as multiply-reserved. Then the
+	 * condition of the loop ensures a proper exit will follow.
+	 */
+	if(!intersect)
+		printk(KERN_WARNING "the interval [%lu, %lu] "
+					"was multiply reserved (!intersect)\n",
+					segment_start(&segment),
+					segment_end(&segment));
+
+	/*
+	 * For error-checking, this must be called only for a single
+	 * node per reservation. The next step in strict error checking
+	 * would be to track the fragments of the interval to reserve
+	 * that do not lie within any available interval and then report
+	 * them as multiply-reserved.
+	 *
+	 * Unfortunately, error checking that way appears to require
+	 * unbounded allocations in order to maintain the set of multiply
+	 * reserved intervals, so it is not entirely robust.
+	 *
+	 * For the moment, a cruder form of error checking is done:
+	 * if the available interval does not contain the interval
+	 * to be reserved, then the complement of the reserved
+	 * interval with respect to the available interval is reported
+	 * as multiply reserved. This may multiply report multiply
+	 * reserved ranges, but it is still less verbose than the
+	 * mechanism used in the bitmap-based allocator.
+	 */
+
+	/*
+	 * Destructive post-order traversal of the set of
+	 * intersecting intervals.
+	 */
+	tmp = intersect;
+	treap_find_leftmost_leaf(tmp);
+	while(tmp) {
+		segment_tree_node_t *fragment = &split_segment;
+		segment_tree_node_t *avail = start_segment_treap(tmp);
+		treap_find_parent_and_remove_child(tmp, parent);
+
+		multiple_left  = &reserved_left;
+		multiple_right = &reserved_right;
+
+		if(!segment_contains(avail, &segment)) {
+			segment_set_endpoints(multiple_left,
+					segment_start(&segment),
+					segment_end(&segment));
+			segment_complement(&multiple_left, avail,
+							&multiple_right);
+			if(multiple_left)
+				printk(KERN_WARNING "the interval [%lu, %lu] "
+					" was multiply reserved (left)\n",
+					segment_start(multiple_left),
+					segment_end(multiple_left));
+			if(multiple_right)
+				printk(KERN_WARNING "the interval [%lu, %lu] "
+					" was multiply reserved (right)\n",
+					segment_start(multiple_right),
+					segment_end(multiple_right));
+		}
+
+		if(!treap_root_delete(segment_length_link(tmp)))
+			treap_root_delete(&bdata->segment_tree.length_tree);
+
+		segment_complement(&avail, &segment, &fragment);
+
+		if(!avail)
+			segment_free(bdata, start_segment_treap(tmp));
+		else
+			segment_insert(&bdata->segment_tree, avail);
+
+		if(fragment) {
+
+			avail = segment_alloc(bdata);
+
+			if(!avail)
+				BUG();
+
+			segment_set_endpoints(avail, segment_start(fragment),
+						segment_end(fragment));
+			segment_insert(&bdata->segment_tree, avail);
+		}
+
+		tmp = parent;
+		treap_find_leftmost_leaf(tmp);
+	}
 }
 
-static void __init free_bootmem_core(bootmem_data_t *bdata, unsigned long addr, unsigned long size)
+/*
+ * free_bootmem_core marks a particular segment of the physical
+ * address space as available. Its semantics are to make the range
+ * of addresses available, irrespective of alignment constraints.
+ */
+static void __init free_bootmem_core(bootmem_data_t *bdata, unsigned long addr,
+							unsigned long size)
 {
-	unsigned long i;
-	unsigned long start;
+	unsigned long start, end;
+	segment_tree_node_t segment, *avail, intersection, freed;
+	treap_node_t *tmp, *parent, *intersect = NULL;
+
+	start = addr;
+	end = start + size - 1;
+
+	segment_set_endpoints(&segment, start, end);
+	segment_set_endpoints(&freed, start, end);
+
+	segment_all_intersect(&bdata->segment_tree.start_tree,
+			start ? start - 1 : start, end + 1, &intersect);
+
 	/*
-	 * round down end of usable mem, partially free pages are
-	 * considered reserved.
+	 * Error checking here is simple:
+	 * If the available segment and the segment being freed truly
+	 * intersect, their intersection should be reported as multiply
+	 * made available.
 	 */
-	unsigned long sidx;
-	unsigned long eidx = (addr + size - bdata->node_boot_start)/PAGE_SIZE;
-	unsigned long end = (addr + size)/PAGE_SIZE;
-
-	if (!size) BUG();
-	if (end > bdata->node_low_pfn)
-		BUG();
 
 	/*
-	 * Round up the beginning of the address.
+	 * Destructive post-order traversal of the set of intervals
+	 * intersecting with the freed interval expanded by one. This
+	 * provides for merging of available intervals, as all the
+	 * adjacent intervals are united with newly available interval.
 	 */
-	start = (addr + PAGE_SIZE-1) / PAGE_SIZE;
-	sidx = start - (bdata->node_boot_start/PAGE_SIZE);
+	tmp = intersect;
+	treap_find_leftmost_leaf(tmp);
+	while(tmp) {
+
+		avail = start_segment_treap(tmp);
+		treap_find_parent_and_remove_child(tmp, parent);
+
+		if(segment_intersect(&freed, avail)) {
+			segment_intersection(&intersection, &freed, avail);
+			printk(KERN_WARNING "the interval [%lu, %lu] "
+				"was multiply made available\n",
+				segment_start(&intersection),
+				segment_end(&intersection));
+		}
 
-	for (i = sidx; i < eidx; i++) {
-		if (!test_and_clear_bit(i, bdata->node_bootmem_map))
-			BUG();
+		segment_unite(&segment, avail);
+
+		if(!treap_root_delete(segment_length_link(tmp)))
+			treap_root_delete(&bdata->segment_tree.length_tree);
+
+		segment_free(bdata, avail);
+
+		tmp = parent;
+		treap_find_leftmost_leaf(tmp);
 	}
+
+	avail = segment_alloc(bdata);
+	if(!avail)
+		BUG();
+
+	segment_set_endpoints(avail, segment_start(&segment),
+					segment_end(&segment));
+
+	segment_insert(&bdata->segment_tree, avail);
 }
 
 /*
- * We 'merge' subsequent allocations to save space. We might 'lose'
- * some fraction of a page if allocations cannot be satisfied due to
- * size constraints on boxes where there is physical RAM space
- * fragmentation - in these cases * (mostly large memory boxes) this
- * is not a problem.
+ * The terms are borrowed from linear programming.
+ * A feasible line segment is one which contains a subinterval
+ * aligned on the appropriate boundary of sufficient length.
+ *
+ * The objective function is the magnitude of the least residue
+ * of the smallest aligned address within the subinterval minus the goal
+ * mod the largest page frame number. A conditional is used instead of
+ * of remainder so as to avoid the overhead of division.
  *
- * On low memory boxes we get it right in 100% of the cases.
+ * The idea here is to iterate over the feasible set and minimize
+ * the objective function (by exhaustive search). The search space
+ * is "thinned" prior to the iteration by using the heuristic that
+ * the interval must be at least of the length requested, though
+ * that is not sufficient because of alignment constraints.
  */
 
+#define FEASIBLE(seg, len, align) \
+	((RND_UP(segment_start(seg), align) + (len) - 1) <= segment_end(seg))
+
+#define STARTS_BELOW(seg,goal,align,len) \
+	(RND_UP(segment_start(seg), align) <= (goal))
+
+#define ENDS_ABOVE(seg, goal, align, len) \
+	(segment_end(seg) > ((goal) + (len)))
+
+#define GOAL_WITHIN(seg,goal,align,len) \
+	(STARTS_BELOW(seg,goal,align,len) && ENDS_ABOVE(seg,goal,align,len))
+
+#define GOAL_ABOVE(seg, goal, align) \
+	((goal) > segment_end(seg))
+
+#define DISTANCE_BELOW(seg, goal, align) \
+	(segment_start(seg) - (goal))
+
+#define DISTANCE_ABOVE(seg, goal, align) \
+	(((ULONG_MAX - (goal)) + 1) + segment_start(seg))
+
+#define OBJECTIVE(seg, goal, align, len)				\
+(	GOAL_WITHIN(seg,goal,align,len) 				\
+	? 0UL								\
+	: (								\
+		GOAL_ABOVE(seg, goal, align)				\
+		? DISTANCE_ABOVE(seg, goal, align)			\
+		: DISTANCE_BELOW(seg, goal, align)			\
+	)								\
+)
+
+#define UNVISITED	0
+#define LEFT_SEARCHED	1
+#define RIGHT_SEARCHED	2
+#define VISITED		3
+
 /*
- * alignment has to be a power of 2 value.
+ * __alloc_bootmem_core attempts to satisfy reservation requests
+ * of a certain size with alignment constraints, so that the beginning
+ * of the allocated line segment is as near as possible to the goal
+ * in the following sense:
+ *
+ * The beginning of the allocated line segment is either the lowest
+ * possible address above the goal, or the lowest possible address
+ * overall. This actually has a simple notion of distance, namely
+ * (goal - start) % (MAX_ADDR + 1). The OBJECTIVE macros measures
+ * this distance, albeit with some arithmetic complications.
+ *
+ * The algorithm proceeds as follows:
+ * (1) Divide the set of available intervals into those which are
+ *     long enough and those which are not long enough, ignoring
+ *     alignment constraints.
+ * (2) Perform depth-first search over the tree of supposedly
+ *     long enough intervals for the best possible interval.
+ *
+ * The FEASIBLE macro is used to determine whether it is truly
+ * possible to place an aligned interval of sufficient length
+ * within the interval, and it is needed because the true length
+ * of the interval is not sufficient to determine that, and
+ * because it is not truly possible to subdivide the set of available
+ * intervals according to this criterion with pure tree operations.
+ *
+ * As address ranges are the granularity of available interval tracking,
+ * this should provide optimal merging behavior.
  */
+
 static void * __init __alloc_bootmem_core (bootmem_data_t *bdata, 
 	unsigned long size, unsigned long align, unsigned long goal)
 {
-	unsigned long i, start = 0;
+	unsigned long length;
+	segment_tree_node_t left_half, right_half, reserved, *left, *right;
+	segment_tree_node_t *optimum, *node;
+	treap_node_t *tmp, *infeasible, *feasible;
 	void *ret;
-	unsigned long offset, remaining_size;
-	unsigned long areasize, preferred, incr;
-	unsigned long eidx = bdata->node_low_pfn - (bdata->node_boot_start >>
-							PAGE_SHIFT);
 
-	if (!size) BUG();
+	feasible = infeasible = NULL;
+
+	if(!align)
+		align = 1;
 
-	if (align & (align-1))
+	length = size;
+	if(!length)
 		BUG();
 
-	/*
-	 * We try to allocate bootmem pages above 'goal'
-	 * first, then we try to allocate lower pages.
-	 */
-	if (goal && (goal >= bdata->node_boot_start) && 
-			((goal >> PAGE_SHIFT) < bdata->node_low_pfn)) {
-		preferred = goal - bdata->node_boot_start;
-	} else
-		preferred = 0;
-
-	preferred = ((preferred + align - 1) & ~(align - 1)) >> PAGE_SHIFT;
-	areasize = (size+PAGE_SIZE-1)/PAGE_SIZE;
-	incr = align >> PAGE_SHIFT ? : 1;
-
-restart_scan:
-	for (i = preferred; i < eidx; i += incr) {
-		unsigned long j;
-		if (test_bit(i, bdata->node_bootmem_map))
+	treap_split(&bdata->segment_tree.length_tree, length, &infeasible,
+								&feasible);
+	optimum = NULL;
+
+	tmp = feasible;
+	while(tmp) {
+
+		if(tmp->marker == UNVISITED) {
+			if(tmp->left) {
+				tmp->marker = LEFT_SEARCHED;
+				tmp = tmp->left;
+				continue;
+			} else if(tmp->right) {
+				tmp->marker = RIGHT_SEARCHED;
+				tmp = tmp->right;
+				continue;
+			} else
+				tmp->marker = VISITED;
+		} else if(tmp->marker == LEFT_SEARCHED) {
+			if(tmp->right) {
+				tmp->marker = RIGHT_SEARCHED;
+				tmp = tmp->right;
+				continue;
+			} else
+				tmp->marker = VISITED;
+		} else if(tmp->marker == RIGHT_SEARCHED)
+			tmp->marker = VISITED;
+		else if(tmp->marker == VISITED) {
+			tmp->marker = UNVISITED;
+			tmp = tmp->parent;
 			continue;
-		for (j = i + 1; j < i + areasize; ++j) {
-			if (j >= eidx)
-				goto fail_block;
-			if (test_bit (j, bdata->node_bootmem_map))
-				goto fail_block;
-		}
-		start = i;
-		goto found;
-	fail_block:;
+		} else
+			BUG();
+
+		if(!tmp)
+			break;
+
+		node = length_segment_treap(tmp);
+
+		if(!optimum && FEASIBLE(node, length, align))
+
+			optimum = node;
+
+		else if(FEASIBLE(node, length, align)
+			&& (OBJECTIVE(node, goal, align, length)
+				< OBJECTIVE(optimum, goal, align, length)))
+
+			optimum = node;
+
 	}
-	if (preferred) {
-		preferred = 0;
-		goto restart_scan;
+
+	/*
+	 * Restore the set of available intervals keyed by length,
+	 * taking into account the need to remove the optimum from
+	 * the set if it has been determined.
+	 */
+	if(!optimum) {
+		treap_join(&bdata->segment_tree.length_tree, &feasible,
+								&infeasible);
+		return NULL;
 	}
-	return NULL;
-found:
-	if (start >= eidx)
-		BUG();
+
+	if(!treap_root_delete(treap_node_link(&optimum->start)))
+		treap_root_delete(&bdata->segment_tree.start_tree);
+
+	if(!treap_root_delete(treap_node_link(&optimum->length)))
+		treap_root_delete(&feasible);
+
+	treap_join(&bdata->segment_tree.length_tree, &infeasible, &feasible);
 
 	/*
-	 * Is the next page of the previous allocation-end the start
-	 * of this allocation's buffer? If yes then we can 'merge'
-	 * the previous partial page with this allocation.
-	 */
-	if (align <= PAGE_SIZE
-	    && bdata->last_offset && bdata->last_pos+1 == start) {
-		offset = (bdata->last_offset+align-1) & ~(align-1);
-		if (offset > PAGE_SIZE)
+	 * Now the iteration has converged to the optimal feasible interval.
+	 * Within that interval we must now choose a subinterval
+	 * satisfying the alignment constraints and do the appropriate
+	 * splitting of the interval from which it was drawn.
+	 */
+
+	segment_set_endpoints(&reserved, goal, goal + length - 1);
+
+	if(!segment_contains(optimum, &reserved))
+		segment_set_endpoints(&reserved,
+				RND_UP(segment_start(optimum), align),
+				RND_UP(segment_start(optimum),align)+length-1);
+
+	segment_set_endpoints(&left_half, segment_start(optimum),
+					segment_end(optimum));
+
+	left = &left_half;
+	right = &right_half;
+	segment_complement(&left, &reserved, &right);
+
+	if(!left && !right)
+		segment_free(bdata, optimum);
+
+	if(left) {
+		segment_set_endpoints(optimum, segment_start(left),
+						segment_end(left));
+		segment_insert(&bdata->segment_tree, optimum);
+	}
+
+	if(right) {
+		segment_tree_node_t *segment = segment_alloc(bdata);
+		if(!segment)
 			BUG();
-		remaining_size = PAGE_SIZE-offset;
-		if (size < remaining_size) {
-			areasize = 0;
-			// last_pos unchanged
-			bdata->last_offset = offset+size;
-			ret = phys_to_virt(bdata->last_pos*PAGE_SIZE + offset +
-						bdata->node_boot_start);
-		} else {
-			remaining_size = size - remaining_size;
-			areasize = (remaining_size+PAGE_SIZE-1)/PAGE_SIZE;
-			ret = phys_to_virt(bdata->last_pos*PAGE_SIZE + offset +
-						bdata->node_boot_start);
-			bdata->last_pos = start+areasize-1;
-			bdata->last_offset = remaining_size;
-		}
-		bdata->last_offset &= ~PAGE_MASK;
-	} else {
-		bdata->last_pos = start + areasize - 1;
-		bdata->last_offset = size & ~PAGE_MASK;
-		ret = phys_to_virt(start * PAGE_SIZE + bdata->node_boot_start);
+		segment_set_endpoints(segment, segment_start(right),
+						segment_end(right));
+		segment_insert(&bdata->segment_tree, segment);
 	}
+
 	/*
-	 * Reserve the area now:
+	 * Convert the physical address to a kernel virtual address,
+	 * zero out the memory within the interval, and return it.
 	 */
-	for (i = start; i < start+areasize; i++)
-		if (test_and_set_bit(i, bdata->node_bootmem_map))
-			BUG();
+	ret = (void *)(phys_to_virt(segment_start(&reserved)));
 	memset(ret, 0, size);
+
 	return ret;
 }
 
+/*
+ * free_all_bootmem_core's responsibilities are to initialize the
+ * node_mem_map array of struct page with the availability information
+ * regarding physical memory, and to make available the memory the
+ * bootmem allocator itself used for tracking available physical memory.
+ * Here the prior behavior with respect to page alignment is emulated
+ * by reducing the granularity of the address ranges to page frames,
+ * using the conservative approximation of the largest page-aligned
+ * interval lying within the interval seen to be available, or making
+ * no memory available if the interval is smaller than a page in length.
+ */
 static unsigned long __init free_all_bootmem_core(pg_data_t *pgdat)
 {
-	struct page *page = pgdat->node_mem_map;
-	bootmem_data_t *bdata = pgdat->bdata;
-	unsigned long i, count, total = 0;
-	unsigned long idx;
+	unsigned long total = 0UL, mapstart, start, end;
+	unsigned long node_start = pgdat->bdata->node_boot_start >> PAGE_SHIFT;
+	struct page *page;
+	treap_node_t *parent, *tmp;
 
-	if (!bdata->node_bootmem_map) BUG();
+	mapstart = virt_to_phys(pgdat->bdata->node_bootmem_map);
 
-	count = 0;
-	idx = bdata->node_low_pfn - (bdata->node_boot_start >> PAGE_SHIFT);
-	for (i = 0; i < idx; i++, page++) {
-		if (!test_bit(i, bdata->node_bootmem_map)) {
-			count++;
-			ClearPageReserved(page);
-			set_page_count(page, 1);
-			__free_page(page);
-		}
-	}
-	total += count;
+#ifdef CONFIG_KERNEL_HACKING
+
+	printk("Available physical memory:\n");
+
+#endif /* CONFIG_KERNEL_HACKING */
+
+	free_bootmem_core(pgdat->bdata, mapstart,
+			RND_UP(NR_SEGMENTS*sizeof(segment_buf_t), PAGE_SIZE));
 
 	/*
-	 * Now free the allocator bitmap itself, it's not
-	 * needed anymore:
+	 * Destructive post-order traversal of the length tree.
+	 * The tree is never used again, so no attempt is made
+	 * to restore it to working order.
 	 */
-	page = virt_to_page(bdata->node_bootmem_map);
-	count = 0;
-	for (i = 0; i < ((bdata->node_low_pfn-(bdata->node_boot_start >> PAGE_SHIFT))/8 + PAGE_SIZE-1)/PAGE_SIZE; i++,page++) {
-		count++;
-		ClearPageReserved(page);
-		set_page_count(page, 1);
-		__free_page(page);
+	tmp = pgdat->bdata->segment_tree.length_tree;
+	treap_find_leftmost_leaf(tmp);
+	while(tmp) {
+		segment_tree_node_t *segment = length_segment_treap(tmp);
+
+		/*
+		 * This calculation differs from that in prior
+		 * incarnations in this subsystem, so I describe it
+		 * in passing detail here.
+		 *
+		 *******************************************************
+		 *
+		 * We have start so that start is the least pfn with
+		 *
+		 * PAGE_SIZE * start >= segment_start(segment)
+		 *
+		 * so after division and ceiling:
+		 *
+		 * start = DIV_UP(segment_start(segment), PAGE_SIZE)
+		 *
+		 *******************************************************
+		 *
+		 * Now the last pfn is the greatest pfn such that
+		 *
+		 * PAGE_SIZE * last + PAGE_SIZE - 1 <=  segment_end(segment)
+		 *
+		 *   -or-
+		 *
+		 * PAGE_SIZE * (last + 1) <= segment_end(segment) + 1
+		 *
+		 * giving us after division and flooring:
+		 *
+		 * last + 1 = DIV_DN(segment_end(segment) + 1, PAGE_SIZE)
+		 *
+		 * or using end as a -strict- upper bound (i.e. end > pfn),
+		 * we have
+		 *
+		 * end = DIV_DN(segment_end(segment) + 1, PAGE_SIZE)
+		 *
+		 */
+
+		start =  DIV_UP(segment_start(segment),   PAGE_SIZE);
+		end   =  DIV_DN(segment_end(segment) + 1, PAGE_SIZE);
+
+#ifdef CONFIG_KERNEL_HACKING
+
+		if(start < end)
+			printk("available segment: [%lu,%lu]\n",
+				start * PAGE_SIZE,
+				end   * PAGE_SIZE - 1);
+
+#endif /* CONFIG_KERNEL_HACKING */
+
+		for(	page  =  pgdat->node_mem_map + (start - node_start);
+			page  <  pgdat->node_mem_map + (end   - node_start);
+			++page) {
+
+                		ClearPageReserved(page);
+                		set_page_count(page, 1);
+                		__free_page(page);
+		}
+
+		/*
+		 * In most calculations in this file, closed intervals
+		 * are considered. In this instance, a half-open interval
+		 * is being considered, and so the usual end - start + 1
+		 * calculation does not apply.
+		 */
+		if(start < end)
+			total += end - start;
+
+		treap_find_parent_and_remove_child(tmp, parent);
+		tmp = parent;
+		treap_find_leftmost_leaf(tmp);
 	}
-	total += count;
-	bdata->node_bootmem_map = NULL;
 
 	return total;
 }
 
-unsigned long __init init_bootmem_node (pg_data_t *pgdat, unsigned long freepfn, unsigned long startpfn, unsigned long endpfn)
+/*
+ * Wrappers around the core routines so that they operate on the
+ * per-node memory structures (pg_data_t *pgdat).
+ */
+unsigned long __init init_bootmem_node (pg_data_t *pgdat,
+					unsigned long freepfn,
+					unsigned long startpfn,
+					unsigned long endpfn)
 {
-	return(init_bootmem_core(pgdat, freepfn, startpfn, endpfn));
+	return init_bootmem_core(pgdat, freepfn, startpfn, endpfn);
 }
 
-void __init reserve_bootmem_node (pg_data_t *pgdat, unsigned long physaddr, unsigned long size)
+void __init reserve_bootmem_node (pg_data_t *pgdat, unsigned long physaddr,
+							unsigned long size)
 {
 	reserve_bootmem_core(pgdat->bdata, physaddr, size);
 }
 
-void __init free_bootmem_node (pg_data_t *pgdat, unsigned long physaddr, unsigned long size)
+void * __init __alloc_bootmem_node (pg_data_t *pgdat, unsigned long size,
+					unsigned long align, unsigned long goal)
+{
+	void *ptr;
+
+	ptr = __alloc_bootmem_core(pgdat->bdata, size, align, goal);
+	if(ptr)
+		return ptr;
+
+	printk(KERN_ALERT "bootmem alloc of %lu bytes failed!\n", size);
+	panic("Out of memory");
+	return NULL;
+}
+
+void __init free_bootmem_node (pg_data_t *pgdat, unsigned long physaddr,
+							unsigned long size)
 {
-	return(free_bootmem_core(pgdat->bdata, physaddr, size));
+	free_bootmem_core(pgdat->bdata, physaddr, size);
 }
 
 unsigned long __init free_all_bootmem_node (pg_data_t *pgdat)
 {
-	return(free_all_bootmem_core(pgdat));
+	return free_all_bootmem_core(pgdat);
 }
 
+/*
+ * Non-node-aware wrappers for the core routines. The per-node
+ * structures are hidden by using the global variable contig_page_data.
+ */
 unsigned long __init init_bootmem (unsigned long start, unsigned long pages)
 {
 	max_low_pfn = pages;
 	min_low_pfn = start;
-	return(init_bootmem_core(&contig_page_data, start, 0, pages));
+	return init_bootmem_core(&contig_page_data, start, 0, pages);
 }
 
-void __init reserve_bootmem (unsigned long addr, unsigned long size)
+/*
+ * In multinode configurations it is not desirable to make memory
+ * available without information about the node assignment of the
+ * memory range, so even though reserve_bootmem() may operate
+ * without node information this cannot.
+ *
+ * This apparent inconsistency in the interface actually makes
+ * some sense, as when presented with irregular node to memory range
+ * assignments in firmware tables, the original request to make memory
+ * available will be aware of its node assignment. But an outstanding
+ * issue is that a non-node-aware memory reservation request (via
+ * alloc_bootmem()) will not know to which node to return the memory.
+ *
+ * Resolving that issue would involve tracking dynamic allocations
+ * separately from assertions regarding the presence of physical
+ * memory, which is feasible given a change of interface, or perhaps a
+ * separate tree in each node for memory reserved by dynamic allocations.
+ */
+void __init free_bootmem (unsigned long addr, unsigned long size)
 {
-	reserve_bootmem_core(contig_page_data.bdata, addr, size);
+	free_bootmem_core(contig_page_data.bdata, addr, size);
 }
 
-void __init free_bootmem (unsigned long addr, unsigned long size)
+/*
+ * reserve_bootmem operates without node information, yet is node
+ * aware. In situations where it may not be clear to where a given
+ * physical memory range is assigned this performs the task of
+ * searching the nodes on behalf of the caller.
+ */
+void __init reserve_bootmem (unsigned long addr, unsigned long size)
 {
-	return(free_bootmem_core(contig_page_data.bdata, addr, size));
+	unsigned long start, end;
+	unsigned in_any_node = 0;
+	segment_tree_node_t segment, *tree;
+	pg_data_t *pgdat = pgdat_list;
+
+	start = addr;
+	end   = start + size - 1;
+
+	segment_set_endpoints(&segment, start, end);
+
+	/*
+	 * For error checking, this must determine the node(s) within
+	 * which an interval to be reserved lies. Otherwise, once the
+	 * error checking is in place, the memory will be reported as
+	 * multiply-reserved on those nodes not containing the memory.
+	 */
+	while(pgdat) {
+		unsigned in_node;
+
+		tree = start_segment_treap(pgdat->bdata->segment_tree.start_tree);
+		in_node = segment_tree_intersects(tree, &segment);
+		in_any_node |= in_node;
+
+		if(in_node)
+			reserve_bootmem_node(pgdat, addr, size);
+
+		pgdat = pgdat->node_next;
+	}
+	if(!in_any_node)
+		printk(KERN_WARNING "the interval [%lu, %lu] "
+			"was multiply reserved\n",
+			segment_start(&segment),
+			segment_end(&segment));
 }
 
+/*
+ * free_all_bootmem is now a convenience function, and iterates over
+ * all the nodes, performing free_all_bootmem_core.
+ */
 unsigned long __init free_all_bootmem (void)
 {
-	return(free_all_bootmem_core(&contig_page_data));
+	pg_data_t *pgdat = pgdat_list;
+	unsigned long total = 0UL;
+
+	while(pgdat) {
+		total += free_all_bootmem_core(pgdat);
+		pgdat =  pgdat->node_next;
+	}
+
+	return total;
 }
 
-void * __init __alloc_bootmem (unsigned long size, unsigned long align, unsigned long goal)
+/*
+ * __alloc_bootmem performs a search over all nodes in order to satisfy
+ * an allocation request, for when it is unimportant from which node
+ * the memory used to satisfy an allocation is drawn.
+ */
+void * __init __alloc_bootmem (unsigned long size, unsigned long align,
+							unsigned long goal)
 {
 	pg_data_t *pgdat = pgdat_list;
 	void *ptr;
 
 	while (pgdat) {
-		if ((ptr = __alloc_bootmem_core(pgdat->bdata, size,
-						align, goal)))
-			return(ptr);
-		pgdat = pgdat->node_next;
-	}
-	/*
-	 * Whoops, we cannot satisfy the allocation request.
-	 */
-	printk(KERN_ALERT "bootmem alloc of %lu bytes failed!\n", size);
-	panic("Out of memory");
-	return NULL;
-}
+		ptr = __alloc_bootmem_core(pgdat->bdata, size, align, goal);
 
-void * __init __alloc_bootmem_node (pg_data_t *pgdat, unsigned long size, unsigned long align, unsigned long goal)
-{
-	void *ptr;
+		if(ptr)
+			return ptr;
 
-	ptr = __alloc_bootmem_core(pgdat->bdata, size, align, goal);
-	if (ptr)
-		return (ptr);
+		pgdat = pgdat->node_next;
+	}
 
-	/*
-	 * Whoops, we cannot satisfy the allocation request.
-	 */
 	printk(KERN_ALERT "bootmem alloc of %lu bytes failed!\n", size);
 	panic("Out of memory");
 	return NULL;
 }
-
diff -urN linux-2.4.15-pre5-virgin/include/linux/bootmem.h linux-2.4.15-pre5-bootmem/include/linux/bootmem.h
--- linux-2.4.15-pre5-virgin/include/linux/bootmem.h	Mon Nov  5 12:43:18 2001
+++ linux-2.4.15-pre5-bootmem/include/linux/bootmem.h	Fri Nov 16 19:38:31 2001
@@ -1,5 +1,6 @@
 /*
  * Discontiguous memory support, Kanoj Sarcar, SGI, Nov 1999
+ * Segment tree-based memory reservation system, William Irwin, IBM, Oct 2001
  */
 #ifndef _LINUX_BOOTMEM_H
 #define _LINUX_BOOTMEM_H
@@ -9,6 +10,7 @@
 #include <linux/cache.h>
 #include <linux/init.h>
 #include <linux/mmzone.h>
+#include <linux/segment_tree.h>
 
 /*
  *  simple boot-time physical memory area allocator.
@@ -25,8 +27,8 @@
 	unsigned long node_boot_start;
 	unsigned long node_low_pfn;
 	void *node_bootmem_map;
-	unsigned long last_offset;
-	unsigned long last_pos;
+	segment_tree_root_t segment_tree;
+	segment_buf_t *free_segments;
 } bootmem_data_t;
 
 extern unsigned long __init bootmem_bootmap_pages (unsigned long);
diff -urN linux-2.4.15-pre5-virgin/include/linux/segment_tree.h linux-2.4.15-pre5-bootmem/include/linux/segment_tree.h
--- linux-2.4.15-pre5-virgin/include/linux/segment_tree.h	Wed Dec 31 16:00:00 1969
+++ linux-2.4.15-pre5-bootmem/include/linux/segment_tree.h	Fri Nov 16 19:52:47 2001
@@ -0,0 +1,362 @@
+/*
+ * linux/include/linux/segment_tree.h
+ *
+ * Copyright (C) Oct 2001 William Irwin, IBM
+ *
+ * Implementation of segment trees augmented with length information.
+ *
+ * In this context, "segment" refers to "line segment". In particular,
+ * I am storing closed intervals of numbers in this tree. One very
+ * important invariant maintained is that all the intervals in the
+ * tree are disjoint. This fact is actually used to help with efficient
+ * search, because since they are all disjoint, they are ordered
+ * according to any representative, in particular, the starting and
+ * ending points.
+ *
+ * The separate tree on length is used to help with searches for
+ * intervals of at least a particular length, and does not have
+ * any special properties otherwise.
+ */
+
+#ifndef _SEGMENT_TREE_H
+#define _SEGMENT_TREE_H
+
+#include <linux/treap.h>
+#include <linux/kernel.h>
+
+typedef struct segment_tree_node {
+	treap_node_t start;
+	treap_node_t length;
+} segment_tree_node_t;
+
+typedef union segment_buf {
+	segment_tree_node_t segment;
+	union segment_buf *next;
+} segment_buf_t;
+
+typedef struct segment_tree_root {
+	treap_node_t *start_tree;
+	treap_node_t *length_tree;
+} segment_tree_root_t;
+
+#define segment_length(node) ((node)->length.value)
+#define segment_start(node) ((node)->start.value)
+#define segment_end(node) ((node)->start.value + (node)->length.value - 1)
+
+#define segment_above_point(node, point) \
+	(segment_end(node) > (point))
+
+#define segment_below_point(node, point) \
+	(segment_start(node) < (point))
+
+#define segment_contains_point(node, point) \
+	(segment_start(node) <= (point) && segment_end(node) >= (point))
+
+#define segment_above(node1, node2) \
+	(segment_start(node1) > segment_end(node2))
+
+#define segment_below(node1, node2) \
+	(segment_end(node1) < segment_start(node2))
+
+#define segment_disjoint(node1, node2) \
+	(segment_above(node1, node2) || segment_below(node1, node2))
+
+#define segment_intersect(node1, node2) \
+	(segment_start(node1) <= segment_end(node2) \
+		&& segment_start(node2) <= segment_end(node1))
+
+#define segment_contains(node1, node2) \
+	(segment_start(node1) <= segment_start(node2) \
+		&& segment_end(node1) >= segment_end(node2))
+
+#define segment_set_endpoints(node, start, end) \
+	do { \
+		segment_length(node) = (end) - (start) + 1; \
+		segment_start(node) = (start); \
+	} while(0)
+
+#define segment_unite(node1, node2) \
+	segment_set_endpoints(node1, \
+		min(segment_start(node1),segment_start(node2)), \
+		max(segment_end(node1), segment_end(node2)))
+
+#define segment_union(seg_union, node1, node2) \
+	segment_set_endpoints(seg_union, \
+		min(segment_start(node1),segment_start(node2)), \
+		max(segment_end(node1), segment_end(node2)))
+
+#define segment_intersection(intersect, node1, node2) \
+	segment_set_endpoints(intersect, \
+		max(segment_start(node1), segment_start(node2)), \
+		min(segment_end(node1), segment_end(node2)))
+
+#define segment_set_start(node, start) \
+	segment_set_endpoints(node, start, segment_end(node))
+
+#define segment_set_end(node, end) \
+	segment_set_endpoints(node, segment_start(node), end)
+
+#define start_segment_treap(node) \
+	treap_entry((node), segment_tree_node_t, start)
+#define length_segment_treap(node) \
+	treap_entry((node), segment_tree_node_t, length)
+
+#define start_treap(node) segment_start(start_segment_treap(node))
+#define end_treap(node)   segment_end(start_segment_treap(node))
+
+static inline unsigned segment_tree_contains_point(segment_tree_node_t *root,
+							unsigned long point)
+{
+	treap_node_t *node;
+
+	if(!root)
+		return 0;
+
+	node = &root->start;
+	while(node) {
+		if(segment_contains_point(start_segment_treap(node), point))
+			return 1;
+		else if(segment_below_point(start_segment_treap(node), point))
+			node = node->right;
+		else if(segment_above_point(start_segment_treap(node), point))
+			node = node->left;
+		else
+			BUG();
+	}
+	return 0;
+}
+
+static inline unsigned segment_tree_intersects(segment_tree_node_t *root,
+						segment_tree_node_t *segment)
+{
+	treap_node_t *node;
+
+	if(!root)
+		return 0;
+
+	node = &root->start;
+	while(node) {
+		if(segment_intersect(start_segment_treap(node), segment))
+			return 1;
+		else if(segment_below(start_segment_treap(node), segment))
+			node = node->right;
+		else if(segment_above(start_segment_treap(node), segment))
+			node = node->left;
+		else
+			BUG();
+	}
+	return 0;
+}
+
+/*
+ * There are five cases here.
+ * (1) the segments are disjoint
+ * (2) the entire segment is removed
+ * (3) something from the beginning of the segment is removed
+ * (4) something from the end of the segment is removed
+ * (5) the segment is split into two fragments
+ */
+static inline void segment_complement(	segment_tree_node_t **segment,
+					segment_tree_node_t  *to_remove,
+					segment_tree_node_t **fragment)
+{
+
+	if(segment_disjoint(*segment, to_remove)) {
+
+		*fragment = NULL;
+
+	} else if(segment_contains(to_remove, *segment)) {
+
+		*segment = *fragment = NULL;
+
+	} else if(segment_start(*segment) >= segment_start(to_remove)) {
+		unsigned long start, end;
+		*fragment = NULL;
+		start = segment_end(to_remove) + 1;
+		end = segment_end(*segment);
+		segment_set_endpoints(*segment, start, end);
+
+	} else if(segment_end(*segment) <= segment_end(to_remove)) {
+		unsigned long start, end;
+		*fragment = NULL;
+		start = segment_start(*segment);
+		end = segment_start(to_remove) - 1;
+		segment_set_endpoints(*segment, start, end);
+
+	} else {
+		unsigned long start_seg, end_seg, start_frag, end_frag;
+
+		start_seg = segment_start(*segment);
+		end_seg = segment_start(to_remove) - 1;
+
+		start_frag = segment_end(to_remove) + 1;
+		end_frag = segment_end(*segment);
+
+		segment_set_endpoints(*segment, start_seg, end_seg);
+		segment_set_endpoints(*fragment, start_frag, end_frag);
+
+	}
+}
+
+/*
+ * Efficiently determining all possible line segments which intersect
+ * with another line segment requires splitting the start treap according
+ * to the endpoints. This is a derived key so it unfortunately may not be 
+ * shared with the generic treap implementation.
+ */
+static inline void segment_end_split(treap_root_t root, unsigned long end,
+				treap_root_t less, treap_root_t more)
+{
+	treap_root_t tree = root;
+	treap_node_t sentinel;
+
+	sentinel.value = end;
+	sentinel.priority = ULONG_MAX;
+	sentinel.left = sentinel.right = sentinel.parent = NULL;
+
+	while(1) {
+		if(!*root) {
+			*root = &sentinel;
+			goto finish;
+		} else if(end > end_treap(*root) && !(*root)->right) {
+			(*root)->right = &sentinel;
+			sentinel.parent = *root;
+			root = &(*root)->right;
+			goto upward;
+		} else if(end <= end_treap(*root) && !(*root)->left) {
+			(*root)->left  = &sentinel;
+			sentinel.parent = *root;
+			root = &(*root)->left;
+			goto upward;
+		} else if(end > end_treap(*root))
+			root = &(*root)->right;
+		else /* end <= end_treap(*root) */
+			root = &(*root)->left;
+	}
+
+upward:
+
+	while(1) {
+		if((*root)->left && (*root)->left->priority > (*root)->priority)
+			treap_rotate_right(root);
+		else if((*root)->right
+				&& (*root)->right->priority > (*root)->priority)
+			treap_rotate_left(root);
+
+		if(!(*root)->parent)
+			goto finish;
+		else if(!(*root)->parent->parent)
+			root = tree;
+		else if((*root)->parent->parent->left == (*root)->parent)
+			root = &(*root)->parent->parent->left;
+		else if((*root)->parent->parent->right == (*root)->parent)
+			root = &(*root)->parent->parent->right;
+	}
+
+finish:
+	*less = (*root)->left;
+	*more = (*root)->right;
+
+	if(*less) (*less)->parent = NULL;
+	if(*more) (*more)->parent = NULL;
+
+	*root = NULL;
+}
+
+#define segment_length_link(node) \
+	treap_node_link(&start_segment_treap(node)->length)
+
+#define segment_start_link(node) \
+	treap_node_link(&start_segment_treap(node)->start)
+
+#define segment_delete(node) \
+	do { \
+		treap_root_delete(segment_start_link(node)); \
+		treap_root_delete(segment_length_link(node)); \
+	} while(0)
+
+static inline void segment_all_intersect(treap_root_t root,
+					unsigned long start,
+					unsigned long end,
+					treap_root_t intersect)
+{
+	treap_node_t *less_end, *more_end, *more_start, *less_start;
+	less_start = more_start = NULL;
+
+	if(start) {
+		less_end = more_end = NULL;
+		segment_end_split(root, start, &less_end, &more_end);
+		treap_split(&more_end, end + 1, &less_start, &more_start);
+		*root = NULL;
+		treap_join(root, &less_end, &more_start);
+	} else {
+		treap_split(root, end + 1, &less_start, &more_start);
+		*root = more_start;
+	}
+	*intersect = less_start;
+}
+
+#if 0
+/*
+ * If for some reason there is a reason to visualize the trees,
+ * the following routines may be useful examples as to how they
+ * may be rendered using dot from AT&T's graphviz.
+ */
+
+extern void early_printk(const char *fmt, ...);
+
+static void print_ptr_graph(treap_root_t root) {
+	if(!*root)
+		return;
+	else if(!(*root)->marker) {
+		segment_tree_node_t *seg = start_segment_treap(*root);
+		(*root)->marker = 1UL;
+		early_printk("x%p [label=\"%p, start=%lu,\\nlength=%lu\"];\n",
+				*root, *root, segment_start(seg), segment_length(seg));
+		if((*root)->parent)
+			early_printk("x%p -> x%p [label=\"parent\"];\n",
+						*root, (*root)->parent);
+		if((*root)->left)
+			early_printk("x%p -> x%p [label=\"left\"];\n",
+						*root, (*root)->left);
+		if((*root)->right)
+			early_printk("x%p -> x%p [label=\"right\"];\n",
+						*root, (*root)->right);
+
+		print_ptr_graph(&(*root)->parent);
+		print_ptr_graph(&(*root)->left);
+		print_ptr_graph(&(*root)->right);
+		(*root)->marker = 0UL;
+	}
+	/*
+	 * This is no good for cycle detection since we also traverse
+	 * the parent links. It's -very- cyclic with those.
+	 */
+}
+static void print_length_graph(treap_root_t root) {
+	if(!*root)
+		return;
+	else if(!(*root)->marker) {
+		segment_tree_node_t *seg = length_segment_treap(*root);
+		(*root)->marker = 1UL;
+		early_printk("x%p [label=\"%p: start=%lu,\\nlength=%lu\"];\n",
+				*root, *root, segment_start(seg), segment_length(seg));
+		if((*root)->parent)
+			early_printk("x%p -> x%p [label=\"parent\"];\n",
+						*root, (*root)->parent);
+		if((*root)->left)
+			early_printk("x%p -> x%p [label=\"left\"];\n",
+						*root, (*root)->left);
+		if((*root)->right)
+			early_printk("x%p -> x%p [label=\"right\"];\n",
+						*root, (*root)->right);
+
+		print_length_graph(&(*root)->parent);
+		print_length_graph(&(*root)->left);
+		print_length_graph(&(*root)->right);
+		(*root)->marker = 0UL;
+	}
+}
+#endif
+
+#endif /* _SEGMENT_TREE_H */
diff -urN linux-2.4.15-pre5-virgin/include/linux/treap.h linux-2.4.15-pre5-bootmem/include/linux/treap.h
--- linux-2.4.15-pre5-virgin/include/linux/treap.h	Wed Dec 31 16:00:00 1969
+++ linux-2.4.15-pre5-bootmem/include/linux/treap.h	Fri Nov 16 19:38:09 2001
@@ -0,0 +1,300 @@
+/*
+ * linux/include/linux/treap.h
+ *
+ * Copyright (C) 2001 William Irwin, IBM
+ *
+ * Simple treap implementation, following Aragon and Seidel.
+ *
+ * Treaps are a simple binary search tree structure, with a twist that
+ * radically simplifies their management. That is that they keep both
+ * the search key and a randomly generated priority. They are then both
+ * heap-ordered according to the priority and binary search tree ordered
+ * according to the search keys. They are specifically designed for, and
+ * also reputed to be effective at range tree and segment tree structures
+ * according to both Knuth and dynamic sets according to the
+ * Blelloch/Reid-Miller paper.
+ *
+ * The rotations themselves are simple, and they are done less often
+ * than for some kinds of trees, where splay trees where specifically
+ * mentioned by Knuth. The decision process as to when to perform a
+ * rotation is simplified by the heap structure. Rotations are done in
+ * two instances: when rotating a node down to a leaf position before
+ * deletion, and in restoring the heap ordering after an insertion.
+ *
+ * Treaps also support fast splitting and joining operations, which
+ * make them convenient for interval searches.
+ *
+ * One important fact to observe is that when joining, all of the
+ * members of the left tree must be less than all the members of
+ * the right tree, or otherwise the search tree ordering breaks.
+ */
+
+#ifndef _TREAP_H
+#define _TREAP_H
+
+#include <linux/kernel.h>
+
+typedef struct treap_node {
+	unsigned long priority;
+	unsigned long value;
+	struct treap_node *left, *right, *parent;
+	unsigned long marker;
+} treap_node_t;
+
+typedef treap_node_t **treap_root_t;
+
+#define TREAP_INIT(root) \
+	do { \
+		*root = NULL; \
+	} while(0)
+
+#define treap_entry(ptr, type, member) \
+	((type *)((char *)(ptr)-(unsigned long)(&((type *)0)->member)))
+
+#define treap_node_link(node) \
+	((!(node) || !(node)->parent) ? NULL :				  \
+		((node) == (node)->parent->left) ? &(node)->parent->left  \
+						 : &(node)->parent->right)
+
+#define treap_find_parent_and_remove_child(tmp, parent)	\
+	do {						\
+		parent = tmp->parent;			\
+		if(parent && parent->left == tmp)	\
+			parent->left = NULL;		\
+		else if(parent && parent->right == tmp)	\
+			parent->right = NULL;		\
+		else if(parent)				\
+			BUG();				\
+	} while(0)
+
+
+#define treap_find_leftmost_leaf(node)					\
+	do {								\
+		if(!node)						\
+			break;						\
+		while(1) {						\
+			if(node->left)					\
+				node = node->left;			\
+			else if(node->right)				\
+				node = node->right;			\
+			else						\
+				break;					\
+		}							\
+	} while(0)
+
+/*
+ * The diagram according to which the assignments in rotation are done:
+ *
+ *            T                            T
+ *            |                            |
+ *            y       <- left              x
+ *          /   \                        /   \
+ *        x      C     right ->         A     y
+ *       /  \                                / \
+ *     A     B                              B   C
+ *
+ * Some of these assignments are not necessary, as the edges do
+ * not change. In these cases the assignments are retained as comments.
+ */
+
+static inline void treap_rotate_left(treap_root_t root)
+{
+	treap_node_t *x, *y, *B, *T;
+	/* treap_node_t *A, *C; */
+
+	if(*root) {
+		x = *root;
+		T = x->parent;
+		y = x->right;
+		if(y) {
+			if(T && T->left  == x) T->left  = y;
+			if(T && T->right == x) T->right = y;
+
+			y->parent = T;
+			*root = y;
+
+			/* A = x->left; */
+
+			B = y->left;
+
+			/* C = y->right; */
+
+			y->left = x;
+			x->parent = y;
+
+			/*
+			x->left = A;
+			if(A) A->parent = x;
+			*/
+
+			x->right = B;
+			if(B) B->parent = x;
+
+			/*
+			y->right = C;
+			if(C) C->parent = y;
+			*/
+		}
+	}
+}
+
+static inline void treap_rotate_right(treap_root_t root)
+{
+	treap_node_t *x, *y, *B, *T;
+	/* treap_node_t *A, *C; */
+
+	if(*root) {
+		y = *root;
+		T = y->parent;
+		x = y->left;
+		if(x) {
+			if(T && T->left  == y) T->left  = x;
+			if(T && T->right == y) T->right = x;
+
+			x->parent = T;
+			*root = x;
+
+			/* A = x->left; */
+
+			B = x->right;
+
+			/* C = y->right; */
+
+			x->right = y;
+			y->parent = x;
+
+			/*
+			x->left = A;
+			if(A) A->parent = x;
+			*/
+
+			y->left = B;
+			if(B) B->parent = y;
+
+			/*
+			y->right = C;
+			if(C) C->parent = y;
+			*/
+		}
+	}
+}
+
+static inline treap_node_t *treap_root_delete(treap_root_t root)
+{
+	struct treap_node *tmp;
+
+	while(1) {
+
+		if(!root || !*root) return NULL;
+		else if(!(*root)->left && !(*root)->right) {
+			tmp = *root;
+			*root = tmp->parent = NULL;
+			return tmp;
+		} else if(!(*root)->left) {
+			treap_rotate_left(root);
+			root = &(*root)->left;
+		} else if(!(*root)->right) {
+			treap_rotate_right(root);
+			root = &(*root)->right;
+		} else if((*root)->left->priority > (*root)->right->priority) {
+			treap_rotate_right(root);
+			root = &(*root)->right;
+		} else {
+			treap_rotate_left(root);
+			root = &(*root)->left;
+		}
+	}
+}
+
+static inline void treap_insert(treap_root_t root, treap_node_t *node)
+{
+	treap_root_t tree = root;
+	node->left = node->right = node->parent = NULL;
+
+	while(1) {
+		if(!*root) {
+			*root = node;
+			return;
+		} else if(node->value <= (*root)->value && !(*root)->left) {
+			(*root)->left = node;
+			node->parent = *root;
+			root = &(*root)->left;
+			break;
+		} else if(node->value > (*root)->value && !(*root)->right) {
+			(*root)->right = node;
+			node->parent = *root;
+			root = &(*root)->right;
+			break;
+		} else if(node->value <= (*root)->value) {
+			root = &(*root)->left;
+		} else {  /* node->value > (*root)->value */
+			root = &(*root)->right;
+		}
+	}
+	while(1) {
+		if(!*root) return;
+		else if((*root)->left
+				&& (*root)->left->priority > (*root)->priority)
+			treap_rotate_right(root);
+		else if((*root)->right
+				&& (*root)->right->priority > (*root)->priority)
+			treap_rotate_left(root);
+
+		if(!(*root)->parent)
+			return;
+		else if(!(*root)->parent->parent)
+			root = tree;
+		else if((*root)->parent == (*root)->parent->parent->left)
+			root = &(*root)->parent->parent->left;
+		else if((*root)->parent == (*root)->parent->parent->right)
+			root = &(*root)->parent->parent->right;
+
+	}
+}
+
+static inline treap_node_t *treap_delete(treap_root_t root, unsigned long k)
+{
+	while(1) {
+		if(!*root) return NULL;
+		else if(k < (*root)->value) root = &(*root)->left;
+		else if(k > (*root)->value) root = &(*root)->right;
+		else return treap_root_delete(root);
+	}
+}
+
+static inline void treap_split(treap_root_t root, unsigned long k,
+					treap_root_t less, treap_root_t more)
+{
+	treap_node_t sentinel;
+
+	sentinel.value = k;
+	sentinel.priority = ULONG_MAX;
+	sentinel.parent = sentinel.left = sentinel.right = NULL;
+
+	treap_insert(root, &sentinel);
+	*less = (*root)->left;
+	*more = (*root)->right;
+
+	if(*less) (*less)->parent = NULL;
+	if(*more) (*more)->parent = NULL;
+
+	*root = NULL;
+}
+
+static inline void treap_join(treap_root_t root,
+				treap_root_t left, treap_root_t right)
+{
+	treap_node_t sentinel;
+	sentinel.priority = 0UL;
+	sentinel.left = *left;
+	sentinel.right = *right;
+	sentinel.parent = NULL;
+
+	if(*left)  (*left)->parent  = &sentinel;
+	if(*right) (*right)->parent = &sentinel;
+
+	*root = &sentinel;
+	treap_root_delete(root);
+}
+
+#endif /* _TREAP_H */
