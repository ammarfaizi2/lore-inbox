Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262457AbVCBVvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262457AbVCBVvA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 16:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbVCBVud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 16:50:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14819 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262511AbVCBVfF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 16:35:05 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050302090734.5a9895a3.akpm@osdl.org> 
References: <20050302090734.5a9895a3.akpm@osdl.org>  <9420.1109778627@redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, davidm@snapgear.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] BDI: Provide backing device capability information
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Wed, 02 Mar 2005 21:34:47 +0000
Message-ID: <31789.1109799287@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch does two things:

 (1) It gets rid of backing_dev_info::memory_backed and replaces it with a
     pair of boolean values:

	(*) dirty_memory_acct

	    True if the pages associated with this backing device should be
	    tracked by dirty page accounting.

        (*) writeback_if_dirty

	    True if the pages associated with this backing device should have
	    writepage() or writepages() invoked upon them to clean them.

 (2) It adds a backing device capability mask that indicates what a backing
     device is capable of; currently only in regard to memory mapping
     facilities. These flags indicate whether a device can be mapped directly,
     whether it can be copied for a mapping, and whether direct mappings can
     be read, written and/or executed. This information is primarily aimed at
     improving no-MMU private mapping support.


Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 memback-bdicap-2611rc4.diff 
 drivers/block/ll_rw_blk.c   |    3 ++-
 drivers/block/rd.c          |   14 ++++++++------
 drivers/char/mem.c          |    6 ++++++
 fs/buffer.c                 |    2 +-
 fs/fs-writeback.c           |    4 ++--
 fs/hugetlbfs/inode.c        |    5 +++--
 fs/ramfs/inode.c            |    7 +++++--
 fs/sysfs/inode.c            |    5 +++--
 include/linux/backing-dev.h |   22 +++++++++++++++++++++-
 mm/filemap.c                |    6 +++---
 mm/page-writeback.c         |    6 +++---
 mm/readahead.c              |    8 +++++---
 mm/shmem.c                  |    7 ++++---
 mm/swap_state.c             |    5 +++--
 14 files changed, 69 insertions(+), 31 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.11-rc4/include/linux/backing-dev.h linux-2.6.11-rc4-memback/include/linux/backing-dev.h
--- /warthog/kernels/linux-2.6.11-rc4/include/linux/backing-dev.h	2004-06-18 13:44:05.000000000 +0100
+++ linux-2.6.11-rc4-memback/include/linux/backing-dev.h	2005-03-02 21:06:31.733471683 +0000
@@ -25,13 +25,33 @@ typedef int (congested_fn)(void *, int);
 struct backing_dev_info {
 	unsigned long ra_pages;	/* max readahead in PAGE_CACHE_SIZE units */
 	unsigned long state;	/* Always use atomic bitops on this */
-	int memory_backed;	/* Cannot clean pages with writepage */
+	unsigned short capabilities; /* Device capabilities */
+	unsigned dirty_memory_acct : 1; /* Contributes to dirty memory accounting */
+	unsigned writeback_if_dirty : 1; /* Dirty memory should be written back */
 	congested_fn *congested_fn; /* Function pointer if device is md/dm */
 	void *congested_data;	/* Pointer to aux data for congested func */
 	void (*unplug_io_fn)(struct backing_dev_info *, struct page *);
 	void *unplug_io_data;
 };
 
+
+/*
+ * Flags in backing_dev_info::capability
+ * - These flags let !MMU mmap() govern direct device mapping vs immediate
+ *   copying more easily for MAP_PRIVATE, especially for ROM filesystems
+ */
+#define BDI_CAP_MAP_COPY	0x00000001	/* Copy can be mapped (MAP_PRIVATE) */
+#define BDI_CAP_MAP_DIRECT	0x00000002	/* Can be mapped directly (MAP_SHARED) */
+#define BDI_CAP_READ_MAP	VM_MAYREAD	/* Can be mapped for reading */
+#define BDI_CAP_WRITE_MAP	VM_MAYWRITE	/* Can be mapped for writing */
+#define BDI_CAP_EXEC_MAP	VM_MAYEXEC	/* Can be mapped for execution */
+#define BDI_CAP_VMFLAGS \
+	(BDI_CAP_READ_MAP | BDI_CAP_WRITE_MAP | BDI_CAP_EXEC_MAP)
+
+#if (BDI_CAP_MAP_DIRECT | BDI_CAP_COPY_FOR_MAP) & BDI_CAP_VMFLAGS
+#error please change backing_dev_info::capabilities flags
+#endif
+
 extern struct backing_dev_info default_backing_dev_info;
 void default_unplug_io_fn(struct backing_dev_info *bdi, struct page *page);
 
