Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291048AbSBGB2W>; Wed, 6 Feb 2002 20:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291049AbSBGB2M>; Wed, 6 Feb 2002 20:28:12 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:12764 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S291048AbSBGB0u>; Wed, 6 Feb 2002 20:26:50 -0500
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200202070126.g171Qch27063@eng2.beaverton.ibm.com>
Subject: [RFC][PATCH] RAW & O_DIRECT improvements for 2.5.3pre6
To: linux-kernel@vger.kernel.org
Date: Wed, 6 Feb 2002 17:26:38 -0800 (PST)
Cc: pbadari@us.ibm.com, axboe@suse.de, andrea@suse.de
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a patch for 2.5.3pre6 to make RAW and O_DIRECT use "bio"
more efficiently. Idea is to simply eliminate intermediate "kiobuf".
I used some of the infrastructure from Ben's AIO patch (2.4.18).
Since Ben's patch is for 2.4, I had to rewrite some of it to suit
2.5 BIO design.

Description:
============

Added kvec (memory container), kvec_cb (control block for kvec IO).

Added support routines for kvec: map_user_kvec(), unmap_kvec(), 
alloc_kvec(), free_kvec() etc..

Use veclets from kvec directly as bio_vecs for "bio" to do the IO.

Issues:
=======

generic_direct_IO() uses stack to build a extent list <block#, size>
of discontiguous disk blocks and passes it to brw_kvec(). Need to
find a better way to do it. 

I am restructuring the code so that, I can push down one extent at a time 
and wait for completion at higher level. One problem with this approach
is kvec_cb (control block) need to have info on the last veclet where
we did IO. 

Any ideas ?

Things to follow:
=================

1) generic_direct_IO() cleanup.

2) I have not removed f_iobuf from filp. Need to do some kiobuf cleanup.

3) Add support for readv/writev for RAW.

Any comments on approach/code are welcome. I can make 2.5.4-preX patch
if the approach is acceptable.

Thanks,
Badari


diff -Naur -X dontdiff linux-2.5.3pre6.org/drivers/char/raw.c linux-2.5.3pre6/drivers/char/raw.c
--- linux-2.5.3pre6.org/drivers/char/raw.c	Tue Jan  1 11:40:34 2002
+++ linux-2.5.3pre6/drivers/char/raw.c	Mon Feb  4 20:36:39 2002
@@ -85,12 +85,6 @@
 		return 0;
 	}
 	
-	if (!filp->f_iobuf) {
-		err = alloc_kiovec(1, &filp->f_iobuf);
-		if (err)
-			return err;
-	}
-
 	down(&raw_devices[minor].mutex);
 	/*
 	 * No, it is a normal raw device.  All we need to do on open is
@@ -255,8 +249,7 @@
 ssize_t	rw_raw_dev(int rw, struct file *filp, char *buf, 
 		   size_t size, loff_t *offp)
 {
-	struct kiobuf * iobuf;
-	int		new_iobuf;
+	struct kvec 	*vec;
 	int		err = 0;
 	unsigned long	blocks;
 	size_t		transferred;
@@ -273,17 +266,11 @@
 
 	minor = minor(filp->f_dentry->d_inode->i_rdev);
 
-	new_iobuf = 0;
-	iobuf = filp->f_iobuf;
-	if (test_and_set_bit(0, &filp->f_iobuf_lock)) {
-		/*
-		 * A parallel read/write is using the preallocated iobuf
-		 * so just run slow and allocate a new one.
-		 */
-		err = alloc_kiovec(1, &iobuf);
-		if (err)
-			goto out;
-		new_iobuf = 1;
+
+	vec = alloc_kvec((size/PAGE_SIZE) + 1);
+	if (!vec) {
+		err = -ENOMEM;
+		goto out;
 	}
 
 	dev = to_kdev_t(raw_devices[minor].binding->bd_dev);
@@ -318,14 +305,14 @@
 
 		iosize = blocks << sector_bits;
 
