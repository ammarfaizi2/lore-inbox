Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317951AbSGPTlD>; Tue, 16 Jul 2002 15:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317952AbSGPTlC>; Tue, 16 Jul 2002 15:41:02 -0400
Received: from hank-fep6-0.inet.fi ([194.251.242.201]:56793 "EHLO
	fep06.tmt.tele.fi") by vger.kernel.org with ESMTP
	id <S317951AbSGPTks>; Tue, 16 Jul 2002 15:40:48 -0400
Message-ID: <3D34773C.F61E7C0F@pp.inet.fi>
Date: Tue, 16 Jul 2002 22:42:52 +0300
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.2.20aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>, William Lee Irwin III <wli@holomorphy.com>
CC: Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@zip.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG] loop.c oopses
References: <20020716163636.GW811@suse.de> <Pine.LNX.4.44L.0207161349100.3009-100000@duckman.distro.conectiva> <20020716170921.GX811@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Tue, Jul 16 2002, Rik van Riel wrote:
> > On Tue, 16 Jul 2002, Jens Axboe wrote:
> > > On Tue, Jul 16 2002, Rik van Riel wrote:
> > > Given the finite size of the pool and the possibly infinite stacking
> > > level, yes that is possible. You may just run out of loop minors before
> > > this happens [1]. Also note that you need more than a simple remapping,
> > > crypto setup for instance.
> >
> > Or maybe SMP, with multiple CPUs submitting requests at the
> > same time ?
> 
> It would still require a totally pathetic loop setup. More than 2 or 3
> stacked loop devices that are not using remapping would crawl

remapping?

> performance wise. Now make that eg 32 "indirections" (allocations and
> copies on _each_ i/o), and I think you'll find that the system would be
> impossible to use long before this theoretical dead lock would be hit.

Jens,

Your remapping code has _never_ worked. This is because your remapping is
supposedly enabled in none_status(), but init hook of type 0 transfer is
never called (check the code in loop_init_xfer). And, even if were enabled,
you would quickly notice that lo->lo_pending count is never decremented in
your 'remap' code.

The patch below fixes that remap issue, plus uncounted number of other loop
issues. For example, device backed loops use pre-allocated pages for zero VM
pressure.

Too bad you seem to be filtering my emails.

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>

diff -urN linux-2.5.25/drivers/block/loop.c linux-2.5.25-loopfix/drivers/block/loop.c
--- linux-2.5.25/drivers/block/loop.c	Wed Jun 19 12:14:13 2002
+++ linux-2.5.25-loopfix/drivers/block/loop.c	Wed Jul 10 22:59:10 2002
@@ -52,6 +52,22 @@
  *   problem above. Encryption modules that used to rely on the old scheme
  *   should just call ->i_mapping->bmap() to calculate the physical block
  *   number.
+ *
+ * IV is now passed as (512 byte) sector number.
+ * Jari Ruusu <jari.ruusu@pp.inet.fi>, May 18 2001
+ *
+ * External encryption module locking bug fixed.
+ * Ingo Rohloff <rohloff@in.tum.de>, June 21 2001
+ *
+ * Make device backed loop work with swap (pre-allocated buffers + queue rewrite).
+ * Jari Ruusu <jari.ruusu@pp.inet.fi>, September 2 2001
+ *
+ * Ported 'pre-allocated buffers + queue rewrite' to BIO for 2.5 kernels
+ * Ben Slusky <sluskyb@stwing.org>, March 1 2002
+ * Jari Ruusu <jari.ruusu@pp.inet.fi>, March 27 2002
+ *
+ * File backed code now uses file->f_op->read/write. Based on Andrew Morton's idea.
+ * Jari Ruusu <jari.ruusu@pp.inet.fi>, May 23 2002
  */ 
 
 #include <linux/config.h>
@@ -82,14 +98,14 @@
 
 static int max_loop = 8;
 static struct loop_device *loop_dev;
-static int *loop_sizes;
+static /*FIXME sector_t*/int *loop_sizes;
 static devfs_handle_t devfs_handle;      /*  For the directory */
 
 /*
  * Transfer functions
  */
 static int transfer_none(struct loop_device *lo, int cmd, char *raw_buf,
-			 char *loop_buf, int size, int real_block)
+			 char *loop_buf, int size, /*FIXME sector_t*/int real_block)
 {
 	if (raw_buf != loop_buf) {
 		if (cmd == READ)
@@ -97,12 +113,12 @@
 		else
 			memcpy(raw_buf, loop_buf, size);
 	}
-
+	cond_resched();
 	return 0;
 }
 
 static int transfer_xor(struct loop_device *lo, int cmd, char *raw_buf,
-			char *loop_buf, int size, int real_block)
+			char *loop_buf, int size, /*FIXME sector_t*/int real_block)
 {
 	char	*in, *out, *key;
 	int	i, keysize;
@@ -119,12 +135,12 @@
 	keysize = lo->lo_encrypt_key_size;
 	for (i = 0; i < size; i++)
 		*out++ = *in++ ^ key[(i & 511) % keysize];
+	cond_resched();
 	return 0;
 }
 
 static int none_status(struct loop_device *lo, struct loop_info *info)
 {
-	lo->lo_flags |= LO_FLAGS_BH_REMAP;
 	return 0;
 }
 
@@ -153,353 +169,429 @@
 	&xor_funcs  
 };
 
