Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbVCHON5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVCHON5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 09:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbVCHON4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 09:13:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34530 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261331AbVCHOMy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 09:12:54 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050307121416.78381632.akpm@osdl.org> 
References: <20050307121416.78381632.akpm@osdl.org>  <E1D8KPt-00058Y-00@dorka.pomaz.szeredi.hu> <E1D8K3T-00056q-00@dorka.pomaz.szeredi.hu> <20050307041047.59c24dec.akpm@osdl.org> <20050307034747.4c6e7277.akpm@osdl.org> <20050307033734.5cc75183.akpm@osdl.org> <20050303123448.462c56cd.akpm@osdl.org> <20050302135146.2248c7e5.akpm@osdl.org> <20050302090734.5a9895a3.akpm@osdl.org> <9420.1109778627@redhat.com> <31789.1109799287@redhat.com> <13767.1109857095@redhat.com> <9268.1110194624@redhat.com> <9741.1110195784@redhat.com> <9947.1110196314@redhat.com> <22447.1110204304@redhat.com> <24382.1110210081@redhat.com> <24862.1110211603@redhat.com> <E1D8Ksv-0005Br-00@dorka.pomaz.szeredi.hu> 
To: Andrew Morton <akpm@osdl.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, torvalds@osdl.org, davidm@snapgear.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] BDI: Provide backing device capability information [try #3]
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Tue, 08 Mar 2005 14:12:31 +0000
Message-ID: <21199.1110291151@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch replaces backing_dev_info::memory_backed with capabilitied
bitmap. The capabilities available include:

  (*) BDI_CAP_NO_ACCT_DIRTY

      Set if the pages associated with this backing device should not be
      tracked by the dirty page accounting.

  (*) BDI_CAP_NO_WRITEBACK

      Set if dirty pages associated with this backing device should not have
      writepage() or writepages() invoked upon them to clean them.

  (*) Capability markers that indicate what a backing device is capable of
      with regard to memory mapping facilities. These flags indicate whether a
      device can be mapped directly, whether it can be copied for a mapping,
      and whether direct mappings can be read, written and/or executed. This
      information is primarily aimed at improving no-MMU private mapping
      support.

The patch also provides convenience functions for determining the dirty-page
capabilities available on backing devices directly or on the backing devices
associated with a mapping. These are provided to keep line length down when
checking for the capabilities.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
diff -uNrp /warthog/kernels/linux-2.6.11-rc4/include/linux/backing-dev.h linux-2.6.11-rc4-memback/include/linux/backing-dev.h
--- /warthog/kernels/linux-2.6.11-rc4/include/linux/backing-dev.h	2004-06-18 13:44:05.000000000 +0100
+++ linux-2.6.11-rc4-memback/include/linux/backing-dev.h	2005-03-08 11:03:45.000000000 +0000
@@ -25,13 +25,39 @@ typedef int (congested_fn)(void *, int);
 struct backing_dev_info {
 	unsigned long ra_pages;	/* max readahead in PAGE_CACHE_SIZE units */
 	unsigned long state;	/* Always use atomic bitops on this */
-	int memory_backed;	/* Cannot clean pages with writepage */
+	unsigned int capabilities; /* Device capabilities */
 	congested_fn *congested_fn; /* Function pointer if device is md/dm */
 	void *congested_data;	/* Pointer to aux data for congested func */
 	void (*unplug_io_fn)(struct backing_dev_info *, struct page *);
 	void *unplug_io_data;
 };
 
+
+/*
+ * Flags in backing_dev_info::capability
+ * - The first two flags control whether dirty pages will contribute to the
+ *   VM's accounting and whether writepages() should be called for dirty pages
+ *   (something that would not, for example, be appropriate for ramfs)
+ * - These flags let !MMU mmap() govern direct device mapping vs immediate
+ *   copying more easily for MAP_PRIVATE, especially for ROM filesystems
+ */
+#define BDI_CAP_NO_ACCT_DIRTY	0x00000001	/* Dirty pages shouldn't contribute to accounting */
+#define BDI_CAP_NO_WRITEBACK	0x00000002	/* Don't write pages back */
+#define BDI_CAP_MAP_COPY	0x00000004	/* Copy can be mapped (MAP_PRIVATE) */
+#define BDI_CAP_MAP_DIRECT	0x00000008	/* Can be mapped directly (MAP_SHARED) */
+#define BDI_CAP_READ_MAP	0x00000010	/* Can be mapped for reading */
+#define BDI_CAP_WRITE_MAP	0x00000020	/* Can be mapped for writing */
+#define BDI_CAP_EXEC_MAP	0x00000040	/* Can be mapped for execution */
+#define BDI_CAP_VMFLAGS \
+	(BDI_CAP_READ_MAP | BDI_CAP_WRITE_MAP | BDI_CAP_EXEC_MAP)
+
+#if defined(VM_MAYREAD) && \
+	(BDI_CAP_READ_MAP != VM_MAYREAD || \
+	 BDI_CAP_WRITE_MAP != VM_MAYWRITE || \
+	 BDI_CAP_EXEC_MAP != VM_MAYEXEC)
+#error please change backing_dev_info::capabilities flags
+#endif
+
 extern struct backing_dev_info default_backing_dev_info;
 void default_unplug_io_fn(struct backing_dev_info *bdi, struct page *page);
 
@@ -62,4 +88,17 @@ static inline int bdi_rw_congested(struc
 				  (1 << BDI_write_congested));
 }
 
