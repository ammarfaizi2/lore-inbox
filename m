Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313743AbSHBNQ6>; Fri, 2 Aug 2002 09:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313687AbSHBNQ6>; Fri, 2 Aug 2002 09:16:58 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:45499 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S313638AbSHBNQt>; Fri, 2 Aug 2002 09:16:49 -0400
Date: Fri, 2 Aug 2002 18:50:11 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, axboe@kernel.org
Subject: Re: [PATCH] Bio Traversal Changes (Patch 4/4: biotr8-doc.diff)
Message-ID: <20020802185011.A1923@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20020802180513.A1802@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020802180513.A1802@in.ibm.com>; from suparna@in.ibm.com on Fri, Aug 02, 2002 at 06:05:13PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And lastly, a patch to the documentation ...


diff -ur linux-2.5.30-pure/Documentation/block/biodoc.txt linux-2.5.30-bio/Documentation/block/biodoc.txt
--- linux-2.5.30-pure/Documentation/block/biodoc.txt	Sat Jul 27 08:28:31 2002
+++ linux-2.5.30-bio/Documentation/block/biodoc.txt	Fri Aug  2 16:46:19 2002
@@ -5,7 +5,7 @@
 	Jens Axboe <axboe@suse.de>
 	Suparna Bhattacharya <suparna@in.ibm.com>
 
-Last Updated May 2, 2002
+Last Updated August 2, 2002
 
 Introduction:
 
@@ -204,8 +204,8 @@
 which case a virtual mapping of the page is required. For SCSI it is also
 done in some scenarios where the low level driver cannot be trusted to
 handle a single sg entry correctly. The driver is expected to perform the
-kmaps as needed on such occasions using the bio_kmap and bio_kmap_irq
-routines as appropriate. A driver could also use the blk_queue_bounce()
+kmaps as needed on such occasions using the rq_map_buffer() routine
+as appropriate. A driver could also use the blk_queue_bounce()
 routine on its own to bounce highmem i/o to low memory for specific requests
 if so desired.
 
@@ -399,7 +399,8 @@
  directly by hand.
  This is because end_that_request_first only iterates over the bio list,
  and always returns 0 if there are none associated with the request.
- _last works OK in this case, and is not a problem, as I mentioned earlier
+ end_that_request_last works OK in this case, and is not a problem, 
+ as mentioned earlier
 >
 
 1.3.1 Pre-built Commands
@@ -508,8 +509,9 @@
 
        unsigned int	bi_vcnt;     /* how may bio_vec's */
        unsigned int	bi_idx;		/* current index into bio_vec array */
-
-       unsigned int	bi_size;     /* total size in bytes */
+       unsigned short	bi_voffset;	/* current vec offset */	
+       unsigned short   bi_endvoffset;	/* last vec's end offset */
+       unsigned int	bi_size;     /* total residual size in bytes */
        unsigned short 	bi_phys_segments; /* segments after physaddr coalesce*/
        unsigned short	bi_hw_segments; /* segments after DMA remapping */
        unsigned int	bi_max;	     /* max bio_vecs we can hold
@@ -554,13 +556,58 @@
 way). There is a helper routine (blk_rq_map_sg) which drivers can use to build
 the sg list.
 
-Note: Right now the only user of bios with more than one page is ll_rw_kio,
-which in turn means that only raw I/O uses it (direct i/o may not work
-right now). The intent however is to enable clustering of pages etc to
-become possible. The pagebuf abstraction layer from SGI also uses multi-page
-bios, but that is currently not included in the stock development kernels.
-The same is true of Andrew Morton's work-in-progress multipage bio writeout 
-and readahead patches.
+The following fields have been introduced in the bio structure 
+to enable setting up a bio which starts in the middle of an entry
+of an existing io_vec without having to make a copy of the iovec 
+descriptor. This could for example be used by drivers like lvm/md
+when it has to split a single bio (using the bio cloning function
+described later) for striping i/o across multiple devices. 
+
+bi_voffset: 
+
+Offset relative to the start of the first page, which 
+indicates where the bio really starts. In general before 
+i/o starts this would be the same as bv_offset for the 
+first vec (at bi_idx), but in the case of clone bio s where 
+the bio may be split in the middle of a segment this could be 
+different. As i/o progresses, now instead of changing any
+of the bvec fields, bi_voffset is moved ahead instead.
+
+The relative offset w.r.t to the start of the first vec
+can be calculated using the macro bio_startoffset(bio)
+
+bi_endvoffset: 
+
+Offset relative to the last page which indicates
+where the bio really ends. In general this would be the same
+as bv_offset + bv_len for the last vec, but in the case of
+clone bio s where a split piece ends in the middle of a 
+segment, it could be different. This field is really used 
+mainly for segment boundary and merge checks (it is more 
+convenient than having to walk through the entire bio 
+and use bi_size to determine the end just to determine
+mergeability).
+
+The macro bio_endoffset(bio) can be used calculate the
+relative offset w.r.t to the bvec end where the bio
+was broken up.
+
+The remaining size to be transfered in the current bio
+vec should be calculated using the bio_segsize() routine
+(instead of accessing bv_len directly any more). This
+takes care of adjusting the length for the above offsets.
+
+Aside:
+An alternative to bi_voffset being an absolute 
+offset wrt to the start of the bvec page would be to
+make it relative to bio_io_vec(bio)->bv_offset instead
+(i.e. the value bio_startoffset() returns in the patch). A
+similar change would then apply to bi_endvoffset. Then
+the fields would be initialized to zero by default,
+though it also would make the mergeability check macros 
+a little longer, and possibly add a little extra computation 
+during request mapping and end_that_request_first.
+
 
 2.3 Changes in the Request Structure
 
@@ -609,11 +656,20 @@
 	unsigned short nr_hw_segments;
 
 	/* Various sector counts */
