Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262705AbVCWCOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbVCWCOw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 21:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262715AbVCWCOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 21:14:49 -0500
Received: from rproxy.gmail.com ([64.233.170.202]:49271 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262703AbVCWCOY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 21:14:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:subject:message-id:date;
        b=AzJdhbpnBhWckWh8Gk8d/X3lSxLBG/8nrQQq5WlyJyOQnZJ6piYynwZyuV93npBuSrwYRm/LPfw6CnoleKafyp814cVe67UZYADCbgKnbXoWJZh1c9aqyajNdcNgpYMrRZFvzukoZIdBS+5zE+zgHADGXOS2P2BMVaHEbHojjO0=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH scsi-misc-2.6 00/08] scsi: small fixes & cleanups
Message-ID: <20050323021335.960F95F8@htj.dyndns.org>
Date: Wed, 23 Mar 2005 11:14:19 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, James.
 Hello, Jens.

 These are series of small fixes & cleanups.  The last two patches
deal with reference counting and hot unplugging oops.  Patches are
against scsi-misc-2.6 tree (this is the devel tree, right?).

 Jens, please try #08 and tell me if you still get oops.  AFAICT,
reference counting isn't the issue here.  We're over-counting not
under-counting (see description of #07).

 All compile cleanly and I haven't found any problem yet.  USB
hot-unplugging doesn't create oops or offline device anymore for me.

[ Start of patch descriptions ]

01_scsi_remove_scsi_release_buffers.patch
	: remove unused bounce-buffer release path

	Buffer bouncing hasn't been done inside the scsi midlayer for
	quite sometime now, but bounce-buffer release paths are still
	around.  This patch removes these unused paths.	

02_scsi_no_special_on_requeue.patch
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
	about timer reuses.  Now timer expiration function clears
	->function and all timer deletion should go through
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

07_scsi_refcnt_cleanup.patch
	: remove bogus {get|put}_device() calls

	SCSI request submission paths can be categorized like the
	following.

	* through high-level driver (sd, st, sg...)
		+ requests (fs / pc)
		+ ioctls
		+ flushes (issue_flush / barrier rqs)
		+ backing dev (unplug fn / field referencing)
		+ high-level specific (init / revalidation...)
	* through scsi-midlayer
		+ midlevel specific (init...)
		+ transport specific (domain validations...)

	All accesses either

	* open high-level driver before submitting requests and
	  closes with no request left.
	* get_device() before submitting requests and put_device()
          with no request left.

	So, basically, SCSI high-level object (scsi_disk) and
	mid-level object (scsi_device) are reference counted by users,
	not the requests they submit.  Reference count cannot go zero
	with active users and users cannot access the object once the
	reference count reaches zero.

	So, the {get/put}_device() calls in scsi_get_command() and
	scsi_request_fn() are bogus and misleading.  In addition,
	get_device() cannot synchronize 1->0 and 0->1 transitions and
	always returns the device pointer given as the argument.  The
	== NULL tests are just misleading.

08_scsi_hot_unplug_fix.patch
	: fix hot unplug sequence

	When hot-unplugging using scsi_remove_host() function (as usb
	does), scsi_forget_host() used to be called before
	scsi_host_cancel().  So, the device gets removed first without
	request cleanup and scsi_host_cancel() never gets to call
	scsi_device_cancel() on the removed devices.  This results in
	premature completion of hot-unplugging process with active
	requests left in queue, eventually leading to hang/offlined
	device or oops when the active command times out.

	This patch makes scsi_remove_host() call scsi_host_cancel()
	first such that the host is first transited into cancel state
	and all requests of all devices are killed, and then, the
	devices are removed.  This patch fixes the oops in eh after
	hot-unplugging bug.

[ End of patch descriptions ]

 Thanks a lot.

--
tejun

