Return-Path: <linux-kernel-owner+w=401wt.eu-S932410AbXAPFs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbXAPFs7 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 00:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbXAPFs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 00:48:58 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:40820 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932410AbXAPFse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 00:48:34 -0500
Date: Mon, 15 Jan 2007 21:48:25 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Paul Menage <menage@google.com>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Paul Jackson <pj@sgi.com>,
       Dave Chinner <dgc@sgi.com>, Christoph Lameter <clameter@sgi.com>
Message-Id: <20070116054825.15358.65020.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC 8/8] Reduce inode memory usage for systems with a high MAX_NUMNODES
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dynamically reduce the size of the nodemask_t in struct inode

The nodemask_t in struct inode can potentially waste a lot of memory if
MAX_NUMNODES is high. For IA64 MAX_NUMNODES is 1024 by default which
results in 128 bytes to be used for the nodemask. This means that the
memory use for inodes may increase significantly since they all now
include a dirty_map. These may be unecessarily large on smaller systems.

We placed the nodemask at the end of struct inode. This patch avoids
touching the later part of the nodemask if the actual maximum possible
node on the system is less than 1024. If MAX_NUMNODES is larger than
BITS_PER_LONG (and we may use more than one word for the nodemask) then
we calculate the number of bytes that may be taken off the end of
an inode. We can then create the inode caches without those bytes
effectively saving memory. On a IA64 system booting with a
maximum of 64 nodes we may save 120 of those 128 bytes per inode.

This is only done for filesystems that are typically used for NUMA
systems: xfs, nfs, ext3, ext4 and reiserfs. Other filesystems will
always use the full length of the inode.

