Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262712AbVG2Slz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262712AbVG2Slz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 14:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262702AbVG2Slt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 14:41:49 -0400
Received: from graphe.net ([209.204.138.32]:40667 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262707AbVG2SlG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 14:41:06 -0400
Date: Fri, 29 Jul 2005 11:41:04 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: linux-kernel@vger.kernel.org
cc: akpm@osdl.org
Subject: [PATCH] Merge /proc/pid/numa_maps functionality into smaps 
Message-ID: <Pine.LNX.4.62.0507291139030.3911@graphe.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch merges the functionality provided by the numa_maps patch in mm 
into the /proc/<pid>/smaps facility. The numa_maps patch may then be 
dropped from mm.

Signed-off-by: Christoph Lameter <christoph@lameter.com>


Index: linux-2.6.13-rc3-mm3/fs/proc/task_mmu.c
===================================================================
--- linux-2.6.13-rc3-mm3.orig/fs/proc/task_mmu.c	2005-07-29 11:07:50.000000000 -0700
+++ linux-2.6.13-rc3-mm3/fs/proc/task_mmu.c	2005-07-29 11:33:38.000000000 -0700
@@ -158,6 +158,10 @@
 	unsigned long shared_dirty;
 	unsigned long private_clean;
 	unsigned long private_dirty;
+	unsigned long anon;
+	unsigned long mapped;
+	unsigned long mapcount_max;
+	unsigned long node[MAX_NUMNODES];
 };
 
 static void smaps_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
@@ -167,6 +171,7 @@
 	pte_t *pte, ptent;
 	unsigned long pfn;
 	struct page *page;
+	int count;
 
 	pte = pte_offset_map(pmd, addr);
 	do {
@@ -191,6 +196,15 @@
 			else
 				mss->private_clean += PAGE_SIZE;
 		}
+
+		count = page_mapcount(page);
+		if (count)
+			mss->mapped += PAGE_SIZE;
+		if (count > mss->mapcount_max)
+			mss->mapcount_max = count;
+		if (PageAnon(page))
+			mss->anon += PAGE_SIZE;
+		mss->node[page_to_nid(page)] += PAGE_SIZE;
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 	pte_unmap(pte - 1);
 	cond_resched_lock(&vma->vm_mm->page_table_lock);
@@ -246,10 +260,15 @@
 
 static int show_smap(struct seq_file *m, void *v)
 {
+	struct task_struct *task = m->private;
 	struct vm_area_struct *vma = v;
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long vma_len = (vma->vm_end - vma->vm_start);
 	struct mem_size_stats mss;
+#ifdef CONFIG_NUMA
+	int n;
+	char buffer[50];
+#endif
 
 	memset(&mss, 0, sizeof mss);
 
@@ -267,13 +286,28 @@
 		   "Shared_Clean:  %8lu kB\n"
 		   "Shared_Dirty:  %8lu kB\n"
 		   "Private_Clean: %8lu kB\n"
-		   "Private_Dirty: %8lu kB\n",
+		   "Private_Dirty: %8lu kB\n"
+		   "Anonymous:     %8lu kB\n"
+		   "Mapped:        %8lu kB\n"
+		   "MaxMapCount:   %8lu\n",
 		   vma_len >> 10,
 		   mss.resident >> 10,
 		   mss.shared_clean  >> 10,
 		   mss.shared_dirty  >> 10,
 		   mss.private_clean >> 10,
-		   mss.private_dirty >> 10);
+		   mss.private_dirty >> 10,
+		   mss.anon >> 10,
+		   mss.mapped >> 10,
+		   mss.mapcount_max);
+#ifdef CONFIG_NUMA
+	for_each_node(n)
+		if (mss.node[n])
+			seq_printf(m, "Node%-4d:      %8lu kB\n",
+					n, mss.node[n]);
+	if (mpol_to_str(buffer, sizeof(buffer),
+			get_vma_policy(task, vma, vma->vm_start)) >=0)
+		seq_printf(m, "Memory_Policy: %s\n", buffer);
+#endif
 	return 0;
 }
 
