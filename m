Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289236AbSAVK1R>; Tue, 22 Jan 2002 05:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289238AbSAVK1B>; Tue, 22 Jan 2002 05:27:01 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:64445 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S289236AbSAVK0c>; Tue, 22 Jan 2002 05:26:32 -0500
Message-Id: <5.1.0.14.2.20020122101548.05416020@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 22 Jan 2002 10:26:19 +0000
To: Jens Axboe <axboe@suse.de>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Linux 2.5.3-pre1-aia1
Cc: Andre Hedrick <andre@linuxdiskcert.org>, Vojtech Pavlik <vojtech@suse.cz>,
        Davide Libenzi <davidel@xmailserver.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020122110621.K1018@suse.de>
In-Reply-To: <Pine.LNX.4.10.10201220054490.16815-100000@master.linux-ide.org>
 <20020122091653.J1018@suse.de>
 <Pine.LNX.4.10.10201220054490.16815-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

A quick question which is I think what Andre is really concerned about when 
talking about atomicity... or if he is not then I would be. (-;

At 10:06 22/01/02, Jens Axboe wrote:
>On Tue, Jan 22 2002, Andre Hedrick wrote:
> >
> > A CLUE HAS ARRIVED ...
> >
> > On Tue, 22 Jan 2002, Jens Axboe wrote:
> >
> > > On Mon, Jan 21 2002, Andre Hedrick wrote:
> > > > > On Mon, Jan 21, 2002 at 03:53:20PM -0800, Andre Hedrick wrote:
> > > > > > On Mon, 21 Jan 2002, Vojtech Pavlik wrote:
> > > > > > Okay if the execution of the command block is ATOMIC, and we 
> want to stop
> > > > > > an ATOMIC operation to go alter buffers?
> > > > >
> > > > > YES! I think you got it! Because atomic here doesn't mean 'do it 
> all as
> > > > > soon as possible with no delay', but 'do nothing else on the ATA bus
> > > > > inbetween'.
> > > >
> > > > In order to do this you can not issue a sector request larger than an
> > > > addressable buffer, since the request walking of the rq->buffer is not
> > > > allowed.
> > >
> > > It's not that it's not allowed, it's that it doesn't work the way you
> > > want it. ->buffer is just the first segment, which is 8 sectors max,
> > > that much is correct. But nothing prevents your from ending the front
> > > of the request and continuing and the drive will never know. Just see
> > > task_mulin_intr.
> >
> > Is this not the effect of stopping the actual IO?
>
>No, not at all. It goes something like this (for multi read, the case
>discussed here). Settings for this sample-run are:
>
>- multi mode set to 16 sectors
>- request: nr_sectors 24 sectors, current_nr_sectors 8. request is thus
>   split in 3 parts, we need to partially complete it do finish it.
>
>o ide_do_request, get new active request
>o start_request, hand off to ide-disk:do_rw_disk()
>o do_rw_disk: setup taskfile, arm interrupt handler, return
>
>[interrupt triggers]
>
>o status is good, we can transfer the 16 sectors the drive expects

Is it possible that the request is aborted at any point between here...

>o taskfile_input_data for 8 sectors:
>
>         nsect = rq->current_nr_sectors;
>         if (nsect > msect)
>                 nsect = msect;

>o call ide_end_request to indicate completion of these 8 sectors.
>         o calls end_that_request_last to complete the first buffer head
>           in the request, resetup request for next transfer.
>
>o ide_end_request returns 1, request is not complete.

... and ide_end_request returning 1 here so that ide_end_request would in 
fact not return 1?

If not, then there is no problem. The operation is atomic, it's just a 
switch from one destination page to another (taking this particular example 
and 4k page size), whether the switch happens fast enough is a different 
cattle of fish altogether...

If yes, I see where Andre is complaining: an abort at this position would 
leave the drive in "io in flight" state and you get "lost interrupt" and 
possibly you all goes pear shaped the first time the next command goes to 
the drive (unless it happens to be the appropriate reset command).

I hope that makes any sense?

Best regards,

Anton

>o taskfile_input_data for 8 sectors.
>
>o call ide_end_request again, still returns 1 (now we have 8 sectors
>   left in the request)
>
>o now we have transferred the 16 sectors inside the interrupt handler,
>   since request is not complete rearm interrupt handler and return.
>
>Next time task_mulin_intr is fired, we do the remaining 8 sectors. This
>time the drive knows to expect only 8 sectors, since we originally
>programmed it for 24 sectors total for this request.
>
> > Then you have to issue another ACB to restart the IO for the next segment?
> > The device has to know when to stop sending.
>
>Nope, see the above.
>
> > It may be possible to do this is paging requirement if on a READ(any pio),
> > reset or update the rq->buffer prior to reading from the data register.
>
>Yes that's very important, the ordering must be right or we are screwed.
>
> > Now what guarentee will the driver have if a the buffer being a full 8
> > sectors before the first read, and if that is not enough for the complete
> > segment transaction, then if we reduce the expected transfers size between
> > interrupts, it will allow for larger values to be put into the
> > sector_count register.  This reduction must correspond to the expected and
> > required 4k page.
>
>But why? The above scenario works.
>
> > This I can do, and we can move forward.
> >
> > If the update of the rq->buffer occurrs afterwards, we may face a
> > driver--device race w/ an early and missied interrupt asserted.
>
>We don't care about rq->buffer at all. What is important is correct (and
>ordered) rq->current_nr_sectors updates so that ide_map_rq returns the
>right transfer location.
>
> > This sounds like what "Davide Libenzi" is reporting.
> > Not really a losted, but arrived while the rq->buffer is being updated.
> > Thus ordering of events are wrong.
>
>It very well could be.
>
>--
>Jens Axboe

-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

