Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316788AbSFQGvt>; Mon, 17 Jun 2002 02:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316828AbSFQGu7>; Mon, 17 Jun 2002 02:50:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24590 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316792AbSFQGsq>;
	Mon, 17 Jun 2002 02:48:46 -0400
Message-ID: <3D0D873A.405ED0BB@zip.com.au>
Date: Sun, 16 Jun 2002 23:52:42 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>, Hugh Dickins <hugh@veritas.com>
Subject: [patch 10/19] direct-to-BIO I/O for swapcache pages
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This patch changes the swap I/O handling.  The objectives are:

- Remove swap special-casing
- Stop using buffer_heads -> direct-to-BIO
- Make S_ISREG swapfiles more robust.

I've spent quite some time with swap.  The first patches converted swap to
use block_read/write_full_page().  These were discarded because they are
still using buffer_heads, and a reasonable amount of otherwise unnecessary
infrastructure had to be added to the swap code just to make it look like a
regular fs.  So this code just has a custom direct-to-BIO path for swap,
which seems to be the most comfortable approach.

A significant thing here is the introduction of "swap extents".  A swap
extent is a simple data structure which maps a range of swap pages onto a
range of disk sectors.  It is simply:

	struct swap_extent {
		struct list_head list;
		pgoff_t start_page;
		pgoff_t nr_pages;
		sector_t start_block;
	};

At swapon time (for an S_ISREG swapfile), each block in the file is bmapped()
and the block numbers are parsed to generate the device's swap extent list. 
This extent list is quite compact - a 512 megabyte swapfile generates about
130 nodes in the list.  That's about 4 kbytes of storage.  The conversion
from filesystem blocksize blocks into PAGE_SIZE blocks is performed at swapon
time.

At swapon time (for an S_ISBLK swapfile), we install a single swap extent
which describes the entire device.

The advantages of the swap extents are:

1: We never have to run bmap() (ie: read from disk) at swapout time.  So
   S_ISREG swapfiles are now just as robust as S_ISBLK swapfiles.  

2: All the differences between S_ISBLK swapfiles and S_ISREG swapfiles are
   handled at swapon time.  During normal operation, we just don't care. 
   Both types of swapfiles are handled the same way.

3: The extent lists always operate in PAGE_SIZE units.  So the problems of
   going from fs blocksize to PAGE_SIZE are handled at swapon time and normal
   operating code doesn't need to care.

4: Because we don't have to fiddle with different blocksizes, we can go
   direct-to-BIO for swap_readpage() and swap_writepage().  This introduces
   the kernel-wide invariant "anonymous pages never have buffers attached",
   which cleans some things up nicely.  All those block_flushpage() calls in
   the swap code simply go away.

5: The kernel no longer has to allocate both buffer_heads and BIOs to
   perform swapout.  Just a BIO.

6: It permits us to perform swapcache writeout and throttling for
   GFP_NOFS allocations (a later patch).

(Well, there is one sort of anon page which can have buffers: the pages which
are cast adrift in truncate_complete_page() because do_invalidatepage()
failed.  But these pages are never added to swapcache, and nobody except the
VM LRU has to deal with them).



The swapfile parser in setup_swap_extents() will attempt to extract the
largest possible number of PAGE_SIZE-sized and PAGE_SIZE-aligned chunks of
disk from the S_ISREG swapfile.  Any stray blocks (due to file
discontiguities) are simply discarded - we never swap to those.



If an S_ISREG swapfile is found to have any unmapped blocks (file holes) then
the swapon attempt will fail.



The extent list can be quite large (hundreds of nodes for a gigabyte S_ISREG
swapfile).  It needs to be consulted once for each page within
swap_readpage() and swap_writepage().  Hence there is a risk that we could
blow significant amounts of CPU walking that list.  However I have
implemented a "where we found the last block" cache, which is used as the
starting point for the next search.  Empirical testing indicates that this is
wildly effective - the average length of the list walk in map_swap_page() is
0.3 iterations per page, with a 130-element list.

It _could_ be that some workloads do start suffering long walks in that code,
and perhaps a tree would be needed there.  But I doubt that, and if this is
happening then it means that we're seeking all over the disk for swap I/O,
and the list walk is the least of our problems.



rw_swap_page_nolock() now takes a page*, not a kernel virtual address.  It
has been renamed to rw_swap_page_sync() and it takes care of locking and
unlocking the page itself.  Which is all a much better interface.



Support for type 0 swap has been removed.  Current versions of mkwap(8) seem
to never produce v0 swap unless you explicitly ask for it, so I doubt if this
will affect anyone.  If you _do_ have a type 0 swapfile, swapon will fail and
the message

	version 0 swap is no longer supported. Use mkswap -v1 /dev/sdb3

is printed.  We can remove that code for real later on.  Really, all that
swapfile header parsing should be pushed out to userspace.



This code always uses single-page BIOs for swapin and swapout.  I have an
additional patch which converts swap to use mpage_writepages(), so we swap
out in 16-page BIOs.  It works fine, but I don't intend to submit that. 
There just doesn't seem to be any significant advantage to it.


I can't see anything in sys_swapon()/sys_swapoff() which needs the
lock_kernel() calls, so I deleted them.


If you ftruncate an S_ISREG swapfile to a shorter size while it is in use,
subsequent swapout will destroy the filesystem.  It was always thus, but it
is much, much easier to do now.  Not really a kernel problem, but swapon(8)
should not be allowing the kernel to use swapfiles which are modifiable by
unprivileged users.


Incidentally.  The stale swapcache-page optimisation in this code:

static int swap_writepage(struct page *page)
{
	if (remove_exclusive_swap_page(page)) {
		unlock_page(page);
		return 0;
	}
	rw_swap_page(WRITE, page);
	return 0;
}

*never* seems to trigger.  You can stick a printk in there and watch it. 
This is unrelated to my changes.  So perhaps something has become broken in
there somewhere??




--- 2.5.22/fs/buffer.c~swap-bio	Sun Jun 16 22:50:18 2002
+++ 2.5.22-akpm/fs/buffer.c	Sun Jun 16 23:22:45 2002
@@ -492,7 +492,7 @@ static void free_more_memory(void)
 }
 
 /*
- * I/O completion handler for block_read_full_page() and brw_page() - pages
+ * I/O completion handler for block_read_full_page() - pages
  * which come unlocked at the end of I/O.
  */
 static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
