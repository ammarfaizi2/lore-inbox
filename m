Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317809AbSHKHYo>; Sun, 11 Aug 2002 03:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317893AbSHKHYo>; Sun, 11 Aug 2002 03:24:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28678 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317809AbSHKHYm>;
	Sun, 11 Aug 2002 03:24:42 -0400
Message-ID: <3D56146B.C3CAB5E1@zip.com.au>
Date: Sun, 11 Aug 2002 00:38:19 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 1/21] random fixes
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, but there's a ton of stuff here.  It ends up as a 4600 line
diff.  Some code dating back to 2.5.24.  It's almost all performance
work and it has been very painful getting its effectiveness tested
on the big machines; the main problem has been getting them booting
2.5 at all.  The results still are not as conclusive as I'd like,
but the signs are good, and there are no other proposals around to
fix these problems.



This one is mainly a resend.

- I changed the sector_t thing in max_block to use davem's approach. 
  I agree with Anton, but making it explicit doesn't hurt.

- Remove a dead comment in copy_strings.

Old stuff:

- Remove the IO error warning in end_buffer_io_sync().  Failed READA
  attempts trigger it.

- Emit a warning when an ext2 is mounting an ext3 filesystem.

  We have had quite a few problem reports related to this, mainly
  arising from initrd problems.  And mount(8) tends to report the
  fstype from /etc/fstab rather than reporting what has really
  happened.

Fixes some bogosity which I added to max_block():

- `size' doesn't need to be sector_t

- `retval' should not be initialised to "~0UL" because that is
  0x00000000ffffffff with 64-bit sector_t.

- Allocate task_structs with GFP_KERNEL, as discussed.

- Convert the EXPORT_SYMBOL for generic_file_direct_IO() to
  EXPORT_SYMBOL_GPL.  That was only exported as a practicality for the
  raw driver.

- Make the loop thread run balance_dirty_pages() after dirtying the
  backing file.  So it will perform writeback of the backing file when
  dirty memory levels are high.  Export balance_dirty_pages to GPL
  modules for this.

  This makes loop work a lot better - I suspect it broke when callers
  of balance_dirty_pages() started writing back only their own queue.

  There are many page allocation failures under heavy loop writeout. 
  Coming from blk_queue_bounce()'s allocation from the page_pool
  mempool.  So...

- Disable page allocation warnings around the initial atomic
  allocation attempt in mempool_alloc() - the one where __GFP_WAIT and
  __GFP_IO were turned off.  That one can easily fail.

- Add some commentary in block_write_full_page()


 drivers/block/loop.c |    2 ++
 fs/block_dev.c       |    6 +++---
 fs/buffer.c          |   13 +++++++++++--
 fs/exec.c            |    5 -----
 fs/ext2/super.c      |    3 +++
 kernel/fork.c        |    5 +++--
 kernel/ksyms.c       |    2 +-
 mm/mempool.c         |    2 ++
 mm/page-writeback.c  |    1 +
 9 files changed, 26 insertions(+), 13 deletions(-)

