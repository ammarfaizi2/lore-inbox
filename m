Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262622AbSJGTb7>; Mon, 7 Oct 2002 15:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262613AbSJGTb6>; Mon, 7 Oct 2002 15:31:58 -0400
Received: from packet.digeo.com ([12.110.80.53]:12725 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262622AbSJGTbP>;
	Mon, 7 Oct 2002 15:31:15 -0400
Message-ID: <3DA1E250.1C5F7220@digeo.com>
Date: Mon, 07 Oct 2002 12:36:48 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
CC: Daniel Phillips <phillips@arcor.de>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Oliver Neukum <oliver@neukum.name>, Rob Landley <landley@trommello.org>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 
 -  (NUMA))
References: <m17yCIx-006hSwC@Mail.ZEDAT.FU-Berlin.DE> <1281002684.1033892373@[10.10.2.3]> <E17ybuZ-0003tz-00@starship> <3DA1D30E.B3255E7D@digeo.com> <3DA1D969.8050005@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Oct 2002 19:36:48.0210 (UTC) FILETIME=[E06A9320:01C26E38]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> 
> Andrew Morton wrote:
> 
> > Go into ext2_new_inode, replace the call to find_group_dir with
> > find_group_other.  Then untar a kernel tree, unmount the fs,
> > remount it and see how long it takes to do a
> >
> >       `find . -type f  xargs cat > /dev/null'
> >
> > on that tree.  If your disk is like my disk, you will achieve
> > full disk bandwidth.
> 
> Pardon my ignorance, but what's the difference between find_group_dir
> and find_group_other, and why aren't we using find_group_other already
> if its so much faster?
> 

ext2 and ext3 filesystems are carved up into "block groups", aka
"cylinder groups".  Each one is 4096*8 blocks - typically 128 MB.
So you can easily have hundreds of blockgroups on a single partition.

The inode allocator is designed to arrange that files which are within the
same directory fall in the same blockgroup, for locality of reference.

But new directories are placed "far away", in block groups which have
plenty of free space.  (find_group_dir -> find a blockgroup for a
directory).

The thinking here is that files in a separate directory are related,
and files in different directories are unrelated.  So we can take 
advantage of that heuristic - go and use a new blockgroup each time
a new directory is created.  This is a levelling algorithm which
tries to keep all blockgroups at a similar occupancy level.
That's a good thing, because high occupancy levels lead to fragmentation.

find_group_other() is basically first-fit-from-start-of-disk, and
if we use that for directories as well as files, your untar-onto-a-clean-disk
simply lays everything out in a contiguous chunk.

Part of the problem here is that it has got worse over time.  The
size of a blockgroup is hardwired to blocksize*bits-in-a-byte*blocksize.
But disks keep on getting bigger.  Five years ago (when, presumably, this
algorithm was designed), a typical partition had, what?  Maybe four
blockgroups?  Now it has hundreds, and so the "levelling" is levelling
across hundreds of blockgroups and not just a handful.

I did a lot of work on this back in November 2001, mainly testing
with a trace-based workload from Keith Smith.  See
http://www.eecs.harvard.edu/~keith/usenix.1995.html

Al Viro wrote a modified allocator (which nobody understood ;))
based on Orlov's algorithm.

I ended up concluding that the current (sucky) code is indeed
best for minimising long-term fragmentation under slow-growth
scenarios.  And worst for fast-growth.

Orlov was in between on both.

Simply nuking find_group_dir() was best for fast-growth, worst
for slow-growth.

Block allocators are fertile grounds for academic papers.  It's
complex.  There is a risk that you can do something which is
cool in testing, but ends up exploding horridly after a year's
use.  By which time we have ten million deployed systems running like
dogs, damn all we can do about it.

The best solution is to use first-fit and online defrag to fix the
long-term fragmentation.  It really is.  There has been no appreciable
progress on this.

A *practical* solution is to keep a spare partition empty and do
a `cp -a' from one partition onto another once per week and
swizzle the mountpoints.  Because the big copy will unfragment
everything.

ho-hum.  I shall forward-port Orlov, and again attempt to understand
it ;)
