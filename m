Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbVANWod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVANWod (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 17:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVANWod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 17:44:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:13449 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261368AbVANWoW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 17:44:22 -0500
Date: Fri, 14 Jan 2005 14:44:04 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Oeser <ioe-lkml@axxeo.de>
cc: linux@horizon.com, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Make pipe data structure be a circular list of pages, rather
In-Reply-To: <200501142312.50861.ioe-lkml@axxeo.de>
Message-ID: <Pine.LNX.4.58.0501141430320.2310@ppc970.osdl.org>
References: <20050108082535.24141.qmail@science.horizon.com>
 <200501142203.44720.ioe-lkml@axxeo.de> <Pine.LNX.4.58.0501141318030.2310@ppc970.osdl.org>
 <200501142312.50861.ioe-lkml@axxeo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 14 Jan 2005, Ingo Oeser wrote:
> 
> Data sink/source is simple, indeed. You just implemented a buffering
> between a drivers output filp, if I understand you correctly.

Yes and no. It is indeed just buffering.

The thing I find most intriguing about it, and which is why I htink it's
important is that while it's "just" buffering, it is _standard_ buffering.  
That's where it gets interesting. Everybody needs buffers, and they are
generally so easy to implement that there's no point in having much of a 
"buffer library". 

But it the standard way allows you to do interesting stuff _between_ two 
things, than that's where it gets interesting. The combinations it allows.

> Now both directions together and it gets a bit more difficult.
> Driver writers basically reimplement fs/pipe.c over and over again.

But bidirectional is just two of those things. 

> Always the same basic operations for that needing the same structure
> to handle it.

Yes.

> Maybe the solution here is just using ONE fd and read/write to it.

No. Use two totally separate fd's, and make it _cheap_ to move between 
them. That's what "splice()" gives you - basically a very low-cost way to 
move between two uni-directional things. No "memcpy()", because memcpy is 
expensive for large streams of data.

> > > We also don't have wire_fds(), which would wire up two fds by
> > > connecting the underlying file pointers with each other and closing the
> > > fds.
> >
> > But that is _exactly_ what splice() would do.
> >
> > So you could have the above open of "/dev/mpeginput", and then you just> > sit and splice the result into a file or whatever.
> >
> > See?
> 
> But you are still pushing everything through the page cache.
> I would like to see "fop->connect(producer, consumer)"

No no. There's no buffer cache involved. There is just "buffers".

If you end up reading from a regular file (or writing to one), then yes,
the buffers end up being picked up from the buffer cache. But that's by no
means required. The buffers can be just anonymous pages (like the ones a
regular "write()" to a pipe generates), or they could be DMA pages
allocated for the data by a device driver. Or they could be the page that
contains a "skb" from a networking device. 

I really think that splice() is what you want, and you call "wire()". 

> Imagine 3 chips. One is a encoder/decoder chip with 8 channels, the other
> 2 chips are a video DAC/ADC and an audio DAC/ADC with 4 channels each.
> 
> These chips can be wired directly by programming a wire matrix (much like a 
> dumb routing table). But you can also receive/send via all of these chips
> to/from harddisk for recording/playback. 
> 
> So you have to implement the drivers for these chips to provide one filp per 
> channel and one minor per chip.
> 
> If I can do this with splice, you've got me and I'm really looking forward to 
> your first commits/patches, since this itch is scratching me since long ;-)

Yes, I believe that we're talking about the same thing. What you can do in 
my vision is:

 - create a pipe for feeding the audio decoder chip. This is just the 
   sound driver interface to a pipe, and it's the "device_open()" code I 
   gave as an example in my previous email, except going the other way (ie 
   the writer is the 'fd', and the driver is the "reader" of the data).

   You'd do this with a simple 'fd = open("/dev/xxxx", O_WRONLY)",
   together with some ioctl (if necessary) to set up the actual
   _parameters_ for the piped device.

 - do a "splice()" from a file to the pipe. A splice from a regular file 
   is really nothing but a page cache lookup, and moving those page cache 
   pages to the pipe.

 - tell the receiving fd to start processing it (again, this might be an 
   ioctl - some devices may need directions on how to interpret the data,
   or it might be implicit in the fact that the pipe got woken up by being 
   filled)

Going the other way (receiving data from a hardware device) is all the 
same thing - and there "tee()" may be useful, since it would allow the 
received data to be dup'ed to two different sinks.

		Linus
