Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbUKHPoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbUKHPoZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 10:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbUKHPoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 10:44:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:23747 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261874AbUKHOf1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 09:35:27 -0500
Date: Mon, 8 Nov 2004 14:34:20 GMT
Message-Id: <200411081434.iA8EYKK8023621@warthog.cambridge.redhat.com>
From: dhowells@redhat.com
To: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com
cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH 18/20] FRV: procfs changes for nommu changes
In-Reply-To: <44bd214c-3193-11d9-8962-0002b3163499@redhat.com> 
References: <44bd214c-3193-11d9-8962-0002b3163499@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch splits some memory-related procfs files into MMU and !MMU
versions and places them in separate conditionally-compiled files. A header
file local to the fs/proc/ directory is used to declare functions and the like.

Additionally, a !MMU-only proc file (/proc/maps) is provided so that master VMA
list in a uClinux kernel is viewable.

Signed-Off-By: dhowells@redhat.com
---
diffstat nommu-proc-2610rc1mm3.diff
 Makefile     |    4 -
 array.c      |    1 
 base.c       |   43 ------------------
 internal.h   |   48 ++++++++++++++++++++
 mmu.c        |   67 ++++++++++++++++++++++++++++
 nommu.c      |  140 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 proc_misc.c  |   50 ++-------------------
 task_mmu.c   |   32 +++++++++++++
 task_nommu.c |   71 ++++++++++++++++++++++-------
 9 files changed, 350 insertions(+), 106 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/fs/proc/array.c linux-2.6.10-rc1-mm3-frv/fs/proc/array.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/fs/proc/array.c	2004-11-05 13:15:43.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/fs/proc/array.c	2004-11-05 14:13:03.809503712 +0000
@@ -79,6 +79,7 @@
 #include <asm/pgtable.h>
 #include <asm/io.h>
 #include <asm/processor.h>
+#include "internal.h"
 
 /* Gcc optimizes away "strlen(x)" for constant x */
 #define ADDBUF(buffer, string) \
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/fs/proc/base.c linux-2.6.10-rc1-mm3-frv/fs/proc/base.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/fs/proc/base.c	2004-11-05 13:15:43.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/fs/proc/base.c	2004-11-05 14:13:03.825502360 +0000
@@ -33,6 +33,7 @@
 #include <linux/mount.h>
 #include <linux/security.h>
 #include <linux/ptrace.h>
