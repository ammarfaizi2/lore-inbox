Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261568AbTC0XkO>; Thu, 27 Mar 2003 18:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261572AbTC0XkO>; Thu, 27 Mar 2003 18:40:14 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:5017 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S261568AbTC0XkF>; Thu, 27 Mar 2003 18:40:05 -0500
Date: Fri, 28 Mar 2003 00:50:54 +0100 (MET)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Suparna Bhattacharya <suparna@in.ibm.com>,
       Andre Hedrick <andre@linux-ide.org>, Jens Axboe <axboe@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] bio traversal 1/2 - core changes
In-Reply-To: <Pine.SOL.4.30.0303280012150.24932-100000@mion.elka.pw.edu.pl>
Message-ID: <Pine.SOL.4.30.0303280047160.24932-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


# Bio traversal (separate submittion/completion bio pointers).
# Patch 1/2 - Core changes.
#
# Originally by Suparna Bhattacharya.
#
# Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

diff -uNr linux-2.5.66/drivers/block/elevator.c linux/drivers/block/elevator.c
--- linux-2.5.66/drivers/block/elevator.c	Fri Mar 21 14:23:25 2003
+++ linux/drivers/block/elevator.c	Sat Mar 22 22:50:06 2003
@@ -324,6 +324,19 @@
 		if (&rq->queuelist == q->last_merge)
 			q->last_merge = NULL;

+		/*
+		 * preset some fields (e.g. the req might have been restarted)
+ 		 */
+		if ((rq->bio = rq->hard_bio)) {
+			rq->nr_bio_segments = bio_segments(rq->bio);
+			rq->nr_bio_sectors = bio_sectors(rq->bio);
+			rq->hard_cur_sectors = bio_cur_sectors(rq->bio);
+			rq->buffer = bio_data(rq->bio);
+		}
+		rq->sector = rq->hard_sector;
+		rq->nr_sectors = rq->hard_nr_sectors;
+		rq->current_nr_sectors = rq->hard_cur_sectors;
+
 		if ((rq->flags & REQ_DONTPREP) || !q->prep_rq_fn)
 			break;

diff -uNr linux-2.5.66/drivers/block/ll_rw_blk.c linux/drivers/block/ll_rw_blk.c
--- linux-2.5.66/drivers/block/ll_rw_blk.c	Tue Mar 25 22:53:09 2003
+++ linux/drivers/block/ll_rw_blk.c	Tue Mar 25 23:51:01 2003
@@ -1680,7 +1680,8 @@

 	sector = bio->bi_sector;
 	nr_sectors = bio_sectors(bio);
-	cur_nr_sectors = bio_iovec(bio)->bv_len >> 9;
+	cur_nr_sectors = bio_cur_sectors(bio);
+
 	rw = bio_data_dir(bio);

 	/*
@@ -1736,7 +1737,10 @@
 			}

 			bio->bi_next = req->bio;
-			req->bio = bio;
+			req->hard_bio = req->bio = bio;
+			req->nr_bio_segments = bio_segments(req->bio);
+			req->nr_bio_sectors = bio_sectors(req->bio);
+
 			/*
 			 * may not be valid. if the low level driver said
 			 * it didn't need a bounce buffer then it better
@@ -1806,7 +1810,9 @@
 	req->nr_hw_segments = bio_hw_segments(q, bio);
 	req->buffer = bio_data(bio);	/* see ->buffer comment above */
 	req->waiting = NULL;
-	req->bio = req->biotail = bio;
+	req->hard_bio = req->bio = req->biotail = bio;
+	req->nr_bio_segments = bio_segments(req->bio);
+	req->nr_bio_sectors = bio_sectors(req->bio);
 	req->rq_disk = bio->bi_bdev->bd_disk;
 	req->start_time = jiffies;
 	add_request(q, req, insert_here);
@@ -1985,10 +1991,8 @@
 	if (!rq->bio)
 		return;

-	rq->buffer = bio_data(rq->bio);
-
 	nr_phys_segs = nr_hw_segs = 0;
