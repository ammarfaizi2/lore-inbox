Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135799AbRDZSwc>; Thu, 26 Apr 2001 14:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135886AbRDZSwX>; Thu, 26 Apr 2001 14:52:23 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:47119 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135799AbRDZSwH>; Thu, 26 Apr 2001 14:52:07 -0400
Date: Thu, 26 Apr 2001 11:49:14 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <20010426201236.W819@athlon.random>
Message-ID: <Pine.LNX.4.21.0104261141280.4480-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Apr 26, 2001 at 11:45:47AM -0400, Alexander Viro wrote:
>
>	Ext2 does getblk+wait_on_buffer for new metadata blocks before
> filling them with zeroes. While that is enough for single-processor,
> on SMP we have the following race:
> 
> getblk gives us unlocked, non-uptodate bh
> wait_on_buffer() does nothing
> 					read from device locks it and starts IO

I see the race, but I don't see how you can actually trigger it.

Exactly _who_ does the "read from device" part? Somebody doing a
"fsck" while the filesystem is mounted read-write and actively written
to? Yeah, you'd get disk corruption that way, but you'll get it regardless
of this bug.

There's nothing else that should be using that block at that stage. And if
there were, that would be a bug in itself, as far as I can tell. We've
just allocated it, and we're the only and exclusive owners of that block
on the disk. Anybody else who touches it is seriously broken.

Now, I don't disagree with your patch (it's just obviously cleaner to lock
it properly), but I don't think this is a real bug. I suspect that even
the wait-on-buffer is not strictly necessary: it's probably there to make
sure old write-backs have completed, but that doesn't really matter
either.

We used to have "breada()" do physical read-ahead that could have
triggered this, but we've long since gotten rid of that.

Or am I overlooking something?

			Linus