diff -uNrp /warthog/kernels/linux-2.6.11-rc4/drivers/block/ll_rw_blk.c linux-2.6.11-rc4-memback/drivers/block/ll_rw_blk.c
--- /warthog/kernels/linux-2.6.11-rc4/drivers/block/ll_rw_blk.c	2005-02-14 12:18:23.000000000 +0000
+++ linux-2.6.11-rc4-memback/drivers/block/ll_rw_blk.c	2005-03-02 18:19:33.000000000 +0000
@@ -238,7 +238,8 @@ void blk_queue_make_request(request_queu
 	q->make_request_fn = mfn;
 	q->backing_dev_info.ra_pages = (VM_MAX_READAHEAD * 1024) / PAGE_CACHE_SIZE;
 	q->backing_dev_info.state = 0;
-	q->backing_dev_info.memory_backed = 0;
+	q->backing_dev_info.writeback_if_dirty = 1;
+	q->backing_dev_info.dirty_memory_acct = 1;
 	blk_queue_max_sectors(q, MAX_SECTORS);
 	blk_queue_hardsect_size(q, 512);
 	blk_queue_dma_alignment(q, 511);
diff -uNrp /warthog/kernels/linux-2.6.11-rc4/drivers/block/rd.c linux-2.6.11-rc4-memback/drivers/block/rd.c
--- /warthog/kernels/linux-2.6.11-rc4/drivers/block/rd.c	2005-01-04 11:13:05.000000000 +0000
+++ linux-2.6.11-rc4-memback/drivers/block/rd.c	2005-03-02 18:57:41.000000000 +0000
@@ -324,9 +324,10 @@ static int rd_ioctl(struct inode *inode,
  * writeback and it does not contribute to dirty memory accounting.
  */
 static struct backing_dev_info rd_backing_dev_info = {
-	.ra_pages	= 0,	/* No readahead */
-	.memory_backed	= 1,	/* Does not contribute to dirty memory */
-	.unplug_io_fn	= default_unplug_io_fn,
+	.ra_pages		= 0,	/* No readahead */
+	.dirty_memory_acct	= 0,	/* Doesn't contribute to dirty memory */
+	.writeback_if_dirty	= 0,
+	.unplug_io_fn		= default_unplug_io_fn,
 };
 
 /*
@@ -335,9 +336,10 @@ static struct backing_dev_info rd_backin
  * memory accounting.
  */
 static struct backing_dev_info rd_file_backing_dev_info = {
-	.ra_pages	= 0,	/* No readahead */
-	.memory_backed	= 0,	/* Does contribute to dirty memory */
-	.unplug_io_fn	= default_unplug_io_fn,
+	.ra_pages		= 0,	/* No readahead */
+	.dirty_memory_acct	= 1,	/* Does contribute to dirty memory */
+	.writeback_if_dirty	= 1,
+	.unplug_io_fn		= default_unplug_io_fn,
 };
 
 static int rd_open(struct inode *inode, struct file *filp)
diff -uNrp /warthog/kernels/linux-2.6.11-rc4/drivers/char/mem.c linux-2.6.11-rc4-memback/drivers/char/mem.c
--- /warthog/kernels/linux-2.6.11-rc4/drivers/char/mem.c	2005-01-04 11:13:10.000000000 +0000
+++ linux-2.6.11-rc4-memback/drivers/char/mem.c	2005-03-02 21:06:39.784800247 +0000
@@ -23,6 +23,7 @@
 #include <linux/devfs_fs_kernel.h>
 #include <linux/ptrace.h>
 #include <linux/device.h>
+#include <linux/backing-dev.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -613,6 +614,10 @@ static struct file_operations zero_fops 
 	.mmap		= mmap_zero,
 };
 
+static struct backing_dev_info zero_bdi = {
+	.capabilities	= BDI_CAP_MAP_COPY,
+};
+
 static struct file_operations full_fops = {
 	.llseek		= full_lseek,
 	.read		= read_full,
@@ -659,6 +664,7 @@ static int memory_open(struct inode * in
 			break;
 #endif
 		case 5:
+			filp->f_mapping->backing_dev_info = &zero_bdi;
 			filp->f_op = &zero_fops;
 			break;
 		case 7:
diff -uNrp /warthog/kernels/linux-2.6.11-rc4/fs/buffer.c linux-2.6.11-rc4-memback/fs/buffer.c
--- /warthog/kernels/linux-2.6.11-rc4/fs/buffer.c	2005-02-14 12:18:50.000000000 +0000
+++ linux-2.6.11-rc4-memback/fs/buffer.c	2005-03-02 18:14:19.000000000 +0000
@@ -876,7 +876,7 @@ int __set_page_dirty_buffers(struct page
 	if (!TestSetPageDirty(page)) {
 		spin_lock_irq(&mapping->tree_lock);
 		if (page->mapping) {	/* Race with truncate? */
-			if (!mapping->backing_dev_info->memory_backed)
+			if (mapping->backing_dev_info->dirty_memory_acct)
 				inc_page_state(nr_dirty);
 			radix_tree_tag_set(&mapping->page_tree,
 						page_index(page),
diff -uNrp /warthog/kernels/linux-2.6.11-rc4/fs/fs-writeback.c linux-2.6.11-rc4-memback/fs/fs-writeback.c
--- /warthog/kernels/linux-2.6.11-rc4/fs/fs-writeback.c	2005-02-14 12:18:51.000000000 +0000
+++ linux-2.6.11-rc4-memback/fs/fs-writeback.c	2005-03-02 18:15:48.000000000 +0000
@@ -315,7 +315,7 @@ sync_sb_inodes(struct super_block *sb, s
 		struct backing_dev_info *bdi = mapping->backing_dev_info;
 		long pages_skipped;
 
-		if (bdi->memory_backed) {
+		if (!bdi->writeback_if_dirty) {
 			list_move(&inode->i_list, &sb->s_dirty);
 			if (sb == blockdev_superblock) {
 				/*
@@ -566,7 +566,7 @@ int write_inode_now(struct inode *inode,
 		.sync_mode = WB_SYNC_ALL,
 	};
 
-	if (inode->i_mapping->backing_dev_info->memory_backed)
+	if (!inode->i_mapping->backing_dev_info->writeback_if_dirty)
 		return 0;
 
 	might_sleep();
diff -uNrp /warthog/kernels/linux-2.6.11-rc4/fs/hugetlbfs/inode.c linux-2.6.11-rc4-memback/fs/hugetlbfs/inode.c
--- /warthog/kernels/linux-2.6.11-rc4/fs/hugetlbfs/inode.c	2005-02-14 12:18:51.000000000 +0000
+++ linux-2.6.11-rc4-memback/fs/hugetlbfs/inode.c	2005-03-02 18:34:02.000000000 +0000
@@ -39,8 +39,9 @@ static struct inode_operations hugetlbfs
 static struct inode_operations hugetlbfs_inode_operations;
 
 static struct backing_dev_info hugetlbfs_backing_dev_info = {
-	.ra_pages	= 0,	/* No readahead */
-	.memory_backed	= 1,	/* Does not contribute to dirty memory */
+	.ra_pages		= 0,	/* No readahead */
+	.dirty_memory_acct	= 0,	/* Doesn't contribute to dirty memory */
+	.writeback_if_dirty	= 0,
 };
 
 int sysctl_hugetlb_shm_group;
diff -uNrp /warthog/kernels/linux-2.6.11-rc4/fs/ramfs/inode.c linux-2.6.11-rc4-memback/fs/ramfs/inode.c
--- /warthog/kernels/linux-2.6.11-rc4/fs/ramfs/inode.c	2005-02-14 12:18:53.000000000 +0000
+++ linux-2.6.11-rc4-memback/fs/ramfs/inode.c	2005-03-02 18:32:54.000000000 +0000
@@ -44,8 +44,11 @@ static struct inode_operations ramfs_fil
 static struct inode_operations ramfs_dir_inode_operations;
 
 static struct backing_dev_info ramfs_backing_dev_info = {
-	.ra_pages	= 0,	/* No readahead */
-	.memory_backed	= 1,	/* Does not contribute to dirty memory */
+	.ra_pages		= 0,	/* No readahead */
+	.dirty_memory_acct	= 0,	/* Does not contribute to dirty memory */
+	.writeback_if_dirty	= 0,
+	.capabilities		= BDI_CAP_MAP_DIRECT | BDI_CAP_MAP_COPY |
+				  BDI_CAP_READ_MAP | BDI_CAP_WRITE_MAP | BDI_CAP_EXEC_MAP,
 };
 
 struct inode *ramfs_get_inode(struct super_block *sb, int mode, dev_t dev)
diff -uNrp /warthog/kernels/linux-2.6.11-rc4/fs/sysfs/inode.c linux-2.6.11-rc4-memback/fs/sysfs/inode.c
--- /warthog/kernels/linux-2.6.11-rc4/fs/sysfs/inode.c	2005-01-04 11:13:43.000000000 +0000
+++ linux-2.6.11-rc4-memback/fs/sysfs/inode.c	2005-03-02 18:18:43.000000000 +0000
@@ -22,8 +22,9 @@ static struct address_space_operations s
 };
 
 static struct backing_dev_info sysfs_backing_dev_info = {
-	.ra_pages	= 0,	/* No readahead */
-	.memory_backed	= 1,	/* Does not contribute to dirty memory */
+	.ra_pages		= 0,	/* No readahead */
+	.writeback_if_dirty	= 0,
+	.dirty_memory_acct	= 0,	/* Doesn't contribute to dirty memory */
 };
 
 struct inode * sysfs_new_inode(mode_t mode)
diff -uNrp /warthog/kernels/linux-2.6.11-rc4/mm/filemap.c linux-2.6.11-rc4-memback/mm/filemap.c
--- /warthog/kernels/linux-2.6.11-rc4/mm/filemap.c	2005-02-14 12:19:04.000000000 +0000
+++ linux-2.6.11-rc4-memback/mm/filemap.c	2005-03-02 17:33:54.000000000 +0000
@@ -172,7 +172,7 @@ static int __filemap_fdatawrite_range(st
 		.end = end,
 	};
 
-	if (mapping->backing_dev_info->memory_backed)
+	if (!mapping->backing_dev_info->writeback_if_dirty)
 		return 0;
 
 	ret = do_writepages(mapping, &wbc);
@@ -269,7 +269,7 @@ int sync_page_range(struct inode *inode,
 	pgoff_t end = (pos + count - 1) >> PAGE_CACHE_SHIFT;
 	int ret;
 
-	if (mapping->backing_dev_info->memory_backed || !count)
+	if (!mapping->backing_dev_info->writeback_if_dirty || !count)
 		return 0;
 	ret = filemap_fdatawrite_range(mapping, pos, pos + count - 1);
 	if (ret == 0) {
@@ -295,7 +295,7 @@ int sync_page_range_nolock(struct inode 
 	pgoff_t end = (pos + count - 1) >> PAGE_CACHE_SHIFT;
 	int ret;
 
-	if (mapping->backing_dev_info->memory_backed || !count)
+	if (!mapping->backing_dev_info->writeback_if_dirty || !count)
 		return 0;
 	ret = filemap_fdatawrite_range(mapping, pos, pos + count - 1);
 	if (ret == 0)
diff -uNrp /warthog/kernels/linux-2.6.11-rc4/mm/page-writeback.c linux-2.6.11-rc4-memback/mm/page-writeback.c
--- /warthog/kernels/linux-2.6.11-rc4/mm/page-writeback.c	2005-02-14 12:19:04.000000000 +0000
+++ linux-2.6.11-rc4-memback/mm/page-writeback.c	2005-03-02 17:34:43.000000000 +0000
@@ -605,7 +605,7 @@ int __set_page_dirty_nobuffers(struct pa
 			mapping2 = page_mapping(page);
 			if (mapping2) { /* Race with truncate? */
 				BUG_ON(mapping2 != mapping);
-				if (!mapping->backing_dev_info->memory_backed)
+				if (mapping->backing_dev_info->dirty_memory_acct)
 					inc_page_state(nr_dirty);
 				radix_tree_tag_set(&mapping->page_tree,
 					page_index(page), PAGECACHE_TAG_DIRTY);
@@ -691,7 +691,7 @@ int test_clear_page_dirty(struct page *p
 						page_index(page),
 						PAGECACHE_TAG_DIRTY);
 			spin_unlock_irqrestore(&mapping->tree_lock, flags);
-			if (!mapping->backing_dev_info->memory_backed)
+			if (mapping->backing_dev_info->dirty_memory_acct)
 				dec_page_state(nr_dirty);
 			return 1;
 		}
@@ -722,7 +722,7 @@ int clear_page_dirty_for_io(struct page 
 
 	if (mapping) {
 		if (TestClearPageDirty(page)) {
-			if (!mapping->backing_dev_info->memory_backed)
+			if (mapping->backing_dev_info->dirty_memory_acct)
 				dec_page_state(nr_dirty);
 			return 1;
 		}
diff -uNrp /warthog/kernels/linux-2.6.11-rc4/mm/readahead.c linux-2.6.11-rc4-memback/mm/readahead.c
--- /warthog/kernels/linux-2.6.11-rc4/mm/readahead.c	2005-02-14 12:19:04.000000000 +0000
+++ linux-2.6.11-rc4-memback/mm/readahead.c	2005-03-02 19:12:36.000000000 +0000
@@ -21,9 +21,11 @@ void default_unplug_io_fn(struct backing
 EXPORT_SYMBOL(default_unplug_io_fn);
 
 struct backing_dev_info default_backing_dev_info = {
-	.ra_pages	= (VM_MAX_READAHEAD * 1024) / PAGE_CACHE_SIZE,
-	.state		= 0,
-	.unplug_io_fn	= default_unplug_io_fn,
+	.ra_pages		= (VM_MAX_READAHEAD * 1024) / PAGE_CACHE_SIZE,
+	.state			= 0,
+	.dirty_memory_acct	= 1,
+	.writeback_if_dirty	= 1,
+	.unplug_io_fn		= default_unplug_io_fn,
 };
 EXPORT_SYMBOL_GPL(default_backing_dev_info);
 
diff -uNrp /warthog/kernels/linux-2.6.11-rc4/mm/shmem.c linux-2.6.11-rc4-memback/mm/shmem.c
--- /warthog/kernels/linux-2.6.11-rc4/mm/shmem.c	2005-02-14 12:19:04.000000000 +0000
+++ linux-2.6.11-rc4-memback/mm/shmem.c	2005-03-02 19:27:16.000000000 +0000
@@ -183,9 +183,10 @@ static struct inode_operations shmem_spe
 static struct vm_operations_struct shmem_vm_ops;
 
 static struct backing_dev_info shmem_backing_dev_info = {
-	.ra_pages	= 0,	/* No readahead */
-	.memory_backed	= 1,	/* Does not contribute to dirty memory */
-	.unplug_io_fn = default_unplug_io_fn,
+	.ra_pages		= 0,	/* No readahead */
+	.dirty_memory_acct	= 0,	/* Doesn't contribute to dirty memory */
+	.writeback_if_dirty	= 0,
+	.unplug_io_fn		= default_unplug_io_fn,
 };
 
 static LIST_HEAD(shmem_swaplist);
diff -uNrp /warthog/kernels/linux-2.6.11-rc4/mm/swap_state.c linux-2.6.11-rc4-memback/mm/swap_state.c
--- /warthog/kernels/linux-2.6.11-rc4/mm/swap_state.c	2005-02-14 12:19:04.000000000 +0000
+++ linux-2.6.11-rc4-memback/mm/swap_state.c	2005-03-02 19:26:58.000000000 +0000
@@ -29,8 +29,9 @@ static struct address_space_operations s
 };
 
 static struct backing_dev_info swap_backing_dev_info = {
-	.memory_backed	= 1,	/* Does not contribute to dirty memory */
-	.unplug_io_fn	= swap_unplug_io_fn,
+	.dirty_memory_acct	= 0,	/* Doesn't contribute to dirty memory */
+	.writeback_if_dirty	= 0,
+	.unplug_io_fn		= swap_unplug_io_fn,
 };
 
 struct address_space swapper_space = {
