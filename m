Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261674AbTCGQnl>; Fri, 7 Mar 2003 11:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261675AbTCGQnl>; Fri, 7 Mar 2003 11:43:41 -0500
Received: from dspnet.fr.eu.org ([62.73.5.179]:37124 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id <S261674AbTCGQnj>;
	Fri, 7 Mar 2003 11:43:39 -0500
Date: Fri, 7 Mar 2003 17:54:13 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <20030307165413.GA78966@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
References: <200303020011.QAA13450@adam.yggdrasil.com> <20030301202617.A18142@kerberos.ncsl.nist.gov> <20030306161853.GD2781@zaurus.ucw.cz> <20030307121215.GA68353@dspnet.fr.eu.org> <20030307123237.GG18420@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030307123237.GG18420@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 01:32:37PM +0100, Pavel Machek wrote:
> > Nope.  CVS uses RCS, and RCS only knows about trees, not graphs.
> > Specifically, branch merges are not tagged as such, and as a result
> > CVS is unable to pick up the best grandparent when doing a merge.
> > That's the main reason of why branching under CVS is so painful
> > (forgetting about the performance issues).
> 
> I see. But I still somehow can not understand how merging is
> possible. Merge possibly means work-by-hand, right? So it is not as
> simple as noting that 1.8 and 1.7.1.1 were merged into 1.9, no? [And
> what if developer did really crap job at merging that, like dropping
> all changes from 1.7.1.1?]

Calling A and B the versions to merge and R the reference, diff3 uses
this algorithm (probably the simplest possible):
- Compute the diff between A and R, call it dA
- Compute the diff between B and R, call it dB
- Merge the two diffs into one (and conflict where you can't)
- Apply the merged diff to R

Better algorithms do the alignments per-character instead of per-line,
detect moved and changed functions, detect duplicate inserts, etc.
None, of course, is perfect, as Larry could tell you.

Now if the development went that way:

1.7  -> 1.7.1.1 (branching, i.e. copy)
 v         v
 v      1.7.1.2
1.8        v
 v   -> 1.7.1.3 (merge)
1.9        v
 v         v
1.10       v
 v   -> 1.7.1.4 (merge)
 v         v
 v      1.7.1.5
 v         v
1.11 <-         (merge)

Pretty much standard, a developper created a new branch, made some
changes in it, synced with mainline, synced with mailine again a
little later, made some new changes and finally folded the branch back
in the mainline.  Let's admit the developper changes don't conflict by
themselves with the mainline changes.

CVS, for all the merges, is going to pick 1.7 as the reference.  The
first time, for 1.7.1.3, it's going to work correctly.  It will fuse
the 1.7->1.8 patch with the 1.7.1.1->1.7.1.2 patch and apply the
result to 1.7 to get 1.7.1.3.  The two patches have no reason to
overlap.  1.7.1.2->1.7.1.3 will essentially be identical to 1.7->1.8,
and 1.8->1.7.1.3 will essentially be identical to 1.7.1.2->1.7.1.3.

As soon as the next merge, i.e 1.7.1.4, it breaks.  CVS is going to
try to fuse the 1.7->1.10 patch with the 1.7->1.7.1.3 patch.  But
1.7->1.10 = 1.7->1.8+1.8->1.10 and 1.7->1.7.1.3 ~= 1.7->1.7.1.2+1.7->1.8.
So they have components in common, hance they _will_ conflict.

If CVS had taken the latest common ancestor by keeping in the
repository the existence of the 1.8->1.7.1.3 link, it would have taken
the 1.8 version as the reference.  The patches to fuse would have been
1.8->1.10 and 1.8->1.7.1.3, which have no reason to conflict.

Same for the next merge, the optimal merge point is in that case 1.10,
and it ends up being a null merge, i.e. 1.11 is a copy of 1.7.1.5.

You can see the final structure is a DAG, with each node having a max
of 2 ancestors.  And that's what PRCS and bk are working with,
fundamentally.

  OG.
