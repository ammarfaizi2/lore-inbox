Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315198AbSGDXxY>; Thu, 4 Jul 2002 19:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315370AbSGDXvu>; Thu, 4 Jul 2002 19:51:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33805 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315120AbSGDXpo>;
	Thu, 4 Jul 2002 19:45:44 -0400
Message-ID: <3D24E01F.20632F2D@zip.com.au>
Date: Thu, 04 Jul 2002 16:54:07 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 7/27] misc cleanups and fixes
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



- Comment and documentation fixlets

- Remove some unneeded fields from swapper_inode (these are a
  leftover from when I had swap using the filesystem IO functions).

- fix a printk bug in pci/pool.c: when dma_addr_t is 64 bit it
  generates a compile warning, and will print out garbage.  Cast it to
  unsigned long long.

- Convert some writeback #defines into enums (Steven Augart)




 Documentation/filesystems/porting |    4 +++-
 drivers/pci/pool.c                |    8 ++++----
 fs/block_dev.c                    |    2 --
 fs/fs-writeback.c                 |    5 +++--
 include/linux/writeback.h         |   16 ++++++++++------
 mm/page_io.c                      |    2 +-
 mm/swap_state.c                   |    7 -------
 7 files changed, 21 insertions(+), 23 deletions(-)

--- 2.5.24/mm/page_io.c~misc	Thu Jul  4 16:17:14 2002
+++ 2.5.24-akpm/mm/page_io.c	Thu Jul  4 16:22:12 2002
@@ -130,7 +130,7 @@ out:
  * swapper_space doesn't have a real inode, so it gets a special vm_writeback()
  * so we don't need swap special cases in generic_vm_writeback().
  *
- * Swap pages are PageLocked and PageWriteback while under writeout so that
+ * Swap pages are !PageLocked and PageWriteback while under writeout so that
  * memory allocators will throttle against them.
  */
 static int swap_vm_writeback(struct page *page, int *nr_to_write)
--- 2.5.24/mm/swap_state.c~misc	Thu Jul  4 16:17:14 2002
+++ 2.5.24-akpm/mm/swap_state.c	Thu Jul  4 16:22:09 2002
@@ -21,16 +21,9 @@
 /*
  * swapper_inode doesn't do anything much.  It is really only here to
  * avoid some special-casing in other parts of the kernel.
- *
- * We set i_size to "infinity" to keep the page I/O functions happy.  The swap
- * block allocator makes sure that allocations are in-range.  A strange
- * number is chosen to prevent various arith overflows elsewhere.  For example,
- * `lblock' in block_read_full_page().
  */
 static struct inode swapper_inode = {
 	i_mapping:	&swapper_space,
-	i_size:		PAGE_SIZE * 0xffffffffLL,
-	i_blkbits:	PAGE_SHIFT,
 };
 
 extern struct address_space_operations swap_aops;
--- 2.5.24/Documentation/filesystems/porting~misc	Thu Jul  4 16:17:14 2002
+++ 2.5.24-akpm/Documentation/filesystems/porting	Thu Jul  4 16:17:14 2002
@@ -3,11 +3,13 @@ Changes since 2.5.0:
 --- 
 [recommended]
 
-New helpers: sb_bread(), sb_getblk(), sb_get_hash_table(), set_bh(),
+New helpers: sb_bread(), sb_getblk(), sb_find_get_block(), set_bh(),
 	sb_set_blocksize() and sb_min_blocksize().
 
 Use them.
 
