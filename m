Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311642AbSCNQFr>; Thu, 14 Mar 2002 11:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311645AbSCNQFd>; Thu, 14 Mar 2002 11:05:33 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:17619 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S311643AbSCNQFK>; Thu, 14 Mar 2002 11:05:10 -0500
Date: Thu, 14 Mar 2002 21:36:11 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, andre@linux-ide.org,
        bcrl@redhat.com
Subject: Re: 2.5.6: ide driver broken in PIO mode
Message-ID: <20020314213611.A1884@in.ibm.com>
Reply-To: suparna@in.ibm.com
In-Reply-To: <Pine.LNX.4.21.0203131339050.26768-100000@serv> <a6o30m$25j$1@penguin.transmeta.com> <20020313203408.GD20220@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020313203408.GD20220@suse.de>; from axboe@suse.de on Wed, Mar 13, 2002 at 09:34:08PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today was one of those days when I didn't get time to look through 
lkml, and almost missed this thread.  Thanks Andre, for mentioning 
it to me. 

On Wed, Mar 13, 2002 at 09:34:08PM +0100, Jens Axboe wrote:
> On Wed, Mar 13 2002, Linus Torvalds wrote:
> > In article <Pine.LNX.4.21.0203131339050.26768-100000@serv>,
> > Roman Zippel  <zippel@linux-m68k.org> wrote:
> > >
> > >I first noticed the problem on my Amiga, but I can reproduce it on an ia32
> > >machine, when I turn off dma with hdparm.
> > 
> > With PIO, the current IDE/bio stuff doesn't like the write-multiple
> > interface and has bad interactions. 
> > 
> > Jens, you talked about a patch from Supparna two weeks ago, any
> > progress?
> 
> I can fix this tomorrow, the stuff from Supparna was just a small bio
> helper to retrieve the segments in a request. Just what we need for
> write-multi.
> 

That's sort of it. It's just at bio/rq level - I haven't touched 
IDE (don't have that expertise). 

However, the latest code I have also covers the avoidance of bv_len, 
bv_offset modifications by the block layer, which I'd been 
concerned about for quite a while and ought to have done something about 
much sooner ;) With this change one can safetly stick in a kvec in a 
bio for example and possibly perform a copyout or something post i/o 
using the same descriptors. (Ben, this is a FYI for you)

Anyway, here is the last patch I had sent to Andre (Jens, this is 
more recent than the earlier helper snippets). It is based on 2.5.5 
though, and I have only tried it on a SCSI system for regression 
(no real testing, just tried booting the kernel and working with it). 
Some changes are needed in IDE so it works with this (see rq_map_buffer
and comments later). So there's work to go.

I wanted to wait till Andre got to integrate this with IDE along
with his modifications and let me know if it really helps solve 
the problem and addresses the requirements he's been highlighting 
all this while. The interfaces need to be refined in accordance with
that feedback, and this patch is incomplete without those IDE
changes. But now that the discussion has caught on, thought I'd share it 
as is anyway for feedback etc ... in the meantime. 
(Caution: Don't try it as is on an IDE system right now, unless
you modify ide_map_buffer as discussed below ...)

Jens, could you check the comment on blk_rq_recalc_segments during
end_that_request_first ? I remember having discussed this with you
long back, but now I can't recall the situations where we need to
recalculate the segments for a request that is being processed.

Regards
Suparna

---------------------------------------------------------------


Description
-------------

(a) Have added a couple of fields (rq->hard_bio and bio->bi_hard_idx). 
So now:

1.Fields rq->hard_bio, rq->hard_bio->bi_hard_idx, rq->hard_cur_sectors, 
  rq->hard_sector and rq->hard_nr_sectors are the ones which get updated
  on true i/o completion, i.e. when end_that_request_first is called.
  These constitute the state that indicates which parts of the request
  are yet to finish.

