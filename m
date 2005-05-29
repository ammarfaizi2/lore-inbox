Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbVE2EXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVE2EXg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 00:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVE2EXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 00:23:36 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:35573 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261230AbVE2EXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 00:23:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:subject:message-id:date;
        b=TuZi2Tum26HjCPpx8+02s3tAaK4r+w1+Cx4h1RANQ/c7W9SfGO887jrW8A9UOsG+lAEGlR27lCVMBeV/6u22W57UdrcfqSS0YOu6tqczXHRRIGpIzl9Z/RMS9ijnY4W0o0LH3Hmqr4ui2eEAxnphQEDQ4Ig2cbUiwgyZOQt6Vs4=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, James.Bottomley@steeleye.com, bzolnier@gmail.com,
       jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH Linux 2.6.12-rc5-mm1 00/06] blk: barrier flushing reimplementation
Message-ID: <20050529042034.5FF4CF1C@htj.dyndns.org>
Date: Sun, 29 May 2005 13:23:18 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, guys.

 This patchset is reimplementation of QUEUE_ORDERED_FLUSH feature.  It
doens't update API docs yet.  If it's determined that this patchset
can go in, I'll regenerate this patchset with doc updates (sans the
last debug message patch of course).

 Major changes are.

 * Implementation is contained inside the blk layer (ll_rw_blk.c and
   elevator.c).  Specific drivers only need to supply
   prepare_flush_fn.  end_flush_fn, blk_complete_barrier_rq_* removed.

 * Tagged queues can use flushing safely.  All in-flight requests are
   drained before pre-flush and no other request is allowed during
   flush sequence.  So, SCSI devices which only support simple tags
   can now use flush barrier (SATA NCQ falls in this category, I think).

 * Multi-bio barrier requests supported.

 This patchset makes the following behavior changes.

 * Original code used to BUG_ON in __elv_next_request() when
   elevator_next_req_fn() returns a barrier request when ordered is
   QUEUE_ORDERED_NONE.  This is a bug as ordered could have been
   changed dynamically by previous barrier request while a barrier
   request in already on the queue.  New code just completes such
   requests w/ -EOPNOTSUPP.

 * Barrier request is not deactivated during pre-flushing.  The
   original code ends up calling elv_deactivate_request() twice
   consecutively on a barrier request as it's also called by
   elv_requeue_request().  Currently, all elevators cope with the
   consecutive deactivations, but I don't think it's a very good idea.
   This is easy to revert, please let me know what you guys think.

 * When an error occurs while writing a barrier request, the whole
   request is completed with error after executing it till the end.
   In fact, any error during flush sequence results in error
   completion of whole barrier request.  (IDE used to report partial
   success, and SCSI didn't handle errors during barrier request
   properly.)

 * ordered is changed to QUEUE_ORDERED_NONE only if pre/post flush
   completes w/ -EOPNOTSUPP.  (SCSI used to revert to
   QUEUE_ORDERED_NONE on any error during preflush)

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

04_blk_flush_reimplementation.patch
	: reimplement QUEUE_OREDERED_FLUSH

	Reimplement QUEUE_ORDERED_FLUSH.

	* Implementation is contained inside blk layer.  Only
	  prepare_flush_fn() is needed from individual drivers.
	* Tagged queues which don't support ordered tag can use
          flushing.
	* Multi-bio barrier requests supported.

05_blk_scsi_turn_on_flushing_by_default.patch
	: turn on QUEUE_ORDERED_FLUSH by default if ordered tag isn't supported

	As flushing can now be used by devices which only support
	simple tags, there's no need to use
	Scsi_Host_Template->ordered_flush to enable it selectively.
	This patch removes ->ordered_flush and enables flushing
	implicitly when ordered tag isn't supported.  If the device
	doesn't support flushing, it can just return -EOPNOTSUPP for
	flush requests.  blk layer will switch to QUEUE_OREDERED_NONE
	automatically.

06_blk_flush_reimplementation_debug_messages.patch
	: debug messages

	These are debug messages I've used.  If you are interested how
	it works...

[ End of patch descriptions ]

 Thanks.

--
tejun

