Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313558AbSHBNOU>; Fri, 2 Aug 2002 09:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313477AbSHBNOU>; Fri, 2 Aug 2002 09:14:20 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:56568 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S313421AbSHBNON>; Fri, 2 Aug 2002 09:14:13 -0400
Date: Fri, 2 Aug 2002 18:47:39 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, axboe@kernel.org
Subject: Re: [PATCH] Bio Traversal Changes - (Patch 3/4 : biotr8-blkdrivers.diff)
Message-ID: <20020802184739.C1859@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20020802180513.A1802@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020802180513.A1802@in.ibm.com>; from suparna@in.ibm.com on Fri, Aug 02, 2002 at 06:05:13PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Modifications (in part) to some drivers to account for bio 
traversal changes.

A few considerations:
- Drivers which traverse segments directly (rather than
  use helpers like blk_rq_map_sg or handle and complete
  one segment at a time using end_that_request_first),
  would need to account for bi_voffset and bi_endvoffset.
- Preferably use rq_map_buffer() to map the current 
  segment to a virtual address if needed, or do something
  similar to account for the correct offsets. bio_kmap_irq
  is gone now (notice that the start of the bio may no longer
  be the start of the next portion to submit, which is
  the right one to map during request processing)
- Use bio_segsize() to find out the length of the
  first bio segment rather than directly rely on the bv_len
  field, since the bio could contain just a part of the vec.
- In general remember that bio_startoffset() and
  bio_endoffset() could be non-zero.
- Drivers which create/setup bios themselves would 
  need to ensure correct initialization of bi_voffset
  and bi_endvoffset

General:
Since some of the block layer helper routines depend
on nr_sectors, current_nr_sectors, hard_cur_sectors, 
nr_bio_segments and nr_bio_sectors, a little care is 
needed to avoid inconsistencies amongst the various counts 
and pointers at any point. A good option is to make use 
of process_that_request_first where applicable/suitable 
and have it take care of ensuring this, rather than trying 
to do the same by hand.

As mentioned earlier some temporary BUG_ON sanity checks
have been inserted at some places where the drivers didn't
appear to be handle arbitrary bios (i.e. with non-zero
bio_startoffset/bio_endoffset).

No changes have been made to LVM for now. Eventually things like
LVM/EVMS would be the generators of clone bios of the type
allowed by this change.