2. Fields rq->bio, rq->bio->bi_idx, rq->current_nr_sectors, rq->sector
  and rq->nr_sectors are the ones used for keeping track of i/o
  submission (i.e. these consitute the state that indicates which parts
  of the request are yet to be submitted).
  These are the fields which a driver would use when processing requests.

3. end_that_request_first now operates on the *hard* values, but it 
  also takes care of bringing the submission pointers up-to-date if
  they are still behind.
  (So, if the submission pointers are ahead of the current completion
   pointers, then end_that_request_first would leave them alone)

(b) No longer modify bv_len, bv_offset fields during i/o completion or
   submission. Thus the mapping provided by bio_map_irq always reflects
   the start of the segment. 
   (This affects ide_map_buffer. Now there is a new macro rq_map_buffer
    which does this correctly. IDE may need to be updated accordingly)

   We can find out our relative offset wrt the start of the segment 
   through the following computation:
	bv_len - current_nr_sectors << 9  


(c) New routines

Let me know if the comments or the naming doesn't describe the intent
correctly - this part needs some work. I haven't actually used them 
in the code as yet, so do be careful if you try them out.
I know I need to refine this part of the code.

- blk_rq_next_segment (this name might be confusing as all it really 
  does is move the pointers to point to the start of the next segment 
  if we are already at the end of the last segment
  - suggestions required for a better name !)
- process_that_request_first (don't really like it as it is right 
  now; just put it in to illustrate how blk_rq_next_segment 
  could be used - need to work out better and more efficient semantics
  for this)
- rq_map_buffer  (along the lines of what ide_map_buffer did)
- rq_unmap_buffer 


Regards
Suparna

--------- Cut here (biotraverse.patch) -------------

diff -ur pure-255/drivers/block/ll_rw_blk.c /usr/src/linux255-bio/drivers/block/ll_rw_blk.c
--- pure-255/drivers/block/ll_rw_blk.c	Mon Mar  4 20:55:30 2002
+++ /usr/src/linux255-bio/drivers/block/ll_rw_blk.c	Wed Mar  6 14:09:06 2002
@@ -1550,16 +1550,30 @@
 	rq->nr_hw_segments = nr_hw_segs;
 }
 
