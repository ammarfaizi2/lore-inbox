Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264945AbTBEVtc>; Wed, 5 Feb 2003 16:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264950AbTBEVtc>; Wed, 5 Feb 2003 16:49:32 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14349 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264945AbTBEVta>; Wed, 5 Feb 2003 16:49:30 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
Date: Wed, 5 Feb 2003 21:56:13 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <b1s19t$3it$1@penguin.transmeta.com>
References: <20030205174021.GE19678@dualathlon.random> <200302051404.21524.shaggy@austin.ibm.com> <20030205201055.GL19678@dualathlon.random>
X-Trace: palladium.transmeta.com 1044482317 12281 127.0.0.1 (5 Feb 2003 21:58:37 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 5 Feb 2003 21:58:37 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030205201055.GL19678@dualathlon.random>,
Andrea Arcangeli  <andrea@suse.de> wrote:
>
>if you think it's normal the thing sounds very messy. I mean, how can
>a changeset be numbered 1.879.43.1 and not be included in 2.5.59?

You're thinking all wrong.

If you're trying to import BK into a traditional (CVS-like) setup, you
are bound to fail. In fact, it sounds like that is exactly what you're
trying to do, and it looks like you simply don't understand
distribution.

Don't feel bad, none of the CVS/Subversion people seem to get it either.

A revision number clearly _cannot_ be a ID in a distributed environment.
What happens when two people both create 1.1 and try to merge? Something
has to give, and the thing that has to give is the notion that revision
numbers "mean" anything.

Yes, revision numbers do show the tree structure of the SCM, but since
merging (by definition) changes the tree structure, then clearly by
definition the revision numbers have to change on a merge when that
happens. 

Revision numbers do not change if:
 - you only work in one tree (ie use BK as a plain CVS replacement)
 - you only ever merge changes to the top-of-tree (ie no branches)

but immediately when two people have worked on two trees in parallel
without synchronizing at each step (ie true distributed development),
revision numbers _have_ to be fixed up when a merge happens.

So your question is meaningless: "how can a changeset be numbered
1.879.43.1 and not be included in 2.5.59" is simply not a valid question
in a distributed environment.

My current BK tree obviously contains 2.5.59 as a proper subtree. That,
however, does NOT mean that the revision numbers would be a proper
subset.

Think of it this way in a simplified revision tree:

	rev 1.1 <- initial release (call it v2.5.0)
	rev 1.2 <- I made a change, and released it as v2.5.1

Ok. Before I had released v2.5.1, somebody else (say, shaggy), had taken
my 2.5.0 tree, and made his own changes to it. So now _he_ has a tree
that looks like

	rev 1.1 <- initial release (v2.5.0)
	rev 1.2 <- shaggy's private change, based on 2.5.0

So now we decide to merge. Two things can happen: shaggy can merge my
changes, and I can merge his. Let's say shaggy decides to merge my
changes into his tree: that will be his "1.3" point, but the my old 1.2
rev obviously will end up being just a branch to him, and will be a
branch based on our largest common denominator, ie 1.1.

So to shaggy, after the merge, we will have

	rev 1.1 <- initial release (v2.5.0)
	rev 1.2 <- shaggy's private change
	rev 1.1.1 <- my change, tagged as v2.5.1, is just a branch to shaggy	
	rev 1.3 <- merge point

Note how rev 1.2 in my original v2.5.1 tree is now called 1.1.1, and
what is now 1.2 doesn't even _exist_ in my tagged v2.5.1.

>The way I understood it is that when Linus merges "stuff", this "stuff"
>gets a changeset number in the future, not in the past. No matter if the
>"stuff" was created in the past. Is this the case or not?

No.  There _is_ no "future" or "past".  Read up on any distributed
system, and realize that relative time can only be determined by how
fast the interconnect is, and if you have disconnected systems (which is
the whole _point_ of doing distributed SCM), then no such thing can
exist. 

In other words, time does not exist between two distributed SCM trees.
The thing that "gels" the time is the act of merging, and only at that
point do we get a _partial_ ordering of changesets.

It's kind of like the cone of light in relativistic physics, except the
speed of light between two points is arbitrary and depends entirely on
when people decided to merge.  Like in relativistic physics, a totally
ordered "before" and "after" only exist within one frame of reference:
immediately when you look at multiple frames of reference, you get only a
partial ordering, and no equality of time.

			Linus
