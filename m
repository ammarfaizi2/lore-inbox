Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbWAVWQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWAVWQg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 17:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWAVWQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 17:16:36 -0500
Received: from cs.uml.edu ([129.63.8.2]:6413 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id S932117AbWAVWQf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 17:16:35 -0500
Date: Sun, 22 Jan 2006 17:16:24 -0500 (EST)
Message-Id: <200601222216.k0MMGO67222285@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, arjan@infradead.org
Subject: [PATCH 1/4] pmap: add pmap files
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This adds /proc/*/pmap files for the pmap command.
Besides the /proc/*/smaps content, it adds info related
to locked memory and huge pages. Unlike every other
bit of /proc to date, the format is carefully specified
to be parsable despite future additions.

Signed-off-by: Albert Cahalan <acahalan@gmail.com>

---

This applies to -git4, grabbed Saturday night.


diff -Naurd 0/Documentation/filesystems/proc/pmap 1/Documentation/filesystems/proc/pmap
--- 0/Documentation/filesystems/proc/pmap	1969-12-31 19:00:00.000000000 -0500
+++ 1/Documentation/filesystems/proc/pmap	2006-01-22 03:42:59.000000000 -0500
@@ -0,0 +1,50 @@
+general grammar of a /proc/*/pmap file
+======================================
+
+The file consists of one line of text for every memory mapping.
+Each line consists of several parts, delimited internally and
+from each other by the ' ' (SPACE) character except as described
+otherwise. From left to right the parts of a line are:
+
+1. general fields, supplied for every mapping
+2. a type indicator field
+3. type-specific fields
+4. a filename
+
+No general field will exceed 20 characters. No general field
+will contain '_', '\\', '/', or whitespace. When future
+requirements dictate additional general fields, they will be
+added to the end (between the last existing general field and
+the type indicator field).
+
+The type indicator field will start with the '_' character.
+The remainer will be composed of letters and numbers, but
+will not start with a number. The length will not exceed 8,
+including the leading '_'.
+
+Type-specific fields will not contain whitespace, '/', or '\\'.
+Unlike general fields, they may contain '_'. No type-specific
+field will exceed 20 characters. Type-specific fields will
+vary in both meaning and number according to the type indicator.
+There may be zero type-specific fields.
+
+The filename is encoded with '\\' (BACKSLASH) and '\n' (NEWLINE)
+escaped as in the C language notation used here.
+
+The very first field of the line is itself extendable by adding
+characters to the end. This is not allowed to violate the length
+or character limits for a general field. Each position must have
+a unique character associated with it, and must display as that
+character or as the '-' (HYPHEN) character. This allows parsers
+to rely on either position or character value.
+
+It is expected that parsers may:
+
+a. read general fields into an unprotected 20-byte buffer
+b. scan from the beginning for the '_' to determine type
+c. scan from the beginning for the '/' to find the filename
+d. scan from the beginning for the '\n' to find the end
+e. scan from the beginning using strchr() or similar
+f. scan field by field, skipping unknown fields
+g. parse the first field by character position
+h. parse the first field by characters seen
diff -Naurd 0/Documentation/filesystems/proc.txt 1/Documentation/filesystems/proc.txt
--- 0/Documentation/filesystems/proc.txt	2006-01-21 14:42:13.000000000 -0500
+++ 1/Documentation/filesystems/proc.txt	2006-01-22 03:27:05.000000000 -0500
@@ -134,6 +134,7 @@
  status  Process status in human readable form          
  wchan   If CONFIG_KALLSYMS is set, a pre-decoded wchan
  smaps	 Extension based on maps, presenting the rss size for each mapped file
+ pmap    for pmap command; see Documentation/filesystems/proc/pmap
 ..............................................................................
 
 For example, to get the status information of a process, all you have to do is
diff -Naurd 0/fs/proc/base.c 1/fs/proc/base.c
--- 0/fs/proc/base.c	2006-01-21 14:42:25.000000000 -0500
+++ 1/fs/proc/base.c	2006-01-21 19:45:32.000000000 -0500
@@ -106,6 +106,7 @@
 	PROC_TGID_MOUNTS,
 	PROC_TGID_WCHAN,
 #ifdef CONFIG_MMU
+	PROC_TGID_PMAP,
 	PROC_TGID_SMAPS,
 #endif
 #ifdef CONFIG_SCHEDSTATS
@@ -146,6 +147,7 @@
 	PROC_TID_MOUNTS,
 	PROC_TID_WCHAN,
 #ifdef CONFIG_MMU
+	PROC_TID_PMAP,
 	PROC_TID_SMAPS,
 #endif
 #ifdef CONFIG_SCHEDSTATS
@@ -202,6 +204,7 @@
 	E(PROC_TGID_EXE,       "exe",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TGID_MOUNTS,    "mounts",  S_IFREG|S_IRUGO),
 #ifdef CONFIG_MMU
+	E(PROC_TGID_PMAP,      "pmap",   S_IFREG|S_IRUGO),
 	E(PROC_TGID_SMAPS,     "smaps",   S_IFREG|S_IRUGO),
 #endif
 #ifdef CONFIG_SECURITY
@@ -244,6 +247,7 @@
 	E(PROC_TID_EXE,        "exe",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TID_MOUNTS,     "mounts",  S_IFREG|S_IRUGO),
 #ifdef CONFIG_MMU
+	E(PROC_TID_PMAP,       "pmap",    S_IFREG|S_IRUGO),
 	E(PROC_TID_SMAPS,      "smaps",   S_IFREG|S_IRUGO),
 #endif
 #ifdef CONFIG_SECURITY
@@ -661,6 +665,27 @@
 };
 #endif
 
+#ifdef CONFIG_MMU
+extern struct seq_operations proc_pid_pmap_op;
+static int pmap_open(struct inode *inode, struct file *file)
+{
+	struct task_struct *task = proc_task(inode);
+	int ret = seq_open(file, &proc_pid_pmap_op);
+	if (!ret) {
+		struct seq_file *m = file->private_data;
+		m->private = task;
+	}
+	return ret;
+}
+
+static struct file_operations proc_pmap_operations = {
+	.open		= pmap_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+#endif
+
 extern struct seq_operations mounts_op;
 struct proc_mounts {
 	struct seq_file m;
@@ -1730,6 +1755,12 @@
 			inode->i_fop = &proc_smaps_operations;
 			break;
 #endif
+#ifdef CONFIG_MMU
+		case PROC_TID_PMAP:
+		case PROC_TGID_PMAP:
+			inode->i_fop = &proc_pmap_operations;
+			break;
+#endif
 #ifdef CONFIG_SECURITY
 		case PROC_TID_ATTR:
 			inode->i_nlink = 2;
diff -Naurd 0/fs/proc/task_mmu.c 1/fs/proc/task_mmu.c
--- 0/fs/proc/task_mmu.c	2006-01-21 14:42:25.000000000 -0500
+++ 1/fs/proc/task_mmu.c	2006-01-22 03:16:51.000000000 -0500
@@ -294,6 +294,90 @@
 	return show_map_internal(m, v, &mss);
 }
 
+/* WARNING: unlike other /proc files, this one has a well-defined
+ * grammar to ensure that future changes do not cause parsers to
+ * fail. See the Documentation/filesystems/proc/pmap file for details.
+ */
+static int show_pmap(struct seq_file *m, void *v)
+{
+	struct task_struct *task = m->private;
+	struct vm_area_struct *vma = v;
+	struct mm_struct *mm = vma->vm_mm;
+	struct file *file = vma->vm_file;
+	int flags = vma->vm_flags;
+	unsigned long ino = 0;
+	dev_t dev = 0;
+	struct mem_size_stats mss;
+	char flag_string[7];
+	unsigned shift = PAGE_SHIFT;
+
+	memset(&mss, 0, sizeof mss);
+	if (vma->vm_mm)
+		smaps_pgd_range(vma, vma->vm_start, vma->vm_end, &mss);
+
+	if (file) {
+		struct inode *inode = vma->vm_file->f_dentry->d_inode;
+		dev = inode->i_sb->s_dev;
+		ino = inode->i_ino;
+	}
+
+	flag_string[0] = flags & VM_READ       ? 'r' : '-';
+	flag_string[1] = flags & VM_WRITE      ? 'w' : '-';
+	flag_string[2] = flags & VM_EXEC       ? 'x' : '-';
+	flag_string[3] = flags & VM_MAYSHARE   ? 's' : '-';
+	flag_string[4] = flags & VM_LOCKED     ? 'L' : '-';
+	flag_string[5] = flags & VM_IO         ? 'i' : '-';
+	flag_string[sizeof flag_string - 1] = '\0';
+
+#ifdef HPAGE_SHIFT
+	if(flags & VM_HUGETLB)
+		shift = HPAGE_SHIFT;
+#endif
+
+	seq_printf(
+		m,
+		"%s %lu %lu %lu %u %u %lu %u %lu %lu %lu %lu %lu ",
+		flag_string,
+		vma->vm_start,
+		vma->vm_end,
+		vma->vm_pgoff,
+		MAJOR(dev),
+		MINOR(dev),
+		ino,
+		shift,
+		mss.resident,
+		mss.shared_clean,
+		mss.shared_dirty,
+		mss.private_clean,
+		mss.private_dirty
+	);
+
+	if (file) {
+		seq_puts(m, "_file ");
+		seq_path(m, file->f_vfsmnt, file->f_dentry, "\n");
+	} else {
+		if (mm) {
+			if (vma->vm_start <= mm->start_brk && vma->vm_end >= mm->brk) {
+				seq_puts(m, "_heap");
+			} else {
+				if (vma->vm_start <= mm->start_stack && vma->vm_end >= mm->start_stack) {
+					seq_puts(m, "_stack");
+				} else {
+					seq_puts(m, "_other");
+				}
+			}
+		} else {
+			seq_puts(m, "_vdso");
+		}
+	}
+
+	seq_putc(m, '\n');
+
+	if (m->count < m->size)  /* vma is copied successfully */
+		m->version = (vma != get_gate_vma(task))? vma->vm_start: 0;
+	return 0;
+}
+
 static void *m_start(struct seq_file *m, loff_t *pos)
 {
 	struct task_struct *task = m->private;
@@ -389,6 +473,13 @@
 	.show	= show_smap
 };
 
+struct seq_operations proc_pid_pmap_op = {
+	.start	= m_start,
+	.next	= m_next,
+	.stop	= m_stop,
+	.show	= show_pmap
+};
+
 #ifdef CONFIG_NUMA
 extern int show_numa_map(struct seq_file *m, void *v);
 
