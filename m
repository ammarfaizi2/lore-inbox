Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262708AbVG2Svu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262708AbVG2Svu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 14:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbVG2Svu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 14:51:50 -0400
Received: from graphe.net ([209.204.138.32]:53911 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262706AbVG2Svh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 14:51:37 -0400
Date: Fri, 29 Jul 2005 11:51:34 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: linux-kernel@vger.kernel.org
Subject: [PATCH] rename smaps -> emaps?
Message-ID: <Pine.LNX.4.62.0507291149290.4049@graphe.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe we should rename smaps to emaps? After all they include more 
information than just sizes. So extended maps would be better.

Patch on top of mm and the numa_maps merge into smap.

Signed-off-by: Christoph Lameter <christoph@lameter.com>

Index: linux-2.6.13-rc3-mm3/fs/proc/base.c
===================================================================
--- linux-2.6.13-rc3-mm3.orig/fs/proc/base.c	2005-07-29 10:38:22.000000000 -0700
+++ linux-2.6.13-rc3-mm3/fs/proc/base.c	2005-07-29 11:46:33.000000000 -0700
@@ -45,6 +45,9 @@
  *
  *  Paul Mundt <paul.mundt@nokia.com>:
  *  Overall revision about smaps.
+ *
+ *  Christoph Lameter <christoph@lameter.com> Silicon Graphics Inc.
+ *  Add NUMA and mapping related output. Renamed to emaps.
  */
 
 #include <asm/uaccess.h>
@@ -103,7 +106,7 @@
 	PROC_TGID_NUMA_MAPS,
 	PROC_TGID_MOUNTS,
 	PROC_TGID_WCHAN,
-	PROC_TGID_SMAPS,
+	PROC_TGID_EMAPS,
 #ifdef CONFIG_SCHEDSTATS
 	PROC_TGID_SCHEDSTAT,
 #endif
@@ -142,7 +145,7 @@
 	PROC_TID_NUMA_MAPS,
 	PROC_TID_MOUNTS,
 	PROC_TID_WCHAN,
-	PROC_TID_SMAPS,
+	PROC_TID_EMAPS,
 #ifdef CONFIG_SCHEDSTATS
 	PROC_TID_SCHEDSTAT,
 #endif
@@ -198,7 +201,7 @@
 	E(PROC_TGID_ROOT,      "root",    S_IFLNK|S_IRWXUGO),
 	E(PROC_TGID_EXE,       "exe",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TGID_MOUNTS,    "mounts",  S_IFREG|S_IRUGO),
-	E(PROC_TGID_SMAPS,     "smaps",   S_IFREG|S_IRUGO),
+	E(PROC_TGID_EMAPS,     "emaps",   S_IFREG|S_IRUGO),
 #ifdef CONFIG_SECURITY
 	E(PROC_TGID_ATTR,      "attr",    S_IFDIR|S_IRUGO|S_IXUGO),
 #endif
@@ -241,7 +244,7 @@
 	E(PROC_TID_ROOT,       "root",    S_IFLNK|S_IRWXUGO),
 	E(PROC_TID_EXE,        "exe",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TID_MOUNTS,     "mounts",  S_IFREG|S_IRUGO),
-	E(PROC_TID_SMAPS,      "smaps",   S_IFREG|S_IRUGO),
+	E(PROC_TID_EMAPS,      "emaps",   S_IFREG|S_IRUGO),
 #ifdef CONFIG_SECURITY
 	E(PROC_TID_ATTR,       "attr",    S_IFDIR|S_IRUGO|S_IXUGO),
 #endif
@@ -593,11 +596,11 @@
 };
 #endif
 