+#define bdi_cap_writeback_dirty(bdi) \
+	(!((bdi)->capabilities & BDI_CAP_NO_WRITEBACK))
+
+#define bdi_cap_account_dirty(bdi) \
+	(!((bdi)->capabilities & BDI_CAP_NO_ACCT_DIRTY))
+
+#define mapping_cap_writeback_dirty(mapping) \
+	bdi_cap_writeback_dirty((mapping)->backing_dev_info)
+
+#define mapping_cap_account_dirty(mapping) \
+	bdi_cap_account_dirty((mapping)->backing_dev_info)
+
+
 #endif		/* _LINUX_BACKING_DEV_H */
diff -uNrp /warthog/kernels/linux-2.6.11-rc4/drivers/block/ll_rw_blk.c linux-2.6.11-rc4-memback/drivers/block/ll_rw_blk.c
--- /warthog/kernels/linux-2.6.11-rc4/drivers/block/ll_rw_blk.c	2005-02-14 12:18:23.000000000 +0000
+++ linux-2.6.11-rc4-memback/drivers/block/ll_rw_blk.c	2005-03-08 11:09:54.000000000 +0000
@@ -238,7 +238,7 @@ void blk_queue_make_request(request_queu
 	q->make_request_fn = mfn;
 	q->backing_dev_info.ra_pages = (VM_MAX_READAHEAD * 1024) / PAGE_CACHE_SIZE;
 	q->backing_dev_info.state = 0;
-	q->backing_dev_info.memory_backed = 0;
+	q->backing_dev_info.capabilities = BDI_CAP_MAP_COPY;
 	blk_queue_max_sectors(q, MAX_SECTORS);
 	blk_queue_hardsect_size(q, 512);
 	blk_queue_dma_alignment(q, 511);
diff -uNrp /warthog/kernels/linux-2.6.11-rc4/drivers/block/rd.c linux-2.6.11-rc4-memback/drivers/block/rd.c
--- /warthog/kernels/linux-2.6.11-rc4/drivers/block/rd.c	2005-01-04 11:13:05.000000000 +0000
+++ linux-2.6.11-rc4-memback/drivers/block/rd.c	2005-03-08 11:14:00.000000000 +0000
@@ -325,7 +325,7 @@ static int rd_ioctl(struct inode *inode,
  */
 static struct backing_dev_info rd_backing_dev_info = {
 	.ra_pages	= 0,	/* No readahead */
-	.memory_backed	= 1,	/* Does not contribute to dirty memory */
+	.capabilities	= BDI_CAP_NO_ACCT_DIRTY | BDI_CAP_NO_WRITEBACK | BDI_CAP_MAP_COPY,
 	.unplug_io_fn	= default_unplug_io_fn,
 };
 
@@ -336,7 +336,7 @@ static struct backing_dev_info rd_backin
  */
 static struct backing_dev_info rd_file_backing_dev_info = {
 	.ra_pages	= 0,	/* No readahead */
-	.memory_backed	= 0,	/* Does contribute to dirty memory */
+	.capabilities	= BDI_CAP_MAP_COPY,	/* Does contribute to dirty memory */
 	.unplug_io_fn	= default_unplug_io_fn,
 };
 
diff -uNrp /warthog/kernels/linux-2.6.11-rc4/drivers/char/mem.c linux-2.6.11-rc4-memback/drivers/char/mem.c
--- /warthog/kernels/linux-2.6.11-rc4/drivers/char/mem.c	2005-01-04 11:13:10.000000000 +0000
+++ linux-2.6.11-rc4-memback/drivers/char/mem.c	2005-03-08 11:15:19.000000000 +0000
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
+++ linux-2.6.11-rc4-memback/fs/buffer.c	2005-03-07 13:25:05.000000000 +0000
@@ -876,7 +876,7 @@ int __set_page_dirty_buffers(struct page
 	if (!TestSetPageDirty(page)) {
 		spin_lock_irq(&mapping->tree_lock);
 		if (page->mapping) {	/* Race with truncate? */
-			if (!mapping->backing_dev_info->memory_backed)
+			if (mapping_cap_account_dirty(mapping))
 				inc_page_state(nr_dirty);
 			radix_tree_tag_set(&mapping->page_tree,
 						page_index(page),
diff -uNrp /warthog/kernels/linux-2.6.11-rc4/fs/fs-writeback.c linux-2.6.11-rc4-memback/fs/fs-writeback.c
--- /warthog/kernels/linux-2.6.11-rc4/fs/fs-writeback.c	2005-02-14 12:18:51.000000000 +0000
+++ linux-2.6.11-rc4-memback/fs/fs-writeback.c	2005-03-07 13:27:24.000000000 +0000
@@ -315,7 +315,7 @@ sync_sb_inodes(struct super_block *sb, s
 		struct backing_dev_info *bdi = mapping->backing_dev_info;
 		long pages_skipped;
 
-		if (bdi->memory_backed) {
+		if (!bdi_cap_writeback_dirty(bdi)) {
 			list_move(&inode->i_list, &sb->s_dirty);
 			if (sb == blockdev_superblock) {
 				/*
@@ -566,7 +566,7 @@ int write_inode_now(struct inode *inode,
 		.sync_mode = WB_SYNC_ALL,
 	};
 
-	if (inode->i_mapping->backing_dev_info->memory_backed)
+	if (!mapping_cap_writeback_dirty(inode->i_mapping))
 		return 0;
 
 	might_sleep();
diff -uNrp /warthog/kernels/linux-2.6.11-rc4/fs/hugetlbfs/inode.c linux-2.6.11-rc4-memback/fs/hugetlbfs/inode.c
--- /warthog/kernels/linux-2.6.11-rc4/fs/hugetlbfs/inode.c	2005-02-14 12:18:51.000000000 +0000
+++ linux-2.6.11-rc4-memback/fs/hugetlbfs/inode.c	2005-03-08 11:09:21.000000000 +0000
@@ -40,7 +40,7 @@ static struct inode_operations hugetlbfs
 
 static struct backing_dev_info hugetlbfs_backing_dev_info = {
 	.ra_pages	= 0,	/* No readahead */
-	.memory_backed	= 1,	/* Does not contribute to dirty memory */
+	.capabilities	= BDI_CAP_NO_ACCT_DIRTY | BDI_CAP_NO_WRITEBACK,
 };
 
 int sysctl_hugetlb_shm_group;
diff -uNrp /warthog/kernels/linux-2.6.11-rc4/fs/ramfs/inode.c linux-2.6.11-rc4-memback/fs/ramfs/inode.c
--- /warthog/kernels/linux-2.6.11-rc4/fs/ramfs/inode.c	2005-02-14 12:18:53.000000000 +0000
+++ linux-2.6.11-rc4-memback/fs/ramfs/inode.c	2005-03-08 11:08:09.000000000 +0000
@@ -45,7 +45,9 @@ static struct inode_operations ramfs_dir
 
 static struct backing_dev_info ramfs_backing_dev_info = {
 	.ra_pages	= 0,	/* No readahead */
-	.memory_backed	= 1,	/* Does not contribute to dirty memory */
+	.capabilities	= BDI_CAP_NO_ACCT_DIRTY | BDI_CAP_NO_WRITEBACK |
+			  BDI_CAP_MAP_DIRECT | BDI_CAP_MAP_COPY |
+			  BDI_CAP_READ_MAP | BDI_CAP_WRITE_MAP | BDI_CAP_EXEC_MAP,
 };
 
 struct inode *ramfs_get_inode(struct super_block *sb, int mode, dev_t dev)
diff -uNrp /warthog/kernels/linux-2.6.11-rc4/fs/sysfs/inode.c linux-2.6.11-rc4-memback/fs/sysfs/inode.c
--- /warthog/kernels/linux-2.6.11-rc4/fs/sysfs/inode.c	2005-01-04 11:13:43.000000000 +0000
+++ linux-2.6.11-rc4-memback/fs/sysfs/inode.c	2005-03-08 11:12:24.000000000 +0000
@@ -23,7 +23,7 @@ static struct address_space_operations s
 
 static struct backing_dev_info sysfs_backing_dev_info = {
 	.ra_pages	= 0,	/* No readahead */
-	.memory_backed	= 1,	/* Does not contribute to dirty memory */
+	.capabilities	= BDI_CAP_NO_ACCT_DIRTY | BDI_CAP_NO_WRITEBACK,
 };
 
 struct inode * sysfs_new_inode(mode_t mode)
diff -uNrp /warthog/kernels/linux-2.6.11-rc4/mm/filemap.c linux-2.6.11-rc4-memback/mm/filemap.c
--- /warthog/kernels/linux-2.6.11-rc4/mm/filemap.c	2005-02-14 12:19:04.000000000 +0000
+++ linux-2.6.11-rc4-memback/mm/filemap.c	2005-03-07 13:25:50.000000000 +0000
@@ -172,7 +172,7 @@ static int __filemap_fdatawrite_range(st
 		.end = end,
 	};
 
-	if (mapping->backing_dev_info->memory_backed)
+	if (!mapping_cap_writeback_dirty(mapping))
 		return 0;
 
 	ret = do_writepages(mapping, &wbc);
@@ -269,7 +269,7 @@ int sync_page_range(struct inode *inode,
 	pgoff_t end = (pos + count - 1) >> PAGE_CACHE_SHIFT;
 	int ret;
 
-	if (mapping->backing_dev_info->memory_backed || !count)
+	if (!mapping_cap_writeback_dirty(mapping) || !count)
 		return 0;
 	ret = filemap_fdatawrite_range(mapping, pos, pos + count - 1);
 	if (ret == 0) {
@@ -295,7 +295,7 @@ int sync_page_range_nolock(struct inode 
 	pgoff_t end = (pos + count - 1) >> PAGE_CACHE_SHIFT;
 	int ret;
 
-	if (mapping->backing_dev_info->memory_backed || !count)
+	if (!mapping_cap_writeback_dirty(mapping) || !count)
 		return 0;
 	ret = filemap_fdatawrite_range(mapping, pos, pos + count - 1);
 	if (ret == 0)
diff -uNrp /warthog/kernels/linux-2.6.11-rc4/mm/page-writeback.c linux-2.6.11-rc4-memback/mm/page-writeback.c
--- /warthog/kernels/linux-2.6.11-rc4/mm/page-writeback.c	2005-02-14 12:19:04.000000000 +0000
+++ linux-2.6.11-rc4-memback/mm/page-writeback.c	2005-03-07 13:26:25.000000000 +0000
@@ -605,7 +605,7 @@ int __set_page_dirty_nobuffers(struct pa
 			mapping2 = page_mapping(page);
 			if (mapping2) { /* Race with truncate? */
 				BUG_ON(mapping2 != mapping);
-				if (!mapping->backing_dev_info->memory_backed)
+				if (mapping_cap_account_dirty(mapping))
 					inc_page_state(nr_dirty);
 				radix_tree_tag_set(&mapping->page_tree,
 					page_index(page), PAGECACHE_TAG_DIRTY);
@@ -691,7 +691,7 @@ int test_clear_page_dirty(struct page *p
 						page_index(page),
 						PAGECACHE_TAG_DIRTY);
 			spin_unlock_irqrestore(&mapping->tree_lock, flags);
-			if (!mapping->backing_dev_info->memory_backed)
+			if (mapping_cap_account_dirty(mapping))
 				dec_page_state(nr_dirty);
 			return 1;
 		}
@@ -722,7 +722,7 @@ int clear_page_dirty_for_io(struct page 
 
 	if (mapping) {
 		if (TestClearPageDirty(page)) {
-			if (!mapping->backing_dev_info->memory_backed)
+			if (mapping_cap_account_dirty(mapping))
 				dec_page_state(nr_dirty);
 			return 1;
 		}
diff -uNrp /warthog/kernels/linux-2.6.11-rc4/mm/readahead.c linux-2.6.11-rc4-memback/mm/readahead.c
--- /warthog/kernels/linux-2.6.11-rc4/mm/readahead.c	2005-02-14 12:19:04.000000000 +0000
+++ linux-2.6.11-rc4-memback/mm/readahead.c	2005-03-08 11:05:04.000000000 +0000
@@ -23,6 +23,7 @@ EXPORT_SYMBOL(default_unplug_io_fn);
 struct backing_dev_info default_backing_dev_info = {
 	.ra_pages	= (VM_MAX_READAHEAD * 1024) / PAGE_CACHE_SIZE,
 	.state		= 0,
+	.capabilities	= BDI_CAP_MAP_COPY,
 	.unplug_io_fn	= default_unplug_io_fn,
 };
 EXPORT_SYMBOL_GPL(default_backing_dev_info);
diff -uNrp /warthog/kernels/linux-2.6.11-rc4/mm/shmem.c linux-2.6.11-rc4-memback/mm/shmem.c
--- /warthog/kernels/linux-2.6.11-rc4/mm/shmem.c	2005-02-14 12:19:04.000000000 +0000
+++ linux-2.6.11-rc4-memback/mm/shmem.c	2005-03-08 11:34:52.000000000 +0000
@@ -184,8 +184,8 @@ static struct vm_operations_struct shmem
 
 static struct backing_dev_info shmem_backing_dev_info = {
 	.ra_pages	= 0,	/* No readahead */
-	.memory_backed	= 1,	/* Does not contribute to dirty memory */
-	.unplug_io_fn = default_unplug_io_fn,
+	.capabilities	= BDI_CAP_NO_ACCT_DIRTY | BDI_CAP_NO_WRITEBACK,
+	.unplug_io_fn	= default_unplug_io_fn,
 };
 
 static LIST_HEAD(shmem_swaplist);
diff -uNrp /warthog/kernels/linux-2.6.11-rc4/mm/swap_state.c linux-2.6.11-rc4-memback/mm/swap_state.c
--- /warthog/kernels/linux-2.6.11-rc4/mm/swap_state.c	2005-02-14 12:19:04.000000000 +0000
+++ linux-2.6.11-rc4-memback/mm/swap_state.c	2005-03-08 11:07:41.000000000 +0000
@@ -29,7 +29,7 @@ static struct address_space_operations s
 };
 
 static struct backing_dev_info swap_backing_dev_info = {
-	.memory_backed	= 1,	/* Does not contribute to dirty memory */
+	.capabilities	= BDI_CAP_NO_ACCT_DIRTY | BDI_CAP_NO_WRITEBACK,
 	.unplug_io_fn	= swap_unplug_io_fn,
 };
 