-inline void blk_recalc_rq_sectors(struct request *rq, int nsect)
+void blk_recalc_rq_sectors(struct request *rq, int nsect)
 {
 	if (rq->flags & REQ_CMD) {
+		BIO_BUG_ON(rq->hard_cur_sectors < nsect);
+		BIO_BUG_ON(rq->hard_bio->bi_hard_idx >= rq->hard_bio->bi_vcnt);
 		rq->hard_sector += nsect;
 		rq->hard_nr_sectors -= nsect;
-		rq->sector = rq->hard_sector;
-		rq->nr_sectors = rq->hard_nr_sectors;
-
-		rq->current_nr_sectors = bio_iovec(rq->bio)->bv_len >> 9;
-		rq->hard_cur_sectors = rq->current_nr_sectors;
+		rq->hard_cur_sectors -= nsect;
+		if ((rq->hard_cur_sectors == 0) && rq->hard_nr_sectors) {
+			rq->hard_cur_sectors = bio_iovec_idx(
+			rq->hard_bio, rq->hard_bio->bi_hard_idx)->bv_len >> 9;
+		} 
+			
+		/* Move the i/o submission pointers ahead if required  */
+		if ((rq->nr_sectors >= rq->hard_nr_sectors) && 
+		(rq->sector <= rq->hard_sector)){
+			rq->sector = rq->hard_sector;
+			rq->nr_sectors = rq->hard_nr_sectors;
+			rq->current_nr_sectors = rq->hard_cur_sectors;
+			rq->bio = rq->hard_bio;
+			rq->bio->bi_idx = rq->bio->bi_hard_idx;
+			rq->buffer = bio_data(rq->bio) + 
+			bio_iovec(rq->bio)->bv_len - rq->current_nr_sectors;
+		}		
 
 		/*
 		 * if total number of sectors is less than the first segment
@@ -1592,17 +1606,19 @@
 	int nsect, total_nsect;
 	struct bio *bio;
 
+
 	req->errors = 0;
 	if (!uptodate)
 		printk("end_request: I/O error, dev %s, sector %lu\n",
 			kdevname(req->rq_dev), req->sector);
 
 	total_nsect = 0;
-	while ((bio = req->bio)) {
-		nsect = bio_iovec(bio)->bv_len >> 9;
 
-		BIO_BUG_ON(bio_iovec(bio)->bv_len > bio->bi_size);
+	/* our starting point may be in the middle of a segment */
+	while ((bio = req->hard_bio)) {
 
+		nsect = req->hard_cur_sectors; 
+		BIO_BUG_ON(nsect > bio->bi_size);
 		/*
 		 * not a complete bvec done
 		 */
@@ -1610,38 +1626,43 @@
 			int residual = (nsect - nr_sectors) << 9;
 
 			bio->bi_size -= residual;
-			bio_iovec(bio)->bv_offset += residual;
-			bio_iovec(bio)->bv_len -= residual;
 			blk_recalc_rq_sectors(req, nr_sectors);
-			blk_recalc_rq_segments(req);
+
+			/* 
+			 * Could we just do without recalc segments ?
+			 *- Suparna 
+			 *blk_recalc_rq_segments(req);
+			 */
 			return 1;
 		}
 
 		/*
 		 * account transfer
 		 */
-		bio->bi_size -= bio_iovec(bio)->bv_len;
-		bio->bi_idx++;
+		bio->bi_size -= nsect << 9;
+		bio->bi_hard_idx++;
 
 		nr_sectors -= nsect;
 		total_nsect += nsect;
 
 		if (!bio->bi_size) {
-			req->bio = bio->bi_next;
-
+			req->hard_bio = bio->bi_next;
 			bio_endio(bio, uptodate);
-
 			total_nsect = 0;
 		}
 
-		if ((bio = req->bio)) {
+		if ((bio = req->hard_bio)) {
 			blk_recalc_rq_sectors(req, nsect);
 
 			/*
 			 * end more in this run, or just return 'not-done'
 			 */
 			if (unlikely(nr_sectors <= 0)) {
-				blk_recalc_rq_segments(req);
+				/* 
+				 * Could we just do without recalc segments ?
+				 * - Suparna 
+				 * blk_recalc_rq_segments(req);
+				 */
 				return 1;
 			}
 		}
diff -ur pure-255/include/linux/bio.h /usr/src/linux255-bio/include/linux/bio.h
--- pure-255/include/linux/bio.h	Mon Mar  4 20:57:52 2002
+++ /usr/src/linux255-bio/include/linux/bio.h	Mon Mar  4 20:18:54 2002
@@ -68,6 +68,7 @@
 
 	unsigned short		bi_vcnt;	/* how many bio_vec's */
 	unsigned short		bi_idx;		/* current index into bvl_vec */
+	unsigned short		bi_hard_idx;	/* next unfinished vec */
 
 	/* Number of segments in this BIO after
 	 * physical address coalescing is performed.
diff -ur pure-255/include/linux/blk.h /usr/src/linux255-bio/include/linux/blk.h
--- pure-255/include/linux/blk.h	Mon Mar  4 20:56:13 2002
+++ /usr/src/linux255-bio/include/linux/blk.h	Tue Mar  5 17:31:19 2002
@@ -52,6 +52,7 @@
 extern inline struct request *elv_next_request(request_queue_t *q)
 {
 	struct request *rq;
+	struct bio *bio;
 
 	while ((rq = __elv_next_request(q))) {
 		rq->flags |= REQ_STARTED;
@@ -59,6 +60,11 @@
 		if (&rq->queuelist == q->last_merge)
 			q->last_merge = NULL;
 
+		/* Remember where we are to start with */
+		rq->hard_bio = rq->bio;
+		rq_for_each_bio(bio, rq)
+			bio->bi_hard_idx = bio->bi_idx;
+		
 		if ((rq->flags & REQ_DONTPREP) || !q->prep_rq_fn)
 			break;
 
@@ -403,6 +409,35 @@
 	blkdev_dequeue_request(req);
 	end_that_request_last(req);
 }
+
+/*
+ * May be used for processing bio's while submitting i/o without
+ * signalling completion. Fails if more data is requested than is
+ * available in the request in which case it doesn't advance any
+ * pointers.
+ * (Assumes a request is correctly set up. No sanity checks)
+ */
+extern inline int process_that_request_first(struct request *req, 
+	int nr_sectors)
+{
+	if (req->nr_sectors < nr_sectors)
+		return 0;
+
+	req->nr_sectors -= nr_sectors;
+	req->sector += nr_sectors;
+	while (nr_sectors) {
+		if (req->current_nr_sectors >= nr_sectors ) {
+			req->current_nr_sectors -= nr_sectors;
+			nr_sectors = 0;
+		} else {
+			nr_sectors -= req->current_nr_sectors;
+			req->current_nr_sectors = 0;
+		}
+		blk_rq_next_segment(req);
+	}
+	return 1;
+}
+
 
 #endif /* ! SCSI_BLK_MAJOR(MAJOR_NR) */
 #endif /* LOCAL_END_REQUEST */
diff -ur pure-255/include/linux/blkdev.h /usr/src/linux255-bio/include/linux/blkdev.h
--- pure-255/include/linux/blkdev.h	Mon Mar  4 20:56:21 2002
+++ /usr/src/linux255-bio/include/linux/blkdev.h	Mon Mar  4 20:27:02 2002
@@ -59,7 +59,9 @@
 	void *special;
 	char *buffer;
 	struct completion *waiting;
-	struct bio *bio, *biotail;
+	struct bio *bio; /* next bio to submit */
+	struct bio *biotail; 
+	struct bio *hard_bio; /* next unfinished bio */
 	request_queue_t *q;
 	struct request_list *rl;
 };
@@ -222,6 +224,53 @@
  * scheduler -- see elv_next_request
  */
 #define blk_queue_headactive(q, head_active)
+
+
+/*
+ * temporarily mapping a (possible) highmem bio for typically for PIO transfer
+ */
+
+/* offset with respect to start of the segment */
+#define blk_rq_offset(rq) (bio_iovec((rq)->bio)->bv_len - ((rq)->current_nr_sectors << 9))
+
+extern inline void *rq_map_buffer(struct request *rq, unsigned long *flags)
+{
+	return bio_kmap_irq(rq->bio, flags) + blk_rq_offset(rq);
+}
+
+extern inline void rq_unmap_buffer(char *buffer, unsigned long *flags)
+{
+	bio_kunmap_irq(buffer, flags);
+}
+
+
+/*
+ * Points to the next segment in the request if the current segment
+ * is complete. Leaves things unchanged if this segment is not over or
+ * if no more segments are left in this request.
+ * Meant to be used for bio traversal during i/o submission
+ * Does not effect any i/o completions, and does not touch any of the 
+ * hard* values in the request or bio
+ * (Decrementing rq->nr_sectors and rq->current_nr_sectors as data is
+ * transferred is the caller's responsibility)
+ */
+extern inline void blk_rq_next_segment(struct request *rq)
+{
+ 	if (rq->current_nr_sectors <= 0) {
+ 		struct bio *bio = rq->bio;
+ 		
+ 		if (bio->bi_idx < bio->bi_vcnt - 1) {
+ 			bio->bi_idx++;
+ 		} else {
+ 			bio = bio->bi_next;			
+ 		}
+		if (bio) {
+ 			rq->bio = bio;
+ 			rq->current_nr_sectors = bio_iovec(bio)->bv_len >> 9; 
+		} 
+ 	}
+}
+
 
 extern unsigned long blk_max_low_pfn, blk_max_pfn;
 