@@ -551,9 +551,8 @@ still_busy:
 }
 
 /*
- * Completion handler for block_write_full_page() and for brw_page() - pages
- * which are unlocked during I/O, and which have PageWriteback cleared
- * upon I/O completion.
+ * Completion handler for block_write_full_page() - pages which are unlocked
+ * during I/O, and which have PageWriteback cleared upon I/O completion.
  */
 static void end_buffer_async_write(struct buffer_head *bh, int uptodate)
 {
@@ -1360,11 +1359,11 @@ int block_invalidatepage(struct page *pa
 {
 	struct buffer_head *head, *bh, *next;
 	unsigned int curr_off = 0;
+	int ret = 1;
 
-	if (!PageLocked(page))
-		BUG();
+	BUG_ON(!PageLocked(page));
 	if (!page_has_buffers(page))
-		return 1;
+		goto out;
 
 	head = page_buffers(page);
 	bh = head;
@@ -1386,12 +1385,10 @@ int block_invalidatepage(struct page *pa
 	 * The get_block cached value has been unconditionally invalidated,
 	 * so real IO is not possible anymore.
 	 */
-	if (offset == 0) {
-		if (!try_to_release_page(page, 0))
-			return 0;
-	}
-
-	return 1;
+	if (offset == 0)
+		ret = try_to_release_page(page, 0);
+out:
+	return ret;
 }
 EXPORT_SYMBOL(block_invalidatepage);
 
@@ -2269,57 +2266,6 @@ int brw_kiovec(int rw, int nr, struct ki
 }
 
 /*
- * Start I/O on a page.
- * This function expects the page to be locked and may return
- * before I/O is complete. You then have to check page->locked
- * and page->uptodate.
- *
- * FIXME: we need a swapper_inode->get_block function to remove
- *        some of the bmap kludges and interface ugliness here.
- */
-int brw_page(int rw, struct page *page,
-		struct block_device *bdev, sector_t b[], int size)
-{
-	struct buffer_head *head, *bh;
-
-	BUG_ON(!PageLocked(page));
-
-	if (!page_has_buffers(page))
-		create_empty_buffers(page, size, 0);
-	head = bh = page_buffers(page);
-
-	/* Stage 1: lock all the buffers */
-	do {
-		lock_buffer(bh);
-		bh->b_blocknr = *(b++);
-		bh->b_bdev = bdev;
-		set_buffer_mapped(bh);
-		if (rw == WRITE) {
-			set_buffer_uptodate(bh);
-			clear_buffer_dirty(bh);
-			mark_buffer_async_write(bh);
-		} else {
-			mark_buffer_async_read(bh);
-		}
-		bh = bh->b_this_page;
-	} while (bh != head);
-
-	if (rw == WRITE) {
-		BUG_ON(PageWriteback(page));
-		SetPageWriteback(page);
-		unlock_page(page);
-	}
-
-	/* Stage 2: start the IO */
-	do {
-		struct buffer_head *next = bh->b_this_page;
-		submit_bh(rw, bh);
-		bh = next;
-	} while (bh != head);
-	return 0;
-}
-
-/*
  * Sanity checks for try_to_free_buffers.
  */
 static void check_ttfb_buffer(struct page *page, struct buffer_head *bh)
--- 2.5.22/include/linux/buffer_head.h~swap-bio	Sun Jun 16 22:50:18 2002
+++ 2.5.22-akpm/include/linux/buffer_head.h	Sun Jun 16 23:22:46 2002
@@ -181,7 +181,6 @@ struct buffer_head * __bread(struct bloc
 void wakeup_bdflush(void);
 struct buffer_head *alloc_buffer_head(int async);
 void free_buffer_head(struct buffer_head * bh);
-int brw_page(int, struct page *, struct block_device *, sector_t [], int);
 void FASTCALL(unlock_buffer(struct buffer_head *bh));
 
 /*
--- 2.5.22/include/linux/swap.h~swap-bio	Sun Jun 16 22:50:18 2002
+++ 2.5.22-akpm/include/linux/swap.h	Sun Jun 16 22:50:18 2002
@@ -5,6 +5,7 @@
 #include <linux/kdev_t.h>
 #include <linux/linkage.h>
 #include <linux/mmzone.h>
+#include <linux/list.h>
 #include <asm/page.h>
 
 #define SWAP_FLAG_PREFER	0x8000	/* set if swap priority specified */
@@ -62,6 +63,21 @@ typedef struct {
 #ifdef __KERNEL__
 
 /*
+ * A swap extent maps a range of a swapfile's PAGE_SIZE pages onto a range of
+ * disk blocks.  A list of swap extents maps the entire swapfile.  (Where the
+ * term `swapfile' refers to either a blockdevice or an IS_REG file.  Apart
+ * from setup, they're handled identically.
+ *
+ * We always assume that blocks are of size PAGE_SIZE.
+ */
+struct swap_extent {
+	struct list_head list;
+	pgoff_t start_page;
+	pgoff_t nr_pages;
+	sector_t start_block;
+};
+
+/*
  * Max bad pages in the new format..
  */
 #define __swapoffset(x) ((unsigned long)&((union swap_header *)0)->x)
@@ -83,11 +99,17 @@ enum {
 
 /*
  * The in-memory structure used to track swap areas.
+ * extent_list.prev points at the lowest-index extent.  That list is
+ * sorted.
  */
 struct swap_info_struct {
 	unsigned int flags;
 	spinlock_t sdev_lock;
 	struct file *swap_file;
+	struct block_device *bdev;
+	struct list_head extent_list;
+	int nr_extents;
+	struct swap_extent *curr_swap_extent;
 	unsigned old_block_size;
 	unsigned short * swap_map;
 	unsigned int lowest_bit;
@@ -134,8 +156,9 @@ extern wait_queue_head_t kswapd_wait;
 extern int FASTCALL(try_to_free_pages(zone_t *, unsigned int, unsigned int));
 
 /* linux/mm/page_io.c */
-extern void rw_swap_page(int, struct page *);
-extern void rw_swap_page_nolock(int, swp_entry_t, char *);
+int swap_readpage(struct file *file, struct page *page);
+int swap_writepage(struct page *page);
+int rw_swap_page_sync(int rw, swp_entry_t entry, struct page *page);
 
 /* linux/mm/page_alloc.c */
 
@@ -163,12 +186,13 @@ extern unsigned int nr_swapfiles;
 extern struct swap_info_struct swap_info[];
 extern void si_swapinfo(struct sysinfo *);
 extern swp_entry_t get_swap_page(void);
-extern void get_swaphandle_info(swp_entry_t, unsigned long *, struct inode **);
 extern int swap_duplicate(swp_entry_t);
-extern int swap_count(struct page *);
 extern int valid_swaphandles(swp_entry_t, unsigned long *);
 extern void swap_free(swp_entry_t);
 extern void free_swap_and_cache(swp_entry_t);
+sector_t map_swap_page(struct swap_info_struct *p, pgoff_t offset);
+struct swap_info_struct *get_swap_info_struct(unsigned type);
+
 struct swap_list_t {
 	int head;	/* head of priority-ordered swapfile list */
 	int next;	/* swapfile to be used next */
--- 2.5.22/kernel/ksyms.c~swap-bio	Sun Jun 16 22:50:18 2002
+++ 2.5.22-akpm/kernel/ksyms.c	Sun Jun 16 23:22:46 2002
@@ -562,7 +562,6 @@ EXPORT_SYMBOL(buffer_insert_list);
 EXPORT_SYMBOL(make_bad_inode);
 EXPORT_SYMBOL(is_bad_inode);
 EXPORT_SYMBOL(event);
-EXPORT_SYMBOL(brw_page);
 
 #ifdef CONFIG_UID16
 EXPORT_SYMBOL(overflowuid);
--- 2.5.22/kernel/suspend.c~swap-bio	Sun Jun 16 22:50:18 2002
+++ 2.5.22-akpm/kernel/suspend.c	Sun Jun 16 22:50:18 2002
@@ -319,14 +319,15 @@ static void mark_swapfiles(swp_entry_t p
 {
 	swp_entry_t entry;
 	union diskpage *cur;
-	
-	cur = (union diskpage *)get_free_page(GFP_ATOMIC);
-	if (!cur)
+	struct page *page;
+
+	page = alloc_page(GFP_ATOMIC);
+	if (!page)
 		panic("Out of memory in mark_swapfiles");
+	cur = page_address(page);
 	/* XXX: this is dirty hack to get first page of swap file */
 	entry = swp_entry(root_swap, 0);
-	lock_page(virt_to_page((unsigned long)cur));
-	rw_swap_page_nolock(READ, entry, (char *) cur);
+	rw_swap_page_sync(READ, entry, page);
 
 	if (mode == MARK_SWAP_RESUME) {
 	  	if (!memcmp("SUSP1R",cur->swh.magic.magic,6))
@@ -344,10 +345,8 @@ static void mark_swapfiles(swp_entry_t p
 		cur->link.next = prev; /* prev is the first/last swap page of the resume area */
 		/* link.next lies *no more* in last 4 bytes of magic */
 	}
-	lock_page(virt_to_page((unsigned long)cur));
-	rw_swap_page_nolock(WRITE, entry, (char *)cur);
-	
-	free_page((unsigned long)cur);
+	rw_swap_page_sync(WRITE, entry, page);
+	__free_page(page);
 }
 
 static void read_swapfiles(void) /* This is called before saving image */
@@ -408,6 +407,7 @@ static int write_suspend_image(void)
 	int nr_pgdir_pages = SUSPEND_PD_PAGES(nr_copy_pages);
 	union diskpage *cur,  *buffer = (union diskpage *)get_free_page(GFP_ATOMIC);
 	unsigned long address;
+	struct page *page;
 
 	PRINTS( "Writing data to swap (%d pages): ", nr_copy_pages );
 	for (i=0; i<nr_copy_pages; i++) {
@@ -420,13 +420,8 @@ static int write_suspend_image(void)
 			panic("\nPage %d: not enough swapspace on suspend device", i );
 	    
 		address = (pagedir_nosave+i)->address;
-		lock_page(virt_to_page(address));
-		{
-			long dummy1;
-			struct inode *suspend_file;
-			get_swaphandle_info(entry, &dummy1, &suspend_file);
-		}
-		rw_swap_page_nolock(WRITE, entry, (char *) address);
+		page = virt_to_page(address);
+		rw_swap_page_sync(WRITE, entry, page);
 		(pagedir_nosave+i)->swap_address = entry;
 	}
 	PRINTK(" done\n");
@@ -451,8 +446,8 @@ static int write_suspend_image(void)
 		if (PAGE_SIZE % sizeof(struct pbe))
 			panic("I need PAGE_SIZE to be integer multiple of struct pbe, otherwise next assignment could damage pagedir");
 		cur->link.next = prev;				
-		lock_page(virt_to_page((unsigned long)cur));
-		rw_swap_page_nolock(WRITE, entry, (char *) cur);
+		page = virt_to_page((unsigned long)cur);
+		rw_swap_page_sync(WRITE, entry, page);
 		prev = entry;
 	}
 	PRINTK(", header");
@@ -472,8 +467,8 @@ static int write_suspend_image(void)
 		
 	cur->link.next = prev;
 
-	lock_page(virt_to_page((unsigned long)cur));
-	rw_swap_page_nolock(WRITE, entry, (char *) cur);
+	page = virt_to_page((unsigned long)cur);
+	rw_swap_page_sync(WRITE, entry, page);
 	prev = entry;
 
 	PRINTK( ", signature" );
--- 2.5.22/mm/page_io.c~swap-bio	Sun Jun 16 22:50:18 2002
+++ 2.5.22-akpm/mm/page_io.c	Sun Jun 16 22:50:18 2002
@@ -14,112 +14,163 @@
 #include <linux/kernel_stat.h>
 #include <linux/pagemap.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
-#include <linux/buffer_head.h>		/* for brw_page() */
-
+#include <linux/bio.h>
+#include <linux/buffer_head.h>
 #include <asm/pgtable.h>
+#include <linux/swapops.h>
 
-/*
- * Reads or writes a swap page.
- * wait=1: start I/O and wait for completion. wait=0: start asynchronous I/O.
- *
- * Important prevention of race condition: the caller *must* atomically 
- * create a unique swap cache entry for this swap page before calling
- * rw_swap_page, and must lock that page.  By ensuring that there is a
- * single page of memory reserved for the swap entry, the normal VM page
- * lock on that page also doubles as a lock on swap entries.  Having only
- * one lock to deal with per swap entry (rather than locking swap and memory
- * independently) also makes it easier to make certain swapping operations
- * atomic, which is particularly important when we are trying to ensure 
- * that shared pages stay shared while being swapped.
- */
+static int
+swap_get_block(struct inode *inode, sector_t iblock,
+		struct buffer_head *bh_result, int create)
+{
+	struct swap_info_struct *sis;
+	swp_entry_t entry;
 
-static int rw_swap_page_base(int rw, swp_entry_t entry, struct page *page)
+	entry.val = iblock;
+	sis = get_swap_info_struct(swp_type(entry));
+	bh_result->b_bdev = sis->bdev;
+	bh_result->b_blocknr = map_swap_page(sis, swp_offset(entry));
+	bh_result->b_size = PAGE_SIZE;
+	set_buffer_mapped(bh_result);
+	return 0;
+}
+
+static struct bio *
+get_swap_bio(int gfp_flags, struct page *page, bio_end_io_t end_io)
 {
-	unsigned long offset;
-	sector_t zones[PAGE_SIZE/512];
-	int zones_used;
-	int block_size;
-	struct inode *swapf = 0;
-	struct block_device *bdev;
+	struct bio *bio;
+	struct buffer_head bh;
 
-	if (rw == READ) {
+	bio = bio_alloc(gfp_flags, 1);
+	if (bio) {
+		swap_get_block(NULL, page->index, &bh, 1);
+		bio->bi_sector = bh.b_blocknr * (PAGE_SIZE >> 9);
+		bio->bi_bdev = bh.b_bdev;
+		bio->bi_io_vec[0].bv_page = page;
+		bio->bi_io_vec[0].bv_len = PAGE_SIZE;
+		bio->bi_io_vec[0].bv_offset = 0;
+		bio->bi_vcnt = 1;
+		bio->bi_idx = 0;
+		bio->bi_size = PAGE_SIZE;
+		bio->bi_end_io = end_io;
+	}
+	return bio;
+}
+
+static void end_swap_bio_write(struct bio *bio)
+{
+	const int uptodate = test_bit(BIO_UPTODATE, &bio->bi_flags);
+	struct page *page = bio->bi_io_vec[0].bv_page;
+
+	if (!uptodate)
+		SetPageError(page);
+	end_page_writeback(page);
+	bio_put(bio);
+}
+
+static void end_swap_bio_read(struct bio *bio)
+{
+	const int uptodate = test_bit(BIO_UPTODATE, &bio->bi_flags);
+	struct page *page = bio->bi_io_vec[0].bv_page;
+
+	if (!uptodate) {
+		SetPageError(page);
 		ClearPageUptodate(page);
-		kstat.pswpin++;
-	} else
-		kstat.pswpout++;
-
-	get_swaphandle_info(entry, &offset, &swapf);
-	bdev = swapf->i_bdev;
-	if (bdev) {
-		zones[0] = offset;
-		zones_used = 1;
-		block_size = PAGE_SIZE;
 	} else {
-		int i, j;
-		unsigned int block = offset
-			<< (PAGE_SHIFT - swapf->i_sb->s_blocksize_bits);
-
-		block_size = swapf->i_sb->s_blocksize;
-		for (i=0, j=0; j< PAGE_SIZE ; i++, j += block_size)
-			if (!(zones[i] = bmap(swapf,block++))) {
-				printk("rw_swap_page: bad swap file\n");
-				return 0;
-			}
-		zones_used = i;
-		bdev = swapf->i_sb->s_bdev;
-	}
-
- 	/* block_size == PAGE_SIZE/zones_used */
- 	brw_page(rw, page, bdev, zones, block_size);
-
- 	/* Note! For consistency we do all of the logic,
- 	 * decrementing the page count, and unlocking the page in the
- 	 * swap lock map - in the IO completion handler.
- 	 */
-	return 1;
+		SetPageUptodate(page);
+	}
+	unlock_page(page);
+	bio_put(bio);
 }
 
 /*
- * A simple wrapper so the base function doesn't need to enforce
- * that all swap pages go through the swap cache! We verify that:
- *  - the page is locked
- *  - it's marked as being swap-cache
- *  - it's associated with the swap inode
+ * We may have stale swap cache pages in memory: notice
+ * them here and get rid of the unnecessary final write.
  */
-void rw_swap_page(int rw, struct page *page)
+int swap_writepage(struct page *page)
 {
-	swp_entry_t entry;
+	struct bio *bio;
+	int ret = 0;
 
-	entry.val = page->index;
-
-	if (!PageLocked(page))
-		PAGE_BUG(page);
-	if (!PageSwapCache(page))
-		PAGE_BUG(page);
-	if (!rw_swap_page_base(rw, entry, page))
+	if (remove_exclusive_swap_page(page)) {
 		unlock_page(page);
+		goto out;
+	}
+	bio = get_swap_bio(GFP_NOIO, page, end_swap_bio_write);
+	if (bio == NULL) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	kstat.pswpout++;
+	SetPageWriteback(page);
+	unlock_page(page);
+	submit_bio(WRITE, bio);
+out:
+	return ret;
+}
+
+int swap_readpage(struct file *file, struct page *page)
+{
+	struct bio *bio;
+	int ret = 0;
+
+	ClearPageUptodate(page);
+	bio = get_swap_bio(GFP_KERNEL, page, end_swap_bio_read);
+	if (bio == NULL) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	kstat.pswpin++;
+	submit_bio(READ, bio);
+out:
+	return ret;
+}
+/*
+ * swapper_space doesn't have a real inode, so it gets a special vm_writeback()
+ * so we don't need swap special cases in generic_vm_writeback().
+ *
+ * Swap pages are PageLocked and PageWriteback while under writeout so that
+ * memory allocators will throttle against them.
+ */
+static int swap_vm_writeback(struct page *page, int *nr_to_write)
+{
+	struct address_space *mapping = page->mapping;
+
+	unlock_page(page);
+	return generic_writepages(mapping, nr_to_write);
 }
 
+struct address_space_operations swap_aops = {
+	vm_writeback:	swap_vm_writeback,
+	writepage:	swap_writepage,
+	readpage:	swap_readpage,
+	sync_page:	block_sync_page,
+	set_page_dirty:	__set_page_dirty_nobuffers,
+};
+
 /*
- * The swap lock map insists that pages be in the page cache!
- * Therefore we can't use it.  Later when we can remove the need for the
- * lock map and we can reduce the number of functions exported.
+ * A scruffy utility function to read or write an arbitrary swap page
+ * and wait on the I/O.
  */
-void rw_swap_page_nolock(int rw, swp_entry_t entry, char *buf)
+int rw_swap_page_sync(int rw, swp_entry_t entry, struct page *page)
 {
-	struct page *page = virt_to_page(buf);
-	
-	if (!PageLocked(page))
-		PAGE_BUG(page);
-	if (page->mapping)
-		PAGE_BUG(page);
-	/* needs sync_page to wait I/O completation */
+	int ret;
+
+	lock_page(page);
+
+	BUG_ON(page->mapping);
 	page->mapping = &swapper_space;
-	if (rw_swap_page_base(rw, entry, page))
-		lock_page(page);
-	if (page_has_buffers(page) && !try_to_free_buffers(page))
-		PAGE_BUG(page);
+	page->index = entry.val;
+
+	if (rw == READ) {
+		ret = swap_readpage(NULL, page);
+		wait_on_page_locked(page);
+	} else {
+		ret = swap_writepage(page);
+		wait_on_page_writeback(page);
+	}
 	page->mapping = NULL;
-	unlock_page(page);
+	if (ret == 0 && (!PageUptodate(page) || PageError(page)))
+		ret = -EIO;
+	return ret;
 }
--- 2.5.22/mm/swapfile.c~swap-bio	Sun Jun 16 22:50:18 2002
+++ 2.5.22-akpm/mm/swapfile.c	Sun Jun 16 22:50:18 2002
@@ -16,7 +16,7 @@
 #include <linux/namei.h>
 #include <linux/shm.h>
 #include <linux/blkdev.h>
-#include <linux/buffer_head.h>		/* for try_to_free_buffers() */
+#include <linux/buffer_head.h>
 
 #include <asm/pgtable.h>
 #include <linux/swapops.h>
@@ -294,13 +294,14 @@ int remove_exclusive_swap_page(struct pa
 	struct swap_info_struct * p;
 	swp_entry_t entry;
 
-	if (!PageLocked(page))
-		BUG();
+	BUG_ON(page_has_buffers(page));
+	BUG_ON(!PageLocked(page));
+
 	if (!PageSwapCache(page))
 		return 0;
 	if (PageWriteback(page))
 		return 0;
-	if (page_count(page) - !!PagePrivate(page) != 2) /* 2: us + cache */
+	if (page_count(page) != 2) /* 2: us + cache */
 		return 0;
 
 	entry.val = page->index;
@@ -313,14 +314,8 @@ int remove_exclusive_swap_page(struct pa
 	if (p->swap_map[swp_offset(entry)] == 1) {
 		/* Recheck the page count with the pagecache lock held.. */
 		write_lock(&swapper_space.page_lock);
-		if ((page_count(page) - !!page_has_buffers(page) == 2) &&
-					!PageWriteback(page)) {
+		if ((page_count(page) == 2) && !PageWriteback(page)) {
 			__delete_from_swap_cache(page);
-			/*
-			 * NOTE: if/when swap gets buffer/page coherency
-			 * like other mappings, we'll need to mark the buffers
-			 * dirty here too.  set_page_dirty().
-			 */
 			SetPageDirty(page);
 			retval = 1;
 		}
@@ -329,8 +324,6 @@ int remove_exclusive_swap_page(struct pa
 	swap_info_put(p);
 
 	if (retval) {
-		if (page_has_buffers(page) && !try_to_free_buffers(page))
-			BUG();
 		swap_free(entry);
 		page_cache_release(page);
 	}
@@ -356,8 +349,9 @@ void free_swap_and_cache(swp_entry_t ent
 	if (page) {
 		int one_user;
 
+		BUG_ON(page_has_buffers(page));
 		page_cache_get(page);
-		one_user = (page_count(page) - !!page_has_buffers(page) == 2);
+		one_user = (page_count(page) == 2);
 		/* Only cache user (+us), or swap space full? Free it! */
 		if (!PageWriteback(page) && (one_user || vm_swap_full())) {
 			delete_from_swap_cache(page);
@@ -691,7 +685,7 @@ static int try_to_unuse(unsigned int typ
 		 * Note shmem_unuse already deleted its from swap cache.
 		 */
 		if ((*swap_map > 1) && PageDirty(page) && PageSwapCache(page)) {
-			rw_swap_page(WRITE, page);
+			swap_writepage(page);
 			lock_page(page);
 		}
 		if (PageSwapCache(page)) {
@@ -725,6 +719,207 @@ static int try_to_unuse(unsigned int typ
 	return retval;
 }
 
+/*
+ * Use this swapdev's extent info to locate the (PAGE_SIZE) block which
+ * corresponds to page offset `offset'.
+ */
+sector_t map_swap_page(struct swap_info_struct *sis, pgoff_t offset)
+{
+	struct swap_extent *se = sis->curr_swap_extent;
+	struct swap_extent *start_se = se;
+
+	for ( ; ; ) {
+		struct list_head *lh;
+
+		if (se->start_page <= offset &&
+				offset < (se->start_page + se->nr_pages)) {
+			return se->start_block + (offset - se->start_page);
+		}
+		lh = se->list.prev;
+		if (lh == &sis->extent_list)
+			lh = lh->prev;
+		se = list_entry(lh, struct swap_extent, list);
+		sis->curr_swap_extent = se;
+		BUG_ON(se == start_se);		/* It *must* be present */
+	}
+}
+
+/*
+ * Free all of a swapdev's extent information
+ */
+static void destroy_swap_extents(struct swap_info_struct *sis)
+{
+	while (!list_empty(&sis->extent_list)) {
+		struct swap_extent *se;
+
+		se = list_entry(sis->extent_list.next,
+				struct swap_extent, list);
+		list_del(&se->list);
+		kfree(se);
+	}
+	sis->nr_extents = 0;
+}
+
+/*
+ * Add a block range (and the corresponding page range) into this swapdev's
+ * extent list.  The extent list is kept sorted in block order.
+ *
+ * This function rather assumes that it is called in ascending sector_t order.
+ * It doesn't look for extent coalescing opportunities.
+ */
+static int
+add_swap_extent(struct swap_info_struct *sis, unsigned long start_page,
+		unsigned long nr_pages, sector_t start_block)
+{
+	struct swap_extent *se;
+	struct swap_extent *new_se;
+	struct list_head *lh;
+
+	lh = sis->extent_list.next;	/* The highest-addressed block */
+	while (lh != &sis->extent_list) {
+		se = list_entry(lh, struct swap_extent, list);
+		if (se->start_block + se->nr_pages == start_block) {
+			/* Merge it */
+			se->nr_pages += nr_pages;
+			return 0;
+		}
+		lh = lh->next;
+	}
+
+	/*
+	 * No merge.  Insert a new extent, preserving ordering.
+	 */
+	new_se = kmalloc(sizeof(*se), GFP_KERNEL);
+	if (new_se == NULL)
+		return -ENOMEM;
+	new_se->start_page = start_page;
+	new_se->nr_pages = nr_pages;
+	new_se->start_block = start_block;
+
+	lh = sis->extent_list.prev;	/* The lowest block */
+	while (lh != &sis->extent_list) {
+		se = list_entry(lh, struct swap_extent, list);
+		if (se->start_block > start_block)
+			break;
+		lh = lh->prev;
+	}
+	list_add_tail(&new_se->list, lh);
+	sis->nr_extents++;
+	return 0;
+}
+
+/*
+ * A `swap extent' is a simple thing which maps a contiguous range of pages
+ * onto a contiguous range of disk blocks.  An ordered list of swap extents
+ * is built at swapon time and is then used at swap_writepage/swap_readpage
+ * time for locating where on disk a page belongs.
+ *
+ * If the swapfile is an S_ISBLK block device, a single extent is installed.
+ * This is done so that the main operating code can treat S_ISBLK and S_ISREG
+ * swap files identically.
+ *
+ * Whether the swapdev is an S_ISREG file or an S_ISBLK blockdev, the swap
+ * extent list operates in PAGE_SIZE disk blocks.  Both S_ISREG and S_ISBLK
+ * swapfiles are handled *identically* after swapon time.
+ *
+ * For S_ISREG swapfiles, setup_swap_extents() will walk all the file's blocks
+ * and will parse them into an ordered extent list, in PAGE_SIZE chunks.  If
+ * some stray blocks are found which do not fall within the PAGE_SIZE alignment
+ * requirements, they are simply tossed out - we will never use those blocks
+ * for swapping.
+ *
+ * The amount of disk space which a single swap extent represents varies.
+ * Typically it is in the 1-4 megabyte range.  So we can have hundreds of
+ * extents in the list.  To avoid much list walking, we cache the previous
+ * search location in `curr_swap_extent', and start new searches from there.
+ * This is extremely effective.  The average number of iterations in
+ * map_swap_page() has been measured at about 0.3 per page.  - akpm.
+ */
+static int setup_swap_extents(struct swap_info_struct *sis)
+{
+	struct inode *inode;
+	unsigned blocks_per_page;
+	unsigned long page_no;
+	unsigned blkbits;
+	sector_t probe_block;
+	sector_t last_block;
+	int ret;
+
+	inode = sis->swap_file->f_dentry->d_inode;
+	if (S_ISBLK(inode->i_mode)) {
+		ret = add_swap_extent(sis, 0, sis->max, 0);
+		goto done;
+	}
+
+	blkbits = inode->i_blkbits;
+	blocks_per_page = PAGE_SIZE >> blkbits;
+
+	/*
+	 * Map all the blocks into the extent list.  This code doesn't try
+	 * to be very smart.
+	 */
+	probe_block = 0;
+	page_no = 0;
+	last_block = inode->i_size >> blkbits;
+	while ((probe_block + blocks_per_page) <= last_block &&
+			page_no < sis->max) {
+		unsigned block_in_page;
+		sector_t first_block;
+
+		first_block = bmap(inode, probe_block);
+		if (first_block == 0)
+			goto bad_bmap;
+
+		/*
+		 * It must be PAGE_SIZE aligned on-disk
+		 */
+		if (first_block & (blocks_per_page - 1)) {
+			probe_block++;
+			goto reprobe;
+		}
+
+		for (block_in_page = 1; block_in_page < blocks_per_page;
+					block_in_page++) {
+			sector_t block;
+
+			block = bmap(inode, probe_block + block_in_page);
+			if (block == 0)
+				goto bad_bmap;
+			if (block != first_block + block_in_page) {
+				/* Discontiguity */
+				probe_block++;
+				goto reprobe;
+			}
+		}
+
+		/*
+		 * We found a PAGE_SIZE-length, PAGE_SIZE-aligned run of blocks
+		 */
+		ret = add_swap_extent(sis, page_no, 1,
+				first_block >> (PAGE_SHIFT - blkbits));
+		if (ret)
+			goto out;
+		page_no++;
+		probe_block += blocks_per_page;
+reprobe:
+		continue;
+	}
+	ret = 0;
+	if (page_no == 0)
+		ret = -EINVAL;
+	sis->max = page_no;
+	sis->highest_bit = page_no - 1;
+done:
+	sis->curr_swap_extent = list_entry(sis->extent_list.prev,
+					struct swap_extent, list);
+	goto out;
+bad_bmap:
+	printk(KERN_ERR "swapon: swapfile has holes\n");
+	ret = -EINVAL;
+out:
+	return ret;
+}
+
 asmlinkage long sys_swapoff(const char * specialfile)
 {
 	struct swap_info_struct * p = NULL;
@@ -741,7 +936,6 @@ asmlinkage long sys_swapoff(const char *
 	if (err)
 		goto out;
 
-	lock_kernel();
 	prev = -1;
 	swap_list_lock();
 	for (type = swap_list.head; type >= 0; type = swap_info[type].next) {
@@ -771,9 +965,7 @@ asmlinkage long sys_swapoff(const char *
 	total_swap_pages -= p->pages;
 	p->flags &= ~SWP_WRITEOK;
 	swap_list_unlock();
-	unlock_kernel();
 	err = try_to_unuse(type);
-	lock_kernel();
 	if (err) {
 		/* re-insert swap space back into swap_list */
 		swap_list_lock();
@@ -799,6 +991,7 @@ asmlinkage long sys_swapoff(const char *
 	swap_map = p->swap_map;
 	p->swap_map = NULL;
 	p->flags = 0;
+	destroy_swap_extents(p);
 	swap_device_unlock(p);
 	swap_list_unlock();
 	vfree(swap_map);
@@ -812,7 +1005,6 @@ asmlinkage long sys_swapoff(const char *
 	err = 0;
 
 out_dput:
-	unlock_kernel();
 	path_release(&nd);
 out:
 	return err;
@@ -866,12 +1058,12 @@ int get_swaparea_info(char *buf)
 asmlinkage long sys_swapon(const char * specialfile, int swap_flags)
 {
 	struct swap_info_struct * p;
-	char *name;
+	char *name = NULL;
 	struct block_device *bdev = NULL;
 	struct file *swap_file = NULL;
 	struct address_space *mapping;
 	unsigned int type;
-	int i, j, prev;
+	int i, prev;
 	int error;
 	static int least_priority = 0;
 	union swap_header *swap_header = 0;
@@ -880,10 +1072,10 @@ asmlinkage long sys_swapon(const char * 
 	unsigned long maxpages = 1;
 	int swapfilesize;
 	unsigned short *swap_map;
-	
+	struct page *page = NULL;
+
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
-	lock_kernel();
 	swap_list_lock();
 	p = swap_info;
 	for (type = 0 ; type < nr_swapfiles ; type++,p++)
@@ -896,7 +1088,9 @@ asmlinkage long sys_swapon(const char * 
 	}
 	if (type >= nr_swapfiles)
 		nr_swapfiles = type+1;
+	INIT_LIST_HEAD(&p->extent_list);
 	p->flags = SWP_USED;
+	p->nr_extents = 0;
 	p->swap_file = NULL;
 	p->old_block_size = 0;
 	p->swap_map = NULL;
@@ -917,7 +1111,6 @@ asmlinkage long sys_swapon(const char * 
 	if (IS_ERR(name))
 		goto bad_swap_2;
 	swap_file = filp_open(name, O_RDWR, 0);
-	putname(name);
 	error = PTR_ERR(swap_file);
 	if (IS_ERR(swap_file)) {
 		swap_file = NULL;
@@ -939,8 +1132,12 @@ asmlinkage long sys_swapon(const char * 
 				      PAGE_SIZE);
 		if (error < 0)
 			goto bad_swap;
-	} else if (!S_ISREG(swap_file->f_dentry->d_inode->i_mode))
+		p->bdev = bdev;
+	} else if (S_ISREG(swap_file->f_dentry->d_inode->i_mode)) {
+		p->bdev = swap_file->f_dentry->d_inode->i_sb->s_bdev;
+	} else {
 		goto bad_swap;
+	}
 
 	mapping = swap_file->f_dentry->d_inode->i_mapping;
 	swapfilesize = mapping->host->i_size >> PAGE_SHIFT;
@@ -954,15 +1151,20 @@ asmlinkage long sys_swapon(const char * 
 			goto bad_swap;
 	}
 
-	swap_header = (void *) __get_free_page(GFP_USER);
-	if (!swap_header) {
-		printk("Unable to start swapping: out of memory :-)\n");
-		error = -ENOMEM;
+	/*
+	 * Read the swap header.
+	 */
+	page = read_cache_page(mapping, 0,
+			(filler_t *)mapping->a_ops->readpage, swap_file);
+	if (IS_ERR(page)) {
+		error = PTR_ERR(page);
 		goto bad_swap;
 	}
-
-	lock_page(virt_to_page(swap_header));
-	rw_swap_page_nolock(READ, swp_entry(type,0), (char *) swap_header);
+	wait_on_page_locked(page);
+	if (!PageUptodate(page))
+		goto bad_swap;
+	kmap(page);
+	swap_header = page_address(page);
 
 	if (!memcmp("SWAP-SPACE",swap_header->magic.magic,10))
 		swap_header_version = 1;
@@ -976,33 +1178,10 @@ asmlinkage long sys_swapon(const char * 
 	
 	switch (swap_header_version) {
 	case 1:
-		memset(((char *) swap_header)+PAGE_SIZE-10,0,10);
-		j = 0;
-		p->lowest_bit = 0;
-		p->highest_bit = 0;
-		for (i = 1 ; i < 8*PAGE_SIZE ; i++) {
-			if (test_bit(i,(unsigned long *) swap_header)) {
-				if (!p->lowest_bit)
-					p->lowest_bit = i;
-				p->highest_bit = i;
-				maxpages = i+1;
-				j++;
-			}
-		}
-		nr_good_pages = j;
-		p->swap_map = vmalloc(maxpages * sizeof(short));
-		if (!p->swap_map) {
-			error = -ENOMEM;		
-			goto bad_swap;
-		}
-		for (i = 1 ; i < maxpages ; i++) {
-			if (test_bit(i,(unsigned long *) swap_header))
-				p->swap_map[i] = 0;
-			else
-				p->swap_map[i] = SWAP_MAP_BAD;
-		}
-		break;
-
+		printk(KERN_ERR "version 0 swap is no longer supported. "
+			"Use mkswap -v1 %s\n", name);
+		error = -EINVAL;
+		goto bad_swap;
 	case 2:
 		/* Check the swap header's sub-version and the size of
                    the swap file and bad block lists */
@@ -1058,15 +1237,20 @@ asmlinkage long sys_swapon(const char * 
 		goto bad_swap;
 	}
 	p->swap_map[0] = SWAP_MAP_BAD;
+	p->max = maxpages;
+	p->pages = nr_good_pages;
+
+	if (setup_swap_extents(p))
+		goto bad_swap;
+
 	swap_list_lock();
 	swap_device_lock(p);
-	p->max = maxpages;
 	p->flags = SWP_ACTIVE;
-	p->pages = nr_good_pages;
 	nr_swap_pages += nr_good_pages;
 	total_swap_pages += nr_good_pages;
-	printk(KERN_INFO "Adding Swap: %dk swap-space (priority %d)\n",
-	       nr_good_pages<<(PAGE_SHIFT-10), p->prio);
+	printk(KERN_INFO "Adding %dk swap on %s.  Priority:%d extents:%d\n",
+		nr_good_pages<<(PAGE_SHIFT-10), name,
+		p->prio, p->nr_extents);
 
 	/* insert swap space into swap_list: */
 	prev = -1;
@@ -1100,14 +1284,18 @@ bad_swap_2:
 	if (!(swap_flags & SWAP_FLAG_PREFER))
 		++least_priority;
 	swap_list_unlock();
+	destroy_swap_extents(p);
 	if (swap_map)
 		vfree(swap_map);
 	if (swap_file && !IS_ERR(swap_file))
 		filp_close(swap_file, NULL);
 out:
-	if (swap_header)
-		free_page((long) swap_header);
-	unlock_kernel();
+	if (page && !IS_ERR(page)) {
+		kunmap(page);
+		page_cache_release(page);
+	}
+	if (name)
+		putname(name);
 	return error;
 }
 
@@ -1176,78 +1364,10 @@ bad_file:
 	goto out;
 }
 
-/*
- * Page lock needs to be held in all cases to prevent races with
- * swap file deletion.
- */
-int swap_count(struct page *page)
-{
-	struct swap_info_struct * p;
-	unsigned long offset, type;
-	swp_entry_t entry;
-	int retval = 0;
-
-	entry.val = page->index;
-	if (!entry.val)
-		goto bad_entry;
-	type = swp_type(entry);
-	if (type >= nr_swapfiles)
-		goto bad_file;
-	p = type + swap_info;
-	offset = swp_offset(entry);
-	if (offset >= p->max)
-		goto bad_offset;
-	if (!p->swap_map[offset])
-		goto bad_unused;
-	retval = p->swap_map[offset];
-out:
-	return retval;
-
-bad_entry:
-	printk(KERN_ERR "swap_count: null entry!\n");
-	goto out;
-bad_file:
-	printk(KERN_ERR "swap_count: %s%08lx\n", Bad_file, entry.val);
-	goto out;
-bad_offset:
-	printk(KERN_ERR "swap_count: %s%08lx\n", Bad_offset, entry.val);
-	goto out;
-bad_unused:
-	printk(KERN_ERR "swap_count: %s%08lx\n", Unused_offset, entry.val);
-	goto out;
-}
-
-/*
- * Prior swap_duplicate protects against swap device deletion.
- */
-void get_swaphandle_info(swp_entry_t entry, unsigned long *offset, 
-			struct inode **swapf)
+struct swap_info_struct *
+get_swap_info_struct(unsigned type)
 {
-	unsigned long type;
-	struct swap_info_struct *p;
-
-	type = swp_type(entry);
-	if (type >= nr_swapfiles) {
-		printk(KERN_ERR "rw_swap_page: %s%08lx\n", Bad_file, entry.val);
-		return;
-	}
-
-	p = &swap_info[type];
-	*offset = swp_offset(entry);
-	if (*offset >= p->max && *offset != 0) {
-		printk(KERN_ERR "rw_swap_page: %s%08lx\n", Bad_offset, entry.val);
-		return;
-	}
-	if (p->swap_map && !p->swap_map[*offset]) {
-		printk(KERN_ERR "rw_swap_page: %s%08lx\n", Unused_offset, entry.val);
-		return;
-	}
-	if (!(p->flags & SWP_USED)) {
-		printk(KERN_ERR "rw_swap_page: %s%08lx\n", Unused_file, entry.val);
-		return;
-	}
-
-	*swapf = p->swap_file->f_dentry->d_inode;
+	return &swap_info[type];
 }
 
 /*
--- 2.5.22/mm/swap_state.c~swap-bio	Sun Jun 16 22:50:18 2002
+++ 2.5.22-akpm/mm/swap_state.c	Sun Jun 16 22:50:18 2002
@@ -14,54 +14,27 @@
 #include <linux/init.h>
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
-#include <linux/buffer_head.h>	/* block_sync_page()/try_to_free_buffers() */
+#include <linux/buffer_head.h>	/* block_sync_page() */
 
 #include <asm/pgtable.h>
 
 /*
- * We may have stale swap cache pages in memory: notice
- * them here and get rid of the unnecessary final write.
- */
-static int swap_writepage(struct page *page)
-{
-	if (remove_exclusive_swap_page(page)) {
-		unlock_page(page);
-		return 0;
-	}
-	rw_swap_page(WRITE, page);
-	return 0;
-}
-
-/*
- * swapper_space doesn't have a real inode, so it gets a special vm_writeback()
- * so we don't need swap special cases in generic_vm_writeback().
- *
- * Swap pages are PageLocked and PageWriteback while under writeout so that
- * memory allocators will throttle against them.
- */
-static int swap_vm_writeback(struct page *page, int *nr_to_write)
-{
-	struct address_space *mapping = page->mapping;
-
-	unlock_page(page);
-	return generic_writepages(mapping, nr_to_write);
-}
-
-static struct address_space_operations swap_aops = {
-	vm_writeback:	swap_vm_writeback,
-	writepage:	swap_writepage,
-	sync_page:	block_sync_page,
-	set_page_dirty:	__set_page_dirty_nobuffers,
-};
-
-/*
  * swapper_inode doesn't do anything much.  It is really only here to
  * avoid some special-casing in other parts of the kernel.
+ *
+ * We set i_size to "infinity" to keep the page I/O functions happy.  The swap
+ * block allocator makes sure that allocations are in-range.  A strange
+ * number is chosen to prevent various arith overflows elsewhere.  For example,
+ * `lblock' in block_read_full_page().
  */
 static struct inode swapper_inode = {
-	i_mapping:		&swapper_space,
+	i_mapping:	&swapper_space,
+	i_size:		PAGE_SIZE * 0xffffffffLL,
+	i_blkbits:	PAGE_SHIFT,
 };
 
+extern struct address_space_operations swap_aops;
+
 struct address_space swapper_space = {
 	page_tree:	RADIX_TREE_INIT(GFP_ATOMIC),
 	page_lock:	RW_LOCK_UNLOCKED,
@@ -149,14 +122,9 @@ void delete_from_swap_cache(struct page 
 {
 	swp_entry_t entry;
 
-	/*
-	 * I/O should have completed and nobody can have a ref against the
-	 * page's buffers
-	 */
 	BUG_ON(!PageLocked(page));
 	BUG_ON(PageWriteback(page));
-	if (page_has_buffers(page) && !try_to_free_buffers(page))
-		BUG();
+	BUG_ON(page_has_buffers(page));
   
 	entry.val = page->index;
 
@@ -222,16 +190,9 @@ int move_from_swap_cache(struct page *pa
 	void **pslot;
 	int err;
 
-	/*
-	 * Drop the buffers now, before taking the page_lock.  Because
-	 * mapping->private_lock nests outside mapping->page_lock.
-	 * This "must" succeed.  The page is locked and all I/O has completed
-	 * and nobody else has a ref against its buffers.
-	 */
 	BUG_ON(!PageLocked(page));
 	BUG_ON(PageWriteback(page));
-	if (page_has_buffers(page) && !try_to_free_buffers(page))
-		BUG();
+	BUG_ON(page_has_buffers(page));
 
 	write_lock(&swapper_space.page_lock);
 	write_lock(&mapping->page_lock);
@@ -361,7 +322,7 @@ struct page * read_swap_cache_async(swp_
 			/*
 			 * Initiate read into locked page and return.
 			 */
-			rw_swap_page(READ, new_page);
+			swap_readpage(NULL, new_page);
 			return new_page;
 		}
 	} while (err != -ENOENT && err != -ENOMEM);

-
