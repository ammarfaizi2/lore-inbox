Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283249AbRK2OUw>; Thu, 29 Nov 2001 09:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283246AbRK2OUd>; Thu, 29 Nov 2001 09:20:33 -0500
Received: from gear.torque.net ([204.138.244.1]:32275 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S283245AbRK2OUX>;
	Thu, 29 Nov 2001 09:20:23 -0500
Message-ID: <3C06445A.2551CFA9@torque.net>
Date: Thu, 29 Nov 2001 09:21:14 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org
CC: linux-scsi@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: CDROM ioctl bug (fwd)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,
That patch is flawed as Jens and I found out the hard way
in the sg driver. The scsi_do_req() can lead to the pointer
chain on the following assignment into q being invalid (in 
the worst case).

The easy fix is to move the assignment into q _before_
the call to scsi_do_req().

Doug Gilbert


vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
Peter Osterlund <petero2@telia.com> wrote:

Ron Lawrence <rlawrence@netraverse.com> writes:

> busy. Here are the symptoms of my problem : doing reads from a CDROM
> device intermingled with CDROM_MEDIA_CHANGED ioctls causes long pauses
> during the ioctl. This behavior started in 2.4.10. The ioctl can take a
> very long time to return, especially if reading large chunks.

This patch fixes the problem for my USB CDROM device. Maybe a similar
patch is needed for the IDE case, I haven't looked yet.

In general, who is responsible for unplugging the request queue after
queuing an ioctl command?

--- linux/drivers/scsi/scsi.c.old       Thu Nov 29 00:42:16 2001
+++ linux/drivers/scsi/scsi.c   Thu Nov 29 00:32:28 2001
@@ -767,14 +767,17 @@
 void scsi_wait_req (Scsi_Request * SRpnt, const void *cmnd ,
                  void *buffer, unsigned bufflen, 
                  int timeout, int retries)
 {
+       request_queue_t *q;
        DECLARE_COMPLETION(wait);
        
        SRpnt->sr_request.waiting = &wait;
        SRpnt->sr_request.rq_status = RQ_SCSI_BUSY;
        scsi_do_req (SRpnt, (void *) cmnd,
                buffer, bufflen, scsi_wait_done, timeout, retries);
+       q = &SRpnt->sr_device->request_queue;
+       generic_unplug_device(q);
        wait_for_completion(&wait);
        SRpnt->sr_request.waiting = NULL;
        if( SRpnt->sr_command != NULL )
        {