+	/* 
+	 * The various block internal copies represent counts/pointers of
+	 * unfinished i/o, while the other counts/pointers refer to 
+ 	 * i/o to be submitted.
+	 */
 	unsigned long nr_sectors;  /* no. of sectors left: driver modifiable */
-	unsigned long hard_nr_sectors;  /* block internal copy of above */
+	unsigned long hard_nr_sectors;  /* block internal copy of the above */
 	unsigned int current_nr_sectors; /* no. of sectors left in the
 					   current segment:driver modifiable */
 	unsigned long hard_cur_sectors; /* block internal copy of the above */
+
+	unsigned short nr_bio_segments; /* no of segments left in curr bio */
+	unsigned short nr_bio_sectors; /* no of sectors left in curr bio */
+	
 	.
 	.
 	int tag;	/* command tag associated with request */
@@ -623,6 +679,7 @@
 	.
 	.
 	struct bio *bio, *biotail;  /* bio list instead of bh */
+	struct bio *hard_bio; /* block internal copy */
 	struct request_list *rl;
 }
 	
@@ -641,9 +698,11 @@
 transfer and invokes block end*request helpers to mark this. The
 driver should not modify these values. The block layer sets up the
 nr_sectors and current_nr_sectors fields (based on the corresponding
-hard_xxx values and the number of bytes transferred) and updates it on
-every transfer that invokes end_that_request_first. It does the same for the
-buffer, bio, bio->bi_idx fields too.
+hard_xxx values and the number of bytes transferred) and typically 
+updates it on every transfer that invokes end_that_request_first,
+unless the driver has advanced these (submission) counters ahead 
+of the sectors being completed. The block layer also advances the 
+buffer, bio, bio->bi_idx fields appropriately as well as i/o completes. 
 
 The buffer field is just a virtual address mapping of the current segment
 of the i/o buffer in cases where the buffer resides in low-memory. For high
@@ -653,6 +712,61 @@
 a driver needs to be careful about interoperation with the block layer helper
 functions which the driver uses. (Section 1.3)
 