-	rq_for_each_bio(bio, rq) {
+	rq_for_each_hard_bio(bio, rq) {
 		/* Force bio hw/phys segs to be recalculated. */
 		bio->bi_flags &= ~(1 << BIO_SEG_VALID);

@@ -2004,11 +2008,24 @@
 {
 	if (blk_fs_request(rq)) {
 		rq->hard_sector += nsect;
-		rq->nr_sectors = rq->hard_nr_sectors -= nsect;
-		rq->sector = rq->hard_sector;
+		rq->hard_nr_sectors -= nsect;

-		rq->current_nr_sectors = bio_iovec(rq->bio)->bv_len >> 9;
-		rq->hard_cur_sectors = rq->current_nr_sectors;
+		/*
+		 * Move the I/O submission pointers ahead if required
+		 * (i.e. if the driver doesn't update them).
+		 */
+		if ((rq->nr_sectors >= rq->hard_nr_sectors) &&
+		    (rq->sector <= rq->hard_sector)) {
+			rq->sector = rq->hard_sector;
+			rq->nr_sectors = rq->hard_nr_sectors;
+			rq->bio = rq->hard_bio;
+			rq->nr_bio_segments = bio_segments(rq->bio);
+			rq->nr_bio_sectors = bio_sectors(rq->bio);
+			rq->hard_cur_sectors = bio_cur_sectors(rq->bio);
+			rq->current_nr_sectors = rq->hard_cur_sectors;
+
+			rq->buffer = bio_data(rq->bio);
+		}

 		/*
 		 * if total number of sectors is less than the first segment
@@ -2043,11 +2060,11 @@
 	}

 	total_bytes = bio_nbytes = 0;
-	while ((bio = req->bio)) {
+	while ((bio = req->hard_bio)) {
 		int nbytes;

 		if (nr_bytes >= bio->bi_size) {
-			req->bio = bio->bi_next;
+			req->hard_bio = bio->bi_next;
 			nbytes = bio->bi_size;
 			bio_endio(bio, nbytes, error);
 			next_idx = 0;
@@ -2087,7 +2104,7 @@
 		total_bytes += nbytes;
 		nr_bytes -= nbytes;

-		if ((bio = req->bio)) {
+		if ((bio = req->hard_bio)) {
 			/*
 			 * end more in this run, or just return 'not-done'
 			 */
@@ -2099,7 +2116,7 @@
 	/*
 	 * completely done
 	 */
-	if (!req->bio)
+	if (!req->hard_bio)
 		return 0;

 	/*
@@ -2107,7 +2124,7 @@
 	 */
 	if (bio_nbytes) {
 		bio_endio(bio, bio_nbytes, error);
-		req->bio->bi_idx += next_idx;
+		req->hard_bio->bi_idx += next_idx;
 	}

 	blk_recalc_rq_sectors(req, total_bytes >> 9);
@@ -2181,6 +2198,80 @@
 	__blk_put_request(req->q, req);
 }

+/**
+ * blk_rq_next_segment
+ * @rq:       the request being processed
+ *
+ * Description:
+ *     Points to the next segment in the request if the current segment
+ *     is complete. Leaves things unchanged if this segment is not over
+ *     or if no more segments are left in this request.
+ *
+ *     Meant to be used for bio traversal during I/O submission
+ *     Does not effect any I/O completions or update completion state
+ *     in the request, and does not modify any bio fields.
+ *
+ *     Decrementing rq->nr_sectors, rq->current_nr_sectors and
+ *     rq->nr_bio_sectors as data is transferred is the caller's
+ *     responsibility and should be done before calling this routine.
+ **/
+void blk_rq_next_segment(struct request *rq)
+{
+	if (rq->current_nr_sectors > 0)
+		return;
+
+	if (rq->nr_bio_sectors > 0) {
+		--rq->nr_bio_segments;
+		rq->current_nr_sectors = blk_rq_vec(rq)->bv_len >> 9;
+	} else {
+		if ((rq->bio = rq->bio->bi_next)) {
+			rq->nr_bio_segments = bio_segments(rq->bio);
+			rq->nr_bio_sectors = bio_sectors(rq->bio);
+ 			rq->current_nr_sectors = bio_cur_sectors(rq->bio);
+		}
+ 	}
+
+	/* remember the size of this segment before we start I/O */
+	rq->hard_cur_sectors = rq->current_nr_sectors;
+}
+
+/**
+ * process_that_request_first - process partial request submission
+ * @req:      the request being processed
+ * @nr_sectors: number of sectors I/O has been submitted on
+ *
+ * Description:
+ *     May be used for processing bio's while submitting I/O without
+ *     signalling completion. Fails if more data is requested than is
+ *     available in the request in which case it doesn't advance any
+ *     pointers.
+ *
+ *     Assumes a request is correctly set up. No sanity checks.
+ *
+ * Return:
+ *     0 - no more data left to submit (not processed)
+ *     1 - data available to submit for this request (processed)
+ **/
+int process_that_request_first(struct request *req, unsigned int nr_sectors)
+{
+	unsigned int nsect;
+
+	if (req->nr_sectors < nr_sectors)
+		return 0;
+
+	req->nr_sectors -= nr_sectors;
+	req->sector += nr_sectors;
+	while (nr_sectors) {
+		nsect = min_t(unsigned int, req->current_nr_sectors,
+			      nr_sectors);
+		req->current_nr_sectors -= nsect;
+		req->nr_bio_sectors -= nsect;
+		nr_sectors -= nsect;
+		blk_rq_next_segment(req);
+	}
+	return 1;
+}
+
 int __init blk_dev_init(void)
 {
 	int total_ram = nr_free_pages() << (PAGE_SHIFT - 10);
@@ -2223,6 +2314,7 @@
 EXPORT_SYMBOL(end_that_request_first);
 EXPORT_SYMBOL(end_that_request_chunk);
 EXPORT_SYMBOL(end_that_request_last);
+EXPORT_SYMBOL(process_that_request_first);
 EXPORT_SYMBOL(blk_init_queue);
 EXPORT_SYMBOL(blk_cleanup_queue);
 EXPORT_SYMBOL(blk_queue_make_request);
diff -uNr linux-2.5.66/include/linux/bio.h linux/include/linux/bio.h
--- linux-2.5.66/include/linux/bio.h	Fri Mar 21 14:24:36 2003
+++ linux/include/linux/bio.h	Sat Mar 22 22:52:16 2003
@@ -131,6 +131,7 @@
 #define bio_iovec(bio)		bio_iovec_idx((bio), (bio)->bi_idx)
 #define bio_page(bio)		bio_iovec((bio))->bv_page
 #define bio_offset(bio)		bio_iovec((bio))->bv_offset
+#define bio_segments(bio)	((bio)->bi_vcnt - (bio)->bi_idx)
 #define bio_sectors(bio)	((bio)->bi_size >> 9)
 #define bio_cur_sectors(bio)	(bio_iovec(bio)->bv_len >> 9)
 #define bio_data(bio)		(page_address(bio_page((bio))) + bio_offset((bio)))
@@ -225,12 +226,15 @@
 #ifdef CONFIG_HIGHMEM
 /*
  * remember to add offset! and never ever reenable interrupts between a
- * bio_kmap_irq and bio_kunmap_irq!!
+ * bvec_kmap_irq and bvec_kunmap_irq!!
  *
  * This function MUST be inlined - it plays with the CPU interrupt flags.
  * Hence the `extern inline'.
+ *
+ * We use bio_vec * directly here instead of bio_page(bio) because we also
+ * want to use this function for bio_vec's different than bio->bi_idx one.
  */
-extern inline char *bio_kmap_irq(struct bio *bio, unsigned long *flags)
+extern inline char *bvec_kmap_irq(struct bio_vec *bvec, unsigned long *flags)
 {
 	unsigned long addr;

@@ -239,15 +243,15 @@
 	 * balancing is a lot nicer this way
 	 */
 	local_save_flags(*flags);
-	addr = (unsigned long) kmap_atomic(bio_page(bio), KM_BIO_SRC_IRQ);
+	addr = (unsigned long) kmap_atomic(bvec->bv_page, KM_BIO_SRC_IRQ);

 	if (addr & ~PAGE_MASK)
 		BUG();

-	return (char *) addr + bio_offset(bio);
+	return (char *) addr + bvec->bv_offset;
 }

-extern inline void bio_kunmap_irq(char *buffer, unsigned long *flags)
+extern inline void bvec_kunmap_irq(char *buffer, unsigned long *flags)
 {
 	unsigned long ptr = (unsigned long) buffer & PAGE_MASK;

@@ -256,8 +260,20 @@
 }

 #else
-#define bio_kmap_irq(bio, flags)	(bio_data(bio))
-#define bio_kunmap_irq(buf, flags)	do { *(flags) = 0; } while (0)
+#define bvec_kmap_irq(bvec, flags)	(page_address((bvec)->bv_page) + (bvec)->bv_offset)
+#define bvec_kunmap_irq(buf, flags)	do { *(flags) = 0; } while (0)
 #endif

+extern inline char *__bio_kmap_irq(struct bio *bio, unsigned short idx,
+				   unsigned long *flags)
+{
+	return bvec_kmap_irq(bio_iovec_idx(bio, idx), flags);
+}
+#define __bio_kunmap_irq		bvec_kunmap_irq
+
+/* Will be removed soon. */
+#define bio_kmap_irq(bio, flags) \
+	__bio_kmap_irq((bio), (bio)->bi_idx, (flags))
+#define bio_kunmap_irq			__bio_kunmap_irq
+
 #endif /* __LINUX_BIO_H */
diff -uNr linux-2.5.66/include/linux/blk.h linux/include/linux/blk.h
--- linux-2.5.66/include/linux/blk.h	Fri Mar 21 14:23:25 2003
+++ linux/include/linux/blk.h	Sat Mar 22 22:50:06 2003
@@ -43,6 +43,7 @@
 extern int end_that_request_first(struct request *, int, int);
 extern int end_that_request_chunk(struct request *, int, int);
 extern void end_that_request_last(struct request *);
+extern int process_that_request_first(struct request *, unsigned int);
 struct request *elv_next_request(request_queue_t *q);

 static inline void blkdev_dequeue_request(struct request *req)
diff -uNr linux-2.5.66/include/linux/blkdev.h linux/include/linux/blkdev.h
--- linux-2.5.66/include/linux/blkdev.h	Fri Mar 21 14:23:25 2003
+++ linux/include/linux/blkdev.h	Sat Mar 22 22:50:06 2003
@@ -10,6 +10,7 @@
 #include <linux/pagemap.h>
 #include <linux/backing-dev.h>
 #include <linux/wait.h>
+#include <linux/bio.h>

 #include <asm/scatterlist.h>

@@ -33,9 +34,28 @@
 				     * blkdev_dequeue_request! */
 	unsigned long flags;		/* see REQ_ bits below */

-	sector_t sector;
-	unsigned long nr_sectors;
+	/* Maintain bio traversal state for part by part I/O submission.
+	 * hard_* are block layer internals, no driver should touch them!
+	 */
+
+	sector_t sector;		/* next sector to submit */
+	unsigned long nr_sectors;	/* no. of sectors left to submit */
+
+	sector_t hard_sector;		/* next sector to complete */
+	unsigned long hard_nr_sectors;	/* no. of sectors left to complete */
+
+	/* no. of segments left to submit in the current bio */
+	unsigned short nr_bio_segments;
+	/* no. of sectors left to submit in the current bio */
+	unsigned long nr_bio_sectors;
+	/* no. of sectors left to submit in the current segment */
 	unsigned int current_nr_sectors;
+	/* no. of sectors left to complete in the current segment */
+ 	unsigned int hard_cur_sectors;
+
+	struct bio *bio;		/* next bio to submit */
+	struct bio *hard_bio;		/* next unfinished bio to complete */
+	struct bio *biotail;

 	void *elevator_private;

@@ -43,15 +63,6 @@
 	struct gendisk *rq_disk;
 	int errors;
 	unsigned long start_time;
-	sector_t hard_sector;		/* the hard_* are block layer
-					 * internals, no driver should
-					 * touch them
-					 */
-	unsigned long hard_nr_sectors;
-	unsigned int hard_cur_sectors;
-
-	struct bio *bio;
-	struct bio *biotail;

 	/* Number of scatter-gather DMA addr+len pairs after
 	 * physical address coalescing is performed.
@@ -282,6 +293,32 @@
  */
 #define blk_queue_headactive(q, head_active)

+/* current index into bio being processed for submission */
+#define blk_rq_idx(rq)	((rq)->bio->bi_vcnt - (rq)->nr_bio_segments)
+
+/* current bio vector being processed */
+#define blk_rq_vec(rq)	(bio_iovec_idx((rq)->bio, blk_rq_idx(rq)))
+
+/*
+ * temporarily mapping a (possible) highmem bio (typically for PIO transfer)
+ */
+
+/* current offset with respect to start of the segment being submitted */
+#define blk_rq_offset(rq) \
+	(((rq)->hard_cur_sectors - (rq)->current_nr_sectors) << 9)
+
+/* Assumes rq->bio != NULL */
+static inline char * rq_map_buffer(struct request *rq, unsigned long *flags)
+{
+	return (__bio_kmap_irq(rq->bio, blk_rq_idx(rq), flags)
+		+ blk_rq_offset(rq));
+}
+
+static inline void rq_unmap_buffer(char *buffer, unsigned long *flags)
+{
+	__bio_kunmap_irq(buffer, flags);
+}
+
 /*
  * q->prep_rq_fn return values
  */
@@ -319,6 +356,10 @@
 	if ((rq->bio))			\
 		for (bio = (rq)->bio; bio; bio = bio->bi_next)

+#define rq_for_each_hard_bio(bio, rq)	\
+	if ((rq->hard_bio))		\
+		for (bio = (rq)->hard_bio; bio; bio = bio->bi_next)
+
 struct sec_size {
 	unsigned block_size;
 	unsigned block_size_bits;
diff -uNr linux-2.5.66/mm/highmem.c linux/mm/highmem.c
--- linux-2.5.66/mm/highmem.c	Tue Mar 25 22:53:11 2003
+++ linux/mm/highmem.c	Tue Mar 25 23:51:01 2003
@@ -431,7 +431,7 @@
 	bio->bi_rw = (*bio_orig)->bi_rw;

 	bio->bi_vcnt = (*bio_orig)->bi_vcnt;
-	bio->bi_idx = 0;
+	bio->bi_idx = (*bio_orig)->bi_idx;
 	bio->bi_size = (*bio_orig)->bi_size;

 	if (pool == page_pool) {


