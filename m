Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130696AbQLaTP5>; Sun, 31 Dec 2000 14:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130352AbQLaTP2>; Sun, 31 Dec 2000 14:15:28 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:62727 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129370AbQLaTPC>; Sun, 31 Dec 2000 14:15:02 -0500
Date: Sun, 31 Dec 2000 10:44:09 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@innominate.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Generic deferred file writing
In-Reply-To: <3A4F7B45.C8313E8A@innominate.de>
Message-ID: <Pine.LNX.4.10.10012311035020.4239-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 31 Dec 2000, Daniel Phillips wrote:
> 
> It's not that hard or inefficient to return the ENOSPC from the usual
> point.  For example, make a gross overestimate of the space needed for
> the write, compare to a cached filesystem free space value less the
> amount deferred so far, and fail to take the optimization if it looks
> even close.

Let me repeat myself one more time:

 I do not believe that "get_block()" is as big of a problem as people make
 it out to be.

And more importantly:

 I strongly believe that trying to be clever is detrimental to your
 health. 

 The "clever" approach is to add tons of complexity, have various
 heuristics to try to not overflow, and then try to debug it considering
 that the ENOSPC case is actually rather rare.

 The "intelligent" approach is just to say that if get_block() shows up on
 the performance profiles, then it should be optimized.

I'd rather be intelligent than clever. Optimize get_block(), which in the
case of ext2 seems to be mostly ext2_new_block() and the balloc.c mess.

The argument that Andrea had is bogus: the common case for writes (and
writes is the only part that deferred writing would touch) is re-writing
the whole file, and the IO to look up the metadata is never an issue for
that case. Everything is basically cached and created on-the-fly. IO is
not the issue, being good about new block allocation _is_ the issue.

Don't get me wrong: I like the notion of deferred writes. But I'm also
very pragmatic: I have not heard of a really good argument that makes it
obvious that deferred writes is a major win performance-wise that would
make it worth the complexity.

One form of deferred writes I _do_ like is the mount-time-option form.
Because that one doesn't add complexity. Kind of like the "noatime" mount
option - it can be worth it under some circumstances, and sometimes it's
acceptable to not get 100% unix semantics - at which point deferred writes
have none of the disadvantages of trying to be clever.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
