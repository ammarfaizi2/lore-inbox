Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310917AbSDXJC1>; Wed, 24 Apr 2002 05:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310835AbSDXJBN>; Wed, 24 Apr 2002 05:01:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17683 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293510AbSDXI6d>;
	Wed, 24 Apr 2002 04:58:33 -0400
Message-ID: <3CC673CF.15794899@zip.com.au>
Date: Wed, 24 Apr 2002 01:58:55 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] buffer-layer cleanup
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Moves all buffer_head-related stuff out of linux/fs.h and into
linux/buffer_head.h.  buffer_head.h is currently included at the very
end of fs.h.  So it is possible to include buffer_head directly from
all .c files and remove this nested include.

Also rationalises all the set_buffer_foo() and mark_buffer_bar()
functions.  We have:

	set_buffer_foo(bh)
	clear_buffer_foo(bh)
	buffer_foo(bh)

and, in some cases, where needed:

	test_set_buffer_foo(bh)
	test_clear_buffer_foo(bh)

And that's it.

BUFFER_FNS() and TAS_BUFFER_FNS() macros generate all the above real
inline functions.  Normally not a big fan of cpp abuse, but in this
case it fits.  These function-generating macros are available to
filesystems to expand their own b_state functions.  JBD uses this in
one case.

Updates all callers to use the above API.



=====================================

--- 2.5.9/include/linux/fs.h~cleanup-070-bh_flags	Wed Apr 24 01:06:15 2002
+++ 2.5.9-akpm/include/linux/fs.h	Wed Apr 24 01:39:42 2002
@@ -206,97 +206,12 @@ extern int leases_enable, dir_notify_ena
 extern void update_atime (struct inode *);
 #define UPDATE_ATIME(inode) update_atime (inode)
 
-extern void buffer_init(void);
 extern void inode_init(unsigned long);
 extern void mnt_init(unsigned long);
 extern void files_init(unsigned long);
 
-/* bh state bits */
-enum bh_state_bits {
-	BH_Uptodate,	/* 1 if the buffer contains valid data */
-	BH_Dirty,	/* 1 if the buffer is dirty */
-	BH_Lock,	/* 1 if the buffer is locked */
-	BH_Req,		/* 0 if the buffer has been invalidated */
-
-	BH_Mapped,	/* 1 if the buffer has a disk mapping */
-	BH_New,		/* 1 if the buffer is new and not yet written out */
-	BH_Async,	/* 1 if the buffer is under end_buffer_io_async I/O */
-	BH_JBD,		/* 1 if it has an attached journal_head */
-
-	BH_PrivateStart,/* not a state bit, but the first bit available
-			 * for private allocation by other entities
-			 */
-};
-
-/*
- * Try to keep the most commonly used fields in single cache lines (16
- * bytes) to improve performance.  This ordering should be
- * particularly beneficial on 32-bit processors.
- * 
- * We use the first 16 bytes for the data which is used in searches
- * over the block hash lists (ie. getblk() and friends).
- * 
- * The second 16 bytes we use for lru buffer scans, as used by
- * sync_buffers() and refill_freelist().  -- sct
- */
-struct buffer_head {
-	/* First cache line: */
-	sector_t b_blocknr;		/* block number */
-	unsigned short b_size;		/* block size */
-	kdev_t b_dev;			/* device (B_FREE = free) */
-	struct block_device *b_bdev;
-
-	atomic_t b_count;		/* users using this block */
-	unsigned long b_state;		/* buffer state bitmap (see above) */
-	struct buffer_head *b_this_page;/* circular list of buffers in one page */
-	struct page *b_page;		/* the page this bh is mapped to */
-
-	char * b_data;			/* pointer to data block */
-	void (*b_end_io)(struct buffer_head *bh, int uptodate); /* I/O completion */
- 	void *b_private;		/* reserved for b_end_io */
-
-	wait_queue_head_t b_wait;
-
-	struct list_head     b_inode_buffers;	/* doubly linked list of inode dirty buffers */
-};
-
-typedef void (bh_end_io_t)(struct buffer_head *bh, int uptodate);
-void init_buffer(struct buffer_head *, bh_end_io_t *, void *);
-
-#define __buffer_state(bh, state)	(((bh)->b_state & (1UL << BH_##state)) != 0)
-
-#define buffer_uptodate(bh)	__buffer_state(bh,Uptodate)
-#define buffer_dirty(bh)	__buffer_state(bh,Dirty)
-#define buffer_locked(bh)	__buffer_state(bh,Lock)
-#define buffer_req(bh)		__buffer_state(bh,Req)
-#define buffer_mapped(bh)	__buffer_state(bh,Mapped)
-#define buffer_new(bh)		__buffer_state(bh,New)
-#define buffer_async(bh)	__buffer_state(bh,Async)
-
-#define bh_offset(bh)		((unsigned long)(bh)->b_data & ~PAGE_MASK)
-
-extern void set_bh_page(struct buffer_head *bh, struct page *page, unsigned long offset);
-
-#define touch_buffer(bh)	mark_page_accessed(bh->b_page)
-
-/* If we *know* page->private refers to buffer_heads */
-#define page_buffers(page)					\
-	({							\
-		if (!PagePrivate(page))				\
-			BUG();					\
-		((struct buffer_head *)(page)->private);	\
-	})
-#define page_has_buffers(page)	PagePrivate(page)
-#define set_page_buffers(page, buffers)				\
-	do {							\
-		SetPagePrivate(page);				\
-		page->private = (unsigned long)buffers;		\
-	} while (0)
-#define clear_page_buffers(page)				\
-	do {							\
-		ClearPagePrivate(page);				\
-		page->private = 0;				\
-	} while (0)
+struct buffer_head;
+typedef int (get_block_t)(struct inode*,sector_t,struct buffer_head*,int);
 
 #include <linux/pipe_fs_i.h>
 /* #include <linux/umsdos_fs_i.h> */
@@ -1211,82 +1126,6 @@ extern struct file_operations rdwr_pipe_
 
 extern int fs_may_remount_ro(struct super_block *);
 
-extern int try_to_free_buffers(struct page *);
-extern void create_empty_buffers(struct page *, unsigned long,
-			unsigned long b_state);
-extern void end_buffer_io_sync(struct buffer_head *bh, int uptodate);
-
-/* reiserfs_writepage needs this */
-extern void set_buffer_async_io(struct buffer_head *bh) ;
-
-static inline void get_bh(struct buffer_head * bh)
-{
-        atomic_inc(&(bh)->b_count);
-}
-
-static inline void put_bh(struct buffer_head *bh)
-{
-        smp_mb__before_atomic_dec();
-        atomic_dec(&bh->b_count);
-}
-
-/*
- * This is called by bh->b_end_io() handlers when I/O has completed.
- */
-static inline void mark_buffer_uptodate(struct buffer_head * bh, int on)
-{
-	if (on)
-		set_bit(BH_Uptodate, &bh->b_state);
-	else
-		clear_bit(BH_Uptodate, &bh->b_state);
-}
-
-#define atomic_set_buffer_clean(bh) test_and_clear_bit(BH_Dirty, &(bh)->b_state)
-
-static inline void mark_buffer_clean(struct buffer_head * bh)
-{
-	clear_bit(BH_Dirty, &(bh)->b_state);
-}
-
-extern void FASTCALL(mark_buffer_dirty(struct buffer_head *bh));
-extern void buffer_insert_list(spinlock_t *lock,
-		struct buffer_head *, struct list_head *);
-
-static inline void
-buffer_insert_inode_queue(struct buffer_head *bh, struct inode *inode)
-{
-	buffer_insert_list(&inode->i_bufferlist_lock,
-			bh, &inode->i_dirty_buffers);
-}
-
-#define atomic_set_buffer_dirty(bh) test_and_set_bit(BH_Dirty, &(bh)->b_state)
-
-static inline void mark_buffer_async(struct buffer_head * bh, int on)
-{
-	if (on)
-		set_bit(BH_Async, &bh->b_state);
-	else
-		clear_bit(BH_Async, &bh->b_state);
-}
-
-/*
- * If an error happens during the make_request, this function
- * has to be recalled. It marks the buffer as clean and not
- * uptodate, and it notifys the upper layer about the end
- * of the I/O.
- */
-static inline void buffer_IO_error(struct buffer_head * bh)
-{
-	mark_buffer_clean(bh);
-
-	/*
-	 * b_end_io has to clear the BH_Uptodate bitflag in the read error
-	 * case, however buffer contents are not necessarily bad if a
-	 * write fails
-	 */
-	bh->b_end_io(bh, test_bit(BH_Uptodate, &bh->b_state));
-}
-
 /*
  * return READ, READA, or WRITE
  */
