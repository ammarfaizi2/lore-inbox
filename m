Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160997AbWG0OZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160997AbWG0OZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 10:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWG0OZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 10:25:16 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:20164 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932347AbWG0OZJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 10:25:09 -0400
Date: Thu, 27 Jul 2006 17:25:07 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: linux-kernel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, viro@zeniv.linux.org.uk,
       alan@lxorguk.ukuu.org.uk, tytso@mit.edu, tigran@veritas.com
Subject: [RFC/PATCH] revoke/frevoke system calls V2
Message-ID: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch implements the revoke(2) and frevoke(2) system calls for
all types of files. The operation is done in passes: first we replace
all pointers to the file with NULL in fd tables, then in a second pass,
we take down shared mappings, sync the file to ensure no I/O operations 
are in-flight, and finally close the file. If mmap takedown or sync fails,
we restore the fds to point to the file.

This patch addresses two complaints from Andrew Morton: no kmalloc
under tasklist_lock and keep fget_light/fput_light locking in sys_read
and sys_write. To ensure do_revoke does not race with users of
fget_light/fput_light, we delay closing of the files until fput_light
is called. These bits were taken from the forced unmount patch by
Tigran Aivazian.

There are two known remaining issues: if someone expands the fd
tables, we will BUG_ON. Edgar Toerning expressed concers over allowing
any user to remove mappings from another process and letting it
crash. Albert Cahalan suggested either converting the shared mapping
to private or substitute the unmapped pages with zeroed pages.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 arch/i386/kernel/syscall_table.S |    2 
 fs/Makefile                      |    2 
 fs/file_table.c                  |    1 
 fs/revoke.c                      |  315 +++++++++++++++++++++++++++++++++++++++
 include/asm-i386/unistd.h        |    4 
 include/linux/file.h             |   14 +
 include/linux/fs.h               |    2 
 include/linux/syscalls.h         |    3 
 8 files changed, 341 insertions(+), 2 deletions(-)

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
Index: 2.6/fs/revoke.c
===================================================================
--- /dev/null
+++ 2.6/fs/revoke.c
@@ -0,0 +1,315 @@
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
+	unsigned int fd;
+	struct file *file;
+	struct task_struct *owner;
+};
+
+/*
+ * 	LOCKING: task_lock(owner)
+ */
+static unsigned long revoke_fds(struct task_struct *owner,
+				struct inode *inode,
+				struct file *exclude,
+				struct revoked_file *to_close,
+				unsigned long nr_fds,
+				unsigned long max_fds)
+{
+	unsigned long offset;
+	struct files_struct *files;
+	struct fdtable *fdt;
+	unsigned int fd;
+
+	files = get_files_struct(owner);
+	if (!files)
+		return 0;
+
+	offset = nr_fds;
+
+	spin_lock(&files->file_lock);
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
+		/*
+		 * Hold on to task until we can take down the file and its
+		 * mmap.
+		 */
+		get_task_struct(owner);
+
+		BUG_ON(offset >= max_fds);
+		revoked = &to_close[offset++];
+		revoked->fd    = fd;
+		revoked->file  = file;
+		revoked->owner = owner;
+	}
+	spin_unlock(&files->file_lock);
+	put_files_struct(files);
+	return offset;
+}
+
+static int revoke_mmap(struct revoked_file *revoked)
+{
+	int err = 0;
+	struct mm_struct *mm;
+	struct vm_area_struct *this, *next;
+
+	mm = get_task_mm(revoked->owner);
+	down_write(&mm->mmap_sem);
+
+	/*
+	 * Be careful, do_munmap removes the unmapped vma from mm->mmap list.
+	 */
+	this = mm->mmap;
+	while (this) {
+		next = this->vm_next;
+		if (this->vm_flags & VM_SHARED && this->vm_file == revoked->file) {
+			err = do_munmap(mm, this->vm_start,
+					this->vm_end - this->vm_start);
+			if (err)
+				break;
+		}
+		this = next;
+	}
+	up_write(&mm->mmap_sem);
+	mmput(mm);
+	return err;
+}
+
+static int close_files(struct revoked_file *revoked)
+{
+	int err = 0;
+	struct files_struct *files;
+
+	files = get_files_struct(revoked->owner);
+	if (files) {
+		err = filp_close(revoked->file, files);
+		put_files_struct(files);
+	}
+	return err;
+}
+
+static void restore_files(struct revoked_file *to_restore, unsigned long nr_fds)
+{
+	unsigned long i;
+
+	for (i = 0; i < nr_fds; i++) {
+		struct revoked_file *this;
+		struct files_struct *files;
+
+		this = &to_restore[i];
+		if (!this)
+			continue;
+
+		files = get_files_struct(this->owner);
+		if (files) {
+			struct fdtable *fdt;
+
+			spin_lock(&files->file_lock);
+			fdt = files_fdtable(files);
+			rcu_assign_pointer(fdt->fd[this->fd], this->file);
+			FD_SET(this->fd, fdt->close_on_exec);
+			spin_unlock(&files->file_lock);
+			put_files_struct(files);
+		}
+
+		put_task_struct(this->owner);
+	}
+}
+
+static int cleanup_files(struct revoked_file *to_cleanup, unsigned long nr_fds)
+{
+	int err = 0;
+	unsigned long i;
+
+	for (i = 0; i < nr_fds; i++) {
+		struct revoked_file *this;
+
+		this = &to_cleanup[i];
+
+		err = revoke_mmap(this);
+		if (err)
+			break;
+
+		err = do_fsync(this->file, 1);
+		if (err)
+			break;
+
+		err = close_files(this);
+
+		put_task_struct(this->owner);
+		if (err)
+			break;
+	}
+	if (err)
+		restore_files(&to_cleanup[i], nr_fds-i);
+
+	return err;
+}
+
+/*
+ *	Returns the maximum number of fds pointing to inode.
+ *
+ *	LOCKING: read_lock(&tasklist_lock)
+ */
+static unsigned long inode_fds(struct inode *inode, struct file *exclude)
+{
+	struct task_struct *g, *p;
+	unsigned long nr_fds = 0;
+
+	do_each_thread(g, p) {
+		struct files_struct *files;
+		struct fdtable *fdt;
+		unsigned int fd;
+
+		files = get_files_struct(p);
+		if (!files)
+			continue;
+
+		spin_lock(&files->file_lock);
+		fdt = files_fdtable(files);
+		for (fd = 0; fd < fdt->max_fds; fd++) {
+			struct file *file;
+
+			file = fcheck_files(files, fd);
+			if (file && file != exclude &&
+			    file->f_dentry->d_inode == inode) {
+				/*
+				 * FIXME: If someone expands fd table, we can overflow.
+				 */
+				nr_fds += fdt->max_fds;
+				break;
+			}
+		}
+		spin_unlock(&files->file_lock);
+		put_files_struct(files);
+	} while_each_thread(g, p);
+	return nr_fds;
+}
+
+/*
+ *	Only allocate memory for those threads that actually have an fd
+ *	pointing to the inode.
+ */
+static struct revoked_file *alloc_revoke_table(struct inode *inode,
+					       struct file *exclude,
+					       unsigned long *nr_fds)
+{
+	read_lock(&tasklist_lock);
+	*nr_fds = inode_fds(inode, exclude);
+	read_unlock(&tasklist_lock);
+
+	return kcalloc(*nr_fds, sizeof(struct revoked_file), GFP_KERNEL);
+}
+
+static int do_revoke(struct inode *inode, struct file *exclude)
+{
+	int err = 0;
+	unsigned long nr_fds, max_fds;
+	struct revoked_file *to_close = NULL;
+	struct task_struct *g, *p;
+
+	if (current->fsuid != inode->i_uid && !capable(CAP_FOWNER)) {
+		err = -EPERM;
+		goto out;
+	}
+
+  retry:
+	if (signal_pending(current)) {
+		err = -ERESTARTSYS;
+		goto out;
+	}
+
+	to_close = alloc_revoke_table(inode, exclude, &max_fds);
+	if (!to_close) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	read_lock(&tasklist_lock);
+
+	/*
+	 * If someone forked while we were allocating memory, try again.
+	 */
+	if (inode_fds(inode, exclude) > max_fds) {
+		read_unlock(&tasklist_lock);
+		goto retry;
+	}
+
+	/*
+	 * First revoke the fds. After we are done, no one can start new
+	 * operations on them.
+	 */
+	nr_fds = 0;
+	do_each_thread(g, p) {
+		nr_fds = revoke_fds(p, inode, exclude, to_close,
+				    nr_fds, max_fds);
+	} while_each_thread(g, p);
+	read_unlock(&tasklist_lock);
+
+	/*
+	 * Now, take down the mmaps and close the files for good.
+	 */
+	err = cleanup_files(to_close, nr_fds);
+  out:
+	kfree(to_close);
+	return err;
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
Index: 2.6/fs/file_table.c
===================================================================
--- 2.6.orig/fs/file_table.c
+++ 2.6/fs/file_table.c
@@ -218,6 +218,7 @@ struct file fastcall *fget_light(unsigne
 	*fput_needed = 0;
 	if (likely((atomic_read(&files->count) == 1))) {
 		file = fcheck_files(files, fd);
+		set_f_light(file);
 	} else {
 		rcu_read_lock();
 		file = fcheck_files(files, fd);
Index: 2.6/include/linux/file.h
===================================================================
--- 2.6.orig/include/linux/file.h
+++ 2.6/include/linux/file.h
@@ -6,6 +6,7 @@
 #define __LINUX_FILE_H
 
 #include <asm/atomic.h>
+#include <linux/fs.h>
 #include <linux/posix_types.h>
 #include <linux/compiler.h>
 #include <linux/spinlock.h>
@@ -67,10 +68,23 @@ struct files_struct {
 extern void FASTCALL(__fput(struct file *));
 extern void FASTCALL(fput(struct file *));
 
+static inline void clear_f_light(struct file *file)
+{
+	file->f_light = 0;
+}
+
+static inline void set_f_light(struct file *file)
+{
+	if (file)
+		file->f_light = 1;
+}
+
 static inline void fput_light(struct file *file, int fput_needed)
 {
 	if (unlikely(fput_needed))
 		fput(file);
+	else
+		clear_f_light(file);
 }
 
 extern struct file * FASTCALL(fget(unsigned int fd));
Index: 2.6/include/linux/fs.h
===================================================================
--- 2.6.orig/include/linux/fs.h
+++ 2.6/include/linux/fs.h
@@ -698,6 +698,8 @@ struct file {
 	struct list_head	f_ep_links;
 	spinlock_t		f_ep_lock;
 #endif /* #ifdef CONFIG_EPOLL */
+	/* This instance is being used without holding a reference. */
+	int			f_light;
 	struct address_space	*f_mapping;
 };
 extern spinlock_t files_lock;
