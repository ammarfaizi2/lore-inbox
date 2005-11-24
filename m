Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbVKXQZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbVKXQZw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 11:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbVKXQZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 11:25:52 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:53347 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750715AbVKXQZv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 11:25:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:subject:message-id:date;
        b=jFwmdF/LnBTHZfDkZStae/WR7ATzMX+RQ/Dd8tVQHNNGeB/OTVL4YoMJpZNGfJEKTmTuOjfzktA+Xmu48vN5Mmv4VwrkRbBrJh2JQ/WBte4dGkeSXhDThlAE1gq6d6awYh9KQdNx7++hvQPNbszPSvuKL3TtZxOYajmQpC25khM=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, jgarzik@pobox.com, James.Bottomley@steeleye.com,
       bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH linux-2.6-block:post-2.6.15 00/11] blk: reimplementation of I/O barrier
Message-ID: <20051124162449.209CADD5@htj.dyndns.org>
Date: Fri, 25 Nov 2005 01:25:41 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Jens, James, Jeff and Bartlomiej.

This is the sixth posting of blk ordered reimplementation.  The last
posting was on 17th, Nov.

	http://marc.theaimsgroup.com/?l=linux-kernel&m=113224210310915&w=2

Changes from the previous post are...

1. Proxy requests (pre_flush_rq, bar_rq and post_flush_rq) are inlined
   into request_queue such that blk_queue_ordered doesn't have to
   allocate when changing ordered mode.  This change removes @gfp_mask
   argument from blk_queue_ordered.  Also, there's no need to reset
   ordered to NONE when a device goes offline anymore.  So, changes to
   to ->remove or ->release callbacks are gone.

2. blk_queue_ordered() does not synchronize using queuelock.
   Synchronization is now the caller's responsibility.  It's still
   perfectly safe to call blk_queue_ordered() without any
   synchronization.  The worst that can happen is wrong ordered
   sequence issued around the call.

3. Note that queuelock is not enough for proper ordered-mode change
   synchronization.  Currently, there's no block driver which requires
   this.  Drivers either don't change ordered mode during operation or
   doesn't properly synchronize configuration changes in the first
   place (IDE).

   This change removes for blk_queue_ordered_locked() function.

4. IDE ordered/fua support has been updated.  As IDE supports dynamic
   configuration change from EH and user input, ordered/fua settings
   should also be changed accordingly.  New IDE HL driver callback
   ->protocol_changed is implmemented and used to properly configure
   ordered mode on configuration changes.

Jens, #1 and #2 are changes to core ordered code but they are quite
simple changes.  There shouldn't be any behavior change.

Bartlomiej, IDE ordered/fua support is now splitted over three patches
08-ide-update-ordered, 09-ide-add-protocol_changed and
10-ide-add-fua-support.  I think #08 should be okay, but if you don't
like #09 and #10, we can skip them for now.  So....

If #09 and #10 are ack'd, we can push all patches into -mm.  If #09
and #10 are nack'd, we can push all patches except the two into -mm.

Thanks.

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

	Update IDE to use new blk_ordered.  This change makes the
	following behavior changes.

	* Partial completion of the barrier request is handled as
          failure of the whole ordered sequence.  No more partial
          completion for barrier requests.

	* Any failure of pre or post flush request results in failure
	  of the whole ordered sequence.

	So, successfully completed ordered sequence guarantees that
	all requests prior to the barrier made to physical medium and,
	then, the while barrier request made to the physical medium.

09_blk_ide-add-protocol_changed.patch
	: implement ide_driver_t->protocol_changed callback

	This patch implements protocol_changed callback for IDE HL
	drivers.  The callback is called whenever transfer protocol
	changes (DMA / multisector PIO / PIO).  The callback is
	sometimes with context and sometimes without, sometimes with
	queuelock, sometimes not.  So, actual callbacks should be
	written carefully.

	To hook dma setting changes, this function implements
	ide_dma_on() and ide_dma_off_quietly() which notifies protocl
	change and calls low level driver callback.  __ide_dma_off()
	is renamed to ide_dma_off() for consistency.  All dma on/off
	operations must be done by using these wrapper functions.

10_blk_ide-add-fua-support.patch
	: add FUA support to IDE

	Add FUA support to IDE.  IDE FUA support makes use of
	->protocol_changed callback to correctly adjust FUA setting
	according to transfer protocol change.

11_blk_add-barrier-doc.patch
	: I/O barrier documentation

	I/O barrier documentation

[ End of patch descriptions ]

--
tejun