+
+2.3.1 The Separation of Submission and Completion State
+
+The basic protocol followed all through is that the bio fields 
+would always reflect the status w.r.t how much i/o remains
+to be completed. On the other hand submission status would
+only be maintained in the request structure. In most cases
+of course, both move in sync (the generic end_request_first
+code tries to handle that transparently by advancing the 
+submission pointers if they are behind the completion pointers
+as would happen in the case of drivers which don't modify
+those themselves), but for things like IDE mult-count write, 
+the submission counters/pointers may be ahead of the 
+completion pointers.  
+
+The following fields have been added to the request structure
+to help maintain this distinction.
+
+rq->hard_bio
+	the rq->bio field now reflects the next bio which
+is to be submitted for i/o. Hence, the need for rq->hard_bio
+which keeps track of the next bio to be completed (this
+is the one used by end_that_request_first now, instead
+of rq->bio)
+
+rq->nr_bio_segments
+	this keeps track of how many more vecs remain 
+to be submitted in the current bio (rq->bio). It is
+used to compute the current index into rq->bio which
+specifies the segment under submission. 
+(rq_map_buffer for example uses this field to map
+the right buffer)
+
+rq->nr_bio_sectors
+	this keeps track of the number of sectors to
+be submitted in the current bio (rq->bio). It can be
+used to compute the remaining sectors in the current
+segment in the situation when it is the last segment.
+
+Now a subtle point about hard_cur_sectors. It reflects
+the number of sectors left to be completed in the
+_current_ segment under submission (i.e. the segment
+in rq->bio, and _not_ rq->hard_bio). This makes it
+possible to use it in rq_map_buffer to determine the
+relative offset in the current segment w.r.t what 
+the bio indices might indicate.
+
+A new helper, process_that_request_first() has been 
+introduced for updating submission state of the request 
+without completing the corresponding bios. It can be used 
+by code such as mult-count write which need to traverse
+multiple bio segments for each chunk of i/o submitted,
+where multiple such chunk transfers are required to cover 
+the entire request.
+
 3. Using bios
 
 3.1 Setup/Teardown
@@ -718,7 +832,7 @@
 
 3.2.1 Traversing segments and completion units in a request
 
-The macros bio_for_each_segment() and rq_for_each_bio() should be used for
+The macros bio_for_each_segment() and rq_for_each_bio() could be used for
 traversing the bios in the request list (drivers should avoid directly
 trying to do it themselves). Using these helpers should also make it easier
 to cope with block changes in the future.
@@ -727,11 +841,28 @@
 		bio_for_each_segment(bio_vec, bio, i)
 			/* bio_vec is now current segment */
 
+Notice that where bi_voffset differs from bv_offset of the first
+bvec, the current segment might start somewhere inside the current 
+bio_vec. The macros bio_startoffset() and bio_endoffset() help
+finding out the relative offsets into the start and end of the 
+vectors where the bio really starts and ends.
+
 I/O completion callbacks are per-bio rather than per-segment, so drivers
 that traverse bio chains on completion need to keep that in mind. Drivers
 which don't make a distinction between segments and completion units would
 need to be reorganized to support multi-segment bios.
 
+It is recommended that drivers utilize the block layer routines 
+process_that_request_first() while traversing bios for i/o submission,
+instead of iterating over the segments directly, and use 
+end_that_request_first() for completion as before. Things like 
+rq_map_buffer() rely on the submission pointers in the request 
+to map the correct buffer.
+
+rq_map_buffer() could be used to get a virtual address mapping
+for the current segment buffer, in drivers which use PIO for 
+example.
+
 3.2.2 Setting up DMA scatterlists
 
 The blk_rq_map_sg() helper routine would be used for setting up scatter
@@ -751,6 +882,7 @@
   memory segments that the driver can handle (phys_segments) and the
   number that the underlying hardware can handle at once, accounting for
   DMA remapping (hw_segments)  (i.e. IOMMU aware limits).
+- Accounts for bi_voffset/bi_endvoffset for arbitrary bio
 
 Routines which the low level driver can use to set up the segment limits:
 
@@ -905,36 +1037,18 @@
 perform the i/o on each of these.
 
 The embedded bh array in the kiobuf structure has been removed and no
