Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932465AbVKUUnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbVKUUnR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 15:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbVKUUnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 15:43:17 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:64705 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932462AbVKUUnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 15:43:16 -0500
Date: Mon, 21 Nov 2005 12:43:07 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: ak@suse.de, linux-kernel@vger.kernel.org,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20051121204307.10630.43311.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051121204301.10630.76569.sendpatchset@schroedinger.engr.sgi.com>
References: <20051121204301.10630.76569.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 2/4] Fold numa_maps into memopolicies.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fold numa_maps functionality into mempolicy.c

First discussed at http://marc.theaimsgroup.com/?t=113149255100001&r=1&w=2

- Use the check_range() in mempolicy.c to gather statistics.

- Improve the numa_maps code in general and fix some comments.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc1-mm1/mm/mempolicy.c
===================================================================
--- linux-2.6.15-rc1-mm1.orig/mm/mempolicy.c	2005-11-17 19:19:24.000000000 -0800
+++ linux-2.6.15-rc1-mm1/mm/mempolicy.c	2005-11-17 19:20:40.000000000 -0800
@@ -84,6 +84,8 @@
 #include <linux/compat.h>
 #include <linux/mempolicy.h>
 #include <linux/swap.h>
+#include <linux/seq_file.h>
+#include <linux/proc_fs.h>
 
 #include <asm/tlbflush.h>
 #include <asm/uaccess.h>
@@ -91,6 +93,7 @@
 /* Internal flags */
 #define MPOL_MF_DISCONTIG_OK (MPOL_MF_INTERNAL << 0)	/* Skip checks for continuous vmas */
 #define MPOL_MF_INVERT (MPOL_MF_INTERNAL << 1)		/* Invert check for nodemask */
+#define MPOL_MF_STATS (MPOL_MF_INTERNAL << 2)		/* Gather statistics */
 
 static kmem_cache_t *policy_cache;
 static kmem_cache_t *sn_cache;
@@ -233,6 +236,8 @@ static void migrate_page_add(struct vm_a
 	}
 }
 
+static void gather_stats(struct page *, void *);
+
 /* Scan through pages checking if pages follow certain conditions. */
 static int check_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long addr, unsigned long end,
