Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130287AbRAAD3e>; Sun, 31 Dec 2000 22:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130877AbRAAD3X>; Sun, 31 Dec 2000 22:29:23 -0500
Received: from baldur.fh-brandenburg.de ([195.37.0.5]:16341 "HELO
	baldur.fh-brandenburg.de") by vger.kernel.org with SMTP
	id <S130287AbRAAD3Q>; Sun, 31 Dec 2000 22:29:16 -0500
Date: Mon, 1 Jan 2001 03:50:45 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Generic deferred file writing
In-Reply-To: <Pine.LNX.4.10.10012311726230.1671-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.10.10101010332330.1050-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 31 Dec 2000, Linus Torvalds wrote:

> 		cached_allocation = NULL;
> 
> 	repeat:
> 		spin_lock();
> 		result = try_to_find_existing();
> 		if (!result) {
> 			if (!cached_allocation) {
> 				spin_unlock();
> 				cached_allocation = allocate_block();
> 				goto repeat;
> 			}
> 			result = cached_allocation;
> 			add_to_datastructures(result);
> 		}
> 		spin_unlock();
> 		return result;
> 
> This is quite standard, and Linux does it in many places. It doesn't have
> to be complex or ugly.

No problem with that.

> Also, I don't see why you claim the current get_block() is recursive and
> hard to use: it obviously isn't. If you look at the current ext2
> get_block(), the way it protects most of its data structures is by the
> super-block-global lock. That wouldn't work if your claims of recursive
> invocation were true. 

I just rechecked that, but I don't see no superblock lock here, it uses
the kernel_lock instead. Although Al could give the definitive answer for
this, he wrote it. :)

> The way the Linux MM works, if the lower levels need to do buffer
> allocations, they will use GFP_BUFFER (which "bread()" does internally),
> which will mean that the VM layer will _not_ call down recursively to
> write stuff out while it's already trying to write something else. This is
> exactly so that filesystems don't have to release and re-try if they don't
> want to.
> 
> In short, I don't see any of your arguments.

Then I must have misunderstood Al. Al?
If you were right here, I would see absolutely no reason for the current
complexity. (Me is a bit confused here.)

bye, Roman

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
