Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317829AbSFMWod>; Thu, 13 Jun 2002 18:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317838AbSFMWoc>; Thu, 13 Jun 2002 18:44:32 -0400
Received: from waste.org ([209.173.204.2]:35719 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S317829AbSFMWoa>;
	Thu, 13 Jun 2002 18:44:30 -0400
Date: Thu, 13 Jun 2002 17:43:37 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Dawson Engler <engler@csl.Stanford.EDU>
cc: Alexander Viro <viro@math.psu.edu>, Andi Kleen <ak@muc.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] 37 stack variables >= 1K in 2.4.17
In-Reply-To: <200206132150.OAA14200@csl.Stanford.EDU>
Message-ID: <Pine.LNX.4.44.0206131735270.31423-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jun 2002, Dawson Engler wrote:

> > On 13 Jun 2002, Andi Kleen wrote:
> >
> > > Alexander Viro <viro@math.psu.edu> writes:
> > > >
> > > > I mean that due to the loop (link_path_walk->do_follow_link->foofs_follow_link
> > > > ->vfs_follow_link->link_path_walk) you will get infinite maximal depth
> > > > for everything that can be called by any of these functions.  And that's
> > > > a _lot_ of stuff.
> > >
> > > Surely an analysis pass can detect recursive function chains and flag them
> > > (e.g. the global IPA alias analysis pass in open64 does this)
> >
> > Ugh...  OK, let me try again:
> >
> > One bit of apriory information needed to get anything interesting from
> > this analysis:  there is a set of mutually recursive functions (see above)
> > and there is a limit (5) on the depth of recursion in that loop.
> >
> > It has to be known to checker.  Explicitly, since
> > 	a) automatically deducing it is not realistic
> > 	b) cutting off the stuff behind that loop will cut off a _lot_ of
> > things - both in filesystems and in VFS (and in block layer, while we are
> > at it).
>
> We're all about jamming system specific information into the checking
> extensions.  It's usually just a few if statements.  So to be clear: we
> can simply assume that the loop
>    link_path_walk
> 	->do_follow_link
> 		->foofs_follow_link
> 			->vfs_follow_link
> 				->link_path_walk
> can happen exactly 5 times?
>
> In general such restrictions are interesting, since they concretely
> show how having a way to include system-specific knowlege into checking
> is useful.  Are there any other such relationships?  The other example
> I know of is the do_page_fault (sp?) routine that can potentially be
> invoked at very copy_*_user site that page faults.  You need to know
> this to detect certain classes of deadlock, but there's no way to
> discern this path from the code without a priori knowlege.

There are various flags for memory allocation that prevent it (usually)
from being recursive (or livelocking).

Though I'm not really convinced by Al's argument. I think if you do a
breadth-first traversal of the possible call tree, as you get past a
certain predicted stack depth, you'll be able to manually prune things
that aren't of interest. Very few things should be potentially recursive
or mutally recursive and any that are probably bear closer manual
scrutiny.

How's Checker do on passing through function pointers?

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

