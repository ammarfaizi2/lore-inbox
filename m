Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbVCDOhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbVCDOhJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 09:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVCDOhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 09:37:09 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:10139 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262601AbVCDOeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 09:34:01 -0500
Date: Fri, 4 Mar 2005 15:04:56 +0100
From: Pavel Machek <pavel@ucw.cz>
To: lm@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: [BK] cvs export
Message-ID: <20050304140455.GD3485@openzaurus.ucw.cz>
References: <20050302011419.GA30790@bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050302011419.GA30790@bitmover.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Tue 01-03-05 17:14:19, Larry McVoy wrote:
> A while back someone complained about the CVS exporter because it
> sometimes groups a pile of BK changesets into one commit.  That's true,
> it does.
> 
> I've been running tests over the BK tree and I think we can do better.
> Here's the scoop: when we do an export we are going from a very bushy
> graph structure to a linear graph structure.  The BK graph structure
> represents what happened in all the BK repos that ever came together,
> the CVS graph structure is more like what would happen if all the work had
> been done in CVS.  What that means in practice is that the linearization
> sometimes results in a single CVS commit which has multiple changesets
> in it.  Pavel or someone complained that the problem with that is that
> if you are looking for a bug and you are searching through commits, that
> works fine *unless* your bug happens to be in one of the commits which
> is really a pile of changesets.  Is that accurate Pavel/Andrea/Roman/etc?

Yes.

> In the last flamefest about BK there was all this fuss that there wasn't
> enough info in the CVS export and I think that the problem described
> above is the basis for 99% (or maybe 100%) of the flameage.  Is that
> also accurate?

No comment -- I'm not sure how to measure flamage.

> Which leads us back to the problem.  If you narrow things down but where
> you land is one of the clustered commits which has many changesets in it
> then you are stuck with having to wade through a big pile of diffs to
> find the bug, those diffs consisting of multiple patches.  Sound right
> to you Pavel/Andrea/Roman/etc?

Yup.

> When we do the export we do a couple of things to make things pleasant
> for you.  We make sure that the timestamps on all the files in the
> same commit are the same, that makes timestamp based tools work.
> We also shove a comment into each file's history that looks like so:
> (Logical change 1.12345) so that tools that try and group things based
> on comments can work.

Seems nice. Notice that I'm not sure when next bug that will require binary search
will pop up, so it may take a while before we'll actually know if it helped.

> It's that second feature that I think we can use to solve the problem,
> we're finally getting to the idea.  If we have a commit that is really 200
> patches which touch 400 files then we can do better.  Suppose that the
> files in the patches are disjoint, i.e., each patch touches a different
> set of files, there is no overlap.  If that's true then we could change
> the comment to (Logical change 1.12345._PATCH).  It's still all one CVS
> commit but if you need to go working through that commit to get at the
> individual patches you could, right?

> One problem is that the set of files in patches may not be disjoint,
> the same file may participate in multiple patches.  I think we can handle
> that in the following way, we put multiple comments, one for each patch,
> so you'd see
> 
> 	(Logical change 1.12345.5)
> 	(Logical change 1.12345.11)
> 	(Logical change 1.12345.79)
> 
> That's not a perfect answer because now that file participates in
> multiple patches and if it's the one that has the problem you'll have
> to wade through the diffs for that file for that commit.  But that's an
> extreme corner case as far as I can tell (I have faith I'll be "educated"
> if I'm wrong about that).

Its certainly better than current situation. Next nasty ACPI problem will tell ;-).

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

