Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317440AbSG2AAA>; Sun, 28 Jul 2002 20:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317443AbSG2AAA>; Sun, 28 Jul 2002 20:00:00 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:51463 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317440AbSG1X77>; Sun, 28 Jul 2002 19:59:59 -0400
Date: Sun, 28 Jul 2002 17:04:53 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 11/13] don't hold i_sem during O_DIRECT writes to blockdevs
In-Reply-To: <3D439E43.5F2DEE3D@zip.com.au>
Message-ID: <Pine.LNX.4.44.0207281656110.9427-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 28 Jul 2002, Andrew Morton wrote:
>
> We're moving in the direction of deprecating the raw driver and
> recommending that applications use O_DIRECT reads and writes against
> blockdevs.

This should probably be done unconditionally or not at all.

We've worked very hard on making block devices more "normal" in 2.5.x, and
I don't want to start diverging again.

If this is really a scalability issue, I would suggest that people who
care look into just getting rid of "i_sem", and replacing it with a
read-write semaphore that explicitly protects only "i_size". Then you make
reads and non-extending writes take that semaphore for reading, and
extending writes and truncates taking it for writing.

[ The "nonextending writes" case is somewhat interesting, a write probably
  needs to actually take the semaphore for writing, and then downgrading
  it to reading after it has checked that it doesn't end up extending the
  file.

  What makes this even more interesting is that depending on the semaphore
  implementation you can actually split up the "take write lock" into
  "prepare to take write lock" and "turn it into a read lock" or "confirm
  write lock", where the "prepare to take write lock" allows existing
  readers but not new write-lockers, so that if you downgrade to a read
  lock you never had to synchronize with anybody else who was already
  reading. ]

I'd much rather do this _right_ than have some ugly blockdev-only hack,
since the problem certainly would happen with files too. A lot of people
want to do databases on a filesystem, just because it is so much easier to
administer.

		Linus

