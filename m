Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbVCaJMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVCaJMK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 04:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVCaJMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 04:12:10 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:5413 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261204AbVCaJHz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 04:07:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:subject:message-id:date;
        b=CEP59Kwp3JahMicT36GCJgvFT8//wnyZt/uYuwr73sJszDTrjDMa2Xc1iJoTvPKqonpcPzOEqbX1mkEzAL2kIZiUvyLmawvqEdPbO6AIb7B1Ajzkz7WZ0K4Yij2Z91+9t+LCwyABzHHTJL0CQ0AhxhaqG6tFu2YonQ4QK1MMvPM=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH scsi-misc-2.6 00/13] scsi: scsi_request_fn() rewrite & stuff
Message-ID: <20050331090647.FEDC3964@htj.dyndns.org>
Date: Thu, 31 Mar 2005 18:07:50 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, James.
 Hello, Jens.

 This patchset is consisted of three parts

 #01-#06: Misc updates.  Except for #02, all patches are from the last
	  patchset.  #05 has been updated.
 #07-#10: Rewrite scsi_request_fn().
 #11-#13: Consolidate requeue paths & cleanup scsi_cmd_retry() calls
	  in scsi_error.c.

#01-#06: Subset of the previously posted misc patchset
----------------------------------------------------------------------
 The new patch #02 removes the code which sets REQ_SPECIAL when
sgtable allocation fails in scsi_init_io().

 #05 timer_cleanup is updated like the following.

	* scsi_eh_times_out() now clears eh_timeout.function.  The
	  original patch triggers BUG() when eh command times out.
	  This fixes the bug.
	* scsi_times_out() doesn't clear eh_timeout.data.
	* In scsi_dispatch_cmd(), when queuecommand fails, iodone_cnt
	  is bumped up only if timer deletion succeeds.

 #01, #03-#04 and #06 are unchanged from the previous posting.

 Note: Patches from the previous patchset which are pointed out to be
       problemetic are omitted.

#07-#10: Rewrite scsi_request_fn().
----------------------------------------------------------------------
 These patches rewrites functions related to command issuing.  The big
picture is

 * scsi_prep_fn(): Only preps requests.  No deferring/killing happens
	in this function unless the request is invalid.  And all
	invalid requests are terminated here.  No invalid request
	reaches request_fn.
 * scsi_request_fn(): Switch locks only once per each issuing.  Don't
	use more than one paths to do the same thing (unified defer
	and kill paths).  Don't test for the same condition multiple
	times.  Make as concise as possible.

#11-#13: Consolidate requeue paths & cleanup scsi_cmd_retry() calls.
----------------------------------------------------------------------
 See patch descriptions.

[ Start of patch descriptions ]

01_scsi_no_REQ_SPECIAL_on_requeue.patch
	: don't use blk_insert_request() for requeueing

	blk_insert_request() has 'reinsert' argument, which, when set,
	turns on REQ_SPECIAL and REQ_SOFTBARRIER and requeues the
	request.  SCSI midlayer was the only user of this feature and
	all requeued requests become special requests defeating
	quiesce state.  This patch makes scsi midlayer use
	blk_requeue_request() for requeueing and removes 'reinsert'
	feature from blk_insert_request().

	Note: In drivers/scsi/scsi_lib.c, scsi_single_lun_run() and
	scsi_run_queue() are moved upward unchanged.

02_scsi_no_REQ_SPECIAL_on_sgtable_allocation_failure.patch
	: don't turn on REQ_SPECIAL on sgtable allocation failure.

	Don't turn on REQ_SPECIAL on sgtable allocation failure.  This
	was the last place where REQ_SPECIAL is turned on for normal
	requests.

03_scsi_remove_internal_timeout.patch
	: remove unused scsi_cmnd->internal_timeout field

	scsi_cmnd->internal_timeout field doesn't have any meaning
	anymore.  Kill the field.

04_scsi_remove_volatile.patch
	: remove meaningless volatile qualifiers from structure definitions

	scsi_device->device_busy, Scsi_Host->host_busy and
	->host_failed have volatile qualifiers, but the qualifiers
	don't serve any purpose.  Kill them.  While at it, protect
	->host_failed update in scsi_error for consistency and clarity.

05_scsi_timer_cleanup.patch
	: remove a timer race from scsi_queue_insert() and cleanup timer

	scsi_queue_insert() has four callers.  Three callers call with
	timer disabled and one (the second invocation in
	scsi_dispatch_cmd()) calls with timer activated.
	scsi_queue_insert() used to always call scsi_delete_timer()
	and ignore the return value.  This results in race with timer
	expiration.  Remove scsi_delete_timer() call from
	scsi_queue_insert() and make the caller delete timer and check
	the return value.

	While at it, as, once a scsi timer is added, it should expire
	or be deleted before reused, make scsi_add_timer() strict
	about timer reuses.  Now timer expiration function should
	clear ->function and all timer deletion should go through
	scsi_delete_timer().  Also, remove bogus ->eh_action tests
	from scsi_eh_{done|times_out} functions.  The condition is
	always true and the test is somewhat misleading.

