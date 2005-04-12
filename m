Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262232AbVDLStD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbVDLStD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 14:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbVDLSsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 14:48:36 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:23253 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262232AbVDLKcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:subject:message-id:date;
        b=cws685mJAJelvNMbYA6hD+5cuwWhZdorbCKzKu/wos1n3S4wAhX1KPnXK3s9+OuFj+fnWkepW7lHo4zVwgXdUTStexj3GchEJa34qrVTf+QiF3HWwqrOKEmk1lbLcsehioaec5tVFP272anxv6E9M0O6qMyej786aJ52EhCvNE8=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH scsi-misc-2.6 00/04] scsi: scsi_request_fn() reimplementation
Message-ID: <20050412103128.69172FEB@htj.dyndns.org>
Date: Tue, 12 Apr 2005 19:32:48 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, guys.

 This patchset reimplements scsi_request_fn().  All prep's are moved
into prep_fn and all state checking/issueing are moved into
scsi_reqfn.  prep_fn() only terminates/defers unpreparable requests
and all requests are terminated through scsi midlayer.


[ Start of patch descriptions ]

01_scsi_reqfn_consolidate_error_handling.patch
	: consolidate error handling out of scsi_init_io() into scsi_prep_fn()

	This patch fixes a queue stall bug which occurred when sgtable
	allocation failed and device_busy == 0.  When scsi_init_io()
	returns BLKPREP_DEFER or BLKPREP_KILL, it's supposed to free
	resources itself.  This patch consolidates defer and kill
	handling into scsi_prep_fn().

	Note that this patch doesn't consolidate state defer/kill
	handlings in scsi_prep_fn().  They were omitted as all state
	checks will be moved into scsi_reques_fn() by the following
	reqfn_reimpl patch.

	ret value checking was changed to switch() as in James's
	patch.  Also, kill: comment is copied from James's patch.

02_scsi_reqfn_move_preps_to_prep_fn.patch
	: move request preps in other places into prep_fn()

	Move request preparations scattered in scsi_request_fn() and
	scsi_dispatch_cmd() into scsi_prep_fn()

	* CDB_SIZE check in scsi_dispatch_cmd()
	* SCSI-2 LUN preparation in scsi_dispatch_cmd()

	No invalid request reaches scsi_request_fn() anymore.

	Note that scsi_init_cmd_errh() is still left in
	scsi_request_fn().  As all requeued requests need its sense
	buffer and result value cleared, we can't move this to
	prep_fn() yet.  This is moved into prep_fn in the following
	requeue path consoildation patchset.

03_scsi_reqfn_reimplementation.patch
	: reimplement scsi_request_fn()

	This patch rewrites scsi_request_fn().	scsi_dispatch_cmd() is
	merged into scsi_request_fn().	Goals are

	* Remove unnecessary operations (host_lock unlocking/locking,
	  recursing into scsi_run_queue(), ...)
	* Consolidate defer/kill paths.
	* Be concise.

	The following bugs are fixed.

	* All killed requests now get fully prep'ed and pass through
	  __scsi_done().  This is the only kill path.
		- scsi_cmnd leak in offline-kill path removed
		- unfinished request bug in
		  scsi_dispatch_cmd():SDEV_DEL-kill path removed.
		- commands are never terminated directly from blk
		  layer unless they are invalid, so no need to supply
		  req->end_io callback for special requests.
	* Timer is added while holding host_lock, after all conditions
	  are checked and serial number is assigned.  This guarantees
	  that until host_lock is released, the scsi_cmnd pointed to
	  by cmd isn't released.  That didn't hold in the original
	  code and, theoretically, the original code could access
	  already released cmd.
	* For the same reason, if shost->hostt->queuecommand() fails,
	  we try to delete the timer before releasing host_lock.

	Other changes/notes

	* host_lock is acquired and released only once.
	  enter (qlocked) -> enter loop -> dev-prep -> switch to hlock -\
			  ^---- switch to qlock <- issue <- host-prep <-/
	* unnecessary if () on get_device() removed.
	* loop on elv_next_request() instead of blk_queue_plugged().
	  We now explicitly break out of loop when we plug and check if
	  the queue has been plugged underneath us at the end of loop.
	* All device/host state checks are done in this function and
	  done only once while holding qlock/host_lock respectively.
	* Requests which get deferred during dev-prep are never
	  removed from request queue, so deferring is achieved by
	  simply breaking out of the loop and returning.
	* Failure of blk_queue_start_tag() on tagged queue is a BUG
	  now.	This condition should have been catched by
	  scsi_dev_queue_ready().
	* req->special == NULL test removed.  This just can't happen,
	  and even if it ever happens, scsi_request_fn() will
	  deterministically oops.
	* Requests which gets deferred during host-prep are requeued
	  using blk_requeue_request().	This is the only requeue path.

	Note that scsi_kill_requests() still terminates requests using
	blk layer.  The path is circular-ref workaround and soon to be
	replaced, so ignore it for now.

04_scsi_reqfn_remove_wait_req_end_io.patch
	: remove unnecessary scsi_wait_req_end_io()

	As all requests are now terminated via scsi midlayer, we don't
	need to set end_io for special reqs, remove it.

	Note that scsi_kill_requests() still terminates requests using
	blk layer.  The path is circular-ref workaround and soon to be
	replaced, so ignore it for now.

[ End of patch descriptions ]


 Thanks a lot.

