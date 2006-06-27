Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWF0Fbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWF0Fbf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 01:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWF0Fbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 01:31:35 -0400
Received: from mga03.intel.com ([143.182.124.21]:55080 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751140AbWF0Fbd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 01:31:33 -0400
X-IronPort-AV: i="4.06,178,1149490800"; 
   d="scan'208"; a="57862968:sNHT2269867285"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH]  mm: moving dirty pages balancing to pdfludh entirely
Date: Tue, 27 Jun 2006 09:31:07 +0400
Message-ID: <6694B22B6436BC43B429958787E4549802394A55@mssmsx402nb>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]  mm: moving dirty pages balancing to pdfludh entirely
Thread-Index: AcaZquPYnIY4PqtKRtW22br/10PK9A==
From: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 27 Jun 2006 05:31:18.0388 (UTC) FILETIME=[EA784B40:01C699AA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Leonid Ananiev

Moving dirty pages balancing from user to kernel thread pdfludh entirely
reduces extra long write(2) latencies, increases performance.

Signed-off-by: Leonid Ananiev <leonid.i.ananiev@intel.com>

	A file block writing time with function write(2) is very long
some times.
IOzone benchmark for file size 50% of RAM size reports record write
latency up to 0.4 sec. See sorted column 2(usec) of 'iozone -Q' output:
$ sort -nk2 wol.dat | tail
    890676      43950       4096
     77040     292806       4096
    407812     346254       4096
   1015436     346382       4096
    632940     368620       4096
    278944     368910       4096
    890672     369545       4096
    761808     376660       4096
    152124     383555       4096
   1144300     400145       4096
Investigation shows that long write(2) time ia a result of
balance_dirty_pages() running. If any of threads on current CPU had
wrote ratelimite_pages and dirty_ratio is achieved a current thread have
to find and write all extra dirty pages in the hole system, than have to
wait IO finishing and repeate until dirty_ratio will be OK. The pdflush
was waked up after balancing at user thread.
A proposed patch wakes up pdflush at low level dirty ratio and task is
continued. If high dirty ratio is reached user task waits for IO finish.
So write process will be throttled. As a result dirty page write back
preparing, inodes scanning, journaling are performed concurrently with
user task run while dirty ratio is inside low/high limits. That is why
high default dirty ratio limit is set to 60%. After patching the kernel
uses multiprocessing more for performance; extra throttling of task is
deleted; task run time becomes more stable and predictable.
	The benchmarks IOzone and Sysbench for file size 50% and 120% of
RAM size on Pentium4, Xeon, Itanium have reported write and mix
throughput increasing about 25%. The described Iozone > 0.1 sec write(2)
latencies are deleted. The condition writeback_in_progress() is tested
earlier now. As a result extra pdflush works are not created and number
of context switches increasing is inside variation limites.


diff -rpu a/mm/page-writeback.c b/mm/page-writeback.c
--- a/mm/page-writeback.c	2006-06-02 16:59:27.000000000 +0400
+++ b/mm/page-writeback.c	2006-06-22 22:43:17.000000000 +0400
@@ -69,7 +69,7 @@ int dirty_background_ratio = 10;
 /*
  * The generator of dirty data starts writeback at this percentage
  */
-int vm_dirty_ratio = 40;
+int vm_dirty_ratio = 60;
 
 /*
  * The interval between `kupdate'-style writebacks, in jiffies
@@ -190,56 +190,14 @@ get_dirty_limits(struct writeback_state 
 static void balance_dirty_pages(struct address_space *mapping)
 {
 	struct writeback_state wbs;
-	long nr_reclaimable;
+	long nr_dirty;
 	long background_thresh;
 	long dirty_thresh;
-	unsigned long pages_written = 0;
-	unsigned long write_chunk = sync_writeback_pages();
 
 	struct backing_dev_info *bdi = mapping->backing_dev_info;
-
-	for (;;) {
-		struct writeback_control wbc = {
-			.bdi		= bdi,
-			.sync_mode	= WB_SYNC_NONE,
-			.older_than_this = NULL,
-			.nr_to_write	= write_chunk,
-		};
-
-		get_dirty_limits(&wbs, &background_thresh,
-					&dirty_thresh, mapping);
-		nr_reclaimable = wbs.nr_dirty + wbs.nr_unstable;
-		if (nr_reclaimable + wbs.nr_writeback <= dirty_thresh)
-			break;
-
-		if (!dirty_exceeded)
-			dirty_exceeded = 1;
-
-		/* Note: nr_reclaimable denotes nr_dirty + nr_unstable.
-		 * Unstable writes are a feature of certain networked
-		 * filesystems (i.e. NFS) in which data may have been
-		 * written to the server's write cache, but has not yet
-		 * been flushed to permanent storage.
-		 */
-		if (nr_reclaimable) {
-			writeback_inodes(&wbc);
-			get_dirty_limits(&wbs, &background_thresh,
-					&dirty_thresh, mapping);
-			nr_reclaimable = wbs.nr_dirty + wbs.nr_unstable;
-			if (nr_reclaimable + wbs.nr_writeback <=
dirty_thresh)
-				break;
-			pages_written += write_chunk - wbc.nr_to_write;
-			if (pages_written >= write_chunk)
-				break;		/* We've done our duty
*/
-		}
-		blk_congestion_wait(WRITE, HZ/10);
-	}
-
-	if (nr_reclaimable + wbs.nr_writeback <= dirty_thresh &&
dirty_exceeded)
-		dirty_exceeded = 0;
-
-	if (writeback_in_progress(bdi))
-		return;		/* pdflush is already working this queue
*/
+	get_dirty_limits(&wbs, &background_thresh,
+				&dirty_thresh, mapping);
+	nr_dirty = wbs.nr_dirty + wbs.nr_unstable;
 
 	/*
 	 * In laptop mode, we wait until hitting the higher threshold
before
@@ -249,8 +207,13 @@ static void balance_dirty_pages(struct a
 	 * In normal mode, we start background writeout at the lower
 	 * background_thresh, to keep the amount of dirty memory low.
 	 */
