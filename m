Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbVKQPgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbVKQPgW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 10:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbVKQPgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 10:36:22 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:30071 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750859AbVKQPgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 10:36:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:subject:message-id:date;
        b=dQScB7u9smrmOW/TRww3/KHmRaLVYEI+gss7uEf0J+32yMhqAmcij+Qx4OTJ/MSWXb3r1VsUC/MRTXniU/rK8W5FCPDzhUlc7+Bv8jw0LmNO2sTsVZjwSxVINWlHjIvKyprDjUx5QbWFKWvvOSS/CXbajLK/BOd6732iJE3/ocM=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, jgarzik@pobox.com, James.Bottomley@steeleye.com,
       bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH linux-2.6-block:post-2.6.15 00/10] blk: reimplementation of I/O barrier
Message-ID: <20051117153509.B89B4777@htj.dyndns.org>
Date: Fri, 18 Nov 2005 00:36:11 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Jens, James, Jeff and Bartlomiej.

This is the fifth posting of blk ordered reimplementation.  The
last posting was on 19th, Oct.

	http://marc.theaimsgroup.com/?l=linux-kernel&m=112972609907761&w=2

The generic dispatch queue patchset which is required for this ordered
patchset has made it into the main tree.

	http://marc.theaimsgroup.com/?l=linux-kernel&m=112972555921965&w=2

Changes from the previous post are...

* As core blk files have moved from drivers/block/ to block/, patches
  are updated accordingly.

* In 04_blk_scsi-update-ordered, sd_prepare_flush() is updated to
  initialize rq->cmd_len properly.  This used to work like this
  previously but something broke it.  Note that the original flush
  code is broken too.  James, can you please verify this?

* libata has gone through some changes since last posting.  libata
  updates are rewritten.  Jeff, please review #07 and #08.

Other than above three, nothing has changed.  Jens, after reviewing,
can we push these into -mm?

Thanks.  :-)

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

--
tejun

