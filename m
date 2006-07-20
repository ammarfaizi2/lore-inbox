Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030301AbWGTMH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbWGTMH4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 08:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbWGTMH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 08:07:56 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:39139 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1030282AbWGTMHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 08:07:55 -0400
Date: Thu, 20 Jul 2006 15:07:30 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: alan@lxorguk.ukuu.org.uk, tytso@mit.edu
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC/PATCH] revoke/frevoke system calls
Message-ID: <Pine.LNX.4.58.0607201504040.18901@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch implements the revoke(2) and frevoke(2) system calls for all
types of files. We revoke files in two passes: first we scan all open 
files that refer to the inode and substitute the struct file pointer in fd 
table with NULL causing all subsequent operations on that fd to fail. 
After we have done that to all file descriptors, we close the files and 
take down mmaps.

Note that now we need to unconditionally do fput/fget in sys_write and
sys_read because they race with do_revoke.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 arch/i386/kernel/syscall_table.S |    2 
 fs/Makefile                      |    2 
 fs/read_write.c                  |   10 -
 fs/revoke.c                      |  207 +++++++++++++++++++++++++++++++++++++++
 include/asm-i386/unistd.h        |    4 
 include/linux/syscalls.h         |    3 
 6 files changed, 220 insertions(+), 8 deletions(-)

Index: 2.6/arch/i386/kernel/syscall_table.S
===================================================================
--- 2.6.orig/arch/i386/kernel/syscall_table.S
+++ 2.6/arch/i386/kernel/syscall_table.S
@@ -317,3 +317,5 @@ ENTRY(sys_call_table)
 	.long sys_tee			/* 315 */
 	.long sys_vmsplice
 	.long sys_move_pages
+	.long sys_revoke
+	.long sys_frevoke
Index: 2.6/fs/Makefile
===================================================================
--- 2.6.orig/fs/Makefile
+++ 2.6/fs/Makefile
@@ -10,7 +10,7 @@ obj-y :=	open.o read_write.o file_table.
 		ioctl.o readdir.o select.o fifo.o locks.o dcache.o inode.o \
 		attr.o bad_inode.o file.o filesystems.o namespace.o aio.o \
 		seq_file.o xattr.o libfs.o fs-writeback.o mpage.o direct-io.o \
-		ioprio.o pnode.o drop_caches.o splice.o sync.o
+		ioprio.o pnode.o drop_caches.o splice.o sync.o revoke.o
 
 obj-$(CONFIG_INOTIFY)		+= inotify.o
 obj-$(CONFIG_INOTIFY_USER)	+= inotify_user.o
