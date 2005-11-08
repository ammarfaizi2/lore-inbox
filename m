Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030349AbVKHVE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030349AbVKHVE6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 16:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030352AbVKHVEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 16:04:54 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:47584 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030349AbVKHVE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 16:04:28 -0500
Date: Tue, 8 Nov 2005 13:04:12 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Mike Kravetz <kravetz@us.ibm.com>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       torvalds@osdl.org, Christoph Lameter <clameter@sgi.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>, Andi Kleen <ak@suse.de>,
       Magnus Damm <magnus.damm@gmail.com>, Paul Jackson <pj@sgi.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20051108210402.31330.19167.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051108210246.31330.61756.sendpatchset@schroedinger.engr.sgi.com>
References: <20051108210246.31330.61756.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 5/8] Direct Migration V2: upgrade MPOL_MF_MOVE and sys_migrate_pages()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Modify policy layer to support direct page migration

- Add migrate_pages_to() allowing the migration of a list of pages to a
  a specified node or to vma with a specific allocation policy in sets
  of MIGRATE_CHUNK_SIZE pages

- Modify do_migrate_pages() to do a staged move of pages from the
  source nodes to the target nodes.

- Use comparisons instead of XOR in permission check.

V1->V2:
- Migrate processes in chunks of MIGRATE_CHUNK_SIZE

Signed-off-by: Paul Jackson <pj@sgi.com>
Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.14-mm1/mm/mempolicy.c
===================================================================
--- linux-2.6.14-mm1.orig/mm/mempolicy.c	2005-11-08 10:06:04.000000000 -0800
+++ linux-2.6.14-mm1/mm/mempolicy.c	2005-11-08 10:17:09.000000000 -0800
@@ -89,6 +89,10 @@
 
 /* Internal MPOL_MF_xxx flags */
 #define MPOL_MF_DISCONTIG_OK (1<<20)	/* Skip checks for continuous vmas */
+#define MPOL_MF_INVERT (1<<21)		/* Invert check for nodemask */
+
+/* The number of pages to migrate per call to migrate_pages() */
+#define MIGRATE_CHUNK_SIZE 256
 
 static kmem_cache_t *policy_cache;
 static kmem_cache_t *sn_cache;
@@ -258,7 +262,7 @@ static int check_pte_range(struct vm_are
 			continue;
 		}
 		nid = pfn_to_nid(pfn);
