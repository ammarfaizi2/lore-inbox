Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288344AbSAVJMy>; Tue, 22 Jan 2002 04:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288354AbSAVJMp>; Tue, 22 Jan 2002 04:12:45 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:24081
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S288344AbSAVJM2>; Tue, 22 Jan 2002 04:12:28 -0500
Date: Tue, 22 Jan 2002 00:52:47 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Jens Axboe <axboe@suse.de>
cc: Andre Hedrick <andre@linuxdiskcert.org>,
        Petr Vandrovec <VANDROVE@vc.cvut.cz>, Vojtech Pavlik <vojtech@suse.cz>,
        Davide Libenzi <davidel@xmailserver.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.3-pre1-aia1
In-Reply-To: <20020122085841.I1018@suse.de>
Message-ID: <Pine.LNX.4.10.10201220023100.16815-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Last volly for a while ...

On Tue, 22 Jan 2002, Jens Axboe wrote:

> On Mon, Jan 21 2002, Andre Hedrick wrote:
> > In PIO there is no scatter gather possible without a memcpy to a
> > contigious buffer period.  Therefore under the contstraints issued bu
> 
> Why?

Okay provide one and a way to referrence from start point and encapsulated
around segments.

> > Linus and Jens, of access to one 4k page of memory, and a forced
> > requirement to return back every 4k page of memory of completion prevents
> > one from ever transaction more than 8 sectors per request in PIO any mode.
> 
> You don't understand... It's not forced, it's just _the sane way to do
> it_. When you finish I/O on a chunk of data, end I/O on that chunk of
> data. This doesn definitely _not_ prevent transaction of more than 8
> sectors per request, that's nonsense. It's only that way in the current
> kernel because it was easy to get right the first time around. And it's
> only in multi-write, oh look at multi-read, that does 16 sectors at the
> time. Weee!

We really have a disconnect.

Everytime command register is written to the drive see a new requst.

You are calling this a segment ??

> > start_request_sectors (255 sectors) max
> > 
> > make_request (start_request_sectors())
> > 
> > 	do_request()
> > 	ide-disk get (255 sectors)
> > 		block truncates to 8 sectors max
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Wrong

Exclude DMAing.

When the sector_count register is set to a value smaller than the total
request entering, is that not truncating the IO?

> > 	ide-taskfile
> > 		transfers 8 sectors max
>                 ^^^^^^^^^^^^^^^^^^^^^^^
> 
> Wrong

How, the constaints are on 4k boundaries or a single page.
4k == 8-512byte sectors.

> > 		end request (return 247 sectors)
> > 
> > upate_request(247 to be re issued, + additional max of 8)	
> 
> end_request _is_ the update request. You seem to not understand that
> calling ide_end_request does not mean that we are terminating the
> request from the host side, we are merely asking the block layer to
> complete xxx amount of sectors for us so we can continue doing the
> request residual.

Okay, I see there is a lot more code in block to decode.
Because the assumption of the ISR's submitted is for exclusive ownership
of the request and buffer from head to tail for the duration of the
total request.  This asumption is similar to DMA executing and total
ownership until completing.  This may be a folly wrt to interfacing to the
block layer.

> > 	make_request (247 to be re issued, + additional max of 8)
> 
> Very wrong, make_request is never called here. Let me out line what
> happens. Do you really mean start_request, if so then yes.

Wait, if the original request requires multiple executions of the command
block then they are separate requests.

> > This is why I am going to request for backing out again because the BLOCK
> > API without a MID-LAYER to buffer against the goal of the kernel,
> > conflicts with the hardware rules requirements.  Until a satisfactory
> 
> end_that_request_first understands partial completion of any size in
> 2.5, what more of a mid layer do you want?

One which interfaces to the hardware exactly, but it appears not possible.
One having the size of the total request and exclusive ownership be
mappable for the duration of the IO.

There are issues associated w/ the barrier down block and how to notify.
Thus owning the entire buffer exclusive for a flush cache barrier write is
needed and may be required.  Unless there is a way to notify based on the
LBA physical sector or "block" of the beginning of the error reported,
problems will arrise in journaling filesystems.  The rational for
maintaining ownership of an (attempted) ordered write and down block, the
hardware will not guarentee the data beyond the error returned from the
flush-cache command.

> > agreement can be reached then the current direction it is going will trash
> > the Virtual DMA hardware coming in the future.
> 
> Is that so?

Yes but we can cross that path when I release the MMIO driver(s) and core.

So I will wander off and think some more, because I see your reference
frame now, but I wonder if you see mine.

Regards,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

