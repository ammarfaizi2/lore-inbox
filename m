Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbVBSRTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbVBSRTq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 12:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbVBSRTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 12:19:46 -0500
Received: from user-10mt71s.cable.mindspring.com ([65.110.156.60]:12912 "EHLO
	localhost") by vger.kernel.org with ESMTP id S261492AbVBSRTm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 12:19:42 -0500
Date: Sat, 19 Feb 2005 12:15:02 -0500
From: David Roundy <droundy@abridgegame.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, darcs-users@darcs.net
Subject: Re: [darcs-users] Re: [BK] upgrade will be needed
Message-ID: <20050219171457.GA20285@abridgegame.org>
Mail-Followup-To: Andrea Arcangeli <andrea@suse.de>,
	linux-kernel@vger.kernel.org, darcs-users@darcs.net
References: <20050214020802.GA3047@bitmover.com> <845b6e8705021803533ba8cc34@mail.gmail.com> <20050218125057.GE2071@opteron.random> <200502190410.31960.pmcfarland@downeast.net> <20050219164213.GB7247@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050219164213.GB7247@opteron.random>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 19, 2005 at 05:42:13PM +0100, Andrea Arcangeli wrote:
> But anyway the only thing I care about is that you import all dozen
> thousands changesets of the 2.5 kernel into it, and you show it's
> manageable with <1G of ram and that the backup size is not very far from
> the 75M of CVS.

The linux-2.5 tree right now (I'm re-doing the conversion, and am up to
October of last year, so far) is at 141M, if you don't count the pristine
cache or working directory.  That's already compressed, so you don't get
any extra bonuses.  Darcs stores with each changeset both the old and new
versions of each hunk, which gives you some redundancy, and probably
accounts for the factor of two greater size than CVS.  This gives a bit of
redundancy, which can be helpful in cases of repository corruption.

> I read in the webpage of the darcs kernel repository that they had to
> add RAM serveral times to avoid running out of memory. They needed more
> than 1G IIRC, and that was enough for me to lose interest into it.
> You're right I blamed the functional approach and so I felt it was going
> to be a mess to fix the ram utilization, but as someone else pointed
> out, perhaps it's darcs to blame and not haskell. I don't know.

Darcs' RAM use has indeed already improved somewhat... I'm not exactly sure
how much.  I'm not quite sure how to measure peak virtual memory usage, and
most of the time darcs' memory use while doing the linux kernel conversion
is under a couple of hundred megabytes.

There are indeed trickinesses involved in making sure garbage gets
collected in a timely manner when coding in a lazy language like haskell.

> On Sat, Feb 19, 2005 at 04:10:18AM -0500, Patrick McFarland wrote:
> > Thats all up to how the versioning system is written. Darcs developers
> > are working in a checkpoint system to allow you to just grab the newest
> > stuff,

Correction:  we already have a checkpoint system.  The work in progress is
making commands that examine the history fail gracefully when that history
isn't present.

> This is already available with arch. In fact I suggested myself how to
> improve it with hardlinks so that a checkout will take a few seconds no
> matter the size of the tree.

I presume you're referring to a local checkout? That is already done using
hard links by darcs--only of course the working directory has to actually
be copied over, since there are editors out there that aren't friendly to
hard-linked files.

> > and automatically grab anything else you need, instead of just grabbing
> > everything. In the case of the darcs linux repo, no one wants to
> > download 600 megs or so of changes.
> 
> If you use arch/darcs as a patch-download tool, then that's fine
...
> The major reason a versioning system is useful to me is to track all
> changesets that touched a single file since the start of 2.5 to the
> head. So I can't get away by downloading the last dozen patches and
> caching the previous tree (which is perfectly doable with arch for ages
> and with hardlinks as well).

And here's where darcs really falls down.  To track the history of a single
file it has to read the contents of every changeset since the creation of
that file, which will take forever (well, not quite... but close).

I hope to someday (when more pressing issues are dealt with) add a per-file
cache indicating which patches affect which files, which should largely
address this problem, although it won't help at all with files that are
touched by most of the changesets, and won't be optimimal in any case. :(
-- 
David Roundy
http://www.darcs.net
