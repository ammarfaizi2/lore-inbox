Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315101AbSESTkK>; Sun, 19 May 2002 15:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315050AbSESTiy>; Sun, 19 May 2002 15:38:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11268 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315096AbSESThh>;
	Sun, 19 May 2002 15:37:37 -0400
Message-ID: <3CE7FFD9.AAFE2D47@zip.com.au>
Date: Sun, 19 May 2002 12:41:13 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 8/15] pdflush exclusion infrastructure
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Collision avoidance for pdflush threads.

Turns the request_queue-based `unsigned long ra_pages' into a structure
which contains ra_pages as well as a longword.

That longword is used to record the fact that a pdflush thread is
currently writing something back against this request_queue.

Avoids the situation where several pdflush threads are sleeping on the
same request_queue.  

This patch provides only the infrastructure for the pdflush exclusion.
This infrastructure gets used in pdflush-single.patch

=====================================

--- 2.5.16/drivers/block/blkpg.c~pdflush-exclusion	Sun May 19 11:49:48 2002
+++ 2.5.16-akpm/drivers/block/blkpg.c	Sun May 19 11:49:48 2002
@@ -35,6 +35,7 @@
 #include <linux/blkpg.h>
 #include <linux/genhd.h>
 #include <linux/module.h>               /* for EXPORT_SYMBOL */
+#include <linux/backing-dev.h>
 
 #include <asm/uaccess.h>
 
@@ -219,7 +220,7 @@ int blk_ioctl(struct block_device *bdev,
 	unsigned short usval;
 	kdev_t dev = to_kdev_t(bdev->bd_dev);
 	int holder;
-	unsigned long *ra_pages;
+	struct backing_dev_info *bdi;
 
 	intval = block_ioctl(bdev, cmd, arg);
 	if (intval != -ENOTTY)
@@ -241,20 +242,20 @@ int blk_ioctl(struct block_device *bdev,
 		case BLKFRASET:
 			if(!capable(CAP_SYS_ADMIN))
 				return -EACCES;
-			ra_pages = blk_get_ra_pages(bdev);
-			if (ra_pages == NULL)
+			bdi = blk_get_backing_dev_info(bdev);
+			if (bdi == NULL)
 				return -ENOTTY;
-			*ra_pages = (arg * 512) / PAGE_CACHE_SIZE;
+			bdi->ra_pages = (arg * 512) / PAGE_CACHE_SIZE;
 			return 0;
 
 		case BLKRAGET:
 		case BLKFRAGET:
 			if (!arg)
 				return -EINVAL;
-			ra_pages = blk_get_ra_pages(bdev);
-			if (ra_pages == NULL)
+			bdi = blk_get_backing_dev_info(bdev);
+			if (bdi == NULL)
 				return -ENOTTY;
-			return put_user((*ra_pages * PAGE_CACHE_SIZE) / 512,
+			return put_user((bdi->ra_pages * PAGE_CACHE_SIZE) / 512,
 						(long *)arg);
 
 		case BLKSECTGET:
--- 2.5.16/drivers/block/ll_rw_blk.c~pdflush-exclusion	Sun May 19 11:49:48 2002
+++ 2.5.16-akpm/drivers/block/ll_rw_blk.c	Sun May 19 11:49:48 2002
@@ -27,6 +27,7 @@
 #include <linux/completion.h>
 #include <linux/compiler.h>
 #include <scsi/scsi.h>
+#include <linux/backing-dev.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
@@ -100,21 +101,21 @@ inline request_queue_t *blk_get_queue(kd
 }
 
 /**
- * blk_get_ra_pages - get the address of a queue's readahead tunable
+ * blk_get_backing_dev_info - get the address of a queue's backing_dev_info
  * @dev:	device
  *
  * Locates the passed device's request queue and returns the address of its
- * readahead setting.
+ * backing_dev_info
  *
  * Will return NULL if the request queue cannot be located.
  */
-unsigned long *blk_get_ra_pages(struct block_device *bdev)
+struct backing_dev_info *blk_get_backing_dev_info(struct block_device *bdev)
 {
-	unsigned long *ret = NULL;
+	struct backing_dev_info *ret = NULL;
 	request_queue_t *q = blk_get_queue(to_kdev_t(bdev->bd_dev));
 
 	if (q)
-		ret = &q->ra_pages;
+		ret = &q->backing_dev_info;
 	return ret;
 }
 
@@ -153,7 +154,8 @@ void blk_queue_make_request(request_queu
 	q->max_phys_segments = MAX_PHYS_SEGMENTS;
 	q->max_hw_segments = MAX_HW_SEGMENTS;
 	q->make_request_fn = mfn;
-	q->ra_pages = (VM_MAX_READAHEAD * 1024) / PAGE_CACHE_SIZE;
+	q->backing_dev_info.ra_pages = (VM_MAX_READAHEAD * 1024) / PAGE_CACHE_SIZE;
+	q->backing_dev_info.state = 0;
 	blk_queue_max_sectors(q, MAX_SECTORS);
 	blk_queue_hardsect_size(q, 512);
 
--- 2.5.16/fs/block_dev.c~pdflush-exclusion	Sun May 19 11:49:48 2002
+++ 2.5.16-akpm/fs/block_dev.c	Sun May 19 11:49:48 2002
@@ -331,7 +331,7 @@ struct block_device *bdget(dev_t dev)
 			inode->i_bdev = new_bdev;
 			inode->i_data.a_ops = &def_blk_aops;
 			inode->i_data.gfp_mask = GFP_USER;
-			inode->i_data.ra_pages = &default_ra_pages;
+			inode->i_data.backing_dev_info = &default_backing_dev_info;
 			spin_lock(&bdev_lock);
 			bdev = bdfind(dev, head);
 			if (!bdev) {
@@ -594,11 +594,12 @@ static int do_open(struct block_device *
 			}
 		}
 	}
-	if (bdev->bd_inode->i_data.ra_pages == &default_ra_pages) {
-		unsigned long *ra_pages = blk_get_ra_pages(bdev);
-		if (ra_pages == NULL)
-			ra_pages = &default_ra_pages;
-		inode->i_data.ra_pages = ra_pages;
+	if (bdev->bd_inode->i_data.backing_dev_info ==
+				&default_backing_dev_info) {
+		struct backing_dev_info *bdi = blk_get_backing_dev_info(bdev);
+		if (bdi == NULL)
+			bdi = &default_backing_dev_info;
+		inode->i_data.backing_dev_info = bdi;
 	}
 	if (bdev->bd_op->open) {
 		ret = bdev->bd_op->open(inode, file);
@@ -624,7 +625,7 @@ static int do_open(struct block_device *
 out2:
 	if (!bdev->bd_openers) {
 		bdev->bd_op = NULL;
-		bdev->bd_inode->i_data.ra_pages = &default_ra_pages;
+		bdev->bd_inode->i_data.backing_dev_info = &default_backing_dev_info;
 		if (bdev != bdev->bd_contains) {
 			blkdev_put(bdev->bd_contains, BDEV_RAW);
 			bdev->bd_contains = NULL;
@@ -698,7 +699,7 @@ int blkdev_put(struct block_device *bdev
 		__MOD_DEC_USE_COUNT(bdev->bd_op->owner);
 	if (!bdev->bd_openers) {
 		bdev->bd_op = NULL;
-		bdev->bd_inode->i_data.ra_pages = &default_ra_pages;
+		bdev->bd_inode->i_data.backing_dev_info = &default_backing_dev_info;
 		if (bdev != bdev->bd_contains) {
 			blkdev_put(bdev->bd_contains, BDEV_RAW);
 			bdev->bd_contains = NULL;
--- 2.5.16/fs/inode.c~pdflush-exclusion	Sun May 19 11:49:48 2002
+++ 2.5.16-akpm/fs/inode.c	Sun May 19 12:02:58 2002
@@ -12,6 +12,7 @@
 #include <linux/quotaops.h>
 #include <linux/slab.h>
 #include <linux/writeback.h>
+#include <linux/backing-dev.h>
 
 /*
  * New inode.c implementation.
@@ -83,6 +84,8 @@ static struct inode *alloc_inode(struct 
 		inode = (struct inode *) kmem_cache_alloc(inode_cachep, SLAB_KERNEL);
 
 	if (inode) {
+		struct address_space * const mapping = &inode->i_data;
+
 		inode->i_sb = sb;
 		inode->i_dev = sb->s_dev;
 		inode->i_blkbits = sb->s_blocksize_bits;
@@ -100,16 +103,17 @@ static struct inode *alloc_inode(struct 
 		inode->i_pipe = NULL;
 		inode->i_bdev = NULL;
 		inode->i_cdev = NULL;
-		inode->i_data.a_ops = &empty_aops;
-		inode->i_data.host = inode;
-		inode->i_data.gfp_mask = GFP_HIGHUSER;
-		inode->i_data.dirtied_when = 0;
-		inode->i_mapping = &inode->i_data;
-		inode->i_data.ra_pages = &default_ra_pages;
-		inode->i_data.assoc_mapping = NULL;
+
+		mapping->a_ops = &empty_aops;
+ 		mapping->host = inode;
+		mapping->gfp_mask = GFP_HIGHUSER;
+		mapping->dirtied_when = 0;
+		mapping->assoc_mapping = NULL;
+		mapping->backing_dev_info = &default_backing_dev_info;
 		if (sb->s_bdev)
-			inode->i_data.ra_pages = sb->s_bdev->bd_inode->i_mapping->ra_pages;
+			inode->i_data.backing_dev_info = sb->s_bdev->bd_inode->i_mapping->backing_dev_info;
 		memset(&inode->u, 0, sizeof(inode->u));
+		inode->i_mapping = mapping;
 	}
 	return inode;
 }
--- 2.5.16/fs/open.c~pdflush-exclusion	Sun May 19 11:49:48 2002
+++ 2.5.16-akpm/fs/open.c	Sun May 19 11:49:48 2002
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/tty.h>
 #include <linux/iobuf.h>
+#include <linux/backing-dev.h>
 
 #include <asm/uaccess.h>
 
@@ -632,7 +633,7 @@ struct file *dentry_open(struct dentry *
 			goto cleanup_file;
 	}
 
-	f->f_ra.ra_pages = *inode->i_mapping->ra_pages;
+	f->f_ra.ra_pages = inode->i_mapping->backing_dev_info->ra_pages;
 	f->f_dentry = dentry;
 	f->f_vfsmnt = mnt;
 	f->f_pos = 0;
--- 2.5.16/fs/ntfs/super.c~pdflush-exclusion	Sun May 19 11:49:48 2002
+++ 2.5.16-akpm/fs/ntfs/super.c	Sun May 19 11:49:48 2002
@@ -26,6 +26,7 @@
 #include <linux/locks.h>
 #include <linux/spinlock.h>
 #include <linux/blkdev.h>	/* For bdev_hardsect_size(). */
+#include <linux/backing-dev.h>
 
 #include "ntfs.h"
 #include "sysctl.h"
@@ -1519,8 +1520,8 @@ static int ntfs_fill_super(struct super_
 	vol->mftbmp_mapping.assoc_mapping = NULL;
 	vol->mftbmp_mapping.dirtied_when = 0;
 	vol->mftbmp_mapping.gfp_mask = GFP_HIGHUSER;
-	vol->mftbmp_mapping.ra_pages =
-			sb->s_bdev->bd_inode->i_mapping->ra_pages;
+	vol->mftbmp_mapping.backing_dev_info =
+			sb->s_bdev->bd_inode->i_mapping->backing_dev_info;
 
 	/*
 	 * Default is group and other don't have any access to files or
--- 2.5.16/include/linux/blkdev.h~pdflush-exclusion	Sun May 19 11:49:48 2002
+++ 2.5.16-akpm/include/linux/blkdev.h	Sun May 19 11:52:27 2002
@@ -7,6 +7,7 @@
 #include <linux/tqueue.h>
 #include <linux/list.h>
 #include <linux/pagemap.h>
+#include <linux/backing-dev.h>
 
 #include <asm/scatterlist.h>
 
@@ -162,11 +163,7 @@ struct request_queue
 	make_request_fn		*make_request_fn;
 	prep_rq_fn		*prep_rq_fn;
 
-	/*
-	 * The VM-level readahead tunable for this device.  In
-	 * units of PAGE_CACHE_SIZE pages.
-	 */
-	unsigned long ra_pages;
+	struct backing_dev_info	backing_dev_info;
 
 	/*
 	 * The queue owner gets to use this for whatever they like.
@@ -328,7 +325,7 @@ extern void blk_queue_hardsect_size(requ
 extern void blk_queue_segment_boundary(request_queue_t *q, unsigned long);
 extern void blk_queue_assign_lock(request_queue_t *q, spinlock_t *);
 extern void blk_queue_prep_rq(request_queue_t *q, prep_rq_fn *pfn);
-extern unsigned long *blk_get_ra_pages(struct block_device *bdev);
+extern struct backing_dev_info *blk_get_backing_dev_info(struct block_device *bdev);
 
 extern int blk_rq_map_sg(request_queue_t *, struct request *, struct scatterlist *);
 extern void blk_dump_rq_flags(struct request *, char *);
--- 2.5.16/include/linux/fs.h~pdflush-exclusion	Sun May 19 11:49:48 2002
+++ 2.5.16-akpm/include/linux/fs.h	Sun May 19 12:02:58 2002
@@ -305,6 +305,7 @@ struct address_space_operations {
 	int (*direct_IO)(int, struct inode *, struct kiobuf *, unsigned long, int);
 };
 
+struct backing_dev_info;
 struct address_space {
 	struct inode		*host;		/* owner: inode, block_device */
 	struct radix_tree_root	page_tree;	/* radix tree of all pages */
@@ -320,7 +321,7 @@ struct address_space {
 	spinlock_t		i_shared_lock;  /* and spinlock protecting it */
 	unsigned long		dirtied_when;	/* jiffies of first page dirtying */
 	int			gfp_mask;	/* how to allocate the pages */
-	unsigned long 		*ra_pages;	/* device readahead */
+	struct backing_dev_info *backing_dev_info; /* device readahead, etc */
 	spinlock_t		private_lock;	/* for use by the address_space */
 	struct list_head	private_list;	/* ditto */
 	struct address_space	*assoc_mapping;	/* ditto */
--- 2.5.16/include/linux/mm.h~pdflush-exclusion	Sun May 19 11:49:48 2002
+++ 2.5.16-akpm/include/linux/mm.h	Sun May 19 11:52:27 2002
@@ -454,7 +454,6 @@ void do_page_cache_readahead(struct file
 void page_cache_readahead(struct file *file, unsigned long offset);
 void page_cache_readaround(struct file *file, unsigned long offset);
 void handle_ra_thrashing(struct file *file);
-extern unsigned long default_ra_pages;
 
 /* vma is the first one with  address < vma->vm_end,
  * and even  address < vma->vm_start. Have to extend vma. */
--- 2.5.16/mm/readahead.c~pdflush-exclusion	Sun May 19 11:49:48 2002
+++ 2.5.16-akpm/mm/readahead.c	Sun May 19 11:49:48 2002
@@ -11,8 +11,12 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/blkdev.h>
+#include <linux/backing-dev.h>
 
-unsigned long default_ra_pages = (VM_MAX_READAHEAD * 1024) / PAGE_CACHE_SIZE;
+struct backing_dev_info default_backing_dev_info = {
+	ra_pages:	(VM_MAX_READAHEAD * 1024) / PAGE_CACHE_SIZE,
+	state:		0,
+};
 
 /*
  * Return max readahead size for this inode in number-of-pages.
--- /dev/null	Thu Aug 30 13:30:55 2001
+++ 2.5.16-akpm/include/linux/backing-dev.h	Sun May 19 11:49:48 2002
@@ -0,0 +1,30 @@
+/*
+ * include/linux/backing-dev.h
+ *
+ * low-level device information and state which is propagated up through
+ * to high-level code.
+ */
+
+#ifndef _LINUX_BACKING_DEV_H
+#define _LINUX_BACKING_DEV_H
+
+/*
+ * Bits in backing_dev_info.state
+ */
+enum bdi_state {
+	BDI_pdflush,		/* A pdflush thread is working this device */
+	BDI_unused,		/* Available bits start here */
+};
+
+struct backing_dev_info {
+	unsigned long ra_pages;	/* max readahead in PAGE_CACHE_SIZE units */
+	unsigned long state;	/* Always use atomic bitops on this */
+};
+
+extern struct backing_dev_info default_backing_dev_info;
+
+int writeback_acquire(struct backing_dev_info *bdi);
+int writeback_in_progress(struct backing_dev_info *bdi);
+void writeback_release(struct backing_dev_info *bdi);
+
+#endif		/* _LINUX_BACKING_DEV_H */
--- 2.5.16/fs/fs-writeback.c~pdflush-exclusion	Sun May 19 11:49:48 2002
+++ 2.5.16-akpm/fs/fs-writeback.c	Sun May 19 12:02:58 2002
@@ -19,6 +19,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/writeback.h>
+#include <linux/backing-dev.h>
 
 /**
  *	__mark_inode_dirty -	internal function
@@ -508,3 +509,40 @@ int generic_osync_inode(struct inode *in
 
 	return err;
 }
+
+/**
+ * writeback_acquire: attempt to get exclusive writeback access to a device
+ * @bdi: the device's backing_dev_info structure
+ *
+ * It is a waste of resources to have more than one pdflush thread blocked on
+ * a single request queue.  Exclusion at the request_queue level is obtained
+ * via a flag in the request_queue's backing_dev_info.state.
+ *
+ * Non-request_queue-backed address_spaces will share default_backing_dev_info,
+ * unless they implement their own.  Which is somewhat inefficient, as this
+ * may prevent concurrent writeback against multiple devices.
+ */
+int writeback_acquire(struct backing_dev_info *bdi)
+{
+	return !test_and_set_bit(BDI_pdflush, &bdi->state);
+}
+
+/**
+ * writeback_in_progress: determine whether there is writeback in progress
+ *                        against a backing device.
+ * @bdi: the device's backing_dev_info structure.
+ */
+int writeback_in_progress(struct backing_dev_info *bdi)
+{
+	return test_bit(BDI_pdflush, &bdi->state);
+}
+
+/**
+ * writeback_release: relinquish exclusive writeback access against a device.
+ * @bdi: the device's backing_dev_info structure
+ */
+void writeback_release(struct backing_dev_info *bdi)
+{
+	BUG_ON(!writeback_in_progress(bdi));
+	clear_bit(BDI_pdflush, &bdi->state);
+}
--- 2.5.16/mm/page-writeback.c~pdflush-exclusion	Sun May 19 11:49:48 2002
+++ 2.5.16-akpm/mm/page-writeback.c	Sun May 19 12:02:58 2002
@@ -166,6 +166,7 @@ int pdflush_flush(unsigned long nr_pages
  * to perform their I/O against a large file.
  */
 static int wb_writeback_jifs = 5 * HZ;
+static struct timer_list wb_timer;
 
 /*
  * Periodic writeback of "old" data.
@@ -206,16 +207,11 @@ static void wb_kupdate(unsigned long arg
 		yield();
 	}
 	run_task_queue(&tq_disk);
+	mod_timer(&wb_timer, jiffies + wb_writeback_jifs);
 }
 
-/*
- * The writeback timer, for kupdate-style functionality
- */
-static struct timer_list wb_timer;
-
 static void wb_timer_fn(unsigned long unused)
 {
-	mod_timer(&wb_timer, jiffies + wb_writeback_jifs);
 	pdflush_operation(wb_kupdate, 0);
 }
 
--- 2.5.16/mm/pdflush.c~pdflush-exclusion	Sun May 19 11:49:48 2002
+++ 2.5.16-akpm/mm/pdflush.c	Sun May 19 11:49:48 2002
@@ -103,6 +103,7 @@ static int __pdflush(struct pdflush_work
 	preempt_disable();
 	spin_lock_irq(&pdflush_lock);
 	nr_pdflush_threads++;
+//	printk("pdflush %d [%d] starts\n", nr_pdflush_threads, current->pid);
 	for ( ; ; ) {
 		struct pdflush_work *pdf;
 
@@ -124,7 +125,7 @@ static int __pdflush(struct pdflush_work
 		if (jiffies - last_empty_jifs > 1 * HZ) {
 			/* unlocked list_empty() test is OK here */
 			if (list_empty(&pdflush_list)) {
-				/* unlocked nr_pdflush_threads test is OK here */
+				/* unlocked test is OK here */
 				if (nr_pdflush_threads < MAX_PDFLUSH_THREADS)
 					start_one_pdflush_thread();
 			}
@@ -147,6 +148,7 @@ static int __pdflush(struct pdflush_work
 		}
 	}
 	nr_pdflush_threads--;
+//	printk("pdflush %d [%d] ends\n", nr_pdflush_threads, current->pid);
 	spin_unlock_irq(&pdflush_lock);
 	preempt_enable();
 	return 0;


-
