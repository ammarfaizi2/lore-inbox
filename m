Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318014AbSG2A1P>; Sun, 28 Jul 2002 20:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318016AbSG2A1P>; Sun, 28 Jul 2002 20:27:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18449 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318014AbSG2A1N>;
	Sun, 28 Jul 2002 20:27:13 -0400
Message-ID: <3D448EAA.CE3382D8@zip.com.au>
Date: Sun, 28 Jul 2002 17:39:06 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 11/13] don't hold i_sem during O_DIRECT writes to blockdevs
References: <3D439E43.5F2DEE3D@zip.com.au> <Pine.LNX.4.44.0207281656110.9427-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sun, 28 Jul 2002, Andrew Morton wrote:
> >
> > We're moving in the direction of deprecating the raw driver and
> > recommending that applications use O_DIRECT reads and writes against
> > blockdevs.
> 
> This should probably be done unconditionally or not at all.
> 
> We've worked very hard on making block devices more "normal" in 2.5.x, and
> I don't want to start diverging again.
> 
> If this is really a scalability issue, I would suggest that people who
> care look into just getting rid of "i_sem", and replacing it with a
> read-write semaphore that explicitly protects only "i_size". Then you make
> reads and non-extending writes take that semaphore for reading, and
> extending writes and truncates taking it for writing.

I don't know if it is a scalability issue, frankly.  It will be for
buffered writes, but for writes which wait on IO, the mechanics of
the media probably make the benefits small.  Conceivably there are
some additional merging opportunities, but it's thin.

We can do the rwsem thing, and that would be good.  But there may
be filesystems which are relying on i_sem to provide protection
against concurrent invokations of get_block(create=1), inside i_size.

> [ The "nonextending writes" case is somewhat interesting, a write probably
>   needs to actually take the semaphore for writing, and then downgrading
>   it to reading after it has checked that it doesn't end up extending the
>   file.
> 
>   What makes this even more interesting is that depending on the semaphore
>   implementation you can actually split up the "take write lock" into
>   "prepare to take write lock" and "turn it into a read lock" or "confirm
>   write lock", where the "prepare to take write lock" allows existing
>   readers but not new write-lockers, so that if you downgrade to a read
>   lock you never had to synchronize with anybody else who was already
>   reading. ]
> 
> I'd much rather do this _right_ than have some ugly blockdev-only hack,
> since the problem certainly would happen with files too. A lot of people
> want to do databases on a filesystem, just because it is so much easier to
> administer.

OK. It'd be nice to get some benchmarks first (say, between O_DIRECT-to-blockdev
and the raw driver) to see if it's worth bothering with.

-
