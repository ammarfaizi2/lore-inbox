Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbWAVWRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWAVWRZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 17:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWAVWRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 17:17:25 -0500
Received: from cs.uml.edu ([129.63.8.2]:7693 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id S932129AbWAVWRY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 17:17:24 -0500
Date: Sun, 22 Jan 2006 17:17:13 -0500 (EST)
Message-Id: <200601222217.k0MMHDR9215012@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, arjan@infradead.org
Subject: [PATCH 2/4] pmap: remove smaps files
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes the /proc/*/smaps files, which are obsolete
and very awkward to parse. It's best to do this now, so that apps
don't come to depend on the files. (not that app developers are
likely to use the files at all, given the awful format)

Signed-off-by: Albert Cahalan <acahalan@gmail.com>

---

This applies to -git4, grabbed Saturday night.


diff -Naurd 1/Documentation/filesystems/proc/pmap 2/Documentation/filesystems/proc/pmap
--- 1/Documentation/filesystems/proc/pmap	2006-01-22 03:42:59.000000000 -0500
+++ 2/Documentation/filesystems/proc/pmap	2006-01-22 03:24:43.000000000 -0500
@@ -31,20 +31,11 @@
 The filename is encoded with '\\' (BACKSLASH) and '\n' (NEWLINE)
 escaped as in the C language notation used here.
 
-The very first field of the line is itself extendable by adding
-characters to the end. This is not allowed to violate the length
-or character limits for a general field. Each position must have
-a unique character associated with it, and must display as that
-character or as the '-' (HYPHEN) character. This allows parsers
-to rely on either position or character value.
-
 It is expected that parsers may:
 
-a. read general fields into an unprotected 20-byte buffer
-b. scan from the beginning for the '_' to determine type
-c. scan from the beginning for the '/' to find the filename
-d. scan from the beginning for the '\n' to find the end
-e. scan from the beginning using strchr() or similar
-f. scan field by field, skipping unknown fields
-g. parse the first field by character position
-h. parse the first field by characters seen
+a. scan forward for the '_' to determine type
+b. scan forward for the '/' to find the filename
+c. scan forward for the '\n' to find the end
+d. read general fields into an unprotected 20-byte buffer
+e. scan forward using strchr() or similar
+f. scan forward field by field, skipping unknown fields
diff -Naurd 1/Documentation/filesystems/proc.txt 2/Documentation/filesystems/proc.txt
--- 1/Documentation/filesystems/proc.txt	2006-01-22 03:27:05.000000000 -0500
+++ 2/Documentation/filesystems/proc.txt	2006-01-22 15:17:18.000000000 -0500
@@ -133,7 +133,6 @@
  statm   Process memory status information              
  status  Process status in human readable form          
  wchan   If CONFIG_KALLSYMS is set, a pre-decoded wchan
- smaps	 Extension based on maps, presenting the rss size for each mapped file
  pmap    for pmap command; see Documentation/filesystems/proc/pmap
 ..............................................................................
 
diff -Naurd 1/fs/proc/base.c 2/fs/proc/base.c
--- 1/fs/proc/base.c	2006-01-21 19:45:32.000000000 -0500
+++ 2/fs/proc/base.c	2006-01-22 15:23:13.000000000 -0500
@@ -23,7 +23,7 @@
  *
  *  Embedded Linux Lab - 10LE Instituto Nokia de Tecnologia - INdT
  *
- *  A new process specific entry (smaps) included in /proc. It shows the
+ *  A new process specific entry (pmap) included in /proc. It shows the
  *  size of rss for each memory area. The maps entry lacks information
  *  about physical memory size (rss) for each mapped file, i.e.,
  *  rss information for executables and library files.
@@ -41,10 +41,10 @@
  *  A better way to walks through the page table as suggested by Hugh Dickins.
  *
  *  Simo Piiroinen <simo.piiroinen@nokia.com>:
- *  Smaps information related to shared, private, clean and dirty pages.
+ *  maps information related to shared, private, clean and dirty pages.
  *
  *  Paul Mundt <paul.mundt@nokia.com>:
- *  Overall revision about smaps.
+ *  Overall revision about maps.
  */
 
 #include <asm/uaccess.h>
@@ -107,7 +107,6 @@
 	PROC_TGID_WCHAN,
 #ifdef CONFIG_MMU
 	PROC_TGID_PMAP,
-	PROC_TGID_SMAPS,
 #endif
 #ifdef CONFIG_SCHEDSTATS
 	PROC_TGID_SCHEDSTAT,
@@ -148,7 +147,6 @@
 	PROC_TID_WCHAN,
 #ifdef CONFIG_MMU
 	PROC_TID_PMAP,
-	PROC_TID_SMAPS,
 #endif
 #ifdef CONFIG_SCHEDSTATS
 	PROC_TID_SCHEDSTAT,
@@ -205,7 +203,6 @@
 	E(PROC_TGID_MOUNTS,    "mounts",  S_IFREG|S_IRUGO),
 #ifdef CONFIG_MMU
 	E(PROC_TGID_PMAP,      "pmap",   S_IFREG|S_IRUGO),
-	E(PROC_TGID_SMAPS,     "smaps",   S_IFREG|S_IRUGO),
 #endif
 #ifdef CONFIG_SECURITY
 	E(PROC_TGID_ATTR,      "attr",    S_IFDIR|S_IRUGO|S_IXUGO),
@@ -248,7 +245,6 @@
 	E(PROC_TID_MOUNTS,     "mounts",  S_IFREG|S_IRUGO),
 #ifdef CONFIG_MMU
 	E(PROC_TID_PMAP,       "pmap",    S_IFREG|S_IRUGO),
-	E(PROC_TID_SMAPS,      "smaps",   S_IFREG|S_IRUGO),
 #endif
 #ifdef CONFIG_SECURITY
 	E(PROC_TID_ATTR,       "attr",    S_IFDIR|S_IRUGO|S_IXUGO),
@@ -645,27 +641,6 @@
 #endif
 
 #ifdef CONFIG_MMU
-extern struct seq_operations proc_pid_smaps_op;
-static int smaps_open(struct inode *inode, struct file *file)
-{
-	struct task_struct *task = proc_task(inode);
-	int ret = seq_open(file, &proc_pid_smaps_op);
-	if (!ret) {
-		struct seq_file *m = file->private_data;
-		m->private = task;
-	}
-	return ret;
-}
-
-static struct file_operations proc_smaps_operations = {
-	.open		= smaps_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
-#endif
-
-#ifdef CONFIG_MMU
 extern struct seq_operations proc_pid_pmap_op;
 static int pmap_open(struct inode *inode, struct file *file)
 {
@@ -1750,12 +1725,6 @@
 			inode->i_fop = &proc_mounts_operations;
 			break;
 #ifdef CONFIG_MMU
-		case PROC_TID_SMAPS:
-		case PROC_TGID_SMAPS:
-			inode->i_fop = &proc_smaps_operations;
-			break;
-#endif
-#ifdef CONFIG_MMU
 		case PROC_TID_PMAP:
 		case PROC_TGID_PMAP:
 			inode->i_fop = &proc_pmap_operations;
diff -Naurd 1/fs/proc/task_mmu.c 2/fs/proc/task_mmu.c
--- 1/fs/proc/task_mmu.c	2006-01-22 03:16:51.000000000 -0500
+++ 2/fs/proc/task_mmu.c	2006-01-22 15:20:24.000000000 -0500
@@ -118,7 +118,7 @@
 	unsigned long private_dirty;
 };
 
-static int show_map_internal(struct seq_file *m, void *v, struct mem_size_stats *mss)
+static int show_map(struct seq_file *m, void *v)
 {
 	struct task_struct *task = m->private;
 	struct vm_area_struct *vma = v;
@@ -173,31 +173,11 @@
 	}
 	seq_putc(m, '\n');
 
-	if (mss)
-		seq_printf(m,
-			   "Size:          %8lu kB\n"
-			   "Rss:           %8lu kB\n"
-			   "Shared_Clean:  %8lu kB\n"
-			   "Shared_Dirty:  %8lu kB\n"
-			   "Private_Clean: %8lu kB\n"
-			   "Private_Dirty: %8lu kB\n",
-			   (vma->vm_end - vma->vm_start) >> 10,
-			   mss->resident >> 10,
-			   mss->shared_clean  >> 10,
-			   mss->shared_dirty  >> 10,
-			   mss->private_clean >> 10,
-			   mss->private_dirty >> 10);
-
 	if (m->count < m->size)  /* vma is copied successfully */
 		m->version = (vma != get_gate_vma(task))? vma->vm_start: 0;
 	return 0;
 }
 
-static int show_map(struct seq_file *m, void *v)
-{
-	return show_map_internal(m, v, NULL);
-}
-
 static void smaps_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				unsigned long addr, unsigned long end,
 				struct mem_size_stats *mss)
@@ -283,17 +263,6 @@
 	} while (pgd++, addr = next, addr != end);
 }
 
-static int show_smap(struct seq_file *m, void *v)
-{
-	struct vm_area_struct *vma = v;
-	struct mem_size_stats mss;
-
-	memset(&mss, 0, sizeof mss);
-	if (vma->vm_mm)
-		smaps_pgd_range(vma, vma->vm_start, vma->vm_end, &mss);
-	return show_map_internal(m, v, &mss);
-}
-
 /* WARNING: unlike other /proc files, this one has a well-defined
  * grammar to ensure that future changes do not cause parsers to
  * fail. See the Documentation/filesystems/proc/pmap file for details.
@@ -466,13 +435,6 @@
 	.show	= show_map
 };
 
-struct seq_operations proc_pid_smaps_op = {
-	.start	= m_start,
-	.next	= m_next,
-	.stop	= m_stop,
-	.show	= show_smap
-};
-
 struct seq_operations proc_pid_pmap_op = {
 	.start	= m_start,
 	.next	= m_next,
