Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261541AbTCGMB5>; Fri, 7 Mar 2003 07:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261545AbTCGMB5>; Fri, 7 Mar 2003 07:01:57 -0500
Received: from dspnet.fr.eu.org ([62.73.5.179]:48399 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id <S261541AbTCGMBs>;
	Fri, 7 Mar 2003 07:01:48 -0500
Date: Fri, 7 Mar 2003 13:12:15 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <20030307121215.GA68353@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
References: <200303020011.QAA13450@adam.yggdrasil.com> <20030301202617.A18142@kerberos.ncsl.nist.gov> <20030306161853.GD2781@zaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030306161853.GD2781@zaurus.ucw.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 06, 2003 at 05:18:53PM +0100, Pavel Machek wrote:
> Can you elaborate? I thought that this
> "real DAG" structure is more or less
> equivalent to each developer having
> his owm CVS repository...

Nope.  CVS uses RCS, and RCS only knows about trees, not graphs.
Specifically, branch merges are not tagged as such, and as a result
CVS is unable to pick up the best grandparent when doing a merge.
That's the main reason of why branching under CVS is so painful
(forgetting about the performance issues).


> If I fixed CVS renames, added atomic
> commits, splits and merges, and gave each
> developer his own CVS repository,
> would I be in same league as bk?
> Ie 10 times slower but equivalent
> functionality?

Nope.  You'll find out that this per-developper repository quickly
needs to become a per-branch repository, and even need you need to
write somewhere when the merges with other repositories happen, and
you end up with the DAG again.

Another way to see it is that CVS and friends use an
update-then-commit scheme, which is proven crap because you lose the
working version you had when you do the update to get a result that is
sometimes interesting.  Nice systems, like PRCS and bk, first commit
to a new branch (no update necessary obviously) then merge in the
mainline.  As a side effect, they are Good with branches.  Bk's main
quality over PRCS is the distribution.  This lack is what makes PRCS
essentially unusable for serious open source projects.  Otherwise
they're semantically the same.


> (3 point merge should be doable for CVS
> to and would be good thing anyway,
> right?)

Technically, CVS does 3-point merge, it's just crap at finding the
third point, and diff3 -m (which is what is used under the hood) isn't
that spectacular either.

You can see the merge operation in a different way.  You take 3
versions of your complete repository A, B and R (reference).  You
compute the deltas dA and dB so that A=dA(R) and B=dB(R).  Then you
try to build M=dA(dB(R))=dB(dA(R)), when it makes sense (not only the
deltas aren't necessarily commutative, they can't even always apply
one after the other).  When it doesn't work there are conflicts to be
resolved by the user.  You can see that when it workds M=dA(B)=dB(A).

You can do a lot of things with that, merging branches is just one of
them.  You can back out patches from within the history for instance
(D->E->F, merge D and F using E as reference removes the D->E patch
from F).

The trick is, the "simplest" your deltas are the lowest the conflict
probability is.  That's where the DAG kicks in.  For a branch merge,
the lowest conflict probability of conflict tends to occur when the
two deltas are a linear combination of small user-made deltas, with no
delta common between the two chains.  I.e. the best reference to use
is the latest merge point.  The DAG allows you to find it.  CVS
doesn't note the merge points so it always goes all the way where the
branch is rooted, ensuring that the two delta chains have a large
common prefix.

Sub-optimal reference point plus diff3's algorithm being what it is
makes the CVS branches plain unusable.  Multiple repositories won't
fix that, since you'll need to merge between repositories anyway.

  OG.
