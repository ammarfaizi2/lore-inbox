Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131044AbRASKfO>; Fri, 19 Jan 2001 05:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131152AbRASKfF>; Fri, 19 Jan 2001 05:35:05 -0500
Received: from baldur.fh-brandenburg.de ([195.37.0.5]:33716 "HELO
	baldur.fh-brandenburg.de") by vger.kernel.org with SMTP
	id <S131044AbRASKe6>; Fri, 19 Jan 2001 05:34:58 -0500
Date: Fri, 19 Jan 2001 11:13:35 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andreas Dilger <adilger@turbolinux.com>,
        Rogier Wolff <R.E.Wolff@bitwizard.nl>, linux-kernel@vger.kernel.org
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <Pine.LNX.4.10.10101181700350.8732-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.10.10101190951390.23899-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 18 Jan 2001, Linus Torvalds wrote:

> > I agree, it's device dependent, but such hardware exists.
> 
> Show me any practical case where the hardware actually exists.

http://www.augan.com

> I do not know of _any_ disk controllers that let you map the controller
> buffers over PCI. Which means that with current hardware, you have to
> assume that the disk is the initiator of the PCI-PCI DMA requests. Agreed?

Yes.

> I'm sure there are sound cards that just expose their buffers directly.
> Fine. Make a special user-space driver for it. Don't try to make it into a
> design.
> [..]
> You need to have a damn special sound card to do the above.

That's true. "Soundcard" is actually a small understatement. :)
Why should I make a new design for it, then it fits nicely into the
current design?

> And you wouldn't need a new memory zone - the kernel wouldn't ever touch
> the memory anyway, you'd just ioremap() it if you needed to access it
> programmatically in addition to the streaming of data off disk.

ioremapped memory is not the same (that's what we do right now), you have
to fake some virtual address to get the data to the right physical
location.

> Also, even when you happen to have the 1% card combination where it would
> work in the first place, you'd better make sure that they are on the same
> PCI bus. That's usually true on most PC's today, but that's probably going
> to be an issue eventually. 

I agree, it's a special setup.

> > Anyway, now with the zerocopy network patches, there are basically already
> > all the needed interfaces and you don't have to wait for 10 years, so I
> > think you need to polish your crystal ball. :-)
> 
> The zero-copy network patches have _none_ of the interfaces you think you
> need. They do not fix the fact that hardware usually doesn't even _allow_
> for what you are hoping for. And what you want is probably going to be
> less likely in the future than more likely.

It's about direct i/o from/to pages, for that you need a page struct (so
the ioremapping doesn't work). See the memory on the pci card as normal
memory, except that you can't allocate it normally, but you can still
organize it like normal memory. All you need to do is to setup this memory
area, then you can use it like normal memory, e.g. I can put it into the
page cache and I can do a normal read/write with it. The changes are very
minor, but it would solve so much other problems (especially alias
issues).

I know, that this isn't possible with any hardware combination,
nonetheless it's not that a big problem to support it where it's possible.

bye, Roman


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