-		if (!node_isset(nid, *nodes)) {
+		if (!node_isset(nid, *nodes) == !(flags & MPOL_MF_INVERT)) {
 			if (pagelist) {
 				struct page *page = pfn_to_page(pfn);
 
@@ -447,6 +451,65 @@ static int contextualize_policy(int mode
 	return mpol_check_policy(mode, nodes);
 }
 
+/*
+ * Migrate the list 'pagelist' of pages to a certain destination.
+ *
+ * Specify destination with either non-NULL vma or dest_node >= 0
+ * Return the number of pages not migrated or error code
+ */
+static int migrate_pages_to(struct list_head *pagelist,
+	struct vm_area_struct *vma, int dest)
+{
+	LIST_HEAD(newlist);
+	LIST_HEAD(moved);
+	LIST_HEAD(failed);
+	int err = 0;
+	int nr_pages;
+	struct page *page;
+	struct list_head *p;
+
+redo:
+	nr_pages = 0;
+	list_for_each(p, pagelist) {
+		if (vma)
+			page = alloc_page_vma(GFP_HIGHUSER, vma,
+						vma->vm_start);
+		else
+			page = alloc_pages_node(dest, GFP_HIGHUSER, 0);
+
+		if (!page) {
+			err = -ENOMEM;
+			goto out;
+		}
+		list_add(&page->lru, &newlist);
+		nr_pages++;
+		if (nr_pages > MIGRATE_CHUNK_SIZE);
+			break;
+	}
+	err = migrate_pages(pagelist, &newlist, &moved, &failed);
+
+	putback_lru_pages(&moved);	/* Call release pages instead ?? */
+
+	if (err >= 0 && list_empty(&newlist) && !list_empty(pagelist))
+		goto redo;
+out:
+	/* Return leftover allocated pages */
+	while (!list_empty(&newlist)) {
+		page = list_entry(newlist.next, struct page, lru);
+		list_del(&page->lru);
+		__free_page(page);
+	}
+	list_splice(&failed, pagelist);
+	if (err < 0)
+		return err;
+
+	/* Calculate number of leftover pages */
+	nr_pages = 0;
+	list_for_each(p, pagelist)
+		nr_pages++;
+	return nr_pages;
+}
+
 long do_mbind(unsigned long start, unsigned long len,
 		unsigned long mode, nodemask_t *nmask, unsigned long flags)
 {
@@ -497,14 +560,22 @@ long do_mbind(unsigned long start, unsig
 	down_write(&mm->mmap_sem);
 	vma = check_range(mm, start, end, nmask, flags,
 	      (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) ? &pagelist : NULL);
+
 	err = PTR_ERR(vma);
 	if (!IS_ERR(vma)) {
+
 		err = mbind_range(vma, start, end, new);
-		if (!list_empty(&pagelist))
-			migrate_pages(&pagelist, NULL);
-		if (!err  && !list_empty(&pagelist) && (flags & MPOL_MF_STRICT))
+
+		if (!err) {
+			if (!list_empty(&pagelist))
+				migrate_pages_to(&pagelist, vma, -1);
+
+			if (!list_empty(&pagelist) && (flags & MPOL_MF_STRICT))
 				err = -EIO;
+		}
+
 	}
+
 	if (!list_empty(&pagelist))
 		putback_lru_pages(&pagelist);
 
@@ -633,10 +704,37 @@ long do_get_mempolicy(int *policy, nodem
 }
 
 /*
- * For now migrate_pages simply swaps out the pages from nodes that are in
- * the source set but not in the target set. In the future, we would
- * want a function that moves pages between the two nodesets in such
- * a way as to preserve the physical layout as much as possible.
+ * Migrate pages from one node to a target node.
+ * Returns error or the number of pages not migrated.
+ */
+int migrate_to_node(struct mm_struct *mm, int source,
+		    int dest, int flags)
+{
+	nodemask_t nmask;
+	LIST_HEAD(pagelist);
+	int err = 0;
+
+	nodes_clear(nmask);
+	node_set(source, nmask);
+
+	check_range(mm, mm->mmap->vm_start, TASK_SIZE, &nmask,
+			flags | MPOL_MF_DISCONTIG_OK | MPOL_MF_INVERT,
+			&pagelist);
+
+	if (!list_empty(&pagelist)) {
+
+		err = migrate_pages_to(&pagelist, NULL, dest);
+
+		if (!list_empty(&pagelist))
+			putback_lru_pages(&pagelist);
+
+	}
+	return err;
+}
+
+/*
+ * Move pages between the two nodesets so as to preserve the physical
+ * layout as much as possible.
  *
  * Returns the number of page that could not be moved.
  */
@@ -644,22 +742,76 @@ int do_migrate_pages(struct mm_struct *m
 	const nodemask_t *from_nodes, const nodemask_t *to_nodes, int flags)
 {
 	LIST_HEAD(pagelist);
-	int count = 0;
-	nodemask_t nodes;
-
-	nodes_andnot(nodes, *from_nodes, *to_nodes);
-	nodes_complement(nodes, nodes);
+	int err = 0;
+	nodemask_t tmp;
+	int busy = 0;
 
 	down_read(&mm->mmap_sem);
-	check_range(mm, mm->mmap->vm_start, TASK_SIZE, &nodes,
-			flags | MPOL_MF_DISCONTIG_OK, &pagelist);
-	if (!list_empty(&pagelist)) {
-		migrate_pages(&pagelist, NULL);
-		if (!list_empty(&pagelist))
-			count = putback_lru_pages(&pagelist);
+
+/* Find a 'source' bit set in 'tmp' whose corresponding 'dest'
+ * bit in 'to' is not also set in 'tmp'.  Clear the found 'source'
+ * bit in 'tmp', and return that <source, dest> pair for migration.
+ * The pair of nodemasks 'to' and 'from' define the map.
+ *
+ * If no pair of bits is found that way, fallback to picking some
+ * pair of 'source' and 'dest' bits that are not the same.  If the
+ * 'source' and 'dest' bits are the same, this represents a node
+ * that will be migrating to itself, so no pages need move.
+ *
+ * If no bits are left in 'tmp', or if all remaining bits left
+ * in 'tmp' correspond to the same bit in 'to', return false
+ * (nothing left to migrate).
+ *
+ * This lets us pick a pair of nodes to migrate between, such that
+ * if possible the dest node is not already occupied by some other
+ * source node, minimizing the risk of overloading the memory on a
+ * node that would happen if we migrated incoming memory to a node
+ * before migrating outgoing memory source that same node.
+ *
+ * A single scan of tmp is sufficient.  As we go, we remember the
+ * most recent <s, d> pair that moved (s != d).  If we find a pair
+ * that not only moved, but what's better, moved to an empty slot
+ * (d is not set in tmp), then we break out then, with that pair.
+ * Otherwise when we finish scannng from_tmp, we at least have the
+ * most recent <s, d> pair that moved.  If we get all the way through
+ * the scan of tmp without finding any node that moved, much less
+ * moved to an empty node, then there is nothing left worth migrating.
+ */
+
+	tmp = *from_nodes;
+	while (!nodes_empty(tmp)) {
+		int s,d;
+		int source = -1;
+		int dest = 0;
+
+		for_each_node_mask(s, tmp) {
+
+			d = node_remap(s, *from_nodes, *to_nodes);
+			if (s == d)
+				continue;
+
+			source = s;	/* Node moved. Memorize */
+			dest = d;
+
+			/* dest not in remaining from nodes? */
+			if (!node_isset(dest, tmp))
+				break;
+		}
+		if (source == -1)
+			break;
+
+		node_clear(source, tmp);
+		err = migrate_to_node(mm, source, dest, flags);
+		if (err > 0)
+			busy += err;
+		if (err < 0)
+			break;
 	}
+
 	up_read(&mm->mmap_sem);
-	return count;
+	if (err < 0)
+		return err;
+	return busy;
 }
 
 /*
