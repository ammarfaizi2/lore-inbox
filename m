Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132539AbRASBOw>; Thu, 18 Jan 2001 20:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132382AbRASBOb>; Thu, 18 Jan 2001 20:14:31 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:57612 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131502AbRASBOa>; Thu, 18 Jan 2001 20:14:30 -0500
Date: Thu, 18 Jan 2001 17:14:01 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roman Zippel <zippel@fh-brandenburg.de>
cc: Andreas Dilger <adilger@turbolinux.com>,
        Rogier Wolff <R.E.Wolff@bitwizard.nl>, linux-kernel@vger.kernel.org
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <Pine.GSO.4.10.10101182335320.3304-100000@zeus.fh-brandenburg.de>
Message-ID: <Pine.LNX.4.10.10101181700350.8732-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Jan 2001, Roman Zippel wrote:
> 
> On Thu, 18 Jan 2001, Linus Torvalds wrote:
> 
> > It's too damn device-dependent, and it's not worth it. There's no way to
> > make it general with any current hardware, and there probably isn't going
> > to be for at least another decade or so. And because it's expensive and
> > slow to do even on a hardware level, it probably won't be done even then.
> > 
> > [...]
> > 
> > An important point in interface design is to know when you don't know
> > enough. We do not have the internal interfaces for doing anything like
> > this, and I seriously doubt they'll be around soon.
> 
> I agree, it's device dependent, but such hardware exists.

Show me any practical case where the hardware actually exists.

I do not know of _any_ disk controllers that let you map the controller
buffers over PCI. Which means that with current hardware, you have to
assume that the disk is the initiator of the PCI-PCI DMA requests. Agreed?

Which in turn implies that the non-disk target hardware has to be able to
have a PCI-mapped memory buffer for the source or the destination, AND
they have to be able to cope with the fact that the data you get off the
disk will have to be the raw data at 512-byte granularity.

There are really quite few devices that do this. The most common example
by far would be a frame buffer, where you could think of streaming a few
frames at a time directly from disk into graphics memory. But nobody
actually saves pictures that way in reality - they all need processing to
show up. Even when the graphics card does things like mpeg2 decoding in
hardware, the decoding logic is not set up the way the data comes off the
disk in any case I know of. 

As to soundcards, all the ones I know about that are worthwhile have
certainly on-board memory, but that memory tends to be used for things
like waveforms etc, and most of them refill their audio data by doing DMA.
Again, they are the initiator of the IO, not a passive receiver. 

I'm sure there are sound cards that just expose their buffers directly.
Fine. Make a special user-space driver for it. Don't try to make it into a
design.

>							 It needs of
> course its own memory, but then you can see it as a NUMA architecture and
> we already have the support for this. Create a new memory zone for the
> device memory and keep the pages reserved. Now you can use it almost like
> other memory, e.g. reading from/writing to it using address_space_ops.

You need to have a damn special sound card to do the above.

And you wouldn't need a new memory zone - the kernel wouldn't ever touch
the memory anyway, you'd just ioremap() it if you needed to access it
programmatically in addition to the streaming of data off disk.

> An application, where I'd like to use it, is audio recording/playback
> (24bit, 96kHz on 144 channels). Although it's possible to copy that amount
> of data around, but then you can't do much beside this. All the data is
> most of the time only needed on the soundcard, so why should I copy it
> first to the main memory?

Because with 99% of the hardware, there is no other way to get at it?

Also, even when you happen to have the 1% card combination where it would
work in the first place, you'd better make sure that they are on the same
PCI bus. That's usually true on most PC's today, but that's probably going
to be an issue eventually. 

> Anyway, now with the zerocopy network patches, there are basically already
> all the needed interfaces and you don't have to wait for 10 years, so I
> think you need to polish your crystal ball. :-)

The zero-copy network patches have _none_ of the interfaces you think you
need. They do not fix the fact that hardware usually doesn't even _allow_
for what you are hoping for. And what you want is probably going to be
less likely in the future than more likely.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