This solution may be a bit hokey. I tried other approaches but this
one seemed to be the simplest with the least complications. Maybe someone
else can come up with a better solution?

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.20-rc5/fs/xfs/linux-2.6/xfs_super.c
===================================================================
--- linux-2.6.20-rc5.orig/fs/xfs/linux-2.6/xfs_super.c	2007-01-15 22:33:55.000000000 -0600
+++ linux-2.6.20-rc5/fs/xfs/linux-2.6/xfs_super.c	2007-01-15 22:35:07.596529498 -0600
@@ -370,7 +370,9 @@ xfs_fs_inode_init_once(
 STATIC int
 xfs_init_zones(void)
 {
-	xfs_vnode_zone = kmem_zone_init_flags(sizeof(bhv_vnode_t), "xfs_vnode",
+	xfs_vnode_zone = kmem_zone_init_flags(sizeof(bhv_vnode_t)
+						- unused_numa_nodemask_bytes,
+					"xfs_vnode",
 					KM_ZONE_HWALIGN | KM_ZONE_RECLAIM |
 					KM_ZONE_SPREAD,
 					xfs_fs_inode_init_once);
Index: linux-2.6.20-rc5/include/linux/fs.h
===================================================================
--- linux-2.6.20-rc5.orig/include/linux/fs.h	2007-01-15 22:33:55.000000000 -0600
+++ linux-2.6.20-rc5/include/linux/fs.h	2007-01-15 22:35:07.621922373 -0600
@@ -591,6 +591,14 @@ struct inode {
 	void			*i_private; /* fs or device private pointer */
 #ifdef CONFIG_CPUSETS
 	nodemask_t		dirty_nodes;	/* Map of nodes with dirty pages */
+	/*
+	 * Note that we may only use a portion of the bitmap in dirty_nodes
+	 * if we have a large MAX_NUMNODES but the number of possible nodes
+	 * is small in order to reduce the size of the inode.
+	 *
+	 * Bits after nr_node_ids (one node beyond the last possible
+	 * node_id) may not be accessed.
+	 */
 #endif
 };
 
Index: linux-2.6.20-rc5/fs/ext3/super.c
===================================================================
--- linux-2.6.20-rc5.orig/fs/ext3/super.c	2007-01-15 22:33:55.000000000 -0600
+++ linux-2.6.20-rc5/fs/ext3/super.c	2007-01-15 22:35:07.646338599 -0600
@@ -480,7 +480,8 @@ static void init_once(void * foo, struct
 static int init_inodecache(void)
 {
 	ext3_inode_cachep = kmem_cache_create("ext3_inode_cache",
-					     sizeof(struct ext3_inode_info),
+					     sizeof(struct ext3_inode_info)
+						- unused_numa_nodemask_bytes,
 					     0, (SLAB_RECLAIM_ACCOUNT|
 						SLAB_MEM_SPREAD),
 					     init_once, NULL);
Index: linux-2.6.20-rc5/fs/inode.c
===================================================================
--- linux-2.6.20-rc5.orig/fs/inode.c	2007-01-15 22:33:55.000000000 -0600
+++ linux-2.6.20-rc5/fs/inode.c	2007-01-15 22:35:07.661964984 -0600
@@ -1399,7 +1399,8 @@ void __init inode_init(unsigned long mem
 
 	/* inode slab cache */
 	inode_cachep = kmem_cache_create("inode_cache",
-					 sizeof(struct inode),
+					 sizeof(struct inode)
+						- unused_numa_nodemask_bytes,
 					 0,
 					 (SLAB_RECLAIM_ACCOUNT|SLAB_PANIC|
 					 SLAB_MEM_SPREAD),
Index: linux-2.6.20-rc5/fs/reiserfs/super.c
===================================================================
--- linux-2.6.20-rc5.orig/fs/reiserfs/super.c	2007-01-15 22:33:55.000000000 -0600
+++ linux-2.6.20-rc5/fs/reiserfs/super.c	2007-01-15 22:35:07.685404561 -0600
@@ -525,11 +525,11 @@ static void init_once(void *foo, struct 
 static int init_inodecache(void)
 {
 	reiserfs_inode_cachep = kmem_cache_create("reiser_inode_cache",
-						  sizeof(struct
-							 reiserfs_inode_info),
-						  0, (SLAB_RECLAIM_ACCOUNT|
-							SLAB_MEM_SPREAD),
-						  init_once, NULL);
+					  sizeof(struct reiserfs_inode_info)
+						 - unused_numa_nodemask_bytes,
+					  0, (SLAB_RECLAIM_ACCOUNT|
+						SLAB_MEM_SPREAD),
+					  init_once, NULL);
 	if (reiserfs_inode_cachep == NULL)
 		return -ENOMEM;
 	return 0;
Index: linux-2.6.20-rc5/include/linux/cpuset.h
===================================================================
--- linux-2.6.20-rc5.orig/include/linux/cpuset.h	2007-01-15 22:34:37.000000000 -0600
+++ linux-2.6.20-rc5/include/linux/cpuset.h	2007-01-15 22:33:53.759908623 -0600
@@ -82,11 +82,13 @@ extern void cpuset_track_online_nodes(vo
 	node_set(page_to_nid(__page), (__inode)->dirty_nodes)
 
 #define cpuset_clear_dirty_nodes(__inode) \
-		(__inode)->dirty_nodes = NODE_MASK_NONE
+	bitmap_zero(nodes_addr((__inode)->dirty_nodes), nr_node_ids)
 
 #define cpuset_intersects_dirty_nodes(__inode, __nodemask_ptr) \
-		(!(__nodemask_ptr) || nodes_intersects((__inode)->dirty_nodes, \
-		*(__nodemask_ptr)))
+		(!(__nodemask_ptr) || bitmap_intersects( \
+			nodes_addr((__inode)->dirty_nodes), \
+			nodes_addr(*(__nodemask_ptr)), \
+			nr_node_ids))
 
 #else /* !CONFIG_CPUSETS */
 
Index: linux-2.6.20-rc5/include/linux/nodemask.h
===================================================================
--- linux-2.6.20-rc5.orig/include/linux/nodemask.h	2007-01-15 22:33:55.000000000 -0600
+++ linux-2.6.20-rc5/include/linux/nodemask.h	2007-01-15 22:35:07.712750734 -0600
@@ -353,6 +353,13 @@ extern nodemask_t node_possible_map;
 #define first_online_node	first_node(node_online_map)
 #define next_online_node(nid)	next_node((nid), node_online_map)
 extern int nr_node_ids;
+
+#if MAX_NUMNODES > BITS_PER_LONG
+extern int unused_numa_nodemask_bytes;
+#else
+#define unused_numa_nodemask_bytes 0
+#endif
+
 #else
 #define num_online_nodes()	1
 #define num_possible_nodes()	1
@@ -361,6 +368,7 @@ extern int nr_node_ids;
 #define first_online_node	0
 #define next_online_node(nid)	(MAX_NUMNODES)
 #define nr_node_ids		1
+#define unused_numa_nodemask_bytes	0
 #endif
 
 #define any_online_node(mask)			\
Index: linux-2.6.20-rc5/mm/page_alloc.c
===================================================================
--- linux-2.6.20-rc5.orig/mm/page_alloc.c	2007-01-15 22:33:55.000000000 -0600
+++ linux-2.6.20-rc5/mm/page_alloc.c	2007-01-15 22:35:07.735213662 -0600
@@ -663,6 +663,10 @@ static int rmqueue_bulk(struct zone *zon
 #if MAX_NUMNODES > 1
 int nr_node_ids __read_mostly;
 EXPORT_SYMBOL(nr_node_ids);
+#if MAX_NUMNODES > BITS_PER_LONG
+int unused_numa_nodemask_bytes __read_mostly;
+EXPORT_SYMBOL(unused_numa_nodemask_bytes);
+#endif
 
 /*
  * Figure out the number of possible node ids.
@@ -675,6 +679,10 @@ static void __init setup_nr_node_ids(voi
 	for_each_node_mask(node, node_possible_map)
 		highest = node;
 	nr_node_ids = highest + 1;
+#if MAX_NUMNODES > BITS_PER_LONG
+	unused_numa_nodemask_bytes = BITS_TO_LONGS(MAX_NUMNODES)
+				- BITS_TO_LONGS(nr_node_ids);
+#endif
 }
 #else
 static void __init setup_nr_node_ids(void) {}
Index: linux-2.6.20-rc5/fs/nfs/inode.c
===================================================================
--- linux-2.6.20-rc5.orig/fs/nfs/inode.c	2007-01-15 22:33:55.000000000 -0600
+++ linux-2.6.20-rc5/fs/nfs/inode.c	2007-01-15 22:35:07.755723291 -0600
@@ -1136,7 +1136,8 @@ static void init_once(void * foo, struct
 static int __init nfs_init_inodecache(void)
 {
 	nfs_inode_cachep = kmem_cache_create("nfs_inode_cache",
-					     sizeof(struct nfs_inode),
+					     sizeof(struct nfs_inode)
+					     - unused_numa_nodemask_bytes,
 					     0, (SLAB_RECLAIM_ACCOUNT|
 						SLAB_MEM_SPREAD),
 					     init_once, NULL);