06_scsi_remove_serial_number_at_timeout.patch
	: remove meaningless scsi_cmnd->serial_number_at_timeout field

	scsi_cmnd->serial_number_at_timeout doesn't serve any purpose
	anymore.  All serial_number == serial_number_at_timeout tests
	are always true in abort callbacks.  Kill the field.  Also, as
	->pid always equals ->serial_number and ->serial_number
	doesn't have any special meaning anymore, update comments
	above ->serial_number accordingly.  Once we remove all uses of
	this field from all lldd's, this field should go.

07_scsi_consolidate_prep_fn_error_handling.patch
	: move error handling out of scsi_init_io() into scsi_prep_fn()

	When scsi_init_io() returns BLKPREP_DEFER or BLKPREP_KILL,
	it's supposed to free resources itself.  This patch
	consolidates defer and kill handling into scsi_prep_fn().
	This fixes a queue stall bug which occurred when sgtable
	allocation failed and device_busy == 0.

08_scsi_move_preps_to_prep_fn.patch
	: move request preps in other places into prep_fn()

	Move request preparations scattered in scsi_request_fn() and
	scsi_dispatch_cmd() into scsi_prep_fn().

	* CDB_SIZE check in scsi_dispatch_cmd()
	* SCSI-2 LUN preparation in scsi_dispatch_cmd()
	* scsi_init_cmd_errh() in scsi_request_fn()

	No invalid request reaches scsi_request_fn() anymore.

09_scsi_prep_fn_comment_update.patch
	: in scsi_prep_fn(), remove bogus comments & clean up

	Remove bogus comments from scsi_prep_fn() and clean up a bit.
	While at it, remove leading and tailing empty comment lines
	for one or two liners to make the code more concise.

10_scsi_request_fn_rewrite.patch
	: rewrite scsi_request_fn()

	This patch rewrites scsi_request_fn().  scsi_dispatch_cmd() is
	merged into scsi_request_fn().  Goals are

	* Remove unnecessary operations (host_lock unlocking/locking,
	  recursing into scsi_run_queue(), ...)
	* Consolidate defer/kill paths.
	* Be concise.

	The following changes fix bugs.

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
	  now.  This condition should have been catched by
	  scsi_dev_queue_ready().
	* req->special == NULL test removed.  This just can't happen,
	  and even if it ever happens, scsi_request_fn() will
	  deterministically oops.
	* Requests which gets deferred during host-prep are requeued
	  using blk_requeue_request().  This is the only requeue path.

11_scsi_make_requeue_command_public.patch
	: add reprep arg to scsi_requeue_command() and make it public

	Add reprep argument to scsi_requeue_command(), remove
	redundant q argument, add code to set cmd->state/owner, and
	make the function public.  This patch is preparation for
	consolidating requeue paths.

12_scsi_consolidate_requeue_paths.patch
	: replace scsi_queue_insert() with scsi_requeue_command()

	Add scsi_device_unbusy() call to scsi_retry_command(), replace
	scsi_queue_insert() with scsi_requeue_command(), make
	scsi_softirq() use scsi_retry_command() for ADD_TO_MLQUEUE
	case too (with explicit device blocking), and make
	scsi_eh_flush_done_q() use scsi_retry_command().  While at it,
	remove leading and tailing empty comment lines from trivial
	comments.

	As scsi_queue_insert() has no users now, kill it.

13_scsi_consolidate_cmd_retry_calls_in_eh.patch
	: consolidate scsi_cmd_retry() calls in scsi_error.c

	Replace all scsi_setup_cmd_retry() calls in scsi_error.c with
	a call just above scsi_finish_command() in scsi_eh_flush_done_q().

[ End of patch descriptions ]

 I've cross-checked with the original source to avoid missing used
paths and proof-read the new code a couple of times.  I've tested
normal, failure and unplug paths with usb and sata drives (I can
reproduce timeouts easily with my usb hd).  Not that the code is
bug-free, but just that I tried.  :-)

 If you don't like removing of empty comment lines from short
comments, let me know, I'll restore the changes and repost the
patches.

 Also, as I'm basing new implementation of scsi device states on the
new request_fn(), it would be great if you can let me know if you like
the general direction of this patchset soon.

 Thanks a lot.

--
tejun