+#include "internal.h"
 
 /*
  * For hysterical raisins we keep the same inumbers as in the old procfs.
@@ -192,21 +193,6 @@ static struct pid_entry tid_attr_stuff[]
 
 #undef E
 
-static inline struct task_struct *proc_task(struct inode *inode)
-{
-	return PROC_I(inode)->task;
-}
-
-static inline int proc_type(struct inode *inode)
-{
-	return PROC_I(inode)->type;
-}
-
-int proc_tid_stat(struct task_struct*,char*);
-int proc_tgid_stat(struct task_struct*,char*);
-int proc_pid_status(struct task_struct*,char*);
-int proc_pid_statm(struct task_struct*,char*);
-
 static int proc_fd_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
 {
 	struct task_struct *task = proc_task(inode);
@@ -231,33 +217,6 @@ static int proc_fd_link(struct inode *in
 	return -ENOENT;
 }
 
-static int proc_exe_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
-{
-	struct vm_area_struct * vma;
-	int result = -ENOENT;
-	struct task_struct *task = proc_task(inode);
-	struct mm_struct * mm = get_task_mm(task);
-
-	if (!mm)
-		goto out;
-	down_read(&mm->mmap_sem);
-	vma = mm->mmap;
-	while (vma) {
-		if ((vma->vm_flags & VM_EXECUTABLE) && 
-		    vma->vm_file) {
-			*mnt = mntget(vma->vm_file->f_vfsmnt);
-			*dentry = dget(vma->vm_file->f_dentry);
-			result = 0;
-			break;
-		}
-		vma = vma->vm_next;
-	}
-	up_read(&mm->mmap_sem);
-	mmput(mm);
-out:
-	return result;
-}
-
 static int proc_cwd_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
 {
 	struct fs_struct *fs;
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/fs/proc/internal.h linux-2.6.10-rc1-mm3-frv/fs/proc/internal.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/fs/proc/internal.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/fs/proc/internal.h	2004-11-05 14:13:03.830501938 +0000
@@ -0,0 +1,48 @@
+/* internal.h: internal procfs definitions
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/proc_fs.h>
+
+struct vmalloc_info {
+	unsigned long	used;
+	unsigned long	largest_chunk;
+};
+
+#ifdef CONFIG_MMU
+#define VMALLOC_TOTAL (VMALLOC_END - VMALLOC_START)
+extern void get_vmalloc_info(struct vmalloc_info *vmi);
+#else
+
+#define VMALLOC_TOTAL 0UL
+#define get_vmalloc_info(vmi)			\
+do {						\
+	(vmi)->used = 0;			\
+	(vmi)->largest_chunk = 0;		\
+} while(0)
+
+#endif
+
+extern void create_seq_entry(char *name, mode_t mode, struct file_operations *f);
+extern int proc_exe_link(struct inode *, struct dentry **, struct vfsmount **);
+extern int proc_tid_stat(struct task_struct *,  char *);
+extern int proc_tgid_stat(struct task_struct *, char *);
+extern int proc_pid_status(struct task_struct *, char *);
+extern int proc_pid_statm(struct task_struct *, char *);
+
+static inline struct task_struct *proc_task(struct inode *inode)
+{
+	return PROC_I(inode)->task;
+}
+
+static inline int proc_type(struct inode *inode)
+{
+	return PROC_I(inode)->type;
+}
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/fs/proc/Makefile linux-2.6.10-rc1-mm3-frv/fs/proc/Makefile
--- /warthog/kernels/linux-2.6.10-rc1-mm3/fs/proc/Makefile	2004-11-05 13:15:43.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/fs/proc/Makefile	2004-11-05 14:13:03.839501178 +0000
@@ -4,8 +4,8 @@
 
 obj-$(CONFIG_PROC_FS) += proc.o
 
-proc-y			:= task_nommu.o
-proc-$(CONFIG_MMU)	:= task_mmu.o
+proc-y			:= nommu.o task_nommu.o
+proc-$(CONFIG_MMU)	:= mmu.o task_mmu.o
 
 proc-y       += inode.o root.o base.o generic.o array.o \
 		kmsg.o proc_tty.o proc_misc.o
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/fs/proc/mmu.c linux-2.6.10-rc1-mm3-frv/fs/proc/mmu.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/fs/proc/mmu.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/fs/proc/mmu.c	2004-11-05 14:13:03.000000000 +0000
@@ -0,0 +1,67 @@
+/* mmu.c: mmu memory info files
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/time.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/mman.h>
+#include <linux/proc_fs.h>
+#include <linux/mm.h>
+#include <linux/mmzone.h>
+#include <linux/pagemap.h>
+#include <linux/swap.h>
+#include <linux/slab.h>
+#include <linux/smp.h>
+#include <linux/seq_file.h>
+#include <linux/hugetlb.h>
+#include <linux/vmalloc.h>
+#include <asm/uaccess.h>
+#include <asm/pgtable.h>
+#include <asm/tlb.h>
+#include <asm/div64.h>
+#include "internal.h"
+
+void get_vmalloc_info(struct vmalloc_info *vmi)
+{
+	struct vm_struct *vma;
+	unsigned long free_area_size;
+	unsigned long prev_end;
+
+	vmi->used = 0;
+
+	if (!vmlist) {
+		vmi->largest_chunk = VMALLOC_TOTAL;
+	}
+	else {
+		vmi->largest_chunk = 0;
+
+		prev_end = VMALLOC_START;
+
+		read_lock(&vmlist_lock);
+
+		for (vma = vmlist; vma; vma = vma->next) {
+			vmi->used += vma->size;
+
+			free_area_size = (unsigned long) vma->addr - prev_end;
+			if (vmi->largest_chunk < free_area_size)
+				vmi->largest_chunk = free_area_size;
+
+			prev_end = vma->size + (unsigned long) vma->addr;
+		}
+
+		if (VMALLOC_END - prev_end > vmi->largest_chunk)
+			vmi->largest_chunk = VMALLOC_END - prev_end;
+
+		read_unlock(&vmlist_lock);
+	}
+}
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/fs/proc/nommu.c linux-2.6.10-rc1-mm3-frv/fs/proc/nommu.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/fs/proc/nommu.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/fs/proc/nommu.c	2004-11-05 14:13:03.000000000 +0000
@@ -0,0 +1,140 @@
+/* nommu.c: mmu-less memory info files
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/time.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/mman.h>
+#include <linux/proc_fs.h>
+#include <linux/mm.h>
+#include <linux/mmzone.h>
+#include <linux/pagemap.h>
+#include <linux/swap.h>
+#include <linux/slab.h>
+#include <linux/smp.h>
+#include <linux/seq_file.h>
+#include <linux/hugetlb.h>
+#include <linux/vmalloc.h>
+#include <asm/uaccess.h>
+#include <asm/pgtable.h>
+#include <asm/tlb.h>
+#include <asm/div64.h>
+#include "internal.h"
+
+/*
+ * display a list of all the VMAs the kernel knows about
+ * - nommu kernals have a single flat list
+ */
+static int nommu_vma_list_show(struct seq_file *m, void *v)
+{
+	struct vm_area_struct *map;
+	unsigned long ino = 0;
+	struct file *file;
+	dev_t dev = 0;
+	int flags, len;
+
+	map = list_entry((struct list_head *) v,
+			 struct vm_area_struct, vm_link);
+
+	flags = map->vm_flags;
+	file = map->vm_file;
+
+	if (file) {
+		struct inode *inode = map->vm_file->f_dentry->d_inode;
+		dev = inode->i_sb->s_dev;
+		ino = inode->i_ino;
+	}
+
+	seq_printf(m,
+		   "%08lx-%08lx %c%c%c%c %08lx %02x:%02x %lu %n",
+		   map->vm_start,
+		   map->vm_end,
+		   flags & VM_READ ? 'r' : '-',
+		   flags & VM_WRITE ? 'w' : '-',
+		   flags & VM_EXEC ? 'x' : '-',
+		   flags & VM_MAYSHARE ? 's' : 'p',
+		   map->vm_pgoff << PAGE_SHIFT,
+		   MAJOR(dev), MINOR(dev), ino, &len);
+
+	if (file) {
+		len = 25 + sizeof(void *) * 6 - len;
+		if (len < 1)
+			len = 1;
+		seq_printf(m, "%*c", len, ' ');
+		seq_path(m, file->f_vfsmnt, file->f_dentry, "");
+	}
+
+	seq_putc(m, '\n');
+	return 0;
+}
+
+static void *nommu_vma_list_start(struct seq_file *m, loff_t *_pos)
+{
+	struct list_head *_p;
+	loff_t pos = *_pos;
+	void *next = NULL;
+
+	down_read(&nommu_vma_sem);
+
+	list_for_each(_p, &nommu_vma_list) {
+		if (pos == 0) {
+			next = _p;
+			break;
+		}
+	}
+
+	return next;
+}
+
+static void nommu_vma_list_stop(struct seq_file *m, void *v)
+{
+	up_read(&nommu_vma_sem);
+}
+
+static void *nommu_vma_list_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct list_head *_p = v;
+
+	(*pos)++;
+
+	_p = _p->next;
+	return (_p != &nommu_vma_list) ? _p : NULL;
+}
+
+static struct seq_operations proc_nommu_vma_list_seqop = {
+	.start	= nommu_vma_list_start,
+	.next	= nommu_vma_list_next,
+	.stop	= nommu_vma_list_stop,
+	.show	= nommu_vma_list_show
+};
+
+static int proc_nommu_vma_list_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &proc_nommu_vma_list_seqop);
+}
+
+static struct file_operations proc_nommu_vma_list_operations = {
+	.open    = proc_nommu_vma_list_open,
+	.read    = seq_read,
+	.llseek  = seq_lseek,
+	.release = seq_release,
+};
+
+static int __init proc_nommu_init(void)
+{
+	create_seq_entry("maps", S_IRUGO, &proc_nommu_vma_list_operations);
+	return 0;
+}
+
+module_init(proc_nommu_init);
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/fs/proc/proc_misc.c linux-2.6.10-rc1-mm3-frv/fs/proc/proc_misc.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/fs/proc/proc_misc.c	2004-11-05 13:15:43.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/fs/proc/proc_misc.c	2004-11-05 14:13:03.865498982 +0000
@@ -50,6 +50,7 @@
 #include <asm/io.h>
 #include <asm/tlb.h>
 #include <asm/div64.h>
