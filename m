Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261324AbSJHQKf>; Tue, 8 Oct 2002 12:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261325AbSJHQKf>; Tue, 8 Oct 2002 12:10:35 -0400
Received: from thunk.org ([140.239.227.29]:2243 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S261324AbSJHQKe>;
	Tue, 8 Oct 2002 12:10:34 -0400
Date: Tue, 8 Oct 2002 12:15:55 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andrew Morton <akpm@digeo.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Daniel Phillips <phillips@arcor.de>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Oliver Neukum <oliver@neukum.name>, Rob Landley <landley@trommello.org>,
       linux-kernel@vger.kernel.org
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 -  (NUMA))
Message-ID: <20021008161555.GA2913@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Andrew Morton <akpm@digeo.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Daniel Phillips <phillips@arcor.de>,
	Chris Friesen <cfriesen@nortelnetworks.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Oliver Neukum <oliver@neukum.name>,
	Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
References: <E17ydRY-0003uQ-00@starship> <Pine.LNX.4.33.0210071229080.10168-100000@penguin.transmeta.com> <20021008003903.GA473@think.thunk.org> <3DA24A0E.D2AC3E1B@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DA24A0E.D2AC3E1B@digeo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 07:59:26PM -0700, Andrew Morton wrote:
> In the testing which I did, based on Keith Smith's traces, the
> current code really isn't very effective.
> 
> What I did was to run his aging workload an increasing number of
> times.  Then measured the fragmentation of the files which it
> left behind.  I measured the fragmentation simply by timing
> how long it took to read all the files, and compared that to
> how long it took to read the same files when they had been laid
> down on a fresh fs.

What access pattern did you use when you read the files?  Did you
sweep through filesystem directory by directory, or did you use some
other pattern (perhaps random)?

It would also be interesting to get a measure of fragmentation of the
filesystems as measured by e2fsck.  This only measures file
fragmentation, and not file locality on a per-directory (or more
ideally per-directory tree, but establishing where the directory trees
are is difficult).

> >
> > [ administrator hints ]
> >
> 
> Alas, nobody uses them :(

No one will use them if they are need to do so manually.  But if we
can convert a few programs to use them, then it might work.  And
people didn't much use madvise() when it was first introduced either,
but it doesn't mean that the existence of the interface was a bad
idea....

If the current algorithm is so bad, then maybe the trick is to use the
fast-growth optimized allocator as the default, *unless* given a hint
to do so via some magic mkdir flag.  Then if certain programs, such as
adduser (when creating a home directory), "cp -r", "bk clone", tar,
etc. where modified to give hints that the a particular directory was
at the top of a directory tree, then slow-growth optimized allocator
could be used to spread apart directory trees.  No, it's not perfect,
but it should be better not using any hints at all.  (And yes, it will
take a while before the userpsace tools that provide said hints are
widely deployed.)

And if we don't have any user-space hints, then we default to the
fast-growth algorithm, which should make Linus happy.  :-)

> Maybe a mount option?  But I think the current algorithm should
> default to "off".

How about a mount option with the possible values: "fast", "slow",
"hinted", and "auto", with the default being "auto" or "hinted"?
(Where hinted utilizes user-space hints, and "auto" utilizes
user-space hints if present, plus some of the so-called ugly
hueristics which you had discussed?)

						- Ted