-preallocation of bios is done for kiobufs. [The intent is to remove the
-blocks array as well, but it's currently in there to kludge around direct i/o.]
-Thus kiobuf allocation has switched back to using kmalloc rather than vmalloc.
-
-Todo/Observation:
-
- A single kiobuf structure is assumed to correspond to a contiguous range
- of data, so brw_kiovec() invokes ll_rw_kio for each kiobuf in a kiovec.
- So right now it wouldn't work for direct i/o on non-contiguous blocks.
- This is to be resolved.  The eventual direction is to replace kiobuf
- by kvec's.
-
- Badari Pulavarty has a patch to implement direct i/o correctly using
- bio and kvec.
+preallocation of bios is done for kiobufs. 
 
+Note: Direct i/o no longer uses kiobufs any more though, and instead
+directly builds up bios and submits then to the block layer.
 
 (c) Page i/o:
-Todo/Under discussion:
 
- Andrew Morton's multi-page bio patches attempt to issue multi-page
- writeouts (and reads) from the page cache, by directly building up
- large bios for submission completely bypassing the usage of buffer
- heads. This work is still in progress.
-
- Christoph Hellwig had some code that uses bios for page-io (rather than
- bh). This isn't included in bio as yet. Christoph was also working on a
- design for representing virtual/real extents as an entity and modifying
- some of the address space ops interfaces to utilize this abstraction rather
- than buffer_heads. (This is somewhat along the lines of the SGI XFS pagebuf
- abstraction, but intended to be as lightweight as possible).
+There now is generic support for multi-page writeouts (and reads) 
+from the page cache by directly building up a sequence of large bios 
+and submitting them in a pipelined manner. This does away with
+the use of buffer heads for page i/o.
+
 
 (d) Direct access i/o:
 Direct access requests that do not contain bios would be submitted differently
@@ -954,14 +1068,6 @@
   cloning, in this case rather than PRE_BUILT bio_vecs, we set the bi_io_vec
   array pointer to point to the veclet array in kvecs.
 
-  TBD: In order for this to work, some changes are needed in the way multi-page
-  bios are handled today. The values of the tuples in such a vector passed in
-  from higher level code should not be modified by the block layer in the course
-  of its request processing, since that would make it hard for the higher layer
-  to continue to use the vector descriptor (kvec) after i/o completes. Instead,
-  all such transient state should either be maintained in the request structure,
-  and passed on in some way to the endio completion routine.
-
 
 4. The I/O scheduler
 
@@ -972,7 +1078,7 @@
 ii.  improved latency
 iii. better utilization of h/w & CPU time
 
-Characteristics:
+4.1 Characteristics:
 
 i. Linked list for O(n) insert/merge (linear scan) right now
 
@@ -1046,12 +1152,6 @@
   multi-page bios being queued in one shot, we may not need to wait to merge
   a big request from the broken up pieces coming by.
 
-  Per-queue granularity unplugging (still a Todo) may help reduce some of the
-  concerns with just a single tq_disk flush approach. Something like
-  blk_kick_queue() to unplug a specific queue (right away ?)
-  or optionally, all queues, is in the plan.
-
-
 5. Scalability related changes
 
 5.1 Granular Locking: io_request_lock replaced by a per-queue lock
@@ -1147,9 +1247,8 @@
 PIO drivers (or drivers that need to revert to PIO transfer once in a
 while (IDE for example)), where the CPU is doing the actual data
 transfer a virtual mapping is needed. If the driver supports highmem I/O,
-(Sec 1.1, (ii) ) it needs to use bio_kmap and bio_kmap_irq to temporarily
-map a bio into the virtual address space. See how IDE handles this with
-ide_map_buffer.
+(Sec 1.1, (ii) ) it needs to use rq_map_buffer() to temporarily
+map a bio into the virtual address space. See how IDE handles this.
 
 
 8. Prior/Related/Impacted patches
diff -ur linux-2.5.30-pure/Documentation/block/request.txt linux-2.5.30-bio/Documentation/block/request.txt
--- linux-2.5.30-pure/Documentation/block/request.txt	Sat Jul 27 08:28:41 2002
+++ linux-2.5.30-bio/Documentation/block/request.txt	Fri Aug  2 11:54:58 2002
@@ -52,11 +52,15 @@
 
 sector_t sector			DBI	Target location
 
-unsigned long hard_nr_sectors	B	Used to keep sector sane
+unsigned long hard_sector	B	Used to keep sector sane
+					Tracks the location of unfinished 
+					portion
 
 unsigned long nr_sectors	DBI	Total number of sectors in request
 
 unsigned long hard_nr_sectors	B	Used to keep nr_sectors sane
+					Tracks no of unfinished sectors in
+					the request
 
 unsigned short nr_phys_segments	DB	Number of physical scatter gather
 					segments in a request
@@ -68,6 +72,14 @@
 					of request
 
 unsigned int hard_cur_sectors	B	Used to keep current_nr_sectors sane
+					Tracks no unfinished sectors in the
+					same segment.
+
+unsigned long nr_bio_sectors	DB	Number of sectors in first bio of
+					request
+
+unsigned short nr_bio_segments	DB	Number of segments in first bio of
+					request
 
 int tag				DB	TCQ tag, if assigned
 
@@ -79,9 +91,11 @@
 struct completion *waiting	D	Can be used by driver to get signalled
 					on request completion
 
-struct bio *bio			DBI	First bio in request
+struct bio *bio			DBI	First unsubmitted bio in request
 
 struct bio *biotail		DBI	Last bio in request
+
+struct bio *hard_bio		B	First unfinished bio in request
 
 request_queue_t *q		DB	Request queue this request belongs to
 