@@ -1297,37 +1136,13 @@ static inline void buffer_IO_error(struc
  */
 #define bio_data_dir(bio)	((bio)->bi_rw & 1)
 
-extern void buffer_insert_inode_queue(struct buffer_head *, struct inode *);
-static inline void mark_buffer_dirty_inode(struct buffer_head *bh, struct inode *inode)
-{
-	mark_buffer_dirty(bh);
-	buffer_insert_inode_queue(bh, inode);
-}
-
 extern int check_disk_change(kdev_t);
 extern int invalidate_inodes(struct super_block *);
 extern int invalidate_device(kdev_t, int);
 extern void invalidate_inode_pages(struct inode *);
 extern void invalidate_inode_pages2(struct address_space *);
-extern void invalidate_inode_buffers(struct inode *);
-#define invalidate_buffers(dev)	__invalidate_buffers((dev), 0)
-#define destroy_buffers(dev)	__invalidate_buffers((dev), 1)
-extern void invalidate_bdev(struct block_device *, int);
-extern void __invalidate_buffers(kdev_t dev, int);
 extern void write_inode_now(struct inode *, int);
-extern int sync_buffers(struct block_device *, int);
-extern int fsync_dev(kdev_t);
-extern int fsync_bdev(struct block_device *);
-extern int fsync_super(struct super_block *);
-extern int fsync_no_super(struct block_device *);
 extern void sync_inodes_sb(struct super_block *);
-extern int fsync_buffers_list(spinlock_t *lock, struct list_head *);
-static inline int fsync_inode_buffers(struct inode *inode)
-{
-	return fsync_buffers_list(&inode->i_bufferlist_lock,
-				&inode->i_dirty_buffers);
-}
-extern int inode_has_buffers(struct inode *);
 extern int filemap_fdatasync(struct address_space *);
 extern int filemap_fdatawait(struct address_space *);
 extern void sync_supers(void);
@@ -1438,113 +1253,15 @@ extern void insert_inode_hash(struct ino
 extern void remove_inode_hash(struct inode *);
 extern struct file * get_empty_filp(void);
 extern void file_move(struct file *f, struct list_head *list);
-extern struct buffer_head * __get_hash_table(struct block_device *, sector_t, int);
-static inline struct buffer_head * get_hash_table(kdev_t dev, sector_t block, int size)
-{
-	struct block_device *bdev;
-	struct buffer_head *bh;
-	bdev = bdget(kdev_t_to_nr(dev));
-	if (!bdev) {
-		printk("No block device for %s\n", bdevname(dev));
-		BUG();
-	}
-	bh = __get_hash_table(bdev, block, size);
-	atomic_dec(&bdev->bd_count);
-	return bh;
-}
-extern struct buffer_head * __getblk(struct block_device *, sector_t, int);
-static inline struct buffer_head * getblk(kdev_t dev, sector_t block, int size)
-{
-	struct block_device *bdev;
-	struct buffer_head *bh;
-	bdev = bdget(kdev_t_to_nr(dev));
-	if (!bdev) {
-		printk("No block device for %s\n", bdevname(dev));
-		BUG();
-	}
-	bh = __getblk(bdev, block, size);
-	atomic_dec(&bdev->bd_count);
-	return bh;
-}
+
 extern void ll_rw_block(int, int, struct buffer_head * bh[]);
 extern int submit_bh(int, struct buffer_head *);
 struct bio;
 extern int submit_bio(int, struct bio *);
 extern int is_read_only(kdev_t);
-extern void __brelse(struct buffer_head *);
-static inline void brelse(struct buffer_head *buf)
-{
-	if (buf)
-		__brelse(buf);
-}
-extern void __bforget(struct buffer_head *);
-static inline void bforget(struct buffer_head *buf)
-{
-	if (buf)
-		__bforget(buf);
-}
 extern int set_blocksize(kdev_t, int);
 extern int sb_set_blocksize(struct super_block *, int);
 extern int sb_min_blocksize(struct super_block *, int);
-extern struct buffer_head * __bread(struct block_device *, int, int);
-static inline struct buffer_head * bread(kdev_t dev, int block, int size)
-{
-	struct block_device *bdev;
-	struct buffer_head *bh;
-	bdev = bdget(kdev_t_to_nr(dev));
-	if (!bdev) {
-		printk("No block device for %s\n", bdevname(dev));
-		BUG();
-	}
-	bh = __bread(bdev, block, size);
-	atomic_dec(&bdev->bd_count);
-	return bh;
-}
-static inline struct buffer_head * sb_bread(struct super_block *sb, int block)
-{
-	return __bread(sb->s_bdev, block, sb->s_blocksize);
-}
-static inline struct buffer_head * sb_getblk(struct super_block *sb, int block)
-{
-	return __getblk(sb->s_bdev, block, sb->s_blocksize);
-}
-static inline struct buffer_head * sb_get_hash_table(struct super_block *sb, int block)
-{
-	return __get_hash_table(sb->s_bdev, block, sb->s_blocksize);
-}
-static inline void map_bh(struct buffer_head *bh, struct super_block *sb, int block)
-{
-	bh->b_state |= 1 << BH_Mapped;
-	bh->b_bdev = sb->s_bdev;
-	bh->b_dev = sb->s_dev;
-	bh->b_blocknr = block;
-}
-
-extern void wakeup_bdflush(void);
-extern struct buffer_head *alloc_buffer_head(int async);
-extern void free_buffer_head(struct buffer_head * bh);
-
-extern int brw_page(int, struct page *, struct block_device *, sector_t [], int);
-
-typedef int (get_block_t)(struct inode*,sector_t,struct buffer_head*,int);
-
-/* Generic buffer handling for block filesystems.. */
-extern int try_to_release_page(struct page * page, int gfp_mask);
-extern int block_flushpage(struct page *page, unsigned long offset);
-extern int block_symlink(struct inode *, const char *, int);
-extern int block_write_full_page(struct page*, get_block_t*);
-extern int block_read_full_page(struct page*, get_block_t*);
-extern int block_prepare_write(struct page*, unsigned, unsigned, get_block_t*);
-extern int cont_prepare_write(struct page*, unsigned, unsigned, get_block_t*,
-				unsigned long *);
-extern int generic_cont_expand(struct inode *inode, loff_t size) ;
-extern int block_commit_write(struct page *page, unsigned from, unsigned to);
-extern int block_sync_page(struct page *);
-
-sector_t generic_block_bmap(struct address_space *, sector_t, get_block_t *);
-int generic_commit_write(struct file *, struct page *, unsigned, unsigned);
-int block_truncate_page(struct address_space *, loff_t, get_block_t *);
-extern int generic_direct_IO(int, struct inode *, struct kiobuf *, unsigned long, int, get_block_t *);
 
 extern int generic_file_mmap(struct file *, struct vm_area_struct *);
 extern int file_read_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size);
@@ -1594,12 +1311,6 @@ extern ssize_t block_read(struct file *,
 extern ssize_t char_write(struct file *, const char *, size_t, loff_t *);
 extern ssize_t block_write(struct file *, const char *, size_t, loff_t *);
 
-extern int file_fsync(struct file *, struct dentry *, int);
-extern int generic_osync_inode(struct inode *, int);
-#define OSYNC_METADATA (1<<0)
-#define OSYNC_DATA (1<<1)
-#define OSYNC_INODE (1<<2)
-
 extern int inode_change_ok(struct inode *, struct iattr *);
 extern int inode_setattr(struct inode *, struct iattr *);
 
@@ -1612,8 +1323,7 @@ static inline ino_t parent_ino(struct de
 	return res;
 }
 
-void __buffer_error(char *file, int line);
-#define buffer_error() __buffer_error(__FILE__, __LINE__)
+#include <linux/buffer_head.h>
 
 #endif /* __KERNEL__ */
 
--- 2.5.9/drivers/block/ll_rw_blk.c~cleanup-070-bh_flags	Wed Apr 24 01:06:15 2002
+++ 2.5.9-akpm/drivers/block/ll_rw_blk.c	Wed Apr 24 01:29:31 2002
@@ -1429,7 +1429,7 @@ int submit_bh(int rw, struct buffer_head
 {
 	struct bio *bio;
 
-	BUG_ON(!test_bit(BH_Lock, &bh->b_state));
+	BUG_ON(!buffer_locked(bh));
 	BUG_ON(!buffer_mapped(bh));
 	BUG_ON(!bh->b_end_io);
 
@@ -1438,7 +1438,7 @@ int submit_bh(int rw, struct buffer_head
 	if (rw == WRITE && !buffer_uptodate(bh))
 		printk("%s: write of non-uptodate buffer\n", __FUNCTION__);
 		
-	set_bit(BH_Req, &bh->b_state);
+	set_buffer_req(bh);
 
 	/*
 	 * from here on down, it's all bio -- do the initial mapping,
@@ -1531,7 +1531,7 @@ void ll_rw_block(int rw, int nr, struct 
 		struct buffer_head *bh = bhs[i];
 
 		/* Only one thread can actually submit the I/O. */
-		if (test_and_set_bit(BH_Lock, &bh->b_state))
+		if (test_set_buffer_locked(bh))
 			continue;
 
 		/* We have the buffer lock */
@@ -1540,7 +1540,7 @@ void ll_rw_block(int rw, int nr, struct 
 
 		switch(rw) {
 		case WRITE:
-			if (!atomic_set_buffer_clean(bh))
+			if (!test_clear_buffer_dirty(bh))
 				/* Hmmph! Nothing to write */
 				goto end_io;
 			break;
@@ -1554,7 +1554,7 @@ void ll_rw_block(int rw, int nr, struct 
 		default:
 			BUG();
 	end_io:
-			bh->b_end_io(bh, test_bit(BH_Uptodate, &bh->b_state));
+			bh->b_end_io(bh, buffer_uptodate(bh));
 			continue;
 		}
 
@@ -1565,7 +1565,7 @@ void ll_rw_block(int rw, int nr, struct 
 sorry:
 	/* Make sure we don't get infinite dirty retries.. */
 	for (i = 0; i < nr; i++)
-		mark_buffer_clean(bhs[i]);
+		clear_buffer_dirty(bhs[i]);
 }
 
 #ifdef CONFIG_STRAM_SWAP
--- 2.5.9/drivers/md/raid5.c~cleanup-070-bh_flags	Wed Apr 24 01:06:15 2002
+++ 2.5.9-akpm/drivers/md/raid5.c	Wed Apr 24 01:20:43 2002
@@ -211,7 +211,7 @@ static inline void init_stripe(struct st
 			       buffer_locked(sh->bh_cache[i]));
 			BUG();
 		}
-		clear_bit(BH_Uptodate, &sh->bh_cache[i]->b_state);
+		clear_buffer_uptodate(sh->bh_cache[i]);
 		raid5_build_block(sh, i);
 	}
 	insert_hash(conf, sh);
@@ -411,7 +411,7 @@ static void raid5_end_read_request (stru
 			buffer = NULL;
 		spin_unlock_irqrestore(&conf->device_lock, flags);
 		if (sh->bh_page[i]==NULL)
-			set_bit(BH_Uptodate, &bh->b_state);
+			set_buffer_uptodate(bh);
 		if (buffer) {
 			if (buffer->b_page != bh->b_page)
 				memcpy(buffer->b_data, bh->b_data, bh->b_size);
@@ -419,16 +419,16 @@ static void raid5_end_read_request (stru
 		}
 	} else {
 		md_error(conf->mddev, bh->b_dev);
-		clear_bit(BH_Uptodate, &bh->b_state);
+		clear_buffer_uptodate(bh);
 	}
 	/* must restore b_page before unlocking buffer... */
 	if (sh->bh_page[i]) {
 		bh->b_page = sh->bh_page[i];
 		bh->b_data = page_address(bh->b_page);
 		sh->bh_page[i] = NULL;
-		clear_bit(BH_Uptodate, &bh->b_state);
+		clear_buffer_uptodate(bh);
 	}
-	clear_bit(BH_Lock, &bh->b_state);
+	clear_buffer_locked(bh);
 	set_bit(STRIPE_HANDLE, &sh->state);
 	release_stripe(sh);
 }
@@ -453,7 +453,7 @@ static void raid5_end_write_request (str
 	md_spin_lock_irqsave(&conf->device_lock, flags);
 	if (!uptodate)
 		md_error(conf->mddev, bh->b_dev);
-	clear_bit(BH_Lock, &bh->b_state);
+	clear_buffer_locked(bh);
 	set_bit(STRIPE_HANDLE, &sh->state);
 	__release_stripe(conf, sh);
 	md_spin_unlock_irqrestore(&conf->device_lock, flags);
@@ -682,7 +682,7 @@ static void compute_block(struct stripe_
 	}
 	if (count != 1)
 		xor_block(count, bh_ptr);
-	set_bit(BH_Uptodate, &sh->bh_cache[dd_idx]->b_state);
+	set_buffer_uptodate(sh->bh_cache[dd_idx]);
 }
 
 static void compute_parity(struct stripe_head *sh, int method)
@@ -741,8 +741,8 @@ static void compute_parity(struct stripe
 			memcpy(bh->b_data,
 			       bdata,sh->size);
 			bh_kunmap(chosen[i]);
-			set_bit(BH_Lock, &bh->b_state);
-			mark_buffer_uptodate(bh, 1);
+			set_buffer_locked(bh);
+			set_buffer_uptodate(bh);
 		}
 
 	switch(method) {
@@ -765,10 +765,10 @@ static void compute_parity(struct stripe
 		xor_block(count, bh_ptr);
 	
 	if (method != CHECK_PARITY) {
-		mark_buffer_uptodate(sh->bh_cache[pd_idx], 1);
-		set_bit(BH_Lock, &sh->bh_cache[pd_idx]->b_state);
+		set_buffer_uptodate(sh->bh_cache[pd_idx]);
+		set_buffer_locked(sh->bh_cache[pd_idx]);
 	} else
-		mark_buffer_uptodate(sh->bh_cache[pd_idx], 0);
+		clear_buffer_uptodate(sh->bh_cache[pd_idx]);
 }
 
 static void add_stripe_bh (struct stripe_head *sh, struct buffer_head *bh, int dd_idx, int rw)
@@ -955,7 +955,7 @@ static void handle_stripe(struct stripe_
 					compute_block(sh, i);
 					uptodate++;
 				} else if (conf->disks[i].operational) {
-					set_bit(BH_Lock, &bh->b_state);
+					set_buffer_locked(bh);
 					action[i] = READ+1;
 					/* if I am just reading this block and we don't have
 					   a failed drive, or any pending writes then sidestep the cache */
@@ -1011,7 +1011,7 @@ static void handle_stripe(struct stripe_
 					if (test_bit(STRIPE_PREREAD_ACTIVE, &sh->state))
 					{
 						PRINTK("Read_old block %d for r-m-w\n", i);
-						set_bit(BH_Lock, &bh->b_state);
+						set_buffer_locked(bh);
 						action[i] = READ+1;
 						locked++;
 					} else {
@@ -1030,7 +1030,7 @@ static void handle_stripe(struct stripe_
 					if (test_bit(STRIPE_PREREAD_ACTIVE, &sh->state))
 					{
 						PRINTK("Read_old block %d for Reconstruct\n", i);
-						set_bit(BH_Lock, &bh->b_state);
+						set_buffer_locked(bh);
 						action[i] = READ+1;
 						locked++;
 					} else {
@@ -1094,7 +1094,7 @@ static void handle_stripe(struct stripe_
 			if (uptodate != disks)
 				BUG();
 			bh = sh->bh_cache[failed_num];
-			set_bit(BH_Lock, &bh->b_state);
+			set_buffer_locked(bh);
 			action[failed_num] = WRITE+1;
 			locked++;
 			set_bit(STRIPE_INSYNC, &sh->state);
@@ -1146,7 +1146,7 @@ static void handle_stripe(struct stripe_
 				generic_make_request(action[i]-1, bh);
 			} else {
 				PRINTK("skip op %d on disc %d for sector %ld\n", action[i]-1, i, sh->sector);
-				clear_bit(BH_Lock, &bh->b_state);
+				clear_buffer_locked(bh);
 				set_bit(STRIPE_HANDLE, &sh->state);
 			}
 		}
@@ -1223,7 +1223,7 @@ static int raid5_make_request (mddev_t *
 		handle_stripe(sh);
 		release_stripe(sh);
 	} else
-		bh->b_end_io(bh, test_bit(BH_Uptodate, &bh->b_state));
+		bh->b_end_io(bh, buffer_uptodate(bh));
 	return 0;
 }
 
--- 2.5.9/fs/buffer.c~cleanup-070-bh_flags	Wed Apr 24 01:06:15 2002
+++ 2.5.9-akpm/fs/buffer.c	Wed Apr 24 01:35:35 2002
@@ -89,7 +89,7 @@ void unlock_buffer(struct buffer_head *b
 	if (atomic_read(&bh->b_count) == 0 && !PageLocked(bh->b_page))
 		buffer_error();
 
-	clear_bit(BH_Lock, &bh->b_state);
+	clear_buffer_locked(bh);
 	smp_mb__after_clear_bit();
 	if (waitqueue_active(&bh->b_wait))
 		wake_up(&bh->b_wait);
@@ -155,7 +155,10 @@ void end_buffer_io_sync(struct buffer_he
 {
 	if (!uptodate)
 		printk("%s: I/O error\n", __FUNCTION__);
-	mark_buffer_uptodate(bh, uptodate);
+	if (uptodate)
+		set_buffer_uptodate(bh);
+	else
+		clear_buffer_uptodate(bh);
 	unlock_buffer(bh);
 	put_bh(bh);
 }
@@ -516,7 +519,10 @@ static void end_buffer_io_async(struct b
 	if (!uptodate)
 		printk("%s: I/O error\n", __FUNCTION__);
 
-	mark_buffer_uptodate(bh, uptodate);
+	if (uptodate)
+		set_buffer_uptodate(bh);
+	else
+		clear_buffer_uptodate(bh);
 	page = bh->b_page;
 	if (!uptodate)
 		SetPageError(page);
@@ -527,7 +533,7 @@ static void end_buffer_io_async(struct b
 	 * decide that the page is now completely done.
 	 */
 	spin_lock_irqsave(&page_uptodate_lock, flags);
-	mark_buffer_async(bh, 0);
+	clear_buffer_async(bh);
 	unlock_buffer(bh);
 	tmp = bh;
 	do {
@@ -575,7 +581,7 @@ still_busy:
 inline void set_buffer_async_io(struct buffer_head *bh)
 {
 	bh->b_end_io = end_buffer_io_async;
-	mark_buffer_async(bh, 1);
+	set_buffer_async(bh);
 }
 
 /*
@@ -967,7 +973,7 @@ __getblk(struct block_device *bdev, sect
  */
 void mark_buffer_dirty(struct buffer_head *bh)
 {
-	if (!atomic_set_buffer_dirty(bh))
+	if (!test_set_buffer_dirty(bh))
 		__set_page_dirty_nobuffers(bh->b_page);
 }
 
@@ -994,7 +1000,7 @@ void __brelse(struct buffer_head * buf)
  */
 void __bforget(struct buffer_head * buf)
 {
-	mark_buffer_clean(buf);
+	clear_buffer_dirty(buf);
 	__brelse(buf);
 }
 
@@ -1052,12 +1058,12 @@ EXPORT_SYMBOL(set_bh_page);
 static void discard_buffer(struct buffer_head * bh)
 {
 	if (buffer_mapped(bh)) {
-		mark_buffer_clean(bh);
+		clear_buffer_dirty(bh);
 		lock_buffer(bh);
 		bh->b_bdev = NULL;
-		clear_bit(BH_Mapped, &bh->b_state);
-		clear_bit(BH_Req, &bh->b_state);
-		clear_bit(BH_New, &bh->b_state);
+		clear_buffer_mapped(bh);
+		clear_buffer_req(bh);
+		clear_buffer_new(bh);
 		unlock_buffer(bh);
 	}
 }
@@ -1167,7 +1173,7 @@ void create_empty_buffers(struct page *p
 	if (PageDirty(page)) {
 		bh = head;
 		do {
-			set_bit(BH_Dirty, &bh->b_state);
+			set_buffer_dirty(bh);
 			bh = bh->b_this_page;
 		} while (bh != head);
 	}
@@ -1197,9 +1203,9 @@ static void unmap_underlying_metadata(st
 		if (buffer_dirty(old_bh))
 			buffer_error();
 #endif
-		mark_buffer_clean(old_bh);
+		clear_buffer_dirty(old_bh);
 		wait_on_buffer(old_bh);
-		clear_bit(BH_Req, &old_bh->b_state);
+		clear_buffer_req(old_bh);
 		__brelse(old_bh);
 	}
 }
@@ -1266,7 +1272,7 @@ static int __block_write_full_page(struc
 			 * zeroed it out.  That seems unnecessary and may go
 			 * away.
 			 */
-			mark_buffer_uptodate(bh, 1);
+			set_buffer_uptodate(bh);
 		} else if (!buffer_mapped(bh) && buffer_dirty(bh)) {
 			if (buffer_new(bh))
 				buffer_error();
@@ -1275,7 +1281,7 @@ static int __block_write_full_page(struc
 				goto recover;
 			if (buffer_new(bh)) {
 				/* blockdev mappings never come here */
-				clear_bit(BH_New, &bh->b_state);
+				clear_buffer_new(bh);
 				unmap_underlying_metadata(bh);
 			}
 		}
@@ -1307,7 +1313,7 @@ static int __block_write_full_page(struc
 	do {
 		struct buffer_head *next = bh->b_this_page;
 		if (buffer_async(bh)) {
-			mark_buffer_clean(bh);
+			clear_buffer_dirty(bh);
 			submit_bh(WRITE, bh);
 			nr_underway++;
 		}
@@ -1354,15 +1360,15 @@ recover:
 			 * The buffer may have been set dirty during
 			 * attachment to a dirty page.
 			 */
-			mark_buffer_clean(bh);
+			clear_buffer_dirty(bh);
 		}
 		bh = bh->b_this_page;
 	} while (bh != head);
 	do {
 		struct buffer_head *next = bh->b_this_page;
 		if (buffer_mapped(bh)) {
-			mark_buffer_uptodate(bh, 1);
-			mark_buffer_clean(bh);
+			set_buffer_uptodate(bh);
+			clear_buffer_dirty(bh);
 			submit_bh(WRITE, bh);
 			nr_underway++;
 		}
@@ -1399,21 +1405,21 @@ static int __block_prepare_write(struct 
 		block_end = block_start + blocksize;
 		if (block_end <= from || block_start >= to) {
 			if (PageUptodate(page))
-				mark_buffer_uptodate(bh, 1);
+				set_buffer_uptodate(bh);
 			continue;
 		}
-		clear_bit(BH_New, &bh->b_state);
+		clear_buffer_new(bh);
 		if (!buffer_mapped(bh)) {
 			err = get_block(inode, block, bh, 1);
 			if (err)
 				goto out;
 			if (buffer_new(bh)) {
-				clear_bit(BH_New, &bh->b_state);
+				clear_buffer_new(bh);
 				unmap_underlying_metadata(bh);
 				if (PageUptodate(page)) {
 					if (!buffer_mapped(bh))
 						buffer_error();
-					mark_buffer_uptodate(bh, 1);
+					set_buffer_uptodate(bh);
 					continue;
 				}
 				if (block_end > to)
@@ -1427,7 +1433,7 @@ static int __block_prepare_write(struct 
 			}
 		}
 		if (PageUptodate(page)) {
-			mark_buffer_uptodate(bh, 1);
+			set_buffer_uptodate(bh);
 			continue; 
 		}
 		if (!buffer_uptodate(bh) &&
@@ -1460,13 +1466,13 @@ out:
 		if (block_start >= to)
 			break;
 		if (buffer_new(bh)) {
-			clear_bit(BH_New, &bh->b_state);
+			clear_buffer_new(bh);
 			if (buffer_uptodate(bh))
 				printk(KERN_ERR
 					"%s: zeroing uptodate buffer!\n",
 					__FUNCTION__);
 			memset(kaddr+block_start, 0, bh->b_size);
-			mark_buffer_uptodate(bh, 1);
+			set_buffer_uptodate(bh);
 			mark_buffer_dirty(bh);
 		}
 next_bh:
@@ -1494,7 +1500,7 @@ static int __block_commit_write(struct i
 			if (!buffer_uptodate(bh))
 				partial = 1;
 		} else {
-			mark_buffer_uptodate(bh, 1);
+			set_buffer_uptodate(bh);
 			mark_buffer_dirty(bh);
 		}
 	}
@@ -1514,7 +1520,7 @@ static int __block_commit_write(struct i
  * Generic "read page" function for block devices that have the normal
  * get_block functionality. This is most of the block device filesystems.
  * Reads the page asynchronously --- the unlock_buffer() and
- * mark_buffer_uptodate() functions propagate buffer state into the
+ * set/clear_buffer_uptodate() functions propagate buffer state into the
  * page struct once IO has completed.
  */
 int block_read_full_page(struct page *page, get_block_t *get_block)
@@ -1554,7 +1560,7 @@ int block_read_full_page(struct page *pa
 				memset(kmap(page) + i*blocksize, 0, blocksize);
 				flush_dcache_page(page);
 				kunmap(page);
-				mark_buffer_uptodate(bh, 1);
+				set_buffer_uptodate(bh);
 				continue;
 			}
 			/*
@@ -1823,7 +1829,7 @@ int block_truncate_page(struct address_s
 
 	/* Ok, it's mapped. Make sure it's up-to-date */
 	if (PageUptodate(page))
-		mark_buffer_uptodate(bh, 1);
+		set_buffer_uptodate(bh);
 
 	if (!buffer_uptodate(bh)) {
 		err = -EIO;
@@ -2018,9 +2024,9 @@ int brw_page(int rw, struct page *page,
 		bh->b_blocknr = *(b++);
 		bh->b_bdev = bdev;
 		bh->b_dev = to_kdev_t(bdev->bd_dev);
-		set_bit(BH_Mapped, &bh->b_state);
+		set_buffer_mapped(bh);
 		if (rw == WRITE)	/* To support submit_bh debug tests */
-			mark_buffer_uptodate(bh, 1);
+			set_buffer_uptodate(bh);
 		set_buffer_async_io(bh);
 		bh = bh->b_this_page;
 	} while (bh != head);
--- 2.5.9/fs/ext3/inode.c~cleanup-070-bh_flags	Wed Apr 24 01:06:15 2002
+++ 2.5.9-akpm/fs/ext3/inode.c	Wed Apr 24 01:39:40 2002
@@ -575,7 +575,7 @@ static int ext3_alloc_branch(handle_t *h
 			branch[n].p = (u32*) bh->b_data + offsets[n];
 			*branch[n].p = branch[n].key;
 			BUFFER_TRACE(bh, "marking uptodate");
-			mark_buffer_uptodate(bh, 1);
+			set_buffer_uptodate(bh);
 			unlock_buffer(bh);
 
 			BUFFER_TRACE(bh, "call ext3_journal_dirty_metadata");
@@ -746,7 +746,7 @@ reread:
 
 	/* Simplest case - block found, no allocation needed */
 	if (!partial) {
-		bh_result->b_state &= ~(1UL << BH_New);
+		clear_buffer_new(bh_result);
 got_it:
 		map_bh(bh_result, inode->i_sb, le32_to_cpu(chain[depth-1].key));
 		/* Clean up and exit */
@@ -812,7 +812,7 @@ out:
 	if (new_size > ei->i_disksize)
 		ei->i_disksize = new_size;
 
-	bh_result->b_state |= (1UL << BH_New);
+	set_buffer_new(bh_result);
 	goto got_it;
 
 changed:
@@ -874,7 +874,7 @@ struct buffer_head *ext3_getblk(handle_t
 			if (!fatal) {
 				memset(bh->b_data, 0,
 				       inode->i_sb->s_blocksize);
-				mark_buffer_uptodate(bh, 1);
+				set_buffer_uptodate(bh);
 			}
 			unlock_buffer(bh);
 			BUFFER_TRACE(bh, "call ext3_journal_dirty_metadata");
@@ -1070,7 +1070,7 @@ static int journal_dirty_async_data(hand
 /* For commit_write() in data=journal mode */
 static int commit_write_fn(handle_t *handle, struct buffer_head *bh)
 {
-	set_bit(BH_Uptodate, &bh->b_state);
+	set_buffer_uptodate(bh);
 	return ext3_journal_dirty_metadata(handle, bh);
 }
 
@@ -1423,7 +1423,7 @@ static int ext3_block_truncate_page(hand
 
 	/* Ok, it's mapped. Make sure it's up-to-date */
 	if (PageUptodate(page))
-		set_bit(BH_Uptodate, &bh->b_state);
+		set_buffer_uptodate(bh);
 
 	if (!buffer_uptodate(bh)) {
 		err = -EIO;
--- 2.5.9/fs/jbd/transaction.c~cleanup-070-bh_flags	Wed Apr 24 01:06:15 2002
+++ 2.5.9-akpm/fs/jbd/transaction.c	Wed Apr 24 01:36:56 2002
@@ -1202,7 +1202,7 @@ void journal_forget (handle_t *handle, s
 		/* If we are forgetting a buffer which is already part
 		 * of this transaction, then we can just drop it from
 		 * the transaction immediately. */
-		clear_bit(BH_Dirty, &bh->b_state);
+		clear_buffer_dirty(bh);
 		clear_bit(BH_JBDDirty, &bh->b_state);
 
 		JBUFFER_TRACE(jh, "belongs to current transaction: unfile");
@@ -1547,9 +1547,8 @@ void __journal_unfile_buffer(struct jour
 	
 	__blist_del_buffer(list, jh);
 	jh->b_jlist = BJ_None;
-	if (test_and_clear_bit(BH_JBDDirty, &jh2bh(jh)->b_state)) {
-		set_bit(BH_Dirty, &jh2bh(jh)->b_state);
-	}
+	if (test_and_clear_bit(BH_JBDDirty, &jh2bh(jh)->b_state))
+		set_buffer_dirty(jh2bh(jh));
 }
 
 void journal_unfile_buffer(struct journal_head *jh)
@@ -1856,12 +1855,11 @@ static int journal_unmap_buffer(journal_
 
 zap_buffer:	
 	if (buffer_dirty(bh))
-		mark_buffer_clean(bh);
+		clear_buffer_dirty(bh);
 	J_ASSERT_BH(bh, !buffer_jdirty(bh));
-//	clear_bit(BH_Uptodate, &bh->b_state);
-	clear_bit(BH_Mapped, &bh->b_state);
-	clear_bit(BH_Req, &bh->b_state);
-	clear_bit(BH_New, &bh->b_state);
+	clear_buffer_mapped(bh);
+	clear_buffer_req(bh);
+	clear_buffer_new(bh);
 	bh->b_bdev = NULL;
 	return may_free;
 }
@@ -1976,7 +1974,7 @@ void __journal_file_buffer(struct journa
 
 	if (jlist == BJ_Metadata || jlist == BJ_Reserved || 
 	    jlist == BJ_Shadow || jlist == BJ_Forget) {
-		if (atomic_set_buffer_clean(jh2bh(jh))) {
+		if (test_clear_buffer_dirty(jh2bh(jh))) {
 			set_bit(BH_JBDDirty, &jh2bh(jh)->b_state);
 		}
 	}
--- 2.5.9/fs/reiserfs/inode.c~cleanup-070-bh_flags	Wed Apr 24 01:06:15 2002
+++ 2.5.9-akpm/fs/reiserfs/inode.c	Wed Apr 24 01:38:14 2002
@@ -329,7 +329,7 @@ research:
 	** and jump to the end
 	*/
 	    if (PageUptodate(bh_result->b_page)) {
-		mark_buffer_uptodate(bh_result, 1);
+		set_buffer_uptodate(bh_result);
 		goto finished ;
     }
 
@@ -398,7 +398,7 @@ finished:
     pathrelse (&path);
     /* I _really_ doubt that you want it.  Chris? */
     map_bh(bh_result, inode->i_sb, 0);
-    mark_buffer_uptodate (bh_result, 1);
+    set_buffer_uptodate (bh_result);
     return 0;
 }
 
@@ -653,7 +653,7 @@ int reiserfs_get_block (struct inode * i
 		reiserfs_restore_prepared_buffer(inode->i_sb, bh) ;
 		goto research;
 	    }
-	    bh_result->b_state |= (1UL << BH_New);
+	    set_buffer_new(bh_result);
 	    put_block_num(item, pos_in_item, allocated_block_nr) ;
             unfm_ptr = allocated_block_nr;
 	    journal_mark_dirty (&th, inode->i_sb, bh);
@@ -705,7 +705,7 @@ int reiserfs_get_block (struct inode * i
 		   allocated block for that */
 		unp = cpu_to_le32 (allocated_block_nr);
 		set_block_dev_mapped (bh_result, allocated_block_nr, inode);
-		bh_result->b_state |= (1UL << BH_New);
+		set_buffer_new(bh_result);
 		done = 1;
 	    }
 	    tmp_key = key; // ;)
@@ -761,7 +761,7 @@ int reiserfs_get_block (struct inode * i
 		reiserfs_free_block (&th, allocated_block_nr);
 		goto failure;
 	    }
-	    /* it is important the mark_buffer_uptodate is done after
+	    /* it is important the set_buffer_uptodate is done after
 	    ** the direct2indirect.  The buffer might contain valid
 	    ** data newer than the data on disk (read by readpage, changed,
 	    ** and then sent here by writepage).  direct2indirect needs
@@ -769,7 +769,7 @@ int reiserfs_get_block (struct inode * i
 	    ** if the data in unbh needs to be replaced with data from
 	    ** the disk
 	    */
-	    mark_buffer_uptodate (unbh, 1);
+	    set_buffer_uptodate (unbh);
 
 	    /* we've converted the tail, so we must 
 	    ** flush unbh before the transaction commits
@@ -809,7 +809,7 @@ int reiserfs_get_block (struct inode * i
 		   block for that */
 		un.unfm_nodenum = cpu_to_le32 (allocated_block_nr);
 		set_block_dev_mapped (bh_result, allocated_block_nr, inode);
-		bh_result->b_state |= (1UL << BH_New);
+		set_buffer_new(bh_result);
 		done = 1;
 	    } else {
 		/* paste hole to the indirect item */
@@ -1851,7 +1851,7 @@ research:
 	    goto out ;
 	}
 	set_block_dev_mapped(bh_result, get_block_num(item,pos_in_item),inode);
-        mark_buffer_uptodate(bh_result, 1);
+        set_buffer_uptodate(bh_result);
     } else if (is_direct_le_ih(ih)) {
         char *p ; 
         p = page_address(bh_result->b_page) ;
@@ -1871,7 +1871,7 @@ research:
 	journal_mark_dirty(&th, inode->i_sb, bh) ;
 	bytes_copied += copy_size ;
 	set_block_dev_mapped(bh_result, 0, inode);
-        mark_buffer_uptodate(bh_result, 1);
+        set_buffer_uptodate(bh_result);
 
 	/* are there still bytes left? */
         if (bytes_copied < bh_result->b_size && 
@@ -1921,8 +1921,8 @@ static inline void submit_bh_for_writepa
 	** later on in the call chain will be cleaning it.  So, we
 	** clean the buffer here, it still gets written either way.
 	*/
-	clear_bit(BH_Dirty, &bh->b_state) ;
-	set_bit(BH_Uptodate, &bh->b_state) ;
+	clear_buffer_dirty(bh) ;
+	set_buffer_uptodate(bh) ;
 	submit_bh(WRITE, bh) ;
     }
 }
--- 2.5.9/fs/reiserfs/do_balan.c~cleanup-070-bh_flags	Wed Apr 24 01:06:15 2002
+++ 2.5.9-akpm/fs/reiserfs/do_balan.c	Wed Apr 24 01:27:26 2002
@@ -48,7 +48,7 @@ inline void do_balance_mark_leaf_dirty (
 					struct buffer_head * bh, int flag)
 {
     if (reiserfs_dont_log(tb->tb_sb)) {
-	if (!test_and_set_bit(BH_Dirty, &bh->b_state)) {
+	if (!test_set_buffer_dirty(bh)) {
 //	    __mark_buffer_dirty(bh) ;
 	    tb->need_balance_dirty = 1;
 	}
@@ -1225,7 +1225,7 @@ struct buffer_head * get_FEB (struct tre
     bi.bi_parent = 0;
     bi.bi_position = 0;
     make_empty_node (&bi);
-    set_bit(BH_Uptodate, &first_b->b_state);
+    set_buffer_uptodate(first_b);
     tb->FEB[i] = 0;
     tb->used[i] = first_b;
 
@@ -1272,7 +1272,7 @@ void reiserfs_invalidate_buffer (struct 
     set_blkh_level( blkh, FREE_LEVEL );
     set_blkh_nr_item( blkh, 0 );
     
-    mark_buffer_clean (bh);
+    clear_buffer_dirty(bh);
     /* reiserfs_free_block is no longer schedule safe 
     reiserfs_free_block (tb->transaction_handle, tb->tb_sb, bh->b_blocknr);
     */
--- 2.5.9/fs/buffer.c.orig~cleanup-070-bh_flags	Wed Apr 24 01:06:15 2002
+++ 2.5.9-akpm/fs/buffer.c.orig	Wed Apr 24 01:06:15 2002
@@ -1055,7 +1055,7 @@ void __brelse(struct buffer_head * buf)
  */
 void __bforget(struct buffer_head * buf)
 {
-	mark_buffer_clean(buf);
+	clear_buffer_dirty(buf);
 	__brelse(buf);
 }
 
@@ -1161,7 +1161,7 @@ EXPORT_SYMBOL(set_bh_page);
 static void discard_buffer(struct buffer_head * bh)
 {
 	if (buffer_mapped(bh)) {
-		mark_buffer_clean(bh);
+		clear_buffer_dirty(bh);
 		lock_buffer(bh);
 		bh->b_bdev = NULL;
 		clear_bit(BH_Mapped, &bh->b_state);
@@ -1306,7 +1306,7 @@ static void unmap_underlying_metadata(st
 		if (buffer_dirty(old_bh))
 			buffer_error();
 #endif
-		mark_buffer_clean(old_bh);
+		clear_buffer_dirty(old_bh);
 		wait_on_buffer(old_bh);
 		clear_bit(BH_Req, &old_bh->b_state);
 		__brelse(old_bh);
@@ -1416,7 +1416,7 @@ static int __block_write_full_page(struc
 	do {
 		struct buffer_head *next = bh->b_this_page;
 		if (buffer_async(bh)) {
-			mark_buffer_clean(bh);
+			clear_buffer_dirty(bh);
 			submit_bh(WRITE, bh);
 			nr_underway++;
 		}
@@ -1463,7 +1463,7 @@ recover:
 			 * The buffer may have been set dirty during
 			 * attachment to a dirty page.
 			 */
-			mark_buffer_clean(bh);
+			clear_buffer_dirty(bh);
 		}
 		bh = bh->b_this_page;
 	} while (bh != head);
@@ -1471,7 +1471,7 @@ recover:
 		struct buffer_head *next = bh->b_this_page;
 		if (buffer_mapped(bh)) {
 			mark_buffer_uptodate(bh, 1);
-			mark_buffer_clean(bh);
+			clear_buffer_dirty(bh);
 			submit_bh(WRITE, bh);
 			nr_underway++;
 		}
--- 2.5.9/fs/ext2/inode.c~cleanup-070-bh_flags	Wed Apr 24 01:06:15 2002
+++ 2.5.9-akpm/fs/ext2/inode.c	Wed Apr 24 01:35:46 2002
@@ -403,7 +403,7 @@ static int ext2_alloc_branch(struct inod
 		branch[n].bh = bh;
 		branch[n].p = (u32*) bh->b_data + offsets[n];
 		*branch[n].p = branch[n].key;
-		mark_buffer_uptodate(bh, 1);
+		set_buffer_uptodate(bh);
 		unlock_buffer(bh);
 		mark_buffer_dirty_inode(bh, inode);
 		/* We used to sync bh here if IS_SYNC(inode).
@@ -552,7 +552,7 @@ out:
 	if (ext2_splice_branch(inode, iblock, chain, partial, left) < 0)
 		goto changed;
 
-	bh_result->b_state |= (1UL << BH_New);
+	set_buffer_new(bh_result);
 	goto got_it;
 
 changed:
--- 2.5.9/fs/fat/buffer.c~cleanup-070-bh_flags	Wed Apr 24 01:06:15 2002
+++ 2.5.9-akpm/fs/fat/buffer.c	Wed Apr 24 01:06:15 2002
@@ -75,7 +75,10 @@ void default_fat_set_uptodate (
 	struct buffer_head *bh,
 	int val)
 {
-	mark_buffer_uptodate(bh, val);
+	if (val)
+		set_buffer_uptodate(bh);
+	else
+		clear_buffer_uptodate(bh);
 }
 
 int default_fat_is_uptodate (struct super_block *sb, struct buffer_head *bh)
--- 2.5.9/fs/hfs/file.c~cleanup-070-bh_flags	Wed Apr 24 01:06:15 2002
+++ 2.5.9-akpm/fs/hfs/file.c	Wed Apr 24 01:36:34 2002
@@ -114,7 +114,7 @@ int hfs_get_block(struct inode *inode, s
 	phys = hfs_extent_map(HFS_I(inode)->fork, iblock, create);
 	if (phys) {
 		if (create)
-			bh_result->b_state |= (1UL << BH_New);
+			set_buffer_new(bh_result);
 		map_bh(bh_result, inode->i_sb, phys);
 		return 0;
 	}
@@ -479,7 +479,7 @@ hfs_s32 hfs_do_write(struct inode *inode
 		pos += c;
 		written += c;
 		buf += c;
-		mark_buffer_uptodate(bh, 1);
+		set_buffer_uptodate(bh);
 		mark_buffer_dirty(bh);
 		brelse(bh);
 	}
--- 2.5.9/fs/hfs/sysdep.c~cleanup-070-bh_flags	Wed Apr 24 01:06:15 2002
+++ 2.5.9-akpm/fs/hfs/sysdep.c	Wed Apr 24 01:06:15 2002
@@ -45,7 +45,7 @@ hfs_buffer hfs_buffer_get(hfs_sysmdb sys
 	} else {
 		tmp = sb_getblk(sys_mdb, block);
 		if (tmp) {
-			mark_buffer_uptodate(tmp, 1);
+			set_buffer_uptodate(tmp);
 		}
 	}
 	if (!tmp) {
--- 2.5.9/fs/hpfs/buffer.c~cleanup-070-bh_flags	Wed Apr 24 01:06:15 2002
+++ 2.5.9-akpm/fs/hpfs/buffer.c	Wed Apr 24 01:06:15 2002
@@ -180,7 +180,7 @@ void *hpfs_get_sector(struct super_block
 
 	if ((*bhp = bh = sb_getblk(s, secno)) != NULL) {
 		if (!buffer_uptodate(bh)) wait_on_buffer(bh);
-		mark_buffer_uptodate(bh, 1);
+		set_buffer_uptodate(bh);
 		return bh->b_data;
 	} else {
 		printk("HPFS: hpfs_get_sector: getblk failed\n");
--- 2.5.9/fs/jbd/commit.c~cleanup-070-bh_flags	Wed Apr 24 01:06:15 2002
+++ 2.5.9-akpm/fs/jbd/commit.c	Wed Apr 24 01:26:18 2002
@@ -29,7 +29,10 @@ extern spinlock_t journal_datalist_lock;
 static void journal_end_buffer_io_sync(struct buffer_head *bh, int uptodate)
 {
 	BUFFER_TRACE(bh, "");
-	mark_buffer_uptodate(bh, uptodate);
+	if (uptodate)
+		set_buffer_uptodate(bh);
+	else
+		clear_buffer_uptodate(bh);
 	unlock_buffer(bh);
 }
 
@@ -447,9 +450,9 @@ start_journal_io:
 			unlock_journal(journal);
 			for (i=0; i<bufs; i++) {
 				struct buffer_head *bh = wbuf[i];
-				set_bit(BH_Lock, &bh->b_state);
-				clear_bit(BH_Dirty, &bh->b_state);
-				mark_buffer_uptodate(bh, 1);
+				set_buffer_locked(bh);
+				clear_buffer_dirty(bh);
+				set_buffer_uptodate(bh);
 				bh->b_end_io = journal_end_buffer_io_sync;
 				submit_bh(WRITE, bh);
 			}
@@ -588,7 +591,7 @@ start_journal_io:
 	JBUFFER_TRACE(descriptor, "write commit block");
 	{
 		struct buffer_head *bh = jh2bh(descriptor);
-		mark_buffer_uptodate(bh, 1);
+		set_buffer_uptodate(bh);
 		ll_rw_block(WRITE, 1, &bh);
 		wait_on_buffer(bh);
 		__brelse(bh);		/* One for getblk() */
--- 2.5.9/fs/jbd/journal.c~cleanup-070-bh_flags	Wed Apr 24 01:06:15 2002
+++ 2.5.9-akpm/fs/jbd/journal.c	Wed Apr 24 01:32:57 2002
@@ -475,7 +475,8 @@ int journal_write_metadata_buffer(transa
 	new_bh->b_bdev = transaction->t_journal->j_dev;
 	new_bh->b_dev = to_kdev_t(transaction->t_journal->j_dev->bd_dev);
 	new_bh->b_blocknr = blocknr;
-	new_bh->b_state |= (1 << BH_Mapped) | (1 << BH_Dirty);
+	set_buffer_mapped(new_bh);
+	set_buffer_dirty(new_bh);
 
 	*jh_out = new_jh;
 
@@ -887,7 +888,7 @@ int journal_create (journal_t *journal)
 		BUFFER_TRACE(bh, "marking dirty");
 		mark_buffer_dirty(bh);
 		BUFFER_TRACE(bh, "marking uptodate");
-		mark_buffer_uptodate(bh, 1);
+		set_buffer_uptodate(bh);
 		unlock_buffer(bh);
 		__brelse(bh);
 	}
--- 2.5.9/fs/jbd/recovery.c~cleanup-070-bh_flags	Wed Apr 24 01:06:15 2002
+++ 2.5.9-akpm/fs/jbd/recovery.c	Wed Apr 24 01:06:15 2002
@@ -484,7 +484,7 @@ static int do_one_pass(journal_t *journa
 					BUFFER_TRACE(nbh, "marking dirty");
 					mark_buffer_dirty(nbh);
 					BUFFER_TRACE(nbh, "marking uptodate");
-					mark_buffer_uptodate(nbh, 1);
+					set_buffer_uptodate(nbh);
 					++info->nr_replays;
 					/* ll_rw_block(WRITE, 1, &nbh); */
 					unlock_buffer(nbh);
--- 2.5.9/fs/jbd/revoke.c~cleanup-070-bh_flags	Wed Apr 24 01:06:15 2002
+++ 2.5.9-akpm/fs/jbd/revoke.c	Wed Apr 24 01:06:15 2002
@@ -541,7 +541,7 @@ static void flush_descriptor(journal_t *
 	{
 		struct buffer_head *bh = jh2bh(descriptor);
 		BUFFER_TRACE(bh, "write");
-		mark_buffer_uptodate(bh, 1);
+		set_buffer_uptodate(bh);
 		ll_rw_block (WRITE, 1, &bh);
 	}
 }
--- 2.5.9/fs/jfs/namei.c~cleanup-070-bh_flags	Wed Apr 24 01:06:15 2002
+++ 2.5.9-akpm/fs/jfs/namei.c	Wed Apr 24 01:06:15 2002
@@ -969,7 +969,7 @@ int jfs_symlink(struct inode *dip, struc
 				memcpy(mp->data, name, copy_size);
 				flush_metapage(mp);
 #if 0
-				mark_buffer_uptodate(bp, 1);
+				set_buffer_uptodate(bp);
 				mark_buffer_dirty(bp, 1);
 				if (IS_SYNC(dip)) {
 					ll_rw_block(WRITE, 1, &bp);
--- 2.5.9/fs/minix/itree_common.c~cleanup-070-bh_flags	Wed Apr 24 01:06:15 2002
+++ 2.5.9-akpm/fs/minix/itree_common.c	Wed Apr 24 01:37:47 2002
@@ -89,7 +89,7 @@ static int alloc_branch(struct inode *in
 		branch[n].bh = bh;
 		branch[n].p = (block_t*) bh->b_data + offsets[n];
 		*branch[n].p = branch[n].key;
-		mark_buffer_uptodate(bh, 1);
+		set_buffer_uptodate(bh);
 		unlock_buffer(bh);
 		mark_buffer_dirty_inode(bh, inode);
 		parent = nr;
@@ -194,7 +194,7 @@ out:
 	if (splice_branch(inode, chain, partial, left) < 0)
 		goto changed;
 
-	bh->b_state |= (1UL << BH_New);
+	set_buffer_new(bh);
 	goto got_it;
 
 changed:
--- 2.5.9/fs/reiserfs/journal.c~cleanup-070-bh_flags	Wed Apr 24 01:06:15 2002
+++ 2.5.9-akpm/fs/reiserfs/journal.c	Wed Apr 24 01:28:40 2002
@@ -124,7 +124,7 @@ static void init_journal_hash(struct sup
 */
 static int reiserfs_clean_and_file_buffer(struct buffer_head *bh) {
   if (bh)
-    mark_buffer_clean(bh);
+    clear_buffer_dirty(bh);
   return 0 ;
 }
 
@@ -847,7 +847,7 @@ static int _update_journal_header_block(
     jh->j_last_flush_trans_id = cpu_to_le32(trans_id) ;
     jh->j_first_unflushed_offset = cpu_to_le32(offset) ;
     jh->j_mount_id = cpu_to_le32(SB_JOURNAL(p_s_sb)->j_mount_id) ;
-    set_bit(BH_Dirty, &(SB_JOURNAL(p_s_sb)->j_header_bh->b_state)) ;
+    set_buffer_dirty(SB_JOURNAL(p_s_sb)->j_header_bh) ;
     ll_rw_block(WRITE, 1, &(SB_JOURNAL(p_s_sb)->j_header_bh)) ;
     wait_on_buffer((SB_JOURNAL(p_s_sb)->j_header_bh)) ; 
     if (!buffer_uptodate(SB_JOURNAL(p_s_sb)->j_header_bh)) {
@@ -893,7 +893,10 @@ static void reiserfs_end_buffer_io_sync(
         reiserfs_warning("clm-2084: pinned buffer %lu:%s sent to disk\n",
 	                 bh->b_blocknr, kdevname(bh->b_dev)) ;
     }
-    mark_buffer_uptodate(bh, uptodate) ;
+    if (uptodate)
+    	set_buffer_uptodate(bh) ;
+    else
+    	clear_buffer_uptodate(bh) ;
     unlock_buffer(bh) ;
     put_bh(bh) ;
 }
@@ -902,7 +905,7 @@ static void submit_logged_buffer(struct 
     get_bh(bh) ;
     bh->b_end_io = reiserfs_end_buffer_io_sync ;
     mark_buffer_notjournal_new(bh) ;
-    clear_bit(BH_Dirty, &bh->b_state) ;
+    clear_buffer_dirty(bh) ;
     submit_bh(WRITE, bh) ;
 }
 
@@ -1565,12 +1568,12 @@ static int journal_read_transaction(stru
       return -1 ;
     }
     memcpy(real_blocks[i]->b_data, log_blocks[i]->b_data, real_blocks[i]->b_size) ;
-    mark_buffer_uptodate(real_blocks[i], 1) ;
+    set_buffer_uptodate(real_blocks[i]) ;
     brelse(log_blocks[i]) ;
   }
   /* flush out the real blocks */
   for (i = 0 ; i < le32_to_cpu(desc->j_len) ; i++) {
-    set_bit(BH_Dirty, &(real_blocks[i]->b_state)) ;
+    set_buffer_dirty(real_blocks[i]) ;
     ll_rw_block(WRITE, 1, real_blocks + i) ;
   }
   for (i = 0 ; i < le32_to_cpu(desc->j_len) ; i++) {
@@ -2389,7 +2392,7 @@ int journal_mark_dirty(struct reiserfs_t
   }
 
   if (buffer_dirty(bh)) {
-    clear_bit(BH_Dirty, &bh->b_state) ;
+    clear_buffer_dirty(bh) ;
   }
 
   if (buffer_journaled(bh)) { /* must double check after getting lock */
@@ -2979,7 +2982,7 @@ static int do_journal_end(struct reiserf
   rs = SB_DISK_SUPER_BLOCK(p_s_sb) ;
   /* setup description block */
   d_bh = journ_getblk(p_s_sb, SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + SB_JOURNAL(p_s_sb)->j_start) ; 
-  mark_buffer_uptodate(d_bh, 1) ;
+  set_buffer_uptodate(d_bh) ;
   desc = (struct reiserfs_journal_desc *)(d_bh)->b_data ;
   memset(desc, 0, sizeof(struct reiserfs_journal_desc)) ;
   memcpy(desc->j_magic, JOURNAL_DESC_MAGIC, 8) ;
@@ -2991,7 +2994,7 @@ static int do_journal_end(struct reiserf
   commit = (struct reiserfs_journal_commit *)c_bh->b_data ;
   memset(commit, 0, sizeof(struct reiserfs_journal_commit)) ;
   commit->j_trans_id = cpu_to_le32(SB_JOURNAL(p_s_sb)->j_trans_id) ;
-  mark_buffer_uptodate(c_bh, 1) ;
+  set_buffer_uptodate(c_bh) ;
 
   /* init this journal list */
   atomic_set(&(SB_JOURNAL_LIST(p_s_sb)[SB_JOURNAL_LIST_INDEX(p_s_sb)].j_older_commits_done), 0) ;
@@ -3079,7 +3082,7 @@ printk("journal-2020: do_journal_end: BA
       struct buffer_head *tmp_bh ;
       tmp_bh =  journ_getblk(p_s_sb, SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + 
 		       ((cur_write_start + jindex) % SB_ONDISK_JOURNAL_SIZE(p_s_sb))) ;
-      mark_buffer_uptodate(tmp_bh, 1) ;
+      set_buffer_uptodate(tmp_bh) ;
       memcpy(tmp_bh->b_data, cn->bh->b_data, cn->bh->b_size) ;  
       jindex++ ;
     } else {
--- 2.5.9/fs/reiserfs/resize.c~cleanup-070-bh_flags	Wed Apr 24 01:06:15 2002
+++ 2.5.9-akpm/fs/reiserfs/resize.c	Wed Apr 24 01:06:15 2002
@@ -116,7 +116,7 @@ int reiserfs_resize (struct super_block 
 		reiserfs_test_and_set_le_bit(0, bitmap[i]->b_data);
 
 		mark_buffer_dirty(bitmap[i]) ;
-		mark_buffer_uptodate(bitmap[i], 1);
+		set_buffer_uptodate(bitmap[i]);
 		ll_rw_block(WRITE, 1, bitmap + i);
 		wait_on_buffer(bitmap[i]);
 	    }	
--- 2.5.9/fs/sysv/balloc.c~cleanup-070-bh_flags	Wed Apr 24 01:06:15 2002
+++ 2.5.9-akpm/fs/sysv/balloc.c	Wed Apr 24 01:06:15 2002
@@ -83,7 +83,7 @@ void sysv_free_block(struct super_block 
 		*(u16*)bh->b_data = cpu_to_fs16(sb, count);
 		memcpy(get_chunk(sb,bh), blocks, count * sizeof(sysv_zone_t));
 		mark_buffer_dirty(bh);
-		mark_buffer_uptodate(bh, 1);
+		set_buffer_uptodate(bh);
 		brelse(bh);
 		count = 0;
 	}
--- 2.5.9/fs/sysv/itree.c~cleanup-070-bh_flags	Wed Apr 24 01:06:15 2002
+++ 2.5.9-akpm/fs/sysv/itree.c	Wed Apr 24 01:38:33 2002
@@ -145,7 +145,7 @@ static int alloc_branch(struct inode *in
 		branch[n].bh = bh;
 		branch[n].p = (u32*) bh->b_data + offsets[n];
 		*branch[n].p = branch[n].key;
-		mark_buffer_uptodate(bh, 1);
+		set_buffer_uptodate(bh);
 		unlock_buffer(bh);
 		dirty_indirect(bh, inode);
 	}
@@ -246,7 +246,7 @@ out:
 	if (splice_branch(inode, chain, partial, left) < 0)
 		goto changed;
 
-	bh_result->b_state |= (1UL << BH_New);
+	set_buffer_new(bh_result);
 	goto got_it;
 
 changed:
--- 2.5.9/fs/udf/inode.c~cleanup-070-bh_flags	Wed Apr 24 01:06:15 2002
+++ 2.5.9-akpm/fs/udf/inode.c	Wed Apr 24 01:38:44 2002
@@ -254,7 +254,7 @@ struct buffer_head * udf_expand_dir_adin
 		return NULL;
 	lock_buffer(dbh);
 	memset(dbh->b_data, 0x00, inode->i_sb->s_blocksize);
-	mark_buffer_uptodate(dbh, 1);
+	set_buffer_uptodate(dbh);
 	unlock_buffer(dbh);
 	mark_buffer_dirty_inode(dbh, inode);
 
@@ -348,7 +348,7 @@ static int udf_get_block(struct inode *i
 		BUG();
 
 	if (new)
-		bh_result->b_state |= (1UL << BH_New);
+		set_buffer_new(bh_result);
 	map_bh(bh_result, inode->i_sb, phys);
 abort:
 	unlock_kernel();
@@ -375,7 +375,7 @@ struct buffer_head * udf_getblk(struct i
 		{
 			lock_buffer(bh);
 			memset(bh->b_data, 0x00, inode->i_sb->s_blocksize);
-			mark_buffer_uptodate(bh, 1);
+			set_buffer_uptodate(bh);
 			unlock_buffer(bh);
 			mark_buffer_dirty_inode(bh, inode);
 		}
@@ -1656,7 +1656,7 @@ int8_t udf_add_aext(struct inode *inode,
 		}
 		lock_buffer(nbh);
 		memset(nbh->b_data, 0x00, inode->i_sb->s_blocksize);
-		mark_buffer_uptodate(nbh, 1);
+		set_buffer_uptodate(nbh);
 		unlock_buffer(nbh);
 		mark_buffer_dirty_inode(nbh, inode);
 
--- 2.5.9/fs/udf/namei.c~cleanup-070-bh_flags	Wed Apr 24 01:06:15 2002
+++ 2.5.9-akpm/fs/udf/namei.c	Wed Apr 24 01:06:15 2002
@@ -984,7 +984,7 @@ static int udf_symlink(struct inode * di
 		bh = udf_tread(inode->i_sb, block);
 		lock_buffer(bh);
 		memset(bh->b_data, 0x00, inode->i_sb->s_blocksize);
-		mark_buffer_uptodate(bh, 1);
+		set_buffer_uptodate(bh);
 		unlock_buffer(bh);
 		mark_buffer_dirty_inode(bh, inode);
 	}
--- 2.5.9/fs/ufs/balloc.c~cleanup-070-bh_flags	Wed Apr 24 01:06:15 2002
+++ 2.5.9-akpm/fs/ufs/balloc.c	Wed Apr 24 01:06:15 2002
@@ -225,7 +225,7 @@ failed:
 	for (i = oldcount; i < newcount; i++) { \
 		bh = sb_getblk(sb, result + i); \
 		memset (bh->b_data, 0, sb->s_blocksize); \
-		mark_buffer_uptodate(bh, 1); \
+		set_buffer_uptodate(bh); \
 		mark_buffer_dirty (bh); \
 		if (IS_SYNC(inode)) { \
 			ll_rw_block (WRITE, 1, &bh); \
@@ -360,7 +360,7 @@ unsigned ufs_new_fragments (struct inode
 			bh = sb_bread(sb, tmp + i);
 			if(bh)
 			{
-				mark_buffer_clean (bh);
+				clear_buffer_dirty(bh);
 				bh->b_blocknr = result + i;
 				mark_buffer_dirty (bh);
 				if (IS_SYNC(inode)) {
--- 2.5.9/fs/ufs/inode.c~cleanup-070-bh_flags	Wed Apr 24 01:06:15 2002
+++ 2.5.9-akpm/fs/ufs/inode.c	Wed Apr 24 01:38:54 2002
@@ -389,7 +389,7 @@ out:
 	if (err)
 		goto abort;
 	if (new)
-		bh_result->b_state |= (1UL << BH_New);
+		set_buffer_new(bh_result);
 	map_bh(bh_result, sb, phys);
 abort:
 	unlock_kernel();
@@ -419,7 +419,7 @@ struct buffer_head *ufs_getfrag(struct i
 		bh = sb_getblk(inode->i_sb, dummy.b_blocknr);
 		if (buffer_new(&dummy)) {
 			memset(bh->b_data, 0, inode->i_sb->s_blocksize);
-			mark_buffer_uptodate(bh, 1);
+			set_buffer_uptodate(bh);
 			mark_buffer_dirty(bh);
 		}
 		return bh;
--- 2.5.9/fs/ufs/util.c~cleanup-070-bh_flags	Wed Apr 24 01:06:15 2002
+++ 2.5.9-akpm/fs/ufs/util.c	Wed Apr 24 01:06:15 2002
@@ -109,8 +109,13 @@ void ubh_mark_buffer_uptodate (struct uf
 	unsigned i;
 	if (!ubh)
 		return;
-	for ( i = 0; i < ubh->count; i++ )
-		mark_buffer_uptodate (ubh->bh[i], flag);
+	if (flag) {
+		for ( i = 0; i < ubh->count; i++ )
+			set_buffer_uptodate (ubh->bh[i]);
+	} else {
+		for ( i = 0; i < ubh->count; i++ )
+			clear_buffer_uptodate (ubh->bh[i]);
+	}
 }
 
 void ubh_ll_rw_block (int rw, unsigned nr, struct ufs_buffer_head * ubh[])
--- 2.5.9/include/linux/amigaffs.h~cleanup-070-bh_flags	Wed Apr 24 01:06:15 2002
+++ 2.5.9-akpm/include/linux/amigaffs.h	Wed Apr 24 01:41:25 2002
@@ -50,7 +50,7 @@ affs_getzeroblk(struct super_block *sb, 
 		bh = sb_getblk(sb, block);
 		lock_buffer(bh);
 		memset(bh->b_data, 0 , sb->s_blocksize);
-		mark_buffer_uptodate(bh, 1);
+		set_buffer_uptodate(bh);
 		unlock_buffer(bh);
 		return bh;
 	}
@@ -64,7 +64,7 @@ affs_getemptyblk(struct super_block *sb,
 	if (block >= AFFS_SB(sb)->s_reserved && block < AFFS_SB(sb)->s_partition_size) {
 		bh = sb_getblk(sb, block);
 		wait_on_buffer(bh);
-		mark_buffer_uptodate(bh, 1);
+		set_buffer_uptodate(bh);
 		return bh;
 	}
 	return NULL;
--- 2.5.9/fs/reiserfs/tail_conversion.c~cleanup-070-bh_flags	Wed Apr 24 01:06:15 2002
+++ 2.5.9-akpm/fs/reiserfs/tail_conversion.c	Wed Apr 24 01:38:23 2002
@@ -141,11 +141,11 @@ void reiserfs_unmap_buffer(struct buffer
     if (buffer_journaled(bh) || buffer_journal_dirty(bh)) {
       BUG() ;
     }
-    mark_buffer_clean(bh) ;
+    clear_buffer_dirty(bh) ;
     lock_buffer(bh) ;
-    clear_bit(BH_Mapped, &bh->b_state) ;
-    clear_bit(BH_Req, &bh->b_state) ;
-    clear_bit(BH_New, &bh->b_state) ;
+    clear_buffer_mapped(bh) ;
+    clear_buffer_req(bh) ;
+    clear_buffer_new(bh);
     bh->b_bdev = NULL;
     unlock_buffer(bh) ;
   }
--- /dev/null	Thu Aug 30 13:30:55 2001
+++ 2.5.9-akpm/include/linux/buffer_head.h	Wed Apr 24 01:33:34 2002
@@ -0,0 +1,356 @@
+/*
+ * include/linux/buffer_head.h
+ *
+ * Everything to do with buffer_head.b_state.
+ */
+
+#ifndef BUFFER_FLAGS_H
+#define BUFFER_FLAGS_H
+
+/* bh state bits */
+enum bh_state_bits {
+	BH_Uptodate,	/* 1 if the buffer contains valid data */
+	BH_Dirty,	/* 1 if the buffer is dirty */
+	BH_Lock,	/* 1 if the buffer is locked */
+	BH_Req,		/* 0 if the buffer has been invalidated */
+
+	BH_Mapped,	/* 1 if the buffer has a disk mapping */
+	BH_New,		/* 1 if the buffer is new and not yet written out */
+	BH_Async,	/* 1 if the buffer is under end_buffer_io_async I/O */
+	BH_JBD,		/* 1 if it has an attached journal_head */
+
+	BH_PrivateStart,/* not a state bit, but the first bit available
+			 * for private allocation by other entities
+			 */
+};
+
+struct page;
+struct kiobuf;
+struct buffer_head;
+typedef void (bh_end_io_t)(struct buffer_head *bh, int uptodate);
+
+/*
+ * Try to keep the most commonly used fields in single cache lines (16
+ * bytes) to improve performance.  This ordering should be
+ * particularly beneficial on 32-bit processors.
+ * 
+ * We use the first 16 bytes for the data which is used in searches
+ * over the block hash lists (ie. getblk() and friends).
+ * 
+ * The second 16 bytes we use for lru buffer scans, as used by
+ * sync_buffers() and refill_freelist().  -- sct
+ */
+struct buffer_head {
+	/* First cache line: */
+	sector_t b_blocknr;		/* block number */
+	unsigned short b_size;		/* block size */
+	kdev_t b_dev;			/* device (B_FREE = free) */
+	struct block_device *b_bdev;
+
+	atomic_t b_count;		/* users using this block */
+	unsigned long b_state;		/* buffer state bitmap (see above) */
+	struct buffer_head *b_this_page;/* circular list of page's buffers */
+	struct page *b_page;		/* the page this bh is mapped to */
+
+	char * b_data;			/* pointer to data block */
+	bh_end_io_t *b_end_io;		/* I/O completion */
+ 	void *b_private;		/* reserved for b_end_io */
+
+	wait_queue_head_t b_wait;
+
+	struct list_head     b_inode_buffers; /* list of inode dirty buffers */
+};
+
+
+/*
+ * macro tricks to expand the set_buffer_foo(), clear_buffer_foo()
+ * and buffer_foo() functions.
+ */
+#define BUFFER_FNS(bit, name)						\
+static inline void set_buffer_##name(struct buffer_head *bh)		\
+{									\
+	set_bit(BH_##bit, &(bh)->b_state);				\
+}									\
+static inline void clear_buffer_##name(struct buffer_head *bh)		\
+{									\
+	clear_bit(BH_##bit, &(bh)->b_state);				\
+}									\
+static inline int buffer_##name(struct buffer_head *bh)			\
+{									\
+	return test_bit(BH_##bit, &(bh)->b_state);			\
+}
+
+/*
+ * test_set_buffer_foo() and test_clear_buffer_foo()
+ */
+#define TAS_BUFFER_FNS(bit, name)					\
+static inline int test_set_buffer_##name(struct buffer_head *bh)	\
+{									\
+	return test_and_set_bit(BH_##bit, &(bh)->b_state);		\
+}									\
+static inline int test_clear_buffer_##name(struct buffer_head *bh)	\
+{									\
+	return test_and_clear_bit(BH_##bit, &(bh)->b_state);		\
+}									\
+
+BUFFER_FNS(Uptodate, uptodate)
+BUFFER_FNS(Dirty, dirty)
+TAS_BUFFER_FNS(Dirty, dirty)
+BUFFER_FNS(Lock, locked)
+TAS_BUFFER_FNS(Lock, locked)
+BUFFER_FNS(Req, req)
+BUFFER_FNS(Mapped, mapped)
+BUFFER_FNS(New, new)
+BUFFER_FNS(Async, async)
+
+/*
+ * Utility macros
+ */
+
+/*
+ * FIXME: this is used only by bh_kmap, which is used only by RAID5.
+ * Clean this up with blockdev-in-highmem infrastructure.
+ */
+#define bh_offset(bh)		((unsigned long)(bh)->b_data & ~PAGE_MASK)
+
+#define touch_buffer(bh)	mark_page_accessed(bh->b_page)
+
+/* If we *know* page->private refers to buffer_heads */
+#define page_buffers(page)					\
+	({							\
+		if (!PagePrivate(page))				\
+			BUG();					\
+		((struct buffer_head *)(page)->private);	\
+	})
+#define page_has_buffers(page)	PagePrivate(page)
+#define set_page_buffers(page, buffers)				\
+	do {							\
+		SetPagePrivate(page);				\
+		page->private = (unsigned long)buffers;		\
+	} while (0)
+#define clear_page_buffers(page)				\
+	do {							\
+		ClearPagePrivate(page);				\
+		page->private = 0;				\
+	} while (0)
+
+#define invalidate_buffers(dev)	__invalidate_buffers((dev), 0)
+#define destroy_buffers(dev)	__invalidate_buffers((dev), 1)
+
+
+/*
+ * Declarations
+ */
+
+void FASTCALL(mark_buffer_dirty(struct buffer_head *bh));
+void buffer_init(void);
+void init_buffer(struct buffer_head *, bh_end_io_t *, void *);
+void set_bh_page(struct buffer_head *bh,
+		struct page *page, unsigned long offset);
+int try_to_free_buffers(struct page *);
+void create_empty_buffers(struct page *, unsigned long,
+			unsigned long b_state);
+void end_buffer_io_sync(struct buffer_head *bh, int uptodate);
+void buffer_insert_list(spinlock_t *lock,
+			struct buffer_head *, struct list_head *);
+
+
+/* reiserfs_writepage needs this */
+void set_buffer_async_io(struct buffer_head *bh) ;
+void invalidate_inode_buffers(struct inode *);
+void invalidate_bdev(struct block_device *, int);
+void __invalidate_buffers(kdev_t dev, int);
+int sync_buffers(struct block_device *, int);
+void __wait_on_buffer(struct buffer_head *);
+int fsync_dev(kdev_t);
+int fsync_bdev(struct block_device *);
+int fsync_super(struct super_block *);
+int fsync_no_super(struct block_device *);
+int fsync_buffers_list(spinlock_t *lock, struct list_head *);
+int inode_has_buffers(struct inode *);
+struct buffer_head *__get_hash_table(struct block_device *, sector_t, int);
+struct buffer_head * __getblk(struct block_device *, sector_t, int);
+void __brelse(struct buffer_head *);
+void __bforget(struct buffer_head *);
+struct buffer_head * __bread(struct block_device *, int, int);
+void wakeup_bdflush(void);
+struct buffer_head *alloc_buffer_head(int async);
+void free_buffer_head(struct buffer_head * bh);
+int brw_page(int, struct page *, struct block_device *, sector_t [], int);
+void FASTCALL(unlock_buffer(struct buffer_head *bh));
+
+/*
+ * Generic address_space_operations implementations for buffer_head-backed
+ * address_spaces.
+ */
+int try_to_release_page(struct page * page, int gfp_mask);
+int block_flushpage(struct page *page, unsigned long offset);
+int block_symlink(struct inode *, const char *, int);
+int block_write_full_page(struct page*, get_block_t*);
+int block_read_full_page(struct page*, get_block_t*);
+int block_prepare_write(struct page*, unsigned, unsigned, get_block_t*);
+int cont_prepare_write(struct page*, unsigned, unsigned, get_block_t*,
+				unsigned long *);
+int generic_cont_expand(struct inode *inode, loff_t size) ;
+int block_commit_write(struct page *page, unsigned from, unsigned to);
+int block_sync_page(struct page *);
+sector_t generic_block_bmap(struct address_space *, sector_t, get_block_t *);
+int generic_commit_write(struct file *, struct page *, unsigned, unsigned);
+int block_truncate_page(struct address_space *, loff_t, get_block_t *);
+int generic_direct_IO(int, struct inode *, struct kiobuf *,
+			unsigned long, int, get_block_t *);
+int file_fsync(struct file *, struct dentry *, int);
+
+#define OSYNC_METADATA	(1<<0)
+#define OSYNC_DATA	(1<<1)
+#define OSYNC_INODE	(1<<2)
+int generic_osync_inode(struct inode *, int);
+
+
+/*
+ * inline definitions
+ */
+
+static inline void get_bh(struct buffer_head * bh)
+{
+        atomic_inc(&(bh)->b_count);
+}
+
+static inline void put_bh(struct buffer_head *bh)
+{
+        smp_mb__before_atomic_dec();
+        atomic_dec(&bh->b_count);
+}
+
+static inline void
+mark_buffer_dirty_inode(struct buffer_head *bh, struct inode *inode)
+{
+	mark_buffer_dirty(bh);
+	buffer_insert_list(&inode->i_bufferlist_lock,
+			bh, &inode->i_dirty_buffers);
+}
+
+/*
+ * If an error happens during the make_request, this function
+ * has to be recalled. It marks the buffer as clean and not
+ * uptodate, and it notifys the upper layer about the end
+ * of the I/O.
+ */
+static inline void buffer_IO_error(struct buffer_head * bh)
+{
+	clear_buffer_dirty(bh);
+
+	/*
+	 * b_end_io has to clear the BH_Uptodate bitflag in the read error
+	 * case, however buffer contents are not necessarily bad if a
+	 * write fails
+	 */
+	bh->b_end_io(bh, buffer_uptodate(bh));
+}
+
+static inline int fsync_inode_buffers(struct inode *inode)
+{
+	return fsync_buffers_list(&inode->i_bufferlist_lock,
+				&inode->i_dirty_buffers);
+}
+
+static inline struct buffer_head *
+get_hash_table(kdev_t dev, sector_t block, int size)
+{
+	struct block_device *bdev;
+	struct buffer_head *bh;
+	bdev = bdget(kdev_t_to_nr(dev));
+	if (!bdev) {
+		printk("No block device for %s\n", bdevname(dev));
+		BUG();
+	}
+	bh = __get_hash_table(bdev, block, size);
+	atomic_dec(&bdev->bd_count);
+	return bh;
+}
+
+static inline struct buffer_head * getblk(kdev_t dev, sector_t block, int size)
+{
+	struct block_device *bdev;
+	struct buffer_head *bh;
+	bdev = bdget(kdev_t_to_nr(dev));
+	if (!bdev) {
+		printk("No block device for %s\n", bdevname(dev));
+		BUG();
+	}
+	bh = __getblk(bdev, block, size);
+	atomic_dec(&bdev->bd_count);
+	return bh;
+}
+
+static inline void brelse(struct buffer_head *buf)
+{
+	if (buf)
+		__brelse(buf);
+}
+
+static inline void bforget(struct buffer_head *buf)
+{
+	if (buf)
+		__bforget(buf);
+}
+
+static inline struct buffer_head *bread(kdev_t dev, int block, int size)
+{
+	struct block_device *bdev;
+	struct buffer_head *bh;
+	bdev = bdget(kdev_t_to_nr(dev));
+	if (!bdev) {
+		printk("No block device for %s\n", bdevname(dev));
+		BUG();
+	}
+	bh = __bread(bdev, block, size);
+	atomic_dec(&bdev->bd_count);
+	return bh;
+}
+
+static inline struct buffer_head * sb_bread(struct super_block *sb, int block)
+{
+	return __bread(sb->s_bdev, block, sb->s_blocksize);
+}
+
+static inline struct buffer_head * sb_getblk(struct super_block *sb, int block)
+{
+	return __getblk(sb->s_bdev, block, sb->s_blocksize);
+}
+
+static inline struct buffer_head *
+sb_get_hash_table(struct super_block *sb, int block)
+{
+	return __get_hash_table(sb->s_bdev, block, sb->s_blocksize);
+}
+
+static inline void
+map_bh(struct buffer_head *bh, struct super_block *sb, int block)
+{
+	set_buffer_mapped(bh);
+	bh->b_bdev = sb->s_bdev;
+	bh->b_dev = sb->s_dev;
+	bh->b_blocknr = block;
+}
+
+static inline void wait_on_buffer(struct buffer_head * bh)
+{
+	if (buffer_locked(bh))
+		__wait_on_buffer(bh);
+}
+
+static inline void lock_buffer(struct buffer_head * bh)
+{
+	while (test_set_buffer_locked(bh))
+		__wait_on_buffer(bh);
+}
+
+/*
+ * Debug
+ */
+
+void __buffer_error(char *file, int line);
+#define buffer_error() __buffer_error(__FILE__, __LINE__)
+
+#endif		/* BUFFER_FLAGS_H */
--- 2.5.9/include/linux/jbd.h~cleanup-070-bh_flags	Wed Apr 24 01:06:15 2002
+++ 2.5.9-akpm/include/linux/jbd.h	Wed Apr 24 01:42:04 2002
@@ -233,11 +233,8 @@ enum jbd_state_bits {
 	BH_JBDDirty,		/* 1 if buffer is dirty but journaled */
 };
 
-/* Return true if the buffer is one which JBD is managing */
-static inline int buffer_jbd(struct buffer_head *bh)
-{
-	return __buffer_state(bh, JBD);
-}
+BUFFER_FNS(JBD, jbd)
+BUFFER_FNS(JBDDirty, jbddirty)
 
 static inline struct buffer_head *jh2bh(struct journal_head *jh)
 {
@@ -838,7 +835,7 @@ static inline int buffer_jlist_eq(struct
 /* Return true if this bufer is dirty wrt the journal */
 static inline int buffer_jdirty(struct buffer_head *bh)
 {
-	return buffer_jbd(bh) && __buffer_state(bh, JBDDirty);
+	return buffer_jbd(bh) && buffer_jbddirty(bh);
 }
 
 /* Return true if it's a data buffer which journalling is managing */
--- 2.5.9/include/linux/locks.h~cleanup-070-bh_flags	Wed Apr 24 01:14:17 2002
+++ 2.5.9-akpm/include/linux/locks.h	Wed Apr 24 01:39:42 2002
@@ -9,26 +9,6 @@
 #endif
 
 /*
- * Buffer cache locking - note that interrupts may only unlock, not
- * lock buffers.
- */
-extern void __wait_on_buffer(struct buffer_head *);
-
-static inline void wait_on_buffer(struct buffer_head * bh)
-{
-	if (test_bit(BH_Lock, &bh->b_state))
-		__wait_on_buffer(bh);
-}
-
-static inline void lock_buffer(struct buffer_head * bh)
-{
-	while (test_and_set_bit(BH_Lock, &bh->b_state))
-		__wait_on_buffer(bh);
-}
-
-extern void FASTCALL(unlock_buffer(struct buffer_head *bh));
-
-/*
  * super-block locking. Again, interrupts may only unlock
  * a super-block (although even this isn't done right now.
  * nfs may need it).
--- 2.5.9/mm/page-writeback.c~cleanup-070-bh_flags	Wed Apr 24 01:25:37 2002
+++ 2.5.9-akpm/mm/page-writeback.c	Wed Apr 24 01:28:57 2002
@@ -466,7 +466,7 @@ int __set_page_dirty_buffers(struct page
 
 		do {
 			if (buffer_uptodate(bh))
-				set_bit(BH_Dirty, &bh->b_state);
+				set_buffer_dirty(bh);
 			bh = bh->b_this_page;
 		} while (bh != head);
 	}
--- 2.5.9/fs/affs/file.c~cleanup-070-bh_flags	Wed Apr 24 01:30:46 2002
+++ 2.5.9-akpm/fs/affs/file.c	Wed Apr 24 01:34:47 2002
@@ -361,7 +361,7 @@ affs_get_block(struct inode *inode, sect
 		u32 blocknr = affs_alloc_block(inode, ext_bh->b_blocknr);
 		if (!blocknr)
 			goto err_alloc;
-		bh_result->b_state |= (1UL << BH_New);
+		set_buffer_new(bh_result);
 		AFFS_I(inode)->mmu_private += AFFS_SB(sb)->s_data_blksize;
 		AFFS_I(inode)->i_blkcnt++;
 
@@ -400,7 +400,7 @@ err_ext:
 	return PTR_ERR(ext_bh);
 err_alloc:
 	brelse(ext_bh);
-	bh_result->b_state &= ~(1UL << BH_Mapped);
+	clear_buffer_mapped(bh_result);
 	bh_result->b_bdev = NULL;
 	// unlock cache
 	affs_unlock_ext(inode);
@@ -701,7 +701,7 @@ static int affs_commit_write_ofs(struct 
 		if (IS_ERR(bh))
 			goto out;
 		memcpy(AFFS_DATA(bh), data + from, bsize);
-		if (bh->b_state & (1UL << BH_New)) {
+		if (buffer_new(bh)) {
 			AFFS_DATA_HEAD(bh)->ptype = cpu_to_be32(T_DATA);
 			AFFS_DATA_HEAD(bh)->key = cpu_to_be32(inode->i_ino);
 			AFFS_DATA_HEAD(bh)->sequence = cpu_to_be32(bidx);
@@ -730,7 +730,7 @@ static int affs_commit_write_ofs(struct 
 			goto out;
 		tmp = min(bsize, to - from);
 		memcpy(AFFS_DATA(bh), data + from, tmp);
-		if (bh->b_state & (1UL << BH_New)) {
+		if (buffer_new(bh)) {
 			AFFS_DATA_HEAD(bh)->ptype = cpu_to_be32(T_DATA);
 			AFFS_DATA_HEAD(bh)->key = cpu_to_be32(inode->i_ino);
 			AFFS_DATA_HEAD(bh)->sequence = cpu_to_be32(bidx);
--- 2.5.9/fs/block_dev.c~cleanup-070-bh_flags	Wed Apr 24 01:30:46 2002
+++ 2.5.9-akpm/fs/block_dev.c	Wed Apr 24 01:31:30 2002
@@ -120,7 +120,7 @@ static int blkdev_get_block(struct inode
 	bh->b_dev = inode->i_rdev;
 	bh->b_bdev = inode->i_bdev;
 	bh->b_blocknr = iblock;
-	bh->b_state |= 1UL << BH_Mapped;
+	set_buffer_mapped(bh);
 	return 0;
 }
 
--- 2.5.9/fs/fat/file.c~cleanup-070-bh_flags	Wed Apr 24 01:33:52 2002
+++ 2.5.9-akpm/fs/fat/file.c	Wed Apr 24 01:36:22 2002
@@ -67,7 +67,7 @@ int fat_get_block(struct inode *inode, s
 	phys = fat_bmap(inode, iblock);
 	if (!phys)
 		BUG();
-	bh_result->b_state |= (1UL << BH_New);
+	set_buffer_new(bh_result);
 	map_bh(bh_result, inode->i_sb, phys);
 	return 0;
 }
--- 2.5.9/fs/hpfs/file.c~cleanup-070-bh_flags	Wed Apr 24 01:33:52 2002
+++ 2.5.9-akpm/fs/hpfs/file.c	Wed Apr 24 01:36:45 2002
@@ -91,7 +91,7 @@ int hpfs_get_block(struct inode *inode, 
 	}
 	inode->i_blocks++;
 	hpfs_i(inode)->mmu_private += 512;
-	bh_result->b_state |= 1UL << BH_New;
+	set_buffer_new(bh_result);
 	map_bh(bh_result, inode->i_sb, s);
 	return 0;
 }
--- 2.5.9/fs/jfs/jfs_metapage.c~cleanup-070-bh_flags	Wed Apr 24 01:33:52 2002
+++ 2.5.9-akpm/fs/jfs/jfs_metapage.c	Wed Apr 24 01:37:09 2002
@@ -267,7 +267,7 @@ static int direct_get_block(struct inode
 			    struct buffer_head *bh_result, int create)
 {
 	if (create)
-		bh_result->b_state |= (1UL << BH_New);
+		set_buffer_new(bh_result);
 
 	map_bh(bh_result, ip->i_sb, lblock);
 
--- 2.5.9/fs/jfs/inode.c~cleanup-070-bh_flags	Wed Apr 24 01:33:52 2002
+++ 2.5.9-akpm/fs/jfs/inode.c	Wed Apr 24 01:37:36 2002
@@ -229,7 +229,7 @@ static int jfs_get_block(struct inode *i
 			rc = extRecord(ip, &xad);
 			if (rc)
 				goto unlock;
-			bh_result->b_state |= (1UL << BH_New);
+			set_buffer_new(bh_result);
 		}
 
 		map_bh(bh_result, ip->i_sb, xaddr);
@@ -249,7 +249,7 @@ static int jfs_get_block(struct inode *i
 	if (rc)
 		goto unlock;
 
-	bh_result->b_state |= (1UL << BH_New);
+	set_buffer_new(bh_result);
 	map_bh(bh_result, ip->i_sb, addressXAD(&xad));
 
 #else				/* _JFS_4K */