-		err = map_user_kiobuf(rw, iobuf, (unsigned long) buf, iosize);
+		err = map_user_kvec(rw, vec, (unsigned long) buf, iosize);
 		if (err)
 			break;
 
-		err = brw_kiovec(rw, 1, &iobuf, dev, &blocknr, sector_size);
+		err = brw_kvec(rw, 1, vec, dev, &blocknr, &iosize, sector_size);
 
 		if (rw == READ && err > 0)
-			mark_dirty_kiobuf(iobuf, err);
+			mark_dirty_kvec(vec, err);
 		
 		if (err >= 0) {
 			transferred += err;
@@ -335,7 +322,7 @@
 
 		blocknr += blocks;
 
-		unmap_kiobuf(iobuf);
+		unmap_kvec(vec);
 
 		if (err != iosize)
 			break;
@@ -346,11 +333,8 @@
 		err = transferred;
 	}
 
- out_free:
-	if (!new_iobuf)
-		clear_bit(0, &filp->f_iobuf_lock);
-	else
-		free_kiovec(1, &iobuf);
- out:	
+out_free:	
+	free_kvec(vec);
+out:
 	return err;
 }
diff -Naur -X dontdiff linux-2.5.3pre6.org/fs/bio.c linux-2.5.3pre6/fs/bio.c
--- linux-2.5.3pre6.org/fs/bio.c	Thu Dec 27 08:15:15 2001
+++ linux-2.5.3pre6/fs/bio.c	Wed Feb  6 21:17:14 2002
@@ -495,6 +495,98 @@
 	return 0;
 }
 
+static int bio_end_io_kvec(struct bio *bio, int nr_sectors)
+{
+	struct kvec_cb *kvec_cb = (struct kvec_cb *) bio->bi_private;
+
+	end_kvec_request(kvec_cb, test_bit(BIO_UPTODATE, &bio->bi_flags));
+	bio_put(bio);
+	return 0;
+}
+
+int ll_rw_kvec(int rw, struct kvec_cb *vec_cb, kdev_t dev, int nr, sector_t b[], int len[])
+{
+	int i, err, tlen, blen, total;
+	struct kvec *vec = vec_cb->vec;
+	struct bio *bio;
+	kveclet_t *veclet;
+	int	sector;
+
+	err = 0;
+	total = 0;
+
+	if ((rw & WRITE) && is_read_only(dev)) {
+		printk("ll_rw_kvec: WRITE to ro device %s\n", kdevname(dev));
+		err = -EPERM;
+		goto out;
+	}
+
+	if (!vec->nr) {
+		err = -EINVAL;
+		goto out;
+	}
+
+
+	atomic_set(&vec_cb->io_count, 1);
+	veclet = vec->veclet;
+
+	for (i = 0; i < nr; i++) {
+		tlen = len[i];
+		sector = b[i];
+
+		while (tlen) {
+
+			blen = 0;
+
+			/*
+			 * allocate bio and do initial setup
+			 */
+			if ((bio = bio_alloc(GFP_NOIO, 0)) == NULL) {
+				err = -ENOMEM;
+				goto out;
+			}
+			atomic_inc(&vec_cb->io_count);
+
+			bio->bi_sector = sector;
+			bio->bi_dev = dev;
+			bio->bi_idx = 0;
+			bio->bi_end_io = bio_end_io_kvec;
+			bio->bi_private = vec_cb;
+			bio->bi_io_vec = veclet;
+
+			while (blen < tlen) {
+				if ((blen + veclet->bv_len) > BIO_MAX_SIZE) 
+					break;
+
+				blen += veclet->bv_len;
+				bio->bi_vcnt++;
+				veclet++;
+			}
+
+			bio->bi_size = blen;
+			sector += (blen >> 9);
+			tlen -= blen;
+
+			submit_bio(rw, bio);
+			total += blen;
+		}
+	}
+
+out:
+	if (err)
+		vec_cb->errno = err;
+
+	/*
+	 * final atomic_dec of io_count to match our initial setting of 1.
+	 * I/O may or may not have completed at this point, final completion
+	 * handler is only run on last decrement.
+	 */
+	end_kvec_request(vec_cb, !err);
+	return total;
+}
+
 module_init(init_bio);
 
 EXPORT_SYMBOL(bio_alloc);
