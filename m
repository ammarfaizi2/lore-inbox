Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271886AbRIIEcw>; Sun, 9 Sep 2001 00:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271885AbRIIEcm>; Sun, 9 Sep 2001 00:32:42 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25360 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S271881AbRIIEcZ>; Sun, 9 Sep 2001 00:32:25 -0400
Date: Sat, 8 Sep 2001 21:28:43 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: linux-2.4.10-pre5
In-Reply-To: <20010909061620.O11329@athlon.random>
Message-ID: <Pine.LNX.4.33.0109082115270.1161-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 9 Sep 2001, Andrea Arcangeli wrote:

> On Sat, Sep 08, 2001 at 08:58:26PM -0700, Linus Torvalds wrote:
> > I'd rather fix that, then.
>
> we'd just need to define a new kind of communication API between a ro
> mounted fs and the blkdev layer to avoid the special cases.

No, notice how the simple code _should_ work for ro-mounted filesystems
as-is. AND it should work for read-only opens of disks with rw-mounted
filesystems. The only case it doesn't like is the "rw-open of a device
that is rw-mounted".

It's only filesystems that have modified buffers without marking them
dirty (by virtue of having pointers to buffers and delaying the dirtying
until later) that are broken by the "try to make sure all buffers are
up-to-date by reading them in" approach.

And as I don't think the concurrent "rw-open + rw-mount" case makes any
sense, I think the sane solution is simply to disallow it completely.

It shouldn't break any sane uses, and which is really the only way to
guarantee that you cannot have virtual and physical dirty pages/buffers to
the same device at the same time.

So if we simply disallow that case, then we do not have any problem:
either the device was opened read-only (in which case it obviously doesn't
need to flush anything to disk, or invalidate/revalidate existing disk
buffers), or the device was opened with write permissions, in which case
there mustn't be any non-ro mounts to the same device.

Notice? Sane, and doesn't really imply any need to introduce any new
communication between the filesystem and the block layer (only a very
thin channel between "mount" and the block layer). Wouldn't you say?

[ start future rambling ]

Now, I actually believe that we would eventually be better off by having a
real filesystem interface for doing kernel-assisted fsck, backup and
de-fragmentation (all just three different sides of the same thing:
filesystem administration), but that's a separate issue, and right now we
have absolutely no clue about what such an interface would look like. So
that's a long-term thing (other OS's have such interfaces, but they tend
to be specialized for only a subset of possible filesystems. Think
Windows defrag).

That kind of explicit filesystem maintenance interface would make all the
remaining issues go away completely, and would at least in theory allow
on-line fixing of already mounted filesystems. Assuming a good interface
and algorithm for it exists, of course.

[ end future rambling ]

		Linus

