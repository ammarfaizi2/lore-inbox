Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135888AbRDZTKD>; Thu, 26 Apr 2001 15:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135887AbRDZTJp>; Thu, 26 Apr 2001 15:09:45 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:64255 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135888AbRDZTJj>;
	Thu, 26 Apr 2001 15:09:39 -0400
Date: Thu, 26 Apr 2001 15:08:16 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <Pine.LNX.4.21.0104261141280.4480-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0104261455530.15385-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Apr 2001, Linus Torvalds wrote:
 
> I see the race, but I don't see how you can actually trigger it.
> 
> Exactly _who_ does the "read from device" part? Somebody doing a
> "fsck" while the filesystem is mounted read-write and actively written
> to? Yeah, you'd get disk corruption that way, but you'll get it regardless
> of this bug.
 
> There's nothing else that should be using that block at that stage. And if
> there were, that would be a bug in itself, as far as I can tell. We've
> just allocated it, and we're the only and exclusive owners of that block
> on the disk. Anybody else who touches it is seriously broken.
 
> Now, I don't disagree with your patch (it's just obviously cleaner to lock
> it properly), but I don't think this is a real bug. I suspect that even
> the wait-on-buffer is not strictly necessary: it's probably there to make
> sure old write-backs have completed, but that doesn't really matter
> either.
> 
> We used to have "breada()" do physical read-ahead that could have
> triggered this, but we've long since gotten rid of that.
> 
> Or am I overlooking something?

Somebody doing dd(1) _from_ that disk. Sure, he's bound to get crap.
But I really don't think that opening device for read should be able
to affect its contents in any way.

BTW, same race exists between block_read() and block_write(). And that
one is even more obviously wrong:

xterm A:					xterm B:

dd if=/dev/hda of=/dev/hdb			dd if=/dev/hdb of=/dev/null

result: some blocks on hdb retaining their old contents.

IMO "no matter what you read, you don't affect the contents" is a good
general principle. Sure, you can get crap if you read in the middle of
write. That's expected and sane. However, the final contents of file
depends only on the things done by writers.

								Al

