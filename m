Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261829AbVGZPt1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbVGZPt1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 11:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbVGZPsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 11:48:06 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:4787 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261829AbVGZPp4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 11:45:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:subject:message-id:date;
        b=qCQDJu86lZLh1a8uoygOx71AFJP+DCDWwLZCnWOPRdgH4balyFmA984KfGTqDNxYzH172nOP23dP/EUHSgz0dngzuSOX6Wv6FupuAKdwhqJ34Y0BG/BQGT7e1ZZtcCi83dZe9m/AJ1vfS9Hep27IOMwBpQe33QucqKYcSEDkGeI=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, jgarzik@pobox.com, James.Bottomley@steeleye.com,
       bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH linux-2.6-block:master 00/10] blk: reimplementation of I/O barrier
Message-ID: <20050726154457.38D60C67@htj.dyndns.org>
Date: Wed, 27 Jul 2005 00:45:50 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Jens, James, Jeff and Bartlomiej.

 This is the third posting of blk ordered reimplementation.  Changes
since the scond posting are...

 * Dispatch queue patchset is reordered in front of this patchset.
 * Draining bug fix
 * Proper requeueing of requests in an ordered sequence for TAG
   ordered queues.
 * Fallback mechanism stripped out.  This also makes -EOPNOTSUPP
   changes in SCSI and IDE unnecessary.
 * TAG ordering request issue fix
 * SCSI/libata/IDE patches splitted as requested
 * Hopefully, changes to libata and IDE are more acceptable
 * Documentation/block/barrier.txt added

 This patchset is part of the patch series described in the following mail.
	http://marc.theaimsgroup.com/?l=linux-kernel&m=112238377602033&w=2

 As all previous patches don't really concern subsystems other than
block layer.  They are only sent to Jens and LKML.  If they're needed,
preceding patches are...

fix-elevator_find:
	http://marc.theaimsgroup.com/?l=linux-kernel&m=112238419731035&w=2

fix-cfq_find_next_crq:
	http://marc.theaimsgroup.com/?l=linux-kernel&m=112238456712203&w=2

generic-dispatch-queue:
	http://marc.theaimsgroup.com/?l=linux-kernel&m=112238633622498&w=2
	http://marc.theaimsgroup.com/?l=linux-kernel&m=112238647101632&w=2
	http://marc.theaimsgroup.com/?l=linux-kernel&m=112238693809889&w=2
	http://marc.theaimsgroup.com/?l=linux-kernel&m=112238675926411&w=2
	http://marc.theaimsgroup.com/?l=linux-kernel&m=112238660407245&w=2
	http://marc.theaimsgroup.com/?l=linux-kernel&m=112238708918364&w=2

reimplement-elevator-switch:
	http://marc.theaimsgroup.com/?l=linux-kernel&m=112238771305863&w=2

 For general description please read barrier.txt and the previous posting.
	http://marc.theaimsgroup.com/?l=linux-kernel&m=111795127124020&w=2

 ==== Some excerpts from barrier.txt. ====

* SCSI layer currently can't use TAG ordering even if the drive,
  controller and driver support it.  The problem is that SCSI midlayer
  request dispatch function is not atomic.  It releases queue lock and
  switch to SCSI host lock during issue and it's possible and likely
  to happen in time that requests change their relative positions.
  Once this problem is solved, TAG ordering can be enabled.

* Error handling.  Currently, block layer will report error to upper
  layer if any of requests in an ordered sequence fails.
  Unfortunately, this doesn't seem to be enough.  Look at the
  following request flow.  QUEUE_ORDERED_TAG_FLUSH is in use.

 [0] [1] [2] [3] [pre] [barrier] [post] < [4] [5] [6] ... >
                                          still in elevator

  Let's say request [2], [3] are write requests to update file system
  metadata (journal or whatever) and [barrier] is used to mark that
  those updates are valid.  Consider the following sequence.

 i.     Requests [0] ~ [post] leaves the request queue and enters
        low-level driver.
 ii.    After a while, unfortunately, something goes wrong and the
        drive fails [2].  Note that any of [0], [1] and [3] could have
        completed by this time, but [pre] couldn't have been finished
        as the drive must process it in order and it failed before
        processing that command.
 iii.   Error handling kicks in and determines that the error is
        unrecoverable and fails [2], and resumes operation.
 iv.    [pre] [barrier] [post] gets processed.
 v.     *BOOM* power fails

  The problem here is that the barrier request is *supposed* to
  indicate that filesystem update requests [2] and [3] made it safely
  to the physical medium and, if the machine crashes after the barrier
  is written, filesystem recovery code can depend on that.  Sadly,
  that isn't true in this case anymore.  IOW, the success of a I/O
  barrier should also be dependent on success of some of the preceding
  requests, where only upper layer (filesystem) knows what 'some' is.

  This can be solved by implementing a way to tell the block layer
  which requests affect the success of the following barrier request
  and making lower lever drivers to resume operation on error only
  after block layer tells it to do so.

  As the probability of this happening is very low and the drive
  should be faulty, implementing the fix is probably an overkill.
  But, still, it's there.

[ Start of patch descriptions ]

01_blk_add-uptodate-to-end_that_request_last.patch
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

02_blk_implement-init_request_from_bio.patch
	: separate out bio init part from __make_request

	Separate out bio initialization part from __make_request.  It
        will be used by the following blk_ordered_reimpl.

03_blk_reimplement-ordered.patch
	: reimplement handling of barrier request

	 Reimplement handling of barrier requests.

        * Flexible handling to deal with various capabilities of
          target devices.
	* Retry support for falling back.
	* Tagged queues which don't support ordered tag can do ordered.

04_blk_scsi-update-ordered.patch
	: update SCSI to use new blk_ordered

	All ordered request related stuff delegated to HLD.  Midlayer
        now doens't deal with ordered setting or prepare_flush
        callback.  sd.c updated to deal with blk_queue_ordered
        setting.  Currently, ordered tag isn't used as SCSI midlayer
        cannot guarantee request ordering.

05_blk_scsi-add-fua-support.patch
	: add FUA support to SCSI disk

	Add FUA support to SCSI disk.

06_blk_libata-update-ordered.patch
	: update libata to use new blk_ordered

	Reflect changes in SCSI midlayer and updated to use new
        ordered request implementation

07_blk_libata-add-fua-support.patch
	: add FUA support to libata

	Add FUA support to libata.

08_blk_ide-update-ordered.patch
	: update IDE to use new blk_ordered

	Update IDE to use new blk_ordered.

09_blk_ide-add-fua-support.patch
	: add FUA support to IDE

	Add FUA support to IDE

10_blk_add-barrier-doc.patch
	: I/O barrier documentation

	I/O barrier documentation

[ End of patch descriptions ]

 Thanks.

--
tejun

