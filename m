Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289196AbSAVIMe>; Tue, 22 Jan 2002 03:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289200AbSAVIMY>; Tue, 22 Jan 2002 03:12:24 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:20241
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S289196AbSAVIMK>; Tue, 22 Jan 2002 03:12:10 -0500
Date: Mon, 21 Jan 2002 23:52:41 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Jens Axboe <axboe@suse.de>, Davide Libenzi <davidel@xmailserver.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
In-Reply-To: <20020122082030.A12720@suse.cz>
Message-ID: <Pine.LNX.4.10.10201212333540.16815-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2002, Vojtech Pavlik wrote:

> On Mon, Jan 21, 2002 at 03:53:20PM -0800, Andre Hedrick wrote:
> > On Mon, 21 Jan 2002, Vojtech Pavlik wrote:
> > Okay if the execution of the command block is ATOMIC, and we want to stop
> > an ATOMIC operation to go alter buffers? 
> 
> YES! I think you got it! Because atomic here doesn't mean 'do it all as
> soon as possible with no delay', but 'do nothing else on the ATA bus
> inbetween'.

In order to do this you can not issue a sector request larger than an
addressable buffer, since the request walking of the rq->buffer is not
allowed.

> > But that is not the real question.  The real question is do we stop
> > and ATOMIC process to return data of a partial completeion, and then
> > return to a HALTED ATOMIC and hope it will still go?
> 
> Yes, and we can do this, and there is no reason why this should not
> work.

PONDERING ....

> > DEAD Method:
> > issue atomic write 255 sectors
> > 	write 8 sector or 4k or 1 page of memory
> > 
> > 	interrupt_issued
> > 		exit atomic write
> > 			update top layer buffers
> > 			return;
> > 	continue write_loop;
> > 	exit on completion and update remainder.
> > 
> > BASTARDIZED Method:
> > issue write 255 sectors
> > 	truncate to max of 8 sectors
> > 	issue atomic write 8 sectors
> > 		interrupt_issued
> > 		end request and notify 4k page complete
> > 	make new request and merge and repeat.
> > 	note there is a new memcpy fo new request. (max 16 to completion)
> > 
> > 
> > OLD Method, with Request Page Walking:
> > issue atomic write 255 sectors
> >         write sectors
> >         interrupt_issued
> > 		walk copy of request
> > 	continue write_loop;
> > 	exit on completion and request and free local buffer.
> > 
> > CORRECT Method:
> > collect contigious physical buffer of 255 sectors
> > memcpy_to_local (one memcpy)
> > issue atomic write 255 sectors
> > 	write sectors
> > 	interrupt_issued
> > 		update pointer
> > 	continue write_loop;
> > 	exit on completion and request and free local buffer.
> > 
> > The price of the overhead and the direct flakyness of the driver we are
> > running from is returning, so the alternative is to disable MULTI-Sector
> > Operations.
> 
> That's pretty much nonsense, beg my pardon. The real correct way would
> be:

We agreed upon error is the "memcpy_to_local" and "free local buffer".

If a low-memory contigious physical buffers was allocated and all the
bounce_memory locations were copied there before submition to the lower
levels, the drives could run down the buffer and be done, preserve the
entire request for error handling when a write to media fails.

> issue read of 255 sectors using READ_MULTI, max_mult = 16
> receive interrupt
> 	inw() first 4k to buffer A
> 	inw() second 4k to buffer B
> don't do anything else until the next interrupt

The second buffer has been taken away, so this is not possible.

> There is absolutely no need for an intermediate scratch buffer, you can
> put the inw()ed data anywhere you like, and if you need any post
> processing, you can do it as well, at any time.

Explain where buffer B come from, because I am totally lost on the above.

I am totally worn out and do not care about the issue anymore for now.

Regards

--a

