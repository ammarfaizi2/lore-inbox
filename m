Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265354AbUHHOHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265354AbUHHOHj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 10:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265383AbUHHOHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 10:07:39 -0400
Received: from waste.org ([209.173.204.2]:48053 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S265354AbUHHOH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 10:07:27 -0400
Date: Sun, 8 Aug 2004 09:07:05 -0500
From: Matt Mackall <mpm@selenic.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Allow to disable shmem.o
Message-ID: <20040808140705.GH16310@waste.org>
References: <m3vffulhou.fsf@averell.firstfloor.org> <Pine.LNX.4.44.0408081248560.1443-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0408081248560.1443-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 08, 2004 at 02:03:09PM +0100, Hugh Dickins wrote:
> 
> But I prefer Matt's tiny tiny-shmem.c which does support all those,
> using ramfs instead, and says in Kconfig what it's doing.
> But perhaps you're wanting to avoid ramfs too?

Ramfs is hard to avoid as it's used internally for / at boot and so
on. My patch for comparison. Comments appreciated.

configurable tiny shmem/tmpfs support


 tiny-mpm/fs/ramfs/inode.c   |    8 +-
 tiny-mpm/include/linux/mm.h |   10 +++
 tiny-mpm/init/Kconfig       |   14 ++++
 tiny-mpm/mm/Makefile        |    4 +
 tiny-mpm/mm/filemap.c       |    2 
 tiny-mpm/mm/tiny-shmem.c    |  128 ++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 159 insertions(+), 7 deletions(-)

Index: tiny/mm/Makefile
===================================================================
--- tiny.orig/mm/Makefile	2004-07-19 13:14:45.000000000 -0500
+++ tiny/mm/Makefile	2004-07-19 13:43:35.000000000 -0500
@@ -5,7 +5,7 @@
 mmu-y			:= nommu.o
 mmu-$(CONFIG_MMU)	:= fremap.o highmem.o madvise.o memory.o mincore.o \
 			   mlock.o mmap.o mprotect.o mremap.o msync.o rmap.o \
-			   shmem.o vmalloc.o
+			   vmalloc.o
 
 obj-y			:= bootmem.o filemap.o mempool.o oom_kill.o fadvise.o \
 			   page_alloc.o page-writeback.o pdflush.o prio_tree.o \
@@ -16,3 +16,6 @@
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
 obj-$(CONFIG_NUMA) 	+= mempolicy.o
+obj-$(CONFIG_SHMEM) += shmem.o
+obj-$(CONFIG_TINY_SHMEM) += tiny-shmem.o
+
Index: tiny/mm/tiny-shmem.c
===================================================================
--- tiny.orig/mm/tiny-shmem.c	2003-09-12 12:14:37.000000000 -0500
+++ tiny/mm/tiny-shmem.c	2004-07-19 13:43:35.000000000 -0500
@@ -0,0 +1,128 @@
+/*
+ * tiny-shmem.c: simple shmemfs and tmpfs using ramfs code
+ *
+ * Matt Mackall <mpm@selenic.com> January, 2004
+ * derived from mm/shmem.c and fs/ramfs/inode.c
+ *
+ * This is intended for small system where the benefits of the full
+ * shmem code (swap-backed and resource-limited) are outweighed by their
+ * complexity. On systems without swap and not using userspace /dev/shm,
+ * this code should be effectively equivalent, but much lighter weight.
+ */
+
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/devfs_fs_kernel.h>
+#include <linux/vfs.h>
+#include <linux/mount.h>
+#include <linux/file.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/swap.h>
+
+extern struct inode *ramfs_get_inode(struct super_block *sb, int mode, dev_t dev);
+extern struct super_block *ramfs_get_sb(struct file_system_type *fs_type,
+	 int flags, const char *dev_name, void *data);
+extern struct file_operations ramfs_file_operations;
+extern struct vm_operations_struct generic_file_vm_ops;
+
+static struct file_system_type tmpfs_fs_type = {
+	.name		= "tmpfs",
+	.get_sb		= ramfs_get_sb,
+	.kill_sb	= kill_litter_super,
+};
+
+static struct vfsmount *shm_mnt;
+
+static int __init init_tmpfs(void)
+{
+	register_filesystem(&tmpfs_fs_type);
+#ifdef CONFIG_TMPFS
+	devfs_mk_dir("shm");
+#endif
+	shm_mnt = kern_mount(&tmpfs_fs_type);
+	return 0;
+}
+module_init(init_tmpfs)
+
+/*
+ * shmem_file_setup - get an unlinked file living in tmpfs
+ *
+ * @name: name for dentry (to be seen in /proc/<pid>/maps
+ * @size: size to be set for the file
+ *
+ */
+struct file *shmem_file_setup(char *name, loff_t size, unsigned long flags)
+{
+	int error;
+	struct file *file;
+	struct inode *inode;
+	struct dentry *dentry, *root;
+	struct qstr this;
+
+	if (IS_ERR(shm_mnt))
+		return (void *)shm_mnt;
+
+	error = -ENOMEM;
+	this.name = name;
+	this.len = strlen(name);
+	this.hash = 0; /* will go */
+	root = shm_mnt->mnt_root;
+	dentry = d_alloc(root, &this);
+	if (!dentry)
+		goto put_memory;
+
+	error = -ENFILE;
+	file = get_empty_filp();
+	if (!file)
+		goto put_dentry;
+
+	error = -ENOSPC;
+	inode = ramfs_get_inode(root->d_sb, S_IFREG | S_IRWXUGO, 0);
+	if (!inode)
+		goto close_file;
+
+	d_instantiate(dentry, inode);
+	inode->i_size = size;
+	inode->i_nlink = 0;	/* It is unlinked */
+	file->f_vfsmnt = mntget(shm_mnt);
+	file->f_dentry = dentry;
+	file->f_op = &ramfs_file_operations;
+	file->f_mode = FMODE_WRITE | FMODE_READ;
+	return file;
+
+close_file:
+	put_filp(file);
+put_dentry:
+	dput(dentry);
+put_memory:
+	return ERR_PTR(error);
+}
+
+/*
+ * shmem_zero_setup - setup a shared anonymous mapping
+ *
+ * @vma: the vma to be mmapped is prepared by do_mmap_pgoff
+ */
+int shmem_zero_setup(struct vm_area_struct *vma)
+{
+	struct file *file;
+	loff_t size = vma->vm_end - vma->vm_start;
+
+	file = shmem_file_setup("dev/zero", size, vma->vm_flags);
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+
+	if (vma->vm_file)
+		fput(vma->vm_file);
+	vma->vm_file = file;
+	vma->vm_ops = &generic_file_vm_ops;
+	return 0;
+}
+
+int shmem_unuse(swp_entry_t entry, struct page *page)
+{
+	return 0;
+}
+
+EXPORT_SYMBOL(shmem_file_setup);
Index: tiny/mm/filemap.c
===================================================================
--- tiny.orig/mm/filemap.c	2004-07-15 13:50:20.000000000 -0500
+++ tiny/mm/filemap.c	2004-07-19 13:43:35.000000000 -0500
@@ -1410,7 +1410,7 @@
 	return 0;
 }
 