+#include "internal.h"
 
 #define LOAD_INT(x) ((x) >> FSHIFT)
 #define LOAD_FRAC(x) LOAD_INT(((x) & (FIXED_1-1)) * 100)
@@ -96,41 +97,6 @@ static int loadavg_read_proc(char *page,
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
-struct vmalloc_info {
-	unsigned long used;
-	unsigned long largest_chunk;
-};
-
-static struct vmalloc_info get_vmalloc_info(void)
-{
-	unsigned long prev_end = VMALLOC_START;
-	struct vm_struct* vma;
-	struct vmalloc_info vmi;
-	vmi.used = 0;
-
-	read_lock(&vmlist_lock);
-
-	if(!vmlist)
-		vmi.largest_chunk = (VMALLOC_END-VMALLOC_START);
-	else
-		vmi.largest_chunk = 0;
-
-	for (vma = vmlist; vma; vma = vma->next) {
-		unsigned long free_area_size =
-			(unsigned long)vma->addr - prev_end;
-		vmi.used += vma->size;
-		if (vmi.largest_chunk < free_area_size )
-
-			vmi.largest_chunk = free_area_size;
-		prev_end = vma->size + (unsigned long)vma->addr;
-	}
-	if(VMALLOC_END-prev_end > vmi.largest_chunk)
-		vmi.largest_chunk = VMALLOC_END-prev_end;
-
-	read_unlock(&vmlist_lock);
-	return vmi;
-}
-
 static int uptime_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
@@ -159,7 +125,6 @@ static int meminfo_read_proc(char *page,
 	unsigned long inactive;
 	unsigned long active;
 	unsigned long free;
-	unsigned long vmtot;
 	unsigned long committed;
 	unsigned long allowed;
 	struct vmalloc_info vmi;
@@ -177,10 +142,7 @@ static int meminfo_read_proc(char *page,
 	allowed = ((totalram_pages - hugetlb_total_pages())
 		* sysctl_overcommit_ratio / 100) + total_swap_pages;
 
-	vmtot = (VMALLOC_END-VMALLOC_START)>>10;
-	vmi = get_vmalloc_info();
-	vmi.used >>= 10;
-	vmi.largest_chunk >>= 10;
+	get_vmalloc_info(&vmi);
 
 	/*
 	 * Tagged format, for easy grepping and expansion.
@@ -229,9 +191,9 @@ static int meminfo_read_proc(char *page,
 		K(allowed),
 		K(committed),
 		K(ps.nr_page_table_pages),
-		vmtot,
-		vmi.used,
-		vmi.largest_chunk
+		VMALLOC_TOTAL >> 10,
+		vmi.used >> 10,
+		vmi.largest_chunk >> 10
 		);
 
 		len += hugetlb_report_meminfo(page + len);
@@ -578,7 +539,7 @@ static struct file_operations proc_sysrq
 
 struct proc_dir_entry *proc_root_kcore;
 
-static void create_seq_entry(char *name, mode_t mode, struct file_operations *f)
+void create_seq_entry(char *name, mode_t mode, struct file_operations *f)
 {
 	struct proc_dir_entry *entry;
 	entry = create_proc_entry(name, mode, NULL);
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/fs/proc/task_mmu.c linux-2.6.10-rc1-mm3-frv/fs/proc/task_mmu.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/fs/proc/task_mmu.c	2004-11-05 13:15:44.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/fs/proc/task_mmu.c	2004-11-05 14:13:03.000000000 +0000
@@ -1,8 +1,10 @@
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
+#include <linux/mount.h>
 #include <linux/seq_file.h>
 #include <asm/elf.h>
 #include <asm/uaccess.h>
+#include "internal.h"
 
 char *task_mem(struct mm_struct *mm, char *buffer)
 {
@@ -45,6 +47,36 @@ int task_statm(struct mm_struct *mm, int
 	return mm->total_vm;
 }
 
+int proc_exe_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
+{
+	struct vm_area_struct * vma;
+	int result = -ENOENT;
+	struct task_struct *task = proc_task(inode);
+	struct mm_struct * mm = get_task_mm(task);
+
+	if (!mm)
+		goto out;
+	down_read(&mm->mmap_sem);
+
+	vma = mm->mmap;
+	while (vma) {
+		if ((vma->vm_flags & VM_EXECUTABLE) && vma->vm_file)
+			break;
+		vma = vma->vm_next;
+	}
+
+	if (vma) {
+		*mnt = mntget(vma->vm_file->f_vfsmnt);
+		*dentry = dget(vma->vm_file->f_dentry);
+		result = 0;
+	}
+
+	up_read(&mm->mmap_sem);
+	mmput(mm);
+out:
+	return result;
+}
+
 static int show_map(struct seq_file *m, void *v)
 {
 	struct vm_area_struct *map = v;
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/fs/proc/task_nommu.c linux-2.6.10-rc1-mm3-frv/fs/proc/task_nommu.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/fs/proc/task_nommu.c	2004-10-19 10:42:09.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/fs/proc/task_nommu.c	2004-11-05 14:13:03.000000000 +0000
@@ -1,7 +1,9 @@
 
 #include <linux/mm.h>
 #include <linux/file.h>
+#include <linux/mount.h>
 #include <linux/seq_file.h>
+#include "internal.h"
 
 /*
  * Logic: we've got two memory sums for each process, "shared", and
@@ -15,19 +17,19 @@ char *task_mem(struct mm_struct *mm, cha
 	struct mm_tblock_struct *tblock;
         
 	down_read(&mm->mmap_sem);
-	for (tblock = &mm->context.tblock; tblock; tblock = tblock->next) {
-		if (!tblock->rblock)
+	for (tblock = mm->context.tblock; tblock; tblock = tblock->next) {
+		if (!tblock->vma)
 			continue;
 		bytes += kobjsize(tblock);
 		if (atomic_read(&mm->mm_count) > 1 ||
-		    tblock->rblock->refcount > 1) {
-			sbytes += kobjsize(tblock->rblock->kblock);
-			sbytes += kobjsize(tblock->rblock);
+		    atomic_read(&tblock->vma->vm_usage) > 1) {
+			sbytes += kobjsize((void *) tblock->vma->vm_start);
+			sbytes += kobjsize(tblock->vma);
 		} else {
-			bytes += kobjsize(tblock->rblock->kblock);
-			bytes += kobjsize(tblock->rblock);
-			slack += kobjsize(tblock->rblock->kblock) -
-					tblock->rblock->size;
+			bytes += kobjsize((void *) tblock->vma->vm_start);
+			bytes += kobjsize(tblock->vma);
+			slack += kobjsize((void *) tblock->vma->vm_start) -
+				(tblock->vma->vm_end - tblock->vma->vm_start);
 		}
 	}
 
@@ -69,9 +71,9 @@ unsigned long task_vsize(struct mm_struc
 	unsigned long vsize = 0;
 
 	down_read(&mm->mmap_sem);
-	for (tbp = &mm->context.tblock; tbp; tbp = tbp->next) {
-		if (tbp->rblock)
-			vsize += kobjsize(tbp->rblock->kblock);
+	for (tbp = mm->context.tblock; tbp; tbp = tbp->next) {
+		if (tbp->vma)
+			vsize += kobjsize((void *) tbp->vma->vm_start);
 	}
 	up_read(&mm->mmap_sem);
 	return vsize;
@@ -84,12 +86,11 @@ int task_statm(struct mm_struct *mm, int
 	int size = kobjsize(mm);
 
 	down_read(&mm->mmap_sem);
-	for (tbp = &mm->context.tblock; tbp; tbp = tbp->next) {
-		if (tbp->next)
-			size += kobjsize(tbp->next);
-		if (tbp->rblock) {
-			size += kobjsize(tbp->rblock);
-			size += kobjsize(tbp->rblock->kblock);
+	for (tbp = mm->context.tblock; tbp; tbp = tbp->next) {
+		size += kobjsize(tbp);
+		if (tbp->vma) {
+			size += kobjsize(tbp->vma);
+			size += kobjsize((void *) tbp->vma->vm_start);
 		}
 	}
 
@@ -100,6 +101,40 @@ int task_statm(struct mm_struct *mm, int
 	return size;
 }
 
+int proc_exe_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
+{
+	struct mm_tblock_struct *tblock;
+	struct vm_area_struct * vma;
+	int result = -ENOENT;
+	struct task_struct *task = proc_task(inode);
+	struct mm_struct * mm = get_task_mm(task);
+
+	if (!mm)
+		goto out;
+	down_read(&mm->mmap_sem);
+
+	tblock = mm->context.tblock;
+	vma = NULL;
+	while (tblock) {
+		if ((tblock->vma->vm_flags & VM_EXECUTABLE) && tblock->vma->vm_file) {
+			vma = tblock->vma;
+			break;
+		}
+		tblock = tblock->next;
+	}
+
+	if (vma) {
+		*mnt = mntget(vma->vm_file->f_vfsmnt);
+		*dentry = dget(vma->vm_file->f_dentry);
+		result = 0;
+	}
+
+	up_read(&mm->mmap_sem);
+	mmput(mm);
+out:
+	return result;
+}
+
 /*
  * Albert D. Cahalan suggested to fake entries for the traditional
  * sections here.  This might be worth investigating.
