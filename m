Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262741AbSJHCyA>; Mon, 7 Oct 2002 22:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262745AbSJHCyA>; Mon, 7 Oct 2002 22:54:00 -0400
Received: from packet.digeo.com ([12.110.80.53]:25283 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262741AbSJHCxz>;
	Mon, 7 Oct 2002 22:53:55 -0400
Message-ID: <3DA24A0E.D2AC3E1B@digeo.com>
Date: Mon, 07 Oct 2002 19:59:26 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.40 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Daniel Phillips <phillips@arcor.de>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Oliver Neukum <oliver@neukum.name>, Rob Landley <landley@trommello.org>,
       linux-kernel@vger.kernel.org
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 
 -  (NUMA))
References: <E17ydRY-0003uQ-00@starship> <Pine.LNX.4.33.0210071229080.10168-100000@penguin.transmeta.com> <20021008003903.GA473@think.thunk.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Oct 2002 02:59:26.0599 (UTC) FILETIME=[B6732170:01C26E76]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:
> 
> ...
> It depends on what you are doing.  BSD, and even XFS, uses the concept
> of using cylinder groups or block groups as one of many tools to avoid
> file fragmentation and to concetrate locality for files within a
> directory.  The reason why FAT filesystems have file fragmentation
> problems in far more worse way is because they attempt don't have the
> concept of a block group, and simply always allocate from the
> beginning of the filesystem.  This is effectively what would happen if
> you had a single block/cylinder group in the filesystem.
>

In the testing which I did, based on Keith Smith's traces, the
current code really isn't very effective.

What I did was to run his aging workload an increasing number of
times.  Then measured the fragmentation of the files which it
left behind.  I measured the fragmentation simply by timing
how long it took to read all the files, and compared that to
how long it took to read the same files when they had been laid
down on a fresh fs.

After ten aging rounds, with the current block allocator, we're
running 4x to 5x times slower.  With the Orlov allocator, we're
running 5x to 6x slower.  Either way, that's a big performance
slowdown.

Orlov turns a 400% slowdown into a 500% slowdown.  So it is a
25% regression for slow growth.  But it is a 300% to 500%
improvement for fast-growth.   (Well, it used to be.  But I
just fixed a memory-corrupting bug in it which I think has
slowed it down.  It's now only double the speed on scsi, triple
on IDE).

What we need, *regardless* of which allocator is used is effective
defrag tools.

I just retested.

2.5.41, scsi:
	time find linux-2.4.19 -type f | xargs cat > /dev/null
	find linux-2.4.19 -type f  0.06s user 0.24s system 1% cpu 19.274 total
	xargs cat > /dev/null  0.23s user 1.42s system 8% cpu 19.954 total

2.5.41, IDE:
	time find linux-2.4.19 -type f | xargs cat > /dev/null
	find linux-2.4.19 -type f  0.06s user 0.23s system 0% cpu 29.274 total
	xargs cat > /dev/null  0.23s user 1.58s system 5% cpu 30.199 total

2.5.41+Orlov, SCSI:
	time find linux-2.4.19 -type f | xargs cat > /dev/null
	find linux-2.4.19 -type f  0.06s user 0.24s system 2% cpu 11.579 total
	xargs cat > /dev/null  0.23s user 1.46s system 14% cpu 11.951 total

2.5.41+Orlov, IDE:
	time find linux-2.4.19 -type f | xargs cat > /dev/null
	find linux-2.4.19 -type f  0.06s user 0.24s system 2% cpu 12.225 total
	xargs cat > /dev/null  0.22s user 1.59s system 14% cpu 12.500 total

We need some of that goodness.

>
> [ administrator hints ]
>

Alas, nobody uses them :(

Maybe a mount option?  But I think the current algorithm should
default to "off".