-static struct vm_operations_struct generic_file_vm_ops = {
+struct vm_operations_struct generic_file_vm_ops = {
 	.nopage		= filemap_nopage,
 	.populate	= filemap_populate,
 };
Index: tiny/include/linux/mm.h
===================================================================
--- tiny.orig/include/linux/mm.h	2004-07-15 13:50:20.000000000 -0500
+++ tiny/include/linux/mm.h	2004-07-19 13:55:07.000000000 -0500
@@ -489,14 +489,23 @@
 
 extern void show_free_areas(void);
 
+#ifdef CONFIG_SHMEM
 struct page *shmem_nopage(struct vm_area_struct * vma,
 			unsigned long address, int *type);
 int shmem_set_policy(struct vm_area_struct *vma, struct mempolicy *new);
 struct mempolicy *shmem_get_policy(struct vm_area_struct *vma,
 					unsigned long addr);
-struct file *shmem_file_setup(char * name, loff_t size, unsigned long flags);
 void shmem_lock(struct file * file, int lock);
+#else
+#define shmem_nopage filemap_nopage
+#define shmem_lock(a, b) /* always in memory, no need to lock */
+#define shmem_set_policy(a, b) (0)
+#define shmem_get_policy(a, b) (NULL)
+#endif
+
 int shmem_zero_setup(struct vm_area_struct *);
+struct file *shmem_file_setup(char * name, loff_t size, unsigned long flags);
+
 
 /*
  * Parameter block passed down to zap_pte_range in exceptional cases.
Index: tiny/fs/ramfs/inode.c
===================================================================
--- tiny.orig/fs/ramfs/inode.c	2004-07-15 13:50:19.000000000 -0500
+++ tiny/fs/ramfs/inode.c	2004-07-19 13:43:35.000000000 -0500
@@ -39,7 +39,7 @@
 
 static struct super_operations ramfs_ops;
 static struct address_space_operations ramfs_aops;
-static struct file_operations ramfs_file_operations;
+extern struct file_operations ramfs_file_operations;
 static struct inode_operations ramfs_file_inode_operations;
 static struct inode_operations ramfs_dir_inode_operations;
 
@@ -48,7 +48,7 @@
 	.memory_backed	= 1,	/* Does not contribute to dirty memory */
 };
 
-static struct inode *ramfs_get_inode(struct super_block *sb, int mode, dev_t dev)
+struct inode *ramfs_get_inode(struct super_block *sb, int mode, dev_t dev)
 {
 	struct inode * inode = new_inode(sb);
 
@@ -146,7 +146,7 @@
 	.commit_write	= simple_commit_write
 };
 
-static struct file_operations ramfs_file_operations = {
+struct file_operations ramfs_file_operations = {
 	.read		= generic_file_read,
 	.write		= generic_file_write,
 	.mmap		= generic_file_mmap,
@@ -199,7 +199,7 @@
 	return 0;
 }
 
-static struct super_block *ramfs_get_sb(struct file_system_type *fs_type,
+struct super_block *ramfs_get_sb(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data)
 {
 	return get_sb_nodev(fs_type, flags, data, ramfs_fill_super);
Index: tiny/init/Kconfig
===================================================================
--- tiny.orig/init/Kconfig	2004-07-19 13:43:35.000000000 -0500
+++ tiny/init/Kconfig	2004-07-19 13:43:35.000000000 -0500
@@ -461,8 +461,22 @@
 	help
 	  Disabling this moves operations on semaphores out of line.
 
+config SHMEM
+	default y
+	bool "Use full shmem filesystem" if EMBEDDED && MMU
+	help
+	  The shmem is an internal filesystem used to manage shared memory.
+	  It is backed by swap and manages resource limits. It is also exported
+	  to userspace as tmpfs if TMPFS is enabled. Disabling this
+	  option replaces shmem and tmpfs with the much simpler ramfs code,
+	  which may be appropriate on small systems without swap.
+
 endmenu		# General setup
 
+config TINY_SHMEM
+	default !SHMEM
+	bool
+
 config CRC32_CALC
 	default !CRC32_TABLES
 	bool

-- 
Mathematics is the supreme nostalgia of our time.