+(sb_find_get_block() replaces 2.4's get_hash_table())
+
 --- 
 [recommended]
 
--- 2.5.24/fs/block_dev.c~misc	Thu Jul  4 16:17:14 2002
+++ 2.5.24-akpm/fs/block_dev.c	Thu Jul  4 16:17:14 2002
@@ -23,8 +23,6 @@
 
 #include <asm/uaccess.h>
 
-#define MAX_BUF_PER_PAGE (PAGE_CACHE_SIZE / 512)
-
 static unsigned long max_block(struct block_device *bdev)
 {
 	unsigned int retval = ~0U;
--- 2.5.24/drivers/pci/pool.c~misc	Thu Jul  4 16:17:14 2002
+++ 2.5.24-akpm/drivers/pci/pool.c	Thu Jul  4 16:17:14 2002
@@ -303,15 +303,15 @@ pci_pool_free (struct pci_pool *pool, vo
 
 #ifdef	CONFIG_DEBUG_SLAB
 	if (((dma - page->dma) + (void *)page->vaddr) != vaddr) {
-		printk (KERN_ERR "pci_pool_free %s/%s, %p (bad vaddr)/%lx\n",
+		printk (KERN_ERR "pci_pool_free %s/%s, %p (bad vaddr)/%Lx\n",
 			pool->dev ? pool->dev->slot_name : NULL,
-			pool->name, vaddr, (unsigned long) dma);
+			pool->name, vaddr, (unsigned long long) dma);
 		return;
 	}
 	if (page->bitmap [map] & (1UL << block)) {
-		printk (KERN_ERR "pci_pool_free %s/%s, dma %x already free\n",
+		printk (KERN_ERR "pci_pool_free %s/%s, dma %Lx already free\n",
 			pool->dev ? pool->dev->slot_name : NULL,
-			pool->name, dma);
+			pool->name, (unsigned long long)dma);
 		return;
 	}
 	memset (vaddr, POOL_POISON_BYTE, pool->size);
--- 2.5.24/include/linux/writeback.h~misc	Thu Jul  4 16:17:14 2002
+++ 2.5.24-akpm/include/linux/writeback.h	Thu Jul  4 16:22:12 2002
@@ -24,18 +24,22 @@ static inline int current_is_pdflush(voi
 /*
  * fs/fs-writeback.c
  */
-#define WB_SYNC_NONE	0	/* Don't wait on anything */
-#define WB_SYNC_LAST	1	/* Wait on the last-written mapping */
-#define WB_SYNC_ALL	2	/* Wait on every mapping */
-#define WB_SYNC_HOLD	3	/* Hold the inode on sb_dirty for sys_sync() */
+enum writeback_sync_modes {
+	WB_SYNC_NONE =  0,	/* Don't wait on anything */
+	WB_SYNC_LAST =  1,	/* Wait on the last-written mapping */
+	WB_SYNC_ALL =   2,	/* Wait on every mapping */
+	WB_SYNC_HOLD =  3,	/* Hold the inode on sb_dirty for sys_sync() */
+};
 
-void writeback_unlocked_inodes(int *nr_to_write, int sync_mode,
-				unsigned long *older_than_this);
+void writeback_unlocked_inodes(int *nr_to_write,
+			       enum writeback_sync_modes sync_mode,
+			       unsigned long *older_than_this);
 void wake_up_inode(struct inode *inode);
 void __wait_on_inode(struct inode * inode);
 void sync_inodes_sb(struct super_block *, int wait);
 void sync_inodes(int wait);
 
+/* writeback.h requires fs.h; it, too, is not included from here. */
 static inline void wait_on_inode(struct inode *inode)
 {
 	if (inode->i_state & I_LOCK)
--- 2.5.24/fs/fs-writeback.c~misc	Thu Jul  4 16:17:14 2002
+++ 2.5.24-akpm/fs/fs-writeback.c	Thu Jul  4 16:22:11 2002
@@ -287,8 +287,9 @@ out:
  *
  * This is a "memory cleansing" operation, not a "data integrity" operation.
  */
-void writeback_unlocked_inodes(int *nr_to_write, int sync_mode,
-				unsigned long *older_than_this)
+void writeback_unlocked_inodes(int *nr_to_write,
+			       enum writeback_sync_modes sync_mode,
+			       unsigned long *older_than_this)
 {
 	struct super_block *sb;
 

-
