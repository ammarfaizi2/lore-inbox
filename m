Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317975AbSHHUUJ>; Thu, 8 Aug 2002 16:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317981AbSHHUUJ>; Thu, 8 Aug 2002 16:20:09 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40197 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317975AbSHHUUI>; Thu, 8 Aug 2002 16:20:08 -0400
Date: Thu, 8 Aug 2002 13:24:35 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Paul Larson <plars@austin.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       <davej@suse.de>, <frankeh@us.ibm.com>, <andrea@suse.de>
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
In-Reply-To: <3D51A7DD.A4F7C5E4@zip.com.au>
Message-ID: <Pine.LNX.4.44.0208081312330.8705-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 7 Aug 2002, Andrew Morton wrote:
>
> Has this been evaluated against Bill Irwin's constant-time
> allocator?  Bill says it has slightly worse normal-case and
> vastly improved worst-case performance over the stock allocator.
> Not sure how it stacks up against this one.   Plus it's much nicer
> looking code.

Guys, this discussion is getting ridiculous.

Doing a bit allocator should be trivial, but it's hard to know when a bit
is to be free'd. You can't just do it at "exit()" time, because even if
pid X exits, that doesn't mean that X can be re-used: it may still be used
as a pgid or a tid by some other process Y.

So if you really want to take this approach, you need to count the uses of
"pid X", and free the bitmap entry only when that count goes to zero. I
see no such logic in Bill Irwin's code, only a comment about last use
(which doesn't explain how to notice that last use).

Without that per-pid-count thing clarified, I don't think the (otherwise
fairly straightforward) approach of Bills really flies.

For that reason I think the mark-and-sweep thing is the right thing to do,
but I think the two-level algorithm is just over-engineering and not worth
it. And I do hate that getpid_mutex thing. Having a blocking lock for
something as simple as pid allocation just smells horribly wrong to me.

Moving the pid allocation to later (so that it doesn't need to handle
operations that block in between allocation and "we're done" and the pid
allocation can be a spinlock) sounds like a fairly obvious thing to do. 

I don't see why we would need the "pid" until the very last moment, at 
which point we already have the tasklist lock, in fact.

And I hate overengineering.

		Linus

