Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273118AbRIJAmW>; Sun, 9 Sep 2001 20:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273120AbRIJAmC>; Sun, 9 Sep 2001 20:42:02 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:42510 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S273117AbRIJAl7>; Sun, 9 Sep 2001 20:41:59 -0400
Date: Sun, 9 Sep 2001 17:38:14 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Andreas Dilger <adilger@turbolabs.com>, Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.10-pre5
In-Reply-To: <20010910001556Z16150-26183+680@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33.0109091724120.22033-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 10 Sep 2001, Daniel Phillips wrote:
>
> Well, I'm happy enough to get this far down the list before getting the first
> Bzzt.  But why do you think we need different blocks sizes in the same
> mapping?  Maybe NTFS is bizarre enough to need that, but then why not just
> have special mappings for the "misc" sizes?

Oh, any extent-based filesystem is going to be _much_ happier just trying
to create the buffer head patterns the way the extents say, rather than
always have to break it down to the smallest common denominator.

The simplest case of this is a tail, where there is nothign wrong with
having a 5kB file, where the first page is a single 4kB buffer, and the
second page is one mapped 1kB buffer and three unmapped buffers. Which
means that you end up reading the file in just two buffers. And they are
of different sizes.

And that's the _simple_ case.

There are other cases - there are filesystems with unaligned buffers,
which can mean that the pattern for a "struct page" actually ends up being

	|      page 1          |           page 2      |

	1kB |    2kB     | 1kB  1kB |    2kb    |  1kB


So each page actually ends up being _three_ buffers, of different sizes.

Sure, you _could_ force them all to be the smallest common size, but that
only means that the elevator (and the controller) have more work to do.
Why would you do that?

Finally, a true extent-based filesystem might mean that the first 4 pages
were all allocated a single 16kB physical block, and we obviously want to
do those pages as full pages. The next 10kB of the file might have been
allocated scattered 1kB blocks - maybe the disk is really fragmented, and
we just had to do it that way. Should the fact that we have some 1kB
extents mean that we do _all_ IO in 1kB chunks? I don't think so.

> > > Should die:
> > >         kdev_t b_rdev;                  /* Real device */
> > >         unsigned long b_rsector;        /* Real buffer location on disk */
> >
> > No - these are what all the indirect IO code uses.
>
> They're still warts.  It would be nice if the various block remappers could
> provide their own pool of remapping structs.

Fair enough - although at least one block remapper we want to see is the
"partition remapper", which right now is a special case at a the device
driver level, but if you think about it it's really nothing more than a
really simple form of remapping.

And a lot of people _would_ prefer to think about it that way - it would
make the partitioning something that the device driver wouldn't see or
know about. Which is a good thing. But it would also mean that just about
all IO gets _some_ remapping.

And requiring us to have another pool of buffers for every single bh in
flight would be painful, I think you'll agree. So while I agree with you
in theory, I also think that the current setup actually has advantages.

> > Which is probably fine - we could replace the existing getblk with it, and
> > do only minor fixups. Maybe.
>
> Yep, maybe.  Christoph was looking at trying this idea with vxfs, I should
> ping him on that.

I'd love to hear if somebody can do something like this. It still sounds
very much like a 2.5.x thing (and hopefully I and Alan can merge enough
that it's going to be RSN), but if done right it should be trivial to
back-port to 2.4.x after testing.

It would definitely make all the issues with Andrea's pagecache code just
go away completely.

		Linus