Index: 2.6/fs/read_write.c
===================================================================
--- 2.6.orig/fs/read_write.c
+++ 2.6/fs/read_write.c
@@ -343,14 +343,13 @@ asmlinkage ssize_t sys_read(unsigned int
 {
 	struct file *file;
 	ssize_t ret = -EBADF;
-	int fput_needed;
 
-	file = fget_light(fd, &fput_needed);
+	file = fget(fd);
 	if (file) {
 		loff_t pos = file_pos_read(file);
 		ret = vfs_read(file, buf, count, &pos);
 		file_pos_write(file, pos);
-		fput_light(file, fput_needed);
+		fput(file);
 	}
 
 	return ret;
@@ -361,14 +360,13 @@ asmlinkage ssize_t sys_write(unsigned in
 {
 	struct file *file;
 	ssize_t ret = -EBADF;
-	int fput_needed;
 
-	file = fget_light(fd, &fput_needed);
+	file = fget(fd);
 	if (file) {
 		loff_t pos = file_pos_read(file);
 		ret = vfs_write(file, buf, count, &pos);
 		file_pos_write(file, pos);
-		fput_light(file, fput_needed);
+		fput(file);
 	}
 
 	return ret;
Index: 2.6/fs/revoke.c
===================================================================
--- /dev/null
+++ 2.6/fs/revoke.c
@@ -0,0 +1,207 @@
+/*
+ * fs/revoke.c - Invalidate all current open file descriptors of an inode.
+ *
+ * Copyright (C) 2006 Pekka Enberg
+ *
+ * This file is released under the GPLv2.
+ */
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/namei.h>
+#include <linux/mm.h>
+#include <linux/sched.h>
+
+/*
+ * Auxiliary struct for keeping track of revoked files.
+ */
+struct revoked_file {
+	struct file *file;
+	struct task_struct *owner;
+	struct list_head list_node;
+};
+
+/*
+ * 	LOCKING: task_lock(owner)
+ */
+static int revoke_files(struct task_struct *owner, struct inode *inode,
+			struct file *exclude, struct list_head *to_close)
+{
+	int err = 0;
+	struct files_struct *files;
+	struct fdtable *fdt;
+	unsigned int fd;
+
+	files = owner->files;
+	spin_lock(&files->file_lock);
+
+	fdt = files_fdtable(files);
+	for (fd = 0; fd < fdt->max_fds; fd++) {
+		struct file *file;
+		struct revoked_file *revoked;
+
+		file = fcheck_files(files, fd);
+		if (!file)
+			continue;
+
+		if (file == exclude)
+			continue;
+
+		if (file->f_dentry->d_inode != inode)
+			continue;
+
+		/*
+		 * Leak the fd so it is not reused. After this point, we don't
+		 * need to worry about racing with sys_close or sys_dup.
+		 */
+		rcu_assign_pointer(fdt->fd[fd], NULL);
+		FD_CLR(fd, fdt->close_on_exec);
+
+		revoked = kmalloc(sizeof(*revoked), GFP_KERNEL);
+		if (!revoked) {
+			err = -ENOMEM;
+			goto out;
+		}
+
+		INIT_LIST_HEAD(&revoked->list_node);
+		revoked->file  = file;
+		revoked->owner = owner;
+
+		/*
+		 * Hold on to task until we can take down the file and its
+		 * mmap.
+		 */
+		get_task_struct(owner);
+
+		list_add(&revoked->list_node, to_close);
+	}
+  out:
+	spin_unlock(&files->file_lock);
+	return err;
+}
+
+static struct page *revoked_nopage(struct vm_area_struct *area,
+				   unsigned long address, int *type)
+{
+	return NULL;
+}
+
+static struct vm_operations_struct revoked_vm_ops = {
+        .nopage         = revoked_nopage,
+};
+
+static int revoke_mapping(struct address_space *mapping)
+{
+	struct vm_area_struct *vma;
+	struct prio_tree_iter iter;
+
+	spin_lock(&mapping->i_mmap_lock);
+	/* make ->nopage fail for all mmaps of the mapping */
+	vma_prio_tree_foreach(vma, &iter, &mapping->i_mmap, 0, ULONG_MAX)
+		vma->vm_ops = &revoked_vm_ops;
+	list_for_each_entry(vma, &mapping->i_mmap_nonlinear, shared.vm_set.list)
+		vma->vm_ops = &revoked_vm_ops;
+	spin_unlock(&mapping->i_mmap_lock);
+
+	/* FIXME: If we fail to invalidate some pages, no one will take them
+	   down but subsequent revoke operations succeed... */
+	return invalidate_inode_pages2(mapping);
+}
+
+static int close_files(struct list_head *to_close)
+{
+	int ret = 0;
+	struct revoked_file *this, *next;
+
+	list_for_each_entry_safe(this, next, to_close, list_node) {
+		struct inode *inode;
+		struct task_struct *task;
+		int err;
+
+		inode = this->file->f_dentry->d_inode;
+
+		task = this->owner;
+		task_lock(task);
+		if (task->files) {
+			err = filp_close(this->file, task->files);
+			if (err)
+				ret = err;
+		}
+		task_unlock(task);
+		put_task_struct(task);
+
+		err = revoke_mapping(inode->i_mapping);
+		if (err)
+			ret = err;
+
+		list_del(&this->list_node);
+		kfree(this);
+	}
+	return ret;
+}
+
+static int do_revoke(struct inode *inode, struct file *exclude)
+{
+	int err, ret = 0;
+	struct task_struct *g, *p;
+	struct list_head to_close = LIST_HEAD_INIT(to_close);
+
+	if (current->fsuid != inode->i_uid && !capable(CAP_FOWNER)) {
+		ret = -EPERM;
+		goto out;
+	}
+
+	/*
+	 * First revoke the file descriptors. After we are done, all new
+	 * operations on the descriptors will fail.
+	 */
+	read_lock(&tasklist_lock);
+	do_each_thread(g, p) {
+		task_lock(p);
+
+		if (p->files) {
+			ret = revoke_files(p, inode, exclude, &to_close);
+			if (ret) {
+				task_unlock(p);
+				goto out_unlock_tasklist;
+			}
+		}
+		task_unlock(p);
+	} while_each_thread(g, p);
+
+  out_unlock_tasklist:
+	read_unlock(&tasklist_lock);
+
+	/*
+	 * Now, close the files and take down mmaps.
+	 */
+	err = close_files(&to_close);
+	if (err)
+		ret = err;
+  out:
+	return ret;
+}
+
+asmlinkage int sys_revoke(const char __user *filename)
+{
+	int err;
+	struct nameidata nd;
+
+	err = __user_walk(filename, 0, &nd);
+	if (!err) {
+		err = do_revoke(nd.dentry->d_inode, NULL);
+		path_release(&nd);
+	}
+	return err;
+}
+
+asmlinkage int sys_frevoke(unsigned int fd)
+{
+	struct file *file = fget(fd);
+	int err = -EBADF;
+
+	if (file) {
+		err = do_revoke(file->f_dentry->d_inode, file);
+		fput(file);
+	}
+	return err;
+}
Index: 2.6/include/asm-i386/unistd.h
===================================================================
--- 2.6.orig/include/asm-i386/unistd.h
+++ 2.6/include/asm-i386/unistd.h
@@ -323,10 +323,12 @@
 #define __NR_tee		315
 #define __NR_vmsplice		316
 #define __NR_move_pages		317
+#define __NR_revoke		318
+#define __NR_frevoke		319
 
 #ifdef __KERNEL__
 
-#define NR_syscalls 318
+#define NR_syscalls 320
 
 /*
  * user-visible error numbers are in the range -1 - -128: see
Index: 2.6/include/linux/syscalls.h
===================================================================
--- 2.6.orig/include/linux/syscalls.h
+++ 2.6/include/linux/syscalls.h
@@ -597,4 +597,7 @@ asmlinkage long sys_get_robust_list(int 
 asmlinkage long sys_set_robust_list(struct robust_list_head __user *head,
 				    size_t len);
 
+asmlinkage int sys_revoke(const char __user *filename);
+asmlinkage int sys_frevoke(unsigned int fd);
+
 #endif