-extern struct seq_operations proc_pid_smaps_op;
-static int smaps_open(struct inode *inode, struct file *file)
+extern struct seq_operations proc_pid_emaps_op;
+static int emaps_open(struct inode *inode, struct file *file)
 {
 	struct task_struct *task = proc_task(inode);
-	int ret = seq_open(file, &proc_pid_smaps_op);
+	int ret = seq_open(file, &proc_pid_emaps_op);
 	if (!ret) {
 		struct seq_file *m = file->private_data;
 		m->private = task;
@@ -605,8 +608,8 @@
 	return ret;
 }
 
-static struct file_operations proc_smaps_operations = {
-	.open		= smaps_open,
+static struct file_operations proc_emaps_operations = {
+	.open		= emaps_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
 	.release	= seq_release,
@@ -1644,9 +1647,9 @@
 		case PROC_TGID_MOUNTS:
 			inode->i_fop = &proc_mounts_operations;
 			break;
-		case PROC_TID_SMAPS:
-		case PROC_TGID_SMAPS:
-			inode->i_fop = &proc_smaps_operations;
+		case PROC_TID_EMAPS:
+		case PROC_TGID_EMAPS:
+			inode->i_fop = &proc_emaps_operations;
 			break;
 #ifdef CONFIG_SECURITY
 		case PROC_TID_ATTR:
Index: linux-2.6.13-rc3-mm3/fs/proc/task_mmu.c
===================================================================
--- linux-2.6.13-rc3-mm3.orig/fs/proc/task_mmu.c	2005-07-29 11:42:19.000000000 -0700
+++ linux-2.6.13-rc3-mm3/fs/proc/task_mmu.c	2005-07-29 11:44:19.000000000 -0700
@@ -164,7 +164,7 @@
 	unsigned long node[MAX_NUMNODES];
 };
 
-static void smaps_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
+static void emaps_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				unsigned long addr, unsigned long end,
 				struct mem_size_stats *mss)
 {
@@ -210,7 +210,7 @@
 	cond_resched_lock(&vma->vm_mm->page_table_lock);
 }
 
-static inline void smaps_pmd_range(struct vm_area_struct *vma, pud_t *pud,
+static inline void emaps_pmd_range(struct vm_area_struct *vma, pud_t *pud,
 				unsigned long addr, unsigned long end,
 				struct mem_size_stats *mss)
 {
@@ -222,11 +222,11 @@
 		next = pmd_addr_end(addr, end);
 		if (pmd_none_or_clear_bad(pmd))
 			continue;
-		smaps_pte_range(vma, pmd, addr, next, mss);
+		emaps_pte_range(vma, pmd, addr, next, mss);
 	} while (pmd++, addr = next, addr != end);
 }
 
-static inline void smaps_pud_range(struct vm_area_struct *vma, pgd_t *pgd,
+static inline void emaps_pud_range(struct vm_area_struct *vma, pgd_t *pgd,
 				unsigned long addr, unsigned long end,
 				struct mem_size_stats *mss)
 {
@@ -238,11 +238,11 @@
 		next = pud_addr_end(addr, end);
 		if (pud_none_or_clear_bad(pud))
 			continue;
-		smaps_pmd_range(vma, pud, addr, next, mss);
+		emaps_pmd_range(vma, pud, addr, next, mss);
 	} while (pud++, addr = next, addr != end);
 }
 
-static inline void smaps_pgd_range(struct vm_area_struct *vma,
+static inline void emaps_pgd_range(struct vm_area_struct *vma,
 				unsigned long addr, unsigned long end,
 				struct mem_size_stats *mss)
 {
@@ -254,11 +254,11 @@
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
-		smaps_pud_range(vma, pgd, addr, next, mss);
+		emaps_pud_range(vma, pgd, addr, next, mss);
 	} while (pgd++, addr = next, addr != end);
 }
 
-static int show_smap(struct seq_file *m, void *v)
+static int show_emap(struct seq_file *m, void *v)
 {
 	struct task_struct *task = m->private;
 	struct vm_area_struct *vma = v;
@@ -276,7 +276,7 @@
 
 	if (mm) {
 		spin_lock(&mm->page_table_lock);
-		smaps_pgd_range(vma, vma->vm_start, vma->vm_end, &mss);
+		emaps_pgd_range(vma, vma->vm_start, vma->vm_end, &mss);
 		spin_unlock(&mm->page_table_lock);
 	}
 
@@ -399,11 +399,11 @@
 	.show	= show_map
 };
 
-struct seq_operations proc_pid_smaps_op = {
+struct seq_operations proc_pid_emaps_op = {
 	.start	= m_start,
 	.next	= m_next,
 	.stop	= m_stop,
-	.show	= show_smap
+	.show	= show_emap
 };
 
 #ifdef CONFIG_NUMA
