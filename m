Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261938AbVCBBOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbVCBBOz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 20:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbVCBBOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 20:14:54 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:24532 "EHLO
	mail.bitmover.com") by vger.kernel.org with ESMTP id S261938AbVCBBOt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 20:14:49 -0500
Date: Tue, 1 Mar 2005 17:14:19 -0800
To: linux-kernel@vger.kernel.org
Subject: [BK] cvs export
Message-ID: <20050302011419.GA30790@bitmover.com>
Mail-Followup-To: lm@bitmover.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: lm@bitmover.com (Larry McVoy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A while back someone complained about the CVS exporter because it
sometimes groups a pile of BK changesets into one commit.  That's true,
it does.

I've been running tests over the BK tree and I think we can do better.
Here's the scoop: when we do an export we are going from a very bushy
graph structure to a linear graph structure.  The BK graph structure
represents what happened in all the BK repos that ever came together,
the CVS graph structure is more like what would happen if all the work had
been done in CVS.  What that means in practice is that the linearization
sometimes results in a single CVS commit which has multiple changesets
in it.  Pavel or someone complained that the problem with that is that
if you are looking for a bug and you are searching through commits, that
works fine *unless* your bug happens to be in one of the commits which
is really a pile of changesets.  Is that accurate Pavel/Andrea/Roman/etc?

In the last flamefest about BK there was all this fuss that there wasn't
enough info in the CVS export and I think that the problem described
above is the basis for 99% (or maybe 100%) of the flameage.  Is that
also accurate?

I tried to point out the following and think it was lost in the noise:
while the repository commits themselves construct a very bushy graph,
the files are not at all bushy, they are extremely linear.  So what does
that actually mean?  The history of the repository is very parallel,
that's what creates a bushy revision history graph, but in spite of that,
there is very little parallelism in the actual files.  The result of
that is that when we do the CVS export, it is true that the number of
commits is about half the number of BK commits.  But the number of file
deltas is only 4% less than the number of file deltas in BK.

Pavel/Andrea/Roman/etc still were unhappy and they are justified in being
unhappy because even though we have almost all of the file history what
we don't have is all of the patch boundaries.  And when you are hunting
down a bug, if you look at Documentation/BUG-HUNTING (which I wrote back
in 1996 amusingly enough) the idea is to do binary search over a range
of changes in order to narrow down the cause.

Which leads us back to the problem.  If you narrow things down but where
you land is one of the clustered commits which has many changesets in it
then you are stuck with having to wade through a big pile of diffs to
find the bug, those diffs consisting of multiple patches.  Sound right
to you Pavel/Andrea/Roman/etc?

If so, I have to agree with you, this is a limitation of the CVS exporter.
So I've been thinking about how to fix this and have the following idea.
I want all the CVS export users to pay close attention because this either
should make you happy or not and I want to know the answer.

When we do the export we do a couple of things to make things pleasant
for you.  We make sure that the timestamps on all the files in the
same commit are the same, that makes timestamp based tools work.
We also shove a comment into each file's history that looks like so:
(Logical change 1.12345) so that tools that try and group things based
on comments can work.

It's that second feature that I think we can use to solve the problem,
we're finally getting to the idea.  If we have a commit that is really 200
patches which touch 400 files then we can do better.  Suppose that the
files in the patches are disjoint, i.e., each patch touches a different
set of files, there is no overlap.  If that's true then we could change
the comment to (Logical change 1.12345.$PATCH).  It's still all one CVS
commit but if you need to go working through that commit to get at the
individual patches you could, right?

One problem is that the set of files in patches may not be disjoint,
the same file may participate in multiple patches.  I think we can handle
that in the following way, we put multiple comments, one for each patch,
so you'd see

	(Logical change 1.12345.5)
	(Logical change 1.12345.11)
	(Logical change 1.12345.79)

That's not a perfect answer because now that file participates in
multiple patches and if it's the one that has the problem you'll have
to wade through the diffs for that file for that commit.  But that's an
extreme corner case as far as I can tell (I have faith I'll be "educated"
if I'm wrong about that).

So, everyone including the Pavel/Andrea/Roman/etc camp, how do you feel
about this?  If we were to hack the exporter to add this info do you think
that would address the problems you have with the exporter?  The reason
I ask is that while I was going to just hack this in, I went to do that
and it turned into a nasty problem, both engineering and CPU wise when
exporting.  So if this isn't what you wanted then I won't bother to do it.

I'm not asking if this is the same as GPLing BK or giving people free 
access to 100% of the BK internal data structures, etc.  What I'm asking
is if this will make the CVS export tree something you can use to get your
job done in an efficient way.  

(Apologies if there are typos, it's been a long week)
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
