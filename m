Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264288AbUA2J0S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 04:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263609AbUA2J0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 04:26:18 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:24998 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263587AbUA2J0H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 04:26:07 -0500
Date: Thu, 29 Jan 2004 01:30:51 -0800
From: Mike Anderson <andmike@us.ibm.com>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: 2.6.1: media change check fails for busy unplugged device
Message-ID: <20040129093051.GA1556@beaverton.ibm.com>
Mail-Followup-To: Andrey Borzenkov <arvidjaar@mail.ru>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	James Bottomley <James.Bottomley@steeleye.com>
References: <200401182141.12468.arvidjaar@mail.ru> <20040119233641.GA1859@beaverton.ibm.com> <200401262216.42966.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401262216.42966.arvidjaar@mail.ru>
X-Operating-System: Linux 2.0.32 on an i486
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Borzenkov [arvidjaar@mail.ru] wrote:
> On Tuesday 20 January 2004 02:36, Mike Anderson wrote:
> > Andrey Borzenkov [arvidjaar@mail.ru] wrote:
> > > If we unplug busy device (consider mounted USB stick) media change check
> > > always returns true (no media change happened). It happens because
> > >
> > > - device state is set to SDEV_DEL and scsi_prep_fn silently kills any
> > > request including TEST_UNIT_READY sent by sd_media_changed without
> > > propagating any information back to caller
> >
> > The silently kill would appear to be the issue. The addition of any
> > number of additional checks prior to calling scsi_ioctl would not ensure
> > that as soon as the last check is done the device state has not changed.
> >
> 
> But why sdev->online remains set after device has been deleted? It is 
> definitely cannot accept any command after that point?
> 
> Is it possible to clear sdev->online in scsi_remove_device? That would solve 
> the problem.
> 

The sdev->online flag was left as is when the device state model was
update as we where overloading the meaning on this flag. I believe James
last statement on this was that we need to merge this in at some point
(correct James?).

As I previously stated above no flag checking will work in this case
(you can make the race smaller) as it can go SDEV_DEL or offline false
after all kinds of checks, but prior to running the command. The
scsi_wait_req needs to handle the case that it might have been woken up
by someone else beside scsi_wait_done. One way to do this would be the
patch below. I did some testing using a ioctl to the sd device that had
been deleted. The patch changed the result return by the ioctl from
success to failure (It should be noted that there is some odd behavior
in the ioctl_internal_command in that it will not return negative errno
values but instead returns the result of the command which will be
positive under errors). We probably need to come up with a better method
than the test in the patch to determine that a request was killed, but
it should be valid enough to test to see if it solves your issue.

-andmike
--
Michael Anderson
andmike@us.ibm.com

DESC
If a request is sent through scsi_wait_req the function may be woken up
from the completion by a function other than scsi_wait_done. This can
happen as a result of cases that return BLKPREP_KILL in the scsi_prep_fn
function.

author: Mike Anderson <andmike@us.ibm.com>
patch_version: Thu Jan 29 09:03:44 UTC 2004
EDESC


 patched-2.6-andmike/drivers/scsi/scsi_lib.c |    2 ++
 1 files changed, 2 insertions(+)

diff -puN drivers/scsi/scsi_lib.c~sdev_del_scsi_wait_req drivers/scsi/scsi_lib.c
--- patched-2.6/drivers/scsi/scsi_lib.c~sdev_del_scsi_wait_req	Mon Jan 26 18:31:45 2004
+++ patched-2.6-andmike/drivers/scsi/scsi_lib.c	Mon Jan 26 18:50:51 2004
@@ -238,6 +238,8 @@ void scsi_wait_req(struct scsi_request *
 	generic_unplug_device(sreq->sr_device->request_queue);
 	wait_for_completion(&wait);
 	sreq->sr_request->waiting = NULL;
+	if (sreq->sr_request->rq_status != RQ_SCSI_DONE)
+		sreq->sr_result |= (DRIVER_ERROR << 24);
 
 	__scsi_release_request(sreq);
 }

_
