Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161532AbWJ3XSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161532AbWJ3XSc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 18:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161464AbWJ3XSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 18:18:32 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:2497 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161435AbWJ3XSb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 18:18:31 -0500
Message-ID: <45468845.20400@us.ibm.com>
Date: Mon, 30 Oct 2006 15:18:29 -0800
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
Organization: IBM LTC
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Alexis Bruemmer <alexisb@us.ibm.com>
Subject: [PATCH] 0/3: Fix EH problems in libsas and implement more error handling
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The following three patches are early drafts of a series of patches to
fix error handling in libsas so that the scsi_eh_* functions are called
so that we can attempt to retry failed commands later.  There is also a
patch to aic94xx to make escb errors are detected correctly,
REQ_TASK_ABORT is handled, and the beginnings of a handler for
REQ_DEVICE_RESET.

However, there are a number of issues with these patches that I wish to
bring to the attention of this mailing list for further input:

First, the aic94xx sequencer can send back an ESCB with an error code of
"REQ_TASK_ABORT", which means that the kernel has to send an ABORT TASK
TMF to sequencer to unjam things.  Until this happens, the sequencer
neither services commands nor sends back completions.  If we want to
wait for the error handler to send the ABORT TASK, we end up waiting for
_all_ pending commands to time out so that the EH can wake up.  This
effectively stalls the system for 30 seconds every time we see
REQ_TASK_ABORT.

On the assumption that we'd like to get on with things sooner than
later, the current iteration of these patches aborts the task as soon as
possible so that the other pending commands will flush out on their own.
 However, this also necessitates the addition of a new sas_task flag
(SAS_TASK_INITIATOR_ABORTED) to indicate "Task aborted, but still
waiting for the EH to call task_done."  From what I can tell,
SAS_TASK_STATE_ABORTED means that the task will be lldd_abort_task'd by
the EH at some point, but does not indicate if that has been done yet,
and SAS_TASK_STATE_DONE is set after everything is done.

The second issue is the manual decrementing of shost->host_failed in the
error handler.  So long as we use the scsi_eh_* commands this value is
decremented automatically--however, it appears that sas_scsi_clear_* is
pulling scsi_cmnds off the error queue and ... dropping them so that
they never go through the error handler.  Is this a desirable behavior,
or am I reading the code incorrectly?  Or...?

The third pertains to REQ_DEVICE_RESET: I've not yet figured out how to
reset a device port as has been hinted that I must do.  I don't know if
a phy reset is sufficient or if I'm barking up the wrong tree.

In any case, these patches have been tested on a x206m, x260 and a x366.
 They seemed pretty stable, though YMMV.  The patches should apply
against linux-2.6.19-rc3 + scsi-misc + scsi-rc-fixes + aic94xx git trees
in the order that they are posted.  They may also eat your disks.

Questions/comments?  This is still very much a work in progress and at
this stage I'm merely seeking constructive feedback to mould this code
into better shape.

--D