diff -Naur -X dontdiff linux-2.5.3pre6.org/fs/block_dev.c linux-2.5.3pre6/fs/block_dev.c
--- linux-2.5.3pre6.org/fs/block_dev.c	Mon Feb  4 21:20:28 2002
+++ linux-2.5.3pre6/fs/block_dev.c	Mon Feb  4 21:06:44 2002
@@ -134,9 +134,9 @@
 	return 0;
 }
 
-static int blkdev_direct_IO(int rw, struct inode * inode, struct kiobuf * iobuf, unsigned long blocknr, int blocksize)
+static int blkdev_direct_IO(int rw, struct inode * inode, struct kvec * iobuf, unsigned long blocknr, int iosize, int blocksize)
 {
-	return generic_direct_IO(rw, inode, iobuf, blocknr, blocksize, blkdev_get_block);
+	return generic_direct_IO(rw, inode, iobuf, blocknr, blocksize, iosize, blkdev_get_block);
 }
 
 static int blkdev_writepage(struct page * page)
diff -Naur -X dontdiff linux-2.5.3pre6.org/fs/buffer.c linux-2.5.3pre6/fs/buffer.c
--- linux-2.5.3pre6.org/fs/buffer.c	Mon Feb  4 21:20:28 2002
+++ linux-2.5.3pre6/fs/buffer.c	Wed Feb  6 22:41:59 2002
@@ -1919,14 +1919,20 @@
 	return tmp.b_blocknr;
 }
 
-int generic_direct_IO(int rw, struct inode * inode, struct kiobuf * iobuf, unsigned long blocknr, int blocksize, get_block_t * get_block)
+int generic_direct_IO(int rw, struct inode * inode, struct kvec * vec, unsigned long blocknr, int blocksize, int iosize, get_block_t * get_block)
 {
 	int i, nr_blocks, retval;
-	sector_t *blocks = iobuf->blocks;
+	int 	blkno, len;
+	sector_t blocks[256];
+	int	blen[256];
+
+	nr_blocks = iosize/blocksize;
+	i = 0;
+	len = 0;
+	blkno = -2;
 
-	nr_blocks = iobuf->length / blocksize;
 	/* build the blocklist */
-	for (i = 0; i < nr_blocks; i++, blocknr++) {
+	while (nr_blocks) {
 		struct buffer_head bh;
 
 		bh.b_state = 0;
@@ -1937,12 +1943,17 @@
 		if (retval)
 			goto out;
 
+		blocknr++;
+		nr_blocks--;
+
 		if (rw == READ) {
 			if (buffer_new(&bh))
 				BUG();
 			if (!buffer_mapped(&bh)) {
 				/* there was an hole in the filesystem */
 				blocks[i] = -1UL;
+				blen[i] = blocksize;
+				i++;
 				continue;
 			}
 		} else {
@@ -1951,11 +1962,28 @@
 			if (!buffer_mapped(&bh))
 				BUG();
 		}
-		blocks[i] = bh.b_blocknr;
+		if (bh.b_blocknr == blkno + 1) {
+			len += blocksize;
+		} else {
+			if (len != 0) {
+				blocks[i] = blkno * (blocksize >> 9);
+				blen[i] = len;
+				i++;
+			}
+			blkno = bh.b_blocknr;
+			len = blocksize;
+		}
+		
+	}
+
+	if (blkno != -2) {
+		blocks[i] = blkno * (blocksize >> 9);
+		blen[i] = len;
+		i++;
 	}
 
 	/* This does not understand multi-device filesystems currently */
-	retval = brw_kiovec(rw, 1, &iobuf, inode->i_dev, blocks, blocksize);
+	retval = brw_kvec(rw, i, vec, inode->i_dev, blocks, blen, blocksize);
 
  out:
 	return retval;
@@ -2017,6 +2045,40 @@
 		if (!err)
 			transferred += iobuf->length;
 	}
+
+	return err ? err : transferred;
+}
+
+int brw_kvec(int rw, int nr, struct kvec *vec, kdev_t dev, sector_t b[],
+	       int len[], int size)
+{
+	int		transferred;
+	int		i, err;
+	struct	kvec_cb	vec_cb;
+	kveclet_t	*vecl;
+
+	if (!nr)
+		return 0;
+	
+	if (!vec->nr)
+		panic("brw_kvec: kvec not initialised");
+
+	vecl = vec->veclet;
+	for (i = 0; i < vec->nr; i++, vecl++) {
+		if ((vecl->bv_offset & (size-1)) || (vecl->bv_len & (size-1)))
+			return -EINVAL;
+	}
+
+	vec_cb.errno = 0;
+	init_waitqueue_head(&vec_cb.wait_queue);
+	atomic_set(&vec_cb.io_count, 0);
+	vec_cb.vec = vec;
+
+	transferred = ll_rw_kvec(rw, &vec_cb, dev, nr, b, len);
+
+	kvec_wait_for_io(&vec_cb);
+
+	err = vec_cb.errno;
 
 	return err ? err : transferred;
 }
