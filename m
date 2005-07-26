Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbVGZPrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbVGZPrH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 11:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbVGZPrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 11:47:06 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:28944 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261880AbVGZPqt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 11:46:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=Eeqm59CCpwMAxTJGmefcimwA+1F/iqi3eRlu+puIwGYd6rB4TJ3VElddgTRPdVMWeg/t758sbZgXRSPHKm6Ho36Hd+Wl4DhXuhDrl0RojAXamzSPZ4MbivkxV5mCFYUsLjdrDkiBXhRMVe1wvUpOgAZ3mfYl/wDYAA+Sl/pFoWs=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, jgarzik@pobox.com, James.Bottomley@steeleye.com,
       bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050726154457.38D60C67@htj.dyndns.org>
In-Reply-To: <20050726154457.38D60C67@htj.dyndns.org>
Subject: Re: [PATCH linux-2.6-block:master 10/10] blk: I/O barrier documentation
Message-ID: <20050726154457.E436E5F2@htj.dyndns.org>
Date: Wed, 27 Jul 2005 00:46:41 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

10_blk_add-barrier-doc.patch

	I/O barrier documentation

Signed-off-by: Tejun Heo <htejun@gmail.com>

 barrier.txt |  271 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 biodoc.txt  |   10 --
 2 files changed, 273 insertions(+), 8 deletions(-)

