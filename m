Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317898AbSHKInG>; Sun, 11 Aug 2002 04:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317945AbSHKInG>; Sun, 11 Aug 2002 04:43:06 -0400
Received: from peace.netnation.com ([204.174.223.2]:48269 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP
	id <S317898AbSHKInF>; Sun, 11 Aug 2002 04:43:05 -0400
Date: Sun, 11 Aug 2002 01:46:52 -0700
From: Simon Kirby <sim@netnation.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
Message-ID: <20020811084652.GB22497@netnation.com>
References: <20020810201027.E306@kushida.apsleyroad.org> <Pine.LNX.4.44.0208101529490.2401-100000@home.transmeta.com> <20020811031705.GA13878@netnation.com> <3D55FF30.6164040D@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D55FF30.6164040D@zip.com.au>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2002 at 11:07:44PM -0700, Andrew Morton wrote:

> This is interesting.
> 
> The 2.5 readahead sort-of does the wrong thing for you.  Note how
> fs/mpage.c:mpage_end_io_read() walks the BIO's pages backwards when
> unlocking the pages.  And also note that the BIOs are 64kbytes, and
> the readahead window is up to 128k, etc.
> 
> See, a boring old commodity disk drive will read 10,000 pages per
> second.  The BIO code there is designed to *not* result in 10,000
> context-switches per second in the common case.  If the reader is
> capable of processing the data faster than the disk then hold
> them off and present them with large chunks of data.

Hmm.  I understand, but I now that I think about it a bit more, I think
I failed to notice the real problem:

The size of the readahead wouldn't matter if it actually prefetched the
data in advance.  It's not doing that right now.

What's happening with my MP3 streaming is:

1. read(4k) gets data after a delay.  xmms starts playing.
2. read(4k) gets some more data, right way, because readahead worked.
   xmms continues.
   ...
3. read(4k) blocks for a long time while readahead starts up again and
   reads a huge block of data.  read() then returns the 4k.  meanwhile,
   xmms has underrun.  xmms starts again.
4. goto 2.

It's really easy to see this behavior with the xmms-crossfade plugin and
a large buffer with "buffer debugging" display on.  With tcpdump in
another window, I can see that the readahead doesn't start prefetching
until it's right near the end of the data it fetched last, rather than
doing it in advance.  This is not obvious except in the case where
read() speed is limited by something like audio playback rates or heavy
processing times.

> But that's all disks.  You're not talking about disks.

Well, my example with grep was assuming a CPU the speed of what I have
right now, not something modern. :)  "bzip2 -9" would likely apply these
days.

> > This problem is showing up with NFS over a slow link, causing streaming
> > audio to be unusable.  On the other end of the speed scale, it probably
> > also affects "grep" and other applications reading from hard disks, etc.
> 
> Well, the question is "is the link saturated"?  If so then it's not
> solvable.  If is is not then that's a bug.

The link is not saturated, but it is used in huge bursts mixed with
periods of silence (where readahead is finished but has not yet started
the next block).

> OK, it's doing 128k of readahead there, which is a bit gross for a floppy.
> You can tune that down with `blockdev --setra N /dev/floppy'.  The

Ooh, is there something like this for NFS?

> but `mke2fs /dev/fd0' oopses in 2.5.30.  ho hum)

Yes, floppy in 2.5 has been broken for a while...

> So hmm.  Good point, thanks.  I'll go play some MP3's off floppies.

:)

Simon-

[        Simon Kirby        ][        Network Operations        ]
[     sim@netnation.com     ][     NetNation Communications     ]
[  Opinions expressed are not necessarily those of my employer. ]