@@ -261,7 +266,9 @@ static int check_pte_range(struct vm_are
 		if (node_isset(nid, *nodes) == !!(flags & MPOL_MF_INVERT))
 			continue;
 
-		if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
+		if (flags & MPOL_MF_STATS)
+			gather_stats(page, private);
+		else if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
 			migrate_page_add(vma, page, private, flags);
 		else
 			break;
@@ -1498,3 +1511,132 @@ void numa_policy_rebind(const nodemask_t
 {
 	rebind_policy(current->mempolicy, old, new);
 }
+
+/*
+ * Display pages allocated per node and memory policy via /proc.
+ */
+
+static const char *policy_types[] = { "default", "prefer", "bind",
+				      "interleave" };
+
+/*
+ * Convert a mempolicy into a string.
+ * Returns the number of characters in buffer (if positive)
+ * or an error (negative)
+ */
+static inline int mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
+{
+	char *p = buffer;
+	int l;
+	nodemask_t nodes;
+	int mode = pol ? pol->policy : MPOL_DEFAULT;
+
+	switch (mode) {
+	case MPOL_DEFAULT:
+		nodes_clear(nodes);
+		break;
+
+	case MPOL_PREFERRED:
+		nodes_clear(nodes);
+		node_set(pol->v.preferred_node, nodes);
+		break;
+
+	case MPOL_BIND:
+		get_zonemask(pol, &nodes);
+		break;
+
+	case MPOL_INTERLEAVE:
+		nodes = pol->v.nodes;
+		break;
+
+	default:
+		BUG();
+		return -EFAULT;
+	}
+
+	l = strlen(policy_types[mode]);
+ 	if (buffer + maxlen < p + l + 1)
+ 		return -ENOSPC;
+
+	strcpy(p, policy_types[mode]);
+	p += l;
+
+	if (!nodes_empty(nodes)) {
+		if (buffer + maxlen < p + 2)
+			return -ENOSPC;
+		*p++ = '=';
+	 	p += nodelist_scnprintf(p, buffer + maxlen - p, nodes);
+	}
+	return p - buffer;
+}
+
+struct numa_maps {
+	unsigned long pages;
+	unsigned long anon;
+	unsigned long mapped;
+	unsigned long mapcount_max;
+	unsigned long node[MAX_NUMNODES];
+};
+
+static void gather_stats(struct page *page, void *private)
+{
+	struct numa_maps *md = private;
+	int count = page_mapcount(page);
+
+	if (count)
+		md->mapped++;
+
+	if (count > md->mapcount_max)
+		md->mapcount_max = count;
+
+	md->pages++;
+
+	if (PageAnon(page))
+		md->anon++;
+
+	md->node[page_to_nid(page)]++;
+	cond_resched();
+}
+
+int show_numa_map(struct seq_file *m, void *v)
+{
+	struct task_struct *task = m->private;
+	struct vm_area_struct *vma = v;
+	struct numa_maps *md;
+	int n;
+	char buffer[50];
+
+	if (!vma->vm_mm)
+		return 0;
+
+	md = kzalloc(sizeof(struct numa_maps), GFP_KERNEL);
+	if (!md)
+		return 0;
+
+	check_pgd_range(vma, vma->vm_start, vma->vm_end,
+		    &node_online_map, MPOL_MF_STATS, md);
+
+	if (md->pages) {
+		mpol_to_str(buffer, sizeof(buffer),
+			    get_vma_policy(task, vma, vma->vm_start));
+
+		seq_printf(m, "%08lx %s pages=%lu mapped=%lu maxref=%lu",
+			   vma->vm_start, buffer, md->pages,
+			   md->mapped, md->mapcount_max);
+
+		if (md->anon)
+			seq_printf(m," anon=%lu",md->anon);
+
+		for_each_online_node(n)
+			if (md->node[n])
+				seq_printf(m, " N%d=%lu", n, md->node[n]);
+
+		seq_putc(m, '\n');
+	}
+	kfree(md);
+
+	if (m->count < m->size)
+		m->version = (vma != get_gate_vma(task)) ? vma->vm_start : 0;
+	return 0;
+}
+
Index: linux-2.6.15-rc1-mm1/fs/proc/task_mmu.c
===================================================================
--- linux-2.6.15-rc1-mm1.orig/fs/proc/task_mmu.c	2005-11-17 15:17:31.000000000 -0800
+++ linux-2.6.15-rc1-mm1/fs/proc/task_mmu.c	2005-11-17 19:19:57.000000000 -0800
@@ -390,130 +390,12 @@ struct seq_operations proc_pid_smaps_op 
 };
 
 #ifdef CONFIG_NUMA
-
-struct numa_maps {
-	unsigned long pages;
-	unsigned long anon;
-	unsigned long mapped;
-	unsigned long mapcount_max;
-	unsigned long node[MAX_NUMNODES];
-};
-
-/*
- * Calculate numa node maps for a vma
- */
-static struct numa_maps *get_numa_maps(const struct vm_area_struct *vma)
-{
-	struct page *page;
-	unsigned long vaddr;
-	struct mm_struct *mm = vma->vm_mm;
-	int i;
-	struct numa_maps *md = kmalloc(sizeof(struct numa_maps), GFP_KERNEL);
-
-	if (!md)
-		return NULL;
-	md->pages = 0;
-	md->anon = 0;
-	md->mapped = 0;
-	md->mapcount_max = 0;
-	for_each_node(i)
-		md->node[i] =0;
-
- 	for (vaddr = vma->vm_start; vaddr < vma->vm_end; vaddr += PAGE_SIZE) {
-		page = follow_page(mm, vaddr, 0);
-		if (page) {
-			int count = page_mapcount(page);
-
-			if (count)
-				md->mapped++;
-			if (count > md->mapcount_max)
-				md->mapcount_max = count;
-			md->pages++;
-			if (PageAnon(page))
-				md->anon++;
-			md->node[page_to_nid(page)]++;
-		}
-		cond_resched();
-	}
-	return md;
-}
-
-static int show_numa_map(struct seq_file *m, void *v)
-{
-	struct task_struct *task = m->private;
-	struct vm_area_struct *vma = v;
-	struct mempolicy *pol;
-	struct numa_maps *md;
-	struct zone **z;
-	int n;
-	int first;
-
-	if (!vma->vm_mm)
-		return 0;
-
-	md = get_numa_maps(vma);
-	if (!md)
-		return 0;
-
-	seq_printf(m, "%08lx", vma->vm_start);
-	pol = get_vma_policy(task, vma, vma->vm_start);
-	/* Print policy */
-	switch (pol->policy) {
-	case MPOL_PREFERRED:
-		seq_printf(m, " prefer=%d", pol->v.preferred_node);
-		break;
-	case MPOL_BIND:
-		seq_printf(m, " bind={");
-		first = 1;
-		for (z = pol->v.zonelist->zones; *z; z++) {
-
-			if (!first)
-				seq_putc(m, ',');
-			else
-				first = 0;
-			seq_printf(m, "%d/%s", (*z)->zone_pgdat->node_id,
-					(*z)->name);
-		}
-		seq_putc(m, '}');
-		break;
-	case MPOL_INTERLEAVE:
-		seq_printf(m, " interleave={");
-		first = 1;
-		for_each_node(n) {
-			if (node_isset(n, pol->v.nodes)) {
-				if (!first)
-					seq_putc(m,',');
-				else
-					first = 0;
-				seq_printf(m, "%d",n);
-			}
-		}
-		seq_putc(m, '}');
-		break;
-	default:
-		seq_printf(m," default");
-		break;
-	}
-	seq_printf(m, " MaxRef=%lu Pages=%lu Mapped=%lu",
-			md->mapcount_max, md->pages, md->mapped);
-	if (md->anon)
-		seq_printf(m," Anon=%lu",md->anon);
-
-	for_each_online_node(n) {
-		if (md->node[n])
-			seq_printf(m, " N%d=%lu", n, md->node[n]);
-	}
-	seq_putc(m, '\n');
-	kfree(md);
-	if (m->count < m->size)  /* vma is copied successfully */
-		m->version = (vma != get_gate_vma(task)) ? vma->vm_start : 0;
-	return 0;
-}
+extern int show_numa_map(struct seq_file *m, void *v);
 
 struct seq_operations proc_pid_numa_maps_op = {
-	.start	= m_start,
-	.next	= m_next,
-	.stop	= m_stop,
-	.show	= show_numa_map
+        .start  = m_start,
+        .next   = m_next,
+        .stop   = m_stop,
+        .show   = show_numa_map
 };
 #endif