Index: blk-fixes/Documentation/block/barrier.txt
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ blk-fixes/Documentation/block/barrier.txt	2005-07-27 00:44:53.000000000 +0900
@@ -0,0 +1,271 @@
+I/O Barriers
+============
+Tejun Heo <htejun@gmail.com>, July 22 2005
+
+I/O barrier requests are used to guarantee ordering around the barrier
+requests.  Unless you're crazy enough to use disk drives for
+implementing synchronization constructs (wow, sounds interesting...),
+the ordering is meaningful only for write requests for things like
+journal checkpoints.  All requests queued before a barrier request
+must be finished (made it to the physical medium) before the barrier
+request is started, and all requests queued after the barrier request
+must be started only after the barrier request is finished (again,
+made it to the physical medium).
+
+In other words, I/O barrier requests have the following two properties.
+
+1. Request ordering
+
+Requests cannot pass the barrier request.  Preceding requests are
+processed before the barrier and following requests after.
+
+Depending on what features a drive supports, this can be done in one
+of the following three ways.
+
+i. For devices which have queue depth greater than 1 (TCQ devices) and
+support ordered tags, block layer can just issue the barrier as an
+ordered request and the lower level driver, controller and drive
+itself are responsible for making sure that the ordering contraint is
+met.  Most modern SCSI controllers/drives should support this.
+
+NOTE: SCSI ordered tag isn't currently used due to limitation in the
+      SCSI midlayer, see the following random notes section.
+
+ii. For devices which have queue depth greater than 1 but don't
+support ordered tags, block layer ensures that the requests preceding
+a barrier request finishes before issuing the barrier request.  Also,
+it defers requests following the barrier until the barrier request is
+finished.  Older SCSI controllers/drives and SATA drives fall in this
+category.
+
+iii. Devices which have queue depth of 1.  This is a degenerate case
+of ii.  Just keeping issue order suffices.  Ancient SCSI
+controllers/drives and IDE drives are in this category.
+
+2. Forced flushing to physcial medium
+
+Again, if you're not gonna do synchronization with disk drives (dang,
+it sounds even more appealing now!), the reason you use I/O barriers
+is mainly to protect filesystem integrity when power failure or some
+other events abruptly stop the drive from operating and possibly make
+the drive lose data in its cache.  So, I/O barriers need to guarantee
+that requests actually get written to non-volatile medium in order.
+
+There are four cases,
+
+i. No write-back cache.  Keeping requests ordered is enough.
+
+ii. Write-back cache but no flush operation.  There's no way to
+gurantee physical-medium commit order.  This kind of devices can't to
+I/O barriers.
+
+iii. Write-back cache and flush operation but no FUA (forced unit
+access).  We need two cache flushes - before and after the barrier
+request.
+
+iv. Write-back cache, flush operation and FUA.  We still need one
+flush to make sure requests preceding a barrier are written to medium,
+but post-barrier flush can be avoided by using FUA write on the
+barrier itself.
+
+
+How to support barrier requests in drivers
+------------------------------------------
+
+All barrier handling is done inside block layer proper.  All low level
+drivers have to are implementing its prepare_flush_fn and using one
+the following two functions to indicate what barrier type it supports
+and how to prepare flush requests.  Note that the term 'ordered' is
+used to indicate the whole sequence of performing barrier requests
+including draining and flushing.
+
+typedef void (prepare_flush_fn)(request_queue_t *q, struct request *rq);
+
+int blk_queue_ordered(request_queue_t *q, unsigned ordered,
+		      prepare_flush_fn *prepare_flush_fn,
+		      unsigned gfp_mask);
+
+int blk_queue_ordered_locked(request_queue_t *q, unsigned ordered,
+			     prepare_flush_fn *prepare_flush_fn,
+			     unsigned gfp_mask);
+
+The only difference between the two functions is whether or not the
+caller is holding q->queue_lock on entry.  The latter expects the
+caller is holding the lock.
+
+@q			: the queue in question
+@ordered		: the ordered mode the driver/device supports
+@prepare_flush_fn	: this function should prepare @rq such that it
+			  flushes cache to physical medium when executed
+@gfp_mask		: gfp_mask used when allocating data structures
+			  for ordered processing
+
+For example, SCSI disk driver's prepare_flush_fn looks like the
+following.
+
+static void sd_prepare_flush(request_queue_t *q, struct request *rq)
+{
+	memset(rq->cmd, 0, sizeof(rq->cmd));
+	rq->flags |= REQ_BLOCK_PC;
+	rq->timeout = SD_TIMEOUT;
+	rq->cmd[0] = SYNCHRONIZE_CACHE;
+}
+
+The following seven ordered modes are supported.  The following table
+shows which mode should be used depending on what features a
+device/driver supports.  In the leftmost column of table,
+QUEUE_ORDERED_ prefix is omitted from the mode names to save space.
+
+The table is followed by description of each mode.  Note that in the
+descriptions of QUEUE_ORDERED_DRAIN*, '=>' is used whereas '->' is
+used for QUEUE_ORDERED_TAG* descriptions.  '=>' indicates that the
+preceding step must be complete before proceeding to the next step.
+'->' indicates that the next step can start as soon as the previous
+step is issued.
+
+	    write-back cache	ordered tag	flush		FUA
+-----------------------------------------------------------------------
+NONE		yes/no		N/A		no		N/A
+DRAIN		no		no		N/A		N/A
+DRAIN_FLUSH	yes		no		yes		no
+DRAIN_FUA	yes		no		yes		yes
+TAG		no		yes		N/A		N/A
+TAG_FLUSH	yes		yes		yes		no
+TAG_FUA		yes		yes		yes		yes
+
+
+QUEUE_ORDERED_NONE
+	I/O barriers are not needed and/or supported.
+
+	Sequence: N/A
+
+QUEUE_ORDERED_DRAIN
+	Requests are ordered by draining the request queue and cache
+	flushing isn't needed.
+
+	Sequence: drain => barrier
+
+QUEUE_ORDERED_DRAIN_FLUSH
+	Requests are ordered by draining the request queue and both
+	pre-barrier and post-barrier cache flushings are needed.
+
+	Sequence: drain => preflush => barrier => postflush
+
+QUEUE_ORDERED_DRAIN_FUA
+	Requests are ordered by draining the request queue and
+	pre-barrier cache flushing is needed.  By using FUA on barrier
+	request, post-barrier flushing can be skipped.
+
+	Sequence: drain => preflush => barrier
+
+QUEUE_ORDERED_TAG
+	Requests are ordered by ordered tag and cache flushing isn't
+	needed.
+
+	Sequence: barrier
+
+QUEUE_ORDERED_TAG_FLUSH
+	Requests are ordered by ordered tag and both pre-barrier and
+	post-barrier cache flushings are needed.
+
+	Sequence: preflush -> barrier -> postflush
+
+QUEUE_ORDERED_TAG_FUA
+	Requests are ordered by ordered tag and pre-barrier cache
+	flushing is needed.  By using FUA on barrier request,
+	post-barrier flushing can be skipped.
+
+	Sequence: preflush -> barrier
+
+
+Random notes/caveats
+--------------------
+
+* SCSI layer currently can't use TAG ordering even if the drive,
+controller and driver support it.  The problem is that SCSI midlayer
+request dispatch function is not atomic.  It releases queue lock and
+switch to SCSI host lock during issue and it's possible and likely to
+happen in time that requests change their relative positions.  Once
+this problem is solved, TAG ordering can be enabled.
+
+* Currently, no matter which ordered mode is used, there can be only
+one barrier request in progress.  All I/O barriers are held off by
+block layer until the previous I/O barrier is complete.  This doesn't
+make any difference for DRAIN ordered devices, but, for TAG ordered
+devices with very high command latency, passing multiple I/O barriers
+to low level *might* be helpful if they are very frequent.  Well, this
+certainly is a non-issue.  I'm writing this just to make clear that no
+two I/O barrier is ever passed to low-level driver.
+
+* Completion order.  Requests in ordered sequence are issued in order
+but not required to finish in order.  Barrier implementation can
+handle out-of-order completion of ordered sequence.  IOW, the requests
+MUST be processed in order but the hardware/software completion paths
+are allowed to reorder completion notifications - eg. current SCSI
+midlayer doesn't preserve completion order during error handling.
+
+* Requeueing order.  Low-level drivers are free to requeue any request
+after they removed it from the request queue with
+blkdev_dequeue_request().  As barrier sequence should be kept in order
+when requeued, generic elevator code takes care of putting requests in
+order around barrier.  See blk_ordered_req_seq() and
+ELEVATOR_INSERT_REQUEUE handling in __elv_add_request() for details.
+
+Note that block drivers must not requeue preceding requests while
+completing latter requests in an ordered sequence.  Currently, no
+error checking is done against this.
+
+* Error handling.  Currently, block layer will report error to upper
+layer if any of requests in an ordered sequence fails.  Unfortunately,
+this doesn't seem to be enough.  Look at the following request flow.
+QUEUE_ORDERED_TAG_FLUSH is in use.
+
+ [0] [1] [2] [3] [pre] [barrier] [post] < [4] [5] [6] ... >
+					  still in elevator
+
+Let's say request [2], [3] are write requests to update file system
+metadata (journal or whatever) and [barrier] is used to mark that
+those updates are valid.  Consider the following sequence.
+
+ i.	Requests [0] ~ [post] leaves the request queue and enters
+	low-level driver.
+ ii.	After a while, unfortunately, something goes wrong and the
+	drive fails [2].  Note that any of [0], [1] and [3] could have
+	completed by this time, but [pre] couldn't have been finished
+	as the drive must process it in order and it failed before
+	processing that command.
+ iii.	Error handling kicks in and determines that the error is
+	unrecoverable and fails [2], and resumes operation.
+ iv.	[pre] [barrier] [post] gets processed.
+ v.	*BOOM* power fails
+
+The problem here is that the barrier request is *supposed* to indicate
+that filesystem update requests [2] and [3] made it safely to the
+physical medium and, if the machine crashes after the barrier is
+written, filesystem recovery code can depend on that.  Sadly, that
+isn't true in this case anymore.  IOW, the success of a I/O barrier
+should also be dependent on success of some of the preceding requests,
+where only upper layer (filesystem) knows what 'some' is.
+
+This can be solved by implementing a way to tell the block layer which
+requests affect the success of the following barrier request and
+making lower lever drivers to resume operation on error only after
+block layer tells it to do so.
+
+As the probability of this happening is very low and the drive should
+be faulty, implementing the fix is probably an overkill.  But, still,
+it's there.
+
+* In previous drafts of barrier implementation, there was fallback
+mechanism such that, if FUA or ordered TAG fails, less fancy ordered
+mode can be selected and the failed barrier request is retried
+automatically.  The rationale for this feature was that as FUA is
+pretty new in ATA world and ordered tag was never used widely, there
+could be devices which report to support those features but choke when
+actually given such requests.
+
+ This was removed for two reasons 1. it's an overkill 2. it's
+impossible to implement properly when TAG ordering is used as low
+level drivers resume after an error automatically.  If it's ever
+needed adding it back and modifying low level drivers accordingly
+shouldn't be difficult.
Index: blk-fixes/Documentation/block/biodoc.txt
===================================================================
--- blk-fixes.orig/Documentation/block/biodoc.txt	2005-07-27 00:44:49.000000000 +0900
+++ blk-fixes/Documentation/block/biodoc.txt	2005-07-27 00:44:53.000000000 +0900
@@ -263,14 +263,8 @@ A flag in the bio structure, BIO_BARRIER
 The generic i/o scheduler would make sure that it places the barrier request and
 all other requests coming after it after all the previous requests in the
 queue. Barriers may be implemented in different ways depending on the
-driver. A SCSI driver for example could make use of ordered tags to
-preserve the necessary ordering with a lower impact on throughput. For IDE
-this might be two sync cache flush: a pre and post flush when encountering
-a barrier write.
-
-There is a provision for queues to indicate what kind of barriers they
-can provide. This is as of yet unmerged, details will be added here once it
-is in the kernel.
+driver. For more details regarding I/O barriers, please read barrier.txt
+in this directory.
 
 1.2.2 Request Priority/Latency
 

