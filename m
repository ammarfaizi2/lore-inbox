Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbVDSObc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbVDSObc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 10:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVDSObb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 10:31:31 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:31116 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261555AbVDSObH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 10:31:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:subject:message-id:date;
        b=SIJNESTNiXKQFDS2j8qufuRTxaU8agxXuk9ZNJO2C3FYzjSahXgMjTdiTUSwltyICu7ZtLTrMcUQEd8OS1lfOiF2Fv+lxn44N7P2srev56aRelnfQyYBDI7t8qU4ht9jvQoUSx2P6zZcA4pUtyTZPcDs71lI9pCBV2AAyu0xYD8=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH scsi-misc-2.6 00/04] scsi: misc timer fixes (reworked)
Message-ID: <20050419143100.E231523D@htj.dyndns.org>
Date: Tue, 19 Apr 2005 23:31:01 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, James.

 This patchset contains the following patches from the previous timer
update patchset.

 02_scsi_timer_eh_timer_fix.patch
 03_scsi_timer_dispatch_race_fix.patch
 04_scsi_timer_remove_delete_timer_from_reset_provider.patch

 eh_timer_fix is reworked as you suggested and split into two
patches. (#01 and #02)

 In the current bk repository, aic7xxx_osm.c has been updated to not
use scsi_add_timer() but aic79xx_osm.c hasn't been yet.  I guess it's
gonna be updated sometime soon, so I've dropped the aic7xxx update
patch.

 As aic79xx_osm.c still uses scsi_add_timer(), timer API update
patches are omitted.  I'll repost them once aic79xx_osm.c is
converted.

 dispatch_race_fix and remove_delete_timer_from_reset_provider patches
are the same as in the previous posting.  If you've already applied
them, just ignore those two (#03 and #04).

 The following bugs are fixed.

 * Race condition between eh and normal completion path for eh_timer
 * scsi_delete_timer() race in scsi_queue_insert()

[ Start of patch descriptions ]

01_scsi_timer_eh_timer_fix.patch
	: make scsi_send_eh_cmnd use its own timer instead of scmd->eh_timeout

	scmd->eh_timeout is used to resolve the race between command
	completion and timeout.  However, during error handling,
	scsi_send_eh_cmnd uses scmd->eh_timeout.  This creates a race
	condition between eh and normal completion for a request which
	has timed out and in the process of error handling.  If the
	request completes while scmd->eh_timeout is being used by eh,
	eh timeout is lost and the command will be handled by both eh
	and completion path.  This patch fixes the race by making
	scsi_send_eh_cmnd() use its own timer.

	This patch adds shost->eh_timeout field.  The name of the
	field equals scmd->eh_timeout which is used for normal command
	timeout.  As this can be confusing, renaming scmd->eh_timeout
	to something like scmd->cmd_timeout would be good.

	Reworked such that timeout race window is kept at minimal
	level as pointed out by James Bottomley.

02_scsi_timer_eh_timer_remove_spurious_if.patch
	: remove spurious if tests from scsi_eh_{times_out|done}

	If tests which check if eh_action isn't NULL in both functions
	are always true.  Remove the if's.

03_scsi_timer_dispatch_race_fix.patch
	: remove a timer race in scsi_queue_insert()

	scsi_queue_insert() has four callers.  Three callers call with
	timer disabled and one (the second invocation in
	scsi_dispatch_cmd()) calls with timer activated.
	scsi_queue_insert() used to always call scsi_delete_timer()
	and ignore the return value.  This results in race with timer
	expiration.  Remove scsi_delete_timer() call from
	scsi_queue_insert() and make the caller delete timer and check
	the return value.

04_scsi_timer_remove_delete_timer_from_reset_provider.patch
	: remove unnecessary scsi_delete_timer() call in scsi_reset_provider()

	scsi_reset_provider() calls scsi_delete_timer() on exit which
	isn't necessary.  Remove it.

[ End of patch descriptions ]

 Thanks.

