Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751021AbVHKHKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbVHKHKk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 03:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbVHKHKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 03:10:40 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:20105 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750960AbVHKHKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 03:10:40 -0400
Date: Thu, 11 Aug 2005 10:10:16 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Mark Fasheh <mark.fasheh@oracle.com>
cc: Christoph Hellwig <hch@infradead.org>, Zach Brown <zab@zabbo.net>,
       David Teigland <teigland@redhat.com>, Pekka Enberg <penberg@gmail.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: GFS
Message-ID: <Pine.LNX.4.58.0508111006470.13379@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Thu, 11 Aug 2005, Pekka J Enberg wrote:
> Reading and writing from other filesystems to a GFS2 mmap'd file
> does not walk the vmas. Therefore, data consistency guarantees
> are different:

What I meant was that, if a filesystem requires vma walks, we need to do 
it VFS level with something like the following patch. With this, your 
filesystem would implement a_ops->iolock_acquire that sorts the locks
and takes them all. In case of GFS2, this would replace walk_vm().

Thoughts?

			Pekka

[PATCH] vfs: iolock

This patch introduces iolock which can be used by filesystems that require
special locking when accessing an mmap'd region.

Unfinished and untested.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 fs/Makefile            |    2 -
 fs/iolock.c            |   88 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/read_write.c        |   15 ++++++++
 include/linux/fs.h     |    2 +
 include/linux/iolock.h |   11 ++++++
 5 files changed, 117 insertions(+), 1 deletion(-)

Index: 2.6-mm/fs/iolock.c
===================================================================
--- /dev/null
+++ 2.6-mm/fs/iolock.c
@@ -0,0 +1,88 @@
+/*
+ * fs/iolock.c
+ *
+ * Derived from GFS2.
+ */
+
+#include <linux/iolock.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+
+/*
+ * I/O lock contains all files that participate in locking a memory region.
+ * It is used for filesystems that require special locks to access mmap'd
+ * memory.
+ */
+struct iolock {
+	struct address_space	*mapping;
+	unsigned long		nr_files;
+	struct file		**files;
+};
+
+struct iolock *iolock_region(const char __user *buf, size_t size)
+{
+	int err = -ENOMEM;
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	unsigned long start = (unsigned long)buf;
+	unsigned long end = start + size;
+	struct iolock *ret;
+
+	ret = kcalloc(1, sizeof(*ret), GFP_KERNEL);
+	if (!ret)
+		return ERR_PTR(-ENOMEM);
+
+	down_read(&mm->mmap_sem);
+
+	ret->files = kcalloc(mm->map_count, sizeof(struct file*), GFP_KERNEL);
+	if (!ret->files)
+		goto error;
+
+	for (vma = find_vma(mm, start); vma; vma = vma->vm_next) {
+		struct file *file;
+		struct address_space *mapping;
+
+		if (end <= vma->vm_start)
+			break;
+
+		file = vma->vm_file;
+		if (!file)
+			continue;
+
+		mapping = file->f_mapping;
+		if (!mapping->a_ops->iolock_acquire ||
+		    !mapping->a_ops->iolock_release)
+			continue;
+
+ 		/* FIXME: This only works when one address_space participates
+		          in the iolock. */
+		ret->mapping = mapping;
+		ret->files[ret->nr_files++] = file;
+	}
+out:
+	up_read(&mm->mmap_sem);
+
+	if (ret->mapping->a_ops->iolock_acquire) {
+		err = ret->mapping->a_ops->iolock_acquire(ret->files, ret->nr_files);
+		if (!err)
+			goto error;
+	}
+
+	return ret;
+
+error:
+	iolock_release(ret);
+	ret = ERR_PTR(err);
+	goto out;
+}
+
+void iolock_release(struct iolock *iolock)
+{
+	struct address_space *mapping = iolock->mapping;
+	if (mapping && mapping->a_ops->iolock_release)
+		mapping->a_ops->iolock_release(iolock->files, iolock->nr_files);
+	kfree(iolock->files);
+	kfree(iolock);
+}
Index: 2.6-mm/fs/read_write.c
===================================================================
--- 2.6-mm.orig/fs/read_write.c
+++ 2.6-mm/fs/read_write.c
@@ -14,6 +14,7 @@
 #include <linux/security.h>
 #include <linux/module.h>
 #include <linux/syscalls.h>
+#include <linux/iolock.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -247,14 +248,21 @@ ssize_t vfs_read(struct file *file, char
 	if (!ret) {
 		ret = security_file_permission (file, MAY_READ);
 		if (!ret) {
+			struct iolock * iolock = iolock_region(buf, count);
+			if (IS_ERR(iolock)) {
+				ret = PTR_ERR(iolock);
+				goto out;
+			}
 			if (file->f_op->read)
 				ret = file->f_op->read(file, buf, count, pos);
 			else
 				ret = do_sync_read(file, buf, count, pos);
+			iolock_release(iolock);
 			if (ret > 0) {
 				fsnotify_access(file->f_dentry);
 				current->rchar += ret;
 			}
+  out:
 			current->syscr++;
 		}
 	}
@@ -298,14 +306,21 @@ ssize_t vfs_write(struct file *file, con
 	if (!ret) {
 		ret = security_file_permission (file, MAY_WRITE);
 		if (!ret) {
+			struct iolock * iolock = iolock_region(buf, count);
+			if (IS_ERR(iolock)) {
+				ret = PTR_ERR(iolock);
+				goto out;
+			}
 			if (file->f_op->write)
 				ret = file->f_op->write(file, buf, count, pos);
 			else
 				ret = do_sync_write(file, buf, count, pos);
+			iolock_release(iolock);
 			if (ret > 0) {
 				fsnotify_modify(file->f_dentry);
 				current->wchar += ret;
 			}
+  out:
 			current->syscw++;
 		}
 	}
Index: 2.6-mm/include/linux/iolock.h
===================================================================
--- /dev/null
+++ 2.6-mm/include/linux/iolock.h
@@ -0,0 +1,11 @@
+#ifndef __LINUX_IOLOCK_H
+#define __LINUX_IOLOCK_H
+
+#include <linux/kernel.h>
+
+struct iolock;
+
+struct iolock *iolock_region(const char __user *buf, size_t count);
+void iolock_release(struct iolock *lock);
+
+#endif
Index: 2.6-mm/fs/Makefile
===================================================================
--- 2.6-mm.orig/fs/Makefile
+++ 2.6-mm/fs/Makefile
@@ -10,7 +10,7 @@ obj-y :=	open.o read_write.o file_table.
 		ioctl.o readdir.o select.o fifo.o locks.o dcache.o inode.o \
 		attr.o bad_inode.o file.o filesystems.o namespace.o aio.o \
 		seq_file.o xattr.o libfs.o fs-writeback.o mpage.o direct-io.o \
-		ioprio.o
+		ioprio.o iolock.o
 
 obj-$(CONFIG_INOTIFY)		+= inotify.o
 obj-$(CONFIG_EPOLL)		+= eventpoll.o
Index: 2.6-mm/include/linux/fs.h
===================================================================
--- 2.6-mm.orig/include/linux/fs.h
+++ 2.6-mm/include/linux/fs.h
@@ -334,6 +334,8 @@ struct address_space_operations {
 			loff_t offset, unsigned long nr_segs);
 	struct page* (*get_xip_page)(struct address_space *, sector_t,
 			int);
+	int (*iolock_acquire)(struct file **, unsigned long);
+	void (*iolock_release)(struct file **, unsigned long);
 };
 
 struct backing_dev_info;
