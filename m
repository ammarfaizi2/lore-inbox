Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261607AbTC0Xmf>; Thu, 27 Mar 2003 18:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261572AbTC0Xl6>; Thu, 27 Mar 2003 18:41:58 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:5017 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S261607AbTC0Xlg>; Thu, 27 Mar 2003 18:41:36 -0500
Date: Fri, 28 Mar 2003 00:52:37 +0100 (MET)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Suparna Bhattacharya <suparna@in.ibm.com>,
       Andre Hedrick <andre@linux-ide.org>, Jens Axboe <axboe@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] bio traversal 2/2 - documentation changes
In-Reply-To: <Pine.SOL.4.30.0303280047160.24932-100000@mion.elka.pw.edu.pl>
Message-ID: <Pine.SOL.4.30.0303280051390.6453-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


# Bio traversal (separate submittion/completion bio pointers).
# Patch 2/2 - Documentation changes.
#
# Originally by Suparna Bhattacharya.
#
# Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

diff -uNr linux-2.5.66/Documentation/block/biodoc.txt linux/Documentation/block/biodoc.txt
--- linux-2.5.66/Documentation/block/biodoc.txt	Mon Mar 17 19:49:00 2003
+++ linux/Documentation/block/biodoc.txt	Tue Mar 18 21:42:40 2003
@@ -5,7 +5,7 @@
 	Jens Axboe <axboe@suse.de>
 	Suparna Bhattacharya <suparna@in.ibm.com>

-Last Updated May 2, 2002
+Last Updated March 18, 2003

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
+ as mentioned earlier.
 >

 1.3.1 Pre-built Commands
@@ -609,11 +610,20 @@
 	unsigned short nr_hw_segments;

 	/* Various sector counts */
+	/*
+	 * The various block internal copies represent counts/pointers of
+	 * unfinished I/O, while the other counts/pointers refer to
+	 * I/O to be submitted.
+	 */
 	unsigned long nr_sectors;  /* no. of sectors left: driver modifiable */
 	unsigned long hard_nr_sectors;  /* block internal copy of above */
 	unsigned int current_nr_sectors; /* no. of sectors left in the
 					   current segment:driver modifiable */
 	unsigned long hard_cur_sectors; /* block internal copy of the above */
+
+	unsigned short nr_bio_segments;	/* no. of segments left in curr bio */
+	unsigned short nr_bio_sectors;	/* no. of sectors left in curr bio */
+
 	.
 	.
 	int tag;	/* command tag associated with request */
@@ -623,6 +633,7 @@
 	.
 	.
 	struct bio *bio, *biotail;  /* bio list instead of bh */
+	struct bio *hard_bio; /* block internal copy */
 	struct request_list *rl;
 }

@@ -641,9 +652,11 @@
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
@@ -653,6 +666,60 @@
 a driver needs to be careful about interoperation with the block layer helper
 functions which the driver uses. (Section 1.3)

+2.3.1 The Separation of Submission and Completion State
+
+The basic protocol followed all through is that the bio fields
+would always reflect the status w.r.t how much i/o remains
+to be completed. On the other hand submission status would
+only be maintained in the request structure. In most cases
+of course, both move in sync (the generic end_that_request_first
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
@@ -732,6 +799,16 @@
 which don't make a distinction between segments and completion units would
 need to be reorganized to support multi-segment bios.

+It is recommended that drivers utilize the block layer routine
+process_that_request_first() while traversing bios for i/o submission,
+instead of iterating over the segments directly, and use
+end_that_request_first() for completion as before. Things like
+rq_map_buffer() rely on the submission pointers in the request
+to map the correct buffer.
+
+rq_map_buffer() could be used to get a virtual address mapping
+for the current segment buffer, in drivers which use PIO for example.
+
 3.2.2 Setting up DMA scatterlists

 The blk_rq_map_sg() helper routine would be used for setting up scatter
@@ -1147,9 +1224,8 @@
 PIO drivers (or drivers that need to revert to PIO transfer once in a
 while (IDE for example)), where the CPU is doing the actual data
 transfer a virtual mapping is needed. If the driver supports highmem I/O,
-(Sec 1.1, (ii) ) it needs to use bio_kmap and bio_kmap_irq to temporarily
-map a bio into the virtual address space. See how IDE handles this with
-ide_map_buffer.
+(Sec 1.1, (ii) ) it needs to use rq_map_buffer() to temporarily
+map a bio into the virtual address space. See how IDE handles this.


 8. Prior/Related/Impacted patches
diff -uNr linux-2.5.66/Documentation/block/request.txt linux/Documentation/block/request.txt
--- linux-2.5.66/Documentation/block/request.txt	Fri Sep 20 16:19:26 2002
+++ linux/Documentation/block/request.txt	Tue Mar 18 21:54:16 2003
@@ -52,11 +52,15 @@

 sector_t sector			DBI	Target location

-unsigned long hard_nr_sectors	B	Used to keep sector sane
+sector_t hard_sector		B	Used to keep sector sane
+					Tracks the location of unfinished
+					portion

 unsigned long nr_sectors	DBI	Total number of sectors in request

 unsigned long hard_nr_sectors	B	Used to keep nr_sectors sane
+					Tracks no. of unfinished sectors in
+					the request

 unsigned short nr_phys_segments	DB	Number of physical scatter gather
 					segments in a request
@@ -68,6 +72,14 @@
 					of request

 unsigned int hard_cur_sectors	B	Used to keep current_nr_sectors sane
+					Tracks no. unfinished sectors in the
+					same segment.
+
+unsigned long nr_bio_sectors	DB	Number of unfinished sectors in first
+					bio of request
+
+unsigned short nr_bio_segments	DB	Number of unfinished segments in first
+					bio of request

 int tag				DB	TCQ tag, if assigned

@@ -79,10 +91,12 @@
 struct completion *waiting	D	Can be used by driver to get signalled
 					on request completion

-struct bio *bio			DBI	First bio in request
+struct bio *bio			DBI	First unsubmitted bio in request

 struct bio *biotail		DBI	Last bio in request

+struct bio *hard_bio		B	First unfinished bio in request
+
 request_queue_t *q		DB	Request queue this request belongs to

 struct request_list *rl		B	Request list this request came from