-	if ((laptop_mode && pages_written) ||
-	     (!laptop_mode && (nr_reclaimable > background_thresh)))
+	if (writeback_in_progress(bdi)) {
+	       if (nr_dirty > dirty_thresh) {
+			dirty_exceeded = 1;
+	                blk_congestion_wait(WRITE, HZ/50);
+		}
+	} else if ((laptop_mode && (nr_dirty + wbs.nr_writeback >
dirty_thresh)) ||
+	     (!laptop_mode && (nr_dirty > background_thresh)))
 		pdflush_operation(background_writeout, 0);
 }
 
@@ -325,6 +288,9 @@ void throttle_vm_writeout(void)
 static void background_writeout(unsigned long _min_pages)
 {
 	long min_pages = _min_pages;
+	struct writeback_state wbs;
+	long background_thresh;
+	long dirty_thresh;
 	struct writeback_control wbc = {
 		.bdi		= NULL,
 		.sync_mode	= WB_SYNC_NONE,
@@ -333,12 +299,11 @@ static void background_writeout(unsigned
 		.nonblocking	= 1,
 	};
 
+	get_dirty_limits(&wbs, &background_thresh, &dirty_thresh, NULL);
+	if (min_pages == 0) {
+		min_pages = wbs.nr_dirty + wbs.nr_unstable;
+	}
 	for ( ; ; ) {
-		struct writeback_state wbs;
-		long background_thresh;
-		long dirty_thresh;
-
-		get_dirty_limits(&wbs, &background_thresh,
&dirty_thresh, NULL);
 		if (wbs.nr_dirty + wbs.nr_unstable < background_thresh
 				&& min_pages <= 0)
 			break;
@@ -347,13 +312,12 @@ static void background_writeout(unsigned
 		wbc.pages_skipped = 0;
 		writeback_inodes(&wbc);
 		min_pages -= MAX_WRITEBACK_PAGES - wbc.nr_to_write;
-		if (wbc.nr_to_write > 0 || wbc.pages_skipped > 0) {
-			/* Wrote less than expected */
+		if (wbc.nr_to_write > 0 || wbc.encountered_congestion) {
 			blk_congestion_wait(WRITE, HZ/10);
-			if (!wbc.encountered_congestion)
-				break;
 		}
+		get_dirty_limits(&wbs, &background_thresh,
&dirty_thresh, NULL);
 	}
+	dirty_exceeded = 0;
 }
 
 /*
@@ -361,14 +325,8 @@ static void background_writeout(unsigned
  * the whole world.  Returns 0 if a pdflush thread was dispatched.
Returns
  * -1 if all pdflush threads were busy.
  */
-int wakeup_pdflush(long nr_pages)
+int inline wakeup_pdflush(long nr_pages)
 {
-	if (nr_pages == 0) {
-		struct writeback_state wbs;
-
-		get_writeback_state(&wbs);
-		nr_pages = wbs.nr_dirty + wbs.nr_unstable;
-	}
 	return pdflush_operation(background_writeout, nr_pages);
 }
 
