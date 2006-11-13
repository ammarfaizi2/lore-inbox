Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755247AbWKMUAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755247AbWKMUAX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 15:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755251AbWKMUAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 15:00:23 -0500
Received: from brick.kernel.dk ([62.242.22.158]:882 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1755247AbWKMUAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 15:00:21 -0500
Date: Mon, 13 Nov 2006 21:02:56 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Alex Romosan <romosan@sycorax.lbl.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1 (+ide-cd patches) regression: unable to rip cd
Message-ID: <20061113200256.GC15031@kernel.dk>
References: <20061110161355.GB15031@kernel.dk> <87u01717qw.fsf@sycorax.lbl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87u01717qw.fsf@sycorax.lbl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10 2006, Alex Romosan wrote:
> Jens Axboe <jens.axboe@oracle.com> writes:
> 
> > Can you retest with this? This must be where the wrong write bit comes
> > from.
> >
> > diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
> > index 2dc3264..a19338e 100644
> > --- a/block/scsi_ioctl.c
> > +++ b/block/scsi_ioctl.c
> > @@ -246,10 +246,10 @@ static int sg_io(struct file *file, requ
> >  		switch (hdr->dxfer_direction) {
> >  		default:
> >  			return -EINVAL;
> > -		case SG_DXFER_TO_FROM_DEV:
> >  		case SG_DXFER_TO_DEV:
> >  			writing = 1;
> >  			break;
> > +		case SG_DXFER_TO_FROM_DEV:
> >  		case SG_DXFER_FROM_DEV:
> >  			break;
> >  		}
> >
> 
> i think this finally got it to work! when i start cdparanoia now i get
> (all the previous debug patches are still applied):
> 
> kernel: ide-cd: starting INQ da76fee4
> kernel: ide-cd: newpc da76fee4
> kernel: ide-cd: newpc da76fee4
> kernel: ide-cd: newpc end INQ da76fee4
> 
> and then when it gets to the parts where the cd might have some
> problems i get a bunch of:
> 
> kernel: hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
> kernel: hdc: packet command error: error=0xb4 { AbortedCommand LastFailedSense=0x0b }
> kernel: ide: failed opcode was: unknown
> kernel: ATAPI device hdc:
> kernel:   Error: Aborted command -- (Sense key=0x0b)
> kernel:   (reserved error code) -- (asc=0x11, ascq=0x11)
> kernel:   The failed "Read CD" packet command was: 
> kernel:   "be 00 00 00 51 93 00 00 0d f8 00 00 00 00 00 00 "
> 
> but cdparanoia continues (albeit more slowly) and eventually finishes.
> thank you!

Great, problem fixed then, patch is already merged upstream so 2.6.19
and next -rc (if any :-) should work. Thanks for your persistent
testing.

-- 
Jens Axboe