diff -Naur -X dontdiff linux-2.5.3pre6.org/fs/ext2/inode.c linux-2.5.3pre6/fs/ext2/inode.c
--- linux-2.5.3pre6.org/fs/ext2/inode.c	Mon Feb  4 21:20:28 2002
+++ linux-2.5.3pre6/fs/ext2/inode.c	Mon Feb  4 21:13:06 2002
@@ -592,9 +592,9 @@
 {
 	return generic_block_bmap(mapping,block,ext2_get_block);
 }
-static int ext2_direct_IO(int rw, struct inode * inode, struct kiobuf * iobuf, unsigned long blocknr, int blocksize)
+static int ext2_direct_IO(int rw, struct inode * inode, struct kvec * iobuf, unsigned long blocknr, int blocksize, int iosize)
 {
-	return generic_direct_IO(rw, inode, iobuf, blocknr, blocksize, ext2_get_block);
+	return generic_direct_IO(rw, inode, iobuf, blocknr, blocksize, iosize, ext2_get_block);
 }
 struct address_space_operations ext2_aops = {
 	readpage: ext2_readpage,
diff -Naur -X dontdiff linux-2.5.3pre6.org/fs/iobuf.c linux-2.5.3pre6/fs/iobuf.c
--- linux-2.5.3pre6.org/fs/iobuf.c	Tue Nov 27 09:23:27 2001
+++ linux-2.5.3pre6/fs/iobuf.c	Tue Feb  5 16:38:09 2002
@@ -120,3 +120,56 @@
 
 
 
+struct kvec *alloc_kvec(int nr)
+{
+	struct kvec *vec;
+	
+	vec = kmalloc(sizeof(struct kvec) + nr * sizeof(kveclet_t), GFP_KERNEL);
+	if (!vec) {
+		return 0;
+	}
+	vec->nr = 0;
+	vec->max_nr = nr;
+	return vec; 
+}
+
+void free_kvec(struct kvec *vec)
+{
+	kfree(vec);
+}
+
+int end_kvec_request(struct kvec_cb *vec_cb, int uptodate)
+{
+	int ret = 1;
+
+	if ((!uptodate) && !vec_cb->errno)
+		vec_cb->errno = -EIO;
+
+	if (atomic_dec_and_test(&vec_cb->io_count)) {
+		ret = 0;
+		wake_up(&vec_cb->wait_queue);
+	}
+
+	return ret;
+}
+
+void kvec_wait_for_io(struct kvec_cb *vec_cb)
+{
+	struct task_struct *tsk = current;
+	DECLARE_WAITQUEUE(wait, tsk);
+
+	if (atomic_read(&vec_cb->io_count) == 0)
+		return;
+
+	add_wait_queue(&vec_cb->wait_queue, &wait);
+repeat:
+	set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+	if (atomic_read(&vec_cb->io_count) != 0) {
+		run_task_queue(&tq_disk);
+		schedule();
+		if (atomic_read(&vec_cb->io_count) != 0)
+			goto repeat;
+	}
+	tsk->state = TASK_RUNNING;
+	remove_wait_queue(&vec_cb->wait_queue, &wait);
+}
diff -Naur -X dontdiff linux-2.5.3pre6.org/include/linux/fs.h linux-2.5.3pre6/include/linux/fs.h
--- linux-2.5.3pre6.org/include/linux/fs.h	Mon Feb  4 21:20:28 2002
+++ linux-2.5.3pre6/include/linux/fs.h	Mon Feb  4 21:13:39 2002
@@ -350,6 +350,7 @@
 struct page;
 struct address_space;
 struct kiobuf;
+struct kvec;
 
 struct address_space_operations {
 	int (*writepage)(struct page *);
@@ -366,7 +367,7 @@
 	int (*flushpage) (struct page *, unsigned long);
 	int (*releasepage) (struct page *, int);
 #define KERNEL_HAS_O_DIRECT /* this is for modules out of the kernel */
-	int (*direct_IO)(int, struct inode *, struct kiobuf *, unsigned long, int);
+	int (*direct_IO)(int, struct inode *, struct kvec *, unsigned long, int, int);
 };
 
 struct address_space {
@@ -1434,7 +1435,7 @@
 sector_t generic_block_bmap(struct address_space *, sector_t, get_block_t *);
 int generic_commit_write(struct file *, struct page *, unsigned, unsigned);
 int block_truncate_page(struct address_space *, loff_t, get_block_t *);
-extern int generic_direct_IO(int, struct inode *, struct kiobuf *, unsigned long, int, get_block_t *);
+extern int generic_direct_IO(int, struct inode *, struct kvec *, unsigned long, int, int, get_block_t *);
 
 extern int waitfor_one_page(struct page*);
 extern int generic_file_mmap(struct file *, struct vm_area_struct *);
diff -Naur -X dontdiff linux-2.5.3pre6.org/include/linux/iobuf.h linux-2.5.3pre6/include/linux/iobuf.h
--- linux-2.5.3pre6.org/include/linux/iobuf.h	Mon Jan 14 13:27:14 2002
+++ linux-2.5.3pre6/include/linux/iobuf.h	Tue Feb  5 16:28:54 2002
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/wait.h>
 #include <asm/atomic.h>
+#include <linux/bio.h>
 
 /*
  * The kiobuf structure describes a physical set of pages reserved
@@ -84,5 +85,42 @@
 
 /* fs/bio.c */
 void	ll_rw_kio(int rw, struct kiobuf *kio, kdev_t dev, sector_t block);
+
+
+typedef struct bio_vec kveclet_t;
+
+struct kvec {
+	unsigned	max_nr;
+	unsigned	nr;
+	kveclet_t	veclet[0];
+};
+
+struct kvec_cb {
+	struct kvec	*vec;
+	atomic_t	io_count;
+	int		errno;	
+	wait_queue_head_t wait_queue;
+};
+
+/* mm/memory.c */
+
+int	map_user_kvec(int rw, struct kvec *vec, unsigned long va, size_t len);
+void	unmap_kvec(struct kvec *vec);
+void	mark_dirty_kvec(struct kvec *vec, int bytes);
+
+/* fs/iobuf.c */
+
+int	end_kvec_request(struct kvec_cb *, int);
+struct kvec *alloc_kvec(int nr);
+void	free_kvec(struct kvec *);
+void	kvec_wait_for_io(struct kvec_cb *);
+
+/* fs/buffer.c */
+int	brw_kvec(int rw, int nr, struct kvec *vec, 
+		   kdev_t dev, sector_t [], int len[], int size);
+
+/* fs/bio.c */
+int	ll_rw_kvec(int rw, struct kvec_cb *vec_cb, kdev_t dev, int nr, sector_t b[], int len[]);
+
 
 #endif /* __LINUX_IOBUF_H */
diff -Naur -X dontdiff linux-2.5.3pre6.org/mm/filemap.c linux-2.5.3pre6/mm/filemap.c
--- linux-2.5.3pre6.org/mm/filemap.c	Mon Feb  4 21:20:28 2002
+++ linux-2.5.3pre6/mm/filemap.c	Mon Feb  4 21:08:09 2002
@@ -1483,22 +1483,14 @@
 static ssize_t generic_file_direct_IO(int rw, struct file * filp, char * buf, size_t count, loff_t offset)
 {
 	ssize_t retval;
-	int new_iobuf, chunk_size, blocksize_mask, blocksize, blocksize_bits, iosize, progress;
-	struct kiobuf * iobuf;
+	int chunk_size, blocksize_mask, blocksize, blocksize_bits, iosize, progress;
+	struct kvec *vec;
 	struct address_space * mapping = filp->f_dentry->d_inode->i_mapping;
 	struct inode * inode = mapping->host;
 
-	new_iobuf = 0;
-	iobuf = filp->f_iobuf;
-	if (test_and_set_bit(0, &filp->f_iobuf_lock)) {
-		/*
-		 * A parallel read/write is using the preallocated iobuf
-		 * so just run slow and allocate a new one.
-		 */
-		retval = alloc_kiovec(1, &iobuf);
-		if (retval)
-			goto out;
-		new_iobuf = 1;
+	vec = alloc_kvec((count/PAGE_SIZE) + 1);
+	if (!vec) {
+		return -ENOMEM;
 	}
 
 	blocksize = 1 << inode->i_blkbits;
@@ -1528,14 +1520,14 @@
 		if (iosize > chunk_size)
 			iosize = chunk_size;
 
-		retval = map_user_kiobuf(rw, iobuf, (unsigned long) buf, iosize);
+		retval = map_user_kvec(rw, vec, (unsigned long) buf, iosize);
 		if (retval)
 			break;
 
-		retval = mapping->a_ops->direct_IO(rw, inode, iobuf, (offset+progress) >> blocksize_bits, blocksize);
+		retval = mapping->a_ops->direct_IO(rw, inode, vec, (offset+progress) >> blocksize_bits, blocksize, iosize);
 
 		if (rw == READ && retval > 0)
-			mark_dirty_kiobuf(iobuf, retval);
+			mark_dirty_kvec(vec, retval);
 		
 		if (retval >= 0) {
 			count -= retval;
@@ -1543,7 +1535,7 @@
 			progress += retval;
 		}
 
-		unmap_kiobuf(iobuf);
+		unmap_kvec(vec);
 
 		if (retval != iosize)
 			break;
@@ -1553,10 +1545,7 @@
 		retval = progress;
 
  out_free:
-	if (!new_iobuf)
-		clear_bit(0, &filp->f_iobuf_lock);
-	else
-		free_kiovec(1, &iobuf);
+	free_kvec(vec);
  out:	
 	return retval;
 }
diff -Naur -X dontdiff linux-2.5.3pre6.org/mm/memory.c linux-2.5.3pre6/mm/memory.c
--- linux-2.5.3pre6.org/mm/memory.c	Mon Feb  4 21:20:28 2002
+++ linux-2.5.3pre6/mm/memory.c	Wed Feb  6 17:13:41 2002
@@ -1443,3 +1443,138 @@
 			len, write, 0, NULL, NULL);
 	return ret == len ? 0 : -1;
 }
+
+int get_user_pages_veclet(struct task_struct *tsk, struct mm_struct *mm, 
+		unsigned long start, int len, int write, int force, kveclet_t *vecl)
+{
+	int i = 0;
+	unsigned long offset;
+
+	offset = start & ~PAGE_MASK;
+
+	do {
+		struct vm_area_struct *	vma;
+
+		vma = find_extend_vma(mm, start);
+
+		if ( !vma ||
+		    (!force &&
+		     	((write && (!(vma->vm_flags & VM_WRITE))) ||
+		    	 (!write && (!(vma->vm_flags & VM_READ))) ) )) {
+			if (i) return i;
+			return -EFAULT;
+		}
+
+		spin_lock(&mm->page_table_lock);
+		do {
+			struct page *map;
+			while (!(map = follow_page(mm, start, write))) {
+				spin_unlock(&mm->page_table_lock);
+				switch (handle_mm_fault(mm, vma, start, write)) {
+				case 1:
+					tsk->min_flt++;
+					break;
+				case 2:
+					tsk->maj_flt++;
+					break;
+				case 0:
+					if (i) return i;
+					return -EFAULT;
+				default:
+					if (i) return i;
+					return -ENOMEM;
+				}
+				spin_lock(&mm->page_table_lock);
+			}
+			map = get_page_map(map);
+			if (map) {
+				vecl->bv_page = map;
+				page_cache_get(map);
+				flush_dcache_page(map);
+			} else 
+				printk (KERN_INFO "Mapped page missing\n");
+
+			vecl->bv_offset = offset;
+			vecl->bv_len = PAGE_SIZE - offset;
+			if (len < vecl->bv_len)
+				vecl->bv_len = len;
+			start += PAGE_SIZE;
+			offset = 0;
+			len -= vecl->bv_len;
+			vecl++;
+			i++;
+		} while(len && start < vma->vm_end);
+		spin_unlock(&mm->page_table_lock);
+	} while(len);
+	return i;
+}
+
+int map_user_kvec(int rw, struct kvec *vec, unsigned long va, size_t len)
+{
+	int pgcount, err;
+	struct mm_struct *mm;
+	
+	mm = current->mm;
+	
+	pgcount = (va + len + PAGE_SIZE - 1)/PAGE_SIZE - va/PAGE_SIZE;
+
+	if (!pgcount) BUG();
+
+	if (vec->nr + pgcount > vec->max_nr) 
+		return -ENOMEM;
+
+	/* Try to fault in all of the necessary pages */
+	down_read(&mm->mmap_sem);
+
+	/* rw==READ means read from disk, write into memory area */
+	err = get_user_pages_veclet(current, mm, va, len,
+			(rw==READ), 0, &vec->veclet[vec->nr]);
+
+	up_read(&mm->mmap_sem);
+
+	if (err < 0) {
+		unmap_kvec(vec);
+		return err;
+	}
+	vec->nr += err;
+
+	return 0;
+}
+
+void unmap_kvec (struct kvec *vec) 
+{
+	int i;
+	struct page *map;
+	kveclet_t *vecl;
+
+	vecl = vec->veclet;
+	
+	for (i = 0; i < vec->nr; i++, vecl++) {
+		map = vecl->bv_page;
+		if (map) {
+			page_cache_release(map);
+		}
+	}
+	
+	vec->nr = 0;
+}
+
+void mark_dirty_kvec(struct kvec *vec, int bytes)
+{
+	int index;
+	struct page *page;
+	kveclet_t *vecl;
+	
+	index = 0;
+	vecl = vec->veclet;
+	while (bytes > 0 && index < vec->max_nr) {
+		page = vecl->bv_page;
+		
+		if (!PageReserved(page))
+			SetPageDirty(page);
+
+		bytes -= vecl->bv_len;
+		index++;
+		vecl++;
+	}
+}
