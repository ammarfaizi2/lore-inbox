Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311366AbSCNGaF>; Thu, 14 Mar 2002 01:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311449AbSCNG3z>; Thu, 14 Mar 2002 01:29:55 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:58378
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S311366AbSCNG3n>; Thu, 14 Mar 2002 01:29:43 -0500
Date: Wed, 13 Mar 2002 22:28:25 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Jens Axboe <axboe@suse.de>, Karsten Weiss <knweiss@gmx.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre3
In-Reply-To: <Pine.LNX.4.21.0203140139310.4725-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.10.10203132148100.21396-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2002, Marcelo Tosatti wrote:

> 
> 
> On Wed, 13 Mar 2002, Andre Hedrick wrote:
> 
> > 
> > Jens,
> > 
> > Please try again because that is not the real problem.
> > All you have shown is that we disagree on the method of page walking
> > between BLOCK v/s IOCTL.  This is very minor and I agreed that it is
> > reasonable to map the IOCTL buffer in to BH or BIO so this is a net zero
> > of negative point.
> > 
> > How about attempting to describe the differences between the atomic and
> > what is violated by who and where.
> 
> Andre, 
> 
> Jens just described what can be violated:
> 
> "First of all, rq->buffer cannot be indexed for the entire nr_sectors
> range -- it's per definition only the first segment in the request, and
> can as such only be indexed within the first current_nr_sectors number of
> sectors. The above can be grossly out of range..." 
> 
> Can you tell me why his is wrong ?
> 
> BTW, I just checked 2.5 and it seems to be the similar (on the non-BIO
> case).

Jens is absolutely correct for the internal kernel usage of rq->buffer.
Given the kernel side of the equation uses single BH pages handed down
from block, the max. content represented by rq->current_nr_sectors is a
single page.  This is depended on arch, but generally sized at 4k.
This 4k page represents a max. of 8 (512 byte) sectors.  In general any
given driver does not know if it will have a full page or not.  IIRC in an
irc chat with alex viro, he made it completely clear that it could/would
be acceptable to reject unaligned full pages from block.  It startled me
at first but he is correct.

Now for the ioctl side of life.  It creates and maps its list of pointer
to rq->buffer too, but it comes for a kmalloc.  This is a contigious
buffer.  Therefore in this case the computation for position for windowing
the hardware segment for IO is referenced by

rq->nr_sectors - rq->current_nr_sectors

Where rq->nr_sectors == rq->current_nr_sectors in the beginning when zero
sectors have been transfered.  The difference provides your referrence
starting point on the contigious rq->buffer.

Again Jens' point about the kernel/block side of the issue is correct.
My point from the ioctl side of the issue is correct.

Now how do we make both sides of the interface use a comman IO path?

Cheers,

Andre Hedrick