-#define MAX_DISK_SIZE 1024*1024*1024
-
-static unsigned long
-compute_loop_size(struct loop_device *lo, struct dentry * lo_dentry)
-{
-	loff_t size = lo_dentry->d_inode->i_mapping->host->i_size;
-	return (size - lo->lo_offset) >> BLOCK_SIZE_BITS;
+/*
+ *  First number of 'lo_prealloc' is the default number of RAM pages
+ *  to pre-allocate for each device backed loop. Every (configured)
+ *  device backed loop pre-allocates this amount of RAM pages unless
+ *  later 'lo_prealloc' numbers provide an override. 'lo_prealloc'
+ *  overrides are defined in pairs: loop_index,number_of_pages
+ */
+static int lo_prealloc[9] = { 125, -1, 0, -1, 0, -1, 0, -1, 0 };
+#define LO_PREALLOC_MIN 4    /* minimum user defined pre-allocated RAM pages */
+#define LO_PREALLOC_MAX 512  /* maximum user defined pre-allocated RAM pages */
+
+#ifdef MODULE
+MODULE_PARM(lo_prealloc, "1-9i");
+MODULE_PARM_DESC(lo_prealloc, "Number of pre-allocated pages [,index,pages]...");
+#else
+static int __init lo_prealloc_setup(char *str)
+{
+	int x, y, z;
+
+	for (x = 0; x < (sizeof(lo_prealloc) / sizeof(int)); x++) {
+		z = get_option(&str, &y);
+		if (z > 0)
+			lo_prealloc[x] = y;
+		if (z < 2)
+			break;
+	}
+	return 1;
 }
+__setup("lo_prealloc=", lo_prealloc_setup);
+#endif
 
-static void figure_loop_size(struct loop_device *lo)
-{
-	loop_sizes[lo->lo_number] = compute_loop_size(lo,
-					lo->lo_backing_file->f_dentry);
-					
-}
+struct loop_bio_extension {
+	struct bio		*bioext_merge;
+	struct loop_device	*bioext_loop;
+	sector_t		bioext_sector;
+	int			bioext_index;
+	int			bioext_size;
+};	
 
-static inline int lo_do_transfer(struct loop_device *lo, int cmd, char *rbuf,
-				 char *lbuf, int size, int rblock)
+static void loop_prealloc_cleanup(struct loop_device *lo)
 {
-	if (!lo->transfer)
-		return 0;
+	struct bio *bio;
 
-	return lo->transfer(lo, cmd, rbuf, lbuf, size, rblock);
+	while ((bio = lo->lo_bio_free0)) {
+		lo->lo_bio_free0 = bio->bi_next;
+		__free_page(bio->bi_io_vec[0].bv_page);
+		kfree(bio->bi_private);
+		bio->bi_next = NULL;
+		bio_put(bio);
+	}
+	while ((bio = lo->lo_bio_free1)) {
+		lo->lo_bio_free1 = bio->bi_next;
+		/* bi_flags was used for other purpose */
+		bio->bi_flags = 0;
+		/* bi_cnt was used for other purpose */
+		atomic_set(&bio->bi_cnt, 1);
+		bio->bi_next = NULL;
+		bio_put(bio);
+	}
 }
 
-static int
-do_lo_send(struct loop_device *lo, struct bio_vec *bvec, int bsize, loff_t pos)
+static int loop_prealloc_init(struct loop_device *lo, int y)
 {
-	struct file *file = lo->lo_backing_file; /* kudos to NFsckingS */
-	struct address_space *mapping = file->f_dentry->d_inode->i_mapping;
-	struct address_space_operations *aops = mapping->a_ops;
-	struct page *page;
-	char *kaddr, *data;
-	unsigned long index;
-	unsigned size, offset;
-	int len;
-	int ret = 0;
+	struct bio *bio;
+	int x;
 
-	down(&mapping->host->i_sem);
-	index = pos >> PAGE_CACHE_SHIFT;
-	offset = pos & (PAGE_CACHE_SIZE - 1);
-	data = kmap(bvec->bv_page) + bvec->bv_offset;
-	len = bvec->bv_len;
-	while (len > 0) {
-		int IV = index * (PAGE_CACHE_SIZE/bsize) + offset/bsize;
-		int transfer_result;
-
-		size = PAGE_CACHE_SIZE - offset;
-		if (size > len)
-			size = len;
-
-		page = grab_cache_page(mapping, index);
-		if (!page)
-			goto fail;
-		if (aops->prepare_write(file, page, offset, offset+size))
-			goto unlock;
-		kaddr = page_address(page);
-		flush_dcache_page(page);
-		transfer_result = lo_do_transfer(lo, WRITE, kaddr + offset, data, size, IV);
-		if (transfer_result) {
-			/*
-			 * The transfer failed, but we still write the data to
-			 * keep prepare/commit calls balanced.
-			 */
-			printk(KERN_ERR "loop: transfer error block %ld\n", index);
-			memset(kaddr + offset, 0, size);
-		}
-		if (aops->commit_write(file, page, offset, offset+size))
-			goto unlock;
-		if (transfer_result)
-			goto unlock;
-		data += size;
-		len -= size;
-		offset = 0;
-		index++;
-		pos += size;
-		unlock_page(page);
-		page_cache_release(page);
+	if(!y) {
+		y = lo_prealloc[0];
+		for (x = 1; x < (sizeof(lo_prealloc) / sizeof(int)); x += 2) {
+			if (lo_prealloc[x + 1] && (lo->lo_number == lo_prealloc[x])) {
+				y = lo_prealloc[x + 1];
+				break;
+			}
+		}
 	}
-	up(&mapping->host->i_sem);
-out:
-	kunmap(bvec->bv_page);
-	return ret;
+	lo->lo_bio_flsh = (y * 3) / 4;
 
-unlock:
-	unlock_page(page);
-	page_cache_release(page);
-fail:
-	up(&mapping->host->i_sem);
-	ret = -1;
-	goto out;
+	for (x = 0; x < y; x++) {
+		bio = bio_alloc(GFP_KERNEL, 1);
+		if (!bio) {
+			fail1:
+			loop_prealloc_cleanup(lo);
+			return 1;
+		}
+		bio->bi_io_vec[0].bv_page = alloc_page(GFP_KERNEL);
+		if (!bio->bi_io_vec[0].bv_page) {
+			fail2:
+			bio->bi_next = NULL;
+			bio_put(bio);
+			goto fail1;
+		}
+		bio->bi_vcnt = 1;
+		bio->bi_private = kmalloc(sizeof(struct loop_bio_extension), GFP_KERNEL);
+		if (!bio->bi_private)
+			goto fail2;
+		bio->bi_next = lo->lo_bio_free0;
+		lo->lo_bio_free0 = bio;
+
+		bio = bio_alloc(GFP_KERNEL, 1);
+		if (!bio)
+			goto fail1;
+		bio->bi_vcnt = 1;
+		bio->bi_next = lo->lo_bio_free1;
+		lo->lo_bio_free1 = bio;
+	}
+	return 0;
 }
 
-static int
-lo_send(struct loop_device *lo, struct bio *bio, int bsize, loff_t pos)
+static void loop_add_queue_last(struct loop_device *lo, struct bio *bio, struct bio **q)
 {
-	unsigned vecnr;
-	int ret = 0;
-
-	for (vecnr = 0; vecnr < bio->bi_vcnt; vecnr++) {
-		struct bio_vec *bvec = &bio->bi_io_vec[vecnr];
+	unsigned long flags;
 
-		ret = do_lo_send(lo, bvec, bsize, pos);
-		if (ret < 0)
-			break;
-		pos += bvec->bv_len;
+	spin_lock_irqsave(&lo->lo_lock, flags);
+	if (*q) {
+		bio->bi_next = (*q)->bi_next;
+		(*q)->bi_next = bio;
+	} else {
+		bio->bi_next = bio;
 	}
-	return ret;
-}
+	*q = bio;
+	spin_unlock_irqrestore(&lo->lo_lock, flags);
 
-struct lo_read_data {
-	struct loop_device *lo;
-	char *data;
-	int bsize;
-};
+	if (waitqueue_active(&lo->lo_bio_wait))
+		wake_up_interruptible(&lo->lo_bio_wait);
+}
 
-static int lo_read_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size)
+static void loop_add_queue_first(struct loop_device *lo, struct bio *bio, struct bio **q)
 {
-	char *kaddr;
-	unsigned long count = desc->count;
-	struct lo_read_data *p = (struct lo_read_data*)desc->buf;
-	struct loop_device *lo = p->lo;
-	int IV = page->index * (PAGE_CACHE_SIZE/p->bsize) + offset/p->bsize;
-
-	if (size > count)
-		size = count;
-
-	kaddr = kmap(page);
-	if (lo_do_transfer(lo, READ, kaddr + offset, p->data, size, IV)) {
-		size = 0;
-		printk(KERN_ERR "loop: transfer error block %ld\n",page->index);
-		desc->error = -EINVAL;
-	}
-	kunmap(page);
-	
-	desc->count = count - size;
-	desc->written += size;
-	p->data += size;
-	return size;
-}
-
-static int
-do_lo_receive(struct loop_device *lo,
-		struct bio_vec *bvec, int bsize, loff_t pos)
-{
-	struct lo_read_data cookie;
-	read_descriptor_t desc;
-	struct file *file;
-
-	cookie.lo = lo;
-	cookie.data = kmap(bvec->bv_page) + bvec->bv_offset;
-	cookie.bsize = bsize;
-	desc.written = 0;
-	desc.count = bvec->bv_len;
-	desc.buf = (char*)&cookie;
-	desc.error = 0;
 	spin_lock_irq(&lo->lo_lock);
-	file = lo->lo_backing_file;
+	if (*q) {
+		bio->bi_next = (*q)->bi_next;
+		(*q)->bi_next = bio;
+	} else {
+		bio->bi_next = bio;
+		*q = bio;
+	}
 	spin_unlock_irq(&lo->lo_lock);
-	do_generic_file_read(file, &pos, &desc, lo_read_actor);
-	kunmap(bvec->bv_page);
-	return desc.error;
 }
 
-static int
-lo_receive(struct loop_device *lo, struct bio *bio, int bsize, loff_t pos)
+static struct bio *loop_get_bio(struct loop_device *lo, int *list_nr)
 {
-	unsigned vecnr;
-	int ret = 0;
-
-	for (vecnr = 0; vecnr < bio->bi_vcnt; vecnr++) {
-		struct bio_vec *bvec = &bio->bi_io_vec[vecnr];
+	struct bio *bio = NULL, *last;
 
-		ret = do_lo_receive(lo, bvec, bsize, pos);
-		if (ret < 0)
-			break;
-		pos += bvec->bv_len;
+	spin_lock_irq(&lo->lo_lock);
+	if ((last = lo->lo_bio_que0)) {
+		bio = last->bi_next;
+		if (bio == last)
+			lo->lo_bio_que0 = NULL;
+		else
+			last->bi_next = bio->bi_next;
+		bio->bi_next = NULL;
+		*list_nr = 0;
+	} else if ((last = lo->lo_bio_que1)) {
+		bio = last->bi_next;
+		if (bio == last)
+			lo->lo_bio_que1 = NULL;
+		else
+			last->bi_next = bio->bi_next;
+		bio->bi_next = NULL;
+		*list_nr = 1;
+	} else if ((last = lo->lo_bio_que2)) {
+		bio = last->bi_next;
+		if (bio == last)
+			lo->lo_bio_que2 = NULL;
+		else
+			last->bi_next = bio->bi_next;
+		bio->bi_next = NULL;
+		*list_nr = 2;
 	}
-	return ret;
-}
-
-static inline int loop_get_bs(struct loop_device *lo)
-{
-	return block_size(lo->lo_device);
-}
-
-static inline unsigned long loop_get_iv(struct loop_device *lo,
-					unsigned long sector)
-{
-	int bs = loop_get_bs(lo);
-	unsigned long offset, IV;
-
-	IV = sector / (bs >> 9) + lo->lo_offset / bs;
-	offset = ((sector % (bs >> 9)) << 9) + lo->lo_offset % bs;
-	if (offset >= bs)
-		IV++;
-
-	return IV;
+	spin_unlock_irq(&lo->lo_lock);
+	return bio;
 }
 
-static int do_bio_filebacked(struct loop_device *lo, struct bio *bio)
+static void loop_put_buffer(struct loop_device *lo, struct bio *b, int flist)
 {
-	loff_t pos;
-	int ret;
-
-	pos = ((loff_t) bio->bi_sector << 9) + lo->lo_offset;
-
-	do {
-		if (bio_rw(bio) == WRITE)
-			ret = lo_send(lo, bio, loop_get_bs(lo), pos);
-		else
-			ret = lo_receive(lo, bio, loop_get_bs(lo), pos);
+	unsigned long flags;
+	int wk;
 
-	} while (++bio->bi_idx < bio->bi_vcnt);
+	spin_lock_irqsave(&lo->lo_lock, flags);
+	if(!flist) {
+		b->bi_next = lo->lo_bio_free0;
+		lo->lo_bio_free0 = b;
+		wk = lo->lo_bio_need & 1;
+	} else {
+		b->bi_next = lo->lo_bio_free1;
+		lo->lo_bio_free1 = b;
+		wk = lo->lo_bio_need & 2;
+	}
+	spin_unlock_irqrestore(&lo->lo_lock, flags);
 
-	return ret;
+	if (wk && waitqueue_active(&lo->lo_bio_wait))
+		wake_up_interruptible(&lo->lo_bio_wait);
 }
 
-static void loop_end_io_transfer(struct bio *);
-static void loop_put_buffer(struct bio *bio)
+static void loop_end_io_transfer(struct bio *bio)
 {
-	/*
-	 * check bi_end_io, may just be a remapped bio
-	 */
-	if (bio && bio->bi_end_io == loop_end_io_transfer) {
-		int i;
-		for (i = 0; i < bio->bi_vcnt; i++)
-			__free_page(bio->bi_io_vec[i].bv_page);
+	struct loop_bio_extension *extension = bio->bi_private;
+	struct bio *merge = extension->bioext_merge;
+	struct loop_device *lo = extension->bioext_loop;
+	struct bio *origbio = merge->bi_private;
+	int uptodate = test_bit(BIO_UPTODATE, &bio->bi_flags);
 
-		bio_put(bio);
+	if (!uptodate)
+		clear_bit(BIO_UPTODATE, &merge->bi_flags);
+	if (bio_rw(bio) == WRITE) {
+		loop_put_buffer(lo, bio, 0);
+		if (!atomic_dec_and_test(&merge->bi_cnt))
+			return;
+		origbio->bi_next = NULL;
+		bio_endio(origbio, test_bit(BIO_UPTODATE, &merge->bi_flags));
+		loop_put_buffer(lo, merge, 1);
+		if (atomic_dec_and_test(&lo->lo_pending))
+			wake_up_interruptible(&lo->lo_bio_wait);
+	} else {
+		loop_add_queue_last(lo, bio, &lo->lo_bio_que0);
 	}
 }
 
-/*
- * Add bio to back of pending list
- */
-static void loop_add_bio(struct loop_device *lo, struct bio *bio)
+static struct bio *loop_get_buffer(struct loop_device *lo,
+		struct bio *orig_bio, int from_thread, struct bio **merge_ptr)
 {
+	struct bio *bio = NULL, *merge = *merge_ptr;
+	struct loop_bio_extension *extension;
 	unsigned long flags;
+	int len;
 
 	spin_lock_irqsave(&lo->lo_lock, flags);
-	if (lo->lo_biotail) {
-		lo->lo_biotail->bi_next = bio;
-		lo->lo_biotail = bio;
-	} else
-		lo->lo_bio = lo->lo_biotail = bio;
+	if (!merge) {
+		merge = lo->lo_bio_free1;
+		if (merge) {
+			lo->lo_bio_free1 = merge->bi_next;
+			if (from_thread)
+				lo->lo_bio_need = 0;
+		} else {
+			if (from_thread)
+				lo->lo_bio_need = 2;
+		}
+	}
+	if (merge) {
+		bio = lo->lo_bio_free0;
+		if (bio) {
+			lo->lo_bio_free0 = bio->bi_next;
+			if (from_thread)
+				lo->lo_bio_need = 0;
+		} else {
+			if (from_thread)
+				lo->lo_bio_need = 1;
+		}
+	}
 	spin_unlock_irqrestore(&lo->lo_lock, flags);
 
-	up(&lo->lo_bh_mutex);
-}
+	if (!(*merge_ptr) && merge) {
+		/*
+		 * initialize "merge-bio" which is used as
+		 * rendezvous point among multiple vecs
+		 */
+		*merge_ptr = merge;
+		merge->bi_sector = orig_bio->bi_sector + (lo->lo_offset >> 9);
+		set_bit(BIO_UPTODATE, &merge->bi_flags);
+		merge->bi_idx = orig_bio->bi_idx;
+		atomic_set(&merge->bi_cnt, orig_bio->bi_vcnt - orig_bio->bi_idx);
+		merge->bi_private = orig_bio;
+	}
 
-/*
- * Grab first pending buffer
- */
-static struct bio *loop_get_bio(struct loop_device *lo)
-{
-	struct bio *bio;
+	if (!bio)
+		return NULL;
 
-	spin_lock_irq(&lo->lo_lock);
-	if ((bio = lo->lo_bio)) {
-		if (bio == lo->lo_biotail)
-			lo->lo_biotail = NULL;
-		lo->lo_bio = bio->bi_next;
-		bio->bi_next = NULL;
-	}
-	spin_unlock_irq(&lo->lo_lock);
+	/*
+	 * initialize one page "buffer-bio"
+	 */
+	bio->bi_sector = merge->bi_sector;
+	bio->bi_next = NULL;
+	bio->bi_bdev = lo->lo_device;
+	bio->bi_flags = 0;
+	bio->bi_rw = orig_bio->bi_rw;
+	bio->bi_vcnt = 1;
+	bio->bi_idx = 0;
+	bio->bi_phys_segments = 0;
+	bio->bi_hw_segments = 0;
+	bio->bi_size = len = orig_bio->bi_io_vec[merge->bi_idx].bv_len;
+	/* bio->bi_max not touched */
+	bio->bi_io_vec[0].bv_len = len;
+	bio->bi_io_vec[0].bv_offset = 0;
+	bio->bi_end_io = loop_end_io_transfer;
+	/* bio->bi_cnt not touched */
+	/* bio->bi_private not touched */
+	/* bio->bi_destructor not touched */
 
-	return bio;
-}
+	/*
+	 * initialize "buffer-bio" extension. This extension is
+	 * permanently glued to above "buffer-bio" via bio->bi_private
+	 */
+	extension = bio->bi_private;
+	extension->bioext_merge = merge;
+	extension->bioext_loop = lo;
+	extension->bioext_sector = merge->bi_sector;
+	extension->bioext_index = merge->bi_idx;
+	extension->bioext_size = len;
 
-/*
- * if this was a WRITE lo->transfer stuff has already been done. for READs,
- * queue it for the loop thread and let it do the transfer out of
- * bi_end_io context (we don't want to do decrypt of a page with irqs
- * disabled)
- */
-static void loop_end_io_transfer(struct bio *bio)
-{
-	struct bio *rbh = bio->bi_private;
-	struct loop_device *lo = &loop_dev[minor(to_kdev_t(rbh->bi_bdev->bd_dev))];
-	int uptodate = test_bit(BIO_UPTODATE, &bio->bi_flags);
+	/*
+	 * prepare "merge-bio" for next vec
+	 */
+	merge->bi_sector += len >> 9;
+	merge->bi_idx++;
 
-	if (!uptodate || bio_rw(bio) == WRITE) {
-		bio_endio(rbh, uptodate);
-		if (atomic_dec_and_test(&lo->lo_pending))
-			up(&lo->lo_bh_mutex);
-		loop_put_buffer(bio);
-	} else
-		loop_add_bio(lo, bio);
+	return bio;
 }
 
-static struct bio *loop_get_buffer(struct loop_device *lo, struct bio *rbh)
+static int figure_loop_size(struct loop_device *lo)
 {
-	struct bio *bio;
+	loff_t size = lo->lo_backing_file->f_dentry->d_inode->i_mapping->host->i_size;
+	sector_t x;
 
 	/*
-	 * for xfer_funcs that can operate on the same bh, do that
+	 * Unfortunately, if we want to do I/O on the device,
+	 * the number of 512-byte sectors has to fit into a sector_t.
 	 */
-	if (lo->lo_flags & LO_FLAGS_BH_REMAP) {
-		bio = rbh;
-		goto out_bh;
-	}
+	size = (size - lo->lo_offset) >> 9;
+	x = (sector_t)size;
+	if ((loff_t)x != size)
+		return -EFBIG;
+	/*
+	 * Convert sectors to blocks
+	 */
+	size >>= (BLOCK_SIZE_BITS - 9);
 
-	bio = bio_copy(rbh, GFP_NOIO, rbh->bi_rw & WRITE);
+	loop_sizes[lo->lo_number] = (sector_t)size;
+	return 0;
+}
 
-	bio->bi_end_io = loop_end_io_transfer;
-	bio->bi_private = rbh;
+static inline int lo_do_transfer(struct loop_device *lo, int cmd, char *rbuf,
+				 char *lbuf, int size, int rblock)
+{
+	if (!lo->transfer)
+		return 0;
 
-out_bh:
-	bio->bi_sector = rbh->bi_sector + (lo->lo_offset >> 9);
-	bio->bi_rw = rbh->bi_rw;
-	bio->bi_bdev = lo->lo_device;
+	return lo->transfer(lo, cmd, rbuf, lbuf, size, rblock);
+}
 
-	return bio;
+static int loop_file_io(struct file *file, char *buf, int size, loff_t *ppos, int w)
+{
+	mm_segment_t fs;
+	int x, y, z;
+
+	y = 0;
+	do {
+		z = size - y;
+		fs = get_fs();
+		set_fs(get_ds());
+		if (w) {
+			x = file->f_op->write(file, buf + y, z, ppos);
+			set_fs(fs);
+		} else {
+			x = file->f_op->read(file, buf + y, z, ppos);
+			set_fs(fs);
+			if (!x)
+				return 1;
+		}
+		if (x < 0) {
+			if ((x == -EAGAIN) || (x == -ENOMEM) || (x == -ERESTART) || (x == -EINTR)) {
+				blk_run_queues();
+				set_current_state(TASK_INTERRUPTIBLE);
+				schedule_timeout(HZ / 2);
+				continue;
+			}
+			return 1;
+		}
+		y += x;
+	} while (y < size);
+	return 0;
 }
 
-static int
-bio_transfer(struct loop_device *lo, struct bio *to_bio,
-			      struct bio *from_bio)
-{
-	unsigned long IV = loop_get_iv(lo, from_bio->bi_sector);
-	struct bio_vec *from_bvec, *to_bvec;
-	char *vto, *vfrom;
-	int ret = 0, i;
-
-	__bio_for_each_segment(from_bvec, from_bio, i, 0) {
-		to_bvec = &to_bio->bi_io_vec[i];
-
-		kmap(from_bvec->bv_page);
-		kmap(to_bvec->bv_page);
-		vfrom = page_address(from_bvec->bv_page) + from_bvec->bv_offset;
-		vto = page_address(to_bvec->bv_page) + to_bvec->bv_offset;
-		ret |= lo_do_transfer(lo, bio_data_dir(to_bio), vto, vfrom,
-					from_bvec->bv_len, IV);
-		kunmap(from_bvec->bv_page);
-		kunmap(to_bvec->bv_page);
-	}
+static int do_bio_filebacked(struct loop_device *lo, struct bio *bio)
+{
+	loff_t pos;
+	struct file *file = lo->lo_backing_file;
+	char *data, *buf;
+	unsigned int size, len;
+	sector_t IV;
 
-	return ret;
+	pos = ((loff_t) bio->bi_sector << 9) + lo->lo_offset;
+	buf = page_address(lo->lo_bio_free0->bi_io_vec[0].bv_page);
+	IV = bio->bi_sector + (lo->lo_offset >> 9);
+	do {
+		len = bio->bi_io_vec[bio->bi_idx].bv_len;
+		data = bio_data(bio);
+		while (len > 0) {
+			size = PAGE_SIZE;
+			if (size > len)
+				size = len;
+			if (bio_rw(bio) == WRITE) {
+				if (lo_do_transfer(lo, WRITE, buf, data, size, IV)) {
+					printk(KERN_ERR "loop: write transfer error, sector %llu\n", (unsigned long long)IV);
+					return 1;
+				}
+				if (loop_file_io(file, buf, size, &pos, 1)) {
+					printk(KERN_ERR "loop: write i/o error, sector %llu\n", (unsigned long long)IV);
+					return 1;
+				}
+			} else {
+				if (loop_file_io(file, buf, size, &pos, 0)) {
+					printk(KERN_ERR "loop: read i/o error, sector %llu\n", (unsigned long long)IV);
+					return 1;
+				}
+				if (lo_do_transfer(lo, READ, buf, data, size, IV)) {
+					printk(KERN_ERR "loop: read transfer error, sector %llu\n", (unsigned long long)IV);
+					return 1;
+				}
+			}
+			data += size;
+			len -= size;
+			IV += size >> 9;
+		}
+	} while (++bio->bi_idx < bio->bi_vcnt);
+	return 0;
 }
-		
+
 static int loop_make_request(request_queue_t *q, struct bio *old_bio)
 {
-	struct bio *new_bio = NULL;
+	struct bio *new_bio, *merge;
 	struct loop_device *lo;
-	unsigned long IV;
-	int rw = bio_rw(old_bio);
+	struct loop_bio_extension *extension;
+	int rw = bio_rw(old_bio), y;
 	int unit = minor(to_kdev_t(old_bio->bi_bdev->bd_dev));
 
 	if (unit >= max_loop)
@@ -528,27 +620,57 @@
 	 * file backed, queue for loop_thread to handle
 	 */
 	if (lo->lo_flags & LO_FLAGS_DO_BMAP) {
-		loop_add_bio(lo, old_bio);
+		loop_add_queue_last(lo, old_bio, &lo->lo_bio_que0);
+		return 0;
+	}
+
+	/*
+	 * device backed, just remap bdev & sector for NONE transfer
+	 */
+	if (lo->lo_encrypt_type == LO_CRYPT_NONE) {
+		old_bio->bi_sector += lo->lo_offset >> 9;
+		old_bio->bi_bdev = lo->lo_device;
+		generic_make_request(old_bio);
+		if (atomic_dec_and_test(&lo->lo_pending))
+			wake_up_interruptible(&lo->lo_bio_wait);
 		return 0;
 	}
 
 	/*
-	 * piggy old buffer on original, and submit for I/O
+	 * device backed, start reads and writes now if buffer available
 	 */
-	new_bio = loop_get_buffer(lo, old_bio);
-	IV = loop_get_iv(lo, old_bio->bi_sector);
+	merge = NULL;
+	try_next_old_bio_vec:
+	new_bio = loop_get_buffer(lo, old_bio, 0, &merge);
+	if (!new_bio) {
+		/* just queue request and let thread handle allocs later */
+		if (merge)
+			loop_add_queue_last(lo, merge, &lo->lo_bio_que1);
+		else
+			loop_add_queue_last(lo, old_bio, &lo->lo_bio_que2);
+		return 0;
+	}
 	if (rw == WRITE) {
-		if (bio_transfer(lo, new_bio, old_bio))
-			goto err;
+		extension = new_bio->bi_private;
+		y = extension->bioext_index;
+		if (lo_do_transfer(lo, WRITE, page_address(new_bio->bi_io_vec[0].bv_page), page_address(old_bio->bi_io_vec[y].bv_page) + old_bio->bi_io_vec[y].bv_offset, extension->bioext_size, extension->bioext_sector)) {
+			clear_bit(BIO_UPTODATE, &merge->bi_flags);
+		}
 	}
 
+	/* merge & old_bio may vanish during generic_make_request() */
+	/* if last vec gets processed before function returns   */
+	y = (merge->bi_idx < old_bio->bi_vcnt) ? 1 : 0;
 	generic_make_request(new_bio);
+
+	/* other vecs may need processing too */
+	if (y)
+		goto try_next_old_bio_vec;
 	return 0;
 
 err:
 	if (atomic_dec_and_test(&lo->lo_pending))
-		up(&lo->lo_bh_mutex);
-	loop_put_buffer(new_bio);
+		wake_up_interruptible(&lo->lo_bio_wait);
 out:
 	bio_io_error(old_bio);
 	return 0;
@@ -557,26 +679,6 @@
 	goto out;
 }
 
-static inline void loop_handle_bio(struct loop_device *lo, struct bio *bio)
-{
-	int ret;
-
-	/*
-	 * For block backed loop, we know this is a READ
-	 */
-	if (lo->lo_flags & LO_FLAGS_DO_BMAP) {
-		ret = do_bio_filebacked(lo, bio);
-		bio_endio(bio, !ret);
-	} else {
-		struct bio *rbh = bio->bi_private;
-
-		ret = bio_transfer(lo, bio, rbh);
-
-		bio_endio(rbh, !ret);
-		loop_put_buffer(bio);
-	}
-}
-
 /*
  * worker thread that handles reads/writes to file backed loop devices,
  * to avoid blocking in our make_request_fn. it also does loop decrypting
@@ -586,9 +688,15 @@
 static int loop_thread(void *data)
 {
 	struct loop_device *lo = data;
-	struct bio *bio;
+	struct bio *bio, *xbio, *merge;
+	struct loop_bio_extension *extension;
+	int x, y, flushcnt = 0;
+	wait_queue_t waitq;
 
+	init_waitqueue_entry(&waitq, current);
 	daemonize();
+	exit_files(current);
+	reparent_to_init();
 
 	sprintf(current->comm, "loop%d", lo->lo_number);
 	current->flags |= PF_IOTHREAD;	/* loop can be used in an encrypted device
@@ -611,23 +719,132 @@
 	up(&lo->lo_sem);
 
 	for (;;) {
-		down_interruptible(&lo->lo_bh_mutex);
+		add_wait_queue(&lo->lo_bio_wait, &waitq);
+		for (;;) {
+			set_current_state(TASK_INTERRUPTIBLE);
+			if (!atomic_read(&lo->lo_pending))
+				break;
+
+			x = 0;
+			spin_lock_irq(&lo->lo_lock);
+			if (lo->lo_bio_que0) {
+				/* don't sleep if device backed READ needs processing */
+				/* don't sleep if file backed READ/WRITE needs processing */
+				x = 1;
+			} else if (lo->lo_bio_que1) {
+				/* don't sleep if a buffer-bio is available */
+				/* don't sleep if need-buffer-bio request is not set */
+				if (lo->lo_bio_free0 || !(lo->lo_bio_need & 1))
+					x = 1;
+			} else if (lo->lo_bio_que2) {
+				/* don't sleep if a merge-bio is available */
+				/* don't sleep if need-merge-bio request is not set */
+				if (lo->lo_bio_free1 || !(lo->lo_bio_need & 2))
+					x = 1;
+			}
+			spin_unlock_irq(&lo->lo_lock);
+			if (x)
+				break;
+
+			schedule();
+		}
+		current->state = TASK_RUNNING;
+		remove_wait_queue(&lo->lo_bio_wait, &waitq);
+
 		/*
-		 * could be upped because of tear-down, not because of
+		 * could be woken because of tear-down, not because of
 		 * pending work
 		 */
 		if (!atomic_read(&lo->lo_pending))
 			break;
 
-		bio = loop_get_bio(lo);
-		if (!bio) {
-			printk("loop: missing bio\n");
+		bio = loop_get_bio(lo, &x);
+		if (!bio)
 			continue;
+
+		/*
+		 *  x  list tag         usage(has-buffer,has-merge)
+		 * --- --------         --------------------------
+		 *  0  lo->lo_bio_que0  dev-r(y,y) / file-rw
+		 *  1  lo->lo_bio_que1  dev-rw(n,y)
+		 *  2  lo->lo_bio_que2  dev-rw(n,n)
+		 */
+		if (x >= 1) {
+			/* loop_make_request didn't allocate a buffer, do that now */
+			if (x == 1) {
+				merge = bio;
+				bio = merge->bi_private;
+			} else {
+				merge = NULL;
+			}
+			try_next_bio_vec:
+			xbio = loop_get_buffer(lo, bio, 1, &merge);
+			if (!xbio) {
+				blk_run_queues();
+				flushcnt = 0;
+				if (merge)
+					loop_add_queue_first(lo, merge, &lo->lo_bio_que1);
+				else
+					loop_add_queue_first(lo, bio, &lo->lo_bio_que2);
+				/* lo->lo_bio_need should be non-zero now, go back to sleep */
+				continue;
+			}
+			if (bio_rw(bio) == WRITE) {
+				extension = xbio->bi_private;
+				y = extension->bioext_index;
+				if (lo_do_transfer(lo, WRITE, page_address(xbio->bi_io_vec[0].bv_page), page_address(bio->bi_io_vec[y].bv_page) + bio->bi_io_vec[y].bv_offset, extension->bioext_size, extension->bioext_sector)) {
+					clear_bit(BIO_UPTODATE, &merge->bi_flags);
+				}
+			}
+
+			/* merge & bio may vanish during generic_make_request() */
+			/* if last vec gets processed before function returns   */
+			y = (merge->bi_idx < bio->bi_vcnt) ? 1 : 0;
+			generic_make_request(xbio);
+
+			/* start I/O if there are no more requests lacking buffers */
+			x = 0;
+			spin_lock_irq(&lo->lo_lock);
+			if (!y && !lo->lo_bio_que1 && !lo->lo_bio_que2)
+				x = 1;
+			spin_unlock_irq(&lo->lo_lock);
+			if (x || (++flushcnt >= lo->lo_bio_flsh)) {
+				blk_run_queues();
+				flushcnt = 0;
+			}
+
+			/* other vecs may need processing too */
+			if (y)
+				goto try_next_bio_vec;
+
+			/* request not completely processed yet */
+ 			continue;
+ 		}
+
+		if (lo->lo_flags & LO_FLAGS_DO_BMAP) {
+			/* request is for file backed device */
+			y = do_bio_filebacked(lo, bio);
+			bio->bi_next = NULL;
+			bio_endio(bio, !y);
+		} else {
+			/* device backed read has completed, do decrypt now */
+			extension = bio->bi_private;
+			merge = extension->bioext_merge;
+			y = extension->bioext_index;
+			xbio = merge->bi_private;
+			if (lo_do_transfer(lo, READ, page_address(bio->bi_io_vec[0].bv_page), page_address(xbio->bi_io_vec[y].bv_page) + xbio->bi_io_vec[y].bv_offset, extension->bioext_size, extension->bioext_sector)) {
+				clear_bit(BIO_UPTODATE, &merge->bi_flags);
+			}
+			loop_put_buffer(lo, bio, 0);
+			if (!atomic_dec_and_test(&merge->bi_cnt))
+				continue;
+			xbio->bi_next = NULL;
+			bio_endio(xbio, test_bit(BIO_UPTODATE, &merge->bi_flags));
+			loop_put_buffer(lo, merge, 1);
 		}
-		loop_handle_bio(lo, bio);
 
 		/*
-		 * upped both for pending work and tear-down, lo_pending
+		 * woken both for pending work and tear-down, lo_pending
 		 * will hit zero then
 		 */
 		if (atomic_dec_and_test(&lo->lo_pending))
@@ -647,6 +864,7 @@
 	struct block_device *lo_device;
 	int		lo_flags = 0;
 	int		error;
+	int		bs;
 
 	MOD_INC_USE_COUNT;
 
@@ -665,33 +883,43 @@
 	if (!(file->f_mode & FMODE_WRITE))
 		lo_flags |= LO_FLAGS_READ_ONLY;
 
+	lo->lo_bio_free1 = lo->lo_bio_free0 = lo->lo_bio_que2 = lo->lo_bio_que1 = lo->lo_bio_que0 = NULL;
+	lo->lo_bio_need = lo->lo_bio_flsh = 0;
+	init_waitqueue_head(&lo->lo_bio_wait);
 	if (S_ISBLK(inode->i_mode)) {
 		lo_device = inode->i_bdev;
 		if (lo_device == bdev) {
 			error = -EBUSY;
-			goto out;
+			goto out_putf;
+		}
+		if (loop_prealloc_init(lo, 0)) {
+			error = -ENOMEM;
+			goto out_putf;
 		}
 	} else if (S_ISREG(inode->i_mode)) {
-		struct address_space_operations *aops = inode->i_mapping->a_ops;
 		/*
 		 * If we can't read - sorry. If we only can't write - well,
 		 * it's going to be read-only.
 		 */
-		if (!aops->readpage)
+		if (!file->f_op || !file->f_op->read)
 			goto out_putf;
 
-		if (!aops->prepare_write || !aops->commit_write)
+		if (!file->f_op->write)
 			lo_flags |= LO_FLAGS_READ_ONLY;
 
 		lo_device = inode->i_sb->s_bdev;
 		lo_flags |= LO_FLAGS_DO_BMAP;
+		if (loop_prealloc_init(lo, 1)) {
+			error = -ENOMEM;
+			goto out_putf;
+		}
 		error = 0;
 	} else
 		goto out_putf;
 
 	get_file(file);
 
-	if (IS_RDONLY (inode) || bdev_read_only(lo_device)
+	if ((S_ISREG(inode->i_mode) && IS_RDONLY(inode)) || bdev_read_only(lo_device)
 	    || !(lo_file->f_mode & FMODE_WRITE))
 		lo_flags |= LO_FLAGS_READ_ONLY;
 
@@ -702,13 +930,28 @@
 	lo->lo_backing_file = file;
 	lo->transfer = NULL;
 	lo->ioctl = NULL;
-	figure_loop_size(lo);
+	if (figure_loop_size(lo)) {
+		loop_prealloc_cleanup(lo);
+		error = -EFBIG;
+		fput(file);
+		goto out_putf;
+	}
 	lo->old_gfp_mask = inode->i_mapping->gfp_mask;
 	inode->i_mapping->gfp_mask = GFP_NOIO;
 
-	set_blocksize(bdev, block_size(lo_device));
+	bs = block_size(lo_device);
+	if (S_ISREG(inode->i_mode)) {
+		int x = (int) loop_sizes[lo->lo_number];
+
+		if ((bs == 8192) && (x & 7))
+			bs = 4096;
+		if ((bs == 4096) && (x & 3))
+			bs = 2048;
+		if ((bs == 2048) && (x & 1))
+			bs = 1024;
+	}
+	set_blocksize(bdev, bs);
 
-	lo->lo_bio = lo->lo_biotail = NULL;
 	kernel_thread(loop_thread, lo, CLONE_FS | CLONE_FILES | CLONE_SIGHAND);
 	down(&lo->lo_sem);
 
@@ -767,11 +1010,12 @@
 	spin_lock_irq(&lo->lo_lock);
 	lo->lo_state = Lo_rundown;
 	if (atomic_dec_and_test(&lo->lo_pending))
-		up(&lo->lo_bh_mutex);
+		wake_up_interruptible(&lo->lo_bio_wait);
 	spin_unlock_irq(&lo->lo_lock);
 
 	down(&lo->lo_sem);
 
+	loop_prealloc_cleanup(lo);
 	lo->lo_backing_file = NULL;
 
 	loop_release_xfer(lo);
@@ -798,6 +1042,7 @@
 	struct loop_info info; 
 	int err;
 	unsigned int type;
+	loff_t offset;
 
 	if (lo->lo_encrypt_key_size && lo->lo_key_owner != current->uid && 
 	    !capable(CAP_SYS_ADMIN))
@@ -813,13 +1058,23 @@
 		return -EINVAL;
 	if (type == LO_CRYPT_XOR && info.lo_encrypt_key_size == 0)
 		return -EINVAL;
+
 	err = loop_release_xfer(lo);
 	if (!err) 
 		err = loop_init_xfer(lo, type, &info);
+
+	offset = lo->lo_offset;
+	if (offset != info.lo_offset) {
+		lo->lo_offset = info.lo_offset;
+		if (figure_loop_size(lo)){
+			err = -EFBIG;
+			lo->lo_offset = offset;
+		}
+	}
+
 	if (err)
 		return err;	
 
-	lo->lo_offset = info.lo_offset;
 	strncpy(lo->lo_name, info.lo_name, LO_NAME_SIZE);
 
 	lo->transfer = xfer_funcs[type]->transfer;
@@ -832,7 +1087,7 @@
 		       info.lo_encrypt_key_size);
 		lo->lo_key_owner = current->uid; 
 	}	
-	figure_loop_size(lo);
+
 	return 0;
 }
 
@@ -926,7 +1181,7 @@
 static int lo_open(struct inode *inode, struct file *file)
 {
 	struct loop_device *lo;
-	int	dev, type;
+	int	dev;
 
 	if (!inode)
 		return -EINVAL;
@@ -941,10 +1196,6 @@
 	lo = &loop_dev[dev];
 	MOD_INC_USE_COUNT;
 	down(&lo->lo_ctl_mutex);
-
-	type = lo->lo_encrypt_type; 
-	if (type && xfer_funcs[type] && xfer_funcs[type]->lock)
-		xfer_funcs[type]->lock(lo);
 	lo->lo_refcnt++;
 	up(&lo->lo_ctl_mutex);
 	return 0;
@@ -953,7 +1204,7 @@
 static int lo_release(struct inode *inode, struct file *file)
 {
 	struct loop_device *lo;
-	int	dev, type;
+	int	dev;
 
 	if (!inode)
 		return 0;
@@ -968,11 +1219,7 @@
 
 	lo = &loop_dev[dev];
 	down(&lo->lo_ctl_mutex);
-	type = lo->lo_encrypt_type;
 	--lo->lo_refcnt;
-	if (xfer_funcs[type] && xfer_funcs[type]->unlock)
-		xfer_funcs[type]->unlock(lo);
-
 	up(&lo->lo_ctl_mutex);
 	MOD_DEC_USE_COUNT;
 	return 0;
@@ -1047,7 +1294,7 @@
 	if (!loop_dev)
 		return -ENOMEM;
 
-	loop_sizes = kmalloc(max_loop * sizeof(int), GFP_KERNEL);
+	loop_sizes = kmalloc(max_loop * sizeof(loop_sizes[0]), GFP_KERNEL);
 	if (!loop_sizes)
 		goto out_mem;
 
@@ -1059,16 +1306,23 @@
 		memset(lo, 0, sizeof(struct loop_device));
 		init_MUTEX(&lo->lo_ctl_mutex);
 		init_MUTEX_LOCKED(&lo->lo_sem);
-		init_MUTEX_LOCKED(&lo->lo_bh_mutex);
 		lo->lo_number = i;
 		spin_lock_init(&lo->lo_lock);
 	}
 
-	memset(loop_sizes, 0, max_loop * sizeof(int));
+	memset(loop_sizes, 0, max_loop * sizeof(*loop_sizes));
 	blk_size[MAJOR_NR] = loop_sizes;
 	for (i = 0; i < max_loop; i++)
 		register_disk(NULL, mk_kdev(MAJOR_NR, i), 1, &lo_fops, 0);
 
+	for (i = 0; i < (sizeof(lo_prealloc) / sizeof(int)); i += 2) {
+		if (!lo_prealloc[i])
+			continue;
+		if (lo_prealloc[i] < LO_PREALLOC_MIN)
+			lo_prealloc[i] = LO_PREALLOC_MIN;
+		if (lo_prealloc[i] > LO_PREALLOC_MAX)
+			lo_prealloc[i] = LO_PREALLOC_MAX;
+	}
 	printk(KERN_INFO "loop: loaded (max %d devices)\n", max_loop);
 	return 0;
 
diff -urN linux-2.5.25/fs/block_dev.c linux-2.5.25-loopfix/fs/block_dev.c
--- linux-2.5.25/fs/block_dev.c	Sat Jul  6 19:55:59 2002
+++ linux-2.5.25-loopfix/fs/block_dev.c	Wed Jul 10 23:51:20 2002
@@ -539,10 +539,10 @@
 		bdev->bd_op = get_blkfops(major(dev));
 		if (!bdev->bd_op)
 			goto out;
-		owner = bdev->bd_op->owner;
-		if (owner)
-			__MOD_INC_USE_COUNT(owner);
 	}
+	owner = bdev->bd_op->owner;
+	if (owner)
+		__MOD_INC_USE_COUNT(owner);
 	if (!bdev->bd_contains) {
 		unsigned minor = minor(dev);
 		struct gendisk *g = get_gendisk(dev);
diff -urN linux-2.5.25/include/linux/loop.h linux-2.5.25-loopfix/include/linux/loop.h
--- linux-2.5.25/include/linux/loop.h	Wed Jun 19 12:14:15 2002
+++ linux-2.5.25-loopfix/include/linux/loop.h	Wed Jul 10 21:53:19 2002
@@ -17,6 +17,11 @@
 
 #ifdef __KERNEL__
 
+/* definitions for IV metric -- cryptoapi specific */
+#define LOOP_IV_SECTOR_BITS 9
+#define LOOP_IV_SECTOR_SIZE (1 << LOOP_IV_SECTOR_BITS)
+typedef /*FIXME sector_t*/int loop_iv_t;
+
 /* Possible states of device */
 enum {
 	Lo_unbound,
@@ -33,7 +38,7 @@
 	int		lo_flags;
 	int		(*transfer)(struct loop_device *, int cmd,
 				    char *raw_buf, char *loop_buf, int size,
-				    int real_block);
+				    /*FIXME sector_t*/int real_block);
 	char		lo_name[LO_NAME_SIZE];
 	char		lo_encrypt_key[LO_KEY_SIZE];
 	__u32           lo_init[2];
@@ -49,13 +54,18 @@
 	int		old_gfp_mask;
 
 	spinlock_t		lo_lock;
-	struct bio 		*lo_bio;
-	struct bio		*lo_biotail;
+	struct bio		*lo_bio_que0;
+	struct bio		*lo_bio_que1;
 	int			lo_state;
 	struct semaphore	lo_sem;
 	struct semaphore	lo_ctl_mutex;
-	struct semaphore	lo_bh_mutex;
 	atomic_t		lo_pending;
+	struct bio		*lo_bio_que2;
+	struct bio		*lo_bio_free0;
+	struct bio		*lo_bio_free1;
+	int			lo_bio_flsh;
+	int			lo_bio_need;
+	wait_queue_head_t	lo_bio_wait;
 };
 
 typedef	int (* transfer_proc_t)(struct loop_device *, int cmd,
@@ -69,7 +79,6 @@
  */
 #define LO_FLAGS_DO_BMAP	1
 #define LO_FLAGS_READ_ONLY	2
-#define LO_FLAGS_BH_REMAP	4
 
 /* 
  * Note that this structure gets the wrong offsets when directly used
@@ -114,6 +123,8 @@
 #define LO_CRYPT_IDEA     6
 #define LO_CRYPT_DUMMY    9
 #define LO_CRYPT_SKIPJACK 10
+#define LO_CRYPT_AES      16
+#define LO_CRYPT_CRYPTOAPI 18
 #define MAX_LO_CRYPT	20
 
 #ifdef __KERNEL__
diff -urN linux-2.5.25/kernel/ksyms.c linux-2.5.25-loopfix/kernel/ksyms.c
--- linux-2.5.25/kernel/ksyms.c	Sat Jul  6 19:56:00 2002
+++ linux-2.5.25-loopfix/kernel/ksyms.c	Wed Jul 10 21:21:19 2002
@@ -88,6 +88,7 @@
 EXPORT_SYMBOL(do_munmap);
 EXPORT_SYMBOL(do_brk);
 EXPORT_SYMBOL(exit_mm);
+EXPORT_SYMBOL(exit_files);
 
 /* internal kernel memory management */
 EXPORT_SYMBOL(_alloc_pages);

