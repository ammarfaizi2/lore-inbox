Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbQLaRE3>; Sun, 31 Dec 2000 12:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129911AbQLaREU>; Sun, 31 Dec 2000 12:04:20 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:20485 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129401AbQLaRD7>; Sun, 31 Dec 2000 12:03:59 -0500
Date: Sun, 31 Dec 2000 08:33:01 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Roman Zippel <zippel@fh-brandenburg.de>,
        "Eric W. Biederman" <ebiederman@uswest.net>,
        Alexander Viro <viro@math.psu.edu>,
        Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Generic deferred file writing
In-Reply-To: <20001231153849.B17728@athlon.random>
Message-ID: <Pine.LNX.4.10.10012310812500.3084-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 31 Dec 2000, Andrea Arcangeli wrote:
> 
> get_block for large files can be improved using extents, but how can we
> implement a fast get_block without restructuring the on-disk format of the
> filesystem? (in turn using another filesystem instead of ext2?)

By doing a better job of caching stuff.

There are multiple levels of caching here. One issue is the question of
"allocate a new block". Go and look how the ext2 block pre-allocation
works, and cry. It should _not_ be a loop that sets one bit at a time, it
should be something that notices when the (u32 *) is zero and grabs the
whole 32 blocks in one go. Instead of defaulting to a pre-allocation of 8
blocks, doing that same expensive thing much too often.

The other thing is that one of the common cases for writing is consecutive
writing to the end of the file. Now, you figure it out: if get_block()
really is a bottle-neck, why not cache the last tree lookup? You'd get a
99% hitrate for that common case.

You should realize that all the block allocation etc code was written for
a very different VFS layer. "get_block()" didn't even exist. We didn't
have SMP issues. We had very different access patterns (the virtual caches
in the page cache makes the accesses to "get_block()" very different, as
the VFS layer keeps track of man mappings on its own.

And get_block() was basically tacked on top of the old code. Al Viro did a
good job of cleaning up some of the issues, but go and look at get_block()
and follow it all the way down into "ext2_new_block()" and back, and I bet
you'll ask yourself why it's so complex. And wonder if it couldn't just be
cleaned up and sped up a lot that way.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