--- 2.5.31/fs/buffer.c~misc	Sat Aug 10 23:23:35 2002
+++ 2.5.31-akpm/fs/buffer.c	Sat Aug 10 23:23:35 2002
@@ -180,7 +180,10 @@ void end_buffer_io_sync(struct buffer_he
 	if (uptodate) {
 		set_buffer_uptodate(bh);
 	} else {
-		buffer_io_error(bh);
+		/*
+		 * This happens, due to failed READA attempts.
+		 * buffer_io_error(bh);
+		 */
 		clear_buffer_uptodate(bh);
 	}
 	unlock_buffer(bh);
@@ -2283,7 +2286,13 @@ int block_write_full_page(struct page *p
 		return -EIO;
 	}
 
-	/* The page straddles i_size */
+	/*
+	 * The page straddles i_size.  It must be zeroed out on each and every
+	 * writepage invokation because it may be mmapped.  "A file is mapped
+	 * in multiples of the page size.  For a file that is not a multiple of
+	 * the  page size, the remaining memory is zeroed when mapped, and
+	 * writes to that region are not written out to the file."
+	 */
 	kaddr = kmap(page);
 	memset(kaddr + offset, 0, PAGE_CACHE_SIZE - offset);
 	flush_dcache_page(page);
--- 2.5.31/fs/block_dev.c~misc	Sat Aug 10 23:23:35 2002
+++ 2.5.31-akpm/fs/block_dev.c	Sat Aug 10 23:23:35 2002
@@ -26,12 +26,12 @@
 
 static sector_t max_block(struct block_device *bdev)
 {
-	sector_t retval = ~0U;
+	sector_t retval = ~((sector_t)0);
 	loff_t sz = bdev->bd_inode->i_size;
 
 	if (sz) {
-		sector_t size = block_size(bdev);
-		unsigned sizebits = blksize_bits(size);
+		unsigned int size = block_size(bdev);
+		unsigned int sizebits = blksize_bits(size);
 		retval = (sz >> sizebits);
 	}
 	return retval;
--- 2.5.31/fs/ext2/super.c~misc	Sat Aug 10 23:23:35 2002
+++ 2.5.31-akpm/fs/ext2/super.c	Sat Aug 10 23:23:35 2002
@@ -698,6 +698,9 @@ static int ext2_fill_super(struct super_
 			printk(KERN_ERR "EXT2-fs: get root inode failed\n");
 		goto failed_mount2;
 	}
+	if (EXT2_HAS_COMPAT_FEATURE(sb, EXT3_FEATURE_COMPAT_HAS_JOURNAL))
+		ext2_warning(sb, __FUNCTION__,
+			"mounting ext3 filesystem as ext2\n");
 	ext2_setup_super (sb, es, sb->s_flags & MS_RDONLY);
 	return 0;
 failed_mount2:
--- 2.5.31/kernel/fork.c~misc	Sat Aug 10 23:23:35 2002
+++ 2.5.31-akpm/kernel/fork.c	Sat Aug 10 23:23:35 2002
@@ -106,9 +106,10 @@ static struct task_struct *dup_task_stru
 	struct thread_info *ti;
 
 	ti = alloc_thread_info();
-	if (!ti) return NULL;
+	if (!ti)
+		return NULL;
 
-	tsk = kmem_cache_alloc(task_struct_cachep,GFP_ATOMIC);
+	tsk = kmem_cache_alloc(task_struct_cachep, GFP_KERNEL);
 	if (!tsk) {
 		free_thread_info(ti);
 		return NULL;
--- 2.5.31/kernel/ksyms.c~misc	Sat Aug 10 23:23:35 2002
+++ 2.5.31-akpm/kernel/ksyms.c	Sat Aug 10 23:23:35 2002
@@ -340,7 +340,7 @@ EXPORT_SYMBOL(register_disk);
 EXPORT_SYMBOL(read_dev_sector);
 EXPORT_SYMBOL(init_buffer);
 EXPORT_SYMBOL(wipe_partitions);
-EXPORT_SYMBOL(generic_file_direct_IO);
+EXPORT_SYMBOL_GPL(generic_file_direct_IO);
 
 /* tty routines */
 EXPORT_SYMBOL(tty_hangup);
--- 2.5.31/drivers/block/loop.c~misc	Sat Aug 10 23:23:35 2002
+++ 2.5.31-akpm/drivers/block/loop.c	Sat Aug 10 23:23:35 2002
@@ -74,6 +74,7 @@
 #include <linux/slab.h>
 #include <linux/loop.h>
 #include <linux/suspend.h>
+#include <linux/writeback.h>
 #include <linux/buffer_head.h>		/* for invalidate_bdev() */
 
 #include <asm/uaccess.h>
@@ -235,6 +236,7 @@ do_lo_send(struct loop_device *lo, struc
 	up(&mapping->host->i_sem);
 out:
 	kunmap(bvec->bv_page);
+	balance_dirty_pages(mapping);
 	return ret;
 
 unlock:
--- 2.5.31/mm/page-writeback.c~misc	Sat Aug 10 23:23:35 2002
+++ 2.5.31-akpm/mm/page-writeback.c	Sat Aug 10 23:23:35 2002
@@ -133,6 +133,7 @@ void balance_dirty_pages(struct address_
 	if (!writeback_in_progress(bdi) && ps.nr_dirty > background_thresh)
 		pdflush_operation(background_writeout, 0);
 }
+EXPORT_SYMBOL_GPL(balance_dirty_pages);
 
 /**
  * balance_dirty_pages_ratelimited - balance dirty memory state
--- 2.5.31/mm/mempool.c~misc	Sat Aug 10 23:23:35 2002
+++ 2.5.31-akpm/mm/mempool.c	Sat Aug 10 23:23:35 2002
@@ -189,7 +189,9 @@ void * mempool_alloc(mempool_t *pool, in
 	int gfp_nowait = gfp_mask & ~(__GFP_WAIT | __GFP_IO);
 
 repeat_alloc:
+	current->flags |= PF_NOWARN;
 	element = pool->alloc(gfp_nowait, pool->pool_data);
+	current->flags &= ~PF_NOWARN;
 	if (likely(element != NULL))
 		return element;
 
--- 2.5.31/fs/exec.c~misc	Sat Aug 10 23:23:40 2002
+++ 2.5.31-akpm/fs/exec.c	Sat Aug 10 23:24:12 2002
@@ -209,11 +209,6 @@ int copy_strings(int argc,char ** argv, 
 		/* XXX: add architecture specific overflow check here. */ 
 		pos = bprm->p;
 
-		/*
-		 * The only sleeping function which we are allowed to call in
-		 * this loop is copy_from_user().  Otherwise, copy_user_state
-		 * could get trashed.
-		 */
 		while (len > 0) {
 			int i, new, err;
 			int offset, bytes_to_copy;

.