diff -ur linux-2.5.30-pure/drivers/block/floppy.c linux-2.5.30-bio/drivers/block/floppy.c
--- linux-2.5.30-pure/drivers/block/floppy.c	Fri Aug  2 10:08:27 2002
+++ linux-2.5.30-bio/drivers/block/floppy.c	Fri Aug  2 10:43:30 2002
@@ -2472,6 +2472,9 @@
 	size = 0;
 
 	rq_for_each_bio(bio, CURRENT) {
+		/* Can't handle arbitrary split bio pieces */
+		BIO_BUG_ON(bio_startoffset(bio) != 0);
+		BIO_BUG_ON(bio_endoffset(bio) != 0);
 		bio_for_each_segment(bv, bio, i) {
 			if (page_address(bv->bv_page) + bv->bv_offset != base + size)
 				break;
@@ -2539,6 +2542,9 @@
 	size = CURRENT->current_nr_sectors << 9;
 
 	rq_for_each_bio(bio, CURRENT) {
+		/* Can't handle arbitrary bio pieces as yet */
+		BIO_BUG_ON(bio_startoffset(bio) != 0);
+		BIO_BUG_ON(bio_endoffset(bio) != 0);
 		bio_for_each_segment(bv, bio, i) {
 			if (!remaining)
 				break;
@@ -3886,6 +3892,9 @@
 	bio.bi_vcnt = 1;
 	bio.bi_idx = 0;
 	bio.bi_size = size;
+	bio.bi_voffset = __BVEC_START(&bio)->bv_offset;
+	bio.bi_endvoffset = __BVEC_END(&bio)->bv_offset +
+		__BVEC_END(&bio)->bv_len;
 	bio.bi_bdev = bdev;
 	bio.bi_sector = 0;
 	init_completion(&complete);
diff -ur linux-2.5.30-pure/drivers/block/loop.c linux-2.5.30-bio/drivers/block/loop.c
--- linux-2.5.30-pure/drivers/block/loop.c	Fri Aug  2 10:08:27 2002
+++ linux-2.5.30-bio/drivers/block/loop.c	Fri Aug  2 10:43:30 2002
@@ -179,7 +179,8 @@
 }
 
 static int
-do_lo_send(struct loop_device *lo, struct bio_vec *bvec, int bsize, loff_t pos)
+do_lo_send(struct loop_device *lo, struct bio_vec *bvec, int bsize, loff_t pos,
+		int startoff, int endoff)
 {
 	struct file *file = lo->lo_backing_file; /* kudos to NFsckingS */
 	struct address_space *mapping = file->f_dentry->d_inode->i_mapping;
@@ -194,8 +195,8 @@
 	down(&mapping->host->i_sem);
 	index = pos >> PAGE_CACHE_SHIFT;
 	offset = pos & (PAGE_CACHE_SIZE - 1);
-	data = kmap(bvec->bv_page) + bvec->bv_offset;
-	len = bvec->bv_len;
+	data = kmap(bvec->bv_page) + bvec->bv_offset + startoff;
+	len = bvec->bv_len - startoff - endoff;
 	while (len > 0) {
 		int IV = index * (PAGE_CACHE_SIZE/bsize) + offset/bsize;
 		int transfer_result;
@@ -251,14 +252,19 @@
 {
 	unsigned vecnr;
 	int ret = 0;
+	int startoff = bio_startoffset(bio), endoff = 0;
 
 	for (vecnr = 0; vecnr < bio->bi_vcnt; vecnr++) {
+		/* FIXME: Could be more efficient */
+		if (vecnr == bio->bi_vcnt - 1) 
+			endoff = bio_endoffset(bio);
 		struct bio_vec *bvec = &bio->bi_io_vec[vecnr];
 
-		ret = do_lo_send(lo, bvec, bsize, pos);
+		ret = do_lo_send(lo, bvec, bsize, pos, startoff, endoff);
 		if (ret < 0)
 			break;
-		pos += bvec->bv_len;
+		pos += bvec->bv_len - startoff - endoff;
+		startoff = 0;
 	}
 	return ret;
 }
@@ -296,17 +302,17 @@
 
 static int
 do_lo_receive(struct loop_device *lo,
-		struct bio_vec *bvec, int bsize, loff_t pos)
+	struct bio_vec *bvec, int bsize, loff_t pos, int startoff, int endoff)
 {
 	struct lo_read_data cookie;
 	read_descriptor_t desc;
 	struct file *file;
 
 	cookie.lo = lo;
-	cookie.data = kmap(bvec->bv_page) + bvec->bv_offset;
+	cookie.data = kmap(bvec->bv_page) + bvec->bv_offset + startoff;
 	cookie.bsize = bsize;
 	desc.written = 0;
-	desc.count = bvec->bv_len;
+	desc.count = bvec->bv_len - startoff - endoff;
 	desc.buf = (char*)&cookie;
 	desc.error = 0;
 	spin_lock_irq(&lo->lo_lock);
@@ -322,14 +328,20 @@
 {
 	unsigned vecnr;
 	int ret = 0;
+	int startoff = bio_startoffset(bio), endoff = 0;
 
 	for (vecnr = 0; vecnr < bio->bi_vcnt; vecnr++) {
 		struct bio_vec *bvec = &bio->bi_io_vec[vecnr];
 
-		ret = do_lo_receive(lo, bvec, bsize, pos);
+		/* FIXME: Could be more efficient */
+		if (vecnr == bio->bi_vcnt - 1) 
+			endoff = bio_endoffset(bio);
+
+		ret = do_lo_receive(lo, bvec, bsize, pos, startoff, endoff);
 		if (ret < 0)
 			break;
-		pos += bvec->bv_len;
+		pos += bvec->bv_len - startoff - endoff;
+		startoff = 0;
 	}
 	return ret;
 }
@@ -477,18 +489,29 @@
 	struct bio_vec *from_bvec, *to_bvec;
 	char *vto, *vfrom;
 	int ret = 0, i;
+	int from_start, from_len, to_start;
 
+	from_start = bio_offset(from_bio);
+	to_start = bio_offset(to_bio);
 	__bio_for_each_segment(from_bvec, from_bio, i, 0) {
 		to_bvec = &to_bio->bi_io_vec[i];
+		from_len = from_bvec->bv_len;
+
+		/* FIXME: Could be more efficient */
+		if (i == from_bio->bi_vcnt - 1)
+			from_len -= bio_endoffset(from_bio);
 
 		kmap(from_bvec->bv_page);
 		kmap(to_bvec->bv_page);
-		vfrom = page_address(from_bvec->bv_page) + from_bvec->bv_offset;
-		vto = page_address(to_bvec->bv_page) + to_bvec->bv_offset;
+		vfrom = page_address(from_bvec->bv_page) + from_bvec->bv_offset
+			+ from_start;
+		vto = page_address(to_bvec->bv_page) + to_bvec->bv_offset +
+			to_start;
 		ret |= lo_do_transfer(lo, bio_data_dir(to_bio), vto, vfrom,
-					from_bvec->bv_len, IV);
+					from_len, IV);
 		kunmap(from_bvec->bv_page);
 		kunmap(to_bvec->bv_page);
+		from_start = to_start = 0;
 	}
 
 	return ret;
diff -ur linux-2.5.30-pure/drivers/block/nbd.c linux-2.5.30-bio/drivers/block/nbd.c
--- linux-2.5.30-pure/drivers/block/nbd.c	Sat Jul 27 08:28:32 2002
+++ linux-2.5.30-bio/drivers/block/nbd.c	Fri Aug  2 10:43:30 2002
@@ -180,6 +180,9 @@
 		 * whether to set MSG_MORE or not...
 		 */
 		rq_for_each_bio(bio, req) {
+			/* Can't handle arbitrary bio pieces yet */
+			BIO_BUG_ON(bio_startoffset(bio) != 0);
+			BIO_BUG_ON(bio_endoffset(bio) != 0);
 			struct bio_vec *bvec;
 			bio_for_each_segment(bvec, bio, i) {
 				flags = 0;
diff -ur linux-2.5.30-pure/drivers/block/rd.c linux-2.5.30-bio/drivers/block/rd.c
--- linux-2.5.30-pure/drivers/block/rd.c	Fri Aug  2 10:08:27 2002
+++ linux-2.5.30-bio/drivers/block/rd.c	Fri Aug  2 10:43:30 2002
@@ -227,6 +227,9 @@
 
 	sector = bio->bi_sector;
 	rw = bio_data_dir(bio);
+	/* Can't handle a bio split in the middle of a segment */
+	BIO_BUG_ON(bio_startoffset(bio) > 0);
+	BIO_BUG_ON(bio_offset(bio) > 0);
 	bio_for_each_segment(bvec, bio, i) {
 		ret |= rd_blkdev_pagecache_IO(rw, bvec, sector, minor);
 		sector += bvec->bv_len >> 9;
diff -ur linux-2.5.30-pure/drivers/block/umem.c linux-2.5.30-bio/drivers/block/umem.c
--- linux-2.5.30-pure/drivers/block/umem.c	Fri Aug  2 10:08:27 2002
+++ linux-2.5.30-bio/drivers/block/umem.c	Fri Aug  2 10:43:30 2002
@@ -423,7 +423,7 @@
 	if (card->mm_pages[card->Ready].cnt >= DESC_PER_PAGE)
 		return 0;
 
-	len = bio_iovec(bio)->bv_len;
+	len = bio_segsize(bio);
 	dma_handle = pci_map_page(card->dev, 
 				  bio_page(bio),
 				  bio_offset(bio),
diff -ur linux-2.5.30-pure/drivers/ide/ide-disk.c linux-2.5.30-bio/drivers/ide/ide-disk.c
--- linux-2.5.30-pure/drivers/ide/ide-disk.c	Fri Aug  2 10:08:28 2002
+++ linux-2.5.30-bio/drivers/ide/ide-disk.c	Fri Aug  2 10:43:30 2002
@@ -45,7 +45,7 @@
 static inline char *ide_map_rq(struct request *rq, unsigned long *flags)
 {
 	if (rq->bio)
-		return bio_kmap_irq(rq->bio, flags) + ide_rq_offset(rq);
+		return rq_map_buffer(rq, flags);
 	else
 		return rq->buffer + ((rq)->nr_sectors - (rq)->current_nr_sectors) * SECTOR_SIZE;
 }
@@ -54,7 +54,7 @@
 				unsigned long *flags)
 {
 	if (rq->bio)
-		bio_kunmap_irq(to, flags);
+		rq_unmap_buffer(to, flags);
 }
 
 /*
@@ -293,7 +293,7 @@
 				nsect = mcount;
 			mcount -= nsect;
 
-			buf = bio_kmap_irq(rq->bio, &flags) + ide_rq_offset(rq);
+			buf = ide_map_rq(rq, &flags);
 			rq->sector += nsect;
 			rq->nr_sectors -= nsect;
 			rq->current_nr_sectors -= nsect;
@@ -318,7 +318,7 @@
 			 * last transfer.
 			 */
 			ata_write(drive, buf, nsect * SECTOR_WORDS);
-			bio_kunmap_irq(buf, &flags);
+			ide_unmap_rq(rq, buf, &flags);
 		} while (mcount);
 
 		ret = ATA_OP_CONTINUES;
diff -ur linux-2.5.30-pure/drivers/ide/ide.c linux-2.5.30-bio/drivers/ide/ide.c
--- linux-2.5.30-pure/drivers/ide/ide.c	Fri Aug  2 10:08:28 2002
+++ linux-2.5.30-bio/drivers/ide/ide.c	Fri Aug  2 10:43:30 2002
@@ -795,7 +795,9 @@
 			rq->errors = 0;
 			if (rq->bio) {
 				rq->sector = rq->bio->bi_sector;
-				rq->current_nr_sectors = bio_iovec(rq->bio)->bv_len >> 9;
+				rq->current_nr_sectors = bio_segsize(rq->bio)
+					>> 9;
+
 				rq->buffer = NULL;
 			}
 			ret = ATA_OP_FINISHED;
diff -ur linux-2.5.30-pure/drivers/ide/pdc4030.c linux-2.5.30-bio/drivers/ide/pdc4030.c
--- linux-2.5.30-pure/drivers/ide/pdc4030.c	Sat Jul 27 08:28:32 2002
+++ linux-2.5.30-bio/drivers/ide/pdc4030.c	Fri Aug  2 10:43:30 2002
@@ -400,14 +400,14 @@
 	if (nsect > sectors_avail)
 		nsect = sectors_avail;
 	sectors_avail -= nsect;
-	to = bio_kmap_irq(rq->bio, &flags) + ide_rq_offset(rq);
+	to = ide_map_rq(rq, &flags);
 	promise_read(drive, to, nsect * SECTOR_WORDS);
 #ifdef DEBUG_READ
 	printk(KERN_DEBUG "%s:  promise_read: sectors(%ld-%ld), "
 	       "buf=0x%08lx, rem=%ld\n", drive->name, rq->sector,
 	       rq->sector+nsect-1, (unsigned long) to, rq->nr_sectors-nsect);
 #endif
-	bio_kunmap_irq(to, &flags);
+	ide_unmap_rq(rq, to, &flags);
 	rq->sector += nsect;
 	rq->errors = 0;
 	rq->nr_sectors -= nsect;
diff -ur linux-2.5.30-pure/drivers/md/raid1.c linux-2.5.30-bio/drivers/md/raid1.c
--- linux-2.5.30-pure/drivers/md/raid1.c	Sat Jul 27 08:28:24 2002
+++ linux-2.5.30-bio/drivers/md/raid1.c	Fri Aug  2 10:43:30 2002
@@ -90,6 +90,9 @@
 	bio->bi_vcnt = RESYNC_PAGES;
 	bio->bi_idx = 0;
 	bio->bi_size = RESYNC_BLOCK_SIZE;
+	bio->bi_voffset = __BVEC_START(bio)->bv_offset;
+	bio->bi_endvoffset = __BVEC_END(bio)->bv_offset +
+		__BVEC_END(bio)->bv_len;
 	bio->bi_end_io = NULL;
 	atomic_set(&bio->bi_cnt, 1);
 
diff -ur linux-2.5.30-pure/drivers/md/raid5.c linux-2.5.30-bio/drivers/md/raid5.c
--- linux-2.5.30-pure/drivers/md/raid5.c	Sat Jul 27 08:28:31 2002
+++ linux-2.5.30-bio/drivers/md/raid5.c	Fri Aug  2 10:43:30 2002
@@ -429,6 +429,8 @@
 	dev->vec.bv_page = dev->page;
 	dev->vec.bv_len = STRIPE_SIZE;
 	dev->vec.bv_offset = 0;
+	dev->req.bi_voffset = 0;
+	dev->req.bi_endvoffset = STRIPE_SIZE;
 
 	dev->req.bi_bdev = conf->disks[i].bdev;
 	dev->req.bi_sector = sh->sector;
@@ -615,6 +617,11 @@
 	for (;bio && bio->bi_sector < sector+STRIPE_SECTORS;
 		bio = bio->bi_next) {
 		int page_offset;
+
+		/* Can't handle arbitrary bio pieces yet */
+		BIO_BUG_ON(bio_startoffset(bio) != 0);
+		BIO_BUG_ON(bio_endoffset(bio) != 0);
+
 		if (bio->bi_sector >= sector)
 			page_offset = (signed)(bio->bi_sector - sector) * 512;
 		else 
diff -ur linux-2.5.30-pure/drivers/scsi/ide-scsi.c linux-2.5.30-bio/drivers/scsi/ide-scsi.c
--- linux-2.5.30-pure/drivers/scsi/ide-scsi.c	Fri Aug  2 10:08:28 2002
+++ linux-2.5.30-bio/drivers/scsi/ide-scsi.c	Fri Aug  2 10:43:30 2002
@@ -592,8 +592,10 @@
 		while (segments--) {
 			bh->bi_io_vec[0].bv_page = sg->page;
 			bh->bi_io_vec[0].bv_len = sg->length;
-			bh->bi_io_vec[0].bv_offset = sg->offset;
+			bh->bi_voffset = bh->bi_io_vec[0].bv_offset = sg->offset;
 			bh->bi_size = sg->length;
+			bh->bi_endvoffset = bh->bi_io_vec[0].bv_offset +
+				bh->bi_io_vec[0].bv_len;
 			bh = bh->bi_next;
 			sg++;
 		}
@@ -605,8 +607,10 @@
 #endif
 		bh->bi_io_vec[0].bv_page = virt_to_page(pc->s.scsi_cmd->request_buffer);
 		bh->bi_io_vec[0].bv_len = pc->request_transfer;
-		bh->bi_io_vec[0].bv_offset = (unsigned long) pc->s.scsi_cmd->request_buffer & ~PAGE_MASK;
+		bh->bi_voffset = bh->bi_io_vec[0].bv_offset = (unsigned long) pc->s.scsi_cmd->request_buffer & ~PAGE_MASK;
 		bh->bi_size = pc->request_transfer;
+		bh->bi_endvoffset = bh->bi_io_vec[0].bv_offset +
+				bh->bi_io_vec[0].bv_len;
 	}
 	return first_bh;
 }
diff -ur linux-2.5.30-pure/drivers/scsi/scsi_lib.c linux-2.5.30-bio/drivers/scsi/scsi_lib.c
--- linux-2.5.30-pure/drivers/scsi/scsi_lib.c	Sat Jul 27 08:28:38 2002
+++ linux-2.5.30-bio/drivers/scsi/scsi_lib.c	Fri Aug  2 10:43:30 2002
@@ -481,10 +481,11 @@
 		if (SCpnt->buffer != req->buffer) {
 			if (rq_data_dir(req) == READ) {
 				unsigned long flags;
-				char *to = bio_kmap_irq(req->bio, &flags);
+				/* Todo: check if this is all we need to do */
+				char *to = rq_map_buffer(req, &flags);
 
 				memcpy(to, SCpnt->buffer, SCpnt->bufflen);
-				bio_kunmap_irq(to, &flags);
+				rq_unmap_buffer(to, &flags);
 			}
 			kfree(SCpnt->buffer);
 		}
