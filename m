Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282194AbRK1Xwo>; Wed, 28 Nov 2001 18:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282211AbRK1XwH>; Wed, 28 Nov 2001 18:52:07 -0500
Received: from mailf.telia.com ([194.22.194.25]:18159 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S282192AbRK1Xvy>;
	Wed, 28 Nov 2001 18:51:54 -0500
To: Ron Lawrence <rlawrence@netraverse.com>
Cc: <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: CDROM ioctl bug (fwd)
In-Reply-To: <Pine.LNX.4.33.0111281009140.1724-100000@monster.jayfay.com>
From: Peter Osterlund <petero2@telia.com>
Date: 29 Nov 2001 00:51:46 +0100
In-Reply-To: <Pine.LNX.4.33.0111281009140.1724-100000@monster.jayfay.com>
Message-ID: <m2elmi1mjx.fsf@ppro.localdomain>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ron Lawrence <rlawrence@netraverse.com> writes:

> busy. Here are the symptoms of my problem : doing reads from a CDROM
> device intermingled with CDROM_MEDIA_CHANGED ioctls causes long pauses
> during the ioctl. This behavior started in 2.4.10. The ioctl can take a
> very long time to return, especially if reading large chunks.

This patch fixes the problem for my USB CDROM device. Maybe a similar
patch is needed for the IDE case, I haven't looked yet.

In general, who is responsible for unplugging the request queue after
queuing an ioctl command?

--- linux/drivers/scsi/scsi.c.old	Thu Nov 29 00:42:16 2001
+++ linux/drivers/scsi/scsi.c	Thu Nov 29 00:32:28 2001
@@ -767,14 +767,17 @@
 void scsi_wait_req (Scsi_Request * SRpnt, const void *cmnd ,
  		  void *buffer, unsigned bufflen, 
  		  int timeout, int retries)
 {
+	request_queue_t *q;
 	DECLARE_COMPLETION(wait);
 	
 	SRpnt->sr_request.waiting = &wait;
 	SRpnt->sr_request.rq_status = RQ_SCSI_BUSY;
 	scsi_do_req (SRpnt, (void *) cmnd,
 		buffer, bufflen, scsi_wait_done, timeout, retries);
+	q = &SRpnt->sr_device->request_queue;
+	generic_unplug_device(q);
 	wait_for_completion(&wait);
 	SRpnt->sr_request.waiting = NULL;
 	if( SRpnt->sr_command != NULL )
 	{

-- 
Peter Österlund             petero2@telia.com
Sköndalsvägen 35            http://w1.894.telia.com/~u89404340
S-128 66 Sköndal            +46 8 942647
Sweden
