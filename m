Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318168AbSH1ETu>; Wed, 28 Aug 2002 00:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318696AbSH1ETu>; Wed, 28 Aug 2002 00:19:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63249 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318168AbSH1ETh>;
	Wed, 28 Aug 2002 00:19:37 -0400
Message-ID: <3D6C5307.3AF15D66@zip.com.au>
Date: Tue, 27 Aug 2002 21:35:19 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] increased accuracy of dirty memory accounting
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Some adjustments to global dirty page accounting.

Previously, dirty page accounting counted all dirty pages.  Even dirty
anonymous pages.  This has potential to upset the throttling logic in
balance_dirty_pages().  Particularly as I suspect we should decrease
the dirty memory writeback thresholds by a lot.

So this patch changes it so that we only account for dirty pagecache
pages which have backing store.  Not anonymous pages, not swapcache,
not in-memory filesystem pages.

To support this, the `memory_backed' boolean has been added to struct
backing_dev_info.  When an address space's backing device is marked as
memory-backed, the core kernel knows to not include that mapping's
pages in the dirty memory accounting.

For memory-backed mappings, dirtiness is a way of pinning the page, and
there's nothing the kernel can to do clean the page to make it freeable.

driverfs, tmpfs, and ranfs have been coverted to mark their mappings as
memory-backed.

The ramdisk driver hasn't been converted.  I have a separate patch for
ramdisk, which fails to fix the longstanding problems in there :(

With this patch, /bin/sync now sends /proc/meminfo:Dirty to zero, which
is rather comforting.



 fs/buffer.c                 |    2 -
 fs/driverfs/inode.c         |    7 ++++++
 fs/mpage.c                  |    2 -
 fs/ramfs/inode.c            |    9 +++++++-
 include/linux/backing-dev.h |    1 
 include/linux/page-flags.h  |   45 ++++++++++++--------------------------------
 mm/filemap.c                |    8 +++----
 mm/page-writeback.c         |   22 +++++++++++++++++++--
 mm/shmem.c                  |    7 ++++++
 mm/swap_state.c             |   29 +++++++++++++++++-----------
 10 files changed, 80 insertions(+), 52 deletions(-)

--- 2.5.32/include/linux/backing-dev.h~dirty-state-accounting	Tue Aug 27 21:32:04 2002
+++ 2.5.32-akpm/include/linux/backing-dev.h	Tue Aug 27 21:32:05 2002
@@ -19,6 +19,7 @@ enum bdi_state {
 struct backing_dev_info {
 	unsigned long ra_pages;	/* max readahead in PAGE_CACHE_SIZE units */
 	unsigned long state;	/* Always use atomic bitops on this */
+	int memory_backed;	/* Cannot clean pages with writepage */
 };
 
 extern struct backing_dev_info default_backing_dev_info;
--- 2.5.32/mm/page-writeback.c~dirty-state-accounting	Tue Aug 27 21:32:04 2002
+++ 2.5.32-akpm/mm/page-writeback.c	Tue Aug 27 21:32:05 2002
@@ -350,7 +350,7 @@ int generic_vm_writeback(struct page *pa
 #if 0
 		if (!PageWriteback(page) && PageDirty(page)) {
 			lock_page(page);
-			if (!PageWriteback(page) && TestClearPageDirty(page)) {
+			if (!PageWriteback(page)&&test_clear_page_dirty(page)) {
 				int ret;
 
 				ret = page->mapping->a_ops->writepage(page);
@@ -395,7 +395,7 @@ int write_one_page(struct page *page, in
 
 	write_lock(&mapping->page_lock);
 	list_del(&page->list);
-	if (TestClearPageDirty(page)) {
+	if (test_clear_page_dirty(page)) {
 		list_add(&page->list, &mapping->locked_pages);
 		page_cache_get(page);
 		write_unlock(&mapping->page_lock);
@@ -487,6 +487,8 @@ int __set_page_dirty_buffers(struct page
 	if (!TestSetPageDirty(page)) {
 		write_lock(&mapping->page_lock);
 		if (page->mapping) {	/* Race with truncate? */
+			if (!mapping->backing_dev_info->memory_backed)
+				inc_page_state(nr_dirty);
 			list_del(&page->list);
 			list_add(&page->list, &mapping->dirty_pages);
 		}
@@ -523,6 +525,8 @@ int __set_page_dirty_nobuffers(struct pa
 		if (mapping) {
 			write_lock(&mapping->page_lock);
 			if (page->mapping) {	/* Race with truncate? */
+				if (!mapping->backing_dev_info->memory_backed)
+					inc_page_state(nr_dirty);
 				list_del(&page->list);
 				list_add(&page->list, &mapping->dirty_pages);
 			}
@@ -534,4 +538,18 @@ int __set_page_dirty_nobuffers(struct pa
 }
 EXPORT_SYMBOL(__set_page_dirty_nobuffers);
 
+/*
+ * Clear a page's dirty flag, while caring for dirty memory accounting. 
+ * Returns true if the page was previously dirty.
+ */
+int test_clear_page_dirty(struct page *page)
+{
+	if (TestClearPageDirty(page)) {
+		struct address_space *mapping = page->mapping;
 
+		if (mapping && !mapping->backing_dev_info->memory_backed)
+			dec_page_state(nr_dirty);
+		return 1;
+	}
+	return 0;
+}
--- 2.5.32/include/linux/page-flags.h~dirty-state-accounting	Tue Aug 27 21:32:04 2002
+++ 2.5.32-akpm/include/linux/page-flags.h	Tue Aug 27 21:32:05 2002
@@ -52,7 +52,7 @@
 #define PG_referenced		 2
 #define PG_uptodate		 3
 
-#define PG_dirty_dontuse	 4
+#define PG_dirty	 	 4
 #define PG_lru			 5
 #define PG_active		 6
 #define PG_slab			 7	/* slab debug (Suparna wants this) */
@@ -120,37 +120,11 @@ extern void get_page_state(struct page_s
 #define SetPageUptodate(page)	set_bit(PG_uptodate, &(page)->flags)
 #define ClearPageUptodate(page)	clear_bit(PG_uptodate, &(page)->flags)
 
-#define PageDirty(page)		test_bit(PG_dirty_dontuse, &(page)->flags)
-#define SetPageDirty(page)						\
-	do {								\
-		if (!test_and_set_bit(PG_dirty_dontuse,			\
-					&(page)->flags))		\
-			inc_page_state(nr_dirty);			\
-	} while (0)
-#define TestSetPageDirty(page)						\
-	({								\
-		int ret;						\
-		ret = test_and_set_bit(PG_dirty_dontuse,		\
-				&(page)->flags);			\
-		if (!ret)						\
-			inc_page_state(nr_dirty);			\
-		ret;							\
-	})
-#define ClearPageDirty(page)						\
-	do {								\
-		if (test_and_clear_bit(PG_dirty_dontuse,		\
-				&(page)->flags))			\
-			dec_page_state(nr_dirty);			\
-	} while (0)
-#define TestClearPageDirty(page)					\
-	({								\
-		int ret;						\
-		ret = test_and_clear_bit(PG_dirty_dontuse,		\
-				&(page)->flags);			\
-		if (ret)						\
-			dec_page_state(nr_dirty);			\
-		ret;							\
-	})
+#define PageDirty(page)		test_bit(PG_dirty, &(page)->flags)
+#define SetPageDirty(page)	set_bit(PG_dirty, &(page)->flags)
+#define TestSetPageDirty(page)	test_and_set_bit(PG_dirty, &(page)->flags)
+#define ClearPageDirty(page)	clear_bit(PG_dirty, &(page)->flags)
+#define TestClearPageDirty(page) test_and_clear_bit(PG_dirty, &(page)->flags)
 
 #define SetPageLRU(page)	set_bit(PG_lru, &(page)->flags)
 #define PageLRU(page)		test_bit(PG_lru, &(page)->flags)
@@ -265,4 +239,11 @@ static inline void pte_chain_unlock(stru
 extern struct address_space swapper_space;
 #define PageSwapCache(page) ((page)->mapping == &swapper_space)
 
+int test_clear_page_dirty(struct page *page);
+
+static inline void clear_page_dirty(struct page *page)
+{
+	test_clear_page_dirty(page);
+}
+
 #endif	/* PAGE_FLAGS_H */
--- 2.5.32/fs/ramfs/inode.c~dirty-state-accounting	Tue Aug 27 21:32:04 2002
+++ 2.5.32-akpm/fs/ramfs/inode.c	Tue Aug 27 21:32:05 2002
@@ -30,6 +30,7 @@
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/smp_lock.h>
+#include <linux/backing-dev.h>
 
 #include <asm/uaccess.h>
 
@@ -41,6 +42,11 @@ static struct address_space_operations r
 static struct file_operations ramfs_file_operations;
 static struct inode_operations ramfs_dir_inode_operations;
 
+static struct backing_dev_info ramfs_backing_dev_info = {
+	.ra_pages	= 0,	/* No readahead */
+	.memory_backed	= 1,	/* Does not contribute to dirty memory */
+};
+
 /*
  * Read a page. Again trivial. If it didn't already exist
  * in the page cache, it is zero-filled.
@@ -69,7 +75,7 @@ static int ramfs_prepare_write(struct fi
 		kunmap_atomic(kaddr, KM_USER0);
 		SetPageUptodate(page);
 	}
-	SetPageDirty(page);
+	set_page_dirty(page);
 	return 0;
 }
 
@@ -95,6 +101,7 @@ struct inode *ramfs_get_inode(struct sup
 		inode->i_blocks = 0;
 		inode->i_rdev = NODEV;
 		inode->i_mapping->a_ops = &ramfs_aops;
+		inode->i_mapping->backing_dev_info = &ramfs_backing_dev_info;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 		switch (mode & S_IFMT) {
 		default:
--- 2.5.32/fs/buffer.c~dirty-state-accounting	Tue Aug 27 21:32:04 2002
+++ 2.5.32-akpm/fs/buffer.c	Tue Aug 27 21:32:05 2002
@@ -2513,7 +2513,7 @@ int try_to_free_buffers(struct page *pag
 		 * This only applies in the rare case where try_to_free_buffers
 		 * succeeds but the page is not freed.
 		 */
-		ClearPageDirty(page);
+		clear_page_dirty(page);
 	}
 	spin_unlock(&mapping->private_lock);
 out:
--- 2.5.32/fs/mpage.c~dirty-state-accounting	Tue Aug 27 21:32:05 2002
+++ 2.5.32-akpm/fs/mpage.c	Tue Aug 27 21:32:05 2002
@@ -571,7 +571,7 @@ mpage_writepages(struct address_space *m
 			wait_on_page_writeback(page);
 
 		if (page->mapping && !PageWriteback(page) &&
-					TestClearPageDirty(page)) {
+					test_clear_page_dirty(page)) {
 			if (writepage) {
 				ret = (*writepage)(page);
 			} else {
--- 2.5.32/mm/filemap.c~dirty-state-accounting	Tue Aug 27 21:32:05 2002
+++ 2.5.32-akpm/mm/filemap.c	Tue Aug 27 21:32:05 2002
@@ -181,7 +181,7 @@ static void truncate_complete_page(struc
 	if (PagePrivate(page))
 		do_invalidatepage(page, 0);
 
-	ClearPageDirty(page);
+	clear_page_dirty(page);
 	ClearPageUptodate(page);
 	remove_from_page_cache(page);
 	page_cache_release(page);
@@ -280,7 +280,7 @@ static void clean_list_pages(struct addr
 	for (curr = head->next; curr != head; curr = curr->next) {
 		page = list_entry(curr, struct page, list);
 		if (page->index > start)
-			ClearPageDirty(page);
+			clear_page_dirty(page);
 	}
 }
 
@@ -348,7 +348,7 @@ static inline int invalidate_this_page2(
 		} else
 			unlocked = 0;
 
-		ClearPageDirty(page);
+		clear_page_dirty(page);
 		ClearPageUptodate(page);
 	}
 
@@ -557,8 +557,8 @@ int add_to_page_cache(struct page *page,
 	error = radix_tree_insert(&mapping->page_tree, offset, page);
 	if (!error) {
 		SetPageLocked(page);
-		ClearPageDirty(page);
 		___add_to_page_cache(page, mapping, offset);
+		ClearPageDirty(page);
 	} else {
 		page_cache_release(page);
 	}
--- 2.5.32/fs/driverfs/inode.c~dirty-state-accounting	Tue Aug 27 21:32:05 2002
+++ 2.5.32-akpm/fs/driverfs/inode.c	Tue Aug 27 21:32:05 2002
@@ -32,6 +32,7 @@
 #include <linux/namei.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/backing-dev.h>
 #include <linux/driverfs_fs.h>
 
 #include <asm/uaccess.h>
@@ -56,6 +57,11 @@ static struct vfsmount *driverfs_mount;
 static spinlock_t mount_lock = SPIN_LOCK_UNLOCKED;
 static int mount_count = 0;
 
+static struct backing_dev_info driverfs_backing_dev_info = {
+	.ra_pages	= 0,	/* No readahead */
+	.memory_backed	= 1,	/* Does not contribute to dirty memory */
+};
+
 static int driverfs_readpage(struct file *file, struct page * page)
 {
 	if (!PageUptodate(page)) {
@@ -108,6 +114,7 @@ struct inode *driverfs_get_inode(struct 
 		inode->i_rdev = NODEV;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 		inode->i_mapping->a_ops = &driverfs_aops;
+		inode->i_mapping->backing_dev_info = &driverfs_backing_dev_info;
 		switch (mode & S_IFMT) {
 		default:
 			init_special_inode(inode, mode, dev);
--- 2.5.32/mm/shmem.c~dirty-state-accounting	Tue Aug 27 21:32:05 2002
+++ 2.5.32-akpm/mm/shmem.c	Tue Aug 27 21:32:05 2002
@@ -29,6 +29,7 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
+#include <linux/backing-dev.h>
 #include <linux/shmem_fs.h>
 
 #include <asm/uaccess.h>
@@ -56,6 +57,11 @@ static struct inode_operations shmem_ino
 static struct inode_operations shmem_dir_inode_operations;
 static struct vm_operations_struct shmem_vm_ops;
 
+static struct backing_dev_info shmem_backing_dev_info = {
+	.ra_pages	= 0,	/* No readahead */
+	.memory_backed	= 1,	/* Does not contribute to dirty memory */
+};
+
 LIST_HEAD (shmem_inodes);
 static spinlock_t shmem_ilock = SPIN_LOCK_UNLOCKED;
 atomic_t shmem_nrpages = ATOMIC_INIT(0); /* Not used right now */
@@ -789,6 +795,7 @@ struct inode *shmem_get_inode(struct sup
 		inode->i_blocks = 0;
 		inode->i_rdev = NODEV;
 		inode->i_mapping->a_ops = &shmem_aops;
+		inode->i_mapping->backing_dev_info = &shmem_backing_dev_info;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 		info = SHMEM_I(inode);
 		spin_lock_init (&info->lock);
--- 2.5.32/mm/swap_state.c~dirty-state-accounting	Tue Aug 27 21:32:05 2002
+++ 2.5.32-akpm/mm/swap_state.c	Tue Aug 27 21:32:05 2002
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
+#include <linux/backing-dev.h>
 #include <linux/buffer_head.h>	/* block_sync_page() */
 
 #include <asm/pgtable.h>
@@ -25,20 +26,26 @@ static struct inode swapper_inode = {
 	.i_mapping	= &swapper_space,
 };
 
+static struct backing_dev_info swap_backing_dev_info = {
+	.ra_pages	= 0,	/* No readahead */
+	.memory_backed	= 1,	/* Does not contribute to dirty memory */
+};
+
 extern struct address_space_operations swap_aops;
 
 struct address_space swapper_space = {
-	.page_tree	= RADIX_TREE_INIT(GFP_ATOMIC),
-	.page_lock	= RW_LOCK_UNLOCKED,
-	.clean_pages	= LIST_HEAD_INIT(swapper_space.clean_pages),
-	.dirty_pages	= LIST_HEAD_INIT(swapper_space.dirty_pages),
-	.io_pages	= LIST_HEAD_INIT(swapper_space.io_pages),
-	.locked_pages	= LIST_HEAD_INIT(swapper_space.locked_pages),
-	.host		= &swapper_inode,
-	.a_ops		= &swap_aops,
-	.i_shared_lock	= SPIN_LOCK_UNLOCKED,
-	.private_lock	= SPIN_LOCK_UNLOCKED,
-	.private_list	= LIST_HEAD_INIT(swapper_space.private_list),
+	.page_tree		= RADIX_TREE_INIT(GFP_ATOMIC),
+	.page_lock		= RW_LOCK_UNLOCKED,
+	.clean_pages		= LIST_HEAD_INIT(swapper_space.clean_pages),
+	.dirty_pages		= LIST_HEAD_INIT(swapper_space.dirty_pages),
+	.io_pages		= LIST_HEAD_INIT(swapper_space.io_pages),
+	.locked_pages		= LIST_HEAD_INIT(swapper_space.locked_pages),
+	.host			= &swapper_inode,
+	.a_ops			= &swap_aops,
+	.backing_dev_info	= &swap_backing_dev_info,
+	.i_shared_lock		= SPIN_LOCK_UNLOCKED,
+	.private_lock		= SPIN_LOCK_UNLOCKED,
+	.private_list		= LIST_HEAD_INIT(swapper_space.private_list),
 };
 
 #define INC_CACHE_INFO(x)	do { swap_cache_info.x++; } while (0)

.
