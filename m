Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263241AbREWUCm>; Wed, 23 May 2001 16:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263242AbREWUCd>; Wed, 23 May 2001 16:02:33 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:26892 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263241AbREWUCZ>; Wed, 23 May 2001 16:02:25 -0400
Date: Wed, 23 May 2001 13:01:56 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: DVD blockdevice buffers
In-Reply-To: <20010523205748.L8080@redhat.com>
Message-ID: <Pine.LNX.4.31.0105231258420.6642-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 May 2001, Stephen C. Tweedie wrote:
> > that the filesystems already do. And you can do it a lot _better_ than the
> > current buffer-cache-based approach. Done right, you can actually do all
> > IO in page-sized chunks, BUT fall down on sector-sized things for the
> > cases where you want to.
>
> Right, but you still lose the caching in that case.  The write works,
> but the "cache" becomes nothing more than a buffer.

No. It is still cached. You find the buffer with "page->buffer", and when
all of them are up-to-date (whether from read-in or from having written
to them all), you just mark the whole page up-to-date.

This _works_. Try it on ext2 or NFS today.

Now, it may be that the preliminary patches from Andrea do not work this
way. I didn't look at them too closely, and I assume that Andrea basically
made the block-size be the same as the page size. That's how I would have
done it (and then waited for people to find real life cases where we want
to allow sector writes).

So in short: the page cache supports _today_ all the optimizations. In
fact, you can, on NFS, do 4096 one-byte writes, and they will be (a)
coalesced into one write over the wire, and (b) will be cached in the page
and the page marked up-to-date.

		Linus

