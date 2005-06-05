Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbVFEF5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbVFEF5a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 01:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVFEF5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 01:57:30 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:17904 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261452AbVFEF5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 01:57:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:subject:message-id:date;
        b=ujMBP/M5pTvb6UOX80q9khFP9DvNKWuioxwcLl1rZkDre2CmN/WHh8qkm4DRuWdDypIv23HVd0tAHhfDPx418kqh/vQrWmCvu2d26ZyqKWhNct4xDBeRD1ZcO+w8MDR4oFiCX1l4/YPxbxaCksBaBCsAoUgbMgGpOz+ZBgUwReU=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, James.Bottomley@steeleye.com, bzolnier@gmail.com,
       jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH Linux 2.6.12-rc5-mm2 00/09] blk: ordered request reimplementation (take 2, for review)
Message-ID: <20050605055337.6301E65A@htj.dyndns.org>
Date: Sun,  5 Jun 2005 14:57:04 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello.

 This is the second take of blk ordered reimplementation.  The
original plan was to just add FUA support to the first
reimplementation, but I ended up reimplementing the whole thing again.

 In the original implementation and the first reimplementation, blk
layer just passes through barrier requests when ordered tag is
supported, assuming that the device reporting ordered tag capability
will do the right thing.  However, the only thing ordered tag
guarantees is that the request will be processed in order.  It doesn't
specify anything regarding cache.  So, no cache flushing occurs before
or after the ordered request, thus breaking the semantic of barrier
requests.

 Another problem I've found is with the SCSI midlayer.  When ordered
tag is used, HARD_BARRIER requests should be issued in the exact order
it left blk layer queue.  However, SCSI midlayer request issue
function isn't atomic.  So, requests can be reordered after it leaves
blk layer queue.

 Actually, during testing I've seen this problem occurs quite often
