Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289350AbSAVSzp>; Tue, 22 Jan 2002 13:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289346AbSAVSxG>; Tue, 22 Jan 2002 13:53:06 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:53265
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S289347AbSAVSv2>; Tue, 22 Jan 2002 13:51:28 -0500
Date: Tue, 22 Jan 2002 10:45:01 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Vojtech Pavlik <vojtech@suse.cz>, Jens Axboe <axboe@suse.de>,
        Davide Libenzi <davidel@xmailserver.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
In-Reply-To: <Pine.LNX.4.33.0201220844120.1799-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10201221012150.18161-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2002, Linus Torvalds wrote:

> 
> On Tue, 22 Jan 2002, Vojtech Pavlik wrote:
> >
> > That's pretty much nonsense, beg my pardon. The real correct way would
> > be:
> >
> > issue read of 255 sectors using READ_MULTI, max_mult = 16
> > receive interrupt
> > 	inw() first 4k to buffer A
> > 	inw() second 4k to buffer B
> > don't do anything else until the next interrupt
> 
> Definitely.
> 
> There is no way the controller can even _know_ the difference between
> 
>  - one large 8kB "rep insw" instruction
>  - two (or more) smaller chunks of "rep insw" adding up to 8kB worth of
>    "inw"
> 
> as long as there are no other IO instructions to that controller in
> between. The two look _exactly_ the same on the bus - there aren't even
> any bursting issues (you can only burst on MMIO, not PIO accesses).
> 
> Sure, there are some timing issues, but (a) data cache misses are much
> bigger things than just a few instructions, and (b) we allow interrupts
> from other devices anyway, so the timing _really_ isn't even an issue.
> 
> So just call "ata_input_data()" several times in a loop for discontinuous
> buffers. I told Andre this before.

Linus,

Then do you mind if we add a page alignment (on the page) to the buffer
based on the rq->current_nr_sectors and to insure a complete page of all
4k of data is present?  Only because during the transition between
these two states HPIOO0:HPIOO1 is data permitted.  If you touch the data
register to write or read and by chance (almost always in Linux) you do
not have a enough data to complete the HPIOO1, the ide_end_request stops
the data process.  It is only proper to to reject unaligned pages when it
is known to invoke an cause HOST:DEVICE pair problems.

Since the only way to insure the correct amount data is present and not
risk/create a device driver race, is to reject unaligned pages.

So understand you (Linus) clearly and no mistakes are made in translation,
you want, approve, and specify data transfers on on unaligned pages.  You
require the data-phase at HPIOO1(trasnfer data) to leave and go hunt for
more unaligned pages to complete the transaction.  There is a problem
because nowhere can I find a transition point go find more data.

Some how you have gotten it in you head it is legal and correct to issue
partial data blocks, and has thrown me for a loop.

Respectfully,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

