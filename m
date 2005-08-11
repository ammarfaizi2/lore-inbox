Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbVHKQpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbVHKQpd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 12:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbVHKQpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 12:45:32 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:24526 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751115AbVHKQpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 12:45:32 -0400
Subject: Re: GFS
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Zach Brown <zab@zabbo.net>
Cc: Mark Fasheh <mark.fasheh@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       David Teigland <teigland@redhat.com>, Pekka Enberg <penberg@gmail.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, linux-cluster@redhat.com,
       Andreas Dilger <adilger@clusterfs.com>
In-Reply-To: <42FB7DE5.2080506@zabbo.net>
References: <Pine.LNX.4.58.0508111006470.13379@sbz-30.cs.Helsinki.FI>
	 <42FB7DE5.2080506@zabbo.net>
Date: Thu, 11 Aug 2005 19:44:50 +0300
Message-Id: <1123778691.24181.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-11 at 09:33 -0700, Zach Brown wrote:
> I don't think this patch is the way to go at all.  It imposes an
> allocation and vma walking overhead for the vast majority of IOs that
> aren't interested.  It doesn't look like it will get a consistent
> ordering when multiple file systems are concerned.  It doesn't record
> the ranges of the mappings involved so Lustre can't properly use its
> range locks.  And finally, it doesn't prohibit mapping operations for
> the duration of the IO -- the whole reason we ended up in this thread in
> the first place :)

Hmm. So how do you propose we get rid of the mandatory vma walk? I was
thinking of making iolock a config option so when you don't have any
filesystems that need it, it can go away. I have also optimized the
extra allocation away when there are none mmap'd files that require
locking.

As for the rest of your comments, I heartly agree with them and
hopefully some interested party will take care of them :-).

			Pekka

Index: 2.6-mm/fs/iolock.c
===================================================================
--- /dev/null
+++ 2.6-mm/fs/iolock.c
@@ -0,0 +1,183 @@
+/*
+ * I/O locking for memory regions. Used by filesystems that need special
+ * locking for mmap'd files.
+ */
+
+#include <linux/iolock.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+
+/*
+ * TODO:
+ *
+ *  - Deadlock when two nodes acquire iolocks in reverse order for two
+ *    different filesystems. Solution: use rbtree in iolock_chain so we
+ *    can walk iolocks in order. XXX: what order is stable for two nodes
+ *    that don't know about each other?
+ */
+
+/*
+ * I/O lock contains all files that participate in locking a memory region
+ * in an address_space.
+ */
+struct iolock {
+	struct address_space	*mapping;
+	unsigned long		nr_files;
+	struct file		**files;
+	struct list_head	chain;
+};
+
+struct iolock_chain {
+	struct list_head	list;
+};
+
+static struct iolock *iolock_new(unsigned long max_files)
+{
+	struct iolock *ret = kzalloc(sizeof(*ret), GFP_KERNEL);
+	if (!ret)
+		goto out;
+	ret->files = kcalloc(max_files, sizeof(struct file *), GFP_KERNEL);
+	if (!ret->files) {
+		kfree(ret);
+		ret = NULL;
+		goto out;
+	}
+	INIT_LIST_HEAD(&ret->chain);
+out:
+	return ret;
+}
+
+static struct iolock_chain *iolock_chain_new(void)
+{
+	struct iolock_chain * ret = kzalloc(sizeof(*ret), GFP_KERNEL);
+	if (ret) {
+		INIT_LIST_HEAD(&ret->list);
+	}
+	return ret;
+}
+
+static int iolock_chain_acquire(struct iolock_chain *chain)
+{
+	struct iolock * iolock;
+	int err = 0;
+
+	list_for_each_entry(iolock, &chain->list, chain) {
+		if (iolock->mapping->a_ops->iolock_acquire) {
+			err = iolock->mapping->a_ops->iolock_acquire(
+					iolock->files, iolock->nr_files);
+			if (!err)
+				goto error;
+		}
+	}
+error:
+	return err;
+}
+
+static struct iolock *iolock_lookup(struct iolock_chain *chain,
+				    struct address_space *mapping)
+{
+	struct iolock *ret = NULL;
+	struct iolock *iolock;
+
+	list_for_each_entry(iolock, &chain->list, chain) {
+		if (iolock->mapping == mapping) {
+			ret = iolock;
+			break;
+		}
+	}
+	return ret;
+}
+
+/**
+ * iolock_region - Lock memory region for file I/O.
+ * @buf: the buffer we want to lock.
+ * @size: size of the buffer.
+ *
+ * Returns a pointer to the iolock_chain or NULL to denote an empty chain;
+ * otherwise returns ERR_PTR().
+ */
+struct iolock_chain *iolock_region(const char __user *buf, size_t size)
+{
+	struct iolock_chain *ret = NULL;
+	int err = -ENOMEM;
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	unsigned long start = (unsigned long)buf;
+	unsigned long end = start + size;
+	int max_files;
+
+	down_read(&mm->mmap_sem);
+	max_files = mm->map_count;
+
+	for (vma = find_vma(mm, start); vma; vma = vma->vm_next) {
+		struct file *file;
+		struct address_space *mapping;
+		struct iolock *iolock;
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
+		/* Allocate chain lazily to avoid initialization overhead
+		   when we don't have any files that require iolock.  */
+		if (!ret) {
+			ret = iolock_chain_new();
+			if (!ret)
+				goto error;
+		}
+
+		iolock = iolock_lookup(ret, mapping);
+		if (!iolock) {
+			iolock = iolock_new(max_files);
+			if (!iolock)
+				goto error;
+			iolock->mapping = mapping;
+		}
+
+		iolock->files[iolock->nr_files++] = file;
+		list_add(&iolock->chain, &ret->list);
+	}
+	err = iolock_chain_acquire(ret);
+	if (!err)
+		goto error;
+
+out:
+	up_read(&mm->mmap_sem);
+	return ret;
+
+error:
+	iolock_release(ret);
+	ret = ERR_PTR(err);
+	goto out;
+}
+
+/**
+ * iolock_release - Release file I/O locks for a memory region.
+ * @chain: The I/O lock chain to release. Passing NULL means no-op.
+ */
+void iolock_release(struct iolock_chain *chain)
+{
+	struct iolock *iolock;
+
+	if (!chain)
+		return;
+
+	list_for_each_entry(iolock, &chain->list, chain) {
+		struct address_space *mapping = iolock->mapping;
+		if (mapping && mapping->a_ops->iolock_release)
+			mapping->a_ops->iolock_release(iolock->files, iolock->nr_files);
+		kfree(iolock->files);
+		kfree(iolock);
+	}
+	kfree(chain);
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
+			struct iolock_chain * lock = iolock_region(buf, count);
+			if (IS_ERR(lock)) {
+				ret = PTR_ERR(lock);
+				goto out;
+			}
 			if (file->f_op->read)
 				ret = file->f_op->read(file, buf, count, pos);
 			else
 				ret = do_sync_read(file, buf, count, pos);
+			iolock_release(lock);
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
+			struct iolock_chain * lock = iolock_region(buf, count);
+			if (IS_ERR(lock)) {
+				ret = PTR_ERR(lock);
+				goto out;
+			}
 			if (file->f_op->write)
 				ret = file->f_op->write(file, buf, count, pos);
 			else
 				ret = do_sync_write(file, buf, count, pos);
+			iolock_release(lock);
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
+struct iolock_chain;
+
+extern struct iolock_chain *iolock_region(const char __user *, size_t);
+extern void iolock_release(struct iolock_chain *);
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


