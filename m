Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287493AbSAVJwh>; Tue, 22 Jan 2002 04:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289218AbSAVJw1>; Tue, 22 Jan 2002 04:52:27 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:27921
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S289212AbSAVJwI>; Tue, 22 Jan 2002 04:52:08 -0500
Date: Tue, 22 Jan 2002 01:45:47 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Jens Axboe <axboe@suse.de>
cc: Vojtech Pavlik <vojtech@suse.cz>, Davide Libenzi <davidel@xmailserver.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
In-Reply-To: <20020122091653.J1018@suse.de>
Message-ID: <Pine.LNX.4.10.10201220054490.16815-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A CLUE HAS ARRIVED ...

On Tue, 22 Jan 2002, Jens Axboe wrote:

> On Mon, Jan 21 2002, Andre Hedrick wrote:
> > > On Mon, Jan 21, 2002 at 03:53:20PM -0800, Andre Hedrick wrote:
> > > > On Mon, 21 Jan 2002, Vojtech Pavlik wrote:
> > > > Okay if the execution of the command block is ATOMIC, and we want to stop
> > > > an ATOMIC operation to go alter buffers? 
> > > 
> > > YES! I think you got it! Because atomic here doesn't mean 'do it all as
> > > soon as possible with no delay', but 'do nothing else on the ATA bus
> > > inbetween'.
> > 
> > In order to do this you can not issue a sector request larger than an
> > addressable buffer, since the request walking of the rq->buffer is not
> > allowed.
> 
> It's not that it's not allowed, it's that it doesn't work the way you
> want it. ->buffer is just the first segment, which is 8 sectors max,
> that much is correct. But nothing prevents your from ending the front
> of the request and continuing and the drive will never know. Just see
> task_mulin_intr.

Is this not the effect of stopping the actual IO?
Then you have to issue another ACB to restart the IO for the next segment?
The device has to know when to stop sending.

ERM, the pain is sinking in .....

It may be possible to do this is paging requirement if on a READ(any pio),
reset or update the rq->buffer prior to reading from the data register.
Now what guarentee will the driver have if a the buffer being a full 8
sectors before the first read, and if that is not enough for the complete
segment transaction, then if we reduce the expected transfers size between
interrupts, it will allow for larger values to be put into the
sector_count register.  This reduction must correspond to the expected and
required 4k page.

This I can do, and we can move forward.

If the update of the rq->buffer occurrs afterwards, we may face a
driver--device race w/ an early and missied interrupt asserted.

This sounds like what "Davide Libenzi" is reporting.
Not really a losted, but arrived while the rq->buffer is being updated.
Thus ordering of events are wrong.

forced to set max_multi_sector to page size.

cmd->(buffer must be attached)->isr(statDRQ|BSY,read2buffer)->reload_isr()
	isr_n(get_new_buffer,statDRQ|BSY,read2buffer)->reload_isr()

if we relaunch because of statDRQ|BSY is not correct, we need to know the
new buffer is loaded.

writing becomes more interesting.

I have to overlay lay Linux on to the state diagrams and then redraft.

Cheers,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development


