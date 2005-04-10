Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbVDJSqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVDJSqJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 14:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbVDJSqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 14:46:08 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:41003 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261560AbVDJSpT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 14:45:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:subject:message-id:date;
        b=VY64aXg0t/TMtiLBoHKiiBg+S46vRC/Qxx6GJP/dTj6WSUouUx+3Uuzpas0e4NUQi4KWI8dBYcqYk/7xHqq405str4DtCMFBeCvxB0wI+JZ6ARSnpQtGbNGqcDtXj2ZHSwS3OpMEOdOjJZiYHniZu+xmaFJICBCmtSITm2cVN8Y=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH scsi-misc-2.6 00/07] scsi: timer updates
Message-ID: <20050410184214.4AAD0992@htj.dyndns.org>
Date: Mon, 11 Apr 2005 03:45:06 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, James, Jens and Christoph.

 This patchset removes misuses of scmd->eh_timeout and unexports SCSI
timer interface such that no one can misuse it anymore.  #02 assumes
that the preceding scsi_send_eh_cmnd() patch is applied.  Tested and
worked for me.

 The following bugs are fixed.

 * Race condition between eh and normal completion path for eh_timer
 * scsi_delete_timer() race in scsi_queue_insert()

[ Start of patch descriptions ]

01_scsi_timer_update_aic7xxx.patch
	: make aic7xxx use its own timer instead of scmd->eh_timeout

	aic7xxx used scmd->eh_timeout in its dv routines.  This kind
	of usage requires knowledge of and creates dependency into the
	SCSI midlayer unnecessarily.  This patch makes aic7xxx driver
	use its own timer instead of scmd->eh_timeout.
	Suggested by Christoph Hellwig.

02_scsi_timer_eh_timer_fix.patch
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

05_scsi_timer_unexport_timer_functions.patch
	: unexport scsi_{add|delete}_timer()

	SCSI cmd timer has specific synchronization/semantic
	requirements and shouldn't be directly used outside SCSI
	midlayer.  With aic7xxx driver updated, there's no user left.
	This patch unexports scsi_{add|delete}_timer() routines and
	also removes @complete argument from scsi_add_timer().  The
	change makes the use of scsi_times_out() confined in
	scsi_error.c, so move it upward such that no prototype is
	needed and make it static.

06_scsi_timer_update_api_doc.patch
	: Delete scsi_{add|delete}_timer() from scsi_mid_low_api.txt

	As scsi_{add|delete}_timer() got unexported, remove them from
	the API doc.

07_scsi_timer_strict_reuse.patch
	: make reuse of SCSI cmd timer strict

	SCSI cmd timer shouldn't be reused while it's active.  Make
	sure that the unused condition is marked with
	eh_timeout->function = NULL and BUG() active reuse path.

[ End of patch descriptions ]

 Thanks a lot.

