Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280186AbRKEDvB>; Sun, 4 Nov 2001 22:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280187AbRKEDuv>; Sun, 4 Nov 2001 22:50:51 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:41732 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S280186AbRKEDud>; Sun, 4 Nov 2001 22:50:33 -0500
Message-ID: <3BE60B51.968458D3@zip.com.au>
Date: Sun, 04 Nov 2001 19:45:21 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: lkml <linux-kernel@vger.kernel.org>, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] disk throughput
In-Reply-To: <3BE5F5BF.7A249BDF@zip.com.au>,
		<3BE5F5BF.7A249BDF@zip.com.au> <20011104193232.A16679@mikef-linux.matchmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> 
> On Sun, Nov 04, 2001 at 06:13:19PM -0800, Andrew Morton wrote:
> > I've been taking a look at one particular workload - the creation
> > and use of many smallish files.  ie: the things we do every day
> > with kernel trees.
> >
> > There are a number of things which cause linux to perform quite badly
> > with this workload.  I've fixed most of them and the speedups are quite
> > dramatic.  The changes include:
> >
> > - reorganise the sync_inode() paths so we don't do
> >   read-a-block,write-a-block,read-a-block, ...
> >
> 
> Why can't the elevator do that?  I'm all for better performance, but if
> the elevator can do it, then it will work for other file systems too.

If a process is feeding writes into the request layer and then
stops to do a read, we've blown it.  There's nothing for the
elevator to elevate.

> > - asynchronous preread of an ext2 inode's block when we
> >   create the inode, so:
> >
> >   a) the reads will cluster into larger requests and
> >   b) during inode writeout we don't keep stalling on
> >      reads, preventing write clustering.
> >
> 
> This may be what is inhibiting the elevator...

Yes.

> > The above changes are basically a search-and-destroy mission against
> > the things which are preventing effective writeout request merging.
> > Once they're in place we also need:
> >
> > - Alter the request queue size and elvtune settings
> >
> 
> What settings are you suggesting?  The 2.4 elevator queue size is an
> order of magnatide larger than 2.2...

The default number of requests is 128.    This is in fact quite ample AS
LONG AS the filesystem is feeding decent amounts of reasonably localised
stuff into the request layer, and isn't stopping for reads all the time.
ext2 and the VFS are not.  But I suspect that with the ialloc.c change,
disk readahead is covering up for it.

The meaning of the parameter to elvtune is a complete mystery, and the
code is uncommented crud (tautology).  So I just used -r20000 -w20000.

This was based on observing the request queue dynamics.  We frequently
fail to merge requests which really should be merged regardless of
latency.  Bumping the elvtune settings fixed it all.  But once the
fs starts writing data out contiguously it's all academic.

> >
> > The time to create 100,000 4k files (10 per directory) has fallen
> > from 3:09 (3min 9second) down to 0:30.  A six-fold speedup.
> >
> 
> Nice!

Well.  I got to choose the benchmark.

> >
> > All well and good, and still a WIP.  But by far the most dramatic
> > speedups come from disabling ext2's policy of placing new directories
> > in a different blockgroup from the parent:
> [snip]
> > A significant thing here is the improvement in read performance as well
> > as writes.  All of the other speedup changes only affect writes.
> >
> > We are paying an extremely heavy price for placing directories in
> > different block groups from their parent.  Why do we do this, and
> > is it worth the cost?
> >
> 
> My God!  I'm no kernel hacker, but I would think the first thing you would
> want to do is keep similar data (in this case similar because of proximity
> in the dir tree) as close as possible to reduce seeking...

Sure.  ext2 goes to great lengths to avoid intra-file fragmentation,
and then goes and adds its own inter-file fragmentation.

It's worse on larger partitons, because they have more of the 128 meg
block groups.

> Is there any chance that this will go into ext3 too?
> 

If it goes in ext2, yes.  Depends on what the ext2 gods say - there
may be some deep design issue I'm missing here.

-
