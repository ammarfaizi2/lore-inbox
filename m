Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130376AbRASK6u>; Fri, 19 Jan 2001 05:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131369AbRASK6k>; Fri, 19 Jan 2001 05:58:40 -0500
Received: from 13dyn160.delft.casema.net ([212.64.76.160]:29715 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S130376AbRASK6Z>; Fri, 19 Jan 2001 05:58:25 -0500
Message-Id: <200101191058.LAA29762@cave.bitwizard.nl>
Subject: Re: Is sendfile all that sexy? (fwd)
To: adilger@turbolinux.com, linux-kernel@vger.kernel.org,
        zippel@fh-brandenburg.de
Date: Fri, 19 Jan 2001 11:58:03 +0100 (MET)
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Torvalds wrote:
> I do not know of _any_ disk controllers that let you map the controller
> buffers over PCI. Which means that with current hardware, you have to
> assume that the disk is the initiator of the PCI-PCI DMA requests. Agreed?

I personally don't have driver-writing experience for caching-IO
(RAID?)  controllers. But why wouldn't you make the cache mappable
over PCI?

I understand that you might want to structure a driver the other way
around, but still, having your memory window available over PCI makes
things easier to debug, so I can imagine the software developpers
pushing their hardware colleagues for this "feature".
 
> actually saves pictures that way in reality - they all need processing to
> show up. Even when the graphics card does things like mpeg2 decoding in
> hardware, the decoding logic is not set up the way the data comes off the
> disk in any case I know of. 

I wrote a driver for a zoran-chipset frame-grabber card. The "natural"
way to save a video stream was exactly the way it came out of the
card. And the card was structured that you could put on an "mpeg
decoder" (or encoder) chip, and you could DMA the stream directly into
that chip.

Now in this case, you'd still need the data somewhere in a cache
memory on your controller card to be able to circumvent the data
moving over the PCI bus twice. So if you're right (and you're always
right :-) about no controller cards having PCI accessable buffer
memory, then we're still stuck.

> >							 It needs of
> > course its own memory, but then you can see it as a NUMA architecture and
> > we already have the support for this. Create a new memory zone for the
> > device memory and keep the pages reserved. Now you can use it almost like
> > other memory, e.g. reading from/writing to it using address_space_ops.
> 
> You need to have a damn special sound card to do the above.

The way soundcards are commonly programmed, they don't play from their
own memory, but from main memory. However, they all can play from
their own memory. 

> And you wouldn't need a new memory zone - the kernel wouldn't ever touch
> the memory anyway, you'd just ioremap() it if you needed to access it
> programmatically in addition to the streaming of data off disk.

That's the way things currently work. If you start thinking about it
as a NUMA, it may improve the situation for "common users" too. 

A PC is a NUMA machine! We have disk (swap) and main memory. We also
have a frame buffer, which doesn't currently fit into our memory
architecture.

Now if we design the NUMA support correctly, just filling in "disk has
a seek-time of 10ms, and 20Mb per second throughput when accessed
linearly" NUMA may on it's own "tune" the swapper to do the right
thing. And once parametrized like this, we can also handle say a
leftover piece of framebuffer!

You dislike making things too general. I agree with that. However, you
also say that you like it when a simple abstraction suddenly makes a
bunch of previously differrent things all the same. It's all a
question of degree.

And I expect that when we do the math on say "disk" as a NUMA area, we
might find that the advice becomes to do IO in 16k chunks. Even though
the hardware tells us on a 4k page basis wether or not a page has been
accessed, we migh be better off aggregating this info to virtual pages
of 16k, and doing IO on chunks of that size.

Now, this swap thingy is just a hunch that I have, which may or may
not be true. But I expect it to be found automatic once we implement
NUMA support in just the right way.

Now, don't get me wrong: I'm not advocating that we immediately start
working towards that NUMA thingy. It's just something to keep in the
back of your head. Maybe the NUMA stuff qualifies as "too general for
too little benefit" in your eyes. I can go along with that. For now.

This argument started about sendfile. The question is: what's the
right API. I still think that "copy one FD to the other, as if a
read/write loop". Just because you don't have to write that read-write
loop, people will be interested in using the interface. And for some
cases, the kernel may be able to optimize it more than for
others. Currently the disk-> network is a special case where the
kernel knows that this can be optimized, while your interface forces
this knowledge also to userspace. I think that it's important that we
-=don't=- force this info out to userspace. That way, if one day we
find that a oneliner can make "copy_fd2fd" also work for disk->disk,
then that's an optimization that we can decide is "worthwhile". 

If it's a oneliner I hope you agree that it's worthwhile if it speeds
copying files up considerably. It's probably not going to be a
oneliner. So the decision is going to be harder. Tough luck.


				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
