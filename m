Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271845AbRIIB6N>; Sat, 8 Sep 2001 21:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271846AbRIIB6E>; Sat, 8 Sep 2001 21:58:04 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32270 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S271845AbRIIB5p>; Sat, 8 Sep 2001 21:57:45 -0400
Date: Sat, 8 Sep 2001 18:53:39 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: linux-2.4.10-pre5
In-Reply-To: <20010909033848.J11329@athlon.random>
Message-ID: <Pine.LNX.4.33.0109081845410.1447-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 9 Sep 2001, Andrea Arcangeli wrote:
> >
> > So imagine that there is another user keeping the bdev active. Implying
> > that you never even try to sync it at all. That sounds like a bad thing to
> > do.
>
> If you would be right it would also be a bug when two users keep open
> the same file at the same time on any filesystem. Tell me where we do
> the fsync of the file when the first user closes it.

Look again - for regular files we _never_ fsync it. Not on the first
close, not on the last one.

And I'm telling you that device files are different. Things like fdisk and
fsck expect the data to be on the disk after they've closed the device.

They do not expect the data to be on disk only if they were the only
opener, or other special cases.

End of story.

> The whole point is that the two users obviously are sharing the same
> cache so there's no issue there.

There may not be any issue for _them_, but there may easily be an issue
between the user that does the first close, and the next
non-page-cache-user.

This is not about coherency between those two users. That coherency is
something we can take for granted if they both use the page cache, and as
such you shouldn't even bring that issue up - it's not interesting.

What _is_ interesting is the assumption of the disk state of _one_ of the
users, and its expectations about the disk contents etc being up-to-date
after a close(). Up-to-date enough that some other user that does NOT use
the page cache (ie a mount) should see the correct data.

And it sounds very much like your current approach completely misses this.

> The only case we need to care specially is the coherency between
> filesystems and blkdev users and that's what I do with the algorithm
> explained earlier.

Yeah, you explained that you had multiple different approaches depending
on whether it was mounted read-only or not etc etc. Which sounds really
silly to me.

I'm telling you that ONE approach should be the right one. And I'm further
telling you that that one approach is obviously a superset of your "many
different modes of behaviour depending on what is going on".

Which sounds a lot cleaner, and a lot simpler than your special case
heaven.

> We don't flush at every close even in current 2.4 buffercache backed.

Because we don't need to. There are no coherency issues wrt metadata
(which is the only thing that fsck changes).

If fsck changed data contents, we'd better flush dirty buffers, believe
me.

> > 	fsync(inode);
> > 	invalidate_inode_pages(inode);
> > 	invalidate_device(inode->b_dev);
>
> That's not enough.

Tell me why. Yes, you need the extension that I pointed out:

> > Yes. So you could make invalidate_device() stronger, trying to re-read
> > buffers that aren't dirty. But that doesn't mean that you should act
> > differently on FS mounted vs not-mounted vs some-other-user.

		Linus