with a SCSI host which has queue depth of 1 (only one outstanding
command).  To do barrier request, the new implementation issues three
requests (pre-flush, barrier-write, post-flush) in order.  After pre
is delivered to LLDD, SCSI midlayer fetches the bar request and tries
to issue it, SCSI midlayer finds out that it should be delayed *after*
it dropped the queue lock and acquired the host lock, and it
determines to requeue the request.  In the meantime, the pre-flush
completes, and the interrupt handler tries to issue the next command.
Unfortunately, the interrupt handler wins the race and successfully
issues the post-flush and after that the bar-write is requeued.  So,
in the end, we have (pre-flush, post-flush, barrier-write).

 * The new implementation is quite flexible in how barrier requests
   can be handled.  Any combination of pre/post-flushing and FUA
   barrier write can be used, and request order can be kept either by
   ordered tag or manual draining.

  The following ordered methods are supported.

  QUEUE_ORDERED_*

  NONE		: ordered requests unsupported,
		  barriers fail w/ -EOPNOTSUPP
  DRAIN		: ordering requests by draining is enough  (no flushing,
		  just drains in-flight requests, issue the barrier,
		  and delay other requests till it completes.)
  DRAIN_FLUSH	: ordering requests by draining w/ pre and post flush
  DRAIN_FUA	: ordering requests by draining w/ pre flush and FUA write
  TAG		: ordering requests with ordered tag is enough
  TAG_FLUSH	: ordering requests with ordered tag w/ pre and post flush
  TAG_FUA	: ordering requests with ordered tag w/ pre flush and FUA-w

 * Barrier requests can be retried, thus allowing falling back to more
   basic methods when something fancy (ordered tag/FUA write) fails.

   Whether to use automatic fallback can be specified with
   QUEUE_ORDERED_NOFALLBACK flag.  When not disabled, blk layer will
   automatically select the next method and retry the failing barrier
   until it succeeds or fallsback to QUEUE_ORDERED_NONE.  Individual
   drivers can also switch ordered method as it likes during ordered
   sequence and the barrier request is retried by the blk layer.

 * Implementation is contained inside the blk layer (ll_rw_blk.c and
   elevator.c).  Specific drivers only need to configure which method
   to use and supply prepare_flush_fn.

 * Devices which support command tagging but not ordered tags can use
   flushing safely.  All in-flight requests are drained before
   pre-flush and no other request until whole sequence completes.
   SATA NCQ falls in this category.

 This patchset makes the following behavior changes.

 * Original code used to BUG_ON in __elv_next_request() when
   elevator_next_req_fn() returns a barrier request when ordered is
   QUEUE_ORDERED_NONE.  This is a bug as ordered could have been
   changed dynamically by previous barrier request while a barrier
   request in already on the queue.  New code just completes such
   requests w/ -EOPNOTSUPP.

 * Barrier request is not deactivated during ordered sequence.  It's
   dequeued before pre-flush and completed after whole sequence is
   finished.  The original code ended up calling
   elv_deactivate_request() twice consecutively on a barrier request
   as it's also called by elv_requeue_request().  Currently, all
   elevators cope with the consecutive deactivations, but I don't
   think it's a very good idea.

 * Any error during flush sequence results in error completion of
   whole barrier request.  (IDE used to report partial success, and
   SCSI didn't handle errors during barrier request properly.)

 I've updated SCSI/libata and IDE to use the new implementation.  This
patchset isn't ready for inclusion yet.  I need to update API docs and
do more testing.  Also, Jens, the reimplementation patch includes some
hacks in elevator.c to not confuse elevators with proxy barrier
request.  The hack can go away with generic dispatch queue I'm
currently cooking.  It takes all dispatch queues from individual
elevators and generalizes it, thus simplifying individual elevators
and making forcing semantics on the dispatch queue easier.

[ Start of patch descriptions ]

01_blk_add_uptodate_to_end_that_request_last.patch
	: add @uptodate to end_that_request_last() and @error to rq_end_io_fn()

	Add @uptodate argument to end_that_request_last() and @error
	to rq_end_io_fn().  There's no generic way to pass error code
	to request completion function, making generic error handling
	of non-fs request difficult (rq->errors is driver-specific and
	each driver uses it differently).  This patch adds @uptodate
	to end_that_request_last() and @error to rq_end_io_fn().

	For fs requests, this doesn't really matter, so just using the
	same uptodate argument used in the last call to
	end_that_request_first() should suffice.  IMHO, this can also
	help the generic command-carrying request Jens is working on.

	One thing that bothers me is this change can be user-visible
	in that additional error codes may be seen by some ioctls.
	eg. -EOPNOTSUPP instead of -EIO can be seen with the following
	two patches on direct-command ioctls.

02_blk_scsi_eopnotsupp.patch
	: make scsi use -EOPNOTSUPP instead of -EIO on ILLEGAL_REQUEST

	Use -EOPNOTSUPP instead of -EIO on ILLEGAL_REQUEST.

03_blk_ide_eopnotsupp.patch
	: make ide use -EOPNOTSUPP instead of -EIO on ABRT_ERR

	Use -EOPNOTSUPP instead of -EIO on ABRT_ERR.

04_blk_add_init_request_from_bio.patch
	: separate out bio init part from __make_request

	Separate out bio initialization part from __make_request.  It
	will be used by the following blk_ordered_reimpl.

05_blk_ordered_reimpl.patch
	: reimplement handling of barrier request

	Reimplement handling of barrier requests.

	* Flexible handling to deal with various capabilities of
          target devices.
	* Retry support for falling back.
	* Tagged queues which don't support ordered tag can do ordered.

06_blk_update_scsi_to_use_new_ordered.patch
	: update SCSI to use the new blk_ordered

	All ordered request related stuff delegated to HLD.  Midlayer
	now doens't deal with ordered setting or prepare_flush
	callback.  sd.c updated to deal with blk_queue_ordered
	setting.  Currently, ordered tag isn't used as SCSI midlayer
	cannot guarantee request ordering.

07_blk_update_libata_to_use_new_ordered.patch
	: update libata to use the new blk_ordered.

	Reflect changes in SCSI midlayer and updated to use the new
	ordered request implementation.

08_blk_update_ide_to_use_new_ordered.patch
	: update IDE to use the new blk_ordered.

	Update IDE to use the new blk_ordered.

09_blk_ordered_reimpl_debug_msgs.patch
	: debug messages

	Theses are debug message I've been using.  If you wanna see
	what's going on...

[ End of patch descriptions ]

 Thanks.

--
tejun

